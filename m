Return-Path: <netdev+bounces-240793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 372FEC7A8C4
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9E46361F37
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 15:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B359C351FA0;
	Fri, 21 Nov 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YumG26cq"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC425A324
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738274; cv=fail; b=fpAsm8mNMMDix6pfQHce1Uk8s0+S2cPpVs/QML23xLre1V8LGSHiiORZBacetrUGpb9Ivc35KHyGWKYS7YlNKQ0DB6QJdA6QK4NPj8aquXMEYoLSzINWk0hV/Jg4VERrdejMI8Y/8Au7J35YWRNvP4TffzIpdLxTGqdsgApK5Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738274; c=relaxed/simple;
	bh=TI9S2nPvFwyeTR/FC00Lo2Gz8ST4zo2DlZBGmhvhbqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOO+x0QUXwklOMynI5Cqmv5aVn/m3P9ZcHkWinruG2KCCbYlDJSRmJ6MBsogABqzDFDDGKey4jNROOJfI4exB/YdrMZcGsDHTv4WOHAXsQiBNEhvNxHOpkAgeqtjoaAYo67RaPcQwmUZ4rBNjCWz9bmW6hr5cSoKJgk+PanoKPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YumG26cq; arc=fail smtp.client-ip=52.101.85.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUoMq8CVZKGyIGGP7dUSIumMIrutwjEbBtS/Swq/ZVenRJWhx81Vyz2z5wkyuJobrfVvkaOIV/ycTbep2kMnm7JoLLAwiyd0ykoSif/Yt//NpV9riT9twTccOjjFjchkFyg9S9RSdyiaAeQ+ZeQRSuM19Syq/dWotBD7NTKy0IeZwYx9FJVFhV3K3qhLQYrBY0qBompM1iICZq/SbGuAWLLJGNxykPS2ra9RWhKycqkxWtbiUFLB+3eQBboepKjOEFjupawaK+nJuCPoDmNZO6mSZJoWHG85/TKgIj5fO6J/IwWxl+vqQkunHOradsBFZEZT6tCFu/q09ypvlxU3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/Y0xTAkEaWUpOHpWkS3pCCd/ekrvvRPsX3Kfn/Vls4=;
 b=ZOlMBYbUlQYVnbjeFcr2ZCUirdjelG6J44yPEZODazgEtnOjkWySeujC3fn4QOVbLB2q54BgkYdd+oDJsIRbntall0Pzgdtub4XFOqgdlw2Yq/EPOX7zvZS6rh9uL0KAtt6FMGpa0ux1HBEq/FPvsufQdGKo7OeHTrF3UCwiavxqfG6DP/78RDtch7lbblGlc8PICjCjbBAlwQ0SguCjdh4Yf5XFgsDrSii91ipKVX9+nWomYHwyuDYCoGEdq3DsouHcEcZLj6HafdvtzeJCeCwMb/JPosi4j+ClTWQoqHWMukSwL+XJ8gV7N9nLj2n5VRYiRfprzIfw7U6l0nY7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/Y0xTAkEaWUpOHpWkS3pCCd/ekrvvRPsX3Kfn/Vls4=;
 b=YumG26cqNTu/G7Smy3qoxMoySqqgFF2pxBrUgRCe4UYoEZsNqCLyShTgZZ+pVtU7hqJezN/mGf4xmLomphFFNkdgMak9yBfJ4Vjx3WLSFS9praNfe6U/mSFiuF0lFsJ3PKBgKEwDErFHwtgrzwhE5K2d6JCB7fl2ZWflq0p6HwNnffMRS0+Mx15g12InaZ00+fH4Jy6QwjijaX3AiettUSl0Ot0H/38IQhc3z6fW+TSvy7LYSOC7o+vinBXeV/uu8Yq/LuNXExU54IdQDvhiXDlV22KiUrWJum88A1In1Q2j1uqGZQpT6urihy8ibqcaD9+T86DswxVa5fmd6Wje2Q==
