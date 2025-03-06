Return-Path: <netdev+bounces-172432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA2CA54956
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1571189392E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8D420C46B;
	Thu,  6 Mar 2025 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZPNKcRM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75CB20C03B;
	Thu,  6 Mar 2025 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260640; cv=none; b=lb4Nt5KQHI3Swha1wVENcYPfNgxZX6F3Qx85vJ/1kQxamCyGZ6jFGHgzijPONUt/it4z2HHENSHn7bHC41SfDzXiG5Jov3Rmnjz/uvyzTUcf9yHgRrCKmvWG2JMjyvNjvLmPIrL6uVobOOjT6zI8Z8hEgRESaDEvi9uw8n53Z0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260640; c=relaxed/simple;
	bh=yhMS1w6Qo37ABqlbxVoPYaQ/5By/4/GAkmJVfu0AuF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dFReA4jVNemWrXN6gWBLXArpyyAlLY4veHRVkQfuuvalg/4gbI9QRitlhdTrPbgQ2nuXKKJZ/DkaijtMilp812u7Toj5OvatV0SLforxqxURJS+oWzuNdn6cL4aEMqyU8Tvq7VFV/h2Qfxj/expBhjFHkD0ujNhnRDeCCAzqxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZPNKcRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A7BC4CEF5;
	Thu,  6 Mar 2025 11:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741260640;
	bh=yhMS1w6Qo37ABqlbxVoPYaQ/5By/4/GAkmJVfu0AuF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XZPNKcRMWlRtft0Ctt6/POlNyzFhtDlnk5Yt+JrkBWWIRKAoab1M0vB3baWb3NDEp
	 cH4juvkKatXcL9oW5+mN9GGMdzjxmOYbr+u2uUeEgI6NuVKfe7im6GxdI2DCDgRL6u
	 bgfsWcy8ij+XFATJy8At1uoKI8TAhpZm0m/BXXlb0rmV7wc4khrMAwtdLFZ+w2rr4V
	 f3+BBDeYwodnmWBiN063t4bC4xPAAoYw2Q59aKh8hBRc5MFFVWCZili323kkXW+MRn
	 5wyO9wFWL/VoOGRDke50n93hlwWOAGvaMP2FMBB3Bgv7bEISpcDZIwFrVyfggtmhXN
	 qIEM2yxoAZv0w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 06 Mar 2025 12:29:28 +0100
Subject: [PATCH net-next 2/2] tcp: ulp: diag: more info without
 CAP_NET_ADMIN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-net-next-tcp-ulp-diag-net-admin-v1-2-06afdd860fc9@kernel.org>
