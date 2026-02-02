Return-Path: <netdev+bounces-255943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMbPNCPagGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:08:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDBFCF638
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 218ED3030EC1
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F88637F8A3;
	Mon,  2 Feb 2026 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VghnSkwE"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF853815EF
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051967; cv=fail; b=d5Ld31ovxqrmN+1p1cbgb7EQJMBwXksZOepo4MoAM1aMbpw1Rp2O01ual513JZYUQaGCSPUZRfhfoTiuQnrX3skQGzUFQINfIp7SSi1aNdQuigXpUOytB7KwYXNefyEP0HiSKdVq7qQZbFowXH7TH8NiPSqUQaE8+spnfjdHlyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051967; c=relaxed/simple;
	bh=917rsUYGXhfcfAH97SM4jgndsIudtNyeq7TgQnLYrNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvDP/MB9U4lOVinGwf9rnFnFC0eZDtSaVM+spdANIeBEFdJbtTUIDw6IR3D/AMmLt1U0h8Y7IAxJeY88sE6CFzHzzZS9BjifBMy+LASmByphgGLgja5TiEgdS/cnHkGwsqCBLgluEO1SuNs8RC8+SKb8s6sIRJh3sKpRxWOuHwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VghnSkwE; arc=fail smtp.client-ip=52.101.61.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKcjDAwwGjTwEPA7w0gWOzPFOoryWLylUQHAowTpE2TauOkBON8F7R1RlLqazF/3dD8rLVmFY9S5HM8e978anu6apT63j8Yhi4dbDjMxHgGVH1uG7WVHAaqYsylm6HCFZvnBrd8Isn10IUR5KmetTupRQKXsSmyWh25MpD8uhZZxJGjxkXSaqsip3izP5KVBUekONabTA3yp2xaSU/6PmOtvnvj1nm6osl6UNNmjjG5+ehxCMBZ1qKPFaTtfz9xMBDanrJxVdI4zyLHyRpPo0Bk5vNOzeJRDT63bySZqR2pbtF8FIRJuenuTF15tB3Ypt2Og3L7R2pdgcTBGzIGRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Pj0JY997AknRU+XlBHq6hPA3kJTw6dWHLqDRZIZ7tE=;
 b=zOrz+MS7f2OaJLsJN5IjPTkS2INJfhJCBP/sp0O5JHGA+jrUI57nTW9P2dvrswTJXrhrXq8rnH71utJsArIKZhLjA40Y1k2Ao9XmQrgxAf4CeC0Pj91cQWkmze81nU/YAHXhIUcjqrrjp7LhWKnvJ/DM/Lf+3dAYMVqBb0drpORzRqqazKJfNFPyPnfga/F+yfRIqs5+V93wHbvb5/KzTjV1yrqK0ordy11ythlQR+L6vHpe82ZjkrFOwq38G9VfDXcgQVXHg0Dmwpq1Q8RmAElwp8ARkYzD5WLZ+ox3ar7wrAoGW+Is7LsxAlGLgTnHJWiy/2/SemUWMBmA2FLxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Pj0JY997AknRU+XlBHq6hPA3kJTw6dWHLqDRZIZ7tE=;
 b=VghnSkwE80oHMfpGuZxTPZ7PhdjVlFo5dXmbnj06l/DCX5CN0g5TmRrNlM2TinFW632UZr22eKAfP+QZnrDhuGSvnNUWO5fA1jAvweRfOzsgkmRfNr0o1qWxfVNtvyebyMdphpOiFTU+x+92G+CTNla+wdhb4o+29tdyYtaU826kUJvMPG1kIBqHhzUSXtgQlUAyKvMZDTi1n7N2tCJ/A8q4Yz/DFeN/eDFPFbOfZjLJKV86B9d+OjyDGwosF00Sb/FWvsrXkGG847yeNdfr+CtScqm0/O5oo9K1xOD2Iu1xBwxjs6HSl1anwhg5TdH8XFKwgpJMZQSG1DQKnzRS5w==
