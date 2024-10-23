Return-Path: <netdev+bounces-138104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBDE9ABFB6
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1E81F24CD5
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8162314A4E7;
	Wed, 23 Oct 2024 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKu4sHuZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9E17741;
	Wed, 23 Oct 2024 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667174; cv=none; b=Dl/PFG4vAIHHpyt5LdRfPdIFux8FZaCOm3Ey3bw1AQ4hIuwj4Rc2HVxtF1l0eYnxDF4F2hifJM6VCz+AFAwDn3mr6wifvrEkl7uUfScLT+CWdDYG3G9OoAadVDU/mDvxzU2sfnbgJHU/TSBxMMW5cKtD40lOQbdiH92Jbdd4WuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667174; c=relaxed/simple;
	bh=FLMGHyAfUGy7R52xiBb/gP4uPf+mTQTx9xmSo+Xzlnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EcH9Z/bTirjUpA9AunzmZwlhqlr7xgPdCgQY/bFt64Cm5K+rIPcPlv79dFfwqpi6WvFFNx6NvSLuS4ezZyKCw+wMCjwtG3yNvZe2nFCIQm1ViEtE0L/7Xf6l+iE5VrQ13g9+K9d9peH0zIbMzjR2WmcN3Li3K4U0TpYWmzrBmiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKu4sHuZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cf3e36a76so63330805ad.0;
        Wed, 23 Oct 2024 00:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729667172; x=1730271972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TOq6S3BVd0FbwZK6IpEO8zNzUEsSPo37nCA15gz6oek=;
        b=QKu4sHuZQb7lK1MYPLCYYvWOaecIQY7CF6olTPuNeHLvDfyuBbeqvVGyCytSDwLIJw
         IOvK3hjClbEDyLwY6maIeJC3FVWRj64Jeye/sm3v6NueFrwux2Z4lB1xjOsdkwVPF5oL
         wc+eSFqRfX5HoMNLMnhfhNdD3HiBeXyc1q01KbQxOx82bDqn9ROYO5Rdo0JCwWm+LghO
         ybtl+/3QmPbrDpP8x4nUbtyyv6yvzutDtI+LOZpmNQYe5D3X3p+eMQNCAdj+fJCqIQjw
         qZf1D9CMu1BPG3VZi34RCHEXXE75bzD05T0nhDEw8C8j5syXGKs83Y/Sdh0scCsSoR3S
         RbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729667172; x=1730271972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOq6S3BVd0FbwZK6IpEO8zNzUEsSPo37nCA15gz6oek=;
        b=BMU3Wr41huyR9FooAjhf8NsX6DkyPehprrOG16uzFO84tQSqhmm8UYWDkjCFi1uaFR
         rKXYprzCtS700zUUYFTLTCFL+Qs9kG6Drf+dctNhY0G97cas295ngms/ml0QMok6fno/
         lot6id3b4hy0jUggLV+OqolHh9kOCXcaEA9L9GhIuBUpHvTWHSMgK0STqLVrg0lPv55W
         i+qSSju6DyZdZDQOtH3gTXfv4ODf+qlTicnCKChCZMP0zZP+LIDgexYEJIOq9mCCpk0K
         ONX29SMjY8jKKac6AIlpGXrQWCCSFAcQP5vAiWGLLY5FSxJwJfgYaMCS8zE8wVQ+z33L
         6j9A==
X-Forwarded-Encrypted: i=1; AJvYcCUXsd0Mjz2mug3yrFfKYyKzWIhA7gG07KhTk8bHcwVopCpA3BN204Hf8orwDYU2feetQ9+aIorcu7lucJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3+gx8z3M7ZdCkAikoSlKRXKy7/+UbeLOgyzWTwUAomlbzu8yy
	Jdew4JexoYAWiclmwN22lu+rXmshCUA7pLU5nms8CTIWeD4FgU79IcjB5g==
X-Google-Smtp-Source: AGHT+IHtJtc5WgmLOXoeCHs9nm8BvD7NfbyF/CjJ2FcQHhVWjnivQcmV2HrRrmsuLKzntQZtwbUSeg==
X-Received: by 2002:a17:903:2447:b0:20c:ce1f:13bd with SMTP id d9443c01a7336-20fa9e2488dmr21746255ad.18.1729667171746;
        Wed, 23 Oct 2024 00:06:11 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e7f0c167bsm51981745ad.140.2024.10.23.00.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:06:11 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v3 0/6] net: stmmac: Refactor FPE as a separate module
Date: Wed, 23 Oct 2024 15:05:20 +0800
Message-Id: <cover.1729663066.git.0x1207@gmail.com>
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
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 422 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  45 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 152 +------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   4 +-
 15 files changed, 491 insertions(+), 403 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h

-- 
2.34.1


