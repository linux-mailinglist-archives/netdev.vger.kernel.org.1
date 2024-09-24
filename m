Return-Path: <netdev+bounces-129595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D8984AC8
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 20:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E6D1C22D1C
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 18:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B554AEEA;
	Tue, 24 Sep 2024 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="dNfBQWeT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B11B85DB;
	Tue, 24 Sep 2024 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201740; cv=none; b=gxNWdSckDm0bHTryw6B4lv16U1RERWNRFaiLoGBpkd/kqwWBd5UBmXj6vXoGmcCSzDvV+/yEQzD4vIKHiVenM4uYelRPhh6M2bTmyROnQBIuckOoQqXnIx/S7OvD6xfLVarM1spKDiEOPg4Uk3gLENNNY3yGw2KyZfeQG4WZh1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201740; c=relaxed/simple;
	bh=Y69CBXft/89RYiJGygxLvDjUaUSw6b6AY050W+oUenE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fv/K8bn2WCChqbYXtEpeOnWhVfnhXmPSbslrptvG0IvD0tKLA0tbszViLOOycFUtSrwY5a12cRcZOnFX71MetzqIeeou/MFbGlTufwZzpxTcwxRpf1UwuV840xgfgY5vafTDPzCPtlUFxDADpVNzgdj6yHeyBc4TCeTBHIOgp2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=dNfBQWeT; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409411.ppops.net [127.0.0.1])
	by m0409411.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 48OBYEIc020297;
	Tue, 24 Sep 2024 18:26:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=YtazcCjHaC02mUMlP90lNJBe1ZmJSaC1m+oIlkc1uhA=; b=dNfBQWeTDbPO
	w/YW+ArCoshbaphO2iHDjzrG+D5o+ny4vC9rswCZ4dtOvlVOLcfPDeJbRsD+x4Ry
	aH4OtiMzSpKyOcHiTWi+z+fyd/onWKHnlJvic1V1SX9jgmRRAmoV9jj0CcQaJD1m
	kbwQmKKAatZwRNIvYGsz/pVs9KD5YDqjt/9XHCw1C4lBgKJ+uUBA/Sme7WqOWqTx
	Wnv8VOI4hM4ZexmysqnFMRILJCthZ5LeLY3CRp/D3L2dj3c9qQmetxHBav8gZnhS
	nHBWodHBnQq/J7lAfy2zvnS8nfh/n8ZIRTJANOUUmSsRFFdyUk8VHDVyA5kyKNC+
	HWbmLSUlLw==
Received: from prod-mail-ppoint7 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be forged))
	by m0409411.ppops.net-00190b01. (PPS) with ESMTPS id 41t7gbjudj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 18:26:21 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
	by prod-mail-ppoint7.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 48OFSiDx025042;
	Tue, 24 Sep 2024 13:26:20 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
	by prod-mail-ppoint7.akamai.com (PPS) with ESMTP id 41ssg1pvr6-1;
	Tue, 24 Sep 2024 13:26:19 -0400
Received: from [100.64.0.1] (prod-aoa-dallas2clt14.dfw02.corp.akamai.com [172.27.166.123])
	by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 60F91636F5;
	Tue, 24 Sep 2024 17:26:18 +0000 (GMT)
Message-ID: <1fbd0d02-6c34-4bb4-b9b8-66e121ff67e3@akamai.com>
Date: Tue, 24 Sep 2024 10:26:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Paolo Abeni <pabeni@redhat.com>, edumazet@google.com, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org, ncardwell@google.com
Cc: linux-kernel@vger.kernel.org
References: <20240910190822.2407606-1-johunt@akamai.com>
 <5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com>
Content-Language: en-US
From: Josh Hunt <johunt@akamai.com>
In-Reply-To: <5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240123
X-Proofpoint-GUID: qkZLFQFukI6XARHdmMKJbaj6CyuY2jP7
X-Proofpoint-ORIG-GUID: qkZLFQFukI6XARHdmMKJbaj6CyuY2jP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409240124

On 9/19/24 2:05 AM, Paolo Abeni wrote:
> !-------------------------------------------------------------------|
>   This Message Is From an External Sender
>   This message came from outside your organization.
> |-------------------------------------------------------------------!
> 
> On 9/10/24 21:08, Josh Hunt wrote:
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 2aac11e7e1cc..196c148fce8a 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -2434,9 +2434,26 @@ static inline s64 tcp_rto_delta_us(const struct 
>> sock *sk)
>>   {
>>       const struct sk_buff *skb = tcp_rtx_queue_head(sk);
>>       u32 rto = inet_csk(sk)->icsk_rto;
>> -    u64 rto_time_stamp_us = tcp_skb_timestamp_us(skb) + 
>> jiffies_to_usecs(rto);
>> -    return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
>> +    if (likely(skb)) {
>> +        u64 rto_time_stamp_us = tcp_skb_timestamp_us(skb) + 
>> jiffies_to_usecs(rto);
>> +
>> +        return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
>> +    } else {
>> +        WARN_ONCE(1,
>> +            "rtx queue emtpy: "
>> +            "out:%u sacked:%u lost:%u retrans:%u "
>> +            "tlp_high_seq:%u sk_state:%u ca_state:%u "
>> +            "advmss:%u mss_cache:%u pmtu:%u\n",
>> +            tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
>> +            tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
>> +            tcp_sk(sk)->tlp_high_seq, sk->sk_state,
>> +            inet_csk(sk)->icsk_ca_state,
>> +            tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
>> +            inet_csk(sk)->icsk_pmtu_cookie);
> 
> As the underlying issue here share the same root cause as the one 
> covered by the WARN_ONCE() in tcp_send_loss_probe(), I'm wondering if it 
> would make sense do move the info dumping in a common helper, so that we 
> get the verbose warning on either cases.
> 
> Thanks,
> 
> Paolo

Thanks for the review Paolo. Sorry for the delay in replying I was OOO. 
I can send a follow-up commit to create a common helper.

Josh

