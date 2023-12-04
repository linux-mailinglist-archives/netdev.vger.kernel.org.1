Return-Path: <netdev+bounces-53576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AA1803CE0
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB251C20B37
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB82FC20;
	Mon,  4 Dec 2023 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QeA2PzsT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D013CD5
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 10:23:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYR65Z3LXdthUfhHeZZE6NS75k2drHl/0hkJZ3VDqz2y4awbAiyMYv9jRM7tt9vfarV9DBeWSEoDgRJZdzDcH+v8olwqjJ/gwNX6m3/nV2lcwzYmyX4MySP3NKhHFURDqrFasKWjUp6tdbMYeAq7d2XGF5uhdUrsfjBT/+/J76d5Uq/b1fj7xg1+CyNTTSr17OuFmPTanLrwVgd9lBU1Q3anB9cOnID51j9LPcoX5RUEmndl0wYygUd5pbY0h5VurilywQQL9M5QoYNpDkWjiVQW510sSHUq6RpfW/dBPKh2tKLGKvOv9Ezg/AIBnLEk3xZf6wK+UIhtGH4/zwyihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqIGHHTB/kLujh+PoKCuvmLKioJTcSk3VRnlm/aZWUg=;
 b=HdxOgXx6BDiLVyhV1db7wpZMZ2YvGTaw8Kx1TAaSRxcBYvUf5X58p2bNBnvInIeq2F1c+QBCKPTGIE9gorx9LBev3Hm7/h/5MXYui4lVX1UbHQXVKulJ9tFV3nZBiJshQbPm61lrGNEZ5iTX8JfJzGQcJigBCMSjK4UuyGt4qqqXgmXN6zjHlS3OC99Xqp6HAx1ufU0uv4IZzPd4n8+SgNrzzuuC+PyEty7zcvY44bMmlFrLNcxmR4DSIIQeNHLdYoN0ZiQX6aip3v0ETCs2WMqQuqcjBX1qvYErHv4/q0CBnd0deTRJsiuGusTYj7x9h1kNMIhjTastKh8AmarfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqIGHHTB/kLujh+PoKCuvmLKioJTcSk3VRnlm/aZWUg=;
 b=QeA2PzsTuan6zcjKYDeJlTfcT8ulFUohF3YpdVYIcD8lCbL9vocc/87+pYtBnU7BtxWzwiFlTASnz/jj6Fo+DwWLS7xkbctRylF7GOiE3F38CHQZW1Y7yRFEzkwsbZfLIaoxoI3oQkz4igW+f4KJFxqO9P1cqwSnX2DnIhywZYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 18:23:44 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 18:23:43 +0000
