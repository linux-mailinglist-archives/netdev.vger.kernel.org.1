Return-Path: <netdev+bounces-28722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C57D780612
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 09:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263FD1C21597
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 07:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4657F14A8E;
	Fri, 18 Aug 2023 07:03:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32197A5D
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 07:03:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2127.outbound.protection.outlook.com [40.107.243.127])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE712D7F
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 00:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTdwTDj3NG++XCIJlYwcNKsdmzWyJifIP25I6J1dAOmaUMQvgee0v4YTbKq7IH7xZ52hwlm0trhr2t4kXO83kV42uo/XVCDeYWEV+4Ov/Ir/tuT4DbOEshzrGmFWwkjwgGxTa5S6VIqwb5eZ4m59TpUJyVmZPNhs23Lap5tJcqIHv96rQkO9yutqzTufUjNzL1c4K1G0wLZT1S/6kU6K2FWrT3VF7im/wUb4DT6O6CFpw2ewD8Dy95oRZaJsK+yIXTRA/GuB6Ue9DJKtGv/of226dybVglfI9XBn8t+NoGo2/igjVQmGjQPab0EVn+zY2Wu0CJveVRKqBuBxrG0nnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EH5U9byr6oeiqQ/aHIFrq5c4N2GBmje9d1UdMVt5+2s=;
 b=MERvX3tjtleE4839J33R5XVhg/jHOcqOJEVnWLudDLmKbt1lYemNGsrnbFXThOUcewRfVZW2a+GcCcaNd+F0PN1J9FLzxjCuKSg/tE1meikTf135wVlabKK8MTTyAjsN/uEdXUGvxNCChcOqIljTV6D3eZqXhSwXeWvP7lTxwJub0VsVu1wKY+GEiwA2t3LL6pzLC2K1o26OcrsAvI1shBzqUSTIR7CBoUNdO3eYYPEf+1lQwOXJ5mj9CEo8D1GE3NE9+K49FCpOcdfvV0vJKp+DuLxbaUnr/KD5on1xpCw8lCgkq0Yls4KIpBmZ2BeiZ0kzdh7gaG70DQVwWgYzSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH5U9byr6oeiqQ/aHIFrq5c4N2GBmje9d1UdMVt5+2s=;
 b=EKsPtFoi10aJsSdBDw0vCI52c+bd71+tI5FSZUBVKV2ZNCGSV7jlqqeY1zPz8dlPSv0JBmfIqptnsjcdd9gNaeZpWJG7CyD7mH5Zk/PR/XWLwvBTpYM67POVJUooUT+VrWUwUNsKYbQdsujmo1qqzh7803EZfoQ1dXBDemQ22fU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 LV8PR13MB6552.namprd13.prod.outlook.com (2603:10b6:408:1e7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Fri, 18 Aug 2023 07:03:23 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:03:23 +0000
Date: Fri, 18 Aug 2023 09:03:08 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>, netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net-next v2 00/13] nfp: add support for multi-pf
 configuration
Message-ID: <ZN8XrOgewOYrIqwG@LouisNoVo>
References: <20230816143912.34540-1-louis.peens@corigine.com>
 <20230817192205.599f108b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817192205.599f108b@kernel.org>
