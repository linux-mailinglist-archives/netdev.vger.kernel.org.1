Return-Path: <netdev+bounces-105109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99A990FB89
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 05:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA961C20DF2
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 03:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB01D556;
	Thu, 20 Jun 2024 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="KtSofEPs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2097.outbound.protection.outlook.com [40.107.94.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8151D52C;
	Thu, 20 Jun 2024 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853026; cv=fail; b=tnvh7Jvijco6ga/ZLV16O+Sn1lZsvW+/A7u6Kk6ftTjKrxs54gnxny8JFov64RS/m+GQfpl59FgvozTH0/LXb6hjOVs39pjj5k7+nAL6oHmNkeGTfFD5ucx8MTwBr6rOh7OLiorTEFiLCwnHZGlwyezFdZKYxrubN5VIqr+0UnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853026; c=relaxed/simple;
	bh=+7l0fXg83Ytly7/OT7WvnM3YAMDxcxRIPE3aZRBDJd8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aqwsj7QSRbl+crOo3Y6KpVFXkTRaQtrZioO3t5AvPWjiujwthI4pvmPnrL/thBTJiGAtSTXvuuK5OsWK089zODW+6LHFyK0VwPvUd/X05JUKpSb1QamSkDwcemYtb65xaYP2NAqhawaf6evcOqxYhY2DBdE9I40bGxsmSvKRigs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=KtSofEPs reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.94.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwcymbGxP/lDCK4ojZdldQJ+OHkZRQGhcd7FUOn8sXitGqhzQYcViflnH0NTQy5JykxtoBr1oKrgdwYE0aEgsau/PiGrhKgfbg3xZtst5+dPEY15k5z0UavggOLRxMpes6meunK1izVpSgmWTi6vhrxqMQQSJDYrt0+M3nfwBUnjSBn29lcbXXo4d3lm4VUu6cL7GetPTCA3E/5dTwocGq7M3HzIqqZWvyeAWMP2dkJ5jAo4HQgOPOm1SWivS9lL2qmzfmAcdb8ZoYQqCpmAlDILbAgSSNA+eo5ftB5609b1VKLoHZTmwmlyjNP9PgQNPkhMLyyOu+el0gc3lemc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pThxDCkzMK+IfSq9+cVdr+3JZaQQEtObL9Hd50UW5o=;
 b=NKqlXZP6IpImjG7G/fEsTe880Q6ZEpzMi4YsO09Cp3gXE/PDIS8wNh27mybt4UXp6ZCKTwxOUMzDWw/DZCm7NLZnZpens8Enfygk4AgQij+Zp9yqHwaBonXOTFpKYW04Ydw2OIs+QHQ8umUyHvPTJGYLQf5qMrvbdbRpIHSriDU6FUlVQgn4/8EQR7zxutQGUwKI76/Jm+7GVjgM+Z7mvljl1VgwQs7GODMFNwPOljjp9WSDvet9Et0CzyIRdgjYOASZbKuWSNhSKclIWn0vDmc5a+ZXPTiTF5rxa9tNsO5PLBnfIriRmUI4UYHPZW6pXJkFqo9TjrqUdpRi6Ay42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pThxDCkzMK+IfSq9+cVdr+3JZaQQEtObL9Hd50UW5o=;
 b=KtSofEPsk2QJynCu4WmTQ0ffzvIDVk+lrT7F5OeoAOgZjpvrggkEZ/PzkRmQhojBmvPHu0TwM2cR6nGaUtdqrH5uRT0NC9CmqA8qr6mLKJNSvpzZLgKXevGd7IUVjzKIj5xHjozxEZab600ebKBVig+PRQMMFGt8STOBb5p/qEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SN7PR01MB8066.prod.exchangelabs.com (2603:10b6:806:359::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Thu, 20 Jun 2024 03:10:22 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 03:10:22 +0000
Message-ID: <8922781d-5f12-4590-af41-b17d83836d19@amperemail.onmicrosoft.com>
Date: Wed, 19 Jun 2024 23:10:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] MCTP over PCC
To: admiyo@os.amperecomputing.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240619200552.119080-1-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20240619200552.119080-1-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:332::15) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SN7PR01MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: a6cbb5bf-b98d-4c0d-a2c2-08dc90d685a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmtOMjBRQktrdXhiRE5VVGpCOW50VGpyWFQ5ZksxMjA2WjZUa0tpZWFjWEJh?=
 =?utf-8?B?VzdFaXNZUXEzWHpVZ3FBRytFL1pDS1J6ajc0dGtsa1duTldrazk1YWxlR29r?=
 =?utf-8?B?UE9jd3RyMDd4cTBWOFh4SW0rMk9vT0RPSWRJVE5vWWVDODhlM3dhaDBTNmcw?=
 =?utf-8?B?by90aGE1dlJOOUI5ZnBMQ1ZuWDZiUmdtNzlPaG9XZ0VidHNYdU9vU3l4OWJL?=
 =?utf-8?B?SWRZdTEzOEFGQzB4WWxVZkVCV0FPbjJ4VmI2YVVmakhsbThGRW9qRXUxL0x5?=
 =?utf-8?B?U0psdzFDNFJrMTBVRnZJK052aGFtTjVBVWQwc3JIYlV3WE5CeEdyd016RUJF?=
 =?utf-8?B?M05NazFhSU8yc1dDNFpKcnY3OVJ1TTdGcXRaNVdCWHYwOEJTaFhodjl3N3FF?=
 =?utf-8?B?VXdqTlFOQVU5RmFUMEVrSmFyV3ZvcDRzbERYekFxam5lT1RQQXREV2IwNEVo?=
 =?utf-8?B?YklIOEVVWklSN2o0d1EzbzREdFZqUWJZUjFqZzlBaUg0UXB2dDNoeWV4T09N?=
 =?utf-8?B?Zys5RXhFeDY0QnRsM011eXoyNWJzZitzYnRLaDFRV2pBL2QxdHlxZ1ZTMkFp?=
 =?utf-8?B?RjliRFNXbWRhaXVvaEZnK1lmcTBlbU0yL00vcWVTcHlFdzlWekRPMDBRMzBu?=
 =?utf-8?B?RHVUTElpZGVVbmpxR2MyRzJPTWwvaWY1M3JqWTkzYTZyZnVHalh3NHFZTXBz?=
 =?utf-8?B?UUhVVStCc2JXRXQ0elJpSFE2Sk15VGlWMFZRUG5JYUl5L2FXa29TTEdQN0Va?=
 =?utf-8?B?Y21lVlZoaG5RMGo5elZnVVVKRklqd3Z4dTlsTWVLVW9hVkVGWmU4NzFSK1FF?=
 =?utf-8?B?TGFicG5ZU2hFUG1vNEtiL3lpcGhON0IvcG1rTGVKQTZFNEFGY0ZSVFZydHRl?=
 =?utf-8?B?Y0xHaGhqUnZXeFdhY2EyZ2R6Rjg5bmUraTgvL1BGdE5TMXZvMlFLM2xqL2xr?=
 =?utf-8?B?WTgwSnd2ZWRwNUcwVXFqbDd3OElTaHJEL1VPWC85NDZJdHM1UERNZGZNelhs?=
 =?utf-8?B?WnpHUnBrb29vYkwvcUUxQUxKdmhHUzg4bWp1L2lhTThsYThCRkZIQ1c1S3VC?=
 =?utf-8?B?T3JJYVBCam9Rdm5kZ2k0VjZsMXdYaVZpK01HSWxPdU5vdS90eUk5NzBCRTd1?=
 =?utf-8?B?Qi9LT0d0alVUQmQ5b25iUERWWk5ObGVpeFh4UHRvNEZPNFFhYXdjbGRiQjVK?=
 =?utf-8?B?Qm5hMGdjd2FjdDloKzFGczNlbldFQzhSOVJpOUJ1WTRra2lKVlk3M0dlY2Vv?=
 =?utf-8?B?TFN0RHBKNjhCaElrV0FWNVplZ1ZPeHQ2VHBiV2NJNUdaVUhQVHpxNWlwQml6?=
 =?utf-8?B?dHNYWGxGaURvQnI4OFJFaXI2eDljeUkxUXVLRWFIU0g0cGpjeWlhOGN0TE9O?=
 =?utf-8?B?MkRoSjhuRzJzUEdRRWNkVlFNUkxPc1pGTExDQVlIQkJoWnN0a2ZZSTk2Mkl3?=
 =?utf-8?B?RjNHZEw0S1ljWGJkWUo2WHZLWDlVaXIzYmRpWEtoOExrOHJJR2YvVVUxVDVO?=
 =?utf-8?B?bWVGaEFQWkx6Rkt0T1BiZVZ1U040V1BBOXhFNzlHRmFndDVmNG8wWjdSaWdZ?=
 =?utf-8?B?aGFzRFVwY3cwMHcreDJ0V1ZKZUMvWW5MclBPdnBmZ3VkOVZPeWxiY09TNnFH?=
 =?utf-8?B?MVJGVDdWUVlhYVZ1VmF2dkNweElLRWpia0M3QXlaU2NKNGxHWGd5cGxzZ0ph?=
 =?utf-8?B?MzVTb1BkMm1vOGhNNlRaWGJYWk1FOVVZZktDcnlIV0JJYnV5eFVwc0x6KzJj?=
 =?utf-8?Q?OozDDziDVC1psSDtmqmV9fjE5DRtYrtJSRSTzdH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVJtWm5uZVN0a3hzTHdRU0NUd1hDWldaSE0ycEQ3NzVURkZGRGIrSU1IVU5Y?=
 =?utf-8?B?empmTDJxS1VzQ09VaDBQV3YvYzZ2UlRFWWdQMHFRZ3RtTXU0aGsyUnpjRmFq?=
 =?utf-8?B?Wit6WGQwMVY1NXlubFFjMnpRd0Z5WFZZTHo2ZjhrQ3p1S2dEc0g1WlZHcStR?=
 =?utf-8?B?VzNic1JMc1VMSTREbCtMbVYyREhmRHNrdFF6aWp3dmZMZlJuSnI5RUFhSm5V?=
 =?utf-8?B?Y2s0VHBNNUFaTTNtdU1BMElXZFZna3M4Ym9jWTQ5akZVSlZENkVsbEgzSmtN?=
 =?utf-8?B?cENLbUZCYlpQaDlsbEl5ajI0WTlSYzYrWlAyUm9kWEdqVXA3M2tTcjFRcitG?=
 =?utf-8?B?Y3BZemxoK05JNmdtVlFZUHJXTTF0NUVmenJ5cFNLclQyRWJnanB2YnFsazNF?=
 =?utf-8?B?YlJPbnBGaWZhUFVyRnJ5WDYvaDJWMmxmRGNNa1ZjdGMxS2Jjb2M5RkRFdGVK?=
 =?utf-8?B?ZkZTd1JoTStFaDdTRWVsSTB1YTZKUWhSNmtqUExQbEhtd3loY2dUL0FhTm9M?=
 =?utf-8?B?N3FiaWMrSWo3NTNLQ0p6YlBlc1l3WDNqeWthcWFBVDFkNytzMEJzNHdQRm9q?=
 =?utf-8?B?b1JKclNOalZLdmdFbDNFR3kzZENGNzFtWnpmSHdYa3FMMHFCdkRhTzFTWmNi?=
 =?utf-8?B?RmtqSnl6S2d6L0VOVThaQ0Q4R205MUVrSHh2RzhOMmoxQmJiRXQ2SUEwUFZ3?=
 =?utf-8?B?a1h1ZFVVT2RIcy9MN3pDanE1WURwRFZvQ2xOZ01KSW1SajJGSlJmU2h5T2Jo?=
 =?utf-8?B?NFJKMEFmTFlhV2Y1T2RoNnBxY29JbVNiazg0enBML1kzZHBxdHFZalZnMlNH?=
 =?utf-8?B?V1EzRk9MalljRkVxVHpkZGVHdWozQnVnZWF2WXVKdk82dUU3RkJnaGs5N1pt?=
 =?utf-8?B?Rkl2VCtnUVdoOTFzSTlOOHRENlhtdldjVVRhRE1XTUtiVUpnZTBnYldXdHBp?=
 =?utf-8?B?VU1XT2MzcDF5Q2NINkd3eDBvVTRhc09MNlVsdE4raE8xTDZSREVTemp3MFNq?=
 =?utf-8?B?eFM5TFB3TG5rOEkrOGVvZmErMDVKS1JoVktJTy90d1hIOGpCbXZNcVBla1I3?=
 =?utf-8?B?WGY2Z05tZnZDMlZqNlcxSVpJdFZnczhaUE9wZ2xKMG9Yck5XTXRSL3ZlTnVi?=
 =?utf-8?B?blNMOHgxVVBIcjNreTFaTnVJWk9wUHh4Y2hyc3Z1T3IveDZzajNTdFVOSkhu?=
 =?utf-8?B?aHMzcWdoRTJaOWNNVENrd2R3ejdVOUtDajVBSUx2Y1NMQmdoVkpwa1JlS2JX?=
 =?utf-8?B?b0VNNHlmQVdNYVRNdFRvZGdpZzAvTzRVMmIzRS9yNk4zdTgyeHArd2ZoY2FB?=
 =?utf-8?B?eGkwbzNIdmRFTUdOL1kyM1Rlak1ST2FtcFlzZGs5eWVVSnNwRU4xOUJLNUdz?=
 =?utf-8?B?b1kvdk1TcE4vKzc0anN2K1BNc0hOK3lpZXd0RjRWSTZoZUVUcGtWUXVlU2xw?=
 =?utf-8?B?bE9XMkRDUFh2RVowREdUOWpBZEdvMXVSdE03UW1oSDQvNXVRZ2l3RmRZeXVT?=
 =?utf-8?B?SEMySmxKOHg5aE5kUjBNUmxrcmtVSHhDUkJrMHdGMjBQSEI5QnV4NXR6ejE5?=
 =?utf-8?B?ZGxWTzU1dW9KZkJTb29QVEpveGhQcjJjQllVYWQrTkc1a1FuNGkxdnlPN2x0?=
 =?utf-8?B?ck1JTERVVXdrVnpOWGJsYWQ4bHRVeGdOYmNURElsZTVCU0FTcDRSNkpuVnc5?=
 =?utf-8?B?WjJxK08wMnFyYnl2MTl1RzY5ODljNkI0VnZ2NEovU21lTkt5aFdDTXdUUGND?=
 =?utf-8?B?dEp1TE5XYmdPOThCN1pvaUN5K2dscHVHVnpHV3c1cHFLdFliaCszTGpFNEFl?=
 =?utf-8?B?YjFiejBUck5aLzJ3Ny9IdklJYVl5SjBkK3NkczJ5dS9ub0dOTUxmck5MbGk2?=
 =?utf-8?B?YWFpaXAzdVlmU2t2QU9CZ29OTllsZlFxRGNTdG9CcUVnOGo2cC91Vmx4RjdG?=
 =?utf-8?B?RTdWbHN0L0hjNjhNVjhDcGE3V2RoNnhkN0pzY0ViS0UrUlU4dklXYklteGhG?=
 =?utf-8?B?RVdnbGhhT3ErSEdtd2lxRWl5K3p6Q3YzVTdWaUppQ2VSc1lheUZpdDd1Tlhw?=
 =?utf-8?B?cDRjVmkwLzJhWVZrSUNWR1Q4SFpkZ1dEelJjMWxIa0I2cFE5SWpBZXcxRzdX?=
 =?utf-8?B?V2gwYVFnV1NpNTVlMVB4Skp5N1VCTGt1MmhkRkgxenUrdU9OOVAvMDRqaW1l?=
 =?utf-8?B?dEtueTNEZjNEeWN4bFRBVVVBcjIxTU9sTVhBSFI5QjNwTHRDcHIrazBPNW9J?=
 =?utf-8?Q?4BLpclvFACsRsfyeRfMKW/GJA24CdDVII3MBZJR6nc=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cbb5bf-b98d-4c0d-a2c2-08dc90d685a1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 03:10:22.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bV2j/lU8238tET6Z3k0VBndPVf6bxexXyahZbAJxvCWx0cLXkdJe34BlX9cAOoMoEm7YCaq3FoYOoExP7qZUkf0pTM7TPPAoYN4XD/Wx5UEjagKRSvVugEt68omvTlgZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8066

