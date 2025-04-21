Return-Path: <netdev+bounces-184433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9FDA9569D
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 21:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676B11892B77
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 19:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA121EF087;
	Mon, 21 Apr 2025 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyWDJ/AQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B731EBFFF;
	Mon, 21 Apr 2025 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745263030; cv=none; b=T9Pb/+bRaqbx38a0HgaQf46zvNzX3nI7nHm8Da42NWMyCa5qRadZ/s5v123Hg+kHcQ38znX5BrPeHG5++1esykT3bCaTicUF+YjyW/uuxRGrFuSHtoCGzJ/Cl9aPgEnoPumsLHPdOd5lH94IckB+LcqSnjFsB/7r/7OMEdh6wdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745263030; c=relaxed/simple;
	bh=vNVjzy6SY6NB8V0+5kVwIcx0deQrkMhPB96hHSvdq/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J8/HPBBqk49Tw/H73tHIqDmfV7mWDFeAN4AxsuS7hWWZgsP5PvOV3u3tzD9C4fpMlTT74I4N0a6ipj11m70HM781PPQfl6A0g6SjEfFSDhezLe8AbdAJdWGO+effK9H27SmSa5y4MpcrxDCGHDPYXHnWE+FkKSHhHqHReMudPiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyWDJ/AQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-aee773df955so4277903a12.1;
        Mon, 21 Apr 2025 12:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745263028; x=1745867828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F874gon9E3P4hwlV/yFSCkcXv75v2itLgs6pZvbeUpA=;
        b=LyWDJ/AQA8bnh+J+IZwX/LunlaUpPywOP5VoyhYzmA2TL3mmxW6X0yydPPm3VMD0p5
         eyVimzavEFXh6yFEkp+0oKCOONglIFhvFW+nDXV7oOLjS4rWhDp7cCtisVZbAOmIcNyM
         0YqH1+GpnWOlLK+No2GDFoffAflijkMaBwn2GxkDmTk2q3Svog1/mWs8BqDfZ1wngDFB
         m449sHL4eQP+8su+zxJzDzer24afyIpZ/cWzsxAt3CnF1YrhHv9Wy6kWqhdNORfZCfDC
         yQDOesKXsSKoKbK2G3VPKuxREc819vKptHWmIC3k8C/I+eybQFfZEXBJv9JqEbq3cUIT
         6GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745263028; x=1745867828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F874gon9E3P4hwlV/yFSCkcXv75v2itLgs6pZvbeUpA=;
        b=V+bK7wyX83QgG3p6+Co/YZsOB0Ctnal0qu2F2Ci44wwF2EFkN3gUtktBZVrp5xWQoO
         3BlQHdXV1TA6O90cdPaURZedZs1nXUIrzr1PNt7n2HTVZdxOVjfVKPygUD/eNZkFcxjS
         MWEHT2MiddNPL+jDscfVVWjPm1EQ+AP72EV+D6vdwLgfCUj18fgmkQRtFmoMuAXsXTZT
         BPNJTAot8yIJ3LSPVtRnLlq7mjfDu5D9ZscKs62uMydsfOO4mqSybQbE2RTxaXroGoCh
         uvqKCLWUG0A3nk0eim7jWmb3S6bCHfOsV3TkU7MYR/Ek8wJonsm7QVhYE+txNJTiYSoS
         SIDw==
X-Forwarded-Encrypted: i=1; AJvYcCU46gXrkxnuRbwld3DmjRSezuWHNvYJs3efw3KhE/RFGdanpVukBRNTIOzpjwiGRlJKoQZwHK2BlFb86xc=@vger.kernel.org, AJvYcCUugO8bZp9rBd9QXhOe/zRCuOzLF7Qv2vkKwaofnCEKdfFZoP20O0qRmYer7DXozKjwzERKxFn1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4SrwzWBtcQ7Vab2BGuCWfd815X8iQ1OP3UoVJFAHXuL/a8Wiz
	GF1+uH+9Zqy46kkNPKSUpPwh3djm2RzKP3auixsNZzfZcrBEWudz
X-Gm-Gg: ASbGncsdkSYrhwyrydN5fhH+JihASDjisTMmypmhmXalLbQ1xZexfzaUmCgzbEDATks
	3vZESCSwRBB91pfS4SJFBXfKdod8axEhMk9MKIBppJzuCKnDIxpwS2N8IEexiITzUlLWgQcjTlG
	L/AaVLjmZWgeSa2FhwxoPF/4n76cbWimC3i59fvk+w56RXzFbXvmBPmPb4GFiu6LwgZumglHQf7
	y7HazKWCydP0EBU1iiuAUq8Oaz+HHD4wjkGu9GwhzIpQcpjITSvLZ1TF6VieZe6uVGTqJbiTzNj
	G0Xu3u1y4nU0xKy1xWTBZiJnTCz+BBjWb0gD7LKNAw==
