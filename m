Return-Path: <netdev+bounces-265332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IwYBTvMrWkm7gEAu9opvQ
	(envelope-from <netdev+bounces-265332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 20:21:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3BF231DF5
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 20:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E2B8300E702
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 19:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0563290A5;
	Sun,  8 Mar 2026 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DKAqOXGA"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A79284684;
	Sun,  8 Mar 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772997687; cv=fail; b=Pxy5pCGSdVGb1zXts+McSrgXOBrSuk0QF5Uz1PVcEElIpWkhddNJjMQ5jQ8jrTzQtN0p6m9xM1ST+vtMt94+M1Avn5bojqhbGztGlEZ3XW2qidEU+1RtL3L0QO45yqb/G7mJwPZb8gqdJpxIqzuPLx/IwXJDifBRcOwxGn4c+k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772997687; c=relaxed/simple;
	bh=p6rf/HndQVGI2UZZUpWdSTz4JpwnGCHVXFk/AjKQwPA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qiZI4SkAY5LlwJ32E24K86eesoeD6llgaOgF6+E/aXnCJ3eRpm4OuPLwzG7j0LU4RxNBFuorh9shAJ3DHkWccKC1s9d4eXAPJGwruQyy6dJxMuqmyZk3AZUpDcoey/mxAH94My4UvV+26Gtn1DL54QqWeEPgzZAUefmBq00vb5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DKAqOXGA; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeOwHfIJwBjPrVTpKd1Db5CbaEb8s7BXQXwiMVyDPCiFta3a7KHqrYLZyynBsVumuBNQFltDu+UeetXo7lOzIswRxh67SuDGUtP+I3nJsDB58lnztEzJvkt4n0We0m1tG714jvFutbvl0QVgqRfZnJID831bbRvvORhOUEVjzuavbQuhRJjghTnzFXEYWXo1QUjyx1OZsOCxiFPb9VGEe+Wx4oCF2M3gHAZBz8bD5gPXGqr2kywDtuWDHVuiOTYmhWH2hUgMg0kSkxXcy37rrtkWSvT/BxC8hje5CvSYWcLRVYlYK8IlpxX93sVPoxPqVbl4JE5m3hEkMbAF1l8eqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2rKzAxZNAO7gRi102GnmKlwKUxdzKZUvghRtBT5APM=;
 b=e3l2qKXqIPNVe6Cz5qK5Sy/nGnpmf6x2k+K5Jb2D0zbY1L5KFtvHWDr+a2Q/Vh55BDvTvSU4jdFGpgOPxtzFZqMtcZNXNEUeRvgurOG6Qjgoec2/WBUhRfWtaFGMzj2I12bdxcIkfBodiL2P9SVotFUdG/oiU2GKLfrv1HAKQj9nLgMd33avo6G2StGaO1ECg3OUvo3e8K0gfawPIeaUiRHJLBTG8ZWXWwTstPjtRdADs5mi1NfBTaXk+qrRAldaKIst0evitN+zjEoffaS9OBLYUl2fw1BPHJ4bYggX/sxCTv1NCpRNcy8/poTYoHyy+r3R23je3U2RDtA3ccPDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2rKzAxZNAO7gRi102GnmKlwKUxdzKZUvghRtBT5APM=;
 b=DKAqOXGAibQxM+rjBNLFiFmEMqQjI8FWwcTj2KSWbuAf5UK8KvohbPO0EIQYSh5v0fDAQ+5W75PVncbywJCX4allntiYx3cRpOY0TqnUFrrYkPFg/yGzKjtwHJuYhEe4coAUn3yG4vXRntzVqv/+KG662H0s9HhPyrDR+sd4jnR6D1OmGKkXzo9FJQw6VkZk5EFsQEfT91JQB1H8XRyGlxyW6NulVzXRoAxLYxw2Eg9PqpyUq4JWohoAKt7rmumT22GgtFXGDyIFkHJD/VyCFhZNJcGmcGbNpeDqSv065Oq7dvJ3xtk1eaAeulBnIOSV4MryHsRVrxuuzyEU3dpOuw==
Received: from BN9PR03CA0077.namprd03.prod.outlook.com (2603:10b6:408:fc::22)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 19:21:21 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::7c) by BN9PR03CA0077.outlook.office365.com
 (2603:10b6:408:fc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Sun,
 8 Mar 2026 19:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sun, 8 Mar 2026 19:21:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 12:21:15 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Mar 2026 12:21:14 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 8 Mar 2026 12:21:12 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, "Breno
 Leitao" <leitao@debian.org>, David Wei <dw@davidwei.uk>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net v2 0/2] selftests: net: fix cmd.process() timeout handling
Date: Sun, 8 Mar 2026 21:21:24 +0200
Message-ID: <20260308192126.2490631-1-gal@nvidia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: 702ad2b4-c9bb-4e29-6b10-08de7d47e082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	Qv7Dzn3crTvl7y6vygE7SKYiFCpUAneooTqBUDn0Yd4HICTLC/RrHljulSaJf9ZW0tG3qyAFBriSVmjc22RC66Cc+5fpWv2jY4VNwsFsMB6Pw98IICWak826bTMTjXhJltreQ6pAuxD1qnOysbGR9DQGM/5o9PJ0UnnG95FprKVABw/KqRKskbpfByhb2VtjD0Slp8DEK6kXKkqaR8tHEs5Rq6mX+MMM+iw5Bn4PcVZMVgv6yh2n6brduqc5eGQuIAHUk41M9h8V3jex/JH/bC52InPrL2QpZkrPhGF8UaRIwz+4pTOXjvk/0mTySGQ/kyCWJVu9PZT4ygpukHjmzATg03yknn3Er7/0ns7V47UhMdXOqAeTlleEac8ILEFbbErIlI9/Fl8AgdxpUU3aVKrzeF+YtdpMv9e9fZ+MTzfWSr1pfT220yrCgddFgkhXoGeK1WTc3WazYSYvT2gViLs/3D4nw93Ceo/pyb9KjsdOfPOCzZQfQcoGqtMzaqc/GJCbejZFmh1q/MmnbopVWBLZn6foU+ntPbA38oRHi9Q5egMFgPLPPeyjFLJrds1G3HmNZQl74PS6F/mEawQr163kHmaLiy0o76XqHd5SY6XlvFG28Fsrz6AAUNbFeM2rTUColbL5kMp5JB8baMh8WRYoON0GeXYQ65cfXRlUDTDFdA1+QLNiexkEgKCMNKy+N4QgFuyeWLqeCNbT+Q+a/pLV/H/C1D9xcDmCH+94c53ifo19JosaBXpH2XH7UA9uLSZ/bdxJgD3DZw9z+rXaSQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RBEMnykVGWN0inrMrz6v9xQaOAsIrrDPXADOp3AigkYtakEwGVZ17CpMO096sfiEYhBrUPBVbf9XY0yBmjBFAekaUKzBspTlpGAJ8jAK3qtWKz3c4Fq7FA31nTW6Mz2AEY8skqOj9dwp1PS2RcxpAKB8tDYOad1mpFGL5d6HZkejFP/p1gQ6W5Mh0VswFl9pbGTibrlnldRPwJsorEzmScJTzrz4k7IdmfdbKkoTHMARTki+9bZ2DtzXXF9GJFMnONvw014Uksc2ZgzTUrqDhrV2hrpUCu9TIywNqQF9WV0uL7G76mw4PsRN0Ndch9vvbtzXpTEcielkmaUAxov4U7fImmL0OzcwQv9oYZ7IHfV4OwtZEiHA3bRYBDePR2464zH8lZogtwH4hgU1WFe7lDovgH9W3JXmXEPArCqp/GYEWi/QMN+SM2eWzVaq4vSt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 19:21:19.4063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 702ad2b4-c9bb-4e29-6b10-08de7d47e082
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412
X-Rspamd-Queue-Id: 6E3BF231DF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265332-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Pass the timeout argument correctly in cmd.process().
As Jakub noted, fixing the timeout broke the bpftrace() command in
netpoll_basic.py, so fix it first.

Changelog:
v1->v2: https://lore.kernel.org/all/20260215125149.2106612-1-gal@nvidia.com/
* Add patch #1.

Gal Pressman (2):
  selftests: net: pass bpftrace timeout to cmd()
  selftests: net: fix timeout passed as positional argument to
    communicate()

 tools/testing/selftests/net/lib/py/utils.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.52.0


