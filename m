Return-Path: <netdev+bounces-99652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B48D5A97
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFC81F21F7D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B8580025;
	Fri, 31 May 2024 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vIz59t3g"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C707F7FBCE;
	Fri, 31 May 2024 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137636; cv=none; b=gHXHmulNNT3xtpcoJqtQtXv7MEOOqWn+QWhDdH5KDQnOKdkcKJPxon1mlSA72POHNjWxT7O4yFukkoLn6m5UAcS9B1dqPlJmr4AGZGbk0KTRDL2nnXDn9CQA1lRwS0eJJTgZBoMHUmXSTQ5gGI2VZfsBomkYpUcQQYzj8w9DQmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137636; c=relaxed/simple;
	bh=QPnk30UOxQpFVKWagGBoGDuovXqy0EZS0AEk1T/lzvI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C4AAeiuyQW6lH92NUOgVDc+UMwno8CDQk84pKUKl/1soSTZaXmPdBdcCEGbuZ4QM4JwUYgHwFz+A+MR600kGuU5WROoIbE4VdNZS1Pez5i3hu2HiKNNVJODcdbZx1dCD8/zhBuvNskhvQEQovMpITib/I1PCcoYTNIuNFvpl928=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vIz59t3g; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44V6e8Yt121186;
	Fri, 31 May 2024 01:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717137608;
	bh=Ni++lcXnjxEEqESx2kuidA8d3WRyg+9fpCXKSkBuHsQ=;
	h=From:To:CC:Subject:Date;
	b=vIz59t3gvcOo1Hx3FzaNpqvUmdDSI2LnpErLgxkMTNLW/aVK1mUM/e+IG2QG+3Pz5
	 Hx4e72VxbnWQibgdeT3eI77aAfOZFnAYjoNn6oMvqeLsGH+4U6o3ETlw5J988CmBin
	 y6qE/oS8o+Lo+T6lnnPfDqR8kEtKICWpbvHo+Hv8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44V6e89N007605
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 May 2024 01:40:08 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 01:40:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 01:40:08 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44V6e8Mn121301;
	Fri, 31 May 2024 01:40:08 -0500
Received: from localhost (linux-team-01.dhcp.ti.com [172.24.227.57])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44V6e79r010373;
	Fri, 31 May 2024 01:40:08 -0500
From: Yojana Mallik <y-mallik@ti.com>
To: <y-mallik@ti.com>, <schnelle@linux.ibm.com>,
        <wsa+renesas@sang-engineering.com>, <diogo.ivo@siemens.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>, <vigneshr@ti.com>,
        <rogerq@ti.com>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <rogerq@kernel.org>
Subject: [PATCH net-next v2 0/3] Introducing Intercore Virtual Ethernet (ICVE) driver
Date: Fri, 31 May 2024 12:10:03 +0530
Message-ID: <20240531064006.1223417-1-y-mallik@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

virtio-net provides a solution for virtual ethernet interface in a
virtualized environment.

There might be a use-case for traffic tunneling between heterogeneous
processors in a non virtualized environment such as TI's AM64x that has
Cortex A53 and Cortex R5 where Linux runs on A53 and a flavour of RTOS
on R5(FreeRTOS) and the ethernet controller is managed by R5 and needs
to pass some low priority data to A53.

One solution for such an use case where the ethernet controller does
not support DMA for Tx/Rx channel, could be a RPMsg based shared memory
ethernet driver. The data plane is over the shared memory while the control
plane is over RPMsg end point channel.

Two separate regions can be carved out in the shared memory, one for the
A53 -> R5 data path, and other for R5 -> A53 data path.

The shared memory layout is modelled as circular buffer.
-------------------------
|          HEAD         |
-------------------------
|          TAIL         |
-------------------------
|       PKT_1_LEN       |
|         PKT_1         |
-------------------------
|       PKT_2_LEN       |
|         PKT_2         |
-------------------------
|           .           |
|           .           |
-------------------------
|       PKT_N_LEN       |
|         PKT_N         |
-------------------------

Polling mechanism can used to check for the offset between head and
tail index to process the packets by both the cores.

This is the v2 of this series. It addresses comments made on v1.

Changes from v1 to v2:
*) Addressed open comments on v1.
*) Added patch 3/3 to add support for multicast filtering

v1:
https://lore.kernel.org/all/20240130110944.26771-1-r-gunasekaran@ti.com/

Ravi Gunasekaran (1):
  net: ethernet: ti: RPMsg based shared memory ethernet driver

Yojana Mallik (2):
  net: ethernet: ti: Register the RPMsg driver as network device
  net: ethernet: ti: icve: Add support for multicast filtering

 drivers/net/ethernet/ti/Kconfig               |   9 +
 drivers/net/ethernet/ti/Makefile              |   1 +
 drivers/net/ethernet/ti/icve_rpmsg_common.h   | 137 ++++
 drivers/net/ethernet/ti/inter_core_virt_eth.c | 591 ++++++++++++++++++
 drivers/net/ethernet/ti/inter_core_virt_eth.h |  62 ++
 5 files changed, 800 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/icve_rpmsg_common.h
 create mode 100644 drivers/net/ethernet/ti/inter_core_virt_eth.c
 create mode 100644 drivers/net/ethernet/ti/inter_core_virt_eth.h

-- 
2.40.1


