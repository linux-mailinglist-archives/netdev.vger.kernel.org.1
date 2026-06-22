Return-Path: <netdev+bounces-301101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6uCoIVAtOWrxnwcAu9opvQ
	(envelope-from <netdev+bounces-301101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:40:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C836AF804
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:40:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=YQyad3Rf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301101-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301101-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BB90302F770
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D2D25B090;
	Mon, 22 Jun 2026 12:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012015.outbound.protection.outlook.com [40.93.195.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B783998B7;
	Mon, 22 Jun 2026 12:40:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132029; cv=fail; b=mBfSn7ZHVHwnOwOTkluKScBg6IFlJ0H7ulDbJXVxG2lC8QuROj5Gdom5CDCKFbJ2hWdOZqMyTaEU2gqEK3G70QbLgExE5PK1YQKhet7hsuRykR49FjLym6pmM0jX4Z8HFspsFicLYXkoAlUD2ID15ogxOhiRtvs1sswU7lxLri0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132029; c=relaxed/simple;
	bh=VOijXDX0KQGxNvw0qhh38Q7dCPEWhRkE5PGaPhrPpSM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eCC3USMXuwFP7+o9q6XUHhS/ek81yvH+/7fog2vauyRBgmbcSzj1t1Kc9/r5xWSHNqbCwJvRY5VauHcklHF1wJhn0lUnSOUR4i8jN1UhoIhnhCVt+4SL9/sNgFG/ZZLs5EB5t0YukkJSWwsyctR62ZVH3SqfEqcUcFngJryHPgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YQyad3Rf; arc=fail smtp.client-ip=40.93.195.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXDR660ti/gOMmqawvSeb70SsvUpxbMbVPMR5eYgEQhyeA6InBQ6N3C6s1d0FV3vUrq4ELKzj8Ef5n84dCZJqPft3wFRZoiOv6Tj6FVfGn7Ot7PKdafvRvfhD0oh9qOnUEbtj7f5R1fAXOkkaesOZAW7DendR6aBgN0ifnEVwrHpxWxZirnMH330uvvgNjo1h7H0cZvJNKmex1mx0ZCTFsUJY8zG5Nj0plKG8TKIpPHKxYbzBBTCw3RUplBRi49tRZlEb2EOaD5fxspeW0bofwIuZL7mEwZdHlkm/METpr1rSd8rVzLTwuqXWNK0noIAKXXdI/D8yMvLHI8AWiifkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+052r72HWq49ChhVPm2c5o/dInd85E/d5yevwsENB6E=;
 b=xoa4DGfkInqquJVf5b64uGejWRnIenaOhSY4dGN4A5OAZVtoo+2YiBk9h+bZAZQ6mzKyoFevmN+B4ICGezPgRim3Sf1IMscg0PWOlAxZUBcIVzEorrbtEMXl/xoFDBsJLBvBZhksYuUgaXglf9/q+xDFZ60hsL/teA5bZyOh6urm5kssjXyiKQ3gPHYbrU+l4JLHL9zTn4N+ZzJkjl95ftMf/VHLdWBDhM+pAnxMvRoM0hZJ2917NIU7bIj/08h/SGRKYuJplRrq6fsHdrDLj+yvwL1fQ/+sxBdMJhSMBaE9NJkBTGu4eLfrG4CBkuwUIstB2a/DoezBYx5HL3IhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+052r72HWq49ChhVPm2c5o/dInd85E/d5yevwsENB6E=;
 b=YQyad3RfkbbXxIxC2B3UMI0ZQGSObmixm1K5FkeJ6va3b83Us/HVRBk9vHcl30eyRFE6/uIcetzbBxh8fmSyXpzxbJCXx6VYtCkTcMfyRSLFEAkj59p20xcZd0TwI4kinUrKMHva8VUk3tjqGTpGKHMXu+XS+FNrhY/s1PAbaXY=
Received: from BL1P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::29)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 12:40:24 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::4e) by BL1P222CA0024.outlook.office365.com
 (2603:10b6:208:2c7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 12:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 12:40:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 07:40:23 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Mon, 22 Jun 2026 07:40:22 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@kernel.org>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v29 0/5] Type2 device basic support
