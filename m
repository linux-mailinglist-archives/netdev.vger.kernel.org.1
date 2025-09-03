Return-Path: <netdev+bounces-219482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FF5B418AF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C6217B7A5
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848DC2E7BA8;
	Wed,  3 Sep 2025 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nIXWxgWv"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013069.outbound.protection.outlook.com [52.101.72.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E42E1C64;
	Wed,  3 Sep 2025 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888571; cv=fail; b=X5AxiA6B8Esa5oai3x7Qpsd5yEtBkRYs8L36XBEYixrFAV847wZVqxjagja+eK9tiGcS8uvI3umsTqRiafwNHg9MwCEIUQjpvqNHrc86QMeMQDFabKZqcwfJPnK9Hi6nNSXYa+Nxo5srpeLbowpuimjIFUbdb9Be+A600DLHSBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888571; c=relaxed/simple;
	bh=6lk8aQj0FpTiCUf+7L5DtW0jLHSUU/tWX8LF52i/CM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=smBUNcinORQAGOe3XOiaRe8x3zkXu6AVczy4shlzJ7Rk6n7z7mI9JE4oZC/AsIabAxtj+/A4JG9Pc6S+ONj3ceqAj3Qo6QgFcCQ4wGMZszHzm8vy2kmsnQOSroEB3X+Wv/lL0as9KXcL67bPlYPokvhvhgX4CB+5/1QLOmLdfa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nIXWxgWv; arc=fail smtp.client-ip=52.101.72.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeX8n5/M2q+QlIuSkyh5K1v8ayzXrw0JVwXlC6sRVXnmS45pGutlCu/Mv7lIzINgbRleJg3XDUN8pRmnMdXDQBr+937ihawuUuSMF7Sc1V77SprDyRvwOXjjNqyQqoL+xPbAtx6rOTDkCy7coYj4xTY3ZecmB/vppDUaRiIa4oPPzCP7hT6tpA9ZJ32P1oPD38mLWV2ewoKEEtMs7M9c/pnHl+RXj1PD7GxJbYriwZqLS3GrN2DCNPVCweZHTglH82ZHxis63ibaiqvQKcm0pMaEIy9oXdR0HAMlNkzyH+pEfQwAD8R12scZ6DP9jkuP/v6VzHvHnEZYpA+8/9KJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpU7G6rqIgPfWAtm1IIrc3Lv6UR9cp7FDrJf+VvBCfg=;
 b=bMYFQio2ICIiDQjZL2XDvSUyeH790z3eAJHg+e76xtSSxU2BFZtHYvf1ZEk1GDnanzz/tVm/YZUoCtvyBYk2xDnE0zmwERiWGx7GgJ/XwDnvsbJtHVqQZOmjAdA3xaVk5FmomJOvXqRHOuaOBu3u8Ux9uXgadUuWAdpAQ5nY1XOXxwn6qWcsBuh9ViJpcqGVCHcha8qM3WJnKSaZh15FAFnzqG7/VbpS7Jtd/z5t0MW2LQatiRo15zv5KH/FjzGJmSpSQ/ZEV6MsqvwzTGIDkunFC7KqismdrOjibnxuAWWCtnvZ10MbzRH57jlT7Lsk4Ha07iLTPifIRE9usXDGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpU7G6rqIgPfWAtm1IIrc3Lv6UR9cp7FDrJf+VvBCfg=;
 b=nIXWxgWvCPSzHrSZx5yrdtNCQgBa7sBc6RYew1evPLNIxTO8Jni69tj0oE+9Q+sVtdzVtaKFN/HHJi/96hb2Rlz79fr9l5Rt4dvfAnxG9RUhupYoy84YDzddU6cmfZf0RWUVami7zFTbV0iXBXjk0MnKPI/mo7OxU0xpJ+idevtY5NHpcIuUlTueKsEE+y1xJacHOLE8pSnJY5kUzGIgZEDRGckqMfl9InzDuWZ1hc3V2EAS8udb+YAVGgXP2jhY6Gqh5ulxcCwiMrTRaSogi6e0chu0QUKb95401JLEpw95PSmS53A6C0SwZP8qTNY6rqg6Wxw7KBUhs+k8Gf4ZpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB8154.eurprd04.prod.outlook.com (2603:10a6:10:243::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 08:36:04 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 08:36:03 +0000
Date: Wed, 3 Sep 2025 11:36:01 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net] net: phy: transfer phy_config_inband() locking
 responsibility to phylink
