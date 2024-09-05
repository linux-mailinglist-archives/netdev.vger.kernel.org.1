Return-Path: <netdev+bounces-125337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F2696CC1A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 03:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8751C21E62
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45EE6FDC;
	Thu,  5 Sep 2024 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O4u5z8cp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890E9450
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498776; cv=none; b=PwajqML1zT/tvj/1ShTIhSN8kU+ZxTeHh3VNQY0rVwUqq97tMHoodCQG2jVKRgbZt/itURcwStTuCo/zW2bht2sE9CcYTl2DYwoAabuuTOXpXYBUTQOFbwsVo6F+m6C0XGhuRMQotH4OlCXwL2TuMimatmDYzrZ0D6/Og9xQsUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498776; c=relaxed/simple;
	bh=sV+F6zESFECPlMIee649MKaowV9eHpoCdJ0gSFQ/0Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k9mSiJoRQ2BNlpukZrcBWtbSr6XyBp3MxZzYw/piurneDRVjryzn6K0/PH+7SQxJnaWPEbz/9M5oSPOvnnFbtlkUGEZs6GEzQyC9EQHXgQylLkRDFnBY4H8Dzn4/vpcB7LmRBQvKIcNoGoWtw77iAcHwVXDiDpJL1dJyIfgoZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O4u5z8cp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484N6Qp3026158;
	Thu, 5 Sep 2024 01:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DaFVzteQcTS91Pzq56hORp/0FM9sIlD3bDOCtoT/f7o=; b=O4u5z8cpHGSKejjg
	nRjWtHAZVWDom9cnYuorz/bOWbf6/aJSawGbg0Ym1iO+TgduOBFXp5uU2S3BpS+r
	Mc5gP61OPYjxR3rtY4Wfqt7q9EXGk5t7ZMgGvZffcu5WkpyX35xNho3sqAVdFCji
	Ek4gzidDoh2FgavW3JVGH2gF6IEYbd9qvGHX9nNuYln8bIhPxC0rb7Jev2EoHyby
	tkqAXqGm/41yLcqIrNcrKJACXoTJ0zzbAo6Zw2XiFYWd0GxGAq+Ph+lJl3i+vw4e
	uHAA3N0qrhTROVdC9Nf8/pf2zCM1+3hnOTVuP2aSRGPWN8jcMZshqwOV+5bJ3e2v
	iNftfw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt674g60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 01:12:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4851CPeb007961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 01:12:25 GMT
Received: from [10.110.126.71] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 18:12:22 -0700
Message-ID: <c29ae5b4-fa2f-4dad-b32f-86838d846d35@quicinc.com>
Date: Wed, 4 Sep 2024 18:12:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: stmmac: Programming sequence for VLAN
 packets with split header
To: Abhishek Chauhan <quic_abchauha@quicinc.com>,
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
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Halaney <ahalaney@redhat.com>
CC: <kernel@quicinc.com>
References: <20240904235456.2663335-1-quic_abchauha@quicinc.com>
Content-Language: en-US
From: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
In-Reply-To: <20240904235456.2663335-1-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lDecve-zp8ecw29PMTebNsli8RAxgHIk
X-Proofpoint-GUID: lDecve-zp8ecw29PMTebNsli8RAxgHIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_22,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050007


> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index e0165358c4ac..dbd1be4e4a92 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -526,6 +526,17 @@ static void dwmac4_enable_sph(struct stmmac_priv *priv, void __iomem *ioaddr,
>  	value |= GMAC_CONFIG_HDSMS_256; /* Segment max 256 bytes */
>  	writel(value, ioaddr + GMAC_EXT_CONFIG);
>  
> +	/* Additional configuration to handle VLAN tagged packets */
> +	value = readl(ioaddr + GMAC_EXT_CFG1);
> +	value &= ~GMAC_CONFIG1_SPLM;
> +	/* Enable Split mode for header and payload at L2  */
> +	value |= GMAC_CONFIG1_SPLM_L2OFST_EN << GMAC_CONFIG1_SPLM_SHIFT;
> +	value &= ~GMAC_CONFIG1_SAVO;
> +	/* Enables the MAC to distinguish between tagged vs untagged pkts */
> +	value |= 4 << GMAC_CONFIG1_SAVO_SHIFT;
I checked the data book internally and see SAVO bit is used to indicate the
valueof the offset from the beginning of Length/Type field at which the header 
should be split, i see the length/type field remains to be 2bytes even in case
of tagged packets may be you need to keep the value of this field to 2bytes as
it was before but one thing which i am still not able to understand is that even
with the value of this field configured to 4 i don't see any packet corruption
issue, something which needs to be checked with HW folks. 
> +	value |= GMAC_CONFIG1_SAVE_EN;
> +	writel(value, ioaddr + GMAC_EXT_CFG1);
> +
>  	value = readl(ioaddr + DMA_CHAN_CONTROL(dwmac4_addrs, chan));
>  	if (en)
>  		value |= DMA_CONTROL_SPH;

