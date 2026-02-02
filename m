Return-Path: <netdev+bounces-255948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAzxLZjagGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:10:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF1CCF679
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D5D830402D7
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B0F385EF4;
	Mon,  2 Feb 2026 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fHH0pzLn"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2238170D
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051980; cv=fail; b=ABej9sdH9P/s0kiVZA0hhgHkpcrBcV6+/aa8W8/XCSdyAYP5EOs2aBDPbzKaELWNlSCdgv1v1j0TI/jIX7wfhDHgXSynwwfzK6gr84oCCd9f7NZFVrLoT+dPpXSRRBP4+JFR4AeBhuyFLyFWzcpKaPMJqS/5TrcRTyk4MDtxBuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051980; c=relaxed/simple;
	bh=jmfvSWNQpJQLCHb2ZjkKEdfgMtu35Js/Qn5Vl3d/6Cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGxJhm9aJgm5ImhFT516JC/8ra53KR2ggBz9/cdH3DzW+P1O86Hr26kHWDoOKhWG1OqTGNQPdfRkam5xrgRNTML5OEr4963MyejYsTjjzy1QfEOB0T4IMNP3LGz4zipnj+9eGw/GVuie9EDDs256s8LjZUNDtwYNg8s+Ob6wXgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fHH0pzLn; arc=fail smtp.client-ip=52.101.48.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFTm0a2xRdG5FErELtBJ8qeLNfDYKaaWsonKkUGfB2ftOoOLRnl6yG8d59a4YKaL6Atb3aIAwV8iN0scDR2bAa+fXWOgnRiNmGA0Mh0ki+xzvm9nvnCmGDRnn/F220x4+gHX77zHs1YRVcXi8BB8/iZ4KBxLBzQydavlhrN5FKW+5QEXhQ3RIGJpoqg7xZ+k+0KhIpsjftlSICWyub1Diy+2yeZbWuTnSL6RhCsW7wZEa1TlUlAF0wDbGP5pHjFzhctFGfVJ3f0MIMfVgn0zLueDG0i97KzduLtSHZ6qu8IvijxatgJi+8QdKHA63bfMzo8AVef3kHCLrjtDGmYBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKMYTHVq3I5r0cH0xkpcgZR5HTEutPjm5sku4RKyvVI=;
 b=tcHtfn8L+0IBCvMJKzM7IzZk4zqVJOvSLUaI6XhjBnWrSOlm4oiGqTpQJUWD8SdEIUnams32kAxjFV7qLN0fyfqDNoqTouMI3TiQAKp1z94VwcDo/W0ZkBHeGrFwZUz3e6W0KyTt9EYAhVmEgovi4gr5K7TZJBEyPvPVjWxDa0cpZSgNsXt9a2HxQ2tMlRAYF7BLBweheTIHMGrL5jeR8Y3J1zOsdpgVmtCx7b2cro3ZZaS2mOxU0QcBuZa6xsOaErL7B6/GItv/rirRyxOV6Dgb5MW997EZwSG9pXRR81fd97uLWpIazjr9lMDc3o8T5kdAU0i59Dh1DMI2ykKHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKMYTHVq3I5r0cH0xkpcgZR5HTEutPjm5sku4RKyvVI=;
 b=fHH0pzLnRpuDMoNeThLSdr47msum2MIYObaTGpuwgG3P0K5CLM2UnHuXB5U9T9RhfOfq13NI3WC2b+Rqhk+1AngJDOTuSPFh7yDwrJA7/mgxBh0BzuE4q/UVUCQckBTBWyIsYA6x77/AEQMXZSAhVj9Qr0EQ+eBtEKXX7yIHdqoKgsNn6pEX/DzMUzSdy1+icr42pvbhNoOCIimnhqclLGSOGuXQpR9C18GHAtSl//DqSDEWNrCr00sSQ20iNbJeUZSuBtOVD81WI8/llnsjvWNIAtgZ6TqAS3mVbe3MZQes+0UZVoYnWPRqylpi1EO/0j+J864R8kw1fhHHzMEJEQ==
Received: from BYAPR04CA0023.namprd04.prod.outlook.com (2603:10b6:a03:40::36)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:06:12 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::6f) by BYAPR04CA0023.outlook.office365.com
 (2603:10b6:a03:40::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 17:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:06:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 09:05:45 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 09:05:45 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 09:05:43 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v17 11/12] virtio_net: Add support for TCP and UDP ethtool rules
