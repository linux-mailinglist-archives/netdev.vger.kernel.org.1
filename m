Return-Path: <netdev+bounces-172899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17593A5669F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7BC178147
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C4821C9F8;
	Fri,  7 Mar 2025 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E67KSbkg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170EA21883E;
	Fri,  7 Mar 2025 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346555; cv=none; b=TY+ksGwZNYbsWSZv01BSObuBW0KD68OouU6ohoGqn2ZkL4r0f69LFdoPJ7vY2bMwY/pS8+DcUptfeHvScBjhn6vXWsTRrGeXn5Mhf3vqOaBZdY+XkcqUOuJ9GN+DwUKMVKT1dFwCwGjWaGbPkiNZRk2WSL1CxT9HCHXlMJoV9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346555; c=relaxed/simple;
	bh=4khma3gxc470a4KUtegJncZCmBtvwCWP8d0H/kZRU/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mwtBZJnazWdbT92j2arduBEIkrgF2e/mMN/LPgBjyZYdQhGyFH5bUV/ktyXjEfzsEUI7U4UPsjMnIZWLbcnpz/9V+9CbmK06uGFhgyUMMZqTh9jzHo87BPUetW15WVJmPoMyIAnsGDpTjC58B/IYTEutCtazI4HFvJk4x4grt+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E67KSbkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF3FC4CEEB;
	Fri,  7 Mar 2025 11:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346554;
	bh=4khma3gxc470a4KUtegJncZCmBtvwCWP8d0H/kZRU/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E67KSbkgVNj7PrZkWLdQkygegb4hN1LZZbUe56decjhnUa1r0owN5av/1oH+SQ4LK
	 uDvnZGaYJkRkeltDWqW3tSQXLH3IWP0xgrtukT7HLG2Sn7GpOD9zORxRzTeMvSgtQk
	 1f+ZFFzYUi+OWhiLTD0ieV9VyAKIg2NDZAYmV46MAFMBByjEeN+rK8b4Z0F+ySTGwP
	 QRhdwztzM8MqbAS5f1PrfpVBlv2wJay57K60VMh+0DQnOzjnKrhzya6Q16g0YtGCjV
	 oYIJFd9vJLGPffd25EW1dmc8FEZ3oahEcyx0kGQOeJBrOJynMIo4BqL6K0TcfsLovp
	 tokYS8dBXS9MA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Mar 2025 12:21:57 +0100
Subject: [PATCH net-next 13/15] mptcp: pm: move generic PM helpers to pm.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-13-abef20ada03b@kernel.org>
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=32968; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4khma3gxc470a4KUtegJncZCmBtvwCWP8d0H/kZRU/Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbSxSjPDmfR8fk7kKMxtDbjM1W8sdBaDhWAk
 DdOh5bdRkeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0gAKCRD2t4JPQmmg
 c8zLD/9T4LdRiYDpVOrXdKDJsvsuyx58eGZ+jCzhaeiEJSgnLxxCGlyPq1R++tNTWJuY9ZnlRrr
 9TkiGLZRQELF9DX6Ely6bfbNbCoxhMx/cYuZ77oHdbD0cTVgseUQl0QVHQ5oIYzpRS+nehJjAuI
 vYb3eak+PMhGYcm6JLhRrLW1ehx4mAE420Wb0cWqZni+oIdipZu9AB0tZUZVF3v4FkoNzOp361Y
 IKP8IOHlwiBJFISc/4v/tz+Bh2POkCH0aDxt5NJ31W9hJi4L/ak0repW17Y6A/5+3X2Lv1YUxoM
 s68fCQz90RG1h4mZQmjtSGzz1kKaJ6p6l9kX6P9JPCbRr+ur+CveHX7U1QlQRkZqmmFMkBKlUOZ
 TjtFCFpAav8/2v6eiWjztCAhGLvNc5lguYEmCkmQ2uNnUb7G5/LFGpnn3tIUMojNA6eGNwUdpNc
 E/kDRBUYAzdZv+m+XT3XPcvE5Gfcx2TstdAURS1iosZ07AODZGpzW71iQXaLGXNKpmL/vudtVT5
 8XnjjC1CABBXlufiGW2p/Q7vdjftXH6/2op7rsa1zZNvx/nawYAu7vcYfQjDuF01DOBVVNJRRf7
 bX7Vha5cezFk7HDDUQxv8Bi2Dhf7G5G4vGRCSQWefLSlHt4NvxLwBrderJCPvOs9wyCSn2jab9b
 DPF7O27Vps7phEg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this patch, the PM code was dispersed in different places:

