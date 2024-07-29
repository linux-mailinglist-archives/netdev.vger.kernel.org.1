Return-Path: <netdev+bounces-113702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B83793F9A2
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6C7B20FB7
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CF815CD7F;
	Mon, 29 Jul 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="yrw27ek1"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DF415A87C
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267499; cv=none; b=EFm4sn33CbjI5/WwgKDxJxAWFVSWvmNFNnRPB1IilHazFcfhNPEyKjKTIUD5RsSYvebFO9NpTa6i9oiXYNMmATGbynay26RHUhMb/1tt56zEd+wIjhXwZGIRrhCkUYksPKfCT/gaZ9O/wEi7HLEieUNMRmBl7ihOAZ2hr3mJlxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267499; c=relaxed/simple;
	bh=lDt9orHvUGdX7CcMCF4+I9gxWcVU6a7LDDMuvDMMK/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nd9Epy/FwpCPbosjTELRt8xqvF4Ztj3cKyS0MGxC3s/7IYBoc8hQePVhJugiWrgScX9C4Iq3/uhAFXuIW/Ib3OIyBnZWk7C+qKdHDf7gCmoH7qu8Z1tZlldmWnTy7FSRa2wp85wZqURta6oKbmmumfYJWLOdYV9e08wUNiFjuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=yrw27ek1; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6c24:bf58:f1fe:91c1])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 97F277DCD1;
	Mon, 29 Jul 2024 16:38:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722267495; bh=lDt9orHvUGdX7CcMCF4+I9gxWcVU6a7LDDMuvDMMK/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=2005/15]=20l2tp:=20don't=20set=20sk_user_data=20in=20tunne
	 l=20socket|Date:=20Mon,=2029=20Jul=202024=2016:38:04=20+0100|Messa
	 ge-Id:=20<9d5db3aeb2cac90f5f40d2cbf199a05837a50dd9.1722265212.git.
	 jchapman@katalix.com>|In-Reply-To:=20<cover.1722265212.git.jchapma
	 n@katalix.com>|References:=20<cover.1722265212.git.jchapman@katali
	 x.com>|MIME-Version:=201.0;
	b=yrw27ek1Msa8il0281SUgQ0tvEb+RUhvVkhXTBOoi29s9tPyzUKvL7FBG+WdbYrih
	 GsEfwGc05fFQ/vrs7+c78roiDAmK2MQPYBAtMdrXRSopihUbDmztmj0ntZuTQOmNVG
	 5PKsw+eCsDL31eI0qbSh8obgTNa2tbEdhDISJv39/O0CJKBM7zMy7Uz58UX/cygMeO
	 rOEepBfllfAvwM30ParT/SQQO4wMVrGPzCeBpNdYLulTegfPxIvu0kw5RQULpf99JP
	 vjgGXJ66ucAqhr8xhU6VGoupjoWTptg2WRpv+jbMrVvvC2KVDzHBjIiqrIiA7Wlewu
	 ni8eZWe0UfeEA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 05/15] l2tp: don't set sk_user_data in tunnel socket
Date: Mon, 29 Jul 2024 16:38:04 +0100
Message-Id: <9d5db3aeb2cac90f5f40d2cbf199a05837a50dd9.1722265212.git.jchapman@katalix.com>
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

l2tp no longer uses the tunnel socket's sk_user_data so drop the code
which sets it.

In l2tp_validate_socket use l2tp_sk_to_tunnel to check whether a given
socket is already attached to an l2tp tunnel since we can no longer
use non-null sk_user_data to indicate this.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
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


