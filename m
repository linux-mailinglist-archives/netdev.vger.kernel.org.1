Return-Path: <netdev+bounces-97269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAE48CA5E5
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 03:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1093C281001
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 01:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BB8FC11;
	Tue, 21 May 2024 01:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xbm1and5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0070017545
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255478; cv=fail; b=g9P9eAB2pwT//xkQHlPMVCc1x49V30yyn+b5SM3JGBVJxsGMgqNWFQZD/B/0SdlbF/m0nJWcpYGWZtdZxvyI3ILtXkWj2NPsaLXGKaAozkjgK+HMD+3MEG+9NYTd8zKTnaCrvnhGhCSE1b4DX/U7fC948Y0zAAQiAtwZc+PN/dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255478; c=relaxed/simple;
	bh=D4A9z367fch+x8sJmD3pV5qXDTCmcPSgyds5SMO412Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KavYEu68SahpoYesPAkPPPD9McQE04ai3YP2eIkVbmkQThgxFmEHjNAQa61YdkwdJXjfVx8ryawhgbwWUtbClS8UsBskS3IH8goLiUtlmGQHr9H33CigHfF6bJMbtC4OUaHFRDIBcv5A9cvm+uVXLx70LGGXfO+e5d6ERIH1ohY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xbm1and5; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJepXDCnCjggq2tghJc/xYOZYCIcChE8Qry7WZnkVUAAG5bweXQ4nKKoxjEki5Y4KdDJdggGir08smoF3iOyDwbFwSMbaHRdY3W3c8CCvil5SArjq5KaEyLYVFcV8Z0nHppFzxd9JBrQo2smxOIccEC0P3wUZ9NWIBLoy/4lFDcQGXeBTSgX92toSQ/GjqedeIdiKXxX6TwjpupO8nTweCjVUyGfOXUoKUhDk/cnOwQNSQ8BLBCN5bCNj9hnpQJ+u5zk4K+3guxKNGDPOb5aJLiKzi9+L/QiGUVR9pT/zVkwIT+Rt/2mHd5LKzGPdC/qY23ndZirQGNUyP4kMP0Z1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWlSKLneip+jJgJKQekuKW4UbgmXx7Ssp8vzUtACoy8=;
 b=jyxzIo9KxZjud9pGxtwMx8XT7dbT8tpa8WlQanKGNklpGYgqUBzK0/w6pV8zmrLh+JojM4VC5rOJH4Oyz4A/VE5ThapG1XdCBVWCwyBr684O50DQYbLyKKmgCFdffguY6IX5C1qVAtPPsEVUNGNA2kCTQKm6ipc5ySW7q9sWKxGCsr9tWuVZzPlL9PoDD94Bf0v1fXr4XTRqh+XDXFv5xBpL4ii9GV1zaOu2TY+//cljiA5f/FuMaCAeNhJuk+VzthPJyO8N4ImHEaMKMBAeMdgTiBm2ycvBBVNHqaL/ghUD9TgZxytBE855dNa3I/pkQ6O575aFCykws5+7/OpPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWlSKLneip+jJgJKQekuKW4UbgmXx7Ssp8vzUtACoy8=;
 b=Xbm1and5wG6Q/OQ78p7xJhK2fMqilZaQ/1Ulgkp/zfl0Ijd8ZaveCT5o1N41wEuVrYfMSrDP+t96X9AdhyiEkPs+rqTNvykJZ74N1NOGqeAw2hgoUx+4+jhkn/NdeJcJsoC9/mzizSDOzPLppvAbPPuqrvmhGwSmwTt5zcPpc2M=
Received: from SA0PR11CA0017.namprd11.prod.outlook.com (2603:10b6:806:d3::22)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Tue, 21 May 2024 01:37:50 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::13) by SA0PR11CA0017.outlook.office365.com
 (2603:10b6:806:d3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34 via Frontend
 Transport; Tue, 21 May 2024 01:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 01:37:50 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 20:37:35 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 7/7] ionic: fix up ionic_if.h kernel-doc issues
