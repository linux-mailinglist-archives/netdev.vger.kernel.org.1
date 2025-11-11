Return-Path: <netdev+bounces-237598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A08AFC4D9DC
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1FE189BB39
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932F3563F5;
	Tue, 11 Nov 2025 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jk1xl53N"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31567355059;
	Tue, 11 Nov 2025 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863320; cv=fail; b=DtG3IL00SIqNg3TydW36FB9fjrlI3XmiuEQRko5YdJ9TDTUEK/40qKJcOkqi5Ea4o4QchvASqAMcrRZ+4ldZRfEHlB8255CAF9xa7CJv2Xj1KRPA5h1myFgUrTsOh3WYIA4AY9qPmTGMakUAOmxFiKA+QXBHCY8S1eBcuYnMThE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863320; c=relaxed/simple;
	bh=SU2Bsjee0ZTYKgiJA78/xgAMp6Rz+ISDa1pgNN1QRWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R/NsQ7EWNRAp3oM5BeWyKj5cO/I00wfWSujawhu7REmizGZ//wJk09EPbRWOpz0AO13pOOyNAxkbtdpCvNwFbtCKpScGLnIyKlPKyI/jelzlQD1mmJx1Bnt2NwPXfpKK9ElY4qEbwg7hrz17s8DAlXNyM+plU2ecj0L+wBsS6B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jk1xl53N; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9iNErSXceiYoncDxrUapu2nxU9/5JySpTGdk93xVPEfzfcQbs75ZCHmcPw7hGvoAEG0I4JNO2WsUrz/HzdgfVBdsqQtKwS8qRlJyZ8sXdNAw+dx31ouYsKJjDWnUCAg93Viu3xZ8in9PFLZvIPywNdSKHHztqMBnz8mK6fFQf/AWn4LTBOnMxhIIIA1oYGlMKClIV4gCaVlP8iZTrhObrVXhbTvLA60SkY1tmjDgySErtD5rxFmOjPBNtsppaEeTuKqNwJWLUx7FcuZ7IKOoB8CZMBgjEFGS6GnxLGEh8+Y7g0n6Nib6mYTS8H7zF5CG73uOrkiULVLqQvf/tboTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvN8h+cgtw7YF4UqD3uDj1QslaOAx80Ly4wGIdcJTaA=;
 b=yNf1NqdxqLE/CUhVTBM7vWCRMBxeqQmGjGAMH83G+//EsWr/UZBZd0C8KrL9ZvMKXsUHl77pjT9EGg+tWDLRpVp8sBQ6jqDhOC1Fsdkri2KZ9VxzsuSCcbHHTPqpsoqlqhAs/idzMd0F6/6/mDpEGCA8zPV/79L6Q11MUAUsusfk1xvWWvEW8NEEZ0PLaxy2m/q4xX7+KSS5iY55J/oUFlSxBD0sdsKZaYksyvJzpsvhYlLjuGwrsxYkyZ2pEz2v2o3L4beMYb07IqJRCSfv4r4XUYV5GrS+xQvRPxil+yM+O5edsjpAorQ+zPMI/fWvAXShjN5vRBz+Qo0ZnlO9ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvN8h+cgtw7YF4UqD3uDj1QslaOAx80Ly4wGIdcJTaA=;
 b=Jk1xl53NObP2cTHZM9OJG38J8e3LK/6NnthlzrG6RiecKyTMvobLctLydRfbtPUQWAPozd/QlnLBYRPZeq0AlnVg5oLU0rsHDUR9lFLE5a1QWba8kLXPyxG+IRP+dhbI8Fosf5mF35LufTM42nkwezRNF65a7VNf+uWJD6vf0+rswurU9SngAW01dGmG+gdWP6a60vd/Lh5xs5wcjtN492oXq4qrvhAG1ltMJFsf9f+BA8Fw4cI+xEoDjMTqyo3DYXAsZ45jIflwZn75dIbF/7t8qeapZx5ou47kyuN7e5d2cGP66OLoIum9829WkdFQwPv39llUOoAOhZlqXDpNjw==
Received: from CH0PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:33::8)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 12:15:14 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::b) by CH0PR08CA0003.outlook.office365.com
 (2603:10b6:610:33::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 12:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 12:15:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 04:15:05 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 11 Nov 2025 04:15:04 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 04:15:00 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net] devlink: rate: Unset parent pointer in devl_rate_nodes_destroy
