Return-Path: <netdev+bounces-241818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D627FC88B1D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC0054E73D5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F74A31B123;
	Wed, 26 Nov 2025 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8k11jTB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D56C31AF39
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146491; cv=none; b=oqmIq3uRxCnX2JozDrn2LjtlpbZntzEUafhE7aVMloz2DffriAa0pDfXmb6QfFuD76n5lmN9EFMyF+/vfMRtcA9h/I12hX4DJIxfbEr5ZGNREOx0DUO2IdWSmEJF/mTUaAnozAbQg9j7nBbo4kvep97uWvKaahGZ1RqNg94oez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146491; c=relaxed/simple;
	bh=8q0JnY5DrrZ+PN2DSLXQVtqJLuqFnZlkdZoIWfZykH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sq01eUwnsHD0+uDjDWC+dhhCWry7QLzu44uD5D7FLOlVWLKCqpcTdV+8N/xvB58ry0qW6MVbWT4pLwJMt31wG8caaPiDwPZ52JhLbQOE+p/c59+IdMvIPwuo+OFHnns/OAVxQUQ4gdk/pO3xHtlTMXQiYwq4YbJftms9GBhblr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8k11jTB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-794e300e20dso356446b3a.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 00:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764146489; x=1764751289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ/O2Ko3hOv90LKroi8XCwo6K73vNvCcrb4vBmq+pd8=;
        b=i8k11jTB2YRvq13lAr08kiugg1VHRpAIuK4mQhMWBR8fiY8kcrWezYvzXS0MITGq9Y
         SnOad0nGmoSYPc4u6uizzly7mA8MW59npjK3C4wO0bCqBY58rErWNxqhrJtpFBaloBG4
         zN0jsTKkPsLBmkmLMu4sRQk/Srf57/bSoA+lo7uzymyF0KJHyHDwdt2DNcwQCVjdK9U9
         cr03Y/k+1q6C7X8u39FxCaHgwijahpWAOU5+jPtChlKOeAt0NAgkTTmxjpb4uFSh0c95
         VFgbcGDtoPtpkmd1oKL+lW+Mh0oerhSZgH0nynAcP38pjUkViWja6QTHC25ziRXYRq1L
         +0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764146489; x=1764751289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YZ/O2Ko3hOv90LKroi8XCwo6K73vNvCcrb4vBmq+pd8=;
        b=wY5+RLhrV8MKhG7W0tmGUVTOP8QKxDWfuemWt2Z72i591POuWFoLna1h25sykHbmHo
         09BqlX6VTAADXwJu/+8DUEcz+EVXqbkKNKpwSo2xbOLV07jn06h1DkK29sIu7Bajom4S
         4bVbPdxRfustQePtcFA2DVpQfxVHVF97gucVaMrMWzMVoXKcWhsySr8MbF5iUjsI9VwH
         zyCpu+G1qMP+9CS3qqvGlB5jA5iKgtd7uM6tiCO0N4o8LD1RsGp1dRRCo0BIUbHLSzHy
         xNO2izjIbN2k6FQ5PFgYQC80ZNq7UluexBSj7c0wnKhFtUK1A8fptSt3x3DedwlCQsh8
         VwcA==
X-Gm-Message-State: AOJu0Yys8BfxrFMF1losY/im17J8WfJY7/qoq+CqLzLfmPfqrBVI0vyS
	X2TMs4CDN0sjsx6JxfCy6p4MwG8W/oh+6RONq9kBt7sWA4HCENkkHsyIfYOR7Q==
X-Gm-Gg: ASbGncuNcuMrLXWtUOOuI5l8Ouvz4YWx9LGj09vKkDoHbEnmhI874NEWo3i+JRpm/vX
	1C5ZHQUcbBKwucZiTuaTvqFS7uSrwDlGTK6mo7QTJTPcmH8Yrb3jwI5I95MYEb4t+Y50/CgdGVT
	ZtgMyYzlr9K+Ii6D9KR5xMlpIJZHgZQXH+v/ry3/X8chm9ArZAPFoAtLltOT7Ee6O6GxWtpzhyp
	Jqi9mYGwlcQRwgvK2SePw9kWJDMgLQztH37NXf+CJVoU/dZu2FAB+HOiDMtFXOOAtD3IIPGN+nj
	qnzpEbz7Gbr78YMywAG5W/Mt3GevjG0nGzWKSh8bkFjIsyaMKy06pOr908yYtkkZyjRG1cdXYgk
	XbDGt3yHq3zj77J6D1OJ6Qp8p3upbGTTUfgVRC8XPJCVYugLdxb8KcZStcWyHdt5qXzfKlpknna
	oUEH2C2LVPmIqeRsL8pjq48A==
X-Google-Smtp-Source: AGHT+IEjsyvBfRts3y6K7+GKt69nymFayBLHmMH7D8x0mMtsZfiZYyaGDV/wMWKATGIe4TPDDuAAjw==
X-Received: by 2002:a05:6a20:6a07:b0:35d:e4b2:b383 with SMTP id adf61e73a8af0-3614f5a21ecmr22112751637.31.1764146488787;
        Wed, 26 Nov 2025 00:41:28 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f024adcfsm20918248b3a.31.2025.11.26.00.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:41:28 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: dsa: yt921x: Use macros for MIB locations
