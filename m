Return-Path: <netdev+bounces-67529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E969A843E41
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 12:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBF928D8FF
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 11:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77626745C6;
	Wed, 31 Jan 2024 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="tR0Mm2xk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2124.outbound.protection.outlook.com [40.107.94.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8BF67A16
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700329; cv=fail; b=Zvx9Oj6NpyXAK58SL+t0VYBdG/Cwz87zspjgXupvK97X71evBTSr9PbT1ESSh+4Pg3SC0Rc66m9mTKh6LPJKHqAZFNEY+aEkq6jKSG+uzTX6mDkgUSgDUSbrS7a1SjKSnYqvMbOxydXR7O0zmHwmhWsWqBa/fNPpxERVi86/0Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700329; c=relaxed/simple;
	bh=4MtyB8eYXYXsRsy/EDldzSRZmqCAKUyIArf9rMLJXXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t4JjY7FSQTuqNnI/x7lJ+Oet93cYmI8V6PvgHy7gdvJZibpx+Lr9JjcjBFem7o+SXKn9Pmp/N4ZbRGB5FgN3uNbi8RRIttEbVHtTFiDRO0SAYXs2OqDK7ypATJAGb7GyJFY6AM0NLoDD5ohgg7Ri2VLGbkS3rL/HXBUGhtEEcHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=tR0Mm2xk; arc=fail smtp.client-ip=40.107.94.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7JjBkVh3mHM1tPCmYN4/7uZ3MiFm1DsmUVI4AoNXs7lJpBnE4kdW7CTMDBQ8upovLGYlaqlELM1GwJp025fXiP+sC1mLHO1Dobauz6oeE7ngGcN20dd/hwaobMddCkqiqLQRS5yKTh1LWpnt5r0KFa3svxsG19nc71bNwDXydlwYgK/TRIE0SD+C+jDaBjWaHHcsmBP5CX6tcdzS2xZGoi4fz0RdcSCanCj5OpQmF94Q7dIbzxoZSJvprm1SBIuDdx8SK9yFYgaYZmivgOi3mnhBLrgQdXN16hclRrAnbjc7bRdG+zq3adv0MEDnZFhVxyoGJpq9MQx0XUXpVIdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm21jemuuxc7wn7SXYEoUBBdIAWNsi1Z4vVqaEgDPJ8=;
 b=BbbEInVlu0DGNKr3r1NJEGDbMdIhdbbWp7Qt6/aOm0zJWnqye7Zqz29VoWFaLjb7LkNgeMuYwtG7eac73BYpIBYme1N6zo1BclTZbXlqwiTZCnYLhm7VR6yvh6QunJdm0tjdRCDIG41e12UOGcTct95EdTM+b1eZuL5IdpkOR5VUICAZUTPEcGO1434X/ExF08wn6cpcWVS0LqPAhpDDzmNaXxrHHVilHi55dew8/xb2fvKAo9pNTGq5+8RSCcAI1fhix0TgpE5UlvDPIh5LsBgEEotDSbhLPvq9QoHn0QZ7FVyDmlW1u20YoNWyEB8CjWItRcUoWHsOUG6myg9S9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm21jemuuxc7wn7SXYEoUBBdIAWNsi1Z4vVqaEgDPJ8=;
 b=tR0Mm2xkmVBU3flkobdCi3QPPzXb7wi1T+FssscLxAy0pAcH1XXpB+DyR66NB0NelnPV/S5vdYZ2ZUvkF86zCxJ9Pxjs4dtpv2YDJKWoMTP7SqM+GnyCqocQLValShx1bTox7YGUARM+Hx5L8VVxFIiQ6glZcDgpdFBbcLWQh2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by CO6PR13MB5274.namprd13.prod.outlook.com (2603:10b6:303:145::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 11:25:25 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::a58c:f93f:a7fc:c3bd]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::a58c:f93f:a7fc:c3bd%7]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 11:25:24 +0000
Date: Wed, 31 Jan 2024 13:25:14 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next 2/2] nfp: customize the dim profiles
Message-ID: <ZbouGqJ2C6gKbiaS@LouisNoVo>
References: <20240131085426.45374-1-louis.peens@corigine.com>
 <20240131085426.45374-3-louis.peens@corigine.com>
 <ZboVNWrlgucuxH9N@nanopsycho>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZboVNWrlgucuxH9N@nanopsycho>
