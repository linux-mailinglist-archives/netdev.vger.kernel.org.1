Return-Path: <netdev+bounces-168900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0408A415B5
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 07:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F5D3B5A98
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 06:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D7720ADFA;
	Mon, 24 Feb 2025 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mwI/x5v6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6823F42A
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380025; cv=fail; b=kkm+Q3Ib3Fxa1IPOCVjv6xz26cGHAJO7ivJ94/QgwSzdCoG8vm7AoPIS2qKWJMF7TQtzy9Jvu97D4OJ5F0Jxa7JtgJiY9DMCNQwlfKuJg84938P2xieqpqKBoYV0zlk0a462LctNn8lo7Z/ksbI+QC1lLt6/s6HIAwE/q8x2N68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380025; c=relaxed/simple;
	bh=GdR2t4DVcZQtrn2Gzs0HcCwAp2+ApKYSjLMuEsjQolc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Er/oUfrOKSSpkTzkbl4EvhquSRiZnCZvkyQkdntVyoA8iz57T55eu5zPa2om1Z019Cxpp5WcstCAS86GSR7cjV17lRu2xHq9NupzaWAbi+YGfZCU4MKr43XQqaEN/r4xC3zQ3q1FYOvwZBprHlf6TUdQkvHd3Ut+LZd0IeYrun4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mwI/x5v6; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5F9EDs1Lx6/etub/bTwCo6S+xEiX4xMfobCGDZ6LgIQ58ZsJxXGrFSD9mPgjhURFBu3juyYORs8vnV1z0xyN8bMH6UQO70e/dgVgb46w4IgeRfzKPyg7jaGV24Set3CTUuNPBHiHhLStz3ZaHQBh3aNl8nesuyXBRJ+RdBT+o3MFEwwYmZPNBNuHr3jWryELSs8yDARMFaSY0+1gtgF1TT9DyMjsQzlS60sDMwXNU8qAi82x7dSKlGJlOBwXoc/1vzw9PeMxOb3OOalv0M9SxB+cBLwFj1I+lsQWitvpC3Eo8aGXontARhrwivNcvJf3LQF15Zrg20461k9ljCqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRu42XQcDEEOOr/Ocxc0TXQicsSkUMq1VNw3xiVoPeo=;
 b=sol6gNisiQl/HsoIyhUdpPncZ1cvvUFnXyYzsOsvDkYT0b415r0KOK6pmsE+u7EuKBZBO//jS8BXEjGBTN0Rs0rUZ39l54Na8ZdewFCmv77GMQ94DDt7NCZE6bko9zRXukMX9LGs4LYlvB5FqExJqwP+V7PZdGcj2bZpXgsCQ/E2N/Dwo9psvMPF8Pj3f3sPu7m2GJxl5jwW6UGXfXFF5pdEY2lRwIo/43Vex3UBBFvInvru6Wknyd1NqfOqG2iaYomwk+ZzVMpg55QOpZNGnyU8ik4Y6JCoERT3A/QXzHDiXOhgH3OfqoP5KOMIplgx2fl0ywQKPA+Peg+wCC5SHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRu42XQcDEEOOr/Ocxc0TXQicsSkUMq1VNw3xiVoPeo=;
 b=mwI/x5v6rNo8oCliqq40MYJXBG97PrW3TOIdP968oP+Q28/BC+3kGSbzac8plOTQQ+ChokieHyKEX634PYVKUvhlTk7Td11Pc1fKoV6zu/ESNT46g/rUlIyqzoDBfnhZ2T7Y2hu94FVUwpeAHGt6km6+KZZVVygAV3UJIRAu7lcMw2BXAOntQJjJpdezcxS8WeLegp6qurnAG1rC/TSf0PcB/jz+MJXG2DQI0OS0pZbOHrfa7znZlYm6EzErkHpMuXexzy6FfYtuA7msJsxl3z7KYr+rnJAika+ingQZK37NlRek3vZDkk0eWqMuf1UObkiKaheYE0JTWFeAzLhD0A==
Received: from BL6PEPF00016417.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:5) by SJ1PR12MB6217.namprd12.prod.outlook.com
 (2603:10b6:a03:458::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 06:53:35 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2a01:111:f403:c803::) by BL6PEPF00016417.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Mon,
 24 Feb 2025 06:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.0 via Frontend Transport; Mon, 24 Feb 2025 06:53:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 23 Feb
 2025 22:53:21 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 23 Feb
 2025 22:53:19 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, <dsahern@gmail.com>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 3/5] iprule: Allow specifying ports in hexadecimal notation
