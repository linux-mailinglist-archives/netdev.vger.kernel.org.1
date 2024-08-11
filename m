Return-Path: <netdev+bounces-117465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE2194E0C1
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 12:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6651F212CD
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 10:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2FF36B0D;
	Sun, 11 Aug 2024 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NABZWumV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BEE20B20
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723370848; cv=none; b=uvZarZVCBlBZnVtMjDG/Bdky272j3ukr3+IFIyh3xAAbBg0sCf4tONWZcTNKWwB6t1gwKN2z/dpC3k4ypiIvZ5FJrU9hm8Q6YZgEjorKj68z+Tb2y2UtQbDEiI6VHEE+E3sXEWO53SnGcDRInizuw9PR4cUSvvQvUpDA2uw8Woo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723370848; c=relaxed/simple;
	bh=AmIkyvERHyRBcadYpjsrVYndrSDRsxhEufdTM57Aih0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k4jhr8xVCDlnE0QgDawslxyywMZwTCaV8sh/oOcA8DmExbIItKMTs5K3FLOmQqNo6DUxBFkSg1dn6XeFCTqd9CLAUcDQPhnSfG71FQs/tdlUeMGkvxOMKfnfAQ6RiSm0U+S3QWpuGreQImN7ALHOi0MS/PI4vr/DVmhKNQiW4+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NABZWumV; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723370847; x=1754906847;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rWLr2a6OT4Cv/pyPswoeLkD96HkiwyUbSDipcU9nLho=;
  b=NABZWumVuyZ6LP6CTE9EC+U1SOpM41OAEiH3cgTCO3wZ42EyaG6TJl8n
   wmZVHSxH6zgHs6Attlr88fGldiBGqJK/hs2BtYUxZgg3mjcYpG1XA6CxX
   UpcNpICUmMZOECxDWIYfKRXC6Eh/WE9IZZwlWPXE0zsKz4BzQ6ylwcmHz
   s=;
X-IronPort-AV: E=Sophos;i="6.09,281,1716249600"; 
   d="scan'208";a="319923471"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 10:07:25 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:16880]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.195:2525] with esmtp (Farcaster)
 id 093a78e2-574f-44e9-b9cf-974605060857; Sun, 11 Aug 2024 10:07:24 +0000 (UTC)
X-Farcaster-Flow-ID: 093a78e2-574f-44e9-b9cf-974605060857
Received: from EX19D010UWB003.ant.amazon.com (10.13.138.81) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 11 Aug 2024 10:07:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D010UWB003.ant.amazon.com (10.13.138.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 11 Aug 2024 10:07:23 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.179) by
 mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Sun, 11 Aug 2024 10:07:17 +0000
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, Ron Beider
	<rbeider@amazon.com>, Igor Chauskin <igorch@amazon.com>
Subject: [PATCH v1 net-next 0/2] ENA driver metrics changes
Date: Sun, 11 Aug 2024 13:07:09 +0300
Message-ID: <20240811100711.12921-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patchset contains an introduction of new metrics
available to ENA users.

David Arinzon (2):
  net: ena: Add ENA Express metrics support
  net: ena: Extend customer metrics reporting support

 .../device_drivers/ethernet/amazon/ena.rst    |   5 +
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |  72 ++++++++
 drivers/net/ethernet/amazon/ena/ena_com.c     | 173 +++++++++++++++---
 drivers/net/ethernet/amazon/ena/ena_com.h     |  68 +++++++
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 162 +++++++++++++---
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  27 ++-
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |   2 +-
 7 files changed, 441 insertions(+), 68 deletions(-)

-- 
2.40.1


