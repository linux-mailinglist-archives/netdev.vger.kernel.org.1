Return-Path: <netdev+bounces-212869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD792B2251D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B4D1A21A32
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813092ECD17;
	Tue, 12 Aug 2025 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cWwF6Fun"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2559B2EBB9E;
	Tue, 12 Aug 2025 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996389; cv=fail; b=DyyipSMW4UEBqRqeeAVTP0diIJ9SSDfm9PS0cQKTdslhstStsnu08iJijv81M38kJ3m8Fknx6xNsF271/S3YsVnFjoqFj7TCJ2zYOnOrRnucQ52ph1gqQ+WnwItk4F9rBBzU6kCCMvllTdbmSrFeO2HgsEtiGusJ5gGKPW3wmA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996389; c=relaxed/simple;
	bh=A5d4KoSVvPNSb0K7ziRYkuvFc8HncdiAmAYq0ndfPMY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VuIMTlF85Gi9IcQgYcImDWX4tEGCiTAYUkLeVikifsh09j5d/htAFR3R92ULE/adAU8ZAd94xm4MXc/CjOMO5Va2R3ATVeNcdPhuT/+QFloJcKFYhflm+yz4G8cHQsKj9Wbu0GPSEC6moV38cwLUgDaBXHBj5i5TJkHYSbEv3VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cWwF6Fun; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPx+NXpQO3lxLx4JmliLmpkBJTsafBv6sghYzducH7ZhgqUGZRaNrJmO0dpx+Nae0K4EtmOcquKrMrHcuY5kETJcMmU9QmUW034rjKGcWAE4h73jxe1Ob1S5fKqCxqmjKb9f3vv8m8VDa7a+6ryQIG2UxIAeqilMpj3oBUia2j7jWkZakfRETviIICT4qMro+Ja7TiHeYj+/AxFphtONoKfEwPsw0b/nQVJiuU23DuTy572yqq5EgE35gp9Hcn55m5G5zhfNPL7feBsk0Bu+ClnsM0/EXgw64ZAwmyN2UIhRe0+uK7TQEddbKQrM94d8ga1Px1PrU4v6f30HFS4YUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1r0SPA+bk8MVsciotAHllylwYbeklPFIoUdn/AaUzyY=;
 b=Nhcwq+2KyycMdutFqVwVg5unDpA/KNahpLNBazdxTa/jt9KeK0WcmxLfnH4LIBPvGUSmGeWx9ltcxC2acq2LHQZK5twWV/u04gsV+xvqxL73X5cPVFjisPw5iZajwowY3NR9EC6rz0vjv3edL+X6klgmwJVZ7f7BXKq0YMjMq92vLIAAeeBCsn1b1EWnSiYoeQm4AENuPSM90gAxynpLiFWirkVXHp6fH5L8qRGr3gP3BeGU1dTYg0DF/sV7C7CqZ5IeAbbR63/CF2hudnJTLU2zHcDzEAGg/O23TyYHRRAG1tw2sy1MwpY8X6dJhEcZXC8U/xXsTv9ymA7LTpA2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r0SPA+bk8MVsciotAHllylwYbeklPFIoUdn/AaUzyY=;
 b=cWwF6FunFmaQF1dBsLc2SnvmFQHbPh3PAppqMAhHBuH4DJdQLdcLp/Mv1YTh3u3Ck5tQkAbyZ4pWecot0pZneiAncc2rLB6ccuN2vOOTp2tXRMdz+nYejddbGGVazGvEZgD4AVzFeo41I/thWDsUxaFGlqt/EU9klmaSeoaNdHO+o579DVVLZHHa0D/Y06XFarvAZaBpR6HXrB7480r2J02TQQU3YTV2M6GKyjoJXloQab5AZeRFrkED45ZxMj6Q9bgxqmtR+j3jX0V/bxQd5GyIN+TzF5vjebvqipjBoUnZ1X7xwAvkbCC2XJZCY16TG20y978hmkeN2kWwOPb9Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB9147.eurprd04.prod.outlook.com (2603:10a6:10:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 10:59:43 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:59:43 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stas Sergeev <stsp@list.ru>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: explicitly check in of_phy_is_fixed_link() for managed = "in-band-status"
Date: Tue, 12 Aug 2025 13:59:28 +0300
Message-Id: <20250812105928.2124169-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0142.eurprd04.prod.outlook.com
 (2603:10a6:208:55::47) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: 3556cadb-ba7c-4b82-c73b-08ddd98f5775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7WhfAbGXOZz9FI0Wry0YP+1Yf0eqwVMAkFQgxoiNHf41W8kPYOg7MSF2ktXI?=
 =?us-ascii?Q?uSAlKlj/W483sqpqCI+nnYNiWKA3XVpyQUCoFR5FBt3N1G4OaCu5G6r1bWFy?=
 =?us-ascii?Q?/bzxR7Nx62tlIh8n/FRA7btfeYmAMOyOaSdE+xogcSQ+bbActIe/NFS+avnW?=
 =?us-ascii?Q?ODuz1pAsFU2XYID1BRBTzgVHN4WTnBtrxpU+iyeHtqEz3h2BPwktqmV6KaWQ?=
 =?us-ascii?Q?3uPV61cJa+ixCfoVj9EU1rUEl2Eow7KM/PNj3bmR9PaTydzpsftnRt/bn4fo?=
 =?us-ascii?Q?kEHNNHfjgcZVBadmNjxF4BR+Jg3cXiT275Tm8lRLhUrM8g0/6QoZGGClFOrU?=
 =?us-ascii?Q?DhUlK+GbsY2VoYfus2/Shhgl+R8L4aa5EOkgenxgm5KryfcZACdZMVC58EQo?=
 =?us-ascii?Q?tepyEXnsL+dAtR+T6jAylrJ06EcG/LxLSWqDGKfT01jTwuwkwkk8IVT2IIKv?=
 =?us-ascii?Q?76rcYvENZYhG+QjSciyW7FoWVgCXBwXrAYFfnXJv5uiz6jawQyJu1idugQsY?=
 =?us-ascii?Q?gpdawdOPGB9KmiGw6BXLxvTJDtnBlQfr9wSHi0maew5ScrideIRzjM5A3EDm?=
 =?us-ascii?Q?/SwFjpdD3+vJ0MKS+zRdmfFwl+2ygjfFU9CJ/t1to6qJvsnSJttTfziqgmm9?=
 =?us-ascii?Q?yoAPa0cYG9C9LefLavrkPQcuE3KPLuKCx2BnocZ2AC/Ywrc1AFdXEpcOUREJ?=
 =?us-ascii?Q?wOPD+TXDurCREVOjt4MiQmlndX4W2agS2zQHMQuRBapneq4LAxGyDvobC189?=
 =?us-ascii?Q?q4YOVHKhx+c2UmIW13hNE9wd9Ih5wEcRA2ARVXoywFnwXqUyU98JFURnWRJq?=
 =?us-ascii?Q?EF8BG05jmd5Z/kaQgkjze4akMhFUx28vIDkY00lmwdskmKePRuKP9sgOeJbq?=
 =?us-ascii?Q?BgBal/7WgMy/qjjBIVWMA/m52U9JSfhmeQbVkXsRd/2ZaQZrqeImJgSjDFuJ?=
 =?us-ascii?Q?AkhgFQVJxBH9XDLwRp4kkrYDyygOmKWn0MFsFLAECGYlNWlNfLutAKx+a8X7?=
 =?us-ascii?Q?ctbLAhjTAyypj8+04OevEMMFg5rgYd+yipS4k2jUV9rMHKhUKyeYhpyn2afB?=
 =?us-ascii?Q?hfXGm2J81Dj9Ts2X6s+RMnc4smy+aLCQAZua7GotYubzc2Ghn+oSJF81tMQw?=
 =?us-ascii?Q?zg+B3HqGqNO0nWdmneM2X5GeR+lPu6gegKQn+l/xIola52zdMjWDsBA86wVA?=
 =?us-ascii?Q?6R2yV2gyaFwWR/T+FgEEpCj491nBWzYppEWCe3SsqEHRM/btm/TJMKSkkjv9?=
 =?us-ascii?Q?rxomFRqyaPiL45FMFfZ7EW16myExljzadDAF9Vh9gmiOLTRnRwKFhXZJJMCJ?=
 =?us-ascii?Q?mnFQOUHi1//WU32/R3qj9JP5Pds0WI+lGb/duf5+oP2i/P479cx0mevAFkZV?=
 =?us-ascii?Q?R/vMA62Am/vkCMP40dku9Pz3ErOwQnEVexIZRqc3UeW6TOycdijDWmFrUIZQ?=
 =?us-ascii?Q?jYHFy5T12YhFeB54zpAIJotjU0Pu8le2kVCwBRJ42Hd7lVO4aoOqvdypfFpD?=
 =?us-ascii?Q?wG+fN9wJks0yaUc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WsAY+vJQlS1jI6g8J08WHj7j2g78Ee+Ga9qAkPOlCONwtB78rLbBkF2XlrHe?=
 =?us-ascii?Q?eBY7FmIpscte5vKRrZ8rSvnPLeRIXwnAMaGVne4JXL8Rb0Dsiw58YHs3o+sw?=
 =?us-ascii?Q?wG7MtRrRNTYqIIZsIjUu1JGtKu7anfNUixNQx4O7kbeIj2BU/gbDt0vy15Ja?=
 =?us-ascii?Q?LkhfrukzKLYPlC7Nub+pNyuRC3IRU0aKcRQlHLm0aCKEVEL3i/GGSXb9c10C?=
 =?us-ascii?Q?Hjqj66PqgqhHPic2mAeOvza4Sinvs1xyhgX9Prkj3zTpwl6kLu5CTLcQMAdY?=
 =?us-ascii?Q?mkJAdSZuQE/63Ksr1A6yp29Ijg68h2y538SK4Eqn+uQkdt7FOZpZchXGDmY7?=
 =?us-ascii?Q?BmDUyAwOXd3cGA86Y2mVjEDZHBDzMSwQIIPSJG7p/o69b5XbOCSTm3FMYwSh?=
 =?us-ascii?Q?WJpKjIMkmTO0W5CtKs396zQn9DMwUnsKPkObSSEgQiKEQh4rdZTFslQAlMQo?=
 =?us-ascii?Q?QdaBx3j+5UUe7KDeWLpBQarhzVYX5h1vnVIxIUkKA+IBf5p4tzVR90FNXGHa?=
 =?us-ascii?Q?nuQrzzfuzM0Qx+mBg+xQOH+AsJiYrswEEW4Z6Ctarjsb/XYil4avtdvUVRmX?=
 =?us-ascii?Q?cXTQeg0ZHYiB4mLIAgaQ1P/kHYjnsN0o7We3yAeyPVz1+b3k5onB8rfk9Zq3?=
 =?us-ascii?Q?Yuh4SedrdaIL/O5n/FzQq6lt3N3gXYfLAiuWLE7h/CJQ2pIKuZGXdJ4afW1Q?=
 =?us-ascii?Q?5jIaR0P8HJk/KU8N5a6zKeVP2f772fe8nQnQsYHpkx8FsuFc8FhhyWEzlt9E?=
 =?us-ascii?Q?3vHm3rWTLiFCFo2/hVFWFwBHBWtlubHMof0zldzZnrFmL0XymyiJYb4joM6K?=
 =?us-ascii?Q?Wp2Alf3fGXC0k0WDZH5mvRU2wGrzY+4oyY2CiLQciHNY3XigaDMPybkGju0W?=
 =?us-ascii?Q?BOmNOZoSynuLj3vPHwA4QKFHDh4njO4aUyVBzO1m7ik1RaVLWlGtoLFXpc3+?=
 =?us-ascii?Q?8/1OnokyntUH+K/OaJr08bqw1n6kjMmmo7ppZtjEW/hlKdqd/p3NYIuQ8Lzw?=
 =?us-ascii?Q?nveBLuWdfs9tJxOLdaM+3NAoWpwrpfztk4HMll11bWHcGDoCgxuxj4AZzenI?=
 =?us-ascii?Q?/HxaIdNwWJml52XF3U/plYkgagRyy5dkShH4vjJi1PtEuhCh+bsYR1xO+6T7?=
 =?us-ascii?Q?Fyb+8xPLvY2gajpTYiYJiK2nB35094xnCZ4nU5iz7F7j8yb8OR6MS/jKmG9m?=
 =?us-ascii?Q?k1fwMSRHSNWjIX9XUcyeZzUtl0hoQAhnaDVniwqXITOqK7ysTwt8ExrpGfla?=
 =?us-ascii?Q?+5YFHxicUzvXcagHRDWq+v1VBH4uX1W/Ay8BwMlGtim8pJgz8oZojvq654qh?=
 =?us-ascii?Q?MOgNXb2NgrFeyDurOtzLsqZD47c5huTmBshbEpwLERraO4JhjjWFSXmqQYJb?=
 =?us-ascii?Q?Glnl/3S1Fm/paOf+dgin1T1yMmqg3zp0aqkrAejmpn3HV0sPv2V+PnN3EdMq?=
 =?us-ascii?Q?t7pzlEHlgeafyjwKoP6zdSlbMkZRfwljE6fU+YW1U9gvk/cWN5/yRtLcYDfi?=
 =?us-ascii?Q?YvJK6ec5z+eF3Rgi7FskVYTC9i3h9eJniXxv10iO2Oa7IlAsWduNM3DcUn1V?=
 =?us-ascii?Q?b9nAl/cr073SVVIENSyAkYZoU35Mx9o6bSu4FyHr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3556cadb-ba7c-4b82-c73b-08ddd98f5775
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:59:42.9490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1X24XUS/B8nVD0HuUtUTnxGHHMoeZjeXeD+cnH0jkrGWYh2U1tynQE2RPmrpXmF3VCK0KWY0PjWp1Deg3RrAAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9147

In phylib-based systems, there are at least two ways of handling a link
to a PHY whose registers are unavailable over MDIO. The better known
implementation is phylink, the lesser known one was added by Stas
Sergeev two years prior, in commit 898b2970e2c9 ("mvneta: implement
SGMII-based in-band link state signaling") and its various follow-ups.

There are two sub-cases of the MDIO-less PHY to consider. First is the
case where the PHY would at least emit in-band autoneg code groups.
The firmware description of this case looks like below (a):

	mac {
		managed = "in-band-status";
		phy-mode = "sgmii";
	};

And the other sub-case is when the MDIO-less PHY is also silent on the
in-band autoneg front. In that case, the firmware description would look
like this (b):

	mac {
		phy-mode = "sgmii";

		fixed-link {
			speed = <10000>;
			full-duplex;
		};
	};

(side note: phylink would probably have something to object against the
PHY not reporting its state in any way, and would consider the setup
invalid, even if in some cases it would work. This is because its
configuration may not be fixed, and there would be no way to be notified
of updates)

Concentrating on sub-case (a), Stas Sergeev's mvneta implementation
differs from the later phylink implementation which also took over in
mvneta.

In the well known phylink model, the phylib PHY is completely optional,
and the pl->cfg_link_an_mode will be placed in MLO_AN_INBAND.

Whereas Stas Sergeev admittedly took "the path of least resistance" and
worked with what was available, i.e. the fixed PHY software emulation:
https://lore.kernel.org/lkml/55156730.5030807@list.ru/

Commit 4cba5c210365 ("of_mdio: add new DT property 'managed' to specify
the PHY management type") made of_phy_is_fixed_link() return true for
sub-case (a), so that the fixed PHY driver would handle it. From
forensic evidence, I believe that was done to have unified phylib driver
handling with sub-case (b).

We want to preserve that behavior, but if other values for the "managed"
property have to be introduced, it means of_phy_is_fixed_link() will
automatically return true for them. As a general rule, that doesn't make
any sense. For example, managed = "c73" may be added to mean that the
operating interface of a port is selected through IEEE 802.3 clause 73
(backplane) auto-negotiation.

So, we need to be explicit about the check.

Documentation/devicetree/bindings/net/ethernet-controller.yaml makes it
clear that the 2 allowed values for "managed" are "auto" and
"in-band-status". So, given the current binding, strcmp(managed, "auto") != 0
should be exactly equivalent with strcmp(managed, "in-band-status") == 0.
The difference is made for new additions.

The Fixes: tag and backport to stable is justified by the fact that new
device trees need to do something reasonable with old kernels.

Fixes: 4cba5c210365 ("of_mdio: add new DT property 'managed' to specify the PHY management type")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/mdio/of_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 98f667b121f7..8e8a34293a8b 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -401,7 +401,7 @@ bool of_phy_is_fixed_link(struct device_node *np)
 	}
 
 	err = of_property_read_string(np, "managed", &managed);
-	if (err == 0 && strcmp(managed, "auto") != 0)
+	if (err == 0 && strcmp(managed, "in-band-status") == 0)
 		return true;
 
 	/* Old binding */
-- 
2.34.1