- pm.c had common code for all PMs

- pm_netlink.c was supposed to be about the in-kernel PM, but also had
  exported common helpers, callbacks used by the different PMs, NL
  events for PM userspace daemon, etc. quite confusing.

- pm_userspace.c had userspace PM only code, but using specific
  in-kernel PM helpers

To clarify the code, a reorganisation is suggested here, only by moving
code around, and (un)exporting functions:

- helpers used from both PMs and not linked to Netlink
- callbacks used by different PMs, e.g. ADD_ADDR management
- some helpers have been marked as 'static'
- protocol.h has been updated accordingly
- (while at it, a needless if before a kfree(), spot by checkpatch in
   mptcp_remove_anno_list_by_saddr(), has been removed)

The code around the PM is now less confusing, which should help for the
maintenance in the long term.

This will certainly impact future backports, but because other cleanups
have already done recently, and more are coming to ease the addition of
a new path-manager controlled with BPF (struct_ops), doing that now
seems to be a good time. Also, many issues around the PM have been fixed
a few months ago while increasing the code coverage in the selftests, so
such big reorganisation can be done with more confidence now.

No behavioural changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 460 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/pm_netlink.c | 461 +------------------------------------------------
 net/mptcp/protocol.h   |  14 +-
 3 files changed, 467 insertions(+), 468 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index cd50c5a0c78e83acd469050e177d6ee551f20f61..d02a0b3adfc43e134cc83140759703ce1147bc9e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -12,6 +12,16 @@
 #include "mib.h"
 #include "mptcp_pm_gen.h"
 
