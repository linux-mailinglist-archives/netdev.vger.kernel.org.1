Return-Path: <netdev+bounces-121133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6392395BE74
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 20:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D196A1F24099
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 18:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472E21CC889;
	Thu, 22 Aug 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJjjhz15"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7531213A3E6
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724352596; cv=none; b=kLVlr0h+8dUVf0P3TCuyeuo/L4C4Y647R0/M0VLau452rOMccPXiYB2NhzIv0Oimu0VQ1tqRZ5oXmiXZo/inlenIp/WbE1izBwL05kAYk1qxYuW3DI3Y9grzjxHbdbOGAMEqVetBBcwmsmhMh81ciM+v+BD/OHQYcgV3PpouJ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724352596; c=relaxed/simple;
	bh=crgYWPkCLIAvbu7XvdgUs3TmZfxmtZc/vrcyBF/SvPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sVA1ZVna4h5uCKjz1Qy7PaAPjIq7+lNNWDse3KEDi5Jy2vl2y7BhxUnOCX5s0I4MF2iQqjNDpD+ZCVxqnw/8GIGg3AUv6nf25Y1NhFewb2y35XEp/MTdsUB2UOIPDPGa6OXfdd4LDm0izYhsm/BP40gjDRVlqosbNpB7BUprF9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJjjhz15; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa086b077so138102466b.0
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 11:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724352592; x=1724957392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XCfnQ9UORkj/HnNGO6eVXZ1A9tNKnGueEDqtFuXzlBc=;
        b=WJjjhz15lvXuq/F+aYu0wkeTDEzZiS+Z/mn4hzZC+LoswazyngU3wYo+A5n3WIMMse
         jhph0mwXlX8tS+sfgDVZRL3J6pkCfdWKuw+Qlb5cOGqLEWZj6F1U/3cyja/KxcH4hflH
         C5GwFrAx3qswHNcKlJgpmcBsZCcy8v8x0/7rCWeVpwHiysiexkyMx/5PyS3rAzL5YfP8
         8noSu9seHUZx6UHw/yVhn1wJPxSUXY6whvVg+j9lhYRBHbem+yW4x8X3MEo8PhVIDKAS
         9HNRtNU9Fv84qIg6EB/VsOoI0UC+lDwx+hn1zd6Ox8Qd8hl8uXR06mEPeo51lidRvdDW
         uzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724352592; x=1724957392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCfnQ9UORkj/HnNGO6eVXZ1A9tNKnGueEDqtFuXzlBc=;
        b=sfJQMgpIb5UlIgzrGeMI1CuGNz+1Xl1WTDtf7A9of0QTZdxNseUh5SEkhPOiz19/Fk
         YSYCx6hrORKI4KRvqyAKedoKwfSALsZBH0LCePeE+BeHf3PcCkTb9YPBwrHco7vpOPa1
         KvC21JnIrbL1olh6plryZHXn8dW+lAYrbMYFw3U3GZ52NjF/herON/vs6q8zOE3J+2lS
         hEIVKQtlXvs4HnZrJun8aq8Ll5GvzbumaVuhzEwUIm8JLgyeFEHQ4hAfvLCuA66IGWyh
         fvSUj0f0e/m3tBgwHOfg07ScZCXu0n3Ht58522sYAjJqtKKf2Um2q7ak5Y1Gu2g9Y2jc
         p5Zw==
X-Gm-Message-State: AOJu0Yx9PiOgkqxV0B09dSAlnTQ52fPn0Cr91JgKYi7dT8ue9iAhkWsH
	E6ahc4MhMFAKyoCwA5Nmz9WErmvXm7NMTCJdUb6TwlyTevwm6x2hApxTzQ==
X-Google-Smtp-Source: AGHT+IGUsntSc76BWJxYjTaTbZH10yNT14dBjkziOuEsKadElkaKJ3NjM6mRsJF4dAcKUm38DVlDLw==
X-Received: by 2002:a17:907:3f95:b0:a77:e55a:9e87 with SMTP id a640c23a62f3a-a866f8ed42amr514402566b.48.1724352591405;
        Thu, 22 Aug 2024 11:49:51 -0700 (PDT)
