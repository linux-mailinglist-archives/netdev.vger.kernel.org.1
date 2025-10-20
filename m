Return-Path: <netdev+bounces-230871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1C1BF0C29
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE99189FE16
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5084C2FCBF5;
	Mon, 20 Oct 2025 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMZmj06c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CE12FBDF3
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958709; cv=none; b=a9H4QC/kcqUN7ZxRnmoNSP+djDVAI9E/qmy9tBVZJm1RAsLSY3Fj4UOkxENpAFCgWRWU16PHc0ljqiIXXC2cgEoEbvX7O1sAAI6kV25ZLM3Sqx2aKlyQLsUjRFH87KjZ7x5XNk45rzView/+z/c5zec9nrOt9x2zd3YjZ6Wv2GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958709; c=relaxed/simple;
	bh=u3O5/Vnm1zd6rOBSlXUrvnWCu5VwPjHgeRbcIJf/UzQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuYaT7/WIPA0xg5/jAdynBJmTPQwbLnHu50oTdtOaG2YXxkfqAfgvPofrgbCcTL9+T5tFg2qGv9Wdu9vum865xaiOzQbvb7M/ZsLo2uQOmG+ZbetHE0sLm5pLCL9NzTOZ/8BruE+zNZ6xcM/3ow6cyafYQyxvqlAypGn49oks0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMZmj06c; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso31510025e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 04:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760958704; x=1761563504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mh4C9N1Ju5JAAtnjcdgue8CazsWnd2rnlhBAUlc6beo=;
        b=cMZmj06cksMOVk/z5IiLs7k6X6gUa1PwL82OjpUT4xRT9f7hXVUhyQb+KUdjiUCBLM
         PfyaSbR3sDBf8tyZSE2/4q6ETeG3acjfG7Luc+ETjZ+fNVSRrWTIxiv33zNzRzZJl0v3
         pX2o+YBEfb5QHUFImR98O56uNIzYWnCZxZc9DEgpW+C/ecrzOVn2W87Xx41+fk3Di5Fy
         2wJSp7SX8VePaTQBkTU4IARiMgBIG5VO4aUpw1QbVCt7tg3DXolG6cYMyJXIdx8rVD4M
         FBJXBjBE8od+hFEOA+c48qN/MklgtUxqP8lA2hR+98PYG2b/ESewvObGTh/WKKGtoNWe
         +3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958704; x=1761563504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mh4C9N1Ju5JAAtnjcdgue8CazsWnd2rnlhBAUlc6beo=;
        b=K3rrUxOQnm270e+ZA+Gsq2Sf+OaI26lcqJmjkl8JBwkmtnrLot2EQlgZcA4/DgSxnF
         I+ZrkpFZqCwP/JLYAD06W6ftGG4tBLufNjc5MsT+Tpi9ozEzlr6wx0xRJbhKM0oVZtqO
         QROYuikRV5jSHxOvxp/m6/0xUHlDj7DTbxdbUN09YWpvN2YgzHRZzytIIScW5ongXhD0
         9LFq+dJaEaOoTJAJCOSI76hSGAdkbMpS48gwTXmqE3ClRnS7RQFnBWhY3pccouxZoAF5
         nefgSGftC7hT8jj6KQX8+puHnvrGoy+YG/LIExNVQgiRw5SmiRUEh2jocTZFf7z4F/EF
         a6GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNAAF6UBDnxZpV7vNNkza88YMBhv8kZSnQImYb/B07QRdzWKzosJkxoITVgdYD7a4ykLXWdBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrINQI/EY1JIaUKIfga9q8XYDY+tKcMPL6+MhSFEQNIm5fU2BZ
	waQ7447AF7w89vJAuz9NSIotxJIX2G7jWosFKrJuf+E8ur8N2WhKwo7s
X-Gm-Gg: ASbGncs5yH2uNdijq3ClotWvTG81ktQrO4B9AYZtohTFyJKJ3OTcji5Rg/wgGqn+pvq
	jhfOgZqE1mX4l/m8o7/VvS5KD4Xfozty/bhBo58vwR/b1V//1qIlgfDBnRUTNURHvH2v+E+yX9T
	nLEawFbGP1g2ovHhSU0snNIqLKZPgUnID8Z5v2h3UsQkc1vF2d3Kht17dpxMzKsBnEp7LOlM4YW
	lYebNClRU9JoRhsYMEzNpOivyK87GyROBMKjriwxlQwffLShGopUV+OJC9+dqDv45tWTo+8NRBu
	NIP1tyY7To7JIDeUnDYRSIG0bwluNiL3CEYaL55kJP2Aqz7mkVLL4sn2IH/4KrAdzRzWR6vqRTt
	+KjRY6vj1cEMRFE8mjWZH+qXsdlTtW/jCMsKnY50Grpv1NF3HnZIr4pGK6Nq9GcpmASggxOhmq0
	/lnTMcYoM2skVegcp0gsukXxBJkLJDAjMR1KdVwn2d72U=
X-Google-Smtp-Source: AGHT+IEC/EgoEzWLSutjjbvP1mXzMKOilW3J4zLO71+sEvQNi3rD9SLIUZ1bssHJ/V0ea3felgXDhA==
X-Received: by 2002:a05:600c:1e06:b0:46f:b43a:aeee with SMTP id 5b1f17b1804b1-4711792089emr93643585e9.39.1760958704255;
        Mon, 20 Oct 2025 04:11:44 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4283e7804f4sm12692219f8f.10.2025.10.20.04.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:11:43 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v6 4/5] PCI: mediatek: Use generic MACRO for TPVPERL delay
Date: Mon, 20 Oct 2025 13:11:08 +0200
Message-ID: <20251020111121.31779-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020111121.31779-1-ansuelsmth@gmail.com>
References: <20251020111121.31779-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the generic PCIe MACRO for TPVPERL delay to wait for clock and power
stabilization after PERST# Signal instead of the raw value of 100 ms.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index cbffa3156da1..313da61a0b8a 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -697,12 +697,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	 */
 	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
 
-	/*
-	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
-	 * 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
-	 * be delayed 100ms (TPVPERL) for the power and clock to become stable.
-	 */
-	msleep(100);
+	msleep(PCIE_T_PVPERL_MS);
 
 	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
 	val = readl(port->base + PCIE_RST_CTRL);
-- 
2.51.0


