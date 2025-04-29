Return-Path: <netdev+bounces-186611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A347A9FE1A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 02:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56911A8602E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82A5BE5E;
	Tue, 29 Apr 2025 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="kw3uv6ez"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B3D8F5B
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745885192; cv=none; b=B1aS2VRTMyaSH6L7c+lXi6gSqm45F7bMNDYhZafVVysnqc/jteTwNrKQ90Z6kbWCqQohHhusvfwTPEjEhMCNzdoktYYHnEzCC9elf6t3k+hEoChQng3EKSjYyRzQw4gOnyikjwt+MPXlv3C2zGqgWJsBBnsm5cKQySFX95j1vEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745885192; c=relaxed/simple;
	bh=O+/bT7I8W+O8RP0vTxVEYDKlCjtjtVB4CmMDk0strXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfPfFbTBmUKgo3RJCiuBHBRsJrcf8JaEcM7dvxSISnYjaOGIZUQmJeaPBg0KZQ9JfoKu1N0TciA9uGLDSpOPXnNu1PmS75AMQ2vtwxqJG6NABTGgIv94hmeckDT1QieiLBe5dUYsviHRNWFOvg3lvkfWnW7uX+OzsIWljbQjMGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=kw3uv6ez; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so4299732a12.3
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 17:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745885190; x=1746489990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NikWCt1H1T7DXqsbNaODz1pzIkI2F8Xu7nGloeD2Vls=;
        b=kw3uv6ezLlG3rVoACIJYfquoF9O/SyQ4V4GR0O0/yFFMxITey5BZYkOyTavui4fCnE
         TXd2vOzFIIHiqg1jWnYvEg155eY6HcHUjuqN15mRAR2nBopK8l+/e5XCdICx+zsFhU/7
         P19ZukRJ0fvSK57XXp2UtorM74DGESewMTuQOXEM5/Hz46C1e/FnsB+EyhKmi/am6SJt
         FMufV2Gx0zK8MkBGmneuL6Jha/8KMuG8mUnp1vqNyC0pM4vhalcRkYzczrs9e8qVvp/S
         ZbHaxXJvMLGvHCw73daPHYonlAfmupxlT8s+qeo7FpDzCDuaK+pAFpBArHRYwXwYUL4R
         92OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745885190; x=1746489990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NikWCt1H1T7DXqsbNaODz1pzIkI2F8Xu7nGloeD2Vls=;
        b=s2kHqoIDU4emmINKLW5nZLvgynnJKPLZDhIwISwSJQxkKp9/R+pFhtjtmce3oLOPRG
         HG1GIbyK80w+FbEkzImdCRKs2uyjjPa7nzJXE3ZudiXSsPhvBmb0sPcK/4iD6t4Yy+vQ
         jDK67FI516Z1OsD5qbkiBRomWqspXHUyvcJqqSjIzRstTsW2lvUDF7yknjQ+rA8Vvop0
         izciyJOZ5CJeqNLy10BO+BwYjj+qZi7xKmYvjYHHW6F9kgxyrOXKMYq1heAfinkMHidU
         +ZJUs6IQ7HPzfHHkqQAJTgf3d895Uv/b9P6H9rbxIjYUG1Fgzisod7gI2zXBDH/jeMGb
         86qA==
X-Gm-Message-State: AOJu0YzK+3dpbhWWZxE0BI4kLUn8cyeqSldIzEc5u9J7P1ZdbfXCa++Z
	4DNFOl0jItiriIzBZZjkO4y1uRYZnuVZZnverVTU7MoG8IdUMsYNNPu+6T9tw+yaRvRWgFFEemI
	E
X-Gm-Gg: ASbGncvDkB6/VHK2v01uLMNyRyMtcqR1hfHf0B1JK224BKtKvcLZ0e77wlq2nE1IMvg
	335GZWs22pWfZEV/P1XmAnzpPMxNE51Fga4EDY/1j8ihwusU+treL3c3wgTolDJUv7Pz08kfc1S
	IfJcVniRh2cYJyItr89ToiWC1f0Dk5ukMHcfOXrVkIxOkk7FnF7u3OFhzYvI2vmuqgNOpHQaw5V
	z9uWFs1/+F4utg6n62zmorG/XmJ2JKVvYVEeESEwU1wHQCcLURC2YYR8vcjz1RPMMpAJGoMQFUj
	KbDl1O/cNzYMVHaU6QFgMxRwdQ==
X-Google-Smtp-Source: AGHT+IFOA0o9AZrLXBysLTjquwdM2r5v9Z7eDR5HNaM//FHz8Q35BR8dVbggV12IJBYGn0bkT9L7WA==
X-Received: by 2002:a17:90a:8c0c:b0:30a:255c:9c89 with SMTP id 98e67ed59e1d1-30a255ca124mr239824a91.19.1745885190443;
        Mon, 28 Apr 2025 17:06:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f77689d6sm7944858a91.29.2025.04.28.17.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 17:06:30 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1] bnxt_en: add debugfs file for restarting rx queues
Date: Mon, 28 Apr 2025 17:06:27 -0700
Message-ID: <20250429000627.1654039-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a debugfs file that resets an Rx queue using
netdev_rx_queue_restart(). Useful for testing and debugging.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../net/ethernet/broadcom/bnxt/bnxt_debugfs.c | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
index 127b7015f676..e62a3ff2ffdd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
@@ -10,6 +10,7 @@
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <net/netdev_rx_queue.h>
 #include "bnxt_hsi.h"
 #include <linux/dim.h>
 #include "bnxt.h"
@@ -61,6 +62,48 @@ static const struct file_operations debugfs_dim_fops = {
 	.read = debugfs_dim_read,
 };
 
+static ssize_t debugfs_reset_rx_write(struct file *filep,
+				      const char __user *buffer,
+				      size_t count, loff_t *ppos)
+{
+	unsigned int ring_nr;
+	struct bnxt *bp;
+	char buf[10];
+	ssize_t ret;
+	int rc;
+
+	if (*ppos != 0)
+		return 0;
+
+	if (count >= sizeof(buf))
+		return -ENOSPC;
+
+	ret = copy_from_user(buf, buffer, count);
+	if (ret)
+		return -EFAULT;
+	buf[count] = '\0';
+
+	sscanf(buf, "%u", &ring_nr);
+
+	bp = filep->private_data;
+	if (ring_nr > bp->rx_nr_rings)
+		return -EINVAL;
+
+	netdev_lock(bp->dev);
+	rc = netdev_rx_queue_restart(bp->dev, ring_nr);
+	netdev_unlock(bp->dev);
+	if (rc)
+		return rc;
+
+	return count;
+}
+
+static const struct file_operations debugfs_reset_rx_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = debugfs_reset_rx_write,
+};
+
 static void debugfs_dim_ring_init(struct dim *dim, int ring_idx,
 				  struct dentry *dd)
 {
@@ -86,6 +129,8 @@ void bnxt_debug_dev_init(struct bnxt *bp)
 		if (cpr && bp->bnapi[i]->rx_ring)
 			debugfs_dim_ring_init(&cpr->dim, i, dir);
 	}
+
+	debugfs_create_file("reset_rx", 0600, bp->debugfs_pdev, bp, &debugfs_reset_rx_fops);
 }
 
 void bnxt_debug_dev_exit(struct bnxt *bp)
-- 
2.47.1


