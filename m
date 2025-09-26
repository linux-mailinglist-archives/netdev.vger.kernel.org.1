Return-Path: <netdev+bounces-226655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07393BA39C3
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 14:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272FE1C0293A
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414072EA48D;
	Fri, 26 Sep 2025 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jmaB+SPO"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166210E3;
	Fri, 26 Sep 2025 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889686; cv=fail; b=MwYMAK63eWTRPFjCIxBWuwMiELYfJzUcdDyFBNfh68K/fDaQTPGK8rfveSkmmEWDwXdTqpOKOXlyxp3BfefRQLFyvMnM4mJY0v0Q18FX0GN3Y+qRVLQV9nFaOI+LecquIe/zIUXwPMswnbpPBWYZDarrQwaKtjkovpfc14C06xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889686; c=relaxed/simple;
	bh=IC+c9HOmfuKMxDgWo4oeDplpu+5uUfR7LCZvONSTUho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NzZ566rPvtDa/uwvjq2Mmn5dcEPNEC9bEF9ekQPwj8pR3/zMDuNugQfRHLxXfL27gwu4prL/ke1uLlHwDlXWik9YjMlGlM2bi7FTyLtm5mMJXGusm4CDQsIcVqGdh5QU3AhyoL4FEW3zQhbKSyYPqiSAxHjv9H0CKlZzvehijR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jmaB+SPO; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3mrA6a98M5mTM8n8NUqUiSlA62SBQWxjRNMx2qSck/or9xs0v+C1L0faiLJ7qWhtu/MSnLGMC6IqWJkD/mPczXVY7wqnlIEjA1remlrdracwC3JwWnGtg1sNGUzjOfmEsymN80PEkE109dDTJn+XgjKmeDckZSE94rKU6SZAm+HWzzT4D+s9shi9KUlb3AV5NGvG1SW37anaCj3YY9ZIBKhuup4eDR8OnUw9LEIDQYYKTrAZpEQyZzQ+dd7oDvL/i0VFKqJRS2Yb/XYJAugUFb5habGQiwQji7ylD0PKnIJwPKjbVF520dy5YyJIYvZvhKp/FkktzvVkCSDouE/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmruSCeFThsLYUIj3S+ygNeG17sPwQb4rs/0srS/1Lk=;
 b=iIXY2ft0kCjQQFkL/zvd280zQByJIf63J6w3mkBMC4R2AKAuf7avE62BWVFo6eupDm1JQrhliSFRvQevp1CFW1IfJmsKN6Ipb6suNK93n8ZkrYZXgru6z65EHH8jT3WcldxEEU9OswbX+0pprfIsND8ag2wtjv+pOXkoFJmOsyuz0UKVGbv73Iraf8dgZS3p5GaYRo5AmbOZIGZhhEEXn2WEZ6Lb/sXCDPhNoj9x3Ff26dPA7Eom4DoeaRnSi9AupHhkdk5WBNXOosPgQ2yA1iq2ahslq81ZToensGHIEV7pHP0Xf+rdKX5OunQGYvfn3uxkKMK0zXj7KKZuyb9N4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmruSCeFThsLYUIj3S+ygNeG17sPwQb4rs/0srS/1Lk=;
 b=jmaB+SPOIxGxjTgITTI7xihhXaPV/++aId7ge80RVM8SaAQNS7GrT/Lcx/IXVGX6xqDGmIZ5BEszsgQ308slwTXIeeRH+pZYJySThowLAPyDJW98KCx267bmwV4ZbfhPwKESZJ6NAJB83xiv+jDhbRCf4gsbzIjspoEtDML18BgJpnPFdlL96mDEiGKcJwvaXPQd96C8TmUdnNroDunkUITFzd41WyGHvSQ7KLC6NGzEv583UahC0AmO74hCyZONBoyZUDxiPE4WMvghYbyYmyJfskQGD94rzmHDNRcdhe9acwc2twAoFYFWLdXgZPjRSbenuMTgEvNKjVIX/E50Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10417.eurprd04.prod.outlook.com (2603:10a6:800:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 12:28:00 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 12:28:00 +0000
Date: Fri, 26 Sep 2025 15:27:57 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Jakub Kicinski <kuba@kernel.org>, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, richardcochran@gmail.com,
	vadim.fedorenko@linux.dev, rmk+kernel@armlinux.org.uk,
	christophe.jaillet@wanadoo.fr, rosenp@gmail.com,
	steen.hegelund@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] phy: mscc: Fix PTP for vsc8574 and VSC8572
