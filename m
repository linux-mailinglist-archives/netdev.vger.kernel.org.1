Return-Path: <netdev+bounces-79124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9BD877E7E
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 11:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70ED11C21656
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FBD383A1;
	Mon, 11 Mar 2024 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pR2tVFkE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76634CD7
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154707; cv=fail; b=EeKeyVlZvw96oZoTa2gtSAMynqOKETliBCrTUhQZSNgYGkgN4CrvxKxc7K2fRYUUDPrpDdW1D/XahLDRnEURwMiQyt+H1su80lj3fvNfycUNkQLhzYaIWxKQ9AIw+S4mp3Nbnc1ZAOH4PDrqGFFtereECh/njmp3mwNkHHIgqEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154707; c=relaxed/simple;
	bh=NUoqwUzpmxvwYeEnKQhGAQHarAR4gqaE9VfcCs4ygUw=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=sKYwmjMLXHVKyiVtIxfOvTPSvrkRNH/9+WuJTxe2U1NXiX4C7NHGsnpHaeEDnqufMJaTFgDurj1soZlXn09tYXgsNGWyKVvFgiCOVDRVxM8cgQ8lZ38vkR6o5P4dGXDhIH4ECchzpkMXldP5h0aNtjK6Ar3xgwaA/JMhYtgc2to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pR2tVFkE; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1SjF4pDt+R5+2aExR5Re6VtpVijVX3+NHm6Znmd5tOl9Zpc1alwsYZJMogY4pmCVRFndbjDqhDEWDopFGYg3iXoibncNncMoWXTtZnZjDiQ3hzcg9kzAWdFy9fsKUFZcF0ms+CMBWQhkidRBvk+sex7qcQT6/0E5Y/+4TAxUzmLDVZijAzqimQs7fEst6KNZoKa3QdFEMaWbP9yzFDpsOCJxdtEwmFpy3S3T3OJty+g9kbAQq7xy8RsXqeDgUqCob+rdicjMFMAauKU7JDrqyJdw5GT2YqFpR9/UgOpPWXf1S0RzRbKzZTX6YeEKBRdeWkN1XGAAXe1CfptgJv2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL9Zk4PbEFhg/A755NizXYzcVKo31ggurO86mWkixIw=;
 b=KhJBjtATNa1rkXBnE7zACnepaAVs+ClaEelRAJDljoDS8hYAoj0hDDj700gQD5otXIbXSeLWWcGlS7lZ8UWbl45a1jtBpyNIFBEkVZZlyFn1aRTGhPJsYcbdVIss1SVLzjwQ8YNA47eBRbOUh9M7LnR51iQwfxDWqqrbkRj46vgxV56gHI25SY1MpCilF2GQ5qdgYgfP3aMY1ZeXPJdRbUZ5UvypGAmUGsl2Vk3sSKn0HD4/IQYHG7AKQZhPNtLP0Lq6wVLTV//dMlMjp4yPHLOXQoYpRSzSBDRnCwvOgsyEsDHP4+S1UqttFIq5mjeMapQIaiOlhCSPShUoRTArAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL9Zk4PbEFhg/A755NizXYzcVKo31ggurO86mWkixIw=;
 b=pR2tVFkEchFzjrPsuj2rpocHBbGRDAci1/R/m4ngXEx5EMueQSOwc4JTeNqx5GOOvFv9JLkOqTnPdaF/PR464v4Sv09t77OF//l5lEDmQ+OEi6JpiV2jsU9eNBT94lBfipPpljMJtcnPQu9jrsXrjonYu2KboYzPqXPGzjbx1BuLloytZja5J2M+r6PBRtQ4ViYeOdaUNih7iczctgpS7o06ppVjYMsGGCouWdf0c/mLb7f0tcxaxE0kDGWzqg+0dphoY8zCsfkLllfgU9dojF71onX0HIlzJ36AuS2YCdUlW40YuQ0ACFuwIbLiz/ZHMPLnLIak68gaN6shiYWLYQ==
