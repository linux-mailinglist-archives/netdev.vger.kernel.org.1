Return-Path: <netdev+bounces-119292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A3F955135
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA401C22579
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925D11C0DE1;
	Fri, 16 Aug 2024 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l40EEdB4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05E28FF
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835392; cv=none; b=C5RFaPuXtzJq5c45APH04kxgZpphBIVfaR8XIwYyBK4AdGg07Tuawo6QLATsEf3MhQ4yia5/yDSeswVegxhNyP+30l/yLccwWIo3wJm85r2c1gKtw28ZZ1Zzpb5KZNzPWWQImy3skT+jXi+fviPnAlr69+d3Zw3co08zYTQsWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835392; c=relaxed/simple;
	bh=dq2bKSvm9GcC9N+19BkW351404sXfcCVwau6zaDRfzg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=M/IDGZLjZSaMRodFJZuxDdUWJifE3++UuiDwIRqmEUEJyeoClAWp/VO7N2h+Z9F/+0sEnb8zrA7VnlKF8qUr0KU4C3kLkvbiABSP2O5iQZZp8Gfr+zq60KZIGWIT8fL0RsI9Xul2M9B0xhPtu8LgKPafowL1eWGhM4+3Wsn3cUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l40EEdB4; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fe9cf83c7so12432401cf.0
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723835390; x=1724440190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1izYPC9P8V8hRLa0CcRW7Dp2hST6lzTER3Qj7HuFv+8=;
        b=l40EEdB4C9qQ+myW4biP/smcADOi42q3osKlaWIrOriYSe9NSH8+fvBaqR8kiKvh2K
         8Z+xVqW8XyWp1JNqQfA9OsvesR9rirWP56j+VubY1Y1w9kzFhCp8r4g8HDru6lsF9Tag
         0oZqC9Iepe1Pe1x5A8EaPLZFZjuBkd8CsaqC6DUkdjxb+RMztkjbkz9LjIU0DTcAwExC
         90DBU8VETmWVI40qc2fu2JeBBhB9zVW95IZqMWnlXrys3O3i2iM7tE2pT9boPRKRUbGn
         oVkfP6LqIFsvuP17rwa0jb9BGE+hB9eAiXZadnPiALjnz2bgMTrdqBGkGyiMeSkFzFxK
         ZgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723835390; x=1724440190;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1izYPC9P8V8hRLa0CcRW7Dp2hST6lzTER3Qj7HuFv+8=;
        b=deQUrpxusqoH1UJaFJYRrxjEWLR1S0+v2f6K8ZtYZxdjTkLO4ezYeSOlCQ+mGL+k97
         p2IUwBLjPIfWijZzaryCgWD7L+hZgcg5vFUxLgHfWBDA6Q/tEpFmDYU8xfAEA/gxohY2
         fYebIlhu8hdnqJgcS+ykODHs4EarenHBic55saffmPkzwBREArGFuANrrlOISgotUCdb
         3zxnzgfpa6VsPnD3hY5GoY5WDf5I+n5o96ZCQhhlukdXg3nxoQWsNWhMvDyTO70ZnpA9
         3aPzqT5xXoZPol9YfohvW0CdCUWsC/AqwAVhZO+FuFE3tYYiALklm9tO9PFn+nalAjOY
         GhNA==
X-Forwarded-Encrypted: i=1; AJvYcCWyBBD+h7Fxe6D6lf6hR6zd5Kliwzrm9TOIOI4fEuO1IYMtzL/Iwdw8UomIOQbXd0wcyfeWLfk2btmTfblxwCJPxgxNXkd/
X-Gm-Message-State: AOJu0YyjipWBGH2PihF8BjglDM/2SeYj6SOQvmS/UtfZyXmWkWZhGf1S
	o+ENqJtB3uFDZYGws2a9N0exL89gKqiWPwyY67Cgph62Al7zVgx6
