Return-Path: <netdev+bounces-163551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36450A2AAEA
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5913E1889150
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541F31C701B;
	Thu,  6 Feb 2025 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aoUpCZ7+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C3F3207
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851357; cv=none; b=JvnSqs04xL6hPM3BYEj8AhpX+LVL7K25zPwQB4tipsqDsm+fFP7BoDzhGpVkskdQyf/LisZ36GtyUv8n3F+mhzD62ap7xwMyGynH5cQt7/AF+P3Qm2N1uacX2wRS7kldd7Ey3zOQiKlBcOWThQ0j5ZVwUrp/tBSr3OlqwrXIoSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851357; c=relaxed/simple;
	bh=J8c55LzCeL3mmFlqrZjlAKjd50RASL5kGUs6yQxUCyQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QG3hjRf2/EJgJyz0CqXRlqbZNMQU3HZlpnDa7hNtrYxvtyLtNxJIUCJNA25yLUtQorhQKne2okQcs8Js+ij2bPfixsvw+V4XfSk4uBdJXaVibM2yUew742+GgkSr+mPaItRvJpayE2IfZI++/cVszgOqha2RuK5WUFtG9rzDMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aoUpCZ7+; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738851355; x=1770387355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PgIUHGsBE2GyM+A+krXLAsG1E/0pULmhnJNQlJjROQE=;
  b=aoUpCZ7+J88cvlthPX3HnuxK5i5ukEi6QjnnlOP3UWDitV1kbf+DzpKt
   pDy6cqM4Xj9oNOqvUZA/1AZw81FqB+rJmFtFh6Ax8AWf+feMR8rUsh+Be
   jdzGiIJA+yQbu9uCydcUTpb0cJLgESQnoETysW9Ef6I1p1R0jTQX0OCSz
   4=;
X-IronPort-AV: E=Sophos;i="6.13,264,1732579200"; 
   d="scan'208";a="63688651"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 14:15:52 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:35608]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.30.79:2525] with esmtp (Farcaster)
 id 48817950-537f-4404-a0f2-e70a254b07c1; Thu, 6 Feb 2025 14:15:52 +0000 (UTC)
X-Farcaster-Flow-ID: 48817950-537f-4404-a0f2-e70a254b07c1
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 14:15:48 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 14:15:48 +0000
Received: from email-imr-corp-prod-pdx-all-2b-dbd438cc.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Thu, 6 Feb 2025 14:15:48 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.172])
	by email-imr-corp-prod-pdx-all-2b-dbd438cc.us-west-2.amazon.com (Postfix) with ESMTP id 6D1E6A021D;
	Thu,  6 Feb 2025 14:15:41 +0000 (UTC)
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
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH v6 net-next 0/4] PHC support in ENA driver
Date: Thu, 6 Feb 2025 16:15:34 +0200
Message-ID: <20250206141538.549-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Changes in v6:
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


David Arinzon (4):
  net: ena: Add PHC support in the ENA driver
  net: ena: PHC silent reset
  net: ena: Add PHC documentation
  net: ena: PHC enable through sysfs

 .../device_drivers/ethernet/amazon/ena.rst    |  90 +++++++
 drivers/net/ethernet/amazon/Kconfig           |   1 +
 drivers/net/ethernet/amazon/ena/Makefile      |   2 +-
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |  63 ++++-
 drivers/net/ethernet/amazon/ena/ena_com.c     | 247 ++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_com.h     |  83 ++++++
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 102 ++++++--
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  44 +++-
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |   6 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     | 230 ++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_phc.h     |  37 +++
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |   8 +
 drivers/net/ethernet/amazon/ena/ena_sysfs.c   |  83 ++++++
 drivers/net/ethernet/amazon/ena/ena_sysfs.h   |  28 ++
 14 files changed, 995 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.h
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_sysfs.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_sysfs.h

-- 
2.47.1


