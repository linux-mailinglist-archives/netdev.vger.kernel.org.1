Return-Path: <netdev+bounces-178807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C971CA79027
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FA63A40D9
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BDA233D91;
	Wed,  2 Apr 2025 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EyYLIOAX"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90931DA5F
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601445; cv=fail; b=H2YtTOIeAFiSoCPqNYJBK1UCZKIBXLO5gDVE/Bd6mgXcJzdmqeYcof3lESTQEedxfu2FvC0sinagsdjYSHNWN8evI9Mkrobr+N4OY8pVD/mkQqEBmGHcGKVouS3KRvYA/eiSo8IbMJk7ncNo/7E2H9i/a+rLG/KH/KE3vMkzpyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601445; c=relaxed/simple;
	bh=H16kYsoFsZ5Zjf/IGkinljKWTP3mx5XP4okmodsyEWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hv7F1glbxEUgaKK3EoVGoPGKgXjJ4If4FWEnthOs1zHyJ9C9LobyZ+W17IsvRSZtYI8VRlqRDeQL068ue6t46hhTPiWZvrEztlDbU6okAPLonYgtwZBkdW4YQ1GZn4S0IpMWD1RUUimP2CM47CRWrKGE7yH3l46O5QPj0ZgM8sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EyYLIOAX; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjpCq+wxLcJ3SdMXWcdwdBAFl0VGuGW+PMag1Os5dEaB6/H3nevKCVRWzIuwVKBU5Aai8ttQd5Qs/X/d1EXrSWIjUKEL02kV/UQUxYksGK1L/XHemyqphvwfMWKPu1mKx6igv6tlnKYTtqoq+iTamIh0mbR/M4navxrZ0FACr/W2/Vt+uw3lYUJQeBbVFX4rpoy1BA+OlILbcAxRTtpnS8zAF/IeChzHFxvJwFM5TCOdCH6PmhbgpOUEBzS8/1iyWkLBi0W4Bm9sCZSWztLPWvgaWJCUjBmjIpeSaQ2UAhM428zcQE+b6RANImeaHB+4ukqa//2pAj9ef73tYN/lCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIz1MHRKBgWw1loVqBDilbjc6pT9j589ZM6BhmNyBFw=;
 b=GAj+v2hantTScvZMiHIZrAU9G84Q/Erq5akAIDqokba5N4H1b/KrN6dDL6rBu4AmzEJV9L6Gox36DOvejEz6oOxWUQsW5mKr73G0AO9x6FFyNc4Uur1+vxbE3VsQHVAjm8vwwzVoGqKUqwWmiUCtI2qMymB1yj3Z9gBkt8P6nha0MyxRHS6JX20t436NIlHFPBiuG9TWzJIgqkqkF9hyPbPBS4U945JRPd2zn32vW7sWJglT8kuWCz4QVVW5LbxE0qnmF9a2YkCs2QaZX/swKaL4HlaFHFLqkVYM/IbXEINXsskAP8Sm4AKfXGg/t8SOR7htcdfy+tt9nq8kPYYrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIz1MHRKBgWw1loVqBDilbjc6pT9j589ZM6BhmNyBFw=;
 b=EyYLIOAXhWHBZF7FNy2LyiIwEWgWY/5SEQVx9rSXkQEDbdbopI3R0uHdf24vfSp8Dep6bRjYPVdrIqfLgZe38vN6h9dXO7DMv97jAYy7egF2w3j74NcqujWcZkrBCgi30KAjaS7k0YnBAFT/pvpkaPRzkoH2jc3f/u95T+t2rpDbU3KOR2HNDNB3HSvkdzlr8fmDBPAsw8lwtfrrXgCI0pJvB0ks2BcOZ2nCwshCvw+7MxgKX6WH7HcztnZvCy4qmbHdu4rSmZjEpv4bPOJalcKFlGanXytBi6bKK6oyn2oFcMBNj7v2hhaC89E6bbVI4M2XVdMWyb8LuIFu5Bkygg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 13:43:59 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8534.048; Wed, 2 Apr 2025
 13:43:59 +0000
Date: Wed, 2 Apr 2025 16:43:55 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: Re: [RFC PATCH net] net: phy: allow MDIO bus PM ops to start/stop
 state machine for phylink-controlled PHY
