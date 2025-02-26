Return-Path: <netdev+bounces-169890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46740A46430
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE44D17C07D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7860F223313;
	Wed, 26 Feb 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="TO4UsmVX"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93762222582;
	Wed, 26 Feb 2025 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582641; cv=none; b=oy7gKnQglOsBf9Ja3hbsJ0wom2LsRuIjEgJ8mbF+Cpsnns5BPzsoeWjBsmnFbe69JGIis6Hcpd9n7PkAaGIMkliVBK9V84FNFk69kqqCzmWxBa0FokuvV+8gX8y1pOP6vj/8pTSNCiFmVZ8mmSZcTp2XzU+UV368rnfg91qJKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582641; c=relaxed/simple;
	bh=YolhIxlnD/KFo71BB2N1+kGv0r3k8mAuWJLh1TvzXDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tr7va8jpyvP2te5gycDorJZFUVqkcsqC2mHiNjdkJ0fvj+Owut1Wzhecdr3M6diZTGTVUkaA0Uwy1pdt+dK14CjE9oEjp0Axi9EeuNOGItXhiJ9Mgx7blpPcio7GUhq5uShT19hQBlPkGP5nO057xbP15CBdZnOMnOC9gVkyq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=TO4UsmVX; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QCD3Hx012382;
	Wed, 26 Feb 2025 16:10:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	8ewL/+uVM2seWyrZlyz4H0RFQuaYKzC45+3Da4nH/t0=; b=TO4UsmVXLWNtMv4Z
	Yh9qIQNeRvGI9qcLvgtzAb3wZNmt6WdJ8e9aatcrI1BVtx7+grrEXzNPhKTnzhVo
	8UkQFSfHTBz0XIsGcdK1HqRENglIQ6g5M/v9ljtvMgiT2uTLAXvJ59kmodhREVpv
	qWagnLPoK48zABDtsyT2/f79aAXq570oMn6ibK/hbcXyf69i8/RLhtktR/BQFIFW
	zjJ/jIm38zrlCZM6gIvydsf1R5DiynJGK/1ER8JsFsQcOMVaoM7bq/a+wsBhKafZ
	J3N1AyuqpojgVEBX6rLC3tT1Spflz6IgtpyH3T/9zQvIxwVYKSd4iSgSchm4W6Yr
	OHMImQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 451psv5a9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 16:10:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4DAF1400BB;
	Wed, 26 Feb 2025 16:08:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C731C5792D9;
	Wed, 26 Feb 2025 14:24:54 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 14:24:54 +0100
Message-ID: <2c8683f7-2c1c-4e18-9f76-53c528029b40@foss.st.com>
Date: Wed, 26 Feb 2025 14:24:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add support for Priva E-Measuringbox board
To: Oleksij Rempel <o.rempel@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh
	<woojung.huh@microchip.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20250203085820.609176-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250203085820.609176-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01

Hi

On 2/3/25 09:58, Oleksij Rempel wrote:
> This patch series introduces support for the Priva E-Measuringbox board
> based on the ST STM32MP133 SoC. The set includes all the necessary
> changes for device tree bindings, vendor prefixes, thermal support, and
> board-specific devicetree to pass devicetree validation and checkpatch
> tests.
> 
> changes v2:
> - drop: dt-bindings: net: Add TI DP83TD510 10BaseT1L PHY
> 
> Oleksij Rempel (2):
>    dt-bindings: vendor-prefixes: Add prefix for Priva
>    dt-bindings: arm: stm32: Add Priva E-Measuringbox board
> 
> Roan van Dijk (2):
>    arm: dts: stm32: Add thermal support for STM32MP131
>    arm: dts: stm32: Add Priva E-Measuringbox devicetree
> 
>   .../devicetree/bindings/arm/stm32/stm32.yaml  |   6 +
>   .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>   arch/arm/boot/dts/st/Makefile                 |   1 +
>   arch/arm/boot/dts/st/stm32mp131.dtsi          |  35 ++
>   arch/arm/boot/dts/st/stm32mp133c-prihmb.dts   | 496 ++++++++++++++++++
>   5 files changed, 540 insertions(+)
>   create mode 100644 arch/arm/boot/dts/st/stm32mp133c-prihmb.dts
> 
> --
> 2.39.5
> 

Series applied on stm32-next.

Cheers
Alex

