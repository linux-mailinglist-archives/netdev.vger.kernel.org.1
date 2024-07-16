Return-Path: <netdev+bounces-111698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE499321B3
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12511C21C08
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14B761FCE;
	Tue, 16 Jul 2024 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pTASlASo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551457888;
	Tue, 16 Jul 2024 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117611; cv=fail; b=EI0wg98zU8pxR3wYpMkYrIPgniYwfiMNScl2GtnHpAYIUV5BGl43QcLoH+hZtCxOY/3Lp3wwnOU1SHz03JgAHJ/jtRiFhPDIqCvJqlj2bXNvm6Yd0gwrJvhqrZi6mLoQVP8FMuNRjEcFgttbRP+dzrnTwDPbXvW27P2b5XQDXtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117611; c=relaxed/simple;
	bh=fpOTZPoD6Wn9M/G73DvF35FW8NQF9DpNdPKb/4erBg0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WqsEAvsb9Y6OeJlMJQ1rNjwtIIXxpHszxbCujSJyhwG4f9e/zqidfsU/2jLTnJALDFUh+fLXV/raoA0zTybMVk3os+gLN0344YC7CzyMaS6UBIC9yuDxDFl6Fe+UwTPupRVUr8cMlIAbHmrFXs7b8xDdH1zDdDmE2l/Rx+E9etM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pTASlASo; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuWojO3XLfQF35Hgi8oAqg6ev1oXeyS2Z5b7aXcMAphvnRsvEnwHbzDTy5QmDvhmEg25PdG2Z3a07i1yj2MJ4SxAHhqutsGYXNtPnlRGTcGzfZICLZOMfqJnJQBoSXriWlz+sXsQ495Bv4/LHc0CklR7fU0bh+3q/Fgnl12cfw7Z6Z2vY3f1JFU55gO7DfoYbwneoBU+6ce23eJBYTBodnd8dtVAIfgxak+apEQt5Kuwk5FD9WwavedsH2Dp33wvuZCVGjNQS/SWTXv3BKCoSnNpU+iyQxxSnBsYarSNM0AfEZ9dTgzJlIYA69S3YfmqVHbVUMB+a+mQLGojO/0DpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWuhMWNKZJopAo/kX1ef4hrkJD51Ehbe9yW/RNY7i34=;
 b=ZeTAyixEtRHLs72WyftnDZYrmhdK98W7CHgI7W7bGE+uDwBVi/BnPp585FbmCe9FVF6bYatqnPd7VRhObGlqp6+Uy/nmWQkr8OJ9w9ZaXjXunxaOSPDFnVl0dubYYZEmkfQAr7UYWnS3PTs5M2nuuVhLc8RawIMZmX6b99OhH6Cy001GSy1yZZnp7ZLHQuaz/ouA/HvVJ/MQy3wD+Y+jaEQzXgUzOfOyS5hAswHh40V4cwb0xBkWkyV64T/w51VCNja/wa9hEfLabckyiF11YjyahzY1ZJLFncXCd8OwxVyugBDcse3oUcU2rRqYpmxKpYlje2Vv5WLUo6/9rZ+ClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWuhMWNKZJopAo/kX1ef4hrkJD51Ehbe9yW/RNY7i34=;
 b=pTASlASo5J1g+cIV+BwJsZcTJ5dOczxVo9TMJSiOVkXkwhD0F7CepdXOwKujDdq7pnQ7sUNZmkpoXvpP9OaoZtRyBH1MRJK1hToRKg6KwLUe2jWmf8EV/Xykq/sdFIZSrcEQ9UzuHxxzMiFTuoCujT462+gTt83Z5lW+tU8Xlz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Tue, 16 Jul
 2024 08:13:27 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 08:13:27 +0000
