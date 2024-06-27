Return-Path: <netdev+bounces-107328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 227AE91A956
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22272856AD
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836CA196455;
	Thu, 27 Jun 2024 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="At8UPRXD"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA5195FEC;
	Thu, 27 Jun 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498941; cv=none; b=rQxan9zaDbrRVcb586oWBrdNtMBj2MAZAf8DJx5e++9sEizc5cp+enRue2jSVs2pYyRe3FJPCUTSSm4znkXwBM4G7apXNMYHHTofrhO8ne6Yp+OYSIBQG3ksuNQGwONPYXo/xxCrIA5ETlFu56FuLoG4DKgeagXfnuc3wHG+L4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498941; c=relaxed/simple;
	bh=3Vi0uGfEuBdcPspVCidcNyOiSGrFtVEnJEsAyuLLmok=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VHFT3+yCtT3HDWwrBo9Qs+fSVSfMTRjiSnqbWIsBgp20Ad2mYp6u+VRqZVbkdIhWOWmCfJoYkLJUkH66wH5W0Qfy0RcCwYuyg0PsUlkrR+bV3WF4zukgz0uf/i9Dmey4MFBUd34r68NhucpX3ZeXkrIZ0XUFvZVDggTuOXhY8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=At8UPRXD; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R9aZpk001371;
	Thu, 27 Jun 2024 16:35:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	JZtOepcBSS+kH3b4UBs+hMQyBQdO3T/Rwy2l9o6fnIA=; b=At8UPRXDc6cOjJzL
	LdgebuAfvq1RI3Q1q6fuQ5fxzM4/cxORPud1Tqc/bSReshwD+d4onUMVZCI6BdE7
	TVTbzAaW1QDGmrKNaSU4ArrB7cFdtuGuE2sgkbtQVtBHaAk6I53PfyHasZMrhGh8
	e5qmAq2GpHfsg4JmisbypDmPkZnGco3ow4wgxw41Pl8vw8vvMCWiyleLq6unI6MY
	+jZcTUNOZDr9lajx2qiwQnQf2d5xvADicI7Isp21EIcsK2JZ0kveYn29woZ7Om3N
	1A5XtTjWrs4sbXs+ecL0hkfemKp+7z8tY6bnezYlf5Gti/JYHiUmqqxilyawpbOg
	p8jfwg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywm1gpfpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 16:35:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5EECA40046;
	Thu, 27 Jun 2024 16:34:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A9D9220B68;
	Thu, 27 Jun 2024 16:33:43 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 27 Jun
 2024 16:33:42 +0200
Message-ID: <876586b4-3957-4b55-83c4-decf42b05efd@foss.st.com>
Date: Thu, 27 Jun 2024 16:33:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Series DTs to deliver Ethernet for STM32MP25
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
References: <20240619125815.358207-1-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240619125815.358207-1-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_11,2024-06-27_03,2024-05-17_01

Hi Christophe

On 6/19/24 14:58, Christophe Roullier wrote:
> STM32MP25 is STM32 SOC with 2 GMACs instances.
>      GMAC IP version is SNPS 5.3x.
>      GMAC IP configure with 2 RX and 4 TX queue.
>      DMA HW capability register supported
>      RX Checksum Offload Engine supported
>      TX Checksum insertion supported
>      Wake-Up On Lan supported
>      TSO supported
> 
> Delivered Ethernet2 instance for board EV1 which is connected
> to Realtek PHY in RGMII mode.
> Ethernet1 instance will be delivered in next step.
> 
> V2: - Remark from Marek (sort DT)
> 
> Christophe Roullier (3):
>    arm64: dts: st: add ethernet1 and ethernet2 support on stm32mp25
>    arm64: dts: st: add eth2 pinctrl entries in stm32mp25-pinctrl.dtsi
>    arm64: dts: st: enable Ethernet2 on stm32mp257f-ev1 board
> 
>   arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 59 +++++++++++++++++++
>   arch/arm64/boot/dts/st/stm32mp251.dtsi        | 49 +++++++++++++++
>   arch/arm64/boot/dts/st/stm32mp253.dtsi        | 51 ++++++++++++++++
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    | 24 ++++++++
>   4 files changed, 183 insertions(+)
> 
> 
> base-commit: 382d1741b5b2feffef7942dd074206372afe1a96

Series applied on stm32-next

Thanks!!
Alex

