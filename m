Return-Path: <netdev+bounces-210947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63EDB15E7E
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 12:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B335171C29
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D97726E140;
	Wed, 30 Jul 2025 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jeNA44/b"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2F230981
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872695; cv=none; b=ThUar82Rxn4wlGZnmitqpxWZtZgeCcPctGRjxFKPZzXgH8qfdoQKsptppUU1xklZTwEhhKGR0b4BndWLyDScj6cVMu71bjYDVaBmD2S9o+u4EAWRM/EX0mSFah+2uJWJqsn8x3RZ1tX5xvzFJla26yjx4jMN5rgC9QeKI6u5tOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872695; c=relaxed/simple;
	bh=hUnHbldGqcBKwoTaqI/0VR5Rs5/NykP1gA8tTed+Va8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XpOITRXadefw5wpqWybKk/XrFria/2rXb4e6pV+iV8pFBRFGdqchYgChYekQtrb8eR4RUUuVjvU9wswdVosJiW3W+dVWdwLQlFnaci9fQy9WH9uIIOQwQlNi+iVPFrdGBQPIOY81Syyqo2X0gEqaiavf/XieDF2Eji6NljOgmww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jeNA44/b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U66Vs7004997;
	Wed, 30 Jul 2025 10:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=OMmrj/nnTfbnJSrmA0UevIcmzldx4MauHShlcnpTzpM=; b=je
	NA44/bI96vOGKrbpchpQLR/jGfCjRkLP3JqX3Y0Eg8YUOAdtTyNEFiI5iWVeh2O9
	WUpFVsyhsZsDw3YIosi20gcmL34wZvbLbs8uzgk8JPI+Mt/eESQWjxJOC4M6GKKX
	BwG1rXJr1DYtaEzrPELE5Hv4I1Okzye8jnDCsXvmITZsyztonitRjaSs9iymJ7Y7
	35lZAamSuTqtfdUjw+ESkb1hA6fYLRHxI3i08HzNODQ2mfcTlvbqeuk5MrXc1frQ
	TK248L7ATBveRIQkPB0l4IdenzELc4uQR+1P8c5aUQs9wwZL8klX3Q6JxtUJuZBI
	XWxbrnjH1ObF5O70nMzw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nyu3s0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 10:51:25 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56UApPZe010370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 10:51:25 GMT
Received: from hu-sharathv-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 30 Jul 2025 03:51:22 -0700
Date: Wed, 30 Jul 2025 16:21:18 +0530
From: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <quic_kapandey@quicinc.com>, <quic_subashab@quicinc.com>
Subject: [PATCH v3] net: Add locking to protect skb->dev access in ip_output
Message-ID: <20250730105118.GA26100@hu-sharathv-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dDRFvUp4ZFPQRxUFQYZg4EBtxBWXA_vk
X-Proofpoint-ORIG-GUID: dDRFvUp4ZFPQRxUFQYZg4EBtxBWXA_vk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA3NiBTYWx0ZWRfX0wZxGIUL/r9q
 YP9nxuxiCzdpx7T2I7fRWwp6/Oy7D/IE4ZAh/aUAfz3IIwlaK1kO4pDO7RiUH/Dd4+Pzw9AMdg/
 EkW+Jv0daUQ/8T2WPDsfXXDrspMnVxBo9wlZjiW6bwlt16e3gfndQZJziPFMqb1aaDYvTUFKQ3I
 Q+4yM302CkQWFRGrrGwdb++37O07cRf8J4NyATwpfVU2cZxxtn+RXy8a/4RD19adxML3rsT805Y
 lzkf1dkY6JKjzld3OVRcYWqIq1OJB9ZYL5E31J0iBtZF4E9FwVwP78FOqAsrbs0IwsSs4i+xu0M
 eg9Nk1UFnVvY67p8zTLna++jhZ8cMBSjbJs9WhKYz8nEkBMAhJ3cmAIqHlrMVefBLUfftRat6/o
 d0/Z4crXdELaUFZujWViAg5OHFjwybcQK7m7n2oDU7RQM4ZEHkWSKvr5E1G6Fsoc3pKxatfd
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=6889f92d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=-Tf2mGPouwMslTLvLWwA:9 a=CjuIK1q_8ugA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300076

In ip_output() skb->dev is updated from the skb_dst(skb)->dev
this can become invalid when the interface is unregistered and freed,

Introduced new skb_dst_dev_rcu() function to be used instead of
skb_dst_dev() within rcu_locks in ip_output.This will ensure that
all the skb's associated with the dev being deregistered will
be transnmitted out first, before freeing the dev.

Given that ip_output() is called within an rcu_read_lock()
critical section or from a bottom-half context, it is safe to introduce
an RCU read-side critical section within it.

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

Changes in v3:
- Replaced WARN_ON() with  WARN_ON_ONCE(), as suggested by Willem de Bruijn.
- Dropped legacy lines mistakenly pulled in from an outdated branch.

Changes in v2:
- Addressed review comments from Eric Dumazet
- Used READ_ONCE() to prevent potential load/store tearing
- Added skb_dst_dev_rcu() and used along with rcu_read_lock() in ip_output

Signed-off-by: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
---
 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 15 ++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 00467c1b5093..bab01363bb97 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -568,11 +568,23 @@ static inline struct net_device *dst_dev(const struct dst_entry *dst)
 	return READ_ONCE(dst->dev);
 }
 
+static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
+{
+	/* In the future, use rcu_dereference(dst->dev) */
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	return READ_ONCE(dst->dev);
+}
+
 static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
 {
 	return dst_dev(skb_dst(skb));
 }
 
+static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
+{
+	return dst_dev_rcu(skb_dst(skb));
+}
+
 static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
 {
 	return dev_net(skb_dst_dev(skb));
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 10a1d182fd84..84e7f8a2f50f 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -425,15 +425,20 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst_dev(skb), *indev = skb->dev;
+	struct net_device *dev, *indev = skb->dev;
+	int ret_val;
 
+	rcu_read_lock();
+	dev = skb_dst_dev_rcu(skb);
 	skb->dev = dev;
 	skb->protocol = htons(ETH_P_IP);
 
-	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
-			    net, sk, skb, indev, dev,
-			    ip_finish_output,
-			    !(IPCB(skb)->flags & IPSKB_REROUTED));
+	ret_val = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
+				net, sk, skb, indev, dev,
+				ip_finish_output,
+				!(IPCB(skb)->flags & IPSKB_REROUTED));
+	rcu_read_unlock();
+	return ret_val;
 }
 EXPORT_SYMBOL(ip_output);
 

