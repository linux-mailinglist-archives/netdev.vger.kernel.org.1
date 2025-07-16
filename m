Return-Path: <netdev+bounces-207434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F540B0735A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 12:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535294E6FB8
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8072F49E5;
	Wed, 16 Jul 2025 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqzfetkJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353B72F4338;
	Wed, 16 Jul 2025 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661705; cv=none; b=dXtOD2aP/HOJGqm9+PQizDdvGX+PVpS0tglmF1ojACMHa+M8hATmhjqcYNOobW3L8wjmLCqgKiUSNm7S6HDvBr9+SkSyu0VFikkwr0AWllV2yUuIB8mEpNWThp6I1/02pE29IF0WUe8nlb7TrVCUlJ5LgPBDCkXFQfVsfg+cTjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661705; c=relaxed/simple;
	bh=d/K4zvv9MxpgoQvOcpDtuXY79iYulEVOCEgNeH9/IL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oOU/0cSeCq1hEOiiu67xZmwXl7MCtOm/gWZk6f10WChnNAboJAJKYsxZUd5dBPFHetAeTBtsKGx7Atg8cAopi2QHQa/KsMXABqY+O4oX5dFtEaCyyRRnw0uKiYp7OIeKzDlkicqYckI0QvntcjWeZ8vlim5l7BSB9JyZiowpxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqzfetkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB8CC4CEF7;
	Wed, 16 Jul 2025 10:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752661704;
	bh=d/K4zvv9MxpgoQvOcpDtuXY79iYulEVOCEgNeH9/IL4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rqzfetkJTFJApP9gcXoUSJLQjCn0WqXo64+wfDuwHpV1TOHOvVS7W4kiyxWj0cTBj
	 xOLYSoWz8jEP7oLYAQeJCgm4ld3ZFhbfZW/IdXkMKbNlyq2VFmDN6wr5U0z/VHN6vi
	 MU6HuPglqsrejH4kdku55sEJx6g5LMRl8vMxqWvoqMcxwQo962neMggCFeaaZ1WRQ/
	 ZLcYPsEyxCB0Ht7HC3PdCt6hDVWoPPUs6WgWBmQKWHEXU0OjI6dLBHJ+18x99t6ZUu
	 1iBt7uR56aEeiW3CtE1dWkwbWaf+/WcQtyuWsk9hxUvI7+AEwAy2nE4lcoau6Wdd3p
	 41aaIcdnKSIug==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 16 Jul 2025 12:28:04 +0200
Subject: [PATCH net-next 2/4] tcp: add tcp_sock_set_maxseg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-net-next-mptcp-tcp_maxseg-v1-2-548d3a5666f6@kernel.org>
References: <20250716-net-next-mptcp-tcp_maxseg-v1-0-548d3a5666f6@kernel.org>
In-Reply-To: <20250716-net-next-mptcp-tcp_maxseg-v1-0-548d3a5666f6@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2283; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8TcURbsq0AerY3ivfODQZ8O8rffsXv6kU9jfm8HF060=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLK6/bpFv13TJWLa/nzkF1Qb8G7cn6VlJOynyaqvnI7P
 VPFpMepo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCL6fxkZrrkzpArN2/fMzpWt
 RDXS7OfveJfrMWp/F6/erdT6JkX7DiPD40XVl8/o6W46ZL4/9Z6AqcSchvxVN4OcDAXNla4umvG
 ZAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a helper tcp_sock_set_maxseg() to directly set the TCP_MAXSEG
sockopt from kernel space.

This new helper will be used in the following patch from MPTCP.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/linux/tcp.h |  1 +
 net/ipv4/tcp.c      | 23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 1a5737b3753d06165bc71e257a261bcd7a0085ce..57e478bfaef20369f5dba1cff540e52c9302ebf4 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -621,6 +621,7 @@ void tcp_sock_set_nodelay(struct sock *sk);
 void tcp_sock_set_quickack(struct sock *sk, int val);
 int tcp_sock_set_syncnt(struct sock *sk, int val);
 int tcp_sock_set_user_timeout(struct sock *sk, int val);
+int tcp_sock_set_maxseg(struct sock *sk, int val);
 
 static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 31149a0ac849192b46c67dd569efeeeb0a041a0b..c9cdc4e99c4f11a75471b8895b9c52ad8da3a7ff 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3751,6 +3751,19 @@ int tcp_set_window_clamp(struct sock *sk, int val)
 	return 0;
 }
 
+int tcp_sock_set_maxseg(struct sock *sk, int val)
+{
+	/* Values greater than interface MTU won't take effect. However
+	 * at the point when this call is done we typically don't yet
+	 * know which interface is going to be used
+	 */
+	if (val && (val < TCP_MIN_MSS || val > MAX_TCP_WINDOW))
+		return -EINVAL;
+
+	tcp_sk(sk)->rx_opt.user_mss = val;
+	return 0;
+}
+
 /*
  *	Socket option code for TCP.
  */
@@ -3883,15 +3896,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	switch (optname) {
 	case TCP_MAXSEG:
-		/* Values greater than interface MTU won't take effect. However
-		 * at the point when this call is done we typically don't yet
-		 * know which interface is going to be used
-		 */
-		if (val && (val < TCP_MIN_MSS || val > MAX_TCP_WINDOW)) {
-			err = -EINVAL;
-			break;
-		}
-		tp->rx_opt.user_mss = val;
+		tcp_sock_set_maxseg(sk, val);
 		break;
 
 	case TCP_NODELAY:

-- 
2.48.1


