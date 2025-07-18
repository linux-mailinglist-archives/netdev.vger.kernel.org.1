Return-Path: <netdev+bounces-208262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E40AB0ABF2
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5F8AA2B22
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 22:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC52F224B04;
	Fri, 18 Jul 2025 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uobIUb0+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F637224AF7;
	Fri, 18 Jul 2025 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752876450; cv=none; b=Lbw3KpDjKnZW0JfrLQcsgUAhMyzJtL57+bKIo4XCzJxR9NGuK/t1WtzI3ldjnomkMz8XM4O90hgTtyG6njByj6bOZ8RhDhpbpqa3vcEQDBU1O5Ao3qXNIF0VFoNRtK6UlsrSa4pCNmCbc7lQScomE/xoT1NkgGZH2UUxsr+4f6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752876450; c=relaxed/simple;
	bh=7SSiioxiLII3ysPv2lQU8H4/tcSwpZwpPrA2dwJQOo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AzfDbknP7JOhjh7YfzOXQSUTitHicjQwYGON+FUkQGuEO/977+RBfYV9OlFxqH7iuzU6RTEdPyoxiUGV4bnOBKJ14KkW1t+feN3dIwBG8418gX5906Ih8Qs+cIiEsnh3zgiRSkWp2nsDVed0lCqTMMCsdRW6ZISPw6AjVEPLB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uobIUb0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B13C4CEF1;
	Fri, 18 Jul 2025 22:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752876450;
	bh=7SSiioxiLII3ysPv2lQU8H4/tcSwpZwpPrA2dwJQOo4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uobIUb0+YbtLQs+1v53pxDykuTx0ov5UeHN7xcaIlhMOOqae/DhlW1LnEjal5YFWM
	 S0QhPRTrErImAVqobraYb/vaExWZBGcUtgdEzWRmT9rtZoWap9uYpOOKlb6qVo2rg2
	 zMebLgwV+Zwb9FAtEgBp6O801Y/WXWk0CEWH+lJGV6NQfkdCsF1XB/YOuFIm6MG40l
	 PG3MgaWl9YAZ9x0t8n/D0mnMUroCh7VsmfTTvVMU/cW5RxTNlmyiK8hzei4fRYIYtI
	 QNlQGL0pHrbfhZE4pLUgJE9XBiX+cbkBD+oeBs9fAOy4v7l2/lXsg/AlfBRhDUEh8M
	 p9f/NgWbxjCcw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Jul 2025 00:06:58 +0200
Subject: [PATCH net-next v2 3/4] mptcp: add TCP_MAXSEG sockopt support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-net-next-mptcp-tcp_maxseg-v2-3-8c910fbc5307@kernel.org>
References: <20250719-net-next-mptcp-tcp_maxseg-v2-0-8c910fbc5307@kernel.org>
In-Reply-To: <20250719-net-next-mptcp-tcp_maxseg-v2-0-8c910fbc5307@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3663; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+DEK5/ZH1GKJo4HP82FajrZLT3Z02xFfmM9jAyFCTh0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKqjk65qOngXGReEPZTbm7CWjNFv9imdzx9nx5tbNBnf
 DbvHKNJRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERsaxn+6fzZfsJ1h8T7rEDn
 p6KnJIzezJ5meN3yQI/0naPOLa3MxxgZvtqUP4ry5kv+dGH33Wxzw4CW86UGG/nfz1xS26jc/OU
 8OwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The TCP_MAXSEG socket option is currently not supported by MPTCP, mainly
because it has never been requested before. But there are still valid
use-cases, e.g. with HAProxy.

This patch adds its support in MPTCP by propagating the value to all
subflows. The get part looks at the value on the first subflow, to be as
closed as possible to TCP. Only one value can be returned for the cached
MSS, so this can come only from one subflow.

Similar to mptcp_setsockopt_first_sf_only(), a generic helper
mptcp_setsockopt_all_subflows() is added to set sockopt for each
subflows of the mptcp socket.

Add a new member for struct mptcp_sock to store the TCP_MAXSEG value,
and return this value in getsockopt.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/515
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
- v2: make mptcp_setsockopt_all_sf() returns only once.
---
 net/mptcp/protocol.h |  1 +
 net/mptcp/sockopt.c  | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6ec245fd2778ef30e0dc84d309d27ecd1f62e0d1..1a32edf6f34364eedd5d077eae7a82a7db8c3a9e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -326,6 +326,7 @@ struct mptcp_sock {
 	int		keepalive_cnt;
 	int		keepalive_idle;
 	int		keepalive_intvl;
+	int		maxseg;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index afa54fba51e215bc2efb21f16ed7d0a0fb120972..2c267aff95bec90d341de9f9e136b9d2df9b8e13 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -798,6 +798,23 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	return ret;
 }
 
+static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
+				   int optname, sockptr_t optval,
+				   unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	int ret = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -859,6 +876,11 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 						 &msk->keepalive_cnt,
 						 val);
 		break;
+	case TCP_MAXSEG:
+		msk->maxseg = val;
+		ret = mptcp_setsockopt_all_sf(msk, SOL_TCP, optname, optval,
+					      optlen);
+		break;
 	default:
 		ret = -ENOPROTOOPT;
 	}
@@ -1406,6 +1428,9 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	case TCP_IS_MPTCP:
 		return mptcp_put_int_option(msk, optval, optlen, 1);
+	case TCP_MAXSEG:
+		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
+						      optval, optlen);
 	}
 	return -EOPNOTSUPP;
 }
@@ -1552,6 +1577,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
 	tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
 	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
+	tcp_sock_set_maxseg(ssk, msk->maxseg);
 
 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));

-- 
2.50.0


