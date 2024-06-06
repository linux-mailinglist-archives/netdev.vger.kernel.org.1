Return-Path: <netdev+bounces-101461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F76C8FF032
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD651F2561D
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A958199EBB;
	Thu,  6 Jun 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e3bLSZxt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1F6196DA0
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685553; cv=fail; b=t3wBY1u43qOTlomm9ERTTiKuPVIsEknCouS+s/czDtjMvi/yiXwba097xbqMpt46IW6x5Os1eudyo+fcGNHslxvKpYNFNEi08WgnsSVyltDLGuZ9QLQ/ugf2QDINlXPnk0KjBLfPaI80K/IqI4rN5P61IhFCNp5i49j4LyuUQo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685553; c=relaxed/simple;
	bh=J94uTgKvngQm6eCXUfsqxruJ+fGKdFUtF4uVCNdBUOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idoczTSvvPNljC0Llhcc2K0pb0riqYdXc7xOp4u/S2bB0MnIbhlvN2LEicFe/SPWNZqWgR6oLp6uvmDQd31wY9wb21zR0/9+mvmSDf84y43BcfHNYICBreJdOdsxQwF42ZN3u4qaFxImdK9O+5845bK3XyZUQ4oNzSFiAe1KWBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e3bLSZxt; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqpCTsFUEiMWT5eV8GGXAz7NiF/6XIijUksaPWmxQ8NY9VPk7la/EoegyRK1FcSBa+6jUlyhBcaf6rysh/FguJiRSgqrEtAoDz0bW97DTTo/MhCZpTjO5WLPXHrkeR138sbxaA6K5IErZRO28ocLnwgALTc3KqGBKXIGf/nbcTesAMzCYolq2JO4jN2BNsPo1c3pvUva2HZ2MqFUdNtla5HdlDpAh+XRB8jkvjrynbwcbvmxawu8rHVNiboGIgmKM1Fvrfa3kMnjNkpkb0y/OLnqs4WndxfBw2dF4WfnsmrCc/W5D83IZnxpFZ/FKpoOFZ+FX68q/IVTDKdR1GPLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geS3ntuY2zSXEI0sWCwKDSGxETIh4xi2BNESpWCd+Ho=;
 b=YpV84kO4Ar3b+ljOjbz9wg+8UgF5dlqyXoXby7b7FcGPmOEgz/8a1WA+b4azr9GlCpT8P1OsdbgDZzY7T/XbS8dk7c4eRuxjwFfOc7IcA/NTEIC0DvV4JdOy6kwmzk5IL+FtY4t0mxiLRfcRqgDZO0TWIAtfDWPZbh9M+zHIfpJP8pdRHrkdDQPz0QBBSlxrR5JzQtoDxPwH3ie4FUfZ9TooXz3neB64qIRKRHTXaDCibHLzCFSk841pG1AOjpaKJ4zSqYF9PcyfHWsZF4iTDgbyCt8qFCau5REc43mSb96FLc2ApRAS4zZJseuhhAr3ML1le5qPk5/5JTqjfEkW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geS3ntuY2zSXEI0sWCwKDSGxETIh4xi2BNESpWCd+Ho=;
 b=e3bLSZxtoUE7q+7deo1ADlzcUJ/0LmNzt9LG5zyIdUUbBVOwNQT4fWlFiecSzB7pZy05BmdzVIMMiZvT47uiQXv+RPBFQo74ZEqulsqU1BrIDwj7gukUCMkBbbPF9S330YVxubLXUmIQPG8dsMRdAtbt0BaPN01p4e4ID9RcOVHa70dcoha1G9lecIrTprKB/ZNBhHRur9FaRlBn9jFMLLOdURc+VIwYAnd8DYMsh7AHib14Lyn0XMYSWzOXkEscHYk7/q+oxg1hnSEyOso4tzdUTVyIijRghIw84AdXKn9uTMB+nbT5WSpQeLDJ3NawIezwEDTDEjKLHld1jN3gjQ==
