Return-Path: <netdev+bounces-210791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1697B14D21
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 13:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9918544753
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A906A28E61E;
	Tue, 29 Jul 2025 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CvQdIDKs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB40F15A8
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753789388; cv=none; b=bGreF6DPIdQzBQK6T8gvQNbSKtOZ6wzRe34Ib9JlGnqI31URDmN+t/yaQCUl00dxXzWycWxek1QGT4F9SD8S5APCUqTu5eQWukwj028ItIfbXq7i20BtBbRBwHx0I+zGn+vrQpZdrKM9emEO0elPTL/460CqNL63hkA+vHUF57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753789388; c=relaxed/simple;
	bh=KJRgKWiqRhyYkJN1tjL+ae6RhfdZzqr4NhISDroUxZA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DBjEzKWubNipVBpME9X4bvSqQplk/dRGG/Dma9ANWnmYuPf5sZ6vpjk2cl61KvLyM33IdbmoBkWikeIsZh4Ep/tGxXjB4s6OupdeMQw+r5aPYUlpZUdO/I5DJ18wKHHrNlMFM8/fyhornGvKz6gwq4XM1dY8sqo3GaoWhU1JolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CvQdIDKs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T8mOiw023593;
	Tue, 29 Jul 2025 11:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=qkYSuAUP3ITP4aj/3zyQ8bV59QS+XcFiXFSVXJEvEKs=; b=Cv
	QdIDKsQsKtJz7rCyxzfg2Sv4dNq0BQvwW03mVAupC/adzTwzK0CSTxkyvU0OdjF3
	NYSRmNMMNk70RVeP9iMphKqmd90zD31eX9aSWvBF9M+BAYCsSsedSkO9ahDL6xUo
	rJ+w29ueDtaB/zt8MPxzD4rI4VsztHBouTlGqd7QndcZ1m2frhxlvZXyfbDqwEdX
	QFBq62Xf9FS3OjFpFA4PXZsYFCxnWMx/vPxckpfqitj4AV3SnYA+IuMQj5Sn32T5
	+YvSJW75rXfhjVrOgtmz4J44fSV60z/vzLLKllXVp8q7KCeajgTwSho8gKipRjGb
	qVJ41s+2U8HF9VTVgiyQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6qqvwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 11:42:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56TBgwYS014369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 11:42:58 GMT
Received: from hu-sharathv-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 29 Jul 2025 04:42:55 -0700
Date: Tue, 29 Jul 2025 17:12:51 +0530
From: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <quic_kapandey@quicinc.com>, <quic_subashab@quicinc.com>
Subject: [PATCH v2] net: Add locking to protect skb->dev access in ip_output
Message-ID: <20250729114251.GA2193@hu-sharathv-hyd.qualcomm.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA5MSBTYWx0ZWRfX8orURk6rXLSk
 DqkL8CRfOX4EVlnHMQdiYUoG99fcA8lcxXDmFOq/DIhT9ppFe1EchjiJosWdfGFJXMcYrtkKKe0
 uthuiczTEx3Rp57e2lW9wfPGL9qM3cCcSqtIK17UtTaCl7FEv8Rd+tPTYlpwLm84jFIjDGIL2H0
 8dmMy3xmOTNdUIDhEFsoThMd5uee0PhYYPXCvJpuK9U4u0Vrg1ldWt4pTdTwE7Yyr1bkhNIbfVj
 14obYvwTVaAl2HO54dQT93mwmE/BFr/Kr0TOWtVnk+P0/BTMdfiGZiaWNhmG9YeceA9C8TML8ml
 jqRsh5J/h5xbyrvI9bliYO2JIgZZRXSo4695CWVwtNXjCwFuXR7xDlrEMjsN9Sf3tbhTwXbGsC8
 a8rAW0zgT3x0bR+Ao2fXzk7ZPQIB49RahIFtqk0tjcF/XCrvXA9PTsH+DFk5YFdgjLTh6ls/
X-Proofpoint-ORIG-GUID: MhUpLbRWO4QRkMm4mxjgYdVUiXNjBTfD
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=6888b3c3 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=HiwjtTabofqhHkfYz1IA:9 a=CjuIK1q_8ugA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: MhUpLbRWO4QRkMm4mxjgYdVUiXNjBTfD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290091

In ip_output() skb->dev is updated from the skb_dst(skb)->dev
this can become invalid when the interface is unregistered and freed,

Introduced new skb_dst_dev_rcu() function to be used instead of
skb_dst_dev() within rcu_locks in outout.This will ensure that
all the skb's associated with the dev being deregistered will
be transnmitted out first, before freeing the dev.

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

Changes in v2:
- Addressed review comments from Eric Dumazet
- Used READ_ONCE() to prevent potential load/store tearing
- Added skb_dst_dev_rcu() and used along with rcu_read_lock() in ip_output

Signed-off-by: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
---
 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 17 ++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 00467c1b5093..692ebb1b3f42 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -568,11 +568,23 @@ static inline struct net_device *dst_dev(const struct dst_entry *dst)
 	return READ_ONCE(dst->dev);
 }
 
+static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
+{
+	/* In the future, use rcu_dereference(dst->dev) */
+	WARN_ON(!rcu_read_lock_held());
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
index 10a1d182fd84..d70d79b71897 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -425,15 +425,22 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst_dev(skb), *indev = skb->dev;
+	struct net_device *dev, *indev = skb->dev;
+	int ret_val;
 
+	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
+
+	rcu_read_lock();
+	dev = skb_dst_dev_rcu(skb);
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
 