Message-ID: <1cd50929-35f5-d0f1-9a68-d22e28cdf1b6@amd.com>
Date: Tue, 16 Jul 2024 09:13:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 11/15] cxl: make region type based on endpoint type
Content-Language: en-US
To: "Li, Ming4" <ming4.li@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-12-alejandro.lucero-palau@amd.com>
 <1f082012-1ad6-4b12-8eb4-96bcc61704a0@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <1f082012-1ad6-4b12-8eb4-96bcc61704a0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0352.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 795adb95-805a-4e06-ec1b-08dca56f2b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXl5RXhsMytCaGJuS1RGekVlaEZqZXhkSnova3FlbkNacTVFUGc5UUtvVzZH?=
 =?utf-8?B?SEV0Q2grRklQTXUrWXJLaXlPNGlMWWd3dG5IbzV2Zjk0WXBLbC9xb2EzWldy?=
 =?utf-8?B?NjhGR2xhOEZaOFd2bWxSbXR3RkRRYWQ3ekcxTkJUUHRqUUFreHZYMmI4dysw?=
 =?utf-8?B?N2dMdkFGZ3MyVFJTUEpnTTEwaU1EKzgyTmxPT3BhL056bitvMG5mRWVBTTVm?=
 =?utf-8?B?Qmp3NWdjZ0cvM0tYNG45b0Z6RmN6MVk1czFNQktKRndrMFUvWEVsN2lkZ1Zy?=
 =?utf-8?B?RTBqN0tuVStNYU1TZHV0QzRhT21POGlHN1JCVmc0ZjNENkoyZzlQZDlBVDVB?=
 =?utf-8?B?b0dZTmxKZnpPUWFLd2JjOXJ0bXFWYWpRKzRWcUY4endBSDJtUlpwL3R5V3dN?=
 =?utf-8?B?SktqbVZ5RitXa1dZeDdzOEd2WlBsaTByQ1QxTkt1WDFGNlZRRWUyakR6M2tH?=
 =?utf-8?B?YnhtSW5jYUttUmx5RkkyY3MrdlN2Z3ROZjRPZ0tIT3dnamllSkNKNWNFdnBB?=
 =?utf-8?B?cGVlS3o0UXllZGtKQ2lTcHY3dVRyakNldVNtY1ZnazROdVRjbTUrZWtpUWpl?=
 =?utf-8?B?T1hYL2xOblhIa3gya0FVVzJlcTdZNExPT2FQcTlVNVZlUnBkSkYxdENIZ0FE?=
 =?utf-8?B?ZzZnNk4vNHZWUnVwZ1BqeUdTVWpSWnlsU3RSYlhOUERtZlY2N252ajFCR2NJ?=
 =?utf-8?B?d3ljU2FUK1FScjdZa0lteDlGUDJoK3gzUlYzdjVkVCtJTzF3VHhGY3pmQmNL?=
 =?utf-8?B?RnRTY2NUanRkcmZzSkJubkk4OWNxMTQyS2ZsSHg5aVdZWkdCSVRjVWJzeWpD?=
 =?utf-8?B?azRSekNwSDhoOGloQXZEeTI0aVdsa0x4Y09GVFNZb29VVlpxQ09tUEdmalcv?=
 =?utf-8?B?NXdOaElacjNadEJUdld0MmVrdUFXdy84TUtMUFhVRmRDZVRsS3J0djd0dm5a?=
 =?utf-8?B?REpJUkUzR3NMNEVEaHpjanM1MFBYL0Y4ZUVjcXNiMi9JRTd0NHZzZVM0Y1J6?=
 =?utf-8?B?UVh2SlhyMFFJV0F4Z3RrSklCbW1haHFZTGdHSGhuRXpDMmlLQTJqSzlCZGlK?=
 =?utf-8?B?ZUV6RnhLc2RoVktPWmxXZ0hteFBkWk4xWTZXeS9yV3JKclJydTlqdW1uUEM2?=
 =?utf-8?B?TlVJSk9KMnI0aHE3Y0ZldXV1b0oyWDE5VVFiNVZXcHl3TlhWckQ2bko1U0dU?=
 =?utf-8?B?TnNXdEJmTTV4a3hzLzZ5MEt6M3RHQXIzaVNWc214RitCNVUxQVNMR3RpS29G?=
 =?utf-8?B?YmFRbitPLzh0VHk1bWIrSUg0b3RvOWMwMFJhN3o2U2pHT09Wd0pFU1J0OXZD?=
 =?utf-8?B?ZHE4bEhRdE01SmEwM3ZVRGhwRXZnUkd3eHlQWUFiaENLaEtKU2FWSlF0QXdH?=
 =?utf-8?B?M0xMaG1aOGlkdjZubXhqbHJtWUJ2dWV0WVZCSFZFN05xU3kyZS9la1p1UVFP?=
 =?utf-8?B?dWlmMTJlRVgvRXphU2VtcHN5bGZnS3ZnaXBsZlMybFBxQ1orUk1DQkdjQUVy?=
 =?utf-8?B?VnBEWmNnOUVaYkJvMWl2ck95TlptbGR0MkpmVWJrR3dhQUV2bGNHTjRabDZw?=
 =?utf-8?B?UGQ5K0JWRmhqays2MXRkcnJGaml4TkpSc1ArczVPTDlHMUZ3UVZpYXVmb1h0?=
 =?utf-8?B?d05CZVR2d1RKV3hMSW0xOTluaGgzSEpIUkJ1SlBhYjBKYjYwNTBSdGgvYVc2?=
 =?utf-8?B?UVhOdGE1STJnS1g5aFhIeFBnbkZqeGM4bjBidDRETFpuVjRpT2p2cmhIb3B3?=
 =?utf-8?B?SzBkVi9GcEwraS9Kem55Q1BTQmZSZDFmMjh2OEtoQXBzOTAyeDhoTllaUVdL?=
 =?utf-8?B?MUpRTkprTGdyeEFueUtHRUdySHh3MU53dkZORWFJT0JqT3hLWkZKMGhXbHVj?=
 =?utf-8?Q?mSE3CoLF8d48T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkxJSlF4NzBiT1RNYWVsaVBjdlZFeGxubW9SR0V4eHEyY0JhQzhkVWF6N2xl?=
 =?utf-8?B?MWRjd3lPV1FkYkNzajVCdVZRSDdlL0VGNzU4MVRpMjE1V0tXMkxwdm9mLzkz?=
 =?utf-8?B?WElUSG8yWURyNlVuVVVYR05WYlVLMDlJTVJmWWxTSS9FOTl0Z2tSeFBmcFNQ?=
 =?utf-8?B?WlVQOFhIOTBodjlmcTdjM244Y2RSeTVvRjlSU1BLa05zdU1OTndWRk5OK3Uy?=
 =?utf-8?B?aDBZMXB2NzN2N0kvYi9ycitCenRVZHVsRS9YaXdMa0hHYm9Oa1kybVB6djFo?=
 =?utf-8?B?a3JBMEJNUVI4MFlnMUlQL1ZnekQ0eU03aEJXSzlEQ2pWQ3VvZjlxcmdSTkwy?=
 =?utf-8?B?MGtId2hMWmlwZUtVVXFDWmY1YVBkYll3OHFjTFJOMndCZFl2YVJDdVR5OUZR?=
 =?utf-8?B?Y0VrL0JhV0dTTDRXZTFveGtrSFVLSEVMbTdnMTA4K25tR2IzVDZRc09MVmZH?=
 =?utf-8?B?N1FaLytFYXMvUDRhejBXUzN1Y1VHNW5uellpZ1hyc1pFWFBzZS9rVUxJTmpF?=
 =?utf-8?B?S1pEYjR3RysvbUlESW1nRjlkUFI3anhyd3Q3dStxcDdhRXFpSy91WVZHVXpB?=
 =?utf-8?B?cWpKSVEwTkdSYnpwdDZja3JzcE9DMmtRRVloZnQraHYyTm5KZnNnSnI5SS9m?=
 =?utf-8?B?TlRGOU9TNVFTR05lcWFhcUxoOVRKMFNCQ29wMEp5aE5wZkZxZzAySU9ibDRz?=
 =?utf-8?B?czZmU0twMTRaZ1MrMFRzREszNzQrWVg3cjNWekpxL2wzTktnaDMyMXM2YUUx?=
 =?utf-8?B?bnY0Ni9VaDF5TmxTWng2cEtrTlU2clNvRHE0YWR5TzF4UzZMMHdyVTM3eWZ1?=
 =?utf-8?B?dldnVDN3aDZERUlyZ2lPL0xIY3p4RGtwVTE0NC9jZTlBVWdLRzg0aVRnTXIv?=
 =?utf-8?B?MDRPVlVCSXdqaWp3R01WUmZYYXRSckhoNzZsQndXeHB3TVVQMnVqZ2dIY3J3?=
 =?utf-8?B?QkxuVUhvSXY1K016S1Nzb2xURWpkaWh2NFh1WkFwM1d4S1p3b3lmelowc0JR?=
 =?utf-8?B?Uk8zdDNRWUN3NEF5NWRaVHFONGF4SHBsNHU4RVRwZi90V0E1SzB2Z0R1QUdU?=
 =?utf-8?B?WkpnZkc4Wm5MbUI0SXRqWENUemROaWNIRDBhWi95b3Q0eS83UmlUSjVRN0lY?=
 =?utf-8?B?QStVYnhMTFV6ODVVRFV5RUdDUzdFdDFNYTRqOFBkVnJiSGxUM3N5U1I3ZkhR?=
 =?utf-8?B?UEZnQzNCZ0lNQXlSYzNSeGFVcndWNjF3bFZBL3doUmRsL1hzWFFadTVsRStk?=
 =?utf-8?B?ZktxTCs2Y2FoL3J5UjErUWNSLzJIL1BVaEJvQ29JckhwcGYwSWY2clJiRUZv?=
 =?utf-8?B?SXBKRFNKN3hEdDArZmtZNEFFaU1QSnh4ZGFncXNQUlZIVmhBVG1zQVJXOEVG?=
 =?utf-8?B?T0IrQ01naERnT1NwWDVWemQyKzdLbDBodFBvWi9yVm00RXZVajIvYndHUGtj?=
 =?utf-8?B?L2t0clQ5Y3JFVDR6bHIyYW13a2VoZXA2WHp2TndWOVllY0FlNllwSFBydWhQ?=
 =?utf-8?B?NUQyT3hpRDc2bWw4Mm8xS3BBS3g1NGtiSldZZEV6alUzN20yRXVEM2t1bnNL?=
 =?utf-8?B?VkltRUR0amFGSHRtTnlXUU10NkR5VEZ1clgzTnlEOHFNNkluZ2doNElWTk13?=
 =?utf-8?B?T08zb09GVE1QSUF3dk93dHllVUNlR0hRUmdJWmV1bVQvendhUnYxZ09SSE9Y?=
 =?utf-8?B?KzB6WC93RFNVN0NqVlBkZDlySWtabEU0bzZLT05YODhvZ09iNkJzcmEzN0I3?=
 =?utf-8?B?RytZa2xGTEZNSmUxakVweXRxQzFEcEdpbk1wZXJxY25TU3dPbVIvU09zcW1I?=
 =?utf-8?B?R2pVV0ZJbm04aElwRS96UU0xZ1B4S0xQR3M2bGV6R29udDNsN1VieklyWjk0?=
 =?utf-8?B?T2hUQUZ4NVhPeVdxZDJ4NHJGbG5DYmhDNjJSVURSREhkZ0Z6Q3NSVFNzUXJu?=
 =?utf-8?B?QU1xRGYrbmp2U2ZaVVFmMHJJMzRLRnlTekZxNEpRbTlvbXZlUGNzTFpQV1RF?=
 =?utf-8?B?MGFpSUI4RllOVjRRWnJKUkRCK01VbmprVVYwZ3N0TENtcnlDWHU3U28xRUZ5?=
 =?utf-8?B?WHgycEVHaDk2K2haRFQvclBnWEJWZzdFckVqUWJjMmRnWEROaXNqZVBJTFBq?=
 =?utf-8?Q?pCe2bpf0rF3eUbMx1c9OI1/XX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795adb95-805a-4e06-ec1b-08dca56f2b16
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:13:27.0186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUtUZPbyFs/hwSvZY7ksKRTSIxgy5OALUw93+1PQCgrUJfFW9N7jhkHC2W6uYuBy6e6S+b001VbFTjfWT8xe7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964


