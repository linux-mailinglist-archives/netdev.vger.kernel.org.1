Return-Path: <netdev+bounces-255625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFTKL5F3f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:56:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D05C659C
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56D7E30125EB
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DEC223DC9;
	Sun,  1 Feb 2026 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IqXzZ6IK"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9DE23BD1D;
	Sun,  1 Feb 2026 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961302; cv=fail; b=u51MIAo7j0WR0TXdY5YuqqjLXKabfzYtOJaWXSmdkrknYzu65kA4WTxa+BamYLei4UPhcBUA/mIL80wkmgP6B8EkmJvxaJN5t/YUUp1oOQfqehzXoeaud3VyysxOkj3toNqoe3REiGV40/PiHPqVXKa2qAY+FecxKMpCmrChNek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961302; c=relaxed/simple;
	bh=Duf97C8mxT2rKcfNHNWCCwo7dDZF7JHc7l6gD0g/ojI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCxbhXlffDDpyAN7a/5DfjFRgYtAorBV6ieBgYsEWaZzE5jsX+ZEYYiyca1dHT80ne7teWSGyjLWfKivzPPmqOXt0zCNnD13Oi7RbAn1xD13t+KdBcJIARIqHXzg2Vt1b+IShTTuaVDYyOwjzEY1abQbDTxmfsnMrFVTUDzgISQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IqXzZ6IK; arc=fail smtp.client-ip=52.101.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uf8Pas/i6En0foUuveBf0qKdA5bpiGi6jScwpbCnwqoZraCEQmfWRFA9Q70BuflXXGuc9FcttnV6YapkmKzDD1AxAYFA6jeKN0J7kpmojy0jOrgY0ErXB5BDfov5CwF+jdZtUi0M5bBhMlRRZOSlYO2NZoM44rm0dvF7zQrRL4ZifuZ2vOT2XxafXokGqULZg8+ms/Jx/5NzqqojThycwO3t8vZ4wREtq4MXhV10FcizvXfgVTDBnggGTLSoGHdGRB+ko2xHNGehkgqisOdOUlBa/c41WbTN4T5G7E0zBf6CLYjeHvJVLWhoXCKZPlZeS/hZA+Z22z/LdWQng2/NbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VLc89sXc6b2NCWDfT0KrtQq0QwAegNrhWbuR2D6464=;
 b=BwFiMQ3OEDI9Vv+rv9k74U9dEsMGmZYo7Uc/SeyNFXQZdXemSvVOBwre6K6mr9E/a6D2efYpHs53Eah54qUb0l0MM98YSiaFXHh+ldwQPpdNigh5+CB687xynytOP0AJWvlr/hwQMEp2Lse2qDJ3aSZU2oAyVRjrFhBunt3U+TP7TG7TMMYsuE/U7D0+XFizCxGLwzkAXZoc0jNP6g9SjSsLEby7ITHklzPOcO27iFAful0A193kT5hm6i956HtKbH5RS8dbTbGizE201dbcL44lIJfFsGlXikNkx2Tq7zw1AERuz4VvUshMnvfh2yxcquYoRRjyMdx1f7oj84HZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VLc89sXc6b2NCWDfT0KrtQq0QwAegNrhWbuR2D6464=;
 b=IqXzZ6IKXpGLhynd3nmkJM9vWu6LYulXPTq1mOnmQWoPHV13SL1v7TmfoDPRUvF0voSrDwQ752b+dn8Gn6waa7ZxqwjRsZDWpXqTN9qWrYlnqM66O0d1uGTw37vCpLf/zbFh1NT2pQmImExvt+dRSRP6kixtoX7OJXKMRbd0TfE=
Received: from BYAPR06CA0056.namprd06.prod.outlook.com (2603:10b6:a03:14b::33)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:54:54 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::f1) by BYAPR06CA0056.outlook.office365.com
 (2603:10b6:a03:14b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sun,
 1 Feb 2026 15:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:54:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:54:53 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:54:52 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v23 04/22] cxl/sfc: Map cxl component regs
