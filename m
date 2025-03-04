Return-Path: <netdev+bounces-171819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AB3A4ECC2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 20:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236B816A383
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16802620F4;
	Tue,  4 Mar 2025 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jV5PG2LE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0FA2620DC
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115148; cv=none; b=CQdS3XgYp/cxa3oIPslrHEdqsQexqElnUkZZWhzcTtx8njm8sIYVOlocn0jKZU/PUaLHQn6EZKAq8+esoKP/1qf/hjSJaMke3C5bfb7ORAZ5q5TA7TVZ7Wmt1oiIXzy4iXTtqoCk50myYQeUkz+karSLPRVeh2RFlB86N/gD5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115148; c=relaxed/simple;
	bh=OSrPccSrJAPQsRRHzOyJCjuNQVsi5lOZphemwmJZKPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHXby6EWobRIU8ZXxkWCkOM4ZXY+OCcVrnYXMdHR2lL7ZMbKgq+Sn8yAynYbKTJ4MjnhNG6RUdyGf9j8fgCtUfs0w+VfyD0JdEoUcMli2fyEaBhCmwviyRhKwSeKfg7uJlYGn73OAwV0TquY9ISrKqtEfWTZHlKQsrDravthTug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jV5PG2LE; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741115148; x=1772651148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vNP64MBhQMf2aS3pd2LMYM9bgKZ4zf4sWIutz7CaQjY=;
  b=jV5PG2LEvq3nBlL/xw2mbXMgoLL8Upu6nHPPbD3MjLjggP+OBI2hfDOn
   dl5xtKp1WJN3DvGpF21WiHZc4dhInL7m0cNL5Akdz1bIRVaumZIpZED+i
   w+4qfCsZffauzR7c1KqaLtSK1JGL62Uu7RKuPZEX4t1alxfjTYvRBy75C
   M=;
X-IronPort-AV: E=Sophos;i="6.14,220,1736812800"; 
   d="scan'208";a="702161986"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 19:05:45 +0000
Received: from EX19MTAUEC001.ant.amazon.com [10.0.29.78:39601]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.19.194:2525] with esmtp (Farcaster)
 id d508c7bf-0c99-4313-8296-7c59fda64bb1; Tue, 4 Mar 2025 19:05:44 +0000 (UTC)
X-Farcaster-Flow-ID: d508c7bf-0c99-4313-8296-7c59fda64bb1
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 19:05:43 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 19:05:43 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 19:05:43 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.178])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTP id 9B71E40477;
	Tue,  4 Mar 2025 19:05:38 +0000 (UTC)
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
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
Subject: [PATCH v8 net-next 4/5] net: ena: PHC stats through sysfs
Date: Tue, 4 Mar 2025 21:05:03 +0200
Message-ID: <20250304190504.3743-5-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304190504.3743-1-darinzon@amazon.com>
References: <20250304190504.3743-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The patch allows retrieving PHC statistics
through sysfs.
In case the feature is not enabled (through `phc_enable`
sysfs entry), no output will be written.

Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_sysfs.c | 80 +++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_sysfs.c b/drivers/net/ethernet/amazon/ena/ena_sysfs.c
index d0ded92d..441085d2 100644
--- a/drivers/net/ethernet/amazon/ena/ena_sysfs.c
+++ b/drivers/net/ethernet/amazon/ena/ena_sysfs.c
@@ -65,6 +65,82 @@ static ssize_t ena_phc_enable_get(struct device *dev,
 static DEVICE_ATTR(phc_enable, S_IRUGO | S_IWUSR, ena_phc_enable_get,
 		   ena_phc_enable_set);
 
+/* Takes into account max u64 value, null and new line characters */
+#define ENA_PHC_STAT_MAX_LEN 22
+
+static ssize_t ena_phc_cnt_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct ena_adapter *adapter = dev_get_drvdata(dev);
+
+	if (!ena_phc_is_active(adapter))
+		return 0;
+
+	return snprintf(buf, ENA_PHC_STAT_MAX_LEN, "%llu\n",
+			adapter->ena_dev->phc.stats.phc_cnt);
+}
+
+static DEVICE_ATTR(phc_cnt, S_IRUGO, ena_phc_cnt_show, NULL);
+
+static ssize_t ena_phc_exp_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct ena_adapter *adapter = dev_get_drvdata(dev);
+
+	if (!ena_phc_is_active(adapter))
+		return 0;
+
+	return snprintf(buf, ENA_PHC_STAT_MAX_LEN, "%llu\n",
+			adapter->ena_dev->phc.stats.phc_exp);
+}
+
+static DEVICE_ATTR(phc_exp, S_IRUGO, ena_phc_exp_show, NULL);
+
+static ssize_t ena_phc_skp_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct ena_adapter *adapter = dev_get_drvdata(dev);
+
+	if (!ena_phc_is_active(adapter))
+		return 0;
+
+	return snprintf(buf, ENA_PHC_STAT_MAX_LEN, "%llu\n",
+			adapter->ena_dev->phc.stats.phc_skp);
+}
+
+static DEVICE_ATTR(phc_skp, S_IRUGO, ena_phc_skp_show, NULL);
+
+static ssize_t ena_phc_err_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct ena_adapter *adapter = dev_get_drvdata(dev);
+
+	if (!ena_phc_is_active(adapter))
+		return 0;
+
+	return snprintf(buf, ENA_PHC_STAT_MAX_LEN, "%llu\n",
+			adapter->ena_dev->phc.stats.phc_err);
+}
+
+static DEVICE_ATTR(phc_err, S_IRUGO, ena_phc_err_show, NULL);
+
+static struct attribute *phc_stats_attrs[] = {
+	&dev_attr_phc_cnt.attr,
+	&dev_attr_phc_exp.attr,
+	&dev_attr_phc_skp.attr,
+	&dev_attr_phc_err.attr,
+	NULL
+};
+
+static struct attribute_group phc_stats_group = {
+	.attrs = phc_stats_attrs,
+	.name = "phc_stats",
+};
+
 /******************************************************************************
  *****************************************************************************/
 int ena_sysfs_init(struct device *dev)
@@ -72,6 +148,9 @@ int ena_sysfs_init(struct device *dev)
 	if (device_create_file(dev, &dev_attr_phc_enable))
 		dev_err(dev, "Failed to create phc_enable sysfs entry");
 
+	if (device_add_group(dev, &phc_stats_group))
+		dev_err(dev, "Failed to create phc_stats sysfs group");
+
 	return 0;
 }
 
@@ -80,4 +159,5 @@ int ena_sysfs_init(struct device *dev)
 void ena_sysfs_terminate(struct device *dev)
 {
 	device_remove_file(dev, &dev_attr_phc_enable);
+	device_remove_group(dev, &phc_stats_group);
 }
-- 
2.47.1


