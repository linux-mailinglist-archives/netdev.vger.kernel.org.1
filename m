Return-Path: <netdev+bounces-92893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82D28B93FA
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 06:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDCD2816D5
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A011E20323;
	Thu,  2 May 2024 04:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="dmGMAOLE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478FA1DDD1
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 04:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625661; cv=none; b=Rlqhl3WlGb7cz+syTOb+wauA8RKxWc50LRzb052UqSZsrSsDrCujbPTXGZ/lJmMQpBwZP4E5W3M6Bg39sb34I7Gd3b1ZiJZfdUfc8vtCgFaYVKV5LLMAeiwBRW+HU+B12aQ9H88PybAAOek3VHgbS5SjNzzMJ1anxYiXQiKRZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625661; c=relaxed/simple;
	bh=OYY5KT41NM5uN1HZKt+u1zzFIxSC++IQ3CLaeU7YVME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovbUcaSvYsIDprb3+3JNNqqKhMRPcMHMiP952/oKVtN+fubQ7OtrWqT4YFB0WXXuZ22A0L1+KTfiLVMCM1ixRb46ZW+tfaoAitXdu0X1SAex5ryY8dofYhLz9WTWR1tyQ0PMrgsE+nSBFpdGByyqEOHKdb2BGjik69L0WeLiIoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=dmGMAOLE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec486198b6so20625405ad.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 21:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714625659; x=1715230459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/ZJcAuW84ecF6scZWO7f0oLtlZZw7KnY0k3vPst4TE=;
        b=dmGMAOLERUUOaSsdIHxM8ligMMrHJHN1qRzGLD5/uZOcnYzZsE1HjKlWrK+rYkA06v
         F26BixrqdJP8hJwVS3iRtPcl2ajGy44YbN9v0mCrIz6jegce97syZ9JNkz7GTNZDg9Yv
         jMaiJ3dwOYDqDhVKpPdlANYTYBCOd7Hg7RMQbF+D4IYLc6hH5HuQk0LlP7jLWL7x+DeX
         ZjsSdIM20I4cUdG84jNw2QEjpKSVr8ajWjVqzW0Js3GwRzkgaG+5McoA2GO/MWVgvG3d
         D1gs4zPk8BufI8SsL8gFaWfQqUb8J9MB0zOASConfzWt7Jdngk3JwS+5XA8uhJpOzeor
         XdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625659; x=1715230459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/ZJcAuW84ecF6scZWO7f0oLtlZZw7KnY0k3vPst4TE=;
        b=Q1JXdZuTVjy+XvMa0+UpMZgvURVcpm/6x6LrqzxfkUn5rBonsWSqxWTZX9IY29WQP2
         dBGtHOh4zm88FuW58TXCp8WgyicY6J57PLj4AXmssoM7YOEh9ME0SYM2hSl6GhAmZa5d
         zB9aEr0EzxBr3/1olZ+ccYicvNf6/OlDQAAgd18dV8pNHOylOWhI2Ixn6hyK3fc1ahH0
         namrP/k4rNEUdO6IqmjrdQIi5J28qAn3dDyLAh6pUcagGcUuP3ioNY6FIbJ3XxRNDS26
         T6GP+QeGDQKDSe94C+rNyJCy3aXuYeEtLCaKk2VBgsUoFhv51c08VgHaP88ia0qlc/3D
         +BOA==
X-Gm-Message-State: AOJu0YyAH427u8FSvTfgn7NhnKnlj+Y6S8cySEeBpAZP2yPyvvwueN/n
	98UhLUJIsQgK5pBqTvGbe/Jwv7GH16P1hJi/vu7Q2w7+cnfWplKG993IrtQ7o9WVicyqfkxZn+E
	I
X-Google-Smtp-Source: AGHT+IE4GAL9EY+w1IH4d5B9UMs5riu6zXx+a518zfYASI+lqYqd9Q2tCMYOfIjs0kSNp0+SD5Nx+g==
X-Received: by 2002:a17:902:ed46:b0:1eb:86d:70cb with SMTP id y6-20020a170902ed4600b001eb086d70cbmr5014933plb.45.1714625659255;
        Wed, 01 May 2024 21:54:19 -0700 (PDT)
