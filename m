Return-Path: <netdev+bounces-263802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD/1C6YkqGl3ogAAu9opvQ
	(envelope-from <netdev+bounces-263802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:25:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 892A91FFA98
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D17C3300D465
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FC53A0E93;
	Wed,  4 Mar 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hs8FpsZd"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041BE370D52;
	Wed,  4 Mar 2026 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772627015; cv=fail; b=kciVGDpFC3nlvoKXigPdGDPgpChJ2lJJ2e28HVSbuxXoHyLfrizLgPcDPCh6PB2UIS//TirysXouOh0fJLhRlQgbQFNwg+gKPNlm8rFLOBjbwNkDGUvnAiGLAg/nuPVS3s0eMNgh9HrYYLv/9KdYL/EjeYcvzKIx+SHzlfC6tzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772627015; c=relaxed/simple;
	bh=8B5d7gdyd8+NW4hZtPdz0zZ8DVy/G8K39aGNfSFLddE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hzTyGoQoa5viuUF/rdXYhjcbnqWI7BExIRWgI0Z3QTtpkYm+SqGox/FyjbCHOio1h4Wi4i4CtVbL2JcXyz7XoEpAz2SIKADBqRilNqu1epl+N+cSpNbScklhBGeMIiOcWSZdemUXfEXsN5cl/zOaR5ny+IsHdY+foCxGX4q10Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hs8FpsZd; arc=fail smtp.client-ip=40.93.198.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCjrflKnZgD+vMJl/Z/URa/EOHecz99tMnN066UQjlztaCfnKwTOOYGNa9zf6sraBn1DFGySTiUqxEbJ59/vDvYjoXD0Q8fgwyXDdkTxOXrlZDExAQ+PIwaCpZpruuzkI3B2+WhvtAPR/FEANqU+ys8dsje5LeCAbeWomPOQJsGkn6bIkYkiMuzfRIWOzhRDXI5aiOCYQMVk12F+sHJ46/HsKtXH14gp8fqG3EQlcA1xeUN0o8buDnU3G+0V6ZBAsbg/HwkT6KpekpknAGk0fnuWBdCgXcyNLFox1E0FfNXd5SL5GjTMsDf/CnPgK8DfxHau5VNU4OubZz9Oi/CHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nPXy5eTkl6QW3qLt3sZhiR+tzIIKFCCdQyVqOG2vRc=;
 b=l2vfyMAYzYS97llvfYqrXRlW7/t7LfeSVWubCtN5DfVoXaQMO4+wA5qJvz3fGNC3qLm0r8v9yUmGq/yy7zefbH1ylzJvwkS0mmx0aJe3mXjXA7+8yM63XF2gEQ3hBWwDFHwZKLjrF4PvzRyWUQjLGRc5/RYl5zHv/cW4bBtiiHd84RR+3slqdYpP1ExM1ATGfbB0MgACNo31J6ZMRhBnDiCDjZvJuMWfBomGneo1iRHn5KPE5umggJAc3ibO0onWtCu2wtgx6cuTfeRREhuixSHVEzM1XHpDJTQbZZnkDWLV9OT8BzcyxZFv2LPQMQVTFqh8pbYCIG6QCSlJndxlCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nPXy5eTkl6QW3qLt3sZhiR+tzIIKFCCdQyVqOG2vRc=;
 b=hs8FpsZdqsWVud2UFeNOv+FqyVLFnn6DRjjo66D+WeHhmHdaQtEiDvx/CiNR3HJJbsSDc4GB4K+9soMyzAxAuUIpNBji9AGoiN4MJhNcFeoDB2zWJ+lALDamvYmW6GipzdzKrB5MjPjoP+1m8MIv47GsUNutUMoqsTQyqqFbTDI=
Received: from CH2PR14CA0021.namprd14.prod.outlook.com (2603:10b6:610:60::31)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 12:23:30 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::c7) by CH2PR14CA0021.outlook.office365.com
 (2603:10b6:610:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend
 Transport; Wed, 4 Mar 2026 12:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 12:23:30 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 06:23:25 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net 0/3] amd-xgbe: RX adaptation and PHY handling fixes
