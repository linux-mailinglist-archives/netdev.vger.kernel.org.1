Return-Path: <netdev+bounces-108234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0B091E778
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C37E1C2173C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042F616F287;
	Mon,  1 Jul 2024 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ/zVUGj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3412516F0C2;
	Mon,  1 Jul 2024 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858562; cv=none; b=RyM8MnrZDdJrBPoN6RW+r+9FJ4oPGkWH6/x7s6nnjGo9HYFFEwGnvawMtpu0sKPMmJE+1AX04yUBqv6AxtE1fZ4VH3bALHZUAQPsmjXjWeNTnzAG3ahgNiX4nR/vfMNzS3owhWqRoY0qCv1/0RPkBD8Jb+cLsdTn4/eC0Dz2Ktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858562; c=relaxed/simple;
	bh=3oFUE1zeHpfsBTFCAx2oZwYC7/BONw4yDPqk1b6j+6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwbMjle7FWu7Sv8nTEudIuSMwEsny6yzEE8OEYhCna4TYjE8TknR+mhNOY3bKWZ+7re2+35jRvrJhx1SAwuLOMCz7KKBlazYChPSzFwCkGkKcsuWNnSVEPLMxByaHg7qZzxiEdVhftDkujwVbHGiTbvgJNvZqyEkDRL81XgwiqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ/zVUGj; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e7145c63cso3814163e87.0;
        Mon, 01 Jul 2024 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719858559; x=1720463359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ6aCZ+zqC/bzroX6nSJ0EOSQTXAboCcbqfSGo7u8OA=;
        b=KJ/zVUGj40qsClvltPTlY+DZBv6ysRNIJXeXafid7WSl/IVi9iDOwNME7wRA14OcVG
         xXJ83W4of+9k3ZusjiQQEKx+YoSQuWPezBOosWbzjGn18NjtqdqHRcoYDYFpZKrd3JAg
         oH40Jhm7xmiinTDSvHiWtd4IY4j8PO4iRAoM6Kus/4tuPCh7Pgf//lz8Ldxjjk/weTRS
         kOaY4ZNxdoE9g9FrQrnBlw+q8lNEvwwfQeULjNPQekVF7EjO4fGVKA0ao9F0u+LuohdC
         GcqcolmMNKdj8+tuUB9bhKwZLcJrP/EeEsY0/2tuo48ZNOFRv45pv0OEWpEGjpkcXfhi
         fLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858559; x=1720463359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJ6aCZ+zqC/bzroX6nSJ0EOSQTXAboCcbqfSGo7u8OA=;
        b=REkrobv29l7YN47bWPGKOtzhXfur1KYrVOUZYHo5iCANHzlBmiP3vBsa3PcFdW5cmh
         ufOrHd0MxTVVU8ht8jfV66moZhm1IkzeI+nE+O3jWJJMMbENtVui+mtFnd5I5oA8CDOt
         BN+XHxQEu8K//WPIG5GG/Eii87pxOaAty7WNBOuWZ2PSGrri8j8yxsjsbdJ0yxaghj1i
         2+qyeCJBuQHeXJVbisOdm0ffY3/wE8goixDbPTN6vqsgOySV3MF352f2wBvGkXMYTLke
         cCF9AXnsAzYkvsdtIl+HRAIqanVVWsO80T+ZI7xtNYcw6Ch0QS6m2kZcjIE44qgvJHh5
         tj0A==
X-Forwarded-Encrypted: i=1; AJvYcCWvHY2UpH+G8rvQPtZh3aBG3IEpjTeUbDIHGHHerRT+FRcP5YQZkpy0CjladMKKb5KqxMV0TBsgNnkzTVdqRM/uFr9LCn2AiOJ8r7aDIw5y3HJEKnRtsuh4ozLaIkXgyZVzgQXR19QUuDQH+d+JuLGqoMTNT2NHk0Go35IBBwD4Xw==
X-Gm-Message-State: AOJu0Yw0JB1x1MZUZ9klYyyb6ZmU4hr0DRu96xvccoYibJJvRJWFtCq2
	OnD3hdQVOBkq6qCUh8P2iO7dc1zVGZL9dabAre6/C1Qjh2nIzyWy
