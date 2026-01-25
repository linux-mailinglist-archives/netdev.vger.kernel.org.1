Return-Path: <netdev+bounces-253229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLKXFLSSdmkxSQEAu9opvQ
	(envelope-from <netdev+bounces-253229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:01:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9228D82999
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAE95300463F
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA9C7081A;
	Sun, 25 Jan 2026 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb3DYGFf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8573090C9
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769378457; cv=none; b=Bo/7pmOogNV1fDb5VZOoM6Kr/IKUjOKYCiBXKvFEDGEmPDWwmdZGTSByYGCk2bLlJmYblI4c3leKChDN8bmNModw+NgcFdyPVuO4O63iW1x/buE1eMqoJAeXf0wZkix27Gr7RkrFcKg4YP+H13qEKC/VeIcoQ9/gUiIjS8ZS06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769378457; c=relaxed/simple;
	bh=jclKtdJuZtCUFK1atwM6/A5wtddZpbuJR/UgpxglLqw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fx4FDLV/o7t8VTQwaII0wThce5IokCyJw2FWVX4N8GtICHwpiMmOYIkyFy9Tru+A4rSFaNNB/d4wrtEFEcYX/IeJYKEgl+yJgy6vD713NFZh2F1ZYw0bpGKWdq5d/o8UtumDrLSjL+Q2Ox6atczQ0bZg5LE0Gp9V6T+xdAbL4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eb3DYGFf; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-644715aad1aso4373392d50.0
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 14:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769378455; x=1769983255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAA6S4oPNmkGryTm0KBSPRHi5Lj0tu35Mdjk5cYMuDc=;
        b=Eb3DYGFf57Cv+8SS+sYq/BlxzSU+wRENnadkVD/D3lRG8w6bItXGM7t+GihAiHIwkq
         iQR0IB+bGxkPIpHctaFSy4oOYZ3fHYAcqgDhpFtzunSQI+nTUQdw8rK5e3BdCiwPo2OR
         FVpW2WRFHb6P/RpSsflSa+3NkvqJ2gdpDVg1cZ7s7GVGyWvrn2rl7ihyFj1mZKCrFTPJ
         a0B6AywfrnopRaeekKpmD9JWqNU0Bp+RoSPduJsfPkb/AXEz4BDvs4U3vcTs2PVzli7E
         Hp+IBRh3JAOLoaMBH9wXPtSoMlOSWHV23Pqg1T2aCrFM1zBBzRuA1ragSBIb1rGl8CRc
         +TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769378455; x=1769983255;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAA6S4oPNmkGryTm0KBSPRHi5Lj0tu35Mdjk5cYMuDc=;
        b=OvXe+JYlUeEL69gnvCC+6HX2zzsIwuYS8NJiLWuZfP1SaRT+bsemgCMJP0nz/nAycH
         2qdR/Qk8NtZ01g+MPsWze15FDboIE7q4EcVaUG6VhLtemAFZHragPXgUrbGqABgbTgjA
         92XXp+yX3uccLxQ9/7ZRNksjR5OtQot5az8/Iio+8q4WTbPuo8uhQEsNEiszwFz6di/T
         WKuIMtJkwGw0vFyJq1QxKvi2dOha+o4ZnMzbDGKVguNCKreu+sNzQBiLIp8bg5ZDZGnE
         kALjAEDNEBcx40Q4SDeqzCVpt8gabsbVMWfgWCVW1ApaP2SPnyuc1syMmWTlVY5UZVlP
         qmvg==
X-Forwarded-Encrypted: i=1; AJvYcCWfH7Og9dS9Oo8c7/oZniFDZKe+rZHFrP5GJypxDTgHHF+0HV2h6wrYFpbi79DYTn7B4IsDpWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+jWdHSzaRqrA/rdiHSQYxa5i3YUAfxIx0cOfJMPPYUquyfRH+
	2ZMuqWzGgUdTGGgIgtx/+Zl1MBLD0GQvZFwqLQYVnXIEBnVWYd2Fu3YO
X-Gm-Gg: AZuq6aImaCqIJHlWFMli9ZzRsP67FC4b4AC7RcQktOTSDa3D6WGCK77kLdE/b5JxThe
	lQxtTZTCsWaoufuUDH5lCXI0Gp4CqTjNsR1N6+ZAMbk/UOmYUacKUT4Orsd5RiMve4AOQ3dV8rI
	mKdOUvWGKeobHQU6GwS2Hn4YXrqoHLx5EXRDGeAPfQ5WhPMgsYzoJJhdcfdvsYEaRJtJpa1qvb1
	M1glxg41pNGCeLmhdSRFTXTxhrCgZslTxl2Hj9NM4kEt4BH5q5dvWQ8jw6YwkQNcEyROidILQqq
	LtY0OTZRucjZfNentpINFDvt+TUzq5OgtZeyptxSG3Vjr3LebMd7arlZsaLj4nWj8OuVPJFIu6d
	OMsq5efRb5TvOJu2zMNAJWF6L7k+J9tK2KEngDaA6QNFHsuc+mcPjRWbkEAGtiH00SLl3btCWvH
	WLiZLYKzPp61+yczgnP4HPFI59NzteFxjGUN9/FjB2aQyng4fZEbyFCHuKdAw=
X-Received: by 2002:a05:690e:12ce:b0:649:47f1:26e0 with SMTP id 956f58d0204a3-6497140db99mr1986222d50.38.1769378454977;
        Sun, 25 Jan 2026 14:00:54 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7943ae2d7f9sm40457437b3.0.2026.01.25.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 14:00:54 -0800 (PST)
Date: Sun, 25 Jan 2026 17:00:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jibin Zhang <jibin.zhang@mediatek.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
Cc: wsd_upstream@mediatek.com, 
 Jibin Zhang <jibin.zhang@mediatek.com>
Message-ID: <willemdebruijn.kernel.4c5ab6b532d7@gmail.com>
In-Reply-To: <20260124095021.3953-1-jibin.zhang@mediatek.com>
References: <20260124095021.3953-1-jibin.zhang@mediatek.com>
Subject: Re: [PATCH v3] net: fix segmentation of forwarding fraglist GRO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253229-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[mediatek.com,google.com,davemloft.net,kernel.org,redhat.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9228D82999
X-Rspamd-Action: no action

Jibin Zhang wrote:
> This patch enhances GSO segment checks by verifying the presence
> of frag_list and protocol consistency, addressing low throughput
> issues on IPv4 servers when used as hotspots
> 
> Specifically, it fixes a bug in GSO segmentation when forwarding
> GRO packets with frag_list. The function skb_segment_list cannot
> correctly process GRO skbs converted by XLAT, because XLAT only
> converts the header of the head skb. As a result, skbs in the
> frag_list may remain unconverted, leading to protocol
> inconsistencies and reduced throughput.
> 
> To resolve this, the patch uses skb_segment to handle forwarded
> packets converted by XLAT, ensuring that all fragments are
> properly converted and segmented.
> 
> Signed-off-by: Jibin Zhang <jibin.zhang@mediatek.com>
> ---
> v3: Apply the same fix to tcp6_gso_segment(), as suggested.
> 
> v2: To apply the added condition to a narrower scop
> 
>   In this version, the condition (skb_has_frag_list(gso_skb) &&
> (gso_skb->protocol == skb_shinfo(gso_skb)->frag_list->protocol))
> is moved into inner 'if' statement to a narrower scope.
> 
>   Send out the patch again for further discussion because:
> 
> 1. This issue has a significant impact and has occurred in many
> countries and regions.
> 2. Currently, modifying BPF is not a good option, because BPF code
> cannot access the header of skb on the fraglist, and the required
> changes would affect a wide range of code.
> 3. Directly disabling GRO aggregation for XLAT flows is also not a
> good solution, as this change would disable GRO even when forwarding
> is not needed, and it would also require cooperation from all device
> drivers.
> 
> [2]: https://patchwork.kernel.org/patch/14375646
> 
> [1]: https://patchwork.kernel.org/patch/14350844

[PATCH net] and please include a Fixes tag and CC: stable.

> 
> ---
>  net/ipv4/tcp_offload.c   | 4 +++-
>  net/ipv4/udp_offload.c   | 4 +++-
>  net/ipv6/tcpv6_offload.c | 4 +++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index fdda18b1abda..6c2c10f37f87 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -107,7 +107,9 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
>  		struct tcphdr *th = tcp_hdr(skb);
>  
> -		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
> +		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
> +		    skb_has_frag_list(skb) &&

Not all skbs with frag_list are SKB_GSO_FRAGLIST skbs.
Let's limit to those, which was the intent when skb_segment_list was
introduced.

Could XLAT set SKB_GSO_DODGY when modifying headers for GSO packets?
Not sure which exact code is being referred to. All such BPF helpers
in net/core/filter.c do. skb_segment has a further sanityf check for
odd frag_list geometry, but conditional on SKB_GSO_DODGY.

See also https://lore.kernel.org/netdev/willemdebruijn.kernel.30b0807bf46c0@gmail.com/

But in general: it is always safe to downgrade from skb_segment_list
to skb_segment. And fine to err on the side of caution esp. for any
packets that were modified along the way, so Ack on the general idea.


> +		    (skb->protocol == skb_shinfo(skb)->frag_list->protocol))
>  			return __tcp4_gso_segment_list(skb, features);
>  
>  		skb->ip_summed = CHECKSUM_NONE;
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 19d0b5b09ffa..2a99f011793f 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -514,7 +514,9 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  
>  	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
>  		 /* Detect modified geometry and pass those to skb_segment. */
> -		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
> +		if ((skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size) &&
> +		    skb_has_frag_list(gso_skb) &&
> +		    (gso_skb->protocol == skb_shinfo(gso_skb)->frag_list->protocol))
>  			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
>  
>  		ret = __skb_linearize(gso_skb);
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index effeba58630b..3c7fd0362475 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -170,7 +170,9 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
>  		struct tcphdr *th = tcp_hdr(skb);
>  
> -		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
> +		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
> +		    skb_has_frag_list(skb) &&
> +		    (skb->protocol == skb_shinfo(skb)->frag_list->protocol))
>  			return __tcp6_gso_segment_list(skb, features);
>  
>  		skb->ip_summed = CHECKSUM_NONE;
> -- 
> 2.45.2
> 



