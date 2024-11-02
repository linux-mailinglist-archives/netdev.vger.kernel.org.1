Return-Path: <netdev+bounces-141191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7885C9B9F70
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 12:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245B71F21724
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC65C189B88;
	Sat,  2 Nov 2024 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq791G/S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B7189503;
	Sat,  2 Nov 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547692; cv=none; b=eqktIwH/+g70NbLhKv0gfjqVUCc9pKsgKWr8hdHKmG0Q07JTwec2Az42ZAazMNtivX0x6N9vqgexqBLWr/UnHVk3RX72qofOWq4tMC20qZPKyddwrGX8u2M6NuP2gop6MdQoQG+OomCsDnZ5eqBrhHAvvIhxXECEafVuXmdj/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547692; c=relaxed/simple;
	bh=0ivyOWSMuN04hx690fkFnG9FrNgorExHe8dOkrPkXcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oA9Tyd2Y+pn1w4mgh4ACtoPoBXxsrNwRD1xR7i627Pdh4JXTHa3LIsSQMd3bo6+XSXmZvJuxNbUkMjgOp2+mYEvwMbShnvRokHLmboGaOJETKZMkJAFDGQESc2KkjgzzkmsRknvo2xegUwsrVnSarjjRcZY8RPnYKwD3C94q4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq791G/S; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99f9fa66fdso53817466b.0;
        Sat, 02 Nov 2024 04:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730547689; x=1731152489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=169hA00Pja97h8hm6emVe3dB6p5nrMbDMRco0sdU1HI=;
        b=Yq791G/SlZIHl2aAV5RvuQoO7JGDy1yppFwdIsiZdNLWnTWez06CXs7uS1LZFcJyiH
         cS0FEoPhNIWpM3P8CpFVteVovxgJ1tflGycXDD84llASHFbeULDmocwwFt3UEwKUSxef
         B3DwOIoefKmzmqWZQzS8kg5Bkijnz6pEdBLtFGme5EOyPxYoatiLAmlD+A0lhGyrRPQU
         bwZbm0rrQr3Z1j3RKU09vrOwPjZCa//z5dd/ICJDcRCVDv6v0jxix6Nyuy6NnSnG5JxB
         /ftoTMNPle+J5mZX/S4+cMhIbcVG9xZouzfMhC3Im86PV67ONs4czgQw6unF9wDUrT/G
         gZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730547689; x=1731152489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=169hA00Pja97h8hm6emVe3dB6p5nrMbDMRco0sdU1HI=;
        b=Z3eTf19nsKjkJSddS+67eAzltIaMLz4kdHh8lgXYdeV/kWkPdpGgPjSHsW4APdPD5x
         EhRMvLH1clg5SICQlhh/Tyh93sOx6uFE9pqkKudn3kVSxq32DVeyNk3cXoEJmC8HCeeK
         5Nqn31fdPq1vn9XcdsskBG9blVosAZYyhPaV83D6mfPAHsfSFg1782ZGCEkN81oznFNZ
         IwuuGwJU0igjOddwspcQ56TOy7SBC7ZpEgF1OJaCIHnMKF46e+mxO1oaUWQXyJ2dTRc4
         PCUxuVK3v7o9wZo6MzbFsvIwf0vbBmng8Qvp5gAGq2GYAH9wmvUklXctz/g9Hq5D2x2c
         T1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU92EOLPNpgNwcNOce8KrUt9muPoaIQNPbtT555Lgcw16cHsLuFggnWgptJjSmY1hfbl7KeD4AL@vger.kernel.org, AJvYcCW06e8JjUITf7iPZ8523uiy3FhkR1JctsLx7zuLE/7iX+cmvafTf0Pr6klDa6ftZb4RldJx0jkMt+samkDC@vger.kernel.org, AJvYcCXjvwRflbepdHxddo8dTUMhMJLwzsp77J6/zlAb43xrpQHQpisayWF5kArUOn7tNaFwv+PBR5iqJ7kW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6xe3ulXfP3JE652TbbAHm2I9kSZv3l4xH/16mSW3dbcQRQjcU
	wtpVCxJSow/AplpFdIyo+qRD3JujOIDeuUoWg7C9tGgbJ0IJ9Pm8
X-Google-Smtp-Source: AGHT+IEt4AjndCEebm/9RILvfW4GXYybZJT+5m7LenNVoAJdiLHQQZg3Dh2A1hqqQqIhTQOPSDbaYQ==
X-Received: by 2002:a05:6402:34c9:b0:5ce:cfed:624 with SMTP id 4fb4d7f45d1cf-5cecfed3330mr136549a12.0.1730547689088;
        Sat, 02 Nov 2024 04:41:29 -0700 (PDT)
Received: from 1bb4c87f881f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceb11a7aaasm2224918a12.83.2024.11.02.04.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:41:28 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	kuba@kernel.org
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peppe.cavallaro@st.com,
	devicetree@vger.kernel.org,
	l.rubusch@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] net: stmmac: add support for dwmac 3.72a
Date: Sat,  2 Nov 2024 11:41:21 +0000
Message-Id: <20241102114122.4631-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241102114122.4631-1-l.rubusch@gmail.com>
References: <20241102114122.4631-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dwmac 3.72a is an ip version that can be found on Intel/Altera Arria10
SoCs. Going by the hardware features "snps,multicast-filter-bins" and
"snps,perfect-filter-entries" shall be supported. Thus add a
compatibility flag, and extend coverage of the driver for the 3.72a.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c   | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index 598eff926..b9218c07e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -56,6 +56,7 @@ static const struct of_device_id dwmac_generic_match[] = {
 	{ .compatible = "snps,dwmac-3.610"},
 	{ .compatible = "snps,dwmac-3.70a"},
 	{ .compatible = "snps,dwmac-3.710"},
+	{ .compatible = "snps,dwmac-3.72a"},
 	{ .compatible = "snps,dwmac-4.00"},
 	{ .compatible = "snps,dwmac-4.10a"},
 	{ .compatible = "snps,dwmac"},
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 54797edc9..e7e2d6c20 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -522,6 +522,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	if (of_device_is_compatible(np, "st,spear600-gmac") ||
 		of_device_is_compatible(np, "snps,dwmac-3.50a") ||
 		of_device_is_compatible(np, "snps,dwmac-3.70a") ||
+		of_device_is_compatible(np, "snps,dwmac-3.72a") ||
 		of_device_is_compatible(np, "snps,dwmac")) {
 		/* Note that the max-frame-size parameter as defined in the
 		 * ePAPR v1.1 spec is defined as max-frame-size, it's
-- 
2.39.2


