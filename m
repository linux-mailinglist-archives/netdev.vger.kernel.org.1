Return-Path: <netdev+bounces-210929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BC9B158B0
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 08:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1907018A13A7
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 06:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6FD1C3BEB;
	Wed, 30 Jul 2025 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fn8j7j9U"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576FE3FE5;
	Wed, 30 Jul 2025 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753855372; cv=none; b=IC9IzLPjaWf0N9kbZ98lHpmAm5Wy3X1NGpfoCQX0NfcJSuAfkmQMjQO5e4BGOm+91b1BzxHgAm4G/CE38QTj/raSpP1g69IlcQNswGbD10Fqqpj2p3CyxrZ6JWblFUWls2XOhWDqWMm+V6xiCYvrlT5zbqDfEyuVRUzzzueG3k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753855372; c=relaxed/simple;
	bh=DxepambSAOX+kPs8ImIDzuWYncFHnfiMA2R2VSN9CFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QDAG2vCEjXs6rEIvSRbRyEQpMGCUdF2TqnJyU8tcr+QNfu4tFBCprWoUWYYj3YYMqKERbttvYAbn6YMD2wme8VusmYybEBb869jl9YgvIca5xXP+/1IsIUFOCx90vX+qfu7U9BFBKw2Edc0O5O1AkGusrFTDToEuDCqztPxU2KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fn8j7j9U; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56U61ATI2722417;
	Wed, 30 Jul 2025 01:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753855270;
	bh=vr8DybXmLcAu87vsb97/V8r9IlfiHzpkQmRfXo3i8/Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=fn8j7j9U5Z3LeGhv7Wv1Ol2KSpCsHBMZDdaYwvqYioKSbAvMBLkk0QQ/hHJmmsOub
	 XJ/2Mp3T1MO9CRwNl08wMhl3h6xu+hWDe27YZ/Yx1QLZJhYAjrmKErfeFSoqHoDNYB
	 oEJMDySCVGY0fuVP3c3+xpYuCz3pVVn8MAH5YO5Y=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56U61AwF3281038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 30 Jul 2025 01:01:10 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 30
 Jul 2025 01:01:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 30 Jul 2025 01:01:09 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56U613Jv759858;
	Wed, 30 Jul 2025 01:01:04 -0500
Message-ID: <4bb1339a-ead6-4a33-b2bf-c55874bab352@ti.com>
Date: Wed, 30 Jul 2025 11:31:03 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net: rpmsg-eth: Add basic rpmsg skeleton
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Michael
 Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Fan
 Gong <gongfan1@huawei.com>, Lee Trager <lee@trager.us>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lukas
 Bulwahn <lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250723080322.3047826-1-danishanwar@ti.com>
 <20250723080322.3047826-3-danishanwar@ti.com>
 <296d6846-6a28-4e53-9e62-3439ac57d9c1@kernel.org>
 <5f4e1f99-ff71-443f-ba34-39396946e5b4@ti.com>
 <cabacd59-7cbf-403a-938f-371026980cc7@kernel.org>
 <66377d5d-b967-451f-99d9-8aea5f8875d3@ti.com>
 <bc30805a-d785-432f-be0f-97cea35abd51@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <bc30805a-d785-432f-be0f-97cea35abd51@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 29/07/25 6:02 pm, Krzysztof Kozlowski wrote:
> On 29/07/2025 11:46, MD Danish Anwar wrote:
>>>>
>>>> One idea I had was to create a new binding for this node, and use
>>>> compatible string to access the node in driver. But the device is
>>>> virtual and not physical so I thought that might not be the way to go so
>>>> I went with the current approach.
>>>
>>> virtual devices do not go to DTS anyway. How do you imagine this works?
>>> You add it to DTS but you do not add bindings and you expect checks to
>>> succeed?
>>>
>>> Provide details how you checked your DTS compliance.
>>>
>>>
>>
>> This is my device tree patch [1]. I ran these two commands before and
>> after applying the patch and checked the diff.
>>
>> 	make dt_binding_check
>> 	make dtbs_check
>>
>> I didn't see any new error / warning getting introduced due to the patch
>>
>> After applying the patch I also ran,
>>
>> 	make CHECK_DTBS=y ti/k3-am642-evm.dtb
>>
>> I still don't see any warnings / error.
>>
>>
>> If you look at the DT patch, you'll see I am adding a new node in the
> 
> I see. This is so odd syntax... You have the phandle there, so you do
> not need to do any node name checking. I did not really expect you will
> be checking node name for reserved memory!!!
> 

I don't have access to the phandle in my function. The reserved memory
is reserved by ti_k3_r5_remoteproc driver. That driver has the phandle.

I am writing a new driver rpmsg_eth, this driver only has the rpdev
structure. This driver doesn't have any dt node or phandle and because
of this I am doing `peer = of_find_node_by_name(NULL,
"virtual-eth-shm");` to get the access to this node here.

I couldn't find any way to access the dt node of reserved memory from
this (rpmsg_eth) driver. Please let me know if there is any way I can
access that.

> Obviously this will be fine with dt bindings, because such ABI should
> never be constructed.
> 
> 
>> `reserved-memory`. I am not creating a completely new undocumented node.
>> Instead I am creating a new node under reserved-memory as the shared
>> memory used by rpmsg-eth driver needs to be reserved first. This memory
>> is reserved by the ti_k3_r5_remoteproc driver by k3_reserved_mem_init().
>>
>> It's just that I am naming this node as "virtual-eth-shm@a0400000" and
>> then using the same name in driver to get the base_address and size
>> mentioned in this node.
> 
> And how your driver will work with:
> 
> s/virtual-eth-shm@a0400000/whatever@a0400000/
> 


It won't. The driver imposes a restriction with the node name. The node
name should always be "virtual-eth-shm"

For other vendors who want to use this driver, they need to reserve
memory for their shared block and name the node `virtual-eth-shm@XXXXXXXX`

> ? It will not.
> 
> Best regards,
> Krzysztof

-- 
Thanks and Regards,
Danish


