Return-Path: <netdev+bounces-138108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1739ABFC7
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB3D1C237ED
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D3C156220;
	Wed, 23 Oct 2024 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSG3ScX/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4D1155A25;
	Wed, 23 Oct 2024 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667199; cv=none; b=UgTnt8+tMzBs9Hsf1Yf/g3poALIfShXihGfGtXQ4sTfrF4uqNswwhAkos8XpoidKPt5+uI1/42GPx7ZcxLjaoT57A5Qt3zh3ozCvBqw+J/cknWute2qCaQDe30qRl+UvzH3vkaYsUHCwewdGgo1uV8d4LzPdWJjkh+S8lRTHLXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667199; c=relaxed/simple;
	bh=2S4PB8cD6QEm0H1EbYTjhF0pvtpTkaqyZMQBDZ+H/dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bs+sfC4rN9csvYfVjTrZYMNS/XHjCbMJqgYOLJztD8FS0Lh3ke4Hj3v4WQIKcsmmws09P6p5cTDCQ7HtCHEoFDWUphQvrv1IZqqOP3oaM0zqJNhODuj5GRfPgtkUI5rXjrglB+ceBJTIm2Z9lvgNM7Nr94kEUywSDlSguZ+XOTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSG3ScX/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20caea61132so50735645ad.2;
        Wed, 23 Oct 2024 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729667196; x=1730271996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8TKGjQeKzNK1dKhEB6C1AtEwQljW8KsdP2zdrjwMfM=;
        b=nSG3ScX/nXYR3czBomumKjNibr8Y3pg3bCQTzyEtOFaWsvV8ex7WmNquyTUztXiRic
         slmhozuZttd26VitI29geJ/lw+721ZxWnu1sKVKzznRHR5vKOLknXnZyxWfgVF6JY+SL
         xxlpQ2WzoeuwDD1/rHt5SFM12VtoRRF1dSmF0gJf4RpMZv0g0/2jNyX99wzFA/EUT8S9
         0wwtT5VRWV83Y4F8REO2r/cONIidLzf83TNJRa5nSgnuxsrBDDSkhorSOIC77GqGNgOk
         qP2F+MimGr01Q4lEviNn3pH5QbnZw6Mrm9HbnIvnjgaqTPBmFv9IDF8h1/YhdkhOIcPn
         vfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729667196; x=1730271996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8TKGjQeKzNK1dKhEB6C1AtEwQljW8KsdP2zdrjwMfM=;
        b=jCOwq96dk47jq/VMjlI8+Rn3SOXE0QbAsruIjKY44gEA6O2PZyTk59IZ4W+pgAlB1v
         E93fJfj0JSkOIT3G5j9f3v4CniaWHjW1GWFIp39Q/9huarl82PThtWWz1ZqgBplX+Uey
         HEMZfOn9R31C7KbJzauS7wB7eXqFM12LSl+3HwqTbd8Ukg9Oih3TsA5jdwDbTcYTihVB
         /+5O8CjEu//p4kptNLpAg3+4VRoCPn2rncX4TnlrioYX10HN+d9ArqV8YtQDrHm8/lQB
         Qy7e81miEgVZrDolyeqeGLxQ83l4v9NhQBAck9c33xpNfFUuEd2siSZpB9dJKlhT6KOf
         E+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVPjLl8V5Y3Va2hWK4YxNhC2oKssnFdLPN24F2IX9VvqgBfLvZJBouqQoCWQjQ3iiAYqbYDNVCl62Tj1SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC3A66IuvRgi3ttbkRHvjaqoTcgz05wGTZbkF3mECttw8CSSwD
	M/hl4VnHWBnxttaLvYhklC+4W6XXuagHwHvsRo7KwXBaxxGVeOyn7WH4VQ==
X-Google-Smtp-Source: AGHT+IHSnPv/WVNjHv6HF60PoAyBSgQDVxcTkHtmIHwy9EeV+7EtdLPdzYBRIDwHlO+bPFZudD1FSw==
X-Received: by 2002:a17:903:2306:b0:20c:e222:619c with SMTP id d9443c01a7336-20fa9e9f8dcmr23396015ad.42.1729667196354;
        Wed, 23 Oct 2024 00:06:36 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e7f0c167bsm51981745ad.140.2024.10.23.00.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:06:35 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v3 4/6] net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
Date: Wed, 23 Oct 2024 15:05:24 +0800
Message-Id: <137e7cf0cb5e6c3e6cbe7f8fe7c979a70373c0aa.1729663066.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729663066.git.0x1207@gmail.com>
References: <cover.1729663066.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Synopsys XGMAC Databook defines MAC_RxQ_Ctrl1 register:
RQ: Frame Preemption Residue Queue

XGMAC_FPRQ is more readable and more consistent with GMAC4.

Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h   | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index efd47db05dbc..a04a79003692 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -84,7 +84,7 @@
 #define XGMAC_MCBCQEN			BIT(15)
 #define XGMAC_MCBCQ			GENMASK(11, 8)
 #define XGMAC_MCBCQ_SHIFT		8
-#define XGMAC_RQ			GENMASK(7, 4)
+#define XGMAC_FPRQ			GENMASK(7, 4)
 #define XGMAC_UPQ			GENMASK(3, 0)
 #define XGMAC_UPQ_SHIFT			0
 #define XGMAC_RXQ_CTRL2			0x000000a8
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index d2ea941370dc..f7d48bf2faed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -373,7 +373,7 @@ const struct stmmac_fpe_reg dwxgmac3_fpe_reg = {
 	.mac_fpe_reg = XGMAC_MAC_FPE_CTRL_STS,
 	.mtl_fpe_reg = XGMAC_MTL_FPE_CTRL_STS,
 	.rxq_ctrl1_reg = XGMAC_RXQ_CTRL1,
-	.fprq_mask = XGMAC_RQ,
+	.fprq_mask = XGMAC_FPRQ,
 	.int_en_reg = XGMAC_INT_EN,
 	.int_en_bit = XGMAC_FPEIE,
 };
-- 
2.34.1