Received: from CH3P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::8)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.12; Fri, 21 Nov 2025 15:17:42 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::e4) by CH3P221CA0016.outlook.office365.com
 (2603:10b6:610:1e7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.13 via Frontend Transport; Fri,
 21 Nov 2025 15:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 15:17:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 07:17:25 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 21 Nov 2025 07:17:20 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>, Jianbo Liu
	<jianbol@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [RFC PATCH ipsec 2/2] bonding: Maintain offloaded xfrm on all devices
Date: Fri, 21 Nov 2025 17:16:44 +0200
Message-ID: <20251121151644.1797728-3-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251121151644.1797728-1-cratiu@nvidia.com>
References: <20251121151644.1797728-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 41978836-daf0-4c0a-f1bc-08de29111d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cy6PDFdOsPImvPzkgTc1sRmypuC0nztiyntOcbggEAxPza8pV1l2a2vvqjIE?=
 =?us-ascii?Q?Ivj3BkteUBvJwLLJxCSW4DLzyvadxD3xwh41P4xR/ByaGqOv/W2SW6qrLfhN?=
 =?us-ascii?Q?ecEYGWmEUxJSK3JlQnxlutkTjYIuEiS3/P2Ex+TEVUV/YYgPoAHgtervew1a?=
 =?us-ascii?Q?HozrttPVsozcc59XGJkCeL8O6iUp/veIxuVRoiY1F1bbg7F10CBpMMKDT2Jn?=
 =?us-ascii?Q?h9mj7KBdOYBd4y8fVkqyIimxjlfyKc8SPU7UZQ921LdPuJE0UqAHjKKU8m9O?=
 =?us-ascii?Q?wXgpfu2gYA84a+YYnnjl0G2Un79fkIcLNcKLmVtZvUvclRFhoQWeuX4HKy3W?=
 =?us-ascii?Q?EW//8Rcq9w6lnZUVBgAOGuyjN7qIntblMCeup3ug3YzPjM8pF5nST5sTjvA7?=
 =?us-ascii?Q?Ikg4ZZAka6mq84A0phljLzw6F4yAMymbSI/4tH7eMxYpcYaJsdIkciFNzP0T?=
 =?us-ascii?Q?EY63UL017U2HT/se33vfzXre9jJlvINqPyvBFGjp4nxEPVj/nayrwSzTemnm?=
 =?us-ascii?Q?OHsf0Xc+AOHmAyWA/P32U2xgU1nj/JB/JjO/cVVXLp445yBteu6yVv6g52Xg?=
 =?us-ascii?Q?U7yGfI1aGy1k9z/BBGJDTFy7PFYDgka59GR2WrhP/3p5o+kAPlgFWWji9MNi?=
 =?us-ascii?Q?D9ya9Wj8p05UNua89RuSovTCSwn4EK2u9YSjJYE3IscigIW/C2/kr1sqJxYm?=
 =?us-ascii?Q?O6bn0mM8HuMia7xJYjN3v/0mPb2ZfcdHyHvCmQI+79KM2P+S61Ixra5gWmPS?=
 =?us-ascii?Q?SYrf78Of7FJvp2XlSdSB1wzdMypOeqFJuuura5KU7YWGRoxTPitiu0Xq3Ru5?=
 =?us-ascii?Q?8fxKfqQm4AEJb9xeKG4QGQzc7Yow81cIMiLtV4EFpI4nyi8ph+Yxun3n5N5L?=
 =?us-ascii?Q?B7BsXaZqLGsF+1EpSzqXbSx8C9A8iQfcq6bgRKpNtJxEGUXmoEFB75/6GjDl?=
 =?us-ascii?Q?YmiwpvDazsue8eyJCHE3CwfEhn1B3pAE6YpuENNOmrO15hWzQfXV8CthNUze?=
 =?us-ascii?Q?ya8cLmKlv7GjaRCKA56A01J09EjZE0WTkux3r17lv/cmf4ciUjBTUfQhQSxf?=
 =?us-ascii?Q?ExGMtpLE2IJ/bzlDDtkje+xKH926XE8KV0dwx/B82GN5/Yk2156TaAF9Bp82?=
 =?us-ascii?Q?+sX1Yy6TzSbxMuz48xvBizcVHfF29txAOBXY6U/MF0jX5lTMGkyxbZ26z6YB?=
 =?us-ascii?Q?G12uQA4QA624EKjFFg4Zel2F8W7JMbACPXgbBE41s8+N7QtWFSK7A26NfG5e?=
 =?us-ascii?Q?TLUs6GlcTUTUavf9rTrLj0qcrYK8IQXPx7NwgPgYCtz+wlVniWCUPtY3uNCP?=
 =?us-ascii?Q?+yxwYsQk0AFsa6duVrizxIoUb/nxuCuidN3UZarQFgA/vH2Xb6MoNKdyC/c1?=
 =?us-ascii?Q?culRPFygGwgKCjecoLsH8RMdYzRFyc+3EpYo+P3kvwEQRsffFJpwfH/nHtAC?=
 =?us-ascii?Q?fiI2a//vglWrXlB2x7KrCSGVhE4mIEfY9vMlp+bhDTMp2AtN7lHGHtmXw55b?=
 =?us-ascii?Q?WAiOVt9fCt8vnFs3xihvWTfNqDovxCofTJ5IfrOYK5rgXKzbO4a8iMOmsiHF?=
 =?us-ascii?Q?YzCEjQSk0Pgg0qtS8eE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:17:41.9413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41978836-daf0-4c0a-f1bc-08de29111d98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542

The bonding driver manages offloaded SAs using the following strategy:

An xfrm_state offloaded on the bond device with bond_ipsec_add_sa() uses
'real_dev' on the xfrm_state xs to redirect the offload to the current
active slave. The corresponding bond_ipsec_del_sa() (called with the xs
spinlock held) redirects the unoffload call to real_dev. Finally,
cleanup happens in bond_ipsec_free_sa(), which removes the offload from
the device. Since the last call happens without the xs spinlock held,
that is where the real work to unoffload actually happens.

When the active slave changes to a new device a 3-step process is used
to migrate all xfrm states to the new device:
1. bond_ipsec_del_sa_all() unoffloads all states in bond->ipsec_list
   from the previously active device.
2. The active slave is flipped to the new device.
3. bond_ipsec_add_sa_all() offloads all states in bond->ipsec_list to
   the new device.

There can be two races which result in unencrypted IPSec packets being
transmitted on the wire:

1. Unencrypted IPSec packet on old_dev:
CPU1 (xfrm_output)                   CPU2 (bond_change_active_slave)
bond_ipsec_offload_ok -> true
                                     bond_ipsec_del_sa_all
bond_xmit_activebackup
bond_dev_queue_xmit
dev_queue_xmit on old_dev
				     bond->curr_active_slave = new_dev
				     bond_ipsec_add_sa_all

2. Unencrypted IPSec packet on new_dev:
CPU1 (xfrm_output)                   CPU2 (bond_change_active_slave)
bond_ipsec_offload_ok -> true
                                     bond->curr_active_slave = new_dev
                                     bond_ipsec_migrate_sa_all
bond_xmit_activebackup
bond_dev_queue_xmit
dev_queue_xmit on new_dev
				     bond_ipsec_migrate_sa_all finishes

This patch fixes both these issues. Bonding now maintain SAs on all
devices by making use of the previous patch that allows the same xfrm
state to be offloaded on multiple devices. This consists of:

1. Maintaining two linked lists:
- bond->ipsec_list is the list of xfrm states offloaded to the bonding
  device.
- Each slave has its own bond->ipsec_offloads list holding offloads of
  bond->ipsec_list on that slave.
These lists are protected by the existing bond->ipsec_lock mutex.

2. When a slave is added (bond_enslave), bond_ipsec_add_sa_all now
   offloads all xfrm states to the new device.

3. When a slave is removed (__bond_release_one), bond_ipsec_del_sa_all
   now removes all xfrm state offloads from that device.

4. When the active slave is changed (bond_change_active_slave), a new
   bond_ipsec_migrate_sa_all function switches xs->xso.real_dev and
   xs->xso.offload handle for all offloaded xfrm states.
   xdo_dev_state_advance_esn is also called on the new device to update
   the esn state.

5. Adding an offloaded xfrm state to the bond device must now iterate
   through active slaves. To make that nice, RTNL is grabbed there. The
   alternative is repeatedly grabbing each slave under the RCU lock,
   holding it, releasing the lock to be able to offload a state, then
   re-grabbing the RCU lock and releasing the slave. RTNL seems cleaner.

6. bond_ipsec_del_sa (.xdo_dev_state_delete for bond) is unchanged, it
   now only deletes the state from the active device and leaves the rest
   for the xdo_dev_state_free callback, which can grab the required
   locks.

Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 283 +++++++++++++++++---------------
 include/net/bonding.h           |  22 ++-
 2 files changed, 164 insertions(+), 141 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4c5b73786877..979e5aabf8d2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -452,6 +452,61 @@ static struct net_device *bond_ipsec_dev(struct xfrm_state *xs)
 	return slave->dev;
 }
 
