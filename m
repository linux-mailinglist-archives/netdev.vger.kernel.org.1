Return-Path: <netdev+bounces-90192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FAF8AD0BF
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572E928B5FE
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE385153503;
	Mon, 22 Apr 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EuwJCodq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330EF153507
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799774; cv=fail; b=bS7xM2EjTKaLtvq49AgHd67sk0cVCi418LAvUGdsEHijgA2LDbB5z/WDIyUydLWH600++Q1ckZMTZCDtcW8XHDys4e3n5gfUkK/OEyiFTAYTtlVLi+K+bU2Jlf7r2RN0sl4EEfwncNQ9YGzguhvDQBHT8Z4ggAqmwNACwH5SOxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799774; c=relaxed/simple;
	bh=ah0+LJyFNCpGgK3fuca8RLUJpg+s3d7XaoFAmLM5Urk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQMwJAqhlzauxJij28Mjy0zlpZ27h0amTEjuaKZxPicAgLc6XvFrFJz6w5fo8MgAa77rc7bUWKmDWd+sDMyxccvQfGH3aM5eltvPQQxCoVhb626T95hJYu1GPkPgIT7iuqvivySzSfTx+wPhUuf0TwHk9MudeFBkYHfO3MLoIdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EuwJCodq; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgzknUWe836y3RPpo0cUP0VFy/NkyXppY+pIUFxzeNe0RGyQf06ZpMRrtSwucbuu7UERTYkon8Ucz3n8+yOcyeDkN4OoxB5yV7W9AWJMrv4Q93aCyTnWXMt/klSsGBaaQnA/A094lj7DWXtgoAp66bU8OKknZoetL59MO4vxDn5JXCgTLEI8BVbwZsltvj39QUhCbyx/BKlT+mS7tmdTLgRrjgXtRBAYY3kQXWxL0JzhIE1ctdlmj8YdOx0ONrArWBCLuynkHzYi8dEDH/af9daDyz1AY2e4jbZKb9lGZbTs6jOXpmlsBvv/3nZq159DcCn4xfy3mngNPVeZr6RQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhmyKFOoc8Zl0G2Njk26RHjMiNWjqgZz6uqc8ameXAc=;
 b=AQT9UFtgmW4J8fQZWHtyVwKooC9xg+tjzFH7W98AWBUi7XHr8v/TJ2gY2Y/EA+s7+sEaTuRD/Kx2gV4x92qz9onraiCBMmWxn0buKA55SK/mHgfg0O98FNp2NTkNML8/TyTW6ViNfC9K5jmRB6qMfP8kB98mUcz7FQvUM7Gq474E1peL9Ox20wppVzPplh9Y0oIAZqm77sMKViPAaM2CD+Sti2OEZZEjqX897qS3Bg+Vv9z0LLFT+k2iHd6fisOmKf70y+KUGN0rnhvguZml8JGq/2WBLa3beQn19BNhv1X7c6ntQxdO/okYD3j7HiaO42WROn8iSXdz0i/V3V1MOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhmyKFOoc8Zl0G2Njk26RHjMiNWjqgZz6uqc8ameXAc=;
 b=EuwJCodqZPilnntEs0+FCbVSOr7zBgkLjJYu+lTxRc8PM0/Y2fJvOKL30MjPhrgvn+UPE9nT7NvExxgPr62IbLiGI5N7MVmtHI5JtfzON+Xt7uUL7qLowrZV4hIqncD5Po9SWpvNUMIDFHCpw1x803x9n9+5CFht4tlRxz84JfeXyW4cWVH2Iu+RpcZ4lnSeBQLdMuLfdRXp7nDX8Dw75goJkNCEBiI/pX8kE7Pl9qL9KYElzsBbh3xgwQJ0Q1aCsf3dZzDu+7k000Uh2Tq1ErQfMU3CbCXKUaGuPZhswq7pmqsixtYydLVk5ormD9ZX5jRkMQ0yBZ0BOwAjLZ9vzw==
