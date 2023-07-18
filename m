Return-Path: <netdev+bounces-18660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0547583AB
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC2E1C20D02
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB17315AC3;
	Tue, 18 Jul 2023 17:42:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB1FC16
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:42:37 +0000 (UTC)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954C5F7
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689702157; x=1721238157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EKc19ne5raO5qoGCOAzXdgmbj1kK1dKvVWyplDZEx5s=;
  b=Ji/QKUqgdBUeCCnDu3RjTk+OyACqIWx5yOPCm3J9UbQTKLAygDuXCLhj
   N0xGF6l+C2TLIv4atCuDTRdUHDcnnuSm9DuAUgr1JfXcxNrn1MwQuzvke
   pcvCw1khq9pZZ1ZSst188TBqHLOTyaBsEWoh9v9GYPmh+Dt4a/j/chR//
   M=;
X-IronPort-AV: E=Sophos;i="6.01,214,1684800000"; 
   d="scan'208";a="347445522"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 17:42:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix) with ESMTPS id 967778068E;
	Tue, 18 Jul 2023 17:42:31 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 17:42:30 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Tue, 18 Jul 2023 17:42:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Harry Coin
	<hcoin@quietfountain.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Kuniyuki
 Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 1/4] llc: Check netns in llc_dgram_match().
Date: Tue, 18 Jul 2023 10:41:49 -0700
Message-ID: <20230718174152.57408-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230718174152.57408-1-kuniyu@amazon.com>
References: <20230718174152.57408-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.18]
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We will remove this restriction in llc_rcv() soon, which means that the
protocol handler must be aware of netns.

	if (!net_eq(dev_net(dev), &init_net))
		goto drop;

llc_rcv() fetches llc_type_handlers[llc_pdu_type(skb) - 1] and calls it
if not NULL.

If the PDU type is LLC_DEST_SAP, llc_sap_handler() is called to pass skb
to corresponding sockets.  Then, we must look up a proper socket in the
same netns with skb->dev.

If the destination is a multicast address, llc_sap_handler() calls
llc_sap_mcast().  It calculates a hash based on DSAP and skb->dev->ifindex,
iterates on a socket list, and calls llc_mcast_match() to check if the
socket is the correct destination.  Then, llc_mcast_match() checks if
skb->dev matches with llc_sk(sk)->dev.  So, we need not check netns here.

OTOH, if the destination is a unicast address, llc_sap_handler() calls
llc_lookup_dgram() to look up a socket, but it does not check the netns.

Therefore, we need to add netns check in llc_lookup_dgram().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/llc/llc_sap.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/llc/llc_sap.c b/net/llc/llc_sap.c
index 6805ce43a055..116c0e479183 100644
--- a/net/llc/llc_sap.c
+++ b/net/llc/llc_sap.c
@@ -294,25 +294,29 @@ static void llc_sap_rcv(struct llc_sap *sap, struct sk_buff *skb,
 
 static inline bool llc_dgram_match(const struct llc_sap *sap,
 				   const struct llc_addr *laddr,
-				   const struct sock *sk)
+				   const struct sock *sk,
+				   const struct net *net)
 {
      struct llc_sock *llc = llc_sk(sk);
 
      return sk->sk_type == SOCK_DGRAM &&
-	  llc->laddr.lsap == laddr->lsap &&
-	  ether_addr_equal(llc->laddr.mac, laddr->mac);
+	     net_eq(sock_net(sk), net) &&
+	     llc->laddr.lsap == laddr->lsap &&
+	     ether_addr_equal(llc->laddr.mac, laddr->mac);
 }
 
 /**
  *	llc_lookup_dgram - Finds dgram socket for the local sap/mac
  *	@sap: SAP
  *	@laddr: address of local LLC (MAC + SAP)
+ *	@net: netns to look up a socket in
  *
  *	Search socket list of the SAP and finds connection using the local
  *	mac, and local sap. Returns pointer for socket found, %NULL otherwise.
  */
 static struct sock *llc_lookup_dgram(struct llc_sap *sap,
-				     const struct llc_addr *laddr)
+				     const struct llc_addr *laddr,
+				     const struct net *net)
 {
 	struct sock *rc;
 	struct hlist_nulls_node *node;
@@ -322,12 +326,12 @@ static struct sock *llc_lookup_dgram(struct llc_sap *sap,
 	rcu_read_lock_bh();
 again:
 	sk_nulls_for_each_rcu(rc, node, laddr_hb) {
-		if (llc_dgram_match(sap, laddr, rc)) {
+		if (llc_dgram_match(sap, laddr, rc, net)) {
 			/* Extra checks required by SLAB_TYPESAFE_BY_RCU */
 			if (unlikely(!refcount_inc_not_zero(&rc->sk_refcnt)))
 				goto again;
 			if (unlikely(llc_sk(rc)->sap != sap ||
-				     !llc_dgram_match(sap, laddr, rc))) {
+				     !llc_dgram_match(sap, laddr, rc, net))) {
 				sock_put(rc);
 				continue;
 			}
@@ -429,7 +433,7 @@ void llc_sap_handler(struct llc_sap *sap, struct sk_buff *skb)
 		llc_sap_mcast(sap, &laddr, skb);
 		kfree_skb(skb);
 	} else {
-		struct sock *sk = llc_lookup_dgram(sap, &laddr);
+		struct sock *sk = llc_lookup_dgram(sap, &laddr, dev_net(skb->dev));
 		if (sk) {
 			llc_sap_rcv(sap, skb, sk);
 			sock_put(sk);
-- 
2.30.2


