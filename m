Return-Path: <netdev+bounces-29425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6557831B9
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B34A280F51
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F348211725;
	Mon, 21 Aug 2023 20:14:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC81D1171A
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:14:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEE9125
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVXmMlIrFrMNLltlHtr72vB47DHZIsJ3eSpK78fkzKPTBRsU8dB9wzoycw/LIIXkJSeAHVUwDMqReDFM/igKY7ARmMTgzeC7VbPmlFQd4BEvSG8MYNnj14ju/NEISZhw2l3uwasM6aQONc5OWF77S6oh272JQA8/C4uOT/w8kFHvCOCL2fAtiA1L9g5KBFsoaMk5R6Pmg8bbGO3u8FaJ+8UAycc9gKsrBiIX3ApfRIIWMRvGOZ7Sbgrt5MiUOHPUt/sY9O1wr7blmzNGEZGZWRQPH+nhkEHULEtgGX83wFDvZB6DmmaiFLauWbpXP40wMbInP6CtOfuAQvcrERSURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+HJLcZpGGctxezmD5XHRmy99phvvD8PzrZWJSXSFPQ=;
 b=JLOrjA/TKTm54+IMKqXRWqX57cxzMHeZBCwz1n63+p6uqGY99Knf/XszivT/7lhHHyypXAIQXDC/CT8p4waGi70eWONfeJI+hlqXQ1OApeN1BuSeiaxUOgI93F5NXJLz1+HZ0TCIyuyp3QxBZVsW/ZL5kBdaQ6Ph5LxjfiaGW4ajuEph+PxfRnPzev97nMX9TbFPIo2VW5xa3Q8Cla+MBwpECCtsOVBso0vCRwHnJPRjIPkBTN4vrkW2vWQ2JWfEW2d3xakPvLGJGgUzpziPRoXMXJfLO/e1W7OWQ/nFWgvozmilOG/shIkAidaJvaoQ2L8QuLDMDPuOv1fm+BebtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+HJLcZpGGctxezmD5XHRmy99phvvD8PzrZWJSXSFPQ=;
 b=YeBgVMVZ7nn850NPAXlydsy8JuN1bPSEO9e2hCF1LkBjJGYFYCmPZZLUJuEHF8U/Wwir+fnBoRlI3mf/1VxoXq+0d8DnuFwDdKVqbpH+qd9tOjKSdcpWfaLS76rfZdDsF7CD7YMX42e8piYsWyEQlvzUdRcrL9rS98Gwoy4WZfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Mon, 21 Aug 2023 20:14:03 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:14:03 +0000
