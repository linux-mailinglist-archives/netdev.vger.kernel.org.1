Return-Path: <netdev+bounces-209611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F7EB1006E
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FB35672E1
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 06:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3775E1E501C;
	Thu, 24 Jul 2025 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DhGfp+wT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E6328F4
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 06:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753337788; cv=none; b=n66s6DKy4pS5PtYIbCO33BZtTNRI/xxKjZVMhCfSoeey3NZTQTOQBkYcBMl1D23yYB3DaZkIBvdaRiAZYHw4oOR2Rqf/7hB8CLN4SbLHFV+y192B3ZcpkKUMQs/KkfmClhcw8NHtz4opGzhp5g68MoWjrpwkomj3BOCgt/h/JxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753337788; c=relaxed/simple;
	bh=JzdgT4Qzp0qtulE7fqRLh41+zB7M+unZAEbXnQm4XvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O1Rsxw29bQ2Biw4sdBUH2pFcqhqIY/xDqBJgxEfpbA7mTzVd3pBAFhHsY/ewIXjiSy1dDOhgHvMhYWaxkheiZ/8gG4ACJu60UaiN1L5h76UW3V3yH9b1zvBjsNLEO6md9j3oJuViCV5cg/+UGGipMm09gI6jHZ9xIJ4oeshbVDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DhGfp+wT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXN6P012566;
	Thu, 24 Jul 2025 06:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f8a3+tNtzFAn0w5QmK+wcdBKxk4GEb3RrJWwwPgEIzw=; b=DhGfp+wTI4lLfhT9
	pyXMWQai5I4/V1f4RqEYJ30MLrg2Y3SwD3TkO2/A0CY7gm75nxxXervowCPtdiqZ
	NdmpK3qygjgIMRQPmMDxOHSg20/sZhIEQ6ASov8u53qs9c8ZBP2T70I8SXOwqvsw
	Lknzh4Iqchl7rLZrWTjUHuZRPM30lSUGchtwpM6jPCnpf4UY/vGxew3N2xaUpBKt
	81X2KibAS8Ks4ZwtTxqkjlA3HFbjwBrU+s2k3qiUrj7iuqkonVK2cuZBIoWPi9C3
	zHuoJmE94yWRYIeAk5JiWGda9UwP2qntqXJQgG/B4g3LcGrUJ87sm0j0cU/U+7/f
	CFPOAg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3hwnah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 06:16:16 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56O6GFc2027151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 06:16:15 GMT
Received: from [10.216.58.103] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 23 Jul
 2025 23:16:12 -0700
Message-ID: <7ffcb4d4-a5b4-4c87-8c92-ef87269bfd07@quicinc.com>
Date: Thu, 24 Jul 2025 11:45:59 +0530
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
Content-Language: en-US
From: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
In-Reply-To: <CANn89iLx29ovUNTp9DjzzeeAOZfKvsokztp_rj6qo1+aSjvrgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=6881cfb0 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=bC-a23v3AAAA:8
 a=1XWaLZrsAAAA:8 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=AJrmuCCVpAqDa0ev6pMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA0MSBTYWx0ZWRfXwcOC0Zat9yjl
 JMkeLHHiknGRpxnRaKYWlLOaXNIhJ6FtIlXD+ZkxX6tOLKXOzg4KeyXfUoPqsoxgbFYyL3L080G
 XE5+xrMxN1aus0CHTLJP4+c5tcMXQgQxx0SNTxOXnQGZjkh+mMG3UrGpKWcyROwL+tF2P33D7Gv
 orS9Yuw39m7uoe0MBvExJuhwrgDmre2g4vQsKGDDjmvYm9hD9a+2DHlTmo5jZ30fV3Rx46M7pRm
 hXXQJZ/vWgnhf/mdqDTD9gSpj4bjP4syE+Pj6VMJzuRk1Z/osOgNSmwzqlA5oAImw8LiQ/SlbQR
 BwIRimRs1XlxMMF94+n/mfGlJOHQ6X5e37MFir2JP9RIPHUohzyy2HEWpwNBjeyVfW/ARCJSV5g
 c+Btxobztnv/wu9nB9VxHHGuXHNOEXwx41EPKb/xQplYJEZpk9rLrHnsePheQPHTSxljPU2Y