Message-ID: <6c5069f1-d689-438b-9c1c-ba3dd62fdb4d@amd.com>
Date: Mon, 4 Dec 2023 10:23:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/7] ionic: small driver fixes
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, brett.creeley@amd.com, drivers@pensando.io
References: <20231201000519.13363-1-shannon.nelson@amd.com>
 <20231201174223.34c6ac58@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20231201174223.34c6ac58@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BL1PR12MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: b269ae35-7bf7-4212-ec67-08dbf4f6256a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qtek8dal73/ChGAWkJ9KLYHiQAScMw0j4QRn+FHFvnzyxC6GcScHB584N+nvinvRZbHdKOCpZUFIKscE4Ta086UPUp0DCkQkA3PBfpX7oSSPNbwgIRvOeh+4ib0idjlNsto/dcK3sx6gVs1JNMOA9XuI/uVtHLoXGxOQvyN/X3TT4lyjdJ6r9sjYk106Fufn1795gkaJbh03tvTdYa7nkq4v0j/ulSdv7ZiZSY5ZrWuNONsf+7O3al5YtA8AWgPo0UdXQE6H9mfPgJ4OZK4Z/DIRi7dSVaFkBfu1+HPKUOff3QNoZ+n2pDjer+ib6Nl6skvl6pB15KO0J1wadBB5EU7WXf+UTXk6MJ0JqQbDdy9lqmVXr9Q/Xpmm9Abq+odtWpQwqv8gKKU7Oqzb4krl+qZcRq/z15soz7jtBcs1vT5S8q7Al8p1AXVXLXkBV7syrT7cjLfThgUaT952v/Mb/JO2SSfX7fIAAMMYtQFyEKrD1xPYgv0whF86hj33YJRA/j52vaEEmiUz3CQTNmtcweoiy3MtLv7EIzsHXCWNR7rMBbt4TAi1FGzgr1FN1hIko3wUlYzl0fxDRru7K4ddTQZHPKqsVZHaJ+je0naeJjkVZF0oJhofcXBl2/Ye1yVQNpMXEmg5rBzaUM1tFVNUug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66556008)(66476007)(66946007)(316002)(6916009)(478600001)(6486002)(38100700002)(5660300002)(41300700001)(36756003)(2906002)(31696002)(86362001)(8676002)(8936002)(4326008)(31686004)(2616005)(83380400001)(26005)(6512007)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE0zenJZVVlMWTBKUVQ4cklvY2NXTVBRTlZxOGxzNUpkQTRYVGlzZDRNT001?=
 =?utf-8?B?bjEvOHJIR2IyTjVmWHdjTFltSkJGby9XbUh2dTlwa2hhdjI4Mm5MUm5DRW8x?=
 =?utf-8?B?UFpxRXExSWN5MUliV3d4Z3BWa01rT2E0cEs0Tm9nQ0Nkd25EcDhNRFRLbkFB?=
 =?utf-8?B?b0JsVEkzQm9wT005aUR5V2Zkd0VGOEhYcTZQYlV6QStKWVhJK3h5VzNIWEJC?=
 =?utf-8?B?azdIc0RGem9DdXJaaXkzdk5iS0RteUowNFdkM0dRdUx5TmF1aTJ4c29aWnVp?=
 =?utf-8?B?YWVLOXVrTUhsUytTSCszTmRVcTlvL1Z5QnFydEZLb3E5aE9LMWc3UVRMVVEw?=
 =?utf-8?B?c09UZlRiOENSNy93anU1ZmVjYlpXMzl2aldXbUwzMmt5NWsvWUcrUW93QVdo?=
 =?utf-8?B?QmJKK1pIREI0Tm9hSUd4TDdKblArakZEU3gxR0txM1Y1SkNEYmVqSElOYjBP?=
 =?utf-8?B?TmVQYUtWa2lrVHlMNW53N3hSWXBwWWF1UWFXdzR0Z2ZjWWoyaDJuSGtSL0h6?=
 =?utf-8?B?S3NmYVRwbm1vVmFoSE5mZzJWVEFyRGRGZjBDVUZlS3ZWbWQvTWg5ZG1Lbm8r?=
 =?utf-8?B?QlNrVWdvb0g1NWJVMDZYODJyOUhWazZkRlQ0amx0aERrblpqWXExSktVS1Vx?=
 =?utf-8?B?eitwOTc1NTJZQVV6R1JkS1ZIWTNLWUxiNDdmMmpmVlZZV3NSdnBIOFJyS3VS?=
 =?utf-8?B?Q1BXaHBzbmlTVlZXTldkemtTYk16dFEzWVY3ZFp6UjlCaWJYZ2l0bUE0Q21I?=
 =?utf-8?B?MWhVdWlPMHExcmw2L2U3ZTJ1YjBxY3lRYXBSeTFadWh6dzVKdGVRaE8wV25k?=
 =?utf-8?B?YlRTSVhIby84YUo2WUVZS3JjTzNLSlVOdzBFaGZOWVdVYk9Wd2U0TGJMaytT?=
 =?utf-8?B?NEppQ0JaT0UrdTNhZnNZNEpRM1B4Wmg3Z3hobGsrVzFDS0tRTVUvd1VkK1E5?=
 =?utf-8?B?QjluUzZ2cEo0ZlAvbUhBdW5lN2hVUmpUcTdRVjhiaEZXOVNFSUUrZWRNNEow?=
 =?utf-8?B?Rno5T0VrY3FSaHNWbVVtdjBZY3NESnYyM2JZWUFORTZNWElGdzR4emV3SXpS?=
 =?utf-8?B?QzRKZ1c3ekdMekpTRmRmOVlwZ2VxTE5VNytaRjBsRmZTSVU3eng4TDJCYWxs?=
 =?utf-8?B?VldNdk96dkoxWENEdG8wdHIzcUlNQisxSHhlMUIweEhXWWdKVkFOYm04bzlF?=
 =?utf-8?B?M3FjakpnN282a3FjUWlnNERmay9DOUZBOVFLSWx3V3RHbSttMzIwaFhGS2Jz?=
 =?utf-8?B?amJxbUZ0OXF4ZFdDWUVha1lwMlc0L2VlYlpSSTUyOXhQYWt2OUhtTWJyR3RN?=
 =?utf-8?B?Y2RIZDdVY1lpeDBSMXcrN0xWREhnS01aczJoWlA0UzY4WU9BaWFKTTNydm10?=
 =?utf-8?B?S3JuZUZIVzdVanZDZ1BRbDFUTkVicnIvQTIwdXlnTEsvcWs1blZncy9XWE5i?=
 =?utf-8?B?QTNtUFhMM2M2UVd6RGJENmNtR25PdW01L0hwTnc5cUFieU9xL05mSHhwckhy?=
 =?utf-8?B?Z293OFdxZko5Ym92c2JBMk40TGhObHFpb1p1U2x5eDRqOXFNR2ZSUUlEQkRO?=
 =?utf-8?B?RTdsVTNpRWlHRENkSExId0hwQXkzQ0krTHRPL3dENDl4L1EvbzdxVzE0Znph?=
 =?utf-8?B?MTlvRTNXZ3IrMkJXRkRoYVlpQlN2UlRDNkZnSVhkK1Znbk1LM01ZY25sUkZ4?=
 =?utf-8?B?Vy9kcGRNTm9zbERpeXdnZWNqM0JGZ2RibWNtazRrenBEblNlYWd2dnpqVnJj?=
 =?utf-8?B?S09icDVaeXV4ZVphSGhiVGo2Q1hSeFR6T1NTRGJYbVJpdnJzK1NPVmc3aGEz?=
 =?utf-8?B?RUM5K3Fna1R0enVCK2JQREZkUnBhcjBHbU42SXZTNkdnM3hwNGZtWFlVMGJX?=
 =?utf-8?B?TEdwNXl6U0FMeWM1SlMwYUlWM1cweER1blRNN0xFOHFSdEl6dXRQcHVrOGlM?=
 =?utf-8?B?eGNhdkk2U1FXQnlNZlNycGFBVVBSUjFXY3pRaW5SNzJGQUxuWGN0Ulo3MVE0?=
 =?utf-8?B?MlkxQ2kxbUpjTVVQNkNBVy8xZkJWTm42eDZDYkk4d3o1Mk1LL0xoUUVyanhH?=
 =?utf-8?B?cm5XNWhFaVFLYTRlOXVCSEk3OVhTSHc1VE9FUXZQa25uK2hiSWFSM2p2bXg5?=
 =?utf-8?Q?oBIqCMkHMbdiqlbDtMCuVXE31?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b269ae35-7bf7-4212-ec67-08dbf4f6256a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 18:23:43.8368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8O8LGOKqDv7tweGATClvI1/5+mWGf66CVV1kUQ/9aD3fnD6h+274BVuFjdpNHZg5PiDDb+oHrH2YhyWe13xFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320

