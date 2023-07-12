Return-Path: <netdev+bounces-17127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C4750704
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E029728163C
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D9227721;
	Wed, 12 Jul 2023 11:50:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCBA27713
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 11:50:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::70b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DEF2103
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 04:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipkhZMhUSYtzMQ0qNjq5XWDpPAz6D+ZiyeDJdEUNWY4fIIwo75flrRESSMFDcsBCb1EabtozdbZZjLQdatLt6uA5Rras9xLPBL1puXJ93dKNcHWztB77rI9zCe3kwsB+MBkkshUyiURmwNgaFIIGaY9mD5U/UGGzEud67zP962Y5YPgl3KtvEflakMFZBBglRUqdZZq16Nh6Hqh5OISHkIhGoUq5NPBvkP0Z5F7Bdn1W4GK0m3DzmGw0Ijt3nxgBdUt3I7WdG9RS8JecXWhUOZt8hluKR3NmtbuOAqfTx4y4UuH6qeZ8N6OlsVYzw+ZO5GO7dU7SHxZ5qku0VpZ3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aomNNkuFc/gpR0luy1xwp7MLz0NvJn+VQUN9PbO0ZZI=;
 b=fsaTkETp0/E9FYHc5IReh9mmwt/YzbXdopr8xSrbebCGzCHIHO40nXd7RsKeso7p4nkrf0edWtncXeEtMGDknUMEHgpPgGhMRmpxOQBdN5KEfpwvtSmxUERHWdQW1W2UTT73I7VcHHU0OEaUj6b7YKA+1YMuK9UQu2JDAlF7RgpQI+K2Wi8CagJZgn6XP7WADAA80+zr/IZ7W+0q9mJYDpZBBILRXBDuhhGK5YQ2MzBtAAYg3CPi8wUlk5nJk2JbHfSpyRfBGrpMAMdD2h/b/S/mdpXJ9UluwdDwFs4Dlr3X0+jyQhPliKWdAzFBalPFA5vugkMI8uTEDkeZ/jWOAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aomNNkuFc/gpR0luy1xwp7MLz0NvJn+VQUN9PbO0ZZI=;
 b=f1UMHmH/SxSZQ7iFwRnbP7nY5aK5zPdaNPfM2M1heHV5a0e8VztgmiyGS/7VbGq5QSrOTmsop9aY7BhkDaZrktf4Cs216fV+JUqNwfHErE7QF6oU49xgzbzCamf04tOhQBXLxZ3cCKhG0GN7lCotlaCL+BtRtK0d0gXrx2FjocQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB4072.namprd13.prod.outlook.com (2603:10b6:208:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 11:49:07 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 11:49:07 +0000
Date: Wed, 12 Jul 2023 12:48:59 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2 net] net/sched: make psched_mtu() RTNL-less safe
Message-ID: <ZK6TK8/sSftMtRdb@corigine.com>
References: <20230711021634.561598-1-pctammela@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711021634.561598-1-pctammela@mojatatu.com>
X-ClientProxiedBy: LO4P123CA0354.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b1f59b-79ca-4f8b-85fb-08db82cdffc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dGXMBWKDaSlko0h/QnG3UQNhbh7lgYGqUL87Xdvz1WpadJh5rVqXDqPrEicg/eX1ux3suyT5ci/3xHMxxpgmfqAdkfF5umuJSkzdr3F167UwazhT57F4FB3+auyGRA6UbLMnAB4PRX4RnJJ1XHAGoOXp3dM46xlUWe0cZSKTl7vja3KLqAXGle9CiGhZ3Ot+DkQ3ZK3bpp/34Yx6uTVQjTxB2UgSHIGp5Pth4MHNyI6mgXdphtop0+ttqeEMwiagJ+aAUTsJEj1sxXROyX4SofrY5IpCuXbVDvYiztkNFkmb8XbD7DJQIIyQj7+fN1TCHHAqJ1gyILnHVRNgCXSzDmTEM4YV71z7gTYyjf+wAY9x2ituK16SSVbvqWxQQpB1aKCPHzA6DvNzed79y3y1W/upC7tDLTiAjlmzAw8RfNfjm52D8olJzz99YoPTBTRQmJHM7N0C5sAL1b6T5y8LxJko2WpaiN1LYQERQlCk5NsYXZBwavmzm7iFIgqjxP1tfx0ERa3gjjHSEivt2OXh1r2qSNxj/u0+Uz30QMn04GQMWOqEQaJ5QWzfbKgwcVOxOzbXGChNHcE5aVJqtbAWu2k6SkzphPGtLkv/eJ4Xbn8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39840400004)(136003)(451199021)(8676002)(8936002)(5660300002)(478600001)(41300700001)(4326008)(6512007)(966005)(316002)(6916009)(6486002)(44832011)(26005)(6506007)(186003)(66946007)(6666004)(66476007)(66556008)(2906002)(2616005)(4744005)(83380400001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G2L4TChoWPm6zM7K7o0PvcMpNVtQ8z3H8xR4uOmOGJ2seNqJimolTrhpMMr1?=
 =?us-ascii?Q?oA1ikwSYsdZlVVwYLmwQRvG0bn4EIdfkPZpbB4hMPb4Su+pyQhtyApxqdtdO?=
 =?us-ascii?Q?vJ7Cr1vG56RYlvrgUZJVGABrboEDYdTdYQrOTUQvbhE1lV9FJVQWUGHr489M?=
 =?us-ascii?Q?WGawrIG3BH88ct4gbcqrfMALuZ37s8Q2Dwczgaudnof2QVoBHBe0wYU4gFwE?=
 =?us-ascii?Q?NapmuD83N8jPD9ecKm0cRfk6WYCEvTc1QvfBYlhF6rJ6sEuewewoXRBd00k0?=
 =?us-ascii?Q?2K94QfzYW64Uqzc2wjNfhkyzpOoeKnMXh8YTYoVyegqa9wekmGILcmsPwR/t?=
 =?us-ascii?Q?Ztcipjdx4DQVVWoBXMf4Dq/BmZAm7ku6Ga0hL/bAcnKe6C8F1hAzF1FrBmMI?=
 =?us-ascii?Q?xn8fuAGCZwlyuhH4QEOvBbSbUPZWtlx7r++/MiJp9seLniyIXzYbUlDBriXY?=
 =?us-ascii?Q?xKIxcPkDrXsMrd0pp6PIXIVXKzHlNB864unyCh2RQ+csI5FyeojCgI7nFLx2?=
 =?us-ascii?Q?B1WRa9nl/8oHmlaKAY0YN2zlRpgiF7fHB3aJ0t1NpdbG/+Tgv4PKxy7FTw2K?=
 =?us-ascii?Q?HfSzYWs1gPg7d6/4Q0KDfD+RK+vxi9yx/fs6YWkrJ7pO4JBEOVJNWXKhrCiD?=
 =?us-ascii?Q?z9nIUcKAXG4wwpA0SQ/AHFJ/BLm8Fy62FYakpHcMPKlnPHH3zv0ATh3XUY0D?=
 =?us-ascii?Q?KvZgJG6Hc+yHsJorYASVqleM7QtOr0nLFDsAZhGWIykNNfedtQmmSXBLO/YH?=
 =?us-ascii?Q?ZMWrERPrIITMIlF6Xa+yb9B3h/b4nOgxcPx50R+fdUZ1WIiMX/pH88ZEEyKq?=
 =?us-ascii?Q?y745pqUXEcmJA6pxldZ/UkoK6i2nxZ3pjMPYx7e6ySOqKY8V5rE6k8QNKszw?=
 =?us-ascii?Q?p8ond2mwT/JQjpn87Ssm4wUfFRjv1ZO/qAdL4yn/KK2HbqwMfQv5+gD/4in8?=
 =?us-ascii?Q?Tgf5vIkdNiqTJNoQLzCCMB3CyH4qWTpKzh8wC4zG7fYK0V0ik+WBSaI4EVBp?=
 =?us-ascii?Q?uO57VAp+ei0T8JM2Gep+HX2D+/7AixIUitwtWOg3QE51shf0SmgvDd070SWn?=
 =?us-ascii?Q?nCH0GAEJNVjz2vro2ovrMfOgcEYtKN/KQ5HWvyAXN54Xz5ouQaMunfaEzanJ?=
 =?us-ascii?Q?rY7YBxaePW9bqrtoS7858fjcFLCw2SMoPo1jIRZCq9qXKRIUJ31biBRjxW7t?=
 =?us-ascii?Q?+tp4yNrdR4MJCXNGz8fMXlkDuqcpLkrswI3lfzS2Cpj39nMN95l087D+1fEa?=
 =?us-ascii?Q?p1ch5+sq912wv76PEEPQbR1n6krKul7gya1i0h1I1MW44BxhJ+jLOMPOpCNl?=
 =?us-ascii?Q?oUnzGX+d69pONwRkVgDLwWKLLggRMNo/29HoEDkLDZPv5tledjiV/03y9iPs?=
 =?us-ascii?Q?Qgwf6uKCgQRs7e2eV7727MkXkuppC1LlLKHtflCanMZcCTRnxW5r33RFJCBX?=
 =?us-ascii?Q?znqBXHD8INjcILZzumplFoxZ3G9U/pJFd4GrYRc+WOPCPCEI8AuyN012Q/aV?=
 =?us-ascii?Q?PznbtQ/Y6CMHyREA4zm4uxnxB6WR1sL35mV14+bJiTpLXalxqZZAistxy+9E?=
 =?us-ascii?Q?Dn7wAy7GvO2+s9sTgot4dwtXgr/hwY685wU5JnQmfuowqqn6ltngzOsjeUqT?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b1f59b-79ca-4f8b-85fb-08db82cdffc8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 11:49:07.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9nuvJA1DB1yIzX7klWEGtXU/w0E1bli6HAA1z9P673EcsaqRvTZqyMn2X06Lw16iDMOhx9T1v76YjXdv4a3ldh52cBAzOKO4VQBSFmoRJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4072
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 11:16:34PM -0300, Pedro Tammela wrote:
> Eric Dumazet says[1]:
> -------
> Speaking of psched_mtu(), I see that net/sched/sch_pie.c is using it
> without holding RTNL, so dev->mtu can be changed underneath.
> KCSAN could issue a warning.
> -------
> 
> Annotate dev->mtu with READ_ONCE() so KCSAN don't issue a warning.
> 
> [1] https://lore.kernel.org/all/CANn89iJoJO5VtaJ-2=_d2aOQhb0Xw8iBT_Cxqp2HyuS-zj6azw@mail.gmail.com/
> 
> v1 -> v2: Fix commit message
> 
> Fixes: d4b36210c2e6 ("net: pkt_sched: PIE AQM scheme")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


