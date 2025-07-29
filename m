Return-Path: <netdev+bounces-210832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A10B1503D
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AF73AF2B8
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F316293C47;
	Tue, 29 Jul 2025 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nbYnA8Xp"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DA4C62
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803445; cv=none; b=JWP+7BlP0LsLR/rys2P/wpqccjZda1SD+zBV/qJsCILIlHMvC8mBkWlxWLpDaF+1AMv7pQ6N8jdPpWePsL4K32ZcIUZbbPwMVM+xMVKAKM3YhX1lLyhjq2M6HEeSfjvCdqrsFLis/T/JKASZhqEbVuAfmARJZrHj4NeTcr9OJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803445; c=relaxed/simple;
	bh=PEHyEjN0ADaz5kET3fFfZncZHo4XCyw5ZkHyELvU72c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nChb8YfFdKqh/0TRSpZ3iEWjtLVhEAlXF9z+59bxLtoGnhtWc1oIuM3zY6WN+FdNDVlzYz1QHJ0D+IMPEHk87/CsRYkeEx/KcKtEh/MFpp/i62Vp61UelasZhG+voka0y0NPSLG5HGshx8aJgf3UUe+ed5nFHZGoS2L7EAKlp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nbYnA8Xp; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TDmAM5017943;
	Tue, 29 Jul 2025 17:37:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	6QqV7V0tO5OxA4sByxR+cgSgc3c8gdKE4nRdb/3tQco=; b=nbYnA8XpRf1fY3nQ
	BmZSCmVbXeZojxlvIrPSmVWLJM+N/dwW8puHyD5dzhA23IRcFijCyILdmwDQuQmk
	jgA3M3+ZgluhThgK0mwolAGs/4VoEuE7TQ7VUraLRS1bNdewXYP0j1SUbpBAkMBO
	OGwLFE4DEDcMb3VydAcNYBT9Uu/pMGtRbpk/KuFf3OvX0wzR0qHcV89M/b1Yb50/
	VRMCDaA1Fb93dHaUSlq0mrdG5YphzF5vHu+UrrVlzo+AFJMT/ZvYe//8L61V8n8D
	YtaQb6fdQSS18+TXn6/ApB7b3D4N+dXCnql0457taRapEFXJHOYDAHUNeDIpvQHN
	wVzaQw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484memp190-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 17:37:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 620F840049;
	Tue, 29 Jul 2025 17:35:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 327B977F2C9;
	Tue, 29 Jul 2025 17:34:50 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 17:34:49 +0200
Message-ID: <186a2265-8ca8-4b75-b4a2-a81d21ca42eb@foss.st.com>
Date: Tue, 29 Jul 2025 17:34:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH RFC net-next 6/7] net: stmmac: add helpers
 to indicate WoL enable status
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ33-006KDR-Nj@rmk-PC.armlinux.org.uk>
 <eaef1b1b-5366-430c-97dd-cf3b40399ac7@lunn.ch>
 <aIe5SqLITb2cfFQw@shell.armlinux.org.uk>
 <77229e46-6466-4cd4-9b3b-d76aadbe167c@foss.st.com>
 <aIiOWh7tBjlsdZgs@shell.armlinux.org.uk>
 <aIjCg_sjTOge9vd4@shell.armlinux.org.uk>
 <d300d546-09fa-4b37-b8e0-349daa0cc108@foss.st.com>
 <aIjePMWG6pEBvna6@shell.armlinux.org.uk>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <aIjePMWG6pEBvna6@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01



