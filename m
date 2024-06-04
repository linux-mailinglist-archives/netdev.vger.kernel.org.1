Return-Path: <netdev+bounces-100493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A42008FAE8F
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A40C1F2327B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D138214374B;
	Tue,  4 Jun 2024 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="eyBkfZ3c"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11141142E9C;
	Tue,  4 Jun 2024 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492654; cv=none; b=FUQC9Pyi1h9koGcy9NcQFoRKDxMfKsVKEDq9qwD18vzeUvd3RWeEP4OLCdJxSp1qRV6EAqD2dWI40vvv1nKfC6YnTX27QR2XmMbh2/YXL/vYjMuZ+cxkdgUcgZNHaBtZzfQcJWbcoUsLLEWb9lePXqGlwwBDihqNheO+3dz4zcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492654; c=relaxed/simple;
	bh=fNwB+gRlhAFTJtZg/PqoxlSZUp9TXw3Qn2y1TZ/BZvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gF9FMtTnIe4/MwPSW2ChGwW9mZZPS74BWq8H5Bt2mS3VI6zn8pdOSnF1hEM/na/t2LkpBda5Qz6Q175NTI2aPQ2XnDSLTFF3cFRGjm+SFo8hQsgwe487sFWne867oZLWaRY2FajvBnCg0mq9mlQ8DVqFLl+nEK7olJ+8aaxBnnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=eyBkfZ3c; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4549DsjD012859;
	Tue, 4 Jun 2024 11:16:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	OQe/uADEFpVniANl2HPBtkrGxr/1Jkhh9ScZYTBH7MU=; b=eyBkfZ3cqtw3pYoe
	F9n5Ujb2ZempFMCIcweE4Yd5LD9jXfOUg+cJFoPSNxyel/TMmdWX2w25O0aGghHO
	/NGfcb0JihUC/q9171VEtsnidPfKp7+jOEi1o4GlQ009Hsd8KyoJTSreZHK0duIL
	atXVY54YNxe8GP/MHtIDXlOKNzgKAsSDzm7zkQrntAEyXjS8FJzRG7W5yl5O1Ogu
	DcHuTqEYjffYhm0M5F12BvMEK85t/7K9Z75NPUZTrId+5mILu83I72oypNeLWo9G
	OqZP1/4ScYDR7VrgxNUWX4DdWtq1sLlWv1LOdAcmHMZRPt5ggArJ4A4iEFpVOUdE
	e8r8Kg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw3wjx6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 11:16:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F094040044;
	Tue,  4 Jun 2024 11:16:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 980B72122EA;
	Tue,  4 Jun 2024 11:15:38 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 11:15:36 +0200
Message-ID: <0a9f494e-94ae-43b2-84fa-6d984c4106cd@foss.st.com>
Date: Tue, 4 Jun 2024 11:15:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] net: ethernet: stmmac: add management of
 stm32mp13 for stm32
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
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
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
 <20240603092757.71902-8-christophe.roullier@foss.st.com>
 <d5ce5037-7b77-42bc-8551-2165b7ed668f@prevas.dk>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <d5ce5037-7b77-42bc-8551-2165b7ed668f@prevas.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_03,2024-05-30_01,2024-05-17_01


On 6/3/24 13:30, Rasmus Villemoes wrote:
> On 03/06/2024 11.27, Christophe Roullier wrote:
>
>> @@ -259,13 +268,17 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
>>   
>>   	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
>>   
>> +	/* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
>> +	val <<= ffs(dwmac->mode_mask) - ffs(SYSCFG_MP1_ETH_MASK);
>> +
>>   	/* Need to update PMCCLRR (clear register) */
>> -	regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
>> -		     dwmac->ops->syscfg_eth_mask);
>> +	regmap_write(dwmac->regmap, dwmac->ops->syscfg_clr_off,
>> +		     dwmac->mode_mask);
>>   
>>   	/* Update PMCSETR (set register) */
>>   	return regmap_update_bits(dwmac->regmap, reg,
>> -				 dwmac->ops->syscfg_eth_mask, val);
>> +				 dwmac->mode_mask, val);
>>   }
>>   
>>   static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
> This hunk is broken, and makes the patch not apply:
>
> Applying: net: ethernet: stmmac: add management of stm32mp13 for stm32
> error: corrupt patch at line 70
>
> The -259,13 seems correct, and the net lines added by previous hunks is
> indeed +9, but this hunk only adds three more lines than it removes, not
> four, so the +268,17 should have been +268,16.
>
> Have you manually edited this patch before sending? If so, please don't
> do that, it makes people waste a lot of time figuring out what is wrong.

Hi Rasmus,

Yes sorry :-(

>
> Also, please include a base-id in the cover letter so one knows what it
> applies to.
>
> Finally, I think you also need to sign-off on the patches you send
> authored by Marek.
Yes, you are right
>
> Rasmus
>

