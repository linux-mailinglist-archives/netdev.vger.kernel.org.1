Return-Path: <netdev+bounces-134254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B629988D0
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F11288D26
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E1D1CB307;
	Thu, 10 Oct 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g76EW346"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9631BDA99;
	Thu, 10 Oct 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569383; cv=fail; b=Uo7Ivfi98krtoklcBK559EnPHD4B6li0nuYYhsA2Fp3WCu5F177y/ih7cWqqe2nb0EPyT5gdTfXJeJjKA2o0T0Gz/+cjyqkQvdZWMLZQGO23+VNL7BWpdmsbLl/AqRIrn1aY77Qyy8eBDGulegaZGd0jZS1uR13rHIGQP1zR9qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569383; c=relaxed/simple;
	bh=7XXiLMPQ1CAhUuNh3ZRgTXlozj6GvORQlg5L8c3Q8jM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SZQgz4U7WG5do7LjjKolYH7fMADpkyrYurfO/bIGORsvFPSc6yD+v201mk1+WryoCCzTv1V+shGR5hxdQIaeCDoDsJgeXjaFmIYPZwQfzAYmt5tMlZzRz5BG1A8n6SEaIXjGZ04s/Cl178HwcbwA2DkDbEToCn3YlsUFTaRUUNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g76EW346; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihn031wCIZfojG6lJpIpXp00tCgTmzpDH3bA+B2Os8sG42VVhBSyY3i23+Ri2v45n7Q16NT/UGemCGcUZs8sid8j9Mnnfwgf/6QsaSmXodV7AyRfL7GVhu7c5TBhabi5DVkS35hEqPYUHQFR01HgJVPLLRg8AKo9vilgYi2JyiZx/5SzkKIHHLbyaFp6ep18YH7RDtBkVR7CG/PRPAA7naQLiMEBUYT9rL2sVIZEYPZfj/HxT7H+CPYT1dgpg87t6nKaWo6S09Gs7KJkGYTHqP1y/GDILvCNWfXSaKJKHfPB0lYqBVPti2nubUFH/hQKFBtcTNizb1sbRkRtAz7oMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dfkp2HRMD4SKy3GSVHf+SBtjTZnh+e4FdyQIK5l7xd4=;
 b=sb2T9TSd9pzN6qwhuBpionxZX6SopQOIH8m/pk65AdKPWgGS96IFq8kM6bNPpSi8kuRCgKiRTgAwNNT0x9kgfiR8ngvbkQ9g0rtlrXeryWOHgZ2OPhPakzl8WNsxPA2Uy7GlKejIl7r8uQEHxhDLt9q3xtPQ3i7zHsF0yi7x4nyS+PaPgVyIoSN98gOCD1IrocI0M+evty3gRVjITvHCMZ9InqEACr8zGIVVt/C0rpU/vHtAc71AscpCqmb0fG31m0f32WLVMVydl7KONkW/W1OaxMwgviPzHJax06B7DR++3rDaTzOvyKh/d6tgijsoVhGCh6aUgsK30QqTSJN3ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dfkp2HRMD4SKy3GSVHf+SBtjTZnh+e4FdyQIK5l7xd4=;
 b=g76EW346V34QenEHClzBGwxP6EYCCQqgiV6Imhq5vSuKpS8kX4f8JrP8Iy70jUm9SNip2AMWOv9VQWU+T5+b5fDSKKRcIs4etNPmuQdpAdtKTsTo1SeaeKaGouKcHqzmcPUn4vDJNjlQnNHAhf45xYG5E9VX3bgMVRjLbuVaxSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 14:09:30 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 14:09:30 +0000
Message-ID: <6fc42ade-66cf-4462-914c-3dd5589c9a9f@amd.com>
Date: Thu, 10 Oct 2024 19:39:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 4/5] net: macb: Configure High Speed Mac for
 given speed.
