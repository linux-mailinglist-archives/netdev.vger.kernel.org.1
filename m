Return-Path: <netdev+bounces-137219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF579A4DDB
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 14:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DCC280E12
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C41524C;
	Sat, 19 Oct 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="myL9JbO+"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE31536D;
	Sat, 19 Oct 2024 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729341969; cv=fail; b=KDYSGWSjWjRZcHqj03wwOP/NKD/hX+GwNE5p9sB8E4g1Q/XsFD9cDF+jwLqsDehT8kr6diugg+uau6IkM0/dg/V1jY97kY5Uf0iM6Dm3eNhZaa783tH3oTp27a2J5UP+lLzqkQm0ZYpFsUiw2q9Oai13z3l/jKj+hINJyp0t4Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729341969; c=relaxed/simple;
	bh=5QpNjmfubk/U98Zn+BIqD4bXAgICgYQHhhTN+7f45JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BEIcEfHwrCbYiCr3kjC6INmteQKXVLAVbE2InPv5lBECYj+QM1na4+yMTVHt3hcpU/LDbkSyMh9it9gmTA7/lYG0h+T427lA8LozQsLQLaI9Q0MHCZB9ZXaOeKWA2U548Q6tfSfCbT9Zt/yjr7v2IEtl34WvtVCeR3BCYO/yiJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=myL9JbO+; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddDmFZa+wNl/y8GtKrZBfeEEjglGLzruYcAJyhcOg8hrQQRC9ONkeVahjXVPF4/iDVLIqXjvcvGXHNhZN61mPpO/CnoOGrhNH4yow+v2WYJcfWDjEKycDxMXnMRQFRq2o4a5vH3OTRmVVeCqCPmdeKj65GqE9faXikIJFJ2M7eY53iXZuepz5Y1YWArgK/S0UL1xeIDWF1aACGW4Vh24qODTKn9IH+Hl/oBBetHIfNZ/DdZKNV1YQBKiO+hOtbkeiJVbkGEJEa8cjL7weKwfkV7/k8ncLB4KBf+Q7PuUlXtULqsnmR1E5Jl09nvWgfafyWG0Ktz234KcZpeApdyHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHFLMpvXgWMt3X581JfD8dCSTF26f73aMMR95kBcpKQ=;
 b=uWrkcM2OU0xYGZTpAXFMYrPCTTSue61aOjZK67umxEMx1UTO/ofoWMHmhzyIQ24/OfWLYzts0ryq0tY4/Y2UpYJvYk4/yLbpkUzyAJYKPtdgEYtiIGd5TEWjeySNfxpwL4Xdl9IACrjOxxM1zd8D6Xb48bQ3rRKyoohZfid/9ZMK+3FfPxG6gvXu3O08ETQCfY/nRI3hK6LvLvgy1T3uoj/dppOSP+w/ekj0FaJUhGiNlsJhNfTrW5JEhW6gxGGlyf8kpmRrRiOx5I1HRDXBCL3eNjrhbYUVY8ir/oJDqYQMtM3WkXOWTWTYe6Z4wdyuNp89znHVYR86MsKSKfKAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHFLMpvXgWMt3X581JfD8dCSTF26f73aMMR95kBcpKQ=;
 b=myL9JbO+pTOoKCpFUskJ92xGkKBYmzEHsKXiLhQ8xSwEV9abkSHUupF+eFc/xyHcaqu/zdxIQ9Hdd2H/5WuzyS+mHa4PBzhAe2WStJKdVa6KLxTRKYtCVVr70kE67jslUoCWju0EhyK2sdBmV4qOl3VtsCPeKlNYKjHTH7nfwQpNgSGXDi8kv8x5DHb1tZ9o6w3i2keUkPiA24vJ02qtC3xclZu8SdkMYJqf+aHFrLpgQXW4DjOVkYbV9C5fseI6gstCU554iuLsbHBXuPavkCX2rOx1KUl7uPntBXXVwoTHjl1Sky7n6XPraaCfCoWTUiBhhSXufjoMCZ37AncFmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB9224.eurprd04.prod.outlook.com (2603:10a6:102:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 12:46:01 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8069.024; Sat, 19 Oct 2024
 12:46:01 +0000
Date: Sat, 19 Oct 2024 15:45:37 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/8] lib: packing: create __pack() and
 __unpack() variants without error checking
