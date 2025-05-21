Return-Path: <netdev+bounces-192266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD881ABF328
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087F31BA4859
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6FE264620;
	Wed, 21 May 2025 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LHd1iy7y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8933025A326
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827806; cv=none; b=HIh/gXm1CIyvS5lISrB+VXuVAwQ+1xQy9wHSt1dGrgcGKo2owc80nLgQOQAX9QTebzHntUOS7XPkmC2P7bnt40xqDaYIytvvaALrMVRPMu8/LvArrQKYiOutcnMnWrgDVCdQgLFf5A5a2jf1O2sWjkaRG+JAFUOVMdJ9NPEScK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827806; c=relaxed/simple;
	bh=pbV+79X4XJT7IWaTc3p+mQbKvor+TV/qiMc+vxO3w08=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FuejKpNidsuo7JuccgIAOwKvXFQvlwhalGTqz6c85CxAiQDkCP5bwj2/ltlfw6ul+oley/rpqhvthQ7qzO/W7+s/PNLWsPM2+t1aAuJT/fk2XBabSXlfVRzi4nSOxlZolynjrCuuiXBE3hkmpILfLF5IL3PXQUq7BgsT/SuEyhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LHd1iy7y; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747827805; x=1779363805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BEv8nIV7U16oRPFosSxIEsukqpM17NphIMViST09ejQ=;
  b=LHd1iy7yL2PdgwXEcNkNWCVylLcyYcxu+iBKmM5doXR3HsbYlUDS0aZD
   Ir5O02f4FaVJnLuQtZCl7SUMTiaY4DdkHTQH6GVVgIv+NMYIl/mjj1oyn
   Q2D4CrG5rQbhgrK5vjhhI5tcG7xUsCcJZ4feWp3eXJKwFuvNTtdvItr4m
   80nAQuXT/Z29D3L1ZXWIlUsXxiIfvUkOf62ZUf5LVf1XT7l53a5G/dOM2
   OUq3lLT1oPvY3zd+W4mxHG6QmS4mOWEr+F8y2146n4bpE5/rgNCiOX3gR
   n5Rzx1nuKyYxzxdZVUR11K8xsPp0zSzAnMikxi4+d/0C/FItwv7FJYngN
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="52367790"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:43:21 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:14427]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.121:2525] with esmtp (Farcaster)
 id f044ea14-3987-45a2-8dd4-4b9d201993a4; Wed, 21 May 2025 11:43:19 +0000 (UTC)
X-Farcaster-Flow-ID: f044ea14-3987-45a2-8dd4-4b9d201993a4
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 11:43:19 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 11:43:08 +0000
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
Subject: [PATCH v9 net-next 0/8] PHC support in ENA driver
Date: Wed, 21 May 2025 14:42:46 +0300
Message-ID: <20250521114254.369-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Changes in v9:
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
 drivers/net/ethernet/amazon/ena/ena_debugfs.c |  66 +++++
 drivers/net/ethernet/amazon/ena/ena_debugfs.h |  27 ++
 drivers/net/ethernet/amazon/ena/ena_devlink.c | 209 ++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_devlink.h |  21 ++
 drivers/net/ethernet/amazon/ena/ena_ethtool.c |  16 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  62 +++-
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |  12 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     | 233 +++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_phc.h     |  37 +++
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |   8 +
 18 files changed, 1262 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/networking/devlink/ena.rst
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_debugfs.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_debugfs.h
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_devlink.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_devlink.h
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.h

-- 
2.47.1


