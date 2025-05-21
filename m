Return-Path: <netdev+bounces-192297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16ECABF4D4
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A0307AAD2D
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA03A26C3BC;
	Wed, 21 May 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DQOlnmv/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26789267B74;
	Wed, 21 May 2025 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831962; cv=none; b=pzSEvbxrnEzYki/9huwD9aZzAP1ZFLb9JadHIkAagvqwFfxI4vj2rkUrzRETCSpe7mFQ46SaK3HkVkgPrOhAVEw9GG6ildo25pE0ScuSDP+WdPr1FdFMKfEg95jqerCvA73OTC4qu8gJDayZIhPBymXjioo+FgOlaf8fb523/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831962; c=relaxed/simple;
	bh=rgboF6O42TahFs/8pXgNbmH2+IAqnYb0uPyGcWYivRM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Sjw1slXKObLfbQZh4xk4yS86FJCQhLnszBVvs6DgtC8q3nftNOdRch39mycMOkX3lBvoCtt6OGuAoNhvzfBMfrVz8IU+iuVaCgZofO2+EyTwoEyi1TjqZckx+L6nzoarHQb/r2u5atJLw9ATX/EoZjdwFMb/PUMeXUBMPH4iquQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DQOlnmv/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XNIu029164;
	Wed, 21 May 2025 12:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zAkNkquuUoYz7N8pVRuD9/VogaSosp8jzMIXjAaUFXs=; b=DQOlnmv/yR7/cuRp
	dnHWHgqEi+r8gdlhjgt8IvX64z4XfQ2QpKecAzWnh4sp638MdHpRurNkYctpCKV9
	SzRNqNN+qhRvV9giFDlONaIRO5iQXEmGc2V7WKowEY5oIcnvG2cF3vkHLhY2lKT6
	h1F0EoqikmiCzKHCJhEMRqJg/uCqGQgs8fAV/BeQKsititybyNlCV1DOvhdXh0Vs
	BA1JZxGl7NzBPtnFBhm93NdQN3JVkjzs0WyDrMY3wD4cO5g4qzqDTSrIHYMRDoQc
	Bo/+W6NCF56RkRZl4cVMGIBrUXbNfjmZKGSwil21shQSHJz6SkiMzeucqeZsNjCX
	tBXosw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf430us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 12:52:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54LCqBI6021618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 12:52:11 GMT
Received: from [10.253.72.103] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 05:52:08 -0700
Message-ID: <a7edb7e8-37ac-45ae-b5c7-2c9034dce4d7@quicinc.com>
Date: Wed, 21 May 2025 20:50:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Lei Wei <quic_leiwei@quicinc.com>
Subject: Re: [net-next PATCH v4 03/11] net: pcs: Add subsystem
To: Sean Anderson <sean.anderson@linux.dev>, <netdev@vger.kernel.org>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
CC: <upstream@airoha.com>, Kory Maincent <kory.maincent@bootlin.com>,
        Simon
 Horman <horms@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        <linux-kernel@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
References: <20250512161013.731955-1-sean.anderson@linux.dev>
 <20250512161013.731955-4-sean.anderson@linux.dev>
 <e92c87cf-2645-493c-b9d3-ce92249116d1@quicinc.com>
 <4556e55b-2360-4780-a282-b2f04f5cc994@linux.dev>
Content-Language: en-US
In-Reply-To: <4556e55b-2360-4780-a282-b2f04f5cc994@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEyNCBTYWx0ZWRfX5PbrLYDXKQWN
 uA4IqaIqcLFXtjMfEtGdnJAjsZ0l8dStAF2Wa8I401PwZVMy+972FVizFtdaq4eMFYzBuBUERH1
 Q/BxixJHLfyyRlksqyOS7YZJlIarxHHwhLe9e0Bmzqjs/MhfgIqSOnry4TrOrgl5IMEiwrwSKQ+
 DYuxDnXaNn1LWTxjxFobossQ7VwPCCwSQwuJA6y9DA0deMbaAst7VWKUUnb7assHoQAZlhMxuIo
 tIaW8/WXrSKv62kquiOxJU6GvCCCAavlqdvTFfdxD72fd33AjEX+RN55PylCOANP9HkPTZv4/pA
 OnNNsrERJbATPA0Y2OjsjyxT64wb9TCow+73yy2gzCmlogRwOWNizu3DzS6589SgO8SJ9Lkwy+j
 XW+klpxtSor22+03ojDZubcB5cSLCE4y9yFEg/3Hz3MJpGbitRs/Fg+O3BpnIaxZlg2qFuSS
X-Proofpoint-GUID: qNMarVzvYdQZ0J3EKqySIf0AQkmmAfEk
X-Authority-Analysis: v=2.4 cv=Ws8rMcfv c=1 sm=1 tr=0 ts=682dcc7c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=eH__3MDfRxuffPQLZlIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qNMarVzvYdQZ0J3EKqySIf0AQkmmAfEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210124



On 5/20/2025 1:43 AM, Sean Anderson wrote:
> On 5/14/25 12:22, Lei Wei wrote:
>>
>>
>> On 5/13/2025 12:10 AM, Sean Anderson wrote:
>>> +/**
>>> + * pcs_register_full() - register a new PCS
>>> + * @dev: The device requesting the PCS
>>> + * @fwnode: The PCS's firmware node; typically @dev.fwnode
>>> + * @pcs: The PCS to register
>>> + *
>>> + * Registers a new PCS which can be attached to a phylink.
>>> + *
>>> + * Return: 0 on success, or -errno on error
>>> + */
>>> +int pcs_register_full(struct device *dev, struct fwnode_handle *fwnode,
>>> +              struct phylink_pcs *pcs)
>>> +{
>>> +    struct pcs_wrapper *wrapper;
>>> +
>>> +    if (!dev || !pcs->ops)
>>> +        return -EINVAL;
>>> +
>>> +    if (!pcs->ops->pcs_an_restart || !pcs->ops->pcs_config ||
>>> +        !pcs->ops->pcs_get_state)
>>> +        return -EINVAL;
>>> +
>>> +    wrapper = kzalloc(sizeof(*wrapper), GFP_KERNEL);
>>> +    if (!wrapper)
>>> +        return -ENOMEM;
>>
>> How about the case where pcs is removed and then comes back again? Should we find the original wrapper and attach it to pcs again instead of creating a new wrapper?
> 
> When the PCS is removed the old wrapper is removed from pcs_wrappers, so
> it can no longer be looked up any more. I think trying to save/restore
> the wrapper would be much more trouble than it's worth.
> 

In the case where Ethernet is not removed but PCS is removed and then
comes back (when the sysfs unbind followed by bind method is used),
it will not work because the Ethernet probe will not be initiated again, 
to call "pcs_get" again to obtain the new wrapper, it would still hold 
the old wrapper.

> --Sean


