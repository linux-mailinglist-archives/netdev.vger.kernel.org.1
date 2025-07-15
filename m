Return-Path: <netdev+bounces-207189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CB4B0624F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8463A5BF6
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCEA1E5B7B;
	Tue, 15 Jul 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y66Kzpmq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4BA20408A
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592008; cv=none; b=X8PVvNo8EJOxJCojKUV0PSNri+lhmzagIkeKxcJslBQAQvh2487BvI1fEFlJ3e/E2KfDtGkpmMmdSUj1VAWv+hPKP7T9ug+QiKsdyovdnMKsuiu8dAZfzRPSSmZJFR8f+cOgLdewqnlwPIsACo5IHXLIAtquT8KlqAtyAKUXCF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592008; c=relaxed/simple;
	bh=KmoH98o7KPpXa931Ekmr4ULJg/wqhFfkJe7O7WD+5ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozQlt/YbaKt053YyILeLM3boUMLM/CSK/r12Bwdx7hFYAVb/NBjIJizzbdNQMcwMxp47Uaqk6KYjRwxDbJFBfJE4oJlqd5En2IaoyCxKy6Cxpxrmv4ZGAjmFKO8nN8hKenAXTcKsydEGtQpsrJ0T2H/buu+PAMXjYVpSUSAeXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y66Kzpmq; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3da73df6c4eso44526445ab.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752592004; x=1753196804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6w/sVb1V8AHMK+B7FCKjsSM7VP3W2earJ8E8o0cKdaE=;
        b=y66KzpmqI+ATFZ6+jQ0f2bh/DeEQI8PXiCHKCmakv+B/Ojb3X66cD+FwmH0GNxzGr7
         64nkQtb3XPBa7VZnJxIXXiKWZuCahueihks7f3pzzlGXeAyxbLB2r0tCEejWlN88NrrN
         ltkMqz6rZnpFxwrci1D93GqQDfA98PB6oBevg6H5i+BsYtp5C3v8TG80s/XYWZWJjwL5
         ir4mtCQFmY+7gxNTOvCLeo3DsacGWpF4AgksPGTabUr16rhDCwQk49dGaKLSIIxW+vmb
         RRBb6TlGNM4lnSycbISe6+Vqhit/X8zW+7H2/xeGJjW4y0uiCixuIQVDFNCtI+dDMOKM
         W8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752592004; x=1753196804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6w/sVb1V8AHMK+B7FCKjsSM7VP3W2earJ8E8o0cKdaE=;
        b=tsUjvgR97Zg8se4jSMKXhBfldCsqqg/uH5CCdT3NbEEGORzGyKIAm3x/h+MbLIVjwr
         bIjpxSXaQSUSLt72jqCQdXprace5FN8+v3Qnzfit/zFEuUPc1ErAkFR15ZuNO9sRDeqi
         fc5NLcHfIV1bQBdA3T0/lMv/SWfw0avz0hQlGQp494vVGKV1pLk2fBa2M35lVxVPhxXf
         d+tjUkMEAuFFNdKwLJBWzQNoJ3F/6ARX3rI4o52uDIWUirxqaw64dmYFis2whD3UVmY5
         UEH9a00Jd+IFSCAQUpnVErxo9lfAz7aABLEOf43sqkeAqdy++58KEdtp2pRfNbn9xeUz
         PQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6zRSfn78Us5XwFMLt6vUhTkUnVUj10i2/nxLviKtrhr6+guxalzrsMcMxo9S9hAniGj0Kzeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2XnBr1IddrSPgD8e8zV5rH2+/FbqDDcPhU3Ng4zR34nxG0Ac+
	4TL7dTpL8wFQTR7xmbYdaa1HdzZgClfken9j83ePYcW6YhCgYWRjXdlGAhfMAK9DV3o=
X-Gm-Gg: ASbGncub+fME5bjsJRrN2eSCsyOCRWzehwcujJNtc7TlQygYedhwBX3Mi0Xe3dWx0l7
	ROdSsJcuWXI0Q2ooZ29+wZZLz6yokAvrKxM8rPbDs5Fg2EJkVZomnHvlo/P1v2Smwho0OCqZUi8
	KdueZvHYiTbf13HkUPP4X+CdfnIa6SptGujBWiBwhAKD1MtHI/sGu7+ksg6ML1L74M8tNUFaNNU
	Zu0bFyHLrIt6Z5zyEMTb3J+pXX155dnNRwLMaIAzHugI19LIQYb/KBT55pAnukW0oxoAMiWqymV
	AJ0JPcVrLQcCyzJ/KaG3RZcM/ud1/hIV+yPuWIoPlRprwdov/LOAxpdZTLAaYCsyuR486EysN1X
	l9DDaxm3tsu8svM/7U5M=
X-Google-Smtp-Source: AGHT+IHqM36QTp5FzfU26d/pDIhI7/8WfKRgrZUTQ/M+sQpnXNIDnRX6/CHFUrNquCYxmgforbIaeg==
X-Received: by 2002:a05:6e02:3bc7:b0:3df:3208:968e with SMTP id e9e14a558f8ab-3e2556650e5mr160301715ab.14.1752592003826;
        Tue, 15 Jul 2025 08:06:43 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556b0f2a2sm2603895173.124.2025.07.15.08.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:06:43 -0700 (PDT)
Message-ID: <59fd61cc-4755-4619-bdb2-6b2091abf002@kernel.dk>
Date: Tue, 15 Jul 2025 09:06:41 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30 03/20] iov_iter: skip copy if src == dst for direct
 data placement
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
 gus@collabora.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org
References: <20250715132750.9619-1-aaptel@nvidia.com>
 <20250715132750.9619-4-aaptel@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250715132750.9619-4-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 7:27 AM, Aurelien Aptel wrote:
> From: Ben Ben-Ishay <benishay@nvidia.com>
> 
> When using direct data placement (DDP) the NIC could write the payload
> directly into the destination buffer and constructs SKBs such that
> they point to this data. To skip copies when SKB data already resides
> in the destination buffer we check if (src == dst), and skip the copy
> when it's true.
> 
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  lib/iov_iter.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index f9193f952f49..47fdb32653a2 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -62,7 +62,14 @@ static __always_inline
>  size_t memcpy_to_iter(void *iter_to, size_t progress,
>  		      size_t len, void *from, void *priv2)
>  {
> -	memcpy(iter_to, from + progress, len);
> +	/*
> +	 * When using direct data placement (DDP) the hardware writes
> +	 * data directly to the destination buffer, and constructs
> +	 * IOVs such that they point to this data.
> +	 * Thus, when the src == dst we skip the memcpy.
> +	 */
> +	if (!(IS_ENABLED(CONFIG_ULP_DDP) && iter_to == from + progress))
> +		memcpy(iter_to, from + progress, len);
>  	return 0;
>  }

This seems like entirely the wrong place to apply this logic...

-- 
Jens Axboe

