Return-Path: <netdev+bounces-143268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8839C1C2E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9BD41C2296F
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E709E1E32CE;
	Fri,  8 Nov 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m0zxBBMt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0BA1DC04A;
	Fri,  8 Nov 2024 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065523; cv=none; b=It/D1rYr+jEG1+Ktw97BDnQFVgHiJLknIRSyTqRwDWEtk88Hx/wWo3rAkIovfzsDPNSXc85+KK7SILgzFjSSuIbpHAhb8qYgqypQ5QFnPEJXeHrj/SsnJGzuXED15df8en8OO2jdtXXr+X1sll9Ga9gReP9sn/3AJd/z9pE+MEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065523; c=relaxed/simple;
	bh=REa7naDZj3JE7RUcIMiSHnLL4NFsApqsLC4+dzdJdJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=baVXUf8ZFG04io8c6vDj97nM5UexhuWSN5+xjBwdWc8/BWqwAb4xZV9+d8lTrvkYqm8g/x2KwTw1/aC+eARHwtK6+ZTz6fKapSsuNhYoGnSKYRyCUtWpX0cpimiEReqtoLXIPQYlXl6w1ee+2claagB+CFN5GvfsQID1NWw2dVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m0zxBBMt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7MbmvK002026;
	Fri, 8 Nov 2024 11:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jg3g8CJOE6XNShK7pgdFE6gzH3yIryU6VXF/O/un2Xs=; b=m0zxBBMtWuuw24qc
	Oyttr6YEz1oQiKT5A4CAvZwbEtR6Gcn6LRtVPOVK/N8gM89+fUEm831DXyANi3qS
	ZWwlXZd6rUGJ7ujkyG5K6c8uVS4nK46ZVMrjdlK2sE+4i9kJaAnXAIwx+YA0mc6D
	V/gvhL8zTU7HI51VHKx0F2KahEqa49NN1ft0EsWa5xEso7N8ZMt/To9t2XiBTZS/
	7NiNxsCO6IHo+OFemE24mbo3TOu32QtiD33HHJPMglp8ZQuF/YnflxBHAAB4Udvu
	0twJCmvwwrU2LXIEqzIJcjpm+bR+wVfPRz9Ae9QUNgkaAY1gpNRF3duY0OxmvJ93
	o5dItw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42s6gksfja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 11:31:39 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A8BVc4D030220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Nov 2024 11:31:38 GMT
Received: from [10.253.8.252] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 8 Nov 2024
 03:31:33 -0800
Message-ID: <9b7def00-e900-4c5e-ba95-671bd1ef9240@quicinc.com>
Date: Fri, 8 Nov 2024 19:31:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] net: pcs: qcom-ipq: Add PCS create and
 phylink operations for IPQ9574
To: Andrew Lunn <andrew@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_luoj@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <bartosz.golaszewski@linaro.org>, <vsmuthu@qti.qualcomm.com>,
        <john@phrozen.org>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
 <20241101-ipq_pcs_rc1-v1-3-fdef575620cf@quicinc.com>
 <d7782a5e-2f67-4f62-a594-0f52144a368f@lunn.ch>
 <9b3a4f00-59f2-48d1-8916-c7d7d65df063@quicinc.com>
 <a0826aa8-703c-448d-8849-47808f847774@lunn.ch>
Content-Language: en-US
From: Lei Wei <quic_leiwei@quicinc.com>
In-Reply-To: <a0826aa8-703c-448d-8849-47808f847774@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YoCC3ZLv-_OZF95wD0AnM6UbU5n2hiPc
X-Proofpoint-GUID: YoCC3ZLv-_OZF95wD0AnM6UbU5n2hiPc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411080095