Message-ID: <20241019124537.mzhrgg2dj4msrycx@skbuf>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-1-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-1-d9b1f7500740@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-packing-pack-fields-and-ice-implementation-v1-1-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-1-d9b1f7500740@intel.com>
X-ClientProxiedBy: VI1PR0502CA0029.eurprd05.prod.outlook.com
 (2603:10a6:803:1::42) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 22908002-4bd4-49a6-d634-08dcf03beff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xO6BJBD5aTP5X2eXwocyK9TAer8CUWQpwqXbHAwrGVZMChUdc5TRfbR4n5WH?=
 =?us-ascii?Q?AjmWDguirSV+2crkHPK1GfTH6LHt4vPTwcozvvqolP/f/LD/jViKddF599L4?=
 =?us-ascii?Q?pnaWOTPFTChothHMouSV/A/w1MtZ5qfPI/uZOdOnLm9EPhv/jeVG06vojzww?=
 =?us-ascii?Q?f3ucT3KfbRw1Ns2FOg1Yx73Oujh4QnJzIAQgQ3giR23UICBZYkUgpVy3+rKr?=
 =?us-ascii?Q?Wje062+hxE71vIkg7CeVR8VMorr6MeTJ6VBYWkIvjBVybNQEZJsmBqAi3uh6?=
 =?us-ascii?Q?bfejgT81gcc6XBz8XAtgESGyT+uTOIO7T+ZtUCPNZtMKu2n0YK4cQ5mWtnJJ?=
 =?us-ascii?Q?ZU3yUAXLcfXZFr+Sw/ur3LDlb4cvnoSaB3ySdvl2YW1HgzSD8oGdJ/gRCoKK?=
 =?us-ascii?Q?MJ4uuGXDUVVK+7vZg428KNJf1OIznA7sLiqBc7oopbPSWf6AO/Ivb6sJ+foM?=
 =?us-ascii?Q?lLQ2WxdKUjiaghnsa8U+JMEcYI/fS1xgJ1ZabDmhi+rztGi1K8RU5aY/g5o5?=
 =?us-ascii?Q?kHy09PSL0tTzkUQ+0dEtvJtbm1uHgE2MQ30FYp/Kvi8IDzwySEn69pYa2saq?=
 =?us-ascii?Q?3ScZkn2+AKvnTbbTBJnf622UVh9QE5W/5FFtovHSzrZWGUmXGEfnlrs7EvB5?=
 =?us-ascii?Q?/jLpUH47hFf+uZuVzQ84ZM+Bs6QL7nXfxAf7Lq5L41ccj2no9T8AmAq9rNBz?=
 =?us-ascii?Q?MuVtcxz5qyKm0i6ZJlPKA+Np6Upd/9jBfGApX3mpwoJSJjELI0kJ2Gtvl7FA?=
 =?us-ascii?Q?OHcuiDmKMfbkBG0p4XFuh46B5SRQJM7uzcao+KYt+nBGzg7TCvxTCDPsU0cm?=
 =?us-ascii?Q?4R6uRQX7G7sJa3A+syjN1z/MzOsZ/lyvh52xPKnvZIUv2hbdgk08yRy25OnK?=
 =?us-ascii?Q?aHvTkS6EqsyeoVI4yCMob/Q5Hvfgi+MIniWSj3Wvh+oNQGZzL9qIy3MhGth6?=
 =?us-ascii?Q?C2lqGXtB8L2iPI+Oy9gNxF8jDW5bENsr9xD5m5qz5EZrbTnnsvQOiQNqGt4f?=
 =?us-ascii?Q?ZhrUbhsBRGouQ7fslB6NedyQ3MZZqIpXxw+q2887gfeNMDn/EGtVZBBAfp8V?=
 =?us-ascii?Q?gKXkVO4lcwycqjvKJ/bfKDe4uuHHV98ooMHPna/c4lGtIMo1DfOxtrq9jWKF?=
 =?us-ascii?Q?7734ntoo8hICuy5mFinKia2vwmSsEm4u+8kmC5vlCJJMdXbhbP3jLrtKx8YR?=
 =?us-ascii?Q?Yx6StQRE1GSZx88aY62F/NQIdaWjDbREcDeEfShOwAsh9bY6dSEwqd4MyZUS?=
 =?us-ascii?Q?wyTdmz7YSA05zwevOmkXXbIql6ao3D6oHyZX7evf8TFbofbXhm3tV3pR3sLU?=
 =?us-ascii?Q?jA55F/jjstljdGXkTWax5Q6H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?neGY2tQ/B7EMlQdDNTevdlppuwR3ABXHW4kWdPtst2bWG5r2aMkXh5IroE9e?=
 =?us-ascii?Q?A1CTbDjG/Y0KDwaAWgyKbf2J0pQbtLW+o9Nfr64AHhp68gjK7JAtdqt9+33p?=
 =?us-ascii?Q?K7MsSd4VYiGi9uzMOrFyG2D0Rq5XTH4bseZVXiMR91U0u757r/dls9Eswiyf?=
 =?us-ascii?Q?LF2ywKnNGdUncKJYPv8EGfHjjf8gRDusmndN2vPjFLY1MtbjaDxhy0AWfo1I?=
 =?us-ascii?Q?ZCtO6puu0PS/JbXAA9FMUiZFsxK+yJr9iRf4frOvD6twNk8cQK5OSwVRWvsI?=
 =?us-ascii?Q?DM22Z3JILo9b35R4q5I0sInzTiQvhZOlIyZezCrYpk97SnAuKtAeFLy/6y1K?=
 =?us-ascii?Q?BQtl+43OgdbVMllFiZSJO8o1wAPJ3DCLGc4/QLzkgUd24EiN8gIzZkdRqimO?=
 =?us-ascii?Q?3uYQTQjmxgXjMs7vGj/9DjIn7BBlkcYYSoOIvoNc0lUpHhsWy1fKbd7ixOF3?=
 =?us-ascii?Q?Jwrm3wfMCzHipbMjVZY7XU1ZFg8O2Mf1lxP0n6hVgPoHwwd0zANVwJOxsVyr?=
 =?us-ascii?Q?bBSyS3PKbl9AWNW7AfqyPmaksDLFI2SIPLu/ipxbG6TLx1ZSJZbxxkJCl30M?=
 =?us-ascii?Q?+8NBJSJbl/6CVNKpcSBiOrdG5Yt1sxXP1u/+8PjD5k17vQGR6WFLbonCqQFb?=
 =?us-ascii?Q?U44O2DpmuO8JWpumzWC4Sy6gBPu50f6fk+EcchAI/h6oW36zKLdKCKPGYLle?=
 =?us-ascii?Q?vfbS1X7T1nuR9hYdWHTFMsRBKGV+ZH7zJ1eFndFFeaVZwgL2ydrYH38+ZLVI?=
 =?us-ascii?Q?utLDH6O2XmlrNiQyXovvx40XEWWz5L3Nh0QnvFTGRuEMbccMjI/YRgWT0592?=
 =?us-ascii?Q?5qy+mnI1NWn1ULv4UrxZ/ssUU17e3w2pNtrNCTc+5HzmmZbV0K2vWWn4lPYN?=
 =?us-ascii?Q?OiqS1rRlRyYqasKK+fEFXtcFSBq7Cx6qeJb6BRx7huMBZ+ZgQdh6RoO/8LSb?=
 =?us-ascii?Q?HEpVXlHxM3QoF5BKNWPRXxiXHV3ZSNqzjPheYXOljfP3UXjEtQ9cNW1xEhGr?=
 =?us-ascii?Q?Lp2N7KjzrNo4GPMqApUVSJTPEqfZ2PS8KH0/vWxfX23be4K8D89Pna+F7/k0?=
 =?us-ascii?Q?q2oGeJs0PSWS9IdKM6EUCRUoa8YavjlHSf8BBZU5DZY3vAslVKpZfMyogorT?=
 =?us-ascii?Q?k07SrLYGSJ5rXKswgWaQsMAxx1V2hEUJ/+wdJtKA68veSEXZF9WhT7lGUPsx?=
 =?us-ascii?Q?r5IxibRIKSes7mylBMjY/4j1YTuX0dCyoewNulNx9GlDYovAHvdWtfOv7xuh?=
 =?us-ascii?Q?5V5IPeKrwyOBmI9qWCbuQi26bkv2kg2lK8NPzjZdBOByIgEkGV1cPoUFmRvG?=
 =?us-ascii?Q?E0T2a39FQslTIvaX6qnMYu/ajyPi4cYlflPibjQUFQ/E5BjqnvSkB0kWIdNB?=
 =?us-ascii?Q?+wNg1Ci2SeMEJ2WSVLASqlw28eaen/7Lp7xcFtWe+HhPdgqCnqdN+fyGl/3L?=
 =?us-ascii?Q?WneKZpU0/OF+rS1yzfz4wJJGIWarHu36d2gFZn3kFT+gpGhVJo5yJZnq6a9P?=
 =?us-ascii?Q?jPzw+8NZqZ0QEvp/q/nP70cdR2yIVQXzN+kTABKGnoc0PTcER7SiclBpwtQu?=
 =?us-ascii?Q?mEoTj+sjrieYifBxgOYMa6Tl6Ot4KBzZM7aZmMIGOeU8yJnHevyfDoEGmXPo?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22908002-4bd4-49a6-d634-08dcf03beff0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 12:45:40.0383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IrgP23Z26v4L8sh5zVJP9aae5R+KFT6Fe89iFYzpXF0j0Xh+hsYiZ9PhU+Ra+7Hn8AtaraFVTIR6B2iH9sNWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9224

On Fri, Oct 11, 2024 at 11:48:29AM -0700, Jacob Keller wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> A future variant of the API, which works on arrays of packed_field
> structures, will make most of these checks redundant. The idea will be
> that we want to perform sanity checks only once at boot time, not once
> for every function call. So we need faster variants of pack() and

The "idea" changed between writing the commit message and the final
implementation. Can you restate "sanity checks only once at boot time"
and make it "sanity checks at compile time"?

> unpack(), which assume that the input was pre-sanitized.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

