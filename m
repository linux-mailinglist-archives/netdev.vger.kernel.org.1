Return-Path: <netdev+bounces-213784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 958D8B269B6
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3A41CC4625
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AE718FC86;
	Thu, 14 Aug 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdjPo9IH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09C13BC3F;
	Thu, 14 Aug 2025 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181830; cv=none; b=TXejvrW0poICrHfV14rE1P/fJFvzCJQFc13LQNkKupKt+ZmOtfdDuKTJUBYtabEqQACH3b8zSLvxJ8wztjLzHOAcYpbbwDs7OR6ZXRFG2s7YpJPVBBv9rE3H1FlbIU1Okp21nueSa1O+Qtzb4B8lziXISPhyh6u6Tq3Lmx4ITGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181830; c=relaxed/simple;
	bh=LsXWAgytQViZTIZEaWmt0uVAM3ROWt00H+RjYm8GNsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0N3e7QO3DotEcRW94IxP9pgYJm55ZY7iAHUWN+WLSXP0M1zNtE06Fih0ZhrGZWk/CjJshuHkIbBEZQQdGy6hds7lXEyB97zDmqkeBOe5pfzkDQyqvMbP2PgebY/XLEVgHe9gI7ayPGtyWNOKwMRus99YYZCSdNW+0TRsvMQrWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdjPo9IH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9e4193083so864998f8f.3;
        Thu, 14 Aug 2025 07:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755181827; x=1755786627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4VZ4dhb8lx/T0ENCC0MClm4qNtbOJe+rhidjzoHI/g=;
        b=YdjPo9IHPEzbFZ8A/IxyoZA499wxlGVes9wyWMebN2xmX6XDjLpurKKbCPeJshtJsD
         qGBYNwCny5gLWkEuJ1+NSfBTe/NixFOfL4Ix/O65wVYxgasMEfsE+ODQq9hjRPZNXzY6
         kkv4musmMCiT4VJ7IirvEKH+7XkVXeUsGrXEEku+9Y1FhYsHLdZdg9bjK1+nKfZiHwVu
         szwyqY8Pd5CjufsKS/55Fd9fC5FaUnoOuO1Rv5LMouvsWgxZoSgPrf3zCDLjtq90RvXe
         PTfFqgEN7JGTex3vfUTp1VHgAuh/mAcbrA/DDHuwhC6/cCPkF1Kxavb94xGxnuJfsiSN
         +ikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755181827; x=1755786627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R4VZ4dhb8lx/T0ENCC0MClm4qNtbOJe+rhidjzoHI/g=;
        b=efLTX9jl4jNjg4E5zyKIxQKA2kmO5ITic9UwuySWwETPrilEv4BzV/DtgW7OkZs0kC
         20mCTTOo8PnA1tBqUAnVKxj4RhzaePJwYuvXKQovyRnUW5wrA3GQQvVhZFmM6mZzHA3G
         xwba3iGaQilfWpjbYkfk8HLaSJXotSZGkqzSwev+lW8JaUJysdGv2oAx2l91sDIkTnmd
         Au7jnB+2+/446deS2GvY54unSOhvE4UFgEA6lOPnJjFWhhWtz8myU8BHYftbq8s9gl7U
         w6oJwKcbSclLJB8yez4b5A8PiScqhs1PDUOmZ7jRKX/fk8pj6g1o4inbLuSAPmgK0h6c
         rBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoRkG7CzCqaxKGSAVhDxVxFjXkm1aUytCwFMqq16Ti8XCzqFn376YLEUXNxbgm6/hcsq1A0as=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkqkvhsOY182BbT7e2mZbbITForj330jYZJVSkH6jurMWUCOk3
	BX0B0OS3VEXK4LJhoQsyQkdTXGxN8wvELSvSldRAKUhahNvUTqk1I1M2
