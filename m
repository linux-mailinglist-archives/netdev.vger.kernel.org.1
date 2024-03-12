Return-Path: <netdev+bounces-79423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB7D879282
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEB54B22D01
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 10:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B26C7867B;
	Tue, 12 Mar 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KJm8kJtR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834AA77655
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240789; cv=fail; b=MWqvTVfD6WVI3z0QP/vD8Vb3Co9DjEAAQwxugvC82ImuMIs3NLIZmbenHSt+TM6kP6uTXT4SEJ4JrYub4JbFyXTwlmOwFtHzoqht6UnghCuD8Fg2k6QbafhExtOXFPQsHCqhoT8w3vYlGhGFz9mrBYHxYZ6fb1E05xmjRE5s1pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240789; c=relaxed/simple;
	bh=qQba5fqjYTCr7FenMU4MllSHZWOnxtxB0gxIr5Nnimc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RMVFfKGZqXLP1znPKwQmlr3yxwOAgGQrElePbpqFJc3X6y1+MeZ/t8IsptVP0HdaobLGu3XgtoWdxyRPifcAmsoNUCPQv9kfAiHLgbu94+YqN5ns4sapmKEFseYGHc5OxknP6v2r4zYujwwMt9UI+gYjHmgDqXOS0lb++yBSDr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KJm8kJtR; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkonD36YhswAOLEt4tYTnjYMV0S3C/vFOq19VJfxEJzgHMpAYPrajx5DaUUVnAp11DxXv61gIxlXQPGVllGLln2NiAzqbw48PY62vfMBjMD2pCj704zFH/EqA0pOsopqn1kLbSQGrcYWOdyuaY2Kga/pinV8I6Rsfh9NqGuOMRczVwSOEDsumkX5GbDpZ8yX6VlvRbKsxgLnSGosAlMUhLKDgC91eS/wyavV9ic1HcEcaYnBS+P7/hNoqf+tWxcPZqJC+sI9o3tIxiegkeBEaKujnG5KiO0k76DAkAO27JVuFxq5eXasNaY7KDzulzslZer+l2PFCaNA6prmRzmJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETZ8H5suMGWSDxfIPBoLXarzxqGLKJv6xfjZQPnAexw=;
 b=RBkOpo1tnQIxIdRm3hbiIp93oXj7zF1CqDBqpj8mVO/lr1+0qIMEy2HXwLIXkU2S7ZVw28yt34iYMHlGpOyT8y8wXqTBWsnFjsWxlHU0Tc/OMTfXbKmiZfWwW54YARs5jumVX0tLMR0PRJxNUqxqBdHeyWXD/ScnU0PBqmx6Pr/mt9P20Et6FqEDDJRyOFnnWqX8DIe8R64bIKSxAdUt36aiufn82IVBlD7nkJxXXTJIM+kE5ee2cS8lrECYsNLmuc1H6J25Y9EiC4GAS62LUlE+E5R9yS2KUXMW56QkII+VU/rlhHYeZwdxPP4skc/C4PLVAGLuD8iw3uHj66+7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETZ8H5suMGWSDxfIPBoLXarzxqGLKJv6xfjZQPnAexw=;
 b=KJm8kJtREKRolDjHZchv5jOFJNa+R8sXVJhegOjsbsDA2jaODWLN3jGtj6KK0m6acsm84NJv1IJ+14V/94iitT6P8PMBXM5DtGrCPEhP58gMAuDgTunIrY5lbMlCBhwPE1sxe6oCD3xTilp3q04B4duR0CSctmskcebyM3lijbjR2ApHA+w0er22z5yIxBwCS7v7yO/13AdPyaU6jbhxCb8bAblR53YKIHeMok7aUjqoAcLBpwDx29B+prvzvPoApW9CLQFVEYXTICEvw+j/HAtZ8ASWfrzZUKBSG/FgFt/XiPsRc6q7ai1H+noUqAL5W7VPZB+yR/ZCwn1qU7LoEg==
