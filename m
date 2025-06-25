Return-Path: <netdev+bounces-200942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C80AE766C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8D43A967F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257871EA73;
	Wed, 25 Jun 2025 05:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScHwaS5W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D380800;
	Wed, 25 Jun 2025 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750829456; cv=none; b=qdBK07c3rxOhmWZVK0/9CuPOTsvo0KHiKmZHmCrhONlhXK1dNKe9QF+KuYcik6YAfBm41xIKPrfokQtaNqAK9NrjJu7QSBKJdbYKCP9SC7Eb++9DTJOuPEEAGB2Tr/wegHCxb07Q3i6O9RiTX58hDyn7xdCOHh73xOUnJFBX13Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750829456; c=relaxed/simple;
	bh=qkqTrWqvL045MNwIzcxOuCzXWF8cU9oUhMgOHUeD7+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MAaQDSAX/JB412XcUEMMau+whKUHQdiRsLJ8v18bsoIz/vc196MO8S6h/hjiOB1reK3WlbB9P9M9gI3SRnZduY28lkHxjIHuxRtLYaKmRNUVciaRRn8sjoT/aGl5HQYyK5t+axyxxYOmC/mhwtQCqV3pELdkZYTqAWT1Pf3N9XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScHwaS5W; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7490702fc7cso615379b3a.1;
        Tue, 24 Jun 2025 22:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750829454; x=1751434254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3evY/iE1wXVw/hvubL4CLnB0sjjyjXrMSBwjFohfH+0=;
        b=ScHwaS5WDUL3b0jbCfj7OTEn0t8mq7YOMzZ5nOGjkjuSX3GVRSta7Uv9q8zdHKkCWh
         MNmF+KdDHKpFoj2yBnPa5Eobj4gOP4qYECpIKx8/FxtTNC1aEIdMO5vurw48LdLQ8HID
         FyZnpLHMCw4eQE3QH8QMyodP8bowhPl/+hYMyE+tLcqTGR6lRY737+cnn30E3fNsgnBe
         AhLfyu6+kci7CHRWsULn1gFqwX/JzI6em7Ugb0SM7azvskuwYTlZ7BNwLks1bv5E/0N4
         dknq+d+SbXfSZeDT7wD0K9IWyE2HqFRybdEB06ouRI9MSXbb13bzEtgupNvWaoENho5A
         d9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750829454; x=1751434254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3evY/iE1wXVw/hvubL4CLnB0sjjyjXrMSBwjFohfH+0=;
        b=oSRXfmFemDtRhP5+TQmBngPMWehhvbAlgMfSdC05E4eFKpAZg53zOZwfi8n/Kh0jo+
         uQ2ahV8FbnjEoKoED13gTQ5h/wWJMqMMMeTrpIYBgz+c7XN6HgsivvWhTypV5KmnJolv
         3MTh+yc9cBmWZ82NBWDmv4loIwT8xDxtCgIipXGTw+Pj0P1iVnalFpqsqFGeZGcYetkz
         pm0/wybwN6WE82BeT0UrThtiHg6Tnz2yLy45n1hOpDUim7tLhMKvuiJp+PjrPcw14afv
         b6naTKDBbGAlyE+uCbBrjKTY8ftzG1fZlMLJdOby3DkXukRj2cpFygZR7NWjb1lXkhiJ
         iT/A==
X-Forwarded-Encrypted: i=1; AJvYcCVeytrn1MLiRtDx81WoLTZH4k7J5Zb2RYM+lpff8wxgZOF6LmMpnUGd6AkR6vR7h0VAZc830XT18dLiueQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+6a3esO4G0486I5cj64Q1LsFTfkic8y6WgCHqH2RTOZC1IRQh
	HyoxwFJRNJgfYxSa+RmKpwLbkJsGC9DrCF1PJ1FWdLA5CRQDLvqzRfYd
X-Gm-Gg: ASbGncsr//hnj3mZXZbR7dYNkZQeBpBRDymA74tgnjK996q+YuX2EXN6tKRGpThQX3S
	euIR0qByObHKrJp22xNOdEWat/57oOspMk+0pDXNCR0nDxEyWmFtTTuLhhnpcBUYYsjuXpPiQxm
	aVq8erv5mKq9tJRniYse84xniFiFb8fPEWzungJlpVjHGNLhKBiHItZoeSmtMfScovU2+aO2e+y
	f3FycFp85e5T0wdt9OKI5xNXScxzVjwI3GkTiH8uYTZgRJ56DpBHHoxF8KwWfUf2YhY4nCDd6bD
	7eX4C7+Ap/0t7uq2vKJmCorChvr4/1HDXO93x+HaztdC2H0XQiDoLQdC7swxQQ==
