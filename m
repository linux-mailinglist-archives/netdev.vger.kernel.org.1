Return-Path: <netdev+bounces-117623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A062D94E96B
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F181C2169E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B985A16D324;
	Mon, 12 Aug 2024 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l2GF36cR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033B1586CD
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453914; cv=fail; b=Bo/hSsrbKP/oAQ9i9jc0FGEUY9eYtRLVlhHZpsnNpiC8hTBiXZK/YSKgIRQmjwF0OJpPkXZcY36QLp8z1PFZYw+nUK974all1imjX4QP/ZitZdGMqnR+X6EiRHxn7UOhorw1yKwLMHUNgOMr27GJVd9QM1hlo9WahvgejYH1s7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453914; c=relaxed/simple;
	bh=861JvugztAb3z/cocQXxFYYkAg7Ao4zeX1UCTjKTs0Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WfNQACEj3+87t1i8HkrNxFsx9VDuAd96U3+aCrgLhOeeUB+K2WeCHPaESuutI7YjY21OLqkIXYuc5iwdaurKk8GT5CAv0Ji80TTr5+x2Ylp7LIGqpFGvgtDiVdXMb9T8J3K3HyVf1fcXeQF+aHvJHn9TXK1EnxbJG6K9CB0PlJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l2GF36cR; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vW5tgaoORZewgklMp1jtSfrzsipUsJwFfWjB2/ZSzwWK3kS4ZTn97nw75kItn4uXDoLDF8xA1hLaEsaB5m60eiN+agf2LlrySy3GWAVxFlbbeJZL7SjTaCRqZ+pw3ehQjfgQEZsRgSONKU8LHge3Ilf5v/i0g9NVBdgVYGjmEllhzUD1oydPac8krByhAHSBVWSFaDouIlimOP6DO2Q4CAOJFWsz2Mi4xPifvoKxCSjje/ZEwgtBZSWckgxRs4J91ISgBuE7CPborFIjivP5jsCmFPfCZdPWbK4S93DJf9FfLA7tqCwNQ4kEV4PEswxaCd0Azo+F+75N5VPG5wvVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eob7yQCWkPRSCOcmffUFJnBTMixoXbzpTfridgItRsc=;
 b=aWw3Ih0kP6LEBi7pSJM5ZtYxTYrHYy1g0ML+yVePOdL6ZncUAEe9m8mXbeEyksQXEFrLcUiprxAfTtkm6+/2w6h4sWam0al68Rtqne2QtgbneekdWhWfBNtkmj7B+IoJs+41Cce6zbsRL26JN8XIcFzhutf8xGNUAjrGCDTGxTUKtEqHLiKksPZlsvV4OZPHF79OhlS11jrxJqgbKY39YGtAKbTSiX3SJrQJcnz3kB6XEcLvYfHf0XQkLWcfa3s1w3X+HuLSliYLs8Pl9y48PkJIvs3Jak67rZ5cr2b5K1fUFiAVHJrrKIBCrOQz5avIwQKJdCmUUxUidbADncpzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eob7yQCWkPRSCOcmffUFJnBTMixoXbzpTfridgItRsc=;
 b=l2GF36cRl6KouoKusFSML3XfqhR2Q+gqVg74hlMjGZ767a4UJF7SfHWe8s9nTHZS0n98qnIyoJjJvsMB/huWQ4u1LRhnuuZGqm8SVEA5XeZXlj7I2IK1fXhlpFNqsFSZrs52iOWWpVTNknNPKAvapxN3Lw0CoRuFf/k5V6/rnbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 09:11:50 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527%6]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 09:11:50 +0000
Message-ID: <733568cc-0a7d-4fc5-a251-2032fb484a4d@amd.com>
Date: Mon, 12 Aug 2024 14:41:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] net: macb: Use rcu_dereference() for
 idev->ifa_list in macb_suspend().
