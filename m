Return-Path: <netdev+bounces-69747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E684C776
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 10:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C4D7B22774
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917C82232E;
	Wed,  7 Feb 2024 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sCHo6hr4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC825779
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298366; cv=none; b=PHm3yzuwiGhvixtro73/buvGQGdHLzmGynELEHXaEWpFpAq7p+6vgLnqZsJdzY3Q2AGUCZsFqvQklyeNAM4eIJVVmMChBhvJVgdvrN1iuIj0AdQ3l6bo/Xsd9nAJ4lWVW8DnO4WFcziAlNCk2+LLr2mRDVKqfytF3g93wHB9MNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298366; c=relaxed/simple;
	bh=JRTeU/WQ3xKHyIzAInVb+YB994geyTmL8GEhny2GOLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKoO36VgK5t/GMyTQVLQevyaucUaCc9FUELOi0KZpVhKXMmMnKLLN/Y+I+HWsflWLzrYX8Nzfu7k91wUQ7BhQl4LI70JvqFLO0l4DQgmH8BOcClGzJSiMw6GO8gA6br9PmZFmp11LyjCXukK4OetiF7L0cAIM/7aABS5K+x7/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sCHo6hr4; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d073b54359so5378831fa.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 01:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298362; x=1707903162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecHvachtVAv6sW84z8AsSsUI9BS/8T7kEDPcbDUA3lM=;
        b=sCHo6hr4gpfyvdu6NAPW/86TDVtWjC3OvdBvwHZ5gIQZ40omJLYxlP76kc4hRgT2BS
         cBNBKaQdCsNcicm69t1PgOzNB92ax1OJMtowTRKH1TwCxLQ7Qa+TI//X4t3tOPiddj1D
         72EWN8VtdjiDFnmPSTrm55XRezSGInSg9EdnkQl70/olZllxEOdDO+CMgnb69ZQdJK0u
         SqvwfgRsDqrv7l24tWDjiwrVjK7FW9+XQrzZSxmRSx3Ja2JbtiDKUzmU75Yf4/29gMO5
         KpRzNzWxDeOikR7TyM9lm2XE3L0nIB6oYwKgmAUc2W2+xpzU1wyf7hsnssbHDoAk+Kfe
         F4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298362; x=1707903162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecHvachtVAv6sW84z8AsSsUI9BS/8T7kEDPcbDUA3lM=;
        b=O15MV888gJfAWjwwVsaE0mJc4BX6Ci/xTfNBft8wdpqOsR0XVC0SVgH2D815ZOyvAY
         g2Jci7EPfUBKVgpFQaVYOH+dknxteZSA631+4WHmeXvh3MSCyIBeYA3Lr7U2PY59C6QF
         cZw+WQKSLiwk9aKivS/0iyI9p1H0MZLtWtNlw1uOsbsnIrStr2D2x7/PDDmsXZc6u2B3
         mAJHgjdau42BBzKvnduGnegkbeejSg/HzYoLLsb5NhhlY4rYXlczXOQvRdvhzJLp4V76
         C8LAGlmCHn9T2ssYouE5u0v7H1bzf+YHhKhW7JJ7Y4V3mZw/ueZ+BJqAQnkQ9i9HlWQ6
         CITA==
X-Gm-Message-State: AOJu0YzGrjSTfA+zzq2TKMF6B7tcCyk6tq4lxbljiU3DTFS7bMm1wozJ
	8FN1wMQyCyxr+b5Yj94ceHPwPzT8NfmKmt9R+7JZJgRaeUgMaWWBp3+gTpntE9Y=
