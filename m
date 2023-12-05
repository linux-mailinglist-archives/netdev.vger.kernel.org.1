Return-Path: <netdev+bounces-54005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B5A805970
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1649C28200A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE1263DD6;
	Tue,  5 Dec 2023 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="yV1OApyu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D13C196
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 08:04:33 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso2748120e87.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 08:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701792272; x=1702397072; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3HWf8UZr/aVLzQNJuoG/ipc31/we63ShxAutS/dB38g=;
        b=yV1OApyuxZrHunAxr017uzu1megUJfhtG4JHxwFlBujl4Si1wDDK7M55N+/QagiSMc
         gI9YU0NYe+k5T7tE6r+DxYQB3J6Jgqc/vR+a4YfZ4JOIlwR3vBH85ZeJc+0j4MCsF9/E
         +edEcn3p6gtXXtqHJG/VERTMWiw+Lx1ExoWxHNTI/0yGtwo/slocCGxH9ACXg/c9ZcIP
         6vxbPiLgcdm21SyKqIHzwZg6u0ZwpVAYO84scGaZU5Zj7disNnvWNI1PhCBAT43cSuaU
         Lx7Rqqt5oL+KapuTfzv5dO9nEMxEmuZdKZJ2KgPY6VbB6qg3+/yGFgYQ5+fSTSGhdbTy
         J/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792272; x=1702397072;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3HWf8UZr/aVLzQNJuoG/ipc31/we63ShxAutS/dB38g=;
        b=JQFxvyCCVxIpXOF/wYCnbxeJOkqYVgoZQu8ZhO9Em2FP4F7XuW7UONVXlYTpSJfd6A
         Cu+E1Rusg0qQLL0gXtuSfYBoVUcYqgAPUe41hBhmqRRSDlbDH8HGpv/y+UOn1h8cRCr2
         5dI5+nA79mGok6csIhOJBwcMDET70Wz2ExFS2Myn363TP0DTfrznh1a/vBFuTFf3qERP
         PoT6pS6H83sM9szZ3Aynp+DxQGd/env2ngMS4Pix64VS/V/rFAkMt50j0IvpbnSgtck6
         NCGOQELIlpncX7L1nRUfeVCqhN1rczVhzn42CtAzauf/6AJg86llRTrle4mRZ7QZPzSk
         5wZQ==
X-Gm-Message-State: AOJu0YwVQN+D1/HC7GmAPV+ojlseZMl37RLKXMECPnZn7yVa+5vmM1fX
	YXItAiA2FTXexpA8tC+z4aXmDw==
X-Google-Smtp-Source: AGHT+IE+l0gQsJA0G3jNdsFcdepiBA4aTBM0PfLz7QPcDRhFbhBYIBJxn9wFekRD2UYZVbOAlQ27wA==
X-Received: by 2002:ac2:5f43:0:b0:50b:c147:4ac with SMTP id 3-20020ac25f43000000b0050bc14704acmr2918963lfz.66.1701792271768;
        Tue, 05 Dec 2023 08:04:31 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h25-20020a056512055900b0050c0bbbe3d2sm171341lfl.256.2023.12.05.08.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:04:30 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 3/6] net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path
Date: Tue,  5 Dec 2023 17:04:15 +0100
Message-Id: <20231205160418.3770042-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205160418.3770042-1-tobias@waldekranz.com>
References: <20231205160418.3770042-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

mv88e6xxx_get_stats, which collects stats from various sources,
expects all callees to return the number of stats read. If an error
occurs, 0 should be returned.

Prevent future mishaps of this kind by updating the return type to
reflect this contract.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.h   |  4 ++--
 drivers/net/dsa/mv88e6xxx/serdes.c | 10 +++++-----
 drivers/net/dsa/mv88e6xxx/serdes.h |  8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index c3c53ef543e5..85eb293381a7 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -613,8 +613,8 @@ struct mv88e6xxx_ops {
 	int (*serdes_get_sset_count)(struct mv88e6xxx_chip *chip, int port);
 	int (*serdes_get_strings)(struct mv88e6xxx_chip *chip,  int port,
 				  uint8_t *data);
-	int (*serdes_get_stats)(struct mv88e6xxx_chip *chip,  int port,
-				uint64_t *data);
+	size_t (*serdes_get_stats)(struct mv88e6xxx_chip *chip, int port,
+				   uint64_t *data);
 
 	/* SERDES registers for ethtool */
 	int (*serdes_get_regs_len)(struct mv88e6xxx_chip *chip,  int port);
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 3b4b42651fa3..01ea53940786 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -177,8 +177,8 @@ static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip,
 	return val;
 }
 
-int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data)
+size_t mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data)
 {
 	struct mv88e6xxx_port *mv88e6xxx_port = &chip->ports[port];
 	struct mv88e6352_serdes_hw_stat *stat;
@@ -187,7 +187,7 @@ int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
 
 	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
 	if (err <= 0)
-		return err;
+		return 0;
 
 	BUILD_BUG_ON(ARRAY_SIZE(mv88e6352_serdes_hw_stats) >
 		     ARRAY_SIZE(mv88e6xxx_port->serdes_stats));
@@ -429,8 +429,8 @@ static uint64_t mv88e6390_serdes_get_stat(struct mv88e6xxx_chip *chip, int lane,
 	return reg[0] | ((u64)reg[1] << 16) | ((u64)reg[2] << 32);
 }
 
-int mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data)
+size_t mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data)
 {
 	struct mv88e6390_serdes_hw_stat *stat;
 	int lane;
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index aac95cab46e3..ff5c3ab31e15 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -127,13 +127,13 @@ unsigned int mv88e6390_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
 int mv88e6352_serdes_get_sset_count(struct mv88e6xxx_chip *chip, int port);
 int mv88e6352_serdes_get_strings(struct mv88e6xxx_chip *chip,
 				 int port, uint8_t *data);
-int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data);
+size_t mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data);
 int mv88e6390_serdes_get_sset_count(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_serdes_get_strings(struct mv88e6xxx_chip *chip,
 				 int port, uint8_t *data);
-int mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data);
+size_t mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data);
 
 int mv88e6352_serdes_get_regs_len(struct mv88e6xxx_chip *chip, int port);
 void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p);
-- 
2.34.1


