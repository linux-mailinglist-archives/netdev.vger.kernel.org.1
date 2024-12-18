Return-Path: <netdev+bounces-152843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A7C9F5FAC
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56545165BCE
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 07:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5D4158D96;
	Wed, 18 Dec 2024 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="f4hpqjA6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37411552E7
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734508402; cv=none; b=ttURbe+HoidiWepe7rSbuNV+ept0ONCH9TOsyphJQyNel3HT2mIImLmkekEjX9n3+K4VyoQze7TAqT2zkfU3hOIA3ZQ9LXankCM/OwAC0TyN6t41t2eElPS/xJ/Sd+THhZHVwWTBqI+SwvfuKhgqvD1xh0Cm6DZPQV8bJ3BX7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734508402; c=relaxed/simple;
	bh=GvkJqtbzEQFpARHdlR/UImr7fknJxIE2E9oMmXuUR3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpI6D9BKcAsuDC/MKieq+el46sSAIhX+4r3pykSzyMApHsG35+TVMuls95HDU26KKznSAn6Fx2KDoA26ZJGC6CY9RptW+ZrYkbr54O9RUiUcHBtfA6eDmkLcolD0hH/AFaq1VMRMHzrv002lIFU02YSpsilB8U3tW8JApqPKGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=f4hpqjA6; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8352F3F171
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 07:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1734508392;
	bh=QA7qYluRuUIa7usBURYUiloTnmBO9zMmnIOKmpkGqzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=f4hpqjA6djTik1WGsKY5R/OtegEbe2Wuo3PCGhdZMnPpiyjZe6c+2OL802mmn9UUE
	 DI/LQLc+AaGEPn3o3OPJMlNY5JLMRMHrM8jYgmt2LRoqChJlDDxG53yaZHTbynX0ZU
	 o3FQHaisCqYsSkvdXC1hGIIks4OcSVc0wUVE78hltu705XnvcYzfQ9MK5p90J3nk1Y
	 5TUuHxHC1JJmXdKiQATt1t8/11mxPsfGikIo5vJoljTPt8qdaCmDUY5nQT5u8i1UgS
	 TNmxKCy7yPY3pT0l05FCzokMa4vBBGrl8jSx9ILIy1JQ98ySL2fAj3z92qL+aqA2MP
	 yxo2GQ6P6Lz3Q==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216405eea1fso51039665ad.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 23:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734508388; x=1735113188;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QA7qYluRuUIa7usBURYUiloTnmBO9zMmnIOKmpkGqzk=;
        b=lACk5rXrD3opOCphVB9wQKFg4XZ8F3ugOgTVuxJCQoG+M8hsbjQMkTVAInUDITV6Kr
         nKjDXpXLQMlsFUBDWVLn/P2MV9dgtxPf2s6o0sBrVzdcUgZ+ulRL4aozxltPUjw3dsf0
         Gxr9kgXO+QnPjZ/TDtCU25Jl0IM+9nNyi6UvPeDYtzu3W0oj+j+JNhfCcRQxjSgRdZA8
         5Wb7/re7+CiDdoiLU3zmEv7DOwx41q+h65q49oPlbKbVMrdXQT+62IragApVJecH9DCq
         9wOR+VUZBLehRlGpkZWGhrRaJC3AtBhgNFTsQrGZCgdxe/Rc3B3QGFEYkXIc5jZagLTB
         fcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV1c5SCS4x6gGENEi0M1WUw/n6yckKO4v8TeReOgqMKlaOh0s7lOZDtXlSfiei4GYNcy9KAL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyno6iwewsJ+bjY6Y3fhw5LvBGcvhbPLvDkKaAwJIekSKNswaXe
	8814qr0Q5V3pGLUUlWjmwxs1BRZgiGpJKPXrXEezFqhUzNNMk06ILLn9uAMmXiFjLzWpJzIhOPS
	3bqswoYF8YbvE3IdD+93CK++hpiLaikFXAWTxRhManZvzVufseQATpKtI0qK5N0M8PVFAxw==
X-Gm-Gg: ASbGncsmOUyg7yeUxh1B7QOD+EkrVSvwa0fq88IovALMcVg2UX21e1XQXzxCKMdQg5Z
	+MZc6ufSgEvyeXhu4zRRkHnBHZcRmWw1H/ASPphgF6pTA/0ZsWvvaa7oQOrEEYM6718wjd1VGy7
	f3rXfL6wEo2BC/CTog+qWYoZmqFYzUmb+HTaOzeGvv1CTRbSg17hb8wQAGUFN6oC2CTZvHcD+D9
	nloqepXL0vRChzeyOAlcowNveyGX9M7DaFKcdNEcanvQMkUFRL5367JGDLOEMAqlgUQ3q9Vn8ws
	sFbrqqLKSdjGFhvv0UTym2ZOu8jd8Gjq1O4=
