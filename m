Return-Path: <netdev+bounces-100492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1AB8FAE86
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3C828166E
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBB114375D;
	Tue,  4 Jun 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="27LETLlo"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41F142E95;
	Tue,  4 Jun 2024 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492572; cv=none; b=pTncufPio9NhKIEN/sjrgg9oiocsNoyogOIPpTU7Gr8VJibStzR2bRRsgdi+dEn2lr7xWD7eTOcrHmWfgqKMDaGYe8inI2+QZrp0kO7YJp+r7GwSsKc4+jVZtufU/E8Spvxe+C6OxvWscjAGbUVznUF30I2HrFzrPBPnU/Zosbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492572; c=relaxed/simple;
	bh=BQ4ARc7ym83EjP1ZdLfO7G30wIOuzKX+3fzcU4koyFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D5cAlhbC6g0rYXnG3FL0H+Jy3XhvK/w2bJvv4tol66mWMCmTtcmwLZM01FGl/SXv09J267rdB2rCQ0tvJ5ZEyTisy00dYIP6nyzr3WAG3oFkNl8rWemCFNJBQeSBSuZuB6lOSWxw+PzjZ634yu+9znfL0bUySMiHg/ebAvGDGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=27LETLlo; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45494lCn031129;
	Tue, 4 Jun 2024 11:15:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	qffrjtKMkRwftEA2tT5fwaxuwB2L0SM4mOqEx2NwZOo=; b=27LETLloblnKW1ze
	OguMztGrFKSJuOveeUHYxriGpmF2JVXJVDwEb8sXBWU9u8R0fQjb3HRfU+EUUBFb
	24RZZ8KJd5JYG7mcmrlxbS5VmJhZFGM2Y/PRTkmAahmIfwMLQYj2xHuPq01JpIUu
	Fd3pjfYyhBwZ8t0BbwkhynDsgUTfNyS+zqwPaApvO/O9kvprpvgM6gyqsUBex37s
	IeEKv6EdGHf8Yl9MR+B/glTcq4VhG0hzOb8BZhytzlnirrOprMmFPlfcujaVoPE8
	1HUHjYLDyYSmuGBIw0ZXTub9PQ73zSUegc8h2I3V0B/Feh4FITQmgo17wIYQaPb2
	HkPAkQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ygd70sd70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 11:15:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3D29F40047;
	Tue,  4 Jun 2024 11:15:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B6222216851;
	Tue,  4 Jun 2024 11:13:54 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 11:13:51 +0200
Message-ID: <627a2182-527c-444d-9485-817c69f57036@foss.st.com>
Date: Tue, 4 Jun 2024 11:13:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] net: stmmac: dwmac-stm32: Separate out external
 clock rate validation
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
 <20240603092757.71902-3-christophe.roullier@foss.st.com>
 <Zl2O+eJF9vOTqFx2@shell.armlinux.org.uk>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <Zl2O+eJF9vOTqFx2@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_03,2024-05-30_01,2024-05-17_01


On 6/3/24 11:38, Russell King (Oracle) wrote:
> On Mon, Jun 03, 2024 at 11:27:48AM +0200, Christophe Roullier wrote:
>> +static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
>> +{
>> +	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>> +	const u32 clk_rate = clk_get_rate(dwmac->clk_eth_ck);
>> +
>> +	switch (plat_dat->mac_interface) {
> Should these be phy_interface?

Hi,

The code is validating the clock frequency of clock that are INPUT into 
the MAC. These clock can be generated by either the PHY, or Xtal, or 
some other source, but they are still the clock which are INPUT into the 
MAC. Therefore I believe mac_interface is correct here.

> Does this clock depend on the interface
> mode used with the PHY?
>
I don't think the clock depend on the PHY mode. Look at 
drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c :
"
458         plat->phy_interface = phy_mode;
459         rc = stmmac_of_get_mac_mode(np);
460         plat->mac_interface = rc < 0 ? plat->phy_interface : rc;
"
and this comment:
"
382 /**
383  * stmmac_of_get_mac_mode - retrieves the interface of the MAC
384  * @np: - device-tree node
385  * Description:
386  * Similar to `of_get_phy_mode()`, this function will retrieve (from
387  * the device-tree) the interface mode on the MAC side. This assumes
388  * that there is mode converter in-between the MAC & PHY
389  * (e.g. GMII-to-RGMII).
390  */
391 static int stmmac_of_get_mac_mode(struct device_node *np)
"
I think in the unlikely case that you would have a mode converter 
between the MAC and PHY, the clock that are validated by this code would 
still be the clock that are INPUT into the MAC, i.e. clock on the MAC 
side of the mode converter and NOT on the PHY side , and those clock 
would not depend on the PHY mode, they would depend on the MAC mode .

