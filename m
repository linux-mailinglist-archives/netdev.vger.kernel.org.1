Return-Path: <netdev+bounces-125958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B24296F6B2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7E41F2468D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B789E1CCB27;
	Fri,  6 Sep 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs2vY1F3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371F3158205;
	Fri,  6 Sep 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633040; cv=none; b=awCcQK3IcL4cetyK9mLP65WXb2BWFgreiVYDoL0iSZLe2pS5BEcv0be123MSWnf2rt7jjcZkvL5kqmqokAkllkdZSgZKMvvjM9cKQF6T1sw8vI4H6v4jT8VXYYjq/4Mmb7UE/Gs2qF0l62asRQ+hqaMVbiti1ODffYcgG+yCl50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633040; c=relaxed/simple;
	bh=Uyzy0dVDftAmKGNv8/hmedP5+MhkU6woP3I6xQmsLiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TrqNv7nSBETX2gn8Jw6e93cwLfUIhb592HfmojrG86GBa4V11iayiDpPo4+KPq5DmcFrN4kUQzG24XLjihNFMG3fBEXOn9iarNViKWmM2IpJPFsXTEU4WePwGei8mZn/88H+zf7TlXNKpL4nfv0+D7OnImU+Au5pIlFnLBMCRyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs2vY1F3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2059112f0a7so20489905ad.3;
        Fri, 06 Sep 2024 07:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725633038; x=1726237838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MmOkWe3bWYqlIPHasXuyjR6OTIRVg7CwkvkDyagLUMA=;
        b=fs2vY1F3X6fsOo3xgUumCMdx1Azri8q9KUK4HHLZ3d8dPzbOlpDl6MqJ5abOpIyjWq
         n4y/wMchqFEwOQ8QD4E5nDJJzzvL7m3cCWP1VRN/Lv2Zeee5jub7hyvNhvYoamicJpfk
         6jCYzvesuKYXf6RiRDSaPMPsBHeTAqs0wztekh33krTlgXkg+uoc8RjvGPRPX0zbfxbU
         QXcOeSbkSO//ORmIyP4pMG8eBPjznzNB8unjsXiC9HsOBbxqqYNtlTwFeDZ+69MYm9xl
         bXUTl98VwWv1MEQTcIV7OCYHo3BMHTHxsOR1yL9CJfcVekEj4UV6C7QY35KOTqLr9TDj
         Z59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633038; x=1726237838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmOkWe3bWYqlIPHasXuyjR6OTIRVg7CwkvkDyagLUMA=;
        b=KOZtel4pmXOn//g0zYrkdUVzXtZiR7bSgw3a/tEv+iLMv9J5nPFJQKrOnoIUwKjyx9
         fkwWYvD+8ImQjTPtFpXJpDL89mAElfzbro0n4QymBdqHNWzzJmNgD88adcLyrRSehI5w
         IiJIA3uf/yn0UMtAYYKL5wIzDLprggT8DBQ0gAp/905EDtSaqvOzhIDqF7HU9HvwpnTi
         /sd7I7mTMErlXT7/Ol1kPu2Bc/LORAN3FGs94DMPgA9wbrO4V+nwJHTejDQkbKqCoKVc
         FFuaho9GzBxxzU2x46zWDs11FtLEQE9sxbLPMcXS7CSziuK+ImL8Z2FbsBhBiqtmUESW
         J7kA==
X-Forwarded-Encrypted: i=1; AJvYcCU3xmNEpY0vEw7US8rbomQtz73Dj2IDXvWocNNsBVKb39bvl1wX6VZ26NiMi076N8ZdvZKIK7K3HzSLAxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxkm9YxU7eYZaBnPm6IWLSxM8zc2k+8Pxmq3UCY7NeVY7pzuF
	DCwHvK5pJ6o1kbImCg+5OAP+3zczlKeNfV80Ri7PbHZ8DGSMHWv3
X-Google-Smtp-Source: AGHT+IH6os/wJqKxaUijZ7r4QxSPQPk3BXwla9T3Qa9yn+zWQ8nBWAVCPpLlT6hUmihDvM4+R20QHQ==
X-Received: by 2002:a17:902:f682:b0:206:a935:2f8 with SMTP id d9443c01a7336-20706f02a27mr681585ad.2.1725633037708;
        Fri, 06 Sep 2024 07:30:37 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae94dcf3sm43951975ad.80.2024.09.06.07.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:30:37 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>,
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
Subject: [PATCH net-next v10 0/7] net: stmmac: FPE via ethtool + tc
Date: Fri,  6 Sep 2024 22:30:05 +0800
Message-Id: <cover.1725631883.git.0x1207@gmail.com>
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

Changes in v10:
  1. fixed a stacktrace caused by timer_shutdown_sync()
  on an uninitialized timer
  2. ignore FPE_EVENT_RRSP events if we are not in the
  ETHTOOL_MM_VERIFY_STATUS_VERIFYING state

Changes in v9:
  1. drop redundant netif_device_present() since ethnl_ops_begin()
  has its own netif_device_present() call
  2. open-code some variables of struct ethtool_mm_state directly
  in struct stmmac_fpe_cfg
  3. convert timer_delete_sync() to timer_shutdown_sync(), thus the
  timer will not be rearmed again
  4. fixed variable declarations in the middle of the scope

Changes in v8:
  1. use timer_delete_sync() instead of deprecated del_timer_sync()
  2. check netif_running() to guarantee synchronization rules between
  mod_timer() and timer_delete_sync()
  3. split up stmmac_tc_ops of dwmac4, dwmac4+ and dwxgmac to give user
  more descriptive error message
  4. fix wrong indentation about switch-case
  5. delete more unbalanced logs

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
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   6 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  22 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  35 ++-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  96 ++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 273 ++++++++----------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 153 +++++++---
 include/linux/stmmac.h                        |  28 --
 11 files changed, 497 insertions(+), 243 deletions(-)

-- 
2.34.1


