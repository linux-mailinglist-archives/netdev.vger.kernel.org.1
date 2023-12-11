Return-Path: <netdev+bounces-56115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146C980DE51
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971E3281EA1
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1752156440;
	Mon, 11 Dec 2023 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="BOBxV3ZP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA1EB5
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:34:02 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bee606265so5267441e87.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702334041; x=1702938841; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4hvxzKDJ8QbQArywA+MZ8TU5wFdrPBaAt6cc8b4tZns=;
        b=BOBxV3ZPXn+/q9wD/xMj5I3onY68m1Lb6IBb9/429Dh3ohOjYGkk+Jf1iW2ADxussT
         XxJMD3CgdZwnTqH0F1fBRqb+Kvl23p9az4rjWB+z+YJDZWvWKvexVa6IuSZL5B0pXib1
         DieGIVbLCh3GcVys9c+SEkuyrZMAzJSV/NdXYmFSW+RmeeyqkpsGIQOwkrmJ5xAGzLAz
         Q2oIMN1tHCl4jItKfb915TUbqbzciRX6i1zsMob5PjwkWv4Q8Q8vnIQTTKydt6QW6exB
         GjvjBobRS6yss2l2XTUcQlXRR6FYcrUkJskKG/oBm5lK5g0vkJNvP71zB5mIG7psdzey
         EAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702334041; x=1702938841;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4hvxzKDJ8QbQArywA+MZ8TU5wFdrPBaAt6cc8b4tZns=;
        b=FD3/vy1zpM5TlpdHNr/5s6u0OB+YZm6w9PycrZ2mCMLagGNTLXkO3hStEisyGg4Sqq
         dyKV7DeWP5RE0hIiKTjPWX6nhD/iawG9tYQh6UwnjUCdcUzTEwEOnTod4Wf6ft2pBpLJ
         jEbKw2TRpl0mMFPgmt9XehHRJEpIfIMCgPi3Rzujj7AcHHNZysMDLFff7WjRIxVzhJNV
         wrHF/I5NzxkVY9b9I5sM8FKgQbBLrhn5ss4AM25zIw1uY2T91jiJnl/fmhn+XSoNWadS
         fx7bv/xe+gOrNOsuOCUMkoqYjJKmOZqrxZGcC24STosoh38jcLYeaTWUb0DYvqnqoxzY
         WuCg==
X-Gm-Message-State: AOJu0YzIOO+noT/pTAbB5RgTCT3VFCyEaDoE8qTOU1wbAXlg1yFqFLus
	z72+seZYjpf5e5hN3iWZJJkR+TBujAtEihEd8XQ=
X-Google-Smtp-Source: AGHT+IEk3NzH/keTcUvDCI/tDBGucnXaSx3fOUnZ5nUFxlqgYXNGgzlAExnFp33M83sW8XBpxX7+0w==
X-Received: by 2002:a05:6512:1312:b0:50b:f6a8:c776 with SMTP id x18-20020a056512131200b0050bf6a8c776mr2369109lfu.62.1702334041221;
        Mon, 11 Dec 2023 14:34:01 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651232d100b0050bfc6dbb8asm1217649lfg.302.2023.12.11.14.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:34:00 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v3 net-next 3/8] net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path
Date: Mon, 11 Dec 2023 23:33:41 +0100
Message-Id: <20231211223346.2497157-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211223346.2497157-1-tobias@waldekranz.com>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
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


