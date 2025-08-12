Return-Path: <netdev+bounces-212747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 349E6B21BD6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 05:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446A519068C2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987912571C2;
	Tue, 12 Aug 2025 03:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ACULJty/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE29135948
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754970765; cv=fail; b=cg8Teo3QOOE5gggIA6eyRrHXuls8mU1vpbrGYFs17BpyHhwQc7Uhspj8vjl/FS0VMBZhwaZGGX6jgb80+VZePQkgupllA6Z+QQjxPdE8EPSzW+tiIrKV+uPp9z7fMr2s0IenH97hvZcR96GYZ7FuHxAjYXWQv4eENeZupCBqLI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754970765; c=relaxed/simple;
	bh=CdN75hnWEA7nfNxl7lxBLYYmxmcaxjBFv+KdVWfgPmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AW+TAVdPqm3RooIbyEmexP4agUId/eXpkIDxEySufdfcgBGDxstbHfaVZL1PndwuFUaf+MGtYvDUc+fnJzONVzYK+0eTrDu2m8KaADdAi4SGQGRkdv7Ze5JXQlct7Prg/Vrhf8psnuOkFkaqyArnH7den3Y1aC8VGl+/7+v5NuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ACULJty/; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdA/gL+XkLcsG63BtYI+gm3oNUa8oWf7kk0QUfJxyW4HJpVOx0XCj7egdoHrtOlWOPgpPDPhbeM9vur2ItPGW6DgpjGQMw/dg3IPpZXyUPL+Bmucl7BdhblJRP+RTFZYKsGri64e2HeBD1LcRiWkYSmNIwMPfrxzNmgqYNEcmVqXzZv8p3I/uocAbG3vUTxvFvvMzNvt7wOiD8CRwIZZKZThx+bieOgn6+wDxwCnP8hOrMkZ/gwZPGV66ApP4L0oGJGo6hjrIqUIffKMbqD8BJ/gcBWdwRmMIPhT+P88DmIxI/w09z35FWpkzMLzxqmcNqdHbdRIu+BDC7r2iK5wyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FD15/CuFGCuMzkYzOifC6GDaxnVN5H+0Pf90XHGKgXk=;
 b=Ij4qnNdB7kQNqFGdtERI1cHRO+9XMpqBwBFAdb4qt9cIOYObh+fit67Ow4ONhKRpJr/+h0Xpv8xpBKgvjv/rs00e5DbhiRArBKfmvDrvSdFXvLA1cczl900xY6bCQPFg8lYFn/TIJeFKe3asaDRLGTmFev3Ry4NkMi81pE/jOxJD5Aune1pemjrTRtHpg7MqXPyipXVI8Kd9UWnmPbd6yuD+v8oC2i9wGXj+f9mnuUtLg9jbwkiPk5qWW/GUrKN3CnxSjmVd5hV+9chY1VwafChrxqATNW4RFqRWi3PSC4owkP2MghgqEFX173pCBAJDkNJt1KrB2GP5SuTm39jxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FD15/CuFGCuMzkYzOifC6GDaxnVN5H+0Pf90XHGKgXk=;
 b=ACULJty/MbfscxCWCpEipcz6rZ7Kj2/u87+sTb0xx6tajhC9X+boeq5UNgBG57jWUJiIIIlRkIP7yp2IM0fYtV8+SPsDelctg7cUmDTZjqAccSiUqvjbpgXjFYQTP6NeUl7RmOgOFZ+/v4nkNex+q8n8TjMRKqqeQSjWdV8ziid8tgrliX4BRA0UK9AfejYWwXM/Y+yeOZzr8ooeJ4vnC8hQiG2dNVOK4lML5qDylR7hdHXKIw+owxUAZFh+Gsj2uQZWaFZQWtGr52wLFxRyjh6Hk/HIA93S4bfR316uDXnqkvgivaK00McjE6kW0z9RxXGkmTl6tYC2XvwP4/xV1g==