Content-Language: en-GB
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: claudiu.beznea@tuxon.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 nicolas.ferre@microchip.com, pabeni@redhat.com
References: <7a61eaff-3ea4-4eba-a11f-7c4caaef45dd@amd.com>
 <20240808044516.12826-1-kuniyu@amazon.com>
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
In-Reply-To: <20240808044516.12826-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a57016-62f2-43d2-66a9-08dcbaaeccbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFRzV1BWNXpXZWd3Y2VoeE96TDE3OFV1SlFmTXBhbkt3cEIwY09rK0RYZmEr?=
 =?utf-8?B?TUZORXEvakhiWkhmdUFmWVl3S3NiNWFmWWh1cHNSZG9Ubm41dUVyVFhGV2xv?=
 =?utf-8?B?UTVQS0dPanBYVTY1Zy96Z1dwSE16ejVLRWg4Q2lUUm8ySDZ2cEkvdEl6bG1y?=
 =?utf-8?B?L3hiWktRUllIUkVmNzEwYlIvbS9YYnE4cCtMdzY3eWR5bFFncWhiOFZHbkgz?=
 =?utf-8?B?NktoT0lQN0hsbVpFazVyRjF3OHA5bjFFSFhVYS85YzJMeUFwMmdlMFMrRm9N?=
 =?utf-8?B?UkZmeS84WUcxRFhhMXdKREEzM0hwOWljZnlHV01CZWxja2ptYWI3Q1FjQVJZ?=
 =?utf-8?B?Z2J4eWdQSnJQUzJEbFZpQkhqNGwyOE52OXFjbGZsMzlscTJkb29WZXNrSEpV?=
 =?utf-8?B?UUp3KzRaZDFEMmkxTjk1cHBmK2hseUVPZmtEQklmTDgrbGtLRjk4SUU5YVI4?=
 =?utf-8?B?akV6RkRUa1BFd3ZpOFUrS20xTmRyd3owYTRwbkZ0bldhaXhMdWFTc0VRaVRo?=
 =?utf-8?B?RzhFYlA0MlBObllhUTN6b05OY0NJTnh5SlV3Nk9qMlEvZmgzVDNhL2I3OVhq?=
 =?utf-8?B?TnZEalRYSG45UElnSnpRKy9ZRVVaVlFhM3p1ejM2MWJqenQvWTFCUUk2K1hH?=
 =?utf-8?B?Y3RSeTFva0hpMmpTTVJRcTlPUVJGS2VaNUU5T08zWFovM3Y2Z1NTNFhsYWl2?=
 =?utf-8?B?WGExSTAvMWExQ05QY3VESUIvMnN2cjZDNVNHZ0tsR01wUjVKWXR6Tyt1WWZC?=
 =?utf-8?B?WG83YUlOdTdWV1h4ZGxwT0VnRVRRWWwwWFFCNEtYQkRxcTNtVVVhb3FCTmRZ?=
 =?utf-8?B?WUpOd3ZabXBkRXgvdG56RlVZSmVRb1o1a0dLMkhuTFkzYkVUbm5Xdlorb2ds?=
 =?utf-8?B?RENDc2xrQ1VmbnZmbkRJK0ZWY1ArWDJJL2RzbDVIWTJNa2FBNG5YWFI3L0Fn?=
 =?utf-8?B?TVYzZUd5L1ZST2RpQm85V2dDSmZCODZDOWtFaGVnVzFGWExaeE44QzI4MGt4?=
 =?utf-8?B?U3lBZmEzbVBTVUNpc29kb3hIQlZReE9NM2o4SlphRWVvWjZkc1NGRDdXUU5H?=
 =?utf-8?B?dFBXKzl2cy9ydVRwK2F5N2Z2WEVzNTI5MVhJMld5Z0VYZFFyUlo5dWg1dnZU?=
 =?utf-8?B?NW9TQjZLY1pSWWR6MnU0QkdBWWlHUVJmYmI5QUJsWC93VXlScWxRd1R3T0FI?=
 =?utf-8?B?d1pzeWFmQ1RaZUQvOEpuRW9kdStENnJ5T0t0cHcwQkZYb1dMMWRtODVGNFVn?=
 =?utf-8?B?a3p5dDJUOHp2NzlRaXFEZWl0L3FEYldaLzlhdDZOSmRLMXFBWEhUdWEySjBC?=
 =?utf-8?B?Q21GOUJ1dkJGOWcxYlRub2oxVzdOKzkvNVhNV2NBTjlUMlZ2WmhKNWVDZVM5?=
 =?utf-8?B?S2w2eXArNWk0aVcra1NNYXIzQnFwTXRxdUU0d1dnWlFFS0g1MmNONTJkZHVF?=
 =?utf-8?B?WnFlcklXa0owWUEzU3orRUlBZVBLcU9aNDI5ck15MFJacnVBbnhHTEJWUkQ1?=
 =?utf-8?B?WURSRHpDTnV6VEJML29YMkhxUHpWR0pVcDhrVjRSWUtDZXdCL2MyYTVGVlln?=
 =?utf-8?B?OW9kWDI2U1B0M0hWY0xpQ21TSlRJaEdFZlJpRG1SS0lrRDJXT0JkZy9hcFRo?=
 =?utf-8?B?YmdVSVlCNlVmMWorVTN5Z2VBQkhPeVVhZzJYaGN3Tnd2SnEzZHJUc2NaS2tP?=
 =?utf-8?B?aGJXUXZKZi8xYW1BSWhCQlA0VlZ4R2hJUGd2eURxVDNMS2JaeFhrT3dIZjl4?=
 =?utf-8?Q?pBOt8jHqQ1cokfglcc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEdlRy9hb1V6TktPRVJ6Uk5NcHcwVXdMY0t3K01Od1paT29qbzFkSmdkUzAv?=
 =?utf-8?B?ZGprOGVzbUpSQjNGc0QrME5MTzJGWnQ1WDBzWkVQVTZLclVjUmt6M2FybVNJ?=
 =?utf-8?B?Z21XZmNSTmhNb0lIeWp4aU0yUjJYTHdDc2ZoQXpWbnpsSkV2bjZNL1B5cVdv?=
 =?utf-8?B?d3hFQS84K1RobXhad3VnZ1ZZM1p3TGhIenJ3c0dpNE4xNCtyclZ5TzJPYTVs?=
 =?utf-8?B?QXIyQlQzOTdLVC9UVFZydFFwU1AxWDN0M1dxMUZoZWVrbXJCTG9IRmRKRXVM?=
 =?utf-8?B?d3h0NndyRjFWc1RJY0RXSHVpZUNFbHA5QVc0TVNtcXdwR1VxYkphZ2krNitB?=
 =?utf-8?B?empxdnlFc2Z6M0xhSVE0MUpDWTNYclJ2dTBvL21Xa245cEVSUlAwbFF3Skhy?=
 =?utf-8?B?Q1NGMlE1dTE3TkdoS2xYeGdTODMyV05sT1RmR205aXBTT3JTYTBpZDQzdzZ2?=
 =?utf-8?B?dTY0Q25iTDk0disyVnNRWU9vVG5DZjU2N1NCTExWZ0xBckNtUytiTFdTVnVG?=
 =?utf-8?B?eUpaSkFPSFJRTUNseThxQ2txVjVvSWplL2k2T0xsTkZHV2ZwY2F0TzZtaXBh?=
 =?utf-8?B?alBhUUw3WjVobDBUZTNabUdGTkxCVUZnSGVMa0tvREhyODZtMzBrZTdDT2Qz?=
 =?utf-8?B?NDVJZnQ0RjhDQ2lqVnZPWmFXN3BFcnliM3NWVndSNFF6SXo4UC80eWc4K1F0?=
 =?utf-8?B?dGlGSThlMnhLeDdRenIwVHpRNjBGOWZkc0xPWmx4V2RlWE9Gb1JLeTF2SS9s?=
 =?utf-8?B?SmFGaGpDT1VIdERLM1VtY3RwSVFOSUlCa2xlMlBycXdSY09ITE1HdnJPSzZQ?=
 =?utf-8?B?ZlNWYytOLzdvYjBwMUJ5RElXclNjK2QwUmgyTXYxL1RFSFpDeTlnSTEzdUNi?=
 =?utf-8?B?Q2U5YnJCYTJaeFJNMVlzTU42MGNydCtmMWp3WE9KUXRkd3BqMjlrUVdKQVNr?=
 =?utf-8?B?VkQxODY0bFJrekVCakFCcTRINjZtSDRMcjdoQ1JYUVNNTHA3RVVNaFArWnF4?=
 =?utf-8?B?MEk3bjlOQ0RsTlBTVHJVaGNqZHhjMEt2Zm5CbzM4dkF5MFJobFBlWmVmVG45?=
 =?utf-8?B?WktXNFBJL20vL3g3M2ZUZW5RdzFZbS8xVjZ1QkJ3NytOeFlsc21EcTNaakRE?=
 =?utf-8?B?SU13cWRDNnVVYnFIWG9tZ0RRdm5Ib3FtTjcyV2lZQy8waEsrWWhJL1JWeUl0?=
 =?utf-8?B?ZmFsOXByaTJaVzdTdDRiVE1laFIzNGpZNXA1cGxBY1hWaG54WU4zTFlSTzZi?=
 =?utf-8?B?WS85eWduREF1ekEyWkdYemp0VzJHaWoyQUlpQThuWTNzNjZTZHBTOU9VS1Ns?=
 =?utf-8?B?V3N0aXRObTZMYzBoY0xXdDRIR2tZenNzOURpVzNrRU50UTBReUlkdi83bnVq?=
 =?utf-8?B?dTRNWDBFdldMcThNa1VBYnIvVjRFV0hDMDJ6cmJpVVh6K3Z6ZERISUh5cnBx?=
 =?utf-8?B?K1JnWnB6N3NudlhYZDc1QytsMTdNMkFGVFVKTVJTd0xxbUpuZVRPU1lYclUv?=
 =?utf-8?B?UkErYlF1bE1rYnExMjFndGpHSGlrcUYwZW5TMzFXT3RDUEE2ZXN5NWd3WU0w?=
 =?utf-8?B?c1FucGNMZVc3aEh6czZtNWxJTTV2QWZ3aXBEQTlZUUFFUjJ1amlHUWdzZTd4?=
 =?utf-8?B?bm1CRXZzVW92UUdleVQzNm40WkM0Zkh6M29vemxDL1NRVU1tcmJkMlF0QmFX?=
 =?utf-8?B?U3oxN3NMUjVodlJkZUxWREpVNUx2WkFpa2E5OEhVd0lWNXcxTXF5M2FYYzFn?=
 =?utf-8?B?TWtYTzAvMWhJdmJrdElpNlgrT01oS3hqWDNhY1laSEQ2TWJoc2crMnlYdUxW?=
 =?utf-8?B?OGs5TVFrcGh5S09EWGllMWRJNlhHQ0FRSHN0THQ2SmxNdmlBUmU0aU9nMFV6?=
 =?utf-8?B?MEkybm1MODF1TUNXdDNmV013UXNvblJYejN1bWQ2ek9rTWVMUHNQbm9VZnRJ?=
 =?utf-8?B?V0lBN050dFFkYTBWdG84ZWZlM0N4ZVU5dE5nNXRFZ3BaSVJMaVYvejVDeWkv?=
 =?utf-8?B?YjhBR0t5LzVWYjdPS3c1RzNyN1BKeG1Oc1VHZHpXVUp6Z083bXNjZ2dSc0pT?=
 =?utf-8?B?NW53WitzdGhDOEVZQjZaVDFFZWw0NHN2TUF5MkI5RVc0L0pQODhsVDgySkVG?=
 =?utf-8?Q?yVV9sGc5Rum1pFOkltrCiQWbd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a57016-62f2-43d2-66a9-08dcbaaeccbe
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 09:11:50.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASu7e229vKZYsCl5YWhAgUnykT6fGDcf+QM2/dLeQPkK9scaB/MVp92egiL592Le
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046

