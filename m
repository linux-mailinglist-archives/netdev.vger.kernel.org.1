Return-Path: <netdev+bounces-188284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E07AABFAD
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4E84E5C6D
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A03278E4A;
	Tue,  6 May 2025 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoD6XcdP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67080278770;
	Tue,  6 May 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524010; cv=none; b=lpEQJuXQRovcx0mEViPpNy0eFcX1Lp2DwODLMR00eedrMQznNAuC3LdxL4kWwbs52Eq3rldvprFxF3PiKjCLyuERGi4+I9lKR1tLSRc20CnZDSiaqaO0SSoVyDMlQTVKu9JZUOuGCL0Hhe1nKG9G2ADqBvQ1yrePaGj9dvG2QOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524010; c=relaxed/simple;
	bh=YVsXPN6IEiX2cI9KuGIy9pGdPaxV/V3RMgTbI0KVoqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1/M+xqZGZgxuACmCtpzKhixpyzlNPbxGYC/vyTUPwf8vSPAIqFnirZ1HO5Rnlw6dfs4jH227ACQ5hec12ZO3oPws1b3PQ2AC8+FWRUpprqt8Lh4cqYQHR/FChIdlNQzpfIa5Fe0QKlcHixCd1d8TuA+f5crqFcSDwNuLWpaXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoD6XcdP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c7913bab2cso580359385a.0;
        Tue, 06 May 2025 02:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746524008; x=1747128808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUQlHE3WV+AglG3E1dueIGqmAdWvRG/aDbQh6p9Pats=;
        b=MoD6XcdPUIOze6mog7Ya7Pt6w5NYerQ/YmttgsJ5nnY9IC9v2ek++6YVbFSprmZB7O
         ap3kmwi/6KtcmuaEfQSY+fObDUn8g6tSErzpaTtnTBBpXHzVM5uzZGMNDNXRZxtIM7uF
         zzmcXW8edz0wa6XThNEtdIaTPL/mrK39iIWwf4MtQuDpAEAblN0DhpnTWLFr1HLOqB8h
         ziJftzdBUbepMze8emGPVYIWjK+BMcowR5eu36zBBT1uivwvOPUvQeQbw4cJDIW/T669
         PqhXjJXOYUFJxNjB+YEXGOJCkj+yN1XwcW2t41vJcyQDUhxkA/j1qS/6P786TDycSE4w
         zhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746524008; x=1747128808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUQlHE3WV+AglG3E1dueIGqmAdWvRG/aDbQh6p9Pats=;
        b=McpYF5wm7t+pCFJaknLKF5bXyYSOcEHpC/HQTeWroOOls8QZ63vRs9p5OsPKsAuonx
         mUCzz2gQic+an9BiqbJShJa2wALCNx4HT5+O0Am8FDFqc08MoWCuNhNt7GrUd2AYQzh9
         rxR4MRO7w/nzw05ad+ePU9Czmgvfd5Pio8p3gRsT5UKNlqVme/8gcru3n46v7fTnN2dg
         g1dKyqn6I2trFNPoQY5xmCxp/T0OweKjltBvesHEmbUw5SP05GqlcNKlnTi7vViO/fNI
         gCz9rU73dqZtkZw0vjVbOM1s/Dl2z1PeNWTJBUjYtCiwSnFJHEaU1XSXW0hjxLv3Ga/J
         BRzg==
X-Forwarded-Encrypted: i=1; AJvYcCUxutoamgy8+VImQ+tY563sE6Qte53VXMNX/bIAOcG4ppvcQeAkZVp4Fx40RyiA7mKUndGct/C/g6A/rWBn@vger.kernel.org, AJvYcCXpTa19m1jwwWsRAAORsXxPrs3KMqjR3xf7mOkg2pAUifACebYl27dus0Qfl+Vel06dNgOgCHNGyspG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/EZA8gi54PDOdeGrtXv+PP93BDl89sfZnIpM3hpOLQdaylVjf
	VngmurW9BZ6EhSDyQ/yvwT0UWOhHbc8FlaXbFx2NpB7RCB1VY7Xg
X-Gm-Gg: ASbGncvLeSEXlqpC3MaMZMLhfpBDlsv3IN0sTaRBLL9TBv8J6EI7d5DxHw5vPIr91z6
	w1ls1HD9Y9EQ4rBXySYQrti7HzWbMaRnA6HpxapJiPAtnVqdKa7nd0gqUtwgGivuoxeHlWC4Q0p
	iw/SrT+XEdqSmKXnqguAos5XyfnCd8opnLodJ/5iKvjWAO3S+Tr2g6Nf4h8Twe3Z7VO3iDtiOUO
	wcFYjO3rNISiqoMy3ExiK2jeI9bFidCKD4erKu7HLTG/jIVnTLAzmFbZwaikcVcPXqFezRnl/zR
	QUWgJ8KKJ1oqIXnY
X-Google-Smtp-Source: AGHT+IH3VqzXlInrKha6VmM4WZWfAGkLbfKCYjNCx8kJZ1aXhqv2kgptMAcRo1MHkN1XMG29piZ9jA==
X-Received: by 2002:a05:620a:2549:b0:7c5:5d4b:e63c with SMTP id af79cd13be357-7caf09d2a28mr363658985a.47.1746524008194;
        Tue, 06 May 2025 02:33:28 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cad24501f1sm685744385a.114.2025.05.06.02.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 02:33:27 -0700 (PDT)
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
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Guo Ren <guoren@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Subject: [PATCH net-next 2/4] net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC
Date: Tue,  6 May 2025 17:32:52 +0800
Message-ID: <20250506093256.1107770-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506093256.1107770-1-inochiama@gmail.com>
References: <20250506093256.1107770-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds device id of the ethernet controller on the Sophgo SG2042 SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
index 3303784cbbf8..3b7947a7a7ba 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
@@ -54,6 +54,7 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sophgo_dwmac_match[] = {
+	{ .compatible = "sophgo,sg2042-dwmac" },
 	{ .compatible = "sophgo,sg2044-dwmac" },
 	{ /* sentinel */ }
 };
-- 
2.49.0


