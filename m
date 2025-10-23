Return-Path: <netdev+bounces-232076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F4CC009EA
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 669DF4E9820
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5F92FFDEA;
	Thu, 23 Oct 2025 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIiRUlId"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6827E30ACF1
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217418; cv=none; b=RYhiyFy0/9uUhmc4inOkJ38TvqgAeqloDEYDSe/LcCkgJFjY28ima51sImRLsBNqtiazTM5Gps2MTm5BN3f/9UxlMR5Dg1axIgpuIQ1twDVhaLAKhIlwqb1InOkuoelLLOLcUtFIFWSZK+hg95a/NFd+5XFaw0u5C10kASLW4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217418; c=relaxed/simple;
	bh=2/gABdtSagvvRvXcgYkvrUxlpN85FD7cuZAxp8ojVKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJWvzQL1x83HW3kOHlWQbzBHztl5Ajkp/uKKpGRkNY3NuOun00jFaf3goKXyxKYBByD+lxIL0KlNxvQ4ZVZFZqRr6Dm1/8bbyCz2HFvJb9s5l56chJ8bPuOm5vb5UM27kJZd+Lyp4WyMGwbkba6jqNCRvl3hJdsJKy+HIxrftsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hIiRUlId; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761217415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IffLhB/dtgzsB8Rx7XpZkACOwzSFp8CqfXzEdzYdCTE=;
	b=hIiRUlIdxT6zC8UC+G0bRntzMC2tGcX+rcAMEgKhlTSN2ykp4frJeTIZBkVOWYjvjVD7Sq
	d7a2tuaBkrvmmGxlxMCezYQDne2KJ13NqIh2Cpem0H6d5IlBDejJeRcRzeros/hUshvW7o
	60G1N5sG5qaovRyilCDeVbXHPYWhz10=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-aupCz0tBPtClb3bMMso1Ag-1; Thu, 23 Oct 2025 07:03:33 -0400
X-MC-Unique: aupCz0tBPtClb3bMMso1Ag-1
X-Mimecast-MFC-AGG-ID: aupCz0tBPtClb3bMMso1Ag_1761217413
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e39567579so3332405e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 04:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217412; x=1761822212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IffLhB/dtgzsB8Rx7XpZkACOwzSFp8CqfXzEdzYdCTE=;
        b=U/I3QipOWd48+s6a7GY6nc2jVpGkTmvd0UidkJLMeFtjrPE9AlcZ0LVRtMED+M9PuU
         KEgcrvsLPEj5/QtnZlDqSvp4VRZsuc14ZTt5/W9FVbJsx8FHkQ6LS1Wgm3YTqYYSBGeL
         BW6UepQeI9K7gexzah41DKnUH2HFPFRqo6+tJhlQ7hIJnpjVhfW8Rx7AdTp7dV1RPXtL
         YTTjyy64uIGyNi8eGePGH5PKp7VhwENF1HNbUqBi6z317i027l7Gz31GhetgcNKxsCrJ
         hVMHXKZLldxHFITKjvU5nfZh0b/i9TM2QTCvb5KGTQJzYbbXUsvrl+UbTG6fEKs+vGDY
         fQQA==
X-Forwarded-Encrypted: i=1; AJvYcCXEC8sOzwwwq8Nwfbjy6I+dxkNNV1UxRyfYYbD+C4iZC9Iy+wcQXtuLepOsrqjWWnyVWpF9EG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMv1bYcgYicU/E+RfCeN+bjFxOEWP89Spm2McWpLc4TEwuVbRz
	Fj+NwyWFJUzf2N3FEByt2G/b+psA9cliliW29WkuBUJfONJPMWKLOIIl8o0dGMLdteIFGkHwoeM
	2y9OARSFhvSudcBgjbIS2rVqYaDivkFIjjbQeibFAVXywb47mSYIgURyzDg==
X-Gm-Gg: ASbGncvn7OGcQeeNakG7KvEPS4bJpY8IGtJIs93eXJ/DcwYtR9pvU/nbgSTW2Qx8WaS
	65c9MKs+Ub06N7aTMV4SauNDANaUv51NX7s1kY7BJDeXXYnRb+pE7+1HeJCzzTqdRjCKZy/MFvz
	G+DrFfv9xdhv29ZgHbMKMUfh4x48qL8d0imVNwayvIwTXV8g24PcDsJwMpath+OyIQscb1Pc0dl
	AV6yPqP7HCsyiVXJQB3IanA/o2So4X7F8S2t3tXvdXmQ6iOeLl/hgPFGd8WrDNKy0df/RQYue1L
	0wSNrpxSGjhmbwcmC5BjYrCgSVvgMw+GQ8qM3dJzqiBkTQMX3D3iBetjeAZgq9xlfHzsvkVPEfY
	rmjr2rZbjZLKBXWEDQFCbcXeJRN5tUBFr8LWRHBTbW5jyYks=
X-Received: by 2002:a05:600c:64cf:b0:46e:3dcb:35b0 with SMTP id 5b1f17b1804b1-4711786d332mr203648545e9.2.1761217412545;
        Thu, 23 Oct 2025 04:03:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcmAKT0d5E/+UDMPzD2Uu8sJN+s2YwSJhnRUKFlKICL+VtTqA3NDebN0QlDpDV/hBH/3a+iA==
X-Received: by 2002:a05:600c:64cf:b0:46e:3dcb:35b0 with SMTP id 5b1f17b1804b1-4711786d332mr203648285e9.2.1761217412134;
        Thu, 23 Oct 2025 04:03:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ccc60sm3389854f8f.34.2025.10.23.04.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:03:31 -0700 (PDT)
Message-ID: <1fb1a9dc-e4c0-40a0-9536-82653b5d0598@redhat.com>
Date: Thu, 23 Oct 2025 13:03:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: alteon: migrate to dma_map_phys instead of map_page
To: Chu Guangqing <chuguangqing@inspur.com>, jes@trained-monkey.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.xn--org-o16s
Cc: linux-acenic@sunsite.dk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251021020939.1121-1-chuguangqing@inspur.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251021020939.1121-1-chuguangqing@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 4:09 AM, Chu Guangqing wrote:
> @@ -2362,9 +2359,8 @@ ace_map_tx_skb(struct ace_private *ap, struct sk_buff *skb,
>  	dma_addr_t mapping;
>  	struct tx_ring_info *info;
>  
> -	mapping = dma_map_page(&ap->pdev->dev, virt_to_page(skb->data),
> -			       offset_in_page(skb->data), skb->len,
> -			       DMA_TO_DEVICE);
> +	mapping = dma_map_phys(&ap->pdev->dev, skb->data,
> +			       skb->len, DMA_TO_DEVICE, 0);

It looks like here a virt_to_phys() is missing around skb->data.

/P


