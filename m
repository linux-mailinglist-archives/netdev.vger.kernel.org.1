Return-Path: <netdev+bounces-150434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563799EA3A3
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 01:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3031618861FF
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E51208A7;
	Tue, 10 Dec 2024 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WwikU7OZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9B171D2
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733790413; cv=none; b=lYudrx9yV5Ji6TEfNmnaBby2M7YHn9Edp8Cekwk4epmmtIWP54zjnsGGapQYLh9nxhgWlEl9VWBAys4gInZF6QALgJUfqFZ3boYjyAHramPQCvZ0JbdC1oEcxuOIM3C1v1boi/6e81xGTDpgrBdPq/TJTViqT42KweEC15emdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733790413; c=relaxed/simple;
	bh=yqJgWOglJ0MBm8Mx+T+NGWfGIRW65rXSvd5SkBr5/0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFb2ul7jehsKaR3ao6orLLnXLEKfVOnwQRtuz/LDaIR00oSiToNplC/2v21XhXTExrJEQTn0NAV4af50O4zBetDZ47mETUlfslwt5WjnQI+JsUL0BOTsBOcvpCoJ+I9qetZRJjkqyiCmtLBRD9uI4wVz7OcDeOLjxmKwf3yhBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WwikU7OZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733790412; x=1765326412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yqJgWOglJ0MBm8Mx+T+NGWfGIRW65rXSvd5SkBr5/0M=;
  b=WwikU7OZlDq6qj41osavrpKXeMC0RXA+gc6kS8F52g+hNcnTX2M0XMQ8
   kphvhmUG7AGrgAGavSXN/djX6Jv2iQktv2OLQu29TanLE0OVSU+5ZATDL
   RgzLJImsZm4Nbsygv43WDLpyTdV2goPiNFQKH3uf/7ZtHpON1afXQMINX
   msBhfMfXV6Gy2fXLuUcWDWHHXOqE2wRx78451bKeJBnFYHcxG7iWWwOMq
   cxYTHzpYtK0LMURkmDGPH8H7Uf71Q5xxc4KARYLdWIv73KKw0Obf4wTaW
   +IRlmeHkbRibfu5Jt+uj8wP4mMNJip7PqznbU2dpUBXsuEXg9YRaamft9
   w==;
X-CSE-ConnectionGUID: TEPbLsI0S8Gl/j1eZRjJyA==
X-CSE-MsgGUID: x/gMJ48YTAqQs/6L1z3XjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44791418"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="44791418"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 16:26:51 -0800
X-CSE-ConnectionGUID: JHB7iXTCQaqjnahIYjBA4Q==
X-CSE-MsgGUID: GHocjKX0QGS5knfVNq/sng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="126132117"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.109.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 16:26:47 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH v1 net-next 2/6] net: napi: add CPU affinity to napi->config
Date: Mon,  9 Dec 2024 17:26:22 -0700
Message-ID: <20241210002626.366878-3-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210002626.366878-1-ahmed.zaki@intel.com>
References: <20241210002626.366878-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common task for most drivers is to remember the user's CPU affinity to
its IRQs. On each netdev reset, the driver must then re-assign the
user's setting to the IRQs.

Add CPU affinity mask to napi->config. To delegate the CPU affinity
management to the core, drivers must:
 1 - add a persistent napi config:     netif_napi_add_config()
 2 - bind an IRQ to the napi instance: netif_napi_set_irq()

the core will then make sure to use re-assign affinity to the napi's
IRQ.

The default mask set to all IRQs is all online CPUs.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 include/linux/netdevice.h |  6 ++++++
 net/core/dev.c            | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b598de335d26..9bf91c3aca8d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -350,9 +350,14 @@ struct napi_config {
 	u64 gro_flush_timeout;
 	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
+	cpumask_t affinity_mask;
 	unsigned int napi_id;
 };
 
+enum {
+	NAPIF_F_IRQ_AFFINITY		= BIT(0)
+};
+
 /*
  * Structure for NAPI scheduling similar to tasklet but with weighting
  */
@@ -394,6 +399,7 @@ struct napi_struct {
 	unsigned long		irq_flags;
 	int			index;
 	struct napi_config	*config;
+	struct irq_affinity_notify affinity_notify;
 };
 
 enum {
diff --git a/net/core/dev.c b/net/core/dev.c
index 6ef9eb401fb2..778ba27d2b83 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6699,11 +6699,35 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 }
 EXPORT_SYMBOL(netif_queue_set_napi);
 
+static void
+netif_napi_affinity_notify(struct irq_affinity_notify *notify,
+			   const cpumask_t *mask)
+{
+	struct napi_struct *napi =
+		container_of(notify, struct napi_struct, affinity_notify);
+
+	if (napi->config)
+		cpumask_copy(&napi->config->affinity_mask, mask);
+}
+
+static void
+netif_napi_affinity_release(struct kref __always_unused *ref)
+{
+}
+
 static void napi_restore_config(struct napi_struct *n)
 {
 	n->defer_hard_irqs = n->config->defer_hard_irqs;
 	n->gro_flush_timeout = n->config->gro_flush_timeout;
 	n->irq_suspend_timeout = n->config->irq_suspend_timeout;
+
+	if (n->irq > 0 && n->irq_flags & NAPIF_F_IRQ_AFFINITY) {
+		n->affinity_notify.notify = netif_napi_affinity_notify;
+		n->affinity_notify.release = netif_napi_affinity_release;
+		irq_set_affinity_notifier(n->irq, &n->affinity_notify);
+		irq_set_affinity(n->irq, &n->config->affinity_mask);
+	}
+
 	/* a NAPI ID might be stored in the config, if so use it. if not, use
 	 * napi_hash_add to generate one for us. It will be saved to the config
 	 * in napi_disable.
@@ -6720,6 +6744,8 @@ static void napi_save_config(struct napi_struct *n)
 	n->config->gro_flush_timeout = n->gro_flush_timeout;
 	n->config->irq_suspend_timeout = n->irq_suspend_timeout;
 	n->config->napi_id = n->napi_id;
+	if (n->irq > 0 && n->irq_flags & NAPIF_F_IRQ_AFFINITY)
+		irq_set_affinity_notifier(n->irq, NULL);
 	napi_hash_del(n);
 }
 
@@ -11184,7 +11210,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 {
 	struct net_device *dev;
 	size_t napi_config_sz;
-	unsigned int maxqs;
+	unsigned int maxqs, i;
 
 	BUG_ON(strlen(name) >= sizeof(dev->name));
 
@@ -11280,6 +11306,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
 	if (!dev->napi_config)
 		goto free_all;
+	for (i = 0; i < maxqs; i++)
+		cpumask_copy(&dev->napi_config[i].affinity_mask,
+			     cpu_online_mask);
 
 	strscpy(dev->name, name);
 	dev->name_assign_type = name_assign_type;
-- 
2.47.0


