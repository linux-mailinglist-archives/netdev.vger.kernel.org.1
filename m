Return-Path: <netdev+bounces-42816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD337D0386
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 23:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228C6B212A0
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 21:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F278354F2;
	Thu, 19 Oct 2023 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="glKCxlQS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFE2208B8
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 21:10:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A5FCA
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 14:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkJK45X1IausikkyhSapW6FT4SglB/0kkYsijpCBVc/DZsArgIRhbsKIOKowgCwMgc0zSI1n0rM3gv0Vi5IcOULPX+00XldKG1yIzsiGbqIh3u9PCJUXX38o0OpK/uKCewx2qa4fH2z3gvW3smZSOAUTZC+aGKNNXYV844fqXJJIAHgt+FmAqi8kY/G7tS0drPyTcVIGdu/p8TKBA22cRnnhej3iUaUVlMF2nrORedYF7QEtH0iuzx16g5sJV1pt750yJXEC7QdY/5rFyblFPDisH9bF5KnBu5O+TxAc6b1nzGhEGu/INBwzgfvVRmdLF/UWMXh9gFIjCM59gb1yMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdrBKm+TYxMITgdVQEqXFJciCILNgAURbS9BIrCgVTY=;
 b=TClVfzdVC8HMZ5ZQ8XWitrGINM1jezuNL4iZmBVeeXyks6FIxi3wyHoXnHZ+q733S9rP8R93YryBRZN9EyGnFL4vBIYFKc1AfEVbu0gaFGGJLDQDBjuojfcuJOjN9mazi/BK1RV1ZVunyik7+E2nDdRLNQjNoZMmrs7Slpm6XOgWWwNTJdoug6I6/asCVKHqxJ9bP0oeP3H168+Lkd3zKzmTtybhXwWuUYh4oCAPPy4MK4QSRtEvn2/1TQ1ztb57bumJYzHPC8j5lyp0T6/8nC5/7xGhU0JKjxAPLOTTqDHmQsfe/aHVjRNuEFA449C52ZKNyBElQ0/kOe/CLRYKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdrBKm+TYxMITgdVQEqXFJciCILNgAURbS9BIrCgVTY=;
 b=glKCxlQSho4QW+/9JO+t+rOLLC/bJcn//LCqy7eR6Ne0zXAikgKfPwEXX0BH13TBVhpfS0FdsFbyGnacQpfhXVoZvEmysdkiqTwbuOJzxlw+NF+EMAuBCjDtZmETqhAraYhD8Nno4nR91YR0EO6xn0rUrH4ZT+2yGRAWFruKI94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MW3PR12MB4586.namprd12.prod.outlook.com (2603:10b6:303:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 21:10:13 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::a13:336d:96a5:b7bf]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::a13:336d:96a5:b7bf%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 21:10:13 +0000
