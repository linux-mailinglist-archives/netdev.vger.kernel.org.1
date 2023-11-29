Return-Path: <netdev+bounces-52129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 352737FD6E6
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 13:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF66B216A6
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 12:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF510134A4;
	Wed, 29 Nov 2023 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cTa+qq/U"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78081D4A
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 04:38:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVWxsAPzbiqkbg/FGgM7XhaHUwF3Y11KRZUspBaqNdHC+SH/3GE7LhvAhDvKAIg1ss6gJTwRMG6bBcWObkNYzrQbWSHoBqMeJCHls/reYbX/pLNirzT1I9TNeVsI3+mszOhgvnid/Hq2rKQnSnQydpz2kIL14tYPcnPMJKahiXYrQOv8YJMw+qcFu9uBl8UeCWivwkd9tqGgiuwkC4hOgvdzSjhMVxLl63B/AHbLfxUyZqCe/xHUyjk9jGT9OHAI48mvSxXHstfAOrWxW045K73LpZ07oTlGNiH2RcR++5r7rO9jpQy/6IAag3z+pqa9rYVSx8ml0CRjSJP5MOjJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ol2WTLvjy/VKOicQXryLtMK0iWdj8PwDAKwupG+ZII=;
 b=ef6/GWG3rG1bflpQnwlS0FZQACDS4ckBYeCFdUYI14HmtQ21zh2F4CtOWfAtOyTy4G2MSmzx7PXav8Owojeb+t/72iCFGP3UZZtiKXbcbgat9QaKc0s2qJx+f2mFKTCjJSpSWxZsedsZkaJmMxkvjbHQqred+fqWDL7dRDRbhsmkEM6jXgPj//fA9R9xS+YCaAzEyzW/TZOfzzVlx8WAotnc/pWhIS0153brZ2vLsVp8dQ/uAlyoV0V7Zjed2Oia+6Z3EdtGUTgCxwtCEcNU8aJYSIzPxznRK0UzjHIn+gUcMbwg8yJkjsBsxUl1bQd/N5UAdYKt95aczrDwH6MFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ol2WTLvjy/VKOicQXryLtMK0iWdj8PwDAKwupG+ZII=;
 b=cTa+qq/UWUCt5Ux0ZrelESinw1zYQQrjb4Z1zeXHG6Men+wXzQevUQCY77+AZEVOw1ixFvfja1Eu5Vfgi1O8JRsJJxTFoq3/16xHQkeuu1iM2tTWiLwitWscPcy/SYxRlDNytcNRzDX+01Ml8znE2p1ePnm9zKh5v86Itb0016o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9382.eurprd04.prod.outlook.com (2603:10a6:20b:4da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Wed, 29 Nov
 2023 12:38:22 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 12:38:22 +0000
Date: Wed, 29 Nov 2023 14:38:19 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC net-next 0/8] DSA LED infrastructure, mv88e6xxx and
 QCA8K