Message-ID: <20250903083601.aghtwpeoh7krh7ao@skbuf>
References: <20250902134141.2430896-1-vladimir.oltean@nxp.com>
 <aLb6puGVzR29GpPx@shell.armlinux.org.uk>
 <20250902144241.avfiqpmqy7xhlwqa@skbuf>
 <20250902150249.sihr23f6w5p37mpr@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902150249.sihr23f6w5p37mpr@skbuf>
X-ClientProxiedBy: VI1P194CA0050.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::39) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: 970ed0e9-f1b8-495a-fc31-08ddeac4eb2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cxkalKJNqmbSC4tkOv5h/CgBzDQW7ip0HMB1N0KnmPdq+GffO3eJ5Ym8zBrv?=
 =?us-ascii?Q?nxqlscDPd/I+k5587xXJC52SGDVCvnpVr/H4Om096fSiDtzqUWSzZ4OHKVKl?=
 =?us-ascii?Q?uLAzLCuJmz7SpBF12IDuhK3YSTuKbao7n3DzepfiYVJrMWP+5eqMitvI+jDv?=
 =?us-ascii?Q?EwYD72bvNgfAxlrfC2mamhUcaF1EX4lQ1CJgfEtLlsiObR2KlkA8IlIzuXh2?=
 =?us-ascii?Q?1269e1/OJB+3y4XWPVlRPD5zd00x57RJ1QGuoLmsdX6zQC5w+7LhFpLJ5SnY?=
 =?us-ascii?Q?5HSCA5HQWm4ybZhqD2QxSZmTkXsfbwvA1wGZwFT5UslXN/xa7V1ij8S2vIZI?=
 =?us-ascii?Q?7LDl7jxlWiWpfgZShWlAxxBmfF2RelIagCGIZqjuDp+ElSu05f5+9eGSlVRO?=
 =?us-ascii?Q?d60mHTv/i8hbjKFaCNEwWHGrHYZcdgnriw+LibYqRLv8nLYR+Tr2+IEjLvT/?=
 =?us-ascii?Q?yNiKQjyTFSwVOmNPi/AfZR7FPKovsptexnoz6OwBIsAn1uihELnDhLj/mxJg?=
 =?us-ascii?Q?yDaezl8uHKWTymEVL6kzBt+4KyNxDxGIDnsL80ndff+CPOj54XpdjdDdDFLk?=
 =?us-ascii?Q?PXlvHczATbls70yD0rMcRdo4YOU2illla00BxadtkjfllU74c1Eiuhu4iGbw?=
 =?us-ascii?Q?zSPWnhFZrUgXHpZVV8cw6GSW7To6gpSuZUO83/6oDJ2ggFixNoKXyPBm8i6k?=
 =?us-ascii?Q?O23GskTJ1HjbiGqQ2j8tfrEAombKrGbwJzVPJPYmrOyR3tnKDih7JTPn45eb?=
 =?us-ascii?Q?DsuUBGlNeFcAn/UR6whaXj3tNpej/JekZaT7qy/iUvj+3albVQdVqQI+BRrd?=
 =?us-ascii?Q?YVJRXk6EQve8aDlacQ1OCkBI4HrHs/Dl3bwLbfjlr1+w9tqQm2RtaJsI0IAd?=
 =?us-ascii?Q?mogAR2PUAiECTOhCrq6ZmqRmk2lo5U/mn9q2HShiJheYLDR47vgIjbZuZxAN?=
 =?us-ascii?Q?nDSDVMam7cCV+S9veNnCStn75tY8D+QSs+1+8x9Ns6O4eA2DVvpt+yDfwrLf?=
 =?us-ascii?Q?+z5RvlM09lMs2m4AZcX/O2yz5adLsuZAE/urElbK6eGvyi4uJh6P+GcB3BWT?=
 =?us-ascii?Q?S4sHNQ+r7hqAFyWC2WSteJJIZEPaa6RCB4CLmN/XZast/F80SiAZ5XsSUdpf?=
 =?us-ascii?Q?R6BpnixI8QHylMHrM/MKnmTOzJuEN51Nphw91r+75Az9tF+l7Z/PObp2qykW?=
 =?us-ascii?Q?N1EcIsXTKA4EO+39tdfPreE+jGlERK9Au3A4yihlXyc+wHKCHkPhvpcmHOOS?=
 =?us-ascii?Q?ycZPtIN849S5wiprc9KgTGztcmU/M5a2ZJrqtEkScIgTJY5vDrqrZJLGYr56?=
 =?us-ascii?Q?kk47HgEI5o46CBkVd0NLY3jnIhQZB8DH0XDop441yCr7Xx6Uafjbvnnv92N+?=
 =?us-ascii?Q?RZR6pz/rNudTKYptnFYXlUsmxLD9ijrwEgkkLokb4UdtNqG65qqRRbKncx4r?=
 =?us-ascii?Q?mn+QQMDflFg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WkH+HRLnvtsq8RrOyzkor2QKlmj63n9rvZwDcosPhYRjg4J+Zsjlugwy4kcZ?=
 =?us-ascii?Q?w0vEUqEf0JZfSCCrTRgWWkw7kSSY2QfCN8ZvqcV5rPD29RTrSxgW8zlGzBtR?=
 =?us-ascii?Q?4NqiycSJiDfGdfLZ/YxqzumYwLXbXI4l3QBWhKGLYsKV6adekEZHXr7s8nfE?=
 =?us-ascii?Q?Wp64cTEd1FvT5FNkGvlCuYdJMPgqpsEJNw5xW9h5/5zg8hdBKnYwm9Cw1Z/s?=
 =?us-ascii?Q?C+tu+BnTdywLT2VwSHSFyD7rL3b/KkgEB23iI56tFM4iIykUbLDUCD2EsX1n?=
 =?us-ascii?Q?W1pvoQ3n89DoDRMyXVvE1eCp4B+UzTCNT4m4JBDbAsGUnF79SGn/VwY8FOMg?=
 =?us-ascii?Q?c1MIY40HABJ0zxe4stLGhQTsii+OYBAbgYiq+SXBJ54HHxyLdjPHRSplpBU8?=
 =?us-ascii?Q?fw/Y4ikZYKvxC50fZwN9YrZSRCc8I9MUsshpSqq7C8E2vkG/7qGJpcEYtMsY?=
 =?us-ascii?Q?MkepEQZePt9IEHXmBb2DQisuxSDE02gHGuSgndtwqEcoW7nwaTjWvDB27+rj?=
 =?us-ascii?Q?nV6/UtETEaYUgPv7OuwrovTP4N8Cum4lL6tk0rvxYT6DhYz9MN+Ygk4yZTYO?=
 =?us-ascii?Q?j3rXD4YMDkyAZwg2yg0yIDvbS2K1NsGIIuxyJZ13zjZkLeHBW7zYT6t5HZ2I?=
 =?us-ascii?Q?Xpes0+ZmVO29daA6IYb0eyVbPvfdTj9RXXBOXuMhjSMGEP3hopl+XVQHSHAg?=
 =?us-ascii?Q?BbpxkzQAspqCAbBSp+X4pJBIJvMv8jZclSfSIwN6IxiJdgO5hxxrGPoqb6jj?=
 =?us-ascii?Q?v2FJanlAal1kKJi6xb3IT9+lpeoXk8Lu38TeJNEP0gxRW3R35i7N55iIQtjr?=
 =?us-ascii?Q?UB9y7T5JplYRoQxZakhXRxm0U6Vjs3GiJ+z+G/9iCcdR2Nae+SZbiTY2KhVW?=
 =?us-ascii?Q?I8z3sGA/oDSDF/DGngzQDqOPiy2hQITvQMyWsJbrgFzGXDyxbWBIQVVlMUyj?=
 =?us-ascii?Q?T5kB/Hgu1UKz66dVAN0NEFznKVolfqGbPej3bsQ0LDPesEpqQvsMhhTbGzjg?=
 =?us-ascii?Q?SB6cFdp6cFdTrCmgkn6HjtQ3e8WGcr41pHcren13QN1AMtEu+Kqehd/zD/o0?=
 =?us-ascii?Q?GINqMinaH0cj7AO2m8LhxhxL9MxpmVqECmARFPgtRLNKiLT7ijQV5OpM/zUg?=
 =?us-ascii?Q?Gr2z4Gur/nnfVbo11XDj0/A5axXfUK3t1GFtD1QyI9naCHw3pEDrPyqxFYBW?=
 =?us-ascii?Q?b3daCQaYPFcs6++1Vf9hbizM8pvbwbVAjatAvp+h4lCOLmS6kyF/RrI/Hepv?=
 =?us-ascii?Q?II0ZCdP54rPf3vZm39n94ly06/l5+Cxt6L5YQDvPJJc4NXh1otw7igE0gvlw?=
 =?us-ascii?Q?oY4lT2MYtOC4VWFIYqad/2aQ6tEfoNVFJ0aMSSVc8xD3s2lTg86hDYBSmmYz?=
 =?us-ascii?Q?TdytysyKhSe7W8bvKuMCpqxRZ8J5BZB7b8JH8pYdgJxa8EioDSkYNTa3W9vq?=
 =?us-ascii?Q?0tQCYbOpm4Ps4VOyaaA+9KRwMjb5JpHiwGt593DmzhW8/1XPg26WIrnu+Da9?=
 =?us-ascii?Q?m4cBPRJa3mnRtLGuorbngA4nDCqqm2CiA9eYTwIGDYGnHS0cmcpG3vk2y5HN?=
 =?us-ascii?Q?6Mob6SxpVSIGC/KOuFu+0nNU4hvpZL0EoSKc4mZv7ivL03K1MSIpwozdBo84?=
 =?us-ascii?Q?txPjWuqC4mVWoZprutSaTVaMkzUtv2DoU529nJefc+4Tldvv5nxGWX8gvYft?=
 =?us-ascii?Q?ZH84VQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970ed0e9-f1b8-495a-fc31-08ddeac4eb2c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:36:03.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn85p3h+mY9P9Qh4WHfT3F+mA6a/xEwJA4XYj09nCMmlI8EMG+FmdcY40hJh0Ras1EGh2rMyfIR35Llda3zyhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8154

