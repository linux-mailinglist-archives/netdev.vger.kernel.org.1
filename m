Return-Path: <netdev+bounces-219974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7DAB43F83
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA663A13DE
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CAE30CD86;
	Thu,  4 Sep 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWjSxTHZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563AC1EEA54
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997047; cv=none; b=FwXCnfUz8zYWV0JuYk5w1fJ3W5+2GnNw7b45/mqL0as0kVNOIH40jn8Ld0PPcWk4Tby5a/DskmkOy5jn3bouCjrsDDKVzC72uEIzcHWTks/246B8wF98iEGAkHCXEmfKfUjNkfx7IT88wM3CnoNRRrTPWbNwZdCHOLhjLg1fHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997047; c=relaxed/simple;
	bh=fJE2yF/PvWH3g7fdEOCUn49CqL0Rrtpc7KRDzBeXS9A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ab2SnE7W+3pbOXoWfBPj8zYJD1XL7QNtOWAndzn4anTCK4w/rhOm76VsL5fRLypz62A2GnL059hcNz2iCA+y6RNDqDixWrR0c88vbPBEvSazl8uhwVLjediY5SOCPcQ0Ua7CUYYkzA36Ek58oEMJ3QZBBOXg+azVhdgl6FMPOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWjSxTHZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756997045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FsChnjzIB7Kv9twtI1vDkbPW57rkIUWsti3YFoQlUs=;
	b=VWjSxTHZ0T4wujPLfXMiV/XsVV+6ULiPqtxPrSiulq0y5lMmEAZ9q41wF2M+tWY/C+Ld9B
	9cWfGpnQS57lnOzwQvKSj9+uQNUL/NxGkgkvVA40gGsyFObKd56UTqk/hDlrMxqcMBePVI
	P0q1SLekmMCJOXUqY8NhVzOU7t6A4Q4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-oiJcdi-4NV6kWH0YGfplcA-1; Thu,
 04 Sep 2025 10:44:00 -0400
X-MC-Unique: oiJcdi-4NV6kWH0YGfplcA-1
X-Mimecast-MFC-AGG-ID: oiJcdi-4NV6kWH0YGfplcA_1756997038
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AA571800366;
	Thu,  4 Sep 2025 14:43:57 +0000 (UTC)
Received: from [10.45.224.74] (unknown [10.45.224.74])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91B2E19560B8;
	Thu,  4 Sep 2025 14:43:53 +0000 (UTC)
Message-ID: <906137ef-822d-4178-b80d-d332ab1046dc@redhat.com>
Date: Thu, 4 Sep 2025 16:43:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] dt-bindings: dpll: Add per-channel Ethernet
 reference property
From: Ivan Vecera <ivecera@redhat.com>
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
 <5e38e1b7-9589-49a9-8f26-3b186f54c7d5@redhat.com>
Content-Language: en-US
In-Reply-To: <5e38e1b7-9589-49a9-8f26-3b186f54c7d5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Rob,

any comment to my second proposal (below)?

Thank you,
Ivan

On 29. 08. 25 3:29 odp., Ivan Vecera wrote:
>> Seems a bit odd to me that the ethernet controller doesn't have a link
>> to this node instead.
> 
> Do you mean to add a property (e.g. dpll-channel or dpll-device) into
> net/network-class.yaml ? If so, yes, it would be possible, and the way
> I look at it now, it would probably be better. The DPLL driver can
> enumerate all devices across the system that has this specific property
> and check its value.
> 
> See the proposal below...
> 
> Thanks,
> Ivan
> 
> ---
>   Documentation/devicetree/bindings/dpll/dpll-device.yaml  | 6 ++++++
>   Documentation/devicetree/bindings/net/network-class.yaml | 7 +++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/ 
> Documentation/devicetree/bindings/dpll/dpll-device.yaml
> index fb8d7a9a3693f..560351df1bec3 100644
> --- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> +++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> @@ -27,6 +27,12 @@ properties:
>     "#size-cells":
>       const: 0
> 
> +  "#dpll-cells":
> +    description: |
> +      Number of cells in a dpll specifier. The cell specifies the index
> +      of the channel within the DPLL device.
> +    const: 1
> +
>     dpll-types:
>       description: List of DPLL channel types, one per DPLL instance.
>       $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> diff --git a/Documentation/devicetree/bindings/net/network-class.yaml b/ 
> Documentation/devicetree/bindings/net/network-class.yaml
> index 06461fb92eb84..144badb3b7ff1 100644
> --- a/Documentation/devicetree/bindings/net/network-class.yaml
> +++ b/Documentation/devicetree/bindings/net/network-class.yaml
> @@ -17,6 +17,13 @@ properties:
>       default: 48
>       const: 48
> 
> +  dpll:
> +    description:
> +      Specifies DPLL device phandle and index of the DPLL channel within
> +      this device used by this network device to synchronize its hardware
> +      clock.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
>     local-mac-address:
>       description:
>         Specifies MAC address that was assigned to the network device 
> described by


