Return-Path: <netdev+bounces-249104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD115D142BB
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BC2430A0F65
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67A436B079;
	Mon, 12 Jan 2026 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4i9/fvA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081ED3624C2
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236513; cv=none; b=Y0O8d1wO+PYxjnZwrfNugosVxuld8cQcW72w+3uRONH9gD7rHPpqZz/eKyz0O9nradxKuo0kesMOUcuYBM8SseYIcw7iVx8ifuAgifeUzkBa9ZzoUV6JV3yhW2ViWhsE5/TK73cZRQ0qlm5FMrerOltoFz9T1j14XTWEwyNytBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236513; c=relaxed/simple;
	bh=8WSwIkL6KauRhPvMljERR7kijZjxW8zO8xX/APi5K+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krEyYPNZAGQ5sRowV6YsHfpjQP2a3mmGPCYVmgql8oWs4OJB5gO/2xsrh/KVSx2RW7/xVbrwt34g3OzypycDg3PClWSHL9I1B1ffnKBFfN1JnJchCgWXHrn+xjjafyHFkJj+itSF05DJjZulpxZbuK8oWobKM7JwJ4iwILtpdO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4i9/fvA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768236510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vC7wn/ye/uBT+aaDl9k3CfBScfwjYeWCooqpfDEE+H8=;
	b=Q4i9/fvA+2Zu3rged2OWX1/bd1b+ZzyAJ381Wig4H3Q/K9bvqKIOE4vKaN9zBNGPGblYkN
	xLKABTBUVtpClaImrkM3FacXdiXuauxAxJfH52BLrpYDX5lFkpGKYjHlYcZb0CtR13QBxX
	DolEIG+wyqfNsbRADYhMaN9OU4Nbgb8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-iIPE60pcPUWT1sIRma0cng-1; Mon,
 12 Jan 2026 11:48:26 -0500
X-MC-Unique: iIPE60pcPUWT1sIRma0cng-1
X-Mimecast-MFC-AGG-ID: iIPE60pcPUWT1sIRma0cng_1768236503
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D479B1800359;
	Mon, 12 Jan 2026 16:48:22 +0000 (UTC)
Received: from [10.44.34.128] (unknown [10.44.34.128])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DF6A19560B2;
	Mon, 12 Jan 2026 16:48:15 +0000 (UTC)
Message-ID: <bee863d4-81a4-421c-b57e-b27843ca308b@redhat.com>
Date: Mon, 12 Jan 2026 17:48:14 +0100
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
 <a581a86d-d49c-4761-bd68-989a7a12cb56@redhat.com>
 <fd07e1f8-455c-464f-9760-9d16d450a7d5@redhat.com>
 <cbf482be-4aa8-488f-9f78-181f8f145c28@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <cbf482be-4aa8-488f-9f78-181f8f145c28@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On 1/12/26 5:14 PM, Krzysztof Kozlowski wrote:
> On 09/01/2026 15:11, Ivan Vecera wrote:
>>>>> +  Common properties for devices that require connection to DPLL
>>>>> (Digital Phase
>>>>> +  Locked Loop) pins for frequency synchronization (e.g. SyncE).
>>>>> +
>>>>> +properties:
>>>>> +  dpll-pins:
>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>> +    description:
>>>>> +      List of phandles to the DPLL pin nodes connected to this device.
>>>>> +
>>>>> +  dpll-pin-names:
>>>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>>>> +    description:
>>>>> +      Names for the DPLL pins defined in 'dpll-pins', in the same
>>>>> order.
>>>>> +
>>>>> +dependencies:
>>>>> +  dpll-pin-names: [ dpll-pins ]
>>>>
>>>> Binding should go to dtschema. See also commit
>>>> 3282a891060aace02e3eed4789739768060cea32 in dtschema or other examples
>>>> how to add new provider/consumer properties.
>>
>> Quick questions... if the dpll pin consumer properties schema should go
>> to dtschema...
>>
>> 1) Should I remove this patch from this series? So this schema won't be
>>      a part of kernel
> 
> Yes.

OK, will remove this patch from the series and create PR against
dtschema and ...

>> 2) dtschema does not contain dpll-device and dpll-pin schemas now, I
> 
> The provider, so the #foo-cells should be in dtschema as well.

... include dpll.yaml and dpll-pin.yaml as well.

>>      expect they should be added as well... or? I'm asking because there
>>      is also e.g. hwlock-consumer.yaml in dtschema but no hwlock
> 
> hwlock-cells are missing, probably due to licensing.

and I will also include '#dpll-pin-cells', as we cannot theoretically
rule out its usage in the future.

Thanks,
Ivan


