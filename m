Return-Path: <netdev+bounces-108067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5444391DC06
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BCB1F23D59
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094C312A16D;
	Mon,  1 Jul 2024 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVH2Jv0Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6420784D13;
	Mon,  1 Jul 2024 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828226; cv=none; b=ohf+UcsuGcHPH85bN5A4PNmFLyZSsB+O4BKlNfTLBscASIk0jjPSL85OP5NJP821HlVGBH497I3yXyUZ0MtQ7o+2dtjk2x9c9CqmTvU3CdRc7l/6iPbFI/JWrCE+Heor7JjWNmJZ1/jAiSw0EGgCHsMzBj7CkCPfKypcbXeV6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828226; c=relaxed/simple;
	bh=WoyZo3J48/BTK8Q5qPu8vu9i2RepQ1vve6EEIdIv+D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wt7QHGtNU8P/M9TWQwiff+1MP1qZ8ytEI7FcGrtQ/9hCgf8lalbwjD2ROgUtjFQNck9xVrudxk5jHdDQ8YPW9r/Mk8ewxAtaF7mF1drJ23698LZhofJTgPGdJON6SwluumD5f6wRVms5gFRJ+jh0GMt/RbyDqFcTMkg/6W5GWsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVH2Jv0Z; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3738690172eso13950565ab.1;
        Mon, 01 Jul 2024 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719828224; x=1720433024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hurOhyWpabhW0TJQF2bFgJMj9d8jgnZbSnHU4diB3eQ=;
        b=TVH2Jv0ZAHODdIV6HA9r3/0oJB/bFMlp3+05QBOrSF17U+lZv7ybVOI+K9qpiNzKW7
         rdztwwremAARPUtC/XyWzr/8TXUHNL469MCI7ruNHoXaxzd3fWrRu8hRP2xsm0omHCj6
         6HrxSuUoG7NHQtBXbxC2SV43Nv9KKDzP/hZstJY8S8T+JgcOA225KuYPIAJlbf6uQ0PA
         Lv0rk45gFgFYpKZWHsMQGQthyB6gs5LvfbDR/VUrah6ooNf6NSeBw7sXKbVj10aOk206
         vXg6PqV0kQFyn/2oy/v2b/x9kfVqtjND+cv1cSmMEF+1zV9YyM7Sj90dYLeOs5jHNR4E
         cYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719828224; x=1720433024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hurOhyWpabhW0TJQF2bFgJMj9d8jgnZbSnHU4diB3eQ=;
        b=JyRVlYnIkYhtMVuX6hrioqVqwmdYEKZFjzq8di+RdnbSfrDoSeFhD1k08o+eHrvYyu
         P7FrtqK7QfaOncqykJsVC666ggMPk+m9A+9vr0pc9k5No9B6tPsvRF0naM0k61jlPjKn
         wveoIBx2P2hQQ0WCLXMO0r+PuD7o2XTSkd2+m/p9vW26Yb6ZYtcmWqM1Uvyr9U0r3TBr
         f5iiadoanUDfNie09vvpNj3v0yGZyon9dAAcClhIWpLjuCR8DEhYFWgmQpWqhI2Zwasd
         o2wwf0hTTOQiFny+0fSYgmVw3wIzwjLo088ZDpDtpFyvgT3UWMGWCtrYouMpqtdoVbRP
         f0Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUjpKdFZ8wLlLqEyP4GC9FtbtOnaC7fEf5uOz/bnCKyzu498i/mSCAkzl+35vtN462LFYpItjzfOdN+tyREsTI4z2eVy2nlQpVafFmcPB7aHOki1cuHmxa/3FvQRjfCg66qFaxqglPhlJbl6g2P8X+ow7nugE4VHSnnJZYp1r8/
X-Gm-Message-State: AOJu0YxjTaFOXe5uFI1KaF3E43TDVe2M9vwAPMssz3CI3eXfg8ShpF+D
	LSB9L2ZPTZaic7M8onMp3yc/k8NZtmPRo/ctz3EPVtRngnsB8JxuaC6qbw==
