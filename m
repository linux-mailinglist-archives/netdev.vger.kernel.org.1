Return-Path: <netdev+bounces-152103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9205A9F2AD5
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23A11889AF0
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 07:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944511D5141;
	Mon, 16 Dec 2024 07:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="iEVBDoLx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2F1D4612
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333616; cv=none; b=oXlrFCvo/DNe2gzzFhDAFajzx/fFnZ9jDKiF9J2DNg/o+Mzp8aTtNgZtn2XUlJHiOLUlfkkgkvFLDaIAHJZcjvn01S7XxHFs4LizX2RpL7SdOoVrAGcHMh0arE5QEw9aSMPLtncEufsu1dxR7TBR4bydwbr66T7wh9zZT1p3kG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333616; c=relaxed/simple;
	bh=UlHsVBY2+5OwtS51cm0ukD6vGIqcaS4QJZtIio5czj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=clG1pRL26G4WHN7rbPDLAoirBGsi/foSB6MHQb/2CdYCTIb6hEFctBdIn50GOpkgb3fP1CRxQbre8Mole51aCUrsUetACX8/zDmCQBLeXw6865OmMguIOTzJo9UOdr8UrpL+HR3CQobqK0hPOLqC6NkEcZ2FIn6hbiFm2DKG1AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=iEVBDoLx; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54024aa9febso3757749e87.1
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 23:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1734333613; x=1734938413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3lnZaher8bDGwGr+xGMpx7jXGopkkIbw5+lGNp1zoU=;
        b=iEVBDoLx8hevq8+eKfYH+Jrv876CkWEMz76oueIVs+LW7BWBDTLah6nzOJOAZ8Jh44
         fBAOb3l0c+vKSKTSfoKvcQd2dZHrfrNFzfWMLDO0t5gg+9St3aReV4Dc0VHQZKo/0cMJ
         ekLduMAckf/2H/tnN2o9ZyMEGioNvGshPY/hP39iYMfdMLAFujnoQvKYV1N6g4ZnH6HC
         zgc4WmShfDKvAGrKkYnwREWeiZXnOdfih9rsHQ8+sJ6jZIRBS605nduRfTvauMnymZo9
         qQenTfwPv3VCYl61+syp+SgdxR0HhyxxdMCzRxOMILj20ORpx16ECHutt2t3KwRZtemO
         tW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734333613; x=1734938413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3lnZaher8bDGwGr+xGMpx7jXGopkkIbw5+lGNp1zoU=;
        b=J5BuWI5ICjdgpbliUKCgCVw81m0a7yyWVNNigdde591hYmMmrYCkZP87heMHGvUnVX
         w38nrh/VXqWhL5xOE1/rn7U/FULN3QUTW8qA6u2ErpDwfYVmUV2hzIjvpLDg/ZkUv0d5
         oLkXWdaTxaPQ80yPcTtNgXjSQtJaxG+sVOBMqVhWbKiyGyl0fcHBe+e78xKBYOvHnkdv
         yVrb7NX+5/ka6mCTVvJH5T8bUPfOK/evkOK+Js7fu9dvNnaJ7xK73QuiQGGoYEgPScu9
         Yf13TP/e9JmoOkDpg7Pt/ENjQcHLBG9EO7s+o5IJN1KrDQ/sifRlk66NvVwRC8LDReRI
         qhig==
X-Gm-Message-State: AOJu0YyOrqnTQcLiBnRX0pZw5PFBhJwgaFIDCu/k5BcYkR5ysqPOa/gt
	AwNRzxh6hPppva49Ru8ot78aBAFHM+dOq4J78on6ihqV7BzG934zAJ4ZeHTC0VnMsSCs5GaJfeL
	Qv4A=
X-Gm-Gg: ASbGncsigXgsem/27FIasX8+kucPE8Pu84XzVgR50GamF8J1avHeKOtgAVS8sWCOnoW
	2KwCe71qOSndiNfGgbSqQJYWyBIv/Uxbp/ooxMQopm+4Tdopue52tublvqO2q/imhx9aMSJezTa
	V8b/jwFUfRpFiDJbNUCANEPk+AhCK5ey1h6fQO+liR9ZG4O2IuTD7HkC9SimnzRxrQJSgV9CV0u
	FY2CsG1990YSQZ0QY+SWr4uIdssx44iImvftItoTRLlaRNH5KdmBbnG/qhCcyCbNndFb7Q=
