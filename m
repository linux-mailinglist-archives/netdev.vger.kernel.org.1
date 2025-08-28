Return-Path: <netdev+bounces-217680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9259B3984D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2F3464B04
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102602F067D;
	Thu, 28 Aug 2025 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="STleHiCH"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7B84A2B;
	Thu, 28 Aug 2025 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373348; cv=fail; b=V5/mzgO7Z5VAw/nffQHNdAnoPVgOnEIqmAk23v3Z0hh+XL1MOqUesi5YkDc/73XWqyHPqvilwBr5PqcjPfvSiFN9lUy3Dlc9d1+WpljjByfIhC6c20ifPbblpJqGT1/iXpFMPfaCLksOn7G8g7viquDRtR/IdG2SQck5dFNVThw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373348; c=relaxed/simple;
	bh=H0btD6lxaTKOBTopfWL9uytbzVAXZqLR057PFcQiINQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pZzrvwDSMFG82Yo6hIU3WeoGcVi+ff/eYHBJbZr+9S+gt61aM/jo3t9xSEwVZYLziA8VtMRbLzI9IRC00vkdlfqX0FCCTlS6J50sAStmfgcRNkXycEUthoEHySNMxh3VSZCTnMOnKomQZ+5T4A6PQzZfJuS49+uQnIfwbUJrWVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=STleHiCH; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDXkONV1IwvHQBlEAMYC3CVDTYuUMKGICsDo3Ng0t7uhuMWo52J0LBMvi/ZAb3PBTDUemIQW6jBrNrvZCgTJsvagTVWrK8A2DsBTwif+N1/LcO8HGBjwR2cJ4yG6EZkR4vZpxfbO8SKuNi30K1QZiJRB0c+62W+6BXpjliCOV0tW6jpI5fIhZNGJYANEOaA3oZoi0s97VXFFuHxyrnemDg+q2lhx00I7Q/kkbhuN0NdgtRU005rU/RDS2t6G/XsEoOiJBrp754Y6thagUmlZB6KDfaNapsRLHDrCq+ygqt8UQ91cj8y+NLDgOc96c+/CZuGk/DI3rP4I+G7LIQ5qLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChUPmaHv0nyywvQDDZZNFKmjA1DIRHXSlM5h1tGf8Wc=;
 b=DoWxrC3Pc8JgSQZVIcrOgn1KmGipsc5lbLe+SY9B/1rfsy4AOcsTrpP/zAv7RdcQAW5tbUVxeLBiM1x1WMpAuw7enMorjBGWa62GLQaVZmRAmic4pkZAXQWLem5YQIHSEE7h8aEFVOegY7UZ0ogudh+LFPH2uEAjav9NdviRJdXiwliak0tiStAQlzdl/AQNtR3mduvU9RRyWGcxPjbPdnjT8QcrBO9OHkWh6P3ziRzfyRP8i9UJNNwbWp02BuvRB3gZ+MXpSsi8xFr/UqN2KqXtq/Wy+Yt+wgUEIsjZ0zAXYX2wOij/n2JH5kcGyyIApzTMctE9IfSsoduP8NGC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChUPmaHv0nyywvQDDZZNFKmjA1DIRHXSlM5h1tGf8Wc=;
 b=STleHiCH9GAGvopTe4rotjPCrBzNOqpp95Ajsh2uuh6bPXMS/o/uAf2THjMtzosig7bmuPPFdi5uTLhIfRO8oSbmmE2olsCEMaPZ7z+VRGegRfVoh1iQXKt7R3gNJ9vydwSnw+O+IjCPUCkwJSWb6XSWHJcz5kEraJvpagvx+s+0+MRreKDMWdimKabAyCJiES/gh979qbjcTKM9LWC4QEculXWR/woxuWxQWABCnO1BYwbO5Eclpw7jkp2T4ILJnaVyJiH3weQ+44nW1Q/1KP/3g+TWq0bU//lr3DSASzlmlYpyaUqNo5HrVr58Lw1nosRvBXXlEvrcxzl1Z3Qh6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB9996.eurprd04.prod.outlook.com (2603:10a6:150:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Thu, 28 Aug
 2025 09:29:02 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 09:29:02 +0000