On 11/6/2024 11:43 AM, Andrew Lunn wrote:
> On Wed, Nov 06, 2024 at 11:16:37AM +0800, Lei Wei wrote:
>>
>>
>> On 11/1/2024 9:21 PM, Andrew Lunn wrote:
>>>> +static int ipq_pcs_config_mode(struct ipq_pcs *qpcs,
>>>> +			       phy_interface_t interface)
>>>> +{
>>>> +	unsigned int val;
>>>> +	int ret;
>>>> +
>>>> +	/* Configure PCS interface mode */
>>>> +	switch (interface) {
>>>> +	case PHY_INTERFACE_MODE_SGMII:
>>>> +		/* Select Qualcomm SGMII AN mode */
>>>> +		ret = regmap_update_bits(qpcs->regmap, PCS_MODE_CTRL,
>>>> +					 PCS_MODE_SEL_MASK | PCS_MODE_AN_MODE,
>>>> +					 PCS_MODE_SGMII);
>>>
>>> How does Qualcomm SGMII AN mode differ from Cisco SGMII AN mode?
>>>
>>
>> Qualcomm SGMII AN mode extends Cisco SGMII spec Revision 1.8 by adding pause
>> bit support in the SGMII word format. It re-uses two of the reserved bits
>> 1..9 for this purpose. The PCS supports both Qualcomm SGMII AN and Cisco
>> SGMII AN modes.
> 
> Is Qualcomm SGMII AN actually needed? I assume it only works against a
> Qualcomm PHY? What interoperability testing have you do against
> non-Qualcomm PHYs?
> 

I agree that using Cisco SGMII AN mode as default is more appropriate,
since is more commonly used with PHYs. I will make this change.

Qualcomm SGMII AN is an extension of top of Cisco SGMII AN (only
pause bits difference). So it is expected to be compatible with
non-Qualcomm PHYs which use Cisco SGMII AN.

>>>> +struct phylink_pcs *ipq_pcs_create(struct device_node *np)
>>>> +{
>>>> +	struct platform_device *pdev;
>>>> +	struct ipq_pcs_mii *qpcs_mii;
>>>> +	struct device_node *pcs_np;
>>>> +	struct ipq_pcs *qpcs;
>>>> +	int i, ret;
>>>> +	u32 index;
>>>> +
>>>> +	if (!of_device_is_available(np))
>>>> +		return ERR_PTR(-ENODEV);
>>>> +
>>>> +	if (of_property_read_u32(np, "reg", &index))
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>> +	if (index >= PCS_MAX_MII_NRS)
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>> +	pcs_np = of_get_parent(np);
>>>> +	if (!pcs_np)
>>>> +		return ERR_PTR(-ENODEV);
>>>> +
>>>> +	if (!of_device_is_available(pcs_np)) {
>>>> +		of_node_put(pcs_np);
>>>> +		return ERR_PTR(-ENODEV);
>>>> +	}
>>>
>>> How have you got this far if the parent is not available?
>>>
>>
>> This check can fail only if the parent node is disabled in the board DTS. I
>> think this error situation may not be caught earlier than this point.
>> However I agree, the above check is redundant, since this check is
>> immediately followed by a validity check on the 'pdev' of the parent node,
>> which should be able cover any such errors as well.
> 
> This was also because the driver does not work as i expected. I was
> expecting the PCS driver to walk its own DT and instantiate the PCS
> devices listed. If the parent is disabled, it is clearly not going to
> start its own children.  But it is in fact some other device which
> walks the PCS DT blob, and as a result the child/parent relationship
> is broken, a child could exist without its parent.
> 

Currently the PCS driver walks the DT and instantiates the parent PCS 
nodes during probe, where as the child PCS (the per-MII PCS instance) is 
instantiated later by the network device that is associated with the MII.

Alternatively as you mention, we could instantiate the child PCS during 
probe itself. The network driver when it comes up, can just issue a 
'get' operation on the PCS driver, to retrieve the PCS phylink given the 
PCS node associated with the MAC. Agree that this is architecturally 
simpler for instantiating the PCS nodes, and the interaction between 
network driver and PCS is simpler (single 'get_phylink_pcs' API exported 
from PCS driver instead of PCS create/destroy API exported). The PCS 
instances are freed up during platform device remove.

>>>> +	for (i = 0; i < PCS_MII_CLK_MAX; i++) {
>>>> +		qpcs_mii->clk[i] = of_clk_get_by_name(np, pcs_mii_clk_name[i]);
>>>> +		if (IS_ERR(qpcs_mii->clk[i])) {
>>>> +			dev_err(qpcs->dev,
>>>> +				"Failed to get MII %d interface clock %s\n",
>>>> +				index, pcs_mii_clk_name[i]);
>>>> +			goto err_clk_get;
>>>> +		}
>>>> +
>>>> +		ret = clk_prepare_enable(qpcs_mii->clk[i]);
>>>> +		if (ret) {
>>>> +			dev_err(qpcs->dev,
>>>> +				"Failed to enable MII %d interface clock %s\n",
>>>> +				index, pcs_mii_clk_name[i]);
>>>> +			goto err_clk_en;
>>>> +		}
>>>> +	}
>>>
>>> Maybe devm_clk_bulk_get() etc will help you here? I've never actually
>>> used them, so i don't know for sure.
>>>
>>
>> We don't have a 'device' associated with the 'np', so we could not consider
>> using the "devm_clk_bulk_get()" API.
> 
> Another artefact of not have a child-parent relationship. I wounder if
> it makes sense to change the architecture. Have the PCS driver
> instantiate the PCS devices as its children. They then have a device
> structure for calls like clk_bulk_get(), and a more normal
> consumer/provider setup.
> 

I think you may be suggesting to drop the child node usage in the DTS, 
so that we can attach all the MII clocks to the single PCS node, to 
facilitate usage of bulk get() API to retrieve the MII clocks for that 
PCS. We reviewed this option, and believe that retaining the current 
parent-child relationship is a better option instead. This is because 
this option allows us the flexibility to enable/disable the MII channels 
(child nodes) in the board DTS as per the ethernet/MII configuration 
relevant for the board.

We would like to explain this using an example of SoC/board DTSI below.

For IPQ9574, port5 can be connected with PCS0 (PCS0: PSGMII, PCS1 not 
used) or PCS1 (PCS0: QSGMII, PCS1: USXGMII).

IPQ9574 SoC DTSI for PCS0 (5 max MII channels) and PCS1:
--------------------------------------------------------
pcs0: ethernet-pcs@7a00000 {
	clocks = <&gcc GCC_UNIPHY0_SYS_CLK>,
		 <&gcc GCC_UNIPHY0_AHB_CLK>;
	clock-names = "sys",
		      "ahb";

	status = "disabled";

	pcs0_mii0: pcs-mii@0 {
		reg = <0>;
		status = "disabled";
	};

	......

	pcs0_mii3: pcs-mii@3 {
		reg = <3>;
		status = "disabled";
	};
	pcs0_mii4: pcs-mii@3 {
		reg = <4>;
		status = "disabled";
	};
};

pcs1: ethernet-pcs@7a10000 {
	clocks = <&gcc GCC_UNIPHY1_SYS_CLK>,
		 <&gcc GCC_UNIPHY1_AHB_CLK>;
	clock-names = "sys",
		      "ahb";

	status = "disabled";

	pcs1_mii0: pcs-mii@0 {
		reg = <0>;
		status = "disabled";
	};	
};


board1 DTS (PCS0 - QSGMII (port1 - port4), PCS1 USXGMII (port 5))
-----------------------------------------------------------------
&pcs0 {
	status = "okay";
};

/* Enable only four MII channels for PCS0 for this board */
&pcs0_mii0 {
	clocks = <&nsscc NSS_CC_UNIPHY_PORT1_RX_CLK>,
		 <&nsscc NSS_CC_UNIPHY_PORT1_TX_CLK>;
	clock-names = "mii_rx",
		      "mii_tx";
	status = "okay";
};

......

&pcs0_mii3 {
	clocks = <&nsscc NSS_CC_UNIPHY_PORT4_RX_CLK>,
		 <&nsscc NSS_CC_UNIPHY_PORT4_TX_CLK>;
	clock-names = "mii_rx",
		      "mii_tx";
	status = "okay";
};

&pcs1 {
	status = "okay";
};

&pcs1_mii0 {
	clocks = <&nsscc NSS_CC_UNIPHY_PORT5_RX_CLK>,
		 <&nsscc NSS_CC_UNIPHY_PORT5_TX_CLK>;
	clock-names = "mii_rx",
		      "mii_tx";
	status = "okay";
};

board2 DTS: (PCS0 - PSGMII (port1 - port5), PCS1 - disabled):
-------------------------------------------------------------
&pcs0 {
	status = "okay";
};

/* For PCS0, Enable all 5 MII channels for this board,
    PCS1 is disabled */
&pcs0_mii0 {
	clocks = <&nsscc NSS_CC_UNIPHY_PORT1_RX_CLK>,
		 <&nsscc NSS_CC_UNIPHY_PORT1_TX_CLK>;
	clock-names = "mii_rx",
		      "mii_tx";
	status = "okay";
};

......

&pcs0_mii4 {
	clocks = <&nsscc NSS_CC_UNIPHY_PORT5_RX_CLK>,
		 <&nsscc NSS_CC_UNIPHY_PORT5_TX_CLK>;
	clock-names = "mii_rx",
		      "mii_tx";
	status = "okay";
};

If we drop the child node in DTS, then all MII clocks will have to be 
combined with the SoC clocks (AHB/SYS) and added to the board DTS, which 
may not be correct. Also, I think the child-parent relationship in DTS 
will make it more clear to reflect the PCS-to--MII-channel relationship.

Kindly let us know if this approach is fine.

> 	Andrew