X-Gm-Gg: ASbGncsdqEsrQgMvqxxHbXz7vbzln30iUB04RZKhj0F+nA+AMeRN1jc0EMsUrBrqNG7
	qsAtdBAFdJYhaVcPCRYmZBP2ENdrTU/RenSyzMmDt+nHmQCCwkZkb57gPZh2BHkfWAvypCCo2em
	7O+ol8BPQgcnqkgY2eC7ku/t5roND1VghegbRIdjNv+/NFiITdk5i11mq3Xuenoyuz9xNZ7DliG
	oRd7dsibMSyR9qMWd3g2si0BESXv76OqjXSVvpMQCjJhPUiGJlXLcJ/LtCJSDTsKDQFlhG70M50
	ggM2aLX5oG71SSvJ5anWaAFVWRS8zP2H/NEs2PaSJW5n0eq9QdXp9ZMSMVrzCxu3EyeV3rUET9Y
	79sNCVnUSrMLGc9xiMkibho3px6x30YeEGQ==
X-Google-Smtp-Source: AGHT+IHoO9EO0ro/faSxOM4wufMudvxB5C949yEnELjO1isa28kX84aJzKexM/+WqEHrFOVKc/qO6g==
X-Received: by 2002:a5d:64c3:0:b0:3b7:8b1b:a9d5 with SMTP id ffacd0b85a97d-3b9edf6f1c6mr2849436f8f.51.1755181826958;
        Thu, 14 Aug 2025 07:30:26 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6cc902sm22933885e9.7.2025.08.14.07.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:30:26 -0700 (PDT)
