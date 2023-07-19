Return-Path: <netdev+bounces-19200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220B3759F6F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 22:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B72281A38
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 20:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E51BB5E;
	Wed, 19 Jul 2023 20:16:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A31FB4C
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 20:16:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2103.outbound.protection.outlook.com [40.107.243.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2F21FD8
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 13:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE7q6CJsAdJk3AoBQWlYZIekVaExhUHzhVL9S00uda5wW7qt7SMnRNUYTVdZJedFVj32Ikqliw2HxZetQXMmtb+o3zuNkdmHGsc02btgO9m3nQfvDMwwPUlJHwskCOQbM8udR5EGoGLOCsJO5Cmdh00cl7NbWME0GW2a6AKYOf+44YvpTid7Sro0wkBhzs8mUwEYYEfQ2d1eLl/1NJi3I5L96/KPzQ4s7LBghSEsVtL0G/4vxnq+9XG5FAPjgFKchMozDK+iJoFObyYqqml+nCWvw+fRgpFmir8qjC5uy2z+Pdh1ikPzTT6idHehFdju5kEakMqmEg9yKgOmlh+hGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWOsELM/ZuX9EbKLFTdfA5tjKJ7A4J32clJAgWF3CL0=;
 b=PfhBDFXxZXmDHic67bE1MUN6e1noOLCXqlVs1s54gYi3ekz3g6iscHEc0dge5VWRHTfbxMutUzTTdt7iAkzNRqJewXf8u0fPM9f0H8ux9PtjouNYtEs7GbkgY5HuZuZhPqge0M6WbVSPTmpI7IEPinHfmoco9q3sUe4VLumPOmsSz8FRYa4qtedks/efR6PYMalZfrDVZ3e6l08qECwwcB9rr39dDF2rf8qetckxp6wxvUQeJcB1RGa5qRLpbsGfjLcQSZNuLE/nmblB43HaU3gKmu/qo+Zh88PLuZl4qUMAXa2flmR3DPs3YpQsSSXIeA7NP0uv78uRZbHcx8CRnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWOsELM/ZuX9EbKLFTdfA5tjKJ7A4J32clJAgWF3CL0=;
 b=AeCeak0D4LlZFm4tcf1MjzDROH7QxKHx4HGBAFL3rgJeoK1nv3r0mygA2EczRcnoeHE+WFEF8SWonAKV3cdlLirjDZw30sTxB0Q4kIvdI5uNC04ppFG4wePyA+BXe+PC7hWfdns6HdVu4G2o32fx8F31du2Epp2ywj/TMMbVbyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5569.namprd13.prod.outlook.com (2603:10b6:a03:424::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 20:16:43 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 20:16:43 +0000
Date: Wed, 19 Jul 2023 21:16:35 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ruc_gongyuanjun@163.com, ajit.khaparde@broadcom.com,
	netdev@vger.kernel.org, somnath.kotur@broadcom.com,
	sriharsha.basavapatna@broadcom.com
Subject: Re: [PATCH 1/1] drivers:net: fix return value check in
 be_lancer_xmit_workarounds
Message-ID: <ZLhEo32623NaRYG4@corigine.com>
References: <20230717144532.22037-1-ruc_gongyuanjun@163.com>
 <20230717193259.98375-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717193259.98375-1-kuniyu@amazon.com>
X-ClientProxiedBy: LO6P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::8) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5569:EE_
X-MS-Office365-Filtering-Correlation-Id: 026ceee6-2793-451c-75ba-08db889511c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3dhaMpRT9ObfBgyujJ7pB1dg1iGKAYA3kYIT9HNZkrsKqxFOUOCd9MrgtWCSN9w77LmPh7c8cinVDEs0KKfhw2ZwR4Uwgz0o1xaUBvlHw/qyZGRRCVKyd69nmC5H0KqRHqh4IyUOB5W1splVuaOCL2K0emaiTEak5ErOKLdqie6rboue3Hvr6OnEc+g3k3w3HpKVHK3gfc6EMOiLZENsu5zo7jGCOcDmca4qLvSYlnU8QzKtqoA5lpJw9Qi2mgcUo14ER323ifAiH8y/9y26br8IF1iP47jAvwnLAJcTG6aP3DZtCBbeOTCwA0liGInxf4eyYTMNSubnAGoraLQRaE7h+NWKM/KICt8fKKXpf4FOL+JQ46Kqg/qoVOyjKASzL2hACuCPgOvzhxPR/LV+q3yZekB/aLZneIbfIAlhbn9UgFasONzZBGaQMkKzMjQ2z8VQqAIs95ibNlxvhZhSrUp3FG8sDjxktR9/kLr7vFhxHbF1Q49sUZtmyokTytvlz6d6kX8lovIg9CiAwWalaYoRsbIYKoSHDyILAwdWWtfdzU5+CA4VIUljxuhVMyog5vE8rK2JegT7ffRNfbPfpOZHdwW0WfNCC7NnFjPoW3g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(39840400004)(376002)(451199021)(38100700002)(86362001)(36756003)(6486002)(6666004)(6512007)(478600001)(4744005)(2906002)(186003)(6506007)(55236004)(26005)(8676002)(5660300002)(316002)(8936002)(41300700001)(44832011)(4326008)(66946007)(6916009)(66556008)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jhPW1Ir4nAzyudKAZlchgmODC8sY1GMm3DQ9QHt7N5o4FiwXebKnmgKAwLqk?=
 =?us-ascii?Q?olqX6ItTjLwq/kavCuqOopoQh5K5JgcM4DhN0mh5sSlImbd6efmVlB9mRgZs?=
 =?us-ascii?Q?UxzGB9GfPtk1PA9N7AZdYtUoedt1cq5J2luBiWcJ/3seLjnQ1G1dsChQ9q9Q?=
 =?us-ascii?Q?bnKbDSM98Kiw76zxAQTTNWZfq8Fl7CaHNgzehGNmn2wgXJkzp6yd2atOExYP?=
 =?us-ascii?Q?Z/iEs+7/h9mqZ6AuO3fZDEam4TeJryl/UhdCisD2N5oaGkY0W7/SJi/aDlnP?=
 =?us-ascii?Q?jw3Z3RQVosBAzUa0L7ZoUsMriBEVSW2NlSQef7YbQuuKJrAYInIggS8UC7Ng?=
 =?us-ascii?Q?5t3XAXWdrI2UBNiJ3GaYLgNiXbqLnkMmDG4pZYrXhA8RTU9lZFVDjfdGhD7G?=
 =?us-ascii?Q?BXUX4fR05aJczaKJQfs2yGjXQdDUefg3RolgAsCc3yykQXiiwAnjTqKMWfze?=
 =?us-ascii?Q?/7s7UJphdsZtd14dcLn3elsTOMTyTnl+VbzsIZH9gPhuY9PlFQhX+uq75tUO?=
 =?us-ascii?Q?RG4Z5nUcfuaBV9qebI8NJm9Okg1HW7Yv7sEFNkX5Mx+Vu/D0pk3R/LFhjMYd?=
 =?us-ascii?Q?ZwFYuBO+xBD0t0h7619zYMRmTrJBwlBBC+flIZlSffKe5sspuqN6AGLrHJF5?=
 =?us-ascii?Q?UiXnfvNFl4r7bDG3Dqe5SqkqpP/xv+x6ulsOvX3ErQ0e8wWg+7/6i6ifp7TL?=
 =?us-ascii?Q?EtH7fQfQBYNXFdc1baV5peANcykCXK83kWVJf+jvCz2g9ayJ2o+bUzImM1ud?=
 =?us-ascii?Q?0xUB90EkmepvDw6H4CwrDr8p3DBgQfY9PItEKcDvaGl/DcxW74PID3iSJGOo?=
 =?us-ascii?Q?/x041+baY2AGCHTm6St2SkQW2YNunO7llowzd3tC0g6vpSPmRijZSJj9ZGaS?=
 =?us-ascii?Q?SufSrqPxTF0E6DRQMt8yvPQ4Twn+/di8NtQyOjFD+wC/1Kk1UTXQDr+8G/KL?=
 =?us-ascii?Q?ktAXGidN8fY1BOnKZ96msP3EJtM2joGJso3SILMrIvgU5xRzZlC8JPArxkio?=
 =?us-ascii?Q?W3Psd4cdDsFMWp6Yqexe4AG9e1gqKGQDCDZ6i5gnJdSYcAMcERMzn/AjyELr?=
 =?us-ascii?Q?FFFzKR8f56xY+0IUeA//yQXXpHFdY9sxqB+3CKJ5zUisfiFqD5GNHX++MlEQ?=
 =?us-ascii?Q?7FAtNOs5xTI/zkyVb4fpLeFRgKV3/ofHnqJC5m6Pz99ReAHHk3TnymyM1PcM?=
 =?us-ascii?Q?S6cOwCCsABbaEQT9mY7HwOJnEouzLOn4yHcuxakzA+f6zqVv3stnmQhlHRRb?=
 =?us-ascii?Q?VgDQ6YenqqpkBUq7NL7WgHfZJKpGBqxa6u3bzZnQnS7aYg4IlrSXXTyfCwF7?=
 =?us-ascii?Q?aXG2VlSDmJgrI7PKSG9w7lqTFPARnQ9yT/Uzebyz57Ah+3rCIELIaKT3oCK+?=
 =?us-ascii?Q?mEjw9s2z3J2UM8RgoSzrFFUWrXj75Sbn7I3xphAGIqKVWwkAkiYk/2baKNEG?=
 =?us-ascii?Q?vEkm32vd7ivE235i6VmUKwV4ck5aclOYRnfx1rKONAQ8vVNGn+fIfuQRYNRg?=
 =?us-ascii?Q?WttHac4/MnWDpEfMtvIZw2EIynqo0PnHP5La3b6sum+nkQwOQxVIF0fO8yFC?=
 =?us-ascii?Q?WRdWk7qet4/pkH7h6VEdwcOcsuL1ubkhkHze57xpL5bWY2IgEH7y29rIys3q?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026ceee6-2793-451c-75ba-08db889511c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 20:16:43.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maPMohL77iYGplLy/jWXOtJJHP7FHs6BLuM9YJmElOO/xWGS92AoDthwxngjmFYGl09fNKPYk85BZ6Ptf1hseHA1zIL9xn+8ZDpLn+R+0oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5569
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 12:32:59PM -0700, Kuniyuki Iwashima wrote:
> From: Yuanjun Gong <ruc_gongyuanjun@163.com>
> Date: Mon, 17 Jul 2023 22:45:32 +0800
> > in be_lancer_xmit_workarounds, it should go to label 'err' if
> > an unexpected value is returned by pskb_trim.
> >
> 
> Fixes tag needed here.

Further to that, assuming this is a fix, then the patch should also be
targeted at the net tree, as opposed to the net-next tree.

	Subject: [PATCH net v2] ...

And the prefix should probably be 'be2net:'

	Subject: [PATCH net v2] be2net: ...

...

