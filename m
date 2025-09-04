Return-Path: <netdev+bounces-219946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D029B43D40
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 161F47AFB1C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD691304BA0;
	Thu,  4 Sep 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="faaCiUuf"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1B303C9D;
	Thu,  4 Sep 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992718; cv=fail; b=GNeBSo/evz58L/iBPJgLiRUciKZn57ga6VI6DkuVRb3CVHL6L3VCDzJD/BUpSSxDzkqB2JtYKQAFXOPWFTxDpzBeKFtkzG3bVyS0Md+XXXluAeK1kQ1XORiXvO84xODzUu2GOHipV15sj2SGqeAC58wOlWXworu23UaSUnq85h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992718; c=relaxed/simple;
	bh=vumGXdrt7WVetpB2w7lSQrWbZSc3TOmGK+n1gz18/Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B6OhiD2xoRu9U/CCqQ4kobjQ0dAURxkjQy4sbJwX6ObvJCPRNQn4HucxHYXExjGE7fcI/u8m/G3Fw7P0Wb7cda3djKPb92JGwnsB2L5M3sUwxu20wtOBT3ykoChN+22lHDIzGr/xIeqGbtpUAofS6yvVH735tp53+Lfh8f0MoNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=faaCiUuf; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxGJHHhiM3g66FR6oA6skuoYpHRyLx9CWQcpys3IwDlKaSb73GmEgtCe1Bz2iTlhVfb6eeptY7RIe+0SLAL5VWk7rkN0/8ZUMJiZ9oGPXhCQYa/PSwvhZuEHu8tKhRX0LH57JzB4EZ8KjRypfo68zS0aa71L/8cRqK5pBm++Xw3F5HDMRTVvffukddXNG6E2sDn5JZ08onMqqNs/LHaUIFIJeAX//n3+kOQwL9KJPBvNCm5/CpfPEmkrdejiB6ZLt7aMf3AadUjmvHTVFb8DR4q2DIm3JwZMcO9s7/YTc3/s4Uy7JH+duYTYDm881D5eH1K0lipCzxs7W54NiRfzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/e3lWvkF5EIUw4Cme47fvmvzODqZHsKbZcHVy5ucFc=;
 b=mFYTDBv2uwjhygSTbp0cERxe2ojkcbvVV/HxHLQ0sENkcIW3WqJKRIf4qO8pcr1r0pEE9RHwZgqknFNDEpwYBRx0bbW0nwmxdMZWOuFwaQNThYaFqcCNNqJq89c+BDOqEa/0yvnUeIav/bdcQeT56gUskClssAgjjqhpZAhQQ66nS1TtTNkqRGZAK8OnlQ9z+1QrEdxl6d67gjLWaBvsCpdFCyU0e+xenIdmuhBL7Yf0/+jfKXiVskG7x50CUzaxI9Gsr/72GHF8MFoOpnfmZEVPOMROCVY9fUc3Dd3kHx8Num2Pzp0KFSmzKXwGftQ0yB3twJ3xjIi3zeT8Lut/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/e3lWvkF5EIUw4Cme47fvmvzODqZHsKbZcHVy5ucFc=;
 b=faaCiUufptgXGSmVfxunAtuaXJMq1TJTNTnBZjGAXMYt6Q7FZ46SQxfuusYssnVgsiwVALGmRVinEo3TB4lpadShVHaTuEGSG3r9rUv5J350WaT2MjzRhfUN7/d783cTaZD8i5vyipAQh8heO0/eHphFWcqPLhRq7eYnauTTILPoBpuz1OiRNQ2VwM1E3A6L/Sb2Z4YgNvL1LJoDyvi6PzxmOAzqBJw5isAcMWNn90a1z/n1YursvVRhgDsED3G0nq+qBklte4wZ90niUeY5ZRLCXAwb9vW1ExObIrXhO/I0JFGPpU2HepisatM6uC3FXtlaKMJQfff4SiYn2W8CGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB7048.eurprd04.prod.outlook.com (2603:10a6:20b:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 13:31:53 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 13:31:53 +0000
Date: Thu, 4 Sep 2025 16:31:50 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xiaoning.wang@nxp.com, Frank.Li@nxp.com, yangbo.lu@nxp.com,
	christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 2/3] ptp: netc: add the periodic output signal
 loopback support
