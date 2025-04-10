Return-Path: <netdev+bounces-181375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2B2A84B1D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DF39A055F
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AA01EFF8E;
	Thu, 10 Apr 2025 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrbJ11Hy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBE71A5BA9
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306604; cv=none; b=hP5mxMC3ZNBe9JdfLFCBD/TzDUFHus8A2qKryoPUHoaQuToooWxBuw56vH8eCBHDMndE+Fh7qBhldKGsZfaejlr2cuBSpTvgJwrgzgStuXpISKLGXQ2TjHj0JZTl84s7Nx7Ov6IHwuNPlG9l7wbBgTYBP7rNoXohF+H6STYN1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306604; c=relaxed/simple;
	bh=aIqRiPJkeBNJZ2nrGcOImZWCaryBj+bGa1evPPogC6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eay7PAcubvB+X8dtFijVsEY8QgPVhr3V9ti+pQ8fPEI60HB82A3H/2048GfcnvpM8cFsRJbbzTZjNQ9aNluzny8KctkPf8c9Bq36GyZUXqVmGVpbHBfjZFDiXeDPZAh5S2rd1HIjG+sNWFEczEdQgLxwIRqA91Ai3Fh9EpDmEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XrbJ11Hy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744306601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NiN7dJ3m76P3AfIAhVC2mtIUN5C4W6S+EN7YkuF0Xws=;
	b=XrbJ11HyuWPyBaWD1+qxNN3RPlRMDGUbcOGXaWzryWsK5Tcq0wHe7cbsmaWjePEVRFWWkw
	L+1GPH91K/nP8ak2Mv/cVObpFUaDzkQ4nojz+Xf8Too1lycQjBZinEKo1xgU+1MV21dwUT
	NlTxqjPpY7ljM29hGBzbM+DSv8fJAJU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-HJZRTcrYNR2wQUOzY8zPUg-1; Thu,
 10 Apr 2025 13:36:38 -0400
X-MC-Unique: HJZRTcrYNR2wQUOzY8zPUg-1
X-Mimecast-MFC-AGG-ID: HJZRTcrYNR2wQUOzY8zPUg_1744306596
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A93E91800257;
	Thu, 10 Apr 2025 17:36:35 +0000 (UTC)
Received: from [10.45.225.124] (unknown [10.45.225.124])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 004CA1955DCE;
	Thu, 10 Apr 2025 17:36:30 +0000 (UTC)
Message-ID: <7f24f249-f49a-4365-930f-f4ebe502c6bf@redhat.com>
Date: Thu, 10 Apr 2025 19:36:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
To: Prathosh.Satish@microchip.com, conor@kernel.org
Cc: krzk@kernel.org, netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, kees@kernel.org,
 andy@kernel.org, akpm@linux-foundation.org, mschmidt@redhat.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-3-ivecera@redhat.com>
 <20250410-skylark-of-silent-symmetry-afdec9@shite>
 <1a78fc71-fcf6-446e-9ada-c14420f9c5fe@redhat.com>
 <20250410-puritan-flatbed-00bf339297c0@spud>
 <6dc1fdac-81cc-4f2c-8d07-8f39b9605e04@redhat.com>
 <CY5PR11MB6462412A953AF5D93D97DCE5ECB72@CY5PR11MB6462.namprd11.prod.outlook.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CY5PR11MB6462412A953AF5D93D97DCE5ECB72@CY5PR11MB6462.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 10. 04. 25 7:07 odp., Prathosh.Satish@microchip.com wrote:
