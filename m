Return-Path: <netdev+bounces-17150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216E0750981
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29021C20FB9
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEB32AB46;
	Wed, 12 Jul 2023 13:23:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C533FFE
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:23:00 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2094.outbound.protection.outlook.com [40.107.95.94])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D8C0
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNQzUrRUXAWQ354B7ryOme36wvuvDw0cayF7G/qdjIlJ7sQH6N7YTRM0B6Z1UjmETpFVGaz9Ebf9kzA+ZkWuTPjI67Lh26QhQATrYucex/tttgkUuI9IV8EurEPGoRZa4Myj9MPuj96IHgLH/d7Ue2YUYu4BDXNB4ta0aPveJeeVTqBcGmyEwb7MZPor4QvvkSMC+JwrrhyCcCeGY6qkVPDW1HnWMKkOU+8Bgd9iWPL2u1NEDFW1J0J6tFTxSJ8BD9pK22wXNR+zpZ8jbIOnQcrQ8+fuqeHHC+4xWTJorihihSCHa9OFhfLunemzcxoUjP1Sg2JyH7C1fXEY92IipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OipH01fy8vi5hz8u9BakVeclYN3PzCx8amYtd2onCOk=;
 b=YpOJIEppxQIdVEJbKBfjlqyFlHQH0nravU3Jx9/cSJdDuMePqZTd7gLsX61Bl6Lcue0R7feIBW0/D0XqzhQkMdpZwhXDSyn9Of2mgsUP5N04+ddu6S/0lBqiIrAEQh1TWbecImfgiNvMyrhh292Xt6Z8D3fwYwKcnlqOyhMt0JStAspY8aEHPslUF9YpVyR24uM9MRprx9T8gY1H8iK85LcdSxTkJxOwtggWRrhJDgEtrnhDz+yvPo+IR7zqV0o/t0UgXDGtPGNQE9fR41wBevJMW39IsSd5VqCVPHq9ZdVxMzrdsJD396S8D7sjkseKkkaviBdjrZLcELHmzMKZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OipH01fy8vi5hz8u9BakVeclYN3PzCx8amYtd2onCOk=;
 b=Y+Xttsp3UVmJouSSNlSW3iAjaUeX7wZzakvGmSvoZzwMLTW6YUm5874WfEDypJxh4iOgxq/e7CjT2RrTXfCYAXb/QAG9LyLTf73JhTZHZ22QWwT6MVrPh0UhUgtZLS6JT7CiIxJtq6ptOW87URJcLdzPxsIaMR5nMuAzEx4vWuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB4432.namprd13.prod.outlook.com (2603:10b6:5:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Wed, 12 Jul
 2023 13:22:54 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 13:22:53 +0000
Date: Wed, 12 Jul 2023 14:22:47 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Jian Wen <wenjianhn@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net,
	Jian Wen <wenjian1@xiaomi.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] tcp: add a scheduling point in
 established_get_first()
Message-ID: <ZK6pJ8Z3VZOKKMyo@corigine.com>
References: <20230630071827.2078604-1-wenjian1@xiaomi.com>
 <20230711032405.3253025-1-wenjian1@xiaomi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711032405.3253025-1-wenjian1@xiaomi.com>
