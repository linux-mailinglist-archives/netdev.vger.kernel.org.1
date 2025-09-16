Return-Path: <netdev+bounces-223641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43B1B59CB0
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6661B235C9
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF78A21578D;
	Tue, 16 Sep 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0KhIQ4M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1895A2E8B95
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038250; cv=none; b=G9Z5WRJGUP5vWfQHm3m93i49qCjhyEltvaUceBItsrzRkxUuiyLBJxljpSjVB3S15xfCT26mOa0ja4NeZUy3/sTGNldgK7pCP3vD4DAhnlOLYcMduujKZsuSpGP1vmI8+C6hYa3G+wD4sgM5E5BF7cRtNLrI6N4lUBcAYh8MOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038250; c=relaxed/simple;
	bh=XVY1KPWzJ/YGZWIZ1wzyfJJiEKD3gbCAYAId4zKeaqA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=doy/F9Ph4fjLx4DC/bDc1VJLO2HsamR7e/Ebq7dNLGxMJMB02/VEBa05FwB3TglAiLmow8+3+nWF5DMHvQthQ5Wot5uEvzEIT2EQqn+mh1QB6Gxq6To0Kdgjdpr64tQUZpBnqKYohAHGvnoxmVmFmLviG6eFuYyvHfzlIlFHKgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0KhIQ4M; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8112c7d196eso595617385a.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038248; x=1758643048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Wd2MJRnYQ7MsJqmQ1xoFKuUpX1v3JB2kIz+Wo1AJiQ=;
        b=a0KhIQ4MrOIA+sD8SktR/Fp1VJ3qra253/3FEJr4MmN+8le+i+MuUwMjeLi+iacyEn
         TyQ3qOezT1h91I9rRIbxS4gYb1SyUUes3d8D3ZeJ4gRkITgHkjUFtDhZdQg9+8YcnAj9
         rOJR2+dj2Xefaz48dsgOmXpUqqT/+Yrei/ZPVdsJBCcyrUag6PnFTzXpCu1buQwfJYqA
         yfPdhLUaJo9UdhZKmGF8u5gUz27XkEjSTvN+9E/HLl/RLMBcrRTyBaEvzwhtr8N/hfIC
         8lpXEpO7R7Q17YEVtCpNwBm1vnEoZLK9n4bycSVDYwbB4AtCBA5THoSqfXLMAun1ulVq
         I5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038248; x=1758643048;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Wd2MJRnYQ7MsJqmQ1xoFKuUpX1v3JB2kIz+Wo1AJiQ=;
        b=pG+JG6Gowkhj8gguHHM3Zb1WjGSlprYg4fYlnxaM58u02jTaPikusaVn3O2sCgb/Zn
         /7fmpN6yDz8FwrTF+nC6ixYMnlvkylB5J0QOMreKfugnlW7yTCWsMH7iXkjw0qZLs2aI
         O3qh9oti1lg52OqGMyQBefBxEB2N5A8ZWRpc3/NpRN/ERHDMXmc6J1GZTf3IOaP4nAAj
         XlaMTN86Cm7o3Wi5/kDcyWhzaAnz5T6Fu624pN5Ywa++6/XTeZFg2XXKM7StkZVgIXnr
         yrTESFEhGmwAeI/szYLUfZ4eLQDYLHI7wyjoTidD4VIvu8PtbOBqENKyTvml7JIPC4CE
         5A5A==
X-Forwarded-Encrypted: i=1; AJvYcCWg5mQjEaTEBON4xHJ95g/mh3YNK/Bp1vxJUYPHWG9I+uERAe1bMUB1kR7K8GZ7Mql3xr0mKlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBAamCxcd9d2V7pLoyd1kakfXFKpWyFVeDkqGZUdDnVABudPpi
	MqS998tIREUC35AfysCxBa4Y1RxsGOZ3EK3fgL9B6j6+MUJ7lt+KyXDN
X-Gm-Gg: ASbGnctnezckJwIqMq5ZO1FfAIRrsuLwAyziq50qFYzuvs89RrQdhRLC8y944KM/XMt
	yBgjZXSoB1LlE3BDyC2KJMyW/1zieMq4dP4D4bQsqH2TOoAagGJbAZGEXokyJHDRgEETiXOTj6U
	FLgJm+4Nz988eVuUdScDyBeUjAZ320Wbg/zsozoWjRsl6EiDXgAq3ybQlGxFHAw5mm8mhc4U3oG
	Z/w3dmEkc4gntJupv6mhJ1ENBceAnF8CqlSTFQAG5z/uHNVny/vB8kg0umwDh+2t17aT23+DQTO
	BP2qfhjG25I5DWH7GBGWdAC7WxS+rl5jo07Y4yCQ132ZTQ+JNQK7LI65Z8xQn4wHE0MTvk3Pk0Q
	L+XxXB8iH15pX3gEdHIMHXVXMCqNCd/QMxUegr+W0tTZ+gGHDFXpA3+PHPyp8afWxGGFzqNqWJz
	qCIw==
X-Google-Smtp-Source: AGHT+IErkEmH2qweZbpoDH0eSCZcXupsbTMzDfQwVn/43HSM7sskhY8O/6av8pU8QmfW7VI+ZOpgPg==
X-Received: by 2002:a05:620a:a093:b0:81f:eb9f:86de with SMTP id af79cd13be357-82400944ad6mr1715608985a.47.1758038247603;
        Tue, 16 Sep 2025 08:57:27 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639dab3e8sm84155821cf.24.2025.09.16.08.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:57:27 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:57:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com
