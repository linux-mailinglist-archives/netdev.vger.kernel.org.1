Return-Path: <netdev+bounces-114088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCDC940E8B
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8556F283DE1
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1897191F91;
	Tue, 30 Jul 2024 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cBFazgq5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1618A92A;
	Tue, 30 Jul 2024 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333736; cv=fail; b=cYsZh70WFHuRgAOoJFAGvvcJKwU/pb/RGq5doWqVT0OFMlfC/Z8FNdAfLHBUbaMdfZQVy9MaNAaJ17BB1g4ILJG2w5qPByPxsoV66kn6gf5X9HpUSyL734YMsQX7gnl+aQNZuy6BbAsfGw2jjhR5CAQlvCtF9NkvmwBJ760YYks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333736; c=relaxed/simple;
	bh=WTlZlsHLTP3ZfSXmIyB6vn/eSUUoL51ANSNlSU4MZp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j7/YWxJcJ6PHqdxdKnucQuzKyy5LI/rBVIqR/LrQt61plUrwmYv2ufHedlKq03i+sbOuSVeIHxIT1P9CqPM1/xzON8BOjhK4tvqkjjFp7ioegEoT4NrkSShPQgrxHQ7M0ifSp63/szO/zZYiHwFc1ic+O4D3+khLQyF9bKZOtPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cBFazgq5; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzgE52OitZbQfROc3FgpG6/gHI/h5W7O9Z395L4sFmOEGit9tIIw94w3mvymPNNXKNxnbX8t+0dJLqigTr4++NRcicoDcwa42YkEt2iGBQkUVFKu2qvx7mFwPr2JJL+CygoXoQsa3PGJPQL7Py9ZkYBxadCUu10X1c7aZxGshp9cmotRtmoj/+xjsIYgRlU2YqVcyOqLRI5IctBtPN9X4EWt6/gTohJMQwGAkwIGHg0s+9QfcuaX2Zno0/EaDRK1rAKau4tM/em0SbhB+A1Lk71lqC0AJaguCPHom/2+jD8RVwi26dyfFUy+8RdyrjyU4S3l/Qe98fPJwCWk9Pyv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0BEasvEZMBEObeKmRJx4kKDVAwNE0fm/SPU1H/lQnY=;
 b=WUlThiOZkdCTe8K525M+sHL1yn6lazedx6ziUMmhSV7ZIKbnGUOi9qxxEAPQ15jHoRuvfxaL5gz2oKBFcE/M/Bcc71AP5cN/OkbYy/pjvM6RqI/3r5i1teHSPHitC++X1fJDKGHsS5H+NbAj63KWmSBYKUFdv2lkheMrABlzdMl94jM+WQu2THs25qtQ2Q/+LDHPDXWTK2bjc57IBfaewTURQTg8f58OIPivt3Xpkj6QwnSNM/zbBRV3ejIH93kPbWyP9lxtiEHn6C6ieo97P8fTPQmPxVthBNqd76VuCrDEAN3pQwghi93SBJbbF04gp+cTVeAmmHbPsJxNQzdJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0BEasvEZMBEObeKmRJx4kKDVAwNE0fm/SPU1H/lQnY=;
 b=cBFazgq58Rh383i/xjDMjSUHdGq6+DcOC6JfRTHIPWdJInIsgVg6bd8nosFA/wQXqzTCx3sTSBY/r09SRAVYY3Ob5c5ugStr97LMql18b/WVCbrqHHGExaJuuiLwgXv98DpPqI+Fwx+Unl1wYpyLdwIXECXPY+4342IQtd/Yy9dLc8I4byReT6bt5I9jWYZlkdP7h+6gwbj4tulKtSQOtkyysltUnKWMV5WpDoOoEVfhO5oSWBR9K7Hf1Zgk2Mdoj+0NGbwhjxanYKw1S8KJ0+zLshacONVwNZQQsuLm2HdtUhFhyaFg/XXBmSXo1KOPqYdM5Ge5P5by/LzHkPFj2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) by
 DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Tue, 30 Jul 2024 10:02:11 +0000
