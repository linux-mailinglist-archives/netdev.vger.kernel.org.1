Return-Path: <netdev+bounces-29418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473A0783104
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806FC1C2033E
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3CF1170E;
	Mon, 21 Aug 2023 19:43:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51CF11707
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 19:43:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C504C2
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 12:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSXGSw2ZLXkwjwuplwUBXd/j3cnGVYBBqeb0FwGTLIToWxUl08Ez18aU5ZC7gf31mCwuEWcRDdaEb/O4Hab62OiFFJNfy+ChZmTund15ji5i4Vn84/ojc+8NAyWTbbp0mwN8QVIsghWWiU8p2m5AFcvcb6aOqtsfB5zUoyx1pKUuONmnHwcbslrtoE7TZlmix4I4HVqnySYtQGjJmkb5P2/dKDZ19ThZWDJWnVpr7vdHNNcvrFM+9NursVeCtIad7XWlx5bQB78xHmS2ZSBqzMLBWrQSV5r0N92sXaYGcUczQJVX+QVRZOyCrSl9Mxte0KKHvjIek85a5gthaVAS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJyKrTSVNGi4PMPQOa7rSIsTygnYxHIAaWVphmZVVEI=;
 b=VvgZNNoXU+AwxF2iG791HSgFkSBiELXbfLF2zeGqxxNQ8/VWF1vTw1X2I2iiFXxpM81mLHFturnqOMb5Po0qUOWPdaCGU5w0FXygJ57wUnUamgnyKv1lZLd+QFZgBf9/VHJiqHNZnya4/iauYSZmJWF3m/ElQLgnAhq8zuZXEQt3Sesh+I9iveFbw9f038aCJY2qPjQ/XSWTUzkxnyx6aAHUoc/559IvMSrTz/XIrOib3SpopBtBB1hVCzFY97000jFPz6HArY3+4rLzy81OXeYnIF+L0tmIeXb8vLzORK+3QZW+yUbwllTI6bxUzV2w8EZP7DCs8OrT3NsOtglvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJyKrTSVNGi4PMPQOa7rSIsTygnYxHIAaWVphmZVVEI=;
 b=A7yaoq+xiG72wPGKzLNR8bg/xqqfint10C/tCfH1G43LW+D6oonAFjvDgv3UYEH3cJp8XZ3bPkkztge6E36eTJLYmz6C1kEWQzqpVg02tGG+2PPiMAHVNEZLblHepkxRPbZ/rnZXNUI5reTIv80SwUAYU0scxoefXmI1ENXNJqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Mon, 21 Aug 2023 19:42:56 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 19:42:56 +0000