Message-ID: <20250926122757.jvcl7xi6435wlztw@skbuf>
References: <20250917113316.3973777-1-horatiu.vultur@microchip.com>
 <20250918160942.3dc54e9a@kernel.org>
 <20250922121524.3baplkjgw2xnwizr@skbuf>
 <20250922123301.y7qjguatajhci67o@DEN-DL-M31836.microchip.com>
 <20250922132846.jkch266gd2p6k4w5@skbuf>
 <20250923071924.mv6ytwtifuu5limg@DEN-DL-M31836.microchip.com>
 <20250926071111.bdxffjghguawcobp@DEN-DL-M31836.microchip.com>
 <20250926122038.3mv2plj3bvnfbple@skbuf>
 <20250926122116.iixyzxl3cjp2z66j@DEN-DL-M31836.microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926122116.iixyzxl3cjp2z66j@DEN-DL-M31836.microchip.com>
X-ClientProxiedBy: VI1PR0502CA0016.eurprd05.prod.outlook.com
 (2603:10a6:803:1::29) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10417:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ff2a57-533c-4d88-74f1-08ddfcf821ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iUhWZeCwJdC5MAoQKnFzNm1z8eC8ZRHXOg923+Ire1siLTByvkEpOcNsNm3T?=
 =?us-ascii?Q?4AV4fbZfsteqSDmTkvR+URkEuhjrCcGXWpP3pqcwvRIq0H+pUszvwgM0+27k?=
 =?us-ascii?Q?hn74c7jQTOzshMNH4/W00hz65ZvgRvUffjeX6ldyKPIqbMs7N40aMqMkJ+U8?=
 =?us-ascii?Q?6GxeID5tsn3QwWBBV1OmHe//SIwFT2SfJalB11vdhrekvx+uyxNgvhSgGRxP?=
 =?us-ascii?Q?9jf++bOW6YHbxIXPAux5vkxCbFeHh914OxP11AnfhORqzsl7gnsxqR4mczOI?=
 =?us-ascii?Q?1Yzz4slX/4Ndw3GqQkjVRqrFUfMM1SCyPKSNxFqmGeD0MC1wO4zA4TsoJzb0?=
 =?us-ascii?Q?AzDoTeCGa7FIX/qg/l5injKXrXwcFmlkMjXW7FEz68Dy0UNHx8rr6V62X/MO?=
 =?us-ascii?Q?3MK4amYsxKxW1hsvppLNTSTwwoX6w9DCybD6ejVSUhIHsb9AklG753+dMP0X?=
 =?us-ascii?Q?/JgcNpe2kofUzlCj2VZ2+Pc4RvuHdAZHVKXlIUwxz4g/XniHTdN0mJpec3p1?=
 =?us-ascii?Q?3oNdNN3yDxPjJIxENmLbUElbOjDJbR0Lpu8BAPZSrhCpF3FFpEC5HQBwZhNu?=
 =?us-ascii?Q?iW7105lc1m7/0snUwnW5XPm637en56vdRjm8SbjdfGI5Bf8F24hFiW58e8eL?=
 =?us-ascii?Q?TnDC44xMwyc++L9VRU3gGdqN0bSzngZzxHdRbOUP4TVv5tW8AzxOJqL0kxpm?=
 =?us-ascii?Q?MUiVwB5poZ47xw9MzKsL6tdBhcz0++fonA+bVUt2MJ1iqM7jOaa0s1fWpfwh?=
 =?us-ascii?Q?lQFxmZ+WX7tURMlh0caGfyjAVKvQpI452AEKGG7Jm7w7soxz0tp6DJSz8JWL?=
 =?us-ascii?Q?atbftHff3oMes7VrxfXIXnHc7+BGNoFvkYYkwVgwTFOXsnY3wR7VX3FwwMkm?=
 =?us-ascii?Q?FXqa/umBM3iwEEj7A7BCrNc+10bfWre7CctkqeDwONoPRfASdV4kE6+JqwbO?=
 =?us-ascii?Q?4LWBz/OmyIwx1huPHBYYti87W2U4hNiPWbVaVxQCuwR/IBnGJGCBDaP2NBcj?=
 =?us-ascii?Q?RS7dtYGtJyrWU/TEc9HZE1Gx1E3wutTBiFKtpfYey2Un1eDxqMHH7u66Zp3+?=
 =?us-ascii?Q?AH675JxtrsS4bB8J7iaiLu1TB4Vq9Xo+t+/pKCQfnRvpPZRjUJfdePuqqcAF?=
 =?us-ascii?Q?lLYiT8hr8OvZ5Pdisl7j9Wj23wnuVMgnDp2snUF0mos9v4gVqvME56xlT4md?=
 =?us-ascii?Q?Iu3vzpJ1ASieV3n/c0O6+vX5D41q1Zs73sKIaicDjY5xntgyvCcPxXuLVR47?=
 =?us-ascii?Q?99FiXXgwNAv69JvQT4D68kA+npSLohnrjEqr+FPlY1KIS+XtyCYM6PG8v9ZD?=
 =?us-ascii?Q?KAJlClJTWu3FucDTDul6EPYFIzpFpivij6FuXP4gVx4h0AtUpP7KepFeNOvz?=
 =?us-ascii?Q?C+EVXZXNJBRjSyyWHuXW9zcNZZ3TUfCUsiW8amooyzi/3XY06k2cDarFLRki?=
 =?us-ascii?Q?mJ/Q7Ahkirs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FhOsd/s/z/kQbLmctLXK8w6oWuKKvMcJmSym2s6TmMtzuN0GO8fDijIRGcKT?=
 =?us-ascii?Q?O6SlXPNk7aiHkhjkdco1OCSsz66XSCov+yaqX1Ma3/gtykhDtrBYeD/ZW9RL?=
 =?us-ascii?Q?RhEb/jSukTq1TSOra483CRXgCAkAXPRg6DFf+sAHzlVVkHaAQvWgbyHl3YBB?=
 =?us-ascii?Q?VDp8dYTRitc6WgpA58jSygbDGbY0MqpoCz3YWaGyScUz1wM8FSg46+j5ZsyY?=
 =?us-ascii?Q?6sBs5zbLW1Qpp90fJzaWiMHLi/ynJ8338FWp1KpWXyyagt3DjYrTRg5xTlwl?=
 =?us-ascii?Q?3X4otFKJxQf963RwNcbyUOYx2tG2+mrVEJiNRK/wO1F+UlddGtbI2ZBUPFpz?=
 =?us-ascii?Q?xvmG4YD9FTu8Ucp9t/LxGrAz6SwPUWrh7R1mRZhvjIxzJEQCE0c+e7H7VGsk?=
 =?us-ascii?Q?NiiwdCBAf4ShAEZlpHRD3x4Q1KCiripWQ+4e9tbsd/6ScNa39czkPIYhTUwi?=
 =?us-ascii?Q?5sVQqPpe0QTCb7vOMGfEdwlrKwlySvyzADLttcYxeNocL2YQ9zqcXJeFFRvT?=
 =?us-ascii?Q?xP54gtzlYX5FqDffnglx43S9+r2ztDfoo/WCl1nyLDlFVDaRnL5XXd5Fk8rs?=
 =?us-ascii?Q?ZdfKxhzKKayWDBHfhmQcOl3dtuU1f8NCukn/srlOigxCVz5Li/GGtN4O23kF?=
 =?us-ascii?Q?RQGS3URvD/WH1Tk+3Fi925c+mzfG4COLD31sc3X7gCoAhkPMG1uOFjjEw4gv?=
 =?us-ascii?Q?vxpqNXvpK5/3YblGMYvC7ElHX8udJYGCOEgHU4Ew2QgNT8LeOo7bZleUCpXN?=
 =?us-ascii?Q?Cn88GJN7lWn4ub/8KEh+HyY1lrx5MDKDcq4JQ4Oh171KWwotaJYuhwuKtq2d?=
 =?us-ascii?Q?hL8aWbURV2MAMvkXVGoR/BORXfNJLPBpm6dSQ8n8scwWayGth5lG5SLwaOUi?=
 =?us-ascii?Q?oIdyNFX78G+kcSJKcCgga4U4CauNmsidP2Sp+gM0ZTwKTQwYT1YNtnOJ13Es?=
 =?us-ascii?Q?Bhn3uzGI1qY1pL+nqT/SY7efOvEwnLXpTAPRdWbz8G74BOIDl0OHzkueIrdp?=
 =?us-ascii?Q?BhMcvq/jAVt5LapS6+AzqLsfAKDDZq9gfAn5EsOkXMl96TmY/arRkfn9JPj8?=
 =?us-ascii?Q?B5DiNU/2qgaNlZ8A8h0obWG3PSPDktwC7LcRHuvD2x53OaS20EKpGtodoiUO?=
 =?us-ascii?Q?oJqF8dgcOb1ZT0L0cK2lgYw3gI5qSWpULnBrIC4Tp4++Ru2Cr6AwNdoVtDY7?=
 =?us-ascii?Q?AiXsVC1qTE84Ct19JCAyTBDSHKKkshrgRauM7wLAx3nbOQNUBe63JUrSEWUi?=
 =?us-ascii?Q?ZHmr0gg+haB0FT2P9Ud+QlG/gRSlC2j5cOEweqxUEqpjzlfeXJ0cL6HluGaI?=
 =?us-ascii?Q?6Ib8ezDlk/e3vqaO+a8qfne3Y1t8AxB3q00TaNtC1W8oQhUfqvkxsa4AiIEb?=
 =?us-ascii?Q?apS+A6+7VevydFxiJxABvn1UeIVNHhObLI4c++l1suGTq6Bl50ofiWR8wJAm?=
 =?us-ascii?Q?pEAzCCaNqgq52yk6MQuFXxLrYGttfjLabhSz+5q0opTz+iJM9vmnBCDSPfvv?=
 =?us-ascii?Q?ABL4HB7Th01So1GceFIRAuo4wduI/DtLdPumxx4O+TyNuoYz5y2t9v2VuRdp?=
 =?us-ascii?Q?Sxy5GKCnR7K1vQaDWsP0NLGzBfqTJCRkWZHoz3fw4ko5zQ6qB6wqLFJCDf4D?=
 =?us-ascii?Q?00w+GGXrYBLhKrsAZjgqg7fXZx9axVG5nws3L/dZVWOoWFrgbCyCdoj71YHr?=
 =?us-ascii?Q?hJ8BVQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ff2a57-533c-4d88-74f1-08ddfcf821ab
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 12:28:00.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZd8+d9hst4OeQqczKn2086xSZNy4KDE9qOqfSzdQB23BIcu5/yGeN00/atTHe99WFyYfTSXdAjtqJQ2h6oPCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10417

