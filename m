Return-Path: <netdev+bounces-101462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7A78FF033
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C051B282581
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D03719A28B;
	Thu,  6 Jun 2024 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G67e0wW0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F29C19A28A
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685559; cv=fail; b=KafKsUZdsjULsfQPVsw47Co++01GEc5kesiIpUJsQg+fUZNBK1vH5VsnT4w2ejI++z2S52CUEVv8+pKRHbD+oLWqQxuy2GsWmbnfP7kzjNCbG2iriqrn8cFyjXge1UiFRojf9wtLTyaUbYD36N5XTsXlPNdeo7DhjNFBs3w9kkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685559; c=relaxed/simple;
	bh=5GJqYavS/pkzOndgeJcgJ8tdg4q4+uNBrwABS/1u4Qs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FATbQSHbHqEtojqiVWnwzzeAo2RwH4eVZJmfun32zWbQvd7jU/AmMWMs/ryovkd7dtt9V2Q47t4xrxQhBELRb8nnTKbENGm8Wevb0mfXXu/GO+ocTN3Qemb2OhUcTH7cUUca2/HHiIrM1R06mlAt19mvsgMkchzl4lDogjY8Qps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G67e0wW0; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVnFYgxj3uWPH4LcD/BwGb4aRrpXkUM4HmXblP6yy0DJs/vFQyotFtKhGvJ88PhiLAdrqsonViEHK8TuKljVbOApwsjuMFohGEtWX5m+SBLoPXl24B+/nz2cjkEzMD1D5Wpx8rZhx952zpxkXCh9I9/hkIDh3TRTczTCElMuLPUCSIQrOFEqRru+gR5UcEiVOqmRhjuGkY/fa+UD5Apslt004unjQ+ViIC2I9b/rYaXKDCm6ijX7YDaUdlyHQ2bdZgjyCRGojqW+7ZO3hADqEIkRUXW1PX/entmni72oyQPtj7Gl+dcWhSfnrFj0+bpJb6HPTAHJSEaWuZV/gVfNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCzn0Ck+tun93I4l1v7Ts9yJn2hvDSIoVQPI4Ul1Ca0=;
 b=GWdZ6QRidjgwDDbBO8z80+MQxT5GDCHj5plsgFaLI8axhDe91W+qRGtTLIPT6gO+4cqYh6H0lwI06G9Dg5mIskXGEez0I2IdSdHKAZPkzd9w3yyuCX3LoxhfSlZ6Y9fjlWOWSANstrH/wX7txoojrNq0THrt34WTjmfm/G7h9CQykLVRDaAmjuzgpodVO/PC0O1JdCZ8gHvSQRv4rDbEcNY5HC0FMLKC4xQX6/gyg+jBGLS2xlZi6NPnO5y/5EwwD+CgJXXyeWipZeZ7ZwAZVY/2JFmrKIn1/JdUpOcUzbdEJShF+EJynfzeYIpcL7OeYl6eZlNkcdRrvjEFRTSHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCzn0Ck+tun93I4l1v7Ts9yJn2hvDSIoVQPI4Ul1Ca0=;
 b=G67e0wW0YJao66Xez1OlNVwJIN8UIB5ObwkEaaLzOUnzL8x1LtSJpwnvb7DUdemGzyyjl4MygwV/dJP/BeTGznjFEnkkX7xO5Zhxu0cg08+9WML5BBVZfaZ9ofyiLdWSwrkx3VVvCCSxr4fRihC32wJxad6cljjrdIvZxCU0t4H73dwGoE2V7K/X0bSR1hVt+GVPFwIaN43jw01uD6buER7B/dY1dKIxI4juDM9COupCYJDNf9HO+2AmjFJbmEGthWP2sKd5i6Dq+GXagBYbIyUKYFLzeuJv8F0ph5fvANerHW3hDFfEBx8hROA9n5XDGtahOdwslNBKQxdWWD1ybQ==