Date: Mon, 2 Feb 2026 11:05:17 -0600
Message-ID: <20260202170518.9076-12-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260202170518.9076-1-danielj@nvidia.com>
References: <20260202170518.9076-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a552c49-c689-4d08-83e1-08de627d5df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AOOewcY3gOGiPtlBZ9SLQVD7NNoK6nfacqPMgPK3Cx4ahmNhyG5JATlF25II?=
 =?us-ascii?Q?ojEnh1DzA7EzQ76LOdPb2nogSNO2YgTxzyxtlziY8S1p0D8kl4ROlTaC5qNy?=
 =?us-ascii?Q?Hv+aAzOeCgVju3WHd4oV7xtpd+vxokmlqdzRRq7u2wWZsZMLHCZl1wybf35G?=
 =?us-ascii?Q?Y460JIth+tzzHn4TVXSj7jWtE+4qAXJ0kxcHCxUY14PWB/sUA/zcsQ1Ro5oT?=
 =?us-ascii?Q?HXzgnZ5Hu52UZVF4VqLp/BMmEXvJBXdnjGsEZTtXZW23xg6qd4ACK+kgXNJD?=
 =?us-ascii?Q?f5R1mSp38H5yo8qpjbD9vvwwhldG90dazuPRJ6SbW8V46pMNZ7IqQ4fD0bek?=
 =?us-ascii?Q?eKG5R6O6ob0mbjFWPkUWZ7KtnmeEnrfSFvMST/4rkRzVjGMJpUEOYylbt/dn?=
 =?us-ascii?Q?9Qv6DIPB+p+XEBuDBz/h+eXtE/heUOdakcVzzRh+bAftyWXV3IoPqWT2Nro8?=
 =?us-ascii?Q?ZNjOcBMGZQSg4qJTxi2SfWcv71RMSfNECfnP0vhaA2Ca7/jacqcZxi19evL3?=
 =?us-ascii?Q?LY8N2ofAuHtQd+L83cbF36om2Bj9U3dG5Zdfx1zcXeV66qN5luD97SBKXzmX?=
 =?us-ascii?Q?mduiVSQjcBtfTqkNUTICjzAq5tR+05t46Kcr2hguzuLg/jWJkPXzQoNpjgUN?=
 =?us-ascii?Q?eEJVX/QsH6l//SHCN6r815nA33AoD7UjtCBFN+iyODawGMKOdHj2Wv09SYgQ?=
 =?us-ascii?Q?M9rEYh6ltMD9JfkAPQZGPU1Uwu04VhEmLIjAsrd5QMkNkeMcm/3Xl6K0fooe?=
 =?us-ascii?Q?/4NcRoxuE3/C2npr1MTiBO3q2pwXvYJCJTuL4nQezAojpxeP/h0/mmQCUrXj?=
 =?us-ascii?Q?KV8gpiPA7lS7wOaMPehe2hECm0K+uL+j52IPPVQtOCYYHeaKPJ7n0omzuvqk?=
 =?us-ascii?Q?qDiNXTkmDM/taFYg9rpBlPwJuVbxo37UFaVTbBbiFGDbLQas2lNXjnWEN5Qu?=
 =?us-ascii?Q?mZB9tqZ04GdLUuOeCHjQeoq4QAg8oEE5Bw2luDDKcJOfNGYMubXeVec3cAf7?=
 =?us-ascii?Q?tDQgovrcC4S/wQ1QSRZG88tiYBd8qoGHq002Sd70OX1eWW/iv4ysTT0BfFJE?=
 =?us-ascii?Q?DD39y58Tl3PU3aGxKCgU55r292yLy7tzhGB2S1pePe3fYv30bcGqBpInatGP?=
 =?us-ascii?Q?Aqd8P1CFNMoBppo+aKP5h/hB7i0zM+l7B17jwLdZ04afvKJYfpEfYU3VQZrr?=
 =?us-ascii?Q?/5SECre4oChinrDPQK1hYVqzd6yhPlEN8D183H0vJxe2PhD+MZRzPuxb+Rd8?=
 =?us-ascii?Q?E3pXP0wjZb7BriOZ4gDBbG1AxO2IYNsJI9G1pMUismOv+OsmPtEA6v3pkcKy?=
 =?us-ascii?Q?TTBUOgJOiscW6LBOgwibj89ZnqIeARQNw2VYn8NfGr7SSH0znY3yYJ7MPRFZ?=
 =?us-ascii?Q?mr9kTX+BjXcstD9o2+p5QYyyRNuE3RonraWhkBbIgJhOovuW4TIgt/8kT+Jf?=
 =?us-ascii?Q?KdNy488KDR3s4HT0ekuRZyxHwMLAJocmPBoAyJZQqaYZT5GUDbMmV8pUrF6H?=
 =?us-ascii?Q?EL7h4qfdpsRjBybo3wOnXWonEcBKVVm4JLmj2mWRF6rWQVX0O9uIk1rSpaul?=
 =?us-ascii?Q?Qguhowe+xuDwt9QmVsROgXhw4dgU9FzLAzUU35NtomaQmA2E6dlUVINjXyGq?=
 =?us-ascii?Q?p2wm5wFVijYb7Tni345sSL2EZ1OLkVIUKdWXZtYwKI0b6sMPJybRatpwd+0L?=
 =?us-ascii?Q?0oFEjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oSDM2QhMeMDjp4DJl8DE3fWPJC4mwySFIfiFViK32CeiahaB5SHu3tD+tnyqiZYG967J2hJRsHJJYZ0otTvvi0GrqHEXURp1QsgkkmWSqu+DGhsSMD7wZsgLQUc4cdKSRy+FiL8MxZqT5RlVsmBUJSqXTvAOzzdNuOptRHlcEqXrF4ZgQ43pOQq8uNFIfRPhvvZeWzezLVfvOVsLKTz34FDU+ic7jQUGTOq+P5ueMbWm1HhzfHGU4zGS88CAHmGcFPcgWRxguQjj7nKGJIsny59sXSdoMP4+QgZC7z36PpYuqy5NG3jsbPSZRUbh7lyR+EKZb74J2lMGA9d6Kgel/i5n/xixAYa+9jnAeVNg+56IkFRR/BOS9+yQHsFTXzOYOlYce3fP6c19gluFFy/bN9krbPe+X7X7cvUJxydA0qNo2I8qWowI8OO5nekHGg3l
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:06:11.9426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a552c49-c689-4d08-83e1-08de627d5df0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255948-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,alibaba.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5EF1CCF679
X-Rspamd-Action: no action

