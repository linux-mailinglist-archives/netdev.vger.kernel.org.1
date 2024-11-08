Return-Path: <netdev+bounces-143280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6009C1C97
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 13:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE651F243F7
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89B61E47CB;
	Fri,  8 Nov 2024 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NeyisAj/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85EA1E5019;
	Fri,  8 Nov 2024 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067439; cv=none; b=etUilAH81XxevSYcCZaYKY2zfZGG4/6lrPyvvFJioooQWayKxK+XRKMFX6BOXzJvfJUX5zSzY8F9vnskcXLRq7FVdE0Eg3gXSbLk79DuhNmuvtXR5IgMVUiPMithgByOCoxDuQwXINLoJs6y6Nvh43DLOcsRCAdzxZTNg3U33Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067439; c=relaxed/simple;
	bh=tiaUwiSpLewwzyaEdaJSH0g+viV751wrD37CgQ1+dcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rc8rw9U18BpnaqlF1LUX9W8wLU1Zx0s2gLqORL+o5LFQCxf9ldzscjQnOTsqxA0/qyZZw+u4V1AyKDAVJLT6ohGZ9AwUyP8oOmNRgJmdy7Wxog03gy+U6jAthXJUn5oJRKqHeINs3Rmjg+RVlZMjyYeoLsWiYB3lOAFFWP8MZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NeyisAj/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Mc4UC013176;
	Fri, 8 Nov 2024 12:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gq+63DII0Ca7njV2SkcMUWfdVH7ZSZ9awxHZ0v14pjM=; b=NeyisAj/7dFKbC8j
	3HtdfLK+j35BNf2d3/v01/ouPwF/qO/4EUKlzkHnoBaUbg7K0bSj/Ex6McQM0mLL
	MxdyK7gSAx8RrxS6YXZnLuqEZaigonx4L5T8RnU868pH4KEHuANhXov11DELZBhE
	KCOqeMNTCpZv8e35Xag63LperoQdZQowzRwu51hMaG7+YF5GlD2EdYZa9j0taO93
	nrHO1aZvTHXjHkmArf59VC8I6ozD6FflBCFDC1+3hBb+7rncThpUfGVmrUNStEAU
	+UyqaYOcUqXD3IVC6SgszXeKZ7YId2GPcWAbpHRWKKdlg+7TkA2QOpSDMiV+ZMXX
	H8I1Gg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42s6gm1hfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 12:03:29 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A8C3SW5008066
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Nov 2024 12:03:28 GMT
Received: from [10.253.8.252] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 8 Nov 2024
 04:03:23 -0800
Message-ID: <57e60cb1-7f57-48ff-9884-458831e19810@quicinc.com>
Date: Fri, 8 Nov 2024 20:03:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] net: pcs: qcom-ipq: Add PCS create and
 phylink operations for IPQ9574
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_luoj@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <bartosz.golaszewski@linaro.org>, <vsmuthu@qti.qualcomm.com>,
        <john@phrozen.org>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
 <20241101-ipq_pcs_rc1-v1-3-fdef575620cf@quicinc.com>
 <Zy0OuPMbUaZtIosj@shell.armlinux.org.uk>
Content-Language: en-US
From: Lei Wei <quic_leiwei@quicinc.com>
In-Reply-To: <Zy0OuPMbUaZtIosj@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1KHfz1SJZftgfw1InVs_u6CN_2Vyq57T
X-Proofpoint-GUID: 1KHfz1SJZftgfw1InVs_u6CN_2Vyq57T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080100