+static struct bond_ipsec_offload*
+bond_ipsec_dev_add_sa(struct net_device *dev, struct bond_ipsec *ipsec,
+		      struct netlink_ext_ack *extack)
+{
+	struct bond_ipsec_offload *offload;
+	int err;
+
+	if (!dev->xfrmdev_ops ||
+	    !dev->xfrmdev_ops->xdo_dev_state_add ||
+	    netif_is_bond_master(dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Slave does not support ipsec offload");
+		return ERR_PTR(-EINVAL);
+	}
+
+	offload = kzalloc(sizeof(*offload), GFP_KERNEL);
+	if (!offload)
+		return ERR_PTR(-ENOMEM);
+
+	offload->ipsec = ipsec;
+	offload->dev = dev;
+	err = dev->xfrmdev_ops->xdo_dev_state_add(dev, ipsec->xs,
+						   &offload->handle, extack);
+	if (err)
+		return ERR_PTR(err);
+	return offload;
+}
+
+static void bond_ipsec_dev_del_sa(struct bond_ipsec_offload *offload)
+{
+	struct xfrm_state *xs = offload->ipsec->xs;
+	struct net_device *dev = offload->dev;
+
+	if (dev->xfrmdev_ops->xdo_dev_state_delete) {
+		spin_lock_bh(&xs->lock);
+		/* Don't double delete states killed by the user
+		 * from xs->xso.real_dev.
+		 */
+		if (dev != xs->xso.real_dev ||
+		    xs->km.state != XFRM_STATE_DEAD)
+			dev->xfrmdev_ops->xdo_dev_state_delete(dev, xs,
+							       offload->handle);
+		if (xs->xso.real_dev == dev)
+			xs->xso.real_dev = NULL;
+		spin_unlock_bh(&xs->lock);
+	}
+
+	if (dev->xfrmdev_ops->xdo_dev_state_free)
+		dev->xfrmdev_ops->xdo_dev_state_free(dev, xs, offload->handle);
+
+	list_del(&offload->list);
+	list_del(&offload->ipsec_list);
+	kfree(offload);
+}
+
 /**
  * bond_ipsec_add_sa - program device with a security association
  * @bond_dev: pointer to the bond net device
@@ -464,111 +519,83 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
 			     unsigned long *offload_handle,
 			     struct netlink_ext_ack *extack)
 {
-	struct net_device *real_dev;
-	netdevice_tracker tracker;
+	struct bond_ipsec_offload *offload, *tmp;
+	struct slave *slave, *curr_active;
 	struct bond_ipsec *ipsec;
+	struct list_head *iter;
 	struct bonding *bond;
-	struct slave *slave;
 	int err;
 
 	if (!bond_dev)
 		return -EINVAL;
 
-	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
-	slave = rcu_dereference(bond->curr_active_slave);
-	real_dev = slave ? slave->dev : NULL;
-	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
-	rcu_read_unlock();
-	if (!real_dev) {
-		err = -ENODEV;
-		goto out;
-	}
-
-	if (!real_dev->xfrmdev_ops ||
-	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
-	    netif_is_bond_master(real_dev)) {
-		NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
-		err = -EINVAL;
-		goto out;
-	}
-
 	ipsec = kmalloc(sizeof(*ipsec), GFP_KERNEL);
 	if (!ipsec) {
 		err = -ENOMEM;
 		goto out;
 	}
+	ipsec->xs = xs;
+	INIT_LIST_HEAD(&ipsec->offloads);
 
-	err = real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev, xs,
-						       offload_handle, extack);
-	if (!err) {
-		xs->xso.real_dev = real_dev;
-		ipsec->xs = xs;
-		INIT_LIST_HEAD(&ipsec->list);
-		mutex_lock(&bond->ipsec_lock);
-		list_add(&ipsec->list, &bond->ipsec_list);
-		mutex_unlock(&bond->ipsec_lock);
-	} else {
-		kfree(ipsec);
+	rtnl_lock();
+	mutex_lock(&bond->ipsec_lock);
+	curr_active = rtnl_dereference(bond->curr_active_slave);
+	bond_for_each_slave(bond, slave, iter) {
+		offload = bond_ipsec_dev_add_sa(slave->dev, ipsec, extack);
+		if (IS_ERR(offload)) {
+			err = PTR_ERR(offload);
+			goto err_slave_dev;
+		}
+		list_add_tail(&offload->list, &slave->ipsec_offloads);
+		list_add_tail(&offload->ipsec_list, &ipsec->offloads);
+		if (curr_active == slave)
+			*offload_handle = offload->handle;
 	}
+
+	/* Mark the xs as 'active' on the current active device. */
+	if (curr_active)
+		xs->xso.real_dev = curr_active->dev;
+	list_add_tail(&ipsec->list, &bond->ipsec_list);
+	mutex_unlock(&bond->ipsec_lock);
+	rtnl_unlock();
+
+	return 0;
+
+err_slave_dev:
+	list_for_each_entry_safe(offload, tmp, &ipsec->offloads, ipsec_list)
+		bond_ipsec_dev_del_sa(offload);
+	kfree(ipsec);
+	mutex_unlock(&bond->ipsec_lock);
+	rtnl_unlock();
 out:
-	netdev_put(real_dev, &tracker);
 	return err;
 }
 
