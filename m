Return-Path: <netdev+bounces-208600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D631B0C49E
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228673B213A
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 12:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24272D660F;
	Mon, 21 Jul 2025 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0GGCxJo2"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E12D5A1A;
	Mon, 21 Jul 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102677; cv=none; b=mZPnObAeOk2xWZP3qnzHI6tSflYPE9lISUGK01bcJRpsjLVscoXCZELbl/YXfdZu1qgk6qWMMeT9491PTWdm/zgLi2hdPkKxdrp6umyW0Rx+Hg9FFz3dOf9eqSVfTVMu7TLzggs9pecuBTEPMvDEP57oNhRoT3/ciMwmXOc3nLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102677; c=relaxed/simple;
	bh=OuazLhBqqrXrceWtDPZrgryjzxWcncFwL5s0O5K+RK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gGdIwLPeJBlxZqK7YvSKLAKclN4XwWRH/6U5Cfvhmq78bB2+ROexTWg61tOW/wFiI9H5PXDdcRrsb3Y9Ywjc7wP6pW4VQNqG/AD8JUulBsEmXMjpYnx5cujn7f4BxbWnF5Q4p2/D8lUi6ma7bHxQrsgiV0STSldJbP2m59LlKLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0GGCxJo2; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LBu24b002202;
	Mon, 21 Jul 2025 14:57:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	QrwPvtm0Y3jVd4A8YMJUm1x2eIlSHpKGIqbTIjvz8DE=; b=0GGCxJo2waUxHJ5n
	tpo0ZXAtI2x1IQX/mSnLBB2UWXUm8KIM1YYSdht2vwrAt8hPJ60gHkJ9BkepTsne
	S6KPhuKi4YiazGtGYy5f5sIGs+ghPVjqj9+9VKWwaThEd7P9mYmLu8eNGwEF+kuH
	VU323u+2uJqOfjh4cDh4NednVsafixyjGv9DsnOex5IwjRzRjQ9LH40CI/E6S/VG
	hMXz2PONOqf/yvjBjBmz48SmTtMEoo8sKfROTPM2HNWb434oTuu/G2B2AM+6HQJa
	lV06ykGVAFC8KcrkY6CBGg3schMPNtzYlYSC24vAmGVdCLnhnZbGadm1S2SADXcV
	G62OpQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4802q211x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 14:57:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BDF4C40057;
	Mon, 21 Jul 2025 14:56:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5B8B37A63A1;
	Mon, 21 Jul 2025 14:54:41 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 14:54:40 +0200
Message-ID: <5c7dd351-2fca-4a96-b911-c79d326d82df@foss.st.com>
Date: Mon, 21 Jul 2025 14:54:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
	<linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
        Tristram Ha
	<Tristram.Ha@microchip.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-1-89d262812dba@foss.st.com>
 <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <b220ae01-81b5-47f1-bf99-9aa0903995e1@kernel.org>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <b220ae01-81b5-47f1-bf99-9aa0903995e1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_01,2025-03-28_01



On 7/21/25 14:16, Krzysztof Kozlowski wrote:
> On 21/07/2025 14:10, Gatien CHEVALLIER wrote:
>> Hello Krzysztof,
>>
>> On 7/21/25 13:30, Krzysztof Kozlowski wrote:
>>> On 21/07/2025 13:14, Gatien Chevallier wrote:
>>>> The "st,phy-wol" property can be set to use the wakeup capability of
>>>> the PHY instead of the MAC.
>>>
>>>
>>> And why would that be property of a SoC or board? Word "can" suggests
>>> you are documenting something which exists, but this does not exist.
>> Can you elaborate a bit more on the "not existing" part please?
> 
> 
> Where does this property exist that you suggest that a new binding "can"
> use it?
> 

I'm not sure if you're only targeting the wording here?

I found this property: "mediatek,mac-wol". Its non-presence sets the
same flag AFAICT.

I need to set the flag so that the stmmac_set_wol() in
drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c eventually
reaches the PHY driver.

>>
>> For the WoL from PHY to be supported, the PHY line that is raised
>> (On nPME pin for this case) when receiving a wake up event has to be
>> wired to a wakeup event input of the Extended interrupt and event
>> controller(EXTI), and that's implementation dependent.
> 
> 
> So it is not "can" but some implementations do not have proper wiring.
> You need to justify your commits and changes.
> 

Ok, does:
In case of proper wiring from the PHY to a wake up event input,
set the "st,phy-wol" to indicate that the PHY WoL capability is
preferred over the MAC one.

seems better?

> 
> 
> Best regards,
> Krzysztof

