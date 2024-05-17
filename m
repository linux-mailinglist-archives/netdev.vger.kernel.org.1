Return-Path: <netdev+bounces-96873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A518C817F
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD48BB21778
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 07:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1FD175AD;
	Fri, 17 May 2024 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FmnzMAo+"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11817597;
	Fri, 17 May 2024 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715931183; cv=none; b=pPmm9ZPRxz85Sm3lBGSmzRZyWTrhBydZ5voXQx40SwX02Wu7s8JzWUIopVlwHjm7diS4hB8QMaFU0OlKDr6+JLUSTfdh9QPC9UL5uBs61i3yJFbUX+UDmKMo2kx4xSytJS4ZaVbikFEMLmQrB5e6ASBBstMhKwoodAqz2qAnL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715931183; c=relaxed/simple;
	bh=wT0sXS5qVPDTxKJ3z9178RUaDjfMzjcAMh2Rwjp67Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nLebwQDz8YEdraKqgIoDK9znQoOeN4SpMhRzKnSy5YD5osVffCuCs1N6Qf1xEk32DNXzK7uFO70YZ9aq0hRtdvCZXZFMgXvBvpmvUDCXJ3q3ZwcUzKv89hgNy0lHkUTwI0baww39ZE1+aYkCn9FjbWXmXDH93lGOyKVmfG7cWKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FmnzMAo+; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44H79nsp009975;
	Fri, 17 May 2024 09:32:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=HvU8GeBGqT8dJ0UI3cbIoZdXlAiRynjiAUrWYrcXiCo=; b=Fm
	nzMAo+sq5wW9Us60uIDdHRpCnDqt/AMwCEk9CD5t6FbyMo+Uid38fgDFdb7ZqSZX
	bFUQceF3IRwSGworx6yugo0lElGR2Dq8ltHZP1z1vTQmawqBOR7IO6/vNw/38MVn
	Oe8Afsd2UXny0ZDqKun6M4vI2YAuoWx7Hh7MYnumZ/xZwSeI6JF+lVMkeYJG3qsP
	90RDHUpoQQH9ybIyoGmfGZI7BWzD6oDTSCFva8nVOD7dWpMBH6P1WrhQnaPD8JWZ
	Muws3mA0lmmmc3rSt+HSF9ZkX1JWdTBRKuo9oJ/eBiQ5IIsRbLk0jwK+/oyDHKhc
	9bE5ZnP+USB05o3YQZJg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y4sxv8ttk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 09:32:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B919740044;
	Fri, 17 May 2024 09:32:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0AC34211602;
	Fri, 17 May 2024 09:30:57 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 17 May
 2024 09:30:56 +0200
Message-ID: <f94d3cd6-df2a-4c2f-b09f-e424be63ccf7@foss.st.com>
Date: Fri, 17 May 2024 09:30:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] ARM: dts: stm32: add ethernet1 and ethernet2 for
 STM32MP135F-DK board
To: Andrew Lunn <andrew@lunn.ch>
CC: Marek Vasut <marex@denx.de>,
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
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-11-christophe.roullier@foss.st.com>
 <43024130-dcd6-4175-b958-4401edfb5fd8@denx.de>
 <8bf3be27-3222-422d-bfff-ff67271981d8@foss.st.com>
 <9c1d80eb-03e7-4d39-b516-cbcae0d50e4a@denx.de>
 <5544e11b-25a8-4465-a7cc-f1e9b1d0f0cc@foss.st.com>
 <4b17d7e4-c135-4d91-8565-9a8b2c6341d2@lunn.ch>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <4b17d7e4-c135-4d91-8565-9a8b2c6341d2@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02



On 5/16/24 14:22, Andrew Lunn wrote:
>>> I suspect it might make sense to add this WoL part separately from the
>>> actual ethernet DT nodes, so ethernet could land and the WoL
>>> functionality can be added when it is ready ?
>>
>> If at the end we want to have this Wol from PHY then I agree we need to
>> wait. We could push a WoL from MAC for this node before optee driver patches
>> merge but not sure it makes sens.
> 
> In general, it is better if the PHY does WoL, since the MAC can then
> be powered down. MAC WoL should only be used when the PHY does not
> support the requested WoL configuration, but the MAC can. And
> sometimes you need to spread it over both the PHY and the MAC.
>

thanks Andrew. So lets wait the optee driver missing part.

alex


> 	Andrew

