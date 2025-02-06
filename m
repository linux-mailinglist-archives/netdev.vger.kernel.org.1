Return-Path: <netdev+bounces-163312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA59A29E70
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8CF16816C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 01:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ECD26ACD;
	Thu,  6 Feb 2025 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCbmBfk3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C59D14286;
	Thu,  6 Feb 2025 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805829; cv=none; b=Q0RVRBMWnlY3wGHxHJMA3dl457hNTNwTeE8mKjTQKwPV3Rf44wSS6X8LRcwQdsXY8RF8Ihk5uoBlT7365tXCxCPfS6+9FCVOuipat0bk24FgI2ajtZz6fUqZFQh/1JMPqylQ211ZLxPnUYbGlRVSfNfocwvzSIe1eaV1Odg+0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805829; c=relaxed/simple;
	bh=YcdeN1ahZZsypY2lSFmere/9Uaiax1qqc0zOCMjyLlg=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HzopI0v3XjXJhaetddM9u7f3PXgFfJZMDkW65CqfYcfolqLKpzcHYg1UDBTqYx+TDYVJ3X4xM9NTGauCVFE7QUEi46SdiqEmIjUw5VoRDnP5iZpZ1nNQPgEw24bcdTt9NEl61pNJG+3goYT5zNLdhd/irlabgtYDqr6AAkaZUpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCbmBfk3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38db104d35eso235117f8f.1;
        Wed, 05 Feb 2025 17:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738805825; x=1739410625; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHccaMmLPBHpXcmtpDogOeGkxvlVKhPd9Vsau1t3lXs=;
        b=lCbmBfk3nYMswkqiJh13qe7wbKTSc9JaYV14MTXrcr8nlEjGmDgbqAu6seb06Z+0hB
         HnwUIJNJeQ7ERcs5B9QKp0X/rHjEbBfGKmgWIRCq392N/Y5P5BB2AceMCU0ZrRF6kgg+
         ohRVA9+ROWmsXm9ace60T/P4JGAS8HvdGzyN2hnIYVgurnCDBYdHSZFCSbPrV205oJGa
         Ep4u5iMkTnoG7erulyCoo76QtjaGP9eoaTTDG7FkuKNDQgZblfSiG5bdH7GhUh/UqLEi
         M28lbQejDKZ0fEFGrA3O0iOvpMQtWjEZ3fNY0A7LWNUPvnpbivUVz2OEkoD7IS4DlpwI
         hqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738805825; x=1739410625;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHccaMmLPBHpXcmtpDogOeGkxvlVKhPd9Vsau1t3lXs=;
        b=vStux20untUgzRBgEEbZgIxAdJ2qmsUFT8ipD1beyeY+AS0sWeRBoQq397WbwFWm3A
         ztLKEH6FZ+WETfjxgXRaQgT6Yi4wm38hz5xsArOPh0lxdOE2fL/0dsKj9ateLtxjZYKY
         p3jVjRMqS7O1NaveTSOw23jE4nmjhSF80eVO+39NTt0uTAVuSR3CaERZSQbCCqEcdbi6
         nhfOxPk5jcnkIsBvejqTyTz6iipEGp6sVhj0w0gnxilsOKSWIqFv6Koe7rqJClCoAPk8
         wF7TaiThSYHNdrJRkjGrPYDki7lflFnNzTrsVE9X8MLauYFlxedDeqYUF1Hbpg+5f7mp
         0Lrw==
X-Forwarded-Encrypted: i=1; AJvYcCWFPrucdYoRLKHInOFDn6bx74jCQdo7VaERxCOLkJFn2o6DGPOozg5RLqQA918WZoRI6y3vPQDTA4w=@vger.kernel.org, AJvYcCX7+3IgdLVtK6UhzRHFbH3VFrPgJjEdJfRehiur0QqOblpAeGGf2a8EmxGlEm0v4o/Xl9MeaktL@vger.kernel.org
X-Gm-Message-State: AOJu0YyIjpg7OgZzZAbllvUt5BcBoEc627QgzcOTmKfOCTopjtPHFTv+
	zK+Zxawbx3t+aO34ld4esrhmo9HZbFZLvT2Nq/iuUGRTa9V3za13
X-Gm-Gg: ASbGnctuHLzFpk4eMlXEsFHBVLYyffrXATik/7O3XSEPy0b7/7eWZ4Cdk9etn7YB22x
	nt6ReisuVqZHsU+Py98cg2CbsT77I/mD589ZhEgUo5E4Hg6Rns5FhpiEPrKvVFBudT/wRIl1qNP
	IjQBbsDDJem4dm2Kdqx0icnaHTvkcTvgmvGJZT6GagceNoXSBWfOUfEbyXdNmTrSykPW1WIc5Pt
	sdVpS9QpYrAmitBwCZNNzGJNZRi9apHT0PFrPnXN/7ExhambLXmFyTbwDoSuGr9Ocy8GVUJ2ywm
	US3CkHR9dCetwZHIX9bmq9btD11c9tZvRwVZcqNwxjtIL0kQsgmPNAOnlI9zlnchJ+XAKj5Ep+A
	xkXE=
X-Google-Smtp-Source: AGHT+IHFHQumFuzr6m8VcMsprWDeJ0lO5iaP9WgeCEDGRZq/oo6NG7t6tJmLt4Hu0xT+7SSErcf1pA==
X-Received: by 2002:adf:f7c3:0:b0:38a:1ba4:d066 with SMTP id ffacd0b85a97d-38db48a3f90mr4665013f8f.27.1738805825249;
        Wed, 05 Feb 2025 17:37:05 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde0fd0dsm304935f8f.75.2025.02.05.17.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 17:37:04 -0800 (PST)
Subject: Re: [PATCH v10 02/26] sfc: add basic cxl initialization
To: alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-3-alucerop@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <b09ce4a0-1de0-06e0-3f01-936b86853be4@gmail.com>
Date: Thu, 6 Feb 2025 01:37:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250205151950.25268-3-alucerop@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 05/02/2025 15:19, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a cxl_memdev_state with CXL_DEVTYPE_DEVMEM, aka CXL Type2 memory
> device.
> 
> Make sfc CXL initialization dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

