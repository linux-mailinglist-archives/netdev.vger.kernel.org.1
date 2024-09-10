Return-Path: <netdev+bounces-127158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B8997465B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 01:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8D6287B85
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 23:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061BA1ABEC0;
	Tue, 10 Sep 2024 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kV5Qcpp1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423A51AAE39
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 23:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726010751; cv=none; b=I3QLFmaAmISaK+VwRrWZnMUqTfHfCDGCHjF1BoQm+RQVBNo6QxLuRybXOKwVNmhzX12/53lTD1brTg5JPyQH09EI1vqE4eXBYeKyVt/FmFyTefvMFmU1HT91HyQ/+PJ7U/51LwCUNmldW490EHhQEP9LzO/wRkwqLzFl4zNo2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726010751; c=relaxed/simple;
	bh=kupMtfs95tdCffu17Dz42Rx/ye0pirz2ak7f/Sx+l9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T+zVts8GL2v66o4tiH586q+LUoRpEO7B7m5Y7u56pEskOeGjEUtdgwk6AtQ1gYLJLns/AcdgSbXPeLDksKN1rf9/KH7nGO2hMy9uNrrbGJyoTzk+L74X37v0SKkWh1WPsPMUzGFrMUVCpfYQLI9rDsPuCL0c+GmDeGmCMY1mLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kV5Qcpp1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AE3csj019985;
	Tue, 10 Sep 2024 23:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tazpJVr4FmZCSc+XJCGyaVVBTYDyDer+sfJ6ey8dveQ=; b=kV5Qcpp1IQn0OXXu
	PECA9EtzalZR9y2vdGNT5/sdogT/BRRsJyBMYPCppEDDiLzTy4Wbb9rljHkBv1o8
	nRI3wyjPxkAlxW3bpxO5VSVSudEkf4n3Q9XSPSwNhI/Grf3sZcud6RRNYbf4koGk
	TG5khq7tyJvXWa6Vk/vAaNhkflBiolud/DnUWNiIsVC7fWYrNcp47FrkWlHcmAk/
	ju4HvREBeeoqPuMSLn37u0wpbIop4Tu1Y+0UmB9bd8EKvscorZrwU3LNhZYU5RPn
	VJ9hm4ptlsxGxxaUhlg5m17eVEPz2fH1dH3NRSAFj0PgqNEBw+SGgWtPARmc5irV
	ud+8GA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy59ynfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 23:25:17 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48ANPGS8031162
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 23:25:16 GMT
Received: from [10.110.103.26] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Sep
 2024 16:25:13 -0700
Message-ID: <209287d5-4dac-48e1-ad15-6fd207bdbc9e@quicinc.com>
Date: Tue, 10 Sep 2024 16:25:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: stmmac: Programming sequence for VLAN
 packets with split header
To: Andrew Halaney <ahalaney@redhat.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu
	<joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@quicinc.com>
References: <20240904235456.2663335-1-quic_abchauha@quicinc.com>
 <jfibug2d5ch6isoop3gbjkbt2kbk2bvhvschnwclyr42p2aqmn@2iigwb3jk5ew>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <jfibug2d5ch6isoop3gbjkbt2kbk2bvhvschnwclyr42p2aqmn@2iigwb3jk5ew>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uGvC3eZkW5gHsM6B4mOhk4EBMtQdCm0r
X-Proofpoint-ORIG-GUID: uGvC3eZkW5gHsM6B4mOhk4EBMtQdCm0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100176



