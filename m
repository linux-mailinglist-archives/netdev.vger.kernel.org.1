Return-Path: <netdev+bounces-124933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6838B96B668
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C781C217E6
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB721CCEC9;
	Wed,  4 Sep 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxnen0D5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA651CCEC4;
	Wed,  4 Sep 2024 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441731; cv=none; b=qPmdKeEzgGvw6m+E9xrc+PW30ResyZkJkS0A5qCnQ16yKvyIWB53LFKzJLJDm7F3tTzPKoKFEVBVd/JSdL85N/Is4RDoFnD7av4T5BMrH5DWThC0Da69Pbh3rMokI+NZMc5jOk3SNyFxsfEeE5P3/Be4l+qq6u9qmKIHcurZJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441731; c=relaxed/simple;
	bh=M/YMBXSKsJJnQYD9L+NPHiOgp4jVmpfZWlI+u6bgPpw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RA34y4puE03Amg4MLvOQJQjR6eeAekcFYcSfdlRM+o1YI+Ds/ClR9zZRbh6A8/jOLHd7X28IACTWc9A5pHfBNKDjqnPAzxJh9t091+gCGkQhJAr6iq6PgD6GYdYdszgL4i7kcMgn8KK4uvVfZacfR9i1306a8u0jNUQEJ3lYCdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lxnen0D5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7177a85d092so436831b3a.3;
        Wed, 04 Sep 2024 02:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725441729; x=1726046529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xdbrukLjPRrEeDE2KtUX1s95Lzj5JQAy01g2Kp/GPkM=;
        b=Lxnen0D5BjiEdM8apdSkBOwWeBXzBV61cDHtsVk+/TCyxRo7VS4l7UogbSntqk5Q92
         m0wR3TnwZT16m/G5ZB69HwJyBXsUFiVRqrlvHyZygn6eAiPImTDkPuxGqGDChSTGvjiC
         ZEWFlJubb9FV0iKrrRTfuV1F9o5BfMAec2Sl1UJhyXHPaF+g0ndkTfze23kWdgKMk33g
         /pdPM2xo1qdaVQ7KWzQ0pPs0hDTkdKZDdHynf9QrMsCf7pZ9hYh8aIWdFb00j8Drumof
         CVBUOcfTNARo/uA+75HP31hg4GSPd5Ny37tSCqkZhB23zgPLsErr9i4c8yOdD2tCacti
         Eatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725441729; x=1726046529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdbrukLjPRrEeDE2KtUX1s95Lzj5JQAy01g2Kp/GPkM=;
        b=hZkS6SvI+taTIU2wBfGtM+9ZDpZKlCHjdtJ8rM8wVC/97MP08yoha/fZXJwOJU5gK5
         wmBDEi3FdulSdO/Y1m46nhu7twQx6HFrzPFzrsv88wKHlSt2JccTAxMTYa4IDmVSStEr
         5SECpeaMa6ErIdMzi8xhVZBUuaV40yxUcxC6FyMpbpNteqBwTpcRlRB5eGE9udpX/5I5
         g4JWGfdR07qGMjLzh35w4FKGh42SRq7LSiz7GC08RA63o1gnBzk7c0PK175Ume5HGBXh
         c2PmeeAXPCKQrYFbrbJYa02s6zIvl3eZLakJTprMbD7W+3XVwZWlooCpdLkKkimquWns
         GNig==
X-Forwarded-Encrypted: i=1; AJvYcCW5MO0HU6BI+KOhpTemc6ijNpINfW6hvUe1z5GDK6GW8kGmaBw0hTBScA9yboZDSmmD6U42U9HI4UaarnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtoGLoF1HEbkDQKDIV/843KFhD3knOsmz4tPJ7FVchBpBxEu0m
	MfpNfIDuEQyqC05ctLRo2geljFPKICre21QTDnfweb7yPRKvp2KJ
X-Google-Smtp-Source: AGHT+IHZoPSnLfOD0195kXHp8FwhTb/QlnwaX/dwZNMNqywXzjijSFZLEA80Dx6SgU0+jMbZWZ9AEQ==
X-Received: by 2002:a05:6a00:2789:b0:70a:f576:beeb with SMTP id d2e1a72fcca58-715dfc3a15emr24155318b3a.15.1725441729432;
        Wed, 04 Sep 2024 02:22:09 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7177859968csm1232048b3a.146.2024.09.04.02.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:22:08 -0700 (PDT)
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
	rmk+kernel@armlinux.org.uk,
	linux@armlinux.org.uk,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v7 0/7] net: stmmac: FPE via ethtool + tc
Date: Wed,  4 Sep 2024 17:21:15 +0800
Message-Id: <cover.1725441317.git.0x1207@gmail.com>
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

Changes in v7:
  1. code style fixes and clean up warnings reported by
  patchwork netdev checks, no functional change intended

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
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  |  96 +++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  12 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |   9 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  21 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  30 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  91 ++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 275 ++++++++----------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 130 ++++++---
 include/linux/stmmac.h                        |  28 --
 11 files changed, 467 insertions(+), 239 deletions(-)

-- 
2.34.1


