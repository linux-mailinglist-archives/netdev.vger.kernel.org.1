Return-Path: <netdev+bounces-251063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E747ED3A893
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8648D3028B38
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B3F326926;
	Mon, 19 Jan 2026 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TO4XBn0e"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056127E1D7;
	Mon, 19 Jan 2026 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825219; cv=fail; b=mZ3VVnRa3JLacG48jfyrPJOpMkLJunw9/MAjucZsYgKpG7GsYSeg/j+CicwH2SbyhaPbwR7PXZAgQ4GGP3SMlhR/qB3VgSc3bwXAZ6cNDsGQMxnRCMzrLiffYbhbJDWatYigBBUXWNL+MWpwpny4wSOaJc3vfoclmBE7wDBKXy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825219; c=relaxed/simple;
	bh=NUKqHHjrZkw0JYeIbXGjWTjwM37ewhL7GgeGBbh8ne8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TWHCRgAjd/qtv3CHGx7FdeCJ+MTUVuMzvxJQ9kO+5XOZbW0y1MUzKXMhtT5FK+U0IGymuQz8iYRjp4hnSeKbhFQ+cDnZIZS9FdngnYA4ycWpg5ivX/iuEaDDneuSvTTBDNehsDSfHIcT0PNp69syRpOi1DG4XE1//GH8Ml0ulIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TO4XBn0e; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tva0Mm8sU6L0H8H2ESvVCQFaNHYTLVNUVvLHfRZsEm8g8BB3hYg08dBu6BQNG7m3v7+aVrNVzlomCqlKg8BlHgUgb3c8HZX6+3Ob5MDJExAwq1+/gU5ctuUIgozwAMEQ245es73B0LxjpOHaMJMehJFMVH+1VcQciUXeRmQa6vD3SLNxWD0icfQxk+R7Fd+MlfhoDrKxOfsw/8VjO6fGRtqj6gvlsaBL6MvurcrUv8Bon6P1S1wzz189iAiov+pHbQYU70wXKqdV73QU1bpVn/JQLHP6eNUsPSCxqGjf3psSKpFmDk3DxMNnwzDvIBXAaEayfFOgg84sg1VBRXCsvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq6/RxXI62xZitCYidjzrU1mfoZIsL5NDFo7oz4c+qM=;
 b=pb8x0rLfcJNFMBV3+zneNa000MRNImuxF5tVXD3dsrVHJ67H9ulEHLaI0MnA4CzVtRr+MnGn0Ko0BOUJUVOusxxslm0tL6w5TKTkUyO1qVHdEV69k8foVnur+Xr9TJeBLd+blGG4caIJxc5LFuPUrt0x+G7LQ7LidLwHi+/EGh4CWl0LTA1PvlHmD392q3Eb5drpEs+u+v6iFUBtXFLIk0yQiIjzvzKKRWJTGT/wErcPpfhDLfBg93gsW+9Mkz6GLS5lNtQR3P1/YObqFiR+8U4+vtHG2LhY6/3PG6VHfmyXP/4h65MYtoJNfjo+3aZPDoGzVutaIubkduuIBQ9Ayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq6/RxXI62xZitCYidjzrU1mfoZIsL5NDFo7oz4c+qM=;
 b=TO4XBn0eNDEIW3MJJDif8dIjd0v+a3CbFj/N3xLXoopNKeaNE3Y7viThn3BlPOsBK9w/0mj8jfmPqKWuw/63GdXRdXqCxzoytBL5bMd3myp8TYL6aE8C/R7StTjQ4SiQmkpsm89jbpbujJxUPRQEdbi7lmhTGLyPLap44EeGsRFd6NmiOg1qH0PqjgU2VAn3hB0jtwFzCdLJPOtScPLTA5DWcZ8ucs1h1zPUV0G6OeK6PyK+BXwCitTSouPqeocGGue6Ntrm2HqmtFB8GNaWy1ME74MyYE4DiX7ByctFCPY9q/b0dKxK3b3ICQgG5bnkv0hswhcrENJcrHiSjIyO0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 12:20:07 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:20:07 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 3/4] net: dsa: sja1105: let phylink help with the replay of link callbacks