On 7/29/25 16:44, Russell King (Oracle) wrote:
> On Tue, Jul 29, 2025 at 03:10:56PM +0200, Gatien CHEVALLIER wrote:
>>
>>
>> On 7/29/25 14:45, Russell King (Oracle) wrote:
>>> On Tue, Jul 29, 2025 at 10:03:22AM +0100, Russell King (Oracle) wrote:
>>>> With Thierry's .dts patch, PHY interrupts completely stop working, so
>>>> we don't get link change notifications anymore - and we still don't
>>>> seem to be capable of waking the system up with the PHY interrupt
>>>> being asserted.
>>>>
>>>> Without Thierry's .dts patch, as I predicted, enabling WoL at the
>>>> PHY results in Bad Stuff happening - the code in the realtek driver
>>>> for WoL is quite simply broken and wrong.
>>>>
>>>> Switching the pin from INTB mode to PMEB mode results in:
>>>> - No link change interrupts once WoL is enabled
>>>> - The interrupt output being stuck at active level, causing an
>>>>     interrupt storm and the interrupt is eventually disabled.
>>>>     The PHY can be configured to pulse the PMEB or hold at an active
>>>>     level until the WoL is cleared - and by default it's the latter.
>>>>
>>>> So, switching the interrupt pin to PMEB mode is simply wrong and
>>>> breaks phylib. I guess the original WoL support was only tested on
>>>> a system which didn't use the PHY interrupt, only using the interrupt
>>>> pin for wake-up purposes.
>>>>
>>>> I was working on the realtek driver to fix this, but it's pointless
>>>> spending time on this until the rest of the system can wake up -
>>>> and thus the changes can be tested. This is where I got to (and
>>>> includes work from both Thierry and myself, so please don't pick
>>>> this up as-is, because I can guarantee that you'll get the sign-offs
>>>> wrong! It's a work-in-progress, and should be a series for submission.)
>>>
>>> Okay, with this patch, wake-up now works on the PHY interrupt line, but
>>> because normal interrupts aren't processed, the interrupt output from
>>> the PHY is stuck at active level, so the system immediately wakes up
>>> from suspend.
>>>
>>
>> If I'm following correctly, you do not use the PMEB mode and share
>> the same pin for WoL and regular interrupts (INTB mode)?
> 
> As the driver is currently structured, switching the pin to PMEB mode
> in .set_wol() breaks phylib, since as soon as one enables WoL at the
> PHY, link state interrupts are no longer delivered.
> 
> It may be appropriate to switch the pin to PMEB mode in the suspend
> method while waiting for a wakeup but we need code in place to deal
> with the resulting interrupt storm (by clearing the wakeup) and that
> code is missing.
> 
> The other approach would be to leave the pin in INTB mode, and
> reconfigure the interrupt enable register (INER) to allow WoL
> interrupts, maybe disabling link state interrupts (more on that
> below.) This has the advantage that reading the interrupt status
> register clears the interrupt - and that code already exists so we
> avoid the interrupt storm.
> 
>>> Without the normal interrupt problem solved, there's nothing further
>>> I can do on this.
>>>
>>> Some of the open questions are:
>>> - whether we should configure the WoL interrupt in the suspend/resume
>>>     function
>>
>> For the LAN8742 PHY with which I worked with, the recommendation when
>> using the same pin for WoL and regular interrupt management is to mask
>> regular interrupt and enable the WoL IIRC.
> 
> That's only really appropriate if the MAC isn't involved in WoL. Let's
> say that the PHY can support magic-packet WoL, but the MAC can also
> support unicast frame WoL, and the user has enabled both.
> 

Oops, just saw that I mispronounced your name in a previous message,
sorry for that.

For STMMAC:
I'm a bit lost there. I may be missing something. I thought that using
PHY WoL (therefore having STMMAC_FLAG_USE_PHY_WOL) superseded the MAC
WoL usage.

In stmmac_hw_init():

if (priv->plat->pmt) {
         dev_info(priv->device, "Wake-Up On Lan supported\n");
         device_set_wakeup_capable(priv->device, 1);
}

but above:

priv->plat->pmt = priv->dma_cap.pmt_remote_wake_up &&
!(priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL);

Then, in stmmac_set_wol(), it's either set the WoL for the
PHY or the MAC?

Can you point me to the part I'm missing please?

> The system goes to sleep (e.g. overnight) and during the night, there's
> a hiccup which causes the link to drop and re-establish at a slower
> speed.
> 
> Since the MAC has not been reconfigured (because the link state
> interrupt is disabled, and thus won't wake the system) the MAC can now
> no longer receive unicast frames to check whether they match the
> despired system wakeup condition.
> 
> So, this poses another question: do we really want to support
> simultaneous PHY and MAC level WoL support, or should we only allow
> one or other device to support WoL?
> 
> If we explicitly deny the WoL at both approach, then we don't have
> to care about link state interrupts, because the PHY will be able
> to cope with the different link speed without needing to wake the
> iystem to reconfigure the network interface for the new link
> parameters.
> 
>> This prevents the PHY from waking up from undesired events while still
>> being able use the WoL capability and should be done in suspend() /
>> resume() callbacks. I guess this means also that you share the same
>> interrupt handler that must manage both WoL events and regular events.
>>
>> On the other hand, on the stm32mp135f-dk, the nPME pin (equivalent to
>> PMEB IIUC) is wired and is different from the nINT pin. Therefore, I
>> guess it should not be done during suspend()/resume() and it really
>> depends on how the PHY is wired. Because if a WoL event is received at
>> runtime, then the PHY must clear the flags otherwise the WoL event won't
>> trigger a system wakeup afterwards.
>>
>> I need to look at how the PHYs can handle two different interrupts.
> 
> The RTL8211F only has one pin (pin 31) which can be used in INTB mode
> or PMEB mode. You can't have independent interrupt and wakeup signals
> with this PHY.
> 

