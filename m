Return-Path: <netdev+bounces-151873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 982839F16D4
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA775163087
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2305194A65;
	Fri, 13 Dec 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhDEWliM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A674A1946B9;
	Fri, 13 Dec 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119676; cv=none; b=WwmOfgSucFm3izJRAqSDhtY29fn79FSgYRlJachQD8NzQIVS1WfEyRb7TtkCEbKZuu2Q75Dmav7KyctpUM1F9dQfKsVarYH6bGM1UIS7Qk0C3f7WEdjTfpHMD2JpG0jWdAe2KRSQGAXohPxHYXLJngB85YvLiJCilv1sDe8Sy7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119676; c=relaxed/simple;
	bh=FT2pYxMpVRHpQWvyHdsqFN9olabaHp1QF/cpNxwp+Ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EjolJNC3vmx5AZ5+pbLYfCh9fTpVan03u8GIj7YHWk2xYlPrLKvoRvVfKlhdiHB/LpSEiYYz8bK4Z28V/l3NIC9iOPXcCD7t0VacXfbfbPU6zPI0QsHh5lEx7djDSCQ3u5RgZCslM0xPT05CMUTmaIP7Fa5Cuzvm9296e/NVhlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhDEWliM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E764AC4CEDE;
	Fri, 13 Dec 2024 19:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734119676;
	bh=FT2pYxMpVRHpQWvyHdsqFN9olabaHp1QF/cpNxwp+Ac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FhDEWliMHhI23eesC0WuJblRR2HUCUaJHGqZ13JjUp4S2ENL8edmxiuLlfY8HX760
	 slQxVixCuZNKOAHg2m8JCUpBoI//X7NhWQ0s99KNivjg4GjshHo32EFcJKCKdA4FPz
	 zy1f4TWD2aSxH3Wh4deiJEgn92XiRrci1z8oJmfzHqL9rKDsD+CsTHLvd1CjYiZPlY
	 oPG29lJp41gcLBvE/R3wUpD0JYpchTp5lsvzi9Vk2rwqjYwAvo0miV/cuXPXbkcSz6
	 f6LD9TqIbjEEJveQEOSSvZ7typL/91Y8qvhT/zZMmecSvlZqtlA7Y9Y7NlZPe4QIuX
	 LMkfg63D3cWWQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Dec 2024 20:52:54 +0100
Subject: [PATCH net-next 3/7] mptcp: add mptcp_userspace_pm_get_sock helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-net-next-mptcp-pm-misc-cleanup-v1-3-ddb6d00109a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9911; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oBnPGAcUV2dukp02f4TOPoUnQ0TE0k8I2ssrLqJk+aQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnXJDxTi/hFDK43OkDnKKzx8Cvu7NKrKF02XRiL
 LVikCgrIP6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ1yQ8QAKCRD2t4JPQmmg
 c060EADZTK86I2NFO0sWb0cJ/ARjBXiO1hSNJ5YxwXKfuxNxv4uSeodIJ3sa1b8O/I1za18oXi1
 KjNDzPKzQy2pry7wHV/qcKGynLdIKgyRWd5LurEIt7AqXkoLVozXYCNTS9mGBECh3Nh03q5hE7T
 Gwv0R3cDHMk2bmgN5vucfZPzjRnJwaypmxY4xTMlMJ1Le/W+6UBgjCoa3V2QKrS37lVH0wGk31O
 2N20+qPH/moJAugx4BmwtjlXWl0ub6yMZE+SAQ8+eXzYJlUolZsNY8WX+vmccwA2oBPwuEW2Kin
 meD7ewYk6qBVQdScNGAHUQb//dCi77zzf/vHL8pPkuL21rUExl9/6xKtORFNepYUgaaGL0Tf5US
 VuqstM85L5jbonIYeN2w1OpI843r7mt2DvWKzDmtkxIe58Q/dJeoKtgRBQkIzg5BcchFdrEwfQ2
 fPRwkNUzcVRClW3nNxrd22A0adJLVDlT2QKZl830kxNO2bvsBAtOElteY//BmlG+QKaJoI8LO+j
 aNMlMxI8eGm8dNqtJg7NZJQZsR22ijXNZNhDUf7FJ9mWmqaxRKAZDIylkT8Hj0J/9N596BeOpUG
 Rl6yIkxibMahOPN8jsiFWb9P3qwcx2798blc548heIXt8aEb477mG/KD5J6aelmTJidiwrGc3v0
 upj8gLSqtFv0eAg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Each userspace pm netlink function uses nla_get_u32() to get the msk
token value, then pass it to mptcp_token_get_sock() to get the msk.
Finally check whether userspace PM is selected on this msk. It makes
sense to wrap them into a helper, named mptcp_userspace_pm_get_sock(),
to do this.

