Return-Path: <netdev+bounces-211914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CCAB1C6FA
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 15:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6793B356F
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 13:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1221928A703;
	Wed,  6 Aug 2025 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpN/B1Gi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764154279
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754487991; cv=none; b=olFLPKSbdp3YIOp101LaYjLSZ3xzAWsBvwUGVQcXHUjmC3cI7S9aexW6v6tAf4EIIjsHUBz8UZNzJpBkTBo0t0/8Yf77GE4iJHuyMg4gBYidoJF3YT/HXM77VB1+VA4D+vrXaYo6CBGDlSxZBvF7ZjepAVCiS9x3Qtzd0s2zd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754487991; c=relaxed/simple;
	bh=AJFFeD7ZnZimDBuLK+AIw/cNOVRHKcgyIvQsTMrt8qo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=C8YmNC2IW5fPJ4DQ5zNoQRGtYsF0KyhQCmAPaKzVqk5g6Eu6rADCopk9HtVSS6UCnsrX6OGUU+gOqTrzRLg+WEavWAhDFTeXOCRyqFArxsPb0KTJoSr8npXDyF11bAO607I71ndTrBMgl7DRYTMz+2dvdvW88Qkpyza2leBSm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpN/B1Gi; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b0862d2deaso17174291cf.2
        for <netdev@vger.kernel.org>; Wed, 06 Aug 2025 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754487988; x=1755092788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gA9xC+zLo/xJtv1kkmWFf7ktgXIp1yyx/7vpkYhzMM=;
        b=TpN/B1GiCmpFLMAbSZUIx2dB08TOI1hLC5aXtf+RMnt8g9ZnCPOWtKl2k2J/rToEV3
         1aavfUdmWSgFpCH9mcrelgVK5TfILUl0eBFy76LqLX1cBpiJGVg7BYc2qOBwtFrkdPy6
         BVoL7X5ZVhxUXNGP4VykSKXGUDe43FsqMkiIrVSaHdL5ZRxmQHW3UuBvKe4x0waIGtb3
         na5nCGylIu4zCv1ESQWKIEjNxSsqAwR/zeSgBOyCxUQxRa5D0Ip+T+1+odKvk3wqNFtC
         csWOfQyojGsgvWOVhkQiCbwu1U3IkpnkBVPsXnmkcTo3CL93i/uzP3HFw9j1GQnts+xw
         oJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754487988; x=1755092788;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3gA9xC+zLo/xJtv1kkmWFf7ktgXIp1yyx/7vpkYhzMM=;
        b=U/zhf5H6IuRQKHSbB4todiEOor3Hth0RbcTT6oAgzn/NWhViwstb8VskoiLOTNNtTy
         IcOGiIF2QP2tnL3Q50OdtiPpWV9h8053ksdXjVjPhwpWIwnNHLeymyvoowKrfDOu2t6a
         CpMbZoWnOSoqGtih/gXxwoQNdAoxDv9QTv2jxKxes9yz+a3WQNMRgKiKC5A1yLFJ24Aa
         5KRTtEL1rSFNtHwT/S4UbpKoH26pu0z5SqZo0RFkjgj0Zbj868++FGSSPo5h3JMdqoNx
         yAPwej1cPW0ZQbnka5cLh9y1AVT26G3BvjOyyk1nZk1E/oFYP78KeFiOCXMplZbGsHuL
         040w==
X-Forwarded-Encrypted: i=1; AJvYcCUsgo6XUnYfScUHnCQjNoumIgZUoxpAUBK9aDZ5arydz2TgaFnpZb70k0oILVqH97oXG7lQawg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbTMfGmA1lzdnp2rJFLHNt6D5bruE7LHpEQ04YwsgBW4Z74w/j
	jhgj086VC1cje0HyW+OQ5QXlgCUZpbqjfLVPbV/7japMlIXWR1GkEW3D
X-Gm-Gg: ASbGncvPjgvmm3K3OtLh9VfnMKtauVhZ1+Tm0HkQhsPeEuWaZs6RZki7d6g2q7uoUbp
	URal9OW5CEPtNAiXkD6+Lzlb922zMJUcq+t1iPslkr+hd3s9ao6c+Dm/svjJmEZl4hJAl6/K4/d
	rsuOy99gdS8e2thHNk2DbT/UB7CX9065ZOfioc4lBS0Th9PO1IzCCD+pZ7owFIqCUcJQlsTqpqD
	HRuL2NSfNJve0u+lvwgHhgShNn+H2UdyhVKHsAI3fuHdnZsK4vd+9SEbBnYdQTNNiUcn6vUYIOS
	pIJBl7ZO9CnAmfBGGckQUgpLeBzX+mXLp/Aud248HwKCK79RFMrhmuvaOoAToIKnmlOOBjLaIYn
	J/6KlQFpBEmNz2BF13LxXUeZ9d298fBzAZWB/kV4me3SZks6gHZnHVA5pU0L1tyTOlFF3tA==
