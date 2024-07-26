Return-Path: <netdev+bounces-113306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC11E93D9F5
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 22:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F2A28265A
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 20:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98007149C45;
	Fri, 26 Jul 2024 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NFt+XvOB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A418641
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026680; cv=none; b=DmVSSTI72bNCDcqFJwFSvfPkLyhbsznTraCEhWvi6tb+qWyU5m+gi/wf6mV2bFCP19X83DL30kwfTTvsmPYr+S4k3jEiFrZFpYh6QHWfgaMoiibOPqE3B0lA0hQdfmQJRQoBJLWMWjRLpYs2SJi+It2I61FlXBJfE7Nvsf1CTt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026680; c=relaxed/simple;
	bh=yo5IJPIYdUzkxkWYr7kywSn3pZSlnPmArx0lgNP2t/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OoplDdBIu4s00FlT1IMiWm972fFDucYk65wtXdKDpqnW64b4iuCNCxyVqXYbQHIWGTcBnXn5KxY7ZCdeBmuUFrTrMY3zuwmvOE2Ec/+vn4h3Lp+RW882jbN6SmRGybUhuWLHm0BON5zVsZRz7zlMsHH8VUqnkhxGzK2vShaCPJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NFt+XvOB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QBaWwl014138;
	Fri, 26 Jul 2024 20:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L8tARZs2c0FVJ1VgmiHYwfPTLAMgxsUgZ742SZHGH4o=; b=NFt+XvOBVXwAkCRH
	QxQRjRQDGOW6Q/4ChKctFOcfdpLtg2nPojthAB1AADoEA7/etNkzk+ul3hWoqQ4X
	tNJds8tNxC44q5B7lL9ZGtLFPyvA0Du84kkC+CeVQbhcgRXHs21Qvmb87Y4OIEDH
	rC5qZuCaxWU8zOr890v9ecaObe9PEaMfYUIZfEmPKR1jFGxj4QNDCS0Fdvd0jIPK
	OjPptLP2NEo5KTn5Ux+3BIFlVu4VRVL/X9yBMStFJAI09zdKH95gaoDH+JZsxw4X
	j4SVXKuP0XACxMJj7APq3aAvkWc70tdIgYG1exvlYCcSBX4B49ylZuBjqsmwYSnM
	8VoaWg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40m1vq2da8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 20:44:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46QKiWXw022609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 20:44:32 GMT
Received: from [10.38.246.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Jul
 2024 13:44:29 -0700
Message-ID: <bba8b50d-d116-42c4-adde-a8045df36961@quicinc.com>
Date: Fri, 26 Jul 2024 14:43:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: Adjust clamping window for applications
 specifying SO_RCVBUF
To: Eric Dumazet <edumazet@google.com>
CC: <soheil@google.com>, <ncardwell@google.com>, <yyd@google.com>,
        <ycheng@google.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, Sean Tranchetti <quic_stranche@quicinc.com>
References: <20240725215542.894348-1-quic_subashab@quicinc.com>
 <CANn89iJ5eGCGgF+_4VxXXV_oMv8Bi-Ugq+MG6=bs+74FR63GUQ@mail.gmail.com>
Content-Language: en-US
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <CANn89iJ5eGCGgF+_4VxXXV_oMv8Bi-Ugq+MG6=bs+74FR63GUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N20cBhYTVZf5YXTl90t7aAvGyOvXXnxN
X-Proofpoint-ORIG-GUID: N20cBhYTVZf5YXTl90t7aAvGyOvXXnxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=837 impostorscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407260139


On 7/26/2024 3:40 AM, Eric Dumazet wrote:
> On Thu, Jul 25, 2024 at 11:55 PM Subash Abhinov Kasiviswanathan
> <quic_subashab@quicinc.com> wrote:
>>
>>           */
>>
>> -       if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) &&
>> -           !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
>> +       if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf)) {
>>                  u64 rcvwin, grow;
>>                  int rcvbuf;
>>
>> @@ -771,12 +770,24 @@ void tcp_rcv_space_adjust(struct sock *sk)
>>
>>                  rcvbuf = min_t(u64, tcp_space_from_win(sk, rcvwin),
>>                                 READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
>> -               if (rcvbuf > sk->sk_rcvbuf) {
>> -                       WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
>> +               if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
>> +                       if (rcvbuf > sk->sk_rcvbuf) {
>> +                               WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
>>
>> -                       /* Make the window clamp follow along.  */
>> -                       WRITE_ONCE(tp->window_clamp,
>> -                                  tcp_win_from_space(sk, rcvbuf));
>> +                               /* Make the window clamp follow along.  */
>> +                               WRITE_ONCE(tp->window_clamp,
>> +                                          tcp_win_from_space(sk, rcvbuf));
>> +                       }
>> +               } else {
>> +                       /* Make the window clamp follow along while being bounded
>> +                        * by SO_RCVBUF.
>> +                        */
>> +                       if (rcvbuf <= sk->sk_rcvbuf) {
> 
> I do not really understand this part.
> I am guessing this test will often be false and your problem won't be fixed.
> You do not handle all  sysctl_tcp_adv_win_scale values (positive and negative)
> 
> I would instead not use "if (rcvbuf <= sk->sk_rcvbuf) {"
> 
> and instead :
> 
> else {
>        int clamp = tcp_win_from_space(sk, min(rcvbuf, sk->sk_rcvbuf));
> 
>        if (clamp > tp->window_clamp)
>              WRITE_ONCE(tp->window_clamp, clamp);
> }
Thanks Eric, I've updated this in v2.

