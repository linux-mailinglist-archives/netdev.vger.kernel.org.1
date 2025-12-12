Return-Path: <netdev+bounces-244573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1DDCBA11A
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 00:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B464130987B2
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 23:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DE22DEA8F;
	Fri, 12 Dec 2025 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jiZJ1jbi"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382562BE65C;
	Fri, 12 Dec 2025 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765583610; cv=fail; b=YgIpVFBw4owVjkyu/zadS+rtglj7OZ9dFUbemVl4eGzkdWWdERRZ9wgth+GScpjMLlBplxg6+Q/D4W+Nv/Ad5K+E0EMzCFilBiua77kc1Fvv5zNi/wJrPRp959QCg46plnQxktmjI2zqPXdnAi9pESn/eTf/TquyffmDBA6qkr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765583610; c=relaxed/simple;
	bh=FmS+L/Zl3BR8/oeMBpsbBf1YqLcAYYLQoW5pAk7Jd9g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YnXMGBX10Us+ZAst6qCeXA2PAvNPHq5DyDlPsQOXq7fHeLzP0tNn5bWMiyniUb7pwbq81i2uBY8zWpk56rp7LSPxBkS3M3g8cRB3EGPYmDt6NIPh7YySw2A+mqcgmmk2GC1o6oWogj5hMLvZoHD/NJy9d1GE8zlDdpuGZNwCzh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jiZJ1jbi; arc=fail smtp.client-ip=52.101.56.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOZp15+/ejYFYi4PKOboktT5H7yvijAziUFI6XHvBk1dXeh1YddcKt2TT1NUtLUqxOYvG2QOsMF4IrtNfrwawmGk6c7hN3BEbZtV3TimZIDmQqiaSN3Rvl9kRsNBQbkjK5MDHGpqtkEPojGQrqmzuNNQXyZiGce555ZOA84sDhSZSuESG7+n7HcKDdD6CsbE3vfaQWxWDoX+y2QJrRBrslqIuX1LjrqAoTzzo9T9jWiHuIWZ6sX2pM9O3R6wNLR6jxcieZ9XtZnc4WPUfQdoZTXVFfH8wqlDrZbOfJE1PXHhmPmblpw5wXp5/GpBmXq9zQ6van6pdRjXjtozTk382g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxY2sD0eEr4yN7ve0gi+9/Cjd7aZtwyP+B3Wrdd3oJw=;
 b=Uo2asFBxSxNAHf+LKNzmqt3nM36oCU8v3WNOPr0+DMT8gtWXiwoQRdybXVoiOxUmbXCArOw6XBXYRjehVDrUf2s5uXHMslp6oExnm8sh9an80khfVWJ1QqyX+7mFf8PhQ0V4UY87rWhT29iMrm3qpMvECKLwvRnO1F5aByzMTrIcgoSDBJpANatlLLmHUfRoaI2HrVLgBqDLMk2T7qY8NAbOAerTGIZmx7uo1DTgLJ7vFkh49pek4i6RpfmFdI3cnwWoNRD4yls9+/ZxhnuuYQ/mLuTrHwWnT2C3TaEkVq9vLW2f59/vYPOWpRp+F+bcGlqs/wC617vM5RyfbQRX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxY2sD0eEr4yN7ve0gi+9/Cjd7aZtwyP+B3Wrdd3oJw=;
 b=jiZJ1jbibi1joiTFqLYxbhkk1kjzrVRYz/On/qoI1F+zdxbri9AlsRcbPqgxvVYKoKjkdTzt+2Q1zwBo67VHx4a+/RywItxo6ivJMMX5VZwpQatEVALyKA57nnBv3DFU9PetRDtzzg6cV+n+6Iva9OQ81sLqefFWr6vD32Y599A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 23:53:25 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 23:53:25 +0000
