Return-Path: <netdev+bounces-119589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999E495648F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFE61F253DD
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2880C156F5E;
	Mon, 19 Aug 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0E0A5xj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F4B156F55;
	Mon, 19 Aug 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052359; cv=none; b=nZ20D6iV8/W/9NlGt9WQVicSkUYSOcVPJuPMdSQXSSGJa5fCeb5er+bq6lr8wVuYCMTh2iev1Bc2k2zeX4yzPh/ZKvBa8D0sSRId6ddjJDCgabv6ncPRi70isc+xEVTI7t1e+wv4yQybGUETxRBhvXWahk3C3Tcda2JfgdWDD1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052359; c=relaxed/simple;
	bh=HjsgPBVS4fiFNwkXSSzXdmsx82NSbDaKaPaXgI01UT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nSurK10G80YAwKxlVP8qjkwSYCGt1Sjfugbc6kArjAgMFO0/xTv4HhgXV6SR/clXXgkOrft77xefc6N5yZzl9w6NIrL/1keTBzFTrQGX3SZXl8c4xGhl8FktfKfkouOQQUHaUP2lThN2ZyoRcJuuo2VBBLsddMG6IYDouqD94fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0E0A5xj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-202146e93f6so23526695ad.3;
        Mon, 19 Aug 2024 00:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724052357; x=1724657157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMxRPL+T8UIjCQfC5kIWgTFU9+0G6pZaJzB9qUuJpIw=;
        b=W0E0A5xjU/cP3ZBPSXmkRYxRoQrW9n0CFExvxacjT6fYeKn2km/PdMPVofxdvGxqKC
         rdsEzV7vpmdJTQIPAmt2BGz3BMPTszVxa3PBcnD2EzHHaYkUtEZTNwhT4YEtMXO4y6x8
         zP8rZ65KTiEWSjhPeih2Q+yt7AVg6puovEUJzBPvJYx12u4oakNRoVvmtuSWkcpZmIXl
         e7UTXTD+vxLSAFW6VkuOlldvIGjFVxub7tMVmKrXf8G1zASSMU2Z1VLXmKtlqZBbNwM6
         0Ramv9d6qPyLPNr383NC6DK0SofPmhTsaHvMK7guAonzSM1q6OsSzfxxacJuZ9SlExll
         7/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052357; x=1724657157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMxRPL+T8UIjCQfC5kIWgTFU9+0G6pZaJzB9qUuJpIw=;
        b=TKtbYXgyCDNWLTc0ny9zC4AwGZSAqddChDVF5lbErHhX/7ko6/ER+Q19fDDZwuAs7h
         /rNVwd0ES9bApYfMNXi7bwLSV0qKrvKwWj4CILQyaH6SAPSb+jgt1664RjDJgvnyPML9
         r5FLvg/BdNJ3EuO/WuYpNC8/i4gL427dTEx1Ll1R1RkEbiUHqFS83e1nEdw7FIHFYBpx
         Z97G3GkawtFx1hyPlfeNK2AmFgZ+0ssRs8pwtEAPovGfbN48xOc26M0P9eV+J2u4nLHr
         TXcniXmJz+rp4aaAeHaXMffFU9zfoixGDsBIA2/2+rPgeOI5D5gGGDh7kd58xKGYY1Hd
         MH2g==
X-Forwarded-Encrypted: i=1; AJvYcCWGL7faCd9Z4HclKLcgo6eJLfwZAH58elLOc0r9pA8rn8InoOR1n2tatNXcunTlR9PnSFPHrFE5j57A+2GpwwNKURscoxcFEda+HR1S
X-Gm-Message-State: AOJu0YyPbXPVGtEj1fj73vg+UKsD9Cr7cPBWyJDy6JoYSatV5+QyPxzc
	6ByK0VOZ6/qeTlkEpGnGj5Boao+OIQMBuE2r46MfU89THI6FG834
X-Google-Smtp-Source: AGHT+IFs9U2vy6o8hrcgBG0WljZK09J5u0ZU7PDrc/0pefVklhHx0XndlbBF0rFOTVbCQeZRG7NQag==
X-Received: by 2002:a17:903:2303:b0:1ff:4967:66a with SMTP id d9443c01a7336-20203e88843mr117933405ad.14.1724052356689;
        Mon, 19 Aug 2024 00:25:56 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f02faa5dsm58340855ad.2.2024.08.19.00.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:25:56 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/7] net: stmmac: FPE via ethtool + tc
Date: Mon, 19 Aug 2024 15:25:13 +0800
Message-Id: <cover.1724051326.git.0x1207@gmail.com>
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
  net: stmmac: refactor FPE verification processe
  net: stmmac: configure FPE via ethtool-mm
  net: stmmac: support fp parameter of tc-mqprio
  net: stmmac: support fp parameter of tc-taprio
  net: stmmac: silence FPE kernel logs

 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  10 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  |  96 ++++++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  11 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  20 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  25 +++
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 107 ++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 192 +++++++++---------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 115 +++++++----
 include/linux/stmmac.h                        |  28 ---
 10 files changed, 430 insertions(+), 178 deletions(-)

-- 
2.34.1


