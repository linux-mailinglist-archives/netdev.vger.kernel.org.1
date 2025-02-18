Return-Path: <netdev+bounces-167468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39EAA3A5E4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC461897221
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B6522E002;
	Tue, 18 Feb 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RGvwsuyd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5871EB5C5
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904024; cv=none; b=HSXtXE99nU8N85Us56Cdts25WkhE6e1BbvMAFZnckr2IM61bO7y+7RclGiBW0cDrC/Kqp227MnHNkK8ifpAFi7HdeP2TBvfCvJ/Oz3YKNxYR1rP+WuZxxEy4kgLCspOSEugnyb5gRhAvyVnS3ByjodvbQnrKVSxi0zKCQEJP/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904024; c=relaxed/simple;
	bh=lpmERRfP06/vGodDMx3C0u66zd50c1uC/rQYL9f5kRk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RlNRC3z2oRMLJN/mTNCwFn8kChIeQQePk2Sid1rjLgC070pwUqJi7RpXtXI0ylsAR/8u2mVYAYOT5AbTmGhhkGKp8O/i+mYsPLG5bjRwg3H2sXk+0VMq1kIyLDKI7MkBjNnKra1Xo9nvACkOURGIt2a0e+D+5s5KVOOZpiyoIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RGvwsuyd; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739904022; x=1771440022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y/HMOk2EM5KfmhREh0e7j1qtCM4FxJB6Qt+Ma/Zz+34=;
  b=RGvwsuydI9TJWyvxwo2nAO+1JKsGlSZLue7N1L9fCPWF/+7Hb6XKj5Cy
   UeBqEmFNA1imiGDXji1LjNLQpj2ByJ98bON2yhyPDwT9h15WdTfH8wMkI
   DmRftunWmjMiG0WfBiW5cT6a8XfHnBxk3S6ODEkQpli8jnu+oXmrTrwXr
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,296,1732579200"; 
   d="scan'208";a="170810997"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 18:40:19 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:44361]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.30.208:2525] with esmtp (Farcaster)
 id 81d29b76-8ec3-4f08-9561-7375c2debe30; Tue, 18 Feb 2025 18:40:18 +0000 (UTC)
X-Farcaster-Flow-ID: 81d29b76-8ec3-4f08-9561-7375c2debe30
Received: from EX19D008UEA003.ant.amazon.com (10.252.134.116) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 18 Feb 2025 18:40:01 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D008UEA003.ant.amazon.com (10.252.134.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Feb 2025 18:40:01 +0000
Received: from email-imr-corp-prod-pdx-all-2b-dbd438cc.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Tue, 18 Feb 2025 18:40:01 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.176])
	by email-imr-corp-prod-pdx-all-2b-dbd438cc.us-west-2.amazon.com (Postfix) with ESMTP id 448D4A0065;
	Tue, 18 Feb 2025 18:39:54 +0000 (UTC)
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
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH v7 net-next 0/5] PHC support in ENA driver
Date: Tue, 18 Feb 2025 20:39:43 +0200
Message-ID: <20250218183948.757-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Changes in v7:
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
 drivers/net/ethernet/amazon/ena/ena_ethtool.c |  21 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  44 +++-
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |  12 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     | 230 ++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_phc.h     |  37 +++
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |   8 +
 drivers/net/ethernet/amazon/ena/ena_sysfs.c   | 133 ++++++++++
 drivers/net/ethernet/amazon/ena/ena_sysfs.h   |  28 ++
 14 files changed, 990 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.h
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_sysfs.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_sysfs.h

-- 
2.47.1


