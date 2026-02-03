Return-Path: <netdev+bounces-256478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Gc0Bz13gmm+UwMAu9opvQ
	(envelope-from <netdev+bounces-256478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:31:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B50DF48C
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4DEE300EBC1
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 22:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604B53793D3;
	Tue,  3 Feb 2026 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWksQgbY"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4C378D9F
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157793; cv=fail; b=L9CfhKdrpYp8eZ64ANNHkpZ4kAm4jqbdDNwa1DB3jrTeXkBJUFw3/gQEWjYRu3P+poO/4r0fmn+TWki1XynvcOpXAaUeSmz5LglE6HANjrTf8oFbYxyVErsjIxFiT09lzaevgH3T7yUE8JP0NHu/s3d1dmQ5J7Zvp2plv27xn5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157793; c=relaxed/simple;
	bh=koIdumn+bsANlWsTTZsp5+kDwwTSl19CxXHOw04niTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulTNULSclUdmg2ckpTd+hr+sI5NBrbDtVuZoePdr3eC+y/jmGVmB0pgZcTKg7DGLZuFFhxMx5GLV6RiTm8g2uVlf1psBeH8Ldhld6JToGUmjpgmDx7AeY2MDu5VV6tfshxRYm9gg8X68u5N7ouP2S8ZmzNu9LOc2lJpUyRIlXeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KWksQgbY; arc=fail smtp.client-ip=52.101.61.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuhnHOiSgdAgiw1GbZzKkif7CMCOUa3deTyPCsTHcJT2TUdhJSL7JiG5AnWTeJ4GE74GeXJ62MoPa/VpMFN73BB5WzOmhKZ0IjLfbJUovtXtIrS/NbLXwa7mxTQTCZMEjXkyKezSh6gdXYeYFlbYOL0HA24QJ3STSAC//BosmSMGKTz70dHOaakKxrTZO9GlbxKZ15TKyarkMu6FPAU20l2ha22jqxI/Rqp7hisovlpQPgwHJFOtY9cvOFbTPp3D9sG2CLO+GJZP+Hz/uN5FX9rzuySVQKtzJMp3U97oeoRWP9Rd7skvQmwcf7/G8ezufIbbvEppOCO6ri7P/jZy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddNXhJgFhhMBXON1lOFUvYm/6YkkfuIS5fA87IROJ+4=;
 b=a69u3G4Op2eM64p2kZAWFyWViwdNelSeddjjQR6oKjr+U/rKjksSGImbPqAsrQ8+6uEMH8gF2/Itr58TXetbU50udlx2ykfLTOxiklm8zSc3UZvjAWYRhSqDDuRe4ui/GQ1vy5+nm6Mbb3OetbQxIpBbVhBaIRzl2YlPhlCoN5DmhAYkn8dVQs8EqIhgrv6J2Ifg/3/NXpBFhJiboy03VKGLQJ9KqtR9Vl9hOwzqrL58QYbsKGWRV1Yns/X3C/TuqFJxuYZCMB1RASrdSLBpuD0aIOgKwR4pufr2DiPoofNJtSTqyZ8eCDXHsPrlSAyzIXFYglKbbwil9GmHOfzOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddNXhJgFhhMBXON1lOFUvYm/6YkkfuIS5fA87IROJ+4=;
 b=KWksQgbY8VqxBYY87RyfereaNLe9Wsk0yfTZ6Sb0kfiR+UScHa/zNrLbIfXtRX8M0+RRaRCFHlh3K7bqrdt8hi86+pDUcCXITU0VtZiWiAk9//mjyZ4mToyIgjiIPmIJXX2MyA7kggl/3iCbkzXzmzc5PZQKeCof/C/8cH4cZXNHwQmbjmzWTxa5WcfraH1CoQMko43tu252f6CWsvtXnceV1xKp/9LogwhLHH3rseemkUJNsUlMvtJOLicmS/voeIziQ6cyRJouWJCTH1yGRC2CNyu2td5+ZUJF1w8WKJPywkw/B8h/1WeazPfO9R6cUwdCucK1+NUJfnZZq2qZ2g==
Received: from CH2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:610:5a::20)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 3 Feb
 2026 22:29:42 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::21) by CH2PR08CA0010.outlook.office365.com
 (2603:10b6:610:5a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 22:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 22:29:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 14:29:21 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 14:29:21 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 14:29:19 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v18 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Tue, 3 Feb 2026 16:28:57 -0600
Message-ID: <20260203222859.4219-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260203222859.4219-1-danielj@nvidia.com>
References: <20260203222859.4219-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: d86048a4-e3f7-4e9c-6969-08de6373b9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2uBb7W3E/Isgka2M5pPanUHv9Yw3mZXphSSDacZqZpRqiWSF3Pwm3fVDZCM4?=
 =?us-ascii?Q?DDc8Z8i+1gXsV2dmXrK+2y23ZHqekD3+eou7OVqopYutxEgS/kHF8RkL+GDh?=
 =?us-ascii?Q?KaNB26+tlaymn6qT/LDj7TLUQDkwbgA6vorqbgMYpzeUYbTtNwrPt9ISyWS1?=
 =?us-ascii?Q?v81W2MEAKP059R7PYOw5LSbdlcQgN+oh4SZibBtIwamgZtIIh5dIarT29G93?=
 =?us-ascii?Q?y4fkkH0ARVP5O8ZnyO3Pc6Kwku30wARcv8ogc+BEwVz9SI1kTYvpmHboW+kS?=
 =?us-ascii?Q?UccbiVYRD2nuHuodGxq8Pe1B0SPXFYDi+QSIewBRKd/R5uyl044NOXCMXhBK?=
 =?us-ascii?Q?DWBmA8Q9NOLNflsettQ9FgRG6+RYIIaSbuhPZ2lVN2+dYRhugrwwmOECGXOw?=
 =?us-ascii?Q?VTwlLwRDgEM1f6F2glJ2XNzj4lUtqBt7mlG8OTXHxjZVHBWOnPQQHS32UKMj?=
 =?us-ascii?Q?j+Tm8ncQ76SoXppaaUBtqbuzOufE8nxlEIjaEOm3PdUpkwhIzB5aLYd7++5p?=
 =?us-ascii?Q?XlEF+eTrGtlSGfp76T8wAsGOcDK1zPvlxNDQo0B6NgXADDtNcii55ugSNRV/?=
 =?us-ascii?Q?RRQX30mDgL/qoBIEFX0s/cUshklAcqXcDz2D9dOeFHa9gdlYrgha2LaPYp6r?=
 =?us-ascii?Q?WYj60rwVHoLdQS29/YQS6E/t0cYS7+m/xCUdqmNHC4ic9Not88YzQIOcyde8?=
 =?us-ascii?Q?oSLx3gFyxU0qmIxA1uFFSk5FDrMj5x1XqAkr92RXfRL5pcGJGnBAELySoCww?=
 =?us-ascii?Q?wJQSJAtyhZ1zUaOIKwvIjaWy18jwSjWkT7UvCoPEu5ywhDraQUL+j5NUVcFf?=
 =?us-ascii?Q?ZY4N/hUFoO1nwpdwDGgSn/JvxFO+GXnp25vyNa299M2f6+6SLHEXlxfiASuV?=
 =?us-ascii?Q?St24qT8QDPH3BY5VlngaOACytPo2qfbhwoxa+IwO3pGtxBJeOg7tyq8U//a7?=
 =?us-ascii?Q?a6FS0/9oOYKSvuDOYjy8aK0jhSyHYST9nki4E+37/6oukm158UN0lsZM5QEy?=
 =?us-ascii?Q?G55KEHT8du5q1dTwgFDdnnSVvLNl31FBkBEcp/rtqvicUR1sJ/eCv25RQbMc?=
 =?us-ascii?Q?H1HlCrRtPI9IKq5dEyu75GHhh65AocjEDnIyBcy8PJ86bjtZLH3quV2MI9K7?=
 =?us-ascii?Q?7pqBtmII4mcBSIb/vqS1egBvPGGh2EggTIr7nG3yMmvmdLXILGOy8sUbPj7w?=
 =?us-ascii?Q?EIdu3fXNvSs8+sJ2xq64wocsv/FkTJIYkrZRZ++LJSD2nQBsxnHCiTWL7MHm?=
 =?us-ascii?Q?tJilN0PTdlhtOHWaopZ1Qtte0PCsduM9oZJm/PLzPTF/QEdk9Tf/s4TliDhL?=
 =?us-ascii?Q?1YtEK39LA7+aFBa+f2SA4rz/9ZcCF+tAw6Oq3mLTHtI1K48amMVY3gOYdCxJ?=
 =?us-ascii?Q?hOSJWBtB68Fhx+N8YftBmIYRIUsOAVC9hXAmlWXyfUEVV0Yq53AinIUou3Vx?=
 =?us-ascii?Q?Y7J5wSvoRwYz7O6cHL5gBUai7tc2cga0TP49D6+wVjMh+8Mgxqj9sp5VBs+2?=
 =?us-ascii?Q?2FPzjA0kP97Axe6nYEsjpKELs6BNUjPGGrXUF1h7eCLkVxZho99nSG8mkw8O?=
 =?us-ascii?Q?bTfvuMJTFA7zMzWUPRrDh+Lhn78W6GhpNf3Vi2ftP8EFqZff9TaMwd10gelM?=
 =?us-ascii?Q?gISmdclwgtlr6bpYL90a0JlBbmHFXAmOlI+S9KdGYvzHBv18irj7JlLELZ2k?=
 =?us-ascii?Q?sjPOnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P/D3xyCOUweSGcjBZ73LWV6i8xmoBV1gLwIfgp45Z1bRFJCEFtMWUj9nUx10VWzYZLBxQWdiKUs9BesAe4/j6ZY8IzIm5ehdLwjKH1KehcHXTrZR3todwMZo7NRvo6j9OHaJz5i5syONPZROVQ4MOI9Fs84g5cZJaSxEgrPwogv2fYqpDT8d64/wuDAjxkPf0dZfxfi7PeIxGw5PC+YEXwwy9XpIfSXcRfpSftaD31PvLi3h1IJJz+v0KZ4M6RNcDBoWfrlQBbWFnmzxNW88UlkHiFpNp7XVkUIdWPiGtlUhTXUZjiyKbrLkNG+ihKNGWP6s1DAdATR/TequKBpFE5dbg5oBBuoVNnSHGjzxDFxxU7+NPGfa08VKP3hKPa5OwGH+m2RZ4Q0fEaxSvY7dRwLLuhVcKKFr5P/xNrhgyoIQ+MPYE24q4bt9yygmJ4Yr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:29:42.4274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86048a4-e3f7-4e9c-6969-08de6373b9f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256478-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alibaba.com:email,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 47B50DF48C
X-Rspamd-Action: no action

Implement support for IPV6_USER_FLOW type rules.

Example:
$ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
Added rule with ID 0

The example rule will forward packets with the specified source and
destination IP addresses to RX ring 3.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: commit message typo

v12:
  - refactor calculate_flow_sizes. MST
  - Move parse_ip6 l3_mask check to TCP/UDP patch. MST
  - Set eth proto to ipv6 as needed. MST
  - Also check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
  - Remove tclass check in setup_ip_key_mask. If it's not suppored it
    will be caught in validate_classifier_selectors.  MST
  - Changed error return in setup_ip_key_mask to -EINVAL

v13:
  - Verify nexthdr unset for ip6. MST
  - Return -EINVAL if tclass is set. It's available in the struct.

v17:
  - Fixed portability bugs for unaligned reads and writes. MST

---
---
 drivers/net/virtio_net.c | 105 +++++++++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 92e34f51737c..a4e46b767553 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5852,6 +5852,40 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_ip6_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct in6_addr tmp;
+	struct ipv6hdr *cap, *mask;
+
+	cap = (struct ipv6hdr *)&sel_cap->mask;
+	mask = (struct ipv6hdr *)&sel->mask;
+
+	/* mask->saddr/daddr may be unaligned; copy to aligned tmp for
+	 * ipv6_addr_any().
+	 */
+	memcpy(&tmp, &mask->saddr, sizeof(tmp));
+	if (!ipv6_addr_any(&tmp) &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(cap->saddr), partial_mask))
+		return false;
+
+	memcpy(&tmp, &mask->daddr, sizeof(tmp));
+	if (!ipv6_addr_any(&tmp) &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+			       sizeof(cap->daddr), partial_mask))
+		return false;
+
+	if (mask->nexthdr &&
+	    !check_mask_vs_cap(&mask->nexthdr, &cap->nexthdr,
+			       sizeof(cap->nexthdr), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5866,6 +5900,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -5893,11 +5930,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
 	}
 }
 
+static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
+		      const struct ethtool_rx_flow_spec *fs)
+{
+	const struct ethtool_usrip6_spec *l3_mask = &fs->m_u.usr_ip6_spec;
+	const struct ethtool_usrip6_spec *l3_val  = &fs->h_u.usr_ip6_spec;
+
+	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6src)) {
+		memcpy(&mask->saddr, l3_mask->ip6src, sizeof(mask->saddr));
+		memcpy(&key->saddr, l3_val->ip6src, sizeof(key->saddr));
+	}
+
+	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6dst)) {
+		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
+		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
+	}
+}
+
 static bool has_ipv4(u32 flow_type)
 {
 	return flow_type == IP_USER_FLOW;
 }
 
+static bool has_ipv6(u32 flow_type)
+{
+	return flow_type == IPV6_USER_FLOW;
+}
+
 static int setup_classifier(struct virtnet_ff *ff,
 			    struct virtnet_classifier **c)
 {
@@ -6034,6 +6093,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -6073,6 +6133,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		++(*num_hdrs);
 		if (has_ipv4(fs->flow_type))
 			size += sizeof(struct iphdr);
+		else if (has_ipv6(fs->flow_type))
+			size += sizeof(struct ipv6hdr);
 	}
 
 	BUG_ON(size > 0xff);
