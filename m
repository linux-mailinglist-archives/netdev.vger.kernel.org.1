Return-Path: <netdev+bounces-211212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F33B172D8
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6241674F2
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DC32C1592;
	Thu, 31 Jul 2025 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftRT+N76"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4542367AB;
	Thu, 31 Jul 2025 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970923; cv=none; b=CSd8hLdTM57x0fe364T1e3vwUdFQsG4pxrZFL05ycQu8h6YUGQZBARoxwuGAMmv655bHJ6tuBAeq3iqH6sbH9GwjyNDPIOenQzfiMrmjiZgJWghDLwjtluUzLowjOvYD7Prrzwgryt+fUg/9hkB+udGbhSExszZtUhtIry3Bawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970923; c=relaxed/simple;
	bh=t0tY7q00a5ytF72jcdTnEfmoGT7haWKWfadxz31pqe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8icpAPTtyNF+giBL4RnvG0QgRnrlOxO+Bykp6Hj/5sPtg2zAvbR0Ud1rF90rnMzn8/q3Kr4s07uV2k3p0T/C3hCkLiBXAv4BYvP8HxZh7FGc5gmJw66+bNBbqUbok6RLKYOEQPhpDBWB0Nk8qmGDQZsVOgQ6JNhoo1tCVdVQhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftRT+N76; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4561ed868b5so3988155e9.0;
        Thu, 31 Jul 2025 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753970920; x=1754575720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7b/X0mJKCm8poA136xWQlOAFRk5KtIeFKyOjuPLa3A=;
        b=ftRT+N762fPihyL88pLC5ZIs0zn267XP+qYF3NOYh9XsCj2yBWGSUSvZfsG7JeZK7h
         mg2KA/q+m4ziJfc5I0IAV34brhH+Ybu0BmqYCvlFSWDuhwR6e/ixD6X5TT3alP5/6UZ9
         mMY4SOVNiODgFG8VgvXkDoS1PysaCeeeE7ak/yncib40oJTM7g/myCyK/PJw6vLV1ro/
         hvo05DTnZqex1joFZ5kSfyjaNhbJm/KRqazNAAaLkv+rYSJ8Deo3Ili4zP5TBkpyrW0i
         9rPIYzAoJ/sHoG6ZnJ/Sqa+earVznfy5vX2kZ2MV2gfLfg9x8lMtxptNLjlJiwGlSXoD
         4Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970920; x=1754575720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s7b/X0mJKCm8poA136xWQlOAFRk5KtIeFKyOjuPLa3A=;
        b=M+W1U/9KjykhTNvzcSKx3oYgz802A9g3Pkifb/nHUbOCafW6iEMsCMKK+TEiJZQe0l
         Vp+uTopHT0zgA8Ku3r+kSDAuLmwCV3xFJweQpZvczOntL8MYyqL5KEqtbuSo3WDKpnKZ
         Z8AcbodCc/2AE3BiHqL4C2xfBzrX0/qc/yn3nA74Q/c4C42IpxgwO/2fG+ODPbnmdCfs
         REC3WpmhCi933Z/1IXeV8BIIHavC0EBNk8RfMD/lBhbyq48GY2U6IgZ9oKWVk6zf+Rln
         t8YtUpsbCgNgHXJwBz14jVrxgmBlRkN0cggM23rFHP4mo+Aj7SER3O9HvFplsWsIw7P4
         PrXA==
X-Forwarded-Encrypted: i=1; AJvYcCXonqjvxuENaof5g/rI/E0yvAtGbnhsSxI+HLuedI3YMLumpaC4ZV+rM7vjdPXlzRcrdjwM1yc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy9mHWUBl4+GlRbQZylJ4aC/i9UWSShk7PwMJ+1BY9yzwyNFuX
	0No9JGsNuOGLVSWlALOxq6YPl9pa9HovxqkuYBYkkDfbecCwfMnG8hJM