Received: from BN8PR04CA0009.namprd04.prod.outlook.com (2603:10b6:408:70::22)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 10:53:03 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:70:cafe::4f) by BN8PR04CA0009.outlook.office365.com
 (2603:10b6:408:70::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 10:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 10:53:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Mar
 2024 03:52:50 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 12 Mar 2024 03:52:48 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>
CC: <jiri@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net v2] devlink: Fix devlink parallel commands processing
Date: Tue, 12 Mar 2024 12:52:38 +0200
Message-ID: <20240312105238.296278-1-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: a190dcc7-3726-45a6-2074-08dc4282974b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d0pGmXD+OWPcSAe45M3BRRAfj3zzyBiCVJ1HpqjC9Ye+MuRdlaa/MDD/SyGJolpVh7pnyBmv62lTs4PeSiQXB7XQdAU+nlaa6+uw/YGxlnz8wHVDEPiV9CnGPyGnoHeE0UL5gaVXscjb3OAn0vD+3At6OQA4XFUAB3nB3oWtauc/oVtHc+K5ppVLu/USxYgKscpNTToRheNKn1WS08lb8b7DdhEBzabh/qWlnUf4AwpzHsjHDNgxERlxvQooOQGN8Xhl8Ih5I7D3/DAvGGKNhL2mqULoK1D/OV3ln6iMByOLFhe5eMtVRoYSG9AAe1U5WkN6QwX6syDeEPedSGmFgqKNxydYbWfUXBg6y9xUYgnRh/4jUczH7uMiVhwHoOcv1UOPf1wMJDVdj4ihzaY3hK4qsGBmi6yPY3YuW3PRRtBmmbkgt+V9caA1Yxr/6ejWr/EIQCZM4pe4/OIY18FJKKfd1hBiGWSFZayG+WxPCxd8uj09rkIFutJ9W1ICE41KqmzRIznBCO+BJ+mLXfITdqr0Ak7U5bfi0b41KoPdbLfClT9VNoUFU6igptv51i4Appc8+kTDGB+wcGLnM8zJfk+iVDcYqjmmvHfEmckLFvlSTl1TJJCuU1fNIiqsPd2R7lQTYtoj6PCnTCaH4GUjowgb1rb2xl1J6biLbJg9UdZZTY2xD7Qygy2GDpsUoPceZF+P8qwuh5TQ1z4BwcdMeYHZHKKK2z+mkLBjHcHig4K2YLN5/fGXzaJljFKdxwYK
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 10:53:02.9357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a190dcc7-3726-45a6-2074-08dc4282974b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038

Commit 870c7ad4a52b ("devlink: protect devlink->dev by the instance
lock") added devlink instance locking inside a loop that iterates over
all the registered devlink instances on the machine in the pre-doit
phase. This can lead to serialization of devlink commands over
different devlink instances.

For example: While the first devlink instance is executing firmware
flash, all commands to other devlink instances on the machine are
forced to wait until the first devlink finishes.

Therefore, in the pre-doit phase, take the devlink instance lock only
for the devlink instance the command is targeting. Devlink layer is
taking a reference on the devlink instance, ensuring the devlink->dev
pointer is valid. This reference taking was introduced by commit
a380687200e0 ("devlink: take device reference for devlink object").
Without this commit, it would not be safe to access devlink->dev
lockless.

Fixes: 870c7ad4a52b ("devlink: protect devlink->dev by the instance lock")
Signed-off-by: Shay Drory <shayd@nvidia.com>
---
v1->v2:
 - Simplify the code by removing the goto
---
 net/devlink/netlink.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 499885c8b9ca..593605c1b1ef 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -193,12 +193,13 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		devl_dev_lock(devlink, dev_lock);
-		if (devl_is_registered(devlink) &&
-		    strcmp(devlink->dev->bus->name, busname) == 0 &&
-		    strcmp(dev_name(devlink->dev), devname) == 0)
-			return devlink;
-		devl_dev_unlock(devlink, dev_lock);
+		if (strcmp(devlink->dev->bus->name, busname) == 0 &&
+		    strcmp(dev_name(devlink->dev), devname) == 0) {
+			devl_dev_lock(devlink, dev_lock);
+			if (devl_is_registered(devlink))
+				return devlink;
+			devl_dev_unlock(devlink, dev_lock);
+		}
 		devlink_put(devlink);
 	}
 
-- 
2.38.1


