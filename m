Return-Path: <netdev+bounces-144539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E319C7B91
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208841F22B08
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31BD2076A9;
	Wed, 13 Nov 2024 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz+Mm7r4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985A20604A;
	Wed, 13 Nov 2024 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523628; cv=none; b=Lx1p5mLT6qt0Fr2nxrOX7UL5Mm0pvznh6DkNujI7Swuv6sJ1jQg6NWEBg9bTj9buPYb2AWw3xzVBYhi2B0NGx1EkESvtIAYEpUuPGBVqSbJ9XIJ0KfT5ExAa1g/VFa7bgy0HThSpFfm8pwVzFEQxg124M+cjhrErRcQoS+3z+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523628; c=relaxed/simple;
	bh=XH0qkdNR0QBB6FiNGo6STrZOuWlMPbxkb9Gv9AHIz3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+NyYQPrO1K3UQCSRpv9PNjX6bbDl32wXbT/45zqnOHdRl99YObhQj2JznLO7Fa9ySc5LFnHDeaylTVDVlJO7i+xn4MhzhYt1vwomAI2EfmY8ceDPbrLIIDj0wnyT+56PhW70vw+UpkSJqiA137mEg0HjJHE1D03yuKxKDRKul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sz+Mm7r4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB4A1C4CEDE;
	Wed, 13 Nov 2024 18:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731523627;
	bh=XH0qkdNR0QBB6FiNGo6STrZOuWlMPbxkb9Gv9AHIz3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sz+Mm7r4FKXnOvTkArJdqAiI5Q46EjdqQtuww37JQzx6fhElIN2C82v3uZ2bn/zdY
	 fyFzWlgBR8twAQLZMZRX6YLOPb0xBIzQ2GtE2wNZ6KZgtdQK/VRXBPbbbfVqoI814F
	 HJcKOi8Lep1QK4sx7eeNyumrrc7znB0q38eY17kGL3LzmVyJGoa2nMeQPx/Danf5mf
	 mhF5YIY7AvI8OxsVCMMukT/gel0NbZ85g801KJq2Up2ztK6J7Qcz9N6EU9CRcdM+0H
	 WVzWFW6cbGApbYQR2AditUKJ7DcSBWsh1uIJzhIuU+vTIwJAhrj/LO9VyG65JBw5hk
	 sT0Uowl1ABjpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4F4D637AB;
	Wed, 13 Nov 2024 18:47:07 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 13 Nov 2024 18:46:43 +0000
Subject: [PATCH net v2 4/5] net/diag: Always pre-allocate tcp_ulp info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-tcp-md5-diag-prep-v2-4-00a2a7feb1fa@gmail.com>
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
In-Reply-To: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Davide Caratti <dcaratti@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731523626; l=6947;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=qfevk1ng2p0MU67TYs7ChEKHqMGys1hoYMjl1SqfztY=;
 b=R0xCpHQCzeM/K00aJqY6yGIdN38COcrV56h3NQO+Vnl0+o1/tgCMI0kdztDExYjqPbKT5eNUl
 GPQNw98NBvxBhqJhHhpzMulRNC46j+M+nn58RE/fGs4+74YKHnRTm5X
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Currently there is a theoretical race between netlink one-socket dump
and allocating icsk->icsk_ulp_ops.

Simplify the expectations by always allocating maximum tcp_ulp-info.
With the previous patch the typical netlink message allocation was
decreased for kernel replies on requests without idiag_ext flags,
so let's use it.

