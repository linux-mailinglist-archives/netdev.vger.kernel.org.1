Return-Path: <netdev+bounces-139887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CFA9B488E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A344B1C22546
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5789D205E17;
	Tue, 29 Oct 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cJAgIi0/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F85A205AC2
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202395; cv=none; b=bQrQpj3nVytxq4Bl+PNQWNuZFDYLI0Hip82XT/oC4+s0F7QK8IUuPkOFnSRu1+EGhwGjGqeuLiqlBMs8ijXJDGAfaFtV4kD3gK2M/lLG8p1/515q76O9nZGIOOS8ms4MKuMlaM6EDZn5Bw6wg7PhNMkNADD6vPA4f+/5w8FwzT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202395; c=relaxed/simple;
	bh=lvBH4nDZzUSZ6y5ghSyZfw8hPI3PkCQivKPs3UeNvug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+t86C2Q9T0l5Po5cwZD+0mrnEh1YSoVuw3hlHcjKux0UsfwtUYFUnYVA+we3GTF94S1dRevvecGKQzOMUgs6qTt8WSZ8WgWTv4Z9DgRYyEkoGoPs/nSYrJkWK9z7Dd6WtvtVjsRO7pskGval0YSgv3mQKgnEd0zuYvJTtfGjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=cJAgIi0/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c99be0a4bbso7286296a12.2
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 04:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730202391; x=1730807191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwyMMsHa5HEUfO6bt7mbb/5lMim+t5T1aF2qtApwxpM=;
        b=cJAgIi0/7SPUxJ7HNHDysZlTDGtxTn1tz/tcmQOEyXxvPbunMzaOfZCLAAl+1AOwCR
         qFQ3DyEVD558cPGtRGsvjhyuh5S4hAm4+Zv6IIIdfimu5w/CtlslfSCE4ep5h+zlF4uN
         U3Joh581iucoGm1pHb/0/50k007fFG1v3Ezq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202391; x=1730807191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwyMMsHa5HEUfO6bt7mbb/5lMim+t5T1aF2qtApwxpM=;
        b=M/4ohVw3l/rkxGvY5/Iw06dDdAsST01ALNVAT/jM7PaYowCLP/OsgVmbl5g+h/e9lu
         5TmrsUkFZupMAxyYA3TgxG9xdi3nGrnwx9odzBKccE8nCGNOz+5P61fHhw3K9JwuyLsn
         eai7A/jsZVlY0ZU/Z9Vj8ZOrgPKFCGqjhsLOj/+dGdOxStrRtdVI0N7oTEzlBjrZWtvc
         pxPc6x8fOwXSx6a1VW3ZKh4rY3m17MBDOWGS2A+AcTghu8pp/vvkQEayn+5K9EEUaZyV
         CTwa2yhA12d+GreGVoMiIuNPV3uKETxzzDFZqgARxsf3S2Ar/0T+Q37IUxR+mNcX5oHY
         7uIA==
X-Forwarded-Encrypted: i=1; AJvYcCU058G15rZ3X70XbfNqyiA9+hDSQpRlhYE0GvRRhSaOFRtEVGQbtbrPtD29XRWo6VKRrHrGPoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXMHxsppE6DY8mrPvRHyzNev1ctDOMA1M2sa9vRgG66LqeRjeA
	8fU7slQgaCQauBN5/6Pxt390qVx02SAThFXMg/LkhNtPRefNL4NktVDG7asDib8=
X-Google-Smtp-Source: AGHT+IEZ6J2w8U62gC+m+8rB9mJkk7F6Y/9g2nTY0WJfkMv8EwABuhHpl3lj0h7DTiCw+LecXrTl/g==
X-Received: by 2002:a05:6402:5191:b0:5cb:78b8:7056 with SMTP id 4fb4d7f45d1cf-5cbbfa9b3fbmr7045227a12.33.1730202391375;
        Tue, 29 Oct 2024 04:46:31 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.41.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6297a09sm3869301a12.21.2024.10.29.04.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:46:31 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [RFC PATCH v3 2/6] can: flexcan: use can_update_bus_error_stats()
Date: Tue, 29 Oct 2024 12:45:26 +0100
Message-ID: <20241029114622.2989827-3-dario.binacchi@amarulasolutions.com>
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


