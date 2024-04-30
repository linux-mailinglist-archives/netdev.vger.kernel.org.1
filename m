Return-Path: <netdev+bounces-92496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E60A8B78DC
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 16:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5931C21A6F
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 14:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A753677100;
	Tue, 30 Apr 2024 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="09aUXTeO"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE661770FC
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485838; cv=none; b=fbpYJA6WajP1M+gAUIGZy8gni820A0QsshWzQFjA2giNIdRtr/aBIi17HTrg+3U54odZBsVgocwxAl1FD5o/tiNea3+ryms5NhNlCnrH0EsFtADNrNIG0/qN6xtufSkX1tg5rsw5p2YnpG9XKbvGY1m9NIo55r33X0Mqf3tPsmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485838; c=relaxed/simple;
	bh=zDTiVG3U5MzR+MQP1mQ9ti8giLESOx8py6lATCzOJ/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q3ch6EQPdtPweADRPy2D1xMRW7DoKoWYmvuX4lFwPquGPuqR/dXODA0thAQZgFcxI4pUDhArxq/5jL1DkXyfEgvl1wUOC75hSe8q36KrP3esYadvi7HK/F5PwxJEkLLOsmf0IeDqY25vDAWpR3eYrz9EDqiCrT1Sq2Hk3w2dfgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=09aUXTeO; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from raven.fritz.box (unknown [IPv6:2a02:8012:909b:0:c34f:7a0c:788d:3e51])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id C7A6C7D8BA;
	Tue, 30 Apr 2024 15:03:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1714485830; bh=zDTiVG3U5MzR+MQP1mQ9ti8giLESOx8py6lATCzOJ/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20Tom=20Parkin=20<tparkin@katalix.com>|To:=20netdev@vger.ke
	 rnel.org|Cc:=20Tom=20Parkin=20<tparkin@katalix.com>|Subject:=20[PA
	 TCH=20net-next]=20l2tp:=20fix=20ICMP=20error=20handling=20for=20UD
	 P-encap=20sockets|Date:=20Tue,=2030=20Apr=202024=2015:03:43=20+010
	 0|Message-Id:=20<20240430140343.389543-1-tparkin@katalix.com>|MIME
	 -Version:=201.0;
	b=09aUXTeOX5ROPX0VLCQrQGXiTVjAqphhyVJ3mCYTOO0NJuvCskJ3VCM0AyOyekK6s
	 XlawZ+wpR/4THvE+eHS/V1P+VBVPV2jNOwEQ9Vgu4ajS9UaymfyorWCgVXsWIJSc80
	 Yu+8bGu0+og7ckIlbgEXmJHeWhZaa6PH7ioztExCJXjo8yuz86Gd12+2CqOX06IWG0
	 /lTZmsAcAyoC5p6DAVAjYts2RHVjtM8hvzB1hTyl/ZdWjgFS2RTISg31ENtIWQbJOE
	 +/K6FMZB9PV7wxluwHXBCMYEw+7ORJGEE3AjGmZPwFp9jJjelJdlkmZdRvE4v/X92t
	 uGBO3Rk3F04Rg==
From: Tom Parkin <tparkin@katalix.com>
To: netdev@vger.kernel.org
Cc: Tom Parkin <tparkin@katalix.com>
Subject: [PATCH net-next] l2tp: fix ICMP error handling for UDP-encap sockets
Date: Tue, 30 Apr 2024 15:03:43 +0100
Message-Id: <20240430140343.389543-1-tparkin@katalix.com>
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
 net/l2tp/l2tp_core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 8d21ff25f160..0a23de37d2d7 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -919,6 +919,28 @@ int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(l2tp_udp_encap_recv);
 
+static void l2tp_udp_encap_err_recv(struct sock *sk, struct sk_buff *skb, int err,
+				    __be16 port, u32 info, u8 *payload)
+{
+	struct l2tp_tunnel *tunnel = l2tp_sk_to_tunnel(sk);
+
+	if (!tunnel || tunnel->fd < 0)
+		return;
+
+	sk->sk_err = err;
+	sk_error_report(sk);
+
+	if (ip_hdr(skb)->version == IPVERSION) {
+		if (inet_test_bit(RECVERR, sk))
+			return ip_icmp_error(sk, skb, err, port, info, payload);
+	}
+#if IS_ENABLED(CONFIG_IPV6)
+	else
+		if (inet6_test_bit(RECVERR6, sk))
+			return ipv6_icmp_error(sk, skb, err, port, info, payload);
+#endif
+}
+
 /************************************************************************
  * Transmit handling
  ***********************************************************************/
@@ -1493,6 +1515,7 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
 			.sk_user_data = tunnel,
 			.encap_type = UDP_ENCAP_L2TPINUDP,
 			.encap_rcv = l2tp_udp_encap_recv,
+			.encap_err_rcv = l2tp_udp_encap_err_recv,
 			.encap_destroy = l2tp_udp_encap_destroy,
 		};
 
-- 
2.34.1


