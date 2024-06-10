Return-Path: <netdev+bounces-102244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DC99020FB
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89B31C23217
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A744981AA2;
	Mon, 10 Jun 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Z2gvYhOR"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42B77E78E;
	Mon, 10 Jun 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020596; cv=none; b=lAwH5Y2C7tusT3JoiZcAfFaTtiGhXDK6JgZ39oS6gvwljOlm4G0QS0yfdfVxbUj969637AaDOICkeD8+pCVzZe8rRtBPCDOUxE1g7OTGXWd88aAaqsHaN99sKqKeXzzpGElbl9bHAZPHcAmFh+i9S1P8SVcc/Y/pNC31RjcnbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020596; c=relaxed/simple;
	bh=aIZpj99P0sU05RD8b9KavtNB/mKvvZDjucVlsvQeQ18=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rmEK9jHFukGbJngiLFskrfyQj/+UXJkGPALtLJToHf5q32yw4Lug3qXT84anUCg8uGs4Av24lEYXXExevHfRKRVNSXnEiRnKlEfsUVwYy6py/BfNn6YUwLXK4u7muf/4jVKt1DroxGYjlK5fyyJ+KYr7v537n1DCQ0JJgNCI3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Z2gvYhOR; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A8Xick019005;
	Mon, 10 Jun 2024 13:56:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ljxA0CMixUpfWg1txgwTXMZ7NWYzNR9MGl6rj1rR4Us=; b=Z2gvYhORT3qNBZUJ
	4aIzn/P4fL5XmmKy0Zc2CWu0f3Yev282KotP0hkcZhn+84tHa4l9qWcoav4oQTef
	oAq2sFzNQ+X1LoTBJsqRK2AjojTRJtr/ssRFjsJTIQiZQcOxdEPzb1+J2KgWscdC
	/n+k86q6vCdP8A9VmWJNAJALKk90xEGiAFMZ20nnGn4oU6u57FFQqJ45Id6DYh1C
	zMkUqBzt/nxxp4/Gi0QW7cRAduIIZmgSDiU5w9Qi+j8QaDUrWDRKoSTGKwsMAaxl
	fDi8WE/NMTHoQ1cxvGfiJYBoniJSa+sD/UGWD47B+9oWPzg8/j+k51XkrUmH1AUf
	m0SG0A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yn0v14m1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 13:56:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A670B4002D;
	Mon, 10 Jun 2024 13:55:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9E0F921685E;
	Mon, 10 Jun 2024 13:54:39 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 10 Jun
 2024 13:54:38 +0200
Message-ID: <e4614975-a7a8-4bfa-a1e2-bf9c31547be9@foss.st.com>
Date: Mon, 10 Jun 2024 13:54:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] net: stmmac: dwmac-stm32: Separate out external
 clock rate validation
To: Ratheesh Kannoth <rkannoth@marvell.com>
CC: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240607095754.265105-1-christophe.roullier@foss.st.com>
 <20240607095754.265105-3-christophe.roullier@foss.st.com>
 <20240610114607.GA3818685@maili.marvell.com>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <20240610114607.GA3818685@maili.marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01

Hi Ratheesh,

On 6/10/24 13:46, Ratheesh Kannoth wrote:
> On 2024-06-07 at 15:27:44, Christophe Roullier (christophe.roullier@foss.st.com) wrote:
>> +static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
>> +{
>> +	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>> +	const u32 clk_rate = clk_get_rate(dwmac->clk_eth_ck);
> nit: reverse xmas tree, split definitions and assignment.

It is not possible ;-)

second declaration need first one.


