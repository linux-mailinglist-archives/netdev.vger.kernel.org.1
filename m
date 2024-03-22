Return-Path: <netdev+bounces-81311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CB68871E6
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 18:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC40B214B6
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 17:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BC35FBA6;
	Fri, 22 Mar 2024 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3clEoEh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024E5D72B
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711128584; cv=none; b=UggIUiPSVkXfI09fz2LRBjtsP1j8e6TZPOmIKD/FE6mbIGKk0hxbCc9ZMNDKemI8/Txo5ljWgpKEomyFrSZ5yK9kz6N3yzrWEJV63EXOh48UELU2sMKKvSi/2B1HWLs6CH8gb/GKKgAFIErhj5TR9xt6qZQ6NU9z1OLTZ/uCBJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711128584; c=relaxed/simple;
	bh=wsMwUpOL7JW1OHIJ/6b1Lh6VfBeVFEE6DXXlE5V1nLg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ovCe07Ef/9VHq5yPz/dgKMEe+Rs7y9CMEJxROyiul7h7tbJsMlLXQVHwoh6TUmXae+ZzHwTC4cUVIcPkZv3qgoumnFnrAto/wn+CEnDBLgcf04Nol54clG8skyWlUHXoyJ7QCt/jYYvX6r4VPRDhFI38GU56kThHkmRkWoRquoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3clEoEh; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-787edfea5adso101404585a.2
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711128581; x=1711733381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gWqkyWvghvlzeWzcDppW1JEWTC6Aw10YkW8NitFWl8=;
        b=G3clEoEhrt0CPeczRcuhm7o6OpBo9y+XjN9MsPO/URf1esjQxhc1o6ijh/kfausLqO
         5O/2cDuUEMbGcSVt3bPpvIpN1pQyAp13xZvBl5R6W2k/HdyUwt0ZJC0w+h67FtZfVDV6
         ctco1VBnSTmPOgDdN0uU2v6/JezvZvfwXLNex2gISHP1I0/gHLz5FCuBK0Rzl6vM6G6r
         wibnyrOIM5SinfSrT9qpWW2ebmsqgpZpjpULb0WBGFygmLUYPtt3FCujQJFiukVZen3q
         zh//yxYQN6n8Z+WfbSCqwIuewiLtdaFJs0CVj9CITiLV2JlqqQAukQAYguX7gOgFEeMh
         RYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711128581; x=1711733381;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4gWqkyWvghvlzeWzcDppW1JEWTC6Aw10YkW8NitFWl8=;
        b=U0ep5YJIQ08e//Ic0t/eBOMOqohrIecmHRPJPNPjIomDUDjUFriaw0xzoEOycHLY9g
         Vtzj96Hq4MalqSzPo9reTgHTSkgHV3esQCv59hYxH+kTotG7uuaPjBHfv7Rt/eQ1/0yg
         9egZChOg2hfKcTdHjUAQb8165BeBK06wdSusFoJhxPUZsqLe78tQq9MOddxuAs2+LPEw
         NTK1AbSFMPspctCJ3aQqe+CFSZm+KQfbN/DXn+WXEj5QxR8E8eW1Mrf8S3QjzAyOP5EG
         d9pYe9SZ4ym/Ln/GiNZUAScbSnLpnQmqF0Piqs4hoeoWaLX5mmOgMGcL7sXn8ywEsIe+
         PMQg==
X-Forwarded-Encrypted: i=1; AJvYcCVn856BiG4RdiVJYL+5NvNYDK+3ZiHwKEtrvB9s+ctecslUYe0sslzYqFngFdPzeaMIozzRK1WFk1mqswoTsEoBWPX5zlsd
X-Gm-Message-State: AOJu0YwzI+FZgca7btIBKsIXZhO36aEI34B9hZ6ez4d27Q0kwt3Ekoua
	FELdu/JEY0n9ToJY9B4TLxV1ee2B2K8TUeoOXBkJyCYl3qXfOBP/5dqH1reI
X-Google-Smtp-Source: AGHT+IEOu/e64ZF6u0awNol2V1Ot/f4fYbcEe0WQ0k+dGMf+2rz48lkEp7Rh1+0tTRtifCKfyjmYkQ==
X-Received: by 2002:a05:620a:2908:b0:78a:5c2:d23d with SMTP id m8-20020a05620a290800b0078a05c2d23dmr190573qkp.0.1711128581411;
        Fri, 22 Mar 2024 10:29:41 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id bk31-20020a05620a1a1f00b00789ea49fd22sm13440qkb.49.2024.03.22.10.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:29:40 -0700 (PDT)
Date: Fri, 22 Mar 2024 13:29:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antoine Tenart <atenart@kernel.org>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>, 
 steffen.klassert@secunet.com, 
 willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org
Message-ID: <65fdc00454e16_2bd0fb2948c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240322114624.160306-4-atenart@kernel.org>
References: <20240322114624.160306-1-atenart@kernel.org>
 <20240322114624.160306-4-atenart@kernel.org>
Subject: Re: [PATCH net v3 3/4] udp: do not transition UDP GRO fraglist
 partial checksums to unnecessary
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antoine Tenart wrote:
> UDP GRO validates checksums and in udp4/6_gro_complete fraglist packets
> are converted to CHECKSUM_UNNECESSARY to avoid later checks. However
> this is an issue for CHECKSUM_PARTIAL packets as they can be looped in
> an egress path and then their partial checksums are not fixed.
> 
> Different issues can be observed, from invalid checksum on packets to
> traces like:
> 
>   gen01: hw csum failure
>   skb len=3008 headroom=160 headlen=1376 tailroom=0
>   mac=(106,14) net=(120,40) trans=160
>   shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>   csum(0xffff232e ip_summed=2 complete_sw=0 valid=0 level=0)
>   hash(0x77e3d716 sw=1 l4=1) proto=0x86dd pkttype=0 iif=12
>   ...
> 
> Fix this by only converting CHECKSUM_NONE packets to
> CHECKSUM_UNNECESSARY by reusing __skb_incr_checksum_unnecessary.
> 
> Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Sorry to have yet more questions, but

Should fraglist UDP GRO and non-fraglist (udp_gro_complete_segment)
have the same checksumming behavior?

Second, this leaves CHECKSUM_COMPLETE as is. Is that intentional? I
don't immediately see where GSO skb->csum would be updated.

I can take a closer look too, but did not want to delay feedback.

> ---
>  net/ipv4/udp_offload.c | 8 +-------
>  net/ipv6/udp_offload.c | 8 +-------
>  2 files changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 3bb69464930b..548476d78237 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -722,13 +722,7 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
>  		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
>  		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
>  
> -		if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
> -			if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
> -				skb->csum_level++;
> -		} else {
> -			skb->ip_summed = CHECKSUM_UNNECESSARY;
> -			skb->csum_level = 0;
> -		}
> +		__skb_incr_checksum_unnecessary(skb);
>  
>  		return 0;
>  	}
> diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
> index 312bcaeea96f..bbd347de00b4 100644
> --- a/net/ipv6/udp_offload.c
> +++ b/net/ipv6/udp_offload.c
> @@ -174,13 +174,7 @@ INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
>  		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
>  		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
>  
> -		if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
> -			if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
> -				skb->csum_level++;
> -		} else {
> -			skb->ip_summed = CHECKSUM_UNNECESSARY;
> -			skb->csum_level = 0;
> -		}
> +		__skb_incr_checksum_unnecessary(skb);
>  
>  		return 0;
>  	}
> -- 
> 2.44.0
> 



