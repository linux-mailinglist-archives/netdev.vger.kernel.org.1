Return-Path: <netdev+bounces-50715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C96787F6E1C
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 09:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D74D2812E7
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 08:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4134D9479;
	Fri, 24 Nov 2023 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="VcAd0yEM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2131.outbound.protection.outlook.com [40.107.20.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFE0D73
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 00:28:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6yDJiPtysXb9BM4Uw1MNCKxBQVBScQcw6FIPjl7VoiZV0TZ7cgMJYTvIRkSVe0BU1qjMH6l0VUpIJShkPiyWYzMDtGT89wiRLfxRCo7y8Iq9HuCDB7TAqakX4frCsABkigP5VokSD/e8WqUdEKAcrOR65qyC7xX5c+NTWZzRDzdCB/3I9MSDZupyZ6mlf4TGwU/hbittRtMyszFHEyblrfXChbFuu4yqgAJp+9cnLLphWsJl+m2ZpB16LoAJztZVrcU1H26RsHkkurf5NVW7OhrFzm2pecgLBFlNcQKxZmAR1VI9INBJNz3GpxQlT/SGeVCvYtYSDIoXJ1UYxA/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIeJfEymUUYlRwjqpyF7uup7Hd/VS1001uPATPddzxI=;
 b=lzLT31aXwLwz4xzcu25Kq7wccy6QbemdCGITDfc8IPJVPEiasSvd/FyjWe/fwlMGD4rHaM7FQKS1SWyywUw6Ix23XW04JW61TxlMdSmYnOgb3Ycehu9k/1n+6LSQ3+9Gc4IsLsHaqbJI8z6b4tK4QOm6ADdSDUuLD9lSn1CfmREMl3I1Bdfr2oywNM6p5qLG6nrjWkE+BuXePLNOg1HslsHE1eGGxo2r0CRyofPZKwX9MA2rbIsIhpXEoBtbfS9MeEe/NKDm9eWYZA9YREOKkphshSa8sJeNQc103urO3eYvzodGDtEj+xODsA6fMUo9iqqbfPn+t5FvutpxK7xgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIeJfEymUUYlRwjqpyF7uup7Hd/VS1001uPATPddzxI=;
 b=VcAd0yEM2aaODa82CWg64LYiy+odDAgzafTJ3YrVmIXqkGy2EWVgt+6/Bxzv6AxqggzrxoDVctOKgUmgjqyKW2c72R9hgvdntWgPO4V50F4GXoTF5d/7KwAP9tZgyfoeZBwDUiYQJhJXABRS2618fFqDXw02nEpTSMTXN4cWK+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PRAPR10MB5322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Fri, 24 Nov
 2023 08:28:16 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 08:28:16 +0000
Message-ID: <36cbb7aa-1080-4fb8-88f7-2c8da82dd554@prevas.dk>
Date: Fri, 24 Nov 2023 09:28:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: microchip: add MRP software ring
 support
Content-Language: en-US, da
To: Vladimir Oltean <olteanv@gmail.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Per Noergaard Christensen <per.christensen@prevas.dk>
References: <20231122112006.255811-1-rasmus.villemoes@prevas.dk>
 <20231122113537.o2fennnt2l2sri56@skbuf>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20231122113537.o2fennnt2l2sri56@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0060.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::21) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PRAPR10MB5322:EE_
