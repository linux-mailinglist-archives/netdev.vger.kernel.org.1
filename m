Return-Path: <netdev+bounces-186424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AE7A9F13A
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F803B54DF
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C93F26A1AA;
	Mon, 28 Apr 2025 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U08sda4i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC82269D13;
	Mon, 28 Apr 2025 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844211; cv=none; b=Y9OUQeifvf5IcE5igOhYVpenc9tplasPeLEob7YDyZRiw7iUT2oyr+5bS24xXmtOPRyzM+VtWoBI9l417g1t/qgvElNu8WVihGGXOq81NJ6kvJosuQkkkEDnhQMe9FTI1T6Mb5aCDN/N24t/RBmQP9m2w1iea02tVoPGo4eZt8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844211; c=relaxed/simple;
	bh=jeflkGq0qH8lOe08zXAdTH5Cb0fn+LVq1YaHKvNXQdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pUkJjoibMl81+q+hBT3Xa/4WOkrvgbfpd1KEFiQ8fRAOAwHxsn+9C6gcwchf7zjDjLXkkJqfcQjGlJ/y2RPuSQPNusX+HbUlPtV7zboKhU4DgDCNEUi76tXjrsrdWoLSBAae//cndDwHDVck5xfL3wbbRCiIf58dMvAnLJao0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U08sda4i; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ace98258d4bso257892066b.1;
        Mon, 28 Apr 2025 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745844208; x=1746449008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Fw4xjFZAdBbyC0mRULT4rScVCberjFeCCRxE4Hm2z8=;
        b=U08sda4iM+Kq4IA6MLrIYB1y49wh8IF2oulTxTZ8PblhOEBufobvNYQdq0A7l4DNaf
         s4QSxlFdiUtYJz+jXQNyXvZZuDiMDFmdAeAf2E/3QYWztdoyzs0tqmRSt2h+QC4tvmzS
         rzdNuxLbzcw3XlkzMMFoJksWRUNcx7nslRhOPfxFgbd41I7CzIPXWoWmYdKqZlKsrFHR
         nlmrRdbc2qXiGlFBMFAxtHpxiTxzTsx8D6x219lA1EgHsYCZe6dm6pA5PottSbXunAYP
         vOBD+Oyp1aGCbxww9H5JiUxnbklWwghdGzIcidUEXI+g2FzGzhOFoUPYHu5xhme0b0Y0
         dBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745844208; x=1746449008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Fw4xjFZAdBbyC0mRULT4rScVCberjFeCCRxE4Hm2z8=;
        b=HWsAdWMKpPbLgCpKmX/dPXKAl9VI26OINQmNW6XC4s8FpJNi5kTvmHti0wAMSn/yp1
         ZLhpFgH6p7R0a2iY15FteCO7dqtym/5RBd0+5VZJi20BtnCyK+rhXFQCQ4L6ti7U9RKg
         ZgHmsaA5/PcNNQWpuKuFt2aZQrCrEeDB1Tc7fzv8hvNvhVUCwZozrGng16YzdpwOQgGx
         wnjkrr4oYOLPguW6GvWPjVPC/BIvPoRyGbke4zgX+vwe0TQgGLCapLZD5Lp7bX9NbQCK
         Douzg4wjF6b1uRNjlzmk5NEcLUXonsRt/ac3nOEuG1j4lEjejo/5E3yJnCKoaYpR45FQ
         gNQw==
X-Forwarded-Encrypted: i=1; AJvYcCVDI5OxXruN6c9dpMI5BgiG1cBQCRtSz5/90VYgUxkiRkBfrApSDF0RkgVv/BM1TpjJY81rrvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQoX6V/wU714aWRhzCv6O4PpERYu0w7rTMt8gA1n12+Xsh2dEd
	1idivRgLEH4GS5FEoMF87FmgD2LDG/MVFVdXbbt/l591N53NNde7
X-Gm-Gg: ASbGnctd6y/gbcbVmlDagWkjKp3hT9RsCPYuFqLWRg1gGaOiufd5Uv2kM5Ruu4YBsrN
	Q2f2fCrjcr3JjX81VtVrqzzijQei98/k9PyVQO17bT+QqeFvrKfCoqZLFxQ1AH0bJ1vRUgsNeoS
	8ljLrgC7q139EBg728YmiSBaDmEJtVjMcC1M/WnkTDmloG7jBjJX1Vs/Ml52Tl5vla7dnt7D/7Q
	cxb+2xbopdIQ/6BBor79p/XFLXMODYkV6OGdHFM/3HWsY7P/loAIfDfsKyZuXwMJJ/yc6tjOSOr
	ocJP2Wcgy7JBoHXlPbLuefmphTu8V5jzQar33vvLu668YnA5lnJjzP6G8/G6Fxzaxg1Vc5issJZ
	6CAd0b6bZFHAC2KnZ0yYscEBNd4zc+JKfI84wB+Q=
X-Google-Smtp-Source: AGHT+IFJSHrQicUVJ6dGBM1gDE1RCAw4pY3X1ZN+DcWAqr2PYeHzmYlfdVLDP1UCRQ33N5sNaKwIFw==
X-Received: by 2002:a17:907:1c1b:b0:ac2:a50a:51ad with SMTP id a640c23a62f3a-ace7108a180mr1098319066b.14.1745844207695;
        Mon, 28 Apr 2025 05:43:27 -0700 (PDT)
Received: from titan.emea.group.atlascopco.com (static-212-247-106-195.cust.tele2.se. [212.247.106.195])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41bbdesm633804866b.11.2025.04.28.05.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 05:43:27 -0700 (PDT)
From: mattiasbarthel@gmail.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wei.fang@nxp.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mattias Barthel <mattias.barthel@atlascopco.com>
Subject: [PATCH net] fec: Workaround for ERR007885 on fec_enet_txq_submit_skb()
Date: Mon, 28 Apr 2025 14:43:25 +0200
Message-ID: <20250428124325.3060105-1-mattiasbarthel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mattias Barthel <mattias.barthel@atlascopco.com>

Activate workaround also in fec_enet_txq_submit_skb()
when TSO is not enbabled.

Errata: ERR007885
Symptoms: NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out

related 37d6017b84f7:
("net: fec: Workaround for imx6sx enet tx hang when enable three queues")

Fixes: 53bb20d1faba ("net: fec: add variable reg_desc_active to speed things up")
Signed-off-by: Mattias Barthel <mattias.barthel@atlascopco.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a86cfebedaa8..17e9bddb9ddd 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -714,7 +714,12 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	writel(0, txq->bd.reg_desc_active);
+	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active))
+		writel(0, txq->bd.reg_desc_active);
 
 	return 0;
 }
-- 
2.43.0


