Return-Path: <netdev+bounces-42952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 443177D0C74
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673F61C20E8B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA014F97;
	Fri, 20 Oct 2023 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dBhhHTbw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2F64668E
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:59:01 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94189D8
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COhB80daksncZL1wkdX7KOfFMITGaRYLYlsaBLq+XYGu0S+PpSrXwmc1nNnGd6g07b9iidSv+OtnpyQiM1jWNbrmOa075R/B3o8typKDvPEogUmgbgPBRSyOjavMQs3Xackt6MnUOKT9ZtAVGsKRSZSuoNlid0f0F6OU2AH9aHWIeYI1kIDJvv4gj+uRucGRQmNdHQdt/RBAqMrz9ZsM+4GBxgDfv9gIZe+jMeRAq2bHviqgHnqkrroWhkKBbk+/ciwu3p/8aPFlFeMyFWCxMdwGajHL1FTLEzzdvul9IMTiuPN5MK0lAFaWhWlaJXNclKcE+BSmyrN6UL0GdFEgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDKgRgEINAd+aCXe2MR2JmdW96ld3y5eNupHNvuEwLw=;
 b=O+TNS3HRHvSLvmnPTy+4ThAlQOOKYAQLaB3D1Dk8i58intjSx8EzO/brSa2rjEK6I5S+HUE2qhZtlCpcXvDdk3ziZKq04Pm+B9jnHIVIhLQmzGBsNj6t2/UUrkBThfLX3XwHCKV4xD0py/rdRA14CTX7cBcID6WbdXqJbpUd2cxsVyZZCmy+Xalpj7E0RtgkNDqFjmdqVhkjHMdhSKmFXscBihQKpH7T5Cu0gll+jcctazBPq9YEPFuXzlKDpnDswC3LHPUQr48I5cKI0dhOMkNDhA/7x7o04lUh0wp3xt9tzI0qjiaeCvecNcTsa8YEJK+BJ68YJOInz428qoTJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDKgRgEINAd+aCXe2MR2JmdW96ld3y5eNupHNvuEwLw=;
 b=dBhhHTbwHgi0d+xotHPFjSStYV45IeC0T/qAkM8HaMysEUfzH0MJzuwGrHmaCnv0LqjnJn9Z0vrqGSBWGnktV2TMGJLtV+HLlWBGDYb2spGpRQSiOJZQ1fnOe4aEbzUNT8GTlwWKOT33lPc+ZxQEcLP3E4agh3j9mOMcaEJfyOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB7008.eurprd04.prod.outlook.com (2603:10a6:803:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.9; Fri, 20 Oct
 2023 09:58:58 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 09:58:57 +0000
Date: Fri, 20 Oct 2023 12:58:54 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew@lunn.ch, paul.greenwalt@intel.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, gal@nvidia.com
Subject: Re: [PATCH net-next] ethtool: untangle the linkmode and ethtool
 headers
Message-ID: <20231020095854.6ycrqx5ppdztgq2x@skbuf>
References: <20231019152815.2840783-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019152815.2840783-1-kuba@kernel.org>
X-ClientProxiedBy: VI1PR03CA0067.eurprd03.prod.outlook.com
 (2603:10a6:803:50::38) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 86da51c1-4384-4d16-8cab-08dbd1532d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sj1M3HvaYIPIaFmDD7UoAw3ujZqsr/DA2Sqlo8BdQxTJmoMkJUfpfkUC/59OvO4fxHlL0Uhq/rcCz82auAV2UIXv4J+0uNLuj+WzI4rcy+WROGkWOlLt6ECsHTQmJSUxmA+weyMTuPs46GzMUa2gKT9bWM1wtItCTrx0h1jSk6LfOg4dxc/dWxepsfovy/KhjmZwe71RV3JDzttPelH78Eb9vXEIhrLp3FR9p33DhsgKc0WYLD0brBpp8zjj/MO3cGX+jidds7aeyBvLg2V1BYtPy67pzEG0Ln4ux1oavzhtskXGaHV6kHct338+MJQt3gA3EOYERl3w+RilRt24fxPr99Ug/66CvMmXQu1QteBH0I4a54E7yZBDVepu0RqGL9HcElIu2T2nLh/IW2MBWYoDqhl0EzjaSl7EIwLQOlgWdSqxc/ptA0gJGzAExdFYG8CR5/BQbttwQjJb7ePLCvNmnu8In0MKLAFkrpLK1jG5rJ7cHmeUB53E1t55aBCWGFOIvUt3rl4/juDNkQ9qn45JVqyp3L75DJJncligWnDIlphtuD95SzHFCVWFSG/e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66946007)(7416002)(2906002)(6486002)(26005)(9686003)(1076003)(33716001)(6506007)(44832011)(38100700002)(6512007)(6666004)(5660300002)(478600001)(4744005)(4326008)(86362001)(8936002)(41300700001)(66476007)(8676002)(66556008)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rnHG9xDr87fC+TdM4fYhMz4YL7z/MTy77gaI81IA+tJHQCh4O3N7tzQGAwl1?=
 =?us-ascii?Q?hHRxiNWI3uxuCnENpEdCuOGaCM3FSv2nt3yAlpvKvlBj+qQB8gNR+aDYv1p8?=
 =?us-ascii?Q?1xFItPFS3zptwiAXcF33knsEc1XIYiG0CUyfDtOK2VQjyrFZbnVUGlpBkyYA?=
 =?us-ascii?Q?fW4fJHQD1OtRYGE5YPEK9iE0lUETwESQD5qhFlsrDjvbZpSQomuID+h0Fg8Y?=
 =?us-ascii?Q?MFDGwphxKqbP5bF2+5XdPZOpnkne/XLk/6snY+WhXKZA9nm5rhvpeHoFFc1I?=
 =?us-ascii?Q?ihPxqdbUWFZySieV+LrUghVsvdXGRJMe8byiLF2ncvFcVJqSKZRtIkP9Dpea?=
 =?us-ascii?Q?+779l97pgJKQ5CsFGr2isqQi/Tp9QjDc+3Q7s79Kac0COcK9e9JNM0Mg57YO?=
 =?us-ascii?Q?Wedi3BWiWNBUg+GrkcNjv2VIislOLo3mKDabBPG/fudAGfV2WDvBYml6kBYf?=
 =?us-ascii?Q?AhTR1IgmE9VtzMuuL/ywy9RUvdv+VO+72/5kaP5Kvfdo5NThLfQ8UgdFt9n9?=
 =?us-ascii?Q?+AW0PoW307yaI+Mecx/itYNMpHqm1n0rtjuJYQD5rxWAjKXsvFwuC+71vANN?=
 =?us-ascii?Q?a1vUN/My4Swwqg6O4mM/W9cr1yJ1HM9YC7f3RCFwuWTCb7htp/uTBi29d9A9?=
 =?us-ascii?Q?tpTsAuIB39VxgNeAB7lfM1Wbhxu2n6EG/vlL1V9WCJAjx2mO3XMAq+LWRN0P?=
 =?us-ascii?Q?eT1HmPeHn8rJBa9YQmh/4BBunv/Bl5q7dik3LMbbQWrtf5XbpTa05qJ2pmP2?=
 =?us-ascii?Q?TSpUSSFbb/CYthi/QRDPRL501aE52AXosz5Y/C2sCr0TqOhKSjdr19dwF4br?=
 =?us-ascii?Q?qWJkaq+dUOIomF8APmPr+Vnf3rc744m0w5Ode/CTJqZfYtSrSZ/uUEuWL85u?=
 =?us-ascii?Q?GgOhaamHtdJGV9fdPqDBYscyzeS9GwhEsWTf2Hm+s6k/TCeKSo3+b1kXZLOl?=
 =?us-ascii?Q?5ziqCOQQBNBxFbppEw8tfZO9E8sIRzA6DhI3m/FFApHCymhjBP55m/FXTb0A?=
 =?us-ascii?Q?vI/vYOGekwTDrdJ3Xm565bzZVp8ce1YKFp2fNFP450uDm3QMuz2A8ze6PyXM?=
 =?us-ascii?Q?V0hTnUBjVJ+v1Umpm7FUC1jCMGXmWzTF1zjiZC0qtbT3Q+YjPl7D/8rv2g/N?=
 =?us-ascii?Q?o8+YYCz6EacZXKJreKHzFD3uqUdbFCQ9fo/+T6Y+96vcsaQm1gRLjNmunzEZ?=
 =?us-ascii?Q?YzTzhuDeNJV/Y3W58Shk7xVqVyI7huM9Y0BuU4X513Y5nC32rw9uP78ZYekn?=
 =?us-ascii?Q?0c65orYPfpixWrIap+/x4KU132m4ZCOSRCwjDfkkSmUbMUPCZ8Qc6MdXno/7?=
 =?us-ascii?Q?eoWvk7Grqo7JRo2QCn9jLBuWEVCWr2b7o10YwBOsQrEzrfdok1WRRrhxZL/6?=
 =?us-ascii?Q?Jcz4rHTD72Tlgq/mdDbZcmU9iFJJdg0yQI3m7eUJJb4jdE6SIX+PnbfnT4a5?=
 =?us-ascii?Q?6UYE65dV5fc7GIu050EfnzpZ+5q7NKRSB8I2s2H1cACuz87Vip5R8qMRFl+s?=
 =?us-ascii?Q?6ctsPxtaK/5fujpssdqiVbSUw8oAnDX6w8BoGYuvlpAbQ7vDa/Vphe3Iooj1?=
 =?us-ascii?Q?NlxlTAdHzmEPsHqxJ68XMW9mlOOitoYu7ugeXlA6RFnl8wiToJxpSuAedpHz?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86da51c1-4384-4d16-8cab-08dbd1532d42
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 09:58:57.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBBQAf7s82/BHM4LVwSN4KVuK/wTLd9XrkHc2a6EQreeCcPhS+k1WM02GZdLMyfx7usGKuVUrYP+u3QtetYRnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7008

On Thu, Oct 19, 2023 at 08:28:15AM -0700, Jakub Kicinski wrote:
> Commit 26c5334d344d ("ethtool: Add forced speed to supported link
> modes maps") added a dependency between ethtool.h and linkmode.h.
> The dependency in the opposite direction already exists so the
> new code was inserted in an awkward place.
> 
> The reason for ethtool.h to include linkmode.h, is that
> ethtool_forced_speed_maps_init() is a static inline helper.
> That's not really necessary.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

