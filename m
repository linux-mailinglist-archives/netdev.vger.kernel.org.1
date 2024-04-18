Return-Path: <netdev+bounces-89058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F708A9506
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613DF281403
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134C2156C5D;
	Thu, 18 Apr 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jlK6E7Kt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB8156998
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429118; cv=fail; b=gikmeunnWlV29zESwVn0PmBFg481OChrpEEs+/pMC5j+lrnWG4NxQVO0NvkPvGnPFRBWE/9iJ6Be2z81YQZPHICwwLd9bdcI/Fd/Hbxf53cudcb5GSH4CjceT1fwB5h6WMUhZDXZYVr/aiktKaVGaxeEWEikVBgOMuAIG1qOPbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429118; c=relaxed/simple;
	bh=x5JpKrUenJ4eRv92b3jJmV7s3cIdZd5sSmULQlfZbpE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HxNy8ECH+I58pxPK+5tnQXJQOh58XIrVQnCD2sMkcf8s9E0xxCC9EL/VuucRYngOegvNMheKzylev0xz5Uu8kzqsg+pLp4Bf7PQ2ngzM1cJCrgHVnUCyUQZoYLmjGwxvBS58b3adj7cPLDe3Mh3bSOxpUn5Jff17hqgH3sdVblk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jlK6E7Kt; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaAy6iOvClOfMDKmnd7X0D8MtwglE+DRFG6pXP6L3QtznW+j7ckVZbBvcmrJi5i+LVNo3BtndGXqn8Zv2EkMBcV2+8EoUTVA5Y8UlsE4rdZgb38GEl3BIia+ySs2tTKzph+YF2cryTABt9uFb7HPqkRhqfXDR0nEF4BBbPWkEXSo+wPPskPiuddcJiYS7rFfdJwWgVg/S/JMdq28yVzNX14emy5QlaJxEfQGoNyFkidqmyQkEDRSIx3dooxRPijTTToVoa4h7buFUSuAdqzeCq/W85et+DDSAUKayKYJAh0QK64IDps66VS3IczVuZGu71UakxlSfJs/OI/3fjqBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5JpKrUenJ4eRv92b3jJmV7s3cIdZd5sSmULQlfZbpE=;
 b=BwkIMIAr8Zwok/WPQW7ncjyTB0e9UHjntIKhzCp19b7xjj7yQ2v8GVZt9rojEEkgdQKV5trcr9K1AMELXKpJqwniuZ1VFDj5raodJCl5aFNZQ9vkZWFY+i5H70hWzBItg+vYT41MqtcrA/HysTYOshs3KmSSYNC8TktmX98OOo9B2C9UHmJ/+GNTrKRYZeIJqATqM8dxJ222Mk14B6CO0knBsoFgBd3W1S9fabTeZlYt6CmtrqMqUjh6/wP7vSDOIlCtr7sliGdQ4I3iQ3vp9Vv01XpKn8LKkyTk0kpgf/l8M1hksiqGMUImlOTeoifPkcsy87CzTDiECTvzX4JY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5JpKrUenJ4eRv92b3jJmV7s3cIdZd5sSmULQlfZbpE=;
 b=jlK6E7KtaoXLsIZp6i4BozPXnhPThQ2OaCYiPO+JQYFkS4eYDu95tSb8mOaS5KICO+NlsTcKPegcWaWnVvmcbufSxCpsdj9pmUAj7uUNYvSw5sqqDfcQ9SeEnXTDlTFzX1rnjtXFbsQ3l+gRH97bnVpfMRmIwQ7e9YDV1DEntz3tD8ffpWK6/e2UBpLVvjdTdpj2ot1c5K2D+rL1abkh01IomItxap0ypdFfcCp4bX7F3ANIq6Z7JKgUaRPSCe8nhk/5VPNusDnynAxs9bwCV2BmU1yqujNYTpmBDPl7k2B250NqKSbJx9jTUApCIx7KVFZdfeSWbNnTm7UwU5Z8uA==
Received: from SJ0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:2c0::24)
 by MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 08:31:54 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::c9) by SJ0PR13CA0019.outlook.office365.com
 (2603:10b6:a03:2c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.12 via Frontend
 Transport; Thu, 18 Apr 2024 08:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 08:31:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 01:31:37 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 01:31:25 -0700
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-5-jiri@resnulli.us>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <parav@nvidia.com>,
	<mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<shuah@kernel.org>, <petrm@nvidia.com>, <liuhangbin@gmail.com>,
	<vladimir.oltean@nxp.com>, <bpoirier@nvidia.com>, <idosch@nvidia.com>,
	<virtualization@lists.linux.dev>
Subject: Re: [patch net-next v3 4/6] selftests: forwarding: add
 check_driver() helper
Date: Thu, 18 Apr 2024 10:31:07 +0200
In-Reply-To: <20240417164554.3651321-5-jiri@resnulli.us>
Message-ID: <877cgvcbs9.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d049f6-10d5-4889-1602-08dc5f820075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v1qJBsGj6IbNRt0X2KsnVnm6m0UNwDfTlH9r2l5NjWL7uMgaJLr/lSAsqUYTa63AucSh2M0ane24CZCfdc2LAz098n2I5EHYkIiMLenIluRWkddV5AlbGJwju6DebBP8aZBDwvSkmoshgx79BPfkSG8FtnRTqDaMzyHaiwADBqW2r8hoKejAsquoRaa5ughYGRvOcfrjYIGhhZvTQnopH++kKSusV0+BigIEx7FQ6f/orTr4+moBJbLQMZYPds7gR0njUNfl5bFT+nxzjY3GgVRKwAHe+sQNAPZgbGhGBOL4QH/sXxKD8KQdeUCdIyoEveDnEWJL9+ciHxUX1I1IzGRxvdQq/PEtIICZEIeZ/Rf+rDT0rtGT5TqSdcKg/S9mcE+s77rCVGboXTJ5mOxdQMiatMyxBHh7H/Fz3AwUfOnSoPkkgkMWANqQjZW2FAT4MvuS0DuHezV7sxqihwH64pvOcRlMmvR6iPxlcZd1vnw6mEHTyNPHvoGe+9VUujl2UCLLs9ChAmDesBPTdGOsc5l5U87Xjrp8sc8grtJbsBpXiz1wxAQ/0db6aSNRfhaJ1omNruCt/+3VjfTwb+uj0X0R/tZQlhbG3AZo+7oJc2nz4/xHRNxKF+tQFcQov4NmQK9R1AviTRzcBymhq6IUG7IKwEiMYODvDC6RMwhARlMHGHtzb5XEPopJvuDBQzGRNKgVW3mhbLjkuOZSX+BJsGkHPqC1eDPvP4hF4moVausBB2dSY6ECnz+deHNd9lR4
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 08:31:53.6422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d049f6-10d5-4889-1602-08dc5f820075
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754


Jiri Pirko <jiri@resnulli.us> writes:

> From: Jiri Pirko <jiri@nvidia.com>
>
> Add a helper to be used to check if the netdevice is backed by specified
> driver.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

