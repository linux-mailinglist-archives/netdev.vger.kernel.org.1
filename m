Return-Path: <netdev+bounces-160241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09D6A18F93
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D4B166AE8
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D610D1ADFFE;
	Wed, 22 Jan 2025 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kvmK/gs1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44404145FE0
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541256; cv=none; b=pKTleiF6s+yFqYEAltSP5gSCU6ajDIox1jSgjK4a63VURYXgLmNsJmXCypGDqKC5lbYQV1iOEKHmHXEKeIllVogFGMoW83FC6fajOxiKozIZOLSsuGgGoKkEWHJdCoT5+yKVk/f3xZq15HI1pGeiiS/EzzG4NCcn6wBFT0Z/UVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541256; c=relaxed/simple;
	bh=nwkg9q9gA7QCRVpR7qMvqWPabsNQZl59GAkOavFZwu4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HAuipgqw+f1DBdcj/Uns/eMje/zydrZEGLPOvuVp3uJFAw1AAhEz82AKeh1fEdZl283XV2OM3hTmDPI2KlSe/btYV4Rca4DU0RuOe1TQTzLYW0rFKs8wn/GEHgzEHKCeq7yrb0RGF0VYxlhpuJmEmCU4ZNZ8pwRCg2R6EJvVEmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kvmK/gs1; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737541252; x=1769077252;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5QcIijtH2z9WETRhWsvfCOsx3WHlId4AQ0+OY51Dkzs=;
  b=kvmK/gs1yfQ4LHot35eSYLWHd8xSt9pzBXy/HDOnYWUW4fs9kvtO/8JB
   pvOu7FlJyzIMHEYVZj9lK7bIIg5iNoD+ul9Le1M2swZ99xxlcI1Bx5Zp+
   sSD2Q8KYKA+BvojXoJ+7Tf5Vn/1/zsISFGsizwkiJQIG7Z9cfk9S9Vtr0
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,224,1732579200"; 
   d="scan'208";a="691029875"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 10:20:49 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.44.209:9779]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.44.200:2525] with esmtp (Farcaster)
 id 3d087c61-1b6f-4807-9049-11df576bf7fa; Wed, 22 Jan 2025 10:20:49 +0000 (UTC)
X-Farcaster-Flow-ID: 3d087c61-1b6f-4807-9049-11df576bf7fa
Received: from EX19D008UEC003.ant.amazon.com (10.252.135.194) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 10:20:48 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEC003.ant.amazon.com (10.252.135.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 10:20:48 +0000
Received: from email-imr-corp-prod-iad-all-1b-a03c1db8.us-east-1.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Wed, 22 Jan 2025 10:20:48 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.175])
	by email-imr-corp-prod-iad-all-1b-a03c1db8.us-east-1.amazon.com (Postfix) with ESMTP id 7004680305;
	Wed, 22 Jan 2025 10:20:43 +0000 (UTC)
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Agroskin,
 Shay" <shayagr@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
	<ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>, "Rahul
 Rameshbabu" <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH v5 net-next 0/5] PHC support in ENA driver
Date: Wed, 22 Jan 2025 12:20:35 +0200
Message-ID: <20250122102040.752-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Changes in v5:
- Add PHC error bound
- Add PHC enablement and error bound retrieval through sysfs

Changes in v4:
- Minor documentation change (resolution instead of accuracy)

Changes in v3:
- Resolve a compilation error

Changes in v2:
- CCd PTP maintainer
- Fixed style issues
- Fixed documentation warning

This patchset adds the support for PHC (PTP Hardware Clock)
in the ENA driver. The documentation part of the patchset
includes additional information, including statistics,
utilization and invocation examples through the testptp
utility.

David Arinzon (5):
  net: ena: Add PHC support in the ENA driver
  net: ena: PHC silent reset
  net: ena: Add PHC documentation
  net: ena: PHC error bound/flags support
  net: ena: PHC enable and error_bound through sysfs

 .../device_drivers/ethernet/amazon/ena.rst    | 111 +++++++
 drivers/net/ethernet/amazon/Kconfig           |   1 +
 drivers/net/ethernet/amazon/ena/Makefile      |   2 +-
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |  79 ++++-
 drivers/net/ethernet/amazon/ena/ena_com.c     | 276 ++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_com.h     |  93 ++++++
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 102 +++++--
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  44 ++-
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |   6 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     | 239 +++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_phc.h     |  38 +++
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |   8 +
 drivers/net/ethernet/amazon/ena/ena_sysfs.c   | 110 +++++++
 drivers/net/ethernet/amazon/ena/ena_sysfs.h   |  28 ++
 14 files changed, 1108 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.h
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_sysfs.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_sysfs.h

-- 
2.40.1


