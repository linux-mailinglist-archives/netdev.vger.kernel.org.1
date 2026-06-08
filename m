Return-Path: <netdev+bounces-296653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E2RfHyL6JmpVpAIAu9opvQ
	(envelope-from <netdev+bounces-296653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:21:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4F76592CE
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:21:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Ounn0kUg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296653-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296653-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 490393275F7A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76BA3246E8;
	Mon,  8 Jun 2026 16:01:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9C30FC03
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 16:01:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934504; cv=none; b=l9a1Fjp0gI0Sj6k/D5RbWp2TarvhI4o+sS+Nn6yfOrj43xaYB1httkAO+Tec9WY6xhT6Lt5oNHZ8dQqok+LDZX/H09CMtSFMbKKXOid21fX5tjViNygZNj09K2KBl8zinshdZY4lOta98U3GiusmDx/k/gz1k8ZWNouRb+L+2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934504; c=relaxed/simple;
	bh=Z5ZlUDcIFkP5vToQQCiXgr32RTSlsqmHKPJXoFSD0A0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NH/cOoPOBbvfeZNKscGJOeZvO8YIVLiUwtCBcDKcjcTxubMPyHfDWXDCNrlPODjfvnX3EoTDXKzdXf319LH04W9qa+iXcOBUnUjyWb9K/TyeHPA+s8lqGqC9BQNujOt4Cp+pNVvRxUW5XTPYzSVUS69A82DncCMlYETp8LKah0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ounn0kUg; arc=none smtp.client-ip=91.218.175.184
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780934499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KpS7/Ea2h1L2nZprI8aCP4jTBdfOjYk1HfNx8n4wVpI=;
	b=Ounn0kUg4yPBXS+6UobnDHSKftO3LEoRUroJvlGswlwJsnv1LAOb8ZS5ekP5WTn//jES/X
	jbpBfOTPahGQaLjiKayC4YKsN7TI2pQU/3ASofIG4CUW4CZRK40EKUNswuta8xrbQvE289
	sOWtDlbrOO46V2r462vhwe6Bp9OvPGo=
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
Subject: [PATCH net v5] ptp: ocp: fix resource freeing order
Date: Mon,  8 Jun 2026 15:59:52 +0000
Message-ID: <20260608155952.240304-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
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
	FORGED_RECIPIENTS(0.00)[m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:pabeni@redhat.com,m:vladimir.oltean@nxp.com,m:rmk+kernel@armlinux.org.uk,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296653-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,redhat.com,nxp.com,armlinux.org.uk,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C4F76592CE

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
v4 -> v5:
* disable interrupts on ts0 and pps devices as well
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

Even though there is still technically a small chance that PTP_CLK_REQ_EXTTS
will be enabled again on PPS device before it is unregistered, it's
better to have this fix committed as current behavior leads to UAF and
crashes during device removals:

Jun  8 15:36:44 host  [ 1535.329384] ==================================================================
Jun  8 15:36:44 host  [ 1535.329425] BUG: KASAN: slab-use-after-free in ptp_ocp_enable+0x6ce/0x7e0 [ptp_ocp]
Jun  8 15:36:44 host  [ 1535.329455] Read of size 8 at addr ffff8881469a99d0 by task modprobe/6021
Jun  8 15:36:44 host  [ 1535.329474]
Jun  8 15:36:44 host  [ 1535.329484] CPU: 25 UID: 0 PID: 6021 Comm: modprobe Kdump: loaded Tainted: G            E       7.0.11-1.el10.x86_64 #1 PREEMPT(full)
Jun  8 15:36:44 host  [ 1535.329490] Tainted: [E]=UNSIGNED_MODULE
Jun  8 15:36:44 host  [ 1535.329491] Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 Gen10, BIOS U30 01/16/2025
Jun  8 15:36:44 host  [ 1535.329494] Call Trace:
Jun  8 15:36:44 host  [ 1535.329495]  <TASK>
Jun  8 15:36:44 host  [ 1535.329498]  dump_stack_lvl+0x56/0x80
Jun  8 15:36:44 host  [ 1535.329504]  print_report+0x174/0x4e3
Jun  8 15:36:44 host  [ 1535.329507]  ? _raw_read_unlock_irqrestore+0x50/0x50
Jun  8 15:36:44 host  [ 1535.329513]  ? kasan_save_free_info+0x37/0x50
Jun  8 15:36:44 host  [ 1535.329517]  ? kfree+0x191/0x400
Jun  8 15:36:44 host  [ 1535.329523]  ? ptp_ocp_enable+0x6ce/0x7e0 [ptp_ocp]
Jun  8 15:36:44 host  [ 1535.329529]  kasan_report+0xb5/0xe0
Jun  8 15:36:44 host  [ 1535.329533]  ? ptp_ocp_enable+0x6ce/0x7e0 [ptp_ocp]
Jun  8 15:36:44 host  [ 1535.329540]  ptp_ocp_enable+0x6ce/0x7e0 [ptp_ocp]
Jun  8 15:36:44 host  [ 1535.329546]  ? kobject_put+0x175/0x4e0
Jun  8 15:36:44 host  [ 1535.329554]  ? signal_store+0x4f0/0x4f0 [ptp_ocp]
Jun  8 15:36:44 host  [ 1535.329560]  ? kobject_put+0x5d/0x4e0
Jun  8 15:36:44 host  [ 1535.329564]  ? mutex_lock+0x82/0xd0
Jun  8 15:36:44 host  [ 1535.329569]  ? __mutex_lock_slowpath+0x10/0x10
Jun  8 15:36:44 host  [ 1535.329574]  ptp_disable_all_events+0x22a/0x2e0
Jun  8 15:36:44 host  [ 1535.329578]  ? ptp_disable_pinfunc.isra.0+0x140/0x140
Jun  8 15:36:44 host  [ 1535.329582]  ? kobject_put+0x175/0x4e0
Jun  8 15:36:44 host  [ 1535.329586]  ptp_clock_unregister+0xaf/0x210
Jun  8 15:36:44 host  [ 1535.329589]  ptp_ocp_detach+0x350/0x480 [ptp_ocp]
Jun  8 15:36:44 host  [ 1535.329596]  ptp_ocp_remove+0x14c/0x1e0 [ptp_ocp]
Jun  8 15:36:44 host  [ 1535.329604]  pci_device_remove+0x9e/0x1d0
Jun  8 15:36:44 host  [ 1535.329609]  device_release_driver_internal+0x37c/0x530
Jun  8 15:36:44 host  [ 1535.329615]  driver_detach+0xbb/0x170

---
 drivers/ptp/ptp_ocp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index beacc2ffb166..735385539b9f 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2479,8 +2479,13 @@ ptp_ocp_ts_enable(void *priv, u32 req, bool enable)
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
@@ -4867,6 +4872,22 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	ptp_ocp_detach_sysfs(bp);
 	ptp_ocp_attr_group_del(bp);
 	timer_delete_sync(&bp->watchdog);
+	/* Disable interrupts on all timestampers */
+	if (bp->ts0)
+		ptp_ocp_ts_enable(bp->ts0, 0, false);
+	if (bp->ts1)
+		ptp_ocp_ts_enable(bp->ts1, 0, false);
+	if (bp->ts2)
+		ptp_ocp_ts_enable(bp->ts2, 0, false);
+	if (bp->ts3)
+		ptp_ocp_ts_enable(bp->ts3, 0, false);
+	if (bp->ts4)
+		ptp_ocp_ts_enable(bp->ts4, 0, false);
+	if (bp->pps)
+		ptp_ocp_ts_enable(bp->pps, ~0, false);
+	if (bp->ptp)
+		ptp_clock_unregister(bp->ptp);
+	kfree(bp->ptp_info.pin_config);
 	ptp_ocp_unregister_ext(bp->ts0);
 	ptp_ocp_unregister_ext(bp->ts1);
 	ptp_ocp_unregister_ext(bp->ts2);
@@ -4884,9 +4905,6 @@ ptp_ocp_detach(struct ptp_ocp *bp)
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


