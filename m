Return-Path: <netdev+bounces-212206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05E9B1EADC
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1744F3ABA42
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC31286435;
	Fri,  8 Aug 2025 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAnRwcqH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E2A286408;
	Fri,  8 Aug 2025 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664834; cv=none; b=U/vuPhC5hkYSMAd81cGgRrtURLN8eavLjRoHWr4WQI3AAe+VHQpO0ilrWVp2RLbFeC++fX3uW6xugEbI9RHs6oR1nk1pNfm3oIA4m8PTXxB4y5nqxTeJZbA4h6ABddSles5mgeN2DkGDa0Y4jPwkizucdYGhCDwSgc0WIAFR92c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664834; c=relaxed/simple;
	bh=KsatO9EaPLT/XVXDGOduZZeF++z6wYaK1fVAl91qJYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0SalCFJp2zktC4bdEXOW6i5xVAc4YIzP1y7T+6QBfIk5SRgJ6o243hq1XSAtflZ8VxrhNe5qMx6yT9hkMgeBUkwO5qNKfvX5xxYiyUg/uCDN2oifMoeeXe82CKCX5uJUqyOBTRuG7ULSQ+i5V9TS6WD0LK5CNit1HbObM6kwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAnRwcqH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-455b00339c8so14562555e9.3;
        Fri, 08 Aug 2025 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664831; x=1755269631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjzjcrqzhcIMLHYIuIJFsQxhNzZVSTi3RrrhvwP/054=;
        b=MAnRwcqHMFd6h9tmx9NnvkylDVSUqHrk/71aRYIASgnVuW1DV2xhHXzc5t8xBWaThU
         C/Vs8ISW18bYoaSNqHDL7eTwcWB7aSWbWHg9XwhFOih30nIODZYWtaEC5Y7N0QIljtuj
         AatQPArQ6LyC/nnMrgjpZZfABVspTFU9f7rkfQTZrOIWYcw5Cz8G/K7LB4pJ6hGCTETS
         S3zznZQ9pJBZ5m1gNcg55oDcDwz4WqtSKbSTYl5OXLq2cGO7hB8RJERSUiUar4R5hXkW
         PbrlSIlBY+8ZI/e8vDG2xDp7MrxUsnHVjOoxK5VOdb1uMA7bohZp6EbvjGhksEy784Vk
         Z6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664831; x=1755269631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjzjcrqzhcIMLHYIuIJFsQxhNzZVSTi3RrrhvwP/054=;
        b=QGZMdmLJ8PQBWAISoY0sM0yvU9rSv07224lcrp6mMQeE/rl/YD6SwYUvNqHaAxoiFK
         eGntVBhlKPjFcn3pNEcxIPL9MRLCBX9s7p4pX90N5zFbqDETFUSrKuENjN8kRQsHVZ8Q
         AfrTgT+KDPcmbO8wH54p3KLzW4wXDWvMbkeN9FGONtp/wx3Dgc+xev2pirIzQyxIr1R2
         CXAo3aGebCJfXglDQ5LY/yipAuBHxWxil8cArDtVMdUbSBfcS5LQkSeVJNjdOlHkeHk1
         f1UUzKFeA3OL4DQSvSAOK1JNSTTOGm69XCllJI8xspdbaqGjKzWz6nSE6TPkai52bKH1
         Vfxg==
X-Forwarded-Encrypted: i=1; AJvYcCWeou8y1DeqfO7oo3GzOIENQBM8M2XBd4FkcpRrYSHV0/Asa2D3EXxI6Xn0PejWd3MW6rRnuwl57lRufWc=@vger.kernel.org, AJvYcCXxOY3GSNIqt9bH+iEdl+gG8oUCYU97XRsfuA70Mo+lWyTIChk8TXCCB5gVI0PsWcKhqxuS3ft6@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhLh8rdxWpm9NfQkrxv4gUslj6NEpG7FbPQYLIeoCC57wOiPY
	wTsbx6HiAP7djadKTVzsC1pS1XMFJb04Tt8VUmQ+S8H+DlaN/W+/s49a
