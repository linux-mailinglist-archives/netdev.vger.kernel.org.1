Return-Path: <netdev+bounces-190636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 647DAAB7F58
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 09:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F218C1BA0009
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 07:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1333280330;
	Thu, 15 May 2025 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffUnYvzQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B729280304;
	Thu, 15 May 2025 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295632; cv=none; b=K66kjV0KqzmIs3E7FMvcEBh5KjlikxUZnsiInNYkPfVcL4R0vsQmpHSWAnNxCKdTWjx2SrQH+QFAjQGlvJ4Rf8cmYz1k065sTt/fm/OHFUOREntBPMHCNGAZS0TzSUvQS9QVL3W5lHVFEyPgHqav1yF6qdO6FLdE97NjIIjBrDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295632; c=relaxed/simple;
	bh=wUEqgSTV2QgtgOIjx6bsDxFv4ShMZp2fM80qbS8rSiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+phS23JiyXYHmilmlME1YnLVFEcOfSldRI0S5calzzIGbLf8eY1ZJpZ0oHVqbncK5YkXRyBB5aMvFI3RjLjOcd8skm4MrkK2UgAI4tZL6RXVugPO4nRFpeaJzmVuSo5DNB9pMW+sjimAa1cw6D3qHfm/D8v64gR2MXgLoIOzaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffUnYvzQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7423fb98cb1so680306b3a.3;
        Thu, 15 May 2025 00:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747295630; x=1747900430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d6+1l6psSc4ieMT2IvTyMfmvtZ8uQROzlTdXH4Fr4sA=;
        b=ffUnYvzQ7XbzhYHIZhYhgBh6xzgkhlErhKH+0SHUy/cdhk0ggapLBYzO8t7rtiumo2
         1PMuugL+cvSq1Oc1TVzk7Zy3Lw0UpuTdXe1+2nDd3c0+8Iqe3JB553WV4CUQx7MQpbQN
         1+tk2zDnzfJGlqOBREoVhUJ7myX21SCYjg2+QVYWSlvXZDruP9NP9Cd1Pya7OtGyqphO
         ohhqjXPOpMOoUV9sf7TJ5t2HfHsb/w4bf5MDifKEEqEJqrkLBrs3xmdYbI+oCX+CNhZI
         zvk4uSATdF3kp/U2tbbMH9q/q0ZUh3na47esX00GvJG0+dXMT2FjslDmdQC2BlfcoWfK
         HhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747295630; x=1747900430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6+1l6psSc4ieMT2IvTyMfmvtZ8uQROzlTdXH4Fr4sA=;
        b=g08R7NHOTHobFExgrmznHl00taj/R0IgIMTlgq+RoMZKDlK3WferWyi9b+gZF0EwuL
         8k3n9rciJmC64KdYogsuyx7I76zS24aLerpgUPlu1SEkFJ3iEixLEKP8uhLXDI7N+Ckd
         e10mzR6qL/krhUNp3HH8rr8fzVywK+M+LvHRzQbkWOufeC1FwnP1adDoXQEBHpQUFqVK
         FspemQ2AQOOfMfLz13TgK7i9j7+BJO2lEK3l3r/zKXRHtbVwciMUx3G5cT+Rn+n1FpBa
         oLA4IlTg+jHU8gaLw2BZOD4QWzGqAFVF71gunC3x4gew0Ze/2UfOzO/tnMHCsrrsnk8w
         YlVg==
X-Forwarded-Encrypted: i=1; AJvYcCU1CaZSk25A5mrLeOkEkFF6d4dB9auQp1kz/0TLghtG7JpyJ7iopJSlvWws0Exji3kmkGtj+OTO@vger.kernel.org, AJvYcCXHHWfOPL7Q99SF8naafDRrRNPocsh/5VVrO5xXePYe9z6XqoI8ZgBqYePjw6fx9PPLpqG0OogU5eMBIoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrVirB+wqsHXMsHdsolt8m0cB5p6WefMA3H6e6i1X5ZwnKGrTH
	RpDbRMIXzpFP8uDFXp3nYeOsft/FB3uxPvgX2u5JQT+od4H9dghV
