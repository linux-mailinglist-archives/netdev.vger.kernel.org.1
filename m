Return-Path: <netdev+bounces-109882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E434E92A273
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D40E281041
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AF180034;
	Mon,  8 Jul 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqAbNyij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740D80024
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441048; cv=none; b=kmrYHQZ4U3U59OGJLRHvac3piIR6wkxUuyLJbeD9d2FFLc930DLon/LujLo5kv2uTirxF7vQE6Z19AmJdLZ5Y7JvpHz/eqkj3C8GZrVVfWlcBWdXqVurFNHz4lqrkWNv+WBkiRblcbmhaX5TPzpNXLLD5VXUiQ+19wusooAUWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441048; c=relaxed/simple;
	bh=cNgG4sJNFrKD0CCkWlyht1Xiq6Jj6zN3B05I5LkJwsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCpxt4TZeM6yWIT82OOi9NR4CTwop8tDj20e0Y90ITf3yKYB3XKoq7TvL2YphNPDASfq9xyCrxMRJ/CoZMr/5+B0Sf0uY77nwmc1CjSkDf/ktXgXp3IbTODB6cIu+30GlR7OX1fEwXBzFoVkFUJ5RHSsISlQVCnnhbL9ETTGs4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqAbNyij; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4265b7514fcso13662045e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720441045; x=1721045845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mh2PihSggFxhCtx/jCViYrh994DXTDX0aEr2FXB2Ac0=;
        b=QqAbNyij/nfAMOVoDV4h/18yEvGIwD7DBQw/+00gV0PCNoDgCKiz4vTESWsrcGCgae
         al3wcuh5BtuWShvNRMhJ41kAlXmbelLeBtXCiOX5l1lF3BWL+t87N2tosTePh9O3Yod1
         JOCVPcbCzKBhakC6vhLe99A4Vyct2sn0nKLRRj0kevwCrXoHTNMnIgQWbyq4uxU4N+s1
         l9Uqwvdbr2/6yIgKSu7rIa59K1JqujG6QS9nmHYYP4+giY/5/DOS8oY2WnBqyJbq1Nsw
         fTeB0UPTv2BfNT+T7mvploRbjzXJCWpLEIdbfVlAz1toIHsYwrgwj+ucsUHuv4pF38mn
         maRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441045; x=1721045845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mh2PihSggFxhCtx/jCViYrh994DXTDX0aEr2FXB2Ac0=;
        b=FBCl9z8whgZEOvnp+vcMbxu51JVf4SdI5bk43d+bJuyd199ezNFn8OiOcxusfdW3NP
         niFIwN8U5Tltkq3C0og45pgrsxs/CR3F+/Jiwj/2OPIPwcG1NgPV0P0gHbrQOLKzWB7p
         Gb7l6v6tM/RS4GAMtSDZJZdVkdLSnCYxY1S9ZAVS3Ksq2mNgjrH2WbqYMcvFFPlVXwZ6
         kHisH0LPEqqtlNbeiCR8fo33b8l1EShbCqGPnjnr60KnFwEvAwdTJsYKkHG+S8fVT1tN
         5sdo2OjcB902A8kG6o4Sk1m4tkJ/vnVXBbu4bA9q3TYNEbeIsY2IbfI4CAtuGdki8v3D
         XAkg==
X-Forwarded-Encrypted: i=1; AJvYcCXzJkZouBpt+0/FB1HhIVAk4P4WECbJ+UO/wIiga9ee1td3llOKDo0FdbUhZXCK1/HHOtBMFGE3ureNBAv8Y60Gd0e34LQ+
X-Gm-Message-State: AOJu0YxVytidRai7gV4vVwBRBataRO+mlC5ARYCh7DPE7cSivWA6hE6z
	BzxFYxpdbbnwq6CvVQPJFWpQicoZ873g9nDQ0R+Yr8WnzqfTiDI0txAbJA==
X-Google-Smtp-Source: AGHT+IEQZk3svFexBPCdHAslaqMJPtvYt92u2/VjNX3ZhUMIEP4X+SS0wse7+I+yt2TRh7bXw7ZxNQ==
X-Received: by 2002:a5d:5708:0:b0:367:40b6:b90b with SMTP id ffacd0b85a97d-3679f6e4f21mr10425619f8f.10.1720441044770;
        Mon, 08 Jul 2024 05:17:24 -0700 (PDT)
Received: from [10.158.37.53] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d6435sm160466815e9.15.2024.07.08.05.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 05:17:24 -0700 (PDT)
Message-ID: <d1dba3e1-2ecc-4fdf-a23b-7696c4bccf45@gmail.com>
Date: Mon, 8 Jul 2024 15:17:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 00/10] mlx5 misc patches 2023-07-08
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
 <20240708105823.GL1481495@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240708105823.GL1481495@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/07/2024 13:58, Simon Horman wrote:
> On Mon, Jul 08, 2024 at 11:00:15AM +0300, Tariq Toukan wrote:
>> Hi,
>>
>> This patchset contains features and small enhancements from the team to
>> the mlx5 core and Eth drivers.
>>
>> In patches 1-4, Dan completes the max_num_eqs logic of the SF.
>>
>> Patches 5-7 by Rahul and Carolina add PTM (Precision Time Measurement)
>> support to driver. PTM is a PCI extended capability introduced by
>> PCI-SIG for providing an accurate read of the device clock offset
>> without being impacted by asymmetric bus transfer rates.
>>
>> Patches 8-10 are misc fixes and cleanups.
>>
>> Series generated against:
>> commit 390b14b5e9f6 ("dt-bindings: net: Define properties at top-level")
>>
>> Regards,
>> Tariq
>>
>> V2:
>> - Fixed compilation issue on !X86 archs.
> 
> Thanks, I have confirmed compilation on ARM and arm64.
> 
> ...
> 

Great. Thank you.

