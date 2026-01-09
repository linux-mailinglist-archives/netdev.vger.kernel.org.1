Return-Path: <netdev+bounces-248523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0C8D0A97B
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 15:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F8163041AE0
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F3535E54C;
	Fri,  9 Jan 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dytI7xnH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3109F328B47
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968383; cv=none; b=AIFBMP2VN8MPwwEYJhzFGGxMpA3Na9qyG1jerZbECQqu3KOv0Qiu6GFOPYfAw3ssw58rMvjLdZA1AL9R/+7nQWQ4g3+WTbzCQdlXb+rtDVI8SAsWg1V9I4Q8ZoQENbpkDL2IzCP4jv0ExpSzxl7M9U+Gr1/xvyHVxDL47qwLqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968383; c=relaxed/simple;
	bh=WkKu2zRCrZeiRQHlrFcjimJCJ9ltl8LP5VCX9OqltC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7vwM+HoGQ98psNrBZIuCrLLvh1lE/0JMl7WR2ZGXGFK9Tn47UCUbcbipCV6zd68e0EZiXP5fMtDG4EL2syBCVNOO8WXqi4LJgimSmB60LsIy2upZlktn8bjNz5y3kPR4DdgahXYuo/eUkpil7mcgk+w7IxSM9HQxNTK2160FoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dytI7xnH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767968381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/6WGCpxh3iEXP0zVTdiymBjWOoqngiNJ6AVVfx3sNs=;
	b=dytI7xnH/wQHr94UzlCAZLdx/Hm2MBzb2copJlsWwIWERyNwP3kjlydDh8qc3YZndeId0j
	/jCFHR9IqU06wU4ylGgj/mfiEjiGM7xQhlX7XXzP/XVC4/ulXyEBYz7yNFXdm1TJ4SN9Aw
	j0YDUD+t+2ZhLR07n6yTiTC6gTIBkBw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-JKSJUgiINYezc9O3GZUFpg-1; Fri,
 09 Jan 2026 09:19:35 -0500
X-MC-Unique: JKSJUgiINYezc9O3GZUFpg-1
X-Mimecast-MFC-AGG-ID: JKSJUgiINYezc9O3GZUFpg_1767968371
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A172195608F;
	Fri,  9 Jan 2026 14:19:31 +0000 (UTC)
Received: from [10.44.33.222] (unknown [10.44.33.222])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80D741954196;
	Fri,  9 Jan 2026 14:19:23 +0000 (UTC)
Message-ID: <09ffc379-85e5-41ce-b781-66ba6bb9a6c7@redhat.com>
Date: Fri, 9 Jan 2026 15:19:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/12] dpll: Add helpers to find DPLL pin fwnode
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>
References: <20260108182318.20935-1-ivecera@redhat.com>
 <20260108182318.20935-4-ivecera@redhat.com>
 <20260109-cooperative-chinchilla-of-swiftness-aebbc8@quoll>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260109-cooperative-chinchilla-of-swiftness-aebbc8@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 1/9/26 10:55 AM, Krzysztof Kozlowski wrote:
> On Thu, Jan 08, 2026 at 07:23:09PM +0100, Ivan Vecera wrote:
>> Add helper functions to the DPLL core to retrieve a DPLL pin's firmware
>> node handle based on the "dpll-pins" and "dpll-pin-names" properties.
>>
>> * `fwnode_dpll_pin_node_get()`: matches the given name against the
>>    "dpll-pin-names" property to find the correct index, then retrieves
>>    the reference from "dpll-pins".
>> * `device_dpll_pin_node_get()`: a wrapper around the fwnode helper for
>>    convenience when using a `struct device`.
>>
>> These helpers simplify the process for consumer drivers (such as Ethernet
>> controllers or PHYs) to look up their associated DPLL pins defined in
>> the DT or ACPI, which can then be passed to the DPLL subsystem to acquire
>> the pin object.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   drivers/dpll/dpll_core.c | 20 ++++++++++++++++++++
>>   include/linux/dpll.h     | 15 +++++++++++++++
>>   2 files changed, 35 insertions(+)
>>
> 
> I don't see cells defined in your binding. Neither updated property.c.

And if the cells are not required? I mean that dpll-names only specifies
array of phandles without parameters...

e.g.
dpll-pin-names = "abc", "def";
dpll-pins = <&dpll_pin_abc>, <&dpll_pin_def>;

Should '#dpll-pin-cells' be defined as constantly equal to 0?

Thanks,
Ivan

> 
> Best regards,
> Krzysztof
> 


