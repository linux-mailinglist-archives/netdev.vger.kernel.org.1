Return-Path: <netdev+bounces-270433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI3kKB4DwWlUPgQAu9opvQ
	(envelope-from <netdev+bounces-270433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:08:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEC62EEB84
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6FDE3012BFA
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782AD3859DA;
	Mon, 23 Mar 2026 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tgup8+rv"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074D3859E4;
	Mon, 23 Mar 2026 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256654; cv=fail; b=uDtgFLL6NerqJvEqP7V/IuTlZQljfwL929ij3fAbGSFhLEJhdeeGiPW12n/lGx4IL6HCuy6/jebr9vkyXIO7SLZb8BnxaAbbvg6TY98546QAoU8FX6GFxAKYPMs4mLmRCLlzAd0BWxvxXd5guvr3nJwreA2jhl6ZeNfXA1q1AM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256654; c=relaxed/simple;
	bh=Q1haGWN0IZM7S1rs0oPgtOx0svfYhzC6pZ9oEHhvK0Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Iat31jvm1F1GYtTZ1Etc+P5BZOE50mf66iMqwDTT68Q6UbVE0lP1pNMkFZ6rog1lcfjgtNZ388IAEDtukJTOiYqvQ2rHKjmBM2Xl1I2hWB86sdUQSqimMAnFomhnF3F0UfRSTvB91dlZKfu2AbDG3UYjtDzCNMhUdqsPo3Qbdak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Tgup8+rv; arc=fail smtp.client-ip=40.107.200.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUCo1V06jceKfdG5/gGIIIS5ZivrTQBwPSE/tnCJP6taqqNzqKQyurUzbE/XZNrP+CRro3DWfxij8F53HhRZQE1J1ZNoBEqR9GMD2gYDkc44BkhKGaMShErHL+A5vN01Orl1B6QFDx9UR6Pt08tfkiuFQ+pTLoexFHllhvROApnTZwfiTAnMF7VIYUwzR2vzhP5eVeWqnMr4jM8U/hZQfAwuDRZpASBXlah01J7a9C3M/5NAPf0DvZmbFj8WtsxmY4vpsHxkM3tysb5tjMkbfMeZm2Q5Heh86172sKV4ozhXPi6Zf+MFLm+ACiEGnrazcrADskw9vh4HqNlYBNiaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmtHwpR9AEi48iWagFsCL9406xMrTncayuX9ueU8GT0=;
 b=LZPf9EXKZdHxOZtg/az8ZHCpf04Fw8EiFprDsx1G9PG/48y00ZP66uR8rbtjGlYV2lMt04CTc0opYsNwHG1J4klKbT3u6AsGXJCHWA8qXeN0p5+0LoH8SYdKOY0C1xEU+CyunZTR2qlwfHRcOIppprdgPxPJrTdwIZIVjqOF8qhG2uC2l/Y5LIb8L8TyeGZlbDZcqzNEQrPXhaWQudiqJpSfpOzJ8VFDpVjpP18eUraSjXUxfUmqohQTAtTJgLuqf1cHX/3mpZc+4YZ4WJqnaqkXrljyaqva/UNtdJskzHYSp1kb2SmIMmfXYBgW1gq61Z2AGLV2bJzof/+5WqdSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmtHwpR9AEi48iWagFsCL9406xMrTncayuX9ueU8GT0=;
 b=Tgup8+rvdcckSMy5QDiNBl7ftjwllNQIo9e8Ncakn1uA1Se/9C1s2kvj9RareBs/rL35rR9VQNbt6DfJXsAr5a2YdF8W7k9u1pDTK7cNylIe0r+Zw+Jr7Y5xWKGUXBqf73qXiQ2EZUKgzckjMBtzbHv8dtu/V7/qS2sdZzt4/zA=
Received: from PH7PR13CA0001.namprd13.prod.outlook.com (2603:10b6:510:174::7)
 by SN7PR10MB6978.namprd10.prod.outlook.com (2603:10b6:806:34d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 09:04:09 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::f5) by PH7PR13CA0001.outlook.office365.com
 (2603:10b6:510:174::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 09:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 09:04:08 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 04:04:02 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 04:04:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Mar 2026 04:04:01 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62N941ni455890;
	Mon, 23 Mar 2026 04:04:01 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 62N940PU003500;
	Mon, 23 Mar 2026 04:04:01 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
	<danishanwar@ti.com>, <m-malladi@ti.com>
Subject: [PATCH net-next v4 0/2] Add ICSSG0 dual EMAC support for AM642 EVM
Date: Mon, 23 Mar 2026 14:33:56 +0530
Message-ID: <20260323090358.632329-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|SN7PR10MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: c34d7b78-a35c-4233-9639-08de88bb2453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xYgviStVfWnrgBefkGpk96Cu7F50dD5VWw3rvOQNVCoBNS7zf2AmGI0oujjldRawhwGqIHP89CaB+Js7Yc4Dgp0l/54NC7wxE8AxYGAkJd9Qs740sEGwKyX9jOVSmhRLg89VcjE7TcwGzwtX9D4BahG91EyG+0k8Lkr1ufZaG7gBBh0VDx0lT44kNy6iq0I/WfI0f/JH3QfABEDXeBaqgWnzol1HvZP+FAb5OwJx2mwT0p7I+1UmaEVzkoJmAA9hz4N68lLusr1MsBkoFjJicDbmRF9c5sRfO4L5+TfECiBUqMbgS4zjkxWn2yJkA2WsJrRvOOACu7kG6/oa8DgslQ12BAeVsVIBCO0XUem8nlbHwJ1KnDgDakLtpcrSv8odSi/v6ciXLTcZpB/pHf+xNdgE2vHVtM4VwhPP3jG3A0qCKvBMZT3cD3ma8XbUXeAM+HV8n1vsi1exnk0qdf4GUb8PqpZEzyhjFFd1UrGMpV3leqGwxgfIB7B3976mk7uudWUtHxHajp/EIJVn642N5ZLkOKDWH8XX7r4KIpEf66CwadMxYdOXMDEjbjw0biIpEePCfC1yPdCxb/lpu7xt2qTpl2z2HXCfsYRwSs2H2XWIsgxcXIbFFtrv7cwblkFySuv8C1v4aDtqOrIFFL2IN378GzkZhpR5J2MsHJ7R/zk4UgPZFgnzxhtFI8JcNegjYVflZBSP81usa7stOa9AIKyQ3y/jZ15Hqn2pSAwFVSca+xjb77uf39CZe+9kOtwpZOh1GqNtTXd6xEhlXpHFSg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	akl+1le57DOn+IulNIVdoTfGYpR46VyNA9FssajtkvCYth+40Hg1wb3ZPYzppvAn+9gme5nhjK2zKm5/H8/+xuBumnj6JgKZNRNNF93yJwCyuktNmWJrNSuh5QF5/NmDf4/RJwE/CwrqDdZID4GXbl9nhBcExmjJ/9wk7K9+maFQDiYZMO/bsBNiYn3X8oU6FeZ7RYK+9HyVBa6OcLySQo9nneqjAd19wMEdLwXS3+oZCyma7beHUu4Ot7zd8ZAL35dGPh/qZZmI1q91qATQ0LFitBdy2jqwaT1HjLM1QD3pajBPIjkkltbSfjEI3WszqC5zr6uLakkpOBRXq8h7ms0DKbudy21ebx1KN2WRV4dGeBEqvkd1msN1rD4pdp5kaKo5CGMp+mJ89E9n8S8iZhfUto5XqgyE/3tZVp9dFiHag/tCbr2hHh/zUdgCQlML
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:04:08.2621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c34d7b78-a35c-4233-9639-08de88bb2453
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6978
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270433-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:dkim,ti.com:mid];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1CEC62EEB84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds device tree overlay support for enabling ICSSG0 dual EMAC
on the AM642 EVM, along with the necessary PHY driver configuration.

The overlay enables both ICSSG0 Ethernet interfaces (port0 and port1) in
dual EMAC mode and can be combined with the existing ICSSG1 overlay to
enable all four ICSSG interfaces if needed.

The series also enables the DP83TG720 PHY driver required for the
DP83TG720-IND-SPE-EVM daughter card used with the ICSSG0 interface.

v3: https://lore.kernel.org/all/20260311053852.1034244-1-m-malladi@ti.com/
logs: https://gist.github.com/MeghanaMalladiTI/20e9e661c3e1075694097bc02f5a3916

Meghana Malladi (2):
  arm64: dts: ti: k3-am642-evm: Add ICSSG0 overlay for dual EMAC support
  arm64: defconfig: Enable DP83TG720 PHY driver

 arch/arm64/boot/dts/ti/Makefile               |   4 +
 .../boot/dts/ti/k3-am642-evm-icssg0.dtso      | 168 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 3 files changed, 173 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso


base-commit: 9ac76f3d0bb2940db3a9684d596b9c8f301ef315
-- 
2.43.0


