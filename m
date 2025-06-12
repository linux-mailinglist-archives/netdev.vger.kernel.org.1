Return-Path: <netdev+bounces-196850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56585AD6B13
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9761BC4249
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3C223AB9F;
	Thu, 12 Jun 2025 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixgh9naE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7484221FCA;
	Thu, 12 Jun 2025 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717488; cv=none; b=btShEj8lOV/KbfAjTGW3wlA41lNvEYwtrFcvFZ1jzYGkbkGi82IKySbLtxxwInBD9kmygEaavuGSido41X25pK85F4/Td5nYYBaVpbHPq3zjKUkbIMP+1bRBa11fIok9dyuzBEZ/xPYy5539iu/RBRawWIIi4HIw2mNduviyvZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717488; c=relaxed/simple;
	bh=+7VQIdXcx79FWgJguV3+lys0EfRmIKvgxhqfFabs2RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSvzkqEqN/WJZe+IkKpJ8K3FVa/CgyZ74kaTp0WO7XzGNYq5KqzcPkey3OSA74FlWNjmPGMCt0LBUBw5jhN2aQg3yHSoeCmZd2soLa//6LCZ40+H5m+wZt+EeVVtIuRlEdLndLSk48aeewdO9e2OUb5lM7prV5j9UKAE1SKrvjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixgh9naE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a5257748e1so515099f8f.2;
        Thu, 12 Jun 2025 01:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717485; x=1750322285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVkM4QRo1KHkxhSmC2rIaxb0hoCWldCV9txteEDW3iw=;
        b=ixgh9naEaj67ujSrtb/irBK+lmqGteCKuOK/LpLZ5l0uLxVb3vxCjehC/orEkEyMmn
         RxhgxWMrk9gUJsqitLSzSHoo8m8pFnw7rzzf4oKGTPDYg+4b/cK6f39pWUBIMAATbBrm
         b/V6KsC1KOOU+eLv1/w9J7rUSg0LtctQ/JrIkDYod1q7M7jC87UcigxZYVBeTg6svA1x
         QVZETn2oD1HOojr0P/L/R+xWD+wT1yR2sXJN9tznPcFxb+BkAPOzwpwRp+BDF4Rvm7BD
         xUxtUB/aTIe7qX4xvk+688e3FfrFuvP4D0H2afNMTnzSgOa2WjHleCkkLFWIsQGj1g32
         16jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717485; x=1750322285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVkM4QRo1KHkxhSmC2rIaxb0hoCWldCV9txteEDW3iw=;
        b=qQ3Sz/rW1wnv4pXgH8Z5fjk5xjFwh+ZZDNoXou4gGmPYmOMSaMQKbVM9qszTnZGZlM
         utCwcT6U7KRdp0m5BIbOd1RjYFxPYcTynyHSt8YoquLZZduKr2xG2e/XSLWQam+y0j/Q
         HLEggUhwSsb0iDzD4HFCJpV6nIIq6E2iEiFbWssifgL3ecY0mkAYs79M8EDmuCcftuf3
         Eybv04n+Lef2Mi5uFMsglIob6Oc+Xmw4QVhNF4Hk5Da82I2Bf7IBnHHIaM8B68AIRjIO
         Qe1WQqUomp5tBDgX/YQzynifqO9rhW1ymHdg5WWxPpXzbJpwppYWZUHw873nQWO3TKss
         zJVg==
X-Forwarded-Encrypted: i=1; AJvYcCUOddkLK5RWPaQpSgBdeEwieNBv33rt6j5QuJYJ8gSiwVFZts0CfifQ8lw4Tnj/nBh5oS11UsQM@vger.kernel.org, AJvYcCVDFWhQmRoHs5tw7DYFMpIMZemnqMY2U8bTWynWd7dLHYmoAI2DkTtphoZO0nrQUB/Mx9nAEt4Re8cO49c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhUBhYoJlgHl7CpYBcBSo78PDKOGtIgIsnYegHaXLQd2jXPxW
	bQ0G05Ow6h8HeM4Q2pabXY+qE1xTAM230cyS34Nt0GtMdLkwjDnCN/uy
