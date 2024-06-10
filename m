Return-Path: <netdev+bounces-102191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73730901CB4
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3E0B22B31
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 08:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF834D8B7;
	Mon, 10 Jun 2024 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rZPTBWm0"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0DE21A0D;
	Mon, 10 Jun 2024 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007373; cv=none; b=sfWxg7Ruu5FXXHN8H9yIT0hMBWoyBaBXz4jaFJtbLMO0wX15gUJ9jVT4cu9+G6gdYlhy4PcIlYqUBOAKJHZglF104DE60wHgxKxe4M0+Vft4zDYFqATN3zKYs0OfT+kWKrRjxo/C3qKJQ4rxy6Qo2YQq4Wt/VyPC7HNtKUhQg6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007373; c=relaxed/simple;
	bh=rRQys8joHD9dH+r0LBeh4CsDcfuPa7n+yqWQ2JDoZlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cPpptO1ZRNgEmYNmaRl1Wv95bGxh+c1k0Z7XgkVXoZmtq7U6zawgBa0gvIQEKPwX/de5wXc848a/u77CW6wDbfa/aaGUf5RPILJBnLWnuPYl6XILFSjB1fAOHsE6VnAJEnJvrvkDln3xqDBKvMjgHyLI8kDKMaKM9kCKT/qvYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rZPTBWm0; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459LdCa7025381;
	Mon, 10 Jun 2024 10:15:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	luPvYi2+bdeQnMajOwT0mxxtNvrSHDJwHEH0GYgBZKI=; b=rZPTBWm0ZyRUTdUs
	WQGUpECn8E4EU1jCXf/0waiFKus+/i4Tmh5mvEjeN3RVZkjIMk5x53R459Hsnezh
	ig2jrKrG74gbb739nA5b/jD9wFs3JlBpUXqAwOnNGw1GCDt9fLfZJvP2HwvVnLEf
	GMu3rZkR/a/ADJbV9tgiG6h3ekCl8oVgA2zrOHVTqnSkFyv6k1A0UNXly0AzdAPM
	wx6mHzoQhLLdj6KlEfq3t1sjS1k92jQqIgfvHroQ7rrPU31o5aNqcbqaneK1ttRB
	xBiUlVIQJcNABkxgOgj8hkG62cSDyAyleV80Ob4btGGTl1wAKhffIybjXGG1eU4T
	FxyFyg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yme6d5nm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 10:15:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1CDB74002D;
	Mon, 10 Jun 2024 10:15:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 78892211F37;
	Mon, 10 Jun 2024 10:14:20 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 10 Jun
 2024 10:14:18 +0200
Message-ID: <ef4d2ebb-dd2a-423d-acd1-43fdb42c1896@foss.st.com>
Date: Mon, 10 Jun 2024 10:14:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
References: <20240610080604.291102-1-christophe.roullier@foss.st.com>
 <06703c03-e1ce-4a94-942d-b556c6084728@linaro.org>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <06703c03-e1ce-4a94-942d-b556c6084728@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01

Hi Krzysztof,

On 6/10/24 10:09, Krzysztof Kozlowski wrote:
> On 10/06/2024 10:06, Christophe Roullier wrote:
>> Enable MCP23S08 I/O expanders to manage Ethernet PHY
>> reset in STM32MP135F-DK board.
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> ---
>>   arch/arm/configs/multi_v7_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 86bf057ac3663..9758f3d41ad70 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -469,6 +469,7 @@ CONFIG_SPI_XILINX=y
>>   CONFIG_SPI_SPIDEV=y
>>   CONFIG_SPMI=y
>>   CONFIG_PINCTRL_AS3722=y
>> +CONFIG_PINCTRL_MCP23S08=y
> This is not an on-SoC pinctrl, so it should be module (=m).

The stmmac is in built-in, if IO-Expander (MCP23S08) is on module, we 
have huge of message during kernel boot

because stmmac driver is deferred several times. (need to wait that 
module are ready)

Thanks

>
> Best regards,
> Krzysztof
>

