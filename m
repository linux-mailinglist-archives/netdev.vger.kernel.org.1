Return-Path: <netdev+bounces-141279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 211809BA54A
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 12:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C777E1F21998
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0716F908;
	Sun,  3 Nov 2024 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WFMnKLrM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502615E5CA
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730633541; cv=none; b=pn6obenhygTdIsrEbYkcjq5s4z7AHDZwMiNZQ5yHFeyWgK/TF8Yr4GNLCIzvihdcC8PkBCGwenSjUWX68PAHF88fleZ+cSM58hVryyl8MSh8Wi5XS3/PjMcLgarnhN+5N8meSZNTIGuqeU3yez3IRnrqqzBJE7Dy/+woSNzCWBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730633541; c=relaxed/simple;
	bh=ON2dZjB9BfejXK663XSmeNdV79sw6IXHV0upg7oAcSk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qi2qdl8LUOcVaZHSrwOlhjixApbQhUVzAc9HqGXPVRJsGVZ6PiI70mUypUYN8BVK3gneEd6CbR96PT5br0dPkNOPFL+bI6bP3VwWsQ0YdNzYFWrax+q7ay4uNUw4c+aqBjWB3mFzPX8y5yiss4+h8QVmZX8VPV6A1UJ5qTR0pzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WFMnKLrM; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730633540; x=1762169540;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mMIvSPFEcueT4GbDYbJ2VvlPPnoB9V/T5tMqr5XWfIM=;
  b=WFMnKLrMRSLBaDr0CKMmEIQmHaFQsHtx1BcpHbah5GMFiUAZH6brYDXw
   3Om59xnGiLjtLuS2qquTJ+1aAgoL5OjDTuJXMXc+EE7amqer/9N4T08Zg
   GQFVuuJnYrAJaMo4KW/busjRU50VjqS6eyhGWoDJ8L7MD0ZF006yHStw9
   4=;
X-IronPort-AV: E=Sophos;i="6.11,255,1725321600"; 
   d="scan'208";a="772415724"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 11:31:57 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:52919]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.37:2525] with esmtp (Farcaster)
 id 148acabf-93f2-40a6-9330-ee956f00d682; Sun, 3 Nov 2024 11:31:56 +0000 (UTC)
X-Farcaster-Flow-ID: 148acabf-93f2-40a6-9330-ee956f00d682
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 3 Nov 2024 11:31:53 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 3 Nov 2024 11:31:53 +0000
Received: from email-imr-corp-prod-iad-1box-1a-9bbde7a3.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Sun, 3 Nov 2024 11:31:53 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.174])
	by email-imr-corp-prod-iad-1box-1a-9bbde7a3.us-east-1.amazon.com (Postfix) with ESMTP id AA97F405DD;
	Sun,  3 Nov 2024 11:31:48 +0000 (UTC)
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
	<ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>
Subject: [PATCH v3 net-next 0/3] PHC support in ENA driver
Date: Sun, 3 Nov 2024 13:31:36 +0200
Message-ID: <20241103113140.275-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

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


