Return-Path: <netdev+bounces-80765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACC7880FFC
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1DDB22AB2
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 10:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F8F2770B;
	Wed, 20 Mar 2024 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="PTiF9aPH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA220DCC
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930846; cv=none; b=ecnRjEAGMQwoa9V7HP9EAAIfXoB8pLWf0h+iSrgFeYIn0d+OynXfibwtgOL21d8+AvA4vYS8FUIxwtv7C/zlV6uba+BS/5n+JTiNkTwr4l0j5+O+DTazK/yU6CRyVk56lRjvqGJZ4CDV7B84Y29aF6q9tKo1W1laDNCQayuxyzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930846; c=relaxed/simple;
	bh=h75awBsQ3kdyC4gjdvhNQLxVEteauituEChyhuecsvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLUOl91o++CyFnNphLJR7GjaE8d9jXF6TElMTSDhe6R+HsuhNArK4y5WQXG8SdDsGsxANlunBSxQQLbH4Au7wwj+b50As17TbvWhO41EIIasyvUaXOKSNRDsvb8MnkI22LgmXjOkVJo8ck51azyHsoghI29LYO00zDgDsJ/9UMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=PTiF9aPH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso7992180a12.2
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 03:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1710930843; x=1711535643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pU0oFHPpizQoibbeCMsLY0ImCdqkE+8lma6xbs74EUw=;
        b=PTiF9aPHuYwc9SQb8OgFoG5kt9fRkEs89SA3z51iAmgkzIaiUyWT/P3Txu5kjBd6kP
         Z+VcwM4TlKhBEQMIyoUde41r2sS7XNWayDl8rkattJkmt/EiAlTZXoY9Ic11VQawvgII
         ZMQknUxhbsnsMzHsuzjG+WkLw0QOCChV6OS1u7nnpAU2HDX2gHex+hLcM+CB8riaJzd/
         e3CzeKrmw/pyyBY/8pw2WQrPWxvvx7VhG14V+yIoKJlFCHCw4Swukya4KkHrXU/sevdR
         SLVn0aIZPuvp9w9lUt6RdLZTMIWg8LlX4kvM6TkJoKQ51WgFBsAvFgOLmKdLmB3aR7Ty
         HfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710930843; x=1711535643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pU0oFHPpizQoibbeCMsLY0ImCdqkE+8lma6xbs74EUw=;
        b=b1OijLHtoyOHIn1m/fQusmaNeGQfbRJps15KhHCQpoG9L2+bR9V1gyjeNsUNTOj6Yb
         Q9byMj/nPFncwUhu+/G/qXKJEzuP595kUJny4cmYRAMGeNtRr9qNVIMJIMYq1P+M5xvn
         YFhPqcRRo/r47ZpJwoVFFDLEnqIzr9/aSULD6g2Ups5HdYJK+cnD0FPKUAwRV4ZNYj1b
         FdKpc/yL4GtVKFUJPR8c2/27iuZyLiagxNfBIlInIuEZRpf/MLPN9tgkzn0ESDPA8idm
         JxxwPTLgQ6betA9N5J7Rn1iPoaiUb4ckFH7UnUU9stR1Bmg6SkorbcezUs2KruTUc6xj
         J3zw==
X-Forwarded-Encrypted: i=1; AJvYcCUKTopKyTGhq3RgbnvFOFLBqYFGE/XdMpkQytft3sOTbO6uR2pwMM5XDvdtdFqOIwCw0YOXdcFi8vZUc8jn9sxlnpDjH9W6
X-Gm-Message-State: AOJu0YzaXnH4Tdpf7t8ITL5UteBLTIAuSqzMnn8cE+QL9BrkaYUcvK1/
	d7DhKxFaNn0bERPFqXxszjWRNyFqYXVEyowkkrvfd2k5NbI/IgfuUD35+ttUHd8=
X-Google-Smtp-Source: AGHT+IGi3JUvj2YvDNINsM2O8nMuJRLfqvY70xpGgIPwbsg92PP8RGrp9qhy9v4jCqpMO5jioRYasQ==
X-Received: by 2002:a17:906:c202:b0:a46:ca55:477a with SMTP id d2-20020a170906c20200b00a46ca55477amr5311288ejz.72.1710930843314;
        Wed, 20 Mar 2024 03:34:03 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090643c700b00a46c8dbd5e4sm2981606ejn.7.2024.03.20.03.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 03:34:02 -0700 (PDT)
Message-ID: <99098715-6b36-456a-869e-39f9b211a8bc@blackwall.org>
Date: Wed, 20 Mar 2024 12:34:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/4] udp: do not accept non-tunnel GSO skbs landing
 in a tunnel
To: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: steffen.klassert@secunet.com, willemdebruijn.kernel@gmail.com,
 netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
References: <20240319093140.499123-1-atenart@kernel.org>
 <20240319093140.499123-2-atenart@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240319093140.499123-2-atenart@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 11:31, Antoine Tenart wrote:
[snip]
> @@ -163,6 +181,16 @@ static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
>   	    !udp_test_bit(ACCEPT_FRAGLIST, sk))
>   		return true;
>   
> +	/* GSO packets lacking the SKB_GSO_UDP_TUNNEL/_CUSM bits might still

s/CUSM/CSUM/

> +	 * land in a tunnel as the socket check in udp_gro_receive cannot be
> +	 * foolproof.
> +	 */
> +	if (udp_encap_needed() &&
> +	    READ_ONCE(udp_sk(sk)->encap_rcv) &&
> +	    !(skb_shinfo(skb)->gso_type &
> +	      (SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM)))
> +		return true;
> +
>   	return false;
>   }
>   
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index b9880743765c..e9719afe91cf 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -551,8 +551,10 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
>   	unsigned int off = skb_gro_offset(skb);
>   	int flush = 1;
>   
> -	/* we can do L4 aggregation only if the packet can't land in a tunnel
> -	 * otherwise we could corrupt the inner stream
> +	/* We can do L4 aggregation only if the packet can't land in a tunnel
> +	 * otherwise we could corrupt the inner stream. Detecting such packets
> +	 * cannot be foolproof and the aggregation might still happen in some
> +	 * cases. Such packets should be caught in udp_unexpected_gso later.
>   	 */
>   	NAPI_GRO_CB(skb)->is_flist = 0;
>   	if (!sk || !udp_sk(sk)->gro_receive) {


