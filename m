Return-Path: <netdev+bounces-199476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB14AE06E9
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C631882588
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602B22586EB;
	Thu, 19 Jun 2025 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBsgkAYi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC225BF00
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339421; cv=none; b=sVKxKZMEQ7JfZaOI0f510qpKnc01Tb6PKFC8GC/rOsiLysvw54ENkDYaPdkqkpNNweQkPWeV3SHZbZ9etABoZC+NrFhPH9akLfVFvESfl5UrWbjlhDoQMM/aUCQx9qATVmk/YijoCgLbfVkGA2SLVarNZNmBTtYmZzCR1zCU7A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339421; c=relaxed/simple;
	bh=yvTf0gRwf8lcvYmPdwBfIAWvG4ZTR+XJziAnsjuaLbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wz3kM1auEgBK3i9CmihimL+Z1p6KC+qfQi3wEQIzYVTax/1VN3Pc3qJpuwD7/YffkjO06kSKZHQVno8c4WHSIlgj1Y8qBpadqs/LRh1fiPEuRw4Uw2+qnnVd08QZvBBvnqnv2pYXaRgsRmUW4pSE5sDQe2jWsO0Kxl2z/+gGL0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBsgkAYi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750339418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRlc/455JdnZehorRTgWTdsui2EMVuSES1pT6cJjXLE=;
	b=jBsgkAYifvsCqB3C7zKWiji+ij1MID3eBbTcGlpJTCzs21s4w2f3Zr8WINY2Qc8R7F9667
	hbFd26dfo1yWyU/fiygbLyjFVjPuMTnyIH2GhsNeiA3BW5XyUZjRXdV5wSweaJq5KqHFzm
	D8BTf0QT+JLcjqJylFqJdqWfV4OmyRQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-Q_tAjlFNOeamlZ-sHIZo3A-1; Thu, 19 Jun 2025 09:23:37 -0400
X-MC-Unique: Q_tAjlFNOeamlZ-sHIZo3A-1
X-Mimecast-MFC-AGG-ID: Q_tAjlFNOeamlZ-sHIZo3A_1750339416
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso4811955e9.0
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 06:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750339416; x=1750944216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRlc/455JdnZehorRTgWTdsui2EMVuSES1pT6cJjXLE=;
        b=jNL5zj3wKNN0x6UfCY2er8WOQmVAfyfGZh9wY0y93eDCbNAecV/DeBj0Bh7MMlznTU
         hku8BYlfBbAi0Vz33M8x4Fgb8QIlZ9r7AjJZXlJLV9Mu5DXt2XZf39IST3YZZ5GAs7Cw
         AT72hgF3n/rtadShXCR1rN/LTBnSEnjylwv4iu0n8nFVMmx4PANb+N3sNb3GvM4swpYW
         HKZ/rJz91VS5XKFtVeeWfV6/Tli7H2A59FJ0LElsqnADTju5FMpDVMc0OTQVx60o+Wd+
         jSsRY+TkOtguT49rPdApLTyvQpw8x1IkvejZ0VKtVhSfB/aZjLNGuFReboCrvhGFH4TC
         LTPA==
X-Forwarded-Encrypted: i=1; AJvYcCWzApXxb581txCpSBj8rkrw7h/gnpKCgiYE9drfudNyrZHWEJop+iUFvrK+1oJ/zUWNYPGrfMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuisnyPQwqq8KABEBqcW0PsHQ9xll3L/ytRfd2yjFdxaZm7mVS
	W2+9BgBUEKQtiF/lRkwI9orwdL725BzV5WLOgFBirF8QpP3r40+pzptqvq6q3TNCIOKy+3Mszhu
	V42JLBhSVcG41Xt8Qo1MomEcRC1p7fIr67b6nPXpyLn1/s5gHtwtRIlJRPA==
X-Gm-Gg: ASbGncvnO7H6zr7X4C5Hy90R01WYXXnMp4vLXPMSJcYQeQElujMDvgt/6Ve2Q11qIOa
	YxRYa/cC2AqNX+WpvitCbsDRhs5raCKnBeuekfHjy1moPiZ9dSSwmsKRzdh27gkmGYQOlsg0sfz
	9yWLEestdzYdjIg0KCAM0FLaOWFTIIeljZrVpvdIQCG1yKPeDSHhe5n9TiW9/Jae2bGce035FbO
	WtxextpS9al5ko1+uKOzSCJEJOTv4RVE51s1rO5JjWgPjLR76kMbz/Y5EXxxPLHwssfAZbLAxnc
	G5WUmmNU7GPTDEzmgh3i5heGKVqTjA==
