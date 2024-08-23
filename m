Return-Path: <netdev+bounces-121308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA91A95CAE8
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F62A282828
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A9F17C211;
	Fri, 23 Aug 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0vSUsdy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0458E376F5;
	Fri, 23 Aug 2024 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410227; cv=none; b=HHbTZd85D8WZlfo5gu18xu0AQEpk/7oU0UndeNrfKGRP+PTJqu/jExqOSsFqCkACJcyeFFPpOBFHUl6+nhagi6j8jmh//EvmkjaW/ljfopDfqlc6KAyQhVHCdeZNPTVEyiMmUG0ybRXoZtltm/arJpruM9B+jgs670LDH9hIyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410227; c=relaxed/simple;
	bh=eHLTjM14fde6NkJpntHo51SxtoLIKLfNnhcjDWuZli0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XkvTLLipFtdeeAP0BXn51z6wzwXktOWhz6X+SdkapC809/jK3RkUv4FWdf7WqDqUWatUZ4wwUVWleKsN4yZ8DklZFNg51WjGvqQrN0y+ZHg0XNwhDFHEWFVeLTG75S0ck1MWsHkaAaKd0vtRRxKjnto1I3G5pJJmStJozPGsZ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0vSUsdy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3e44b4613so1358732a91.3;
        Fri, 23 Aug 2024 03:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724410225; x=1725015025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TeTUUU2VJ4eR8fsXtsB0pqfptdqJDznJpOdQQ9te0Uc=;
        b=l0vSUsdyzPABLVpyH4WdeXrDPTNFVOXvOM0eyzGcvSr/aeBl8lGCgU+XfK0+/yY5RP
         nh3u+2DbHetvdHP1rRbnHxXYVwTt0z38b22N9rk6nlZ/oqVlBhx5AfwsAyDXFcgNB+ki
         GqpYUtEVyur9bN8XJ+6MSTJVrGitK4JtpkbfPLJVWdyrR30blRpSv+CxVQo3QVmGgz9v
         w/FWbZ69lZBLz+zAbpShmRVGwjva7pzm8AFs/AhMdPn+h0T/fA5eR0o8PqWGDvZD8qHS
         6iX3wIIfD+uG5ONjOVq0BMK8Ow4xrgLX62uQYhfRsvD5+LYET7YbkKCVDRsU9JjrgeiU
         iKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724410225; x=1725015025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeTUUU2VJ4eR8fsXtsB0pqfptdqJDznJpOdQQ9te0Uc=;
        b=Dotc6ClEGDcyZVeczI8jz1o5K30/bZfA5fmj1x2s4QoXkqChwLVTPBGyjcjmDzZojb
         fwxQcs3T+7dg69Sw3/an7kRO2zWWoWiBI3cC6qNnVwxLdCuZAGe5vJHJnAHlATkrQDha
         6RJL+SQ6Z+hX3yprBMj2z3ZKrY1mnC977Bmi52Z9bo5+7LZyA4Tss9IVytPv35umfn57
         23PtC8JojqDYAPISuci3jn2WTtj6ZlMxBk+coto7TTdPMc7LNIk1amiRG2ubkhEfq2+J
         oNR3E7qdzqttY7Wkbciiunj8v48Fn07hRPvWF05QrAseqSr2dQYb6J7HLG6VCsWh5g8o
         i3Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVIHsJfOFOEX5qEidIyOJAvVocYWzmjq/5zpewDUBAwNfZCIklpjZQT2pEABzkhFy4XrDiiXzTIn6xd5tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydAkcrLeJzBDiMYAHkdDVsxrJfzUK5laUszvxsMO38/QCSHVPW
	6R/805W2/plSOoeOps8LKawzIxm8Gbd4Vl6JavmIVIbpWIICAEnK
X-Google-Smtp-Source: AGHT+IGJqWNwBZLbYT6vbePx8jWvkWRzrJYFIR3+4t2mkMpl1f2w1a8JNdXAYDwQYUAn9q5m5QJJuQ==
X-Received: by 2002:a17:90a:b00b:b0:2c9:6278:27c9 with SMTP id 98e67ed59e1d1-2d646d5dc70mr1749587a91.38.1724410225029;
        Fri, 23 Aug 2024 03:50:25 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d5eb8d235esm6074344a91.6.2024.08.23.03.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:50:24 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
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
Subject: [PATCH net-next v6 0/7] net: stmmac: FPE via ethtool + tc
Date: Fri, 23 Aug 2024 18:50:07 +0800
Message-Id: <cover.1724409007.git.0x1207@gmail.com>
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

Changes in v6:
  1. new FPE verification process based on Vladimir Oltean's proposal
  2. embed ethtool_mm_state into stmmac_fpe_cfg
  3. convert some bit ops to u32_replace_bits
  4. register name and function name update to be more descriptive
  5. split up stmmac_tc_ops of dwmac4+ and dwxgmac, they have different
  implementations about mqprio
  6. some code style fixes

Changes in v5:
  1. fix typo in commit message
  2. drop FPE capability check in tc-mqprio/tc-taprio

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
  1. refactor FPE verification process
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
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  |  92 +++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  12 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  20 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  30 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  85 ++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 274 ++++++++----------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 130 ++++++---
 include/linux/stmmac.h                        |  28 --
 11 files changed, 452 insertions(+), 237 deletions(-)

-- 
2.34.1