X-ClientProxiedBy: JNAP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::23)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|CO6PR13MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: c4dd5143-6f81-4503-8321-08dc224f5165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YnwGDVTwf4yyK2tyzt4/LyxM6ckaSBv5M4OzpHdrP6sc2SmL8uyA7ojuBPlaVX+5ssSLbKCnzF4t55AC3XHBJrx/ZX04oKYx1RADbKTLdKcuc7SKbfXN+zNFjXnZo1DrHJB677+nOGmoMrOrM7MaZG/Ei7cIq0wxLLmaaWS3PMpUhNCyW8mivXYhDnffItzkNWk4zIC6xOJSoPjKokLipVsgTnrAX8lOHFvw6XumYyn7JbYquryzf2xcaeVXXKylri6zI80+nQj03H0zVHA3Iu8xMq0U+1TzT73Zg//I3XmGpMTRTdA+dDPWF+aUHDyoWxL/G7rOeOO+qeGbQjjsUiY+hLzYIkRySpF61KjVB48kblUzbm1RNQ1LkBd+DtVPSpE9IiYW653HuXFhEZZhFjZXEIMA2XxOVzgWy0B8Enw2vyEcB1qHWCzfG0qK0aZcZpOCabdyverMyVPml1O3eKunTM3yMK0mVTvZtNIjM/NmT3tk+ewHEBqRIxJAiLWGBv5/XqCMBVdDiSiBGMGT9Bd9xlaqGoxqF+7bPG0amonJNDfhc6kgUKJo4GA3aXKqadi3lLFimkADv5Pbh7juvrWXgj0aMNOXLfv/gMfT281+GiPRNddVv+lDu4caVQTr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(136003)(376002)(396003)(39840400004)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(451199024)(64100799003)(6486002)(5660300002)(26005)(66556008)(66476007)(66946007)(478600001)(83380400001)(2906002)(966005)(6506007)(4326008)(6666004)(316002)(6916009)(8676002)(8936002)(54906003)(44832011)(9686003)(6512007)(107886003)(38100700002)(86362001)(33716001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qzXVH0xs+2AJkI8BQoLoZ/AI/1BJ5bLQKJ1PLP2lI0PXK8ZABm90gjCbhoHO?=
 =?us-ascii?Q?15V1oACbXfaWI/LFYTF4QKCuCGrH85Tq6zWv57uKX5S58lM5P0bylPsXQx6O?=
 =?us-ascii?Q?d0oevPkTdUH5b7XTLhS7bZHL6D/O1NjxV0LvJT0Nhxqd2cawuDIcVhoK8iPH?=
 =?us-ascii?Q?dtvB9DO/1yVr+p5N6ZF7sdU25wYBeb6DaDN9YsGFb4o3D67zk6wuIfWin0/E?=
 =?us-ascii?Q?vWg5OdobERjirA+3ZPxO2JXMxkWiANfgvroGtlKtue6GOAdIX7NBnljTyqlW?=
 =?us-ascii?Q?gxiXyFzph5PI1lDKeZG/EhN/mcSs10yhC4mEuHGvGDXY3mxwgNT5YxR2RFKG?=
 =?us-ascii?Q?9YaZj5KeZYNhoONFQeSHMSGYgUCCufAGNzAuPiRnoPHIDMMFaTJ4uaHEvFyx?=
 =?us-ascii?Q?0ECWK14nE1N57Syf00aiPJKdOGeKIKSbJ1be47DWhv90Iu8B/zF/nuUTQdbh?=
 =?us-ascii?Q?IxOH1GERdV1k4LhBZ3MqD6ihMn6w2l5V9ZdeM/ZND/00jLPq/tL0sJ6K0YDH?=
 =?us-ascii?Q?D+nwRkelrOv5kXoVce9oRtzv4trFTOJ5Of0nYrLOMEx8HzY5JnxyjdMiRsjF?=
 =?us-ascii?Q?v4fomr6GSuY/7k57oTFtms8Hqd+gU6+p2gE6subgVmq84VI/ODIYbO9ZsfZR?=
 =?us-ascii?Q?WJ0XnFtU/CEb6cObop1RYiYiVji2ni2z+Q4HxhSvaazAou31YGkh29RY9Iru?=
 =?us-ascii?Q?ursu8tGi46kUEsU4+4itffCRl2qE9byWF02d7rCgdCubSgy3FIWPclZvIGnT?=
 =?us-ascii?Q?5vhJZItNEJOIHlQZmQ6fMMMpblzRmWVRfFxKvwPvCakQIGiqKg9OX+del1I4?=
 =?us-ascii?Q?P2EgePsfXK97iaQgVLOqly3Qk4LH6ksAEL5Lal9VrLOvIxDs28Qi7cIvdOD9?=
 =?us-ascii?Q?ZlF7q0TGgRDFdFCkQBG7Hi3CEtEHmPACOs1I0LDt7XdCjnHBHE1oqOjNUqgo?=
 =?us-ascii?Q?8pybVVMaHbAJK45avesm4f1foXy5vkAKXPupV5S4rH/7Jd4bAtPu6MVzqGA3?=
 =?us-ascii?Q?D6kLKlfFHkcio2XZDe8hD4NFUkK+6vnHY27f6v/ztNf0IC4sA+bCVTsI410P?=
 =?us-ascii?Q?t+LQBMCd2ewtHNgHanwiAYDggZctge+NnJl/sMDxet+GB+XFvUJIxW0g8jny?=
 =?us-ascii?Q?hk8rVYGtwajAB2tIlbDpOtp1GWqdwrFJjYSoj5YoX+EJOGM92IqTvk5MPemg?=
 =?us-ascii?Q?IvCLVYqpkZQqDX1QgKLAcu/6ygJ9xebphOaP9FKQhXu0My4DdBVdV76wpDRt?=
 =?us-ascii?Q?9sBtHCdPOTs4//+5TyNq+e4nLFz57KnUto/8Y///x+gEcQ8uZDiT9O4rTc2G?=
 =?us-ascii?Q?SGAEEh1+9mir9vfHdW0iheg/sAn6b/k3A38ct0Uumo7x+BGDQ3nlgR64fgR0?=
 =?us-ascii?Q?IhDa+GjHP0gdiRnc0vUsoL0rbtXvIcvQPg0cLlVvmbMqsIX8gaecE7kKkk2L?=
 =?us-ascii?Q?tZScm71C9SrVRQCHuJiEIhd9oABU9abb1xSbpIhZFPhwfLN1zTqk6UqtnOmB?=
 =?us-ascii?Q?mXmSALAGZtBMhat9k/dnFqMB4PNLwCrYygTDEDKqHY7QoKRpa8jqUxfG6vik?=
 =?us-ascii?Q?rzn9wm0IKfGj+2S0pTffKw03MM6n+y0mog4thglWfzqvqI00+cF/aZ2bmxA8?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dd5143-6f81-4503-8321-08dc224f5165
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 11:25:24.4579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTiCoBGlUM2tTuN40gm235SJN0YFaO8hdoagd2ziIt8Q8i6RBT0unYLXypOtjWXMPKvSLcE6e5v/7kkSNUTjxSM4PUCd/Sfh6kJiHDk1hI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB5274