Message-ID: <20250402134355.cbe673oejhoaor5p@skbuf>
References: <20250225153156.3589072-1-vladimir.oltean@nxp.com>
 <Z8Xvmqp2sukNPzvt@shell.armlinux.org.uk>
Content-Type: multipart/mixed; boundary="4mjfsddum7pm6rwp"
Content-Disposition: inline
In-Reply-To: <Z8Xvmqp2sukNPzvt@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1P195CA0077.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::30) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c178c6-5fd5-4983-0c47-08dd71ec6b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i0dZ1Ldr/AmTJvVtGcXwhSna2F34jiJUm3BI966lyoNdZvwpNpd0QV4MsJBU?=
 =?us-ascii?Q?5wqt00Y+gWf8u5nEN+oug1ysOo4adcmjlPr1UoY0/EQCmZtUMNeh/l50pXMu?=
 =?us-ascii?Q?/AY6uzEnlG4RANoxZV0QlCQmbGZhTrEwkrC95zu24bUSsjUth94of6A/oaKz?=
 =?us-ascii?Q?7b/qGC2e9v0aSX2Ao4m/LER/ddAVSdXKtETJYfbohjAcroc0C33jknhedkbS?=
 =?us-ascii?Q?ZVDdsw+MY2WQfIY5emQIDrMpR7iC6478NjMrA6lBYdNJ+XF6xl9lMDmOrs8W?=
 =?us-ascii?Q?gFFQfOOKdQyuu6LRMZvSMFRXOraslc7VBOXn13Bf8b6cldit/+u+HlPkt2/N?=
 =?us-ascii?Q?k/g1N73CKx6+8v3igGC7PiCN0JmEg4dNapdDV7+OyNZ88QrrLewY+W47AVA8?=
 =?us-ascii?Q?FIioREQh27arO8/oMvAOKaYXUr+GRf3cw8mh+djKwPZYOtMqhsUYCfNUykX9?=
 =?us-ascii?Q?x4P7MQk5b08QGYrcU8D6HU0iU3bOGgEiT5c0hFYyUAEIrEFEH+yxvPPXKKwO?=
 =?us-ascii?Q?k0IU/as1YoIQCwasLM5+SDbw5Sb9gkrt9omp4l8RDn583B3mmdA8+Jx6MAmy?=
 =?us-ascii?Q?BOsH6s+Ai+1G6FtOflwtHLPDvJIwuTVyoyzq1FDG3kT+/yCng6cMu2tQhEnY?=
 =?us-ascii?Q?Iy1qZEtaiVh2vB+1C/LP3/vmvbVJdsMHYzmTTabrZFeSMcKMFFn2AFk7aq69?=
 =?us-ascii?Q?sZERUKoZ8patQkdROEo8DztCh31HdlI+d2TRce9Ehmvk680maleEE7lVXsvN?=
 =?us-ascii?Q?F+zXwQ7WMxdpgNLfTMV2B6eccSm3zHGW1HEbS7Xp8rDGSJW3DtXT5Zghi2Pg?=
 =?us-ascii?Q?qwvSyLa6uzR83PCCIOWCxQXAG9XP5inN9W72VtQujAiZhebItX1WclWZ9DjO?=
 =?us-ascii?Q?7GC/3S84eRr5q0Q01U2ExaCPf0tFvd6f522dKYkUWRw6yk30cQO1ZB4PJrTs?=
 =?us-ascii?Q?/+q8GmT2orzVGoQniqttqty6yxIEx9eXtoWdJqfoM/xvLJ4DtF6mTI1m2MMp?=
 =?us-ascii?Q?WhEXQ6E8rh90yuqMvrTGWFE/AU55rT4PBp60RD+JtZ4Aie+1wb6Cl2b8jSUm?=
 =?us-ascii?Q?wsJ2SdpRm9BVWJvKOVERVMkTa5SbJnCdsYgWVpAA3P3oyWCqeqJ1J+0NrQOK?=
 =?us-ascii?Q?elPTbWqUEVLzPMlaki68QbaEY1m8Go8LCko8RyC++tOXo4MyZvrp38PAQJnZ?=
 =?us-ascii?Q?ab9ZicXO61MsFKf0cMPmyH5Ajis5kISnUdCMFNOtAu4SkwHO/AMHJD/3CeqZ?=
 =?us-ascii?Q?JvG3LGHfqGU0j9ZN+tdPEnVTi5GmU+ihbMTUXs7xICPo0X6KleMCeq/KGeXd?=
 =?us-ascii?Q?oWoYYitkncjqAklV2mkPA0vLeXbgDsVo63799uRr5xfp0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WgMR6pA+g7DlGvptP+GmN6V8BYu3qhPzAGcSQleAJaMmFXjaDgaxkfiiIf/b?=
 =?us-ascii?Q?5rSXff/pvWrh4k1xZYnEdwWlNfOIT6MkIM5EuGXbAZyEQAW/wG3o3axdzDsH?=
 =?us-ascii?Q?djoZswCD7Fwe0VMPWtJ1Wogse8E4TvvwyFFh3m2Tyw1zXhICSD0zeRdU/igQ?=
 =?us-ascii?Q?l4NShaId+Q+Pvi2ab+SVD8rfyX7+EDD+9Vyfn721Ix56YhEFnl1DGIcwGJTx?=
 =?us-ascii?Q?Laxc14SiOIBRCI6gLu2mkNBj4z5hdPcHd4r2rwLX9sajOnXC28sNFRrVmV69?=
 =?us-ascii?Q?vxac3ittMJOc+8YSg7/M0c0APlaYkvoqT/jofZQ9COcS9ZM1evk140OSgOP5?=
 =?us-ascii?Q?cS2xWsYVEMEXK3aQ/IgWQjuTPB3OHU6Q1lIITw7VPEc8hEQD5fWCsymTQVAx?=
 =?us-ascii?Q?Mhc6BjCqZo1tcX2lyvUua/7OUMTkiYKI7H2V9ygi+9kb4Y1ofw9b5caI+mzw?=
 =?us-ascii?Q?PPoTQNhruW1FVIZzVb9mE8+Rp700/Dkrw5jEmqd6soqS83DhNp/v97au0MEh?=
 =?us-ascii?Q?TKI6fZbz3nmdEE/16O7Pk4//VsQy/evKmdAmn8FJ/gotXYj4t5gSHiMDmwWM?=
 =?us-ascii?Q?yxgjpQmSu2QjwBzl1MON3G2EafNu1XIbg/GuQBbjUOXCobpnuTd4Oq7tLeuj?=
 =?us-ascii?Q?GCJmoXvvnW1P4RAzF6MLF+kVIq5SljDiS4M1f0ctYdjirVQO9XvnjYUji7hQ?=
 =?us-ascii?Q?a/lfmMSP08Nl27WDgphWSBuGSG5Bu/YxuT+AsgzKL76013Sga2AUk+WBISm2?=
 =?us-ascii?Q?+jzicXlNvwfZeXayuASA0SLZopOBGRzWpORZtrRFRTrp/bQkiDntFBzuL2R5?=
 =?us-ascii?Q?qxzCkyYHIaZM8Alrqdq8wuW1OmLLRf3dB6ig+6YLkFq+Z4a5n1vyWk274WWh?=
 =?us-ascii?Q?PHrvJn5e7B96uIRNLYiPmqEMCtewsqPTAEn8hUeW4dcwDE+ESS2M439bKehT?=
 =?us-ascii?Q?Hsxhvl+2KAt4UVIw9xlAC1WaZvxgC3lLfdTndf4Q+fnjx6QVhatilzOzPeEp?=
 =?us-ascii?Q?fbGRdeFBlTfrbq/3EzgM2gL9LaRNU4BmKEs2mkTsKIjfzemswDhvZFxiPdFK?=
 =?us-ascii?Q?GlT6xcuMUOY5ntb33miqb92K/RDWxnexAxwYhW8JJStjG2Syc5l9vaxzqU//?=
 =?us-ascii?Q?pEbQQHAOGYNFVB5Ix8M6nuY+m20ZwnYhQp5xdCjP5GztckXua/mCb6xWEHS3?=
 =?us-ascii?Q?Qv2vHz6sLStOj3XkzQ71mEKXywvdO23r379awskUfRylhGiwTa1AePlS0nId?=
 =?us-ascii?Q?E2HdM3SGLRE/LkLSLpNn/Yr+DLsyO71MmTpIQtcJDq2z+WMF6EyqKjw5LWRl?=
 =?us-ascii?Q?knAQS9c+NnRra8I+zzuqDitIPOxBILakDJw3XIfCGBGOUW9cjSxRrt4LKAca?=
 =?us-ascii?Q?vaXvkyJL62/cFnDeP18Aes2k3I3fQoR60n440AKVtziMkqSpzcY/jIxEfaJr?=
 =?us-ascii?Q?bsN2p1A/zBGcyuu2uhQRQxtcavoSrR6ts97mVvrxpio4FpmExSxJE1J6H0AX?=
 =?us-ascii?Q?mWJkUIlrN+h1zSRshLS9e3avpFP24LuCzdGdG0RCW2BmPM9F/FizLJhsxrWJ?=
 =?us-ascii?Q?pcnP3vEWrJsAU2HJxGXhcmGwho25axVbipHONoU5PZDvj9MxSJJy352HRyk2?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c178c6-5fd5-4983-0c47-08dd71ec6b74
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:43:58.8950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsO/GOV0SWaYqOBZ5OUQhKTMKPaQV/cmfSHw9DDGuE0DlKhMR2Ey9wewNApQh7iqTkLOIls9W8IQZmWJ+r6ODw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8580