Date: Mon, 24 Feb 2025 08:52:38 +0200
Message-ID: <20250224065241.236141-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224065241.236141-1-idosch@nvidia.com>
References: <20250224065241.236141-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b876289-cf64-44b7-c3e9-08dd549ff56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HxsQ9IObTXbPacCLFG6elsi8V2qwsy64MflAaEoAwt/2Oa57hd/HZKMVpdAL?=
 =?us-ascii?Q?uTMs71A8afrJIPmLAB09XnYuMWcjnPRIUWshyczqPmxCDgPWzinrdYCIWRxW?=
 =?us-ascii?Q?BXbulf32pOur8qCQ40t1j6Eeh+Ssada7h/JXJt1JlogmPNsltK2/RXIZWM2g?=
 =?us-ascii?Q?5viPU7RdDH0xhAS/PZyCgp2pXjKCgcPKMAEJoIhbwN1eY8VqCyB5pOf9z3pI?=
 =?us-ascii?Q?dpLldT8/MIZ4vENs5CTW8ULUnS7TDWnYpS/kVqWc/Oy19bPjLzfJXo2kfx+v?=
 =?us-ascii?Q?ToQhzXX6s6j63p6MJ0rim/Ti8ZqTJOCYv9MDmAP4zXBT+o56zBBeef3Iw+2s?=
 =?us-ascii?Q?pAbKWNJzTKHwTjYdiy6qxOd0/g98QvCssWkJk8kS2RVdD0nUpMFc8wJsf9xc?=
 =?us-ascii?Q?Dk3m4VXNt4KwQitUZ2Upv3vDCJMTfBly0j8GYepk4Nj8TCgIP2GiIOvbvzjU?=
 =?us-ascii?Q?uHPPNbx6C0+2V0QCwV+L79Bbt0Se5M7gJpoyGWmtiYHxGn1b7aryRVVcQfZO?=
 =?us-ascii?Q?SkOJharGbwty36d17lOKd9/s5e+Tl6EtkY89sFwmgNJ2Z3aUZsmj1NnyBpEg?=
 =?us-ascii?Q?vB/4/eEQb2irpznhui/9FXP0o6Ft0QytpnQAOYMSV0PNiF5mSNhbnP8KR3Xp?=
 =?us-ascii?Q?VGk6vmvZAdzUM3791JMHsTJhjBgse44Rjk/gvn0E5kiuHZ9YhShdHW24UcLS?=
 =?us-ascii?Q?h93iong5zfhk9pGStRHgxUv0zbJ1LR6Nr6FZlNdGrgs0yM5+6hqjz3hcs8uI?=
 =?us-ascii?Q?AyOFh87wU642U5vKEex9vdyt3SqpprIXwykGpXcCQnHJDYXzDZ7E/eU4cDgm?=
 =?us-ascii?Q?WGt2BJdnvFCTgksygwKPj9m8/uObh9xscpXaktDx4CgiDcAKhoDi7Ti01hMV?=
 =?us-ascii?Q?CGlnG8R0BnaqM37nPvKCBh+D7NYpbCDNXuwYKxkx6HzgFxxMA7GNLed3EsEB?=
 =?us-ascii?Q?IjfzAF4CORgKc8IIKWTSf1c679fRm325sI4uyD1bikNn6yVDVG9iRJU9Ce7R?=
 =?us-ascii?Q?PQdUjF8T2dJgRXuubasB+pS65eHVEKwo3zhpAb40enBRl8qEgAa005a8Qdu0?=
 =?us-ascii?Q?oy4scJIg/Nml3NHSKhFlCrh8a4hyxE8CkbzpuhICsiOdvviRVtJp5jrANu8A?=
 =?us-ascii?Q?zdezN5+qW+uSe7qWJbDrjyQuqYfmSkI/ximCYYOnDytALhf4u0vFer4TVOid?=
 =?us-ascii?Q?9HcgqE1xa99lDl1PJzIkqmXjKXVWoBbHWGIa2wi3B+P5S7K0DApC+jI4N7YE?=
 =?us-ascii?Q?v7IduSxlrzUxjAdIWpRMtwNaBN0Qyy+5wq5PkuRIvEytYxFhEKyAJoYLMkrA?=
 =?us-ascii?Q?GtCWMgrqTQeA0rHGdMJjs8GeZ6kHA7CHt3N808SWqoFI5cJ8kp7MbBhOXk+Q?=
 =?us-ascii?Q?UzX+0hFsJ/yNmKUK6kVMi3CW/lSmbVwXuNSDhwfm6W6bi8dx+/yFbWQBIUpi?=
 =?us-ascii?Q?33aReNDwZUBJo+JlCQvxlsdFyRXTY5KP5JPebIarb4fdI695VsYkBjktZCbh?=
 =?us-ascii?Q?sMgPVoVsFvdPvNQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:53:34.8723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b876289-cf64-44b7-c3e9-08dd549ff56f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217

This will be useful when enabling port masks in the next patch.

Before:

 # ip rule add sport 0x1 table 100
 Invalid "sport"

After:

 # ip rule add sport 0x1 table 100
 $ ip rule show sport 0x1
 32765:  from all sport 1 lookup 100

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 ip/iprule.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ip/iprule.c b/ip/iprule.c
index 61e092bc5693..64d389bebb76 100644
--- a/ip/iprule.c
+++ b/ip/iprule.c
@@ -608,16 +608,16 @@ static void iprule_port_parse(char *arg, struct fib_rule_port_range *r)
 	if (sep) {
 		*sep = '\0';
 
-		if (get_u16(&r->start, arg, 10))
+		if (get_u16(&r->start, arg, 0))
 			invarg("invalid port range start", arg);
 
-		if (get_u16(&r->end, sep + 1, 10))
+		if (get_u16(&r->end, sep + 1, 0))
 			invarg("invalid port range end", sep + 1);
 
 		return;
 	}
 
-	if (get_u16(&r->start, arg, 10))
+	if (get_u16(&r->start, arg, 0))
 		invarg("invalid port", arg);
 
 	r->end = r->start;
-- 
2.48.1


