Return-Path: <netdev+bounces-48319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC747EE0B6
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB191F254F0
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC812D78F;
	Thu, 16 Nov 2023 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="qHJcWgG7"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0053193;
	Thu, 16 Nov 2023 04:32:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myhU/Kec4/HCP4xnLHMYavWJLD3XJcpuPdUT1aobzO6Y8pEWYaDcGeN7F3BWT+lTSNsM9surinY6/WFUXDEXwI1sDPeJfYPPiVCoMN+JHbEn+NBvnWtdLOX10p6XE4/GIttCS9ewydhFXzV6uume2CU8lpkqEQg5gfEUfxgxwPng4NuvLkzXYH2GKDdAWP6ue/ThYNZMyOk5Cnyxa1Z7eqHFa52rNIqKjJeLhfTkuHkvo0lp1teTPwDTv7+NNEmr6b24hBBlF9QFdHZGre8CgVTQD69FzTG2FF1eFgkUO+m55yMyfJV3gaSd7B2Aen2qdx1WY0zSCGa5qo74dG/9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erSNOIqkYfsj7ghnepi8x+WnXDMD9UUkmwsu/mDE8TY=;
 b=EpiatL1rW93hM7/07vM0QYFha7novmCT6s0AMLzl1WoTH1wk42udqNSiIHovP8sV1TCU4Ib7HdM0KQRkfYlOIN3RWJGazoaBL4O30AxJghAxI5Sxc3N87t+3wskK+k7bGEgYbRBk+oICHCTYImroQfrhft/FVQqlF8URvdyl6TounsiuYp0VZAJ1h3aSKIQZMFrPWvB/fW4J0TsYGwyXFrKSM+pz9HNByB8xBM/Tmul/cyk7pq7CzlEMppmNyMn1m246keIsGgGQDWOcg8N6auHb7snMuibR5l4srRImIxMrWE0Nraxzgyzbl22vrfaPkws3yHLDLwq0lGkc+MqS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erSNOIqkYfsj7ghnepi8x+WnXDMD9UUkmwsu/mDE8TY=;
 b=qHJcWgG76Sioz2RB9e9z9SWXvPys/Po9KOZlsyzRYm0MSxBUMw01inW2GX/KOVIMg4cz4ZqKopsQkJb+7AUUCFjvr26wUuhZiGSVuDOlZ6VfmXWseNnBaGle8J7BNumU1K4ng7jcmw0TOfMxv3tKMQmc9GM0hGOD660eCRG3Xd6EIdNItq4CEyt6Ej99A2b89Y41aKraQcfu2c6uBZfr8H3U9HA1zLhrn6ku2bZ4kUTURka1DkedL3PRGJU6GubLw3FJU8NqAy5xEASmSC6lRbzrl5BX5BOw7pSFnFrYAAG0yPOSgJ0p2WUyEI+OHUfrrvA2oI3QSeqnUhenNi2FLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by AM9PR04MB8570.eurprd04.prod.outlook.com (2603:10a6:20b:435::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 12:32:55 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%6]) with mapi id 15.20.7002.018; Thu, 16 Nov 2023
 12:32:54 +0000
