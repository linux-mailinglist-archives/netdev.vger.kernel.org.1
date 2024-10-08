Return-Path: <netdev+bounces-133089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC54994835
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9AA1B25EC2
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4871DACBE;
	Tue,  8 Oct 2024 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cWcst3/J"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4851A320F;
	Tue,  8 Oct 2024 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389261; cv=none; b=QAulj+y1lCNmiomBVKA83PPimieAR8vYf/SpRbAQ2PVETuZAGcF/mL/tdz8DvWjlE6UGOFtQzJjTxEMOwP1IHX4/IQ9C6Ih+OcGeJGT8JWH4PAIK1YcYOZKhUMMvUe3aU15mzKJEWq2KkgHaioTwydQ/ZOMkAQZFCppZCkfg+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389261; c=relaxed/simple;
	bh=ouw2dRtToBF6p95IrVv+WiiU9tAPxLpXAEGKU0/rb8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=olNbvlB+LQIN3LrBnorcGfpymOoyOwpKvK00Pc0TMMFgz/H5jsyvVWJaCfnbQQIExGGcpmkQF7PBsvwcYzIYEJrBZfCcZw9ykIAP+wh8IXO9IuYfJaM0jy5iZvbFffA7AbTdsT8U6Dy9kVN5013o+zEPIiWLXZYOkDhux2CsLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cWcst3/J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4988IBAf001669;
	Tue, 8 Oct 2024 12:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8pZorrKXub6AQq6yToKSpksBjU3BFYCO9H+0Yb6Ceys=; b=cWcst3/J89CzOzqx
	wAvlvxOmN1WSrxmOkTIlDr/pkHgcA0nqARVRloTWS/1JaU15CXYDZXVJYrNk548N
	T8SqWY1w/n63N8ZtGJthbmd8NgyfSnSfHQeDVaGWxq31eFoJoe1NChwkF9jAc65e
	hubNVNNC61LOzN3PCYT6JNctQ0NRy+u3tCSHFLbTmcNxiIkehufh76qsH52YB7NJ
	l3JCKq2UP8B8nwEEd4YiYzqGjNWRDgTxIjGBymBuzqogUn9mZaRlDO9xgMTKwPUr
	Gsqz2Wxm4u3Y+MzCy9H6YgN5fRFJqDeHKyUibZTMNgvkPdVtGeKIKFV0lQeOAw/h
	hVDtmQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42513u0nwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 12:07:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 498C79eH015515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 12:07:10 GMT
Received: from [10.50.59.162] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Oct 2024
 05:07:01 -0700
Message-ID: <999ff0a1-1f8c-4220-a9d9-6dc1e0bddda6@quicinc.com>
Date: Tue, 8 Oct 2024 17:36:06 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: stmmac: allocate separate page for buffer
To: Jakub Kicinski <kuba@kernel.org>, Suraj Jaiswal <quic_jsuraj@quicinc.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu
	<joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>, Rob Herring <robh@kernel.org>,
        <kernel@quicinc.com>
References: <20240910124841.2205629-1-quic_jsuraj@quicinc.com>
 <20240910124841.2205629-2-quic_jsuraj@quicinc.com>
 <20240911165140.566d9fdb@kernel.org>
Content-Language: en-US
From: Sarosh Hasan <quic_sarohasa@quicinc.com>
In-Reply-To: <20240911165140.566d9fdb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cr1C_KImqt6DsK2c9SePOldVk5UplyB_
X-Proofpoint-GUID: cr1C_KImqt6DsK2c9SePOldVk5UplyB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=657 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080076



On 9/12/2024 5:21 AM, Jakub Kicinski wrote:
> On Tue, 10 Sep 2024 18:18:41 +0530 Suraj Jaiswal wrote:
>> Currently for TSO page is mapped with dma_map_single()
>> and then resulting dma address is referenced (and offset)
>> by multiple descriptors until the whole region is
>> programmed into the descriptors.
>> This makes it possible for stmmac_tx_clean() to dma_unmap()
>> the first of the already processed descriptors, while the
>> rest are still being processed by the DMA engine. This leads
>> to an iommu fault due to the DMA engine using unmapped memory
>> as seen below:
>>
>> arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402,
>> iova=0xfc401000, fsynr=0x60003, cbfrsynra=0x121, cb=38
>>
>> Descriptor content:
>>      TDES0       TDES1   TDES2   TDES3
>> 317: 0xfc400800  0x0     0x36    0xa02c0b68
>> 318: 0xfc400836  0x0     0xb68   0x90000000
>>
>> As we can see above descriptor 317 holding a page address
>> and 318 holding the buffer address by adding offset to page
>> addess. Now if 317 descritor is cleaned as part of tx_clean()
>> then we will get SMMU fault if 318 descriptor is getting accessed.
> 
> The device is completing earlier chunks of the payload before the entire
> payload is sent? That's very unusual, is there a manual you can quote
> on this?
Here if as part of tx clean if first descriptor is cleaned before tx complete of next
descriptor is done then we are running into this issue.
for non tso case if we see xmit code has logic to alloc different page for each fragments and same logic
we are trying for TSO case.

>> To fix this, let's map each descriptor's memory reference individually.
>> This way there's no risk of unmapping a region that's still being
>> referenced by the DMA engine in a later descriptor.
> 
> This adds overhead. Why not wait with unmapping until the full skb is
> done? Presumably you can't free half an skb, anyway.
> 
> Please added Fixes tag and use "PATCH net" as the subject tag/prefix.

