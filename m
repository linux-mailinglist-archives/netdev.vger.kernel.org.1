Return-Path: <netdev+bounces-57385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43608812FC6
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA031F221BA
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD641774;
	Thu, 14 Dec 2023 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zkap/NQq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252DD10A;
	Thu, 14 Dec 2023 04:10:50 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-33646d24c1bso484491f8f.2;
        Thu, 14 Dec 2023 04:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702555848; x=1703160648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TzgD0Qs2BVpmH7f8GdD/KOxE3BnUuO973WRXZk0Mqc=;
        b=Zkap/NQqA2Pemj3D9+t1PkWi5X4YZuLDaxp4yruSTFa+0ugT2GHjyKKTdSUnIkW5v/
         vk3NlqXGI084ApBW37hETCF+MXUBvfmCnnKFh/Vvs9mnmeVmErYj0TBha5ISh83UO/wI
         VGROXr9MISihUqfOBVINN4Aq7SfrDtmB3nyztVlQtGejCamushuR2okGv+8gn/PtaHyH
         XybVfw11u67RsPu5U+7j/X5IZNwCKvvyim8GF6wY0TWWvrRgXkO2GcHB3lRLdqz1xnaz
         vobeWCFj+6rsjoHJB4hLCy6uYjT+yls7y8QjJfiwR5Hu/HNJKrKkIl2ptfbaT00sxoLB
         YYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702555848; x=1703160648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TzgD0Qs2BVpmH7f8GdD/KOxE3BnUuO973WRXZk0Mqc=;
        b=pnE7L3RXQqidn+inArpbllJ5VyzOLs0hvgkQ+pTn1SY4lZ8BBUN5hjNygPqbe9WVRG
         FzJGEmztft3PG+ed062e2ikA2ILelGS6VVHlvqnQV7MPmefdbmHWgTXvwnuAonXaztnh
         quTq/e86qElOvxgLhclAIRNJ2vsljur7gj1IEx+ZiFASkLqFhXuzyxnUJXZ6/QYsecDS
         iy1skCZKDnpg72if4fNcIclJnDEWJ753qe76HSROgLTBxP90aLE1/mc2i+dl6ZQBKiA5
         tg2yujxF28BUBepNwQEoeEaMf84jZTPzngEcI4mC/BY8Wg+TcInaC8uAKfSyf6UtvcOT
         97DQ==
X-Gm-Message-State: AOJu0YwRrUB4sGw0Ae7s0ljts53eTkbnvfzrgelsHbGTjxEXyqg4fRYc
	fM4Q6LWRe5nfNIFlbFS46/M=
X-Google-Smtp-Source: AGHT+IFlbtDyVGhid1ONroUF4/bPW2P7eO3cxUrEwDviy2M8WtDceFRi16tMWzEFJwChKMDmLsx1cw==
X-Received: by 2002:a5d:650d:0:b0:336:3db7:6e3e with SMTP id x13-20020a5d650d000000b003363db76e3emr1214199wru.96.1702555848265;
        Thu, 14 Dec 2023 04:10:48 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id d12-20020adfa40c000000b003333fa3d043sm16026765wra.12.2023.12.14.04.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:10:47 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Harini Katakam <harini.katakam@amd.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v7 1/4] net: phy: make addr type u8 in phy_package_shared struct
Date: Thu, 14 Dec 2023 13:10:23 +0100
Message-Id: <20231214121026.4340-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231214121026.4340-1-ansuelsmth@gmail.com>
References: <20231214121026.4340-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch addr type in phy_package_shared struct to u8.

The value is already checked to be non negative and to be less than
PHY_MAX_ADDR, hence u8 is better suited than using int.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v7:
- Add this patch

 include/linux/phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index e5f1f41e399c..e5e29fca4d17 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -338,7 +338,7 @@ struct mdio_bus_stats {
  * phy_package_leave().
  */
 struct phy_package_shared {
-	int addr;
+	u8 addr;
 	refcount_t refcnt;
 	unsigned long flags;
 	size_t priv_size;
-- 
2.40.1


