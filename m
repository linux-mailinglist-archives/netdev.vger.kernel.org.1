Return-Path: <netdev+bounces-139423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FF79B2372
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 04:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76694281327
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 03:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747E6189BA2;
	Mon, 28 Oct 2024 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/eS6jln"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7675818D649;
	Mon, 28 Oct 2024 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084902; cv=none; b=jVLIYXkNzMREbZVFqu/UoG/1OfH7QlPgFGWjKMczteDDoYIvZ5ISpZvV9CFeBoR+e98oh3M5Ikvvq9g8r8xx/cW08JNs9TlhCX+NBb3Gyi825Z71EU/acxKKDS2Za+Y3MQCiiMaKp2GS4PKCzfccxEgvRrow+qIhX88efuntBbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084902; c=relaxed/simple;
	bh=udSu0PifOzRa5GkWP7sFryWEU4fALlPs0aaNg1SJDJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d+i5dShclg689gTtMfBUSW9iRSfyL1cPXUTNUmzSMle01iHRzbcC5xBW850Zx/RSZ9XT++ckd/w9Eja5ukSJA8L2UuL/7jTlRxhFoQKHN86JRcR4DU+mV7IzZva/NMlB8sHuKAoNZLDnU3X9TykG3tV99xLcKWtv+kB04rjxxM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/eS6jln; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cbb1cf324so32127935ad.0;
        Sun, 27 Oct 2024 20:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730084899; x=1730689699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZgSPrHkP+5PHa4TM3CPdf/GMcXQ4aZTX0bTblaWKZw=;
        b=M/eS6jlnau4rNaTBJJZ0IM4GCJzH8W8ETBEanJxx54h3xCIV5rX3ANh0zDaZwrj2SO
         0AoFs9zWmHXz/nNI8okrdgHf2a5EgKg1JoeuijcuF6ZGsFN4WZv75l9HRMDCcGz17TAk
         nLZGb8HCMW/BRnFk4KRc711rzqpMi7v2CK7WvZcQY1kMywp2/a3Sty0l5eBuPZK7YyBi
         SDLvfOXhLAo0Y9JVU/ZfM6RC/SXWWuKSngwyNCqGJDRpsHT9S3xt4EfYMFDrehSbOn1E
         48RYosM2g8QgIwZFflEt32UX9Pf4W4738jrwWzYR0vOKAqtxoM1N2YgOVeYgCPJrLm6l
         o2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730084899; x=1730689699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZgSPrHkP+5PHa4TM3CPdf/GMcXQ4aZTX0bTblaWKZw=;
        b=pQh5OSGAgsfjXl5+wY9fgDVWtnrH57MXxOG8G01TrhJ9/ltQx6Rg0E2a1qEXYB9CK0
         c7/nDhkjqNAvBBSqcHhBj0jxiMeNTGgQSXp2ydyN2fw/P975HbMdI3jWIVbUj8vdoi5C
         Xc3aNZic4+vLdKwDjGLhpRIV5zGaVLi1p/VDzPxvIxk3yWLeBEFUHFpFn8Giyn326aL4
         z8p8poiomKK3sE2DrSoTmD7FsMPwJQ0i9JNK0T73WZMIM5z5A5FmCAdNAUydwXntIO1E
         MbFaQCOg4eTM7QNPyYj74e5UX9OSFm9NS+4IFT34ORvVqlL0CPbxAhL7OgjUtjxxlIFl
         ABmw==
X-Forwarded-Encrypted: i=1; AJvYcCVHsznSNyki5PcYvMNy3vAvy2HuCt0TCMkZaXZ9aPIsFPfgKnjSu3YB19SuZN9Ca8FqKvqMvWMLXPYpT3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX53zWp9JhNeOjDAcqPCwRdJknZmBHkj6trP7qZ2aaqM+mKwVL
	Ppdj2IpXrYOwcxuxAkSuOVVVOR/cjznEmsETef2dQTzUUh50uu+pD+QNAA==
X-Google-Smtp-Source: AGHT+IFchisKXMXu4T+iCy7SrFqbq7c/JyULflLF19QqNcWyjDqPmVKAegFzkUP62qdTFlLz5UXVQQ==
X-Received: by 2002:a17:902:f607:b0:20b:ab4b:544a with SMTP id d9443c01a7336-210c6c6d591mr113535035ad.43.1730084899264;
        Sun, 27 Oct 2024 20:08:19 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-210bbf6d327sm41414155ad.67.2024.10.27.20.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 20:08:18 -0700 (PDT)
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
Subject: [PATCH net-next v5 6/6] net: stmmac: xgmac: Enable FPE for tc-mqprio/tc-taprio
Date: Mon, 28 Oct 2024 11:07:29 +0800
Message-Id: <aa950a5cea1f7b2ac1ff49c3eb958c01d46ee778.1730084449.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730084449.git.0x1207@gmail.com>
References: <cover.1730084449.git.0x1207@gmail.com>
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