Message-ID: <b113a610-15b0-460a-a439-3e8461ae3f60@amd.com>
Date: Mon, 21 Aug 2023 12:42:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ionic: Remove unused declarations
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yue Haibing <yuehaibing@huawei.com>, brett.creeley@amd.com,
 drivers@pensando.io, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20230821134717.51936-1-yuehaibing@huawei.com>
 <46c62232-9a00-4a9f-b1ea-288c53ae47c3@amd.com>
 <20230821123927.4806075c@kernel.org>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20230821123927.4806075c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::33) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e35f215-225d-4319-b3d6-08dba27ed118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FQPL1Pcg5Skx3LwPSoaapTKXSuemcpvIvJtWAu6LLgCADdhhxlr9X2fNwnVTFWIwlMdi6UTLD3BPYJzCnvkw4nmuzPD6tWPQJuVPyumtoQRoR22g8fvjRIemmw5KZtnXDMc3qW1lvw6nFfhCtTZg8I9H/Ql6hiOsFe/9CVUQxU+alUaovQ+fvezhLdE+mRyRU0Lt9XndqjU8TjP23G752j9sCBuvl0RnNcCW+JKr/hcXabYozq3rR5+yk9/zmpg8ZFDZYW5sS7d86syu2q/qxFbZpJH3yr7CVURw2yOscbJgAvkZln9zQaPe4+NFiXaYj7aXG7cCHGrRZZfsxDco1bAmMb62JEbt9BJDRna/c6WPbfOOlnR1Bx6WkdAyK1AanA9jWNkgO1Wqog8ytIv3oxzE1ckl7dtTd7ajIoeFitUTfp1CyWJav9dcsCc+8c9/zPm2NFT6Kn2+UTiLiIHpmzIer2gwJ37277DVDNPym7UPx4kmdN0XjhO4CZp9Ik1Lay220n5MjhJzZr1FZC3SX5WCPZY0ajcztNM6y+Ajd+IFDOt4N7w0iBgrvgKezH3PbeLRHME0fu8oxQqwkTNRycs1mu6Smd02O/z4H1g6rkYo+6XhVbMaJ0WaSWabhLoe6Vndc4hiw9UBKkUIXNKOiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(186009)(1800799009)(451199024)(66556008)(6916009)(66476007)(66946007)(6512007)(316002)(2616005)(8676002)(8936002)(4326008)(41300700001)(36756003)(478600001)(6666004)(38100700002)(53546011)(6486002)(6506007)(83380400001)(4744005)(2906002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU5EaHVLQTIxbG81dzd2TXN6eEx0Q0UrSXZSYnV5MnErcVduTitaWVhERW0z?=
 =?utf-8?B?OEZiU21nSjNEaGF4UmxwMXh5ZDlMQTJGSXgvNEk3SzlPUDRPQmYxeDg2azhw?=
 =?utf-8?B?VHluTTh1TEg4Q3hUODVwaUVIMG1CQW8vNmZiaXNGTU5zU2FLcTA4Z0pMRU9O?=
 =?utf-8?B?aXV2UWtkd2habFNCTit6V1BCdnhFNnBzckJndHJGd01mMmdKVnB2aytBdGRP?=
 =?utf-8?B?RlFNN3dJWkZOZk8rejBMYWtJejVtNGZHTmxOS0YvdXJDd2ZPMEt3SUZJZTJo?=
 =?utf-8?B?eU9IZVYvTDlMcjJQa3dlTE5YYkY4M1pta05jZ2NRaTVFcU1oTVpJVkNQbSs1?=
 =?utf-8?B?c1FsdS8rd2VVQTA4NGFFUEhYMzh1K0xUQWptMmdsZ3JBVFdwYmwxUnlDM0pz?=
 =?utf-8?B?clU3bCtxN1VxYitXWWZJaHR1Uk9XMWc0TXZncGZhV2djYko1aTkybm0wRW1B?=
 =?utf-8?B?Z1ZuSGRyVUxkZ2lDVDJRSDBwdGxPVjUva1RHWXgxV1hIN05FRlBHNS9kRGdn?=
 =?utf-8?B?WG13bkR5YjlwM1JpdnVWOVB5dmVwWmROYmtGeC9RYnhucklRYXg5VXRrWFBE?=
 =?utf-8?B?bVN6KzdMOGRUYkthQlhnSi9mOXBoMm5TaXQwZTk4aFVzTjJRanVUdVlWUTRq?=
 =?utf-8?B?U3ZKM2drWG5qQjNaZjhHYmZ2QThOdEFDdytoSUVzS2RtSER6dEpyaUIrRmJw?=
 =?utf-8?B?YUJKcGc5Z2YwMy9uTzdZRnZiZkhWNGZXdk1PZXNvamoyalpaTzZ1ZG9EL1A1?=
 =?utf-8?B?cy93dElyY3cxeGprZnMycGhDY2lYbVVvZ3c4MERWSHZvcFdGUTN3L0ttM1dV?=
 =?utf-8?B?Nm5YTXY4SFBsSTYzNTdhZ2lINHBHMmFsV21hczNzcGo0cGN2QU16bDFEL2cr?=
 =?utf-8?B?V2xWMTZvRW9iU1JmTUJKNWcvdjNNVUVkOFZiTmxZZVNUZUFmcHM3TjVhOXht?=
 =?utf-8?B?b0hjWVhldnNPRUMzaUtiM1FKK0VHVll1RS8xdXlzYzhOa285dFVna3NNTWpJ?=
 =?utf-8?B?cU94RlhxcTRQNi9kWlBGRHNZakZLUyt3OUlGTlBmenNtd1RwOVZvbWNyeVpt?=
 =?utf-8?B?b0J6TWdtUFh4anFDUGJJWFgveDFWd0FFVDc0VWRJVjVULzR6UjJqejBpa1dn?=
 =?utf-8?B?WTcwOWswaXhMOEdoYUdQV2VnbWtRWWFHS3V5VVNZK1hqZjhpMjRiNXkrN1h1?=
 =?utf-8?B?Y1IwdkU5MTU4NEpnQzh5cmJFMTJCSiszRFZ6ejNHYS9sMndobkhBOXhIVWRT?=
 =?utf-8?B?dXR4MlNGdTY3S0ZON3pITHhNT0YxQ2xBd0FrbTQ4NllOOXU3Yi9weGxSTXM3?=
 =?utf-8?B?VVUxQ2toZzBMTCtBSDRFajB2dG1keE02OW0rNG84RnNuRjRPM1hHM1JXcDJJ?=
 =?utf-8?B?WGRaRVNGNnRtd3B4QW94T3JmMEIwakdZKzlsSGptbWQ4WGdzeGtoYmpoam9k?=
 =?utf-8?B?VytIVjZwTTJWb0hKODRkRjAzU1QvRnZvWEN2U1NodjI4VC8rK0lXb2c0aEpm?=
 =?utf-8?B?ZlZNaVJQSkZ5WWxQb2NyUTBKd3BDZFNTRktGWi9RMnlSRDlKQUFBdEplLzZO?=
 =?utf-8?B?Q3FLSS9aOEFCM2RRc0tMMnRnNDA5UVlLaitjM1ZDY2thZ3c2N0Y0Q2ZIaVVk?=
 =?utf-8?B?SWN4OUEybHQ1RzdzNmU5azRrTkovdkpPS3ZyZlBPaUNkZmtRcThlT2phd1o5?=
 =?utf-8?B?bmlwMjBFQW1zTFhGRXpnYkdVUFYxV2ZibHlUZk55bU5BR1cwQlpYekVaM2hY?=
 =?utf-8?B?T05iOG9VWGQ2KzZrZUtyRGl2OUhEblRoZTErS2NjQzdMVHlYVHNXZUx6V0xL?=
 =?utf-8?B?TFgxTFI0VFB1YkZzZ3EyRGcvUlpFZVE4T211M0lPMTdMMmwwU3VONlhlN2Vh?=
 =?utf-8?B?amN2UVBQbW15eEh4YmlkZm4rcU91RGRkamU4SFpGR0k1RUtUSERXWkI4ZFJM?=
 =?utf-8?B?U1FaOTVGOW5RWjZ2Y2VpOUdPQTczZlErQnI5U2tLSHNqVjZvOUZtV0J3NGw1?=
 =?utf-8?B?UGdkTGs0RXhMVlVlbnJsUlkwZ2tONkRzUDFLRlRNb2xRZVJ6cmZXUzVyeDdW?=
 =?utf-8?B?enpXRVVOU3gwT1JDcktoaGdkeHpuR1RKMjVlREwxN2MzVkEzeDAxUWZ6ZWJQ?=
 =?utf-8?Q?zD5N6nfR7a4HsKnMvgPsy274q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e35f215-225d-4319-b3d6-08dba27ed118
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:42:56.1864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUEnbg0B5V8nXFE3C7uvIkCmkWWASx6Lfu441CTHLNcCATbBjGlhoX55kdW5ego+GQQptvnkojBrE9bAxce7Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/21/2023 12:39 PM, Jakub Kicinski wrote:
> 
> On Mon, 21 Aug 2023 10:26:40 -0700 Nelson, Shannon wrote:
>>> Commit fbfb8031533c ("ionic: Add hardware init and device commands")
>>> declared but never implemented ionic_q_rewind()/ionic_set_dma_mask().
>>> Commit 969f84394604 ("ionic: sync the filters in the work task")
>>> declared but never implemented ionic_rx_filters_need_sync().
>>>
>>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>>
>> This should include a "Fixes" tag
> 
> Nope, it's harmless, no Fixes needed.
> Fixes is for backporting, why would we backport this.

Okay.

Unfortunately I experimented with sending the "changes requested" 
message to the pw bot just before receiving your note...

sln

