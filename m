Return-Path: <netdev+bounces-113165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A668E93CF97
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 10:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6521228280B
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 08:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72071176FA0;
	Fri, 26 Jul 2024 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iO4EBk4t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D301E176AA9
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982230; cv=none; b=pSrsOq6rXgMDCD3DHz5xkN8Z8ET/5Obwgmz772c1vG1PyZwgc2T2Kw5Sj16VBzLIHRbNrdWnXoIyLa3R+DMYY+2Iayw9nTy5Q/74jQv1NacbFPdJFu8WX/Wx9+tXIASd6P8CEQybcVXMAVysjfJB3zd0rFGQgrNlsMNPmq0fDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982230; c=relaxed/simple;
	bh=V9W5+OcL4dtcPDuVIRDRDKUFfYi6CmrQZMZhvwyfyhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKvvOdM13X/bD70DBeF+b+tOP3TFqyrZebcPSpmwfDXztwSKm19NdPNtaiPPcYuHr/GvOOx80PGA0X05PKRh+scsutgdXyHqtaX/6gYe/3BtvBmmMnfNBP7vseZA83YyRLtmkV/Hhs8qn17FxcewBgUGebo8VIL4VSOYri+IT7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iO4EBk4t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721982227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYuPDPFmQ3yjKfaNaXYatDsZSH0jFsHP0pvY2Laqfrg=;
	b=iO4EBk4t7w++zZggIWYYbo5jTUx1dWEwHR/MT2kKsLqKgRVZF7LkPhDCwhoJUTdDh4R2DP
	OFBy/P1zyZmhJZ5Qf2ndAWQZN3BXtpY/hj0qpiE8F1dYaFSf/tNaKrcQuvdPFoN0UIIPOD
	UQrYQ9TFRL1Px28vR6lqHCyRjFs1OhI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-s92hiIzkMuq0ahAH4_AbXw-1; Fri, 26 Jul 2024 04:23:45 -0400
X-MC-Unique: s92hiIzkMuq0ahAH4_AbXw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42808f5d32aso1844915e9.2
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 01:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721982224; x=1722587024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYuPDPFmQ3yjKfaNaXYatDsZSH0jFsHP0pvY2Laqfrg=;
        b=vzm7y2wpaBwkaHlO0VcdviHga/WIGlJWRWQxMJc2ghwxT8ZDCFr3na5Cs74E/hgHpK
         s4Xy/gsDSFS7KCWfF9WgNS1WORFEfK9zXVrBHqHdE0cvoYu07cufgnFgMdCAczNgZ5Gc
         862pvcqFmqff2nscHqc083tcw2BRRmDAVfTufnq2uQ+JqvnCHNxMexJlLOjhXo4+3cvn
         HYStcto92P+9eagBWFczIeUOLAklzv+UItVbLLcCmV6lFMdm++4Ct7OJHCcCTsP7P3PF
         +Nh20/2REw7cyJHaWQTLMP6z9DcFrHRSJmYAC16lUQGBMhi900H2j/xysRl8iHi93jZ5
         ls8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuFes4GpdyiFf9TlaFvKCYy0my+0lMCs0AjXgec1hUg20SfpJTffloh5/Uj7gOHn50jckN7P29Up8Xa+nslcvwVK33mpA4
X-Gm-Message-State: AOJu0YwMzbC/qTGQgWSP0HhB28blvRBEH8Vf5j1uj/KyCoO3GIjIqz73
	kptuLBpEcH99V0ijB/S4t9TdKQ8A5SkO1ZlQoR1298b/17um+iSHzdcowLKsNWk70b2JL3avhnV
	NHqCYjDmmfFdUYzogKcenTYcyN5mGTKJpEDc5RZhOV7DCSHjkgEmTbg==
X-Received: by 2002:a05:600c:3c89:b0:426:6ea6:383d with SMTP id 5b1f17b1804b1-4280543f1c8mr20335325e9.2.1721982224359;
        Fri, 26 Jul 2024 01:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHr0dd8is+ijDiLASGm8eqohX/NfIGiuAF0U/2jvpWsvaxTrL5TLr8c0hkyCSRSF+/LwfgsA==
X-Received: by 2002:a05:600c:3c89:b0:426:6ea6:383d with SMTP id 5b1f17b1804b1-4280543f1c8mr20335205e9.2.1721982223806;
        Fri, 26 Jul 2024 01:23:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b099:1310:2725:cccc:c3fe:5a02? ([2a0d:3341:b099:1310:2725:cccc:c3fe:5a02])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280573fec6sm65499645e9.18.2024.07.26.01.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 01:23:43 -0700 (PDT)
Message-ID: <bab2caf1-87a5-444d-8b5f-c6388facf65d@redhat.com>
Date: Fri, 26 Jul 2024 10:23:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 mst@redhat.com, jasowang@redhat.com, arefev@swemel.ru,
 alexander.duyck@gmail.com, Willem de Bruijn <willemb@google.com>,
 stable@vger.kernel.org
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/24 04:32, Willem de Bruijn wrot> @@ -182,6 +171,11 @@ static 
inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>   			if (gso_type != SKB_GSO_UDP_L4)
>   				return -EINVAL;
>   			break;
> +		case SKB_GSO_TCPV4:
> +		case SKB_GSO_TCPV6:

I think we need to add here an additional check:

			if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
				return -EINVAL;

> +			if (skb->csum_offset != offsetof(struct tcphdr, check))
> +				return -EINVAL;
> +			break;
>   		}
>   
>   		/* Kernel has a special handling for GSO_BY_FRAGS. */
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 4b791e74529e1..9e49ffcc77071 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -140,6 +140,9 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
>   	if (thlen < sizeof(*th))
>   		goto out;
>   
> +	if (unlikely(skb->csum_start != skb->transport_header))
> +		goto out;

Given that for packet injected from user-space, the transport offset is 
set to csum_start by skb_partial_csum_set(), do we need the above check? 
If so, why don't we need another similar one for csum_offset even here?

Thanks,

Paolo