Received: from CH0P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::27)
 by IA1PR12MB8335.namprd12.prod.outlook.com (2603:10b6:208:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:30 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::2) by CH0P221CA0044.outlook.office365.com
 (2603:10b6:610:11d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:29:13 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:29:09 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Petr
 Machata" <petrm@nvidia.com>, Alexander Zubkov <green@qrator.net>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 6/9] mlxsw: spectrum_acl_tcam: Fix memory leak during rehash
Date: Mon, 22 Apr 2024 17:25:59 +0200
Message-ID: <d5edd4f4503934186ae5cfe268503b16345b4e0f.1713797103.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713797103.git.petrm@nvidia.com>
References: <cover.1713797103.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|IA1PR12MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c545214-888f-4dad-3b1b-08dc62e100a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/XX/48Jiekk3q9TH8ijwTfXy1/wJrKvb1nPDbJRJu5QAZ7psJy8EMkVpNTpV?=
 =?us-ascii?Q?+PoRnvdnJyj+7SWK2m4CNtnfNZM8eC73+wLdD6F4I5kCEtyZF3RY48r7QWrx?=
 =?us-ascii?Q?QoTG7VosVDO36coZblRBOFmCdZhXfzNL/hr32Cm23gBEplR+lEWcwROOKwKF?=
 =?us-ascii?Q?38SqGAzp/MMqHHzXkUXChXG802/3lI91/Lu0A3+QKEYtH7YKtrpQLV5wpH71?=
 =?us-ascii?Q?HXXL0h5TtVHU1iDTpUhnTUL5nFcO7ZwyguypblCDXGk0MPjTbGqWboZhm+cc?=
 =?us-ascii?Q?8rI8HtmImK/4v53iG8et4dl/RCnlw6v+9+OdMtcLveTY0rY1mYxmnfg+BLYu?=
 =?us-ascii?Q?BrfXNDtHmLsU4mNwjyPTfInNPQlUCJcjK49RguoOyLIHvENKwBkKSeYxQaRF?=
 =?us-ascii?Q?iYY9Fen1F9aBBgSEwhXSB3rmzj6rhEb4gchowT1Dl0+9fJ5hIgPjoLYDaiIY?=
 =?us-ascii?Q?8X4sOSq6r1jiqaLue+OlgSkHlnNfZRzVS3yKo7uaJ1PRoyIxDDOO8abctiJi?=
 =?us-ascii?Q?HqbwFKsyNBak7/TvQxOGRqVylIN/BT4ch879YVSVjBN1aoSGGJ4aFvcFlkRp?=
 =?us-ascii?Q?F/U6dEjpnCM5Zi3gM1p0vu7enc3PW4xGsMbnCOrubg61c3zbmDu2BhhCV8+z?=
 =?us-ascii?Q?KQLe3t3XlfMBlMuXAo9Elx74PWovw9vv/BkTUe+ZKjmcga5Yz5sLb2tI/7wz?=
 =?us-ascii?Q?nNllVNlRcWp5dRqdqPaxBEZMiLkAMk7zrLAxV06kbTmgnUMHOd5pyOgeDMSl?=
 =?us-ascii?Q?+jUYmYaYoLuIqBTsy5PHjWeSO1BMkFS45tH7ZOKfPjslYgjvQ9HHvgcvyBrc?=
 =?us-ascii?Q?BvxyMrMCn5xHMVL0XiARvbHZloQ8Eqj6UX0M5aGs3/WhPOUsBxVUAYiJI2BK?=
 =?us-ascii?Q?y8M+IM0ZqfP3pIJok1qBtJwbdFRVtg19XyxKdtIvB+xphlTz7vb/M63B1zk3?=
 =?us-ascii?Q?/4gPL6idpPYpIDJxBcZsiHxwJKtMuou7YegUtsu6lJYGJ8TyGVXOOifYF1Sc?=
 =?us-ascii?Q?1Y6FXyO7gzgYdT4RMWDr/sOUWNEdvZH/ZYhXTc3RvTis8Fh4SEDcSQVI20b+?=
 =?us-ascii?Q?o3iapfLnaM5EokNiYl/ue9NTrkh12rrW/BtozcjnzZwX/7fTPzq+gf5+vLYh?=
 =?us-ascii?Q?HvvPvxi3zUpY78BDr07NIlZc9LKwDgLSY86WAaBPpI4EbV5TJXLsrX19NFIk?=
 =?us-ascii?Q?yiCRmFg5Z3zcUsBbYHQYGY8aZK7hssNqqS25I+En4R2Z8x0qPipLdRMM52Pn?=
 =?us-ascii?Q?GXlccLw0ptfGXLOE0OtjXFZjBPf1QX701fMVsSX7lxkLR6uBxS0GAfKhESl6?=
 =?us-ascii?Q?XHr8YOugZQJVZkaxzYsMlaGgtfacXgRekXpWoW1IC4ntm5BgCSoR371TuMgm?=
 =?us-ascii?Q?yloKsGdmkJwU7cxQZESWdvKQztk8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:29.6066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c545214-888f-4dad-3b1b-08dc62e100a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8335

From: Ido Schimmel <idosch@nvidia.com>

The rehash delayed work migrates filters from one region to another.
This is done by iterating over all chunks (all the filters with the same
priority) in the region and in each chunk iterating over all the
filters.

If the migration fails, the code tries to migrate the filters back to
the old region. However, the rollback itself can also fail in which case
another migration will be erroneously performed. Besides the fact that
this ping pong is not a very good idea, it also creates a problem.

Each virtual chunk references two chunks: The currently used one
('vchunk->chunk') and a backup ('vchunk->chunk2'). During migration the
first holds the chunk we want to migrate filters to and the second holds
the chunk we are migrating filters from.

The code currently assumes - but does not verify - that the backup chunk
does not exist (NULL) if the currently used chunk does not reference the
target region. This assumption breaks when we are trying to rollback a
rollback, resulting in the backup chunk being overwritten and leaked
[1].

Fix by not rolling back a failed rollback and add a warning to avoid
future cases.

[1]
WARNING: CPU: 5 PID: 1063 at lib/parman.c:291 parman_destroy+0x17/0x20
Modules linked in:
CPU: 5 PID: 1063 Comm: kworker/5:11 Tainted: G        W          6.9.0-rc2-custom-00784-gc6a05c468a0b #14
Hardware name: Mellanox Technologies Ltd. MSN3700/VMOD0005, BIOS 5.11 01/06/2019
Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
RIP: 0010:parman_destroy+0x17/0x20
[...]
Call Trace:
 <TASK>
 mlxsw_sp_acl_atcam_region_fini+0x19/0x60
 mlxsw_sp_acl_tcam_region_destroy+0x49/0xf0
 mlxsw_sp_acl_tcam_vregion_rehash_work+0x1f1/0x470
 process_one_work+0x151/0x370
 worker_thread+0x2cb/0x3e0
 kthread+0xd0/0x100
 ret_from_fork+0x34/0x50
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Fixes: 843500518509 ("mlxsw: spectrum_acl: Do rollback as another call to mlxsw_sp_acl_tcam_vchunk_migrate_all()")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 568ae7092fe0..0902eb7651e1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -1200,6 +1200,8 @@ mlxsw_sp_acl_tcam_vchunk_migrate_start(struct mlxsw_sp *mlxsw_sp,
 {
 	struct mlxsw_sp_acl_tcam_chunk *new_chunk;
 
+	WARN_ON(vchunk->chunk2);
+
 	new_chunk = mlxsw_sp_acl_tcam_chunk_create(mlxsw_sp, vchunk, region);
 	if (IS_ERR(new_chunk))
 		return PTR_ERR(new_chunk);
@@ -1334,6 +1336,8 @@ mlxsw_sp_acl_tcam_vregion_migrate(struct mlxsw_sp *mlxsw_sp,
 	err = mlxsw_sp_acl_tcam_vchunk_migrate_all(mlxsw_sp, vregion,
 						   ctx, credits);
 	if (err) {
+		if (ctx->this_is_rollback)
+			return err;
 		/* In case migration was not successful, we need to swap
 		 * so the original region pointer is assigned again
 		 * to vregion->region.
-- 
2.43.0


