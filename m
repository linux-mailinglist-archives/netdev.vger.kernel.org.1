Return-Path: <netdev+bounces-217617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C27DB394BC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688133A4EF5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 07:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1192D6418;
	Thu, 28 Aug 2025 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WRrEeBUO"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66882D0612;
	Thu, 28 Aug 2025 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364884; cv=none; b=ZVzPNkHx2ifxR/X8QaopFJ4oF/Z057cHXUVZauDE1Cxt5xzY6kScGuMxARRGhrkun3wwOmzO7kJyR2gSE487vLopZzLE9TaozXMVSva0Xdyxl+Jmdv28jIRUBLJO+HNAJacIP9xOZGAxmLAshcM2zWjAmBweI9eywn4Oiwba3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364884; c=relaxed/simple;
	bh=JrMEMAIN72PQSLuM09hZkye0UtP7yWfTIz0Vd16Rgc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IrUvcanBCtazAQN28oMg5328ucbmMZaaZqVOp2Yds2BtiJjrW5paJHrf3N4LNExMGU6+F//mL8Qc8ICZJVmL8F2aSYR/+Cx0lm2ha5qoKiDymsEaxekGmUTwKjpT1l8UNmflsokTY4I58vRlIioetiUd1pTO9wVwOFH773FT/NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WRrEeBUO; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57S77LrX1926333;
	Thu, 28 Aug 2025 02:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756364841;
	bh=4jNlY0U4kVd90go0mP1NgI2AJgnZ0N8e4hHUy/MOZEg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WRrEeBUOqqYzIYufYa2h80gdOjGilk4M/qXtYLRADYiK4KW8MhwJhICLJGRwnaC7R
	 lSQ4EcdKbABGa2vMs8xWNKa2HN+4JUhgZKJuGtBIxIAzAcgyoT9TXrY7SGemH2i8nh
	 CWkIRE1uIDUX4TaNR8dwUUqH/u7qKScWpZ9LQd0s=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57S77Ldh3049105
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 28 Aug 2025 02:07:21 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 02:07:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 02:07:20 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57S77Etn4120830;
	Thu, 28 Aug 2025 02:07:15 -0500
Message-ID: <dab8033d-e7d7-4522-b832-eaf58efaad68@ti.com>
Date: Thu, 28 Aug 2025 12:37:14 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net: rpmsg-eth: Add basic rpmsg skeleton
To: "Anwar, Md Danish" <a0501179@ti.com>,
        Krzysztof Kozlowski
	<krzk@kernel.org>,
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
 <fab2a856-e3b0-4d25-9ce4-72f1f57e3115@ti.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <fab2a856-e3b0-4d25-9ce4-72f1f57e3115@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof, Andrew,

On 30/07/25 8:41 pm, Anwar, Md Danish wrote:
> 
> 
> On 7/30/2025 11:43 AM, Krzysztof Kozlowski wrote:
>> On 30/07/2025 08:01, MD Danish Anwar wrote:
>>>>
>>>>> `reserved-memory`. I am not creating a completely new undocumented node.
>>>>> Instead I am creating a new node under reserved-memory as the shared
>>>>> memory used by rpmsg-eth driver needs to be reserved first. This memory
>>>>> is reserved by the ti_k3_r5_remoteproc driver by k3_reserved_mem_init().
>>>>>
>>>>> It's just that I am naming this node as "virtual-eth-shm@a0400000" and
>>>>> then using the same name in driver to get the base_address and size
>>>>> mentioned in this node.
>>>>
>>>> And how your driver will work with:
>>>>
>>>> s/virtual-eth-shm@a0400000/whatever@a0400000/
>>>>
>>>
>>>
>>> It won't. The driver imposes a restriction with the node name. The node
>>> name should always be "virtual-eth-shm"
>>
>> Drivers cannot impose the restriction. I don't think you understand the
>> problem. What stops me from renaming the node? Nothing.
>>
>> You keep explaining this broken code, but sorry, this is a no-go. Shall
>> I NAK it to make it obvious?
>>
> 
> Krzysztof, I understand this can't be accepted. This wasn't my first
> approach. The first approach was that the firmware running on the
> remotecore will share the base-address using rpmsg. But that was
> discouraged by Andrew.
> 
> So I came up with this DT approach to read the base-address from linux only.
> 
> Andrew, Since rpmsg-eth is a virtual device and we can't have DT node
> for it. Using the reserved memory node and then search the same using
> node name in the driver is also not acceptable as per Krzysztof. What do
> you suggest should be done here?
> 
> Can we revisit the first approach (firmware sharing the address)? Can we
> use module params to pass the base-address? or Do you have any other
> ideas on how to handle this?
> 
> Please let me know.
> 

This is what I came up with after few discussions offline with Andrew. I
will post v2 soon with the below changes

1. Similar to qcom,glink-edge.yaml and google,cros-ec.yaml - I will
create a new binding named ti,rpmsg-eth.yaml this binding will describe
the rpmsg eth node. This node will have a memory region.
2. The rpmsg-eth node will be a child node of the rproc device. In this
case `r5f@78000000`. I will modify the rproc binding
`ti,k3-r5f-rproc.yaml` to describe the same.
3. Other vendors who wish to use RPMSG_ETH, can create a rpmsg-eth node
as a child of their rproc device.

This approach is very similar to what's done by qcom,glink-edge.yaml
/google,cros-ec.yaml and their users.

-- 
Thanks and Regards,
Danish


