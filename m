Return-Path: <netdev+bounces-159439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02686A15789
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505E81885345
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFEC1EE03D;
	Fri, 17 Jan 2025 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fmmv+W6N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EDE1EBA08;
	Fri, 17 Jan 2025 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139349; cv=none; b=jI/M8YzfV0Ln8uWZOViJluA827I9+n8SoSdVBXuQ7sLVGQcmeIkvLwVfj4QViKoaMh2sjLulPxHT4pojYik/zjtfd2pvUddxTxG2TSt4exRmfN6aWt1IyiXqvFdCvuZgKMeFFJ0vLmHZMZEDWFzo4Tg8w06ORv8BkkSKlwW3gpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139349; c=relaxed/simple;
	bh=wx/MAt8aTDGMMZUp/3rZvd7r6+B3dtTjjmLAqsXJjSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QWnNpu1UOZkH7qa0Vo4cPRJdxRZulq/iyH47inY2GLCraQMOOxIOLux0BawrSqvlvk/q09EpkZqWAmWHnMwuUprqlOuTLvWkpPkCZqsmyNHqhWB0BImG3MzCkZnVtU3yW2EfgWCJ9NG3FuPzCXheuAUgi9T0xMEE0CFR8mdSpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fmmv+W6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC3EC4CEE0;
	Fri, 17 Jan 2025 18:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139349;
	bh=wx/MAt8aTDGMMZUp/3rZvd7r6+B3dtTjjmLAqsXJjSE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fmmv+W6NLGXmYXB41BrG8p4A61FL43hx4T+NvQNE2nW626mLXHpKgi7QI8ltJLRKQ
	 DNb623zVWkPnvUfDLfOX34vRPhF1uvkhEsawzIpnjiAubUOhmcK0LbTDVhLKTT0Q9B
	 Dtd1ibvmLSS5zoxYAWqslo0WJPVsvBOg722yjoXUEOZAffS0pH8Nv24sUg3atoPXKK
	 5VoJ53fbmD661LxAU4AYPvm39u4Yo+z3wx/sNQulThtjBrh+AlaomAF2x/4RSa/JYY
	 MZ16Xfof04AvN0ZxifLk6hRD2EbNpebjiqFn2VJwaFg+ue4BhKGt/AyeXEVHnBoklM
	 WdGuJsxEGDCoQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 19:41:47 +0100
Subject: [PATCH net-next v2 15/15] mptcp: pm: add local parameter for
 set_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-15-61d4fe0586e8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7567; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jtC6ugdm2BzQr6tjHVlRQQAfuKWYk/N/2vrKM0wc/J0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniqRr6gxqv43R6khcwZ8O+btpLV8j4lNpnup4z
 xRyGOl4B7KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qkawAKCRD2t4JPQmmg
 c3HTD/9g666JXszTh3SsXVStQ85i4T1M4sMxWU4F6bxzd9z2SApW73+drYrZd6b0ILZCGs9V2YU
 Rh9tS56rqtltuGY/UGwpJv4XTXSR/WblwoyjB+dqgZJcoHbPzQvD8g66ZlNvOfm9ZfoYDDAYIfQ
 oiZLr7MtxSoqBU7H6epI+A3OK6oIbkRUsf0tCOrxuBQdObNu2LWBQJELVRdiJH7q1IM3d6+7SoC
 GKsJGhvC5zIH/1Doe5O8zb9zbNZXCQEzhucws+EoelkGaWvhdP5wZs3DTw6elM+k2EobH7ys0X+
 o210/+93GdgOE8WL8gDO6TnWPVhI1NPUPt+ZASZtyPGj87n36QwL3CXKD+OmsFdsxLZj74pZiGK
 QU5aOrEPNsaLOgGOPHt7rFZkpr/ZV6Azr02mZEeeZv8KK2mBD2+LMayAHv0/TI+A8kJbVVI7iaQ
 Tk1dJN0nfUbSMJPLew4K1sut9tPk7QJeKhyfuMrQLjxzN6YJVrsc3IH6fPC4eJ3EXXUKE53RfT9
 +nx/NMn5j0HcvPFmy+POe/g3TmbzikLApXt/bMZC3uAOaPOAApkKHdtsqHFO2Cvoq7XH6qyrPgq
 Wmreg3oZ01grqUs6khPXZjDbMoJQddmlqAEuz5+3gW/a6vQr7lD3IWScQDyjkOrWo4uavtdM0Zh
 Va/hMSDJ0yg3OAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch updates the interfaces set_flags to reduce repetitive
