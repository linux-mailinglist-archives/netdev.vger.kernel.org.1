Return-Path: <netdev+bounces-218522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD17B3CF91
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 23:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890D31B24724
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 21:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13025783D;
	Sat, 30 Aug 2025 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkHdUhN9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4128730CD85;
	Sat, 30 Aug 2025 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756590141; cv=none; b=QakKDHVHYevV8PbfMJobiQcV6M2VBDE2Nmk2n2tGhkCf2a11NUaKnlTd8VxKffMmKwaEuh12cnZTTKD7TD0saIJivsG5vewDxMprU+xtwZaoVL6CxuSnCYz1JDwuO6HUpA11unA6jqpanTrprhBLiwqILgKIwU3Oh1Tcp56OKik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756590141; c=relaxed/simple;
	bh=BJYDBiQ4amhJaGjub/U5j328zDVwJa4YHQ6Slw4ZyaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLKcVoQWvIcugyk38NUgKFO6xUvFlWSxJIFjdxgd8vq1eUXe7+BWV2pjfhsyI2dfngSXyOpof2ll/x1+45yW+vL4BiGY6f9guifFaEPctxNwyKrrvj9TOoV93rPZ5hnxFUprspLV+g5W2kqGVOmQ6JYTJ5VPrYS9e0k124hjApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkHdUhN9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso2053140a12.2;
        Sat, 30 Aug 2025 14:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756590139; x=1757194939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rY/JPOchmMvWF/419gMe9g7EplINNEPxkeuggdXANUs=;
        b=CkHdUhN9mhtWlbr7xiJbKFJAIZa6WUpKahOLNl+LGdgmtXNqI6/5QVPVsdtXsdm7J4
         GF7jl7w+ew425gvsTFfZdxU8Wxu3s0KKBAnmvqHzVL+TReepX7zJQWE9qNIg7sykijVH
         B+zl4xRLzZbOyOIJd0I2OEHBf1Hj9OwDc/u8+KReWG7hSBfQ03QUw7ilwiU4MtSF6lAf
         uY4Sif3VaS4hZn5EoMG4v5WPcq3bJWG/YIkLV9d2jcwEht8kzWiROIkL/IFrmTMMZMKa
         LMqv/UlRfaIp0jf4WgyE3CL/uA9elm5hrmiNV4hYtvec4KneCmrVdpcyQwOwjCigiLVy
         7xUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756590139; x=1757194939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rY/JPOchmMvWF/419gMe9g7EplINNEPxkeuggdXANUs=;
        b=VEtl+nmfwJ1INjBi2iGrpQyGhA4JVdPtOSUAFg38whtkH71BgvuBErkaBZeUa0oy0Z
         3xKDOIYkYL7AxfiwQibCjVuIvUxRxIwh/C+4tDaH1PJty5e59bDbwyHTtiHOUT7JjSHr
         gEACHPzO/g2KXLZYcWLAD83dWUCc3gciYorCCF28uWjcdnDA/U7+yN8uByNLebI6X5AK
         u7smibWYUR07sDufQHcWn/1fVDDE+WBl68IfimQdiR/oFnGb7Bw/bBMcUEHp8kiMgvgz
         OMkMWQ4ahVrkYA12YThHAfXAOs0KVAg4lU3daJo2TIDUNkHax1piuRxek819E4z++ExT
         JOcA==
X-Forwarded-Encrypted: i=1; AJvYcCVYOouEUKMmNZg42E1F5+dKGn6/ajcy04cyx/CuSJU+irPnipKP5hXdnI67G9f4cluuiEG22olfp/Z21xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxSv9rK+IGX+VnYm2hgX5lqZDOaIQ6eKcwaACEygiQsuQWljDp
	VlZwZhfjW2LOhYwOdZR1++zjIJxWnFFtEmFxsNLiXHVeYlUzjLSLirKMeWX8/A==
