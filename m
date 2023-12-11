Return-Path: <netdev+bounces-55863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E2480C914
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B347F1F216CE
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C84A38FB0;
	Mon, 11 Dec 2023 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aTEh25w/"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CFDA9
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 04:11:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2oP1L4vg0QGs081R3stBohY6XXgTU10UVKnh35QsUnCxQrbE37ZE0czXw1wcICLrlbctKYc6aAz3JVtlMf9HSXLErKsHf4RH2ZUS3z4dk7CVLB35hMALVTIWW/khf0B75enoW9da+Ts2L3LqbYu6utNIYVV97+g1zTrZTKHxnHWb0Ni9F3op51IttVWjCcygZNFjJrytCBbHx/HxVjNqzFdMFsHDKXGOR+QlT905dK4pLBrx8kVnIeNEWesLgPyMBvutoH5hi2v7sDvKn/1uBV+7pP1Ot0KJh/W86oE3Itmj8++ezQimpRcYQ2//rPm2JzLEAGWrB4f0Ts72OgpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Nc42lpSxl0DEmOcVo2laMRaSNReNU5WmxnsivEscJg=;
 b=TEI/sA8GcxCCGJpAzk2wu+6DFQiUtzTJpXNNkXD/HBd5erta401+OGKWhhktkToW9JUGne3Vv9HFojLp8yCKev63VfangrwXcWFvzDmYlKpBppHz/BOAVo47qd2tlFr6aHgUtMGUyRKStRN/kyk0d6s5lYzuXR/kFDbzfJ5D8ASYeI/EOHHP3c162EYFeGfbb5gJ4erqVLR9rZKm6vJpTvUGBinOjt2OX1OKR1e8vaphaiDwNoKJEhVL9AYMKFMBi9NuslhV6QOgiofiNnZFwTkvaW0nz0ImgQHZUI2mQKBjAUfHym98Eu9T4aJAr7FF+ahCuDcPgUON5UcwrGDWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Nc42lpSxl0DEmOcVo2laMRaSNReNU5WmxnsivEscJg=;
 b=aTEh25w/k2gII3nqFSaAuZG4IH77t4QW7wxqeqa1yrdACPW/lBAV/WplZpHt0baCpRw47fInQ4qdtvMEpHneMvn0Nb7lm1ErW34zJQKkTjpeIij+kd4Ykx4FZJL7H8T4orwPnKhYV5+dcBdakWzJuEf8gYZCl9Xnk/8ZDho9VGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB9492.eurprd04.prod.outlook.com (2603:10a6:102:2bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:11:09 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 12:11:09 +0000
Date: Mon, 11 Dec 2023 14:11:05 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
	vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 net-next 6/8] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Message-ID: <20231211121105.l5nk47b5uaptzhay@skbuf>
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
 <20231204123531.tpjbt7byzdnrhs7f@skbuf>
 <8caf8252-4068-4d17-b919-12adfef074e5@kernel.org>
 <7d8fb848-a491-414b-adb8-d26a16a499a4@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d8fb848-a491-414b-adb8-d26a16a499a4@kernel.org>