+#define ADD_ADDR_RETRANS_MAX	3
+
+struct mptcp_pm_add_entry {
+	struct list_head	list;
+	struct mptcp_addr_info	addr;
+	u8			retrans_times;
+	struct timer_list	add_timer;
+	struct mptcp_sock	*sock;
+};
+
 /* path manager helpers */
 
 /* if sk is ipv4 or ipv6_only allows only same-family local and remote addresses,
@@ -39,6 +49,345 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 #endif
 }
 
+bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
+			   const struct mptcp_addr_info *b, bool use_port)
+{
+	bool addr_equals = false;
+
+	if (a->family == b->family) {
+		if (a->family == AF_INET)
+			addr_equals = a->addr.s_addr == b->addr.s_addr;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		else
+			addr_equals = ipv6_addr_equal(&a->addr6, &b->addr6);
+	} else if (a->family == AF_INET) {
+		if (ipv6_addr_v4mapped(&b->addr6))
+			addr_equals = a->addr.s_addr == b->addr6.s6_addr32[3];
+	} else if (b->family == AF_INET) {
+		if (ipv6_addr_v4mapped(&a->addr6))
+			addr_equals = a->addr6.s6_addr32[3] == b->addr.s_addr;
+#endif
+	}
+
+	if (!addr_equals)
+		return false;
+	if (!use_port)
+		return true;
+
+	return a->port == b->port;
+}
+
+void mptcp_local_address(const struct sock_common *skc,
+			 struct mptcp_addr_info *addr)
+{
+	addr->family = skc->skc_family;
+	addr->port = htons(skc->skc_num);
+	if (addr->family == AF_INET)
+		addr->addr.s_addr = skc->skc_rcv_saddr;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (addr->family == AF_INET6)
+		addr->addr6 = skc->skc_v6_rcv_saddr;
+#endif
+}
+
+void mptcp_remote_address(const struct sock_common *skc,
+			  struct mptcp_addr_info *addr)
+{
+	addr->family = skc->skc_family;
+	addr->port = skc->skc_dport;
+	if (addr->family == AF_INET)
+		addr->addr.s_addr = skc->skc_daddr;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (addr->family == AF_INET6)
+		addr->addr6 = skc->skc_v6_daddr;
+#endif
+}
+
+static bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
+					 const struct mptcp_addr_info *remote)
+{
+	struct mptcp_addr_info mpc_remote;
+
+	mptcp_remote_address((struct sock_common *)msk, &mpc_remote);
+	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
+}
+
+bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
+				   const struct mptcp_addr_info *saddr)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_addr_info cur;
+	struct sock_common *skc;
+
+	list_for_each_entry(subflow, list, node) {
+		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
+
+		mptcp_local_address(skc, &cur);
+		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
+			return true;
+	}
+
+	return false;
+}
+
+static struct mptcp_pm_add_entry *
+mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
+				const struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_add_entry *entry;
+
+	lockdep_assert_held(&msk->pm.lock);
+
+	list_for_each_entry(entry, &msk->pm.anno_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, addr, true))
+			return entry;
+	}
+
+	return NULL;
+}
+
+bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_add_entry *entry;
+
+	entry = mptcp_pm_del_add_timer(msk, addr, false);
+	kfree(entry);
+	return entry;
+}
+
+bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
+{
+	struct mptcp_pm_add_entry *entry;
+	struct mptcp_addr_info saddr;
+	bool ret = false;
+
+	mptcp_local_address((struct sock_common *)sk, &saddr);
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.anno_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
+			ret = true;
+			goto out;
+		}
+	}
+
+out:
+	spin_unlock_bh(&msk->pm.lock);
+	return ret;
+}
+
+static void __mptcp_pm_send_ack(struct mptcp_sock *msk,
+				struct mptcp_subflow_context *subflow,
+				bool prio, bool backup)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	bool slow;
+
+	pr_debug("send ack for %s\n",
+		 prio ? "mp_prio" :
+		 (mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr"));
+
+	slow = lock_sock_fast(ssk);
+	if (prio) {
+		subflow->send_mp_prio = 1;
+		subflow->request_bkup = backup;
+	}
+
+	__mptcp_subflow_send_ack(ssk);
+	unlock_sock_fast(ssk, slow);
+}
+
+void mptcp_pm_send_ack(struct mptcp_sock *msk,
+		       struct mptcp_subflow_context *subflow,
+		       bool prio, bool backup)
+{
+	spin_unlock_bh(&msk->pm.lock);
+	__mptcp_pm_send_ack(msk, subflow, prio, backup);
+	spin_lock_bh(&msk->pm.lock);
+}
+
+void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow, *alt = NULL;
+
+	msk_owned_by_me(msk);
+	lockdep_assert_held(&msk->pm.lock);
+
+	if (!mptcp_pm_should_add_signal(msk) &&
+	    !mptcp_pm_should_rm_signal(msk))
+		return;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (__mptcp_subflow_active(subflow)) {
+			if (!subflow->stale) {
+				mptcp_pm_send_ack(msk, subflow, false, false);
+				return;
+			}
+
+			if (!alt)
+				alt = subflow;
+		}
+	}
+
+	if (alt)
+		mptcp_pm_send_ack(msk, alt, false, false);
+}
+
+int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
+			      struct mptcp_addr_info *addr,
+			      struct mptcp_addr_info *rem,
+			      u8 bkup)
+{
+	struct mptcp_subflow_context *subflow;
+
+	pr_debug("bkup=%d\n", bkup);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		struct mptcp_addr_info local, remote;
+
+		mptcp_local_address((struct sock_common *)ssk, &local);
+		if (!mptcp_addresses_equal(&local, addr, addr->port))
+			continue;
+
+		if (rem && rem->family != AF_UNSPEC) {
+			mptcp_remote_address((struct sock_common *)ssk, &remote);
+			if (!mptcp_addresses_equal(&remote, rem, rem->port))
+				continue;
+		}
+
+		__mptcp_pm_send_ack(msk, subflow, true, bkup);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static void mptcp_pm_add_timer(struct timer_list *timer)
+{
+	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
+	struct mptcp_sock *msk = entry->sock;
+	struct sock *sk = (struct sock *)msk;
+
+	pr_debug("msk=%p\n", msk);
+
+	if (!msk)
+		return;
+
+	if (inet_sk_state_load(sk) == TCP_CLOSE)
+		return;
+
+	if (!entry->addr.id)
+		return;
+
+	if (mptcp_pm_should_add_signal_addr(msk)) {
+		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
+		goto out;
+	}
+
+	spin_lock_bh(&msk->pm.lock);
+
+	if (!mptcp_pm_should_add_signal_addr(msk)) {
+		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
+		mptcp_pm_announce_addr(msk, &entry->addr, false);
+		mptcp_pm_add_addr_send_ack(msk);
+		entry->retrans_times++;
+	}
+
+	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
+		sk_reset_timer(sk, timer,
+			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+
+	spin_unlock_bh(&msk->pm.lock);
+
+	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
+		mptcp_pm_subflow_established(msk);
+
+out:
+	__sock_put(sk);
+}
+
+struct mptcp_pm_add_entry *
+mptcp_pm_del_add_timer(struct mptcp_sock *msk,
+		       const struct mptcp_addr_info *addr, bool check_id)
+{
+	struct mptcp_pm_add_entry *entry;
+	struct sock *sk = (struct sock *)msk;
+	struct timer_list *add_timer = NULL;
+
+	spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
+		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		add_timer = &entry->add_timer;
+	}
+	if (!check_id && entry)
+		list_del(&entry->list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
+	if (add_timer)
+		sk_stop_timer_sync(sk, add_timer);
+
+	return entry;
+}
+
+bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+			      const struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_add_entry *add_entry = NULL;
+	struct sock *sk = (struct sock *)msk;
+	struct net *net = sock_net(sk);
+
+	lockdep_assert_held(&msk->pm.lock);
+
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+
+	if (add_entry) {
+		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
+			return false;
+
+		sk_reset_timer(sk, &add_entry->add_timer,
+			       jiffies + mptcp_get_add_addr_timeout(net));
+		return true;
+	}
+
+	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
+	if (!add_entry)
+		return false;
+
+	list_add(&add_entry->list, &msk->pm.anno_list);
+
+	add_entry->addr = *addr;
+	add_entry->sock = msk;
+	add_entry->retrans_times = 0;
+
+	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+	sk_reset_timer(sk, &add_entry->add_timer,
+		       jiffies + mptcp_get_add_addr_timeout(net));
+
+	return true;
+}
+
+static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_add_entry *entry, *tmp;
+	struct sock *sk = (struct sock *)msk;
+	LIST_HEAD(free_list);
+
+	pr_debug("msk=%p\n", msk);
+
+	spin_lock_bh(&msk->pm.lock);
+	list_splice_init(&msk->pm.anno_list, &free_list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	list_for_each_entry_safe(entry, tmp, &free_list, list) {
+		sk_stop_timer_sync(sk, &entry->add_timer);
+		kfree(entry);
+	}
+}
+
 /* path manager command handlers */
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
@@ -297,6 +646,80 @@ void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
 	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
 }
 