X-Gm-Gg: ASbGncvjr6m/QSjwQ+RBfLpGGBpkQOb+hwrjzjX4tb/rk8WoXyVt9f0RezPnSXM1w30
	95FPAi8gDH155qh+Nt5/fyy3ijBhLJB/nXdiAarGmerV75ufSSMELHorEU1zseD41BL3RX3Fn1u
	e1iKasDwmYUamb5sI6Ucr+9lqC8iqELx/kQBa/4cRkqVJnq5UaTyLDk08IN5//TiGthr73hBcso
	EBGSJwpg+LMZb+zXLTxZV4roHscpOCUZ9XbaVL788XmnBOJFKfvDaoVtKBjTxkAj7mGTFjBJKyf
	6zrMfa3iQLOVNHhDQxKIWB5b8bPLT3E9oBLRU0q+GW2wEF6ViaNaQRjT4gml946c5P0J+xA=
X-Google-Smtp-Source: AGHT+IH7vaX+46eX5i0fTxj4a02XS3Q62QbSQ5+KLll4ZTcudY4b1sAt/byMBzH0xrz50sLkT5UHOg==
X-Received: by 2002:a05:600c:6096:b0:456:173c:8a53 with SMTP id 5b1f17b1804b1-45892b911a8mr84575585e9.2.1753970919699;
        Thu, 31 Jul 2025 07:08:39 -0700 (PDT)
Received: from debian ([45.84.137.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee578e4sm27661275e9.26.2025.07.31.07.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 07:08:39 -0700 (PDT)
Message-ID: <194828df-1e6e-762c-0887-5a68c914027e@gmail.com>
Date: Thu, 31 Jul 2025 16:08:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] net: pppoe: implement GRO support
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org
References: <20250716081441.93088-1-nbd@nbd.name>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <20250716081441.93088-1-nbd@nbd.name>
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
> 
>  drivers/net/ppp/pppoe.c | 104 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 103 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index 410effa42ade..5d35eafd06df 100644
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
> @@ -1173,6 +1174,105 @@ static struct pernet_operations pppoe_net_ops = {
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
> +	__be16 type;
> +	int flush = 1;
> +
> +	off_pppoe = skb_gro_offset(skb);
> +	hlen = off_pppoe + sizeof(*phdr) + 2;
> +	phdr = skb_gro_header(skb, hlen, off_pppoe);
> +	if (unlikely(!phdr))
> +		goto out;
> +
> +	/* ignore packets with padding or invalid length */
> +	if (skb_gro_len(skb) != be16_to_cpu(phdr->length) + hlen - 2)
> +		goto out;
> +
> +	NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = hlen;
This is not required as {inet,ipv6}_gro_receive already set the network offset.

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
> +	pp = ptype->callbacks.gro_receive(head, skb);
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
> +	int err = -ENOENT;
> +
> +	ptype = gro_find_complete_by_type(type);
> +	if (ptype)
> +		err = ptype->callbacks.gro_complete(skb, nhoff +
> +						    sizeof(*phdr) + 2);
> +
> +	return err;
> +}
Shouldn't pppoe_gro_complete fix the length field of the pppoe header?

> +
> +static struct packet_offload pppoe_packet_offload __read_mostly = {
> +	.type = cpu_to_be16(ETH_P_PPP_SES),
> +	.priority = 10,
> +	.callbacks = {
> +		.gro_receive = pppoe_gro_receive,
> +		.gro_complete = pppoe_gro_complete,
> +	},
> +};
> +
>  static int __init pppoe_init(void)
>  {
>  	int err;
> @@ -1189,6 +1289,7 @@ static int __init pppoe_init(void)
>  	if (err)
>  		goto out_unregister_pppoe_proto;
>  
> +	dev_add_offload(&pppoe_packet_offload);
>  	dev_add_pack(&pppoes_ptype);
>  	dev_add_pack(&pppoed_ptype);
>  	register_netdevice_notifier(&pppoe_notifier);
> @@ -1208,6 +1309,7 @@ static void __exit pppoe_exit(void)
>  	unregister_netdevice_notifier(&pppoe_notifier);
>  	dev_remove_pack(&pppoed_ptype);
>  	dev_remove_pack(&pppoes_ptype);
> +	dev_remove_offload(&pppoe_packet_offload);
>  	unregister_pppox_proto(PX_PROTO_OE);
>  	proto_unregister(&pppoe_sk_proto);
>  	unregister_pernet_device(&pppoe_net_ops);

