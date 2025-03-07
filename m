Return-Path: <netdev+bounces-172887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5844AA56681
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EFE3ABDCD
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E1F217727;
	Fri,  7 Mar 2025 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMvykRe+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB7217718;
	Fri,  7 Mar 2025 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346519; cv=none; b=GEdt0MywSd3tqEWo5rWMxDAAbiEcQAolgXxoxKIT11WeY0wXgCNGnu3t4enh6rP/EahvxwBD7+DTohEiXoMh3tbgn8ff2Yn/293gp1Asy/Rbcmewn5w1ZfXT/NpWgyP/47yeq79WyWZNGyPVLnnHtBFYAYuM33U3xC91LRP8SYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346519; c=relaxed/simple;
	bh=m0tbqgy2Fs18Vg7nq4jYtQPHfemyvcqkKBYSjS8hbm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpuDqc4blGmsYOVRBAsCg6q3j4b1kEcI+Accl8szqzzo6ijZ7nEGCN6mMeALfokqzzeIHoTc/XZm8pmFlD0wFcBSnRlTperK2Xz/00T4NDOJKtqW7NUWsZHm4sYBPsshpaz1HtF6faDJ2bboykUzj2om7Ad7Zs4ABlbboopOvag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMvykRe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA47C4CEE8;
	Fri,  7 Mar 2025 11:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346519;
	bh=m0tbqgy2Fs18Vg7nq4jYtQPHfemyvcqkKBYSjS8hbm8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XMvykRe++XNF9UJhG2pFnMfrCCYkFrBr5PHZo/gwDaBlJ1hKZ8PJ39h6D861B9cm6
	 Z68ICYCUPvv6jrVf8jkNgoXqMEhrF4QVB88HWGbo5IIhSph3FCO0TRWFwvTXxkDy0M
	 ODMchUBecMuZojy5xXMKsTS/rpbSUUpDiprJOUT4esNiWFWz9drbxNQK+QaE1DNVqP
	 2hK4DYqmdahyyVuPmQ/NM+IJ3Tyo600TFmvMvJkb7SWQ7kFnx93j/7R6EqBHDNWSBy
	 0HCNv201k7fI3QJJ3uzElWBpcgM6LUlaMf8Ny7n3R44VESLABYvgcLvziLoeT0MK94
	 dHfuGnaG8UdjQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Mar 2025 12:21:45 +0100
Subject: [PATCH net-next 01/15] mptcp: pm: use addr entry for get_local_id
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-1-abef20ada03b@kernel.org>
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6157; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=N0jxYDhWIMIjBjXGCW8uoGdyvqIDOnjvgQElvjNeUrI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbRG3zJe4vBwz9PAVPNrz0t3EpVtGttJ3MJG
 5+2Gjn+W8mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0QAKCRD2t4JPQmmg
 c990D/4mLGvBCyGdcTlKU5v0a8DyQTQtj3sXmt6pjGQmINQ4wEwGBxIb+b3Fb10jXQP183UWxmO
 /R0z7iWvO8CtfP6M4EXHtDAxMRlmfSJZzD78BuomCnS+2Bz8MUsh1OWllqeKLDrMcF9W5SfvYCU
 dhTeUq4clyRcSV9KAgFgkt/puzvA46cW/unxSonp+v2/5dHy834MZ8XwB39yqZk73PFrigqgRNN
 sF4V0eednhGcwnlmL3SsossrDBKMPhBT6GR9s/SD3VGw2sY1K0AFeksuVQ6pK3W4zDXEDNErxr0
 xjbxZGFqM/iBgd9Q5t4JAarAYdLzOPwYUvM6m9VoescGe3EnfCepHaCA7rxtmO2qHyJBW2Kw6u9
 bP8CNeKOiXQzeO2C7luOC2JBymiys7Ka7gqoFfwy2lsuHK5XHqusJjyJeYNa+7fbdRuBddWbF5p
 HKd+kH0Mcnj2Rh10+fvjv1DSccMQ2r+OqXEg5Rl7Vlqd5mtlt0ZDPy4kmlWwgOuddUbiedT3hiC
 aJoukryx4fhcJ5aPsUNoXF2PATx47KSBdDOPNGT3lPzqoz/bVs23HZ9HgNvMLmHHXSzT+DLLaZm
 7WWrgRH+7rfJG2JwNfkVkdmfmSqu3eHNHt55ul6zgCYDu1KwaGH7APZvY4GMWZaP6mdk5V8B5RC
 QAyJjgShzGFxpuQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The following code in mptcp_userspace_pm_get_local_id() that assigns "skc"
