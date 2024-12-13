Return-Path: <netdev+bounces-151876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D65FB9F16DA
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FA718870CC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F201EC006;
	Fri, 13 Dec 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ski15LLs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B961EBFE8;
	Fri, 13 Dec 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119684; cv=none; b=st3Um6C0zVRx2KtXXfhz9s4qVoxTmRPgjzYDWjbgjKgSpuZOOIndHpAIhX/aX/UIKFBXp6YSKiB1y5m5d9y9zKZ1Cc1YW3o0G8I6ztwrWnPJzECiO2UbfbVlnA+g8SI9JNCWcuyYUliL/8KhvTkzdGsHaP9CKFCh6FDUfqlA6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119684; c=relaxed/simple;
	bh=XYimpMwHKzxu/xlRyqbufMgM2CAFOTSTeqqmj4NVsqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z94z3fsIg0vLA/12UPpkmcgdAK96T8BBAv/GyYbdRnCZqe0ui7FUnbw/eyaM0+6Bx74ru8NpSFA7MEy3djXTbA1J7MPiiCFdz+PqQ25vB47fV1uZQgZ+Rb6Q2zVU3FdKji1zuNIBZhI3TzxJgiBvvLHRjbUu/rJjSL+7f69eaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ski15LLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CEFC4CED0;
	Fri, 13 Dec 2024 19:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734119684;
	bh=XYimpMwHKzxu/xlRyqbufMgM2CAFOTSTeqqmj4NVsqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ski15LLs0Pp9/dP7BTTLlJAjOTCJO7z1R4Re1iiT8vcwvLhUydK2rd5CLr5SzTxfm
	 0AnmP5EeLYZKclgu2buyVasswuhUtbNXXB8Uhjj8AtQNnj8/TGld/4oajtqav8rVfH
	 TeEbF1xdrbXGu2G7hOhWPBWHR249sDaU9mRNQErZg/3eUmtzTg7UPde7zpb0Y9r3RA
	 95BjfTKmFT/E4rpmT+7XOZBmJfB5tP91FD/iRIdfjG33lwrOzDh2BIgKUmVt0QnEEz
	 JiU0WDcA3yvkHzs629MVrWBc8wNGwJycbOqthfO18fF+T1tZ7V7a/cX3WXojBLTmD3
	 hocutpDJhLabg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Dec 2024 20:52:57 +0100
Subject: [PATCH net-next 6/7] mptcp: change local addr type of
 subflow_destroy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-net-next-mptcp-pm-misc-cleanup-v1-6-ddb6d00109a8@kernel.org>
References: <20241213-net-next-mptcp-pm-misc-cleanup-v1-0-ddb6d00109a8@kernel.org>
In-Reply-To: <20241213-net-next-mptcp-pm-misc-cleanup-v1-0-ddb6d00109a8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3618; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WZc11LXDW5RCot2xKVUu7oZMqukne6n1CK2wcrRNuwI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnXJDxIptG9MwD7PcbPa9+zn5Y7r5kXcWNzhr1l
 XNmiYXFdiWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ1yQ8QAKCRD2t4JPQmmg
 cwgJD/41Qmz2tP7ZR8UAOCSIgpJlktZWWxuKDqQ+P7ae6pQO9Mz3ndWT5x4Rf1+tXZB6nFeoarf
 sP3CXhhxkJ6lj4Utvo4sixTcai6EE371cNTwmmi2S2QIfwtxk5JtgzmTEels6V5wvuKpf4LexGa
 PtEDCc5LyXnMMQ8EV69XlomHZ1sKS2EbsPfBifeliS0azqM7a4czkmp9O6/nEzWpmCMbvnE0DMn
 oDTkVo8/wVAMK1qkph38BrhQUxUzS+Dxi6S6KqAtTdtqCX6JdRZI5Tz3rcSbM7IOz+X4yTIUCBt
 WPTqu/PrvqAsNbQLf4icfytzh1FTX80602jx8raKWIH1SAoQx0ujxSDqkPLsc+L205/xxYbL4wh
 NFt8Z4/6MCA5IiOAu5qLYpc6XZPc669gXbHMk2BCtxN4+iA2uXwmBfJniIQe3k9+ClLh/rbdof2
 q+XdHrDqQnRBskaOnXrVXW+2Xif92bfeU2u//LjfTI6XUJmLNtINQiQYJxhYHdT3i8Ue+W3wjBQ
 7D3m5K2EKw7ou31J9mvNSy+oEzP9GTE2jUx+sAVxvpCFuURvJGsZhSGjEi7IFvx4UoXnHIA0sOW
 rbX8w9lqcHODgcWddChheByPfZDixAaTMD3+z99fOY6GvqqXxRsqbHdRgvQv2GNuerrwAFxL28Y
 uefAMMTrRfb2S4g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Generally, in the path manager interfaces, the local address is defined as
an mptcp_pm_addr_entry type address, while the remote address is defined as
an mptcp_addr_info type one:

        (struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)

But subflow_destroy() interface uses two mptcp_addr_info type parameters.
This patch changes the first one to mptcp_pm_addr_entry type and use helper
mptcp_pm_parse_entry() to parse it instead of using mptcp_pm_parse_addr().

This patch doesn't change the behaviour of the code, just refactoring.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7689ea987be35aa9e9b87c7add108a08566e974f..1d5b77e0a722de74f25c9731659b2c938122c025 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -485,7 +485,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct mptcp_addr_info addr_l;
+	struct mptcp_pm_addr_entry addr_l;
 	struct mptcp_addr_info addr_r;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
@@ -502,7 +502,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	sk = (struct sock *)msk;
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &addr_l);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto destroy_err;
@@ -515,35 +515,34 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	}
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (addr_l.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
-		ipv6_addr_set_v4mapped(addr_l.addr.s_addr, &addr_l.addr6);
-		addr_l.family = AF_INET6;
+	if (addr_l.addr.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
+		ipv6_addr_set_v4mapped(addr_l.addr.addr.s_addr, &addr_l.addr.addr6);
+		addr_l.addr.family = AF_INET6;
 	}
-	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&addr_l.addr6)) {
-		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_r.addr6);
+	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&addr_l.addr.addr6)) {
+		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_l.addr.addr6);
 		addr_r.family = AF_INET6;
 	}
 #endif
-	if (addr_l.family != addr_r.family) {
+	if (addr_l.addr.family != addr_r.family) {
 		GENL_SET_ERR_MSG(info, "address families do not match");
 		err = -EINVAL;
 		goto destroy_err;
 	}
 
-	if (!addr_l.port || !addr_r.port) {
+	if (!addr_l.addr.port || !addr_r.port) {
 		GENL_SET_ERR_MSG(info, "missing local or remote port");
 		err = -EINVAL;
 		goto destroy_err;
 	}
 
 	lock_sock(sk);
-	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
+	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
 
 		spin_lock_bh(&msk->pm.lock);
-		mptcp_userspace_pm_delete_local_addr(msk, &entry);
+		mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
 		spin_unlock_bh(&msk->pm.lock);
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);

-- 
2.45.2


