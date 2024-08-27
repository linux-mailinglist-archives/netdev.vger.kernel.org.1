Return-Path: <netdev+bounces-122179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92237960409
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC5EB22FCE
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2963199E95;
	Tue, 27 Aug 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oK+P+wyR"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9507199242;
	Tue, 27 Aug 2024 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746120; cv=none; b=tJp+HBey9TOEn55SUNrW+p+BATLjIT3zugYlYpHDdKKq77ohgbZGdicu9pt446NnDWGUOUSGbvYGKPetL1qUF/nADzWI674pvac+rZbIa4yO5oxUj7UVKEKAT/AeoQVkMDYnvznduqfgXfEQlYHoLwH3drGRIusAY8fg0ZJLDE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746120; c=relaxed/simple;
	bh=KUNevkqKItUtyAoJeoaCrfGr37Eon6c2GKQEP9yAB9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pYrIAh0JFJkELIEbprvX4pbVgKamqcey9j+9hq6FAgscMOreXK0Qr4pVQjch0F/3Kv+n+tjbCy7HCK+ftRRvUBeHmDRqu1TjWO2sOFTTFtvWEBNWXlWzR1lmfsBTLaZYFOxq+XmeQplPGwNQoAXKhArjMWQ346H1VdfGavhbA3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oK+P+wyR; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R7NZnX002527;
	Tue, 27 Aug 2024 10:08:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	NL0vfsDaZi+n7IXnnxL961mLfvdpI9ZZJJiAuUY0CU8=; b=oK+P+wyRw6FWOfoE
	ii3HFisp1T+BZcECPD9QcTmWQAnw0oAdYT+ELLEbd2HwfVDIg7dqla3qthTTlFDn
	9dHgJfiS8GlyJMKotw2TmRX8VLsA6NXdw5Vp0hUnHbt95dJ7cvqsNkTTe8JSlqJ3
	ilBOB9iLUYx3zQ8pltIC2PiQLRKfPPRkVT4ih9SmavhWveUdmAzzFkRyAkUJDsIg
	3Vw5npBP4l3po35kbKOg4jkMJke1iHgIvabfPlrSXmv9OrBF/NqfqrM7/Ub5Obe3
	fZV9bmY/1mm9Fkq5GKQXAbp2Zl9HrzxP2GDbbFfvPdDpSI9/fSwEZKZY5gub+8z+
	Vw8oWQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 419ac886r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 10:08:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2089540048;
	Tue, 27 Aug 2024 10:08:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C12A724DCC5;
	Tue, 27 Aug 2024 10:07:11 +0200 (CEST)
Received: from [10.252.31.50] (10.252.31.50) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 10:07:10 +0200
Message-ID: <8a13fd32-4bc4-4711-bf6b-7e0ce2e938ec@foss.st.com>
Date: Tue, 27 Aug 2024 10:07:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: dts: st: stm32mp151a-prtt1l: Fix QSPI
 configuration
To: Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Oleksij Rempel
	<o.rempel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240806120517.406714-1-o.rempel@pengutronix.de>
 <20dc2cd4-7684-4894-9db3-23c3f4abd661@pengutronix.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20dc2cd4-7684-4894-9db3-23c3f4abd661@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_05,2024-08-26_01,2024-05-17_01

Hi

On 8/7/24 11:38, Ahmad Fatoum wrote:
> Hello Oleksij,
> 
> On 06.08.24 14:05, Oleksij Rempel wrote:
>> Rename 'pins1' to 'pins' in the qspi_bk1_pins_a node to correct the
>> subnode name. The previous name caused the configuration to be
>> applied to the wrong subnode, resulting in QSPI not working properly.
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>>   arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi b/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
>> index 3938d357e198f..4db684478c320 100644
>> --- a/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
>> +++ b/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
>> @@ -123,7 +123,7 @@ flash@0 {
>>   };
>>   
>>   &qspi_bk1_pins_a {
>> -	pins1 {
>> +	pins {
> 
> As you have seen such device tree overriding is error prone and would
> be entirely avoidable if specifying full board-specific pinctrl groups
> was allowed for the stm32 platforms instead of override-and-pray.

You can create your own pin group in stm32mp15-pinctlr.dtsi. What is the 
issue ? Do I miss something ? It will avoid to overwrite an existing 
configuration

regards
alex


> Anyways, there's better syntax for such overriding now:
> 
>    &{qspi_blk1_pins_a/pins}
> 
> which would cause a compilation error if pins was renamed again.
> 
>>   		bias-pull-up;
> 
> There's bias-disable in stm32mp15-pinctrl.dtsi. You may want to add
> a /delete-property/ for that to make sure, it's not up to the driver
> which one has priority.
> 
>>   		drive-push-pull;
>>   		slew-rate = <1>;
> 
> These are already in qspi_bk1_pins_a. If repeating those is ok, why
> not go a step further and just duplicate the pinmux property and stay
> clear of this issue altogether, provided Alex is amenable to changing
> his mind regarding pinctrl groups in board device trees.
> 
> 
> Cheers,
> Ahmad
> 

