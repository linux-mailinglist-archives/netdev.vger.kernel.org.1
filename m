Return-Path: <netdev+bounces-102588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F8903D7B
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80233285B93
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91A617C21D;
	Tue, 11 Jun 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="p/Rld3O2"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144F51E535;
	Tue, 11 Jun 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112846; cv=none; b=ZE0OyG6qVdvTpFX2g5odxl/oB+L5SXtW08TIGBVy8KzaPmaN98OKyJMIEDkkuPVrPOmdts8/SuNTW3NK6iH8sF/WOhD9KtnM1CmPV0pRJ/h/O5h7FvVKCrZ/8qcPWTcqoCiPfZYQVdjnHlZWa4Xn4xYFLNFL/YaJ7tGLmIbLNgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112846; c=relaxed/simple;
	bh=a43EvLdzT3hjNYienRevQQ9EadCb/AzgEwa5kSDbq5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ozO8d52efrDxH86+7AffPFqvweDGWMYW/Gk/r5D75NFrY0u7famjd3vc7WXxJ/DNU/afxGMMoPVEh6jvme8RbaXfS0FBRmqcUiOhv2No5KdZKKEN9AHAJz+jRljzfMGXxVayEZHh92UwqeejMhhHOIvQVEe3s/TIAXZU3b4Jg+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=p/Rld3O2; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BCI3c7027544;
	Tue, 11 Jun 2024 15:33:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	yc4KsdWifRz6rWcxt8D4eZPRcwDWS3GJ2TG1rWFVqRo=; b=p/Rld3O29KvUSLHb
	0AWiU0UliT8PMxuaA7PA2/iLR8IHkBHkNlHlYjW0rxLicuqwGztFOBW6/MbtznWv
	frCWj/2YKwxc48GTk7YWziKkUzNZIa3J37VIGy/xjS019Vq/ThQ/e3ex1inRWSob
	ur9A7Vn76oAR0Ko6jMcCXJ70ZsI9pbXDAFJlyTzuS8uLHmBq5PdrrN3fXLtAMaUQ
	ZgoAl/f3XszurgUOI3Ko0RjXImVNYxJ/jxAf4RLKUHivcsNc3gglawMJkGc9RU+m
	ZWlY1CeDcTFnOGM4/E8tsQSxumiA6mCVL7g8rEG5vitiJ245RESCn2lfjfSiGJ64
	/dNMiw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypbp432sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 15:33:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id ADC9140044;
	Tue, 11 Jun 2024 15:33:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A5298215BEA;
	Tue, 11 Jun 2024 15:32:11 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 11 Jun
 2024 15:32:10 +0200
Message-ID: <7999f3df-da1e-4902-b58a-6bb58546a634@foss.st.com>
Date: Tue, 11 Jun 2024 15:32:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v7 7/8] net: stmmac: dwmac-stm32: Mask support
 for PMCR configuration
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
References: <20240611083606.733453-1-christophe.roullier@foss.st.com>
 <20240611083606.733453-8-christophe.roullier@foss.st.com>
 <ee101ca5-4444-4610-9473-1a725a542c91@denx.de>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <ee101ca5-4444-4610-9473-1a725a542c91@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_07,2024-06-11_01,2024-05-17_01


On 6/11/24 15:07, Marek Vasut wrote:
> On 6/11/24 10:36 AM, Christophe Roullier wrote:
>
> [...]
>
>>   static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, bool 
>> suspend)
>> @@ -348,8 +352,15 @@ static int stm32_dwmac_parse_data(struct 
>> stm32_dwmac *dwmac,
>>           return PTR_ERR(dwmac->regmap);
>>         err = of_property_read_u32_index(np, "st,syscon", 1, 
>> &dwmac->mode_reg);
>> -    if (err)
>> +    if (err) {
>>           dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);
>> +        return err;
>> +    }
>> +
>> +    dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
>> +    err = of_property_read_u32_index(np, "st,syscon", 2, 
>> &dwmac->mode_mask);
>> +    if (err)
>> +        dev_dbg(dev, "Warning sysconfig register mask not set\n");
>
> My comment on V6 was not addressed I think ?

Hi Marek,

I put the modification in patch which introduce MP13 (V7 8/8) ;-)

  	err = of_property_read_u32_index(np, "st,syscon", 2, &dwmac->mode_mask);
-	if (err)
-		dev_dbg(dev, "Warning sysconfig register mask not set\n");
+	if (err) {
+		if (dwmac->ops->is_mp13)
+			dev_err(dev, "Sysconfig register mask must be set (%d)\n", err);
+		else
+			dev_dbg(dev, "Warning sysconfig register mask not set\n");
+	}