Date: Sun, 1 Feb 2026 15:54:20 +0000
Message-ID: <20260201155438.2664640-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 008f997f-d5e2-4924-68c2-08de61aa3dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T2ZFbtNM9dXt0/T8MQ47zQF1xlTzGv1DU+X8tC5llej8PCelOxbhlL2LGlOH?=
 =?us-ascii?Q?GV5b+7+UAa3by+uAM9sjvtYHguOnwF4KXgFDScF1KHjAwAGmv44Ea7owVR+p?=
 =?us-ascii?Q?FRqQ0AWGwpPicsEAxByqiyWwo+iAgSZ4if9/0ZwHzBMY7X6ZBsfOguFX0vqY?=
 =?us-ascii?Q?jKwr2UyIv4Qk42ZVDx4MFA+YoapMsQRsL+gzZG/9FYQKOLf14s9m51xUc7Qt?=
 =?us-ascii?Q?wI/z1mxaa7HTM8MVFK1dOT4wvbMm1qK2/Wx21FgaIf6DYk0Rfpr1J7nM+jmm?=
 =?us-ascii?Q?tpc3TY44y+UnNSkY8AC8htTj7I0oTpTS7h2ypxolBTE3ndG5+aZF9d9SApla?=
 =?us-ascii?Q?3AmLoOwCwRGWbj7rk3Fbo29PLNaVqxd6Dtc8O7+55AynimskLpgk/vwelEDj?=
 =?us-ascii?Q?+x7AkVMWcfRwTlyTReLeYwSgeXYnQtcg6mtVTfraHK5yjQNHbDSzdE3sDJEk?=
 =?us-ascii?Q?NhQmcST9uBw2jf+cfYycihwEHXYzdhCcvDLr2pJfyY+Vr0pCur65bNAJJckB?=
 =?us-ascii?Q?bqhp0Xfp9c70/rZCmfn9s0I0lmNvc1AcJvrJ6nh73mvzeMdBPRCg3H544GDB?=
 =?us-ascii?Q?gRpijiJJ+Aw9zxo3RgK/CFBPA+B6Ul+Y128PFU0ELRn7oUkrLPnBiJypaZnu?=
 =?us-ascii?Q?tHLPbzYsgXznvJnIzYSh28n4fKHhPAltfpViVeaI+Na8tgI+oBM2B89zxwzH?=
 =?us-ascii?Q?3Mfq4GaYU3Xl3M/l9plNr53Zz860yTacCsxIB3Lbqex2gtPHcwEkY7O9Kb16?=
 =?us-ascii?Q?mp2ui3PCQFMt1HTk5G3UscYSjsgu2QGyL7LdBCq+3g3pTuqN3u3xXTOX+DLL?=
 =?us-ascii?Q?1Xti2nwkkfeRredeho0Yfa0EdWGzV164II1bexluQ6joEOtSoqS1f2rn3WXC?=
 =?us-ascii?Q?6yg++kbY/dCAylnf28ZhhRV1lAslygGSIPyEF86JEXgQApD8E1iSy9qXGurn?=
 =?us-ascii?Q?4FHTWn/EBJgi+fyFAcPXqzlDWVq60N4oH+RAIEgOiScTzVrPrpbDrxUd7ArX?=
 =?us-ascii?Q?ZDUQa1lBP9s+SG7yJrDn/S7cersPOTa+vrzBRlyLZsUH4dtVrVjy0cw98txJ?=
 =?us-ascii?Q?LdNKPo+KXRPB5B+782pkn/K2WQZsIX0V8w+uy5NWlPe4PsoY1wBAY1zvrZQS?=
 =?us-ascii?Q?pxYazkN3hOYqMnWlRzljXHITzvPvZkb1dm9he7Tqt6AT69HnckUqjd1FEHN+?=
 =?us-ascii?Q?zK+0ttNkq7bwNXsJJK9uGmXe7+zfMNUsK+fFa6N/0I5rbMrFZwwQAEeiv/Em?=
 =?us-ascii?Q?OJy28VsxSSwvghI4Opw+85fxHMmdA5dAjL/k2EaJxutCWpoPwGPEa1D2MDsX?=
 =?us-ascii?Q?1H6WrOY1xMt4utlUwgh9Tid1pnLP9CWwF/dgl2lFUH3C/imC57dOhjdXmpxP?=
 =?us-ascii?Q?dlJlilBHPIq5oxxZtlFNPcG6RLu5UtrJkfURktx/1abH1wmcUVufptfi8FRg?=
 =?us-ascii?Q?G6CAFbFSn/YvnwsfAaS0oZA39uTckzUMeinUFH5GyugFYJAdCAqrQ7Sht7ho?=
 =?us-ascii?Q?knKkouDX+PKXry4Cf28rgXMJi+m/wQdjfa5dehnsVoryHp2eMNxYdxkcIrLV?=
 =?us-ascii?Q?P40c06qepMt4aB73+dDeiNcTgeCq/zlx/DfOqE2kftgOFCMLWZ0iyfgJnTjr?=
 =?us-ascii?Q?W9tpenK5Pofpj1eUzT1jXjCSDN4FCEAmN7geiHsVonUW3Zt53Cg0JsYJumHC?=
 =?us-ascii?Q?iKgOKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	89PslrRDvWv0rcsJYx/Pg4McRSufWrV9ystMK0VdE0voIyenFMuDscf7SAhBAK0KwXpM/rwbMSSR/nhakIfP8w5AMF/P7ujXO7tzEB75Mg1QBFNoChd1DiT78ZE+Tln+RfpIWAVIoX4pkAyrNRdplHZ3gKGHaZuyJevzgvCZX982q/xaAZ7gMgWkk1GjHLX+34JdYTlZj4Q1MMVdl6oNjKL3qmfMA1noYqN4xJ1EVwIE6TI1LUTRD6ZAvhCHoSnr59V0lNJtomnTUPGsA5N3X11hmNCBwAoqT3uhR+YVHPy1T4/h1rQY2rOWXMwfEwGJxAEj3Kz3z9mcUqWyY8JKlZzXEmNOAYKgoIcQMWZak23hUB/KeEHn3Jovl0wuZrKkdguRMScoiFojsg+QFEQkTfQapp2a5qJZ70XrID3GtqNDo/OmiDn4j5nzrezgR9uF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:54:54.4204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 008f997f-d5e2-4924-68c2-08de61aa3dfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-255625-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,huawei.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 21D05C659C
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Export cxl core functions for a Type2 driver being able to discover and
map the device component registers.

