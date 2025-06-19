Return-Path: <netdev+bounces-199417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 135DCAE0332
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F811884CEB
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797F1221F30;
	Thu, 19 Jun 2025 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ba1iy66j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E023085BA
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750331733; cv=none; b=PstCoLK3n0z0zbtc9jLuR5NzjFffjsGB84iVubjQZqOkzVEeBR7R7Njo6wxhJQwe25M6LvxQQvLsqREcx6A0yufaONN+c3B73+7O3Uu8+s7DtLjQAk1mRI9YWI1dNXBRa0I6taq6jQQsQillSzMfWl6JuJCPNVtd3eyyGM0WCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750331733; c=relaxed/simple;
	bh=LUeQAjtBZos6OdUZbbQVfexhZynCiSgqlsEwbuBatHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsgnKFs+UsGcHh/h39tBjTxhi4Ps518ZL+Qcnqx8kq/Te47A+lXzybPCABS6eMDrU+fYJyHTjcK12d9fStHtugysn9deFlMApnuPgo7L2sFWWY6wGpEMEuPW1WIQ4bdDF3kXqQ9kmAlfFTGYxqWkIwzRdT9FfzC+Y3seQCGogjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ba1iy66j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750331730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xZv/IaN3pVBxm6Ay/mMD7muLAWVYifKr0RAn2IkTKE=;
	b=ba1iy66jrY3A+2qdWoghrzrb+8yfNWKaw+0rMZgtvIFKRL5l92OsE+GeJlSLEbdJ0C1iij
	TooyEEf57u7YU4WtSpL5HnMwi+8KAiBkg0nv6sOmVzuc/MnjuDYrY6hc84D91ql7y4WfZg
	MHCTMN3LME10M5/aM2p+WQCtkU1ftls=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-gBGFlOA3Pr6WumZkjsa0pw-1; Thu, 19 Jun 2025 07:15:29 -0400
X-MC-Unique: gBGFlOA3Pr6WumZkjsa0pw-1
X-Mimecast-MFC-AGG-ID: gBGFlOA3Pr6WumZkjsa0pw_1750331728
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45311704d22so4288715e9.2
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 04:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750331728; x=1750936528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xZv/IaN3pVBxm6Ay/mMD7muLAWVYifKr0RAn2IkTKE=;
        b=U2Heq8+9dByMplj2MrR58a5O+qvULPRqK3mcyJuknwiV4vO4OpdaiFMNPhTZWcqCbz
         zsOVFTgm+Eb+QL/EsMPVso708SxpeI+Hk+gNQtTX/tbTSDQrzHJPY7eoxLSnrq6OluEv
         4/wfNmy+ufScv6Cx/rho6W8SHlrgD8ZmfQVoPnZnjFZ//Jn4qc3eW+9RAgSL0cSmHWqQ
         znJZ8P3De3SaMmGzXNu630BxVc2141S95KokIgAW7t0wkboZOEi3f6kIilzfiD407Asb
         WTwOv4tysSQawYiYxDhw92TnmIOvVqRXYAAQO8cFT2/9ySFdE8QbowMs5VtP7xkrTZmT
         rvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXum3B9NDLeKtvqqn9h0r84TU6PklOMuY1uOYwbmb2CVbuBxzgBz6TbotcFKEiDyqwqxULW7Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK/UV+iB5OSV0IyoCivz+u7ZqQ0KgiCVyCmIaBwM1Vwa6Jh3xa
	/TwcbaVFLqtESDlQ+u0TwvplLI8nwP4gWePhZ82zfkxaNa4Q3NzLswbfpaTldD8zqgUz974HJ6I
	f6ZI8MdmLpkgO9vWZDJUio3Kx2cslniK2LaKKpgvkAtG4SSf70Ix46SVwDA==
