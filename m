Return-Path: <netdev+bounces-140260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1719E9B5B4D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 06:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8752853E8
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 05:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EF51CF5D0;
	Wed, 30 Oct 2024 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4h/Vdxi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610D71CF293;
	Wed, 30 Oct 2024 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266600; cv=none; b=bzQAUI6B/1kT900S9SNHXX92gc0HY4j9IoenX+D92ljlLk91oE0bz9irbaZQfnAbROKiVpGVd5BUHc8m8D7wnBL27oZPbnQfuejFuFndTtBDUzhm4IutrFOWIy1/iwUaz4Jb2KrVS06QtNO1AFFouoBVnLNheV2RX1Q9SNjFucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266600; c=relaxed/simple;
	bh=pb2WEI6e0Y9CXRnhptznPXv/5BI4xkMtWblg/9X3dW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fartj5W0AuyCyX98KeQtCP5FOijagm92sVVOEyhLMNikUr7ciqnN6JNFRrH0zETGUmF2sXawHJANew6lJFOt5ycxnkJWnDGxn6M9jNSih57Zk6VfRYVP/dVQZL3yANeKohbBwgh8DJp27ioFLnYAdYkUJgilwdxtpz1hx4VVofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4h/Vdxi; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e601b6a33aso3643981b6e.0;
        Tue, 29 Oct 2024 22:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730266597; x=1730871397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5JB/cGgUoF+EaDvRZAGIK3OwHiKrJHGT5IlWD3Oxlrk=;
        b=H4h/VdxicuYW17Kt7EQAaLPxPUgOadvteHP6RyKozgtgVXNEEXZEXtxqcBvcucjds1
         RxoirmYjBc15BOiEUI1ErEVN+JVz3ddEmDKe4qGYF2SnhmOrV254bHRrKCGXT81gYRB2
         9IPOxK/2ZXDXTm8PhiMoDWmCwqCE97kXR0jtaXWHjyPipl3i7HuCh/L/N9/mWEDY1hPM
         HjA5y8za7oCnNOnE52bkdFpGTb23BdQCJXuBX3kE6uuYWcJGGEaYHjcPe838gsVzoHae
         uHkUnFcf62gXHo+NhFa0ytphNkS+vZEdSHc0zp4c9NFJlx9cLiNA+cCPPDOltlVo/FLz
         RCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730266597; x=1730871397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JB/cGgUoF+EaDvRZAGIK3OwHiKrJHGT5IlWD3Oxlrk=;
        b=raYXf1iz/KePMOGZ0pNFr160twyZsipnHnj49P7j7rKVAoW2XUm7Asnz/BsF45FG3j
         9arAbgMayvbfJL48But2fCGq6zXWR38mzMNotXd3odJro8Zo52boCnp7d/HYqETrGDUJ
         T/FSKUZFMa2VcnAWKOZ68mkqvX2bTTxjBS4BrfLclRFcgyKxg88uKh8X/asRZHKIRk5d
         CbPlsdOlwG5DzSxEeOWa+ax1dt3yFJW9iJEhwc4N6xPigCwvP3PIgXaMxil3FSSCgPzm
         MwH1pMShfB0ZpLvkINrnugYCKtsJCRqzyQfjXa7DTczC/227cDA/2b+PyfSkr28GrUq3
         N1Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXCvIDSyUV8nKDSkvpGi7XhslWh1JW7pJoA9silPqw+Cw59o9yfHvqcPBTQPQv/MWg7BGj3BNRjh6caj1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEP2A+MDIeKyh3p9S0zuFsGTjN4VUD08JDP3x/xV9LgEZmkne0
	FBNrGwAOT2Z2zKr4AwGl3ckHPpCRitOiHRjgsju7vgZr3WxciYvHbcsr+A==
X-Google-Smtp-Source: AGHT+IH4FirAelcYwz6Otzk0LxXXB4G8PXfXbrPJ8o3q22jWDCJ8ZAFjpdGAFz8nJtPeZGloDI4FmA==
X-Received: by 2002:a05:6808:1918:b0:3e6:ad7:9a38 with SMTP id 5614622812f47-3e63844158emr12362178b6e.24.1730266596775;
        Tue, 29 Oct 2024 22:36:36 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7edc8661098sm8516595a12.8.2024.10.29.22.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 22:36:36 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v6 0/6] net: stmmac: Refactor FPE as a separate module
Date: Wed, 30 Oct 2024 13:36:09 +0800
Message-Id: <cover.1730263957.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor FPE implementation by moving common code for DWMAC4 and
DWXGMAC into a separate FPE module.

FPE implementation for DWMAC4 and DWXGMAC differs only for:
1) Offset address of MAC_FPE_CTRL_STS and MTL_FPE_CTRL_STS
2) FPRQ(Frame Preemption Residue Queue) field in MAC_RxQ_Ctrl1
3) Bit offset of Frame Preemption Interrupt Enable

Tested on DWMAC CORE 5.20a and DWXGMAC CORE 3.20a

Changes in v6:
  1. Introduce stmmac_fpe_supported() to improve compatibility
  2. Remove redundant fpesel check
  3. Remove redundant parameters of stmmac_fpe_configure()

  V5:
    https://patchwork.kernel.org/project/netdevbpf/list/?series=903628&state=%2A&archive=both

Changes in v5:
  1. Fix build errors reported by kernel test robot:
  https://lore.kernel.org/oe-kbuild-all/202410260025.sME33DwY-lkp@intel.com/

Changes in v4:
  1. Update FPE IRQ handling
  2. Check fpesel bit and stmmac_fpe_reg pointer to guarantee that driver
  does not crash on a certain platform that FPE is to be implemented

Changes in v3:
  1. Drop stmmac_fpe_ops and refactor FPE functions to generic version to
  avoid function pointers
  2. Drop the _SHIFT macro definitions

Changes in v2:
  1. Split patches to easily review
  2. Use struct as function param to keep param list short
  3. Typo fixes in commit message and title

Furong Xu (6):
  net: stmmac: Introduce separate files for FPE implementation
  net: stmmac: Rework macro definitions for gmac4 and xgmac
  net: stmmac: Refactor FPE functions to generic version
  net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
  net: stmmac: xgmac: Complete FPE support
  net: stmmac: xgmac: Enable FPE for tc-mqprio/tc-taprio

 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |   1 -
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  11 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 150 -------
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  26 --
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   6 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  31 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   7 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  20 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  11 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   8 +-
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 405 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  45 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 165 +------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   4 +-
 15 files changed, 480 insertions(+), 412 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h

-- 
2.34.1


