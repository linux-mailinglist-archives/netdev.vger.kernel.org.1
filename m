Return-Path: <netdev+bounces-204438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 551D7AFA6AD
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 19:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE87B189A568
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF1028D8F4;
	Sun,  6 Jul 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3g+qrZ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038828D8DB
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751821653; cv=none; b=ej+r2bHMMluGpQYqa2d4RnRbrhnqFs7NZsuZLMRYVafk+5d9wtLPGgymfwxpHWA9MXdAPDwhgxW3AbYfWgy6alri8D7nVDWIyXDv2YnJUIZ0IvOyt2CQGjUBjArfYTO4PgWuA4zN9ysk7F7+z+7sUPI82d9J8QJ3s+x67SiaJZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751821653; c=relaxed/simple;
	bh=lCqAqgThyRa0R4blSats1RndfmMtsUzKnT4Y7+Um+LI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gyWtEHksgnCztMimAcghos0nu5TIO2tH0yRsYnEmC2Qt1OcipBZfgidFv0TDDwV2rRH6ap1JKaYr+5bBaOqP6GXHPz15ihw6rjBGseHW/DFiUB+HjR7WM/LGz+J79+zk0vug7++w+CFJETg+UbikqZRhUejOAkVXlv6DN/my+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3g+qrZ2; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e84207a8aa3so1458511276.3
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 10:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751821651; x=1752426451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMNYSSEm+vCL47ZK69Fn0/Xpan8Ql0a2lYv78AqPXQQ=;
        b=A3g+qrZ2kwRQG//ze4LRuinPDAjcPULRzCq0GPAB4OAc/gTflV7OUUD/Ihnpqa/g2g
         UYZg9W45lwldoKxHhlzYm9xk4a/Ok8z+NenWV6toC1I4BnYeCU3GQBRkujxcBX9iWuEx
         OMT/8KJ9ODXQ69SsUViXHlRH5a3fsrS6oMWB/csWQwp7O+z4iCmn8qVR/imi38LvuJej
         +rbhZfuJJQ3mwOjrT1J9jnOWy+yiijBkpNAeYa6KpH4WdzjwK6FSmY7AsAEOo4ea1ixj
         Z9q/pf+1Uuahqv64opvra0kuGVv/BU1noPlqxW3/HgG9QrxNGwygsbDHX2ke2EGs/8DE
         23Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751821651; x=1752426451;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMNYSSEm+vCL47ZK69Fn0/Xpan8Ql0a2lYv78AqPXQQ=;
        b=sgN/roWQ40apWqTKL4PIHB0oOmtvu5DW2VEMZfoJXVXOq40mSh6Owa0/vZXVyp5+r+
         b4zrmcE8UEpOfKvjU5glH9n+7Q5CzJI7vB3PYEV6vIIJk+ecHe7uT8Fh3oV6ZtcosmzY
         qQSNY9wSyP1T0Zef6xnCPSSQ7dtK05vNzPO2J84i6rtKX4MO7/qPIv30eFV3w4wc31p5
         mumR/H3MtQfF/0fclR/93y/3IQYEf/ruLUIzJ4NMYHeJbAh634NzHHPH/GFgzjdAAeDf
         7hLDyVbEhu/pc7QMxU/YvwIJRbCtJKxFuRd/f1VtMhWG/6PoIK7ltwVHeD06lmntnsnS
         ARVg==
X-Forwarded-Encrypted: i=1; AJvYcCVzBUBZp80ETEq8ndjXBV4fX+ZV5z0h0nfA7LSwlyupZseggL0Jw9e5qPpABP3WRclnwH6uCF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDcxwdpMLq/O/nX/pN/zv36fD4A3PxjS5JRAj0R4hyd6QPmAVq
	HfD9sn+WXHQmIwOtBBu9kEzC4gr/sGtQ9P1YpmIrPREqjSEy2UqRZnnx
X-Gm-Gg: ASbGncvCcgXA0qNVaEr0GsTdYOoiAkY8lSJBYKZG2XCQEPsdqhoTocJ9mwZBO4pSZ69
	XWaaFmZQqzmE63T/+pJRxdyQwcuAloife9GEAR/4NlVOQjM2Fwj2vi6mSooOA6TpXxzXu3JVIqR
	8vpNizECvJ9qUgsWb5un4ncPPUyMcN/fOpuX3wE/KzXvtJ0uyr7ofi8J5Wh9W9T0vnkqoKwrakw
	rITkCM0G/5osW8vvvjU7VTQCYs9PGu8HPAIhyjnFaYjijvejUyBKkf9w4YqrIEAl2HAVmrbTnhi
	ksPzafVLzn5qKcWqzZe4DWTyAM5tjZPJnQiYSICac47hYN/G9BO5dW9bjkEsyk04lC/5c1zIPVe
	v+04DDXQ8BME6kbgV7FOsXgUEl3SOWvK/aPSFENFbYXfxFadU/w==
