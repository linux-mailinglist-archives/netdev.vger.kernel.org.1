Return-Path: <netdev+bounces-21383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653D5763754
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F90F281DAA
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67811C15A;
	Wed, 26 Jul 2023 13:16:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E6BA43
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:16:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2126.outbound.protection.outlook.com [40.107.96.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0002681
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy4sEi+QckKs8DoLC/rrgS0kgrZfyygdV93z6SsPdclArCgi1/c//i1jlpeCTFCa/77+OhswPukP2vVcwNSODbAAbT62S/CjL09y7SXuVttm9/bvCWQ5Is70/Qjdl6QnecSPU1ZMEjT3051z2h9Axlvi6ekXm5rWh3tFgHyQfMskzAsBKeIx0P6l2VyD3fnR1oEvYRX2AAQ8OKeYB/BIx0wbTyz3AlbIFhZ63pk5sLFqOXIN3Iipvjcz+QA7CyiYGOgCK/C3uo1NH6eC8RVxwpzZqSp/IBRZg0cs9YTef7qbSpHs9F6GXjgvqdjy0080I66hfHVKYA8oUAoRVhpedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pst9sgUcMAPr/I20hlAybH06dNpc17ftsc3cmgBjA9s=;
 b=mEKoHNs2XSbfARt3hXb8gVYnay+NHOd09e+vX6dH6K6+5o9Wdy5RFPLIKfKpPJPscAgftRGH2rY3gtA/mYA/N31JHmF6nj3cFBbsaaGmHewwfGvy+Ch1+EDDvW1SK1TdHz6Zobyu3niwj00V+S517Ksej9vXElYvX8rB3U06UwXqghlOLct5UdABlEVReFEtm5XGZTYYa6VVqj/BU4CwzCJWgCONaG3nGpzcEZhgOOaF5qDkFosxGqKcd+o/cWG/+MvyBev9bE0xSB7ImtOLl4GgVaZQEGOPPd42AWW8JOqxAYCMHcks4MEpGpbtMWQPLU65kCWleXjWVEj7WV64cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pst9sgUcMAPr/I20hlAybH06dNpc17ftsc3cmgBjA9s=;
 b=cKKziS2e1RAW5vozhIfEPTZTsw1v+QLDfmKI9ylQQV9J0hXXLyf1x5SUmOn+PHM2H49Rs5pPpYi5LuWeGR231VFK5G1eadcUn9Hat6XcN8q79UikegJOPLhzCTB2HvXxLvrk5KuDR1ZxNaD4oi/3pWP+PXyMszUgYSnRsDFtG6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB4085.namprd13.prod.outlook.com (2603:10b6:208:268::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 13:16:17 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 13:16:17 +0000
Date: Wed, 26 Jul 2023 15:16:11 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Donald Hunter <donald.hunter@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 0/3] tools/net/ynl: Add support for
 netlink-raw families
Message-ID: <ZMEcm5dIShMa2TQh@corigine.com>
References: <20230725162205.27526-1-donald.hunter@gmail.com>
 <ZMETxe6sXMRvJZ/3@corigine.com>
 <CAAf2ycnL3a2Q5dAk6n26PDdArZbXgL1Tg4dwodS96K523A90gA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAf2ycnL3a2Q5dAk6n26PDdArZbXgL1Tg4dwodS96K523A90gA@mail.gmail.com>
X-ClientProxiedBy: AS4P190CA0048.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::21) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0856d1-29d9-4c46-0c83-08db8dda7ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qUs/LdGdvHlEbhFWWbY3r8PMxl/Jj9M5oeLuLVjRy+pbKfXLFFZolcExEkXBoj1V2UHr4JmVzLqG3lw844a9qCDLM70AUClWEwGVphH9NdYlDz3amKpvMoNCo9fVAiaVNipqGSqZDY3LfpsnMwqDCJ9fTPkig6PZixUALV8OPEoSIcdyCMVy45y0RGZ8GFn8XPhEulwT2Bg8o6ToRtpDZDQlac3/gr77MvCZaOrR9abihZJK+YIK5+e4M04mx92joNQSZ1Bhi7iZzfRwIQupISyPF5wriNG/RHxYx9ZsBHoNJZe2VjJsVcjR/v3tkEceZKYtZz1cQNVu15JspB+vHQr2cYb0K4Q6hEFQnsoDBEo925C8Au4406wSpHsoU/07j/TWMSV9om+xkF61nwNhhFY5AZdvP/rSenCSoYZz61zm4FdR/5kS2WqRg6iEoDOugVMUfjBHsPbMCAkShJNalERz8NAKrsOB8UAX/Moeq4B8LkDgpMaI1320n6L7LMdBvU8uyp8cJs0+nNRbgBNx6jLMyPlUPG4MlNtsri8a7CK1s4uKoHlBNmg21mZoH0RK9+Fu2HnK+ZyGVWCm1H+LYRGOPpSdPdHMj7OpICRYXYo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(376002)(396003)(366004)(136003)(451199021)(6916009)(6486002)(6666004)(66946007)(66556008)(66476007)(6512007)(966005)(44832011)(4326008)(54906003)(38100700002)(36756003)(478600001)(2906002)(83380400001)(41300700001)(2616005)(5660300002)(8676002)(8936002)(6506007)(316002)(186003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w3UsIFCphS3mvzRHWX2oq+lkRsbXdz62ZTYPam75jC8prb/f+/rzTNsecKKa?=
 =?us-ascii?Q?410ITPwoGnqe4mVIgT2Xa0DNYf84131dzDljD1Y/dOEXm3CQGQBgqBwTCVwc?=
 =?us-ascii?Q?Wo+NoB4vMSlx0rjk/9lHm/yzIqxKpBllRTHnIqT6RWgqDqQarHJtbT+R0cXQ?=
 =?us-ascii?Q?OFsPCX+F2WD5ro9fvTb59MClTNe8LMiFmmeY4lxU/37R/nnx6aKdCNwkYrvH?=
 =?us-ascii?Q?casJyRz3X17+krWKutmadIFyt6ci3KsPYbbFeWBL7pF3yHOF9EkRGpZOAdhe?=
 =?us-ascii?Q?F12NdbbYbxwTFOCJoK0StNDIMprcPclf8LfZ44UvySvp4dwDqynR7AlaI+sm?=
 =?us-ascii?Q?GgJw8l0F/m4TXzgO4pDdXC9gxYXUBmsjSHEiaIKcR6G8DoFTKmL3nhGs2huX?=
 =?us-ascii?Q?VaHfa/LQjBf2RaJv2yptbzhK7VZUmRFfYyYeAMivkt8IP32YP1ysBMr8N3YS?=
 =?us-ascii?Q?NbxymkfQWSaS4oc2AE/DIRMNnft3t36ss/SHg5bap2+kGl+sz9L3qeAETiBz?=
 =?us-ascii?Q?XR83MZZVCle3bnLzrnhHKtxdQkToTL4QIe53sfa5aEF7vUCAPJ1Bth7Sm2qr?=
 =?us-ascii?Q?PuvpyySn+dU51afRwem5RJZkBMw7IorAsI0LXSLnAbQsPel18Hglku6MXvHt?=
 =?us-ascii?Q?XuChYtNrrHyIDIzuumBuEy+gKJQrQWZ25aNVseNCUWh2OTgl3NQFo9vFUEcl?=
 =?us-ascii?Q?yNU/3Wjc6HmJXmShLcAVKJGAA+eZxifQ9L/1wB1p6etaOwFIpDe1xuYpeb9L?=
 =?us-ascii?Q?SF42yHfR6dv1Vy0GJWjdqJwW9tK+23N2iR8zxcQQ9yIN9Yh1LvjfKozSWqLc?=
 =?us-ascii?Q?ErZQ7J6rjivI6Fn/KqpBLzRxpgnoudULnPx7LO7HfY536kK19A/lLvJf+9v5?=
 =?us-ascii?Q?cbniwp57FRqo+PotS7ldzB2fph3hBATeFQ8o+2PKvbxUh1XA95/WB0tUQBN4?=
 =?us-ascii?Q?CNEcuS6kzvb22MgheCM1xXqTbB3fX7Ncirl9+9ZciPti1IPOYLpMBVXPt4dc?=
 =?us-ascii?Q?ltPfUU4fhvjnMObWQnlDFAdJC1PErV3tAxu6qNrBhpZqqBGkTavO7eaqOxdl?=
 =?us-ascii?Q?7x262ktEYt6EQ9+2UGV4FiJ71VUC/LQB+O8POYp5K5PS9IXVOH/8ogqW5JHO?=
 =?us-ascii?Q?YxSvHz2V4A6P7N/w9iG352y0Ncc41x7B13Fp0Tu5fumxm5Hotfw9lnMDdwT1?=
 =?us-ascii?Q?RxusWzqj8IXtbrFeMWc0Dkkzh5MmFJkt2v4sK8/dpOuk4gXNAsiqBNXn2HjQ?=
 =?us-ascii?Q?VV90HQHB4gY8ZWvIsFB7y15uJ9Fh9zd7gwG6Ap6P0SSCAALzSYYWwVr93cmd?=
 =?us-ascii?Q?ULOYDQppccLlNnFVGDhA0HZQ1jfOSSEdIgRc1a/GtFCc5Ze6zGO6R5jW4GXT?=
 =?us-ascii?Q?Od2XGcwYPMbrhBt09G9qmAadqm0X9mN0oFG0jorowNgMWmgB5Zoinjx4PZHQ?=
 =?us-ascii?Q?GwYjIcPq/On8lhu+nASy83OuTSKHHYqRNRvT0hdEs5fyZ3uCYTq4iQPDTzx0?=
 =?us-ascii?Q?0VuYVnX9GcOnjCFJ8FrY4ZkCUBE9IWL2jzBFiZKlJO9yDau59RtOv1OVN6Qj?=
 =?us-ascii?Q?we46c+VfVdRXIa0GnHx0R3YJPMjnAUe+QFoNv4n6/1tO8JEHxV8g4zFokdPM?=
 =?us-ascii?Q?Vey9mThQ4AhXerc2pbUcox2WjucDm4M0X8izfaiTI5PXyFS1BZae0h3p/Sdl?=
 =?us-ascii?Q?wo2TVw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0856d1-29d9-4c46-0c83-08db8dda7ec6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 13:16:17.3352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ageE9VqJoMph3qDtlz5tcMwkI59xlr1m2B1WT0MVxwbrCnlY2+nzJBZEdk4ki22+G7nMHa+fW3T6QpZO+zBshwI42V6dgzeyfxnoEm5XM0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4085
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 02:06:02PM +0100, Donald Hunter wrote:
> On Wed, 26 Jul 2023 at 13:38, Simon Horman <simon.horman@corigine.com> wrote:
> >
> > On Tue, Jul 25, 2023 at 05:22:02PM +0100, Donald Hunter wrote:
> > > This patchset adds support for netlink-raw families such as rtnetlink.
> > >
> > > The first patch contains the schema definition.
> > > The second patch extends ynl to support netlink-raw
> > > The third patch adds rtnetlink addr and route message types
> > >
> > > The second patch depends on "tools: ynl-gen: fix parse multi-attr enum
> > > attribute":
> > >
> > > https://patchwork.kernel.org/project/netdevbpf/list/?series=769229
> > >
> > > The netlink-raw schema is very similar to genetlink-legacy and I thought
> > > about making the changes there and symlinking to it. On balance I
> > > thought that might be problematic for accurate schema validation.
> > >
> > > rtnetlink doesn't seem to fit into unified or directional message
> > > enumeration models. It seems like an 'explicit' model would be useful,
> > > to require the schema author to specify the message ids directly. The
> > > patch supports commands and it supports notifications, but it's
> > > currently hard to support both simultaneously from the same netlink-raw
> > > spec. I plan to work on this in a future patchset.
> > >
> > > There is not yet support for notifications because ynl currently doesn't
> > > support defining 'event' properties on a 'do' operation. I plan to work
> > > on this in a future patch.
> > >
> > > The link message types are a work in progress that I plan to submit in a
> > > future patchset. Links contain different nested attributes dependent on
> > > the type of link. Decoding these will need some kind of attr-space
> > > selection based on the value of another attribute in the message.
> > >
> > > Donald Hunter (3):
> > >   doc/netlink: Add a schema for netlink-raw families
> > >   tools/net/ynl: Add support for netlink-raw families
> > >   doc/netlink: Add specs for addr and route rtnetlink message types
> >
> > Hi Donald,
> >
> > unfortunately this series doesn't apply to current net-next.
> > Please consider rebasing and reposting.
> 
> Hi Simon,
> 
> As I mentioned in the cover letter, it depends on:
> "tools: ynl-gen: fix parse multi-attr enum attribute"
> https://patchwork.kernel.org/project/netdevbpf/list/?series=769229
> 
> Should I wait for that and repost?

Sorry my bad. I guess this is fine as-is unless Jakub says otherwise.

-- 
pw-bot: under-review

