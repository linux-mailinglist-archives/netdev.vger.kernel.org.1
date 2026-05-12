Return-Path: <netdev+bounces-286961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO68Cr/HAmqWwgEAu9opvQ
	(envelope-from <netdev+bounces-286961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:25:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C445051AF2C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 592CB3031AC0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BFD43C05F;
	Tue, 12 May 2026 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="luX6EUsI"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6AA2FFF8D;
	Tue, 12 May 2026 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566016; cv=fail; b=AT27Jr+uH85Px0R2UnulMHSXMB5aHkZ5cta0MZmgRsRxOFsWgZsE8KUOYyDzJsiVhpXy49lIQctDECM4xlE4Te7yhrC4w4tNuKOcCCuS08fXK8jXrSQNjTfNe6nd21jTIrui+OsXWDrXblfFClht4C2l7fl3ZhUHBLNHnu5YCsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566016; c=relaxed/simple;
	bh=0DO/Dxp7JizR/b2L5K7WDmV4rIOYZsWwpWHS/OIHRFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fXcBws//IE4GjFF0URAFz2qI3qLf4Igu+klxbUJXvade1S/jdhY2VaPpU3M+Cm424lVbsTRXKmRT9u53f+yb9qZUtKcdX9oorouaN8VaUgqd3k6uydfd+5v1uaUtxCwAI57GXKrRiKByhQgxn+10hl5hIoV7ll30tuqNWw1QcYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=luX6EUsI; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYrpiSAp4Ofuy0mpg1Gtxy1CoIZ4P74q/9UvGXq+IRJR0MuLeHQwGB2yf7S0/b9tYxxC93wAI11NPoN9KsH+XHs2lSa0brToW4gLvCg5VAzM/4kJdJdSKy8kOHXeE2VjyhDs1Pv/lxF+UOnSe/msr+KilaR9HyOKjQINePcG2U/2Bi9JAU1fngETzZj13qeeOAPZzzdppiDTAGk5Cz7WL4Jwg8aWwoomo29uEc0z3DOGLFlhiqphmBCa8DaXWUl7HXcb0HiJaUhYk8r0ynn/X7ZP8BR8pbul42JTDONT/ceGGBxWHqk3HNWIea0sw2+KzjdKDmdb8L2WsMRMZ4gcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFrnVx2vClI03GqvL0LNJR40dpFSDsq4E2xv5pSAFaM=;
 b=S3ak8oL7WOiHKo2+0FM+S2WbX/8r5XYZt7MwsBh1bL7RmqigQgvBXcjTLWhTzhbGqOizcarfnCLoXqNerDmtYHt2//r1Mv84WN5uhBkXzdPFtGaYaSfNM6MJdRXuqNTVkACpFmnUmy5p1EO+nT0TZ5sVgXoUrXWgdyGwZfNom9OAorkyziKO2NkZlp7IKbm/aR8Jt0s5pKUMQUTSUfXXJIsm8ddbvRJ2PlEOKyUDaS8H5xwBJLSVM/ZFtxHWS4t2yreY3sIVWD2FEA4RU43eqz7QwAfl6yu92HgFvsOarl9U7er/uC6HyPpEiwJO9eCyjFNR4A9sWyoqrO8RusdTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFrnVx2vClI03GqvL0LNJR40dpFSDsq4E2xv5pSAFaM=;
 b=luX6EUsIkG4+LYFhersOWU8xJGYKVElu1aG8dJ6N3OVCA31KAZJacvl9oIbGzt/vqCsiqDiq0gL6tVE3uEFmEbSK9wdtCeHKZTZUiQHOr6hh5jD22ChzmLM5U0sUqcDd4r1HTfWKUxJVmxGDZP3V6cBdOgEfouMusbHQtSEClQk=
Received: from MW4PR04CA0188.namprd04.prod.outlook.com (2603:10b6:303:86::13)
 by LV3PR10MB7915.namprd10.prod.outlook.com (2603:10b6:408:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 06:06:36 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::9) by MW4PR04CA0188.outlook.office365.com
 (2603:10b6:303:86::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 06:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 06:06:34 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 01:06:31 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 01:06:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 01:06:31 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64C66VmN1179435;
	Tue, 12 May 2026 01:06:31 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 64C66TPO031898;
	Tue, 12 May 2026 01:06:30 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, MD Danish Anwar
	<danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jacob Keller <jacob.e.keller@intel.com>, "Meghana
 Malladi" <m-malladi@ti.com>, David Carlier <devnexen@gmail.com>, Kevin Hao
	<haokexin@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next 0/2] Add ICSSG firmware stats related to HSR 
Date: Tue, 12 May 2026 11:36:25 +0530
Message-ID: <20260512060627.3781329-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|LV3PR10MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: ce920ca5-4fe9-44f8-da89-08deafec9ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|18002099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info:
	n0A5p7bnDy2zmZGUlF+wpiIzTknbmhPpXcmQoxxPvDLwfushtetwKnsVXFYBpMsR8BzhPwqg1TIoycjzP151V/7Dq+YXVJuENV9aqif79I1cybWOXxa8YytYpCkszZV4b6RyJnv+uwV82YqYVt6Lrcau6uP+dnlL8IX2EwF3gpzp3+dY2V/iGn0m1ar1e3+Jovmn9h0EVJD31dPv5tngiLcrNIyYUvhgJ/ZlfkGCb71bDS0oIXRevWFuqOhQD1xc8yzMErFGQqsw38HRC/ZR37orNftiNgHlEwOZjyXJ0kaniLnFhT1m+otFhwI+MxMj1jdmLIdqUp855UUxkoJ5v46ZKvtEjTtVtrwhNw1oqL3dTtitBksIF5ELSJVSh8Ufje3c94YEZFH5ckAn21AwGKlZgQaifmvPCaUSzvl/Uz6v7LpRY0P58AhL6JkYqVm1oOLdB2QSGvggzDwZfTnvdW9MsR6LyeCANblA39j1kzyCPFPbGmnBl/mcJvJ5qhby5J1Lun3G/qbx4wOx7XAsXpXAyjOBDFDK7e3NPk0U90t8m5arNu2/2AdSx6OwYEEX1ZuNe8ryYlD/PkkMrefbTZkHVpou+rWwqgTwPtP9yb5++4PDwh5YhJt0SitBiZvB4a3N4SdW2tFl+BadpFBJ1NxI2RjA7OyWfwu8N1JPESyrIC2v0Tft9pDWJ89am6NUzTK3BuAx4TU61o3+YD+vqYcnUDoqHs5KjbyfgsNH21RgtdiCVhLnhzlZwH32/WXmpCQQaRI7IPCDYpL6GhFHiQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(18002099003)(921020)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CblPtD5brRD/WUK1xZZt6v5sDvUDVsey5bJaDNhDan59eMPXVOJ2qwcNhBy1fZzncGJoL04Q+hsGjnl6Y7BLa4svduD0I7pMLCFYzv7xLAFlDOQieUqi7t1KryGljwZTTjDn/sNg9TBwwG6kLcoNDhIv61khr3B/uN+JPNLNzheTK/badYpVOV3jUu6JukqNOlx1UHsCXXVSmMgwumQecTA3K+DP8W/lUL5KTE6CJGtnr0DhwMYhRq0u8OAKRdYal5ySV3kvOpnj6OGcfiHEROYGi0j1wB4XFDynZ2W0maYj7KdjKIJshomcPkzQJywqZaEESzMtdoJy/RJeGkxAYN87wYJJjsfJYtIPg/gjcQHj81lEN7VYmHpfU/1jGJ4E5sjqKKtetS0TZlcpihbfsQ4CokmEcZ9CP+GWYBpRUgtbEG/Qed0a7RH19z6MbcKV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 06:06:34.3828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce920ca5-4fe9-44f8-da89-08deafec9ed6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7915
X-Rspamd-Queue-Id: C445051AF2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286961-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,ti.com,lunn.ch,intel.com,gmail.com,linux.dev];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

This series has two pacthes,
Patch 1/2 Updates Stats counter to use ARRAY_SIZE instead of hardcoded length.
Patch 2/2 Adds new stats related to HSR / PRP maintained by ICSSG firmware.

MD Danish Anwar (2):
  net: ti: icssg: Derive stats array lengths from ARRAY_SIZE
  net: ti: icssg: Add HSR and LRE PA statistics

 .../device_drivers/ethernet/ti/icssg_prueth.rst | 10 ++++++++++
 drivers/net/ethernet/ti/icssg/icssg_common.c    |  7 +++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h    |  3 +--
 drivers/net/ethernet/ti/icssg/icssg_stats.h     | 17 ++++++++++++++++-
 .../net/ethernet/ti/icssg/icssg_switch_map.h    | 10 ++++++++++
 5 files changed, 42 insertions(+), 5 deletions(-)


base-commit: 63751099502d10f0aa6bb35273e56c5800cc4e3a
-- 
2.34.1


