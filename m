Return-Path: <netdev+bounces-114400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5A59425BA
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 07:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD4DB21159
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 05:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18154374D4;
	Wed, 31 Jul 2024 05:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j9fYdYHf"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C419A2942A;
	Wed, 31 Jul 2024 05:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722403635; cv=none; b=CzvnGXwexAlS1qAN6j26LXHAQmQxZYaObGuxuLRyZUZzXlBtD76cJlRRddwVMFh0T+VOZzuYsUHQpMEQdUENrgG2vGQC2cn8Y9F0In1H+vtipCDXmQM/X+JBW5ECvgl+BJrJcNG1guUSBWFi2GeTtGBCeWqw32RwGyklZwQTNFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722403635; c=relaxed/simple;
	bh=lHOQEwHFGr6IRvkQ0edrsSx+6YXVaxIcl8yCX7E0gTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fvB5oRk4J97+tHGNZMucjPJajmEvDJNYCX3e/GybacT3tIIVi8jd+X5MAVPkzLXjpLMrtG2DsRgD0glVdPEdFjCAV1M3KAjDogdZPjr/v0iIzqKygBSI6Aj9fNl+R0d8Jd9eRHBmpYRZItRMo8F8Ll2xpTxDo3nDmcyMWQa4i98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j9fYdYHf; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46V5Qi7A058561;
	Wed, 31 Jul 2024 00:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722403604;
	bh=n9xBTiMwvt0rpB6EyYnOnZsaylDjxVHudrA+wyU00ws=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=j9fYdYHfpMs9glxOErzDyT0DknOq1J49TpzwbUWILC/qAd88MvAhGG5+QqRdBfAmk
	 Zug0g1iQ6mk2lEEE1/h5JsQOIpKKiHSKIO+f3CjN7sLpyEDvRdHhic3hyQmfR/0Mi6
	 PZoa031v2yFJdzp3cVSjx5e+RZmAfFoUOLYgo7HE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46V5Qijq070686
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 00:26:44 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 00:26:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 00:26:43 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46V5QYDW110549;
	Wed, 31 Jul 2024 00:26:35 -0500
Message-ID: <3dbe09c5-8803-4ad8-9618-a9660854274b@ti.com>
Date: Wed, 31 Jul 2024 10:56:34 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DO NOT MERGE][PATCH v4 6/6] arm64: dts: ti: k3-am64: Add
 ti,pa-stats property
To: Nishanth Menon <nm@ti.com>
CC: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Roger
 Quadros <rogerq@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>
References: <20240729113226.2905928-1-danishanwar@ti.com>
 <20240729113226.2905928-7-danishanwar@ti.com>
 <20240730120816.unujbfewvcfd3xov@geiger>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240730120816.unujbfewvcfd3xov@geiger>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 30/07/24 5:38 pm, Nishanth Menon wrote:
> On 17:02-20240729, MD Danish Anwar wrote:
>> Add ti,pa-stats phandles to k3-am64x-evm.dts. This is a phandle to
>> PA_STATS syscon regmap and will be used to dump IET related statistics
>> for ICSSG Driver
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am642-evm.dts | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> index 6bb1ad2e56ec..dcb28d3e7379 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
>> @@ -253,6 +253,7 @@ icssg1_eth: icssg1-eth {
>>  		ti,mii-g-rt = <&icssg1_mii_g_rt>;
>>  		ti,mii-rt = <&icssg1_mii_rt>;
>>  		ti,iep = <&icssg1_iep0>,  <&icssg1_iep1>;
>> +		ti,pa-stats = <&icssg1_pa_stats>;
> 
> Follow:  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117
> for ordering properties.

Sure Nishant, I will take care of ordering properties when I post these
DTS patches for merge.

For now, I have posted DTS patches only for reference and only the
dt-binding patch is for merging.

>>  		interrupt-parent = <&icssg1_intc>;
>>  		interrupts = <24 0 2>, <25 1 3>;
>>  		interrupt-names = "tx_ts0", "tx_ts1";
>> -- 
>> 2.34.1
>>
> 

-- 
Thanks and Regards,
Danish

