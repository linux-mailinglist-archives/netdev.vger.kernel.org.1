Return-Path: <netdev+bounces-269021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBX1HUGtumlXagIAu9opvQ
	(envelope-from <netdev+bounces-269021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:48:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8552BC4F9
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 142A13049722
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6CC3D9027;
	Wed, 18 Mar 2026 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieHyQs7G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B743D8917;
	Wed, 18 Mar 2026 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841443; cv=none; b=h7qh4PhQx2i1LCGViu8JcbuqCKvMhzyfJMBel7rCLoAmWAbPQeSEBWN2kvKHp/tudB4UKrlA4rRrKfd78w0iwwGo9Q4fw5/NoquwKIjCDesSsTyb1Cr66Mxqn4n4eh1WoLDkarUD7K6Pff8jbPKgVyOWSNDMz9T2qa/jwGCYoSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841443; c=relaxed/simple;
	bh=trAQf7hV5ZPnfdrp8wqAugv9ikSXYxyDoELp///NIuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YeneeD+lyyEmiW9/P3giVDvWmvKly7J1129JtLOKxCUFg5NUrQdWCEnemoDMGjCau1zQtEJTHkPbiCITSS59/RGh0nDuX4kvz1UqQp3soZqfgBRBKxIOyggcdloeKrQ9m4umTZ7x7Q5GVdeAOT6Agvm6mtqTl1UK1D25G33tnfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieHyQs7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7098EC2BC87;
	Wed, 18 Mar 2026 13:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773841442;
	bh=trAQf7hV5ZPnfdrp8wqAugv9ikSXYxyDoELp///NIuo=;
	h=From:To:Cc:Subject:Date:From;
	b=ieHyQs7Gq2+ijMerPe1beSREqAGDUgv8P6J71kjErAkx7Bcd+tB6DAkUDqaHJNYfS
	 MUjfdW1ZiyEtQ7Db9PtZAv4fS5W2W/0NTmEbw45985kBDzRfdvG4Jgm/PYeY066LPM
	 7MZ8hFOKC3rh31OgDSEFRWNCsU49TaQg1bLi4e2lOCIPiYdC65wzGMWKGqXkSt5MTz
	 ObUejPQ6mb045O/mMc29hcdx+FJ64G9GuKXDY4wcjxPVPi+r7jiF8h5/6W79MxcpBm
	 ltn+M+KYtzFEVlb8Km22Mx3ubzrnaWXv3J/GK/LfMvyann1RJBbhZ81zLbFmzgn2pV
	 pQiIB+3DxJ87A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2] net: fjes: Drop fjes_acpi_driver and rework initialization
Date: Wed, 18 Mar 2026 14:43:55 +0100
Message-ID: <12857407.O9o76ZdvQC@rafael.j.wysocki>
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
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269021-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pdevinfo.name:url,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: CA8552BC4F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The ACPI driver interface used by the Fujitsu Extended Socket (fjes)
Network Device driver is redundant because its only role is to create
a platform device the fjes platform driver can bind to, which can be
done already at the module initialization time.

Namely, acpi_find_extended_socket_device() looks for the requisite ACPI
device object anyway and it may as well check its resources, and the
platform device can be created when the ACPI object in question
has been found (and it can be freed when the module is unloaded).

Moreover, as a rule, it is better to avoid binding drivers directly to
ACPI device objects [1].

Accordingly, drop fjes_acpi_driver, adjust the module initialization
and exit code as per the above and set the fwnode for the fjes platform
device to point to the corresponding ACPI device object as its ACPI
companion.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Add platform device unregistration to the rollback path in
   fjes_init_module, as per
https://lore.kernel.org/linux-acpi/CAJZ5v0g9BinHfQDS6hUvVHdLxDPvbv7ck=m1Bqa=+C3iE+vgxw@mail.gmail.com/

---
 drivers/net/fjes/fjes_main.c | 120 +++++++++++++++--------------------
 1 file changed, 50 insertions(+), 70 deletions(-)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index b63965d9a1ba..1f0f38980549 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -111,56 +111,6 @@ fjes_get_acpi_resource(struct acpi_resource *acpi_res, void *data)
 	return AE_OK;
 }
 
