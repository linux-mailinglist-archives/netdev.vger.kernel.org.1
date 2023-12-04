Return-Path: <netdev+bounces-53498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F43803559
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 14:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C5B280F89
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF1025546;
	Mon,  4 Dec 2023 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E5hbKJBL"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C327D2
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 05:48:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4l3G9iyM4Y2rg4o3gTu7I4Qw8GyJWZ1ZwKkafDEtlC0jUtf6L0Obwl4/QSMnPEfnyrLT1OKj9XJRZnc7PuGoK2f/fZK2VYVpIC0KlPeD0iMUx2AMdl1XJ9lnlWfIkrpnDaI9TNkkZWWS0wXNRfPJ91v5AOY4GOmwF6l2MNE68akDjyShd0wPy5t3zvvrZ/vudSAKQufIf2QAKoX0NenMSe7iZEcnMT8+CoQWgb0oPlKL/wNTsEGukGRjpKUz/1NxzVdqllMBZA9gJV4iK0LM/wGkKB4gFEGctD2aKYk04JZOO3FiSCElgzdXyujtK3V4rvPEeNruxSPSDMwwynx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXaKwhrD/rrsVjAp7WcpkoJRDBWIOA6lmig2Xz9cUHo=;
 b=BwYqM8k1IPLBS8bb3efRtttyQwpMZ3LdDxp8BF2QVKP9dk1wNtvGUwbxkQkda767ggIC7XI8S79WNJfgDp2qMCTLQ+jTxA7Kr16TaAEJgk0kbLxOCMdsuZCMbwkmL7SHaoZbJ0TKyC9FHXC+YtEZ7JGj0aSdc4F1+qFdW+Ev9lATJw7WJ3rsGJP7Q4TOCfGOZwzXnMcvXfdsZEODfVq4FRoXgX9k2IlBibWUMFhHBvCqlCoDTlFzcIeeQXK1+UIVQsrM9+26FJhcc0nkLbpZx4fSUSRKH6SC5SUNW+5FVjI1aAi/TMfCGpzKaiZgnH9NridYxPLuAwbhBdNxNDOfqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXaKwhrD/rrsVjAp7WcpkoJRDBWIOA6lmig2Xz9cUHo=;
 b=E5hbKJBLesaOhPrn5GP71vkRga3ptN+I0Vn/pwJjQAHGIPVf5m8nNr9jMmvZIiY1+PSwzCjfacQCEu71qmxFtt5WMHKkkha/o5LK9lD+9CJUS87K7Q38/H1PkvkhU6m29FAvDOfjCt6O/l1GfbDVdIrlrS7a8tMS0+dl4GK8V2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7850.eurprd04.prod.outlook.com (2603:10a6:10:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 13:48:34 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Mon, 4 Dec 2023
 13:48:34 +0000
Date: Mon, 4 Dec 2023 15:48:30 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
	vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 net-next 5/8] net: ethernet: ti: am65-cpsw: add mqprio
 qdisc offload in channel mode
Message-ID: <20231204134830.uqz5xi7h7utnou7q@skbuf>
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-6-rogerq@kernel.org>
 <20231201135802.28139-6-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201135802.28139-6-rogerq@kernel.org>
 <20231201135802.28139-6-rogerq@kernel.org>
