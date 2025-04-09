Return-Path: <netdev+bounces-180617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E57A81E1F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30184A3138
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D525A2A7;
	Wed,  9 Apr 2025 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCp50GHf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCDC22ACEE
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183188; cv=none; b=YwwcXrBdaPKNQc0xo49gRjJUeEdwHo/UILUr1Mji4FbbgTr+sgX1eVrGM86NkwohVLBn5oXynxvcfizPnKniK2rRFjgIetcGu+/j+5tB+oP38qVG6DfUc506ZYYucbH9bFtZpwFD2mCORqeJSFXhOEsEuaZQmq/ng2tlSACgimA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183188; c=relaxed/simple;
	bh=xY3OrvxpN12CBiShIEEAnUDF9lnn4uFm+kgUk/nG3bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zp/q8PeyjD2QplTT0MNuxhzo0ZDOMeKzg+frLKVo3GNEdMYoP4Bixhif5S9jkIn1CmO0AgZWRNQz7XhHys6J9jnBXzWE9kWECknW8U8M/DRrbviFEeYs7/SXpY6Yrp27/0Sxwru0MPsXdW/yPHyvJnHFhXLl/ejjtf6cUB9Mq+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCp50GHf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744183185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnD2Cmi/5vHxE2WCVwIRip4Gvb9KNwXCbHUYmCj7z5A=;
	b=iCp50GHfRiFT+kdrDVmH3nXKlAKZzh8QHVNxrM/QQwhTbx350bz+oe3SToG3MliUZQ2Jtp
	2gxkBXqLktD9butrPHCkmjogwb3q67j7pYiJbrdP0pX53VXae2F4DleiMtOzkMqoRkXFV/
	9HLXlce9IC9bieSz+Kt2395N4rLETrU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-HvmobODIOZCuoAaVyolrlA-1; Wed,
 09 Apr 2025 03:19:40 -0400
X-MC-Unique: HvmobODIOZCuoAaVyolrlA-1
X-Mimecast-MFC-AGG-ID: HvmobODIOZCuoAaVyolrlA_1744183178
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43CFF19560BB;
	Wed,  9 Apr 2025 07:19:38 +0000 (UTC)
Received: from [10.44.32.72] (unknown [10.44.32.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 585451955DCE;
	Wed,  9 Apr 2025 07:19:33 +0000 (UTC)
Message-ID: <280e8a8e-b68f-4536-b9a4-4e924dde0783@redhat.com>
Date: Wed, 9 Apr 2025 09:19:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/28] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
To: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
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
 <20250407173149.1010216-7-ivecera@redhat.com>
 <7dfede37-2434-4892-8c8d-4d005fa1072b@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <7dfede37-2434-4892-8c8d-4d005fa1072b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 07. 04. 25 8:04 odp., Krzysztof Kozlowski wrote:
> On 07/04/2025 19:31, Ivan Vecera wrote:
>> This adds DT bindings schema for Microchip Azurite DPLL chip family.
> 
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
>> These bindings are used by zl3073x driver and specifies this device
>> that can be connected either to I2C or SPI bus.
> 
> Bindings are for hardware, not driver. Explain the hardware.

OK

>>
>> The schema inherits existing dpll-device and dpll-pin schemas.
>>
> 
> Do not explain what schema does - we see  it. Explain the hardware which
> we do not see here, because we (or to be precise: I) know nothing about.

OK

>> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   .../bindings/dpll/microchip,zl3073x.yaml      | 74 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 75 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl3073x.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl3073x.yaml
>> new file mode 100644
>> index 0000000000000..38a6cc00bc026
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dpll/microchip,zl3073x.yaml
>> @@ -0,0 +1,74 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dpll/microchip,zl3073x.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Microchip Azurite DPLL device
>> +
>> +maintainers:
>> +  - Ivan Vecera <ivecera@redhat.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - microchip,zl3073x-i2c
>> +      - microchip,zl3073x-spi
> 
> 1. No, you do not get two compatibles. Only one.

Will split to two files, one for i2c and one for spi.

> 2. What is 'x'? Wildcard? If so, drop and use specific compatibles.

Microchip refers to the ZL3073x as a family of compatible DPLL chips 
with the same features. There is no need to introduce separate 
compatible string for each of them.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +allOf:
>> +  - $ref: /schemas/dpll/dpll-device.yaml
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      dpll@70 {
>> +        compatible = "microchip,zl3073x-i2c";
> 
>> +        #address-cells = <0>;
>> +        #size-cells = <0>;
> 
> Again, why do you need them if you are not using these two?

The dpll-device.yaml defines them as required. Shouldn't they be 
specified explicitly?

>> +        reg = <0x70>;
>> +        status = "okay";
> 
> Drop

OK

> Also, follow DTS coding style and order properties properly.
> 
>> +
>> +        num-dplls = <2>;
>> +        dpll-types = "pps", "eec";
>> +

Ack
> Best regards,
> Krzysztof
> 


