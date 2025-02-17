Return-Path: <netdev+bounces-167046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1366AA3889B
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED737A1310
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A457227572;
	Mon, 17 Feb 2025 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJ1ngecr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585DA22756F;
	Mon, 17 Feb 2025 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807947; cv=none; b=fcmUwmsksAjQ1FOz7k3NSNk4mJkGrJcIMYcBLHgZhBzprjLkYDW/n4oWiRI7c2YYNWAt3G3WZ/Tz2XVR23XWcJP9Dnmuc4HV4m2yvQ7MuV0HEq1DigKunR34Hl0dLDX4CEHCpJ/NBckvGD0SfHiycACUUgfUT7oOojoBXlJNFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807947; c=relaxed/simple;
	bh=mn/byETT/0sr5lhGTrcFKUtqBu0ZeniSKQID857Slmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ecHiwJBBg89YIj2QumxI3zvr5vxQQBfgyS2OiWxeG2p9XUSjdaOWsx88UitKjmRJWz/IA2dY80sSzkqM2MsWpoOeHGUzX0inMzjo+p1OnKbB//bCYHLYEdyEVZK3/ghUQxMBwQvILFY5K6iSaZbAoospB086dj0rybCwgIWy1d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJ1ngecr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220bfdfb3f4so92392835ad.2;
        Mon, 17 Feb 2025 07:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739807944; x=1740412744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FjCy/ZffARgeuZcf1GFTdyg+YmqrhzszPwnoHjKDmPE=;
        b=UJ1ngecrRc+UptoXynUz9rDqrZ7j3hN3Ss88m0+9bP8lpKFmOMAJbEJU+5l3AG9265
         afGA28HItvDG1CDxOK8AbEavzX3GxZjpNH4aWxS0PIlHE//ZRorI6W/5/QGaUDuOvB7A
         W3B3JHN6DIX/FDH7WTS/a0M660dRaujU91ETxHr2fJbLHdNVX3Cnhim7HGwK88D1fdrM
         zEE1ZsuLVpINSQH/1G1hXnzgQFnSY5cVo8qvH0/ia2mwlpCMm7zsgEaacFaQkz6sfQXy
         mVi7NkwqgQ6fIePgIJrobMPp+MXFO7IJC6jEtucYXV7kF7ZUcJfIEYKD1Vnih+BkVkLk
         XfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739807944; x=1740412744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjCy/ZffARgeuZcf1GFTdyg+YmqrhzszPwnoHjKDmPE=;
        b=gcflW0YkFPBJcU1CW6ZO90O4FKlnuAR2e0Ar/lBToGdROTeroIVH/ZHZqc+rwP6rbT
         8CCVrQOXB1GL5sQswX+yK27wxLGkzgV8rBppgfuFQJTmTSuDhvlfXCTlWlfhp8QckvBu
         C2/h5/8CSvVlWAoGakrN267tcjc1U4SxSwMzGqg86kJpNrZgEuYr03hZgZ/9WlxJqqdA
         +qDAg94g/zcbgSDacHwHlM6mbSV1eGDGaCsR1W3BaS7YHEgooLNrLql7vLQR2ZJIiFqV
         1rtIg9/qeJMdRY7xGISJGqDj++J+xjOoWwJSgJrYZrEdODlCwrCtsgPZPzBwrmIwznuw
         74ww==
X-Forwarded-Encrypted: i=1; AJvYcCUpGyTvB5Yr7Mm1pgvd8HUxsszCqTubFFQ2G/Tt1JC5DHX/oAde3r1v3Q1CuNVl4OTlBdLRv7GYUa1n/Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZy+Db/3ViNciAkShyZFYL5vWeI91EwzDkpGph4k73l9r9fB0v
	NChzZgTwP7HcV98WFGKgb5n4rNsPekHXfwkk5fUAPL87FIoCCp8a
X-Gm-Gg: ASbGncsOuvjn0W9yC5W+GhxZs0HqDascNIz/GMucilI5F8sm7gtGWtSdlJUikRz3U+8
	aGPQx/LEtx72r0c7h1JOO+brbrfT59q/rbGpikbZ14P42TnHrc0BJGf06oBfKl9uPGF7e6cTowS
	35/KoWP+iDlrDN5K/poRdHrbGwV38f0DSQbWvKnN91h6evhZwCgnAHPWkjCd313HAZD1vy0cnDx
	gT6Dwl7PzseogMYPnbL5vU5OEQchB7V6pGmGRsSCKShFRV8N+x+9dGkvIQGtIHnUpOE5KbrGeaJ
	O464tEZjr4HFXdp4tSk/
X-Google-Smtp-Source: AGHT+IHXyootXyMJ7WqJlzjvmqadmtDWJcQg4Y1jgPTTSE29jnJtzuRXNyecLpmO6L5BqF58tIKC/w==
X-Received: by 2002:a17:903:22c7:b0:216:3e87:c9fc with SMTP id d9443c01a7336-22103efc0d3mr183904045ad.5.1739807944475;
        Mon, 17 Feb 2025 07:59:04 -0800 (PST)
Received: from eleanor-wkdl.. ([140.116.96.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55858d6sm72826895ad.223.2025.02.17.07.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:59:03 -0800 (PST)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com,
	lkp@intel.com,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next v2] net: stmmac: Use str_enabled_disabled() helper
Date: Mon, 17 Feb 2025 23:58:33 +0800
Message-ID: <20250217155833.3105775-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kernel test robot reported, the following warning occurs:

cocci warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c:582:6-8: opportunity for str_enabled_disabled(on)

Replace ternary (condition ? "enabled" : "disabled") with
str_enabled_disabled() from string_choices.h to improve readability,
maintain uniform string usage, and reduce binary size through linker
deduplication.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502111616.xnebdSv1-lkp@intel.com/
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 96bcda0856ec..3efee70f46b3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
+#include <linux/string_choices.h>
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 #include "stmmac_ptp.h"
@@ -633,7 +634,7 @@ int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
 		}
 
 		netdev_dbg(priv->dev, "Auxiliary Snapshot %s.\n",
-			   on ? "enabled" : "disabled");
+			   str_enabled_disabled(on));
 		writel(tcr_val, ptpaddr + PTP_TCR);
 
 		/* wait for auxts fifo clear to finish */
-- 
2.43.0


