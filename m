Return-Path: <netdev+bounces-113697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1D93F99B
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC761282E27
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C17015921B;
	Mon, 29 Jul 2024 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="woRidNEJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C648413BC3F
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267497; cv=none; b=qteSk9iSLPCbyO+mBQJd5+f1VPcFqU7AAnwKSKWwZP8qtPGzDKtdkFkQZsOOYl5kLCXrQGYXXiqGbmTJE4Ve4rwYydFwrQldXtiR8nAeEAgCPf8hI3wpnEnhoPTG6AzlIeYocQnzccljdMm2Iu6cara/GmeIyn57fsq/aUS9BWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267497; c=relaxed/simple;
	bh=jOrD3Ywonye7ccVKUoLIgonb8s5USPSg2WdfwCA3xi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i5kOz6cj4LCD6i3RpZeiPr8G8o9vH4x5psyE9fLo2ESe5JRnNthhVwxX5nVZbcbN52yfQPg3fCCEMxelEQx0MDpWpDXZzIaQPQr2sBeLYs1LkFbGPvPPUg+iY3+39J5kY14yceMoH0otOc23HE2XfBRE2Q3GPnH7odUP1T3HGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=woRidNEJ; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6c24:bf58:f1fe:91c1])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 1301A7DAD9;
	Mon, 29 Jul 2024 16:38:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722267495; bh=jOrD3Ywonye7ccVKUoLIgonb8s5USPSg2WdfwCA3xi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=2001/15]=20l2tp:=20lookup=20tunnel=20from=20socket=20witho
	 ut=20using=20sk_user_data|Date:=20Mon,=2029=20Jul=202024=2016:38:0
	 0=20+0100|Message-Id:=20<892b98b875da7c42cebbc952305ad913468d581e.
	 1722265212.git.jchapman@katalix.com>|In-Reply-To:=20<cover.1722265
	 212.git.jchapman@katalix.com>|References:=20<cover.1722265212.git.
	 jchapman@katalix.com>|MIME-Version:=201.0;
	b=woRidNEJwHXix958WCsWXIzCVf5zGEIuuoQmZbmxYvJp80nEF4UsZ+jQ96UTWyxC9
	 ZTZUazYaYK9L15QWcyX3D62IsuCvx3yB1u6WuA+KKubtfIhrJdbi+lnVQmtvGEwZv+
	 QpZQ4Ou3GWS5ZMLb/EONE6ptohsM3JfalqEIzQIAg7AwYo0Ibmy5dllgf4qAkdECnm
	 uUAG+inEErbt/SJmKHneQoOwRCKp//XRirYm0g27jvsNFUfwA9Igq/qyHdoM9jMyr9
	 vBc32eN+6CpH9zYvuGAIxKQVMxu8TJhhdpl/N10bEkCdMkrKXzjzggy182wlHcx4RH
	 iDfr596IaqtfQ==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 01/15] l2tp: lookup tunnel from socket without using sk_user_data
Date: Mon, 29 Jul 2024 16:38:00 +0100
Message-Id: <892b98b875da7c42cebbc952305ad913468d581e.1722265212.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722265212.git.jchapman@katalix.com>
References: <cover.1722265212.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp_sk_to_tunnel derives the tunnel from sk_user_data. Instead,
lookup the tunnel by walking the tunnel IDR for a tunnel using the
indicated sock. This is slow but l2tp_sk_to_tunnel is not used in
the datapath so performance isn't critical.

l2tp_tunnel_destruct needs a variant of l2tp_sk_to_tunnel which does
not bump the tunnel refcount since the tunnel refcount is already 0.

Change l2tp_sk_to_tunnel sk arg to const since it does not modify sk.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 52 ++++++++++++++++++++++++++++++++++++--------
 net/l2tp/l2tp_core.h |  5 +----
 net/l2tp/l2tp_ip.c   |  7 ++++--
 net/l2tp/l2tp_ip6.c  |  7 ++++--
 4 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index c80ab3f26084..c97cd0fd8514 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -150,15 +150,43 @@ static void l2tp_session_free(struct l2tp_session *session)
 	kfree(session);
 }
 
-struct l2tp_tunnel *l2tp_sk_to_tunnel(struct sock *sk)
+static struct l2tp_tunnel *__l2tp_sk_to_tunnel(const struct sock *sk)
 {
-	struct l2tp_tunnel *tunnel = sk->sk_user_data;
+	const struct net *net = sock_net(sk);
+	unsigned long tunnel_id, tmp;
+	struct l2tp_tunnel *tunnel;
+	struct l2tp_net *pn;
+
+	WARN_ON_ONCE(!rcu_read_lock_bh_held());
+	pn = l2tp_pernet(net);
+	idr_for_each_entry_ul(&pn->l2tp_tunnel_idr, tunnel, tmp, tunnel_id) {
+		if (tunnel && tunnel->sock == sk)
+			return tunnel;
+	}
+
+	return NULL;
+}
 
