Return-Path: <netdev+bounces-181142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CFEA83CFC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18AEF3A9B46
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 08:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC5320AF77;
	Thu, 10 Apr 2025 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yd6UoVMm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3D1E5204
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273634; cv=none; b=KYQBZ1K1ojq2w2lai5zxJw92DjdG7vbFnWXyjkwMDQd/e+aHwSnytu+Zuloro3oBE2HmaETYdsb+GM4j8HjaTH6m45p9KOA8UgQJ0WlEUuQisq9D1VGBZXnWRILWzF4oXD4CtdE+qFULVazya3l+L7z2rwjJAjV9MqczvVqxsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273634; c=relaxed/simple;
	bh=7OgjP2r1y+H3C98mILy/OyuBEWsNZ4LMB1R3QgFCf1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sf341PBVyiSXrvq9gxb1Gt45by7xmau6rMJI8Lqnzld+vpw0ynHGrIF+Ynh1wlHdwwh2tQLSwAVm1w593wsPGCiIWC7dPcv4hlA4PKDlSBeq7Wg9rhjn7kpn5SewbazVBqGQw1phbQg2g8ooFIJbRAYSkudkYcYjNgZA8Eso1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yd6UoVMm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744273631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKzMCc0mBOI4figeschKj6q6v2G4wTIIAmTInqn3cTg=;
	b=Yd6UoVMmOwcJadb73dYwNI9K01Gxk4Xh2UhLBbF9l/zCshuKMFEEqcBmVmL5yYf3dvjFYg
	jIJkirLwFT1E72ZohXpXAPBY0aBVsIquqwihOIpsffIRm0xfY0ba3JKxLprY1e5hSoaM7u
	0IYuqc6cSelny1QKv0RZNq5N4CmuWB4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-eakRA7OoMYml2AecDjx9QQ-1; Thu,
 10 Apr 2025 04:27:07 -0400
X-MC-Unique: eakRA7OoMYml2AecDjx9QQ-1
X-Mimecast-MFC-AGG-ID: eakRA7OoMYml2AecDjx9QQ_1744273625
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4D9D1800263;
	Thu, 10 Apr 2025 08:27:04 +0000 (UTC)
Received: from [10.44.33.222] (unknown [10.44.33.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F9583001D0E;
	Thu, 10 Apr 2025 08:26:59 +0000 (UTC)
Message-ID: <c0ef6dad-ce7e-401c-9ae1-42105fcbf9c4@redhat.com>
Date: Thu, 10 Apr 2025 10:26:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] mfd: zl3073x: Add components versions register
 defs
To: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-8-ivecera@redhat.com>
 <df6a57df-8916-4af2-9eee-10921f90ff93@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <df6a57df-8916-4af2-9eee-10921f90ff93@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10. 04. 25 9:13 dop., Krzysztof Kozlowski wrote:
> On 09/04/2025 16:42, Ivan Vecera wrote:
>> Add register definitions for components versions and report them
>> during probe.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   drivers/mfd/zl3073x-core.c | 36 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
>> index f0d85f77a7a76..28f28d00da1cc 100644
>> --- a/drivers/mfd/zl3073x-core.c
>> +++ b/drivers/mfd/zl3073x-core.c
>> @@ -1,7 +1,9 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   
>>   #include <linux/array_size.h>
>> +#include <linux/bitfield.h>
>>   #include <linux/bits.h>
>> +#include <linux/cleanup.h>
>>   #include <linux/dev_printk.h>
>>   #include <linux/device.h>
>>   #include <linux/export.h>
>> @@ -13,6 +15,14 @@
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
>> @@ -196,7 +206,9 @@ static void zl3073x_devlink_unregister(void *ptr)
>>    */
>>   int zl3073x_dev_init(struct zl3073x_dev *zldev)
>>   {
>> +	u16 id, revision, fw_ver;
>>   	struct devlink *devlink;
>> +	u32 cfg_ver;
>>   	int rc;
>>   
>>   	rc = devm_mutex_init(zldev->dev, &zldev->lock);
>> @@ -205,6 +217,30 @@ int zl3073x_dev_init(struct zl3073x_dev *zldev)
>>   		return rc;
>>   	}
>>   
>> +	/* Take device lock */
> 
> What is a device lock? Why do you need to comment standard guards/mutexes?

Just to inform code reader, this is a section that accesses device 
registers that are protected by this zl3073x device lock.

>> +	scoped_guard(zl3073x, zldev) {
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
>> +	}
> 
> Nothing improved here. Andrew comments are still valid and do not send
> v3 before the discussion is resolved.

I'm accessing device registers here and they are protected by the device 
lock. I have to take the lock, register access functions expect this by 
lockdep_assert.

>> +
>> +	dev_info(zldev->dev, "ChipID(%X), ChipRev(%X), FwVer(%u)\n",
>> +		 id, revision, fw_ver);
>> +	dev_info(zldev->dev, "Custom config version: %lu.%lu.%lu.%lu\n",
>> +		 FIELD_GET(GENMASK(31, 24), cfg_ver),
>> +		 FIELD_GET(GENMASK(23, 16), cfg_ver),
>> +		 FIELD_GET(GENMASK(15, 8), cfg_ver),
>> +		 FIELD_GET(GENMASK(7, 0), cfg_ver));
> 
> 
> Both should be dev_dbg. Your driver should be silent on success.

+1
will change.

>> +
>>   	devlink = priv_to_devlink(zldev);
>>   	devlink_register(devlink);
>>   
> 
> 
> Best regards,
> Krzysztof
> 


