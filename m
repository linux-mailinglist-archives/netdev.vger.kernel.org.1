Return-Path: <netdev+bounces-211603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5A3B1A556
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F9916F517
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D121771C;
	Mon,  4 Aug 2025 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UsnxMAN5"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA52165E9;
	Mon,  4 Aug 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319383; cv=fail; b=CTTqrinkhiSf4bbp/aEsbAn3UtBUegIHgZovSRKebPklX6aH93yBozlcLn/Y7JqDAcTjSilq8B9el+ZGgZofPAEXVb+VqD3ydsEXC6P9VrXjMIV5JH6dHRMIS5Da0XiDPNBVcKLW+jHyvLflmKsCM8t7WuDZmzIHa5Nlxr0ao8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319383; c=relaxed/simple;
	bh=OREjqKvPMVg7FsX0vzRTptDPKZnu+U34rjjkgB2QSC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hfSoAdeRPl4eAhIejnQIIKxuMGklrsLMLi455Hg06iEyHFLhuThj0gkWJtgOraEWZ0U0uTGq8gnO04rr1+XP5GfUdUMPPX7yoKzLUEWK9IknY4mkh5dK0RxE1wyE1LuhjYrBjIX0l90SC6aCa8Irv8p76u0/Jotp3/Z2ZQY5DZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UsnxMAN5; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iV7vM2N+OyXWfigbICkoZfVRudm2soWVcEx5Ysb+zAyl+FoD76LieOTfi8f6oegmwCzNi6FvTszJwNxtKIWStcrepntPJpiW1DVbwXruhHrlEtQHzc/vOw0U9gF6Zes6PTlycH0Kfqc2d2ijxBBAlPhtLAqd/t4kvfRzgJnnYZKnG4zM2XifBcengDjrv+GMH+isjR2HVViFG0qdnv5pNtSbNKC/n8w3MH7951R5kc4KSbhxC5Ipu5wO1+rk7f3AmjmpBPobRY913RmZRRngexEd+fwUZrXU/jD9r+1ZMLk3vkPyJOnzBAdsZ/Um52jhJASaxIsdoVk680ia0E3Jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGkvDsPZeGu6Ymju7CxZLi+VZGud4psVcmeRU1Cxsnw=;
 b=h1Ah8wFXnT8oPnphmtRTZeoJUPwCPy3ZWscZDI4C5s2xXBRwbPutpwwca/lsQxrG1tWes5ozqTx0nJyNphjOla/RgazJOSOu/hFAFNFQTKmFtUiSdtSSifql0azmzWvR7gsdog3yMt08K1YyiSRVpG89WOTc+z6cF4Q0uilYyTMzVo+dN3t+IIrxKwuQ58flk14nuEuNouTrjskcuwtEAYp0XI5F+EbqT0tJtZmRIvA32ZgClJucOCwJfED5oGN07aBYqlihThWWJBWfQrkm8N6OJazbiRhnnX4V7k/Qpm13VWRq03tZ+7evtBbxvu7tw+g95d77w31Zm8YO0Q6geg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGkvDsPZeGu6Ymju7CxZLi+VZGud4psVcmeRU1Cxsnw=;
 b=UsnxMAN5ecaf5ii0njTPtUSzDBdvva0Tnrt7Xi8KeVoDAn3EljQU5rTFcJxhu/Ev7O5y//e+5F9JbjISgWo5kW1JWoWSST51HGfWndkpI0O6xN2+i38Y5VTF8R0BuJTo8VFjadnWHOw64Z7cmZlIYfxaT1scoPENmq5/ULxFOLpwz2p4R38TpdOecT7rqksiXRo3AkWFfqD2KQJ2jVeoFzqQGd3jR7wQgbGSfyn+PGdjv1S+ibDstelsWxDUqvdGb9JgPgY2gCPPq5WcWX7ToNOnv/D+ZPcCuZ2pnnNyKc25QU8w2YytQjrhjgGRB05hd5dlAHYz5MiOlArOfscvZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10816.eurprd04.prod.outlook.com (2603:10a6:10:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 14:56:17 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8989.020; Mon, 4 Aug 2025
 14:56:17 +0000
