Return-Path: <netdev+bounces-187254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF2FAA5F88
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 15:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A261BA3D38
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068A1D5CD7;
	Thu,  1 May 2025 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMRdBJsz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF719D06B
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107530; cv=none; b=h+kjlPxDO9wxPPTtvhkao+hrYyIps6BrzFIEGvHuVHKDDEm/TAJL1+9O14tDlaQBfHjHPsI+eJftZTuMpobkE69VomMZf7MYVCxIpnKJkQBcFdqnxrsMhEFuTbNRHYzmaMcuKRl6Wa4AWv3YjblcRKzgjpFjuc4SNTl0NnUGRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107530; c=relaxed/simple;
	bh=TBF9cHqvsBBjMo+hOAdT/xXFYkhNbU6400lnc2ENgSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnxLgcewNwp6ixgt5qg/Llv2eOAtNsPWpAayiv2kqY16Q9OynU8VBPCk9ArlUHwieeJmkaNyy0nYscLZWtIZTBWqBguoqeAaPRPdEvmo5ZsOhrzrQMfLRfNo3Tzska69fEB/BVIA9qni+ubq2ouZBfTSM2ADA7r4ZNvv7NQNN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMRdBJsz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746107527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7Og0tNFd6K52qkvPJcrj4sxsIAm+zhBLcJjT2wd0Ho=;
	b=WMRdBJszvjYxn3XG0iMjtn025v21Tye9+grZrisATFnkujRpJNro//qb1icsI9gs2gKpEU
	2G3DUfjxuuGfmMb9BJPxEs8/N9rfApwquFJPyLdbh4T0krJbOVCiaPV5le8vlBluXxSYiG
	a4QaYHqTGguq0pbXG2m2qAhYwd/Srtk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-nJJNEWtTOJa3lZu8ag0sgA-1; Thu,
 01 May 2025 09:52:04 -0400
X-MC-Unique: nJJNEWtTOJa3lZu8ag0sgA-1
X-Mimecast-MFC-AGG-ID: nJJNEWtTOJa3lZu8ag0sgA_1746107522
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CC541800990;
	Thu,  1 May 2025 13:52:02 +0000 (UTC)
Received: from [10.44.32.102] (unknown [10.44.32.102])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DF311956094;
	Thu,  1 May 2025 13:51:55 +0000 (UTC)
Message-ID: <5eefb009-f920-4954-9ef9-4a00791e3129@redhat.com>
Date: Thu, 1 May 2025 15:51:06 +0200
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


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
> 
PHC/PTP driver and in future GPIO controller.

I'm adding here only DPLL for now as it is finished and ready
(part2)... PTP driver is now in progress and GPIO is in planning phase.

Ivan


