Return-Path: <netdev+bounces-125345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD32396CC7B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 04:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604701F229EE
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5C718B09;
	Thu,  5 Sep 2024 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jwTeoRLo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBDFEAF6
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 02:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725501958; cv=none; b=R36UyOGnd0kfE6+OE43Fc1TBy4+oUtwZwfths759t0Bzzc6NkwjMk673ocx7bkFjPE6BDX2l5xW9KMbcPJwiS5n0aPecR0BNEY6kImW++p6mckAyfaBMwAo1Zpce1rSKvt/7BldmOdVNJFi0qBmy8u8+d2UFjIANP/E057qR8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725501958; c=relaxed/simple;
	bh=Pf1Wrk3NEAFUxLClRr4VrE3W93nf/nbSAF3Fdi9O1OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ByR2Q//ISiaIrSHDqx56m+ZD3n9bOJmV4bpnXt5RBJRi0JTByMYMFUVABRXKs6k33eqzUkjq+gSCV6Zj9DLUJLhTCtIojQaNRt5uXlQxrK84JQ1Ki/iDE0x4H14xFSs3XgUefOxEQ/AcF7JR6cm+4rFVV+uV3gs5Wgq9QEW0iwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jwTeoRLo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4850rGsO003593;
	Thu, 5 Sep 2024 02:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+JI2V/1jxpPZ4pbTR7FaveC1IbFHqMaF/rrhMycRsCA=; b=jwTeoRLoYxO013Ll
	hNI3ihFu93zwiOgIiPBfMxL3dmze+Q1VBDzJILiKq0o8DBM0OIoivRKLo7wIsBGe
	923H4JijIExcEQue+Zq36R+LUUXFA57N7+94x9htynrA/LVMBXrdfqcKiVz0dpyR
	9XcdZ5c2RxoUbPdiY7wBS1PBckuwDuNRDGorlbxCDrNlmedDXRiQeLXEG4AF+zn5
	U+1N8tcJifehjPQRUh+86Nxddu9MJfTbmoW+AkS51z5RPBCanuhVjo4eRHsRPO9t
	xwbG/C29L2qvws0Yl5KMsljbBo0V1yTCBM3VbtVXh2oI2620CCpCosnT4YVnnfEO
	YY1RpQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41buxfc9q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 02:05:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48525YVE028438
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 02:05:34 GMT
Received: from [10.110.105.58] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 19:05:30 -0700
Message-ID: <e9ef3235-8e35-4918-a2a4-76573034ca59@quicinc.com>
Date: Wed, 4 Sep 2024 19:05:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: stmmac: Programming sequence for VLAN
 packets with split header
To: Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
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
 <c29ae5b4-fa2f-4dad-b32f-86838d846d35@quicinc.com>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <c29ae5b4-fa2f-4dad-b32f-86838d846d35@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oSj-lMejUqYyyDRfPINlvdFFLLWhi40c
X-Proofpoint-ORIG-GUID: oSj-lMejUqYyyDRfPINlvdFFLLWhi40c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_01,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409050015



On 9/4/2024 6:12 PM, Sagar Cheluvegowda wrote:
> 
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>> index e0165358c4ac..dbd1be4e4a92 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>> @@ -526,6 +526,17 @@ static void dwmac4_enable_sph(struct stmmac_priv *priv, void __iomem *ioaddr,
>>  	value |= GMAC_CONFIG_HDSMS_256; /* Segment max 256 bytes */
>>  	writel(value, ioaddr + GMAC_EXT_CONFIG);
>>  
>> +	/* Additional configuration to handle VLAN tagged packets */
>> +	value = readl(ioaddr + GMAC_EXT_CFG1);
>> +	value &= ~GMAC_CONFIG1_SPLM;
>> +	/* Enable Split mode for header and payload at L2  */
>> +	value |= GMAC_CONFIG1_SPLM_L2OFST_EN << GMAC_CONFIG1_SPLM_SHIFT;
>> +	value &= ~GMAC_CONFIG1_SAVO;
>> +	/* Enables the MAC to distinguish between tagged vs untagged pkts */
>> +	value |= 4 << GMAC_CONFIG1_SAVO_SHIFT;
> I checked the data book internally and see SAVO bit is used to indicate the
> valueof the offset from the beginning of Length/Type field at which the header 
> should be split, i see the length/type field remains to be 2bytes even in case
> of tagged packets may be you need to keep the value of this field to 2bytes as
> it was before but one thing which i am still not able to understand is that even
> with the value of this field configured to 4 i don't see any packet corruption
> issue, something which needs to be checked with HW folks. 

Good catch Sagar. Let me check this internally and get back. 

>> +	value |= GMAC_CONFIG1_SAVE_EN;
>> +	writel(value, ioaddr + GMAC_EXT_CFG1);
>> +
>>  	value = readl(ioaddr + DMA_CHAN_CONTROL(dwmac4_addrs, chan));
>>  	if (en)
>>  		value |= DMA_CONTROL_SPH;

