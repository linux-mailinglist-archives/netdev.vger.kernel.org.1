Return-Path: <netdev+bounces-153307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6CE9F792C
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8EE1897DF0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B24221D89;
	Thu, 19 Dec 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bezi6adN"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928B1CD15
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734602691; cv=none; b=lO8+Yo8eUb/0UO1hNPykEqm1FEicDcN7C3dyhdVcO4naoX1jtOpFBoc0x+EAWc46hpF3GEMwX2jXWYwarJOPi4i/vNZ1vTgtm+HaXkpjncGcYfIwyjAMog1floQogvNhelvRU2Cz6RcrJsm9qi6XAZtE/5+36V6qys6B0q+S0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734602691; c=relaxed/simple;
	bh=z+jT2BH6CXQz/LdKck8Nm3esbiFuCecq45fWe9fhMPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sxs8iAfC9V9bFfppSISg8gNUyCh2YhY1CkVlb7AOWpnNvS7fGFc3hmLhLw9CbotarwBgCxsaNuNurK+iqoYpFpnJZQqAizQrZTMnnc9LNNCUTCEP6OP7FOQhnVPEzo0wPGOohgMVA0Ytw6ajjggD08jDyVyn1N3LFOUQsPfgwio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bezi6adN; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734602685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FC0BByRwY5jjyaoArpGEimBF8TVNc68F1f4qhJsjgiU=;
	b=Bezi6adNZl5SgpxAkwryyWDemBTowix375Ag8rdW+TB/oww8MOw5Y3N0s76oR6MuXM4Vc6
	Txp7XhnIokk5GyTZdSacrtYG4DHDaMNdCTr5abXzByIQmp3E/XJqmGvZfsakILoUHsPUdv
	j1R8SEFqZY00fLodpwWfj7MPV4ngI+w=
From: Yajun Deng <yajun.deng@linux.dev>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next v2] net: mdio_bus: change the bus name to mdio
Date: Thu, 19 Dec 2024 18:04:54 +0800
Message-Id: <20241219100454.1623211-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since all directories under the /sys/bus are bus, we don't need to add a
bus suffix to mdio.

This is the only one directory with the bus suffix, sysfs-bus-mdio is
now a testing ABI, and didn't have Users in it. This is the time to change
it before it's moved to the stable ABI.

Change the bus name to mdio and update sysfs-bus-mdio.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v2: update sysfs-bus-mdio
v1: https://lore.kernel.org/all/20241219065855.1377069-1-yajun.deng@linux.dev/
---
 Documentation/ABI/testing/sysfs-bus-mdio | 54 ++++++++++++------------
 drivers/net/phy/mdio_bus.c               |  2 +-
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-mdio b/Documentation/ABI/testing/sysfs-bus-mdio
index 38be04dfc05e..a1fad1d0b8fa 100644
--- a/Documentation/ABI/testing/sysfs-bus-mdio
+++ b/Documentation/ABI/testing/sysfs-bus-mdio
@@ -1,72 +1,72 @@
-What:          /sys/bus/mdio_bus/devices/.../statistics/
+What:          /sys/bus/mdio/devices/.../statistics/
 What:          /sys/class/mdio_bus/.../statistics/
-Date:          January 2020
-KernelVersion: 5.6
+Date:          January 2025
+KernelVersion: 6.13
 Contact:       netdev@vger.kernel.org
 Description:
 		This folder contains statistics about global and per
 		MDIO bus address statistics.
 
-What:          /sys/bus/mdio_bus/devices/.../statistics/transfers
+What:          /sys/bus/mdio/devices/.../statistics/transfers
 What:          /sys/class/mdio_bus/.../transfers
-Date:          January 2020
-KernelVersion: 5.6
+Date:          January 2025
+KernelVersion: 6.13
 Contact:       netdev@vger.kernel.org
 Description:
 		Total number of transfers for this MDIO bus.
 
-What:          /sys/bus/mdio_bus/devices/.../statistics/errors
+What:          /sys/bus/mdio/devices/.../statistics/errors
 What:          /sys/class/mdio_bus/.../statistics/errors
-Date:          January 2020
-KernelVersion: 5.6
+Date:          January 2025
+KernelVersion: 6.13
 Contact:       netdev@vger.kernel.org
 Description:
 		Total number of transfer errors for this MDIO bus.
 
-What:          /sys/bus/mdio_bus/devices/.../statistics/writes
+What:          /sys/bus/mdio/devices/.../statistics/writes
 What:          /sys/class/mdio_bus/.../statistics/writes
-Date:          January 2020
-KernelVersion: 5.6
+Date:          January 2025
+KernelVersion: 6.13
 Contact:       netdev@vger.kernel.org
 Description:
 		Total number of write transactions for this MDIO bus.
 
-What:          /sys/bus/mdio_bus/devices/.../statistics/reads
+What:          /sys/bus/mdio/devices/.../statistics/reads
 What:          /sys/class/mdio_bus/.../statistics/reads
-Date:          January 2020
-KernelVersion: 5.6
+Date:          January 2025
+KernelVersion: 6.13
 Contact:       netdev@vger.kernel.org
 Description:
 		Total number of read transactions for this MDIO bus.
 
-What:          /sys/bus/mdio_bus/devices/.../statistics/transfers_<addr>
+What:          /sys/bus/mdio/devices/.../statistics/transfers_<addr>
 What:          /sys/class/mdio_bus/.../statistics/transfers_<addr>
-Date:          January 2020
-KernelVersion: 5.6
+Date:          January 2025
+KernelVersion: 6.13
 Contact:       netdev@vger.kernel.org
 Description:
 		Total number of transfers for this MDIO bus address.
 
-What:          /sys/bus/mdio_bus/devices/.../statistics/errors_<addr>
+What:          /sys/bus/mdio/devices/.../statistics/errors_<addr>
 What:          /sys/class/mdio_bus/.../statistics/errors_<addr>
-Date:          January 2020
-KernelVersion: 5.6
+Date:          January 2025
+KernelVersion: 6.13
 Contact:       netdev@vger.kernel.org
 Description:
 		Total number of transfer errors for this MDIO bus address.
 
-What:          /sys/bus/mdio_bus/devices/.../statistics/writes_<addr>
+What:          /sys/bus/mdio/devices/.../statistics/writes_<addr>
 What:          /sys/class/mdio_bus/.../statistics/writes_<addr>
-Date:          January 2020
-KernelVersion: 5.6
+Date:          January 2025
+KernelVersion: 6.13
 Contact:       netdev@vger.kernel.org
 Description:
 		Total number of write transactions for this MDIO bus address.
 
-What:          /sys/bus/mdio_bus/devices/.../statistics/reads_<addr>
+What:          /sys/bus/mdio/devices/.../statistics/reads_<addr>
 What:          /sys/class/mdio_bus/.../statistics/reads_<addr>
-Date:          January 2020
-KernelVersion: 5.6
+Date:          January 2025
+KernelVersion: 6.13
 Contact:       netdev@vger.kernel.org
 Description:
 		Total number of read transactions for this MDIO bus address.
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 7e2f10182c0c..20dd59208973 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -1425,7 +1425,7 @@ static const struct attribute_group *mdio_bus_dev_groups[] = {
 };
 
 const struct bus_type mdio_bus_type = {
-	.name		= "mdio_bus",
+	.name		= "mdio",
 	.dev_groups	= mdio_bus_dev_groups,
 	.match		= mdio_bus_match,
 	.uevent		= mdio_uevent,
-- 
2.25.1


