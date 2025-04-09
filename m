Return-Path: <netdev+bounces-180614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D451A81DF7
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6CEE7B59A3
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C48253B41;
	Wed,  9 Apr 2025 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTiuiQFq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716D3250C1C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182570; cv=none; b=U+GKrRa1/bP+NhmZWI4oZL96yYDXaPnwNWL/XESHbOqaKUZuyGmeP45Sp90H5QY7IBa3TNwj0wTgAW1NPXTWNNqmTlnyYnspZACVQ6P/J4XU5bV/jn3jms96b8R0pHlSp13kAbD/dXgrr5ilLGXAnodFstFjL0Rvv4pwQ5VcWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182570; c=relaxed/simple;
	bh=Ju61UE3ue+7ZPK1+BpNOyDImzB+6PsUjmMaUw6oxeNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/y6StFenSWO8kPp9oVK4MpVat6K3XXjaVt8zVDn9rajJmhC4UqNXBLrgvo1TynBGiHvJvwbK6QzoZG7LmsVo+q4hQQsltEvDC5M2EGLTPsecrw/F8ajgi1qmxrNERxfGPji0FTpumMruAfXnj1dyGuaX7jhNBcmjiFQMvVRsBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTiuiQFq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744182567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKXNBwTzB3JJWhMXmywSS8c+ahDgNbNsHfEHIzv0RqE=;
	b=XTiuiQFqe5ulMqJA5VeW0F8oK2utDFoWNfM1DbonYleHeI3QX5NTkxpkdv0KFZddTt4J7Q
	b7AD5jygIK6kePt1k7ZngISclEAAwX3zOFrThOMk3cpdlUd+7+0gd00EYPdCo8zwO+hf8U
	kQubm3pGrALFWqTvtVM76N/55qZgTeI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-LqtNNFwjPwKxf1NEBtXEIQ-1; Wed,
 09 Apr 2025 03:09:23 -0400
X-MC-Unique: LqtNNFwjPwKxf1NEBtXEIQ-1
X-Mimecast-MFC-AGG-ID: LqtNNFwjPwKxf1NEBtXEIQ_1744182561
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43E6219560B3;
	Wed,  9 Apr 2025 07:09:21 +0000 (UTC)
Received: from [10.44.32.72] (unknown [10.44.32.72])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B117A19560AD;
	Wed,  9 Apr 2025 07:09:16 +0000 (UTC)
Message-ID: <5bd6c5d4-4ca1-4e53-b073-717a8e8295c6@redhat.com>
Date: Wed, 9 Apr 2025 09:09:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/28] dt-bindings: dpll: Add device tree bindings for
 DPLL device and pin
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
 <20250407173149.1010216-6-ivecera@redhat.com>
 <74172acd-e649-4613-a408-d1f61ceeba8b@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <74172acd-e649-4613-a408-d1f61ceeba8b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 07. 04. 25 8:01 odp., Krzysztof Kozlowski wrote:
> On 07/04/2025 19:31, Ivan Vecera wrote:
>> This adds DT bindings schema for DPLL (device phase-locked loop)
> 
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
> A nit, subject: drop second/last, redundant "device tree bindings for".
> The "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Will fix this in v2.

>> device and associated pin. The schema follows existing DPLL core API
> 
> What is core API in terms of Devicetree?
> 
>> and should be used to expose information that should be provided
>> by platform firmware.
>>
>> The schema for DPLL device describe a DPLL chip that can contain
>> one or more DPLLs (channels) and platform can specify their types.
>> For now 'pps' and 'eec' types supported and these values are mapped
>> to DPLL core's enums.
> 
> Describe entire hardware, not what is supported.

Ack

>>
>> The DPLL device can have optionally 'input-pins' and 'output-pins'
>> sub-nodes that contain pin sub-nodes.
>>
>> These pin sub-nodes follows schema for dpll-pin and can contain
>> information about the particular pin.
> 
> Describe the hardware, not the schema. We can read the contents of
> patch. What we cannot read is the hardware and why you are making all
> these choices.

OK

>>
>> The pin contains the following properties:
>> * reg - pin HW index (physical pin number of given type)
>> * label - string that is used as board label by DPLL core
>> * type - string that indicates pin type (mapped to DPLL core pin type)
>> * esync-control - boolean that indicates whether embeddded sync control
>>                    is allowed for this pin
>> * supported-frequencies - list of 64bit values that represents frequencies
>>                            that are allowed to be configured for the pin
> 
> Drop. Describe the hardware.
> 
> 
>>
>> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> 
> Did this really happen?
> 
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   .../devicetree/bindings/dpll/dpll-device.yaml | 84 +++++++++++++++++++
>>   .../devicetree/bindings/dpll/dpll-pin.yaml    | 43 ++++++++++
>>   MAINTAINERS                                   |  2 +
>>   3 files changed, 129 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
>>   create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> 
> Filenames matching compatibles... unless this is common schema, but
> commit description did not mention it.

Yes, this is common schema to describe a common properties of DPLL 
device that is inherited by a concrete HW implementation (next patch).