Message-ID: <cac1a6e5-80f1-48de-ad1b-3a75c4802957@amd.com>
Date: Thu, 19 Oct 2023 16:10:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] amd-xgbe: add support for AMD Crater
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Shyam-sundar.S-k@amd.com
References: <20231018144450.2061125-1-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <20231018144450.2061125-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:805:106::18) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MW3PR12MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2c760e-2c9d-49af-41a0-08dbd0e7c913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RvbxKCCR9nckOMS18PbDqkODdVPHxrHCmD7OHOhvt11Xtll2jr6KSHw5e0LeDNY9VHC3vTKZKUgBT3oKuLUVO3v9ekFMqQUE9fwISMOar1leTbXusJhw9BF8s/Bjvr0GlQs4vMV71iJXamm8M2dKwgMfcVYa1M7PTa6wqGaysT42HPHd4hma4OCNV3UoSGzGNAXN8OBICKO1dwIwZ6hA2KGNsbbYvwNgwiwAeBo+iIuNi45mGRfeJdsuqkj6pwkZN0InZuYvJ2PDsaefbxqVWkk0ya+0HDs0XY2lTz0X11x0RBBHx2o4nueewZLkeYaXeuACDmH+WtDDtSuhNtqA+pjxNX+IwqL5uXEaa2gjbEipp2i2gxKVdKJVJgmNV+8Ybcm9x+3c0M5Dy1pLHAGHeIJ62K4NGzlN8OFBBnDK6hTbpeaXt6v7sqEcIouD8nU3BkAAPU5Y+JCsd7XBHI8CxVl44LCUIUDF4wcwUqe2YB3y08Bbz4tbUmnlKmj+WmHG4bpcFDxMX069903fUcV11sV6eRvHiRAhkRtx/z/NxaOZhqb2r6amr44s8i4dUziHcqyTnJf3drTyAdNNu9fYrXdxxD0wUaD26gBsawou5PmVGAMRJfDNYOFNJ5qRZKUPhoHcfVU4SwCWLvCRlV2k7RwxADD/4ByaBgOE5OoCLUZxva4ENb678jsoHLaMJioU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(66476007)(66556008)(66946007)(8936002)(316002)(6486002)(478600001)(8676002)(5660300002)(36756003)(31696002)(4326008)(41300700001)(86362001)(38100700002)(53546011)(2616005)(6506007)(83380400001)(26005)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkgvelVhN1dGNE5zeG51OERuWWpaNXFNT2toUWJqcythNkRZWFZSOFR2RytE?=
 =?utf-8?B?b0hqcER0d0VaTVh0SnVhTk5LWWRwTGt5V09iWUx4a1JmdStPb2RNcFI2a2tE?=
 =?utf-8?B?elM4b0U2Z0dpa0ZtSUkvMWZnTFJWYnRnSkNCVkxvWmZERnZ1c0w4QWJRRU90?=
 =?utf-8?B?WVNKSS9GanRCYmJaK21wQTZ1UFozYStFQXViSStRWnFUZ04wSk1lZ1F1Qmd6?=
 =?utf-8?B?R01HOVpWcW0rc2haVVZnajNyaWc1WnozZUt4Z09jYUhJektZaXU5WGVHZTd1?=
 =?utf-8?B?cHphRGt3dlhDWWdvN3RNNWl5U3gvdnpnbnp0VHhxV2VaTmE1ZndXTUkwZnhl?=
 =?utf-8?B?N1NULzRYMXhPeDB1ZVE4cGszN2J5eGdFbzNLVzZYQzh4SzJCZjIxRU5ZK3VC?=
 =?utf-8?B?TDBhK1JNTU8xTXVDU2hzcExncmxrMVRoWURzS29KMUg2Z0JaTE0vbmRQaWVN?=
 =?utf-8?B?ZHlyc3UyNUNyOVJ3bENWTVRSbTQ1OXBmai9kVkhhZnl0VnlUSWh5ZWtWaURW?=
 =?utf-8?B?cmU3YXZIMkwrNldrRnUrdlFHeW1waW80dGYzQ3p0dmlCVG94RVE5bXRkZUVH?=
 =?utf-8?B?NXY0N2FoK0E3RmZFaXdTY0R1Mk15YkJEYzJqY2Nlb0VZOUlUL2NiQWhpRW1T?=
 =?utf-8?B?MkpDbE1KQWJRZDJsOGJwYThtUzU3ejFCQkQwNjZnWEs5ekhnbmtlZjBJaWJo?=
 =?utf-8?B?am9oQ2pyd0VBVlBzTk1tVE9QbHVCaHIzbFVDN3BkTHBhNWNodFhQVWN0MWtU?=
 =?utf-8?B?ck5FWmdKY2szTmprQUxqbzUzbGhMR3Fpd0xBMW9aNHF4MWxlbTdjbE8wRkwy?=
 =?utf-8?B?TzFpY281cWp6VEdxbnJCNFRMSC9zc1pPb2J4OVVvekJKRUVpY3UyN3JqN2dk?=
 =?utf-8?B?ZnViUUpMWjN0amg1ejZTNVI4blhpUUEyYU1EbTJQb3BOQ2E5dmxDZXI2dkcz?=
 =?utf-8?B?K2hNa04yTTgxTFNzS096V0lRZlNrUUJ0QmRka0ZTSmhoM2RhZFUweHcrcGZD?=
 =?utf-8?B?VWFtQlh3Y2FHVFFCN2Y3SlRmRW9wQ3Y3VHhOVW41T1l1ZGpock1DcVNOZXdw?=
 =?utf-8?B?V2JqVkE2RGxoMnU1K2ttdlM3T1NZMFQ3TjdZUHFXN3hEZ0p2Ym5HdDJxeGQ4?=
 =?utf-8?B?WGtyNVJDVi84OWFoTCtFblg2U25FbHNzN0paT0lEVkVPU1NXdDZHdmxmSXI5?=
 =?utf-8?B?V0FoejJQZER0UnZTb1l0MU51TE00aGxJbks2Qml3aGt5eFh2dG52bVhBVzNz?=
 =?utf-8?B?M0luZlkwU2Q2U3ozV1krOVdaUVdZdm1Eb202YWFEdkEwdGVUT2ppeE9VcmUr?=
 =?utf-8?B?Um9FcjF1THE4dHpkcWoyMjFpOFAyUFIzRW5kZUt4Q2VzZEQvZEd6ZkF4NTA1?=
 =?utf-8?B?Rk42QTU5d3k1M2R4ZDFlYTZaMGNLNFlPN1JoMVFoWHJUNUp1WVQvZ2lNODFa?=
 =?utf-8?B?cUJuaEhwcUZhRENGRGdUNENNaVY1eHkxc3JueWIxKzRaSU5XTEJ3UEVxWXY1?=
 =?utf-8?B?VzdNY3lNUHpXREZaa0FEdmpCZG5zd2ZnRlM4RTdNYkNCdFo5VHhGZ1JLYTJP?=
 =?utf-8?B?YXRvQ3Q0VHpUQW9DeTBCSFVNK252SWxvN1IzYkorckJmMnhVcFZ0K3EvcUdR?=
 =?utf-8?B?MGN5a2JpbkIySkp0TFFtMmZPMlpPM1g4eVpwV3pnaVRtalh5MHVsdXl6UTBD?=
 =?utf-8?B?cVd3ZXphZEs1Yk1DQTZ1Qkh4NmVmdmhDYnRkZVF4Nm45V0lSWTVJMVpnME9j?=
 =?utf-8?B?dmRoY2VxZ0I4bUE0aVRIZFB0TnhRaU9wTDJhZ0dWL3c2UVhWYVZTMkRtYm5D?=
 =?utf-8?B?bUNWTjBBMjFiOEozTmVKZFpMZ2c3SmkxTkgyT01zeUM3TkNyaDBqcTlRbjEz?=
 =?utf-8?B?TUl2bldEUWxXV3dxYi8rL05CaWJQZHJFYVdsdjdZRVhmUGJUOG5kYTFTQnUz?=
 =?utf-8?B?MlE3amNoUGxaUWNkMGR3NmpWaFFoY1FuazdxYTJkeGR5dnVuN2pRYjRJUUQ0?=
 =?utf-8?B?Q1ZhTUk5VG5lajZjOGtaVzBKNUlHRjhaSkxPN0oxVVJzNWcrNThPMkc3WDJT?=
 =?utf-8?B?SzN1U0YvdzQycnlnZGZIYkNFSU1xSVZIRG1MNzRGN2JGcGttOGdLRjFGOXNm?=
 =?utf-8?Q?WTdDiQH40Fd02zSK2/Yx8grHS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2c760e-2c9d-49af-41a0-08dbd0e7c913
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 21:10:13.3879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzTZwE2+OFRkrxiNcsnD1QzQgEwuxwlRNe7FYZSDX0/qAq3TPqajYQW/F359EU9u5t/s4gvX+pojSPvXRHKteA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4586

On 10/18/23 09:44, Raju Rangoju wrote:
> Add support for a new AMD Ethernet device called "Crater". It has a new
> PCI ID, add this to the current list of supported devices in the
> amd-xgbe devices.Also, the BAR1 addresses cannot be used to access the
> PCS registers on Crater platform, use the indirect addressing via SMN
> instead.

It looks like this should be a three patch series with new "Crater" device 
support, followed by a quirk/exception for the BAR1 address issue, and 
then finally your first patch being the last patch so that the device 
isn't enabled until the final patch.

Thanks,
Tom

> 
> Raju Rangoju (2):
>    amd-xgbe: add support for new pci device id 0x1641
>    amd-xgbe: Add support for AMD Crater ethernet device
> 
>   drivers/net/ethernet/amd/xgbe/xgbe-common.h |  5 +++
>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 33 +++++++++++++++++---
>   drivers/net/ethernet/amd/xgbe/xgbe-pci.c    | 34 ++++++++++++++++-----
>   drivers/net/ethernet/amd/xgbe/xgbe.h        |  6 ++++
>   4 files changed, 65 insertions(+), 13 deletions(-)
> 

