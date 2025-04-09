Return-Path: <netdev+bounces-180619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69795A81E2C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551CA4C0D3D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A9225A2A9;
	Wed,  9 Apr 2025 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8UzEu5F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4E255E40
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183351; cv=none; b=W35hnOkcnmNUFCaGDKnGOctdoR3WB2Lg4xBYJ3CFz1mN6IPyuh03jQ9M8L2CQJ7TQA8iWpo2VGIejlQ/2vY9pjwntVfbEdpydE8tlzHQHScXBFaAXfSHvjiDjZs+TVa8G9Z4WIPc7aYfGw1Cf6JZ06fe3YSnP+whLsdpMsoRmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183351; c=relaxed/simple;
	bh=vFjOIR2qT2cophmsAoVj/+t8mSZ2UXuTRoZalL9q4BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVz0DdjvaY2a13Zl6NalBVo9ZZJK4QAvX7viZotiEfis/tbs5dZjVKG2cNN+4f1ZQiGs/sHboJX4ZdBZZDEF4TKEvf6XcYiSGjM5GqzHkbNQeYF3bLyLQusVvk+q6TJ+FyCNJ0wLec29uzubiLZ5ieuMOMbs5fv0QN+HeugIdyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8UzEu5F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744183348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/J94JhSC/N/eXUEN95Nr6eGuIYakV3vxEh4pWaWBJD0=;
	b=W8UzEu5FvrQRsd+CwwPBZY99LgjDzUSPGB8276GBcFwgoRjkuhM1QTpbqIikAaqigOXVCo
	uZ0FdfFQjJu3RHzYUpI8wtTugY3wGmluEEF2FCYLrmqld/mVwH/YIaopuwQQJVYlr8z1t6
	fljhDAhi93qamsB/oTel0spdJ+Crhi4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-WdO_gmLoOBuEuU6Tf9pb-Q-1; Wed,
 09 Apr 2025 03:22:25 -0400
X-MC-Unique: WdO_gmLoOBuEuU6Tf9pb-Q-1
X-Mimecast-MFC-AGG-ID: WdO_gmLoOBuEuU6Tf9pb-Q_1744183343
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81B9C1955DC5;
	Wed,  9 Apr 2025 07:22:22 +0000 (UTC)
Received: from [10.44.32.72] (unknown [10.44.32.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 139671955DCE;
	Wed,  9 Apr 2025 07:22:17 +0000 (UTC)
Message-ID: <82a605e1-2f0a-4466-966e-061101613158@redhat.com>
Date: Wed, 9 Apr 2025 09:22:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/28] dpll: zl3073x: Read optional pin properties from
 firmware
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
 <20250407173149.1010216-9-ivecera@redhat.com>
 <09e09598-945b-4f26-a5f4-9f1a17a709c4@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <09e09598-945b-4f26-a5f4-9f1a17a709c4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 07. 04. 25 8:06 odp., Krzysztof Kozlowski wrote:
> On 07/04/2025 19:31, Ivan Vecera wrote:
>> +
>> +	if (zl3073x_dpll_is_input_pin(pin))
>> +		node_name = "input-pins";
>> +	else
>> +		node_name = "output-pins";
>> +
>> +	/* Get node containing input or output pins */
>> +	pins_node = device_get_named_child_node(zldpll->mfd->dev, node_name);
>> +	if (!pins_node) {
>> +		dev_dbg(zldpll->mfd->dev, "'%s' sub-node is missing\n",
>> +			node_name);
>> +		return NULL;
>> +	}
>> +
>> +	/* Get pin HW index */
>> +	idx = zl3073x_dpll_pin_index_get(pin);
>> +
>> +	/* Enumerate pin nodes and find the requested one */
>> +	fwnode_for_each_child_node(pins_node, pin_node) {
>> +		u32 reg;
>> +
>> +		if (fwnode_property_read_u32(pin_node, "reg", &reg))
>> +			continue;
>> +
>> +		if (idx == reg)
>> +			break;
> 
> Where do you drop the reference to pin_node?

The pin_node is a return value of this function. It is stored into 
pin_info->fwnode (in zl3073x_dpll_pin_info_get()) and later the 
reference is dropped by zl3073x_dpll_pin_info_put().

>> +	}
>> +
>> +	/* Release pin parent node */
>> +	fwnode_handle_put(pins_node);
>> +
> 
> 
> 
> Best regards,
> Krzysztof
> 