Message-ID: <29ee9551-de8c-401c-8b88-5cc2a35abee3@amd.com>
Date: Fri, 12 Dec 2025 15:53:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/1] i40e: additional safety check
To: gregory.herrero@oracle.com, aleksandr.loktionov@intel.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251212210643.1835176-1-gregory.herrero@oracle.com>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20251212210643.1835176-1-gregory.herrero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 078334a0-fd5d-4536-64c2-08de39d9a3d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEtLWUR2ZHpiTFh6RzQrVnVOUGxCWFo1VHRFYXpaS256RzZ1RGJkMzFpSkpF?=
 =?utf-8?B?VC9heVFUTXBkS2E4dFBrQW12QVNuL2NVbnRzTjZNTmFJNGdCeWNnNitYSGRn?=
 =?utf-8?B?dFk2aXJDcStHVHZidzUzdGZMYytYMVZoSHNKVE1yVTBCZUlET3BoSjBuaHkv?=
 =?utf-8?B?d1hTUUtmVDF0d0xSNlozSysxL051aUdkZGxSMUtNMmQrL0pVdExZUVFvTkpa?=
 =?utf-8?B?U3hpNHpmc3hzcVE0TUVqbmszdngxL3FGZ3ppVUcxVENGRnBzSWlSTUNEM2Vy?=
 =?utf-8?B?SSs3Qlo5YXJmUzhKSEZyQ29YSEpnZUQrc3E3bU9tNUxLSmVBZ2NLTFgyblhJ?=
 =?utf-8?B?QklHUU1DUFB0a3kvdFBBMlkveEE5SFBGaUdHNEs5SDNicytxR0ErUDJZQTI3?=
 =?utf-8?B?UmQ2d1YvbUJtN3IxL2pJTnhEdWZwdWc1MEQ0RmY3TU5QQmhOUjZJV3gxdmlP?=
 =?utf-8?B?ZXd1S25MQkFsaU9LcDJvR3I5elFpNWZRL2pLZSthaG5GS3lLNFcrcFY3R2Jl?=
 =?utf-8?B?SCtyQmhwUmpYa2hKTlgyK1VTbWpkNnNZUjV0VzJ1SWVzaCtLelQwNlE5OGZa?=
 =?utf-8?B?OE10Tk4rZG1lZysyVmUwRUZEenk5SmNvUnNFNDBGMm5rbnZISWJWczBJcGRk?=
 =?utf-8?B?Q1RhQWNBOUtOQmRvN0dMWVkwbHdFZGEvSmx2U2pCaEVIVlNDYzFOcHRSWFk1?=
 =?utf-8?B?Z1c3RkhiRnUvUDZpNGpIZDJsOGVEUVBNWWIyTlpOZHBvem9Ndys4Sk9kYTZ2?=
 =?utf-8?B?b0UwME9xNGZ5Y3lNZit5ZDdtTmhrOWJ1MVRBVTlSN3NOeFk5U0pmMHg1QWJ4?=
 =?utf-8?B?dENHSVBDTGU3MWNFaWxuZ3h5Wllzdk1KZFA0YzdpdHRxeDNDK0xxVW1ORUFq?=
 =?utf-8?B?cFRhRERTY0Z4Y2s4MFVRc2ZRNmxwc091ZWx5U2c3MmRNUmt3cFdTeXZxbXBu?=
 =?utf-8?B?c3RJZDhMZkhNS0tMeVdDTVNnMStFaUpGSEtoKzZ1bURwSVEvbUFnVnFCdWFX?=
 =?utf-8?B?amYxd3hvc3ErR3h5b05xbi9XVEUzM3lxeGhNdzE2MjhQaHQ4UkgwVEZuYmFt?=
 =?utf-8?B?V3VyTzF5UmE5aGQxZjBVWHlPcE9pQTVjS2Fra1RYM01PZFAzNzlRTFhoM1JT?=
 =?utf-8?B?cHZQMmlNZzVVZlVyaVF0SENVUXkwS3FsVkhPZDRYbmovdzlpU3ZzU1hISjdT?=
 =?utf-8?B?dUs4VWtPNC81M2tDNERTVDRDY3M1UTg4TmRVWVNBdTdBMG0yeEgyOUhkYW9s?=
 =?utf-8?B?b1plQStXOTJSTVZnTWFPQVhobExKODJDTW9mcnh1Qkhsa0lnZkN4eE9Ubnhu?=
 =?utf-8?B?MzkzUzNRQWFERFpPUjRNcXJ4SG1ESmtwczBYOGFZdDBDdTcrb3ozc0RTUFR1?=
 =?utf-8?B?eUxDUUV4NEJpU0NmUHpvV1krWU1ua0ZvMGh6YktTRzhaekxLTFJhdDh3eHpt?=
 =?utf-8?B?VW1WMmJvUnVDQ29teGtHbWp2dXBzVWRhb25xcHVHVFcyZC9waDBtVXllM1Jx?=
 =?utf-8?B?K3lnTG93SU0xeTc4NkozVXlBeFdYT3o0M0g4eXNiMHJyVlk5UkJTd2hmcG82?=
 =?utf-8?B?b0d5ZEhReXloNnVvSU9uWGw2Nm1VNXFmUEdwNFhnc3c4UVIxbi9ZS01aQUhh?=
 =?utf-8?B?TndWU2hNRDdUSVZCM0VOMVZsbm9Rekl2d205V0h4RG1RUGFiSVQ1NFdDQmNR?=
 =?utf-8?B?NVRFU2RjT3J6Wmpvc0RPbXlvOElJVFR6eFhUSXhrdG5CeU9oMFoyV21ZS1hj?=
 =?utf-8?B?VWR4U2k3ZExBZlkvcmpZMkx2dTUrcHlrMTVzYy9iZlZhUmtLMWdPVTVEa1Q2?=
 =?utf-8?B?UmhsbS90NU85Mk92Vkc1NjlxeTlMaE1MZzZ4N2Vqek9CWWxnY1kwR3JBd0Z6?=
 =?utf-8?B?MU5zenJOUForcEJrTlM5bk8veWhwbFFSdXg2YjlOS3o0YkdZSmlZOG92bGhY?=
 =?utf-8?Q?xlTpn2+26bsi4PnUMV0zTAXSe2TrSKTk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rnd5UDh0c0Q1ajl3TUljaWM2QVg5bGxnbTE5SXdVZElYSnoyWks2b1VycnlN?=
 =?utf-8?B?Q09oNUxocnlIZ1oyKzdGcVd3c1pPOGdlZWhkbU84UjRIVUdFTjVlamhJdFhS?=
 =?utf-8?B?b0dzeVRDM0t6QVd5K2RuazJnaFVjUXkrOW9OdmFPMnJ5UUJRd3ovSHlFbU5E?=
 =?utf-8?B?bStQTUx3MHNrTFRlUHJTM3BOSUNHYTlRbnpBZjFxUVVxQVAzSHFsK1pBWWpH?=
 =?utf-8?B?M29HYzVmNWhSelFHdzNRZXlOUGk1QlpjZXYraEUyWHFpaDZERHNsMFMxVmJE?=
 =?utf-8?B?Nk1OS2xoZTZKRXJzdWJxYWRqZHZlM0pFTGxMYnBVb0JXWExyMXVjNUl0bllJ?=
 =?utf-8?B?YU9yVXkwamtFVmN3K1l1ZnlIUWw4TVBUYUZOb2dTTS9CSkk1T2NHcXpIMWgy?=
 =?utf-8?B?dW1aSjk3bmlsclU4K2N4bitEMmNZNzl6aHA3dElNRkxhaS9Bb2lwb1ROeW11?=
 =?utf-8?B?OS93M3VWaS9jQkNob1g4dHNreFV3WUZXRVE2UGt6WmtZWjZPQzk5T3FWY3RK?=
 =?utf-8?B?cGlSZHk3cWdnSkFsdjViTXVsZ1lVYWV1TXYycUFuWkM4aWdodjIrVlVxclJv?=
 =?utf-8?B?U1M2RGVMcmd2c2FIYUtEdEMzUGN0L2NvYkQ2NmJXdUxCcTBTell6ZURHSzlH?=
 =?utf-8?B?TmlCaVI3N09iRW1KdmYxQWZSRTR1RTBOSzlpV1hWTWtQV2x5Q1NNSzBzUitm?=
 =?utf-8?B?ZXFYR2JOL1BIdVZEdkxYdVNwVVJYYXJmMVJVMXpwTFVjL0JhZkxrY1ZMUUJJ?=
 =?utf-8?B?cVg5OUM2Sy9ERnNxeG5FSzVKZVJiT2RyQ1pJOEdWL0lpcThQM2tYYm83Y1FN?=
 =?utf-8?B?YlQ3WXI2ZlVReng2UWtweGZxdmlBb0JueWVSaG5QNE9wYWhDcUNOenJNWTFy?=
 =?utf-8?B?VlRUd0hKMVlwSWR0aXNNc09YaEJ4V295bnNQQk54WG0yRDAyTDlRM2xBZzd4?=
 =?utf-8?B?NXNneTRvMjNmcjNYQS9Ob05KQ1hCNHZ4ZEpWZnQ2Q3R2azR4RCtxb3hQNExz?=
 =?utf-8?B?ZUFTandkZVlyWElTbW1BL3ZHMXVXOVRQMUVtZWdZbFY3amtlQytDRHVJOFNp?=
 =?utf-8?B?MzJwSHIxcjNIaHUyRlFkL3p0ZUY5Q3R3YWJ6VVRTWlNTMDUxVGx6NUdiMmRK?=
 =?utf-8?B?Qm9rN3hrUDZSYzNUSHBwY0x2cVVCSUNRanlBazVhKzkzeGJrVmV3RGNXN1FJ?=
 =?utf-8?B?NFJVQmxSc1NUN3FUb0V4ano0T3ViU1FIVGlOcnZUMy9oSURjWkZTbGtrY29M?=
 =?utf-8?B?MDZhRENvaGZISXhEbmUvUTJNVnVlQ0Z0Y3I0a1Vjd0ltcThEb1h6b1RsZ1ZL?=
 =?utf-8?B?SndSOU1jaU5iOS9YRnYzaUhtMU5kQm1iN0tMSFRzT095K0tVeDRuWDJQdU9u?=
 =?utf-8?B?KzQ3eTBuM0J6MWNsVlBHQ21vY1pScFZPWTRnaTczZlY5YU1aMDRhY1RvZzN5?=
 =?utf-8?B?Z053eTFoWDRyd3dFbWlaWEFweWUxN2pRaGRNY2xZdzJLSlFoVC9oQTdtWHFR?=
 =?utf-8?B?a0ZVTmRyYS9pVHV4c2pkREN2WUlJZmJ1Z3lqWDlHQk8wU3RBM2JYaysyZndO?=
 =?utf-8?B?RkZPYnpMUHcwNXhXMWV0ZElPQ0FMdTRpaVJ4RG5SYldRNFNDTktCYXptQmFW?=
 =?utf-8?B?OVRyVy9sOXJVS2VEelB3QmYwYTE2c3NzN2pkYjFpMlp1YTNuNk1Pa3A1c21V?=
 =?utf-8?B?SGpzdW1TY3RKUVJpTVRhS0kvaGJrZW9Dcm1RbGRGdGtRc0RwdzJXNTV5NGtH?=
 =?utf-8?B?QW16dElmWUNtRCs0ZEpWU0dKY1A5bVNjbjFSanZ4R2hoM0NkSVh6RkdERHY5?=
 =?utf-8?B?dTQ0cUdmeFRuZ1lHblB2Q3NJbmpSU2laTDlwOTZ4TzFreFVvc3dEd2VqMC94?=
 =?utf-8?B?RVhlejFsdjd6amtJVEFDTDY0N1YzNElmMjRTMEdMc20wbHV1YXM3YXdBWmZn?=
 =?utf-8?B?UFRBOFRpZFZOSEk0Y2VXbUZyV0dobjZieFZlWDlRL1c3aW0xUmdIYVBiUzJM?=
 =?utf-8?B?eDc2NGlaTTIzSncvRG1tL2ZwSmdyb0dPbzRiVHJlWHhDYSthWW1jc1VMU1lG?=
 =?utf-8?B?czFKUHhCRHZrU0QvZWNMQmFMY0VsNm1pNWxscGpXT0lueG9YcnNCWGRRNzh4?=
 =?utf-8?Q?LDhiEzcR8ezuwDwFLImxkCiZN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078334a0-fd5d-4536-64c2-08de39d9a3d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 23:53:25.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOeNOTc2hWzZ3gCN3D/QaH+wW+21QUlSNi00tI7LpN6Cm6U03tt8OLY7D+LcJ8B4ujshjHUNV9n+0shuQ5cB5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

