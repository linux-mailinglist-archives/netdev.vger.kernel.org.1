Return-Path: <netdev+bounces-181192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86279A8407E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4685A1B80F04
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5048E280CE8;
	Thu, 10 Apr 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hocVkP6L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCADF26FDB3
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280634; cv=none; b=lVQqmfrFO0BYQHQQjzlJ9AD//YHj9QkL8lMfh+C1wJKyc98GHoimLBABNIyT9uAap7wrCwXGplPdWa79RtQZm8gtLPo76BsGlHxCV8zpCsG3Xud4lbxvxHMHgupxeGqTLtV/LhfK8QstbtBGDwgYtZkowgZkaFeaHMQU6qOiWlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280634; c=relaxed/simple;
	bh=KFFGsaJ42NneK7JhtvnEybxvw/Sz33e6bm09QFRxBRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=al+j33H+KdgvV8W9eBFpeLztm8zHjs0wGPqU+IGRiSubfkBYd7wcb2AzhkB5mNOYAI5e2FRgxmIk0bL8eXu2SuQhACfoufQ6izNYV63TmWHZ9qEfCHiWlLzd48nEn2caqPtScTKdbd6czxljqaSV0HIMrCkAo+dmUA5L4ExRvbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hocVkP6L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744280630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Cmcl/WkdnX++J14o4N9FMLdimmmWjtXNPGTUQE37cs=;
	b=hocVkP6LqrthbNfl9whnd7wy3JhaKX6xulJKn3WL5oz6SO6IROsZNGTqOrGuldeQYrM/4+
	bNkbRl23/1EAwC+gCRpLLcjZg4tm/ULS2DLUdP7bof01v31i0QHySk399EO7VGHaqWqAeR
	JPaHWlqnvhBB2PKhbP2PDC9JElOmx8A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-D1m_GYS7PTGtphfHMR4Rjg-1; Thu,
 10 Apr 2025 06:23:47 -0400
X-MC-Unique: D1m_GYS7PTGtphfHMR4Rjg-1
X-Mimecast-MFC-AGG-ID: D1m_GYS7PTGtphfHMR4Rjg_1744280625
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E51DC1809CA3;
	Thu, 10 Apr 2025 10:23:44 +0000 (UTC)
Received: from [10.44.33.222] (unknown [10.44.33.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07EC63001D11;
	Thu, 10 Apr 2025 10:23:39 +0000 (UTC)
Message-ID: <40239de9-7552-41d1-9ee4-152ece6f33bc@redhat.com>
Date: Thu, 10 Apr 2025 12:23:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/28] mfd: zl3073x: Add components versions register defs
To: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>
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
 <22b9f197-2f98-43c7-9cc9-c748e80078b0@redhat.com>
 <5af77349-5a76-4557-839b-d9ac643f5368@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <5af77349-5a76-4557-839b-d9ac643f5368@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On 10. 04. 25 9:11 dop., Krzysztof Kozlowski wrote:
> On 09/04/2025 08:44, Ivan Vecera wrote:
>> On 07. 04. 25 11:09 odp., Andrew Lunn wrote:
>>> On Mon, Apr 07, 2025 at 07:28:32PM +0200, Ivan Vecera wrote:
>>>> Add register definitions for components versions and report them
>>>> during probe.
>>>>
>>>> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
>>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>>> ---
>>>>    drivers/mfd/zl3073x-core.c | 35 +++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 35 insertions(+)
>>>>
>>>> diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
>>>> index 39d4c8608a740..b3091b00cffa8 100644
>>>> --- a/drivers/mfd/zl3073x-core.c
>>>> +++ b/drivers/mfd/zl3073x-core.c
>>>> @@ -1,10 +1,19 @@
>>>>    // SPDX-License-Identifier: GPL-2.0-only
>>>>    
>>>> +#include <linux/bitfield.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/unaligned.h>
>>>>    #include <net/devlink.h>
>>>>    #include "zl3073x.h"
>>>>    
>>>> +/*
>>>> + * Register Map Page 0, General
>>>> + */
>>>> +ZL3073X_REG16_DEF(id,			0x0001);
>>>> +ZL3073X_REG16_DEF(revision,		0x0003);
>>>> +ZL3073X_REG16_DEF(fw_ver,		0x0005);
>>>> +ZL3073X_REG32_DEF(custom_config_ver,	0x0007);
>>>> +
>>>>    /*
>>>>     * Regmap ranges
>>>>     */
>>>> @@ -159,10 +168,36 @@ EXPORT_SYMBOL_NS_GPL(zl3073x_dev_alloc, "ZL3073X");
>>>>    
>>>>    int zl3073x_dev_init(struct zl3073x_dev *zldev)
>>>>    {
>>>> +	u16 id, revision, fw_ver;
>>>>    	struct devlink *devlink;
>>>> +	u32 cfg_ver;
>>>> +	int rc;
>>>>    
>>>>    	devm_mutex_init(zldev->dev, &zldev->lock);
>>>>    
>>>> +	scoped_guard(zl3073x, zldev) {
>>>
>>> Why the scoped_guard? The locking scheme you have seems very opaque.
>>
>> We are read the HW registers in this block and the access is protected
>> by this device lock. Regmap locking will be disabled in v2 as this is
> 
> Reading ID must be protected by mutex? Why and how?

Yes, the ID is read from the hardware register and HW access functions 
are protected by zl3073x_dev->lock. The access is not protected by 
regmap locking schema. Set of registers are indirect and are accessed by 
mailboxes where multiple register accesses need to be done atomically.
This is the reason why regmap locking is not sufficient.

> What is a "device lock"?

zl3073x_dev->lock

Sorry for confusing.

>> not sufficient.
>>
>>>> +		rc = zl3073x_read_id(zldev, &id);
>>>> +		if (rc)
>>>> +			return rc;
>>>> +		rc = zl3073x_read_revision(zldev, &revision);
>>>> +		if (rc)
>>>> +			return rc;
>>>> +		rc = zl3073x_read_fw_ver(zldev, &fw_ver);
>>>> +		if (rc)
>>>> +			return rc;
>>>> +		rc = zl3073x_read_custom_config_ver(zldev, &cfg_ver);
>>>> +		if (rc)
>>>> +			return rc;
>>>
>>> Could a parallel operation change the ID? Upgrade the firmware
>>> version?
>>>
>>> 	Andrew
>>
>> No, but register access functions require the device lock to be held.
>> See above.
> 
> Andrew comments stay valid here. This is weird need of locking and your
> explanation is very vague.

See above why custom locking schema is necessary.

> BTW, do not send v2 before people respond to your comments in reasonable
> time. You just send 28 patchset and expect people to finish review after
> one day.

I'm sorry... will wait.

Thanks,
Ivan