This patch doesn't change the behaviour of the code, just refactoring.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 144 ++++++++++++++++-------------------------------
 1 file changed, 47 insertions(+), 97 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6a27fab238f15b577e1e17225d4450e60ffd25d7..afb04343e74d2340cd77e298489b55340dda0899 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -173,36 +173,50 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 	return backup;
 }
 
-int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
+static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct mptcp_sock *msk;
+
+	if (!token) {
+		GENL_SET_ERR_MSG(info, "missing required token");
+		return NULL;
+	}
+
+	msk = mptcp_token_get_sock(genl_info_net(info), nla_get_u32(token));
+	if (!msk) {
+		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+		return NULL;
+	}
+
+	if (!mptcp_pm_is_userspace(msk)) {
+		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		sock_put((struct sock *)msk);
+		return NULL;
+	}
+
+	return msk;
+}
+
+int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
+{
 	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
-	u32 token_val;
 
-	if (!addr || !token) {
-		GENL_SET_ERR_MSG(info, "missing required inputs");
+	if (!addr) {
+		GENL_SET_ERR_MSG(info, "missing required address");
 		return err;
 	}
 
-	token_val = nla_get_u32(token);
-
-	msk = mptcp_token_get_sock(sock_net(skb->sk), token_val);
-	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
 		return err;
-	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto announce_err;
-	}
-
 	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "error parsing local address");
@@ -275,7 +289,6 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
@@ -283,30 +296,21 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	LIST_HEAD(free_list);
 	int err = -EINVAL;
 	struct sock *sk;
-	u32 token_val;
 	u8 id_val;
 
-	if (!id || !token) {
-		GENL_SET_ERR_MSG(info, "missing required inputs");
+	if (!id) {
+		GENL_SET_ERR_MSG(info, "missing required ID");
 		return err;
 	}
 
 	id_val = nla_get_u8(id);
-	token_val = nla_get_u32(token);
 
-	msk = mptcp_token_get_sock(sock_net(skb->sk), token_val);
-	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
 		return err;
-	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto out;
-	}
-
 	if (id_val == 0) {
 		err = mptcp_userspace_pm_remove_id_zero_address(msk, info);
 		goto out;
@@ -343,7 +347,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
@@ -351,28 +354,18 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
-	u32 token_val;
 
-	if (!laddr || !raddr || !token) {
-		GENL_SET_ERR_MSG(info, "missing required inputs");
+	if (!laddr || !raddr) {
+		GENL_SET_ERR_MSG(info, "missing required address(es)");
 		return err;
 	}
 
-	token_val = nla_get_u32(token);
-
-	msk = mptcp_token_get_sock(genl_info_net(info), token_val);
-	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
 		return err;
-	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto create_err;
-	}
-
 	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
@@ -475,35 +468,24 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_addr_info addr_l;
 	struct mptcp_addr_info addr_r;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
 	int err = -EINVAL;
-	u32 token_val;
 
-	if (!laddr || !raddr || !token) {
-		GENL_SET_ERR_MSG(info, "missing required inputs");
+	if (!laddr || !raddr) {
+		GENL_SET_ERR_MSG(info, "missing required address(es)");
 		return err;
 	}
 
-	token_val = nla_get_u32(token);
-
-	msk = mptcp_token_get_sock(genl_info_net(info), token_val);
-	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
 		return err;
-	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto destroy_err;
-	}
-
 	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
@@ -566,31 +548,19 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct net *net = sock_net(skb->sk);
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
-	u32 token_val;
 	u8 bkup = 0;
 
-	token_val = nla_get_u32(token);
-
-	msk = mptcp_token_get_sock(net, token_val);
-	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
 		return ret;
-	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "userspace PM not selected");
-		goto set_flags_err;
-	}
-
 	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
 	if (ret < 0)
 		goto set_flags_err;
@@ -637,30 +607,20 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 		DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
 	} *bitmap;
 	const struct genl_info *info = genl_info_dump(cb);
-	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
-	struct nlattr *token;
 	int ret = -EINVAL;
 	struct sock *sk;
 	void *hdr;
 
 	bitmap = (struct id_bitmap *)cb->ctx;
-	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 
-	msk = mptcp_token_get_sock(net, nla_get_u32(token));
-	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
 		return ret;
-	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto out;
-	}
-
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_for_each_userspace_pm_addr(msk, entry) {
@@ -685,7 +645,6 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	release_sock(sk);
 	ret = msg->len;
 
-out:
 	sock_put(sk);
 	return ret;
 }
@@ -694,28 +653,19 @@ int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 				struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct mptcp_pm_addr_entry addr, *entry;
-	struct net *net = sock_net(skb->sk);
 	struct mptcp_sock *msk;
 	struct sk_buff *msg;
 	int ret = -EINVAL;
 	struct sock *sk;
 	void *reply;
 
-	msk = mptcp_token_get_sock(net, nla_get_u32(token));
-	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
 		return ret;
-	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto out;
-	}
-
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		goto out;

-- 
2.45.2


