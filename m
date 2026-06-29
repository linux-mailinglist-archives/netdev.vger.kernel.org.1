Return-Path: <netdev+bounces-302823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8n73C9fPQmqQDAoAu9opvQ
	(envelope-from <netdev+bounces-302823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 22:04:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE286DE8BA
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 22:04:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=A35E35EY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302823-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302823-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BE193013B4A
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41364341AB8;
	Mon, 29 Jun 2026 20:04:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0424833E351
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 20:04:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782763466; cv=fail; b=CjApSlCX7jsT1rZGzUBsR0J7iTHqni0faRGux4sn3neo5J1nQ2Pn6dR5cs5J44Nnfo3preLIE3amJybUNSJkvOe9KxnAegted+nS5sCElLKroKbQU7K9GwT0bhdXVQUjjMtnZv0o27KAje/CSGXBQt+3cXhVwRhklus28UQB2PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782763466; c=relaxed/simple;
	bh=YKa64MS1TWV8s8LXfXUBBhy04/2xDe18ZJN8NVOgAPI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mShIrAPgT0ydqcrE7O2qMsxIPAG9ygxLHokZ7hrUsQFEtXt6Zc5MNDQ7DEKVy+YBMvOZjZtBunjECDsog0JK/Aw9s+fe1DCnwOkrd3wcvIBz8AB5i+bRGADGiIhY0ARjtkpJj7PZoF/0uNl8c0CeMLlOLl4bXpX+5H+kB+mbzEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A35E35EY; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMVHS2tlJkfGXm3bQkPRsX/L/LbbvqxfwvNF0X7ARgzA8SlyDDjo12moYAuyukeC46Kg9df2BNem43y9Q34Ue42rIdOWFXMao5NT0+iJ60BUbv9Zys1+5JGXLpXvpMcxfa5O5ipBqpoFDduq2icFVeq6E0X4jaaMYWY1E3B6LUFLHctgIPFi65nmNjHnIbosZ6ybMQMzL9KDpPLL22FEM/jwj8AbdI3rgaWTcXcdR8xbG0im+fJ2JO+3MbWJj4DQ97PMXSlNyvwSeVHWEXvdehcMN7xWrCL+GyWnzCyx0m5tQ+bxmW5Y5qRgWRcVjD9JbGCCtjtsW0PKFaaQ7ztEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLybLy6vpiCYFu1IqS/oJIJpPWttJnwlFt6MMt/Yvl0=;
 b=l9reniOF8iQ5hct6gGlslkEBBB/x9u/2tmFjwK6pAhMN4bK0oLvGohGqTeCUzKR1Wts5BqCXVhb9/js+0qt0eNHqY6DwXxyP/07fiyGeVJGznN0Fn5CeLBOVEuHoJbZlFyMolpxritxCpz+iLGQVMsEkdlrj3eHB2gDj61kt3oE+BLVpx2M7Sj/JMGkRn0/OqClg8yMvhjDjFp2xa2zhDmRfEPRECOM06ifzV+5TJVfl8BPHK2sq8G0wNT1XIBSnvKSRf99ueB2Ly0bwE+sn2UWtUbKsvrcAJOOBFOit6hV1k+LViWcs2Tbmhv16SSpJrAWWsTr0SspU1FDPVIiDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLybLy6vpiCYFu1IqS/oJIJpPWttJnwlFt6MMt/Yvl0=;
 b=A35E35EY+dMtF8t2LhQmbw7saaqHJKzz21f1JtimjO3C+1Ue/TQuxtPpXmsI2j9DEnz9UKNB05kytGT6xghUQyivuNeVvp06qmd/6yMqReAcJdsg+rHpzGbjuerhpCpj820LGRWZqCZe0FLM4pHTi7bCpqNdbeMihxb0EpaBgYE=
Received: from PH7P220CA0097.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::15)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 20:04:18 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::34) by PH7P220CA0097.outlook.office365.com
 (2603:10b6:510:32d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 20:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 20:04:17 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 15:04:16 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net v2 0/2] pds_core: fix use-after-free on workqueue during remove
