Return-Path: <netdev+bounces-95782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC428C36BF
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 15:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44981C20B3F
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 13:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD8D29429;
	Sun, 12 May 2024 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LTMwc/nd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8A23749
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715521624; cv=none; b=K77wyKvG3FYIKkbfD7I4cdL4DmjkfqwBLaGZGqnZ9IwUJ32JvcdgamK17cdu/Zo3rpEUoL1Nvi1506w9LWq/g3OBEhTdcK9fOK3VslGXgvPZfZ6kZksd0k1B8VbawroguFPa612fARUI2qJfUx06e/JZnlqKlNtjD0cVOB+vYuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715521624; c=relaxed/simple;
	bh=L/4YScJxLhiVh5EeK16O5H51LvPqEbEBF1KaxuHWxSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGpyn2w7mwNvrAWRiwn/U+S97DC6Ir+RyICgljP+1h3ZK+vaQ+ZTGWwH3iVqu6PBRz37mNeUR67/sQHyUWXbjc9up9iMl3IGacz4rvEkNlA1I2Z4LkEVcJtUiWrgedt6Xq8E6Vj7pBode8kmJBY7OKT7Gkh1ddwUwGaFGVzJ+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LTMwc/nd; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715521624; x=1747057624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CtXaCNnSsGPI8v0EitPsWFCuWNY2hB2e7DDUoOHad8c=;
  b=LTMwc/ndC5VYVl2ne9zuj7IHA5qIuHjbcNdMKhJp0MIpu61FFKg912V9
   Cy7fqHd/nkMKhLaQxI3YJ7d6B2YhC7BRpa+NZUMIZCDOjf4KL0bYD9UeS
   /xo27u1H7vR4JwDbkx6KeTaoJfNwSuLDu1cw5bJ53x7iLjFK783Nr47Xs
   E=;
X-IronPort-AV: E=Sophos;i="6.08,155,1712620800"; 
   d="scan'208";a="204593870"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 13:47:02 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.44.209:57615]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.61.78:2525] with esmtp (Farcaster)
 id 273e2207-a009-4bad-8ce5-74a27cc45f04; Sun, 12 May 2024 13:47:00 +0000 (UTC)
X-Farcaster-Flow-ID: 273e2207-a009-4bad-8ce5-74a27cc45f04
Received: from EX19D008UEA003.ant.amazon.com (10.252.134.116) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 12 May 2024 13:47:00 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA003.ant.amazon.com (10.252.134.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 12 May 2024 13:47:00 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Sun, 12 May 2024 13:46:58
 +0000
From: <darinzon@amazon.com>
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
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: [PATCH v2 net-next 4/5] net: ena: Changes around strscpy calls
Date: Sun, 12 May 2024 13:46:36 +0000
Message-ID: <20240512134637.25299-5-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240512134637.25299-1-darinzon@amazon.com>
References: <20240512134637.25299-1-darinzon@amazon.com>
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
index 7398bc61..184b6e6c 100644
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


