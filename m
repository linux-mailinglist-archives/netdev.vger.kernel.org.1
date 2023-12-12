Return-Path: <netdev+bounces-56396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8707E80EB49
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D37B20A3A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78025E0A8;
	Tue, 12 Dec 2023 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lV4BKbLX"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2045.outbound.protection.outlook.com [40.107.13.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DE9AF
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 04:13:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtijZoEyHcqKCEdYNvFe6Qn79QUL1MojMenJ8jSliSHc8c4ScKI6t1UfKoNbFUH3GPXaBEMHSfiwV7LsktZNYfiTffPhTnDGxlRM8sbaPni7jGCiPrpVSKeIpNxAXrMn9kcDddh4LtPonpyUAtFsAuIdql5ArOZVSPDh5IemAzkxxnlQItUAFCtDYo8b/bia5SUl490Byo7T96TGTW64W7nv+8MxlcfB9sIGJz2/w6WWY1b3YcA0DlCmC+GsPnh7pxncFU7zyAC4Bwt8bTohl/Qdj5ZXHJiiYJ47GWrSBaab0PO/moNW5cNclmQJPAEyu/oFcPUWIuQob5u45CFUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMAB3CwbpYuNVcJVfoiIEuDHfJjlX3HA7NWrmlEQdZ8=;
 b=FXc26DMtt7IY/bLhRDqMFFzmDIxUKZOgBkg2xNYxaWVAIxk6XK5CHK58hBYr90tCvKOK6Ed48UdYZu+Oaj5n+A3KWBUvl00+uKO71jWj3n2tdwWnJ3SC05n7onpTbDuMPwzlndCD3FhUry71iCnkv4HboHPHPLxXsCnu2I6xbexjJN+1t20AABo0ZoFhlhSPGYc9Ic3s8JIDQ5aIYZeghK8r6FPU/zrGHGEZIrtDgwO86NY9xF5HF/AF0lk6GDyiRN5pflOSJrrOuZU7CUAPxOgRSJZKjng0Gbl0GChq89S+vMnVoVuIktT0/W6QeNf9jHcFQGZl95ftR2YI5sbXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMAB3CwbpYuNVcJVfoiIEuDHfJjlX3HA7NWrmlEQdZ8=;
 b=lV4BKbLXM/QQ3ZQ1FLsoB/Fr/05uHzE40oJG4D/jKR1D+u+XMDVws0VWSKgAXjhus/QrTr82dSCyE/oO5SrFJ6OsafgTvbirkH7Cc1m0g9MliNNvHScYli4WLNTgoc50eZlaIem2SLb8nQ3He1JXUr8R47FRtSBPHp1WY/tKS3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM8PR04MB7763.eurprd04.prod.outlook.com (2603:10a6:20b:246::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 12:13:43 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 12:13:43 +0000
Date: Tue, 12 Dec 2023 14:13:40 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 4/8] dpaa2-switch: add ENDPOINT_CHANGED to the irq_mask
Message-ID: <eiuqug7hhchgpmw3ifb377hpnm3eycfzmx33exuh7ut5kgfrnc@rvnsz5ibghqc>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
 <20231204163528.1797565-5-ioana.ciornei@nxp.com>
 <20231205195819.6c8dbcb8@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205195819.6c8dbcb8@kernel.org>
