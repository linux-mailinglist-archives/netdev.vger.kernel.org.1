Return-Path: <netdev+bounces-192685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37642AC0D33
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB2B3A80D3
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54E12882BC;
	Thu, 22 May 2025 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KfS9Yft5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4A23BF91
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921753; cv=none; b=KjDwJRYcF4GWuSD00T0dngdvcTnufhiwGTVFA1vJSlvcatV2Ou/2DydIB8pWaTXV8r+ZeuJ8M9ARrp3AuSHLTNVIF5O9K4t5fy1vKv1tPRTJL7Fjt6HeZWvsuj11YjOmblV6YOfFQao2AkLJkcJMQhxoVy8B3G3nvoiYyx0YFKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921753; c=relaxed/simple;
	bh=ulYQMl8r4K46bpzLvggxODwBYxY1spM4Vx1vtzKGbUw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eq/N0k2r6Tj5zdh3+00HyAdaTP6bqP7Ufqz8eQhuZkO3rbLpDCvyDYyC7fyg3J6S5u7F9YzXK/SXDGa7kSoUeJjEyreY+6PKUPXsqT319ikPPVzSB4vXpITx9Xs03yB+TSuoRyICSYHKU9EsWky1Kcz9t9UFo+kLvh56SKKTzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KfS9Yft5; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747921752; x=1779457752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UMRfJjjDncFqt5W6DhaB5wNJN6v/U2dzG5EXeZtOlTE=;
  b=KfS9Yft5bBflNmcM7lTC2nSu2SW2tqZggHozgCN+0pNQgnLAAzrueO7q
   foXWH50VIBSfuu05Xli6g5cN/52P62yo4NyNBp5jThQe6zU5qLpZSuxQl
   fH1JsOgwVnjsn8leKFnbUNKL+RFEeLkGRCrba+3LYBJin+cg4BeNMrk0C
   Wo8CE0ox7hOS8Ir/NLSTaZrHLp021kKiRR3ccsGfS2F2s57oPhrD4nVxE
   6NbwXDYyC3pLQWBHOd5u/UDfZ7t8shjlM01cHUnLAKn9U5mLZEDQ6NCil
   jXEeQyKjbgSaI2PK5OnUzVIlkuZ56nPUYJ4CkO+/pkq5R/6nwlQS2Ag+D
   g==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="96243644"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:49:10 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:18946]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.135:2525] with esmtp (Farcaster)
 id 3ecb85c4-9f04-4354-a29f-c220e88c7fba; Thu, 22 May 2025 13:49:08 +0000 (UTC)
X-Farcaster-Flow-ID: 3ecb85c4-9f04-4354-a29f-c220e88c7fba
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:49:08 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:48:57 +0000
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
	<leon@kernel.org>
Subject: [PATCH v10 net-next 0/8] PHC support in ENA driver
Date: Thu, 22 May 2025 16:48:31 +0300
Message-ID: <20250522134839.1336-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Changes in v10:
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

David Arinzon (8):
  net: ena: Add PHC support in the ENA driver
  net: ena: PHC silent reset
  net: ena: Add device reload capability through devlink
  net: ena: Control PHC enable through devlink
  net: ena: Add debugfs support to the ENA driver
  net: ena: View PHC stats using debugfs
  net: ena: Add PHC documentation
  net: ena: Add a DEVLINK readme

 .../device_drivers/ethernet/amazon/ena.rst    | 126 +++++++++
 Documentation/networking/devlink/ena.rst      |  25 ++
 Documentation/networking/devlink/index.rst    |   1 +
 drivers/net/ethernet/amazon/Kconfig           |   2 +
 drivers/net/ethernet/amazon/ena/Makefile      |   2 +-
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |  74 ++++-
 drivers/net/ethernet/amazon/ena/ena_com.c     | 267 ++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_com.h     |  84 ++++++
 drivers/net/ethernet/amazon/ena/ena_debugfs.c |  62 ++++
 drivers/net/ethernet/amazon/ena/ena_debugfs.h |  27 ++
 drivers/net/ethernet/amazon/ena/ena_devlink.c | 209 ++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_devlink.h |  21 ++
 drivers/net/ethernet/amazon/ena/ena_ethtool.c |  16 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  62 +++-
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |  12 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     | 233 +++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_phc.h     |  37 +++
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |   8 +
 18 files changed, 1258 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/networking/devlink/ena.rst
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_debugfs.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_debugfs.h
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_devlink.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_devlink.h
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.h

-- 
2.47.1


