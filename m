Return-Path: <netdev+bounces-114986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69567944D87
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5E31C24F7C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763201A38E7;
	Thu,  1 Aug 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0nyEMOL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54921A3BC3
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520733; cv=none; b=AcFc8ORRNpmTCuVs7jZQYeNmMHwwBbMW01kOLMUU8rnUFGjqppSGfxxBr+kyO1l8KiLJ5cvb13G+OBAkpUiQB9yvULm9z/Kg4y05YVZGVIUqZfp/ap05p+CimoAeE6ktgV5YHxxmEI3S0d5e60f8x/psjB1/7KHmioUzuBJ8bVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520733; c=relaxed/simple;
	bh=+fCp3AqhHIQNw6n+OpXv3H19V5qoCyOWWFKpMb3BxPc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nbopZdHUyfKzZvMlPJZ8YJI7EwzSS1aopWVf58ww6xU/VouTltjro+Rqcwu5ylpZ6Y7m1kyXCuzY0X3qKHTNhnzQSiy0Li27sZkV/65kaALq82mCusPDHVKdDs+kA9Ie2RTWzj2Hj1NJSUqCE1kIUeQ1v2qZFaP8Q5ZwGXpPZms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0nyEMOL; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-709428a9469so3806596a34.3
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722520731; x=1723125531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4Qh/dMUTBaCwn68jbX3SvQdsVX6xFjJlcYBjfmZudw=;
        b=Z0nyEMOLVbHbAB/EBwsYZeGsdPxsp52QduzgAJ7+TNm/mNK+IbBdoIFu9pvOZrnacg
         u0cGAU4G7i+FYIsDmysHI19J6Ib5duC/NTeyhWLQhhS8rLhT7S6+BfokLe0Vdc7Qe/SI
         RMAorqJbVSPKGdpqx90mRhlHxKB4fh+ACqJXNLBYGDy5NCfGHyu1Fa9lnOJkyFUaI3rg
         Vm6H20zW9+x+LtgGQhTGkNGMJWgS/AWrMvR2Lyj1drl+a9EY0sVyAL3duRwu80xasCnR
         FF5Urj5VSDbjbPLAZ8ehYxkZd8BjelpAOmi3nf6xWk+SBYgYVN9JkSD5+zWaTrLAC/Zn
         xzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722520731; x=1723125531;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F4Qh/dMUTBaCwn68jbX3SvQdsVX6xFjJlcYBjfmZudw=;
        b=eOwOxAKlDzSqYxoAiBbLf/FeaCa7K9FEGen89uvWE/5rKDyBeq6NURT/41jubtz5Ni
         YzBX6M9gwwO1jOtJGxLB5LBIaZaJxOaXkMIFvs7RQ7kR97y7jNtmiMtWuMJY8aHRNUYR
         +xRTpFOSiZMwOLUk1qSmSoH2lT1NZcqfgEKAijx5AaCdCJMqkv5AlnhhsCT/wEqc1vza
         cxiovxBzHWPAUGDbuGImwyFfpOB9xC3y/0QttRuN4/LraYoZwkEWVyHcEdpM23jMRcmu
         WUmwDAV0MIk4EJus5yzqoy9psXHVKscTnKeVVbubWHRcVWAV2AuTg3Spl9S5jPtbmsXr
         Dezg==
X-Forwarded-Encrypted: i=1; AJvYcCUDPDNow5SP2+GnrfBfYIySxlYNDf6PfPzz/8Ny946fk6EmwEjtcAd/nKnxSvYE+W/lAybSWoOp4ZnJrGJaXQEadGVraozk
X-Gm-Message-State: AOJu0Yz1wOtaKEKzMTeuTWPbC7NaBIUPQ/+eESdHuZvTK/E7/yKf5Bij
	SfyMj1+6okhKXNGwUvUz5h1BUjVfv4c8+uwFxNev6B+lxoalFQRi
X-Google-Smtp-Source: AGHT+IHeQgoihlsGXQfVMAviwl1d30DiELyDldOmzVi3hynZf0C+osNfyHgqQ8XvOJc94qQNLzYf2Q==
X-Received: by 2002:a05:6358:7203:b0:1ac:ee25:ea12 with SMTP id e5c5f4694b2df-1af3b9fd316mr8599155d.6.1722520730475;
        Thu, 01 Aug 2024 06:58:50 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb79e5600bsm27549826d6.33.2024.08.01.06.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:58:49 -0700 (PDT)
Date: Thu, 01 Aug 2024 09:58:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66ab94992d011_2441da29429@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240731172332.683815-7-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
 <20240731172332.683815-7-tom@herbertland.com>
