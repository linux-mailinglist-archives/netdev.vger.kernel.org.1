Return-Path: <netdev+bounces-217924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 495BDB3A68D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD34B3A7AC6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBC8326D53;
	Thu, 28 Aug 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgDHQ+QZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67CF1F582A;
	Thu, 28 Aug 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398988; cv=none; b=A4b/3G8A4updg3JbVYxsCeVWSDobBEV0Hz1ptmqLbascgiNGeJCjupOAbLsiDITHvGJ29UhVCDASkZ9SUf2NxQUlTZxIhz7xludNIp5sio9KDEvapxegyq9VLyujUb+pamTdhnchq+cZyrv8WBf6NUvnh7qgz5o71MDdk2QGCsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398988; c=relaxed/simple;
	bh=JfmHNKv6fRRctbyWAbALohUHBx6noYvrxSlvIRgrcfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=giaUY+QyaveBuNJUNqvpiE1HpaoWilvMOLrsyKggzBL4c8bgfK0r4GzO3SnFbupHmV5Nxiy9Fwx3rIUxnEG99mowL3CVwRuKyFASYNjWa9LYnPDMJL8rM9Hu5YrIfUUyNOwMWKAigY3jUsLU7ontmtjxoxgApt7JMHDaED3hcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgDHQ+QZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7ace3baso199856466b.3;
        Thu, 28 Aug 2025 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398984; x=1757003784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qfjvek//ENAEgL2FKgX59bx4t0OTeCHfKIX7r7gIqYY=;
        b=MgDHQ+QZiFO4dS7sZTO2t/LcMO26ozbNNOmmSQcj+YgrAFXvkbMHVeVip7baBgfQ7z
         wX8W7ri4jD7dZJsOCvsWjjQXRRAPGD9RwmJhyh5FpSEnK9b8CER8Cz7EuimJLUn5htK8
         bDaXABjsO9bLBCMtFDdKIeSKIK1vMNRBz81rjgJL9hBkHabdhsRCtq+qAyatF4M33Ybr
         myhAzV+vOSuojAKHztJh5YlPUUl9umE6Ke/KQdymPlSq6ttjFaxAvNigmFQthvhwvike
         E01noLW5J7ze1MvsNwAhbvZH+8Siid+mpRrkOi/pIkeNTxoo+df9kaXOQP6P9fRFW/am
         kHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398984; x=1757003784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfjvek//ENAEgL2FKgX59bx4t0OTeCHfKIX7r7gIqYY=;
        b=CBWnOxUvANWMCFya5pLg4F8KlL1nlJXDtGewlJVXXyBVAR08a7d2ew48TJM27vNrhb
         1uOJGAK7VQBxt36juPLcZqSoeLpGABaqQn5STyqygtc6FYunNFDfkPCI3vP8hoJIUzYL
         c7rN0pfEw+XP4pL27sa/Km3jCli1MdD9G3+i7aBY5rohlU06eh+xV5YNgLMRYQ7sJ2Bm
         FCkGp7ablycjXpFU0RXYAuYnq/tx1xhYvou4KZLqOl0vsOOUa3MPEPw8kvTTJG2eGXos
         SedPXpm4La3Dui6WwvQPIFjn1bPqXGsCGL2gDfUzpJeD14ymoFXk33E/X/OXjPXhD9cP
         xKlw==
X-Forwarded-Encrypted: i=1; AJvYcCXRmGbTh67hc61qXQh3h3MoxY4DxOqNCsaRyifPP1FckAgaDXiY0SW16LADKwLbkt7kQsVLKz4KnRhHrWo=@vger.kernel.org, AJvYcCXt5QVC86F7cjWCaktpGrzC6Q2+62LwZmSCX9xJ5imSrFXVPF+aAf7tXa0RgQKvhKz6ODQssLMM@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYr+5EPmlmOuS7WRMzQQUEOCCuE2sABD7pP3VdYs/xV03J/4o
	PK1LTCPjoLMzJ2aKt/YR/2HtDHsfkLPq22ZzHE2WYr6g0X1npMMfksDW