X-Google-Smtp-Source: AGHT+IH6t+tcpp4993pIVk43Qfm1vQX+JJNqthrLys0H4E9YIC8cmt+4g1IsPuNP9Vkk7i0VPJDevA==
X-Received: by 2002:a17:90b:51c1:b0:2ff:71d2:ee8f with SMTP id 98e67ed59e1d1-3087c361083mr19056772a91.13.1745263027604;
        Mon, 21 Apr 2025 12:17:07 -0700 (PDT)
Received: from mythos-cloud.. ([125.138.201.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df24097sm6968738a91.21.2025.04.21.12.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 12:17:07 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Moon Yeounsu <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dlink: add synchronization for stats update
Date: Tue, 22 Apr 2025 04:16:44 +0900
Message-ID: <20250421191645.43526-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are two paths that call `get_stats()`:
    1. From user space via the `ip` command
    2. From interrupt context via `rio_interrupt()`

Case 1 is synchronized by `rtnl_lock()`, so it is safe.
However, the two cases above are not synchronized with each other.
Therefore, `spin_lock` is needed to protect `get_stats()` as it can be
preempted by an interrupt. In this context, `spin_lock_irq()` is required
(using `spin_lock_bh()` may result in a deadlock).

While `spin_lock` protects `get_stats()`, it does not protect updates to
`dev->stats.tx_errors` and `dev->stats.collisions`, which may be
concurrently modified by the interrupt handler and user space.
By using temporary variables in `np->tx_errors` and `np->collisions`,
we can safely update `dev->stats` without additional locking.

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
Question:
	This might be a bit off-topic, but I don’t fully understand why a single global
	`rtnl_lock` is used for synchronization. While I may not be fully aware of the 
	design rationale, it seems somewhat suboptimal. I believe it could be improved.
---
 drivers/net/ethernet/dlink/dl2k.c | 11 +++++++++--
 drivers/net/ethernet/dlink/dl2k.h |  5 +++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index d0ea92607870..2d929a83e101 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -865,7 +865,7 @@ tx_error (struct net_device *dev, int tx_status)
 	frame_id = (tx_status & 0xffff0000);
 	printk (KERN_ERR "%s: Transmit error, TxStatus %4.4x, FrameId %d.\n",
 		dev->name, tx_status, frame_id);
-	dev->stats.tx_errors++;
+	np->tx_errors++;
 	/* Ttransmit Underrun */
 	if (tx_status & 0x10) {
 		dev->stats.tx_fifo_errors++;
@@ -904,7 +904,7 @@ tx_error (struct net_device *dev, int tx_status)
 	}
 	/* Maximum Collisions */
 	if (tx_status & 0x08)
-		dev->stats.collisions++;
+		np->collisions++;
 	/* Restart the Tx */
 	dw32(MACCtrl, dr16(MACCtrl) | TxEnable);
 }
@@ -1074,6 +1074,7 @@ get_stats (struct net_device *dev)
 #endif
 	unsigned int stat_reg;
 
+	spin_lock_irq(&np->stats_lock);
 	/* All statistics registers need to be acknowledged,
 	   else statistic overflow could cause problems */
 
@@ -1085,6 +1086,7 @@ get_stats (struct net_device *dev)
 	dev->stats.multicast = dr32(McstFramesRcvdOk);
 	dev->stats.collisions += dr32(SingleColFrames)
 			     +  dr32(MultiColFrames);
+	dev->stats.collisions += np->collisions;
 
 	/* detailed tx errors */
 	stat_reg = dr16(FramesAbortXSColls);
@@ -1095,6 +1097,8 @@ get_stats (struct net_device *dev)
 	dev->stats.tx_carrier_errors += stat_reg;
 	dev->stats.tx_errors += stat_reg;
 
+	dev->stats.tx_errors += np->tx_errors;
+
 	/* Clear all other statistic register. */
 	dr32(McstOctetXmtOk);
 	dr16(BcstFramesXmtdOk);
@@ -1123,6 +1127,9 @@ get_stats (struct net_device *dev)
 	dr16(TCPCheckSumErrors);
 	dr16(UDPCheckSumErrors);
 	dr16(IPCheckSumErrors);
+
+	spin_unlock_irq(&np->stats_lock);
+
 	return &dev->stats;
 }
 
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 195dc6cfd895..dc8755a69b73 100644
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
@@ -401,6 +403,9 @@ struct netdev_private {
 	u16 negotiate;		/* Negotiated media */
 	int phy_addr;		/* PHY addresses. */
 	u16 led_mode;		/* LED mode read from EEPROM (IP1000A only) */
+
+	u64 collisions;
+	u64 tx_errors;
 };
 
 /* The station address location in the EEPROM. */
-- 
2.49.0


