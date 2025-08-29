Return-Path: <netdev+bounces-218289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F728B3BC85
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F4D3B4327
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6230431A57B;
	Fri, 29 Aug 2025 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKv9Q4ft"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47772F069C
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756474171; cv=none; b=FWeDRDu7apltSwSsNflaihYEfoYsu6+4UWnq0X+ByCBvX0ByVBH12dw6WXLwGwLvdnE3J8IGMuMpIx+Em9doKKiYGcYYz87aDpX51Z95T/A3aSvBSc8ekncWcsBkz+BEitwh3mc4Mknx31FjhiNiGOm35p1IudGtJZ+cst2gGu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756474171; c=relaxed/simple;
	bh=knOkve9KJ6aDZa9cI8V8ayiO/Btg8paML35UfEGiBTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bi6tdh2uUK+2FhVNhnBlu4fU1IM/0lOQOiZmjPMUMCY7a+J6jJIPXUspiDplCqwld0orDqyKih05VxOHNOZaearwvpgNu+jvvA+0yIntepB3VWKcqUYQmFLx+gZ19i9r4OxZ9RzSFOrEQWevvqKG8TFhRZO7enyYeYRlipmqynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKv9Q4ft; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756474168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5xCVHj/t6FV37rBGnYXOrcnRWfi0Bqvu58jEXvy/kk=;
	b=AKv9Q4fti/MxQ/3w7FfoZZey/vc2cxaxgdF/UfDncNZZ54IBtXcQBBUHewD2DuMXSgDiDa
	aRHC/0A99Lqp8fPhAjErsgv5F6ke0qPFBPmpym+TT08SW6j+TBJ23v2hx4R7k09eeEipBg
	nCbmYaFLc/IZ6aOjmQpjoveM2pLTkUg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-bwUiLHz3NvykS1iWwDEgDg-1; Fri,
 29 Aug 2025 09:29:23 -0400
X-MC-Unique: bwUiLHz3NvykS1iWwDEgDg-1
X-Mimecast-MFC-AGG-ID: bwUiLHz3NvykS1iWwDEgDg_1756474161
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CCA11956089;
	Fri, 29 Aug 2025 13:29:21 +0000 (UTC)
Received: from [10.45.224.190] (unknown [10.45.224.190])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02E7C19560B4;
	Fri, 29 Aug 2025 13:29:16 +0000 (UTC)
Message-ID: <5e38e1b7-9589-49a9-8f26-3b186f54c7d5@redhat.com>
Date: Fri, 29 Aug 2025 15:29:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] dt-bindings: dpll: Add per-channel Ethernet
 reference property
To: Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, mschmidt@redhat.com, poros@redhat.com,
 Andrew Lunn <andrew@lunn.ch>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250815144736.1438060-1-ivecera@redhat.com>
 <20250820211350.GA1072343-robh@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250820211350.GA1072343-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Rob,

