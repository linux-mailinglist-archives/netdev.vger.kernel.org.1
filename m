Return-Path: <netdev+bounces-144774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D48319C86D7
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC030B2BB12
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0281DB95F;
	Thu, 14 Nov 2024 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GLJpw+UT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B808B163
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578400; cv=none; b=ui7b9+5LfjNJLzAtzfBLSBlor1J//qVSNDsuEP7Y7VVJc4+rFBN15yP2T4A2Go7emK0dFtuIoTx+17Y9QXYrCEdJLm1ie3IaIL8dQTLDdCezSQNusnm+uEpp43BtjM5BZNNq1gn2aK/mkoV643ENmY020KjZ1+BM3GSVZanBrD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578400; c=relaxed/simple;
	bh=HtWQzeTTVAQlU8xBUwy0I07kf8pWv9Jb5YD2SAdsOwg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XnmB/LG4ro8pYfy80ih5GEeE5K4O78DTJg6VA1DrWvpyO9K8kloFPUbFnRQfP9mttkyG73RlrMZpVyaHKtKoJjKdXKndZH30MOUtBORRDtxp9VQyaH6by2b1UEQJMLLbSSGUf6Vuu16LhWuV44gKT6ELOCkLLXb4FtT7O4vN+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GLJpw+UT; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731578399; x=1763114399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4kTICDmFgr9RMoAcHZ4ZE22AicdSiOJTojwwWC4JiKM=;
  b=GLJpw+UTldzIPAebvZw91aIO3RaTLDMIVSwNwIgXy2BwhPlsK0BEBGfi
   gFn+eZ5P8oVPiWjMZc2uqIXVq3gSZRWLDgraNzIB7bBNcvaXpzWfzMTOy
   NuxC6YcyK67k8ogqEd8GDipnzm6qIkz6twAEhCLYcVnAyxIyX1G6f/JgD
   M=;
X-IronPort-AV: E=Sophos;i="6.12,153,1728950400"; 
   d="scan'208";a="442752755"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 09:59:55 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:37670]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.112:2525] with esmtp (Farcaster)
 id e18460f2-7415-4348-9ead-01dcecd881b5; Thu, 14 Nov 2024 09:59:53 +0000 (UTC)
X-Farcaster-Flow-ID: e18460f2-7415-4348-9ead-01dcecd881b5
Received: from EX19D009UWB001.ant.amazon.com (10.13.138.58) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 14 Nov 2024 09:59:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D009UWB001.ant.amazon.com (10.13.138.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 14 Nov 2024 09:59:51 +0000
Received: from email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Thu, 14 Nov 2024 09:59:51 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.176])
	by email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com (Postfix) with ESMTP id 6EF3AC00D9;
	Thu, 14 Nov 2024 09:59:45 +0000 (UTC)
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
Subject: [PATCH v4 net-next 0/3] PHC support in ENA driver
Date: Thu, 14 Nov 2024 11:59:27 +0200
Message-ID: <20241114095930.200-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

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

David Arinzon (3):
  net: ena: Add PHC support in the ENA driver
  net: ena: PHC silent reset
  net: ena: Add PHC documentation

 .../device_drivers/ethernet/amazon/ena.rst    |  78 ++++++
 drivers/net/ethernet/amazon/Kconfig           |   1 +
 drivers/net/ethernet/amazon/ena/Makefile      |   2 +-
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |  63 ++++-
 drivers/net/ethernet/amazon/ena/ena_com.c     | 247 ++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_com.h     |  83 ++++++
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 102 ++++++--
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  28 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |   4 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     | 230 ++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_phc.h     |  37 +++
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |   8 +
 12 files changed, 859 insertions(+), 24 deletions(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.h

-- 
2.40.1


