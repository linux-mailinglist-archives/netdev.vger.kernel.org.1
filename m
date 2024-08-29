Return-Path: <netdev+bounces-123514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDBC96524A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 23:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B521C24203
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766471BB6B5;
	Thu, 29 Aug 2024 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbUbFgsI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD90E1BAECD;
	Thu, 29 Aug 2024 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968125; cv=none; b=uKDL3VX1BDSIFLMJYEI4MnBf3tiMmbue2r9FHcm0x8Un6C9a4FHZ6lL/bLxHDWM/YtYvG6d3a8hfvLFQilyiiP/4SmJH9Tc5ZFm8ZxTv6qzThVX2cMxa59kWSgXwLOf0HNkW/2qtYcJmXhgIckmqaz+9qY/GprRaoH8HVxuT2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968125; c=relaxed/simple;
	bh=/Ib3RLq1lbiCNk/gwnJKNDQ9hhJgWipT3hhpkjr0OGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxxUPDsgaeb2iodvUv00bKLcYMmwiQ8v2L7jYIGPAvMsyibTV+ix2bbXJ6uYrmDQmH4O4Zj14RccKeP8/7YI2xRkcGsS5ifX+drlMlO3ynF+C2EEJyUYuNo0QqTUjVx2mrJmkTPr/rdNDZsu7JNHP1GsEq+n11lrRO8pJZfg4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbUbFgsI; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39d47a9ffb9so4229235ab.1;
        Thu, 29 Aug 2024 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968123; x=1725572923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2cYzMIEtOcnTHpiB72IdBy7qlV47qa+YowYhB7YIvA=;
        b=LbUbFgsIJ+m92sa688vjZgkpBQiko0qEorVmLAT/9VloMFrI9HqFs1bNpXlNbV6R8R
         ImKs4zyTJ2ZyhSXEaEgwV1npADwLfH+ilh2bEevFGdvGpuk1j64PnmYh6M3kKK1pdwKI
         uzBPYJSbdIRyp4o6CACdeoTKlQxR8mkxT+qqswHHScRLfST3xY48UqwdI3JopZ9VccVA
         6ceV5KnXFeneOeeSVO3LtpjOVURPPTH7b8RxYzkLLhKfJYI3NjPfQ9hIgGgDJmOB5eAP
         /+yavllwdPFCxsXDA4l8rvLKoxsZ/iHMKzJZDpdhkbS9Tcut0JRwZufkcPhPdoqHl2Wb
         56Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968123; x=1725572923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2cYzMIEtOcnTHpiB72IdBy7qlV47qa+YowYhB7YIvA=;
        b=XL1hAern20Dj5aeUnoWYljhpR19uTS9AGZPhExeF03PbaY7n5MYTSFFqmO9qgos3i+
         qsHDLMT0hIEcPAPHk0XdOYNweqCwGrYjERHPxjW0kqm4f8DNwwhkS6N2Mn8pt4Su4ZnH
         uol7aRX5vGTXVaxImCy8Vhao1wsaE9GQ9EmDpexTeV8P62aR6bbGvtCPTUO7dint1cwL
         O2cj5LArSwmLocDPuHBlcDAJy45yJYTj6cZMg7xqtuGgi52rgzRyrtWVaklypLq8jsge
         xluluhamZ7kzqn2MddKtn0bAhlpz9KDQ9j5EWA/CSZmhGbkvc+bpZlC7zkluyyLXPPAo
         +rxg==
X-Forwarded-Encrypted: i=1; AJvYcCX3p0U/zV2TLDH9Nx6cqUEqi2Y/QQmdG1gzQYYKR9C3TkkNKRagPmK7l4GIBGMq+qgNwmXhvIjXuHMEOhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ6mUxVDzyAKJDkFaoHKd2/ZHkH4QikvdU5Kn1DHLYiPu2+E43
	3SMaR6owztveu1uYEtYnrppkphLixhV65w4MNz1DSFyL7NThN7iZ0kmki9N/
X-Google-Smtp-Source: AGHT+IGAI0zPMj8TO3F1/Jfsd0hd4CenesfKqQ2Y6k7rb00bKaDbGGEBU0M2pNVii8kIzbF4vLAz3Q==
X-Received: by 2002:a05:6e02:1e04:b0:39d:351a:d0a2 with SMTP id e9e14a558f8ab-39f379ae918mr51543625ab.25.1724968122609;
        Thu, 29 Aug 2024 14:48:42 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77a7besm1708029a12.37.2024.08.29.14.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:48:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next 2/6] net: ag71xx: update FIFO bits and descriptions
Date: Thu, 29 Aug 2024 14:48:21 -0700
Message-ID: <20240829214838.2235031-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829214838.2235031-1-rosenp@gmail.com>
References: <20240829214838.2235031-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Taken from QCA SDK. No functional difference as same bits get applied.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 48 +++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index db2a8ade6205..89c966b43427 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -149,11 +149,11 @@
 #define FIFO_CFG4_MC		BIT(8)	/* Multicast Packet */
 #define FIFO_CFG4_BC		BIT(9)	/* Broadcast Packet */
 #define FIFO_CFG4_DR		BIT(10)	/* Dribble */
