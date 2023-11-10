Return-Path: <netdev+bounces-47103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4767E7CA5
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 14:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB3A4B20CF2
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C18D1A262;
	Fri, 10 Nov 2023 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W6HtwzId"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDBE19BAF
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 13:51:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCF53820A
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 05:51:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vz/M+cOApsFM0LslJ3mA2KJOMd1Tm9s7luVrh0TL+tparERMt0kKo0rwqLpVUTtxI78JW0lL00E1AJ3CIKJU8Kn3+m9e3ajpmcEP5SQNzp99z5cVBs53HsgvGwHpl9NexeBb9y6Ik6FCl/HFEvHlftMOTODzsn/3KuS4XLW6x1xNcCdOQpjOKZvJ+Yo3VR9/XEDSMC2MWoDnbOJ2UMV0c4KjaFN1T3FuFK+HvDJfs40RIw2Gn4I1YMCs60KUJBl6KivWcnmuUmymXQ2qnUhrRHgDFuWQton9A9lB3FBP7lJNe+Okwry9nZVMqrgdes3uQSueAFbpKctGczp1gXjgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW4YDoIKt1HFSHtYaid93UdVK3rq2yiwy+W20tdLJH8=;
 b=gkbsn7euBg0vHnaz13Y8zQluZieTT63H3W7BG68iTcoNRjTtGXjprOEp2P29qWOfV8EWG0QEXK4Vd6NlA7XSOHeR7O5cl8O3oMrVoomG/65gOHeWI1AxRQ8SlOaO828Zdekg5Yhls9KOCUI1TAI/QNKaU01tzRd9cXYRVphwgbsqFFy6bWJUVkQf2TeNIr6yM5ucDJ3O1Y6FizMy+wQWA+av5QN1X8Zm2uyfAQnDWmhFhrhFTHgT+a4MFDs3928iJEuHYQq/qQGKt5jrnhIpFpFtOsObqL62R3OsgO/sWxP48ODids69bZ7mWCvGMt56vN/GAOrZkGu61S9PCtDDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW4YDoIKt1HFSHtYaid93UdVK3rq2yiwy+W20tdLJH8=;
 b=W6HtwzId/ImB/TTEw23yPE/2cg4vsW9jiom4jxeTyz7wFq1JJ4ZrAE8trN7LqbkMH0i+PknlAUnidhavMQQABPLrFpshpiAkD/7K5uhIJM7X7YJwthwbUkds/jQPYYOwckCO1HB7nux0urptkEYDyqBjaPNRaN4FncdEkqRcnPCuD16BVhJk2oppzIPpEll0hjdgcEGwwqAA/QnCgnQlqDoB0wcziiIzHnEtaFO/i22u+F3jI6tlNelPQUyJqO06YgSc798BEhgBrA/EHwUeumPH4Zty3PEC56oJ0T3OsMIw2h4OL29V6+uF2D38gobw/0lvFewRfpbNBAkD2yxQFQ==
Received: from MN2PR15CA0025.namprd15.prod.outlook.com (2603:10b6:208:1b4::38)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 13:51:00 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:1b4:cafe::1d) by MN2PR15CA0025.outlook.office365.com
 (2603:10b6:208:1b4::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21 via Frontend
 Transport; Fri, 10 Nov 2023 13:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 13:51:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 10 Nov
 2023 05:50:46 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 10 Nov
 2023 05:50:44 -0800
References: <20231106001410.183542-1-luca.boccassi@gmail.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: <aclaudi@redhat.com>
CC: <luca.boccassi@gmail.com>, <netdev@vger.kernel.org>,
	<stephen@networkplumber.org>
Subject: Re: [PATCH iproute2] Revert "Makefile: ensure CONF_USR_DIR honours
 the libdir config"
Date: Fri, 10 Nov 2023 14:34:37 +0100
In-Reply-To: <20231106001410.183542-1-luca.boccassi@gmail.com>
Message-ID: <87fs1dyax9.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f30cc6-295e-47e8-26a3-08dbe1f412bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YllJVSdlbXWnU5xru2spGWKoblklJoyN6zwcySnaGG+W6R2jFD+SkRVsNm+kksTVQPd7qyr9X3qp7n85iOtHruQJzXKlLwtmDgc/B4uS4tONT3+KxyJECAy80lhjGKhzPZ3MMgnQfCllSN6mQBPaTFweUl5AofJufakyuklDiPAWYg3jiMbC+HZDw6AL722LjB6DEx6Ct4Qbg84yK8RfzDwm0sLQjm7vLXdx49Fhz2YjPryp/r73BS6GZXxHpWU8aY4lq+8dbFfp5Ae4yqVCfQiJzjTZlwmKro89aveuNvFuab0Dthn3nIBuY49npK32ykMdyW3LnR67N7sxoff4yw+MHIwjspVb4tLTom6kn7W/l1j53aHONnOzUx+/JudHzWYswitdDTGUZgB4w6vgVn24qLra21gzqEc2aVaA45woAxI9by1UIPYk5TTSwbq8Cg/bwFtAZLBT4QjRNlUWdRm2TTlyxTLI5CbmxZ1BGdEPuJhwKBk2WccntK000z7Vi6OuJx0zLJZEnTq2IXzP3sud00D5KA7RM6HnZ5Ukdo61ySFmax0vzLJRZGH8KZlgE7IyTuShlEaBj87jjc3p0oLbmBFIgHvwSTuQUwiSAhUwoYUvus4ybvwxjWXVO6vCT+yRn0O/0/p1UnQ2V7wEEtno3wGNTL3hQIiTAk+ZkBkPJS+awmveJ0+6k7jU4j5VBf0quDLClva/e54xr9VQZDR3amTKWPCb65gRJMkZmQr5R1wiaxcfdun+deOOOtwF
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(6916009)(316002)(4326008)(5660300002)(8676002)(8936002)(54906003)(70206006)(70586007)(6666004)(478600001)(40480700001)(2616005)(41300700001)(336012)(426003)(83380400001)(2906002)(40460700003)(47076005)(16526019)(36860700001)(82740400003)(36756003)(86362001)(26005)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 13:51:00.3969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f30cc6-295e-47e8-26a3-08dbe1f412bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667

luca.boccassi@gmail.com writes:

> From: Luca Boccassi <bluca@debian.org>
>
> LIBDIR in Debian and derivatives is not /usr/lib/, it's
> /usr/lib/<architecture triplet>/, which is different, and it's the
> wrong location where to install architecture-independent default
> configuration files, which should always go to /usr/lib/ instead.
> Installing these files to the per-architecture directory is not
> the right thing, hence revert the change.

So I looked into the Fedora package. Up until recently, the files were
in /etc, but it seems there was a deliberate change in the spec file
this September that moved them to /usr/lib or /usr/lib64.

Luca -- since you both sent the patch under reversion, and are Fedora
maintainer, could you please elaborate on what the logic was behind it?
It does look odd to me to put config files into an arch-dependent
directory, but I've been out of packaging for close to a decade at this
point.

Thanks!

> This reverts commit 946753a4459bd035132a27bb2eb87529c1979b90.
>
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 54539ce4..7d1819ce 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -17,7 +17,7 @@ endif
>  PREFIX?=/usr
>  SBINDIR?=/sbin
>  CONF_ETC_DIR?=/etc/iproute2
> -CONF_USR_DIR?=$(LIBDIR)/iproute2
> +CONF_USR_DIR?=$(PREFIX)/lib/iproute2
>  NETNS_RUN_DIR?=/var/run/netns
>  NETNS_ETC_DIR?=/etc/netns
>  DATADIR?=$(PREFIX)/share