-static void bond_ipsec_add_sa_all(struct bonding *bond)
+static void bond_ipsec_add_sa_all(struct bonding *bond, struct slave *new_slave,
+				  struct netlink_ext_ack *extack)
 {
+	struct net_device *real_dev = new_slave->dev;
 	struct net_device *bond_dev = bond->dev;
-	struct net_device *real_dev;
 	struct bond_ipsec *ipsec;
 	struct slave *slave;
 
-	slave = rtnl_dereference(bond->curr_active_slave);
-	real_dev = slave ? slave->dev : NULL;
-	if (!real_dev)
-		return;
+	INIT_LIST_HEAD(&new_slave->ipsec_offloads);
 
 	mutex_lock(&bond->ipsec_lock);
-	if (!real_dev->xfrmdev_ops ||
-	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
-	    netif_is_bond_master(real_dev)) {
-		if (!list_empty(&bond->ipsec_list))
-			slave_warn(bond_dev, real_dev,
-				   "%s: no slave xdo_dev_state_add\n",
-				   __func__);
-		goto out;
-	}
-
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		struct bond_ipsec_offload *offload;
 		struct xfrm_state *xs = ipsec->xs;
 
-		/* If new state is added before ipsec_lock acquired */
-		if (xs->xso.real_dev == real_dev)
-			continue;
-
-		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev, xs,
-							     &xs->xso.offload_handle,
-							     NULL)) {
+		offload = bond_ipsec_dev_add_sa(slave->dev, ipsec, extack);
+		if (IS_ERR(offload)) {
 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
 			continue;
 		}
 
-		spin_lock_bh(&xs->lock);
-		/* xs might have been killed by the user during the migration
-		 * to the new dev, but bond_ipsec_del_sa() should have done
-		 * nothing, as xso.real_dev is NULL.
-		 * Delete it from the device we just added it to. The pending
-		 * bond_ipsec_free_sa() call will do the rest of the cleanup.
-		 */
-		if (xs->km.state == XFRM_STATE_DEAD &&
-		    real_dev->xfrmdev_ops->xdo_dev_state_delete)
-			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
-								    xs,
-								    xs->xso.offload_handle);
-		xs->xso.real_dev = real_dev;
-		spin_unlock_bh(&xs->lock);
+		list_add_tail(&offload->list, &new_slave->ipsec_offloads);
+		list_add_tail(&offload->ipsec_list, &ipsec->offloads);
 	}
