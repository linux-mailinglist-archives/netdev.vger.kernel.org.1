Return-Path: <netdev+bounces-197729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9792AD9B2B
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3702A189F63E
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D8721A435;
	Sat, 14 Jun 2025 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="femSWKet"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEF12153D4;
	Sat, 14 Jun 2025 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888023; cv=none; b=nZ56sBBZjou+F1e6C54UdEeOdvf/WePJkGFMWKP+uyNjp+NshWQUiiC5S+X/gn7VfVI/VccqzjvGlFaXyK5qOPm2aZyFAsmQuoobc1PW4uobVlHVkDMjS4AdUL6lgCz0K4YhDSDI6+67Wzw0XyjDUqDbAO4DdXUJgip+7zsdcYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888023; c=relaxed/simple;
	bh=cxvip1yaT62CM+//fUwMVTiGeWcLHBVTmroF7OvOZ9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrllxNBWdP+w9qsFE7LyvZUlduuBo82cgARpzfChJM+pVf0Qui5brUn7CSmBKOV2zpa4O9MQnjnYjjd2FHEJ1w+htyndwx84iPR4xLUP13znF67VPXvVW56vBX+BbVLY7cVv1b/dKlGNlGzg2cDCZMH5Q1QG1GTlVEV1UVbs+2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=femSWKet; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a5096158dcso2498173f8f.1;
        Sat, 14 Jun 2025 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888020; x=1750492820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkDKhWADOeV+BLdp7lg/EAzlBGEzVLIjr5l/oooXOXs=;
        b=femSWKetkOX22GD/N0Qihin8PCwShkQBohrHtx2Xy9f/AsXlEaT+3YXCJZ9LBzpal7
         HHEmi8Sl8HJrCyQtmjibadCn3Md8ZMew7B6j5jNZSoAkGfawC3zTSnWHCteiTnfl2ta3
         A0nMiojTS326Hv645yKQpeNSGHPme9Qtc+qso2dMcP6OQIhIRgzdd17Rt9Mc1qlO7NkR
         JvoH8XtkKF/sD4xJdIIVh0Qw85aS0afV5Uf7y2K8X4vpGQCRzsFxScCZFox/Fz+FYHC4
         7ZUXR9rRk5lKW/3+iGxSWz5HxRhBd2HJqkxIRY0i+s9M1YD+STs4iPAXx6O+qoqSyWnu
         ZjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888020; x=1750492820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkDKhWADOeV+BLdp7lg/EAzlBGEzVLIjr5l/oooXOXs=;
        b=oH4Rc00vX2acE5HcnxH/m4UZcJ9aoGwaOaCVGkMt/Y+bwmDuSFP2SgGL+9QZcXlPRv
         IEK39eF6X8gpn0Piqi6r82fGhduKWSnptuHlaOqzXCOXdXddsexWvp9zYBic3NMo4dPj
         2e7JbGwdhlp26WpzP2sKaYiaB2W+YZJuclrmb33kpxmWczhIwHPUfnorMuV6l0P7tdDK
         ftjj7iRcybmn5i/g4ZqZvCQlh7R5+9tFZemHUPhUiPNpck78eRwWeT78ozFKoLR6ItHR
         mJdbx9Bqk/NROVA9orX54gQFenbiX6KQNn1v1amxUQ839X77+yexOKcFigpsd7nqkFdy
         73Nw==
X-Forwarded-Encrypted: i=1; AJvYcCW5X7chVcaVp4qSLBHoOnK6jdxPi3dDfagKAmkclI+ho/c8W6w04nvt/DwQZTwZCB/bEVPAWsQBpWkCTt0=@vger.kernel.org, AJvYcCWojjbVetDHA2F2Kj6xmSsiAdiqTyOJQhUh6eYgkYtVanz+1wdpypT60QQes1yXD8M+XyI7l38u@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0V9AVvhF08AHCQjaXZGuwQH/Aod6hHytt1zmDgi75K/FOXLj
	P4ApcTPQwongzJzWtr9mWWqqubBqkrgLO1Oxrxmc+Bsz1dGMG5P6roh+
X-Gm-Gg: ASbGncu41dWpdViGbCL2QTwnb7ww6KU58todQ4dpvFJhFAiEONGOlXFSy61skw1Thha
	ZKqQBL6JEGrn86VIzxAbqH1Ssum6e7+LXyR1D7Ul6rqS8qqK4wYBMQsuyWFAOj4Ma7Uot487mmF
	tasR4y4Nf/Yq11yeAamWeRcwntpCAKOnSdwB/PLYDTnKb7sB863EjHS0zNDvieiRjD5qTcv5twi
	qgL5WOr251vlX4bwFurCRdryTpiGzr6cdXs2pfCV6t1/KMXLOiXPMrbunJypqaKLPr7rVmQC0H3
	/Jt7pSpoNcqIotMtcMDEhC4qNaAlyQig0eGrqt5vSkKg8UHKmEBRCkE6+ML8ecHRzQ++eoe+gDB
	Zo5Ft84YfWKpHqqTg8i4cnWKmWVBppSy61fC3tEsb/IzIrQyyNprbyo/Y3nqBNLI=
X-Google-Smtp-Source: AGHT+IEeQkLUl4X4SlZsIGu8Rf3Vu/Mw6OJ+R1Nyy2AYpff2MZa0YgxoBQEAiEyb++TId1vdc3PsZg==
X-Received: by 2002:a05:6000:71a:b0:3a5:27ba:47c7 with SMTP id ffacd0b85a97d-3a572e2df96mr2150810f8f.48.1749888020226;
        Sat, 14 Jun 2025 01:00:20 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:19 -0700 (PDT)
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
Subject: [PATCH net-next v4 11/14] net: dsa: b53: prevent GMII_PORT_OVERRIDE_CTRL access on BCM5325
Date: Sat, 14 Jun 2025 09:59:57 +0200
Message-Id: <20250614080000.1884236-12-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
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

 v4: no changes

 v3: no changes

 v2: no changes

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 2bcbb003b1fd..034e36b351c9 100644
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
index 896684d7f594..ab15f36a135a 100644
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