On Wed, Jan 31, 2024 at 10:39:01AM +0100, Jiri Pirko wrote:
> [Some people who received this message don't often get email from jiri@resnulli.us. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> > static void nfp_net_rx_dim_work(struct work_struct *work)
> > {
> >+      static const struct nfp_dim rx_profile[] = {
> >+              {.usec = 0, .pkts = 1},
> >+              {.usec = 4, .pkts = 32},
> >+              {.usec = 64, .pkts = 64},
> >+              {.usec = 128, .pkts = 256},
> >+              {.usec = 256, .pkts = 256},
> >+      };
> >       struct nfp_net_r_vector *r_vec;
> >       unsigned int factor, value;
> >-      struct dim_cq_moder moder;
> >+      struct nfp_dim moder;
> >       struct nfp_net *nn;
> >       struct dim *dim;
> >
> >       dim = container_of(work, struct dim, work);
> >-      moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
> >+      moder = rx_profile[dim->profile_ix];
> 
> It looks incorrect to hardcode it like this. There is a reason this is
> abstracted out in lib/dim/net_dim.c to avoid exactly this. Can't you
> perhaps introduce your modified profile there and keep using
> net_dim_get_[tr]x_moderation() helpers?

Hmmm, we'll take a look at this. There might be follow-up questions but
we'll give it a closer look first. Thanks for the feedback.