X-ClientProxiedBy: JN3P275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::9)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|LV8PR13MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 34678f4d-387b-448a-75c5-08db9fb93661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xa8Zo3JUNNDrwyF8sRZp6yxglMuHn5yvn1+mHB3K4ArGZL4CXHtXMlPwrtnJfRgXLuvD1jW2ALss1c4CtsO7myNz3cvPcppnTkaZao8ytcWVmhEuPReSqmbkTgiPe5m9lRHsgF+fWgq2/Ef/RyMROCbiyCYWYkhO4XRL0Ooo+7idAunMCIuT68rsFIaJY33990PWL9bchTaRUZWzp2Rx6HK8WuUU2g22zmTt8L93lLLFDJiepbOFY1x2El8oeKdumZAFlTvVNjkwKf90OLst07rEPeu6u/5+HWZEt1jkQ7DRezs7Wc6zmv87vd1IWP2esb9bkkCdHbyvhOTLoR4royNBRyE3Pt/msn/FWdnDtE4SJaa+7dEOPGmMzZvS1XqA+JdGpuFSTWwdKxZTRmvZoKwhKckDVFhyZ9REuD614Y12m4Hs7C6+PGzfnol4lVMiyyOcptXOfs/KXJSZsIRrEJFnOkQe46u4CTluOE/SrER4U5BZv3jnYwZXPXk7l95PnFXYBK85GbmWLeh4/Ks0URN64NMaJUWoC3yXqjwyh6yaQpFlvwSLjZ9zxhoHzo3IyYAFbe6cmNt2fx2QNvyMF+BmILDC7/ORhE/Wk/3hLpze/zo2JsOrHitFBKWVr0SnuMvIJduuIOcXwB0BB3LI7sXDdqabvkK9ftC80tX1wFA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(396003)(39840400004)(366004)(186009)(1800799009)(451199024)(54906003)(2906002)(86362001)(316002)(66556008)(6512007)(66476007)(33716001)(66946007)(6666004)(6916009)(9686003)(6486002)(478600001)(38100700002)(6506007)(5660300002)(107886003)(41300700001)(8936002)(4326008)(8676002)(12101799020)(44832011)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?adDj7Y1OE+Vyp5vQzg7Tz+rLNjdNhn0Ys4QK6pkxi1SlSJHMQeGtbW5kGYki?=
 =?us-ascii?Q?LFHnpcwgAwvgNBJnOy7CGLG3xm5cR5J5czzPY6PYspHCZft3ziUrYC1KRsfD?=
 =?us-ascii?Q?wOzl+ueELQsG6QevTsc65onHIkZpKfNPjPRr08M7gLqvgM1Uxs2rLlyM10zI?=
 =?us-ascii?Q?srRGHt6+99MhHT7WNcYtwnnuI4VWVHumEkIo0VjHtsQbbplqtI5haSyD7YQS?=
 =?us-ascii?Q?AoDjmVSjNV81ImyiaLLIbQLWsnUxoO8dkr3dOFoOOUa7Plb3u7dTFz4IiSA0?=
 =?us-ascii?Q?ZJEbrpRUC9xCnQggQXSWBRl7ZEH3uls+9dRJgwUTt9L/P0U+9QxGf/r6KJXr?=
 =?us-ascii?Q?1xA3IIfvIx8MizrU6FwIt6eeNEdiB5IMRCojjjlhxsFyUYAz6dm4QNj59xXi?=
 =?us-ascii?Q?m3Gq/y/c5E2VNf5smR+vxwzeYq64gHuKkRVcp5jp4NA+BzzYTAc3C5LZpwOo?=
 =?us-ascii?Q?6DhXt1NasdEPJ58m973An7Lo73L7+jAQYW/YfA+TZnlqKtQc86E+jOzOSju9?=
 =?us-ascii?Q?x/3GKKG3gPGG6yZ23uxSPt3a4h/B+0TxERvsZy5vNunanbwUmu2XrKqYCXPE?=
 =?us-ascii?Q?zs0r//silnZKza0ilqYnw7GI3TI3/FFIoiT7HjgvvZFUqTDC6jE+Q5B3kK/b?=
 =?us-ascii?Q?Sc/F8z9bccNhD9t4fvlUp0g9fr/uusbkHQ57oSFQ7Fo0ibC/jtkaXoQ8O5VR?=
 =?us-ascii?Q?kC9Tx+12Fwnhd3VAQAw9oYR1JlB63p/NgH5qrzMIHE29fVl2luk+SUjDT+6g?=
 =?us-ascii?Q?YG9L2XMUT/ucBFyh4DhLxuf1zl+6132DqDY98vo9Alb0JBC87onDwoPYW5/8?=
 =?us-ascii?Q?sM/3HywHzvR9lIBStmpVTVhwOybtpF8HAbk6iCWdrPPoDCCYEmqaT2y6aRgY?=
 =?us-ascii?Q?/Yrw7ANlCDt5GNQBRlKUjok2nD9O548nHL3Jw49AVP2yaT20nyNoPBsy3LYx?=
 =?us-ascii?Q?T5A/DqglUHrZjnNZiDx8TzmvcpfWHiPGCsdLeIVJLyCmEvXXFRgxMadZ4OEP?=
 =?us-ascii?Q?GCQgS+3XsijBUTGTYcUc+KUQFeZGAhLG348TjPI8pdFEInZjBKzwf/gwOLYQ?=
 =?us-ascii?Q?zKFoTphAzJ57NingrmciSasCMZpgTOYTFtehzDMhEy1TNUMm0ZFJ/lyIZcZ4?=
 =?us-ascii?Q?U+Ehe0NmaicuEo9PzVf2wUFhmKxwVnmJaZFY6T9ypge/4DkxdH6u0HvMWYCS?=
 =?us-ascii?Q?JRm8MP8H4pQqsp6JpnkoZYx+W7IKXEHC1Vk/9CzYfBeBMFR6KcsrQfPXGOQZ?=
 =?us-ascii?Q?+resjOrzLwTuAsDBimJB4IOsJH4ryhxxhZcyohq4exhoEO9rr7uQS+RxPr0x?=
 =?us-ascii?Q?jw5epqqmS5pOySg3FL9yCuLMwzP1kSJQoB41/bTbgRkkXqvp6beG/rL9r+SL?=
 =?us-ascii?Q?jQyIB8vFl2AbZKbjDntLqBZT2r2V/nxSi0bOofI/ImW6jWJkbPu/Rs1mNGQB?=
 =?us-ascii?Q?A9kATOM5iuAay7bWxjRi+fr+e+L9L50VU5fvSgABagw/8u1n1dM843Jq2S89?=
 =?us-ascii?Q?de0glZn3BRrvkCC7lWgJs1VdTONRhrQKMVnk5MYQOvFL19aXN7vK8HbTYJLl?=
 =?us-ascii?Q?CCOvVEpgdSDNebJc/peBGjt4qQ4+5aSsihwMXMs0K2e7S8MkbJcZ/aV85VPz?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34678f4d-387b-448a-75c5-08db9fb93661
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:03:23.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rubb1Os8MMQxIe3kzA+b/DmQyhLN/ggP4FZbynQCnjrZwCXBoTODEcWJwUqjTG/1tL17szqmugHP1ea+o+C4z136JpJ9yg/kFjStMuUagXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6552
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 07:22:05PM -0700, Jakub Kicinski wrote:
> On Wed, 16 Aug 2023 16:38:59 +0200 Louis Peens wrote:
> > As part of v1 there was also some partially finished discussion about
> > devlink allowing to bind to multiple bus devices. This series creates a
> > devlink instance per PF, and the comment was asking if this should maybe
> > change to be a single instance, since it is still a single device. For
> > the moment we feel that this is a parallel issue to this specific
> > series, as it seems to be already implemented this way in other places,
> > and this series would be matching that.
> > 
> > We are curious about this idea though, as it does seem to make sense if
> > the original devlink idea was that it should have a one-to-one
> > correspondence per ASIC. Not sure where one would start with this
> > though, on first glance it looks like the assumption that devlink is
> > only connected to a single bus device is embedded quite deep. This
> > probably needs commenting/discussion with somebody that has pretty good
> > knowledge of devlink core.
> 
> How do you suggest we move forward? This is a community project after
> all, _someone_ has to start the discussion and then write the code.

This is a good point, it would have been nice if things could just be
wished into existence. I will try to negotiate for some time to be spend
on this from our side, and then raise a new topic for discussion.

