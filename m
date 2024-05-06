Return-Path: <netdev+bounces-93627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B58D8BC813
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 09:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9715C1F2232F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 07:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B49455E5B;
	Mon,  6 May 2024 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="e1I8KKHA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068F5338C
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979118; cv=none; b=mk5M7SbvIx0pLVTVmxLAUGprhSYngGGJggGvVnocxEEc5l4AzGgaYXFdiQbiNZCqgdVZeCdtszRcH08NZHamHlwqXBcRAPEzQH7RydYtjOLkzZEzIJ1AwUKohf7qxhxCMtzwhpkFLsWJJsCQxSy0uECOhYJvJ0av3UBCLa0jPcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979118; c=relaxed/simple;
	bh=y8TijsN5cZcRlAjXenEn4D+F2JxysTKIm+kt1OX8wxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAWlRr/fK55hDI5UY+C+wXfivmzd8LBMhX2YAr4bSrh2s8TNv4WFL2evG7JTBgUkPt5V8XkS78QA0s9R4AtOcbY8I1ZSJKQ4tw4wetWoocIOtrgwSlvR9bSs41Usqi5UqC/bdsigITRPPmJKbfwTS/JeUlmrlk5jzXIpe4aoFcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=e1I8KKHA; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714979118; x=1746515118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K2XKbUuKFSNnaDX3EZvj69QBngT9O2/joPD7nMFpejg=;
  b=e1I8KKHAH4kza3lP0I+WTBBkVxJPqUptnp65FHBa7ezG4yUQULV0zsi5
   oWbl/terdXQKGRt1zjqDorI2xdslXfxhMus4nt231k3ujKs13FpCQuixw
   wZB2ku+SOti2yHQuw5VkLbEmYwjHjIKqzkfM0jn+Rjj+g4H1oPKX/sCIN
   k=;
X-IronPort-AV: E=Sophos;i="6.07,257,1708387200"; 
   d="scan'208";a="293116609"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:05:15 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:58251]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.254:2525] with esmtp (Farcaster)
 id 0ddae137-5ef9-4e7a-8329-1ca18dda79e3; Mon, 6 May 2024 07:05:14 +0000 (UTC)
X-Farcaster-Flow-ID: 0ddae137-5ef9-4e7a-8329-1ca18dda79e3
Received: from EX19D002UWA004.ant.amazon.com (10.13.138.230) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 07:05:14 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D002UWA004.ant.amazon.com (10.13.138.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 07:05:14 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 6 May 2024 07:05:11 +0000
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
Subject: [PATCH v1 net-next 4/6] net: ena: Changes around strscpy calls
Date: Mon, 6 May 2024 07:04:51 +0000
Message-ID: <20240506070453.17054-5-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506070453.17054-1-darinzon@amazon.com>
References: <20240506070453.17054-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: David Arinzon <darinzon@amazon.com>

strscpy copies as much of the string as possible,
meaning that the destination string will be truncated
in case of no space. As this is a non-critical error in
our case, adding a debug level print for indication.

This patch also removes a -1 which was added to ensure
enough space for NUL, but strscpy destination string is
guaranteed to be NUL-terminted, therefore, the -1 is
not needed.

Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 16 ++++++++++++----
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 17 +++++++++++++----
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index 28583db8..b24cc3f0 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -460,10 +460,18 @@ static void ena_get_drvinfo(struct net_device *dev,
 			    struct ethtool_drvinfo *info)
 {
 	struct ena_adapter *adapter = netdev_priv(dev);
-
-	strscpy(info->driver, DRV_MODULE_NAME, sizeof(info->driver));
-	strscpy(info->bus_info, pci_name(adapter->pdev),
-		sizeof(info->bus_info));
+	ssize_t ret = 0;
+
+	ret = strscpy(info->driver, DRV_MODULE_NAME, sizeof(info->driver));
+	if (ret < 0)
+		netif_dbg(adapter, drv, dev,
+			  "module name will be truncated, status = %zd\n", ret);
+
+	ret = strscpy(info->bus_info, pci_name(adapter->pdev),
+		      sizeof(info->bus_info));
+	if (ret < 0)
+		netif_dbg(adapter, drv, dev,
+			  "bus info will be truncated, status = %zd\n", ret);
 }
 
 static void ena_get_ringparam(struct net_device *netdev,
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index c17a9833..53f1000f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2703,6 +2703,7 @@ static void ena_config_host_info(struct ena_com_dev *ena_dev, struct pci_dev *pd
 {
 	struct device *dev = &pdev->dev;
 	struct ena_admin_host_info *host_info;
+	ssize_t ret;
 	int rc;
 
 	/* Allocate only the host info */
@@ -2717,11 +2718,19 @@ static void ena_config_host_info(struct ena_com_dev *ena_dev, struct pci_dev *pd
 	host_info->bdf = pci_dev_id(pdev);
 	host_info->os_type = ENA_ADMIN_OS_LINUX;
 	host_info->kernel_ver = LINUX_VERSION_CODE;
-	strscpy(host_info->kernel_ver_str, utsname()->version,
-		sizeof(host_info->kernel_ver_str) - 1);
+	ret = strscpy(host_info->kernel_ver_str, utsname()->version,
+		      sizeof(host_info->kernel_ver_str));
+	if (ret < 0)
+		dev_dbg(dev,
+			"kernel version string will be truncated, status = %zd\n", ret);
+
 	host_info->os_dist = 0;
-	strscpy(host_info->os_dist_str, utsname()->release,
-		sizeof(host_info->os_dist_str));
+	ret = strscpy(host_info->os_dist_str, utsname()->release,
+		      sizeof(host_info->os_dist_str));
+	if (ret < 0)
+		dev_dbg(dev,
+			"OS distribution string will be truncated, status = %zd\n", ret);
+
 	host_info->driver_version =
 		(DRV_MODULE_GEN_MAJOR) |
 		(DRV_MODULE_GEN_MINOR << ENA_ADMIN_HOST_INFO_MINOR_SHIFT) |
-- 
2.40.1


