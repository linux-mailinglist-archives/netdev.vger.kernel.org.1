Return-Path: <netdev+bounces-149995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7A99E876B
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 20:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7661884D30
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 19:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080BA40BE5;
	Sun,  8 Dec 2024 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUyd5ByJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42395211C;
	Sun,  8 Dec 2024 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733685048; cv=none; b=YPxKYORBT3WIVkdZTwQ+AtyWXzy9jQzMC9nPfuadSq3bM9/lrgF1m9pI5pSfOoWmQumN5s/WqsQ8LO25jdW9Ppy3bIfrKWywUqzw2PiBBK11SPT/u9ZOM1zxxFCmIvAixSEHQHn4+oZsQYbBdauclaIzQ/Vrh4mQ9WRkVVEVvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733685048; c=relaxed/simple;
	bh=9TfDDRf4EzVGBFnJ44ZU5tjgLq9zoLHMnvsie7QraM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ntVO7R1Tq6YLpa//N820SIllpqojaJHypo3GKhr/ZQgEsGt+ClTInudR+Eo1qFc/OuB2sEHXSyP4wwoFwVMRP6FcH/TXBXcAco3MlGX9hIlZ2KPKYmsK+yuLHGOYz7tLngclc3p+VHXi3vBRvwgnOcLLFTc7fvY32fs74yCn2fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUyd5ByJ; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8418ecda126so144067839f.3;
        Sun, 08 Dec 2024 11:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733685046; x=1734289846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SG5reo1dXIq31bXS85h7E4Iq3GMFsNfzE/E+ItcldH4=;
        b=NUyd5ByJE5hj+3Qg5q+zjCYdP8gixBEeiG0Hw831LBgfeyKDgVx6Wf53nJhZxgjVz5
         pXBzXIY33NoA3zx3MR/W/z+Z+2bT2PbDDzagNmw0LY3wJLWPf5rB3PcgyMdzK1Gee693
         F0bQqFkAaR5jbisCFh8jAtJfQcg8EEQ6p5yn5ae714RGoc1/sBEaLRylITOS0dFUuWfo
         uK4MUACBwj/jkjcm8yaU2Fvut85SmwGNtL7J69SgCldub002/MGNFkSrX7MQEy5BPToA
         5Fh+43kty1UPZYZMhBl6Dos7szFsVKiXmbrG8UIG9Suekd6Nh/rAGmd6vxly32Z9Grmv
         v+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733685046; x=1734289846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SG5reo1dXIq31bXS85h7E4Iq3GMFsNfzE/E+ItcldH4=;
        b=O/PtadBBWCBT6NqDNqZ/xlRUoTdluBts1lvsDRrb2Y1Cig2QZjBdlDnb/XNspfOMEq
         2/N2iohzfwqwl9yh4OFSeWW26XpSeGCzQPLiK/ZbzrQLErqNren/Z/oNVdmn35KNQQUV
         6S3uV6fG3bya9VJmpT6O4Zfpe9bwsCEbrxm6T3tt1okWUyzCoVbnq5/rWJ5ubgfMzQEf
         P+5jidZNdzkqFbZzlpMiQIVEC+16NqkhbaxM/sYwX6GDvajbAhxix2u/I3b5HL+fXwNU
         pJ8RWtULC5ZoHo/XvbrZxcEbOtBxd7wIrN9+c+rzGI4nFqMEOIsk5aXLyyvFFd+ORFsq
         kJ0w==
X-Forwarded-Encrypted: i=1; AJvYcCWAhMwfrZi/7+WPIUxN5w2e1phDbJuwz4RXMa0MTAQ1Sba0arOA+5xArnlkjASljpEl/KOtCKtu@vger.kernel.org, AJvYcCWkwp5WiNtJ0OCvWC7ZPcJcjw+rpHysC8JVZg/uhuv8cap99Eyb5oYnbBmqHN2zXAzvGaZIcutf/sKZFjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw43a0Jw/d+5HXIJj9J29FOzyIRywYbSP73j0iffgNItuIaDrLQ
	nVCd15sLRZwzPyO990r+WiQUd3w5V4izA5ZKvcSnsH3B9taR5IOg
X-Gm-Gg: ASbGncsdkbEZQOITMBj3o+CbpDA3AXkHMqSarvO8qC8Jgt+vEXFYQn+Tn7hDFHlKw3U
	490y1c1REC/2Vk6N4rfgjfdHqgpQnF5W0Tm0z/w+weJYIs/85I4pQFzL6KqNapz+0M4BYhIcCZu
	m+uZl4AA9gPIxZatXqhe6XS0PSxRwE0fJnsHgnoG0iMOJVQFpuvy9xHwNLj3f0bmaFLfJ6CL3jY
	F71p9MvqM0/k9HgWl+VUQMAjC69XECCODJdWlBSszxbb9/EwILww5uBCSWc2q72/bM3SrZKogot
