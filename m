Return-Path: <netdev+bounces-199734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AA4AE19AC
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A88217CFE4
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8324285411;
	Fri, 20 Jun 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W90dgTwB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6B229B27;
	Fri, 20 Jun 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417906; cv=none; b=Bfkw3VeRg0dsJr0XEByPEYYYLynIwOHe8PpNnK/ji2G2LRsJ2meOZsfdHOl9Mrt8cAxTV2CX30JES+rqTcRsTH479wwiOYL8kPTFmM4bkOGUJ9WsCx7rVl4pcynJtA7V0oLvw+2MfaFqda3bvJU6hKge9lc4ap3lDK1JeQ+w5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417906; c=relaxed/simple;
	bh=5X5JisUrRK/k3YVJmaiudJluyTdp1KylB9TqvN8D1LY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Eiqv2OTuLR6FgayCyMbNtWlvbJUtF+x/MNxoSSKJFfBxmlUSh9fYekksW4u1ZP56JYMHXfODmf9ZkF4NCAC0zKMRaXYGi7AtJXwy2jLnE8ZwoDAudUvxWwmOWle7G6PXqwxEDep9KSLvWMmNCuc3wtE2FKWrYwK3Qveuywy4FqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W90dgTwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9588EC4CEEE;
	Fri, 20 Jun 2025 11:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750417906;
	bh=5X5JisUrRK/k3YVJmaiudJluyTdp1KylB9TqvN8D1LY=;
	h=From:To:Cc:Subject:Date:From;
	b=W90dgTwB6eCGhJ8arE2TPezjW/8Lnf+JBLF+y839X7btEpKNtA+jUneqroPdCAhLI
	 i0QC3ceKzfoJX67GKMx9TZ5qIzkuSCJPJz2qfezbnq7363g6tI7m1rSRMHv7qrUxA+
	 7xe+ZGTmeK7LkBAnV7XDLr3MWQ54mlADQ7DoUWjBoYqmUdFjWSr+5p7mtamp1urwM5
	 SxCiAlC4f6w2eJaq1dnH67mb8hdRt5Q7vazQcBZPUioGFspHZA1mrTmNJtFIOrwBTS
	 cKC5QrEr3Lj3YCnCF9z1V4Sd+GxK8HTeAsAr2ALm/L7DuBH7Oyw57On/B6tdFO6c5j
	 VilAvsqOtjHeA==
From: Arnd Bergmann <arnd@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ethernet: intel: fix building with large NR_CPUS
Date: Fri, 20 Jun 2025 13:11:17 +0200
Message-Id: <20250620111141.3365031-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

With large values of CONFIG_NR_CPUS, three Intel ethernet drivers fail to
compile like:

In function ‘i40e_free_q_vector’,
    inlined from ‘i40e_vsi_alloc_q_vectors’ at drivers/net/ethernet/intel/i40e/i40e_main.c:12112:3:
  571 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
include/linux/rcupdate.h:1084:17: note: in expansion of macro ‘BUILD_BUG_ON’
 1084 |                 BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >= 4096);    \
drivers/net/ethernet/intel/i40e/i40e_main.c:5113:9: note: in expansion of macro ‘kfree_rcu’
 5113 |         kfree_rcu(q_vector, rcu);
      |         ^~~~~~~~~

The problem is that the 'rcu' member in 'q_vector' is too far from the start
of the structure. Move this member before the CPU mask instead, in all three
drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h | 2 +-
 drivers/net/ethernet/intel/i40e/i40e.h   | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 6119a4108838..757a6fd81b7b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -187,6 +187,7 @@ struct fm10k_q_vector {
 	u32 __iomem *itr;	/* pointer to ITR register for this vector */
 	u16 v_idx;		/* index of q_vector within interface array */
 	struct fm10k_ring_container rx, tx;
+	struct rcu_head rcu;	/* to avoid race with update stats on free */
 
 	struct napi_struct napi;
 	cpumask_t affinity_mask;
@@ -195,7 +196,6 @@ struct fm10k_q_vector {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dbg_q_vector;
 #endif /* CONFIG_DEBUG_FS */
-	struct rcu_head rcu;	/* to avoid race with update stats on free */
 
 	/* for dynamic allocation of rings associated with this q_vector */
 	struct fm10k_ring ring[] ____cacheline_internodealigned_in_smp;
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 54d5fdc303ca..91aa88366c05 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -944,6 +944,7 @@ struct i40e_q_vector {
 
 	u16 v_idx;		/* index in the vsi->q_vector array. */
 	u16 reg_idx;		/* register index of the interrupt */
+	struct rcu_head rcu;	/* to avoid race with update stats on free */
 
 	struct napi_struct napi;
 
@@ -956,7 +957,6 @@ struct i40e_q_vector {
 	cpumask_t affinity_mask;
 	struct irq_affinity_notify affinity_notify;
 
-	struct rcu_head rcu;	/* to avoid race with update stats on free */
 	char name[I40E_INT_NAME_STR_LEN];
 	bool arm_wb_state;
 	bool in_busy_poll;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index c6772cd2d802..c6cfab0ff9d3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -505,11 +505,11 @@ struct ixgbe_q_vector {
 				 * represents the vector for this ring */
 	u16 itr;		/* Interrupt throttle rate written to EITR */
 	struct ixgbe_ring_container rx, tx;
+	struct rcu_head rcu;	/* to avoid race with update stats on free */
 
 	struct napi_struct napi;
 	cpumask_t affinity_mask;
 	int numa_node;
-	struct rcu_head rcu;	/* to avoid race with update stats on free */
 	char name[IFNAMSIZ + 9];
 
 	/* for dynamic allocation of rings associated with this q_vector */
-- 
2.39.5


