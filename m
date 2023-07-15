Return-Path: <netdev+bounces-18043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1333C75462F
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 04:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEB228231C
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 02:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F879A47;
	Sat, 15 Jul 2023 02:14:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EAE7EC
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 02:14:23 +0000 (UTC)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F359430DF
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 19:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689387263; x=1720923263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E6Bw//y+gCtRJDevQpDxEQCpbuaOtFoqCDqM5B26ds4=;
  b=GCzSDNufP+pobl5vsApeQEZBLsMMgRCAh9AM4re6Q3Of7igHCZCYC10l
   S1aUJJHRvBvFkBXpwjB3f8cUmuq8QRc3OHcJw/ghY+evcnWPQBdok1kSh
   D/tAipX4qwAYdKQNTt2/+t5WmKqr20lWNLBD7mKxZeadV+JX3lNlrigrv
   U=;
X-IronPort-AV: E=Sophos;i="6.01,207,1684800000"; 
   d="scan'208";a="142834175"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 02:14:21 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com (Postfix) with ESMTPS id 810DF80596;
	Sat, 15 Jul 2023 02:14:17 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 15 Jul 2023 02:14:16 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 15 Jul 2023 02:14:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Harry Coin
	<hcoin@quietfountain.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Kuniyuki
 Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 1/4] llc: Check netns in llc_dgram_match().
Date: Fri, 14 Jul 2023 19:13:35 -0700
Message-ID: <20230715021338.34747-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230715021338.34747-1-kuniyu@amazon.com>
References: <20230715021338.34747-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.14]
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We will remove this restriction in llc_rcv() in the following patch,
which means that the protocol handler must be aware of netns.

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
 net/llc/llc_sap.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/llc/llc_sap.c b/net/llc/llc_sap.c
index 6805ce43a055..5c83fca3acd5 100644
--- a/net/llc/llc_sap.c
+++ b/net/llc/llc_sap.c
@@ -294,13 +294,15 @@ static void llc_sap_rcv(struct llc_sap *sap, struct sk_buff *skb,
 
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
@@ -312,7 +314,8 @@ static inline bool llc_dgram_match(const struct llc_sap *sap,
  *	mac, and local sap. Returns pointer for socket found, %NULL otherwise.
  */
 static struct sock *llc_lookup_dgram(struct llc_sap *sap,
-				     const struct llc_addr *laddr)
+				     const struct llc_addr *laddr,
+				     const struct net *net)
 {
 	struct sock *rc;
 	struct hlist_nulls_node *node;
@@ -322,12 +325,12 @@ static struct sock *llc_lookup_dgram(struct llc_sap *sap,
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
@@ -429,7 +432,7 @@ void llc_sap_handler(struct llc_sap *sap, struct sk_buff *skb)
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