Date: Mon, 19 Jan 2026 14:19:53 +0200
Message-Id: <20260119121954.1624535-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
References: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0171.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::8) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d03062-7981-4329-21c6-08de5755152e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QUTVudPAuCCjVyXW0w/AKaRbLOBDqNnQC3tddkoqio0YuuOJ+6ZyGj4XjSfk?=
 =?us-ascii?Q?MU8K7+1dRxumbkaSg1f9l02iCKnnXmB16ElsyWSIqeEvnknxlDY0HQYpgVYV?=
 =?us-ascii?Q?ZgD01PPGnBhMI7aQIG9Gk/G+o7b2vf3LL6yg2LU69NMXwIPIYbwol9AafEKG?=
 =?us-ascii?Q?3tJvFmIiZleD3kB1l+Gs+6hkmwxuJWVAOK8EwWA+LAKYSIUsiPpnoLGmdIcV?=
 =?us-ascii?Q?H601dbyWgaIf3LokNV73FJ2KZg0Z2KS3Mx++84iJI+6kP601Rc0DD6xoq44I?=
 =?us-ascii?Q?2D9nhSOfNqCX8ZwZPJV3lFZRkeqjF2fgOfxSL3bZEDiilgrBrZSy7KOFlc4f?=
 =?us-ascii?Q?dCwn6cGrFdKhHcIvcjsTGl/CB7xr5gDXwGws+UUT3wjLPeWMv0V9AGd4cwuo?=
 =?us-ascii?Q?uZW0g9dmhYF8Zecl0WdDptIYQhOqUiNIt4CUz+01bkv/gtr8Oo5J3a/iwZ60?=
 =?us-ascii?Q?/RLuwILuAHtUL9GTqKx+upo3rS4MvugJM2LRlvDt2fNrrwtclDLEWQwHd/XN?=
 =?us-ascii?Q?w2RCqntXP4fSZb+9YB35fkFAuQnthqk/jbGQWqTsEOyxk/R8eAGiu9tFhJ8E?=
 =?us-ascii?Q?ChFj7Y6JG4qO3+wuHntslPPelgcvnVfDjEx4IyjPb81x4qCOE/RM5MPwBt0Y?=
 =?us-ascii?Q?S9nlOEMFp9y77j30o3u+zViixVkeJL/uuoyUgqBMb1O3oX3WZQX0XjhyRkAY?=
 =?us-ascii?Q?TYh5grpAD9mMuQ2tqMcCmrtXIgXYiA9DoFAVo6NTlDn5kFsXlOk0ZLShKO2W?=
 =?us-ascii?Q?Ej0nNsmIrlUmX/szUOxlntxmGE2CeW5OaBZk6qffusH7jeDHKM/j2ef8QJ/b?=
 =?us-ascii?Q?DztmocLO12FbNiNx5AHaiDMYZbSKgBrTRaXvQOFxjH8UeY8SfNJV6njAcFC3?=
 =?us-ascii?Q?A8gxa8pfYFh5m7xTc2ybqev4yIH/rBJTaifq5uDbHGPD5MvJun5T9l/JoyAe?=
 =?us-ascii?Q?TWGbN32TmsQK5jiMEdN74JYboQFvHdyOqHS+QfTcb9ZLsTdH5OoMekGW+XXP?=
 =?us-ascii?Q?wWFPGGc0fYc/Cn+oKIwlap3eMBQXr87ZIvXo6nrmzhW/ykN/jg933rY2SKPf?=
 =?us-ascii?Q?ejAyZndz/qEPG2Eo3nqr9YdYADDv9wjBUeFutxWVPJtKcBRjUCRH7MiPgwSn?=
 =?us-ascii?Q?udQW16EOstsJGEkqQOacKMYDMhyYk2aKtvTHo82MtCjrGaKre4US/Y6W0feU?=
 =?us-ascii?Q?kHpiBQRtO6/2R4VT/ZyJ053GvXEnt5DfWyc9pGxfxHcD+WYsI86T18G/pAz8?=
 =?us-ascii?Q?2IPfmI36prhVDOikRNkEJsenxIqRijRUdOQCQayZx1E9iiPXzEiPoiO3rd/c?=
 =?us-ascii?Q?cGkOCYQ4QBSULISWnx/0kgXt+eYaiLjfbHV2uROn1vg9JZU9AirYx/5OHUX3?=
 =?us-ascii?Q?K2DpCfWBBmTcd2KrWaX2nxrsw5Ti0SY6URZ3IzO550G3BPPK6TBaScLkdv1J?=
 =?us-ascii?Q?zezofllmRIEart0CsPw8Iemax/er2KqSm01h0YR92bC4fNGgTi/pBtQQAx38?=
 =?us-ascii?Q?7zplZRaDqgCDnKN4YQx12JMtQNsQpA9zWAppU1J+kUx4kpaZVVPSYIyMkpzJ?=
 =?us-ascii?Q?nyBrbc/Cj1qN5XH1PBzAA2J5scoUheawQfzFmtKTkudGL/kv8vCA7TlWWiQ8?=
 =?us-ascii?Q?gNECwsZ5yVp/TCGZUXZSjiM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dj34WgLRILI6tJ67fE2cDyW3f5k85V4NUDyV+1TfcDylvu1I4dUH1PWBknAb?=
 =?us-ascii?Q?vIm1yywiUf8U/IH2pcKzsgXZRIsSARwn2CFypM5c92P5xJ4kX0oZbaPt4H8Q?=
 =?us-ascii?Q?KSt3NCxAw3UDgrVHaD9XH+IdJQziR0QCjNwKuL1yF2gqEGvODwAYrMs0Y1xG?=
 =?us-ascii?Q?zEsKX8RgfnJnbDY9SwzFipdXKoRUxZIwJWbz4bkFu5I+OnGT36CtiZ41EPJR?=
 =?us-ascii?Q?J+0SG937j3T2q/Vv/xS/7r033BHtTjH3+Sl/pAdGo1LufaeeNVlzrAFK09Zf?=
 =?us-ascii?Q?aVaLJXARUiNqDP2Ippw0ESSXrmSKoIW1qZlG6RHvH2ekz1XRh1DVL3CCcXFs?=
 =?us-ascii?Q?KFs2WCLcjXhVDCmCfMN7TK/HXPj+O6T9t7NQt1i3LkgR9QNkoQIT3fSLYxGx?=
 =?us-ascii?Q?VwL70pVcQ8lClRql+fJZLeYn08jIx9xZD3gaBuYon55wt3KIA3Ifr/cBZ4uj?=
 =?us-ascii?Q?wQ9XTDRi1xzYH0Z8Dr8pgJ2OSuBwnvcMqAPTfplbTglwXdaTvUnIeDDrK6fo?=
 =?us-ascii?Q?bChEyIEGHyx39HyYEqGGrzxQKJvg5lKEVczkpOVgMBEH+NTqmsyfEzzSrTeH?=
 =?us-ascii?Q?Ajxibh/PU9+unxY4sKFLuBvWb51d+1+85jfRrBWO+RteafmBbnHbd4I+qNkt?=
 =?us-ascii?Q?NsHsIpEg3bL6Pup7WYLbeLcyNzzJwf60l1W+UBKDvsOFSjqSuTP56/6OIFx2?=
 =?us-ascii?Q?lbHfhUK8dH2+M/h5evmAyLmta5iiNOMnyCBeV8R/INO1tfVVXTqhkZwShsrC?=
 =?us-ascii?Q?9E7gbQhfaaYhrzGXs3o02TqoFi0XdL5lcwtRAN77Oln47gVBF6yZP33w74x5?=
 =?us-ascii?Q?nf+qp4b9T/Rxw5xGHLQgo/rrRcrEKptfhQ4uPPUOzEX2XN2smo8S9oEA8QmK?=
 =?us-ascii?Q?LjEU34tawcTeapreShbyV3P7rRRjnTwiBtkSq1cMhByYWRE1fNRjkORp1JVH?=
 =?us-ascii?Q?h6EsaYroWp9VXWdHTX/ALSgz/SzYpK826/B65jHvJKbOf8+9dzm9/CdD1XiK?=
 =?us-ascii?Q?i8S8jlGLZkvpkg4iZBu+/jswoKLyA23YSn9Xb8Kngx+Qo6bdViQ2Am5mlkRv?=
 =?us-ascii?Q?0EvQ6HuRCVJN93QzrTfbW6liIPQt4OXpCn1s0QfKDDPWhk93J9vxiqcU8X4g?=
 =?us-ascii?Q?YlYZ4d7raIVsUcF+/b3qx8ZIq+f4ftwVMjPITq1gkIc3/4eZonS7Pn5j+LbS?=
 =?us-ascii?Q?NxhW4cF1DZ3bivFjBP/UOm7Ur1S9aOF9MLdTPf0/dQy643sojarc1btjJOLp?=
 =?us-ascii?Q?Pa0n7ryIKDGxBrAu2wfhFMgAfLVpE9x5jQyg+0vZ0sT/2uDSRJKRSxKnr1b3?=
 =?us-ascii?Q?9rq0rqwsvNPIM/OLUXKJNHWoVo5IrBHlowJ9ay0kQoLcGN+3D8Blz3uiF5u5?=
 =?us-ascii?Q?RJ80YWMhh5kxhLLJMQoK8KbstbWJBl8NveLjBkwU/HQlDx7/Ndhk9N17rbNt?=
 =?us-ascii?Q?e3yrgpDK1VNuJorPRBcEiQL2SjNJwYkfVhcVHAzrNG0rk5VxwEUuu2zqBRsO?=
 =?us-ascii?Q?qAlRthCNVOix2sR6RD9jTrX/M6xAKcz5qtYzvc6HLivAl6e5ldFutvaOkgsu?=
 =?us-ascii?Q?jJXvV+zOKn5gumzh1B4k27BHwcHOBRWHHvKlXygv0ZkbEO8Mpv2MzJEf0Sj0?=
 =?us-ascii?Q?OVWsdFjbGTz9bhb+YR2fceWm0LRsHsAbeEk8GJ6bGtou4OCAI+SV58FnFIgq?=
 =?us-ascii?Q?9WG1+Cc+Ayut9a0dgc/rkNoDqcLKg4Km1UVVycCADeU6jRXrEPJUudDSxGe2?=
 =?us-ascii?Q?HPECz5+Ivg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d03062-7981-4329-21c6-08de5755152e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:20:07.4052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Pyka763qpzuT6JZ4sRTTC+tK8dC1HhAI0X7Dj9MTaNJmLp6hxx8ceoJtb2OF1iPSlzREbk3gwKN8d2JD01PTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

