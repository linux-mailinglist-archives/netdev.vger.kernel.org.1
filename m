Return-Path: <netdev+bounces-191137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1CBABA261
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3F9161014
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A998427F170;
	Fri, 16 May 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="JVePYhpe"
X-Original-To: netdev@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E2727A92E;
	Fri, 16 May 2025 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418530; cv=none; b=gAOa7zgJZGLltgWvL9KSgJlOp+fC5P1sZwdpBG9etwwjUg3LChdUb4qNbe+Ff3tUHj0dV36quPNudnrT/+l0d7kyV2bmAXstNqFz701HUfuhzs8fLiz3fMp2Gj3+RIaNNj5gI28opMAU7gfNUJGi6elNu1Y/SZMCiFsd5Vh3dgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418530; c=relaxed/simple;
	bh=kHwPxvD7M946+KWLYcCeAR5SpbIFFqBcCKwpRmbodqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGtPW2rfS8dyeYL+qrk71uT1auTqeG5/1FYFUlVUhdDuv3SwLz/9IdJUaB7UKG8EKtbmiGoMpqkZbtC7cMOL6pXQjwJ98t8ykg6Bi7phUDXczVo/PRdM8+ESLNhxHZT2/PGKnQSBj+CK/T3PPR0ZD77/6RWrz+Ca0fVuM6sfAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=JVePYhpe; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id D782D1007C9;
	Fri, 16 May 2025 18:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1747418518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+i5DM3x3WXg2uqMLLr9WJvq/q6qvV6rl33rsfy6Fiwc=;
	b=JVePYhpe43R10j1wecIfq9dDxv8tsjf8UVk3pErXPRzjvAH/Q/VpyBp2kIJzxpQv4qWrMF
	QvdYcomHJVQEpsRaEEnTZZEYuK+UUL66mrkAPNAhJD9PAzQENdvKkVeneIh/LvE2sBOzJc
	aAlcrGcHqqbE+o6XJ1CO86s5GB2APD8=
Received: from frank-u24.. (fttx-pool-157.180.226.139.bambit.de [157.180.226.139])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 8B8621226F2;
	Fri, 16 May 2025 18:01:58 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 10/14] arm64: dts: mediatek: mt7988a-bpi-r4: Add fan and coolingmaps
Date: Fri, 16 May 2025 20:01:41 +0200
Message-ID: <20250516180147.10416-12-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250516180147.10416-1-linux@fw-web.de>
References: <20250516180147.10416-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add Fan and cooling maps for Bananapi-R4 board.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v2: fix typo
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index 23b267cd47ac..c6f84de82a4d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -12,6 +12,15 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		/* cooling level (0, 1, 2, 3) : (0% duty, 30% duty, 50% duty, 100% duty) */
+		cooling-levels = <0 80 128 255>;
+		#cooling-cells = <2>;
+		pwms = <&pwm 0 50000>;
+		status = "okay";
+	};
+
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
@@ -73,6 +82,26 @@ cpu_trip_active_low: active-low {
 			type = "active";
 		};
 	};
+
+	cooling-maps {
+		map-cpu-active-high {
+			/* active: set fan to cooling level 2 */
+			cooling-device = <&fan 3 3>;
+			trip = <&cpu_trip_active_high>;
+		};
+
+		map-cpu-active-med {
+			/* active: set fan to cooling level 1 */
+			cooling-device = <&fan 2 2>;
+			trip = <&cpu_trip_active_med>;
+		};
+
+		map-cpu-active-low {
+			/* active: set fan to cooling level 0 */
+			cooling-device = <&fan 1 1>;
+			trip = <&cpu_trip_active_low>;
+		};
+	};
 };
 
 &i2c0 {
-- 
2.43.0


