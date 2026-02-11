Return-Path: <netdev+bounces-258177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RtzeIQ3yi2lXdwAAu9opvQ
	(envelope-from <netdev+bounces-258177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:05:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 782B1120D75
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEB07300B529
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 03:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5292F83AC;
	Wed, 11 Feb 2026 03:05:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B392D8766;
	Wed, 11 Feb 2026 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770779143; cv=none; b=h055jqXbcGBNYKP3R/ZLxOrIrBpoInq6j/QfUQtBEe34YmifAC8DMx/GbJn4sdF/D29qMu1Ktk75+5BK7dNyoKFu+e6OtbNQWx6RCggsxI3uZm+1gaWuOTXmUicipAVz0TY1gy8mAO6aLh4MWNXf9dipkcaOJJoNifYoGP0JTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770779143; c=relaxed/simple;
	bh=zFMPx/uaDgj7OSAXnVULEtjjSu/xzIIWX1fxcezlqWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8LNnapimNxYQSyftant4OnM5leCmHKOq5HLuKrGjQR+kjQYQuFs3sec7v9fY549PXF12EdnLR1yF737tLKRlcQmdNn76hjEGxwM9CmdatzbLez2KsJZ9Y3vlACLB1uVwAYoeEwUm18B32XHAr9bjLSkY0CbmCRqUKg3NtNGPhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A6A954C3FB;
	Wed, 11 Feb 2026 04:05:35 +0100 (CET)
Date: Wed, 11 Feb 2026 04:05:34 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Jakub Kicinski <kuba@kernel.org>
Cc: razor@blackwall.org, kuniyu@google.com, davem@davemloft.net,
	edumazet@google.com, idosch@nvidia.com, sdf@fomichev.me,
	shaw.leon@gmail.com, netdev@vger.kernel.org, bridge@lists.linux.dev,
	horms@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v2,05/14] net: bridge: mcast: track active state,
 foreign IGMP/MLD querier disappearance
Message-ID: <aYvx_ghdIarDKFqR@sellars>
References: <20260206030123.5430-6-linus.luessing@c0d3.blue>
 <20260207045605.4164706-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260207045605.4164706-1-kuba@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[c0d3.blue];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258177-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[blackwall.org,google.com,davemloft.net,nvidia.com,fomichev.me,gmail.com,vger.kernel.org,lists.linux.dev,kernel.org,redhat.com,lunn.ch];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 782B1120D75
X-Rspamd-Action: no action

Hi Jakub,

Thanks for checking.

On Fri, Feb 06, 2026 at 08:56:05PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> [...]
> This isn't a bug, but I noticed a couple of unaddressed review comments
> from Ido Schimmel's feedback on v1 back in May 2025 that don't appear to
> have been incorporated into this v2 series.

I have the feeling this bot got confused somehow, maybe it does
not fully get how things got restructured in
br_multicast_querier_exists(), __br_multicast_querier_exists()
and the newly added br_multicast_snooping_active()?

> 
> In __br_multicast_querier_exists() in net/bridge/br_private.h around line
> 1164, the 'is_ipv6' bool parameter is marked const. Since this is a
> pass-by-value parameter, the const qualifier doesn't provide any benefit.
> Should it be removed?
> 
> Reference: https://lore.kernel.org/all/aDNPxdmDPYwasUEM@shredder/

I'm not adding or moving any "const bool is_ipv6" anymore. Au
contraire, I'm explicitly removing the "const" in is_ipv6 to
__br_multicast_querier_exists() while restructuring
things in [PATCH v2 13/14] now?

> 
> Also in br_multicast_querier_exists() in net/bridge/br_private.h around
> line 1182, the function takes a struct ethhdr *eth parameter but only uses
> eth->h_proto. Would it make more sense to either make the 'eth' parameter
> const, or just pass the EtherType (__be16) directly instead of the entire
> struct pointer?
> 
> Reference: https://lore.kernel.org/all/aDNPxdmDPYwasUEM@shredder/
> 

I think I also followed this one, too? In [PATCH v2 13/14] I'm
removing passing a "struct ethhdr *eth" and am instead passing an
"int proto" to br_multicast_querier_exists() and an
"__be16 eth_proto" to br_multicast_snooping_active()?


(I'm also unsure why this reply was to this patch and not
[PATCH v2 13/14] ->
https://patchwork.kernel.org/project/netdevbpf/patch/20260206030123.5430-14-linus.luessing@c0d3.blue/)

