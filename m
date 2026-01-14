Return-Path: <netdev+bounces-249864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD11D1FB88
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EDBE301A83B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886B5399002;
	Wed, 14 Jan 2026 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k3ln43bk"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE139C654;
	Wed, 14 Jan 2026 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404123; cv=fail; b=FNE24dCKR8QY4qQmNF+BFO976eOcjvWHXJBX4fTfO6IVTtIR8a5nF4uHMkIFfoqrrwo723XNR86FcmtVpa5qR3c8tVhMDFUK6PFzojnIf9Q9tn1QLjPJhxLk0KSMVURXhRRROmNYM2gxFrCvsn1A4fSxwKWMLJw4Z4fKKUdB6AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404123; c=relaxed/simple;
	bh=odvJ0GH5tgvRpHSbmtBoG4G3DTsIJY2FlWdzFECVTr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lhlgSFzIpcfVWyf++PbH8y8T2RRCt1I4Pj0kXomT/vhekopLJ5MKMC33OMT5NYBJuj7gbQYAHM2ytfED3/eEsAdiClVaD745EDiHJEqU/gcJem+zAJPKg2kcuky7zcNidKWATRbbH8e/jUST/+ff59X54+tLOvonqC7LWx04Ges=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k3ln43bk; arc=fail smtp.client-ip=40.107.162.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPpxri9uNqFL0qth+ajqHsBAHPB2Njbj2pHqYYHWj6NYETgawXcqccTajbUPNu3vxfKpGgLDR154o48aayj6/QDHCzcOi+9sHY9015HxQXJ3/UZeRtIx+MU8Rtgy9zgTJ3Yt4EGE0BVh9svqfqB5qukSHvzZn5KTFQPW571ID0kiYucBuYJ4m2GyMiUtlN7AgVofwYjvWzTZkqdOegGF+NjCZVhCJRECm71L16SYkooGWy6aUACBjU/+hj1XE8m6xYMtSzTsaBZsKDY5sjbnmFKXqLpfAewkc1lmVHRr2eWfb7IKcrn6sj7ZYHirMQpZLApbCYlKi3isV2UKd+Q42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i933dvB78A3s1ehF8H1jCqsle0UkZm35gpPMszJblZk=;
 b=njf96wWxh5MoPfg8OgwO8B1quMB7LNyHtlPgLInijgMTPlm9or1gmDRSZjTy5pE7bXri+VjAiZCvTG1hAA4FXYfWR3b37g+BsINqvSvk8f/MwGGnTnkM4/d5VGGjSxCt0hgOT9z1aNkXnQ3muoHFvU/fAuoBtmFMbiQG879WaFAugyCV3fCOBvBGkiem2BJ5DkJ8Rc+miXW9KdBzq1BfR99UJFzEvVCiq8XpVOUSfJO7U8WUq4erMTf8HBe9eMci6CVFk0CGH6gZzxR7sQ/IVBZLepUxq/4snZZ/VgrP6aQR/Fgm8guRe+tjox0fkOEEPuVr74p1HWqk01SBgU2l4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i933dvB78A3s1ehF8H1jCqsle0UkZm35gpPMszJblZk=;
 b=k3ln43bkU8isYKO1iTC8Ail5yqO/txeF5AYHPwtp9Z8No4BUIOKrlR7ADI+sIStnFEo8gdYXQ7uUhKO3lqnhSmjqMNErKiYBkBPM3M3gvFlO3k1YuIiYzXyZ58FpP3iXxSPeup1ZmKaBYUC2dPJblYUY2avRLsXq5dZTRENDDrEmmGN9GjRpzAy9h/g0ZXgLHyOpTwX0y0COQNWpDWrmbsmSZpYbYVs0ki5DHz0Rehm8uPKdUU58I0MS7I78WjHKo7KEORUepDG51uAib3pUeG9ocSuMbVw2Ta9cBI3yBUNef9oa0uTnoLnIxTvEF6CDXQpIpCP/PisnUd1LAKWqqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:21:28 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 15:21:28 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy 7/8] phy: lynx-28g: truly power the lanes up or down
