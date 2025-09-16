Return-Path: <netdev+bounces-223291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD2AB58995
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DAC1899DB0
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1968519EEC2;
	Tue, 16 Sep 2025 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcu/LODr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6231A13D521
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982779; cv=none; b=ExaDJzd0JSqnFk+o0jAXbKSexzdBeUaaAzND2+DzaTXyCWt6sLZK/ZL5KB99wVoz0FcLluHZ9MY2ZcINKQrMWvidVUdsyerouPFqC/IsGMxdC25xLb2Fn7R1U9HbJlZqTPDzC9jrSUTv7JH4lDjY3mXiuWullOdar9fkF7Fd6uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982779; c=relaxed/simple;
	bh=H/DVaXzoxcFzLSBp3bmejd4XBPWWM0Rk1MFhKzvuDiY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SwvQyRq9LsLeXBkaSigwwGjViwhAyZkswhRQUAIEFRq8oEtC0QYoCIVVNp3jDwBmjdKVC+kSXY7yyzIHC9NhVU9elvQLrYvMTAwPNw2fExsLaUu+OzkL79zj+vezw+gk0e83dOXwz4IpQB+71OeQYjpmaw/+kPnKESNCnUNa2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcu/LODr; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-781fbbad816so11776386d6.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757982776; x=1758587576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r12V2PoKHZmPaH2sw9C5YGo3JgG0KLZK8dsUu+0xYo=;
        b=kcu/LODr0KKea8Eok2ilwc3S7wwvx64nkOa/NprsHF3V6xbVe24CRjl63plt+Nv+e1
         k430JTWh8H4GGaMvb9ajJkoV7n18TPT5uKHCPJHsXzc7MhyWAgXqYqkiEhT8zpQtWT9m
         nEDLn14uslGVGrYAxnyV6TPJthP5DYIex2TOrpeYgkFY4mGgW0CotawErOVlhbawCye6
         5A+/nbYXqgDpMa0qPCaeeWWXErtQrXO71dUoXtSKY7brSszzgzdOGGBdo4wIsBa0RHkY
         3MNMDdrKo6AP6Evfvv7utb/NhAwcab+342b992rm+ajJS08WfaCw5pP6xNNTDlJjM0FQ
         xkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982776; x=1758587576;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4r12V2PoKHZmPaH2sw9C5YGo3JgG0KLZK8dsUu+0xYo=;
        b=RJ3zD/hBKh7f1MEXgOBSMRvu9krygn15for5sW/dZuW7w4cNhC/voFYnW+gJTLEb+u
         ucyFvJWAUcYlCgeMlBVtcsKw1n3xFZNcOpyGqtFVBPIdOVMw2CgvuM8QF+QMk8ZXXwwx
         gswBPDqXC+LyHnZnHPDW8CDMSAhCNDXYdwWalZoqpyy0IQE6ZklB2rwFtibMCJDtCB2M
         Yef7fRcSzn0TQ0Nif7Jp3MdtYDUE/rp2oz9+Rm+cAGaLGXaNL25450rIDxs9UitEEOg2
         5Zaa+K3ThuCF7o+VFNE6HuYJX66rMljqDZkp6nF2Fv1XqzqNOyu8SU/MsBkcyMivu01j
         F4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgYROs/Xw3yGcwWRNcDiOZAKWQBOKQBQ8MR2SjruXT34c8HtLpzsa6eCTT9RMmnLbkLDqrn1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOjx74eN+7wlaBzyiJwHYqfuG+q2jaj/x1+vjIiv4G9U4K1puZ
	jozYJaLHe4MfxEDDqeUTvSXqEhQDq6xdoiFndRhJ/x8oMP4J3tB6j4uH
X-Gm-Gg: ASbGncv+Bhc/mw8wvO6U4Wd3Q3vKGzVd8B8WR7HWZv5AL0TDLWScj1HznTN+GKlAP0p
	hvL849A/kSLaW5YbxUGYWvWnvlJ0OqdDiV/2a76zEmBh2hmdlMCS4q5ZGEoXdW653U/XVSjnt10
	6vhWdtmKNPshjZGmQYNlCM9xUK6Fu1syvua1letcBHfSfs5/xygrcXaPAA3+Ee4Zku7VE0kyXdq
	o6U1ubmSg9NmwAcQVi0gK9JUmMeqmaYaxUR2FJ7+I3fICD26TLWdumAYmWTPDqPrr7LtmYMrUYw
	AfINP4V67aAnUizN59esLJI2WrM+HwrKtAD6H0Y4GBsLuallBLShc45Flbc2EEoa85TNA7LpYvZ
	nF6UU3EpeUZx6YOhdIS9LCHV9+Rnn8Gc4bhFg9KWWWcyO0QSIJklw5/0hz5Uv3N75YZGXH631/G
	8lRg==
