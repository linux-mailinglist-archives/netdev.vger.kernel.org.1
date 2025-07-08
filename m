Return-Path: <netdev+bounces-204821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9756EAFC2F2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63EF07AA189
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721CC22837F;
	Tue,  8 Jul 2025 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aflmAIw3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B652264C5;
	Tue,  8 Jul 2025 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956872; cv=none; b=nBvtmD3m5anfdN6YB39Nm5xh05wvy3YdTisE+V/dgs1hnr0v4vhWnc6hn3PO1kICm4vKmyzvzPN+9ZuafaiPcskJ2wvvrPz6Ay432n+JV5qIcmoS9NlvTLVDMY4+b6tnOyhL1HgPs4qWuhewxq1ajBgVRZFyAY2Hq3h48epfmN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956872; c=relaxed/simple;
	bh=oahrj+cAhI+XuKeAaCx2jkbVB+ACE3JA0NODR/XArhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeQBP6YAz0QVCm8/riGxiIArPlz8fuxTid6qhcBQw94W0IXHaIicS6akGDCq/axJkiEXOdUx+vqiw4cCmMYk+kVmleghLLn7jaEZAA+MW8k7folmVCIHDy5AMB4cBX2zN4iFgLAhxwsmUYR281gBbaPOFK6STBj9EwQsdYaoj9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aflmAIw3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so2943077a12.3;
        Mon, 07 Jul 2025 23:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751956870; x=1752561670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLiBq2WXDjQXd+fjZ92LJ4ai9vU68aXWw+t+C2oy52I=;
        b=aflmAIw38br9w0rmqAZ9Vp+rtOrw10fwPfVlcCBO6LedlcAsJMdpmtERkOWfc+0/5L
         BrilMRwh8MS+kNDxcfWPm2Cpd3IKdfsHHp5DzHwQ/gFI30QpKNUOpO0+UqY5WrhQDapx
         1e3X7UMt50r3z3gZZ8F8EG/U9js9Urq3zDjCoJfAD6dvNBJil38iZl+YAWyDG8ViehtV
         +neiXAz4cUDUKm2ZdYnPkFdFOkO6qTOQoyOIKFXAdYxq8K7n7dv3zHs9b7+nxLfJzq6n
         SC4mYtMoLw47MNdTz79wudR7zrP06jAx9u6/8ZtrRSGNYhD3eaEjv+Iv4MfcER8oyFWc
         MTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956870; x=1752561670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLiBq2WXDjQXd+fjZ92LJ4ai9vU68aXWw+t+C2oy52I=;
        b=Ox11EIRk/HiZpdjrHh/nCijciYLkMbcfsbZq8oeVuHfvkowfJcOk+NjgLmpFJ8QooB
         jzhMvmLPEMVlRnaX+iCfO+BnjUTX6Akjr/mTV2gXruObrTVHKz28/JxqWgZCwDcIhoq0
         eUyqqHwAcAzQCqAudFbA7X44lk4EEmXgvAWc/qSiHBVvR25dDJS0nM61AeuW6FPgVvxF
         rqmVzvRQdtToilug/tbXJaFYx+L2BOcvDf/Tf4Zv/sRvqcMk5eHssmmCysoQqXhBPJeK
         tArOQhA//IpqeCivoh2jTHqKMu0j1DqeN16METd4Gio4mtqhWB9frlcPKia91vHzPE3U
         fQZg==
X-Forwarded-Encrypted: i=1; AJvYcCWOFqpVOuREgr+7mipIKDsJkxUfHIkSAy7f7fVGZVAYpAq67OwEO9fuj9mn1/f9WlidOD/kvtsNBjEHeNPH@vger.kernel.org, AJvYcCXdppqQ1EYTDoQN2qzUQUgjFkMt8pZvW0XiDqPwk6mbqfhpKRjG23bIulPPaD4/9J89NRpOdp18VhiG@vger.kernel.org
X-Gm-Message-State: AOJu0YyCT9lUuqpeL3DrvQV7Gev2n4XlmX2tXsvIdd4ZDM8l1SKxu16t
	obbwqnJHMIraJLnu0BCvqi2xnjm9YKfdNsszqX4ibklAu+XBjFVSVYMa
X-Gm-Gg: ASbGncuA2uakZ2CeOL6QU+iTfTPN1R/i3BjQqnyLnmWM5V6MeQpGp13CLRzv6f+e9fn
	xxvuOL68p0syaeNNOn1x69U8bL+v7ehPmq3SshS9+knojEJnWTB8aEFjoTWOdDGeioM+MQtHXtR
	b7ifLITdIGgHtOABVcUUVAC+RHRDDtl6F6GZDCRJdaa2eC/1ShvFcrOQzRnEsBASMfffwO5sn9g
	D9BFmd9LPfhnXOZkHVMH4a9lCLhRIYZSgQ9VMTMxvheKwW0OlQQQfq2RnJStQQBc+3CQCOHaeuv
	nsJ9K8xF2VnqCyiOdwhmk39lQzCeSwpsMTwRwuRdSKDmcJGOAPtfjZAZYDFpEA==
X-Google-Smtp-Source: AGHT+IGLMBKLkTLMuH2Vb0CDrC1iseBxe/ZnNx75ISOJrVgy0Sw4kB2z+b7qCz4DGT+64Y7TlWzLGA==
X-Received: by 2002:a17:90b:1d52:b0:315:f140:91a8 with SMTP id 98e67ed59e1d1-31aac4ba08dmr25723943a91.16.1751956870099;
        Mon, 07 Jul 2025 23:41:10 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31c21d27f09sm1203410a91.2.2025.07.07.23.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:41:09 -0700 (PDT)
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
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Subject: [PATCH net-next v2 2/3] net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC
Date: Tue,  8 Jul 2025 14:40:50 +0800
Message-ID: <20250708064052.507094-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708064052.507094-1-inochiama@gmail.com>
References: <20250708064052.507094-1-inochiama@gmail.com>
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
2.50.0


