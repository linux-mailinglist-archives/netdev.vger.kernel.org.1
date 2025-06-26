Return-Path: <netdev+bounces-201381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82190AE93DB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 03:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FB717C6FF
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 01:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AC817B50A;
	Thu, 26 Jun 2025 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+D/iDyF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD58F4A33
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750902874; cv=none; b=V5m3nqn+TVNViV9i8Snu/sAHcH5d/mKTnY04kHGhdfb8IyU5q7qd+nu+JpVfiQF8IbghC+gspOAre7b6pCzOuh8liiQ/51Hzdm5F7jVeSv7MqUKEkpzLjuJ91R6JYocbXdZJE/WyDaTmQ4SEQAueMm+uKcvmnqJzha7vqMPa5jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750902874; c=relaxed/simple;
	bh=vMW1iHtADzGBB0HdRNmfXo/5p9EbsnldNKkKgif++LY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QuwzQ0xWfkg3h5Rml3yHUjfoKe+7E7QK6dJqU525ksUzmZ/xgazEUlJ0kY6j/chBCFfCKFG3f9YiynOn3MUZmIbgHs2WZDwF9JCS60M1Dr6G8poxIH8i4pIbPpzlA2Fob3O3KEfocBB65feKtHCQU9eBbyCrBYlpfqooc9z1ApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+D/iDyF; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7086dcab64bso5097057b3.1
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 18:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750902872; x=1751507672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwzPowZMkt4Kfj1DpxsFgKXcdwsd5eETb2H/nYea5Vo=;
        b=Z+D/iDyFPGRvRYp9s4v+CmRT8OI0mMPt9dmoIytvPCfcz8VRhPZFQuwpJF4ffBAVLl
         47TBFs2v4OcjEn/qLPtXylQkABlY7ytnut6ReWQcWrL3SQBSROrkaMzOoFEog7UvzuV9
         D5v1Dq97FIzG8FpOheIW4DcGPGM4Qck6Jfv7PafQT7rpyTbZWKT5hN4WVI4aH1jclgpC
         3Dn2mwbBjbhzsV3x6fe3blymCygisiFj7Wj2e1O40by1mdC4AID9hyrj4vn8U03iSx1N
         A5ASEwSm/LQw2iYrZgyIdFvTnws9oM8cAgnWyb214UFlrH6wDV2oSw36rFl0iE9YqaKC
         nTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750902872; x=1751507672;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wwzPowZMkt4Kfj1DpxsFgKXcdwsd5eETb2H/nYea5Vo=;
        b=KQZqOjvUxgm/wvdB6KdVD/kqoOD/Y7xBYP964GUY6cer9855EjKQuI4bzN+FsRvcAr
         iyc0AZMzQHa6KKuESg7XFO/Xn4k4tBqDagtkjeBWgd1VkR101vItWDSbcbsD2o2IciE8
         MlvmG7D0Xq8r3X4o9hL5zZWf7JBui1Ia6e0t6gQ+Q7Re7BowJGnIYE4R5+RCQ8l6oC16
         C+fYbtwtovQexZ1P48hV8Br9/IaaqOnb/md+KJaKEEGThymxsWAQm8+1O41ltXJMJoq5
         VmAvH9szXNJFSGgpjBPmaBtt9liLsA75JRc9fAVl1YFE3Sr8jot1Lz2KiTf5avudMkGy
         VKVg==
X-Forwarded-Encrypted: i=1; AJvYcCWbEKXKrhKVAXpnV1VAcfcRgKy+zHvYOkFATqy3hUO7CkXYrGVOwJuZIzjGvTWoYCHFYyV8F2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfw8Gd1sOe+JzHhq4DsKk/CFRjP1RvVPg6uC8u7uBAE5iOqNpZ
	QHKUmYlBuHaHBIq4Vow3m9ivw2RtyHgyMdRmYth37yNNcjJ98qGWrLwz
X-Gm-Gg: ASbGnctbgkt8AqybNXX4QdHQdoIT5zgeBapXPnmdVGZqgR1+t3aY9OYAr25Q+3s6Pml
	zO38WZaqwARwhh42uuOxW78aI5lyqCGyHhRZc/tH5h5eyfJxv+JFfAHLAagHkeBNP0+pVHnT0vs
	HJUwOnl/+fyZosUcofM9mBpb3UNhpdlAB/peEDhAXObvQ9tfpwSPHR1gxDHtKTpeiFk2IkmsBme
	lNXjU2IxO77RkS0cidBbWf5TXLPRKbU050qysKth279I7JZfQLIi6UWuEbHGyMhYbq6cZlBaNq3
	6L85I5vxxwhAv4Tyvcn0zrCICpyfuV0lrQyMtp8nQg6EHQ2P7i8gNzijdLDjS2j2nCOkxoF8/Pd
	P3YY0dAnqwBZ4xevPU9er8akYr98fU1TxO563tU9SXA==