-static struct resource fjes_resource[] = {
-	DEFINE_RES_MEM(0, 1),
-	DEFINE_RES_IRQ(0)
-};
-
-static int fjes_acpi_add(struct acpi_device *device)
-{
-	struct platform_device *plat_dev;
-	acpi_status status;
-
-	if (!is_extended_socket_device(device))
-		return -ENODEV;
-
-	if (acpi_check_extended_socket_status(device))
-		return -ENODEV;
-
-	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-				     fjes_get_acpi_resource, fjes_resource);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	/* create platform_device */
-	plat_dev = platform_device_register_simple(DRV_NAME, 0, fjes_resource,
-						   ARRAY_SIZE(fjes_resource));
-	if (IS_ERR(plat_dev))
-		return PTR_ERR(plat_dev);
-
-	device->driver_data = plat_dev;
-
-	return 0;
-}
-
-static void fjes_acpi_remove(struct acpi_device *device)
-{
-	struct platform_device *plat_dev;
-
-	plat_dev = (struct platform_device *)acpi_driver_data(device);
-	platform_device_unregister(plat_dev);
-}
-
-static struct acpi_driver fjes_acpi_driver = {
-	.name = DRV_NAME,
-	.class = DRV_NAME,
-	.ids = fjes_acpi_ids,
-	.ops = {
-		.add = fjes_acpi_add,
-		.remove = fjes_acpi_remove,
-	},
-};
-
 static int fjes_setup_resources(struct fjes_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
@@ -1470,43 +1420,81 @@ static struct platform_driver fjes_driver = {
 	.remove = fjes_remove,
 };
 
+struct fjes_acpi_walk_context {
+	struct acpi_device *adev;
+	struct resource resources[2];
+};
+
 static acpi_status
 acpi_find_extended_socket_device(acpi_handle obj_handle, u32 level,
 				 void *context, void **return_value)
 {
+	struct fjes_acpi_walk_context *fjes_context = context;
 	struct acpi_device *device;
-	bool *found = context;
+	acpi_status status;
 
-	device = acpi_fetch_acpi_dev(obj_handle);
+	device = acpi_get_acpi_dev(obj_handle);
 	if (!device)
 		return AE_OK;
 
 	if (strcmp(acpi_device_hid(device), ACPI_MOTHERBOARD_RESOURCE_HID))
-		return AE_OK;
+		goto skip;
 
 	if (!is_extended_socket_device(device))
-		return AE_OK;
+		goto skip;
 
 	if (acpi_check_extended_socket_status(device))
-		return AE_OK;
+		goto skip;
+
+	status = acpi_walk_resources(obj_handle, METHOD_NAME__CRS,
+				     fjes_get_acpi_resource, fjes_context->resources);
+	if (ACPI_FAILURE(status))
+		goto skip;
+
+	fjes_context->adev = device;
 
-	*found = true;
 	return AE_CTRL_TERMINATE;
+
+skip:
+	acpi_dev_put(device);
+	return AE_OK;
 }
 
+static struct platform_device *fjes_plat_dev;
+
 /* fjes_init_module - Driver Registration Routine */
 static int __init fjes_init_module(void)
 {
-	bool found = false;
+	struct fjes_acpi_walk_context fjes_context = {
+		.adev = NULL,
+		.resources = {
+			DEFINE_RES_MEM(0, 1),
+			DEFINE_RES_IRQ(0)
+		}
+	};
+	struct platform_device_info pdevinfo;
 	int result;
 
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, ACPI_UINT32_MAX,
-			    acpi_find_extended_socket_device, NULL, &found,
+			    acpi_find_extended_socket_device, NULL, &fjes_context,
 			    NULL);
-
-	if (!found)
+	if (!fjes_context.adev)
 		return -ENODEV;
 
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+
+	pdevinfo.name = DRV_NAME;
+	pdevinfo.res = fjes_context.resources;
+	pdevinfo.num_res = ARRAY_SIZE(fjes_context.resources);
+	pdevinfo.fwnode = acpi_fwnode_handle(fjes_context.adev);
+
+	fjes_plat_dev = platform_device_register_full(&pdevinfo);
+
+	acpi_dev_put(fjes_context.adev);
+
+	if (IS_ERR(fjes_plat_dev))
+		return PTR_ERR(fjes_plat_dev);
+
 	pr_info("%s - version %s - %s\n",
 		fjes_driver_string, fjes_driver_version, fjes_copyright);
 
@@ -1515,19 +1503,11 @@ static int __init fjes_init_module(void)
 	result = platform_driver_register(&fjes_driver);
 	if (result < 0) {
 		fjes_dbg_exit();
+		platform_device_unregister(fjes_plat_dev);
 		return result;
 	}
 
-	result = acpi_bus_register_driver(&fjes_acpi_driver);
-	if (result < 0)
-		goto fail_acpi_driver;
-
 	return 0;
-
-fail_acpi_driver:
-	platform_driver_unregister(&fjes_driver);
-	fjes_dbg_exit();
-	return result;
 }
 
 module_init(fjes_init_module);
@@ -1535,9 +1515,9 @@ module_init(fjes_init_module);
 /* fjes_exit_module - Driver Exit Cleanup Routine */
 static void __exit fjes_exit_module(void)
 {
-	acpi_bus_unregister_driver(&fjes_acpi_driver);
 	platform_driver_unregister(&fjes_driver);
 	fjes_dbg_exit();
+	platform_device_unregister(fjes_plat_dev);
 }
 
 module_exit(fjes_exit_module);
-- 
2.51.0





