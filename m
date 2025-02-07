Return-Path: <netdev+bounces-164018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FBFA2C482
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8C0188E70E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0973E23906C;
	Fri,  7 Feb 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAi3NjAb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369A239065;
	Fri,  7 Feb 2025 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936796; cv=none; b=NdG9/1o9j75thgdscMhuEvQjUeHDLWx3gnAkwH+V/uJtJeaSCGT2pZRlB9wdxDAH0MVhZIQPq/thQbeL82SWfqsdeqnJ8YF7d5i/DL0AqOpHP1t6ybU/U0ryye4YRkF2toQhMnZZFd3UDlkY3q6Ym24Fd2RuXbU16E6BMJ4092U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936796; c=relaxed/simple;
	bh=7M8zHdU1PZn0d0vrNjtFpzTQwFdAblqqoVi6ORrd108=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QqL6mn4ANmzfCGzwsRneQXeLm+nWgPkXg+8zBu/zG2cag9PhezkxbeJGA2fbI/73/nXDS1NnOlCtJRvJxB6Y4IS1jKXgR7VH5ypbMOFju27loeiIqfBJzeVN2PJiiTuYur0REU9uCikl0g1x9UPzExwM1eqnigaphVeZT0RMCLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAi3NjAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AEAC4CEDF;
	Fri,  7 Feb 2025 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936796;
	bh=7M8zHdU1PZn0d0vrNjtFpzTQwFdAblqqoVi6ORrd108=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rAi3NjAbFr36QPN24l/FBnpmVzGtV7/+ser5JHaumB5qBoZhYlMHRjvYQTV+mEKZK
	 9dQ1DdcDRDIBF/hktzCYZRusQmp1G87MLiR52SpqfEgFkLWHV5cxxbWlb6jKXTusSs
	 6nbtG2+H+ppOEjYdg37yF2IcgXCNMqr4F4M3koKK9wNL8uuCduf3ODen3C6bYTMrqh
	 4k6DY/auorA56Bb+lSKGybX/7paOmnOAGyZkTjTqDcAMNqz/LkSjpPUuF9QTeaPDTy
	 KAFjR7QmNgiBhEs5oRJMq5EzUJAh1PcX8hUhLYMvCojNXyG6FPcaPnmQfxYYdygxei
	 rDswXr3WAJT4A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Feb 2025 14:59:29 +0100
Subject: [PATCH net-next v3 11/15] mptcp: pm: add id parameter for get_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-11-71753ed957de@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5775; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HXd6Aj/DYG7JLfN2KwZ/tTYEUnX7lmHLq+ywdaJ48lI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnphG99hO3JHkPR9+8pUdNVaf4dwM34Hzq1mvrV
 kwFCMUc6eeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6YRvQAKCRD2t4JPQmmg
 c+NYEADMfi6JGT7GkY7dfJGZBGp/hJBeEtXi+s/jWSVDpFr0nTTF4njDtHnPyOx3hEmTCfDLpIF
 PuP4bGiQcjYS3GqRt+jKxEMzhB9ILWGIkjrfJRvriAWgXeXsstD0VC7VcaCWppBLqjo4FNJxNPC
 PqQHhSuWYmk1Xpo4+2Gb9eIv7H4WL6N+x3TjoBg6oOxY2o1TcztSH3SFq8m0a3RLDZWo4UNG3jP
 Fz6vbGO+fDWWbZlLAfqUBQsvFiIC2BwWhPbUqjHwSuJP+/IdpT2dV7HsBLg2StWxz+rMfG3sHw5
 kl0NsE2Z2N9wNl070zb3dm8JFmOaDbV1q1TDaTIT1ibZjOwZqf9LLq+On56Q3NwJWRBX9H0Qpi2
 1UAZ3+LyyaPNhIS+56BRkUuetIr77D4CmIc5PcFUdX7V1SAM8j7kW3Y6zV9L/M3Bl8CY4PzKAiy
 cS/kKHV1LFOIeVCZxZ2MBBlOfr8wesGlQE3X2jFEcHv7yuRnSNsgfGbkoVqcei6CUOzD0ZVGPQ/
 EvkRfE7lDKx9qTrbUwe3d6pF3uNiPvpwyrkaJANYESRf0Y/vKJjs4Z+854KaLttjCjlPcEmgvvQ
 z9WZB9P0Msk8t4TZhbbYYXt9WzTeumTwZEDrxIduiXMJkW11UKDFwqgAWOMBD2IKzF6TRwvatyP
 9HZF196GEpAbTyQ==
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
v2:
- Fix 'attr' no longer being set in mptcp_pm_nl_get_addr(), but still
  used in this patch (no longer in the next one). (Simon)
v3:
- Same fix, but in mptcp_userspace_pm_get_addr().
---
 net/mptcp/pm.c           | 20 ++++++++++++++++----
 net/mptcp/pm_netlink.c   | 16 ++++------------
 net/mptcp/pm_userspace.c | 16 ++++------------
 net/mptcp/protocol.h     |  4 ++--
 4 files changed, 26 insertions(+), 30 deletions(-)

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
index 8185697044e2b735edb161578685411f9ab231e4..5a6c33d0063df7e741b9a83a624099adab1611f6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1773,23 +1773,15 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(struct genl_info *info)
+int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
 {
+	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	struct mptcp_pm_addr_entry addr, *entry;
+	struct mptcp_pm_addr_entry *entry;
 	struct sk_buff *msg;
-	struct nlattr *attr;
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
index 1246063598c8152eb908586dc2e3bcacaaba0a91..99e882a5a67180bc912818ec0952fd50ed601ac4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -684,30 +684,22 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct genl_info *info)
+int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry addr, *entry;
+	struct nlattr *attr = attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	struct sk_buff *msg;
-	struct nlattr *attr;
 	int ret = -EINVAL;
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
index a4c799ecceffe2fe495c0066bcb31b9983d64b01..ffe370245ec55fe64b1215b48878d1bdaabd3248 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1134,8 +1134,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
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