X-Google-Smtp-Source: AGHT+IHBdzLEkklY0D9WmBJ64Xf7XejTse4UFiLRQR7hUrfFiqMI5K/Q7/CZsR5GOmtfYhbLVMFxmw==
X-Received: by 2002:a05:6300:8e1b:b0:220:81e2:eae4 with SMTP id adf61e73a8af0-22081e2eaf6mr1165303637.39.1750829453617;
        Tue, 24 Jun 2025 22:30:53 -0700 (PDT)
Received: from deliz-1.. ([154.91.3.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e21466sm3297606b3a.49.2025.06.24.22.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 22:30:53 -0700 (PDT)
From: Deli Zhang <deli.zhang21th@gmail.com>
To: michael.chan@broadcom.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deli Zhang <deli.zhang21th@gmail.com>
Subject: [PATCH] bnxt_en: Add parameter disable_vf_bind
Date: Wed, 25 Jun 2025 13:30:05 +0800
Message-ID: <20250625053005.79845-1-deli.zhang21th@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In virtualization, VF is usually not bound by native drivers, instead
should be passthrough to VM. Most PF and VF drivers provide separate
names, e.g. "igb" and "igbvf", so that the hypervisor can control
whether to use VF devices locally. The "bnxt_en" driver is a special
case, it can drive both PF and VF devices, so here add a parameter
"disable_vf_bind" to allow users to control.

Signed-off-by: Deli Zhang <deli.zhang21th@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 41 +++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2cb3185c442c..89897182a71d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -88,6 +88,12 @@ MODULE_DESCRIPTION("Broadcom NetXtreme network driver");
 
 #define BNXT_TX_PUSH_THRESH 164
 
+#ifdef CONFIG_BNXT_SRIOV
+static bool disable_vf_bind;
+module_param(disable_vf_bind, bool, 0);
+MODULE_PARM_DESC(disable_vf_bind, "Whether to disable binding to virtual functions (VFs)");
+#endif
+
 /* indexed by enum board_idx */
 static const struct {
 	char *name;
@@ -144,7 +150,12 @@ static const struct {
 	[NETXTREME_E_P7_VF] = { "Broadcom BCM5760X Virtual Function" },
 };
 
-static const struct pci_device_id bnxt_pci_tbl[] = {
+/* The boundary between PF and VF devices in bnxt_pci_tbl */
+#ifdef CONFIG_BNXT_SRIOV
+#define FIRST_VF_DEV_ID 0x1606
+#endif
+
+static struct pci_device_id bnxt_pci_tbl[] = {
 	{ PCI_VDEVICE(BROADCOM, 0x1604), .driver_data = BCM5745x_NPAR },
 	{ PCI_VDEVICE(BROADCOM, 0x1605), .driver_data = BCM5745x_NPAR },
 	{ PCI_VDEVICE(BROADCOM, 0x1614), .driver_data = BCM57454 },
@@ -196,7 +207,7 @@ static const struct pci_device_id bnxt_pci_tbl[] = {
 	{ PCI_VDEVICE(BROADCOM, 0xd802), .driver_data = BCM58802 },
 	{ PCI_VDEVICE(BROADCOM, 0xd804), .driver_data = BCM58804 },
 #ifdef CONFIG_BNXT_SRIOV
-	{ PCI_VDEVICE(BROADCOM, 0x1606), .driver_data = NETXTREME_E_VF },
+	{ PCI_VDEVICE(BROADCOM, FIRST_VF_DEV_ID), .driver_data = NETXTREME_E_VF },
 	{ PCI_VDEVICE(BROADCOM, 0x1607), .driver_data = NETXTREME_E_VF_HV },
 	{ PCI_VDEVICE(BROADCOM, 0x1608), .driver_data = NETXTREME_E_VF_HV },
 	{ PCI_VDEVICE(BROADCOM, 0x1609), .driver_data = NETXTREME_E_VF },
@@ -17129,10 +17140,36 @@ static struct pci_driver bnxt_pci_driver = {
 #endif
 };
 
+#ifdef CONFIG_BNXT_SRIOV
+static void bnxt_vf_bind_init(void)
+{
+	s32 idx;
+
+	if (!disable_vf_bind)
+		return;
+
+	for (idx = 0; bnxt_pci_tbl[idx].device != 0; idx++) {
+		if (bnxt_pci_tbl[idx].device == FIRST_VF_DEV_ID) {
+			/* Truncate off VF devices */
+			memset(&bnxt_pci_tbl[idx], 0, sizeof(struct pci_device_id));
+			pr_info("%s: Disabled VF binding, id table offset %u",
+				DRV_MODULE_NAME, idx);
+			return;
+		}
+	}
+
+	/* Should not reach here! */
+	pr_crit("%s: Unknown VF dev id %u", DRV_MODULE_NAME, FIRST_VF_DEV_ID);
+}
+#endif
+
 static int __init bnxt_init(void)
 {
 	int err;
 
+#ifdef CONFIG_BNXT_SRIOV
+	bnxt_vf_bind_init();
+#endif
 	bnxt_debug_init();
 	err = pci_register_driver(&bnxt_pci_driver);
 	if (err) {
-- 
2.47.0