On 11/8/2024 3:02 AM, Russell King (Oracle) wrote:
> Hi,
> 
> On Fri, Nov 01, 2024 at 06:32:51PM +0800, Lei Wei wrote:
>> +static int ipq_pcs_config_mode(struct ipq_pcs *qpcs,
>> +			       phy_interface_t interface)
>> +{
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	/* Configure PCS interface mode */
>> +	switch (interface) {
>> +	case PHY_INTERFACE_MODE_SGMII:
>> +		/* Select Qualcomm SGMII AN mode */
>> +		ret = regmap_update_bits(qpcs->regmap, PCS_MODE_CTRL,
>> +					 PCS_MODE_SEL_MASK | PCS_MODE_AN_MODE,
>> +					 PCS_MODE_SGMII);
>> +		if (ret)
>> +			return ret;
>> +		break;
>> +	case PHY_INTERFACE_MODE_QSGMII:
>> +		ret = regmap_update_bits(qpcs->regmap, PCS_MODE_CTRL,
>> +					 PCS_MODE_SEL_MASK | PCS_MODE_AN_MODE,
>> +					 PCS_MODE_QSGMII);
>> +		if (ret)
>> +			return ret;
>> +		break;
>> +	default:
>> +		dev_err(qpcs->dev,
>> +			"Unsupported interface %s\n", phy_modes(interface));
>> +		return -EOPNOTSUPP;
>> +	}
> 
> I think:
> 
> 	unsigned int mode;
> 
> 	switch (interface) {
> 	case PHY_INTERFACE_MODE_SGMII:
> 		/* Select Qualcomm SGMII AN mode */
> 		mode = PCS_MODE_SGMII;
> 		break;
> 
> 	case PHY_INTERFACE_MODE_QSGMII:
> 		mode = PCS_MODE_QSGMII;
> 		break;
> 
> 	default:
> 		...
> 	}
> 
> 	ret = regmap_update_bits(qpcs->regmap, PCS_MODE_CTRL,
> 				 PCS_MODE_SEL_MASK | PCS_MODE_AN_MODE, mode);
> 	if (ret)
> 		return ret;
> 
> might be easier to read? 

Thanks for the suggestion, I will make this change.

I notice that in patch 4, the USXGMII case
> drops PCS_MODE_AN_MODE from the mask, leaving this bit set to whatever
> value it previously was. Is that intentional?
> 

Yes, this bit is used for configuring the SGMII AN mode - Cisco AN or 
Qualcomm AN. The default setting is Cisco SGMII AN mode.

Please note that as per our discussion with Andrew on his comment 
regarding the default mode to use, we would like to change the default 
setting for SGMII/QSGMII to Cisco AN Mode in the next patch update.

>> +static int ipq_pcs_link_up_config_sgmii(struct ipq_pcs *qpcs,
>> +					int index,
>> +					unsigned int neg_mode,
>> +					int speed)
>> +{
>> +	int ret;
>> +
>> +	/* PCS speed need not be configured if in-band autoneg is enabled */
>> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
>> +		goto pcs_adapter_reset;
>> +
>> +	/* PCS speed set for force mode */
>> +	switch (speed) {
>> +	case SPEED_1000:
>> +		ret = regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
>> +					 PCS_MII_SPEED_MASK,
>> +					 PCS_MII_SPEED_1000);
>> +		if (ret)
>> +			return ret;
>> +		break;
>> +	case SPEED_100:
>> +		ret = regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
>> +					 PCS_MII_SPEED_MASK, PCS_MII_SPEED_100);
>> +		if (ret)
>> +			return ret;
>> +		break;
>> +	case SPEED_10:
>> +		ret = regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
>> +					 PCS_MII_SPEED_MASK, PCS_MII_SPEED_10);
>> +		if (ret)
>> +			return ret;
>> +		break;
>> +	default:
>> +		dev_err(qpcs->dev, "Invalid SGMII speed %d\n", speed);
>> +		return -EINVAL;
>> +	}
> 
> I think it's worth having the same structure here, and with fewer lines
> (and fewer long lines) maybe:
> 
> 	if (neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED) {
> 		switch (speed) {
> 		...
> 		}
> 
> 		ret = regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
> 					 PCS_MII_SPEED_MASK, ctrl);
> 		if (ret)
> 			return ret;
> 	}
> 
> means you don't need the pcs_adapter_reset label.
> 

Sure, thanks for the suggestion. I will make this change.

