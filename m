Return-Path: <netdev+bounces-118009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8349995040C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D32F1F21685
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDFF1991B5;
	Tue, 13 Aug 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awvE5sCH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21422187331;
	Tue, 13 Aug 2024 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549686; cv=none; b=dX1caZDIFPQrkoaGdsS4+wTIaY9NzhgSUXg+/XXHENVnN3ar2MHBiRz9bOQ11f1ZgiJboYUey7+szCc2ycvOu63ZBm/2551EcPfVJg+W4vGwI1A/7v3kQdKznCb7juBdkPYz9+0eYBV/frQ+xu0pAsQHQ4h/3gawEQhm146wMEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549686; c=relaxed/simple;
	bh=0Z2cgfwh+FGbm+tAFL1t1EH0gL6wPPISi30Dl+jiL6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iff9MISzLMq2owplypvyB/N2tlJqCnpTEhbiW3Bre+JUVqZKFCSd2/kHNlVVZ6s9dLqVy+y39hB9/UtyXNTLw8Wmsco3YvvCSPDJ2OhhBOx7rJQsfrknQi3OeBcpnWy8eeulCBcHnRFQakc+iK/Kqaun3ivz2z4qKES4CO1LLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awvE5sCH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-710cad5778fso4334311b3a.3;
        Tue, 13 Aug 2024 04:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723549684; x=1724154484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+7d9iEhLFGEdBGoEWb9zLkjiEjssEK611mhoRerD7SA=;
        b=awvE5sCHrUHcjBiesZuTNFaUxQ6I9c+nnVYCxjnTNK+8BoykXsBvT1jhPXE7/qT7FZ
         CCdOp7bOYynNLlzxDw4x0b6pjHACy47s8/3ipEvU6Ji0fqNzX1vyuER+ZuFn19eCks0G
         463ZE4zV95aSR+rlSAnvNOVPA/JdjGazma4Xdb8NSLOkXwT6y7EBx3gf7o2etWk4rVI1
         CadASkF8f30reqEgQ2EcOV1l6//otVjk8zxFlPl2nJJdJ0ZTDM9b0Ou9/J00b4TVYekS
         041tDyVdsQ85gbqsSm5U0UtQVF/VF7np0zOqPba5rVCG3Bak4Nzp71o6xIOdRgqJtaZy
         Zyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723549684; x=1724154484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7d9iEhLFGEdBGoEWb9zLkjiEjssEK611mhoRerD7SA=;
        b=oQz44xR7K90dBrOy4+4f5axvH54C7UYXvyB1Jmezk5vf/NHRdptOBdAAvWFwR2+7S9
         cQgtlUyjr16xzhy7/g4Ep5ttdW6s4fMaC78kNsBeHerj31xdkkMTSoS5sdr+PoBldNG9
         IZ/VUOzAtwOOEaY602JRkfYrGPxGY41dn00SVM2caig0avwV1X5kE4f7jvHQUQTUVavZ
         2w/H84X09ZSXvZzCGY33TXk5Tye7bz1bOsv3JhbAsfYj3ctKezfBruNxz1gTLtjkd+P4
         yl77/ZkxFMF5F3FMOsTVnj7KJgSEbqG+Z1MB0nxCEWAWiSLHgdszVuAGyTXMlK1VMpgE
         37yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG6qmp+9r1wHji5xAzhdMKsSwKODMujWJolKnPFASdSHAhSiAdvclOYlcjJgzdiUtXNTClOum9MqpvMYv8MnJ8sJ7GaroJquMU6gqA
X-Gm-Message-State: AOJu0Yxi5rs24S0dRGzdCKP77Iu86a8poVzFXM9deSjNY2DSqrBF7I1T
	BZDU6Bl+/AZ5jVny8bY3rlgtUfk3QK8loxPZa1P6aTu5+Cv4eamo
X-Google-Smtp-Source: AGHT+IElTSvIrqpk2wLbRPBuuMsOrLa4kUNZ+aiMqa058Bv7NV0CVIQB6r/9vCRUrMVdnEYlCMWSFQ==
X-Received: by 2002:a05:6a00:390d:b0:70b:2233:f43b with SMTP id d2e1a72fcca58-7125516c61bmr3696505b3a.13.1723549684205;
        Tue, 13 Aug 2024 04:48:04 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5a562bbsm5548755b3a.111.2024.08.13.04.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 04:48:03 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2 0/7] net: stmmac: FPE via ethtool + tc
Date: Tue, 13 Aug 2024 19:47:26 +0800
Message-Id: <cover.1723548320.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the Frame Preemption(FPE) over to the new standard API which uses
ethtool-mm/tc-mqprio/tc-taprio.

Changes in v2:
  1. refactor FPE verification processe
  2. suspend/resume and kselftest-ethtool_mm, all test cases passed
  3. handle TC:TXQ remapping for DWMAC CORE4+

Furong Xu (7):
  net: stmmac: move stmmac_fpe_cfg to stmmac_priv data
  net: stmmac: drop stmmac_fpe_handshake
  net: stmmac: refactor FPE verification processe
  net: stmmac: configure FPE via ethtool-mm
  net: stmmac: support fp parameter of tc-mqprio
  net: stmmac: support fp parameter of tc-taprio
  net: stmmac: silence FPE kernel logs

 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  10 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  |  96 +++++++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  11 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  20 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  22 +++
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 103 +++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 173 +++++++++---------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 115 ++++++++----
 include/linux/stmmac.h                        |  28 ---
 10 files changed, 416 insertions(+), 166 deletions(-)

-- 
2.34.1


