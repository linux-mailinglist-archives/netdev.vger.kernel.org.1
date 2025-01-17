Return-Path: <netdev+bounces-159435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BA4A15783
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937D93A7E0D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42B71E9B20;
	Fri, 17 Jan 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la+Ee7F1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC71E9B1D;
	Fri, 17 Jan 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139338; cv=none; b=STDPh7AHnLUqoZszROG99QBPa0cfdcN50zzzSDd3Y/1UNREwujVqFZqyJ/RNd6rK8kPJwV0bTe2GQHkxvbBPYa1qgG5B9vt72DjftDaDmsnsYC8aYElwd3NOFjd0B96h6wdAXocXSb2E5qmkajjeB3FQpXVL7TBqgJ7qbqMT6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139338; c=relaxed/simple;
	bh=aUS1NonvHy253RG7iD6V+MotJ2vT0l3meNzJIfFovpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=adtRX3A1zdo2qwDeJJBSy3sujj+7uu993Dh0xiI2R6GVfYmon+/fIHZP/iKP8q2JTAkAajbSQufdCHxrXeqQCiDYdVSiA2HUhmlFFkjm+vTDsHwwDw+mnqDwOj9ECy1+DNpBZCj0hJMrmoGIDSsuqCRLY/ZgQzZ2sfZ/hJkGgOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la+Ee7F1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B894C4CEE8;
	Fri, 17 Jan 2025 18:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139338;
	bh=aUS1NonvHy253RG7iD6V+MotJ2vT0l3meNzJIfFovpU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=la+Ee7F1UcSXW8/j6Dw9Nzc5BCapmRie/w0IoybXXpMptCDAKNBAZT76eACefmuFp
	 0JQwnLKlFJoth4WNgqHasljTY3teGkcVNBFnEycGl6C4Yn5e8ZoD6UGhoH+cHd85LB
	 XuAXi4W3xlzKxYyYqSE0MaEJXTX+/xcPgRYT1D0jER44S4NczDN2QmhG1bbD6EDpGY
	 t5eio10rU4+rG3ptzwvlWTa4hWmpJFp0ngxvFHDOKaZS2GBfE6LqbuXYHbYdi2KhTW
	 gfKCeqx//pm3fn0Xo3jSBSeHvnS3cZTblUXJC7zjed9nNX9VujmNbEUo5HPpISY/Fx
	 famivKFT6aWFw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 19:41:43 +0100
Subject: [PATCH net-next v2 11/15] mptcp: pm: add id parameter for get_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-11-61d4fe0586e8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5703; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=w8FZxi4P8R7OyWva5g/VZWDB0AeZXhr4vEcDgu3NcOc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniqRqBdj9OLUibJqB+H2AWRAC1XFykdZroLknw
 XTb0I++bkeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qkagAKCRD2t4JPQmmg
 c/BgD/4wCTI/jGwFong5zJdzwalo2365/2Ob6WB1iCEe7tkXjlmSiU+eD5lEAjDWe1Ae7L0HxI4
 fG2uVSz9yTcNSqz+398V/Fr9QSTYRja2gtK/hKAF6552P0LO0OJXBC8wdwolB4zWe7iDmZfRO1a
 rQpEenaIE5HxaaErJk3IiCHFDDkDH0KOWwXZegfwHoyJ14IdEcYifI+IWn+7HpvLYVf0JFt9rJb
 2KybjJvDomLlsvqb2exiTXaXlplulMo2/jilr6FjnVapJg2noF44c9F+jNfX+ihWD15xBHLijp8
 LDiVjHT4mw2aZ/lbEJmGQ7ERu4VWqAiXvmiP4O1C9QP4kFkUVlxj4VJ6GyDiPM/nLNjh7SP6o1z
 uk/XmyTdN+jjUUZsvNPZ8u55QoS2eWGK41dRdB5HqM6VodWXoR7wW1WO72c2vwYYvBfmtTPyFcM
 FZO3GfgWqSXxgMdzFa2UuaoQY/YSOOu84TZqywwnZRCGJ6U4TB4LAp63LlnXefKq6Gz6BbYBfJ4
 1VG/YW4ub4+OExAkKCNJwiOtN9DvYDH3PtWmTx+r3jdHzTX52SRsR+qBmjznfzwyXYWMlo6Y3Lc
 GC2lvxenldQBQkQqetjk+E+nl8bNB4BNVXnrdJeWKOurFyzUv30yvtLxsrV+pxzv9T8nr6iWv9G
 arb/Y+/1+R6hxHA==
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
---
 net/mptcp/pm.c           | 20 ++++++++++++++++----
 net/mptcp/pm_netlink.c   | 16 ++++------------
 net/mptcp/pm_userspace.c | 14 +++-----------
 net/mptcp/protocol.h     |  4 ++--
 4 files changed, 25 insertions(+), 29 deletions(-)

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
index 853b1ea8680ae753fcb882d8b8f4486519798503..f7da750ab94f7bbffafb258cb0d6ff01ad59c0b0 100644
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
index 7fe91a2e170dd40a830c4301960b484017fd11d2..e77920c932442ce1d317fcda8d2561e11d0c2a12 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1132,8 +1132,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
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


