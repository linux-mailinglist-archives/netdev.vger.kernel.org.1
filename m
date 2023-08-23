Return-Path: <netdev+bounces-29918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E49785339
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7841C20C83
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0528A938;
	Wed, 23 Aug 2023 08:56:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB50883A
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 08:56:42 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3EA2D43
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 01:56:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c1f6f3884so696906666b.0
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692780995; x=1693385795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AslGWfxwSGfY+Fl1ndpwxP+06+6bcSEvPOtXVEc7gDY=;
        b=u0n54oQdFCRPlkryq7VzijjKhNcr54ieL7TViEd253esKAVYGLuWqjiU7wgRpXRIB4
         BRhp8uAqNCMpqj5s5/+JWzfvz28GNcgHxNqwgdOsti5LuVMd7AW+rEB/fVfmlt8unDhz
         sp2XkkBfaGUVC0af+9FGrr7bDbPV1EHh/U5qBDc8X0uWDl4upLVj6vcu3wTdHQn4xclm
         e7MY0lYcKmMuoQNLtSwVjM3mnrnH815gqqJxCp2LDJsrq1FFj7RHmbdomzy2oM1YJuGT
         6KX9OJAUE7hyddEFNmTgRS1m0oNwEHrbAcBQ287osSs/tkBcZTsEnT/JGq4RzOG4SfrQ
         hx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780995; x=1693385795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AslGWfxwSGfY+Fl1ndpwxP+06+6bcSEvPOtXVEc7gDY=;
        b=hGynF9wFAyEoJ+CVYTQpMYB4VVrbV1ywapiWdDPEHQN123R0fgZr8eZo0HcKBw9LJZ
         ws+gE6YJgpa613HtAsh2coiodQViLWdPxAn9N1bj/6BUDNedIKKHfSs8CUQXRKnA/ctF
         ou4vcyPSQq+78/DH3MonIS4QRanlgJ3R1IpHxLmULy3NLCI012TI0Nxj+Nf9efHuP8tb
         3t/za+C/DQFHB/4FmQ3MjDnQCUDIZ2q3Uq82qw6glGj3TJVNyfyXQVf+/YxOnYxBAnyO
         2ts9bbfYEsynHBxivzRlwHd2rbilDwXkhDSYVJyEf4LgGCQFZTBQQ7B84sHeY94eviVG
         f8Zw==
X-Gm-Message-State: AOJu0YzhRZqX29dvqv9bAQ8zyrk2gcjVWcpNgG37hxcEIFrviRkYtz9a
	qVuIfbsJktbpuBLUz+/kiI1PtA==
X-Google-Smtp-Source: AGHT+IEHrFB+dDhCvQbbY4eTMmnC4imbCLJk4+OAcyB7Z4Z/qdStoEn0i8bid6tQ4NrAuMRxtpYB9g==
X-Received: by 2002:a17:906:8466:b0:9a1:f026:b4f1 with SMTP id hx6-20020a170906846600b009a1f026b4f1mr192364ejc.30.1692780995169;
        Wed, 23 Aug 2023 01:56:35 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id bs9-20020a170906d1c900b0099bcd1fa5b0sm9492255ejb.192.2023.08.23.01.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:56:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] net: dsa: use capital "OR" for multiple licenses in SPDX
Date: Wed, 23 Aug 2023 10:56:32 +0200
Message-Id: <20230823085632.116725-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Documentation/process/license-rules.rst and checkpatch expect the SPDX
identifier syntax for multiple licenses to use capital "OR".  Correct it
to keep consistent format and avoid copy-paste issues.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/b53/b53_serdes.c                   | 2 +-
 drivers/net/dsa/b53/b53_serdes.h                   | 2 +-
 drivers/net/dsa/hirschmann/hellcreek.c             | 2 +-
 drivers/net/dsa/hirschmann/hellcreek.h             | 2 +-
 include/linux/platform_data/hirschmann-hellcreek.h | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
index b0ccebcd3ffa..3f8a491ce885 100644
--- a/drivers/net/dsa/b53/b53_serdes.c
+++ b/drivers/net/dsa/b53/b53_serdes.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Northstar Plus switch SerDes/SGMII PHY main logic
  *
diff --git a/drivers/net/dsa/b53/b53_serdes.h b/drivers/net/dsa/b53/b53_serdes.h
index ef81f5da5f81..3d367c4df4d9 100644
--- a/drivers/net/dsa/b53/b53_serdes.h
+++ b/drivers/net/dsa/b53/b53_serdes.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Northstar Plus switch SerDes/SGMII PHY definitions
  *
diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
index 720f4e4ed0b0..11ef1d7ea229 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.c
+++ b/drivers/net/dsa/hirschmann/hellcreek.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 or MIT)
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * DSA driver for:
  * Hirschmann Hellcreek TSN switch.
diff --git a/drivers/net/dsa/hirschmann/hellcreek.h b/drivers/net/dsa/hirschmann/hellcreek.h
index 4a678f7d61ae..6874cb9dc361 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.h
+++ b/drivers/net/dsa/hirschmann/hellcreek.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
  * DSA driver for:
  * Hirschmann Hellcreek TSN switch.
diff --git a/include/linux/platform_data/hirschmann-hellcreek.h b/include/linux/platform_data/hirschmann-hellcreek.h
index 6a000df5541f..8748680e9e3c 100644
--- a/include/linux/platform_data/hirschmann-hellcreek.h
+++ b/include/linux/platform_data/hirschmann-hellcreek.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
  * Hirschmann Hellcreek TSN switch platform data.
  *
-- 
2.34.1


