Return-Path: <netdev+bounces-76176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E7186CAEA
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 15:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00C56B20EEE
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3E27D060;
	Thu, 29 Feb 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="buq/0WvG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD315D2
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215466; cv=fail; b=IpXGKnc2f2M5AqcpjZFNxNnpdayFmJoYMDyF/e+xkJEYbwynbyHehD2Ydk6RXDZXHENQJggSWEan7L86WS3dc/UQ+QdrOsKTeUJCCu0Ex3bWazqule+XtioMqnfie28pCrqy41fJqGhS0ytWiUlvygs90kMW7bDKKMHdECZz+i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215466; c=relaxed/simple;
	bh=EWtoJwUxB1ltA1hBNd6WYeS93H4P4ue2SeTvJ1Zjwsc=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jfUeezHP1Uh3Oc/6D7bXTaKpI1Oje7wlNWklelj0DU8ldGCePcHC7KfPBSP9T/eRru60NQ4RzfvtrsQwCLSksn6PxDJcIkd4Yt8g9R5HcqxKKQr1Xr6mncLQv/c5tzPwyCRtJvdb99c/ooNoiCyDe2FRGLRvLXViFXNLyOHb8lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=buq/0WvG; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTyJnh5KukLumCw9NtDkAhnUbPV+lOaDpRJ2pJx02+9dEk1vC5p9xNVe5grRXWAws6hXyQzo3t4E3b7LaqK3Hxkn4NxphlYJ37Dq+bk2IxvMfy3PzQ57RAR5yNx8ejotq0oQv8PgkyPe/sD+Ct4pmYSdAKTmtPBhtH6TwjVE4uymtBu2TjVCzYMDLAxnvqMFwxt8NqswY4UHSWJI7vnhwxgXIU9ququ8/eeVTRUjKgWX0NGormbfzvdTowK9j58U3Mb14EdAewxlFIFnoaXw79G93d1d5dNYd95qo4QHWCLgGUQSLq5vvMdS4L3Ti1FAAhxX6zI/c9ewuTt2NolaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWtoJwUxB1ltA1hBNd6WYeS93H4P4ue2SeTvJ1Zjwsc=;
 b=HOtclcOK5A91jq87wipR73xkNRh23Xn8FCBS3oDQRCCCoM7Es2SxuMvf2nr9zKM/MCzEWbfZ+4ejIRccdbIHzBuTZa2Vyo5OdLWqEnGPbbaql1IsfG2NR9838mvEqr/YYQDJKhz7CBwFIsUG6nPGVR9DfUZjLdEIPLbKvLeyO4i8FatKV/luMMUdCCgOt9uKEMX7aIrbLFYfvQmCi/43jwkcXDEFhwlz331wEb+7QYd5U/kjpXk1UUH3JSImcFSMl4Nbpa7EYp4mVjUraupQdzs9JgMw1DZoESwJ2my8ZnSbBlcdTtQxKD7nW+gnF3tPPGqNgZ0nN989o/+IwXW/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWtoJwUxB1ltA1hBNd6WYeS93H4P4ue2SeTvJ1Zjwsc=;
 b=buq/0WvGe9WOamLPwHatQEcsTf4wWkM+rLgTqZOCPIxWT+T2jywdThertMQ53SzgFJZ9rIOqvSX0nPzWnYxpPW/sSdNJWl0DjSE0+cFuv1teuMzKgh63aOU4iVnU0c+SZsM0slkt5epRMErdGqdnuiW8jgV5gs1hrNAvwplO/NlVNVatslae4KIJxD/hFWNv0PryOrftPaBgAM9munan1X3hTozzU4QtgrbQa9FZzVP42DHsiamFD1j1Ha5gtEQLPfRA3vmoS5XbkSbFoa7hRx4voBlszwi/YBHzPvUEuxZCmjkwZIqxZDSVxPaX6f1ogI+uL3jRUyQV7HkMii+aDg==
Received: from DS7PR07CA0002.namprd07.prod.outlook.com (2603:10b6:5:3af::8) by
 DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.41; Thu, 29 Feb 2024 14:04:19 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:3af:cafe::8f) by DS7PR07CA0002.outlook.office365.com
 (2603:10b6:5:3af::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Thu, 29 Feb 2024 14:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 14:04:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 29 Feb
 2024 06:03:58 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 29 Feb
 2024 06:03:53 -0800
References: <cover.1709057158.git.petrm@nvidia.com>
 <4a99466c61566e562db940ea62905199757e7ef4.1709057158.git.petrm@nvidia.com>
 <20240227193458.38a79c56@kernel.org> <877cioq1c6.fsf@nvidia.com>
 <20240228064859.423a7c5e@kernel.org> <20240228071601.7117217c@kernel.org>
 <87le74o9pu.fsf@nvidia.com> <20240228084220.14d2cf55@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 2/7] net: nexthop: Add NHA_OP_FLAGS
Date: Thu, 29 Feb 2024 15:03:45 +0100
In-Reply-To: <20240228084220.14d2cf55@kernel.org>
Message-ID: <874jdrnz95.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DM6PR12MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c2195b-e1d7-4ecd-e037-08dc392f529f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7N4R+vznnBNGKJb8yT/MGBLeP+JL0mKVASnRu5ie7OneHIWCd8g5pXUsJcrWOTiKp5M8zEmrl9Ka+zVqyLyfnPtCU2yv9lFo2KjcmqyeHuDyh+pZtXc0laT7y6i9+buD4dK1ZJrf5BafJxyUyu9Rv5CAU9WGBO78U0kzv/Oi7n4zRzPYbdcICrLXb7ophYk204MXres6exhZP3nZYYUPNbaO5Re7R+38S1q35Gy0fOjx7z4nhwyFR69GKDGyHzR2Z91nNj3kBhHH5z21zrwXP++3fJ6hKl3ShbNZvGypx7AiMZrMB7e8sJ8uxmfaM0vXBvu1G6CfOtIzcD6ebMTD/eTOtoGefwNVa04RpZ/8ZSA6e631Pi4hvwwMASgG7SaQ/NmIqeGQBZP46q4kIkRcGDGayTNWHWtPtSNA8pcYYW8pO/60wwg4bjJ2Czhef9hccAPZQFT84Sdp2j+n2dQcrFKYy8qjmStyIvAiH7YkBgrbyWilTfHi3Q3AjbmRqNtk4xnWsLMbZ5LGe6ppO7PVkhpjaS4VnCXcrRnqROcRgyIkqHiUIkEnvjvRkFHtV2pNW9MBt9Ih/wa2yq6EHXvQLW7mm+IO1S21wLxDsKtTo9C6ifYtcETFLGi9nywtfcMDTnyXCd2yXrebDzbRX4t4ehzXoBxFvJjOPq9AWVOVMhSoIIlFRZvWkfaU++9qEc/QseQO7zsCV22DKiCcELMON3DdCWfhRBDGbdAHppVWMuUkwJmOhFT2ipLioZLoeN83
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 14:04:19.0035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c2195b-e1d7-4ecd-e037-08dc392f529f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387


Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 28 Feb 2024 16:58:24 +0100 Petr Machata wrote:
>> Um, so as I said, I mostly figured let's use bitfield because of the
>> validation. I really like how it's all part of the policy and there's no
>> explicit checking code. So I'd keep it as it is.
>
> FWIW the same validation is possible for bare unsigned types with
> NLA_POLICY_MASK().

Awesome, that's what I need.