Apologies.  I just saw that there was more feedback on the previous 
patchset.  I am addressing that now.

On 6/19/24 16:05, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
>
> This series adds support for the Management Control Transport Protocol (MCTP)
> over the Platform Communication Channel (PCC) mechanism.
>
> MCTP defines a communication model intended to
> facilitate communication between Management controllers
> and other management controllers, and between Management
> controllers and management devices
>
> PCC is a mechanism for communication between components within
> the  Platform.  It is a composed of shared memory regions,
> interrupt registers, and status registers.
>
> The MCTP over PCC driver makes use of two PCC channels. For
> sending messages, it uses a Type 3 channel, and for receiving
> messages it uses the paired Type 4 channel.  The device
> and corresponding channels are specified via ACPI.
>
> The first patch in the series implements a mechanism to allow the driver
> to indicate whether an ACK should be sent back to the caller
> after processing the interrupt.  This is an optional feature in
> the PCC code, but has been made explicitly required in another driver.
> The implementation here maintains the backwards compatibility of that
> driver.
>
> The second patch in the series is the required change from ACPICA
> code that will be imported into the Linux kernel when synchronized
> with the ACPICA repository. It ahs already merged there and will
> be merged in as is.  It is included here so that the patch series
> can run and be tested prior to that merge.
>
> Changes in V3
> - removed unused header
> - removed spurious space
> - removed spurious semis after functiomns
> - removed null assignment for init
> - remove redundant set of device on skb
> - tabify constant declarations
> - added  rtnl_link_stats64 function
> - set MTU to minimum to start
> - clean up logic on driver removal
> - remove cast on void * assignment
> - call cleanup function directly
> - check received length before allocating skb
> - introduce symbolic constatn for ACK FLAG MASK
> - symbolic constant for PCC header flag.
> - Add namespace ID to PCC magic
> - replaced readls with copy from io of PCC header
>
> Changes in V2
>
> - All Variable Declarations are in reverse Xmass Tree Format
> - All Checkpatch Warnings Are Fixed
> - Removed Dead code
> - Added packet tx/rx stats
> - Removed network physical address.  This is still in
>    disucssion in the spec, and will be added once there
>    is consensus. The protocol can be used with out it.
>    This also lead to the removal of the Big Endian
>    conversions.
> - Avoided using non volatile pointers in copy to and from io space
> - Reorderd the patches to put the ACK check for the PCC Mailbox
>    as a pre-requisite.  The corresponding change for the MCTP
>    driver has been inlined in the main patch.
> - Replaced magic numbers with constants, fixed typos, and other
>    minor changes from code review.
>
> Code Review Change not made
>
> - Did not change the module init unload function to use the
>    ACPI equivalent as they do not remove all devices prior
>    to unload, leading to dangling references and seg faults.
>
> Adam Young (3):
>    mctp pcc: Check before sending MCTP PCC response ACK
>    mctp pcc: Allow PCC Data Type in MCTP resource.
>    mctp pcc: Implement MCTP over PCC Transport
>
>   drivers/acpi/acpica/rsaddr.c |   2 +-
>   drivers/mailbox/pcc.c        |   5 +-
>   drivers/net/mctp/Kconfig     |  13 ++
>   drivers/net/mctp/Makefile    |   1 +
>   drivers/net/mctp/mctp-pcc.c  | 373 +++++++++++++++++++++++++++++++++++
>   include/acpi/pcc.h           |   1 +
>   6 files changed, 393 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/net/mctp/mctp-pcc.c
>

