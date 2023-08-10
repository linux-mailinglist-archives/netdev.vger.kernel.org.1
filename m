Return-Path: <netdev+bounces-26538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6E3778080
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E847281FA0
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ADE20CA7;
	Thu, 10 Aug 2023 18:41:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC3B62A
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:41:11 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::603])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1443B3C11
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:40:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYSn0A/JBY8Hy7/SmkAdfHBEbezQoiUJJvp25EsFcQkvZ7QzYa7uCo3fnZzsLssPSia9kkkq/yVLVtfQ6LVWi5E273KMWag/ptzwn/hsH0BLfnpEsgHnG0dJnI+fkIEDS7pHTwpsV6R8CzjRQn+usYrDcrqwyTBQi0j/BNFi8Kot/tmgKdZNHAXuC0oTFmnJV8ERq9+GWJXHXIAWpFkJ4y1gs8H/Yidd86GOsrGSZS7jg/0KyaWpcQ0pIOEmF2d2lrw8MXDSGAhVICeztM0U5mXsfTcgZ644qQhgLvZNvHQdgxGofysyDRBiExKNleVQdTUX6ZaDrgyzzMWoOG8ggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+El8fKv1e2fHuC3efhzdT+djTFL1aNRYDT4EIfryNs=;
 b=jN3bEPP8V1jnvLtYZ66n6ZrsK8XMGpbqKtvRTxoTHGFvSqYnCAn8wXu7ACbt5dfKoRfnPFahcjNYx4uhV7PFJwo6MEWEaa89PnjwdlTYMochIRJ9IgENtD4jY7P6ulcqNiv8aiJXBHcQLnl3iSanuDFSYGq5Rjqr5BAGIfdKKqz68xZ7BTyZgdqd//HLIujg+cbdRxeOsfVTSHDtWODQKXn0dlMO0SaXkiT3NiOlCpJwPfvqmkzPiXaZF/NZmyWpGX+2jY3EULUonH024nc9k2yleQjUuQsM8OYj17EpPZ+erHQ3O/CWZAwWxRty8nPvnqZbB7r6sTZzANPCAuyCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+El8fKv1e2fHuC3efhzdT+djTFL1aNRYDT4EIfryNs=;
 b=Mifm3NfMqnLMSqgWdp+d8m1pbXOGQAaJmaW1O2IHiaqSIMGw/zxvCMUOy8iGRKfXRuuGig/d+v8Ymqlb1GiRA9LEkp4VeFwcjcjSVxZL96W6/U+69fdqe5fT7vri7ROdN0Lzos5hGCsUj9FkGw0UPtiyXcMhoDTaWf87b4g7qrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8557.eurprd04.prod.outlook.com (2603:10a6:102:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 18:40:07 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 18:40:07 +0000
Date: Thu, 10 Aug 2023 21:40:03 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, jiri@resnulli.us, johannes@sipsolutions.net,
	gal@nvidia.com, tariqt@nvidia.com, lucien.xin@gmail.com,
	f.fainelli@gmail.com, andrew@lunn.ch, simon.horman@corigine.com,
	linux@rempel-privat.de, mkubecek@suse.cz
Subject: Re: [PATCH net-next 10/10] ethtool: netlink: always pass genl_info
 to .prepare_data
Message-ID: <20230810184003.id4ouegp3kp6ciki@skbuf>
References: <20230809182648.1816537-1-kuba@kernel.org>
 <20230809182648.1816537-1-kuba@kernel.org>
 <20230809182648.1816537-11-kuba@kernel.org>
 <20230809182648.1816537-11-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809182648.1816537-11-kuba@kernel.org>
 <20230809182648.1816537-11-kuba@kernel.org>
X-ClientProxiedBy: FR2P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a0fe34-f9f5-48b6-3725-08db99d137d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZQlvfni8OcfE85s9dqzKin0+jI+ZKt0qaSVo1NJfMu+l8kIpK+11gNzrNghOwkOR2gq4XqYwa7OnLOu77UuZOr70JGPeE2HetqDqkc+xkFFfER5IoyjJAGfnszXoNtAwXYW9wBK7lTEQANs1xUVL/wL1QCi8KRhihkFviQurDW4CEN8swMg6HOKkx27cgIjJQakFDno01j1FhksZ8oKVetZZH5Hj146ODFPF18WqKxx4SeuX30cOIMs4Vd+bU4VUN9Z5j1f6gpZLWtDO6efR2fOTz1nSPwweCzRHGDt8DuWcj3Fvdzk/vJFd4seuUV28V/dpEvSV7CCOv7syOZMNv3Imzp/EBl/0jErqM2J4JeNLSC8UVAVCJlh/4ChCJjLau182uN97weU+Qb3xGTWvlfEOPpf4Q4LoceSsGrUskv6RSKHEAVdHJZ3pvuh9O30Yd9pVWN9IiJQaL0AWfiItFgOfKRjbbP14+2RhHezTKmjzZEuV4s8MN3sB1CXgdjYmUCX3wAbFtHvRJUMIoy/+7IZiCjNF34JSTJKZCEfyAduYkap9ngUU6tUBIMZ9Sa58MW7dx+hk/92N/os1qwqvFU6DfX8WGKdVoTmdwhSJjLHJM/Wy1SRJkaqzYYb3qjdB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(39860400002)(396003)(366004)(376002)(186006)(451199021)(1800799006)(1076003)(66556008)(66946007)(6916009)(26005)(66476007)(6506007)(6486002)(6666004)(478600001)(83380400001)(41300700001)(33716001)(44832011)(7416002)(316002)(4326008)(9686003)(6512007)(2906002)(86362001)(8676002)(8936002)(5660300002)(38100700002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q5gHCedqmH9WIwb3evtxhdbxEzEVSG0iz2Gii+jzd8SokLMr8Tuj7wjA7eWw?=
 =?us-ascii?Q?BUuc9IdJ1fmfz5p09Xs2KNWbCOPTMX6+YtW0ds+Wxwa7crmcL0Apt1jinXg8?=
 =?us-ascii?Q?TmpUtikdmnn2k/gGyGz5xddlv6AEgNX8nnssBAFzl/D6weV4F2MGvWnsMZ58?=
 =?us-ascii?Q?T6iKOX1dVLHRs/j16undpYebe9aCuFvfAYbgwS8xkc6ZfCb3rqmNRQ+XsUv/?=
 =?us-ascii?Q?6y7s+N7iNa78JOshNLDhlyYWoAqKGUSiMgnlikIN0nqjLK2PGBSMJIqtsy1o?=
 =?us-ascii?Q?titTTbY7TIvkPGs2O83ri25T4/1TttxrcxqfBvIkwEAwjGd8z8BjNixBImM0?=
 =?us-ascii?Q?1G6iMui8rO7UhsH5UazetOGi1pSq1VOwqaP4w46fTbpZ4D6DfsIsVtr+eRR9?=
 =?us-ascii?Q?zp+aXV1miGxAtmHg6JOjToEAm7Pjy5MMisGOLlB3/olNHQOoxTfFZdZjJ1fk?=
 =?us-ascii?Q?Fmf40HbR6bZYgpWyFc5kGn8slenDtRnOtQDfwIFvkcJ3O9QqrkiyP9L/46qY?=
 =?us-ascii?Q?cdYuwwj5eIk46yM/dTnKyiPm84v3TU0fz9vK7xVT5yBGaU4C9L8/7uTO70WV?=
 =?us-ascii?Q?rHfjCNO8DBRxceLWZtlinlEKfWt27nG0ZLQPwBe+3yyMN8aTeRz6Fr+751ZL?=
 =?us-ascii?Q?4hwpA/hRAAgQxGfsS38rvQLFOd4kc7Ppu3TzOxr2NUanF2od2FCmZQG2VIy8?=
 =?us-ascii?Q?P10ZP4HXAgUnXZtCV1SHmOAqvGcv5foIwF6m5ImcQ1dD0i+NKe+gE02HzMpH?=
 =?us-ascii?Q?nmWD+dN0poFAeFnBGdr336ueFxBHhylzQGh2WcKxxknjdRZ+yFkXFzvNqNnF?=
 =?us-ascii?Q?sCO71anLVisB7ezl1LabShe4wzACE7sBmg7Y0zZ+2X9jdfhiBpVldt4rRTvY?=
 =?us-ascii?Q?Jxrd5WeKADj0jdkzKCz/LDL84nqikiWwN7762RXmeX5b7V3G4ccr2l+Le+WL?=
 =?us-ascii?Q?B4PI3vd/y/HdRxeh1kK8tXdXgY7qgV3l6a6M6dMYAtXYXY/kLrDo3zlyVepI?=
 =?us-ascii?Q?cclMKSsvuIcRptbe2pUrHnLFfM/ADJcqdNsa6NwUvgTKnRIdodnPvz205iVg?=
 =?us-ascii?Q?niN/47u3yio8IQOLwAlujHqVvrlkRAqeVz1sGgVj2fgkieiwwbGks3aTPMGM?=
 =?us-ascii?Q?jcaL82rZ8ukfs6qjxIjiyYa/l6g7o51Rq9T4ma9NCFdfD+cvxzUT1eFbeWx1?=
 =?us-ascii?Q?TxVep44XbjP/fCGgvBWjcRDJ2vMGUHr5zHtKrnLrB+PTIUp2igIXuLsS8n0y?=
 =?us-ascii?Q?uZOqNrkTHpy/EtFTvahyUoE1V8uVQYXtWQnoXf7PGOzrstn4m0UeQYHs7dTz?=
 =?us-ascii?Q?juqNEDp6Cvfbdtd80Slut+kzl1fRxOtly/G40bACj4BkkpA4wP4w2Zs/LABb?=
 =?us-ascii?Q?yzRkzTp0OszJ+FjAYY29Strpv81jusxcrAZ+ScGKVc1PP7IAizB5eOo8dsqx?=
 =?us-ascii?Q?iHGIEEx0l7pJK2IV1pov4s1wp7icr4lW+etaX3FCBy0mA1chWpQ/QfC4I1n+?=
 =?us-ascii?Q?eRR06H9MSz1jE8oovR43WHsX2yFAaMmqeVRjapFdhPnTyMgeXVU6k5PVcl0x?=
 =?us-ascii?Q?3KgECc2NRn7yfmY0/L0SNUNASQjqYRjbhH37fSWaK8idX0LjHYH0yCK/pr9H?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a0fe34-f9f5-48b6-3725-08db99d137d5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 18:40:06.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7X/ZQVby9njh+YtK/N8KhqUp0G//XsFS2bMBaEC0RY+kgGBOo2pmustWcCiNphjlE1FsYvxMO2yh8Fdr9NobA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8557
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 11:26:48AM -0700, Jakub Kicinski wrote:
> We had a number of bugs in the past because developers forgot
> to fully test dumps, which pass NULL as info to .prepare_data.
> .prepare_data implementations would try to access info->extack
> leading to a null-deref.
> 
> Now that dumps and notifications can access struct genl_info
> we can pass it in, and remove the info null checks.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: gal@nvidia.com
> CC: tariqt@nvidia.com
> CC: lucien.xin@gmail.com
> CC: f.fainelli@gmail.com
> CC: andrew@lunn.ch
> CC: vladimir.oltean@nxp.com
> CC: simon.horman@corigine.com
> CC: linux@rempel-privat.de
> CC: mkubecek@suse.cz
> CC: johannes@sipsolutions.net
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # pause

with:

$ ethtool -I --show-pause eno3 --src pmac
netlink error: ethtool_nl: Device does not support MAC merge layer
netlink error: Operation not supported

