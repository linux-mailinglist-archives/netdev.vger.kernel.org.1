Return-Path: <netdev+bounces-194520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933EAC9D50
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 00:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468DE17BA3E
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 22:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE9321324E;
	Sat, 31 May 2025 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg1zZXZ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279491F4CB6;
	Sat, 31 May 2025 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748731827; cv=none; b=jUXLbgGlqqUa5/fFEEKmD263YwZPecpswSAIei5C+IEW7nq4g0ofYy4w0kdD8ReAMzaSmBP0vnN4CpqVg106wMs7WNJmA/M67J0uXKl4u1BYqcl62AwT9YfBgl5ftyPJx/TxBrttwOoITqqpPFT5d76Ejruc55hGcWgOa6CC/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748731827; c=relaxed/simple;
	bh=R5txiWduQ1MLb/7Ofzb1I1KmObx5d/2qHesoSZIUDnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GN21GFVqFOXb0rNWFaEEs2GRcw+uYeogsJnNx0BaKHPR+utbqBk+VpYcsjF+VDiei1eWQ0B8m1oa/yWM8xI7shKYJCHKC9ZcEroqbsHuto1QzD05mzS/k1GkL0nHRkNR4o1HN1fCTNfpF5lQ2wEJskynoeaJj06NPw7+JENc71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg1zZXZ1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6049431b0e9so4913242a12.0;
        Sat, 31 May 2025 15:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748731824; x=1749336624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+ejMMbHq5PYDlrAJtCac52TZKigbKKjKjZOjD2zAkU=;
        b=eg1zZXZ1sZLsaFDC5VRVcMCsJrzqm4NfjAm1V6MbQ3ep9N/jv+t1hwFvaDK3R7Lvyr
         LcLYhBkmnm8s7VpVJtEDInwDpFN5qhk7sFJ3Y3DSRZOtQQ0N1Tt24qSicOO1f2nCM7Ls
         nRxcwGAbtcWGbORccHm0IPFY/I2brW0YX9ufsWWmva0iuQ605HGblZaXXAJO1EY9faAk
         pE/FT55shCzYUPeBmb17G//u9My8MyzHFjA9WnTdlFgcoHnnFRyKaqMgjgkdWpQvytDK
         Iyz4nhI8rMgKYXn18l7R69Hr7XsIC8ebUvmK+cVn6nGBwRZTocS2t8+nlScGqUVEfvYR
         69Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748731824; x=1749336624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+ejMMbHq5PYDlrAJtCac52TZKigbKKjKjZOjD2zAkU=;
        b=AxxsfU94xldmWCGPQP87IZql+3LI3fPO4Y9FPBjYIGP2+qG7dCMhPcfyDuwaB6SKD6
         KQsSFsRT2CXzCHhpNA/x/58ofbMEpLHa/KrhqVFUjyBJ0/oboGTQdCICm611ysLC+WLy
         hNOOt3/WWAh0JQNmu+sULriupH0b9NGaKV+UYh/fTJK8moZv0R+NmfjvnMwCEsfp+iqV
         Ls6w47GTGzKmAnmR4HV6AiGlDXjvZMKJuPJW5YmWimbveYGRA2P8HGTAltLw01Kk6v1U
         rDVbtc1nPcPY1cx422d7rnp4FnlcvluD7BpcYpVEWa8a9ZTht1gP202UrpcW5gNVDW0h
         XAlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmqKiZ0G6drjO7x9SLk85ZoRoyFFPLuKPnT63VV0Tok9AqIdrawFXAG3YqIw/tlSToFPzw0avz@vger.kernel.org, AJvYcCWAm4N6psCUrH6Xm27ILIn/hR2naXdl7JR12aFN0jsfUoMawEP5r/+B3bJJn+hth1SHv2kxHHtnVvSN+EU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6DsWvWtBDu3xpQmecGwz/NWG4zG+zjZaX9Hc5MOXKsI95GVRZ
	iDyL98XlsUoeeLOlvSIxtWlkfV14SXngKnnb0IWEQ5Yf3lxBfbjdBieP
X-Gm-Gg: ASbGncvx6WCIum1fMoSzD4xUHQbyi2zWs7dxvGNWHqU1OQrcUUPS5+m7JKMOkOzjIMQ
	AG1hG6Ux0tLHdTN5DSktK1ppy8RCL5NOAMh0m7VsdxH/QboLUPlqtj6u0OsJjV6Xu6EkXy6GNAl
	yr1pl1vD6fKRJKTmg7wT6M64pje96IRrwCzaZClvUeJYQYBGVL/3f3Kd6vxtCjqb0cuPqSZmaX6
	L1zZrL2yI4/eTdehmrDyr0ZoQgHSrs6CGHwSCwLZkcf0qvc7o2fCTIecz9VciyAsmxgBwPi0n8x
	/VLqmslobK/UGExHS+yQ04TfH56mUuVyMbuxyX8tAr2IaZe97R7TGDYueNz/EQ==
X-Google-Smtp-Source: AGHT+IGSPxyDMANdKlB+Fn8HNNWASSa2Bs/z9FPJQCG4AKg3SX/aVPdEY48GBHheiKWQtcFs78dyGg==
X-Received: by 2002:a17:907:6d1f:b0:ad8:9c97:c2dc with SMTP id a640c23a62f3a-adb36b23210mr618259566b.15.1748731824303;
        Sat, 31 May 2025 15:50:24 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7ff054sm562918666b.14.2025.05.31.15.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 15:50:24 -0700 (PDT)
From: Zak Kemble <zakkemble@gmail.com>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zak Kemble <zakkemble@gmail.com>
Subject: [PATCH v1 2/2] net: bcmgenet: enable GRO software interrupt coalescing by default
Date: Sat, 31 May 2025 23:48:53 +0100
Message-Id: <20250531224853.1339-3-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531224853.1339-1-zakkemble@gmail.com>
References: <20250531224853.1339-1-zakkemble@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply conservative defaults.

Signed-off-by: Zak Kemble <zakkemble@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index cc9bdd244..4f40f6afe 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3986,6 +3986,8 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
 
+	netdev_sw_irq_coalesce_default_on(dev);
+
 	/* Request the WOL interrupt and advertise suspend if available */
 	priv->wol_irq_disabled = true;
 	if (priv->wol_irq > 0) {
-- 
2.39.5


