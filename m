Return-Path: <netdev+bounces-248441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6212D088D6
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AB643015160
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DE933436A;
	Fri,  9 Jan 2026 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqZLqamQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB223BF9F
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954140; cv=none; b=tYi4wvcF78TDz6WvrHog7g4lO1iATaMTI2kU1YM7KIXs+g7mQ9ZZ2kw97jODz9xo0Tb3KeyQNZFbHaKP4QfHXqPKsXhq/gHoIgSXLlVaMxlxaD87jheXBot+kUVKqFSd289AFvD9LX9iOepqzcnRmG8rB+WoY1LGWIGkevk01KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954140; c=relaxed/simple;
	bh=P+Qapu7PTQqd6vj/HqMKsi+M3yYPpVMrQovpFpc59xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HayBXTBVPDT4oHI+4svglNEPWp40YNZArDJimLRIH2sZN7aVEidm6bj+lf1rFhf15Wh2qCZobjqe1jXtIwOfJS8AKJHco5sMq/WRWRFA8TcAzT+fcm2o2PFtaO8WnsAtEs0fwyvOU7WuFv2tYc4+UXo39+fDwYmPeQR3U6ad1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqZLqamQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767954137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1X6VjjSDBSXJE0ymL3SGMh0l4uxNAcGGXw1ekS2+I5g=;
	b=gqZLqamQKtyDr9qhDKTE/XZfT6w37JhUM6sNppcGT6HQNGVKEw421uoOAj4oltzDfkkFYW
	jSj35vQjyxf8d8/OglKyKWk+PoIY/Sqj/1zibLPPK5nRryUxTNdXCdVVMBBruvl3nucxGi
	sgCNyd7h+q+0m1DS3R1qI9YUAf6t4Dg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-ChZLRiv_Nwe1xlCYcTvuzw-1; Fri,
 09 Jan 2026 05:22:16 -0500
X-MC-Unique: ChZLRiv_Nwe1xlCYcTvuzw-1
X-Mimecast-MFC-AGG-ID: ChZLRiv_Nwe1xlCYcTvuzw_1767954133
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94F33180035D;
	Fri,  9 Jan 2026 10:22:12 +0000 (UTC)
Received: from [10.44.32.135] (unknown [10.44.32.135])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13FC61800994;
	Fri,  9 Jan 2026 10:22:04 +0000 (UTC)
Message-ID: <a581a86d-d49c-4761-bd68-989a7a12cb56@redhat.com>
Date: Fri, 9 Jan 2026 11:22:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next 01/12] dt-bindings: dpll: add
 common dpll-pin-consumer schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Rob Herring <robh@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-rdma@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Richard Cochran <richardcochran@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Mark Bloch <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>
References: <20260108182318.20935-1-ivecera@redhat.com>
 <20260108182318.20935-2-ivecera@redhat.com>
 <20260109-wonderful-acoustic-civet-e030da@quoll>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260109-wonderful-acoustic-civet-e030da@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 1/9/26 10:48 AM, Krzysztof Kozlowski wrote:
> On Thu, Jan 08, 2026 at 07:23:07PM +0100, Ivan Vecera wrote:
>> Introduce a common schema for DPLL pin consumers. Devices such as Ethernet
>> controllers and PHYs may require connections to DPLL pins for Synchronous
>> Ethernet (SyncE) or other frequency synchronization tasks.
>>
>> Defining these properties in a shared schema ensures consistency across
>> different device types that consume DPLL resources.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   .../bindings/dpll/dpll-pin-consumer.yaml      | 30 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 31 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
>> new file mode 100644
>> index 0000000000000..60c184c18318a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
>> @@ -0,0 +1,30 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dpll/dpll-pin-consumer.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: DPLL Pin Consumer
>> +
>> +maintainers:
>> +  - Ivan Vecera <ivecera@redhat.com>
>> +
> 
> You miss select. Without it this binding is no-op.

Will fix.

>> +description: |
> 
> Drop |

Will do.

>> +  Common properties for devices that require connection to DPLL (Digital Phase
>> +  Locked Loop) pins for frequency synchronization (e.g. SyncE).
>> +
>> +properties:
>> +  dpll-pins:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      List of phandles to the DPLL pin nodes connected to this device.
>> +
>> +  dpll-pin-names:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    description:
>> +      Names for the DPLL pins defined in 'dpll-pins', in the same order.
>> +
>> +dependencies:
>> +  dpll-pin-names: [ dpll-pins ]
> 
> Binding should go to dtschema. See also commit
> 3282a891060aace02e3eed4789739768060cea32 in dtschema or other examples
> how to add new provider/consumer properties.

Will do.

Thanks for advice...

Ivan


