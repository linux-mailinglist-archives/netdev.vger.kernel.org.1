Return-Path: <netdev+bounces-216210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E59B328D5
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 15:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 639F74E1506
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8A25A350;
	Sat, 23 Aug 2025 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDekaSHG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1559021CA10;
	Sat, 23 Aug 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755956679; cv=none; b=fE+Vh5h9JXu1CfpnPpQe4vTbuJqMmoUvEmdwdWvHuwMlBZeqKoMV7p2kjD+Nvuk0iVWjO5Bb03Xvjm7YrgEwa2t9snX6ee0WRhxeC09WxEUMtn3Kf+ShkF52ZMmeMr9u8T70yvb4v+x+0ClKZ3BemLfyT76enwD28MZvB4QhkoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755956679; c=relaxed/simple;
	bh=Ey5j7k2Nt0EJ2wKwSSfsO6gTg7+LivmeH2vMSOfmmlQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=D++WnAJTWKSL622fIXN3sXYfEwW2x4UghwWCVu2qsRSHMF1fXTmteKota39zd6kVQJNpi0apPSGj0gBUawNKNHSzRXDlWPc2mOSebofDm9y/vuHDxvZ5vo8xvwV7tZ477UfwAYbzwQ/LpJ/TI2DfdUigyVbMvadGr5rWFFGN6zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDekaSHG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9e415a68fso2596589f8f.2;
        Sat, 23 Aug 2025 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755956674; x=1756561474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jjW1qfNz39D2HB5APzuebpHpOX0iU7j5m6Z8FNxRVSw=;
        b=CDekaSHGk9fyAbrNiBoFr8j7AaTZhxshK0bFvjOIYYxYXHMmjDj5YjZZ86HbjYYKvu
         fKc6T9XcIv0NiIKT+ZP+1woUKiDkzCR2GBIoiXlFw7ENvkcpVmSdU/kF2BHRWlqTIDUy
         imzQcllgMYHZJbBRDiI/pRBJTuWLUzcwpCraWv+YBWMks7ZRtMjY5lZg2M/5S7+hPu/9
         zBuLZPIlLCyb4toffUgIubHq+fjutsPi10vsbLNsoNRXdK+DNMYnnJGC675oTkAwBHD+
         09bfguIUlmQ1w2caP+051U/oYJPh5s7o/HQAtJYX2sg+oZT42ImxDra+cFAKEHoKcmc7
         ej5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755956674; x=1756561474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjW1qfNz39D2HB5APzuebpHpOX0iU7j5m6Z8FNxRVSw=;
        b=iB+BXO6vwrGpNE4SJKhZlTo/FHZT24J//ZY1sNzZuPiIGLFpoazE39z5C/uXLbKoq7
         an2NpFu+edinNUUXs1HZY4uUjySWEpBW6+xjP8nOXKHXTnyukE11kAwU4SpPHwR1vbEt
         DZiVyCmoDT1N+P0yZEiw6VT4qXoXQIgH8wrtXIAavHp37q91POhymKKkqaw6yLQ+OHXb
         2/NVWHlWzcAS21nS51g+BYV9TGgSCiGAqG1vorO04Ckxavbe43xFq5DdqoyaAwhszaOu
         gnq2V0VlyVR+RZ71c7VXi0pDiT+82yYmM+W+wJbREPBi/wU/zos10dBsnof6sFEwvfBh
         grFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyB0layfX3xQwwXixgYLJu9mZOlqg4m6raWMofX3ljiOUud/YztuTzaEJkqWtthgcrWXrpsZ2N@vger.kernel.org, AJvYcCX4gQ9slyA+ler8NwtnaGqbp+UIrecJk4V+gy6sgUyAz1ZbeMfmmwjLoy5eOzcjYFvLQiHaKDjC3ItO+Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6yRUQadfljd/0apUpDm5dh7kQ+Gcu5ujpmMroIVmBOEj+aqV+
	Zymtu5MhaTALcqDL0QBLfyVTgX4LzkUCySm8GYIYSsqqv7Mv8zcbDMmF
