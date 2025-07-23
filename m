Return-Path: <netdev+bounces-209256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25145B0ED19
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F34A3BBE1B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6650D27A135;
	Wed, 23 Jul 2025 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RrW9xSCg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F3279DC9
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258944; cv=none; b=lgWKX/w1lSI+eNR74sBUAucNet/QcBvNxlURkwnukbG+bETudwgj7eKYDZy+hXqGpFKvh07JfHRZRDctGUkERiG6DvAKtImeaRn3Y4uS0sW5m1m/Xlr8ePUF12fo+cxv7HTkc8l0O5l1in8HJsW094dikdPBf61fo64mDH/IXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258944; c=relaxed/simple;
	bh=Old/3Qt5CzTrppvR7qhNWfs/NIr09kY5oAzNYtl5MV4=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SOJFJWI1YhwBVEALjWY+Mw73YFzDkED5nI8OmeXnGgjwUbYH8y1CXmqXlxGwrsEdwtgUXF31RiUGoQrg3dQS7jM26jotIgNX7iv0JdnJcFXQP79MGZ1IkaqDMJfyvZCeXwBHU8hiIT74lgrDrURrx+XZuKtnCfoQti26RNWVn6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RrW9xSCg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMONn1025715;
	Wed, 23 Jul 2025 08:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=nRUPNlm207veaKr3tI4tO18M4qlX7VPs9SpvXFwuV1g=; b=Rr
	W9xSCgHzG5jTnY7FLdbYi48+1HRqDibxUOm+SyRKiOUbruvu16U5rXuI4BKjKkqy
	f9Iq1m3xa5sKGh6B81zfYONAu6qXNpKzq902E88G+VOLp5enaXDZAAZfLXfhKrph
	KNNZEadNvfAKbCfkHFVBEQbkHBxAsh1dQi6aA4OHOv/oOIrNNGeGhE7IDjxgYTWJ
	yKWAk1XLJNYM0RHBezdWWHvWGtaPdB3AHkqIA3Uw7J8YsizOQSPKekXb4VvvacOm
	02ZB9OL66ITKoS50OlzMLhXStGL9ADUtBrkMsXgFC1sxnNMO6bkwS+FZU2pDZyHG
	WNAbWEuHjHVw1b3EDu+A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1uax4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 08:22:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56N8M80E008963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 08:22:08 GMT
Received: from hu-sharathv-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 23 Jul 2025 01:22:05 -0700
Date: Wed, 23 Jul 2025 13:52:01 +0530
From: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <quic_kapandey@quicinc.com>, <quic_subashab@quicinc.com>
Subject: [PATCH] net: Add locking to protect skb->dev access in ip_output
Message-ID: <20250723082201.GA14090@hu-sharathv-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=68809bb1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=_RfymyqqWee_soDNvBUA:9 a=CjuIK1q_8ugA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA2OCBTYWx0ZWRfXysWqJ5+RPd1x
 WgQGnBsDz7m5okgs+QJwnVKoQyCKuspX64r9XP7FUbPfql/5lJzg/LBmz8hEjYx5fX57wTdBjQI
 IbntWFskgYi4LLWQWB+c0p8/EjonawsBvNGvguePkH6mz5fnkdnq9WqglH9BYc+zHibeHsklwK+
 wSfdxPK2KCTpNGZiJiWoPj1/BYFem1cNy9LO6E08BRPCxOdz9q8JSRjONh83ntx/xwoYZDeDTFc
 OTv4GRHHt+hlTJXaNHRQ2dL2a2dL9VMsGGXjiuElrPT1pLHruKd8iCWgAw6+g81xgVgNAkTngtb
 OyMiTow38mtaBVQXegxNZc7fkCgZVj1bjHm0Wxh3wgOpwq3lAF9uoVxg2+1AWdfLa/sJBlkHDgC
 fMzelL7ufYi5y/mN3ouTWpUUVXnxYTJpv4qzM89K9vgOg1hUrcBuwIQEObYlQxVUySajF7P+
X-Proofpoint-ORIG-GUID: Pi1HO32LJYXlH447me5o_MEMbJuFsDqT
X-Proofpoint-GUID: Pi1HO32LJYXlH447me5o_MEMbJuFsDqT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230068

In ip_output() skb->dev is updated from the skb_dst(skb)->dev
this can become invalid when the interface is unregistered and freed,

Added rcu locks to ip_output().This will ensure that all the skb's
associated with the dev being deregistered will be transnmitted
out first, before freeing the dev.

Multiple panic call stacks were observed when UL traffic was run
in concurrency with device deregistration from different functions,
pasting one sample for reference.

[496733.627565][T13385] Call trace:
[496733.627570][T13385] bpf_prog_ce7c9180c3b128ea_cgroupskb_egres+0x24c/0x7f0
[496733.627581][T13385] __cgroup_bpf_run_filter_skb+0x128/0x498
[496733.627595][T13385] ip_finish_output+0xa4/0xf4
[496733.627605][T13385] ip_output+0x100/0x1a0
[496733.627613][T13385] ip_send_skb+0x68/0x100
[496733.627618][T13385] udp_send_skb+0x1c4/0x384
[496733.627625][T13385] udp_sendmsg+0x7b0/0x898
[496733.627631][T13385] inet_sendmsg+0x5c/0x7c
[496733.627639][T13385] __sys_sendto+0x174/0x1e4
[496733.627647][T13385] __arm64_sys_sendto+0x28/0x3c
[496733.627653][T13385] invoke_syscall+0x58/0x11c
[496733.627662][T13385] el0_svc_common+0x88/0xf4
[496733.627669][T13385] do_el0_svc+0x2c/0xb0
[496733.627676][T13385] el0_svc+0x2c/0xa4
[496733.627683][T13385] el0t_64_sync_handler+0x68/0xb4
[496733.627689][T13385] el0t_64_sync+0x1a4/0x1a8

Signed-off-by: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
---
 net/ipv4/ip_output.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 10a1d182fd84..95c5e9cfc971 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -425,15 +425,22 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst_dev(skb), *indev = skb->dev;
+	struct net_device *dev, *indev = skb->dev;
 
+	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
+
+	rcu_read_lock();
+
+	dev = skb_dst(skb)->dev;
 	skb->dev = dev;
 	skb->protocol = htons(ETH_P_IP);
 
-	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
-			    net, sk, skb, indev, dev,
-			    ip_finish_output,
-			    !(IPCB(skb)->flags & IPSKB_REROUTED));
+	ret_val = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
+			       net, sk, skb, indev, dev,
+				ip_finish_output,
+				!(IPCB(skb)->flags & IPSKB_REROUTED));
+	rcu_read_unlock();
+	return ret_val;
 }
 EXPORT_SYMBOL(ip_output);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