Date: Wed, 14 Jan 2026 17:21:10 +0200
Message-Id: <20260114152111.625350-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114152111.625350-1-vladimir.oltean@nxp.com>
References: <20260114152111.625350-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: d710effa-845f-4f05-3dd1-08de5380969a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?inNiyvbA4bGX+lGtQGW0vs53+KtW9Z75RjhAj3UpvA32Jm3ejm+mgNgALGvS?=
 =?us-ascii?Q?bJZenvDfBu3hqHKqqB8a4cFzX9jJgbe9YA9P314AfsYwNH0YMRVA3V7eghsj?=
 =?us-ascii?Q?fftHwUophwyHwtF4REsmTGpVHduA7lxtZwQce56+AYPd6vKK/wXBtQio8Yzq?=
 =?us-ascii?Q?KLefLPuZ9Drcz9Y92tpcFsuadCZeu5CSe8scZAZrNBQr4KDv/h9LLmVfvW9G?=
 =?us-ascii?Q?b3aeJ4Yhhy2jUrAFX/YZZxv93g1EW23Vs3U98B9fDrJ/R87PnNmm9M3oG/IK?=
 =?us-ascii?Q?zgDwABu4vU5W+v6jIgY/u04zQO4FFWGZ9h1rNtrmGDjmTwwTJwKrgRPVr0+v?=
 =?us-ascii?Q?H/oB8y6Q9OsUY/gAzfw0GM3eh14uvJ6ITgK5DnGe70Wuwai0yPREYBTM4Ce+?=
 =?us-ascii?Q?bQB0xS360/0H/msr0nl8nAkbktd6QfnnIcFyilVGu2kjWB9Gr73Ylvfx0CG+?=
 =?us-ascii?Q?WltKJIboEMZn/5WwU7NYvjIu6ijastoKHWrZZMa0GllU5TK8AXnYpG8mMS4u?=
 =?us-ascii?Q?CMjBLtVlx4Njad5SSv6CoU8TyW4negO5xPm/2giYSDQBNJ9PrLePPlVPqnCU?=
 =?us-ascii?Q?O2D8g1FkUv7reG7gThVMNPrrjXNPXzXyvuUn+0NWozFyjfHY7BskzNm2t9ab?=
 =?us-ascii?Q?naKfAzjBuLtwe76eW71ujppGO15R+Cz9X20adMZdassjwLQpUtTOfiiYdDfY?=
 =?us-ascii?Q?lFeUq52TNs75rYodJIsFN8hJdkh30uWn+nwTTgXsB51QCpYs1G4cHOuIoLEa?=
 =?us-ascii?Q?wi5Htz/F5fZh6fBQk4GDb6L7tRXQgpk6s95bS7g1N1ZwyqHfmeFLmMtsJZQo?=
 =?us-ascii?Q?B4UlHwhMUhIaZNmmFdpl+l+EiccCqf4fAnHdrvusDfYuaS6A1/Txx3zN6Cd3?=
 =?us-ascii?Q?ABrcW6A9pM3Vmxifp8rNE4tFP9c7rx7ZWzvVG9Y8CrUgAMNXTD/Rx0QqepF1?=
 =?us-ascii?Q?Js0WNMAplkSCJEYHtmv8+KedUd+QUBPxGHA81PFwoPD2rky1iarhpN+uddgt?=
 =?us-ascii?Q?H5h2r6eNYJB7hCTzYLvm01+UeCgouSNKgIU/mjXvT8qjq1RejISleXrDNa7w?=
 =?us-ascii?Q?DY1btIbTDYQQ3lHybaXi9KJdovhFDh6TZynTI2h1iF/pl3cxtnPYDTOsqfwd?=
 =?us-ascii?Q?e9Tz58/ny3OZZrFQ2aqADCXW8dFzO42g7y1wq/Axpe58vCn3ewnDgBERnWdl?=
 =?us-ascii?Q?rTm0mpNiYg3DqfSX6wTdGFcOXTY8nakVGNVbj64KfSOYDx7n+DA3Y4g0jVsw?=
 =?us-ascii?Q?g/DNrJxeqdi6mymrHaaro0MN6exKHQ0BwPnxdbY9c3TbOsdMrFa/LczZi/Ql?=
 =?us-ascii?Q?hOlSt7dgYM1EEjmgBNAjFEX9iueh6VLy10IKH5eYXBzxs3BxfoWc4cZKacwN?=
 =?us-ascii?Q?wEyJW/6wTKE0pTqktqZk+x4+wGETc8tzgkOleuBMsLB4OmgQUO1/yEV/m6Lw?=
 =?us-ascii?Q?ux64h4sSvf8Ba5w4AGZ4mMX/PyGrklBYuWzCCXCN35ImapPiUS3thCsqSH0U?=
 =?us-ascii?Q?Te3R5iaQrcFLYDknvDpA0TbSz0/6XWyjsJfeHtoPbGNN6qOSqBZ64R+twi7a?=
 =?us-ascii?Q?mIAqyMOBcoQbrUfK67fyIisvlqNBgWYD/hrd9T9FZyOq/omE67EcH2AVOgKp?=
 =?us-ascii?Q?e0vNCH8ad/wUN5nJRlMatfw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pD5CNUxjJ+W+PMVnYWlviWiAZj1b+wsC8zd+JZe9/eR1uf657jDV+pLt7VkG?=
 =?us-ascii?Q?HP3+YZziZMH0yOoRrTmutK++fOEz6sV3EpHdgQ9K6+eHmDD9RUcGRBNXHSP+?=
 =?us-ascii?Q?SbSshHwazQIMm6Mf/GhQHzojxz4JSmUBM/6R6zFy6obz/d5mdUoIsOTZaPGa?=
 =?us-ascii?Q?EjWclvx/8n7jKzeOSbjmsv5YjO5OAtJ6sqOPM0pJIVpEltNaXf24iVswAsq+?=
 =?us-ascii?Q?qh2p61/kqWkHN3B/hQivhK8jxbHQsYwcfR90708rV02DjPFLhdlgh+MWnw8P?=
 =?us-ascii?Q?uVYuAELUbYs7NZHBVdPeyN9gdKjK6mfZ8v3oOb6b88dNF9gmmMBh0BCHyfZa?=
 =?us-ascii?Q?ZWo4i5Uq2ATZ4udc8THMrAGMt7ikHeKFBZFTqqzlXEOngc+ZlcRx324bX5UO?=
 =?us-ascii?Q?aCNe0KhHLluxYNjdpyFplgSLxcB5yP7luvVgyxh6VRTMoTKfiR5ciky6YDgf?=
 =?us-ascii?Q?/pxOuEQCPnOly0eD98b0CUvBr5F3aOayg2kOevrqCcsK+ATxcNgpVDel69GX?=
 =?us-ascii?Q?pjYmpndwE//8PJhhmvT2IDct7J2HSTiGYMvt1IAT26ZzMjLH2Mr2xeXIrOaF?=
 =?us-ascii?Q?8aQO+G81umtBeqPqf0GTXOd5XphgfuFknMjUKIejctV5hKnAypIIUEX2q1UO?=
 =?us-ascii?Q?27Nvzgi6aCmI1LaxirCchtGnciQkRVNlKeunddQZbksoPg6M+s5e+tGdH7ec?=
 =?us-ascii?Q?UgE/Vlu9Pr98BS0uxlXL5hIOmLxzp6wsYXazkFZoJEagIlmvzHunSx9kPkFk?=
 =?us-ascii?Q?U6OZZaMe5RVpqYvuugvUjNg4E6MpfbrolOsgMH+YlmcPaxFLoOC9wqysdE5W?=
 =?us-ascii?Q?N1k+O5LDmducvsB8Us2O959rJZpf75b0EHCIXZhteHWiRl2eoLD4C9GreqRd?=
 =?us-ascii?Q?VyDtFV34CZbnaxtqIT5NMur3N4oRE83NWVc4+M7YqmaXaroYAbgZXjQciW0X?=
 =?us-ascii?Q?gvEvtPaW14qa6UM+Nq0sd7vhMhMUthF58VzxUbbPI44NWtq8JQaHMIxQ7kcr?=
 =?us-ascii?Q?Yx73cVzmnipdiGAiQxCzeZ1vk1mM8Oq62xsyoPto5kqSojeaN2uzMGkL5RKf?=
 =?us-ascii?Q?+qdwQunupWky+lqJrsnZXJi8uR2+JuhzOG206wtRm5TDNxs38gPecc+PHpxN?=
 =?us-ascii?Q?4sTRVs+ZqStrenvNJSehAZGCpMydsTT0NO/TPFweAKB98tAKEYwBQ/hbfptL?=
 =?us-ascii?Q?SHl7NRsD5Ou1nMF8sDCJJLTwL9B8+TOZS1OjQuSOeHwo7lrk5iowOY2iKO3R?=
 =?us-ascii?Q?+YBa89Hke74Eld3KIT99mzxjF+DXMJ7vRIttV+gCJGV+Rmwc9X6h4Ur+0sSD?=
 =?us-ascii?Q?MAFipGUgmWFJuc66HaPmDx9z+had2GfaaDcOqCXUAv/0WEuLeUgUUhtOe1ub?=
 =?us-ascii?Q?ZYIdMUKrwHz1u1nGfJEDcrJOZYbwCS0I0YS5on/J4H4KlB55bSl0nF2a5FLU?=
 =?us-ascii?Q?PlxwJfg0VFzgMn6kYzFJjMFYGeOmFVCE64aLLhzp1SN9Je3jk0l3Bh8f3BXb?=
 =?us-ascii?Q?+Dl+w3/xmQPMf0sn2SKwkuskJuzMuIhkfiuaXJ2cZF4N0VnAJ6Z0jZfYVVg+?=
 =?us-ascii?Q?1LuaO1OYF4mu6CqJ6r3wgKLBpzj7vkRqtJE78/oYwvh8RbX96CyMd9UyhyHR?=
 =?us-ascii?Q?nJd7zYzdndLBUxVYp3OtyOeTOtBHLucgVb355Acs2fcbjvPw+qSCfEV2QOsN?=
 =?us-ascii?Q?U3ZKLk37swR7phGSvLw9XXbKfDFgMcFsYqWdNSfI/vUFJwgF0qOlEX3H2vi1?=
 =?us-ascii?Q?YRtsYxibboO/NOO2OwqyaE2fSCjNdXQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d710effa-845f-4f05-3dd1-08de5380969a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:21:28.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vo1iqkcT4SoFlQqZu53AHKDFlRHQf8LLhB2ANpeos2TqlH3uyhkEJb/nanK8OLI2DFX+MIDbfVfm+eohFNfBaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

