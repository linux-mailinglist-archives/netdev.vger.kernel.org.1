Return-Path: <netdev+bounces-59262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44A281A1CF
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7681F23C07
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480123D97C;
	Wed, 20 Dec 2023 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q26LS86n"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087823E474
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ja8ZVRfUFZo9TEIsRLXfB791J9jDrRTbHU4y3tLH2Kg7DGyDLnScLr6btjbVml0exsMR+hMEBAvFB5KIkCbPnz4a15xvYVDB8w+4lA1nXRsbvIDjIKgVtRVHmi7eyY04OEPErhaw/1h4StPuWRZZ2IXdklhxmd4tEfd1C7ckREjKHPaiEK+sAA109TEQ1T3UfFYDU1jr1osQbJ8FH2s/OIxriNwSrcugI0dk+IuqB7ciCpsJEqjm2nCrrHDBqWA8oyTA5+Ks9OuvqGpnv7YEoVM9upsdOJ0aKgHjt+cPYqT7OYlalbd6g8IRi3xNkq3tfElb3e6PduviVNTPGLLPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upJh6cRjiRD4SF6cbc0fY7qquQoYt2tyWmwadakObNU=;
 b=n9Yy4MAUUqa9jLJu2yZvovY7jsvf5ajQQxQKS8YcSoNiY1nZzSYvt557wNYc3fWkT5rhy4mFBJwQ5aT96r1G34hHJYJ2M6Tk0dtxvg3XA4cdK+1vNtFx+IzyqID8G6f8KAARGIH2HRpWgUM27oFpKq2Mq3c/NnRbQ/iK0DIf3gKbsEqQvU8UrwtZtNU1napNYD2CcNDFlOo0C4NSeyFmhS8ci1FyhbkvbMdCQg1mZI5LKoYNFwJMKgelhRhUOwNe83F4lAe1jorkxiKMxgEampX5k5ZjkQEhGBPY+6oY3vt202O5qineZWLO1JO/AOWBgoEQM8IzGivoY4nxLdYbgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upJh6cRjiRD4SF6cbc0fY7qquQoYt2tyWmwadakObNU=;
 b=Q26LS86n0LXdw1KGnFjM/FrrAa41C548im+6pTr/dsSbIaZA8FiaWzKmMWImi+tzWfHvGhxeDhYHuu/d60UKKjhi499CRV5ugVm503F+RRnYkbOzwJbZagh70O6Nr1m4lcR1XT+mtxLMpND+Abc/YHSTFpyJHP5ILIeyIVI8o8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM8PR04MB7203.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 15:07:09 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 15:07:09 +0000
Date: Wed, 20 Dec 2023 17:07:06 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/8] dpaa2-switch: do not clear any
 interrupts automatically
Message-ID: <46qcylil2xr3qfajdurvggvvrg2eakezqlng5sivrwsr3urica@q5m3gopdqqoq>
References: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
 <20231219115933.1480290-6-ioana.ciornei@nxp.com>
 <20231220144822.GJ882741@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220144822.GJ882741@kernel.org>
