Return-Path: <netdev+bounces-17497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C58751D02
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3452E281325
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4835DF9F7;
	Thu, 13 Jul 2023 09:17:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD39F9DA
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:17:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2097.outbound.protection.outlook.com [40.107.94.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6ACB4
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LibdzMVYzj9rrDQdI1sPJFdEevDAtjZlz9R+ukexhTJSUoVkdC5rBiku7Tj02dkb3EUDopcqC4CMzyX4TjmJNvRxdfXuChKg2AZ0f6U3ZoaA2J1vQS7Y1lE07JYUL7SoA20EX+BHylinhYdWPr/GO9xksxEMt888xiV1DMep11ShqBcSGOkAuhGO3kGuz+YvnA/LuBly2gBkbcM8G0kD9STzy2vK8LeZRAXG0aReakWyfNGVhU7zgvjwSyg9HM0tghUIpb6DulF+7E1JKQswopdPWgGMhgKp0QTgXC1AGur5uKvV75/1/BM0IzebVii40lK8Xgz8CaxsKzvQBG0Tlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJiPhq0Y/J6xJGOyuu/Za9grfjsChK5Fxj/irMUOaiQ=;
 b=jdKQbXGmnT1iAZpebLpLwuW1LxkPeWJUcxUGcmlPEPmSwgKf9EBF1uMmOy0uibE+X3vnjs3gHwcKThjp/t2PCcM32AK4BIJaIR5xlI/9Oa+XOyLhOT8XopwCVZ+dC/fULL5E1fpxLbb/E4LsbOjpHUxOw/UR/2vFY7UXEkspQdVMr1VHSR0nDhqTTgh37XhCPaf9xADe+L94+p/Cnic7+pLG155E9CcHNfR3eTfy33f9MBTr1txQwwXiU4zoetHmCM8gEIgdzT7667lZQQmhiOW4LREJRoVkkNZHCFd2zsyUVjx2JiSMU6xVHYEZe1TCh6J+oVHNijmNNS2kYPdU2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJiPhq0Y/J6xJGOyuu/Za9grfjsChK5Fxj/irMUOaiQ=;
 b=RgFK92bEsewn8DrcWxxB4xtvLeFwEh9dIB7P/6cpi9KSPj5vl7LrtvqgNau8V5xY0Csg9OYBErLv18iQ+QNopgKkaD4uOU3regt6Sd//prv8TYMSySuhDPdWS675/P/pzByiewX24XZ4boF0QwyO/QD3HvhqzWAmeLpgoJynw34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA3PR13MB6323.namprd13.prod.outlook.com (2603:10b6:806:39f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 09:17:49 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:17:49 +0000
Date: Thu, 13 Jul 2023 10:17:42 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
	kernel@mojatatu.com
Subject: Re: [PATCH net-next v4 3/5] net: sched: cls_u32: Undo refcount
 decrement in case update failed
Message-ID: <ZK/BNvy+BFS/KnrS@corigine.com>
References: <20230712211313.545268-1-victor@mojatatu.com>
 <20230712211313.545268-4-victor@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712211313.545268-4-victor@mojatatu.com>
X-ClientProxiedBy: LO4P265CA0165.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::8) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA3PR13MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e2cf0a-98b2-4962-b820-08db8382074e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YeQzHA7FRSYZmRwQPqfvE7b4GqGNL33VEXsyo0oersF4LHTp54GuGw8rVZvCHdw9eUexbZLLz8ChwRXRGRaDM4ZyP3P3TCk+oNpDN479Z61YbCNJziRBdt51v7e0HRvYfDjnAeJvIrnu3GjVgzSmHxAuvDSzJ2AroFtUYdulzI8F80Tu5GFumJWSsjdgrzrxUsRDjtZLrtXoNBfQbSi7YuoPqsQiJBA+MxDGoOqsr91Fqo7FwJESRwIcs8sDB4jrPyNsyPOWKYDPtBoXCwyCWCEC2dGddeT274ONNBNvV8gRMDq4tvCmduRO9KUoJ3MnMdnRK53AUYkU3GT4hsDg6SxaIJIZ6P/wFYvyuefhC0rl1jcSYYcQiRsTMXkGQDcw9bBjORn2ri+Bdka6Rtg1lkdTHl2fyfIfi2hQxdWyxQub9gEtB7FWSM0yceu3KT5hBFHdcgc7sfmqLd7rjQh40XN1sWXiNSYvqkohZ+WakwGct7j+P1WmRjDZ6+p4SWxYQZYveSSHVMkXWGd5tL3nLnjwAGCaEOSGmGcefkyBCkP7dvg8ZsASqtycZlMeuD809B67bZki42kzdxVX5FcgvOQBODx3BLa8/wkTAKPKq1I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39840400004)(396003)(451199021)(478600001)(6666004)(6486002)(6506007)(186003)(26005)(6512007)(2906002)(41300700001)(66946007)(66476007)(66556008)(6916009)(316002)(5660300002)(8936002)(44832011)(7416002)(4326008)(15650500001)(38100700002)(8676002)(4744005)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JkV0GaTt22uSMJ54icNTPX7uTF9KvP4EVxcFB+5X2h8+9Neimc0YtmA2tEEW?=
 =?us-ascii?Q?OhQ1w4mmyGG03/U6QvNrI7ORu9cuqSLERiKyrTvdqjcdW4CZFfz7I97euVmP?=
 =?us-ascii?Q?3cp8JwoSrek2aUdVsETNUqaNACIkXEI+9/y8/QUZD/8+9DnXVZrJIhIa1HGD?=
 =?us-ascii?Q?eOjFDcq7e4cuMTZ1AZJ5vJ+WaFxpeZ3Kw0WO9IVPS08u9dQI1TzNU2RbI5j8?=
 =?us-ascii?Q?V16yJDLJlqhb+iFfDx3jBPfib4MnKmP0OOXJDKxyCr7U2CZ43gDiJQVh/4sk?=
 =?us-ascii?Q?Px5y6AdAexvQZOWHvvYUKb4QpMvQvyQaKIZftcFsg9Z4WSPaKWssZ/+gs/i/?=
 =?us-ascii?Q?uBSTHZksVYXDQYQY+MyyrLe4b2EuZDiOSyNKh2jVIvrHUNtr1TVxP3LypHAT?=
 =?us-ascii?Q?59j+chpd3p278vQl2Fr4bR63HEnjC/PHrZ0jOtIcl6hvuQrdJPbOCo4hHO24?=
 =?us-ascii?Q?TaBPxcyRpfSGB5A7moAQRQ8zC6Uh+qpBUS2R7aaV/eGgq1kaLA+kqxZLaRXg?=
 =?us-ascii?Q?Hd4xc1uNF8jSWeRwaPr1byTRyBEhRGj6EVOeND+/iwr1lfuIrbjttDcnnWRV?=
 =?us-ascii?Q?/NR4Y+pJSgYWvT2h7poTpSm42BY22ru91iSh9z0YpEIvCIvr1ybCx0xX5SZe?=
 =?us-ascii?Q?UmYvbwl3eahQbk/mM3Tsxq20wt8UCU832mznDmd94s1ZDb2g/vmaWb3OGFsQ?=
 =?us-ascii?Q?65V9VSUauBQQTSLUJn5/7W393/ot6n53q50NU++qmkOFzUB8GZJU8N9ZuI0j?=
 =?us-ascii?Q?vq1RoZV1yQUmfNkfivp1VAmkFa4wqZR7pNto1ZDly63KUTZeMCUr4t2pydNP?=
 =?us-ascii?Q?vKUuIRtjyPMNbyZfz4BPN9PS5NjxkGxHHvZjgCHYHsRWIPwuSlF9nVj6SXLh?=
 =?us-ascii?Q?M7XvzGijXW+6uBvzsMfAFK+BqfkvC7Th2c3RMKKCsKrC0tteni38oQOm3NLN?=
 =?us-ascii?Q?BOrzE4f0MQVhBBVqXKEeJoPfyewJ71DM2VOCdXwFfkCLqYh8pz2Ed+4Q/8Ys?=
 =?us-ascii?Q?KL5FCSiafx77VKZh1IfBrOpcn8oqdaqXG0RIoE3KsjyKymbCnaqjigd5HpvD?=
 =?us-ascii?Q?ItGxSGvOXMeTWKYsBIrtTP1Bw1r5WgS4fDaPZMI+m4Kfnd2s3QhbADiy6Q0H?=
 =?us-ascii?Q?d9zwDx8ZqsbDhqsP9Lc5zWUADiYbm1f5RFToLrlQb/XLnpGmLA+g4HYS0hAU?=
 =?us-ascii?Q?KesBaC4dkGs8s58qpdQJ5mtvVPZ7ETh/0GBYv3S/yHxR7yDfiTJgLj6JLaHW?=
 =?us-ascii?Q?b6mYKZAdQuG2f33GNbF/K5p/omB5vqD7uxuuh3lACJzmDw5qRgA4aEaHNJ4b?=
 =?us-ascii?Q?K7Y3xuERtEKE7AM0g5HfvHDp7pfqxMaskd+rj7zsf8QZCHynoYUKGqv/Rf0r?=
 =?us-ascii?Q?+9SKYfpA9C5F9MFt31r4IR5bMDRDp0dP5S/M/eaNAMApUOFpvY0JhB7F8ji0?=
 =?us-ascii?Q?HqQrh52qArNTWc1veEea5T7NxCCiMu4sZ88hrICvmtP538iIzaxTZIHO1dna?=
 =?us-ascii?Q?4GfolrVGBpIZcAzMYSBycarqNaJlYKJSRJypsEJi7wr3MqTbwnMuDlhB8F6r?=
 =?us-ascii?Q?CeFmCqrYRv6S2uDnEZ0ArRG5wkNdt25hpNrDusgBLfLsEv+Zw6VAZoTj7ZnH?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e2cf0a-98b2-4962-b820-08db8382074e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:17:49.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZafCXvoT2g1yr5gL7wR47HKC0Qjzh4RFaH7cjH/ZRnP3205ns805WtX21x9sxGHWuC2fEIxtlurSndZ71bdR5OItvHhdvR+K5NYH+QZj7gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6323
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 06:13:11PM -0300, Victor Nogueira wrote:
> In the case of an update, when TCA_U32_LINK is set, u32_set_parms will
> decrement the refcount of the ht_down (struct tc_u_hnode) pointer
> present in the older u32 filter which we are replacing. However, if
> u32_replace_hw_knode errors out, the update command fails and that
> ht_down pointer continues decremented. To fix that, when
> u32_replace_hw_knode fails, check if ht_down's refcount was decremented
> and undo the decrement.
> 
> Fixes: d34e3e181395 ("net: cls_u32: Add support for skip-sw flag to tc u32 classifier.")
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