Date: Mon, 29 Jun 2026 20:03:56 +0000
Message-ID: <20260629200358.2626129-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f1bdc6-4976-4e61-a19a-08ded61999c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|11063799006|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	7N8v3T91rDn9Md3R77Hij39sZhxjXnjJUeJ6bNFVSTQ6M8q6EwsGWvejMWNiMhQssRt0jfO0UKkDTWzXBp/mSfq8Fw5R9VYpV3bs44gbRJh8DWzYzC0YpLFdv6+HU+CCGVHSmoGkKD91vP27y8zm/X7pPFBFihSKltUyge1UIeYe1Xg0zEshXFvssW6XruWm0hs/SfKHcduyKgoYYIZqeeT7d0rNRqRyxckMRzt3Vq4B6xxqt569BjqenN0SWx7uFxkYE6cRTVDzq7q0xEk1XjJ00Td7H0VdsoZdLX1CxlTcHLKdJYzHEXStaFdWzaGye2BBXhKnbebuT7rHMIf2HOyjB5SzU1l2yBA0eeVgcYcr2po5SvS1NONSBE2gAY7EMVV8ZX8PLUes+NNn0xau1vqCc5hZqrpoHjijqiQn+7btCxkn0F74UQxnOVzgJX217nd/bBwwXM7UFSUEfqnWoeh5S7zgyzup+0DRf7oda78WFSld+YDNM3gIhuQGciAIg12RK4/7LrlNfg9ugBeXBroO406H6HClLWq09U179fXsa144CtXH4EnS4aZhrIwPiHKGTtvR930YWexChnLTVLHnKZE6W5X0Oft115JokVsjrz0zZdUWd44GRpR7spfYrr2pwbQ5XwqvrhvZnXspUD1jNfhFe4iO4tlUbiMTtgNmiE4FYp6SYUPd/tvxydE+4PsFxEjnoWQA9VHuUpzk5g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(11063799006)(18002099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NyXMwzgMsguE/p+X7P1Dxz29rSrALlrauBPZyCzZ5+6Yxcb1e3gjdyHYUWEFPTvxqB4bYgWJa79Fyb8TN2bY80p+HYotWhZkDK3xSiyfdbTblrvxNm2UZwzc5yUTc5dFQzioBDb95zqm6VekoKqjQOBL+pZl6Ss4Ucx4vmyQYkFu3XloVN8OV6NiRPXY4t6NfvwMf8W4v0rZwwE77xbB/8HlSUx8ErgDK6PNNtKQnzRsviUrchIp8CojmEgY2DxG9F12qr8A8Y9LNvEa5JnQqrnTwTtz9xMLZP4j4ClFuudptyILOYhG9Hjnk9wnV6OCjQBhNohYPi3wLc1TsI5DOi6S/k7ja7Om3r9U0n3LQW3C2WqTyHFKeIo/pnKhnSNRPoR3s64pyUENbgEQ+yMaklZfEUkPHqFX3WOSxuNC1x0xw44QZCmk05QBdO4eGbee
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 20:04:17.5318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f1bdc6-4976-4e61-a19a-08ded61999c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302823-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:dkim,amd.com:mid,amd.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AE286DE8BA

This series fixes a use-after-free on the workqueue during driver remove.

Patch 1 fixes a pre-existing deadlock between the PCI reset worker and
pdsc_remove() that was identified during review of v1.

Patch 2 is the reworked UAF fix that moves destroy_workqueue() after
pdsc_teardown() and adds proper work synchronization.

v2:
- Fix deadlock between pci_reset_thread and remove (new patch 1/2)
  found by sashiko AI review of v1
- Rework UAF fix: move destroy_workqueue() after pdsc_teardown()
  instead of setting wq to NULL (addresses NULL deref found by sashiko)
- Add cancel_work_sync() after free_irq() to drain ISR-queued work
- Reorder adminqcq/notifyqcq freeing to avoid accessing freed notifyqcq

v1: https://lore.kernel.org/netdev/20260610025952.196470-1-nikhil.rao@amd.com/

Nikhil P. Rao (2):
  pds_core: fix deadlock between reset thread and remove
  pds_core: fix use-after-free on workqueue during remove

 drivers/net/ethernet/amd/pds_core/adminq.c | 15 +++++++++++----
 drivers/net/ethernet/amd/pds_core/core.c   | 21 ++++++++++++++-------
 drivers/net/ethernet/amd/pds_core/main.c   |  5 +++--
 3 files changed, 28 insertions(+), 13 deletions(-)

--
2.43.0


