Return-Path: <netdev+bounces-169405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DBCA43BAC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB2D19C0D6E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6544267AEF;
	Tue, 25 Feb 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8Qfom2G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3134B267384
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479016; cv=none; b=Vw2aJp5Trsjd6onHVE5WFHoCRcsLI8j0qXReaXVRL04Q+0x8aruNsh7LUfMC7uNmW1T3s1KiRz6JTd8IpUqUwyyIMbSsvZCGbF/jzSpb02DsHc47V1xIXvRqLonchzyzxxYCTjFud14cGGtxHl9v3sBpmz6UaYpdnXpcjZuKPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479016; c=relaxed/simple;
	bh=O1FgopGcYJ35ObRP1Xk/qskuRkSW8a6T+txTQ6TzWj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=heYiCwlOPe5K/JMoDkz+BHCaUIGLACdRu9WKl+zNbjoWUU0/Abutx0xB70CLwigFDmZop3IhdmalD4obLY/racqP5YrpbqivL2wWE1anbs7JFunbSFLVtFoEUOcvPE0KA2Pz9dA8MhPCZ/043wqKcB5cLSmzEkG8Xk4r0mvOxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8Qfom2G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740479013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFvercYRlsaQmbbEmex586DDS54p3SFZRkpRH2olSTU=;
	b=f8Qfom2GnJ3Vkhe+bNjPjBhKXN3hfLicacATPGEQAbrRXlvVTFIdagHv8PA1hs05dFZEAS
	HAyW/kIl2oPkKAI5HX3HHrImfe9vY+HDhJT6Id1YJXh3utnkfTTXDwcQusXcj7DtXP0ujv
	F6ZN3EjdlM4Bw8Y5SVRBq+h1ja+Dn/U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-9LJNOGQOOK232ijti1njtA-1; Tue, 25 Feb 2025 05:23:32 -0500
X-MC-Unique: 9LJNOGQOOK232ijti1njtA-1
X-Mimecast-MFC-AGG-ID: 9LJNOGQOOK232ijti1njtA_1740479011
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43947a0919aso51619755e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740479011; x=1741083811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFvercYRlsaQmbbEmex586DDS54p3SFZRkpRH2olSTU=;
        b=lJwYe1Z8faKMsDHU4LO0iACJI1cPsJO/bwKebs6TpZ+7dQhL0V41ub7RViWowlV2mK
         kSL2Pnuh1X292J92TImd2RleFtSbCCf7IN2GPDpVKV5z4tlwZBQA+AWdCgZJKztrijKV
         BLMlH+TR4yRqJxTOCFK20GuMvrZpt8/sRaioOdPgYTqAjogX7PhWciVEPpJm/rYqPLWx
         DkYoGamcXxdzrSI33GrUHiXRvba0l5v/pATow3aiHV4/YmBRSc8roKOepegCFW/zfjRb
         3ZU5ks/Qrz+/IxwxTQ07q4Ti4S036BNo0uL1bMeVQfibCy43TGtPCDcmA+wgIFpZJ9nr
         1cpg==
X-Forwarded-Encrypted: i=1; AJvYcCUWhPmKyh8c/SDVXrNW23++46ZJpgMWMzU0QvkuR5VgBOXVURQB8Uzybs6yvRoPIVDlZuw7hU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCwnzpuYdgBVxE6h2o7RqDxJwRthq8yPchZqhpq7PWI+BrGcaL
	K94MV/9jLqRonp9lNdx36us3I5o9RLwWmh+1UrG6nLw0Q/DdYoX/AEiBKnhHsj3aPA8pW7IFfCP
	iV7SgJWNK3FV+qgZdNBLN6+b1t57+AaJoAJIikbUozYlOOVUf7I0TfA==
