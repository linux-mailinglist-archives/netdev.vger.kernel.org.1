Return-Path: <netdev+bounces-271575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIV4GhTsw2kAvAQAu9opvQ
	(envelope-from <netdev+bounces-271575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:07:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE3D3266DD
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C099130065D5
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1493DB621;
	Wed, 25 Mar 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B3RvDqc7"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE533B974;
	Wed, 25 Mar 2026 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447140; cv=fail; b=R3SAGwXydCDq0CaaBXCasVk1lUw9bqb5T0C48rhE5y4es8EKxuzi6JqsCM1PX67TDS8PFbvyMAFeWLWfODMUPVh/Kehcza9gP/g2XZ+yh9dhnsBFUfrz/tUHpST8marQkXWCDiVWx5wcDf4r/zC403OJL2pG7CzKzbGG26UbKQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447140; c=relaxed/simple;
	bh=o6NGVLYh0nhPsP1u/ahOsuzqv+Jem1v2a4jRiJ/rc2E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=flfQFX2jaHkrc5rJVxjCJLcQ/woE6jF/ctPaE/zEk+bhvKDeySX5lwBcgC+qb1nOAW7s1tSs0xctAOH4YoXYr8OsV5Zlf+HMZt0L5xfQfot595J72xtYd7O/DxxqYH2m3atkGT7g7nphMWxXPLiZJ+4VIkSa+1xxous8cLJ4O1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B3RvDqc7; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmZ7xAX2PBQVbukYuIFhaGso4LpMUstEyGifl6p8hvbbopRpgvFg753+w5E/WR4Cg0A0oyKjjvPrKk6uDsdO5gN5Dza8a6rn4TWpLZHEslt8dj4Mo/2sSlMb6Q0uK2Bf2ogWO16ddnehzPbv4d3qtdk3hZRC9aeT33in1lN0kje0SMkgH/tY1xmvKhL3RULwuNChuyHo1ZTFcezorDF9VStaD/PKp/tom3p3gJT/kocrVjYW88SDa4LXpE2kDpGehpR6DduhAHcjWD6aQByTdj31BUFMvlhOPE8O5sJhm3qaOyTP48CVu8uOzK5ZIc9oMaxv4SAthJ8wjy3F2ZcBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF/F17NhDB5ZOXSo7KrCe94UDYQu7IrWcs0jox9vyWI=;
 b=JbhyFYevF2/xWSqalNuR+KgQs+7Hd9jYUtuz8z9FJSdw4hsseJ4nFEa3DRweFcdAnXmtWEkebY1pjZHYTr2VATjHgew/dfvsuQmBkwjBB5EimbxdAu3wCxmcNDHwlpcn4cVR9ETS358YUN7vykPAwbHKSI2v/8bgsdqJdinur2xgA4cLakg18V7ozNi5w5nKLx65Jzr5OvvsHMLLvtha/GEtorhgZT7xnYzxA+Vseyku1Wnnx85517PV20/G+pVX6jo88V3YmsqTrd1EOzptn4G0rnEwMtRYQDGhPLFtIU3V31uqjHi0/C/N6azzthAr04Mv/PNEx2VqImz4Pk2kKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF/F17NhDB5ZOXSo7KrCe94UDYQu7IrWcs0jox9vyWI=;
 b=B3RvDqc744vcbmCTJ63FsqMZmJCBTims+mXdNS0N/zrymx0Ch5SvPkv6HcNYSdvd5VzQRmxrzXASsIQNT5zq7Oro8LonO8iI0g+8lCo8nHAyWRTDfWkELl2hH771KMjQe9M5HJW6Kl8el3I2pkxagEfTNKfzElCGN3OmpSyoOORFyZUK9KmXuZDv4fMkCVu5yJI+EUZjjDJRIoVA4cY/1DwqWSLsrKRT6LTqmVPsZKvm2CxNVkMQqAsuMSdW4EttcBKBjAFn6ZTviAT+SiYlh4THZbKV70kdkgb9Uos9e4qDwxPCs2wdvNSv35gcygbVAZo4HszkUUwy+gNBSta8pQ==
Received: from SA1PR02CA0014.namprd02.prod.outlook.com (2603:10b6:806:2cf::21)
 by DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 13:58:51 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:2cf:cafe::20) by SA1PR02CA0014.outlook.office365.com
 (2603:10b6:806:2cf::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 13:58:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 13:58:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 06:58:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 25 Mar 2026 06:58:33 -0700
Received: from moonraker.home (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 06:58:30 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 0/3] net: stmmac: Fix Tegra234 MGBE clock
Date: Wed, 25 Mar 2026 13:58:08 +0000
Message-ID: <20260325135811.148480-1-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DS4PR12MB9612:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afe06f8-2c93-498a-d2f0-08de8a76a4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	e31CFDxa4nCHqVvz8t4oUB22IA9gHXSp5E8nQeM9lOp/BOJ1OiRWWVdWTinjl+eLwlsgKgyAgF2t96cduES9wsQye3CrVhkhnAvMVeyIj59Kj8nC1+WJldsaOAwiyyoqtuPfRPmAxmcjncfyEpKz87ynf6KxRFwzKBfebWgskh1z5QO62O9WdxXGgqaUDMvnJZTbeaKi3CszIDL5vdpJE5aMwexSpmpqWCiMxqycQkvheSAIlRNe6HxfC5KqTQJdRT5VghEHc+l1mn7digkH2OZoNNwRR3pTxi8YjvKj/WLnrs91NqJ926i4DeASARWVn9ysHcDZjNP7iMufBCmAqQwHmIu9vzXT1YQzlfoPLC0NPINLk6Q6t26bY2SCwCR6fXGD3vHcXM6oy9tEjPOLASLcB4zikZXPtepwJ36Z7JtCGvfnZlaLAae54TLwY2U2HyEDEa7P1AqQJO1jriJXeKX0KwD5oUC+cwpy/N+7iugjh7G5Sam+iRTEb9dGAfJFWKe8EUEOxhozL1zByubCaruiMoHvq3EMOLCMwSmwBpd2Ynkhp5A9krkMymk7PS9wB3jX/uBtlFCLS1kPJADEOi12euSygMre09CULkxt8xF/AJrqfHHGX+yq3SA9nCtMpyBgT5ecr+bDh05GvstrxjSjJKgnmQXAMG6GXiftcKX51XzXvTmEed0WUUtKXQC0hOMqQfrjwldyrE+UwPxJiueyEU0KFge+Dw8mDtuTQMny7dkhbXWPNHn5UVU9BAoxSdYndqVvWYaOppoCFLUyDA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J3ynWlxvLjxwfAFQ+mSWdxlBJN8DZ13uDOSjnax12/4smTPcZwOLSdN3UM+JvEtBOzPnZq0h/NPpFw6eloswuEAKPfTyaH6j2UgWSnneiPjSAcj6ikWMDEhTMfNQKdf5cJmi1J143PoSroVnHiqUXDwBczsDOj5Am+ZmvfflgZr/3jj+5+YKy6WzUklqXx8zx8xgzXqpww5jpoFtTZrStdGPBm71mAtnMUUwWRenbGwgV8xb9ZplkeVwHzz2ENisOUCs7ror5vF4s9mUg6MOt8c2QH1wEc9ApjPv1hsyNbkxEL5G4KobGbDSbLEU0dBoWxZlG6+NzYvsPwRU22a3pC5LgV8dfGIXNAbBl+gQziK1EGE3b4DT/obPxzk7mXSrQH5CcrTAc0MHS7nqXPynSX+ZM2AcK9x+7FRpJq8UVn3v9weaX6wM58wIbrAbG875
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 13:58:50.6105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afe06f8-2c93-498a-d2f0-08de8a76a4b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9612
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271575-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4EE3D3266DD
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
 .../net/ethernet/stmicro/stmmac/dwmac-tegra.c | 19 +++++++++++++++++--
 3 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.43.0


