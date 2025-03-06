Return-Path: <netdev+bounces-172562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FAAA556A7
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988933B3FF0
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F1827933E;
	Thu,  6 Mar 2025 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ3oseEX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981327817F;
	Thu,  6 Mar 2025 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289261; cv=none; b=CVgyh2ziQTHcqTV9aYF3E4OLsTYMtWtkdwmNTrifOzpuBILjzid439sRa6T7oN73dYiqU70Qpy603D6N3qBt6xYqTPUMedn3CgjJd5SP5mUiUPz29ZqxpVG+NfNNKaKqQYD/pDbI1sbgVh7TzAylh06a10GykiG8rVBXE67U8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289261; c=relaxed/simple;
	bh=Cm6vDyUbIrIQxat63MdKJ7WZRrhzlrOMj14ySEYOLYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A9y5RDjpXYMwiHydiwDzbd7BRfQeJtuZ8aWvDi4LZoRlSJdFpUS+IyH0Anep7Nm8G0fqH3V8ysUF+wRFJCx9ArCA24WjxbkqPhk0qpJIWGAbG8N2aYDYBgMr0kFNSImRS8tOCpdYgGscoRb6aiccZ9LViYdkPSrbkv6W6m9ZN9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ3oseEX; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f546cbf71cso582137b6e.0;
        Thu, 06 Mar 2025 11:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289258; x=1741894058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULS7Fd+mRkc1O4hEOntwhPuCIIRXdsFwT4SYy2nMfAg=;
        b=kZ3oseEXuPqujXsxT4zQ56MAsiPOUewPwNPvQTQ7SlPIkTvcDTKm7sVkh2Eff+dolo
         CZO/xJEV8k3fmm3Fihh1vrMOEs8HkH+NvWS9rNv3/ewEwfPYLL4tMsKXHOH6wSDksf29
         xEup+kVfHiTaeVLKrc50ZHfO6IR8FOOMECxI7AgN0gbqneIGU4E8yRIsLhJZ/Z2MFK/4
         qvB7uIH5yvf8JZNJe5yALDe9usErbHE5BLKVVzNzPcca+B9Rlubl77P9tUcA4j/zV1Qh
         hfPqJt1WBY2ZB9bEYBEaaQu1GtZlqmWCzQSAyUwec3CSMKUqeMwya2Cd4XPgItcIllHh
         2UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289258; x=1741894058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULS7Fd+mRkc1O4hEOntwhPuCIIRXdsFwT4SYy2nMfAg=;
        b=IFwkHTXPr/L2O+zVrYzv34HC+Imaq9fLwfvjjlbHgSztIR54Ilv6P2aLgewS58CLKL
         P44p0dZl5o0Iy6KOT6uc3dTZ9s4QuRLgVw7GnXRhi3CLvlOdgd+0vu1h6G2Hd4095buL
         GVsjAG8uzaoM1Pk3/8Kt2UHxpOtviCMlLTsnioIE1kEwlpKor3ykHL6rxDjtz5Y9pDFL
         GjIv6RdaZBk2mT7BW5bs52m7HoN3WHCAf6JFVXMWXw/f5o5tmXQFbLQN9wyCb0Lk1clA
         M9NuUN0GkPsToCblaHeQMpWoZ2OA8PEiQ/BGzWHRXC3avEYlta2vyJxhlTj0jiuGgqSE
         P1Qw==
X-Forwarded-Encrypted: i=1; AJvYcCW/pRH3/sbuU/6p//w7WVTR42yDGN6FZrXnAiT8kr/Pm36EBMxLIUO9Dumr4cWjwnDSUS8K4Y+h@vger.kernel.org, AJvYcCXysGgG8AHfSOMfiZeOx7FKh5qhl0OAmVnAtbausVtsFZE2igNtQOP5RCrONbaJBPSDWHscdL+R1+5JDz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Cu/hM7zArf2sK81sdzJ9jmXKFzt/TngDpwGBFkS98cmOeHs8
	/n/E+0eDhubZhYAsvj0AKWjpl4ssQOVV6Usqnha+0euip3MAkzuP1/EcBA==
