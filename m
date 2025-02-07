Return-Path: <netdev+bounces-164022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80B5A2C48B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E533A8D79
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08CB23AE81;
	Fri,  7 Feb 2025 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aB+UAHNX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E3723AE80;
	Fri,  7 Feb 2025 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936806; cv=none; b=ZHUTPE0Rmt2Qb1psyluJ9DiG8tG8zdmudgH1zGKbgiEd5A/vAp806CxEPBEE4RmUiYSryjOYPC7TtblHg5HD6g6MapkCMcYGoUDYcIsdEmChBopLl3B5uHqCeqCyENyC7jwF2wMGBZSwsed7ZI97sVAZIrpWpKEXKtSjCJ6/ISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936806; c=relaxed/simple;
	bh=w68cYSg6WyAk3uTwltAFjwgiEcD8LUi2kgnY+OQEoTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJFo30btRtyRJ0U7qYdiW6c2QIOpflrvvRfZX1C4GowY7rlswcweDat7FiaW6f/uffjiM1RH9jYVyTV6sVb7leYGeO8hzz/D+d2yuXgPzinIMezykXXzqZxL1F8V9Y0u7eA532zCJeCcu52KD8BVYBanWmgu85mM4LNJJtpQ3U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aB+UAHNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32454C4CED1;
	Fri,  7 Feb 2025 14:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936806;
	bh=w68cYSg6WyAk3uTwltAFjwgiEcD8LUi2kgnY+OQEoTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aB+UAHNXjhRnMEUxsk/HIrXDa2P8wLRz7kFR5nH/UC/ELAvBxLMcm2BGxCWeGj1XX
	 WIu0aiZtJyszmNC0o8s07kkBLh0hq9AMiwSIfNogXhg1k5uNsTYio7DQryfLEbMl+/
	 KDRxqKqIHPiSGE9rgUxlbDpDX/0PYMMjHSKNie5a2CMhhSLXssRmHu+n0We1q3C+no
	 uavJyOaJ1YmCKIjqkp4/P4OdgRDB97taygI+IWAnnvZZVFu7V5Vu253jdEeynjjOzS
	 Lyiqs79moXlatoevDkpAbkxGFMjoDXeYYUHbIcajc29RD4Alrc9C9EEgBOZXjrbolS
	 kxhzTYqxhWadQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Feb 2025 14:59:33 +0100
Subject: [PATCH net-next v3 15/15] mptcp: pm: add local parameter for
 set_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-15-71753ed957de@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7617; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qj9m8m0a3wfgfUzgBFHqOovOUzvV2q/ybgg+jHEABjI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnphG9msOuXbrLsJrdogTH566Shz1XOiMDFTvsi
 4iP4ohxhCuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6YRvQAKCRD2t4JPQmmg
 c8D5D/9TpPLISFDO3Jr63keIuvFWcSA/NJd4SvcW3vUcGQQYweBU2qkMarM3iUzUtvHEUMCoPgJ
 9LbOrGE4px29l13A1Q7nMEiS/2/D4yro6tc/ZCQP5fU5lCGZyzq82R09oDxb0HNz1w2x8NCfy5M
 XtcAduO6EpFqPFpt1IT9Lp5FRJIBVvGLzvOGSwT+BOJDtMGOxmpY0x0rRTL0PlwuX61kZeZNu+L
 czE29qMaxDQ55/iZrOoat7VxVlxGxaSGaRG7fwhzrggHYKZzFbllXc5WvA8QCB4fYDlgmQpY7ft
 8GpMowV2fpSm87Np0wERB6GUPiYNAz2RcqMpFOz3Czp00bou9dhW+yhq2Jp4Ws8fcbp1/D1CbGm
 abCJM4idzkdWUiwtuQcKXKTD0kVqSMTB72ykKnmzCEQBISIrfYuJOau3nKV+4C0JdIxkdwXtn1b
 MPFHgLDsMKYKEWEgI3f8yTn5y0qkrigHsY1uPnkqe63eIt+tYufSqw0H7BnuGsZds9XUG3EkI9/
 xfd12yPo7ireNI93KHAyjSGeZk9Wq8fMet+cGbylR9hE7RlZ0yiRkkjHjGVLbWbn5eyKe2YP7Te
 rjyeDxPjZnSCRUNHutnS2KarqoifGPeAQnMSP8Hhv7kygys5mOaDZppazvQ431wYBTKzV7YsB0a
 78TQj23YzxV4lUQ==
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
index 172ddb04e3495348a62feb4b634ed2c32ad7dce2..99705a9c2238c6be96e320e8cd1d12bfa0e0e7f0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1951,50 +1951,41 @@ static int mptcp_nl_set_flags(struct net *net,
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
 	    (entry->flags & (MPTCP_PM_ADDR_FLAG_SIGNAL |
 			     MPTCP_PM_ADDR_FLAG_IMPLICIT))) {
 		spin_unlock_bh(&pernet->lock);
@@ -2002,12 +1993,12 @@ int mptcp_pm_nl_set_flags(struct genl_info *info)
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
index 6e7dc5375e291f9b6ec27bc8c632691401b91717..37226cdd9e3717c4f8cf0d4c879a0feaaa91d459 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1038,8 +1038,10 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
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


