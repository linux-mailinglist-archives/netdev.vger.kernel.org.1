Return-Path: <netdev+bounces-128390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358AF9794EA
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 09:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B375B2840D0
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 07:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78FEDDAB;
	Sun, 15 Sep 2024 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJNt6w84"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07C1B85D6;
	Sun, 15 Sep 2024 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726383834; cv=none; b=Cd5hRYfJgeS2afaIeu+9tT/89q36+KURVlyrDbo4r4baOGqsxgPSOQ9sint0UNxv3FjVy9mfgwu9Jclp2N68p6FvVM9pl1VFDDBPqHBkLn2r0SG+oMbaC0pA9oIYLXIIC8JXDNXy8HHX8RgM73ei1A41qCPMTRS6P+3v0Ihn180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726383834; c=relaxed/simple;
	bh=XAvSYzT+vQG5PeBsmtpVZNzFheuGk5PMCw6RUE9MaaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UV52cLu6mfMVpXi88MLlne1/OAQFNpqeDjsvi3ikLFHW0z4o+BkkDNqxqWfRDORnnRBote571HmVHfDlksUSOEeYT56+bi//9SbcbIwN2Mvk8KiXNHKW16/UYBQOT7GoUxtGLDQ8u5RUgqh1I0KWhFDpAf/4J+nzQ9S91+1tdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJNt6w84; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so38778171fa.3;
        Sun, 15 Sep 2024 00:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726383831; x=1726988631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KEavmw2LUY976ET169IA5SeQMrU1JxBvwS/MFJxjHsg=;
        b=mJNt6w849ru1FM4oB8puvpLtmQNeXFLzyrgcoy7CTqFVSWbiw7sEMgOmYRBZbxwWM1
         ki3mRaAqu8G3kW7hYYaHhCb0O7G6ujnNOwQghfF3xVVzQ+seoXAV9aKPmxptPxi5DClS
         Wzq2LJRBETR09L/CxbSam+SsjfoFudswlxiONh45STfn2d6vUgWQIUCk/ubpx0GYFYLW
         /rgxC0OGouTUsbJ68vGMjXz/s+xZG3MKlZgdV3TqyKWkMsKHoaHzP9BWAofgtkIuNJTi
         NOPLgFQsQ7VOZUkb7HLM+RaP8Uw+Rnu2jdBedubYFPsGgFfHlNRlviraj86dcakcN12F
         CAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726383831; x=1726988631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEavmw2LUY976ET169IA5SeQMrU1JxBvwS/MFJxjHsg=;
        b=VlYVQ+6nMPKA1e7gW3Lc+wmZcblWqGcHhqNS9HJVYWX5aQc1o4f+NCJ5P/7zEUK9W5
         h76r5OUj+0IqJEqjQg4QJrQwvlUDEj8LbutPSzDbu/hwxpzKpJqI4vy7VnXJ09yi4SFd
         T/n0XIvNQoECTroL2K2/dUNN7Y1MMcps0d3utV/f0Y5aMFNcQ0kBR4shZq76C8YayfW4
         bLqYLeV9pkCimPFpgQKzVXrGzdQ6fsdNhcU8KUeIc1jd5+r/FYtwEvBMID5IhA0yHQYM
         kKPY83zOAFGkCXXivhlL2jZ9l7mO5vCcZx1uW+w5CLB8S/qDo5S89qzh2Y0ZbprpIgS9
         G8xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzirzcWaDOxDR9/B7Ibl1OT4MP47HUTeJyr4NX0H4b/A75S8z4uT/Fte+89JAqS121Ckf/3HFm@vger.kernel.org, AJvYcCW77qQn3hmpWmhRCLociC3PGt9r3fnYj0eCO0vzmqpnMBfCgj6Ak3ViCx3bBk3toPaUbU5FWe2OU44sbEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0NG+sP+Hd/4bPbnuDS0iEBRFZxGd0/O3mmagVK9QuJpX0Ztnj
	aq1Pw58t2BLTAG5gHLuBQvtEd+84xp87QtBfb4bagqjUMuS9hHAY
X-Google-Smtp-Source: AGHT+IFVMZF1BrveCxcSafa+dUJ6XIlXXCTk+1Y1FY1q/mSb956LWqbntUQTWqQ2cxGtHWK0k8ZLyg==
X-Received: by 2002:a2e:a988:0:b0:2f7:4fac:f69f with SMTP id 38308e7fff4ca-2f787dbf3e3mr63663781fa.12.1726383830612;
        Sun, 15 Sep 2024 00:03:50 -0700 (PDT)
