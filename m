Return-Path: <netdev+bounces-151875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F109F16D8
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3F018875BA
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B2C1E0DD9;
	Fri, 13 Dec 2024 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gv17vZw4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93E199921;
	Fri, 13 Dec 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119682; cv=none; b=KKdbW5tbWaYQCBuZEobzMhUvG0eE9lO2IfqRQKj3e9brPvz99/K9ioIN5nheYw+41VwgJwohxiGlRHcq7YOPAfWfQWSzrlO/dWbVjgtpX9bJ72FW3nRIP5c3Hf9JRZREMt5rk0KDpYwU6CaICdEiGierGDIgbB1SKfUdDi6j/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119682; c=relaxed/simple;
	bh=b5vVbASD/+U9TlDn04S+Fi5osjg+Wd/T5nHLXZLbOKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hFTc7NAVBvNBEUkiOrZS2notOW4AMgeMDgvAFq1wWfL5h0sP4AVWHm+mIR/+6Ze9p5BmFH7BQHcQGIqbinRufu5/uOuy2xvPBcT1Zs9KJKojr5pwE2oYtlyVIq1RcbmltxeNJf4bRXDpSJdaCc9XDNiuuwADSEBy3OtBq6bSsQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gv17vZw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DC2C4CEE2;
	Fri, 13 Dec 2024 19:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734119681;
	bh=b5vVbASD/+U9TlDn04S+Fi5osjg+Wd/T5nHLXZLbOKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gv17vZw4NsMF7qhcbhRTmmcJDtrYCm3wSOH54fqBJkCmthjue1PboCPri2920Gb4y
	 FFgEYbt4QqFvCsRyQD8+pmNKvTzhl162TbOIwhVQ6tWsPyHCC/+eRBvY8DB+5UgNKR
	 EN0GJ22EnOB5QAZQX2MmcjpQaPcj0xTuyoi4z9AYB857D6dGZtjnLTM4FGhFPRDvdY
	 ZqLZxq4iK4DOZOLP7hHaCMyOYZwWNJ8TfoHbD8rnx38YaA2is4ScL99kuNAnRjq5xn
	 XK/TB06YX79b21CBoSWz79OqxjtKAeqUd3Yi6/UMO1C2WUCkzOxr358R31py61ZWMs
	 1lqWBqzF2R1Pg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Dec 2024 20:52:56 +0100
Subject: [PATCH net-next 5/7] mptcp: drop free_list for deleting entries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-net-next-mptcp-pm-misc-cleanup-v1-5-ddb6d00109a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3983; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TRx8Ib8e0IRHyTHl/67CzmebJSbQHIWBfNaEJnvqAvU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnXJDxYy3Y9jgHSW2jHXQrl8m7f1Om9b782N+1+
 VpQMTfxTgiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ1yQ8QAKCRD2t4JPQmmg
 c2V4EACrcHO15PIdrCf7memqk1nHi7cYRgjEsXQkuNa+8ktpGAYnFC2IjPxx2bdG/i3a/j2u6BL
 VRewb2CumcjOlAkXrGnrGpu/L4Y8yeAerYcbRQBS0rXPOXTORTmUpwvhimhveM2kv5bBCPa4HW/
 dcjmxjnHSMjrOIERxjNS+g1ys0niS4qQKvxF5ZLxHJWt1OHM4tvR8jS8GpwEtkCOFegAO/euYn+
 QYg/1TKfYFDTZ5TBYBODQPq+U/x8XwHgYgrq0kszUjCjFKtV/2sCoyomlg6hSt8PzoUxLn5EpSd
 aBprr3fSGMvBaUJkvGDySyBdJsB9kMTd7AecPq3xDA9HD2OJzFny91nFE/+xQ9LEcW4xbwsBPg+
 1XFEra95eNTivLszu71sx+s8oQtvsk03dcYYTWWnLXyRHzDiwEGSaUvpsBnUQiha+NkZcd/CHp8
 pOG0DPLdwl6TjALen6PIxirZWfsMJPjBkvLG9MOwBumGvpU7BbaxojqoY/2a4cKDtVEfga3km3S
 CvKKVgZV2xrxBHHQ8iFYwIrw4NHDYVppuZvtcJkiLU3/RN6TKZZE2NM6/93H4N94STzSSLG4zTw
 P7qJB9HDhZtdCmrsL52YCkTXxxry+uKVBMp/D9UWJ+03nwg9FskNA8HMXgDzCz7prItJY31t3Mn
 O9mTW4hwtPDaYkA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_pm_remove_addrs() actually only deletes one address, which does
not match its name. This patch renames it to mptcp_pm_remove_addr_entry()
and changes the parameter "rm_list" to "entry".

With the help of mptcp_pm_remove_addr_entry(), it's no longer necessary to
move the entry to be deleted to free_list and then traverse the list to
delete the entry, which is not allowed in BPF. The entry can be directly
deleted through list_del_rcu() and sock_kfree_s() now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 42 +++++++++++++++---------------------------
 net/mptcp/protocol.h     |  3 ++-
 2 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index cac4b4a7b1e586b66d86c7a15462f642a7b0314f..7689ea987be35aa9e9b87c7add108a08566e974f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -287,41 +287,31 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 	return err;
 }
 
-void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
+void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
+				struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_rm_list alist = { .nr = 0 };
-	struct mptcp_pm_addr_entry *entry;
 	int anno_nr = 0;
 
-	list_for_each_entry(entry, rm_list, list) {
-		if (alist.nr >= MPTCP_RM_IDS_MAX)
-			break;
+	/* only delete if either announced or matching a subflow */
+	if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+		anno_nr++;
+	else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+		return;
 
-		/* only delete if either announced or matching a subflow */
-		if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
-			anno_nr++;
-		else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list,
-							&entry->addr))
-			continue;
+	alist.ids[alist.nr++] = entry->addr.id;
 
-		alist.ids[alist.nr++] = entry->addr.id;
-	}
-
-	if (alist.nr) {
-		spin_lock_bh(&msk->pm.lock);
-		msk->pm.add_addr_signaled -= anno_nr;
-		mptcp_pm_remove_addr(msk, &alist);
-		spin_unlock_bh(&msk->pm.lock);
-	}
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.add_addr_signaled -= anno_nr;
+	mptcp_pm_remove_addr(msk, &alist);
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_pm_addr_entry *match;
-	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
-	LIST_HEAD(free_list);
 	int err = -EINVAL;
 	struct sock *sk;
 	u8 id_val;
@@ -355,16 +345,14 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	list_move(&match->list, &free_list);
+	list_del_rcu(&match->list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	mptcp_pm_remove_addrs(msk, &free_list);
+	mptcp_pm_remove_addr_entry(msk, match);
 
 	release_sock(sk);
 
-	list_for_each_entry_safe(match, entry, &free_list, list) {
-		sock_kfree_s(sk, match, sizeof(*match));
-	}
+	sock_kfree_s(sk, match, sizeof(*match));
 
 	err = 0;
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5ba67cb601e02902ca6fcd91028ce36d30f45fc3..cd5132fe7d22096dbf6867510c10693d42255a82 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1038,7 +1038,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
-void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
+void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
+				struct mptcp_pm_addr_entry *entry);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 

-- 
2.45.2


