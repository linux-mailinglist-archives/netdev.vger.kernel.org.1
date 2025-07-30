Return-Path: <netdev+bounces-211011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E78B162BB
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AE91AA1AA1
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726BB2D9797;
	Wed, 30 Jul 2025 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="66Jzwt4p"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95485263F4E
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885643; cv=none; b=OwaosAl5/o3BTH1alxCVIazm+Be58TGH/5ohoexIqjstQWYnGUbs7Nx1RVZwD2H475WXiUWxV0GKwh5coa8SsKK3fFylxvTIOOkVdJbuYgFiKxR80qDEJR7hUhtRmaUkBmqhFNIR8Kpvdr64UtipZJoBJC9rJrPi5sAnu7wGktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885643; c=relaxed/simple;
	bh=IEsS3GavQBhmr4Hn9d18D5V5BjU9JyYWit6IcLcch70=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Eb1P/EGyNDDciAyEcYfPcu+Bv13/3iPUw+cIr7ddS/7LvvO0GSMWdm1o59tj8NT5TVVD9gxFP1qJ7hVJqL9uF2JtBtZGWBeyfkJbcGVp8Rz2s02A0nowkl8L1fz7pIU8frHlbpE0av71QaY9z3a6Apsq9cbmCzBFfZj+2d7+iNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=66Jzwt4p; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UE7Bjh009376;
	Wed, 30 Jul 2025 16:26:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	DZZ4GqXf7y47QZhCRNieA0XxG6Nm7i3hAzMzrvoMRKA=; b=66Jzwt4p9aAqWnZa
	jovznjSoYBObAC4bQxUq+uqX3ebgx9xgDeF3+gFrROWR00m0soKjXhjnuKJ+lZTy
	dJPravJ4nrbuRAqrkOmfxxtrPt45zT4OWwO+xw5iWFbm56XhYOXdCoxue9hIDd32
	Lybet95DfnapTMoa1kvBdJyGqkIiHECHi1LXoRbf5rIsp5PJonzTZXj7w3vWhWR5
	Gjb1PfDB9ahzOa+0kvz78K3i8DhQVsWKGCtJdgJyUmT6NsZcNMImyT28StJVTT34
	sdnmmhvTZMvK5yDRxNK7RL7c+kp3y0c/0HB/XyZToDBFQhYCiDx814NK8Dr4W4ne
	6scPvQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484pc2jm7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 16:26:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 10E7E40053;
	Wed, 30 Jul 2025 16:25:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9C4BC787C1B;
	Wed, 30 Jul 2025 16:24:33 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:24:32 +0200
Message-ID: <27e10ba4-5656-40a8-a709-c1390fee251f@foss.st.com>
Date: Wed, 30 Jul 2025 16:24:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC ???net???] net: phy: realtek: fix wake-on-lan support
To: Andrew Lunn <andrew@lunn.ch>,
        "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>
CC: Heiner Kallweit <hkallweit1@gmail.com>,
        Daniel Braunwarth
	<daniel.braunwarth@kuka.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>,
        <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Thierry Reding <treding@nvidia.com>
References: <E1uh2Hm-006lvG-PK@rmk-PC.armlinux.org.uk>
 <a14075fe-a0fc-4c59-b4d3-1060f6fd2676@lunn.ch>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <a14075fe-a0fc-4c59-b4d3-1060f6fd2676@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01



On 7/30/25 15:59, Andrew Lunn wrote:
>> 2. detect whether we can support wake-up by having a valid interrupt,
>>     and the "wakeup-source" property in DT. If we can, then we mark
>>     the MDIO device as wakeup capable, and associate the interrupt
>>     with the wakeup source.
> 
> We should document "wakeup-source" in ethernet-phy.yaml.
> 

+1

> What are the different hardware architectures?
> 
> 1) A single interrupt line from the PHY to the SoC, which does both
> link status and WoL.
> 
> 2) The PHY has a dedicated WoL output pin, which is connected to an
> interrupt.
> 
> 3) The PHY has a dedicated WoL output pin, which is connected directly
> to a PMIC. No software involved, the pin toggling turns the power back
> on.
> 

Just my 2 cents:

In some cases like the LAN8742, there are some flags that need to be
cleared when waking up in order to be able to handle another WoL event.
It can be done either in the suspend()/resume() or in an interrupt
handler of the PHY. In 3) This suggests that the interrupt is somehow
forwarded to the Linux kernel.

This is what I was ultimately trying to do in two steps with the TEE
notifying the kernel of that interrupt.

Moreover, if a WoL event occurs when the system is not in a low-power
mode, then the flags will never be cleared and another WoL event cannot
be detected while the system is in a low-power mode.

Maybe we can argue that these flags can be cleared in suspend() and
and resume(). But then, if there's no interrupt to be handled by the
kernel, how do we know that we have woken up from a WoL event?

IMHO, I think 3) may optionally declare another interrupt as well
for WoL events.

Eventually, 2) and 3) would have 1 interrupt(WoL) if PHY is in polling
mode and 2 if not?

Please tell me if that makes any sense to you or if I missed something.

> For 1), i don't think 'wakeup-source' tells us anything useful. The
> driver just needs to check that interrupts are in use.
> 
> For 2) we should recommend that the wakeup interrupt is called
> "wakeup", following wakeup-source.txt, and the "wakeup-source"
> property is present.
> 
> For 3) its more magical, there is no interrupt properties involved, so
> we do need the "wakeup-source" to know that the pin is actually
> connected to something.
> 
> We need to differentiate between drivers newly getting WoL support,
> and existing drivers. We can be much more strict with new support.
> 
> 	Andrew