On Fri, Sep 26, 2025 at 02:21:16PM +0200, Horatiu Vultur wrote:
> The 09/26/2025 15:20, Vladimir Oltean wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Fri, Sep 26, 2025 at 09:11:11AM +0200, Horatiu Vultur wrote:
> > > I have been asking around about these revisions of the PHYs and what is
> > > available:
> > > vsc856x - only rev B exists
> > > vsc8575 - only rev B exists
> > > vsc8582 - only rev B exists
> > > vsc8584 - only rev B exists
> > > vsc8574 - rev A,B,C,D,E exists
> > > vsc8572 - rev A,B,C,D,E exists
> > >
> > > For vsc856x, vsc8575, vsc8582, vsc8584 the lower 4 bits in register 3
> > > will have a value of 1.
> > > For vsc8574 and vsc8572 the lower 4 bits in register 3 will have a value
> > > of 0 for rev A, 1 for rev B and C, 2 for D and E.
> > >
> > > Based on this information, I think both commits a5afc1678044 and
> > > 75a1ccfe6c72 are correct regarding the revision check.
> > >
> > > So, now to be able to fix the PTP for vsc8574 and vsc8572, I can do the
> > > following:
> > > - start to use PHY_ID_MATCH_MODEL for vsc856x, vsc8575, vsc8582, vsc8584
> > > - because of this change I will need to remove also the WARN_ON() in the
> > >   function vsc8584_config_init()
> > > - then I can drop the check for revision in vsc8584_probe()
> > > - then I can make vsc8574 and vsc8572 to use vsc8584_probe()
> > >
> > > What do you think about this?
> > 
> > This sounds good, however I don't exactly understand how it fits in with
> > your response to Russell to replace phydev->phy_id with phydev->drv->phy_id
> > in the next revision. If the revision check in vsc8584_probe() goes away,
> > where will you use phydev->drv->phy_id?
> 
> I got a little bit confused here.
> Because no one answer to this email, I thought it might not be OK, so
> that is the reason why I said that I will go with Russell approach.
> But if you think that this approach that I proposed here is OK (as you seem
> to be). Then I will go with this and then I will not do Russell
> suggestion because it is not needed anymore.

Yes, sorry, I am in the middle of some work and I'm not as responsive as
I should be.

