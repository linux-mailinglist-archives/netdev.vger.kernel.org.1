Return-Path: <netdev+bounces-16187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8367474BB70
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 04:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38ADD2819FF
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 02:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488961FA1;
	Sat,  8 Jul 2023 02:34:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801223C0
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 02:34:51 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4FCE45;
	Fri,  7 Jul 2023 19:34:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3680lqgx030290;
	Sat, 8 Jul 2023 02:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=O7NbcbjtiQq9pJ4WxuugR5NVz78nLpWUeNDqRkf/nUo=;
 b=rZSM9eM8cN4IJjIH/1Rh4jZs8mGVpfoLrLIXgUXFqcmny1y5fcDOmsjOOHEbhVmbHJq/
 Lm2aJDojtarvXDuXIwP/IwGFjcABjx98hXqFx2y0ETRb0uye9m4RzB7v4lFYm8q4iCFh
 p1nuK1qpGot99R+h9cNsXL8bG0E7iYVlbbBfI+TcURalSbomXAXEfqLhUqYfzNzVmSc8
 s/Jh/L495zINHmi5SH0QKDKuuEgKL4VWLG/Hx4S/LvDohaqwpeTvDSvT2ZAMTxRzedav
 RC/X1DCgIODzCBEmSScE0/4GXtY+LwHAvDBc7prLJzTLgr5PbxY1XO0TncfzboPBa1rf 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpfhpsj9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Jul 2023 02:34:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3681X6nC034583;
	Sat, 8 Jul 2023 02:34:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx81h02h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Jul 2023 02:34:23 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3682YL30033474;
	Sat, 8 Jul 2023 02:34:22 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3rpx81h01x-2;
	Sat, 08 Jul 2023 02:34:22 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: davem@davemloft.net
Cc: Liam.Howlett@Oracle.com, akpm@linux-foundation.org, david@fries.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        zbr@ioremap.net, brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, anjali.k.kulkarni@oracle.com
Subject: [PATCH v9 1/6] netlink: Reverse the patch which removed filtering
Date: Fri,  7 Jul 2023 19:34:15 -0700
Message-ID: <20230708023420.3931239-2-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708023420.3931239-1-anjali.k.kulkarni@oracle.com>
References: <20230708023420.3931239-1-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=988
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307080022
X-Proofpoint-GUID: OgwJ0FxBMw0nrwjshhzyOLxaJxE6ysoW
X-Proofpoint-ORIG-GUID: OgwJ0FxBMw0nrwjshhzyOLxaJxE6ysoW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

To use filtering at the connector & cn_proc layers, we need to enable
filtering in the netlink layer. This reverses the patch which removed
netlink filtering - commit ID for that patch:
549017aa1bb7 (netlink: remove netlink_broadcast_filtered).

Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netlink.h  |  5 +++++
 net/netlink/af_netlink.c | 27 +++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 19c0791ed9d5..d73cfe5b6bc2 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -227,6 +227,11 @@ bool netlink_strict_get_check(struct sk_buff *skb);
 int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 portid, int nonblock);
 int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, __u32 portid,
 		      __u32 group, gfp_t allocation);
+int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb,
+			       __u32 portid, __u32 group, gfp_t allocation,
+			       int (*filter)(struct sock *dsk,
+					     struct sk_buff *skb, void *data),
+			       void *filter_data);
 int netlink_set_err(struct sock *ssk, __u32 portid, __u32 group, int code);
 int netlink_register_notifier(struct notifier_block *nb);
 int netlink_unregister_notifier(struct notifier_block *nb);
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 3a1e0fd5bf14..e75e5156e4ac 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1432,6 +1432,8 @@ struct netlink_broadcast_data {
 	int delivered;
 	gfp_t allocation;
 	struct sk_buff *skb, *skb2;
+	int (*tx_filter)(struct sock *dsk, struct sk_buff *skb, void *data);
+	void *tx_data;
 };
 
 static void do_one_broadcast(struct sock *sk,
@@ -1485,6 +1487,13 @@ static void do_one_broadcast(struct sock *sk,
 			p->delivery_failure = 1;
 		goto out;
 	}
+
+	if (p->tx_filter && p->tx_filter(sk, p->skb2, p->tx_data)) {
+		kfree_skb(p->skb2);
+		p->skb2 = NULL;
+		goto out;
+	}
+
 	if (sk_filter(sk, p->skb2)) {
 		kfree_skb(p->skb2);
 		p->skb2 = NULL;
@@ -1507,8 +1516,12 @@ static void do_one_broadcast(struct sock *sk,
 	sock_put(sk);
 }
 
-int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
-		      u32 group, gfp_t allocation)
+int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb,
+			       u32 portid,
+			       u32 group, gfp_t allocation,
+			       int (*filter)(struct sock *dsk,
+					     struct sk_buff *skb, void *data),
+			       void *filter_data)
 {
 	struct net *net = sock_net(ssk);
 	struct netlink_broadcast_data info;
@@ -1527,6 +1540,8 @@ int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
 	info.allocation = allocation;
 	info.skb = skb;
 	info.skb2 = NULL;
+	info.tx_filter = filter;
+	info.tx_data = filter_data;
 
 	/* While we sleep in clone, do not allow to change socket list */
 
@@ -1552,6 +1567,14 @@ int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
 	}
 	return -ESRCH;
 }
+EXPORT_SYMBOL(netlink_broadcast_filtered);
+
+int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
+		      u32 group, gfp_t allocation)
+{
+	return netlink_broadcast_filtered(ssk, skb, portid, group, allocation,
+					  NULL, NULL);
+}
 EXPORT_SYMBOL(netlink_broadcast);
 
 struct netlink_set_err_data {
-- 
2.41.0


