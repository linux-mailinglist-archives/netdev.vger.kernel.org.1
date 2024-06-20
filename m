Return-Path: <netdev+bounces-105490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35079116F1
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 01:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA97285856
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AE6149C65;
	Thu, 20 Jun 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VoQXnkkR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064885642;
	Thu, 20 Jun 2024 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926879; cv=none; b=f+kjkeGKgyHtgsvPVryX9XB5YFhjVXJDsDqA5mifQkPtMQnOU/nP6J0KOuHAzFANI9vx77sMJejj6lZaIX8/okj8Yg2d8opQ3xK+my+ORJNtXjWLo631O6yAC9Fnbf7LxukKXICZqZ4T2s6p7eIy14L9ycdfGmZxZaSLUMnbrkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926879; c=relaxed/simple;
	bh=ngt92kmUX1tCKCpJ1tBveqLHUuTKeOhtEKUqA6Zk1yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VhAjC5GJZO9DCTx4Vc1wLacjI3Z8cWa3iI5epx/ys8eulOwp+31FbM4BE+A6PfNNMGC4283idv3CGwtacpPwA+Wsv5KnssGrzvxbqMO2eSKk2PDSbu2NXL227cV2ctXHZDEibmHI5tZSm3ICpYDAVpMsRDtpxBzxGeyK5Fc1kLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VoQXnkkR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHLEhZ011308;
	Thu, 20 Jun 2024 23:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZoPSYja5mpNUszKqHDDm6aoj5vXRWxFq5L8Od+dOaUk=; b=VoQXnkkRSZVN/dXy
	F9tirDyD4mMtLeyomSW4TTb3lXpScBwHp6n5plHeOl+CYRtnrCz0T+4xWtjUkDBx
	7rOdDBpDWIggpOS2//rv1wVrMjBxQXxV1g+npVKi/Zneq01VZuA89LRrs49UMBoK
	dq7EoV8D5WlVQ2rJXVBiPafoUL/Zj2lsQcuGHJlhq2S0MAd/5ePLuqsxD0wIVmI4
	HmgQAZ0ppk23oL7JDAuWU3GP2oAkzQCNmr/wR3cOPcFWKPp+2zEL+vS7Elh8FV4P
	NCYUXhDvrd5XN+H5i2r6NTJedCag42CoM5wOPuxiH91zRSsNMYT7van2aeLs8VTI
	c/I71w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrrc8vb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 23:41:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KNf61l002208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 23:41:07 GMT
Received: from [10.48.244.93] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 16:41:06 -0700
Message-ID: <4a401305-c21c-417c-8280-82bb1ce1d379@quicinc.com>
Date: Thu, 20 Jun 2024 16:41:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dwc-xlgmac: fix missing MODULE_DESCRIPTION() warning
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
CC: Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240616-md-hexagon-drivers-net-ethernet-synopsys-v1-1-55852b60aef8@quicinc.com>
 <ZnAYVU5AKG_tHjip@nanopsycho.orion> <20240617171430.5db6dcd0@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240617171430.5db6dcd0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kau9UzF4gzqhzYQmU7Ul8EEriBeKcYf9
X-Proofpoint-ORIG-GUID: kau9UzF4gzqhzYQmU7Ul8EEriBeKcYf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_10,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=825 spamscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406200173

On 6/17/2024 5:14 PM, Jakub Kicinski wrote:
> On Mon, 17 Jun 2024 13:04:53 +0200 Jiri Pirko wrote:
>> Looks okay. Missing "Fixes" tag though. Please add it and send v2.
>> Also, please make obvious what tree you target using "[PATCH net]"
>> prefix.
> 
> I've been applying these to net-next lately, TBH.
> Judging by the number of these warnings still left in the tree we are
> the only ones who care.

I'm trying to get rid of these tree-wide.
Hope I'm not just tilting at windmills...


