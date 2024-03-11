Return-Path: <netdev+bounces-79240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 607BA878620
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 18:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6853282E3B
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB754AEE7;
	Mon, 11 Mar 2024 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fl1bxkWO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1505482CF
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177219; cv=fail; b=mN5P/HHl/W2kHEkSfRar/PpdWiHQFGCLtutZDvlHczFAPp45FiECZvzcNr9BIbncEVcNYP/OzHIbpRNfCVYSui/pTPFJncxr6uaQZbzel0LqsRg8niZBoM0B0Xwufhca1/pxAaJyZYJtNtRmLBhO+59z11gC0QythRSZ8BvYZM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177219; c=relaxed/simple;
	bh=ngV+idU5c67qp0ApuLTrq0XNkStSmoI+T8zDW9xbLy4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=F5QQmSz1b4XaW2Mh6DW7MJ8KAF9obf8EcuojGFD5EzZb3eDLREFtX73wGeLsfpPcYJjjuiA2VXZLx5tDRiLWb/G4UvJ/aBUw1WC1hq4KTOEUROAMPiGhWdmRDkBha2NXSyHkc1G+s3dxnlTSoP+v2du80ReWuZuoANSZcqZ5QLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fl1bxkWO; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhs1d8cmpnWEXqiZSoODh2B/o+U+AyS9hX2Ikw9EFNNNPQzuWYC12yxIHp320VM5mzsoLtmyCJFWaI9KLEQDRUxeAoRWqrL8uSPdq9vZ1uePtyfSIHCEarOzOMUkg+bdMXtXAqseY3ddgZENnz6/QVUmB+oQfQF7KwfmUcdI9FTSTyM1WE7T6RwB3wxkmoW9uHAutAWmTdcNqSFkgTQyCmIANokgU7o5mkiFN6rZdjiNOFcbXAnEp4av55mh7kmi23v1EtW6xOA5/XJuqnh5QFRZzfS6mEOON7btY6ePFc+fXl9C2eLcogYzw2A8/MFoi/y071sBDosmf9ZMj4IOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuMqjpwYCUK2YsaoZUzEUsoOVjGIXg9xaULUac5lOpI=;
 b=XYKTTBM+ibi+asumS4eHjUiloXoZhthXM50Bg3yc5Bj8AZIcW6YQtfGs4cELA58Uh+HTozZji4vIfmiYZfQsBDWdtEhLjB1pf9Ki4dIoGUwC7cuhu3VtZeOC9Hcs5f727pV6wX3RmtyzHw7npbGqHiljTeraIFke+Hq1IwzjsI6D3GcvqwaZ3cB/lzFBU7Ch+qt9z2UwzUoBYX+P6XvnyaYFZVVMYXNywQwdrNzusVLOzMQ2PtHrOBOolT9EZh+LdVFZLDPPWveeLGQBqgMaVW4XFIkJoFHM9rG3YiBWCaAd3l/yyEltcrQ5sIUaHqfM9jpdupEoauGf6OGaAsSMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuMqjpwYCUK2YsaoZUzEUsoOVjGIXg9xaULUac5lOpI=;
 b=fl1bxkWOYBnc5fWI+tZ0wsgdCiiwTOq4WSVyFLlEpl8DCFnGBLoPnCu7KitHkmL+C7Cia3YVeQn4TiwpY06A2+kJKIwGjv5pJQFLe/4UtFJNoNRKZIOdAaeC3pL7C2Fl6vHqQ2YcVz8pIwpYTru/B/5Sh4qhFoFpDiRPbC3+YcZC/RumzJfAfHfdjHFK28NHCmUWAUoXL/mR+ZRlZxUMdA/hKGNC0Y/ngEtPldltinPwfTZSoGjULPVYmTPOocMktZ0O57KP8/GxetG3nWHXtXEpHWiQUFgVgtu/fZmOz9UhqXo3P/WnayZfEk/kQiKxcJVNt/9Slf7z0ASkSxHqCQ==