+static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
+					const struct mptcp_rm_list *rm_list,
+					enum linux_mptcp_mib_field rm_type)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct sock *sk = (struct sock *)msk;
+	u8 i;
+
+	pr_debug("%s rm_list_nr %d\n",
+		 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow", rm_list->nr);
+
+	msk_owned_by_me(msk);
+
+	if (sk->sk_state == TCP_LISTEN)
+		return;
+
+	if (!rm_list->nr)
+		return;
+
+	if (list_empty(&msk->conn_list))
+		return;
+
+	for (i = 0; i < rm_list->nr; i++) {
+		u8 rm_id = rm_list->ids[i];
+		bool removed = false;
+
+		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
+			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+			u8 remote_id = READ_ONCE(subflow->remote_id);
+			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
+			u8 id = subflow_get_local_id(subflow);
+
+			if ((1 << inet_sk_state_load(ssk)) &
+			    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
+				continue;
+			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
+				continue;
+			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)
+				continue;
+
+			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u\n",
+				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
+				 i, rm_id, id, remote_id, msk->mpc_endpoint_id);
+			spin_unlock_bh(&msk->pm.lock);
+			mptcp_subflow_shutdown(sk, ssk, how);
+			removed |= subflow->request_join;
+
+			/* the following takes care of updating the subflows counter */
+			mptcp_close_ssk(sk, ssk, subflow);
+			spin_lock_bh(&msk->pm.lock);
+
+			if (rm_type == MPTCP_MIB_RMSUBFLOW)
+				__MPTCP_INC_STATS(sock_net(sk), rm_type);
+		}
+
+		if (rm_type == MPTCP_MIB_RMADDR) {
+			__MPTCP_INC_STATS(sock_net(sk), rm_type);
+			if (removed && mptcp_pm_is_kernel(msk))
+				mptcp_pm_nl_rm_addr(msk, rm_id);
+		}
+	}
+}
+
+static void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
+{
+	mptcp_pm_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
+}
+
+void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
+			 const struct mptcp_rm_list *rm_list)
+{
+	mptcp_pm_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
+}
+
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list)
 {
@@ -580,6 +1003,43 @@ int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 	return mptcp_pm_set_flags(info);
 }
 
