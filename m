Return-Path: <netdev+bounces-274029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INN7Dor2zGl9YQYAu9opvQ
	(envelope-from <netdev+bounces-274029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:42:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 797BD378A7F
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EE9F3040AB3
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 10:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070783E8C6F;
	Wed,  1 Apr 2026 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iIoXX629"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012044.outbound.protection.outlook.com [40.93.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240B3DE43C;
	Wed,  1 Apr 2026 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039403; cv=fail; b=lz/Y87lTNtdNhG/rYvIgtVVEhqxtL87OcdtJwTYa0tSMgJlxrt94Aql6dYejJ4vxtCJfh2f4BzV0fPPDPpra5PlV+YaeitOhLL9Dl1DnH8G5fky61JBROe8qc1uAhuVbJAtuKSmT6qQThfYsFSh6+VWXiINmZSCjV6jX7QCEVbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039403; c=relaxed/simple;
	bh=9z2DoO4vlF5ZWUL6PY8p6CcEeKQbE8EdWcUQpHrDfCc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CFW+V7s7JSSZ3D+qBq4NPFfnfzw2nBBOUdifOYh7iZNEsfo+qwuNK020R4fuVoJhOksi8vIDC87Bc13oDm07IapSNvdfim+25hIk1SFHCxW6zZ1oPpbyZETtJSMOs4cUKzXO8p8PgTzFU+bb/dQ0KNmIMgM/AJExI7S1NrUMoZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iIoXX629; arc=fail smtp.client-ip=40.93.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6SKwiTChRVxNJaIyHRFD2QNKuzdz2q6U2qxtIc24eYayojAiaBSEmlHqH/F34AE7A0x3rwOm5rszWIWGXPbqziab3SL6d9SARJgmODQLjorPzdMagqESAvl6bBrQAEVB2vvsdixOLaHyNeBb5cNsLPN3L5N/7klXniWzJ3MIIjPmelSsfZIrFYMyxBBa0CHBGk4FFHpxpqVAnz08cwqZ5hkHziexqNEz3QtTDDfP9zzIi7xv+EuJlcLZliysjygy48e1q/QLyuRlyJq45GUaMiDdsrT3aWXSHh3J09KTMr+Qg0p3RZqNywrcAJeZAWNGjw4NSsfi5ytDI3hyuTZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqNI9tWosoLvpJ553mQqbOhGY8N2OsO/1+Z8Nm8rwsI=;
 b=RxBEXrEt0OsMBHkvR2XvODkBIaiqVEVwTjTK37s+oQo7Ij2dYreDUCQv5pPgr6eWUSD86f1BTyQnLzhalX863WuGwfAn/sQL8o1ZKUQQhJIO5qI9mEgLqz1vclhlTGSStjBeKtxd0uIm6mvpX07uGyID3FBSdo1saoncb4G+SSwqtcx5/ntGb/x7kk/2dwZ+M+VxmfBrVXW95Bdzs3/pCsQkGoDHzChQCY86WlIeSOZ6Ioe//TgGcr6MZiCpFg3Le78QbQg5r5btfGJkL0GJB5bXeF7oVphcz9lujKEoN7Ax0cyWjK4FXkXAgqBP96nmzXi3649RYjtMfjAcU4MUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqNI9tWosoLvpJ553mQqbOhGY8N2OsO/1+Z8Nm8rwsI=;
 b=iIoXX629CXHh2IQ9tb0RL9AWrHFeau3NGvEAFNOBM1tgENFnvKc09z4r0eZNWxcYuHP3g+nwZP5B2BnuyP8KDztrgnhaprHdyqFMN987IA9o84I0A1cu4ZilF+LToUxhw3iBU5eVZZCWUx/wp4Mc6USDl/npsHktBLpg6Ih2NmXzopszR9sNXpqhOPltvG5cVciIFn7jvg9uvaHZT5wXL1v6bt/y8R1ACSL26/W+DOUqmhzLzarSGrxVVn8dI8ZWtXFkyxzGlJi3/QGp9MzxUfiQV5jjJ4b8Kb+eL97eM/kJ5YQMGwKPKx7hbfnt/TJU/V0WSq0KuE66D9TGj+exFg==
Received: from BN0PR02CA0030.namprd02.prod.outlook.com (2603:10b6:408:e4::35)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 10:29:58 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::34) by BN0PR02CA0030.outlook.office365.com
 (2603:10b6:408:e4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 10:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:29:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 03:29:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 03:29:49 -0700
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 03:29:47 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 0/3] net: stmmac: Fix Tegra234 MGBE clock
Date: Wed, 1 Apr 2026 11:29:38 +0100
Message-ID: <20260401102941.17466-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 7234cbc7-58aa-4dc0-3d41-08de8fd99f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	obf+FadFGINSVpIkugnRJhptuDpKdhVii+Nd4b8VJ4fjwACntrTugXnf6pkdf63F0ZkGecYzLsOdhZJsQkG9Z+CotdXqxC0MA6aEmYyTFp1Q3glz37eTHBBlAWLrnt0taUKupzUJGqh8Jnoc6Tz41r5xNBczTulstfcx9yOHcV89m0EYIDtV64AtaiwZEV2fBYki2G6+swhqRfGGfDEYpyek2sc8gYL8ebd2Mdil6cvFB9emKLglrc9MQBIkJvV4a+R+NMbc6BWCi81SEKHs2ABVHIzF7TG/rNMvQenBLjqvcq/7UntR0kn+kEDtnaGnD5m4PsxbNGcaJycWY0gqjC/Gs9QSCVglLXJPpGmNKyf36s+OXUIOSCPaKtmmMm1agBaDqJFq2yTDqXe8FrFTkHzMw7yZh1InH4lMYboHUfFfemNijB/XLX3Q3UIPkdVnR7AbiHNiTcXHgLnHc2K9wikiOVnxw/Bv05Yiibm2KeLPLB70vfYnk5eTGvjMgPi9m0ZHLyQhkZSSKUN55dDkru51tSr87qqZbXcSLNlkoBHG4s7/njQnVzps/xL20DkPj1iGWKPgnIDERNx6H2VUxULb7rrGiLzR7JKKW8u/Y+IR+r7gsGhHur0wL5tj5edfYyWYiKBluapmC0F30w1UFjn2in5DqlSmuH4iPMShJuMQC7gGURi1TqcaecXZ9TnsVk2i0nMZ3ujtyFKmFEzUJVMNiucwjYr1IklkrJYn2yuJYqaQjv29vXbIaGxAE3T4eajFpA6tt7K7hOp0Afxuog==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FUJuBFzDANUM06ytii/mIbi3ZlwMm3gdI+247vJoz4SzzYHn3BSOUr4bAuu36glUooI3A/EnQT8Ydtajj876w5b2oPThu+aX853KhHNXzN2+9Jzi1DmaEh6tccA4P11IbyK3oOvipWl7XVBxfC5nJgbQhU1ztt+jf5zzinb7eljrKDLEz6eQrT2OtnaL8bp8He619qBmy1tZw5n0W5YYiAtw3hpNjTk9CqOama37IRqWH4rj8L7zVGW3NB/ijpBWqEjuupP/o4wbv1L67iVjQNHkSu1J2A+TTfm1fgdWK+jghReZh/GkBpSRCZATTVNP9W4wMGIk7cxsAvz+r5Hq8Hye4TuX1RMcPtjnbyplNPG1knCLgU5iMDctT0NsQmkz1fg9gK0Yitz8wdIucIwCunBdZ/wu0lHCbP/WAhcVPIfzPFAEZuf7OGFvrAVXCdfx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:29:57.6203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7234cbc7-58aa-4dc0-3d41-08de8fd99f64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274029-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 797BD378A7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The name of the PTP ref clock for the Tegra234 MGBE ethernet controller
does not match the generic name in the stmmac platform driver. Despite
this basic ethernet is functional on the Tegra234 platforms that use
this driver and as far as I know, we have not tested PTP support with
this driver. Hence, the risk of breaking any functionality is low.