X-Google-Smtp-Source: AGHT+IFGnU2mjoz9gPp3FUwgjA97XxV1JEWCuXRDRqFSmhKcNWhwZKoBv6J80NpwJ8GuF7c72ZQdsA==
X-Received: by 2002:a05:6e02:1c41:b0:375:b2c1:a783 with SMTP id e9e14a558f8ab-37cd1793dacmr79099545ab.17.1719828224285;
        Mon, 01 Jul 2024 03:03:44 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b5188csm4073202a12.3.2024.07.01.03.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 03:03:43 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH-next v1] r8152: Convert tasklet API to new bottom half workqueue mechanism
Date: Mon,  1 Jul 2024 15:33:27 +0530
Message-ID: <20240701100329.93531-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate tasklet APIs to the new bottom half workqueue mechanism. It
replaces all occurrences of tasklet usage with the appropriate workqueue
APIs throughout the alteon driver. This transition ensures compatibility
with the latest design and enhances performance

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Tested on odroidxu4
---
 drivers/net/usb/r8152.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 15e12f46d0ea..57a932a6f759 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -26,6 +26,7 @@
 #include <linux/atomic.h>
 #include <linux/acpi.h>
 #include <linux/firmware.h>
+#include <linux/workqueue.h>
 #include <crypto/hash.h>
 #include <linux/usb/r8152.h>
 #include <net/gso.h>
@@ -883,7 +884,7 @@ struct r8152 {
 #ifdef CONFIG_PM_SLEEP
 	struct notifier_block pm_notifier;
 #endif
-	struct tasklet_struct tx_tl;
+	struct work_struct tx_work;
 
 	struct rtl_ops {
 		void (*init)(struct r8152 *tp);
@@ -1950,7 +1951,7 @@ static void write_bulk_callback(struct urb *urb)
 		return;
 
 	if (!skb_queue_empty(&tp->tx_queue))
-		tasklet_schedule(&tp->tx_tl);
+		queue_work(system_bh_wq, &tp->tx_work);
 }
 
 static void intr_callback(struct urb *urb)
@@ -2748,9 +2749,9 @@ static void tx_bottom(struct r8152 *tp)
 	} while (res == 0);
 }
 
-static void bottom_half(struct tasklet_struct *t)
+static void bottom_half(struct work_struct *t)
 {
-	struct r8152 *tp = from_tasklet(tp, t, tx_tl);
+	struct r8152 *tp = from_work(tp, t, tx_work);
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
@@ -2944,7 +2945,7 @@ static netdev_tx_t rtl8152_start_xmit(struct sk_buff *skb,
 			schedule_delayed_work(&tp->schedule, 0);
 		} else {
 			usb_mark_last_busy(tp->udev);
-			tasklet_schedule(&tp->tx_tl);
+			queue_work(system_bh_wq, &tp->tx_work);
 		}
 	} else if (skb_queue_len(&tp->tx_queue) > tp->tx_qlen) {
 		netif_stop_queue(netdev);
@@ -6826,11 +6827,11 @@ static void set_carrier(struct r8152 *tp)
 	} else {
 		if (netif_carrier_ok(netdev)) {
 			netif_carrier_off(netdev);
-			tasklet_disable(&tp->tx_tl);
+			disable_work_sync(&tp->tx_work);
 			napi_disable(napi);
 			tp->rtl_ops.disable(tp);
 			napi_enable(napi);
-			tasklet_enable(&tp->tx_tl);
+			enable_and_queue_work(system_bh_wq, &tp->tx_work);
 			netif_info(tp, link, netdev, "carrier off\n");
 		}
 	}
@@ -6866,7 +6867,7 @@ static void rtl_work_func_t(struct work_struct *work)
 	/* don't schedule tasket before linking */
 	if (test_and_clear_bit(SCHEDULE_TASKLET, &tp->flags) &&
 	    netif_carrier_ok(tp->netdev))
-		tasklet_schedule(&tp->tx_tl);
+		queue_work(system_bh_wq, &tp->tx_work);
 
 	if (test_and_clear_bit(RX_EPROTO, &tp->flags) &&
 	    !list_empty(&tp->rx_done))
@@ -6973,7 +6974,7 @@ static int rtl8152_open(struct net_device *netdev)
 		goto out_unlock;
 	}
 	napi_enable(&tp->napi);
-	tasklet_enable(&tp->tx_tl);
+	enable_and_queue_work(system_bh_wq, &tp->tx_work);
 
 	mutex_unlock(&tp->control);
 