Received: from BL1PR13CA0111.namprd13.prod.outlook.com (2603:10b6:208:2b9::26)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Mon, 11 Mar
 2024 17:13:34 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::e7) by BL1PR13CA0111.outlook.office365.com
 (2603:10b6:208:2b9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16 via Frontend
 Transport; Mon, 11 Mar 2024 17:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:13:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 10:13:15 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 11 Mar
 2024 10:13:10 -0700
References: <cover.1709901020.git.petrm@nvidia.com>
 <2a424c54062a5f1efd13b9ec5b2b0e29c6af2574.1709901020.git.petrm@nvidia.com>
 <20240308090333.4d59fc49@kernel.org> <87sf10l5fy.fsf@nvidia.com>
 <20240308194853.7619538a@kernel.org> <87frwxkp9v.fsf@nvidia.com>
 <87bk7lkp5n.fsf@nvidia.com> <20240311085912.5a149182@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 11/11] selftests: forwarding: Add a test for NH
 group stats
Date: Mon, 11 Mar 2024 17:30:54 +0100
In-Reply-To: <20240311085912.5a149182@kernel.org>
Message-ID: <8734swlmjh.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ba5bb0-3b59-43b5-5378-08dc41ee9567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XoPQQ2FA2J2zH4aTIHxYT1gUrl1ZMcpeeVBBfWN0yC3E9rPSY86+NzfL93xh/ISG8SgEH6it0YgQFxz0cqXWG6aF0hJIEp3chMP50B++rP6Og+SobAyIwD5T4fcV1BpzkOi95ueSt5wfeTeRgFtPSKsnYOJriXJEgpZR++p80WLFrmoSH5QDGbVYKA7ZjHgMSJI/F1obDQ4YmGOBOu2JqG0fduSdwEBF+w+Cfe2EKZoR8+3mZxC74k7EaPQLKi915al7FU0CmnJchlNI9RfH3X4nBqqgKv+2Vzz+PivmBKe0DPLlqHkmMyFDbTxk5bsBloMKb/28o7JPMuZs4mzO8f+wDRJkgCQTJ3QiCWe6B4g0mJCDye045j9xFCI3PYHYrct1i1Eu02gvjS3GoyXDHyxfSQHDKajKZJ3mJDbQ3KPomhPZ0L2zoyrzyqyTDNeSS0Kq0ACUXOB4UzejF/GqCRzdALbvKNVF4gHmuW7MQKeTrgDm7087526GBlFatfDZzXLdEW+X9pmmG1miDcHQIDhRawJiRewtALwigulSXp/qallc7Tcmy1Hg5OuOdeLYkKjYFjIW13bsxMuJjF4YwFWpF2LAZVFhUK7qnflDG0KEVR/mLPCKN7mNELnpSOKwIYeWttOEbvxnWfaFHQ6cBg8cQTlKTsXTcwsMdg+1YJS4Sn1l1msj8WjBziWNpvsa7TjNQopKSDaIWJ2bbBGgwROwtEeYeJZUzLpt+0tsDGyQKpydhi77VlJ60qYwuUNX
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:13:34.2491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ba5bb0-3b59-43b5-5378-08dc41ee9567
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123


Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 11 Mar 2024 12:00:59 +0100 Petr Machata wrote:
>> > It should run the SW parts and skip the HW ones.  
>> 
>> In fact why don't I paste the run I still have in the terminal from last
>> week:
>> 
>> [root@virtme-ng forwarding]# TESTS=" nh_stats_test_v4 nh_stats_test_v6 " ./router_mpath_nh_res.sh
>> TEST: NH stats test IPv4                                            [ OK ]
>> TEST: HW stats not offloaded on veth topology                       [SKIP]
>> TEST: NH stats test IPv6                                            [ OK ]
>> TEST: HW stats not offloaded on veth topology                       [SKIP]
>
> SKIP beats PASS so the result for the entire test (according to our
> local result parser) will be SKIP. Can we switch to XFAIL?

Sure.

But I don't think SKIP should trump PASS. IMHO SKIP is the weakest
status, soon as you have one PASS, that's what the overall outcome
should be. I guess the logic behind it was that it's useful to see the
tests that skip?