+static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
+	struct sock *sk = (struct sock *)msk;
+	unsigned int active_max_loss_cnt;
+	struct net *net = sock_net(sk);
+	unsigned int stale_loss_cnt;
+	bool slow;
+
+	stale_loss_cnt = mptcp_stale_loss_cnt(net);
+	if (subflow->stale || !stale_loss_cnt || subflow->stale_count <= stale_loss_cnt)
+		return;
+
+	/* look for another available subflow not in loss state */
+	active_max_loss_cnt = max_t(int, stale_loss_cnt - 1, 1);
+	mptcp_for_each_subflow(msk, iter) {
+		if (iter != subflow && mptcp_subflow_active(iter) &&
+		    iter->stale_count < active_max_loss_cnt) {
+			/* we have some alternatives, try to mark this subflow as idle ...*/
+			slow = lock_sock_fast(ssk);
+			if (!tcp_rtx_and_write_queues_empty(ssk)) {
+				subflow->stale = 1;
+				__mptcp_retransmit_pending_data(sk);
+				MPTCP_INC_STATS(net, MPTCP_MIB_SUBFLOWSTALE);
+			}
+			unlock_sock_fast(ssk, slow);
+
+			/* always try to push the pending data regardless of re-injections:
+			 * we can possibly use backup subflows now, and subflow selection
+			 * is cheap under the msk socket lock
+			 */
+			__mptcp_push_pending(sk, 0);
+			return;
+		}
+	}
+}
+
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 27b8daf3bc3ff550b61fc9fdbd6f728804ea43bf..e4abb94e8c0bd42533500587f5f6e88038b2db62 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -18,14 +18,6 @@
 
 static int pm_nl_pernet_id;
 
-struct mptcp_pm_add_entry {
-	struct list_head	list;
-	struct mptcp_addr_info	addr;
-	u8			retrans_times;
-	struct timer_list	add_timer;
-	struct mptcp_sock	*sock;
-};
-
 struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
@@ -41,7 +33,6 @@ struct pm_nl_pernet {
 };
 
 #define MPTCP_PM_ADDR_MAX	8
-#define ADD_ADDR_RETRANS_MAX	3
 
 static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
 {
@@ -54,77 +45,6 @@ pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
 	return pm_nl_get_pernet(sock_net((struct sock *)msk));
 }
 
-bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
-			   const struct mptcp_addr_info *b, bool use_port)
-{
-	bool addr_equals = false;
-
-	if (a->family == b->family) {
-		if (a->family == AF_INET)
-			addr_equals = a->addr.s_addr == b->addr.s_addr;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		else
-			addr_equals = ipv6_addr_equal(&a->addr6, &b->addr6);
-	} else if (a->family == AF_INET) {
-		if (ipv6_addr_v4mapped(&b->addr6))
-			addr_equals = a->addr.s_addr == b->addr6.s6_addr32[3];
-	} else if (b->family == AF_INET) {
-		if (ipv6_addr_v4mapped(&a->addr6))
-			addr_equals = a->addr6.s6_addr32[3] == b->addr.s_addr;
-#endif
-	}
-
-	if (!addr_equals)
-		return false;
-	if (!use_port)
-		return true;
-
-	return a->port == b->port;
-}
-
-void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
-{
-	addr->family = skc->skc_family;
-	addr->port = htons(skc->skc_num);
-	if (addr->family == AF_INET)
-		addr->addr.s_addr = skc->skc_rcv_saddr;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	else if (addr->family == AF_INET6)
-		addr->addr6 = skc->skc_v6_rcv_saddr;
-#endif
-}
-
-void mptcp_remote_address(const struct sock_common *skc,
-			  struct mptcp_addr_info *addr)
-{
-	addr->family = skc->skc_family;
-	addr->port = skc->skc_dport;
-	if (addr->family == AF_INET)
-		addr->addr.s_addr = skc->skc_daddr;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	else if (addr->family == AF_INET6)
-		addr->addr6 = skc->skc_v6_daddr;
-#endif
-}
-
-bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
-				   const struct mptcp_addr_info *saddr)
-{
-	struct mptcp_subflow_context *subflow;
-	struct mptcp_addr_info cur;
-	struct sock_common *skc;
-
-	list_for_each_entry(subflow, list, node) {
-		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
-
-		mptcp_local_address(skc, &cur);
-		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
-			return true;
-	}
-
-	return false;
-}
-
 static bool lookup_subflow_by_daddr(const struct list_head *list,
 				    const struct mptcp_addr_info *daddr)
 {
@@ -251,167 +171,6 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 	return true;
 }
 
-struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
-{
-	struct mptcp_pm_add_entry *entry;
-
-	lockdep_assert_held(&msk->pm.lock);
-
-	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true))
-			return entry;
-	}
-
-	return NULL;
-}
-
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
-{
-	struct mptcp_pm_add_entry *entry;
-	struct mptcp_addr_info saddr;
-	bool ret = false;
-
-	mptcp_local_address((struct sock_common *)sk, &saddr);
-
-	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
-			ret = true;
-			goto out;
-		}
-	}
-
-out:
-	spin_unlock_bh(&msk->pm.lock);
-	return ret;
-}
-
-static void mptcp_pm_add_timer(struct timer_list *timer)
-{
-	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
-	struct mptcp_sock *msk = entry->sock;
-	struct sock *sk = (struct sock *)msk;
-
-	pr_debug("msk=%p\n", msk);
-
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
-
-	if (!entry->addr.id)
-		return;
-
-	if (mptcp_pm_should_add_signal_addr(msk)) {
-		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
-		goto out;
-	}
-
-	spin_lock_bh(&msk->pm.lock);
-
-	if (!mptcp_pm_should_add_signal_addr(msk)) {
-		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
-		mptcp_pm_announce_addr(msk, &entry->addr, false);
-		mptcp_pm_add_addr_send_ack(msk);
-		entry->retrans_times++;
-	}
-
-	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
-		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
-
-	spin_unlock_bh(&msk->pm.lock);
-
-	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
-		mptcp_pm_subflow_established(msk);
-
-out:
-	__sock_put(sk);
-}
-
-struct mptcp_pm_add_entry *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       const struct mptcp_addr_info *addr, bool check_id)
-{
-	struct mptcp_pm_add_entry *entry;
-	struct sock *sk = (struct sock *)msk;
-	struct timer_list *add_timer = NULL;
-
-	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id)) {
-		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-		add_timer = &entry->add_timer;
-	}
-	if (!check_id && entry)
-		list_del(&entry->list);
-	spin_unlock_bh(&msk->pm.lock);
-
-	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
-	if (add_timer)
-		sk_stop_timer_sync(sk, add_timer);
-
-	return entry;
-}
-
-bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_addr_info *addr)
-{
-	struct mptcp_pm_add_entry *add_entry = NULL;
-	struct sock *sk = (struct sock *)msk;
-	struct net *net = sock_net(sk);
-
-	lockdep_assert_held(&msk->pm.lock);
-
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-
-	if (add_entry) {
-		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
-			return false;
-
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
-	}
-
-	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
-	if (!add_entry)
-		return false;
-
-	list_add(&add_entry->list, &msk->pm.anno_list);
-
-	add_entry->addr = *addr;
-	add_entry->sock = msk;
-	add_entry->retrans_times = 0;
-
-	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
-	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
-
-	return true;
-}
-
-void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
-{
-	struct mptcp_pm_add_entry *entry, *tmp;
-	struct sock *sk = (struct sock *)msk;
-	LIST_HEAD(free_list);
-
-	pr_debug("msk=%p\n", msk);
-
-	spin_lock_bh(&msk->pm.lock);
-	list_splice_init(&msk->pm.anno_list, &free_list);
-	spin_unlock_bh(&msk->pm.lock);
-
-	list_for_each_entry_safe(entry, tmp, &free_list, list) {
-		sk_stop_timer_sync(sk, &entry->add_timer);
-		kfree(entry);
-	}
-}
-
 /* Fill all the remote addresses into the array addrs[],
  * and return the array size.
  */