Date: Wed, 26 Nov 2025 16:40:20 +0800
Message-ID: <20251126084024.2843851-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126084024.2843851-1-mmyangfl@gmail.com>
References: <20251126084024.2843851-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract MIB constants into the header file to improve code style. This
patch will not change the behavior of the function.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 103 +++++++++++++++++++--------------------
 drivers/net/dsa/yt921x.h |  54 ++++++++++++++++++++
 2 files changed, 103 insertions(+), 54 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 97fc6085f4d0..ebfd34f72314 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -39,60 +39,55 @@ struct yt921x_mib_desc {
  * to perform 32bit MIB overflow wraparound.
  */
 static const struct yt921x_mib_desc yt921x_mib_descs[] = {
-	MIB_DESC(1, 0x00, NULL),	/* RxBroadcast */
-	MIB_DESC(1, 0x04, NULL),	/* RxPause */
-	MIB_DESC(1, 0x08, NULL),	/* RxMulticast */
-	MIB_DESC(1, 0x0c, NULL),	/* RxCrcErr */
-
-	MIB_DESC(1, 0x10, NULL),	/* RxAlignErr */
-	MIB_DESC(1, 0x14, NULL),	/* RxUnderSizeErr */
-	MIB_DESC(1, 0x18, NULL),	/* RxFragErr */
-	MIB_DESC(1, 0x1c, NULL),	/* RxPktSz64 */
-
-	MIB_DESC(1, 0x20, NULL),	/* RxPktSz65To127 */
-	MIB_DESC(1, 0x24, NULL),	/* RxPktSz128To255 */
-	MIB_DESC(1, 0x28, NULL),	/* RxPktSz256To511 */
-	MIB_DESC(1, 0x2c, NULL),	/* RxPktSz512To1023 */
-
-	MIB_DESC(1, 0x30, NULL),	/* RxPktSz1024To1518 */
-	MIB_DESC(1, 0x34, NULL),	/* RxPktSz1519ToMax */
-	/* 0x38 unused */
-	MIB_DESC(2, 0x3c, NULL),	/* RxGoodBytes */
-
-	/* 0x40 */
-	MIB_DESC(2, 0x44, "RxBadBytes"),
-	/* 0x48 */
-	MIB_DESC(1, 0x4c, NULL),	/* RxOverSzErr */
-
-	MIB_DESC(1, 0x50, NULL),	/* RxDropped */
-	MIB_DESC(1, 0x54, NULL),	/* TxBroadcast */
-	MIB_DESC(1, 0x58, NULL),	/* TxPause */
-	MIB_DESC(1, 0x5c, NULL),	/* TxMulticast */
-
-	MIB_DESC(1, 0x60, NULL),	/* TxUnderSizeErr */
-	MIB_DESC(1, 0x64, NULL),	/* TxPktSz64 */
-	MIB_DESC(1, 0x68, NULL),	/* TxPktSz65To127 */
-	MIB_DESC(1, 0x6c, NULL),	/* TxPktSz128To255 */
-
-	MIB_DESC(1, 0x70, NULL),	/* TxPktSz256To511 */
-	MIB_DESC(1, 0x74, NULL),	/* TxPktSz512To1023 */
-	MIB_DESC(1, 0x78, NULL),	/* TxPktSz1024To1518 */
-	MIB_DESC(1, 0x7c, NULL),	/* TxPktSz1519ToMax */
-
-	/* 0x80 unused */
-	MIB_DESC(2, 0x84, NULL),	/* TxGoodBytes */
-	/* 0x88 */
-	MIB_DESC(1, 0x8c, NULL),	/* TxCollision */
-
-	MIB_DESC(1, 0x90, NULL),	/* TxExcessiveCollistion */
-	MIB_DESC(1, 0x94, NULL),	/* TxMultipleCollision */
-	MIB_DESC(1, 0x98, NULL),	/* TxSingleCollision */
-	MIB_DESC(1, 0x9c, NULL),	/* TxPkt */
-
-	MIB_DESC(1, 0xa0, NULL),	/* TxDeferred */
-	MIB_DESC(1, 0xa4, NULL),	/* TxLateCollision */
-	MIB_DESC(1, 0xa8, "RxOAM"),
-	MIB_DESC(1, 0xac, "TxOAM"),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_BROADCAST, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PAUSE, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_MULTICAST, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_CRC_ERR, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_RX_ALIGN_ERR, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_UNDERSIZE_ERR, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_FRAG_ERR, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_64, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_65_TO_127, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_128_TO_255, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_256_TO_511, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_512_TO_1023, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_1024_TO_1518, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_1519_TO_MAX, NULL),
+	MIB_DESC(2, YT921X_MIB_DATA_RX_GOOD_BYTES, NULL),
+
+	MIB_DESC(2, YT921X_MIB_DATA_RX_BAD_BYTES, "RxBadBytes"),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_OVERSIZE_ERR, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_RX_DROPPED, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_BROADCAST, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PAUSE, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_MULTICAST, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_TX_UNDERSIZE_ERR, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_64, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_65_TO_127, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_128_TO_255, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_256_TO_511, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_512_TO_1023, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_1024_TO_1518, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_1519_TO_MAX, NULL),
+
+	MIB_DESC(2, YT921X_MIB_DATA_TX_GOOD_BYTES, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_COLLISION, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_TX_EXCESSIVE_COLLISION, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_MULTIPLE_COLLISION, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_SINGLE_COLLISION, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_TX_DEFERRED, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_LATE_COLLISION, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_OAM, "RxOAM"),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_OAM, "TxOAM"),
 };
 
 struct yt921x_info {
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 3e85d90826fb..44719d841d40 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -173,6 +173,60 @@
 #define  YT921X_MIB_CTRL_ALL_PORT		BIT(0)
 #define YT921X_MIBn_DATA0(port)		(0xc0100 + 0x100 * (port))
 #define YT921X_MIBn_DATAm(port, x)	(YT921X_MIBn_DATA0(port) + 4 * (x))
+#define  YT921X_MIB_DATA_RX_BROADCAST		0x00
+#define  YT921X_MIB_DATA_RX_PAUSE		0x04
+#define  YT921X_MIB_DATA_RX_MULTICAST		0x08
+#define  YT921X_MIB_DATA_RX_CRC_ERR		0x0c
+
+#define  YT921X_MIB_DATA_RX_ALIGN_ERR		0x10
+#define  YT921X_MIB_DATA_RX_UNDERSIZE_ERR	0x14
+#define  YT921X_MIB_DATA_RX_FRAG_ERR		0x18
+#define  YT921X_MIB_DATA_RX_PKT_SZ_64		0x1c
+
+#define  YT921X_MIB_DATA_RX_PKT_SZ_65_TO_127	0x20
+#define  YT921X_MIB_DATA_RX_PKT_SZ_128_TO_255	0x24
+#define  YT921X_MIB_DATA_RX_PKT_SZ_256_TO_511	0x28
+#define  YT921X_MIB_DATA_RX_PKT_SZ_512_TO_1023	0x2c
+
+#define  YT921X_MIB_DATA_RX_PKT_SZ_1024_TO_1518	0x30
+#define  YT921X_MIB_DATA_RX_PKT_SZ_1519_TO_MAX	0x34
+/* 0x38: unused */
+#define  YT921X_MIB_DATA_RX_GOOD_BYTES		0x3c
+
+/* 0x40: 64 bytes */
+#define  YT921X_MIB_DATA_RX_BAD_BYTES		0x44
+/* 0x48: 64 bytes */
+#define  YT921X_MIB_DATA_RX_OVERSIZE_ERR	0x4c
+
+#define  YT921X_MIB_DATA_RX_DROPPED		0x50
+#define  YT921X_MIB_DATA_TX_BROADCAST		0x54
+#define  YT921X_MIB_DATA_TX_PAUSE		0x58
+#define  YT921X_MIB_DATA_TX_MULTICAST		0x5c
+
+#define  YT921X_MIB_DATA_TX_UNDERSIZE_ERR	0x60
+#define  YT921X_MIB_DATA_TX_PKT_SZ_64		0x64
+#define  YT921X_MIB_DATA_TX_PKT_SZ_65_TO_127	0x68
+#define  YT921X_MIB_DATA_TX_PKT_SZ_128_TO_255	0x6c
+
+#define  YT921X_MIB_DATA_TX_PKT_SZ_256_TO_511	0x70
+#define  YT921X_MIB_DATA_TX_PKT_SZ_512_TO_1023	0x74
+#define  YT921X_MIB_DATA_TX_PKT_SZ_1024_TO_1518	0x78
+#define  YT921X_MIB_DATA_TX_PKT_SZ_1519_TO_MAX	0x7c
+
+/* 0x80: unused */
+#define  YT921X_MIB_DATA_TX_GOOD_BYTES		0x84
+/* 0x88: 64 bytes */
+#define  YT921X_MIB_DATA_TX_COLLISION		0x8c
+
+#define  YT921X_MIB_DATA_TX_EXCESSIVE_COLLISION	0x90
+#define  YT921X_MIB_DATA_TX_MULTIPLE_COLLISION	0x94
+#define  YT921X_MIB_DATA_TX_SINGLE_COLLISION	0x98
+#define  YT921X_MIB_DATA_TX_PKT			0x9c
+
+#define  YT921X_MIB_DATA_TX_DEFERRED		0xa0
+#define  YT921X_MIB_DATA_TX_LATE_COLLISION	0xa4
+#define  YT921X_MIB_DATA_RX_OAM			0xa8
+#define  YT921X_MIB_DATA_TX_OAM			0xac
 
 #define YT921X_EDATA_CTRL		0xe0000
 #define  YT921X_EDATA_CTRL_ADDR_M		GENMASK(15, 8)
-- 
2.51.0