Message-ID: <20231129123819.zrm25eieeuxndr2r@skbuf>
References: <20231128232135.358638-1-andrew@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128232135.358638-1-andrew@lunn.ch>
X-ClientProxiedBy: VI1PR06CA0171.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::28) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS1PR04MB9382:EE_
X-MS-Office365-Filtering-Correlation-Id: 7efd723f-c72b-4d7a-64f9-08dbf0d812ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PJA2v5gq8ayeHpy9buUmN8l0hWO6SogxDNAkujHzxbaNupc9ktzSkd2tldG1IJOhPPrSqQiDlw47nUR4UcFOxZzcKROXlp9eV2w/142iFpapIU+uvjjyyOqmdAvlhuMc+AZdTM0gyhWDLkLhQP4YaZ4sLQJwnC9Q2NMNoASouFzJUchrogSH4tYmWfuVnBE7kSsBEIih0CDkKeBb2pWHOMQR6hUjhT94Hc+jktr/phfOXLZ4pPTyZ0w85ygLzcdNuESB4JWZKKd20mmTCRNLfpBxQ+RNDh0clTCndMnOg3UXQmWYzRKHkMJtS8Wr7cl6TjiZkuGVOCSrkLfja0N7Lr6neYOKWB213Wbpo8gncyepcTmpQUD2+YLCwlv5mITf4QubKR8jWMuv40GZuJwP23NT62UF5BQGWoFb1JVjtMiCMlZMO7wGQxcR3ufFHM/uXoDlSU1uBfyazUT2wJA4o54RnityuI4ouJ8u1dNiptsx/TU2YD+mLmzM4pk3IBz/ipUsTlqx77RyGhtoFBTJAYurYiVQQ+pPmv98HXYwBQ4jekZSxcl4WzleyaAP/0l5x0A9TTLNn9qwbqplS0zoVBq+IkSgzFjlk4Hpyv+lT7o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(26005)(1076003)(6512007)(9686003)(86362001)(38100700002)(6486002)(54906003)(5660300002)(966005)(41300700001)(2906002)(6666004)(6506007)(478600001)(4326008)(66476007)(8676002)(316002)(8936002)(6916009)(33716001)(66946007)(66556008)(44832011)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0sCzslOtllvLfye+f2hDMR4XIyqNOLInMP7BeBYK8lDH/Ri3+uAYIFgJElTb?=
 =?us-ascii?Q?FqxzeAMKMmThvgc2OlBVksU/iQN33Q8QEQa5oJzci6F0NFwvAOvXl938oBWh?=
 =?us-ascii?Q?vd106D3WSbZMQvy5Ub5foN3cLkFhGmapX9KV81qKuaYjJOX23QiRkeKRihUr?=
 =?us-ascii?Q?xaNjmlMCQgGpQO5t67z3ENkS355QBP02ItHzFc0/Iyknyk1FnjavRAmFYWeJ?=
 =?us-ascii?Q?WabYG13AfqqxDduXCeuBtsEhcRQ2c9nL8y1LefVwsfwc/AJJMMOSKamz+6xB?=
 =?us-ascii?Q?Z0D58PLDDay89EXrLZF5PiwlmcAdPM4KIoxyeS6qqrNrsvE7g3H0wl1cRlQ0?=
 =?us-ascii?Q?DSEeOlENJGbSmOZyLEK3Blq5tgFGgNf9BiKmwxU/3oPNbaZad/mLjGY2iXEE?=
 =?us-ascii?Q?M+DNJ8LL+zTgQJvobkzEhepYlWt4qu4engBEfpQ9xLp9RrBNm7GbggxH8kh9?=
 =?us-ascii?Q?RsKJ5SaFSg9U8mS99fjnVqU65u4vudA8K3qh0rBT5QsmCluWWoCMFrPk+n74?=
 =?us-ascii?Q?dujFhjAQkMqhnLMWq58EvjNu/y3eCASZ/juxGmFTwJylOzqrnioZJWQSmtNM?=
 =?us-ascii?Q?aeBe3QXkmPK3X8cccB167NK1GMI9M6nINE26tXtVBxd3Bd5OUNVJDIdU0cWC?=
 =?us-ascii?Q?47bu9jJy5wPcGUWfO+2m3x2XghC1/EZPRbu471fZmQIfHxAIgxmVCnZRxPK8?=
 =?us-ascii?Q?yd6vGR6JmEXKz42/NL5Z6m/oYKCXG2hxkR4Hj8FWQAWWGbcMcBqVzz1e+BsE?=
 =?us-ascii?Q?eI+7akBlrqTrMv8mT+iPssoLYiuK3we8JMNz8WnsKPKXdtKXjV1PWocOQCYP?=
 =?us-ascii?Q?bGpJrZC5jujrreQv2BosJcXXtrAKdTDmAKZReAZnOMp4hkJEyNvUFAspl6DA?=
 =?us-ascii?Q?XQxcBNo5/Gb9tFZ4Vj/TzIRY9YXQJH1Z+AVCUKlsqTvBwBKB5ognopw6nogo?=
 =?us-ascii?Q?/47PIN6I9SrjBPpSR/oUn+Tw13H9ql4DMwekR37MjXuJ3Ds+6oKXpB/k7C4/?=
 =?us-ascii?Q?NByNR7FT44pVztpYo0myE5+OUzpZaq8S+BBk95OsXg285HZbWVKeJ/gKPyng?=
 =?us-ascii?Q?/YbQOzSEe1aCGGQfyIgoztn8i5tZRPq01oOi+FNYdVpYbtMMmht7YyaVupjg?=
 =?us-ascii?Q?r5LN2WBH+I6hRr3elT6Om8vFzSGN2/tVdhPyK+hFpgEMYGLHujJKfFFOQ4/n?=
 =?us-ascii?Q?kYgyZb4HKgDzM4/sg9s1er9aXWkjY8X8bUt0oG/7xze8FoXuAVRBlwJrg1dQ?=
 =?us-ascii?Q?bV+2MecYfXv6PgXRKuFg+788hgbFWmL8aVdpjZ6kb//KORtolWlrqXm/u/nE?=
 =?us-ascii?Q?Y6iaVEI2X4w8zjYCt5pznShFfUwXWw6raj3rcRgYhYIyASgKnaZLo6ZLOckz?=
 =?us-ascii?Q?i6sFuoojiD9oak5d6HrZV/LinVLahzEFP/aCQj1xm2juuYezDgiljPHvGygo?=
 =?us-ascii?Q?0PVCH9tq/F4eAlWRrd8K2F/B8aAL69KT94qp8toYuqoquITq+KsbBkmRezTM?=
 =?us-ascii?Q?xkWC5a+Lmggc0U0Dc8xgY8kAOtxTHiQErb6T4EXarXYAFR+fediOd9UPu1bI?=
 =?us-ascii?Q?bGg6FIbzwKpCLXh6S9BdWELwKWkE+6rt6zsKIetoenW+Yqwqkzl+dcLJO+v9?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7efd723f-c72b-4d7a-64f9-08dbf0d812ff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 12:38:22.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjtiPHvVdRACP5N7Ua1vCns+FdOXWeqQ+OSP8aZ7EaByDR8+OQF0bhF6aVh69pAc0mXQeePFY0Zg7PfNN9gy0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9382