Received: from localhost (fwdproxy-cln-023.fbsv.net. [2a03:2880:31ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f47d1dfsm153102666b.149.2024.08.22.11.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:49:50 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kernel-team@meta.com,
	sanmanpradhan@meta.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next 1/2] eth: fbnic: Add ethtool support for fbnic
Date: Thu, 22 Aug 2024 11:49:43 -0700
Message-ID: <20240822184944.3882360-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ethtool ops support and enable 'get_drvinfo' for fbnic. The driver
provides firmware version information while the driver name and bus
information is provided by ethtool_get_drvinfo().

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  3 +++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 26 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 13 ++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  6 ++---
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  2 ++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  1 +
 7 files changed, 49 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index 9373b558fdc9..37cfc34a5118 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -8,6 +8,7 @@
 obj-$(CONFIG_FBNIC) += fbnic.o
 
 fbnic-y := fbnic_devlink.o \
+	   fbnic_ethtool.o \
 	   fbnic_fw.o \
 	   fbnic_irq.o \
 	   fbnic_mac.o \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index ad2689bfd6cb..28d970f81bfc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -132,6 +132,9 @@ void fbnic_free_irq(struct fbnic_dev *dev, int nr, void *data);
 void fbnic_free_irqs(struct fbnic_dev *fbd);
 int fbnic_alloc_irqs(struct fbnic_dev *fbd);
 
+void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
+				 const size_t str_sz);
+
 enum fbnic_boards {
 	fbnic_board_asic
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
new file mode 100644
index 000000000000..0dc083fd1878
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -0,0 +1,26 @@
+#include <linux/ethtool.h>
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+
+#include "fbnic.h"
+#include "fbnic_netdev.h"
+#include "fbnic_tlv.h"
+
+static void
+fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	fbnic_get_fw_ver_commit_str(fbd, drvinfo->fw_version, 
+				    sizeof(drvinfo->fw_version));
+}
+
+static const struct ethtool_ops fbnic_ethtool_ops = {
+	.get_drvinfo		= fbnic_get_drvinfo,
+};
+
+void fbnic_set_ethtool_ops(struct net_device *dev)
+{
+	dev->ethtool_ops = &fbnic_ethtool_ops;
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 0c6e1b4c119b..5825b69f4638 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -789,3 +789,16 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
 		count += (tx_mbx->head - head) % FBNIC_IPC_MBX_DESC_LEN;
 	} while (count < FBNIC_IPC_MBX_DESC_LEN && --attempts);
 }
+
+void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
+				 const size_t str_sz)
+{
+	struct fbnic_fw_ver *mgmt = &fbd->fw_cap.running.mgmt;
+	const char *delim = "";
+
+	if (strlen(mgmt->commit) > 0)
+		delim = "_";
+
+	fbnic_mk_full_fw_ver_str(mgmt->version, delim, mgmt->commit,
+				 fw_version, str_sz);
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index c65bca613665..221faf8c6756 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -53,10 +53,10 @@ int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership);
 int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll);
 void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd);
 
-#define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str)	\
+#define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str, _str_sz) \
 do {									\
 	const u32 __rev_id = _rev_id;					\
-	snprintf(_str, sizeof(_str), "%02lu.%02lu.%02lu-%03lu%s%s",	\
+	snprintf(_str, _str_sz, "%02lu.%02lu.%02lu-%03lu%s%s",	\
 		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_MAJOR, __rev_id),	\
 		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_MINOR, __rev_id),	\
 		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_PATCH, __rev_id),	\
@@ -65,7 +65,7 @@ do {									\
 } while (0)
 
 #define fbnic_mk_fw_ver_str(_rev_id, _str) \
-	fbnic_mk_full_fw_ver_str(_rev_id, "", "", _str)
+	fbnic_mk_full_fw_ver_str(_rev_id, "", "", _str, sizeof(_str))
 
 #define FW_HEARTBEAT_PERIOD		(10 * HZ)
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index b7ce6da68543..921325de8d8a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -385,6 +385,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
 	netdev->netdev_ops = &fbnic_netdev_ops;
 
+	fbnic_set_ethtool_ops(netdev);
+
 	fbn = netdev_priv(netdev);
 
 	fbn->netdev = netdev;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 6bc0ebeb8182..d1abc67f340d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -55,6 +55,7 @@ int fbnic_netdev_register(struct net_device *netdev);
 void fbnic_netdev_unregister(struct net_device *netdev);
 void fbnic_reset_queues(struct fbnic_net *fbn,
 			unsigned int tx, unsigned int rx);
+void fbnic_set_ethtool_ops(struct net_device *dev);
 
 void __fbnic_set_rx_mode(struct net_device *netdev);
 void fbnic_clear_rx_mode(struct net_device *netdev);
-- 
2.43.5


