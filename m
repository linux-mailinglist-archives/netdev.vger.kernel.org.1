Return-Path: <netdev+bounces-219467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85999B4170E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF9188B0E9
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C7D2DBF6E;
	Wed,  3 Sep 2025 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oOC5tY9q"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D821C8611;
	Wed,  3 Sep 2025 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885482; cv=none; b=pbhQbVtrJW9h42km4yTZtf0Iddw2IE83SJwaB1ZhZEYNXLJcaVkqWsB14/KFLp5KUfEUhsL9JKjhv/ZNp16e96PpSDFfh9zn6HPCBkl94dUw27lBw/EZCLpjcZgfUH64Zgv0k2z2zg/k9N6zJq/3rUht2WSMBsTGgtKdLn3UBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885482; c=relaxed/simple;
	bh=UzjeIvCkXA9dbokj6cXZQ/0m+/oSRETAN7DOXHcComw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OwELczZGX6dIfaG4Gceh/jBdCkE7h8njVdHC3IYsZUNF5JelEdkzAdxnPtwcQDktGQhvUFsz/kh9gxXRrHFHs19+Dw0Y4Dev2Yge01BPamtCRC7HUbQSfQWtzRMhNMv2B1+9mPa4tTY+Orq7SgPFnOFBZ5z4gK1C2VBDPj4UsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oOC5tY9q; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5837hlMt2779765;
	Wed, 3 Sep 2025 02:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756885427;
	bh=La6ncxcZEmWdKtlYiqu4qaaCsos1RqPeSH44Dfbmrsg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=oOC5tY9q0MixsxO5Xobph2w7N4vEUNiRky93Q69HAAoIx2sePLaFHBWx0X3ND+G1E
	 3FU6rH9ecK8AXPX9Y4vFv5fmMEZnKD9TkEnHh8cjFxWAnuDv91+beFx84zl5YwhTeZ
	 rA6bQxoBaqnERooaaKdWbS7tAcH0XNXKIPTNtoXo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5837hle13356790
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 02:43:47 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 02:43:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 02:43:46 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5837hbje1211215;
	Wed, 3 Sep 2025 02:43:37 -0500
Message-ID: <ce3b3241-b944-4d2b-95e9-259c71b26026@ti.com>
Date: Wed, 3 Sep 2025 13:13:36 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/8] dt-bindings: net: ti,rpmsg-eth: Add DT
 binding for RPMSG ETH
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
 <20250902090746.3221225-2-danishanwar@ti.com>
 <20250903-dark-horse-of-storm-cf68ea@kuoka>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250903-dark-horse-of-storm-cf68ea@kuoka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof,

On 03/09/25 12:48 pm, Krzysztof Kozlowski wrote:
> On Tue, Sep 02, 2025 at 02:37:39PM +0530, MD Danish Anwar wrote:
>> Add device tree binding documentation for Texas Instruments RPMsg Ethernet
>> channels. This binding describes the shared memory communication interface
>> between host processor and a remote processor for Ethernet packet exchange.
>>
>> The binding defines the required 'memory-region' property that references
>> the dedicated shared memory area used for exchanging Ethernet packets
>> between processors.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  .../devicetree/bindings/net/ti,rpmsg-eth.yaml | 38 +++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/ti,rpmsg-eth.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,rpmsg-eth.yaml b/Documentation/devicetree/bindings/net/ti,rpmsg-eth.yaml
>> new file mode 100644
>> index 000000000000..1c86d5c020b0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/ti,rpmsg-eth.yaml
>> @@ -0,0 +1,38 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/ti,rpmsg-eth.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments RPMsg channel nodes for Ethernet communication
>> +
>> +description: |
>> +  RPMsg Ethernet subnode represents the communication interface between host
>> +  processor and a remote processor.
>> +
>> +maintainers:
>> +  - MD Danish Anwar <danishanwar@ti.com>
>> +
>> +properties:
>> +  memory-region:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: |
>> +      Phandle to the shared memory region used for communication between the
>> +      host processor and the remote processor.
>> +      This shared memory region is used to exchange Ethernet packets.
>> +
>> +required:
>> +  - memory-region
>> +
>> +additionalProperties: false
> 
> This cannot be really tested and is pointless binding... Really, one
> property does not make it a device node.
> 
> 

I tried to do something similar to google,cros-ec.yaml and
qcom,glink-edge.yaml

They are also rpmsg related and used by other vendors. I created similar
to that as my use case seems similar to them.

The only difference being I only need one property.


-- 
Thanks and Regards,
Danish