Use it in sfc driver cxl initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/pci.c             |  1 +
 drivers/cxl/core/port.c            |  1 +
 drivers/cxl/core/regs.c            |  1 +
 drivers/cxl/cxl.h                  |  7 ------
 drivers/cxl/cxlpci.h               | 12 ----------
 drivers/cxl/pci.c                  |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 35 ++++++++++++++++++++++++++++++
 include/cxl/cxl.h                  | 19 ++++++++++++++++
 include/cxl/pci.h                  | 21 ++++++++++++++++++
 9 files changed, 79 insertions(+), 19 deletions(-)
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6b7e50858d56..ba2d393c540a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <cxl/pci.h>
 #include <linux/aer.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 54f72452fb06..385588b8b30b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -11,6 +11,7 @@
 #include <linux/idr.h>
 #include <linux/node.h>
 #include <cxl/einj.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 93710cf4f0a6..20c2d9fbcfe7 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <pmu.h>
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5d111980d879..944c5d1ccceb 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -39,10 +39,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
 #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
 
-#define   CXL_CM_CAP_CAP_ID_RAS 0x2
-#define   CXL_CM_CAP_CAP_ID_HDM 0x5
-#define   CXL_CM_CAP_CAP_HDM_VERSION 1
-
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
 #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
@@ -206,9 +202,6 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
-int cxl_map_component_regs(const struct cxl_register_map *map,
-			   struct cxl_component_regs *regs,
-			   unsigned long map_mask);
 int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs);
 int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index d879120b2780..93df1b1fa326 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -13,16 +13,6 @@
  */
 #define CXL_PCI_DEFAULT_MAX_VECTORS 16
 