Date: Thu, 28 Aug 2025 12:28:59 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20250828092859.vvejz6xrarisbl2w@skbuf>
References: <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
 <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
 <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
 <20250806145856.kyxognjnm4fnh4m6@skbuf>
 <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
 <20250827073120.6i4wbuimecdplpha@skbuf>
 <aK7Ep7Khdw58hyA0@FUE-ALEWI-WINX>
 <aK7GNVi8ED0YiWau@shell.armlinux.org.uk>
 <aK7J7kOltB/IiYUd@FUE-ALEWI-WINX>
 <aK7MV2TrkVKwOEpr@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK7MV2TrkVKwOEpr@shell.armlinux.org.uk>
X-ClientProxiedBy: VE1PR08CA0030.eurprd08.prod.outlook.com
 (2603:10a6:803:104::43) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB9996:EE_
X-MS-Office365-Filtering-Correlation-Id: 423387f6-f876-4956-7186-08dde6155357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8EmwyPiIXiWqWJyZHTtaDOtsJVaVh3TvtoGQ9tyvwQvYX4Ju5TP5BY+VYpr1?=
 =?us-ascii?Q?MsaWEG9s/fb+8K2rrnSgI9oXg6hLfkujmCpZJXepMUy+Lj30+XUkPWYbbml9?=
 =?us-ascii?Q?FkNKD4y2g1wQ+CePd7qhmcbGKR8MLnmWCtrfjavoGJIfl4Bv4b8PW3O6CoR9?=
 =?us-ascii?Q?23b9rd6O+jeR4iEYVLNwjduqwzDxK0jCA0dxDxOabX4Gc09xT075MxbkFfv9?=
 =?us-ascii?Q?0eHEvK5aeWcVJsXcpslSNtlxP7lQWg8/ShGpwL4frxPsrFiLWFhlKMzROefB?=
 =?us-ascii?Q?Rh89VElnoZRiUPwpcY3ScquInQVcKh7xtAWVEo4L4RIK0FqFfmVw8UkvG/hN?=
 =?us-ascii?Q?8WAjRjvIb6Vo8OxzARJx9MWNnVzabdHSeG8Fe6MKhkSMZ6NXmywAbET7Y6dt?=
 =?us-ascii?Q?rg5N/+vHXIfUNB4+Vih/nyRIPcMWDrbIYa2EBCn8GMojm7b8mgQOVXbrJjWH?=
 =?us-ascii?Q?XfEMiyZIJ1K5wmRoiq11nT3Bhdyl1nJkPpkyTxe/QIH3OMXXUS21jZhHXCwZ?=
 =?us-ascii?Q?ZfK9INgHUJcIwUXNFrP66rJV7HVaKGd2ybji3AT3Jtf3vRr+4lHf8+jQdwqa?=
 =?us-ascii?Q?y4xIogcq6Yo5Kbg37z/iguo+vnO/CKhokhOHACadzuZWFy8elxC5lCbNVBrg?=
 =?us-ascii?Q?39QGyAA7whMgIVYLc0CcEGDJV8MkYCzX2i1Tyjv+W5eYlqQ3BWyLtICD5uUl?=
 =?us-ascii?Q?aNBSyZtME7B+UuEq3J6zwgePnR/zIxCaoYYoQ+SpuZjLQKwWGhblYfSPos9d?=
 =?us-ascii?Q?/vM8kydfBR0p/X4SkIJk8KT4sIBy3JqedUxu1dxzKfnbIiwQ7A2aBldCAlm+?=
 =?us-ascii?Q?sTkpQg5mR3pdU0crjkNsNzV3twnBtN5o3KVnuYkd2n2Yx0LC7PCQmGfEDidu?=
 =?us-ascii?Q?TiwsDzgU4tEOdvnPOnH0PbIaRG9PZUP+ZCCaYukwuZHExk3S1S2Jx7jJ67Lv?=
 =?us-ascii?Q?14s5SRB9sU+aFcnL5VlCKIPTo2FDcvBD61QJhgBH5t8FM/zDV9Gd/J7hKeg1?=
 =?us-ascii?Q?8eoAoAEWMgCy+nwFZCpxtZgFHd8erDRN47gGArwUMEvg6mBKcvh7LxWgTY6l?=
 =?us-ascii?Q?QY9a7ioiAA1fdRTPAkdU6gCejv7j/FhA/izrSlnLUrrMZySSVas9NIk5uj5G?=
 =?us-ascii?Q?JRWANHud9saQKcel6ekt00EwB50UqEkvrkvIlJ4P0/gq08JJHiqv3wYZNWFr?=
 =?us-ascii?Q?uNlUmqQoqcWnrPs0+0ZjOp0O4v5Pc+EikTmqKe83XGZwVJ9utXAKQIJKcVaH?=
 =?us-ascii?Q?tz2aRFA+BISCO7+KHJT3g6GzjjHnlU+l72CSP46ltu4CvAQCNCD6EWMDa4ze?=
 =?us-ascii?Q?X0/U/Y5DDUF0xik4oKvblBkSLjc2x6OokT77JHl5zVEqyi6uD+7nyZ4U+lZE?=
 =?us-ascii?Q?4bSA/79DT7X2pEgBx7sKy6jk3W6OZfInwIo2X38fJ+B0P4habxd4mNX1sadh?=
 =?us-ascii?Q?eCkucb+JshI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DqJotcZJWYauYAZHZBOpHUX/6iyzkRZI2U4bP8NQy6/tuzFC4cfQ3ibg+qxP?=
 =?us-ascii?Q?jBgl4GEqifNh82RROv80C1FnqSY3eeBb+ZjR3yaaN2FD4HkmafdSl3UunyGw?=
 =?us-ascii?Q?r3YzsP0jnLZPjNVT+xNxJFPtD2oUISs3JohS70vklnHlpbGHLWzTOYr9OobX?=
 =?us-ascii?Q?1vKgJCFcoy9XGkLYzw/bj+0x/Ip9k2oDPFEszzjrfLPk86sUN66+NVCvM3Co?=
 =?us-ascii?Q?cABLgTMGTKL4CLKTT4ZkQlGd1O3WRuIQOSdukcvG/pkTpLFH4NakmNQycwaw?=
 =?us-ascii?Q?Dx4dhAdmSZNCLb1cZthQXYAyXEQ2Sby02a9VgOfKlHbCDso/YTqbjZGw61/1?=
 =?us-ascii?Q?9f8uUVK5fNwlOzFA/rDL83DpAmM0Egxw4OcUktisaYcGTl8UCPFDy+Fy1g7/?=
 =?us-ascii?Q?AGLvEHbKkEQAnHgXTQyQLOCCV9InCHXsIkHnyf1+ValOjrjP0PZzK/0GeKrf?=
 =?us-ascii?Q?LWQoRCNUQlN1t9EGZIyY1mkuo5Y8ZPvnkcr5bQ+I0GaFfdVcLnHm4N2nPuBx?=
 =?us-ascii?Q?UYbdX2ehOVFBI1qbxqXQ6xg8dYJM+I2EEJBiK8Xx/dkpkli6eTArETzq0SsT?=
 =?us-ascii?Q?0P66A4sy99j8o7/irSf0DB/K8dYF5R6PybWiNVEvMWW666u1kRYfLMQ5H0ll?=
 =?us-ascii?Q?nWCjqqbJzQMVPXatRS4CH3faUkQJFDlw20dIVyxxrCnltMivcUJhkcnhvPtW?=
 =?us-ascii?Q?RkdX29X5Y74HBSA0vaUktN3j+F08hnILTYheyDOID6ctw0XuYpx/goUGJNVf?=
 =?us-ascii?Q?/75wkfxMt1CiWAYYOLrjj0BmtaKBrGzQb2e+i4/D+QKaWR9irTn0PavU/bnG?=
 =?us-ascii?Q?hAEf/CV0B/TSJS8DdEaiMepSWo2IAHZhKNGNtsDvchBVHOvBy7TG0iQspRHj?=
 =?us-ascii?Q?a+gLl3sg5GCqVMDDzHr9E328H3kOdWIuUVaiXlV7Cqf8aT12JzdS55BkEiET?=
 =?us-ascii?Q?o9jROr18kcVQTuT0YqeYYCIXM2lFSPdjBaEkBOHKGUBJw3Ah0Rr9nD3kyyn3?=
 =?us-ascii?Q?2bCsOUMUO6KQA+2SL/0VceWaf5bLaKnuGNf02JqnMwWpuzVqO2fLXqklboFt?=
 =?us-ascii?Q?lvTyPC475ElUb4bRxOl/KOzgh7YDj6UtToNeFTsJtar6WqHxiCdUlit6EjG7?=
 =?us-ascii?Q?622gfjlZ+erHL/1z4r7PEFVInOK3qdSshhnviB3fJZ90EC4h9vC+8yweZnsk?=
 =?us-ascii?Q?rX4AlHdDonwofnKLgf2PRX44ZwwuKPIaXnLJoTIOBGVc15ilhfTIkOj1VcTS?=
 =?us-ascii?Q?4o2aY1P7J+IujUgWGeJ5QFsT6hc5Y8TC8jpezIbFsASj5Tud9VqF2Qr92ANQ?=
 =?us-ascii?Q?9FShkSFxz6aDs7M+id+Z4YiYP/aE/1Lp1Lj2IvAbl/W5X7HXmjnenW3sweHu?=
 =?us-ascii?Q?cC2n6h8e59JH4jVdzmZF4DndHnKV27p4u4RCIVlrgE89fdrn4C3eHrb8dlmI?=
 =?us-ascii?Q?ohSBCZucaiU812GYZjou2FiGnYrL5iYFlz7aonZqYm2c9L7hvcRRUpJ+lycD?=
 =?us-ascii?Q?m04OTgzZG1hMky5RipWesgSSeTzKvWhvfFjm/io97G8nx/d1ZfqMfWyPD3Pv?=
 =?us-ascii?Q?fx2nFS/hIcI8aHwuCJtdQklD7ChBW0i2SfGs9vZmL3MoPOg2gcUV+8j3NUgw?=
 =?us-ascii?Q?EOQ+cjnxE8ZZmU3Iz+koHwuqgWWED1SOqzpR+T2JwwWWFqmiz7KwF4agogCg?=
 =?us-ascii?Q?C8AMuA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423387f6-f876-4956-7186-08dde6155357
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:29:02.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2Dyim2Xtk0bXfu7loJnN1b5cXUq304tQ7zZ/ViqBFIflPljJfuurnvjBbdoqAMz2La7W7kGE1LGt3CObzkH1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9996

