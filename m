Return-Path: <netdev+bounces-53497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6026680351B
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 14:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170081F2112B
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E91825115;
	Mon,  4 Dec 2023 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pLGg2p42"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2082.outbound.protection.outlook.com [40.107.14.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79146D42
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 05:38:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxsAaRp6kMa4Q3Z5JmAC5UKbrmujO7GRH8uBS++NZA+hWYWMts5C4ix8ljo0ZBGqkg7R/7hHcoknuG+6cj3NkVPy6BeQ+os9vMQ9dAtJHyGa3r6VvhNFaTsewtgFaChOTqX5wHvgcWBsvvb31SuEkmlb+uEXg3HX/ypgcirXT7X3/NzEKyOmBHJsauG+g/gCyKxZJQwH0Usi7BfqqtTNRdfx1K0GYXaCAZ1KukSvA0kB242AszMeR2rFHndXlbn5aZtc5Hlthzpi8WeWsHMjszuC4vV3dGKvsisBQdUYBSVYvAS7tnAgwK0BU66jRujAT0hCexxG02odRKZg+79t0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLEu6xySX01MvP+lwM8ZqxzpI1rLcO0cJG+3kR5mhJ8=;
 b=JGPI6XjqWEbL30mvqtubuKOABaXQHX7PTLrHYBfQOPIdxE3oAIcG8BfCYBjnk//8KuTz4Sw8yeUFJKYE5oKeU8BsIyRqafKMsvuc8v4+N6/8EMENHeM5PQWIA4vSAVM649tHA5F7H/vrnmxcecjnqUBSXAMc64SGmZ3d0BdN4rVfxJx3SYwIiNj2OXD2Ljhn1CcLnAVD/9ciAQJT5EdKi/MKow13MT1og8o1CJJqKBox9Os+I0A/mAhlGYG1tlbqWY1F/2Dec9HhwBnR6NyEqjSHQsFWl02XzJvWTeAoQ9kABo9RBaTOI05bLRKbEWatxnM/ganraVQx15m28Ax5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLEu6xySX01MvP+lwM8ZqxzpI1rLcO0cJG+3kR5mhJ8=;
 b=pLGg2p42PjpmXw7pqJsIps7ak79s4lIEEHBB8gpZJRthw9LrkUy+SgJ8Pdpqj/ZdcOFKn1c5TZ43AMRBYN0Pe00TSs3l0wiVkHDXKTqZwjkgt0XvonfyzZHNPQdeAWEDlY32QbGg5A/NK2VocmuV6qomCqMtlDIwJakmjUEcDok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 13:38:27 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Mon, 4 Dec 2023
 13:38:27 +0000
Date: Mon, 4 Dec 2023 15:38:23 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
	vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 net-next 2/8] net: ethernet: am65-cpsw: cleanup TAPRIO
 handling
