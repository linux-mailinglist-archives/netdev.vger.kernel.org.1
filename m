Return-Path: <netdev+bounces-102460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96214903226
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031E1281592
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 06:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89E170842;
	Tue, 11 Jun 2024 06:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FUAlq5Jd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A30143742;
	Tue, 11 Jun 2024 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718085920; cv=fail; b=Osm0R3FYiozZWJZYUDUhtRbcIywHTgShwGvdNuDheMu8W/Rjj7UXbT+UgzuAaEvmAsvx2a9ev9nBUlBGF8xlPTARn7ZePGBYilks7QFRoC0x3JtchEkm8Jygpfmn04403wSGm3H21nJNl/DlUmR9J1AvKk85eJ/BAS0rqhtTIBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718085920; c=relaxed/simple;
	bh=RWqaHblr+jaZ1xoTA/e0yuS1Nnf1GSOOZa+fsp/eMDs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fCWqw/gHO53kikoNuXUvm6FkNRpRSwZd05Y8EVZYYxyxlCW/m/sZZySTid+QkfuRPo6p7IaSAJbO/Vh0QaC+HA91IoJ2iQTr4lkrBiGAtQTSCmF3pQZkhb0idZ+d1W0xk0/g0qavft4UFlu/hH2wclS3Q8ebFuhm7ep7WsvDayE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FUAlq5Jd; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYmSDbUGiFfFtaUfuk3VimMCursU+wV1A29Nd9uTa0h+Hnani6gOl8OTMmbe+gl9zRKdPFrP0oHwNU2fzCE2giV92Ezv7mpTvdBNyYcb1ZIAq3krOrmDJyFZAL9TiJynXa+qzBiXVMm+XAuWBaEpywz1S2OENm7ZW8Uxw+fM/qA0tHOFtMmdiVTF6b1arX6RUIq6+Tvl/t24cZhYxU26casvL3o6EyTuviWFxC/xmwPOjnNbik1FrkMdcJYq9dTcnj7JPErQ11mszaXC3GRzxDNKDQcgtjOcLg8L8eer6i1XngUPsTIrv9pNM7wo0Hf5eiAyeMNfSWSFE5palbEJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMgEFAGwHA/GIaBR8PjTHslt8a4NaOzCTPZoDAfCOrc=;
 b=R935cgENxVL4yOsMTxe8ttEhHAXAkQpBTy4k73L+f91zLJltZHuAI3AD+h+jPvzNl8NySs7FiV9LatE+hbvPlOD+OY31knZNyfUeNeXK6Vqp5PZ1xhzLOeNioaA05BIhx/tDjfj/sGvU4rXG7gq6S07F4NN5d+97rWpUFf08vFgr701brcrN8N6dPYBT29GDbQW3QETNgMfTCUQqnFqEz9hEWLPRT1t2b5XUpJSDJ6dG5j6tORTMEHw8tvhhC/NhzIetYQKfJUQup93LoplOg1EMSsLPLeLjmWV3PLAWzm6JQKTTvcJ2dZUBKjfdrEUV3OhOEKQeMCdnMPTJgZ8Zfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMgEFAGwHA/GIaBR8PjTHslt8a4NaOzCTPZoDAfCOrc=;
 b=FUAlq5JdvHvUoUNeaZ2FsFCeLrflcQ2Nau1g+NmbEkD14VuYs8meYjHTvC/F1rcOmfa1eMZ6vvmUKkvYvaEPGMDzGnoT8iVl+EZ/7WplvQruyehljetv2Mt79/xgY0IDK4i0qof86QE1eAVWADOHoK9EWKrdwL4GUrTYV1E1uS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 06:05:16 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 06:05:15 +0000