Received: from localhost (fwdproxy-prn-006.fbsv.net. [2a03:2880:ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id n8-20020a170903110800b001e22860c32asm243800plh.143.2024.05.01.21.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:19 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH net-next v2 3/9] netdev: add netdev_rx_queue_restart()
Date: Wed,  1 May 2024 21:54:04 -0700
Message-ID: <20240502045410.3524155-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240502045410.3524155-1-dw@davidwei.uk>
References: <20240502045410.3524155-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mina Almasry <almasrymina@google.com>

Add netdev_rx_queue_restart() function to netdev_rx_queue.h. This is
taken from Mina's work in [1] with a slight modification of taking
rtnl_lock() during the queue stop and start ops.

For bnxt specifically, if the firmware doesn't support
BNXT_RST_RING_SP_EVENT, then ndo_queue_stop() returns -EOPNOTSUPP and
the whole restart fails. Unlike bnxt_rx_ring_reset(), there is no
attempt to reset the whole device.

[1]: https://lore.kernel.org/linux-kernel/20240403002053.2376017-6-almasrymina@google.com/#t

Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/netdev_rx_queue.h |  3 ++
 net/core/Makefile             |  1 +
 net/core/netdev_rx_queue.c    | 58 +++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 net/core/netdev_rx_queue.c

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index aa1716fb0e53..e78ca52d67fb 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -54,4 +54,7 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 	return index;
 }
 #endif
+
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
+
 #endif
diff --git a/net/core/Makefile b/net/core/Makefile
index 21d6fbc7e884..f2aa63c167a3 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
 obj-y += net-sysfs.o
 obj-y += hotdata.o
+obj-y += netdev_rx_queue.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
new file mode 100644
index 000000000000..9633fb36f6d1
--- /dev/null
+++ b/net/core/netdev_rx_queue.c
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/netdevice.h>
+#include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
+
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq)
+{
+	void *new_mem;
+	void *old_mem;
+	int err;
+
+	if (!dev->queue_mgmt_ops->ndo_queue_stop ||
+	    !dev->queue_mgmt_ops->ndo_queue_mem_free ||
+	    !dev->queue_mgmt_ops->ndo_queue_mem_alloc ||
+	    !dev->queue_mgmt_ops->ndo_queue_start)
+		return -EOPNOTSUPP;
+
+	new_mem = dev->queue_mgmt_ops->ndo_queue_mem_alloc(dev, rxq);
+	if (!new_mem)
+		return -ENOMEM;
+
+	rtnl_lock();
+	err = dev->queue_mgmt_ops->ndo_queue_stop(dev, rxq, &old_mem);
+	if (err)
+		goto err_free_new_mem;
+
+	err = dev->queue_mgmt_ops->ndo_queue_start(dev, rxq, new_mem);
+	if (err)
+		goto err_start_queue;
+	rtnl_unlock();
+
+	dev->queue_mgmt_ops->ndo_queue_mem_free(dev, old_mem);
+
+	return 0;
+
+err_start_queue:
+	/* Restarting the queue with old_mem should be successful as we haven't
+	 * changed any of the queue configuration, and there is not much we can
+	 * do to recover from a failure here.
+	 *
+	 * WARN if the we fail to recover the old rx queue, and at least free
+	 * old_mem so we don't also leak that.
+	 */
+	if (dev->queue_mgmt_ops->ndo_queue_start(dev, rxq, old_mem)) {
+		WARN(1,
+		     "Failed to restart old queue in error path. RX queue %d may be unhealthy.",
+		     rxq);
+		dev->queue_mgmt_ops->ndo_queue_mem_free(dev, &old_mem);
+	}
+
+err_free_new_mem:
+	dev->queue_mgmt_ops->ndo_queue_mem_free(dev, new_mem);
+	rtnl_unlock();
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(netdev_rx_queue_restart);
-- 
2.43.0


