Return-Path: <netdev+bounces-248442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC22FD08852
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 700B9301670F
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DCF33508A;
	Fri,  9 Jan 2026 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmL0xntQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9233019BA
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954184; cv=none; b=loz2+eGPNT1izvoIx8NoJYEvouQUuXx/7GpU5gktefkrR0HCzzHhnMf9JM1TBh9CecVCkbAY2EeQmn6C7nVcWyJDv+HQ2adntAXo1phmTWmgdWImresslMcKOckEEdC1Wy6r4u7TO9KTw1qcmwq2NOZyW1iYAhsQv62Pu8KgkrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954184; c=relaxed/simple;
	bh=EEGmoGqBV9GfkkOjO9oHg2qhXiEtLKEgQ9u8EJUQbKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/X1zhz95WAW8NEa/Pfh6iMf5hrir/w0+MfWG0EF0xNpJ+iPBGqfvcmL9f3jU4vGoVMqzewdOcUEI2DOS+P7Q93pfF63EbfVvnyRp3N3Y7vGPUKqy6J/pKBt1OmL2Ay7u1mhcyULEknwUc+wGttwA5yLRUfmS9rSsAcD7HXqlew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MmL0xntQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767954181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgTuGSJqZ1fMkiPNSGvIy/EFwwr4d2ZCO17UacaOjNc=;
	b=MmL0xntQxP+yVUCOeILo5d1fS8Nish7I988+/Ve+QJrUaM1L9+V6Jsy7TbZhklaI29qMip
	7LhokfXdaevgKCIx6yZjm+sLFVcgbc4qUS6dG5pcqiRObpGMYFRd5GcHayerzcjyufswG0
	PoPN7gEF2IdLBuw4Tpq91xHEOsgj3Js=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-DfkO9NcCMtSPK9fQ5b93Rg-1; Fri,
 09 Jan 2026 05:23:00 -0500
X-MC-Unique: DfkO9NcCMtSPK9fQ5b93Rg-1
X-Mimecast-MFC-AGG-ID: DfkO9NcCMtSPK9fQ5b93Rg_1767954177
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51BC01956096;
	Fri,  9 Jan 2026 10:22:56 +0000 (UTC)
Received: from [10.44.32.135] (unknown [10.44.32.135])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 793241956048;
	Fri,  9 Jan 2026 10:22:48 +0000 (UTC)
Message-ID: <25f49485-2228-4aa5-9023-0b00cc10a4da@redhat.com>
Date: Fri, 9 Jan 2026 11:22:47 +0100
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
> 
WDYM by property.c ?

Thanks,
Ivan


