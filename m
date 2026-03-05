Return-Path: <netdev+bounces-264173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNoBIxkHqWlW0QAAu9opvQ
	(envelope-from <netdev+bounces-264173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:31:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED27420AD15
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE27303799E
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 04:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA3A1CAA78;
	Thu,  5 Mar 2026 04:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2L1dGC4B"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA941F936;
	Thu,  5 Mar 2026 04:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685018; cv=fail; b=PwMRB24GRIb0GKbp7aRUlXVkHGIYfiKhekymAstlOG1wLGYva1Ub9A7yozgt5Hx4yiLdpIc15q3v4djDw7sq1um+1lppYPRTyPn/iQdOLVzXVsXDgJaxUheOIhZndbvWqrAr43V5RDp44bI8KGkjfm0kuLE5RIzWPeQmowJmIfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685018; c=relaxed/simple;
	bh=sgegkmXb0yHT8ND5bdjlRLGThy6DMt1tF8UROmi2wr0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m/eKkDD0fx+sKPm8QOswjb/A74e+SbDzJZ0aa56KXChKT0bu9I4xi7tui82ibq+ZuyFRM2ZJgY5DsroyQqgSp1vGNi4BnrGYv4nVN+bpSmN7zVIv8XkaGRyx/zres0NUVUYABzqolJTnBiW/OFQ0Rb2Ygu/qRFw3sSxk09yUoBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2L1dGC4B; arc=fail smtp.client-ip=40.93.195.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOh5mDCtncLpz2R0o5fqx9vkhHnDYVeVJT9Gayc4/HgCrXigymuoLtc/QZVQI8fMtmnZkNbZNHVstLxtv6PqC2f8zIcZOfIBb/X/CdZbIxCJt5Fv+oJHcAkZVzTcizXdrSy0pnOZuOMK9ODtUoLyp894/4N8hCqUlnJ3SMqaYfO5ux5FqsMUT9wRUZpKnEBJSdH+qBeYMLZKWNqVyNBaHBixeRVrfpajr4P3nFDvpj87iB540f7sBY88V+QkYYDuAwo0Hpir0CED7CxtBJCybibkw7cDTKmad2pWefuAVyjcuABRjwDgORyDwyQFIrraeZkm8pe76fZS0xbsaam5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXb4plizlz37km1P4ZykraA5xiD9Tfc0SxFGmXBXICg=;
 b=saAVu2+A73Jhhw7Pt7JW0tbUL21ZD8CdvO4mjIEF0zCe8M0j8oNS7zUJWuOxajaou2qyLrvydCX2C3FAPm+tymu/MCv8L6FzfYrBY1W/ukdM9mrcpToIk+V9IX0ic9YgPwdr9EnAp4IGpwAEVNFRnrtm1dd9ST25od9o9//IClIL8ISs9vEY2w7JFPoBLlXmusb07BSR898Go0dQSm3xCXMYFbNH79WpYAbir4FRXRCXsluIcB0YcrsViNuN+00t/jietvkpRNMXbY8KU+FwEhFBgmL8/DOPuZuQM809JKDSGlppH5sYIy0qkg8XdAieMmp3AGykhiIriWCe8v4EWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXb4plizlz37km1P4ZykraA5xiD9Tfc0SxFGmXBXICg=;
 b=2L1dGC4Bk52NMSoXiwblwTCx3JtkcPUw42deb2a+6R5ArNw/kCnjxNlSJnPX6kCdwlcH9rXSiZ8f8q+JZeimvJqtaMP6soGAz0AMaHYjxQm57Ev24pYtGFJqbHQyrUC2D+Op+MNSnKm5rHo0R3Lm5VAFgAQ6AcOVsmTYTc6KeeE=
Received: from BL1PR13CA0135.namprd13.prod.outlook.com (2603:10b6:208:2bb::20)
 by IA0PPF0C93AC97B.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 04:30:14 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::b3) by BL1PR13CA0135.outlook.office365.com
 (2603:10b6:208:2bb::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.13 via Frontend Transport; Thu,
 5 Mar 2026 04:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 04:30:14 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 22:30:11 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v2 net 0/3] amd-xgbe: RX adaptation and PHY handling fixes
Date: Thu, 5 Mar 2026 09:59:49 +0530
Message-ID: <20260305042952.835926-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: 334a3b7d-4ab7-4285-76b2-08de7a6fe586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016;
X-Microsoft-Antispam-Message-Info:
	YOGuXUpj1HMasH3TS+6o0rlg/UlDx3x7TGLxiKzMfb8q10eu+u4xeU1URY8oboc+aSLN6mpkzRcYPZFYX7YkVgJ39lTZSYObvg6gZHMYxMGnG2JOUBN4XQe0YdSlzwlj137zUKeYuD4uF0lRkDTMC1DoKLOTbMBbcDeXgw9fUSsuLlz3PPT5GH0ntJ2zR7AEarkxKs5O66wzSKy9Ar3H2CSRWA4Z6QFWS9QWkRfvmjuIZcVMNlqWuZvy5HQJYOyGUVcWBNB7BHBAsVWX3W0oirDVqwJEagandr+MUhPId3zJ7BAdZTnEvVOhJ6ubYb/d2HSmHp6ZPSSIyoAAdCnZHtIioSv+egF6EltWsMgM2R2TMdrfdNNFCCNdxzXmFM/zuu9UMtvzjvbkSiJt9kkZZSSl7O/UeScYAxTJynVHuizzc3D+JmHxYqMQ1c+U4r1L8IzuzJPVWj7n9/+dGjaQKdim3VkqdyjcHF+r6xmkQrHtzt1qZiwd9qaF1SQLBlLBNmBzkfhydbpD+iPVCMl0VH8etmv4DB6S+O72qW0jjd42oZRAQILXjTa7yuHmx7iEW62crzMSiFaOCt1KB2LNbcVKWJpY6VmOGEkCktk+ytW9usBLj7Pah2PCH6vbkEQvqS7LXbd4/L6Lafzv2gjFeRuv9ESZelhgP01qE9N2GUCoITE+PbgngnNEoLuUv5w6h0R1FwOxsFhO9iY2acjHe0FTNbjDCqn/ltqHI3KKACl/uYYTbPPJmMylVRw+Y7U5iq/AynYMszsPi76IT7rNsw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8+N+4hm1QfvSOM0C+/DZFwKZEBgxbsLK+PSji2VHoyN/AY/yOpnu5mm0WB17k7UJQdPIzEAWpFBwb6/76fBFjtzYthD1AfdG/7hQeuTpS0nR09HFXTMvtYi1G3DPt7aj+SGd205oYDN414qExLx+UUF9c9OQi7X1RtNOtUbnk274mTGLo+USO10+la4nMvWUeGMHnUBZK2gVULS8dVbGlBvgFWKhPI+n1N05hORKaeHIT/+b6+Xxhs2KYD7jfdjj9Qw38JzXmX/bqc6XxnAtmCdhpaRiieVXQ/3V00kj6rR0iuhMLoyLu7naQv6avkNAxxiKVG3Rgp4JQDqYKvGmYND/+kpiNj6wqWc3S9BzJq5r9oGqRwU09I6TeVTS3MsKUomGlR2whVU/Pv35C+njwmzBRQQrhfyGj5dd7zfl275bkDQOm5wpVvdM7od97Caj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 04:30:14.3579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334a3b7d-4ab7-4285-76b2-08de7a6fe586
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B
X-Rspamd-Queue-Id: ED27420AD15
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264173-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
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

Changes since v1:
 - Patch 2: change the rx_adapt_data_path_stopped flag to boolean type
   as it is only used as a true/false indicator.

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


