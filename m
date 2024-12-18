Return-Path: <netdev+bounces-152908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E41769F64AE
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09091691DA
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E0619F103;
	Wed, 18 Dec 2024 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU7CEYZe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686519939D;
	Wed, 18 Dec 2024 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734520631; cv=none; b=buRz31TjmmQ6k6xX6Jp908iu8CUtDIGvBTY0FcoD5Rj7n9DXo5kyPp9Oj3CUdAL7DIEFcr7184Lc06hQSLzq2VA8d8fo3saTxqowqT60SwpyeAwjAfFw+203+pKR0vM22OkMeDzEaUH16PiedJXUnAoBkpFNTMeyaxJXmvGX4Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734520631; c=relaxed/simple;
	bh=0g7ZRLLkMCnVxeqL6Z+cStGdJI030IIUaV0Fbw8B0sA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=i/JEnan5KUtWyLJvSD3pVAOktExgtT7dbkexvrHTgbuZjZXjd/3vGQpSQ02hbtaC/eeKuL7HFL5Mg95yW7tqjfHXv1WzW3cBvLJuLoBycnw8LJ+jEF1+4m8DqXZJ3YhJixsnRl5m4D1zUr7V9fslpdp1YUFnLsNacVdK3cQuWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CU7CEYZe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436202dd730so45538145e9.2;
        Wed, 18 Dec 2024 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734520627; x=1735125427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1s+2TGeEw+GH8Eu09SMgINcA6qH0dwtnjAOICu4c8HI=;
        b=CU7CEYZeN3w08TmQ8QZ3jPJuwIHp0orzLAjmJQmy+VFM3jpgPxKNfwyzhZ1zA21xO/
         ZCCP5BPB6mek1dzLWxU0kAsY1WqdBDlpGeHvf48Grhnko3wELm7yTHADnxz8aSGc/O+X
         Lc8I+FhAgqgi3Dqsi/0yLnKlKdw1uO0wbDV4YfDuZFvOzoUFboPf8zwPBCJpH7ThQQKc
         Vd38j8lmtZmBcx3xBnyGqG/rTtRU2j6Vj1M/sLAc68odXoe5gfMlpxbXEFZD/im1l0uD
         uxCvDt53pyYuHzcPXn0MkrvZdHrGzL8R7yfMHSf6DpHjIdHJ1ueq1KIqwKmJArx+TYGw
         yaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734520627; x=1735125427;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1s+2TGeEw+GH8Eu09SMgINcA6qH0dwtnjAOICu4c8HI=;
        b=ZX6Gcvk4xaHokL7roXB9pTjtis9qRsVNpoS92Cis1iv+gAIMb2yd6JZmpIez4dpPbP
         ylDpAtLPHOJ7AsCyJqk7QoM+Bp8UZMClmT4wO5mZyS93HO2p9doinLrgHa1lqAoI2nwY
         fSGeHDcXdmiQ1p7zz8alwqi5woUAxlQt/6fdVCdDles1bE/IpOu2+cbf2X3cUQYo2Tvn
         ppp2isFefv16k2VKSQFyHywfsIpCcTzQJVQvtiyWAoka2YyrqvZUh9NaXmOP+aJ7eccG
         zWV8NjE7QeTVVSsP2+hAFxBtlV0TPXaS6NJHbsyrT4JxP6d05jCEbsgmCrKdiERWrv25
         nnbw==
X-Forwarded-Encrypted: i=1; AJvYcCUdtrhv9fCyg60VLTiV2/ekoRBUy0k5QEZnjslaaSP+xBB3MOYyfYfu4+NFp6I2fiKwzsPPX3STE+E=@vger.kernel.org, AJvYcCWug4Z3Q2QpbTTVbyqVXT1vgKK2/S9P+4gE7uwOzHr2qlkSvHDe+fandeZr6b2K5bvRkgfqowHG@vger.kernel.org
X-Gm-Message-State: AOJu0YzuXVZiKLW8JyjUM0Dl4HA0wflEE+A7kFQA+OdAXrLLQL0NhjAC
	ea1wdTUgtjL/kzGvY/51bqPPwsvqmOg+rc6Q702AmgS5ZYYrtCdP
X-Gm-Gg: ASbGnct96dk3AKx2PxNnBCq+bFacOX/w4T9nV4QuUPjeMKkSsuTmcbAeChLQNIRkklF
	2mi5lcnXk/qq9apunx3s8fhby1AM3CxS3h3n2GPkU4GWTLlLIHfsIXb8k3iqz9ghE0Hio+Z+jln
	gljyfY3wp9w8PLD+eVrlCr5PtdxKpkyC52w5MCnNw7j2WQ5PCn06VuSs8xafG+TgD11ENPqTMPQ
	xtrUouY5+29y0DHnyCRSM7u6TOQB9XecJVoGI9/2e8srCc9vTQMHX84SaDT5lXc+/vHjPdhsL8W
	YACAGLj2+/Rj66svB8yzRPUdpL2mcWhaiO+eP6GT2a5g
X-Google-Smtp-Source: AGHT+IGBoPrBdALKcs8sjwLUrOoXT0m61mj/vt2coJ4TTQW73voS3kTZHbGhPxA1m5CgoU6fNToz6g==
X-Received: by 2002:a05:600c:3ba8:b0:434:e8cf:6390 with SMTP id 5b1f17b1804b1-43655343c1cmr19812935e9.6.1734520627337;
        Wed, 18 Dec 2024 03:17:07 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656afc163sm17040615e9.1.2024.12.18.03.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 03:17:06 -0800 (PST)
Subject: Re: [PATCH v8 16/27] sfc: obtain root decoder with enough HPA free
 space
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-17-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <ccc0e0e5-b430-726f-ada4-5346c0e5a4ec@gmail.com>
Date: Wed, 18 Dec 2024 11:17:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241216161042.42108-17-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 16/12/2024 16:10, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Asking for available HPA space is the previous step to try to obtain
> an HPA range suitable to accel driver purposes.
> 
> Add this call to efx cxl initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