X-Gm-Gg: ASbGncunJQjoTifS3OpcocDMexQ99IC9Eh8YOgL626eZPJjBD+4x23UQDP56rw0RX4r
	Sj7pFDq7SToZZL13H8Mnl9Qt5QeZdXgUn1zf/vpeVnZgKCNrJo6phTfQZ07t4LlETl+DvRa7mvC
	FozpXYe2nCQVKHw1y6q6ezS45bf4PRp+8B9t6AUcLR9OWI+b/jH48HIsvYeEh2zqAHCkhEhXnOd
	TR9qmiF+3nddM4rXq1cGL9sI5Msd/mbHt2gmG4s8z39evW289qmIcO146dWc/FXPfKmGvHKiq4g
	URGjP6kZrmFNNlYbTLQfqGZqg3Lp4sDUFiXafZrVPLoXYHebpC/LUk2uBcpOLSzNPtgj4nRZEBS
	N54LbAx2/Gh4g7EEthOCUdwhLBzO4LHQjbfx12HaaSoQH8tUMnHgGlLFFyxap+2vE5jQC9kTg2I
	GpkNNbb2ggPRvPtyrUkzlzFgrrQ+CgBBA8ShoFYhwNzjiWpTtuM4RvQqPt8XpQ+iZkvmQMSo9mP
	P/uauo/ZCp6YN6k93rAN+KJK/YP9A==
X-Google-Smtp-Source: AGHT+IFe/hXcuH4AtiAKvjVUFlgCKrqqvJR25IyTeSY2Pjjx/C6Tzii4v9S5DZvkLNq7zohXjkV0JQ==
X-Received: by 2002:a17:907:1c13:b0:afe:d62a:f04b with SMTP id a640c23a62f3a-afed62af6dbmr401965966b.3.1756398983612;
        Thu, 28 Aug 2025 09:36:23 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afef7ae440dsm58069466b.15.2025.08.28.09.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:36:23 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Junnan Wu <junnan01.wu@samsung.com>,
	Ying Xu <ying123.xu@samsung.com>
Subject: [PATCH] virtio_net: adjust the execution order of function `virtnet_close` during freeze
Date: Thu, 28 Aug 2025 18:36:18 +0200
Message-ID: <20250828163618.86177-1-226562783+SigAttilio@users.noreply.github.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junnan Wu <junnan01.wu@samsung.com>

"Use after free" issue appears in suspend once race occurs when
napi poll scheduls after `netif_device_detach` and before napi disables.

For details, during suspend flow of virtio-net,
the tx queue state is set to "__QUEUE_STATE_DRV_XOFF" by CPU-A.

And at some coincidental times, if a TCP connection is still working,
CPU-B does `virtnet_poll` before napi disable.
In this flow, the state "__QUEUE_STATE_DRV_XOFF"
of tx queue will be cleared. This is not the normal process it expects.

After that, CPU-A continues to close driver then virtqueue is removed.

Sequence likes below:
--------------------------------------------------------------------------
              CPU-A                            CPU-B
              -----                            -----
         suspend is called                  A TCP based on
                                        virtio-net still work
 virtnet_freeze
 |- virtnet_freeze_down
 | |- netif_device_detach
 | | |- netif_tx_stop_all_queues
 | |  |- netif_tx_stop_queue
 | |   |- set_bit
 | |     (__QUEUE_STATE_DRV_XOFF,...)
 | |                                     softirq rasied
 | |                                    |- net_rx_action
 | |                                     |- napi_poll
 | |                                      |- virtnet_poll
 | |                                       |- virtnet_poll_cleantx
 | |                                        |- netif_tx_wake_queue
 | |                                         |- test_and_clear_bit
 | |                                          (__QUEUE_STATE_DRV_XOFF,...)
 | |- virtnet_close
 |  |- virtnet_disable_queue_pair
 |   |- virtnet_napi_tx_disable
 |- remove_vq_common
--------------------------------------------------------------------------

When TCP delayack timer is up, a cpu gets softirq and irq handler
`tcp_delack_timer_handler` will be called, which will finally call
`start_xmit` in virtio net driver.
Then the access to tx virtq will cause panic.

The root cause of this issue is that napi tx
is not disable before `netif_tx_stop_queue`,
once `virnet_poll` schedules in such coincidental time,
the tx queue state will be cleared.

To solve this issue, adjusts the order of
function `virtnet_close` in `virtnet_freeze_down`.

Co-developed-by: Ying Xu <ying123.xu@samsung.com>
Signed-off-by: Ying Xu <ying123.xu@samsung.com>
Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
Message-Id: <20250812090817.3463403-1-junnan01.wu@samsung.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d14e6d602273..975bdc5dab84 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5758,14 +5758,15 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	disable_rx_mode_work(vi);
 	flush_work(&vi->rx_mode_work);
 
-	netif_tx_lock_bh(vi->dev);
-	netif_device_detach(vi->dev);
-	netif_tx_unlock_bh(vi->dev);
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
 		virtnet_close(vi->dev);
 		rtnl_unlock();
 	}
+
+	netif_tx_lock_bh(vi->dev);
+	netif_device_detach(vi->dev);
+	netif_tx_unlock_bh(vi->dev);
 }
 
 static int init_vqs(struct virtnet_info *vi);
-- 
2.48.1


