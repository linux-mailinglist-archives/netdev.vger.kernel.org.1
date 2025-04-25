Return-Path: <netdev+bounces-186180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB882A9D619
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07CC178A67
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0DD2973CA;
	Fri, 25 Apr 2025 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yym5k9DV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0621ABD6;
	Fri, 25 Apr 2025 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622927; cv=none; b=aL24s0fGhAzJqSjtaVgEunFheLqmHWvqaiETzDEV35iQRZgH35ljZLYJpwzltS3WLKn0w00lC6eEBzALR0vInAItVkTZr8yOt6GtN4MpcQyZLcjRSmGwyt//vVbCNahsllO8nsZB/ZyGitLhAHuni6mLodUvBJaAl7bJa+S4mO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622927; c=relaxed/simple;
	bh=vsFKpSpZnGhZifAM23UK3UzlMYS9tXWLxNc3v4lm3Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pR1OHXbVJMkIfuGmc8AsdoWOm/tVPwRlxzfNyzTjkkdtoEawbpLydaYzMZJH34kiUK2rcf3CD0YAfUOxkWoPXbP5fNcRotYEHglT3wSd9Ar5rYjmrUMbsHn83y+h+Ojl4V6QUdnznbpe8GsJNi1JzGgsFYRU9GfIHX2P0s5K0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yym5k9DV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224019ad9edso41653735ad.1;
        Fri, 25 Apr 2025 16:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745622925; x=1746227725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad7ab9Hi/U7rnoziyztPIwqTOAC6c1GvW0nqsLo6SJI=;
        b=Yym5k9DVAqR2pbIuMA7lkg6vuVnUmOAyJ/cxpwIvaW/s8J3tOWYkw/s0c9QWyfsq+y
         5zYXdN8HaKue3lYNlwNOPORohE7gkfIGQVFCxlqmHLVQmfaDwVFHDlJo6obCBP1EuraV
         sWFC7Ung7QajJFFXyJczCicCUBGLYUdGwolc+ihW7Na/H3rGtlkMYoxX9GWq7+YcA63K
         VRVoBeJN+3uO4Wyjk+W/ubE4wvW3Uc5633Md7i8rJWxbmapjnCZTUeyVJevXC2jeo7xW
         yGoIvea5xoOhEXsouuFjs+pKcPOX3xel8/jZ4HhjAQQx2G92WZF/8N2YZdzeA5lc1gkM
         jv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745622925; x=1746227725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ad7ab9Hi/U7rnoziyztPIwqTOAC6c1GvW0nqsLo6SJI=;
        b=aSzc/fYhuc0Wtr5VD6MVv13zhdnGXAitc5HEqROMMnueKd/juCqlZ36cynUIAzkjU2
         92j0bJPKwizXJpzJYlwBDal/w4CPZF6ETdtUmNqrk73V+Cn4uqOncZHV1welEKvNSgqv
         QSez4AxiepW6Q/uOAfCvDk2rXMCTmQJnENfpmCsAs+oLzIkeAOu+UtOornlEAWt3YrZE
         glHweVUlSWnJmM5owwASeeWbgcljTsuNLJBBf/JOeLbKQvJm827IqPTmJZMkl0rdbFjk
         nlHEHKaGOW7alP8R6DDyRDjW+EPWUnJsEiUjF6FUZIFsBMNtwxRGJmr3lnPHaK62OPoS
         ISEA==
X-Forwarded-Encrypted: i=1; AJvYcCU82bBUNs9DbUTme6TH9Fa5YzAaLLvodPKITn/RBN6gB2PzEIR7CXEUzeEiDaUWsudKEBG3Av4x@vger.kernel.org, AJvYcCU9oQXyyoq41YT410RRA7W5dnTnzg40CfuxlOB4pfFgAFv6U6KQSyFV/X0kRJ9f7zel+ZlaUQTSo9R4Lds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEZ9YvM+uiauLSwNnFoPIyXEawTA7q/AG4BmQeOG25uIO2bow5
	dhgt+grQrft+XWleg/4lUN5iGcb1C+V0BE/nEcxOWgleWSm+S1l1
