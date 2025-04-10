Return-Path: <netdev+bounces-181194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E02A840B1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E76D7AA12C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B49281353;
	Thu, 10 Apr 2025 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8XZIA95"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD4328134F
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280956; cv=none; b=KgBWiKLxunkTa4Lfmwg/6ybEWaq65WnqR1qPPZBCPbwKVUMrL5zmPo3V//gNlItSPyuuvxntccEAL6kjWfNrpeFiBsW7CgIViKD+iQABFuvXK2U7m7vNzFEVXn71GWUBplTPBjKDGfhQupoIfig7GJB8KfYDPgOSpSw7WoHvE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280956; c=relaxed/simple;
	bh=T2YpW2T64hC3dx1YdyYMPNHuqxtbkydXN6gtVnUJ2Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCW/BNtJpn94AaViTnbbGua3lC74aPhjLtJiihd6QuzuH0TiM5kj48FpH722obJh/HTj+fgMf95Jwc4gX+XZLV+LmkJuIx6pzMHDwR+q6jYc1fLcKBbJa/3BwDKmRjjVrsktblG9AhpMdZQpKtkKDDDJdlbrtKMClKnUilD4F7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8XZIA95; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744280954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1hKyPdATUu7KyOVtsLJLvQEfHei49HiqTvsEP6q4sI=;
	b=E8XZIA95aJhUbbF4A0A5IppBn8eld+Z8DxHpvYkHc0CZYjR8WK1zEhsGbT5BgJmGYytvTy
	U3Ph47ZTHTS1aXWv+uCK+aCL0ERkxskSXTzysn0JyjpHnnIvdJkg7/c7D6tidHkEnHQKut
	cyw3N7/auxqhKVtTWtejtwpBsdFxaHk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-GkIFOQlDN2GVBVJp31Iz8A-1; Thu,
 10 Apr 2025 06:29:07 -0400
X-MC-Unique: GkIFOQlDN2GVBVJp31Iz8A-1
X-Mimecast-MFC-AGG-ID: GkIFOQlDN2GVBVJp31Iz8A_1744280945
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AAEC1956087;
	Thu, 10 Apr 2025 10:29:05 +0000 (UTC)
Received: from [10.44.33.222] (unknown [10.44.33.222])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCD7219560AD;
	Thu, 10 Apr 2025 10:29:00 +0000 (UTC)
Message-ID: <b4d22372-ae85-421c-8ce4-669787160da2@redhat.com>
Date: Thu, 10 Apr 2025 12:28:59 +0200
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
 <280e8a8e-b68f-4536-b9a4-4e924dde0783@redhat.com>
 <b65daab2-8184-45f4-af18-8499e80fbc04@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <b65daab2-8184-45f4-af18-8499e80fbc04@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40



On 10. 04. 25 9:01 dop., Krzysztof Kozlowski wrote:
> On 09/04/2025 09:19, Ivan Vecera wrote:
>>>> +
>>>> +maintainers:
>>>> +  - Ivan Vecera <ivecera@redhat.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - microchip,zl3073x-i2c
>>>> +      - microchip,zl3073x-spi
>>>
>>> 1. No, you do not get two compatibles. Only one.
>>
>> Will split to two files, one for i2c and one for spi.
> 
> No. One device, one compatible.

OK, get it now. I thought that I need to have separate compatible for 
each bus access type.

>>> 2. What is 'x'? Wildcard? If so, drop and use specific compatibles.
>>
>> Microchip refers to the ZL3073x as a family of compatible DPLL chips
>> with the same features. There is no need to introduce separate
>> compatible string for each of them.
> 
> So a wildcard, thus drop. Use full product names. Google search gives me
> no products for ZL3073x but gives me ZL30735.

I will use more appropriate microchip,azurite compatible.

>>
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +
>>>> +allOf:
>>>> +  - $ref: /schemas/dpll/dpll-device.yaml
>>>> +
>>>> +unevaluatedProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    i2c {
>>>> +      #address-cells = <1>;
>>>> +      #size-cells = <0>;
>>>> +
>>>> +      dpll@70 {
>>>> +        compatible = "microchip,zl3073x-i2c";
>>>
>>>> +        #address-cells = <0>;
>>>> +        #size-cells = <0>;
>>>
>>> Again, why do you need them if you are not using these two?
>>
>> The dpll-device.yaml defines them as required. Shouldn't they be
>> specified explicitly?
> 
> But you do not use them. Where is any child node?

I though I have to specify this due to existence of 'input-pins' and 
'output-pins' in the example.

>>
>>>> +        reg = <0x70>;
>>>> +        status = "okay";
>>>
>>> Drop
> Best regards,
> Krzysztof
> 

Thanks,
Ivan


