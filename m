Return-Path: <netdev+bounces-161695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F3AA236FE
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 22:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E061884200
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25871F1513;
	Thu, 30 Jan 2025 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6qopS1g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81901A2C29
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738274287; cv=none; b=cflqKzETYUsJ/4FdeD+lAxjCkAezMO5tXn5juv0v+N6cl3o80RMk1KcrOyHZi+WEqa8UgOPuS2e52e55wFUrzFaaXV4xHtxTgWjBc7wpN4NJVdQZo4vM+Gg3tAmFErSxUAPkagI4C/tvs/8cPcqfVmrf9ftg+6IUhQls9+21LZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738274287; c=relaxed/simple;
	bh=lbfyUXhCCR3o5Q2J4+vh8DwWzWC9xj8OAuoAhTdea1M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXBzx/8jos+6YAtbpN0qjOPQQV0PXT0NA33AGOga7PF4QPYe+LiseHdOL/p2WtkbRUJfvhSlUixvr51731/67X0cuPhKcxvcsFzkIgwtEuiFYpdKPWCJguMJiA4JbTCZdf5wmnNBFAsVBxlSoUH5hAMvbilVWCEzzP2HKdlqySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6qopS1g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738274282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZGR9n2NxO5o2uz/dG2BP9wPYFCxYVeESyInJLxbGQ0=;
	b=H6qopS1gQFm02trNluJJHbtdB5Lgj3JZt1hZOl8WFxpS6MuDB2C/RR1/KALV5rIZxo3uqY
	HF448vl1KX4FHN1gfWJ0D26Z1jAZzOUxMwn/tCD5O8f2HyUM4ZlozTWC3dONJjfFRAxzAW
	NWDJsITKqnmxuDP74z6VoRoB0bjWqNE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-E9TRZP3lPXmwyJSOiYoOfA-1; Thu,
 30 Jan 2025 16:57:59 -0500
X-MC-Unique: E9TRZP3lPXmwyJSOiYoOfA-1
X-Mimecast-MFC-AGG-ID: E9TRZP3lPXmwyJSOiYoOfA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9F1E19560B1;
	Thu, 30 Jan 2025 21:57:57 +0000 (UTC)
Received: from lszubowi.redhat.com (unknown [10.22.80.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40281195E3E0;
	Thu, 30 Jan 2025 21:57:55 +0000 (UTC)
From: Lenny Szubowicz <lszubowi@redhat.com>
To: pavan.chebbi@broadcom.com,
	mchan@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	george.shuklin@gmail.com,
	andrea.fois@eventsense.it,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] tg3: Disable tg3 PCIe AER on system reboot
Date: Thu, 30 Jan 2025 16:57:54 -0500
Message-ID: <20250130215754.123346-1-lszubowi@redhat.com>
In-Reply-To: <20241129203640.54492-1-lszubowi@redhat.com>
References: <20241129203640.54492-1-lszubowi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Disable PCIe AER on the tg3 device on system reboot on a limited
list of Dell PowerEdge systems. This prevents a fatal PCIe AER event
on the tg3 device during the ACPI _PTS (prepare to sleep) method for
S5 on those systems. The _PTS is invoked by acpi_enter_sleep_state_prep()
as part of the kernel's reboot sequence as a result of commit
38f34dba806a ("PM: ACPI: reboot: Reinstate S5 for reboot").

There was an earlier fix for this problem by commit 2ca1c94ce0b6
("tg3: Disable tg3 device on system reboot to avoid triggering AER").
But it was discovered that this earlier fix caused a reboot hang
when some Dell PowerEdge servers were booted via ipxe. To address
this reboot hang, the earlier fix was essentially reverted by commit
9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF").
This re-exposed the tg3 PCIe AER on reboot problem.

This fix is not an ideal solution because the root cause of the AER
is in system firmware. Instead, it's a targeted work-around in the
tg3 driver.

Note also that the PCIe AER must be disabled on the tg3 device even
if the system is configured to use "firmware first" error handling.

V3:
   - Fix sparse warning on improper comparison of pdev->current_state
   - Adhere to netdev comment style

Fixes: 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 58 +++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 9cc8db10a8d6..5ba22fe0995f 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -55,6 +55,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/crc32poly.h>
+#include <linux/dmi.h>
 
 #include <net/checksum.h>
 #include <net/gso.h>
@@ -18192,6 +18193,50 @@ static int tg3_resume(struct device *device)
 
 static SIMPLE_DEV_PM_OPS(tg3_pm_ops, tg3_suspend, tg3_resume);
 
+/* Systems where ACPI _PTS (Prepare To Sleep) S5 will result in a fatal
+ * PCIe AER event on the tg3 device if the tg3 device is not, or cannot
+ * be, powered down.
+ */
+static const struct dmi_system_id tg3_restart_aer_quirk_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R440"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R540"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R640"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R650"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R740"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R750"),
+		},
+	},
+	{}
+};
+
 static void tg3_shutdown(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
@@ -18208,6 +18253,19 @@ static void tg3_shutdown(struct pci_dev *pdev)
 
 	if (system_state == SYSTEM_POWER_OFF)
 		tg3_power_down(tp);
+	else if (system_state == SYSTEM_RESTART &&
+		 dmi_first_match(tg3_restart_aer_quirk_table) &&
+		 pdev->current_state != PCI_D3cold &&
+		 pdev->current_state != PCI_UNKNOWN) {
+		/* Disable PCIe AER on the tg3 to avoid a fatal
+		 * error during this system restart.
+		 */
+		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
+					   PCI_EXP_DEVCTL_CERE |
+					   PCI_EXP_DEVCTL_NFERE |
+					   PCI_EXP_DEVCTL_FERE |
+					   PCI_EXP_DEVCTL_URRE);
+	}
 
 	rtnl_unlock();
 
-- 
2.47.1


