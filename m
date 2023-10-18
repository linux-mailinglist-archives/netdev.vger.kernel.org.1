Return-Path: <netdev+bounces-42399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D57CE8F7
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 22:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C961B20FA6
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46357F7;
	Wed, 18 Oct 2023 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByBP4/do"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92773347BE
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 20:31:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D621FEB
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 13:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697661043; x=1729197043;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WUM2+kXHQQ0ag7yQlnXJQ/BJvb9H0JB045LloYnj1c4=;
  b=ByBP4/do+IH04Acux4+5zt/oQLB5yk3h3NF46Yfh2MCgbqBsR6uyW4QG
   0rq+GxyNWBsYaZ8XxLq0rxF7sV8jq9BIMUerNMjMg63KuDnNWXeIKqjTJ
   qp02CEx+ig/WEpPKd3Zht8gccvR3mK8zZhWFmwu2GZnwmFt1jSYGgw72i
   zTl9lAkjN37ZN7Y70yIAaFFLyDyNIb0jCzcomDc0f+WcosUyfRQ1wbDNr
   /9gjzUPiyRQzfNTUIT8NhfML9uUPTJAvB92pZsvloCnw7QIjVAH3HiXcq
   BFHWe6uzHRQ1zjO57K7P5GrrHHDrBxJmKNQlN31+Oz8zk4wyFoqjAwBwQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="365454378"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="365454378"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 13:30:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1088088159"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="1088088159"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 13:30:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 13:30:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 13:30:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 13:30:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7N/9pRsnbBYLGeFEWIS7mwc9eVPfZQL+KcTJsUYMsC14huLMH0IgmPyrNX9TVH/e6s9nz3j3zaIoYu1msYj/v8p4aFDkW0Qk/6OStWTgXbtyB+iijZVR4zHMJ+7phv+BVo+CCtrhaSNwH6amlIplRJ+c68Ys3layoGyzYZLYRSdebqr0yx9XEIay8PNUst8iDiYjJ7qKrYqmg44R31nGK5LHYnNHlqY2hc6OXchuygkC4lhzTArW6/hBjSg7JQazHGYF4vRdUa+n68b2RVCoIvG8A2+tIocOk9V/xzHm3r0ccZEp7cX+IG/7HT10C8vpiCM2O+iHapZMB6CqMwJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCFsrjXTzIG1d1fm+chdJx9ZbUY7s01pEovvAy2P7F0=;
 b=K/YBU99SiZdYEeKGhwpC7WGHqMBvVfkVkUEKW9atR2/EtbQFB9QwA9qTWoCHMK/xY0zEXa0JGWDbPhNo9RbAR+RxrjRPS+QU4x7JjJSmF2O0NuoCGsH+tn3XCxcAnjB8+s58r/g2R0cIfOnjFE7G/tqJsy4VML0bmYrGBI9k7wdk38VmZ1hPWpme9mC/FTK/SdwQM8bRMRBBWcVCE43W5aaYrxWnIM0iA3MZyyZu/8fX/cu9wOC6vAoOQQKviTlOVJJnkvEJhzKzH7dZ6u26rPFG9OrqHVVbSMSZVoMoeVclY5YF/GUeRp7KOOtc6Uwvl8G5aqLodV8Y0xPfZUYtnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DM4PR11MB5487.namprd11.prod.outlook.com (2603:10b6:5:39f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 20:30:27 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 20:30:26 +0000
Message-ID: <438c1d70-4626-a149-ed0a-b8ade4234980@intel.com>
Date: Wed, 18 Oct 2023 22:30:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net v2 5/5] selftests: net: add very basic test for netdev
 names and namespaces
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<jiri@resnulli.us>, <daniel@iogearbox.net>
References: <20231018013817.2391509-1-kuba@kernel.org>
 <20231018013817.2391509-6-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231018013817.2391509-6-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::14) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DM4PR11MB5487:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ae7f2b-3777-4d17-330e-08dbd0190fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xo36WZeXpF95upgMgnhoNwgKegjx+PYTFbePpzjlnX+fDq3ipQySjn7gqgJd07CBjOxGBAjnM8khoCcFGfafCnaKUB13n4EFm6rqEb40J26y2TRjrQoVNblUxAVq1V3rDZVaFU+FLDpk0pLEUfozZGtSqSvtE5bsi8vQU5qvvin6ctYhnQaym9Yr1UzCAhggV5I6i+Wo5JjztAaSq8gQA6bfFdEuLFdui0zzqumSrDHWJguT61bJhk8G9fWT7Yv69UKN8ODJQn+jHU3nOKdtwIpPZh4Dt91H/zkIPlFtslRURzUDqWfT1jyGNCZQpu4Ky1Z5f7qrJVmYoqEWXF+6wGoedzXkvbteQ+0zWg6spIuhlG5dHtYXpuXZLmYwAfo7ffnzydl7dHSPY8Pb2kNJmj+fqUXWb9CbR7hmDY/zNLuocTge/F7s8FcGkP4cImpNZ0goB2/dkyKb6zAT94V91LBzizG23bssMsGTJdtqehku6k5Myfx06iEcgB2sswlcJDE+/7bmzD+j430nEZmPFruLqXqu574W7Anv6+US2lPPTOEXNUYl01ljSznX13KeZ3mgVvrtAY+IR/IGRW2XLlsKviOwoe0Y11CWnXlb6JVG9CCAmpFYysypGcjwMsbtEGMKky571DddGS2D6c0BuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(83380400001)(4744005)(38100700002)(66476007)(6512007)(36756003)(2616005)(316002)(31696002)(86362001)(8936002)(66556008)(41300700001)(5660300002)(6666004)(2906002)(8676002)(4326008)(66946007)(478600001)(53546011)(6506007)(6486002)(82960400001)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkdCdFJTT2RucWc1SnFtTk11Qzd3Nm1SbW93M1ZJc0MrTlpXU1Jsb1kxT09Q?=
 =?utf-8?B?K1NDK2pOSFgrQmdIU29lczhOMjBndXZCejVoMnlJRnVOZ0FkWVRBblQvcWVY?=
 =?utf-8?B?WkhYdzdhQ1lwSHV6Ui9PekZzQ0o3d1IyUDRUclg4Szl0RngrUStPd0FtRUVa?=
 =?utf-8?B?TFE4RHpsV1dFOTUxY0IxbG5NN1YwNnI4WU94TnhLbStHOEZtdXMwNFBmd0pT?=
 =?utf-8?B?RUl5UERmYXZPNzdEY3RFb096dkthcmRtWGRkUXRWVXc2QlZXaEtqWXE3Q3dD?=
 =?utf-8?B?MXQ5U0l3dFdJYVpxWmkvbSszdnlHcDJHWUpSRDRrVU1BMytLcVhKVk93T1FR?=
 =?utf-8?B?WjdmSWEyRWovR1g5VTAxVmJiK3pOOFF3MVpILzVxME95ZDBCLzFUU1hkTTQx?=
 =?utf-8?B?SjZlRks2T2tsQTduVUlZMFNTcDJkWUJrK1lyL2MrdDdtd2FZY1hkVlBpZXJP?=
 =?utf-8?B?WjlVK25oa05FRHJFekZpaFp6Wmk1YXhKeDg4TDMydUx3dmU4YlBrSGZoMGtF?=
 =?utf-8?B?dUF0MnlGOTRwS0l6MCtIUjdpNGtaTHkvVDc5cFZDMmVxU2ZLK2ZnckJqVWI2?=
 =?utf-8?B?M3Mrdk5QSUtwMENlRTI4QStsbnVIcjRldXNLRnVFVEFDbDZicllyVkZ5d0Iy?=
 =?utf-8?B?QzBBUlJ0QTNmSGd2Y0wvNUdLbGppa3Z1QW5sTnlNM3VHRThMZWFFU3NGeWNi?=
 =?utf-8?B?Z3k0Y3RQcHNoU1oyWERXalJOc1BZUG14TkZsYnBpdVF5UlBXVkZJdGxmd1VH?=
 =?utf-8?B?NXR1bTZpQXp1Tm1RWCs0NFhTNGMweGkvTnczaFd2QUxRSlhYTE9XUjA2Vm9v?=
 =?utf-8?B?VzJabUZnRnFacGRqb1lhNkV6VjZNWHljWHZaREx2OGdQOXBwY3F6VkhEdkt2?=
 =?utf-8?B?NGtjeHN6YzkyNmFPTWYxckFMbHB3ZS9xNDB2eXNsYnp4OHJRZ2c0SVJBTXNQ?=
 =?utf-8?B?eDNNZ2FLaU1DdGx0ZXlkQ1M5dU5NR2Vscm9zcG1HVVVpT3BQUEpOMXlJMXBw?=
 =?utf-8?B?ZzNoNUZUS1ZoWkFjU1BMeXhMZGRMUE12ZVVoZFN3UU1EQlV1QnlxYXE5OW5t?=
 =?utf-8?B?Ukw5RE1PQk5nZ2c3cFE3YWVqZlZLcVBkRDlNZlFCUlNrVmJHUXBKZGZQZkRU?=
 =?utf-8?B?am92SXExRlBPeGo4N1ViL2ZocnFUR0lqNmR5WW5BYkh5cHlqelV0VUtoeDNY?=
 =?utf-8?B?bWpJZHFhUU1KckJsUkw0c2U0aVFMWlllYllYaFZrUmF2UEdaMkUzZ1FHMWc1?=
 =?utf-8?B?N2V5R1ZlUEJnUHF0WnRSdVY5ODFnTCtaOHozcTZ0dWxtUXlGeElUOEZyY0ZM?=
 =?utf-8?B?cHNQODJlSmZ6T2NsSXpYNkRxQzNRRWY0ZDlnYUNaaGdvMnE5c3pJZEJQN2ty?=
 =?utf-8?B?NzFLMURtYWFuc3U1elgyWjJNMzRMZUZnU2RuaEFOT29jUndjczMrcTJHYy9J?=
 =?utf-8?B?MUNZZU9YTzFEaGc4UjBiNTdpYmRqOGlOWGJQZzR1UHNKZHNVWnNSQVo4cEtv?=
 =?utf-8?B?cW14d0xMUlZ5SExNOWNES0RQaCs0dFpqUUwwMG5Rc0ZCaEFhdkpQc05UNEVL?=
 =?utf-8?B?cjZDWks3WThGWXc2RkhtWDM4WkdLenh3clYxOWRZaUhLcDFuYS94YzFZbUxm?=
 =?utf-8?B?bUNZZnN6dkhJMnhpM0hOSUJNK2dERE0rZmdBTEsyNklFOGVodTFCWVFMbjg0?=
 =?utf-8?B?SldpN0hCbnZuOENESG9KUFUrMzlVUUZ0UUhMaC9RWTlLQTB5c2ZKYjVPWHI3?=
 =?utf-8?B?NXJ1dW5QdEZ5QThsRkJ6UkJ2Qm9EVVRpanNSYVAxMzVFSzlIQ2tzK295SmN4?=
 =?utf-8?B?aU54azlMNlhET1lPWmFXWno2eVVWaU5CVFo1QVpCcVBzdlo5L0VjYTBBbmV4?=
 =?utf-8?B?WHRLZXRJVVlzRlFseXFLL2JOcmtnVWdzaWRyTlBiWFFydFdOcnF4d1JVLzZW?=
 =?utf-8?B?Nzd1VXY1OXFpM29rTGh4SVNUZ0FYY3VjUU5rK25MVXRwbFhkLzNaM2hrdEJl?=
 =?utf-8?B?TG9nL09tR25CQmdLQm1hVVZUTGh3d2ZmbVlrYnFjSGhLMjFjTnB6RjFwcGZx?=
 =?utf-8?B?NjM4b2tJMjRkb2Y5WnFDMXhNUG5ocjZ6bTd4UkdQbnVYOFRDWk1FeFZBbDI4?=
 =?utf-8?B?cjlZaDR4cUszY21GalhtM3lXaXh6L2FISUp6ZVp5QlhIZDFlWC8wdzhnbDhM?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ae7f2b-3777-4d17-330e-08dbd0190fcc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 20:30:26.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMHG0BXlHLWhxOwk6Q2BOcGoqpmGjR6lxUcqNW8CnIyUyJlBIkQerSGFLLR+wGQVnrxrPoUOIchd5vmKUqS5NnWGbDUtjuDFwAmcFJZkM2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5487
X-OriginatorOrg: intel.com

On 10/18/23 03:38, Jakub Kicinski wrote:
> Add selftest for fixes around naming netdevs and namespaces.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>   - drop the \ from line ends
>   - use Przemek's magic for the error message
>   - redirect errors to stderr
> ---
>   tools/testing/selftests/net/Makefile      |  1 +
>   tools/testing/selftests/net/netns-name.sh | 87 +++++++++++++++++++++++
>   2 files changed, 88 insertions(+)
>   create mode 100755 tools/testing/selftests/net/netns-name.sh

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

