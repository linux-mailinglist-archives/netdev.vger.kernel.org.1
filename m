Return-Path: <netdev+bounces-111277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2270193076D
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 354BEB21747
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 21:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEE5176FB2;
	Sat, 13 Jul 2024 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoGhvt4U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0472C176AD3;
	Sat, 13 Jul 2024 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905424; cv=none; b=W3jZSYWC64WbsbDyNX+3TkS7h50363c5Tov1NwByy6rUG7c5XHi+0+jmUPIhaTE3aMWm5PDSmpuXXrOFNXpPrWT7J5NPlId3qFYQ9GD3Sjja84uBLFdyt5M2ZsAy4ZG2qkD5nUvMQmd6s92blu+txueEwBQPvgRJbiGEOWZe9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905424; c=relaxed/simple;
	bh=m7FqwOWk8eEAqPJZHwbnkEs7vnZSdt08NNMj6h5Kpvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W047q+vAgqKc8glCDBvhYvjgikeDBN7kcs86V+QcM4suyhJ73A5GKpNTAbZ+pPfYHWfkNA4AfpsdgDOa9EpO4a9n0tlVdVdU4JLI5PwDbvV9K4K2Yd9rDTVA9RUfZ9Csc0fjHaFXwXIm9Zw4myN7jbYPgohuthP6MZ5UFKewFd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoGhvt4U; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee9b098bd5so43369211fa.0;
        Sat, 13 Jul 2024 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720905421; x=1721510221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0Hoo54i+A9LS2Cr5Bq7orVNqLEp9rP4JoswbUONUqk=;
        b=JoGhvt4UzC0YcqegFCKdm69MIIPmp+tzLfVyKfeb3rsS8HfdKd98If9pcCQ3I/HKWQ
         aj+QfsIvoQ89IWWjZyKd0H581pMxpsFb4zY5Won4ayNm4su6Z4LNnOgi+0OF6NOA+VIX
         oKEFCv+1mFQWTuBV8dQF4bL3bv/eewf9AvthaqacLKLgXCejNmiChs9CSXsSKByiP3ry
         N5pY6yYRT8ZZ6cm47zYMVIaV8p3Ak1kKlqEbcmify0WPklfb1idC/H9PNtlFyhAde4iP
         qSQ3tFt0Gc1kiA2cKSuqQ2eqm255q0ED137VCDi5sXVXylUyASoKs1orylzjonrjMo4E
         MaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720905421; x=1721510221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0Hoo54i+A9LS2Cr5Bq7orVNqLEp9rP4JoswbUONUqk=;
        b=L98uBtaiX9Q8KgvmZrwxfnTqX9i2x9A/jhCBP0tWILPREOFgjAZKFpt6beHNusQAV9
         y6KJoSuV6Mu/UDGVlIqtbJqHWjfJKUE/3jtR12iu+QjrfzVglczOKrEt5qbvLhqpW0lU
         gjgM8lgHW/ntOYGau4yc9YaS228oLuDin6L+VCEp0dYuNTF8+Mdj+0e3jzWP5WvGB0Nd
         FJkivNsL5ChWvp/y/4fjgq85Ytv48QsBBC5dGjpQhfBTTusJy8kbS1a3oiKYwhQKm8OB
         hYkeItg3PPHJ1MWDt+PqE5u1WKM1qF2PUo7VZuZIRAuMTqpcCtAMIuHNF51kpgcua0fR
         dwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDolauUV/du8n2luMqTtihtyPBICV/X8uEAzqF3xQhZJJ6DJUzDt5fifwmjJRKIXwTz1Mn/IPy6XJwDxpsQaq278S2gsgY/9xH2f6v
X-Gm-Message-State: AOJu0YzK9g+kUUBRVPljU2YWCa4jnaWaQti0IIjRY4IEj/vJ9xRA/1aK
	DiD5mC7+ZSG2ERvdeEsjS/hSiPSgygf5OSBnhFWg/rGQWOaJVaU8VCn7VwGq
X-Google-Smtp-Source: AGHT+IGCu+S5zJUJQSLk7SO6iLL1TGrG9T4Am9UOVINrsGDOwzjdXhUbD/6umNCgTGG0/e50fz06Cg==
X-Received: by 2002:a2e:9b57:0:b0:2ec:4de9:7334 with SMTP id 38308e7fff4ca-2eeb30b9a2amr104753211fa.11.1720905420780;
        Sat, 13 Jul 2024 14:17:00 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253b6sm1187286a12.41.2024.07.13.14.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:17:00 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 09/12] net: dsa: Define max num of bridges in tag8021q implementation
Date: Sat, 13 Jul 2024 23:16:15 +0200
Message-Id: <20240713211620.1125910-10-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713211620.1125910-1-paweldembicki@gmail.com>
References: <20240713211620.1125910-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Max number of bridges in tag8021q implementation is strictly limited
by VBID size: 3 bits. But zero is reserved and only 7 values can be used.

This patch adds define which describe maximum possible value.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v4:
  - resend only
v3:
  - added 'Reviewed-by' only
v2, v1:
  - resend only
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8:
  - resend only
v7:
  - added 'Reviewed-by' only
v6:
  - resend only
v5:
  - added 'Reviewed-by' only
v4:
  - introduce patch
---
 drivers/net/dsa/sja1105/sja1105_main.c | 3 +--
 include/linux/dsa/8021q.h              | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index ee0fb1c343f1..0c55a29d7dd3 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3167,8 +3167,7 @@ static int sja1105_setup(struct dsa_switch *ds)
 	ds->vlan_filtering_is_global = true;
 	ds->untag_bridge_pvid = true;
 	ds->fdb_isolation = true;
-	/* tag_8021q has 3 bits for the VBID, and the value 0 is reserved */
-	ds->max_num_bridges = 7;
+	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
 
 	/* Advertise the 8 egress queues */
 	ds->num_tx_queues = SJA1105_NUM_TC;
diff --git a/include/linux/dsa/8021q.h b/include/linux/dsa/8021q.h
index f3664ee12170..1dda2a13b832 100644
--- a/include/linux/dsa/8021q.h
+++ b/include/linux/dsa/8021q.h
@@ -8,6 +8,11 @@
 #include <net/dsa.h>
 #include <linux/types.h>
 
+/* VBID is limited to three bits only and zero is reserved.
+ * Only 7 bridges can be enumerated.
+ */
+#define DSA_TAG_8021Q_MAX_NUM_BRIDGES	7
+
 int dsa_tag_8021q_register(struct dsa_switch *ds, __be16 proto);
 
 void dsa_tag_8021q_unregister(struct dsa_switch *ds);
-- 
2.34.1