Implement TCP and UDP V4/V6 ethtool flow types.

Examples:
$ ethtool -U ens9 flow-type udp4 dst-ip 192.168.5.2 dst-port\
4321 action 20
Added rule with ID 4

This example directs IPv4 UDP traffic with the specified address and
port to queue 20.

$ ethtool -U ens9 flow-type tcp6 src-ip 2001:db8::1 src-port 1234 dst-ip\
2001:db8::2 dst-port 4321 action 12
Added rule with ID 5

This example directs IPv6 TCP traffic with the specified address and
port to queue 12.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: (*num_hdrs)++ to ++(*num_hdrs)

v12:
  - Refactor calculate_flow_sizes. MST
  - Refactor build_and_insert to remove goto validate. MST
  - Move parse_ip4/6 l3_mask check here. MST

v14:
  - Add tcp and udp includes. MST
  - Don't set l3_mask in parse_ipv?. The field isn't in the tcpip?_spec
    structures. It's fine to remove since it is set explicitly in
    setup_ip_key_mask.  Simon Hormon/Claude Code
---
---
 drivers/net/virtio_net.c | 223 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 209 insertions(+), 14 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 39af6be5abbf..1af73a765d85 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -31,6 +31,8 @@
 #include <net/ip.h>
 #include <uapi/linux/virtio_pci.h>
 #include <uapi/linux/virtio_net_ff.h>
+#include <uapi/linux/tcp.h>
+#include <uapi/linux/udp.h>
 #include <linux/xarray.h>
 #include <linux/refcount.h>
 #include <linux/unaligned.h>
@@ -5886,6 +5888,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_tcp_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct tcphdr *cap, *mask;
+
+	cap = (struct tcphdr *)&sel_cap->mask;
+	mask = (struct tcphdr *)&sel->mask;
+
+	if (get_unaligned(&mask->source) &&
+	    !check_mask_vs_cap(&mask->source, &cap->source,
+			       sizeof(cap->source), partial_mask))
+		return false;
+
+	if (get_unaligned(&mask->dest) &&
+	    !check_mask_vs_cap(&mask->dest, &cap->dest,
+			       sizeof(cap->dest), partial_mask))
+		return false;
+
+	return true;
+}
+
+static bool validate_udp_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct udphdr *cap, *mask;
+
+	cap = (struct udphdr *)&sel_cap->mask;
+	mask = (struct udphdr *)&sel->mask;
+
+	if (get_unaligned(&mask->source) &&
+	    !check_mask_vs_cap(&mask->source, &cap->source,
+			       sizeof(cap->source), partial_mask))
+		return false;
+
+	if (get_unaligned(&mask->dest) &&
+	    !check_mask_vs_cap(&mask->dest, &cap->dest,
+			       sizeof(cap->dest), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5903,11 +5951,47 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
 		return validate_ip6_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_TCP:
+		return validate_tcp_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_UDP:
+		return validate_udp_mask(ff, sel, sel_cap);
 	}
 
 	return false;
 }
 
