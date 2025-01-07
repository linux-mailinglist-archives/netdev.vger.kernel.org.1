Return-Path: <netdev+bounces-155746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A86DA0391A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 08:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA77F18868DC
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4F91DDC06;
	Tue,  7 Jan 2025 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlVuP2GJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C72137C37;
	Tue,  7 Jan 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736236511; cv=none; b=L3L6UgFE7SZ95rSlj3/+H9lkyzHyzKuU+dyBMcEorgfeRRMVTx9SXi41T3XRG7UmBaiJWR8nTYebgu9triVGi86zzn9951jbXphgo0qT2Hc0Q0IGYxiuFvK+m4TJIPa7tYwTfwpkN4D6oUnfBWrgkGBZ9MQ5rc40T/F7Rp5RfA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736236511; c=relaxed/simple;
	bh=DkQsxBYXjrXTGNuz03s9MA1m/PgQOj8rOW7OpyJup+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L4YDjz0t0M/uoJiVI3q0dbBFvxg6hlV+uptX9jKZDctMY8WXRYs0DNA9jMKaks+p0x6Dsw6d0LaMquPAMzcfJ+FHKTxQUJg1FFVudvZh7XU8VFM//sdoUSyl6WGVvq6B4j9f39h9R0WIOcDUndi4vBRceAkAXMnbmlJ0DWdAA08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlVuP2GJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216728b1836so201915395ad.0;
        Mon, 06 Jan 2025 23:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736236509; x=1736841309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fMRSb4dnSsNjNB0J5PZBlf9Y068CCmYN8ovILPTjdbA=;
        b=hlVuP2GJiZh0mOI+daZgr/WOvYKz7GR9VZCiC+PZCIEo0db3BYOKyt2y0Xsrd5mZi8
         LLDaiy6ds9UMNwxaBsAJoGwYM1i229cBl8L+2MR6lcvtG3HvPKxo5bCrMZ737RCvFlQf
         ASgSp4eIe3GeAicmGcFMl8TCOVmTn0I4a4CniL3NV5WoGH/O0wDnobh2GRG5QCMWAChC
         x+wy++CndVCBE7kUREpwMWsSJ2YXZbu2lRznBtgmEFciU4REkj0hpiZeoSHnsa82adV/
         342HRB8Cc/00gc6CREYWBq+B6l6hH5DR9fo0+TFtGlWvEWf8RRg5ZJ7EZxTuI7sMPLL4
         UBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736236509; x=1736841309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMRSb4dnSsNjNB0J5PZBlf9Y068CCmYN8ovILPTjdbA=;
        b=Lmra6Cs2jLyOP3bZIljpEMnbjgvb/cStvdDJ6Cnq4bnqyszQ1YBkZYy0m+QGiMU5e/
         xJg8fRQtC2iO9sJB3ktlBKFsIewFa0tTEb/JyPsf7xD2RZb7NZRkiPfdAyX1HdSk3/bO
         btPaaB15Tpswyl1bC3jW/XdiDoy3hpmv+OG0Tmxfj2P8PKWLmbqxCBcn6DeMCwMzwWIs
         57fIBeIp1r1QQHmmsQ49TAolxXaxGAj9m1kYXUb2nBSgFrryNK1cdAgeKmWJqCd8vt0J
         NcofqQdLzUo/evoZ7yLReiHjL133UfhhvZJP0wvowVrcFfwCtaglIoUkj9HyYARqE0Aw
         Q5+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1Pfkl6pWzRB4x1MburtrnKXDy/rpeVeRZQ/CVMirJVbKvra2UPsRoduGZOQFYZsidKav3SlrlP2D4YKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3gmOC3CenZbrUoRctrtsNC+v0wL2U2Io3QlGV7cx99TyHqMw
	wzpT9C4a+zvN0oHvHnL3MMDqfAIZgZi/qjRwM2forg10J192HXysRMfwcA==
X-Gm-Gg: ASbGncsRGCWbr/DceYkYJ19sSTUpjcg7hZggek/d/P11kpFcQggUeK0Z4jqzF9B08ky
	D+DVH22GTPZCH5py/WZeSyCHwXzXQ5q15UXa8IcXaXKeM/cXpS1iJR1rF1c+ZQB0Dz3A+fEl/Ko
	vWh0lpid8va6+vfLeE37O/Tg1xuwgOhWsVoBtdQcb/ymH9jKhZXmaPtEo7venPDJgYe9XP3sNGq
	WSDaB/+EUlLle5xOlnI/WxY+Y52OCXJzRFlmSMmCb0AzQNqM7dSCqaxfxM2qM+yQttpQQ==
X-Google-Smtp-Source: AGHT+IHTiLKTTvGlPvf762xL6WD6qZDn+dCSTlEUSBZ2KuE+CZ/5XDACbnpOBQG5E+loF0NezMfxjw==
X-Received: by 2002:a17:902:db11:b0:216:282d:c69b with SMTP id d9443c01a7336-219e6f4312dmr754512945ad.50.1736236508633;
        Mon, 06 Jan 2025 23:55:08 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-219dc9f7e49sm304468635ad.217.2025.01.06.23.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 23:55:08 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2] net: stmmac: Unexport stmmac_rx_offset() from stmmac.h
Date: Tue,  7 Jan 2025 15:54:48 +0800
Message-Id: <20250107075448.4039925-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stmmac_rx_offset() is referenced in stmmac_main.c only,
let's move it to stmmac_main.c.

Drop the inline keyword by the way, it is better to let the compiler
to decide.

Compile tested only.
No functional change intended.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
V1 -> V2: Drop the inline keyword (Andrew Lunn)
V1: https://lore.kernel.org/r/20250106062845.3943846-1-0x1207@gmail.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 8 --------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b8d631e559c0..548b28fed9b6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -416,14 +416,6 @@ static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 	return !!priv->xdp_prog;
 }
 
-static inline unsigned int stmmac_rx_offset(struct stmmac_priv *priv)
-{
-	if (stmmac_xdp_is_enabled(priv))
-		return XDP_PACKET_HEADROOM;
-
-	return 0;
-}
-
 void stmmac_disable_rx_queue(struct stmmac_priv *priv, u32 queue);
 void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue);
 void stmmac_disable_tx_queue(struct stmmac_priv *priv, u32 queue);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2f518ec845ec..24cc39d8edbd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1315,6 +1315,14 @@ static void stmmac_display_rings(struct stmmac_priv *priv,
 	stmmac_display_tx_rings(priv, dma_conf);
 }
 
+static unsigned int stmmac_rx_offset(struct stmmac_priv *priv)
+{
+	if (stmmac_xdp_is_enabled(priv))
+		return XDP_PACKET_HEADROOM;
+
+	return 0;
+}
+
 static int stmmac_set_bfsize(int mtu, int bufsize)
 {
 	int ret = bufsize;
-- 
2.34.1


