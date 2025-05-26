Return-Path: <netdev+bounces-193355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40229AC39B2
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018EC3A3E71
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904221C84D7;
	Mon, 26 May 2025 06:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Fa/B2+zr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB09D1917D0
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239895; cv=none; b=lX1M3/kdUe6vE0oHGF2chv3gN5koNtJeX85Fy3GPgX936V/oXSl2LxDYsUK72R/x34AJ/XqBDNXKBwXncJJacZfKwCgmtJAlLbttL01uzieUv9u2zh/Q37T0Nz/XfQJTMSef+TrGe0NNXKhw9+8G8zDALS+eS2E/T6VNFkEfOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239895; c=relaxed/simple;
	bh=RA4ijvfl6+qK1cI5PRdBTW+zw+1hCYnLYJPlrE8j4KM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBwvcCR92631wawu86mfUwDbJfbLCsM3ZMbF2kGvOXtcn03/Rw0tZBxt9LtphqQuN3fvDSxwseZBH4Gi+19QX9t4wNuo854kSQXdo59IbNDDoEj1MmwoZhMZUCAaN07QdlzwZ8k4kBrfkHoU24QYtkdC09KD22pNMhgOtoUXQUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Fa/B2+zr; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748239894; x=1779775894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jnp9S+ARjnckeIbOUC4EFeAiP4AH72bEdHrs0gRb5g4=;
  b=Fa/B2+zrZ3NvnV1gpuMdec0SzcPlA7SkI5+icZ6T7zAzOsp83U+9/XdU
   ys4E5WpqndC3SFvEU98d2b0nXsiX2I/033/V1re4JotIzcC6BzbesnHif
   j68ZfmR8I/GYtp/vdKvV0OwZHV5iGW2mvkGfpNQ/q+OSzWWLp+NgdB913
   bJp1xv9hYOCVH06yCi7LeGIAj0InZMqm/rfZzjDJXCY/X56lre15BkvSX
   2ytLCXk2lpNo6h2VJVlVty1VuLz8biRenf8IwODpXTRVOAm0F6DPuwfVi
   9SfiiYoXhr7FtiepAI4FmpcFtM8AkEZcLdEEdZTKMiivemxoF7wvE3jcy
   w==;
X-IronPort-AV: E=Sophos;i="6.15,315,1739836800"; 
   d="scan'208";a="53864196"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 06:11:32 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:62624]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.53:2525] with esmtp (Farcaster)
 id 860abe8d-8df1-47ce-8b04-8e03f4d47063; Mon, 26 May 2025 06:11:31 +0000 (UTC)
X-Farcaster-Flow-ID: 860abe8d-8df1-47ce-8b04-8e03f4d47063
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 06:11:31 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.177) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 06:11:19 +0000
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
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky
	<leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH v11 net-next 5/8] net: ena: Control PHC enable through devlink
Date: Mon, 26 May 2025 09:09:15 +0300
Message-ID: <20250526060919.214-6-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526060919.214-1-darinzon@amazon.com>
References: <20250526060919.214-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Add the capability to set parameters through the devlink framework.

The parameter used for controlling PHC (enable/disable) details
are as follows:
- Name: enable_phc
- Type: Boolean (true - enable/false - disable)
- Mode: DEVLINK_PARAM_CMODE_DRIVERINIT
- Effect: Changes take place during driver initialization,
          any changes require a devlink reload to take effect.

Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_devlink.c | 89 +++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_devlink.h |  2 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  2 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     |  2 +
 4 files changed, 95 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_devlink.c b/drivers/net/ethernet/amazon/ena/ena_devlink.c
index e0294886..b6afe58c 100644
--- a/drivers/net/ethernet/amazon/ena/ena_devlink.c
+++ b/drivers/net/ethernet/amazon/ena/ena_devlink.c
@@ -5,6 +5,59 @@
 
 #include "linux/pci.h"
 #include "ena_devlink.h"