X-Gm-Gg: ASbGncuD5GNgAy+feQPzH/6JqKfy2bt0Wt//Cr1H9/Ey9pC8in1u14nhTjJeQhlkxYY
	fe1gvMp4fspn/xNGbtbRuIo7gv1ifY/n8gQV6BsMFRwptsq6dQNsyN94INGGmdjw1dJnKi9hvX6
	6DAaMPuuBF88xrrFjmCrAjb7Z98OotsQJXcQ02VXCiZujFaCDJGlWQVO51Cm1V1oZ7b2YFSm3Yc
	NCp0+YmENGmzA4zoT6Sa7r/39Ao4eCBKwy7/EmDhlBYwHf+RQVWfPHjKIwj3iBxk3vBLkURiUb0
	RZHeJjdaaaEe0jTnyGuEcOARzcqPjqboduP1j29HOQ==
X-Google-Smtp-Source: AGHT+IFrQfGBydx8cnsUqT3XFwz17wFaHW9pKFR5UQ9X+kB2b1/bZey7ss18z7TOgQ7RHqhwP6HkvQ==
X-Received: by 2002:a17:902:d2c8:b0:224:10a2:cad5 with SMTP id d9443c01a7336-22dbf4c8508mr64194745ad.10.1745622925235;
        Fri, 25 Apr 2025 16:15:25 -0700 (PDT)
Received: from mythos-cloud.. ([125.138.201.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15fa906da6sm3462952a12.62.2025.04.25.16.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 16:15:24 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Moon Yeounsu <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: dlink: add synchronization for stats update
Date: Sat, 26 Apr 2025 08:13:52 +0900
Message-ID: <20250425231352.102535-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two paths that call `get_stats()`:
    1. From user space via the `ip` command
    2. From interrupt context via `rio_interrupt()`

Case 1 is synchronized by `rtnl_lock()`, so it is safe.
However, the two cases above are not synchronized with each other.
Therefore, `spin_lock` is needed to protect `get_stats()` as it can be
preempted by an interrupt. In this context, `spin_lock_irq()` is required
(using `spin_lock_bh()` may result in a deadlock).

`dev->stats.tx_errors` and `dev->stats.collisions` may be
concurrently modified by the interrupt handler and user space, so
they are also protected by `spin_lock`.

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
Changelog:
v1: https://lore.kernel.org/netdev/20250421191645.43526-2-yyyynoom@gmail.com/
v2:
- fix incorrect method of updating `dev->stats.tx_errors` and
  `dev->stats.collisions`
---
 drivers/net/ethernet/dlink/dl2k.c | 11 ++++++++++-
 drivers/net/ethernet/dlink/dl2k.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index d88fbecdab4b..0a3ac9ba3729 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -865,7 +865,6 @@ tx_error (struct net_device *dev, int tx_status)
 	frame_id = (tx_status & 0xffff0000);
 	printk (KERN_ERR "%s: Transmit error, TxStatus %4.4x, FrameId %d.\n",
 		dev->name, tx_status, frame_id);
-	dev->stats.tx_errors++;
 	/* Ttransmit Underrun */
 	if (tx_status & 0x10) {
 		dev->stats.tx_fifo_errors++;
@@ -902,9 +901,15 @@ tx_error (struct net_device *dev, int tx_status)
 		rio_set_led_mode(dev);
 		/* Let TxStartThresh stay default value */
 	}
+
+	spin_lock_irq(&np->stats_lock);
 	/* Maximum Collisions */
 	if (tx_status & 0x08)
 		dev->stats.collisions++;
+
+	dev->stats.tx_errors++;
+	spin_unlock_irq(&np->stats_lock);
+
 	/* Restart the Tx */
 	dw32(MACCtrl, dr16(MACCtrl) | TxEnable);
 }
@@ -1074,6 +1079,7 @@ get_stats (struct net_device *dev)
 #endif
 	unsigned int stat_reg;
 
+	spin_lock_irq(&np->stats_lock);
 	/* All statistics registers need to be acknowledged,
 	   else statistic overflow could cause problems */
 
@@ -1123,6 +1129,9 @@ get_stats (struct net_device *dev)
 	dr16(TCPCheckSumErrors);
 	dr16(UDPCheckSumErrors);
 	dr16(IPCheckSumErrors);
+
+	spin_unlock_irq(&np->stats_lock);
+
 	return &dev->stats;
 }
 
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 195dc6cfd895..c24823e909ef 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -372,6 +372,8 @@ struct netdev_private {
 	struct pci_dev *pdev;
 	void __iomem *ioaddr;
 	void __iomem *eeprom_addr;
+	// To ensure synchronization when stats are updated.
+	spinlock_t stats_lock;
 	spinlock_t tx_lock;
 	spinlock_t rx_lock;
 	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
-- 
2.49.0