X-Google-Smtp-Source: AGHT+IFLXQ1G/8tFNvYxI7EXzXU18ZbNW2pwP6myGFGGsl8sAi9kR+tdHtHLzDyd4+qqc+EqkLVjkw==
X-Received: by 2002:a05:6512:3d88:b0:52c:89b3:6d74 with SMTP id 2adb3069b0e04-52e7b8df4c4mr3115552e87.6.1719858557253;
        Mon, 01 Jul 2024 11:29:17 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab0b809sm1528753e87.37.2024.07.01.11.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:29:16 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 01/10] net: pcs: xpcs: Move native device ID macro to linux/pcs/pcs-xpcs.h
Date: Mon,  1 Jul 2024 21:28:32 +0300
Message-ID: <20240701182900.13402-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701182900.13402-1-fancer.lancer@gmail.com>
References: <20240701182900.13402-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the next commits will alter the DW XPCS driver to support setting a
custom device ID for the particular MDIO-device detected on the platform.
The generic DW XPCS ID can be used as a custom ID as well in case if the
DW XPCS-device was erroneously synthesized with no or some undefined ID.
In addition to that having all supported DW XPCS device IDs defined in a
single place will improve the code maintainability and readability.

Note while at it rename the macros to being shorter and looking alike to
the already defined NXP XPCS ID macro.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

---

Changelog v2:
- Alter the commit log so one would refer to the DW XPCS driver change and
  would describe the change clearer. (@Russell)
- s/sinle/single (@Vladimir)
---
 drivers/net/pcs/pcs-xpcs.c   | 8 ++++----
 drivers/net/pcs/pcs-xpcs.h   | 3 ---
 include/linux/pcs/pcs-xpcs.h | 2 ++
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 31525fe9c32e..99adbf15ab36 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1343,16 +1343,16 @@ static const struct xpcs_compat nxp_sja1110_xpcs_compat[DW_XPCS_INTERFACE_MAX] =
 
 static const struct xpcs_id xpcs_id_list[] = {
 	{
-		.id = SYNOPSYS_XPCS_ID,
-		.mask = SYNOPSYS_XPCS_MASK,
+		.id = DW_XPCS_ID,
+		.mask = DW_XPCS_ID_MASK,
 		.compat = synopsys_xpcs_compat,
 	}, {
 		.id = NXP_SJA1105_XPCS_ID,
-		.mask = SYNOPSYS_XPCS_MASK,
+		.mask = DW_XPCS_ID_MASK,
 		.compat = nxp_sja1105_xpcs_compat,
 	}, {
 		.id = NXP_SJA1110_XPCS_ID,
-		.mask = SYNOPSYS_XPCS_MASK,
+		.mask = DW_XPCS_ID_MASK,
 		.compat = nxp_sja1110_xpcs_compat,
 	},
 };
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 96c36b32ca99..369e9196f45a 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -6,9 +6,6 @@
  * Author: Jose Abreu <Jose.Abreu@synopsys.com>
  */
 
-#define SYNOPSYS_XPCS_ID		0x7996ced0
-#define SYNOPSYS_XPCS_MASK		0xffffffff
-
 /* Vendor regs access */
 #define DW_VENDOR			BIT(15)
 
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index da3a6c30f6d2..8dfe90295f12 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -12,6 +12,8 @@
 
 #define NXP_SJA1105_XPCS_ID		0x00000010
 #define NXP_SJA1110_XPCS_ID		0x00000020
+#define DW_XPCS_ID			0x7996ced0
+#define DW_XPCS_ID_MASK			0xffffffff
 
 /* AN mode */
 #define DW_AN_C73			1
-- 
2.43.0