Date: Mon, 20 May 2024 18:37:15 -0700
Message-ID: <20240521013715.12098-8-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240521013715.12098-1-shannon.nelson@amd.com>
References: <20240521013715.12098-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebf1b75-7887-461b-701e-08dc7936a028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b9QeIo0e4nA9IvWJJ7Y8K/NhEribbPj0FTjshBQJYyTCwzF30u40VVNyhVSI?=
 =?us-ascii?Q?kraC5ja+kvIvu7y530z40E7N2FecuQZ+7tMtOMamP/ahEgcUBAY3LZReRnpf?=
 =?us-ascii?Q?wF/rzkdczv/cLhFpPOMwLQ5JiOWOVvFPBDCXEwUxFAAXe/SIs9nb1ti7sb6v?=
 =?us-ascii?Q?rt0GCXEGmaEP0Y2mJOzhmCou6lwsdVHKfasgD5tHbKzZ+GykQDMPNniUHb+2?=
 =?us-ascii?Q?ZtxxTbru6YCtEIbLBS/u1q/qAryg+MBZy7coNlzpnGQ4B5BoldKBuWtjjnIP?=
 =?us-ascii?Q?9VEsHXJVXqO9jsA10vOd9+fAR4Mj3rEzoFdLLsaxI5/slFdyuoMXeOBM+W6Q?=
 =?us-ascii?Q?JD40jmE0ocH+Oi9dY9WjVnz8gzT50dVlsC+EErJmZs0tjrtfbMZjjPUknm+l?=
 =?us-ascii?Q?xo+UgXnsys0iKkczB2uM/EmrL1aoYw5q9dTRFIdpQpL8k8+nK1w1cCKCx8j2?=
 =?us-ascii?Q?QfLzkBSkDuV8A3+4acRDKGqDJnr8KPT03fwhTWObK7XsjPlE5aolVIZhBbTZ?=
 =?us-ascii?Q?v+c84CIWlgFvrUyDjEhfZGBVVlgjZiZTfRsW1vqFiWdRxn52Ac25p6YeJCcD?=
 =?us-ascii?Q?cy7lTuHlfWzirSBRRsf8rHUTdK3JrpdGjPxyz6nGcZRDnapAb1q3U3UjTEKW?=
 =?us-ascii?Q?EeuEjU0CmqtICQi6QG6RgZ+e6vTFiXK7FFlBxmNbfEpD7p101swah4lW26ZJ?=
 =?us-ascii?Q?pc3W9DPeDU2cCUVXWrxkq8+5rvJDrLtL27xzSqLhCTb5XQPjdzmfA69QdJ2n?=
 =?us-ascii?Q?Too44Hz07+gRw205BEWI5jZKCqqJDPpFGJUaAg7xQPT4nvTffOrCpAgDeAlh?=
 =?us-ascii?Q?5AN3Ex3ZvvnP/rGSEWDchBYpO+F+CfwDhslj5o4AQ6jSjaykqsgXRYLmnS/x?=
 =?us-ascii?Q?tOIayhhjlCXqCvcSdrdNBOTYG7NSzjPH+TnNPQ47pSlsqXtc2DWlRPPLQDIa?=
 =?us-ascii?Q?bvW+6DKBSOGdfIDfWk1VWKNWEQCeojCQKPgnsnvagOpeolJWDKuPYPingoKf?=
 =?us-ascii?Q?y63nHAzC2m/fi/XY9ynwGdvuW7HNqtl+H70raqgvKueDXZb6Z18RXuvt6OMi?=
 =?us-ascii?Q?bXV8krXs0faI8JyD2PNXfYE5+I1YzNA27Q4WxOxYgP4fLCQXUWDsPHHfsaJv?=
 =?us-ascii?Q?F3LhCx6O217bjjGaR8zw4qVQdJXNHBSiUGZEG2nfaJjjvUoJyWjDOozeT9c/?=
 =?us-ascii?Q?QhGjyp+s6rIO41plJVdSQfCpb2lDFYT6m6zLk7nuFDQzWC5GaFFHcZBfhGdO?=
 =?us-ascii?Q?q7YZweuuNG7LLHL8h3v5RYjSt7L2DBcR7R1V6NM9ftX9XK2hlzjuAsuXn76g?=
 =?us-ascii?Q?WqHt8BD6bhJQaJMjKYk+H2216tRb1jt5xqWRpGbtwewGQRvXkOPVgkt+4tY4?=
 =?us-ascii?Q?FfXSbffGF7lxdXkNaCMDQv4vpk30?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 01:37:50.1342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebf1b75-7887-461b-701e-08dc7936a028
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372

All the changes here are whitespace and comments, no code
or definitions changed.  Not all issues were addressed, but
it is much better than it was.  Mostly fixed was a lot
of "Excess union member" and ''rsvd' not described' warnings.

Fixes: c4e7a75a096c ("ionic: updates to ionic FW api description")
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


