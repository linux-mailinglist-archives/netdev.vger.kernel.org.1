Return-Path: <netdev+bounces-290878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPRWMIiAEGrdYQYAu9opvQ
	(envelope-from <netdev+bounces-290878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 18:12:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 284855B76EA
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 18:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 365D13001858
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E76D37A485;
	Fri, 22 May 2026 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="maTTj/96"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64493451DA
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466204; cv=none; b=dMTcekL+7FK0pR/HaRmJ+ZIG1emtjOe/MXf8uF/clAy9c/NefgXzh12x9H39E388LnV30zC03lYZDuWQRR7KgQxp0hhB8Z2AmC2RDjH/Ov1/C3Ba48T5CTWcl/s8Ds6UV4MjKry182UmMydlBOCsU+DstKnkQx6Cn/dwCep8Oi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466204; c=relaxed/simple;
	bh=MMG1MNPy8IQUkFt1D4krNlctGXzorIA28COqeqEdV+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TlbMysFqQnwbB9iZcrJIhQ6mDjia3p40pVHvRX1G9kObM5lPY/4QXApez1CBooFpdx1TanfgPpNfLQWEtlJl46cWV3sWYJqoiyOvxblTBAybqOPDa5HpWYz4Z0sU2ZSPMi12WU1vIAabnFojPjQ5Sw3veSmQFrgNC9sSjcg7rbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=maTTj/96; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779466199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X6JpBixHdNPpiBXG7bHfdGKDLHJKCPORLWgGNAnqsXQ=;
	b=maTTj/96bennUlQOMSIQcS7T4kgPvnszGApYCJsdkZo5cMl1i6NlhBFNeL8rslUqIF8Cjr
	eiYixtNWwCU6jjGnW4lYeoZhOTK6wT8lssiZXQQ1GNrRY417D+A4jo2hT9dtvRrlKsJfkf
	OsGOOu2SI4t+a1Es92Pg/PKRwsYSuAE=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v4] ptp: ocp: fix resource freeing order
Date: Fri, 22 May 2026 16:09:03 +0000
Message-ID: <20260522160903.2659871-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290878-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,redhat.com,nxp.com,armlinux.org.uk,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 284855B76EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable
events") added a call to ptp_disable_all_events() which changes the
configuration of pins if they support EXTTS events. In ptp_ocp_detach()
pins resources are freed before ptp_clock_unregister() and it leads to
use-after-free during driver removal. Fix it by changing the order of
free/unregister calls. To avoid irq handler running on the other core
while ptp device unregistering, call synchronize_irq() after HW is
configured to stop producing irqs and no irqs are in-flight.

Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable events")
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
v3 -> v4:
* address issues flagged by Sashiko by adding synchronize_irq() after
* disabling HW irq
v2 -> v3:
* fix code issue in v2
v1 -> v2:
* on v1 sashiko mentioned that some IRQs may fire after bp->ptp freed.
  it looks like a false positive, because ptp_clock_unregister() will
  explicitly disable all EXTTS channels before destroying ptp_clock
  structure. But there is a possibility of timestampers being active
  without PTP_PF_EXTTS function set. It can be done through sysfs files
  and it will change pins configuration directly, but can only be done
  for TS1..TS4. Disable them explicitly after detaching sysfs files.
---
 drivers/ptp/ptp_ocp.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index d88ab2f86b1b..12e1642c677a 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2216,8 +2216,13 @@ ptp_ocp_ts_enable(void *priv, u32 req, bool enable)
 		iowrite32(1, &reg->intr_mask);
 		iowrite32(1, &reg->intr);
 	} else {
+		int irq_vec = pci_irq_vector(bp->pdev, ext->irq_vec);
+
 		iowrite32(0, &reg->intr_mask);
 		iowrite32(0, &reg->enable);
+		ioread32(&reg->intr_mask);
+		if (irq_vec > 0)
+			synchronize_irq(irq_vec);
 	}
 
 	return 0;
@@ -4558,6 +4563,18 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	ptp_ocp_detach_sysfs(bp);
 	ptp_ocp_attr_group_del(bp);
 	timer_delete_sync(&bp->watchdog);
+	/* Disable interrupts on all timestampers */
+	if (bp->ts1)
+		ptp_ocp_ts_enable(bp->ts1, 0, false);
+	if (bp->ts2)
+		ptp_ocp_ts_enable(bp->ts2, 0, false);
+	if (bp->ts3)
+		ptp_ocp_ts_enable(bp->ts3, 0, false);
+	if (bp->ts4)
+		ptp_ocp_ts_enable(bp->ts4, 0, false);
+	if (bp->ptp)
+		ptp_clock_unregister(bp->ptp);
+	kfree(bp->ptp_info.pin_config);
 	ptp_ocp_unregister_ext(bp->ts0);
 	ptp_ocp_unregister_ext(bp->ts1);
 	ptp_ocp_unregister_ext(bp->ts2);
@@ -4575,9 +4592,6 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 		clk_hw_unregister_fixed_rate(bp->i2c_clk);
 	if (bp->n_irqs)
 		pci_free_irq_vectors(bp->pdev);
-	if (bp->ptp)
-		ptp_clock_unregister(bp->ptp);
-	kfree(bp->ptp_info.pin_config);
 	device_unregister(&bp->dev);
 }
 
-- 
2.47.3


