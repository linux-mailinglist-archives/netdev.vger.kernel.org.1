Return-Path: <netdev+bounces-210792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4594B14D28
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 13:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC70818A18B0
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944BD21B8E7;
	Tue, 29 Jul 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tx2TQrrz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE6E28F51B
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753789560; cv=none; b=Ou3yZEpkiJv/tq2K206pR81vj7Yr34dxV0+s3smXBx6sT10u6iMqsG9gQflbcjQsRwJN5Fcr/NpRPd/xoXndLU1Ff8pq9J9r7W9lvmWph8pMC4s8al5430tyZr7bI1vNakNE+hNVUQ7bN3RNrvV1BEQNHnHPG1lwxJZoZlNTu+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753789560; c=relaxed/simple;
	bh=vcPIRm/ScqP46BgosoJr/lkPi5rv8qGicj6Gv0Ydp5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b67nmU9iZE3crXyKp8a3LUn/v0XNAyPc/QiH0nceK1q1LuN6IKJJnPvvlQdnkvV/xplHK9Ft/ZAL9Zl1gWBc14l9GEMR42sdj3s45Y4MOpI974mVbGabnGK5hj1xXUwwOuG0MNG8H1ECeLl/kcVjY5N9Id2DG9voaFnWpTg8m9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tx2TQrrz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9DkJi018302;
	Tue, 29 Jul 2025 11:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FwfQ57/ZPL+/CP3NSvEOHoG4w+TICt4Fp7qs3Ld30Pk=; b=Tx2TQrrzaurkX5k2
	hiebH+7yPBgiVqfppIruHO4n/Gyi9G/tCM5+Wim01jeYv7+UsWmn+P1m/Pq7LAkG
	/9kFCBAS62k+ghah6UuLphWiXa9+VtDoedARsNeuZtDw7qHjWsyNoPKpmVXJTgnY
	3QKfhq+XhOqwae01T1A7M/4gOLDtihRZI0F16HaZItGLccjXBs0HPkfbFC0r4jf0
	Wn87HVH141H3Rj2sOflD1qnYwfN6oUMPBwA80v7+uslnSxm03Kh18imYDk+SQHYh
	TPCNqacPvMa3ERCe5fvWFBXrwerImmOSIwBCy5zgiw4dTnAFAmLUBEO2GpCBYDeM
	eA3+KQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbkyv4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 11:45:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56TBjoG7018309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 11:45:50 GMT
Received: from [10.218.43.155] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 29 Jul
 2025 04:45:47 -0700
Message-ID: <85b87295-ad23-4526-9447-b6b1b47ef51c@quicinc.com>
Date: Tue, 29 Jul 2025 17:15:37 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Add locking to protect skb->dev access in ip_output
To: Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <quic_kapandey@quicinc.com>, <quic_subashab@quicinc.com>
References: <20250723082201.GA14090@hu-sharathv-hyd.qualcomm.com>
 <CANn89iLx29ovUNTp9DjzzeeAOZfKvsokztp_rj6qo1+aSjvrgw@mail.gmail.com>
 <7ffcb4d4-a5b4-4c87-8c92-ef87269bfd07@quicinc.com>
 <CANn89iJwM2-rueNzEdOOUuTF7DV=yT+qAFUJsEDqiMJzdjf=-g@mail.gmail.com>
Content-Language: en-US
From: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
In-Reply-To: <CANn89iJwM2-rueNzEdOOUuTF7DV=yT+qAFUJsEDqiMJzdjf=-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=6888b46f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=RQhb_X5OQiy-zTECqLIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA5MSBTYWx0ZWRfX7YWtzpRhW73e
 VcReObDVBaDsER0ssuQnTzMkxUMVZdommgEwm1xnl3FGkSFYQ2prPb6U/v+WcDIzN1hp2jkqPsp
 4ptg48pjNwgJ5F2a20b3h5WzraDm6tuJIcNShIYHYYDIsEOthGZmgb67u/YSvWOwyb0jjiiAKKW
 AfrBisPYZl1aatw/qbT9HYk7BHi3jLacy9qz6IyNEAIovhoGRH7ZmEpwRLBmv6y8fFtO+pam8m8
 V1uGG7mhXROlWQkz2xCiawUBzsb8OF4JuhI6BfbV0qjIGKx+lj3O3Th6kokA4MguxpkrQDDVqhf
 Ixjtj0Wls5LqYuGWBFEY3vNR2SsK14DsWA5+/yxMiPXc2gTcJacCKnKnP5Y5LR4O2ymGFsv80ut
 GVSOJt5FoEubuouDTbBABQXCfhCeNAggZ0jrBCv3E6YafpMNn57xrQxq8/Fp0LnAuRbdujPk
X-Proofpoint-ORIG-GUID: SthXAk58ErDDYRN0D7ur5cZYXmHS7KeC
X-Proofpoint-GUID: SthXAk58ErDDYRN0D7ur5cZYXmHS7KeC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=499 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290091


On 7/24/2025 1:33 PM, Eric Dumazet wrote:
> On Wed, Jul 23, 2025 at 11:16 PM Sharath Chandra Vurukala
> <quic_sharathv@quicinc.com> wrote:
>>
>>
>> Thanks Eric for the review, as this work is already underway on your end, I’ll pause and wait for your changes to become available.
> 
> Hi Sharath
> 
> I think you definitely can send a patch, I was not trying to say you
> could not do it.
> 
> Just pointing out what the plan was :)
> 
> Feel free to use my suggested patch, test it and send a V2
> 
> Thanks.
Thanks Eric, have sent a v2 patch with your suggested changes. 