X-Gm-Gg: ASbGncsrEQfXBsPkN0MGawMmk0UtjO/uNujYJ/eIhoC2HBEQ5I6kBsgKELQjj6Cis95
	Fm4VlLkXJzOfHEW7nkxLJsull3qJc7Rv5IDvDdRY625H3/fOfiFZfUf4Rycn37uAnyDRx3YT/7R
	u1K1oxgetmJ+nMzTinC/NsuOowkgzI2tIFMPoqtztUuXTJ369k/lN2zwq2yIM1PL6LQp+Blwx7C
	I9l9cqqKVDCd6/d0tNSdYm30F2SFp/+GQroeqWnjhhB7BDlYJPWWygbV5Q1InjjbPKl6a+siet3
	unZkp6LKAI0iuBUeTX3GsB8ax9OJVJys/p5OtTHJYytyXQgs32tyyS9FcqUtgUVeZUN4pQ==
X-Received: by 2002:a05:600c:190b:b0:445:1984:247d with SMTP id 5b1f17b1804b1-4533cadefe8mr187697275e9.7.1750331728253;
        Thu, 19 Jun 2025 04:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG43dOM5T7qmoDFSYxKLqTuwEzuqqfaVGRVW809R5AKI8GEve+HAJw7T1QeY9uWvmBGJ78U+g==
X-Received: by 2002:a05:600c:190b:b0:445:1984:247d with SMTP id 5b1f17b1804b1-4533cadefe8mr187696945e9.7.1750331727767;
        Thu, 19 Jun 2025 04:15:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310:d5d8:c311:8743:3e10? ([2a0d:3344:271a:7310:d5d8:c311:8743:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e99503asm25371355e9.29.2025.06.19.04.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 04:15:25 -0700 (PDT)
Message-ID: <72bab3b2-bdd6-43f6-9243-55009f9c1071@redhat.com>
Date: Thu, 19 Jun 2025 13:15:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 13/14] dpll: zl3073x: Add support to get/set
 frequency on input pins
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
 <20250616201404.1412341-14-ivecera@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250616201404.1412341-14-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 10:14 PM, Ivan Vecera wrote:
> +/**
> + * zl3073x_dpll_input_ref_frequency_get - get input reference frequency
> + * @zldpll: pointer to zl3073x_dpll
> + * @ref_id: reference id
> + * @frequency: pointer to variable to store frequency
> + *
> + * Reads frequency of given input reference.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int
> +zl3073x_dpll_input_ref_frequency_get(struct zl3073x_dpll *zldpll, u8 ref_id,
> +				     u32 *frequency)
> +{
> +	struct zl3073x_dev *zldev = zldpll->dev;
> +	u16 base, mult, num, denom;
> +	int rc;
> +
> +	guard(mutex)(&zldev->multiop_lock);
> +
> +	/* Read reference configuration */
> +	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
> +			   ZL_REG_REF_MB_MASK, BIT(ref_id));
> +	if (rc)
> +		return rc;
> +
> +	/* Read registers to compute resulting frequency */
> +	rc = zl3073x_read_u16(zldev, ZL_REG_REF_FREQ_BASE, &base);
> +	if (rc)
> +		return rc;
> +	rc = zl3073x_read_u16(zldev, ZL_REG_REF_FREQ_MULT, &mult);
> +	if (rc)
> +		return rc;
> +	rc = zl3073x_read_u16(zldev, ZL_REG_REF_RATIO_M, &num);
> +	if (rc)
> +		return rc;
> +	rc = zl3073x_read_u16(zldev, ZL_REG_REF_RATIO_N, &denom);
> +	if (rc)
> +		return rc;
> +
> +	/* Sanity check that HW has not returned zero denominator */
> +	if (!denom) {
> +		dev_err(zldev->dev,
> +			"Zero divisor for ref %u frequency got from device\n",
> +			ref_id);
> +		return -EINVAL;
> +	}
> +
> +	/* Compute the frequency */
> +	*frequency = base * mult * num / denom;

As base, mult, num and denom are u16, the above looks like integer
overflow prone.

I think you should explicitly cast to u64, and possibly use a u64 frequency.

/P


