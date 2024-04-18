Return-Path: <netdev+bounces-89066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6462B8A9549
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8633E1C20A87
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606BC15887A;
	Thu, 18 Apr 2024 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZyY/HQBn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560182D7A
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430071; cv=fail; b=IJTVZDGxfFbw5QzpIaGfzrNGcgqkdbJ+PhDdiaXejs5/earWlTuQ89TeIBAxjq/U8TqU2qsCu9QAR1SkG53Z7+CRloIdMJgAzQdQ1bXyluXgMD4pMvgKjck0UZftkgtuMJLj7ROSXGtlx82+GBkfRipHSQNC2cE/X74jwUiLqtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430071; c=relaxed/simple;
	bh=E33Y+3obEAe3uvyYzHVKNAtylg5kvNtIs4igR3mVoOQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=EzWIBZLGpdDcZNxoOVYA0E8c3bCyuuDZ4vCzypzNtCBXHOZyOvx21OnmzpX+EBEYXOa4zUdkTPp4N+ou1/OKWt9WVq5KAFj+d39AsnWzXUo39a7gyxyT+MFRxvMsjonJ6xE8Tek55fRXgq6HLgB/1DjgW0PGPDGWVTYxVSC6HDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZyY/HQBn; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGpf7JavL6Vd6++mR+IF5z26JUbs3gCy1P+6G0HG4h4Qe3A9wgOHV8/dKBt+N4Hc2lcRtV7U3DDF6QYPlHhvZHuDZiakSNN6sW8WvUvBwznvj5VYff3V86UqPj0Z7qWODM/k5p6GJbRjRi7f+A4slL9u7b10LYw3kfm18xO05YuPX/4nBB9gCFRqNjt1d/xRN+4fCFc5DdetPvT/HWf34ALOBKpVYGne4bp4thP9w8w6y+UpJnSovQF4rtqhPRLw+CCnBM++SiWXFqW+3TtyDUdjtctWyXJF6gZpIzopfG6VVbQWMR2OXdBPT6MEzxRuakKpkZ/+mD/0GyDSix4Sjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiV88JAagAuBbAK7eHUmu9OsqSe8e1gY/ztdlMEaaG4=;
 b=n+IXAZGbiWGJj+7RK6iEPfV0ECwcDRNIXnIPrKPkItYj/cSL1TFamHZ5GvC37d+c25plteYsKYRQSq3mmRWldgXucV0CIM9r1uXfyemjsBhgtmcNNDlKfRgjhVHpOQBWUTve84GSn4cVP4kovFjSIIXSADy88JHEBBt+h8j1NP+KNt425vf/ezRQ5OF+xXihaJXI//P2utPXbxZZZ9SrhVq45+smt5NEboBO8K4B8EETyjP/dWqAe0LjzvoowjlOtchC3rPFCqG+r0KwZjlbU1OJpIz0dAH//C2IJs4JjyHrE3ZSUpSiIQB5SbanLy6qH9w8l2byWZFqcg6W5B5pwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiV88JAagAuBbAK7eHUmu9OsqSe8e1gY/ztdlMEaaG4=;
 b=ZyY/HQBnGvu9l68igXWPp2Rfoh8K7SkI/vz16lCtMG3zOiio7g1S3OQskV/le4/pGR8xSqj+wtImLvrcy/ASfiL4f/CKEDzviQAGx6Pp3fyT0YDTDvZYxgKEPykNoU/oFpb1j0QvgfBnvl+RLovK1wolRFfBb34S/n5vd623I1mzRrOQ0ba6rh8ZwfZP21J+D3ASeFWuUxU78VwIuD30nLFrwB2O833gN1JI+uTQoXd+lW3+b2PWsD/3PKyPCTJhUCYQihS1e8CzgfuvF3/SgPWuijxvmIA4GzgxG0Uh7loBN8/zmr8l95++qxojkgrSCskmd+fz55QeqET4QeOvaw==
