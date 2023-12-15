Return-Path: <netdev+bounces-57981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8A6814A9A
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CABA285BCB
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD12F111C;
	Fri, 15 Dec 2023 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MU/bIdo2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B2453AF
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpzNEUOMSwh4DQHQA8TlTOuwy8/+TX9Djy9SfaCOjvimF/xR6tJdQzMcsXdN80roXQRTrrxo4YXB+cg5pKMPFkGbHURDaiXeApKXUt0nnfn1qyTIx+kuAYk0v/sPWNDeHgpjYTuqZEkbqR72rifpii86GhAd6Y+3MI4+pqrpPljap5CbqT+5pwlpoNek3S5C1Jq30q1Tq3u75iA0Q0oJzMgDU+aOB0qqAE3GX0nRepej9A2g13u0PiAV0RB9z6/N/FeHnlJIsIe649jb1FDJ79u2mgTjCaJQKdjc8/tHn0k4cKTAwAxlGubLQrEZmeoziZ7M754oS/w3Nr3B6gx3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWJM7Tze3SrPFYYAypBouQSk5/rcsJ5YgzoP7mHjs+A=;
 b=PN8bGniQk6G1t6Q12yQc8tLsLqUoRUvPj86GFEVmmtp0k6Lw/ieTOQCYnWgPpVkeu6X7TC/iiGxzxnUB1dBcxGs8M2+X33r9oT67DXIRTJ9/DFJqqnAhsXUiusZmEM32gyzBA7hpGER1skd+HGkXIygu6hXPkFQQTQtj5td4OzTBkbsg4IJy1nCMSk1nFvru0rTEXGfCPqS6/NMPGK1gaznoeSsbv99Ria2l1CCWO8RXMfjOoNeAOyilThWbKs2CzElFu1dQV5tK6H13sQi0/i+pe1Xni/k8/R542KFSurm0SFlt2a1Hx1JVL0BG6iiYYnVs00oocOYfO4C4HJp/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWJM7Tze3SrPFYYAypBouQSk5/rcsJ5YgzoP7mHjs+A=;
 b=MU/bIdo29/B6lmKe4pXmO7VI+URBa5661SfdFpt8fNXVJCXcirm5EgXaA99Pdim/cbJ7fSqZJDm/R966dgPcPbvuP8IiHYDSaRwB9fspQoaAIipPMprSD3IT/BwlFl35N4OBXD2M61LjLq1k7woV2/T3PQZWfVmnqkTgTc4PXns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 14:35:51 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 14:35:50 +0000
