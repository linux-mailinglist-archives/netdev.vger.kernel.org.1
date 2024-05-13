Return-Path: <netdev+bounces-96084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A988C43EC
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1B51C230C7
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC946139;
	Mon, 13 May 2024 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6fxuUzc0"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7432B1EB5B;
	Mon, 13 May 2024 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613357; cv=none; b=LdTeKFXfQan5yhKXSI/xXUFpqvOHtCMyaycLtlA/PDx2MgMVUH7OaZBh5AxK7Sqc1OEF5lBv7Xkdh8D/6khvr1bBSEb5RSGw7Mu0Sr64XpCiAXVWPwHOgtGMgwfSCQx3TKpU+b5y8MdvKd0OfU4smO26qAoJSRgeP4Ec9TTNR5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613357; c=relaxed/simple;
	bh=wN+bxMewYfk59ZhO6FatFbnK3XTXhM/uncKw4+2rhy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=snbJdAvcQ76B4gdBRLaeZC6Di4ne86lgm9WgZglpkMF2/2IMtRu12CDu05VVgXSFntl6iU1pzpmJtCMIteyH0IDJLfHaSSyPbR51ZWqLMaSU8DgYwLhAiihy4xo9r3Edo2q4UGQO6RHOPIjo0WyatHVtC1yM40tDbaEb1sTgAYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6fxuUzc0; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DCEFNO012993;
	Mon, 13 May 2024 17:15:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=/001sYINRF3QuS2WXNucZ6g4afwEJpHTPMm7u6dV36I=; b=6f
	xuUzc0q+Uhb6FnzVUh0pFqLdOW/11qBYWlQ8eR/p/IRtf6hiFXWx9SwAzsvKYy+b
	QscKscbuLpWfluMRuURat1XI/gw3X1pYQLP+FjoeMG3BvcRMRmbd+fWC4hIHMBwa
	M4jLbitCejlFAR/2aTc4JLgPhSLfprychXoLH8TT3VtVOrPueu4HEjW6/XI8PppQ
	XqH8D2zbfUlrAwDN6UhTtZ+rbo5vLFwFeJnCNAbVk3ZZQXml9UvTH2VeID3zkysD
	7N6Tpm7CpI4vEeszdtwzk/7QuZ/RGkR+z3ozcnWByOfYUrIFsZwPJTh0FjY5EMYl
	zPUK7v2J92++F4vzvAPw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y1y8n7dfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 17:15:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7DF6540044;
	Mon, 13 May 2024 17:15:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2EC3E22365C;
	Mon, 13 May 2024 17:14:11 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 17:14:08 +0200
Message-ID: <742bc68a-63a8-4f6e-b5ad-1f37a543f24f@foss.st.com>
Date: Mon, 13 May 2024 17:14:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] net: stmmac: dwmac-stm32: clean the way to
 manage wol irqwake
To: Marek Vasut <marex@denx.de>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-7-christophe.roullier@foss.st.com>
 <5b8b52cf-bd43-40c0-962a-c6936637b7de@denx.de>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <5b8b52cf-bd43-40c0-962a-c6936637b7de@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_10,2024-05-10_02,2023-05-22_02


On 4/26/24 17:40, Marek Vasut wrote:
> On 4/26/24 2:57 PM, Christophe Roullier wrote:
>> On STM32 platforms it is no longer needed to use a dedicated wakeup to
>> wake up system from CStop.
>
> This really needs more clarification.
>
> Why was the code needed before ? Maybe because it was used by some of 
> the older STM32F4/F7/H7 SoCs ? Is it still needed by those SoCs ? Will 
> this patch break those older SoCs ?
Yes you are right, if power mode use in STM32F4/F7/H7 SoC, issue with 
this patch, I will abandon it.
>
>> This patch removes the dedicated wake up usage
>> and clean the way to register the wake up irq.
>
> [...]

