Return-Path: <netdev+bounces-153499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDD79F8549
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 21:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6168188B967
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 20:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14C81FDE39;
	Thu, 19 Dec 2024 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XjzFeR/2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC31C07CB
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638349; cv=none; b=V7uEMgR/rUaig7+XvrrupXd7lkRR/6yHkDEBjpsdsrl/WtZIwzF6/lBvcPLjJjDzuan30TeCiwJSGaeGnuXfcSF3a6ca61thLQuartXjawJvei+cvvqLZJWXua/z+sPRtF1RHA0+FC/J/5DVLWMBZzb5EDdYCBTaxr3XvbzS/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638349; c=relaxed/simple;
	bh=JFdVPVem4046BqyFJNrVT8yrmK5qAD0B08AcK/8jouc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BuPZVC6PfmRxNEgZUTl+owl3iJ/jRduIbh8L/xh07iJrW/2BK5QRvBLCnbvompIWb344PZwc0yHujoMVLu3JlQQTeCxF2bYeeHVA33Dfjg5Zf4isXajFSjOihFKME9pMF1AJh0bfc0aRQg0iHm0R+fpGdz+RwfzFjfUCZj5aezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XjzFeR/2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso2266193a12.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734638346; x=1735243146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hLOILUzDo5sXZb8TaMc1HjYSIW50UI2D0EZn3eUUCc=;
        b=XjzFeR/2bEKWzpAFe/fpx6GAM2nPZH7iSbhamd9PCgoq8+PZZiPjhDs8M8hahk7gVy
         7dr+7gxzskVdlUAciNcwJL7avN/FmTCFuE9cA9cStAoPb276DnrVJq+qF075IIuz2bWD
         XVaKVB8U3NGn69YOIV1pQ3MdosxeoBa03VbKBGis6OGe0kFyZKaWxedXEIEyFMjSXK7G
         yT2qmBZCNIPMvBn75qDy4n9OCv9+nyCWixL8EPScYgygiSoQ9zjzxMzHvr7VSrlmehUe
         F2J0ZEugJPiG8JioK8a3wdMDxYAd5LFmP1GALbQBXm72ducurGxwtDuGSDAUWdpFYDrD
         hCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734638346; x=1735243146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hLOILUzDo5sXZb8TaMc1HjYSIW50UI2D0EZn3eUUCc=;
        b=laIXfBCz4IdgGxXDvONUPU0XJ3fvJEmnJxXB9QUfcPJgmtCYiuZ84dtKRvEd/IJE4A
         FT9H5BDVFQzgmgyJTkvZIp+iFYwGyxCoTWhDXEpz0OdOyvOFkV9I9uNWbyztw7DFhqMX
         0zEKZKIqHe9puuTWnToUAo8yOim39AxDt4/OMMAiMSAOhwL6955sr60S2Ah8VLaYMmu/
         7VckTGcdxtMpGAcPxQGc4GY7UJvHoupRh25uBUMFBH+eCu+88hlWVXxRg5q03IwomggO
         s6Yqo/XfF9+nMHxqjFi1RCfh9Gh17f4kx8S3w1af4DcJRfSrTDuheC2clknQ6zKWrUt2
         kuVg==
X-Forwarded-Encrypted: i=1; AJvYcCVEwGo4IJjL2UCVi77ONi2GkeNcLvvLSrRmLtLMlyIZOzpLzgzvPceIAY9HqeSRflYgjrgTk1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHisVfRuvmg5Tv8RnkImoCETW9OMX5OQypYU9MU72nlVInV2z
	SMOvk8t/xgcZ7nLvGaNwVuhVmxK6mwUfpHTDqFW9IZGrz1yG1QFWzuZeu7FSqOE=
X-Gm-Gg: ASbGncs9ZB32u6IjluQdRdjrdaHycy4G4Qm2ERiu0vZCuFRDU9wSFs/jdmgzrtxRxiS
	AH4Vy0UjirS5c4lkUZ2be/VvYgf9G/WH/Ewlwo5Zw26nlaThmFduZ35KLzr9Hptwc3qvfR7RA/n
	+GSQG8ipwcK5q7/8bSmqvzNzSRysfMrrAJTkAy2oqFEwtkihq8xWLSfPnqhFWCHZeQ3XTzApvOX
	0rUKLW4HnOhEkBeS8f+yQcNRmlmYIc4ZrFcMcsGnKCCEItVFA==
