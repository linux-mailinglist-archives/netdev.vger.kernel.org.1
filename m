Return-Path: <netdev+bounces-102675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D11B390436E
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CE21C232C5
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DD86FE16;
	Tue, 11 Jun 2024 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nDyykH1R"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D722628D
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130190; cv=none; b=boBIsKI444wgG1Q0aLbSh6Kfyf6I+TH4zDhfSYWtHyfvP7BZe4q9p7+p1Okr3pHybwS1bFXP36qfFq743FEjisORB3steHpnEaIWjpDosCDxJqoTIAIJgi17tlbZf8qL2zM0CAzbzqDUgVYMimW3Kw2CIaI/iLMWMJYmPl6z2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130190; c=relaxed/simple;
	bh=OwT+mzZahiq6w4Ib5aGESPGjOU0M+MPL+Z8vR/USPcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fVtsmJfABUYRrp3FSng8WPHUxuSzh08l7kkEgMUzTXdTEQS2RguTj3zaUBbHDXN69GlkYDkon5hcQBoTVKsKK4fpKz0pZfoFNSwCy/qvPQ5gpLVhnmqtBaT7YbGd8JikewqdaUMRzFvpmIEma8PrFc5mRMW374RFW3i1Rt2M8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nDyykH1R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BBqGuh009912;
	Tue, 11 Jun 2024 18:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UVAASebRnti5XmMIPPNNwqFJAiSAUK/HajgZpQm+CWw=; b=nDyykH1R81q6+PGH
	+5hWahfcqKe7IqEGQ33R31k098or7snqkqBMaf96IyEdjF2nEvvr13OM7PRn9LWP
	ybhBct3EavG/2wC4CKnGPqJAFAvVuHPKXWZj7df+JpymtUALyDQjcS/uWuM9RPpt
	qkXyuZrF/aqILrO4VlQ72gspA4fE+BIc95LObFQINriOV5Du23paD7sYZ3yDKhdK
	ftjt/xlwSwg66PQjbDfyarzKjh5l7+J+6N/mJg+j1atSkcDDai2i0HitRrVlMndw
	FyFIe0ZCRr3D8nnLCBFkIQph2TFa3VaDO4/rnoJsqFZoNB6dWV5FY1edZaCFSYvx
	3wsZIQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ype9123xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 18:22:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BIMXRb029851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 18:22:33 GMT
Received: from [10.110.56.35] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 11:22:33 -0700
Message-ID: <f030e42f-6655-451c-9453-5026d27c0980@quicinc.com>
Date: Tue, 11 Jun 2024 11:22:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2 5/8] net: stmmac: dwmac4: convert
 sgmii/rgmii "pcs" to phylink
To: Andrew Halaney <ahalaney@redhat.com>,
        "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>,
        Sneh Shah <quic_snehshah@quicinc.com>
CC: Serge Semin <fancer.lancer@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <E1sD0P5-00EzC6-Me@rmk-PC.armlinux.org.uk>
 <zzevmhmwxrhs5yfv5srvcjxrue2d7wu7vjqmmoyd5mp6kgur54@jvmuv7bxxhqt>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <zzevmhmwxrhs5yfv5srvcjxrue2d7wu7vjqmmoyd5mp6kgur54@jvmuv7bxxhqt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jTanxnBQfx0WIyNwwvCywqbgGhoOEpUx
X-Proofpoint-ORIG-GUID: jTanxnBQfx0WIyNwwvCywqbgGhoOEpUx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406110125



