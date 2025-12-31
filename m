Return-Path: <netdev+bounces-246417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0ECCEBA3D
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 10:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57B5E30062FF
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 09:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8C4315D25;
	Wed, 31 Dec 2025 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpIXZkj7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="chogrhxd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8062DF131
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172231; cv=none; b=jeV3pHPqdWZpotN6aJ+4yF57GaZAS1GI2Angbo0XLH14axY4Q4fmzrWDriSDZdg5CKwXt1a7emaQx8l1ztvYAVTBYcAG/3h4ivMwy6MYytH8gsTmB7gvdCKXYM/ZzObu6BHlS5Zi8Gg13jamNVOkiBaz+mC2na0ye1IahmzTmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172231; c=relaxed/simple;
	bh=C18oOaqpuCwjx9gb7fHDkQlJITpTiSH9l4nAR52DW7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COIhlkO4sqv97jK855eaMTBdAc4io2rOigftJ4ocXF56pKrwMsM3u6iBUr91Z4nctlBoOC09IxuPcCRL7FHSGFzH0EGajUviuAiRz2XCaDE+1i8wn/H6+1rEPqBjwRh9x+OKm/bXOC+aefdtjGy6pxp1c70vwK8bNaHniBdB5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TpIXZkj7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=chogrhxd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767172229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0XSnpLieWa7Aa1DEfVg5NvtYGcFd+UxijHC4TQDbzNc=;
	b=TpIXZkj77ylgkcPU3bC7Bk07eQ/07WpELnzTNaGjzDylZprnA7I+pErRvun3RF9+MT9tys
	/pHLHeOczbJ31z21XtbbN3Et4Kf0205OXUBQVGBwbHInd2rrimbvEtJU3Fz/iXAoxbYV6C
	v/eHglh+SEwhAI+jVcUF3schV5ryfTo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-69LU_SZFPZyDIcVTUbVxxw-1; Wed, 31 Dec 2025 04:10:27 -0500
X-MC-Unique: 69LU_SZFPZyDIcVTUbVxxw-1
X-Mimecast-MFC-AGG-ID: 69LU_SZFPZyDIcVTUbVxxw_1767172226
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477964c22e0so77150165e9.0
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 01:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767172226; x=1767777026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XSnpLieWa7Aa1DEfVg5NvtYGcFd+UxijHC4TQDbzNc=;
        b=chogrhxdz08zOkARufPmsY8rYUQqCAqwCvbQWDzqWwR7ZpoOJ13EeB/g0MsKdkAWPm
         XV9huJ+cLdahSBY3vZia6KHnKKMaCgYZkLuE8i5PNk9r1BaLTI1jT3BXXGEVKwTGr80S
         KiHFnePY4IuHDHKw/qDvWDCIKnX8VysYh49u5Ux++hCtD39vtl8wGcQh4+QwS1aC/IeW
         rKSbDxyh6EtQnZqejUtUP3Zs8BNzYyo453MHw/WseSSVJwvZsPRJG13+xgwmrZErNmCu
         lErVAj9+c42J6OvIqho8pBUU2iegaxioSLU9Xh40pGJq3XUaf5kGxR9WM47E5vzxKhTM
         o4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767172226; x=1767777026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XSnpLieWa7Aa1DEfVg5NvtYGcFd+UxijHC4TQDbzNc=;
        b=uSSXik9AnJ25v3sN0q0unfG0uFQLgLnLrnPbAbR9MXW8c99cWU/DCIBgTmNcpnOQNq
         6uiRKvCD/OSbKtJ5prhPhlpT1cZkmOryKvOv2Fq2eXG+XhDrSyXfgwRcmnVc+erRQv8P
         CxyqdAyy2jtdiqWY7Fzx6HK/TpmZMRJ0EV/BKMo3+jBygYR0nB6Hn3YOdWB2l4lL2V4n
         +nWD65L+4+I/6BegczfImZrBNiHcwXLXaIEfSRUGP7SjeNEx/vKxqQ25EwuW+R/LNd2O
         Q/KrTXlKVCo5XC4A2QkppBU7yADXdOHY7E0e8KniNhYkOhGGxrHGN+IwW1VKhnVBSi64
         as8A==
