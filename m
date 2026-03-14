Return-Path: <netdev+bounces-267720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAgzHvVJtWk3ywAAu9opvQ
	(envelope-from <netdev+bounces-267720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:43:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EE828CE41
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E043F302D53D
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 11:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E8324E4AF;
	Sat, 14 Mar 2026 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb+LelyH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E24205E25;
	Sat, 14 Mar 2026 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773488625; cv=none; b=lROClJAEmCHrq1/IY/tor/sJQ37JK9ujCdwB6Ycfrdg6N2zsLxoKJpsdh207p8DbjIIfdoBxOIdkpuQ7/5CQQzO/wOAngwxnp+n0ynid4dggU5j13epe8sh21kuzjCzx7C5kyDJzZA1Jlqy44bPODRwa1DCfXVbXFQSFP9cypNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773488625; c=relaxed/simple;
	bh=S3XN8pEzrzuZhx8bUg4Xm6iP8lFBGXhEWx2FunlA+qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aTTw7nYn6My+iAYsFFgJSgAL7cYgC+borgF6UhSxj3va3Fmhn7mm+GotlLI8YkIadSYAQLbv3MyRgvV7RgmyVuNU3ECsFq4/uuW8zboKPujZkInwTni3X9PdRTi2HENUnyzTe1Rfjqxr4ZKzilqyncIwdU3IGMrvOFtDDopzzjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb+LelyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D60C116C6;
	Sat, 14 Mar 2026 11:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773488625;
	bh=S3XN8pEzrzuZhx8bUg4Xm6iP8lFBGXhEWx2FunlA+qs=;
	h=From:To:Cc:Subject:Date:From;
	b=Pb+LelyHxvo4U+XAyR6SGjxzzk64s4DSCG3gf9TMK8IqEGyGikU60/bSRzPRR5iS7
	 9LbCw5csQOTE9Ama4vDh3MMt775glLAt8wwZngImtDku8d5iXiQ7E3e5XeODOEfRXe
	 PiTi+7GSYpX2WNXxkVOz8kLnIWRkMxDDhi6r5z4vzSngJNP/52FI23lVCN1zRzWglQ
	 SoX/VM1cyennKmwz1+4nFjULYTiuJCNscstPZ9N6bt9KD2KVWqH1/PEEnSGnDOFET2
	 0chN2xieijy7mUMNL8hbPaAhp3N/Zh99qOOP/nvAWmQZgaY7fCZZmV8FeU7SkSxWke
	 OxYnFTE4R92hw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v1] ptp: vmw: Convert to a platform driver
Date: Sat, 14 Mar 2026 12:43:33 +0100
Message-ID: <12883468.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267720-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: C1EE828CE41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the PTP VMware ACPI driver to a platform
one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/ptp/ptp_vmw.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 20ab05c4daa8..8510121d79d1 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/ptp_clock_kernel.h>
 #include <asm/hypervisor.h>
 #include <asm/vmware.h>
@@ -83,7 +84,7 @@ static struct ptp_clock_info ptp_vmw_clock_info = {
  * ACPI driver ops for VMware "precision clock" virtual device.
  */
 
-static int ptp_vmw_acpi_add(struct acpi_device *device)
+static int ptp_vmw_acpi_probe(struct platform_device *pdev)
 {
 	ptp_vmw_clock = ptp_clock_register(&ptp_vmw_clock_info, NULL);
 	if (IS_ERR(ptp_vmw_clock)) {
@@ -91,11 +92,11 @@ static int ptp_vmw_acpi_add(struct acpi_device *device)
 		return PTR_ERR(ptp_vmw_clock);
 	}
 
-	ptp_vmw_acpi_device = device;
+	ptp_vmw_acpi_device = ACPI_COMPANION(&pdev->dev);
 	return 0;
 }
 
-static void ptp_vmw_acpi_remove(struct acpi_device *device)
+static void ptp_vmw_acpi_remove(struct platform_device *pdev)
 {
 	ptp_clock_unregister(ptp_vmw_clock);
 }
@@ -107,12 +108,12 @@ static const struct acpi_device_id ptp_vmw_acpi_device_ids[] = {
 
 MODULE_DEVICE_TABLE(acpi, ptp_vmw_acpi_device_ids);
 
-static struct acpi_driver ptp_vmw_acpi_driver = {
-	.name = "ptp_vmw",
-	.ids = ptp_vmw_acpi_device_ids,
-	.ops = {
-		.add = ptp_vmw_acpi_add,
-		.remove	= ptp_vmw_acpi_remove
+static struct platform_driver ptp_vmw_acpi_driver = {
+	.probe = ptp_vmw_acpi_probe,
+	.remove = ptp_vmw_acpi_remove,
+	.driver = {
+		.name = "ptp_vmw_acpi",
+		.acpi_match_table = ptp_vmw_acpi_device_ids,
 	},
 };
 
@@ -120,12 +121,12 @@ static int __init ptp_vmw_init(void)
 {
 	if (x86_hyper_type != X86_HYPER_VMWARE)
 		return -1;
-	return acpi_bus_register_driver(&ptp_vmw_acpi_driver);
+	return platform_driver_register(&ptp_vmw_acpi_driver);
 }
 
 static void __exit ptp_vmw_exit(void)
 {
-	acpi_bus_unregister_driver(&ptp_vmw_acpi_driver);
+	platform_driver_unregister(&ptp_vmw_acpi_driver);
 }
 
 module_init(ptp_vmw_init);
-- 
2.51.0