sja1105_static_config_reload() changes major settings in the switch and
it requires a reset. A use case is to change things like Qdiscs (but see
sja1105_reset_reasons[] for full list) while PTP synchronization is
running, and the servo loop must not exit the locked state (s2).
Therefore, stopping and restarting the phylink instances of all ports is
not desirable, because that also stops the phylib state machine, and
retriggers a seconds-long auto-negotiation process that breaks PTP.
Thus, saving and restoring the link management settings is handled
privately by the driver.

The method got progressively more complex as SGMII support got added,
because this is handled through the xpcs phylink_pcs component, to which
we don't have unfettered access. Nonetheless, the switch reset line is
hardwired to also reset the XPCS, creating a situation where it loses
state and needs to be reprogrammed at a moment in time outside phylink's
control.

Although commits 907476c66d73 ("net: dsa: sja1105: call PCS
config/link_up via pcs_ops structure") and 41bf58314b17 ("net: dsa:
sja1105: use phylink_pcs internally") made the sja1105 <-> xpcs
interaction slightly prettier, we still depend heavily on the PCS being
"XPCS-like", because to back up its settings, we read the MII_BMCR
register, through a mdiobus_c45_read() operation, breaking all layering
separation.

With the existence of phylink link callback replay helpers, we can do
away with all this custom code and become even more PCS-agnostic, even
though the reset domain is tightly coupled.

This creates the unique opportunity to simplify away even more code than
just the xpcs handling from sja1105_static_config_reload().
The sja1105_set_port_config() method is also invoked from
sja1105_mac_link_up(). And since that is now called directly by
phylink - we can just remove it from sja1105_static_config_reload().
This makes it possible to re-merge sja1105_set_port_speed() and
sja1105_set_port_config() in a later change.

Note that my only setups with sja1105 where the xpcs is used is with the
xpcs on the CPU-facing port (fixed-link). Thus, I cannot test xpcs + PHY.
But the replay procedure walks through all ports, and I did test a
regular RGMII user port + a PHY.

ptp4l[54.552]: master offset          5 s2 freq    -931 path delay       764
ptp4l[55.551]: master offset         22 s2 freq    -913 path delay       764
ptp4l[56.551]: master offset         13 s2 freq    -915 path delay       765
ptp4l[57.552]: master offset          5 s2 freq    -919 path delay       765
ptp4l[58.553]: master offset         13 s2 freq    -910 path delay       765
ptp4l[59.553]: master offset         13 s2 freq    -906 path delay       765
ptp4l[60.553]: master offset          6 s2 freq    -909 path delay       765
ptp4l[61.553]: master offset          6 s2 freq    -907 path delay       765
ptp4l[62.553]: master offset          6 s2 freq    -906 path delay       765
ptp4l[63.553]: master offset         14 s2 freq    -896 path delay       765
$ ip link set br0 type bridge vlan_filtering 1
[   63.983283] sja1105 spi2.0 sw0p0: Link is Down
[   63.991913] sja1105 spi2.0: Link is Down
[   64.009784] sja1105 spi2.0: Reset switch and programmed static config. Reason: VLAN filtering
[   64.020217] sja1105 spi2.0 sw0p0: Link is Up - 1Gbps/Full - flow control off
[   64.030683] sja1105 spi2.0: Link is Up - 1Gbps/Full - flow control off
ptp4l[64.554]: master offset       7397 s2 freq   +6491 path delay       765
ptp4l[65.554]: master offset         38 s2 freq   +1352 path delay       765
ptp4l[66.554]: master offset      -2225 s2 freq    -900 path delay       764
ptp4l[67.555]: master offset      -2226 s2 freq   -1569 path delay       765
ptp4l[68.555]: master offset      -1553 s2 freq   -1563 path delay       765
ptp4l[69.555]: master offset       -865 s2 freq   -1341 path delay       765
ptp4l[70.555]: master offset       -401 s2 freq   -1137 path delay       765
ptp4l[71.556]: master offset       -145 s2 freq   -1001 path delay       765
ptp4l[72.558]: master offset        -26 s2 freq    -926 path delay       765
ptp4l[73.557]: master offset         30 s2 freq    -877 path delay       765
ptp4l[74.557]: master offset         47 s2 freq    -851 path delay       765
ptp4l[75.557]: master offset         29 s2 freq    -855 path delay       765

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 58 ++++----------------------
 1 file changed, 8 insertions(+), 50 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index aa2145cf29a6..3936d63f0645 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2280,14 +2280,12 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 {
 	struct ptp_system_timestamp ptp_sts_before;
 	struct ptp_system_timestamp ptp_sts_after;
-	u16 bmcr[SJA1105_MAX_NUM_PORTS] = {0};
-	u64 mac_speed[SJA1105_MAX_NUM_PORTS];
 	struct sja1105_mac_config_entry *mac;
 	struct dsa_switch *ds = priv->ds;
+	struct dsa_port *dp;
 	s64 t1, t2, t3, t4;
-	s64 t12, t34;
-	int rc, i;
-	s64 now;
+	s64 t12, t34, now;
+	int rc;
 
 	mutex_lock(&priv->fdb_lock);
 	mutex_lock(&priv->mgmt_lock);
@@ -2299,13 +2297,9 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 	 * switch wants to see in the static config in order to allow us to
 	 * change it through the dynamic interface later.
 	 */
-	for (i = 0; i < ds->num_ports; i++) {
-		mac_speed[i] = mac[i].speed;
-		mac[i].speed = priv->info->port_speed[SJA1105_SPEED_AUTO];
-
-		if (priv->pcs[i])
-			bmcr[i] = mdiobus_c45_read(priv->mdio_pcs, i,
-						   MDIO_MMD_VEND2, MDIO_CTRL1);
+	dsa_switch_for_each_available_port(dp, ds) {
+		phylink_replay_link_begin(dp->pl);
+		mac[dp->index].speed = priv->info->port_speed[SJA1105_SPEED_AUTO];
 	}
 
 	/* No PTP operations can run right now */
@@ -2359,44 +2353,8 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 			goto out;
 	}
 
-	for (i = 0; i < ds->num_ports; i++) {
-		struct phylink_pcs *pcs = priv->pcs[i];
-		unsigned int neg_mode;
-
-		mac[i].speed = mac_speed[i];
-		rc = sja1105_set_port_config(priv, i);
-		if (rc < 0)
-			goto out;
-
-		if (!pcs)
-			continue;
-
-		if (bmcr[i] & BMCR_ANENABLE)
-			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
-		else
-			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
-
-		rc = pcs->ops->pcs_config(pcs, neg_mode, priv->phy_mode[i],
-					  NULL, true);
-		if (rc < 0)
-			goto out;
-
-		if (neg_mode == PHYLINK_PCS_NEG_OUTBAND) {
-			int speed = SPEED_UNKNOWN;
-
-			if (priv->phy_mode[i] == PHY_INTERFACE_MODE_2500BASEX)
-				speed = SPEED_2500;
-			else if (bmcr[i] & BMCR_SPEED1000)
-				speed = SPEED_1000;
-			else if (bmcr[i] & BMCR_SPEED100)
-				speed = SPEED_100;
-			else
-				speed = SPEED_10;
-
-			pcs->ops->pcs_link_up(pcs, neg_mode, priv->phy_mode[i],
-					      speed, DUPLEX_FULL);
-		}
-	}
+	dsa_switch_for_each_available_port(dp, ds)
+		phylink_replay_link_end(dp->pl);
 
 	rc = sja1105_reload_cbs(priv);
 	if (rc < 0)
-- 
2.34.1