to "new_entry" is not allowed in BPF if we use the same code to implement
the get_local_id() interface of a BFP path manager:

	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
	new_entry.addr = *skc;
	new_entry.addr.id = 0;
	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;

To solve the issue, this patch moves this assignment to "new_entry" forward
to mptcp_pm_get_local_id(), and then passing "new_entry" as a parameter to
both mptcp_pm_nl_get_local_id() and mptcp_userspace_pm_get_local_id().

No behavioural changes intended.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           |  9 ++++++---
 net/mptcp/pm_netlink.c   | 11 ++++-------
 net/mptcp/pm_userspace.c | 17 ++++++-----------
 net/mptcp/protocol.h     |  6 ++++--
 4 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6c8cadf84f31f4c7dcc38b787beda048d5362dc8..f6030ce04efdf20b512b3445fb909b4dec386b1a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -406,7 +406,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
-	struct mptcp_addr_info skc_local;
+	struct mptcp_pm_addr_entry skc_local = { 0 };
 	struct mptcp_addr_info msk_local;
 
 	if (WARN_ON_ONCE(!msk))
@@ -416,10 +416,13 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	 * addr
 	 */
 	mptcp_local_address((struct sock_common *)msk, &msk_local);
-	mptcp_local_address((struct sock_common *)skc, &skc_local);
-	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
+	mptcp_local_address((struct sock_common *)skc, &skc_local.addr);
+	if (mptcp_addresses_equal(&msk_local, &skc_local.addr, false))
 		return 0;
 
+	skc_local.addr.id = 0;
+	skc_local.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
+
 	if (mptcp_pm_is_userspace(msk))
 		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
 	return mptcp_pm_nl_get_local_id(msk, &skc_local);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a6387bcf848b9483feb454c78ba110ae7fd72621..23c28e37ab8f1befb391894e465635ee523d54ed 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1150,7 +1150,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	return err;
 }
 
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
+			     struct mptcp_pm_addr_entry *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
@@ -1159,7 +1160,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
-	entry = __lookup_addr(pernet, skc);
+	entry = __lookup_addr(pernet, &skc->addr);
 	ret = entry ? entry->addr.id : -1;
 	rcu_read_unlock();
 	if (ret >= 0)
@@ -1170,12 +1171,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	if (!entry)
 		return -ENOMEM;
 
-	entry->addr = *skc;
-	entry->addr.id = 0;
+	*entry = *skc;
 	entry->addr.port = 0;
-	entry->ifindex = 0;
-	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
-	entry->lsk = NULL;
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
 	if (ret < 0)
 		kfree(entry);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7e7d01bef5d403cb8569a3e26102eccf466745a5..8c45eebe9bbc755cc11dfb615be693799829f250 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -130,27 +130,22 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 }
 
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_addr_info *skc)
+				    struct mptcp_pm_addr_entry *skc)
 {
-	struct mptcp_pm_addr_entry *entry = NULL, new_entry;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
+	struct mptcp_pm_addr_entry *entry;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &skc->addr);
 	spin_unlock_bh(&msk->pm.lock);
 	if (entry)
 		return entry->addr.id;
 
-	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
-	new_entry.addr = *skc;
-	new_entry.addr.id = 0;
-	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
+	if (skc->addr.port == msk_sport)
+		skc->addr.port = 0;
 
-	if (new_entry.addr.port == msk_sport)
-		new_entry.addr.port = 0;
-
-	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
+	return mptcp_userspace_pm_append_new_local_addr(msk, skc, true);
 }
 
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7b74dedc79362203cb058122e0d0a1718fb6035a..333d20a018b42e8881b8ad62466a2f196e869bdc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1121,8 +1121,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
+			     struct mptcp_pm_addr_entry *skc);
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
+				    struct mptcp_pm_addr_entry *skc);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);

-- 
2.48.1


