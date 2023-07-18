Return-Path: <netdev+bounces-18662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2875A7583B0
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2A22815C8
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D9715ACE;
	Tue, 18 Jul 2023 17:43:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7CB15AC3
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:43:03 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C301D10FF
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689702182; x=1721238182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=55FK+8TfP8y1UujI1QfBQns5KSV2TOxmbSXwXGdc23w=;
  b=mEGD965dIZdrOvvjtILIep27gOCFLMXUE+IWbgnqQPsHDMqormv6Cwbp
   A2OPEarSgX2x+PqrWtB+EGDoifBoSjavUsKdeyFVS+yrAU/X/hhsZJrAv
   9iBZudR6K6SLqFkDHB8e4J0UtNv0XnL3SBPtrO+Pz6+yz02pHKeTn8pFr
   s=;
X-IronPort-AV: E=Sophos;i="6.01,214,1684800000"; 
   d="scan'208";a="345255269"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 17:43:01 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 2FFA861124;
	Tue, 18 Jul 2023 17:42:59 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 17:42:56 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 17:42:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Harry Coin
	<hcoin@quietfountain.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Kuniyuki
 Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 2/4] llc: Check netns in llc_estab_match() and llc_listener_match().
Date: Tue, 18 Jul 2023 10:41:50 -0700
Message-ID: <20230718174152.57408-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
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

If the PDU type is LLC_DEST_CONN, llc_conn_handler() is called to pass
skb to corresponding sockets.  Then, we must look up a proper socket in
the same netns with skb->dev.

llc_conn_handler() calls __llc_lookup() to look up a established or
litening socket by __llc_lookup_established() and llc_lookup_listener().

Both functions iterate on a list and call llc_estab_match() or
llc_listener_match() to check if the socket is the correct destination.
However, these functions do not check netns.

Also, bind() and connect() call llc_establish_connection(), which
finally calls __llc_lookup_established(), to check if there is a
conflicting socket.

Let's test netns in llc_estab_match() and llc_listener_match().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/llc_conn.h |  2 +-
 net/llc/af_llc.c       |  2 +-
 net/llc/llc_conn.c     | 49 ++++++++++++++++++++++++++----------------
 net/llc/llc_if.c       |  2 +-
 4 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/include/net/llc_conn.h b/include/net/llc_conn.h
index 2c1ea3414640..374411b3066c 100644
--- a/include/net/llc_conn.h
+++ b/include/net/llc_conn.h
@@ -111,7 +111,7 @@ void llc_conn_resend_i_pdu_as_cmd(struct sock *sk, u8 nr, u8 first_p_bit);
 void llc_conn_resend_i_pdu_as_rsp(struct sock *sk, u8 nr, u8 first_f_bit);
 int llc_conn_remove_acked_pdus(struct sock *conn, u8 nr, u16 *how_many_unacked);
 struct sock *llc_lookup_established(struct llc_sap *sap, struct llc_addr *daddr,
-				    struct llc_addr *laddr);
+				    struct llc_addr *laddr, const struct net *net);
 void llc_sap_add_socket(struct llc_sap *sap, struct sock *sk);
 void llc_sap_remove_socket(struct llc_sap *sap, struct sock *sk);
 
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 57c35c960b2c..9b06c380866b 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -402,7 +402,7 @@ static int llc_ui_bind(struct socket *sock, struct sockaddr *uaddr, int addrlen)
 		memcpy(laddr.mac, addr->sllc_mac, IFHWADDRLEN);
 		laddr.lsap = addr->sllc_sap;
 		rc = -EADDRINUSE; /* mac + sap clash. */
