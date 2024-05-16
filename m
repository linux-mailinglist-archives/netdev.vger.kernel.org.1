Return-Path: <netdev+bounces-96709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4748C739C
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 11:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3692840C7
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5E714388D;
	Thu, 16 May 2024 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kkZSSwwt"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEE0143883;
	Thu, 16 May 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851115; cv=none; b=jIMMpKx8+wd9Iz6+lDFgdO7mSWzzId5rxuHdepfjHo4G7qJnuejG+9W2lhD3woNRer8YRhgoyhkk8C2ZMr+BebhGXyBdYbBfCevs/LA9j99Qg713l6V04GfTZSJTnsH7V+L8LEy1YspQqHp01U2jRAFA9rxHYnHYVRft1h8ExrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851115; c=relaxed/simple;
	bh=+xmkqYSCYHnosn2TGgTyqw4XPyycmmx3R2w24+K14dk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t+rO3WwJzYmQxbCdb8kw0TMuvXvunHpd2ejAaMCtHdQGl7eiEFJ8osqKs56jYhVVRuSVPrD4BMufLBMCeTJsu5pPx2CRp+axrpZrx+vEdXXLm/Orac2V5ViA0ioMDOqlpAnQ9bR//oCKQ73DIoY+KS3niIKtxKP4u/QoLr+eaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kkZSSwwt; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44G9HtNP127035;
	Thu, 16 May 2024 04:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715851075;
	bh=KvNnbS9FRbuAHdlS0fq7GDILSQs+EwKSdndASTjueQM=;
	h=From:To:CC:Subject:Date;
	b=kkZSSwwtywvvbc689n9Qj+qgt7x/uds36UIbSKK02826imNuELS6FCwrwQUUXymL9
	 IZsF0OO5j68KQT6TBm6PBqQSZcI3r4+BIN5mzyiH6E1m962z8AwW4lFjfAnmZyJg6M
	 9S2xRhYUlTR0U/uolyc9p+rbOGtMfedtmmWlPnEw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44G9HtW9009651
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 May 2024 04:17:55 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 May 2024 04:17:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 May 2024 04:17:54 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44G9HsBY030491;
	Thu, 16 May 2024 04:17:54 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44G9Hrk3027556;
	Thu, 16 May 2024 04:17:54 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo
	<diogo.ivo@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn
	<andrew@lunn.ch>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [RFC PATCH net-next 0/2] Add multicast filtering support for ICSSG driver
Date: Thu, 16 May 2024 14:47:50 +0530
Message-ID: <20240516091752.2969092-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This series add multicast filtering support for ICSSG driver.

The patch 1/2 of the series introduces helper APIs needed to configure
FDB tables maintained by firmware.

Patch 2/2 introduces the support for multicast filtering.

The driver will keep a copy of multicast addresses in emac->mcast_list.
This list will be kept in sync with the netdev list and to add / del
multicast address icssg_prueth_mac_add_mcast / icssg_prueth_mac_del_mcast
APIs will be called.

To add a mac_address for a port, driver need to call icssg_fdb_add_del()
and pass the mac_address and BIT(port_id) to the API. The ICSSG firmware
will then configure the rules and allow filtering.

If a mac_address is added to port0 and the same mac_address needs to be
added for port1, driver needs to pass BIT(port0) | BIT(port1) to the 
icssg_fdb_add_del() API. If driver just pass BIT(port1) then the entry for
port0 will be overwritten / lost. This is a design constraint on the
firmware side.

To overcome this in the driver, to add any mac_address for let's say portX
driver first checks if the same mac_address is already added for any other
port. If yes driver calls icssg_fdb_add_del() with BIT(portX) | 
BIT(other_existing_port). If not, driver calls icssg_fdb_add_del() with 
BIT(portX).

The same thing is applicable for deleting mac_addresses as well. This
logic is in icssg_prueth_mac_add_mcast / icssg_prueth_mac_del_mcast APIs.

MD Danish Anwar (2):
  net: ti: icssg-prueth: Add helper functions to configure FDB
  net: ti: icssg-prueth: Add multicast filtering support

 drivers/net/ethernet/ti/icssg/icssg_config.c | 186 ++++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_config.h |  19 ++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |  50 ++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  15 ++
 4 files changed, 263 insertions(+), 7 deletions(-)


base-commit: 654de42f3fc6edc29d743c1dbcd1424f7793f63d
-- 
2.34.1