-out:
 	mutex_unlock(&bond->ipsec_lock);
 }
 
@@ -600,47 +627,13 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
 						    offload_handle);
 }
 
-static void bond_ipsec_del_sa_all(struct bonding *bond)
+static void bond_ipsec_del_sa_all(struct bonding *bond, struct slave *old_slave)
 {
-	struct net_device *bond_dev = bond->dev;
-	struct net_device *real_dev;
-	struct bond_ipsec *ipsec;
-	struct slave *slave;
-
-	slave = rtnl_dereference(bond->curr_active_slave);
-	real_dev = slave ? slave->dev : NULL;
-	if (!real_dev)
-		return;
+	struct bond_ipsec_offload *offload, *tmp;
 
 	mutex_lock(&bond->ipsec_lock);
-	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		struct xfrm_state *xs = ipsec->xs;
-
-		if (!xs->xso.real_dev)
-			continue;
-
-		if (!real_dev->xfrmdev_ops ||
-		    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
-		    netif_is_bond_master(real_dev)) {
-			slave_warn(bond_dev, real_dev,
-				   "%s: no slave xdo_dev_state_delete\n",
-				   __func__);
-			continue;
-		}
-
-		spin_lock_bh(&xs->lock);
-		xs->xso.real_dev = NULL;
-		/* Don't double delete states killed by the user. */
-		if (xs->km.state != XFRM_STATE_DEAD)
-			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
-								    xs,
-								    xs->xso.offload_handle);
-		spin_unlock_bh(&xs->lock);
-
-		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
-			real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs,
-								  xs->xso.offload_handle);
-	}
+	list_for_each_entry_safe(offload, tmp, &old_slave->ipsec_offloads, list)
+		bond_ipsec_dev_del_sa(offload);
 	mutex_unlock(&bond->ipsec_lock);
 }
 