Subject: Re: [PATCH 06/12] flow_dissector: UDP encap infrastructure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> Add infrastructure for parsing into UDP encapsulations
> 
> Add function __skb_flow_dissect_udp that is called for IPPROTO_UDP.
> The flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS enables parsing of UDP
> encapsulations. If the flag is set when parsing a UDP packet then
> a socket lookup is performed. The offset of the base network header,
> either an IPv4 or IPv6 header, is tracked and passed to
> __skb_flow_dissect_udp so that it can perform the socket lookup
> 
> If a socket is found and it's for a UDP encapsulation (encap_type is
> set in the UDP socket) then a switch is performed on the encap_type
> value (cases are UDP_ENCAP_* values)
> 
> An encapsulated packet in UDP can either be indicated by an
> EtherType or IP protocol. The processing for dissecting a UDP encap
> protocol returns a flow dissector return code. If
> FLOW_DISSECT_RET_PROTO_AGAIN or FLOW_DISSECT_RET_IPPROTO_AGAIN is
> returned then the corresponding  encapsulated protocol is dissected.
> The nhoff is set to point to the header to process.  In the case
> FLOW_DISSECT_RET_PROTO_AGAIN the EtherType protocol is returned and
> the IP protocol is set to zero. In the case of
> FLOW_DISSECT_RET_IPPROTO_AGAIN, the IP protocol is returned and
> the EtherType protocol is returned unchanged
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  include/net/flow_dissector.h |   1 +
>  net/core/flow_dissector.c    | 114 +++++++++++++++++++++++++++++++++++
>  2 files changed, 115 insertions(+)
> 

> +static enum flow_dissect_ret
> +__skb_flow_dissect_udp(const struct sk_buff *skb, struct net *net,
> +		       struct flow_dissector *flow_dissector,
> +		       void *target_container, const void *data,
> +		       int *p_nhoff, int hlen, __be16 *p_proto,
> +		       u8 *p_ip_proto, int bpoff, unsigned int flags)
> +{
> +	enum flow_dissect_ret ret;
> +	const struct udphdr *udph;
> +	struct udphdr _udph;
> +	struct sock *sk;
> +	__u8 encap_type;
> +	int nhoff;
> +
> +	if (!(flags & FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS))
> +		return FLOW_DISSECT_RET_OUT_GOOD;
> +
> +	switch (*p_proto) {
> +	case htons(ETH_P_IP): {
> +		const struct iphdr *iph;
> +		struct iphdr _iph;
> +
> +		iph = __skb_header_pointer(skb, bpoff, sizeof(_iph), data,
> +					   hlen, &_iph);
> +		if (!iph)
> +			return FLOW_DISSECT_RET_OUT_BAD;
> +
> +		udph = __skb_header_pointer(skb, *p_nhoff, sizeof(_udph), data,
> +					    hlen, &_udph);
> +		if (!udph)
> +			return FLOW_DISSECT_RET_OUT_BAD;
> +
> +		rcu_read_lock();
> +		/* Look up the UDPv4 socket and get the encap_type */
> +		sk = __udp4_lib_lookup(net, iph->saddr, udph->source,
> +				       iph->daddr, udph->dest,
> +				       inet_iif(skb), inet_sdif(skb),
> +				       net->ipv4.udp_table, NULL);
> +		if (!sk || !udp_sk(sk)->encap_type) {
> +			rcu_read_unlock();
> +			return FLOW_DISSECT_RET_OUT_GOOD;
> +		}
> +
> +		encap_type = udp_sk(sk)->encap_type;
> +		rcu_read_unlock();
> +
> +		break;
> +	}
> +	case htons(ETH_P_IPV6): {
> +		const struct ipv6hdr *iph;
> +		struct ipv6hdr _iph;
> +
> +		iph = __skb_header_pointer(skb, bpoff, sizeof(_iph), data,
> +					   hlen, &_iph);
> +		if (!iph)
> +			return FLOW_DISSECT_RET_OUT_BAD;
> +
> +		udph = __skb_header_pointer(skb, *p_nhoff, sizeof(_udph), data,
> +					    hlen, &_udph);
> +		if (!udph)
> +			return FLOW_DISSECT_RET_OUT_BAD;
> +
> +		rcu_read_lock();
> +		/* Look up the UDPv6 socket and get the encap_type */
> +		sk = __udp6_lib_lookup(net, &iph->saddr, udph->source,
> +				       &iph->daddr, udph->dest,
> +				       inet_iif(skb), inet_sdif(skb),
> +				       net->ipv4.udp_table, NULL);

#if IS_ENABLED(CONFIG_IPV6)

similar to net/ipv4/udp_diag.c

> +		if (!sk || !udp_sk(sk)->encap_type) {
> +			rcu_read_unlock();
> +			return FLOW_DISSECT_RET_OUT_GOOD;
> +		}
> +
> +		encap_type = udp_sk(sk)->encap_type;
> +		rcu_read_unlock();
> +
> +		break;
> +	}
> +	default:
> +		return FLOW_DISSECT_RET_OUT_GOOD;
> +	}
> +

>  static void
>  __skb_flow_dissect_tcp(const struct sk_buff *skb,
>  		       struct flow_dissector *flow_dissector,
> @@ -1046,6 +1151,7 @@ bool __skb_flow_dissect(struct net *net,
>  	int mpls_lse = 0;
>  	int num_hdrs = 0;
>  	u8 ip_proto = 0;
> +	int bpoff;

What does bp mean here?

It points to the network header off, but nhoff does not mean network
header, but next header. And now points to the udp header. Just not
sure what bp is meant to convey.