X-Gm-Gg: ASbGncsTw/TLbW30Q1VV4l6tSx+gfDTQvC7TQl26hh9C8QqKifGqteiUju2oYn+NzmH
	00xVNcgzfNJRzRGiUtHlfSWZ9oIbxoNDYUmW5cNTmDpjCgUE74Byj19v8IFYKAa/1dVxE5OzNru
	a+FQXy0GCHrfD+b/ZAZURU6agBCyybbGt7L52rnZxPG7YyR8z0+4XT6mCxScwsAMOnJwIoXkEjq
	jjh/uQe8HIUOZoST4peEbI2oO6y1AgyBbKdRD4S0musaoGH5G9zKjX92m0CJoPxHtLb2QEoX26i
	VPPalAMjDlC/foEKvVdUJm1AijdFr19Sc+CPQEhuhdkTHYM1Icqnz+Sz+exqZ3irKHkqODWdD6P
	DrUVSOfnSsaYdU/saj4OjlxwykJ2EbNoKvCjFIWXIS4VLr+pWaIhC4t+zf5HrkC5f9VQh7/NQle
	heHw==
X-Google-Smtp-Source: AGHT+IHUKb+2p1EBinulFJLR/9fVwt+I/wVUkwi/EJa79TifWfb1AA/4y807zJF+ciuz+uFC+xcesw==
X-Received: by 2002:a05:6000:250e:b0:3a4:eda1:6c39 with SMTP id ffacd0b85a97d-3a561308a8emr1635886f8f.13.1749717485061;
        Thu, 12 Jun 2025 01:38:05 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:38:04 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v3 11/14] net: dsa: b53: prevent GMII_PORT_OVERRIDE_CTRL access on BCM5325
Date: Thu, 12 Jun 2025 10:37:44 +0200
Message-Id: <20250612083747.26531-12-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250612083747.26531-1-noltari@gmail.com>
References: <20250612083747.26531-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement GMII_PORT_OVERRIDE_CTRL register so we should
avoid reading or writing it.
PORT_OVERRIDE_RX_FLOW and PORT_OVERRIDE_TX_FLOW aren't defined on BCM5325
and we should use PORT_OVERRIDE_LP_FLOW_25 instead.

Fixes: 5e004460f874 ("net: dsa: b53: Add helper to set link parameters")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 21 +++++++++++++++++----
 drivers/net/dsa/b53/b53_regs.h   |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

 v3: no changes

 v2: no changes

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index d082e5a851ab5..74e3b6bd798e0 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1279,6 +1279,8 @@ static void b53_force_link(struct b53_device *dev, int port, int link)
 	if (port == dev->imp_port) {
 		off = B53_PORT_OVERRIDE_CTRL;
 		val = PORT_OVERRIDE_EN;
+	} else if (is5325(dev)) {
+		return;
 	} else {
 		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
 		val = GMII_PO_EN;
@@ -1303,6 +1305,8 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 	if (port == dev->imp_port) {
 		off = B53_PORT_OVERRIDE_CTRL;
 		val = PORT_OVERRIDE_EN;
+	} else if (is5325(dev)) {
+		return;
 	} else {
 		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
 		val = GMII_PO_EN;
@@ -1333,10 +1337,19 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 		return;
 	}
 
-	if (rx_pause)
-		reg |= PORT_OVERRIDE_RX_FLOW;
-	if (tx_pause)
-		reg |= PORT_OVERRIDE_TX_FLOW;
+	if (rx_pause) {
+		if (is5325(dev))
+			reg |= PORT_OVERRIDE_LP_FLOW_25;
+		else
+			reg |= PORT_OVERRIDE_RX_FLOW;
+	}
+
+	if (tx_pause) {
+		if (is5325(dev))
+			reg |= PORT_OVERRIDE_LP_FLOW_25;
+		else
+			reg |= PORT_OVERRIDE_TX_FLOW;
+	}
 
 	b53_write8(dev, B53_CTRL_PAGE, off, reg);
 }
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 896684d7f5947..ab15f36a135a8 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -95,6 +95,7 @@
 #define   PORT_OVERRIDE_SPEED_10M	(0 << PORT_OVERRIDE_SPEED_S)
 #define   PORT_OVERRIDE_SPEED_100M	(1 << PORT_OVERRIDE_SPEED_S)
 #define   PORT_OVERRIDE_SPEED_1000M	(2 << PORT_OVERRIDE_SPEED_S)
+#define   PORT_OVERRIDE_LP_FLOW_25	BIT(3) /* BCM5325 only */
 #define   PORT_OVERRIDE_RV_MII_25	BIT(4) /* BCM5325 only */
 #define   PORT_OVERRIDE_RX_FLOW		BIT(4)
 #define   PORT_OVERRIDE_TX_FLOW		BIT(5)
-- 
2.39.5


