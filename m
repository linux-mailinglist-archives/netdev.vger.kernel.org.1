Return-Path: <netdev+bounces-155268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53B5A0193F
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 12:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB361883CC9
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEA070831;
	Sun,  5 Jan 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPY69I9x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0B517FE;
	Sun,  5 Jan 2025 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736077131; cv=none; b=nDuayAdkA3U73rVgkM5Db3f7Jrr+tzrKdj63tkAtNptedFclT9AL83dN9QnLXlfh3ivuyzhyw5gqkNR+pZq/mPAGIefUaV18zc/pIsxPvr7Hn2S5m2KEk/vnmt8IPG4WJiBhhywrXVLTnoExRTb2yDEecrkhxF7f9RLBNP+LIDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736077131; c=relaxed/simple;
	bh=VozTSC3xzIch1AbkqdudGfWudw2JMr+c5/1FneOn7gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNV6Bi61esB8ZCZvkVKbE9IefKcwhjoKtIqBLlarwiLnQH1F83z6Qkb83Wembk7lurmOqhXog8uo/ulb4NWu7yhmp7/8uYITI6oWQq/mzcL+bqjKkybMyaiR/JWO3vgQX/cy6NSu5uw3W7FT2euyFjlBB8Z46MOx0C1SO2XOXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPY69I9x; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54252789365so6903731e87.0;
        Sun, 05 Jan 2025 03:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736077128; x=1736681928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UnXkorlhj21AU0DeCCqRG7b8kES+RU7vQ09X3NJJsME=;
        b=YPY69I9xhwi2yDfopb6RAzh8SoJ4BUsOCDCETz3jwcua+VJ7xnzd54lz8jEgKkiP4/
         Ya71VMdORZlU99Jx1qX3So+0bn9pFHGeqll79w/Vx3qiMNzyTbh+4Ln27GtAiIpKGXNG
         JygD10Cm27REC6G9sx+OZjbwIy/QpGsFHKwLY70RYiy51RToz7yY0F07b8BYlmTk6LpU
         SJH5HBFjetm+qEedJ9fz4GbcIJfMZrQ51B44veYGdlcH6cnu7EpQ5ZtYRbikRGJ5NkFB
         06WIyb/yeMUg9TB/T0lHe/XjhVPxx/CUConsdK9F/CGNQzpIBRXQOpk6gbxUmsSn2cq+
         iXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736077128; x=1736681928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnXkorlhj21AU0DeCCqRG7b8kES+RU7vQ09X3NJJsME=;
        b=DbzvPkMsyIQVdilUckTQYu1MurOVcBAfHwoQHCKUuzKxwEj7gwLJW0GsIl5D0jQyQ3
         NioHNbQsCm+BT58JQ+5GGn1VpBtUwo5r06Q8qUA2Z+eAy2deUk37+P0sOvt6CLOiwSHv
         lvXYeQm9s4MMwcIUa4WtyJpO2V+EChzbHWs8sknaLCUz/51IH5yfatD9DlKDoFta6rlj
         lRlqnhiWvdlaaBGkw0rSXSIfEI+MECJZKzJjW8DQ6GMzw0LyksEHiJMqHlYRpY+o0zoM
         naBS2MAl6yicm6QQtjTEoCOhW1DRLV7PrmoiVwExrkRB7Uv6TSKHDaxebCJhE0loyLjJ
         Or5A==
X-Forwarded-Encrypted: i=1; AJvYcCUDQqFyYFnnC2kmZiWZITucmkMQs2r8rYAYEpaL2C0tQarkxNHfN8q+Zx5Ec0tcdzYJ9A03W8y6NDWamAg=@vger.kernel.org, AJvYcCWETafic0AueWOY0eNO95taXpN2BxSfpF7EyVYMOGuDf7EPyKAzosZC2qcrw//FGZkj+g4jWZYQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4GSakYHKRn54yRq80JWHRleW44MalfZtRIkhoT3BC6vbSilbq
	YElvCzyrAlFq/zaGgqKR1Kcd4HpG1XH0hEc/rbv7xX1Y6RZ237eK
