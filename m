Return-Path: <netdev+bounces-207097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC2BB05AF2
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A155217565F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F1B2E2667;
	Tue, 15 Jul 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9I0/cFG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FEC2E2EE9
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585129; cv=none; b=GuSiue0QRedfL77Fv9Gy7tFkU4xWFJB2AGnGkOn54n+PLjflKB6qvgmFoatDjqtaC3FlPYwjOFG8aD0/X3bld1XS7huWMzky8nlzwugyT+tbFS+jGU5mry03pHkebJ5LhvxXfyNuaY9/yi5Vd+DHSYQDZybpyh5vX/P1R+nJ3PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585129; c=relaxed/simple;
	bh=G+ns0uih/2uJnqImmyyh/cjDmesXOrcn+5Yz32pH4mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PuHsNU+a/IUD9e05FQliYC/d8OgTV9ojAX9JHZ4nyR8WT4JdzITzpdrpTTo9wWKC3ieoT+/JuMhs8pRnxUae9eP6n4YajYdVG7Ht81lcD6maG6P5dD0yTynb8PYIdNpNg2sD2GnLHv4VQvqBC24d0fo+jMbUFWEuwd3vn7WTEEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9I0/cFG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZz4VIlihh12lH8XqRKgb8bjytGutX1e1f4gwGdB4vo=;
	b=E9I0/cFGUut37BXb6A9FINr7DbXcD9xcjuTFfB74M4NgRnLCUYiQYWkQLGx90FJELOjB3b
	8rJThYonN+t7bMyaDcSQqYUZAY72xl2YopLd/bymO+kUk51x0/4vYokhwilwSar9DmPH9w
	D4+wljA1OriEBqiSRc1Z06zXOfiZx9g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-D5HwydE_Ppu_WBPgOJU1Ag-1; Tue, 15 Jul 2025 09:12:05 -0400
X-MC-Unique: D5HwydE_Ppu_WBPgOJU1Ag-1
X-Mimecast-MFC-AGG-ID: D5HwydE_Ppu_WBPgOJU1Ag_1752585124
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4561611dc2aso19775345e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 06:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585124; x=1753189924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZz4VIlihh12lH8XqRKgb8bjytGutX1e1f4gwGdB4vo=;
        b=v4XxJPIaR0Iet1Ie4guLlyASUMeyKj+S+Rk7AaNxjuTvfkZ/P2ZOkOxA5ooK6m5AV4
         lkSkAd4Uv8gfRsiDuioOYphlPhqR39e31nZQP5Jt1q1R9iXJhTyDB6Mv8vq+OZ1SboHi
         XPQKJKNO85EQrNIfErWxETiAG+tB+N7NUMwPxMzFnOJiO6U5U7vUwKeWBKywg2fBlmpj
         UWKLds6c3Uecsq7BfZbUizVv505ggRSLXUxtkjIOWSCEH8Jx2m2j7cfp72oceIG06huL
         or5NXNeofp2a7gxLCH99VLvgbLhYzUWE7LyDwaNAxulNQ0i37Pf3CYHGdBYsmNvk6IXA
         Q4sw==
X-Forwarded-Encrypted: i=1; AJvYcCUAmBtYAsoBRS+13G2AzGmoN3JSQzbGMUEfgvvqVJpFywleXyZpBgRpk95N9Z4iX8v8PkEePpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqppy6ww6p9Aw4wLHJZhyP/e5ji7YwCP7+RiPDhtDtjrwc+Lbb
	moxqTDri6fkAAx67YkCAGAtpMhjrT6ovFn7Yqmo+G/7/oH6mfQjSuIpMx5LfBiBZR6sw+VM/4Mz
	tQ3sVgUrVEGkWaKp+g3xFcet2cq3OcCFp9F16KO8Za1ZRYI4l8FvAO+zp1Q==
X-Gm-Gg: ASbGncs4Y8abAxp0BgTPewrtk5jIZE8tagKq6aVCoSilbRySfdWP/EQQg/JyHP1K9Mq
	64OwAtyzsAIaT06T/5gOfR73VBrH/xTeLWReh8rF0OuXR66vmUtAxULMaMItr3ZNUFfBT0CabXI
	j02uMcv3zVMtX25KEBAk1ShncX4Wu+Tnzg1lYA0kp6xICpeX1zAv1ggKTM8ViUDMqF9a4HGGbwE
	62nhPM4a/nMLIc/JJ3AFFWoUXXoSIUghuMCQj55ulflfcfK8Y5RwIn7OeWg8wK691T/6PruzxZx
	JghUmyuoNtUoGtZjvFf1bhqKyQ/efxUt7NxRcJKmzNjEzqNG0diDYwzZ9+BkUrYVrEEr/y79jwW
	rvAPd1UCbnEM=
X-Received: by 2002:a05:600c:3481:b0:456:1752:2b39 with SMTP id 5b1f17b1804b1-45627727ef0mr23163675e9.33.1752585123981;
        Tue, 15 Jul 2025 06:12:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvhstXqxkYiuemf61jyKIee/sWIfmW07HUYzwNSL7GMP+VePr5KTLB5NLMowun8JOgyGr8Vw==
X-Received: by 2002:a05:600c:3481:b0:456:1752:2b39 with SMTP id 5b1f17b1804b1-45627727ef0mr23163335e9.33.1752585123501;
        Tue, 15 Jul 2025 06:12:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45624651a09sm30800535e9.12.2025.07.15.06.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:12:03 -0700 (PDT)
Message-ID: <495a37e7-e31d-4671-a4d9-7e653ad80b60@redhat.com>
Date: Tue, 15 Jul 2025 15:12:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] dpll: zl3073x: Add support to adjust phase
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250710153848.928531-1-ivecera@redhat.com>
 <20250710153848.928531-5-ivecera@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250710153848.928531-5-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 5:38 PM, Ivan Vecera wrote:
> +static int
> +zl3073x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
> +					 void *pin_priv,
> +					 const struct dpll_device *dpll,
> +					 void *dpll_priv,
> +					 s32 *phase_adjust,
> +					 struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dpll *zldpll = dpll_priv;
> +	struct zl3073x_dev *zldev = zldpll->dev;
> +	struct zl3073x_dpll_pin *pin = pin_priv;
> +	u32 synth_freq;
> +	s32 phase_comp;
> +	u8 out, synth;
> +	int rc;
> +
> +	out = zl3073x_output_pin_out_get(pin->id);
> +	synth = zl3073x_out_synth_get(zldev, out);
> +	synth_freq = zl3073x_synth_freq_get(zldev, synth);
> +
> +	guard(mutex)(&zldev->multiop_lock);
> +
> +	/* Read output configuration */
> +	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
> +			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
> +	if (rc)
> +		return rc;
> +
> +	/* Read current output phase compensation */
> +	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP, &phase_comp);
> +	if (rc)
> +		return rc;
> +
> +	/* Value in register is expressed in half synth clock cycles */
> +	phase_comp *= (int)div_u64(PSEC_PER_SEC, 2 * synth_freq);

Is 'synth_freq' guaranteed to be != 0 even on extreme conditions?
Possibly a comment or an explicit check could help.

/P