X-ClientProxiedBy: AS4P189CA0041.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::15) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM8PR04MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: bb53661d-d63a-4a5e-6287-08dbfb0bc8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZMxitB/WcOGrlzCzHUv353EN0Hji6cjHdbqHNfzjLd2ighxvsHYbI6WOgdMzrVPbZLbkKm/Xc4MO70+zMRlzyF0jDjJnV+/wLqdgsKQE86/nPgygNsgmyWcUoErcF09IyNEpuMtG1AVpzo9bHAQMtzlgAQgEwp5Nc3wXgA3272HIi0EbUEzRH2ao1DZ6yfKClcyu1U6Axbb9xxiIGOoLal77pyVCmYWAN11n3xj1wO2q/QX1iTxNwa52M/W0c2Wb/TJE+hY6488HPTRUKg1AQjgvOff/8RpQ8mA9LkpE9LbuXa6/LIeySwhOLqGV1nGzw9nFrAPZQ6ueMRCHUAb/qGoh55bui4h2+BQ+SCP+xY1QO1NaDVLo2mRRZgGkSkpMFFIYEaz8ptTtfgsGA5sX+Wtu53LTjUiJvCJWxkBM0Yn9WVto7WANXAT3ZlfPQgdOPjoDstcaF3YN+k2lbLJGXVExrOsBSDvi4zVeNOxF/LYHCngkC9R2Xn7eQWJg/xCsPbEcqqtb7W1pSSzk/CvNQdUCz665BvAMAXmHqmxRksHI1HExsPXdbh/elH/QRAS0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(86362001)(316002)(6916009)(66946007)(8936002)(478600001)(66556008)(4326008)(6486002)(8676002)(66476007)(44832011)(2906002)(41300700001)(26005)(4744005)(6506007)(9686003)(6512007)(5660300002)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XoTb7kwtT4iDBkyzYDr3hzJJ6FndguuOdONEf+K2gDuI7pYSIt3M0XIh0rGk?=
 =?us-ascii?Q?NXFAv/eS7Bh5bVyednaMzGRmab3mkS0c7/TsOYPmnYQOJ0rRDpeFMIxLIsPy?=
 =?us-ascii?Q?C51shUhAArBH5G0SeNuR50O0uaOzeJcES1pE3GYQ9yzw7a9oY8nBqC/M9J6o?=
 =?us-ascii?Q?Cs56OUXLgx1A4TnKNXqWv0vkpsGMjuyMc5Wjsu41lwvWyPRA/pJBWPzi4BWO?=
 =?us-ascii?Q?frezwR1qBff44PNvs3wd67oeISXp6jnSvmZlTPUMAFi2AJOr5NtYvGS1q35M?=
 =?us-ascii?Q?WMLjAST2yodsbpnlyyYWty7FObLG28+GPDuBjAR6IDLbZcnteWTKhmyERwGR?=
 =?us-ascii?Q?QmQdkBDwR2kuOtIvoyVpvh6Z5FTl5efBo4oLDhBWrZEJnY22Sc0zEuesmC9L?=
 =?us-ascii?Q?gBtJTF9rw8L6vYh0EZzH+y3p8fU3Xy3uF3+M1hiXeY5O+uygW6q4yFS9c5Jn?=
 =?us-ascii?Q?eZgTfggeoM+FRPAnHR4syj2ZJULEHpe+mm0jOlTsLyUy1zOFYO72FHN1PXJ7?=
 =?us-ascii?Q?EROMY2laHMuDtZlU+zlZYIgFDkvAWFGsXuHm89x2PLfbZp5a67czNUOzXm/n?=
 =?us-ascii?Q?NOqPek74HP1DQmm2YyC7uBfqaJnfWg/b97wnrF++DMd4BOYrn+3HaCaxUx5j?=
 =?us-ascii?Q?MKEdhdnWAs9FxO6dYNsMieSVo4TSANEGmuxbJXz20sq3ZuR0pfKcpJBsfC2c?=
 =?us-ascii?Q?6WYnyF6kDnreR2xbMmTR8QW/YBPdaJXjtQKY+s5DVmJ7GrHt+ktgFUYvPOYw?=
 =?us-ascii?Q?IuwYOAsXqotCKaRVrUrcGATlhUq93bTRGg3doxyDaRq2eoA70j2bjNlXTvxg?=
 =?us-ascii?Q?ed4nvz7hm1UPvJ49Ub0hVT5c27/qc7uv76wkKv7MEPnY68ivOniW9RCdsfdX?=
 =?us-ascii?Q?rLzIacRCV3yxudrHMhcNyvZOKIjJ2AL8pFV1a1nFBvdZIRE1OccGUtouK564?=
 =?us-ascii?Q?lvaX7ky7RHaRZyF41IDMnKqIthbfwX/gilhFmHIHMUFvLFy+tFbl36yUnX8k?=
 =?us-ascii?Q?tkiYl59M84uRjAv35TAVVjudV6nYYCMdDtWUEO79a3JPtfixSEQX7JFiazk9?=
 =?us-ascii?Q?ih3wpRx3aWd2aHnwZKnk9I6ItLAu9LBrf7o2oBK5lklAoBeW9ztmBlrpwxrs?=
 =?us-ascii?Q?EOJdXNs4MrI1MUeccCO1bUhOcB3HmWfP/jYJjHj3x7Dc04e+aqZnvJ/f6TZw?=
 =?us-ascii?Q?GiO91M7Dp89YHwLcZRJI+jpCZRNWmdEWAZkKW2ocpO1ZFnowQViijP1R/RpR?=
 =?us-ascii?Q?D+ZrLsP7HLuPUPGiHr2aSnzsashMOIJEaVl7e5q/z+HnAxtNLhckJ1zP4k0A?=
 =?us-ascii?Q?4gvjINTPI92BlBQkqcjhYsSDlM93pHcOIwUrZsLVUl5insmLQ5YzbcnkdZB6?=
 =?us-ascii?Q?S1W54fXFWdCREjG/n6T0df7M7T96BbEq9IVTM6+mLbfU32/x/4KEDwYuBvBW?=
 =?us-ascii?Q?er0Okhdo5l7FxKQMaL6W6JoCDTAM6cR1mG6zPj/V3ejSgYtslJVu2dpDaBZm?=
 =?us-ascii?Q?ZlAbvnO/plbTL1V30VVXzP5UEt2xy3ltYSuv0XEpQHUc5BSbpHWkEGS965nN?=
 =?us-ascii?Q?Zb0Dhy26zbOBxAwymltrIDixfVJfwylKHOQAi/jb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb53661d-d63a-4a5e-6287-08dbfb0bc8d7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 12:13:43.7348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HivfbE4VmMDIcb8kf5rLvbrrfuv7Y2zJGEFe//8YK1hdFxr5immYZA/EysYC42v0BOiSxQwO8RPwtI2JEwfzyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7763

On Tue, Dec 05, 2023 at 07:58:19PM -0800, Jakub Kicinski wrote:
> On Mon,  4 Dec 2023 18:35:24 +0200 Ioana Ciornei wrote:
> > Add the ENDPOINT_CHANGED irq to the irq_mask since it was omitted in the
> > blamed commit.
> 
> Any user-visible impact? What's the observable problem?

No user-visible impact but that is only because the firmware sets both
events anytime a switch interface is connected to a MAC. We shouldn't
rely on this behavior since it's not documented. And this is why I
didn't catch the problem when I initially sent the patch.


