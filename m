Return-Path: <netdev+bounces-203500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E4AF62AF
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C601174363
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F001D5CC6;
	Wed,  2 Jul 2025 19:31:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98892F7D18;
	Wed,  2 Jul 2025 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751484695; cv=none; b=gTk7E6ZEDlEHZo05s5Ja+U/cQQwrVrWgHcP7PNtsRiFvb0CBR5iwPBvTxsA4g01+5Z2Ffki6WQxdfx/0x2F7L/EMN/v6THJshxr4BHjL9NfK3/waPMuRj2Z6jEGAok0Au5uKGuwUiqM4EasqIdtiBguUKLiw8zBKl0MoeFFM6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751484695; c=relaxed/simple;
	bh=XpjxKMXhHrJbAkM86bUV3jYSI9PntAn8jRn+vHWr8/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqfpiMBhYykYKLni84Zj2CP6IuwdZq8nJM5a+iDMNiTC8dXnMf34nmMr/hX+okmXyuNDN26O6Ypezn6NaKP99DONqCLkoBUXJ4CQk2hjdi+eV1ybWlm1TnOBaDJlUDJ2zM4ERoRQuBEkSkhhEQZDfeu5gYRbUSenTgUewxcXkjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uX3Ad-00082C-SN; Wed, 02 Jul 2025 19:31:04 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Su Hui <suhui@nfschina.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Lee Trager <lee@trager.us>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next 5/6] eth: fbnic: Enable firmware logging
Date: Wed,  2 Jul 2025 12:12:11 -0700
Message-ID: <20250702192207.697368-6-lee@trager.us>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702192207.697368-1-lee@trager.us>
References: <20250702192207.697368-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware log buffer is enabled during probe and freed during remove.
Early versions of firmware do not support sending logs. Once the mailbox is
up driver will enable logging when supported firmware versions are detected.
Logging is disabled before the mailbox is freed.

Signed-off-by: Lee Trager <lee@trager.us>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_fw_log.c    | 28 +++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_fw_log.h    |  2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   | 21 ++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
index caedbe7844f7..38749d47cee6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
@@ -8,6 +8,31 @@
 #include "fbnic_fw.h"
 #include "fbnic_fw_log.h"

+void fbnic_fw_log_enable(struct fbnic_dev *fbd, bool send_hist)
+{
+	int err;
+
+	if (!fbnic_fw_log_ready(fbd))
+		return;
+
+	if (fbd->fw_cap.running.mgmt.version < MIN_FW_VER_CODE_HIST)
+		send_hist = false;
+
+	err = fbnic_fw_xmit_send_logs(fbd, true, send_hist);
+	if (err && err != -EOPNOTSUPP)
+		dev_warn(fbd->dev, "Unable to enable firmware logs: %d\n", err);
+}
+
+void fbnic_fw_log_disable(struct fbnic_dev *fbd)
+{
+	int err;
+
+	err = fbnic_fw_xmit_send_logs(fbd, false, false);
+	if (err && err != -EOPNOTSUPP)
+		dev_warn(fbd->dev, "Unable to disable firmware logs: %d\n",
+			 err);
+}
+
 int fbnic_fw_log_init(struct fbnic_dev *fbd)
 {
 	struct fbnic_fw_log *log = &fbd->fw_log;
@@ -26,6 +51,8 @@ int fbnic_fw_log_init(struct fbnic_dev *fbd)
 	log->data_start = data;
 	log->data_end = data + FBNIC_FW_LOG_SIZE;

+	fbnic_fw_log_enable(fbd, true);
+
 	return 0;
 }

@@ -36,6 +63,7 @@ void fbnic_fw_log_free(struct fbnic_dev *fbd)
 	if (!fbnic_fw_log_ready(fbd))
 		return;

+	fbnic_fw_log_disable(fbd);
 	INIT_LIST_HEAD(&log->entries);
 	log->size = 0;
 	vfree(log->data_start);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h
index 881ee298ede7..cb6555f40a24 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h
@@ -36,6 +36,8 @@ struct fbnic_fw_log {

 #define fbnic_fw_log_ready(_fbd)	(!!(_fbd)->fw_log.data_start)

+void fbnic_fw_log_enable(struct fbnic_dev *fbd, bool send_hist);
+void fbnic_fw_log_disable(struct fbnic_dev *fbd);
 int fbnic_fw_log_init(struct fbnic_dev *fbd);
 void fbnic_fw_log_free(struct fbnic_dev *fbd);
 int fbnic_fw_log_write(struct fbnic_dev *fbd, u64 index, u32 timestamp,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 249d3ef862d5..b70e4cadb37b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -291,6 +291,17 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto free_irqs;
 	}

+	/* Send the request to enable the FW logging to host. Note if this
+	 * fails we ignore the error and just display a message as it is
+	 * possible the FW is just too old to support the logging and needs
+	 * to be updated.
+	 */
+	err = fbnic_fw_log_init(fbd);
+	if (err)
+		dev_warn(fbd->dev,
+			 "Unable to initialize firmware log buffer: %d\n",
+			 err);
+
 	fbnic_devlink_register(fbd);
 	fbnic_dbg_fbd_init(fbd);
 	spin_lock_init(&fbd->hw_stats_lock);
@@ -365,6 +376,7 @@ static void fbnic_remove(struct pci_dev *pdev)
 	fbnic_hwmon_unregister(fbd);
 	fbnic_dbg_fbd_exit(fbd);
 	fbnic_devlink_unregister(fbd);
+	fbnic_fw_log_free(fbd);
 	fbnic_fw_free_mbx(fbd);
 	fbnic_free_irqs(fbd);

@@ -389,6 +401,8 @@ static int fbnic_pm_suspend(struct device *dev)
 	rtnl_unlock();

 null_uc_addr:
+	fbnic_fw_log_disable(fbd);
+
 	devl_lock(priv_to_devlink(fbd));

 	fbnic_fw_free_mbx(fbd);
@@ -434,6 +448,11 @@ static int __fbnic_pm_resume(struct device *dev)

 	devl_unlock(priv_to_devlink(fbd));

+	/* Only send log history if log buffer is empty to prevent duplicate
+	 * log entries.
+	 */
+	fbnic_fw_log_enable(fbd, list_empty(&fbd->fw_log.entries));
+
 	/* No netdev means there isn't a network interface to bring up */
 	if (fbnic_init_failure(fbd))
 		return 0;
@@ -455,6 +474,8 @@ static int __fbnic_pm_resume(struct device *dev)

 	return 0;
 err_free_mbx:
+	fbnic_fw_log_disable(fbd);
+
 	rtnl_unlock();
 	fbnic_fw_free_mbx(fbd);
 err_free_irqs:
--
2.47.1

