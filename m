Return-Path: <netdev+bounces-54055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4026805D03
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 19:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECBD1F216FC
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740EB6A35A;
	Tue,  5 Dec 2023 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k6YSreJE"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2072.outbound.protection.outlook.com [40.107.13.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE2FA5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 10:12:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeR2I4tzlIXF6TWO6Ais+eS/Ahw+UAli88MHsOgyVxXd4Pgrrt86Pv1ZBTuKFk2ohErd32wi5pocswoSXiQAtkaJdl8lHwI6TSQKQbINNLf2+ftF0ExdA2q/2oTWboedxFvgVFhbVpC6ZKS/wpkbxIcKuOOXoszwnCdN13CvSBFOiWecJQY57DYq0afmu1a/BKvwFRgA07S7p4ZpE7Bij2n+3869028vkUN9/8mqoEG5WWmJaakvJMr8vseXGyhV73f9henT+yHBs/QsyqlQMPhOlla47c2CYOELih+q5SIsL2pp6J12l2f8nd9U0xgUZK6NMNa/kc8Wt+TVkHtXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJODtTmvyf0FgRsDpJCn7hQ8S2u7FRD8Ih6do3zuUVc=;
 b=EQI5/a45sGgECc9/tmmAZPrp8QX/1WM7ccs949iQPTkwUvq8qCXSx2yDQtCuwR59UGrDO7R6BT1KYM2iuFZbeYUp7YizE9EtXQdQOQWwRwqDe7JE82rbM/8+4dB+0wg/aF7BW9rhujhoRLm90jLTxIbXs6N0hAoxsTuIdwwVcy/U+jXioBXi00xfnWCbDvkMAAAuX4qIVMFsM9EL0j/vUamMR0dS3YgY5tkDjuH/VdBxy8Ycmi9g2+vsp5/04EKhaLcXoGuXaTopa96V9rpvmlpNeESSp04hkKgHSlXv0cUbCmSPtqtGqbvDvzvOKsHHbmAHM9nvu064qczZCMpP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJODtTmvyf0FgRsDpJCn7hQ8S2u7FRD8Ih6do3zuUVc=;
 b=k6YSreJE/8kj+2X/Mrq5vtyrLNu41z+XuYcJrDKqOHmTBuOgxPutnSts7YI1273ZL2BxETtu86AUmXxkE+40oZbc0Z050T7bAVPITYa7MJMbPr28jrRJkYy+uFbTuVcukUJYTcU3bj5qykpNg2ovv8soep9T12tBZU5GlB2+VGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB7124.eurprd04.prod.outlook.com (2603:10a6:208:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Tue, 5 Dec
 2023 18:12:00 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Tue, 5 Dec 2023
 18:12:00 +0000
Date: Tue, 5 Dec 2023 20:11:56 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 6/6] net: dsa: mv88e6xxx: Add "rmon" counter
 group support