+#include "ena_phc.h"
+
+static int ena_devlink_enable_phc_validate(struct devlink *devlink, u32 id,
+					   union devlink_param_value val,
+					   struct netlink_ext_ack *extack)
+{
+	struct ena_adapter *adapter = ENA_DEVLINK_PRIV(devlink);
+
+	if (!val.vbool)
+		return 0;
+
+	if (!ena_com_phc_supported(adapter->ena_dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support PHC");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static const struct devlink_param ena_devlink_params[] = {
+	DEVLINK_PARAM_GENERIC(ENABLE_PHC,
+			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
+			      NULL,
+			      NULL,
+			      ena_devlink_enable_phc_validate),
+};
+
+void ena_devlink_params_get(struct devlink *devlink)
+{
+	struct ena_adapter *adapter = ENA_DEVLINK_PRIV(devlink);
+	union devlink_param_value val;
+	int err;
+
+	err = devl_param_driverinit_value_get(devlink,
+					      DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
+					      &val);
+	if (err) {
+		netdev_err(adapter->netdev, "Failed to query PHC param\n");
+		return;
+	}
+
+	ena_phc_enable(adapter, val.vbool);
+}
+
+void ena_devlink_disable_phc_param(struct devlink *devlink)
+{
+	union devlink_param_value value;
+
+	value.vbool = false;
+	devl_param_driverinit_value_set(devlink,
+					DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
+					value);
+}
 
 static int ena_devlink_reload_down(struct devlink *devlink,
 				   bool netns_change,
@@ -80,6 +133,27 @@ static const struct devlink_ops ena_devlink_ops = {
 	.reload_up	= ena_devlink_reload_up,
 };
 
+static int ena_devlink_configure_params(struct devlink *devlink)
+{
+	struct ena_adapter *adapter = ENA_DEVLINK_PRIV(devlink);
+	union devlink_param_value value;
+	int rc;
+
+	rc = devlink_params_register(devlink, ena_devlink_params,
+				     ARRAY_SIZE(ena_devlink_params));
+	if (rc) {
+		netdev_err(adapter->netdev, "Failed to register devlink params\n");
+		return rc;
+	}
+
+	value.vbool = ena_phc_is_enabled(adapter);
+	devl_param_driverinit_value_set(devlink,
+					DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
+					value);
+
+	return 0;
+}
+
 struct devlink *ena_devlink_alloc(struct ena_adapter *adapter)
 {
 	struct device *dev = &adapter->pdev->dev;
@@ -97,11 +171,26 @@ struct devlink *ena_devlink_alloc(struct ena_adapter *adapter)
 	ENA_DEVLINK_PRIV(devlink) = adapter;
 	adapter->devlink = devlink;
 
+	if (ena_devlink_configure_params(devlink))
+		goto free_devlink;
+
 	return devlink;
+
+free_devlink:
+	devlink_free(devlink);
+	return NULL;
+}
+
+static void ena_devlink_configure_params_clean(struct devlink *devlink)
+{
+	devlink_params_unregister(devlink, ena_devlink_params,
+				  ARRAY_SIZE(ena_devlink_params));
 }
 
 void ena_devlink_free(struct devlink *devlink)
 {
+	ena_devlink_configure_params_clean(devlink);
+
 	devlink_free(devlink);
 }
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_devlink.h b/drivers/net/ethernet/amazon/ena/ena_devlink.h
index cb1a5f21..7a19ce48 100644
--- a/drivers/net/ethernet/amazon/ena/ena_devlink.h
+++ b/drivers/net/ethernet/amazon/ena/ena_devlink.h
@@ -15,5 +15,7 @@ struct devlink *ena_devlink_alloc(struct ena_adapter *adapter);
 void ena_devlink_free(struct devlink *devlink);
 void ena_devlink_register(struct devlink *devlink, struct device *dev);
 void ena_devlink_unregister(struct devlink *devlink);
+void ena_devlink_params_get(struct devlink *devlink);
+void ena_devlink_disable_phc_param(struct devlink *devlink);
 
 #endif /* DEVLINK_H */
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index a4d35405..28878a42 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3138,6 +3138,8 @@ static int ena_device_init(struct ena_adapter *adapter, struct pci_dev *pdev,
 		goto err_mmio_read_less;
 	}
 
+	ena_devlink_params_get(adapter->devlink);
+
 	/* ENA admin level init */
 	rc = ena_com_admin_init(ena_dev, &aenq_handlers);
 	if (rc) {
diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.c b/drivers/net/ethernet/amazon/ena/ena_phc.c
index 5ce9a32d..7867e893 100644
--- a/drivers/net/ethernet/amazon/ena/ena_phc.c
+++ b/drivers/net/ethernet/amazon/ena/ena_phc.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include "ena_netdev.h"
 #include "ena_phc.h"
+#include "ena_devlink.h"
 
 static int ena_phc_adjtime(struct ptp_clock_info *clock_info, s64 delta)
 {
@@ -213,6 +214,7 @@ err_ena_com_phc_config:
 	ena_com_phc_destroy(ena_dev);
 err_ena_com_phc_init:
 	ena_phc_enable(adapter, false);
+	ena_devlink_disable_phc_param(adapter->devlink);
 	return rc;
 }
 
-- 
2.47.1


