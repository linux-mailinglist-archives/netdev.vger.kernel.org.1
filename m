Return-Path: <netdev+bounces-139417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D989B235F
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 04:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF038281341
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 03:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950A4185B77;
	Mon, 28 Oct 2024 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqb7Buil"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27941B815;
	Mon, 28 Oct 2024 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084870; cv=none; b=WX0lQA5QdacAkVJmg919gH/E2zej72eYKogm+T5ZdaZ51mOZfg7FhDlnV832DcEijba4o/S4Vd6ag9OwNQJHOSj1Q5M/5rCPdQwZpRaYqiXf44/CY+Fp2KFqfDBHv1RxSLp5o+VhejeNtz2l8RcrewXRjMy3QOCFpmBBfS4OQMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084870; c=relaxed/simple;
	bh=GSkNEOFhNaUTv/2kT3b4fFMm5I3C8TWYznb8hMiyrqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TgiKHaqdnWn774Fr3/q2fBZX1QzoPUq+v21DX81mx4DZpM48rco3vzPCaFbMBvB2jEkL2q8cXUH/neaD6FavzYJoKpK8OjdPaH+fUa3oWhMUeWHJ3SqjmivwuhwEps2deV2Ts7R1zWmwAELdIBv6++krm/0VK8zaNEm6mLmX20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqb7Buil; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c8c50fdd9so29634295ad.0;
        Sun, 27 Oct 2024 20:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730084867; x=1730689667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oyZ5oeJxWBOMpUrNuWphCAJQozS0spzFlvL2/Btoo5A=;
        b=Lqb7BuilZJnutgjWIxN6Fd9rYrLg96nryzc+bfEDbwwVum84WyvuQvsOhvbVkjeSjo
         K/YTcXJiazu/IsQEDS9zmxrSdo7ic+i+T4paoNOLXNKLMDZutPCTl5h96W9honTZVSrL
         XsWRyC2OPQ6IWbrQepQy8x6SoeXx0kHRFL5WT9+gNTcznMex24uhTjqeKKght+qdC1Vj
         YvdqxJ4vtCc+wJP4/gGv1M/9OfAleedlzqlxdVPZNpHZQ/cRTcGo89mEwfu5SZObThrT
         weRIp+JahtbQAAVJnlDIRaJUN8rJ1iMZqCFiJpIoKksblAfMyQmbh3RCYHfoIS3DYXVl
         xK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730084867; x=1730689667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyZ5oeJxWBOMpUrNuWphCAJQozS0spzFlvL2/Btoo5A=;
        b=aqjDzRo3BkXyCYAyidkMhcMnMGsvZPJwbrAMnxIcxn2xFqehirZoL3m2wQEfN5YNAU
         sU0BFhNsFNpQNfvj++l86XHaMeaie1BJRr9n5PMw2aTeCC274ddwXAu36cLRhtcelcUf
         Oflo3fkPOWaOJPKxs4WT8M2WENggWQtEjxNYmSGe+6VumuZaqfcay2nSk94olw1CAlC0
         mdzK0m/SI6+xI8iXY1gNkdYKfDwD1CWtaE54kRXcwu47A3QA8ib/9f/4ID8tx8La1Hu5
         HEbdrQGEUnY8uORypBmJBN1Zv/B8fK7U47/OGHhB7P30DBDs690qJzVRgobZCyMtVCnI
         EyAw==
X-Forwarded-Encrypted: i=1; AJvYcCUpa+Fly0BLe5xTg0rU699udrPzzJffobMELuY9cCgXVJNi/aN7jN9xIu97SK2mHGIjUdoPKQBI8oTvkPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyld0D9HOfvxKLZtZno+k4wUvKPr6JTkt0jVIaPtcMVeCOPkIm
	pUwuO58zt2qK7SFen+7eT5xTrjgPSS8x6gYGQjF0Uei3UcK+NCDpeLRMIA==
X-Google-Smtp-Source: AGHT+IGjTJH6FP5Q/Rq9jlV590Kh1CRuN6iXAYc28hlY0HjvVjt90JpayXD0vSxAoJRyO87DxJokiA==
X-Received: by 2002:a17:902:f64a:b0:20b:a73b:3f5 with SMTP id d9443c01a7336-210c59c6d8cmr111903495ad.14.1730084866834;
        Sun, 27 Oct 2024 20:07:46 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-210bbf6d327sm41414155ad.67.2024.10.27.20.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 20:07:46 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/6] net: stmmac: Refactor FPE as a separate module
Date: Mon, 28 Oct 2024 11:07:23 +0800
Message-Id: <cover.1730084449.git.0x1207@gmail.com>
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