X-Google-Smtp-Source: AGHT+IH1M0sijyP+94ZdZqgyXYx7IsKtO5xYHyE5Jb5WJ71L1gBlS5xl+86mFGCqvmvr4JiXj97CiQ==
X-Received: by 2002:ad4:5942:0:b0:764:c753:c57e with SMTP id 6a1803df08f44-767c5aeeca1mr160391206d6.64.1757982776117;
        Mon, 15 Sep 2025 17:32:56 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-763c03a7fa1sm84738776d6.59.2025.09.15.17.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:32:55 -0700 (PDT)
Date: Mon, 15 Sep 2025 20:32:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com, 
 willemdebruijn.kernel@gmail.com
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
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.d5fd7a312fe9@gmail.com>
In-Reply-To: <20250915113933.3293-5-richardbgobert@gmail.com>
References: <20250915113933.3293-1-richardbgobert@gmail.com>
 <20250915113933.3293-5-richardbgobert@gmail.com>
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
> Currently, packets with fixed IDs will be merged only if their
> don't-fragment bit is set. This restriction is unnecessary since packets
> without the don't-fragment bit will be forwarded as-is even if they were
> merged together.

Please expand why this is true.

Because either NETIF_F_TSO_MANGLEID is set or segmentation
falls back onto software GSO which handles the two FIXEDID
variants correctly now, I guess?

> If packets are merged together and then fragmented, they will first be
> re-split into segments before being further fragmented, so the behavior
> is identical whether or not the packets were first merged together.

I don't follow this scenario. Fragmentation of a GSO packet after GRO
and before GSO?

> Clean up the code by removing the unnecessary don't-fragment checks.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/gro.h                 | 5 ++---
>  net/ipv4/af_inet.c                | 3 ---
>  tools/testing/selftests/net/gro.c | 9 ++++-----
>  3 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/gro.h b/include/net/gro.h
> index 6aa563eec3d0..f14b7e88dbef 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -448,17 +448,16 @@ static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *ip
>  	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
>  	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
>  	const u16 count = NAPI_GRO_CB(p)->count;
> -	const u32 df = id & IP_DF;
>  
>  	/* All fields must match except length and checksum. */
> -	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
> +	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | ((id ^ id2) & IP_DF))
>  		return true;
>  
>  	/* When we receive our second frame we can make a decision on if we
>  	 * continue this flow as an atomic flow with a fixed ID or if we use
>  	 * an incrementing ID.
>  	 */
> -	if (count == 1 && df && !ipid_offset)
> +	if (count == 1 && !ipid_offset)
>  		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
>  
>  	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index fc7a6955fa0a..c0542d9187e2 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1393,10 +1393,7 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
>  
>  	segs = ERR_PTR(-EPROTONOSUPPORT);
>  
> -	/* fixed ID is invalid if DF bit is not set */
>  	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
> -	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
> -		goto out;
>  
>  	if (!skb->encapsulation || encap)
>  		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> index d5824eadea10..3d4a82a2607c 100644
> --- a/tools/testing/selftests/net/gro.c
> +++ b/tools/testing/selftests/net/gro.c
> @@ -670,7 +670,7 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
>  		iph2->id = htons(9);
>  		break;
>  
> -	case 3: /* DF=0, Fixed - should not coalesce */
> +	case 3: /* DF=0, Fixed - should coalesce */
>  		iph1->frag_off &= ~htons(IP_DF);
>  		iph1->id = htons(8);
>  
> @@ -1188,10 +1188,9 @@ static void gro_receiver(void)
>  			correct_payload[0] = PAYLOAD_LEN * 2;
>  			check_recv_pkts(rxfd, correct_payload, 1);
>  
> -			printf("DF=0, Fixed - should not coalesce: ");
> -			correct_payload[0] = PAYLOAD_LEN;
> -			correct_payload[1] = PAYLOAD_LEN;
> -			check_recv_pkts(rxfd, correct_payload, 2);
> +			printf("DF=0, Fixed - should coalesce: ");
> +			correct_payload[0] = PAYLOAD_LEN * 2;
> +			check_recv_pkts(rxfd, correct_payload, 1);
>  
>  			printf("DF=1, 2 Incrementing and one fixed - should coalesce only first 2 packets: ");
>  			correct_payload[0] = PAYLOAD_LEN * 2;
> -- 
> 2.36.1
> 



