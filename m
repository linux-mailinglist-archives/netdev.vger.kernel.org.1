Return-Path: <netdev+bounces-203322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F96AF1563
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42F6189336F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A1C272804;
	Wed,  2 Jul 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doB3EVWh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78F12571D4
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458629; cv=none; b=rncbU4M8l3pTF09idpLgLLKjALZeU2AEHkOtxMP/4yBtiA/kStD8iSSPHrT8jFLcN9R3UnumUbarSoT+vVpCJipHmJHchAQ8y5aRCighzHYjDM3fxUZ8a2Jk2CS181JbZniedD/6N165FUxwl97qqtNK6NsHWy9uth11nPQTrGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458629; c=relaxed/simple;
	bh=arrFBjkFe46MqYLWVBWkj7DSOrnRYSGqfpNIx8b+8OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQ0yXmxTHRtMxSqrFytbUoHtz+kh97+pnjoXo7JmVbgMEhyO0r9FGqzubs0aAVMl9k5pbqc7sZ3/hqp5ND+qXyZKRdc946H6fbnQkhf0KZP0TY6AnQ+GEnH+qL9TyPDCcag0DouLefsA+lNi7ab7W8EspKvdjIr5YBpg+c0DtP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=doB3EVWh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751458626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CXv4HPGX8MKUJrgwv//0ODreoCsIVgbAC0DLr2hgEhY=;
	b=doB3EVWhfiO/dlH5zPFPm3T5Q2tpG0HpOPNQxGSEe9mqmULn73186ixODTilNLcGeSIcJF
	8ZMesGs/TfHW8Lp82dirqwBbGVQzn+6HHhBLHEumLJw86IObh2VLWtETgQHToryjnxfqbU
	xLFpRiW6AywKzLBNNNJJtuSW93LGz5s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-9oQVOhhVOhK-fBfnP8c5Yw-1; Wed,
 02 Jul 2025 08:17:04 -0400
X-MC-Unique: 9oQVOhhVOhK-fBfnP8c5Yw-1
X-Mimecast-MFC-AGG-ID: 9oQVOhhVOhK-fBfnP8c5Yw_1751458622
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F3BE1808985;
	Wed,  2 Jul 2025 12:17:01 +0000 (UTC)
Received: from [10.45.226.95] (unknown [10.45.226.95])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1086C18003FC;
	Wed,  2 Jul 2025 12:16:54 +0000 (UTC)
Message-ID: <e55caefa-2ea9-4d31-be76-48cdfd481b5c@redhat.com>
Date: Wed, 2 Jul 2025 14:16:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 09/14] dpll: zl3073x: Register DPLL devices
 and pins
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
 Shannon Nelson <shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250629191049.64398-1-ivecera@redhat.com>
 <20250629191049.64398-10-ivecera@redhat.com>
 <ne36b7ky5cg2g3juejcah7bnvsajihncmpzag3vpjnb3gabz2m@xtxhpfhvfmwl>
 <1848e2f6-a0bb-48e6-9bfc-5ea6cbea2e5c@redhat.com>
 <k2osi2mzfmudh7q3av5raxj33smbdjgnrmaqjx2evjaaloddb3@vublvfldqlnm>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <k2osi2mzfmudh7q3av5raxj33smbdjgnrmaqjx2evjaaloddb3@vublvfldqlnm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 02. 07. 25 2:02 odp., Jiri Pirko wrote:
> Wed, Jul 02, 2025 at 01:49:22PM +0200, ivecera@redhat.com wrote:
>>
>>
>> On 02. 07. 25 12:57 odp., Jiri Pirko wrote:
>>> Sun, Jun 29, 2025 at 09:10:44PM +0200, ivecera@redhat.com wrote:
>>>
>>> [...]
>>>
>>>> +/**
>>>> + * zl3073x_dpll_device_register - register DPLL device
>>>> + * @zldpll: pointer to zl3073x_dpll structure
>>>> + *
>>>> + * Registers given DPLL device into DPLL sub-system.
>>>> + *
>>>> + * Return: 0 on success, <0 on error
>>>> + */
>>>> +static int
>>>> +zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
>>>> +{
>>>> +	struct zl3073x_dev *zldev = zldpll->dev;
>>>> +	u8 dpll_mode_refsel;
>>>> +	int rc;
>>>> +
>>>> +	/* Read DPLL mode and forcibly selected reference */
>>>> +	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(zldpll->id),
>>>> +			     &dpll_mode_refsel);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>> +	/* Extract mode and selected input reference */
>>>> +	zldpll->refsel_mode = FIELD_GET(ZL_DPLL_MODE_REFSEL_MODE,
>>>> +					dpll_mode_refsel);
>>>
>>> Who sets this?
>>
>> WDYM? refsel_mode register? If so this register is populated from
>> configuration stored in flash inside the chip. And the configuration
>> is prepared by vendor/OEM.
> 
> Okay. Any plan to implement on-fly change of this?

Do you mean switching between automatic and manual mode?
If so? Yes, later, need to extend DPLL API to allow this.

Ivan

>>
>>>> +	zldpll->forced_ref = FIELD_GET(ZL_DPLL_MODE_REFSEL_REF,
>>>> +				       dpll_mode_refsel);
>>>> +
>>>> +	zldpll->dpll_dev = dpll_device_get(zldev->clock_id, zldpll->id,
>>>> +					   THIS_MODULE);
>>>> +	if (IS_ERR(zldpll->dpll_dev)) {
>>>> +		rc = PTR_ERR(zldpll->dpll_dev);
>>>> +		zldpll->dpll_dev = NULL;
>>>> +
>>>> +		return rc;
>>>> +	}
>>>> +
>>>> +	rc = dpll_device_register(zldpll->dpll_dev,
>>>> +				  zl3073x_prop_dpll_type_get(zldev, zldpll->id),
>>>> +				  &zl3073x_dpll_device_ops, zldpll);
>>>> +	if (rc) {
>>>> +		dpll_device_put(zldpll->dpll_dev);
>>>> +		zldpll->dpll_dev = NULL;
>>>> +	}
>>>> +
>>>> +	return rc;
>>>> +}
>>>
>>> [...]
>>>
>>
> 


