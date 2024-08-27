Return-Path: <netdev+bounces-122510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BF59618E4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 22:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EE4283A70
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5D61D2F6C;
	Tue, 27 Aug 2024 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APlze0sX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F279945
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724792371; cv=none; b=cns8I6h1W8xTr0+5pT1F+PSQAjvDB+7sIWla0GU87rh92w86lxIH5KP2zBbE+OV9Qm10hk791RJyTBidfnASDLkeuv6Bc1n3vSenc4jgtcpIVA7XoVlR9Xt4oOuhT2l7a9CMQTHAruIQ3yDNj1p0doT+/4uBPlnjkK/it8Ytb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724792371; c=relaxed/simple;
	bh=F5bwrhmguNyQvNw1SlM6rC8sPjo/RzyvDErUsQs+AQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUp0CqQxTFfcT6+YN7WlQJ5cAJRLvk6BOqxbAoyFjX2haELVwqYxG8HU/qWznOw8C3kAVRVgpi1gKioy4rRxL0qg9/nFwicT47dLQbF/LghGDOYyii6GtU4TkbZDr7ipCRQC/IhFec+Otc/XuBOk4uJgnjM+QrbUQdmFcdmSVUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APlze0sX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428e1915e18so49616865e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724792368; x=1725397168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOAyTfuPnDh4RXPQiUEXnK4gtDG5dABUlp8EYn/GnI4=;
        b=APlze0sXHC+rC3bOJSMkFsM9pqskcZEtkVph+5ryKjeFX22IK52WGAWuSXMyzQovGx
         IzOvi3RdUusSvlj6xK4912gKdWJkrXnIfPdVAptk6OIivvRwBpGrSVzrtK2opI4iUtP3
         2VxurKBk9SZOjHotVeaMCj4wA3UdSqZnJuPZpbR4jIVN+mOitc3Ryr21pd7XSJBeBR2o
         KWnq9oY2pO+kywTUTlRlvmsbSBJE4PfH+TC9okfEaKH1wezsEFBu44EnddByklAAHRmK
         Fpn/XcdeSd5k54oRwkrfVQARam6+31tZx9FZZBnzVesxJPHCpZ4Iq6APz9aMIh/KGil+
         V2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724792368; x=1725397168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOAyTfuPnDh4RXPQiUEXnK4gtDG5dABUlp8EYn/GnI4=;
        b=SPrPSq9vpmeji3A9+uIXPJI6GvNV/Hr6r5ZkHJwTr//WzTnxYX0NapzN7oh3BFlYTX
         Rv4OTb2INxMauaVzxRVAk5U4p3VfNh2+08oBXpOllk3skTu9XtxK2q7439QJMM83ts/k
         6Uy7Q/Hv/pFqO+EsmYYSBAViQfuUNBSZkjjr4vuQ6Tapw1jFCril/oOJ17zB7FFxf/l0
         yC2tl6W17dilOzItR81VweNH11LVGHj4VJoVhXpG5ylZ43eugT0Z7l7WqX5sfbt81iCZ
         6BzYpech/zztJCc1b5iqkkjRJozErpl0/JDvDRNEiIGav/J4vHC/y1aBatNw1sJU8MfX
         I8UQ==
X-Gm-Message-State: AOJu0Yx+7Tz8cZSTcOWar3aKq98DiewAfqNCnhP9yEDIvd5iU6Rsap9b
	6Y3tBdNtR/F1bUKSdwig/7KjOOrIbKQNs+7iYSU3H9BpZxStEFqaHNBOMuFQ
X-Google-Smtp-Source: AGHT+IHKzUvUYOaKlO7LP0CJ0MjRj4wVDyzNCNJdvV1NRTB/ee/lJEVMu1eLWXQQnUEnHzZY6NaPjw==
X-Received: by 2002:a05:600c:4707:b0:426:62c6:4341 with SMTP id 5b1f17b1804b1-42acd57c086mr106306545e9.20.1724792366876;
        Tue, 27 Aug 2024 13:59:26 -0700 (PDT)
Received: from localhost (fwdproxy-cln-010.fbsv.net. [2a03:2880:31ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abeffe3e9sm233555435e9.43.2024.08.27.13.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:59:26 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] eth: fbnic: Add ethtool support for fbnic
Date: Tue, 27 Aug 2024 13:59:03 -0700
Message-ID: <20240827205904.1944066-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240827205904.1944066-1-mohsin.bashr@gmail.com>
References: <20240827205904.1944066-1-mohsin.bashr@gmail.com>
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
v2:
- Update the emptiness check for firmware version commit string
- Rebase to the latest

v1: https://lore.kernel.org/netdev/20240807002445.3833895-1-mohsin.bashr@gmail.com
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


