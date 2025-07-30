Return-Path: <netdev+bounces-211022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EDCB16369
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 17:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE9C1887B8B
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD5A2DC349;
	Wed, 30 Jul 2025 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bJljP8gm"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026AD481A3;
	Wed, 30 Jul 2025 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888339; cv=none; b=XGjAodczvuRcb325A8RrLclQDrtZYE1zQe3vTu4EkNrRWBZLZHGnzje5uy7lZ9ZBnkGzDjXlr+oV9MPhcJsbCwHId1TvQlbfy+nAganGcygLHRq5DPk58PMl/bAx9dktqpKNAkotcUHbZkYJPCsNWNPO6rRONPlD8BJcyLf4NPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888339; c=relaxed/simple;
	bh=GJragZO3FFVRHX0BsPd+cF+6aOPRGgevDm/AbN61+I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dsk6ybuKram1dPOdMKqJJZJpJYPkiQ/dwsbzWyBVqKwAZhPRG7akdG6Nul6G0MNHONt6wVUgbuuJj/UsrWfazX5g38wrGSrCJ/QYW2nxfDdMYmgTUUhSwdlgodUN2aHXNa5TtMyHnE7sDjQGd7ebqGQ0riSZERvNVke4plqxrwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bJljP8gm; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56UFBM8J2817587;
	Wed, 30 Jul 2025 10:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753888282;
	bh=E9tbG6pOqeu0Zfy681IAds4vdtxY0AX3TN2Fl6VFJfE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bJljP8gmVKHFqh/q7AXs0DrgXCd6yNPfVmHNgZI+aVTGZ/U6s0Wiok98qytEsaUAE
	 42V2Gz2qPrxt8jF3TW+JleGRlKrM2NeuXNSHf+MPMvs7KVQ/gl5jxUn+aUOsKUtJXt
	 3KA2ShAgj5TAa+v6CXPV7OJVJoTE4xUJZzwM9rQY=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56UFBMuI2004946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 30 Jul 2025 10:11:22 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 30
 Jul 2025 10:11:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 30 Jul 2025 10:11:21 -0500
Received: from [10.249.130.61] ([10.249.130.61])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56UFBEbb1131008;
	Wed, 30 Jul 2025 10:11:14 -0500
Message-ID: <fab2a856-e3b0-4d25-9ce4-72f1f57e3115@ti.com>
Date: Wed, 30 Jul 2025 20:41:13 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net: rpmsg-eth: Add basic rpmsg skeleton
To: Krzysztof Kozlowski <krzk@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Mengyuan Lou
	<mengyuanlou@net-swift.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan
 Srinivasan <maddy@linux.ibm.com>,
        Fan Gong <gongfan1@huawei.com>, Lee Trager
	<lee@trager.us>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Lukas Bulwahn <lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250723080322.3047826-1-danishanwar@ti.com>
 <20250723080322.3047826-3-danishanwar@ti.com>
 <296d6846-6a28-4e53-9e62-3439ac57d9c1@kernel.org>
 <5f4e1f99-ff71-443f-ba34-39396946e5b4@ti.com>
 <cabacd59-7cbf-403a-938f-371026980cc7@kernel.org>
 <66377d5d-b967-451f-99d9-8aea5f8875d3@ti.com>
 <bc30805a-d785-432f-be0f-97cea35abd51@kernel.org>
 <4bb1339a-ead6-4a33-b2bf-c55874bab352@ti.com>
 <0e85bda4-9ac2-4587-b8bb-550bea1728dc@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <0e85bda4-9ac2-4587-b8bb-550bea1728dc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 7/30/2025 11:43 AM, Krzysztof Kozlowski wrote:
> On 30/07/2025 08:01, MD Danish Anwar wrote:
>>>
>>>> `reserved-memory`. I am not creating a completely new undocumented node.
>>>> Instead I am creating a new node under reserved-memory as the shared
>>>> memory used by rpmsg-eth driver needs to be reserved first. This memory
>>>> is reserved by the ti_k3_r5_remoteproc driver by k3_reserved_mem_init().
>>>>
>>>> It's just that I am naming this node as "virtual-eth-shm@a0400000" and
>>>> then using the same name in driver to get the base_address and size
>>>> mentioned in this node.
>>>
>>> And how your driver will work with:
>>>
>>> s/virtual-eth-shm@a0400000/whatever@a0400000/
>>>
>>
>>
>> It won't. The driver imposes a restriction with the node name. The node
>> name should always be "virtual-eth-shm"
> 
> Drivers cannot impose the restriction. I don't think you understand the
> problem. What stops me from renaming the node? Nothing.
> 
> You keep explaining this broken code, but sorry, this is a no-go. Shall
> I NAK it to make it obvious?
> 

Krzysztof, I understand this can't be accepted. This wasn't my first
approach. The first approach was that the firmware running on the
remotecore will share the base-address using rpmsg. But that was
discouraged by Andrew.

So I came up with this DT approach to read the base-address from linux only.

Andrew, Since rpmsg-eth is a virtual device and we can't have DT node
for it. Using the reserved memory node and then search the same using
node name in the driver is also not acceptable as per Krzysztof. What do
you suggest should be done here?

Can we revisit the first approach (firmware sharing the address)? Can we
use module params to pass the base-address? or Do you have any other
ideas on how to handle this?

Please let me know.

> 
> Best regards,
> Krzysztof

-- 
Thanks and Regards,
Md Danish Anwar


