Return-Path: <netdev+bounces-145689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004539D0647
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 22:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6C4281F5E
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D886D1DDA33;
	Sun, 17 Nov 2024 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXrV112A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E591DD86E;
	Sun, 17 Nov 2024 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878911; cv=none; b=ROVLGrV/r9BJ3QW0XIfra7P8PzFxSUi4zgUyKkwdn1pjel34esjFZY9HU98FvEd5ZxUwG7JbZJXlEY3aMb7CU6yD27g5tJlsh0WvkaN5xHdOjS1T5xD7ktqViAReCY69wnfHomg5A+RHO1mk4yfKbsHvi2fCihr8xxXii6by3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878911; c=relaxed/simple;
	bh=Wu2ZYQnZnpM89I2UYYuSrf79m4Y8+Ten8StK7vYe4NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aB8rInVRB+58ED/bnO/Js6buTgNofv4C8Vkg48mAm3OhGmTTdLadQrJaWfaNmEFHU8sZ3/Iucw+BYbQmsQS9HnSrZf79SwYEdox7SPNVy46N4j0XXGFsEd1g0LGtCdDmGiQ+xeGSGoTK1ZTKqAgOQ9OwaYhM3sKpEozD51xwvJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXrV112A; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cb7139d9dso33279155ad.1;
        Sun, 17 Nov 2024 13:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731878909; x=1732483709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2LHCzZcj4jlxO8OBofUgVOLc3VHA0hSzkDYf2n5ccE0=;
        b=YXrV112AW+Sll5Hajwa6NE/DpPJyPXB8TX+taKGr5GjX5qvgxKbswjIAcP+WT3Mb/e
         G3N5+XHLCnDy8gw3PvFGc6p2hbgXMS7x2Rh7RoQAjf3yorF4At2k6lh4nivsiZvTW1p4
         W89jzAFCzA8BXt01pgca1KwtmZsgHt0GuvvzWGfQGq/5y+UdvskFltQltfqnGTMVsRbG
         1ZMl+kZugoVOHZ5Ui8MwL542CHbW6EeOAlJ26tZ8eqHG1DDTxc2iZsJAr4KQ1JWeNkCQ
         8vzo/jQUe1JRqj0UbGSgs4IYj23VTWpO1wJqG3ulPxZfMWM9J+KdEbTnaF2ftYle8Ggg
         3XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731878909; x=1732483709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LHCzZcj4jlxO8OBofUgVOLc3VHA0hSzkDYf2n5ccE0=;
        b=AX8dhVo1wJn6i6+wCp9C+ci+gyrX31gewAVZwJxg1LmHtc16sY6sgrWYcqk8z3Ev0B
         WpkuOuLE8H5BY4O8p3eWvMIGq3yytIEV3YkQ0wAv8VoJUUp2jN+05/iyzRR2LdCjjMPv
         AI9p2jP+JxBoyLCHcuiudnxBQifbUWbewPcxodgIrNWr+0hpEjeLZPeJl91Lu0nZWrDh
         MbMEkSnFQeGn4o6NbZzbErMZZ+UyHOLwvGcWszWLsInDKLnSS+UBrcHsIFdUDhO11CvN
         cKgfMjZb2NdNTMTUjsmBEVPlCK8pSZmeM+QiUCv05heK8rHSVZCNgGrvtQujCFtAsRZq
         UIFw==
X-Forwarded-Encrypted: i=1; AJvYcCXPdcJzqG0sRzB2tnNt+tejZGJygZ2n4yPFIw0bvoFlRmIRMrFnu2A4b45qHrY0lQm54VV3ERZ+XnGTk0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjjdWOBxThvBpyms+XTpZbqXWnyH21RwDGRn3RXukRFVcmfHW1
	79/fjgsDtR56HjuUf6dB5s2KE17hEivKFeFD3Fg3Q1YiO+4okRfswAo+9A==
X-Google-Smtp-Source: AGHT+IEKcyvOz8TIVnpDMBgvci1l0YcG5+1ZQOu0uNSb5yMEqzI+VbDE8Ye3HXsCailYsJQew1OmUA==
X-Received: by 2002:a17:902:d503:b0:20c:ca42:e231 with SMTP id d9443c01a7336-211d0d62d3bmr146074705ad.6.1731878909519;
        Sun, 17 Nov 2024 13:28:29 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec909asm44330845ad.97.2024.11.17.13.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 13:28:29 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: mdio-ipq4019: fix wrong NULL check
Date: Sun, 17 Nov 2024 13:28:27 -0800
Message-ID: <20241117212827.13763-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_ioremap_resource returns a PTR_ERR when it fails, not NULL. OTOH
this is conditionally set to either a PTR_ERR or a valid pointer. Use
!IS_ERR_OR_NULL to check if we can use this.

Fixes: 23a890d493 ("net: mdio: Add the reset function for IPQ MDIO driver")

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/mdio/mdio-ipq4019.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index dd3ed2d6430b..859302b0d38c 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -256,7 +256,7 @@ static int ipq_mdio_reset(struct mii_bus *bus)
 	/* To indicate CMN_PLL that ethernet_ldo has been ready if platform resource 1
 	 * is specified in the device tree.
 	 */
-	if (priv->eth_ldo_rdy) {
+	if (!IS_ERR_OR_NULL(priv->eth_ldo_rdy)) {
 		val = readl(priv->eth_ldo_rdy);
 		val |= BIT(0);
 		writel(val, priv->eth_ldo_rdy);
-- 
2.47.0


