Return-Path: <netdev+bounces-151874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CDB9F16D6
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47EDA18864B6
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B925195B1A;
	Fri, 13 Dec 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVLp3zcw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB919580F;
	Fri, 13 Dec 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119679; cv=none; b=aq60dAAHNPVPsJWzG11KOomxjkZl9C7SrVp/SwylFRGF1SzL55nIcZnU1PR1/wIbiX7Yu/Nx765cy8TrStsDXxDTs4WMK5td1g7+jFXSUYdTJ61veyoXBPrlAAdMKcPHRApUVLXmQlL6BTUasmWxEP49DTi5T4luUDKFk4NOACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119679; c=relaxed/simple;
	bh=3g50c6HBn+t7c/kMlsP5mIHLE9A+Iv7BvIt3rAwhsRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dNbAI1OuHc1IKzLM6EZUTmzkd7XyFAnwjCV+X0Edagom2r+cOHJLB8ENOMpjcLT05FYkid1hY7sR0MlelLeXDCq6EzlIeHnWWdPWDNb1au4GZIVS6a3MUbDDYmgKDWdq8qIEoO/irEKHGxUov2uq4zT1PWDdeHgMXjGA/1qJZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVLp3zcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA1DC4CED7;
	Fri, 13 Dec 2024 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734119678;
	bh=3g50c6HBn+t7c/kMlsP5mIHLE9A+Iv7BvIt3rAwhsRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XVLp3zcwXrZTSCJ+IaG3tj8Ux2UpG8IbNx7GT1otWVRUoY4KW70RlFHtKcq+Vb+Dd
	 otirepW3XnACGPRmX9w6Af6qfZfaXIxt3eOBHxepfUqOSfV8MzzzYv2eekd0m+Gpwz
	 wJZkk4UZwsQ6r8ecOsD9NceCY1NS2/Q/jayU9Hy+GwLh18klcF3ux5/EqkyDPRMh5L
	 bjyepBJtrvf7PJzAqn2C6FQHJ8ix5KXAi5MzKbHScYSPpQBM0E14HDq9csWYEeAOt4
	 Qt2w1YjHDZm5KujPpjh5nlIvJY7Jyirqh6xo3ppukg3q0VtSQm/pZAAze0WcTj1ehT
	 pJ4KRVYgDGgqw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Dec 2024 20:52:55 +0100
Subject: [PATCH net-next 4/7] mptcp: move mptcp_pm_remove_addrs into
 pm_userspace
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-net-next-mptcp-pm-misc-cleanup-v1-4-ddb6d00109a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6419; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cL+GKxNWOp5RCIUkUynjWxXQuFxEFi2FPnZGxZ/+qkA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnXJDxCo3At+1nzWrn288cTpAlFqWJcpH9gB7qt
 eSJeZUbA/qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ1yQ8QAKCRD2t4JPQmmg
 c//8D/41Jgv2NOyXLNHYLDpfQvQ99tpNy0C1AzwyYFiDg2NUVlVOI2M4J39KhfAgfFsDf3KIEts
 V8D3HE3OhM5+GUj9xgtUvZVq38ezEWEXHgltjJuNgqPv00UxMjFwEiMPcm6DxlV/YHr9VxV+rIe
 WgW4yk+FMIO5LXXUuulrXud1VkLUFYWBYkewoY5rYKsKiqtNdEb+wVhjeDG14IvVsTgf0cHgWGq
 nkkhZOzUD8Cbt396gSOl5YDIcCz+vzySfXOvWKBj4ITn0x8d2Tyzx74LyoFezOKKrwlMA4EtGL2
 P0C6hBUB+S0Bel1HZWp/91oUOpZzc4C5BsZpSxp0f+TcPbC+cjjJatj/uhuJFFVrCZx8VsRpzke
 oYH+L3mXdSxl990QNkH1NRqIQKpZAMH0HCmbFLh/fHgQiUywYcODcFdjxBiqCAttzJemuoSLCnS
 AvxIPkYWtcAbB3B3olA20Q+CPuNLfJb6KRiP+GpbyKYBinaUQ28szgPItiWpWj4y9Rbpp7dgIZP
 1nYeAoayqMDK5E30YTOMytkcwii9mvhP/ejKC29RbI6PzVDc98RNdhlMPuiBddrfqNvMLDJDvqt
 E1IopuxdAEpHF3UsWe16ZUTq0yguHFfZ9DQ3hCtyB9clfZv+FXEeiPevEsoRL9ojKeoZcr9rMAA
 bEmSimC5i9MVItw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Since mptcp_pm_remove_addrs() is only called from the userspace PM, this