+static void set_tcp(struct tcphdr *mask, struct tcphdr *key,
+		    __be16 psrc_m, __be16 psrc_k,
+		    __be16 pdst_m, __be16 pdst_k)
+{
+	/* mask/key may be unaligned; use memcpy */
+	if (psrc_m) {
+		memcpy(&mask->source, &psrc_m, sizeof(mask->source));
+		memcpy(&key->source, &psrc_k, sizeof(key->source));
+	}
+	if (pdst_m) {
+		memcpy(&mask->dest, &pdst_m, sizeof(mask->dest));
+		memcpy(&key->dest, &pdst_k, sizeof(key->dest));
+	}
+}
+
+static void set_udp(struct udphdr *mask, struct udphdr *key,
+		    __be16 psrc_m, __be16 psrc_k,
+		    __be16 pdst_m, __be16 pdst_k)
+{
+	/* mask/key may be unaligned; use memcpy */
+	if (psrc_m) {
+		memcpy(&mask->source, &psrc_m, sizeof(mask->source));
+		memcpy(&key->source, &psrc_k, sizeof(key->source));
+	}
+	if (pdst_m) {
+		memcpy(&mask->dest, &pdst_m, sizeof(mask->dest));
+		memcpy(&key->dest, &pdst_k, sizeof(key->dest));
+	}
+}
+
 static void parse_ip4(struct iphdr *mask, struct iphdr *key,
 		      const struct ethtool_rx_flow_spec *fs)
 {
@@ -5949,12 +6033,26 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
 
 static bool has_ipv4(u32 flow_type)
 {
-	return flow_type == IP_USER_FLOW;
+	return flow_type == TCP_V4_FLOW ||
+	       flow_type == UDP_V4_FLOW ||
+	       flow_type == IP_USER_FLOW;
 }
 
 static bool has_ipv6(u32 flow_type)
 {
-	return flow_type == IPV6_USER_FLOW;
+	return flow_type == TCP_V6_FLOW ||
+	       flow_type == UDP_V6_FLOW ||
+	       flow_type == IPV6_USER_FLOW;
+}
+
+static bool has_tcp(u32 flow_type)
+{
+	return flow_type == TCP_V4_FLOW || flow_type == TCP_V6_FLOW;
+}
+
+static bool has_udp(u32 flow_type)
+{
+	return flow_type == UDP_V4_FLOW || flow_type == UDP_V6_FLOW;
 }
 
 static int setup_classifier(struct virtnet_ff *ff,
@@ -6094,6 +6192,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
 	case IPV6_USER_FLOW:
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
 		return true;
 	}
 
@@ -6135,6 +6237,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 			size += sizeof(struct iphdr);
 		else if (has_ipv6(fs->flow_type))
 			size += sizeof(struct ipv6hdr);
+
+		if (has_tcp(fs->flow_type) || has_udp(fs->flow_type)) {
+			++(*num_hdrs);
+			size += has_tcp(fs->flow_type) ? sizeof(struct tcphdr) :
+							 sizeof(struct udphdr);
+		}
 	}
 
 	BUG_ON(size > 0xff);
@@ -6174,7 +6282,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
-			     const struct ethtool_rx_flow_spec *fs)
+			     const struct ethtool_rx_flow_spec *fs,
+			     int num_hdrs)
 {
 	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
@@ -6186,27 +6295,99 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 		selector->length = sizeof(struct ipv6hdr);
 
 		/* exclude tclass, it's not exposed properly struct ip6hdr */
-		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
-		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
-		    fs->h_u.usr_ip6_spec.tclass ||
+		if (fs->h_u.usr_ip6_spec.tclass ||
 		    fs->m_u.usr_ip6_spec.tclass ||
-		    fs->h_u.usr_ip6_spec.l4_proto ||
-		    fs->m_u.usr_ip6_spec.l4_proto)
+		    (num_hdrs == 2 && (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+				      fs->m_u.usr_ip6_spec.l4_4_bytes ||
+				      fs->h_u.usr_ip6_spec.l4_proto ||
+				      fs->m_u.usr_ip6_spec.l4_proto)))
 			return -EINVAL;
 
 		parse_ip6(v6_m, v6_k, fs);
