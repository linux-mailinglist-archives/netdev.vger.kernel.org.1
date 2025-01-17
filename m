Return-Path: <netdev+bounces-159350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C266A15345
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF91116870A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585EE19AD93;
	Fri, 17 Jan 2025 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyZbw8lZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80599199FC9;
	Fri, 17 Jan 2025 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129218; cv=none; b=WQYHlUdfWjUPhnzKs+beE+PgLlELTiKMawdTbBavnC+3NQrnjS0b1llf52C5QhnfwUPSE+6KnKm8fh3TeVQ1/ZnIgBY86+6B7f+Mpxv60zlLRJ7qFZDJR/pIaA+hyVOPY3Qwqdu9UMolmYULp5G+QTE+OBBHX2dFFzN7PO+ETyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129218; c=relaxed/simple;
	bh=Pv6zZL/UEQpCe6YCTZ2hC46zbBmDK/Nb+Njxgibtc3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ErwLXcJqgDC/VejRuhJ8fmITitfUc28np08Tey6GDkK0bYFS73VWWO8dkX3og5pxC+tGB2bBWUEaIyydSIkNHluUizhe/YRze7SZKE9u/vvAyemS2JY0CNs1aabKmyQEJgPIJOcGqKUWytho5DnJtly5UBOFBLVNaJwOJ0zDKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyZbw8lZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3862d6d5765so1332611f8f.3;
        Fri, 17 Jan 2025 07:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737129215; x=1737734015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pWEO4mXmrgX9A+rahUTkZPxpsEQKDRWEFh1XmmPE8bg=;
        b=kyZbw8lZa8EqMhbOWGiUPMT/ffHePnXW0Z6LL6UvJCi1vhiHu4OWOb71fn0dlG5UD0
         G4ImD4vLrLcNG/Th62LnN/DQ/7v6bYl83KLkC33UE2Lxo76u5u3dVh0CmFD6xRIFIpz+
         4n5Zz6hhoHaYGqFhb+MjROgFCv8GvCvAKgo4IChVt0WsE3fs2SaLsx552B2vX31tp5qo
         UTSYL53r8crtHMq2m6/1U5HfCvdsZAIVuIulnTGyuqfcMojsZlA1Sr916SKrxOTOVa64
         +8lkl18nd2YLo+wkW3r150JKgXOyMEPWKVdLBA0DuAddxzqrjFj9bh5Ea4Cll9PEi3zb
         hAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737129215; x=1737734015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWEO4mXmrgX9A+rahUTkZPxpsEQKDRWEFh1XmmPE8bg=;
        b=NxmY4whcvftWrnMbENinEsZKfBDifJpfKK9nuKjwUoj/FRUCpv5YLzq2B5YEKKvepF
         KdsNyh6GcH/7KZBb8eH1fq1RtFQCcVyd426yQxS7+/Aega1xhb/jXyW6T2IGVKcOkk2i
         KD/MzuVDFD8MQw2U5XWC70PMUsgC5/yFPH3AHxfOyHcjQ1FPnsKyV0KzqPGpmBL9Zb68
         XXBJghF1aU/7UIqes5FC7RfXiVrJJefTYfj/AqIrmXuh7dep3FBZ3ATf8oOSw1DvGeAf
         3kH/TNg+q/GfDstyCf+Mhmo29EEnufJctlr3HywAH8bz9j40ULoHuTA+bfXKPZeVa2qu
         Mc6g==
X-Forwarded-Encrypted: i=1; AJvYcCVkJqQpuwBgm9S48vATAh0GvaL43tQtsf4ryMr34Gs1h3t4omh0K+jryh3zYGH4qsuD6JrGkiMm@vger.kernel.org, AJvYcCWocC5ULY4M0lPUW7FYy8ZuNvPCYZu/0iXCO8iirjagkoGmniImthK7HltP4I84tx2F/yUekzQ7p3yjk2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXGkOcS8k15Z3xzIRKGffC3p+Xy6VdPIj050/m37M1doKp3ZC
	js9nzWCsgFLe2hmOaR1yP9+sNsPXgg3NQtwDI9kDbctmRrSqFf/p
X-Gm-Gg: ASbGncspOASoASSgJMLzAVpBIed8js0eKLc+VKO/LaYasHFqNfJo8aGRSUWUOiQJdxi
	0MgsRMB3x7ZL596EofOM19jjlLUS5rXlhAwg96Od8ws2AVZzGeE9C8ZgM2NA69g8DMvnAVMM1Gs
	X3rzeA9HC34xbv1P6TPjeX75Ddr0Qg7G8a7wFzxNLMb9toDQeD0ac3Sz74ZFHAbQ+lPmQg+GmFq
	985ZLnuvJO1lGEoo1BSDhbbudWndmrbjXXe3mzYxihCNVCvb2rpnySbYePEiLU0MYqPg55vZN8d
	kYOT+Ehkb1nveiyd4ZmCVy22Lg==
X-Google-Smtp-Source: AGHT+IGNGiONpxV+GF6eyRmRWscmpLkuIBdAedL5zi2YGx6prpKmmwhZLampYCznTsZBL5ObecUgjg==
X-Received: by 2002:a5d:5848:0:b0:38b:dbf0:34f2 with SMTP id ffacd0b85a97d-38bf59f03c7mr3119509f8f.52.1737129214512;
        Fri, 17 Jan 2025 07:53:34 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38bf32758dbsm2854779f8f.64.2025.01.17.07.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 07:53:34 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net PATCH] net: airoha: Fix wrong GDM4 register definition
Date: Fri, 17 Jan 2025 16:52:39 +0100
Message-ID: <20250117155257.19263-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix wrong GDM4 register definition, in Airoha SDK GDM4 is defined at
offset 0x2400 but this doesn't make sense as it does conflict with the
CDM4 that is in the same location.

Following the pattern where each GDM base is at the FWD_CFG, currently
GDM4 base offset is set to 0x2500. This is correct but REG_GDM4_FWD_CFG
and REG_GDM4_SRC_PORT_SET are still using the SDK reference with the
0x2400 offset. Fix these 2 define by subtracting 0x100 to each register
to reflect the real address location.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/mediatek/airoha_regs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_regs.h b/drivers/net/ethernet/mediatek/airoha_regs.h
index e448b66b5334..30c96f679735 100644
--- a/drivers/net/ethernet/mediatek/airoha_regs.h
+++ b/drivers/net/ethernet/mediatek/airoha_regs.h
@@ -249,11 +249,11 @@
 #define REG_GDM3_FWD_CFG		GDM3_BASE
 #define GDM3_PAD_EN_MASK		BIT(28)
 
-#define REG_GDM4_FWD_CFG		(GDM4_BASE + 0x100)
+#define REG_GDM4_FWD_CFG		GDM4_BASE
 #define GDM4_PAD_EN_MASK		BIT(28)
 #define GDM4_SPORT_OFFSET0_MASK		GENMASK(11, 8)
 
-#define REG_GDM4_SRC_PORT_SET		(GDM4_BASE + 0x33c)
+#define REG_GDM4_SRC_PORT_SET		(GDM4_BASE + 0x23c)
 #define GDM4_SPORT_OFF2_MASK		GENMASK(19, 16)
 #define GDM4_SPORT_OFF1_MASK		GENMASK(15, 12)
 #define GDM4_SPORT_OFF0_MASK		GENMASK(11, 8)
-- 
2.47.1