@@ -7001,7 +7002,7 @@ static int rtl8152_close(struct net_device *netdev)
 #ifdef CONFIG_PM_SLEEP
 	unregister_pm_notifier(&tp->pm_notifier);
 #endif
-	tasklet_disable(&tp->tx_tl);
+	disable_work_sync(&tp->tx_work);
 	clear_bit(WORK_ENABLE, &tp->flags);
 	usb_kill_urb(tp->intr_urb);
 	cancel_delayed_work_sync(&tp->schedule);
@@ -8423,7 +8424,7 @@ static int rtl8152_pre_reset(struct usb_interface *intf)
 		return 0;
 
 	netif_stop_queue(netdev);
-	tasklet_disable(&tp->tx_tl);
+	disable_work_sync(&tp->tx_work);
 	clear_bit(WORK_ENABLE, &tp->flags);
 	usb_kill_urb(tp->intr_urb);
 	cancel_delayed_work_sync(&tp->schedule);
@@ -8468,7 +8469,7 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 	}
 
 	napi_enable(&tp->napi);
-	tasklet_enable(&tp->tx_tl);
+	enable_and_queue_work(system_bh_wq, &tp->tx_work);
 	netif_wake_queue(netdev);
 	usb_submit_urb(tp->intr_urb, GFP_KERNEL);
 
@@ -8640,12 +8641,12 @@ static int rtl8152_system_suspend(struct r8152 *tp)
 
 		clear_bit(WORK_ENABLE, &tp->flags);
 		usb_kill_urb(tp->intr_urb);
-		tasklet_disable(&tp->tx_tl);
+		disable_work_sync(&tp->tx_work);
 		napi_disable(napi);
 		cancel_delayed_work_sync(&tp->schedule);
 		tp->rtl_ops.down(tp);
 		napi_enable(napi);
-		tasklet_enable(&tp->tx_tl);
+		enable_and_queue_work(system_bh_wq, &tp->tx_work);
 	}
 
 	/* If we're inaccessible here then some of the work that we did to
@@ -9407,11 +9408,11 @@ static int rtl8152_change_mtu(struct net_device *dev, int new_mtu)
 		if (netif_carrier_ok(dev)) {
 			netif_stop_queue(dev);
 			napi_disable(&tp->napi);
-			tasklet_disable(&tp->tx_tl);
+			disable_work_sync(&tp->tx_work);
 			tp->rtl_ops.disable(tp);
 			tp->rtl_ops.enable(tp);
 			rtl_start_rx(tp);
-			tasklet_enable(&tp->tx_tl);
+			enable_and_queue_work(system_bh_wq, &tp->tx_work);
 			napi_enable(&tp->napi);
 			rtl8152_set_rx_mode(dev);
 			netif_wake_queue(dev);
@@ -9839,8 +9840,8 @@ static int rtl8152_probe_once(struct usb_interface *intf,
 	mutex_init(&tp->control);
 	INIT_DELAYED_WORK(&tp->schedule, rtl_work_func_t);
 	INIT_DELAYED_WORK(&tp->hw_phy_work, rtl_hw_phy_work_func_t);
-	tasklet_setup(&tp->tx_tl, bottom_half);
-	tasklet_disable(&tp->tx_tl);
+	INIT_WORK(&tp->tx_work, bottom_half);
+	disable_work_sync(&tp->tx_work);
 
 	netdev->netdev_ops = &rtl8152_netdev_ops;
 	netdev->watchdog_timeo = RTL8152_TX_TIMEOUT;
@@ -9974,7 +9975,7 @@ static int rtl8152_probe_once(struct usb_interface *intf,
 	unregister_netdev(netdev);
 
 out1:
-	tasklet_kill(&tp->tx_tl);
+	cancel_work_sync(&tp->tx_work);
 	cancel_delayed_work_sync(&tp->hw_phy_work);
 	if (tp->rtl_ops.unload)
 		tp->rtl_ops.unload(tp);
@@ -10030,7 +10031,7 @@ static void rtl8152_disconnect(struct usb_interface *intf)
 		rtl_set_unplug(tp);
 
 		unregister_netdev(tp->netdev);
-		tasklet_kill(&tp->tx_tl);
+		cancel_work_sync(&tp->tx_work);
 		cancel_delayed_work_sync(&tp->hw_phy_work);
 		if (tp->rtl_ops.unload)
 			tp->rtl_ops.unload(tp);
-- 
2.44.0