X-Gm-Gg: ASbGncvw0OxjoeqZcyN2jThJOHzqe7k5yA+KpGeAw8yaanFiuYHbsgM8HvXw2D0HFg2
	9AGHUi9gbI0W2zGX5hGBrHshPHn9+SNOXVYrdYy5cxV11chnIw9gndOkjMbdMc9RDNGYzd0EK1U
	+is7U47aE89wdaN9vJ97Nn6ZcHtaZN6jIebyZtRl7RDoWg14AAjfCbQFhIW9AQFLbMnGkvFmupq
	Vme9y9MukYcvBpZuJATfnOZpune5wnvkWawjb+NMrAdJvdhQUL00iwB4vZR4U+hAX2ywWCYmxX+
	ItXH3/q7JJAGV2P4UdLtXrNtl6KFeo7M0W9TrEz3QWzJrZWe1b684Qx73aIoVTylnz9H/YTtGUy
	IZkpzCFucN/Xn
X-Google-Smtp-Source: AGHT+IFvgnOmILvFKHnH8JqHLGeAQSPz8LbYx1PSwc+/4ej8LxCkVZZs39j2tc7OgMxg4YaV7oK63A==
X-Received: by 2002:a05:6808:130e:b0:3f6:787d:69f5 with SMTP id 5614622812f47-3f697b61ac4mr460283b6e.23.1741289258507;
        Thu, 06 Mar 2025 11:27:38 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:37 -0800 (PST)
From: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next 07/14] net: bcmgenet: add support for RX_CLS_FLOW_DISC
Date: Thu,  6 Mar 2025 11:26:35 -0800
Message-Id: <20250306192643.2383632-8-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306192643.2383632-1-opendmb@gmail.com>
References: <20250306192643.2383632-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the DESC_INDEX ring descriptor is no longer used we can
enable hardware discarding of flows by routing them to a queue
that is not enabled.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 356d100b729d..ea575e5ae499 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -599,7 +599,7 @@ static void bcmgenet_hfb_create_rxnfc_filter(struct bcmgenet_priv *priv,
 					     struct bcmgenet_rxnfc_rule *rule)
 {
 	struct ethtool_rx_flow_spec *fs = &rule->fs;
-	u32 offset = 0, f_length = 0, f;
+	u32 offset = 0, f_length = 0, f, q;
 	u8 val_8, mask_8;
 	__be16 val_16;
 	u16 mask_16;
@@ -688,11 +688,13 @@ static void bcmgenet_hfb_create_rxnfc_filter(struct bcmgenet_priv *priv,
 
 	bcmgenet_hfb_set_filter_length(priv, f, 2 * f_length);
 	if (fs->ring_cookie == RX_CLS_FLOW_WAKE)
-		bcmgenet_hfb_set_filter_rx_queue_mapping(priv, f, 0);
+		q = 0;
+	else if (fs->ring_cookie == RX_CLS_FLOW_DISC)
+		q = priv->hw_params->rx_queues + 1;
 	else
 		/* Other Rx rings are direct mapped here */
-		bcmgenet_hfb_set_filter_rx_queue_mapping(priv, f,
-							 fs->ring_cookie);
+		q = fs->ring_cookie;
+	bcmgenet_hfb_set_filter_rx_queue_mapping(priv, f, q);
 	bcmgenet_hfb_enable_filter(priv, f);
 	rule->state = BCMGENET_RXNFC_STATE_ENABLED;
 }
@@ -1444,7 +1446,8 @@ static int bcmgenet_insert_flow(struct net_device *dev,
 	}
 
 	if (cmd->fs.ring_cookie > priv->hw_params->rx_queues &&
-	    cmd->fs.ring_cookie != RX_CLS_FLOW_WAKE) {
+	    cmd->fs.ring_cookie != RX_CLS_FLOW_WAKE &&
+	    cmd->fs.ring_cookie != RX_CLS_FLOW_DISC) {
 		netdev_err(dev, "rxnfc: Unsupported action (%llu)\n",
 			   cmd->fs.ring_cookie);
 		return -EINVAL;
-- 
2.34.1


