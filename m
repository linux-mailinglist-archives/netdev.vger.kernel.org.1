Return-Path: <netdev+bounces-57466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D94813229
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65171F21373
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D559B59;
	Thu, 14 Dec 2023 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="MGu/9zaY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E58124
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:51 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso113177911fa.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702561850; x=1703166650; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6K9/ftBYWBy7RW0nipjB9A3FGsMp92lHEjrhCFhEnz4=;
        b=MGu/9zaYLE3e95fJvlrRKeiJRkIHcX1LhjTGq5fBEHVyMqtAym+WDTFrXIMDfoFpwt
         I+GmkLnGG3jQV5VQKVtF/he2ocW6n/hDGYtkorh63oqM3Qa+cYX525A72duCULttHMys
         G+fbsHxvpJB1uzuHQ8YQdyKcfTkA+5zED03npMsc2foK6IMubC9BpIw7XDMz7UTcAjJD
         f1zhO0L86WN+SWxAbkBAhnWxhyH4kyD/gm4iPnRkC74s/WDPu9Aa1PUX/jQqCJV+iarQ
         CvuJ78o2O4YWl2s2HRS3XR+A7FUH8XHCtTKje8/4kmOTMydDHsLK+6eNDssLej4Ac3Nr
         5rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561850; x=1703166650;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6K9/ftBYWBy7RW0nipjB9A3FGsMp92lHEjrhCFhEnz4=;
        b=XviyXWXgSaxGmZ8NyXxzh7DEIC/n5+KS1hav7NQLEWgmqqJkTNBDPvGxXQDciRoZD7
         OwcAdguvMtD44mmSiGi0H6RTSh0xkgwCOvWYMNaV12nk/8CDeINf0WnTlquydC6Mvj4/
         EIIAXLzPLsQbhGARNOYCOo7aEyWv7DbzG7n5Mr+xLwFIVOj0wHXVMOqjPOt3GJinjYE/
         L13kKwUfLFvoKMRcmz+96+REXzON6whmTuUf0iMd9Cf7KOHv2FKGcDDEA2SiIhKzL0O3
         JcdnXPPZjAfCZaYyPGQJP+NKbWsEM65Lcq49eduz7BbTNu9lUyMLjmp0jFqXbJWxI9OR
         fdEg==
X-Gm-Message-State: AOJu0Yy2PRwyXdYwpgPDP54SyWuFRqvo8ObRehda+Ebxva4mOfTxwCNv
	H+DvXRRYHAWhxD8SeJmmP8O9UQ==
X-Google-Smtp-Source: AGHT+IFYiWwLA3Llwq5oK0wvJk9doffMI97ng2QyPulFxY/DNkKiXLwzv5OVDgrcnPYA+h6xm1V2TA==
X-Received: by 2002:a2e:a453:0:b0:2cc:4262:75a4 with SMTP id v19-20020a2ea453000000b002cc426275a4mr450446ljn.11.1702561850107;
        Thu, 14 Dec 2023 05:50:50 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h4-20020a2ebc84000000b002cc258b5491sm1154010ljf.10.2023.12.14.05.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:49 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v4 net-next 3/8] net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path
Date: Thu, 14 Dec 2023 14:50:24 +0100
Message-Id: <20231214135029.383595-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135029.383595-1-tobias@waldekranz.com>
References: <20231214135029.383595-1-tobias@waldekranz.com>
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

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
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