X-Received: by 2002:a17:902:e5cd:b0:215:a434:b6ad with SMTP id d9443c01a7336-218d7232943mr25584215ad.33.1734508388469;
        Tue, 17 Dec 2024 23:53:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8buoRwWFzglreuoOoKDyupa7wxpFqo9x1eMl1ZfFbJ0E6MvUkTFSZN2/LUGq0kuulji31iw==
X-Received: by 2002:a17:902:e5cd:b0:215:a434:b6ad with SMTP id d9443c01a7336-218d7232943mr25584005ad.33.1734508388127;
        Tue, 17 Dec 2024 23:53:08 -0800 (PST)
Received: from acelan-precision5470 (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e500a2sm69929225ad.118.2024.12.17.23.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 23:53:07 -0800 (PST)
Date: Wed, 18 Dec 2024 15:53:00 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vitaly.lifshits@intel.com
Subject: Re: [PATCH iwl-net v2] igc: return early when failing to read EECD
 register
Message-ID: <rdwtgcpvchdejucyraohjm52sqyhqm23sec6omkbys6wrxaslv@tspjghkgsx2m>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	En-Wei Wu <en-wei.wu@canonical.com>, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vitaly.lifshits@intel.com
References: <20241218023742.882811-1-en-wei.wu@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218023742.882811-1-en-wei.wu@canonical.com>

On Wed, Dec 18, 2024 at 10:37:42AM +0800, En-Wei Wu wrote:
> When booting with a dock connected, the igc driver may get stuck for ~40
> seconds if PCIe link is lost during initialization.
> 
> This happens because the driver access device after EECD register reads
> return all F's, indicating failed reads. Consequently, hw->hw_addr is set
> to NULL, which impacts subsequent rd32() reads. This leads to the driver
> hanging in igc_get_hw_semaphore_i225(), as the invalid hw->hw_addr
> prevents retrieving the expected value.
> 
> To address this, a validation check and a corresponding return value
> catch is added for the EECD register read result. If all F's are
> returned, indicating PCIe link loss, the driver will return -ENXIO
> immediately. This avoids the 40-second hang and significantly improves
> boot time when using a dock with an igc NIC.
> 
> Log before the patch:
> [    0.911913] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [    0.912386] igc 0000:70:00.0: PTM enabled, 4ns granularity
> [    1.571098] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
> [   43.449095] igc_get_hw_semaphore_i225: igc 0000:70:00.0 (unnamed net_device) (uninitialized): Driver can't access device - SMBI bit is set.
> [   43.449186] igc 0000:70:00.0: probe with driver igc failed with error -13
> [   46.345701] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [   46.345777] igc 0000:70:00.0: PTM enabled, 4ns granularity
> 
> Log after the patch:
> [    1.031000] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [    1.032097] igc 0000:70:00.0: PTM enabled, 4ns granularity
> [    1.642291] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
> [    5.480490] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [    5.480516] igc 0000:70:00.0: PTM enabled, 4ns granularity
Thank En-Wei, this is a good fix.

> 
> Fixes: ab4056126813 ("igc: Add NVM support")
> Cc: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> ---
> Changes in v2:
> - Added "after" logs showing improved boot time
> - Fixed error code (use -ENXIO instead of -ENODEV)
> - Added error propagation in igc_get_invariants_base()
> - Added Fixes tag
> - Added [PATCH iwl-net] prefix
> - Changed original author from AceLan to En-Wei
> 
>  drivers/net/ethernet/intel/igc/igc_base.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
> index 9fae8bdec2a7..1613b562d17c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_base.c
> +++ b/drivers/net/ethernet/intel/igc/igc_base.c
> @@ -68,6 +68,10 @@ static s32 igc_init_nvm_params_base(struct igc_hw *hw)
>  	u32 eecd = rd32(IGC_EECD);
>  	u16 size;
>  
> +	/* failed to read reg and got all F's */
> +	if (!(~eecd))
> +		return -ENXIO;
> +
>  	size = FIELD_GET(IGC_EECD_SIZE_EX_MASK, eecd);
>  
>  	/* Added to a constant, "size" becomes the left-shift value
> @@ -221,6 +225,8 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
>  
>  	/* NVM initialization */
>  	ret_val = igc_init_nvm_params_base(hw);
> +	if (ret_val)
> +		goto out;
>  	switch (hw->mac.type) {
>  	case igc_i225:
>  		ret_val = igc_init_nvm_params_i225(hw);
> -- 
> 2.43.0
> 

