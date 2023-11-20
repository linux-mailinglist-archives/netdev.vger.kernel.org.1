Return-Path: <netdev+bounces-49176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F967F10B0
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D412813FB
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CEB1FD7;
	Mon, 20 Nov 2023 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FWnO91LT"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CD31709
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 02:44:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxcTGo0XUL0M7veiKPSeoOTUyTHSQO4us7C7Ry45g6buTNP/PRI6jaCMigGvv/MrjkrrAaXQKiez2kIqR7A4ICHIbKmH7gL8O3k4IYloMC7ZgRodWGol3ihUfpyY/BmtI4i/o/yCZwSy9+zyHCqFBKsTxovS4TJG75nAru5DGEo8kbGx6Gutsc0xWn4TPmUryGDvyJbl9pPawCccXLwcgloU/WPHixYrMb8hVYkBSh6B0vDEJLzBNQb8XeQaak4rMrezKBre83j/PpGGZqWBt8V5c8AO/GrIMbJUKocXFdJonKvijFweYMKlUKaela5cS2Q/hsZ4ceYU1GTk95ufiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EeA0idsCTN9qu5NqItDXjd4J0uxmo5zM3mWHMPuxqc=;
 b=R+GOBY16W6ohSB01BDqKRD8k48UCUxL7oD/sR+pOIxoeVDF0KTB2voby2lX3Dnw5KAeNWQlZlppiUQKTrCbcrzltvUMdNCP0Oh8ssJLBasU2RUJ9wsLw1FYczFB/WqW1pxBowvHrE1Y/GeUyE8c1Vin/qu0OE1pCvtTCw9yKzazlAzVa3GyXAmUPEV4lKvPdMLZVFUPIA/Ed5T/zyHXt0pOAejbPFSOVwTWII3EnnXQjhtJGEu5cFEOMD2ius+Pa4idD7rxaMKDamVAsfBDPpI+iXX6HIyWjL1gLiBDQZF7p4b0HcaMjWAU0SGeiKIXIDUDhHSQWtlsx6Cb869Blcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EeA0idsCTN9qu5NqItDXjd4J0uxmo5zM3mWHMPuxqc=;
 b=FWnO91LToF3a9RvxH4j74pRcTavcAifTE3FSEdsVqq0yv4CUnDQKBEJKfBEeJTabNA82DBdYQD8JiQoJuUYvNw3a7Bkx8ElRDovFDGGQmQwMIj00YAT6q9lt1lJZKRNx6rTe+PzmtT0CEmV4QyJXLUgCts/whM+T3aOEsuYqJp1uQDLFRh1+rQH/Qtdf2LZ8AahfenQV7LcswZaPPWVGWdXBopw/1OMfzWKBbjL2GMbm0/9wmZYPfexc3p1y9FiulUBNnxu1WnnRMy/m5e2AIsvTR1FhAwR/0hzCmeEDHIkk84h/I2nLlxxi66BYVTChYFRo2ghsS56Zu0MP6F736A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by AM9PR04MB8209.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 10:44:52 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%7]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 10:44:51 +0000
Message-ID: <6fd275d5-6f98-4c93-a37d-e7169f8789dd@suse.com>
Date: Mon, 20 Nov 2023 11:44:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] usbnet: assign unique random MAC
To: Benjamin Poirier <benjamin.poirier@gmail.com>,
 Oliver Neukum <oneukum@suse.com>
