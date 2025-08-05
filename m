Return-Path: <netdev+bounces-211744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D63B1B773
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 17:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5EC626A29
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F6327A121;
	Tue,  5 Aug 2025 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1qmtMrq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC1279327
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407592; cv=none; b=rsqJLRbEDFx9UB6wPO5aak+ygZOOoinGLSXQz5eiwvLeakqN07Tihz961Dj2u7VtRqmFoN3+4fKN98vNMAEDf2+LTd7OoDKfH0yAd8Nvq+2JUoe45eX2zG7K4x7iiow3NDYKXeLq1AHyw1AcXV2Pxi4bu2uSZ/IBr51/o3bWQoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407592; c=relaxed/simple;
	bh=ClPDABoCKyds0P7p212Dc2TrMGxmXyvr84QrKA39lfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foaBF3Tf+0WrV5NcYzvTA5rbxxQ4AN0r+zc2ftVIbXixVgBacReg3xT+maTse2CrbirhtH3c2/YtLeXg4UmF+h9yTgmiwEUB0Ii+DC7++ppW+tJQULutyPpN/NlRziIprgKQJtzRxE4v5kqsY//3no7rDB/cEC5a9x6OrYUuBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1qmtMrq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754407589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXoRJsKx4vdNmT+9ZbmAJuS3gw/IRi0dWODJu4jAvGw=;
	b=L1qmtMrqQ2kLLbvc+DYXKmYvfZQk7cZALQEKln5Wd9ymjpRpVtmPYWzUjOPXMVdo1EFOt0
	Pothi8ZvqhVZ/Lct4B9B1ByrDe0bIvC6SeZjc54IkYHMHgqTscn8ZRDo0/fChfRNf7/dSi
	rEg/olJ5BkpLoXsu2XG15De8jRuIA9E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-ssCeknXJO8OgPQycv79brw-1; Tue,
 05 Aug 2025 11:26:25 -0400
X-MC-Unique: ssCeknXJO8OgPQycv79brw-1
X-Mimecast-MFC-AGG-ID: ssCeknXJO8OgPQycv79brw_1754407583
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A77C195608F;
	Tue,  5 Aug 2025 15:26:23 +0000 (UTC)
Received: from [10.43.3.116] (unknown [10.43.3.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11BCB1955E88;
	Tue,  5 Aug 2025 15:26:18 +0000 (UTC)
Message-ID: <b33c76da-8ce1-402f-b252-f6d439ec39c7@redhat.com>
Date: Tue, 5 Aug 2025 17:26:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: dpll: Add clock ID property
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250717171100.2245998-1-ivecera@redhat.com>
 <20250717171100.2245998-2-ivecera@redhat.com>
 <5ff2bb3e-789e-4543-a951-e7f2c0cde80d@kernel.org>
 <6937b833-4f3b-46cc-84a6-d259c5dc842a@redhat.com>
 <20250721-lean-strong-sponge-7ab0be@kuoka>
 <804b4a5f-06bc-4943-8801-2582463c28ef@redhat.com>
 <9220f776-8c82-474b-93fc-ad6b84faf5cc@kernel.org>
 <466e293c-122f-4e11-97d2-6f2611a5178e@redhat.com>
 <db39e1ff-8f83-468c-a8cb-0dd7c5a98b85@kernel.org>
 <f96b3236-f8e6-40c1-afb2-7e76894462f9@redhat.com>
 <1419bca0-b85a-4d4b-af1a-b0540c25933a@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <1419bca0-b85a-4d4b-af1a-b0540c25933a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 04. 08. 25 8:45 odp., Andrew Lunn wrote:
>> Let's say we have a SyncE setup with two network controllers where each
>> of them feeds a DPLL channel with recovered clock received from some of
>> its PHY. The DPLL channel cleans/stabilizes this input signal (generates
>> phase aligned signal locked to the same frequency as the input one) and
>> routes it back to the network controller.
>>
>>      +-----------+
>>   +--|   NIC 1   |<-+
>>   |  +-----------+  |
>>   |                 |
>>   | RxCLK     TxCLK |
>>   |                 |
>>   |  +-----------+  |
>>   +->| channel 1 |--+
>>      |-- DPLL ---|
>>   +->| channel 2 |--+
>>   |  +-----------+  |
>>   |                 |
>>   | RxCLK     TxCLK |
>>   |                 |
>>   |  +-----------+  |
>>   +--|   NIC 2   |<-+
>>      +-----------+
>>
>> The PHCs implemented by the NICs have associated the ClockIdentity
>> (according IEEE 1588-2008) whose value is typically derived from
>> the NIC's MAC address using EUI-64. The DPLL channel should be
>> registered to DPLL subsystem using the same ClockIdentity as the PHC
>> it drives. In above example DPLL channel 1 should have the same clock ID
>> as NIC1 PHC and channel 2 as NIC2 PHC.
>>
>> During the discussion, Andrew had the idea to provide NIC phandles
>> instead of clock ID values.
>>
>> Something like this:
>>
>> diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
>> b/Documenta
>> tion/devicetree/bindings/dpll/dpll-device.yaml
>> index fb8d7a9a3693f..159d9253bc8ae 100644
>> --- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
>> +++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
>> @@ -33,6 +33,13 @@ properties:
>>       items:
>>         enum: [pps, eec]
>>
>> +  ethernet-handles:
>> +    description:
>> +      List of phandles to Ethernet devices, one per DPLL instance. Each of
>> +      these handles identifies Ethernet device that uses particular DPLL
>> +      instance to synchronize its hardware clock.
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +
> 
> I personally would not use a list. I would have a node per channel,
> and within that node, have the ethernet-handle property. This gives
> you a more flexible scheme where you can easily add more per channel
> properties in the future.
> 
> It took us a while to understand what you actually wanted. The ASCII
> art helps. So i would include that and some text in the binding.

Like this?

diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml 
b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
index fb8d7a9a3693f..798c5484657cf 100644
--- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
+++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
@@ -27,11 +27,41 @@ properties:
    "#size-cells":
      const: 0

-  dpll-types:
-    description: List of DPLL channel types, one per DPLL instance.
-    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-    items:
-      enum: [pps, eec]
+  channels:
+    type: object
+    description: DPLL channels
+    unevaluatedProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^channel@[0-9a-f]+$":
+        type: object
+        description: DPLL channel
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            description: Hardware index of the DPLL channel
+            maxItems: 1
+
+          dpll-type:
+            description: DPLL channel type
+            $ref: /schemas/types.yaml#/definitions/string
+            enum: [pps, eec]
+
+          ethernet-handle:
+            description:
+              Specifies a reference to a node representing an Ethernet 
device
+              that uses this channel to synchronize its hardware clock.
+            $ref: /schemas/types.yaml#/definitions/phandle
+
+        required:
+          - reg

Thanks,
Ivan