X-Proofpoint-GUID: hOJvH1wNi5y_eEDayal9L5nkT1Ksr_aI
X-Proofpoint-ORIG-GUID: hOJvH1wNi5y_eEDayal9L5nkT1Ksr_aI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240041



On 7/23/2025 8:38 PM, Eric Dumazet wrote:
> On Wed, Jul 23, 2025 at 1:22 AM Sharath Chandra Vurukala
> <quic_sharathv@quicinc.com> wrote:
>>
>> In ip_output() skb->dev is updated from the skb_dst(skb)->dev
>> this can become invalid when the interface is unregistered and freed,
>>
>> Added rcu locks to ip_output().This will ensure that all the skb's
>> associated with the dev being deregistered will be transnmitted
>> out first, before freeing the dev.
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
>> Signed-off-by: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
>> ---
>>  net/ipv4/ip_output.c | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>> index 10a1d182fd84..95c5e9cfc971 100644
>> --- a/net/ipv4/ip_output.c
>> +++ b/net/ipv4/ip_output.c
>> @@ -425,15 +425,22 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>>
>>  int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>>  {
>> -       struct net_device *dev = skb_dst_dev(skb), *indev = skb->dev;
>> +       struct net_device *dev, *indev = skb->dev;
>>
>> +       IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
>> +
>> +       rcu_read_lock();
>> +
>> +       dev = skb_dst(skb)->dev;
> 
> Arg... Please do not remove skb_dst_dev(skb), and instead expand it.
> 
> I recently started to work on this class of problems.
> 
> commit a74fc62eec155ca5a6da8ff3856f3dc87fe24558
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Mon Jun 30 12:19:31 2025 +0000
> 
>     ipv4: adopt dst_dev, skb_dst_dev and skb_dst_dev_net[_rcu]
> 
>     Use the new helpers as a first step to deal with
>     potential dst->dev races.
> 
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>     Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>     Link: https://patch.msgid.link/20250630121934.3399505-8-edumazet@google.com
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> 
> Adding RCU is not good enough, we still need the READ_ONCE() to
> prevent potential load/store tearing.
> 
> I was planning to add skb_dst_dev_rcu() helper and start replacing
> skb_dst_dev() where needed.
> 
> diff --git a/include/net/dst.h b/include/net/dst.h
> index 00467c1b509389a8e37d6e3d0912374a0ff12c4a..692ebb1b3f421210dbb58990b77a200b9189d0f7
> 100644
> --- a/include/net/dst.h
> +++ b/include/net/dst.h
> @@ -568,11 +568,23 @@ static inline struct net_device *dst_dev(const
> struct dst_entry *dst)
>         return READ_ONCE(dst->dev);
>  }
> 
> +static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
> +{
> +       /* In the future, use rcu_dereference(dst->dev) */
> +       WARN_ON(!rcu_read_lock_held());
> +       return READ_ONCE(dst->dev);
> +}
> +
>  static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
>  {
>         return dst_dev(skb_dst(skb));
>  }
> 
> +static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
> +{
> +       return dst_dev_rcu(skb_dst(skb));
> +}
> +
>  static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
>  {
>         return dev_net(skb_dst_dev(skb));
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 10a1d182fd848f0d2348f65fde269383f9c07baa..37b982dd53f69247634c67c493c44fa482100dee
> 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -425,15 +425,20 @@ int ip_mc_output(struct net *net, struct sock
> *sk, struct sk_buff *skb)
> 
>  int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  {
> -       struct net_device *dev = skb_dst_dev(skb), *indev = skb->dev;
> +       struct net_device *dev, *indev = skb->dev;
> +       int res;
> 
> +       rcu_read_lock();
> +       dev = skb_dst_dev_rcu(skb);
>         skb->dev = dev;
>         skb->protocol = htons(ETH_P_IP);
> 
> -       return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> +       res = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
>                             net, sk, skb, indev, dev,
>                             ip_finish_output,
>                             !(IPCB(skb)->flags & IPSKB_REROUTED));
> +       rcu_read_unlock();
> +       return res;
>  }
>  EXPORT_SYMBOL(ip_output);
Thanks Eric for the review, as this work is already underway on your end, I’ll pause and wait for your changes to become available.

