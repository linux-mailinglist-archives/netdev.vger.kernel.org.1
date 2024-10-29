Return-Path: <netdev+bounces-139818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7883C9B44B9
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2561C22262
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 08:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA40820494F;
	Tue, 29 Oct 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eCzuHOiV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAAF204945
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191587; cv=none; b=As938vq5I+PJbvq46/1XSmoqKE9efAQ6x+OcA+2SmzOZTYGE46EVH9ATWYaYGFHgG3+dP5G1ZawWTsKjtiaqU+Qs5/4lFZt+6MbuwRECBISi2cDWszSlXCNelonyFiggQl24nyBfsI1TnfktDmg09G80ajs3GnZhdBPobSxkVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191587; c=relaxed/simple;
	bh=7jZErEgYAUH8xk9j5Uoe+tHYPD+nw3TS+qHbiMcKb80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nx9kJ1m7XQ80H8SCife4cLWVlT4dvXJn4f5rBqMo/wGnnuuHoiDv6RT29EWQDxFwcCTQjq/0Wrf30DirGnLwIBVOJgFXTe/idMZM0hhrGUjya5jp1DDrrPC5oknlzVFwmAp3yA1R1nnZVhZo8VUFEi3nCvBJATBpJSBVTE+1x/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=eCzuHOiV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso6156386a12.2
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 01:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730191584; x=1730796384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDcquMlQbBV3XN4Io8qW6xdqDAgSIub1vLoIuhz6Z10=;
        b=eCzuHOiVtY2ZJD4owOG5zMGPhLDlJK3w008p7yR+ZGSJYLK19d5O+ylnP5iij8uGLX
         6nfWFoDmDmPT6cX8Qv/YIxbRIrM6uw1EsXPp9rIvp83RY/30wu0MSmd/J1NsqM4q3YaR
         au2CeflwBhByh/bIP3kdmyU9ERTonRhuUnlfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191584; x=1730796384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDcquMlQbBV3XN4Io8qW6xdqDAgSIub1vLoIuhz6Z10=;
        b=ijdGzCo2QgMoL3dMjuajRigYK3JLM1jF6E5+FmJVLZ3RMOHNo+FL8iVSdso+NMVNhz
         ikYMon4LdDdqU7nKVt071JuT4VLYRtq1fA0SVPqlTNznnITKn0HqVNXHlv/WVCFbZVhN
         DKJXiXlue4MlpkzFy1Ix92B7m/rtZiCIvRmR2Y4nIZO8g06haBFb/Evrl8pZjf6TYRJz
         J/WSMXAaa/B4kyvv+JQ7s8GGhukz/RtCVT04W8XKEj3esTv7F1GEykojL1QvevrrN/Qm
         NoDPsoh0sYt8DnbJiZP3pHCJUVZhDIBh3+DdcQpV9DDyOSvF0hwuAZUutH50/tGOU6tS
         uIxg==
X-Forwarded-Encrypted: i=1; AJvYcCU9eZOgKBshsUQejgy4fnxVBKw8JD8dUkQ34Gqb4oZlMhuR1liVtSVuk4TuerBZ45j7CZgsXkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt5K3CJlkzmqqi2H4XwTsWQ8ILA3tYfu5hQj409vRbb171HV4H
	SS4izK8Dr6F6KNU683d8NSAMCzfMq2Sx0w66C4MM8amVos+VwT89n5mqkkKGQAI=
X-Google-Smtp-Source: AGHT+IGQHk3b2V3qEBkaWlzGQYJYEEX9sbx1ZZHVJ7DYIM2F1SK1zV1W2kZaoYuPp8TXT2xduyix0A==
X-Received: by 2002:a17:906:c10d:b0:a9a:37fe:e7d0 with SMTP id a640c23a62f3a-a9de6199186mr1046662666b.64.1730191583525;
        Tue, 29 Oct 2024 01:46:23 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-68-117.business.telecomitalia.it. [79.40.68.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7dacsm450134166b.9.2024.10.29.01.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:46:23 -0700 (PDT)
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
	Simon Horman <horms@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v2 1/6] can: dev: add generic function can_update_bus_error_stats()
Date: Tue, 29 Oct 2024 09:44:45 +0100
Message-ID: <20241029084525.2858224-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029084525.2858224-1-dario.binacchi@amarulasolutions.com>
References: <20241029084525.2858224-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v1)

 drivers/net/can/dev/dev.c | 30 ++++++++++++++++++++++++++++++
 include/linux/can/dev.h   |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 6792c14fd7eb..0a3b1aad405b 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -16,6 +16,36 @@
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
 
+void can_update_bus_error_stats(struct net_device *dev, struct can_frame *cf)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	bool rx_errors = false, tx_errors = false;
+
+	if (!cf || !(cf->can_id & (CAN_ERR_PROT | CAN_ERR_BUSERROR)))
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


