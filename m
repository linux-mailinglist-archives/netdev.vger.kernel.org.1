Return-Path: <netdev+bounces-198523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB9BADC90A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B63170C6C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43C92BF3D3;
	Tue, 17 Jun 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hDoCKKWk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A52980AC
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750158380; cv=none; b=VxAIuqvMlYfz5hCHweF393jpe87oGid/hlm3OJuj2Sry1sGP/EAwb+RKO4AAqqr7J4r2jFJkmGEqzlsBxSW21Fya3FZrRHMLaRpJDpe3Aji31s7BbuS4hikdzzRtZaBPCP5/xCmupeU5p7ItIlI7PpFK7rlqzMfqtrKLsLqzWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750158380; c=relaxed/simple;
	bh=HtbrQLlEVD0p0k8MENI7BU8t7wt9OJe9jQG05nwOpbc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=myr7uAmwdiXiOGSorfZbxOCShPV63BJQLLdUd/ssE1Wx7L70mJ4uFkqKOCSHKRJq8ZcoQFIhU1OwxOff9Awoclk71bNlh9PgBocT+q13PtTahJkqKfcIDWFGJ9I4Ckwy2dVvEMQLN1KCfe9UZc+dt6wMvyIWAul3E76CPRQeEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hDoCKKWk; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1750158379; x=1781694379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sL8x0iNDy70SSwEfgFw38Q1eahB9ZMZ9SDAMo9puSPg=;
  b=hDoCKKWkhvBDzO71t2mGWPjOX2FIKaYbVryU9jgdCySUBrXjOTJcpNgM
   vBnULrRb+o2HnvrfZkf1jIKuSbWOSMpPJSC0FR0/qc8Qcf8EHXOsXz4pi
   fM6JGnTulzGuokKuqfNEzXtKnuF7Q+Id+LGhy92QxSWw2soDIXDa68NaW
   sGEvvmMVEYGq/Nxicp7/JPk8P1SdagrWw6WTQTHnQZ4f2W0jJzJdXtZfs
   DYO4KjaXskhfhwi2QpcfooyWEfW/sYyBDKZT87lhOtOybAoqqKgBQPL+C
   kLPDGJRXPwLs0RhQPic+DJunjV+7L9IRWFC4xdlKmjAkXcRTfmtOkaC6v
   g==;
X-IronPort-AV: E=Sophos;i="6.16,243,1744070400"; 
   d="scan'208";a="105452331"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 11:06:15 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:63441]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.15.192:2525] with esmtp (Farcaster)
 id 0810d6b2-f790-4af6-a733-279b9f0eba65; Tue, 17 Jun 2025 11:06:13 +0000 (UTC)
X-Farcaster-Flow-ID: 0810d6b2-f790-4af6-a733-279b9f0eba65
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 11:06:12 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 11:06:01 +0000
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
Subject: [PATCH v13 net-next 0/9] PHC support in ENA driver
Date: Tue, 17 Jun 2025 14:05:36 +0300
Message-ID: <20250617110545.5659-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Changes in v13
- Remove unnecessary out-of-tree driver documentation

Changes in v12 (https://lore.kernel.org/netdev/20250611092238.2651-1-darinzon@amazon.com/):
- Add devlink port support
- Remove unnecessary checks from devlink reload up and reload down

Changes in v11 (https://lore.kernel.org/netdev/20250526060919.214-1-darinzon@amazon.com/):
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

 .../device_drivers/ethernet/amazon/ena.rst    | 108 +++++++
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
 19 files changed, 1229 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_debugfs.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_debugfs.h
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_devlink.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_devlink.h
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.h

-- 
2.47.1


