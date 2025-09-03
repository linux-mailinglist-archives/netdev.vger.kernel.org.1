Return-Path: <netdev+bounces-219589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CD7B421C5
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E770F4E4EBD
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E450308F27;
	Wed,  3 Sep 2025 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YkJ4AduF"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B31030275C;
	Wed,  3 Sep 2025 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906445; cv=none; b=a4OlPAiyvPltgTPJha1Du3rtOmWbhfO96Wuzzz7jvG6FL8V00TgY+gToi/1d4acr8mFCtLvku7XJTgdvcr8Q1FJY+ZfxkeleXZtmrjul2rRCZyh+FwIO0KWlrre9siM4ov4QWljMST2sv//tD6b+0VXw/fJkeD8YR5hElA34mSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906445; c=relaxed/simple;
	bh=2hBP7a77LXhu4FMAKVodcWryH+gjc+Z+qhMnvPPqARQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gnP9zHUv5U0+gM+Gasy2J8K31uemhXKXwQfcL/5YL1HPChalLb5KdJVg8t4GBdW+SR9NeWaATX1RwUxKlKzPULb8hAfGN8gNQarA+/m+iRyl71Djv2kqGtFaZzcM+n9Eotr2sx6jW35UmzRDJniDA2KVH9KByEXQrhzsxL+vImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YkJ4AduF; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583DXBu83272899;
	Wed, 3 Sep 2025 08:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756906391;
	bh=/Ex5Ruupp+iSliQyyGJXOWquzJhUs9ncVlh9Xx0KAOg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=YkJ4AduFBdZIueNM42g9orDKKPqATkUZHCsXGm20hLws3KsAx86RMTX21VDvV/2pq
	 bVoU3sgTH4BKRRH/obxMVs4lyd1UJo52sFDb/T+Yh+km72vZZvzxmoPL04jNdDQn1q
	 waxyljNGAE9MySM9myHfZPqH5dYuUPTIiHpOLWeo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583DXAeE3556800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 08:33:10 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 08:33:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 08:33:09 -0500
Received: from [10.249.130.74] ([10.249.130.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583DWvvN1636883;
	Wed, 3 Sep 2025 08:32:58 -0500
Message-ID: <38c054a3-1835-4f91-9f89-fbe90ddba4a9@ti.com>
Date: Wed, 3 Sep 2025 19:02:56 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/8] dt-bindings: remoteproc: k3-r5f: Add
 rpmsg-eth subnode
To: Krzysztof Kozlowski <krzk@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>
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
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <f2550076-57b5-46f2-a90a-414e5f2cb8d7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 9/3/2025 6:24 PM, Krzysztof Kozlowski wrote:
> On 03/09/2025 09:57, MD Danish Anwar wrote:
>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>> ---
>>>>  .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml     | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>>> index a492f74a8608..4dbd708ec8ee 100644
>>>> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>>> @@ -210,6 +210,12 @@ patternProperties:
>>>>            should be defined as per the generic bindings in,
>>>>            Documentation/devicetree/bindings/sram/sram.yaml
>>>>  
>>>> +      rpmsg-eth:
>>>> +        $ref: /schemas/net/ti,rpmsg-eth.yaml
>>>
>>> No, not a separate device. Please read slides from my DT for beginners
>>
>> I had synced with Andrew and we came to the conclusion that including
>> rpmsg-eth this way will follow the DT guidelines and should be okay.
> 
> ... and did you check the guidelines? Instead of repeating something not
> related to my comment rather bring argument matching the comment.
> 
> 
> ...
> 
>> @@ -768,6 +774,7 @@ &main_r5fss0_core0 {
>>  	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
>>  	memory-region = <&main_r5fss0_core0_dma_memory_region>,
>>  			<&main_r5fss0_core0_memory_region>;
>> +	rpmsg-eth-region = <&main_r5fss0_core0_memory_region_shm>;
> 
> You already have here memory-region, so use that one.
> 

There is a problem with using memory-region. If I add
`main_r5fss0_core0_memory_region_shm` to memory region, to get this
phandle from driver I would have to use
	
	of_parse_phandle(np, "memory-region", 2)

Where 2 is the index for this region. But the problem is how would the
driver know this index. This index can vary for different vendors and
their rproc device.

If some other vendor tries to use this driver but their memory-region
has 3 existing entries. so this this entry will be the 4th one.

But the driver code won't work for this. We need to have a way to know
which index to look for in existing memory-region which can defer from
vendor to vendor.

So to avoid this, I thought of using a new memory region. Which will
have only 1 entry specifically for this case, and the driver can always

	of_parse_phandle(np, "rpmsg-eth-region", 0)

to get the memory region.

>>  };
>>
>>  &main_r5fss0_core1 {
>>
>>
>> In this approach I am creating a new phandle to a memory region that
>> will be used by my device.
> 
> 
> 
> Best regards,
> Krzysztof

-- 
Thanks and Regards,
Md Danish Anwar