X-Forwarded-Encrypted: i=1; AJvYcCXQzAzWDq/Rq9v4iMg0FOHoIrgvk1C3NfRPZJyaQE+FDQ3v/1xN26u85Hvs76HfnVcbL97Vu9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaG3lybh2O+kcDBEmgeoBvH3PanycJCTqQMA1ir3SxI6v2Wo80
	ofgaqZsvGQE7+MoqfkaSQ6BD+KYOfB+K9aX4Y3pK3thXiOkNeS3EPJJtptIzX57k9PhqCsPCiVG
	MAdeaCiYb7GwXSNxNRShamPFNBQAce0wpkbP4B1JOEfLShioFLQS+aa5seQ==
X-Gm-Gg: AY/fxX55xTv0F7m4EoDiJT/neskRbn5WofSO6JCKp4edl5euZjMAtGdsRDZQeDhsGf+
	QB2sRTZCYZV2zybT7ax4Vksey3p1mYrGgLv02ZcU2FOwT6GmDYikfBFMXup0OjTcwvgUoQfvrz1
	hn1xC9syZPvQZkMHZFMQrWgpTxM/EsBTFlJStPdILITBLRYwlcYKPU1e2Oo+Mcxj4OorQJ5QPTv
	2uri49ojjxM8aBwycbUE42xUAAr0CQaiUEUILCtiVg8zVH8JP8ZEC9BJG34JvZ5exM9ME9mNMmE
	YZYFZ/q6rHav4l4DdtbaHE1phGAcrFh6askav1jRONsMQq+PDRpl+V26KV/utktntodNApzkRYg
	CkKfuDxzuzpPG
X-Received: by 2002:a05:600c:444d:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47d18bdfc61mr470648995e9.13.1767172226020;
        Wed, 31 Dec 2025 01:10:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEshNHH+OTSCO29vFtm6r+1hUti14MOz4PjprkTpUXeTQpWFCSpExwpsFWFv8OW7Mp06rf4LA==
X-Received: by 2002:a05:600c:444d:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47d18bdfc61mr470648685e9.13.1767172225626;
        Wed, 31 Dec 2025 01:10:25 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193cbc0bsm657122095e9.11.2025.12.31.01.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 01:10:25 -0800 (PST)
Message-ID: <fba600bf-412b-44d5-b2c0-bdf0194bd7e9@redhat.com>
Date: Wed, 31 Dec 2025 10:10:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tls: TLS 1.3 hardware offload support
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net
References: <20251230224137.3600355-1-rjethwani@purestorage.com>
 <20251230224137.3600355-2-rjethwani@purestorage.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251230224137.3600355-2-rjethwani@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/30/25 11:41 PM, Rishikesh Jethwani wrote:
> Add TLS 1.3 support to the kernel TLS hardware offload infrastructure,
> enabling hardware acceleration for TLS 1.3 connections on capable NICs.
> 
> This patch implements the critical differences between TLS 1.2 and TLS 1.3
> record formats for hardware offload:
> 
> TLS 1.2 record structure:
>   [Header (5)] + [Explicit IV (8)] + [Ciphertext] + [Tag (16)]
> 
> TLS 1.3 record structure:
>   [Header (5)] + [Ciphertext + ContentType (1)] + [Tag (16)]
> 
> Key changes:
> 1. Content type handling: In TLS 1.3, the content type byte is appended
>    to the plaintext before encryption and tag computation. This byte must
>    be encrypted along with the ciphertext to compute the correct
>    authentication tag. Modified tls_device_record_close() to append
>    the content type before the tag for TLS 1.3 records.
> 
> 2. Version validation: Both tls_set_device_offload() and
>    tls_set_device_offload_rx() now accept TLS_1_3_VERSION in addition
>    to TLS_1_2_VERSION.
> 
> 3. Pre-populate dummy_page with valid record types for memory
>    allocation failure fallback path.
> 
> Note: TLS 1.3 protocol parameters (aad_size, tail_size, prepend_size)
> are already handled by init_prot_info() in tls_sw.c.
> 
> Testing:
> Verified on Broadcom BCM957608 (Thor 2) and Mellanox ConnectX-6 Dx
> (Crypto Enabled) using ktls_test. Both TX and RX hardware offload working
> successfully with TLS 1.3 AES-GCM-128 and AES-GCM-256 cipher suites.
> 
> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.


