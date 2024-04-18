Return-Path: <netdev+bounces-89060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E47B8A951C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DA01C20E90
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD3158203;
	Thu, 18 Apr 2024 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SkOnhRXV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1553384A5E
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429382; cv=fail; b=pL1nYTzRPiMBTrtjORMeGXDMK3jKrE/yNrn6EUIfhcSbBclGs2Y9aVpkUDjP9NogyyHmgDWc1qD0Ozfo/+5ob6QGWUEaWJrQ6BgMHGMY1ZVGK9G+rtyE9IC+0mirnENN9E1Y25+OB44W8HgreEB7OxcQfgf+FHoQBr2lp0SeDrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429382; c=relaxed/simple;
	bh=DWDJxS1PXO2IE6QeSooFOf28W1S1B1mTJBc0daZWjO8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iZ1BAMdivS/dL/wxIbZ8VpyJaiNqShwcXqNLXn9SuJkIdyF//uDEY02X4D/NBkU9VL1sXW7eEjwum8ghT4Pv47QbBru78qcsQaFtYnfPHPHsBvDdRjoA0UJx+kQLmaQ0a1Q/akyFrz0PRrdZGWM/wP3P9CxxBmLf3yhR3O+WCXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SkOnhRXV; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dkn8XPQFUQbECSAaj5IzAeZhjsXTuVSwK+5GL/TFAw+xKRIF5QPcs+OUzYZfPSkfaQkXSrmLIhjp2DifHMSLBlTprpLLfiDu6T7i6FLv160OWfBv1vBHKzMnnvVgEaWbqRQNZi2Zh0WkQ3wDHI6V2xJ5WvbEMyUVcrLlsEMNpx3KEpdSmycr2mNJNDGSGpFcZd9pcSO80ifYnJecz1v4KU5r5GV5PAKig8ZoC1CofuFVTEN+rLaQTm1xts7iZn/gjRwNtzDN/3iAU6Y0QQoIDSAKU43fdOYzlKrgQ6fK8yRrQS2PkkH6dTMGhMbtWcmtWmYFUC+aS+Pt55fVHW+NQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7mfE3GKx2vn/DA+JdvwQ1h1DSX5Ts/ncrhQJGXuFr4=;
 b=G4OQjRy4RdiSyftDgF8RYgY/NeqmgJARHlqi9thspvKUItfCO4WivNYiHtlki3wYyJLYvH8IE6QhAk3A62+L5jmEkpm/PRKdwGLnyiLKt+lCGVZ0JnYhWjWoUWxKgmJp1ugdppncXI/88e4ARaSlkGj7ytkTtp1hz4zdC006x360Fijj88A5ky8r9O4zRPqE3o8XwhsFkKo3KmIeygPemBnzCvu01zpzuvysjp7rAqbPmoqcidFTu9Ww9oue3MkDG+kwNv1xist5oqD1CIo6DG8YXDuMdGFY+94tnagSFrRdVwWVSUTvoqY25teDHaiW2ZtBvO36rgZOim4wqOmRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7mfE3GKx2vn/DA+JdvwQ1h1DSX5Ts/ncrhQJGXuFr4=;
 b=SkOnhRXVQq4RVZM+IL4YvrYUzBroagzYWR33RaegBMpTGLm1plu6GWih+ISJ84wlRIMDExO6swkgOKqo1OrUD8knSrOLKOXf+n04GCbb0D8ybI6ohzo0ObbJ123PBHgqpzITYzdMBLZ1wX8X/seZ6Do0LYKyUsMLjB/IxsH2TjyAcqVF2F0OF6cIU0bfeAdW9/wdJBN0M20bbn3ywfClV6nSZJZR7hZ5KuqojkZ4pLxInjOMnsew0mqfBghij2qIzh0d4rbYmIM489CBJNK4lrOr+e+Uo+5Bn7cJ6alzKPHXWrEooKfrun1dO3FfWxM0fL/qAG8bCVxWQAZ8b40H2A==