On 12/12/2025 1:06 PM, gregory.herrero@oracle.com wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> From: Gregory Herrero <gregory.herrero@oracle.com>
>
> On code inspection, I realized we may want to check ring_len parameter
> against hardware specific values in i40e_config_vsi_tx_queue() and
> i40e_config_vsi_rx_queue().
>
> v5:
> - use "hardware-dependent" in commit description
> - add Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> - get rid of i40e_get_max_num_descriptors() documentation as it's self explanatory
> v4:
> - remove u32 cast in i40e_config_vsi_tx_queue() too and don't mention it
>    anymore in commit description.
> - wrap i40e_get_max_num_descriptors() description
> v3:
> - drop trailing period from the subject
> - reword commit description
> - remove u32 cast in i40e_config_vsi_rx_queue()
> v2:
> - make i40e_get_max_num_descriptors() 'pf' argument const.
> - reword i40e_get_max_num_descriptors() description.
> - modify commit description to explain potential behavior change.
>
> Gregory Herrero (1):
>    i40e: validate ring_len parameter against hardware-specific values
>
>   drivers/net/ethernet/intel/i40e/i40e.h             | 11 +++++++++++
>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 12 ------------
>   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 ++--
>   3 files changed, 13 insertions(+), 14 deletions(-)

Sorry I didn't notice this before, but I'm not used to seeing a cover 
letter for a single patch. Usually (always?) cover letters are only used 
for series (2 or more patches).

Thanks,

Brett
>
> --
> 2.51.0
>
>