X-ClientProxiedBy: VI1PR10CA0098.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::27) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3ccd0c-8a62-4eee-00e5-08dbfa424228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ffxO4FPXu7LcEzgQ2KNqRu1G29m4Q60w2FDJPteu2RgyIt0XmhsP2uF/zBe3HzKMvnbh1zn++RKBlIqtfjARhTzz5DXiT1hQV5q4YK2iYODOM5Mv3pFbrmQadBn4TwVFTjbyASM3+x+QodsmzcrgCAX1qfJ4fbNfBMyI7qXdbW6HPRWeXY1N29CHpklrNkaIlriPch5Pjc1N6ysZPGD8Ce6nkuut0LnChC4k5DWDN26gAAKGlbSpYE94M/WNYimTVe2+6jNEC/bIq7bJTfaynfIqPNyGtYL+iwaprVsa4slMZOIolE9ZEtEzPh08+KbIjqtGJi28VqKz1y92VLC34nGDqphmzZVSeZfYV1NN6dWGQom4dzGJtGnHuy5ixV8IjN36O7e0ufZwCA2jEv2bwTESaqhWjU4xcZJq3HVVmLJdW/FdGpDEiYYEMhPEGFk6pf/FeDI6XnqVoHc1OTfwnCLNNK9z9QYEQdaW2XH+WmwrgXimrmrFycMAyahZvb2LgsVtjcsuaWLEIaOZjkcVumMqBAI0gkKKjUtNeQ+gV408+1F5CHVdpgT+q5ZaQk64
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2906002)(41300700001)(478600001)(6916009)(66556008)(66476007)(6486002)(66946007)(7416002)(316002)(38100700002)(6666004)(86362001)(4326008)(8936002)(8676002)(53546011)(6506007)(6512007)(9686003)(33716001)(44832011)(1076003)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/MmsZKwfg1/TfquGapkLXocRYaYCYpVxQ2zQ2abXIvlaUs8Sfyf1j5Y7zeB1?=
 =?us-ascii?Q?NhAOChkFp4olTbwmXh9yaLQt0SN3j9mbtZJUEPYlCTVLgqhxmk2fm6DVxvij?=
 =?us-ascii?Q?+f4awIHW9aYvqRlwygmlwse1InQKXQKML/bf3G1MAVajKZPQ61R/VFwQuvFm?=
 =?us-ascii?Q?zUOv8Aj8KyyMsF/sBEIgYXHLnB0VbaRd/ExAuM1dFGma19CDJWXWiw6YGRQE?=
 =?us-ascii?Q?cw3R+Y3XepjvORyxfAS9D4od5lAjB+V+H84Nf416/9y5vn8b5sQNyvXob+9U?=
 =?us-ascii?Q?CM/h60oSyXXvOfde8jA1BdS6tU3PC6xOvwK4Szz1Oa5eidtUNKGtDLSMF6SM?=
 =?us-ascii?Q?jGktVg2TK55UKZX6eHMt45Cp6c83Ue+zOb1m7H8vnQOG5LUhWHggCxZpTI9v?=
 =?us-ascii?Q?WIID0GAxG6yMEpeqn6qPHXyBWJf7wtyy6e9NvV1Bu/cIuQp8hy4o8KLTLlmF?=
 =?us-ascii?Q?IZ7pbutggrfpGA99t5/BPYr1PkJKgsg1s6KCiN/Ro6f9YxEneXnsWH/+XEXe?=
 =?us-ascii?Q?dSna0fBlRb/ihPjHCk0wTsogwEL+DJeERQeYq8P/FSXjqZMkCwy82MVx3j79?=
 =?us-ascii?Q?Q+oQGJ8PINRTVeXSplZ1q079Ode47lkDpHsegdbO/a1NWdXtkdsF+AVwS5d0?=
 =?us-ascii?Q?1F6jPeWBFe3QHjlznaTmWJFHd3vcTjNUqhenDMcbyXGB+achzFxI10N2ISCC?=
 =?us-ascii?Q?TF4Od5eJTkZbcZlOHY4J8jyHvteVqJAgDoxhihq0LkrBVyKJAfCHWekiY1RK?=
 =?us-ascii?Q?nCoZccWAcopTXwSoyJAU+u6pMpPVBwHh7CJ6OBKdx7xZ9FhRRMYYlvrIj96F?=
 =?us-ascii?Q?vPVOkhYsWzBGLCmZ1HguidVTZiDeBX3xwp9Nwbce3jxUDPscc/6IUdvUjBds?=
 =?us-ascii?Q?R8+s9TjI4EaypvqPia6d2zOPwtQD5DyRNCCdMNVLKgU2LNfMF3dQZXtGz4dt?=
 =?us-ascii?Q?t2T78SUeWzzfF8QoNSiUKjvueCoibuOASTqRQOlWsn77OO9QliVjY8WjFey4?=
 =?us-ascii?Q?wFhtrKhk7hpVzmmitPdfc8mN3W4EgQi02TvyHfECnqum2xfopPgpAoCgaIhp?=
 =?us-ascii?Q?pIWiiwEEaVZW/iQO2ug8UPb5BpGlH2d8RTPOjH3blHYSX4c/At2VcUwd4rNd?=
 =?us-ascii?Q?m86OQby+L6Hn0dePJ13lN34kHPrkIIqU9jYGtT9fFTYW91PPEnmySyfprjmb?=
 =?us-ascii?Q?Ob2ToIhdaWWM3hPnxxp3VZrP4XFPgvUAuzL8MBEuwsySNiR/paujV7Y/THBo?=
 =?us-ascii?Q?aQQk2UaBypDIwUDhxxxynjX1ZRqE8tAIxGqua64swy/x61Z1ZJ9Wu6MbtFC7?=
 =?us-ascii?Q?v2gbWejdLrc2q1s2FTlk0SraU4esW0KXE5clnTcsXEniucmSZMxJbdBZGBZL?=
 =?us-ascii?Q?I+Eu2JI23mIotbga7Od7C1JsyyYsQlcMUGBTW9Wba+5gPQieWtegxsYbPec6?=
 =?us-ascii?Q?IRdct/C142jFaOHv5C7CZW0nM6PEBmldMPvqw3fMUc2qEaXuEwpoDynAM0Oe?=
 =?us-ascii?Q?6dqflO5TlSI8NNaeMN++T/vv4sKGzmK3Z1tJ2gBouA9HgrlKECn3ZTK79VFG?=
 =?us-ascii?Q?YM1SNFHCAFofc5csoo7Vmp0QWgVf+yfMBgRoT0upH2kPCW2DwdcOH3ncBPu4?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3ccd0c-8a62-4eee-00e5-08dbfa424228
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:11:08.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoqgyhOJLORLJrkR/WW958yupxxJOLeBUuTAK52RkPE22cwpzz+c5aUkiiflzgaDDwPPQu55F9ups22y6jtP6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9492

