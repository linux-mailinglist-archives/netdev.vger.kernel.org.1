Return-Path: <netdev+bounces-31373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C99D78D569
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 13:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C6128136B
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 11:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF41441D;
	Wed, 30 Aug 2023 11:09:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB253D6D
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 11:09:08 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87187CC9;
	Wed, 30 Aug 2023 04:09:06 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37UB8sJC031855;
	Wed, 30 Aug 2023 06:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1693393734;
	bh=aTIg5mzV7JiNY3xt8bYwUjiNb7vWP7ZZum5iREsZtTQ=;
	h=From:To:CC:Subject:Date;
	b=Fc27m1+bXAStdsdD7heVkIAO5Hoa0SVl35K1GkEDe8aMM7ldGo0LXz0NinBxFqdc4
	 u1p4i1Bw8IX8zaP9YR6qaajF/LxNATvtcvFljD5g1wISWPtAEOBGvDCtEfOVU+qSyJ
	 jcivULGwkKVCdOJQQ+8Q+leerzILXnC1QbH455Lo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37UB8spd020349
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 30 Aug 2023 06:08:54 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 06:08:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 06:08:53 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37UB8r3O100193;
	Wed, 30 Aug 2023 06:08:53 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.35])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 37UB8qRY005982;
	Wed, 30 Aug 2023 06:08:53 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Simon Horman <horms@kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>, Andrew Lunn <andrew@lunn.ch>,
        MD Danish Anwar
	<danishanwar@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>
Subject: [RFC PATCH net-next 0/4] Introduce switch mode and TAPRIO offload support for ICSSG driver
Date: Wed, 30 Aug 2023 16:38:43 +0530
Message-ID: <20230830110847.1219515-1-danishanwar@ti.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series adds support for switch-mode and TAPRIO offload for ICSSG 
driver. This series also introduces helper APIs to configure firmware
maintained FDB (Forwarding Database) and VLAN tables. These APIs are later
used by ICSSG driver in switch mode.

Thanks and Regards,
Md Danish Anwar

MD Danish Anwar (3):
  net: ti: icssg-prueth: Add helper functions to configure FDB
  net: ti: icssg-switch: Add switchdev based driver for ethernet switch
    support
  net: ti: icssg-prueth: Add support for ICSSG switch firmware on AM654
    PG2.0 EVM

Roger Quadros (1):
  net: ti: icssg_prueth: add TAPRIO offload support

 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/Makefile              |   4 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c  | 324 +++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |  25 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 367 +++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  55 ++
 drivers/net/ethernet/ti/icssg/icssg_qos.c     | 294 +++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h     | 119 +++++
 .../net/ethernet/ti/icssg/icssg_switchdev.c   | 478 ++++++++++++++++++
 .../net/ethernet/ti/icssg/icssg_switchdev.h   |  13 +
 10 files changed, 1666 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.h

-- 
2.34.1