Message-ID: <68be885c-f3ea-48aa-91c9-673f9c67fe28@gmail.com>
Date: Thu, 14 Aug 2025 16:30:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3] net: pppoe: implement GRO/GSO support
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20250811095734.71019-1-nbd@nbd.name>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <20250811095734.71019-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> Only handles packets where the pppoe header length field matches the exact
> packet length. Significantly improves rx throughput.
> 
> When running NAT traffic through a MediaTek MT7621 devices from a host
> behind PPPoE to a host directly connected via ethernet, the TCP throughput
> that the device is able to handle improves from ~130 Mbit/s to ~630 Mbit/s,
> using fraglist GRO.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
> v2: fix compile error
> v3:
>   - increase priority value
>   - implement GSO support
>   - use INDIRECT_CALL_INET
>   - update pppoe length field
>   - remove unnecessary network_offsets update
> 
>  drivers/net/ppp/pppoe.c | 160 +++++++++++++++++++++++++++++++++++++++-
>  net/ipv4/af_inet.c      |   2 +
>  net/ipv6/ip6_offload.c  |   2 +
>  3 files changed, 163 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index 410effa42ade..a8d8eb870bce 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -77,6 +77,7 @@
>  #include <net/net_namespace.h>
>  #include <net/netns/generic.h>
>  #include <net/sock.h>
> +#include <net/gro.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -435,7 +436,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (skb->len < len)
>  		goto drop;
>  
> -	if (pskb_trim_rcsum(skb, len))
> +	if (!skb_is_gso(skb) && pskb_trim_rcsum(skb, len))
>  		goto drop;
>  
>  	ph = pppoe_hdr(skb);
> @@ -1173,6 +1174,161 @@ static struct pernet_operations pppoe_net_ops = {
>  	.size = sizeof(struct pppoe_net),
>  };
>  
> +static u16
> +compare_pppoe_header(struct pppoe_hdr *phdr, struct pppoe_hdr *phdr2)
> +{
> +	return (__force __u16)((phdr->sid ^ phdr2->sid) |
> +			       (phdr->tag[0].tag_type ^ phdr2->tag[0].tag_type));
> +}
> +
> +static __be16 pppoe_hdr_proto(struct pppoe_hdr *phdr)
> +{
> +	switch (phdr->tag[0].tag_type) {
> +	case cpu_to_be16(PPP_IP):
> +		return cpu_to_be16(ETH_P_IP);
> +	case cpu_to_be16(PPP_IPV6):
> +		return cpu_to_be16(ETH_P_IPV6);
> +	default:
> +		return 0;
> +	}
> +
> +}
> +
> +static struct sk_buff *pppoe_gro_receive(struct list_head *head,
> +					 struct sk_buff *skb)
> +{
> +	const struct packet_offload *ptype;
> +	unsigned int hlen, off_pppoe;
> +	struct sk_buff *pp = NULL;
> +	struct pppoe_hdr *phdr;
> +	struct sk_buff *p;
> +	int flush = 1;
> +	__be16 type;
> +
> +	off_pppoe = skb_gro_offset(skb);
> +	hlen = off_pppoe + sizeof(*phdr);
> +	phdr = skb_gro_header(skb, hlen + 2, off_pppoe);
> +	if (unlikely(!phdr))
> +		goto out;
> +
> +	/* ignore packets with padding or invalid length */
> +	if (skb_gro_len(skb) != be16_to_cpu(phdr->length) + hlen)
> +		goto out;
> +
> +	type = pppoe_hdr_proto(phdr);
> +	if (!type)
> +		goto out;
> +
> +	ptype = gro_find_receive_by_type(type);
> +	if (!ptype)
> +		goto out;
> +
> +	flush = 0;
> +
> +	list_for_each_entry(p, head, list) {
> +		struct pppoe_hdr *phdr2;
> +
> +		if (!NAPI_GRO_CB(p)->same_flow)
> +			continue;
> +
> +		phdr2 = (struct pppoe_hdr *)(p->data + off_pppoe);
> +		if (compare_pppoe_header(phdr, phdr2))
> +			NAPI_GRO_CB(p)->same_flow = 0;
> +	}
> +
> +	skb_gro_pull(skb, sizeof(*phdr) + 2);
> +	skb_gro_postpull_rcsum(skb, phdr, sizeof(*phdr) + 2);
> +
> +	pp = indirect_call_gro_receive_inet(ptype->callbacks.gro_receive,
> +					    ipv6_gro_receive, inet_gro_receive,
> +					    head, skb);
> +
> +out:
> +	skb_gro_flush_final(skb, pp, flush);
> +
> +	return pp;
> +}
> +
> +static int pppoe_gro_complete(struct sk_buff *skb, int nhoff)
> +{
> +	struct pppoe_hdr *phdr = (struct pppoe_hdr *)(skb->data + nhoff);
> +	__be16 type = pppoe_hdr_proto(phdr);
> +	struct packet_offload *ptype;
> +	int len, err;
> +
> +	ptype = gro_find_complete_by_type(type);
> +	if (!ptype)
> +		return -ENOENT;
> +
> +	err = INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
> +				 ipv6_gro_complete, inet_gro_complete,
> +				 skb, nhoff + sizeof(*phdr) + 2);
> +	if (err)
> +		return err;
> +
> +	len = skb->len - (nhoff + sizeof(*phdr));
> +	phdr->length = cpu_to_be16(len);
> +
> +	return 0;
> +}
> +
> +static struct sk_buff *pppoe_gso_segment(struct sk_buff *skb,
> +					 netdev_features_t features)
> +{

I don't think this will be called for PPPoE over GRE packets,
since gre_gso_segment skips everything up to the network header.

> +	unsigned int pppoe_hlen = sizeof(struct pppoe_hdr) + 2;
> +	struct sk_buff *segs = ERR_PTR(-EINVAL);
> +	u16 mac_offset = skb->mac_header;
> +	struct packet_offload *ptype;
> +	u16 mac_len = skb->mac_len;
> +	struct pppoe_hdr *phdr;
> +	__be16 orig_type, type;
> +	int len, nhoff;
> +
> +	skb_reset_network_header(skb);
> +	nhoff = skb_network_header(skb) - skb_mac_header(skb);
> +
> +	if (unlikely(!pskb_may_pull(skb, pppoe_hlen)))
> +		goto out;
> +
> +	phdr = (struct pppoe_hdr *)skb_network_header(skb);
> +	type = pppoe_hdr_proto(phdr);
> +	ptype = gro_find_complete_by_type(type);
> +	if (!ptype)
> +		goto out;
> +
> +	orig_type = skb->protocol;
> +	__skb_pull(skb, pppoe_hlen);
> +	segs = ptype->callbacks.gso_segment(skb, features);
> +	if (IS_ERR_OR_NULL(segs)) {
> +		skb_gso_error_unwind(skb, orig_type, pppoe_hlen, mac_offset,
> +				     mac_len);
> +		goto out;
> +	}
> +
> +	skb = segs;
> +	do {
> +		phdr = (struct pppoe_hdr *)(skb_mac_header(skb) + nhoff);
> +		len = skb->len - (nhoff + sizeof(*phdr));
> +		phdr->length = cpu_to_be16(len);
> +		skb->network_header = (u8 *)phdr - skb->head;
> +		skb->protocol = orig_type;
> +		skb_reset_mac_len(skb);
> +	} while ((skb = skb->next));
> +
> +out:
> +	return segs;
> +}
> +
> +static struct packet_offload pppoe_packet_offload __read_mostly = {
> +	.type = cpu_to_be16(ETH_P_PPP_SES),
> +	.priority = 20,
> +	.callbacks = {
> +		.gro_receive = pppoe_gro_receive,
> +		.gro_complete = pppoe_gro_complete,
> +		.gso_segment = pppoe_gso_segment,
> +	},
> +};
> +
>  static int __init pppoe_init(void)
>  {
>  	int err;
> @@ -1189,6 +1345,7 @@ static int __init pppoe_init(void)
>  	if (err)
>  		goto out_unregister_pppoe_proto;
>  
> +	dev_add_offload(&pppoe_packet_offload);
>  	dev_add_pack(&pppoes_ptype);
>  	dev_add_pack(&pppoed_ptype);
>  	register_netdevice_notifier(&pppoe_notifier);
> @@ -1208,6 +1365,7 @@ static void __exit pppoe_exit(void)
>  	unregister_netdevice_notifier(&pppoe_notifier);
>  	dev_remove_pack(&pppoed_ptype);
>  	dev_remove_pack(&pppoes_ptype);
> +	dev_remove_offload(&pppoe_packet_offload);
>  	unregister_pppox_proto(PX_PROTO_OE);
>  	proto_unregister(&pppoe_sk_proto);
>  	unregister_pernet_device(&pppoe_net_ops);
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 76e38092cd8a..0480a6d4f203 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1533,6 +1533,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
>  
>  	return pp;
>  }
> +EXPORT_INDIRECT_CALLABLE(inet_gro_receive);
>  
>  static struct sk_buff *ipip_gro_receive(struct list_head *head,
>  					struct sk_buff *skb)
> @@ -1618,6 +1619,7 @@ int inet_gro_complete(struct sk_buff *skb, int nhoff)
>  out:
>  	return err;
>  }
> +EXPORT_INDIRECT_CALLABLE(inet_gro_complete);
>  
>  static int ipip_gro_complete(struct sk_buff *skb, int nhoff)
>  {
> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
> index fce91183797a..9e3640b018a4 100644
> --- a/net/ipv6/ip6_offload.c
> +++ b/net/ipv6/ip6_offload.c
> @@ -306,6 +306,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
>  
>  	return pp;
>  }
> +EXPORT_INDIRECT_CALLABLE(ipv6_gro_receive);
>  
>  static struct sk_buff *sit_ip6ip6_gro_receive(struct list_head *head,
>  					      struct sk_buff *skb)
> @@ -388,6 +389,7 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
>  out:
>  	return err;
>  }
> +EXPORT_INDIRECT_CALLABLE(ipv6_gro_complete);
>  
>  static int sit_gro_complete(struct sk_buff *skb, int nhoff)
>  {


