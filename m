Return-Path: <netdev+bounces-139822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDEF9B44C7
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6769A1F24528
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 08:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2202022EB;
	Tue, 29 Oct 2024 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ieCSYjL8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C21B6FB0
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191609; cv=none; b=YrIUtc6zPMgD5S0hjlAEkfmmTV8He92zYO7Hp1pozzzBTQqnF+KG3vNjdl4Cj26T0l9/ZuGW5hdl1j4tKLc6OR5IuCn4x9ZMWqSfgqLuT6UshSvV9lSTlKDYu7AUuMt/aZvcder/SmJtB24AOQoRq9Nr8LXdgWQEZshQ2K7I5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191609; c=relaxed/simple;
	bh=lvBH4nDZzUSZ6y5ghSyZfw8hPI3PkCQivKPs3UeNvug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5TfjZysD/rzfS+4M8tO/nXUu26XhKkHJiAvIruDC7Y2bPFCIv2m4N9L0cIeulKMsnWIZ1R1jVF+mt+wnbkxkE70g2gN3EznwCLGp7Aj/H1iuYvm6zFNE7rg9AXarmtvm1jDz0ZJqUiqwCFqvi6m1J1vkWzv7G8/gGQG3w0XMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ieCSYjL8; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f2b95775so5987440e87.1
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 01:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730191604; x=1730796404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwyMMsHa5HEUfO6bt7mbb/5lMim+t5T1aF2qtApwxpM=;
        b=ieCSYjL8IptPLaZ6hAKobBQVUhO21p62duTr9ghMpGYtc5ZkBmVVueIBViErvlFGgE
         NavjIn9YhmofkH8a3crQQ9DMdJW+ilmF1VIljCWPMUuObs1kiO8XCxljiguWXYiVS65J
         xKsk/YOdvh3ojWawT5hFbSp01kogXP/RH8Xc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191604; x=1730796404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwyMMsHa5HEUfO6bt7mbb/5lMim+t5T1aF2qtApwxpM=;
        b=QXBvyvjsKdKTaj12s2mO605HkljhryuCFc9G4C0oP3vze8oxjzCRIZzSpVoR+8XK3S
         u8DSGJ6nNwXPdL3uXg9kH1V8iwIYsZFEbT1y93rPisJkgDN2wiKYz1vp3ZvXhv346/gL
         tyzWLD1xvALXri3T8x2o4eA0R0QmeR3RGOcRBcf8nQ4ca0X9FG4eFYgCWk3mNKiAXhS/
         qc5FMwmvcLRIii2XEbubCPbt+aaBCyAFtJWFEJUbbZUaEEbULbXR657xKQHm5suZWCKR
         b+9y1j4iOCtGzgKIsSjW0tbm/pV+ECFHf9INX/trtAPZ//JQPMl8xGGWbQt7HH02QYJr
         OENA==
X-Forwarded-Encrypted: i=1; AJvYcCWS5P3CRZlv97qi00t76m2C5+N3Z2e/KP1g4ZZbVXAHWaaby/X4fYDxT22WIfIkIdQDUNUljSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbxXsQT4hNqefExbIDVEu+ngDxsXCI5v/79R+vyLXB/uwRd2wW
	uPwXO7K9e35Dy1JCz7O9ExprgEXMOkwWr7a71VT5ew3yBm1SSqDDVAR+bgNps6Q=
X-Google-Smtp-Source: AGHT+IEISmXm1iH8AiJejbMa004PxvUCwKNYOyyhBpeNGrG9KbTdzRJ6Jk4J3pez3yKENXfTWV0g2Q==
X-Received: by 2002:a05:6512:1252:b0:536:a4f1:d214 with SMTP id 2adb3069b0e04-53b348cc55cmr9003984e87.19.1730191604452;
        Tue, 29 Oct 2024 01:46:44 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-68-117.business.telecomitalia.it. [79.40.68.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7dacsm450134166b.9.2024.10.29.01.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:46:44 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v2 2/6] can: flexcan: use can_update_bus_error_stats()
Date: Tue, 29 Oct 2024 09:44:46 +0100
Message-ID: <20241029084525.2858224-3-dario.binacchi@amarulasolutions.com>
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

The patch delegates the statistics update in case of bus error to the
can_update_bus_error_stats().

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

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