The previous attempt to fix this in the stmmac platform driver, by
supporting the Tegra234 PTP clock name, was rejected [0]. The preference
from the netdev maintainers is to fix this in the DT binding for
Tegra234.

This series fixes this by correcting the device-tree binding to align
with the generic name for the PTP clock. I understand that this is
breaking the ABI for this device, which we should never do, but this
is a last resort for getting this fixed. I am open to any better ideas
to fix this. Please note that we still maintain backward compatibility
in the driver to allow older device-trees to work, but we don't
advertise this via the binding, because I did not see any value in doing
so.

Changes since V3:
- Added Krzysztof's reviewed-by for device-tree changes.
- Re-worked logic in MGBE driver for detecting the legacy clock to make
  it more explicit and clear.

Changes since V2:
- Corrected example in dt-binding doc.

Changes since V1:
- Moved handling of different PTP clock names into Tegra234 MGBE driver.
- Add changes to update the Tegra234 MGBE DT binding and DT source.

[0] https://lore.kernel.org/linux-tegra/20250612062032.293275-1-jonathanh@nvidia.com/

Jon Hunter (3):
  net: stmmac: Fix PTP ref clock for Tegra234
  dt-bindings: net: Fix Tegra234 MGBE PTP clock
  arm64: tegra: Fix Tegra234 MGBE PTP clock

 .../bindings/net/nvidia,tegra234-mgbe.yaml    |  4 ++--
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  8 ++++----
 .../net/ethernet/stmicro/stmmac/dwmac-tegra.c | 20 +++++++++++++++++--
 3 files changed, 24 insertions(+), 8 deletions(-)

-- 
2.43.0