@@ -6100,7 +6162,10 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 	if (num_hdrs > 1) {
 		eth_m->h_proto = cpu_to_be16(0xffff);
-		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+		if (has_ipv4(fs->flow_type))
+			eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+		else
+			eth_k->h_proto = cpu_to_be16(ETH_P_IPV6);
 	} else {
 		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
 		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
@@ -6111,20 +6176,38 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
 			     const struct ethtool_rx_flow_spec *fs)
 {
+	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
+	struct ipv6hdr *v6_k = (struct ipv6hdr *)key;
 	struct iphdr *v4_k = (struct iphdr *)key;
 
-	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
-	selector->length = sizeof(struct iphdr);
+	if (has_ipv6(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
+		selector->length = sizeof(struct ipv6hdr);
+
+		/* exclude tclass, it's not exposed properly struct ip6hdr */
+		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip6_spec.tclass ||
+		    fs->m_u.usr_ip6_spec.tclass ||
+		    fs->h_u.usr_ip6_spec.l4_proto ||
+		    fs->m_u.usr_ip6_spec.l4_proto)
+			return -EINVAL;
 
-	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
-	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->m_u.usr_ip4_spec.ip_ver ||
-	    fs->m_u.usr_ip4_spec.proto)
-		return -EINVAL;
+		parse_ip6(v6_m, v6_k, fs);
+	} else {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+		selector->length = sizeof(struct iphdr);
+
+		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
+		    fs->m_u.usr_ip4_spec.ip_ver ||
+		    fs->m_u.usr_ip4_spec.proto)
+			return -EINVAL;
 
-	parse_ip4(v4_m, v4_k, fs);
+		parse_ip4(v4_m, v4_k, fs);
+	}
 
 	return 0;
 }
@@ -6194,7 +6277,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
-	if (has_ipv4(fs->flow_type)) {
+	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
 		selector = next_selector(selector);
 
 		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
-- 
2.50.1


