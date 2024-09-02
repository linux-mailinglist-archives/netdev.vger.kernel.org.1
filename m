Return-Path: <netdev+bounces-124283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6202A968CE0
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 19:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60D81F22C25
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587FF1C62BA;
	Mon,  2 Sep 2024 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVVkhO+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B391AB6E8
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725298768; cv=none; b=GHH70jEMS9mTVhVG4p5d/90XwOLDNJM3HIBPrhcW4q3Oqd0rqthf6LSqkrxHKPUwVee+Pjd0ruX/rN1mqEz4Ke9kDQsj9cRNIcoC+WUNESvq6rciYxZDMQtbDbtEFeIA/accltkG1bsotc3eGX7DvoWGb+p9GdgwTDsND3/o0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725298768; c=relaxed/simple;
	bh=cyYd3YPT9izSRi07Y5ijGjZdxw8e4nseqXKU/YCc8Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYD178gsW/95lSu5b1TXN9NPGcAuN6dj3MH/DWXHzZrEYzzKE0J8n5WZh8gDCjXlqtF9tqHvgNlaJfuYuwD8sSkDeRbF32DgHnJguekRG0vxgkuV26w14YXXY/81XJo0PoVXb+c9ji6/qvbCplB5Uw8Bo6dqIHA2RfM0958xa/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVVkhO+e; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bb8cf8abeso35378455e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725298762; x=1725903562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lywaRzs78Ml/XY1JK5fV3MVZlhot/sVG+Eouef2fhM0=;
        b=QVVkhO+ep3WXcyRkUkfViUbvsuriXDOxcUUwoBncuGk4PBnswn2C+7oh+zfQEC3CyZ
         vcyw5PM93xXkRNlUsFo7WWEjDNMGO2R6p3S4Ow0sNS3qzoF0+FZkdKhb21HHKYTwaGbF
         +3CeSknAHOBXpsNMvu/d3RRaSI0idVhXm6ez80QtTumusi0zI0MdW/ETda9mSlsFbLEc
         /4AGGkRrZZkZVX8mvxW6jD7GH2GqbY8qhCnvfX0+053koVS6SNpBcgRgYUdqPs3XtviV
         BBHsinchLNMIuTVlHO8ZfcCGABHLhLxTVUlSCoq7dwZbdSVlHiPIj1S+5HCtPBv3oiVE
         n++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725298762; x=1725903562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lywaRzs78Ml/XY1JK5fV3MVZlhot/sVG+Eouef2fhM0=;
        b=gSuEm+RmoMZCZ0KP9lohkbaeTdJ3Nw1NnZspUzqozthUT/M2gse4043lnffGs9TWqQ
         DfYEn2OndBuZMe0hai+su8vHO48ARH9ZK2hdMsc04Q2bdfjk4L/qyZaUxjzSx3WSpW5C
         /vVvC8WZ6O/trQfCDthFHMxk67uXXnLrCYVt6h3SvY0EnugtBTK1pHg3OyMqiMpbzQpr
         JZ+jKWE091lCQTnhRCVlwd9VJFgg4a1b1vDENUVVByH/jn2vQu+SeGavvoPTo5cW1Qfu
         nnDH6uc9EEY97nXdicN7MtlZZ+E3h2tNRFJ4WLHUAKbPcVqAfUG1P7yDNuyQ69oMdC8r
         ixqg==
X-Gm-Message-State: AOJu0Yzf6iG7ZcsAbrGRgrCA0ogeU2LM0gMQrCbCmZfVEfwtbR2HReVH
	7aC1zvK2A6hav9V7gCm5wFE2UC6lDBcXpj473qnNhYVIcSsxBbPQSFY9Tgtf
X-Google-Smtp-Source: AGHT+IGYAiH9YUhgZalTnfKmJ8IXy11wSItelOiA8ZayCcIijemFHAwh10VAZB5k393ECFzYu53KMw==
X-Received: by 2002:adf:ec43:0:b0:374:c040:b015 with SMTP id ffacd0b85a97d-374c040b2b0mr4208500f8f.57.1725298761781;
        Mon, 02 Sep 2024 10:39:21 -0700 (PDT)
Received: from localhost (fwdproxy-cln-115.fbsv.net. [2a03:2880:31ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c6543ee3sm4927604f8f.12.2024.09.02.10.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:39:21 -0700 (PDT)
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
	sdf@fomichev.me,
	jdamato@fastly.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next v3 1/2] eth: fbnic: Add ethtool support for fbnic
Date: Mon,  2 Sep 2024 10:39:06 -0700
Message-ID: <20240902173907.925023-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240902173907.925023-1-mohsin.bashr@gmail.com>
References: <20240902173907.925023-1-mohsin.bashr@gmail.com>
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
v3: Update v1 link

v2: https://lore.kernel.org/netdev/20240827205904.1944066-2-mohsin.bashr@gmail.com

v1: https://lore.kernel.org/netdev/20240822184944.3882360-1-mohsin.bashr@gmail.com
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
index 000000000000..7064dfc9f5b0
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
index 0c6e1b4c119b..8f7a2a19ddf8 100644
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
+	if (mgmt->commit[0])
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
index 571374361259..a400616a24d4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -521,6 +521,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->netdev_ops = &fbnic_netdev_ops;
 	netdev->stat_ops = &fbnic_stat_ops;
 
+	fbnic_set_ethtool_ops(netdev);
+
 	fbn = netdev_priv(netdev);
 
 	fbn->netdev = netdev;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 60199e634468..6c27da09a612 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -58,6 +58,7 @@ int fbnic_netdev_register(struct net_device *netdev);
 void fbnic_netdev_unregister(struct net_device *netdev);
 void fbnic_reset_queues(struct fbnic_net *fbn,
 			unsigned int tx, unsigned int rx);
+void fbnic_set_ethtool_ops(struct net_device *dev);
 
 void __fbnic_set_rx_mode(struct net_device *netdev);
 void fbnic_clear_rx_mode(struct net_device *netdev);
-- 
2.43.5


