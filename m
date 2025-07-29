Return-Path: <netdev+bounces-210834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC48B15062
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F379516610F
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793B22951B3;
	Tue, 29 Jul 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UW7u5GrT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758842949E5
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803901; cv=none; b=ErR0olxhZbO0wonfAjI+aPaukSzjKGTQExA+svgVJGkKR21+Fa64ZR8bSoGGUWkfviLq5Bz9iZreH8dE50RhVGPsd8vAWOExULNuNLq+Cd+BeQ3B5oX3r9qm+XKgdN0vxjiCNBofLIW4V5QANfL7N1vm0h41RXqiYDmttAt3H74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803901; c=relaxed/simple;
	bh=qu8muXoLR7pnTZ3FB5pPlYtD51+7wbi7KiWh4voe0QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ID0aKd1vXItcWtO8+rt8iG2sXXEM1qaF7CDAKkjM2d2hM2dLSkkDuilIhlNcK1cMinHerVFKpNYwOT/nfx4dcE/h3xHo2D3Sv6XkDjNOU0bl11AmUteX54xvJQpIPNId1fDd2G2eGZAoeZpRdel2HUIbbC0TfhK08yhcBE7ZHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UW7u5GrT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9gksK031181;
	Tue, 29 Jul 2025 15:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DEa4IXBakvY69qnl01DUuxE3PjHKkB2Yhfb9K8+oBAA=; b=UW7u5GrTPbim7T5g
	qfaRGmG89GAroHth8z8S8qI57jV006htpx7TR6v5MfIrq+HT2lDQoM02dus2qK6j
	iyFvoy9heWISGZy2MAMintuRY+vPqbyxcEFMO3MKfpRVFBah7A00YlaImLAfbtCp
	t+3GW+4S3+3Q8LGrOH4yi7WUv4Kqum4D4bLYoOzCG0twQf3kzEzRKuWlt1BHsLrk
	rGB7ffxK0GgvmQIVlozmG6THo3KNd6eJ2dmmoQhzYIY4LtrMIkdgkQZK6MKwtAPH
	UylOp99VVxAAEIG8zPs6XJgGEDXqjKfdXTTWYbEcLBsUtGX5fQzVYUbgk5X7PviT
	xvFG9g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbm0jwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 15:44:49 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56TFimJ7006575
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 15:44:48 GMT
Received: from [10.216.36.202] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 29 Jul
 2025 08:44:45 -0700
Message-ID: <b6beefcf-7525-4c70-9883-4ab8c8ba38ed@quicinc.com>
Date: Tue, 29 Jul 2025 21:14:41 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: Add locking to protect skb->dev access in
 ip_output
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, <davem@davemloft.net>,
        <dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <quic_kapandey@quicinc.com>, <quic_subashab@quicinc.com>
References: <20250729114251.GA2193@hu-sharathv-hyd.qualcomm.com>
 <6888d4d07c92c_15cf79294cb@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
In-Reply-To: <6888d4d07c92c_15cf79294cb@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=6888ec71 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=PpstCEIyj3ptPoRNqVMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExNyBTYWx0ZWRfX1+1NwA9LXEDH
 l7vvX++eV8fbDtZTE03jnjwa/xc1gLFcRtIivs4OR5kErJU4BbTHrWdfXrAbQXx9kYBvR7xloRv
 WcufeQy9wYvoEWWTepEhYYc/TJSj70MLYKTu4isVhXMjmj7N7NjWscY8cbX4d5kPcjixpwcK3M9
 4LgEnIir8dH28oX1s8pNk4FgK2ehqfCCpVGNndb7jUr18uE/LKff7LNC3EJbFhgc2tKVTkX9Wpo
 N+LY4ftcPgPtkMh+ED+WsEiskXmAIiYGWlo7yfvS04siOpt2wAWF6pGXQjt117eNYeh9hRmKi9L
 vlUf4yXJkzrWhvlvQwzqSuNhA4YHJku1NIRUWB40CKZI800X+4gM163rwd16UV7IfSH1V81oxHy
 9FAjOFchCKNWZh+qlMEORObVPzpTvj7z6WTm7fqeqU8qtPgOqEl4bUT/jYl+rXBdXbVP3+ha
X-Proofpoint-ORIG-GUID: NWBpWKbUuAoMoemmzf4aJ1ZgXTmV_Tt3
X-Proofpoint-GUID: NWBpWKbUuAoMoemmzf4aJ1ZgXTmV_Tt3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290117