--4mjfsddum7pm6rwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 03, 2025 at 06:06:18PM +0000, Russell King (Oracle) wrote:
> On Tue, Feb 25, 2025 at 05:31:56PM +0200, Vladimir Oltean wrote:
> > DSA has 2 kinds of drivers:
> > 
> > 1. Those who call dsa_switch_suspend() and dsa_switch_resume() from
> >    their device PM ops: qca8k-8xxx, bcm_sf2, microchip ksz
> > 2. Those who don't: all others. The above methods should be optional.
> > 
> > For type 1, dsa_switch_suspend() calls dsa_user_suspend() -> phylink_stop(),
> > and dsa_switch_resume() calls dsa_user_resume() -> phylink_start().
> > These seem good candidates for setting mac_managed_pm = true because
> > that is essentially its definition, but that does not seem to be the
> > biggest problem for now, and is not what this change focuses on.
> > 
> > Talking strictly about the 2nd category of drivers here, I have noticed
> > that these also trigger the
> > 
> > 	WARN_ON(phydev->state != PHY_HALTED && phydev->state != PHY_READY &&
> > 		phydev->state != PHY_UP);
> > 
> > from mdio_bus_phy_resume(), because the PHY state machine is running.
> > It's running as a result of a previous dsa_user_open() -> ... ->
> > phylink_start() -> phy_start(), and AFAICS, mdio_bus_phy_suspend() was
> > supposed to have called phy_stop_machine(), but it didn't. So this is
> > why the PHY is in state PHY_NOLINK by the time mdio_bus_phy_resume()
> > runs.
> > 
> > mdio_bus_phy_suspend() did not call phy_stop_machine() because for
> > phylink, the phydev->adjust_link function pointer is NULL. This seems a
> > technicality introduced by commit fddd91016d16 ("phylib: fix PAL state
> > machine restart on resume"). That commit was written before phylink
> > existed, and was intended to avoid crashing with consumer drivers which
> > don't use the PHY state machine - phylink does.
> > 
> > Make the conditions dependent on the PHY device having a
> > phydev->phy_link_change() implementation equal to the default
> > phy_link_change() provided by phylib. Otherwise, just check that the
> > custom phydev->phy_link_change() has been provided and is non-NULL.
> > Phylink provides phylink_phy_change().
> > 
> > Thus, we will stop the state machine even for phylink-controlled PHYs
> > when using the MDIO bus PM ops.
> > 
> > Reported-by: Wei Fang <wei.fang@nxp.com>
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> > I've only spent a few hours debugging this, and I'm unsure which patch
> > to even blame. I haven't noticed other issues apart from the WARN_ON()
> > originally added by commit 744d23c71af3 ("net: phy: Warn about incorrect
> > mdio_bus_phy_resume() state").
> 
> I think the commit looks correct to restore the intended behaviour,
> but I'm puzzled why we haven't seen this before.
> 
> As for the right commit, you're correct that 744d23c71af3 brings the
> warning. Phylink was never tested with suspend/resume initially, and
> that's been something of an after-thought (I don't have platforms that
> support suspend/resume and phylink, so this is something for other
> people to test.)
> 
> However, your patch also brings up another concern:
> 
> commit 4715f65ffa0520af0680dbfbedbe349f175adaf4
> Author: Richard Cochran <richardcochran@gmail.com>
> Date:   Wed Dec 25 18:16:15 2019 -0800
> 
> adding that call to MII timestamping stuff looks wrong to me - it means
> MII timestamping doesn't get to know about link state if phylink is
> being used. I'm not sure whether it needs to or not. Maybe Richard can
> comment.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Thanks for the review and for pointing this out.

If Richard does not respond to the comment request, I will submit the
attached patch to net-next once it reopens on Apr 7th. I will anyway
resubmit the PM-related change above to "net" today, without the RFC tag.

--4mjfsddum7pm6rwp
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-phy-extend-MII-timestamper-link-state-update-to-.patch"

From f1c1892e3ca21be9e241f6b8a3710a14f7ec304f Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 2 Apr 2025 16:20:33 +0300
Subject: [PATCH] net: phy: extend MII timestamper link state update to phylink

Context: since 2017, struct phy_device has a "phy_link_change" hook,
added by commit a81497bee70e ("net: phy: provide a hook for link up/link
down events"), with two implementations in the kernel:
- phylib's eponymous phy_link_change()
- phylink's phylink_phy_change()

Russell King points out here:
https://lore.kernel.org/netdev/Z8Xvmqp2sukNPzvt@shell.armlinux.org.uk/

that commit 4715f65ffa05 ("net: Introduce a new MII time stamping
interface.") from 2019 made the interesting design choice of placing the
further phydev->mii_ts->link_state() hook in the phylib implementation,
but not in the phylink one, due to an unknown reason.

As such, converting MAC drivers from phylib to phylink poses a
regression challenge if they use MII timestampers, because with phylink,
these will no longer be notified of link state changes (which is
something they may or may not care about).

The only upstream user of mii_ts->link_state is ptp_ines.c. I also don't
know in which systems it is integrated, and whether the attached MACs
use phylib or phylink.

In lack of link state updates coming from phylink, the ptp_ines.c driver
retains the initial PORT_CONF setting, which assumes PHY_SPEED_1000 <<
PHY_SPEED_SHIFT. I'm unable to further assess the impact of this
mismatch between the real MII speed and the initial assumption.

Lacking a proper bug report, I am going to assume there is no breakage,
but going forward, we should equally support phylib and phylink. That
can be done by placing the mii_ts->link_state() hook at the
phy_device->phy_link_state() call sites (i.e. phy_link_down() and
phy_link_up()), rather than at the individual implementation sites.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/phy.c        |  2 ++
 drivers/net/phy/phy_device.c |  2 --
 include/linux/phy.h          | 10 ++++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 13df28445f02..77b1d2d002ab 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -77,12 +77,14 @@ static void phy_link_up(struct phy_device *phydev)
 {
 	phydev->phy_link_change(phydev, true);
 	phy_led_trigger_change_speed(phydev);
+	phy_ts_link_change(phydev);
 }
 
 static void phy_link_down(struct phy_device *phydev)
 {
 	phydev->phy_link_change(phydev, false);
 	phy_led_trigger_change_speed(phydev);
+	phy_ts_link_change(phydev);
 	WRITE_ONCE(phydev->link_down_events, phydev->link_down_events + 1);
 }
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 675fbd225378..f535a2862fc6 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1064,8 +1064,6 @@ static void phy_link_change(struct phy_device *phydev, bool up)
 	else
 		netif_carrier_off(netdev);
 	phydev->adjust_link(netdev);
-	if (phydev->mii_ts && phydev->mii_ts->link_state)
-		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
 }
 
 /**
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a2bfae80c449..c6cc4403323c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1609,6 +1609,16 @@ static inline bool phy_polling_mode(struct phy_device *phydev)
 	return phydev->irq == PHY_POLL;
 }
 
+/**
+ * phy_ts_link_change: Notify MII timestamper of changes to PHY link state
+ * @phydev: the phy_device struct
+ */
+static inline void phy_ts_link_change(struct phy_device *phydev)
+{
+	if (phydev->mii_ts && phydev->mii_ts->link_state)
+		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
+}
+
 /**
  * phy_has_hwtstamp - Tests whether a PHY time stamp configuration.
  * @phydev: the phy_device struct
-- 
2.34.1


--4mjfsddum7pm6rwp--