Received: from DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b]) by DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b%3]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:02:11 +0000
Message-ID: <22cd777b-ffda-439b-b2e5-866235aba05e@nvidia.com>
Date: Tue, 30 Jul 2024 11:02:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system
 side
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Revanth Kumar Uppala <ruppala@nvidia.com>, "andrew@lunn.ch"
 <andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-3-ruppala@nvidia.com>
 <ZJw2u6BIShe2ZGsw@shell.armlinux.org.uk>
 <BL3PR12MB64504E3A40CD6D8EAB7FF0C8C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
 <ZL5nQxCyj8x+5lWk@shell.armlinux.org.uk>
 <bb949d68-3229-45b8-964c-54ccf812f6f8@nvidia.com>
 <ZqdzOxYJiRyft1Nh@shell.armlinux.org.uk>
 <2aefce6d-5009-491b-b797-ca318e8bad4e@nvidia.com>
 <Zqi1O88vXK3Uonr1@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Zqi1O88vXK3Uonr1@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0550.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::20) To DM8PR12MB5447.namprd12.prod.outlook.com
 (2603:10b6:8:36::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5447:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 721939e0-0ae2-4ef3-4208-08dcb07eae44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlQ1UHhoQVgxL2k3T2JmVkxZeU9WRlZxa1h6cm5PbW5OVGJWNFRoK3E4Q2lo?=
 =?utf-8?B?TW53OXVQR0ZkTFhnc3p2VkFzSzlTK3lIajUxVGJ5SGVBQmNpSk8rWC9wbzE5?=
 =?utf-8?B?VFcrbGxxSDhNaUJzaWxrNG9ubnZ2UUI3Q2xKV3crOXF0R282R2wzQjE3YWs0?=
 =?utf-8?B?bmlXL3N4MTFzOHEvbld0d0VsMHpqcmV4OURzVmhDOWJJNWpwd2ZzVzdVdEN3?=
 =?utf-8?B?UUsvSS9yZG0wTWhoTmtUQ1ozRmthbTZCRW1INU1veTBqbUpRS01ma2VjSFJS?=
 =?utf-8?B?YkR6czE4TENjU3VONzFzTkI3NUdXVWhadG1VNitjT2J3OXdPL2Ewc0xuNGRQ?=
 =?utf-8?B?ZVljakNSbDZySmNkbWgvYm9KR2gzeWRrUVVoci9SR3I3bE9OY3VNSUNJVUVR?=
 =?utf-8?B?R0tEQ29wTFFkSGd3UkxCRVEwOWs5NUdlcUtCYVpQMnVlZlNNUUtaUVNyK0xz?=
 =?utf-8?B?eFA1YWp4dnhhSmZQOUFzc0ZvT2VrNURXdnpxRFNqNWl5WGxQRTExK0FTMU9s?=
 =?utf-8?B?T2FJaTR6ODdNUmtSY1dLLzBYa05vS3JVbDhWVm1qblNzcEhCZWNPcUxFc294?=
 =?utf-8?B?UE05YTJiOUFGZUNhTEFUY3N6UXBBZVlPSS9pU0VkWDAwTUFwaHhiV3ZnMWh0?=
 =?utf-8?B?RVNFbnpjbXZ0TEV6QWRnY09VMGZIalZEMklDc25BWjZqemdGSnVSVHd0MmVM?=
 =?utf-8?B?cHV1c21pUXRuQlBQbzhjRVkwRTJJY0tWN0grWmtPODhvSFNzRkc1RHdOeHRj?=
 =?utf-8?B?cHBEaGJWeFEvSCtCUG45STJIWW83T1NicHFFMFkxL1MrRG9EY3FRMkRlcTdi?=
 =?utf-8?B?S1ZmS2c1a0hXaWpXZjNBMnhVNnQxK3JiZVo1b3B0WjYxMEtTZ3FEWFZhSGFG?=
 =?utf-8?B?U2FUVGVOb3NQQ243Y1RNbmcyNHJuTWtuT292ei8vUjcwZklxSXpXMnpXd2ts?=
 =?utf-8?B?c0xjUDMzTFMxMnljZ2dQcXJUQkNSNmR4Zld1VDhPV29hSGUvbHIxNmF5Vy9B?=
 =?utf-8?B?K0s2YytjMkRqM2k2enVJRUFTUjRPRWVydHFiOXRYYXhmY2xrS3Zvc0h1S2dN?=
 =?utf-8?B?WUpNc244d3dnQ2w1bHpCMXphWTV3c2NpUStXQVlNUGoyNHJLdmVzK0cwMCtw?=
 =?utf-8?B?TFdvNXk2VnlZMUdmWXpLSUhhZlNMSUdOaWw2U0UzcWlqaXd6OWRWRWREdlZW?=
 =?utf-8?B?aHVtMzB1L2Jiem52UnAzOGw2MHRIZjUrMGpMYjB2SVNCNzZFUFdzdEk5NWhV?=
 =?utf-8?B?Z29nWFF6RFhmblZweVR0MnVOV2JFVnlZV2VtRWJFdGVQRW55Mlo4T0pLZjBk?=
 =?utf-8?B?L01qRmZXNnBwS2JyZ1QxOFk2NkJZSzNwNlN0L1U1dDJlZC9GbEg3S3hzVjZh?=
 =?utf-8?B?VVdSalMzMjBQOUkvU2p5eUM1UXVOMGdTUzdKVVRhcllOcktmT2R0NTFTbEYv?=
 =?utf-8?B?RXlWSkRTK2p0V0RySVgycHlqQWFVOFJkOS9jTkRXcWhXclFXTGN5QTlQdGxz?=
 =?utf-8?B?WHZJdHJzSVd6Z3dMTlBCaFF4TTV6aDVFdnd1d0RHQktnZExnTmhicmwwayt2?=
 =?utf-8?B?bmlWVWdhaUpXcmtQTm9URjR2SnVpZFM5ME5NN2ZPcXhoQzF1amRRTDloQkQ2?=
 =?utf-8?B?bWRqeExoUjlMSVJPRDJ1eUpNcTJhazBRdkFkbmpHNENjT05LajdkdUlJNlBC?=
 =?utf-8?B?NFpFVmhHQXR3T2lWUnRadXhVZ3VVY2xlQy9VSE5kNk9aR0ZiOWtMZ29WM3hN?=
 =?utf-8?B?b3VIZlBNT2xoQjh2cDB5TjRBcVFsb1RvMEY3VUxveUJrOUM2THFGdm96a1BU?=
 =?utf-8?B?RUFnSEJzUkNQQzVaMTFDZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVpiN2diZk94bExZczRQbFhvOUNzeHkyTldlQmtKNFJ3L2lvcTZaRXlBRHJM?=
 =?utf-8?B?NVlIMTJBYmRUKzdqVWFKVkoxWmdLRmNUVEVXSzB0OTZrN2lIRThrNlp1akZV?=
 =?utf-8?B?OWp0dTg1dDc0SFNoYlZSL3FjNVcxM2FMVXN1RjlGTDBWekxxOUxmdEZxa3RS?=
 =?utf-8?B?SHREUjVjMyt4bVZrakZvTjZqaStMeUdrVFJseXQ3VEFLbzFGYjhUdEw0Uyta?=
 =?utf-8?B?azdBUENiSDcyQVZEUzhISGYwbmF3aHBXeHA5OEkwaUJQM1hmTlBydTN3Yk1n?=
 =?utf-8?B?M1l3eFNRWjVxQ3l6VlpSaEl0RENIdjcrZGk0QThOc2RXdVd5UURNbTBESFh6?=
 =?utf-8?B?bUphTTMrV1hYZXY3Mm85Ujh6djV5Vzd6TFZDVVhjRXdJUWFrSGRJK1VPcDFR?=
 =?utf-8?B?dUg0NFB4ZUZ0M0ljWERhZ3FXSzVMR214eE9RbEJDR3NVUFZ4SmR1MitqdEJq?=
 =?utf-8?B?OXlvdk1JQlQ3UkRkUXFiVUloY1ZEcHIzdjgwaUhWTU9nRWt2ditCaW1ISVdp?=
 =?utf-8?B?bmJwWkhVU3ZsSUlUQUJJQWRuZXUyOWkwU0pTbzF3R0V6NHo5VThnalBjRm0x?=
 =?utf-8?B?NGpKQllURWU2SEgzZnFMUEhJekhMYXhHV3QyaW1IQjVMN283c2xUMUxBenlM?=
 =?utf-8?B?SGhNQ2VTWkFNYThHeHd4dEpINU9hMUs0SGpUZUY0OGZOWVNpMHNkdUNxRlZa?=
 =?utf-8?B?c2lqR2FBTUYwTmsxVjlkZm1TMkpaVURqbUhiWVJPNmphUVlGVmVEa1JOUElK?=
 =?utf-8?B?TTNoakJVclY1eUdVRUttRnZFczhtUC9IQ3VXZWpIM3RoZmo4LzU0TTNNOGhL?=
 =?utf-8?B?NSs2MU5iNmNmSnNkRzRXVzNHQVpQK2tESkswSVZETmVGOXAwbWJMYWl6Wmp0?=
 =?utf-8?B?anJKTE5YRllhOUplK0l6a2FZb1FpL05rTExjSUdzdjhzZTVWOHlmaTRWVHdY?=
 =?utf-8?B?ZTJHeVo3cWs5OGo2YUlHMmNiYTRsSWdpTTBwVmFvdjRLV0hFK0c5YWZOdnZH?=
 =?utf-8?B?Vjh3VFNkNk81a01oWis0ZHhUdmRTbzFRQlVnNHA3ZUJ3TjdvaU9kUk5vcTJl?=
 =?utf-8?B?S2YyaXJObkZia3FvQ2NPRmxnU09BTTBDZkVsVmsvT2ppYzVDMzBpc2RSK1VI?=
 =?utf-8?B?QXVGdHArZzlZcXZUT2FLNU9SbGh3QUU3a3pWTVorc1lDdFRWcjAxc2VacEp4?=
 =?utf-8?B?SVl4MnpGTkcxcUMrRzZnQWdrd0xINmd4LzJvWVp0SmhmUFdqRXVFa2RZSlB2?=
 =?utf-8?B?K2ZITk5LbmZWdVRGL3NyQUpzbWNkZ0x2QzEyTnNPa2QzZFBubE8rT1pQSkJw?=
 =?utf-8?B?T093SkxtOFpmUW8wT00zWlBtcWFRNWRVeEY1WUpRMVd0YjZYUWVnbnFMMDZ4?=
 =?utf-8?B?WDRhaEpzVXN0RnJXOW9BV1k3blVGU1AvRmhzZkVCZ01LcDdLZVZqc0U4TUor?=
 =?utf-8?B?M3dpU1E2N2NoS2MvcFpncE9mRytRMlAydTVtZjZFQ0tJWHlWQ0pKTStFdjRV?=
 =?utf-8?B?NVVIQkFvMWVXSlhEL1JRVXBSSWt4NUZwVTdBU0s0aVZHVlRyaFBXOTFSeXVH?=
 =?utf-8?B?Q0t3VVo2dmNVRDRFTHRHenBmN3R1WGJqdEJwYUUyZHF6c05kMVQwRzFYK1hm?=
 =?utf-8?B?cGluNkpidHRzZXRUY21PSStuNFZmNHRHUXJxbThFa3A3MkNHWVBiQ0dpOG1Z?=
 =?utf-8?B?eHpZWkpKTVJpek1IcXRRVW1nZWhwdHNTQkdISkN5dnI1Z1NZa24zUDg4QllX?=
 =?utf-8?B?Tms2L1hSMWlZR2hxeVA3eE11TzlZZ29DQWlvN3FnV3JWNUVoMXJLR2RHeFFO?=
 =?utf-8?B?L0lsbjl3UVpYN3g4U08wa3dteTNtWmVJNEJOdEhYaXZQb3JwY0RlSVg4K0ZO?=
 =?utf-8?B?NHc1cGRUSnV2a1NaZTFxSVNNSFA2d3k2TWVDdi8xT21PaU1BZGRGWmUyU0dQ?=
 =?utf-8?B?QzNsN3kxSXd6SXRRYmtPVVE2YkJrSVRxblo3MVhFWGppTFpkc1FrS0tXSTAz?=
 =?utf-8?B?OEdFUGtrVmM5SlRUYnp5ZGYzMlltNkFsWEh5SjFCUXVSbUZxMC8vdHNNYXZF?=
 =?utf-8?B?RXhHQkJlZHdRWXhlNTQxZEVpQm5BN1JWcWhYVHU5cGxmdjMwVzBacXNXbVNo?=
 =?utf-8?Q?JziqYQLkiMJ/yaBaWzza4ElqR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721939e0-0ae2-4ef3-4208-08dcb07eae44
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:02:11.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+rjHyFL5mCkKQTM4yjoWUp9zdUj3TS3n2RwiSLj3PSfZL5qBA86wFPO9ppQTf5Qb8rp/VDwdhf3RN6pwmlw3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456


On 30/07/2024 10:41, Russell King (Oracle) wrote:
> On Tue, Jul 30, 2024 at 10:36:12AM +0100, Jon Hunter wrote:
>>
>> On 29/07/2024 11:47, Russell King (Oracle) wrote:
>>
>> ...
>>
>>>> Apologies for not following up before on this and now that is has been a
>>>> year I am not sure if it is even appropriate to dig this up as opposed to
>>>> starting a new thread completely.
>>>>
>>>> However, I want to resume this conversation because we have found that this
>>>> change does resolve a long-standing issue where we occasionally see our
>>>> ethernet controller fail to get an IP address.
>>>>
>>>> I understand that your objection to the above change is that (per Revanth's
>>>> feedback) this change assumes interface has the link. However, looking at
>>>> the aqr107_read_status() function where this change is made the function has
>>>> the following ...
>>>>
>>>> static int aqr107_read_status(struct phy_device *phydev)
>>>> {
>>>>           int val, ret;
>>>>
>>>>           ret = aqr_read_status(phydev);
>>>>           if (ret)
>>>>                   return ret;
>>>>
>>>>           if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
>>>>                   return 0;
>>>>
>>>>
>>>> So my understanding is that if we don't have the link, then the above test
>>>> will return before we attempt to poll the TX ready status. If that is the
>>>> case, then would the change being proposed be OK?
>>>
>>> Here, phydev->link will be the _media_ side link. This is fine - if the
>>> media link is down, there's no point doing anything further. However,
>>> if the link is up, then we need the PHY to update phydev->interface
>>> _and_ report that the link was up (phydev->link is true).
>>>
>>> When that happens, the layers above (e.g. phylib, phylink, MAC driver)
>>> then know that the _media_ side interface has come up, and they also
>>> know the parameters that were negotiated. They also know what interface
>>> mode the PHY is wanting to use.
>>>
>>> At that point, the MAC driver can then reconfigure its PHY facing
>>> interface according to what the PHY is using. Until that point, there
>>> is a very real chance that the PHY <--> MAC connection will remain
>>> _down_.
>>>
>>> The patch adds up to a _two_ _second_ wait for the PHY <--> MAC
>>> connection to come up before aqr107_read_status() will return. This
>>> is total nonsense - because waiting here means that the MAC won't
>>> get the notification of which interface mode the PHY is expecting
>>> to use, therefore the MAC won't configure its PHY facing hardware
>>> for that interface mode, and therefore the PHY <--> MAC connection
>>> will _not_ _come_ _up_.
>>>
>>> You can not wait for the PHY <--> MAC connection to come up in the
>>> phylib read_status method. Ever.
>>>
>>> This is non-negotiable because it is just totally wrong to do this
>>> and leads to pointless two second delays.
>>
>>
>> Thanks for the feedback! We will go away, review this and see if we can
>> figure out a good/correct way to resolve our ethernet issue.
> 
> Which ethernet driver is having a problem?
> 

It is the drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c driver. It 
works most of the time, but on occasion it fails to get a valid IP 
address.

Thanks
Jon
-- 
nvpublic

