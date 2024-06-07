Return-Path: <netdev+bounces-101633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E938FFB45
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C6428640B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 05:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155F21B974;
	Fri,  7 Jun 2024 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uK6OoKSi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B3E57D;
	Fri,  7 Jun 2024 05:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717737581; cv=fail; b=fVXd2VsGRaFgetB0B/nh7N4LKUxgAXnFKrv5drGhst9PLfLgvIjUzbztscS1Stw4Sc2Ujb5KpY3HUWlekDbe2lZ9p/l/H8zlYTouQZHBn9mZrnjt/sq9vvQDHGiq0sgLfeFb3ElmzWEnb0HXhdhBF/I8y4yuqc7+lET7CssMUKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717737581; c=relaxed/simple;
	bh=0QlndJZRjY2FzOA+17p/VSN6Y8wN1H3hWq4cLq1WelM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iCWdOMhXdPmSDeO6A7U6WQEJyRm9EOipSxYpXtinUivPSUq5EWZZkMdsrIKBseaITvqyp9WB9ZcSDhMrqeRkgokp2SfL+kpnejfZ48G3D5NGWl/fK0MuG6SyVqxGe660v0FcfdQT0coyGUddgap9OnObdBbG5GHPs+62EL63oYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uK6OoKSi; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jw7QZILcNSpepsYwlJaJHiSSISAFwB+AaZ5GItci9BsoB7yMTJNeODk8/IcvX9/7KISmzeEpG2y0rD5GABcaG7GFcrPBuPgZ3eZohj/BGIjuFC2zXRkUEsLwNeOTkvvIo1awhg89jFu3BvjAuhkv7kqWuT/Pp8hrxr/WlPBFN9cQqmdPHCkgJFfPVTOu5TyDqShmnTq1aWGYFpiOit38UNL69QrseBIvapEMhz+2hmmLu8ecNK7OP+MEUuTx9bZO/Q4tN9tpRdAz4O8UK4+/P34FgDI1zU38ZGTwNrfWfWVMJ+gDyB40prW1KM0nKHCGULjmVdHdZu0SqaOsa2pwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aglg/L72hOWftNVWd+JMjiGVUa7wEWZFqt0rnKlv7TU=;
 b=PaS/uPDxC6gTKJs71MFdD465uTUsVRCMFx9xWS7R0MtrXzkzd/cSQpAMJHaV2YXojIJqJEi9wZiFEGHrXcaKfTip0D2eJ0n2HQW+xLwbl2/T0tHGSAVxdUZQ4FuuDYZLCkyaVR4DO6u1fOHlGwc6mOGhrtUoUMjY6aewQU40sgD3LpSFJSWovHLc4EDwTuOOKjbw7g0ZcqeqvYAKPMiz4Okl2p+wwvTbeKWIgeA5adTEOo1foxNuL8JWHRfQFJuYOJQQb1/uHL4ucrVnTKscY2rTvmb5/g0ASRaHn7jeDrmxsyFrlZjvrNGPvjfFmL6a55dq3RtKAwU9OBxrEQDnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aglg/L72hOWftNVWd+JMjiGVUa7wEWZFqt0rnKlv7TU=;
 b=uK6OoKSidOMElr0wwUZmotaexKTNRWmnJQg3I83NM+X0ivsdpwIzIuVFo6PPPnxp58Z71Pjvg6FiunZ9cBT33wlTrOMJ78WdzTPLRDqI2wSUyFv0w7cs7wWBqp9achOUBbx/yjyjyUKG261cjkObwsgLgfMj7uIzrFh1pboKGTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 05:19:34 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527%5]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 05:19:32 +0000
