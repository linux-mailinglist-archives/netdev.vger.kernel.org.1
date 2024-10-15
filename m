Return-Path: <netdev+bounces-135496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E499E25C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD6F1C21A9E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735991CFEB5;
	Tue, 15 Oct 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhZ5UG62"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E91CDA1C;
	Tue, 15 Oct 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983393; cv=none; b=eARtQ81XZ1g4o6AWWVveLuzStqhAh2b/zWJfnfgYPY9tah9ykWgVTD4kA/o3uoKasYNPLbMy0jM5RmdxBGd2pZIkjOOEqJwiVPYWC8LVIC0Il8gt2iwLfdWajb95HvI/9G8PhKrKc23PyTmGMRhzH63VaCnHNiEWyG3gvKAloX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983393; c=relaxed/simple;
	bh=CUf1xhmh5CFKPoCzustBibfvzHISdKK+GgBumXZ1+cM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PTkMQr6eA7oWyIhhh6ft7V0kpM7zaj+QBlKYbl//kIVWWS10mS4yjludQuCBwSVSyc6tsfLSB3U7LjAtfPZJVEv4JyK/JZas9lZdpzAVknp2mplaWbZ3/O8h7J1ENjqmeQvOJlO8m0Gzv2NnyLfyDKEuD/a5i72QBMImNPyUtk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhZ5UG62; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea78037b7eso2049287a12.0;
        Tue, 15 Oct 2024 02:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728983390; x=1729588190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+rAVWSk33yzFNuxYAb2kshPjGwfRkyohC13H7ruK8yQ=;
        b=NhZ5UG62FoLbgQzLu6OxxrCs+lbn/f0rU95PEMpRNKw72NTmD09eAQfSowYfveecDQ
         eHtuJ8viMjFQu7KPKo0JY3F0pxH5zLoq9xUXjbiFA9JgK6OjiViGTtVvm3VS8vP8swAQ
         LlVqgF8/gO+Ju9TVQVJxQ/Tt/Y7wKiiMD6R3CWe3bN88mBJg5Rlu8yvzh7+FDQKjw5xP
         UXC/85xBiT8SgIKUFvsngkIM5zT7BS0DWMsBe9O70oWepPnQS/Jh4XqONP1MG69q723M
         8FDrR5L8UebG5U4dyPSHKa9QOCj03bQg7fB5DNNxIl/XIhxFAFm4ROXX9fQfrUnA7kJs
         7q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983390; x=1729588190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rAVWSk33yzFNuxYAb2kshPjGwfRkyohC13H7ruK8yQ=;
        b=Luq7OGEoB3OZOj6L+NP6ogHt2GUPmbkWJT4Eb43E7d1EpSRKFpTpqIr2OWhE7VhJKy
         8q+PQxzm0EtkB7JELNxLI8md46gWICVbLG91m/waYzV36OYNVfZ9yxWDDe6rk87Aae/3
         R7cfeA72KADDTqL5pYpJ8sxQBezv+r8pk12l7+at5HEqNQfY+TSpI6ieL9/HUbcwFNS1
         1PnLOaiiEg7GTqMttdf6ynju7vvd6end2Y3S3Rd6K35egPBJc4ljQrBFsqGM6F4gUu3s
         xgQrQFfXy4rsgMmqBLCfIpXChgmLhsHePH94SpXgh4Zh9IK75Fl7wcJm1iNMCFfg6+l/
         m0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCU7gcrBbdq0uC/QE3GYhhuhDWHAkeNZnlG4OARo/C2Y1/IvU9fyRxP4hwsoybA53HdTp6UgvKPXGNKsEAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytat9eqL/+MQ5UcsLCPww16L2uPp5F6ao97m6yy90pUK2GqOUh
	aGNvtVqRxyj1A8/t6rFHn/hzcS7B5CXQJ7mewJZAioJp2aPMiS4pUvxQPA==
X-Google-Smtp-Source: AGHT+IH2FmmE/B412YTtjplQJI8buvMqqeNbFsv4Gh0T/efoJEx1gqHO/rnFjmNENHAao3BcqsnkXw==
X-Received: by 2002:a05:6a21:e591:b0:1d5:125f:feb0 with SMTP id adf61e73a8af0-1d8bcf14d2amr20182563637.18.1728983390268;
        Tue, 15 Oct 2024 02:09:50 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20d17ec8f35sm7905095ad.0.2024.10.15.02.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:09:49 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 0/5] net: stmmac: Refactor FPE as a separate module
Date: Tue, 15 Oct 2024 17:09:21 +0800
Message-Id: <cover.1728980110.git.0x1207@gmail.com>
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

Tested on DWMAC CORE 5.20a and DWXGMAC CORE 3.20a

Furong Xu (5):
  net: stmmac: Introduce separate files for FPE implementation
  net: stmmac: Introduce stmmac_fpe_ops for gmac4 and xgmac
  net: stmmac: Rework marco definitions for gmac4 and xgmac
  net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
  net: stmmac: xgmac: Complete FPE support

 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  12 -
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 150 ------
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  26 --
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   7 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  28 --
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   7 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  54 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  10 -
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 442 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  38 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 149 +-----
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   4 +-
 15 files changed, 527 insertions(+), 405 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h

-- 
2.34.1