-/* Register Block Identifier (RBI) */
-enum cxl_regloc_type {
-	CXL_REGLOC_RBI_EMPTY = 0,
-	CXL_REGLOC_RBI_COMPONENT,
-	CXL_REGLOC_RBI_VIRT,
-	CXL_REGLOC_RBI_MEMDEV,
-	CXL_REGLOC_RBI_PMU,
-	CXL_REGLOC_RBI_TYPES
-};
-
 /*
  * Table Access DOE, CDAT Read Entry Response
  *
@@ -106,6 +96,4 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
 						struct device *host) { }
 #endif
 
-int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 668d44eb1bf5..7b4699fb8870 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
+#include <cxl/pci.h>
 #include <cxl/mailbox.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 8e0481d8dced..34126bc4826c 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -7,6 +7,8 @@
 
 #include <linux/pci.h>
 
+#include <cxl/cxl.h>
+#include <cxl/pci.h>
 #include "net_driver.h"
 #include "efx_cxl.h"
 
@@ -18,6 +20,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl;
 	u16 dvsec;
+	int rc;
 
 	probe_data->cxl_pio_initialised = false;
 
@@ -44,6 +47,38 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (!cxl)
 		return -ENOMEM;
 
+	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
+				&cxl->cxlds.reg_map);
+	if (rc) {
+		pci_err(pci_dev, "No component registers\n");
+		return rc;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
+		pci_err(pci_dev, "Expected HDM component register not found\n");
+		return -ENODEV;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.ras.valid) {
+		pci_err(pci_dev, "Expected RAS component register not found\n");
+		return -ENODEV;
+	}
+
+	rc = cxl_map_component_regs(&cxl->cxlds.reg_map,
+				    &cxl->cxlds.regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc) {
+		pci_err(pci_dev, "Failed to map RAS capability.\n");
+		return rc;
+	}
+
+	/*
+	 * Set media ready explicitly as there are neither mailbox for checking
+	 * this state nor the CXL register involved, both not mandatory for
+	 * type2.
+	 */
+	cxl->cxlds.media_ready = true;
+
 	probe_data->cxl = cxl;
 
 	return 0;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 13d448686189..7f2e23bce1f7 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -70,6 +70,10 @@ struct cxl_regs {
 	);
 };
 
+#define   CXL_CM_CAP_CAP_ID_RAS 0x2
+#define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_HDM_VERSION 1
+
 struct cxl_reg_map {
 	bool valid;
 	int id;
@@ -223,4 +227,19 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
 						      sizeof(drv_struct), mbox);	\
 	})
+
+/**
+ * cxl_map_component_regs - map cxl component registers
+ *
+ * @map: cxl register map to update with the mappings
+ * @regs: cxl component registers to work with
+ * @map_mask: cxl component regs to map
+ *
+ * Returns integer: success (0) or error (-ENOMEM)
+ *
+ * Made public for Type2 driver support.
+ */
+int cxl_map_component_regs(const struct cxl_register_map *map,
+			   struct cxl_component_regs *regs,
+			   unsigned long map_mask);
 #endif /* __CXL_CXL_H__ */
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
new file mode 100644
index 000000000000..a172439f08c6
--- /dev/null
+++ b/include/cxl/pci.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+
+#ifndef __CXL_CXL_PCI_H__
+#define __CXL_CXL_PCI_H__
+
+/* Register Block Identifier (RBI) */
+enum cxl_regloc_type {
+	CXL_REGLOC_RBI_EMPTY = 0,
+	CXL_REGLOC_RBI_COMPONENT,
+	CXL_REGLOC_RBI_VIRT,
+	CXL_REGLOC_RBI_MEMDEV,
+	CXL_REGLOC_RBI_PMU,
+	CXL_REGLOC_RBI_TYPES
+};
+
+struct cxl_register_map;
+
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
+#endif
-- 
2.34.1


