Return-Path: <netdev+bounces-296021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U0iXIld9I2oZugEAu9opvQ
	(envelope-from <netdev+bounces-296021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 03:52:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1836064C241
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 03:52:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VgTrE6ib;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296021-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296021-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 317C2302962B
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 01:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58944199385;
	Sat,  6 Jun 2026 01:52:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B53722652D;
	Sat,  6 Jun 2026 01:52:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780710741; cv=none; b=WFGkB9i9vfwAaxfo6bipPKpgzlhkYSkO66o1GiVT1GdCiL3upY3ulDn5mujIsfKxJ6d0aQXeceajkxNF9KQKbJ8gzbAfkcmwSuNYsLcSBd0//cgOkH6cFuRXj+UE4KelxLb+SGCaQ/s6BDpczrfuixHyQ7m2GjN2NK5ugRtwxJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780710741; c=relaxed/simple;
	bh=jXLqk39dh4GV1IdGH9oPuxNRXEMm3xhvcmetcpw2qVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViBKxfRGfqOqu8CbXYnDPAAe69aS0w9pOe/nVhkgTkWVzXkuxo5nWW9w2enM2z1KBfZ696MPls6xZ40TAPGy7+PN8VSjnMwjP22o0eDG5qP+9j+OXbqUX9Iy0ngKcTLUp6i0r/A6AEY20f6wiMLMfPuzcSsXn/1i0BtHsf2BJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgTrE6ib; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A459D1F00893;
	Sat,  6 Jun 2026 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780710740;
	bh=/W0oQZsffucYpGt5qBYJAQJIKuz+GVFwN5UOc7b7C/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VgTrE6ibXZHllNn4+NZgaKEnvjF1SMvqamT8enxNXi8nBQPMuNEdrTlMzFsUJyhbu
	 HI5DAoIRu+Svjzq7pzJb45Q5Db+WuVc7uFCcepJmOljFn1UF/XxzhsfPk0Rq+YGjXg
	 ARd92imyLa7wpUP7CF7JfaVfwcEWcUOZi7ZXQlF58h/BgTx6xMu3uk8e+bmUTofMJJ
	 9VGewpzWormaaCKDK6ziXQ2ik9T96GWXcwZ1D3taDry5eWYfVqys4NDayt95q5HrP0
	 Be9qU0ep7P3NjP9iQBaH6cHYeJAt+ezdzjwexlyaW9efXnbmxKXSalCIsaV7L5xMej
	 udsnUN36AoPhQ==
Date: Fri, 5 Jun 2026 18:52:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: <edumazet@google.com>, <davem@davemloft.net>, <jiayuan.chen@linux.dev>,
 <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/sched: cls_flower: reject ETH_ADDRS match on
 devices without L2 header
Message-ID: <20260605185217.23858c32@kernel.org>
In-Reply-To: <20260603101135.1954370-1-yun.zhou@windriver.com>
References: <20260603101135.1954370-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296021-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:edumazet@google.com,m:davem@davemloft.net,m:jiayuan.chen@linux.dev,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1836064C241

On Wed, 3 Jun 2026 18:11:35 +0800 Yun Zhou wrote:
> Fix this at the source by preventing nonsensical filter configurations
> rather than adding bounds checks in the hot classification path.

That's obviously preferable but we'd need much more code to make it
work. The TC action blocks can be shared between arbitrary devices.
I'm kinda surprised we can even get to a real device from the block,
but either way I think the check you're adding is meaningless?
-- 
pw-bot: cr

