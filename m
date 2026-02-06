Return-Path: <netdev+bounces-257592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CpzGVALhmkRJQQAu9opvQ
	(envelope-from <netdev+bounces-257592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:40:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AEAFFD53
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B56B73007957
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D21D29E0F8;
	Fri,  6 Feb 2026 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rsIEG0Q/"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D4283FC8;
	Fri,  6 Feb 2026 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392391; cv=fail; b=ewdaXaFDzN5V0HU1hCyuYOiJWzPcUZA3Qk94/UgFuK5AbJ3N7Pfzcu5HOGntJ5kH8Uc2HPm4dW7j0oCiqrg7wPAMVsWudvI9emWyo86h970q1YUIDRXRuVyVNSXXMYYMm0Y8sRSEx44ROyBEOkmU93yHRouirIejwNuPY0oUqQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392391; c=relaxed/simple;
	bh=Ar4jhb3WuQA2JjFzTS0FqWYOVZxqD8VDTg4KtRnZcfA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gaj2OqW1tSaXnMmGpmkwZXFm+WbNiNMiIc10wwZc0FHBnhYHzU5ggkh7NZh0st7JZOdGCrszR0JQ+5VqbZ1tm86uy/bCj9RDvSe9pZgML+Qoyb8A2aHpqscdXrEdTUD1fuDKRZpnZR75j29lUxACIysx1GQbRNq4mdDZXR6DF8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rsIEG0Q/; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0lagzcqYGZ7ZprB+nFSpIQ6fUfOU5d/qd2cBwYMwjZCphuTELKsFMqadnA1wFL5H+ECiTtGbHa9fvm7kOfHbScSzPfHpzvx0z0QyStE8VZylSUUudDgbNBL2zwh1otWZyvhntfa+mNaQ/7FM2JU/J0rcTP6IVB9t78QD7gAGMVH/oQmUmAK/JbfPCv78Dz9CwiWegMQtStJCYHrFGM5epwFwtQXnQsou4PE2NDmsXQUkNckkCNz0kWy+6oUIDDVLBgZW2D/yYpNp+IbmFWvcgEJJy95llLSEYKuUW7AyDzUPtNY3lM7nYd/9lPbu5ZNOVl7IHJgYt1y1/L2mIrd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1V1Euygq52z57uuVzlIfK2cKXk2toaxMbg3C/u4t8n8=;
 b=qRP4YEQedDzU4YQGBHmh2WCtWKS2kuAGaJbHlzIri5oCZfGY+htQtehl/adu+bBZf6vsHJSPVyf1w/uGdeCPvlmIeKZlVk7PfW8DWlSP05NapWc6eAE94NHcVY6Hx3fj8fTEOBtW2cx4m/Ogn0jmN14MW/whWX8G+k8scrlxRld8Bk2HoB6vl7ci2A2D9P27WtauMHlMylTewdCrpnLx5/7Aw2PMylz4/Rwb1BaOH0gCBsAEAoQZBIha08CEPmzU2K8BW2I4y+j/gbaxyEmJEzvqaRWmpSEVzXLCfruBNoKBPMpJS9jMjujF10XRgZfrJXKZFoLXh5f04NgQqohwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1V1Euygq52z57uuVzlIfK2cKXk2toaxMbg3C/u4t8n8=;
 b=rsIEG0Q/NhQ7V/MdBSmXW51EM8DIivFk1ZEbGePR1BP6g1yjj2N7LlqHRBTbbcDOscBItgftjaDlsZrZlIkV6lNUDYUrQZuwK694MCdAVXUuSxvmzve8EbHpEnADrCOgAGNnyM6Cm1AcO2XQYLnKaHWiKK3YwtqqOuhfQlR6jnZ486qvoCFuIHe9Hhq/D6Hqz92QzfxfBfINglCdpT6pcCytAHKsDdTSGvZUsFCZ3e5xK9C7CvBGmsX48T06/nniommI4325Ngf0NZ53ZWjgW9o+v3zWwAWa1JkfofXwGGm4XfN8K/xaiXB2SgHk8OFdVT48zOqjHBcLVSNgJqzkaQ==
Received: from SJ0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:a03:33e::6)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Fri, 6 Feb
 2026 15:39:47 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::79) by SJ0PR03CA0031.outlook.office365.com
 (2603:10b6:a03:33e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 15:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 15:39:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 07:39:33 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 07:39:27 -0800
References: <20260205220541.2992807-1-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <willemb@google.com>, <petrm@nvidia.com>,
	<donald.hunter@gmail.com>, <michael.chan@broadcom.com>,
	<pavan.chebbi@broadcom.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 0/9] net: stats, tools, driver tests for HW GRO