X-Google-Smtp-Source: AGHT+IEIletltwM7Eo031iuDsJy5ecInDeuq2OZLjyoL7hFA4akeWiPIQgwgsEMcc86m+pG8QBnXvw==
X-Received: by 2002:a05:690c:6312:b0:710:f5c5:c9bf with SMTP id 00721157ae682-71406ca31d7mr84700097b3.15.1750902871719;
        Wed, 25 Jun 2025 18:54:31 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712cc673bb5sm24765397b3.39.2025.06.25.18.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 18:54:30 -0700 (PDT)
Date: Wed, 25 Jun 2025 21:54:30 -0400
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
Message-ID: <685ca856436a0_2a5da4294c9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250625135210.2975231-14-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-14-daniel.zahka@gmail.com>
Subject: Re: [PATCH v2 13/17] net/mlx5e: Implement PSP Tx data path
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
> Setup PSP offload on Tx data path based on whether skb indicates that it is
> intended for PSP or not. Support driver side encapsulation of the UDP
> headers, PSP headers, and PSP trailer for the PSP traffic that will be
> encrypted by the NIC.
> 
> Signed-off-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

> +static void psp_write_headers(struct net *net, struct sk_buff *skb,
> +			      __be32 spi, u8 ver, unsigned int udp_len,
> +			      __be16 sport)
> +{
> +	struct udphdr *uh = udp_hdr(skb);
> +	struct psphdr *psph = (struct psphdr *)(uh + 1);
> +
> +	uh->dest = htons(PSP_DEFAULT_UDP_PORT);
> +	uh->source = udp_flow_src_port(net, skb, 0, 0, false);
> +	uh->check = 0;
> +	uh->len = htons(udp_len);
> +
> +	psph->nexthdr = IPPROTO_TCP;
> +	psph->hdrlen = PSP_HDRLEN_NOOPT;
> +	psph->crypt_offset = 0;
> +	psph->verfl = FIELD_PREP(PSPHDR_VERFL_VERSION, ver) |
> +		      FIELD_PREP(PSPHDR_VERFL_ONE, 1);
> +	psph->spi = spi;
> +	memset(&psph->iv, 0, sizeof(psph->iv));
> +}
> +
> +/* Encapsulate a TCP packet with PSP by adding the UDP+PSP headers and filling
> + * them in.
> + */
> +static bool psp_encapsulate(struct net *net, struct sk_buff *skb,
> +			    __be32 spi, u8 ver, __be16 sport)
> +{
> +	u32 network_len = skb_network_header_len(skb);
> +	u32 ethr_len = skb_mac_header_len(skb);
> +	u32 bufflen = ethr_len + network_len;
> +	struct ipv6hdr *ip6;
> +
> +	if (skb_cow_head(skb, PSP_ENCAP_HLEN))
> +		return false;
> +
> +	skb_push(skb, PSP_ENCAP_HLEN);
> +	skb->mac_header		-= PSP_ENCAP_HLEN;
> +	skb->network_header	-= PSP_ENCAP_HLEN;
> +	skb->transport_header	-= PSP_ENCAP_HLEN;
> +	memmove(skb->data, skb->data + PSP_ENCAP_HLEN, bufflen);
> +
> +	ip6 = ipv6_hdr(skb);
> +	skb_set_inner_ipproto(skb, IPPROTO_TCP);
> +	ip6->nexthdr = IPPROTO_UDP;
> +	be16_add_cpu(&ip6->payload_len, PSP_ENCAP_HLEN);
> +
> +	skb_set_inner_transport_header(skb, skb_transport_offset(skb) + PSP_ENCAP_HLEN);
> +	skb->encapsulation = 1;
> +	psp_write_headers(net, skb, spi, ver,
> +			  skb->len - skb_transport_offset(skb), sport);
> +
> +	return true;
> +}

It makes sense to do this in the driver.

But it would be good to from the start have this in a driver
independent location, as library functions that drivers can call.

Same for psp_rcv in patch 16.

Else, every driver is going to reimplement this logic.