X-ClientProxiedBy: VI1PR0902CA0043.eurprd09.prod.outlook.com
 (2603:10a6:802:1::32) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 97fb9b89-443a-4e44-4cf1-08dbf4cfb52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OPUtchZLQJ0uG0lxQup/pCCgNv1aOkqD4nRMK2X3aY2a5hE2BphiYGjhSSh7MUQnFoqYiMnPI/1IIroBQi2bbpuTterZCB35UBcb/8xrzVrdl89awvZtaTrDYCJh3RxDOuU13BaDhqbYu/LsB34svMPUmopS46Te+ed5N/qHW2c5uKXx+ZzQD22TsItDMpDgCsoI9VSrAa1k6PuNYXbsvcd+KqXRBng5UzB16AG+ixgY1mAE/urO8CVuuOiXQNnGO+RRk0xtkjLRyBvyUv/fYlgF5m1+g4hUghzGWdh9oVZ3tJbIoJ0HNOSugI+Z+etYocYQivP7qb0/AKT9Tf0JATbFQ6cWrqUw+2mwjruYExAToKCRlmdQq28WWHHTs4leT627LiZsA21TVVXYv/FgauSk/xbRuEQSlao7s7GKvrRJ58vn4+gmuaTih0B5WVvbQ19JTQEnCDOMz3Dz8HC6zxMXSS5STyTHsDycj/IxHDb84LuGt38EYVvzIYz2xHH1OijMWnGszGaVH+Ta07Y9TD5WQL69bpj7VunAJYfrsJhLFiEXbPJpNnorcw0Vn/39
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(7416002)(4744005)(5660300002)(316002)(4326008)(44832011)(66946007)(66556008)(66476007)(6916009)(38100700002)(41300700001)(1076003)(26005)(83380400001)(8936002)(86362001)(33716001)(8676002)(6666004)(6486002)(2906002)(6506007)(9686003)(6512007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lvzLpV7ddZr7FrQLJMwPSlnquuEnJZ0OcXWAdzmCc8eJ1wjYSg5bzHAEyowr?=
 =?us-ascii?Q?9tMPsGRqeKyxCYBxd20wx0Z3fE8A7ovEiIlHV63PGWF4gj/4fQ9xdgr0XTwY?=
 =?us-ascii?Q?yx7dKNYe/VNnGdRettBiiUy+CQLPsSSO4U032oBZRfpBj0EMDY1B6rIXrz9/?=
 =?us-ascii?Q?FPqavW3Yo0TbG/J6Wgh96BzphxZjT6ChwrceakKGHONc5zeqr14B3P/dXjLT?=
 =?us-ascii?Q?/Z5XEvYX4VbuTnxCbVHkRNn+GQYwtGwa44aJUhuSDz9Wlf0sTvGJmErVrgqH?=
 =?us-ascii?Q?GAA6FFzDsw5p2orgSrmANs670SD9/jWzXv41qxVMIgSEyKOrmu0dvoGmDZAM?=
 =?us-ascii?Q?aaxQDQ1R7Lj3zoFD+cdJl+uWs4KB0lUIrGECRk+xLxJKBdBdftxmf8vacePh?=
 =?us-ascii?Q?GDMCK6Xkng9zxY5WLAkTIm/ZlzXtOXEFY7FS7W0dL/4c8lO9f9FjBLSaPZ1l?=
 =?us-ascii?Q?5QlbwdrIFzKte4OfEXUywFtny5zjzWcUgfl1nn+UI3xproCultJhuxZtq/CG?=
 =?us-ascii?Q?r2xMNm8cDKF4whUiXCDbvtu2CIy5V49F5BbY5i7RncVCZYAIFZXJEewqH5Ye?=
 =?us-ascii?Q?MigIGrTdygefKDa6XAk2gK1cYYsOp8+OJ0ayxz7aGPdpVycSNcb3RooBrZC2?=
 =?us-ascii?Q?UaRMf0tpKUiDUEQG7cQtz+5p+iPjFEY5WbijhgXQk/hdGzxokS1Zmoyh3w9a?=
 =?us-ascii?Q?5PyJ7lEbRCz7cvuDVZmUOCvh12AW4aRgvHDYMnN5jStdx2FH4FnyVHJM54p5?=
 =?us-ascii?Q?+SA8IthtlyVxlWqds/2qKUvStgtEKflFsSLMfHq3k2r9QOtOEg+dF5Demki0?=
 =?us-ascii?Q?EtbQw5NV6q+U0D3F7iL42tz4ZOgCfn3p6wOjjTBROohfvTwuNgotnOU1JB71?=
 =?us-ascii?Q?c/x2SqptrtNMtTNcU3dBaUi+VU4Ko9JBP4TbIZvFXvBEywlBnjxLCuNJmIVw?=
 =?us-ascii?Q?+okxqt3zrQWXwZwdgu06TsD2G2Fi5JxcvMVT//TAJpisdxVUG5B9NkxNIPE6?=
 =?us-ascii?Q?mKmmxXMrg8JfEC1hoB6BgR9PmRConrjVu67UpsQywEIgEGw29XORBfrCpLcd?=
 =?us-ascii?Q?h3AzgFo3dmpv2dVhGDkTVc9zRD6oL+LnFU4tK1YPkCCLGRmnht3TFJES9ykB?=
 =?us-ascii?Q?3LwomymU9mM0/MfJFtD1HbZoUhs8Q+5aYYjLW3owX5x7VjQ8KX6CQM0IJraC?=
 =?us-ascii?Q?WVcGQf7laTVtSx/tdZHoYD5wfSXzuZgB6CAc5XBxpRGLU70ZkzO4yxvfBuOo?=
 =?us-ascii?Q?EhOSSnkcF9xbU4JuSLH1Q03fGZT6F4WKTyTQucjuXjbiOe2htSDB8p0RvAwp?=
 =?us-ascii?Q?85km5oMrf8e4lM+9gHJd5Dv03GgFgQksUW5YZC78i3k9XpuALNA9Qc+JOUKH?=
 =?us-ascii?Q?oTK6ms31OWGiEFowSsgQC4x08zNIc74Urd2KasI3skxsfeEN/Z3inN2CTlHl?=
 =?us-ascii?Q?Nri0OOH9MQ74bSEp1p4gn4D8wcc6mP2OlwKejZ3aC2iq1zVYTZ0s7K4suB7v?=
 =?us-ascii?Q?8dLvI/dJa4FrPtmKqtEpBtP2kgKOwLZZRSUFWRCOFrroS9zWVmbak34LIv+6?=
 =?us-ascii?Q?rgMjAGYUREnf5sbLlP47uMAbyvoHuzuGR4gZUwWyH72H/iBayCvZJ0JN/8HE?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fb9b89-443a-4e44-4cf1-08dbf4cfb52e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 13:48:33.9774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JengrRWHqMPAKgO4qYhiOHBZMnnu0kC+um/3JiuN3crdQHd5A07KS9xJg/Z0zs8pTHBrHhXLk3+qOpb+TDdtNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7850

On Fri, Dec 01, 2023 at 03:57:59PM +0200, Roger Quadros wrote:
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
> index 49ae9d1cd948..2733bac55bfa 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
> @@ -15,6 +15,8 @@
>  #include "am65-cpts.h"
>  #include "cpsw_ale.h"
>  
> +#define TO_MBPS(x)	((x) * 8 / 1000000)

Can be rewritten as ((x) * BITS_PER_BYTE / MEGA)

and further as ((x) / BYTES_PER_MBIT).

Also, I wonder if it wouldn't be better to do a DIV_ROUND_UP(x, BYTES_PER_MBIT)
instead. When user space requests a certain bandwidth, it expects to get it.
If the hardware is not fine grained enough, it should prefer giving it slightly
more rather than slightly less.

