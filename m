Return-Path: <netdev+bounces-208621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FDBB0C629
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208473B76AD
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012FD2DA76E;
	Mon, 21 Jul 2025 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5iIxQfL4"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2582D6617;
	Mon, 21 Jul 2025 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107768; cv=none; b=sooTnhuoVDyNms92lBfQsxSkE5rGB4ubYGTqpCn+Hva7t80eeo+JRtJPfzj+BBkhJ9acg8hYelGgs10mvQD7bzFzUKPjQdKFAX0kL9J6KHpX+py5cYIGbFA7Xesl8jRW7wr+691atpNFJGhSTm7/bBfnSkBwvoz1gaBY8Pg4OUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107768; c=relaxed/simple;
	bh=4mTsBe71F88u3XVMXKY9/rSzIS8TxslEt+Beazy+yD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o3yIw1GEV1c83HkaZO7pn45jX11wRRUUm0FyLN9xLGk8kh6lcmNYA1bSe/0yBhsSuwDt2CJCqj7VlQOMG7UV1QK7J84xrvc2LlzwhhNtOxoPJ51bxFJpI1R5XaJzHAqrmjDYhgcX7jQzFDCouEdBhXhexiAjAz4up/nTygZTyPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=5iIxQfL4; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LCPm57020352;
	Mon, 21 Jul 2025 16:22:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	MlPUcJGCX9eGUJmog410SGdHvgab8UL6u6jJvem96Jg=; b=5iIxQfL4YWN2yOno
	Nav6nT0ot5lu7hhSPyXgIerU2aur1+pWl2zGqeVjwo5/MoRbNadUTCrznjLT6TA2
	TaNHCcQbUg79u4zgfZ1O9g9Vzdl9kvccvLpIX9bvOJJaLruoh8epwg9EXkyX5bZI
	HBffxDudJzyO/nBTZnXGGRTuIBlzLysZ8qs1DiKVOZiSbSdG/gSZSIL+QQcDwfNM
	8lHkW+sNsPxrhPb3JUzOj/Fg5nvwoylJ3DKlGL8PWv6cyARyZE2P2qxSoGTxpeJ8
	ClX+EVBlHiLtWapJDla7SIQTQ2zQW1eT6/lUrBSu7KW2M741cnudg2Mve0D671uW
	QvzB2A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4802q21em4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 16:22:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2B30240054;
	Mon, 21 Jul 2025 16:20:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2988376EA8E;
	Mon, 21 Jul 2025 16:19:09 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 16:19:08 +0200
Message-ID: <b95e3439-717b-4159-acf9-7ce76d1c43d4@foss.st.com>
Date: Mon, 21 Jul 2025 16:19:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] net: phy: smsc: fix and improve WoL support
To: Andrew Lunn <andrew@lunn.ch>
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
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-3-89d262812dba@foss.st.com>
 <cca8e9e6-a063-4e00-87af-f59ea926cce3@lunn.ch>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <cca8e9e6-a063-4e00-87af-f59ea926cce3@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_01,2025-03-28_01

Hello Andrew,

On 7/21/25 15:26, Andrew Lunn wrote:
>> +static int smsc_phy_suspend(struct phy_device *phydev)
>> +{
>> +	if (!phydev->wol_enabled)
>> +		return genphy_suspend(phydev);
>> +
>> +	return 0;
>> +}
> 
> Suspend/resume is somewhat complex, and i don't know all the
> details. But this looks odd. Why does the phylib core call suspend
> when phydev->wol_enabled is true? That at least needs an explanation
> in the commit message.
> 

As stated by Russel, this callback is not needed because phy_suspend()
will not call this suspend() callback if phydev->wol_enabled is set.
Therefore, I'm removing it vor V2.

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
> 
> Please don't spam the log. It is clear the system woke up, there are
> messages in the log...

I wanted to state clearly that the wake up happended because of a WoL
event but sure, I understand that it's best if log isn't spammed. Do you
prefer it completely removed or dev_info()->dev_dbg() ?

Best regards,
Gatien

> 
> 	Andrew