On 08/08/24 10:15 am, Kuniyuki Iwashima wrote:
> From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> Date: Thu, 8 Aug 2024 09:53:42 +0530
>> Hi Kuniyuki,
>>
>> On 08/08/24 9:30 am, Kuniyuki Iwashima wrote:
>>> In macb_suspend(), idev->ifa_list is fetched with rcu_access_pointer()
>>> and later the pointer is dereferenced as ifa->ifa_local.
>>>
>>> So, idev->ifa_list must be fetched with rcu_dereference().
>>>
>>
>> Is there any functional breakage ?
> 
> rcu_dereference() triggers lockdep splat if not called under
> rcu_read_lock().
> 
> Also in include/linux/rcupdate.h:
> 
> /**
>   * rcu_access_pointer() - fetch RCU pointer with no dereferencing
> ...
>   * It is usually best to test the rcu_access_pointer() return value
>   * directly in order to avoid accidental dereferences being introduced
>   * by later inattentive changes.  In other words, assigning the
>   * rcu_access_pointer() return value to a local variable results in an
>   * accident waiting to happen.
> 
> 
>> I sent initial patch with rcu_dereference, but there is a review comment:
>>
>> https://lore.kernel.org/netdev/a02fac3b21a97dc766d65c4ed2d080f1ed87e87e.camel@redhat.com/
> 
> I guess the following ifa_local was missed then ?

I am ok to use rcu_dereference(), just curios why the check 
idev->ifa_list was removed ?


vineeth

