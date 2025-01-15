Return-Path: <netdev+bounces-158416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78561A11C37
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C51E1889B5C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C10E1E7C2E;
	Wed, 15 Jan 2025 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JhKty0y0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B811DE3D9
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930420; cv=fail; b=Zfyg/ysmfL/56DxoqlQpBBLpsAJP7CjTyEZ47Hb0gErpK63tTOc2vDxbbqCrh4z/aWvHFMDSiLLvCqDt641pJk1G+4yPDAHzJ7l58wVw9wo2i3iBH1G5u2vvuBhN3ybYjfVfgzXypmaKaCQynZEKahlOMrdZM2g5atieuWWsoYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930420; c=relaxed/simple;
	bh=Mr6Bkqjdy3YefwWFWOEJjpMnsJ0GUo2TvMluTXSk9jo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeQvcx+e32BLz84PnjbiP7VvexXLPtblLWDaV0DHeYPwcF4WdTYtIw/vfDdI5IeUXO6j4sl6CmQ+HvFZXFfv/eIp/F+OeXF27w1Bs8qnsYvsPuHf811YiPOmWnYBntKmvHcKFHo2lBISoyPZ5RyPNZcP0WLlyKdSGadQzzcT6Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JhKty0y0; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCHbew2DmlDJkkpYBwIYnxIzreA2/zIPRqref7ItrHQPFBZETk0D7ptBHcVyVDlzaWz1m880BElbm9mxLLqWfFIktbgdzPk9xWsDGPaa3gI/Tu4ge6MxBPJXa/y9TEWyziki2z6Df9BOZYXbi0x4XzrdhcWp5WNffZmBSH7PJx9ue3fSBLmFLxxCBwjQq4pWQCmXarpQxz3mjZpwHH6UmqaTyEYT+/DTb1+j8+Eu+KGqQ5S3xOawYZwI2VGgKu0kwaTIvaGXbniYtKXj+99z8Hwt4jAnuskpfxbg7zXYYU9f4L6VwYJQgejgT0kWSNJV8NKh7l3yi0uOQlllvVPCZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbPrCeQz6BXOpLtftRJ1SsPU6dUXqpLR6VKT1Ao8qEA=;
 b=TBpW4u1olt0MWAkNCMH4mrQ5ArzRx4b/L0Ot22MsYYQodRTBPow8fnOVbdH/2wGx/4sjU1uzM6L59p4urntZ1VNchinZkMfKrzcrs8hNbh+MQPTQGsRocgUsuycrm78CluLGw1bgchOWEjBrs4D7LOgRogXWgkydaIJKkwVpQs0brFrGxq+qTp0qPMghe9YarLLwxGX+gBsYOOvvGIR9NwCneCdsa8P+FZ7ZtBLNvq4B4DqF/VVq+BDyuE346dURpJzSc1tGQ12vuuVAxlLBYNwq4REtNuzPIxySabA7Ce3vrlI5nf6s8W4K4hSB6aqfuOjmlafe32dBU+ASKMIYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbPrCeQz6BXOpLtftRJ1SsPU6dUXqpLR6VKT1Ao8qEA=;
 b=JhKty0y0mwdYuiN2kXrKHXpslkqLssHg8GD3fMQgmV3M8WgYxEd2Z30bYiL933PDXX23FVZusMNmIJONabR7nQm57EnVKPDAwLI4j+/LslKXAnISbKR/9jK0CipUQrvaMgfqLQ9dhl1QA2a4ZAIHg16NCRybZJAkWjSFSCeRqbudqj//N92eBLAnNOqXRu96JRyQuv5dv/FWnDX8hwhKVZu1p9N7dx4v5ihH1DqVF4R5qGeBVTxEOvKcppf4uRVNrfG07eeu5YuIoHgu8StxEtBCcqNfsnPJg4AH7tMYLNTvfLy4ENyLkIIZmyytJQQ9okuI9eh3LJLxelnUK9kIkw==