@@ -480,33 +239,6 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 	return i;
 }
 
-static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				bool prio, bool backup)
-{
-	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-	bool slow;
-
-	pr_debug("send ack for %s\n",
-		 prio ? "mp_prio" : (mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr"));
-
-	slow = lock_sock_fast(ssk);
-	if (prio) {
-		subflow->send_mp_prio = 1;
-		subflow->request_bkup = backup;
-	}
-
-	__mptcp_subflow_send_ack(ssk);
-	unlock_sock_fast(ssk, slow);
-}
-
-static void mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-			      bool prio, bool backup)
-{
-	spin_unlock_bh(&msk->pm.lock);
-	__mptcp_pm_send_ack(msk, subflow, prio, backup);
-	spin_lock_bh(&msk->pm.lock);
-}
-
 static struct mptcp_pm_addr_entry *
 __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 {
@@ -772,73 +504,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	}
 }
 
-bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
-				  const struct mptcp_addr_info *remote)
-{
-	struct mptcp_addr_info mpc_remote;
-
-	mptcp_remote_address((struct sock_common *)msk, &mpc_remote);
-	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
-}
-
-void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow, *alt = NULL;
-
-	msk_owned_by_me(msk);
-	lockdep_assert_held(&msk->pm.lock);
-
-	if (!mptcp_pm_should_add_signal(msk) &&
-	    !mptcp_pm_should_rm_signal(msk))
-		return;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		if (__mptcp_subflow_active(subflow)) {
-			if (!subflow->stale) {
-				mptcp_pm_send_ack(msk, subflow, false, false);
-				return;
-			}
-
-			if (!alt)
-				alt = subflow;
-		}
-	}
-
-	if (alt)
-		mptcp_pm_send_ack(msk, alt, false, false);
-}
-
-int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
-			      struct mptcp_addr_info *addr,
-			      struct mptcp_addr_info *rem,
-			      u8 bkup)
-{
-	struct mptcp_subflow_context *subflow;
-
-	pr_debug("bkup=%d\n", bkup);
-
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		struct mptcp_addr_info local, remote;
-
-		mptcp_local_address((struct sock_common *)ssk, &local);
-		if (!mptcp_addresses_equal(&local, addr, addr->port))
-			continue;
-
-		if (rem && rem->family != AF_UNSPEC) {
-			mptcp_remote_address((struct sock_common *)ssk, &remote);
-			if (!mptcp_addresses_equal(&remote, rem, rem->port))
-				continue;
-		}
-
-		__mptcp_pm_send_ack(msk, subflow, true, bkup);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
+void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
 {
 	if (rm_id && WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
 		/* Note: if the subflow has been closed before, this
@@ -849,80 +515,6 @@ static void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
 	}
 }
 
-static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
-					const struct mptcp_rm_list *rm_list,
-					enum linux_mptcp_mib_field rm_type)
-{
-	struct mptcp_subflow_context *subflow, *tmp;
-	struct sock *sk = (struct sock *)msk;
-	u8 i;
-
-	pr_debug("%s rm_list_nr %d\n",
-		 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow", rm_list->nr);
-
-	msk_owned_by_me(msk);
-
-	if (sk->sk_state == TCP_LISTEN)
-		return;
-
-	if (!rm_list->nr)
-		return;
-
-	if (list_empty(&msk->conn_list))
-		return;
-
-	for (i = 0; i < rm_list->nr; i++) {
-		u8 rm_id = rm_list->ids[i];
-		bool removed = false;
-
-		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
-			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-			u8 remote_id = READ_ONCE(subflow->remote_id);
-			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
-			u8 id = subflow_get_local_id(subflow);
-
-			if ((1 << inet_sk_state_load(ssk)) &
-			    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
-				continue;
-			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
-				continue;
-			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)
-				continue;
-
-			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u\n",
-				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
-				 i, rm_id, id, remote_id, msk->mpc_endpoint_id);
-			spin_unlock_bh(&msk->pm.lock);
-			mptcp_subflow_shutdown(sk, ssk, how);
-			removed |= subflow->request_join;
-
-			/* the following takes care of updating the subflows counter */
-			mptcp_close_ssk(sk, ssk, subflow);
-			spin_lock_bh(&msk->pm.lock);
-
-			if (rm_type == MPTCP_MIB_RMSUBFLOW)
-				__MPTCP_INC_STATS(sock_net(sk), rm_type);
-		}
-
-		if (rm_type == MPTCP_MIB_RMADDR) {
-			__MPTCP_INC_STATS(sock_net(sk), rm_type);
-			if (removed && mptcp_pm_is_kernel(msk))
-				mptcp_pm_nl_rm_addr(msk, rm_id);
-		}
-	}
-}
-
-void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
-{
-	mptcp_pm_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
-}
-
-static void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
-				const struct mptcp_rm_list *rm_list)
-{
-	mptcp_pm_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
-}
-
 /* Called under PM lock */
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 {
@@ -1186,43 +778,6 @@ static const struct genl_multicast_group mptcp_pm_mcgrps[] = {
 					  },
 };
 
