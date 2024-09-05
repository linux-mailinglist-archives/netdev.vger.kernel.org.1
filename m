Return-Path: <netdev+bounces-125671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA8F96E37E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FD51F270A4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69EF1A4E91;
	Thu,  5 Sep 2024 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZhFA43S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B051A0721;
	Thu,  5 Sep 2024 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565786; cv=none; b=Dx++Drzoyx+5uKtG0IpIMM+33WUi//ygyFOAB2zXQcOHWd5iwpvv4zVcX+oLYeeBD36Qgggxe1Gyk12THofhNRCSVALihN8caWlG+fso99oX7LkIq+mlTgcNNtGjSLaHpfglIIjFr0eSTAnGJiVup8ZWgblWLJx/u/dRrOgg2Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565786; c=relaxed/simple;
	bh=oHroWVGxmMxmoFyojOaOYeUj3KBNuZ53lO8tuQLNXrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCbXBYcIptGh2ahqnOE5E6yyqSIKtIZQV5S0YfGVxCaHJrTQuJ1o42JBLA+M93f+1WOc/k+5t9ACLDwBl2UPOQbG9AGRvoDI2y6Mcdc7xLOt2UHIBT/6LoDNexi8DT/MI/ZNCltkTFrNgEDUBOMzj+bBHfTgLCi/Gni7lXOV5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZhFA43S; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso923413a12.2;
        Thu, 05 Sep 2024 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725565784; x=1726170584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnmxUQqRtH4TCHr6G7et4HHFrfCoGXFp7X7UNG+dva8=;
        b=BZhFA43SgWWznvzEaU6FHBfS20RTYrq49efnvq3byFCw+eA+5QWNyXmCJt9DFrkJAl
         rDkiPy25gpBVfCObzZsdDPz+YrJvZhHKNi6EkizJUPlCQMgQh0zFhOuRYFCE+8vabA1d
         2R1HnKmMUxAnCGCIUMuCK351WuuKkJaK5Qsjy5MbstZ2F5HkmywUMEbbNcqv4jk3GUey
         rngKXsOOTynaxP6WdD/tH4ZOVjMhm2b9iBcj6LUi5maxvtJ7N2wKYs+2S0bwPvCZ7Vy3
         SxxG7TBr0LYLqf+m95Jfujb2JE6uplkIGNcmnh6PYokqNRb4TSxoixwHfLHp6l/bugUp
         u7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725565784; x=1726170584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnmxUQqRtH4TCHr6G7et4HHFrfCoGXFp7X7UNG+dva8=;
        b=l9BO0A5o6defcYJVvdD75r0ttFTtYdFvJThSNksNxWpXwkz8UxQUkjLWVa51zK3sh9
         QlIO8FSYF543ZYTu3CL0y4YodoljC4khFA093Yod3jJMYwCjpu+IgnIch551o85GQS7G
         vyQLJnzCHs24LbY+dJS90iU55GZIXgfHS1JH6zMezURt/8QEkkDmJlhoU0LzNsm5eFCT
         mtNZU/qSq8YLvaR8H71LkaQs7Acxm8F5xvqMCmBAbWO67B8EdaJbp/VUTbn65bmFXO3/
         zbmNAlvmbib72uIwb4h00pBTetLvUUlcuvQuMrzSexx4EfbXjM2ENueSmPdsgax8OAzt
         88Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXdYo0b0LPpFSNqKyFfPNiTYwBA5mRB/hTKcup2c5ZOmyyZk/m4xUf/Dm2jwWFJUqmLpjcPe+qtb1c52EI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jji5FLyv8YSCs/MNGk0iBnWV2Thv0TVa68RcX4OkQ0/txu4D
	XRpNe97MXhx+0ktiJ00cwWBAT9KC0zXnLEq9uXABYmd8wDNw3cB0R3IVsONw
X-Google-Smtp-Source: AGHT+IEnUI2db9UPKQfKa7ssvFR2egUWf28hTWjaTTYi16U/JYiU/jpXIyAyYlltZGNKLhWGY45Mpg==
X-Received: by 2002:a05:6a20:43ab:b0:1c4:6be3:f571 with SMTP id adf61e73a8af0-1cf1d1b32b9mr60419637.39.1725565784257;
        Thu, 05 Sep 2024 12:49:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71791e54585sm1248410b3a.182.2024.09.05.12.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 12:49:43 -0700 (PDT)
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
Subject: [PATCHv2 net-next 3/7] net: ag71xx: update FIFO bits and descriptions
Date: Thu,  5 Sep 2024 12:49:34 -0700
Message-ID: <20240905194938.8453-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905194938.8453-1-rosenp@gmail.com>
References: <20240905194938.8453-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Taken from QCA SDK. No functional difference as same bits get applied.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/ethernet/atheros/ag71xx.c | 48 +++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index e7da70f14f06..74e01ce6161f 100644
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


