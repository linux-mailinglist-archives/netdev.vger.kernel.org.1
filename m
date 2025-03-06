Return-Path: <netdev+bounces-172431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AD4A54943
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA2A1893D64
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E750C20B1E7;
	Thu,  6 Mar 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzbuKTRx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70FF20AF7A;
	Thu,  6 Mar 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260636; cv=none; b=ZjRyERBLHux+uAr5Ao64HXLWgWVI6K+tkn5rgdsYTJU1mojejd0LbADywi0U9Qod42yijyvNs9Jlpww8xF/lAPh9Fl3i9SrwR2Mqr7PfQe2wjPGK297+wAKewHRhHjlOMukQ2fWCdtvjkTWqak5ewLJMdy4bnyDNq8QAy9Nem7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260636; c=relaxed/simple;
	bh=NC/lGvDmAV8Ip3X0m8TXXBe5iESf8md8tcu6oLbzdYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHSvAcn21QW1UU+c+3pSRs0t1BI9//BhGlBz/SdPW3QAPwx5o5+7PA4NkFCcg07Xy/g1NVoLRmrHp2i8OcyhFxazrKMzQ1Z9Hc7eBo9LI/sQUzEYR8YmUoJZu2OTg2aSEZYCs482PDuw8NGb2ddn7KjKxDslKR1gIIk+0exUVeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzbuKTRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F8DC4CEE9;
	Thu,  6 Mar 2025 11:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741260636;
	bh=NC/lGvDmAV8Ip3X0m8TXXBe5iESf8md8tcu6oLbzdYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KzbuKTRxn68vc74atTqVpICAGSUtl+M4n3TC9lugy7RZv3NKNKHBI4v6WwcCWBlZI
	 jkMa6HMLP0b8L5UY6BkrqNdKT9COjLYpU/n9e7olnfciPuuu0fWN7qkWXy8+fSpxeI
	 v4XRkThVwEkTdd4mgM3uAvKQfjn4VILS1F8Bsqcb6MSv8Rl5JReI+rJRx/hwX1ULGX
	 7Y4fCcmgrwE8/a4VUUxDLt4bNWKFEo3t56k2nYOjhqOi3lVNyKEaUsl1/ENtFh40JC
	 I1OuEp2mUICcmlU37R3s5fH8NCMf6eMAyEQ71O0SDFPqBtwJzMComuqR2UByyUnhKm
	 qX3wjJ9mHShCg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 06 Mar 2025 12:29:27 +0100
Subject: [PATCH net-next 1/2] tcp: ulp: diag: always print the name if any
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-net-next-tcp-ulp-diag-net-admin-v1-1-06afdd860fc9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2536; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NC/lGvDmAV8Ip3X0m8TXXBe5iESf8md8tcu6oLbzdYg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnyYdU0x1HWhVpn2lpl9zrgoiDzZx/GhKqVSJFk
 jHhaZ3+AnWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8mHVAAKCRD2t4JPQmmg
 czNmD/wMIKMdV7Smuz5ijDckfsfZKG1lXjElZpOSbIXoted7yIFTjkAWnMLdIpPtZgGQ6UfyTlV
 OvN4gRLajSaJrsVLvkj1zLJxgOlbRbXhdwyMGKavQc4Yd9E7LSasaEI+eN7aLYzpXpVrZSk9T6i
 COiNzz+UBKdnBjZ2RyMV21tlvJ6EZWHpsO/+mUU5Hfy34xVI7Vlegm3ZmxiOvqykSVWQ1G7Wdn2
 atDQeAN2qYQaw02iEqRbz1/X5jZWncY8g19oxZ3e1TtMNErvQ6Cy46c1IBiqulZko9ENdLHjZvg
 aA7SVl57XWeOKkJUwN2lU3P/vJkdI0BpLfufk1vEqCcnshy9osqx6jd+g/Tcl2LiA91HRVlDEbA
 iI+YFz0nlu6S9E+Nl7qz7Oqk2J5IvxOIUl++FSHo7PVXBc8YHt934dGYl7HZD0s/ClVCMebLZNX
 6SBLtekIkzAXNSfCUHskAL/F40LPrBNNGG+RF/gY0tT/NZMFBkrhVAL/tGi+0Ao8sMduQb2ogNp
 pxMCgbrq5NK+RIS9OUD7aApNhmPoVzpX/kF/Vp0XfgHTHz3OoY/jucvHDLgal8BPQ0jGF0D7YMH
 X7U5h5PJSWOiJnILmSfG9R0x4xSwoaQCfDC88OszkQxfWRgCxNGRR4FJt85SiYyW0aFdqaHEgwp
 64tSqoIW29WXeHA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since its introduction in commit 61723b393292 ("tcp: ulp: add functions
to dump ulp-specific information"), the ULP diag info have been exported
only if the requester had CAP_NET_ADMIN.

At least the ULP name can be exported without CAP_NET_ADMIN. This will
already help identifying which layer is being used, e.g. which TCP
connections are in fact MPTCP subflow.

Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/ipv4/tcp_diag.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index f428ecf9120f2f596e1d67db2b2a0d0d0e211905..d8bba37dbffd8c6cc7fab2328a88b6ce6ea3e9f4 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -83,7 +83,7 @@ static int tcp_diag_put_md5sig(struct sk_buff *skb,
 #endif
 
 static int tcp_diag_put_ulp(struct sk_buff *skb, struct sock *sk,
-			    const struct tcp_ulp_ops *ulp_ops)
+			    const struct tcp_ulp_ops *ulp_ops, bool net_admin)
 {
 	struct nlattr *nest;
 	int err;
@@ -96,7 +96,7 @@ static int tcp_diag_put_ulp(struct sk_buff *skb, struct sock *sk,
 	if (err)
 		goto nla_failure;
 
-	if (ulp_ops->get_info)
+	if (net_admin && ulp_ops->get_info)
 		err = ulp_ops->get_info(sk, skb);
 	if (err)
 		goto nla_failure;
@@ -113,6 +113,7 @@ static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
 			    struct sk_buff *skb)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	const struct tcp_ulp_ops *ulp_ops;
 	int err = 0;
 
 #ifdef CONFIG_TCP_MD5SIG
@@ -129,15 +130,13 @@ static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
 	}
 #endif
 
-	if (net_admin) {
-		const struct tcp_ulp_ops *ulp_ops;
-
-		ulp_ops = icsk->icsk_ulp_ops;
-		if (ulp_ops)
-			err = tcp_diag_put_ulp(skb, sk, ulp_ops);
-		if (err)
+	ulp_ops = icsk->icsk_ulp_ops;
+	if (ulp_ops) {
+		err = tcp_diag_put_ulp(skb, sk, ulp_ops, net_admin);
+		if (err < 0)
 			return err;
 	}
+
 	return 0;
 }
 
@@ -164,14 +163,14 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
 	}
 #endif
 
-	if (net_admin && sk_fullsock(sk)) {
+	if (sk_fullsock(sk)) {
 		const struct tcp_ulp_ops *ulp_ops;
 
 		ulp_ops = icsk->icsk_ulp_ops;
 		if (ulp_ops) {
 			size += nla_total_size(0) +
 				nla_total_size(TCP_ULP_NAME_MAX);
-			if (ulp_ops->get_info_size)
+			if (net_admin && ulp_ops->get_info_size)
 				size += ulp_ops->get_info_size(sk);
 		}
 	}

-- 
2.47.1


