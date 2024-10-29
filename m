Return-Path: <netdev+bounces-139889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A769B4899
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005541F2381B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B040F206E6D;
	Tue, 29 Oct 2024 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qevd+j0V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83568206953
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202402; cv=none; b=u9tPEinvxcnmHmjc49/yZYlBeMycLtR754kw1xY/TbG3iu+agj8xnahH2rFM1V64kOKPAW4cpbu8AWHeCMoWQDfyNGy0RWx++MiEaSSgPCI2anmXpmcDslbfxiyBrnExQef2l6UV6IrXySwOzAvPrme8tib/QqXBnlxIJCAMZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202402; c=relaxed/simple;
	bh=zGQNeCdJfkEacQEWhKkyV5Ry31CnGCgUtEGDHPY8Ta4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaObVe1ReM3UWQdTnH3J5ex0OAHxyzjM5PsGnfcSsY7Q2UHayiSFk9a7Eq5RS8pgTZytUtWRWdtboBftg/oOO3PnwquhWeNTkYTlqIywad5ZOWIt6e7EY5VkohpfcnrmY0MUxb70ApNslegFJEXKF69JePfKJ9FVDrtzial9Sb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=qevd+j0V; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so7624877a12.1
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 04:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730202399; x=1730807199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7zf1SxmTLYYJKdIBWggPPFkkyvCdLLyYv8BJT477vU=;
        b=qevd+j0VfLZCBEtrY68CFWvqnI32U6jQGkuFLKhVohrN3u084HFOk7u3latWqJPE9p
         fktwG9TBisZm1INugFL94ydvswjdNbATutcprpDWO1Y56BqNpn438CDkFXonvqxV5Bua
         r8spWVhzbICqRQ5hxfZYo1S/f/+P/6gduESLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202399; x=1730807199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7zf1SxmTLYYJKdIBWggPPFkkyvCdLLyYv8BJT477vU=;
        b=rpiwklYmt9ES9sPEq8A/5Akb/3z1OfPEplzgCEqGFqq5num4CMS2BfsZzJFskSjF3N
         InGqAk9P0jq7l033GZzkPcXFldcLhn6A7s1N8aodUQYOfpegYUgB2QI4iTLnFrBAqi+J
         e2VphrGTgH2FFLSazFFT6XbeiKoCJuxk3qCY/AVlNqi+vumyHwocrPOSmvtE9CuENMs/
         n9h2LficDyoZrc/9yghrn0j10teDnIUhxnh5133xwLU+jCxW3Qenza3KxRaEJveUBC7r
         NTMRM7wMRliXhwyGQ+KTAYPyXJw3Lk9DUhx1MOY4IsIMHHl1m4uuvlw/cNx5fVUsXvUV
         PXpA==
X-Forwarded-Encrypted: i=1; AJvYcCV6S+aPqDgTPrW3eEOlcWSSu5Pq8HQJOCuTyiiCnRJ7DTANH+NMK+SQlqx3UHXUCD4XL5oEoa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qN2amwRFFqBXhFph+tHdYlvA2xeE1xVpwFBa9W0Bd34IYzao
	euM15WN4/gIGOmx3ahFc3IaNQD66hmWVJ+NoR7wt3VA16G71sGvr9bkIphugik4=
X-Google-Smtp-Source: AGHT+IFQPjRGEu5AzAkALhjbGjgLzCygsqqvVu/v3wZnXp+FNxqihXgz0zlaCUYVkgQ0pA+esg6IPw==
X-Received: by 2002:a05:6402:40d5:b0:5c9:4022:872d with SMTP id 4fb4d7f45d1cf-5cbbfa66f3dmr9918447a12.32.1730202398864;
        Tue, 29 Oct 2024 04:46:38 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.41.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6297a09sm3869301a12.21.2024.10.29.04.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:46:38 -0700 (PDT)
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
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v3 6/6] can: dev: update the error types stats (ack, CRC, form, ...)
Date: Tue, 29 Oct 2024 12:45:30 +0100
Message-ID: <20241029114622.2989827-7-dario.binacchi@amarulasolutions.com>
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

The patch modifies can_update_bus_error_stats() by also updating the
counters related to the types of CAN errors.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v1)

 drivers/net/can/dev/dev.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 4ad0698b0a74..ed2bdc6fe4a1 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -27,16 +27,31 @@ void can_update_bus_error_stats(struct net_device *dev, struct can_frame *cf)
 	priv = netdev_priv(dev);
 	priv->can_stats.bus_error++;
 
-	if ((cf->can_id & CAN_ERR_ACK) && cf->data[3] == CAN_ERR_PROT_LOC_ACK)
+	if ((cf->can_id & CAN_ERR_ACK) && cf->data[3] == CAN_ERR_PROT_LOC_ACK) {
+		priv->can_stats.ack_error++;
 		tx_errors = true;
-	else if (cf->data[2] & (CAN_ERR_PROT_BIT1 | CAN_ERR_PROT_BIT0))
+	}
+
+	if (cf->data[2] & (CAN_ERR_PROT_BIT1 | CAN_ERR_PROT_BIT0)) {
+		priv->can_stats.bit_error++;
 		tx_errors = true;
+	}
 
-	if (cf->data[2] & (CAN_ERR_PROT_FORM | CAN_ERR_PROT_STUFF))
+	if (cf->data[2] & CAN_ERR_PROT_FORM) {
+		priv->can_stats.form_error++;
 		rx_errors = true;
-	else if ((cf->data[2] & CAN_ERR_PROT_BIT) &&
-		 (cf->data[3] == CAN_ERR_PROT_LOC_CRC_SEQ))
+	}
+
+	if (cf->data[2] & CAN_ERR_PROT_STUFF) {
+		priv->can_stats.stuff_error++;
 		rx_errors = true;
+	}
+
+	if ((cf->data[2] & CAN_ERR_PROT_BIT) &&
+	    cf->data[3] == CAN_ERR_PROT_LOC_CRC_SEQ) {
+		priv->can_stats.crc_error++;
+		rx_errors = true;
+	}
 
 	if (rx_errors)
 		dev->stats.rx_errors++;
-- 
2.43.0