X-Gm-Gg: ASbGncspdIHLBamOKG1zj/2Zbw+VtnZK28urd8PXdwid0V/io2eZ6k3XMARKks4aGRn
	Cw9kz7ubEFxtggQJGC7ZfzupFnlMPNfDXPF3yzKfdc+LJNb2O1AZPtcLGtqHO3iNnLUIFGUxQP1
	1J9iPk4pS0JLUbDTCvHFwY1h1kDTMvPWkX5jHi7dC5x04x/kkfYrPIUVpRyfpT2cxfr4BoaHm3J
	G0A2A35q+L0nAZiFJnNUfOf+lzs1/NDMH1xPdSnHUSbDqJTXhP120JJ34DesuSR2yxJC1BrqWDT
	oSaQn1qYeQXXNU7lHNe7YOnUqIMvGVmIkTB3Smqq0lA=
X-Received: by 2002:a5d:6d8c:0:b0:38d:c087:98d5 with SMTP id ffacd0b85a97d-390cc5f573emr2347338f8f.8.1740479010969;
        Tue, 25 Feb 2025 02:23:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz4JZUAibWUrdhy9yrIVRgWtK2z4/VkN+tAG5NwhKKNfEC0TXMFvvpKpTwouW0wrrU1Rw5vw==
X-Received: by 2002:a5d:6d8c:0:b0:38d:c087:98d5 with SMTP id ffacd0b85a97d-390cc5f573emr2347296f8f.8.1740479010610;
        Tue, 25 Feb 2025 02:23:30 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1532f20sm21118625e9.8.2025.02.25.02.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:23:30 -0800 (PST)
Message-ID: <9d381da6-cef7-431e-be82-fd2888fc480a@redhat.com>
Date: Tue, 25 Feb 2025 11:23:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 01/20] net: Introduce direct data placement tcp
 offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
References: <20250221095225.2159-1-aaptel@nvidia.com>
 <20250221095225.2159-2-aaptel@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250221095225.2159-2-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 10:52 AM, Aurelien Aptel wrote:
> +int ulp_ddp_sk_add(struct net_device *netdev,
> +		   struct sock *sk,
> +		   struct ulp_ddp_config *config,
> +		   const struct ulp_ddp_ulp_ops *ops)
> +{
> +	int ret;
> +
> +	/* put in ulp_ddp_sk_del() */
> +	dev_hold(netdev);

You should use netdev_hold()/netdev_put() instead, with a paired reftracker.

> +
> +	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
> +	if (ret) {
> +		dev_put(netdev);
> +		return ret;
> +	}
> +
> +	inet_csk(sk)->icsk_ulp_ddp_ops = ops;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ulp_ddp_sk_add);
> +
> +void ulp_ddp_sk_del(struct net_device *netdev,
> +		    struct sock *sk)
> +{
> +	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, sk);
> +	inet_csk(sk)->icsk_ulp_ddp_ops = NULL;
> +	dev_put(netdev);
> +}
> +EXPORT_SYMBOL_GPL(ulp_ddp_sk_del);
> +
> +bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
> +{
> +	struct ulp_ddp_dev_caps caps;
> +
> +	if (!netdev->netdev_ops->ulp_ddp_ops)
> +		return false;
> +	netdev->netdev_ops->ulp_ddp_ops->get_caps(netdev, &caps);
> +	return test_bit(cap_bit_nr, caps.active);
> +}
> +EXPORT_SYMBOL_GPL(ulp_ddp_is_cap_active);
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index fbb67a098543..771720c6e0da 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5474,6 +5474,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  
>  		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
>  		skb_copy_decrypted(nskb, skb);
> +		skb_copy_no_condense(nskb, skb);
> +		skb_copy_ulp_crc(nskb, skb);
>  		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
>  		if (list)
>  			__skb_queue_before(list, skb, nskb);
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 2308665b51c5..bcb8055bbb0f 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -346,6 +346,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  
>  	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
>  	flush |= skb_cmp_decrypted(p, skb);
> +	flush |= skb_is_ulp_crc(p) != skb_is_ulp_crc(skb);

Possibly a `skb_cmp_ulp_crc()` helper would be cleaner.

Thanks,

Paolo


