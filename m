Return-Path: <netdev+bounces-151871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F4D9F16D0
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350D2162E58
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2399D190661;
	Fri, 13 Dec 2024 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvebfEfg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB40519047A;
	Fri, 13 Dec 2024 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119671; cv=none; b=I2n7zCE0WXUAbLJYc7LjHrvlK2vsyikr0sQfKJzj5DVfWsUUoMR0KOLSabzmmFFfWB7L1xx2Pz9Ko+rQWDeUOwGrjDHcEnkIErRW1+Cx+paxZpI5bf86xU6wa3tbcA1wX4he4hfOKmwSNXCFjlkwij7htu4+I4z5FeJml9K5nts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119671; c=relaxed/simple;
	bh=YeEo0FQpu4HwzsK5d2IHwd99nWxzPy4eCH/vibmZDvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PH1b8ChPxMKPsLoALWqdcnDkrfrRWhRqcmYULx/Y1+vy5EXneI1NM6RIxpo6Dbc3q9rkLqtR4ACQY7xqGBD/22OchCjJS0qX3MnvXDVMxDA522OkykeKdtwq8G2Qs48WDDtds1Phcp/MT0vAINTdnOc/l3bC+cgXb7sJ0QcKsas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvebfEfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CC6C4CED7;
	Fri, 13 Dec 2024 19:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734119670;
	bh=YeEo0FQpu4HwzsK5d2IHwd99nWxzPy4eCH/vibmZDvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NvebfEfgYUNmRFtzFNs59JomyIuV5Ng9c5+JQe2LlXI5BcN4J7Kg9Dy3wNCCenzER
	 AZBtUohb3oGKEg0DaJQI8wdPiulUB0kJsLSN9yzSqkTiciAXfWvczozhm1f3s7nx7h
	 adT7YpL2dtCUiKMjVGc+3uWQDQdR74vtf/EUgNhbkNi8vgVE8g2m+5yTo31Ig6K1IW
	 IW5qGtbxB+vYjPmRX30siqx/PvVcoQCDyiPdkXJFGwJS3kHP/ZXKM6ryX+3D7Ga2wI
	 Mmt/KZHhJKBz8IJwDT2pjjAGLwQRI03sZ9N6RgPcvuwqUKrh05Khi0tp0Wj/MLvcSl
	 l12BsX+xqFOqw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Dec 2024 20:52:52 +0100
Subject: [PATCH net-next 1/7] mptcp: add mptcp_userspace_pm_lookup_addr
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-net-next-mptcp-pm-misc-cleanup-v1-1-ddb6d00109a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5130; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DWCBSaHTHFhWfsXP07JxK1bsLPN/FA8ensLxvz+BmKk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnXJDxMuObpi/F3ZfZMzBsOSUUXZ+wmiIEuunvJ
 jwHjRqdfhyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ1yQ8QAKCRD2t4JPQmmg
 c9FVD/9k9kQ3ZBpNgSMmmMh2v6QvYvNInFt0Bi3R/6QsHn8ARXdti8dElAGeWB7vk8Y6Myqad7v
 RIIpwsGM+o4B7q1qjNDF7g1v0GXL+7OtoWbc92A2N+lB4d6Uc9L0g725g7xXWbKJ1Gw4mxrU6eR
 9A/V068JTYgrbZI3DmTE6X+veGQjbXkUBejnD1Jz7LyRGL4QQ7N7XfpPIlyebfu+6nrqt/F1ocv
 5pT0LbW6ZE5qRW8NnfIwOVQOy8dmX2wyU05Lnh6ex3HoDW+Eld+GndJtUxVSUkg42oE8fA2qzmN
 gBWO7GhxsbJPPQEUxyK/ojYMr7tYNTUk8SmmHDn7JHrIAzjplml9cnnNfkLsGRGYyrUFTmMPcB0
 Wc5pD0i3AqocpkZvTMu1/jp9vsVsgvRKzjGUFMjapum9vIUv6QcM/84kFTwZJWX3+SDzoKFW3ie
 YqCp4NMMDtDqzoHyZct3kgiiHFMb9rfkkrHHq+ZzCcOHn40gYtMDHs+OF8LXFE1QpULMqW9aEav
 tLvw7NRgursWPzTwXTHsCbwDggf5eKfp8Qa5pb4rM5hL5CKK8/JiHbWq6sKMCyGFv8XMEFCbbAN
 lIZN4XhLkVoV22sov6DA9KixSl3rMT/QdjZB/d0zNSgzkKniz4wG0qPWFa16GIe34/wZIX41HR6
 UWJ5SLSgVOh3WTA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Like __lookup_addr() helper in pm_netlink.c, a new helper
mptcp_userspace_pm_lookup_addr() is also defined in pm_userspace.c.
It looks up the corresponding mptcp_pm_addr_entry address in
userspace_pm_local_addr_list through the passed "addr" parameter
and returns the found address entry.

This helper can be used in mptcp_userspace_pm_delete_local_addr(),
mptcp_userspace_pm_set_flags(), mptcp_userspace_pm_get_local_id()
and mptcp_userspace_pm_is_backup() to simplify the code.

Please note that with this change now list_for_each_entry() is used in
mptcp_userspace_pm_append_new_local_addr(), not list_for_each_entry_safe(),
but that's OK to do so because mptcp_userspace_pm_lookup_addr() only
returns an entry from the list, the list hasn't been modified here.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 69 ++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e35178f5205faac4a9199df1ffca79085e4b7c68..3664f3c1572e269fd7c74ea1d86a49389ed5c0c1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -26,6 +26,19 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
+			       const struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, addr, false))
+			return entry;
+	}
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry,
 						    bool needs_id)
@@ -90,22 +103,20 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
-			/* TODO: a refcount is needed because the entry can
-			 * be used multiple times (e.g. fullmesh mode).
-			 */
-			list_del_rcu(&entry->list);
-			sock_kfree_s(sk, entry, sizeof(*entry));
-			msk->pm.local_addr_used--;
-			return 0;
-		}
-	}
+	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
+	if (!entry)
+		return -EINVAL;
 
-	return -EINVAL;
+	/* TODO: a refcount is needed because the entry can
+	 * be used multiple times (e.g. fullmesh mode).
+	 */
+	list_del_rcu(&entry->list);
+	sock_kfree_s(sk, entry, sizeof(*entry));
+	msk->pm.local_addr_used--;
+	return 0;
 }
 
 static struct mptcp_pm_addr_entry *
@@ -123,17 +134,12 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_addr_info *skc)
 {
-	struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
+	struct mptcp_pm_addr_entry *entry = NULL, new_entry;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&e->addr, skc, false)) {
-			entry = e;
-			break;
-		}
-	}
+	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
 	spin_unlock_bh(&msk->pm.lock);
 	if (entry)
 		return entry->addr.id;
@@ -153,15 +159,11 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 				  struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
-	bool backup = false;
+	bool backup;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, false)) {
-			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
-			break;
-		}
-	}
+	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
+	backup = entry && !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	spin_unlock_bh(&msk->pm.lock);
 
 	return backup;
@@ -606,13 +608,12 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		bkup = 1;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &loc.addr, false)) {
-			if (bkup)
-				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
-			else
-				entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
-		}
+	entry = mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
+	if (entry) {
+		if (bkup)
+			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+		else
+			entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
 	}
 	spin_unlock_bh(&msk->pm.lock);
 

-- 
2.45.2