Date: Mon, 4 Aug 2025 17:56:14 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20250804145614.ca27e2h44khdfzbz@skbuf>
References: <aJBQiyubjwFe1h27@FUE-ALEWI-WINX>
 <20250804100139.7frwykbaue7cckfk@skbuf>
 <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
 <aJDCOoVBLky2eCPS@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJDCOoVBLky2eCPS@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10816:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca5265a-a797-4fd2-9a8a-08ddd36710a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jsGCAvhocz0ZK72kwx2XIXsf2SDszZNvL8jEJUOSGdYF+1ulPACzkYhrFrwP?=
 =?us-ascii?Q?uCqfpsaRcCCE8e3kO8FdAYBcaGSAk0ct8EWf5MarDGhopWG8VxxbC8OLWESd?=
 =?us-ascii?Q?59IMdPcMZ6jGCQAlN1ZidSj0Y8Mv2MaDx+0uGfi445UVXgKqmomv2PAN+DCP?=
 =?us-ascii?Q?OH5fvtAtq3+XxzK+JXNCtS8MZe8DJoNSL6QIxLKXFjEfL0a6WjQ6RmUEzOuZ?=
 =?us-ascii?Q?n1FYcjMQcnuLCdxXP8zvMIGE5nwuljbMugwxlp8Y63ErjzGyTsEJ8Pce/394?=
 =?us-ascii?Q?g+Lgdmy6b0xmvvhFDSvKeLQIFyQx/liWNemXTJ1z3hVgLHpq5PYj3o7Bf5e7?=
 =?us-ascii?Q?KtbqOpViLFlCzV34+uORgORRwOMsLJyVEzYyVy5H03nc1eLCrm8WxsgjrIe6?=
 =?us-ascii?Q?/lQWfkDDp8zw8jH7n3dU4Lx+B5iYfcxobH/inqmnWP0UsV0FwSe7i4ak7Q8e?=
 =?us-ascii?Q?yn5WDH+zmSkTF4Dat+P3yjYlRCOnbdXYLJBwV95B8PlZyIbUeUE+WBCcnmH8?=
 =?us-ascii?Q?N9mNk3AfHtyrUKzputNyXUUTWkEBy0A1Ju58IVhjSN72C7WH0omPVvayXvXP?=
 =?us-ascii?Q?sxMTAB77q333jRxzx+qIwvAU8xSI2x7/Z2sGhWfnmgSRX91cNiBmLmx7q8z3?=
 =?us-ascii?Q?gj494fji9Suu4NIvvpH7sFFP9xGyhTPeMNgf70rl+CWju5t7xGQMIh0UHGC1?=
 =?us-ascii?Q?alVd9ze3GtbKwLaXjTP57T9/BKtsodbi2LRVuhUiKWv7GYRqEOV8kCv7yY5T?=
 =?us-ascii?Q?LUVLnOoc7rdatu8xyKIb7D72YhGI1OHF50Nlp807OD5nejQhm7SDbw/D2iyv?=
 =?us-ascii?Q?OpyD225VVqWcp9gu4wg9/fQbZRI/7W6FOkVV7GyXtaqzTjz42pgEHSULJXQi?=
 =?us-ascii?Q?RiwvmLQBIBOzBtqEiGDzPx1d1trqfQ5avfdFsX5ymf/B1HVH/JqPE+moFU3w?=
 =?us-ascii?Q?z/a1/bHhprwts7gCBvvFnplnEsgFfbNetAlqLGno2TV3npB1AXKYyXPBF96q?=
 =?us-ascii?Q?BHIK1hErtG9R8PMZTdVpvWFXLWVEbv3xBQ86mHMkQbK/jVC8qkcr0o6e0UrA?=
 =?us-ascii?Q?4MoPL3qDY3Xs/MBZYuk8vEdJSjEbf7j9HGk5Wd9OOUdytTv3cH24JtV1uZPd?=
 =?us-ascii?Q?vROUIkTT1RkeMkI/uBqw8BomLkDB3hP1KlVAhJOZ0oaxlTDjf/SIhh0IKReY?=
 =?us-ascii?Q?4sdx3YoEBxLWvXU2gTOHXP26R54xjfy3514tc3zYXRzvM9mdEn24geY4Zkoc?=
 =?us-ascii?Q?SphSARW/Gsl3mBdttNMh54eh0/A9ptapC4Nv9DNXFQHVLgVsIl5q5d5SGuS2?=
 =?us-ascii?Q?uJdlaGQcJH+q99dfojUeT/yB86TfGpeVLDnV4mTUHSNC4zyHpLX4uG2H/b6A?=
 =?us-ascii?Q?5YG18DA4+IYfATNcKkx+IYNqN8/l6J5EoMwuwEK2PvvkiBhU0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J+6b9sZwj3whmxLrjFCY/z1xTQhYaJWP7LbBRaKmL+jQzghJjEbsdfDGGbXe?=
 =?us-ascii?Q?ahYyUdaV+qENLPPf2LEmz9u9X8NBzjp2ud0hgUS0v9q1C3E43IhEWimyrXHJ?=
 =?us-ascii?Q?XZoILSqGx6+D42F6BovPp1NCcUlivinlbOAPesIbl9mvDlr1C1oGhYpnMGUX?=
 =?us-ascii?Q?X/eocMx2qSzIE2lCf/fYn3riUkGlo1LT7Ze+uCF3Rm5ieLATWRbiZS7EuvwF?=
 =?us-ascii?Q?uM5d0M7/mvOCPVNfigrodzsrvpk5DjG6EId5M4jCsczIF4w3Xr5MLjXLwePj?=
 =?us-ascii?Q?CHOyshKKzw+JPeaE9HS8O2wV8FbGIW+J8dyJ86Wc7kQBbWYcgO0usKE2k3nJ?=
 =?us-ascii?Q?IfWiqoatS+ECjrCZAEcgRUJRsJFtM0VXn4tBFBe7rCSxKNWqkdyhjkcSmyZt?=
 =?us-ascii?Q?VAJeTdmLpcgq0NVGJFwKA+mBzk7DfACvfuFnF8kpG2Zo8m9xBg34RjScqZU0?=
 =?us-ascii?Q?hZDYvuaFxfPxrHeZnnAIz8/cIiOqO8nm1mKD2FMXKr4YtYKHzO38X8lMiSsr?=
 =?us-ascii?Q?dPi1gbkijinGZrhPllAH6PwqTjMVAvEgCHCewIwfM2W1Bi99ZmkVNmSFVzap?=
 =?us-ascii?Q?u23DC9diAyTlyAUvmCBcg/IUVYJR5UOSePh7VUWI/oN2am1NYORkWwclcQBU?=
 =?us-ascii?Q?+rSSOGROM2D6/eqEmOunl6D/IWwj7zxHTuBiVQqJzGgnkid6NTX1dtlGMaVh?=
 =?us-ascii?Q?h5ZHDoT+ulR2KuTvXQ49/5UOMnhEUdYnarKr7qm+qcboTmKfT+cz769FjN2L?=
 =?us-ascii?Q?cZfTEuhWPRLFoZDZyUf+QGlBB01Uxk+do+kgo0eE3XjhwtRr36IogwYU3veY?=
 =?us-ascii?Q?8/44FUvjedcZPN9iLTMUnZGOJGZ1XmburuscorxJHHtS14CZgq1z6YmheZHe?=
 =?us-ascii?Q?ZDd3sXuxCVbH2U0ejMizOAGWNUHUBLIBRponkjdNOjq4jDOMF3W4arTtmGDh?=
 =?us-ascii?Q?D2AQyB8++6CFDABLVqu+53+/o6C9r+0Uf7LiH/8zS1Myk3waLAnxixuUah0c?=
 =?us-ascii?Q?5ZX+T099mThsXl/5CtOK4qpyviU5W4CxFn0JSE/ijhOe+hSJT4QPXOjcuYyx?=
 =?us-ascii?Q?9xA/PushaFypfymgLG+KxItazQsZB2ymVjzYsRi2FoCvH6MNWL2Np/sNQwba?=
 =?us-ascii?Q?WAGEv6DdIa7+GhgpIEjOdTogupITxIE0Kof8rhCGG/ibySc0f6yjnELysCL6?=
 =?us-ascii?Q?pyBepedZp1RXIoQ6uZ/pxYU+JiQS0Memn1Iypq/5aqqb0pOAzYmL5LV4leBa?=
 =?us-ascii?Q?jhmWlAibWgh5q/mCWCIM9AYpYx1GuAOm9+X+h6NsEP5Dktmt3uGT6cjJpsyv?=
 =?us-ascii?Q?ED6p7sHSrVrsk9x45eNb+g5xzld7Ctyf0tqS19A8+yBM1kK1WRJpEu7vibTI?=
 =?us-ascii?Q?OR86m4GUZrjoZsn3WENabh+b1uqEKzUcrUrfLnWU4FgFEAkqAg8MM26X3Cwg?=
 =?us-ascii?Q?7kNyldxWf9Qrv/Kh+w4AJIzwmq+ZpbKQ04Ih8AT5S2hfT9K7EBKoeRrNXrXs?=
 =?us-ascii?Q?Fb3Pt345PB3xLB/dG2kA/Ni8qlvvBvZBLYCVMiqFfOlI8kNIDHsrrWMC+TVY?=
 =?us-ascii?Q?5y1DbRpnUpP/7Efj3r2aDm8T941umq4jqDqr19ZyXUWXKRQOFXFHsfohGZoW?=
 =?us-ascii?Q?uM4D79VFiLWPNqh/R4cVPqitE17dlBSdW3jOzINSNPld2wQmazG1j7fFl1Yv?=
 =?us-ascii?Q?8eGLoQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca5265a-a797-4fd2-9a8a-08ddd36710a5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 14:56:17.2353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGdkc9jJptmoAfZNwb8YTceLSkv5khnGdu9wbQNTkCmDcVWTTNLeqwKUWGIgw6NzN7JhJfvp/K+eyxcILcSsZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10816