Message-ID: <20250904133150.shxehnjfz2qpl2dk@skbuf>
References: <20250903083749.1388583-1-wei.fang@nxp.com>
 <20250903083749.1388583-1-wei.fang@nxp.com>
 <20250903083749.1388583-3-wei.fang@nxp.com>
 <20250903083749.1388583-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903083749.1388583-3-wei.fang@nxp.com>
 <20250903083749.1388583-3-wei.fang@nxp.com>
X-ClientProxiedBy: BE0P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6ca6af-06e7-4313-686c-08ddebb768e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|19092799006|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?soVe7eg0zJxidxxUFAyJrOQaYQWygIPh9zWqb0/RyxgVQv8IoNjQv+0TJuMu?=
 =?us-ascii?Q?abBn00lHZMdJaRMXP6Zg6toSh+euVrgMk+YCOJ6euPdgCihbUEExHIpl1duz?=
 =?us-ascii?Q?/Of/wuT8Tbu/OKDsBkt1CXBYJHqWgFALXBVKnaod9HmlGb3wIHcxAtRUQ++x?=
 =?us-ascii?Q?gZvK33jRYZE3m/Nc7/b3OhpxXj+br50xBc2cJoYBIpQTkoQMDCwFsLjEwLeU?=
 =?us-ascii?Q?M2ULMRJJI1kCiezTHD4UH1Ua5uDb569o/AZsi8DO5nfIHSYn2QL/hphJeRxT?=
 =?us-ascii?Q?Nt3kRwaRl+R60JDH1L1dPMfH1SMSY3C7PxRJvlgFv73qNDeFSmBtT3c1R54l?=
 =?us-ascii?Q?yylAHda0DAljLDe73x6Kb6IacAamcOFRteAXJ5NKwvm4X2IRU0FDKNIdxp2B?=
 =?us-ascii?Q?5PWB3X6dLDu0R1iE6tfF7t9SgE4UmdroGUkIDj879/XGAEwF28hxACa3hrEQ?=
 =?us-ascii?Q?2HSsv7Prx8yiP/ugByEO8IypQdEjWpoLkOqBhRVZoSrKC/SHDb//jhz/NXOG?=
 =?us-ascii?Q?OeQeuqHaIzuQu4W7HtYSsUBqCSabtO7LOXizJgH2PSLdvPHnCZ2+X6UVbWdc?=
 =?us-ascii?Q?W/VF1GSupqzxb8mphM0G4EcfZcSB/rkksvXlnHXk1HjctNoY6N1x7Qh+aohA?=
 =?us-ascii?Q?jXkCdpig2Gfg+cZbVbWRSp9VMIYfi3Cvl1ET0p85p8ncDCVx8zDGVBTDD9Lt?=
 =?us-ascii?Q?RSouDihQoEEZAnBznnfyslqrjLEUVWO6THnSR82OKRuBcoOyYhUry1+7FwyY?=
 =?us-ascii?Q?iALu5lmCTUUL4RSJTJEsWdXW5yKNTqua2cjZbq4hPGl2pNixN80vAE6oxzKo?=
 =?us-ascii?Q?CwvXuJ9SZWEn+7MehK6qnRPeUsYcix2VDanDsBiLPUGBsgUTkjkKiIW9KS6x?=
 =?us-ascii?Q?FrbCPEoC6pIATOuLKMatT0b+djzCHfJq5mR3xvsFAN4OSxNvH1aWo3yh3Bpq?=
 =?us-ascii?Q?HdEzGMD1uneEssxNopqBNzeEko7zcTUmYzl9mtUhnnh5fcgZhNdgxRP39KBH?=
 =?us-ascii?Q?FL+vVUtxg9iM22aIXlaL0athB0k0LiSiiY+w1MgAnAnziO7fJZPmYnFvrNSp?=
 =?us-ascii?Q?HAOn+CV8UuyUgEGZTbYqD7yajA6j5LD/vtCcxpe3lfoRz3aouYA7cEg40sS5?=
 =?us-ascii?Q?F8UwE3X5zqcMoiZPgkVB34KBHwbBLel5B1xgpNw9HLbMuiU3HiAfgrEpk6x4?=
 =?us-ascii?Q?OtWey7l3h03Xj5jDopwwddagJhib0nLOT7et+jwtnX/WDyoOMbrPS8G7/4kn?=
 =?us-ascii?Q?1L6Bh0e4Yg/0HiYlff6d6Q7TJGO5i8rr8XbOioOc3LwVVZwgOAXK6OoBiWOu?=
 =?us-ascii?Q?RzypZcvyJ5HeU3dN0xBv2j8vOVg8wqc9EluNkj9bo1mp9v658Q7CP328Nd7s?=
 =?us-ascii?Q?4Qexgw1TjDhn2fx3VEmEMB7PFbAihM0FLGoNbkFhgHi66ryUB7NNo2e4in5Y?=
 =?us-ascii?Q?OgztxQtNek8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(19092799006)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8PW/Vf/xk16Eufmrp6eCMIqE2cxoC5vfWuj+/0+zuDZWjTTb4oDbHHj3ng3u?=
 =?us-ascii?Q?r1Y8Kusj1TeyI2oNXCVrHsWMOm9Epkp2U4m2E7+vZE2Lk98q65AMlIuckDki?=
 =?us-ascii?Q?tabqnv4Le+puOTlH2381lHcWER9dlSbgLe1QhUwuANSjCcEjZjfupkAWpYp/?=
 =?us-ascii?Q?AzoLXbbGGJJL0HRIPUhTkY0MSKJQg0UDWCxtOoqgPs+ia1bi2pqe2euJ8dw3?=
 =?us-ascii?Q?x23zMqJU8sWMsqWZg9NS4P5ZGb5JHPG2TMeuovXjfTyXVb92OelpPy4y1sCm?=
 =?us-ascii?Q?q9pR/3TKxftUS7dh7dkd7g4Wx+RZ2O/6DZ46LTv5PbT0bQF3gfeXKrum2fI2?=
 =?us-ascii?Q?RGwy/dhHO0g4NJ+dQo4OBW6tqywSi5x9FRdBQHS/LrBPvKgAgc+rc2gr31Yg?=
 =?us-ascii?Q?OHfp2Kyea1KsqRsPLFtPhuHC4mTCkYdMTYJaDm8ap7AlMtHLTDNk8//36hcJ?=
 =?us-ascii?Q?OtSQzXUGDs5JIf7IDU3KglL74zefZbpQjVt0wWNLEoT/vgEEa4QoTmIKrTSu?=
 =?us-ascii?Q?V36RimQtpTWQpWUBmCLJoHyld98ITBYlOTromMrjOEbQe6ytJ2QbjBgT/tLl?=
 =?us-ascii?Q?fJcAKNJoH5wSpUSblamY1noM0tqyOT2IrUiVcCVNN7Hn01FadpBViCf8+PRR?=
 =?us-ascii?Q?Yfb7BhoNDJgN3pBp2+igTTF0UGldyW7CR7RlCtVLcDHMVaPizDX8AYxfcFwC?=
 =?us-ascii?Q?IfTqPPsBPSqlkEVZOW0mJ5CP+h1PioHYm6IF9qDoNyfeDxYJYMdFokknm7mU?=
 =?us-ascii?Q?XGeCCjKk8cIcPrUQr895paF4lsdlU/O8U7s2a6011sK3yRTNLasH11J7aYuP?=
 =?us-ascii?Q?cqQ51HUeHrlWi4euFfcBrCklwfqOC65CBM6vrDqIlfYuSTGMr7emSywJP3Sl?=
 =?us-ascii?Q?my8DVMiVzqDAVno8UCpOkT0JPhRsXkloXw/XlIbP+6eKECbTB6zhVtXZOayu?=
 =?us-ascii?Q?b7a6KXxzQrlPCkGi1ulUVIkES2Nua+EEnPGteFKiHy0pFUT3zmjJUtpfDFZQ?=
 =?us-ascii?Q?+AB2ClbvPyVvNdz1oSDSGFodnfGbIYZjFk+XI3Fc2Ozi9IWZulTkZVRWCSLb?=
 =?us-ascii?Q?nnk0kuIPjDhzgUwWUhKCsrjz9V0/DsiygKDdciFXBsSwMlEpfl5lCEu7IJMS?=
 =?us-ascii?Q?qqPwXQ7TovZ3gwX1e5WdJR2tZ+mSEJi5v8EwKDlOW1CgQtLprAMftPK37aO4?=
 =?us-ascii?Q?lR6+PPGFFjageEmpIa2srvf0JeSioK5RXNgHOaxdiIz15kjWRrl4199LCtbh?=
 =?us-ascii?Q?C2jpHtsGQYQac+2uSciVQ+RMMmkhPOEK68J/Tg4c6BX1qjPJ9TeezGXcJ36F?=
 =?us-ascii?Q?rbb5VDmkiXN+t99P1ZeqOWhzLP+1mdnJ+Xc7zQB48OymIMJfwMPfZjIWsjks?=
 =?us-ascii?Q?e/hMuRLax9Ab6qGyTnjsoTV6YKQgsezzogIbCUtfs0ArFJ26OmHSr/tP8Ds+?=
 =?us-ascii?Q?92uQtIFEvg5b5qqpdUGiFH081NUrp6yew1bWZi8xQp69D9oImg5J/N3uw9/S?=
 =?us-ascii?Q?rg1sM0UlTQiX/geof4IC/quGOCmWFjqVfZk3NQwezU8CaBy4gsd44DmE8Vsi?=
 =?us-ascii?Q?PaGQtCldZy93QTIEV8zo6IhRO0K+M20KIq9RbIYm8Z0L8ISoAYIb16JOPnIX?=
 =?us-ascii?Q?wAaTWXyxWTa4ALeKYyfMsNlDafH9olu55qEOtZirq1uOVZhtgOb6YkUbsYdg?=
 =?us-ascii?Q?kJrYxw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6ca6af-06e7-4313-686c-08ddebb768e9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 13:31:52.9486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSXOqheS05Ba/NL0XnxGBJtyW3YFDWWLqjm59H3qCPBbNpT+Ja/9wS1rn85fyj5x0EhfwKkkDyAeuANpc8q2kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7048

