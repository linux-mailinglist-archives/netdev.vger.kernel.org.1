Return-Path: <netdev+bounces-107250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6987591A6C8
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C8228596F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA952161900;
	Thu, 27 Jun 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GtnRWrDW"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC41161314;
	Thu, 27 Jun 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492237; cv=none; b=P7UlGjks6jwblu4kCMyTEJIhpRP4MCCA/WqwIgtjZunV3WxO02Ztpxzz8z50F7eEBD3aXEjbXl4ixd7tRhBvofaOLQNZFPk/n6J4HoCjreuSuh9qvMOQot3VqT7A61rdrEHLH+I+e7BJGXg//0E0b2LtyVHn799W4hsMIOLfbek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492237; c=relaxed/simple;
	bh=ozMDR0fkbEQta+UOJZ1FFXQo1ZGGSn1y5K98kho/9pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=trQ8JFkZzGWdIFCz08fQuZD3hr9BfmyZPjGomfVXgKf5UD7OPUi1hgsugZOBIkqB+mNYVsEqXuSwi79UxWp3r8WP3HALpl2A9VUlT6LpXNjk/o/8P63nYV1bWDZUbdn73wytdEMaP3QB05SomzUukd7PlenHWVG6IubuUFO5KZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GtnRWrDW; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R9ZMS3011277;
	Thu, 27 Jun 2024 14:43:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	bvWJeEz7wgq1kb1F+RfxA0OnfFRUKW1rLsdX1vbv/18=; b=GtnRWrDW7l/RHIL3
	DNyn7KxrcBxc+AE0eh8g9Tir7OKU7onm/JuFafJfnVWMSLZEEXPpi5viIs99qWxB
	oLwrYWA8Xf1BrgOz9XgTjPoWC+VAkuEYjDv5RMt9Li5YsD6Oykr/vISr2F0gQlSD
	Z4rdTmi+pMBlys61FRXBVeq63HcQRxNO5QrPONw4aLWLD6QnLQuempMZiplRSPUJ
	rXKiMGO3wt5Q+9sf/HD3vFmkh5XBAuxSFvWwu3XjYz3owu4Nj3DCf1CnbrjrfHUJ
	fAcK7mXSxCmyC0yGFiLFFRSerA9/9Ja3gjMkkVmQ3i8oYKrYwrjPAtKsn6zp9vI9
	PSV+oA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx860uenb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 14:43:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5AD794002D;
	Thu, 27 Jun 2024 14:43:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A32C721A900;
	Thu, 27 Jun 2024 14:42:12 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 27 Jun
 2024 14:42:11 +0200
Message-ID: <1a13b19b-cf16-4a49-8d80-21579dc1da94@foss.st.com>
Date: Thu, 27 Jun 2024 14:42:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] Add MCP23S08 pinctrl support
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
References: <20240611084206.734367-1-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240611084206.734367-1-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_08,2024-06-27_03,2024-05-17_01



On 6/11/24 10:42, Christophe Roullier wrote:
> Enable MCP23S08 pinctrl support
> 
> V2: - Remark from Krzysztof (Change built-in to module)
> 
> Christophe Roullier (1):
>    ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support
> 
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> 
> base-commit: bb678f01804ccaa861b012b2b9426d69673d8a84

Applied on stm32-next.

Thanks
Alex

