Return-Path: <netdev+bounces-210803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6EDB14E14
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798893A1BC0
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 13:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3168114C588;
	Tue, 29 Jul 2025 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gBg0rlKl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5051442F4
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794397; cv=fail; b=M4TS9tty/FTYncFbF+JKqWqhrvAb1MWhhl+5OJtj2pYA5U971Pe2fVmNZrMUVV8Enu59M98CgPP+eY5q1SW7TPQ6OedTf5EVqWpK7vryRAQ2diMs6rdtx2ikwirojiFN6qu8mytEQi2dc5dvB8y14ctApGYx7xsIxTUkIMQCJwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794397; c=relaxed/simple;
	bh=h0FIeI4QlKXc5xuOOjUlCk9hhK8fnnDVg7ile2ajPiQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oy8KkTGDP8CatOdEMUGmpcWfj7W9NA/eLiqADOSrOvKohA9MpYZZa8Vra7k7IVkogyDsvQNsYp9yy1T2vVkAoG6Jle9lRCUSdFqg3X4bm/932s9kbmAVy6KEWhE5jtZyH3bckzKf7Yxj9VST+5hHZiAWr152QmdIvLZcBMLuevE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gBg0rlKl; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sm5cE3k2rfeML+3Ci+ftr53RDBGbFYA4Z4gcmPVPFoS0X1r0ZgcX5mIqaH0ar4VS0g9AtU33M5826xyf1Ju9vFxjXh42m6VmKTGjN3HqIOQZn112i7FlnUKJvSQFegSrlytmSxoigoRO4SRBNPX0v7MlkRsZ4kLxLuRxikifIB/jWpgUuOaOHf6hv2JARBSPmEemW9I+kWQ+HDkusdCpEBdeDMJcGUfNrl8l7IAx0bqhUgE0XbNsMs5qSkrS3z7NGpggu20Lw3xQKhEmCShxm4Sx/nTq2yRa6TrA0u3iRaIzHS8mFr5lr13iunwfLRbBATnaJOdFGkuGfoJS2xAzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gT77iOO/NzDU7wJxlHfqF+G1XnThZP8Az7CNwoUY0rc=;
 b=STU8EAefNQVIsz6nlHM9I4A5yQyn5r3HXxMGJNXrCZQwLn3QmMr8MhA/61bL/sbQYwV7w3lih3o+oJlOLHu/85ZPnDSapRiSoqNZBjQtjTdLONYBMN6eziEDvvRHJCW06Nb3WjnbBbVkdLy020GmS84qT6AuoV0A09sbcb9R73982fR0ksDl+yiHKQHlLmfBUyxX7tZ3rQmtNWDcdElPdaXyGBd4qJOjy3LNY/5OD5eO/NBERgE5NUfr/k8sJLn28FWI3PaoDQHf3xNqlheGMsF33r5k7I0+UUBYabSGGk0doTl8yK6eTEim3GMkw5bhKEYmpfpWNWZ+qZNNcEHsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gT77iOO/NzDU7wJxlHfqF+G1XnThZP8Az7CNwoUY0rc=;
 b=gBg0rlKlBrP27d5TZG+vJQ1yfGNinM4uDzBnhTT7dYfIokEgb5mZTmj+aJSHnQtwaYA2ynqBcEnXXPnwHiDi6VkQfQyBYj9dXNbole4KgYP+f/vIUzmQ5LyK4vv7IYeMqeK+hMF7urnK/o4aI8qW9uuL6oaIfMniXgmjhS4sD2aduVcnG8Pt4z4vq2+X87ixTKXruOv9+7WRT4cq4PE8X425ylJlH5516xZYikmUkQx1+SUDbKoaPIuwjT0b1IpJxwYoXC/NTVM+Ye6JsrLtNGJEl/JSWvLs71URaZkDHYGr5K+UuSGLlnFKgnFU8qSeX/i7140cDDm5CokjBgG3dg==