Date: Mon, 22 Jun 2026 13:40:05 +0100
Message-ID: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d2c62d-35a8-48e5-c382-08ded05b6e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	A/OHF7gaXA5g7mH6LIzOMh3UCCX+Ttpi/vCJ8eVUxDHrFpiAscqW+z+NwIKaL2CexBp6yhPPZRwI9O0mAe1a9BEY6k9QXvzDVN9OzDERWzlf51aZI5+lClo7DNbb+mlQukmUmdj8knJoSdfTKid5/zllyVooGvcJEN5dfDr2NmJUaxIHiJPJQwmJ5ebNL4ID9Cuyke5U14aamxsAPimMYhY99dXjSJEbcam7KM9dRVcSYIRrfKoWp4Q7oM2cGjHPOXyOkV3UyUr5UAUXJzLWFHFtrmLyF9iTh9RuDmNVDmhwtPhBqrw2zb9+WRcGvsxS4YhuYtnIxcU3VXOe6umxTEwNO6q/mqh1V/lr9UgcKcU6qep+S/Xa59HzDLVnoFOD70N65RPVih6xcw5afruBowpKA96fY9+VNEVbpn+q/iNWP8i3cvoVIcPyv4avM8ebuPlqJyFSRZ9B8EQPl8vAt1JhFv15nRNeSvypBabKTzFsOC//2jBsvi7+0uuF/BniPBhxKQcdGkTPO8Yl2OLfGv0cWWylqbISOq7flJNKG/2YUpJkLKYvjYS9p7QMByJdCQ73Zsy6etxomzC5/g7Y562ev1oihRA2aWvrOG1Zimsj9YG/27fnG1CmM+PX8Kuf5keV6A1cSZNXjmanfNz2BAlISn249pZdwUGaxaCbp6ZT0fOuBKq/b2uhOB8ZAloQ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3sQGYihfFTi/MM2DcYfp3UxNzYLkXdzOlz2TgfdvzH6CTT+cb+0vIxedj97cyQa/Jc9cNcuwEMzECJccoGYNS3rRWNcyqf97vcaA4fYbixHmGy7sQd+Tci2I4fnwPPhdtQiHfNG7irSjVYlQCNAgA8at7zZtBhV+xbhUnVfAem+Cwf4WX91l3QSAPnrSp+9uDgt8dsSISiaBYkx1BhENQ6Y45R5l3HbwM4K13NETHETv1vHBtCT+siO0vsAo6sB9ZJOjw347iQsYd8vN1RTFgZctMgwaGtYJejndA26x93LrUNsjCXy4qFfy/2+zuHQAy8LGkoIKMXWFz++73eWx7RgLnhdy7AmRiRwUjHdu0T50UtddHEgcQPP3aJE2cu6/VVgOq/bthr3gZiOtHNn/+aIgXjRq+TCupYvGdqEGSfikruoKwvpi43APGttnWxoW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 12:40:23.9643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d2c62d-35a8-48e5-c382-08ded05b6e0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:dan.j.williams@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301101-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8C836AF804

From: Alejandro Lucero <alucerop@amd.com>

This series adds the last bits for allowing a CXL Type2 driver to obtain
a CXL region linked to the device HDM decoders committed by the BIOS,
with the driver being the sfc network driver.

Changes from v28:

 - patch 1: 
	fix doc (Ed Cree)
	fix error path (Sashiko)

 - patch 3:
	removing extra + char (sashiko)

 - path5:
	remove stray change (Ed Cree)

Changes from v27:

 - patch 1: make driver probe failing if error in efx_cxl_init (Dan)
 - patch 4: add unmapping if error after efx_cxl_init (Dave)
 - patch 4/5: move cxl_pio_initialised from patch 4 to patch 5 (Dave)

Tested in the cxl_for_7.3 branch.

Alejandro Lucero (5):
  sfc: add cxl support
  cxl/sfc: Map cxl regs
  cxl/sfc: Initialize dpa without a mailbox
  sfc: obtain and map cxl range using devm_cxl_probe_mem
  sfc: support pio mapping based on cxl

 drivers/cxl/core/core.h               |   2 +
 drivers/cxl/core/mbox.c               |  51 +------------
 drivers/cxl/core/memdev.c             |  67 ++++++++++++++++
 drivers/cxl/core/pci.c                |   1 +
 drivers/cxl/core/port.c               |   1 +
 drivers/cxl/core/regs.c               |   1 +
 drivers/cxl/cxlpci.h                  |  12 ---
 drivers/cxl/pci.c                     |   1 +
 drivers/net/ethernet/sfc/Kconfig      |   9 +++
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  41 ++++++++--
 drivers/net/ethernet/sfc/efx.c        |  18 ++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 105 ++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  32 ++++++++
 drivers/net/ethernet/sfc/net_driver.h |  10 +++
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     |   2 +
 include/cxl/pci.h                     |  22 ++++++
 18 files changed, 309 insertions(+), 70 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: 9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686
-- 
2.34.1