Message-ID: <6c01bed7-580e-4f1a-9986-39c20f063e67@amd.com>
Date: Tue, 11 Jun 2024 11:35:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/4] net: macb: Add ARP support to WOL
Content-Language: en-GB
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240610053936.622237-1-vineeth.karumanchi@amd.com>
 <20240610053936.622237-4-vineeth.karumanchi@amd.com>
 <b46427d8-2b8c-4b26-b53a-6dcc3d0ea27f@lunn.ch>
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
In-Reply-To: <b46427d8-2b8c-4b26-b53a-6dcc3d0ea27f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: a33a571e-6999-4683-4e23-08dc89dc766f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjBsVGhnZ0NFTWRrRHcya2pqWGw2Z3dSbm1lbDFWZW1MU0diT0VMUDQ4M3gy?=
 =?utf-8?B?bmU2VUY5WDl2N2wwTndMUE9vTFFQTWZyc3FFZDJ0VWZNZG1mc3FnQ2N2Nmdt?=
 =?utf-8?B?OTlNeVR3VlN4OXh5WkcwNVJpajdTOXBVN05yemx4djNkbUJZNzlIWXN5YTRS?=
 =?utf-8?B?RTFpbnV5ZzFpNFJhdzNXMERQbjlkR1BHdXV0dU5UdWdrWWtLUmxTNmcyU092?=
 =?utf-8?B?b3BIQ0d3VFpjUU5mQlh2dnQvS2pDR3JQbTJZWnFJV2hpcGJHWXk4WXNmMEtZ?=
 =?utf-8?B?d0syM1c3QWZRb1RHeENFQkFITGFYWGlNNmxIWGthbkh3N0dkY1lFcThQZ0Fo?=
 =?utf-8?B?ZkpRVXo0dnFTY1NXUUdGMlQ4cm5idGJUemFDUGcxeDFTdTF4R3JhdEFPWnlU?=
 =?utf-8?B?ZG00M0sxeHBObzVSS1JlNG1aSmdISlV0VnQxTndYM1FnRXZxWWxWWjdhNG1r?=
 =?utf-8?B?elUxZzB3TUkwVXBzUklHT29Bd3RBNU5wa0pEK2hjeDlhUDhmenRmNlFtczhK?=
 =?utf-8?B?RENXdFVFek8zdFljRGhFWUtPbGs0UC9kQ2FxUnRQZHhCWHlCbFNlcUlzZlRs?=
 =?utf-8?B?Wnp6anVlUTVJVEljTHJhRXVVa1RYS0E3eHI3YlZESDVZV0F1aW9qWlFaem1p?=
 =?utf-8?B?L2R5QStnNzlnVDl5TkxzTGE3TG5hRUlaaEdLOUNnZWNLRmlKYTN6U3h6cXQy?=
 =?utf-8?B?eWJzeGF3SUdwcWdDRWJ6WTZlN3ZSM2pDb0VqWGFYTGtIa09NanFwdDFsUUhh?=
 =?utf-8?B?ZCt1d29IbkxYOGxYU3c2em5uYXVNZ2xyZTVqTGZCNUtpUkpyRUVwZDIvcm1k?=
 =?utf-8?B?cmJGYVhubzQwWkZydmI5b2VKdkZ1SGsrdS9Wa0tkSERvOVlJVnpuQytXNys1?=
 =?utf-8?B?YWF4WEFFMVdkdkFReDVjaWNIb2ZSQXpqbi9qOGw4VC90dW84Ukp3ZXFQQi9X?=
 =?utf-8?B?QnJVdklaak5sOEtHKy9nbXA2dUhHMG10UHZZZGd6bE9wdUc1aWZzeGZWVHJx?=
 =?utf-8?B?S0Y0dUUvV2xOUWV6UTZ1WWRxRVo5ZzdZMFh3ekVxWk83cmRUTlRCcFFHYXl2?=
 =?utf-8?B?a2ZOVDRheXdJQVdPemlUZkV0cXFDWmdEQ3lPNC90Nm9VWkExd0VXdVRUZE5k?=
 =?utf-8?B?OEkrOTg3TllwSWZTbDdLaGtiL3NteFVEWnhaSG4vMDRwSnIrcEt4ZnFEdzBt?=
 =?utf-8?B?ME9VRHEwQnJWNzE2bUp5cTJmTzVld2tRUmNYSTFJRVJTdzQxR2w4Zk03NjJv?=
 =?utf-8?B?MHZOYVhRb1UxTE10cllWOSsrTnZHdFFqd1EyR1R1QWlaWTh5cmg0RXp6R1M4?=
 =?utf-8?B?eTZLcENhZTFQeTVHVSttQmVEZ1VwV25VM3NqUG9GeTdZcVdqNVBrQytZWUZ1?=
 =?utf-8?B?Zkdvc2dEdDA4bzcwWHZNQnRITVRPNGEyekFIdHRaMnBCVVdFR1p6T05tTmp5?=
 =?utf-8?B?TmVOYmY2L0dQZTBiMkx4V0ZHWEZIRUZlNEhBcEFhZE9SQ0FoTGlQeFpVOE9D?=
 =?utf-8?B?Y05GaC8xeHNDeXcvb0U1U1ZVUDdnMG56bUdnTldHbDVQYkh3N0hiOURQS2Iw?=
 =?utf-8?B?Zy9hUzZlbHFrVG5yUU8veVhnRGNMRWhYWGc3NnBDWnEvWTBzUmFoVWkyYXV4?=
 =?utf-8?B?OVcvcURrcXJnNW9kZ1c1dXdkeGExWVhvdEpkN2xaNko1RjhjZi8vc29lRjBB?=
 =?utf-8?B?NDJLU2FzZFJDQ1JUNEs1VWxucmVrWG9SSGsrMFFZenJoaWVCeWUvVkpaSjhr?=
 =?utf-8?Q?SXjk27hpL/539y6PepUYxh7AMKGdJcBOGlEzlUG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0Z0cGFpajFIQWJ6TEJiTCtyWUhTeCtrSnNjaUlMS1F0QnU5MjlPZTFDNzJP?=
 =?utf-8?B?WHlKeFFIWDdFL1h3RFRSS3ppRytZNEpTWE0rRms5eTM4T1gwcVYzNENkMDRw?=
 =?utf-8?B?dG1jQ1Rvb0MvYzZ0TmZId3BidFdzSC9ZR202dDc2bjdxZkVBTE1QMkdQUWNr?=
 =?utf-8?B?QWlQc2hNcHhORStTcWNOSjFmdHJleEVKUlpxYTdTdzJtMjVUZysxTHVWdHNU?=
 =?utf-8?B?UXF3dmttS1QrcVplTFVXRHgrZ0ZmN0ZqUUd6a3dwTER3MjZwYitrdlRiRk9w?=
 =?utf-8?B?aFlodHBWWnJlNDdXVlI2MCtCekZoMGZiTW1kL01mZmZBVzgva2RBNFZFYTJZ?=
 =?utf-8?B?dzIwTFRnUGdrazR4MStadTJ1K1JRNnVmb1N0K1VzSW83OWVqSWVvN0x4RTFi?=
 =?utf-8?B?MTFqTkNkcitWNkszVVZtc3FDeHBsMFc0QWxPUW5OQ1QxTDNvbTdJVEhieTU2?=
 =?utf-8?B?b1gyU1JTUUtUQS84Sk1wY0VCS0NtdGxKaFRUK3hEdFZ6ckJ4RW0yQi81NkJN?=
 =?utf-8?B?ME1sM0ZBb0NvYVZ1YklTU3pNOU4xbVdJUWtvbGQ3WjRjVm1yTXljaXFsVzZ0?=
 =?utf-8?B?dXUya2dqMzFlTkZUM1BJeDFEOEZkNitqOE0yTHBndXpPTjNUV3FLc2tqUW5o?=
 =?utf-8?B?TnN0eDNQa2d0aDVaRlJuRC9iRGR3L0ZhdkFGNVNJalh4NlJ4NytHRmpoNXFP?=
 =?utf-8?B?eFltd0FjRE1XblpxZUFtS0JqWkJISjk5TWFPNXJmb0hZaW0vYjJEZDJWVmxn?=
 =?utf-8?B?bXBiVlZKSDVERXM1NTJ4Vmd2NXJ4dEM0T1ljNm5tV3pDR1RrRjc0S2RvT1p2?=
 =?utf-8?B?ZmVOYkR6OFQxa0M4TE5mUUhkQzJMNngxOWxZVExmZzU3b0lZNGpnVTc1ZFBX?=
 =?utf-8?B?ZDdFcyttemNCUitmbVovWWtXbXAyUkdvNW4xL2t0SkswWkJab3FQVmVIZVQy?=
 =?utf-8?B?ZDl4UFFvQmlMTEUzb2ozcU5zbWxZTEhBeHZiSVdCZWR5YXpMcTl6cE96S1BO?=
 =?utf-8?B?bFkyRjU0dmcrQUxjMTRzMEJRbHE2WW9CL2lGbGo5VEFBTU1pU2IybloxUXVq?=
 =?utf-8?B?R3JqSVhYUld0clBXWTQ2VEwyZmJ4U1IzcUdMcnBuK2RUejFtNUl3QWhQRHFu?=
 =?utf-8?B?WHdneUhiZTc1K2VvVmJKdFpLanJvM0haTXk4L1l4SGcxMHV4UW1Malc4NmRx?=
 =?utf-8?B?ZlBHMTZzU3dhZ1NUamovV2FiT1pyOGo4bHNlQzdlL3dIV0pXTksxelZKVmx0?=
 =?utf-8?B?TXZkbHFZYmlFTzM0UmNrcURXd0tnV2EzMUh2eFhPYzkrL1gvZGxhSENMdyt2?=
 =?utf-8?B?a2ZNVHN0Kzh3ZkRCWVdLa3FESktWSWxrYm02Q3ZQVG5ra0xDbTRSV3hXWmMy?=
 =?utf-8?B?LytEYjJpdmkwTjhxOXZHRTRicGdTYmFDVzVPaWdldTI3WGM5bkZucmJIRGpt?=
 =?utf-8?B?TGhyOEhkV3hnSGNzckdwV1J3cnhudGgySmtONmhtYm8wTUNBOG43cm9FTVk0?=
 =?utf-8?B?VS9PakJsd2diOU5HRHEzbVFSUkRpVmdWVjR4N2pyYTJIdkthclFIVVg2VmdR?=
 =?utf-8?B?MG9XaFB3RzhRV2RrcU9TcTRuaENmbi9oTTFkU1ZiM3kzUEJEZHpRRUkyLzJH?=
 =?utf-8?B?KzA1eWlibytnNDYwc3kzZEtYVWRJQm1NVlZXUndPSE1Ua3lPdzhxUFZ4ZDlk?=
 =?utf-8?B?TkZzbmFOSSs1T2RJVWdxZlhkZThCNjUzT0tnalo1YjEweU1JY0pXV3NCYVJx?=
 =?utf-8?B?VXFpQUhmTGwxSjFpY1prR2hCTTBsRDlISlZ3UEkvYWs3Z2FkSkZLN1BjYm8x?=
 =?utf-8?B?anQwM0puUXM0TW1yUnRPdG03WjRDMml5bnF3YmpwWi9VNUVNNVBjMkVJbFJZ?=
 =?utf-8?B?VmtWRGtLQzVaWTdQK0tPMHNiYkxOUm5wMGVGK0RwSXc1ZVRjTU5DUEh3bUVP?=
 =?utf-8?B?QXppQzBYMFZUU3JNY0ZQazNheDI1WFhqVVN2WjlUN3VRcms3OStMS3JveWRt?=
 =?utf-8?B?V2IvVFIwcDFqTGpyUExGaWxtUFVVYUpWQnNoL0tidHRnRjRWVFhhVmRURkQr?=
 =?utf-8?B?TEluZ3RFVHhaN0ROeGkzRUNNWVhoYmREK2loeWJmNXYrUDdSWGlsd002SlVO?=
 =?utf-8?Q?VZm/GztMa03c3lFAS91vC/EoB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33a571e-6999-4683-4e23-08dc89dc766f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 06:05:15.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USJ8jqTDV8QhepCnLpKB4nb0kU2gX6GMaqFSjHLzSGemT1uLGOgQGya5ArET81Gi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527

Hi Andrew,



On 10/06/24 6:16 pm, Andrew Lunn wrote:
>> @@ -3294,22 +3292,15 @@ static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>>   
>>   	/* Pass the order to phylink layer */
>>   	ret = phylink_ethtool_set_wol(bp->phylink, wol);
>> -	/* Don't manage WoL on MAC if handled by the PHY
>> -	 * or if there's a failure in talking to the PHY
>> -	 */
>> -	if (!ret || ret != -EOPNOTSUPP)
>> +	/* Don't manage WoL on MAC if there's a failure in talking to the PHY */
>> +	if (!!ret && ret != -EOPNOTSUPP)
>>   		return ret;
> 
> The comment is wrong. You could be happily talking to the PHY, it just
> does not support what you asked it to do.
> 


These are the 3 possible return scenarios

1. -EOPNOTSUPP. : When there is no PHY or no set_wol() in PHY driver.
2. 0 : Success
3. any error (-EINVAL, ... ) from set_wol()

we are returning in case 3.

The comment can be "Don't manage WoL on MAC, if PHY set_wol() fails"

please let me know your thoughts/comments.


🙏 vineeth



