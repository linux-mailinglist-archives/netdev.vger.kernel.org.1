Return-Path: <netdev+bounces-96112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F80A8C45EB
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5231F21A78
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8929520335;
	Mon, 13 May 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="Oyr0r5ih"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC4F23748
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620979; cv=none; b=Dzd8m9GQsf+8O64VCZynBJ94vRvs4EZ9NWtk6VmLG+vfENjE02EdlHPTgKDViBl8xc2NbXJ4yRX2rGbCFkktLdDDsKbkKMb/TgFV2ebtITw6Z5O4zuL05tBSy1BJDvtbe2vFFCNHD4ByoN/I7w/dDhBJsSqBHZhLqpdV5qNcYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620979; c=relaxed/simple;
	bh=Zix4FMd8+noxRXybgw5bkPx71UlQ31HeH9CU+FrUD7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XaxL9ShPuoT4zU1zE/WTdAi9aw8cpvMwwp6qSGu0E7Lo5Hg0puqYD8NzIOM4ppkiBCMG+WszSSyWubAnwfaFpTWp2ippvlhS8uY52u8JBWmLr/BIUUlZooOtvB6uEwTKxfvOdrEZW8eftFe4xYjVwa7vYdCBZlp6NtO+rC81E0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=Oyr0r5ih; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from raven.fritz.box (unknown [IPv6:2a02:8012:909b:0:bf0e:9f23:fd2f:ba2a])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id 91A497D9D4;
	Mon, 13 May 2024 18:22:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1715620971; bh=Zix4FMd8+noxRXybgw5bkPx71UlQ31HeH9CU+FrUD7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20Tom=20Parkin=20<tparkin@katalix.com>|To:=20netdev@vger.ke
	 rnel.org|Cc:=20Tom=20Parkin=20<tparkin@katalix.com>|Subject:=20[PA
	 TCH=20net]=20l2tp:=20fix=20ICMP=20error=20handling=20for=20UDP-enc
	 ap=20sockets|Date:=20Mon,=2013=20May=202024=2018:22:47=20+0100|Mes
	 sage-Id:=20<20240513172248.623261-1-tparkin@katalix.com>|MIME-Vers
	 ion:=201.0;
	b=Oyr0r5ihU746XoVwlw4FKDFOi1b9PeQ08GIQv0auqJZjsd3PukK3QAwcqzQW9yusC
	 ToHDF0xko3nJNfkBhRwGXCLbcGbR2j6OR2+tVAnQiTU7xxw3nmEIYrlnHvpIhD8Jvw
	 EwmTJLW85VKgURGbUbwU4QNzPU6AYg+1+6qxvbMqCBHM8uXZ/x5dHHLELRxsX0/mlg
	 rfVuW4EfY3T3r4rVAIGTAJ9+I6psceZb2KiNmiN8QiyFciMXidqji+3SJ+8dqfw7Qp
	 pzjdvPU932a9FgIa0P9Oe3QJ1Hq+LLD1u81lZNkucBTgncMAjD3Y1kGMBMDeLvruHJ
	 5UzcCxc6c1Uow==
From: Tom Parkin <tparkin@katalix.com>
To: netdev@vger.kernel.org
Cc: Tom Parkin <tparkin@katalix.com>
Subject: [PATCH net] l2tp: fix ICMP error handling for UDP-encap sockets
Date: Mon, 13 May 2024 18:22:47 +0100
Message-Id: <20240513172248.623261-1-tparkin@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a36e185e8c85
("udp: Handle ICMP errors for tunnels with same destination port on both endpoints")
UDP's handling of ICMP errors has allowed for UDP-encap tunnels to
determine socket associations in scenarios where the UDP hash lookup
could not.

Subsequently, commit d26796ae58940
("udp: check udp sock encap_type in __udp_lib_err")
subtly tweaked the approach such that UDP ICMP error handling would be
skipped for any UDP socket which has encapsulation enabled.

