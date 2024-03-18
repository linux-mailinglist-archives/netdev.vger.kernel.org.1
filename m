Return-Path: <netdev+bounces-80494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E9F87F441
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 00:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737381F23652
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 23:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE05F86F;
	Mon, 18 Mar 2024 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vFSeSOOj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1F5F862;
	Mon, 18 Mar 2024 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806034; cv=fail; b=SrVC4aKxdmwCZYvPYgU8UYsjTO4tgkSewi/ianO13SzF9SIWnq4Z32dYLQD90Qs9aqKPho/0yq8iRgFGzvprS4LFfYd7l7KyxOwzMXePtoTwUXTj3wPS8AKTU9HtIcARcVui/VATwSh3KESkC2WdndRrGoibEZhLDqXRZM+XwRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806034; c=relaxed/simple;
	bh=DG8Z3e1rszDyw6zdqD53+1vnKurkdRFrcrI17GBQkiQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hb0SepKaJ8NXdWA9ARVPHaiMFDgzb68xbmiaxanTI5PAd7yrvPMc7DD20XBoYscgCT6eMeO4GW1yNZ9mpT/NMjBqPjcoQD6KIhgMcqJHBkpHX7FQ5Um8A+iH5ory6HGL+TVfJqNZFOXvXHxb8mCHoZv9XcXX5/EDpJ3vLqcAmZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vFSeSOOj; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHC0WUWMAb5MhKDmkXlUmO8EDk/+HquP4eM4JsPPOKzHBapngpMNpmjSg4bEcQzLUmdO25f40Lpd0KBvbVFSSVNWoYwhugvi1MvG3ErE6bj0MGB10gy8WPsM9HGDiBRwdi5coy585rQ0rrEErccH9dFeN/dshoAsz6Jiu7Dg5pDMcipwj8nc+rrppvuwt4iLZAetb3MvLtkBauhapoJqcD5CNh2zf2mQsvF3Ja+COzY26raqhFxx0aPsAkwaYvJ/Hu0WlRsuMhVQ5cHxjaQc9vipj/Zu+AdB+HLYAEMYNvRKnQsWTxE37qbN0mNXRTo5fpzHuxlgFq1iQFjGzEb1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+ZNWiG5TsJmnRczzlsZtC3waPg7Hj+DHeXedDXu5PQ=;
 b=L2YU5niRxKNZiWPRxxSfuhVaenCruloqunUpkmKGSRKTzS4giH6jc1GiGzrhRx8FtF6C+8nh7W1r+TSgeLOE0ad5wqRi0nmBIdW9W3niojcgzaX3SaNgGWaruySog4EquFG6sAskkB1RpRJQg7NF6a4H+kSzSO85qeKu7ERtXUNa80MymUbd97r5M7xm2l1yhIC8oJ8LI6arY4kCJugUNJRJ/EDAkkssfuPASqJuiB/HnR+k5974T1q95hH/mihRB3y4SJkg4vrVicUW/AvglZJmULTI3j8EVUOr1loOzFeriRnNrGolb0K1MHeCewIwUIL9lobBlS0GDzt5DJCGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+ZNWiG5TsJmnRczzlsZtC3waPg7Hj+DHeXedDXu5PQ=;
 b=vFSeSOOjE43b0f62Uefiqvo5U9h6c35lqEORMnLpMnfrVpkmLi74+rKjq+QpP6aGaXUNy6THWnF0yWuV3BOvcdsll+sH7bCYeMrCSdJf4uyTL+eSGd4h64Ij5LrYvGYJCGbnYxpF0DkkwHZSuDQd2VuIW5Xm6QIQepVnHfSV/IU=
Received: from SA1P222CA0191.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::24)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 23:53:50 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::fe) by SA1P222CA0191.outlook.office365.com
 (2603:10b6:806:3c4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 23:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 23:53:50 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 18:53:48 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <corbet@lwn.net>
CC: <linux-doc@vger.kernel.org>, <brett.creeley@amd.com>,
	<drivers@pensando.io>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net] ionic: update documentation for XDP support
