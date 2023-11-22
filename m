Return-Path: <netdev+bounces-49970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F487F41AC
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572C828189E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAD25102D;
	Wed, 22 Nov 2023 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="HH3AjfCf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2132.outbound.protection.outlook.com [40.107.243.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DE7D40
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:29:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8oPZjRnnapYTUrxSkfU5r7Ax9aUi8VNxKuO6Cf78AtUgUP56o6GwlJ6G4kWpMiBIW1GLLF1PkyfnzzSySd8nkHfJzb07zPO/weXN6Svycb9AeIGwZLdr8v3ASPh5hvAzgDnVpgEkkkNEINKigto3vBaH00znYixJPhKkDDU+/Xz6chtkWGau8aGiiOtdsM9V+lnzf9yccjNC7FxuZXofFxZB/ImIyqVh9lRuWXwAFAFwdGKZAatLrKTLV6KsbwEX9E0X+XANvtNBWGq83tHi5kFflFGqWy98TYzsI6OG8znjGrwz2rIbIhUUTfsiEwsfcyyNvzNTPx64wVadKx3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0yqJ+/s/KPIIDhLIw+0umXmUY3WX5eY1cya3j3A3uk=;
 b=B/gfBtVmOy4Ei6TnedKODojsQ6vhcSRhwvspyThevlS2XGWpiHp9sm7vwl0LWIrwzbJWW+3M76SAMLJ7fRADaDKI3Yeb+zHKZXiL78eAbsbcCUVpgIuFCtFAvya0vYdAoMFBn8enV6fJrZefOWfAjNGSRtf8zcMuW5ty8aH6jTlW3UnAiUMOLQECKXekYRmrKtLN56CsxBGsusxdHL3a1th45NqgvdanFltJDJ52aPZSbZuEPBy2EZNc8GanKn0/Z4OkItBHnXlQwuvOEh9e8cvxT2QdoTnCcjO5hwncfKbEHpnLJgPWDzPglrDVPcRZZYn4EINPy9ZvZntrQD9VJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0yqJ+/s/KPIIDhLIw+0umXmUY3WX5eY1cya3j3A3uk=;
 b=HH3AjfCf/1PiGg2xREBlhrdbln0IHQ7WMjFdNdL9ic66cOkUzTeLPEuROR2WlyoMrHbuPTACICSTsDRQSE2Ah0l57SYnaH/LCD4OTIDCtlHVLgBGLThNawFBeTsT1qJ9J2F1WRqC8XQsEWvjdyILmV8itbdX3I9aLxzJiZcv9cE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by BLAPR13MB4641.namprd13.prod.outlook.com (2603:10b6:208:330::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 09:29:46 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::91e8:b139:26e3:f374]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::91e8:b139:26e3:f374%3]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 09:29:46 +0000
From: Yinjun Zhang <yinjun.zhang@corigine.com>
To: hengqi@linux.alibaba.com
Cc: ast@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	horms@kernel.org,
	jasowang@redhat.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux-foundation.org,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v4 4/4] virtio-net: support rx netdim
