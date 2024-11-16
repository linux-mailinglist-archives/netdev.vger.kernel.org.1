Return-Path: <netdev+bounces-145596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3341B9D005A
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 19:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E685D2875E8
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA21BC9F3;
	Sat, 16 Nov 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="M/o9Or9q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5421B85E3
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780202; cv=none; b=mAF0hjlLLVpLRIjEGpdoXb0Rer2pKhtS3wGfzBKpuz4WG6JOUJW7dL5NW50E7ZKdgsg/LlJAS257T3IZC62mvXnjLmrRh9MKASKM4a3ngF+H+l6Uugc3qC4LMlIlJQgKeH2MuyOlFcYt4HfG5zrR922QpB/BA3NstgSyQFb3nAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780202; c=relaxed/simple;
	bh=nrpSX80iZEgD1tyuub9lydq0DIRCuLzTN3EI9VOm5RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVFQKCCVtNcKzuuu/cWCIUSunz5TZQsdQY+GGj0h+j8TGWSoSPvs6KyZsZur7ttpyszWr3DhhqWBkfCvKBJ2ffGv7R0EBa1EEkkBM4j1gmApL3CvVh9HXWeYPVgLwrD+PJ17XntySYWA0Eamhby47ptN75J5NaeC3DQZH2KgJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=M/o9Or9q; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d495d217bso703957f8f.0
        for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 10:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1731780199; x=1732384999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzqc0qf43o4g73YzOl/3Mk2ZcRlSoSU0wYKvIRYgWeY=;
        b=M/o9Or9qDKQO6Miry9Q2iBYlM2DRWw4iWxL35GLPW+3oyJe99RrGwrcCcPLoO1XQtd
         8SumikWdm0I/2B1NJc+EQODXwn9UC3hbItUiDFsnjNMrMKFPlKHbT+dVgNcsQg7ytnPF
         dgudLLpLriV8soznxDZ9UYOUlg43oMldjBi2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731780199; x=1732384999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzqc0qf43o4g73YzOl/3Mk2ZcRlSoSU0wYKvIRYgWeY=;
        b=s4dXNNSbyEMxRuzSWezM3IWGQMzwFQzJOg0kr9iFhXM8Q2LIrAkEmiIaR2pI+dYyMO
         Gahegp9koQTJcEeSXOdkIU3QqouNrNJ95JLntZfKI1+pmRiDJzY75Mv/XxptE/5/9LZa
         ygflNNT62OkSl018z7c7/QovN34XTNdQzovcQ2U+MMnFmV2kyoLrlQvJ3PghL80UW/SO
         NgDrA7xuXSTipU3hTk+F0s3PJ9UcjsYS5Y6jJDu6MvV1KNq4EFvNao3iSbsYQl+FZdnw
         MF4Fj3SbVbEkmN+nJ5PHNcnu8hy1EC5gY7qu5JPkfO7ED1JXjt53Oj0d3cQCqv15BZQN
         UDXw==
X-Forwarded-Encrypted: i=1; AJvYcCWfd3CGaFQtkvscgJybZuwhHM1pa/fM7VaxzfQtbq5bUqEZe6LdOMjMsqeVMhpW+4+vM/1i7to=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hozG6RBGFUgzW+WwkwB36aDl2qbuMm3jEiRjhSzsZtgHU3Io
	lnKmjAOJVctLhPSlXAGXSp+5Wf5hNJO90ookiJfEjBIQJFjqjPDx2ZGtVzMTT/A=
X-Google-Smtp-Source: AGHT+IGkyP3qGN+tINbIZ4XNnyhPqXqEDpgjVb/byBCp6YrVMvdl+zOjNIxpY2yrRpZDbbYKagylow==
X-Received: by 2002:a05:6000:4213:b0:37d:5042:c8de with SMTP id ffacd0b85a97d-38225a45297mr6503959f8f.22.1731780199189;
        Sat, 16 Nov 2024 10:03:19 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dc6d364sm329549066b.0.2024.11.16.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:03:18 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Haas <haas@ems-wuensche.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 6/7] can: ems_usb: fix {rx,tx}_errors statistics
Date: Sat, 16 Nov 2024 19:02:35 +0100
Message-ID: <20241116180301.3935879-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241116180301.3935879-1-dario.binacchi@amarulasolutions.com>
References: <20241116180301.3935879-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ems_usb_rx_err() function only incremented the receive error counter
and never the transmit error counter, even if the ECC_DIR flag reported
that an error had occurred during transmission. The patch increments the
receive/transmit error counter based on the value of the ECC_DIR flag.

Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/usb/ems_usb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 050c0b49938a..98a70a2fe189 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -361,7 +361,6 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 
 		/* bus error interrupt */
 		dev->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
 		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
@@ -381,8 +380,12 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 		}
 
 		/* Error occurred during transmission? */
-		if ((ecc & SJA1000_ECC_DIR) == 0)
+		if ((ecc & SJA1000_ECC_DIR) == 0) {
 			cf->data[2] |= CAN_ERR_PROT_TX;
+			stats->tx_errors++;
+		} else {
+			stats->rx_errors++;
+		}
 
 		if (dev->can.state == CAN_STATE_ERROR_WARNING ||
 		    dev->can.state == CAN_STATE_ERROR_PASSIVE) {
-- 
2.43.0


