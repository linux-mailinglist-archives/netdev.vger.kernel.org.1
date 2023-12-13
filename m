Return-Path: <netdev+bounces-56828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE5A810F5D
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5EE1C20967
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2270B23742;
	Wed, 13 Dec 2023 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0hJ1xlD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF623740
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 11:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3696C433C8;
	Wed, 13 Dec 2023 11:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702465648;
	bh=qeHcGu+cqpueuzzOHNMxP2bi/V2IKukDx5WaAQ3io2I=;
	h=From:To:Cc:Subject:Date:From;
	b=J0hJ1xlD7C6izgIls3qD5GO9UOvsVzz0B7Isf3z8GgihZaCiuJszZHdQdjrotpe8k
	 xXY9gs4tIayTZARJPrYzo+BNLXJEvJfGrUOaIWTlFoxUQHcDU+oihmsYsyCKzEapsC
	 2pbxhj6zqrkIxAwELm/W2guhf9cYtIYsAqusBxhx1srR/l1hBS0MfHMroNfWB45Xgv
	 yWe4wU8doZIgqQ3mS4ENffZEYrbsY0XUFqAc5GFTiLAnrWyhnV63bhtRPfB7LEyegn
	 pqgN1JHTEJqO+diU1j1UsoZNYjiyQMQ1Od05hr9ycs+z21wAsLsgn7jvgwi7GNpPIb
	 j/8J1sfxYFLnw==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	vladimir.oltean@nxp.com
Cc: s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	horms@kernel.org,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rogerq@kernel.org
Subject: [PATCH v8 net-next 00/11] net: ethernet: am65-cpsw: Add mqprio, frame pre-emption & coalescing
Date: Wed, 13 Dec 2023 13:07:10 +0200
Message-Id: <20231213110721.69154-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series adds mqprio qdisc offload in channel mode,
Frame Pre-emption MAC merge support and RX/TX coalesing
for AM65 CPSW driver.

In v8 following changes were made
- added a new selftest patch to use aggregate stats if
   pMAC stats are not supported.
- added a patch to rename TI_AM65_CPSW_TAS to TI_AM65_CPSW_QOS
   is added.
- added a patch to fix mac stats reporting. we only support
   aggregate stats.
- build issues if TI_AM65_CPSW_TAS is disabled is resolved.
- selftest patches are moved to the beginning of the series.

Changelog information in each patch file.

cheers,
-roger

Grygorii Strashko (2):
  net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
  net: ethernet: ti: am65-cpsw: add sw tx/rx irq coalescing based on
    hrtimers

Roger Quadros (7):
  net: ethernet: am65-cpsw: Build am65-cpsw-qos only if required
  net: ethernet: am65-cpsw: Rename TI_AM65_CPSW_TAS to TI_AM65_CPSW_QOS
  net: ethernet: am65-cpsw: cleanup TAPRIO handling
  net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
  net: ethernet: am65-cpsw: Move register definitions to header file
  net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge
    support
  net: ethernet: ti: am65-cpsw: Fix get_eth_mac_stats

Vladimir Oltean (2):
  selftests: forwarding: ethtool_mm: support devices with higher
    rx-min-frag-size
  selftests: forwarding: ethtool_mm: fall back to aggregate if device
    does not report pMAC stats

 drivers/net/ethernet/ti/Kconfig               |  14 +-
 drivers/net/ethernet/ti/Makefile              |   3 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c   | 249 ++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  64 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.h      |   9 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c       | 708 +++++++++++++-----
 drivers/net/ethernet/ti/am65-cpsw-qos.h       | 186 +++++
 .../selftests/net/forwarding/ethtool_mm.sh    |  48 +-
 tools/testing/selftests/net/forwarding/lib.sh |   9 +
 9 files changed, 1103 insertions(+), 187 deletions(-)


base-commit: 70028b2e51c61d8dda0a31985978f4745da6a11b
-- 
2.34.1


