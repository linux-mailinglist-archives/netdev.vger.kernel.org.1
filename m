Return-Path: <netdev+bounces-199425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C52AAE0423
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849CA1BC44F4
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039FF22370C;
	Thu, 19 Jun 2025 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNZcfN0O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4822539D
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333236; cv=none; b=ZgHF/606IKCoZrqY4kknjhWdZX3lhjTyQy0xRQ2u+O3hFsX03ZznPCzCvKreEHPxRClkxElbVVDSt4+LPUr2gDeTUlPl0Thgdcr4eHbLMTBRiC2CRkUigzZ9CLulGH4/nHiQWfsDopmm4lecvPkRmXMyttnkUZ4uwu4yxydDBzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333236; c=relaxed/simple;
	bh=fI4b0JmvmR/LKJHS4kYGRgS79fqtVDdNyB26iJdkI7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6kckWnuo/19n6rdpkZ2lk3PtJUjlNyMw2AjX6hACmtJnZz+aLlm7kb6i+dYZZJTEsniv0cYOAzQSXT7Tw4+GxCyTowmEbP804715GSt3eLW2ixrokETdC3hy7iLG+c/vCp2pO9Ve/Bn8lY6W5kPgUA9WYfLdnwfYYDTGVDa/k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNZcfN0O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750333234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5MqY5EbJPpgVIT/GMNbBL+m8bzhYEjTyXfnL0CxcoM=;
	b=LNZcfN0O5EiHbj61InS26SG0DzgdUWWkci85mvoDr02Jd0QJjHDcXuzfG+DX48i/0nJxv8
	nbpvCl16f3280jjXtn0KogAmJZy/KVQsA/eBHUWqIMCPVYoR85DHFC78sitAGwReqtsP7g
	eGM9zD7jKB8dOuDqOW+S/QtDDyaptoA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-DhR_BA3-NsmyjHBT8FEWIg-1; Thu, 19 Jun 2025 07:40:33 -0400
X-MC-Unique: DhR_BA3-NsmyjHBT8FEWIg-1
X-Mimecast-MFC-AGG-ID: DhR_BA3-NsmyjHBT8FEWIg_1750333232
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so345664f8f.1
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 04:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750333232; x=1750938032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5MqY5EbJPpgVIT/GMNbBL+m8bzhYEjTyXfnL0CxcoM=;
        b=bggSxn1/b7gH/elNklOdoCVKXcaB10MzFS5fbx/Og2YLTnQlgMwsDW+8CVJxRp1hZp
         IbxP7JnoUbrzISiBqceQlRvOF08A/NaspW3IAJkz0GLUyQy9TTieOw7f/MzTqDE+lEE/
         ibLXsMBwwDTOCQu60GE/k76HAujFrlGmgOsvPRzvjc5dIV4K/BSrmfgQCJ/KICYq5Xvi
         GAunWnqkYceNghhoUf88BRA20yOM4RrE+TD588FxItKNs7bPWwvkelWxLmjODZGqUqFT
         1l89ZyB8SbhSOAeswKmjpbAyRTz41L/hfB6fMM6I3MMST50T2AXbf13MffE5+4Atmary
         BkGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS2AFY0Go+NTUjYYrTZOTiHPbU08uu6r4zn77STwdrhatCLDJsGIya4Bemfzt1wvFdcf07mCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIM27fsoPEPwuhyluujeVtx44y8K1VfYIpbnipvThMRmDmgGXG
	A0QZa8BKLuO2MRxFqfvwa713WfoIpnwQE2mjYRMHYviklOYu4KAx6okvSQ1NbkQnqxkZpazW6m9
	g1HYedKK42XgwWq+Tl26/Xzfdq8hHih2HD1D9GQbWBu9P2kLHbJq5xk/oFQ==
X-Gm-Gg: ASbGnctaOcyxsCPiqfJ34A7kS26Z/eJIXE04ASMNARiRubgujAS4mcB0qVSA0zFMAPe
	08OvkbWYw5NQ2tm4AG3Yxmg5liVE3VV4UlocF3Dmc4JchFufmNf7D0GC+v/BN8H3k7lJmeL1EfE
	OnhsKjajSks+0k/ZwLH5iEh224ivDEZ9zdVKLGY6qQHGcK7SSvMPmpd+Uymu7O7RJnarjIzbCG8
	M/acITi3EfMoQ4cqtngUaatKWfLbooNbnmel3nY/qGTOM0UvK4pGyNolwglj1R7uT9gMiX9i+xQ
	z3e2HLAf9X7TbZQLYKYHj20tBdpksy4ywiXPKTOR8MjLbVlhXMZEifB/4yK4ix5KhoqA8Q==
X-Received: by 2002:a05:6000:2d0c:b0:3a5:8d0b:d0b8 with SMTP id ffacd0b85a97d-3a58d0bd1camr4831898f8f.54.1750333231801;
        Thu, 19 Jun 2025 04:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkPsAM7rzvUuUIwuWTbnbsaa2hHEQ50y/ld0Zh2qJ6v7nBnPiul0WnrvWb0vFBIsYzskhEqg==
X-Received: by 2002:a05:6000:2d0c:b0:3a5:8d0b:d0b8 with SMTP id ffacd0b85a97d-3a58d0bd1camr4831872f8f.54.1750333231356;
        Thu, 19 Jun 2025 04:40:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310:d5d8:c311:8743:3e10? ([2a0d:3344:271a:7310:d5d8:c311:8743:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b28876sm19250304f8f.73.2025.06.19.04.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 04:40:30 -0700 (PDT)
Message-ID: <7fce273d-06f4-498c-a36a-d6828b4d4f30@redhat.com>
Date: Thu, 19 Jun 2025 13:40:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 14/14] dpll: zl3073x: Add support to get/set
 frequency on output pins
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shannon Nelson <shannon.nelson@amd.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250616201404.1412341-1-ivecera@redhat.com>
 <20250616201404.1412341-15-ivecera@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250616201404.1412341-15-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 10:14 PM, Ivan Vecera wrote:
> +static int
> +zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
> +				      void *pin_priv,
> +				      const struct dpll_device *dpll,
> +				      void *dpll_priv, u64 frequency,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dpll *zldpll = dpll_priv;
> +	struct zl3073x_dev *zldev = zldpll->dev;
> +	struct zl3073x_dpll_pin *pin = pin_priv;
> +	struct device *dev = zldev->dev;
> +	u32 output_n_freq, output_p_freq;
> +	u8 out, signal_format, synth;
> +	u32 cur_div, new_div, ndiv;
> +	u32 synth_freq;
> +	int rc;
> +
> +	out = zl3073x_output_pin_out_get(pin->id);
> +	synth = zl3073x_out_synth_get(zldev, out);
> +	synth_freq = zl3073x_synth_freq_get(zldev, synth);
> +
> +	/* Check the requested frequency divides synth frequency without
> +	 * remainder.
> +	 */
> +	if (synth_freq % (u32)frequency) {

As the frequency comes from user-space and is validated only the DT
info, which in turn is AFAICS imported verbatim into the kernel, I
*think* it would be safer to check for 0 here or at DT info load time.

/P