+
+		if (num_hdrs > 2) {
+			v6_m->nexthdr = 0xff;
+			if (has_tcp(fs->flow_type))
+				v6_k->nexthdr = IPPROTO_TCP;
+			else
+				v6_k->nexthdr = IPPROTO_UDP;
+		}
 	} else {
 		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
 		selector->length = sizeof(struct iphdr);
 
-		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
-		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
-		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
-		    fs->m_u.usr_ip4_spec.ip_ver ||
-		    fs->m_u.usr_ip4_spec.proto)
+		if (num_hdrs == 2 &&
+		    (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+		     fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+		     fs->m_u.usr_ip4_spec.l4_4_bytes ||
+		     fs->m_u.usr_ip4_spec.ip_ver ||
+		     fs->m_u.usr_ip4_spec.proto))
 			return -EINVAL;
 
 		parse_ip4(v4_m, v4_k, fs);
+
+		if (num_hdrs > 2) {
+			v4_m->protocol = 0xff;
+			if (has_tcp(fs->flow_type))
+				v4_k->protocol = IPPROTO_TCP;
+			else
+				v4_k->protocol = IPPROTO_UDP;
+		}
+	}
+
+	return 0;
+}
+
+static int setup_transport_key_mask(struct virtio_net_ff_selector *selector,
+				    u8 *key,
+				    struct ethtool_rx_flow_spec *fs)
+{
+	struct tcphdr *tcp_m = (struct tcphdr *)&selector->mask;
+	struct udphdr *udp_m = (struct udphdr *)&selector->mask;
+	const struct ethtool_tcpip6_spec *v6_l4_mask;
+	const struct ethtool_tcpip4_spec *v4_l4_mask;
+	const struct ethtool_tcpip6_spec *v6_l4_key;
+	const struct ethtool_tcpip4_spec *v4_l4_key;
+	struct tcphdr *tcp_k = (struct tcphdr *)key;
+	struct udphdr *udp_k = (struct udphdr *)key;
+
+	if (has_tcp(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_TCP;
+		selector->length = sizeof(struct tcphdr);
+
+		if (has_ipv6(fs->flow_type)) {
+			v6_l4_mask = &fs->m_u.tcp_ip6_spec;
+			v6_l4_key = &fs->h_u.tcp_ip6_spec;
+
+			set_tcp(tcp_m, tcp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
+				v6_l4_mask->pdst, v6_l4_key->pdst);
+		} else {
+			v4_l4_mask = &fs->m_u.tcp_ip4_spec;
+			v4_l4_key = &fs->h_u.tcp_ip4_spec;
+
+			set_tcp(tcp_m, tcp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
+				v4_l4_mask->pdst, v4_l4_key->pdst);
+		}
+
+	} else if (has_udp(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_UDP;
+		selector->length = sizeof(struct udphdr);
+
+		if (has_ipv6(fs->flow_type)) {
+			v6_l4_mask = &fs->m_u.udp_ip6_spec;
+			v6_l4_key = &fs->h_u.udp_ip6_spec;
+
+			set_udp(udp_m, udp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
+				v6_l4_mask->pdst, v6_l4_key->pdst);
+		} else {
+			v4_l4_mask = &fs->m_u.udp_ip4_spec;
+			v4_l4_key = &fs->h_u.udp_ip4_spec;
+
+			set_udp(udp_m, udp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
+				v4_l4_mask->pdst, v4_l4_key->pdst);
+		}
+	} else {
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -6246,6 +6427,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	struct virtio_net_ff_selector *selector;
 	struct virtnet_classifier *c;
 	size_t classifier_size;
+	size_t key_offset;
 	int num_hdrs;
 	u8 key_size;
 	u8 *key;
@@ -6278,11 +6460,24 @@ static int build_and_insert(struct virtnet_ff *ff,
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
 	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
+		key_offset = selector->length;
 		selector = next_selector(selector);
 
-		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+		err = setup_ip_key_mask(selector, key + key_offset,
+					fs, num_hdrs);
 		if (err)
 			goto err_classifier;
+
+		if (has_udp(fs->flow_type) || has_tcp(fs->flow_type)) {
+			key_offset += selector->length;
+			selector = next_selector(selector);
+
+			err = setup_transport_key_mask(selector,
+						       key + key_offset,
+						       fs);
+			if (err)
+				goto err_classifier;
+		}
 	}
 
 	err = validate_classifier_selectors(ff, classifier, num_hdrs);
-- 
2.50.1