Received: from MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14) by
 DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Wed, 15 Jan 2025 08:40:13 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::23) by MN2PR01CA0045.outlook.office365.com
 (2603:10b6:208:23f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 08:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 08:40:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 00:40:00 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 00:39:59 -0800
Date: Wed, 15 Jan 2025 10:39:55 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net 6/8] net/mlx5e: Properly match IPsec subnet addresses
Message-ID: <20250115083955.GM3146852@unreal>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
 <20250113154055.1927008-7-tariqt@nvidia.com>
 <20250114183735.15aea391@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250114183735.15aea391@kernel.org>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: d7be7b15-50d8-4cb1-4701-08dd35403a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MC1J2cy7mjXOIUdzWUeGqZRhto3kKEifB/YUZtYic6Pn4OFnDQiU9C6e0CgN?=
 =?us-ascii?Q?hZfD+V0kYNMx8BWLUyrgfdlwCmZwA6y9/oCKA3jDr/OCR6wLvGnvRr3RdiMj?=
 =?us-ascii?Q?1qpw89RVA1ZQn79qAxCEbuCmxI9b4HF7iled153utgyy6UwlzJo9N6w0VBKw?=
 =?us-ascii?Q?hGeGJhyOwrt5KBdd6FU8o0nawENQdq4nlnPOtWtsU2EJWmNYPwLoljIqMi+A?=
 =?us-ascii?Q?BaVo38xbNYWvk0sFct53UFQ6tc3Ijh61SfBmFiSIlmAY3sqIwCqUZui4vPsU?=
 =?us-ascii?Q?oLhjQY+O14s0ofFXCJQGdgQVBanTJ89k2cGYV/R/zqegZL7S1Chs/xveYkbT?=
 =?us-ascii?Q?SnELeJNcI/ohJBAkx8Dy0ps38YUXuDFrp/sdMXlYbebRIy8SHqbpuUPEkCgH?=
 =?us-ascii?Q?2N/MLop3QWEkEQCJMBo1jW7IwggfpjFguVer1jTHU38jI9F/Z7sAUL1gWlnN?=
 =?us-ascii?Q?jv1KpNxcLQzdErRT96aCo9iCP1KY44nWoM6mQc7CFHFSkj3c84e+q+IdmCW9?=
 =?us-ascii?Q?S8WKMVoxjtWtQ0MpNqtLkIcG8G10dX31QICAFCcAeksF4pKSA5fOALAXo6mu?=
 =?us-ascii?Q?+pV2wj74idDdfBvZNsbbOZbRrjSR3O3MRJpOUnyisU8m7CYLMhu5f4nAf/Vx?=
 =?us-ascii?Q?vpG+eGVBGUbD+luPIMURiOJ5jfy9fJ7gvn2NGAoMTdU9jVB33ZhPboGMoszz?=
 =?us-ascii?Q?Tzfxq/eRtrBlrHubz4wYZsnELu3Ze2LTdVYiXagTPG103dg1O9O31jgNiaQ3?=
 =?us-ascii?Q?kBFDjvl67Xm10JGxhBV976gyuYDTm6gvqw8cn0AA/nP7PlF5K+HCTTEX0py2?=
 =?us-ascii?Q?dTwzpOrxHFCAD2hI2IfOwWFbtOIV1xXh9HLWqhVX+Ej8mZhsd27LArLRdgzX?=
 =?us-ascii?Q?S5EtpMNWfwMDAhg05Il99PIz1TmAA2ib0Vx4ptVkCRWOwy/njp209PKTbBVT?=
 =?us-ascii?Q?9y5ITXYoTtSbrgJzshQOSfmNNeJeHNpnY9NaDRom5ii99O86HLx59h4jrsNZ?=
 =?us-ascii?Q?FpOr9PGXz67hYe6j8I4wCSu7wnfQtCzvNp+vU+qXdrceX/RAUUAW+RQNf1yS?=
 =?us-ascii?Q?DVpoeWDU1I3OQu9+bG8EwR0lqLY3/WA49eGcJamo0NOgsfHb4r4Hlbi3mouW?=
 =?us-ascii?Q?fHX2KEcLAuPknWxxN9lC6Xad59Vyg9d5x5G9ittf5vZaIg1DvyXVXIP35h7K?=
 =?us-ascii?Q?pBpU7RMLF2hrsGAbZg2q6mYSgEf4aFYl0xYYcN0uwx9OznX7j/rm8dvRjHbq?=
 =?us-ascii?Q?PgFrJy3v7dI4t1nXB61zW7ioWpT6FmJhjhEN8fRKSi1ddEkq7FfGkn0QNYWK?=
 =?us-ascii?Q?CkHhUUeXtOvz0LeDD1dqNFDVDS9H+2g6lMMTOKT/ZBwOEKT4hLyZHTl0YMja?=
 =?us-ascii?Q?ASLuKkNlnKsGOLh7mXZxQ+nm7bNaQe+tTaRapdsR8Ca8GF+QW76tbCep/5DL?=
 =?us-ascii?Q?rmvn0WkKHK6FlgO8d+pNGRjpIxdO2DcKPtbxltbhaYTru6QeRbO5OWebARpW?=
 =?us-ascii?Q?amPsA/tMmqJmtFg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 08:40:12.7818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7be7b15-50d8-4cb1-4701-08dd35403a5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254

On Tue, Jan 14, 2025 at 06:37:35PM -0800, Jakub Kicinski wrote:
> On Mon, 13 Jan 2025 17:40:52 +0200 Tariq Toukan wrote:
> > +static void addr4_to_mask(__be32 *addr, __be32 *mask)
> > +{
> > +	int i;
> > +
> > +	*mask = 0;
> > +	for (i = 0; i < 4; i++)
> > +		*mask |= ((*addr >> 8 * i) & 0xFF) ? (0xFF << 8 * i) : 0;
> 
> sparse is unimpressed with the lack of byteswaps here.
> 
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c:1159:28: warning: restricted __be32 degrades to integer
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c:1159:23: warning: invalid assignment: |=
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c:1159:23:    left side has type restricted __be32
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c:1159:23:    right side has type int

Strange that I didn't get such errors from kbuild, I kept this patch in
my tree for approximately month, before we sent it.

> 
> 
> Maybe just force cast to u32 inside the helper, and add a comment why?
> Or just byte swap.

Thanks, will try.

> 
> Also from the word mask and subnet in the commit message it sounds like
> you are shooting for a prefix. But this does "byte enable" kind of
> thing :S Think 10.0.55.0/24. Maybe mention if this is intentional in
> a comment, too.

It is not essential, I need to take into account subnet too.

Tariq, please drop this patch for now.

Thanks

