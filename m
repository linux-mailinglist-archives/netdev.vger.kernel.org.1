Return-Path: <netdev+bounces-140648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121889B76CA
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84DD6B219E5
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 08:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F281448E4;
	Thu, 31 Oct 2024 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Pxib9hEn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F54D517
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364794; cv=none; b=Edf7nLrb6e18O64H3EdzyQqlZTLBX9OeflIFBkCqkfrRHaYIdkcEZtZQaWSV7u3ws50ZujWxs0fECQhAnEHwLVNk7wuYXHMCKBIhcuVQoU5Hs64G3fXC/E0upoxp/Y8qyaR6D3+g2jYWblk7+BiroxXqDiM2FbdoUcqiSa53Dxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364794; c=relaxed/simple;
	bh=f/2JbAr42fsF5c421mRqc8R9x9fSmFPw7bCYUIOvi0M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MPv9GlwAr2JURHAfkrW0rLLgaO58Xb/remm8oZmJ499HEBwpetNIMq0hfUlMr9ui7uOPFQEIMYg5uwAAp2Xxc2DHpjSzvJ4l9PGgZGZOeleoIOZWGfBUadyGnHmI4ROK31qZvlJ2g8Bnk6V0EjVmd4g3pDnrBIM9oO85qAoWY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Pxib9hEn; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730364792; x=1761900792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VJIVy2CB/xYx6tvwMtDM92h0xhOQ5EAtmZAqYgJT8Sc=;
  b=Pxib9hEnM7B2XkFAFahknojgQtqzS+E+HijXopF4Uvff5YodmU1k9rFY
   D70EohCd4WVRVyhZITRIgETYCeukz06E6GSxttTb1VFhPMgDqVD3mWbaf
   8i72YwsdwgxP/RLV3ratXgp7IJOAI8Q5QgpVfkqP10919dP/3eHmlYLCS
   k=;
X-IronPort-AV: E=Sophos;i="6.11,247,1725321600"; 
   d="scan'208";a="670549242"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 08:53:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:4387]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.102:2525] with esmtp (Farcaster)
 id 38f1d14b-e92e-43f3-aaaa-d4858029cc4b; Thu, 31 Oct 2024 08:53:09 +0000 (UTC)
X-Farcaster-Flow-ID: 38f1d14b-e92e-43f3-aaaa-d4858029cc4b
Received: from EX19D009UWB002.ant.amazon.com (10.13.138.74) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 31 Oct 2024 08:53:08 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D009UWB002.ant.amazon.com (10.13.138.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 31 Oct 2024 08:53:07 +0000
Received: from email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Thu, 31 Oct 2024 08:53:07 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.177])
	by email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com (Postfix) with ESMTP id 21F1DA04A3;
	Thu, 31 Oct 2024 08:53:01 +0000 (UTC)
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
Subject: [PATCH v2 net-next 0/3] PHC support in ENA driver
Date: Thu, 31 Oct 2024 10:52:41 +0200
Message-ID: <20241031085245.18146-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

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


