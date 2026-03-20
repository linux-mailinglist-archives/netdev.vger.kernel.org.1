Return-Path: <netdev+bounces-270045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NcvFeievWmW/gIAu9opvQ
	(envelope-from <netdev+bounces-270045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:24:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB832DFDF2
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B0C23020509
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DA034D3B1;
	Fri, 20 Mar 2026 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq9yuy3f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2CA34C12B
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034659; cv=none; b=Cr2SBOsNIZLn+hTJ+vWmrAGVacZIkZ5Fg5snIHM2xkv/LUfAZNzktLzCsxStASh8oIYcZ8Fb7SOEdus+ALRbzP3ve0GvAbV63XZoOdbF8sgsCQUuhSxkddvOg+oUYin0PR5xBPzB5kcG/SG/nW6eyt4zndwScd10zwSFkwDbUJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034659; c=relaxed/simple;
	bh=AAoHi3E3pYFmtsInfUBOH0hYPsWqRWTaH/bElid2KBg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZhybM/X1Whndh9J9WILWwg2XCGaC79k0IqoIWi/KJRXAx3kft/y/aTJ9lJCAGJ8x7IBUzrt64dVQqngcylOwP/RzsXzSmk8a/ZQEhF6PwHOX9moBXlsYamYOPh6Ji78Khi8tf8Xw9nyxIBN0u5svqLlwXvW/ku/bCH5dVuHib6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jq9yuy3f; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64937edbc9eso1036114d50.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034656; x=1774639456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E67JCelcxEnCX3a2Sq4H2/xp+XhNrkqey+wbQ7vBedE=;
        b=Jq9yuy3fgc6yQxHh696rEoGPgeronstHV9GAA1xO03L880S4GdS+zvymEZK6wjzlIU
         0dgOkOuGaL0VSymsfXft/D/OUtTjSJPRcUFGyf8a1A4pHcfcL0qEJ+eVjXpF0IRD4CP3
         xIPzJSAbH1hw1eox+141mio5zf9i614rXIrHD7jcx4Id/QELJ2rVbXUpSsgQ+xdNb5fG
         5zqG5vmgzOcrs3IhkGqkOM8tw6nNH7pn1QT9yw9KWj7epj7FbkQTePX0ZqTIH927pPYC
         wSiklDb8juBhg3017w+fnDB6b3F2yNH6kXBxNb7JyNMg8RczwM9nc4XO6Y2/tr4EIU0A
         K/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034656; x=1774639456;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E67JCelcxEnCX3a2Sq4H2/xp+XhNrkqey+wbQ7vBedE=;
        b=TUoFKWOEv/5Y7HmPJO7PaSZxQoySxtt9G1oh3f+pkvJsAJY46Xxi9WaIKqXWMXCh6R
         J9z3/2eIrUfmo2eUYRQJdQzEh9LsKJjVOdiptMRJBLqNt6Qp+JRPDsbj1EnbpmddGFnc
         EtRv00DoMEshuFZ1RXgiw8ZnrXqRuc+mYb3CSqfB+gBnrptx6fdA442WWGR9RAMB1kOw
         CCcyf1/2rZVHWi7B6h76XunYd4Ff53VoRNHIqgVAJqFkHFg1NIRMCQ/7ENtq4uMVT1VH
         InTXZIK+lM6IrK24FUeu0LiZOu1IoXoRUyZUImvdNZGEc9OHA6SkQemHkTiMLAA8Fjlq
         oFUw==
X-Forwarded-Encrypted: i=1; AJvYcCUF2ykbt7d79rW2C+9I4FBA4PSn69/ukEcpFyydJGmwV+MG6BHxKyl73uqOfZpP0gy+cbmbBMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDcDqSRBx2/IhbGu6gY7e3g3+BzXrTrgVfJL28S8bp28Rc0RP
	Hsrn19+2qVmjEbampljZd3tQzIJ8BJjrnLD1+Ce+YcV3Ia0vBVrQNCFkKsyP1A==
X-Gm-Gg: ATEYQzxgiXJZcTBZaO6o075q2uzB/PkQCD0Xv9gl1hsMRKcUBJ/9Cn3HgItqbnTTDz4
	pY3cjBH4MDOqe7hh4hg2hi5tN1vi9BO77V19GeM1HNAQIGanOgeRUxPvxut7Cbz6ljYUorQ8BZL
	jRSkT5p3qoNVTQyRTiOG4I0bWN4ry8o5JZHId6yNLTUGOmRmdzA6Wde/XLyXgx8kf3BDm8fF9jl
	uKihLv2iVyYmTgH4RMn98n2aw6LY2SfXs9E5Od1YZ66jMFPJUXdjentk0xPqy0XDtTHczAoN7q7
	hAFpjB1n49ss0qdk4t7QotPk8dijmYSGZqfPlpmDIXSOS6qgmik5jzzA7jO/IzaI4RYr25pubuG
	41wUKERvg2FJD51mQeFczL7FqWcU1wifNTAOcznUp/pajPI8NLXGa9JFnqBn0wDt+VcvHEJZeQL
	2lSlVZPoHzoEIAI4Wp8JIah1JwgHK72G0cBRBcQ0fnewk0BGxydzdZLw8L6FH13kMVH0cDMoun0
	l2t
X-Received: by 2002:a05:690e:1583:10b0:64a:d1bd:8c66 with SMTP id 956f58d0204a3-64eaa6df7bcmr3852436d50.29.1774034655988;
        Fri, 20 Mar 2026 12:24:15 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64eabd3e317sm2064774d50.4.2026.03.20.12.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:24:14 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:24:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Guoyu Su <yss2813483011xxl@gmail.com>, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org, 
 horms@kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com, 
 syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com, 
 Guoyu Su <yss2813483011xxl@gmail.com>
Message-ID: <willemdebruijn.kernel.2018fae77325e@gmail.com>
In-Reply-To: <20260320141459.9691-1-yss2813483011xxl@gmail.com>
References: <willemdebruijn.kernel.c0bb5d182993@gmail.com>
 <20260320141459.9691-1-yss2813483011xxl@gmail.com>
Subject: Re: [PATCH net v5] net: use skb_header_pointer() only for DODGY TCPv4
 GSO skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270045-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,googlegroups.com,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,google.com,davemloft.net,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	NEURAL_HAM(-0.00)[-0.086];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: ECB832DFDF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Guoyu Su wrote:
> Syzbot reported a KMSAN uninit-value warning in gso_features_check()
> called from netif_skb_features() [1].
> 
> The current direct skb->len check is not sufficient for SKB_GSO_DODGY
> packets. In the AF_PACKET/PACKET_VNET_HDR path, packet_snd() can build
> a DODGY GSO skb whose total length is large enough, while the IPv4
> header is not fully available as initialized linear data for a direct
> iph->frag_off access.

The fix looks fine, but the AI review of an earlier revision brings up
a good point: __virtio_net_hdr_to_skb calls pskb_may_pull in all paths
to ensure the network header is fully in skb linear. What kind of packet
is this that managed to escape those checks?

> Use skb_header_pointer() to fetch the IPv4 header only for DODGY packets
> and clear mangleid_features conservatively if the header cannot be
> accessed or the DF bit is not set.
> 
> Keep the existing direct ip_hdr()/inner_ip_hdr() access for non-DODGY
> packets so that buggy internal callers are still exposed.
> 
> [1] https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
> 
> Fixes: cbc53e08a793 ("GSO: Add GSO type for fixed IPv4 ID")
> Reported-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
> Tested-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
> Signed-off-by: Guoyu Su <yss2813483011xxl@gmail.com>
> ---
> v5:
>  - Move nhoff into the SKB_GSO_DODGY branch.
>  - Drop the explicit nhoff < 0 check.
> 
> v4: https://lore.kernel.org/netdev/20260319005421.14908-1-yss2813483011xxl@gmail.com/
> v3: https://lore.kernel.org/netdev/20260312104351.185370-1-yss2813483011xxl@gmail.com/
> v2: https://lore.kernel.org/netdev/20260308083319.1255118-1-yss2813483011xxl@gmail.com/
> v1: https://lore.kernel.org/netdev/20260307162905.3697050-1-yss2813483011xxl@gmail.com/
> 
>  net/core/dev.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 14a83f2035b9..be0cc69fa534 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3805,10 +3805,20 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  	 * segmentation-offloads.rst).
>  	 */
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
> -		struct iphdr *iph = skb->encapsulation ?
> -				    inner_ip_hdr(skb) : ip_hdr(skb);
> +		const struct iphdr *iph;
> +		struct iphdr _iph;
>  
> -		if (!(iph->frag_off & htons(IP_DF)))
> +		if (unlikely(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY)) {
> +			int nhoff = skb->encapsulation ?
> +				    skb_inner_network_offset(skb) :
> +				    skb_network_offset(skb);
> +
> +			iph = skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
> +		} else {
> +			iph = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
> +		}
> +
> +		if (!iph || !(iph->frag_off & htons(IP_DF)))
>  			features &= ~dev->mangleid_features;
>  	}
>  
> -- 
> 2.34.1
> 