Date: Wed, 4 Mar 2026 17:53:02 +0530
Message-ID: <20260304122305.812541-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a532319-02b8-463c-10ff-08de79e8d861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	SZEL7S+ULleWLoHcQJccJyNoKgSyy9Mi5k912pXZrctkvvMnm7JNj6cqYpLt0Q52aKuNYQRrLL+ILzghfjZwag06ASNL1Ok1ID4bHL7XXYANAf9ztJinkp4oxuZp1dUYutAFtb89Ewh0iezqJwHHFRS84XMkeMMxeN07GdayuaK+TuiUysByeOciD40KIA/zdg7LUUs1XIy4OEAMR2vp2ZwrZmTQsKM8Y5honHwlSqbmhDhA/tiPntpdizdNYvI/UiC2vTqzSarGzFRURS3Dzdd0W+3Bi6MHqIDpDyKJiVNNMJvEg3Wj4u3OcCtzwfEQeBRq24p8jojzjVon5v5p3u9dw8N9ly5yPBzhcQuiJi9U7lMbSXPxTpwen9fwhn3XCFqElMSKJ/PjuMyMLQT1u6k80WmkPOi51nGJ8hFYb0GCoGllkOsIsHV/4lTOOKglq9DSeA5MHl8KE4DCg53LfILtQUP+O76PFB4n8VXEBosxpwlMG+ZPzXmcC6+lMFG6/Wkqqd5JMwhIXqdOFEqjFMrg4bUM6uJCyt98ZH5B0Bg91zZEF6qZz3tOUwJYHvfiIcFKeR5A3zl++89os4zpKVU2KXn4UIk2K6wZL6C0srQKgCbYVM0VRolaCPojL33d66B0D5WmsAnDyAgvB48jQRdI4FGVvNOj9hZBmJRL/qc3OPWroWRK1Jmc1zbSSVkaFeeKY1nAxFClYilJ18DETdEouFnQf42CW5NEgU4OJ5jLuZXPTO6jCCepN25usk9qxqr3yqNSEpYMIxEuFImH2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wDofzyO/AophnqLbcYB1W58GmOnWPbA89FLtHBXVR6NT5zh1fWsYUeU4HuLCbOokEnPRf9eQYad1aL8mnPVTrMEqroMNTXaYsV9tHBVkNbGnEA+n1AvaS0ouh0JXjtHWYMbC0c4/Uw7blo35nf+XGLQwolxIDTdwvO+HVqvUQs1Ax3gVQThZDJCUm1ZavSL5FL/gRzXQsH+qa4ZrqIVz4hWRygcEfg4sDeIko1yLLXSZmA2JlI3cJyHI3fKgWT23REFDCdtDsWmPnmbXZFX9O/1fx1KAWYvvI8dyZCxJU6MDby38mWPoRPz8TSpGkGTCaDBZDGCfSWP/YP4dT+kGpPBk8rs3O8Nag++CT4+fR4rweNjLHW/8oi7hopjCWn+8U1fcEM6sO1levpnQSjMWYGENgHp0jX72ydGVtfVVWS49S7wWeglfpC0qZ2ru6sMS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 12:23:30.2266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a532319-02b8-463c-10ff-08de79e8d861
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
X-Rspamd-Queue-Id: 892A91FFA98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263802-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:mid];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This series fixes several issues in the amd-xgbe driver related to RX
adaptation and PHY handling in 10GBASE-KR mode, particularly when
auto-negotiation is disabled.

Patch 1 fixes link status handling during RX adaptation by correctly
reading the latched link status bit so transient link drops are
detected without losing the current state.

Patch 2 prevents CRC errors that can occur when performing RX
adaptation with auto-negotiation turned off. The driver now stops
TX/RX before re-triggering RX adaptation and only re-enables traffic
once adaptation completes and the link is confirmed up, ensuring
packets are not corrupted during the adaptation window.

Patch 3 restores the intended ordering of PHY reset relative to
phy_start(), making sure PHY settings are reset before the PHY is
started instead of afterwards.

Raju Rangoju (3):
  amd-xgbe: fix link status handling in xgbe_rx_adaptation
  amd-xgbe: prevent CRC errors during RX adaptation with AN disabled
  amd-xgbe: reset PHY settings before starting PHY

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 15 ++--
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 78 +++++++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  4 ++
 3 files changed, 83 insertions(+), 14 deletions(-)

-- 
2.34.1


