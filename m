Return-Path: <netdev+bounces-98833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8AC8D293E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351801F25ABC
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FDFA41;
	Wed, 29 May 2024 00:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KWV/hbKt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B44C80
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941024; cv=fail; b=VApeNXBX4CyiIaa4fmeJ7Gq16/gc1P+y0wSxZSgMbIiicJX9ilIPiMZhBIXqwOhADWWPhJSRL7QH93CBfZqygI94g/kvbK0uZKac42gpF1ZHz0f4WJkfMUC1Y5maP60Dtd1eCilxdyF8Ge7a5fCQIHANgJ2Wm+FbjquTuM8LFP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941024; c=relaxed/simple;
	bh=7L6IGdA3A2llxPH6PdN9aie2NoakT4mH7mKgk1GiMzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAEGUKlgCRxdnU6VrQOhWue3Cz+NjVhkOtU8uGuBKYrCPZHgta7nXViOgxzBGoBiFlYDYkzPlAf1NcDFTJ4VRQHv/KLbkVgLLGtKPQ6rYTe2e9MyYVEPoHQQ0kHitNtYkNA2XRYVIVrBv+9HKOpoW+bGndEQbl5o534A/aafgQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KWV/hbKt; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+Cedrspy4j2iCo3BiZ9k2XujX1JG6tqRZhlCQtM+Bitq2dZIhd5eDgdlBG945yI1j9ZQ6vZx8CQMVVadEmjOKom5KpX6K18YAb00SNSiuJYFfgwMgJ9j7j2jhHjAHvlGv/wcJZ9KNQz5Ot9TAW3vyviVeL8wdkaNY41US79IwzK1aEaozRZj6RNXH0myXZPCdjXFwPuCXHUVpmRERZ3Fzmpn0gy+cZmwE7jVaTdrKC/z354HG9O7ak3avlKnzNfrtNvGcfTqZKYNd4OBnRmT5yHwOwoDRp6u1Mc5g+62bUKIh8fYD6QVJkdCVRFD1noepxRsZJc6ILh3nZ5KegN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zah4Ret+haBsyRggFp3EbGcJTqT5uYUwIt7Bj+3GH4Q=;
 b=GSgNU5OanRyMtatCdvXfOvTiq9HHUQY7Qv9XPsMgjbYVSMF2lYAQMLL3vnrj6xnb6OkAweCU2JOX13CXFeskkYRXlYBVsnAmiJyeaKRApgLPA7Xl40AAql4rARk4pP3vq5/jR0P6jUQ598eVqopXh+X0SGvaUSxfQcQNMIyEvmKXWc/PDipkVuH+ReN2ZSv4Q0KELUmCw+55QQDzGPdfexrEGHHxpHRI1qw/N0OvmdQKLvh0E2otEJzdRuGakg24X055P7sMMkfnoFhJTps91W3/OVhGGfeki+aETqS8FNeoL0BiCRkbO4eQK1B1+lIL+hOdXW64G3nVMJGP4kteYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zah4Ret+haBsyRggFp3EbGcJTqT5uYUwIt7Bj+3GH4Q=;
 b=KWV/hbKtL/Ah+rrPjHA5SB9DTYcj2mKfh6NkGM4RUqlEIzrq+Z0zWHLR8tR4XKFTLTtZEho7PsNKfIqIuZlfU9BPeaALZjo5gpQ1EzCDqTfLKwWYrvClTJM6AAjKoDEBrZO1MhWfkDodBfJ2fV8cnQE9Uk5ZNY4TIeKFKFNUvaA=
Received: from MW4PR04CA0357.namprd04.prod.outlook.com (2603:10b6:303:8a::32)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 00:03:38 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::cf) by MW4PR04CA0357.outlook.office365.com
 (2603:10b6:303:8a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 00:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 00:03:37 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 19:03:32 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next v2 7/7] ionic: fix up ionic_if.h kernel-doc issues
Date: Tue, 28 May 2024 17:02:59 -0700
Message-ID: <20240529000259.25775-8-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240529000259.25775-1-shannon.nelson@amd.com>
References: <20240529000259.25775-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d14850-f651-4a8f-6de2-08dc7f72ca76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9liEAt8ixMXTQtTuQWuqkrGh3Q5cITtMeTnkPFmtwWdBPWRJ3t71CzpaJ2bQ?=
 =?us-ascii?Q?zuKJ/zgoaZWLaSeMqF3VGRGkIzzG0R/cjiWS73DO/E5CmxqAHvz//Qt+wHqN?=
 =?us-ascii?Q?BKgcCoxvCmrqGN5qjcYBAuCFeU17i0d+nUXJtfZ4fbZVEUa9rXhQHx6fQRKa?=
 =?us-ascii?Q?lmEky83DhtMYxhle05/ALXm0Dov7NhcohSyUxGJLI6iVW41v02isw3sHa1N8?=
 =?us-ascii?Q?WELFro+QLv1WcNIwA91TeLKgwdh2facO7zW9uRpAEoPLuI0CKHmOLSaHPmgg?=
 =?us-ascii?Q?B9qi1vMvD7kPTQdcFri9u+fPwrnBnYiMm3RW4f+ROkjLjsKYMVIKZvwFpjn2?=
 =?us-ascii?Q?snCJeqy9D3AKsBezZ2nRG4CtPuxvKYoYc2nK3duVE+dVAa0X0kd4cOxyqzO7?=
 =?us-ascii?Q?ARK/Clm/57eOlnwkCrmF9xNiIOCs5YAvMsdrRmudyOsAEdtmqfFKISXuIE/V?=
 =?us-ascii?Q?Hqjs3KIYQ/7l7oPZhUju5RKRGZwUucdnJI5tUCF/Kv4pk+wfIJtcInY5F2OC?=
 =?us-ascii?Q?1q5urLokddZ/ukASoSd7pqY6gboq/f4dYzbsTQC7o/bMCptG4uc8WZQJuehi?=
 =?us-ascii?Q?ZzKnZpDttve9H/X2yMzT/bQt+u3wT4CSUw1gViWTowerHUmkZ29VAR9N+kfr?=
 =?us-ascii?Q?amFYM3nATyyRG0szAF6mMNCps23uGI3mlbWnmd+0D214iGUJMe1Z8VCUqKlB?=
 =?us-ascii?Q?lj6rBWbm3+g+3OS+nlFBklyR94D1zEgasPM6DHnuz2Pc1u/fiEBNP1YVhGOT?=
 =?us-ascii?Q?sJHmkU88MGbI+t6bJCFAa0mqUPeoER1RW6DDXYveF6pSYzqq5LXoAr2yXOYS?=
 =?us-ascii?Q?/WV3WkDRNIWyalyxFSNckX0BNsNYKANqkfb2kGtFoYPFbmKC8kypTw0iabMK?=
 =?us-ascii?Q?cucLxPYMt8KN3EHL7eTzUWD51p3d7u6K5dwjJdDdDTA1l+JVm/V8bWojV8SR?=
 =?us-ascii?Q?moEo207iqL5VamP3MacMgYe8HGT3xrXhlQwUca4zNozDnK4gUJHRzDx6WCk2?=
 =?us-ascii?Q?N2XAxOX9MDTrxVe1DD0TH9mBvp4JACK55XHZbPuvhjLH0arl4r1ofnNc5TG4?=
 =?us-ascii?Q?xxpUZ0Kng03DfcSrlDgeUiQp8a3Mw12Hzag3r68gw5s/IoPpTPBA7iW7dehp?=
 =?us-ascii?Q?IMSr4vhCHCdTXwsSxfd7Gjm+L5ZkNofimJMhmeE62udl3eUNuoUdIHeltmK6?=
 =?us-ascii?Q?J1rhSOkJpG/PLPUHXb5b+zbV3NZ8Fxb84L2taCpivdZehsIr9vvPEyh6fThZ?=
 =?us-ascii?Q?P27tCRfzC8h6se8cLeW7B4tTL1/dP/0zaFh79r5az1QOrPdIT/U1qNDtzVF9?=
 =?us-ascii?Q?MChGmuWgkKHycRnemNlGnL4hR9jxrHfgR6fxBqrcFBfkJRSYrrtoYQb1rbPY?=
 =?us-ascii?Q?WEeGUyg/hdGUlpRYMMrhRbZERkY7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 00:03:37.8119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d14850-f651-4a8f-6de2-08dc7f72ca76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148