Received: from CH0PR03CA0191.namprd03.prod.outlook.com (2603:10b6:610:e4::16)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 03:52:40 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::ad) by CH0PR03CA0191.outlook.office365.com
 (2603:10b6:610:e4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Tue,
 12 Aug 2025 03:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 03:52:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 20:52:25 -0700
Received: from sw-mtx-036.mtx.nbulabs.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 11 Aug 2025 20:52:24 -0700
From: Parav Pandit <parav@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, Parav Pandit <parav@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next 1/2] devlink/port: Check attributes early and constify
Date: Tue, 12 Aug 2025 06:51:05 +0300
Message-ID: <20250812035106.134529-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250812035106.134529-1-parav@nvidia.com>
References: <20250812035106.134529-1-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 946ca169-d214-432a-37f1-08ddd953aee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EmXDq3CtdGByRgLZs46biZRzuzBf+sA5E9IHPY0LSNUQtev9lc6gVwp4BiHi?=
 =?us-ascii?Q?SO5SiKhtHuAnz8hTp0O9hj+5IFt0tJdz7iVAgNPt0f8fndKj+EJhpLp+b0u1?=
 =?us-ascii?Q?MYQZPubqRS6a17rdiBsreu9UTVYzfAkFWW7kEFcfMBBygpv4cKphAb3IMp0C?=
 =?us-ascii?Q?V9AcuDYL5fFmtXVejpwvQ1z+hCpWDsXD00zxoODTI5HiEUCC70iVQTxAFJUg?=
 =?us-ascii?Q?PYLWT5wcVyC6AeBbBAOldCSWmQQwesinN3SAGuM3fVMhz3pdCrzOgjZ/VcEH?=
 =?us-ascii?Q?l0UAgDdT9XR2x6PmJ/P5jMq9janJG5hS8nlH87WM5VJGMG1TEUurxi9ZOAlC?=
 =?us-ascii?Q?3CbqnxRq3xE46e+P4pGU0iEieLcKGc+h943j+1eQiVZw445nEaNox/BRvlI+?=
 =?us-ascii?Q?VsAxG8fGVxDH7AmK22hnjUITHAdb9h2fgPY6zqmTlHebiPeFPlyyGzLKUvxE?=
 =?us-ascii?Q?n7hvwOw28bEBKDQw8CbShCs+EJFJTusmbKaB4a0CQ8CcNm9CdSht2dAiID1/?=
 =?us-ascii?Q?cHtPovzPRSfMWANxX/tE6pKV8qtIhVeouD62YguiwFqpWIpalAAAbRFGrq0i?=
 =?us-ascii?Q?nnL3ww98prvTvXoC16WnWNVbLmiuDgmCiUiWCMC1/0u0jRlPNqYwueiDwWkp?=
 =?us-ascii?Q?UzmPkYiTq59kfd3mx7ZB3pz2rwLZrhGnj4dGCrKIxyHSV2syCfI5fqgkm8f6?=
 =?us-ascii?Q?hTCTjFi5/POBZr4Z+nfX4BR3UV/YJ9twIidvARjmgAM09qRzDppNH6DGAaPr?=
 =?us-ascii?Q?d6Q1+cEz7GgpgdBtNrIOJB9XDdxo0tQWiNewxM9Nv0eZbrc3fd825eO7i7rY?=
 =?us-ascii?Q?8ANzdxhTVfS4ZwLliHNySpmfBHVg44Rnnkl/rFfpEIOXhL5m3+Gg9kwECsBW?=
 =?us-ascii?Q?iEVqbgh/eMr9L2L620HVgIlTvWZ9PAOt05A8dSR7JOR6PY+c3Gq3ePTLEZ8q?=
 =?us-ascii?Q?dUl+scE8HqdaIWdN8dUt1LN8vLFC92Jk8q0gmW9eAIRxuGEkts75qP2eRd3h?=
 =?us-ascii?Q?6k/PDXmV+ZNe6BHGNHmzVPZTZ703N3PO1I3Nb+RA5TE/yg6H53b8X356okaX?=
 =?us-ascii?Q?1rxjTxKrSVPLw/iriOGYmuZDaOpkuPpPF68gsI512LxTKd/5WJ0u3YCSBBbI?=
 =?us-ascii?Q?S+gFHNgmMnoQBUx46OuirwFpNUmGLgMKbkM9TT5aFWc7XLFn+eBsJcB88A8Z?=
 =?us-ascii?Q?JGveGXmEFdhx0+Uu+Ix4icDnifzArJCOQvckGO3peFMlrAXVRhmmTJys/oV6?=
 =?us-ascii?Q?H/XHiQPJ4mHWWAY9RmpI6Er86AGPBP/oXiEMerOTZWTLGANSzNqrbEzOf27j?=
 =?us-ascii?Q?iu0CJ+VuC26xHGJ8WX0j2pK6mxvn33qEjqxkiidlSPNpxz4Y6SLACgozHHBc?=
 =?us-ascii?Q?oz3UWVkRLoge/DRjmVRN8c1EvRJVdJFnd0s5h6dAgY2zJv72RXTDRBNtZOlv?=
 =?us-ascii?Q?l9QAb1OWNYSJR3t3TgQoHm9tg7alQi2br+9rot8ek1DRiPoMgrWuK2a92eyB?=
 =?us-ascii?Q?/wZ/DXzaghtK/whI8SvKq87JbsVrzZLVMX9h?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 03:52:39.4930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 946ca169-d214-432a-37f1-08ddd953aee8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

Constify the devlink port attributes to indicate they are read only
and does not depend on anything else. Therefore, validate it early
before setting in the devlink port.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 include/net/devlink.h | 2 +-
 net/devlink/port.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 93640a29427c..c6f3afa92c8f 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1739,7 +1739,7 @@ void devlink_port_type_ib_set(struct devlink_port *devlink_port,
 			      struct ib_device *ibdev);
 void devlink_port_type_clear(struct devlink_port *devlink_port);
 void devlink_port_attrs_set(struct devlink_port *devlink_port,
-			    struct devlink_port_attrs *devlink_port_attrs);
+			    const struct devlink_port_attrs *dl_port_attrs);
 void devlink_port_attrs_pci_pf_set(struct devlink_port *devlink_port, u32 controller,
 				   u16 pf, bool external);
 void devlink_port_attrs_pci_vf_set(struct devlink_port *devlink_port, u32 controller,
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 939081a0e615..1033b9ad2af4 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1357,17 +1357,17 @@ static int __devlink_port_attrs_set(struct devlink_port *devlink_port,
  *	@attrs: devlink port attrs
  */
 void devlink_port_attrs_set(struct devlink_port *devlink_port,
-			    struct devlink_port_attrs *attrs)
+			    const struct devlink_port_attrs *attrs)
 {
 	int ret;
 
 	ASSERT_DEVLINK_PORT_NOT_REGISTERED(devlink_port);
+	WARN_ON(attrs->splittable && attrs->split);
 
 	devlink_port->attrs = *attrs;
 	ret = __devlink_port_attrs_set(devlink_port, attrs->flavour);
 	if (ret)
 		return;
-	WARN_ON(attrs->splittable && attrs->split);
 }
 EXPORT_SYMBOL_GPL(devlink_port_attrs_set);
 
-- 
2.26.2