On 9/6/2024 2:49 PM, Andrew Halaney wrote:
> On Wed, Sep 04, 2024 at 04:54:56PM GMT, Abhishek Chauhan wrote:
>> Currently reset state configuration of split header works fine for
>> non-tagged packets and we see no corruption in payload of any size
>>
>> We need additional programming sequence with reset configuration to
>> handle VLAN tagged packets to avoid corruption in payload for packets
>> of size greater than 256 bytes.
>>
>> Without this change ping application complains about corruption
>> in payload when the size of the VLAN packet exceeds 256 bytes.
>>
>> With this change tagged and non-tagged packets of any size works fine
>> and there is no corruption seen.
> 
> My real limited understanding from offline convos with you is that:
> 
>     1. This changes splitting from L3 mode to L2? This maybe a "dumb"
>        wording, but the L2 comment you have below reinforces that.
>        Sorry, I don't have a very good mental model of what SPH is doing
i will explain more in detail as part of my next patch.From what i understood from the databook is
MAC has intelligence to know if the packet has VLAN header vs Normal Ethernet frame. 
Based on that the programming sequence is followed to make sure split happens correctly 
for Vlan packet vs non-Vlan packet. 

>     2. This addresses the root issue of a few of the commits in
>        stmmac that disable split header? Patches like
>        47f753c1108e net: stmmac: disable Split Header (SPH) for Intel platforms
>        029c1c2059e9 net: stmmac: dwc-qos: Disable split header for Tegra194
>        ?
> 
> If 1 is true I suggest making trying to paint a higher level intro picture to
> reviewers of what the prior programming enabled vs what you've enabled.
> It would help me at least!
> 
> If 2 is true I suggest calling that out and Cc'ing the authors of those
> patches in hopes that they may try and re-enable SPH. If its not true
> (maybe there's an errata?) I'd be interested in knowing if there's a more
> generic way to disable SPH for those platforms instead of playing
> whack-a-mole per platform. That's a bit outside of the series here though,
> but I imagine you may have enough information to help answer those sort of
> questions and clean up the house here :)
I will add the folks in cc. If they are interested to test this out its even
better.

> 
> Thanks,
> Andrew
> 
> 
>>
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>> ---
>> Changes since v0
>> - The reason for posting it on net-next is to enable this new feature.
>>
>>  drivers/net/ethernet/stmicro/stmmac/dwmac4.h     |  9 +++++++++
>>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 11 +++++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
>> index 93a78fd0737b..4e340937dc78 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
>> @@ -44,6 +44,7 @@
>>  #define GMAC_MDIO_DATA			0x00000204
>>  #define GMAC_GPIO_STATUS		0x0000020C
>>  #define GMAC_ARP_ADDR			0x00000210
>> +#define GMAC_EXT_CFG1			0x00000238
>>  #define GMAC_ADDR_HIGH(reg)		(0x300 + reg * 8)
>>  #define GMAC_ADDR_LOW(reg)		(0x304 + reg * 8)
>>  #define GMAC_L3L4_CTRL(reg)		(0x900 + (reg) * 0x30)
>> @@ -235,6 +236,14 @@ enum power_event {
>>  #define GMAC_CONFIG_HDSMS_SHIFT		20
>>  #define GMAC_CONFIG_HDSMS_256		(0x2 << GMAC_CONFIG_HDSMS_SHIFT)
>>  
>> +/* MAC extended config1 */
>> +#define GMAC_CONFIG1_SAVE_EN		BIT(24)
>> +#define GMAC_CONFIG1_SPLM		GENMASK(9, 8)
>> +#define GMAC_CONFIG1_SPLM_L2OFST_EN	BIT(0)
>> +#define GMAC_CONFIG1_SPLM_SHIFT		8
>> +#define GMAC_CONFIG1_SAVO		GENMASK(22, 16)
>> +#define GMAC_CONFIG1_SAVO_SHIFT		16
>> +
>>  /* MAC HW features0 bitmap */
>>  #define GMAC_HW_FEAT_SAVLANINS		BIT(27)
>>  #define GMAC_HW_FEAT_ADDMAC		BIT(18)
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
>> +	value |= GMAC_CONFIG1_SAVE_EN;
>> +	writel(value, ioaddr + GMAC_EXT_CFG1);
>> +
>>  	value = readl(ioaddr + DMA_CHAN_CONTROL(dwmac4_addrs, chan));
>>  	if (en)
>>  		value |= DMA_CONTROL_SPH;
>> -- 
>> 2.25.1
>>
> 