On Tue, Sep 02, 2025 at 06:02:49PM +0300, Vladimir Oltean wrote:
> On Tue, Sep 02, 2025 at 05:42:41PM +0300, Vladimir Oltean wrote:
> > Can we disable the resolver from phylink_sfp_disconnect_phy(), to offer
> > a similar guarantee that phylink_disconnect_phy() never runs with a
> > concurrent resolver?
> 
> Hmm, I now noticed phylink_sfp_link_down() which does disable the
> resolver already. I need to test/understand whether the SFP state
> machine ever calls sfp_remove_phy() without a prior sfp_link_down(), if
> the link was up.

This is ugly but is also the only functional idea I have (patch is on
top of the submitted one):

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 9609dc445a0a..16644d5dfa5b 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -67,6 +67,8 @@ struct phylink {
 	struct timer_list link_poll;
 
 	struct mutex state_mutex;
+	/* Serialize updates to pl->phydev with phylink_resolve() */
+	struct mutex phy_lock;
 	struct phylink_link_state phy_state;
 	unsigned int phy_ib_mode;
 	struct work_struct resolve;
@@ -1594,11 +1596,13 @@ static void phylink_resolve(struct work_struct *w)
 {
 	struct phylink *pl = container_of(w, struct phylink, resolve);
 	struct phylink_link_state link_state;
-	struct phy_device *phy = pl->phydev;
 	bool mac_config = false;
 	bool retrigger = false;
+	struct phy_device *phy;
 	bool cur_link_state;
 
+	mutex_lock(&pl->phy_lock);
+	phy = pl->phydev;
 	if (phy)
 		mutex_lock(&phy->lock);
 	mutex_lock(&pl->state_mutex);
@@ -1704,6 +1708,7 @@ static void phylink_resolve(struct work_struct *w)
 	mutex_unlock(&pl->state_mutex);
 	if (phy)
 		mutex_unlock(&phy->lock);
+	mutex_unlock(&pl->phy_lock);
 }
 
 static void phylink_run_resolve(struct phylink *pl)
@@ -1839,6 +1844,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	if (!pl)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_init(&pl->phy_lock);
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
 
@@ -2099,6 +2105,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 		     dev_name(&phy->mdio.dev), phy->drv->name, irq_str);
 	kfree(irq_str);
 
+	mutex_lock(&pl->phy_lock);
 	mutex_lock(&phy->lock);
 	mutex_lock(&pl->state_mutex);
 	pl->phydev = phy;
@@ -2144,6 +2151,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 
 	mutex_unlock(&pl->state_mutex);
 	mutex_unlock(&phy->lock);
+	mutex_unlock(&pl->phy_lock);
 
 	phylink_dbg(pl,
 		    "phy: %s setting supported %*pb advertising %*pb\n",
@@ -2324,6 +2332,7 @@ void phylink_disconnect_phy(struct phylink *pl)
 
 	phy = pl->phydev;
 	if (phy) {
+		mutex_lock(&pl->phy_lock);
 		mutex_lock(&phy->lock);
 		mutex_lock(&pl->state_mutex);
 		pl->phydev = NULL;
@@ -2331,6 +2340,7 @@ void phylink_disconnect_phy(struct phylink *pl)
 		pl->mac_tx_clk_stop = false;
 		mutex_unlock(&pl->state_mutex);
 		mutex_unlock(&phy->lock);
+		mutex_unlock(&pl->phy_lock);
 		flush_work(&pl->resolve);
 
 		phy_disconnect(phy);