To: linux@armlinux.org.uk, vineeth.karumanchi@amd.com
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew@lunn.ch, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
 <20241009053946.3198805-5-vineeth.karumanchi@amd.com>
 <ZwZKumS3IEy54Jsk@shell.armlinux.org.uk>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <ZwZKumS3IEy54Jsk@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::11) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cac6d0a-779c-4409-f177-08dce93528ba
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGc3VlA4dGd2NE9uR0VJbmxFcUM1VkVDcTdza3M1bWZxbUJiVjdJcDkySGs0?=
 =?utf-8?B?V0pNYWthb2RocTBFUFpiZDFBQVUyNU5VL25kWUZLVkR0WGJjNWNpc3pYZVI5?=
 =?utf-8?B?Ykc5c0pvYXdoOG1pMFdOMDVXbklMaFdLNHJyVEF0TndvVXlSUGN0MldWM3NJ?=
 =?utf-8?B?aHlxelRWd2hncGpLOExxUzdOVnVoUkh5Tm5HeENxdmt6cGxZTlU3dVJ2Vk5w?=
 =?utf-8?B?bm5SWXdqUkV5MStzQjFwTlpiTkxkRjFySTZVaGp3VW5GR1c2UmFzaU8rR3ps?=
 =?utf-8?B?ZXE0TFpOa2J6bHVCMS9kZkt4bWlOUy8vT1NFNUdBa2czdVZyR1paOFk2ekZt?=
 =?utf-8?B?ai9BUUl4MTVlL3FaQzBvU3QydkNtZzdWbWNZUFRqdnAyV2FYdXVNU0lHS3px?=
 =?utf-8?B?UHpkNXk3NkNzQWp2WXM5QkgyRWpnYzRET2d5R1lTK21adVIxQVBsWkU1QVVH?=
 =?utf-8?B?M09sLzJYYXVrampJbkQycHdodG42SnhNekdTYm9iVmxQUk1JTVNPclE3T1Zr?=
 =?utf-8?B?YTFNUi91c2dRcExZdW90NkVvZTlsMmtZWHJOOXYzRVdlV3JRMGpSWkRsKzBr?=
 =?utf-8?B?ZWVDeTFjU21sY05vTG03OFB1UnlmYjdOVXlURElvN3gyVjVVVGVZaDBVcUFm?=
 =?utf-8?B?WVcrMWp4cHBxaDg3MCs3S21UYzhFSkV0NUlEWGlleUxYdXM1aVJ4aEVkajFI?=
 =?utf-8?B?UUU3VmJ0T0JFeG5wVVA0cmxLNjU0VDg3WkRMcTZKN2JxQndzcWpEekhIRCtk?=
 =?utf-8?B?VU9Dbll2Q3MwRmwrZzZicnFLVmwreW1vWkJsYXkrWFdmT2YyM29IQmROR0I0?=
 =?utf-8?B?K09XUkJiK3BSUG1xNW1TWE1McHZZejdHaXQ5dnBQalpWWEVFS3ZlTG40bVIy?=
 =?utf-8?B?aVd1MmV3dEtKbHhXTDJ2bmFibUlzMlFzdUppYXdXb1hMSm14R2N6V1g4UGVq?=
 =?utf-8?B?RTM4UkRUakZLbW9OTkhudUdzMVR5bjlTa21EV1dscS8rbG1sQUV0Rk1OeWNp?=
 =?utf-8?B?MWdlVllqNlR3dzVLSloyM2JwdTJRN2MrbUh5U1BqNW1YM0hZWC9mcEVaQk9v?=
 =?utf-8?B?cnZXQ0xYOHo1TFJGcTZhWjZYZWY5OFpSc0hPbWp6Ry9BeHpmU3FUVy84ckFO?=
 =?utf-8?B?MFU3SktkMEg4VHRacEoyNnF6Qzl3b2Y5QUljc1o0WXhsZEkzU3lCQTBvVUZ0?=
 =?utf-8?B?ZXFZSmYvMEwrbTVKUk9qc2VQU1oySHdVZFg4ZzNrWThoYnFkMEtrNVZsZnRk?=
 =?utf-8?B?MyszOU1qNmFQcU1LZ3RIOG5TR2tJR3ZpQ3RwejVFYUNra3FXR1JCSktCMEsx?=
 =?utf-8?B?eXJsNHJpQWFESGtqa1pnL0tsRUdDaXRwZjRTVEo0TDRxT3NKRmhFcTJSUXZt?=
 =?utf-8?B?eHZDazNEOVdpK2hTRU1xT284Zk93d0RJMWpSNHRzeVdXMTk2dkgxckkzVmxt?=
 =?utf-8?B?SE0vbHlqSVlvWVFqRWRPV2F1WExWU2xqeHlCS015L20xMTRhNlBsTEl6STBx?=
 =?utf-8?B?SG5oazUyczlKajY0M2ErYlVuajA2RDBVa0FEdmg5K2pyOFJEcVQvWWVON1I5?=
 =?utf-8?B?cEFKZFRLNVc4NEI1dHUwSTdpUWZBMFhoRWIxd21lVEJHWXBqblBybXhRaS9s?=
 =?utf-8?B?cXgzUUJaYXBXYkI3K2pWU0hmMER0ZkhFbjhvZ1lzZ3VnaHNaUFZ1ZURwOFJv?=
 =?utf-8?B?MWtoYkY2YTNNaEs4STY1alJjLzRBSklCLzlKa09vMVV4MUYyNjg0a0l3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDFXSmo0aDhvb2Fra1JGWFRJSGZzWXJycnNnQjR3NG9iT2w1Qm5pZEZSTjha?=
 =?utf-8?B?Y2dRVjJRK1FsQUtwbHlEVmxVeXRrMk1kUDJ4STNSQ3JTSGg3aUs1dEJCM3A2?=
 =?utf-8?B?KzFKR1BUd3BFSHBJRzE4a1BIUWt1Z1lLNW1WZExWd3FoRURzWmtPMmRpUkRM?=
 =?utf-8?B?QkIwdkMxNVRpSHU0aEZoL0dEMzFaZUpyZXpCTjlreGRzMWZCR3hoSUhadVlG?=
 =?utf-8?B?dDdVZzM1RTlyMWIvTTRBYU1aVnExSkRvY0U5Y3hKK1V2RURXeU1UWXg3cGM4?=
 =?utf-8?B?dGkvRDJ3VCtoSzdPS2NYc05SQU9zQnFqVjBIRzBDSlRycllZbzNjN05XM08r?=
 =?utf-8?B?aVB2UFFKSU9VYnlITHFTWU40ZUs2aUI4UVl5dkw4Wk1oVUJDazNPcmxONmdS?=
 =?utf-8?B?dmV0ZU1TN3Vxb2xDMjVKSlYrSlN6UzBGMGZCTlVaZ3cvSXNEU3MxajVPTmVN?=
 =?utf-8?B?bzliSG1UUkwrSVdkZ2lOOVZLNmZBU1lmRkR1WVVDNTBlaUJXYklmZXlwckMv?=
 =?utf-8?B?RXBIQjNOWGhXRXFSWXF6eXFUTDR1QTBvYWhhWlI2dnErUGhmdGJmU0NDN3RT?=
 =?utf-8?B?LzQyK09qNUh5ZktZRTc3ZlN0S0tIcERGRENFL1dvNGJvbklZa2pkNHVCQkor?=
 =?utf-8?B?QmdMV2tINzMzNFhjR1ZVQlpvY0hkRzF0TXBPUURMNVc3VFlTWXBIVTkvUU9K?=
 =?utf-8?B?ZmFTMXFnTjBMK3h1VWo4MXY2dk9xR1hyRVl5enE3ZGVDUXpkNGVDS2lzRXgr?=
 =?utf-8?B?NjJGWUxmQXRNSnpsb0NqdllCb1JoUGhnbExRZ0NYM2RzcGp2dUt2dEJlL2U4?=
 =?utf-8?B?SGRNTnRybjFhZVBMRjdaeE4yMmRFUmtjS2RHTHFzN3A1M3l5N05aaVFwWUFs?=
 =?utf-8?B?K2NReG42ay9KZDY4TDliOUNvMTNEZlh3Qm11djFBcm1nbUJTb3VRdzFUend1?=
 =?utf-8?B?TXlVL0FHY21rb1g2bC8xV2luNXlFQmpMaDhwTGxmSEx3R1JyQXltK29ieXBm?=
 =?utf-8?B?T0xuNkVuQnFVVEFQWWNvVHlhdFp3MFAyS3N1ZFRlaW5Jbzh4RUxMTEZTaGlG?=
 =?utf-8?B?ZHhuOE9IRGNrMEdRUU1FQ0hMUFVFTDBEbUpyZGgvd3Y0RmdnWUlGR2luMGFZ?=
 =?utf-8?B?Y3Nva0NaMTlvUTYxVkRyLzRpQ1hoUHZFQk9Ra0o2dXFMT3pOQVlCS1QzQitH?=
 =?utf-8?B?bytaUGNNVVdFOTY1ZTRsWVdNOEdONnNHMzJOckY4eXJKRUZ5S3dkRkg3aDNi?=
 =?utf-8?B?UzMyc08xZ3hRMFRpWlpGNmpSRFcySFVvNnEwUHljU21USjNWZkVjMUxxbU5B?=
 =?utf-8?B?UW1pdzFFYTNBdk9WR0ZhL0VDQlMrOEtVOHVoUWZXNzhhUms5dyt1T3lpWnp5?=
 =?utf-8?B?aGJvUGxlZjFndjViRjl5L0xhdFYyYmV6VStMWXgrSFN3Mnh4MkV2Mkt4a1Ri?=
 =?utf-8?B?bUZKYjlxSTJEMGo0S0U0d2hqbTI2d1dtSjhIWWtGU3pCZFhQMndDZnBDUzl1?=
 =?utf-8?B?YmU3VDZZT0Excit0R2xMT2ZFaGhkdllFSmRCWG1PWGc4WlNwZ1MzVUJUNm1J?=
 =?utf-8?B?a2RVRzZzZkpCVWZEbVkzdzc0emJNNkdQWVFkMVZYSWRON281YTQ2bFJZY25z?=
 =?utf-8?B?aUVya0pKaXFIYWg3bUROcEg1bFYzSnppcm5vV2htZEY5VzdVd0t5SC9mZHlx?=
 =?utf-8?B?RVR5cWZ3Z0RNeWZiRXV3YVc3NVI4MVo4T1JGV2JleTJsYTNVc3p6bFBnSWZZ?=
 =?utf-8?B?ejJwMGpRZzZiUnZRZW1zd0RDeUMwbGErcDhReDFuWHBUd3FadUhERE9RZTlL?=
 =?utf-8?B?VE9RVVcvT280TWNRckRnYUFseTlXRmRpQkVaNVlTMG0yQ016dERpRmFGM0lN?=
 =?utf-8?B?Q2VnS0tBOEpFa2Z2SFljV0FRNW5Ld1NZRnpFaGJhaDMxVG4vMzgrTzh0WVZS?=
 =?utf-8?B?eVQ3bnZpckZJLzhBZlZVeTJiZ0dIZ09FcmtzWFFGMnNwZmczV2hPL25ISG52?=
 =?utf-8?B?aWVjYnA1bVIza0tCQ1dlNEtteUp4MTVxYXpxakhCMCtqV3RDMkw1cFg5L0Y4?=
 =?utf-8?B?UEhRbENDZ2tYNDIvc3Fyc2ZISllsVngyaDg4d3ZBWWp5T1YwWSt6N1V4cG82?=
 =?utf-8?Q?Umr2yWOoCPm0z3pz+bF3NY/Zr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cac6d0a-779c-4409-f177-08dce93528ba
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 14:09:30.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQSIbmpBP9SXUFnt7GhgEhBGADjYuYoBXrCEeVuQHl4SpxcRuA48niR9pbHCeFqr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391

