Return-Path: <netdev+bounces-120117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851695859B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C7C1F2549F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34105188CB3;
	Tue, 20 Aug 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T31tIMe8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341A18E351;
	Tue, 20 Aug 2024 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152883; cv=none; b=coKDp08QoOKxYcjatAj70tdk0cq19L/H6HD+m4//LIv26/+LzNhof5lzijuwvV8LzwRaBZXDrIJlQ3bPoLlL5YufJROWT1UYFs/V8UdftffipR0N/BqNw/zAvCqm1iPFBGFWQ2wZCgJaWE61HwNGmlJ8KfEpHyrAcPT69yTisPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152883; c=relaxed/simple;
	bh=QWn3brooeiHVfcyF/vvUkq4KqOQeevKpNAslvGKTuQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QQkejjA3mQuBwWTik9dmYi83vWGcn/L1eO5l27B2LjWv14h8qgIaiW35HWJDt0wU3quxIVV+W8yJjKPWznhvlZPg3n/k9Iuv15uMUBaCyWzY1FAII61Pxs7RNbfn8o9WF0H/F8J+lceyxvtABQsgCFYHaxm/j0u+0bpuHbZCQv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T31tIMe8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201fae21398so31381485ad.1;
        Tue, 20 Aug 2024 04:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724152881; x=1724757681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbDMo5MbDihkl8ZyjdgPltbmTW4XyoUcFA+9KEyX+yo=;
        b=T31tIMe8QMDoO504CBlCJ6hZ3LxOkS2lLpUqzWk4M3IaYWa5ZkkiFZKnT45VKhBfjL
         GoA+MHIsnxsRzV5342EpKukdZxOFs3+ZwpCTxjlrg/7zQ2lCl7cdpB6zXmg9ZHlx0qpa
         3FN+5HPhHVcgCBJlXDZO+L+dhtBHFe+AybVoYqYNFPotFDT/GFm4bE/CIIbe+HRCivpE
         liNAYyxlRy0vKyTbOqJn3+wlsvS1uRK49iV6ebjx50P+W4596OIZFnft5K/POqQBF+ax
         Cd6Meyuiw6Q8BPy6GiCUCTwCtdA15w5mQMUu+5IBIli6gaNNNHBTEycVHyGCh3lmCrEU
         WxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724152881; x=1724757681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbDMo5MbDihkl8ZyjdgPltbmTW4XyoUcFA+9KEyX+yo=;
        b=l0Bl7S6VwTcHBZ+/L7bzDa5Y/Q+qdgooqsLgStFYhtiz9T3mYD32ScfT86xdLMmtaP
         FbYVbByZhBcjvutbshTK/eTbfOrrFnXAl16TRPIAj1qELhfQ2YFzsI5+2YWcFuJrXvbe
         6xFap6XDgQ1UKmaxqqG29+jJTFQH7ut64BO4eToiqVYQGuboRdVOFIRsMbuvyv1ZYIRJ
         ZsR3OcG8JKhQWJMqIZSPX/DdO3B9CBzoNaQQULv4ArOQH9DrQA5GV6bmKZevffe7FHGA
         vWRC307eqdoArEi6mjl0aG6ihaF8SoXZG6smg6S0B1gJIwX9fFbebYTdIdTd2yjvYgse
         bEQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkI4DRcorW7aT6jIGnFfeRpHYaitnRUuSvnb3qX1ggozP3OL6YQITJvLQGv8Pv2+aoBzByqq92C6ovgHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxigTW1kSjcaZRn3PzWCKvzrG6FbVdNsp/CaHbpeb0OUfSOO9Ws
	JpkpKPD+gM7aYq9Ot5YML07tF4vQ5CWXprTfC77A3lQbkp0XvxKf
X-Google-Smtp-Source: AGHT+IGJyPKgTlfpaaVO2Q89NFOvgDCYB02I5tKaJmY5LED7+9l9qf1xzzx6B/7gPkW4vruDFFPBYg==
X-Received: by 2002:a17:903:2303:b0:1fd:93d2:fba4 with SMTP id d9443c01a7336-20203f321efmr127662545ad.48.1724152880582;
        Tue, 20 Aug 2024 04:21:20 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f03756f6sm76465355ad.172.2024.08.20.04.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:21:19 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/7] net: stmmac: FPE via ethtool + tc
Date: Tue, 20 Aug 2024 19:20:34 +0800
Message-Id: <cover.1724152528.git.0x1207@gmail.com>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  |  96 +++++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  11 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  20 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  27 ++-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 110 +++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 214 +++++++++---------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 120 ++++++----
 include/linux/stmmac.h                        |  28 ---
 10 files changed, 455 insertions(+), 185 deletions(-)

-- 
2.34.1


