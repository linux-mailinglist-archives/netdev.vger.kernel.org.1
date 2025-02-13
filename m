Return-Path: <netdev+bounces-165994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DD5A33DE4
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8FA37A537B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17896227EB4;
	Thu, 13 Feb 2025 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWWocGaJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3A227EAE
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445837; cv=none; b=se5HHIFNIG2L0LHKjzqyhxjZPetePnaoyQFisplJrxrEarfAvyN4UBpGDhlJTjeTZHX6WL6vb3Mqd7Os9w9Tu+Z7o7Q5oQAjN5tCwoaI37Goyhjl2MribnMFTay2/wctJOSRxqKpr61hPrv5ue+gm3Xsz4JZyC0W07fUohAFuC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445837; c=relaxed/simple;
	bh=YY6DOrCUpQsyNOYx6VdO/TtggXIJ9ECRrzNJKzUoTuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQCwOc9OtkWuehd9fzsRRPu+sXQdB++jtE8vQONZrw981eC4LQ+MY6LRxPjIc5cmoYrnLKBlVqUl8k2gj1NZFTktRgqlVulZbQGWHQnHUdHDzgmOe1Hmy6jEeJyj6CtOBk+IYDcbvGPa//Ve3dPexRlfjuBglL/hrRzBvxYkQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWWocGaJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739445834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LL+aPdnFR/fkXCURRzOeY8yP7Oiq1xCa5VfoFeYynkw=;
	b=PWWocGaJQeqQ9XReEqrMr/xzXklMCxsqk0osUHMfX5VSHpeSNzlis7pmLy7YZV/JOpzZUp
	4QWYwtIS4CzXQxPlqlkjECCSnEEpthJuaTpVROPcg3kgls22kN3yHCvgcgBLO1TeUPrmX6
	KLLDdiTwvBWTOf8Nkm1UXCnN3ehHYN8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-L2e0x3HVP2i3yNfRE0Zsxg-1; Thu, 13 Feb 2025 06:23:52 -0500
X-MC-Unique: L2e0x3HVP2i3yNfRE0Zsxg-1
X-Mimecast-MFC-AGG-ID: L2e0x3HVP2i3yNfRE0Zsxg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so5672785e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 03:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739445831; x=1740050631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LL+aPdnFR/fkXCURRzOeY8yP7Oiq1xCa5VfoFeYynkw=;
        b=YbiqP+qqVfQSMiSGEuVAmk7fychJ0dWGf+5+lNATAXZwCLQ7ml/Cn30dwYaRBxFA3n
         FyJ76IBioyChD+zxz574UmQR4zY2et6CVLzD9HHZtfrmN8q7q8/hv3tCv52blzT+RPha
         ulCg+Y8+Eni3e0nInnTujVdlLJJXuahST6z/L4mA8ePwGG46MCK+DFGQTsCPe7PE9Vph
         IzEtVQEx0KLP6+4DKv+Lz8s2TCKpnIDk6MteOULJKMnhpWF++xZAKuYskEeYMRTBwZja
         JSb+HbjWWKBFYVqwmiF4z0fRt44mjcgnIWDDvdZWcv0V/lAa3fx6A5M01iE+bJrqpA27
         TMtw==
X-Forwarded-Encrypted: i=1; AJvYcCWK+3+8MX91UDZ/EBmi8EpIST94IcWRaTS3x0sk/rYye3OnpiPsQlkHQAEeZ8rk+B8E+YjZkkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi1vW96MSk+Z35PhsTW3yTqr72HuM3KeM356w5IOROLx5t5+FH
	90hHlltr3iGIvAUBVjr0GvDAHhq3MKF0S0jz+xZV8xpMSQlhZDD+ic6kkZxUtbPIQJXRPuzDGUE
	Y18f7XpyCksxwYOGnPRKaqAKBflJdvg+BKX780BJS5uzaj9JT37lyXA==
X-Gm-Gg: ASbGncsOPVjOhB8fXNa1D2Cx1xrmUgKT1cemy76m435OMy5G9mBalruHM3UlvBUpLI9
	/aU989IxM33V8sn4eq2Ltv8VwbCZg6wnW+vRbgbgh7Eqz2vnSFzfx6LLl2M6S7+G79coQrwwFkV
	XkV3hG5/UAHPrbuX9NB97bRpKCU6G0IABg+2qjRmeRzOGAHxpWh0o9uvmnsqLJhTgjEq4JbQb6E
	69euh7G/M/fzqo7Cp62UFl/se3eHfMOSOoq7Rt3UcFPoQ0e2/Cm/EPx9bKGQZVsCCkFEnxdcWbU
	FBWTopW4tstusgmRYuL/JZ0Nw6b9gZBjbxA=
X-Received: by 2002:a05:600c:870d:b0:439:34d3:63cd with SMTP id 5b1f17b1804b1-4395816f381mr65177135e9.9.1739445831376;
        Thu, 13 Feb 2025 03:23:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFtFyqrjbkfQQqT9IE89MU7ZaXBN7z5Cz0szfxnDWNjv1Rol7DbNd/LzOv6OpYD5KnA0J+fw==
X-Received: by 2002:a05:600c:870d:b0:439:34d3:63cd with SMTP id 5b1f17b1804b1-4395816f381mr65176865e9.9.1739445831072;
        Thu, 13 Feb 2025 03:23:51 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc48d9dsm41234445e9.0.2025.02.13.03.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 03:23:50 -0800 (PST)
Message-ID: <3a979b56-e9d6-41c9-910b-63b5371b9631@redhat.com>
Date: Thu, 13 Feb 2025 12:23:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ti: icss-iep: Fix pwidth configuration for
 perout signal
To: Meghana Malladi <m-malladi@ti.com>, javier.carrasco.cruz@gmail.com,
 diogo.ivo@siemens.com, horms@kernel.org, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
 danishanwar@ti.com
References: <20250211103527.923849-1-m-malladi@ti.com>
 <20250211103527.923849-2-m-malladi@ti.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250211103527.923849-2-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 11:35 AM, Meghana Malladi wrote:
> @@ -419,8 +426,9 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
>  			regmap_write(iep->map, ICSS_IEP_CMP1_REG0, lower_32_bits(cmp));
>  			if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
>  				regmap_write(iep->map, ICSS_IEP_CMP1_REG1, upper_32_bits(cmp));
> -			/* Configure SYNC, 1ms pulse width */
> -			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG, 1000000);
> +			/* Configure SYNC, based on req on width */
> +			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
> +				     (u32)(ns_width / iep->def_inc));

This causes build errors on 32bits:

ERROR: modpost: "__udivdi3" [drivers/net/ethernet/ti/icssg/icss_iep.ko]
undefined!
make[3]: *** [../scripts/Makefile.modpost:147: Module.symvers] Error 1
make[2]: *** [/home/nipa/net/wt-0/Makefile:1944: modpost] Error 2
make[1]: *** [/home/nipa/net/wt-0/Makefile:251: __sub-make] Error 2
make: *** [Makefile:251: __sub-make] Error 2
ERROR: modpost: "__udivdi3" [drivers/net/ethernet/ti/icssg/icss_iep.ko]

You should use div_u64()

/P