X-Gm-Gg: ASbGncvzy8wqExrBK3QOAOc+wznsFohhOIgdJ6eV/E+hXDdaKJcvDc21TP0nAcUIaNN
	8xKyBhdUMMW9pmwQlU7CgzjSjzUd82f4kdfWF0X+iyp4basYk2psRcXCVLRT1PE7PEw9FqYF7R+
	CX9YN5Fi4nAkl6EcvGxujNhSi2b2TOwECRHVdp+Ys/ziaG4I6MS4oj/SHSpArvz8JC+0eSUP1xV
	RpgPaHdIOykl+uaiNV6wOQGjmJa9+TZoKR37QrTQrg7kQ==
X-Google-Smtp-Source: AGHT+IFDPTY+CmpX2fATRp62xT27/eXNzMe0FOeFJskEzO7JLWgMwhtr1w/gVc5zW30o7649VTTCcQ==
X-Received: by 2002:a05:6512:3d86:b0:542:218a:2af7 with SMTP id 2adb3069b0e04-54229538b19mr17917597e87.15.1736077127945;
        Sun, 05 Jan 2025 03:38:47 -0800 (PST)
Received: from laptop.dev.lan ([2001:2040:c00f:15c::4159])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54269fd89e8sm689357e87.91.2025.01.05.03.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 03:38:46 -0800 (PST)
From: Dmitrii Ermakov <demonihin@gmail.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Dmitrii Ermakov <demonihin@gmail.com>
Subject: [PATCH v2 RESEND net-next] e1000e: makes e1000_watchdog_task use queue_delayed_work
Date: Sun,  5 Jan 2025 12:38:19 +0100
Message-ID: <20250105113822.108706-1-demonihin@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaces watchdog timer with delayed_work as advised
in the driver's TODO comment.

Signed-off-by: Dmitrii Ermakov <demonihin@gmail.com>
---
V1 -> V2: Removed redundant line wraps, renamed e1000_watchdog to e1000_watchdog_work

 drivers/net/ethernet/intel/e1000e/e1000.h  |  4 +--
 drivers/net/ethernet/intel/e1000e/netdev.c | 42 ++++++++--------------
 2 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index ba9c19e6994c..5a60372d2158 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -189,12 +189,12 @@ struct e1000_phy_regs {
 
 /* board specific private data structure */
 struct e1000_adapter {
-	struct timer_list watchdog_timer;
 	struct timer_list phy_info_timer;
 	struct timer_list blink_timer;
 
+	struct delayed_work watchdog_work;
+
 	struct work_struct reset_task;
-	struct work_struct watchdog_task;
 
 	const struct e1000_info *ei;
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 286155efcedf..cb68662cdc3a 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1778,7 +1778,7 @@ static irqreturn_t e1000_intr_msi(int __always_unused irq, void *data)
 		}
 		/* guard against interrupt when we're going down */
 		if (!test_bit(__E1000_DOWN, &adapter->state))
-			mod_timer(&adapter->watchdog_timer, jiffies + 1);
+			queue_delayed_work(system_wq, &adapter->watchdog_work, 1);
 	}
 
 	/* Reset on uncorrectable ECC error */
@@ -1857,7 +1857,7 @@ static irqreturn_t e1000_intr(int __always_unused irq, void *data)
 		}
 		/* guard against interrupt when we're going down */
 		if (!test_bit(__E1000_DOWN, &adapter->state))
-			mod_timer(&adapter->watchdog_timer, jiffies + 1);
+			queue_delayed_work(system_wq, &adapter->watchdog_work, 1);
 	}
 
 	/* Reset on uncorrectable ECC error */
@@ -1901,7 +1901,7 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
 		hw->mac.get_link_status = true;
 		/* guard against interrupt when we're going down */
 		if (!test_bit(__E1000_DOWN, &adapter->state))