-#define FIFO_CFG4_LE		BIT(11)	/* Long Event */
-#define FIFO_CFG4_CF		BIT(12)	/* Control Frame */
-#define FIFO_CFG4_PF		BIT(13)	/* Pause Frame */
-#define FIFO_CFG4_UO		BIT(14)	/* Unsupported Opcode */
-#define FIFO_CFG4_VT		BIT(15)	/* VLAN tag detected */
+#define FIFO_CFG4_CF		BIT(11)	/* Control Frame */
+#define FIFO_CFG4_PF		BIT(12)	/* Pause Frame */
+#define FIFO_CFG4_UO		BIT(13)	/* Unsupported Opcode */
+#define FIFO_CFG4_VT		BIT(14)	/* VLAN tag detected */
+#define FIFO_CFG4_LE		BIT(15)	/* Long Event */
 #define FIFO_CFG4_FT		BIT(16)	/* Frame Truncated */
 #define FIFO_CFG4_UC		BIT(17)	/* Unicast Packet */
 #define FIFO_CFG4_INIT	(FIFO_CFG4_DE | FIFO_CFG4_DV | FIFO_CFG4_FC | \
@@ -168,28 +168,28 @@
 #define FIFO_CFG5_DV		BIT(1)	/* RX_DV Event */
 #define FIFO_CFG5_FC		BIT(2)	/* False Carrier */
 #define FIFO_CFG5_CE		BIT(3)	/* Code Error */
-#define FIFO_CFG5_LM		BIT(4)	/* Length Mismatch */
-#define FIFO_CFG5_LO		BIT(5)	/* Length Out of Range */
-#define FIFO_CFG5_OK		BIT(6)	/* Packet is OK */
-#define FIFO_CFG5_MC		BIT(7)	/* Multicast Packet */
-#define FIFO_CFG5_BC		BIT(8)	/* Broadcast Packet */
-#define FIFO_CFG5_DR		BIT(9)	/* Dribble */
-#define FIFO_CFG5_CF		BIT(10)	/* Control Frame */
-#define FIFO_CFG5_PF		BIT(11)	/* Pause Frame */
-#define FIFO_CFG5_UO		BIT(12)	/* Unsupported Opcode */
-#define FIFO_CFG5_VT		BIT(13)	/* VLAN tag detected */
-#define FIFO_CFG5_LE		BIT(14)	/* Long Event */
-#define FIFO_CFG5_FT		BIT(15)	/* Frame Truncated */
-#define FIFO_CFG5_16		BIT(16)	/* unknown */
-#define FIFO_CFG5_17		BIT(17)	/* unknown */
+#define FIFO_CFG5_CR		BIT(4)  /* CRC error */
+#define FIFO_CFG5_LM		BIT(5)	/* Length Mismatch */
+#define FIFO_CFG5_LO		BIT(6)	/* Length Out of Range */
+#define FIFO_CFG5_OK		BIT(7)	/* Packet is OK */
+#define FIFO_CFG5_MC		BIT(8)	/* Multicast Packet */
+#define FIFO_CFG5_BC		BIT(9)	/* Broadcast Packet */
+#define FIFO_CFG5_DR		BIT(10)	/* Dribble */
+#define FIFO_CFG5_CF		BIT(11)	/* Control Frame */
+#define FIFO_CFG5_PF		BIT(12)	/* Pause Frame */
+#define FIFO_CFG5_UO		BIT(13)	/* Unsupported Opcode */
+#define FIFO_CFG5_VT		BIT(14)	/* VLAN tag detected */
+#define FIFO_CFG5_LE		BIT(15)	/* Long Event */
+#define FIFO_CFG5_FT		BIT(16)	/* Frame Truncated */
+#define FIFO_CFG5_UC		BIT(17)	/* Unicast Packet */
 #define FIFO_CFG5_SF		BIT(18)	/* Short Frame */
 #define FIFO_CFG5_BM		BIT(19)	/* Byte Mode */
 #define FIFO_CFG5_INIT	(FIFO_CFG5_DE | FIFO_CFG5_DV | FIFO_CFG5_FC | \
-			 FIFO_CFG5_CE | FIFO_CFG5_LO | FIFO_CFG5_OK | \
-			 FIFO_CFG5_MC | FIFO_CFG5_BC | FIFO_CFG5_DR | \
-			 FIFO_CFG5_CF | FIFO_CFG5_PF | FIFO_CFG5_VT | \
-			 FIFO_CFG5_LE | FIFO_CFG5_FT | FIFO_CFG5_16 | \
-			 FIFO_CFG5_17 | FIFO_CFG5_SF)
+			 FIFO_CFG5_CE | FIFO_CFG5_LM | FIFO_CFG5_LO | \
+			 FIFO_CFG5_OK | FIFO_CFG5_MC | FIFO_CFG5_BC | \
+			 FIFO_CFG5_DR | FIFO_CFG5_CF | FIFO_CFG5_UO | \
+			 FIFO_CFG5_VT | FIFO_CFG5_LE | FIFO_CFG5_FT | \
+			 FIFO_CFG5_UC | FIFO_CFG5_SF)
 
 #define AG71XX_REG_TX_CTRL	0x0180
 #define TX_CTRL_TXE		BIT(0)	/* Tx Enable */
-- 
2.46.0


