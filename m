Return-Path: <netdev+bounces-125775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED19696E8CD
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 06:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E481F24EFF
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 04:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E5053370;
	Fri,  6 Sep 2024 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1TP/rjR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6E4AEF2;
	Fri,  6 Sep 2024 04:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725598602; cv=none; b=UG5cRQeVPswMF71OuTSHlDr+neADkKz5GAC1APcFteHaxSLBnuBFaJd4hTnwYpHwa5YHFiPRD487M+vlgxP+xIeLH/cozQ2MKVxT7DiTqDGMwbQzC5su9+/Ww/4C93Uq//Hs6pXaFO7sJX+deZpYULOY+cVE7Qe88ZsZi6zPKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725598602; c=relaxed/simple;
	bh=06NYwGV/b26HXwoNN3RC4u3U54HUhPzpWQfYgTicPjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XLdItsNxpsGQaKh2j26eY5o4tF4A+IgvrS4uwD3S2Uifd/mG1zd2f6/fj3lbxvgFEjYcoD7b3p1LaUjrUL/QnMftIQs2gnRlr1uAs6X4qufLFWygQTaC6JSXgkKYPWUMON5TQQdRtOH0Ega8Wq5bDy2BX5CrNGq5ZKxgo6p2BB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1TP/rjR; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5e172cc6d66so944693eaf.2;
        Thu, 05 Sep 2024 21:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725598600; x=1726203400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ob3grukux8jAuJGDrQV1ST/lFWPUfHGs10KzV3SCsCg=;
        b=W1TP/rjRtctScPxoABA57O92qtfzQO+TPirxFuJ5pWMTRlHw3qCotud/Zxhbs+bcrP
         DqonB3CPx3LHQpAEdBh283asaN96UnN490lFMhvCJymN3B5kOE88eJlnPaPZKHxBQLQU
         0LNZNHVHJiPPMMd9QNhCIVMgOJPlTisxmg7neU9x5L7ZRnlXlQALsQjiqMoNFREKIfIy
         Tzp8SHcHZWX8AN2kxaSANtc1ZaSBBm6WzLKq2gXUjsLQAgptW2hbByLlgE5H/jBotxbL
         RJkNueSowZmbQxvidFImTC1c36lfQkriJ7UawXDz/S5fddSKxasK8/ynE7Ck9iNZIzdH
         MpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725598600; x=1726203400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ob3grukux8jAuJGDrQV1ST/lFWPUfHGs10KzV3SCsCg=;
        b=S4iy08JztFMyLAmAboffuAWjoBcnH57kZT5kNsMTMRFupP2b1xAiwNCcKiypgxLKAu
         LgIDAbmS1+kzho2iFIG6//5xe7/znEJljmuiaBcl5IzQc9HIKyLjVRMud15rW5I8x4oE
         3MeI8MJI6Y0j1eqbOA50CF/rNyZ1ThsNPL+Z6/oVufT9z2UXLMnseMIC0iLVXLiP437x
         DLOB9p/9CXgG7sLdZVhvjD7q6RlRuDpzRW41gCQFe/aecgFt8tYZkql6qSCsxWR1Ipcy
         YKOxDhA6SsoKe96UcJumcQjtoH+wWwsyk57UfZysZBS13+xH/HRLlx03SkqsVUVAODym
         2GpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvUwzaK58ztum9XS9ZRGc/wG+4TDoG7n6zmTFycdMmTRgnJpVpXSnIUzx3/rzXSwQhUHfwYIpDUws275I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXMqCg5xQmsnhbcxE0TwQSgsz0B40CXJBbs0raG0Ibp5ubagX+
	YaeKqlTsLaScqY2KwfHldRhubMXm8aFDX2cocRAwDyhBsBgxR4vt
X-Google-Smtp-Source: AGHT+IHer/O4jKLDfgNK47fqGGGDsM3FDOhwLhyyoIVhUdPzGfkP+qXtM/YrAO9Wg+uMGV5Q3zd+5Q==
X-Received: by 2002:a05:6870:330e:b0:277:f925:4f67 with SMTP id 586e51a60fabf-27b82db385fmr1794920fac.4.1725598599821;
        Thu, 05 Sep 2024 21:56:39 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71791e54585sm1704002b3a.182.2024.09.05.21.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 21:56:39 -0700 (PDT)
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
Subject: [PATCH net-next v9 0/7] net: stmmac: FPE via ethtool + tc
Date: Fri,  6 Sep 2024 12:55:55 +0800
Message-Id: <cover.1725597121.git.0x1207@gmail.com>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  |  96 ++++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  12 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |   9 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   6 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  22 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  35 ++-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  96 +++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 269 ++++++++----------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 153 +++++++---
 include/linux/stmmac.h                        |  28 --
 11 files changed, 494 insertions(+), 242 deletions(-)

-- 
2.34.1


