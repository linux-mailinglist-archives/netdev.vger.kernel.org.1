Return-Path: <netdev+bounces-17496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65916751D01
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF601C21286
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10F8F9F6;
	Thu, 13 Jul 2023 09:17:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA52FBE1
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:17:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2108.outbound.protection.outlook.com [40.107.244.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F451FC0
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:17:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzaOO9LiXG51/e4/h84apGWw8r8GP1xUeQfVNGclOEqNVmhAgXJRLrlWgZw4rwJ5gMCFumEf7lAebXJy0ayHwW/kSFmOe6PmCGPMuug0sxSq0OJ6FQ7fjowfScfZb9U0bpWgsWLwyJP97cmqfOukr4uAYrNUTKQ00DLohd78eqhkdFHTjpANT7MpBDzPR6YDoaveDndIgrGWr3U7wqsrGQn5oKtKLhjblHmSbNPURWnJWUsO4WZaePwwAm48tVozzMDGI9SQEaxXjX2mI5tNoSUJ78ai8fQtrr7p8K/Nm8Be1OtP48Xw2At7MbT7xG9shgz5U5cHRJzCl99picQ11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNfAT4hb1yQxTSU+9oz3xg6LXngrYuPqRSw/nx8JJ+s=;
 b=oSh5bnQIHfEf3fNU3YZ+dVI+YIsuiEwicTqvQRuFv+ReJFN/DcKJlyXwt2qKJTUOWEQVPXf3T0Mv+6R2wysVQaibjI9WZQFFATCZCO8DzwHAWwkNaMmunt6W1SXo0yiJRrQjoUxNoHBdzNkaU78QmCgdbQjbWbkc5doMnaAiBcKuuw0PB4Fvf74PjFcBeRGTPSxj8IQFBiIh//EVlYxTCL4l61FncTQTl+iiyHF0pzmM2UuQ2XfY4cGsviTpTQznNfQEMewIsHqta196J9My5lJKeIOUJ+9cdGNCVVn2pr9iw/TfsVuhNHo590OIxcxU9EBFdgpm4OFLvq3vpLErug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNfAT4hb1yQxTSU+9oz3xg6LXngrYuPqRSw/nx8JJ+s=;
 b=L3jj6MRgPzEWpPegV+KkQobOh19dD/uF0yJ5K2GNPRcpATlZabXrAN2pGRXvzL+8vfN3+GWNWcgAHqLhOaps03ToYRZe+bjv47fjpsn/pI77l+bWftOgpMFx8v6ila3+V24zKYb8sp0oyUUAZhTUxoxQy1chHUMMC0jQHqZoboc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA3PR13MB6323.namprd13.prod.outlook.com (2603:10b6:806:39f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 09:17:29 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:17:29 +0000
Date: Thu, 13 Jul 2023 10:17:22 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
	kernel@mojatatu.com
Subject: Re: [PATCH net-next v4 2/5] net: sched: cls_u32: Undo
 tcf_bind_filter if u32_replace_hw_knode fails
Message-ID: <ZK/BIjWlu5qh+CR4@corigine.com>
References: <20230712211313.545268-1-victor@mojatatu.com>
 <20230712211313.545268-3-victor@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712211313.545268-3-victor@mojatatu.com>
X-ClientProxiedBy: LO3P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::14) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA3PR13MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c756ac5-7c24-4ab5-4b38-08db8381fb2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qlFP3BJYyeaR7aSXgsZx5a+oUDVGNOhkh0KdqOPZNjim/eVpvFVGtoeOdz1QZTslwwTahd5eseTPPQYLiQNTmtQMMAy3j7bZ2AOnY5Mo3BngPdpF5ozVzkfIsFL9oHShQGE9/NeAHmwlgafc62yqSI+IPWCh6sL9qR1v+geuprGV1rq+SszS8SYHGAp+Dc/ArwKappzj25ie/3961QgBpmG5sMSVNsGoIZyJc8FbRSmGEl502UMukidtdvCowtIfjkD4gI5RkrQrYj5gll+pc1xO4COCUaNIW1Xcs8fFt1Axd4e/VhnyF57uFzCT/AldPrxTF8cDgj0Ev1rs9u9z7lMkBusuzBdrUv9y2PaMWTdss/8VoSIJnw+Bwb3RVIkMVFYjiJoTrpHZKJtGiSbn0b3kaFvv8lv5QDvCXzLpgLyvp/KlguMx+EFHM3+Ewkaqn+XSccTkfrkLxiPbEVZXDh/2y53ioNAnQBrlKqPQdcW8wof1Io08wPxARUHiKO0gBFps43XZuIx69ucmHphhVZ7iWm7coW6rgoa3DR711v6N2QIqEembGdBCSPlxwMf9H2VattHgSLdHNNjq1dI5OOBNg4e7JJIZh9nzkteSglw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39840400004)(396003)(451199021)(478600001)(6666004)(6486002)(6506007)(186003)(26005)(6512007)(2906002)(41300700001)(66946007)(66476007)(66556008)(6916009)(316002)(5660300002)(8936002)(44832011)(7416002)(4326008)(38100700002)(8676002)(4744005)(86362001)(36756003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YvK8VWNC5Dn0QxbfRQR1tXqkEk8wruvkP+uSvDbJ9FqzEH/0u2SHhEkx3Dvk?=
 =?us-ascii?Q?LEYGZfm/4hIxsz97jITUUmbZuWTpHcJj0XvvffIhRxcZLzcin5saNMxuJiRj?=
 =?us-ascii?Q?FzcDFHxh01FHbC2/nqTcc1Vgeb2ziCg9mZXM8gUo5aMZo7LwTbNsh+WnAB19?=
 =?us-ascii?Q?dl54NgfIOsr7Bvw7eKycffI1LUUxloMBZ8AnNbTE5a5sw5KgNlLLC0Pyflzn?=
 =?us-ascii?Q?GwD6u9UXVudVyTwaKwQQrAzVm/vRqyyMWzqQKuLPlJvOAdK2/te2ikwGwt63?=
 =?us-ascii?Q?OozA/Iy8PyHdiai2ujKKd4UBo7Rjo9KRQyGA4qS0tItapkCUx5/djtN9Rlgq?=
 =?us-ascii?Q?mzRzqPSWOpBoCz2GeS5idUuvOduNpHSb0+/w729y5pLMcJ1xjVdNbrAOWPdv?=
 =?us-ascii?Q?ewaVGIQn5Ghd/bR5euYi5PrIPGjMaZjVIaekuXVFkjbAfrF+LrdiLB5Ue44x?=
 =?us-ascii?Q?TOlsEnmkZidjUlR/BNANgbfSiUfuqr4er9EuTfPdAKRZqS9JVzwILI6wFNAE?=
 =?us-ascii?Q?WrmovKWGUvEh5oBZQhd5M3qDFTRr+mNZJxvF+AZtwz5De1uv2utdNWdPQD1A?=
 =?us-ascii?Q?nUiAFfhr6Y63o8pGjYKrSN6JyBPsrZXR9w+/3I1wbL6wk/0G2eW53GQwN7FO?=
 =?us-ascii?Q?XDmEVMHF3M0XaJQEdwNbnd064Mw5l/auTw1MBDVd1kWHEFNVLgg7c36JFpRh?=
 =?us-ascii?Q?JWXRkEXIZh++GX7M0GY2RYfp9qooWCq4GJT6Ai4Z9NjrOeQn29q48YzuumkY?=
 =?us-ascii?Q?AgwSVQ764lWckChA1oy3fEAFwqp8578Os7ROpX7xtr/PZ3sxDGdiNK5GmamQ?=
 =?us-ascii?Q?jhY17FWiFvvGsijGOjuCbyp2MIujRB0cNnLfnuDEsQsfCvuu4Oq5pbcDTz61?=
 =?us-ascii?Q?VZ5kpl0Kw7SPJrHQka7o5vS7XHtzbKKRom2AUbQEBvPYrPqjJz3LOcl5Mfx/?=
 =?us-ascii?Q?QT8fKSrSWwLZ2VujUUOpQcl3/ON03zgMR6SUreXCU36gVWYQi58JNZQKWOOD?=
 =?us-ascii?Q?k8Ser7FX/ePphSS8yGYivsvcc+WyHE5LbS9H7Sr1H/ATOe68K0JZv6Vo+pED?=
 =?us-ascii?Q?OMfFgNd7DGDtBKmjfjDWENa+bH33Jz1nImiZ0MfkztX2/N1zsi9uOszWbDte?=
 =?us-ascii?Q?FzCEzkDWAt3Rmry9e4juUarItfcU1MFyq9ZUMN2SqUXysVS8YVSHYPLBh3w2?=
 =?us-ascii?Q?J5oktgK37Dat+ec3/2cpVUb9O+STsJVD+y7+89qaYzsutYGzDiZj0RrDi0Rd?=
 =?us-ascii?Q?oXSYFs6bChKJIkPSM1fCTY2PjZ8BCvtrX9sF2oy8vSWNo9+Kf3wZW3aCRgDm?=
 =?us-ascii?Q?eHmUQJL2SiihjvTpgFSUKqSIRZjfUuCJTafvakND8/oUbFbHeodJ28IUZknd?=
 =?us-ascii?Q?pn1p4Kxp3nWLYtoYCPjj5LljQCOGTzOdYxEzUyMgUu71I+Rs78CKde6d5L3o?=
 =?us-ascii?Q?TjJSasHIBPEI8g/oBn26P9UUv2TUpZGRI1/Eyfl8BVMl2tU6NWYt5lNTXzw+?=
 =?us-ascii?Q?/HDbaO04VlhmkpPrs1ILN+oAwaJNeRcVqL1l7cZybnd+g8BDuRXH1b8OC3qW?=
 =?us-ascii?Q?PVfMXr/pL8ImkQXG3ykEo719NTTaZODsrsp/QBwhtEGjdlSqXxkAbFO9xTOR?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c756ac5-7c24-4ab5-4b38-08db8381fb2a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:17:29.2393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbdumsDyf1/b/jWd4mP0blQRfs2mjWhoNPzG17TLhnQnZhg87rI6j9gsbuhUHNVaRdbgqMEP57rnA3vBsU0azZBGjK2LjiDzvah+EzFAL7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6323
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 06:13:10PM -0300, Victor Nogueira wrote:
> When u32_replace_hw_knode fails, we need to undo the tcf_bind_filter
> operation done at u32_set_parms.
> 
> Fixes: d34e3e181395 ("net: cls_u32: Add support for skip-sw flag to tc u32 classifier.")
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


