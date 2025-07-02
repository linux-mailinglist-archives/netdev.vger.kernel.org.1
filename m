Return-Path: <netdev+bounces-203314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC1BAF146E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADFF3BBAB5
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D96263F22;
	Wed,  2 Jul 2025 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hg27Hb5y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0225A630
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456848; cv=none; b=YLlofhj1muHs1eoARHeg7/mXVQwEe0Bh1eu0AsOhXKURfjPe7ICo0Q/hI1k6G4LSlaHlflzzwQ8k+/TPhsL8tgrEA/DTz41mKulNrskLvr1c0oPxD5UTtHWHkb6mKhYqELfSNXUTvkb+N+hlYDqJQ783GtyrucgAYOdib6i4FcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456848; c=relaxed/simple;
	bh=EdrNrz0J5/F40ltBEuQ5eTDBQM8WpBm8Wgb12vkPL4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXkdTDnAuLwXbZx1Ez6TfWyYEoH9uD9NOAlcFhG/v6932rSPk126+an0v+8z2aW863LX+htFjaa23Rnw+gTJr/ygEKXNkvDLH19lyW30q+yeTBHqVttvMZRDWKdhB9qFDT7CbxGMaqlkUYWWkp9l1lMFs3FJW5xRjoXpwdMGUeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hg27Hb5y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751456846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vpjls0kbN64i2dWrj9KDXg1RVSJyJ1rvA/dpxJi7NRE=;
	b=hg27Hb5yGLoSjmqhsSbIIRtxlFHzjydmRfLkhQtD3X9SVMOWZG/Wbmjj4ob4Xw5/euTLq1
	v3tdjAKJNFp7VHlUMvRRyAFaXt413dbXrLb85f0cXABApyqbnP3goVo62O9s0LtNA/7KLJ
	4weSAx2Ae8zfjYlqFWw6gNKtHV+qLxY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-U-JgH6XrNR2I76D7Zs9FDQ-1; Wed,
 02 Jul 2025 07:47:22 -0400
X-MC-Unique: U-JgH6XrNR2I76D7Zs9FDQ-1
X-Mimecast-MFC-AGG-ID: U-JgH6XrNR2I76D7Zs9FDQ_1751456839
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D996B180028A;
	Wed,  2 Jul 2025 11:47:18 +0000 (UTC)
Received: from [10.45.226.95] (unknown [10.45.226.95])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BCBA30001B9;
	Wed,  2 Jul 2025 11:47:12 +0000 (UTC)
Message-ID: <18e5cef5-7907-4c65-a255-56af0cfa67b8@redhat.com>
Date: Wed, 2 Jul 2025 13:47:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 08/14] dpll: zl3073x: Read DPLL types and pin
 properties from system firmware
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shannon Nelson <shannon.nelson@amd.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250629191049.64398-1-ivecera@redhat.com>
 <20250629191049.64398-9-ivecera@redhat.com>
 <vpzjeh5kc6s4cpah5wagdy6sm3rzt6vlfyfcdbenppwnzftzow@u4xu7mhzg77u>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <vpzjeh5kc6s4cpah5wagdy6sm3rzt6vlfyfcdbenppwnzftzow@u4xu7mhzg77u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 02. 07. 25 12:41 odp., Jiri Pirko wrote:
> Sun, Jun 29, 2025 at 09:10:43PM +0200, ivecera@redhat.com wrote:
> 
> [...]
> 
> 
>> +/**
>> + * zl3073x_prop_dpll_type_get - get DPLL channel type
>> + * @zldev: pointer to zl3073x device
>> + * @index: DPLL channel index
>> + *
>> + * Return: DPLL type for given DPLL channel
>> + */
>> +enum dpll_type
>> +zl3073x_prop_dpll_type_get(struct zl3073x_dev *zldev, u8 index)
>> +{
>> +	const char *types[ZL3073X_MAX_CHANNELS];
>> +	int count;
>> +
>> +	/* Read dpll types property from firmware */
>> +	count = device_property_read_string_array(zldev->dev, "dpll-types",
>> +						  types, ARRAY_SIZE(types));
>> +
>> +	/* Return default if property or entry for given channel is missing */
>> +	if (index >= count)
>> +		return DPLL_TYPE_PPS;
> 
> Not sure how this embedded stuff works, but isn't better to just bail
> out in case this is not present/unknown_value? Why assuming PPS is
> correct?

Per discussion with Microchip, the PPS should be reported as default.
The platform can define either via DT or APCI or software_node the
values for the DPLLs. Anyway this attribute is informational.

>> +
>> +	if (!strcmp(types[index], "pps"))
>> +		return DPLL_TYPE_PPS;
>> +	else if (!strcmp(types[index], "eec"))
>> +		return DPLL_TYPE_EEC;
>> +
>> +	dev_info(zldev->dev, "Unknown DPLL type '%s', using default\n",
>> +		 types[index]);
>> +
>> +	return DPLL_TYPE_PPS; /* Default */
>> +}
> 
> [...]
> 


