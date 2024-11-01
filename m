Return-Path: <netdev+bounces-141032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045259B9221
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D6B1F224EF
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C581A265D;
	Fri,  1 Nov 2024 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTYz0ou8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D9D19F423;
	Fri,  1 Nov 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467961; cv=none; b=YXp4N0BGDqWD8VD5VbcUg1BJIdg7LDg2L2tv1e2gIhI7Nc0imQPWTyt8d4yKAI1yDs4wJnowajaNkxy94jEdMxzYA5N/RXVbkAuy1E94Ix7xUjbsizQORekqyIYSaC6C4ds3jfzagGpgFfg5lOetc0p5dRhypOePod7gBobdnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467961; c=relaxed/simple;
	bh=udSu0PifOzRa5GkWP7sFryWEU4fALlPs0aaNg1SJDJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QdYpaUZ06esG5/l5ZjEoPbWe2JdygXo75yUcm7WFYONC2KSLI3229vX7O5lW72/ZZeXhh+T18RLQDTcySIJNWokQLmF5/pPqIVknP03D8hvFeJssb1FsqETu7BzytseACfHwkWG+1Up+9NK1ccyH7GhZk6A7WtXMPPItSqADTUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTYz0ou8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso1638459a91.3;
        Fri, 01 Nov 2024 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730467958; x=1731072758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZgSPrHkP+5PHa4TM3CPdf/GMcXQ4aZTX0bTblaWKZw=;
        b=TTYz0ou8Lu/QOWQgJN/mCerlrCBHdH2prEXt1kROYdRGpEnzDbLQvXE7bEmQaY2g4j
         1A2jxfJE3sTwW1XKHyIgw6jxsSRHs+xYIwLLaZPPCquzT7FQv+krlLIjZNu3GuO929UI
         ps6qpPFaw0tE6dfa1Y5VvQbEoJAP1nzxkBvgO3mUwvCohy8aGd19w3tEbkbwQTYJVwUx
         iTaniIlW7ykjzhFhyYWoiY0gS+6mmS3/7gMFM9gQ7A9oIcE3iFPZHgakwk1oeO8yqzsD
         kheL/2Gzvkw5tbYG8P7K8rF2DtaBaa2ZL5NAXi/uIyrc4VGI43fKssP0MZEM5TRUHem3
         y+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730467958; x=1731072758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZgSPrHkP+5PHa4TM3CPdf/GMcXQ4aZTX0bTblaWKZw=;
        b=FDXjZxKfI2osiR82ZQVT44JyHslb9qzZDVtV+0Ss2wPTgPQtpcEUR8aOGpdut8bIov
         2DvJlZzUAlV4sY+PTX62v41GFUkNeIMrcR2Fa+SZXTJSIdps8NiQ5BAcjaMFZGCTuaL6
         NvZWZyDJ+rwjPvlUbwGoxocoqhqSqpkYD2H+Ilv/QPlHpdpBkyOuhFUH1l5Yw/xUNBxv
         JTNU5UTt3LovLsS0kLzM8CzZB8wsRwH13ikdK3D4R251rjIsOkgQcPi4dAKsH3K/tsaD
         V7xjnYeru4ex5BxiNWPrDO4VZUx/kOtiWWpOpFk77BzPsiPxy+Cq0wvf8BB2X5UpQrmj
         MW2A==
X-Forwarded-Encrypted: i=1; AJvYcCUvqMdkWcq9eD5RjFmjXMjaat0Lj3OP55+gz+CK1q+cjawWb8+b2NdcZ1p2tN2bPJ1QPtMEiHR6qIei7e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXL3EChW4iSPw1U2H/COOhWTfQMpYH+xJogd6vUVrAxiOwEIL4
	CFKAlgxB/G2rO7XUBj53OG7adwv2CmO3UIM1lzb+tnXLcDAGhi2Jf47avQ==
X-Google-Smtp-Source: AGHT+IHTARvDrrbplxN/Ao00eWN31nXbIywcdD4rM9k0ODO/JUtkFyG0XgpgcHwQj45NcT/QvLH8bw==
X-Received: by 2002:a17:90b:38ca:b0:2e2:cf5c:8ee8 with SMTP id 98e67ed59e1d1-2e93c186141mr8591363a91.12.1730467958001;
        Fri, 01 Nov 2024 06:32:38 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ee452ac4ffsm2425552a12.25.2024.11.01.06.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:32:37 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v8 8/8] net: stmmac: xgmac: Enable FPE for tc-mqprio/tc-taprio
Date: Fri,  1 Nov 2024 21:31:35 +0800
Message-Id: <0575ef1553d572b7c8bc1baafa3fb7ac641073e0.1730449003.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730449003.git.0x1207@gmail.com>
References: <cover.1730449003.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FPE on XGMAC is ready, it is time to update dwxgmac_tc_ops to
let user configure FPE via tc-mqprio/tc-taprio.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 75ad2da1a37f..6a79e6a111ed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1290,8 +1290,8 @@ const struct stmmac_tc_ops dwxgmac_tc_ops = {
 	.setup_cls_u32 = tc_setup_cls_u32,
 	.setup_cbs = tc_setup_cbs,
 	.setup_cls = tc_setup_cls,
-	.setup_taprio = tc_setup_taprio_without_fpe,
+	.setup_taprio = tc_setup_taprio,
 	.setup_etf = tc_setup_etf,
 	.query_caps = tc_query_caps,
-	.setup_mqprio = tc_setup_mqprio_unimplemented,
+	.setup_mqprio = tc_setup_dwmac510_mqprio,
 };
-- 
2.34.1