Received: from localhost.localdomain (81-225-142-40-no600.tbcn.telia.com. [81.225.142.40])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d301776sm4475061fa.54.2024.09.15.00.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 00:03:49 -0700 (PDT)
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
Subject: [PATCH] e1000e: makes e1000_watchdog_task use queue_delayed_work
Date: Sun, 15 Sep 2024 09:03:21 +0200
Message-ID: <20240915070334.1267-1-demonihin@gmail.com>
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
 drivers/net/ethernet/intel/e1000e/e1000.h  |  4 +-
 drivers/net/ethernet/intel/e1000e/netdev.c | 43 ++++++++--------------
 2 files changed, 18 insertions(+), 29 deletions(-)

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
index 360ee26557f7..5b7a3a1423ed 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1778,7 +1778,8 @@ static irqreturn_t e1000_intr_msi(int __always_unused irq, void *data)
 		}
 		/* guard against interrupt when we're going down */
 		if (!test_bit(__E1000_DOWN, &adapter->state))
-			mod_timer(&adapter->watchdog_timer, jiffies + 1);
+			queue_delayed_work(system_wq, &adapter->watchdog_work,
+					   1);
 	}
 
 	/* Reset on uncorrectable ECC error */
@@ -1857,7 +1858,8 @@ static irqreturn_t e1000_intr(int __always_unused irq, void *data)
 		}
 		/* guard against interrupt when we're going down */
 		if (!test_bit(__E1000_DOWN, &adapter->state))
-			mod_timer(&adapter->watchdog_timer, jiffies + 1);
+			queue_delayed_work(system_wq, &adapter->watchdog_work,
+					   1);
 	}
 
 	/* Reset on uncorrectable ECC error */
@@ -1901,7 +1903,8 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
 		hw->mac.get_link_status = true;
 		/* guard against interrupt when we're going down */
 		if (!test_bit(__E1000_DOWN, &adapter->state))
-			mod_timer(&adapter->watchdog_timer, jiffies + 1);
+			queue_delayed_work(system_wq, &adapter->watchdog_work,
+					   1);
 	}
 
 	if (!test_bit(__E1000_DOWN, &adapter->state))
@@ -4293,7 +4296,8 @@ void e1000e_down(struct e1000_adapter *adapter, bool reset)
 
 	napi_synchronize(&adapter->napi);
 
-	del_timer_sync(&adapter->watchdog_timer);
+	cancel_delayed_work_sync(&adapter->watchdog_work);
+
 	del_timer_sync(&adapter->phy_info_timer);
 
 	spin_lock(&adapter->stats64_lock);
@@ -5164,25 +5168,12 @@ static void e1000e_check_82574_phy_workaround(struct e1000_adapter *adapter)
 	}
 }
 
-/**
- * e1000_watchdog - Timer Call-back
- * @t: pointer to timer_list containing private info adapter
- **/
-static void e1000_watchdog(struct timer_list *t)
-{
-	struct e1000_adapter *adapter = from_timer(adapter, t, watchdog_timer);
-
-	/* Do the rest outside of interrupt context */
-	schedule_work(&adapter->watchdog_task);
-
-	/* TODO: make this use queue_delayed_work() */
-}
-
 static void e1000_watchdog_task(struct work_struct *work)
 {
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
@@ -5411,8 +5402,8 @@ static void e1000_watchdog_task(struct work_struct *work)
 
 	/* Reset the timer */
 	if (!test_bit(__E1000_DOWN, &adapter->state))
-		mod_timer(&adapter->watchdog_timer,
-			  round_jiffies(jiffies + 2 * HZ));
+		queue_delayed_work(system_wq, &adapter->watchdog_work,
+				   round_jiffies(2 * HZ));
 }
 
 #define E1000_TX_FLAGS_CSUM		0x00000001
@@ -7588,11 +7579,10 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_eeprom;
 	}
 
-	timer_setup(&adapter->watchdog_timer, e1000_watchdog, 0);
 	timer_setup(&adapter->phy_info_timer, e1000_update_phy_info, 0);
+	INIT_DELAYED_WORK(&adapter->watchdog_work, e1000_watchdog_task);
 
 	INIT_WORK(&adapter->reset_task, e1000_reset_task);
-	INIT_WORK(&adapter->watchdog_task, e1000_watchdog_task);
 	INIT_WORK(&adapter->downshift_task, e1000e_downshift_workaround);
 	INIT_WORK(&adapter->update_phy_task, e1000e_update_phy_task);
 	INIT_WORK(&adapter->print_hang_task, e1000_print_hw_hang);
@@ -7733,11 +7723,10 @@ static void e1000_remove(struct pci_dev *pdev)
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