Fixes: 61723b393292 ("tcp: ulp: add functions to dump ulp-specific information")
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 include/net/tcp.h    |  1 -
 net/ipv4/inet_diag.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_diag.c  | 13 -------------
 net/mptcp/diag.c     | 20 --------------------
 net/tls/tls_main.c   | 17 -----------------
 5 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d1948d357dade0842777265d3397842919f9eee0..757711aa5337ae7e6abee62d303eb66d37082e19 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2568,7 +2568,6 @@ struct tcp_ulp_ops {
 	void (*release)(struct sock *sk);
 	/* diagnostic */
 	int (*get_info)(struct sock *sk, struct sk_buff *skb);
-	size_t (*get_info_size)(const struct sock *sk);
 	/* clone ulp */
 	void (*clone)(const struct request_sock *req, struct sock *newsk,
 		      const gfp_t priority);
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 2dd173a73bd1e2657957e5e4ecb70401cc85dfda..ac6d9ee8e2cc21fc97d6018547d33b540712e780 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -97,6 +97,55 @@ void inet_diag_msg_common_fill(struct inet_diag_msg *r, struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(inet_diag_msg_common_fill);
 
+static size_t tls_get_info_size(void)
+{
+	size_t size = 0;
+
+#ifdef CONFIG_TLS
+	size += nla_total_size(0) +		/* INET_ULP_INFO_TLS */
+		nla_total_size(sizeof(u16)) +	/* TLS_INFO_VERSION */
+		nla_total_size(sizeof(u16)) +	/* TLS_INFO_CIPHER */
+		nla_total_size(sizeof(u16)) +	/* TLS_INFO_RXCONF */
+		nla_total_size(sizeof(u16)) +	/* TLS_INFO_TXCONF */
+		nla_total_size(0) +		/* TLS_INFO_ZC_RO_TX */
+		nla_total_size(0) +		/* TLS_INFO_RX_NO_PAD */
+		0;
+#endif
+
+	return size;
+}
+
+static size_t subflow_get_info_size(void)
+{
+	size_t size = 0;
+
+#ifdef CONFIG_MPTCP
+	size += nla_total_size(0) +		/* INET_ULP_INFO_MPTCP */
+		nla_total_size(4) +		/* MPTCP_SUBFLOW_ATTR_TOKEN_REM */
+		nla_total_size(4) +		/* MPTCP_SUBFLOW_ATTR_TOKEN_LOC */
+		nla_total_size(4) +		/* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
+		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
+		nla_total_size(4) +		/* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
+		nla_total_size(4) +		/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
+		nla_total_size(2) +		/* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
+		nla_total_size(4) +		/* MPTCP_SUBFLOW_ATTR_FLAGS */
+		nla_total_size(1) +		/* MPTCP_SUBFLOW_ATTR_ID_REM */
+		nla_total_size(1) +		/* MPTCP_SUBFLOW_ATTR_ID_LOC */
+		0;
+#endif
+
+	return size;
+}
+
+static size_t tcp_ulp_ops_size(void)
+{
+	size_t size = max(tls_get_info_size(), subflow_get_info_size());
+
+	return size +
+	       nla_total_size(0) +			/* INET_DIAG_ULP_INFO */
+	       nla_total_size(TCP_ULP_NAME_MAX);	/* INET_ULP_INFO_NAME */
+}
+
 static size_t inet_sk_attr_size(struct sock *sk,
 				const struct inet_diag_req_v2 *req,
 				bool net_admin)
@@ -115,6 +164,7 @@ static size_t inet_sk_attr_size(struct sock *sk,
 	ret += nla_total_size(sizeof(struct tcp_info))
 	     + nla_total_size(sizeof(struct inet_diag_msg))
 	     + inet_diag_msg_attrs_size()
+	     + tcp_ulp_ops_size()
 	     + 64;
 
 	if (ext & (1 << (INET_DIAG_MEMINFO - 1)))
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index d752dc5de3536303aeb075c10fbdc2c9fc417cd5..a60968ceb1553b2d219290b84a36b05a2d1fa8d2 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -154,7 +154,6 @@ static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
 
 static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
 {
-	struct inet_connection_sock *icsk = inet_csk(sk);
 	size_t size = 0;
 
 #ifdef CONFIG_TCP_MD5SIG
@@ -174,18 +173,6 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
 				       sizeof(struct tcp_diag_md5sig));
 	}
 #endif
-
-	if (net_admin && sk_fullsock(sk)) {
-		const struct tcp_ulp_ops *ulp_ops;
-
-		ulp_ops = icsk->icsk_ulp_ops;
-		if (ulp_ops) {
-			size += nla_total_size(0) +
-				nla_total_size(TCP_ULP_NAME_MAX);
-			if (ulp_ops->get_info_size)
-				size += ulp_ops->get_info_size(sk);
-		}
-	}
 	return size;
 }
 
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 2d3efb405437d85c0bca70d7a92ca3a7363365e1..8b36867e4ddd5f45cebcf60e9093a061d5208756 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -84,27 +84,7 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
-static size_t subflow_get_info_size(const struct sock *sk)
-{
-	size_t size = 0;
-
-	size += nla_total_size(0) +	/* INET_ULP_INFO_MPTCP */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_TOKEN_REM */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_TOKEN_LOC */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
-		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
-		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_FLAGS */
-		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_REM */
-		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_LOC */
-		0;
-	return size;
-}
-
 void mptcp_diag_subflow_init(struct tcp_ulp_ops *ops)
 {
 	ops->get_info = subflow_get_info;
-	ops->get_info_size = subflow_get_info_size;
 }
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 6b4b9f2749a6fd6de495940c5cb3f2154a5a451e..f3491c4e942e08dc882cb81eef071203384b2b37 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1072,22 +1072,6 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
-static size_t tls_get_info_size(const struct sock *sk)
-{
-	size_t size = 0;
-
-	size += nla_total_size(0) +		/* INET_ULP_INFO_TLS */
-		nla_total_size(sizeof(u16)) +	/* TLS_INFO_VERSION */
-		nla_total_size(sizeof(u16)) +	/* TLS_INFO_CIPHER */
-		nla_total_size(sizeof(u16)) +	/* TLS_INFO_RXCONF */
-		nla_total_size(sizeof(u16)) +	/* TLS_INFO_TXCONF */
-		nla_total_size(0) +		/* TLS_INFO_ZC_RO_TX */
-		nla_total_size(0) +		/* TLS_INFO_RX_NO_PAD */
-		0;
-
-	return size;
-}
-
 static int __net_init tls_init_net(struct net *net)
 {
 	int err;
@@ -1123,7 +1107,6 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
 	.init			= tls_init,
 	.update			= tls_update,
 	.get_info		= tls_get_info,
-	.get_info_size		= tls_get_info_size,
 };
 
 static int __init tls_register(void)

-- 
2.42.2



