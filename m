Return-Path: <netdev+bounces-111590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C802F931A39
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 20:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2619EB22384
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC36BFC0;
	Mon, 15 Jul 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="5oPhD3da"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022089.outbound.protection.outlook.com [52.101.43.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20461FF0;
	Mon, 15 Jul 2024 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067679; cv=fail; b=hFwGHkkCqohYE3kSVehUqDWIBy0yXb+nyaDiNAKFvyArKCtCH9sNxTgIatv8u/+Ytj9dq9ui786JQerWCS/qyKzKlZABlBhir6+PaERc/kWes4w+AxTjEEYD2tMt32LnoGmnUeabh/C7TTvJhpPpAeLxYQZq7ANCEcwPe9VJzLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067679; c=relaxed/simple;
	bh=T/Uo+fO2Vt2HDWI6smmZ3tCgkeyV324iGcLW7niMs/8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fXlOr4BKYH2xdr3sxzupRVzFv2trkzxfyHS8a6PpGaSc2q4CkaQH4xZ0+HbeStVHvTuHXOgcZmK1qZ0niy8j6x1fBMl1nvnwL/dgX8zSofGC+3/JGzDvi/Z4MgT6d7KoPJreEN4VfNnKg+PPD9jMNtr58RQSVoMyGmgQ8zzDrI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=5oPhD3da reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.43.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TN5BZ3eVQjIdrR/afPVfhVVTFVqd2RUFhPuclX/qlGXfY4Flt7TrWiYFpbNGWpGk1mf2aVwNFCv8JYFg5SbonWZ87t0NIIop3GNNAKwQntDdpCYYbPo38QR3myBSxs15r8DcrBnpcgZ1tWrz2UP4Fdq9I7dNKLBI/R3ENadeaXMZjchVLa1dMiLWqU+Z1BGWph9gw4kv5/OwjMNl2tSoWb06D47IGjlvP0tbKgVtntItKmrCks9DDOBng4HZ/bsKQxPv2I5JtvtaXoJIJeVYwiZt7Tm3l/ilbtX+1MW6ibYbyrNzpvze43hP3SQ8v7sKzByzQlhkULdO/hKGcDCaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmZDqsumfXMA60bGoMldp9rasvO7xevEjpV4KyxeIIE=;
 b=G/jAQTFMjDdK7N+qzAYsJSJ8omWXLuF6UB77ycoJSkmZIX9WPnoJ7GsHkOZ0/h7NQXZjeK7ZHOirxpIlBjUITyiNGzB5uCYUuMKGApLTdcXqzOz6bR+BhD/4FeB9GhPxrE0/jjhOBZMBdjS/z6I/K7tbFnEq0hZ4WBaSf+7baNMcNnyMNqYpAvApB5Dxl0h3YqOB0qEZQkeiQ3dbzcO8lfpV/79e1xxTbqeUxnzBMXaHytYY4VreQfzsrdJxBE2LV6gQWaXuR0SY9VnK1BNLgYChZd708/lezbySZ7GpSYEHojHU3nVkcj4h6BVSguAYOEOG6TpHJvmVTTuGhsJl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmZDqsumfXMA60bGoMldp9rasvO7xevEjpV4KyxeIIE=;
 b=5oPhD3da/FcJc944dwMYP17PNmhImcTbG//EP9IdLUJ7kbyDNz/70d3vIepg4gMl7S+jQnDd/ZBGI7BHIQbTrMUqA29uyg5g+UgvDBB5oNVzMJTn5av0VHMLGfdXrMPe7A7pRWfWQ3EmAwXu+frJ62+upUCioLR2lrwk0KYknZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SA6PR01MB9093.prod.exchangelabs.com (2603:10b6:806:432::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.27; Mon, 15 Jul 2024 18:21:15 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 18:21:15 +0000
Message-ID: <3ad21332-c58a-46bb-8d3b-8b3d1cd8cb75@amperemail.onmicrosoft.com>
Date: Mon, 15 Jul 2024 14:21:11 -0400
User-Agent: Mozilla Thunderbird
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
Subject: Re: [PATCH v4 0/3] MCTP over PCC
To: Dan Williams <dan.j.williams@intel.com>, admiyo@os.amperecomputing.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20240702225845.322234-1-admiyo@os.amperecomputing.com>
 <66900ef8e7c79_1a77429414@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
In-Reply-To: <66900ef8e7c79_1a77429414@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR22CA0100.namprd22.prod.outlook.com
 (2603:10b6:930:65::28) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SA6PR01MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: b72fe0d1-7658-4739-6911-08dca4fae9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cURRdmRVOFVod0lvbE0zVHlybUpLMG1UUnJCdndCWGpnSVp2WGJwb2J5QzQr?=
 =?utf-8?B?TEM3bjNKS0lqSEVDWTFMMEZuS25HN3JPdGhITURBaXFRK0hVNGdNUFRCZ0ZH?=
 =?utf-8?B?ZnN2VC9mOU1iZXE4azZNL1M2VzhjaitIYlFoR2k1bGg0bktWSy83R3JwNkZn?=
 =?utf-8?B?VlYyd3ZhOGEvb0gyRzhXTVpBUUNUN3lJNGFYcm1OLzlXb3JtNlFyZ2Z3UnNk?=
 =?utf-8?B?T0RqTytRVW5oYXRWWUNGNzZNb0p6VExTWHVzelM3WEZzcWJyZFluR3c4MzFI?=
 =?utf-8?B?YkhOOGlRaFNSQlpMQm50T3YweXVISGJWR0thMGR2VXBPOGEzZnQ1LzdtQmNv?=
 =?utf-8?B?RU53bHc0VzdIem02d1drS2tlS1gxUjV4Q1pQajVtTzdZVk5uRkhjQ2E3ZzJo?=
 =?utf-8?B?dEFLcGVkZnZ2dDNXYkRFM1RFRU0zS05CdXVpaUxMNzJYalF5NUxQcUxOQkhj?=
 =?utf-8?B?OW4zSjN3cExnMGNZaTRVVnVHNm5vWWsxWnRicjdzSFUrS01ZS0dpS1FHVkpR?=
 =?utf-8?B?Z1crN2RFR2tXc0poZ05UTW5CdEMzNlNPeERoa2pwWVRjb2gvclBGNmh6a3Fl?=
 =?utf-8?B?cmg2ZUVqMktQTzZweFRyaVpEQkVtWXlJQ21BaktzYllvK1M4QU1XcE42R3dV?=
 =?utf-8?B?MHFsQ1AyNmZwNGhBSHd2ZUxyRFM4WWhNNDVRZGdHY21MMTlnSHlTZnNiM1JI?=
 =?utf-8?B?SE8zWk1tdGlOYkFTTys3SUpuMk9JczFJWWw2SjkvNW5YUGNIL3BzVG5yTFdm?=
 =?utf-8?B?VDN0bmZFcHVxS0tSOSttOTRoUjVQRkJSQk45cXFRMTB2S0xSakxHS3BUZnR6?=
 =?utf-8?B?ek94M2NZVW9Dd05GaGVYNWN6YTdES2pibmtkSEtTQ1lYR3BWNFhoNDZKMUJo?=
 =?utf-8?B?YlV2UXZ2YmprSTZFV2pMTFJRNVc3UnpPTkRoV2t6RmtQOHRLbll2V2U1S2xr?=
 =?utf-8?B?TE1ac1ZHenQ3Y0lmc1lJck85YnYreEZPMGd0QStKQVpyeU5ZRXJaNUdEamlR?=
 =?utf-8?B?MlBXcnJ6ZWp3bTRGTlprZVlsZ3czOThONmoxbnZHQUFSWVpsc2xPWVZoZGtl?=
 =?utf-8?B?N0p3VzhTeWlHb3ZkRVFEc29iNVRXdFNFeGlaRzZZeURiL1N1ZWsxK250S3RO?=
 =?utf-8?B?a21DSUpobzkrSWp6Y29ZbUxVVVRSM1lvbXJKZDYzVXRMeE96M2dMeEdySnVU?=
 =?utf-8?B?Q0lQY2x6Q0JFcUhYaE5LZG1UWGFuUEMwUUN5OUFTUUU3N0U0N2RGSXM2WXR3?=
 =?utf-8?B?czAzTENPSDdOQ0l3ZCtEZERuVndhYUhsaVgxSzgzYjFadUpsdmI4amRDL2Y2?=
 =?utf-8?B?bzNxMzRFWklRQTc3QkZFMFA0d1g1ZGFwNUp6anExL2JkWUV0aFpvdWExZlp4?=
 =?utf-8?B?Z2VRODlqdVR6cGY0MXdXSnF0Wkcwb3FkTzFtR01uellZVTAvaTJJRVMyeld1?=
 =?utf-8?B?d2pvUXQyWUxzNjNGTldzRE1RLzlxZnBrRTNwUmRqZ2JGOVBrayt0Szc4VFVz?=
 =?utf-8?B?K3JMbisrOFZDMFM5dGovdTRiUDQzUEY4dWpmeDJYS2xWOGVzMFZIODZ1R2tX?=
 =?utf-8?B?aE9uUXZURElFN2dpMDkyYnFUN0FmTUlMam9IaTg2dXFKdEs0Vzg4NGs5WFNu?=
 =?utf-8?B?S2tuZFEyM29mamtLazVBTFNRK216TENMNVFJcWJKSmVrYTRyamhnWUhPUE1k?=
 =?utf-8?B?QmJEZmJ1SC9Gc2ZqazNYa1hyRjVhS0E3Z2E4bWVDRFBHUXREYTRoQVlSRGRI?=
 =?utf-8?Q?XbquzeqLwB/Ivl+hPo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1pRbitsRDBOSzYzKzhodTFJd2x0QkNscHZ4U1VtQ0Nod05jS2Y0U2lFaFJo?=
 =?utf-8?B?VFp5N1NURWQ2U01qNlF3S3hJVHVyZzNDWktScWRNZ0hsMVdVdXlXb0U5Z29H?=
 =?utf-8?B?N1NRRVZJTzVSd2w4Vi9PNDJJMmxWR1hjajAzdmZBN1lNYUpVeC9sYU42RHNm?=
 =?utf-8?B?UXU3NWtVTmdwd05iVHRQZ29peEFIZVNaZG1UNVJWSDlnOG1XdzUzWEVuZ1RC?=
 =?utf-8?B?cFdBKzhBNGhlVk8wQWdNR2NMZWRNQTIwTkk0VzhDN1JRK2ZDYmdoSnlPT3Fi?=
 =?utf-8?B?d21wNVVvZEtrZm5vOVhyK2ZSckRVWXJIdUdqWVpISmhISndKOHJuVFdpSkhH?=
 =?utf-8?B?T3F4aVVweHVnMmF5NUJxVnJmQmlJVklhNDdRaHNjQy8yd1ZhOHRVdFVVeTdk?=
 =?utf-8?B?VWZTYVdVNG5KME14NWhnTXNTd2dtejd4Rk5lalg1aGROanhWdTdsSTZ6UHdq?=
 =?utf-8?B?M1hYU281RVdQV0xpMW02Wms3ankzRzR0K3YxMU80Q1gxZzBDZnF3dzJFUy9o?=
 =?utf-8?B?VFJxRGdld0oyZThUK1FCVG51Vy9xeXpjMTg4Y2F2VG5oUm5pSlNYd2ltVkxm?=
 =?utf-8?B?Vi94M2I2MVVjU0NYeEVleEZsa05PelhTN0o5T2pyRGszQkpqWTU5TGpmRFBR?=
 =?utf-8?B?N3ZKd0F6OFJkYTJRK2JDT3VCUVkzbWpsSVJIT3FiVnRpRHNMaVo5Zk1tK0FI?=
 =?utf-8?B?c25nb0RTQnBrcUgza05GZFI2TllKMHN2UFhMZlhVRkxRVmt4c3Uvd2pJRHUz?=
 =?utf-8?B?Mlc2dWdzajRQdEtMdW9NQ09GaTQxOTZ5MjZYUXgrYXdNc0p5R2FTQmtueEVG?=
 =?utf-8?B?eU15UStvK1EyeUVpL0tqWmwxUlRLY0V1UkdpYWltV1JWWUgvaVVjd2ZBSTVl?=
 =?utf-8?B?V3RRNFN6RVdCc2w0Um55a2ltc0Z5RTdGUnBGbjVxVlBsK0VqUmZKcEt3Njlu?=
 =?utf-8?B?V3R5N0V4U2xEeHkrRzJKYWxuS09uSXd4SXRVSUVMaFhNS3A3TGJHRG5tcGRi?=
 =?utf-8?B?TC81dTQ4K3IzejdwYUQwU2hZVHlKaGVxUDlRMmg1S1VVcmd1b3l3YnBnUkcr?=
 =?utf-8?B?djcyVnd1U2ZyQWp4cjhzV2M3dU0xOFEwams4K0xScy81OTJzaElQRmVpMWhS?=
 =?utf-8?B?V3NrVnF3UFVHWm9qTHB3WndDMWp5MzBOcFhTdVZueEpBNFZIM21nclEzc01F?=
 =?utf-8?B?VXVsRUZPdEdCMjFCMWpCS01hZE9Dc3V3RFdEV3VTekRNVlo5Uyt5MTBYUW9J?=
 =?utf-8?B?VWx2RjRUcVJVOGZmM21BWmVabHgxbHVCMXFoclB1c3NwY3d4NDdacTg3U21Y?=
 =?utf-8?B?UmlRTXI1TktzZENaUlh5TXQxdGQ3TEZPbSt0MGRTeUp0WWtPVWxMRStJM3lv?=
 =?utf-8?B?U1M1eG9ma1dTUGRLQ1gycllNSHZiZzBzN3dLRTVnRXcrMUV5SGgzQzVNOXhJ?=
 =?utf-8?B?U2dzTEdEcjdEUjFnWHNXYTVUOTZxNm9Ld0JIOVZjTXFGVElMejNjVnBHdWZX?=
 =?utf-8?B?SUEwQnJpUmFvd2VyTzBRbTVOSFhuNTZRdEhhNm15V3Q2VS9OYzlPeUhzWklO?=
 =?utf-8?B?U3h5T0hLMTVIUmQ3R3l3TFdMRjc4YzdzV3ZYNjhtSTVoM1EyVHhPby9YdVRP?=
 =?utf-8?B?eE1pTkVRWW1Dakdtbll1WmRtQ1VGQjFQWGtwekVSRUdjdG0waDhLbExBNzdE?=
 =?utf-8?B?c2QxcStXRjlDNWVTcU4wa3d1alV0TFduNUZMb3IzQVFsMGdYODlvRVBldmMr?=
 =?utf-8?B?SVNXWFlZbUM0SkN3V1dmUlRMNG15NHJYNE10ZGZ5YXVrZHVwNllESWxOMGF6?=
 =?utf-8?B?QkNLRGhHL0dMSThwc0dtcDhoK2gxK2FWV2UzYWwvN2ZLZFpYZGVabDhLbXFq?=
 =?utf-8?B?NHMxQ2lWVXV6LzErTit3V3VBVWM2UVhTcStoK29PY0VsVmJkWHp0UWVUcmdr?=
 =?utf-8?B?N3llQlMwV0x6OUlSUytTZVhQUGtxYTdrUHl0OVlGdWg1Y3Zhb01TNytJdmxp?=
 =?utf-8?B?aEZvKzFFSHlGeGNicU1CdWNiVXdnaGtDRVdyM3JpNnRiMHYrR2FCTjNHOHdq?=
 =?utf-8?B?T2d4dzRtY2RwV2VCN2xyTFZPdUx0Vkd5cWU5ZGRKcVZmWlJhb0VZN2VFdUpX?=
 =?utf-8?B?bUJJVGNGSUN3UWlPK3I0QUNkUkg4V2ZJQkhRblRWWWNickQyNEd6MjdaaStD?=
 =?utf-8?B?bW80WjBvdFZOY2dVWngzaEZ1V2Q4YkxEZWU0SVBFdU90aUI4QVdwWnZvN2RK?=
 =?utf-8?Q?i866pHq7ry0K3MldnBN0CXrAeW3tWOWpy1S9ArTJ4I=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72fe0d1-7658-4739-6911-08dca4fae9ac
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 18:21:15.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrHekc9nqedkvVOoidameU+7++UHGDCGsxgUgr2lpEJXN9GNLOEsf6CW3WICn+7EWZpwqx/KBiVVOJKfTu/qoOYod0f0GIlcVdqOYqX57XZeJOMZaqtZjcnd3DP6cJJT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB9093

Apologies for not addressing these concerns before updating.  If there 
is a V6 (am sure there will be) I will update the cover.

MCTP is a general purpose  protocol so  it would  be impossible to 
enumerate all the use cases, but some of the ones that are most topical 
are attestation and RAS support.  There are a handful of protocols built 
on top of MCTP, to include PLDM and SPDM, both specified by the DMTF.

https://www.dmtf.org/sites/default/files/standards/documents/DSP0240_1.0.0.pdf
https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pd

SPDM entails various usages, including device identity collection, 
device authentication, measurement collection, and device secure session 
establishment.

PLDM is more likely to be used  for hardware support: temperature, 
voltage, or fan sensor control.

At least two companies have devices that can make use of the mechanism. 
One is Ampere Computing, my employer.

The mechanism it uses is called Platform Communication Channels is part 
of the ACPI spec: 
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

Since it is a socket interface, the system administrator also has  the 
ability to ignore an MCTP link that they do not want to enable.  This 
link would be exposed to the end user, but would not be usable.

If MCTP support is disabled  in the Kernel, this driver would also be 
disabled.

PCC is based on a shared buffer and a set of I/O mapped memory locations 
that the Spec calls registers.  This mechanism exists regardless of the 
existence of the driver. Thus, if the user has the ability to map these  
physical location to virtual locations, they have the ability to drive 
the hardware.  Thus, there is a security aspect to this mechanism that 
extends beyond the responsibilities of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device 
will never be enabled.  Thus it is only an issue on hard that does 
support PCC.  In that case, it is up to the remote controller to 
sanitize communication; MCTP will be exposed as a socket interface, and 
userland can send any crafted packet it wants.  It would thus also be 
incumbent on the hardware manufacturer to allow the end user to disable 
MCTP over PCC communication if they did not want to expose it.

Does this cover you concerns?


On 7/11/24 12:57, Dan Williams wrote:

> admiyo@ wrote:
>> From: Adam Young<admiyo@os.amperecomputing.com>
>>
>> This series adds support for the Management Control Transport Protocol (MCTP)
>> over the Platform Communication Channel (PCC) mechanism.
>>
>> MCTP defines a communication model intended to
>> facilitate communication between Management controllers
>> and other management controllers, and between Management
>> controllers and management devices
>>
>> PCC is a mechanism for communication between components within
>> the  Platform.  It is a composed of shared memory regions,
>> interrupt registers, and status registers.
>>
>> The MCTP over PCC driver makes use of two PCC channels. For
>> sending messages, it uses a Type 3 channel, and for receiving
>> messages it uses the paired Type 4 channel.  The device
>> and corresponding channels are specified via ACPI.
>>
>> The first patch in the series implements a mechanism to allow the driver
>> to indicate whether an ACK should be sent back to the caller
>> after processing the interrupt.  This is an optional feature in
>> the PCC code, but has been made explicitly required in another driver.
>> The implementation here maintains the backwards compatibility of that
>> driver.
>>
>> The second patch in the series is the required change from ACPICA
>> code that will be imported into the Linux kernel when synchronized
>> with the ACPICA repository. It ahs already merged there and will
>> be merged in as is.  It is included here so that the patch series
>> can run and be tested prior to that merge.
> This cover letter looks woefully insufficient.
>
> What is the end user visible effect of merging these patches, or not
> merging these patches?  I.e. what does Linux gain by merging them, what
> pressing end user need goes unsatisfied if these are not merged? What is
> the security model for these commands, i.e. how does a distro judge
> whether this facility allows bypass of Kernel Lockdown protections?
>
> The Kconfig does not help either. All this patch says is "communication
> path exists, plumb it direct to userspace", with no discussion of
> intended use cases, assumptions, or tradeoffs.