Message-ID: <0a2f116a-0569-4562-a34a-53438a5665fc@amd.com>
Date: Mon, 21 Aug 2023 13:14:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ionic: Remove unused declarations
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yue Haibing <yuehaibing@huawei.com>, brett.creeley@amd.com,
 drivers@pensando.io, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20230821134717.51936-1-yuehaibing@huawei.com>
 <46c62232-9a00-4a9f-b1ea-288c53ae47c3@amd.com>
 <20230821123927.4806075c@kernel.org>
 <b113a610-15b0-460a-a439-3e8461ae3f60@amd.com>
 <20230821130512.27d0265e@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20230821130512.27d0265e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:510:174::16) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 842ae886-f444-4615-2663-08dba28329f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ugIy3TqJz9pYZnhySrfdI5zxDlKnOF474hU6S1NrAlPCfJif5ThAIe3qVlCx5nFLqrydUPaZVnUpV0B5k7iuWbRZ46uIOPg5s8ykpMzqhgppLgQOf45q1SV2nS8ujQ0ziHBBiY8k4nZKjd0eoaHbUeXpjt6uI1dV6GzVwTEtGrXhkfktqRiZDT/pl8ECIu4zaxd+5wTf8+9HUcLyD+soE3LJieb4hhIV11sMQmDYjSRTfwnANfLDpWRYBUOG/RJstsVDl0WLuc4YhbRhdVgWNxSag/LwPJU2JPWpReEJeEMwb9F+yqnc99GbLOtvlr0Wfw/Zn6vBeRvVtti6+Cqsu/uV0ahrzVvMS1UFgneZZkBm6LB1nVPqhbJqLSmV+5fZJNSzYQ3S3tACdb1OzphQrG2z9yD/sTvbFKee8s5VGqDWIg2HFKNFSTUGV2yiINrZqxZDiF0OfyykTA5DELaIYEnm1qFtuiniINWXDVPOV8P8XU+DlMb2Pbp1mT7lJyp1Ou8ylCuUSN7gahlqh8D3UlNaT9xSBLLn1J+z6w0ZBN58BzDeisUEwSZtgl+jV2xCAfahc2PQeN2A3Muzvo3LJrrv+KB/OYD86l1hkDeZa4BLfj+swTVwZy5rfB/v2GM7xiQ3Yznm+dhLwjDhvs8DyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(38100700002)(53546011)(6506007)(6486002)(45080400002)(83380400001)(4744005)(2906002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WE9jbDJyZ1pReGliRzlTeTdUNG9yNytobldTVkkyaDNJbW9HMTNXTXFwc3Yz?=
 =?utf-8?B?T3cwS2hNMS84Sm5UbVBvRHhFdG1CSEZmVXF5dVQxd2VTaHZ0azl5ZzVuUldw?=
 =?utf-8?B?NEpZS1RaL041U3VUZi9ORzUrT0RVN2ozTllXbXp3VzRQSlF2WVRkdjhodXhh?=
 =?utf-8?B?cnIzSkFBejNDUEtzeEZwdmpmcEtvVVkxd0JuN2lCd0Z3VUhyRjZwSjcxeVlY?=
 =?utf-8?B?dGtrZ1hqN1AwY2VHMEllVGN2d0M5aUxkMU94SXZINFJ3QkhBd2tzcXdJZEgw?=
 =?utf-8?B?OTY0WW5wYzNraWdKSWQ1RHdaL3l3a0xQVVQ3cWhwTisxNmgwOFNoODA2MDNj?=
 =?utf-8?B?cDFxNW5DbjRhbHNJNDR2Y2xXRnpIWEp5a1lUZEpIWEszY09ZODRTTEI3aWNj?=
 =?utf-8?B?U3ZzQ004TTRvTHdUUEc1MWRuc01veGJheWpGMUVMSUZ1amNKamVCWGRmOEVK?=
 =?utf-8?B?T0dRV3BXaGlmVmVXd2pNUFczNmdWYmpFWXVXUWFtclF3YkFBNmxsUDhNWkV5?=
 =?utf-8?B?d043RnVnakhKYk5HcHBzbDBUcW5yRkJOMHR1dHNpVGlQSk9uQ3RIZzUzVzg4?=
 =?utf-8?B?NkgwcFlHdyt3SUJvNTBRbFdPZGZuL3VMeFR0YnJadmFKYmZUdHN3YkhPS3dj?=
 =?utf-8?B?MkdNUUI1dXV4STJmN3BMeVlMUWxVMzhSSnlNMjVjVnN2c0NvdmhvWVhoUUE1?=
 =?utf-8?B?cVpQb2dTQnY4UWhpdzJxbEVGbThwQWZ2NXg1cVF4YUhYMFJwc3cxN21TNFdQ?=
 =?utf-8?B?UEh5RnpBUCtiVGlmRkc0WkxsV25YOU1LWkhYeG55YWVQWFd6SDFQallYZTBT?=
 =?utf-8?B?RndVYno1aUJRRkFFV1I0Tmd0ZTYrMWE0MGZuTlkweHdGOGNZQk5QL21naFA1?=
 =?utf-8?B?UU5rYjRCTTMva0dSZnZnbHR2WG53dEVwS3Rlam11cVU5cUpxZmljVGxMWFJI?=
 =?utf-8?B?UGdRelNYeDBCejBZMDhweU8rOXFxcFBQZkFRWjdwVE8vendFVU0zVVdUbjhX?=
 =?utf-8?B?NkFqdEJqNUxuYlJVMFpLNUxOYXhpSnVGdEdjc0t6dWw2Q0FyUW5DUlRaOVdQ?=
 =?utf-8?B?NmZkVjhrZUJlTEE5clpEUFltQXBUVjVGcEJ2cGlxemxQY1drRWpkOHJqQnhD?=
 =?utf-8?B?YzZSVHk2c1dXaGtQblVKeEVjc0ExT1pENmFkOHpzL0NLTGFsRzVxNS84WnBm?=
 =?utf-8?B?SHI5Rjh0MXZ0UnlGdjczeHQ1VWM1UnFNTEZpSjZJMG50Lzk3TlVZazJLZ2RV?=
 =?utf-8?B?ekhiUWdSUk10NGdPQ2ZiZTg2NExoQ3ZESUJBS0F3TXlGREo4cHBvSGU1WXJi?=
 =?utf-8?B?b3MrUkR6U0JXN2tGRHYxUnF6cEczUk5wYTd3Mko4UFF1QUxaVGNUUWVEdE9v?=
 =?utf-8?B?OEJWeDJBejN2Rmp2UHk5S0dTWUhwejJrbGU5clFkbEs3SFV0UVQ5Nk1RWE8y?=
 =?utf-8?B?YTlPNFdYUFB5RUd5WDE4TFk2QURNaWswcjNtckhsS0xRZG5TWDJQYWtHUXhI?=
 =?utf-8?B?bXdaMVFDMldXYmlZTkxzTVAwZVpMZTAvaUNhMGh1b3ZiZk5iekpTZDJBbFdv?=
 =?utf-8?B?aDBFWkxNNEQ2Q1VlcmR2UFIxL20wWXlraU5paFAwZE44ZHkzcWM2Tm0yU2c5?=
 =?utf-8?B?aStmYUVlTWcySWdRa0NFbDh6aHpWbWJWK1JKNXM4dExwd2xEWC92VitDb3Zs?=
 =?utf-8?B?dTFER25GZ2swdUhOWjJPSGtmMFFGRnRwamZIUTE3YTFzKzRHWk1kK1lzZlNZ?=
 =?utf-8?B?U1F4ZzhzWEFmNWtaNmtFY2EvaWtZdW9vN1VPU0RITUdRcFFoRm1WUCswbGJM?=
 =?utf-8?B?LzBqNnZiNU5qMXAwV0huVG5HRUNvTVFIbDRZYVRJRHBNZHRXSkFMNlVBSlgw?=
 =?utf-8?B?SFo4Z1NhWEVBV2JiUmZremxiMTZUVGJmQXk5ZjRacFIrQ1lNUnJBNHZMOGor?=
 =?utf-8?B?ZWpQK240UkF0dktHZlA0MURJNnlWZDJOSStzMk96USszNnF3bnFYL3hvTTM5?=
 =?utf-8?B?aWFMQnJTcnhDMEJoMW1kRy9xS1V1UHIyL2tMbDU1bDFYR0VpTTY5QXpGZGRp?=
 =?utf-8?B?UVFFNkNqTi82VFBUaUFKNDRrK0dLdXVCeGRYTEdZVU1jTG10dXVSOW82aGVs?=
 =?utf-8?Q?ur26FH1Kzj6Jv4dVDFTqp2Zkt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842ae886-f444-4615-2663-08dba28329f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:14:03.2801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FhHZnUEPo3rOOW2/UL+ZOwcBWoDGZifBzX3rkcfYCQNu29RmFYXbbAg/6mOqeakwhUdWragwGpGFSnnDnNiCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/21/2023 1:05 PM, Jakub Kicinski wrote:
> 
> On Mon, 21 Aug 2023 12:42:52 -0700 Nelson, Shannon wrote:
>>> Nope, it's harmless, no Fixes needed.
>>> Fixes is for backporting, why would we backport this.
>>
>> Okay.
>>
>> Unfortunately I experimented with sending the "changes requested"
>> message to the pw bot just before receiving your note...
> 
> As luck would have it - seems like something in the copious Outlook
> headers confuses python's email library:

Well, "lucky" me?

Fine...

Acked-by: Shannon Nelson <shannon.nelson@amd.com>