In the case of L2TP tunnel sockets using UDP-encap, this latter
modification effectively broke ICMP error reporting for the L2TP
control plane.

To a degree this isn't catastrophic inasmuch as the L2TP control
protocol defines a reliable transport on top of the underlying packet
switching network which will eventually detect errors and time out.

However, paying attention to the ICMP error reporting allows for more
timely detection of errors in L2TP userspace, and aids in debugging
connectivity issues.

Reinstate ICMP error handling for UDP encap L2TP tunnels:

 * implement struct udp_tunnel_sock_cfg .encap_err_rcv in order to allow
   the L2TP code to handle ICMP errors;

 * only implement error-handling for tunnels which have a managed
   socket: unmanaged tunnels using a kernel socket have no userspace to
   report errors back to;

 * flag the error on the socket, which allows for userspace to get an
   error such as -ECONNREFUSED back from sendmsg/recvmsg;

 * pass the error into ip[v6]_icmp_error() which allows for userspace to
   get extended error information via. MSG_ERRQUEUE.

Fixes: d26796ae5894 ("udp: check udp sock encap_type in __udp_lib_err")
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---

v2:

 * Target at net rather than net-next.
 * Fix up unbalanced braces with conditionally-compiled code.
 * Use rcu_dereference_sk_user_data() to derive the tunnel pointer from
   the sk, for the same reason l2tp_udp_encap_recv() uses that approach
   rather than l2tp_sk_to_tunnel().

---
 net/l2tp/l2tp_core.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 8d21ff25f160..4a0fb8731eee 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -887,22 +887,20 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 	return 1;
 }
 
-/* UDP encapsulation receive handler. See net/ipv4/udp.c.
- * Return codes:
- * 0 : success.
- * <0: error
- * >0: skb should be passed up to userspace as UDP.
+/* UDP encapsulation receive and error receive handlers.
+ * See net/ipv4/udp.c for details.
+ *
+ * Note that these functions are called from inside an
+ * RCU-protected region, but without the socket being locked.
+ *
+ * Hence we use rcu_dereference_sk_user_data to access the
+ * tunnel data structure rather the usual l2tp_sk_to_tunnel
+ * accessor function.
  */
 int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
 	struct l2tp_tunnel *tunnel;
 
-	/* Note that this is called from the encap_rcv hook inside an
-	 * RCU-protected region, but without the socket being locked.
-	 * Hence we use rcu_dereference_sk_user_data to access the
-	 * tunnel data structure rather the usual l2tp_sk_to_tunnel
-	 * accessor function.
-	 */
 	tunnel = rcu_dereference_sk_user_data(sk);
 	if (!tunnel)
 		goto pass_up;
@@ -919,6 +917,29 @@ int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(l2tp_udp_encap_recv);
 
+static void l2tp_udp_encap_err_recv(struct sock *sk, struct sk_buff *skb, int err,
+				    __be16 port, u32 info, u8 *payload)
+{
+	struct l2tp_tunnel *tunnel;
+
+	tunnel = rcu_dereference_sk_user_data(sk);
+	if (!tunnel || tunnel->fd < 0)
+		return;
+
+	sk->sk_err = err;
+	sk_error_report(sk);
+
+	if (ip_hdr(skb)->version == IPVERSION) {
+		if (inet_test_bit(RECVERR, sk))
+			return ip_icmp_error(sk, skb, err, port, info, payload);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		if (inet6_test_bit(RECVERR6, sk))
+			return ipv6_icmp_error(sk, skb, err, port, info, payload);
+#endif
+	}
+}
+
 /************************************************************************
  * Transmit handling
  ***********************************************************************/
@@ -1493,6 +1514,7 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
 			.sk_user_data = tunnel,
 			.encap_type = UDP_ENCAP_L2TPINUDP,
 			.encap_rcv = l2tp_udp_encap_recv,
+			.encap_err_rcv = l2tp_udp_encap_err_recv,
 			.encap_destroy = l2tp_udp_encap_destroy,
 		};
 
-- 
2.34.1