> -----Original Message-----
> From: Ivan Vecera <ivecera@redhat.com>
> Sent: Thursday 10 April 2025 14:36
> To: Conor Dooley <conor@kernel.org>; Prathosh Satish - M66066 <Prathosh.Satish@microchip.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>; netdev@vger.kernel.org; Vadim Fedorenko <vadim.fedorenko@linux.dev>; Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>; Jiri Pirko <jiri@resnulli.us>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Prathosh Satish - M66066 <Prathosh.Satish@microchip.com>; Lee Jones <lee@kernel.org>; Kees Cook <kees@kernel.org>; Andy Shevchenko <andy@kernel.org>; Andrew Morton <akpm@linux-foundation.org>; Michal Schmidt <mschmidt@redhat.com>; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardening@vger.kernel.org
> Subject: Re: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip Azurite chip family
> 
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 10. 04. 25 3:18 odp., Conor Dooley wrote:
>> On Thu, Apr 10, 2025 at 09:45:47AM +0200, Ivan Vecera wrote:
>>>
>>>
>>> On 10. 04. 25 9:06 dop., Krzysztof Kozlowski wrote:
>>>> On Wed, Apr 09, 2025 at 04:42:38PM GMT, Ivan Vecera wrote:
>>>>> Add DT bindings for Microchip Azurite DPLL chip family. These chips
>>>>> provides 2 independent DPLL channels, up to 10 differential or
>>>>> single-ended inputs and up to 20 differential or 20 single-ended outputs.
>>>>> It can be connected via I2C or SPI busses.
>>>>>
>>>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>>>> ---
>>>>>     .../bindings/dpll/microchip,zl3073x-i2c.yaml  | 74 ++++++++++++++++++
>>>>>     .../bindings/dpll/microchip,zl3073x-spi.yaml  | 77
>>>>> +++++++++++++++++++
>>>>
>>>> No, you do not get two files. No such bindings were accepted since
>>>> some years.
>>>>
>>>>>     2 files changed, 151 insertions(+)
>>>>>     create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
>>>>>     create mode 100644
>>>>> Documentation/devicetree/bindings/dpll/microchip,zl3073x-spi.yaml
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
>>>>> b/Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
>>>>> new file mode 100644
>>>>> index 0000000000000..d9280988f9eb7
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.
>>>>> +++ yaml
>>>>> @@ -0,0 +1,74 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
>>>>> +---
>>>>> +$id:
>>>>> +http://devicetree.org/schemas/dpll/microchip,zl3073x-i2c.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: I2C-attached Microchip Azurite DPLL device
>>>>> +
>>>>> +maintainers:
>>>>> +  - Ivan Vecera <ivecera@redhat.com>
>>>>> +
>>>>> +description:
>>>>> +  Microchip Azurite DPLL (ZL3073x) is a family of DPLL devices
>>>>> +that
>>>>> +  provides 2 independent DPLL channels, up to 10 differential or
>>>>> +  single-ended inputs and up to 20 differential or 20 single-ended outputs.
>>>>> +  It can be connected via multiple busses, one of them being I2C.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - microchip,zl3073x-i2c
>>>>
>>>> I already said: you have one compatible, not two. One.
>>>
>>> Ah, you mean something like:
>>> iio/accel/adi,adxl313.yaml
>>>
>>> Do you?
>>>
>>>> Also, still wildcard, so still a no.
>>>
>>> This is not wildcard, Microchip uses this to designate DPLL devices
>>> with the same characteristics.
>>
>> That's the very definition of a wildcard, no? The x is matching
>> against several different devices. There's like 14 different parts
>> matching zl3073x, with varying numbers of outputs and channels. One
>> compatible for all of that hardly seems suitable.
> 
> Prathosh, could you please bring more light on this?
> 
> Just to clarify, the original driver was written specifically with 2-channel
> chips in mind (ZL30732) with 10 input and 20 outputs, which led to some confusion of using zl3073x as compatible.
> However, the final version of the driver will support the entire ZL3073x family
> ZL30731 to ZL30735 and some subset of ZL30732 like ZL80732 etc
> ensuring compatibility across all variants.

Huh, then ok... We should specify zl30731-5 compatibles and they differs 
only by number of channels (1-5) ?

The number of input and output pins are the same (10 and 20), right?

If so, I have to update the whole driver to accommodate dynamic number 
of channels according chip type.

Btw. Conor, Krzystof if we use microchip,zl30731, ..., 
microchip,zl30735... What should be the filename for the yaml file?

Thanks,
Ivan

> Thanks.
>>
>>>
>>> But I can use microchip,azurite, is it more appropriate?
>>
>> No, I think that is worse actually.
> 