X-Gm-Gg: ASbGnct4fq41C86TZqeSdTLWMh2QvMOUDDHn5uzLBnKrkU7CQxByG3rtj9to2FTIQHP
	rwCKqjXk+X8pPmnXpBu5SyQYy3cs+jb5gHZGRduzDbWN199DygPffku7asQN44vihiPgD4LWPk0
	goVxZU37/RC4a4QhtUaemJguIUx9tpEZkb0T6QTdoyX2ksj8Nvd/joGD34VXQv7uMBqBAvx6b9O
	Gim6paDtu2T2pYfb+tFEDz3kF8UOvHCIKquA70hgmb239LDE8y95H/xE/O72F0gZ4tdDGqkq+yX
	EKUeC/LoAMLrqpMOfFk8z+y44q9dnARa6Sct7PJDHM/ZH8RqD1qURmTJbz18+M9R4hNmHOhR3rl
	3PNQcjw==
X-Google-Smtp-Source: AGHT+IEGF3T3RZLN8y+Mvh3TSXwE+AbXUtlNFyXPSJ5Q7Op4TQjKy7T262iMP6W7Wk2kHU1oMTo8vw==
X-Received: by 2002:a05:600c:4f94:b0:459:d494:faf9 with SMTP id 5b1f17b1804b1-459f4f3e51dmr34361025e9.10.1754664830934;
        Fri, 08 Aug 2025 07:53:50 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:50 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 13/24] net: pass extack to netdev_rx_queue_restart()
Date: Fri,  8 Aug 2025 15:54:36 +0100
Message-ID: <96b167f57130cefd756f8cc228f6239b0e21111c.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Pass extack to netdev_rx_queue_restart(). Subsequent change will need it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 drivers/net/netdevsim/netdev.c            | 2 +-
 include/net/netdev_rx_queue.h             | 3 ++-
 net/core/netdev_rx_queue.c                | 7 ++++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 96b6fa696247..e8e88782fdf1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11532,7 +11532,7 @@ static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
 
 	netdev_lock(irq->bp->dev);
 	if (netif_running(irq->bp->dev)) {
-		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
+		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr, NULL);
 		if (err)
 			netdev_err(irq->bp->dev,
 				   "RX queue restart failed: err=%d\n", err);
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 46cdf31f0354..74b2fe1b1cd3 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -865,7 +865,7 @@ nsim_qreset_write(struct file *file, const char __user *data,
 	}
 
 	ns->rq_reset_mode = mode;
-	ret = netdev_rx_queue_restart(ns->netdev, queue);
+	ret = netdev_rx_queue_restart(ns->netdev, queue, NULL);
 	ns->rq_reset_mode = 0;
 	if (ret)
 		goto exit_unlock;
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 8cdcd138b33f..a7def1f94823 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -56,6 +56,7 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 	return index;
 }
 
-int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq,
+			    struct netlink_ext_ack *extack);
 
 #endif
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index fb87ce219a8a..420b956a40e4 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -10,7 +10,8 @@
 #include "dev.h"
 #include "page_pool_priv.h"
 
-int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx,
+			    struct netlink_ext_ack *extack)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
@@ -134,7 +135,7 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 #endif
 
 	rxq->mp_params = *p;
-	ret = netdev_rx_queue_restart(dev, rxq_idx);
+	ret = netdev_rx_queue_restart(dev, rxq_idx, extack);
 	if (ret) {
 		rxq->mp_params.mp_ops = NULL;
 		rxq->mp_params.mp_priv = NULL;
@@ -177,7 +178,7 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 
 	rxq->mp_params.mp_ops = NULL;
 	rxq->mp_params.mp_priv = NULL;
-	err = netdev_rx_queue_restart(dev, ifq_idx);
+	err = netdev_rx_queue_restart(dev, ifq_idx, NULL);
 	WARN_ON(err && err != -ENETDOWN);
 }
 
-- 
2.49.0


