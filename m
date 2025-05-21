Return-Path: <netdev+bounces-192270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB667ABF330
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8D63A7651
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3AB25A2AF;
	Wed, 21 May 2025 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="kehEKcIv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68068239E79
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827882; cv=none; b=LnWr1oCOTHJgGJaH04Y+Cd7JypPM/QMKASFMaA0Axilcvctrz+pbG0csELOF2eNMWRGaNo8R0jdCP0xpvitLIOzA8lF3+1YQmsjLZBJcI9OmuwMDL6jhj3+7Z7HJ5AWPiOrxg3rMuErCDcfTr1lBq3MRBVZtjFdlDowO0F6Tdz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827882; c=relaxed/simple;
	bh=P7S0sV+c3kyNYEhAnMO5fSO/1cfX9Lr5010Fv/Jsla8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0BlmK2P89EMi3vCBSuPtqWxOrcy/30AEnrKLeua378s8d2XBspkZP9MyW5941z0zLbeLT4UBCOaIRD0PllMK+BCfqNaLygWOogcFY1MbXRiUBSAWbi7JmhnbfFQk+TeEsewkTqpzKkvrlAsH2ZbEm5VK1XfHrK0assVoT3VR4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kehEKcIv; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747827881; x=1779363881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8tz6LoI8LRkU21FN+Sd5e2/OyCA/N25DqbmZ4IWwZIU=;
  b=kehEKcIvvb3AI3IFruIYyaN9Ty6/d2X51KTzZtyBDNSdJ3PFWHrgsRum
   ioYI1SzJZG+zyvF92ppNn1VFFnDR02BhkWQeydpN5Tq1mspFFxX/a2+bv
   jawkaI6OWLX37BG4szepnALvfvyIOkjhz0GtckzVwc0qbqof8J62hE37R
   jGl2LhL1GN/YolPBCuz0Dwz1+DMt3ii5YkMvVjktHVY/anC6lpiBSqQ4p
   kJCq8zEeJF0bFWxDKHZeqj0v3DsQdxQsWMF1s0Td4NMBXXFlKHLKMXJsr
   Q13O0Qo51n2/X58P9gcmSGcY1SWajsJS575c5kX1R+B14CvprSDYN0Fuz
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="492496171"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:44:40 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:39114]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.132:2525] with esmtp (Farcaster)
 id c0a7d303-0fd4-4dcb-8f16-858d581f1e43; Wed, 21 May 2025 11:44:38 +0000 (UTC)
X-Farcaster-Flow-ID: c0a7d303-0fd4-4dcb-8f16-858d581f1e43
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 11:44:38 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 11:44:27 +0000
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
	<leon@kernel.org>
Subject: [PATCH v9 net-next 4/8] net: ena: Control PHC enable through devlink
Date: Wed, 21 May 2025 14:42:50 +0300
Message-ID: <20250521114254.369-5-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521114254.369-1-darinzon@amazon.com>
References: <20250521114254.369-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Add the capability to set parameters through the devlink framework.

The parameter used for controlling PHC (enable/disable) details
are as follows:
- Name: phc_enable
- Type: Boolean (true - enable/false - disable)
- Mode: DEVLINK_PARAM_CMODE_DRIVERINIT
- Effect: Changes take place during driver initialization,
          any changes require a devlink reload to take effect.

Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_devlink.c | 93 +++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_devlink.h |  2 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  2 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     |  2 +
 4 files changed, 99 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_devlink.c b/drivers/net/ethernet/amazon/ena/ena_devlink.c
index e0294886..1f3d9a40 100644
--- a/drivers/net/ethernet/amazon/ena/ena_devlink.c
+++ b/drivers/net/ethernet/amazon/ena/ena_devlink.c
@@ -5,6 +5,63 @@
 
 #include "linux/pci.h"
 #include "ena_devlink.h"
+#include "ena_phc.h"
+
+static int ena_devlink_phc_enable_validate(struct devlink *devlink, u32 id,
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
+enum ena_devlink_param_id {
+	ENA_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
+	ENA_DEVLINK_PARAM_ID_PHC_ENABLE,
+};
+
+static const struct devlink_param ena_devlink_params[] = {
+	DEVLINK_PARAM_DRIVER(ENA_DEVLINK_PARAM_ID_PHC_ENABLE,
+			     "phc_enable", DEVLINK_PARAM_TYPE_BOOL,
+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
+			     NULL, NULL, ena_devlink_phc_enable_validate),
+};
+
+void ena_devlink_params_get(struct devlink *devlink)
+{
+	struct ena_adapter *adapter = ENA_DEVLINK_PRIV(devlink);
+	union devlink_param_value val;
+	int err;
+
+	err = devl_param_driverinit_value_get(devlink,
+					      ENA_DEVLINK_PARAM_ID_PHC_ENABLE,
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
+					ENA_DEVLINK_PARAM_ID_PHC_ENABLE,
+					value);
+}
 
 static int ena_devlink_reload_down(struct devlink *devlink,
 				   bool netns_change,
@@ -80,6 +137,27 @@ static const struct devlink_ops ena_devlink_ops = {
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
+					ENA_DEVLINK_PARAM_ID_PHC_ENABLE,
+					value);
+
+	return 0;
+}
+
 struct devlink *ena_devlink_alloc(struct ena_adapter *adapter)
 {
 	struct device *dev = &adapter->pdev->dev;
@@ -97,11 +175,26 @@ struct devlink *ena_devlink_alloc(struct ena_adapter *adapter)
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


