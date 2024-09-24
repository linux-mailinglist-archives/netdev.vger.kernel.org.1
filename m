Return-Path: <netdev+bounces-129512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055119843B2
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848D71F23A98
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BCF19B3E4;
	Tue, 24 Sep 2024 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kHZK8vrU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C4E19B3C3;
	Tue, 24 Sep 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174002; cv=fail; b=hjnWCHEvlEUvy5mLtoRMQfnNuvfnQfQ68Y0lCBeHB9zNEtUndQHXMfFaA2t7omUno/QzrhHOiknUHgyvGiLMFWwUU2Qw3W7IyN1VHlUwQQ+I72S2RrJHH+opH/U9UlF7opb9ThkBDgCSzQ61oCbciI5u/R8HXayT+WwEnCMp1AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174002; c=relaxed/simple;
	bh=2VbHraPk6ht/UzI4FqmL5PTxWta9mtPNj81AfvyLORg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XKjLqGThiB+HTz357O3r2TfEJfpIeo6VvIILJVCL2ehROJmaSkCy4Efbzc4SwY23Npl+bpJ3DRYUnnDurGDvh1C5RkyvS/n2sY0Ik4R4Dg7WZ0nO0s7ZT0VhbwfiitETpzvUavgDdHV+lkChFS5Zt6tf+NV5N7EAYYEFTKHBZVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kHZK8vrU; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHCmvJFyTi8my8ddvNVOoWxWx+y7U402D90BjKoQQMGh5aGZrbnY14pv7EZvodwY6GpJUrb1TM4paOfB0gaqEyJHiU/ywKFyRd/SngT06734V1tJjg5dEaLVOaNLmZ2yLL4fQC4QdWAOlT0JfMSN7k52y4O35KEOVSM9Uc1iDeG770iUtO4sD/I57hnR+paFXxhS/qzMZ6jA2y49TV1ig7NoqjuJY7I8GO4k/SaOpOSkeUfxz7WsJoN8nGXUVq5hJnPmwOWbvCa2otKcEYmVBWkr8mOLBp1dt3/84V3QYbanz5KeMzUhdlEulIP67gohTaE5irWVF4tGhux33Ba9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCyyAGHVGW+uKgvcFwJpbo6MwBRcvw0YqXFJrEzqqFs=;
 b=PXPomXI3S8DLNWZoJDoiJk8qndFcH0GqEFAcgljDsj/Z1SZVczLfuRLne0ZgmRnYGsxoM+IK5JrkkTnB7ekR5mXw/FZTM1wRJxaDunOBVYX4J8H9nDq4dUapkiqfwW+aBFXmkN0pPHPgBn4aGyMz8sHKVXMQUTvOg11lDD6B0WurIAnckk3Uc8g+ugOLjI/vGTHs+l3+MMGsXN5IZbORE8MFvLOs7nMo7E7X4cdmcOU4Ej65FzB5V8FY5aossCpaLe7+Ia5IgO6Tf++FHHQ8UTJKwt+ghuW6xha4aCrbv7aTOmVcStNVd/JIjNttN9u03Kjd2KzX8EZXEBwr9DFdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCyyAGHVGW+uKgvcFwJpbo6MwBRcvw0YqXFJrEzqqFs=;
 b=kHZK8vrUn8Z3spn4W65MmuNr5vF2BMiF2hHFXQsbQ+YvrA4dloCNIQiRFYvf7d3+fn1Wv9nT4VF2gOAduW/iI5zxP8Qq5iC8aZHQdnKEqq9qtJ9m995Qcaslh95NCg1vpopUF2jt0G8SbbD2n5aQ7XpOiWul4un57YjVu9fyeP6lFr9fBbudclaBYqgOtERKq7GsruOQHvEhxeHuCLYniH2Er7r66tqNkJaVwO2C449fNB/xFlC+pqABLvcZtMydXEk8ht1OzfsiPuTqRUXG3qKaSpXN35wvud7pGW0M0B1eYZVhoiHRNmGJTpVrFXbiDsWegiu+pthNya34+uDpJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) by
 MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 10:33:17 +0000