X-Google-Smtp-Source: AGHT+IGAoUUWuIAFGXFjZHPYOdUW/NCMEUT4O78Q+ZU2lHtaKcex3jp5WH4jOKXkXGhU4vIGNKmgjg==
X-Received: by 2002:a05:622a:5e16:b0:453:4b61:7e3e with SMTP id d75a77b69052e-453741b54e9mr47261671cf.1.1723835389635;
        Fri, 16 Aug 2024 12:09:49 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd9e9bsm19491651cf.13.2024.08.16.12.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:09:49 -0700 (PDT)
Date: Fri, 16 Aug 2024 15:09:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io, 
 willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66bfa3fc590da_184d66294a7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240815214527.2100137-5-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
 <20240815214527.2100137-5-tom@herbertland.com>
Subject: Re: [PATCH net-next v2 04/12] flow_dissector: UDP encap
 infrastructure
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
>  net/core/flow_dissector.c    | 121 +++++++++++++++++++++++++++++++++++
>  2 files changed, 122 insertions(+)
> 
> diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
> index ced79dc8e856..8a868a88a6f1 100644
> --- a/include/net/flow_dissector.h
> +++ b/include/net/flow_dissector.h
> @@ -384,6 +384,7 @@ enum flow_dissector_key_id {
>  #define FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL	BIT(1)
>  #define FLOW_DISSECTOR_F_STOP_AT_ENCAP		BIT(2)
>  #define FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP	BIT(3)
> +#define FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS	BIT(4)
>  
>  struct flow_dissector_key {
>  	enum flow_dissector_key_id key_id;
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 4b116119086a..160801b83d54 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -13,6 +13,7 @@
>  #include <net/gre.h>
>  #include <net/pptp.h>
>  #include <net/tipc.h>
> +#include <net/udp.h>
>  #include <linux/igmp.h>
>  #include <linux/icmp.h>
>  #include <linux/sctp.h>
> @@ -806,6 +807,117 @@ __skb_flow_dissect_batadv(const struct sk_buff *skb,
>  	return FLOW_DISSECT_RET_PROTO_AGAIN;
>  }
>  
> +static enum flow_dissect_ret
> +__skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
> +		       struct flow_dissector *flow_dissector,
> +		       void *target_container, const void *data,
> +		       int *p_nhoff, int hlen, __be16 *p_proto,
> +		       u8 *p_ip_proto, int base_nhoff, unsigned int flags)
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
> +		iph = __skb_header_pointer(skb, base_nhoff, sizeof(_iph), data,
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
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case htons(ETH_P_IPV6): {
> +		const struct ipv6hdr *iph;
> +		struct ipv6hdr _iph;
> +
> +		if (!likely(ipv6_bpf_stub))
> +			return FLOW_DISSECT_RET_OUT_GOOD;
> +
> +		iph = __skb_header_pointer(skb, base_nhoff, sizeof(_iph), data,
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
> +		sk = ipv6_bpf_stub->udp6_lib_lookup(net,

Should this use ipv6_stub?
> +				&iph->saddr, udph->source,
> +				&iph->daddr, udph->dest,
> +				inet_iif(skb), inet_sdif(skb),
> +				net->ipv4.udp_table, NULL);
> +
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
> +#endif /* CONFIG_IPV6 */
> +	default:
> +		return FLOW_DISSECT_RET_OUT_GOOD;
> +	}
> +
> +	nhoff = *p_nhoff + sizeof(struct udphdr);

maybe sizeof(_udph) for consistency

> +	ret = FLOW_DISSECT_RET_OUT_GOOD;
> +
> +	switch (encap_type) {
> +	default:
> +		break;
> +	}
> +
> +	switch (ret) {
> +	case FLOW_DISSECT_RET_PROTO_AGAIN:
> +		*p_ip_proto = 0;
> +		fallthrough;
> +	case FLOW_DISSECT_RET_IPPROTO_AGAIN:
> +		*p_nhoff = nhoff;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +

