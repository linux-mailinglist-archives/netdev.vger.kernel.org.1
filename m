Return-Path: <netdev+bounces-294351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id evMWEvMnH2roiAAAu9opvQ
	(envelope-from <netdev+bounces-294351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:58:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4635631414
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:58:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=uiU9KRIJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294351-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294351-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C267307DFAB
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286E739B97F;
	Tue,  2 Jun 2026 18:51:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8563439A7E0;
	Tue,  2 Jun 2026 18:51:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426309; cv=fail; b=T9GjDpW+ijJO7dlfsBZGdbF+aUlMyTRD5X/TryOZ63nAfJ3HZmq1KRYACBwmr36nJ1mFYz4qehr3PmM+MhzCpp3Te5BZ7C8CxE5OcaOETfsotZMbCBW3+pp3HI5jBPjBU+Cl1YUQY+5a2utXOLD0cqVu5w5fDqwD3B2oyDYP0wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426309; c=relaxed/simple;
	bh=HBJ+3unn089UWCPjKKORwN720rbz7P5P4G1hJUcahj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZqWtFx6W2i5LL5J/EaFJv3PrGycDcvi2M4W3d4nQEBESzeTgjYtUky/ym4w3T01kcfCQTIdCPbgG16DDByVf/e8i8U32iphNcYBLvZpaLL+Zu4siuXhHY5lo51phYQy1kWZ8lM1sf7zLBY0Fgdikej5QKD47xs56zI9J285zzBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uiU9KRIJ; arc=fail smtp.client-ip=40.93.196.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPPhREmOs2nYn6uar4qRQeN4J0mVMY3nJatewFPd8BIGc9SbcKPDXBqGdhI3PWEwAWJQeglc3/so9CYmsq2ec+Q7kd0XJ7hSQQakgOUTP7vaQEpUAD9eQu6MbOW2VI6dgs1ZH57mawGhT02QOFUVde2Syj1Xtba0z6dOrwey0Hm0aK5V7T91gQFym4pRoLRU8l+0eaY0PyKndKDFxZ5MDXCfEf2yUGlXrKwNpbSFrJazH0NN2an/eHyZvpt809zvorjbEXqgf+siaDLKTtn5W7On5I+AE+/SdI/Q4cVN5qKyfaP61JJpNQAeKOyS+Z2M4Ond8VmqJ1TsKrqk698GcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIT2U/njn9FDxJoIGAF9nYQk1ETPctpzvDzuFiJzjyQ=;
 b=kk+ynxe3jLfLlYx2x0GOOzEfbZyg1NMU9AUSGY3Uu2PWjjXdQad/gVfEsYeoot4ebZNXOjrDETuERBWTXwOn7AxPL2IInCQj7KgaNRtZSOvap4iTaH5rfvhshNC/d3YDhH3y+HaRis6OyTfnyC7EKNTesm3R6BqozhOso1C0xzWCAJj67mzZvVuPHQx5HwDpjWsKEmm5WSIoqAtzShGAKAvwyGmyeD0/a1prahJmn8cu0E5d6yTZkJBVhT9MDex0U/27RS1aBhoaeeqql1uQZCO5v2VCbR68l0g8aDDhNAuyL35v2E4krhZssO7zwErx59N9Qa/oWqcX0+Ws/40wyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIT2U/njn9FDxJoIGAF9nYQk1ETPctpzvDzuFiJzjyQ=;
 b=uiU9KRIJY+JR6bTXYYiXmdVou8zVwU8EDXQHypksMSbSW+NnR7UqFULxK4FANzlNjCAHPxj1kI9f16DUAaV3b6OYSvdjzAlDcLvXkHjOWR3P8k7UWCzh474nHx/v/Tzn/Vg2bIwd1ZwFojMJHa2JxWR4jddnG3XTygelZo32AFjvKfgqTRjKIS3gMDYn83VbiPR/o4n2m8EljF+S0NGnUopazO3NJH9lACq8gKPRcAN5X142c1iwhY6o/mpJTPUjzbywTdqmnKGJP0Cq6N+7cSc8c+xRZnm/qEiZ0B22qcl9XvCrqodofUtBTzI9/gF+qREWMgNcXPhoy/wjaCxW/A==
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 18:51:42 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 18:51:42 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Roopa Prabhu <roopa@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Chirag Shah <chirag@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/3] vxlan: vnifilter: fix spurious notification on VNI update
Date: Tue,  2 Jun 2026 11:51:37 -0700
Message-ID: <20260602185138.253265-3-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602185138.253265-1-aroulin@nvidia.com>
References: <20260602185138.253265-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 424434cf-9de4-4ef9-8107-08dec0d7fc9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	PRdrzCXzh+oyP0ljp1jMqzu2Z/Zb1zZgqSqlFI3UYZIr2GfyEgTQg6cRoDQFM74hLAkGEUwKZ7nagWIHbMmWLxBLBolTBpmD6mYIWvZKal8nayK/duCPdsA4urUG9YDXSYD67cmOqcEsmpdftKg/s7wvYGtMkSaTXNVDEprwmmqKstXX1muxavquOY2v8aEMkZov2/YNzTTby/lTko61tA2sYdjcyQ/UOlh9XdjzHwhBT84FTBKXS2AiFuopUBLps5RyBxeUmkYkfD6MCzLkxSq86ShdWKYW+nmAQgUpj3bQHrZlbdb6NaEApq7TTuDfJp3pbv8aFLfJ8LLDOkxGdjv1UIkP8W3fFY5Hnjqa/ANQa+xskyUHi3DGd0ylZ6kSXrnzefn712XtCzJ0an5W+XETVUgADjeUhDNpnv0LPOw2+cy0VIWUX5gpI65v+8Ru/ZsSnllbgb4kBhj+GQYXZy/WG5NV2iRRhzoOR4VViFYoSP2GNsX2h0pGTxxnIGZ7yf0hd25+msizbAHb/4iiiBhEM3qygnRfZD1C8ImAweoMmAPdIuVqJz8C8eMywCC/eF+NFjmFL2DJvRs7BqLd8C06V/F044i28VXWmkvWjJHlv4MkMdn/7cEHKrV7KhjhGU53czzlr40frJRq+/JPHmWDDrW3hxIHv3PZlcX+kDQVi3s8gqFooeJngljnI7BV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BliQ1NGOhjP/PVHDh1FXx/bsMZmowfTtlHSKLYoNYYHXfaLdge7rBUmYXuI0?=
 =?us-ascii?Q?x00WRWwoRjW0yfqZ5/ItF74XxzzwvHbrxIGg96UuJhqJokfyD4VyxQSu1WQg?=
 =?us-ascii?Q?2Igo9D4qhnAnuP8IViOn18YMzYrsl13jxzxgxxz4tkJLxXTxvoqNXPnN3MQA?=
 =?us-ascii?Q?cs4x3ie4ZC4qWhdIu2SFTfdlX5fKlQWE0JkNlJg77tqTi95JLgJKPmRI7UgT?=
 =?us-ascii?Q?TdV6f1aJng0Ayc3rbFamucBgDlckERtMAjSYEnfSK2T3EeTwglwkIojwFZV/?=
 =?us-ascii?Q?6Sm/bGTMlBtMKetNwVe9fBrAYW/d5pa6td2TDDQbN5r5jevIJgpZPlhVsHzl?=
 =?us-ascii?Q?6rNN5xCmbBX5j5sI/t6n4iU/r9oxyazBs2qw3/+Uj1vex3/MF5SsZ5KeRJMI?=
 =?us-ascii?Q?15pzYcsc7bQ3kIpL9PJDUJKKNU7tTrFu2qh5TUbx0NMUON5IPFBj9WOf+qow?=
 =?us-ascii?Q?FPfeddXj9MumDE+vO0dyME/WZtnRTH6mbXZvNJZ//RD44keJo3aOnx1Ev+sB?=
 =?us-ascii?Q?zzk1ecgeRKyiaO3mL8F2itf+xvHATV+bixjPF3gLG1/BoGh7B693/udU6aC8?=
 =?us-ascii?Q?ygxMSRn6O230RKOcTGKemjwg5zVeWTs//YyRHnEMYOztlQEMRcmqJYsf7HBc?=
 =?us-ascii?Q?siMWt8ANbR8qkC/hwH+S79b3jBZJbskWi0L/KK/7I3ccLgDjMsVtc/k9X4IG?=
 =?us-ascii?Q?SWulqjV/wLv+Ds7hY/tC+uNae9WVZP559JR6YfKlk0VwhCJ2/FflDTDXp8ab?=
 =?us-ascii?Q?C/10yPK+f4/Lo6aBwh9n5GDX178h4AOWbHvCgZjuX3sIqZl3BHw5BLuCut9z?=
 =?us-ascii?Q?UvR+ogdRGBdW/xcb9kJwE4NBXeHD+X6YN/YZ8OmFiN54usDR0kMD5muzhuq2?=
 =?us-ascii?Q?qJqGnxIOkt/lwd+r0XE+xtQ59Z4PAL6YprB0GZcGCKb5y4XpDsSUlkeJzItX?=
 =?us-ascii?Q?1OqfDnEPgjY5EVgWfojS2ogW/kRznwiJOmCw9l62E6mLUpwGh3kFHxDekHOv?=
 =?us-ascii?Q?EiRI54e+665N1mFX3qLddcTTWfdi8wXZlG/MtGmEYbkolQJWxdKQjv0xM7pi?=
 =?us-ascii?Q?DFY4z6RNQ0Ed0xyY8XqSa4Bsp4WpqzsyvFLF2rc81J3wPQe/SfOFUGiZFkck?=
 =?us-ascii?Q?1B+lpidUiX2enhJ53XPlZlIEWE657iI6FKPqg5M2AQCVcgwiMpbkQwhqpYxD?=
 =?us-ascii?Q?mmQG2vhxSibDAn+ffOALNFv9oOLnG7zywYkk+fEZGrTR2Z/dKWNyRnXXX1Hn?=
 =?us-ascii?Q?2SnI7K3iBTKTgjlzh63HVYMXHKlywx1Dd8H1P4pzcmKWIHMVjb1nQ4YwnFGx?=
 =?us-ascii?Q?lbVl54WXfOHMfO3LyKz4U8Vutv0v43pm1g2tDvse29aIdXoMAOWGWI/eLcGN?=
 =?us-ascii?Q?q54sk0rYtW8QKok/8Gsq+9stOAjec2CI+eJS0nQkBEsgl9XMtVoWk2lNQe0i?=
 =?us-ascii?Q?aEjhoOW4iK1zJEie+Tdh0LDnqnY85NT4HDbK++ugE4QlCSk0iTSzchpiannW?=
 =?us-ascii?Q?2twAClahIhc+9iSSlGPEniy/uO4Xu1pWIh4n06998VBkyjlB0VhanaMy0i7B?=
 =?us-ascii?Q?+3yIl/zBYQTx07kKy2vHsWh1g3ajHbA+0QJSzrfm2MEJNS1ijoAMk9r22mqo?=
 =?us-ascii?Q?aSwqJIFUWrYTuf0Oe3Q4hyHKrs93yNbvb1hpBtvP3mtLaD2pzCLmTDGM3+JA?=
 =?us-ascii?Q?9VObWBWSdOikMkIE5sx4Gp6H+ZCBkLE1korhjkXMIdVFtvPTsgpgVGy3PhyV?=
 =?us-ascii?Q?8BqYnZqnow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424434cf-9de4-4ef9-8107-08dec0d7fc9e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 18:51:42.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVd6Iko+TBkOFXwpGd+HeyuLon2bcT/aI5hLUA72sA2WvJIe4CjaGk7txrMTcbdHvznVDE5PAK/ZB8lRD+EGQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-294351-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:roopa@nvidia.com,m:petrm@nvidia.com,m:idosch@nvidia.com,m:chirag@nvidia.com,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4635631414

When a VNI is re-added with the same attributes (e.g. same group or no
group), vxlan_vni_update() sends a spurious RTM_NEWTUNNEL notification
even though nothing changed.

The bug is that 'if (changed)' tests whether the pointer is non-NULL,
not the bool value it points to. Since every caller passes a valid
pointer, the condition is always true and the notification fires
unconditionally.

Fix by dereferencing the pointer: 'if (*changed)'.

Reproducer:

 # ip link add vxlan100 type vxlan dstport 4789 local 10.0.0.1 \
      nolearning external vnifilter
 # ip link set vxlan100 up
 # bridge monitor vni &
 # bridge vni add vni 1000 dev vxlan100
 # bridge vni add vni 1000 dev vxlan100  # spurious notification

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/net/vxlan/vxlan_vnifilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index f2a202d468928..3e76f4e210944 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -661,7 +661,7 @@ static int vxlan_vni_update(struct vxlan_dev *vxlan,
 	if (ret)
 		return ret;
 
-	if (changed)
+	if (*changed)
 		vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
 
 	return 0;
-- 
2.43.0