On 12/1/2023 5:42 PM, Jakub Kicinski wrote:
> 
> On Thu, 30 Nov 2023 16:05:12 -0800 Shannon Nelson wrote:
>> This is a collection of small fixes for the ionic driver,
>> mostly code cleanup items.
> 
> Hm, looks cleanup-y indeed. Majority of this looks like net-next
> material, really.
> 
> 1 - fine for net
> 2 - perf optimization, we generally follow stable rules, which say:
> 
>     Serious issues as reported by a user of a distribution kernel may
>     also be considered if they fix a notable performance or
>     interactivity issue. As these fixes are not as obvious and have a
>     higher risk of a subtle regression they should only be submitted by
>     a distribution kernel maintainer and include an addendum linking to
>     a bugzilla entry if it exists and additional information on the
>     user-visible impact.
> 
> I doubt serious "user-visible impact" will be the case here, however.
> 
> 3 - I don't see how this matters, netdev is not registered, locks are
>      not initialized, who's going to access that pointer?
> 4 - cleanup / nop
> 5 - cleanup / nop
> 6 - fine for net
> 7 - optimization and a minor one at that
> 
> I appreciate the diligent Fixes tags but I'm afraid we need to be a bit
> more judicious in what we consider a fix.

Okay, you would prefer most of these as net-next, and you like the Fixes 
tags, but normally if there are Fixes tags they should be in net.  So, 
do you want the Fixes tags removed when these patches are sent to net-next?

sln


> --
> pw-bot: cr

