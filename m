Return-Path: <netdev+bounces-115389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F4F94629A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 19:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A23B1F25D12
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2E115C129;
	Fri,  2 Aug 2024 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ih7BYj0l"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C45B15C12D
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620222; cv=none; b=mFLeapJgtZ4xSJN7to757YlDM5wLNVopXFLObDekIr82FPl8GQnuHwwIRbR8chTQ8ZxG2ysg5/OC77QOgsSxJFcxPGVFu3vhk2M8qublPywY1DCol+0QGAM6A9Z/X5+zpv7nhV92l1aytWo82IGFX0d8dBskBzLKcr5Q6verDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620222; c=relaxed/simple;
	bh=tWb0ClB+d2o06qVF+A90ZywKqXynhlNRj0DbSUwzZiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGzniTwj+TIp02v1/9Z7YcTocls3FTJFwqY65cLH0MRKLFU4qP4El/ZWk2REXtcZgbk4keg857i4JHBTm5+hggDANFb4MRDGMu/xaz8cjENdbIEcrUnvr1lgJ3rPlMq0PH2NrLB3YaLQinBdmc1Hj88DAG6V7cOrWYflCw+1OBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ih7BYj0l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472E1pEj015463;
	Fri, 2 Aug 2024 17:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=v
	faaMJcEGhiRUh7j0wjpxvvdNXKkXVZJMTx1dTbVe5Q=; b=Ih7BYj0loJr8Bv2v/
	9w/I29sCom8KiaHEOKqRHokrpYWoCDBkFuHKADTMOihGwgNJXfog7E2xaN1b2FQI
	oL7JKP2I0aTZ/qK3fN+y49wXmPVYQjHDeVSl4BTG3BvV5jwTeSCgli9wUva589WL
	EozyZriXyxaejg/nHUcCwTgvEd0HIjKlkRlu+vzyAs0mtAnUdY/pOWN4NX79yJFl
	XNP9FIrUYb4WjGztcDKM6CmSVTchmMvLlFkfRO4Hd47kx38YOTdhElJAX53ra83j
	BVyC1rpIcOZjt+q8JDJJ2lVXktZbyRdvKdZ0xifWlDoEyGzPfG1+9DbtkquDNFTJ
	w1psA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rygm8pef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 17:36:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472GlJY4009205;
	Fri, 2 Aug 2024 17:36:56 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx3g23m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 17:36:55 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472Hao1I18285158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 17:36:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3EB558062;
	Fri,  2 Aug 2024 17:36:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08EB158057;
	Fri,  2 Aug 2024 17:36:50 +0000 (GMT)
Received: from [9.61.167.68] (unknown [9.61.167.68])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Aug 2024 17:36:49 +0000 (GMT)
Message-ID: <aac40c02-3783-44f9-a8c8-97467570d4d5@linux.ibm.com>
Date: Fri, 2 Aug 2024 12:36:49 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] ibmveth: Recycle buffers during replenish
 phase
To: "Nelson, Shannon" <shannon.nelson@amd.com>, netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com
References: <20240801211215.128101-1-nnac123@linux.ibm.com>
 <20240801211215.128101-3-nnac123@linux.ibm.com>
 <e7878a08-440c-4ca7-a982-1b9a71ea9072@amd.com>
Content-Language: en-US
From: Nick Child <nnac123@linux.ibm.com>
In-Reply-To: <e7878a08-440c-4ca7-a982-1b9a71ea9072@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cDG_pZ6ZqScHh3qPNU7PpeQcyeg_7KfB
X-Proofpoint-ORIG-GUID: cDG_pZ6ZqScHh3qPNU7PpeQcyeg_7KfB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_13,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1011 impostorscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020121



On 8/1/24 18:07, Nelson, Shannon wrote:
> On 8/1/2024 2:12 PM, Nick Child wrote:
>>
>> When the length of a packet is under the rx_copybreak threshold, the
>> buffer is copied into a new skb and sent up the stack. This allows the
>> dma mapped memory to be recycled back to FW.
>>
>> Previously, the reuse of the DMA space was handled immediately.
>> This means that further packet processing has to wait until
>> h_add_logical_lan finishes for this packet.
>>
>> Therefore, when reusing a packet, offload the hcall to the replenish
>> function. As a result, much of the shared logic between the recycle and
>> replenish functions can be removed.
>>
>> This change increases TCP_RR packet rate by another 15% (370k to 430k
>> txns). We can see the ftrace data supports this:
>> PREV: ibmveth_poll = 8078553.0 us / 190999.0 hits = AVG 42.3 us
>> NEW:  ibmveth_poll = 7632787.0 us / 224060.0 hits = AVG 34.07 us
>>
>> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
>> ---
>>   drivers/net/ethernet/ibm/ibmveth.c | 144 ++++++++++++-----------------
>>   1 file changed, 60 insertions(+), 84 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c 
>> b/drivers/net/ethernet/ibm/ibmveth.c
>> index e6eb594f0751..b619a3ec245b 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -39,7 +39,8 @@
>>   #include "ibmveth.h"
>>
>>   static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance);
>> -static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter);
>> +static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>> +                                      bool reuse);
>>   static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev);
>>
>>   static struct kobj_type ktype_veth_pool;
>> @@ -226,6 +227,16 @@ static void ibmveth_replenish_buffer_pool(struct 
>> ibmveth_adapter *adapter,
>>          for (i = 0; i < count; ++i) {
>>                  union ibmveth_buf_desc desc;
>>
>> +               free_index = pool->consumer_index;
>> +               index = pool->free_map[free_index];
>> +               skb = NULL;
>> +
>> +               BUG_ON(index == IBM_VETH_INVALID_MAP);
> 
> Maybe can replace with a WARN_ON with a break out of the loop?
> 
> Otherwise this looks reasonable.
> 
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> 

Hi Shannon,
Thanks for reviewing. Addressing your comment on both
patches here as they are related. I agree we should
replace the BUG_ON's but there are 6 other BUG_ON's in
the driver that I would like to address as well. I am
thinking I will send a different patch which removes
all BUG_ON's in the driver (outside of this patchset).

Since this patchset only rearranges existing BUG_ONs, I
will hold off on sending a v2 unless other feedback comes
in. Thanks again.


