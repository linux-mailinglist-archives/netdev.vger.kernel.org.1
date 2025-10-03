Return-Path: <netdev+bounces-227753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D955BB6954
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 14:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E2074E0F8B
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241B52ECD14;
	Fri,  3 Oct 2025 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="A6ic5k8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5128504B
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759493035; cv=none; b=n/h7bF5bYzYVQ8ThZ+1ahYxHOft9sDNOHT+xwXw4qtw8ogtouyPv9FFsB9qdluC94FEqsKy1zGaop5OywEfoBisB7nlfLrKUL7Uftf2q+2VkhYep7dgw5Oe9ZC2/+iShJNCzNizNDALiXxn6pzfQ3+zML7OBDTsJ4GhBH1e+s8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759493035; c=relaxed/simple;
	bh=TKJ68FQzM4OxoqzPD1unNLoApkMeRnB7fJR+0WinljE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OK6CbTSO5S+bweuY99zrg71PeQ/iN/VDKPgfJPcccJta+ElQKZa95TRN/Qwl0xB1/+LXCngxtgMdOjW3Ns3OEBu5adLnWeLl4vvn087X1jgVbZoUwyBCW9pMrlS5pkrLluk2ASGIkTNShOPRHaPJ7Mrz/9cRHl5D0iIWKbE2Bv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=A6ic5k8z; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6349e3578adso3968571a12.1
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759493031; x=1760097831; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7EUW43HWolyI7T5LSzYWxB/vbzNla21nNsPp9mz+OZo=;
        b=A6ic5k8z7XJBy13VqJMYMttQy54y34Q46MyX++5vj0WvkgXfhwKNVU/EBdnJpMH2t7
         SEiYkp8wdNSI6Cp+0sZJpCczgSXv1aKZJCPWiJHk2w/9tcNWXoJ0X2BW3jOe3xEWCCQc
         ne6TExW7IzmCaQusiTOrbDJZd+7K1v2fRh9roXUPG2i/y6xay9qZ7y4h+yD1XdS047Ox
         Jj1nXOC6Jmopx7aoSYpV3nkZxMja5Yrwva1/WByxdLaQRpPb9dwjo21JxCg3RdgRg8Wx
         LmrANYRVOR/vtABl5tKy7XxmQ5lT0+Bs1kenJ6vdBAmsvVs7r6yraoK1Gm6ocDH6/51F
         98Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759493031; x=1760097831;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EUW43HWolyI7T5LSzYWxB/vbzNla21nNsPp9mz+OZo=;
        b=j+7Jlw5qDqyVdYxwqmVmJjX2TDceda7y+e6uz4iSFrB71ixng3KwzYH0fWX+Vc04Fc
         yMSAJQJJd5EF4C+6yM6n0I2QXN+yu6agpM3AnMayY5Kdejg0zWvdxKPaknXLnkq99gg0
         /+/GLtDP3YhLfImjKpFhJRz9ja2575tITgH/kLtWQPGhTGBaIenUcjjF8kEwwKZZhvgW
         /IzaosOqDuUKYtisb+6wXEzAP9D+3BPM51fwwkQfRNIsyOh5c19oJrBfP/VlN0LbYmpv
         rE3tIzfMXKbPUs3dEcMPTvJKldMQz0GGqf0fKlX+S9GBB3lUd9jMBuPWoXY5aris+kXC
         Z88A==
X-Gm-Message-State: AOJu0YzbXBTjRgOFgT0iTy6jtO7lqqgBf2JdKtrhuZ6JZoPxAO+QmU61
	G6QWZcE4I0Ct1iT6bfcvmf4BYfcJ/yDPpVcbAT0hYTpYAVcvygcnkZC4k7FEE2bOIOk=
X-Gm-Gg: ASbGncvWCnYKxgVNg3ZqtsfBdReEYQKVcU4RmoabJrzq5QDdrw7ql9QJwrhDGvFcn0o
	HbYtCvgWiq9ei2y8RrOJc8mkIE74mMh44gem4Fkom0Hf/PjqezahpXRD4nzaPgztar9LX7gnGDx
	/7DHML3d6GkCzRUnJogSFiy613GNG6NUfq8i5CagXfZERwfsgbky6WOaaYZ96RotwYa1guyKS0n
	mXGeoijtOCoXsO1uSVHEGg2HKuBmZYPgL7QpKJUGADgfgIn00QdLg+T+hj49ak+bXLCl0yxSmCZ
	qqW4zDiWWLA4cdqmp8y4XK+YZvAJ8evzzsMb2PR+c44xPd1ENfHh+A0PveGvTJ61EdGe7sOu568
	UEfNXVexJ2kp99HuG6lyBxArzo0cDUhhZ1CeU4dCjtJxmMpQ8
X-Google-Smtp-Source: AGHT+IHgY7YMNMn1KWKsL3AP2dmLTqwcNzT1KzlBF2R4fZUXm4QNPcsYDW6TGFHfq2FabuVmsQODEQ==
X-Received: by 2002:a05:6402:2793:b0:62f:ce89:606f with SMTP id 4fb4d7f45d1cf-63934900286mr2753027a12.12.1759493031527;
        Fri, 03 Oct 2025 05:03:51 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6378811ef5esm3893480a12.43.2025.10.03.05.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:03:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [PATCH RFC bpf-next 5/9] bpf: Make bpf_skb_vlan_push helper
 metadata-safe
In-Reply-To: <20250929-skb-meta-rx-path-v1-5-de700a7ab1cb@cloudflare.com>
	(Jakub Sitnicki's message of "Mon, 29 Sep 2025 16:09:10 +0200")
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
	<20250929-skb-meta-rx-path-v1-5-de700a7ab1cb@cloudflare.com>
Date: Fri, 03 Oct 2025 14:03:48 +0200
Message-ID: <87cy742nvf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 29, 2025 at 04:09 PM +02, Jakub Sitnicki wrote:
> Use the metadata-aware helper to move packet bytes after skb_push(),
> ensuring metadata remains valid after calling the BPF helper.
>
> Also, take care to reserve sufficient headroom for metadata to fit.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  include/linux/if_vlan.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
> index 4ecc2509b0d4..b0e1f57d51aa 100644
> --- a/include/linux/if_vlan.h
> +++ b/include/linux/if_vlan.h
> @@ -355,16 +355,17 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
>  					  __be16 vlan_proto, u16 vlan_tci,
>  					  unsigned int mac_len)
>  {
> +	const u8 meta_len = mac_len > ETH_HLEN ? skb_metadata_len(skb) : 0;

This is a typo. Should be:

+       const u8 meta_len = mac_len > ETH_TLEN ? skb_metadata_len(skb) : 0;
                                      ^^^^^^^^
>  	struct vlan_ethhdr *veth;
>  
> -	if (skb_cow_head(skb, VLAN_HLEN) < 0)
> +	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
>  		return -ENOMEM;
>  
>  	skb_push(skb, VLAN_HLEN);
>  
>  	/* Move the mac header sans proto to the beginning of the new header. */
>  	if (likely(mac_len > ETH_TLEN))
> -		memmove(skb->data, skb->data + VLAN_HLEN, mac_len - ETH_TLEN);
> +		skb_postpush_data_move(skb, VLAN_HLEN, mac_len - ETH_TLEN);
>  	if (skb_mac_header_was_set(skb))
>  		skb->mac_header -= VLAN_HLEN;

