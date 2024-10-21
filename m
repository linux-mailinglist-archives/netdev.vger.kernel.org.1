Return-Path: <netdev+bounces-137365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E599A59AE
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 07:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386031C20BDC
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 05:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1962C433D5;
	Mon, 21 Oct 2024 05:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Su7fdoTF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0F3171CD
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 05:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729488028; cv=none; b=YVUbFtQQ6fgFiwTSGGq3TvsxENhQOoF289KRwCtCiLHtFJUGJD4gnKjxJqSrCvQEgTxips9/7eR7DvpJeGn/fdnPgwg9nTORO2syfH80qSjL67mszmeF5Daizcn+F20nNG8zBN+4IWtIzvJRXnT4VzUQplghIZCPp6O6KWT8EFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729488028; c=relaxed/simple;
	bh=I9JaE5xJsAnhwxfHFiL8yaWmeZONiFMJrf6w3esfLBA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rj0B9ky2ZFnvnjUQXiKheHhsb7vBhahmJGbDvvKsW5bqLAGrtmg9nyQ5fRx0PoQkZBH2wMh/AIKIRP47Wx+ifrPgc31iYjZFzMSiEfzOlAjC7QflNo7YIIFoj1F/DfrU4078I2jM3+2JV6XBpBuBfP6aBVfhRPVTxL1PImPBsso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Su7fdoTF; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729488026; x=1761024026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O6Xekv7TY9LVYH7+SERM0RBObVEPbQRv2riwa7A44+4=;
  b=Su7fdoTFLZC3zcZQ7rMNNfOamjVK0UpwLgJNwY0K8vBcuLE21R5C1LQd
   PUYXUK9Lsr57iDUB4/r3U6xlwu7JHm2RNMkqELm/9FV/Feag9cBSXZEkN
   t7+zZlpqU28qUNfHonmGqZB291WDHHMnvacxFRBf1batYUORib1DQsVpB
   M=;
X-IronPort-AV: E=Sophos;i="6.11,220,1725321600"; 
   d="scan'208";a="433170407"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 05:20:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:6626]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id 3137facb-fae5-4bf1-bb8b-e8296067b389; Mon, 21 Oct 2024 05:20:22 +0000 (UTC)
X-Farcaster-Flow-ID: 3137facb-fae5-4bf1-bb8b-e8296067b389
Received: from EX19D009UWB004.ant.amazon.com (10.13.138.86) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 05:20:21 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D009UWB004.ant.amazon.com (10.13.138.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 05:20:21 +0000
Received: from email-imr-corp-prod-pdx-all-2c-d1311ce8.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 21 Oct 2024 05:20:21 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.175])
	by email-imr-corp-prod-pdx-all-2c-d1311ce8.us-west-2.amazon.com (Postfix) with ESMTP id 12BAF404EA;
	Mon, 21 Oct 2024 05:20:15 +0000 (UTC)
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>
Subject: [PATCH v1 net-next 0/3] PHC support in ENA driver
Date: Mon, 21 Oct 2024 08:20:08 +0300
Message-ID: <20241021052011.591-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

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
 drivers/net/ethernet/amazon/ena/ena_com.c     | 217 +++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_com.h     |  82 +++++++
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 101 ++++++--
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  28 ++-
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |   4 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     | 223 ++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_phc.h     |  37 +++
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |   8 +
 12 files changed, 820 insertions(+), 24 deletions(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.h

-- 
2.40.1


