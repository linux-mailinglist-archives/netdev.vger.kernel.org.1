Return-Path: <netdev+bounces-196484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B067AD4FA9
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E8D16E678
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 09:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762FD25EF9F;
	Wed, 11 Jun 2025 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="saKCboCm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037425C83E
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633878; cv=none; b=komGQOi1BEEgvvD78Uf1eH7Z28v9BJesek8PQhnbQi/3X6DtPyQIME6PisbsOunADX7A22AYBN0j8NCfcAMF92dSZ4ylldiDGJjXhVzcTnCd2kgAM8QxpiM/dUx/AuwGWWs4qLEDY2FrROHSfW6+Jm2x/4OeBoEyntAXPv9Vkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633878; c=relaxed/simple;
	bh=9fuIsMrKfByr08viERJ4H3Guz5fiei3MNhay3ImwnQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSPl7ydOc5PVkbYif4r6Utp61exrnwWMXLrBhggmoQHgN6ozTpwbDpHWwZEzZCxSTf5b2/6wmHrg+sJ6L6TMi9Hi0zalhMYuBlFZDE0/7e4W0yeT/9TP/ZvEPmN9Rbe8NV0+T9Sjk1sDIF0iTuA5WdWDrQAlIaDrnUg7uuo68ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=saKCboCm; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749633877; x=1781169877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TGGVDqP7BbgcmSDXZvO56tN5sA+HZ4gWTi2xMmNMBfk=;
  b=saKCboCmXL7I80kCdbHxtNUHD3ckukzqR2VoEmKOCWnS68jYxPy4ZCPG
   nnPIsA+/w9xb3PjV5xAp6dbW4/WztCymjfv9nxNGUgOZM2OJV6NpNtB8Y
   wqkg9vRGQA0Bn4yqdTrnHwG/ExiOoFnL/TShaVLZqFiZHIKDs3s1Y4Psr
   kLi1mcvFk0XPn6k+z7bHvSJUNX4yN4QIAjUplRlM+xT57pmDrH0gOzTXR
   D/VDIeI7YVGaUdkwo6nOMdYbUZsK/Wf78b68EmrrvgJZUyB4jvE5mdUph
   0dTqueCvFFRWXOaElU3vhj9iieFcP2W8UJmCbgxEdzLNRTVLnYuy+YyLx
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,227,1744070400"; 
   d="scan'208";a="530050750"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 09:24:29 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:20038]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.25.199:2525] with esmtp (Farcaster)
 id 496c6fa5-99a3-4014-9079-139f9be6a37b; Wed, 11 Jun 2025 09:24:27 +0000 (UTC)
X-Farcaster-Flow-ID: 496c6fa5-99a3-4014-9079-139f9be6a37b
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 09:24:25 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.176) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 09:24:13 +0000
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
Subject: [PATCH v12 net-next 4/9] net: ena: Add devlink port support
Date: Wed, 11 Jun 2025 12:22:33 +0300
Message-ID: <20250611092238.2651-5-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611092238.2651-1-darinzon@amazon.com>
References: <20250611092238.2651-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Add the basic functionality to support devlink port
for devlink model completeness purposes.
Current support is for registration/un-registration.

Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_devlink.c | 31 +++++++++++++++++--
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |  1 +
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_devlink.c b/drivers/net/ethernet/amazon/ena/ena_devlink.c
index db56916c..1aa977a6 100644
--- a/drivers/net/ethernet/amazon/ena/ena_devlink.c
+++ b/drivers/net/ethernet/amazon/ena/ena_devlink.c
@@ -6,6 +6,23 @@
 #include "linux/pci.h"
 #include "ena_devlink.h"
 
+static void ena_devlink_port_register(struct devlink *devlink)
+{
+	struct ena_adapter *adapter = ENA_DEVLINK_PRIV(devlink);
+	struct devlink_port_attrs attrs = {};
+
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
+	devlink_port_attrs_set(&adapter->devlink_port, &attrs);
+	devl_port_register(devlink, &adapter->devlink_port, 0);
+}
+
+static void ena_devlink_port_unregister(struct devlink *devlink)
+{
+	struct ena_adapter *adapter = ENA_DEVLINK_PRIV(devlink);
+
+	devl_port_unregister(&adapter->devlink_port);
+}
+
 static int ena_devlink_reload_down(struct devlink *devlink,
 				   bool netns_change,
 				   enum devlink_reload_action action,
@@ -20,6 +37,8 @@ static int ena_devlink_reload_down(struct devlink *devlink,
 		return -EOPNOTSUPP;
 	}
 
+	ena_devlink_port_unregister(devlink);
+
 	rtnl_lock();
 	ena_destroy_device(adapter, false);
 	rtnl_unlock();
@@ -46,6 +65,8 @@ static int ena_devlink_reload_up(struct devlink *devlink,
 
 	rtnl_unlock();
 
+	ena_devlink_port_register(devlink);
+
 	if (!err)
 		*actions_performed = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT);
 
@@ -85,10 +106,16 @@ void ena_devlink_free(struct devlink *devlink)
 
 void ena_devlink_register(struct devlink *devlink, struct device *dev)
 {
-	devlink_register(devlink);
+	devl_lock(devlink);
+	ena_devlink_port_register(devlink);
+	devl_register(devlink);
+	devl_unlock(devlink);
 }
 
 void ena_devlink_unregister(struct devlink *devlink)
 {
-	devlink_unregister(devlink);
+	devl_lock(devlink);
+	ena_devlink_port_unregister(devlink);
+	devl_unregister(devlink);
+	devl_unlock(devlink);
 }
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index a732a19e..cba67867 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -390,6 +390,7 @@ struct ena_adapter {
 	u32 xdp_num_queues;
 
 	struct devlink *devlink;
+	struct devlink_port devlink_port;
 };
 
 void ena_set_ethtool_ops(struct net_device *netdev);
-- 
2.47.1


