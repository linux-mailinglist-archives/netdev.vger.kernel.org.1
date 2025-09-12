Return-Path: <netdev+bounces-222397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F63B5412A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 05:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731825A181E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 03:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F6C2676D9;
	Fri, 12 Sep 2025 03:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XWeS+fZS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B6261B75
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 03:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648748; cv=none; b=g2rtyxYtypttzRt/7LPUPs5zGgw1DnBBgCDWb7SLFukjcyaa8LW55GPR5NY6VInfOjrpJU0DAtc3O40izajtLJLJQUxQ4V41jM77W16m3AB70qlIJO1U6f9gUgsk96ME+gZrul020mwUBZ2K1FKFU1UFJhevLF44aRIZXBvYAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648748; c=relaxed/simple;
	bh=Ta7w7kzg2Da2Ms4qjfefxVRnX0W/a1reodjAWFN1BiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DF4aEND85jjI9817gCH4W7G1h0eHTbe0/hPiBq2vtzwasIiYhlgg56bSwBjnGl3XXm2SJWnKNH5qbIqGGkP9JP9rO1/WIXJuHqmlinURCLkjdi+5xaSyv5R1Pd1ED+Osu1otqxLh3aM4p96MYgNC/YswfiiDsPeBk5q3vNiVq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XWeS+fZS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32dc4faa0d7so1283627a91.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 20:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757648745; x=1758253545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=srRkUnraQe1DlU8ZTGy562oG8l2prFUcBJnvi6wBpa8=;
        b=XWeS+fZSu2yyWJJAulPfMETsUa8jGaK5pRn/2bRCCylv1yAraBdxd5cu0kVkBJoxCB
         hpgcc+/zJFbBAsL6p7Z9bqW5Om0Oy89ho/EYqu0mBP2WXA5XTLN3bMasSJuNnKXiKD/0
         9Pism5DcLUm7hLREp1MApuyRiPvjmlkI7kmjRiCB0pbFYNzCT0a8WnJsKbSXIYuVt460
         4EL+eNn3FVRGmbGSpjwuYCmEOiOweg3kFsNmECXzkBQ9DtA3lvcix9ff5IvaA429PXsy
         v8V2zEbRmXgQwW6ghH+OxaYRWEOopImeTOH2aq12Ivs7PUnwco51bLOjCsTFqRhb0r87
         qELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757648745; x=1758253545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srRkUnraQe1DlU8ZTGy562oG8l2prFUcBJnvi6wBpa8=;
        b=YU1z1eqJtjMJMAKV+0CFzHetXkWAicqXlL5cNilrTXHYQt5SWbaSOYx9hYXGtn7XrY
         XtWkuYDMA+85REnUXuSflKYae6TLJTmwYQRcwgbHZZKdo1dkBdHJU3UPIRxRPcEuZw+o
         fTy4X+6z4Vj6ppzdeMxy/Prk630ezoZD6bfdnrrrAeErYE5eS2+3blzRIDcj5augqmz6
         /QQDipOdTtncFt/0l7jICd2mlh+4FgiGJ2eOR6OeBblGOvEdrmDvIb8OfldV7mGOJGZ7
         9m67B+TsvKFMrChQ9FDb4Ncm2KA5QWfN4RtFBbblOFpIFDZB5Z9dYWuTKXJBtIR26SDs
         U5gw==
X-Gm-Message-State: AOJu0Yx83t5vMI+RS8dpHrhP8o6zM1u0KV0pDGLeQuTr9Pj7R+bn6zQt
	LGEQQf/haLpBskMD8jm/sQxJY6EDixGbgcy/rGcz9nv94nL2S8sxEniiTyBgQlsMS+M6y6wWHfx
	pG7RQOSo=
X-Gm-Gg: ASbGncsLNAmAdSlqduHpkYD7qnvvvwAk/Z2iajTnt6yU1gLJJ3jc2WG2us4EhJ6jjtO
	cgedRMh6GcD8fqpiN8L4fYejDOoKwGZPOmRgZt2tVrZYmE4oN1HEI9kwtxuuJEXUzO7JuS+i8BV
	HNVTHtWA2Ngthzsczo+TY2r7jsLmZZIdb9qm5LsGNWAcIeqKomAZx5aqf3jD3ZWS3zs20bcDhZB
	RWJk7DuKqYezIWO5JoZsuZg7WrLLONulnjfL5MVctueOUFLIlOo1ypdWTP+1TEyK6Kv0gNde9y2
	5+dqxoOPxV1ayHezGEGRfj3ywdc3BLfvXXr8sewSxuWGb5qx9br9gt7OPpCZZvE46FKzKV4eTLp
	mh9H+e3rBr9KJEn5VWVlmlrWBIk7lAIE1lrwyPDE=
X-Google-Smtp-Source: AGHT+IGR44LGnDHo06RJIktefSGeKyBeGQjrPpDFtTAcSFEoQH8sPjmw2kwB8RmI5j/XqLoeJw8IrA==
X-Received: by 2002:a17:90b:4ad2:b0:32d:d4fa:4b5 with SMTP id 98e67ed59e1d1-32de4e7d0c1mr1379053a91.2.1757648745477;
        Thu, 11 Sep 2025 20:45:45 -0700 (PDT)