Message-ID: <72d8ab78-4e61-ba13-2abe-dfe988dd511f@amd.com>
Date: Fri, 15 Dec 2023 08:35:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 net-next 3/3] amd-xgbe: use smn functions to avoid race
Content-Language: en-US
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Shyam-sundar.S-k@amd.com
References: <20231212053723.443772-1-Raju.Rangoju@amd.com>
 <20231212053723.443772-4-Raju.Rangoju@amd.com>
 <68c52e74-dd8d-4211-bdb9-9541b41c6900@amd.com>
 <82f60707-a24d-b745-ab25-7909b24c629e@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <82f60707-a24d-b745-ab25-7909b24c629e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0069.namprd05.prod.outlook.com
 (2603:10b6:803:41::46) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CO6PR12MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: b09cdb91-83be-4256-937d-08dbfd7b229f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DWUdzBZm56g4qNV0DZtD8seQEFv1BPUbyXqwgL0l8ZAnmmP6Gkb5B8KO5A3CdRn+GVirAZQtK+7zZ+QTJcVYpfeLDXIr59anvgZnVD4Ozc+oEphXYZbg/f+2tx+nhbnh/8y8xPuzch3cPdIIeeGd6G6GTa85sRhHTmuwvETBOpJ26Yo/3K6t7iGnLiq47/DohB1T/1FPPWLjFgw/NEfIxCe5NVfoPkZjjHi7Elu8EbrpRZUBAQrcQHbQY2+m82rM2Oumb6YLOYA5+5WAG3UA0h/xPuGWFAnYnxagw8DzFdZ0dBSiMln2A2UqdIFNLPTUvR35AT7FaWzLBj3B/wi09/WP8xFY3lbw5l1aUB0XGqBKmaq2Fsrq7AYMBtX1aWMNHdcO9qYP6J3922lyPcYls4thSiKla/l0z+FRKBKAk5GgfAKwgh25dFaOuaMGGDW7aOb6IFb0zSbm15RSCvBNAbTH0+we0SdpYETdWNcLYdl6gnKhNAlqcSWy0MQPyijBOM1gt43DB/4gX94ry8IJBWC2L4Am/IG3MxXrVNMVVmT/jeYiFxVOGWge1wwR9NA9Pajo2PbQTQ0Iyq0ww7bG4GcNkwRRphSwr5CR/ekLowieUgLf6B9nFIXAeuWPTx1Ni8Ps+yc7aa//7jBcl5vYgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(86362001)(36756003)(38100700002)(316002)(66476007)(2616005)(66946007)(66556008)(26005)(83380400001)(5660300002)(4326008)(8676002)(53546011)(8936002)(6666004)(6512007)(6506007)(478600001)(6486002)(41300700001)(4744005)(31696002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXZhYjZzV1lHQUdOYkVlQjIxTlBNMnhSdGQrZFdVMjBVT25hcW9aTmF6b1JT?=
 =?utf-8?B?SHJVbXdHWFVscC9WNUxSbmdYVWx3amU1Q2tkM2tYalJ1YmZuZ3ZoVHhpTytP?=
 =?utf-8?B?VWg5aUJncjNtV3FMZTArUFFYbnM0ZW93RHczNHFSQkVGeWtWMDBqTzJxdGM3?=
 =?utf-8?B?YWlKbytzQW5EU0dsVnhOMVk1ZllKc1M0OWlITlZQaWFpYWpKQ1dmaEErRmRE?=
 =?utf-8?B?UXFEY0hVS2Zqem9iaHRFSEZ2RHpKNGtJSnduYU0waHhUS1ZwMVJSK21jekY2?=
 =?utf-8?B?YjFWTWdMSEJwYXYwTmRsc3FhcEtvdGVObHpEM3pzaUltVmV5alJOaWx6Zml3?=
 =?utf-8?B?bUtLRWJSL21mR1l3VnVXL2RBdXkweDJ5NTd1aHFzK241eHpCRnAwMU9EM0dQ?=
 =?utf-8?B?a0JWVnFvR3RBYjhwNWJzZjcwL3RLR3JCZTRCYkwzS3lSUzl2YTVrbWdNRVp0?=
 =?utf-8?B?bnNEdFdUOVRJeHRyS0ZLRUFWc1ViM2J2KysrYUxHZzhTcHVkVVdjR29YVXcw?=
 =?utf-8?B?bzgvSUlEKzdXMldjdUZHNlJmbFpWd3dzaUZ3NmZQWEdMa0FJQ1FCK2pUYjZB?=
 =?utf-8?B?aGFUd3UxU0dZbEFyZ1Y5VU5hNGxwQnNaN1MzMG5GaGFMcFc4WDhsekc3QzVl?=
 =?utf-8?B?WDlCS3dMRFd0TFhhN1dzTE9KVFlWUjJhOWVaYjR4TXZjVWREQ3F0Y0p0Skh4?=
 =?utf-8?B?NSthdnpTMmpIVnJ5bUlGazdUbTNUcjJyOXRYRHJvOTllRHdYVTV5QzZHVnhD?=
 =?utf-8?B?QVZUK1ZrVmtmTlhQWTBrWXRvNjRISWdkeHdJSDg3a2xnRWsrMWF5ZktXK1ZR?=
 =?utf-8?B?UXFmQytRLzNHakttOHNPMzErdGZ6d2E4NmtWUC9rU1lyUkRBRHZHK2F4a1BW?=
 =?utf-8?B?MGUzWmdiZmYzSU1Cb2hLdk93YktkMzYyeHJPOElUbGpsQ1BpUFhxRy9vTGdT?=
 =?utf-8?B?UDNiMTMrVG9IV1dEQmNwVUE4RCtqaDd2NGhxSmVFY2NIZ3dGQ0FVL3BVYUx3?=
 =?utf-8?B?SFhCVy9teVhFWm03bXdOdktCdDJnQ2YrTnpMRG9HeFhDMG44MDNDbkdiZkIy?=
 =?utf-8?B?YnhWbURES3dHdEVmd2ZJQk9kaVhmZWJ6OUw1clNBTTBDNVRnT0pubDB6Wi9i?=
 =?utf-8?B?Q2FKQllZS050YmVZekJka05zUGJCTEhvaG82TmRRbncvNTloZkVGcUoxeGtE?=
 =?utf-8?B?V0xzc2w4QXVxMitoN2hXMDBOeEQ0TkdkMmh5cUE5NW1EMVlFYWFNQTZ4QzAr?=
 =?utf-8?B?bTFyKzRLMmJTQTFJcXpWdk1PbDFIMUcyWXpZZVdtd3BIOHE2TURnbjB3dkpN?=
 =?utf-8?B?WEp6bkFtOFI3WndpaUpWSlYwNnBtbm5wKzlicGNOM3NhNkREKytYOTIwTUhn?=
 =?utf-8?B?R25TbU5UV2ZudnRKeFViTW8vOGNqaE5jVEVLckh3Y0dpOHRnYjZjbk9zckFD?=
 =?utf-8?B?RlFJQmI4dEtrOGd5Z21uZzJ3Vm9ucTA1L09LVlM2aXJOT3BlejJ4NHAxemZ4?=
 =?utf-8?B?bTlQNkx0QW83VEt0aURQYXoyU3o2OWgwdUVVRWxCWlB4TzNhWjhVUENVeDFY?=
 =?utf-8?B?ak8xQlI4Uno5R2tybUgxUkV6KzVzRlNoaVNUb1doa1lleTFnQUhxL05YL1cr?=
 =?utf-8?B?QlR4Z0IzYS9sdGo4RjZPV1p5TlpTNVRHbWtvL2ErdWVWYVYyck9lWEhrQ3hV?=
 =?utf-8?B?SmVGK0V4S2xGK2tudEZ4ZVZPUVdDSWwxVVNZaSsrVWFSaVhMendjWGtzWHYv?=
 =?utf-8?B?YmZ5b29WZEpld2dGZUlqV21xU2t0UHZSQmlHYjJtUXZSN0ZGcndJMEVZd0Uv?=
 =?utf-8?B?VWRiVExlSXRUajJCQ3U3R0FvUFdQN05OdjE2ZnR3UWRXTGNnZjNTakZEcmsy?=
 =?utf-8?B?WUs5bEZqUHZLQTVZT3JxbkRqc3lOaGJkQXJEMTFPbDhvdVB0Vm5JMk1pWGlC?=
 =?utf-8?B?dnJQMGJ2dWkxQ1NuMmhTTkF1Y21WcjZmR2ltUUlkbzVwci9BT2VCWkhIZkhZ?=
 =?utf-8?B?eUsrK2NFdjZqeVJ1NVUzQmtEbk5rc1cwYml5ZDNoQkhVcnNIRlBJRHprS0xx?=
 =?utf-8?B?K1NvNHJuSCtma3VBYXpXR2hDWWNkWk9wRzBVeC9vRkRMS0NUU0czc2xMZWhs?=
 =?utf-8?Q?YEga/zQN5RblOfCq2rJDMWA+d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09cdb91-83be-4256-937d-08dbfd7b229f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 14:35:50.8326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxhxglkdlcfEIKZHmDaVUqkzsErtPAT0IMtgZQ/yovl7qZs3puba2RJhN5CNAg2OuM4/xdT9UYriBn4bPoys+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394

On 12/14/23 22:35, Raju Rangoju wrote:
> 
> 
> On 12/12/2023 9:08 PM, Tom Lendacky wrote:
>> On 12/11/23 23:37, Raju Rangoju wrote:
>>> Some of the ethernet add-in-cards have dual PHY but share a single MDIO
>>> line (between the ports). In such cases, link inconsistencies are
>>> noticed during the heavy traffic and during reboot stress tests.
>>>
>>> So, use the SMN calls to avoid the race conditions.
>>
>> So this patch replaces all the PCI accesses you added in patch #2, so 
>> why not just do this from the start?
> 
> Yes, that is correct. It was done to maintain the history and that will be 
> reference as to why SMN is used over regular PCI accesses in this case.

Seems unnecessary to me. Adding a comment in the commit log and the code 
that states why SMN is used instead of PCI and how it fixes the race 
condition would be enough. Your call... but since patch #2 enables the 
device, this could cause a bisect issue.

Thanks,
Tom

> 

