Return-Path: <netdev+bounces-187498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9840BAA77D6
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 18:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCEA173220
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ACD262813;
	Fri,  2 May 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/Zue5+d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0925E45E
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204870; cv=none; b=u8HhN9alaOvaw4dXGYL0J95fK/BVLrDcvgXOPU8Zvqwjr7yDks7xXwYCuSbpWf4sksC6tsiM++Wdg7KRE1kkKER8lnVj9vbNinNEtaqwTWu0WdeByBGZ1F2gTOqGrBQ4+aJ0Nqig11dw6xXP79ZmZUgfrLu1/fp8Skzh9qe/vqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204870; c=relaxed/simple;
	bh=IBdEo4TKzpkkWBzpsOe+Lont38DEq8RTG02a5nilIj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8gbNtV7NdMR+0J301jqwu2J5Wk2sb/Xh/Hemh34h+15em/GN0A1Vcf/Xm2X174Z/ASzctDITrWHFlxMk2FCC+W+A9PvnjRy0aRPWdRL0nQ5czY8ZbzFcqxNRUAlowybLa0seKaGkQYdzQjz0EZe8kIfJVFRmEywGPrDC8oJtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/Zue5+d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746204867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bu9UhU+O+lj6htW8SouO0+6n/1iffy38JAAPOH/btzA=;
	b=Q/Zue5+d1UouLGNzcnzlwAzxdFcFLIcPw2FnUI+JGVXieKHC4oQ57vStqHWkOQm0nTNwzv
	i03iJMbFz3A0SrgvQfgcmqv076ZcQvzwvAFV0hXkKi3YoY/hSEe5WpJAuzAkPozkiP8bXm
	BuMyNC5QBEWGuA1ijkzUuGJkpMSFEVQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-DpK6vXU3NyqxzdYB4IHgDA-1; Fri,
 02 May 2025 12:54:24 -0400
X-MC-Unique: DpK6vXU3NyqxzdYB4IHgDA-1
X-Mimecast-MFC-AGG-ID: DpK6vXU3NyqxzdYB4IHgDA_1746204862
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B19C919560AD;
	Fri,  2 May 2025 16:54:21 +0000 (UTC)
Received: from [10.44.32.102] (unknown [10.44.32.102])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A46F019560A3;
	Fri,  2 May 2025 16:54:16 +0000 (UTC)
Message-ID: <a699035f-3e8d-44d7-917d-13c693feaf2e@redhat.com>
Date: Fri, 2 May 2025 18:54:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250430101126.83708-1-ivecera@redhat.com>
 <20250430101126.83708-9-ivecera@redhat.com>
 <20250501132201.GP1567507@google.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250501132201.GP1567507@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On 01. 05. 25 3:22 odp., Lee Jones wrote:
> On Wed, 30 Apr 2025, Ivan Vecera wrote:
> 
>> Register DPLL sub-devices to expose the functionality provided
>> by ZL3073x chip family. Each sub-device represents one of
>> the available DPLL channels.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>> v4->v6:
>> * no change
>> v3->v4:
>> * use static mfd cells
>> ---
>>   drivers/mfd/zl3073x-core.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
>> index 050dc57c90c3..3e665cdf228f 100644
>> --- a/drivers/mfd/zl3073x-core.c
>> +++ b/drivers/mfd/zl3073x-core.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/device.h>
>>   #include <linux/export.h>
>>   #include <linux/math64.h>
>> +#include <linux/mfd/core.h>
>>   #include <linux/mfd/zl3073x.h>
>>   #include <linux/module.h>
>>   #include <linux/netlink.h>
>> @@ -755,6 +756,14 @@ static void zl3073x_devlink_unregister(void *ptr)
>>   	devlink_unregister(ptr);
>>   }
>>   
>> +static const struct mfd_cell zl3073x_dpll_cells[] = {
>> +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 0),
>> +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 1),
>> +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 2),
>> +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 3),
>> +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 4),
>> +};
> 
> What other devices / subsystems will be involved when this is finished?

Lee, btw. I noticed from another discussion that you mentioned that
mfd_cell->id should not be used outside MFD.

My sub-drivers uses this to get DPLL channel number that should be used
for the particular sub-device.

E.g.
1) MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 2);
2) MFD_CELL_BASIC("zl3073x-phc", NULL, NULL, 0, 3);

In these cases dpll_zl3073x sub-driver will use DPLL channel 2 for this
DPLL sub-device and ptp_zl3073x sub-driver will use DPLL channel 3 for
this PHC sub-device.

platform_device->id cannot be used for this purpose in conjunction with
PLATFORM_DEVID_AUTO as that ->id can be arbitrary.

So if I cannot use mfd_cell->id what should I use for that case?
Platform data per cell with e.g. the DPLL channel number?

Thanks for advices...

Ivan


