Return-Path: <netdev+bounces-180610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C459A81D5C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8793817EC5E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 06:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1175D1DF984;
	Wed,  9 Apr 2025 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJqxQ0tl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE941E00B4
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181102; cv=none; b=VvZvp8cPueHJgINnJQbz5H4XjsscB45Nd8B4Q9xVSLhTpeDi1vIu79yutILxHrXn4Y1UFMKhqWwAmQOsVdkEmdyYa/CDFLJ+8ZadCGYCRykbgBX7WfcG9S/OjpDfQNAlccK26bwee5vRi0D9h0u8aP/DEV2w/T81qds3e+IWhE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181102; c=relaxed/simple;
	bh=Lk/nerQuXwCVaG1hZ0KR4U4tdyw6/FXCBoB6hXRgscQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APxHwua64SD4bR+HzWES8qx2NlWBspfTgZkKzRM7G0fymQf+F7wa/W/tuoXMFDRkXg9HUDP2XYUnzRNlVLU883597Hshd8stUstpvH50pJLokpUMQYSts6V7TG+GE6DfMcamNpYMYLUxNmB/NuSqHTjPwJSiKuq0/x/YI9itv2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJqxQ0tl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744181099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xyyyv7/mfJ9H0zBbyj9vD5vCWrDye2V05E9brkG1H0g=;
	b=FJqxQ0tlb2yCd5CtizmWFzTbySj2YFqlDidAPfbCc0/84s9Nj4nR7YYtPvyi+RiSeKWRCz
	HBmw1iXprfGYfqFkC+dKQsEnFq9zARGPrcUDVPyLez7eiWzKV4UlvFC60I6+SDWCszFmgb
	LYgezhQiY4uiyIw4XT4j+8d9yQbT5a8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-m6XxHO3uPn6SB5zNQuCBSg-1; Wed,
 09 Apr 2025 02:44:55 -0400
X-MC-Unique: m6XxHO3uPn6SB5zNQuCBSg-1
X-Mimecast-MFC-AGG-ID: m6XxHO3uPn6SB5zNQuCBSg_1744181093
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA7321955DCD;
	Wed,  9 Apr 2025 06:44:52 +0000 (UTC)
Received: from [10.44.32.72] (unknown [10.44.32.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 521C43001D0E;
	Wed,  9 Apr 2025 06:44:47 +0000 (UTC)
Message-ID: <22b9f197-2f98-43c7-9cc9-c748e80078b0@redhat.com>
Date: Wed, 9 Apr 2025 08:44:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/28] mfd: zl3073x: Add components versions register defs
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407172836.1009461-6-ivecera@redhat.com>
 <a5d2e1eb-7b98-4909-9505-ec93fe0c3aac@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <a5d2e1eb-7b98-4909-9505-ec93fe0c3aac@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07. 04. 25 11:09 odp., Andrew Lunn wrote:
> On Mon, Apr 07, 2025 at 07:28:32PM +0200, Ivan Vecera wrote:
>> Add register definitions for components versions and report them
>> during probe.
>>
>> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   drivers/mfd/zl3073x-core.c | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
>> index 39d4c8608a740..b3091b00cffa8 100644
>> --- a/drivers/mfd/zl3073x-core.c
>> +++ b/drivers/mfd/zl3073x-core.c
>> @@ -1,10 +1,19 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   
>> +#include <linux/bitfield.h>
>>   #include <linux/module.h>
>>   #include <linux/unaligned.h>
>>   #include <net/devlink.h>
>>   #include "zl3073x.h"
>>   
>> +/*
>> + * Register Map Page 0, General
>> + */
>> +ZL3073X_REG16_DEF(id,			0x0001);
>> +ZL3073X_REG16_DEF(revision,		0x0003);
>> +ZL3073X_REG16_DEF(fw_ver,		0x0005);
>> +ZL3073X_REG32_DEF(custom_config_ver,	0x0007);
>> +
>>   /*
>>    * Regmap ranges
>>    */
>> @@ -159,10 +168,36 @@ EXPORT_SYMBOL_NS_GPL(zl3073x_dev_alloc, "ZL3073X");
>>   
>>   int zl3073x_dev_init(struct zl3073x_dev *zldev)
>>   {
>> +	u16 id, revision, fw_ver;
>>   	struct devlink *devlink;
>> +	u32 cfg_ver;
>> +	int rc;
>>   
>>   	devm_mutex_init(zldev->dev, &zldev->lock);
>>   
>> +	scoped_guard(zl3073x, zldev) {
> 
> Why the scoped_guard? The locking scheme you have seems very opaque.

We are read the HW registers in this block and the access is protected 
by this device lock. Regmap locking will be disabled in v2 as this is 
not sufficient.

>> +		rc = zl3073x_read_id(zldev, &id);
>> +		if (rc)
>> +			return rc;
>> +		rc = zl3073x_read_revision(zldev, &revision);
>> +		if (rc)
>> +			return rc;
>> +		rc = zl3073x_read_fw_ver(zldev, &fw_ver);
>> +		if (rc)
>> +			return rc;
>> +		rc = zl3073x_read_custom_config_ver(zldev, &cfg_ver);
>> +		if (rc)
>> +			return rc;
> 
> Could a parallel operation change the ID? Upgrade the firmware
> version?
> 
> 	Andrew

No, but register access functions require the device lock to be held. 
See above.

Thanks,
Ivan


