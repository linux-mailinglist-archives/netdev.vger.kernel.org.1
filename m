Return-Path: <netdev+bounces-125397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B3D96CFF6
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FE61C21B28
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21071925BD;
	Thu,  5 Sep 2024 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zdtzjgg2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7291925B2;
	Thu,  5 Sep 2024 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519780; cv=none; b=tn3V6vPMbzP3K5VfT3+XTqMj5UO53YEwOKGTJc29j/lRJ4loEy7i9p9PMwOJ/jQdr4ImiWNDuxegHU9yA0Fdzdjaiu/WI0pdbOJw4EVYowusLgmGOC2SBe9AwkkvF+9xCijjERu4tgckfsCANrt4jD+JTg+DOsLhzrCj088r38k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519780; c=relaxed/simple;
	bh=Xc98z3pf9jzk64noew6FjkFzwjrhgpzK9PUf6lhiia4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xt1T/R+O2F3H9z0NKM34udWbWQHqCEkbjWNU4jT5ZuUz1KSW60uLzxxPayIKGoC/OmNE9xJ7dXRpFcfUAzAc9w2+3MeiLggqftZ1ivuJLkLAOJmqmPzPY7EgD2WD8GGc54AMRsYmIMjMCMdvhVzOZfTHel1gtwjrRxGQtBgUdY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zdtzjgg2; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5e174925b7bso298835eaf.0;
        Thu, 05 Sep 2024 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725519778; x=1726124578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gGPyaa+1WDEMchRcuy5C5zdpNT7E1IN97l7V6rYpwAQ=;
        b=Zdtzjgg2B8cA8fC29sMy3JRWkJVrviRPuYw2N6QdVBKaHZM1PPtRNROT93L7SUuVJ3
         wjKpuuyxntaiEiCxzYn4XJVqSF/iEpD24hgimJ/jrsoCZ3dLdFDzlyYftmK7/2h4LMYG
         lcG+2ZVoPT/kMaRs82YSh/O01N0130In8BBhMoqC2xQLkQ2wsBQ+vRdA+LRrRqvdC1Bt
         g0SXZyNKHwAFBGwzu3ozBBNka4hQhFc0WWoEceHJ2FQDG4reoobvSbinaDPH62Qs18l7
         ADB8tPrF5F6GKHFR3lrWO50tTYydZFnEhWHeKq6Hud22cyZdyOyPC8saHdQj93Zqu6mZ
         oqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725519778; x=1726124578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGPyaa+1WDEMchRcuy5C5zdpNT7E1IN97l7V6rYpwAQ=;
        b=Gp4SNIqJNdargsDtRt3EDICmtF+WmS0LCOjyTjQvii4ZUgFQWyQ9lsJtt1XMdz6DjT
         nV2jdaYJyfROARlHiZNwT9tWZbxfItYHHUak1f4G9QnAazIWMOr41PiQeSUyWyQ3E313
         0yhv2B2NwRmVmFP+sXkZxsOZFGP+WR7TUemKf/98zSI1+SaIEswJgt88PvwQUhWLS61z
         0EacP1t4i2BEh9FPhCsuKE2VQiBTW9QArA76cLXtCA+Bl5I3ccOr0g+xdrZivyvgY4HN
         GzyCKO5Q8HkGLgKeHBAVRZBRgtgMCaBvjaQ8pC8rh6JRPPz5382AqyNheKDPBJVxTGPN
         ZKxA==
X-Forwarded-Encrypted: i=1; AJvYcCUbA2OuQLRWV1fMqLgcaXQ3v/eKXgxec3jTQT1oLdhqt3aPyMYXiLo9vGCR77CvB7p/6J577rfjm/BZB1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbhPZDFxu0pbBIp9oSXelZ4qcKrPnyqMedu9GF8GV5AgNpr4y
	3AWiQ0G0ABhiun2zdUteuZ1yk/dcFNTq5oE86vl/ehx/oC/1jOQ3
X-Google-Smtp-Source: AGHT+IFEQpZl3ZnRXG3Y8a3KH8gtlt/4cKxL4Zrb6w6RD/CEHqKTJ40bzqvmaOsEUf2ErIgac3XQsw==
X-Received: by 2002:a05:6358:590f:b0:1b7:fc1f:5b95 with SMTP id e5c5f4694b2df-1b81240f229mr926884155d.14.1725519777913;
        Thu, 05 Sep 2024 00:02:57 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71778595107sm2604897b3a.150.2024.09.05.00.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:02:57 -0700 (PDT)
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
Subject: [PATCH net-next v8 0/7] net: stmmac: FPE via ethtool + tc
Date: Thu,  5 Sep 2024 15:02:21 +0800
Message-Id: <cover.1725518135.git.0x1207@gmail.com>
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
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  30 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  91 ++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 276 ++++++++----------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 153 +++++++---
 include/linux/stmmac.h                        |  28 --
 11 files changed, 491 insertions(+), 242 deletions(-)

-- 
2.34.1