On Fri, Dec 08, 2023 at 12:26:24PM +0200, Roger Quadros wrote:
> On 08/12/2023 12:13, Roger Quadros wrote:
> > Wondering how to fix this the right way. Should set/get_mm fail if CONFIG_TI_AM65_CPSW_TAS is not enabled?
> > 
> 
> How about this fix?
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> index 1ac4b9b53c93..688291d6038f 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> @@ -775,6 +775,9 @@ static int am65_cpsw_get_mm(struct net_device *ndev, struct ethtool_mm_state *st
>  	u32 port_ctrl, iet_ctrl, iet_status;
>  	u32 add_frag_size;
>  
> +	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
> +		return -EOPNOTSUPP;
> +
>  	mutex_lock(&priv->mm_lock);
>  
>  	iet_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> @@ -827,6 +830,9 @@ static int am65_cpsw_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
>  	u32 val, add_frag_size;
>  	int err;
>  
> +	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
> +		return -EOPNOTSUPP;
> +
>  	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size, &add_frag_size, extack);
>  	if (err)
>  		return err;
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
> index 6df3c2c5a04b..946e89fbb314 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
> @@ -100,6 +100,8 @@ void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed);
>  void am65_cpsw_qos_link_down(struct net_device *ndev);
>  int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev, int queue, u32 rate_mbps);
>  void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common);
> +void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port);
> +void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common);
>  #else
>  static inline int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev,
>  					     enum tc_setup_type type,
> @@ -124,10 +126,12 @@ static inline int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev,
>  
>  static inline void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
>  { }
> +static inline void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port)
> +{ }
> +static inline void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common)
> +{ }
>  #endif
>  
> -void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port);
> -void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common);
>  
>  #define AM65_CPSW_REG_CTL			0x004
>  #define AM65_CPSW_PN_REG_CTL			0x004
> 
> 
> -- 
> cheers,
> -roger

I don't know, does it sound like it is related?

config TI_AM65_CPSW_TAS
	bool "Enable TAS offload in AM65 CPSW"
	depends on TI_K3_AM65_CPSW_NUSS && NET_SCH_TAPRIO && TI_K3_AM65_CPTS
	help
	  Say y here to support Time Aware Shaper(TAS) offload in AM65 CPSW.
	  AM65 CPSW hardware supports Enhanced Scheduled Traffic (EST)
	  defined in IEEE 802.1Q 2018. The EST scheduler runs on CPTS and the
	  TAS/EST schedule is updated in the Fetch RAM memory of the CPSW.