X-Gm-Gg: ASbGncss1F4WS8sQlk0XS9DgVXU+HxNbgh3GtXqZ1QgxFxk566rT7s06lAEaW/uTmut
	K8rRwNFWyjStTWS9Mi99yhdmKuqW2/zltsdXAcgyvzaFN2zzJxEPl23191y2SkmNdn+IeXgbeip
	nnnhZ9vyoqSTucfueTi8Yd46kCnNuhzzbOCK/+XqCehgHg0WOpuOTM/e3zFsOAQKjJgOd+6tH6i
	+Ixo5pmnWjXTUEKm7vztOe4Wl1xKIukwaUxSGS46deApGjTYWpcCgYsPcf/sDpdHcrHu8RRajxH
	UlbcnlqMkucPoQt716XTtsEYWbk5+M7qWf0yxBmGS3exathYNIW0+dwr5nzhk91WdrKBhmCSr/g
	CKID7jzu07V4WaITHyTOB7+yeR/fSXxMQOHcLCoVvhyZKTIpJ89+f/TmtXMoXg7d0IzCuAFg=
X-Google-Smtp-Source: AGHT+IGgFx1Ps75H6j3SWeQKVWnNGqidWvkK/oN8XDd/UOMhhz42guErzCjyCAPD+64Z6aUJIex+vQ==
X-Received: by 2002:a05:6000:2586:b0:3a5:243c:6042 with SMTP id ffacd0b85a97d-3c5da54e98bmr4499280f8f.2.1755956674153;
        Sat, 23 Aug 2025 06:44:34 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-251-209-58.retail.telecomitalia.it. [95.251.209.58])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c711211b19sm3761466f8f.39.2025.08.23.06.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 06:44:33 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2 1/2] net: phy: introduce phy_id_compare_vendor() PHY ID helper
Date: Sat, 23 Aug 2025 15:44:28 +0200
Message-ID: <20250823134431.4854-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce phy_id_compare_vendor() PHY ID helper to compare a PHY ID with
the PHY ID Vendor using the generic PHY ID Vendor mask.

While at it also rework the PHY_ID_MATCH macro and move the mask to
dedicated define so that PHY driver can make use of the mask if needed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Fix kdoc error

 include/linux/phy.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 74c1bcf64b3c..66153ac1f728 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1260,9 +1260,13 @@ struct phy_driver {
 #define to_phy_driver(d) container_of_const(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
 
-#define PHY_ID_MATCH_EXACT(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 0)
-#define PHY_ID_MATCH_MODEL(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 4)
-#define PHY_ID_MATCH_VENDOR(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 10)
+#define PHY_ID_MATCH_EXTACT_MASK GENMASK(31, 0)
+#define PHY_ID_MATCH_MODEL_MASK GENMASK(31, 4)
+#define PHY_ID_MATCH_VENDOR_MASK GENMASK(31, 10)
+
+#define PHY_ID_MATCH_EXACT(id) .phy_id = (id), .phy_id_mask = PHY_ID_MATCH_EXTACT_MASK
+#define PHY_ID_MATCH_MODEL(id) .phy_id = (id), .phy_id_mask = PHY_ID_MATCH_MODEL_MASK
+#define PHY_ID_MATCH_VENDOR(id) .phy_id = (id), .phy_id_mask = PHY_ID_MATCH_VENDOR_MASK
 
 /**
  * phy_id_compare - compare @id1 with @id2 taking account of @mask
@@ -1278,6 +1282,19 @@ static inline bool phy_id_compare(u32 id1, u32 id2, u32 mask)
 	return !((id1 ^ id2) & mask);
 }
 
+/**
+ * phy_id_compare_vendor - compare @id with @vendor mask
+ * @id: PHY ID
+ * @vendor_mask: PHY Vendor mask
+ *
+ * Return: true if the bits from @id match @vendor using the
+ *	   generic PHY Vendor mask.
+ */
+static inline bool phy_id_compare_vendor(u32 id, u32 vendor_mask)
+{
+	return phy_id_compare(id, vendor_mask, PHY_ID_MATCH_VENDOR_MASK);
+}
+
 /**
  * phydev_id_compare - compare @id with the PHY's Clause 22 ID
  * @phydev: the PHY device
-- 
2.50.0