Received: from SA9PR13CA0054.namprd13.prod.outlook.com (2603:10b6:806:22::29)
 by PH7PR12MB6634.namprd12.prod.outlook.com (2603:10b6:510:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 14:52:31 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::f2) by SA9PR13CA0054.outlook.office365.com
 (2603:10b6:806:22::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.11 via Frontend
 Transport; Thu, 6 Jun 2024 14:52:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 14:52:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 07:52:16 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 07:52:11 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov
	<green@qrator.net>, <mlxsw@nvidia.com>
Subject: [PATCH net 2/6] lib: test_objagg: Fix spelling
Date: Thu, 6 Jun 2024 16:49:39 +0200
Message-ID: <9615fdd350c154c2c15101906e3e9f961703e5a2.1717684365.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|PH7PR12MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3d505d-b160-4393-179f-08dc86384a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4PvJaqPNa0JeE4FDzP7Mjt2n2kwcBSQe//CYDYxt8hNsJ3KX0Ts85VhL6jIQ?=
 =?us-ascii?Q?tPuFHUL/rA9/DIVEymMz4E4MtLDg+TcJKqLLq+F1od6t2IGz2idKhbXnz1CT?=
 =?us-ascii?Q?zg57cBnw1VJo3xfiS+CymKFTn7Q8hZ1HMjmiBnTdXs2XTCfIznF9JmLjMMS3?=
 =?us-ascii?Q?UaPPz94LGAR0Zv+TRc61tMcpN2azpQWziEAcNMiqhS9j1SrdA/T/oRSVnEQ7?=
 =?us-ascii?Q?O4npbVtV9EjGS3Tptz3JEyjvqNBurL/qF21msSGuLUh0WUf3KEqeZtSqInTM?=
 =?us-ascii?Q?nVmm2fZMeC5QmiXjPfj5UIoVnlsOf78CUIBxwcVqlXMd2esHn5sNSKd3qSWT?=
 =?us-ascii?Q?cDp4ga0oIIVDOJwAXoOxCtZIawah5DVixbKE1faONOzTsvUKawXO3prrmY02?=
 =?us-ascii?Q?xYSrAoGOuPSEkKS4Lo1aLFNBc91vdZAcTmKjrkNuvqYJaHm6ge9c4ggPra8c?=
 =?us-ascii?Q?GO0bkaztNnVBrZiW/N1UlGNJJvc/cKvlEj328dWsRxbptR3J0HN5BCxubJwR?=
 =?us-ascii?Q?QyufRLwsvuDFWj0lGz66I/Nztjyk0MD7r5B5NY7JfZsIQ2sPHAbI1Ws/0Sw4?=
 =?us-ascii?Q?wvvTU/Y4QEpQx0u4qiagiXRcxQ1WqBFhXAHWcNMCqMA5qnyXO9Rc4KuYB3/E?=
 =?us-ascii?Q?aGgbx5T2uAZG9Sm5WESKuZ0bkV1Dt9AVVUAYIeEF1+QJ9At2loEGKfLYxlY4?=
 =?us-ascii?Q?J44ExmeMTL0omzX3Yjaglk8GcjtXHiqGSzAAYndTxoVBYNeXQxNStB94aFOf?=
 =?us-ascii?Q?BmZNARrz4Ps42A5FJsIYo+lXcnKIBM2lJo4sn8+JFLC09Ay+K7BY1FLN82WO?=
 =?us-ascii?Q?rgxjVd9URv3I69NpeDclwadg2pBytGJv9kUAtBRKdicqAd/LpSVBC+55fWF2?=
 =?us-ascii?Q?9c8sP+aK7fs8vK6cNG5TObkBxir3XN/52d7J1GK3rZhsLyMZxxNwMRQmG5P0?=
 =?us-ascii?Q?VhZ90g1kiDc0Sh7191hd0reNhlqGXVvYQhbKsJ9muZ429d9L1ZhwuzmnK71V?=
 =?us-ascii?Q?hrqN30OCXXi+56/tl6kqdSosrcdkGrMNHBtnAHwHvW4pAPJ3PTdxr2i3PG+J?=
 =?us-ascii?Q?VSza9ZyzvHAveTd28PsfenTpBsYVu18VUO6dVqPg60J5Y8Tvb2zOOiKxlc4b?=
 =?us-ascii?Q?5xNPI9JQRkNHTu8OKbSrDeuJHlaszL274TlXBiuWMHqtp4Z9XLfkPc2HsR4Z?=
 =?us-ascii?Q?3rAkKRbdLObPbrGHHk1XVie8jzgiMcYC0Fvs6OVigF4xoWAB89kdmnT/Tx3e?=
 =?us-ascii?Q?idTpkp4hxLQzCBEWi/K7bGjwxbns5Gfx45gWlKlBovMBxPB19i4JCBGGI4y7?=
 =?us-ascii?Q?Dy4HTPwHiSgZ4aS5B2dV95jGIVVzTCkUipxjgdOlaq88g6b2hW2qGeoKSjAf?=
 =?us-ascii?Q?iRINkiCL8T+y7I48/4EsRAOxiCgKgK1ELGrODwrLzuDr3OkskQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:52:30.4535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3d505d-b160-4393-179f-08dc86384a82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6634

From: Ido Schimmel <idosch@nvidia.com>

Fixes: 0a020d416d0a ("lib: introduce initial implementation of object aggregation manager")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 lib/test_objagg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_objagg.c b/lib/test_objagg.c
index c0c957c50635..d34df4306b87 100644
--- a/lib/test_objagg.c
+++ b/lib/test_objagg.c
@@ -60,7 +60,7 @@ static struct objagg_obj *world_obj_get(struct world *world,
 	if (!world->key_refs[key_id_index(key_id)]) {
 		world->objagg_objs[key_id_index(key_id)] = objagg_obj;
 	} else if (world->objagg_objs[key_id_index(key_id)] != objagg_obj) {
-		pr_err("Key %u: God another object for the same key.\n",
+		pr_err("Key %u: Got another object for the same key.\n",
 		       key_id);
 		err = -EINVAL;
 		goto err_key_id_check;
-- 
2.45.0