-			mod_timer(&adapter->watchdog_timer, jiffies + 1);
+			queue_delayed_work(system_wq, &adapter->watchdog_work, 1);
 	}
 
 	if (!test_bit(__E1000_DOWN, &adapter->state))
@@ -4287,7 +4287,8 @@ void e1000e_down(struct e1000_adapter *adapter, bool reset)
 
 	napi_synchronize(&adapter->napi);
 
-	del_timer_sync(&adapter->watchdog_timer);
+	cancel_delayed_work_sync(&adapter->watchdog_work);
+
 	del_timer_sync(&adapter->phy_info_timer);
 
 	spin_lock(&adapter->stats64_lock);
@@ -5169,25 +5170,12 @@ static void e1000e_check_82574_phy_workaround(struct e1000_adapter *adapter)
 	}
 }
 
-/**
- * e1000_watchdog - Timer Call-back
- * @t: pointer to timer_list containing private info adapter
- **/
-static void e1000_watchdog(struct timer_list *t)
+static void e1000_watchdog_work(struct work_struct *work)
 {
-	struct e1000_adapter *adapter = from_timer(adapter, t, watchdog_timer);
-
-	/* Do the rest outside of interrupt context */
-	schedule_work(&adapter->watchdog_task);
-
-	/* TODO: make this use queue_delayed_work() */
-}
-
-static void e1000_watchdog_task(struct work_struct *work)
-{
-	struct e1000_adapter *adapter = container_of(work,
-						     struct e1000_adapter,
-						     watchdog_task);
+	struct delayed_work *dwork =
+		container_of(work, struct delayed_work, work);
+	struct e1000_adapter *adapter =
+		container_of(dwork, struct e1000_adapter, watchdog_work);
 	struct net_device *netdev = adapter->netdev;
 	struct e1000_mac_info *mac = &adapter->hw.mac;
 	struct e1000_phy_info *phy = &adapter->hw.phy;
@@ -5416,8 +5404,8 @@ static void e1000_watchdog_task(struct work_struct *work)
 
 	/* Reset the timer */
 	if (!test_bit(__E1000_DOWN, &adapter->state))
-		mod_timer(&adapter->watchdog_timer,
-			  round_jiffies(jiffies + 2 * HZ));
+		queue_delayed_work(system_wq, &adapter->watchdog_work,
+				   round_jiffies(2 * HZ));
 }
 
 #define E1000_TX_FLAGS_CSUM		0x00000001
@@ -7596,11 +7584,10 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_eeprom;
 	}
 
-	timer_setup(&adapter->watchdog_timer, e1000_watchdog, 0);
 	timer_setup(&adapter->phy_info_timer, e1000_update_phy_info, 0);
+	INIT_DELAYED_WORK(&adapter->watchdog_work, e1000_watchdog_work);
 
 	INIT_WORK(&adapter->reset_task, e1000_reset_task);
-	INIT_WORK(&adapter->watchdog_task, e1000_watchdog_task);
 	INIT_WORK(&adapter->downshift_task, e1000e_downshift_workaround);
 	INIT_WORK(&adapter->update_phy_task, e1000e_update_phy_task);
 	INIT_WORK(&adapter->print_hang_task, e1000_print_hw_hang);
@@ -7741,11 +7728,10 @@ static void e1000_remove(struct pci_dev *pdev)
 	 * from being rescheduled.
 	 */
 	set_bit(__E1000_DOWN, &adapter->state);
-	del_timer_sync(&adapter->watchdog_timer);
+	cancel_delayed_work_sync(&adapter->watchdog_work);
 	del_timer_sync(&adapter->phy_info_timer);
 
 	cancel_work_sync(&adapter->reset_task);
-	cancel_work_sync(&adapter->watchdog_task);
 	cancel_work_sync(&adapter->downshift_task);
 	cancel_work_sync(&adapter->update_phy_task);
 	cancel_work_sync(&adapter->print_hang_task);
-- 
2.45.2