-		ask = llc_lookup_established(sap, &daddr, &laddr);
+		ask = llc_lookup_established(sap, &daddr, &laddr, &init_net);
 		if (ask) {
 			sock_put(ask);
 			goto out_put;
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 912aa9bd5e29..d037009ee10f 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -453,11 +453,13 @@ static int llc_exec_conn_trans_actions(struct sock *sk,
 static inline bool llc_estab_match(const struct llc_sap *sap,
 				   const struct llc_addr *daddr,
 				   const struct llc_addr *laddr,
-				   const struct sock *sk)
+				   const struct sock *sk,
+				   const struct net *net)
 {
 	struct llc_sock *llc = llc_sk(sk);
 
-	return llc->laddr.lsap == laddr->lsap &&
+	return net_eq(sock_net(sk), net) &&
+		llc->laddr.lsap == laddr->lsap &&
 		llc->daddr.lsap == daddr->lsap &&
 		ether_addr_equal(llc->laddr.mac, laddr->mac) &&
 		ether_addr_equal(llc->daddr.mac, daddr->mac);
@@ -468,6 +470,7 @@ static inline bool llc_estab_match(const struct llc_sap *sap,
  *	@sap: SAP
  *	@daddr: address of remote LLC (MAC + SAP)
  *	@laddr: address of local LLC (MAC + SAP)
+ *	@net: netns to look up a socket in
  *
  *	Search connection list of the SAP and finds connection using the remote
  *	mac, remote sap, local mac, and local sap. Returns pointer for
@@ -476,7 +479,8 @@ static inline bool llc_estab_match(const struct llc_sap *sap,
  */
 static struct sock *__llc_lookup_established(struct llc_sap *sap,
 					     struct llc_addr *daddr,
-					     struct llc_addr *laddr)
+					     struct llc_addr *laddr,
+					     const struct net *net)
 {
 	struct sock *rc;
 	struct hlist_nulls_node *node;
@@ -486,12 +490,12 @@ static struct sock *__llc_lookup_established(struct llc_sap *sap,
 	rcu_read_lock();
 again:
 	sk_nulls_for_each_rcu(rc, node, laddr_hb) {
-		if (llc_estab_match(sap, daddr, laddr, rc)) {
+		if (llc_estab_match(sap, daddr, laddr, rc, net)) {
 			/* Extra checks required by SLAB_TYPESAFE_BY_RCU */
 			if (unlikely(!refcount_inc_not_zero(&rc->sk_refcnt)))
 				goto again;
 			if (unlikely(llc_sk(rc)->sap != sap ||
-				     !llc_estab_match(sap, daddr, laddr, rc))) {
+				     !llc_estab_match(sap, daddr, laddr, rc, net))) {
 				sock_put(rc);
 				continue;
 			}
@@ -513,29 +517,33 @@ static struct sock *__llc_lookup_established(struct llc_sap *sap,
 
 struct sock *llc_lookup_established(struct llc_sap *sap,
 				    struct llc_addr *daddr,
-				    struct llc_addr *laddr)
+				    struct llc_addr *laddr,
+				    const struct net *net)
 {
 	struct sock *sk;
 
 	local_bh_disable();
-	sk = __llc_lookup_established(sap, daddr, laddr);
+	sk = __llc_lookup_established(sap, daddr, laddr, net);
 	local_bh_enable();
 	return sk;
 }
 
 static inline bool llc_listener_match(const struct llc_sap *sap,
 				      const struct llc_addr *laddr,
-				      const struct sock *sk)
+				      const struct sock *sk,
+				      const struct net *net)
 {
 	struct llc_sock *llc = llc_sk(sk);
 
-	return sk->sk_type == SOCK_STREAM && sk->sk_state == TCP_LISTEN &&
+	return net_eq(sock_net(sk), net) &&
+		sk->sk_type == SOCK_STREAM && sk->sk_state == TCP_LISTEN &&
 		llc->laddr.lsap == laddr->lsap &&
 		ether_addr_equal(llc->laddr.mac, laddr->mac);
 }
 
 static struct sock *__llc_lookup_listener(struct llc_sap *sap,
-					  struct llc_addr *laddr)
+					  struct llc_addr *laddr,
+					  const struct net *net)
 {
 	struct sock *rc;
 	struct hlist_nulls_node *node;
@@ -545,12 +553,12 @@ static struct sock *__llc_lookup_listener(struct llc_sap *sap,
 	rcu_read_lock();
 again:
 	sk_nulls_for_each_rcu(rc, node, laddr_hb) {
-		if (llc_listener_match(sap, laddr, rc)) {
+		if (llc_listener_match(sap, laddr, rc, net)) {
 			/* Extra checks required by SLAB_TYPESAFE_BY_RCU */
 			if (unlikely(!refcount_inc_not_zero(&rc->sk_refcnt)))
 				goto again;
 			if (unlikely(llc_sk(rc)->sap != sap ||
-				     !llc_listener_match(sap, laddr, rc))) {
+				     !llc_listener_match(sap, laddr, rc, net))) {
 				sock_put(rc);
 				continue;
 			}
@@ -574,6 +582,7 @@ static struct sock *__llc_lookup_listener(struct llc_sap *sap,
  *	llc_lookup_listener - Finds listener for local MAC + SAP
  *	@sap: SAP
  *	@laddr: address of local LLC (MAC + SAP)
+ *	@net: netns to look up a socket in
  *
  *	Search connection list of the SAP and finds connection listening on
  *	local mac, and local sap. Returns pointer for parent socket found,
@@ -581,24 +590,26 @@ static struct sock *__llc_lookup_listener(struct llc_sap *sap,
  *	Caller has to make sure local_bh is disabled.
  */
 static struct sock *llc_lookup_listener(struct llc_sap *sap,
-					struct llc_addr *laddr)
+					struct llc_addr *laddr,
+					const struct net *net)
 {
+	struct sock *rc = __llc_lookup_listener(sap, laddr, net);
 	static struct llc_addr null_addr;
-	struct sock *rc = __llc_lookup_listener(sap, laddr);
 
 	if (!rc)
-		rc = __llc_lookup_listener(sap, &null_addr);
+		rc = __llc_lookup_listener(sap, &null_addr, net);
 
 	return rc;
 }
 
 static struct sock *__llc_lookup(struct llc_sap *sap,
 				 struct llc_addr *daddr,
-				 struct llc_addr *laddr)
+				 struct llc_addr *laddr,
+				 const struct net *net)
 {
-	struct sock *sk = __llc_lookup_established(sap, daddr, laddr);
+	struct sock *sk = __llc_lookup_established(sap, daddr, laddr, net);
 
-	return sk ? : llc_lookup_listener(sap, laddr);
+	return sk ? : llc_lookup_listener(sap, laddr, net);
 }
 
 /**
@@ -776,7 +787,7 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	llc_pdu_decode_da(skb, daddr.mac);
 	llc_pdu_decode_dsap(skb, &daddr.lsap);
 
-	sk = __llc_lookup(sap, &saddr, &daddr);
+	sk = __llc_lookup(sap, &saddr, &daddr, dev_net(skb->dev));
 	if (!sk)
 		goto drop;
 
diff --git a/net/llc/llc_if.c b/net/llc/llc_if.c
index dde9bf08a593..58a5f419adc6 100644
--- a/net/llc/llc_if.c
+++ b/net/llc/llc_if.c
@@ -92,7 +92,7 @@ int llc_establish_connection(struct sock *sk, const u8 *lmac, u8 *dmac, u8 dsap)
 	daddr.lsap = dsap;
 	memcpy(daddr.mac, dmac, sizeof(daddr.mac));
 	memcpy(laddr.mac, lmac, sizeof(laddr.mac));
-	existing = llc_lookup_established(llc->sap, &daddr, &laddr);
+	existing = llc_lookup_established(llc->sap, &daddr, &laddr, sock_net(sk));
 	if (existing) {
 		if (existing->sk_state == TCP_ESTABLISHED) {
 			sk = existing;
-- 
2.30.2


