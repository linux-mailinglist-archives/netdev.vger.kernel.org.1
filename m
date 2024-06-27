Return-Path: <netdev+bounces-107242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C1D91A67E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9F4284BD9
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4A5156F42;
	Thu, 27 Jun 2024 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ARC3XNZD"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518E15573B;
	Thu, 27 Jun 2024 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490857; cv=none; b=a2gDEpnMC9i4OjMTsqwdE9h08sNsInA8pzyOFOOgbL/Uw6EwB8KBjCGvXMqXJnWbmlEAB2AAz1MtCCUvR6dboB+T5s5FQ0QEX4jUFfRYu4UvZDL5q/MDK5jRuwieAq77lTnv3X5Eur9sxO9ZhcI51prdTrv1EK5+uQ3eYY5e/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490857; c=relaxed/simple;
	bh=7N0odRzOw1ltNVEc/R/14XetuMEqhPMVC1+GvkLtPmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DTHjaO3spjM4KSCDf9sWEn+zrdK3fM36O7sc3NDoXabtOt0zOy6DKEtRdkIeqDyFX9jnohXqYLqmTHmt2OpBHAMdkgdiTjqhb/Jq2XG+ElpjwHU+QGtlC0Xl4Biv7F74XZVZO7U9gOPJUSGnvCeQgeIpLQ3jUEj2g2zpRQgYhcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ARC3XNZD; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R95ARN020835;
	Thu, 27 Jun 2024 14:20:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	AGl8CVfDYYSZflNFW+9FeYoeCPrKt6+mzA+//qho8Gc=; b=ARC3XNZDq7mKTDtw
	Rd/HVBSE9YxIXlVoQpeT+6Ype3wcHoIr888t2gA9qlKgLMhiKcjMRvnR/Zf4HPL8
	pSDT/uWI/rQaNF85uvoNSDKw9LNUyhRphQHx82kdlySQg3R+qWm6C4bKFP4vgTYp
	ZEZ9thnCiLNCdDICQHKES477pNEK4hO10przJi3OV4KkJ3enb1oLOQPOcdShUAD8
	PRcWAU6eIzNUnkeFvULwpQQgcNW2m9Hdy22WtZFW811UtlVhtyviv0PB7vBmlNO+
	+aEXimxg/WkGkY5+M6vLdwtxpTjKebOMtP0F+ZBWbntsfiWHNExqzG425KB6cuNX
	VbPv/g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywnxxngmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 14:20:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 462774002D;
	Thu, 27 Jun 2024 14:20:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CAA30218601;
	Thu, 27 Jun 2024 14:19:08 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 27 Jun
 2024 14:19:07 +0200
Message-ID: <0b155f29-17d1-4863-be38-fb6c1dec4c31@foss.st.com>
Date: Thu, 27 Jun 2024 14:19:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Series DTs to deliver Ethernet for STM32MP13
To: Christophe Roullier <christophe.roullier@foss.st.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Marek Vasut
	<marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240610080309.290444-1-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240610080309.290444-1-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_06,2024-06-27_03,2024-05-17_01

Hi

On 6/10/24 10:03, Christophe Roullier wrote:
> STM32MP13 is STM32 SOC with 2 GMACs instances
>      GMAC IP version is SNPS 4.20.
>      GMAC IP configure with 1 RX and 1 TX queue.
>      DMA HW capability register supported
>      RX Checksum Offload Engine supported
>      TX Checksum insertion supported
>      Wake-Up On Lan supported
>      TSO supported
> 
> Christophe Roullier (3):
>    ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
>    ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
>    ARM: dts: stm32: add ethernet1 for STM32MP135F-DK board
> 
>   arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi | 71 +++++++++++++++++++++
>   arch/arm/boot/dts/st/stm32mp131.dtsi        | 38 +++++++++++
>   arch/arm/boot/dts/st/stm32mp133.dtsi        | 31 +++++++++
>   arch/arm/boot/dts/st/stm32mp135f-dk.dts     | 23 +++++++
>   4 files changed, 163 insertions(+)
> 
> 
> base-commit: 28f961f9d5b7c3d9b9f93cc59e54477ba1278cf9

Series applied on stm32-next.

regards
Alex

