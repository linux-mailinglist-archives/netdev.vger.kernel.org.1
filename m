Return-Path: <netdev+bounces-306322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RwLYFb3XT2pDpAIAu9opvQ
	(envelope-from <netdev+bounces-306322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 19:17:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98988733C81
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 19:17:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QkSi7MVB;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306322-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306322-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF429301A901
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E239EB47;
	Thu,  9 Jul 2026 17:13:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5121B39DBE5
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 17:13:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617190; cv=none; b=RM9nHLG6d1hqJFJnsYk31/ml0eoldA3OG7V+l9na4QazsfBGI+R6rtzGWqYG55ZSdHRkUxhGTHlkA6WR+8U9CKaN8qYQwCynOnPo7Tn6P4XazYGSIRhe5vpTA+8jeJrmoAhbAraB7gE7VG+BcEIM0jY0h2eQ+bXx+rv9VjcJbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617190; c=relaxed/simple;
	bh=zfzxst+OIscXUvbk8QAIbzukiIr8kIyDsKyM5EYA5rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFNzpAAiT2/6vVtJlsVkzAfVIvMOg7DBXxDmW3JwxcGtSJ+Fma2HFucWy84zH6zlfes3ZWlMKIEHsuKn77dDzzavlOlJbUBahnrze77HeUEPy92BXFnwXzjVntVlRRlssDYoFG64jwGai+mFHgYyUApzYzNWVd5pgwSrmjjz0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkSi7MVB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7581F000E9;
	Thu,  9 Jul 2026 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783617189;
	bh=1pV70xEOvQyB3ukvmw0oiht/Cdcq4jFyt2B8YWj7CXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QkSi7MVBWoMXoAzvPr4vFBO+UOTmSx0mkflKFEeuc7vobI3Jbqwu5iTWL1GvopSRb
	 f4SlmQRhVJ8Qf6+C/iSIVrvPXdD+Ljz2j6xRwtWg9/kepoLUkLXmEYxmZhveT5Jj9C
	 Jz2h/abnW5jgGd4+eLH0B0I7QOLliL74pkqi4mQGHVbb7rEMimQcdFoJfp4tpyrSmJ
	 7xA1/u/t8BH6C05HeazzEhfzzDQys5AJfYhBW4dJ1peg07TbJnnsxcqD9yTlpSJbqe
	 TrXWLB0qzD8ycP7cfZbGHGQXIXc9fFUchp9KMuguNs3eMWg9EWdm3RNhKnQkBKDvXY
	 9w7A9xnz+l+NA==
Date: Thu, 9 Jul 2026 18:13:04 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: fix ETS channel derivation in
 airoha_tc_setup_qdisc_ets()
Message-ID: <20260709171304.GV1364329@horms.kernel.org>
References: <20260704-airoha-ets-handle-fix-v1-1-42516b3549a1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704-airoha-ets-handle-fix-v1-1-42516b3549a1@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306322-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98988733C81

On Sat, Jul 04, 2026 at 04:21:38PM +0200, Lorenzo Bianconi wrote:
> Derive the hardware QoS channel from opt->parent instead of opt->handle
> in airoha_tc_setup_qdisc_ets(). The ETS qdisc handle is either
> user-specified or auto-allocated by qdisc_alloc_handle() and bears no
> relation to the HTB leaf classid that identifies the hardware channel.
> HTB derives the channel from TC_H_MIN(opt->classid), and ETS is always
> attached as a child of an HTB leaf, so its opt->parent matches that
> classid. Using opt->handle instead can cause two ETS qdiscs on different
> HTB leaves to collide on the same hardware channel, corrupting scheduler
> configuration and stats.
> 
> Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


