Return-Path: <netdev+bounces-99641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9768D5994
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2BE3B22B60
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 04:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96F67B3FA;
	Fri, 31 May 2024 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eSRk4B6v"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3345200DE;
	Fri, 31 May 2024 04:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717130749; cv=none; b=sm7TVitLWjevv94dXHzUHzUi23AfauwuivQWcBvgToFXqZPLKJqYY+jEpRKvfKAq2NSrkiFizPfJJMZwvVND6pLNZQVVXAA8V9ajN6sNQ7aQVkqekkR4/aBUBYpRarnN2ghxL3wiHJ74yMf1Erb0AFk2Mh9oXS+35O2zO4WCUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717130749; c=relaxed/simple;
	bh=AcQjH0Tv+ds/w/G6RFoYZcCzZe6XNzxHUHykPWMypY0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qvRNDzvJwN9JW8q3rM1YjibpQUHEZoL/KKT+y4wyo2Zu9u7Ek7XFe6m7fTHZ3F9s2PR8LX7lutyQernPqsv+eeq1R3wrNJ9ukAgr0OYKRgl+2UKxSDU+pIJsRDifa+A7wavnbhSFjtnu3HrlgBH/N5U04G1N2DANExQWNLspM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eSRk4B6v; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44V4jHpV092443;
	Thu, 30 May 2024 23:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717130717;
	bh=mNKiM5U/rsPEaic2/48KPNyIn8o3PwqoEUPJCxassRk=;
	h=From:To:CC:Subject:Date;
	b=eSRk4B6vXMdQ4a5sQcdPvJOmfIOdutd9bt0FjzeLGsvUZSJrlyk7i5aJXHkBjwv5S
	 P/w2P5oeuJgxGqVv2B4h0OR18Z57F4fPqT1OuSEWGnJeY6QpMEetNEEAEH7d4oc7V9
	 dVaAhpIw28ujYW7b4TXxljkaIe9b6DdLtS0D/9R0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44V4jH8u120082
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 23:45:17 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 23:45:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 23:45:16 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44V4jG4r035650;
	Thu, 30 May 2024 23:45:16 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44V4jFPZ023385;
	Thu, 30 May 2024 23:45:16 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Simon Horman
	<horms@kernel.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD
 Danish Anwar <danishanwar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>
Subject: [PATCH net-next v9 0/2] Add TAPRIO offload support for ICSSG driver
Date: Fri, 31 May 2024 10:15:10 +0530
Message-ID: <20240531044512.981587-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This series adds taprio offload support for ICSSG driver.

Patch [1/2] of the series moves some structures and API definition to .h
files so that these can be accessed by taprio (icssg_qos.c) file.

Patch [2/2] of the series introduces the taprio support for icssg driver.

Changes from v8 to v9:
*) Rebased the series on latest net-next/main as the series was not
   cleanly applying because of [1] as mentioned by Jacob Keller
   <jacob.e.keller@intel.com>. Now the seires can be cleanly applied on
   net-next with or without [1].
*) No other changes done in this series.

Changes from v7 to v8:
*) Modified commit message of patch 2/2 to state both ICSSG Switch and
   dual-emac firmware supports taprio offload as pointed out by
   Andrew Lunn <andrew@lunn.ch>
*) Rebased on latest net-next/main

Changes from v6 to v7:
*) Rebased on 6.10-rc1.
*) Removed RFC tag, no functional changes.

Changes from v5 to v6:
*) Added RFC tag as net-next is closed now.
*) Created a new patch for "the struct definition move" and made this
   series instead of single patch as suggested by
   Paolo Abeni <pabeni@redhat.com>.
*) Removed est_new structure as that is no longer used.
*) Freeing qos.tas.taprio_admin using taprio_offload_free() as suggested
   by Paolo Abeni <pabeni@redhat.com>
*) Clearing taprio_admin and taprio in error case in emac_taprio_replace()
   API using goto label taprio_clear.
*) Added RB tag of Simon Horman <horms@kernel.org> 

Changes from v4 to v5:
*) Rebased on latest net-next/main [commit 5c4c0edca68a]
*) Moved icss_iep structure to icss_iep.h file so that iep wraparound time
   which is stored in iep->def_inc, can be accessed by qos file.
*) Added comment about IEP wraparound time compensation in icssg_qos.c
*) Moved icssg_qos_tas_init() to prueth_netdev_init() so that icssg_qos_tas_init()
   gets called even if interface is down.
*) Fixed print statements as suggested by Vladimir Oltean <vladimir.oltean@nxp.com>
*) Added taprio_offload_get() and taprio_offload_free() in emac_taprio_replace()
   and emac_taprio_destory() respectively.

Changes from v3 to v4:
*) Rebased on the latest next-20231005 linux-next.
*) Addressed Roger and Vinicius' comments and moved all the validations to
   emac_taprio_replace() API.
*) Modified emac_setup_taprio() API to use switch case based on taprio->cmd
   and added emac_taprio_destroy() and emac_taprio_replace() APIs.
*) Modified the documentation of structs / enums in icssg_qos.h by using
   the correct kdoc format.

Changes from v2 to v3:
*) Rebased on the latest next-20230928 linux-next.
*) Retained original authorship of the patch.
*) Addressed Roger's comments and modified emac_setup_taprio() and
   emac_set_taprio() APIs accordingly.
*) Removed netif_running() check from emac_setup_taprio().
*) Addressed Vinicius' comments and added check for MIN and MAX cycle time.
*) Added check for allocation failure of est_new in emac_setup_taprio().

Changes from v1 to v2:
*) Rebased on the latest next-20230921 linux-next.
*) Dropped the RFC tag as merge window is open now.
*) Splitted this patch from the switch mode series [v1].
*) Removed TODO comment as asked by Andrew and Roger.
*) Changed Copyright to 2023 as asked by Roger.

v8: https://lore.kernel.org/all/20240529110551.620907-1-danishanwar@ti.com/
v7: https://lore.kernel.org/all/20240527055300.154563-1-danishanwar@ti.com/
v6: https://lore.kernel.org/all/20240515065042.2852877-1-danishanwar@ti.com/
v5: https://lore.kernel.org/all/20240429103022.808161-1-danishanwar@ti.com/
v4: https://lore.kernel.org/all/20231006102028.3831341-1-danishanwar@ti.com/
v3: https://lore.kernel.org/all/20230928103000.186304-1-danishanwar@ti.com/
v2: https://lore.kernel.org/all/20230921070031.795788-1-danishanwar@ti.com/
v1: https://lore.kernel.org/all/20230830110847.1219515-1-danishanwar@ti.com/
[1] https://lore.kernel.org/netdev/20240528113734.379422-1-danishanwar@ti.com/

MD Danish Anwar (1):
  net: ti: icssg: Move icss_iep structure

Roger Quadros (1):
  net: ti: icssg_prueth: add TAPRIO offload support

 drivers/net/ethernet/ti/Kconfig              |   1 +
 drivers/net/ethernet/ti/Makefile             |   1 +
 drivers/net/ethernet/ti/icssg/icss_iep.c     |  72 -----
 drivers/net/ethernet/ti/icssg/icss_iep.h     |  73 ++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   4 +
 drivers/net/ethernet/ti/icssg/icssg_qos.c    | 288 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h    | 113 ++++++++
 8 files changed, 483 insertions(+), 74 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h


base-commit: ccf23c916ca35239a924ec8649cc88b1ef25d3d9
-- 
2.34.1


