Return-Path: <netdev+bounces-136869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A629F9A35A5
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 403AAB22C0B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 06:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94FB189F55;
	Fri, 18 Oct 2024 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHahmoS0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A74218A6B4;
	Fri, 18 Oct 2024 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233615; cv=none; b=otNQRqRlc34NPnY5H54xSUaAdQ2D7qkv5DrnDPzNDAx5rVwqhUBNF25VyzJ6TvOuXaAbpNwjSEEfkYElyDCz0JVAA3oejEeqICAdcI3T8et3F3k5EUUP19L4BaQHT9yKj4NeMKn5EuPONUQdCfPs8u9ZMiLGCJIB9McpcrQgQf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233615; c=relaxed/simple;
	bh=OfOrYfAd0F1D8yHmbIEH5qhVEhRVDig94Gm3a2Itddo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDJ2fyIWOuYN9hnz1UOoyr92RoxoSBFW4RreDIWLrq/1GodVkXHoX6mQzmJWvHxaq2/1B8Tkz2wxifV5GMck8rQ+ZGRUZIlqvPwuP/ngX33wAC49LL0QLCjMyq22LYG9958ozSyCjKW5AVSDzrJHCtT6sJczsHi94q1Ym1uGl20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHahmoS0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-207115e3056so13888465ad.2;
        Thu, 17 Oct 2024 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729233613; x=1729838413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEyaQIcaSa5+mb094OvjW2KqzXq/V2wwCSsdaWimUtA=;
        b=AHahmoS07hJgXp4DAZeTEyHJuQ5aqV6fjG/Kh1xQWUj+nFw8Q1DI4UI5zxF9J7Le0k
         LUrWVMrSnaMtcNxYyVKlR5IJhX8APq1ywdhzMwjM5qdbGURs+uMWrLk7kuQB8cINP8qx
         vSyy8yaFkmpbU7p8KZhNC4hS2HR5OTCtDp0P3BHEHf8zcD5zC8POKnj5JQLtbQ1sdIuP
         BhCQz6dWr3DnfFR9VvodX685JWpDzltBFio+rNSAWvpoQdQkv8TFhN0caYk4Qf+1/Pei
         +D267at0kpgmcS5U5jQxr/6nwx0IpPOCRY/HQFdrEo5tOpm0YsChq6tskOVTgtT1t78D
         z3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729233613; x=1729838413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEyaQIcaSa5+mb094OvjW2KqzXq/V2wwCSsdaWimUtA=;
        b=Kx54PyBjIwcaxz8pDjMQBVajvViWwGfEOdBRPjBzsuT2LmWOjlmy5YYayF2h1hnXgd
         d19xEv5gIcQhL5Lk7bKMG1VWuT625WDq2Zudl/Je7gjXW+KQrBTWTkCs3PYOtbO8NLJj
         hy9Qk3J6CT2kBVPCLXDyvr6zJk2fL+r3oeW6MGkqdSFOJIii6Ga+xlk5ZMj8WLytg1Eu
         KX667zWXgFmvFcvjcsCes2Qe+/oWPI+aXJW6fqiL35hjOY2xWxWS0GROnIeClyq0inhc
         fHjIMaKsHiW1jHmVvP/g20uPjLWYzFSCxqeAMzlfnjEpV7O50IbETNd/vhny0i43Mq3c
         Ameg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ8Sp9t+BnXGG+l2Bqvw+2uvaoLT2qY7GYCWz0GRwTTqgJstJzalMlVyqgETF+hUYIunTAAwbK0ly4+ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmpM6Ks4a73XfRs23j8K+0qwBa5yYBOb13IOSam/4ifG6Vq8o9
	QkN0E2wq/k91fU4XmpaPdLiijx8BVVJeKK+nTnc50Nm/X96vZILJtBSMxw==
X-Google-Smtp-Source: AGHT+IGOxD5tfJSh2f087iD/w7KV+RKu1IaYQSlM8m+sKzV2CR4NX/4iBMMPRNAoT4F+qgJB9qds/A==
X-Received: by 2002:a17:902:cf11:b0:20c:bb35:dae2 with SMTP id d9443c01a7336-20e5a89fbdbmr18335085ad.28.1729233612791;
        Thu, 17 Oct 2024 23:40:12 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e5a74766fsm6285455ad.73.2024.10.17.23.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 23:40:12 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2 5/8] net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
Date: Fri, 18 Oct 2024 14:39:11 +0800
Message-Id: <c22faea09a3f240a84ee9e7f95329d860134d832.1729233020.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729233020.git.0x1207@gmail.com>
References: <cover.1729233020.git.0x1207@gmail.com>
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
index 8ac9aff101e8..9245e360109f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -372,8 +372,8 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr,
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


