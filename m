Return-Path: <netdev+bounces-292625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAxLH9sKGGpzbAgAu9opvQ
	(envelope-from <netdev+bounces-292625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:28:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 217B05EF957
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85E8D300749F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916B63ACF1E;
	Thu, 28 May 2026 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQ4W2W8H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54653A2E12
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960537; cv=none; b=BoUV0UF/wxztD5uAsd0k7HL1wv6bjLJEehf9oLKMNcxUtul2EQ6BwUbhi1e06Rub4YeUfx78ZpoKFhch9GylUXwtoR56X5By1kLU2Utusmhv/k3ERgNj9OzVRpheG2y2Ky4ZAUA9Q72dVykwU5KwShloTJn6L2hgdduyNwoZJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960537; c=relaxed/simple;
	bh=388TTXHA2bYg3pINmCqbGNJ/46zxWL3jvZ1z79Swck8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KpmWfZcPgay7yMlg2VhRGWsMeY7SQ8adOULB0aPThsMyz0i/iCfC8chGSFviUYlzSSuCPT+qjh7iJrhcd2mbVUwD9MjSq0xk2yHCWkcRf4T8efLvFUTr72mTTl22Etzxe9SK8hwwfHwKqik0uDTIXYOV3wFmqRl2YafoeKENFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQ4W2W8H; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-83659d38e38so5218256b3a.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779960535; x=1780565335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=24w+nn0UtZQy1tnWAmAuGdbzPuljPvQQ+ussDWU2L8s=;
        b=pQ4W2W8HkZtK9kpV+HOnyZbFSvjKtxPNSL9guJsBkQZo3MZZbJX1+/2p8LzbH9Smc9
         PzmN9fvEaBzkickxEAehdBp9u/ENlTMbOXplx0VhX//SZa9IxQEtOdr+8xKpIJobUwWV
         hrjR8na2sZ0UXq/jCoMjLbjzl0AORdZULERk3FwWyDg1WIW9sFcNQlnM8HvPA3zfMOqG
         VOOew4fFdzMRi86eLHy90yB/uViX3M0z/k0j00+sz09hFqb6EoHyl94E2cHFnGTWRH/H
         YXivIVg+Hwes077Up8kW6T5EO8qs04iozvQaZ9mV5bsNmJudUmSWSKNOaB4jhNnU7FQk
         8jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779960535; x=1780565335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24w+nn0UtZQy1tnWAmAuGdbzPuljPvQQ+ussDWU2L8s=;
        b=r0VFu7nu0svwbvwcQ/nAp+hJy4zRwP7L35XO/eGuTm0ftpM1JXWr5Rc7VrNTjxE2e+
         h9fHhJ77uubzN54T9+6JZsDUAKWHS2TjB7q3pOQqmKeDtbSB5h/LQxM/PeKQ/kQ2Uz7a
         3redJwLQt0Dow9x4dWZuAuPBENEqPfuDSReEHxMOSMDNwr9S7Sw+4z9Ace6FmP6CgNMV
         HGkFdqKrTQiNX2w1oHh6sj+rG1nfwk9T1jDBn50Ad74AVb3lnUdbWzBz5HP7P9LzeQrW
         KDHwxjL4XpC8K3q37FboFUXRTZeaq5vnFM9Z60BifogSmZ76eyaVYq6gezCPeexJ2V+7
         TSCw==
X-Gm-Message-State: AOJu0Yxzfh4QmU/ZNm/GUgIEKgg9e/6WciVksablrjqnKdKDTI2d86/K
	kLNvpNraQ5qgDO5H+VsiEdcrG80sEtCZCwuvopps0FQ2zdLg+hV+AzFR3B4k+iIj
X-Gm-Gg: Acq92OGwsvhq6qq5m4BGKmIJ9hMkS87OYPadeSrp3MTDFEYcG/bkYdQdiUGwoIR08Ub
	HWkcd4rl9a/LEjDxO7iBQPTptyMzL+GtpXGpRFYdUO1czGZien2KyHUKzjBWy9KNJW5D7szPgJb
	EHA7suBo4S1LBs7ce5HSTzvV7wIjtmzONVUk1Uwc/5pkWOOVi21pch1yyYy1WXW51fKvWMLWLqC
	8/dZT+ZrEr49X2CYC3ww70PgLPKdu7dQH4aQOP4jJ9GZPTFX3bhJB5wCD4w4mGFTiKqY4b/H2dX
	ZPsfqn2EJmk01Ss6+3iNvzhYHBmufg4HHSarTSJ9XHIe8Dh67haDaZv7+9TMBJGRGqGC8xqLdTT
	WfKUg+T7tWvoPBOel/Dzgya9gBYHqaHnrYymFF7/DmUj6JCwXmhhZPMDAZTdqGEeMo4F+hdMgnt
	mXb4VSht5upv08+4nSfsAuP5n28GFECTSUHXAyaDGlcqaIFkGlBQN/GpWbkxSYIYHkcoTsG90zf
	O9kBraIjrR3c52bh5yk2IpCclz5LSD1ZCvIrRvtPP898OiTxH0mgiLOe3NHCl4475tPQydRp5t5
X-Received: by 2002:a05:6a00:8c10:b0:81f:9b4c:81c0 with SMTP id d2e1a72fcca58-8415f58d727mr25206416b3a.41.1779960535125;
        Thu, 28 May 2026 02:28:55 -0700 (PDT)
Received: from bass-virtual-machine.. ([163.61.198.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70bf92asm4590713b3a.31.2026.05.28.02.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 02:28:54 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	ecree.xilinx@gmail.com
Cc: linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH] sfc: Use acquire/release for irq_soft_enabled
Date: Thu, 28 May 2026 17:28:38 +0800
Message-Id: <20260528092838.2099352-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292625-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,amd.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 217B05EF957
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

irq_soft_enabled is a lockless gate for interrupt handlers. When clear,
handlers must only acknowledge interrupts and must not touch channel state.

Channel reallocation disables this gate, swaps and initializes channel
pointers, frees old channels, and then enables the gate again. READ_ONCE()
does not provide an acquire barrier, so an IRQ handler can observe the gate
as enabled while still seeing stale channel pointers or channel state.

Use release stores when updating the gate and acquire loads in interrupt
handlers before touching channels. Keep the existing smp_wmb() after gate
updates, preserving the current ordering with event queue start and stop.

Add small helpers to document the ordering and avoid repeating barrier
comments at every caller. Without the comments, checkpatch warns about
memory barriers without comments.

Fixes: d829118705f8 ("sfc: Rework IRQ enable/disable")
Fixes: 8127d661e77f ("sfc: Add support for Solarflare SFC9100 family")
Fixes: 5a6681e22c14 ("sfc: separate out SFC4000 ("Falcon") support into new sfc-falcon driver")
Fixes: 51b35a454efd ("sfc: skeleton EF100 PF driver")
Fixes: 6e173d3b4af9 ("sfc: Copy shared files needed for Siena (part 1)")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
 drivers/net/ethernet/sfc/ef10.c               |  4 ++--
 drivers/net/ethernet/sfc/ef100_nic.c          |  2 +-
 drivers/net/ethernet/sfc/efx_channels.c       |  4 ++--
 drivers/net/ethernet/sfc/falcon/efx.c         |  4 ++--
 drivers/net/ethernet/sfc/falcon/falcon.c      |  2 +-
 drivers/net/ethernet/sfc/falcon/farch.c       |  4 ++--
 drivers/net/ethernet/sfc/falcon/net_driver.h  | 12 ++++++++++++
 drivers/net/ethernet/sfc/net_driver.h         | 12 ++++++++++++
 drivers/net/ethernet/sfc/siena/efx_channels.c |  4 ++--
 drivers/net/ethernet/sfc/siena/farch.c        |  4 ++--
 drivers/net/ethernet/sfc/siena/net_driver.h   | 12 ++++++++++++
 11 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 7e04f115bbaa..a907303497f9 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -2143,7 +2143,7 @@ static irqreturn_t efx_ef10_msi_interrupt(int irq, void *dev_id)
 	netif_vdbg(efx, intr, efx->net_dev,
 		   "IRQ %d on CPU %d\n", irq, raw_smp_processor_id());
 
-	if (likely(READ_ONCE(efx->irq_soft_enabled))) {
+	if (likely(efx_irq_soft_enabled(efx))) {
 		/* Note test interrupts */
 		if (context->index == efx->irq_level)
 			efx->last_irq_cpu = raw_smp_processor_id();
@@ -2158,7 +2158,7 @@ static irqreturn_t efx_ef10_msi_interrupt(int irq, void *dev_id)
 static irqreturn_t efx_ef10_legacy_interrupt(int irq, void *dev_id)
 {
 	struct efx_nic *efx = dev_id;
-	bool soft_enabled = READ_ONCE(efx->irq_soft_enabled);
+	bool soft_enabled = efx_irq_soft_enabled(efx);
 	struct efx_channel *channel;
 	efx_dword_t reg;
 	u32 queues;
diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/ethernet/sfc/ef100_nic.c
index 00050f786cae..7885b3a5a398 100644
--- a/drivers/net/ethernet/sfc/ef100_nic.c
+++ b/drivers/net/ethernet/sfc/ef100_nic.c
@@ -333,7 +333,7 @@ static irqreturn_t ef100_msi_interrupt(int irq, void *dev_id)
 	netif_vdbg(efx, intr, efx->net_dev,
 		   "IRQ %d on CPU %d\n", irq, raw_smp_processor_id());
 
-	if (likely(READ_ONCE(efx->irq_soft_enabled))) {
+	if (likely(efx_irq_soft_enabled(efx))) {
 		/* Note test interrupts */
 		if (context->index == efx->irq_level)
 			efx->last_irq_cpu = raw_smp_processor_id();
diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index f4dc3f3f4416..d1dc8667c645 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -972,7 +972,7 @@ int efx_soft_enable_interrupts(struct efx_nic *efx)
 
 	BUG_ON(efx->state == STATE_DISABLED);
 
-	efx->irq_soft_enabled = true;
+	efx_set_irq_soft_enabled(efx, true);
 	smp_wmb();
 
 	efx_for_each_channel(channel, efx) {
@@ -1009,7 +1009,7 @@ void efx_soft_disable_interrupts(struct efx_nic *efx)
 
 	efx_mcdi_mode_poll(efx);
 
-	efx->irq_soft_enabled = false;
+	efx_set_irq_soft_enabled(efx, false);
 	smp_wmb();
 
 	if (efx->legacy_irq)
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index 0c197b448645..e1a60e5035db 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -1460,7 +1460,7 @@ static int ef4_soft_enable_interrupts(struct ef4_nic *efx)
 
 	BUG_ON(efx->state == STATE_DISABLED);
 
-	efx->irq_soft_enabled = true;
+	ef4_set_irq_soft_enabled(efx, true);
 	smp_wmb();
 
 	ef4_for_each_channel(channel, efx) {
@@ -1493,7 +1493,7 @@ static void ef4_soft_disable_interrupts(struct ef4_nic *efx)
 	if (efx->state == STATE_DISABLED)
 		return;
 
-	efx->irq_soft_enabled = false;
+	ef4_set_irq_soft_enabled(efx, false);
 	smp_wmb();
 
 	if (efx->legacy_irq)
diff --git a/drivers/net/ethernet/sfc/falcon/falcon.c b/drivers/net/ethernet/sfc/falcon/falcon.c
index fb1d19b7c419..0c0e00412689 100644
--- a/drivers/net/ethernet/sfc/falcon/falcon.c
+++ b/drivers/net/ethernet/sfc/falcon/falcon.c
@@ -449,7 +449,7 @@ static irqreturn_t falcon_legacy_interrupt_a1(int irq, void *dev_id)
 		   "IRQ %d on CPU %d status " EF4_OWORD_FMT "\n",
 		   irq, raw_smp_processor_id(), EF4_OWORD_VAL(*int_ker));
 
-	if (!likely(READ_ONCE(efx->irq_soft_enabled)))
+	if (!likely(ef4_irq_soft_enabled(efx)))
 		return IRQ_HANDLED;
 
 	/* Check to see if we have a serious error condition */
diff --git a/drivers/net/ethernet/sfc/falcon/farch.c b/drivers/net/ethernet/sfc/falcon/farch.c
index 23d507a3820d..291165db7933 100644
--- a/drivers/net/ethernet/sfc/falcon/farch.c
+++ b/drivers/net/ethernet/sfc/falcon/farch.c
@@ -1500,7 +1500,7 @@ irqreturn_t ef4_farch_fatal_interrupt(struct ef4_nic *efx)
 irqreturn_t ef4_farch_legacy_interrupt(int irq, void *dev_id)
 {
 	struct ef4_nic *efx = dev_id;
-	bool soft_enabled = READ_ONCE(efx->irq_soft_enabled);
+	bool soft_enabled = ef4_irq_soft_enabled(efx);
 	ef4_oword_t *int_ker = efx->irq_status.addr;
 	irqreturn_t result = IRQ_NONE;
 	struct ef4_channel *channel;
@@ -1592,7 +1592,7 @@ irqreturn_t ef4_farch_msi_interrupt(int irq, void *dev_id)
 		   "IRQ %d on CPU %d status " EF4_OWORD_FMT "\n",
 		   irq, raw_smp_processor_id(), EF4_OWORD_VAL(*int_ker));
 
-	if (!likely(READ_ONCE(efx->irq_soft_enabled)))
+	if (!likely(ef4_irq_soft_enabled(efx)))
 		return IRQ_HANDLED;
 
 	/* Handle non-event-queue sources */
diff --git a/drivers/net/ethernet/sfc/falcon/net_driver.h b/drivers/net/ethernet/sfc/falcon/net_driver.h
index 7ab0db44720d..c8c00bdc17f0 100644
--- a/drivers/net/ethernet/sfc/falcon/net_driver.h
+++ b/drivers/net/ethernet/sfc/falcon/net_driver.h
@@ -1305,6 +1305,18 @@ static inline netdev_features_t ef4_supported_features(const struct ef4_nic *efx
 	return net_dev->features | net_dev->hw_features;
 }
 
+static inline void ef4_set_irq_soft_enabled(struct ef4_nic *efx, bool enabled)
+{
+	/* Publish channel state before changing the IRQ handler gate. */
+	smp_store_release(&efx->irq_soft_enabled, enabled);
+}
+
+static inline bool ef4_irq_soft_enabled(struct ef4_nic *efx)
+{
+	/* Pair with ef4_set_irq_soft_enabled() before touching channels. */
+	return smp_load_acquire(&efx->irq_soft_enabled);
+}
+
 /* Get the current TX queue insert index. */
 static inline unsigned int
 ef4_tx_queue_get_insert_index(const struct ef4_tx_queue *tx_queue)
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index b98c259f672d..a4a3ec657a71 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1731,6 +1731,18 @@ static inline void efx_xmit_hwtstamp_pending(struct sk_buff *skb)
 	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 }
 
+static inline void efx_set_irq_soft_enabled(struct efx_nic *efx, bool enabled)
+{
+	/* Publish channel state before changing the IRQ handler gate. */
+	smp_store_release(&efx->irq_soft_enabled, enabled);
+}
+
+static inline bool efx_irq_soft_enabled(struct efx_nic *efx)
+{
+	/* Pair with efx_set_irq_soft_enabled() before touching channels. */
+	return smp_load_acquire(&efx->irq_soft_enabled);
+}
+
 /* Get the max fill level of the TX queues on this channel */
 static inline unsigned int
 efx_channel_tx_fill_level(struct efx_channel *channel)
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
index 1fc343598771..ace27f6ff6ae 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -1004,7 +1004,7 @@ static int efx_soft_enable_interrupts(struct efx_nic *efx)
 
 	BUG_ON(efx->state == STATE_DISABLED);
 
-	efx->irq_soft_enabled = true;
+	efx_set_irq_soft_enabled(efx, true);
 	smp_wmb();
 
 	efx_for_each_channel(channel, efx) {
@@ -1041,7 +1041,7 @@ static void efx_soft_disable_interrupts(struct efx_nic *efx)
 
 	efx_siena_mcdi_mode_poll(efx);
 
-	efx->irq_soft_enabled = false;
+	efx_set_irq_soft_enabled(efx, false);
 	smp_wmb();
 
 	if (efx->legacy_irq)
diff --git a/drivers/net/ethernet/sfc/siena/farch.c b/drivers/net/ethernet/sfc/siena/farch.c
index 7613d7988894..208cc499c747 100644
--- a/drivers/net/ethernet/sfc/siena/farch.c
+++ b/drivers/net/ethernet/sfc/siena/farch.c
@@ -1514,7 +1514,7 @@ irqreturn_t efx_farch_fatal_interrupt(struct efx_nic *efx)
 irqreturn_t efx_farch_legacy_interrupt(int irq, void *dev_id)
 {
 	struct efx_nic *efx = dev_id;
-	bool soft_enabled = READ_ONCE(efx->irq_soft_enabled);
+	bool soft_enabled = efx_irq_soft_enabled(efx);
 	efx_oword_t *int_ker = efx->irq_status.addr;
 	irqreturn_t result = IRQ_NONE;
 	struct efx_channel *channel;
@@ -1606,7 +1606,7 @@ irqreturn_t efx_farch_msi_interrupt(int irq, void *dev_id)
 		   "IRQ %d on CPU %d status " EFX_OWORD_FMT "\n",
 		   irq, raw_smp_processor_id(), EFX_OWORD_VAL(*int_ker));
 
-	if (!likely(READ_ONCE(efx->irq_soft_enabled)))
+	if (!likely(efx_irq_soft_enabled(efx)))
 		return IRQ_HANDLED;
 
 	/* Handle non-event-queue sources */
diff --git a/drivers/net/ethernet/sfc/siena/net_driver.h b/drivers/net/ethernet/sfc/siena/net_driver.h
index 4cf556782133..a84aca72f311 100644
--- a/drivers/net/ethernet/sfc/siena/net_driver.h
+++ b/drivers/net/ethernet/sfc/siena/net_driver.h
@@ -1624,6 +1624,18 @@ static inline void efx_xmit_hwtstamp_pending(struct sk_buff *skb)
 	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 }
 
+static inline void efx_set_irq_soft_enabled(struct efx_nic *efx, bool enabled)
+{
+	/* Publish channel state before changing the IRQ handler gate. */
+	smp_store_release(&efx->irq_soft_enabled, enabled);
+}
+
+static inline bool efx_irq_soft_enabled(struct efx_nic *efx)
+{
+	/* Pair with efx_set_irq_soft_enabled() before touching channels. */
+	return smp_load_acquire(&efx->irq_soft_enabled);
+}
+
 /* Get the max fill level of the TX queues on this channel */
 static inline unsigned int
 efx_channel_tx_fill_level(struct efx_channel *channel)
-- 
2.34.1


