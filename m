Return-Path: <netdev+bounces-158978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B77A13FF9
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC9B161B78
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDB7242261;
	Thu, 16 Jan 2025 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIaPWzyA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F85243845;
	Thu, 16 Jan 2025 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046503; cv=none; b=PcHh6NJgb+gA/KIfGEPfJA3a2Am3g9Yz1AGYGZFwNGrCy1l+ddFnvCQUCzOUe/TYnsCmF5PxRiOH1YHJ+Rb/xcJSo9zk+DBVffdBei5kWdXN+P+lmeKYx7rSHeLUJsdUJqE5wgD/PXkJw3aeWv1oG2Y5g6E2T9Flwk7Y6Q0pYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046503; c=relaxed/simple;
	bh=YRpq9JV5Z5meenpglwSA1AZ13S9YzSV5/fyK+fdxSao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z1pA8bS4McTl7UI4GrkoGqZWAe7rWnoz4Kqk12QShv2N0AU8cGb+APaN9nZBCQHjIclzUIYCWG3Uwu1NNMCPu9q5lMj/f8sVkkcyYz431IjmseZyUsCHRSZ4QVf4y57k1bqFDqmlnl4/QUJ+RIw0G4OdnL9O7YHBuYrIsopoJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIaPWzyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18408C4CEE1;
	Thu, 16 Jan 2025 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046503;
	bh=YRpq9JV5Z5meenpglwSA1AZ13S9YzSV5/fyK+fdxSao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IIaPWzyANJD5eqauO6H5FjV+kS+B5te75+QYhEdzgjdjQyWb1nVWNj6bTCqFxE6dP
	 Q/28uF/3la2f2tQ6arRJs0ZoNEdbAP/XJp8KDhy/SkSFcWuyNWYceCk9bmm5gVzb69
	 JL8Y4tQjtb1LPX4jx54sDZHcA+N9alf0A422KRXsI5ZnNl0KpmB8BJH3AOVpZpWGXp
	 xrllgsfh0RjIa7VkTUmBgJ9auAQbxCxMmhRgO0tVrNAuSHan6IBTs8oOx1MuZe1VHL
	 HcxK/Z/s21pic9vgN9bRjzMkUWSlFL2cryH81RNwsFpC9o3uKAwGnNEaah7GMlZUpU
	 LWGSIroXKA9Xg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 17:51:33 +0100
Subject: [PATCH net-next 11/15] mptcp: pm: add id parameter for get_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-11-c0b43f18fe06@kernel.org>
References: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
In-Reply-To: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5499; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lqHa0c+mmfmiUAzGpi4E8Vg0xmIpkoSJxe0Pjghhe4s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnHxi/xZCSgV+WfgAibPf5UHE3RyMV16cfoO
 up4kbjRxySJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xwAKCRD2t4JPQmmg
 c563EACi1bnp1PR8jQujqv9/t6Nr4uWCU3q17T2+A54Bw3SZ6NaHZOvqsw2W/xZ0TOpsqF8IL3l
 BvhQb7rxyDOHBT9S2wxghQYrM3PGIkeIn7YjcVP6ecL2/nf3pUEYJj9AQgGosnSM4yA5zRc7wlN
 S1ZUGKSiolEAyL1OfIlkig5hSp5Wgqyccfi066sm0WD+ifHSuSqavIce2JX19hoa5ieBYrQXZD1
 af3vni3+6sVL4EYh8Vw6EW2bttOs0NSuXXh5vFE9zJCBn3gX8WnEIm3uTurIBMHBg6MxOvOS/yl
 lJ2wqgZa8uxOcvahv0l23mnd672Equ7xCeOde+UwhTTPgalewzXg7bddvNwxf8MIUg3VMn12MNN
 cUhvGQQ2E9oiKuig/0lc/SyOVcSljZ2yanDCy+3atcGS8pgpaxUw0rapGdUK+QEfa7L3xNwdP1X
 4S7IsvGLulWRglj2BmLTLwJwySjHEJ+lZh7ZP9aHpKb5F4mggewNgdbvtHd6cmnuVi6DYx1aLkP
 ATwnDyiGYHYousDrVK816VY6bZdWdSViNw/QQ/gRl2LgkUBKwjRoQao7OC8e15OgjsHHVRCInLA
 QRgcPXv82yyyX3nu9U3kCmataUZu+je9EQV/NCFG3JzMyP2x4crKaCGSSdAKgzIWKst4LAmenwL
 JznyH8utnsF6fNw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The address id is parsed both in mptcp_pm_nl_get_addr() and