On 7/16/24 08:14, Li, Ming4 wrote:
> On 7/16/2024 1:28 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
>> Suport for Type2 implies region type needs to be based on the endpoint
>> type instead.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index ca464bfef77b..5cc71b8868bc 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2645,7 +2645,8 @@ static ssize_t create_ram_region_show(struct device *dev,
>>   }
>>   
>>   static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>> -					  enum cxl_decoder_mode mode, int id)
>> +					  enum cxl_decoder_mode mode, int id,
>> +					  enum cxl_decoder_type target_type)
>>   {
>>   	int rc;
>>   
>> @@ -2667,7 +2668,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>>   		return ERR_PTR(-EBUSY);
>>   	}
>>   
>> -	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
>> +	return devm_cxl_add_region(cxlrd, id, mode, target_type);
>>   }
>>   
>>   static ssize_t create_pmem_region_store(struct device *dev,
>> @@ -2682,7 +2683,8 @@ static ssize_t create_pmem_region_store(struct device *dev,
>>   	if (rc != 1)
>>   		return -EINVAL;
>>   
>> -	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
>> +	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id,
>> +			       CXL_DECODER_HOSTONLYMEM);
>>   	if (IS_ERR(cxlr))
>>   		return PTR_ERR(cxlr);
>>   
>> @@ -2702,7 +2704,8 @@ static ssize_t create_ram_region_store(struct device *dev,
>>   	if (rc != 1)
>>   		return -EINVAL;
>>   
>> -	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
>> +	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id,
>> +			       CXL_DECODER_HOSTONLYMEM);
>>   	if (IS_ERR(cxlr))
>>   		return PTR_ERR(cxlr);
>>   
>> @@ -3364,7 +3367,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   
>>   	do {
>>   		cxlr = __create_region(cxlrd, cxled->mode,
>> -				       atomic_read(&cxlrd->region_id));
>> +				       atomic_read(&cxlrd->region_id),
>> +				       cxled->cxld.target_type);
>>   	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>   
>>   	if (IS_ERR(cxlr)) {
> I think that one more check between the type of root decoder and endpoint decoder is necessary in this case. Currently, root decoder type is hard coded to CXL_DECODER_HOSTONLYMEM, but it should be CXL_DECODER_DEVMEM or CXL_DECODER_HOSTONLYMEM based on cfmws->restrictions.
>

I think you are completely right.

I will work on this looking also for other implications.

Thanks


>

