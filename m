Return-Path: <netdev+bounces-252082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLBmKspOcWkvCAAAu9opvQ
	(envelope-from <netdev+bounces-252082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:10:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E065E8C2
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA41A60455F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B09744102F;
	Wed, 21 Jan 2026 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CpjWx47Z"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013036.outbound.protection.outlook.com [40.93.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3F225760
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033301; cv=fail; b=BSH98OTBMbzAFwZOnTX+arGFsaifpvbULgmvg902OFG518/cRld/rSHvfdTc+lqL9HOWplZhoVYyqtrdBPIT18orvOAx+W/P3reI+2COucKVXZwJaqtBtAYn/X79SAWYeu68YRByI3wnOGICaP0RINboukT3VpppmmXfOjhJhH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033301; c=relaxed/simple;
	bh=tla85qvdh25J62gw0tQvMRf4tORIr0kuDyjWZ0PiD3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YySlFGnmPT382AKpNEhX4sv7LneITpihGBtcSugw7/+csEZml2RO2f6n+mY7BMEcMZXbByx/3AVYw3mSOxJ5qQRU8zvkGLYzrp+2zdZSWxKF/9ZcCr6zbeqS0ZH5S1el4s2JDC4m6oQvjAM9yZXXvVJvhmOerYOlhr6LKimtSzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CpjWx47Z; arc=fail smtp.client-ip=40.93.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPzfz0zyzNmV6Or09jb4DbqCNaD+HewHx0st37cCke1Y9+tkK23rcA02waYuoiwvqqmo0O/faV37+ygvB+mYjmHOmVBYICkKymtDlElSUvVznnewELn54UDs4DWfxCQs1MAhFMoIAJNX2qKANjFekMpPxGlI2R+Q0APq7tBMvebMQk/Ydi9um90fzpqpSt5TUP1uhcA+4Jn6kymSCe90IxEagvA5Hf+iGYbSdZFqqMxv0dH18T6FO9JcZlWBY2wVtm5S/ujcyDXY5vKA3CgEw1Jg4OM01h4U/tdJYcMxwHDMrrp5QStQOb9R27ZOXRx9OzSIawBk5u/GeXgrFNjA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zq0VkHtAJPkb8hoIpzIJGTPYW8aBkNFsRnbOCJTKL04=;
 b=byauoW53hYd/5lBtqUROIJR+XLmLf/AlEZFMeQD9407BK0x6zFgxHeqbijEUk+2b655Wjcll8C6O8skYW3vXFO59VYwNHkbxiJoDoz4xRaWocNfXujJ38jRrorVAzVtBBXItXMgI+jG3d10Wum4Vi6OKOkfOg4vkgWZUUpFrFQTaQqVRTDtMnQrsLobshIq+Me75SvMvdHI6EOHOUfDsZD8A7ljZpNLM5FDqtC79oaCsAd9XVnH82z9jCiDEbh1RWNzfmkjWysgZ8Ln+diADq7sQT7cBXFF2UH8W5Ak8SwpPnhCxKlrfEQhbqqzTpuYnStB/8PxhcMV0mnD590b4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq0VkHtAJPkb8hoIpzIJGTPYW8aBkNFsRnbOCJTKL04=;
 b=CpjWx47Z+VCPxATLCMnwBP7HiwnkmO5fqlmivEWgPIbWncFklwp3ME0zE9BYvnhY28cQT91DQXcwEP7kduq2rCGndXffFKktT8XTMFFc/9GQ/14ft75PQWb+KpRPF1bO+vM20wRywE/26sl9kNhbP2hd2zTRXMG7eqVGfplqKv0KuEbsAgVquTzAYkreoaivlRVgWdTMy/TqTCCcceu9m8+TXiMtnBBhfwreJSiSegbUSmMkqpTEJz2BF89Yjmt1LxW3YeoT9rVFZenaWm26YZs5qU+eRzwlyR0TOfrG2H3NjVjHaREVvkwgNpbcmbxPt+z3Clbpw10eH4+IH2XuXQ==
Received: from BL1PR13CA0199.namprd13.prod.outlook.com (2603:10b6:208:2be::24)
 by IA4PR12MB9761.namprd12.prod.outlook.com (2603:10b6:208:550::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:08:16 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::bd) by BL1PR13CA0199.outlook.office365.com
 (2603:10b6:208:2be::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.2 via Frontend Transport; Wed,
 21 Jan 2026 22:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:08:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:51 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:50 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 21
 Jan 2026 14:07:49 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v16 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Wed, 21 Jan 2026 16:06:49 -0600
Message-ID: <20260121220652.894364-10-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121220652.894364-1-danielj@nvidia.com>
References: <20260121220652.894364-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|IA4PR12MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: ba015016-5c16-4d7e-f6fa-08de59399291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fh4M9nDie6XClgpzq0qnUKSgudhaniTwapx0B5GBRQlWNNDyFf47CJntGBXL?=
 =?us-ascii?Q?vgEDNaumdwVQTgJRr+eM5FJPta/oJRNjpaWn5mCjkgCUiVwALK/cjnll5j6q?=
 =?us-ascii?Q?tN+wTxrI4yzMZnwlT3N/ZEUA3c/ms/F2q0jzc90PSaJF4LhEp+geQOlqwBmk?=
 =?us-ascii?Q?OyrYQv07V9jwfI64cebeb4u8PAjq2FgRs1XQ356cpJ9hmUI0aTu7wBhKtBna?=
 =?us-ascii?Q?8wUUF7su4cZ/Vk/kHX53YnZrbFnlE0dLNFgc7Z19jUOzzIzlnrrrL3H3tePe?=
 =?us-ascii?Q?8WKYz5N4RR4GQN4jfUCuQSnI7nsVvBDirYZaqeGIT88FkaI5YTSfr+Nkp/Kk?=
 =?us-ascii?Q?mHQrMnj/Atg8dN/nHf6gjOh84K6DFCxCtgF2Y4Gu1apZV4pHeIzqHcyFYfx0?=
 =?us-ascii?Q?DdOMTm+L2B1duPc5Fu1vUIb2n9A2Tlq7+zJ+E+gl2qRa7MzsMNdCkisHglEV?=
 =?us-ascii?Q?wyfzG8IBU+ZUZjHSZtuiU+IGNH4f8UqiF516aXV+tEHzt8VlQSDlxh6bz2Tc?=
 =?us-ascii?Q?tk7XnODETy33HsKePwQO75VWCN4fZiWyqmQzOgmAzxZYqcwa5F1CsDSUiEde?=
 =?us-ascii?Q?xGfoJRhRxE1K3IkZf8ucO2bykNnzo94ytNKHLC9CtoQkgWzGgot0nnbhN0Xc?=
 =?us-ascii?Q?ftarZx7x7mYGqcV5QGbb5yrAx8+1iAcNEss4fKF7lO2obozrV5RvhYLoz8vJ?=
 =?us-ascii?Q?jwPxcqYaP9VN8qTRygUmPOdoDdJgByWNx1fRbBFYbDnwxZ+F/iObK4f1do9o?=
 =?us-ascii?Q?a07QwSF0o6kA7ttVWP/dx9yc39uVA6PAY8ZtOJm075/xp8q8MTTnxjoyAxWq?=
 =?us-ascii?Q?XXbAzwZ58pWCQOlJ3MGdXTFiOnBBansB1vmElflfnFQP0AwSkkLWDwDNs6jg?=
 =?us-ascii?Q?YCXzwmzs198fjS3cC5EuRphqru1aG+a0DISLcNOg8JJosk4a8UJmDqOjpvdB?=
 =?us-ascii?Q?q3u4Oin8IAGYMrn8mc7NXGRnXpcDG9W1qzW91MlY8BxLNQUy7oNl+mbvpcri?=
 =?us-ascii?Q?FWtPh04a8hDQOQPfcqV97gOWUSsE1Z7zj8USgbehHBRzdipQElW57a1C4RVQ?=
 =?us-ascii?Q?rAs/gMhNc85TVq/HRkVKQ+kNp7qfhRS/SrNkfyjGjSUqt8WB8+TJSOk5eiRU?=
 =?us-ascii?Q?0Glk2nyli8uxGnIs4SUu0cAjGCszsvkk1T3DtTULW9horEukH22vPL4EDnj+?=
 =?us-ascii?Q?SMPgpZ+u924K1rc5ftqLGF0IdBUPQeKtPXwoqPzTWrvcqe3ThJv0pzVcrx77?=
 =?us-ascii?Q?cEN9VbKA3vRZD1TGuFx6+hyVyn4FBik/vOGVCjBQtH7qmShj/sdGl3wBk9Zv?=
 =?us-ascii?Q?fYdKycxpvJud+VpD0MVeBOjXvucNSBOHQZjrfPDRyI0rnwvc08nV2Z1QsyCP?=
 =?us-ascii?Q?fvRBjhKhC9nAeN9wqk2duyl9OzikoVx7G5ErJdDaBabbqFa7OHvVH7YJyzVA?=
 =?us-ascii?Q?qBfBNxnlfg7b9GACpSCWvhz9iEFxxTPO6I83yyUKR6zM/veIs7kKnF6mbg71?=
 =?us-ascii?Q?yqbIOB7xV86HB9/ErVHex658H81yIj60Zv1235WY2Z4MHi4d2xGWJYswpHPl?=
 =?us-ascii?Q?JqfSyeKrubqaBEC1M7iTh4rjpSBZi278zFWTEGlnYdAeN/4FUYoDqQksfyeZ?=
 =?us-ascii?Q?JidEiQJfzOykT4ZYjpNa9uLyOhVnDwRaH4xvINkrT+w4VNmHAILZ6wOmPDqN?=
 =?us-ascii?Q?cl+cvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:08:13.8349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba015016-5c16-4d7e-f6fa-08de59399291
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9761
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-252082-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,alibaba.com:email,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2605:f480:58:1:0:1994:3:14:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[52.25.139.140:received,216.228.117.160:received,10.129.68.7:received,10.127.8.14:received,2603:10b6:208:2be:cafe::bd:received];
	DWL_DNSWL_BLOCKED(0.00)[Nvidia.com:dkim];
	DNSWL_BLOCKED(0.00)[216.228.117.160:received,52.25.139.140:received,10.129.68.7:received,2605:f480:58:1:0:1994:3:14:from,40.93.201.36:received,10.127.8.14:received,2603:10b6:208:2be:cafe::bd:received,10.129.68.6:received,2603:10b6:208:2be::24:received];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E4E065E8C2
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
---
---
 drivers/net/virtio_net.c | 129 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ba231f10b803..7ce120baeb41 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5818,6 +5818,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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
+	if (mask->saddr &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (mask->daddr &&
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
@@ -5829,11 +5862,41 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
+		mask->saddr = l3_mask->ip4src;
+		key->saddr = l3_val->ip4src;
+	}
+
+	if (l3_mask->ip4dst) {
+		mask->daddr = l3_mask->ip4dst;
+		key->daddr = l3_val->ip4dst;
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
@@ -5969,6 +6032,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -6000,8 +6064,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6013,8 +6087,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6022,8 +6097,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -6045,6 +6147,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
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
@@ -6082,7 +6191,15 @@ static int build_and_insert(struct virtnet_ff *ff,
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