X-Google-Smtp-Source: AGHT+IF0fmv4Wr8LY08jRHZsI4hjJsYafL7GiFI9dClEL14qKh8/PvfWAazPI1H0PfTeK1OuVNPC+Q==
X-Received: by 2002:a05:6402:401a:b0:5d0:e560:487f with SMTP id 4fb4d7f45d1cf-5d81dd9cda0mr166803a12.11.1734638345098;
        Thu, 19 Dec 2024 11:59:05 -0800 (PST)
Received: from localhost ([2001:4090:a244:82f5:6854:cb:184:5d19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701c822sm944816a12.77.2024.12.19.11.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:59:04 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 19 Dec 2024 20:57:53 +0100
Subject: [PATCH v6 2/7] can: m_can: Map WoL to device_set_wakeup_enable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-topic-mcan-wakeup-source-v6-12-v6-2-1356c7f7cfda@baylibre.com>
References: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
In-Reply-To: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2839; i=msp@baylibre.com;
 h=from:subject:message-id; bh=JFdVPVem4046BqyFJNrVT8yrmK5qAD0B08AcK/8jouc=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJTql42hv/19nSYusP1CavLp22BNzZ/n7ouRXbt/D8C6
 h7r+A5c6ChlYRDjYJAVU2S5+2Hhuzq56wsi1j1yhJnDygQyhIGLUwAmov+J4b9TXO2Cm37sN//f
 a8hrCUk+uTZxt8CZi5NOl7adu+ObLfaMkeFTQNfl8oeFMqtrDm/I4c1fUBR8zveqgEjR8R0uXD8
 MLzMBAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

In some devices the pins of the m_can module can act as a wakeup source.
This patch helps do that by connecting the PHY_WAKE WoL option to
device_set_wakeup_enable. By marking this device as being wakeup
enabled, this setting can be used by platform code to decide which
sleep or poweroff mode to use.

Also this prepares the driver for the next patch in which the pinctrl
settings are changed depending on the desired wakeup source.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16e9e7d7527d9762d73a7ec47940c73c0976e05d..0dcdcde3449c7647e4bc9a92f918160a336f94c0 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2186,6 +2186,36 @@ static int m_can_set_coalesce(struct net_device *dev,
 	return 0;
 }
 
+static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+
+	wol->supported = device_can_wakeup(cdev->dev) ? WAKE_PHY : 0;
+	wol->wolopts = device_may_wakeup(cdev->dev) ? WAKE_PHY : 0;
+}
+
+static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+	bool wol_enable = !!(wol->wolopts & WAKE_PHY);
+	int ret;
+
+	if (wol->wolopts & ~WAKE_PHY)
+		return -EINVAL;
+
+	if (wol_enable == device_may_wakeup(cdev->dev))
+		return 0;
+
+	ret = device_set_wakeup_enable(cdev->dev, wol_enable);
+	if (ret) {
+		netdev_err(cdev->net, "Failed to set wakeup enable %pE\n",
+			   ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
 		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
@@ -2195,10 +2225,14 @@ static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_coalesce = m_can_get_coalesce,
 	.set_coalesce = m_can_set_coalesce,
+	.get_wol = m_can_get_wol,
+	.set_wol = m_can_set_wol,
 };
 
 static const struct ethtool_ops m_can_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
+	.get_wol = m_can_get_wol,
+	.set_wol = m_can_set_wol,
 };
 
 static int register_m_can_dev(struct m_can_classdev *cdev)
@@ -2325,6 +2359,9 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 		goto out;
 	}
 
+	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+		device_set_wakeup_capable(dev, true);
+
 	/* Get TX FIFO size
 	 * Defines the total amount of echo buffers for loopback
 	 */

-- 
2.45.2