@@ -648,33 +641,45 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
 			       struct xfrm_state *xs,
 			       unsigned long offload_handle)
 {
-	struct net_device *real_dev;
+	struct bonding *bond = netdev_priv(bond_dev);
+	struct bond_ipsec_offload *offload, *tmp;
 	struct bond_ipsec *ipsec;
-	struct bonding *bond;
 
-	if (!bond_dev)
-		return;
+	mutex_lock(&bond->ipsec_lock);
+	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (ipsec->xs != xs)
+			continue;
 
-	bond = netdev_priv(bond_dev);
+		list_for_each_entry_safe(offload, tmp, &ipsec->offloads,
+					 ipsec_list)
+			bond_ipsec_dev_del_sa(offload);
+
+		list_del(&ipsec->list);
+		kfree(ipsec);
+		break;
+	}
+	mutex_unlock(&bond->ipsec_lock);
+}
+
+static void bond_ipsec_migrate_sa_all(struct bonding *bond,
+				      struct slave *new_active)
+{
+	struct bond_ipsec_offload *offload;
 
 	mutex_lock(&bond->ipsec_lock);
-	if (!xs->xso.real_dev)
-		goto out;
+	list_for_each_entry(offload, &new_active->ipsec_offloads, list) {
+		struct xfrm_state *xs = offload->ipsec->xs;
 
-	real_dev = xs->xso.real_dev;
+		spin_lock_bh(&xs->lock);
+		if (xs->km.state != XFRM_STATE_DEAD) {
+			struct net_device *dev = new_active->dev;
 
-	xs->xso.real_dev = NULL;
-	if (real_dev->xfrmdev_ops &&
-	    real_dev->xfrmdev_ops->xdo_dev_state_free)
-		real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs,
-							  offload_handle);
-out:
-	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		if (ipsec->xs == xs) {
-			list_del(&ipsec->list);
-			kfree(ipsec);
-			break;
+			xs->xso.real_dev = dev;
+			xs->xso.offload_handle = offload->handle;
+			if (dev->xfrmdev_ops->xdo_dev_state_advance_esn)
+				dev->xfrmdev_ops->xdo_dev_state_advance_esn(xs);
 		}
+		spin_unlock_bh(&xs->lock);
 	}
 	mutex_unlock(&bond->ipsec_lock);
 }