Date: Fri, 6 Feb 2026 16:36:17 +0100
In-Reply-To: <20260205220541.2992807-1-kuba@kernel.org>
Message-ID: <874int285w.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: edea2533-c4c5-4ed3-bd54-08de6595f584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i8dd/+OiaGjmk3vZ0Frk7seGz2MSgetermOL3lPuzXjAPFssLavmJ7n2n4Mw?=
 =?us-ascii?Q?1CE79hrS0exnVKUTvL4DbOZB6VwYYkoQqN13afXEGQYt17C3NMr2ZJHihHwN?=
 =?us-ascii?Q?uNfpcMUbB7trTIzCzin0Bx6FupTr8tEHMwYiRS/oVSXhhnQqNVrinsF/+Zz8?=
 =?us-ascii?Q?M1sAlNkYG3B8+umdGi5qA3VhJslN2BaGyncUCCol7on5lbx+rFHlrRWGSyiT?=
 =?us-ascii?Q?CPlIX+YEm3e7J7dOpfg9zyTw0ZVqx8/dL+oZTKBh4qLy9vUhJrX0HQ2SBWs2?=
 =?us-ascii?Q?/Rzzrdo24BLI9lqpQysw7R2vip4zXYYNEhLMTn16uZOo2MTGBsbtzsMMrSgj?=
 =?us-ascii?Q?kwoFeuEGZclvsNGjj3h/kMUaPet8GbKcN6I/egokWNpHRVzR3VpTcvsyfHVH?=
 =?us-ascii?Q?v6AASBvLKLtJdcUjI1JEBK6s3elqKMXnelED2L+SWd0h88rxgnctET6eYY+W?=
 =?us-ascii?Q?4QDScGK4KT//SHwvji3rI8rp3He+hU2+Jb767StO8W6aAEH9o6VD9qm8LYy9?=
 =?us-ascii?Q?cErswAHoI1lnm5MgfAPkjPI6jZy5+ZPo1jNTzLHHWKdDmhNoKZcozcYyjSot?=
 =?us-ascii?Q?wg0RQHa3ZfUmromS+zE93ROQh7hAcM/VyZhnVZQbnJGYcqdYlIA0qbkLnaG7?=
 =?us-ascii?Q?qJTu2gPsCn0epP/AKis4i4cnjmfbtxmWFem3usX5Pm8v8h6GUBXVqhcvoi2T?=
 =?us-ascii?Q?PG0V8UkPJkGL6zkq3iUBTSZozjM5zrx4l69iAF4oXGWIkzR4BOToaZ9xpk0y?=
 =?us-ascii?Q?ucHHNYk3hQZcswXmDSRR6jtyfHfx2mP8HqpS5VCbiOUkB3RDlKePCaTyJcm1?=
 =?us-ascii?Q?/Fhve3fddWAHps3Gf/igKVdPhPAE6tcShzPsbiiao3b+ws0NvuMlbJfX8/TY?=
 =?us-ascii?Q?30RoffPAb1JT5YYtEPkL6dKhspNg7GlJ7wQDgVkCIasToSBW0rd502ySQVra?=
 =?us-ascii?Q?HpEdqiM6rtJJcgShxKQhJwyFjRD41xRBcq/S6SRf5d4QDwpTb4fjW5JqYAVL?=
 =?us-ascii?Q?bflSVgOKeBK4uzahllSZRQgiKXARp6kcF86we2AQ5FTQaZdd4mlDoNK9Du31?=
 =?us-ascii?Q?BGgpn/t7LVd2JIROlJyDrmjc/RXiaK9WW0hsPIU5Rr4EQ9o2R91LylWRxA5n?=
 =?us-ascii?Q?kKbHH8ItLRFGEa2jRdNxoRtQDHT5Y2wHeqWOI2BUBAPm1eJPGACnFhcpGReE?=
 =?us-ascii?Q?PKR8sIjIMpLCjaQIQwWJ/Q5tkNNAMznGXTjF5IMnLENc2DyqoF8OFyvgOnYJ?=
 =?us-ascii?Q?9OxiCV9X6g1HXdK7jM6e+j5nAoQg2QX9HACcduTwAhehlj+sPLucBxLocBCa?=
 =?us-ascii?Q?tgArMkGz4CVDgH+FOiwTxA9d13c245ljnaCyGC1lme/NtfqB5VqAEY9NFBxh?=
 =?us-ascii?Q?p9XcnO44uGky0xL7mSiEUMN2UJ73SqRzg6u7rWDy1joChiYImtCygynkf2KN?=
 =?us-ascii?Q?8KDHm/+aYnUqRKIRM0agliWmqmX6uYs2GX7uPmzHJ0KGC3noqXGPgB6g/3TZ?=
 =?us-ascii?Q?6pvddh0gC3mq0HGqOHzk5lIZUoVSWrXe22Lb4MX/Vu88eNsBFkQnpAczh4u+?=
 =?us-ascii?Q?6PgO1cem+DclquQotJFp/GL2zqh7AHqXEerNy8hr9N5AaH0e8K0XSNXtX74U?=
 =?us-ascii?Q?asVz4UM+Fl8d6Y9K88wOdFsZqnVfbFLiJDdRyq53V75tAPXytOqNMgjR2JOe?=
 =?us-ascii?Q?4HtF/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dl7nYOD6RLHssCHAWrYBFYhMoBWtR6TIqMwQMzjQhDsmpkA6s7eoKaMzlXbKVXgHT2Jb545Llf8gqUmO8OqFIIvtHze/XFuxJo32lW80INsVP0EFcWwND5vE8MIN9KYe2jzNejJhkiXht4ctYwC4WQLpJfUSuzANHJphOKMAah143VuR2d77QhC1ge9ZJNDOCz5W4udzz7Jx9q+tTWDEEJsh7er+bwxCXyzPh6k2syHHwUTbEpITnuD+om5r6nruUF7mnVHIBJfdj1sl/LLPb+Gjqaz3dBEq93mRXQB72V0x05s2w3ahQZM1QQW05V5CjaOW21jHAsvrgvE1Th669Tt52au7u5lBYgS9nw8osVr+K00FYvI7wbq7c/TuaLc6PDkf07ZK7Dd9Jx58PjknrrtdVcsc6XN9U7Z17xsj3H5NHuyTXPuk3H7FeMpBfLSo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:39:47.6486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edea2533-c4c5-4ed3-bd54-08de6595f584
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257592-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D6AEAFFD53
X-Rspamd-Action: no action


Jakub Kicinski <kuba@kernel.org> writes:

>   selftests: drv-net: gro: test GRO stats
>   selftests: drv-net: gro: add test for packet ordering
>   selftests: drv-net: gro: add a test for HW-GRO depth

I went over these three, and have to admit that I don't understand GRO
enough to have an opinion on them. Likewise the Broadcom-specific code.
So I'm done with the review.

