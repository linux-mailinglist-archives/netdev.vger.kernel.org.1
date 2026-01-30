Return-Path: <netdev+bounces-255206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMUGOZ3tfGmdPQIAu9opvQ
	(envelope-from <netdev+bounces-255206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:42:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7E2BD664
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 207373043BD5
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2026037C0F5;
	Fri, 30 Jan 2026 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="F4T32OAn"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8B237F0F3;
	Fri, 30 Jan 2026 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794662; cv=none; b=P5FwwbC8DyszkHygYJx1mPTy3a0j8W6zg9EulbSKfQc8Ep8vJRNRoG9VWVhg7+nZYp656S0CuRkEWUUFgBeQmrsOj7QcxL7DtbPi+5BgTzmcFmXUJB8/6pO2+gJPyPnoOX3J3S1fYH2CF5kfjv4D5V7XZPGr1RjL2/+gI9OGSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794662; c=relaxed/simple;
	bh=smOrr7rJtqJ1A/iQT/v59C5+7ftMjhEeBSqGWew1gNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZ4rStwQi/5Uxal/zwCgUeLjLvEu2n0LOlmimsCk5q6JjTnHnYihsAdTodkM3TuXEORreMn/K6z34Nll+ZI/zhAwguHjxlN1OHdEAQ6qDvMAHOOkmTeC1jZRsKmOvGBERFvxoVq0Ku0g8Xo5Gvp/kPqmqfiX9Uqc/++h/cLK7QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=F4T32OAn; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769794660; x=1801330660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FgHEkCKDX6peL0Q9VZpqqddTmjBFrZxzV6jF7iiGbxI=;
  b=F4T32OAnGcW2EvMRwD5/jHYPs7lJjxp7iAUDa81EcVUBETbrrx8DGyIg
   eWuNif7+uHKze4pGQ6ZUaC6Tt8/5tMPs6ndSRttPXQ57ACZ4+3ZaaqREZ
   3tZPnp2wwbkFIXc/pgwys4+wivN7i1d34r7i8KV3L5dq5I16Nf9WSlDrf
   h47nPLwbH1G3ANii7GFuHs1nbcpSc8GkMGwXVDUazK+vowpyZ3YiZsdSV
   sm6/ervbPRZxU7UGvha0PKwI1vhKBW55gaCY164Ifga1Sz07sdO+vaK2p
   tFY72/Tn/Z6gHguz66wos3ZYw2B9SjM2aEP0ganPgMVcM98gn4p7kMDTu
   A==;
X-CSE-ConnectionGUID: A2t4NE0ETXiyhNRzB0iUlw==
X-CSE-MsgGUID: aHBSknfIQya7DDbknB6mnQ==
X-IronPort-AV: E=Sophos;i="6.21,263,1763424000"; 
   d="scan'208";a="11720956"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 17:37:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:21098]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.224:2525] with esmtp (Farcaster)
 id edd01702-61c8-47d5-ac65-d1bd6e6f9b19; Fri, 30 Jan 2026 17:37:37 +0000 (UTC)
X-Farcaster-Flow-ID: edd01702-61c8-47d5-ac65-d1bd6e6f9b19
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:37 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:34 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Babis Chalios <mail@bchalios.io>, "Alexander
 Graf" <graf@amazon.de>, <mzxreary@0pointer.de>, Marco Cali
	<xmarcalx@amazon.co.uk>, David Woodhouse <dwmw@amazon.co.uk>, "Takahiro
 Itazuri" <itazur@amazon.com>
Subject: [PATCH v7 4/7] ptp: ptp_vmclock: Add device tree support
Date: Fri, 30 Jan 2026 17:36:03 +0000
Message-ID: <20260130173704.12575-5-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130173704.12575-1-itazur@amazon.com>
References: <20260130173704.12575-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-255206-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[itazur@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,amazon.es:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1C7E2BD664
X-Rspamd-Action: no action

From: David Woodhouse <dwmw@amazon.co.uk>

Add device tree support to the ptp_vmclock driver, allowing it to probe
via device tree in addition to ACPI.

Handle optional interrupt for clock disruption notifications, mirroring
the ACPI notification behaviour.

Although the interrupt is marked as 'optional' in the DT bindings, if
the device *advertises* the VMCLOCK_FLAG_NOTIFICATION_ABSENT then it
*should* have an interrupt. The driver will refuse to initialize if not.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
Tested-by: Takahiro Itazuri <itazur@amazon.com>
---
 drivers/ptp/ptp_vmclock.c | 67 +++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index f8b24f9e8..619c8e5a9 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -14,10 +14,13 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/init.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -524,7 +527,7 @@ vmclock_acpi_notification_handler(acpi_handle __always_unused handle,
 	wake_up_interruptible(&st->disrupt_wait);
 }
 
-static int vmclock_setup_notification(struct device *dev, struct vmclock_state *st)
+static int vmclock_setup_acpi_notification(struct device *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	acpi_status status;
@@ -537,10 +540,6 @@ static int vmclock_setup_notification(struct device *dev, struct vmclock_state *
 	if (!adev)
 		return -ENODEV;
 
-	/* The device does not support notifications. Nothing else to do */
-	if (!(le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_NOTIFICATION_PRESENT))
-		return 0;
-
 	status = acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
 					     vmclock_acpi_notification_handler,
 					     dev);
@@ -575,6 +574,55 @@ static int vmclock_probe_acpi(struct device *dev, struct vmclock_state *st)
 	return 0;
 }
 
+static irqreturn_t vmclock_of_irq_handler(int __always_unused irq, void *_st)
+{
+	struct vmclock_state *st = _st;
+
+	wake_up_interruptible(&st->disrupt_wait);
+	return IRQ_HANDLED;
+}
+
+static int vmclock_probe_dt(struct device *dev, struct vmclock_state *st)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	st->res = *res;
+
+	return 0;
+}
+
+static int vmclock_setup_of_notification(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	return devm_request_irq(dev, irq, vmclock_of_irq_handler, IRQF_SHARED,
+				"vmclock", dev->driver_data);
+}
+
+static int vmclock_setup_notification(struct device *dev,
+				      struct vmclock_state *st)
+{
+	/* The device does not support notifications. Nothing else to do */
+	if (!(le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_NOTIFICATION_PRESENT))
+		return 0;
+
+	if (has_acpi_companion(dev)) {
+		return vmclock_setup_acpi_notification(dev);
+	} else {
+		return vmclock_setup_of_notification(dev);
+	}
+}
+
 static void vmclock_remove(void *data)
 {
 	struct device *dev = data;
@@ -619,7 +667,7 @@ static int vmclock_probe(struct platform_device *pdev)
 	if (has_acpi_companion(dev))
 		ret = vmclock_probe_acpi(dev, st);
 	else
-		ret = -EINVAL; /* Only ACPI for now */
+		ret = vmclock_probe_dt(dev, st);
 
 	if (ret) {
 		dev_info(dev, "Failed to obtain physical address: %d\n", ret);
@@ -719,11 +767,18 @@ static const struct acpi_device_id vmclock_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, vmclock_acpi_ids);
 
+static const struct of_device_id vmclock_of_ids[] = {
+	{ .compatible = "amazon,vmclock", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, vmclock_of_ids);
+
 static struct platform_driver vmclock_platform_driver = {
 	.probe		= vmclock_probe,
 	.driver	= {
 		.name	= "vmclock",
 		.acpi_match_table = vmclock_acpi_ids,
+		.of_match_table = vmclock_of_ids,
 	},
 };
 
-- 
2.50.1