Date: Mon, 18 Mar 2024 16:53:31 -0700
Message-ID: <20240318235331.71161-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f21226-71b5-4116-2a48-08dc47a6a91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zyz7JwUK+TEMjH0wh+2NK0NqhFC1VSwwEDKIbPdsEnUQbVbrMb/071I7LKKckZdrNhbzuraS/pzxZ/Ma8eZOlQtXF15EsAnC44ioJRqnMHQWyLsXwBdAULCICaX8/KhnH0pBWvEUg+fQnbLIuZFHJUK51WlCpAZhNd+5OGjqCLRXKU3yg4MpwwZMbX72Ynitt7m/t7rY5plp7hiQVbY30tLH2r/Kkk29xNtBzk7k1If8Y1jsON7sqb7YpE//BL2RLFSJiGq7iQAKpf824GeOybFx04Vjfy1CsLAnCS1Z7e/76MSFv2ycHbTlHNBM2sowMPneJRFZbIRvuf3oh+4sM6suvho74HLXFDFeLc3uDhfIQo26BJUouuE0+W3dqvw8Q0A7EfmF8S4sg0YpvrK/9ORJDR8Hx/37EDrrkHStjbprDSQALGSoF3lx/ZXmbCgNb5/Xaoll8pklHDeK1/pVWVeo8EJ0BTMmHrqbTh1UONOuiH28Sfa6e2iHAYdApCyqKFocxs2MKDz/edCKq4z/BoziZ7TSS7nG1kOO5ls2F67tN56YNgcJIC8mVhmGffQ3693pQNbxY3QwEkJIrubM7kXA89RruLjUhM2sM9JnV3N6bBqXIC3wqnyg4zwwLtryTWC83Fak7a0eSWBx3+r26XUpPJA6lyBOs1iQL7SbbAPcpIxAPjltRijsQ6NCTy1A/7ADIuNw3s3+nmzFIsPrhyTiIG1BRJQ/bayH1UzUxOanuodlDtqDYC6nX3tLFuFM
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 23:53:50.4631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f21226-71b5-4116-2a48-08dc47a6a91a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076

Add information to our documentation for the XDP features
and related ethtool stats.

While we're here, we also add the missing timestamp stats.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../ethernet/pensando/ionic.rst               | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/pensando/ionic.rst b/Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
index 6ec7d686efab..a3f7e4d6b95e 100644
--- a/Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
+++ b/Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
@@ -99,6 +99,12 @@ Minimal SR-IOV support is currently offered and can be enabled by setting
 the sysfs 'sriov_numvfs' value, if supported by your particular firmware
 configuration.
 
+XDP
+---
+
+Support for XDP includes the basics, plus Jumbo frames, Redirect
+and ndo_xmit.  There is no current for zero-copy sockets or HW offload.
+
 Statistics
 ==========
 
@@ -138,6 +144,12 @@ Driver port specific::
      rx_csum_none: 0
      rx_csum_complete: 3
      rx_csum_error: 0
+     xdp_drop: 0
+     xdp_aborted: 0
+     xdp_pass: 0
+     xdp_tx: 0
+     xdp_redirect: 0
+     xdp_frames: 0
 
 Driver queue specific::
 
@@ -149,9 +161,12 @@ Driver queue specific::
      tx_0_frags: 0
      tx_0_tso: 0
      tx_0_tso_bytes: 0
+     tx_0_hwstamp_valid: 0
+     tx_0_hwstamp_invalid: 0
      tx_0_csum_none: 3
      tx_0_csum: 0
      tx_0_vlan_inserted: 0
+     tx_0_xdp_frames: 0
      rx_0_pkts: 2
      rx_0_bytes: 120
      rx_0_dma_map_err: 0
@@ -159,8 +174,15 @@ Driver queue specific::
      rx_0_csum_none: 0
      rx_0_csum_complete: 0
      rx_0_csum_error: 0
+     rx_0_hwstamp_valid: 0
+     rx_0_hwstamp_invalid: 0
      rx_0_dropped: 0
      rx_0_vlan_stripped: 0
+     rx_0_xdp_drop: 0
+     rx_0_xdp_aborted: 0
+     rx_0_xdp_pass: 0
+     rx_0_xdp_tx: 0
+     rx_0_xdp_redirect: 0
 
 Firmware port specific::
 
-- 
2.17.1