X-Google-Smtp-Source: AGHT+IGuo9Kvv/tHvSoPyZKt0NC4Sr/HfxAUeB26jhjZIlHSLuNwmlFFE2bHFKJeqSew9Vz7KZBjHw==
X-Received: by 2002:a05:6e02:b4a:b0:3a7:98c4:86a9 with SMTP id e9e14a558f8ab-3a811e226b8mr125132395ab.20.1733685046171;
        Sun, 08 Dec 2024 11:10:46 -0800 (PST)
Received: from inspiron7620plus.lan ([172.59.229.198])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2bb66b174sm339580173.151.2024.12.08.11.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 11:10:44 -0800 (PST)
From: Guy Chronister <guyc.linux.patches@gmail.com>
To: hkallweit1@gmail.com
Cc: nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guy Chronister <guyc.linux.patches@gmail.com>,
	Koba Ko <koba.ko@canonical.com>,
	Timo Aaltonen <timo.aaltonen@canonical.com>,
	Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH] r8169: Add quirks to enable ASPM on Dell platforms
Date: Sun,  8 Dec 2024 13:10:39 -0600
Message-ID: <20241208191039.2240-1-guyc.linux.patches@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some non-Dell platforms equipped with r8168h/r8111 have issues with ASPM. It's very hard to fix all known issues in a short time and r8168h/r8111 is not a brand new NIC chip, so introduce the quirk for Dell platforms. It's also easier to track the Dell platform and ask for Realtek's effort.
Make the original matching logic more explicit.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
Signed-off-by: Timo Aaltonen <timo.aaltonen@canonical.com>
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Guy Chronister <guyc.linux.patches@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 83 ++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6934bdee2a91..3c1cf704492f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -15,6 +15,7 @@
 #include <linux/etherdevice.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/ethtool.h>
 #include <linux/hwmon.h>
 #include <linux/phy.h>
@@ -5322,13 +5323,89 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
 	rtl_rar_set(tp, mac_addr);
 }
 
+static bool rtl_aspm_dell_workaround(struct rtl8169_private *tp)
+{
+	static const struct dmi_system_id sysids[] = {
+		{
+			.ident = "Dell",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 16 5640"),
+				DMI_MATCH(DMI_PRODUCT_SKU, "0CA0"),
+			},
+		},
+		{
+			.ident = "Dell",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 14 3440"),
+				DMI_MATCH(DMI_PRODUCT_SKU, "0CA5"),
+			},
+		},
+		{
+			.ident = "Dell",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 14 3440"),
+				DMI_MATCH(DMI_PRODUCT_SKU, "0CA6"),
+			},
+		},
+		{
+			.ident = "Dell",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3450"),
+				DMI_MATCH(DMI_PRODUCT_SKU, "0C99"),
+			},
+		},
+		{
+			.ident = "Dell",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3450"),
+				DMI_MATCH(DMI_PRODUCT_SKU, "0C97"),
+			},
+		},
+		{
+			.ident = "Dell",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3550"),
+				DMI_MATCH(DMI_PRODUCT_SKU, "0C9A"),
+			},
+		},
+		{
+			.ident = "Dell",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3550"),
+				DMI_MATCH(DMI_PRODUCT_SKU, "0C98"),
+			},
+		},
+		{}
+	};
+
+	if (tp->mac_version == RTL_GIGA_MAC_VER_46 && dmi_check_system(sysids))
+		return true;
+
+	return false;
+}
+
 /* register is set if system vendor successfully tested ASPM 1.2 */
 static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 {
-	if (tp->mac_version >= RTL_GIGA_MAC_VER_61 &&
-	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
+	 /* definition of 0xc0b2,
+	  * 0: L1
+	  * 1: ASPM L1.0
+	  * 2: ASPM L0s
+	  * 3: CLKEREQ
+	  * 4-7: Reserved
+	  */
+	if ((tp->mac_version >= RTL_GIGA_MAC_VER_61 &&
+		 (r8168_mac_ocp_read(tp, 0xc0b2) & 0x0F)) ||
+		rtl_aspm_dell_workaround(tp)) {
 		return true;
-
+	}
 	return false;
 }
 
-- 
2.45.2