>> +
>> +pcs_adapter_reset:
>> +	/* PCS adapter reset */
>> +	ret = regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
>> +				 PCS_MII_ADPT_RESET, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return regmap_update_bits(qpcs->regmap, PCS_MII_CTRL(index),
>> +				  PCS_MII_ADPT_RESET, PCS_MII_ADPT_RESET);
>> +}
>> +
>> +static void ipq_pcs_get_state(struct phylink_pcs *pcs,
>> +			      struct phylink_link_state *state)
>> +{
>> +	struct ipq_pcs_mii *qpcs_mii = phylink_pcs_to_qpcs_mii(pcs);
>> +	struct ipq_pcs *qpcs = qpcs_mii->qpcs;
>> +	int index = qpcs_mii->index;
>> +
>> +	switch (state->interface) {
>> +	case PHY_INTERFACE_MODE_SGMII:
>> +	case PHY_INTERFACE_MODE_QSGMII:
>> +		ipq_pcs_get_state_sgmii(qpcs, index, state);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	dev_dbg(qpcs->dev,
>> +		"mode=%s/%s/%s link=%u\n",
>> +		phy_modes(state->interface),
>> +		phy_speed_to_str(state->speed),
>> +		phy_duplex_to_str(state->duplex),
>> +		state->link);
> 
> This will get very noisy given that in polling mode, phylink will call
> this once a second - and I see you are using polling mode.
> 

Sure, I will use dev_dbg_ratelimited() API instead.

>> +/**
>> + * ipq_pcs_create() - Create an IPQ PCS MII instance
>> + * @np: Device tree node to the PCS MII
>> + *
>> + * Description: Create a phylink PCS instance for the given PCS MII node @np
>> + * and enable the MII clocks. This instance is associated with the specific
>> + * MII of the PCS and the corresponding Ethernet netdevice.
>> + *
>> + * Return: A pointer to the phylink PCS instance or an error-pointer value.
>> + */
>> +struct phylink_pcs *ipq_pcs_create(struct device_node *np)
>> +{
>> +	struct platform_device *pdev;
>> +	struct ipq_pcs_mii *qpcs_mii;
>> +	struct device_node *pcs_np;
>> +	struct ipq_pcs *qpcs;
>> +	int i, ret;
>> +	u32 index;
>> +
>> +	if (!of_device_is_available(np))
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	if (of_property_read_u32(np, "reg", &index))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (index >= PCS_MAX_MII_NRS)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	pcs_np = of_get_parent(np);
>> +	if (!pcs_np)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	if (!of_device_is_available(pcs_np)) {
>> +		of_node_put(pcs_np);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	pdev = of_find_device_by_node(pcs_np);
>> +	of_node_put(pcs_np);
>> +	if (!pdev)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	qpcs = platform_get_drvdata(pdev);
>> +	put_device(&pdev->dev);
>> +
>> +	/* If probe is not yet completed, return DEFER to
>> +	 * the dependent driver.
>> +	 */
>> +	if (!qpcs)
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +
>> +	qpcs_mii = kzalloc(sizeof(*qpcs_mii), GFP_KERNEL);
>> +	if (!qpcs_mii)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	qpcs_mii->qpcs = qpcs;
>> +	qpcs_mii->index = index;
>> +	qpcs_mii->pcs.ops = &ipq_pcs_phylink_ops;
>> +	qpcs_mii->pcs.neg_mode = true;
>> +	qpcs_mii->pcs.poll = true;
>> +
>> +	for (i = 0; i < PCS_MII_CLK_MAX; i++) {
>> +		qpcs_mii->clk[i] = of_clk_get_by_name(np, pcs_mii_clk_name[i]);
>> +		if (IS_ERR(qpcs_mii->clk[i])) {
>> +			dev_err(qpcs->dev,
>> +				"Failed to get MII %d interface clock %s\n",
>> +				index, pcs_mii_clk_name[i]);
>> +			goto err_clk_get;
>> +		}
>> +
>> +		ret = clk_prepare_enable(qpcs_mii->clk[i]);
>> +		if (ret) {
>> +			dev_err(qpcs->dev,
>> +				"Failed to enable MII %d interface clock %s\n",
>> +				index, pcs_mii_clk_name[i]);
>> +			goto err_clk_en;
>> +		}
> 
> Do you always need the clock prepared and enabled? If not, you could
> do this in the pcs_enable() method, and turn it off in pcs_disable().
> 

Yes, it can be moved to pcs_enable/pcs_disable method. I will make this 
change.

> I think phylink may need a tweak to "unuse" the current PCS when
> phylink_stop() is called to make that more effective at disabling the
> PCS, which is something that should be done - that's a subject for a
> separate patch which I may send.
> 



