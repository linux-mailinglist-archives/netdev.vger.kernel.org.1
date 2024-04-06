Return-Path: <netdev+bounces-85448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEA089AC8E
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 19:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EED9281EDD
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 17:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5725B4594E;
	Sat,  6 Apr 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx9qUoIm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44F446A0
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712425697; cv=none; b=HqGcHNoYejjAM5pF0YoO2OA4lyn/i7/KcRvPD0Al+Halr4QP+xb5Wfk4beqrruaOQPcKPBa7S7r4PwJbriaLTeK62sD4Bi/nek2ipyDQk0fUPVaW+LS7Bit+udVyuDzsk+TfC0hZFNyx1QGNMJOz/7DwECd7OSXDXOhJojJerug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712425697; c=relaxed/simple;
	bh=vrNznCeKHYbTReyAETSmlRPZ/FnbrWRysFHDGKNtVUc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SAUY/9eb2NeJPlfe4ruJSJZLy6hP6EGLZkdFr1lV5SZH3cmTfLOStN3G5NaVppv33nGYVLvoUhvW+KzmJMtORsBhhqWdMaTszd3AenJqhhityWxi9vgLOhlb/9FrC/i2mv5f1Xnx5G+PRd6qzPTUB/QL6PRpKnmbguley2mfrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yx9qUoIm; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6963cf14771so26690336d6.3
        for <netdev@vger.kernel.org>; Sat, 06 Apr 2024 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712425694; x=1713030494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVAn8i1m+Roapdsr9mW2PBPj/xupwvpFcXUlbTivErk=;
        b=Yx9qUoImQEZY5H/G6oGZDWKChty4ksaleOzAecHpzvpAlploH56kPGbNjrFySp7D0v
         svZ6+ASu7q90bmdaEwFlEPAkTUt0Wm9YtEC4VPCf7JAX7srHpN/gumkcWmv9PcOVnEGW
         ZhjvpmMhwUOpFW8F/d4HlwfJ/hLaeoPaHn7Tj7eBR0ydz843KTEqPgzC6UOi/MzRneCM
         3FYvd3lsRXUxazEQuwnlS/7AKgTJHmwV+6SzaSKfWAaB2OQHgLZY8rVw3XM1Lx1GXMXh
         djLkm3vFWlWJ2583Rr+dRzyzwRqt8aturbE2Mg0hipaHjco+/0Ax4SqLgiQgZFg4upVA
         hUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712425694; x=1713030494;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hVAn8i1m+Roapdsr9mW2PBPj/xupwvpFcXUlbTivErk=;
        b=BUbKP6runwL1ngYGTGectKcI9UpC/XVbOgLLqmvvEbcWKXzg1nHf4fYDpc3+2CilqJ
         0wDgZmBejhpqkn+X7u5zMl0Tzdq/aCMjNHjNLML8BeP6Oj+Wf3lN8yWipxpOtJEc/Mqb
         cCnZI4eILFVHDECxDFFBIniNUT0XYuN62PJKewbg9cqm5Tg/4dWjy9DG+0jIzTl6tHEa
         msLNY5BtSpf3lqArRi1lv1fjAp2o4bMoghGgPMkgzqQd2nYIwjRc9YmMozhPGk2YCIdd
         BKaCPZQiMfGRZemDLTCCJ6C/b9rr1GoeVtLB6/vb1agn4kqLugYnVhKwvgvE2Ugawkte
         MpJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt5ZQjSEXZacgVESqYLHhwSoxUOz6/SljglCCdY71wLuhWQ8s9FITZpNgURK2GuCyDR1xxZZWKDDHLTxy42YLjs0iEYgtt
X-Gm-Message-State: AOJu0Yw9qRzv1hRa2JJY4zCWeTeruMpkiDzn/eGbpcPDpi0aQ2g7XeOW
	0kxWFxrvrOuCj7z9wkRzH2jLhlfFzRwdxhqTy4qEAPmAsa3/nXE+
