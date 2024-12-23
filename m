Return-Path: <netdev+bounces-153982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B5C9FA8D7
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 02:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113FF1885A6A
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 01:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F69417996;
	Mon, 23 Dec 2024 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irxM0OqE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E317BB6;
	Mon, 23 Dec 2024 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734915570; cv=none; b=ouNaTe2R80mFjkGtM8CNY9I9/KFoBIr/VyCvC36T7IO2wmzydUm0BqmDJN7m4vY8GcHJa42NSN7a52p1gE5Jk4SWjWgFGJUhuXGkRZj9Ym+BLuFF77E7df0KGAFhdRbMj1sxxI9v6mHWvlKXBYzpA91ssKRyDaikc8LB14BC6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734915570; c=relaxed/simple;
	bh=khaXCDhZzZW4H8p3un1TOoMjCQqhPUmCFWqDYVBlDbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqaXmmU26+JwFR2Mwax9CFvdxGioGepzf0CVUzryJcBcDfy5u88l7xY1chu3rk1xj8p6pr6AZZMB+P/+CTFwaZBrFIdZXetACJ8V+79VZu+JsPpcdgf3jp3AiBDaYbRLZBRGwVjf6JZwgcSpSJ10zdVqYUgbyKWOEn8DEsqbvf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irxM0OqE; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6ff72ba5aso296097685a.1;
        Sun, 22 Dec 2024 16:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734915568; x=1735520368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiKcNAywK5Cmu1NkwsGA/Qh6M5B4fnjylkQgAEZo09A=;
        b=irxM0OqEeI3A0mNL4iKKebCS12B9a3OV/L1vjVrUFssasadzmaQZ3/sseXTdBl44hr
         9SDOhlkkqY980en7zzICza4DWR6LqzUDPZ3q/45kgi5HcK2fqNiCQYtzE+GLY4qJb/RX
         YMWGTJ7V4j+nudMI+WG76H2peaCqxTS/0jphSj7dghxXsGEomrdIzAGBD5gcP7DrSfz3
         jxSbxNTmDewSeAM/PxkS7xFSLacrhE48/H+a2ZOgP70+YZAWgZvy7mOnKLtByk7ol3uQ
         WIlGx2WJ8hyxaskwnc2jNuqDoBBR/nGvBi3hn9Ldcqwy7TeHyPNElGgXL2ERNBkAXs1Q
         Akzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734915568; x=1735520368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiKcNAywK5Cmu1NkwsGA/Qh6M5B4fnjylkQgAEZo09A=;
        b=q5p3Dfbil82QLZ86YqrhU/u5Y1hElZ7HrFVcTWrLqX7PIt9h+bnSxbeEsnEl0Lyh/r
         +DgT7SCGppVNonXenwIzhBR6e34OPa8ifqB+7cFh4tRPaX6gb4N8js4evw1iXiLDDOqR
         AkzS4ti0cVQfVxHWE2aFZXEjUUVNtdUT+FLFLJMZwRPBNhnrd0PP+5xqhW35SsDrKhf8
         XBX5DNdbVcEnM7C+UzCkj9sEp+1rDSEs3hATt06GQ89XOezSnr1KQrxKZCaNjg1uF6Bt
         flhFZ6DSiAUxDavWgpyxVfyX1yTSLTFwDU4dfml9WzEkEJMEtOCxIoh9yf1NRdOB2E4T
         vIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqLp0Lf4vVrGFLAazSeE6p4P+5a41069NZXEe/F2m5EnlWg4AITP38ZD+IEKI5p2Ti8FR6mtVbXIQrioXv@vger.kernel.org, AJvYcCWvDKVtcuSn0zTy4EYn3liYroEP5k+044s18msejeM5eh4vgFRIJhg6F8+kgKQsdt1YxqIU+Qx9@vger.kernel.org, AJvYcCX6XnoxFJC8X4v9IuQxSaeDbm3XkGip4pvG3UKyUjPSE6vEgRdDhj2LwNBM3Qrz8DnQ45aGWEiYBU4u@vger.kernel.org
X-Gm-Message-State: AOJu0YxsTt6lUuZUPcWo1qMX72+RWW8B8WeD854BbSeAFmqTQR+uB1e6
	3K6mjGaBG1z743l4di8tzQ/knbVG5D75oFbUL2qIVoG/U8Y0UPua
X-Gm-Gg: ASbGncvoV+gCVptjZWBmZRUMLC3HF2PXyAtgBnOZFeapVCtDil2XFtziKXK9eU9xg2o
	wc5c+sYLb+1rMB7u6eudl6sQ9i/fPgDFyMSAGFyr9aDWHyzT4k28wYbSdxTBFhga5N/3vLkqbM2
	8OoRIyxVSLTDlqeWNM1SmLtGQxGnt29yOUAXHWOEk8k/gUwwdsJrEm1ZojjOPeMyIKSfqS7xeje
	ZPE5XoYoLbTd4Z57iaPtFsTOo0Ln+ai
X-Google-Smtp-Source: AGHT+IHmWT1/Ptgcfo0yRcOfYVL7jRnYrWxtKz1ZxEcSoQyLNTugTUWefuWbPDDlyPnGLBEXiIHxDA==
X-Received: by 2002:a05:620a:394a:b0:7b6:d710:2282 with SMTP id af79cd13be357-7b9ba80ebc6mr1941528985a.49.1734915567731;
        Sun, 22 Dec 2024 16:59:27 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bd0b9sm341784485a.23.2024.12.22.16.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 16:59:27 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v3 2/3] net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
Date: Mon, 23 Dec 2024 08:58:38 +0800
Message-ID: <20241223005843.483805-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223005843.483805-1-inochiama@gmail.com>
References: <20241223005843.483805-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "snps,dwmac-5.30a" compatible string for 5.30a version that can avoid
to define some platform data in the glue layer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c   | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3ac32444e492..6ce3e538ce0a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -421,6 +421,17 @@ static void stmmac_remove_config_dt(struct platform_device *pdev,
 	of_node_put(plat->mdio_node);
 }
 
+/* Compatible string array for all gmac4 devices */
+static const char * const stmmac_gmac4_compats[] = {
+	"snps,dwmac-4.00",
+	"snps,dwmac-4.10a",
+	"snps,dwmac-4.20a",
+	"snps,dwmac-5.10a",
+	"snps,dwmac-5.20",
+	"snps,dwmac-5.30a",
+	NULL
+};
+
 /**
  * stmmac_probe_config_dt - parse device-tree driver parameters
  * @pdev: platform_device structure
@@ -552,11 +563,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		plat->pmt = 1;
 	}
 
-	if (of_device_is_compatible(np, "snps,dwmac-4.00") ||
-	    of_device_is_compatible(np, "snps,dwmac-4.10a") ||
-	    of_device_is_compatible(np, "snps,dwmac-4.20a") ||
-	    of_device_is_compatible(np, "snps,dwmac-5.10a") ||
-	    of_device_is_compatible(np, "snps,dwmac-5.20")) {
+	if (of_device_compatible_match(np, stmmac_gmac4_compats)) {
 		plat->has_gmac4 = 1;
 		plat->has_gmac = 0;
 		plat->pmt = 1;
-- 
2.47.1


