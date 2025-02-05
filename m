Return-Path: <netdev+bounces-163126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E380BA295B4
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B760160D46
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6331DAC95;
	Wed,  5 Feb 2025 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6afy8HNX"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878BA1DAC81;
	Wed,  5 Feb 2025 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771625; cv=none; b=MLWBqZc2IKMiuda6pFVgMYhbCLPE3mqUQK8IWOeMMxgndQjhzRlDVI5AgAuxOq1LIjAfwCo/+avts6kHFw0HnP9dOGM2pbMzJS261WeLaW+l3aMjqXsgEmn6LFgajq0gjTtRD5G2dmB2Fzf1/L/rNwfKMR6JYouC+LPLY32WD5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771625; c=relaxed/simple;
	bh=53VKuWOfgt52pZFgRpANs8PddOmYAtpCNlsKAnzd8KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jBwoQrNWn7btq4MSBWhlYJMb528FE0i94Zrcf/BO2o4BDHtisRDz1qVb22lFCqqUcfiJcgiToeG1FOsEWYPjuEpn71dk+sjJ/ZgywRl35RGMUCEFtIaBhfKxcT6KZapi5cZTRIrqHlRYVutcHGQFcLXAOlzb/vV6ZyZ/TXmNiTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6afy8HNX; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515G0p1F031520;
	Wed, 5 Feb 2025 17:06:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	YzSHclRpZjXdpbypTAK2KFPhVA+qCoQsT3woG1zZJrE=; b=6afy8HNXwQBSd43T
	W8I2uCt96QhaXrBk5F49orAmd1WXv32fTK/pQNTq7dZ5sVTFqy3+EgJJLGjdmL4F
	w+o7QnWoOP8w4G/Ej+ABVk5j0NCslt1Gv94j4UxzHBbV2e0x9k1N4uCqwngeuiru
	j14PHwKduUWpfAf8VBOkUuMBsfX+/F9dqx0zLbw1yU0bcu/pcO84W2iL5BVFvPn5
	xpDHWtADAoB3otEOEDiTJpsh+TGIuuL7GWt6VSDBOtOBTeDzf5r7pU+7fi5xXSpi
	ayDUvTQB+njys7UJbC9LcsyTDFaMz+ru6iXiMDLGdaUiVusXhHRG9RYTzCTtG66/
	qshRwA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44m2ru2mmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 17:06:29 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0C44D40046;
	Wed,  5 Feb 2025 17:05:01 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 489692AF21F;
	Wed,  5 Feb 2025 17:02:21 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 17:02:20 +0100
Message-ID: <6db6e1d4-a0b1-4ce3-9235-d92bb19da1d6@foss.st.com>
Date: Wed, 5 Feb 2025 17:02:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add support for Priva E-Measuringbox board
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        "Rob Herring (Arm)"
	<robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Woojung Huh
	<woojung.huh@microchip.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>,
        <devicetree@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S.
 Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel@pengutronix.de>
References: <20250203085820.609176-1-o.rempel@pengutronix.de>
 <173859694746.2601652.11244969424431209545.robh@kernel.org>
 <Z6Msn8AxgG_JTVNs@pengutronix.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <Z6Msn8AxgG_JTVNs@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01

Hi Oleksij

On 2/5/25 10:17, Oleksij Rempel wrote:
> Hi Alexandre,
> 
> On Mon, Feb 03, 2025 at 09:37:06AM -0600, Rob Herring (Arm) wrote:
>>
>> On Mon, 03 Feb 2025 09:58:16 +0100, Oleksij Rempel wrote:
>>> This patch series introduces support for the Priva E-Measuringbox board
>>> based on the ST STM32MP133 SoC. The set includes all the necessary
>>> changes for device tree bindings, vendor prefixes, thermal support, and
>>> board-specific devicetree to pass devicetree validation and checkpatch
>>> tests.
>>>
> 
> ...
> 
>> arch/arm/boot/dts/st/stm32mp133c-prihmb.dtb: adc@48004000: adc@0:interrupts: 0 was expected
>> 	from schema $id: http://devicetree.org/schemas/iio/adc/st,stm32-adc.yaml#
>> arch/arm/boot/dts/st/stm32mp133c-prihmb.dtb: adc@48003000: adc@0:interrupts: 0 was expected
>> 	from schema $id: http://devicetree.org/schemas/iio/adc/st,stm32-adc.yaml#
>
> 
> Can I please get your attention here. The reported issue is not related
> to this patch set. adc@0:interrupts are set in the dtsi file.

Yes I saw this issue too when I tried to merge your series. I'm 
discussing with STM32 ADC driver owner to fix the issue (either in stm32 
adc yaml or maybe in schema).

Anyway we also have the issue for STM32MP135F-DK board so I'll merge 
your series as it doesn't introduce the issue.

regards
Alex




> Kind regards,
> Oleksij