Message-ID: <a358234a-8521-468e-8531-c8be0bbc619d@amd.com>
Date: Fri, 7 Jun 2024 10:49:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/4] net: macb: Add ARP support to WOL
Content-Language: en-GB
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
 <20240605102457.4050539-4-vineeth.karumanchi@amd.com>
 <901ec7a8-7460-492e-8f50-6d339a987020@lunn.ch>
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
In-Reply-To: <901ec7a8-7460-492e-8f50-6d339a987020@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:3:17::15) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 390199e7-603e-4d33-6281-08dc86b169e4
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk1xV3I4MVZZVGxLaEdFYmlqRnk0bzhhcEV2Y3Ayc1Y2SzRoNFh1OHdvS2pF?=
 =?utf-8?B?d3l3bWg2QU9xZWJEVmpJRVViWFF6ejRVV0tiK0RWMUtxM1grV3JRTUpwOU5z?=
 =?utf-8?B?OGxLSGVnanloZXN5QlV1ZHJVUWN1aGw4VTI1RVUxRHJNMnZ6UGErbHNSYkxs?=
 =?utf-8?B?TVRTb3ZtVjRhRkRJVGpnV2ZkRkxGeUFQVUlaQW1NblJiZnhUNlYwY24rLzU3?=
 =?utf-8?B?MGhKVVNZY0ROR1Nxbks1RTQ0a3h5TmljWXJhRU5tNzh0bVVRSEdsTXN4TXJu?=
 =?utf-8?B?c0xjL3ZTUkFleWwrZzVvODVwcjlWUEpnRnNKM0lvVDdzbzQxeXBXc3BDYmYw?=
 =?utf-8?B?TjRCeFFidnM1NzFOZEgwcXRrdlplY3o3UGJEQlpRSnQ0LzhpN1hvZHN5cVBY?=
 =?utf-8?B?WGg3bkxRVkZPMURDRHE1Z1FTZ0FOeTdGako3bGxRb2t4OVFCeWkrZlRVZnpy?=
 =?utf-8?B?MVR3ckV1UUE1VXVvQVI5MDYydzcyeW9yM2NPelFhVmxaeFhRWm5QUGpJWjRt?=
 =?utf-8?B?RDFPZEFITlBJU29qazFmZVJwRGdRazA3dG1abUpHWHJjc0M2bUI1UFFyZm9N?=
 =?utf-8?B?R3VIRHVGWmFSYzFuMjViV1pTMFprL0lzQW5WVkJuQk91ZnA1bDlsRGowb3dR?=
 =?utf-8?B?bzVFMytvTklMVVgrNy9UcEVJUEMvR1RyYmk1d054Q0k1NytGUG91QkM2Qk9x?=
 =?utf-8?B?U0FSM3VYaXhGdUhWY1R4WWxLWVUxRDk3SUlTZE9lY24razdyYmh4Y0xCSGhq?=
 =?utf-8?B?TmM4RElkRG1rMGJERzNnK2ZmcEFNZmxUaWUzVXFUMkR5WjI5aWxpWUU4U2pC?=
 =?utf-8?B?UTZhTWtteTJyRFVDMVUyWVlGM2xiRlI4L3ZkZFlMZTFGWU85cVJNSlgwQ2ZB?=
 =?utf-8?B?bVVvRE1mUllDV2ZHUWdhQlJGbVRkL05iWWZNZFB2UUVrVzFOMDJPMHdzUWMw?=
 =?utf-8?B?M2ViaGFBNmhieGxKcmVsVXVVcjh2d21QbWthL1V1WlJzSGw4aFZlR3BtK3F5?=
 =?utf-8?B?TE5XeEhrNTRiamhrbE51bHVNalphU3Uva0NyZ2dYc0hva1lGZ0pndkRhN2pa?=
 =?utf-8?B?MmFzNFY1QzVTeCtUNXdpcG1Fc0tJOUJlVlZyQzQvaGdDZlMwejduTE9aSU5m?=
 =?utf-8?B?Z2NBTTY5KytrUEZDbnlaOUNiSFgycldFYitWUmRuZHRpekpXcVpSWHlrakha?=
 =?utf-8?B?cnpCR3QvdGgxWEVPWWxZdWhTMlJlblZWbzBqaFNjVVMwSVY1ZlR1YS9WLzZR?=
 =?utf-8?B?eU5ZWXIzWEZDRGhPenRVRFdvbGs2RDFQL1JraDFKajZZSFl1OXRoOVQ1cUlZ?=
 =?utf-8?B?N1JGVVd4QkQ0TWtJa3M2amU1ZHNnZmRLaEJKUHZHT3d3RHQ2S2FuSldIZENU?=
 =?utf-8?B?VVc3YXJXSjRqcDlyZ3pXK0V6enlwamlPNXJld0JmMGJRdzhnMkJ6K1cwejJI?=
 =?utf-8?B?VVJ0dXFkK2RVU3FHMUZkRHVpL2hhaW5iWm1SWkNkaStSN2h1Z29PM2RnRnZU?=
 =?utf-8?B?Mk9TeUg5VzM4bVIzOEhIY3pmcGEzN2FTcHVhNHl2ZmNtOUxTR1dONERQeHla?=
 =?utf-8?B?ZzZFUlNlYklSQmp4SXlxUzBzTVIvSUhGaVVENUl2NjNQNFkzUVAzdDNVZUVZ?=
 =?utf-8?B?SXFxZ2piWWhnL2hxL1ZGdnhldVFvOHozNUdrSFl2QlVKTW4wTk5YQmxjbjRS?=
 =?utf-8?B?cXE1ampkaHpsZ1dVZzExTlF2U1B2SlZrUHZQbHdmRnY4Z3pjVkFmbGd3ZlQy?=
 =?utf-8?Q?/LzmShq5F6AsZzXgyKmKsfk3saqEHjNQEy4g1MF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1RnY2YvYktuYWhYZmpZU0dMcDV1RjZOZkpSNDh2ZGlTYzMwQ01GN3A2TFlk?=
 =?utf-8?B?QkRmekF1bVY3bHJmcGt3eEEzdVd0L1d3TVNPRGkwcXR1OUczSTBXcXUrMkx1?=
 =?utf-8?B?OWZMem5sVW9mYkFTMkJteWsyTUhSV3JjRUhpN0Fab2phVUIzcEh0cWVDNElu?=
 =?utf-8?B?TDhVREtqZzR3YW9qV3Zibm96SFh1U3NLUU1pS0FEUlNFUDEwYWJ6LzYweDY1?=
 =?utf-8?B?d0hZejRncHZPK3RNQWlaNklZUUxGWFBEaUM2aWthT3I3N2dxdkZrcnZWNU9J?=
 =?utf-8?B?V003QWVnb2o5R2Y0eFVYY2dTMlYxYnNmcm1CdGtlQ2JKOGdFdTVhRmpJUVNt?=
 =?utf-8?B?TXBra3hLZmo0eC85VktlOHZQR2NJVFNTOE0zdmpMMjF5ZldYR0lCbFQvME1M?=
 =?utf-8?B?d1hUWWEwR1hnamt1ZHozY2hIMGc3SWdhcTZqZEdKajVJbXZmb202b1hjaGVt?=
 =?utf-8?B?SEprcWx1K1czQ0xoR0JVSHk5SDQrOGI5b3Z3cTFqK0J1T0xKbTdVREl1UmVG?=
 =?utf-8?B?L3RPWVFKazlhOGwyOS9VMmtHTHNpMG1yTUVjdnJEQ1dkWTdENjFjT2phZk5n?=
 =?utf-8?B?L0k2WndkWjhYTWpFODY2dlZ5ZzJmQm52eS8yQ2RHRVlsTVp3NUJjZUpTOXpT?=
 =?utf-8?B?VGx3V2F0SHVuOXZmZlZITmFWbHNndTNLM3pMYTF5K3Yvc3kzUllwYnNnNDUz?=
 =?utf-8?B?ZVZobUFZS01Ra3RqbVZnVE1pY3cvWEs4Z0ZMNmZNd0NCbmlMR1B3bzVwS0xQ?=
 =?utf-8?B?N040MnlyNmJRNmRQTFBCWHlCQWpOYmwvUGJKbnpqQlVURUtZMEpHbmdmZjZj?=
 =?utf-8?B?bmVvWFA0eFV3bExlWFpFWG53UjFXcnRBQVJITDRDWjNqWGNheTNuSldPMktn?=
 =?utf-8?B?czkxd0NwS1YvS01UczVNTW9adXV6dmx4d3pNUUZtLzBqdTNLbzVnWi9odVA2?=
 =?utf-8?B?eThoYmxVbXE3Rk9FWTJCcTV3OHlKSUlpb1ltL1hoZ2lxM1R4Mkt2ZFYwdWpj?=
 =?utf-8?B?UjdKakF6M2pqTU9Pb0hGV01aUU5PdTFTcThrbXRGK29XLzdDVnNJWTM3NTNk?=
 =?utf-8?B?bjAyRVE2dXgyVmVzZnh5NjhSRGdnQnZvQVc5TllDblpzWWlEYm55TkZBYnk3?=
 =?utf-8?B?bDVvUG1wd1owSU12UXo4aEtXUVdGS09YT2tDRFNSL2tNcGFGSSsrdnVTS05u?=
 =?utf-8?B?N0x4NkZwSDQwSkpyQnlWbUsvTVRYcjVkekd2Y0drblZyTzJ1b3lDSFdOa2wy?=
 =?utf-8?B?L2wzVFVWbitLa0ZhR2thc1gweDF2TjZMNTJ4dDN2NHF6RUpXaXFJMUxLN2dN?=
 =?utf-8?B?eGx6QjhnUTN5TVBtZ3N5TDhmdG5aLzFCK1owaDlXWjFaRzl0eUhjbzJPNmV2?=
 =?utf-8?B?WDJ6UXVERlRHZGlodEhkVmtmSmVBQ0U2ZDg4ZHV2OXhNT2tuOEY0a1I0MmNi?=
 =?utf-8?B?Q2RMWTBLY1lrQUVXWHRSSmpESWhtN0lVMU9ZQlFqMmRhYmg3dWN2N2o1V0U0?=
 =?utf-8?B?d3VBblAyLzc2dmsxSjJKTFZGdkdDeUFiZnVEd1FabURWY3Q3cDhGRUZOWG1R?=
 =?utf-8?B?THp0MVRFS2k4Q2N1dFdZVkN4dnVyaGUwZzJoTlJXMzJXV09jWWhYMDJJMWh4?=
 =?utf-8?B?QlZTZnZWc1Y2NHdTM3RJV2NTemswd1hZK1Vnbi82VUN6dEJCOFNMZ0NTUGJG?=
 =?utf-8?B?aTRpWVBpbjVHSFF2aEcyRVJER3RDZGlQQlhJQjBFb2J3YWx3RzhwYVVvSUN0?=
 =?utf-8?B?NWNDZ2JBRkpET1YrZzRReWN4U1pvbFdPRjM2dktrelFoYk43NHlvY0ZTVDJF?=
 =?utf-8?B?eXdpVGM5STk5cWFSbnJWeENWOHc2aXZFaTlyK1A4bHVET1pYeWZsdlFodmF3?=
 =?utf-8?B?NFd0Y2d1VWUzMU1TVVZBMGRCYnk3TnJLWjhWejZldzhKOWdvRjFpTlMrMHdG?=
 =?utf-8?B?cUNxdDhpQXYrYTdzdm9rWXNNYjVTU1J1V0ZETlpRMzRhbWlEellJV05lUFAv?=
 =?utf-8?B?NzZvd1c1SFhaTEV1cUNHdzByOXBSMUZZS3pTMDZQYjkxWTdnTjVlOVAzMy9L?=
 =?utf-8?B?Tk90QkVzV1dNWDhVQjZ4VjFnWldOM0hDSGQrM3FGVmN6UGgxSkxFT0hMbjhv?=
 =?utf-8?Q?QQSZgHl9Pb94XX2lVX7nCYpG3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390199e7-603e-4d33-6281-08dc86b169e4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 05:19:32.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODSVhzKPR/fFSrSb+Uuw1WABHHFpyLKGV5oTEo5fCC1zuF4GjUzhPaeAkPohetDI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409