Message-ID: <20231205181156.y5p57cb2rgukyjwz@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205160418.3770042-7-tobias@waldekranz.com>
X-ClientProxiedBy: AM6PR10CA0041.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM0PR04MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b7b2ee-b067-4eb5-3e06-08dbf5bdacd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W1QnPf/mVOzyMRtQjVRwwda4PI+uDov5vHnKYOX0hnGSXm+UEQddOqTsUpuYeY/C7BJa8G6JTR6cfzaDPA5BcT++Jle1uoKcb8isqWWuk4Vkiw0rh2hjdLCTFLvASzlgAYhJKbcJg6hYagyt8xRALvu18o+5L0PXopv7sNubVlrdleznkNAsaPwWC96pghry/GheN3RrvgtvCVAMqcV40yx2SBWNWSk0/AUDknAKGNeZQ1fGaRkfjMLUVm6q4ZXfB4E/JyfCcdtdiZVzqpw5SJVgHrZhCKgn3wHYFwcCaC497m3qFqghA3OWuKHngEJZ9/nqvMEhj4BX/0V2HeVXY8CCf59LSVYaE6Tn8aUdEg/e7cjH5YX5jRReakhe1w6CIitNVFWU/991Ek1FBhyUw5nRkditIFdbCGZleovrUxvrFA9MZsIAOurSQe3f6ju12iZ3L8J0cHe9hYAwue/YLOEmuVQqNqLmE1S3RffOJeW57pyFlHwtJiQ98FBVxOcc0rRy/KEpLLvxC9JbXmT/Y9dHGKzNv65VrwpZJJVS7OUBddmHHo1PDhICbL8JCZ6N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(26005)(1076003)(83380400001)(86362001)(9686003)(6512007)(66476007)(33716001)(316002)(66946007)(6916009)(478600001)(6506007)(66556008)(6486002)(6666004)(5660300002)(4326008)(8936002)(8676002)(44832011)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?87DoRav1K+tFGeCrdTsFeEREzYltHTEmH7+vHBf7/H1g9ofn59Au9ZqkcuTO?=
 =?us-ascii?Q?bCmCPsZ5GuDV/MnY/g/kzn1u0HO3XzkmfzVWDqYHEhZdNn4GQl3Wps15OLY5?=
 =?us-ascii?Q?UK3BlA5oWX/qO3W4jAI2s+AkLGxhdsKE/s7NBa21rYasLFzyeM2jZ066+0zo?=
 =?us-ascii?Q?xMcNI6vHBAevLEIRHJ0cHnltSCj43iFgDbo0+e9z7+IigfysrwpK8q3dqKY/?=
 =?us-ascii?Q?ikGjXRoF8Fzko8Tsbkpo/k9d9Dlo5NRBfHuXc2nSqE07H12z1QKC6GA48BbY?=
 =?us-ascii?Q?JB7OjvmI3+NQbZEzFAzr52Ft78P6WdbpYdnFlKn8rV9eUYSMyNhOcr3GtBec?=
 =?us-ascii?Q?Rcb4hF+MXUvG04ILXGoHNZO7QHAKVTdBCAfMXlGMSnIALtydlJa4SS615v1P?=
 =?us-ascii?Q?7Nh27IumRm7Fty/LlE37R7VAkZrMc7rANYFUn7aU8ustQATDtc2SeTJTyfPG?=
 =?us-ascii?Q?rddavcfRNqyYSYuMkp9iMkDVqfgpbSMz0nKF4COxkUfu5vYJKcd+gstMMckp?=
 =?us-ascii?Q?G4dSZVIB6qsJXpkEVxsVw1FacHGmNM1nTC8CI4eXs24vo1oqNrcc5vp1wnQ1?=
 =?us-ascii?Q?SSeqrRakJ9ffHq5aV6+DAaLphRpYLFuoM9LJjOzDUcMjEWWiBk1i3heXgiQk?=
 =?us-ascii?Q?SvTm4aEhqtjZ2Esgilp5Dk8bMjlj81EZ2XHL1d/7fY14z0Ck7tz1erRr0Nji?=
 =?us-ascii?Q?Vq0/Fm8Im3vXYytrt9hrowqAtnJyvozm3ob3bGq9GIfyhL7wT19C8d0OJjNR?=
 =?us-ascii?Q?CbljFvUaX8DCHUf3ns5KsuQQqAAc7hhdpX+NCM+T8tLyg2W4X4YDun8YyXQ1?=
 =?us-ascii?Q?qgA/Z5xqTsDm4dbqix2/YxGQkEZnQuV6RfWaQutHx2HzKXo6iGcmqr6LF2yU?=
 =?us-ascii?Q?xpF5C0a6zWKHdKp7oOww+3gJzOXuzpxEnMx7HlaXuaFizXVxCgwM08yvHbKP?=
 =?us-ascii?Q?ZfeIFNPh36WBgkRdqiyXaqRUSogCqtgqM4fxkYnCe8ur9Xx7WnZgFgCfcavW?=
 =?us-ascii?Q?NpeBKLRgaeSOOKMDLkAgJD4MhnIehDHocrEzU7m1OGWjGIOM2j1ick62ov/8?=
 =?us-ascii?Q?hT8qYXU4kdJ5DesjJqnQgu3LddS+N0iHUdAB5rVEPLcY7dEulX8fiKbqySoQ?=
 =?us-ascii?Q?4CpC6Lmsjdvkm0Aj/6w0d5ADGfdg/pPXhPDQ4A6T+onBbeBAFV8XH7kzxBhO?=
 =?us-ascii?Q?OjsV3P0KrFFpWLrcfTVksogRE2/lxXmApGvsM1s5rW73jEIAbTc+GR+Pfh5L?=
 =?us-ascii?Q?m2gqkcQLwgVe5tH7f/TjvNM9l2oOaqQ437aNxMN25VTm7WE/REuW4Wm+Scft?=
 =?us-ascii?Q?syw64Vzf81K/B9oGApOGlS4fltDolZqKkSsm9UNggHXoErJ6i95kEvWngebH?=
 =?us-ascii?Q?TXrcZNlbtgkqZ2jnF99JQI8+wWHZ8fiBy9G+gnwiqLucb+xv1uxQ9fRgzbwD?=
 =?us-ascii?Q?B0kuy+0bDNP2dfzUE/3QqWOq0sPYRhClXIJS9jtfQOLb0KzzbHJFzz223E4m?=
 =?us-ascii?Q?YlRV5Fvskel9N/bvpB2pDrpuViMhJJq75SXBpl+NKquibACrjn/T+HXabKLj?=
 =?us-ascii?Q?5SSzoKiccr7Pq4CB5Dxu4KOubhO2RnWpDz61Fh+ANaFqWr8fEKhdWWOO/0my?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b7b2ee-b067-4eb5-3e06-08dbf5bdacd1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 18:12:00.2494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bA8uLd4yKgVcWB6qew7BCvh49HafKJAo6uiEKgWcsiVDNaDAHUIV4ulsW34UQn+Se3qotQOYTpA4erX9OSXILA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7124

On Tue, Dec 05, 2023 at 05:04:18PM +0100, Tobias Waldekranz wrote:
> Report the applicable subset of an mv88e6xxx port's counters using
> ethtool's standardized "rmon" counter group.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c | 42 ++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 1a16698181fb..2e74109196f4 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -1357,6 +1357,47 @@ static void mv88e6xxx_get_eth_mac_stats(struct dsa_switch *ds, int port,
> +	MV88E6XXX_RMON_STAT_MAP(in_undersize, undersize_pkts);
> +	MV88E6XXX_RMON_STAT_MAP(in_oversize, oversize_pkts);
> +	MV88E6XXX_RMON_STAT_MAP(in_fragments, fragments);
> +	MV88E6XXX_RMON_STAT_MAP(in_jabber, jabbers);
> +	MV88E6XXX_RMON_STAT_MAP(hist_64bytes, hist[0]);
> +	MV88E6XXX_RMON_STAT_MAP(hist_65_127bytes, hist[1]);
> +	MV88E6XXX_RMON_STAT_MAP(hist_128_255bytes, hist[2]);
> +	MV88E6XXX_RMON_STAT_MAP(hist_256_511bytes, hist[3]);
> +	MV88E6XXX_RMON_STAT_MAP(hist_512_1023bytes, hist[4]);
> +	MV88E6XXX_RMON_STAT_MAP(hist_1024_max_bytes, hist[5]);

I see that these are in STATS_TYPE_BANK0 and that every switch provides
that. Good.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

