Return-Path: <netdev+bounces-139886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E839B488B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B621D1C2252B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342A9205AC5;
	Tue, 29 Oct 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OkgwDSj5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01170204F86
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202393; cv=none; b=kyMj1ZJLAtzyawXBveIdVkI8GJ95czm9mnaISPbdRPF9A/Mpl5wCfpCU9iUe8fnCSTNQc0iccrdcEOWpTKQAHVlQ7pWVVTCyj7tcD/SPUV91wnM7an3WvGRZaF1+cS6VOqLgxZcklUQGnpjmMAdmpxbCayyHs1rmNeE9YRIwXek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202393; c=relaxed/simple;
	bh=MYi4S650y33mN73Kf9uazMkGdu+8CjicgD9fCZT8FKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dI3Dt3q/4j/srJPlikZwwMlcwiPs/SSr3uE1rYyVizBUB9eKUpMZTD8U7bTMZ7HbWF8+HD2x77SAreFK0Ira/6+e6eO4sAu3lbVs2Sll0F8fpjBgq5t/E6MlEOvEiT9W8op6dws9vWU/vFm9RtB0kBVNX08yspj+u0Zo/zxJvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=OkgwDSj5; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so6327686a12.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730202389; x=1730807189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeZLl8zUuEL6V9/kOSR2k3pEjiYcKf6aSxS5b01tjs0=;
        b=OkgwDSj5bEiKIgiUaGviEZkWotgzHy0r4z7CfeOh+SoWMDpHWfJMgE1jsyF/uYDJRM
         bH/HaiydkrYvHTrBnamwst50mS6kSpO3GUQrLxAQTSktuRzxyP6reu3zDD94FeiP4+JK
         bnb8VNfsHAbqxS6mwXk0SR5MZ71zZGSuF/MV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202389; x=1730807189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeZLl8zUuEL6V9/kOSR2k3pEjiYcKf6aSxS5b01tjs0=;
        b=v7CQyFr5qh1HHwgojfGHT7vaueimjePf6RHzfvCwdq1+27gxJKMtxJnaGOi6HE6s1S
         ZU41blP4A6Q+CxHZ8giQhUz8aywb1JhReHeeSrFhq31xVcuf/0RNDJ+ZQuh9l7Q3VwBw
         EdkXGQ37RhfQ2Wys71w1TgxQGsMVxVuUW5xEofZx3P3FQQ6X/pw+KmsywChA/VUPz5sl
         +rwhwe2i1t/iGQD/73qkU/kDKN6zItLgY9571wU70FpqkzQVBKR3C1s0Qp+To2jSBkpn
         JWuRFcfoZJVOkBYuAvOXqcHPz5rcSkhmzogiXQa67DhZyBOQfYWfMbqm8jnzURfO1wR0
         7n+w==
X-Forwarded-Encrypted: i=1; AJvYcCWN0Z/vtBFgPbCE1W9j4ZJcVkombFgI2MH7qVOQpAPzn5DNmt+83MD7pLeUtuHBHazeNVHD3QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmvvrghxF21gYQ36XFS/JJyB4xUC+//EtJ4a6ETJVd1YywN2/D
	RRCyf8pnFHGKg8g8tjL7Ixo5WdEYCaKyOgSjWwkbTsVKIb7Pu9y47GDDIKeEkY4=
X-Google-Smtp-Source: AGHT+IG0az3xTPFahoyYAxTC+lhA3oJJQQ7Bh7+sxOSbR2RbP2MPBmSUOm7IuDoXUgWCFF2NCcbQ1g==
X-Received: by 2002:a05:6402:5215:b0:5cb:ee14:d08d with SMTP id 4fb4d7f45d1cf-5cbee14d13fmr3714450a12.15.1730202389145;
        Tue, 29 Oct 2024 04:46:29 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.41.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6297a09sm3869301a12.21.2024.10.29.04.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:46:28 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v3 1/6] can: dev: add generic function can_update_bus_error_stats()
Date: Tue, 29 Oct 2024 12:45:25 +0100
Message-ID: <20241029114622.2989827-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
References: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function aims to generalize the statistics update by centralizing
the related code, thus avoiding code duplication.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Drop double assignement of "priv" variable.
- Check "dev" parameter is not NULL.

 drivers/net/can/dev/dev.c | 30 ++++++++++++++++++++++++++++++
 include/linux/can/dev.h   |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 6792c14fd7eb..4ad0698b0a74 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -16,6 +16,36 @@
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
 
+void can_update_bus_error_stats(struct net_device *dev, struct can_frame *cf)
+{
+	struct can_priv *priv;
+	bool rx_errors = false, tx_errors = false;
+
+	if (!dev || !cf || !(cf->can_id & (CAN_ERR_PROT | CAN_ERR_BUSERROR)))
+		return;
+
+	priv = netdev_priv(dev);
+	priv->can_stats.bus_error++;
+
+	if ((cf->can_id & CAN_ERR_ACK) && cf->data[3] == CAN_ERR_PROT_LOC_ACK)
+		tx_errors = true;
+	else if (cf->data[2] & (CAN_ERR_PROT_BIT1 | CAN_ERR_PROT_BIT0))
+		tx_errors = true;
+
+	if (cf->data[2] & (CAN_ERR_PROT_FORM | CAN_ERR_PROT_STUFF))
+		rx_errors = true;
+	else if ((cf->data[2] & CAN_ERR_PROT_BIT) &&
+		 (cf->data[3] == CAN_ERR_PROT_LOC_CRC_SEQ))
+		rx_errors = true;
+
+	if (rx_errors)
+		dev->stats.rx_errors++;
+
+	if (tx_errors)
+		dev->stats.tx_errors++;
+}
+EXPORT_SYMBOL_GPL(can_update_bus_error_stats);
+
 static void can_update_state_error_stats(struct net_device *dev,
 					 enum can_state new_state)
 {
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 23492213ea35..0977656b366d 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -201,6 +201,7 @@ void can_state_get_by_berr_counter(const struct net_device *dev,
 				   enum can_state *rx_state);
 void can_change_state(struct net_device *dev, struct can_frame *cf,
 		      enum can_state tx_state, enum can_state rx_state);
+void can_update_bus_error_stats(struct net_device *dev, struct can_frame *cf);
 
 #ifdef CONFIG_OF
 void of_can_transceiver(struct net_device *dev);
-- 
2.43.0


