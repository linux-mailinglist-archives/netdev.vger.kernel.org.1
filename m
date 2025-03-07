Return-Path: <netdev+bounces-172896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A1BA56699
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1B33B42A0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4849218592;
	Fri,  7 Mar 2025 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7lKJDp2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03A21ADA7;
	Fri,  7 Mar 2025 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346545; cv=none; b=DkElnWisXPp/ZabGYLHCcVa1QButVGOpRWRF1zHNCJ01KdWnITTcp8qI+ry5kpbdVinS/ZFCe6JENdiXANiFQKI/LtSmFcOMZBQaCUSo1TkQpqBdXPms+qzJCX3YlC0AHhOWmKAjd6Wf8HuT7MhpKHBGYnPpuiyUNAOULFi0PWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346545; c=relaxed/simple;
	bh=L59p0ieFp5sfW21N/LIxELWgoma4jNugO6Oc6bDKwUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=REh5l6QgcmKdESd82/6tgQIdD2Dyg9z1sf0NwC3kAdxTUN+aXaauBSxixrE3ACP1CXXGg+rJVfnD26GKMt83NXQUmTVwYPICPe69WThR6EPWhOfVMgS+7JF5D2qWBz9+f5ATsEE5cVkVSoZYLWoa7/EbGCf0y+uPJ0zfaBHLLBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7lKJDp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B33EC4CEE7;
	Fri,  7 Mar 2025 11:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346545;
	bh=L59p0ieFp5sfW21N/LIxELWgoma4jNugO6Oc6bDKwUI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G7lKJDp26EysanZaFOT6MudO+YXn0fdMxtT70ZdbdB1g5fSy3vLB2B2djqJQMlA6n
	 a6RZw2CBQNC1tCdyFSROp7Nxyt8qeatAdQ19KP+wlhI7c62Oj0Qvib7lV7q4CdlTMK
	 zZtRKMNLi09N3ecO33dzoSpYEwdWuWp1r1Iwr+rd4YqMj/gLHTy2mRuYUiCFKsSh2z
	 NK6MADcYzvwn4t+LEi9QBWq/QQfpyE8iIraM0/b5qkij9CQ2QIOb653UVmGYO0hknN
	 +HOZBVG5GVnLnX6iSr3MG1amIhPt0gb2QHlwgJGE/m5EXJMsZrGeO8gVmh263cy1Mj
	 r0W+tyCLAzmMw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Mar 2025 12:21:54 +0100
Subject: [PATCH net-next 10/15] mptcp: pm: worker: split in-kernel and
 common tasks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-10-abef20ada03b@kernel.org>
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4728; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=L59p0ieFp5sfW21N/LIxELWgoma4jNugO6Oc6bDKwUI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbRn8x8UOfkZK1CLpl1AaA1ZmIiRU5N3DCzp
 kI4wFRB386JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0QAKCRD2t4JPQmmg
 c3emEACYXddO+sIKof9ei0hHFzuTPAIPBiLnQ5ad1ZBu5imL7eVQPGcCEdf9VzQW0E+ErJY4jjm
 DlaY+NgSvSqvq8vRJynFxnKfE8qJigJfmGm//bBPkusySIWfwUWHNM6dfj+2aY1aTMA8vs205gQ
 W1Ncor9P6LHvq7/l9zA6YfjLNjNDRW1bmuElAu81NwyRlQOPiWcwr+lnCFGwmmEDBUO8Cp2JO41
 ZjUwnTyYpHlYhSNAq/TC5Y4K9bUomCJCPUCerAMC9LTI7Ns0FhpyJhIpCbSxRHpl1epqAiOgPOa
 zavAvSqLdAAXLonlRGjhQ+C+lCCpZYJYdSb/1QA1pHLI3140xrc7tnmCPh5c0WP4hqLsjyCuRIJ
 Ow6yieA2qKoebHcg5Ll+r/PAbWSX3x1TTKAGpmDF6aQoCdn7eegg9oivl1G+a4XM4ZYGJTK/7gT
 DcEw/GkBKpSc/Do0fwieazXyuxBTGhP42/k+LWxPe4B6ZKTcMHiOgr6DwEYVv1amYllRE+hds03
 RUsZyEroXolN32yygKpreczaentICx1OEZFasDg9rb/7jx+PA68vblwKEzv5jMZwJ/29xH+CTlB
 z28vQ6m3+tZwwzR9uJ0G9KqXZehh79R5Y0xrMOzaGoRAqf2dexK2cWmqxmNHK0eFaXwvekKdS7e
 3Xzn54+XZPDE3pg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To make it clear what actions are in-kernel PM specific and which ones
are not and done for all PMs, e.g. sending ADD_ADDR and close associated
subflows when a RM_ADDR is received.

The behavioural is changed a bit: MPTCP_PM_ADD_ADDR_RECEIVED is now
treated after MPTCP_PM_ADD_ADDR_SEND_ACK and MPTCP_PM_RM_ADDR_RECEIVED,
but that should not change anything in practice.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 25 +++++++++++++++++++++++++
 net/mptcp/pm_netlink.c | 23 +++--------------------
 net/mptcp/protocol.h   |  2 ++
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 17f99924dfa0ee307cd10beea90465daf7c84aed..ddf9d0dc6274535b7d061c0c3b3258ec7dc7576c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -599,6 +599,31 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 #endif
 }
 
+void mptcp_pm_worker(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	msk_owned_by_me(msk);
+
+	if (!(pm->status & MPTCP_PM_WORK_MASK))
+		return;
+
+	spin_lock_bh(&msk->pm.lock);
+
+	pr_debug("msk=%p status=%x\n", msk, pm->status);
+	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
+		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
+		mptcp_pm_addr_send_ack(msk);
+	}
+	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
+		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
+		mptcp_pm_rm_addr_recv(msk);
+	}
+	__mptcp_pm_kernel_worker(msk);
+
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 void mptcp_pm_destroy(struct mptcp_sock *msk)
 {
 	mptcp_pm_free_anno_list(msk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 781831c506918cf3c4b93549cefa1a54373935bf..37986208b9c0aac48d9a7b29fb37e11e947f0d66 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -912,7 +912,7 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 	}
 }
 
-static void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
+void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
 {
 	mptcp_pm_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
 }
@@ -923,30 +923,15 @@ static void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
 	mptcp_pm_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
 }
 
-void mptcp_pm_worker(struct mptcp_sock *msk)
+/* Called under PM lock */
+void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	msk_owned_by_me(msk);
-
-	if (!(pm->status & MPTCP_PM_WORK_MASK))
-		return;
-
-	spin_lock_bh(&msk->pm.lock);
-
-	pr_debug("msk=%p status=%x\n", msk, pm->status);
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
 	}
-	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
-		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
-		mptcp_pm_addr_send_ack(msk);
-	}
-	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
-		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
-		mptcp_pm_rm_addr_recv(msk);
-	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
 		mptcp_pm_nl_fully_established(msk);
@@ -955,8 +940,6 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
 		mptcp_pm_nl_subflow_established(msk);
 	}
-
-	spin_unlock_bh(&msk->pm.lock);
 }
 
 static bool address_use_port(struct mptcp_pm_addr_entry *entry)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0013b68a2731ed13cbbd817870c33f6f7f6d0b40..d4725b32aa567806ebf720347ecae80e22169828 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1010,6 +1010,7 @@ void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
 				  const struct mptcp_addr_info *remote);
 void mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
+void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
@@ -1149,6 +1150,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
+void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);

-- 
2.48.1


