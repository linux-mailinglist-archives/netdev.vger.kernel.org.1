Return-Path: <netdev+bounces-203802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C424CAF73FC
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8701C85A32
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF8F2E54B7;
	Thu,  3 Jul 2025 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D59kf0jO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2A2E424E
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545374; cv=fail; b=SO0rQdM5Pos7W8D/mR7xjAgCBFBSVDp+yQckrGwqxcMDz4v2kSl1llL5/yW0k3Csl0d7x7X0d+K2BMMQBTnM1hztlhT1D8NcYc5swvDfLPuuk9buQ+GBDkIIS3wzZNvJ1JA5/NNL6VRf1oOk/5+8Ibd9fgR8r9OtWfeHNmSLvjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545374; c=relaxed/simple;
	bh=G8zLFYNjLfE/vGMe/iD85MiKWoh2agU6AwLLuG+HOJI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=knnhxGoiHuEPw3rZARkI3izawXISBMnsLWyI5m/vPOHB7p+/BqBrTpUQdQs2kkPOdazM0CL3y6Cz/aFLKVIAZwJERg++35fFz1UjvwgjZSeVb7ayUgxUAa/VNcmKetPT1S0aAOEo+08rTrGzS+6J6Njbk/YANwxQUPgfzLtNvH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D59kf0jO; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnUB3dnwtDwxH1j/2oZnAwEpYKlEF+PLU3+SgyDhzYiPrRqHCTPhJ62kKBWLmuCfRp+ro0J0mKS7siu2XPNar2BfbryFquU8n1nnf0SBTIvbHs6+R30tDJsR62ggSwpkoFEmVFkG3fzlgrhGD/A+8GZF9YVeQi2yzrpJORuspwIvDQDxF6bjNGBzrVQxk5Bjkzdg5UIiGiRiv359kYmKvPYvG4dItSMA2iAV3lDgfKB3VIj84aABGUCmYKF4PEHaHCOfRJnyO/AKHMbDBJhiYv6Kx/y71fzo48NJGEBAOI/XcJrStIARLAeXV0hY6doc7/NJuJ8D8IzZpO2MsfFcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HH4HT6CgKwdq95w19ZXUKt+B08/VlfOIdvwVbXedts=;
 b=fLf6JJs17uXz5Pvs+Hk4JfmJba3Fz0nxp5mawmzbvvjijuo8TqKGW50DUpl6NNvugD7Ebnzcm4Wo5aaik72fIDEyoEbA5iTZU35CObAEWktSjN52FJcnD1VSFUd5KiVIAKShUrohcgpsqAxEKN8EuKxiaRhAOvxvtQPIIEFYeRPrjYsy90+pXzVZUZhGTzibkuyliu1Mftq7OhlbZQaN05fklYzD3OVJ5y/ZYRUgF40pJ74SDrx82NsDXvEhY1BWgrIpe6MpPE4NGpd9EkQofbRwgjFypcl24bO9i6IRb0m4PzexOHAy2tFffkjg9VsW0K0nCnGXiKq251arXMYZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HH4HT6CgKwdq95w19ZXUKt+B08/VlfOIdvwVbXedts=;
 b=D59kf0jOQ1d+G7F31V/PbaZMfPzGCFNDlugOli8vk/DKP6hYBAqsRMlOC0//wD7v31RIjVyL6NyWQZxX2kB0+CG5wxEAsScKoIBTc/rVb3COaDjmqOnxUMeCCwMbOSjdPLAA8EPjvP4IIfxZ8tnzguNH6Oxe3HVfFeeWqUVYGsimYSJnms1lelyQz2qix+qYTHXeiLBOB+PSpsG+u/X4k412SwgDtx1YQp7IZnGxIcKAxo7cO17A3kUSGvbAjON7hAnjo6QyI0nsRU40PmLVLsCs9ith4Wuq8PRSHpG9IbN1x8PJtXhXinfoVbfTdYWG0HHW7xPYkVn/YmQwyxyRNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 12:22:47 +0000
Received: from IA1PR12MB7496.namprd12.prod.outlook.com
 ([fe80::8a53:2522:9d01:ec41]) by IA1PR12MB7496.namprd12.prod.outlook.com
 ([fe80::8a53:2522:9d01:ec41%5]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 12:22:47 +0000
Message-ID: <b5f66ba0-7d1c-4228-b0ec-f62aca289b23@nvidia.com>
Date: Thu, 3 Jul 2025 15:22:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] eth: mlx5: migrate to the *_rxfh_context
 ops
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com,
 leon@kernel.org, ecree.xilinx@gmail.com