References: <20250306-net-next-tcp-ulp-diag-net-admin-v1-0-06afdd860fc9@kernel.org>
In-Reply-To: <20250306-net-next-tcp-ulp-diag-net-admin-v1-0-06afdd860fc9@kernel.org>
To: mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7443; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yhMS1w6Qo37ABqlbxVoPYaQ/5By/4/GAkmJVfu0AuF8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnyYdUEEYv1cOiGQDt6Iv/zXtQ8ZTlE3GmEM/wx
 cLVfzOu26iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8mHVAAKCRD2t4JPQmmg
 c61lEACErGicQcawp+cHJ6ylYIZceszFnKXWN4dH4s0y0xYDi7n9OUMU40ZauZ6EnIGK9EAw69U
 CB2bKdmk6VEwYWxkueJRaoXSfccyZ8Gap0tuT/ShfBdZ7TyKVtdCD2XxSo8RImplMqHwieiDIXz
 ZvDvA9QHFDZB4HladyLPqD3S1juoqAik4ORC2lvYZGVoc0EaxaERCJojgANMg+BJFMKg6LGOzA9
 OjAHWUAB7bAy/ToT7WYhjMXWyFbxv7yCwINg6Hfcbb9IMWVkvQ7+F7P10YkKyjaMb5ZpsaLKVR1
 419z5nYqbC/1Qhucwyn37Yd/XEPdqMliDb8WC8em+Ihk/bq96Et3zPzen0ZqvW9qw7Ok/ZAqM5+
 JSiA+h7/3+vzzzPUbb92hELS/VGjS/zqO+1/IL0u4klqAh2/php5TmHoamlrJmmWaSjl+CukF/F
 a0tRoRsXfruXc7oO9wa+7fb3MBC8oXeINz05CVJMaPnD7sR535kLUmwS+PBnWRIeFvuJ2VjPnx4
 nOEnC9h2R72EX8fpYnMJG5SWcr4wOQWujb3pRO1ZtF47jRuENa4vPezUlhFSPVP5w8FMmERkEaD
 A1tv0kdYwAVVpNSjeDAeDscJFIIEW/v1kBrtFuE/izaDcH3SF8ddQeovpPffD171lz/JDvTxYy9
 A4FalpZMzdfG5UA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When introduced in commit 61723b393292 ("tcp: ulp: add functions to dump
ulp-specific information"), the whole ULP diag info has been exported
only if the requester had CAP_NET_ADMIN.

It looks like not everything is sensitive, and some info can be exported
to all users in order to ease the debugging from the userspace side
without requiring additional capabilities. Each layer should then decide
what can be exposed to everybody. The 'net_admin' boolean is then passed
to the different layers.

On kTLS side, it looks like there is nothing sensitive there: version,
cipher type, tx/rx user config type, plus some flags. So, only some
metadata about the configuration, no cryptographic info like keys, etc.
Then, everything can be exported to all users.

On MPTCP side, that's different. The MPTCP-related sequence numbers per
subflow should certainly not be exposed to everybody. For example, the
DSS mapping and ssn_offset would give all users on the system access to
narrow ranges of values for the subflow TCP sequence numbers and
MPTCP-level DSNs, and then ease packet injection. The TCP diag interface
doesn't expose the TCP sequence numbers for TCP sockets, so best to do
the same here. The rest -- token, IDs, flags -- can be exported to
everybody.

Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/tcp.h   |  4 ++--
 net/ipv4/tcp_diag.c |  8 ++++----
 net/mptcp/diag.c    | 42 ++++++++++++++++++++++++++----------------
 net/tls/tls_main.c  |  4 ++--
 4 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a9bc959fb102fc6697b4a664b3773b47b3309f13..7207c52b1fc9ce3cd9cf2a8580310d0e629f82d6 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2598,8 +2598,8 @@ struct tcp_ulp_ops {
 	/* cleanup ulp */
 	void (*release)(struct sock *sk);
 	/* diagnostic */
-	int (*get_info)(struct sock *sk, struct sk_buff *skb);
-	size_t (*get_info_size)(const struct sock *sk);
+	int (*get_info)(struct sock *sk, struct sk_buff *skb, bool net_admin);
+	size_t (*get_info_size)(const struct sock *sk, bool net_admin);
 	/* clone ulp */
 	void (*clone)(const struct request_sock *req, struct sock *newsk,
 		      const gfp_t priority);
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index d8bba37dbffd8c6cc7fab2328a88b6ce6ea3e9f4..45e174b8cd22173b6b8eeffe71df334c45498b15 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -96,8 +96,8 @@ static int tcp_diag_put_ulp(struct sk_buff *skb, struct sock *sk,
 	if (err)
 		goto nla_failure;
 
-	if (net_admin && ulp_ops->get_info)
-		err = ulp_ops->get_info(sk, skb);
+	if (ulp_ops->get_info)
+		err = ulp_ops->get_info(sk, skb, net_admin);
 	if (err)
 		goto nla_failure;
 
@@ -170,8 +170,8 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
 		if (ulp_ops) {
 			size += nla_total_size(0) +
 				nla_total_size(TCP_ULP_NAME_MAX);
-			if (net_admin && ulp_ops->get_info_size)
-				size += ulp_ops->get_info_size(sk);
+			if (ulp_ops->get_info_size)
+				size += ulp_ops->get_info_size(sk, net_admin);
 		}
 	}
 	return size;
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 02205f7994d752cc505991efdf7aa0bbbfd830db..70cf9ebce8338bde3b0bb10fc8620905b15f5190 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -12,7 +12,7 @@
 #include <net/netlink.h>
 #include "protocol.h"
 
-static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
+static int subflow_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
 {
 	struct mptcp_subflow_context *sf;
 	struct nlattr *start;
@@ -56,15 +56,6 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 
 	if (nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_TOKEN_REM, sf->remote_token) ||
 	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_TOKEN_LOC, sf->token) ||
-	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
-			sf->rel_write_seq) ||
-	    nla_put_u64_64bit(skb, MPTCP_SUBFLOW_ATTR_MAP_SEQ, sf->map_seq,
-			      MPTCP_SUBFLOW_ATTR_PAD) ||
-	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
-			sf->map_subflow_seq) ||
-	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_SSN_OFFSET, sf->ssn_offset) ||
-	    nla_put_u16(skb, MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
-			sf->map_data_len) ||
 	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_FLAGS, flags) ||
 	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_REM, sf->remote_id) ||
 	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_LOC, subflow_get_local_id(sf))) {
@@ -72,6 +63,21 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 		goto nla_failure;
 	}
 
+	/* Only export seq related counters to user with CAP_NET_ADMIN */
+	if (net_admin &&
+	    (nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
+			 sf->rel_write_seq) ||
+	     nla_put_u64_64bit(skb, MPTCP_SUBFLOW_ATTR_MAP_SEQ, sf->map_seq,
+			       MPTCP_SUBFLOW_ATTR_PAD) ||
+	     nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
+			 sf->map_subflow_seq) ||
+	     nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_SSN_OFFSET, sf->ssn_offset) ||
+	     nla_put_u16(skb, MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
+			 sf->map_data_len))) {
+		err = -EMSGSIZE;
+		goto nla_failure;
+	}
+
 	rcu_read_unlock();
 	unlock_sock_fast(sk, slow);
 	nla_nest_end(skb, start);
@@ -84,22 +90,26 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
-static size_t subflow_get_info_size(const struct sock *sk)
+static size_t subflow_get_info_size(const struct sock *sk, bool net_admin)
 {
 	size_t size = 0;
 
 	size += nla_total_size(0) +	/* INET_ULP_INFO_MPTCP */
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_TOKEN_REM */
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_TOKEN_LOC */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
-		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
-		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_FLAGS */
 		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_REM */
 		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_LOC */
 		0;
+
+	if (net_admin)
+		size += nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
+			nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
+			nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
+			nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
+			nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
+			0;
+
 	return size;
 }
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 99ca4465f70216c5a44e4ca7477df0e93df6b76d..cb86b0bf9a53e1ff060d8e69eddbd6acfbee5194 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1057,7 +1057,7 @@ static u16 tls_user_config(struct tls_context *ctx, bool tx)
 	return 0;
 }
 
-static int tls_get_info(struct sock *sk, struct sk_buff *skb)
+static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
 {
 	u16 version, cipher_type;
 	struct tls_context *ctx;
@@ -1115,7 +1115,7 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
-static size_t tls_get_info_size(const struct sock *sk)
+static size_t tls_get_info_size(const struct sock *sk, bool net_admin)
 {
 	size_t size = 0;
 

-- 
2.47.1