X-Google-Smtp-Source: AGHT+IEHd6ybTEj/iZ2N3uRMwG0g8IMAhDrPq7tBky61PCL5RDufcF6B6NhotuHC9Oy6VX8xHBSOfQ==
X-Received: by 2002:a05:690c:4b13:b0:713:ff2c:a7aa with SMTP id 00721157ae682-7166b7ecb72mr134618787b3.31.1751821650667;
        Sun, 06 Jul 2025 10:07:30 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71665b12c88sm12636827b3.94.2025.07.06.10.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 10:07:30 -0700 (PDT)
Date: Sun, 06 Jul 2025 13:07:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <686aad51a4f7c_3ad0f329439@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702171326.3265825-18-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-18-daniel.zahka@gmail.com>
Subject: Re: [PATCH v3 17/19] psp: provide decapsulation and receive helper
 for drivers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Raed Salem <raeds@nvidia.com>
> 
> Create psp_rcv(), which drivers can call to psp decapsulate and attach
> a psp_skb_ext to an skb.
> 
> psp_rcv() only supports what the PSP architecture specification refers
> to as "transport mode" packets, where the L3 header is IPv6. psp_rcv()
> also assumes that a psp trailer is present and should be pulled from
> the skb.
> 
> Signed-off-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
> 
> Notes:
>     v3:
>     - patch introduced
> 
>  include/net/psp/functions.h |  1 +
>  net/psp/psp_main.c          | 49 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
> index afb4f5929eec..8ecc396bcfff 100644
> --- a/include/net/psp/functions.h
> +++ b/include/net/psp/functions.h
> @@ -18,6 +18,7 @@ psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
>  void psp_dev_unregister(struct psp_dev *psd);
>  bool psp_encapsulate(struct net *net, struct sk_buff *skb,
>  		     __be32 spi, u8 ver, __be16 sport);
> +int psp_rcv(struct sk_buff *skb, u16 dev_id, u8 generation);

If respinning, maybe prefix these device datapath helpers as psp_dev_.
>  
>  /* Kernel-facing API */
>  void psp_assoc_put(struct psp_assoc *pas);
> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index 8229a004ba6e..ec60e06cdf69 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c
> @@ -195,6 +195,55 @@ bool psp_encapsulate(struct net *net, struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL(psp_encapsulate);
>  
> +/* Receive handler for PSP packets.
> + *
> + * Presently it accepts only already-authenticated packets and does not
> + * support optional fields, such as virtualization cookies.
> + */
> +int psp_rcv(struct sk_buff *skb, u16 dev_id, u8 generation)
> +{
> +	const struct psphdr *psph;
> +	int depth = 0, end_depth;
> +	struct psp_skb_ext *pse;
> +	struct ipv6hdr *ipv6h;
> +	struct ethhdr *eth;
> +	__be16 proto;
> +	u32 spi;
> +
> +	eth = (struct ethhdr *)(skb->data);
> +	proto = __vlan_get_protocol(skb, eth->h_proto, &depth);
> +	if (proto != htons(ETH_P_IPV6))
> +		return -EINVAL;
> +
> +	ipv6h = (struct ipv6hdr *)(skb->data + depth);
> +	depth += sizeof(*ipv6h);
> +	end_depth = depth + sizeof(struct udphdr) + sizeof(struct psphdr);
> +
> +	if (unlikely(end_depth > skb_headlen(skb)))
> +		return -EINVAL;
> +
> +	pse = skb_ext_add(skb, SKB_EXT_PSP);
> +	if (!pse)
> +		return -EINVAL;
> +
> +	psph = (const struct psphdr *)(skb->data + depth + sizeof(struct udphdr));
> +	pse->spi = psph->spi;
> +	pse->dev_id = dev_id;
> +	spi = ntohl(psph->spi);

unused

> +	pse->generation = generation;
> +	pse->version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
> +
> +	ipv6h->nexthdr = psph->nexthdr;
> +	ipv6h->payload_len =
> +		htons(ntohs(ipv6h->payload_len) - PSP_ENCAP_HLEN - PSP_TRL_SIZE);

Whether the trailer is removed by the device is device specific.

> +
> +	memmove(skb->data + PSP_ENCAP_HLEN, skb->data, depth);
> +	skb_pull(skb, PSP_ENCAP_HLEN);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(psp_rcv);
> +
>  static int __init psp_init(void)
>  {
>  	mutex_init(&psp_devs_lock);
> -- 
> 2.47.1
> 



