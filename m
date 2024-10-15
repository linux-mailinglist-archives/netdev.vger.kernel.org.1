Return-Path: <netdev+bounces-135500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C31999E267
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60355282F81
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69451E32A9;
	Tue, 15 Oct 2024 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1kXUdRI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7D1DE2A9;
	Tue, 15 Oct 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983428; cv=none; b=hAo/0xwuj4chQ8Li2BkXhdFIspqhp6zmdluJirYgMKiCeYy6BAwc4cjbPKoBnjpZBlCv306Ytlwqg7qoofY39uWUimXi/4B5vlVXXHr4zsrGJKhwR6gVWkUSaWqq/UC06uGPIErvddQP9kKLh+Vfyg4yPFmp2vJ0jjZ1st6Sxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983428; c=relaxed/simple;
	bh=8oKBZr1mWk8ADow95X5vh4WaZk6+Y0FMJsQLEeaZHx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R3RlCEOr0L3CbEzggXNc/zgwchhNCoVfuCaXvEWDNmT7IQKjy4CJCUgnYfN9k4oZJDqgEmKdbMiBSmKLyKl8xfNBEnKfIQo+aCXagWiSuIgN6WNX/5cbKDm9ilouR3mX5wZSw3rpyCNQKFlaVCLlKmFzRgNT4O7WlMOHXHgidiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1kXUdRI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ce5e3b116so15113845ad.1;
        Tue, 15 Oct 2024 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728983426; x=1729588226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qC4ITX8vr0WBNue0oHaO5HTmQIFp73nTXTvZqY8X0oE=;
        b=f1kXUdRIRJ/klsAEvhGfklVry91is90sVunpSwEpMs713U/fuIHgbrs7ETZW2UnLUz
         rCe2XLps+DeDI0CAuYhNXXa162UYxICkJJdsCxcrEWKwb8reciC8wmAZKg6zyOiYZHxO
         q28ZQXTfCOZbfzvwXXOrt+S3ZU9revpiFQCLDo0MSJq1xJvSECsdd31P2n6pHVrKOM3d
         iotgV2e1eOFC+smK1S/1ilRRgoC5aDCLZ5d47rCpFDiRnjh+Epi5Q+jBRn4PL8KXTryr
         CYLn7lDx/VuniA/Yt0RhAcufYcTJ2yCORAIScwJz8bLm1DS8yEaaNwehc4vLgpfldLNB
         BkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983426; x=1729588226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qC4ITX8vr0WBNue0oHaO5HTmQIFp73nTXTvZqY8X0oE=;
        b=KfEnp1BlWayKMUTonRUDccbI2qFskEeU/2DgG9HgWyDkiXBAN+JU55OKoY33b+2okS
         gR+cSuSMt9/1FBUkZGgPP0BN7so74sg52s3kmiXDqecpfz5dv51TnCmgiPnX0xcWlEU8
         xAfLwa0rmBqQkrsxkRSkFXIG1t8QYCU/rT+PhVK430KW19s6vPU2L8f0aW7xqmWk8XEZ
         pnw1f4vnMOrAURQG5N4kNzookWUG1ODHg0dMzCHm0+10AFPJdrHiKf/qpMbmP1QQj7lW
         N/51F1xHKHAEQx3muqJ/Xi0Kcx+13p4MRXD9SWlXhndH5m1HoioFZI/WR/CRzNs5iEM0
         v+pw==
X-Forwarded-Encrypted: i=1; AJvYcCWzNiI5QqiAy4b3bQfk3Sgj9+APGBqy4PkqF4+UfkBioXOvvPpBxhDISXE5Wy5jly3PHqD2UjyRATcdRqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAyKZFfQ0T10yakXHgFQB7ZFrzEARCunbgCZm00L22tAsjgoGb
	/4VDToXrjzZkhjCzOvCYlfzohb6pFs6D4F1ebdS+RasvASymzlSggAAn5g==
X-Google-Smtp-Source: AGHT+IFdWqzBaHWfrp76YUJtczY0dt/qtyrIGQByrUQ7U4/m9oSOLWWvisslI/C2kgflrL3/LwZ3uA==
X-Received: by 2002:a17:902:e747:b0:20b:ce88:1b9d with SMTP id d9443c01a7336-20cbb22efb7mr169979085ad.45.1728983426052;
        Tue, 15 Oct 2024 02:10:26 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20d17ec8f35sm7905095ad.0.2024.10.15.02.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:10:25 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 4/5] net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
Date: Tue, 15 Oct 2024 17:09:25 +0800
Message-Id: <4557515b4df0ebe7fb8c1fd8b3725386bf77d1a4.1728980110.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728980110.git.0x1207@gmail.com>
References: <cover.1728980110.git.0x1207@gmail.com>
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
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h   | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 917796293c26..c66fa6040672 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -84,8 +84,8 @@
 #define XGMAC_MCBCQEN			BIT(15)
 #define XGMAC_MCBCQ			GENMASK(11, 8)
 #define XGMAC_MCBCQ_SHIFT		8
-#define XGMAC_RQ			GENMASK(7, 4)
-#define XGMAC_RQ_SHIFT			4
+#define XGMAC_FPRQ			GENMASK(7, 4)
+#define XGMAC_FPRQ_SHIFT		4
 #define XGMAC_UPQ			GENMASK(3, 0)
 #define XGMAC_UPQ_SHIFT			0
 #define XGMAC_RXQ_CTRL2			0x000000a8
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index 0c13d5aee3d2..6060a1d702c6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -332,8 +332,8 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr,
 	}
 
 	value = readl(ioaddr + XGMAC_RXQ_CTRL1);
-	value &= ~XGMAC_RQ;
-	value |= (num_rxq - 1) << XGMAC_RQ_SHIFT;
+	value &= ~XGMAC_FPRQ;
+	value |= (num_rxq - 1) << XGMAC_FPRQ_SHIFT;
 	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
 
 	value = readl(ioaddr + XGMAC_MAC_FPE_CTRL_STS);
-- 
2.34.1