The current procedure for power_off() and power_on() is the same as the
one used for major lane reconfiguration, aka halting.

But one would expect that a powered off lane causes the CDR (clock and
data recovery) loop of the link partner to lose lock onto its RX stream
(which suggests there are no longer any bit transitions => the channel
is inactive). However, it can be observed that this does not take place
(the CDR lock is still there), which means that a halted lane is still
active.

Implement the procedure mentioned in the block guide for powering down
a lane, and then back on.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
part 1 -> part 2:
- minor commit message fixup

Patch last made its appearance in v3 from part 1:
https://lore.kernel.org/linux-phy/20250926180505.760089-17-vladimir.oltean@nxp.com/

(old) part 1 change log:

v2->v3: reimplement lynx_28g_power_off() using read_poll_timeout()
v1->v2: slight commit message reword

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 99 ++++++++++++++++++++----
 1 file changed, 83 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 048c24c48803..4c20d5d42983 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -73,9 +73,11 @@
 
 /* Lane a Tx Reset Control Register */
 #define LNaTRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x20)
-#define LNaTRSTCTL_HLT_REQ			BIT(27)
-#define LNaTRSTCTL_RST_DONE			BIT(30)
 #define LNaTRSTCTL_RST_REQ			BIT(31)
+#define LNaTRSTCTL_RST_DONE			BIT(30)
+#define LNaTRSTCTL_HLT_REQ			BIT(27)
+#define LNaTRSTCTL_STP_REQ			BIT(26)
+#define LNaTRSTCTL_DIS				BIT(24)
 
 /* Lane a Tx General Control Register */
 #define LNaTGCR0(lane)				(0x800 + (lane) * 0x100 + 0x24)