-	if (tunnel)
-		if (WARN_ON(tunnel->magic != L2TP_TUNNEL_MAGIC))
-			return NULL;
+struct l2tp_tunnel *l2tp_sk_to_tunnel(const struct sock *sk)
+{
+	const struct net *net = sock_net(sk);
+	unsigned long tunnel_id, tmp;
+	struct l2tp_tunnel *tunnel;
+	struct l2tp_net *pn;
+
+	rcu_read_lock_bh();
+	pn = l2tp_pernet(net);
+	idr_for_each_entry_ul(&pn->l2tp_tunnel_idr, tunnel, tmp, tunnel_id) {
+		if (tunnel &&
+		    tunnel->sock == sk &&
+		    refcount_inc_not_zero(&tunnel->ref_count)) {
+			rcu_read_unlock_bh();
+			return tunnel;
+		}
+	}
+	rcu_read_unlock_bh();
 
-	return tunnel;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(l2tp_sk_to_tunnel);
 
@@ -1213,8 +1241,10 @@ EXPORT_SYMBOL_GPL(l2tp_xmit_skb);
  */
 static void l2tp_tunnel_destruct(struct sock *sk)
 {
-	struct l2tp_tunnel *tunnel = l2tp_sk_to_tunnel(sk);
+	struct l2tp_tunnel *tunnel;
 
+	rcu_read_lock_bh();
+	tunnel = __l2tp_sk_to_tunnel(sk);
 	if (!tunnel)
 		goto end;
 
@@ -1242,6 +1272,7 @@ static void l2tp_tunnel_destruct(struct sock *sk)
 
 	kfree_rcu(tunnel, rcu);
 end:
+	rcu_read_unlock_bh();
 	return;
 }
 
@@ -1308,10 +1339,13 @@ static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
 /* Tunnel socket destroy hook for UDP encapsulation */
 static void l2tp_udp_encap_destroy(struct sock *sk)
 {
-	struct l2tp_tunnel *tunnel = l2tp_sk_to_tunnel(sk);
+	struct l2tp_tunnel *tunnel;
 
-	if (tunnel)
+	tunnel = l2tp_sk_to_tunnel(sk);
+	if (tunnel) {
 		l2tp_tunnel_delete(tunnel);
+		l2tp_tunnel_dec_refcount(tunnel);
+	}
 }
 
 static void l2tp_tunnel_remove(struct net *net, struct l2tp_tunnel *tunnel)
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 8ac81bc1bc6f..a41cf6795df0 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -273,10 +273,7 @@ void l2tp_nl_unregister_ops(enum l2tp_pwtype pw_type);
 /* IOCTL helper for IP encap modules. */
 int l2tp_ioctl(struct sock *sk, int cmd, int *karg);
 
-/* Extract the tunnel structure from a socket's sk_user_data pointer,
- * validating the tunnel magic feather.
- */
-struct l2tp_tunnel *l2tp_sk_to_tunnel(struct sock *sk);
+struct l2tp_tunnel *l2tp_sk_to_tunnel(const struct sock *sk);
 
 static inline int l2tp_get_l2specific_len(struct l2tp_session *session)
 {
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index e48aa177d74c..78243f993cda 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -235,14 +235,17 @@ static void l2tp_ip_close(struct sock *sk, long timeout)
 
 static void l2tp_ip_destroy_sock(struct sock *sk)
 {
-	struct l2tp_tunnel *tunnel = l2tp_sk_to_tunnel(sk);
+	struct l2tp_tunnel *tunnel;
 	struct sk_buff *skb;
 
 	while ((skb = __skb_dequeue_tail(&sk->sk_write_queue)) != NULL)
 		kfree_skb(skb);
 
-	if (tunnel)
+	tunnel = l2tp_sk_to_tunnel(sk);
+	if (tunnel) {
 		l2tp_tunnel_delete(tunnel);
+		l2tp_tunnel_dec_refcount(tunnel);
+	}
 }
 
 static int l2tp_ip_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index d217ff1f229e..3b0465f2d60d 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -246,14 +246,17 @@ static void l2tp_ip6_close(struct sock *sk, long timeout)
 
 static void l2tp_ip6_destroy_sock(struct sock *sk)
 {
-	struct l2tp_tunnel *tunnel = l2tp_sk_to_tunnel(sk);
+	struct l2tp_tunnel *tunnel;
 
 	lock_sock(sk);
 	ip6_flush_pending_frames(sk);
 	release_sock(sk);
 
-	if (tunnel)
+	tunnel = l2tp_sk_to_tunnel(sk);
+	if (tunnel) {
 		l2tp_tunnel_delete(tunnel);
+		l2tp_tunnel_dec_refcount(tunnel);
+	}
 }
 
 static int l2tp_ip6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
-- 
2.34.1