X-Google-Smtp-Source: AGHT+IEED7k/UxARQ4yHtg44VUc9jeRtNKbB2QuUl8ugAzsWtzkG1UPjBXx6JFEsyjLOE1j+AB05XA==
X-Received: by 2002:a05:622a:2c5:b0:4ab:89c8:bd32 with SMTP id d75a77b69052e-4b09231965fmr42814961cf.0.1754487987997;
        Wed, 06 Aug 2025 06:46:27 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e67f72a47esm816132385a.61.2025.08.06.06.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 06:46:27 -0700 (PDT)
Date: Wed, 06 Aug 2025 09:46:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Ramaseuski <jramaseu@redhat.com>, 
 netdev@vger.kernel.org
Cc: kuba@kernel.org, 
 horms@kernel.org, 
 pabeni@redhat.com, 
 Jakub Ramaseuski <jramaseu@redhat.com>, 
 Tianhao Zhao <tizhao@redhat.com>, 
 Michal Schmidt <mschmidt@redhat.com>
Message-ID: <68935cb3b108_1576e429466@willemb.c.googlers.com.notmuch>
In-Reply-To: <6893596a9b057_1500a329471@willemb.c.googlers.com.notmuch>
References: <20250805121627.311053-1-jramaseu@redhat.com>
 <6893596a9b057_1500a329471@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net] net: mask NETIF_F_IPV6_CSUM flag on irregular packet
 header size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Jakub Ramaseuski wrote:
> > Throughput with GRE on IPv6 drops to 0 on NICs that use ice/bnxt_en
> > or any driver with NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM set and with
> > NETIF_F_HW_CSUM unset, see following dmesg output for more info.
> 
> HW_CSUM is generally not advertised if IP_CSUM and IPV6_CSUM are.
> HW_CSUM is a superset, and generally advisable. But some devices
> only support specific protocols..
> 
> The pertinent comment here is that SKB_GSO_TCPV6 cannot be segmented
> if NETIF_F_IPV6_CSUM is set

and the IPv6 packet has extension headers, I mean to add.

V> And the same for SKB_GSO_UDP_L4 if ETH_P_IPV6.
> 
> > Mask NETIF_F_IPV6_CSUM in gso_features_check if the IPv6 header contains
> > extension headers. This flag indicates that the network interface
> > is capable of computing the checksum only for plain IPv6 headers
> > without any extension headers.
> > 
> > The exception is a BIG TCP extension, which, as stated in 68e068cabd2c6c53:
> > "The feature is only enabled on devices that support BIG TCP TSO.
> > The header is only present for PF_PACKET taps like tcpdump,
> > and not transmitted by physical devices."
> > 
> > Fixes: 04c20a9356f283da ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")
> 
> That fix is still a valid fix to fall back onto software checksum
> offload for non GSO packets.
> 
> This fix addresses the same for GSO packets.
> 
> That fix is not wrong, and still needed (this patch also does not modify or remove its code).

The question is what the right tag.

Your code also shows a tunnel, but not the one implicated on the above patch:

    Fixes: aa3463d65e7b ("fou: Add encap ops for IPv6 tunnels")

But conceivably this is not tunnel related at all, if any TSO6 traffic can
cause IPv6 extension headers to be present.

Minor: when respinning please put this brief explanation first, and
the log output (stack trace, skb_dump), second.
 
> > Reported-by: Tianhao Zhao <tizhao@redhat.com>
> > Suggested-by: Michal Schmidt <mschmidt@redhat.com>
> > Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
> > ---
> > ---
> >  net/core/dev.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index b28ce68830b2b..118c433c2cb9b 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3778,6 +3778,10 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
> >  		if (!(iph->frag_off & htons(IP_DF)))
> >  			features &= ~NETIF_F_TSO_MANGLEID;
> >  	}
> > +	if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
> > +		skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
> > +		!ipv6_has_hopopt_jumbo(skb))
> > +		features &= ~NETIF_F_IPV6_CSUM;
> 
> Exit the branch as soon as possible. Avoid the Ethernet header lookup
> if possible.
> 
> And unfortunately transport header cannot be guaranted with
> virtio_net_hdr_to_skb.
> 
>          /* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
>           * so neither does TSO that depends on it.
>           */
>          if (features & NETIF_F_IPV6_CSUM &&
>              (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
>               (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> 	       vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
>               skb_transport_header_was_set(skb) &&
>               skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
>               !ipv6_has_hopopt_jumbo(skb))
>                  features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
> 
> 
> >  	return features;
> >  }
> > -- 
> > 2.50.1
> > 
> 
> 



