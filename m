Return-Path: <netdev+bounces-138502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A369ADF2F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58A8282F3A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8515B1B0F2B;
	Thu, 24 Oct 2024 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA774m5s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EA91AB6F8;
	Thu, 24 Oct 2024 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758703; cv=none; b=lPTENg4EG1M5e6ddiYyZSoBdgoXh5gvLatQjaKjqb059tN/PrMu1879zE5Bkt/IdKrcUctZuf1ENPZvlpgSXOSKpGKIyx3ncbdhVubAqr0N9f9iuvNWCw2jqElbCiigyzQFH1OVDSGkg83fI/nLpjV7gj+A+cbPp24cYOEWjJHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758703; c=relaxed/simple;
	bh=NFYyAskNuwtL9TnxIXB89bYz5D/jS2Z/Q2WzwwDjhy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ar882BKyUBmWVjRfPlA3l5evTwWzciXH9K2+ylR8qj20VnLwm4pVsH8iBvyraE0EljqoXuqm9pHO6QrBnb7dyqObZofScUMRanIh3mxVQx8y23SNrDer43O8pVGf5taKkccTDF4Zn7d00Set/YKYYijeSN2F7pnQUKdl3dPmdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fA774m5s; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c693b68f5so6323575ad.1;
        Thu, 24 Oct 2024 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729758700; x=1730363500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1oNnTivFwASMm3bbLUePa/ONTbP9bazkJEQG70mDoE=;
        b=fA774m5s53Sx63C+2MVWo1t2UPt5zI1xFn+7vDNqG7vWsdh9bNWThDEdJOKRGGyupy
         ejV4ei1FDGYlA7/7ae7cUp/YmIlvMU1bFnfL0jnUuKItVc+w6OItpOzG/C+Bk1OyU3Bp
         BMjbiNhtGcSBptFT8lRUX6S7yK4yoYQhaIFI5nK8x50Sc6lQw5ZKShlF7U2xDKeImQbC
         n5WH5ElM+qhF4ETSJYS25JR8r/32L22c4Bq8B0lXFWdmH+Nxp+Lr5JieOXGLtw1iloR9
         PiZ+jZilsVadamOP9Jkp+WhBCqpNCzvRZex/GTqiR3lAschT/8pKGgtIdkIKlTvJWuOR
         F0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729758700; x=1730363500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1oNnTivFwASMm3bbLUePa/ONTbP9bazkJEQG70mDoE=;
        b=MHOX4cdgevrtQpk5FtQC8/3YXN8tNRXIxDjDc0e4K8Jax8sHLZ0Ayhn9HiQfUE4SdX
         Ewe77THY/srXjIu3sdyuQ1ew0iOeofS01/kanRg1lggtHLzHFGC+rKyflN7WoJN8LeOy
         fmp8SHIcVJMnpAJ99VQHk+cyEAiVgIjQ/BpJv+NF7eJKTapEL5WVOY0vnhIM72kWthrf
         vZbqDqSVw37voUSHaSv3x/jGESKleGyJfNyq7weSdFY/U2wbw5iTYNcuhaJVRxuIKNbZ
         k+pg5j1GldoW4AOUoC+lvCTeQtFTOOThRGtBYCDbsjZ25ZcHAKlemSu+V1dtfxdASl6i
         cA7w==
X-Forwarded-Encrypted: i=1; AJvYcCVX43Q4V6h6kdGd8DjNUxMSGpDzpNhQwvKjDtzIOP6izRqexdhWFiYv8s5umexEFF2041zBLFK1YGN5ij0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCffcn7aETvpKYlMxMLQfkusUaCqjWWOazoLvv6Y5dFf7b/8PK
	6d+UowF9H6pKp1eF+ISYIYSPVltoeXNmLgs1KX/EHMrUbSu/7QcHZo7Z7g==
X-Google-Smtp-Source: AGHT+IE8sGDrZzabWRqjNx6ZIY3uaHY+X1npznrkLs6Jcu4tChUNH1+QbobLtPQARhooG89cxI/kWg==
X-Received: by 2002:a17:902:ccc9:b0:205:68a4:b2d8 with SMTP id d9443c01a7336-20fa9deb634mr66670025ad.11.1729758699949;
        Thu, 24 Oct 2024 01:31:39 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e77e5a4ec4sm868773a91.54.2024.10.24.01.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:31:39 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/6] net: stmmac: Refactor FPE as a separate module
Date: Thu, 24 Oct 2024 16:31:15 +0800
Message-Id: <cover.1729757625.git.0x1207@gmail.com>
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
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +-
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 412 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  44 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 157 +------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   4 +-
 15 files changed, 481 insertions(+), 407 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h

-- 
2.34.1