@@ -102,9 +104,11 @@
 
 /* Lane a Rx Reset Control Register */
 #define LNaRRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x40)
-#define LNaRRSTCTL_HLT_REQ			BIT(27)
-#define LNaRRSTCTL_RST_DONE			BIT(30)
 #define LNaRRSTCTL_RST_REQ			BIT(31)
+#define LNaRRSTCTL_RST_DONE			BIT(30)
+#define LNaRRSTCTL_HLT_REQ			BIT(27)
+#define LNaRRSTCTL_STP_REQ			BIT(26)
+#define LNaRRSTCTL_DIS				BIT(24)
 #define LNaRRSTCTL_CDR_LOCK			BIT(12)
 
 /* Lane a Rx General Control Register */
@@ -260,6 +264,9 @@
 #define LYNX_28G_LANE_RESET_SLEEP_US		100
 #define LYNX_28G_LANE_RESET_TIMEOUT_US		1000000
 
+#define LYNX_28G_LANE_STOP_SLEEP_US		100
+#define LYNX_28G_LANE_STOP_TIMEOUT_US		1000000
+
 enum lynx_28g_eq_type {
 	EQ_TYPE_NO_EQ = 0,
 	EQ_TYPE_2TAP = 1,
@@ -687,6 +694,15 @@ static bool lynx_28g_lane_halt_done(struct lynx_28g_lane *lane)
 	       !(rrstctl & LNaRRSTCTL_HLT_REQ);
 }
 