References: <20250702030606.1776293-1-kuba@kernel.org>
 <20250702030606.1776293-4-kuba@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250702030606.1776293-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To IA1PR12MB7496.namprd12.prod.outlook.com
 (2603:10b6:208:418::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7496:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0dc8c1-ded3-419c-1db5-08ddba2c51f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnRrQTV4OWs0L1JFWS9Ebi9kNWdXc1Q2U0crdHBRczRqZmQ4cS9sNnh6THdn?=
 =?utf-8?B?dSthdXlIKzMzYktKWXYxT3hhRDZaZUplUVZ5cGNBMVExZ3g1SkZCSFZEamxU?=
 =?utf-8?B?VzFRc3RNQlNaQmoyMGZ4TE5mL0dhcDBIUFZNdUpBMmhwY29NMmhzWTJHYmJC?=
 =?utf-8?B?empyWTVoZUE2MDlRMzZ5QzFSMUoxWUhaV0lJbjk4Qm9iSFRBbXl4OW8vdnpn?=
 =?utf-8?B?L0dMRmd6OXpjdlhuZVVzbGhLbVZ4SG54V2lDdWszSmxxc24zRW5lVUtQcHph?=
 =?utf-8?B?enIwTzlPVXUyM1BhK1ZGRmV1RVlObS9tbW5JbjNPOFZaNG41alMzYVVUMnJL?=
 =?utf-8?B?WlBTN2JTbm1yOHBFRkVxbklFbjNXK2QvS0UvUUI4Q0lMOEpiOUVjak1Kb1pv?=
 =?utf-8?B?aFJqMDhjK21ia3U2Z1lJQk13TUlnb00zNklXdFF5Y0lpRlJjRkFPaVVvUDBH?=
 =?utf-8?B?TVBOMUtOYzJBMW1lK3pEUkdWTkVKaVdUZm5oeTdKTlhMbTdGYU1NdGlRaWxk?=
 =?utf-8?B?VlNZVkFKRG9jM082MEEzdjFacWFSZ2RGdUpPWDBXQUpzaGtxSXJZVG42TUJ0?=
 =?utf-8?B?NHBGZ0QzR0U1NmhlS2lyT2c0WUZjL2hRVEdXTWxMMHlWLzR5aDdHMGpBU2xT?=
 =?utf-8?B?Q2tTK1lINnV2QlE1aXJuRnk1MWt2aVJoeEN3bXlLTC9WMzIvdXZFdTQzNTcw?=
 =?utf-8?B?anphcUZkWUZyR3cxS3NCdUxYZGVvYUlOWjAyZ0MwL3FJa0VZdlRsajV5dFdJ?=
 =?utf-8?B?RmdyV1hCekFBcC9EK1lXV2NLVU81dGZrd2ZZdTRhc0ZyVEF0clU5NnFaN05F?=
 =?utf-8?B?Y0c1bmd0WjdWaGpNNU1OeUNNc1hWTmFUS1BLSlR6ZlIraGcxbFcvT3JnVnBT?=
 =?utf-8?B?Q1pnM2hnczlkWE02YTR1czVxaDdHcFYybWpaUHJPODZsRkhTK3oxT2FMdDZw?=
 =?utf-8?B?SmcvNXRhV3k3eGhpaCtkNlZFRTJNWFIwZFM3cWh1akNtM0FwQWszaGdFY1U1?=
 =?utf-8?B?VkF4QWxpS3FHcGhTMlJUZ3dFWnYvTmJtVEZzSnBMdDVxc2pTL1VFTnZTODJ6?=
 =?utf-8?B?ZmgvSkF0akthakxBdXNSei8vcmJDRStGSEIyV1Q5MG0zSmZOVXJJc3h1QVRO?=
 =?utf-8?B?a0tTcVhlWElSZm5BdXArVm1IeFFRM25ER1lXTTRtYzJHU0tRWjljZFVPclpV?=
 =?utf-8?B?V2tvWHlXblQwRy9RakhNN1VCL2VaempVdS8xTncxS2oxQVZoZnZ3aXNiOU1p?=
 =?utf-8?B?ZjFDTjN5SkVRZVBuK2RnRDJkQTlaV2tiTWo1N2RUVUhFZXBGNlRjbE5RZVov?=
 =?utf-8?B?M1ZJZ3dabDBGbHQ1UkJOUzNCRER6WTV1ZmNUS3NJeTBYM2RzNERZek5ZQVdt?=
 =?utf-8?B?N3BYRkkzc2gxcENPNUZZQng3M3VvNmV4ckltUHhhUWNtVzNxekRpYi8vYnND?=
 =?utf-8?B?Q1loeTVod0RYajJQZFowVS9NcW5KSHEwY3ZlYlNFN2N4RVl3OXoyRDcxMWVn?=
 =?utf-8?B?S1hDNHFoeTFURm0zU3h2NWUrcUxEUTI3VVk1WVhvcUpFK0lNZFQ5d2E4MzRn?=
 =?utf-8?B?ZGVnZTlwY1hEc2VXRG1OZUZDVGVaVFg2TGJGOWV2NjNxRk5Ea3dvckIrT1F3?=
 =?utf-8?B?eUx1ZlVyYk1VUER2dUUvcjZvWWtoVnZzL1VOdHpyS3BqSjNGb005eTIzbTN1?=
 =?utf-8?B?aThRM0g4Z2FLeFBnN0xYMEJ3eUpCazJNZVRkZ2Z5RHdBTVJVVnhleGZEMmNW?=
 =?utf-8?B?blgrRUNrZ0FxQ1M1OGdRSWw5Z0VLNWNCcm9wTDV2SFhESjEveTMrekdJL0dL?=
 =?utf-8?B?SUV0WGszTHdTT1V4YUYvYjcxcVBIZlFSNnpVeFdJNWhNcDRncm0zNHNDZjJa?=
 =?utf-8?B?ekY5WGo1aTFqM1hiS3dlekxIN1BGdjNPSWRBL1dsQ2Yvc1FjN0xyM3VjdFRR?=
 =?utf-8?Q?i9qXaYkemPY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7496.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGhyQ3pzNVorMDgxWmdwN2NsUFpSMG1leXA4MVR6dlJTeC9mN1NEUU9JOEY3?=
 =?utf-8?B?ZUFQNFV3NEw5VXhMQ0JGZFdHU2FadUsrUjVtTFh1UUhtUnl4R3BCSFRNakpn?=
 =?utf-8?B?OG9INW5Va3kxT0dXeWpHL3p6eEVlR2s3UXhnN0J0aGNGQU9Kc0U3dmV4VzM3?=
 =?utf-8?B?Ukk3Z2UrWVBLb2RheGExRFFlNnpIeVFxMWdyZjBIbmxnSmpTNnBaam8weStS?=
 =?utf-8?B?ZnBCTENvM0tQVnByUUU0eDQwa0V6a3A2QUd1c0hDVTdTV2xaNGhRM09PNmRQ?=
 =?utf-8?B?c0hSejBFd2gydjhTaGdlVzdza01xZ2NzbkRqZENzTlVsNm5hTlhYcEh1R1Y3?=
 =?utf-8?B?OE9BVHdYOXNwREwwb055bGFab0lOMXNWcGkyN3J3Zk93ZStmUWpBZ0pFVDFU?=
 =?utf-8?B?eHpCaGxva051SjNIWHlsT0k4MU9UUUw3eWVrUXVpUGgxeUgwaGdMMDloVldt?=
 =?utf-8?B?aktKN3FKenlGV0JyWWxUdGdIaXNUajZpbEIyWmh4VEhVN29HRDVpTExmMEVF?=
 =?utf-8?B?a2c4M3JnNGJJMEJHb3g2Qm1MREZ5Y3Nkdys4RjV4ZjRtaHZCcENEdWI1WkN1?=
 =?utf-8?B?NG1yY2svdEZZd3g2bUJtem1EQ2xnd2VQSUVsaFk0aFVTbjE1dXZZRGJoZEdT?=
 =?utf-8?B?V0s1Kzk2MzB1WGtVVFFjWklkZEdpUFBmc1orNnNnUko4Z0VCeXBhY1U4aWxE?=
 =?utf-8?B?MlRWNzVJNGEyUGNla3ppSDRLUlNqUmsrTmwzMG1kYURSUThCeTJkM0pEQXNv?=
 =?utf-8?B?WXE4V3IwdndzY2VCTVdVck9sOENGbjUvYTNoY3VDZE5lT2ZwSmZrelR0d0NH?=
 =?utf-8?B?RzBQdEpNbmpIZVVva0Fkc0JUajhtYnBqWkF0aHdHOWhDMU5vM29QZi9rUkV4?=
 =?utf-8?B?aXQ1Y0Z4SEU5VnM4dFV5QklpSllnWG0wTU1ZYXUrd1dzN1pveWZXQ1N6Uyth?=
 =?utf-8?B?WndTTVlDakV2Z2xIS1pQTVJ5Z3FSQXc2VXo2Sk9uekxVSmpiaGhmbERad2pm?=
 =?utf-8?B?MkY1WVNQc1h4cnVmeDUrcVRwRFhKR0dadjRhYS9BUFphVHB3R0x2QzRDeUJG?=
 =?utf-8?B?SEpEQ1AxSnJBemRvNm93bml5QlZXQjR0ZlEvRWRZdXJ0L0RVUmxXUGkvUnZW?=
 =?utf-8?B?QU9qaENrTXN3R28rSlN1MEdJMmRxUWpDbkVWK1ArNnV1QUFQK1VsRHkvWkVo?=
 =?utf-8?B?ZENpejdlOEQrRU5WT1NaejRzbzRRUFV5Y282NDluL1J0WkkzanZpYzNxS1Qv?=
 =?utf-8?B?SW81T1NuUzg5ZCt0d3BhOUJqVHYxM1lkZlo0OVNsNmxiUnRqYm56YnllZVpF?=
 =?utf-8?B?WDhCVzNOTGlyQk1rVmZaZ2pBVWJ3ZVBrUmZhbHNRV1JOZDlJN0F6dktROFVN?=
 =?utf-8?B?eFBzQUs0N1JDVFBNTE1oOFJvSExadUlJaGs1emJGemxQNU8va0Yydk1CaFhk?=
 =?utf-8?B?c3VJbWxGZ3dTSzBpeWZEZlA5OGdobGxMejAwVjRKYitPUHAvWWh1WWVHK3Ft?=
 =?utf-8?B?QnZseDRMWTZGVEJXZnBIS0hvQ0wySmtidXZkdEJKeFl5VEI3cjBpUHRlbEt4?=
 =?utf-8?B?NmxaeEk3QUphZUlITTdERk5UVFozRGVPdmQwMXk1blIzVjdKUW04T3NEQ2FK?=
 =?utf-8?B?Z2xLS3l0bGtDQlNrU3licmdaWHY1YXYvcGxkc2RHZDE5WkJINHM5VWViRHJx?=
 =?utf-8?B?Y2c5b0FtaWRjYUtpUHBZVDc1VkVBOExkc0IveEIySFZtZjdlQkZ2ejZ6NkNk?=
 =?utf-8?B?emtXMEswRklKSHNxSEtEbmVjYUhTcTlhaTFNdGplMDNQazl0T1BqVElDUkwv?=
 =?utf-8?B?YmNDUlp1U1NFMDh0M1F3NW9wSTc2d2huaGZ1dUJCejhQQ0JZVVhySDkwV0FD?=
 =?utf-8?B?VTViWW9lMTliVEpieGVoT2F4QVlBeUhDbGNLOUJaNFoyaTFlYUV6TzhMeXZR?=
 =?utf-8?B?cEVGN3RSKzB5ZHpXNFk1em9qL3NVYjdBTCtOYWw4VFdIazVIdE9KVFYzYmpZ?=
 =?utf-8?B?S2FmbkFJVmk3QmJ3ejdEdkVYUE9rUnE0TjBCZEZxaXdGYUQ4bTZhV1JQYzl0?=
 =?utf-8?B?Uk0xaDNEbFROcHU3WUtjeTJnUHFzUmxqK3BOV1p2aDJEakF1SE13V2NnNWx0?=
 =?utf-8?Q?uZJQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0dc8c1-ded3-419c-1db5-08ddba2c51f1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7496.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 12:22:47.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ePs4yyCpmlq27BwCBPERECBhGOj/pUDlm/AwSbNkyMKACoNSydPBdpeae1TqdJ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056

On 02/07/2025 6:06, Jakub Kicinski wrote:
> Convert mlx5 to dedicated RXFH ops. This is a fairly shallow
> conversion, TBH, most of the driver code stays as is, but we
> let the core allocate the context ID for the driver.
> 
> mlx5e_rx_res_rss_get_rxfh() and friends are made void, since
> core only calls the driver for context 0. The second call
> is right after context creation so it must exist (tm).
> 
> Tested with drivers/net/hw/rss_ctx.py on MCX6.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - remove hfunc local var in mlx5e_rxfh_hfunc_check()
>  - make the get functions void and add WARN_ON_ONCE()
> v1: https://lore.kernel.org/20250630160953.1093267-4-kuba@kernel.org
> ---
> -int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
> +void mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc,
> +			bool *symmetric)

I assume this doesn't compile, you didn't remove the return statement at
the end of the function.

>  {
>  	if (indir)
>  		memcpy(indir, rss->indir.table,

...

> -int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
> -			      u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
> +void mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
> +			       u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
>  {
>  	struct mlx5e_rss *rss;
>  
> -	if (rss_idx >= MLX5E_MAX_NUM_RSS)
> -		return -EINVAL;
> +	rss = NULL;

Nit, would be nicer to initialize to NULL in the variable declaration.

> +	if (rss_idx < MLX5E_MAX_NUM_RSS)
> +		rss = res->rss[rss_idx];
> +	if (WARN_ON_ONCE(!rss))
> +		return;
>  
> -	rss = res->rss[rss_idx];
> -	if (!rss)
> -		return -ENOENT;
> -
> -	return mlx5e_rss_get_rxfh(rss, indir, key, hfunc, symmetric);
> +	mlx5e_rss_get_rxfh(rss, indir, key, hfunc, symmetric);
>  }