Hi Andrew,

On 06/06/24 7:29 am, Andrew Lunn wrote:
>> @@ -3278,13 +3280,11 @@ static void macb_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>>   {
>>   	struct macb *bp = netdev_priv(netdev);
>>   
>> -	if (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) {
>> -		phylink_ethtool_get_wol(bp->phylink, wol);
>> -		wol->supported |= WAKE_MAGIC;
>> -
>> -		if (bp->wol & MACB_WOL_ENABLED)
>> -			wol->wolopts |= WAKE_MAGIC;
>> -	}
>> +	phylink_ethtool_get_wol(bp->phylink, wol);
> 
> So you ask the PHY what it supports, and what it currently has
> enabled.
> 
>> +	wol->supported |= (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ? WAKE_MAGIC : 0;
>> +	wol->supported |= (bp->wol & MACB_WOL_HAS_ARP_PACKET) ? WAKE_ARP : 0;
> 
> You mask in what the MAC supports.
> 
>> +	/* Pass wolopts to ethtool */
>> +	wol->wolopts = bp->wolopts;
> 
> And then you overwrite what the PHY is currently doing with
> bp->wolopts.
> 
> Now, if we look at what macb_set_wol does:
> 
>> @@ -3300,11 +3300,10 @@ static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>>   	if (!ret || ret != -EOPNOTSUPP)
>>   		return ret;
>>
> 
> We are a little bit short of context here. This is checking the return
> value of:
> 
> 	ret = phylink_ethtool_set_wol(bp->phylink, wol);
> 
> So if there is no error, or an error which is not EOPNOTSUPP, it
> returns here. So if the PHY supports WAKE_MAGIC and/or WAKE_ARP, there
> is nothing for the MAC to do. Importantly, the code below which sets
> bp->wolopts is not reached.
> 
> So your get_wol looks wrong.
> 

yes, with PHY supporting WOL the if/return logic needs changes.

Consider the scenario of phy supporting a,b,c and macb
supporting c,d modes. For a,b,c phy should handle and for "d"
mode the handle should be at mac.

I will make the changes accordingly.
please let me know your thoughts or suggestions.


>> -	if (!(bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ||
>> -	    (wol->wolopts & ~WAKE_MAGIC))
>> -		return -EOPNOTSUPP;
>> +	bp->wolopts = (wol->wolopts & WAKE_MAGIC) ? WAKE_MAGIC : 0;
>> +	bp->wolopts |= (wol->wolopts & WAKE_ARP) ? WAKE_ARP : 0;
>>   
>> -	if (wol->wolopts & WAKE_MAGIC)
>> +	if (bp->wolopts)
>>   		bp->wol |= MACB_WOL_ENABLED;
>>   	else
>>   		bp->wol &= ~MACB_WOL_ENABLED;
>> @@ -5085,10 +5084,8 @@ static int macb_probe(struct platform_device *pdev)
>>   	else
>>   		bp->max_tx_length = GEM_MAX_TX_LEN;
>>   
> 
>> @@ -5257,6 +5255,12 @@ static int __maybe_unused macb_suspend(struct device *dev)
>>   		return 0;
>>   
>>   	if (bp->wol & MACB_WOL_ENABLED) {
>> +		/* Check for IP address in WOL ARP mode */
>> +		ifa = rcu_dereference(__in_dev_get_rcu(bp->dev)->ifa_list);
>> +		if ((bp->wolopts & WAKE_ARP) && !ifa) {
>> +			netdev_err(netdev, "IP address not assigned\n");
>> +			return -EOPNOTSUPP;
>> +		}
> 
> I don't know suspend too well. Is returning an error enough abort the
> suspend?
> 

yes, it will abort suspend.

🙏 vineeth

> 	Andrew