+static bool lynx_28g_lane_stop_done(struct lynx_28g_lane *lane)
+{
+	u32 trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
+	u32 rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
+
+	return !(trstctl & LNaTRSTCTL_STP_REQ) &&
+	       !(rrstctl & LNaRRSTCTL_STP_REQ);
+}
+
 static bool lynx_28g_lane_reset_done(struct lynx_28g_lane *lane)
 {
 	u32 trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
@@ -696,15 +712,13 @@ static bool lynx_28g_lane_reset_done(struct lynx_28g_lane *lane)
 	       (rrstctl & LNaRRSTCTL_RST_DONE);
 }
 
-static int lynx_28g_power_off(struct phy *phy)
+/* Halting puts the lane in a mode in which it can be reconfigured */
+static int lynx_28g_lane_halt(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
 	bool done;
 	int err;
 
-	if (!lane->powered_up)
-		return 0;
-
 	/* Issue a halt request */
 	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_HLT_REQ,
 			  LNaTRSTCTL_HLT_REQ);
@@ -727,15 +741,12 @@ static int lynx_28g_power_off(struct phy *phy)
 	return 0;
 }
 
-static int lynx_28g_power_on(struct phy *phy)
+static int lynx_28g_lane_reset(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
 	bool done;
 	int err;
 
-	if (lane->powered_up)
-		return 0;
-
 	/* Issue a reset request on the lane */
 	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_RST_REQ,
 			  LNaTRSTCTL_RST_REQ);
@@ -750,9 +761,64 @@ static int lynx_28g_power_on(struct phy *phy)
 	if (err) {
 		dev_err(&phy->dev, "Lane %c reset failed: %pe\n",
 			'A' + lane->id, ERR_PTR(err));
+	}
+
+	return err;
+}
+
+static int lynx_28g_power_off(struct phy *phy)
+{
+	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
+	bool done;
+	int err;
+
+	if (!lane->powered_up)
+		return 0;
+
+	/* Issue a stop request */
+	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_STP_REQ,
+			  LNaTRSTCTL_STP_REQ);
+	lynx_28g_lane_rmw(lane, LNaRRSTCTL, LNaRRSTCTL_STP_REQ,
+			  LNaRRSTCTL_STP_REQ);
+
+	/* Wait until the stop process is complete */
+	err = read_poll_timeout(lynx_28g_lane_stop_done, done, done,
+				LYNX_28G_LANE_STOP_SLEEP_US,
+				LYNX_28G_LANE_STOP_TIMEOUT_US,
+				false, lane);
+	if (err) {
+		dev_err(&phy->dev, "Lane %c stop failed: %pe\n",
+			'A' + lane->id, ERR_PTR(err));
 		return err;
 	}
 
+	/* Power down the RX and TX portions of the lane */
+	lynx_28g_lane_rmw(lane, LNaRRSTCTL, LNaRRSTCTL_DIS,
+			  LNaRRSTCTL_DIS);
+	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_DIS,
+			  LNaTRSTCTL_DIS);
+
+	lane->powered_up = false;
+
+	return 0;
+}
+
+static int lynx_28g_power_on(struct phy *phy)
+{
+	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
+	int err;
+
+	if (lane->powered_up)
+		return 0;
+
+	/* Power up the RX and TX portions of the lane */
+	lynx_28g_lane_rmw(lane, LNaRRSTCTL, 0, LNaRRSTCTL_DIS);
+	lynx_28g_lane_rmw(lane, LNaTRSTCTL, 0, LNaTRSTCTL_DIS);
+
+	err = lynx_28g_lane_reset(phy);
+	if (err)
+		return err;
+
 	lane->powered_up = true;
 
 	return 0;
@@ -1167,7 +1233,7 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	 * the reconfiguration is being done.
 	 */
 	if (powered_up) {
-		err = lynx_28g_power_off(phy);
+		err = lynx_28g_lane_halt(phy);
 		if (err)
 			return err;
 	}
@@ -1183,12 +1249,13 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	lane->mode = lane_mode;
 
 out:
+	/* Reset the lane if necessary */
 	if (powered_up) {
-		int err2 = lynx_28g_power_on(phy);
+		int err2 = lynx_28g_lane_reset(phy);
 		/*
 		 * Don't overwrite a failed protocol converter disable error
-		 * code with a successful lane power on error code, but
-		 * propagate a failed lane power on error.
+		 * code with a successful lane reset error code, but propagate
+		 * a failed lane reset error.
 		 */
 		if (!err)
 			err = err2;
-- 
2.34.1


