Return-Path: <netdev+bounces-259764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CECXETrGmGnyLwMAu9opvQ
	(envelope-from <netdev+bounces-259764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:38:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2116AB1C
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52118301BF62
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 20:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6EE307AF4;
	Fri, 20 Feb 2026 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVeBlxwu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398D12FD1DA
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771619895; cv=none; b=MVDN+w+w6HAb8s9o9XEyWRnzlHz+DV1GvgWP8pn36dsNe9MltxvAoRU6nA3Z1wCNwg3L7COfLFiqE5rgMSEzrbkSpMXGIWrQ3P+Ml6s76M3HEL3De86XyaR2WpZn06kq6kTwDnGXpryzk5QnmtGAbG8gLbiQNdKOUX7cS8m+Qro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771619895; c=relaxed/simple;
	bh=YkeUmJE5VCgB+/8w/kNuLw08/jxthUEWqf0pcnkt7Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtAYt51BFJHQgcHBn3gK6IphlY/T/j568Sy8+wi3odERV0gcMoDbpNuLG9QSRc5tUfHPL+U8FuxJVJRmcwqRvulejsg+1i5SW30bD8hOOOBFbhW5LgRN8DGdQveTJiBSwduPjvPuRMEsgiGQvXA8tTccKcswaHsF+4jp4Ki9TQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVeBlxwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7D9C116C6;
	Fri, 20 Feb 2026 20:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771619894;
	bh=YkeUmJE5VCgB+/8w/kNuLw08/jxthUEWqf0pcnkt7Iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sVeBlxwuYPKMYlbDKYgy0GxImyJyTCgi4neui8y09/xveCbg22SD758KHzUDD7z6N
	 D1LlWobBt1KU7Wa9bmHSI2IIzw7wuTK8qyJ90mnBHiA04gBcIz8hrdx35YxZkC2MqF
	 jwgTtALy0yJdFsVdJlYZjvSnXsZ/ho5IwLwkzFkZJu55KPHBrBRCwKCiu6Bs79y5B4
	 zj1anQKJ1FeyzByBShIAszsD+WKBSbvOLN7QBQqGI/vD87IxAZsBgPm6ow9UZY2S1B
	 0r0096DuTV99nCweGeEvSnvIDDDMr2WPWRofgss+7TQt+xzy3I8l5gXDEZxfdAN6fU
	 IJ7wOmj1V1BuA==
Date: Fri, 20 Feb 2026 12:38:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: "Nikhil P. Rao" <nikhil.rao@amd.com>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v4 2/2] xsk: Fix zero-copy AF_XDP fragment drop
Message-ID: <20260220123813.61780c4f@kernel.org>
In-Reply-To: <aZhVdcTDceAlhLvV@boxer>
References: <20260217211019.48280-1-nikhil.rao@amd.com>
	<20260217211019.48280-3-nikhil.rao@amd.com>
	<20260219145529.42b177d3@kernel.org>
	<aZhVdcTDceAlhLvV@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,intel.com,fomichev.me,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-259764-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8F2116AB1C
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 13:37:09 +0100 Maciej Fijalkowski wrote:
> > Personal preference perhaps but removing error checking always
> > gives me pause. Maybe:
> > 
> > 	bool frag_fail;
> > 
> > 	frag_fail = __xsk_rcv_zc(xs, xskb, len, contd);
> > 	list_for_each...
> > 		...
> > 		frag_fail |= __xsk_rcv_zc(xs, xskb, len, contd);
> > 	DEBUG_NET_WARN_ON_ONCE(frag_fail);  
> 
> error checking can be actually skipped as xskq_prod_nb_free() peeked into
> xsk rx queue and told us there is enough space for descriptor production.

Understood. I was wondering whether the assert / DEBUG_NET.. may still
be worth keeping but up to you.

> Nikhil, I also see you routed the set to 'net' tree, previously xsk core
> was handled via bpf/bpf-next.

Dunno... We had mixed results, I think net / net-next is fine for stuff
that's purely packet movement. There is no BPF dependency here..
Unless you have a reason! I'm not feeling strongly. Just the stuff we
were fixing recently made me wonder if this code is getting sufficient
networking eyes..

