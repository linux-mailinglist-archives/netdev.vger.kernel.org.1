Return-Path: <netdev+bounces-96686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1283E8C7258
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 10:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FED1C217E7
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 08:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F2C604D5;
	Thu, 16 May 2024 08:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UmMcVkWG"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2232F4120A;
	Thu, 16 May 2024 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846437; cv=none; b=kkV9bx82fXTqGymhLjO15eB4eheshaLIzrgXBnUuLSZf1DJauturWZDN625kJ7JuMrLu6hMKxwaTH8b5jfML7FxkKk9UmpcU9cQ7pOHCFcaeF3cP2wxSKSuBOEymLzpOXnLew1rembSBs/G7bTstsH+aifeYV3Tiz9UAr3I+czw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846437; c=relaxed/simple;
	bh=ir7OEPsIB4tXdeYYmNY7Cbeyj6ggj2jZXmerEjaLdfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sdbweVHhURrhZcoWqC1oGEuf0WnOb3RuGArqixvr0pMbitOhSui9cBHbUi6DvmtaQvhGhxXYFC7j6YalCjDRoySNlE6D/XnWuNwAWcX/oku+ica9S9FdDjIL/Fxm5JNyt/MmaVmVozbRmTkD7UwURvL6RAZYe/ppmhs569HCtlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UmMcVkWG; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G7e2A0009990;
	Thu, 16 May 2024 10:00:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=Y9trgIEu9RJeCdLikqsHLkO6L244vgMdpxM1Z3pwaD0=; b=Um
	McVkWGSeyAqG7zib2bWvlJJKU1n11jEEZc09GsrTpzqCiEXZypojsxCIhQ6QGb2R
	h/85D95WXhwEGLy/EIbDDASXYgx1N9neWTvA7r2fGgB6Ram2rWeAe1YrfAtlcfy8
	wwfOFzXocBd8Z0W7NA8jrn9cHAO7OhfaY/5ZriS/jmiH4tZRzWVOWpx8QUJfXTLA
	gyVWgOjZ7tP0MiI8vnu46iBBTPLOM6ywtH7uujQMgnWfhJvJ0hEp9BAmIIaMTAhH
	X4D+tcpYqpTsMOrhEIuDyLJa5Z5rBuzsiaCGm0RCL9IIf8QtU+FHgHuNpyPuMPQx
	jH+uBQgahirt8dZKazAQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y4sxv4f6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 10:00:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3999440044;
	Thu, 16 May 2024 09:59:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 39B872122F0;
	Thu, 16 May 2024 09:58:48 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 09:58:47 +0200
Message-ID: <5544e11b-25a8-4465-a7cc-f1e9b1d0f0cc@foss.st.com>
Date: Thu, 16 May 2024 09:58:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] ARM: dts: stm32: add ethernet1 and ethernet2 for
 STM32MP135F-DK board
To: Marek Vasut <marex@denx.de>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-11-christophe.roullier@foss.st.com>
 <43024130-dcd6-4175-b958-4401edfb5fd8@denx.de>
 <8bf3be27-3222-422d-bfff-ff67271981d8@foss.st.com>
 <9c1d80eb-03e7-4d39-b516-cbcae0d50e4a@denx.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <9c1d80eb-03e7-4d39-b516-cbcae0d50e4a@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_03,2024-05-15_01,2023-05-22_02

Hi

On 5/16/24 02:23, Marek Vasut wrote:
> On 5/13/24 6:01 PM, Alexandre TORGUE wrote:
>> Hi Marek
> 
> Hi,
> 
>> On 4/26/24 17:44, Marek Vasut wrote:
>>> On 4/26/24 2:57 PM, Christophe Roullier wrote:
>>>> Add dual Ethernet:
>>>> -Ethernet1: RMII with crystal
>>>> -Ethernet2: RMII without crystal
>>>> PHYs used are SMSC (LAN8742A)
>>>>
>>>> With Ethernet1, we can performed WoL from PHY instead of GMAC point
>>>> of view.
>>>> (in this case IRQ for WoL is managed as wakeup pin and configured
>>>> in OS secure).
>>>
>>> How does the Linux PHY driver process such a PHY IRQ ?
>>>
>>> Or is Linux unaware of the PHY IRQ ? Doesn't that cause issues ?
>>
>> In this case, we want to have an example to wakeup the system from 
>> Standby low power mode (VDDCPU and VDD_CORE off) thanks to a magic 
>> packet detected by the PHY. The PHY then assert his interrupt output 
>> signal.
>> On MP13 DK platform, this PHY signal is connected to a specific GPIO
>> aka "Wakeup pins" (only 6 wakeup pins an MP13). Those specific GPIOs 
>> are handled by the PWR peripheral which is controlled by the secure OS.
> 
> What does configure the PHY for this wakeup mode ?

Linux device tree.

> 
>> On WoL packet, the Secure OS catches the PHY interrupt and uses 
>> asynchronous notification mechanism to warn Linux (on our platform we 
>> use a PPI). On Linux side, Optee core driver creates an irq 
>> domain/irqchip triggered on the asynchronous notification. Each device 
>> which use a wakeup pin need then to request an IRQ on this "Optee irq 
>> domain".
>>
>> This OPTEE irq domain will be pushed soon.
> 
> I suspect it might make sense to add this WoL part separately from the 
> actual ethernet DT nodes, so ethernet could land and the WoL 
> functionality can be added when it is ready ?

If at the end we want to have this Wol from PHY then I agree we need to 
wait. We could push a WoL from MAC for this node before optee driver 
patches merge but not sure it makes sens.

Alex