X-MS-Office365-Filtering-Correlation-Id: bcea189e-1ca2-47d5-cfd6-08dbecc74e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+08PT4Me5UEhw1GBfblGJOSYC3w/nZ6XzIsQ8OGYZfcsJUjj2oquh5dDtNWZ6BG7hXQExGcO/Lb3VRBPYarGK9/ft5TrY0LD8UW4z14K/87703839fiyA8LLjvloXehj3kA6dzhxVceaYa6SU+At5yXVdNXVeOJZxxMgT69e2FDwuWEMeItflbHHpJ2cLUbq3rPlGBmzsWpjUAdXN+e0HOdA8xhdgky5pF4srvDFcvMl79MqwtZgDifPwnEpGLB7DQ6Aa5tin2HMaX/dY3GtToOhkatW54gLN4CPOOimR3fO7y7ev1hUbnnu0yBu7T/DMORD+zWQba2aYOq4Oi8O/HmZ+3HcEp6RJbaTsIa3aXC9o4nrspLIPUyJ6Shk7cbgh6t+qeyJvjl3NC8aXoc3/paXhF7jTSoI5kdBKkdtl414/UKd5yT+qFnXyXWFYX9KB00Sjwm660lYxdnuBGgOimN67nFPobdB+JNkBGYc76UmGZMElCVoKMdJ6yQGYEf9xmJmsojy2Hb0Np1Ppx/KZZHFgzm7asWxUESkKbMat6fUJk0UpRLq5g0Nbi7m12GEyTWNou9XcaeC9XRaGfFFFitL/+Rx98pE92HEIBijdFeOU7nfkko3aEUIMQEMJs7w21GgXYf9+qaFlM12JpMSWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39850400004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66946007)(66476007)(41300700001)(31686004)(316002)(2906002)(31696002)(4744005)(86362001)(6666004)(8676002)(8976002)(7416002)(5660300002)(44832011)(54906003)(6486002)(6506007)(66556008)(110136005)(107886003)(26005)(2616005)(6512007)(4326008)(8936002)(478600001)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjJySzB0TUd5aTl1TWwra3lNTkFJWng2M2Uxa2h6amQ0LzhZVENmcENXWHFD?=
 =?utf-8?B?MzVrbDNvaEJmOU40ZWpYazlQakNNcDVtR0FNWndEZDhMRko0U004bmFYdE1S?=
 =?utf-8?B?ZDJwKzVvV1lsS1dodjhjbFlaV1JGQmthaUJWWVgxUUFvZVdKYTY0YmRaaXo0?=
 =?utf-8?B?bi9iRFd5WnpXZWVxNUpmOUxYNFpuT0E0M3NidUlrWlh1WWJ3QUtCOXBTd2dS?=
 =?utf-8?B?dnVYZUN4Y25EY1BQZS94L2lvYnNwTFFSSW10MGNsd3RMN1IybllDaVBwM2Fp?=
 =?utf-8?B?M2MyY2dNaWNwVmRQK0tPKzRrSHMyK2JKUFc4czF3UWxac0RCc2MvSWlKa0FO?=
 =?utf-8?B?eHFENGhqOVhXcnBIRFhBSHp1ZTl3TUFPbzJjdlFqcFFEcW91dGVYR3htOVZQ?=
 =?utf-8?B?MWhKNzkxRnRRZEtGVk15RW9HakFRbmJPR3lWTWEwSDB1b2RzRWIrUVFJZlBH?=
 =?utf-8?B?MmRlMjVUNUh6LzJ6RVh0UEI5UDU1SDl4NDNzb0V1NThDZ0tOL01VQWw2eDVp?=
 =?utf-8?B?ZE1IVElYUUxYOTNjY3MzOWwxOFF2Yjg4OHBwbVJuV2Y0aElJbmpXZEpPRS9m?=
 =?utf-8?B?NFNHb3Y3MHZpbXloWElJUlpkc2JRdFhWbG9Yb2p1TlZ2VXBDK2hWMnljTGpm?=
 =?utf-8?B?VWEvZ3owYUFjT2NQTVR3OXMvYWdZbXdmUEtka1RleU9wT2E2THc1dzJiVUd6?=
 =?utf-8?B?SXpVczFoZ0dQQVVrZExUSzMvcTRnVjJGclI2dHc4U0VCS2lvRHJoZCtFdGd6?=
 =?utf-8?B?TW40WHpkekc1Ky9GVEN2YU50Ny9BbEZ6bHo1VmxzS0NFQjR5QVpPSk5QU3Rv?=
 =?utf-8?B?OXJPU0U4MWlTM3NXaEpXcllVZDFBa3dkenVrWEVTNjZEWWtTY2N6UTJSeEhu?=
 =?utf-8?B?SGc5REg5b3Ayd1VIaWtySmJnN0FpN3ZzMmdrL2ZLeUUzTHZYRDN2TjdUYUps?=
 =?utf-8?B?eE5GRm16Z1YrMWtVVjdydW9jM2s3eko1NnhFR1ZTT08vSy83bzFxcVhzbXIz?=
 =?utf-8?B?UG9hczM3NzZFSnZydlBFYmhWam85Umt1d2tQRTdxN0ZCbitMSHFtbHJYTGF1?=
 =?utf-8?B?ekU5OTFtSVd6MXlybXpXMGpmQVltMTB2UFYxNHdFanBpdkZyOU42T3ZPdk1Z?=
 =?utf-8?B?bEF6b3NaMzdIdG5YYVlvdGtWN2tJNnorcGduU24xU0sxT242QzRoUFFMSG9R?=
 =?utf-8?B?aEI2c0ZOTkV4OEVaTk01cW5zUGFOaTJjMDJ0QzdQZlV0QXBVZjBVZWR2MVRF?=
 =?utf-8?B?Z1hZbmcyRDdCbTNxS2o1em5vRkFJdHhjSzNCTVowSFNSSkhwZHFTVXRNMXdr?=
 =?utf-8?B?aFphMXpoUnRObjhSaHZTYW56UmJvOGY3em1rZHdub3RTUS9tbW9ZYXZXVDlh?=
 =?utf-8?B?Q3B1VWVmQktUMkpFbTRCVDNyU1FDY0h2dFRiNU5xOVRDcC8xcWJMem0yNy9E?=
 =?utf-8?B?eEpFV0ZDRFYzazgwMjRIZGxKbTA5Smg1TmtqV2ZKVWZrLzRPcCtnVDdiT2Nz?=
 =?utf-8?B?Q2JPU2xrWm12UThZY28zMTdVelhISUt6QWlML1BoRWI1K0ErNTk5OTN6VkZB?=
 =?utf-8?B?bDE5M3gzcnBLaVpmeDAxRUcrVXdFc3hKU3JxY0x0RmNOSzV1dkZ1QnJJTnhw?=
 =?utf-8?B?RVBNMUtGVnpGQnpZbnRPVk9SSzNyNTR0WFpSZ20yOFlVTnRjZEZ6VkdpRWFX?=
 =?utf-8?B?VkE1UnVnbWNjellIRlZ6bWVQc3BBWVZ2bmpwN3ZLNHlCYjk0RFdiZzlCa21L?=
 =?utf-8?B?VTFaanAwOEd0a21vNXpnQWxCU0JnbXZtS3RkcGR2UUp4aUlPTnBianAzNnli?=
 =?utf-8?B?YjlCTDluNS9ERXlQUHdId2NnQXF4UExCRTB3d2dZRktoVUMxTWNiMDNKY0ZT?=
 =?utf-8?B?Qjhzei8yS25VUWF2c2tvK1FydUk4Zy9BQzJER3Z3aGduRzFFdmdBOVRPVW1j?=
 =?utf-8?B?NXFKT0ZPU3gxeWN4YWJMcUlROWRvKzEvUUdiSFA0bkhFZUF5SXNQcHRqQ3ZE?=
 =?utf-8?B?R3BQVmlCdCs0V2FzMm8wendzTmdmdzVFTkhFdG1zdFE5WHR5QUo1bzlENWQy?=
 =?utf-8?B?dkJYY2ZpUDV3ZnpJaHlTbk5neFBOYmRSY1BSNzdLYjUwVFVtOGhrQ0JnUFJI?=
 =?utf-8?B?Sy9wdW5jd24rMXVuOExueklMdWdWN3pRR3QvWnRRQ0lNTzVMSUplSmZCVytn?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bcea189e-1ca2-47d5-cfd6-08dbecc74e2f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 08:28:15.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVvC7um+bj9RXQrDSUlLClCCe9UwrCxCyXi3+1j5wzN1oMM6GHp7+t0G5MZI44Wb+mseXDVBFyLNiyTrydyK3BRlIZE9yxujkq6bR9LgKNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5322

On 22/11/2023 12.35, Vladimir Oltean wrote:
> On Wed, Nov 22, 2023 at 12:20:06PM +0100, Rasmus Villemoes wrote:
>> From: Per Noergaard Christensen <per.christensen@prevas.dk>
>>
>> Add dummy functions that tells the MRP bridge instance to use
>> implemented software routines instead of hardware-offloading.
>>

> 
> Could you please explain a bit the mechanics of this dummy implementation?
> Don't you need to set up any packet traps for MRP PDUs, to avoid
> forwarding them? What ring roles will work with the dummy implementation?

Hm, you're right, of course. We will have to check what went wrong in
our testing, we did believe we had it working, but that can't really be
true. So please ignore this for now, sorry for the noise.

Rasmus


