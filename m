Return-Path: <netdev+bounces-79126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D9877E84
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 11:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C4A4B20527
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 10:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AC0381DA;
	Mon, 11 Mar 2024 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IJb9K/aC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF31364BE
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154788; cv=fail; b=fs9di99GBiRowPPVD2F3AP8mw/4ufMZtkXdTmbpD2u2qKG0KgyIecwPbiraXHLGt8hz6e8IWHzT98tGw37DEtCck1129qHaOaxww9qqJ7YkGr7ndw04oFLgOPwBTH/w7hCkSf4s8lLOqoo8gGwr6aRghRhR47s9LV14ZyUVH+h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154788; c=relaxed/simple;
	bh=vcrhkpUaZh0egNcTxHF33yQkaEJfn7cuckD7lN1fwN4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AStMtOnXGLcgBWIUWDkjgIPFlLCXGcwRcyR31F6gjyRFhJUeef/6JJqnBJ4A4MtznFbkaZqphJpbSH2dCzCBazsSQ3PRFjgKD5GCKizVaidaArsSSDm+cl2jnVp+Fh/+B5LaDUS2+C0LpvWBS0cLUm1kx9rDvunZu9+uneCX9hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IJb9K/aC; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1CnBTo6ueoFLpWDUJTMjD42RgazvBFkm4PNyofjkuW4Xz6+UHlptZlxYm8yzZvxV/FTHH0rE+In8i1SNwt2rSv577X41AnT7rA+vRLJ79zxPNAQV+raba3vmaf/fDXmnjw+tgFtKy5gEkWPX22RSMdaSMzJ1QupzZEJnscL63J136oJyuDWnjDcYHkvaw583sUlxr+TuOTbhvTFXWSpv00IYjPrT3VmAsPt619Up9AL/mh9rKOMWXcfD0LiaU+eZ4B7uMLy1XJffGzGnGj7YPf0xrLhZRabiIiosW5cDege/zohLO0x228Xv/oHjf5riq0J5j5/X9PezpSGE5EOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vdzdTa4KO5pD8a3eSSdbPbKwTcyu+XPa/u0hI10JN4=;
 b=HX/4FTVJDW7TTq5PkmfB9lp5vv2sS7rDJkvdYlxfVtLqRVVK90MgHPVcIuuN+u0ovYafG4lDn1PPOa3Zhkitfnuyv9b3U5Q3t+NTDAfnSJJYOl20O6YJhZ3Om2wAblJC14xXonYFSUL+Lp+0dtwYaC3xAbe2fl5bFjgguIeNZPgFJDv2DJB0dfoWbxej4miLxVNgLtNe/yCYjRNDSgYPGZteyJewcIHCpoUVtDfMF3NCjYyKAa+y98kPmArRJBFC1ohTy6o1myX/AMVlsuTvbp3F+6R7aBtIWSvkg059/NBGXbIukCWGh8hTw9em1eyLaaCkDUuIlnTVSD4k1Po7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vdzdTa4KO5pD8a3eSSdbPbKwTcyu+XPa/u0hI10JN4=;
 b=IJb9K/aC/xvwwgb9ugbTsy2wyzT/8t+oR3Bdd6K7LFDVXyZHHLAWoI8iPkRQl0H1HAZqKbunGXhUvNdYRr2eJ0Xzk82RNzmeCokhmEWYDNx71MlHYxujEqgk95t9pVG9+8nm/G12tko8yptiOLW+7uOM5QgCYCuDSP7juv/VyGTDtf6B4AGEdFOkOaJKw/OdyNYQJgG/VZxKK9scuXYhRcrkVnppCKQAnaRbAR1dxZ2XDRVKxrfJ42h1moFR9ekoXRW5GEh7hf3bDTO46I4CQ0eZx3ZTHnyi7N69ocFFcG7PCiPSCT/h/t2DTpDZ0fFtEFAD2k5YEAUAyk7yboRONw==
Received: from DS7PR03CA0126.namprd03.prod.outlook.com (2603:10b6:5:3b4::11)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 10:59:42 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::ad) by DS7PR03CA0126.outlook.office365.com
 (2603:10b6:5:3b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 10:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 10:59:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 03:59:34 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 11 Mar
 2024 03:59:28 -0700
References: <cover.1709901020.git.petrm@nvidia.com>
 <2a424c54062a5f1efd13b9ec5b2b0e29c6af2574.1709901020.git.petrm@nvidia.com>
 <20240308090333.4d59fc49@kernel.org> <87sf10l5fy.fsf@nvidia.com>
 <20240308194853.7619538a@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 11/11] selftests: forwarding: Add a test for NH
 group stats
Date: Mon, 11 Mar 2024 11:59:09 +0100
In-Reply-To: <20240308194853.7619538a@kernel.org>
Message-ID: <87frwxkp9v.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b33cef5-5777-465d-dc76-08dc41ba5ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MplMWsKaZvmiJNYBIJSOB9OAXxMc0Qp1IeSt/+6ivURWoSROLfQ5XkR1kO/7+t3RpH6YNy8IHylo5yHuhPgtSEZJMnJyuT5F81iSr+XkEVZ625toMN+CG3n4MDMgSgVZV9JzTOcDHsTpov/CteYher7F4i7oBSLA4c6d3MLBKMoz8IAGVCL07O/yJuvOCPlct1QX6YegVaf5eHX5IrrjDH/6J8mOI7iUhKgKzFcDzg+iO95sSzREsEfWO66iQkrqSP+Y82hKP/ZrUIdiMX/3uNYOUalDiHxYXINqGeh21dPoytSP1omyxvGYXNtawM6+mB6q14D1/iXYOxlM+flW35ajbr3/sBgdEQUEKnxD6jBENTQTAiEa7wqTM/sZDOYbVt47ItNjtczY0CXes/5bV29+xvgRf4NH4CuwGEj1c/T1VUDAOdrQfQxw9UAz6iASk87QqnLe8rhRNZODcZp3PbJ3Omx8VguLA1uw9Aq/72NjBedNtJsVPaCocK/y3IkZxUUIKQZKr/L/uHmohHLIl8KKcI583YiWyEimhH0eSfmO3/jJuhhETHUnaE3dCAkYLjGnEoX0JyjYDS1ap2axw5LStCi+WXzdyr5DDWfXlk/7dN3MMCZvShaLvEOjcauj95s3DIZ+sqXYXC9Jc6B7TirOVtpIYPmxO4EWSgZi7WhV/evxyXpEWTwATcyH0MAdMhbaF+WhuoKOgyR8iVcvUxykbfuHpLGiYpOUoH9IzzuebzdFYlRO+FZ4pB3Scpnx
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 10:59:42.1575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b33cef5-5777-465d-dc76-08dc41ba5ac9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952


Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 8 Mar 2024 23:31:57 +0100 Petr Machata wrote:
>> > Are the iproute2 patches still on their way?
>> > I can't find them and the test is getting skipped.  
>> 
>> I only just sent it. The code is here FWIW:
>> 
>>     https://github.com/pmachata/iproute2/commits/nh_stats
>
> I tried but I'll need to also sync the kernel headers.
> Maybe I'll wait until David applies :S
> Will the test still skip, tho, when running on veth?

It should run the SW parts and skip the HW ones.

