Return-Path: <netdev+bounces-196480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB38DAD4FA0
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF096189DB6F
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 09:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7EB25393B;
	Wed, 11 Jun 2025 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hrROcRQt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B02367AA
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633802; cv=none; b=fndhdWOCkpyDoWkPd4laVs/8Uxf2GoJjUFQBsTZuZIfu8qKLNGUtFD/35mBetqrylLKv+V793RIUgxkB8HVhQt31KCtqjOaf9N6dVkBikYeuQtwQLLgELMpWkZQc5LgZemWcyrmuem2qTT35Fnyg7XmOJr62bxdg+IyiLybkYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633802; c=relaxed/simple;
	bh=N+No3KjH/lv4Ik/F6O7eP4GE5lFssK6VQUI/1/dlBbw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ap0ThuhF4ei/PBeG4G//61Zt632crYpsS+i5tb8q41vKqP92bR4JEG2RjZB9Wp13ZtAdQj30cPILTul5PGXGUEreGC+NCGOd5fo4liz5ojp/c9BAtQO5u/Lsb+CyLhBMEyEv+d9SVFvcthDF/6tnn7UPAf2mCAqog8qd31Ln+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hrROcRQt; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749633800; x=1781169800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+p3t5Z2Q82TxrYMMtbbCK5/y1Pf98Q2phHZ2B222jlQ=;
  b=hrROcRQtMSmsKqFX5t/L05A5M2T4zC10T6+uJZhotEHK4E/wKkFffWXi
   3/zn99jxhpLOi8l5IEmnxqPY0XXlnZ2goe6OaJkjcHqLYS+ueRtAi1ybB
   U4m+ZNAEkpdOqmgZbjqqgjVIjZcNpqY8AqImccW481rMZVDosvSMQissf
   T9I1uA36GGRdztexOZzppiPrMbcLGjgNOGbgiOiGGpr/+yewqQW4c4lda
   kRvuxre2f/K+jcyjZOElQwwnPTMSFVdzvarONK+5zG20cfRbNgh/PCQfz
   JLQtBZge5uuftNCbcME05S1nahGPLk69L22F2zSPyzdWkBBuOgru4OGQg
   w==;
X-IronPort-AV: E=Sophos;i="6.16,227,1744070400"; 
   d="scan'208";a="834108176"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 09:23:10 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:32468]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.8.225:2525] with esmtp (Farcaster)
 id fb426341-2cd1-4699-9d0d-cdc62ef341a5; Wed, 11 Jun 2025 09:23:09 +0000 (UTC)
X-Farcaster-Flow-ID: fb426341-2cd1-4699-9d0d-cdc62ef341a5
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 09:23:09 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.176) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 09:22:57 +0000
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Richard
 Cochran" <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky
	<leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH v12 net-next 0/9] PHC support in ENA driver
Date: Wed, 11 Jun 2025 12:22:29 +0300
Message-ID: <20250611092238.2651-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Changes in v12
- Add devlink port support
- Remove unnecessary checks from devlink reload up and reload down

Changes in v11 (https://lore.kernel.org/netdev/20250526060919.214-1-darinzon@amazon.com/)
- Change PHC enablement devlink parameter to be generic instead of device specific

Changes in v10 (https://lore.kernel.org/netdev/20250522134839.1336-1-darinzon@amazon.com/):
- Remove error checks for debugfs calls

Changes in v9 (https://lore.kernel.org/netdev/20250521114254.369-1-darinzon@amazon.com/):
- Use devlink instead of sysfs for PHC enablement
- Use debugfs instead of sysfs for PHC stats
- Add PHC error flags and break down phc_err into two errors
- Various style changes

Changes in v8 (https://lore.kernel.org/netdev/20250304190504.3743-1-darinzon@amazon.com/):
- Create a sysfs entry for each PHC stat

Changes in v7 (https://lore.kernel.org/netdev/20250218183948.757-1-darinzon@amazon.com/):
- Move PHC stats to sysfs
- Add information about PHC enablement
- Remove unrelated style changes

Changes in v6 (https://lore.kernel.org/netdev/20250206141538.549-1-darinzon@amazon.com/):
- Remove PHC error bound

Changes in v5 (https://lore.kernel.org/netdev/20250122102040.752-1-darinzon@amazon.com/):
- Add PHC error bound
- Add PHC enablement and error bound retrieval through sysfs

Changes in v4 (https://lore.kernel.org/netdev/20241114095930.200-1-darinzon@amazon.com/):
- Minor documentation change (resolution instead of accuracy)

Changes in v3 (https://lore.kernel.org/netdev/20241103113140.275-1-darinzon@amazon.com/):
- Resolve a compilation error

Changes in v2 (https://lore.kernel.org/netdev/20241031085245.18146-1-darinzon@amazon.com/):
- CCd PTP maintainer
- Fixed style issues
- Fixed documentation warning

v1 (https://lore.kernel.org/netdev/20241021052011.591-1-darinzon@amazon.com/)

This patchset adds the support for PHC (PTP Hardware Clock)
in the ENA driver. The documentation part of the patchset
includes additional information, including statistics,
utilization and invocation examples through the testptp
utility.

David Arinzon (9):
  net: ena: Add PHC support in the ENA driver
  net: ena: PHC silent reset
  net: ena: Add device reload capability through devlink
  net: ena: Add devlink port support
  devlink: Add new "enable_phc" generic device param
  net: ena: Control PHC enable through devlink
  net: ena: Add debugfs support to the ENA driver
  net: ena: View PHC stats using debugfs
  net: ena: Add PHC documentation

 .../device_drivers/ethernet/amazon/ena.rst    | 126 +++++++++
 .../networking/devlink/devlink-params.rst     |   3 +
 drivers/net/ethernet/amazon/Kconfig           |   2 +
 drivers/net/ethernet/amazon/ena/Makefile      |   2 +-
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |  74 ++++-
 drivers/net/ethernet/amazon/ena/ena_com.c     | 267 ++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_com.h     |  84 ++++++
 drivers/net/ethernet/amazon/ena/ena_debugfs.c |  62 ++++
 drivers/net/ethernet/amazon/ena/ena_debugfs.h |  27 ++
 drivers/net/ethernet/amazon/ena/ena_devlink.c | 210 ++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_devlink.h |  21 ++
 drivers/net/ethernet/amazon/ena/ena_ethtool.c |  16 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  62 +++-
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |  14 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     | 233 +++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_phc.h     |  37 +++
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |   8 +
 include/net/devlink.h                         |   4 +
 net/devlink/param.c                           |   5 +
 19 files changed, 1247 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_debugfs.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_debugfs.h
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_devlink.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_devlink.h
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.h

-- 
2.47.1


