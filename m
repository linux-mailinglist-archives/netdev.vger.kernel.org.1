Return-Path: <netdev+bounces-209266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9A3B0EDAF
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FBF963D9F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC2327BF6C;
	Wed, 23 Jul 2025 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NGLzIj42"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2ADAD23;
	Wed, 23 Jul 2025 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260831; cv=none; b=Mh6IduHo2jsRPIHybcLiLzpalznIpSt/TwbwtVeZz90NvWP+lR50Fz7IYOIAinlFSpsbo/UtoitC+/i+JYKZC46wmXSHuXpAzez3p1Li1mJW1rMWVa17r0jxvNCMJa4WRcHjUCTH8PbDAoPBp8zcBvN9gId5khX1ip1IBEQ8GJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260831; c=relaxed/simple;
	bh=9zjnLbtffxuB1uYUoa7iv5uHmX241oAFDS3Lz8Acxg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ahICndmaTGOjv9yxdjqkOLXb1Oc4bGnlBGOeFv5NER+Eun3A6etmYT4wyR2RZV+Wr7RvkzacLvfDBGuyWnw+xTqxL01VN9KjIPsrw5bpwKuO4ll1mBX/+5850RAbAjl+3h0Y+KT5AMLkXLAqkJpts5UA5pUD9HyJ3DjAYX5kX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NGLzIj42; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N7jtjo016500;
	Wed, 23 Jul 2025 10:53:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	4omO8HrdTU5rt9OTERdVAhBxw0f+jenWpse03kloZAo=; b=NGLzIj42a45+DaYo
	zBEiznaFEhrArWn2NvFbdNTP11qNhuvqRLdGcpdMF4qM4n4nh4R7WJweUfYkr33O
	9gCPYAWixsAyCf3xWopkU06LTz9qEIfUIoqnj2Jm88m4C0qlx4ocxmp2yA+Phd10
	gFh1GtiEFenBCNi4I/x36MR5cK+waLthkA9AabGnWm5OAbOpzCQbHC2GCBSobTu7
	fuELMq4j4EPBNKwN80aB6F6TvCuqdjTyMqk0E4u2gQvVxbo0rHQcWCWV3qe+40NY
	GVaQribBqTVIgD8d2rf7b/wDMnAUh/U4WpSkD/8BxIGrHVcG8PEdwsqsAQs7Kzvx
	alDexA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 480pamyj52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 10:53:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 394D740046;
	Wed, 23 Jul 2025 10:51:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B5D4F775480;
	Wed, 23 Jul 2025 10:50:18 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 10:50:17 +0200
Message-ID: <5a2e0cd8-6d20-4f5a-a3a0-9010305509e3@foss.st.com>
Date: Wed, 23 Jul 2025 10:50:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn
	<andrew@lunn.ch>
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
        Simon Horman <horms@kernel.org>,
        Tristram Ha
	<Tristram.Ha@microchip.com>,
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
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
 <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
 <383299bb-883c-43bf-a52a-64d7fda71064@foss.st.com>
 <2563a389-4e7c-4536-b956-476f98e24b37@lunn.ch>
 <aH_yiKJURZ80gFEv@shell.armlinux.org.uk>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <aH_yiKJURZ80gFEv@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01



On 7/22/25 22:20, Russell King (Oracle) wrote:
> On Tue, Jul 22, 2025 at 03:40:16PM +0200, Andrew Lunn wrote:
>> I know Russell has also replied about issues with stmmac. Please
>> consider that when reading what i say... It might be not applicable.
>>
>>> Seems like a fair and logical approach. It seems reasonable that the
>>> MAC driver relies on the get_wol() API to know what's supported.
>>>
>>> The tricky thing for the PHY used in this patchset is to get this
>>> information:
>>>
>>> Extract from the documentation of the LAN8742A PHY:
>>> "The WoL detection can be configured to assert the nINT interrupt pin
>>> or nPME pin"
>>
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/power/wakeup-source.txt
>>
>> It is a bit messy, but in the device tree, you could have:
>>
>>      interrupts = <&sirq 0 IRQ_TYPE_LEVEL_LOW>
>>                   <&pmic 42 IRQ_TYPE_LEVEL_LOW>;
>>      interrupt-names = "nINT", "wake";
>>      wakeup-source
>>
>> You could also have:
>>
>>      interrupts = <&sirq 0 IRQ_TYPE_LEVEL_LOW>;
>>      interrupt-names = "wake";
>>      wakeup-source
>>
>> In the first example, since there are two interrupts listed, it must
>> be using the nPME. For the second, since there is only one, it must be
>> using nINT.
>>
>> Where this does not work so well is when you have a board which does
>> not have nINT wired, but does have nPME. The phylib core will see
>> there is an interrupt and request it, and disable polling. And then
>> nothing will work. We might be able to delay solving that until such a
>> board actually exists?
> 
> (Officially, I'm still on vacation...)
> 
> At this point, I'd like to kick off a discussion about PHY-based
> wakeup that is relevant to this thread.
> 
> The kernel has device-based wakeup support. We have:
> 
> - device_set_wakeup_capable(dev, flag) - indicates that the is
>    capable of waking the system depending on the flag.
> 
> - device_set_wakeup_enable(dev, flag) - indicates whether "dev"
>    has had wake-up enabled or disabled depending on the flag.
> 
> - dev*_pm_set_wake_irq(dev, irq) - indicates to the wake core that
>    the indicated IRQ is capable of waking the system, and the core
>    will handle enabling/disabling irq wake capabilities on the IRQ
>    as appropriate (dependent on device_set_wakeup_enable()). Other
>    functions are available for wakeup IRQs that are dedicated to
>    only waking up the system (e.g. the WOL_INT pin on AR8031).
> 
> Issue 1. In stmmac_init_phy(), we have this code:
> 
>          if (!priv->plat->pmt) {
>                  struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
> 
>                  phylink_ethtool_get_wol(priv->phylink, &wol);
>                  device_set_wakeup_capable(priv->device, !!wol.supported);
>                  device_set_wakeup_enable(priv->device, !!wol.wolopts);
>          }
> 
> This reads the WoL state from the PHY (a different struct device)
> and sets the wakeup capability and enable state for the _stmmac_
> device accordingly, but in the case of PHY based WoL, it's the PHY
> doing the wakeup, not the MAC. So this seems wrong on the face of
> it.

2 cents: Maybe even remove in stmmac_set_wol() if !priv->plat->pmt.

> 
> Issue 2. no driver in phylib, nor the core, ever uses any of the
> device_set_wakeup_*() functions. As PHYs on their own are capable
> of WoL, isn't this an oversight? Shouldn't phylib be supporting
> this rather than leaving it to MAC drivers to figure something out?
> 
> Issue 3. should pins like WOL_INT or nPME be represented as an
> interrupt, and dev_pm_set_dedicated_wake_irq() used to manage that
> interrupt signal if listed as an IRQ in the PHY's DT description?
> 
> (Side note: I have tried WoL on the Jetson Xavier NX board I have
> which uses stmmac-based WoL, but it seems non-functional. I've
> dropped a private email to Jon and Thierry to see whether this is
> expected or something that needs fixing. I'm intending to convert
> stmmac to use core wakeirq support, rather than managing
> the enable_irq_wake()/disable_irq_wake() by itself.)
> 