Cc: bjorn@mork.no, netdev@vger.kernel.org
References: <20231116140616.4848-1-oneukum@suse.com> <ZVaAN28EeKJeMKPJ@d3>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ZVaAN28EeKJeMKPJ@d3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::14) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|AM9PR04MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a71429f-c671-4bd4-9e1a-08dbe9b5b970
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Iwzl9SnAwxY8qo7iIq4gn8GAD3oFQGD2Va0h+inFJxpHm5JFJWH3gnznB1ai9llL2jcurSzAPi4Whj9Ut8uHl5bkketjuw7fbMqFwWnELCS7CLVYvkZVV//CgRhhtUH0HL9uiOZ0eRqDUZNrJo+DWkN9CnSG9bEXDxnEVCxec11olhDcLNcFE7XARY9neJh8XI6FsB22w6LTEpPAIuwIAxOosz3gz0D3Nz62v3B5tjGqkcSIlLytyWYYk1rgAW0hh9AG4JrOsNnRPUjbYEb8QP9D1mM4GX9e2k7HRBsF15JyRu3yuz3ehVxhEn3Qj9Od3b2yjjGJHWNpWpwbFmYgxrl9PyQDCPUqi/F5TAOLix4HYyDzfO5CTKlVr3AIOMXJa5NEd3qRvrlaPadN74h0LRaZuNCwj2IiaqtaAyuV2joF+77S4aw7fPiEvIjtJRZHzFaVXCdTbGPYS9ii6I5neuDfAQmHwpNd8gqL8L0tGn5OVy8wkDKPoJI+ujEBwX2FDDoVKZYcxX3YIF9URPLNBpnr3sEiK2VxZqeHvVg2s0JKKxrcZ1/iFUHatsBswohohml0l0J6Hi2j1v2No1oGI6zOVjwLFWCdABU+baHVWmeYybfpFWhQ6yLRjt7F/bD1Ut3277+YiKtlgY4SaRVuCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(36756003)(31696002)(5660300002)(86362001)(2906002)(4744005)(83380400001)(110136005)(6506007)(53546011)(6666004)(478600001)(6486002)(6512007)(2616005)(4326008)(38100700002)(8676002)(8936002)(66556008)(66476007)(66946007)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mmx3M2RBeUs5ak9zUFBXS0c0cUZUbHN4UmZPak9oN3Y3QlE3SVZtQmFLamxa?=
 =?utf-8?B?dFlFN1R0SngvOWx6VC9STVV6dVZ0ZkJOTkFXbDMxZmlwUlB5UG16ZHRkNFVQ?=
 =?utf-8?B?M2VyVHhVSEh1T050R3FaUUtDMlo5VDhXZEhvZUE2cjNkRS9hcFlsUDBhU2tV?=
 =?utf-8?B?Vm8zeU9DUGNFR2wwWmVKT1U3NTVKSkRGT0ZWT3NPU3RKTmNlUUVyZE1NQWp3?=
 =?utf-8?B?Y0swYU5WRjI5aEU5VjFGZVpxdkQyUFY1NTJYem91dlFMQkZoZHNkR2M2cUJr?=
 =?utf-8?B?UFcyc1lvdWwyNVoyVHhGSnVMV20xbm9NQ0E5K2NmTlhHMW9BYy9kMmg5QUJa?=
 =?utf-8?B?M1Y5V2ZLYlNZQk9tQ3drck1TdW1FZTJuYkJrMCtPOGxwS3huSlFvQitSRFNy?=
 =?utf-8?B?MncwbWVlT21tdTUrd0s5QUZtR2dzM0ZZLzBpeWp6amp4RGkrZWJlcGhzaWNS?=
 =?utf-8?B?elBnYk96WldON1M0VHlQNjZGOHBiMXF2WndQOGdGQ0QwclRyYnVWVkl3cnNC?=
 =?utf-8?B?bFNFd25qVmhDcEZJWi9CQXlnbkFxL2ZIcmFjRlA0MXZRd2R1L2lTb2wza09J?=
 =?utf-8?B?V1pnOWpKUzdiT0ZjWDQwLzljc3VGTmN5cXJhaTdxOGtsRU1HSHVEMkNUcFJt?=
 =?utf-8?B?R1dRN1A3Z25RRXV3aWxHSmZNd2E0SFd3K0xSb0VabGxOOGhWYmNUTHhJMXUr?=
 =?utf-8?B?M1lPc2RXb215d0IweFp3dTQxOFBsUWVRcW1yaStuTjVEOFgvS1dJT29JK29n?=
 =?utf-8?B?dU9rZEhoa2hMOVZJRWN0SURBaERoK1NiNVlCZk5IbEViSnRtL2xwUzFRSFhG?=
 =?utf-8?B?N1IxKzBSWHhGZzBNVEhMZ3ZDYy9FeUsxOU1LRDE0alFTZ3lGVWFJd1VFV21Q?=
 =?utf-8?B?OUdvRTRTUjR0VXlIeHA3VmwydjBXdWtMdG5pekVINmYvUG9tZVVjVnRKaDJE?=
 =?utf-8?B?eUprTlBLaVFwaGNSZk9vMHZrdFU0YnF3UTdFZFp6K3ljbWZxcy9aNWxJaFZZ?=
 =?utf-8?B?Y2lMZE1xNmkyUjlYZE42SU5nN0ZQdHVSak1IZDFCb0JCb0RPNzNYQko5Mlor?=
 =?utf-8?B?RDdiMTN1azk4QzNQU0Q4aU03NGZEcmsvVDRuVjhHN3ZvYjJuK3VRNTYvWHR4?=
 =?utf-8?B?NVJEeGtUZkl2TlRDVU5JUkd4czVDK3M5Z1dRSEtJZldkUEY0RERGREp5cGVr?=
 =?utf-8?B?YXhMWVhCWkNYejFJSUc1SkY2OWFraVF5WW5WR3VSUmRwd3JGbU01SUpNb1VP?=
 =?utf-8?B?aFRVdDNCMmcvd0N2MFhFVjNhQi9MdG1ucjBTT2syQUdLb2wvMm45OXUyc3pn?=
 =?utf-8?B?cEZQc0xVRkt6TzZsMXUyeUNFeUk0enhGc1R4MlNkeENDMm1odDQ0SC9Hb2c5?=
 =?utf-8?B?eHh3MysxZmYyNmdlT3lTTHRwRWZZT25ua0JBZkp2T09lWjZsSnpFUjBpN2tk?=
 =?utf-8?B?eGNKWGVFVGoyakpVZzE2ZjRqbHBaeFNBY2hXc1lPdFpWeUJQZHNSelQvbUNr?=
 =?utf-8?B?d2xWQTh5SmU5K2VGdExhaXdBVE1NWC9xS25OeTNOMzhFMG9ITHdrV3lqZFkx?=
 =?utf-8?B?VEdDLytJRC9qd3NESUErU0JqOUpHWGZqbHgxdW9KU202dTVPUjJTd0hmUmlE?=
 =?utf-8?B?T3paMkloSTlFMTQ0eWRxMlZCaVBzWEZLWDVjTkxMc2IzUStzQVNYT2xVeU45?=
 =?utf-8?B?MHN2cllxaklsY3RwLy85d1FHMExCdUYrb3M0eDZVVGRHUGZKSEQ5bDREV2kx?=
 =?utf-8?B?K2dPVkVsUExKMThoekhLMjFjNTZXdWQxSFBveXVnRGZETm5CQ2pYZHFyeGcx?=
 =?utf-8?B?UlZXS0taNWFHaFBabElBdnNnMHhKZ0FZclB4cGJMZ2hYYk9acFRPNmIwRnc4?=
 =?utf-8?B?eWNsaHA3SG1FNkJWdWtOdmRxaC9MbG5sL21PdlVsODFtUTNMSkthdE5sOTdE?=
 =?utf-8?B?aUpNSEwrQlhseFhQaHBoQXlydHVDblFWRUd0SWtib3BiMlljeUFWTVVQTC9M?=
 =?utf-8?B?WWdqUlhURzV5QVNERHpPSHU3TkNtOC95YVIwTkpYUTNtQkxoN2drck9SYUNW?=
 =?utf-8?B?WUl4QU5ROUVKMTlVSktrV1MweFNxNXlKcFR0ZzFXVWZqRktnc3NGcVlTZ0ZX?=
 =?utf-8?B?ZlFQWlJjTXYwT2ZnaXdPanFENlVqZ3NnVm9nMEJNZkFGd2w5VnFyeDA0VGRB?=
 =?utf-8?Q?XgKte6roKnDSPQVR2aTloYciZlug0xCscSJNLpmaOtAc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a71429f-c671-4bd4-9e1a-08dbe9b5b970
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 10:44:51.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KrCi7zEYyyXkmyVVm5YsZv4TcpIOta/ZvLy9lMii51Z4SZJboI89q2iEUHj1qMIEKpCV3DBZrTx+IlF4VcEnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8209

On 16.11.23 21:48, Benjamin Poirier wrote:

> Before initialization, dev_addr is null (00:00:00:00:00:00). Since this
> patch moves the fallback address initialization after the
> 	if (info->bind) {
> block, if the bind() did not initialize the address, this patch changes
> the result of the
> 		     (net->dev_addr [0] & 0x02) == 0))
> test within the block, no? The test now takes place on an uninitialized
> address and the result goes from false to true.

Hi,

right this issue exists. V2 will come up.

	Regards
		Oliver

