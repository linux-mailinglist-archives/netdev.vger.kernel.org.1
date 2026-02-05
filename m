Return-Path: <netdev+bounces-257355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HaUAZYehWla8gMAu9opvQ
	(envelope-from <netdev+bounces-257355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:49:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A65F836A
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C8DD30480C0
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235DD33A6FF;
	Thu,  5 Feb 2026 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BbL+z1nS"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE0337BB2
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331666; cv=fail; b=ad4URW4rkWHoxO9eZHBQigBDZIWYSC9WkTKT7S4oDNyIViQrAxMDUXSkzBwLNAPpfn8M7AiuzBx2p8FTDyTDq8PaW3kGMlPrmCiNlis+4Y+ixHgJg0h4BHsC7Wmi4b8YlAeLcxEqDsQHT/B6EKIqS+t5Ii7sReZE+OpDdhbq63o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331666; c=relaxed/simple;
	bh=8eVqJNRcMKcsZIjnQ8IhIdQ+B3AmfU3xtHTyLsmaV9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMrZ5iQ8+buWEYcaxZpoJ75svsPGokVpcQ/bYAmzKprZlODofmxaNERTo/mmhb9MZRv+CFfjyjODY5voPtzti+UuvJKc/YJd2uiigIeTwjX5tTdD0aAv9cGQPrBZ64IX5z+FLurFMxDUfyJozo44b9UCWaExSRQndFSQFjJn1m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BbL+z1nS; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCf3sE5YSe01GoPTYLrsVF5/sOHpTxzE3y8cYcR3XVMtpaJ3bSVVIjgsIUBI3vitjL6Z0Z4onoSTodTaagp0ji1ibdnOWkdNSLzmUNvJ3weQNMx1qKkReVy5fRV9rt0Lrs7K95/HxW7ZlwWlckkf4ract6coNqIGb9/1ThF7lcFJ/kQUTMPTRgGNVLS8Ks2uAOLe/5VlNmjSkZAqp0c5LcVyRC0eYhFAqJ8FkDH3XfsDYh/B2mpFfRvnB+pGz/gnYik6Iu277vNcQNsn41ENKk2k6PY35XJGiSrfQsxep27ywU1KgfM84rKIpZQAM2jcha57LWyZHwJ+18UXFkR/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRxcCHGmqoVqN971N2OmjIP2KHZfgGJ63tA+GZMVNDg=;
 b=yAJd23OuhV+uTQU0y79Zcl5ffj1ZmMLTqa7MZG8l116VWUzm0H+nB/sViHbM5N+vcMSqTo9I5Zq3hP2EK/Uwp5C6YUL5kWeo7wCi20FK9O7W22JEW/GZNiHVXh9h3RfEGD3n5Y9svjBa9QLsSqdpbAOOMS4F1oApZXlXwDirxpxENOj2VKc8VbMet8XjJAY31csctKAZUhxRAucd4VUZETv8Rs4tRY1GqOUwqz61f2sF2Yt8aj8O7cMRV8cm9wtBkLmJs0vfPU4zDLMUMno9LGFUgFOOOtwzsROZzx+CvPsd+tSVQFHRzh48fd09AfEUWQPogwr9IApfId4fCF2QNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRxcCHGmqoVqN971N2OmjIP2KHZfgGJ63tA+GZMVNDg=;
 b=BbL+z1nSvTlxmn/tUHoahfcyMDcYJedVaS99AOfk4syHr4Ay+LdlAHp3Eh+6EvL+eM/0JhcvC7r3InaZSZ0o2l/crSlpC6r2lVNtZjN2ICc6O0l+zFPaFk8pdFz5N0ZjY7t9H+bdtTO9xeANoOTfeiFWo7uYku7QiZJMsO3lRTV5r8/dlXs+01KGyN8TuuBIOVLUiy7rlcNkgzphR05zKP+kua9Ks5l4Xssp2BbvtnLnPlTcSM4xDSZe56JMNkQ+S71k0vWrl69h3NmcwTsa3io428i/XJun93CBK+DKfY3JbHCMF5hMLDKW/8js9cDMqgw2uNlkH9HW9fMA87B/vw==
Received: from BY5PR13CA0022.namprd13.prod.outlook.com (2603:10b6:a03:180::35)
 by SA1PR12MB999084.namprd12.prod.outlook.com (2603:10b6:806:4a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 22:47:40 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::bb) by BY5PR13CA0022.outlook.office365.com
 (2603:10b6:a03:180::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 22:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 22:47:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 14:47:28 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 14:47:27 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 14:47:26 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v20 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Thu, 5 Feb 2026 16:47:04 -0600
Message-ID: <20260205224707.16995-10-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205224707.16995-1-danielj@nvidia.com>
References: <20260205224707.16995-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SA1PR12MB999084:EE_
X-MS-Office365-Filtering-Correlation-Id: 319e8689-1325-4640-a045-08de65089118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dU1EHNmTv8GdPEuuqmhvasK/zYnsutimir8PZtRzeib9tNXN67wMhXJGYGhu?=
 =?us-ascii?Q?X2jwREnSOz0K0SQC0kHhfkC+/5cvukPNoSiqm8hSiDtC3G+1uGRjZy9+ZXV1?=
 =?us-ascii?Q?5vBWiYKrPhDMx9YUxFBSdZmpKYUq7Dl27lGTmhIQlN1Q9JLvg/a2Q0FjMV1v?=
 =?us-ascii?Q?3heEk/Ez+y/r2oEwokVqgaCLJW4AjsPmiAl1ul9I9sxamtHfHHsUGTW0XfY7?=
 =?us-ascii?Q?hPtGC8aFLmD/DsEYsMta72s8lNn1D+2QMiizo1XjMbDsMjgsrq20jZA0yz13?=
 =?us-ascii?Q?uSBZn8Ut5tmoq1aqGhMWc0mlM/OViNaYmeehxHl0TCPchXd4df14oiGa/L/M?=
 =?us-ascii?Q?kgVie3Tg2O9t93qRaww8gbwtwePOTtobaRe/iqkangbqBvT7NqCNeCdBHWV1?=
 =?us-ascii?Q?iXY73pSDg+giiZbbPTEaAr3FisFKVTkdWo3/rqMXx2sBcazRbE3HXV9HdX/r?=
 =?us-ascii?Q?iH0TPMjE0haQMv8ujv6vJJ/JceFupwnDzkYXsyChrXKDjrXCBtpaPibqncqL?=
 =?us-ascii?Q?/ixnbh0C0bPQ70mUy+WMjk5ZpJJEm5kt2j+YqTude8zZF1vjnpohArtshXxZ?=
 =?us-ascii?Q?cSPOhVO6oz97JS448S85InHpi4lKYwjavhfECu1IAPIyJxfthL2ZKA0xOygI?=
 =?us-ascii?Q?4PcigHz9sLdBQoRQ1EnKvX+pKsbpZTdQDqixr6/UhEClArbPmNfpAZK4KN45?=
 =?us-ascii?Q?OsOUrgoURTleM5lldReXn4oLuEnwy0qi6iWYexqCBEvmH2BgXCgE8MAuqwPc?=
 =?us-ascii?Q?AHYATJ5HX7LeCyAvRR6UacMFOR3Y7GO8PxDgCJuzEOVHsu4ygHozGsMktiHd?=
 =?us-ascii?Q?fKeRnhbtXz6iym3wa0U9LKwI63lhStmgLCZ1Jv7biBXmsBGGRdYunLe7IWGU?=
 =?us-ascii?Q?PP0gKI5t9KNbc6SnfZUvdbT0kUU9ZEvgM7ad465F3rRnphDcLFE3IQT/j3/W?=
 =?us-ascii?Q?erVuU35bYBtqIR6H2/XYytDptjZGHxxr4T+z1mn1qkrzUETVtfJ3ATohBGjd?=
 =?us-ascii?Q?+8KHCzqp6MhOjS7Wc5eRscMjXNpX0D5oDz3SCtHozSf1JsLI+oLZ7ZrXO8Zy?=
 =?us-ascii?Q?bdPWr4hkPbsO9VIfxt6cfN8yDjIoZwKn159YNgSkMeSDSj0eNW6PiTeqk3pH?=
 =?us-ascii?Q?I/wH60cu0Y9+rjq+4OPba1iZya75eZva5Z5GXGzcNW4HsmGrqHS4oxNQRsqF?=
 =?us-ascii?Q?k/v4605g4xs1bAOqeXETiXe9r2rCuYBxAOLcEErIc7EJeXNU+xL3n/TckBda?=
 =?us-ascii?Q?BbzPnvy+ij2T6YRHdIZ5JxyVRwBE/Et2U9bEQ0wYmRty+Gp8svAQ29sYdDYc?=
 =?us-ascii?Q?Acbik1sLpmh6BfNshIzxWaW84mt/bbtIMOnByh9mzg1sh0xswtpbJ87I9jCN?=
 =?us-ascii?Q?7iBpjx5wuB+1JejjJN3WjewB9oWMdwr8duAT0egRBdlHZEodJvXY7xyP9Q9s?=
 =?us-ascii?Q?rIHdcKkb/kTPZgmroV3oeR0BGKO3nwG2WzSOWnCDBl2nimci0H60lfb7BUtn?=
 =?us-ascii?Q?lKVqd1wQ1HKkMFfxp/DMDqhiLPzePce51uMvsN3EnCp7JgM1fABxjMZGReAs?=
 =?us-ascii?Q?EYg/XPkapJVe9yF5ZxIzgmtvYRSOxh0lduT/YOET+gMTd88WlAP3aVCLdLfE?=
 =?us-ascii?Q?VlKhwp95BnEzIUhiXuk6q3xW2rNaYOkuXs1V4pxs2uWKD7KrNpj9/OZ51b3A?=
 =?us-ascii?Q?77nBDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J6mkbVRgHWtHCy9VCmlZpjW8D1ntwHKMKLqmbUI8nzPqX20HFJwkrcTslDOIP7nvJgZjqukrsPqAsVoQ1d76qE24koMy4wCM0LBGLmHTPYNIx85JrON+ugCvauAusZOzvMBXwozTASddKH/S9XP7+e1ltmAXh+ngvtdeYtCs5wOnd8u5ZZlR8Bcxz+AMhK77UYyZqok0zwM2Ql6NZ+KXVT7OCCq2EcUV95NTf9uIrfveKTSoj4jWAE9rmaQ+HynYKCW0sp4DZ9+wt10LDSJOX9ikROa5yCnsntaf5fngmlGWGaZ+uD/Re0jwJDXMuzEqAPonIQx+dylP7yNlWDOEX1do19747i/pEBCUHuDvViEJ2AL44z6BMENDvEJg4DwBzaIL1ttYclLGh7AYysteA9g7vPROdXPGE4epKhcPHkckGNSM4UV6r1YJM0cA88Ke
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 22:47:40.1367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 319e8689-1325-4640-a045-08de65089118
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999084
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257355-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 56A65F836A
X-Rspamd-Action: no action

Add support for IP_USER type rules from ethtool.

Example:
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
Added rule with ID 1

The example rule will drop packets with the source IP specified.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed bug in protocol check of parse_ip4
    - (u8 *) to (void *) casting.
    - Alignment issues.

v12
    - refactor calculate_flow_sizes to remove goto. MST
    - refactor build_and_insert to remove goto validate. MST
    - Move parse_ip4 l3_mask check to TCP/UDP patch. MST
    - Check saddr/daddr mask before copying in parse_ip4. MST
    - Remove tos check in setup_ip_key_mask.
    - check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
    - changed return of setup_ip_key_mask to -EINVAL.
    - BUG_ON if key overflows u8 size in calculate_flow_sizes. MST

v13:
    - Set tos field if applicable in parse_ip4. MST
    - Check tos in validate_ip4_mask. MST
    - check l3_mask before setting addr and mask in parse_ip4. MST
    - use has_ipv4 vs numhdrs for branching in build_and_insert. MST

v17:
    - Fixed portability bugs for unaligned reads and writes. MST
---
---
 drivers/net/virtio_net.c | 130 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5cbf26d8f7ad..92e34f51737c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -33,6 +33,7 @@
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
 #include <linux/refcount.h>
+#include <linux/unaligned.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -5818,6 +5819,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_ip4_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct iphdr *cap, *mask;
+
+	cap = (struct iphdr *)&sel_cap->mask;
+	mask = (struct iphdr *)&sel->mask;
+
+	if (get_unaligned(&mask->saddr) &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (get_unaligned(&mask->daddr) &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (mask->protocol &&
+	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	if (mask->tos &&
+	    !check_mask_vs_cap(&mask->tos, &cap->tos,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5829,11 +5863,41 @@ static bool validate_mask(const struct virtnet_ff *ff,
 	switch (sel->type) {
 	case VIRTIO_NET_FF_MASK_TYPE_ETH:
 		return validate_eth_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
+		return validate_ip4_mask(ff, sel, sel_cap);
 	}
 
 	return false;
 }
 
+static void parse_ip4(struct iphdr *mask, struct iphdr *key,
+		      const struct ethtool_rx_flow_spec *fs)
+{
+	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
+	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
+
+	if (l3_mask->ip4src) {
+		memcpy(&mask->saddr, &l3_mask->ip4src, sizeof(mask->saddr));
+		memcpy(&key->saddr, &l3_val->ip4src, sizeof(key->saddr));
+	}
+
+	if (l3_mask->ip4dst) {
+		memcpy(&mask->daddr, &l3_mask->ip4dst, sizeof(mask->daddr));
+		memcpy(&key->daddr, &l3_val->ip4dst, sizeof(key->daddr));
+	}
+
+	if (l3_mask->tos) {
+		mask->tos = l3_mask->tos;
+		key->tos = l3_val->tos;
+	}
+}
+
+static bool has_ipv4(u32 flow_type)
+{
+	return flow_type == IP_USER_FLOW;
+}
+
 static int setup_classifier(struct virtnet_ff *ff,
 			    struct virtnet_classifier **c)
 {
@@ -5969,6 +6033,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -6000,8 +6065,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 				 u8 *key_size, size_t *classifier_size,
 				 int *num_hdrs)
 {
+	size_t size = sizeof(struct ethhdr);
+
 	*num_hdrs = 1;
-	*key_size = sizeof(struct ethhdr);
+
+	if (fs->flow_type != ETHER_FLOW) {
+		++(*num_hdrs);
+		if (has_ipv4(fs->flow_type))
+			size += sizeof(struct iphdr);
+	}
+
+	BUG_ON(size > 0xff);
+	*key_size = size;
 	/*
 	 * The classifier size is the size of the classifier header, a selector
 	 * header for each type of header in the match criteria, and each header
@@ -6013,8 +6088,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 }
 
 static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
-				   u8 *key,
-				   const struct ethtool_rx_flow_spec *fs)
+				  u8 *key,
+				  const struct ethtool_rx_flow_spec *fs,
+				  int num_hdrs)
 {
 	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
 	struct ethhdr *eth_k = (struct ethhdr *)key;
@@ -6022,8 +6098,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
 	selector->length = sizeof(struct ethhdr);
 
-	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
-	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	if (num_hdrs > 1) {
+		eth_m->h_proto = cpu_to_be16(0xffff);
+		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+	} else {
+		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
+		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	}
+}
+
+static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
+			     u8 *key,
+			     const struct ethtool_rx_flow_spec *fs)
+{
+	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
+	struct iphdr *v4_k = (struct iphdr *)key;
+
+	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+	selector->length = sizeof(struct iphdr);
+
+	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->m_u.usr_ip4_spec.ip_ver ||
+	    fs->m_u.usr_ip4_spec.proto)
+		return -EINVAL;
+
+	parse_ip4(v4_m, v4_k, fs);
+
+	return 0;
 }
 
 static int
@@ -6045,6 +6148,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
 	return 0;
 }
 
+static
+struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
+{
+	return (void *)sel + sizeof(struct virtio_net_ff_selector) +
+		sel->length;
+}
+
 static int build_and_insert(struct virtnet_ff *ff,
 			    struct virtnet_ethtool_rule *eth_rule)
 {
@@ -6082,7 +6192,15 @@ static int build_and_insert(struct virtnet_ff *ff,
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
-	setup_eth_hdr_key_mask(selector, key, fs);
+	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
+
+	if (has_ipv4(fs->flow_type)) {
+		selector = next_selector(selector);
+
+		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+		if (err)
+			goto err_classifier;
+	}
 
 	err = validate_classifier_selectors(ff, classifier, num_hdrs);
 	if (err)
-- 
2.50.1