Received: from SJ0PR03CA0102.namprd03.prod.outlook.com (2603:10b6:a03:333::17)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 14:52:27 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::26) by SJ0PR03CA0102.outlook.office365.com
 (2603:10b6:a03:333::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Thu, 6 Jun 2024 14:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 14:52:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 07:52:11 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 07:52:06 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov
	<green@qrator.net>, <mlxsw@nvidia.com>
Subject: [PATCH net 1/6] lib: objagg: Fix spelling
Date: Thu, 6 Jun 2024 16:49:38 +0200
Message-ID: <0176885fccfffe7aaad6fcae774ff336bdf75c94.1717684365.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717684365.git.petrm@nvidia.com>
References: <cover.1717684365.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b97173-651f-4f4a-9e71-08dc863847ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oWNYVALntSUFM8iqIuRSfG2NRhKt4Qv0Hnz2Hc509Xju5DWopFSQnIGu8tM7?=
 =?us-ascii?Q?icZA5Xe7bANq6xZs8+no1IwqOOKokLY4rr+bQn5nZOFg4rmOaaIO8+7SANZC?=
 =?us-ascii?Q?gJRqdx601Al2Gee1BUzJZ2GqYMqZJMTl2l8u8qdC7CkrCprJp9xd6lxBAyiX?=
 =?us-ascii?Q?IjFXoGZgQUhpOCi0PAUuqem5cGLJ1QzvWuDjNL7eQ9WqwhB3bh+/HGIc+42E?=
 =?us-ascii?Q?pU1y3rxxIyYi3fYZcYtdbHM1FSV1jJwU5x1iX6hx8y4xqj+JCmM7BtOdfR71?=
 =?us-ascii?Q?T9Fncri7MlFJ2bY5FvOpYT2HKm0Di9lrHdSdtytd6B8Hrw9MWMPebeDdukLf?=
 =?us-ascii?Q?41SBj4KFr4Jv7d+4gN5oxoIvC32ZU7mMv25PEOugIgNtNaVtOmViSRKhLBYW?=
 =?us-ascii?Q?5KhRuUuPe+VafGhzlvBD6SaqB00ij0cu3NpHhysl7khcxbJjIWTL56jj+1jb?=
 =?us-ascii?Q?/8DhHLJmL4l9YnfRBUAdGvzT9jaIf5tZ3Vjo64AqvuluKycGBvzQru1VsfHZ?=
 =?us-ascii?Q?C3NYG4Bv2kNOZLeRTW8Vl4H2ZBuj2k0Eb9A8eFlEMWu1ql4fQ44U3FGfkbP5?=
 =?us-ascii?Q?LkR3SBj53DJp77miSrIDHEoH9oLuQutP2Tyg9jVfpO2pH98OaC0SvQBJMdig?=
 =?us-ascii?Q?o0aqdctCRb1WJ/eKXdLRUlozkEIq6zWh8rsjDLSv7dzqB339eJN+cDy2aZtE?=
 =?us-ascii?Q?NweAKMmlrbRolmBASe4oIKbq/ZgQD0SqYYBaPdks7UclHVoVo5suLw/OPfku?=
 =?us-ascii?Q?RyQ9vHbOsNV83cdrvAr4Oe1o1S78hxo0dpYtEXt/bivVTGUNPgwLwH+cCNhX?=
 =?us-ascii?Q?FEE8mPDxrmOKTdORE2LFNzEl+dbY2TfOTX0kGupBbRgxZQkBA+shP9y/ia/2?=
 =?us-ascii?Q?EQQlEkqJDvlyPdnlXhgZ2w+mirSElfOtDcewBGgMaKNn11VRWv6kBogQAqx8?=
 =?us-ascii?Q?wH628J/b6T7PCCsrAxiMwszcz9sSO6ssfyL8UEVK1Jxd6Hy94Xef+adlO9GD?=
 =?us-ascii?Q?68iT5LLQohIUpMeFZk2UnZ1lvFR2Iwpi+kHMPZKXu8RXaVk5+hVekCVAnt2t?=
 =?us-ascii?Q?O85NDwcjSHPZ7aKOI7YT2zzYXlH95alHLiVeuCAv0Uoa9IqbeI6AtMEsHCjc?=
 =?us-ascii?Q?tkTxFUNTlXpMBvscGbeTTQcNOZEr6BMul1DbVISZWCuFECik3jlR7j+9uecU?=
 =?us-ascii?Q?oJx+hPJk3PHq9R6TM3691XoHl9tr06ImWUtHHwXCFbr2MsXrCdy34+WRwqPS?=
 =?us-ascii?Q?HRkQUej6AuuTB00LQxMCCCBA8k5WbfdSvtZfG4v02OeDQfIunzAmdGBy+B9d?=
 =?us-ascii?Q?Iea7+GoNDEIiRr89mI8RjX1Mrtnav7iSwbCger/KPExmIx6eBj9FNIqSQu75?=
 =?us-ascii?Q?r/j6I922FZtmmPbb6bfBEEibdUxTNMCftSfd/GhutaTRifhdRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:52:25.8800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b97173-651f-4f4a-9e71-08dc863847ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406

From: Ido Schimmel <idosch@nvidia.com>

Fixes: 0a020d416d0a ("lib: introduce initial implementation of object aggregation manager")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 lib/objagg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/objagg.c b/lib/objagg.c
index 1e248629ed64..955538c90223 100644
--- a/lib/objagg.c
+++ b/lib/objagg.c
@@ -421,7 +421,7 @@ static struct objagg_obj *__objagg_obj_get(struct objagg *objagg, void *obj)
  *
  * There are 3 main options this function wraps:
  * 1) The object according to "obj" already exist. In that case
- *    the reference counter is incrementes and the object is returned.
+ *    the reference counter is incremented and the object is returned.
  * 2) The object does not exist, but it can be aggregated within
  *    another object. In that case, user ops->delta_create() is called
  *    to obtain delta data and a new object is created with returned
-- 
2.45.0


