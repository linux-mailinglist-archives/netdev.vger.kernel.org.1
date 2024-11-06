Return-Path: <netdev+bounces-142217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6719BDD80
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 04:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2B91C23280
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A05190056;
	Wed,  6 Nov 2024 03:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YfRrBN2M"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F8318FDB1;
	Wed,  6 Nov 2024 03:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730863027; cv=none; b=FpzBqaJ/r1hVNqSVA4CHBUX1q523NDrhAcnDtm5OZGjv4Nq6TAAGC8EAI1N3oze0Ut8WqISz3WDRAkOSa2CPk0M3mz8fJZt9Ltov9prUvBHuxmj7tBHTfoJnzTAo+zs5BePuEx6jrj15TqhL0pxFo7AxiCmBhVJB2Kd68riF+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730863027; c=relaxed/simple;
	bh=DACGt92rTFPfameQs8D2whJQLHsEhqs7UbOv2+TxXPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m0RdGi2wUgMh3meNJlkLGeGe0RiWFhX5Lbp5gppkVcZDclQlhpSqHRW9g/0YOidqTr51X92+rGLOx2DMpt3cK+/dYVbg6ZMZrSAuwD4Iu/gdKJuiEYHVgyhsGzEAvMhUlTLxxd8S5GWaL4MbJ9UJbmFUJb/2lqgL/bc31HdZTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YfRrBN2M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5KABKI009100;
	Wed, 6 Nov 2024 03:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1J8mfxCbiCDTDsZI2fUKWhtK0rZUEtEtd+IltNnj4C0=; b=YfRrBN2MDCDDCErh
	p2ZPkAtvYwpBILfpkXLweswe0uB9e56nEQ/Yr+issXriljA/FD37Q1evbfWNnmVj
	CrZm67ZGpCRglTcMs91zHyChwV0bk4E5slNFwSBbOIHa+2N9wE10bRaX3JZISIRj
	JbYIbQOvd0JXF9QUX4Ugzx8U0Cy0MbM095rrETD2uu72zUPEMw48hqC6CexNbEDA
	s37/GY04QHHrIEAVhVA7YbhJdZMBGi8GBygH9RGr4w96ZGLvxv9frIrOo8rW4eNp
	imIhf8vgWJ4F8wgVzqdjTjizeLIjzh952Sg7qws2HXxu4oS06oAYuP10AAjCsStD
	Wb28Ig==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd4usrjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 03:16:46 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A63Gjqh029314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 03:16:45 GMT
Received: from [10.253.14.204] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 5 Nov 2024
 19:16:40 -0800
Message-ID: <9b3a4f00-59f2-48d1-8916-c7d7d65df063@quicinc.com>
Date: Wed, 6 Nov 2024 11:16:37 +0800
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
Content-Language: en-US
From: Lei Wei <quic_leiwei@quicinc.com>
In-Reply-To: <d7782a5e-2f67-4f62-a594-0f52144a368f@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xEBCrXy7c1m6E8BxoqRRcRdiq2ueaRo_
X-Proofpoint-ORIG-GUID: xEBCrXy7c1m6E8BxoqRRcRdiq2ueaRo_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060024



On 11/1/2024 9:21 PM, Andrew Lunn wrote:
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
> 
> How does Qualcomm SGMII AN mode differ from Cisco SGMII AN mode?
> 

Qualcomm SGMII AN mode extends Cisco SGMII spec Revision 1.8 by adding 
pause bit support in the SGMII word format. It re-uses two of the 
reserved bits 1..9 for this purpose. The PCS supports both Qualcomm 
SGMII AN and Cisco SGMII AN modes.

>> +static int ipq_pcs_config_sgmii(struct ipq_pcs *qpcs,
>> +				int index,
>> +				unsigned int neg_mode,
>> +				phy_interface_t interface)
>> +{
>> +	int ret;
>> +
>> +	/* Access to PCS registers such as PCS_MODE_CTRL which are
>> +	 * common to all MIIs, is lock protected and configured
>> +	 * only once. This is required only for interface modes
>> +	 * such as QSGMII.
>> +	 */
>> +	if (interface == PHY_INTERFACE_MODE_QSGMII)
>> +		mutex_lock(&qpcs->config_lock);
> 
> Is there a lot of contention on this lock? Why not take it for every
> interface mode? It would make the code simpler.
> 

I agree, the contention should be minimal since the lock is common for 
all MII ports in a PCS and is used only during configuration time. I 
will remove the interface mode check.

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
> 
> How have you got this far if the parent is not available?
> 

This check can fail only if the parent node is disabled in the board 
DTS. I think this error situation may not be caught earlier than this 
point.
However I agree, the above check is redundant, since this check is 
immediately followed by a validity check on the 'pdev' of the parent 
node, which should be able cover any such errors as well.

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
>> +	}
> 
> Maybe devm_clk_bulk_get() etc will help you here? I've never actually
> used them, so i don't know for sure.
> 

We don't have a 'device' associated with the 'np', so we could not 
consider using the "devm_clk_bulk_get()" API.

> 	Andrew