Message-ID: <20231204133823.xtnmxokzwv7tehb5@skbuf>
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-3-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201135802.28139-3-rogerq@kernel.org>
X-ClientProxiedBy: BE1P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::12) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c4fc25-4f4a-4a46-7291-08dbf4ce4b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AgBgj40XPKAk0cJEY1hS/RtC+2PXXPys1D1vfau+o8oW0enmeuNtwH6WQ5WT6aR7gsuMWGGom/9Zy8xMVbgUm2euzFvlVWvw8puiK8oxqgQf8ewOmYv+FnaMVp/IkdAYMi2hbnVK/1nPClua18Z7xWOotIH63yQpgDbH8pZ8wc6nxzn/Veb20jRnnhEAzIJNq0NpnhlMcZ2SljBGff0tUp8cWv+2xguLwLAjAyJj0NTDWsfBGTrtoUVwYL4sNbby14ZSGnao1y48rZ5kVmZaufF9FCtMA9GwHghIWaOxpjeRF3PUhgqPuqoIdlVu7vE6LSUGH8XogFaUOLfXj65P1f5pkVWeOwANuX41IH4ynKdRKlIZ9ppGo1yOHipT+Ry9Qt6PkNsV+sk6RFmylLeJqFB55fHrMrJEdeyJFEuZiFH7LtgZAvCuCc7amb7uEEQeXdHlv5YFgci3Ba6R+qFrM7xosic1kgORNcDHb5LnYT9m+vRfpPODIYObKA6VCWHhLjjUfPnkiJUyohzyYS/vwFKiUNfsLjJmCJOVQ0Dh84Jaw8lDhDmYogSqC4gG9Bny
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(6916009)(316002)(66946007)(44832011)(5660300002)(4326008)(8936002)(8676002)(7416002)(6486002)(33716001)(38100700002)(83380400001)(86362001)(478600001)(2906002)(6666004)(1076003)(26005)(6506007)(4744005)(6512007)(9686003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FetNHh/RypBcynpIef/AluHvB5YMeNFp9zzcDD8sr5rHfvN3d1FAZrnTzOGI?=
 =?us-ascii?Q?4YPZ3+QKdwYkvyC0glTNG/rg/Hfc/njC+Zw1smxOFA2xXWp8V4D7Z01J6A4k?=
 =?us-ascii?Q?gBy96QHaoOx0qIYS+UB2DzpZ5xOxEKttxf1YeuLEmt0h/mOwnCFZNog/T3AX?=
 =?us-ascii?Q?wdpIUz0Li9OLm3mVvA+P1jhqAz1UIFb8AwJ9BnFZuk9uusp99FK9ksDYD4C/?=
 =?us-ascii?Q?Lx4iVgcWkyStGn99Xwa4PkcslTcwim3OINltNyGQAngd3wFbgekb8KaTpShw?=
 =?us-ascii?Q?iW2bLMPVpryhf1ZNkdw3hdQ4Tv269fj8SQx7u/7Qt2SnheutoKjmr5iwj7Qb?=
 =?us-ascii?Q?PLevwahN2wU8Oxaq5jik3HhydEkZIQcb52cfxjCbCQL607KsjNlt1m8xwLPQ?=
 =?us-ascii?Q?/WItM057NFRoYUM0kZEwt6Dmk15Lo0MhT5BuvRrlXVGB7u2UXFOGaS328JH7?=
 =?us-ascii?Q?YAXHgJ4NvHwi95CYx/wia7XbeXv7UkAxB417MLfTxqiUPVj/xrlalBzDSIM1?=
 =?us-ascii?Q?rqYwvIvtsYKte3UFVr8PV+jQdx86z2pKQIzcTQnHL/0L44C004cmqI0nTjjR?=
 =?us-ascii?Q?3RrjQVUm8YdUZeMrwLBxqLMervIQlaXgWm1en2K0IlHAlCrOZjbJPNm3nts5?=
 =?us-ascii?Q?uPG6EON3i0x+xX7rVZ49derfG9wiGoYMiyYXu95RhYwAKfc3Pavjsn/2UxxX?=
 =?us-ascii?Q?csdJ+HzdyHsQyxE/5oU9x4naoAGa/WYkUftiex+KoEgl9YuIAFHgtMk5PQzi?=
 =?us-ascii?Q?sN0DAze1S2elEJNiNYjPz6biJbg2DNFPVqAxCjPDDhHuq5UoLefPlIsmbeHd?=
 =?us-ascii?Q?gz1d9fNXdArFVnhT42AvWgInVD7mpYJni+cJCCNDJPp9tbN5kBVZPDdcJIPW?=
 =?us-ascii?Q?Gv4NzSpbDCx9iAEf4iEJ4ZJLu7I8ooQAk5FuhwkJlSthOvU02LZV4hUIf6WM?=
 =?us-ascii?Q?QPIh83qHGruKgm1wIhoPoAhyJNOZ1C3d8pJFhYcwjp8rCIs5WBIk9DvIom5o?=
 =?us-ascii?Q?0Lly45DWByA8nzbseRnMuJr5AQ0D/yzRnA/3y3Ghi0MwkkTofkFYH83d84fA?=
 =?us-ascii?Q?lWwS2bwgnNMzaWzjSa78TDyL1X+X6ZYENoKpj5tMDqxZQxcafrIAcT9W5GmH?=
 =?us-ascii?Q?gHfcUSmE1ismRHHlfL74xwGK4HM147kOHRGHm0fF94uePu820BqAaUFQPpSM?=
 =?us-ascii?Q?BtTiJ0WT9zHdMLUtFXKyJfXkkXaokvQJR8uvxMjtEQOpyR3TVdslR87FXH4P?=
 =?us-ascii?Q?coN9lpbFiZ+qtpD4+YH5Q1Fbtc4AA3iCEyO83RktBS0SCBEpb8PgSuySvC4O?=
 =?us-ascii?Q?4Dc6SkblH5p43x9J2uIKZ+HtRq5JvLgLaGiHxpbx3d0B0e+jI3q64Cx+kFx+?=
 =?us-ascii?Q?xp2NSoFtqyIXEvS6/JQI+T2tIZYuX+mornRy2W/GEwPb/G772a0sJSNqcGVT?=
 =?us-ascii?Q?Tsbvo1GukX9+SKiwG/YvJn3lMbkCUHf7+3imBIfce+RIZ3PVGy2+C3Ydwth6?=
 =?us-ascii?Q?WdQzvFprzMaJ7QADuGTaYu6KvOLQ0JgbZJQhVCWhqgyIFlDlXm6uTjS9gQqp?=
 =?us-ascii?Q?UPux/JyYcK+mCGbYj40aZVbLTG0eK0eVQceJFO0x/DziLE09Y1DUr75w8A51?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c4fc25-4f4a-4a46-7291-08dbf4ce4b64
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 13:38:27.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZUA0h4Ps4qMm92uIHbOchpqSttZ5OMubF4hRzVaOLQO2AfslPQzh0P8wPAJT9ZQSTedFzAp3DdILJJ+nJZOjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

On Fri, Dec 01, 2023 at 03:57:56PM +0200, Roger Quadros wrote:
> Handle offloading commands using switch-case in
> am65_cpsw_setup_taprio().
> 
> Move checks to am65_cpsw_taprio_replace().
> 
> Use NL_SET_ERR_MSG_MOD for error messages.
> Change error message from "Failed to set cycle time extension"
> to "cycle time extension not supported"
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---

After this change (I guess), it's pointless to initialize

	int ret = 0, tact = TACT_PROG;

when both will be overwritten later in am65_cpsw_taprio_replace(), and
nothing depends upon their initial values.