mptcp_userspace_pm_get_addr(), this makes the code somewhat repetitive.

So this patch adds a new parameter 'id' for all get_addr() interfaces.
The address id is only parsed in mptcp_pm_nl_get_addr_doit(), then pass
it to both mptcp_pm_nl_get_addr() and mptcp_userspace_pm_get_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 20 ++++++++++++++++----
 net/mptcp/pm_netlink.c   | 14 +++-----------
 net/mptcp/pm_userspace.c | 14 +++-----------
 net/mptcp/protocol.h     |  4 ++--
 4 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 526e5bca1fa1bb67acb8532ad8b8b819d2f5151c..caf5bfc3cd1ddeb22799c28dec3d19b30467b169 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -434,16 +434,28 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-static int mptcp_pm_get_addr(struct genl_info *info)
+static int mptcp_pm_get_addr(u8 id, struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(info);
-	return mptcp_pm_nl_get_addr(info);
+		return mptcp_userspace_pm_get_addr(id, info);
+	return mptcp_pm_nl_get_addr(id, info);
 }
 
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_get_addr(info);
+	struct mptcp_pm_addr_entry addr;
+	struct nlattr *attr;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return -EINVAL;
+
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	if (ret < 0)
+		return ret;
+
+	return mptcp_pm_get_addr(addr.addr.id, info);
 }
 
 static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 853b1ea8680ae753fcb882d8b8f4486519798503..392f91dd21b4ce07efb5f44c701f2261afcdc37e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1773,23 +1773,15 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(struct genl_info *info)
+int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	struct mptcp_pm_addr_entry addr, *entry;
+	struct mptcp_pm_addr_entry *entry;
 	struct sk_buff *msg;
 	struct nlattr *attr;
 	void *reply;
 	int ret;
 
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
-		return -EINVAL;
-
-	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
@@ -1803,7 +1795,7 @@ int mptcp_pm_nl_get_addr(struct genl_info *info)
 	}
 
 	rcu_read_lock();
-	entry = __lookup_addr_by_id(pernet, addr.addr.id);
+	entry = __lookup_addr_by_id(pernet, id);
 	if (!entry) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		ret = -EINVAL;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 1246063598c8152eb908586dc2e3bcacaaba0a91..79e2d12e088805ff3f59ecf41f5092df9823c1b4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -684,9 +684,9 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct genl_info *info)
+int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry addr, *entry;
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	struct sk_buff *msg;
 	struct nlattr *attr;
@@ -694,20 +694,12 @@ int mptcp_userspace_pm_get_addr(struct genl_info *info)
 	struct sock *sk;
 	void *reply;
 
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
-		return ret;
-
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
 		return ret;
 
 	sk = (struct sock *)msk;
 
-	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		goto out;
-
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
 		ret = -ENOMEM;
@@ -724,7 +716,7 @@ int mptcp_userspace_pm_get_addr(struct genl_info *info)
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, addr.addr.id);
+	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	if (!entry) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		ret = -EINVAL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 69f3909bef8fd163e701f27a003378cdea453805..f209b40d08f372528b2294f3494ccf2d6bbb43e1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1127,8 +1127,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_pm_nl_get_addr(struct genl_info *info);
-int mptcp_userspace_pm_get_addr(struct genl_info *info);
+int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info);
+int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {

-- 
2.47.1


