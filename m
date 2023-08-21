Return-Path: <netdev+bounces-29307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A657829FB
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D428A1C208C5
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFCF6FA1;
	Mon, 21 Aug 2023 13:08:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF44A29
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:08:41 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2080.outbound.protection.outlook.com [40.107.14.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13B68F
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2E8B4VUJbj8Jyuecu5h8jbJmOBt5IPvcBuGDvLKZxqvGRGp6owFDe+Z8IdafWpZX3OyGXEOQ1ph2dz23SHT9uOhPnGZIhvWiR23R6yjpPh4K4Dx6rwd5w6+AtFkXHCwcJhGnrt+ySImbohCQRIL9U4HGdLQfNmnLHmUGg0Za115rzBbDGxfQjD5mN1d8nnQRyVrdfM/QqQYEsgGY2Pi92aUy7gCLvkiGCiHxjx3AmMJ1fQVfBGk+tfk/W5It0Xs5SfDK6aXMhtrW9eBiMhznyJb4/k4vRug8IIydLz61HNBki53kH8uY0TNOLUlFhGG0745ft8WY5MPOz7pilKAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/WYpgTR7ieHQRGYq728M/jzzwZbeA2PhV/k2S23AnE=;
 b=flHvE5Pt/P/U/bRSNUD43t0XFE92HvQkV6UAh4AmTA/1pPvgPOpCNgPiCzMQ4TAq6a3dL3dLVgAzGLvy5AfgjsXvGl1lUy3PhevUDbJL/BfnT0EZwh9Y6ZAKxPBJH7XfxNdhsr+VcGqaR6VQ49HbYESj9ob9BHEjFr03mzLFfZIsgsufKDLeEJ9eA9R41Ib1oh0V8se4RoSPOckZk1YmVDHQee+WZDTDj3d0u6c+qTMNyNIOvLlHM8JpGxIngIJkDDx2UE24iQHuZ+WOtlvuwbZvFrcWtrhEjqkOMIxCJKdf4pm/nvS3ErKRqKL667nsIXkt5f+SmrjuZ94Sz1OKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/WYpgTR7ieHQRGYq728M/jzzwZbeA2PhV/k2S23AnE=;
 b=S3xUipmuYWt5rKnlgllSHXaGvbsQolS1wmkpTbuppAgEVptadN2/bralX00PvqLm5pyoX4opGO+9utHxs9inwklYBqxsvrTXwSDD/inCwHZioqqsKp38XDaBBTQAiBx8WfUDdqpI4Fdz4IZtKvsV8ZsXr+Oo0G6rrHtBM7N9ie4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 13:08:36 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 13:08:36 +0000
Date: Mon, 21 Aug 2023 16:08:32 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
	UNGLinuxDriver@microchip.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, colin.foster@in-advantage.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mscc: ocelot: Remove unused declarations
Message-ID: <20230821130832.5xr7wcwsscodgvrt@skbuf>
References: <20230821130218.19096-1-yuehaibing@huawei.com>
 <20230821130218.19096-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821130218.19096-1-yuehaibing@huawei.com>
 <20230821130218.19096-1-yuehaibing@huawei.com>
X-ClientProxiedBy: VI1PR0102CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::40) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBAPR04MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: da417860-585b-49d1-29c7-08dba247badc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yObpqX0LtRg5V8z4Tu1BOrwxJFAZMudlqYdotyZ+3WtUlXinxDM0esL+wmXvibufgXGpGvA24+j9UmLPCPd6Td3JhF9L9CD9GtXFNJxqJdxD/PX2qzQ9+iMUAFqrLry0FVX5FJRZl0r10xP7enIpj26yXveKacbGIRtpZWvJOgeP/11bhFhUyY+K+srPX5rR/5p0p65AEVJHj856dbM77M2e4SE3lLOqSQWpinsJwB1vfembAadlWctcJt+qL0fnCjxmPlvR/wGH8lx8ueZyLINwiT/bhgC/pDGYOp2/iGxphNbLJQLcBfOmxg4HDl34P9+/2anNWa54g+ifFnuXnOUa8ixRIycTO8P8TxK5MsY4F/pkH/+tiikOsAWSH4k7q5Jjsxi/bSE0QBh4ALAQ6paLzyAKe9M4YvQW0UpIqjgzHwtdSGDDdPZy5y8Ree11AQczhsSFB3AEE/X0XtC/VrBkvucdx5YnSAvI5AYtsJohGPSEIytrLPgmHUZaoYKxXzSXK87nhb45lEjn5/UT0MPjifT2nGgbrfC+M5h4/fRrD8FOIjG3Afxv4XVFH3y9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(4744005)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(44832011)(26005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(41300700001)(33716001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ME+5dQPRYAMPUXZuVMzXPaVfK/TSu3pMSfukS2chqz2yiW7BuPBQ//Z6YOwr?=
 =?us-ascii?Q?loQ5zItkruaUJ3u0Ov6X3fo5v3CkA9CnKpzAfNGMK1X3PeUGGh87PNVDKUR+?=
 =?us-ascii?Q?6n7bue0Ijz3fn4GmucqHzc1bYItVutTHXzyCBKHJ+NURxPyll55SPmWnBdvc?=
 =?us-ascii?Q?WTvN03fJlgOfXtHBXz9qJTUMhAHw2i4VOe4FH3fSlcLEKRucfQOqwBqrDFo2?=
 =?us-ascii?Q?PKd/wW/XaluALffCUuo86vC11X2WCWX4LVVLx251X8TTfTchg0y+NVBS8Pd1?=
 =?us-ascii?Q?mGZc2zIljjF2CXrA5iGVQ9ydm+5A2nhmNjjpx3QpLjJaL0Jgfxu8UM/OQwky?=
 =?us-ascii?Q?LxNVC+lceKpLjfVHzMC5SKZMFPwKnIFHDqRG3OudFS1VbrfA+VWsY/4GtG30?=
 =?us-ascii?Q?mfukcHf90L8FATCgsPvH0sf3zo0UmqW2ag4B7vcNTuq2DTO7GDhjubUuZYfY?=
 =?us-ascii?Q?dVTKLkpW/Hz9yjjUZ8D8KKWr8UDvAqaN+DWyqOGrj1bQYhIeWunb0DCeQMJQ?=
 =?us-ascii?Q?jbkc9Y37ISTu8suH7fxcxKvI3tyZMI4V0nzVyscwJ+wEMtPVL7/mgTfSeG5V?=
 =?us-ascii?Q?oSKJgEQ8w4zF8aupYkg/4+TGeMFLQEWV/jdKEs7oso17v5yJIRS0iqieDpg2?=
 =?us-ascii?Q?9Le7MyrwfAp0BlXw4Gx9WIHGx8KGRIZHjWRaidNtBFYZWjQ1z7lNSDw0oMnz?=
 =?us-ascii?Q?ES5ZxQ4KC5Rb6JmoqkyckbKtIVy7exEXXk2veCBvTH/AGiO3MvjGyLEwqSuT?=
 =?us-ascii?Q?dMvOt2M3/fhGzLdCpgLrcgfjKcfuSeCsGK2UWwVK8QqMXnUdNwOZ2DsRoNOg?=
 =?us-ascii?Q?32THwa0uJXqSCnFw32KNMn0Efhw2Potzx0u+L5XTMzhwZLRbIL1rm0C6aHXF?=
 =?us-ascii?Q?ITZDWKxHGGwtH89iriQtu+5LJPznWQk1OVtym4fot8HgJK4qmuHNWjO7W+ba?=
 =?us-ascii?Q?X2D/yDpG0A7qo3JtfdELPSyaCmTSLIqLAiO1ursbFgIzSorFvK7TXOXhDJq4?=
 =?us-ascii?Q?mejuSaFZ7mEQzimtXUfzaCOPy2vkfCqLZc91anSCuiCy2HLLR7gmS6rgimtL?=
 =?us-ascii?Q?p84TA+HAKqYuGImvC9LR4uksVdHMR9A5u/6f1Kb3BvmhKE6YGEfgmLsLNbXa?=
 =?us-ascii?Q?mBtj6J/qDi9/Cn44T0q5c2LDoTQBgUIg9HvVZ0nsEA+XFHFEqXc/Vp9p+FQa?=
 =?us-ascii?Q?nw7buLQZQnQFqcmK5pC4/FSG1zVHstyvHdpsM1s4HH1FrMaaMLClYAYIYBaA?=
 =?us-ascii?Q?O0VZClXv1+dF3wsbmVUn7kDPDqYTavCG+xi0f8uDBaUKadVE54AsTF/JX/Of?=
 =?us-ascii?Q?lSMEp+j3vSaUNfRtse/9f4+I5b0biLmb2+agYiol5DOnP3LCzxLCasOBGIpw?=
 =?us-ascii?Q?8C/gUJj1NpuZ2kbitcHAJJjGlTURDJtO23zfoeSTvEZI5Rvfpd3FsANyCsG5?=
 =?us-ascii?Q?Q+oWfcB8R9olmS+pe4ULBfAqPmdb5YcJqp1trPyuqD97/Dhq0gGoorDYyar2?=
 =?us-ascii?Q?+Yxxz2crgcF9UBGoTiRAZ8clSLWxX3X1b1VHojeTyS5QGQ/CW065938ctpzv?=
 =?us-ascii?Q?mIsKIc5oGGj9ICQ2gMBNt2TJGFAaevNFPxPofoek0DRV72nnoBIsDOu97iU9?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da417860-585b-49d1-29c7-08dba247badc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 13:08:36.5597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZOtNnJIKvD94IKpfyi3S5GJiuwwK4VZN+w+J4bfJf06JuuThnXqQw2a9BETqulvj/kSx3ojK85kWA0oSNnrfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 09:02:18PM +0800, Yue Haibing wrote:
> Commit 6c30384eb1de ("net: mscc: ocelot: register devlink ports")
> declared but never implemented ocelot_devlink_init() and
> ocelot_devlink_teardown().
> Commit 2096805497e2 ("net: mscc: ocelot: automatically detect VCAP constants")
> declared but never implemented ocelot_detect_vcap_constants().
> Commit 403ffc2c34de ("net: mscc: ocelot: add support for preemptible traffic classes")
> declared but never implemented ocelot_port_update_preemptible_tcs().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

