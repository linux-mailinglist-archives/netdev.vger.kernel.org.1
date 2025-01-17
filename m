Return-Path: <netdev+bounces-159429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA3A15770
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0135616044A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165191DF72E;
	Fri, 17 Jan 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrANXPf6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD3D1DF726;
	Fri, 17 Jan 2025 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139323; cv=none; b=TjfFtCXjAdOR+AKYVhtoJyd5/dc0YbZQJq3THxZ1soxD573zDOjpv0XItbiNn0B5zzZw7tSWDHrQ7RrhO3CQgcNdSG2GF75DECxA5han6MdzOqszI+8gEP4BWDQzTg3JKabOdBSdSrt1S6MnFfJO2A7KsaQmyEeLtmyEZ/jgmcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139323; c=relaxed/simple;
	bh=Lqek27knGwgehju7/g0u3Xuoe0fvOylfOxCOeXWYdF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/JN8NWFJ93jzfPyPuuD9QDlg+zintyQsJpPBlYGgpIdg4h/mHbuagw/evN0XzGs+IXyCutkuhmSjrTOdIOGRZVf1zPjTMLhbl+f+fSxuBxO+EWtyA44Jr3+DF60lqH0CUCmW2U+8zSQfI6ZbNHYCC3eyK8KD70gD1N8y2n3Kdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrANXPf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F12CC4CEDD;
	Fri, 17 Jan 2025 18:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139322;
	bh=Lqek27knGwgehju7/g0u3Xuoe0fvOylfOxCOeXWYdF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qrANXPf6aZ6HuOcAiGDq/6EfAb49mIOImXML+E7BftbajaAlRge6mvXM5tUUFSp6n
	 fkonnvyMgXEtqQl4H1yDZQrdYipjoc3Uo6DXLFXLJZ8x87b//N9dfXQ4mFaWRkwdeT
	 ayQxTJ3nN7KmqKVaXCSVXmfZqk3kuX39AJJu+iy+maJTiCnDymHAWw8YcJ05MGRcrY
	 6F62v1978g4SsqTQA45s78WCWe4m5m+Jh9hTjX7Uq0B02R1j6Vsea6n7S01Rrnip05
	 EL+2q9QwPcvW5W+5gbY64PxO8QGjSyWrwYIgeUJcvJjrmnvEPCZPafMRUI/jFhpYl+
	 CJNzNPhJ4RvkQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 19:41:37 +0100
Subject: [PATCH net-next v2 05/15] mptcp: pm: userspace: use
 GENL_REQ_ATTR_CHECK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-5-61d4fe0586e8@kernel.org>
References: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
In-Reply-To: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6019; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lYcLaaLOXN2A3W5NX7QnQyADIBMohkFvf2lwLm//Ay4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniqRqTN721Na/78MrdcI8FO+HqXY5xiAk5J8iN
 W0ZVNKDFlSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qkagAKCRD2t4JPQmmg
 c47LD/4/9IfRpbZM6Wh2U2DO3qT0WYUdeAhoguf/WhgV0l3Wxd4NWRm4f00BBvfyz/oPcYvkVcB
 YOyYOCDlskBf0pTcGlQHl06gDHKrnpUhv9GKojuVyZ7SVQsFjjSBxq78b0VPmt7zj8TUi9kwtBD
 PmRMFbhbX6UBnAdB2Zwux3OKdiwleSSMfRpxcnW53kTMS5gY5iNQfgfny5Lt+qQsecJiHUJnLHp
 dWxF+SK+LOFtIK1SNFcoxFceMEzuKyAREpdRlIbwIuwjl+kLfNP6Benxg9/a3uxZyajd214k77Z
 I6/mbZIRqh12FXikiETRDDxNPK/eXXasahbZ0THJ4fsKQt4UjWLpvlrlC/XyCliHEDcr5clq/I4
 IzpYYGk4BRitaPAZnHLe7JrQ9JsnuLgV+0viutsnIX8yX9I9Bh4VhozC4rj/na5wjrsADjUqzFJ
 fZ1y17DVD20lJ8cZXS+LtehfZD9/ml9pswOgDFhi/q6G2FkhXt0z4zjAYA7bnwYrKHDtZ2C/bwE
 YJdWS1PeefLbumaZ4+W3zz6Fswy0j+xEpNaeC8/g7vZRihyrmQuBL9ajPbDyn6pY40Gjwh86GaW
 LD0FvdJEbo23IWsIDstuzyTPHislUnTY08g9BQSeUehCG8UtNbf/5FkN8KVptbBi2KcdGIc2TOd
 335npVGUv94AxAQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

A more general way to check if MPTCP_PM_ATTR_* exists in 'info'
is to use GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_*) instead of
directly reading info->attrs[MPTCP_PM_ATTR_*] and then checking
if it's NULL.

So this patch uses GENL_REQ_ATTR_CHECK() for userspace PM in
mptcp_pm_nl_announce_doit(), mptcp_pm_nl_remove_doit(),
mptcp_pm_nl_subflow_create_doit(), mptcp_pm_nl_subflow_destroy_doit()
and mptcp_userspace_pm_get_sock().

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e350d6cc23bf2e23c5f255ede51570d8596b4585..4cbd234e267017801423f00c4617de692c21c358 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -175,14 +175,13 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct mptcp_sock *msk;
+	struct nlattr *token;
 
-	if (!token) {
-		GENL_SET_ERR_MSG(info, "missing required token");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN))
 		return NULL;
-	}
 
+	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	msk = mptcp_token_get_sock(genl_info_net(info), nla_get_u32(token));
 	if (!msk) {
 		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
@@ -200,16 +199,14 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
+	struct nlattr *addr;
 	int err = -EINVAL;
 	struct sock *sk;
 
-	if (!addr) {
-		GENL_SET_ERR_MSG(info, "missing required address");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
 		return err;
-	}
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -217,6 +214,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
+	addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "error parsing local address");
@@ -312,18 +310,17 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_pm_addr_entry *match;
 	struct mptcp_sock *msk;
+	struct nlattr *id;
 	int err = -EINVAL;
 	struct sock *sk;
 	u8 id_val;
 
-	if (!id) {
-		GENL_SET_ERR_MSG(info, "missing required ID");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_LOC_ID))
 		return err;
-	}
 
+	id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	id_val = nla_get_u8(id);
 
 	msk = mptcp_userspace_pm_get_sock(info);
@@ -369,19 +366,17 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
+	struct nlattr *raddr, *laddr;
 	struct mptcp_pm_local local;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
 
-	if (!laddr || !raddr) {
-		GENL_SET_ERR_MSG(info, "missing required address(es)");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
+	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
 		return err;
-	}
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -389,6 +384,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
+	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
@@ -402,6 +398,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 	entry.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
 
+	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
@@ -493,18 +490,16 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 
 int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_l;
 	struct mptcp_addr_info addr_r;
+	struct nlattr *raddr, *laddr;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
 	int err = -EINVAL;
 
-	if (!laddr || !raddr) {
-		GENL_SET_ERR_MSG(info, "missing required address(es)");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
+	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
 		return err;
-	}
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -512,12 +507,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	sk = (struct sock *)msk;
 
+	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &addr_l);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto destroy_err;
 	}
 
+	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");

-- 
2.47.1


