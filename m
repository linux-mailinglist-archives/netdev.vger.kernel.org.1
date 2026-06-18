Return-Path: <netdev+bounces-300372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GI2LJsq4M2raFQYAu9opvQ
	(envelope-from <netdev+bounces-300372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:22:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDD769ECFE
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:22:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ONtpPbEe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300372-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300372-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36D3F309FCA6
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46AE3C278F;
	Thu, 18 Jun 2026 09:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65C3C9EF6
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 09:19:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774369; cv=none; b=N7AgPemZ+XMfWZu6zL5rsLHN0JKwoEGKlywjOdKtCGrIUDIFb/7Eoss56EWeXrxQ17bcV5CKcqUHkaa4qLID98pk5OcuEAZl1zxG1nyHnvIZarhOTPZ0/WmL9wz2hQO3bKyb7IFpBCVHVvSTCKHciv/LdYTbFdPK6913WSeUtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774369; c=relaxed/simple;
	bh=YsZcYLNIRb86mC37t6uUI6YCrPD8D+tXjpSe0X7m+3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qspaOIHA5uB7p5uxQy++mnwlcnC4s1APWRt5GYq2yPOLUZzQiCR6BhKXSIQtBC+9Xt+DevO6JPUbLDdWLQRhHot95s/PZX2oQinVDWe00dXJcZHEi1p1zAiHnLdfZH2Z+YX/Oe8ejctrxOMw9odT++9gtRIDsJHVGVqU1eRBfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONtpPbEe; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so338268a91.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781774364; x=1782379164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h4+bEXTWziNwy1SF67u7r8C81h/KKBqevPNZ0iuGFf4=;
        b=ONtpPbEeo3e/XnkK6DRk+/5SipzF0rXQIY1xLHM1+ol25sQ8vQ7gPp/6IMoSXQSTZ6
         AF73gGKm+p3OFafX6hdljIi398wbjoRwNNh90ASCfqghIwe9KpbLxlKHddJqV+JQYsLl
         m9yd5/ZL8tSsjQH2KbNeiPE6bHK85CYEfGgU24eRjMnmkO2jUT1bWLv6O6Sz6zllNUC6
         gnLl7KqTbafTAMHHdp4d0gXrVxlqa3ML6wQf0NP3kCTUfUDr5IRtDlu1oCWEMMPZPAVN
         e6/4zmIPlVfYHOMJB+cfiCNFURzy2jRD33CjIdYn/WqUL1lzLeRQ7h6UvXdfyjhOaCDa
         4Bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781774364; x=1782379164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4+bEXTWziNwy1SF67u7r8C81h/KKBqevPNZ0iuGFf4=;
        b=MNaiwmLxwsSViZf40f4qrOupiHhgZJpqGNZDi3+KgePXCmdI9dSkwLiNtStewsGGyl
         NzTmp9qBz5QtJHEySxJiqlWQUHUULvKG6t7y75ey3VV7Ut2gKfLSZJTfKazY96JeX94C
         +rDWAS5/zAZMHL+vJKlVgcRWQ+xyFE0Xv98Fj5WpRuQ6wXkvxahvfXHzOTxPvr787Rq3
         VbxNzVU0G4OHP6/DRcEvIj6olxPPUq0NG7JHwzquUXHvcm7KlzPoLm2sVe9lwEXn4ux2
         1oT8rd1hA8v0TPw/4TdyHOu1OCoRNCSuoBECkw2P3fvGhF7PbC+nunUsEFg2n9/F6nhm
         Bipg==
X-Gm-Message-State: AOJu0YwJUd+aEFQ2/Z2k66GePzNIpjL/AUGRebInQCMFHPOBG4OE87+D
	88/6yVEKehGqvccyyUVQm7BN4M4EdmwT1VqAWJceliOD6bs6WGpiRw4x5c7gq2Yb
X-Gm-Gg: AfdE7cnJPn8NMhcXjl0+E/ivde+UF0nKF17WrKy6d6aHp1QFqdpzaepEZLdXR9e2pSE
	EiYUI4AV29GnhNrwdyu2Hq46idkuJI8k/NdaJZWtGJRkA/gheIwCmW+nqIQE5hAq8GdxqclAZIM
	V0vKw4WaZGV+BpYSvAlPtQS0gjZSL+YlylIIIcsXNF4H7tOACl8Jiy1ZphVGDlm/2+T89l5YG/J
	L1Tm9J4PWuKI3gped0Ysy4RzZz73+eM2rXTH5AKrsIAzx+BGgLorlQTbi0Ye79xi/qJSDuUUkr8
	wO5K5kGmXVed2/O+/8BQkh09FHRAxYuvSfnxhPf3UWELAjpIEq1MB2DwzyOZP+RQnSZTGYOQrQv
	XWU43vpd2tiH8cODdPJX0Qf0gvpH+W044prqH6TECFme/Ye1BxGjJEkrr/1550YiAh+wJHgIyBf
	IuyC+o//Z390bHMPcXMx0NgqZrxPXY5TDa0G9av9VIlc20tYScGWHF7vKBC1bNv+3WBF+BknXW7
	NX6A7I6GJVxWigcUVCveGFRu5GjL6YXabrPu3SAG8qLDw==
X-Received: by 2002:a17:90b:1ccf:b0:36d:8bb4:4640 with SMTP id 98e67ed59e1d1-37c936ac828mr6588148a91.19.1781774364088;
        Thu, 18 Jun 2026 02:19:24 -0700 (PDT)
Received: from bass-virtual-machine.. ([36.112.122.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37ce7acac6dsm1088519a91.0.2026.06.18.02.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 02:19:23 -0700 (PDT)
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
	horms@kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH net v2] sfc: Use acquire/release for irq_soft_enabled
Date: Thu, 18 Jun 2026 17:16:18 +0800
Message-Id: <20260618091618.3874171-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300372-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,amd.com,gmail.com];
	FORGED_SENDER(0.00)[hanguidong02@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-net-drivers@amd.com,m:ecree.xilinx@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:baijiaju1990@gmail.com,m:hanguidong02@gmail.com,m:ecreexilinx@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBDD769ECFE

irq_soft_enabled is a lockless gate for interrupt handlers. When it is
false, handlers acknowledge interrupts but must not touch channel state.

Channel reallocation disables the gate, swaps and initializes channel
pointers, frees old channels, and then enables the gate again. Once a
handler observes irq_soft_enabled as true, it can dereference
efx->channel[] and other channel state. That observation must therefore
be ordered after the channel state was published.

READ_ONCE() does not provide that acquire ordering. The existing
smp_wmb() in the soft-enable paths also cannot provide it because it is
after the irq_soft_enabled=true store, so it cannot publish prior channel
state before the gate becomes visible.

Use a release store only when opening the software IRQ gate, and use
acquire loads in interrupt handlers before touching channels. Use
WRITE_ONCE() when closing the gate; handlers that observe false do not
touch channel state.

Keep the existing smp_wmb() after gate updates. It preserves the
previous ordering between the software IRQ gate and subsequent event
queue setup, start and stop operations, which is separate from the
release/acquire ordering added here.

Fixes: d829118705f8 ("sfc: Rework IRQ enable/disable")
Fixes: 8127d661e77f ("sfc: Add support for Solarflare SFC9100 family")
Fixes: 5a6681e22c14 ("sfc: separate out SFC4000 ("Falcon") support into new sfc-falcon driver")
Fixes: 51b35a454efd ("sfc: skeleton EF100 PF driver")
Fixes: 6e173d3b4af9 ("sfc: Copy shared files needed for Siena (part 1)")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
v2:
- Use release ordering only when enabling the software IRQ gate.
- Use WRITE_ONCE() when disabling it.
- Expand the commit message to address review comments from Jakub
  Kicinski and Edward Cree about the release pairing and the existing
  smp_wmb().
v1: https://lore.kernel.org/netdev/20260528092838.2099352-1-hanguidong02@gmail.com/
---
 drivers/net/ethernet/sfc/ef10.c               |  4 ++--
 drivers/net/ethernet/sfc/ef100_nic.c          |  2 +-
 drivers/net/ethernet/sfc/efx_channels.c       |  4 ++--
 drivers/net/ethernet/sfc/falcon/efx.c         |  4 ++--
 drivers/net/ethernet/sfc/falcon/falcon.c      |  2 +-
 drivers/net/ethernet/sfc/falcon/farch.c       |  4 ++--
 drivers/net/ethernet/sfc/falcon/net_driver.h  | 17 +++++++++++++++++
 drivers/net/ethernet/sfc/net_driver.h         | 17 +++++++++++++++++
 drivers/net/ethernet/sfc/siena/efx_channels.c |  4 ++--
 drivers/net/ethernet/sfc/siena/farch.c        |  4 ++--
 drivers/net/ethernet/sfc/siena/net_driver.h   | 17 +++++++++++++++++
 11 files changed, 65 insertions(+), 14 deletions(-)

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
index f4dc3f3f4416..103d2a02bf5f 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -972,7 +972,7 @@ int efx_soft_enable_interrupts(struct efx_nic *efx)
 
 	BUG_ON(efx->state == STATE_DISABLED);
 
-	efx->irq_soft_enabled = true;
+	efx_irq_soft_enable(efx);
 	smp_wmb();
 
 	efx_for_each_channel(channel, efx) {
@@ -1009,7 +1009,7 @@ void efx_soft_disable_interrupts(struct efx_nic *efx)
 
 	efx_mcdi_mode_poll(efx);
 
-	efx->irq_soft_enabled = false;
+	efx_irq_soft_disable(efx);
 	smp_wmb();
 
 	if (efx->legacy_irq)
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index 0c197b448645..a61cc2c84b78 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -1460,7 +1460,7 @@ static int ef4_soft_enable_interrupts(struct ef4_nic *efx)
 
 	BUG_ON(efx->state == STATE_DISABLED);
 
-	efx->irq_soft_enabled = true;
+	ef4_irq_soft_enable(efx);
 	smp_wmb();
 
 	ef4_for_each_channel(channel, efx) {
@@ -1493,7 +1493,7 @@ static void ef4_soft_disable_interrupts(struct ef4_nic *efx)
 	if (efx->state == STATE_DISABLED)
 		return;
 
-	efx->irq_soft_enabled = false;
+	ef4_irq_soft_disable(efx);
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
index 7ab0db44720d..9880fff59f9d 100644
--- a/drivers/net/ethernet/sfc/falcon/net_driver.h
+++ b/drivers/net/ethernet/sfc/falcon/net_driver.h
@@ -1305,6 +1305,23 @@ static inline netdev_features_t ef4_supported_features(const struct ef4_nic *efx
 	return net_dev->features | net_dev->hw_features;
 }
 
+static inline void ef4_irq_soft_enable(struct ef4_nic *efx)
+{
+	/* Publish channel state before opening the IRQ handler gate. */
+	smp_store_release(&efx->irq_soft_enabled, true);
+}
+
+static inline void ef4_irq_soft_disable(struct ef4_nic *efx)
+{
+	WRITE_ONCE(efx->irq_soft_enabled, false);
+}
+
+static inline bool ef4_irq_soft_enabled(struct ef4_nic *efx)
+{
+	/* Pair with ef4_irq_soft_enable() before touching channels. */
+	return smp_load_acquire(&efx->irq_soft_enabled);
+}
+
 /* Get the current TX queue insert index. */
 static inline unsigned int
 ef4_tx_queue_get_insert_index(const struct ef4_tx_queue *tx_queue)
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index b98c259f672d..c172b3504e61 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1731,6 +1731,23 @@ static inline void efx_xmit_hwtstamp_pending(struct sk_buff *skb)
 	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 }
 
+static inline void efx_irq_soft_enable(struct efx_nic *efx)
+{
+	/* Publish channel state before opening the IRQ handler gate. */
+	smp_store_release(&efx->irq_soft_enabled, true);
+}
+
+static inline void efx_irq_soft_disable(struct efx_nic *efx)
+{
+	WRITE_ONCE(efx->irq_soft_enabled, false);
+}
+
+static inline bool efx_irq_soft_enabled(struct efx_nic *efx)
+{
+	/* Pair with efx_irq_soft_enable() before touching channels. */
+	return smp_load_acquire(&efx->irq_soft_enabled);
+}
+
 /* Get the max fill level of the TX queues on this channel */
 static inline unsigned int
 efx_channel_tx_fill_level(struct efx_channel *channel)
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
index 1fc343598771..55123f8322a7 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -1004,7 +1004,7 @@ static int efx_soft_enable_interrupts(struct efx_nic *efx)
 
 	BUG_ON(efx->state == STATE_DISABLED);
 
-	efx->irq_soft_enabled = true;
+	efx_irq_soft_enable(efx);
 	smp_wmb();
 
 	efx_for_each_channel(channel, efx) {
@@ -1041,7 +1041,7 @@ static void efx_soft_disable_interrupts(struct efx_nic *efx)
 
 	efx_siena_mcdi_mode_poll(efx);
 
-	efx->irq_soft_enabled = false;
+	efx_irq_soft_disable(efx);
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
index 4cf556782133..73bc42a854e2 100644
--- a/drivers/net/ethernet/sfc/siena/net_driver.h
+++ b/drivers/net/ethernet/sfc/siena/net_driver.h
@@ -1624,6 +1624,23 @@ static inline void efx_xmit_hwtstamp_pending(struct sk_buff *skb)
 	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 }
 
+static inline void efx_irq_soft_enable(struct efx_nic *efx)
+{
+	/* Publish channel state before opening the IRQ handler gate. */
+	smp_store_release(&efx->irq_soft_enabled, true);
+}
+
+static inline void efx_irq_soft_disable(struct efx_nic *efx)
+{
+	WRITE_ONCE(efx->irq_soft_enabled, false);
+}
+
+static inline bool efx_irq_soft_enabled(struct efx_nic *efx)
+{
+	/* Pair with efx_irq_soft_enable() before touching channels. */
+	return smp_load_acquire(&efx->irq_soft_enabled);
+}
+
 /* Get the max fill level of the TX queues on this channel */
 static inline unsigned int
 efx_channel_tx_fill_level(struct efx_channel *channel)
-- 
2.34.1