Received: from MN0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:208:52d::7)
 by DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 13:06:32 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::bf) by MN0PR04CA0011.outlook.office365.com
 (2603:10b6:208:52d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Tue,
 29 Jul 2025 13:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 13:06:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 29 Jul
 2025 06:06:10 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 29 Jul
 2025 06:06:08 -0700
Date: Tue, 29 Jul 2025 16:06:04 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Steffen Klassert
	<steffen.klassert@secunet.com>
Subject: Re: [PATCH ipsec 2/3] Revert "xfrm: Remove unneeded device check
 from validate_xmit_xfrm"
Message-ID: <20250729130604.GN402218@unreal>
References: <cover.1753631391.git.sd@queasysnail.net>
 <177b1dda148fa828066c72de432b7cb12ca249a9.1753631391.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <177b1dda148fa828066c72de432b7cb12ca249a9.1753631391.git.sd@queasysnail.net>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: 821caa91-285a-4163-b9ba-08ddcea0bd84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GqssNRIeksCwiGwYCT5G2szL6YJZ/ZU1kDWTvN2PzZeQjYStX/rROhtAiTpr?=
 =?us-ascii?Q?BAkgoTvCcLGH2eRswmMKa86X7Zpng8cK1CkZphHBky3t53SYWyROxf+KZ6TD?=
 =?us-ascii?Q?vjyY4BEnsrfYJ3Nlv8MITinQskEsd9O2aLipHqI5p42fPzhHWYKJAoWgcxeA?=
 =?us-ascii?Q?nuPOPvCow6/ECVeQl2bTDY6YDdWq/GBrdxJjY5LwjBJidRFGsBiT2VxuT4/6?=
 =?us-ascii?Q?cGEVi6HW6r4zPZKBweD2S+CQ1IgOlaSmg0Yw2Ap0SwFFmr27/Z2zeaErWLHE?=
 =?us-ascii?Q?oYYdJM6nbJzO9Nrl0TCMWfBQbUtBuDGKBe0XOSpVAf3AFV2ZIkCel6dAei7E?=
 =?us-ascii?Q?kSXP4j2XxLuqVeTATvcMDZuUvRjBPJ95xFDrXH0fl54zClIYUT8Y4C+M4oFc?=
 =?us-ascii?Q?PstMoMyQLJejPlm1udiQbzteDrPjRirI8Ls7CsVOBCmk5hUbTJPPX4zo0bzo?=
 =?us-ascii?Q?oOIOZumyYgTy1TMx8OZsrEvDPT3xOkyGZyeOpaOiA+RjGp3S+FZ9tHTc00RK?=
 =?us-ascii?Q?xGMRIjyXvmG/UpJMXdWNrl+44uFUwjETccEKPwZn/eUqpoEoDJPfqxDsZoPK?=
 =?us-ascii?Q?F+xNksX9ifszeTc6dR1qFN0PrBceQP1PAsO6dFMCqFV9Gj72vQZ66fmxoy9e?=
 =?us-ascii?Q?Mo0pjiml1IHrR85zVJqtGtc7f+6tQrctmsVDvqQ5739G2iyhLeHcvxuhdpFK?=
 =?us-ascii?Q?i0fRfesM0p5w+GL2JtSkwjLSfi5szoY0jQK1vGYJD83a55Z4zujbQK4ERBv+?=
 =?us-ascii?Q?9APhq6DDQCXIBJSyfdRWh9hSMz73i8n4Ln5ypWU9nlyIpmbwbu0wCUdQNurQ?=
 =?us-ascii?Q?3O77Ne9dCmLvLpU06XtJOF8bGnd/5AWRziAWsCfPeMVI0y5LjSakXG0IteS6?=
 =?us-ascii?Q?1vFIO7Lmfv/IgrFXSo+YrufmaCJSefuYOWlPYiDMoREDLjuPQbtrChKyNe2d?=
 =?us-ascii?Q?7Et6V40EWQzkiWI650YOoyhFeZyiddcUAH0wPxmlFXsaUoIRm1Lr2QUOT+Oj?=
 =?us-ascii?Q?wPu1PqC3/kcsk59zyKA3HJwZVYUbzuuPNQmgfDjUbAlQLBi7HU5fA8vUky9o?=
 =?us-ascii?Q?kS5zAn9P6sflxhs1Iw7GfTmACNtjBmWFhGW/B+e5ebPEzGglb9HseidkTHjb?=
 =?us-ascii?Q?uFQKnuW59D8rMfEhygYSzpaTiSbVfovkSw46PV7yICMlVGyYK4Oi9K2VSbwg?=
 =?us-ascii?Q?Vy2AIX8FHMb3TrtNDMfcorw3MU/9BD0AfBGLuvs11Ir18wuPYjra+tmgslKc?=
 =?us-ascii?Q?W2N9T9ihuKPOGuZYf40jFwwxo+/PruDLKh6tvJyAd2bNEPoNBglnglnlpJ98?=
 =?us-ascii?Q?L+Gs7BwceaYGkmIPBFKZtrIhGRblac+R90KPHggO0zTUfHzUYYK6A3B5rGr5?=
 =?us-ascii?Q?pPkzyDsCDfffXIxGzXqtEKr1ivOSylN+KgZVP6FROda91UhiwK9i45+1itX4?=
 =?us-ascii?Q?Gt9dCdJCRYeoD2oItoARuvd9zV6wU93EtwPzrW6xRnkWWH39sD8l2zpSFqfT?=
 =?us-ascii?Q?fH1UctCkomCdVltA80S+OW2Cr9l5o24HylJh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 13:06:32.3175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 821caa91-285a-4163-b9ba-08ddcea0bd84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499

On Mon, Jul 28, 2025 at 05:17:19PM +0200, Sabrina Dubroca wrote:
> This reverts commit d53dda291bbd993a29b84d358d282076e3d01506.
> 
> This change causes traffic using GSO with SW crypto running through a
> NIC capable of HW offload to no longer get segmented during
> validate_xmit_xfrm.
> 
> Fixes: d53dda291bbd ("xfrm: Remove unneeded device check from validate_xmit_xfrm")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  net/xfrm/xfrm_device.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

