Return-Path: <netdev+bounces-182198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C222A88192
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7948E164997
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452382A1AA;
	Mon, 14 Apr 2025 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wu687hea"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4622097
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636684; cv=none; b=tRQgXrCw9XJmAs4DKo/G86PD38iZ3QNYHoP6yAZV50V4KAFoD2dWW4G+P0sdEnmsTPQEqi6udoBVV8Gh0msjb9Zs0bm/PHXsMtt7AbDiqsBdaN6eQf0oQLbYh7fpgtL/zyHmFqEnWYTD42FQyREqRBgG5U27VS4AOS8BzakZLgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636684; c=relaxed/simple;
	bh=j6qaFjEHnf91faduCcvIC+Q3Tft1VA4mqpCBxh4GFvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qi3HqoHIVAkPhw+icPlAiIR1FG0L0uWGZL69rEqML9mWYrLucVDIRE8t+iaNnk7Ynp483aFSM0RBxiQe7C13LquNIR893nJxoNUmK9ekuDtwKFHwKHhOi4X1ke7SB467plKbAEy+5EKT9vkaR7j6vDuEmwo26Pm7E5DH+MqFGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wu687hea; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAej3p012665;
	Mon, 14 Apr 2025 13:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=8VE57CFYuSWnpfedeptxs8N1kct+AU
	Ft+N8bO011XO4=; b=Wu687heaFzkO1n45JIgh//CUD9GtU97lXkw+PgC5KWpYSA
	7iVKbKJ8+ICYs1EimM/k8qqCs/4LxGY8E3UNqEkfTYoZozYD63hYaaPliCl1yj14
	OKwc8/XvTJVVNLmg6zyqpVBCixVJXfqokMNxfAfzkDclYQjWbFqtD9Orx0iZayob
	WeJ2wMYX4sMS9gbbc+yua0ir8CtipUl9zXu/hDnWdcMPf67AUNWNXV6RxYZCDNWM
	vVIqdicqOMGV537l55+otgWUc9lHuF6ktevu4DCzN+bxOFD1DuO3k3W5AQKBTZT5
	dJhxC/RSpUzb1hr+aIryAWYEbu2AiRTU7uv2l11g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4610tp8q70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 13:17:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAxas6024914;
	Mon, 14 Apr 2025 13:17:50 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gt6njv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 13:17:50 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53EDHlcJ31392442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 13:17:47 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BC7858055;
	Mon, 14 Apr 2025 13:17:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF2835804B;
	Mon, 14 Apr 2025 13:17:49 +0000 (GMT)
Received: from d.ibm.com (unknown [9.61.3.79])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Apr 2025 13:17:49 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] ibmveth: Use WARN_ON with error handling
 rather than BUG_ON
In-Reply-To: <Z/iwd8qonlrfOkO5@mev-dev.igk.intel.com> (Michal Swiatkowski's
	message of "Fri, 11 Apr 2025 08:02:31 +0200")
References: <20250410183918.422936-1-davemarq@linux.ibm.com>
	<Z/iwd8qonlrfOkO5@mev-dev.igk.intel.com>
Date: Mon, 14 Apr 2025 08:17:49 -0500
Message-ID: <87o6wyhog2.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4I7gNUnM2h20g9MDMZfyoQQWrFIHVeLR
X-Proofpoint-ORIG-GUID: 4I7gNUnM2h20g9MDMZfyoQQWrFIHVeLR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1011 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140095

Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:

> On Thu, Apr 10, 2025 at 01:39:18PM -0500, Dave Marquardt wrote:
>> - Replaced BUG_ON calls with WARN_ON calls with error handling,
>>   with calls to a new ibmveth_reset routine, which resets the device.
>> - Added KUnit tests for ibmveth_remove_buffer_from_pool and
>>   ibmveth_rxq_get_buffer under new IBMVETH_KUNIT_TEST config option.
>> - Removed unneeded forward declaration of ibmveth_rxq_harvest_buffer.
>
> It will be great if you split this patch into 3 patches according to
> your description.

Thanks. I debated the right approach here. Thanks for the guidance.

>>  static struct kobj_type ktype_veth_pool;
>> @@ -231,7 +230,10 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>>  		index = pool->free_map[free_index];
>>  		skb = NULL;
>>  
>> -		BUG_ON(index == IBM_VETH_INVALID_MAP);
>> +		if (WARN_ON(index == IBM_VETH_INVALID_MAP)) {
>> +			(void)schedule_work(&adapter->work);
>
> What is the purpose of void casting here (and in other places in this
> patch)?

I'm indicating that I'm ignoring the bool returned by schedule_work().
Since this seemed odd to you, I take it the convention in Linux code is
not doing this.

>> +			goto failure2;
>
> Maybe increment_buffer_failure, or sth that is telling what happen after
> goto.

Okay, I can change that.

>> +		}
>>  
>>  		/* are we allocating a new buffer or recycling an old one */
>>  		if (pool->skbuff[index])
>> @@ -300,6 +302,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>>  		                 DMA_FROM_DEVICE);
>>  	dev_kfree_skb_any(pool->skbuff[index]);
>>  	pool->skbuff[index] = NULL;
>> +failure2:
>>  	adapter->replenish_add_buff_failure++;
>>  
>>  	mb();
>> @@ -370,20 +373,36 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
>>  	}
>>  }
>>  
>
> [...]

Thanks for your review!

-Dave

