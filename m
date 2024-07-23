Return-Path: <netdev+bounces-112597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D3893A200
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312802833E6
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E14152794;
	Tue, 23 Jul 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="UOKv+LO3"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC09153808
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742715; cv=none; b=hZ/hFK9ZBstDI7IiJybDlzG6R7oH1sQL2w/di9UJzAQOyEc64OWGDC89VLyyH4EcSYy/j/ZNOxDIPADVd/ts5N2HA+E3LxzcvdY1k/UIF5MdOt2zMFJBp5+PzMkRnCHovuH3gr87Md9FxR4+MLZeZ2iHx+nwfFZkcAPhc1Ll+nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742715; c=relaxed/simple;
	bh=qQ7Sc1IN0y1n+yXdxsGWCbcnjUEbXAMYGZJtVRdx5Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPuc9s24dt+4NfrHUi+GIllR3xa8DuKkTjfYtXCE13dZE8O/cQyz1rw4i6OKLLG+FKHUT7/ZgafwJWm5hJoQqRFwbqVGrk1xsBkZbAUAji/Cx/Ba7HsNrVQVIXazDouunHeYsBHkEbgV6Q3xZjLnYpokDpweoiBEYigCP1FHx6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=UOKv+LO3; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id B03717DCEC;
	Tue, 23 Jul 2024 14:51:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742705; bh=qQ7Sc1IN0y1n+yXdxsGWCbcnjUEbXAMYGZJtVRdx5Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2005/15]=20l2tp:=20don't=20set=20sk_user_data=20in=20tunnel=20s
	 ocket|Date:=20Tue,=2023=20Jul=202024=2014:51:33=20+0100|Message-Id
	 :=20<0b51d3a4611109b3749c1acb4f09ffa9fb45bc45.1721733730.git.jchap
	 man@katalix.com>|In-Reply-To:=20<cover.1721733730.git.jchapman@kat
	 alix.com>|References:=20<cover.1721733730.git.jchapman@katalix.com
	 >|MIME-Version:=201.0;
	b=UOKv+LO3fG7vLrnmQ8uoi4Af7c4MmZgY7BT3zl+wFWT/9Yjxh+QYUtTUO5Ue8Oosk
	 ZyX4XM/q4w50/GHMeTCYILtoIx9bUklG5tfzmKkxKGzWvmtrI7S/HBfHI+NqKLVk7n
	 /jfsBXrOwwmrB8cPvjeBrhr+H3SKcTXd4e04apZ3azaJekZ79KSkMYt+40aF+blFVb
	 5SGd/xyh7DZAjZnR7IDrArsJ5/PYtWMnahxPKNKOXYeiuz18Lo8dwIP2LglmnF2wjq
	 MM5/6CddOn7vNz3lUCfsci4OSPpjyaUh9CQ4N+fNt2As4vKjDAiIYqtsvPzrHkp77a
	 leJODvYyA43kA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 05/15] l2tp: don't set sk_user_data in tunnel socket
Date: Tue, 23 Jul 2024 14:51:33 +0100
Message-Id: <0b51d3a4611109b3749c1acb4f09ffa9fb45bc45.1721733730.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721733730.git.jchapman@katalix.com>
References: <cover.1721733730.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp no longer uses the tunnel socket's sk_user_data so drop the code
which sets it.

In l2tp_validate_socket use l2tp_sk_to_tunnel to check whether a given
socket is already attached to an l2tp tunnel since we can no longer
use non-null sk_user_data to indicate this.
---
 net/l2tp/l2tp_core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index c97cd0fd8514..59a171fa1a39 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1263,7 +1263,6 @@ static void l2tp_tunnel_destruct(struct sock *sk)
 	/* Remove hooks into tunnel socket */
 	write_lock_bh(&sk->sk_callback_lock);
 	sk->sk_destruct = tunnel->old_sk_destruct;
-	sk->sk_user_data = NULL;
 	write_unlock_bh(&sk->sk_callback_lock);
 
 	/* Call the original destructor */
@@ -1554,6 +1553,8 @@ EXPORT_SYMBOL_GPL(l2tp_tunnel_create);
 static int l2tp_validate_socket(const struct sock *sk, const struct net *net,
 				enum l2tp_encap_type encap)
 {
+	struct l2tp_tunnel *tunnel;
+
 	if (!net_eq(sock_net(sk), net))
 		return -EINVAL;
 
@@ -1567,8 +1568,11 @@ static int l2tp_validate_socket(const struct sock *sk, const struct net *net,
 	    (encap == L2TP_ENCAPTYPE_IP && sk->sk_protocol != IPPROTO_L2TP))
 		return -EPROTONOSUPPORT;
 
-	if (sk->sk_user_data)
+	tunnel = l2tp_sk_to_tunnel(sk);
+	if (tunnel) {
+		l2tp_tunnel_dec_refcount(tunnel);
 		return -EBUSY;
+	}
 
 	return 0;
 }
@@ -1607,12 +1611,10 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
 	ret = l2tp_validate_socket(sk, net, tunnel->encap);
 	if (ret < 0)
 		goto err_inval_sock;
-	rcu_assign_sk_user_data(sk, tunnel);
 	write_unlock_bh(&sk->sk_callback_lock);
 
 	if (tunnel->encap == L2TP_ENCAPTYPE_UDP) {
 		struct udp_tunnel_sock_cfg udp_cfg = {
-			.sk_user_data = tunnel,
 			.encap_type = UDP_ENCAP_L2TPINUDP,
 			.encap_rcv = l2tp_udp_encap_recv,
 			.encap_err_rcv = l2tp_udp_encap_err_recv,
-- 
2.34.1