>>
>> diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
>> new file mode 100644
>> index 0000000000000..e6c309abb857f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
>> @@ -0,0 +1,84 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dpll/dpll-device.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Digital Phase-Locked Loop (DPLL) Device
>> +
>> +maintainers:
>> +  - Ivan Vecera <ivecera@redhat.com>
>> +
>> +description: |
> 
> Do not need '|' unless you need to preserve formatting.

OK

>> +  Digital Phase-Locked Loop (DPLL) device are used for precise clock
>> +  synchronization in networking and telecom hardware. The device can
>> +  have one or more channels (DPLLs) and one or more input and output
>> +  pins. Each DPLL channel can either produce pulse-per-clock signal
>> +  or drive ethernet equipment clock. The type of each channel is
>> +  indicated by dpll-types property.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^dpll(@.*)?$"
>> +
>> +  "#address-cells":
>> +    const: 0
>> +
>> +  "#size-cells":
>> +    const: 0
> 
> Why do you need these cells?

There are 'input-pins' and 'output-pins' sub-nodes that do not use '@' 
suffix and 'reg' property. They can be specified only once so address 
nor size do not make sense.

>> +
>> +  num-dplls:
>> +    description: Number of DPLL channels in this device.
> 
> Why this is not deducible from compatible?

Yes, it is. Concrete HW implementation should know this.
Will drop.

>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +
>> +  dpll-types:
>> +    description: List of DPLL types, one per DPLL instance.
>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> +    items:
>> +      enum: [pps, eec]
> 
> Why this is not deducible from compatible?

The compatible does not specify how the DPLL channels are used. 
Particular hardware schematics/wiring specify the type of the channel usage.

>> +
>> +  input-pins:
>> +    type: object
>> +    description: DPLL input pins
>> +    unevaluatedProperties: false
> 
> So this is all for pinctrl? Or something else? Could not figure out from
> commit msg. This does not help me either.

No, these pins have nothing to do with pinctrl.
Will describe in next version.

>> +
>> +    properties:
>> +      "#address-cells":
>> +        const: 1
> 
> Why?
> 
>> +      "#size-cells":
>> +        const: 0
> 
> Why? I don't see these being used.

The pin has '@' suffix and 'reg' property that specifies the HW index of 
the pin. (e.g pin@3 under output-pins is the 3rd physical output pin).

>> +
>> +    patternProperties:
>> +      "^pin@[0-9]+$":
>> +        $ref: /schemas/dpll/dpll-pin.yaml
>> +        unevaluatedProperties: false
>> +
>> +    required:
>> +      - "#address-cells"
>> +      - "#size-cells"
>> +
>> +  output-pins:
>> +    type: object
>> +    description: DPLL output pins
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      "#address-cells":
>> +        const: 1
>> +      "#size-cells":
>> +        const: 0
>> +
>> +    patternProperties:
>> +      "^pin@[0-9]+$":
>> +        $ref: /schemas/dpll/dpll-pin.yaml
>> +        unevaluatedProperties: false
>> +
>> +    required:
>> +      - "#address-cells"
>> +      - "#size-cells"
>> +
>> +dependentRequired:
>> +  dpll-types: [ num-dplls ]
>> +
>> +additionalProperties: true
>> diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
>> new file mode 100644
>> index 0000000000000..9aea8ceabb5af
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
>> @@ -0,0 +1,43 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dpll/dpll-pin.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: DPLL Pin
>> +
>> +maintainers:
>> +  - Ivan Vecera <ivecera@redhat.com>
>> +
>> +description: |
>> +  Schema for defining input and output pins of a Digital Phase-Locked Loop (DPLL).
>> +  Each pin can have a set of supported frequencies, label, type and may support
>> +  embedded sync.
>> +
>> +properties:
>> +  reg:
>> +    description: Hardware index of the pin.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  esync-control:
>> +    description: Indicates whether the pin supports embedded sync functionality.
>> +    type: boolean
>> +
>> +  label:
>> +    description: String exposed as the pin board label
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +
>> +  supported-frequencies:
>> +    description: List of supported frequencies for this pin, expressed in Hz.
>> +    $ref: /schemas/types.yaml#/definitions/uint64-array
> 
> Use common property suffixes and drop ref.

Should I use 'supported-frequencies-hz'? If so... This property unit 
type is specified [1] as uint32-matrix, can I use this for list of 
uint64 numbers?

[1] 
https://github.com/devicetree-org/dt-schema/blob/dd3e3dce83607661f2831a8fac9112fae5ebe6cd/dtschema/schemas/property-units.yaml#L56

>> +
>> +  type:
>> +    description: Type of the pin
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    enum: [ext, gnss, int, mux, synce]
>> +
>> +
> 
> Just one blank line

Ack

> I bet that half of my questions could be answered with proper hardware
> description which is missing in commit msg and binding description.
> Instead your commit msg explains schema which makes no sense - I
> mentioned, we can read the schema.
>> +required:
>> +  - reg
> Best regards,
> Krzysztof
> 


