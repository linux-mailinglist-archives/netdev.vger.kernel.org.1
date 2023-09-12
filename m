Return-Path: <netdev+bounces-33280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BC879D498
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26615281DA5
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B29618B1F;
	Tue, 12 Sep 2023 15:16:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F218B18
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:16:57 +0000 (UTC)
X-Greylist: delayed 2643 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Sep 2023 08:16:56 PDT
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9418712E
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:16:56 -0700 (PDT)
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38CBjx3T013978;
	Tue, 12 Sep 2023 15:32:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=jan2016.eng; bh=cCMva
	KeYEKSRnvDj7gM+RvL9tN/IKxbvboXJhOtSKwU=; b=n6El1hsWMWPsQbd5GGuW8
	hcYqgm3ViHljbJkl7mLYeEZM3jhGDautidB+BM7NhhQzyOConKU0xphjI2aJHNu/
	/U9II4ypp86+Ae/IFHxTA+Sa8zax6b13UotrhayjrPavbjF0XwRJUQQ4dNgAaqOL
	FP+JAHEgY90Q0as6vfMSU8XAc5WlqkeFcPwYKNvhhBCNTIi68mqdgUs0egUci5VK
	SUA85m67ZkPk38MnqaWBGeKGvRTqwjpOOVUI0pLVzHAgvZPTciZGuuYCU5dB8QTg
	+/RwOxzxbQOLWlUS0XPbUZiHt3hReLBcR8zzoH154ugm8owoupmZhfJAUycXJQTQ
	w==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 3t0djt3qg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 15:32:33 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 38CDucEU021743;
	Tue, 12 Sep 2023 10:32:32 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 3t0m1x8jdc-1;
	Tue, 12 Sep 2023 10:32:32 -0400
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.122.140])
	by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 72ABC627E3;
	Tue, 12 Sep 2023 14:32:23 +0000 (GMT)
From: Jason Baron <jbaron@akamai.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [net-next 1/2] inet_diag: export SO_REUSEADDR and SO_REUSEPORT sockopts
Date: Tue, 12 Sep 2023 10:31:48 -0400
Message-Id: <0b1deb44b8401042542a112e8235e039fc0a5f65.1694523876.git.jbaron@akamai.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1694523876.git.jbaron@akamai.com>
References: <cover.1694523876.git.jbaron@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0
 mlxlogscore=965 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120121
X-Proofpoint-GUID: 5ky7a4ouv9oCi9kOnfvPe27DO2M07-VX
X-Proofpoint-ORIG-GUID: 5ky7a4ouv9oCi9kOnfvPe27DO2M07-VX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0
 mlxlogscore=906 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309120121

Add the ability to monitor SO_REUSEADDR and SO_REUSEPORT for an inet
socket. These settings are currently readable via getsockopt().
We have an app that will sometimes fail to bind() and it's helpful to
understand what other apps are causing the bind() conflict.

Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 include/linux/inet_diag.h      | 2 ++
 include/uapi/linux/inet_diag.h | 7 +++++++
 net/ipv4/inet_diag.c           | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
index 84abb30a3fbb..d05a4c26b13d 100644
--- a/include/linux/inet_diag.h
+++ b/include/linux/inet_diag.h
@@ -77,6 +77,8 @@ static inline size_t inet_diag_msg_attrs_size(void)
 #endif
 		+ nla_total_size(sizeof(struct inet_diag_sockopt))
 						     /* INET_DIAG_SOCKOPT */
+		+ nla_total_size(sizeof(struct inet_diag_reuse))
+						    /* INET_DIAG_REUSE */
 		;
 }
 int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.h
index 50655de04c9b..f93eeea1faba 100644
--- a/include/uapi/linux/inet_diag.h
+++ b/include/uapi/linux/inet_diag.h
@@ -161,6 +161,7 @@ enum {
 	INET_DIAG_SK_BPF_STORAGES,
 	INET_DIAG_CGROUP_ID,
 	INET_DIAG_SOCKOPT,
+	INET_DIAG_REUSE,
 	__INET_DIAG_MAX,
 };
 
@@ -201,6 +202,12 @@ struct inet_diag_sockopt {
 		unused:5;
 };
 
+struct inet_diag_reuse {
+	__u8	reuse:4,
+		reuseport:1,
+		unused:3;
+};
+
 /* INET_DIAG_VEGASINFO */
 
 struct tcpvegas_info {
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index e13a84433413..d6ebb1e612fc 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -125,6 +125,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 			     bool net_admin)
 {
 	const struct inet_sock *inet = inet_sk(sk);
+	struct inet_diag_reuse inet_reuse = {};
 	struct inet_diag_sockopt inet_sockopt;
 
 	if (nla_put_u8(skb, INET_DIAG_SHUTDOWN, sk->sk_shutdown))
@@ -197,6 +198,12 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 		    &inet_sockopt))
 		goto errout;
 
+	inet_reuse.reuse = sk->sk_reuse;
+	inet_reuse.reuseport = sk->sk_reuseport;
+	if (nla_put(skb, INET_DIAG_REUSE, sizeof(inet_reuse),
+		    &inet_reuse))
+		goto errout;
+
 	return 0;
 errout:
 	return 1;
-- 
2.25.1


