Return-Path: <netdev+bounces-303483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EttsLY21RGpEzQoAu9opvQ
	(envelope-from <netdev+bounces-303483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:37:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5BA6EA450
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:37:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303483-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303483-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 159083007895
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 06:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726EE35AC3C;
	Wed,  1 Jul 2026 06:36:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013172E62A9;
	Wed,  1 Jul 2026 06:36:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887775; cv=none; b=cr2ICAkk56vvecDIHrzXEilQPIZxcsSyZQCVvFyLflR6N3hFgxVUQujuPa/d74ogrfphcB5lDHIpNTy5U5IM6uxitumnYZ83PkLxXN8ZWxtWiYA795puBb7oYL8R2zWHd8WpGmCfrJsXIRBKCvQfAaEZEh92E79sukcx6jGLfFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887775; c=relaxed/simple;
	bh=W0+x3mTxKmE28XoEmmcTzUPx1gA8EEVcbQXsTKdrFM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3BrBUniBlKOSqdARX8Vc66U8YVYKFvRkBfHUcptB4bIbjOnjIRFRNOYtDexHfF/bLPbo5G+Nf2FgPvX606IXLCzhfer61PJlUMScplItLTF55BIaBmFWmZDD0ff5h8fXJoGVatDaqmfgTCvwdDSCqpw2KEhhwJMyPEvy7D7Hls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A5C4B602F8; Wed, 01 Jul 2026 08:36:11 +0200 (CEST)
Date: Wed, 1 Jul 2026 08:36:11 +0200
From: Florian Westphal <fw@strlen.de>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org,
	pablo@netfilter.org
Subject: Re: [PATCH net 4/9] netfilter: nf_conntrack_sip: validate skb_dst()
 before accessing it
Message-ID: <akS1W7XGQ3LiP0LC@strlen.de>
References: <20260630045243.2657-1-fw@strlen.de>
 <20260630045243.2657-5-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630045243.2657-5-fw@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303483-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,netfilter.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ozlabs.org:url,strlen.de:email,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A5BA6EA450

Florian Westphal <fw@strlen.de> wrote:
> From: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> tc ingress and openvswitch do not guarantee routing information to be
> available. These subsystems use the conntrack helper infrastructure, and
> the SIP helper relies on the skb_dst() to be present if
> sip_external_media is set to 1 (which is disabled by default as a module
> parameter).

The sashiko drive-by appears real, I submitted a patch for it.
Its not a regression added by this patch but a unrelated issue.

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260701062922.9660-1-fw@strlen.de/