On Wed, Aug 27, 2025 at 10:13:59AM +0100, Russell King (Oracle) wrote:
> On Wed, Aug 27, 2025 at 11:03:42AM +0200, Alexander Wilhelm wrote:
> > I asked the hardware engineer again. The point is that the MAC does not set
> > SGMII for 100M. It still uses 2500base-x but with 10x paket repetition.
> 
> No one uses symbol repetition when in 2500base-x mode. Nothing supports
> it. Every device datasheet I've read states clearly that symbol
> repetition is unsupported when operating at 2.5Gbps.
> 
> Also think about what this means. If the link is operating at 2.5Gbps
> with a 10x symbol repetition, that means the link would be passing
> 250Mbps. That's not compatible with _anything_.

FWIW, claim 5 of this active Cisco patent suggests dividing frames into
2 segments, replicating symbols from the first segment twice and symbols
from the second segment three times.
https://patents.google.com/patent/US7356047B1/en

I'm completely unaware of any implementations of this either, though.

To remain on topic, I don't see how the hardware engineer's claim can be
true. The PCS symbol replication is done through the IF_MODE_SPEED
field, which lynx_pcs_link_up_2500basex() sets to SGMII_SPEED_2500 (same
as SGMII_SPEED_1000, i.e. no replication). You can confirm that the
IF_MODE register has the expected value by putting a print.

