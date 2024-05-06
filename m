Return-Path: <netdev+bounces-93623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390798BC80E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 09:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25301F22207
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 07:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503C71419AA;
	Mon,  6 May 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RUT08gPP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1661411D2
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979108; cv=none; b=AUC+O8PazI91TptPTgX76Ds/BRwYV/V+44nUbvJbuxZWkaVIrWa/8J4ixMNfP/siUKd8KdVZdZb/0D3skrf4VhKQikGYAS0DqQOgZ0aw/0K23RD7cfPGEon0WT+kKPoz4VAb+EVfCCA7Z0P3IVX6Sp3ch6x87motY+o1I5QHjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979108; c=relaxed/simple;
	bh=hrEy6vKaY/RWyIghRdJ39PuwlQUPQJAP3qZvfcpl9KQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dNaK69FBh/75d1Qmx7Kn+YZliQHiG9SSnaXaQOp3+AdRG0pNugiiHEwsuCkDKtY6lJJHyYCH5Vk433kyDOpF1ooHO0+3H4rdtMw2Xf0BbrJtwbWjbilb/ypzMJe7gewrrVNkC0DyxxFJSKsR2PiYWmjdqG4bHPdN++LOnU2S728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RUT08gPP; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714979106; x=1746515106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZW7+Zjod42qczhSa48uqj+i5hnxSYtuPdkkuTfG1r0g=;
  b=RUT08gPP8cX/28aIsRbjrCe390t3JSlf5s/6uDga1C94C/V3ztSIYoyr
   LzANaE1ycmm1nEjQgdc2gv4a7gGtHDEwb3QHZhnG5lC4MghZbu6CZUnRt
   3l9QlipoPmtsfaErG0kz2DQnO6vojj9umhg5ngM+R9MhF3y/RseP/JtjK
   g=;
X-IronPort-AV: E=Sophos;i="6.07,257,1708387200"; 
   d="scan'208";a="294210493"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:05:02 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.44.209:40561]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.59.248:2525] with esmtp (Farcaster)
 id 5c4f59bf-6926-40ff-b6a5-fce057b51368; Mon, 6 May 2024 07:05:02 +0000 (UTC)
X-Farcaster-Flow-ID: 5c4f59bf-6926-40ff-b6a5-fce057b51368
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 07:05:01 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 07:05:01 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 6 May 2024 07:04:59 +0000
From: <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: [PATCH v1 net-next 0/6] ENA driver changes May 2024
Date: Mon, 6 May 2024 07:04:47 +0000
Message-ID: <20240506070453.17054-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: David Arinzon <darinzon@amazon.com>

This patchset contains several misc and minor
changes to the ENA driver.

David Arinzon (6):
  net: ena: Add a counter for driver's reset failures
  net: ena: Reduce holes in ena_com structures
  net: ena: Add validation for completion descriptors consistency
  net: ena: Changes around strscpy calls
  net: ena: Change initial rx_usec interval
  net: ena: Add a field for no interrupt moderation update action

 drivers/net/ethernet/amazon/ena/ena_com.h     | 15 ++--
 drivers/net/ethernet/amazon/ena/ena_eth_com.c | 37 +++++++---
 drivers/net/ethernet/amazon/ena/ena_eth_com.h |  2 +-
 .../net/ethernet/amazon/ena/ena_eth_io_defs.h |  5 +-
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 31 ++++++---
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 69 ++++++++++++++-----
 drivers/net/ethernet/amazon/ena/ena_netdev.h  | 10 ++-
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |  1 +
 8 files changed, 126 insertions(+), 44 deletions(-)

-- 
2.40.1