Received: from localhost ([106.38.221.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32deacdf9bcsm258571a91.23.2025.09.11.20.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 20:45:45 -0700 (PDT)
From: Jian Zhang <zhangjian.3032@bytedance.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	guoheyi@linux.alibaba.com
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacky Chou <jacky_chou@aspeedtech.com>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jian Zhang <zhangjian.3032@bytedance.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Revert "drivers/net/ftgmac100: fix DHCP potential failure with systemd"
Date: Fri, 12 Sep 2025 11:45:38 +0800
Message-ID: <20250912034538.1406132-1-zhangjian.3032@bytedance.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 1baf2e50e48f10f0ea07d53e13381fd0da1546d2.

This patch can trigger a hung task when:
* rtnetlink is setting the link down
* the PHY state_queue is triggered and calls ftgmac100_adjust_link

Within the rtnetlink flow, `cancel_delayed_work_sync` is called while
holding `rtnl_lock`. This function cancels or waits for a delay work
item to complete. If the PHY state_queue (delay work) is simultaneously
executing `adjust_link`, it will eventually call `rtnl_lock` again,
causing a deadlock.

This results in the following (partial) trace:
* rtnetlink (do_setlink):
[  243.326104] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  243.334871] task:systemd-network state:D stack:0     pid:711   ppid:1      flags:0x0000080d
[  243.344233] Call trace:
[  243.346986]  __switch_to+0xac/0xd8
[  243.350814]  __schedule+0x3c0/0xb78
[  243.354734]  schedule+0x60/0xc8
[  243.358258]  schedule_timeout+0x188/0x230
[  243.362762]  wait_for_completion+0x7c/0x168
[  243.367461]  __flush_work+0x29c/0x4c8
[  243.371579]  __cancel_work_timer+0x130/0x1b8
[  243.376376]  cancel_delayed_work_sync+0x18/0x28
[  243.381463]  phy_stop+0x7c/0x170
[  243.385098]  ftgmac100_stop+0x78/0xf0
[  243.389213]  __dev_close_many+0xb4/0x160
[  243.393621]  __dev_change_flags+0xfc/0x250
[  243.398226]  dev_change_flags+0x28/0x78
[  243.402536]  do_setlink+0x258/0xdb0
[  243.406460]  rtnl_setlink+0xf0/0x1b8
[  243.410484]  rtnetlink_rcv_msg+0x2a0/0x768
[  243.415097]  netlink_rcv_skb+0x64/0x138
[  243.419473]  rtnetlink_rcv+0x1c/0x30
[  243.423540]  netlink_unicast+0x1c8/0x2a8
[  243.427973]  netlink_sendmsg+0x1c4/0x438
[  243.432402]  __sys_sendto+0xe4/0x178
[  243.436447]  __arm64_sys_sendto+0x2c/0x40
[  243.440966]  invoke_syscall.constprop.0+0x60/0x108
[  243.446397]  do_el0_svc+0xa4/0xc8
[  243.450171]  el0_svc+0x48/0x118
[  243.453710]  el0t_64_sync_handler+0x118/0x128
[  243.458648]  el0t_64_sync+0x14c/0x150

* state_queue (phy_state_machine):
[  242.882453] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  242.891226] task:kworker/3:0     state:D stack:0     pid:32    ppid:2      flags:0x00000008
[  242.900592] Workqueue: events_power_efficient phy_state_machine
[  242.907250] Call trace:
[  242.910001]  __switch_to+0xac/0xd8
[  242.913813]  __schedule+0x3c0/0xb78
[  242.917735]  schedule+0x60/0xc8
[  242.921268]  schedule_preempt_disabled+0x28/0x48
[  242.926449]  __mutex_lock+0x1cc/0x400
[  242.930565]  mutex_lock_nested+0x28/0x38
[  242.934971]  rtnl_lock+0x60/0x70
[  242.938607]  ftgmac100_reset+0x34/0x248
[  242.942919]  ftgmac100_adjust_link+0xe0/0x150
[  242.947816]  phy_link_change+0x34/0x68
[  242.952032]  phy_check_link_status+0x8c/0xf8
[  242.956829]  phy_state_machine+0x16c/0x2e0
[  242.961428]  process_one_work+0x258/0x620
[  242.965934]  worker_thread+0x1e8/0x3e0
[  242.970148]  kthread+0x114/0x120
[  242.973762]  ret_from_fork+0x10/0x20

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index a863f7841210..477719a518bc 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1448,17 +1448,8 @@ static void ftgmac100_adjust_link(struct net_device *netdev)
 	/* Disable all interrupts */
 	iowrite32(0, priv->base + FTGMAC100_OFFSET_IER);
 
-	/* Release phy lock to allow ftgmac100_reset to acquire it, keeping lock
-	 * order consistent to prevent dead lock.
-	 */
-	if (netdev->phydev)
-		mutex_unlock(&netdev->phydev->lock);
-
-	ftgmac100_reset(priv);
-
-	if (netdev->phydev)
-		mutex_lock(&netdev->phydev->lock);
-
+	/* Reset the adapter asynchronously */
+	schedule_work(&priv->reset_task);
 }
 
 static int ftgmac100_mii_probe(struct net_device *netdev)
-- 
2.47.0


