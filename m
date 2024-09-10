Return-Path: <netdev+bounces-127156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C5797464C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 01:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88167287A23
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 23:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D77B198A21;
	Tue, 10 Sep 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ccaZlUTA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5421E498
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726010425; cv=none; b=FtHDPa06rZS76asFSI1UGUSQRqC2Yzkh+E5GeqJ3wET7ofzUCjM0ZWJoHW4FTgkwGabYsVafVROunPVazJXslBPlC1vEG5YGjA781ylxhWrV9WPDRv5ZA7r8A4T7ToHG+++CBti/peQ0mzWNKOHzSUSWf2HSfz6tCMPRWU9+pXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726010425; c=relaxed/simple;
	bh=OEKwZ9DZD+3qrtyu4PG31y9YsdaNQKCkyxrLff+OoKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jIWKrpD7ydGHT7o5RReOVR8u4POyLeE9tDv6k9viq2hRK561MJqEviG3lnEHA3rk6lbn+7uAAdlCHoheBj926pgdEuazhcSQtPy1TavuXRPzkl63cC1mX3eQw8xpzsP8+rehsDx1oZgCJ7PP8xduNS6MSq6hsL0hZO37GiIl6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ccaZlUTA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AEhWJA021155;
	Tue, 10 Sep 2024 23:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cMLL+UNM94l+k/LixEppgfIGCe2D8l+aiVZ0NFKMqLA=; b=ccaZlUTAt87diMig
	kqHZYb4EGV+IBgLU6uKk5RwQ7bIGDud93KJRqmbyvKZVY0x4tv7dfiD4b5leNx2k
	8KQ8LBcNwk9MPUUvxjHnRRs/+vavgtCvuWA4B2HNZIg8XxxBHUHYUl1y27ZMqYjw
	ib8kSKjnGdsH0fE67uBiIROfng5AQz538EDMjVOHHzwn0BrZGW1Q2nVQr9wKB5eP
	d8b8CQVYOq0TlMstVS/HnpU4vehDX5p6J4OfUrlbzkk9VdtYyzGSleO8QXAqu3rv
	bDSpLrKU6ftRh08NgTTl4O+PzAlNmS/rixthuyRE/D+wIJhlaT8rrHECGoSz3ngj
	/Fdb0g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy59yn7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 23:19:59 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48ANJx9n022580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 23:19:59 GMT
Received: from [10.110.103.26] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Sep
 2024 16:19:55 -0700
Message-ID: <9ca5bc22-f02b-471a-9dbc-f9bcccee9b46@quicinc.com>
Date: Tue, 10 Sep 2024 16:19:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: stmmac: Programming sequence for VLAN
 packets with split header
To: Simon Horman <horms@kernel.org>
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
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Halaney <ahalaney@redhat.com>, <kernel@quicinc.com>
References: <20240904235456.2663335-1-quic_abchauha@quicinc.com>
 <20240906102839.GE2097826@kernel.org>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <20240906102839.GE2097826@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H6FprxXnRqt_I-9w9tFLTeXHxQ0t2ooN
X-Proofpoint-ORIG-GUID: H6FprxXnRqt_I-9w9tFLTeXHxQ0t2ooN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=980 phishscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100175



On 9/6/2024 3:28 AM, Simon Horman wrote:
> On Wed, Sep 04, 2024 at 04:54:56PM -0700, Abhishek Chauhan wrote:
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
>>
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> 
> ...
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
>> +	value |= GMAC_CONFIG1_SAVE_EN;
>> +	writel(value, ioaddr + GMAC_EXT_CFG1);
> 
> Hi Abhishek,
> 
> Perhaps it is inconsistent with the code elsewhere in this file,
> in which case I would suggest a follow-up clean-up, but I
> expect that using FIELD_PREP would both lead to cleaner code here
> and remove the need for *_SHIFT.
> 
Noted!

>> +
>>  	value = readl(ioaddr + DMA_CHAN_CONTROL(dwmac4_addrs, chan));
>>  	if (en)
>>  		value |= DMA_CONTROL_SPH;
>> -- 
>> 2.25.1
>>
>>