X-ClientProxiedBy: LO4P123CA0426.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f1744f-af9e-4e80-6bdf-08db82db18f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MoR/gVnC9nx0xRRNsXBkjf+RS9CehXME3UqupRtzvcj0lSuQB4/Ytmle+hLGqMAwDzU+g7VBqw489Znm7ppOLt34LBBb4b7lbj7vJVKp2MmEJspu90iGqvWyaSUfKIkdTrE/JQ6V+Dr9QVnoQZQjBO2a80YpVQVxu+hItPh7Gv+z65ZY0//sVsuqNSkW8w+3vzyGG3CXNqAiR9h8mi13RniiZYpeJKmP6a0D96q6O6/mlaiw62lHt5Mxmd7jsoxgBYsjukCdUETVA5OrySqoT/cmSazbr6IHt+azzbj8db27zDV8ANzj9ZNDiTf8D8hnnw/iBqDLB2Uxc6TS3R37z8t+yljuWqfpTTBp66l1SodLDZ6v1w1MRG4KRHvxfLKuQiLm+2eqfYYHFNC02yv/ABPDPxCJqcG+Xzdx5DN8BZBGVXwJM1/QiWCMTknixKv+ga37WmhTGc67NupkeUiVSZI4ESZEnh3C9ym3vRu7c6n79EVCD6+kim43fJhED36eza3SnhFzT91wtGyw43WteKTQbisKgCdTidyKQdH1TJvMixAFtdgoFGxYIUCTeNnWCxvly+zYlR5h3jQXhSlrYqavrrC6xaArXpJUTQzjuR4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39830400003)(376002)(396003)(451199021)(186003)(478600001)(6666004)(6486002)(2616005)(83380400001)(86362001)(36756003)(66946007)(26005)(4326008)(966005)(2906002)(6512007)(41300700001)(38100700002)(316002)(6916009)(8676002)(66476007)(6506007)(4744005)(66556008)(5660300002)(8936002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HgFBiUelouOt6U7iZOEOlyWGB8bqeZtrZLnEoG7l4yHc3XDHbpjVvOyEohQf?=
 =?us-ascii?Q?yvhA2RgV19c6bdVEcidlH/u2QwiVJMR1liFrFAQ6Qy9hfV43gMFu8tbtNdLX?=
 =?us-ascii?Q?JGEWjc1zs5JxSfPIDeD+Kn3lu1lgTC1K97htM9hRK7s5pVgb/b9x+hx/2sUX?=
 =?us-ascii?Q?vJyq7AqTxJ+YvFINt8DO4mXh1TyP1+MqtxOdwAP0ezu9yi5+b0EfrIqMMIfA?=
 =?us-ascii?Q?6aDKY31l7hPDHCiD8Ixo+EAWoKVoI3rXOZ7UZaf8cgiVf5v9tu+Z4FA81RH6?=
 =?us-ascii?Q?mkqOrlVqVplOBWcJCuI/fSgljl9Bci5T3f8Qg7LZNcRptLyz8IdMwJVhyKaU?=
 =?us-ascii?Q?v+7q0TT1O3X0gNB+POXUVvWar9QDhag3vdyTsiu9O5Kj7gGYqwChRwFagz1I?=
 =?us-ascii?Q?VrWV1ei99ywQaTksDg1pHjIinhoTWEKN5XTs1AiGwBV3/HCMpFD7iQzoGeaG?=
 =?us-ascii?Q?XiU2t/OR9kITM48HvoJZjQ3Z8ds+yQXve887c/e/6ZEwnsYCmsNerfa3vCUw?=
 =?us-ascii?Q?YnQpVPclPl0Y2p912CKx9BDVWL6PquCAElAInYfpEREthQ4oE8BkxUGiZKJj?=
 =?us-ascii?Q?v3frHWmwNhD7pAet8j17Ca4/Wi0V6wl9+5e1bB13IWC2wwPAUDRNDL3MQbEX?=
 =?us-ascii?Q?MsSqcOV9MCV12Lo+Rk8XL/hOrpOgywtqA9ank2IyUrJorytUVJyPEPwkjB2G?=
 =?us-ascii?Q?Xqey2pO1fyUvGip7WjUR0Zb2td3UU8BpihbOTlQeNaTFZcVEWQ9rNEzWByBo?=
 =?us-ascii?Q?Be/ab9/SVPoG8zt7dZOiI5EJxOoMKWe2YMJR8WJDakVGt3eSEN+GXufBMN/p?=
 =?us-ascii?Q?48UVT/aZjsg0psJqCDH82H7/jMbZwWYdzw4oTMq2JSvaAGb8ooYKSRAiYptx?=
 =?us-ascii?Q?3dKuyOo6343Y/3blRsjTGO5XS4MFMZIr+IIE1/CSaa/1Huebf8n4755y88IE?=
 =?us-ascii?Q?3ELoBmB8EoNw1hu1NwuAlFITXt/BynWoCIhkZGpMAbt3G7mxfBIKB925lTiP?=
 =?us-ascii?Q?MIIy9aGST+vq9DZA/rkyFQvQBu0qsZBvut1ln7j10k4ZryQPRLFD8d7ksYOD?=
 =?us-ascii?Q?gncnWuTUsS6Uw9qjnv8BEB2wUxEgFK/Q0zwJEiddi6I1B3I+7uQ/LSHeg6VX?=
 =?us-ascii?Q?yBMu00wl6egE12j5hCTo8AJHIeQ722Llxtn7AEvAvwxClpv9huBB5rqpFDDR?=
 =?us-ascii?Q?wnoF9A0IC8I+xYZIENTf4CsrUSw0xN87mJeY3YFjN6tHSE7Op9n7aplZIYuD?=
 =?us-ascii?Q?BMo/AznkqVI/tep6hkGGHmTntIgMj9jLxWMsu97l0dHdSUrtvNqvgxN+BeJu?=
 =?us-ascii?Q?e91nhzvQPO5SfFtk+cEDneZezbvH+cMAeeG2R7ceiyoJSscjHhPlSpu2NhN0?=
 =?us-ascii?Q?VIde/uaswxv8HVmwlh8a5gYo0ov7tFP6jX3eED+q8ciVR2Ci60Of96rqewDM?=
 =?us-ascii?Q?X7jQYr/I+WmvWYFCrdlBkAIebBCZlf70C3pVM2/uaBZYSjv79nr/qniRkHmq?=
 =?us-ascii?Q?YHwHo7FiVSZMkeKZ497k0LlSEZ5KYKBRAC0blG6U3vDtoL/4YjgKdxGFZ5HJ?=
 =?us-ascii?Q?3jOAylGWniC++57lk14duVE54ve5Ybvg+KhgP9E6z84YE9mDnKAT8yWmfhMe?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f1744f-af9e-4e80-6bdf-08db82db18f8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 13:22:53.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1xTye454GNp1PkCAeyjTzjBwu+iDauVVYzEpyRxEuX6ahlWNVz2ipoeAfxgk+bKblQ00fBQ2vTiK0Zrjb50vUv3IV14nFhUwfVgtPLAVjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4432
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 11:24:05AM +0800, Jian Wen wrote:
> Kubernetes[1] is going to stick with /proc/net/tcp for a while.
> 
> This commit reduces the scheduling latency introduced by
> established_get_first(), similar to commit acffb584cda7 ("net: diag:
> add a scheduling point in inet_diag_dump_icsk()").
> 
> In our environment, the scheduling latency affects the performance of
> latency-sensitive services like Redis.
> 
> Changes in V2 :
>  - call cond_resched() before checking if a bucket is empty as
>    suggested by Eric Dumazet
>  - removed the delay of synchronize_net() from the commit message
> 
> [1] https://github.com/google/cadvisor/blob/v0.47.2/container/libcontainer/handler.go#L130
> 
> Signed-off-by: Jian Wen <wenjian1@xiaomi.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