Received: from CH0PR03CA0429.namprd03.prod.outlook.com (2603:10b6:610:10e::13)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 08:47:46 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::4) by CH0PR03CA0429.outlook.office365.com
 (2603:10b6:610:10e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Thu, 18 Apr 2024 08:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 08:47:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 01:47:26 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 01:47:16 -0700
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-7-jiri@resnulli.us>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <parav@nvidia.com>,
	<mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<shuah@kernel.org>, <petrm@nvidia.com>, <liuhangbin@gmail.com>,
	<vladimir.oltean@nxp.com>, <bpoirier@nvidia.com>, <idosch@nvidia.com>,
	<virtualization@lists.linux.dev>
Subject: Re: [patch net-next v3 6/6] selftests: virtio_net: add initial tests
Date: Thu, 18 Apr 2024 10:39:49 +0200
In-Reply-To: <20240417164554.3651321-7-jiri@resnulli.us>
Message-ID: <87ttjzawhd.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 413bd440-1700-4458-aa64-08dc5f843802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rrGZvCdoEyU0lM3Hwr0SPZ67JfxOpMGC6Bd3eUahyHmO/PDNCvusH5BbzRarQk9cqA9C0W8H/uqA8UdPCX7CB4X97zFPSCB/M9bhlHuh4H7pSAHIFoKPxVJBDDGiap9FY9Mi8l8VczuqM9dlXftcPg1AHwEDPmbolMM9VaOHLTbcoAHYW7vSz8WIumVqKw9xfL3hnlpQOt6dGV3TAtJgrudOnsh1Di6isQCnYycBgcoVdXnj056Kk7HbXyuOcL5ckGd6HmPzfT/kWb2baONTVj+aibw6Aj1J0dXOr4VfR/nUk0rYo1UWKof3jKxnZarn7f1NPGizHT4SAibILOgb5ajSX8fZZ1v8YhLVCuaddQNcK51TuIIs515y303zY99XTmC9f3Z12I1DjW5PbrDxbUHqCMMUTNPFFfycmXrXE7HXv9a2vWvMgKryQjPtBoytE7EQEA8stydQS5ICRSHqp1ukKbFLOnYdgthprnS7wKcRamk0WGHpk5Fs5neT9JY/bKnGmZpZWLIRu6rx4DvjWjsT5WMtGUMTmLZZuwqhSfOFZTf+CBVGPGAtvKq7ctttjEcrxbVglAzd/qI+ETImYP7nX34xqsRKgUeQCHZg5sVzyqVyE4C1CVYmBn3ewD/axjXU/KHDm3RNnrzsQfFCA1LSf1trByuGasiAYRBT2XvqkWDckyW13pgOQScK4uAf7cF5hGneq7cTE3Hh7u/thcRbmsr5YFHG2F/tML0/p4z5YC7IdNnXNsqli6vDwnWG
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 08:47:45.8225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 413bd440-1700-4458-aa64-08dc5f843802
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708


Jiri Pirko <jiri@resnulli.us> writes:

> From: Jiri Pirko <jiri@nvidia.com>
>
> Introduce initial tests for virtio_net driver. Focus on feature testing
> leveraging previously introduced debugfs feature filtering
> infrastructure. Add very basic ping and F_MAC feature tests.
>
> To run this, do:
> $ make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests
>
> Run it on a system with 2 virtio_net devices connected back-to-back
> on the hypervisor.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

> +h2_destroy()
> +{
> +	simple_if_fini $h2 $H2_IPV4/24 $H2_IPV6/64
> +}
> +
> +initial_ping_test()
> +{
> +	cleanup

All these cleanup() calls will end up possibly triggering
PAUSE_ON_CLEANUP. Not sure that's intended.

> +	setup_prepare
> +	ping_test $h1 $H2_IPV4 " simple"
> +}

Other than this nit, LGTM.

Reviewed-by: Petr Machata <petrm@nvidia.com>