Hi Russel,

On 10/9/2024 2:49 PM, Russell King (Oracle) wrote:
> On Wed, Oct 09, 2024 at 11:09:45AM +0530, Vineeth Karumanchi wrote:
>> HS Mac configuration steps:
>> - Configure speed and serdes rate bits of USX_CONTROL register from
>>    user specified speed in the device-tree.
>> - Enable HS Mac for 5G and 10G speeds.
>> - Reset RX receive path to achieve USX block lock for the
>>    configured serdes rate.
>> - Wait for USX block lock synchronization.
>>
>> Move the initialization instances to macb_usx_pcs_link_up().
> It only partly moves stuff there, creating what I can only call a mess
> which probably doesn't work correctly.
>
> Please consider the MAC and PCS as two separate boxes - register
> settings controlled in one box should not be touched by the other box.
>
> For example, macb_mac_config() now does this:
>
>          old_ncr = ncr = macb_or_gem_readl(bp, NCR);
> ...
>          } else if (macb_is_gem(bp)) {
> ...
>                  ncr &= ~GEM_BIT(ENABLE_HS_MAC);
> ...
>          if (old_ncr ^ ncr)
>                  macb_or_gem_writel(bp, NCR, ncr);
>
> meanwhile:
>
>> @@ -564,14 +565,59 @@ static void macb_usx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
>>   				 int duplex)
>>   {
>>   	struct macb *bp = container_of(pcs, struct macb, phylink_usx_pcs);
> ...
>> +	/* Enable HS MAC for high speeds */
>> +	if (hs_mac) {
>> +		config = macb_or_gem_readl(bp, NCR);
>> +		config |= GEM_BIT(ENABLE_HS_MAC);
>> +		macb_or_gem_writel(bp, NCR, config);
>> +	}
> Arguably, the time that this would happen is when the interface mode
> changes which would cause a full reconfiguration and thus both of
> these functions will be called, but it's not easy to follow that's
> what is going on here.
>
> It also looks like you're messing with MAC registers in the PCS code,
> setting the MAC speed there. Are the PCS and MAC so integrated together
> that abstracting the PCS into its own separate code block leads to
> problems?

Agreed, Since our current hardware configuration lacks AN and PHY, I've 
relocated the ENABLE_HS_MAC configuration into PCS to
allow speed changes using ethtool. When more hardware with a PHY that 
supports AN becomes available,
the phylink will invoke macb_mac_config() with the communicated speed 
(phylinkstate->speed).
It is possible to make ENABLE_HS_MAC conditional based on speed.

Currently, for fixed-link, will keep the earlier implementation.

Please let me know your thoughts and comments.

-- 
🙏 vineeth