On Wed, Sep 03, 2025 at 04:37:48PM +0800, Wei Fang wrote:
> The NETC Timer supports looping back the output pulse signal of Fiper-n
> into Trigger-n input, so that users can leverage this feature to validate
> some other features without external hardware support. For example, users
> can use it to test external trigger stamp (EXTTS). And users can combine
> EXTTS with loopback mode to check whether the generation time of PPS is
> aligned with an integral second of PHC, or the periodic output signal
> (PTP_CLK_REQ_PEROUT) whether is generated at the specified time.
> 
> Since ptp_clock_info::perout_loopback() has been added to the ptp_clock
> driver as a generic interface to enable or disable the periodic output
> signal loopback, therefore, netc_timer_perout_loopback() is added as a
> callback of ptp_clock_info::perout_loopback().
> 
> Test the generation time of PPS event:
> 
> $ echo 0 1 > /sys/kernel/debug/ptp0/perout_loopback
> $ echo 1 > /sys/class/ptp/ptp0/pps_enable
> $ testptp -d /dev/ptp0 -e 3
> external time stamp request okay
> event index 0 at 63.000000017
> event index 0 at 64.000000017
> event index 0 at 65.000000017
> 
> Test the generation time of the periodic output signal:
> 
> $ echo 0 1 > /sys/kernel/debug/ptp0/perout_loopback
> $ echo 0 150 0 1 500000000 > /sys/class/ptp/ptp0/period
> $ testptp -d /dev/ptp0 -e 3
> external time stamp request okay
> event index 0 at 150.000000014
> event index 0 at 151.500000015
> event index 0 at 153.000000014
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