X-Gm-Gg: ASbGncukODwTfmMrlijJK3/lBEUIi/bGXtWR0Yoa1o6z+1ta7DVgM18+ssBNlgo9Z9Q
	dTdYV/tU2IwRy5RgI/ZnQ849c9h7rCDZJVF3sJxW9HE5NpVk1qq9P0G6e59az2+Vw4CIr8AB84e
	+VGVQR9Oen5opW4w1KhR15AXDcGAmPtuWEQC83zHoG+zhnJm4P6A7eFdl2BOskQenK05oe9W9ql
	3INMEB2Cx4hiIbX2l5Nw4LgVWQpJu/DWf4VRal2nPUoXA/IAE35OHdmJ9WhEuiEmounrweCenIM
	sAncR29jSmtbrOK8/eC7gNBS3JDkfHDpiRAviiL3AN5bRQ50r+cm
X-Google-Smtp-Source: AGHT+IHKeW/lRf4A736uiyEk8pb1EFNbX4MNRx95s1GbRRKiftyq5dFJydREqeAw1RiiX8blRyYUDg==
X-Received: by 2002:a05:6a00:2987:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-742892680f5mr7842964b3a.5.1747295630226;
        Thu, 15 May 2025 00:53:50 -0700 (PDT)
Received: from mythos-cloud.. ([125.138.201.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237704dc0sm10666148b3a.7.2025.05.15.00.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 00:53:49 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Moon Yeounsu <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: dlink: add synchronization for stats update
Date: Thu, 15 May 2025 16:53:31 +0900
Message-ID: <20250515075333.48290-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch synchronizes code that accesses from both user-space
and IRQ contexts. The `get_stats()` function can be called from both
context.

`dev->stats.tx_errors` and `dev->stats.collisions` are also updated
in the `tx_errors()` function. Therefore, these fields must also be
protected by synchronized.

There is no code that accessses `dev->stats.tx_errors` between the
previous and updated lines, so the updating point can be moved.

Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
Changelog:
v1: https://lore.kernel.org/netdev/20250421191645.43526-2-yyyynoom@gmail.com/
v2: https://lore.kernel.org/netdev/20250425231352.102535-2-yyyynoom@gmail.com/
- fix incorrect method of updating `dev->stats.tx_errors` and
  `dev->stats.collisions`
v3:
- fix incorrect locking method
---
 drivers/net/ethernet/dlink/dl2k.c | 14 +++++++++++++-
 drivers/net/ethernet/dlink/dl2k.h |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 232e839a9d07..038a0400c1f9 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -146,6 +146,8 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 	np->ioaddr = ioaddr;
 	np->chip_id = chip_idx;
 	np->pdev = pdev;
+
+	spin_lock_init(&np->stats_lock);
 	spin_lock_init (&np->tx_lock);
 	spin_lock_init (&np->rx_lock);
 
@@ -865,7 +867,6 @@ tx_error (struct net_device *dev, int tx_status)
 	frame_id = (tx_status & 0xffff0000);
 	printk (KERN_ERR "%s: Transmit error, TxStatus %4.4x, FrameId %d.\n",
 		dev->name, tx_status, frame_id);
-	dev->stats.tx_errors++;
 	/* Ttransmit Underrun */
 	if (tx_status & 0x10) {
 		dev->stats.tx_fifo_errors++;
@@ -902,9 +903,15 @@ tx_error (struct net_device *dev, int tx_status)
 		rio_set_led_mode(dev);
 		/* Let TxStartThresh stay default value */
 	}
+
+	spin_lock(&np->stats_lock);
 	/* Maximum Collisions */
 	if (tx_status & 0x08)
 		dev->stats.collisions++;
+
+	dev->stats.tx_errors++;
+	spin_unlock(&np->stats_lock);
+
 	/* Restart the Tx */
 	dw32(MACCtrl, dr16(MACCtrl) | TxEnable);
 }
@@ -1073,7 +1080,9 @@ get_stats (struct net_device *dev)
 	int i;
 #endif
 	unsigned int stat_reg;
+	unsigned long flags;
 
+	spin_lock_irqsave(&np->stats_lock, flags);
 	/* All statistics registers need to be acknowledged,
 	   else statistic overflow could cause problems */
 
@@ -1123,6 +1132,9 @@ get_stats (struct net_device *dev)
 	dr16(TCPCheckSumErrors);
 	dr16(UDPCheckSumErrors);
 	dr16(IPCheckSumErrors);
+
+	spin_unlock_irqrestore(&np->stats_lock, flags);
+
 	return &dev->stats;
 }
 
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 0e33e2eaae96..56aff2f0bdbf 100644
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