Message-ID: <willemdebruijn.kernel.1fa5cf297a68d@gmail.com>
In-Reply-To: <4b2c5770-ab53-43f6-8c68-7e2f4a912d8e@gmail.com>
References: <20250915113933.3293-1-richardbgobert@gmail.com>
 <20250915113933.3293-5-richardbgobert@gmail.com>
 <willemdebruijn.kernel.d5fd7a312fe9@gmail.com>
 <4b2c5770-ab53-43f6-8c68-7e2f4a912d8e@gmail.com>
Subject: Re: [PATCH net-next v5 4/5] net: gro: remove unnecessary df checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Willem de Bruijn wrote:
> > Richard Gobert wrote:
> >> Currently, packets with fixed IDs will be merged only if their
> >> don't-fragment bit is set. This restriction is unnecessary since packets
> >> without the don't-fragment bit will be forwarded as-is even if they were
> >> merged together.
> > 
> > Please expand why this is true.
> > 
> > Because either NETIF_F_TSO_MANGLEID is set or segmentation
> > falls back onto software GSO which handles the two FIXEDID
> > variants correctly now, I guess?
> > 
> 
> This is true because the merged packets will be segmented back to
> their original forms before being forwarded. As you already said, the IDs
> will either stay identical or potentially become incrementing if MANGLEID
> is set, either of which is fine.
> 
> >> If packets are merged together and then fragmented, they will first be
> >> re-split into segments before being further fragmented, so the behavior
> >> is identical whether or not the packets were first merged together.
> > 
> > I don't follow this scenario. Fragmentation of a GSO packet after GRO
> > and before GSO?
> > 
> 
> Yes. One could worry that merging packets with the same ID but without DF
> would cause issues if they are then fragmented by the host. What I'm saying
> is that if such packets are merged and then fragmented, they will first be
> segmented back to their original forms by GSO before being further fragmented
> (see ip_finish_output_gso). The fragmentation occurs as if the packets were
> never merged to begin with.

This explicit pointer that fragmentation for such GSO packets happens
in ip_finish_output_gso, which first calls skb_gso_segment, is
informative. It again turns an assertion into an explanation.

I think you jumped the gun a bit on sending a v6 right with these
answers. I'd like these clarifications recorded.

> IOW, fragmentation occurs the same way regardless
> of whether the packets were merged (GRO + GSO is transparent). I thought I'd
> mention this to clarify why this patch doesn't cause any issues.
> 
> >> Clean up the code by removing the unnecessary don't-fragment checks.
> >>
> >> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> >> ---
> >>  include/net/gro.h                 | 5 ++---
> >>  net/ipv4/af_inet.c                | 3 ---
> >>  tools/testing/selftests/net/gro.c | 9 ++++-----
> >>  3 files changed, 6 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/include/net/gro.h b/include/net/gro.h
> >> index 6aa563eec3d0..f14b7e88dbef 100644
> >> --- a/include/net/gro.h
> >> +++ b/include/net/gro.h
> >> @@ -448,17 +448,16 @@ static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *ip
> >>  	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
> >>  	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
> >>  	const u16 count = NAPI_GRO_CB(p)->count;
> >> -	const u32 df = id & IP_DF;
> >>  
> >>  	/* All fields must match except length and checksum. */
> >> -	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
> >> +	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | ((id ^ id2) & IP_DF))
> >>  		return true;
> >>  
> >>  	/* When we receive our second frame we can make a decision on if we
> >>  	 * continue this flow as an atomic flow with a fixed ID or if we use
> >>  	 * an incrementing ID.
> >>  	 */
> >> -	if (count == 1 && df && !ipid_offset)
> >> +	if (count == 1 && !ipid_offset)
> >>  		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
> >>  
> >>  	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
> >> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> >> index fc7a6955fa0a..c0542d9187e2 100644
> >> --- a/net/ipv4/af_inet.c
> >> +++ b/net/ipv4/af_inet.c
> >> @@ -1393,10 +1393,7 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
> >>  
> >>  	segs = ERR_PTR(-EPROTONOSUPPORT);
> >>  
> >> -	/* fixed ID is invalid if DF bit is not set */
> >>  	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
> >> -	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
> >> -		goto out;
> >>  
> >>  	if (!skb->encapsulation || encap)
> >>  		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
> >> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> >> index d5824eadea10..3d4a82a2607c 100644
> >> --- a/tools/testing/selftests/net/gro.c
> >> +++ b/tools/testing/selftests/net/gro.c
> >> @@ -670,7 +670,7 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
> >>  		iph2->id = htons(9);
> >>  		break;
> >>  
> >> -	case 3: /* DF=0, Fixed - should not coalesce */
> >> +	case 3: /* DF=0, Fixed - should coalesce */
> >>  		iph1->frag_off &= ~htons(IP_DF);
> >>  		iph1->id = htons(8);
> >>  
> >> @@ -1188,10 +1188,9 @@ static void gro_receiver(void)
> >>  			correct_payload[0] = PAYLOAD_LEN * 2;
> >>  			check_recv_pkts(rxfd, correct_payload, 1);
> >>  
> >> -			printf("DF=0, Fixed - should not coalesce: ");
> >> -			correct_payload[0] = PAYLOAD_LEN;
> >> -			correct_payload[1] = PAYLOAD_LEN;
> >> -			check_recv_pkts(rxfd, correct_payload, 2);
> >> +			printf("DF=0, Fixed - should coalesce: ");
> >> +			correct_payload[0] = PAYLOAD_LEN * 2;
> >> +			check_recv_pkts(rxfd, correct_payload, 1);
> >>  
> >>  			printf("DF=1, 2 Incrementing and one fixed - should coalesce only first 2 packets: ");
> >>  			correct_payload[0] = PAYLOAD_LEN * 2;
> >> -- 
> >> 2.36.1
> >>
> > 
> > 
> 