X-Google-Smtp-Source: AGHT+IFnLby0Dpj6+dDgeb8nexClwG17U8UyL7MmHv37q9Gp/lKqSbUAqB7rEbA9RYjik4PxdaMBGQ==
X-Received: by 2002:a05:6214:2a8b:b0:699:24e7:d335 with SMTP id jr11-20020a0562142a8b00b0069924e7d335mr5496251qvb.64.1712425694576;
        Sat, 06 Apr 2024 10:48:14 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id v11-20020a0ccd8b000000b006961d023d2fsm1604696qvm.17.2024.04.06.10.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 10:48:14 -0700 (PDT)
Date: Sat, 06 Apr 2024 13:48:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <66118ade17cd9_172b6329459@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240406160825.1587913-1-edumazet@google.com>
References: <20240406160825.1587913-1-edumazet@google.com>
Subject: Re: [PATCH net-next] net: display more skb fields in skb_dump()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Print these additional fields in skb_dump()
> 
> - mac_len
> - priority
> - mark
> - alloc_cpu
> - vlan_all
> - encapsulation
> - inner_protocol
> - inner_mac_header
> - inner_network_header
> - inner_transport_header
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  net/core/skbuff.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 2a5ce6667bbb9bb70e89d47abda5daca5d16aae2..fa0d1364657e001c6668aafaf2c2a3d434980798 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1304,13 +1304,16 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
>  	has_trans = skb_transport_header_was_set(skb);
>  
>  	printk("%sskb len=%u headroom=%u headlen=%u tailroom=%u\n"
> -	       "mac=(%d,%d) net=(%d,%d) trans=%d\n"
> +	       "mac=(%d,%d) mac_len=%u net=(%d,%d) trans=%d\n"
>  	       "shinfo(txflags=%u nr_frags=%u gso(size=%hu type=%u segs=%hu))\n"
>  	       "csum(0x%x ip_summed=%u complete_sw=%u valid=%u level=%u)\n"

If touching this function, also add csum_start and csum_offset?
These are technically already present in csum, as it's a union:

        union {
                __wsum          csum;
                struct {        
                        __u16   csum_start;
                        __u16   csum_offset;
                };              
        };

But it is a bit annoying to have to do the conversion manually.
And this is a regular playground for syzbot.

> -	       "hash(0x%x sw=%u l4=%u) proto=0x%04x pkttype=%u iif=%d\n",
> +	       "hash(0x%x sw=%u l4=%u) proto=0x%04x pkttype=%u iif=%d\n"
> +	       "priority=0x%x mark=0x%x alloc_cpu=%u vlan_all=0x%x\n"
> +	       "encapsulation=%d inner(proto=0x%04x, mac=%u, net=%u, trans=%u)\n",
>  	       level, skb->len, headroom, skb_headlen(skb), tailroom,
>  	       has_mac ? skb->mac_header : -1,
>  	       has_mac ? skb_mac_header_len(skb) : -1,
> +	       skb->mac_len,
>  	       skb->network_header,
>  	       has_trans ? skb_network_header_len(skb) : -1,
>  	       has_trans ? skb->transport_header : -1,
> @@ -1319,7 +1322,10 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
>  	       skb->csum, skb->ip_summed, skb->csum_complete_sw,
>  	       skb->csum_valid, skb->csum_level,
>  	       skb->hash, skb->sw_hash, skb->l4_hash,
> -	       ntohs(skb->protocol), skb->pkt_type, skb->skb_iif);
> +	       ntohs(skb->protocol), skb->pkt_type, skb->skb_iif,
> +	       skb->priority, skb->mark, skb->alloc_cpu, skb->vlan_all,
> +	       skb->encapsulation, skb->inner_protocol, skb->inner_mac_header,
> +	       skb->inner_network_header, skb->inner_transport_header);
>  
>  	if (dev)
>  		printk("%sdev name=%s feat=%pNF\n",
> -- 
> 2.44.0.478.gd926399ef9-goog
> 



