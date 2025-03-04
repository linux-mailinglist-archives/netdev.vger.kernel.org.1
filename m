Return-Path: <netdev+bounces-171815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ECBA4ECC0
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 20:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE1A189045C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4219D24EA9A;
	Tue,  4 Mar 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="M6++a+VC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C72063E0
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115126; cv=none; b=JZTpt2gD41b+imtKaATo0lQV3uyGTzhlOl/ZyNZjGFoslYfmNBSTdjg+p1I7KICNaXjLbIdrdqScVP7ja4fwZWo8snw0eJnIHFc2M3TmnM3wJaLX3JA3gE7rh09+3Zp4qih0U48ny7cg6Ztka4Zm3ivLRNrsfZEGdJOPm+ZKBfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115126; c=relaxed/simple;
	bh=VymyZI8orx5mQ4IUaLUYYJXe3CCShwinSpMBCQQvcOM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f/UqtdVwBKn2sqLsFZSxOqf4Pd1hhCiv0WyoIsSsFfjDhoowDKgdf+VOXvRnr2W5P3VarYqVSym1bsz5FzBc9E2BPURRdlJF96WbhAG6ADJw18m+FVbBFMCw8TEuDJ0P+39doZgmfantg3UOlrJHtYGjC6MPDm3huTwoNCVgIq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=M6++a+VC; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741115125; x=1772651125;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cmWgUx2CIt2BnglFLLO24rSuYNOpAMYfwt5mIgC/rtA=;
  b=M6++a+VCjau1GK4IBR8HrDJs5qikI9OIF6pOjweRhLXcu1RMX447UbqE
   gKBc9wvS0xwTejL2kZ88LtlA+UR6p6TJ1Wqqk8Giqi4023NYVfZQLAGk4
   7t/IYGK6XDG/FohaFgtU8DkNWHb/gj5v7a5trI5ziO4sRlWABFgUbMmYg
   I=;
X-IronPort-AV: E=Sophos;i="6.14,220,1736812800"; 
   d="scan'208";a="28366152"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 19:05:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:28015]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.28:2525] with esmtp (Farcaster)
 id bbe242e5-0c1a-4bba-8f1a-e481b9b8010d; Tue, 4 Mar 2025 19:05:22 +0000 (UTC)
X-Farcaster-Flow-ID: bbe242e5-0c1a-4bba-8f1a-e481b9b8010d
Received: from EX19D010UWB002.ant.amazon.com (10.13.138.71) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 19:05:14 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D010UWB002.ant.amazon.com (10.13.138.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 19:05:13 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 19:05:13 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.178])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTP id 681B1A07D3;
	Tue,  4 Mar 2025 19:05:07 +0000 (UTC)
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
	<vadim.fedorenko@linux.dev>
Subject: [PATCH v8 net-next 0/5] PHC support in ENA driver
Date: Tue, 4 Mar 2025 21:04:59 +0200
Message-ID: <20250304190504.3743-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Changes in v8:
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

David Arinzon (5):
  net: ena: Add PHC support in the ENA driver
  net: ena: PHC silent reset
  net: ena: PHC enable through sysfs
  net: ena: PHC stats through sysfs
  net: ena: Add PHC documentation

 .../device_drivers/ethernet/amazon/ena.rst    |  96 +++++++
 drivers/net/ethernet/amazon/Kconfig           |   1 +
 drivers/net/ethernet/amazon/ena/Makefile      |   2 +-
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |  63 ++++-
 drivers/net/ethernet/amazon/ena/ena_com.c     | 247 ++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_com.h     |  83 ++++++
 drivers/net/ethernet/amazon/ena/ena_ethtool.c |  16 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  44 +++-
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |   6 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     | 230 ++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_phc.h     |  37 +++
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |   8 +
 drivers/net/ethernet/amazon/ena/ena_sysfs.c   | 163 ++++++++++++
 drivers/net/ethernet/amazon/ena/ena_sysfs.h   |  28 ++
 14 files changed, 1014 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.h
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_sysfs.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_sysfs.h

-- 
2.47.1


