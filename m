Return-Path: <netdev+bounces-194841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5B4ACCE6C
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 22:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A0A1767BF
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA1B2550C2;
	Tue,  3 Jun 2025 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3LAiM8s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD725393B;
	Tue,  3 Jun 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983755; cv=none; b=XmAdsq53T+WnbGY1smF9eSWE2waNyNCVva718KUZXP88juuU8fje65OcqX5Nj3j16aDr823ZDxBNN7V44uO6e7ISlFBpDWtSqH325bs9xYRQEFFLPiLKaN3EH62VidK5QRAyP40svh2UFnpnQxPfifqyavcNvP8mJTP/g9z6mRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983755; c=relaxed/simple;
	bh=B4/uKeFQHpyqNhkoU3L8RIaO/6OlxwBv1vJVz2FE9rE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEx1dJqghcwrq6iDjzULDCEDUifLnDm6D/DDSzJQ4rdTVTVlOXbtkzqlIcsCZTNZrpYcS/BX3D+q0hqkXBMt0FDAa1HPDNKJIDqCcMMw7fnVEOqGbXNrIa86GPNfKEOJ/B/1YO2FustopG0WYHF+PflB2Jo3Ks4igpWZAbs5Xfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3LAiM8s; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so41021495e9.3;
        Tue, 03 Jun 2025 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748983752; x=1749588552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts5xavCFNYjvBrxVH+680SHA8PjLmI4AmY4J+ku+0HU=;
        b=I3LAiM8sag0B01e0wTZngfXv/Q1UEYay8+zuWuta0XxOISrQDkDw8HFsYeEHmy3bYD
         PHD36avYIfhvXbpa9gjkS0khtCi896omRanFjfY9dq/aIDKFOPCPalR+CmxUi0K/6xvM
         WDowkAQTF55S3Pswi+Hba6AGpHl4DHH8gK1AHxXH+tDVFWoGwUArTba7HwbTpK5GAA7F
         z2S6NPivRJ1TlwYGTcgfDjnj6pq5gqYBuGI4xG+j/G8vpukS8E/6m2ERd4ijPf0cfwbg
         4Dj37F61c9IQH6owgO1bWmH5cd1mk+DYegeXw+cNZjtN0JNVNY8Ikc+W4MJ0KwrrwuDP
         38uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983752; x=1749588552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ts5xavCFNYjvBrxVH+680SHA8PjLmI4AmY4J+ku+0HU=;
        b=WZ8LK2fl/Up6JIw4XR8TLPUlZ77wrXNW90t9R7SOXzd1IDcCB4/LkUG24XkwSpK/PG
         7e3SdWtbAOUHp+UxzA9MsHxpHe5KLjEagmEBHPI3ZKOnmMEHlyo4CZu8KBpj4VtX2n/x
         PF8FRdN6yjnAiTS83hYyhdnpWkRJ6bl2WHNDxrYh1bmVjTrTF2lZKuoouDtDu3IcLoQv
         HmKhTI/pWH9fr2T6KDCaf/A55sxgR0Rhqef3RaXJXBW9p/B3fXXuf8FH9eE+aQnWpnFf
         40Yv5v8agxRewBNB8Uuf93weanQaIlmB3YJHqgWkvRUwaWDANd3Tu5cX7VXDwpGDhfi5
         iSYA==
X-Forwarded-Encrypted: i=1; AJvYcCU0jOIxGqG358Uw687TbvyKFgMX6VHxAkSNxrl1clH4T1POYXIcMNPD9XFjH/0mZyknjFJKheBnleLc6uw=@vger.kernel.org, AJvYcCXkSNmJppqc9TgzcwbHS4uKq2gwoYN0lZioeUay6MPsblGyhdyV6BUqIGF/XEoGCUBMWcaIAQ9f@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsa/LVmfh4Nuer5X4e58rp7jIZP4HeCbilEcBCwDCanKXxudP6
	aezAp4UXrxD68lQzqUd8D4c7PvnT6YDKvsr9Bxfif5tewe6w40mpD0IS
X-Gm-Gg: ASbGnctXeDuTLcsFi6iTvv9eONqQ6dtNloJKe3vO82hxGFVvm/xl12fe6PrW/R2gLd/
	UFjcdfBoBg7P/zmaqQdfs/B1sxd6LVGOjDzubrPgoZsrgAtjVAzmQ3Z3yf0Tc5noBhApsmFLSiz
	W4y00ygXz1cYs/oEVk9pcdHcu9wMjku+I9Xqf5Qv1Ib+oZqiQRJKNjaZ4ZlBlIVgPO0sMJFqHAG
	kzKrPwu3DWsqslE5KAD/I3cf4/4vc3QtB9ddaibVAbx3WsyzJi8am4KS+Jw2b7xAKEfV+nB4ebM
	8sPVHiXyNz1E3S3XvxKgnJnLet00A5ZZAXrAt3lnVyt8kY5WUhfNRt77CdKAAseY6zk70jeemwq
	Z3a2ulKMITGwa2uuTzn65giYIzsO9a7fUftr11mnD3h8jsEuMG98iKGDchQEyE2g=
X-Google-Smtp-Source: AGHT+IF+ZC3Id7w/YC9SXgrH6Z+4cQonivRVcLMBCmGHFBoV3nFaiJfvjePaJXjpr1hpgYEhDos9Rg==
X-Received: by 2002:a05:600c:4e01:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-451f0a64f08mr1415505e9.4.1748983752142;
        Tue, 03 Jun 2025 13:49:12 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1500-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1500::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451e58c348asm26258225e9.3.2025.06.03.13.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:49:11 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH net-next v2 07/10] net: dsa: b53: prevent GMII_PORT_OVERRIDE_CTRL access on BCM5325
Date: Tue,  3 Jun 2025 22:48:55 +0200
Message-Id: <20250603204858.72402-8-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250603204858.72402-1-noltari@gmail.com>
References: <20250603204858.72402-1-noltari@gmail.com>
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
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 21 +++++++++++++++++----
 drivers/net/dsa/b53/b53_regs.h   |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

 v2: no changes.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 693a44150395e..4cee69f29cf8d 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1277,6 +1277,8 @@ static void b53_force_link(struct b53_device *dev, int port, int link)
 	if (port == dev->imp_port) {
 		off = B53_PORT_OVERRIDE_CTRL;
 		val = PORT_OVERRIDE_EN;
+	} else if (is5325(dev)) {
+		return;
 	} else {
 		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
 		val = GMII_PO_EN;
@@ -1301,6 +1303,8 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 	if (port == dev->imp_port) {
 		off = B53_PORT_OVERRIDE_CTRL;
 		val = PORT_OVERRIDE_EN;
+	} else if (is5325(dev)) {
+		return;
 	} else {
 		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
 		val = GMII_PO_EN;
@@ -1331,10 +1335,19 @@ static void b53_force_port_config(struct b53_device *dev, int port,
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


