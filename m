Return-Path: <netdev+bounces-198527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC9AADC913
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FCA3B248C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506122D12F6;
	Tue, 17 Jun 2025 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="cEP3JDrT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8C219E8
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750158454; cv=none; b=DqX9zafbGmOnJh785PmL1f5C3pN1v5GmTvGjnx/Vc2XA76/7mWW2fDbtjDclxtUFy0R1zykFGPCW3h024zWmdoNLfld8KmoUSxALqg/gBE34n3JDPUDzdhTUfrEAgEgRM1sS6xceDZV+qO0IAtzEcC6oeJkvIthHlFJZWgov6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750158454; c=relaxed/simple;
	bh=9fuIsMrKfByr08viERJ4H3Guz5fiei3MNhay3ImwnQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Re7NiQEdoOUh7IXK8WouLey64OVdswuax2bgpuZDLUsekPKfrKBZtcDZi/KqIKb7C7xWouVGTOKQkAZOPtg7fEsAZRnZYq6V9Fm/bpzvahCHCAEtKaW87YRZO+TqAVX8o51rUP8qV52ySZ8EtfDDF2Mw44zbzsE142KTx7J4gT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=cEP3JDrT; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1750158452; x=1781694452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TGGVDqP7BbgcmSDXZvO56tN5sA+HZ4gWTi2xMmNMBfk=;
  b=cEP3JDrTm5YodcCroZP48f1BFC9lXEbPckc/uCURsM9VNy6+6Lz6RcWr
   MFZMWXOM8wY7hS65PX0QwQOkVS9VUhaZq5ZpPjPbpuZqKhkJkWzlvGxGS
   fTplc3T8sbP/pTTXSDcFknJ0wGq8azqb5gvwPpkL0BQ5cYqKwplHGOREw
   MNxykfe6xgYiNTLVYHQutim+9IuYq1bM8UxSLLoL91gvp9gXUbXGGuvId
   nJ+f4muFQF+ciastIEmwnCqFIlGH6AlRmNjklFljdBJqZQp+ro+xFmLdN
   GpM559pkfTVP6Oz0XEsx+SZUPz/1CR2iVDmobSTXwsSqGs9mJiOYz2O5a
   A==;
X-IronPort-AV: E=Sophos;i="6.16,243,1744070400"; 
   d="scan'208";a="734485425"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 11:07:30 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:61221]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.47.11:2525] with esmtp (Farcaster)
 id 283afdbd-6fee-4b69-afa0-4d1e0acf5f40; Tue, 17 Jun 2025 11:07:29 +0000 (UTC)
X-Farcaster-Flow-ID: 283afdbd-6fee-4b69-afa0-4d1e0acf5f40
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 11:07:28 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 11:07:17 +0000
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
Subject: [PATCH v13 net-next 4/9] net: ena: Add devlink port support
Date: Tue, 17 Jun 2025 14:05:40 +0300
Message-ID: <20250617110545.5659-5-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617110545.5659-1-darinzon@amazon.com>
References: <20250617110545.5659-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
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


