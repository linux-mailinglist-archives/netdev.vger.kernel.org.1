Return-Path: <netdev+bounces-136864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0E19A3591
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05506B22762
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 06:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19751185B54;
	Fri, 18 Oct 2024 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU01QPko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB2E20E30E;
	Fri, 18 Oct 2024 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233587; cv=none; b=kr1B2RWHo1gFC4damS+GCoAvwQcW28nRTXskGCuygchw+1D7Merj5ukBgAvqEzoRqmQfmBU6GEZZFSbOReb3WMJTvsqwnA1WiLmhGmhAWkP9I/JvsNsiEVmMrJNGJIRim5sHiV6BeWvCyjWyuR1CkzFRqL8Bn5jkNjO4cRcLg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233587; c=relaxed/simple;
	bh=IGPFmn6D+KUkVA+wfJe9DMypAF9a9v5PpM1weFI138Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P1EqPMm8+Zk4S7EFPWon6UrLTu8yl0pkDXwdmyldoDcszBPuEj4pN2HypcBigsHTES3vf5MSKPUHkgY90oYzIK4byIZHCAnWcDlAXf+S0GOEKn1dHl3HiM8fDgZMHgXJsoOmAf+S69+kLeD8uUSH3sQSYYdYHLOX9ICUHfyYgtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AU01QPko; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cceb8d8b4so11136425ad.1;
        Thu, 17 Oct 2024 23:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729233584; x=1729838384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uT/jCt5QcwTbFSYi05lc89RT3DwAspW1JXtMxybafaY=;
        b=AU01QPkoHZj/lc5Y7oaooTK0XNuVdPofj9SpUIiCN0EoNFbinNP9y7BZNwZq5M9VIu
         lgNV5Xtz7cUrHY/xQhodsy+KUP0zfeN+DQgrNTVgVt38KO/I1Yu1mRHz2UZbC7kqVGdu
         3JevaUp6y4IVVVD8kNN4LPhP1sEteNF6v4morU0KI+KuKJE7YC85AkXGBj3qAWriSznW
         aMX3bpATVaFA5K0MyePeef1QjabtrbhWXtq2wmTK/Zfi3CIzB+dl++3+Fm/gIgzdDXNQ
         csTsepn8CtsqVlUmFVCy/q8yplGDeK8eaubw9NauS8an7vhMGOu8HPJ0OqDZSI1u5Suf
         o41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729233584; x=1729838384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uT/jCt5QcwTbFSYi05lc89RT3DwAspW1JXtMxybafaY=;
        b=Q+qJ2qJ9PIAigr0+E952XsUKCzIrZsmQMTAyp0Cp/N/AQpa9TXmW1MvukGwcikL2b9
         sq6/BV3oG/SZhvsKi5xqSIX2fdjf5pgZNzVFmu6AqHHBgr9LSiyHiEW6KUREGESjgfZg
         bEwlyfeSW3306V6Vws6LUrv/hrbmxPHQ6NTs7gMCaFtuh2IS6jKoYYg0VG45fWBmGSkY
         /9kh1AgoN+aYX2ikI2+gn5/mW1BPwcebxVPrj79YWyT0bTzWhlHnmStVSCxt8+vJtkYk
         GtSX3FDpozaUkMCFIZqyaQaBINuvGpzyOaYKub/maUvI14mTvvDy2gz7m+1+I4exZTX5
         P2mw==
X-Forwarded-Encrypted: i=1; AJvYcCV9bNgXE4LQ4LBYE7QHcAa2lZJzsdkeVW16e2SmVorF7hlSs5y22xdBp9yW5qPz+kXxxXlKvKoLA7OuMcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJz5OyvnGuwvKxcMhI5+oIZFmmtKs2bJkB5Pl0Arlhc5mldW7F
	dBOnUqYJSBwC47jEKx9L1fZmkho8LWK02omPrZmYLsY5NrmGcPCEVCzPXQ==
X-Google-Smtp-Source: AGHT+IFu4YCLEVDs8s7LlrZTMXp3Lx2+ATgY2Oc7tnIYbAbFTja+uBUgxR0QGwxjWrDfj8BFV3AdZw==
X-Received: by 2002:a17:902:e749:b0:20e:567c:9d87 with SMTP id d9443c01a7336-20e567c9ddbmr31892085ad.20.1729233583765;
        Thu, 17 Oct 2024 23:39:43 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e5a74766fsm6285455ad.73.2024.10.17.23.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 23:39:43 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/8] net: stmmac: Refactor FPE as a separate module
Date: Fri, 18 Oct 2024 14:39:06 +0800
Message-Id: <cover.1729233020.git.0x1207@gmail.com>
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

Changes in v2:
  1. Split patches to easily review
  2. Use struct as function param to keep param list short
  3. Typo fixes in commit message and title

Furong Xu (8):
  net: stmmac: Introduce separate files for FPE implementation
  net: stmmac: Introduce stmmac_fpe_ops for gmac4 and xgmac
  net: stmmac: Rework macro definitions for gmac4 and xgmac
  net: stmmac: Refactor stmmac_fpe_ops functions for reuse
  net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
  net: stmmac: xgmac: Switch to common_fpe_configure()
  net: stmmac: xgmac: Complete FPE support
  net: stmmac: xgmac: Enable FPE for tc-mqprio/tc-taprio

 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  12 -
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 150 ------
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  26 -
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   7 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  28 --
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   7 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  54 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  10 -
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 464 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  38 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 149 +-----
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   4 +-
 15 files changed, 549 insertions(+), 405 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h

-- 
2.34.1