On Mon, Aug 04, 2025 at 03:22:50PM +0100, Russell King (Oracle) wrote:
> We're falling foul of the historic crap that 2500base-X is (802.3 were
> very very late to the party in "standardising" it, but after there were
> many different implementations with varying capabilities already on the
> market.)
> 
> aquantia_main.c needs to implement the .inband_caps() method, and
> report what its actual capabilities are for the supplied interface
> mode according to how it has been provisioned.

I have some patches for that which need testing, because I don't yet
fully understand why there are 2 different settings for this operation,
and how they interact.

- Bit 3 of the aqr_global_cfg_regs[] registers (1e.310, 1e.31b, 1e.31c,
  1e.31d, 1e.31e, 1e.31f) is "System Interface Autoneg". There's one of
  these for each supported media side link speed. We have to filter for
  those media link speeds where the translated VEND1_GLOBAL_CFG_SERDES_MODE
  matches the phy_interface_t given to .inband_caps(), and warn on
  inconsistent settings (the same phy_interface_t is provisioned with
  inband enabled at speed X, and disabled at speed Y). I'm crossing my
  fingers this warning isn't going to fire on OCSGMII/2500base-x on live
  systems, but who knows. I am unlikely to be able to find out whether
  setting or unsetting this bit makes any difference for OCSGMII, since
  my PCS does not see the 16-bit config words.

- Bit 3 of register 4.C441 is "USX Autoneg Control For MAC". Not clear
  whether it is an alternative or additional configuration specific for
  USXGMII. This bit I can test.

There is some non-trivial consolidation which needs to be dealt with
first. The driver does not call aqr107_fill_interface_modes() for many
of the PHY IDs for which it could do that. And we can't implement
.inband_caps() except for those PHYs where we know that the registers
read by aqr107_fill_interface_modes() are accessible. I think I do have
those consolidation patches in a reasonably good state.

