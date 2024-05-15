Return-Path: <netdev+bounces-96474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017EC8C610C
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 08:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9DD283673
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 06:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8BB41C73;
	Wed, 15 May 2024 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aIqRY/xU"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950853392;
	Wed, 15 May 2024 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755882; cv=none; b=S41jfQABvMarWha4zpNZ+axj411HAy0cBQ1nff4A2re94ahI/LvM/oqBf80KcZ2ma+FenL2jQppreC3/dvEPJeJvZN88omrfwYqzx/e6tnpZIDy8eOGxOYA/v8XNZBNa+Ugm6Som3h5df/vX2K8oQ58gg9/Ht2O3Owmcw2zEFsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755882; c=relaxed/simple;
	bh=AcMqpX0URE9te22i8OHGjSQymBsQdVrP5w4QrGAwmDw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GMGn9m/ed/V+S4ptlmfG+IXCg5sTdGCn+pmTlXST5rI7dgrbDfr5Q0IyiqeLEuNoWvKUGLQOQNmLApPKsCp2EWgrwTNCTCMQxydQc+Hk6NNjMYQXM8v7UeiOgXRewgEiwwWVd3zb6N73y0sxhFcy0A14wnEtJaPX0YXoBGeUCDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aIqRY/xU; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44F6okW1126872;
	Wed, 15 May 2024 01:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715755846;
	bh=Wo3NosmbA+bW3iOvCUhh0Mt7A5msKwTFBl7WuLM2ikM=;
	h=From:To:CC:Subject:Date;
	b=aIqRY/xUPDqUtYrjdpOT3XAEWlfFRB6coMDkGPjVIx76fNf6iZ3jQnB4J5WFQAMJm
	 nv200dxz0D5dQjO1AZlWy2fayiPrPtPFXxJEgm0FjOJf+Qz/4kNRhLKGED/rCGGe1D
	 KxcMNzADKCVcSYFQ8R6+JP76sXSzPVQFn2hZpKoQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44F6okCT065032
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 May 2024 01:50:46 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 May 2024 01:50:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 May 2024 01:50:46 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44F6okS0019575;
	Wed, 15 May 2024 01:50:46 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44F6ojJr029143;
	Wed, 15 May 2024 01:50:45 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        Simon Horman
	<horms@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Diogo
 Ivo <diogo.ivo@siemens.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd
 Bergmann <arnd@arndb.de>, Vignesh Raghavendra <vigneshr@ti.com>,
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
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH net-next v6 0/2] Add TAPRIO offload support for ICSSG driver
Date: Wed, 15 May 2024 12:20:40 +0530
Message-ID: <20240515065042.2852877-1-danishanwar@ti.com>
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

This series adds taprio offload support for ICSSG driver.

Patch [1/2] of the series moves some structures and API definition to .h
files so that these can be accessed by taprio (icssg_qos.c) file.

Patch [2/2] of the series intoduces the taprio support for icssg driver.

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

v5: https://lore.kernel.org/all/20240429103022.808161-1-danishanwar@ti.com/
v4: https://lore.kernel.org/all/20231006102028.3831341-1-danishanwar@ti.com/
v3: https://lore.kernel.org/all/20230928103000.186304-1-danishanwar@ti.com/
v2: https://lore.kernel.org/all/20230921070031.795788-1-danishanwar@ti.com/
v1: https://lore.kernel.org/all/20230830110847.1219515-1-danishanwar@ti.com/
 
MD Danish Anwar (1):
  net: ti: icssg: Move icss_iep structure

Roger Quadros (1):
  net: ti: icssg_prueth: add TAPRIO offload support

 drivers/net/ethernet/ti/Kconfig              |   1 +
 drivers/net/ethernet/ti/Makefile             |   3 +-
 drivers/net/ethernet/ti/icssg/icss_iep.c     |  72 -----
 drivers/net/ethernet/ti/icssg/icss_iep.h     |  73 ++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   5 +
 drivers/net/ethernet/ti/icssg/icssg_qos.c    | 288 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h    | 113 ++++++++
 8 files changed, 485 insertions(+), 75 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h


base-commit: cddd2dc6390b90e62cec2768424d1d90f6d04161
-- 
2.34.1