All the changes here are whitespace and comments, no code
or definitions changed.  Not all issues were addressed, but
it is much better than it was.  Mostly fixed was a lot
of "Excess union member" and ''rsvd' not described' warnings.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_if.h    | 237 +++++++++++++-----
 1 file changed, 181 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 9a1825edf0d0..9c85c0706c6e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -71,7 +71,7 @@ enum ionic_cmd_opcode {
 	IONIC_CMD_FW_CONTROL_V1		        = 255,
 };
 
-/**
+/*
  * enum ionic_status_code - Device command return codes
  */
 enum ionic_status_code {
@@ -112,6 +112,7 @@ enum ionic_notifyq_opcode {
 /**
  * struct ionic_admin_cmd - General admin command format
  * @opcode:     Opcode for the command
+ * @rsvd:       reserved byte(s)
  * @lif_index:  LIF index
  * @cmd_data:   Opcode-specific command bytes
  */
@@ -125,6 +126,7 @@ struct ionic_admin_cmd {
 /**
  * struct ionic_admin_comp - General admin command completion format
  * @status:     Status of the command (enum ionic_status_code)
+ * @rsvd:       reserved byte(s)
  * @comp_index: Index in the descriptor ring for which this is the completion
  * @cmd_data:   Command-specific bytes
  * @color:      Color bit (Always 0 for commands issued to the
@@ -147,6 +149,7 @@ static inline u8 color_match(u8 color, u8 done_color)
 /**
  * struct ionic_nop_cmd - NOP command
  * @opcode: opcode
+ * @rsvd:   reserved byte(s)
  */
 struct ionic_nop_cmd {
 	u8 opcode;
@@ -156,6 +159,7 @@ struct ionic_nop_cmd {
 /**
  * struct ionic_nop_comp - NOP command completion
  * @status: Status of the command (enum ionic_status_code)
+ * @rsvd:   reserved byte(s)
  */
 struct ionic_nop_comp {
 	u8 status;
@@ -166,6 +170,7 @@ struct ionic_nop_comp {
  * struct ionic_dev_init_cmd - Device init command
  * @opcode:    opcode
  * @type:      Device type
+ * @rsvd:      reserved byte(s)
  */
 struct ionic_dev_init_cmd {
 	u8     opcode;
@@ -176,6 +181,7 @@ struct ionic_dev_init_cmd {
 /**
  * struct ionic_dev_init_comp - Device init command completion
  * @status: Status of the command (enum ionic_status_code)
+ * @rsvd:   reserved byte(s)
  */
 struct ionic_dev_init_comp {
 	u8 status;
@@ -185,6 +191,7 @@ struct ionic_dev_init_comp {
 /**
  * struct ionic_dev_reset_cmd - Device reset command
  * @opcode: opcode
+ * @rsvd:   reserved byte(s)
  */
 struct ionic_dev_reset_cmd {
 	u8 opcode;
@@ -194,6 +201,7 @@ struct ionic_dev_reset_cmd {
 /**
  * struct ionic_dev_reset_comp - Reset command completion
  * @status: Status of the command (enum ionic_status_code)
+ * @rsvd:   reserved byte(s)
  */
 struct ionic_dev_reset_comp {
 	u8 status;
@@ -207,6 +215,7 @@ struct ionic_dev_reset_comp {
  * struct ionic_dev_identify_cmd - Driver/device identify command
  * @opcode:  opcode
  * @ver:     Highest version of identify supported by driver
+ * @rsvd:    reserved byte(s)
  */
 struct ionic_dev_identify_cmd {
 	u8 opcode;
@@ -218,6 +227,7 @@ struct ionic_dev_identify_cmd {
  * struct ionic_dev_identify_comp - Driver/device identify command completion
  * @status: Status of the command (enum ionic_status_code)
  * @ver:    Version of identify returned by device
+ * @rsvd:   reserved byte(s)
  */
 struct ionic_dev_identify_comp {
 	u8 status;
@@ -242,6 +252,7 @@ enum ionic_os_type {
  * @kernel_ver:       Kernel version, numeric format
  * @kernel_ver_str:   Kernel version, string format
  * @driver_ver_str:   Driver version, string format
+ * @words:            word access to struct contents
  */
 union ionic_drv_identity {
 	struct {
@@ -267,7 +278,9 @@ enum ionic_dev_capability {
  * union ionic_dev_identity - device identity information
  * @version:          Version of device identify
  * @type:             Identify type (0 for now)
+ * @rsvd:             reserved byte(s)
  * @nports:           Number of ports provisioned
+ * @rsvd2:            reserved byte(s)
  * @nlifs:            Number of LIFs provisioned
  * @nintrs:           Number of interrupts provisioned
  * @ndbpgs_per_lif:   Number of doorbell pages per LIF
@@ -284,6 +297,7 @@ enum ionic_dev_capability {
  * @hwstamp_mult:     Hardware tick to nanosecond multiplier.
  * @hwstamp_shift:    Hardware tick to nanosecond divisor (power of two).
  * @capabilities:     Device capabilities
+ * @words:            word access to struct contents
  */
 union ionic_dev_identity {
 	struct {
@@ -317,6 +331,7 @@ enum ionic_lif_type {
  * @opcode:  opcode
  * @type:    LIF type (enum ionic_lif_type)
  * @ver:     Version of identify returned by device
+ * @rsvd:    reserved byte(s)
  */
 struct ionic_lif_identify_cmd {
 	u8 opcode;
@@ -329,6 +344,7 @@ struct ionic_lif_identify_cmd {
  * struct ionic_lif_identify_comp - LIF identify command completion
  * @status:  Status of the command (enum ionic_status_code)
  * @ver:     Version of identify returned by device
+ * @rsvd2:   reserved byte(s)
  */
 struct ionic_lif_identify_comp {
 	u8 status;
@@ -416,7 +432,7 @@ enum ionic_txq_feature {
 };
 
 /**
- * struct ionic_hwstamp_bits - Hardware timestamp decoding bits
+ * enum ionic_hwstamp_bits - Hardware timestamp decoding bits
  * @IONIC_HWSTAMP_INVALID:          Invalid hardware timestamp value
  * @IONIC_HWSTAMP_CQ_NEGOFFSET:     Timestamp field negative offset
  *                                  from the base cq descriptor.
@@ -429,6 +445,7 @@ enum ionic_hwstamp_bits {
 /**
  * struct ionic_lif_logical_qtype - Descriptor of logical to HW queue type
  * @qtype:          Hardware Queue Type
+ * @rsvd:           reserved byte(s)
  * @qid_count:      Number of Queue IDs of the logical type
  * @qid_base:       Minimum Queue ID of the logical type
  */
@@ -454,12 +471,14 @@ enum ionic_lif_state {
 /**
  * union ionic_lif_config - LIF configuration
  * @state:          LIF state (enum ionic_lif_state)
+ * @rsvd:           reserved byte(s)
  * @name:           LIF name
  * @mtu:            MTU
  * @mac:            Station MAC address
  * @vlan:           Default Vlan ID
  * @features:       Features (enum ionic_eth_hw_features)
  * @queue_count:    Queue counts per queue-type
+ * @words:          word access to struct contents
  */
 union ionic_lif_config {
 	struct {
@@ -481,33 +500,39 @@ union ionic_lif_config {
  * @capabilities:        LIF capabilities
  *
  * @eth:                    Ethernet identify structure
- *     @version:            Ethernet identify structure version
- *     @max_ucast_filters:  Number of perfect unicast addresses supported
- *     @max_mcast_filters:  Number of perfect multicast addresses supported
- *     @min_frame_size:     Minimum size of frames to be sent
- *     @max_frame_size:     Maximum size of frames to be sent
- *     @hwstamp_tx_modes:   Bitmask of BIT_ULL(enum ionic_txstamp_mode)
- *     @hwstamp_rx_filters: Bitmask of enum ionic_pkt_class
- *     @config:             LIF config struct with features, mtu, mac, q counts
+ *	@eth.version:            Ethernet identify structure version
+ *	@eth.rsvd:               reserved byte(s)
+ *	@eth.max_ucast_filters:  Number of perfect unicast addresses supported
+ *	@eth.max_mcast_filters:  Number of perfect multicast addresses supported
+ *	@eth.min_frame_size:     Minimum size of frames to be sent
+ *	@eth.max_frame_size:     Maximum size of frames to be sent
+ *	@eth.rsvd2:              reserved byte(s)
+ *	@eth.hwstamp_tx_modes:   Bitmask of BIT_ULL(enum ionic_txstamp_mode)
+ *	@eth.hwstamp_rx_filters: Bitmask of enum ionic_pkt_class
+ *	@eth.rsvd3:              reserved byte(s)
+ *	@eth.config:             LIF config struct with features, mtu, mac, q counts
  *
  * @rdma:                RDMA identify structure
- *     @version:         RDMA version of opcodes and queue descriptors
- *     @qp_opcodes:      Number of RDMA queue pair opcodes supported
- *     @admin_opcodes:   Number of RDMA admin opcodes supported
- *     @npts_per_lif:    Page table size per LIF
- *     @nmrs_per_lif:    Number of memory regions per LIF
- *     @nahs_per_lif:    Number of address handles per LIF
- *     @max_stride:      Max work request stride
- *     @cl_stride:       Cache line stride
- *     @pte_stride:      Page table entry stride
- *     @rrq_stride:      Remote RQ work request stride
- *     @rsq_stride:      Remote SQ work request stride
- *     @dcqcn_profiles:  Number of DCQCN profiles
- *     @aq_qtype:        RDMA Admin Qtype
- *     @sq_qtype:        RDMA Send Qtype
- *     @rq_qtype:        RDMA Receive Qtype
- *     @cq_qtype:        RDMA Completion Qtype
- *     @eq_qtype:        RDMA Event Qtype
+ *	@rdma.version:         RDMA version of opcodes and queue descriptors
+ *	@rdma.qp_opcodes:      Number of RDMA queue pair opcodes supported
+ *	@rdma.admin_opcodes:   Number of RDMA admin opcodes supported
+ *	@rdma.rsvd:            reserved byte(s)
+ *	@rdma.npts_per_lif:    Page table size per LIF
+ *	@rdma.nmrs_per_lif:    Number of memory regions per LIF
+ *	@rdma.nahs_per_lif:    Number of address handles per LIF
+ *	@rdma.max_stride:      Max work request stride
+ *	@rdma.cl_stride:       Cache line stride
+ *	@rdma.pte_stride:      Page table entry stride
+ *	@rdma.rrq_stride:      Remote RQ work request stride
+ *	@rdma.rsq_stride:      Remote SQ work request stride
+ *	@rdma.dcqcn_profiles:  Number of DCQCN profiles
+ *	@rdma.rsvd_dimensions: reserved byte(s)
+ *	@rdma.aq_qtype:        RDMA Admin Qtype
+ *	@rdma.sq_qtype:        RDMA Send Qtype
+ *	@rdma.rq_qtype:        RDMA Receive Qtype
+ *	@rdma.cq_qtype:        RDMA Completion Qtype
+ *	@rdma.eq_qtype:        RDMA Event Qtype
+ * @words:               word access to struct contents
  */
 union ionic_lif_identity {
 	struct {
@@ -558,7 +583,9 @@ union ionic_lif_identity {
  * @opcode:       Opcode
  * @type:         LIF type (enum ionic_lif_type)
  * @index:        LIF index
+ * @rsvd:         reserved byte(s)
  * @info_pa:      Destination address for LIF info (struct ionic_lif_info)
+ * @rsvd2:        reserved byte(s)
  */
 struct ionic_lif_init_cmd {
 	u8     opcode;
@@ -572,7 +599,9 @@ struct ionic_lif_init_cmd {
 /**
  * struct ionic_lif_init_comp - LIF init command completion
  * @status:	Status of the command (enum ionic_status_code)
+ * @rsvd:	reserved byte(s)
  * @hw_index:	Hardware index of the initialized LIF
+ * @rsvd2:	reserved byte(s)
  */
 struct ionic_lif_init_comp {
 	u8 status;
@@ -584,9 +613,11 @@ struct ionic_lif_init_comp {
 /**
  * struct ionic_q_identify_cmd - queue identify command
  * @opcode:     opcode
+ * @rsvd:       reserved byte(s)
  * @lif_type:   LIF type (enum ionic_lif_type)
  * @type:       Logical queue type (enum ionic_logical_qtype)
  * @ver:        Highest queue type version that the driver supports
+ * @rsvd2:      reserved byte(s)
  */
 struct ionic_q_identify_cmd {
 	u8     opcode;
@@ -600,8 +631,10 @@ struct ionic_q_identify_cmd {
 /**
  * struct ionic_q_identify_comp - queue identify command completion
  * @status:     Status of the command (enum ionic_status_code)
+ * @rsvd:       reserved byte(s)
  * @comp_index: Index in the descriptor ring for which this is the completion
  * @ver:        Queue type version that can be used with FW
+ * @rsvd2:      reserved byte(s)
  */
 struct ionic_q_identify_comp {
 	u8     status;
@@ -615,12 +648,14 @@ struct ionic_q_identify_comp {
  * union ionic_q_identity - queue identity information
  *     @version:        Queue type version that can be used with FW
  *     @supported:      Bitfield of queue versions, first bit = ver 0
+ *     @rsvd:           reserved byte(s)
  *     @features:       Queue features (enum ionic_q_feature, etc)
  *     @desc_sz:        Descriptor size
  *     @comp_sz:        Completion descriptor size
  *     @sg_desc_sz:     Scatter/Gather descriptor size
  *     @max_sg_elems:   Maximum number of Scatter/Gather elements
  *     @sg_desc_stride: Number of Scatter/Gather elements per descriptor
+ *     @words:          word access to struct contents
  */
 union ionic_q_identity {
 	struct {
@@ -640,8 +675,10 @@ union ionic_q_identity {
 /**
  * struct ionic_q_init_cmd - Queue init command
  * @opcode:       opcode
+ * @rsvd:         reserved byte(s)
  * @type:         Logical queue type
  * @ver:          Queue type version
+ * @rsvd1:        reserved byte(s)
  * @lif_index:    LIF index
  * @index:        (LIF, qtype) relative admin queue index
  * @intr_index:   Interrupt control register index, or Event queue index
@@ -667,6 +704,7 @@ union ionic_q_identity {
  * @ring_base:    Queue ring base address
  * @cq_ring_base: Completion queue ring base address
  * @sg_ring_base: Scatter/Gather ring base address
+ * @rsvd2:        reserved byte(s)
  * @features:     Mask of queue features to enable, if not in the flags above.
  */
 struct ionic_q_init_cmd {
@@ -698,9 +736,11 @@ struct ionic_q_init_cmd {
 /**
  * struct ionic_q_init_comp - Queue init command completion
  * @status:     Status of the command (enum ionic_status_code)
+ * @rsvd:       reserved byte(s)
  * @comp_index: Index in the descriptor ring for which this is the completion
  * @hw_index:   Hardware Queue ID
  * @hw_type:    Hardware Queue type
+ * @rsvd2:      reserved byte(s)
  * @color:      Color
  */
 struct ionic_q_init_comp {
@@ -800,7 +840,7 @@ enum ionic_txq_desc_opcode {
  *                      will set CWR flag in the first segment if
  *                      CWR is set in the template header, and
  *                      clear CWR in remaining segments.
- * @flags:
+ *    flags:
  *                vlan:
  *                    Insert an L2 VLAN header using @vlan_tci
  *                encap:
@@ -813,13 +853,14 @@ enum ionic_txq_desc_opcode {
  *                    TSO start
  *                tso_eot:
  *                    TSO end
- * @num_sg_elems: Number of scatter-gather elements in SG
+ *    num_sg_elems: Number of scatter-gather elements in SG
  *                descriptor
- * @addr:         First data buffer's DMA address
+ *    addr:       First data buffer's DMA address
  *                (Subsequent data buffers are on txq_sg_desc)
  * @len:          First data buffer's length, in bytes
  * @vlan_tci:     VLAN tag to insert in the packet (if requested
  *                by @V-bit).  Includes .1p and .1q tags
+ * @hword0:       half word padding
  * @hdr_len:      Length of packet headers, including
  *                encapsulating outer header, if applicable
  *                Valid for opcodes IONIC_TXQ_DESC_OPCODE_CALC_CSUM and
@@ -830,10 +871,12 @@ enum ionic_txq_desc_opcode {
  *                IONIC_TXQ_DESC_OPCODE_TSO, @hdr_len is up to
  *                inner-most L4 payload, so inclusive of
  *                inner-most L4 header.
+ * @hword1:       half word padding
  * @mss:          Desired MSS value for TSO; only applicable for
  *                IONIC_TXQ_DESC_OPCODE_TSO
  * @csum_start:   Offset from packet to first byte checked in L4 checksum
  * @csum_offset:  Offset from csum_start to L4 checksum field
+ * @hword2:       half word padding
  */
 struct ionic_txq_desc {
 	__le64  cmd;
@@ -901,6 +944,7 @@ static inline void decode_txq_desc_cmd(u64 cmd, u8 *opcode, u8 *flags,
  * struct ionic_txq_sg_elem - Transmit scatter-gather (SG) descriptor element
  * @addr:      DMA address of SG element data buffer
  * @len:       Length of SG element data buffer, in bytes
+ * @rsvd:      reserved byte(s)
  */
 struct ionic_txq_sg_elem {
 	__le64 addr;
@@ -927,7 +971,9 @@ struct ionic_txq_sg_desc_v1 {
 /**
  * struct ionic_txq_comp - Ethernet transmit queue completion descriptor
  * @status:     Status of the command (enum ionic_status_code)
+ * @rsvd:       reserved byte(s)
  * @comp_index: Index in the descriptor ring for which this is the completion
+ * @rsvd2:      reserved byte(s)
  * @color:      Color bit
  */
 struct ionic_txq_comp {
@@ -953,6 +999,7 @@ enum ionic_rxq_desc_opcode {
  *                      receive, including actual bytes received,
  *                      are recorded in Rx completion descriptor.
  *
+ * @rsvd:         reserved byte(s)
  * @len:          Data buffer's length, in bytes
  * @addr:         Data buffer's DMA address
  */
@@ -967,6 +1014,7 @@ struct ionic_rxq_desc {
  * struct ionic_rxq_sg_elem - Receive scatter-gather (SG) descriptor element
  * @addr:      DMA address of SG element data buffer
  * @len:       Length of SG element data buffer, in bytes
+ * @rsvd:      reserved byte(s)
  */
 struct ionic_rxq_sg_elem {
 	__le64 addr;
@@ -1170,6 +1218,7 @@ enum ionic_pkt_class {
  * @lif_index:  LIF index
  * @index:      Queue index
  * @oper:       Operation (enum ionic_q_control_oper)
+ * @rsvd:       reserved byte(s)
  */
 struct ionic_q_control_cmd {
 	u8     opcode;
@@ -1182,7 +1231,7 @@ struct ionic_q_control_cmd {
 
 typedef struct ionic_admin_comp ionic_q_control_comp;
 
-enum q_control_oper {
+enum ionic_q_control_oper {
 	IONIC_Q_DISABLE		= 0,
 	IONIC_Q_ENABLE		= 1,
 	IONIC_Q_HANG_RESET	= 2,
@@ -1216,7 +1265,7 @@ enum ionic_xcvr_state {
 	IONIC_XCVR_STATE_SPROM_READ_ERR	 = 4,
 };
 
-/**
+/*
  * enum ionic_xcvr_pid - Supported link modes
  */
 enum ionic_xcvr_pid {
@@ -1351,6 +1400,7 @@ struct ionic_xcvr_status {
  * @fec_type:           fec type (enum ionic_port_fec_type)
  * @pause_type:         pause type (enum ionic_port_pause_type)
  * @loopback_mode:      loopback mode (enum ionic_port_loopback_mode)
+ * @words:              word access to struct contents
  */
 union ionic_port_config {
 	struct {
@@ -1382,6 +1432,7 @@ union ionic_port_config {
  * @speed:              link speed (in Mbps)
  * @link_down_count:    number of times link went from up to down
  * @fec_type:           fec type (enum ionic_port_fec_type)
+ * @rsvd:               reserved byte(s)
  * @xcvr:               transceiver status
  */
 struct ionic_port_status {
@@ -1399,6 +1450,7 @@ struct ionic_port_status {
  * @opcode:     opcode
  * @index:      port index
  * @ver:        Highest version of identify supported by driver
+ * @rsvd:       reserved byte(s)
  */
 struct ionic_port_identify_cmd {
 	u8 opcode;
@@ -1411,6 +1463,7 @@ struct ionic_port_identify_cmd {
  * struct ionic_port_identify_comp - Port identify command completion
  * @status: Status of the command (enum ionic_status_code)
  * @ver:    Version of identify returned by device
+ * @rsvd:   reserved byte(s)
  */
 struct ionic_port_identify_comp {
 	u8 status;
@@ -1422,7 +1475,9 @@ struct ionic_port_identify_comp {
  * struct ionic_port_init_cmd - Port initialization command
  * @opcode:     opcode
  * @index:      port index
+ * @rsvd:       reserved byte(s)
  * @info_pa:    destination address for port info (struct ionic_port_info)
+ * @rsvd2:      reserved byte(s)
  */
 struct ionic_port_init_cmd {
 	u8     opcode;
@@ -1435,6 +1490,7 @@ struct ionic_port_init_cmd {
 /**
  * struct ionic_port_init_comp - Port initialization command completion
  * @status: Status of the command (enum ionic_status_code)
+ * @rsvd:   reserved byte(s)
  */
 struct ionic_port_init_comp {
 	u8 status;
@@ -1445,6 +1501,7 @@ struct ionic_port_init_comp {
  * struct ionic_port_reset_cmd - Port reset command
  * @opcode:     opcode
  * @index:      port index
+ * @rsvd:       reserved byte(s)
  */
 struct ionic_port_reset_cmd {
 	u8 opcode;
@@ -1455,6 +1512,7 @@ struct ionic_port_reset_cmd {
 /**
  * struct ionic_port_reset_comp - Port reset command completion
  * @status: Status of the command (enum ionic_status_code)
+ * @rsvd:   reserved byte(s)
  */
 struct ionic_port_reset_comp {
 	u8 status;
@@ -1510,6 +1568,7 @@ enum ionic_port_attr {
  * @opcode:         Opcode
  * @index:          Port index
  * @attr:           Attribute type (enum ionic_port_attr)
+ * @rsvd:           reserved byte(s)
  * @state:          Port state
  * @speed:          Port speed
  * @mtu:            Port MTU
@@ -1518,6 +1577,7 @@ enum ionic_port_attr {
  * @pause_type:     Port pause type setting
  * @loopback_mode:  Port loopback mode
  * @stats_ctl:      Port stats setting
+ * @rsvd2:          reserved byte(s)
  */
 struct ionic_port_setattr_cmd {
 	u8     opcode;
@@ -1540,6 +1600,7 @@ struct ionic_port_setattr_cmd {
 /**
  * struct ionic_port_setattr_comp - Port set attr command completion
  * @status:     Status of the command (enum ionic_status_code)
+ * @rsvd:       reserved byte(s)
  * @color:      Color bit
  */
 struct ionic_port_setattr_comp {
@@ -1553,6 +1614,7 @@ struct ionic_port_setattr_comp {
  * @opcode:     Opcode
  * @index:      port index
  * @attr:       Attribute type (enum ionic_port_attr)
+ * @rsvd:       reserved byte(s)
  */
 struct ionic_port_getattr_cmd {
 	u8     opcode;
@@ -1564,6 +1626,7 @@ struct ionic_port_getattr_cmd {
 /**
  * struct ionic_port_getattr_comp - Port get attr command completion
  * @status:         Status of the command (enum ionic_status_code)
+ * @rsvd:           reserved byte(s)
  * @state:          Port state
  * @speed:          Port speed
  * @mtu:            Port MTU
@@ -1571,6 +1634,7 @@ struct ionic_port_getattr_cmd {
  * @fec_type:       Port FEC type setting
  * @pause_type:     Port pause type setting
  * @loopback_mode:  Port loopback mode
+ * @rsvd2:          reserved byte(s)
  * @color:          Color bit
  */
 struct ionic_port_getattr_comp {
@@ -1593,9 +1657,11 @@ struct ionic_port_getattr_comp {
  * struct ionic_lif_status - LIF status register
  * @eid:             most recent NotifyQ event id
  * @port_num:        port the LIF is connected to
+ * @rsvd:            reserved byte(s)
  * @link_status:     port status (enum ionic_port_oper_status)
  * @link_speed:      speed of link in Mbps
  * @link_down_count: number of times link went from up to down
+ * @rsvd2:           reserved byte(s)
  */
 struct ionic_lif_status {
 	__le64 eid;
@@ -1610,7 +1676,9 @@ struct ionic_lif_status {
 /**
  * struct ionic_lif_reset_cmd - LIF reset command
  * @opcode:    opcode
+ * @rsvd:      reserved byte(s)
  * @index:     LIF index
+ * @rsvd2:     reserved byte(s)
  */
 struct ionic_lif_reset_cmd {
 	u8     opcode;
@@ -1643,9 +1711,11 @@ enum ionic_dev_attr {
  * struct ionic_dev_setattr_cmd - Set Device attributes on the NIC
  * @opcode:     Opcode
  * @attr:       Attribute type (enum ionic_dev_attr)
+ * @rsvd:       reserved byte(s)
  * @state:      Device state (enum ionic_dev_state)
  * @name:       The bus info, e.g. PCI slot-device-function, 0 terminated
  * @features:   Device features
+ * @rsvd2:      reserved byte(s)
  */
 struct ionic_dev_setattr_cmd {
 	u8     opcode;
@@ -1662,7 +1732,9 @@ struct ionic_dev_setattr_cmd {
 /**
  * struct ionic_dev_setattr_comp - Device set attr command completion
  * @status:     Status of the command (enum ionic_status_code)
+ * @rsvd:       reserved byte(s)
  * @features:   Device features
+ * @rsvd2:      reserved byte(s)
  * @color:      Color bit
  */
 struct ionic_dev_setattr_comp {
@@ -1679,6 +1751,7 @@ struct ionic_dev_setattr_comp {
  * struct ionic_dev_getattr_cmd - Get Device attributes from the NIC
  * @opcode:     opcode
  * @attr:       Attribute type (enum ionic_dev_attr)
+ * @rsvd:       reserved byte(s)
  */
 struct ionic_dev_getattr_cmd {
 	u8     opcode;
@@ -1687,9 +1760,11 @@ struct ionic_dev_getattr_cmd {
 };
 
 /**
- * struct ionic_dev_setattr_comp - Device set attr command completion
+ * struct ionic_dev_getattr_comp - Device set attr command completion
  * @status:     Status of the command (enum ionic_status_code)
+ * @rsvd:       reserved byte(s)
  * @features:   Device features
+ * @rsvd2:      reserved byte(s)
  * @color:      Color bit
  */
 struct ionic_dev_getattr_comp {
@@ -1702,7 +1777,7 @@ struct ionic_dev_getattr_comp {
 	u8     color;
 };
 
-/**
+/*
  * RSS parameters
  */
 #define IONIC_RSS_HASH_KEY_SIZE		40
@@ -1726,6 +1801,7 @@ enum ionic_rss_hash_types {
  * @IONIC_LIF_ATTR_RSS:         LIF RSS attribute
  * @IONIC_LIF_ATTR_STATS_CTRL:  LIF statistics control attribute
  * @IONIC_LIF_ATTR_TXSTAMP:     LIF TX timestamping mode
+ * @IONIC_LIF_ATTR_MAX:         maximum attribute value
  */
 enum ionic_lif_attr {
 	IONIC_LIF_ATTR_STATE        = 0,
@@ -1736,6 +1812,7 @@ enum ionic_lif_attr {
 	IONIC_LIF_ATTR_RSS          = 5,
 	IONIC_LIF_ATTR_STATS_CTRL   = 6,
 	IONIC_LIF_ATTR_TXSTAMP      = 7,
+	IONIC_LIF_ATTR_MAX          = 255,
 };
 
 /**
@@ -1749,11 +1826,13 @@ enum ionic_lif_attr {
  * @mac:        Station mac
  * @features:   Features (enum ionic_eth_hw_features)
  * @rss:        RSS properties
- *              @types:     The hash types to enable (see rss_hash_types)
- *              @key:       The hash secret key
- *              @addr:      Address for the indirection table shared memory
+ *	@rss.types:     The hash types to enable (see rss_hash_types)
+ *	@rss.key:       The hash secret key
+ *	@rss.rsvd:      reserved byte(s)
+ *	@rss.addr:      Address for the indirection table shared memory
  * @stats_ctl:  stats control commands (enum ionic_stats_ctl_cmd)
- * @txstamp:    TX Timestamping Mode (enum ionic_txstamp_mode)
+ * @txstamp_mode:    TX Timestamping Mode (enum ionic_txstamp_mode)
+ * @rsvd:        reserved byte(s)
  */
 struct ionic_lif_setattr_cmd {
 	u8     opcode;
@@ -1772,7 +1851,7 @@ struct ionic_lif_setattr_cmd {
 			__le64 addr;
 		} rss;
 		u8      stats_ctl;
-		__le16 txstamp_mode;
+		__le16  txstamp_mode;
 		u8      rsvd[60];
 	} __packed;
 };
@@ -1780,8 +1859,10 @@ struct ionic_lif_setattr_cmd {
 /**
  * struct ionic_lif_setattr_comp - LIF set attr command completion
  * @status:     Status of the command (enum ionic_status_code)
+ * @rsvd:       reserved byte(s)
  * @comp_index: Index in the descriptor ring for which this is the completion
  * @features:   features (enum ionic_eth_hw_features)
+ * @rsvd2:      reserved byte(s)
  * @color:      Color bit
  */
 struct ionic_lif_setattr_comp {
@@ -1800,6 +1881,7 @@ struct ionic_lif_setattr_comp {
  * @opcode:     Opcode
  * @attr:       Attribute type (enum ionic_lif_attr)
  * @index:      LIF index
+ * @rsvd:       reserved byte(s)
  */
 struct ionic_lif_getattr_cmd {
 	u8     opcode;
@@ -1811,13 +1893,14 @@ struct ionic_lif_getattr_cmd {
 /**
  * struct ionic_lif_getattr_comp - LIF get attr command completion
  * @status:     Status of the command (enum ionic_status_code)
+ * @rsvd:       reserved byte(s)
  * @comp_index: Index in the descriptor ring for which this is the completion
  * @state:      LIF state (enum ionic_lif_state)
- * @name:       The netdev name string, 0 terminated
  * @mtu:        Mtu
  * @mac:        Station mac
  * @features:   Features (enum ionic_eth_hw_features)
- * @txstamp:    TX Timestamping Mode (enum ionic_txstamp_mode)
+ * @txstamp_mode:    TX Timestamping Mode (enum ionic_txstamp_mode)
+ * @rsvd2:      reserved byte(s)
  * @color:      Color bit
  */
 struct ionic_lif_getattr_comp {
@@ -1838,12 +1921,15 @@ struct ionic_lif_getattr_comp {
 /**
  * struct ionic_lif_setphc_cmd - Set LIF PTP Hardware Clock
  * @opcode:     Opcode
+ * @rsvd1:      reserved byte(s)
  * @lif_index:  LIF index
+ * @rsvd2:      reserved byte(s)
  * @tick:       Hardware stamp tick of an instant in time.
  * @nsec:       Nanosecond stamp of the same instant.
  * @frac:       Fractional nanoseconds at the same instant.
  * @mult:       Cycle to nanosecond multiplier.
  * @shift:      Cycle to nanosecond divisor (power of two).
+ * @rsvd3:      reserved byte(s)
  */
 struct ionic_lif_setphc_cmd {
 	u8	opcode;
@@ -1870,6 +1956,7 @@ enum ionic_rx_mode {
 /**
  * struct ionic_rx_mode_set_cmd - Set LIF's Rx mode command
  * @opcode:     opcode
+ * @rsvd:       reserved byte(s)
  * @lif_index:  LIF index
  * @rx_mode:    Rx mode flags:
  *                  IONIC_RX_MODE_F_UNICAST: Accept known unicast packets
@@ -1878,6 +1965,7 @@ enum ionic_rx_mode {
  *                  IONIC_RX_MODE_F_PROMISC: Accept any packets
  *                  IONIC_RX_MODE_F_ALLMULTI: Accept any multicast packets
  *                  IONIC_RX_MODE_F_RDMA_SNIFFER: Sniff RDMA packets
+ * @rsvd2:      reserved byte(s)
  */
 struct ionic_rx_mode_set_cmd {
 	u8     opcode;
@@ -1904,13 +1992,14 @@ enum ionic_rx_filter_match_type {
  * @qid:        Queue ID
  * @match:      Rx filter match type (see IONIC_RX_FILTER_MATCH_xxx)
  * @vlan:       VLAN filter
- *              @vlan:  VLAN ID
+ *	@vlan.vlan:  VLAN ID
  * @mac:        MAC filter
- *              @addr:  MAC address (network-byte order)
+ *	@mac.addr:  MAC address (network-byte order)
  * @mac_vlan:   MACVLAN filter
- *              @vlan:  VLAN ID
- *              @addr:  MAC address (network-byte order)
+ *	@mac_vlan.vlan:  VLAN ID
+ *	@mac_vlan.addr:  MAC address (network-byte order)
  * @pkt_class:  Packet classification filter
+ * @rsvd:       reserved byte(s)
  */
 struct ionic_rx_filter_add_cmd {
 	u8     opcode;
@@ -1937,8 +2026,10 @@ struct ionic_rx_filter_add_cmd {
 /**
  * struct ionic_rx_filter_add_comp - Add LIF Rx filter command completion
  * @status:     Status of the command (enum ionic_status_code)
+ * @rsvd:       reserved byte(s)
  * @comp_index: Index in the descriptor ring for which this is the completion
  * @filter_id:  Filter ID
+ * @rsvd2:      reserved byte(s)
  * @color:      Color bit
  */
 struct ionic_rx_filter_add_comp {
@@ -1953,8 +2044,10 @@ struct ionic_rx_filter_add_comp {
 /**
  * struct ionic_rx_filter_del_cmd - Delete LIF Rx filter command
  * @opcode:     opcode
+ * @rsvd:       reserved byte(s)
  * @lif_index:  LIF index
  * @filter_id:  Filter ID
+ * @rsvd2:      reserved byte(s)
  */
 struct ionic_rx_filter_del_cmd {
 	u8     opcode;
@@ -2000,6 +2093,7 @@ enum ionic_vf_link_status {
  *	@trust:		enable VF trust
  *	@linkstate:	set link up or down
  *	@stats_pa:	set DMA address for VF stats
+ *	@pad:           reserved byte(s)
  */
 struct ionic_vf_setattr_cmd {
 	u8     opcode;
@@ -2031,6 +2125,7 @@ struct ionic_vf_setattr_comp {
  * @opcode:     Opcode
  * @attr:       Attribute type (enum ionic_vf_attr)
  * @vf_index:   VF index
+ * @rsvd:       reserved byte(s)
  */
 struct ionic_vf_getattr_cmd {
 	u8     opcode;
@@ -2064,8 +2159,8 @@ enum ionic_vf_ctrl_opcode {
 /**
  * struct ionic_vf_ctrl_cmd - VF control command
  * @opcode:         Opcode for the command
- * @vf_index:       VF Index. It is unused if op START_ALL is used.
  * @ctrl_opcode:    VF control operation type
+ * @vf_index:       VF Index. It is unused if op START_ALL is used.
  */
 struct ionic_vf_ctrl_cmd {
 	u8	opcode;
@@ -2089,7 +2184,7 @@ struct ionic_vf_ctrl_comp {
  * struct ionic_qos_identify_cmd - QoS identify command
  * @opcode:  opcode
  * @ver:     Highest version of identify supported by driver
- *
+ * @rsvd:    reserved byte(s)
  */
 struct ionic_qos_identify_cmd {
 	u8 opcode;
@@ -2101,6 +2196,7 @@ struct ionic_qos_identify_cmd {
  * struct ionic_qos_identify_comp - QoS identify command completion
  * @status: Status of the command (enum ionic_status_code)
  * @ver:    Version of identify returned by device
+ * @rsvd:   reserved byte(s)
  */
 struct ionic_qos_identify_comp {
 	u8 status;
@@ -2118,7 +2214,7 @@ struct ionic_qos_identify_comp {
 #define IONIC_QOS_ALL_PCP		0xFF
 #define IONIC_DSCP_BLOCK_SIZE		8
 
-/**
+/*
  * enum ionic_qos_class
  */
 enum ionic_qos_class {
@@ -2174,6 +2270,7 @@ enum ionic_qos_sched_type {
  * @dot1q_pcp:		Dot1q pcp value
  * @ndscp:		Number of valid dscp values in the ip_dscp field
  * @ip_dscp:		IP dscp values
+ * @words:		word access to struct contents
  */
 union ionic_qos_config {
 	struct {
@@ -2219,8 +2316,9 @@ union ionic_qos_config {
  * union ionic_qos_identity - QoS identity structure
  * @version:	Version of the identify structure
  * @type:	QoS system type
- * @nclasses:	Number of usable QoS classes
+ * @rsvd:	reserved byte(s)
  * @config:	Current configuration of classes
+ * @words:	word access to struct contents
  */
 union ionic_qos_identity {
 	struct {
@@ -2236,7 +2334,9 @@ union ionic_qos_identity {
  * struct ionic_qos_init_cmd - QoS config init command
  * @opcode:	Opcode
  * @group:	QoS class id
+ * @rsvd:	reserved byte(s)
  * @info_pa:	destination address for qos info
+ * @rsvd1:	reserved byte(s)
  */
 struct ionic_qos_init_cmd {
 	u8     opcode;
@@ -2252,6 +2352,7 @@ typedef struct ionic_admin_comp ionic_qos_init_comp;
  * struct ionic_qos_reset_cmd - QoS config reset command
  * @opcode:	Opcode
  * @group:	QoS class id
+ * @rsvd:	reserved byte(s)
  */
 struct ionic_qos_reset_cmd {
 	u8    opcode;
@@ -2260,8 +2361,10 @@ struct ionic_qos_reset_cmd {
 };
 
 /**
- * struct ionic_qos_clear_port_stats_cmd - Qos config reset command
+ * struct ionic_qos_clear_stats_cmd - Qos config reset command
  * @opcode:	Opcode
+ * @group_bitmap: bitmap of groups to be cleared
+ * @rsvd:	reserved byte(s)
  */
 struct ionic_qos_clear_stats_cmd {
 	u8    opcode;
@@ -2274,6 +2377,7 @@ typedef struct ionic_admin_comp ionic_qos_reset_comp;
 /**
  * struct ionic_fw_download_cmd - Firmware download command
  * @opcode:	opcode
+ * @rsvd:	reserved byte(s)
  * @addr:	dma address of the firmware buffer
  * @offset:	offset of the firmware buffer within the full image
  * @length:	number of valid bytes in the firmware buffer
@@ -2297,6 +2401,7 @@ typedef struct ionic_admin_comp ionic_fw_download_comp;
  * @IONIC_FW_INSTALL_STATUS:	Firmware installation status
  * @IONIC_FW_ACTIVATE_ASYNC:	Activate firmware asynchronously
  * @IONIC_FW_ACTIVATE_STATUS:	Firmware activate status
+ * @IONIC_FW_UPDATE_CLEANUP:	Clean up after an interrupted fw update
  */
 enum ionic_fw_control_oper {
 	IONIC_FW_RESET			= 0,
@@ -2312,8 +2417,10 @@ enum ionic_fw_control_oper {
 /**
  * struct ionic_fw_control_cmd - Firmware control command
  * @opcode:    opcode
+ * @rsvd:      reserved byte(s)
  * @oper:      firmware control operation (enum ionic_fw_control_oper)
  * @slot:      slot to activate
+ * @rsvd1:     reserved byte(s)
  */
 struct ionic_fw_control_cmd {
 	u8  opcode;
@@ -2326,8 +2433,10 @@ struct ionic_fw_control_cmd {
 /**
  * struct ionic_fw_control_comp - Firmware control copletion
  * @status:     Status of the command (enum ionic_status_code)
+ * @rsvd:       reserved byte(s)
  * @comp_index: Index in the descriptor ring for which this is the completion
  * @slot:       Slot where the firmware was installed
+ * @rsvd1:      reserved byte(s)
  * @color:      Color bit
  */
 struct ionic_fw_control_comp {
@@ -2346,7 +2455,9 @@ struct ionic_fw_control_comp {
 /**
  * struct ionic_rdma_reset_cmd - Reset RDMA LIF cmd
  * @opcode:        opcode
+ * @rsvd:          reserved byte(s)
  * @lif_index:     LIF index
+ * @rsvd2:         reserved byte(s)
  *
  * There is no RDMA specific dev command completion struct.  Completion uses
  * the common struct ionic_admin_comp.  Only the status is indicated.
@@ -2362,6 +2473,7 @@ struct ionic_rdma_reset_cmd {
 /**
  * struct ionic_rdma_queue_cmd - Create RDMA Queue command
  * @opcode:        opcode, 52, 53
+ * @rsvd:          reserved byte(s)
  * @lif_index:     LIF index
  * @qid_ver:       (qid | (RDMA version << 24))
  * @cid:           intr, eq_id, or cq_id
@@ -2369,6 +2481,7 @@ struct ionic_rdma_reset_cmd {
  * @depth_log2:    log base two of queue depth
  * @stride_log2:   log base two of queue stride
  * @dma_addr:      address of the queue memory
+ * @rsvd2:         reserved byte(s)
  *
  * The same command struct is used to create an RDMA event queue, completion
  * queue, or RDMA admin queue.  The cid is an interrupt number for an event
@@ -2425,6 +2538,7 @@ struct ionic_notifyq_event {
  * @ecode:		event code = IONIC_EVENT_LINK_CHANGE
  * @link_status:	link up/down, with error bits (enum ionic_port_status)
  * @link_speed:		speed of the network link
+ * @rsvd:		reserved byte(s)
  *
  * Sent when the network link state changes between UP and DOWN
  */
@@ -2442,6 +2556,7 @@ struct ionic_link_change_event {
  * @ecode:		event code = IONIC_EVENT_RESET
  * @reset_code:		reset type
  * @state:		0=pending, 1=complete, 2=error
+ * @rsvd:		reserved byte(s)
  *
  * Sent when the NIC or some subsystem is going to be or
  * has been reset.
@@ -2458,6 +2573,7 @@ struct ionic_reset_event {
  * struct ionic_heartbeat_event - Sent periodically by NIC to indicate health
  * @eid:	event number
  * @ecode:	event code = IONIC_EVENT_HEARTBEAT
+ * @rsvd:	reserved byte(s)
  */
 struct ionic_heartbeat_event {
 	__le64 eid;
@@ -2481,6 +2597,7 @@ struct ionic_log_event {
  * struct ionic_xcvr_event - Transceiver change event
  * @eid:	event number
  * @ecode:	event code = IONIC_EVENT_XCVR
+ * @rsvd:	reserved byte(s)
  */
 struct ionic_xcvr_event {
 	__le64 eid;
@@ -2488,7 +2605,7 @@ struct ionic_xcvr_event {
 	u8     rsvd[54];
 };
 
-/**
+/*
  * struct ionic_port_stats - Port statistics structure
  */
 struct ionic_port_stats {
@@ -2646,8 +2763,7 @@ enum ionic_oflow_drop_stats {
 	IONIC_OFLOW_DROP_MAX,
 };
 
-/**
- * struct port_pb_stats - packet buffers system stats
+/* struct ionic_port_pb_stats - packet buffers system stats
  * uses ionic_pb_buffer_drop_stats for drop_counts[]
  */
 struct ionic_port_pb_stats {
@@ -2681,7 +2797,9 @@ struct ionic_port_pb_stats {
  * @pause_type:     supported pause types
  * @loopback_mode:  supported loopback mode
  * @speeds:         supported speeds
+ * @rsvd2:          reserved byte(s)
  * @config:         current port configuration
+ * @words:          word access to struct contents
  */
 union ionic_port_identity {
 	struct {
@@ -2707,7 +2825,8 @@ union ionic_port_identity {
  * @status:          Port status data
  * @stats:           Port statistics data
  * @mgmt_stats:      Port management statistics data
- * @port_pb_drop_stats:   uplink pb drop stats
+ * @rsvd:            reserved byte(s)
+ * @pb_stats:        uplink pb drop stats
  */
 struct ionic_port_info {
 	union ionic_port_config config;
@@ -2721,7 +2840,7 @@ struct ionic_port_info {
 	struct ionic_port_pb_stats  pb_stats;
 };
 
-/**
+/*
  * struct ionic_lif_stats - LIF statistics structure
  */
 struct ionic_lif_stats {
@@ -2983,8 +3102,10 @@ struct ionic_hwstamp_regs {
  *			bit 4-7 - 4 bit generation number, changes on fw restart
  * @fw_heartbeat:    Firmware heartbeat counter
  * @serial_num:      Serial number
+ * @rsvd_pad1024:    reserved byte(s)
  * @fw_version:      Firmware version
- * @hwstamp_regs:    Hardware current timestamp registers
+ * @hwstamp:         Hardware current timestamp registers
+ * @words:           word access to struct contents
  */
 union ionic_dev_info_regs {
 #define IONIC_DEVINFO_FWVERS_BUFLEN 32
@@ -3014,7 +3135,9 @@ union ionic_dev_info_regs {
  * @done:            Done indicator, bit 0 == 1 when command is complete
  * @cmd:             Opcode-specific command bytes
  * @comp:            Opcode-specific response bytes
+ * @rsvd:            reserved byte(s)
  * @data:            Opcode-specific side-data
+ * @words:           word access to struct contents
  */
 union ionic_dev_cmd_regs {
 	struct {
@@ -3032,6 +3155,7 @@ union ionic_dev_cmd_regs {
  * union ionic_dev_regs - Device register format for bar 0 page 0
  * @info:            Device info registers
  * @devcmd:          Device command registers
+ * @words:           word access to struct contents
  */
 union ionic_dev_regs {
 	struct {
@@ -3098,6 +3222,7 @@ union ionic_adminq_comp {
  *              interrupts when armed.
  * @qid_lo:  Queue destination for the producer index and flags (low bits)
  * @qid_hi:  Queue destination for the producer index and flags (high bits)
+ * @rsvd2:   reserved byte(s)
  */
 struct ionic_doorbell {
 	__le16 p_index;
-- 
2.17.1


