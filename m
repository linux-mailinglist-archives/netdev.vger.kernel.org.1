Return-Path: <netdev+bounces-131336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9050C98E1E9
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 19:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEAABB21690
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7A71D175F;
	Wed,  2 Oct 2024 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMUtQH+y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5939C1D0BA2;
	Wed,  2 Oct 2024 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891584; cv=none; b=Ib6K2nq1w0zUiETcUeTpAha00jsYLxim57yVLU4TT4Gwi5lHFS+DLz4VioP+RXEG1Iak5ZXKyKK8gwHi+iWbXS/BrPvg4YGDE/clphtyCBXaENBYMhVeqJqxLHsbUqR4fLwn0lz6t2C7yocwWkYWfSygdVAVfIRA0CG62fGkcbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891584; c=relaxed/simple;
	bh=hEq1ddkphnQ6sKXpFedhMvgdGKGilXS89Vlu7DKKrcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/FNZMRVULdDkejf0XohJJbAMmB223KKmcaPFSDuP0OxnjVeNJsPdQT/kPQ15odl10LfbeHUrEePbFxjJ7ETVa5ebBZ8s5Vv7Bau5OFb4y6/gzsxFwaZl+O52I/zauQ5R89QnugA/XpsSqrQAbNqEmVAYlCNDFvN/YIIU7afzoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMUtQH+y; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2facf00b0c7so10067961fa.1;
        Wed, 02 Oct 2024 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727891580; x=1728496380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j1KvCZ7gaXzt52gPxua+C5bMinjON5snkugcQdtgk70=;
        b=BMUtQH+y+doeb0CMyAoy56PdsOkk9r1Y4jAr8lZIumJRhj0Y0NvAo5s84p7KNhSuG+
         IzVnqNjT6mNiRpVtRLfpzHfOw5ekO2eXU2VEgWftsKUfFO4tjrc5uHaZSqThr2RcQw14
         rf4dhHu1rECIrehTm1zrxZsVzBpKDbqvvlEvqcXWJKvs24zlEPKIFi111n8mI3DaE28J
         uqmmfPiwqAWeJ7VEmNC5m0kiFC6RnY4lANULaNEqTuaGgt+t1+e9nvLsz19BD4LZJqRK
         iZsrjbuTx5sPp7D6pkZQwuO+rgKHbX6+XfVZ8nOiTgthDSf58kBhoW762R99OusxYuwC
         9E6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727891580; x=1728496380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1KvCZ7gaXzt52gPxua+C5bMinjON5snkugcQdtgk70=;
        b=KV23R36JUQ5woNyyDhARxflwRbQUPvzFqjx/n909iSCgJgDbRzGGFKDcpDAB5UQe7I
         XdXnyA9js4RIkdbQbisixpguW6bnZCqSE1zlErn72Szw4fu3feFP8HtglqaF8Um8tq0Q
         jZmJ1oQrQ6CS70gDgyqBvUOR1wCPH9eK4Yq3E7mN4yCB/29QRFA6yRx+nilGa+1uInPe
         6OGMA5bc+P5lAGi54JAmliGPoOlAQdWORZ3Bg7QdWbK3ZyHsQ5tvVwDtEBNJ4f57M129
         FTLyiK6aKZsckaG4RZWBIz3xwxJ3/gNRShP3JT9XVGzmYUSd83t0A5uR8XOUet7T9Pj5
         Sb9A==
X-Forwarded-Encrypted: i=1; AJvYcCUv2GQcW1/139eubXWOZT5iBQv36FluLxhZWq4M2UVaE1G72bbrqtExNt+v3OQVxPzsn6/H6z8dGf1PCVk=@vger.kernel.org, AJvYcCXQcQK9XY8xQEzrLDvkIVrmtrgGG/eZ76+ugyo98Is8a3URhT5ccj60+eeStVwBPIUspEZhm+/N@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/J3dAI42yldpmMXr+0NVzCyR9yTELHv1SuiMYDK2c78jOYWE6
	LvdMXfTFgjl127YHepWHbKAwIWVDWMesmv7WwhPLMgcojWMlfEm3axXN/7YC
X-Google-Smtp-Source: AGHT+IGa18kvxvg8Vx8+TvCEpf9WV9I6u3h8TcPjesh3PjmhEGgbC4i0pCBjyNko56nxv1HoL5TG/w==
X-Received: by 2002:a05:6512:a8b:b0:539:8bc9:b354 with SMTP id 2adb3069b0e04-539a6260868mr169443e87.9.1727891580038;
        Wed, 02 Oct 2024 10:53:00 -0700 (PDT)
Received: from laptop.dev.lan ([2001:2040:c00f:15c::4159])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043bb4esm1958968e87.234.2024.10.02.10.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 10:52:59 -0700 (PDT)
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
Subject: [PATCH v2 net-next] e1000e: makes e1000_watchdog_task use queue_delayed_work
Date: Wed,  2 Oct 2024 18:59:15 +0200
Message-ID: <20241002165957.36513-2-demonihin@gmail.com>
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
index f103249b12fa..495693bca2b1 100644
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
@@ -4293,7 +4293,8 @@ void e1000e_down(struct e1000_adapter *adapter, bool reset)
 
 	napi_synchronize(&adapter->napi);
 
-	del_timer_sync(&adapter->watchdog_timer);
+	cancel_delayed_work_sync(&adapter->watchdog_work);
+
 	del_timer_sync(&adapter->phy_info_timer);
 
 	spin_lock(&adapter->stats64_lock);
@@ -5164,25 +5165,12 @@ static void e1000e_check_82574_phy_workaround(struct e1000_adapter *adapter)
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
@@ -5411,8 +5399,8 @@ static void e1000_watchdog_task(struct work_struct *work)
 
 	/* Reset the timer */
 	if (!test_bit(__E1000_DOWN, &adapter->state))
-		mod_timer(&adapter->watchdog_timer,
-			  round_jiffies(jiffies + 2 * HZ));
+		queue_delayed_work(system_wq, &adapter->watchdog_work,
+				   round_jiffies(2 * HZ));
 }
 
 #define E1000_TX_FLAGS_CSUM		0x00000001
@@ -7591,11 +7579,10 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -7736,11 +7723,10 @@ static void e1000_remove(struct pci_dev *pdev)
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


