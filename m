Return-Path: <netdev+bounces-181541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B06A6A85605
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F2419E6A36
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FEB28EA47;
	Fri, 11 Apr 2025 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YH3HqqvH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA21F0990
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744358488; cv=none; b=bl022bqcPgSC9TsMgy8J5rSkcr1t5N4CkI+d5HSUaBLnJ5slh/Q04DZJHzr6a5OdgdtPa7DwkcBWaA485jQVZ/SV/7h8BAn7/VHZzV/dAyNy4LLG0OHNRQW41lOGwWN+r0btnWtaA+KvioiRmKf/Aq+feAPDBWGpvf4isGcXhIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744358488; c=relaxed/simple;
	bh=7HpYJ2qu2P7Z6iGhZXhWC2kKKmcV6NItufe2Jaqo0zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuERBPUf213jgbWtLYw1pMzOUqrHd4eZMaUB7f9lrq/W6MLXmjsn5GQg536CYDqG+MvrC9zzC0HwciphfwPsA1ARatBK63Ox4sszpjFSTXWDNiSDmGPOeyvRU5GwXPxtZ1Kz+GC0wYEmJ8CeQpJTbzDPo2vZAeY22sz1D1xMp4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YH3HqqvH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744358485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kuoOwVeCLC2BNxuJu8PYjCz8x0OZU31drELGm05wlM4=;
	b=YH3HqqvH7BJVe3GDaigOt75BhLEAvKVGOuSTJtGsPSwWiuNQCn/BNDWk6zc8P4G2ehwSw7
	eMoEOInjFf/onKefJTx0puJQ8nSN+ohvRWhLXNh8oBvAwFEvjgZGYr+hGV9gELUVvXruBj
	23EwCJxG2XuML1R1/aqUT6cDEpKOWqw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-MKaejLBYOtiCJIwWsZx4Dw-1; Fri,
 11 Apr 2025 04:01:20 -0400
X-MC-Unique: MKaejLBYOtiCJIwWsZx4Dw-1
X-Mimecast-MFC-AGG-ID: MKaejLBYOtiCJIwWsZx4Dw_1744358478
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79C7A195606B;
	Fri, 11 Apr 2025 08:01:18 +0000 (UTC)
Received: from [10.45.225.124] (unknown [10.45.225.124])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9668E1809BF5;
	Fri, 11 Apr 2025 08:01:13 +0000 (UTC)
Message-ID: <c68dd22d-f9e3-43d0-8090-e7f53265ef89@redhat.com>
Date: Fri, 11 Apr 2025 10:01:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] Add Microchip ZL3073x support (part 1)
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250411072616.GU372032@google.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250411072616.GU372032@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 11. 04. 25 9:26 dop., Lee Jones wrote:
> On Wed, 09 Apr 2025, Ivan Vecera wrote:
> 
>> Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
>> provides DPLL and PTP functionality. This series bring first part
>> that adds the common MFD driver that provides an access to the bus
>> that can be either I2C or SPI.
>>
>> The next series will bring the DPLL driver that will covers DPLL
>> functionality. And another ones will bring PTP driver and flashing
>> capability via devlink.
>>
>> Testing was done by myself and by Prathosh Satish on Microchip EDS2
>> development board with ZL30732 DPLL chip connected over I2C bus.
>>
>> Patch breakdown
>> ===============
>> Patch 1 - Common DT schema for DPLL device and pin
>> Patch 3 - Basic support for I2C, SPI and regmap
>> Patch 4 - Devlink registration
>> Patches 5-6 - Helpers for accessing device registers
>> Patches 7-8 - Component versions reporting via devlink dev info
>> Patches 9-10 - Helpers for accessing register mailboxes
>> Patch 11 - Clock ID generation for DPLL driver
>> Patch 12 - Export strnchrnul function for modules
>>             (used by next patch)
>> Patch 13 - Support for MFG config initialization file
>> Patch 14 - Fetch invariant register values used by DPLL and later by
>>             PTP driver
>>
>> Ivan Vecera (14):
>>    dt-bindings: dpll: Add device tree bindings for DPLL device and pin
>>    dt-bindings: dpll: Add support for Microchip Azurite chip family
>>    mfd: Add Microchip ZL3073x support
>>    mfd: zl3073x: Register itself as devlink device
>>    mfd: zl3073x: Add register access helpers
>>    mfd: zl3073x: Add macros for device registers access
>>    mfd: zl3073x: Add components versions register defs
>>    mfd: zl3073x: Implement devlink device info
>>    mfd: zl3073x: Add macro to wait for register value bits to be cleared
>>    mfd: zl3073x: Add functions to work with register mailboxes
>>    mfd: zl3073x: Add clock_id field
>>    lib: Allow modules to use strnchrnul
>>    mfd: zl3073x: Load mfg file into HW if it is present
>>    mfd: zl3073x: Fetch invariants during probe
>>
>>   .../devicetree/bindings/dpll/dpll-device.yaml |  76 ++
>>   .../devicetree/bindings/dpll/dpll-pin.yaml    |  44 +
>>   .../bindings/dpll/microchip,zl3073x-i2c.yaml  |  74 ++
>>   .../bindings/dpll/microchip,zl3073x-spi.yaml  |  77 ++
>>   MAINTAINERS                                   |  11 +
>>   drivers/mfd/Kconfig                           |  32 +
>>   drivers/mfd/Makefile                          |   5 +
>>   drivers/mfd/zl3073x-core.c                    | 883 ++++++++++++++++++
>>   drivers/mfd/zl3073x-i2c.c                     |  59 ++
>>   drivers/mfd/zl3073x-spi.c                     |  59 ++
>>   drivers/mfd/zl3073x.h                         |  14 +
>>   include/linux/mfd/zl3073x.h                   | 363 +++++++
>>   lib/string.c                                  |   1 +
>>   13 files changed, 1698 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
>>   create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
>>   create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
>>   create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x-spi.yaml
>>   create mode 100644 drivers/mfd/zl3073x-core.c
>>   create mode 100644 drivers/mfd/zl3073x-i2c.c
>>   create mode 100644 drivers/mfd/zl3073x-spi.c
>>   create mode 100644 drivers/mfd/zl3073x.h
>>   create mode 100644 include/linux/mfd/zl3073x.h
> 
> Not only are all of the added abstractions and ugly MACROs hard to read
> and troublesome to maintain, they're also completely unnecessary at this
> (driver) level.  Nicely authored, easy to read / maintain code wins over
> clever code 95% of the time.  Exporting functions to pass around
> pointers to private structures is also a non-starter.

If you mean regmap_config exported to zl3073x-i2c/spi modules then these 
three modules could be squashed together into single module.

> After looking at the code, there doesn't appear to be any inclusion of
> the MFD core header.  How can this be an MFD if you do not use the MFD
> API?  MFD is not a dumping area for common code and call-backs.  It's a
> subsystem used to neatly separate out and share resources between
> functionality that just happens to share the same hardware chip.

You are right, the v2 series was spliced into 2 separate series as the 
bot warns about too big (>15 commits) series. The real MFD API usage is 
present in the second one (or in patch 14 of the v1 patch-set) when MFD 
cells are created for DPLL functional blocks.

And yes, I chose the MFD for the common part because DPLL and PTP 
functions share the same registers concurrently. And MFD could be the 
right place for exposing these shared resources and providing 
synchronized access to them. The device has also GPIO functionality that 
could be potentially covered in the future.

Or would you prefer to implement all these functional block in one 
monolithic driver? Would it be better for maintenance?

Thanks,
Ivan