@@ -1236,10 +1241,6 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 	if (old_active == new_active)
 		return;
 
-#ifdef CONFIG_XFRM_OFFLOAD
-	bond_ipsec_del_sa_all(bond);
-#endif /* CONFIG_XFRM_OFFLOAD */
-
 	if (new_active) {
 		new_active->last_link_up = jiffies;
 
@@ -1267,6 +1268,11 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 	if (bond_uses_primary(bond))
 		bond_hw_addr_swap(bond, new_active, old_active);
 
+#ifdef CONFIG_XFRM_OFFLOAD
+	if (new_active)
+		bond_ipsec_migrate_sa_all(bond, new_active);
+#endif /* CONFIG_XFRM_OFFLOAD */
+
 	if (bond_is_lb(bond)) {
 		bond_alb_handle_active_change(bond, new_active);
 		if (old_active)
@@ -1311,10 +1317,6 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 		}
 	}
 
-#ifdef CONFIG_XFRM_OFFLOAD
-	bond_ipsec_add_sa_all(bond);
-#endif /* CONFIG_XFRM_OFFLOAD */
-
 	/* resend IGMP joins since active slave has changed or
 	 * all were sent on curr_active_slave.
 	 * resend only if bond is brought up with the affected
@@ -2241,6 +2243,10 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		goto err_detach;
 	}
 
+#ifdef CONFIG_XFRM_OFFLOAD
+	bond_ipsec_add_sa_all(bond, new_slave, extack);
+#endif
+
 	res = bond_master_upper_dev_link(bond, new_slave, extack);
 	if (res) {
 		slave_dbg(bond_dev, slave_dev, "Error %d calling bond_master_upper_dev_link\n", res);
@@ -2530,6 +2536,10 @@ static int __bond_release_one(struct net_device *bond_dev,
 		bond_select_active_slave(bond);
 	}
 
+#ifdef CONFIG_XFRM_OFFLOAD
+	bond_ipsec_del_sa_all(bond, slave);
+#endif
+
 	bond_set_carrier(bond);
 	if (!bond_has_slaves(bond))
 		eth_hw_addr_random(bond_dev);
@@ -3931,6 +3941,7 @@ static int bond_master_netdev_event(unsigned long event,
 #ifdef CONFIG_XFRM_OFFLOAD
 		xfrm_dev_state_flush(dev_net(bond_dev), bond_dev, true);
 #endif /* CONFIG_XFRM_OFFLOAD */
+
 		break;
 	case NETDEV_REGISTER:
 		bond_create_proc_entry(event_bond);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 49edc7da0586..deb8904adb25 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -156,6 +156,20 @@ struct bond_params {
 	u8 ad_actor_system[ETH_ALEN + 2];
 };
 
+struct bond_ipsec {
+	struct xfrm_state *xs;
+	struct list_head list;  /* Entry in bond_dev->ipsec_list. */
+	struct list_head offloads;  /* Offloads of xs on slave devs. */
+};
+
+struct bond_ipsec_offload {
+	struct bond_ipsec *ipsec;
+	struct list_head list;  /* Entry in slave->ipsec_offloads. */
+	struct list_head ipsec_list;  /* Entry in parent bond_ipsec. */
+	struct net_device *dev;
+	unsigned long handle;
+};
+
 struct slave {
 	struct net_device *dev; /* first - useful for panic debug */
 	struct bonding *bond; /* our master */
@@ -188,6 +202,9 @@ struct slave {
 	struct delayed_work notify_work;
 	struct kobject kobj;
 	struct rtnl_link_stats64 slave_stats;
+#ifdef CONFIG_XFRM_OFFLOAD
+	struct list_head ipsec_offloads;
+#endif
 };
 
 static inline struct slave *to_slave(struct kobject *kobj)
@@ -206,11 +223,6 @@ struct bond_up_slave {
  */
 #define BOND_LINK_NOCHANGE -1
 
-struct bond_ipsec {
-	struct list_head list;
-	struct xfrm_state *xs;
-};
-
 /*
  * Here are the locking policies for the two bonding locks:
  * Get rcu_read_lock when reading or RTNL when writing slave list.
-- 
2.45.0