Hi Andrew,

On Wed, Nov 29, 2023 at 12:21:27AM +0100, Andrew Lunn wrote:
> This patchset extends the DSA core to add support for port LEDs being
> controlled via sys/class/leds, and offloading blinking via
> ledtrig-netdev. The core parses the device tree binding, and registers
> LEDs. The DSA switch ops structure is extended with the needed
> functions.
> 
> The mv88e6xxx support is partially added. Support for setting the
> brightness and blinking is provided, but offloading of blinking is not
> yet available. To demonstrate this, the wrt1900ac device tree is
> extended with LEDs.
> 
> The existing QCA8K code is refactored to make use of this shared code.
> 
> RFC:
> 
> Linus, can you rework your code into this for offloading blinking ?
> And test with ports 5 & 6.
> 
> Christian: Please test QCA8K. I would not be surprised if there is an
> off-by-one.
> 
> This code can also be found in
> 
> https://github.com/lunn/ v6.7-rc2-net-next-mv88e6xxx-leds

I am disappointed to see the dsa_switch_ops API polluted with odds and
ends which have nothing to do with Ethernet-connected Ethernet switches
(DSA's focus).

Looking at the code, I don't see why dsa_port_leds_setup() cannot be
rebranded as library code usable by any netdev driver and which bypasses DSA.
Individual DSA switch drivers could call it directly while providing
their struct device for the port, and a smaller ops structure for the
cdev. But more importantly, other non-DSA drivers could do the same.

I think it comes as no surprise that driver authors prefer using the DSA
API as their first choice even for technically non-DSA switches, seeing
how we tend to cram all sorts of unrelated stuff into the monolithic
struct dsa_switch_ops, and how that makes the API attractive. But then
we push them away from DSA for valid reasons, and they end up copying
its support code word for word.

Maybe this sounds a bit harsh, but NACK from me for the approach.

