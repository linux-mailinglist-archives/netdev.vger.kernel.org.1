Return-Path: <netdev+bounces-110162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B2D92B219
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E27B22A63
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BF915380B;
	Tue,  9 Jul 2024 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sdv4cS0+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8991527AA;
	Tue,  9 Jul 2024 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513425; cv=none; b=Dkd+szTnWsAXcSowRIwvdCCTkxxFBzUXGRBCQ0F+pdMKAMeNlV2avfDS1saE4PJQIsfZBG4aiNScHRAo2lfpPMks6y8bXjShFuLVLS4SwyDoU1KCn9zj73TtA4agYFpecROjuMMgah39xmTaF+dYbOquK7uFsWPCeH8Ck8OilQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513425; c=relaxed/simple;
	bh=SmezAz6lx/b6Wh0eCBWbS/9CX/6rhZ5RMEV0HZ8cgKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ue76WzxjX6EYVwX2v2s/xyu335cZIQ/EWyEglCbEhMZ/WTJajSQ22/U5OCDBDVjcq8vxQQU1WQlrVQv5HBD39imONj+v4Lagbb5+tuqLoItBSHMsWg+cFCg13J5wauBXjPYaTc0p46CbwF94wAKGaS3jUexyVP8b+Pio5WZu69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sdv4cS0+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c97ff39453so3303606a91.0;
        Tue, 09 Jul 2024 01:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720513423; x=1721118223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETQ1Az9wlQRIwVfJaj8s9DEGWwFkHYmCUfhq50YE6H8=;
        b=Sdv4cS0+M7i8JyLl4uzC9RI6jk9PvEcNqBwviGATIfsV6NLFSaW6ZCHIp0IYfk6zaA
         9r67Pa15dDI8XKvfeNjM8N085Z+80gFgt2gDILledKFcVru+Sc3W6kKjGwNygxs7iweT
         2lfwyhj65J8/FedF7nsCWi+u86PCIi9M3liHb6r8d0Uy6zOpbU1J/5U6bVp+cY+YGRTK
         nc0rQw+HBJKy4vRwixTQi17q4RQG7VqGGLceox0XvXygqLvaN3PhghFMonivGtpNvqAS
         TYVgjd6rjYPDgJ+DsEJP5Itj7ZpNUCoNR3eIofI4SVmzP03t5TZqSds2QUqdylPbDu36
         IUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720513423; x=1721118223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETQ1Az9wlQRIwVfJaj8s9DEGWwFkHYmCUfhq50YE6H8=;
        b=bjsT4+jFEFDGjnOQD8IVG+G4bP/8XcsIMR69jhaDr6R8D7LxIP1NXOe9xfni2d5UGq
         K/0BowzbHbHLci0HCjspazscfFFxYSqQ1fnQymFHbS/A4cyl7DpLWwvjCTTUXetQKCzk
         n4AmOM3hqB6hrovRbMrIzvJllaF9ey/uCcgiEBWubhuM5reXfrNRjUckYUacZBSbQjN0
         yNPSI7Zx4XkhQt633BkXE+8gxduxU6SGSD9X1H8mwySrt5U2O1UNpMgWbjVkLDjnoEb4
         6yTkrSGQ+HT7Jgbgum1A+aC+634rOhPJV1sDeKlEZmDflhG1PqOcc4KXj/0wVg5FWPe6
         gp4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUG+NAnuD44WnVR3t38FZJ4Wf175qHoAerap9mVTG1QgKBP/eL6vV7nzP1PJseMNwyCg8w3g80Zdi82sSNVNrQixT2SzQ7Gdm1/4SC
X-Gm-Message-State: AOJu0YxloAve8nwuL7WLyirZvoKN2DBQxJcAp0qJPyEhiD6xaddoBwj7
	m4/mTRx1RdgNQ7Vd1dBZSLhHvcT51ung030N9JfxYO0Mynghpi4p
X-Google-Smtp-Source: AGHT+IEVYnLUHa1kgLdWSapSU4Nr9l01XJ3I7VWvMs6KV7BVQGoIhoK6qMFuFZbgFcihFFyg/q6Bbw==
X-Received: by 2002:a17:90b:110:b0:2c4:d00a:15cb with SMTP id 98e67ed59e1d1-2ca35c69723mr1851012a91.21.1720513423275;
        Tue, 09 Jul 2024 01:23:43 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c99a92a430sm9588929a91.4.2024.07.09.01.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 01:23:42 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 7/7] net: stmmac: xgmac: enable Frame Preemption Interrupt by default
Date: Tue,  9 Jul 2024 16:21:25 +0800
Message-Id: <fc69b94aad4bbe568dcf9ef7aa73f9bac685142c.1720512888.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720512888.git.0x1207@gmail.com>
References: <cover.1720512888.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Frame Preemption Interrupt is required to finish FPE handshake.

XGMAC_FPEIE is read-only reserved if FPE is not supported by HW.
There is no harm that we always set XGMAC_FPEIE bit.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index c66fa6040672..f359d70beb83 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -96,10 +96,11 @@
 #define XGMAC_LPIIS			BIT(5)
 #define XGMAC_PMTIS			BIT(4)
 #define XGMAC_INT_EN			0x000000b4
+#define XGMAC_FPEIE			BIT(15)
 #define XGMAC_TSIE			BIT(12)
 #define XGMAC_LPIIE			BIT(5)
 #define XGMAC_PMTIE			BIT(4)
-#define XGMAC_INT_DEFAULT_EN		(XGMAC_LPIIE | XGMAC_PMTIE)
+#define XGMAC_INT_DEFAULT_EN		(XGMAC_FPEIE | XGMAC_LPIIE | XGMAC_PMTIE)
 #define XGMAC_Qx_TX_FLOW_CTRL(x)	(0x00000070 + (x) * 4)
 #define XGMAC_PT			GENMASK(31, 16)
 #define XGMAC_PT_SHIFT			16
-- 
2.34.1