Received: from SN6PR05CA0009.namprd05.prod.outlook.com (2603:10b6:805:de::22)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Thu, 18 Apr
 2024 08:36:18 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::e8) by SN6PR05CA0009.outlook.office365.com
 (2603:10b6:805:de::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.11 via Frontend
 Transport; Thu, 18 Apr 2024 08:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 08:36:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 01:36:06 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 01:35:55 -0700
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-6-jiri@resnulli.us>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <parav@nvidia.com>,
	<mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<shuah@kernel.org>, <petrm@nvidia.com>, <liuhangbin@gmail.com>,
	<vladimir.oltean@nxp.com>, <bpoirier@nvidia.com>, <idosch@nvidia.com>,
	<virtualization@lists.linux.dev>
Subject: Re: [patch net-next v3 5/6] selftests: forwarding: add
 wait_for_dev() helper
Date: Thu, 18 Apr 2024 10:33:13 +0200
In-Reply-To: <20240417164554.3651321-6-jiri@resnulli.us>
Message-ID: <8734rjcbkq.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 059723d9-5db4-412a-ed0e-08dc5f829dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HoNmVNCArhPS5VWA0pBXMx64as1aCd4Wx8okqVgWSJCXJAzWvLR6fhRnbhNv9dcZ3sBKKLrNgDOH6lWCetlG5U1tHP+c0DEaJ+qJN91lsQxebhwu8VKiWwCp3NoDFrID4660MFlY07ZZQXOH6xLWTb/li/e8wwTuKxx7exEX4GPJwzB8MLJFFEzQXTa6CNvo43yO5L8SR2jbTzAWtTZ5Bcp0/8+alkiGm2vxFZHwVc5UjMruhrS/DBSglyGvJTXlynki0fYlsjTV4gEMwSSWaji7otc+/M6OPDNkjEEIGWI7Cg23akUG6n0pcKJMa++4AvPaIL8jWkUGDhn01IRWf1xX9AnuWGK5cnybya2vNHWLTlkB0bAOgb0sefbVyikyqq/bUApFIWn+2NN3vztQcwZyRymnFJfhGm4+U7NNxM4yhoPHzh5yJx4bn5csHaxh5zA97FUQXt1ivZ4mZ57MOJC39R5xrD91b3hWu5PdNel9daVpU/oWsvQwwccLUsXvs7sBfjrU1IvVLvO/1/zX1cbNf+DRmtb+HlU7UEQj+UCNT/JqJY8DqYw1nnbbdoZfcqWnN/zXzzwdEgpy9YBemy98+r51DyEs0FxWFfYM/pJjHV89TI+1pU8cV55BhC8zhEd92stYEZHNQozXTzvPnAJkciJTuchm6Npg7ToucM7dUBhHzmuHW97OZ4A+l1fq6mylbPlIK2xN2DnIi4aUmtavCXEdkZTO001raIsq3kX1gXrDDUxXNcpb8X+XyUid
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(7416005)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 08:36:17.6831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059723d9-5db4-412a-ed0e-08dc5f829dd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266


Jiri Pirko <jiri@resnulli.us> writes:

> From: Jiri Pirko <jiri@nvidia.com>
>
> The existing setup_wait*() helper family check the status of the
> interface to be up. Introduce wait_for_dev() to wait for the netdevice
> to appear, for example after test script does manual device bind.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - reworked wait_for_dev() helper to use slowwait() helper
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index edaec12c0575..41c0b0ed430b 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -745,6 +745,19 @@ setup_wait()
>  	sleep $WAIT_TIME
>  }
>  
> +wait_for_dev()
> +{
> +        local dev=$1; shift
> +        local timeout=${1:-$WAIT_TIMEOUT}; shift
> +
> +        slowwait $timeout ip link show dev $dev up &> /dev/null

I agree with Benjamin's feedback that this should lose the up flag. It
looks as if it's waiting for the device to be up.

> +        if (( $? )); then
> +                check_err 1
> +                log_test wait_for_dev "Interface $dev did not appear."
> +                exit $EXIT_STATUS
> +        fi
> +}
> +
>  cmd_jq()
>  {
>  	local cmd=$1