code, adds a new parameter 'local' for them.

The local address is parsed in public helper mptcp_pm_nl_set_flags_doit(),
then pass it to mptcp_pm_nl_set_flags() and mptcp_userspace_pm_set_flags().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 16 ++++++++++++++--
 net/mptcp/pm_netlink.c   | 35 +++++++++++++----------------------
 net/mptcp/pm_userspace.c | 19 +++++++------------
 net/mptcp/protocol.h     |  6 ++++--
 4 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c213f06bc70234ad3cb84d43971f6eb4aa6ff429..b1f36dc1a09113594324ef0547093a5447664181 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -506,9 +506,21 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 
 static int mptcp_pm_set_flags(struct genl_info *info)
 {
+	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr_loc;
+	int ret = -EINVAL;
+
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
+		return ret;
+
+	attr_loc = info->attrs[MPTCP_PM_ATTR_ADDR];
+	ret = mptcp_pm_parse_entry(attr_loc, info, false, &loc);
+	if (ret < 0)
+		return ret;
+
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(info);
-	return mptcp_pm_nl_set_flags(info);
+		return mptcp_userspace_pm_set_flags(&loc, info);
+	return mptcp_pm_nl_set_flags(&loc, info);
 }
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c2101f7ca31e648aa72ff0890ba3a0801c1bf674..fef01692eaed404e272359df691264f797240d10 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1951,62 +1951,53 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-int mptcp_pm_nl_set_flags(struct genl_info *info)
+int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
+			  struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
 			   MPTCP_PM_ADDR_FLAG_FULLMESH;
 	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
-	struct nlattr *attr;
 	u8 lookup_by_id = 0;
 	u8 bkup = 0;
-	int ret;
-
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
-		return -EINVAL;
 
 	pernet = pm_nl_get_pernet(net);
 
-	attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
-	if (addr.addr.family == AF_UNSPEC) {
+	if (local->addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
-		if (!addr.addr.id) {
+		if (!local->addr.id) {
 			NL_SET_ERR_MSG_ATTR(info->extack, attr,
 					    "missing address ID");
 			return -EOPNOTSUPP;
 		}
 	}
 
-	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	spin_lock_bh(&pernet->lock);
-	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
-			       __lookup_addr(pernet, &addr.addr);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, local->addr.id) :
+			       __lookup_addr(pernet, &local->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		return -EINVAL;
 	}
-	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
+	if ((local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
 	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		spin_unlock_bh(&pernet->lock);
 		NL_SET_ERR_MSG_ATTR(info->extack, attr, "invalid addr flags");
 		return -EINVAL;
 	}
 
-	changed = (addr.flags ^ entry->flags) & mask;
-	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
-	addr = *entry;
+	changed = (local->flags ^ entry->flags) & mask;
+	entry->flags = (entry->flags & ~mask) | (local->flags & mask);
+	*local = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
+	mptcp_nl_set_flags(net, &local->addr, bkup, changed);
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 1af70828c03c21d03a25f3747132014dcdc5c0e8..277cf092a87042a85623470237a8ef24d29e65e6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -564,9 +564,9 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
+				 struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_pm_addr_entry *entry;
 	struct nlattr *attr, *attr_rem;
@@ -575,8 +575,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	struct sock *sk;
 	u8 bkup = 0;
 
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
-	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
 		return ret;
 
 	msk = mptcp_userspace_pm_get_sock(info);
@@ -586,11 +585,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	sk = (struct sock *)msk;
 
 	attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
-	if (ret < 0)
-		goto set_flags_err;
-
-	if (loc.addr.family == AF_UNSPEC) {
+	if (local->addr.family == AF_UNSPEC) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr,
 				    "invalid local address family");
 		ret = -EINVAL;
@@ -609,11 +604,11 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 		goto set_flags_err;
 	}
 
-	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
 	if (entry) {
 		if (bkup)
 			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
@@ -623,7 +618,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, &rem, bkup);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0fc74e567329f005096cb0769f4fcf4a5019f532..8dcde58a62d5243e3868441cd5859712aa98826a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1036,8 +1036,10 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
-int mptcp_pm_nl_set_flags(struct genl_info *info);
-int mptcp_userspace_pm_set_flags(struct genl_info *info);
+int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
+			  struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
+				 struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);

-- 
2.47.1


