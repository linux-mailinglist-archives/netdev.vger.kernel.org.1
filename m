Return-Path: <netdev+bounces-208647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336C4B0C85C
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B45189A044
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3AF2DFF17;
	Mon, 21 Jul 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UvbfVzpu"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48CA1A5BA4;
	Mon, 21 Jul 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113617; cv=none; b=bD5DhypN4nhkIor0H7lgkuZnKRd3LiEsidOXLh+t5IzSpTOzOjaXg7QCWjwLrav1ZR+fb9bkXSBN3Ugsw87QbrKpPVesbN9wE1I/NB2NciWfg4UY3dk0N/U5HqmyJj9aRmVnXIRtlOWz/6sQKzcjZkQL9nmwA9qwfNYgbm/Ii1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113617; c=relaxed/simple;
	bh=0u/FkNt313+bbH04ZJjnyQgStvvud8cR+f/8Ru2O9/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VjTyUuTZUY4uf3P3SKMSOSBE3+PxLv0Q4ba9uvpmNNIIDqLCQYLTaFnmaM72rTLfm9NbNLmbutB7kk+DrvrpIn89qQkUUeJByREKeMKRX79KdGqfPrP6fMo3r1sTSL29JBgiVy3eRfYdqIeq5++psX7S+Lbn30wmjEt8uk+tKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UvbfVzpu; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LF5RUS011179;
	Mon, 21 Jul 2025 17:59:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	rsxdTCztBKYXlx+C4LuG8AeZggJrpJdUJ0Xm76EVhB4=; b=UvbfVzpuufx4byKp
	qcX7btJ++p/Dy6hnVJx1aUaEKMxpo1BBXfeXWmxfbJ1FmZnGrmlKIR21eP62pD3a
	Xt7q5wtTkXo7k3/l9DPZMxYeZGnqnkFzbo+zlGTbs83v4JhpISvnaDaqs/c8+Fmz
	WPGuk9MwHDXlF/xKTKnQ+9ieU5I/cjaGcsjLlgk8fwEvlLy3TV9NKigRQP94CTKq
	XlIpIXEBxXv8/KMUp3Zyyf2HI8+58l6IR4Ykhgkbn31gV+Wytx78wXmnacjBM+sR
	cM4tNVzKKl8At5JokIGjLbSPJH9dDz9ksPFtC+etuglhlBKhOXmswwzs8MzbtcT6
	IbCvgw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48028g1d9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 17:59:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A0CE040046;
	Mon, 21 Jul 2025 17:58:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 34BFE76EA8F;
	Mon, 21 Jul 2025 17:56:19 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 17:56:18 +0200
Message-ID: <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
Date: Mon, 21 Jul 2025 17:56:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
To: Andrew Lunn <andrew@lunn.ch>
CC: Krzysztof Kozlowski <krzk@kernel.org>,
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
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, Simon Horman
	<horms@kernel.org>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-1-89d262812dba@foss.st.com>
 <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01

Hello Andrew,

On 7/21/25 15:18, Andrew Lunn wrote:
> On Mon, Jul 21, 2025 at 02:10:48PM +0200, Gatien CHEVALLIER wrote:
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
>>
>> For the WoL from PHY to be supported, the PHY line that is raised
>> (On nPME pin for this case) when receiving a wake up event has to be
>> wired to a wakeup event input of the Extended interrupt and event
>> controller(EXTI), and that's implementation dependent.
> 
> How does this differ from normal interrupts from the PHY? Isn't the
> presence of an interrupt in DT sufficient to indicate the PHY can wake
> the system?
> 
> 	Andrew

Here's an extract from the Microchip datasheet for the LAN8742A PHY:

"In addition to the main interrupts described in this section, an nPME
pin is provided exclusively for WoL specific interrupts."

I'm not an expert of the different PHYs, but I guess there may be a
distinction needed between some "main" PHY interrupts and the WoL one
at least for deep low-power use cases.

Because this line is wired to a peripheral managed by our
TEE, the ultimate goal here would be to declare the OP-TEE node as
an interrupt provider and to forward the interrupt to the kernel using
the asynchronous notification mechanism. Then, reference the OP-TEE
node in the "interrupts-extended" property in the PHY node so that it
can be acked by the PHY driver. As of now, this patch set at least allow
to wakeup from a deep low power mode using the WoL capability of the
PHY.

Regarding this property, somewhat similar to "mediatek,mac-wol",
I need to position a flag at the mac driver level. I thought I'd go
using the same approach.

Best regards,
Gatien




