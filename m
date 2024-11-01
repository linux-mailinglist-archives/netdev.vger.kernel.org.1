Return-Path: <netdev+bounces-141023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3DC9B9207
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDAE1C227B6
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37C919923A;
	Fri,  1 Nov 2024 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVjYLpqF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB03BBE5;
	Fri,  1 Nov 2024 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467915; cv=none; b=iHmGiLZIcZg+501l1gx3V5YZL7+1o+0i5KJ7egTaCXpXiIsex+qkbpF9M9xku2UpMpniNFJXG/j75cCv/rIHLwX4vWWDMT+J1I1ZIm442+v1jpGTDw2pWdNhiBtcfGQJXCwEJll4DHt2ugyTJne7tg/qdTwimvZ/ce5mLe/+j5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467915; c=relaxed/simple;
	bh=/QQlBKrGBX5/ZCpPlP53FmQkpKz73UVKr99O0hoWXb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NRS7oIBX2uB8oTUwZJkxIH8kdWpX+8xW3VouQ1M6Dm5b/WM0djwVd72UtYsliItl48Vr9pvD0j0zBNcXLeF7oXNmSddjWrN1nRK20ehCMf8oT4GbCFdKoVr6y+/DR8pRQHgn2OnlP6NHmxTAvSW4bPD5Nj0UfKyYCKSEDy0HSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVjYLpqF; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2e23f2931so1476101a91.0;
        Fri, 01 Nov 2024 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730467912; x=1731072712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6BgmcTk7XmHujA/4u0if1oSw4JEAcJOllZBBdLUDRLQ=;
        b=aVjYLpqFJs9mj4wwI1EouqyqXMrU9Kh/hWNlJ/3b0/9XmDcdEjzBjav+Kxhwa0vY1R
         l1tTN2d0o8Zn+qXdIoRejjhKJjZ0c98aPUvgWVcoiYGKowGMYkagXzOGDDOGagq9RNsZ
         qwj9LKdl9SQqo+lUCYSUcPfjm0sXC1sgM2gWKuex4ba5liTjDNEKNtt9iRKoJXB90u/d
         ZJN6+OgmvkWPUx78Z70TI27ZXwGCwDPDjCGtTX2RINrb2dvKwiKT7yJvmshYNOF+J3Eh
         9SpCYTVPZx5YH8cgJ3+m6ft8RY+Pjn5nfwdz0ruPtrjh6lcglF8IhyKZeew5JbxpiYxi
         9Kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730467912; x=1731072712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BgmcTk7XmHujA/4u0if1oSw4JEAcJOllZBBdLUDRLQ=;
        b=tTBrNRCL7OglTOsgum0Vj8LpFBkvFTix3+DnI+9OMOd4QEylmp9M25Y7K3WyZdSls4
         oMjLdiP/6V67kAAaBLzbQs2IsIz4GVy4lDgfPgY30y/lmx3oaFquySGoEUjMqjD1fuaY
         VVpDUcEhXcvR/QsN+Qn88I8pHLLd7zx4izfYnBkGvm/6GSsVd036f7KXMTiwxBgizjvB
         1ywkhb33idWethWWsEkr3D3FK4YlzxJtndQ2TALUANUxZ/I5le0rK1sIeEci/mjf5+CR
         YFXr7g+QeE/WzcWEEVuW6kNv1Bij7zOMzh87S2PwD+LOZBHKv30BemnjhjAt6IiD3Jl9
         qpHw==
X-Forwarded-Encrypted: i=1; AJvYcCUQfHXpb/NfJK6jWyZS3PYXC8G2Mqgv3R4sUMRsjva/O6fS2L1Yit7cBH2UzQ1Pf7x+44CXNd8gYDQXpxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxKlve+uSPFjTCHzTXnrLDqQ72u3lAWS4dWB7cQXnCXVusdRa3
	Hnzq1HgXxzwN+hUr3Wi6vQcJj3+GWq6e31lIjHDDktPC514aZ8OCpC4hFw==
X-Google-Smtp-Source: AGHT+IHAE55EK0dfqKcLPAtM/F6+ejlhfkIjKBOG/4/JPVFxXfsjxql6Db9+CeYkz1C9x1U4n7tJZQ==
X-Received: by 2002:a17:90b:3844:b0:2e2:a8e0:85e9 with SMTP id 98e67ed59e1d1-2e94c2e43bamr4641436a91.18.1730467912286;
        Fri, 01 Nov 2024 06:31:52 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ee452ac4ffsm2425552a12.25.2024.11.01.06.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:31:51 -0700 (PDT)
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
Subject: [PATCH net-next v8 0/8] net: stmmac: Refactor FPE as a separate module
Date: Fri,  1 Nov 2024 21:31:27 +0800
Message-Id: <cover.1730449003.git.0x1207@gmail.com>
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

Changes in v8:
  1. Reorder functions in their natural calling order
  2. Unexport stmmac_fpe_configure() and make it static
  3. Swap 3rd patch and 4th patch in V7

  V7:
    https://patchwork.kernel.org/project/netdevbpf/list/?series=905021&state=%2A&archive=both

Changes in v7:
  1. Split stmmac_fpe_supported() changes into a separate patch
  2. Unexport stmmac_fpe_send_mpacket() and make it static
  3. Convert to netdev_get_num_tc()
  4. Commit message update for the 3rd patch

  V6:
    https://patchwork.kernel.org/project/netdevbpf/list/?series=904502&state=%2A&archive=both

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

Furong Xu (8):
  net: stmmac: Introduce separate files for FPE implementation
  net: stmmac: Rework macro definitions for gmac4 and xgmac
  net: stmmac: Introduce stmmac_fpe_supported()
  net: stmmac: Refactor FPE functions to generic version
  net: stmmac: Get the TC number of net_device by netdev_get_num_tc()
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
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 413 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  33 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 165 +------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   4 +-
 15 files changed, 476 insertions(+), 412 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h

-- 
2.34.1


