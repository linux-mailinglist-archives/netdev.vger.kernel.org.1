Return-Path: <netdev+bounces-151361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA63F9EE61D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947CF287AE5
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B437C2054E8;
	Thu, 12 Dec 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IlNQzRAI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC332158DB1
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004788; cv=none; b=L+GuMpLV8JK0OWkcHulQigvDIwnr47NJPZIYj6o8Uima7p2eAmVE6H9ASr/lCa3YysdrQXqgYg8FAxEScq/HAQGI1v6a27e7VloxrwOYnpakGM5vPIIM2VQ3WhN7zoYHq0qQ9BLT5JmpqhbA1mY/ABcOk+SIASibAXrrzMtXpHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004788; c=relaxed/simple;
	bh=N99Z3SqeeeEArYdSrYwovkVydyD5i+JNQdfPOYDR5k4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fKmqowwUnyUe9Z9tfpj/qq/BLU0KWvPvvuDzLuTELEYiwLfR1ByD+Jy/UTRzSUTT5shDVelCmlRkRtF8+pjuXAC92J1GpVxOhQtjuQ4CWg9VCKYOC7jMEugCfytq40kgjZREwjR2skMj3dZmQ+1Y6PIXrTw7zvhXkeHY4lhageg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IlNQzRAI; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734004786; x=1765540786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xFd2ABz6zoY7hN45K0k7JI4fYMfDHgxalGNDMTuK8MY=;
  b=IlNQzRAI1dLrFrAmb5QPRN1l24k0XLf37oZWFDGX07kG0UdZXyTyWdTs
   IvayP4asD2W12ADJQkJdJcv+C0P9NGzNDs2WokvhMfojZ/3EuJbG1w0ZT
   FpKjf1y32kvWPRBL8y9iX8L3XvTabrkBXcfWjFXj9jQm7/77FyxvIZ8LH
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,228,1728950400"; 
   d="scan'208";a="680847748"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 11:59:42 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:15512]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.153:2525] with esmtp (Farcaster)
 id c82b9b12-b4ed-46ee-9303-f188fe483d94; Thu, 12 Dec 2024 11:59:42 +0000 (UTC)
X-Farcaster-Flow-ID: c82b9b12-b4ed-46ee-9303-f188fe483d94
Received: from EX19D028EUB003.ant.amazon.com (10.252.61.31) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 12 Dec 2024 11:59:41 +0000
Received: from u11acbc1324fb53.ant.amazon.com (10.13.248.51) by
 EX19D028EUB003.ant.amazon.com (10.252.61.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 12 Dec 2024 11:59:33 +0000
From: Shay Agroskin <shayagr@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Shay Agroskin <shayagr@amazon.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "kernel
 test robot" <lkp@intel.com>
Subject: [PATCH v1 net-next] net: ena: Fix incorrect indentation
Date: Thu, 12 Dec 2024 13:59:08 +0200
Message-ID: <20241212115910.2485851-1-shayagr@amazon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D028EUB003.ant.amazon.com (10.252.61.31)

The assignment was accidentally aligned to the string one line before.
This was raised by the kernel bot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412101739.umNl7yYu-lkp@intel.com/
Signed-off-by: David Arinzon <darinzon@amazon.com>
Signed-off-by: Shay Agroskin <shayagr@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 63c8a2328142..c1295dfad0d0 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -74,7 +74,7 @@ static void ena_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	if (threshold < time_since_last_napi && napi_scheduled) {
 		netdev_err(dev,
 			   "napi handler hasn't been called for a long time but is scheduled\n");
-			   reset_reason = ENA_REGS_RESET_SUSPECTED_POLL_STARVATION;
+		reset_reason = ENA_REGS_RESET_SUSPECTED_POLL_STARVATION;
 	}
 schedule_reset:
 	/* Change the state of the device to trigger reset
-- 
2.43.0


