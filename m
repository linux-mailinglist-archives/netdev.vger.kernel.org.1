Return-Path: <netdev+bounces-115878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 651E19483E4
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D8A1C21E8F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933B116D338;
	Mon,  5 Aug 2024 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMEXwRhX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DEC143C4B;
	Mon,  5 Aug 2024 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722892263; cv=none; b=RdwUtVOO8f4dxHV9yd0+tXOkZ9jklCBUsutpZ1TB9WmGG5AJ/j1ZsHLX4LZ04HoEzJBQSLya0FP7t3r2YierXgAyx/mcgw9cIfD4i+iG2lu0YdDH36JbOQeZ4ocK6KOc0vj8TgJBXQMfeVV29a0EgAvh4NN0jJw8iaFcfG+N4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722892263; c=relaxed/simple;
	bh=7h5cZFkaufJdb0vRMkLXtHFo6e61k7QkyKt6QNDFMvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHGlH3buckeNd+uFDaOe5Shembb1L3y6LOgwLamr33DGyxyvMYbQ91ccWWwlbwkRXrkJHRKSXcHWcCqLuRWxmEJQ0BBFOECBr63WxS08rupAmE5dowdsm4UTQNsjNvl+GUH5RVlbC9yuCeecYQY8+V00wA2j04sGezB6y9CbrXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMEXwRhX; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso56371fa.0;
        Mon, 05 Aug 2024 14:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722892260; x=1723497060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FkeNGgxLJlDCBPLBLDTnDJd9fYpQKo2t2Ld/HlDRnE=;
        b=JMEXwRhXJUCopI5gWjce8SYmtMfW2Ub6HQEF62a3UB1bZnJy9hq8TG49uOXQXTvv5+
         xBY275adoQJLVcj7h/DaSn+f34ueRAq0E2tkRfAhdDQNo5OUgUYbextGrpjgonLESRRz
         w5gujBBdDJ11ipDG5whBa75LLKN/ZeNKsonu1BCRXWycpUMNXrzNiE9Lz1sEJelV2UlY
         Nc1jcBj1Cn0DYW0I2TA7tcqdRTv6izud9gUm1qJDIx0/l+Iu5rRGCxrAFWGmRDJiD29A
         R/t86QPqapRp0iSbXSmveBD3VE64d0rH7AMS7ULyFUPn9uJY5+5p8RhU6QTH1y/5hxMW
         RliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722892260; x=1723497060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FkeNGgxLJlDCBPLBLDTnDJd9fYpQKo2t2Ld/HlDRnE=;
        b=JZdRNxKdOuOyjpvwfdVWewR5ldPQ2oMEpU23ZfL5eLknA3ihNk6bTR/KSu9TVBw+PA
         CQqTNBAvBsjr8N2MsX2e/FKRYef4YqJAGLQzHHlB1YsWKyGv7v4t4bhjcH1Is6TzjInc
         cEQ+OOfCYI3xw9Ua1x1FL+IpJ7Qc/+8dvdA76IaeQgGbazgjJsU3eCUGwku4gaiTD1+M
         IN40z6BN0To8kFtfMV5buWECE+UJu5QPnCPVM8SW2OQzQ5pkq1KBNVym3WVlpT4JYIP+
         qUXlfXchWZwG7pCgp8cAURkdoKw0y2oCB2tIhq37WBYXrWpb8DQ2AnOhmxi2uWNt9ULP
         G2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVa4/FOYFQs8qVwUlETMNUDH9B3yfFE3M6ETLd2GKxBbJXqDZsY8fk4fNqbDf5zEYC2z4Dyoz7tdrsCYqXbu9/eIg9utXgLqSjzP6Oi
X-Gm-Message-State: AOJu0YxNcns3bcSp8lEEBEPXU2qnwePk1s396bEv10TfVX3CDBwdJifq
	0ywI4P3B23IEzSBlo8YoP6cyAH1I3VBPE/7pdP6PW/4OQA+wpkn+9sLSY1Ul
X-Google-Smtp-Source: AGHT+IGJ8JS4rvgadwcvP7Di1O6ysebb1EmrHLM37Mv6wVLiQBPM7jIY6/aObAFLb9So+6MhQ3UH/g==
X-Received: by 2002:a2e:8050:0:b0:2ef:c8a1:ff4 with SMTP id 38308e7fff4ca-2f15aa88b8fmr104722711fa.7.1722892259217;
        Mon, 05 Aug 2024 14:10:59 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:1688:6c25:c8e4:9968])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1c623csm11875291fa.63.2024.08.05.14.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 14:10:58 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/5] net: dsa: vsc73xx: fix port MAC configuration in full duplex mode
Date: Mon,  5 Aug 2024 23:10:27 +0200
Message-Id: <20240805211031.1689134-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805211031.1689134-1-paweldembicki@gmail.com>
References: <20240805211031.1689134-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet description ("Port Mode Procedure" in 5.6.2),
the VSC73XX_MAC_CFG_WEXC_DIS bit is configured only for half duplex mode.

The WEXC_DIS bit is responsible for MAC behavior after an excessive
collision. Let's set it as described in the datasheet.

Fixes: 05bd97fc559d ("net: dsa: Add Vitesse VSC73xx DSA router driver")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2:
  - Added 'Fixes' and 'Reviewed-by' to commit message.

This patch came from net-next series[0].
Changes since net-next:
  - rebased to netdev/main only

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-6-paweldembicki@gmail.com/
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index d9d3e30fd47a..f548ed4cb23f 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -957,6 +957,11 @@ static void vsc73xx_mac_link_up(struct phylink_config *config,
 
 	if (duplex == DUPLEX_FULL)
 		val |= VSC73XX_MAC_CFG_FDX;
+	else
+		/* In datasheet description ("Port Mode Procedure" in 5.6.2)
+		 * this bit is configured only for half duplex.
+		 */
+		val |= VSC73XX_MAC_CFG_WEXC_DIS;
 
 	/* This routine is described in the datasheet (below ARBDISC register
 	 * description)
@@ -967,7 +972,6 @@ static void vsc73xx_mac_link_up(struct phylink_config *config,
 	get_random_bytes(&seed, 1);
 	val |= seed << VSC73XX_MAC_CFG_SEED_OFFSET;
 	val |= VSC73XX_MAC_CFG_SEED_LOAD;
-	val |= VSC73XX_MAC_CFG_WEXC_DIS;
 
 	/* Those bits are responsible for MTU only. Kernel takes care about MTU,
 	 * let's enable +8 bytes frame length unconditionally.
-- 
2.34.1