X-Gm-Gg: ASbGncvCQtMHggkVJ3xgZ2hsbUzhORBJAgxpBV7hnCYw4V37afqUg6Qe0uzjZToCq+B
	zmMpHkjwdJGwRjhGqdBVLD1vw8X8DBqVv8GuFLjjqstfqt0VVaCcUi3es1Nc1CngRpU3BWdK3Q6
	X4Hbfv+lnk76LjYVRkyiBJL01vRp35MspWXkn131V4rbShF5OyS2s+wmBbpvl3oDiuuWJz1CzGb
	fyLiYrc/exOEgCKtLiwgfarBmENn2pq1zdbH5PyyYJIeq8w5dF5K+ijHRVh5J+YlWj/UsQ4Iowm
	rcAxDtnXqke1wqrMwhr8BQlKNwSlSOi9AfpPIqqkc7zqoXsRFdaKN9sh9A4D+I8dimVKQUo6n4o
	SSQIJHOKupGgJiiMNYHOpQGtZGN3iFkTGnLi9pR+8HezLvqfaS5Iz6AL3+cDD/t3lhA==
X-Google-Smtp-Source: AGHT+IHYPQqDFERxJIFwA2J1mhv1++eW9+/JHW6fdC9Qqbwf7Tr3rlueFCxnKmqLcI/MrNfBQSmW/w==
X-Received: by 2002:a17:902:e751:b0:248:a054:e1c4 with SMTP id d9443c01a7336-249448f8ad8mr39874385ad.23.1756590139262;
        Sat, 30 Aug 2025 14:42:19 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903758b89sm60807735ad.59.2025.08.30.14.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 14:42:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: thunder_bgx: use OF loop instead of fwnode
Date: Sat, 30 Aug 2025 14:42:17 -0700
Message-ID: <20250830214217.74801-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loop ends up converting fwnode to device_node anyway.

While at it, handle return value of of_get_mac_address in case of NVMEM.

Simplify while loop iteration.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../net/ethernet/cavium/thunder/thunder_bgx.c | 27 ++++++++-----------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 21495b5dce25..eb5525c1482e 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1468,27 +1468,23 @@ static int bgx_init_acpi_phy(struct bgx *bgx)
 
 static int bgx_init_of_phy(struct bgx *bgx)
 {
-	struct fwnode_handle *fwn;
-	struct device_node *node = NULL;
+	struct device_node *node = bgx->pdev->dev.of_node;
+	struct device_node *child;
 	u8 lmac = 0;
 
-	device_for_each_child_node(&bgx->pdev->dev, fwn) {
+	for_each_child_of_node(node, child) {
 		struct phy_device *pd;
 		struct device_node *phy_np;
+		int err;
 
-		/* Should always be an OF node.  But if it is not, we
-		 * cannot handle it, so exit the loop.
-		 */
-		node = to_of_node(fwn);
-		if (!node)
-			break;
-
-		of_get_mac_address(node, bgx->lmac[lmac].mac);
+		err = of_get_mac_address(child, bgx->lmac[lmac].mac);
+		if (err == -EPROBE_DEFER)
+			goto defer;
 
 		SET_NETDEV_DEV(bgx->lmac[lmac].netdev, &bgx->pdev->dev);
 		bgx->lmac[lmac].lmacid = lmac;
 
-		phy_np = of_parse_phandle(node, "phy-handle", 0);
+		phy_np = of_parse_phandle(child, "phy-handle", 0);
 		/* If there is no phy or defective firmware presents
 		 * this cortina phy, for which there is no driver
 		 * support, ignore it.
@@ -1504,7 +1500,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
 
 		lmac++;
 		if (lmac == bgx->max_lmac) {
-			of_node_put(node);
+			of_node_put(child);
 			break;
 		}
 	}
@@ -1514,14 +1510,13 @@ static int bgx_init_of_phy(struct bgx *bgx)
 	/* We are bailing out, try not to leak device reference counts
 	 * for phy devices we may have already found.
 	 */
-	while (lmac) {
+	while (lmac--) {
 		if (bgx->lmac[lmac].phydev) {
 			put_device(&bgx->lmac[lmac].phydev->mdio.dev);
 			bgx->lmac[lmac].phydev = NULL;
 		}
-		lmac--;
 	}
-	of_node_put(node);
+	of_node_put(child);
 	return -EPROBE_DEFER;
 }
 
-- 
2.51.0