patch moves it into pm_userspace.c.

For this, lookup_subflow_by_saddr() and remove_anno_list_by_saddr()
helpers need to be exported in protocol.h. Also add "mptcp_" prefix for
these helpers.

Here, mptcp_pm_remove_addrs() is not changed to a static function because
it will be used in BPF Path Manager.

This patch doesn't change the behaviour of the code, just refactoring.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 46 ++++++++--------------------------------------
 net/mptcp/pm_userspace.c | 28 ++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  4 ++++
 3 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7a0f7998376a5bb73a37829f9a6b3cdb9a3236a2..98ac73938bd8196e196d5ee8c264784ba8d37645 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -107,8 +107,8 @@ static void remote_address(const struct sock_common *skc,
 #endif
 }
 
-static bool lookup_subflow_by_saddr(const struct list_head *list,
-				    const struct mptcp_addr_info *saddr)
+bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
+				   const struct mptcp_addr_info *saddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
@@ -1447,8 +1447,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				      const struct mptcp_addr_info *addr)
+bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -1476,7 +1476,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 
 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
-	ret = remove_anno_list_by_saddr(msk, addr);
+	ret = mptcp_remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
 		if (ret) {
@@ -1520,7 +1520,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		}
 
 		lock_sock(sk);
-		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
+		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
@@ -1633,36 +1633,6 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-/* Called from the userspace PM only */
-void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
-{
-	struct mptcp_rm_list alist = { .nr = 0 };
-	struct mptcp_pm_addr_entry *entry;
-	int anno_nr = 0;
-
-	list_for_each_entry(entry, rm_list, list) {
-		if (alist.nr >= MPTCP_RM_IDS_MAX)
-			break;
-
-		/* only delete if either announced or matching a subflow */
-		if (remove_anno_list_by_saddr(msk, &entry->addr))
-			anno_nr++;
-		else if (!lookup_subflow_by_saddr(&msk->conn_list,
-						  &entry->addr))
-			continue;
-
-		alist.ids[alist.nr++] = entry->addr.id;
-	}
-
-	if (alist.nr) {
-		spin_lock_bh(&msk->pm.lock);
-		msk->pm.add_addr_signaled -= anno_nr;
-		mptcp_pm_remove_addr(msk, &alist);
-		spin_unlock_bh(&msk->pm.lock);
-	}
-}
-
-/* Called from the in-kernel PM only */
 static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 					      struct list_head *rm_list)
 {
@@ -1671,11 +1641,11 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 
 	list_for_each_entry(entry, rm_list, list) {
 		if (slist.nr < MPTCP_RM_IDS_MAX &&
-		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+		    mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
 			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (alist.nr < MPTCP_RM_IDS_MAX &&
-		    remove_anno_list_by_saddr(msk, &entry->addr))
+		    mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
 			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 	}
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index afb04343e74d2340cd77e298489b55340dda0899..cac4b4a7b1e586b66d86c7a15462f642a7b0314f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -287,6 +287,34 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 	return err;
 }
 
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
+{
+	struct mptcp_rm_list alist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+	int anno_nr = 0;
+
+	list_for_each_entry(entry, rm_list, list) {
+		if (alist.nr >= MPTCP_RM_IDS_MAX)
+			break;
+
+		/* only delete if either announced or matching a subflow */
+		if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+			anno_nr++;
+		else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list,
+							&entry->addr))
+			continue;
+
+		alist.ids[alist.nr++] = entry->addr.id;
+	}
+
+	if (alist.nr) {
+		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= anno_nr;
+		mptcp_pm_remove_addr(msk, &alist);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+}
+
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a93e661ef5c435155066ce9cc109092661f0711c..5ba67cb601e02902ca6fcd91028ce36d30f45fc3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1027,6 +1027,10 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
+bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
+				   const struct mptcp_addr_info *saddr);
+bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *addr);
 int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);

-- 
2.45.2