X-Google-Smtp-Source: AGHT+IHGvvy7ocT/yLWz+20NQrkjy9SXMAlu4TryyrSG9B3M6ZvfiDNezXzU5CTqzAb6oEJrphXPtQ==
X-Received: by 2002:a05:6512:b18:b0:540:1dac:c03d with SMTP id 2adb3069b0e04-5409a2297e1mr3485716e87.57.1734333613069;
        Sun, 15 Dec 2024 23:20:13 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9b2bsm748930e87.94.2024.12.15.23.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:20:12 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next v2 3/5] net: renesas: rswitch: align mdio C45 operations with datasheet
Date: Mon, 16 Dec 2024 12:19:55 +0500
Message-Id: <20241216071957.2587354-4-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216071957.2587354-1-nikita.yoush@cogentembedded.com>
References: <20241216071957.2587354-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per rswitch datasheet, software can know that mdio operation completed
either by polling MPSM.PSME bit, or via interrupt.

Instead, the driver currently polls for interrupt status bit. Although
this still provides correct result, it requires additional register
operations to clean the interrupt status bits, and generally looks wrong.

Fix it to poll MPSM.PSME bit, as the datasheet suggests.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 12 +++---------
 drivers/net/ethernet/renesas/rswitch.h |  6 ------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index e1541a206687..6e3f162ae3b3 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1205,32 +1205,26 @@ static int rswitch_etha_set_access(struct rswitch_etha *etha, bool read,
 	if (devad == 0xffffffff)
 		return -ENODEV;
 
-	writel(MMIS1_CLEAR_FLAGS, etha->addr + MMIS1);
-
 	val = MPSM_PSME | MPSM_MFF_C45;
 	iowrite32((regad << 16) | (devad << 8) | (phyad << 3) | val, etha->addr + MPSM);
 
-	ret = rswitch_reg_wait(etha->addr, MMIS1, MMIS1_PAACS, MMIS1_PAACS);
+	ret = rswitch_reg_wait(etha->addr, MPSM, MPSM_PSME, 0);
 	if (ret)
 		return ret;
 
-	rswitch_modify(etha->addr, MMIS1, MMIS1_PAACS, MMIS1_PAACS);
-
 	if (read) {
 		writel((pop << 13) | (devad << 8) | (phyad << 3) | val, etha->addr + MPSM);
 
-		ret = rswitch_reg_wait(etha->addr, MMIS1, MMIS1_PRACS, MMIS1_PRACS);
+		ret = rswitch_reg_wait(etha->addr, MPSM, MPSM_PSME, 0);
 		if (ret)
 			return ret;
 
 		ret = (ioread32(etha->addr + MPSM) & MPSM_PRD_MASK) >> 16;
-
-		rswitch_modify(etha->addr, MMIS1, MMIS1_PRACS, MMIS1_PRACS);
 	} else {
 		iowrite32((data << 16) | (pop << 13) | (devad << 8) | (phyad << 3) | val,
 			  etha->addr + MPSM);
 
-		ret = rswitch_reg_wait(etha->addr, MMIS1, MMIS1_PWACS, MMIS1_PWACS);
+		ret = rswitch_reg_wait(etha->addr, MPSM, MPSM_PSME, 0);
 	}
 
 	return ret;
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index 78c0325cdf30..2cb66f3f4716 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -743,12 +743,6 @@ enum rswitch_etha_mode {
 #define MPSM_PRD_SHIFT		16
 #define MPSM_PRD_MASK		GENMASK(31, MPSM_PRD_SHIFT)
 
-/* Completion flags */
-#define MMIS1_PAACS             BIT(2) /* Address */
-#define MMIS1_PWACS             BIT(1) /* Write */
-#define MMIS1_PRACS             BIT(0) /* Read */
-#define MMIS1_CLEAR_FLAGS       0xf
-
 #define MLVC_PLV		BIT(16)
 
 /* GWCA */
-- 
2.39.5


