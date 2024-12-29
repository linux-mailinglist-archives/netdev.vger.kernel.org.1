Return-Path: <netdev+bounces-154450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390589FDFF1
	for <lists+netdev@lfdr.de>; Sun, 29 Dec 2024 17:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9D91882587
	for <lists+netdev@lfdr.de>; Sun, 29 Dec 2024 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A06197A92;
	Sun, 29 Dec 2024 16:47:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0BD15350B;
	Sun, 29 Dec 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.82.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735490837; cv=none; b=SWKkVvrgpQQ7atF1N0uhBBFQqgq9/RiBhA3opvpiT3hkegZ6M2X6Yyx847g+7217rBPWxh9suOrLbeMc9qBIb1S307KgWENdq+4EDyfOcFVamHCTZxSWtk393c0KTYzmqpGgSHGNa5M6xhjJhPwoGT2gxcRtXUA3HMkQJXXrh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735490837; c=relaxed/simple;
	bh=b/wRZcXxqhZDTx5RE0Wyu+5eHOS2vvEoKnzvvbG4YKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oD2mxe+GOorawpIlI/ygmiQOcRS8TElujWhu8s4nJ/3797Ey5qlMdco/u/HmU/QBSWaAXwE7DNqGwLZUywZ5qdN9OoLxb2NJhNT8olGtvxA+nWEQKg4ZBvu/lC6Rx1uM4NqMV55yoqwfrKjfFtzKMJNR+oMMW0BlmCoDtbqhRiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=vps-ovh.mhejs.net; arc=none smtp.client-ip=145.239.82.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1tRwRb-00000004nnV-3ALc;
	Sun, 29 Dec 2024 17:47:11 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: M Chetan Kumar <m.chetan.kumar@intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: wwan: iosm: Fix hibernation by re-binding the driver around it
Date: Sun, 29 Dec 2024 17:46:59 +0100
Message-ID: <ea5c805559e842077734a6c7695dd60467c1ef12.1735490770.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <8b19125a825f9dcdd81c667c1e5c48ba28d505a6.1735490770.git.mail@maciej.szmigiero.name>
References: <8b19125a825f9dcdd81c667c1e5c48ba28d505a6.1735490770.git.mail@maciej.szmigiero.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: mhej@vps-ovh.mhejs.net

Currently, the driver is seriously broken with respect to the
hibernation (S4): after image restore the device is back into
IPC_MEM_EXEC_STAGE_BOOT (which AFAIK means bootloader stage) and needs
full re-launch of the rest of its firmware, but the driver restore
handler treats the device as merely sleeping and just sends it a
wake-up command.

This wake-up command times out but device nodes (/dev/wwan*) remain
accessible.
However attempting to use them causes the bootloader to crash and
enter IPC_MEM_EXEC_STAGE_CD_READY stage (which apparently means "a crash
dump is ready").

It seems that the device cannot be re-initialized from this crashed
stage without toggling some reset pin (on my test platform that's
apparently what the device _RST ACPI method does).

While it would theoretically be possible to rewrite the driver to tear
down the whole MUX / IPC layers on hibernation (so the bootloader does
not crash from improper access) and then re-launch the device on
restore this would require significant refactoring of the driver
(believe me, I've tried), since there are quite a few assumptions
hard-coded in the driver about the device never being partially
de-initialized (like channels other than devlink cannot be closed,
for example).
Probably this would also need some programming guide for this hardware.

Considering that the driver seems orphaned [1] and other people are
hitting this issue too [2] fix it by simply unbinding the PCI driver
before hibernation and re-binding it after restore, much like
USB_QUIRK_RESET_RESUME does for USB devices that exhibit a similar
problem.

Tested on XMM7360 in HP EliteBook 855 G7 both with s2idle (which uses
the existing suspend / resume handlers) and S4 (which uses the new code).

[1]: https://lore.kernel.org/all/c248f0b4-2114-4c61-905f-466a786bdebb@leemhuis.info/
[2]:
https://github.com/xmm7360/xmm7360-pci/issues/211#issuecomment-1804139413

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/net/wwan/iosm/iosm_ipc_pcie.c | 57 ++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
index 04517bd3325a..fe5981a27a10 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
@@ -6,6 +6,7 @@
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 #include <net/rtnetlink.h>
 
 #include "iosm_ipc_imem.h"
@@ -448,7 +449,61 @@ static struct pci_driver iosm_ipc_driver = {
 	},
 	.id_table = iosm_ipc_ids,
 };
-module_pci_driver(iosm_ipc_driver);
+
+static bool pci_registered;
+
+static int pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
+{
+	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE) {
+		if (pci_registered) {
+			pci_unregister_driver(&iosm_ipc_driver);
+			pci_registered = false;
+		}
+	} else if (mode == PM_POST_HIBERNATION || mode == PM_POST_RESTORE) {
+		if (!pci_registered) {
+			int ret;
+
+			ret = pci_register_driver(&iosm_ipc_driver);
+			if (ret) {
+				pr_err(KBUILD_MODNAME ": unable to re-register PCI driver: %d\n",
+				       ret);
+			} else {
+				pci_registered = true;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static struct notifier_block pm_notifier = {
+	.notifier_call = pm_notify,
+};
+
+static int __init iosm_ipc_driver_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&iosm_ipc_driver);
+	if (ret)
+		return ret;
+
+	pci_registered = true;
+
+	register_pm_notifier(&pm_notifier);
+
+	return 0;
+}
+module_init(iosm_ipc_driver_init);
+
+static void __exit iosm_ipc_driver_exit(void)
+{
+	if (pci_registered)
+		pci_unregister_driver(&iosm_ipc_driver);
+
+	unregister_pm_notifier(&pm_notifier);
+}
+module_exit(iosm_ipc_driver_exit);
 
 int ipc_pcie_addr_map(struct iosm_pcie *ipc_pcie, unsigned char *data,
 		      size_t size, dma_addr_t *mapping, int direction)