-void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
-{
-	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
-	struct sock *sk = (struct sock *)msk;
-	unsigned int active_max_loss_cnt;
-	struct net *net = sock_net(sk);
-	unsigned int stale_loss_cnt;
-	bool slow;
-
-	stale_loss_cnt = mptcp_stale_loss_cnt(net);
-	if (subflow->stale || !stale_loss_cnt || subflow->stale_count <= stale_loss_cnt)
-		return;
-
-	/* look for another available subflow not in loss state */
-	active_max_loss_cnt = max_t(int, stale_loss_cnt - 1, 1);
-	mptcp_for_each_subflow(msk, iter) {
-		if (iter != subflow && mptcp_subflow_active(iter) &&
-		    iter->stale_count < active_max_loss_cnt) {
-			/* we have some alternatives, try to mark this subflow as idle ...*/
-			slow = lock_sock_fast(ssk);
-			if (!tcp_rtx_and_write_queues_empty(ssk)) {
-				subflow->stale = 1;
-				__mptcp_retransmit_pending_data(sk);
-				MPTCP_INC_STATS(net, MPTCP_MIB_SUBFLOWSTALE);
-			}
-			unlock_sock_fast(ssk, slow);
-
-			/* always try to push the pending data regardless of re-injections:
-			 * we can possibly use backup subflows now, and subflow selection
-			 * is cheap under the msk socket lock
-			 */
-			__mptcp_push_pending(sk, 0);
-			return;
-		}
-	}
-}
-
 static int mptcp_pm_family_to_addr(int family)
 {
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -1445,20 +1000,6 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *addr)
-{
-	struct mptcp_pm_add_entry *entry;
-
-	entry = mptcp_pm_del_add_timer(msk, addr, false);
-	if (entry) {
-		kfree(entry);
-		return true;
-	}
-
-	return false;
-}
-
 static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
 				  const struct mptcp_addr_info *addr)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f66c3d28333fc6abe4ea285207fdc0b78dbea9d8..360d8cfa52797a34f43bee817d0ff1e5c2e23219 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -996,7 +996,6 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
 				  const struct mptcp_addr_info *rem);
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
-void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
@@ -1010,10 +1009,13 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
-bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
-				  const struct mptcp_addr_info *remote);
+void mptcp_pm_send_ack(struct mptcp_sock *msk,
+		       struct mptcp_subflow_context *subflow,
+		       bool prio, bool backup);
 void mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
-void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk);
+void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
+			 const struct mptcp_rm_list *rm_list);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
@@ -1024,14 +1026,10 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 			      u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
-struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr);
 bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,

-- 
2.48.1