Date: Wed, 22 Nov 2023 17:29:39 +0800
Message-Id: <20231122092939.1005591-1-yinjun.zhang@corigine.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <c00b526f32d9f9a5cd2e98a212ee5306d6b6d71c.1700478183.git.hengqi@linux.alibaba.com>
References: <c00b526f32d9f9a5cd2e98a212ee5306d6b6d71c.1700478183.git.hengqi@linux.alibaba.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To DM6PR13MB3705.namprd13.prod.outlook.com
 (2603:10b6:5:24c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB3705:EE_|BLAPR13MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: 2750e3d1-b43e-4064-c03a-08dbeb3d90f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	otCtA6m7KDjDXHB35Po42uY1Xt94sa/e1BrRHtBHZdq22dofZZhvTZ4Aj8hc35oppcBnBi/nWDDhS7Tz53uQqneKha2g14r2fRe+NdCaQRv/wzCzbpLPQKJ1sFSY75sScvYYf6GobegHhSH2K+AvgcKrJxHUwK/XAlHabz4sIgMpxwC7beIcU3EmdrNbgPcFmCmZXjTcVRebI6Ljv+PnFmFDlLB/gWoqrYx8IuhdQv+KkniGXrlbhPCi50rMRvZ8JrkETAcYIVx8YfsJAtMZgRAuEmxwP8GHFO6vBg5XA1IIkB09vpwes6CdEJX8fAtemOuFMMMGWu1VuM5VkZpTRs6Oxc/Fov0AOy8hH8nEWHqTRB44yLjQAQcwUYxbI0KOJ2B5jY5U7EAImcEv9h1UI79kgC7eZ8t8C18BNPn0ILVQqdjG2R9luAuANjpUTib2xgb50PElj9MDtrBOMxetcQIiLfeydLK+tYRgGz/A39xDbcfmvfn0j92Asa7BnZKdJiikoWAYNhluPYR2nZdrGIhkYiTlvkvgtd2Qk4GhM4/gueC6x4eDl/RCYhHjWjWgqyPNI3GgdhllSqIm7gjNCeXZzld9nrdmp5oQX+kE1Dvnyxo6PnKzMRNK8CgKmYfYSyj+05Rijj7ItEV4Lx1Jp+9zjvOATPhmw+atXPcHfi0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39830400003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(5660300002)(44832011)(4744005)(2906002)(7416002)(6486002)(52116002)(26005)(1076003)(38100700002)(6512007)(86362001)(36756003)(2616005)(6506007)(83380400001)(6666004)(478600001)(8936002)(8676002)(41300700001)(38350700005)(66946007)(66556008)(4326008)(66476007)(6916009)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P7Ys5iTdFp+Y4JutR8CPo4nHA+lnSpm1iuyscMdZpoDw0DhH1oaHFPGztmSw?=
 =?us-ascii?Q?/sRZ1yW/c6lvW/hDaz4ijDytPERtoL3eVoAloeHIwcF50j63H7oJ8VGrdPTu?=
 =?us-ascii?Q?dZsq63dSM3A7aWIF9Ew4DwPiAW5EHHfAYz2qx/kFZuuITTJ06Qyzihn/vYVi?=
 =?us-ascii?Q?OZjhudmYrh0BOLBL5ZDNFpQOgI56Y7LDwWVVPnLKHxfdzDtJQW/IGpSf18Bu?=
 =?us-ascii?Q?JgkPUjp+tmaLmseQzJunT/4eT6+BJTjrLwnV0DwdZoZujWT1S638ng7v/+wr?=
 =?us-ascii?Q?eyDdg4whjdX3wFd0aeuI6ugxxtMiybS6mrEGdGKhjzOlr0zWmbLdpTU3vBid?=
 =?us-ascii?Q?ng3DVEQZho/3FzrLacrFugB6Xg1bLZm+858RuZ+FaAbm6P4GH6AeLZBsMvrn?=
 =?us-ascii?Q?DhmNYrpwRJr8SVwqru3zEGMG1BPoHDYkihJbP/tBGf9Xv9l0UVX0ztTeZLUg?=
 =?us-ascii?Q?SYJRkjKftXO1GKneyWPhfmA3iAAr5X+SzMH/90FVys5BOOXf/8YPVmBCSmTc?=
 =?us-ascii?Q?+/f3/+sni0vMVZq6yUSer0G3cyPRy/tfdeEs0DwmyBuPLnvK5NAViPm3zyYA?=
 =?us-ascii?Q?8jZUSOqOX3BmYgKQheYm08bjSGydyGHTgGJK4YkCPPN7yX/O7HO1qzvzYG8c?=
 =?us-ascii?Q?CuZ3CXMZvblEWbY/y4FDgQ0Vpc00A+g2wib1c2nRDg9VMTzB2QSHgTsSPXUB?=
 =?us-ascii?Q?PwvqY4loRRsyR4cU94sqz6EWYinTcGtZPN8kvuWZ+C05KN6+3RcclvYB6DUf?=
 =?us-ascii?Q?P/YlP0p5TKOvf2vM4qsrxeX6fQDCWsGVx18BJ8D6WAoo/m/71S8J+8+cbb7A?=
 =?us-ascii?Q?1ke/B6xTL78sAt1Rp/f9X6RsXI493QS2X2Z1Bb0XnbzMcu8Xh7qrQXrYcR8+?=
 =?us-ascii?Q?GAL3b7xflmLJA0fi6obGMNqrT+t0pJFpbB7YZ2LfUCXXsJK4nbSav5owmZsr?=
 =?us-ascii?Q?U9Hxpqw6aeeZuM8Ueb3zBqOsh5UWB34AB86P+XJITqIXw018U2ZpeRib9wlB?=
 =?us-ascii?Q?sBmDYZBoImfd+oLyzHqybH2fFeSNJ/ejsZbeG2RBMMrVJZHiROSO8+3B/axr?=
 =?us-ascii?Q?EjnxQp0xicHYpRNMCKd5sYsqLDJhMkfmcwpjwNwuzFvx0vdrwBYGktc+KGmD?=
 =?us-ascii?Q?5UMp6E7x9N3+8uA4eXv2cRgGqjLg9P7Jo2Wsk0KoxSV2BguvOqvEw3SLGGLo?=
 =?us-ascii?Q?+LG2xL/nl8+mdFf7rUdEZrpTPcc4GcLu1ATjJrrjGV2oPLYxy9dmQEk+/TdK?=
 =?us-ascii?Q?CLN22gr6/BisCZFqP1q8kyMLXEsObugYzWwbz724IlvEmEVJq0VCn5PQn+Pc?=
 =?us-ascii?Q?k1MUdiMJcBwj1FKdactqcgc82hQyEA9b4ynPRylTF/YiYnIPpGjbZwWwIjou?=
 =?us-ascii?Q?g8UvDevBs9UEDZYLZJIzWXhujiBEBAjKFc+xVbR6MqPUWF/o/DnSg97tOpM6?=
 =?us-ascii?Q?jgusCD3ieFUxkSWfFxLsaMfHA8DHYMJStFvwq+9hDak/5B1HzDW4Xv8WgYQf?=
 =?us-ascii?Q?qa2HTCBxKD4oGageNXJSerm38Sszf3h5m7IOb9lRnu9lgaAYpPNwHszUbR6l?=
 =?us-ascii?Q?m5lCfKUv8e8EWJne35yC2JHtgvw7dVJmMFPBy6oz3t0hPrff0KZvYvXuzPUZ?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2750e3d1-b43e-4064-c03a-08dbeb3d90f2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3705.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:29:46.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iQrHHiHvqi31u+0i2K4URRsqJAD9BSJCo5VdHLsn7L74s7pMT219yd88ecE104wqjlw6+ZalNQ8wsQGJv4VevDCgFbWPam6Vj6gHMeh/4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4641

On Mon, 20 Nov 2023 20:37:34 +0800, Heng Qi wrote:
<...>
> @@ -2179,6 +2220,7 @@ static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
>  	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
>  	napi_disable(&vi->rq[qp_index].napi);
>  	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> +	cancel_work_sync(&vi->rq[qp_index].dim.work);

I'm not sure, but please check if here may cause deadlock:
 rtnl_lock held ->
 .ndo_stop ->
 virtnet_disable_queue_pair() ->
 cancel_work_sync() ->
 virtnet_rx_dim_work() ->
 rtnl_lock()

>  }
>  
>  static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)

<...>

