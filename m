Return-Path: <netdev+bounces-135248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2A799D27B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C795FB26BE2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A451C304B;
	Mon, 14 Oct 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="d3ZYJbnt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB271BBBC4
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919488; cv=none; b=HpBuSCwj864noOPhL6UqU9CXizD5RfcUszjbmNdmp1KAu3nhuW1CbgbYqmQXCCZ/WTf426cdWuRiNlIxbOTenWm0TSiU7cSDQvxWrqKhJ1mQ1v2AP89if25UZRJ0bGgJJLsfXcsuCaaVwQVK7G73I6DeDG3r9bQP3KDz92Jz/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919488; c=relaxed/simple;
	bh=QuncdE9kUGyMlrCyIU0A4Zo2V78v+caSklfTJlnlBoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osHyt3Jf4xOd3C358eTAZNHBi4u04t3xTp9XWxOMXw3/UVFNx/woV4OCq6AOXqcJ8Dv9qlrkQNpLzah0UzDe4BwuD4PvukkLDiocAFrH7jR9oQ8ufB2gUruC+bLF0EaEEo7F/mV6ehnfXkuywBKtXJIYl0TYMJuWS5NqCWs//Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=d3ZYJbnt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4311bb9d4beso28325535e9.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1728919485; x=1729524285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1ubGjttmwYd5EYJYtdXhE3bw7ehS4yxQFLk9r6TH7o=;
        b=d3ZYJbntwdn4IEaNQYmelmba8O6qT5VlM9+CeoiUHpYfCK1U2kCC501UVI6/PUaycf
         kGsSUlezrjY1RmvkME6SuYjhJzu0zRs1hUp6FnyNSfCDMF4VO8JEQEajhbrKdGNJF3sN
         REtbOnMyTL4VBfSpxUsrW/Idg+m+cAJZxsrQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919485; x=1729524285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1ubGjttmwYd5EYJYtdXhE3bw7ehS4yxQFLk9r6TH7o=;
        b=IJ12p90Bf4V7zO9Ba2qXE2/s8plpDVk58P8pAd5uEUHveuEia0pd0c1kV1pJZwcZpH
         XvVhRY/slHQDs2bDrH3NdT8gFFKKULuCnqXCLfybaJwIeHqmWsaSOlJ5VP1P/GZdHqEk
         RPL2BnHa3j39jdmzOxm7A/2daHFNfcAbAsaGvVTBi2VP/zGdHcXSJaoYqxjioY8pe/sA
         +BnWGg5BctePI7SzjVZHBAH3uaN/Q0rpECbUeniVmfT/RVfcOZuBf5T+Cs/XnZjz6yTx
         LI8br1kp8J42zLLGTx4/rEUIlmTtzLaDn2vQmZiYjjpwNG+jjVRYpnacX/sKUtJqFHbV
         tuZw==
X-Forwarded-Encrypted: i=1; AJvYcCWJS88RwF0m5zH/a+WlXclx74+/GW2HbmbslukX9UQ2I3rH+6b8r9WOeTJadxlmxYhhyM7MTwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgdOATxw4WVpXnJkVXYsaZpVvNR8twkoLBVnMdNqJLQqgOuNe1
	s4DxfjhY4MTVJ/R2sSiKJjEk3PK484OJB4UTf4bMlX8AIVSC3lZjTCjE2kB3C6A=
X-Google-Smtp-Source: AGHT+IF4JWlOlvMPdCidrlARcCCytbWgSFORgP9Hmt+oL+CcsnuX/II03HaBHyokWumwj6uoTzDUZg==
X-Received: by 2002:a05:600c:3b8e:b0:426:6e86:f82 with SMTP id 5b1f17b1804b1-43125609939mr71666065e9.22.1728919485308;
        Mon, 14 Oct 2024 08:24:45 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.40.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd1b7sm11629911f8f.37.2024.10.14.08.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:24:45 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH 2/6] can: flexcan: use can_update_bus_error_stats()
Date: Mon, 14 Oct 2024 17:24:17 +0200
Message-ID: <20241014152431.2045377-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
References: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch delegates the statistics update in case of bus error to the
can_update_bus_error_stats().

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/flexcan/flexcan-core.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ac1a860986df..790b8e162d73 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -819,7 +819,6 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	struct flexcan_regs __iomem *regs = priv->regs;
 	struct sk_buff *skb;
 	struct can_frame *cf;
-	bool rx_errors = false, tx_errors = false;
 	u32 timestamp;
 	int err;
 
@@ -834,41 +833,31 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	if (reg_esr & FLEXCAN_ESR_BIT1_ERR) {
 		netdev_dbg(dev, "BIT1_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT1;
-		tx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_BIT0_ERR) {
 		netdev_dbg(dev, "BIT0_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT0;
-		tx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_ACK_ERR) {
 		netdev_dbg(dev, "ACK_ERR irq\n");
 		cf->can_id |= CAN_ERR_ACK;
 		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
-		tx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_CRC_ERR) {
 		netdev_dbg(dev, "CRC_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT;
 		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
-		rx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_FRM_ERR) {
 		netdev_dbg(dev, "FRM_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_FORM;
-		rx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_STF_ERR) {
 		netdev_dbg(dev, "STF_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_STUFF;
-		rx_errors = true;
 	}
 
-	priv->can.can_stats.bus_error++;
-	if (rx_errors)
-		dev->stats.rx_errors++;
-	if (tx_errors)
-		dev->stats.tx_errors++;
+	can_update_bus_error_stats(dev, cf);
 
 	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
 	if (err)
-- 
2.43.0