X-ClientProxiedBy: AS4P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::8) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM8PR04MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d44255c-db37-47c1-951b-08dc016d56a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	daXBNBoWWS6T8/7APAvOBZ//LCBPlG35vnBIrC1ztcmhEGcqLl3KGgUKy3Ul4/F69/nNMnGef8+V6SqlblhcNUdbq/c6JHcTILDZ6J3eXxZZa4fqWZRFtjt5/Iz4qffitX4alPfPalloz1o/ABmsHNkvsnqUByfuzn4X9VmOfieRtzVJNKz0SXb7YUCCMnHfyvKLJrj5Kp9NAkwFkGYcat1CWQ+y2daXn/U6NtsV48EHjGkLAeyet+58/MtEySjMLKj7QS2L2zOt1cWwWICd12MBy4ZRS5kdLcsd8MC8qy3oYLy+3yGXcNy1zvJGFVepHif/rXnYqqaKdJ85rlaGl022JY34sU0qh1UdTEhIO7PQm3ArY20tLTul8dz/+vmzeptKzm+RM0NI7SG6htz1j0AgKco7JcnFtghXWJhp6nIp6i03qefJ4fflShhACFNLzBcL7aV9UmO7GJygRe1zIgIbwOznR57l3jRZ8fmo2ccvSOZj6hbt9018Iih5BILa7Q4tTYRZdsIDg7lAq5zzQ5SH+vZ57Bi4XXcmKtM9btzYKMQlNEpT+EXGYuUlfc7j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6916009)(86362001)(38100700002)(26005)(83380400001)(33716001)(316002)(478600001)(6486002)(41300700001)(66946007)(66476007)(9686003)(6666004)(6506007)(66556008)(6512007)(2906002)(8676002)(8936002)(5660300002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XytcOal9blH67KK2M7Px6e2j8djPhrdTxulFgvKPpOV9jzSsNpDBwNc3vETR?=
 =?us-ascii?Q?irM4g1CAzGY1dHKes1XlTrKN9j3dy9+DhOi13v+1da287nnxwNGRV0+U1SGF?=
 =?us-ascii?Q?FTAmEtyLzJjA3Y7du1UFjMpfuWVFfCSNjZqfmk/JX5fusNoNMCNH//72fKRy?=
 =?us-ascii?Q?ZI2mAHlN3bLPA9WK2WGFz/ttrbiQAuTRkOdoGy2OLHgOemQ50BB7JMe31uyj?=
 =?us-ascii?Q?/r7U2d8VxgciDK3lqvsJW/tomGeyX3WP5uLdgQ+PYHJVN/lp3uTK8/V9AbGu?=
 =?us-ascii?Q?IUClMqjtXeTnRdIwF17E8BJvYmGvjXd9Vh7L/8iLoRW85yn4/6xlYatK0pr5?=
 =?us-ascii?Q?G2+J4EknlJf7ojbP2UwBhmxfOpB+epygBbG7KHk2NH1j4E3FMYh7YxG4+22F?=
 =?us-ascii?Q?cqB4VTAHbIe5PrGRsiCtpjgmITpTsFjb820ujCwGeSf8kPknxQ4GfNQgQy80?=
 =?us-ascii?Q?F/SjNbkmlntExq2VaC11vIP1XO6w6xt9aaxg8eugJAlrFqx40j2yGZd6Kxo2?=
 =?us-ascii?Q?3P9DUP+4XRrotWd8tCCFO61nb/cStbSARLadbf/9FzIG5gifhRRTteyzMGvI?=
 =?us-ascii?Q?Sk7xxhJG65vcAJyfiNd3txfUi9rQ5oVZWzgDg1VuEHzjMTyJM13/tz7lLhBr?=
 =?us-ascii?Q?DUc/t8XiFBbacmPjYwSjOzwgrjxUx3OwWUIHy/KirnEDGnLluSHjkO2BP3Mu?=
 =?us-ascii?Q?b9QJrjAfXeOtWd3seem5APHg9tl+usaphR3VKaCXE4OnqNyXtFzHMnu7on8M?=
 =?us-ascii?Q?jZWge6hSNaWTzdra2d9x8MDgtceey345gUEuToc4TuWVJiCDl4RtshF3/uqS?=
 =?us-ascii?Q?Arvfkc/Oh4+iersRmb1PePpL4QEH6JNcmXzedOEfHpvytJ2vmkKY3mN8uXGS?=
 =?us-ascii?Q?u3WfywtJzOJyPMsDuvOkE34WpFohHQsl8R7sGMRcibEMldh0PKvxBQ3xWyX2?=
 =?us-ascii?Q?pq8ySqPGjRbazjyoRs00YRMAyJAGJhBtjEEJ5/H4LCfm882ghH7pk+J6uyyi?=
 =?us-ascii?Q?O3HFOG9NSLb1RiPw+EupSUnjKFBTREc1Bv9ZrowxM4WF1seY4AOsZD9aGeRJ?=
 =?us-ascii?Q?VA/9MLF6/OPgqMflDjJzcYbUoKUT3ddClb1eVVzc6x+w/88QJmVpbEEInXBV?=
 =?us-ascii?Q?yf4dzfHxW7cVhKnenu9f42LQeEqxAJCpiHJAkkp+zYoKAWgVtdq4hhd4ZwEv?=
 =?us-ascii?Q?S/V3DXuVvxA3YlzPtNrWtKcA0o1XQ9q+TG2Q2FIVl8HlqcozzioccXrXIKpA?=
 =?us-ascii?Q?muFPUe0G9ewnSjaAFNIozpu8NUekPl+R/k0rRqVltkqT+kll+Q1coin5sx5t?=
 =?us-ascii?Q?nTfkbcqeqOPSXp6wMEkevh8zcDiE+p5YmKLcBvMHaRvlUT0cvlTPAbq9+ha/?=
 =?us-ascii?Q?Is4+70uLYI2RHT2MWk0vHf5YBe2kRwka7QroFb/02pkcfuTUeMHYVh91AFwI?=
 =?us-ascii?Q?NfKaXwtch+PKvvb3/reBkbpyf/UDWeFy+fr2rXuARH+YA2WhfIC0H6BTAWcj?=
 =?us-ascii?Q?z8DuyjHtHX7FSuRTChZQKg8SnjUsSVNU0ahLTD41p3G7U3uClXq4eh/oMUuy?=
 =?us-ascii?Q?3YTvFt0TcjvPXe/A1LHs/y3SUcQdVUrky+MHaRq3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d44255c-db37-47c1-951b-08dc016d56a8
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 15:07:09.8406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suZDz1NIwvN6DzEMGEgU9U3lVFJV2bFWf/S0xAl4x+RyKsundSWuwB5x+80SKtLdd7yUToPaWLcKbtr/Q0Jo7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7203

On Wed, Dec 20, 2023 at 03:48:22PM +0100, Simon Horman wrote:
> On Tue, Dec 19, 2023 at 01:59:30PM +0200, Ioana Ciornei wrote:
> > The DPSW object has multiple event sources multiplexed over the same
> > IRQ. The driver has the capability to configure only some of these
> > events to trigger the IRQ.
> > 
> > The dpsw_get_irq_status() can clear events automatically based on the
> > value stored in the 'status' variable passed to it. We don't want that
> > to happen because we could get into a situation when we are clearing
> > more events than we actually handled.
> > 
> > Just resort to manually clearing the events that we handled. Also, since
> > status is not used on the out path we remove its initialization to zero.
> > 
> > This change does not have a user-visible effect because the dpaa2-switch
> > driver enables and handles all the DPSW events which exist at the
> > moment.
> > 
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> > Changes in v3:
> > - mention that the change does not have a user visible impact
> > Changes in v2:
> > - add a bit more info in the commit message
> 
> Thanks for these updates too.
> 
No problem!