On 20. 08. 25 11:13 odp., Rob Herring wrote:
> On Fri, Aug 15, 2025 at 04:47:35PM +0200, Ivan Vecera wrote:
>> In case of SyncE scenario a DPLL channels generates a clean frequency
>> synchronous Ethernet clock (SyncE) and feeds it into the NIC transmit
>> path. The DPLL channel can be locked either to the recovered clock
>> from the NIC's PHY (Loop timing scenario) or to some external signal
>> source (e.g. GNSS) (Externally timed scenario).
>>
>> The example shows both situations. NIC1 recovers the input SyncE signal
>> that is used as an input reference for DPLL channel 1. The channel locks
>> to this signal, filters jitter/wander and provides holdover. On output
>> the channel feeds a stable, phase-aligned clock back into the NIC1.
>> In the 2nd case the DPLL channel 2 locks to a master clock from GNSS and
>> feeds a clean SyncE signal into the NIC2.
>>
>> 		   +-----------+
>> 		+--|   NIC 1   |<-+
>> 		|  +-----------+  |
>> 		|                 |
>> 		| RxCLK     TxCLK |
>> 		|                 |
>> 		|  +-----------+  |
>> 		+->| channel 1 |--+
>> +------+	   |-- DPLL ---|
>> | GNSS |---------->| channel 2 |--+
>> +------+  RefCLK   +-----------+  |
>> 				  |
>> 			    TxCLK |
>> 				  |
>> 		   +-----------+  |
>> 		   |   NIC 2   |<-+
>> 		   +-----------+
>>
>> In the situations above the DPLL channels should be registered into
>> the DPLL sub-system with the same Clock Identity as PHCs present
>> in the NICs (for the example above DPLL channel 1 uses the same
>> Clock ID as NIC1's PHC and the channel 2 as NIC2's PHC).
>>
>> Because a NIC PHC's Clock ID is derived from the NIC's MAC address,
>> add a per-channel property 'ethernet-handle' that specifies a reference
>> to a node representing an Ethernet device that uses this channel
>> to synchronize its hardware clock. Additionally convert existing
>> 'dpll-types' list property to 'dpll-type' per-channel property.
>>
>> Suggested-by: Andrew Lunn <andrew@lunn.ch>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   .../devicetree/bindings/dpll/dpll-device.yaml | 40 ++++++++++++++++---
>>   .../bindings/dpll/microchip,zl30731.yaml      | 29 +++++++++++++-
>>   2 files changed, 62 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
>> index fb8d7a9a3693f..798c5484657cf 100644
>> --- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
>> +++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
>> @@ -27,11 +27,41 @@ properties:
>>     "#size-cells":
>>       const: 0
>>   
>> -  dpll-types:
>> -    description: List of DPLL channel types, one per DPLL instance.
>> -    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> -    items:
>> -      enum: [pps, eec]
> 
> Dropping this is an ABI change. You can't do that unless you are
> confident there are no users both in existing DTs and OSs.

Get it, will keep.

>> +  channels:
>> +    type: object
>> +    description: DPLL channels
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      "#address-cells":
>> +        const: 1
>> +      "#size-cells":
>> +        const: 0
>> +
>> +    patternProperties:
>> +      "^channel@[0-9a-f]+$":
>> +        type: object
>> +        description: DPLL channel
>> +        unevaluatedProperties: false
>> +
>> +        properties:
>> +          reg:
>> +            description: Hardware index of the DPLL channel
>> +            maxItems: 1
>> +
>> +          dpll-type:
>> +            description: DPLL channel type
>> +            $ref: /schemas/types.yaml#/definitions/string
>> +            enum: [pps, eec]
>> +
>> +          ethernet-handle:
>> +            description:
>> +              Specifies a reference to a node representing an Ethernet device
>> +              that uses this channel to synchronize its hardware clock.
>> +            $ref: /schemas/types.yaml#/definitions/phandle
> 
> Seems a bit odd to me that the ethernet controller doesn't have a link
> to this node instead.

Do you mean to add a property (e.g. dpll-channel or dpll-device) into
net/network-class.yaml ? If so, yes, it would be possible, and the way
I look at it now, it would probably be better. The DPLL driver can
enumerate all devices across the system that has this specific property
and check its value.

See the proposal below...

Thanks,
Ivan

---
  Documentation/devicetree/bindings/dpll/dpll-device.yaml  | 6 ++++++
  Documentation/devicetree/bindings/net/network-class.yaml | 7 +++++++
  2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml 
b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
index fb8d7a9a3693f..560351df1bec3 100644
--- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
+++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
@@ -27,6 +27,12 @@ properties:
    "#size-cells":
      const: 0

+  "#dpll-cells":
+    description: |
+      Number of cells in a dpll specifier. The cell specifies the index
+      of the channel within the DPLL device.
+    const: 1
+
    dpll-types:
      description: List of DPLL channel types, one per DPLL instance.
      $ref: /schemas/types.yaml#/definitions/non-unique-string-array
diff --git a/Documentation/devicetree/bindings/net/network-class.yaml 
b/Documentation/devicetree/bindings/net/network-class.yaml
index 06461fb92eb84..144badb3b7ff1 100644
--- a/Documentation/devicetree/bindings/net/network-class.yaml
+++ b/Documentation/devicetree/bindings/net/network-class.yaml
@@ -17,6 +17,13 @@ properties:
      default: 48
      const: 48

+  dpll:
+    description:
+      Specifies DPLL device phandle and index of the DPLL channel within
+      this device used by this network device to synchronize its hardware
+      clock.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
    local-mac-address:
      description:
        Specifies MAC address that was assigned to the network device 
described by


