Return-Path: <netdev+bounces-92284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A292F8B672C
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 03:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D5F283B9F
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 01:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0B1205E3F;
	Tue, 30 Apr 2024 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="0CxEzQ+M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB32205E32
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 01:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439263; cv=none; b=Q/2co/GDeuo1FESVhT+z7z7e6kuuzH8MHAbxqrdCYxrqqxpIcjQjgMRP+dO8dyozzT4ubwiHGIZlZMFnYjDu/zSMAKPgZ9BuDLSPm2eOvN57DEUFvi31SRNzjflBIFNjwg2tk94hRFIcnaQZmmvspEb2bnOwzRVvc3r73Vx/lYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439263; c=relaxed/simple;
	bh=OYY5KT41NM5uN1HZKt+u1zzFIxSC++IQ3CLaeU7YVME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNldfPBzInmzGlJMJINkOzKGxskbO4Ejj1Ljzt6OCIEaP6Tax2ACw9lMgR1Yhh1haof27gR5bsmo1LHAE1uBi6LQMXrMHzMtIBJZ866SwWBHVgMOpXYPJZZopMd1G5J4uuxZ9uok0ypp4B/R9Nrg+569DLzFdECb4z2titRxENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=0CxEzQ+M; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6123726725eso1528049a12.3
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 18:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714439261; x=1715044061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/ZJcAuW84ecF6scZWO7f0oLtlZZw7KnY0k3vPst4TE=;
        b=0CxEzQ+M+Qe3JEv1fCpMBa/CooTScM8p2h8uHFn4gODMtWFxs2MA8pN01/GaARJ7aS
         YTFAPyajK6PrkoaZSqAMIpXg1N9Ir8fXCaMdamgQy/Jm2K6/mWOZ9VXTQkXFvVTZkn6Y
         PCZSYVa5R2tqqaIEZMIaWhRFy92lxD3X+q+8tvEIb8LN5SpxpydYsxMkzh99gFyH5SeQ
         ilA+7NbpVoXufEmD6DadOrIrUlmZ6mWugVzBDUqhx477nGu9abtYfyirdOK02QWE9o4M
         zDChq0ZVdDyrXRbls2YnHnYI4JLNacMJ4XZy/rG8QaaQQBVTrCW3+V5aJgRDsF7zgJ35
         zbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714439261; x=1715044061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/ZJcAuW84ecF6scZWO7f0oLtlZZw7KnY0k3vPst4TE=;
        b=ofdJA3YbphM4iZJb/vPrr3bfhFpVZ73wWEynxGD/m1XuCfegpGkDdVIp3V6OvpZ1pU
         XgQjAIQre8sJOTVRatFkKS19i/vAKSo4CvClY65p1NN8kGv7YDYcZprKq+MKbGyHGz6P
         BCosNlLRcg1atrH5d7CuOjIytgNubUofkA/1mVNp5RZmtbU3FfJoMkMkwFtaRlcr+NAV
         vIqBJ+zvTFsxg9KvakD0eu7dqNNB/QBSd/XBeQcIzu2d/3AWpT9BXnhDWo5fbBu+HfkG
         MBUs6kKO8euRQ+w3eMGeRJf2mq8ev0lbVrqVt96YhXm7l/+4jipC7C9nEFvfSpAEHFNT
         e7KA==
X-Gm-Message-State: AOJu0Yzr9oB8mPnf+7Z2TKkjLpFs57drMPYNvK/inIbUGFB7/4A6yQod
	A3MU7q5am989HoMlPehO6JUbP9fpHtNpABKDjhQwUzCP3WKnFiXQDUFYFaqvICww40q3WwDauVU
	F
X-Google-Smtp-Source: AGHT+IEOFfjoUzZArpr2emS+wl9sWvDsfTheiLzznCDSpGDqLxMk1ts1YjrGw/qO01nVaj2IwpCa1A==
X-Received: by 2002:a17:90b:3ccf:b0:2b1:6686:dd7b with SMTP id qd15-20020a17090b3ccf00b002b16686dd7bmr4831853pjb.33.1714439260992;
        Mon, 29 Apr 2024 18:07:40 -0700 (PDT)
Received: from localhost (fwdproxy-prn-118.fbsv.net. [2a03:2880:ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id gw3-20020a17090b0a4300b002b1ae6f26cbsm2697774pjb.53.2024.04.29.18.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 18:07:40 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH net-next v1 3/3] netdev: add netdev_rx_queue_restart()
Date: Mon, 29 Apr 2024 18:07:32 -0700
Message-ID: <20240430010732.666512-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430010732.666512-1-dw@davidwei.uk>
References: <20240430010732.666512-1-dw@davidwei.uk>
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