On 6/5/2024 3:35 PM, Andrew Halaney wrote:
> On Fri, May 31, 2024 at 12:26:35PM GMT, Russell King (Oracle) wrote:
>> Convert dwmac4 sgmii/rgmii "pcs" implementation to use a phylink_pcs
>> so we can eventually get rid of the exceptional paths that conflict
>> with phylink.
>>
>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>> ---
>>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 102 ++++++++++++------
>>  1 file changed, 72 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
>> index dbd9f93b2460..cb99cb69c52b 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/ethtool.h>
>>  #include <linux/io.h>
>> +#include <linux/phylink.h>
>>  #include "stmmac.h"
>>  #include "stmmac_pcs.h"
>>  #include "dwmac4.h"
>> @@ -758,42 +759,76 @@ static void dwmac4_ctrl_ane(void __iomem *ioaddr, bool ane, bool srgmi_ral,
>>  	dwmac_ctrl_ane(ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
>>  }
>>  
>> -static void dwmac4_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
>> +static int dwmac4_mii_pcs_validate(struct phylink_pcs *pcs,
>> +				   unsigned long *supported,
>> +				   const struct phylink_link_state *state)
>>  {
>> -	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);
>> +	/* Only support in-band */
>> +	if (!test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, state->advertising))
>> +		return -EINVAL;
>> +
>> +	return 0;
>>  }
>>  
>> -/* RGMII or SMII interface */
>> -static void dwmac4_phystatus(void __iomem *ioaddr, struct stmmac_extra_stats *x)
>> +static int dwmac4_mii_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>> +				 phy_interface_t interface,
>> +				 const unsigned long *advertising,
>> +				 bool permit_pause_to_mac)
>>  {
>> +	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
>> +
>> +	return dwmac_pcs_config(hw, neg_mode, interface, advertising,
>> +				GMAC_PCS_BASE);
>> +}
>> +
>> +static void dwmac4_mii_pcs_get_state(struct phylink_pcs *pcs,
>> +				     struct phylink_link_state *state)
>> +{
>> +	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
>> +	unsigned int clk_spd;
>>  	u32 status;
>>  
>> -	status = readl(ioaddr + GMAC_PHYIF_CONTROL_STATUS);
>> -	x->irq_rgmii_n++;
>> +	status = readl(hw->pcsr + GMAC_PHYIF_CONTROL_STATUS);
>> +
>> +	state->link = !!(status & GMAC_PHYIF_CTRLSTATUS_LNKSTS);
>> +	if (!state->link)
>> +		return;
>>  
>> -	/* Check the link status */
>> -	if (status & GMAC_PHYIF_CTRLSTATUS_LNKSTS) {
>> -		int speed_value;
>> +	clk_spd = FIELD_GET(GMAC_PHYIF_CTRLSTATUS_SPEED, status);
>> +	if (clk_spd == GMAC_PHYIF_CTRLSTATUS_SPEED_125)
>> +		state->speed = SPEED_1000;
>> +	else if (clk_spd == GMAC_PHYIF_CTRLSTATUS_SPEED_25)
>> +		state->speed = SPEED_100;
>> +	else if (clk_spd == GMAC_PHYIF_CTRLSTATUS_SPEED_2_5)
>> +		state->speed = SPEED_10;
>> +
>> +	/* FIXME: Is this even correct?
>> +	 * GMAC_PHYIF_CTRLSTATUS_TC = BIT(0)
>> +	 * GMAC_PHYIF_CTRLSTATUS_LNKMOD = BIT(16)
>> +	 * GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK = 1
>> +	 *
>> +	 * The result is, we test bit 0 for the duplex setting.
>> +	 */
>> +	state->duplex = status & GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK ?
>> +			DUPLEX_FULL : DUPLEX_HALF;
> 
> My gut feeling is that this is/was wrong, and the LNKMOD_MASK expects you've
> shifted / got the field out etc...
> 
> Sneh, Abhishek, can you confirm this for us? I'd appreciate it.
> 
The status needs to be checked against Bit 16 which is GMAC_PHYIF_CTRLSTATUS_LNKMOD to determine the Duplex. 
In the above logic the status is checked against GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK (value 1) which actually determines
the link is up/down 

//Correct logic
state->duplex = status & GMAC_PHYIF_CTRLSTATUS_LNKMOD ?
			DUPLEX_FULL : DUPLEX_HALF;

Bit 16	LNKMOD		Link Mode

This bit indicates the current mode of operation of the link.
0x0: HDUPLX 
0x1: FDUPLX 

Bit 1	LUD	Link Up or Down

This bit indicates whether the link is up or down during transmission of configuration in the RGMII, SGMII, or SMII interface.
0x0: LINKDOWN  
0x1: LINKUP 


> I need to run for the evening soon, but tested taking sa8775p-ride,
> making it have managed = "in-band-status", and remove the
> HAS_INTEGRATED_PCS stuff... and then all of a sudden the link acts as if
> its half duplex (but works otherwise I think? need to test more
> throughly):
> 
>     [   11.458385] qcom-ethqos 23040000.ethernet end0: Link is Up - 1Gbps/Half - flow control rx/tx
> 
> So I think it is probably wrong, and if I understand
> correctly most of the special treatment for the qualcomm driver can be
> dropped? I know it was mentioned that all the 2.5 Gpbs stuff is a
> Qualcomm addition (and that you're chasing down some answers with the
> hardware team), but hopefully you can confirm the register's bitfields
> for us here!
> 
> 
>>  
>> -		x->pcs_link = 1;
>> +	dwmac_pcs_get_state(hw, state, GMAC_PCS_BASE);
>> +}
>>  
>> -		speed_value = ((status & GMAC_PHYIF_CTRLSTATUS_SPEED) >>
>> -			       GMAC_PHYIF_CTRLSTATUS_SPEED_SHIFT);
>> -		if (speed_value == GMAC_PHYIF_CTRLSTATUS_SPEED_125)
>> -			x->pcs_speed = SPEED_1000;
>> -		else if (speed_value == GMAC_PHYIF_CTRLSTATUS_SPEED_25)
>> -			x->pcs_speed = SPEED_100;
>> -		else
>> -			x->pcs_speed = SPEED_10;
>> +static const struct phylink_pcs_ops dwmac4_mii_pcs_ops = {
>> +	.pcs_validate = dwmac4_mii_pcs_validate,
>> +	.pcs_config = dwmac4_mii_pcs_config,
>> +	.pcs_get_state = dwmac4_mii_pcs_get_state,
>> +};
>>  
>> -		x->pcs_duplex = (status & GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK);
>> +static struct phylink_pcs *
>> +dwmac4_phylink_select_pcs(struct stmmac_priv *priv, phy_interface_t interface)
>> +{
>> +	if (priv->hw->pcs & STMMAC_PCS_RGMII ||
>> +	    priv->hw->pcs & STMMAC_PCS_SGMII)
>> +		return &priv->hw->mac_pcs;
>>  
>> -		pr_info("Link is Up - %d/%s\n", (int)x->pcs_speed,
>> -			x->pcs_duplex ? "Full" : "Half");
>> -	} else {
>> -		x->pcs_link = 0;
>> -		pr_info("Link is Down\n");
>> -	}
>> +	return NULL;
>>  }
>>  
>>  static int dwmac4_irq_mtl_status(struct stmmac_priv *priv,
>> @@ -867,8 +902,12 @@ static int dwmac4_irq_status(struct mac_device_info *hw,
>>  	}
>>  
>>  	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
>> -	if (intr_status & PCS_RGSMIIIS_IRQ)
>> -		dwmac4_phystatus(ioaddr, x);
>> +	if (intr_status & PCS_RGSMIIIS_IRQ) {
>> +		/* TODO Dummy-read to clear the IRQ status */
>> +		readl(ioaddr + GMAC_PHYIF_CONTROL_STATUS);
>> +		phylink_pcs_change(&hw->mac_pcs, false);
> 
> I'll just highlight it here, but same question as the dwmac1000 change.
> We can discuss that question there, and if anything changes apply it
> here too. It is probably fine and I'm fussing over nothing.
> 
>> +		x->irq_rgmii_n++;
>> +	}
>>  
>>  	return ret;
>>  }
>> @@ -1186,6 +1225,7 @@ static void dwmac4_set_hw_vlan_mode(struct mac_device_info *hw)
>>  const struct stmmac_ops dwmac4_ops = {
>>  	.core_init = dwmac4_core_init,
>>  	.update_caps = dwmac4_update_caps,
>> +	.phylink_select_pcs = dwmac4_phylink_select_pcs,
>>  	.set_mac = stmmac_set_mac,
>>  	.rx_ipc = dwmac4_rx_ipc_enable,
>>  	.rx_queue_enable = dwmac4_rx_queue_enable,
>> @@ -1210,7 +1250,6 @@ const struct stmmac_ops dwmac4_ops = {
>>  	.set_eee_timer = dwmac4_set_eee_timer,
>>  	.set_eee_pls = dwmac4_set_eee_pls,
>>  	.pcs_ctrl_ane = dwmac4_ctrl_ane,
>> -	.pcs_get_adv_lp = dwmac4_get_adv_lp,
>>  	.debug = dwmac4_debug,
>>  	.set_filter = dwmac4_set_filter,
>>  	.set_mac_loopback = dwmac4_set_mac_loopback,
>> @@ -1230,6 +1269,7 @@ const struct stmmac_ops dwmac4_ops = {
>>  const struct stmmac_ops dwmac410_ops = {
>>  	.core_init = dwmac4_core_init,
>>  	.update_caps = dwmac4_update_caps,
>> +	.phylink_select_pcs = dwmac4_phylink_select_pcs,
>>  	.set_mac = stmmac_dwmac4_set_mac,
>>  	.rx_ipc = dwmac4_rx_ipc_enable,
>>  	.rx_queue_enable = dwmac4_rx_queue_enable,
>> @@ -1254,7 +1294,6 @@ const struct stmmac_ops dwmac410_ops = {
>>  	.set_eee_timer = dwmac4_set_eee_timer,
>>  	.set_eee_pls = dwmac4_set_eee_pls,
>>  	.pcs_ctrl_ane = dwmac4_ctrl_ane,
>> -	.pcs_get_adv_lp = dwmac4_get_adv_lp,
>>  	.debug = dwmac4_debug,
>>  	.set_filter = dwmac4_set_filter,
>>  	.flex_pps_config = dwmac5_flex_pps_config,
>> @@ -1278,6 +1317,7 @@ const struct stmmac_ops dwmac410_ops = {
>>  const struct stmmac_ops dwmac510_ops = {
>>  	.core_init = dwmac4_core_init,
>>  	.update_caps = dwmac4_update_caps,
>> +	.phylink_select_pcs = dwmac4_phylink_select_pcs,
>>  	.set_mac = stmmac_dwmac4_set_mac,
>>  	.rx_ipc = dwmac4_rx_ipc_enable,
>>  	.rx_queue_enable = dwmac4_rx_queue_enable,
>> @@ -1302,7 +1342,6 @@ const struct stmmac_ops dwmac510_ops = {
>>  	.set_eee_timer = dwmac4_set_eee_timer,
>>  	.set_eee_pls = dwmac4_set_eee_pls,
>>  	.pcs_ctrl_ane = dwmac4_ctrl_ane,
>> -	.pcs_get_adv_lp = dwmac4_get_adv_lp,
>>  	.debug = dwmac4_debug,
>>  	.set_filter = dwmac4_set_filter,
>>  	.safety_feat_config = dwmac5_safety_feat_config,
>> @@ -1391,5 +1430,8 @@ int dwmac4_setup(struct stmmac_priv *priv)
>>  	mac->mii.clk_csr_mask = GENMASK(11, 8);
>>  	mac->num_vlan = dwmac4_get_num_vlan(priv->ioaddr);
>>  
>> +	mac->mac_pcs.ops = &dwmac4_mii_pcs_ops;
>> +	mac->mac_pcs.neg_mode = true;
>> +
>>  	return 0;
>>  }
>> -- 
>> 2.30.2
>>
> 