X-Received: by 2002:a05:600c:4f43:b0:448:e8c0:c778 with SMTP id 5b1f17b1804b1-453514a1e54mr102985255e9.22.1750339416157;
        Thu, 19 Jun 2025 06:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzq+77XzI783Jt8YUI6h/miSxke49tHCSnFqIWVHg/I3AY/81H+u1Iauzwvv3Q5jdGX1Wv2g==
X-Received: by 2002:a05:600c:4f43:b0:448:e8c0:c778 with SMTP id 5b1f17b1804b1-453514a1e54mr102984925e9.22.1750339415703;
        Thu, 19 Jun 2025 06:23:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310::f39? ([2a0d:3344:271a:7310::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45362219d3dsm8413635e9.26.2025.06.19.06.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 06:23:33 -0700 (PDT)
Message-ID: <45b79d7d-dc26-491b-b5e6-c5f5ab210850@redhat.com>
Date: Thu, 19 Jun 2025 15:23:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 13/14] dpll: zl3073x: Add support to get/set
 frequency on input pins
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
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
 <20250616201404.1412341-14-ivecera@redhat.com>
 <72bab3b2-bdd6-43f6-9243-55009f9c1071@redhat.com>
 <ba027737-39df-4541-8fea-1c4cf489b43b@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ba027737-39df-4541-8fea-1c4cf489b43b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 2:15 PM, Vadim Fedorenko wrote:
> On 19/06/2025 12:15, Paolo Abeni wrote:
>> On 6/16/25 10:14 PM, Ivan Vecera wrote:
>>> +/**
>>> + * zl3073x_dpll_input_ref_frequency_get - get input reference frequency
>>> + * @zldpll: pointer to zl3073x_dpll
>>> + * @ref_id: reference id
>>> + * @frequency: pointer to variable to store frequency
>>> + *
>>> + * Reads frequency of given input reference.
>>> + *
>>> + * Return: 0 on success, <0 on error
>>> + */
>>> +static int
>>> +zl3073x_dpll_input_ref_frequency_get(struct zl3073x_dpll *zldpll, u8 ref_id,
>>> +				     u32 *frequency)
>>> +{
>>> +	struct zl3073x_dev *zldev = zldpll->dev;
>>> +	u16 base, mult, num, denom;
>>> +	int rc;
>>> +
>>> +	guard(mutex)(&zldev->multiop_lock);
>>> +
>>> +	/* Read reference configuration */
>>> +	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
>>> +			   ZL_REG_REF_MB_MASK, BIT(ref_id));
>>> +	if (rc)
>>> +		return rc;
>>> +
>>> +	/* Read registers to compute resulting frequency */
>>> +	rc = zl3073x_read_u16(zldev, ZL_REG_REF_FREQ_BASE, &base);
>>> +	if (rc)
>>> +		return rc;
>>> +	rc = zl3073x_read_u16(zldev, ZL_REG_REF_FREQ_MULT, &mult);
>>> +	if (rc)
>>> +		return rc;
>>> +	rc = zl3073x_read_u16(zldev, ZL_REG_REF_RATIO_M, &num);
>>> +	if (rc)
>>> +		return rc;
>>> +	rc = zl3073x_read_u16(zldev, ZL_REG_REF_RATIO_N, &denom);
>>> +	if (rc)
>>> +		return rc;
>>> +
>>> +	/* Sanity check that HW has not returned zero denominator */
>>> +	if (!denom) {
>>> +		dev_err(zldev->dev,
>>> +			"Zero divisor for ref %u frequency got from device\n",
>>> +			ref_id);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	/* Compute the frequency */
>>> +	*frequency = base * mult * num / denom;
>>
>> As base, mult, num and denom are u16, the above looks like integer
>> overflow prone.
>>
>> I think you should explicitly cast to u64, and possibly use a u64 frequency.
> 
> I might be a good idea to use mul_u64_u32_div together with mul_u32_u32?
> These macroses will take care of overflow on 32bit platforms as well.

I guess such macros will work, but u64 is available on 32bits platform
as well - and possibly simpler/more readable.

/P