Date: Tue, 11 Nov 2025 14:14:39 +0200
Message-ID: <1762863279-1092021-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: f1812513-68be-43b3-23f4-08de211bf81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U3teqxRL0wT4R1gKv3v2B5Kcc0a5pxjLIoW36zwwcOo2/gNJbaFbeAyEvxUu?=
 =?us-ascii?Q?lRnVUSQCZ6btM/902p/Wd6Ohtp+nAFgRN/j/I0P3QdHovRuCR9/tZpzX3gqK?=
 =?us-ascii?Q?b2p9lyqZOvXmbNHiI60K9lhLVG95kqUslPA/h8zVGH7Acbl/qEVoZhx62bPq?=
 =?us-ascii?Q?VU36bj3MUbLm4JzqPbfS7o1KfmMvUDqX5sq2zFA0gRTbmoZlUsPHHmCjQTWJ?=
 =?us-ascii?Q?X/3Vhyp+p3WyA76CiAJQuD1ELREjenUF0GPi9S6d60isZT3IWVnOUobubipO?=
 =?us-ascii?Q?89V1ItizxdYF65g2lbODGnSOKzaUgqeiuGSO6V7g1vM/8AyK76nMAdo5J990?=
 =?us-ascii?Q?wiZR+RvQekF3IpVLL9pmF4ZsQgrGivUthfrV93RS3cUeA1BA8r37tbRFlThp?=
 =?us-ascii?Q?Gg+qcDfC6Y93Ik/Mm6vaoIB+wL1JsAWqrEPg5fWfTrBACDFS+IirYd+8tXUZ?=
 =?us-ascii?Q?kvTyA+8m36eMIbS/Uj/5+KhgA6eo+w119rh+gGWrMopug8qq3RybU7osJBsU?=
 =?us-ascii?Q?9Bk5PDhPYtBfIuPt7g+eEpgIp8QiTdZd51FOuW/9DNrh4O2I9j+dUZb70IeI?=
 =?us-ascii?Q?IWf7huugVIdv8zegGkHHymOdAHguOts5+Ki0dU1AX8dkRmycjqCLeXtufVzP?=
 =?us-ascii?Q?+Qa0BNouiFDzzwB/H6BhHDKsJUhcALcw3CU81zBixHwC20gu/PV3FNIPEbdw?=
 =?us-ascii?Q?XaqYP2TmBuHrA+NjClNwGqEzABFydE7Q0h3QpkWyyOh/9lRpEjAkV7t+jO17?=
 =?us-ascii?Q?Sbo4YQltKWkSq+9JJzxZh6aetgKCW2t3xzIJnSjSrSz3kxlRJ9qpWPyzruhN?=
 =?us-ascii?Q?iSNd5NaZnt6asC1E78QTgSXwa1hueQ6OQ7atLvsApjXeJ1YMknFXg2520aLl?=
 =?us-ascii?Q?cvVQCsn+epngpBPDvz84B4RbaxSeNsiyZ7jzvKlXUPjRboWplDUDcZNtjsX+?=
 =?us-ascii?Q?rToXmKRKcoimsKUrWkFEHvkKya4jhqC0A7vIosZnglDvbNUS53iDnLinoYQU?=
 =?us-ascii?Q?6wmLKkl090A/c3OnKwUpdEDrY8gdPF4qtsd+Lu0WU/oRwG1H3RpfZPVmX62T?=
 =?us-ascii?Q?jzQ8t9zOyRbbi+G7Iod7o3UjTuClovdI/AD2MxDZJgn7+xaESZjvgxdOTGOz?=
 =?us-ascii?Q?4KJFnTxRcaRMtjN7YncSoYPTS0flFMJ9cIpvTmCGweJmDoMVtDFqBjR58YZF?=
 =?us-ascii?Q?vUkWQNNFEuSyDGd7QEqLxIbM3HmrNQ6Xmx/sKJqdurQNPFQCh9aHKbdz52Vi?=
 =?us-ascii?Q?522NoLPqTl25qK0BJjLcey2eWrpNDCZ7mP1S35CYmCRPdErxstpL9LwlaJ9b?=
 =?us-ascii?Q?54OErT14pDrlqU3NA5FSEQxONuaAYt1FOELMZ5mXki6fvDGH5Fhl/ZjTRHvM?=
 =?us-ascii?Q?rMnVmFBnRNFFnhZmTeyhOKoKEhsOQzbIfrkD7I7/Orpq7SZMiN9u/pxtZSeJ?=
 =?us-ascii?Q?0jffqP+6p5WuxVLhvo/gAvNta4TPm/7nbj9e5na0LTS1w5Nr8xZIpSGupSvN?=
 =?us-ascii?Q?xf4HhuqtLylcog4Tzo88SGhunioqQ5ouM8LUaKzDFC+Z3oo2oI+p3tdyk4X0?=
 =?us-ascii?Q?VxWInXtNKZRhI5fEbQg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 12:15:14.2422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1812513-68be-43b3-23f4-08de211bf81d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890

From: Shay Drory <shayd@nvidia.com>

The function devl_rate_nodes_destroy is documented to "Unset parent for
all rate objects". However, it was only calling the driver-specific
`rate_leaf_parent_set` or `rate_node_parent_set` ops and decrementing
the parent's refcount, without actually setting the
`devlink_rate->parent` pointer to NULL.

This leaves a dangling pointer in the `devlink_rate` struct, which is
inconsistent with the behavior of `devlink_nl_rate_parent_node_set`,
where the parent pointer is correctly cleared.

This patch fixes the issue by explicitly setting `devlink_rate->parent`
to NULL after notifying the driver, thus fulfilling the function's
documented behavior for all rate objects.

Fixes: d75559845078 ("devlink: Allow setting parent node of rate objects")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/rate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 264fb82cba19..d157a8419bca 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -828,13 +828,15 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 		if (!devlink_rate->parent)
 			continue;
 
-		refcount_dec(&devlink_rate->parent->refcnt);
 		if (devlink_rate_is_leaf(devlink_rate))
 			ops->rate_leaf_parent_set(devlink_rate, NULL, devlink_rate->priv,
 						  NULL, NULL);
 		else if (devlink_rate_is_node(devlink_rate))
 			ops->rate_node_parent_set(devlink_rate, NULL, devlink_rate->priv,
 						  NULL, NULL);
+
+		refcount_dec(&devlink_rate->parent->refcnt);
+		devlink_rate->parent = NULL;
 	}
 	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_list, list) {
 		if (devlink_rate_is_node(devlink_rate)) {

base-commit: 8c0726e861f3920bac958d76cf134b5a3aa14ce4
-- 
2.31.1