Message-ID: <a0cd7abe-581e-460a-a36b-7665749417a2@suse.com>
Date: Thu, 16 Nov 2023 13:32:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: question on random MAC in usbnet
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Oliver Neukum <oneukum@suse.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 USB list <linux-usb@vger.kernel.org>
References: <53b66aee-c4ad-4aec-b59f-94649323bcd6@suse.com>
 <87zfzeexy8.fsf@miraculix.mork.no>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <87zfzeexy8.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|AM9PR04MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e363b8-022b-4de1-5934-08dbe6a027f8
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	japRa3i6VimhIWdRwepqAiVfSVvw2Nuu0dcL3e5xX9Jlnl6iRBr3OeT9m+KHsNZgalo1SC8spQ5HYp6ayrqO88oQ9pwAxLBh1MvIUdcYvKJ0PbV8prsh71K4HMxXI5GAckSnis+o3JgjOCmujayyhuePlwNuajn06HI5LFpJ5d00qPk0hqZvIqT/fMu2jSbj6hEm2+S31G1I2ChWdBJXIapUmOJrOi9R4W8FhY3reO2OiL09R92DCtTPf1VrpmR3a7GxTlKwP6LuQObF2B3vwQFVV8p8Zv6o7oTFzwC5+jYlzsXqv6Zw5p6i6/O31l4YosWWVsfrl7+tfRYaTCKC+NzPY58SzsCplchiPcdgt0PN7cskQRg642aTAqXN2/2ilLJSzks+SADRzMEqV7JNkBlX0lEKfgW4AV9COmiQZeTUFaSjo9ulE+76xjudUPiNA/BCGylHHn4KDhNYwFkFgfy9PmAwVyvYuyUe/pu8aFCTci6tXC1J3HYL/ZLmG467j6+Z2G/AsgLf+ZYR8NMtjdWUQs/4L4IEIn6QcM2sKA/MrcJ9Q/N2d+/gK6uUxmSKBl4jl0B2REzqVEifDEZdkhjOlMUy2YLktxTdK0Hznlhks3jLD5rXmOCrE016mAxizXzkr/w/HVdpucd2m05loQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6486002)(478600001)(2906002)(6506007)(53546011)(31696002)(2616005)(6512007)(5660300002)(86362001)(316002)(54906003)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(38100700002)(110136005)(41300700001)(4744005)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnlCRDU2eWZ2dWpkK0cwcFhRTWhoNWtmTEgrbSttcjNNTmhRRHkyYWVtV2hQ?=
 =?utf-8?B?ZEw0Nm1rbkpqLzdNSDR5Zm01V3BLQnNrRWFOMTRnK25NNjFUVjFCT2RpeVFS?=
 =?utf-8?B?OTZrdzVJbHpjdEVsbjV2Z0dTWmZsVUJ6Znk1VGlyY2g2WXAyQW1scUJMTnJ6?=
 =?utf-8?B?bjFiOG51aUVEb1dTYUg5cEFjVDRsTlZhM3NvUGRuelJ1U1ViQ2FxME1kNzJ0?=
 =?utf-8?B?MlN4bkhaUm0zSFFBYXBodUFqajJ1WHVLc1JBSXBsbmpkMlJnckNBT2NEUnp3?=
 =?utf-8?B?dndGWUlEdlM0VVZvUmFGL3dralJIR2VTVUlqM1BQR3Jtc1JyZStYejIzREVP?=
 =?utf-8?B?OEFsSnRJUDlKQzNZS3VQV3hiR1BhdzBEbzJSVFc3ZUFBcDJRL0JzcHJ3VCsv?=
 =?utf-8?B?TnZxQmd5dWtUQUJ3MHY4aFZIWHdMY1JwOElzUzh2aVdpUzNTSXFWOXBZdVND?=
 =?utf-8?B?bXE0cDBkd3VOc3pGNUJXZW1vamZFeVdDeExSWDIvS3Q5RlIxUXJId2dWMEpD?=
 =?utf-8?B?UzRRcTBoeVJ1Nmo5dGJWK2hrMVFqK1RVM0p2TnNWWVU0cFk2L1UvamlMMmVq?=
 =?utf-8?B?YjdmbGlBS1YxN2hoZkZsSmx6aktOU2poMW4wMEFQdkdTZGNWMzZ0bDhmaUQ4?=
 =?utf-8?B?VGVKZHpGbjl4MkNQQmNYU3RMQkJSRDU0eGxJMVlOcjFzLzJ1M25Gcy92cnhm?=
 =?utf-8?B?TU1PV05CQ0xlN3QyMjdkYjd1SGp3eVlkajNpSXM1L0IwWEpsOUM3R0tRRW9s?=
 =?utf-8?B?OW1DTW03WFFuK1N0UTBQWmpXY3lPSWxjaXJ5V2NGOHUrcFJ0QmdiZFd1SnZm?=
 =?utf-8?B?S1FqYStPVlA2cUxTOWN2bnY2VWExb21ncVZVNEJVdEVHeE1EVjY2d1Mrb0d2?=
 =?utf-8?B?MGl1RTBRSU9OSWRLazNPTGg3VlhHeUdxSHRsRWh0MndlS2NOYzRKOFpxcFJW?=
 =?utf-8?B?ODN0dVdIMDFNakZBdDY0eUl6NWlZZ0hKODJ1SUxOZWtMUHBJK3VQZ3Q1NHRj?=
 =?utf-8?B?Yjl1amM2RjhlWnFodUpoUENDcTR6dlZRTHdNK013ajh0TEFwUlVnd3JiR096?=
 =?utf-8?B?RFNUdGlUeHNtRjJRSWFKUHEyQTNTOGxxM0ZaTjlYa2t4clBEbkFLcGEzQUVZ?=
 =?utf-8?B?eHlON21tOGJ6U3F0NExjc204SXNEbk45ZTdwK3Q2bGY2Y09Ed080eHJBcEs1?=
 =?utf-8?B?a1pZL2V2QlZwZmZNMyt0bGdHY3J0OXdWK2FLemdsSTFEaFUxK2d0RUx0Yk5x?=
 =?utf-8?B?c0lUZ2pQWXBiT3l5K3hSTDBhd0w1ZnlIL1NZdXlqQkk4SmJ3Zkp5c0pQbllT?=
 =?utf-8?B?ZE1YQk0rclU2Nlc2N3lmY2I3aU5vaFdjUGtSUHlMVkJZdVJ2c0hWbk1VaGZz?=
 =?utf-8?B?a1NPNTNSWU10bzFPdFdiN3A5N3pFeTRZSGhQSDBzMWZ2cFhqbGJ4V3lnZWJP?=
 =?utf-8?B?NjdDMDZheXk1SmVIbHowZ3NUQUpldXhvTVNYVHpjc2lLSWJVbkJwYUUzNmY4?=
 =?utf-8?B?UE5YeUQ3dEUyTzU5RTNwMCtRK2YydmNwREJNRGE5Z2U0dk0yL2VRYkZLQkF4?=
 =?utf-8?B?eG5FbHBFU1ZhdnhlZWFvK2lpYXFQOW1QNzYxU1VUelg2SWlkZ3BkcHdXSXBU?=
 =?utf-8?B?ZFdMNFVJMkNDdmtvOSsrOGNxNC9id1QrYTVnczg4Mm5taXBMMjljMUJ2R0g3?=
 =?utf-8?B?RHljTkVhNUpLSDJ4eEl6cldIRmNVWlB4bTRTT2k2WGVRc2ppVjlkWUpwZVl1?=
 =?utf-8?B?RDFVY2VPWlVoNTV1K2FrUDNJamNSdlRHUzlpRHNlZHJaVHdOTitmamxqSmw3?=
 =?utf-8?B?YzNDcEtyQndIdFFER05RbEZNN0dPRUdoazZucHV4NFVBWFVUTHV5cDZmY0Jv?=
 =?utf-8?B?dUpHdjJoQlVjZG1xMEQrM3NGUG1iZzNOKzlQOVZMcUd4YWVSUm95S2NKR1pB?=
 =?utf-8?B?dHc3S0REekhxcVl2VmVLTlNaOVFVUnp5VFdDUjQ4am9GeUdFSDhEMGdIRTZa?=
 =?utf-8?B?dFZWZWUvUFhRVlRhTHhIR1V4WmR6bmtjYlduOVk0U1JVa2puZUw5NnJZUjRj?=
 =?utf-8?B?L0h3bGVVUk9rZkwwZWJIN1daeXlvQ0JVMzZMRUo0dHpsUmdTbGFhVFQrNWdt?=
 =?utf-8?B?VkVPY201NkJKT1dMTFlOcHhzK3FmRkhBSXBQYmN2MkVuSVNXTUJPdGxXWmdh?=
 =?utf-8?Q?Ts9sjlTdckyJcjxX8gi61c0Z8NY91QiWrhYiMOf/MskJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e363b8-022b-4de1-5934-08dbe6a027f8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 12:32:54.8128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZaddlWyW0K5qD4P0qMwvYnV7/5rREy8kHlLWYI1rrfjiU/yUbwJuoZVoozIsGAA4gPUg/b0eHS2EppF5gF0kIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8570

On 16.11.23 12:31, Bjørn Mork wrote:
> Oliver Neukum <oneukum@suse.com> writes:

> A host using more than one usbnet device was also unlikely 20 years
> ago.  So host unique was good enough in any case.
> 
> These factors have change a lot since then, obviously.

Yes.
   
> I could be wrong, but I don't expect anything to break if we did that.
> The current static address comes from eth_random_addr() in any case, so
> the end result as seen from the mini drivers should be identical.  The
> difference will be seen in userspace and surrounding equipment, And
> those should be for the better.

In theory somebody might have a setup with multiple devices on the same
bus and using them getting the same MAC for seamless fallover.

	Regards
		Oliver


