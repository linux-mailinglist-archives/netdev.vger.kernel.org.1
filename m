Return-Path: <netdev+bounces-208595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D92B0C414
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1BB3AE27A
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 12:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A682D3EC5;
	Mon, 21 Jul 2025 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="DAyLPBEA"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299573C0C;
	Mon, 21 Jul 2025 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100809; cv=none; b=Oy26WRXPsNVKLdteESUZwViDSRifKwpJ+WcAiHqSB++Kh8hcrfptNmFzPe8n42BBGMT2CPtUxmN6yiwr9yROIBJjmJISt6RgsCgeEgmrRFfji/AJExwesfswqXyLmOUBPKgy6NKvIx4ef72/ID9kPBAWN1m9eqIIEbaG5K/ZToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100809; c=relaxed/simple;
	bh=7SYBp9Zb4m3gELQ7tCurU5ja2w/hoGsVa4I9FvSKshg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YlUHBGA2M36ZcQtmZCD7I1cbQj4lGskUikaOtnb/Dw5EvmWjJXbKOxvK059kel8OOPV9beO8zTLksaf53tClYvijPHWaHEHCcevlOZU2fZp5rDmXqviW8DsDi5KRLEgsZcSAK1v3bjOpo63CY3xqr/ZumMttgGIcLgK5Eh7on9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=DAyLPBEA; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LCB6IN007054;
	Mon, 21 Jul 2025 14:26:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	fqiwAVutR1r5EQfU0bWFAUEcQiPbqDN4nQ+mORgbmZw=; b=DAyLPBEAplfXgm0X
	o93LZeJwbDtNejaod2Dtz+F0rJSKVcNuTfA8NE1KghKatYoZ3/0IcygcXYkoASoe
	zEN/P+q4CSd4zAqlViY2B+SC3gd82JhjD6eY0nDP+zDwI+9VHZQtpMx64ghQ8G1z
	7GlfFqfrDZ1b8QpSZanCAOI/VykHbgASaUp2DbRXvaaVFCu+6kO0LMlodu08HsSH
	MTJY9ox9uug/nPb/MrOkP1kxXx7+zdjn7c2KQLqh3C0ZK7yHRzo5UC5DiV4cm/28
	HVMXPWAZCEfXT+PvLJd7Ls6uk3fzkEjiiF8EXa+at4Mfdd7r/Esojzkev0DL+s7l
	shNFCQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48028g0fh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 14:26:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 56DDC40047;
	Mon, 21 Jul 2025 14:24:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6CF5B7A4C92;
	Mon, 21 Jul 2025 14:23:30 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 14:23:29 +0200
Message-ID: <1fc9d75e-459d-454f-b8dc-1fb7f59d09b4@foss.st.com>
Date: Mon, 21 Jul 2025 14:23:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] net: phy: smsc: fix and improve WoL support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Tristram Ha
	<Tristram.Ha@microchip.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-3-89d262812dba@foss.st.com>
 <aH4kVBTxd4zRYv2l@shell.armlinux.org.uk>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <aH4kVBTxd4zRYv2l@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01

Hello Russel,

On 7/21/25 13:28, Russell King (Oracle) wrote:
> On Mon, Jul 21, 2025 at 01:14:45PM +0200, Gatien Chevallier wrote:
>> +static int smsc_phy_suspend(struct phy_device *phydev)
>> +{
>> +	if (!phydev->wol_enabled)
>> +		return genphy_suspend(phydev);
> 
> This should not be necessary. Take a look at phy_suspend(). Notice:
> 
>          phydev->wol_enabled = phy_drv_wol_enabled(phydev) ||
>                                (netdev && netdev->ethtool->wol_enabled);
>          /* If the device has WOL enabled, we cannot suspend the PHY */
>          if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
>                  return -EBUSY;
> 
> PHY_ALWAYS_CALL_SUSPEND is not set for this PHY, therefore if
> phydev->wol_enabled is set by the above code, phydrv->suspend will
> not be called.
> 

Indeed, thank you for pointing this out. I will remove this callback for
v2.

>> +
>> +	return 0;
>> +}
>> +
>> +static int smsc_phy_resume(struct phy_device *phydev)
>> +{
>> +	int rc;
>> +
>> +	if (!phydev->wol_enabled)
>> +		return genphy_resume(phydev);
>> +
>> +	rc = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	if (!(rc & MII_LAN874X_PHY_WOL_STATUS_MASK))
>> +		return 0;
>> +
>> +	dev_info(&phydev->mdio.dev, "Woke up from LAN event.\n");
>> +	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR,
>> +			   rc | MII_LAN874X_PHY_WOL_STATUS_MASK);
>> +
>> +	return rc;
> 
> Note that this will be called multiple times, e.g. during attachment of
> the PHY to the network device, when the device is opened, etc even
> without ->suspend having been called, and before ->wol_enabled has
> been set. Make sure your code is safe for this.
> 

If ->wol_enabled isn't set, then we should fallback to the previous
implementation so I expect it to be fine for that matter.
Then, I expect flags to be set only in case of WoL event received.
Nevertheless, I will double check the phy_* API used in this sequence
for V2, thank you.

Best regards,
Gatien

