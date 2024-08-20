Return-Path: <netdev+bounces-120062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FFF9582E0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CDD1F22468
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE73818C902;
	Tue, 20 Aug 2024 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru4A8ABr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE018C32B;
	Tue, 20 Aug 2024 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146731; cv=none; b=LYK88GtZljNcCBRlziW05I5qErsIZD5ZIE9++WkVa0W8qxHdJOhvemb024CiMwdzbcZCvpCW0/XWD7TopaINseEVjzciyFhy5l09d1B8mDbOtVkBLgLKHwZ8/qfovww09/TtXv6IYtktD70S+CsBsN4sMpExi6rSDTyvUiJ3IQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146731; c=relaxed/simple;
	bh=Rdad3okL7MNmaQlSj6sJja3bX3EWeW7LJlvGMZClMgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P/tBzU2WhbIeEFsTdSe0HVOJwIZS7vJMvkzc2UwvEcGdq+0zB+0IfP8yhkiqk9mRYK4KJXoOTl3nq7vBftnw7pldw+hu0cXO9psOw/5ivOdsDxlyONpOoUpwruOSnyi0nrGdvrdpnPPS2uXPIrJ85umtw37K+cHgAMQlumHhQM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ru4A8ABr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3b36f5366so3650333a91.0;
        Tue, 20 Aug 2024 02:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724146730; x=1724751530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0WVdsLsmxYwgymE6I6XPZ0VOeJxb8k0ES72cD/kLQY8=;
        b=Ru4A8ABr3AXn+MksU0DRvJYVPoIPEaatVzV4HGFQMpyB3w2JrHRBBnvUgYN6H/qwrs
         A97uh9MXUPe5qAvTZ+tageMOQmbv6IX/5dnQZ74jBsJwfik6IbRTg7xNkP+FgFsBPbA1
         bxrfyLlEW4c8RpnzPnAGIwkE8Id4vWH9j/3XC3pBjJARqnonnrvOmxHOSSDSf3rKD2gY
         OH0A39QUaBoRhbJLqksKhSBgygTkuNfFB35nTkrvCyaBVyGA9vH56uCnvuAPZMYiLtPw
         oeDODnEGFFR+sj/NYYIeCaffv2cAB4k9LGRm1atQc7hV+uYju0IaVOGbgq4dTbiI3FKY
         vYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146730; x=1724751530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WVdsLsmxYwgymE6I6XPZ0VOeJxb8k0ES72cD/kLQY8=;
        b=ssLj+ajCAlS0QTtLyJ9kQSlX0EmnoH5xxuaE/uMHNoclnwxMMDyNfxLfc+9oFUZ+sj
         d+g02SEOlMp5t/S1l96pV+L1Gj4rhmeKUrGIBAp2f7TMC/uyohxwor7r3IxpTqwEKPmD
         qM1JGphyjEV8eGfIZb8CbaHKHH49nEW5JioW6Vjhv2Jvm7FvTpGq/as2/nkXXggSgQEw
         olRxkzWXkcTxXGXmjaqRDnsXVzPqhwhbgASN7O7uNn87wOpBCTUB5b4TnF+rlxPOWJXC
         x2YW7oKCwBvV8n5YZpRcp8VkR5Jt3wtMaQwQ4+D6Q1mi6DFu2lx1wXXaezl83X5T6MX7
         /T2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIlwOgw0Bg3eKYltbEyqtaUcB9FxjqHNGydwPXQDcvboBD4dqKFHssNvmEFoCTYsYZtFAtobsmt5eAjLSG7OA6R1A9Hbj/XLZd+18e
X-Gm-Message-State: AOJu0YwQSG69PYnNV7eyHMzx+/DPNf7m8of5JPEwpQawR285dLRSQNt8
	FEqiEyAb69enCvRRp3fqZYX9nqeiws42igAk4VxfFeboH7oup4CL
X-Google-Smtp-Source: AGHT+IHF9I9s+Fxk8vbHg0K2cB/yaA+g12OqwqsSEsnVkiEks2c7wO1DOmBk/9tSNMmJicERd3O47A==
X-Received: by 2002:a17:90a:ff91:b0:2d3:d728:6ebb with SMTP id 98e67ed59e1d1-2d3dfc36bffmr12330038a91.5.1724146729285;
        Tue, 20 Aug 2024 02:38:49 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d45246061dsm3230608a91.8.2024.08.20.02.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:38:48 -0700 (PDT)
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
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v4 0/7] net: stmmac: FPE via ethtool + tc
Date: Tue, 20 Aug 2024 17:38:28 +0800
Message-Id: <cover.1724145786.git.0x1207@gmail.com>
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

Changes in v4:
  1. reorder FPE-related declarations and definitions into clean groups
  2. move mm_lock to stmmac_fpe_cfg.lock
  3. protect user configurations across NIC up/down
  4. block stmmac_set_mm() when fpe_task is in progress to finish
  5. convert to ethtool_dev_mm_supported() to check FPE capability in
  tc-mqprio/tc-taprio
  6. silence FPE workqueue start/stop logs

Changes in v3:
  1. avoid races among ISR, workqueue, link update and
  register configuration.
  2. update FPE verification retry logic, so it retries
  and fails as expected.

Changes in v2:
  1. refactor FPE verification processe
  2. suspend/resume and kselftest-ethtool_mm, all test cases passed
  3. handle TC:TXQ remapping for DWMAC CORE4+

Furong Xu (7):
  net: stmmac: move stmmac_fpe_cfg to stmmac_priv data
  net: stmmac: drop stmmac_fpe_handshake
  net: stmmac: refactor FPE verification process
  net: stmmac: configure FPE via ethtool-mm
  net: stmmac: support fp parameter of tc-mqprio
  net: stmmac: support fp parameter of tc-taprio
  net: stmmac: silence FPE kernel logs

 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  10 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  |  96 +++++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  11 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  20 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  27 ++-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 110 +++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 214 +++++++++---------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 124 +++++++---
 include/linux/stmmac.h                        |  28 ---
 10 files changed, 463 insertions(+), 181 deletions(-)

-- 
2.34.1


