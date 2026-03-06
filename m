Return-Path: <netdev+bounces-264760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULFnGYTFqmnVWwEAu9opvQ
	(envelope-from <netdev+bounces-264760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 13:16:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E82205CD
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 13:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA7933013D41
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 12:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D01737FF7F;
	Fri,  6 Mar 2026 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JQGTSNUT"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032AA37CD37;
	Fri,  6 Mar 2026 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799072; cv=fail; b=PxzQ7PGwfcAtnAgFuOcQqqQXe3X4OtJHXs7rjHXrhtN5cP53Hd6FfyK+DVhZKR23nNQG8HT+IGgXw1ZnFcLkmZb89o8RXJMuqF4luJtCrVafNCXXTYssFBRefN6E6bDzL0W87rn4j/sYmadCXGdSDSqkgO7XioY189rOxwfW+fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799072; c=relaxed/simple;
	bh=JPM6j92NAeekZhbtP1q87149gQ+uhjs40m89OqPIZGg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LXHLhJ9qjSf+XB/mKfxlAwWFyxIPcYq/UETBOb6mEPVLg2VQYyVskem+adn4ZjOnpHXxw0cY1NUFC59vcGsGtsoUK1kkGK3HWjKut69pF75TLi9pt7pb5esKrIsBLqBCNfWnwlLaRSfCWQumadwyWVQHDbuV+Q6f7b7NXtz75SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JQGTSNUT; arc=fail smtp.client-ip=52.101.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkFHDO/H3M6nqMn527jGQuXx5bvjVuya1icHmH08ywMD6vy2PxPcYgH7LK5hDORgoQs12pYeJ4+2gU4NhS/3bON52vO8fNm2PHwumMCZGaIKHXcUiUb3+SxUXW2xqo8RSeiK/kAaHJ27JCaw2+mx7ndECnBJ9ICQe0rs7uPQz+eZM6pBJG5R8qusokh87mqcFqSZZ3BRpJV1+qMXL4rslKLacpu4R4EJnLES8ArtCmCfBgvOgihRY9iOKMkT+MtxM1gi350kpIE5RlWbcZ1kBhBee4L/VfjSC3lq3fSylI0dzN6o3vHvtAbe87t5Kp7o1MhDGBjIiWBPOs98bxYlEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJw6X5NyUwodtCoLBzQHI5zxrETbxdoReFC6R7I6t0o=;
 b=y74QMzhXXUhvQM2Qu2y9H5n3qPsBXxhIGdDS/r+i2LBEIDWRvjW+lbYzeFdorpP8j0CCFWQn+oJmVZduGsWDD7Lyq43z+P2hxUNqsvOSjgmxvdbzd14X2oYxcyTADf/rz0+jgzBNztVjVYzm9n13bYWu5gCoEJhmoHaOIeep7/0qE/7Ih/oujzqzo1NgoZfy3xjP1pIDdoFTpBF6e88xkGtnmj3Wk/2X+6EiaLDHwG1+n5hNad6ah5ExUSKImO9QCA6LLGdv7rDfNLUOAHwUm7bjb4YLw02SbyTZa4xIKhBiyOGULn1S3fVVK54AjlC3+bY3ky/RbQI8eidWDFBeoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJw6X5NyUwodtCoLBzQHI5zxrETbxdoReFC6R7I6t0o=;
 b=JQGTSNUTYt8fMBA61+BOyMD/bz4hCRjP21k/lRav617EFArAK4Y0FnIfN3h2MHdS9y8Opb4sZBQ3rBZh8bfE8TfMMJ+MevfYVgZKJPIsPc7L47Jb9f/BxTZzDWCOmrgPzjZWpMfOR+JE0E3tduhz1IHykgnsf+aKaK7oQcJl8EU=
Received: from BLAPR03CA0112.namprd03.prod.outlook.com (2603:10b6:208:32a::27)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 12:11:07 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::2d) by BLAPR03CA0112.outlook.office365.com
 (2603:10b6:208:32a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 12:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 12:11:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 06:11:06 -0600
Received: from airavat.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 04:11:04 -0800
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 0/2] amd-xgbe: Improve power management for S0i3
Date: Fri, 6 Mar 2026 17:40:45 +0530
Message-ID: <20260306121047.1231755-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 1725d662-c60d-481b-dd50-08de7b797203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	IpXIVw46D+65kQldjRMjqWwUGRWLD+TE7dyvqAfdR7OPtDZXfky/87qB4ofFkzSa5in6dWV30MG9OOxfQAEeNgiGifSQ3hccQ6eMgXNJOyJCWuBTX6BQ+CXZQfBCVSyxsvOY0W67qvr5yY48yRbvshiYoYaPwHEwNNcQabemP9mqL8cXyoVVnQ7U8Z4zUqxZfOATVeqY1hVgAZXHOOPTZBnztTojla3bKiW+ivXNgQfjJf+hi3EZJl0v3RSulptvz/d+YAu9DCE9QVxvqjtBkJPFE+72xOpytOHyeLArnMLIC5o8OnZgPh0c9Dp49NMjLomvh01TiWg8v6UOHJDrcsLxz3okL1GMuZQFGv8gJYdXU4tayqw2vUuVNZldWzfiEgNxp9H6Y83bDli/5OvSR7Ky8Aq/9oR9EzSWNI6c8a1oY6fOrFAmgzbCWjlm1XBDgoRHM+dBdyD8pZQVOw2eEdkGCiQ+m4zRWJxhC96jJtr3QWI/a6gkl6xvdHDmzpYiyTUkhovEjUGtow2etTePV8CQhi0mLiorgJ5PSIp4Vw4WMGeO0VeKKQxiw7UDAT85Yu7xX5cnvORO8QFyXopJ55nXtmADk3wwRK/KNOJNV/QYLgs0/x69GyZ0TAH0qYSNw02ooGRVwEXAHDvyPy0ApnsDsJXYyvYnN8IHKILF2teVHmtq5qFtGFoFsa4bQZKg77DAI9cKY9JtYs8w2JiAg5bvhTpiYlA7JDw15LOf2/YixngrBVJjobE1Y4ldVRQWBFwf9YCDQgLuLJ4ppeGg3w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WnrM3DBsIpd+tIhN6TOn04Edi7cr6u78+q4CJhze5EweuBuJGA6t0MHBOAg8sy1m5/OfKLk4//Q/eKLu2+7aU99zjknGctPwzmuxhLtpuF4id2Nf6W/QhJ5OwYY7egEP886w8ehQQHf2DzPqrCciIguGB+xQuYl2d7zpy4vzZY6EMoXKJjQP2M088VrrZ0pRy9D6hJgvTfLYdJBF3lrMQBWG5CXAQ2L9Oq/F8G2tkIQ8E9F973/TQOR3Llj+uUuEgFhw32e3RBkHyzARM0OTQJ7LDeliR7CP23bKbiXbnXbB0FWXHcRsM73CP9CzQTeJz3O3T8cNE/4+1SDb5ymynzFc2lAuvdeEQUjjWzFKLSVekCDyF+Sn+49vsyWt8vFVQuFqUiIKGOvPCtXE0SocppYbkR/T91Scpn16asm7ktgaxvae41NKVo6I1Ra9kf9h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 12:11:06.6869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1725d662-c60d-481b-dd50-08de7b797203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020
X-Rspamd-Queue-Id: 059E82205CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264760-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Improve the amd-xgbe power management handling to allow AMD platforms to
reach the deepest suspend state (S0i3) when modern standby is used.

The first patch cleans up the xgbe_powerdown() and xgbe_powerup()
helpers by removing an unused caller distinction and aligning the
ordering of operations with xgbe_stop().

The second patch adds proper PCI power management operations, following
the standard PCI PM model, so that the device can be cleanly put into
D3 and resumed back to D0. Without this, the amd_pmc driver reports:

  "Last suspend didn't reach deepest state"

when the amd-xgbe driver is enabled.

These changes have been tested on AMD platforms using S0i3 modern
standby.

Raju Rangoju (2):
  amd-xgbe: Simplify powerdown/powerup paths
  amd-xgbe: add PCI power management for S0i3 support

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 47 ++++++++-----------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c      | 41 ++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c |  4 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  8 +---
 4 files changed, 61 insertions(+), 39 deletions(-)

-- 
2.34.1