Received: from SJ0PR03CA0247.namprd03.prod.outlook.com (2603:10b6:a03:3a0::12)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:06:00 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::4b) by SJ0PR03CA0247.outlook.office365.com
 (2603:10b6:a03:3a0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 17:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:06:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 09:05:43 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 09:05:43 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 09:05:42 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v17 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Mon, 2 Feb 2026 11:05:16 -0600
Message-ID: <20260202170518.9076-11-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 8305d0b9-822f-4825-d259-08de627d5716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8GI6d0Tu6X4LVauRR1yuXtuzN+SY4U0GHxRgPX0WwGowWNFRhY2ELUrK8BqW?=
 =?us-ascii?Q?U+ne3SJf8TZwAtc30ClNpZOT0yGOEhRjUTfyHexNFSC0Erddv1/duxqT/Plc?=
 =?us-ascii?Q?f6CGjh50u7dMoTjM0XCXIM0KYbKjZJYdtqf7LQg1auYWM3wyi3tMGin+vsqp?=
 =?us-ascii?Q?CfNnMdYaC/Hd63VW6S/kDdnSNramnI7mT/p0M+cDjHahyDjo4qfydcEOnzAW?=
 =?us-ascii?Q?MyDmQAQAyIhpoLDPp9pMzGbtiiVNzPsFbkvrX64yDyz7ZHLlhMINFu+M1i6v?=
 =?us-ascii?Q?zAHIPReh5DCooqZr4vfm+uVNeMrYIP1L8Yc3yNCOqg5X5oNLjuFFduDTj0X6?=
 =?us-ascii?Q?vlDFzcIYm6wk9RuxGI9mCEdPtjDfTDgYOs20gwqzjn+4kje14cmIOfRlusKV?=
 =?us-ascii?Q?d6JjXDWUA8XXMKK2Wlk17u0o0Iwu3KulwrfaC/5Cu94eym4lzvt41KTnvLul?=
 =?us-ascii?Q?aUeBXDf/kP77bshiyBpsHlkRKP52k+N7NC27WSoBZdgH83mnMk0seLxRa5Hy?=
 =?us-ascii?Q?aPnPjNaWvy3LhOykOiFTBD7JTMnJlf7YJagnX7oz+ERhhlPVjfeg2YXO6cX5?=
 =?us-ascii?Q?IKS5Ycy/dWYP3CyDfB0ziV49P+pQphemJ5/rYCFSy8B7EvwPnAW/Jq1HrgFn?=
 =?us-ascii?Q?mtqqptMih9FqWviwV3T8dzj/hjNrK9ecAwFrDcE46x2YzD/daFgoA+B20LtI?=
 =?us-ascii?Q?ECpQH+6GiF63tFC+HZzWnPDLo9ZljPvrpYNmDbABcnlzKXTwpWxh+LQDVT13?=
 =?us-ascii?Q?HdeY/1+JSaqUw5jbeq/HOYomFoDXrpPhXYTnzVUOqgQG/ez64TMNrDeVIU5I?=
 =?us-ascii?Q?YaxyCq2PbzmTKtRUR7RtIKYjPhCZbWGb62oZcqY8plD4wGCTSLqmQcGzr2dl?=
 =?us-ascii?Q?UsKKEW97Qu0Q9faEP9688o6Tc4b2NIpRu0wu43t+HkoKQauLLHg4/91nDj22?=
 =?us-ascii?Q?o9RE8jNblNK81l7/XwB2wZ7N9R1seCGeOacPveOqDX93BM7eCdC0HiFuEfiv?=
 =?us-ascii?Q?kNAS9Egz6Y8bMs79xxW7N9TdBMj8OvnjCd96cVzhzAdknHpjniAYalzqWKdY?=
 =?us-ascii?Q?8T9AW1+WgpyjlI8U0qqvF5FdhVi7f8FmI4qJ2vIWSbO9Z4rcCXmzkVTz5Off?=
 =?us-ascii?Q?4x9v+Aab2dxGAsN1cGjvBjOlMbVTrc72q7JVN//RmWjqrcsgAJIHJZwERFqJ?=
 =?us-ascii?Q?ijeBK1wqR78JimNHFvMldgHden3KkdZ81kfIqRYlDLjC8oEJkJe+A/WFJyZc?=
 =?us-ascii?Q?/RvxupSfbIXWIPMONpoeIhbzi201qT8vrjUEwbQ0ZZFFeOzjSKSMltZpdfxR?=
 =?us-ascii?Q?yUtH422crdriMRAjVPB3150ciKYiINHcO37QXW4vrAleDCCIbRk6LFn1g+TA?=
 =?us-ascii?Q?ctZYGcqYOJbr7LvZyxS+6gLkjvqcNVKPaRd2XlcJGqTJ2DZmewcfqinqxqt/?=
 =?us-ascii?Q?smYIcLMA+cMKRqTOTrkoEwzUulcxXp343ENCvwVg/xKcCLfdoJ0opEYTQPT2?=
 =?us-ascii?Q?pdp954CC3cJbL9oz98NarVKX6UYVDz4tYQ4V5TJrrSBy2z1PL+9w/j19CGJo?=
 =?us-ascii?Q?dHn8oWPu0z2QlCCZrfa3Yqd8v5fJ9IiucR3sbk5EJZMglpcwnyq7DWFd54zM?=
 =?us-ascii?Q?nEnc4yijzAs+ZY1ma6C6pr8mrghjap7Wd6b68cIU9jbKCPcsQHL4mfM/JgXQ?=
 =?us-ascii?Q?nQpBig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8CR71YLTbEwb4Sl3D0TTYBNBb1LCHDCP62S9GUAcKDYcABSjjY7cE9djBSIp+249RUC9uFBifLInCp67C88T0WTChm+7budUMbCtlp+VNtwyMkYqTeRnlUeUBbuJnRIa0Se9eluIxeYcJtZi+vkUQfB41W9lA9+8Zn6IEusTBa/TReOcWul1xH901rgEHDXc04EzNkzlNZ57+iLIhD5Vw3WlNF3cpTMM4eAemtssafNAV2eCM6Avp8xdpefIZpl98bn1RdPgLS/2iTiLnEoSk6CrayDZ6GeHEUg0IMkXQawLYKauqW/hFIjLaw2IEwBUJu1/Jkm5TUG8BOWGiMJouelzoDIPr61m36Fa7g9P/GGHsLDD8nmCa/yKg14cLy+mY1fXqdIFmE54+vP4+NOcvw3URDr3g7qxgeOX+VPG87JZcU5cVSYFONrgdticLgcT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:06:00.4527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8305d0b9-822f-4825-d259-08de627d5716
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630
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
	TAGGED_FROM(0.00)[bounces-255943-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,alibaba.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7CDBFCF638
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
index adf7b493ac90..39af6be5abbf 100644
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