On 7/29/2025 7:34 PM, Willem de Bruijn wrote:
> Sharath Chandra Vurukala wrote:
>> In ip_output() skb->dev is updated from the skb_dst(skb)->dev
>> this can become invalid when the interface is unregistered and freed,
>>
>> Introduced new skb_dst_dev_rcu() function to be used instead of
>> skb_dst_dev() within rcu_locks in outout.This will ensure that
>> all the skb's associated with the dev being deregistered will
>> be transnmitted out first, before freeing the dev.
>>
>> Multiple panic call stacks were observed when UL traffic was run
>> in concurrency with device deregistration from different functions,
>> pasting one sample for reference.
>>
>> [496733.627565][T13385] Call trace:
>> [496733.627570][T13385] bpf_prog_ce7c9180c3b128ea_cgroupskb_egres+0x24c/0x7f0
>> [496733.627581][T13385] __cgroup_bpf_run_filter_skb+0x128/0x498
>> [496733.627595][T13385] ip_finish_output+0xa4/0xf4
>> [496733.627605][T13385] ip_output+0x100/0x1a0
>> [496733.627613][T13385] ip_send_skb+0x68/0x100
>> [496733.627618][T13385] udp_send_skb+0x1c4/0x384
>> [496733.627625][T13385] udp_sendmsg+0x7b0/0x898
>> [496733.627631][T13385] inet_sendmsg+0x5c/0x7c
>> [496733.627639][T13385] __sys_sendto+0x174/0x1e4
>> [496733.627647][T13385] __arm64_sys_sendto+0x28/0x3c
>> [496733.627653][T13385] invoke_syscall+0x58/0x11c
>> [496733.627662][T13385] el0_svc_common+0x88/0xf4
>> [496733.627669][T13385] do_el0_svc+0x2c/0xb0
>> [496733.627676][T13385] el0_svc+0x2c/0xa4
>> [496733.627683][T13385] el0t_64_sync_handler+0x68/0xb4
>> [496733.627689][T13385] el0t_64_sync+0x1a4/0x1a8
>>
>> Changes in v2:
>> - Addressed review comments from Eric Dumazet
>> - Used READ_ONCE() to prevent potential load/store tearing
>> - Added skb_dst_dev_rcu() and used along with rcu_read_lock() in ip_output
>>
>> Signed-off-by: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
>> ---
>>  include/net/dst.h    | 12 ++++++++++++
>>  net/ipv4/ip_output.c | 17 ++++++++++++-----
>>  2 files changed, 24 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/net/dst.h b/include/net/dst.h
>> index 00467c1b5093..692ebb1b3f42 100644
>> --- a/include/net/dst.h
>> +++ b/include/net/dst.h
>> @@ -568,11 +568,23 @@ static inline struct net_device *dst_dev(const struct dst_entry *dst)
>>  	return READ_ONCE(dst->dev);
>>  }
>>  
>> +static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
>> +{
>> +	/* In the future, use rcu_dereference(dst->dev) */
>> +	WARN_ON(!rcu_read_lock_held());
> 
> WARN_ON_ONCE or even DEBUG_NET_WARN_ON_ONCE
> 
That makes sense — I will revise the code to use WARN_ON_ONCE() accordingly.>> +	return READ_ONCE(dst->dev);
>> +}
>> +
>>  static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
>>  {
>>  	return dst_dev(skb_dst(skb));
>>  }
>>  
>> +static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
>> +{
>> +	return dst_dev_rcu(skb_dst(skb));
>> +}
>> +
>>  static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
>>  {
>>  	return dev_net(skb_dst_dev(skb));
>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>> index 10a1d182fd84..d70d79b71897 100644
>> --- a/net/ipv4/ip_output.c
>> +++ b/net/ipv4/ip_output.c
>> @@ -425,15 +425,22 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>>  
>>  int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>>  {
>> -	struct net_device *dev = skb_dst_dev(skb), *indev = skb->dev;
>> +	struct net_device *dev, *indev = skb->dev;
>> +	int ret_val;
>>  
>> +	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
> 
> Why introduce this?
> 
Apologies for the oversight. The branch I am currently working on is quite outdated, and this line originates from that earlier version.
This line appears to have been unintentionally included during the preparation of the patch for submission to net-next. Will correct this.>> +
>> +	rcu_read_lock();
>> +	dev = skb_dst_dev_rcu(skb);
>>  	skb->dev = dev;
>>  	skb->protocol = htons(ETH_P_IP);
>>  
>> -	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
>> -			    net, sk, skb, indev, dev,
>> -			    ip_finish_output,
>> -			    !(IPCB(skb)->flags & IPSKB_REROUTED));
>> +	ret_val = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
>> +			       net, sk, skb, indev, dev,
>> +				ip_finish_output,
>> +				!(IPCB(skb)->flags & IPSKB_REROUTED));
>> +	rcu_read_unlock();
>> +	return ret_val;
>>  }
>>  EXPORT_SYMBOL(ip_output);
>>  
> 
> 