Received: from DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b]) by DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 10:33:17 +0000
Message-ID: <ee295a9b-a9f6-4f18-8bb3-fc6871ecdf40@nvidia.com>
Date: Tue, 24 Sep 2024 11:33:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system
 side
From: Jon Hunter <jonathanh@nvidia.com>
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
 <22cd777b-ffda-439b-b2e5-866235aba05e@nvidia.com>
 <ZqjKi0iC83BlZ5PT@shell.armlinux.org.uk>
 <9dbb7ecc-6073-4948-8db0-2ed584847f7e@nvidia.com>
Content-Language: en-US
In-Reply-To: <9dbb7ecc-6073-4948-8db0-2ed584847f7e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0239.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::13) To DM8PR12MB5447.namprd12.prod.outlook.com
 (2603:10b6:8:36::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5447:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d01c616-222c-4b67-aec3-08dcdc844d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eSs3SmI0QlQ3SUpGallNTytlVnR1WGoxdUFNVGNCYTl5RzVEYzVLMXZOYWJE?=
 =?utf-8?B?VVZrZjZrWVpOM2RVRk9WMk9QRGJIOUtEbm5DT1JGMmdjZzlYLytkWEJJbFhl?=
 =?utf-8?B?TW5laGtiWGFlZFFMV01wYVZ5cHNJN2RTZTBNUHJzME9lOFBMM285dHhKck93?=
 =?utf-8?B?ZGU4REh5QlhVU25JazIwLzRtTWxvcjV3dlpyN3UweVVQSDZNcXJSdUx5cTF0?=
 =?utf-8?B?T1htWVFOMkh1YXozNytzcDBjbldjWnZVT2IwRlJJZUVqZUVFd3JoTEdqejdG?=
 =?utf-8?B?L1gzUWxIQkhSUmcvb0J1UDMyN1ZLTzFQTS9TVE9DWDhMSk1lV3BtVUhGb0hL?=
 =?utf-8?B?TTJJdDBleno5OE5Sd2ltTVlyVXExRlJuaFoySmRGaVJBcFUzaGo2ZUVQWVN1?=
 =?utf-8?B?UFRPN08xVnN3RWxHNUxOcGlkRW1zMVBpWVByM1F2OFpMaXVKT1VEdTVFb3gz?=
 =?utf-8?B?SjlkLzNBTE5FT3hLaUJ4RzdOa0xkNGpvNFBqdWNQYmsvWnh0ckc0UVdpczdS?=
 =?utf-8?B?cG4xamJiclVpN2NTRlVKWFdWMmM4a1BYTW5XWnhSMW4yOTZON20yQ0NMc0t5?=
 =?utf-8?B?R3RNZklUbjJ4TmFoK3FvNGNtNXloT3dsemlPUkZQTEt2b2c4dTYwOGlWZTEw?=
 =?utf-8?B?aWhRSHV6d2IzYk5aV1g2elRrVksxOXhSUmZvU0RhRjRqZ0NzWmNKN1FyVWM1?=
 =?utf-8?B?T2hyVUwxb09aNGZCMDJtTG5XRzZzb053eFNlV0pna29EYjhSQVgyQS9aeWU0?=
 =?utf-8?B?ajdWSlowWU51bXBsVjVaUVNodDFYUjFtZXJLTmpTMjNnVExlRCtWSmd5UG5v?=
 =?utf-8?B?WnR6V2syWEMzZTJrRW14L2wrcjZ1ZS9vb0NHUGdkd1QwM3g1WSs2TnNxMEsy?=
 =?utf-8?B?a0IyMDFPY1EybXdmbm02S2RXWWJ6SWtJZ2l6T2N4NDNENnlteFI0UDVmTWwy?=
 =?utf-8?B?QVFrcUh0Z0NqbjdkWG41ck1ydGduWDZkVWROMzFIQi9GejQ2Wis1ZmlmT25M?=
 =?utf-8?B?cU1nSEpGYWRTalBva2RQYTdTZ25IL1lJczMxNWRJVEhNUkdHV0J3U0cvTmQw?=
 =?utf-8?B?NzRiWC9QYVREM0FkeEtuT2d5STZTRWNVeFlDY0cybDN1MlNZT054NjM3VVVi?=
 =?utf-8?B?K0FXamszVFVPZG0wWnFkRGpRcVk2VzBEcVpyMU1JQkkyL2NEZm1xODhhZ29G?=
 =?utf-8?B?dXdZYXpLQUkxSkFqOTFBR1B2UTVpYjIwRWM3c2pQQk91SUtuOTVOTkVxSW90?=
 =?utf-8?B?ZWkrM29GdkE0M1VydkxKWDEyRmlMU1I5VDJQN0ZaQkpZVnkyVDJObm9OUlhZ?=
 =?utf-8?B?OUhHVU9FTXpBRXdNbkIyVWl6M0srdURlNDUrL2JlZjMveFljaTRQNThLZXk1?=
 =?utf-8?B?OFkwQmZFUmlxZTUrb0ErWCt1MXdOUmUySDYyWEhIZEhLNzlhWUdTM2FQcDN4?=
 =?utf-8?B?cFV1SEtKZjVCQUR6OGJWVVRoUnVtdm9hWm1rVGxUeDNyT2hvL0VnNWQ2U1VJ?=
 =?utf-8?B?eWlUU1J6elprK01xbVZnRzNjYTJoSHBLTFo5SkJVZnl3SzFYaGFzM1RTUytP?=
 =?utf-8?B?WjJ6NVBqU1c5akNwa2lSSDVUSmY3R2YxQjA1cTdBWjN4Yk5zZ2MyNTBlbUhH?=
 =?utf-8?B?OGNnMEh3RGd5ZjlPdVovV1dGQU9LMnNXNURxRGp1THkxbHFTTVFKWFI2UW1U?=
 =?utf-8?B?RjBhTk45Z1IyMXYzR3B1MEMwNTlIUG1xY1RiVVM1elFOZjlneWZZQ1RRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFhGbGl0aFdSSElhbW9Vdzc5OHhZVUVsSnNHYmthWnVRN3hST3BUNkEwUENw?=
 =?utf-8?B?UXg4M2tmOHZVNENwWW1MTDgwZ1FMN3NYUmV6MDVqSXIyeUNhQ01ITVdrNEZ3?=
 =?utf-8?B?U3hmRUdsMHRuZG9EOTVxY1FpbHd5NWo2dzFPSU5PaU9RUGw4dUhsVzVKTWhE?=
 =?utf-8?B?bWYzVzd1TDNSRlNtS3ZIcUlRbWxmSDJvNHA5bXBJMm5HK0xzdFBLRWpyN1pW?=
 =?utf-8?B?bHJoa3hBS01Od3hJM2RINVRESGRDcUdJOW56cHZMVUZYeU5nQWxVZ3J6TTU1?=
 =?utf-8?B?ejNtUzA1MlQyNWxqUVMxSGF5a2dZMWlocHlER1hZeXE1aEFaMDMwdC9PNHJY?=
 =?utf-8?B?aEVDd1gzRzUzLzJYZVZ5KzYwREltSmkzR3FDVWhxRVRNVDFkd2lmMzI4L1E5?=
 =?utf-8?B?QlZVWnZYVWNEREdnNEcrWE1kQ2lIMmp5dUIwc3E4VHVtQ2JoYXpHeGRGSXd2?=
 =?utf-8?B?OEw3Y2J3WVh6dnFIOGFrQkllTkdiTnkvMzZuS0ZFUk1yZGJJZG41Q1k0MEx1?=
 =?utf-8?B?WUltZ280YkxBeDRGQSt2M3NSYTM0UGFqZDB2T1psZ2lOYlVBSTZwK1VYMkdT?=
 =?utf-8?B?c1JjM2o2eGFMVEgxZDN4TWc0Z29zcE0zblNPUXdDRmFUSEpIN2hTYmRtdWJ3?=
 =?utf-8?B?SlB3N2I5K0NCT3FPeWNkam9mck8vU1g3VmZIYnNiYlBYZFFKQXRqemsrMFl6?=
 =?utf-8?B?c3cxVWJiZFIzN3NNUEZsalNvK3Rja095WTlXdlplcDJXQ3RtcExwNHlNRWI1?=
 =?utf-8?B?emE0Slp2czBrYTFtOEFKWlhWc01udkVuZHFQS3BJY2F6cEVtdUNiMmhMcFli?=
 =?utf-8?B?Z3M3WHpyT0NVWmsrK3hhWFd1WWdxQXM1VnlLdy8rRmYzSnNIbEErdVJOQVdV?=
 =?utf-8?B?a3EzRHhvdnE1dThWdVora3BWOGpFVmJ5V1MyTHdCKzNGLy81NldUclU1eWlP?=
 =?utf-8?B?aG40OGFWL3NETnd0bUk4S0dEemRZSE56VjdLUTJKYTk4WG1aK25kNFJmTUhP?=
 =?utf-8?B?a0wraDMvRUlUTXdJWkpLekNYdDFwSlFlWGtwQ3JFYm4zYjVnMWFvR00zWG5o?=
 =?utf-8?B?WW15bHJ3NzlETlVVOGwvdTJIZjdiRWRTeWNOZVcyVlhaa3l0TnMwcU5oUXhK?=
 =?utf-8?B?SXlDUDRMa29UaHZjNWRkZWRWVHRZTHBwSmdVUDV5ZjYyU2ZyVlVkOUhDNkwv?=
 =?utf-8?B?b2ZyTGx0eG9NQmNYR0R5dUd2SFRYMzRiRm5JN0lBeVBZayszc01yTHJCVzdw?=
 =?utf-8?B?Z1pEY2dKVzhpdEpuR2w3QTVobUM3dFdDelJVZTk0SWhYblRZVlpaR2ZxOG51?=
 =?utf-8?B?WXpNTkhSdVB5Wm9udm9ENjFOTVNiZkcvNkQ4Q1Zkb3lMSW0zRk5SWGVNdWVH?=
 =?utf-8?B?UDAvaFBIWDZvSlBvb1NXeklQZi9kZnFlclI4L1lDdGw2NmFMNVQ0UGRqR0Qv?=
 =?utf-8?B?QnpIT0hNTHpGU1lCQnFmTDlXS0JwOTlYK3hSV3V2dWIyMjViZ1NseTIvdVdT?=
 =?utf-8?B?ODFpRjhFd2EvSm9YUmN4TnhsOXpRdzVUYm9oemxPV2RyOUh1L1dZL1lYM2xa?=
 =?utf-8?B?cjNCVjNYY2lIaUlOY0tUM21hd0xTMityTS9kcTJFRkRQM3UwaE5WdVlIWWt1?=
 =?utf-8?B?QTRQdVVIMXYvZjRqc201MU1wSkpMbnFvb2U4NEhSaGl4NkpSRVhVaDJmMzFO?=
 =?utf-8?B?SU9WS3dRT1NwYU1vQy8xWS9yV0g3WXFTamVjY00wZFF2dXMzdFp0a1BiMVNU?=
 =?utf-8?B?a0psNVk2T3RwanROZEY3MHZPZCtGMVNHVWFteXFPaGpTWm5zTS9MbkpzN1pz?=
 =?utf-8?B?SzF0a2gxL3VuV2NJbm1MaXFLbVpPdXk0RlU5YlBxYmhZS2JoUCtIbWd5ZDJp?=
 =?utf-8?B?ZlJ0NkRKMmxPWFRzSm1RTDhJbC91NHVCbXBCdktQSXBhNEFxQU53em5odXhE?=
 =?utf-8?B?SFdtVGFUQkVVWU1NWjBMeml5TVM4MFFYWm5sbkh2VjRBNCtURDhIZXJYTTNj?=
 =?utf-8?B?S2RHck5EMUFtcWsvM0I2Uk5DT3JyMCtMK0N3WURSVDVraTI1Q3ExWHBTOXpo?=
 =?utf-8?B?aGFrYnlKbTRLU2xVQVlEbXRuaFRGQUJ5RlFrbGVkcktvdWVaa1RSR1hSMC82?=
 =?utf-8?Q?JIfgzrlQHHBlj5320WCgjlYIZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d01c616-222c-4b67-aec3-08dcdc844d50
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 10:33:17.2838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MOq9BBbJt1NYZMPQ0I3csO05qgDuKzNC2O9ZK/WlsmbGkl5QzkZeem5PDTzdjzlexKrVl4d/kwRrNGTzvRRpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949


On 30/07/2024 13:25, Jon Hunter wrote:
> 
> On 30/07/2024 12:12, Russell King (Oracle) wrote:
> 
> ...
> 
>> Hmm. dwmac-tegra.c sets STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP, which
>> means that the serdes won't be powered up until after the PHY has
>> indicated that link is up. If the serdes is not powered up, then the
>> MAC facing interface on the PHY won't come up.
>>
>> Hence, the code you're adding will, in all probability, merely add a
>> two second delay to each and every time the PHY is polled for its
>> status when the PHY indicates that the media link is up until such
>> time that the stmmac side has processed that the link has come up.
>>
>> I also note that mgbe_uphy_lane_bringup_serdes_up() polls the link
>> status on the MAC PCS side, waiting for the link to become ready
>> on that side.
>>
>> So, what you have is:
>>
>> - you bring the interface up. The serdes interface remains powered down.
>> - phylib starts polling the PHY.
>> - the PHY indicates the media link is up.
>> - your new code polls the PHY's MAC facing interface for link up, but
>>    because the serdes interface is powered down, it ends up timing out
>>    after two seconds and then proceeds.
>> - phylib notifies phylink that the PHY has link.
>> - phylink brings the PCS and MAC side(s) up, calling
>>    stmmac_mac_link_up().
>> - stmmac_mac_link_up() calls mgbe_uphy_lane_bringup_serdes_up() which
>>    then does receive lane calibration (which is likely the reason why
>>    this is delayed to link-up, so the PHY is giving a valid serdes
>>    stream for the calibration to use.)
>> - mgbe_uphy_lane_bringup_serdes_up() enables the data path, and
>>    clears resets, and then waits for the serdes link with the PHY to
>>    come up.
>>
>> While stmmac_mac_link_up() is running, phylib will continue to try to
>> poll the PHY for its status once every second, and each time it does
>> if the PHY's MAC facing link reports that it's down, the phylib locks
>> will be held for _two_ seconds each time. That will mean you won't be
>> able to bring the interface down until those two seconds time out.
>>
>> So, I think one needs to go back and properly understand what is going
>> on to figure out what is going wrong.
> 
> Yes agree.
> 
>> You will likely find that inserting a two second delay at the start of
>> mgbe_uphy_lane_bringup_serdes_up() is just as effective at solving
>> the issue - although I am not suggesting that would be an acceptable
>> solution. It would help to confirm that the reasoning is correct.
> 
> I was wondering about something along those lines. We will go back and 
> look at this.


Just to circle back on this. After reviewing the link bring-up sequence 
in the mgbe_uphy_lane_bringup_serdes_up() function, the Tegra hardware 
team identified some specific sequence and timing requirements we needed 
to correct. Paritosh has posted a fix for this [0] and now we have 
verified that this fixes the issue we were seeing without making this 
change.

Thanks
Jon

[0] 
https://lore.kernel.org/linux-tegra/20240923134410.2111640-1-paritoshd@nvidia.com/

-- 
nvpublic

