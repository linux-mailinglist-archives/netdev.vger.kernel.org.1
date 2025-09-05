Return-Path: <netdev+bounces-220276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C57BB45243
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD31A5A1E69
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D938D3054C7;
	Fri,  5 Sep 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L65rLMzo"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A367C3043D1;
	Fri,  5 Sep 2025 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062683; cv=none; b=jhHeXY6EESvxofwfni2qaz8cN/7Bj+BVmQbi85rb+Vd+I9m7KvEtHwgEPX1kAV8ydSGyNhlHeM+4eXvNxabzzZldato5YqPRgIms0PocJFRIO/Tqb7cDv+JwTqRYmP3IBrMQgvn3HIG310VCD5bmzR9xA/6F3bycg92g3q9IE2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062683; c=relaxed/simple;
	bh=cMojpqJ27h2eTF7V8dVIvJWdJkl9UMHceULvamZ/QVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oO1N9Aka51+audDYtb8Xs3n4UbC6b5u3wBCaMCDAaJkB9veerqtv7YFSaQoJZ+lo/SmEdayl3F5AzjnInArQSSmwL0sFMBoD8CbEGAlDzBC+pGvpqC7LQsIR0c+xDiIKdWfA6CNShWcueyFHBpAuUqsnbjNzOygF74nOTCizNPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L65rLMzo; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5858v61n3285442;
	Fri, 5 Sep 2025 03:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757062626;
	bh=kSrPRCtXJQEhqr1BuGJ8W84oGetUB7hhLQoAxDn9OAw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=L65rLMzogaTqWulEtRUm5v8L8NOgoTpdl2VCs2AYrRKilQ72FPlbbS3GQIILuT79Y
	 +HhowBCxGclATIIb9zEmJzwbs4cL2wRCCANm+r1OxHHSE0YlUSiFdVsxieBdIpN/ND
	 O2BGuMl/W6VM0yVHTMS7DjnOidnPad+rtM6mWf88=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5858v6k2251546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 03:57:06 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 03:57:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 03:57:06 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5858uuZp196351;
	Fri, 5 Sep 2025 03:56:57 -0500
Message-ID: <ebcf48cb-a988-423c-b6bb-9bdee75dcdae@ti.com>
Date: Fri, 5 Sep 2025 14:26:55 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/8] dt-bindings: remoteproc: k3-r5f: Add
 rpmsg-eth subnode
To: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        "Anwar, Md Danish" <a0501179@ti.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu
 Poirier <mathieu.poirier@linaro.org>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Xin
 Guo <guoxin09@huawei.com>, Lei Wei <quic_leiwei@quicinc.com>,
        Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>,
        Fan Gong
	<gongfan1@huawei.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Geert
 Uytterhoeven <geert+renesas@glider.be>,
        Lukas Bulwahn
	<lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        Suman Anna <s-anna@ti.com>, Tero
 Kristo <kristo@kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Roger Quadros
	<rogerq@kernel.org>
References: <20250902090746.3221225-1-danishanwar@ti.com>
 <20250902090746.3221225-3-danishanwar@ti.com>
 <20250903-peculiar-hot-monkey-4e7c36@kuoka>
 <d994594f-7055-47c8-842f-938cf862ffb0@ti.com>
 <f2550076-57b5-46f2-a90a-414e5f2cb8d7@kernel.org>
 <38c054a3-1835-4f91-9f89-fbe90ddba4a9@ti.com>
 <6e56f36f-70fd-4635-b83f-a221780237ba@lunn.ch>
 <9c2a863c-0c8a-4563-a58d-d59112ac45a8@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <9c2a863c-0c8a-4563-a58d-d59112ac45a8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 03/09/25 7:53 pm, Krzysztof Kozlowski wrote:
> On 03/09/2025 16:06, Andrew Lunn wrote:
>>>>>  	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
>>>>>  	memory-region = <&main_r5fss0_core0_dma_memory_region>,
>>>>>  			<&main_r5fss0_core0_memory_region>;
>>>>> +	rpmsg-eth-region = <&main_r5fss0_core0_memory_region_shm>;
>>>>
>>>> You already have here memory-region, so use that one.
>>>>
>>>
>>> There is a problem with using memory-region. If I add
>>> `main_r5fss0_core0_memory_region_shm` to memory region, to get this
>>> phandle from driver I would have to use
>>> 	
>>> 	of_parse_phandle(np, "memory-region", 2)
>>>
>>> Where 2 is the index for this region. But the problem is how would the
>>> driver know this index. This index can vary for different vendors and
>>> their rproc device.
>>>
>>> If some other vendor tries to use this driver but their memory-region
>>> has 3 existing entries. so this this entry will be the 4th one.
>>
>> Just adding to this, there is nothing really TI specific in this
>> system. We want the design so that any vendor can use it, just by
>> adding the needed nodes to their rpmsg node, indicating there is a
>> compatible implementation on the other end, and an indication of where
>> the shared memory is.
> 
> I don't know your drivers, but I still do not see here a problem with
> 'memory-region'. You just need to tell this common code which
> memory-region phandle by index or name is the one for rpmsg.
> 

I am able to pass this index as driver_data in the `rpmsg_device_id`.

I can work with just adding this reserved memory region to the
'memory-region'. No need to create additional node in dt.

This will be the code,

static const struct rpmsg_eth_data ti_rpmsg_eth_data = {
	.shm_region_index = 2,
};

static struct rpmsg_device_id rpmsg_eth_rpmsg_id_table[] = {
	{ .name = "ti.shm-eth", .driver_data =
(kernel_ulong_t)&ti_rpmsg_eth_data },
	{},
};

Other vendors can add separate entry to rpmsg_eth_rpmsg_id_table with
their index based on their device tree.

I am keeping the data name `ti_rpmsg_eth_data` vendor specific so that
other vendors can create their data filed and add entry to
`rpmsg_eth_rpmsg_id_table` with driver_data pointing to their data
structure.

Andrew, does this sound ok to you. I will send out a v3 once you confirm.

Krzysztof, Andrew thanks for the feedback.

-- 
Thanks and Regards,
Danish