Received: from CH5PR05CA0019.namprd05.prod.outlook.com (2603:10b6:610:1f0::27)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Mon, 11 Mar
 2024 10:58:23 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::93) by CH5PR05CA0019.outlook.office365.com
 (2603:10b6:610:1f0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16 via Frontend
 Transport; Mon, 11 Mar 2024 10:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 10:58:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 03:58:12 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 11 Mar
 2024 03:58:08 -0700
References: <cover.1709934897.git.petrm@nvidia.com>
 <501f27b908eed65e94b569e88ee8a6396db71932.1709934897.git.petrm@nvidia.com>
 <20240308145859.6017bd7f@hermes.local>
 <20240308194334.52236cef@kernel.org>
 <20240309092158.5a8191dc@hermes.local>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH iproute2-next 1/4] libnetlink: Add rta_getattr_uint()
Date: Mon, 11 Mar 2024 11:53:50 +0100
In-Reply-To: <20240309092158.5a8191dc@hermes.local>
Message-ID: <87jzm9kpc4.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: f7463bf4-f3a1-42ef-e670-08dc41ba2b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EpP9x30jdpCA2M9AI8AS+fD0evolSSzIh99eUVZsRk9qW4sZ/atrmI6l7q+Ejw0pEnApr4QUCeXg/wPvN6h0cPGhsFQ8XblLTp0iwFfTmAxqLbsjZpLiSGh2qqRyO/aRVHqOU5G+5rU8VSaukBJcA40k6CqnhDpo0srNZdwxLR/yifnjaYZn1xKuPOpcmeBSkqKUdXSBUThY2Y5WzKyFVPZg/pzJKQEJCB2CcSYzzf9pFGvWb1y48/Dhjs1DB8Yli1v62pvXF2NJcaj691cSvADhxkxHq0I09p49D/kUTmMnZ/W+IYQrJZzO51KNgNCtx3qW24SH3ncrS9FWmyxegBD6+5g2j60nYZsNQB9K0IOivEjyffvTQm4yOixO6S9suZBnJ/tterWmZqx0gTGeUXyYbpcVZwDPTPFrMrqAh/gffxBp74NlVf0LiUhnvammN6eaC//dMsR9PsYJYzgBwEx+Xfs2JTXKtx6Pu9CkJljNsfHsJLf+0UNLX9+NT24brrdSk6TZP90E0KEy/wupiVrJgLmihnrRat6M2pYV3bdeh4y/XI/DD+QfPol5EpBAfseiWvZsMZDWiwNZypwKnbUqeX8jyLrMsRKE+SVcT4ZceLdGFKpWpylagcoOi9JnmQVFQIhK0LSf/nLpfZOVEPwrfyt7rkvcgGRzDknIqltKL3Y/6v65BDgdM0YcsC5NfPP1EMaN5dpOX/qD1lIlPwi0ujAC4jk2Xj0L/FzPd1Vx4/rEPHDFuEC65/5QQg+Z
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 10:58:22.4846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7463bf4-f3a1-42ef-e670-08dc41ba2b53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673


Stephen Hemminger <stephen@networkplumber.org> writes:

> On Fri, 8 Mar 2024 19:43:34 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
>
>> On Fri, 8 Mar 2024 14:58:59 -0800 Stephen Hemminger wrote:
>> > > +static inline __u64 rta_getattr_uint(const struct rtattr *rta)
>> > > +{
>> > > +	if (RTA_PAYLOAD(rta) == sizeof(__u32))
>> > > +		return rta_getattr_u32(rta);
>> > > +	return rta_getattr_u64(rta);    
>> > 
>> > Don't understand the use case here.
>> > The kernel always sends the same payload size for the same attribute.  
>> 
>> Please see commit 374d345d9b5e13380c in the kernel.
>
> Ok, but maybe go further and handle u16 and u8

I intended this as a getter of the corresponding kernel attribute type,
which only ever sends 4- and 8-byte payloads, but sure, I can add that.