X-Google-Smtp-Source: AGHT+IG4xCnOjsLrRUcNuGS7caw38M+9njqUmb40A1WXpFOFy1FQWE4KoM39FRiymyeeDPpJDhbtsA==
X-Received: by 2002:a2e:a273:0:b0:2d0:9322:8d0f with SMTP id k19-20020a2ea273000000b002d093228d0fmr2829069ljm.26.1707298362563;
        Wed, 07 Feb 2024 01:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXe/gF7sBIbzhAK8HMgggca/Dyc7ERgBXVfAucw/KnZW92CbTCvyUBIm/Rpa0lEveRXoBszuehhJqGLz31rjS4qu/qhN6XpUlgw/pNE8QfPeG7eA+lwHAA1wWmS3A9f8ug8HSQ6DKF2EJ0jcjj/xBTAUEkWwCMRAmLow4eElvKkwUnztU0ialSBVhTsfK71umwzASMR33wTiZgN/ClKbPskxxVuzdbRzWA19pX6X0wT9fmxsLcjaN9S/fZzxUB6SdCpsugyRZFlnaWqJgDildZXwc5XbcllM4KlPqVDi9WhRBiMn0ohFneW4AWY8hG0etb5GQ0KpIrYQ9oLwN5OfvLF3T2WnDQSHdy92v1uyb8LfpXu8EslEIe+78s/WNclItuAS/SYkIpjgGzK0w4rA5YzuwIV4ICx+bPvj2RLTg8myyuDJgYPAJRcP17U
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:41 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 06/14] can: m_can: Add rx coalescing ethtool support
Date: Wed,  7 Feb 2024 10:32:12 +0100
Message-ID: <20240207093220.2681425-7-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207093220.2681425-1-msp@baylibre.com>
References: <20240207093220.2681425-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the possibility to set coalescing parameters with ethtool.

rx-frames-irq and rx-usecs-irq can only be set and unset together as the
implemented mechanism would not work otherwise. rx-frames-irq can't be
greater than the RX FIFO size.

Also all values can only be changed if the chip is not active.

Polling is excluded from irq coalescing support.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 55 ++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9b3e8e09f3aa..6dad1f569f82 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1977,7 +1977,57 @@ static const struct net_device_ops m_can_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static int m_can_get_coalesce(struct net_device *dev,
+			      struct ethtool_coalesce *ec,
+			      struct kernel_ethtool_coalesce *kec,
+			      struct netlink_ext_ack *ext_ack)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+
+	ec->rx_max_coalesced_frames_irq = cdev->rx_max_coalesced_frames_irq;
+	ec->rx_coalesce_usecs_irq = cdev->rx_coalesce_usecs_irq;
+
+	return 0;
+}
+
+static int m_can_set_coalesce(struct net_device *dev,
+			      struct ethtool_coalesce *ec,
+			      struct kernel_ethtool_coalesce *kec,
+			      struct netlink_ext_ack *ext_ack)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+
+	if (cdev->can.state != CAN_STATE_STOPPED) {
+		netdev_err(dev, "Device is in use, please shut it down first\n");
+		return -EBUSY;
+	}
+
+	if (ec->rx_max_coalesced_frames_irq > cdev->mcfg[MRAM_RXF0].num) {
+		netdev_err(dev, "rx-frames-irq %u greater than the RX FIFO %u\n",
+			   ec->rx_max_coalesced_frames_irq,
+			   cdev->mcfg[MRAM_RXF0].num);
+		return -EINVAL;
+	}
+	if ((ec->rx_max_coalesced_frames_irq == 0) != (ec->rx_coalesce_usecs_irq == 0)) {
+		netdev_err(dev, "rx-frames-irq and rx-usecs-irq can only be set together\n");
+		return -EINVAL;
+	}
+
+	cdev->rx_max_coalesced_frames_irq = ec->rx_max_coalesced_frames_irq;
+	cdev->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
+
+	return 0;
+}
+
 static const struct ethtool_ops m_can_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
+		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ,
+	.get_ts_info = ethtool_op_get_ts_info,
+	.get_coalesce = m_can_get_coalesce,
+	.set_coalesce = m_can_set_coalesce,
+};
+
+static const struct ethtool_ops m_can_ethtool_ops_polling = {
 	.get_ts_info = ethtool_op_get_ts_info,
 };
 
@@ -1985,7 +2035,10 @@ static int register_m_can_dev(struct net_device *dev)
 {
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &m_can_netdev_ops;
-	dev->ethtool_ops = &m_can_ethtool_ops;
+	if (dev->irq)
+		dev->ethtool_ops = &m_can_ethtool_ops;
+	else
+		dev->ethtool_ops = &m_can_ethtool_ops_polling;
 
 	return register_candev(dev);
 }
-- 
2.43.0


