Return-Path: <netdev+bounces-219475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F4EB4177B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1FB163359
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694DF2E6CA0;
	Wed,  3 Sep 2025 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gm/FiO28"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8B2E2DFA;
	Wed,  3 Sep 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886333; cv=none; b=oSyQgxCKHGeGYzNkiHK+a5CFK5J0+l7TJ0pNuuRWfhKE1YSZzRK6BvQk8wqHGL5q+Nu8hxK0ZY5PnMmxjTWGQpOAMccX99Fr9CMklkmYzlCVxhZn4OCVUoJ/PJ21YMO2ZWnKWE4MA3IQDcHDIuQi9BU5qo12Nr6kjW/JxilReU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886333; c=relaxed/simple;
	bh=74O75ijkUdsvIPQhfHdZZhdBgkHM40PrUthaHaSUhn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XCbkBCI2zCsxqllJDpgaqbujuqD8bgNR5iWQlQL/yCw3qsUTAgeFnZlzfuF04LiXRwo3y9Q3lGmVxDYzzxRKRybfGork3LJGHXFlt19A93CKeXu12mhwmMTZLdvUOXHAfmkgFZmGZ1JrVfVQoC+2c300DAs3xw/4Sfmwk74wN4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gm/FiO28; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5837w2q73215022;
	Wed, 3 Sep 2025 02:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756886282;
	bh=C1GxC5wEZ7w0hRkO573JUt7hmP/RrOOhSWDg3A2PT/o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=gm/FiO2863E9riM2wUW/YKWv+8Hap14okkUNr7krZuwkWdIUMhHcNztY9yuLsb/me
	 HcYQNkHXf/M0DnC+lgydKkWhm8U+ai3ViN3TsI32t0zs3rNF8a1iM6VSvY3nCXGFZH
	 AlQQf2CZdmkmuaDdcQSLogjYpUH0z4Br8PsHf/q0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5837w2lr3363202
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 02:58:02 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 02:58:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 02:58:01 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5837vpEY1226636;
	Wed, 3 Sep 2025 02:57:52 -0500
Message-ID: <d994594f-7055-47c8-842f-938cf862ffb0@ti.com>
Date: Wed, 3 Sep 2025 13:27:51 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/8] dt-bindings: remoteproc: k3-r5f: Add
 rpmsg-eth subnode
To: Krzysztof Kozlowski <krzk@kernel.org>
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
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250903-peculiar-hot-monkey-4e7c36@kuoka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 03/09/25 12:49 pm, Krzysztof Kozlowski wrote:
> On Tue, Sep 02, 2025 at 02:37:40PM +0530, MD Danish Anwar wrote:
>> Extend the Texas Instruments K3 R5F remoteproc device tree bindings to
>> include a 'rpmsg-eth' subnode.
>>
>> This extension allows the RPMsg Ethernet to be defined as a subnode of
>> K3 R5F remoteproc nodes, enabling the configuration of shared memory-based
>> Ethernet communication between the host and remote processors.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml     | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>> index a492f74a8608..4dbd708ec8ee 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>> @@ -210,6 +210,12 @@ patternProperties:
>>            should be defined as per the generic bindings in,
>>            Documentation/devicetree/bindings/sram/sram.yaml
>>  
>> +      rpmsg-eth:
>> +        $ref: /schemas/net/ti,rpmsg-eth.yaml
> 
> No, not a separate device. Please read slides from my DT for beginners

I had synced with Andrew and we came to the conclusion that including
rpmsg-eth this way will follow the DT guidelines and should be okay.

I have another approach to handle this.

Instead of a new binding and node. I can just add a new phandle to the
rproc binding. Phandle name `shared-mem-region` or `rpmsg-eth-region`

Below is the device tree and dt binding diff for the same.

diff --git
a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
index a492f74a8608..c02c99a5a768 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
@@ -210,6 +210,16 @@ patternProperties:
           should be defined as per the generic bindings in,
           Documentation/devicetree/bindings/sram/sram.yaml

+      rpmsg-eth-region:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: |
+          phandle to the reserved memory nodes to be associated with the
+          remoteproc device for rpmsg eth communication. The reserved
memory
+          nodes should be carveout nodes, and should be defined with a
"no-map"
+          property as per the bindings in
+
Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+        additionalItems: true
+
     required:
       - compatible
       - reg
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index e01866372293..e70dc542c6be 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -61,7 +61,13 @@ main_r5fss0_core0_dma_memory_region:
r5f-dma-memory@a0000000 {

 		main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
 			compatible = "shared-dma-pool";
-			reg = <0x00 0xa0100000 0x00 0xf00000>;
+			reg = <0x00 0xa0100000 0x00 0x300000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_memory_region_shm: r5f-shm-memory@a0400000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0400000 0x00 0xc00000>;
 			no-map;
 		};

@@ -768,6 +774,7 @@ &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
+	rpmsg-eth-region = <&main_r5fss0_core0_memory_region_shm>;
 };

 &main_r5fss0_core1 {


In this approach I am creating a new phandle to a memory region that
will be used by my device.

Can you please let me know if this approach looks okay to you? Or it you
have any other suggestion on how to handle this?

> talk from OSSE25. This is EXACTLY the case I covered there - what not to
> do.

Sure I will have a look at that.

-- 
Thanks and Regards,
Danish


