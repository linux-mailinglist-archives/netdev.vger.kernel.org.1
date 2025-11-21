Return-Path: <netdev+bounces-240733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EFEC78D6E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 43BD02BC96
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9802034C127;
	Fri, 21 Nov 2025 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3nEU9cJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05C734B40E
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724973; cv=none; b=VHXIz/I/iMgdlsXCr17verT/chGTgaH+qL/SXrQPfzSInVhKiiFkQWDUXDlvZav90eJ7XM6adYIjOp9CzxtUQSVQbB6SiYe71Usk4p+AOloNOMTs0j2mvX/N3Bd8aBIJ7P9IVt+ox0xBYoQfJVmurMhoJck63qnw6k/AYrfVe3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724973; c=relaxed/simple;
	bh=4sC+YEMBQOAmZLe09rnzCJD1y8NBOeODeC/IvVPodoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOyIOAEDK9jGZB/b0bvEZXYZBfOaPKwxEI0+gDfG+ssXyzrrX0PlGPDNIzGuM2Cem0zcbbinokM/9EoGYM3UIoykni/1aZern7W+pAmcRlU2el40feq6z/NBBMvrFNHg8WWG8/NsP7Vl6do+YKUwiVir0mtxS8bqJ68hX1coubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3nEU9cJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso8714215e9.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763724969; x=1764329769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJZypyy2Lhm+4dU+VDEY7IcdBp0UiWAwJvLyr9kbDD8=;
        b=R3nEU9cJ/55hZDUN7H+6XrohhMuw+E7eOaa9/UW1oZvboIh/RusxBOZLJz2zkYZhK2
         dryK8rIfZioskIcMe7d4YUAIC+qUXiirOBZ0Xga9ux2Bnj6uN4qXtBK7VsQ2IaqLEuus
         TFUBaMevnectWQjfETUcesKnzDVPLxnspN6APVkCcaxY3gW4CLFFOoWRDAQW685+fIED
         /UcLvFGJEkNe/Q48Ak92V78lKrUAGfpOfusZuGRPdlH6auE2VDnIMtx1fgxsIgKWSUvd
         NHlNoPg2EMNZ6Lvg/GVc3EQZ4uk57BNCBYx8AZ//K5t+gbraiyujEZZg809vABLxldgY
         +M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763724969; x=1764329769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nJZypyy2Lhm+4dU+VDEY7IcdBp0UiWAwJvLyr9kbDD8=;
        b=bP1VuUK2vBQawKgsDCpYWH4oPjB1kvoJWz6IQUM+J6Mh0KUlFKSTiYY7RnzzywRTGK
         GPNUiX4TU8bepfnHVnpPP2kUg1CePDyZ0OPxDIKFXhnSBDm9TMwu3imgULw+M2FR/FOi
         SPU7EePiy0KDfIQexdOEdfp4mi9toYLvicG+uXvOW+TqaucLvfIzKUrKJ1WsN5g9f1li
         2r4gWlDoDLB/8fpKRXtj5pmvV8DcNN7XD3TF/d3VtMx9oY5/SWLbIRs8NGv7utxwgm+W
         fbd5FCIwx25Bf4dkP5uJqAIl2IACD+J3qCuaXV00iUZlLL8QMgMb4nvMeMq099N07+oU
         JQjw==
X-Forwarded-Encrypted: i=1; AJvYcCXKSUUsTzb+FETbl77kGSgDCrSQaB4fjrrPVkR5T9mtAKtOhwpU7talYvZuneclS16iSRoSrD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGfLOk3nky1K5b44UCP7MeOEA20GXMrWxpm08/9sVTZOgJPjv+
	SdRt6IZybQ1helK4e11j7xxLCY+5qnH1pKYivSvW50RTuzBQkbbHiUTk
X-Gm-Gg: ASbGnctRW8qgD3UFJq7aSk5FN44PBprw8f2GXl6inZE3aRxrZ7ZHQAvDcO6xFXZJbJo
	zG4n0k+8/Ikcav+slE82r36vhI9S8osCIBmW0S8d0IodvT7m81ajl1ACikd5ojGyiXZoREBTXw6
	IfmPR0eJI8vbhZqssLC1n7GqN5GYZvV+adxrSNF4rnFrrPxZz+XT3G5qQe/8WQPEh6QdEq4FH2a
	uF4GMt4ZTtb39l0MJNHvurHmJlwyBVgMy6If1owON9kF8t8DjPO07qllt9G66rAfMN7IFSSD7pZ
	FfsIht/MTtIz0pQp4mx+4lzHooxh1BG2DaM0a0gAu/f2ik0yA2KFHS02kpVDyAikjxHyhZiOcjl
	x8+rwqKyV3Y6WcXx6FZxOCR9fbFvz6pVY+WWOjjo1Vz3yDbN9ibh4/Sq1NTYqF+Zx+mfdnNmOef
	GMv5lM8OtI6MoY6xzphhKx7R2fulN9Rzfrp+E=
X-Google-Smtp-Source: AGHT+IHeGiEbepIxQ4oItmULN0g5LjudPiuJcNy16zrM/slmw7LOo2HakFym0E4guUaNMPuSEBhQuQ==
X-Received: by 2002:a05:600c:1ca0:b0:477:75eb:a643 with SMTP id 5b1f17b1804b1-477c0165b4emr25487105e9.4.1763724969090;
        Fri, 21 Nov 2025 03:36:09 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:9cce:8ab9:bc72:76cd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3558d5sm38732465e9.1.2025.11.21.03.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:36:08 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next 05/11] net: dsa: rzn1-a5psw: Add support for optional reset control
Date: Fri, 21 Nov 2025 11:35:31 +0000
Message-ID: <20251121113553.2955854-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add support for an optional reset control to the RZN1 A5PSW driver.
Obtain the reset line using
devm_reset_control_get_optional_exclusive_deasserted() during probe
to ensure that the Ethernet switch (ETHSW) block is properly released
from reset before initialization.

This change prepares the driver for use on Renesas RZ/T2H and RZ/N2H
SoCs, where the ETHSW IP block is connected to a dedicated reset line
that must be controlled by software.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/dsa/rzn1_a5psw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 1635255f58e4..7b84585a5415 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
+#include <linux/reset.h>
 #include <net/dsa.h>
 
 #include "rzn1_a5psw.h"
@@ -1205,6 +1206,7 @@ static int a5psw_pcs_get(struct a5psw *a5psw)
 static int a5psw_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct reset_control *reset;
 	struct device_node *mdio;
 	struct dsa_switch *ds;
 	struct a5psw *a5psw;
@@ -1241,6 +1243,12 @@ static int a5psw_probe(struct platform_device *pdev)
 		goto free_pcs;
 	}
 
+	reset = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(reset)) {
+		ret = PTR_ERR(reset);
+		goto free_pcs;
+	}
+
 	mdio = of_get_available_child_by_name(dev->of_node, "mdio");
 	if (mdio) {
 		ret = a5psw_probe_mdio(a5psw, mdio);
-- 
2.52.0


