Return-Path: <netdev+bounces-210744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B88B14A5B
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 10:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499547AA0B0
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 08:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F562868B2;
	Tue, 29 Jul 2025 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XwF5dllE"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9624F286888
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778782; cv=none; b=IkLq5r5IyTuTtWD0mZ6BRqIMSgXErDSfcVVpYLdNFnEeox16Vd4NhB3Fn97FTNA1J4Aqa7CR/7GSrhRxv4EZTTIkYN6pONxL+wkFXPRo66L0jhLanKktWaMABIebwMm7bgs8mzOfec70UgyFxnCwcKahkxyD7BS6s2YYdL8rTf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778782; c=relaxed/simple;
	bh=WY2UlMLKeLmqAMB/yJuFTN4pS7HC8+jweYlnwQXzRaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xl3uryr+3/m13y12gEwOmbvQyRgP9QfGV+Ic7jdbJzNMv3t87TW5uLA1AyD7mcotWLYIooETBtbhjla6Qf9Qs1BkYQ4iV9djKETA2RyxegwzYIhMa4YCVWBSThGz7f2c9uDuy8nBQggsSCLx4kuiDzEid8rbo0mxl+qAyoIefqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XwF5dllE; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T8YNat014089;
	Tue, 29 Jul 2025 10:45:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	dZOnwyJc/z92LBdcHXh09X96k4RSZO3Wfpl7wZweE1U=; b=XwF5dllEtECZLCeq
	JJifgyRlhmk9xDJChmramDEt0vbuK5xkHgtWAt+3NgJRIN5ptXyhNVShV476LLg4
	Ee384LrKR+nfpswuEJva/XjMRNXgsvo8hbbP8LVl9MEDHrSmFyqzQawtuzsnCBjW
	3tndnxRP71fnGUcb/gyVjYA66+Zh5ibkl7EA3Dwq1WXEiz+S+B4vFuf6ZYMSZY4a
	q2laWBj7+d7G208HtTSG+/dDfiFNciLpIqJn7mK7GVivJFGpcouiB626sSwu1a+Y
	57NhNXArM0o9iq4tAasVLMKdxTWdv5qOCH4m8r6AcB4fgaYCSQk3rJK517Rg2EFg
	7ivAsw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4858k51a3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 10:45:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 53DFD4004D;
	Tue, 29 Jul 2025 10:44:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8DA065F4E65;
	Tue, 29 Jul 2025 10:43:33 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 10:43:32 +0200
Message-ID: <77229e46-6466-4cd4-9b3b-d76aadbe167c@foss.st.com>
Date: Tue, 29 Jul 2025 10:43:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH RFC net-next 6/7] net: stmmac: add helpers
 to indicate WoL enable status
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn
	<andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>,
        Heiner
 Kallweit <hkallweit1@gmail.com>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ33-006KDR-Nj@rmk-PC.armlinux.org.uk>
 <eaef1b1b-5366-430c-97dd-cf3b40399ac7@lunn.ch>
 <aIe5SqLITb2cfFQw@shell.armlinux.org.uk>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <aIe5SqLITb2cfFQw@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01



On 7/28/25 19:54, Russell King (Oracle) wrote:
> On Mon, Jul 28, 2025 at 07:28:01PM +0200, Andrew Lunn wrote:
>>> +static inline bool stmmac_wol_enabled_mac(struct stmmac_priv *priv)
>>> +{
>>> +	return priv->plat->pmt && device_may_wakeup(priv->device);
>>> +}
>>> +
>>> +static inline bool stmmac_wol_enabled_phy(struct stmmac_priv *priv)
>>> +{
>>> +	return !priv->plat->pmt && device_may_wakeup(priv->device);
>>> +}
>>
>> I agree this is a direct translation into a helper.
>>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>
>> I'm guessing at some point you want to change these two
>> helpers. e.g. at some point, you want to try getting the PHY to do the
>> WoL, independent of !priv->plat->pmt?
>>
>>> -	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
>>> +	if (stmmac_wol_enabled_phy(priv))
>>>   		phylink_speed_down(priv->phylink, false);
>>
>> This might be related to the next patch. But why only do speed down
>> when PHY is doing WoL? If the MAC is doing WoL, you could also do a
>> speed_down.
> 
> No idea, but that's what the code currently does, and, as ever with
> a cleanup series, I try to avoid functional changes in cleanup series.
> 
> Also, bear in mind that I can't test any of this.
> 
> We haven't yet been successful in getting WoL working in mainline. It
> _seems_ that the Jetson Xaiver NX platform should be using PHY mode,
> but the Realtek PHY driver is definitely broken for WoL. Even with
> that hacked, and along with other fixes that I've been given, I still
> can't get the SoC to wake up via WoL. In fact, the changes to change
> DT to specify the PHY interrupt as being routed through the PM
> controller results in normal PHY link up/down interrupts no longer
> working.
> 
> I'd like someone else to test functional changes!
> 

Hello Russel,

First of all, thank you for taking the time to improve this code.
What exactly do you mean by hacking? Forcing !priv->plat->pmt?

