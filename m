Return-Path: <netdev+bounces-211531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37163B19F2F
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50F93A1334
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D113D1ACECE;
	Mon,  4 Aug 2025 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RWSU1Lou"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D512566;
	Mon,  4 Aug 2025 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301707; cv=fail; b=TraoJIC9ObqhQ+PVXPb5Wr7MZDjSsrUXaeuNAAEoHN/JSTLiXPxcJYycd9qcjkZ3BZvx2pF5ECZDKv6z15ZyLHzck9bXB2TMHmqWny6FBCOYoK21/2kCiOF2Fug7MDxeBpSkVI0EMIZPWjWaqYWPjEuA34fiSAK0jmyhda2P04w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301707; c=relaxed/simple;
	bh=jzQdSSTRaBaGZ+mvPxc62oDpm1WiJRU6/Ykx2tBzN6g=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LhBkwlZcPmkF/JI1hrIO2jpPpJfCC7FIwaENlC1A7VSajmCZvuF5ojXrozuX+LooNF5TRcRjsaLdizmNkmJp4Xv8wK0RENktOjDIQ5d/Ee845VCzNltyq3aZGqFnlBewOK5iouUS0Sks2PtqDEPvtpYCK2Twi2UGp0e7AD/kTHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RWSU1Lou; arc=fail smtp.client-ip=40.107.159.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoF9fV/8/CwApRKRjr0GZv8tUP7eBjq2vBrQq00Dl+yhAT9NAuBuTL31EQ4FJx11cbR+LuyvKgqqgzIHYOJDH85Fa9xHQiT2/eg6eVFHTBkpGmcDE7DqoNCt1wJ5LxWAtEnHgr0La2sTNKfCl9wh4luL2WuqhwCa+KuMcpoZG9VELlTpicPorjxhqsXJqg9+mX4BKQ0UBLZzMVGDCeYrYxAFLYIUoZC2Ihm+G6YyDHgxwT1j3pzGAgvA8pwCbw8rQ/Vk1/cYqH5ygyYazD4HTWFqHFQH6heZC/7/vGyiBlfeHEhtYg8syNr5QzKq6E6qLnqsCU78yqOf1ielExHnCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4nT1qdoeeNYJr1jANL3Sm6OH1ZOAI3O66l8yEfqLmE=;
 b=KNyCrSx2KssP/kpuhzgiUT92Cenuyt7K1DOSEXb/+KzEOUuQwo5bNce5Pb2o00rYu/p8gT39oZREIDl3iGMRpA8gv+lH0oAqoHfeO5//D6WmvWwHVeSXFmQEsf7oqLVBuRIZG+I733RVSBXKdGXi5bwv/kLDgPdEePF0RiD4/WbTYt7q918aeQkwM2hgbL2ut4GEsYAU7/K8fR2fc6L8ghxB1MCqCoeWrRj2x+2wjcvMoojlmcNZyARm9thI2BMikvubko5rgBAZKojTwuI1Lx+DOcEs+5ayQwKYqwYQzPHnN+9mA0mTWpit9COrDYbtKwNqh0eXqKB9wsvNH9xskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4nT1qdoeeNYJr1jANL3Sm6OH1ZOAI3O66l8yEfqLmE=;
 b=RWSU1LouuCu/ivyTb3ipnRUT+1/EvqU50ZNf0CTopTjASL6C767Pjk0B/eEh/JUgyyD/PsrufjcmaA1fM9TrRs3GVSC8T5Q265PZGRjVcqofR6XBux/lUT9dXur/IA8b6CltUIbTwlnnb+xFPnz1KHB9KEKxdQ7NAg4XYV5ijde7Eq7aIX57k1sE/emJuIWwuspV0xmsK5uUBgqpDxOS7cfysijeab70UPJbpCPgNHrvEPHtZELNT6qnVuBEzSO15T+zDJylQPLPUl5o5Kg5ob7STxZHCloEbSfIklIpTqP4UqboGCD/LQIjVjnHwB4Zv0V++q3ILed0ZuzbT39FDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB11033.eurprd04.prod.outlook.com (2603:10a6:102:484::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 10:01:42 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8989.020; Mon, 4 Aug 2025
 10:01:42 +0000
Date: Mon, 4 Aug 2025 13:01:39 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20250804100139.7frwykbaue7cckfk@skbuf>
Content-Type: multipart/mixed; boundary="4tj3nzivy3sqjajf"
Content-Disposition: inline
In-Reply-To: <aJBQiyubjwFe1h27@FUE-ALEWI-WINX>
X-ClientProxiedBy: VI1PR08CA0211.eurprd08.prod.outlook.com
 (2603:10a6:802:15::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB11033:EE_
X-MS-Office365-Filtering-Correlation-Id: f065a6c8-5660-4fec-dad7-08ddd33de963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|10070799003|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gadCvG4xBfdBZNooA0dcCN/zw+3wGRnb6R6d5dxc1tgWpmYiUuJ/fQB9pjj4?=
 =?us-ascii?Q?tSrtZCfhnCdZmWGtlFLm626zuREuAkclu/ov3B3jPJgQ2FKlDcpKDyRapAZ8?=
 =?us-ascii?Q?Ekn5bJ9cMDJi6kX1G4VeH7JRfJZ8GaPS1PKbIhl1fOxQQwIUw4pGcMpHK4pf?=
 =?us-ascii?Q?6kis+xc7d7vopvdi46IXeN56COY8sgcd6C/FwkPactE5OyrlOIo1SfF8EpvW?=
 =?us-ascii?Q?+at2hFADvarel/QXufZxWJb+uMgpkJqGdCWXg0auhjH3om1cxhNzYw6T2pCP?=
 =?us-ascii?Q?PuuNypOWyZzAx7LjDMBSwSl8ufwlXnTfKdsWZ5uLl7LK/sj/uWAVm5moOCe0?=
 =?us-ascii?Q?lKmxGQefOlwGG2MLfzEqE9ebioXL5NhDNhAaxwg3qTbf8BloxBhn5oTX9mZ8?=
 =?us-ascii?Q?xOF8Z1J1nF9noPGDY3h2zuQfI/J5yK4w97fVWV4dX0/909bemlJF0pTfAWi/?=
 =?us-ascii?Q?fnFAS9uf5ABC2VfZXwjehh+ejhszbwXDt1ur15lXDDfnEh+A85QGHC3wC1Nu?=
 =?us-ascii?Q?wG6oRdNQNUpSkpP4v6rnEMLGFAJfR3GgXfqBw7t4EiyxTaBrC/WlWMFhSlFJ?=
 =?us-ascii?Q?OzwXRy0Ev6yl7qbgm8YH9ETle5yd8drGO21zevHquib4GeKDw1GM86tdVQFO?=
 =?us-ascii?Q?k0fDkhMhTv0/wKHIfRSBL0AtqGdTC6pSJfQjovD96HgPkIrpIKcoi7PYIKUZ?=
 =?us-ascii?Q?51tdmL0lxnNfnwhWff0GhFGgEp5nfRkvgfrMfIPURod2/RrBjXixKsFncHtK?=
 =?us-ascii?Q?iXMQ0MFQDBafR/Ka7BelsOT2IjWs7pBRbWQ9VaTP9jXNah/eZg0I51mPqeo1?=
 =?us-ascii?Q?m0oMpfpu0spYDKrk7TVFQQtEAUJUk6o8wLzbEqshpW+ob8lzlQRthDa7ctVp?=
 =?us-ascii?Q?uPYSUgoG3PTq3JnmDw8YF91A5CvC9zh4fJvYGahYfjRvvzYN9IGjprJnkdU4?=
 =?us-ascii?Q?xnqNA+EbGr3ee7jgZK7jglJgosxlndQn+rB1OtWhPBDdALKOzYzCZk4w8Yqh?=
 =?us-ascii?Q?UeITEpBYVrguuKRQGO6Tf2n5DRSDkrMOQIduG4mEBfPI00goS2imFLZWRd84?=
 =?us-ascii?Q?9NsCRuicqpAuxA4/2BDSx1Ek+m6UdaoMjq5JT0JQqyVyA2Yc4yEVANtPvSiF?=
 =?us-ascii?Q?yvLkLNPmFyUpCR1MzZ93ZpkGikRxM7vrWcz2wax9WRIRo1BdsedJFL/6bi4c?=
 =?us-ascii?Q?d7496aoXd3YNFSq/YTrgQxyS7yG6JV5yFjQxST48ATggfgCuS+Ht4L9X+7z7?=
 =?us-ascii?Q?9RdtLNoS+s5ctktQrtbYnEzIkX8U872yU8r95YaDU+F5HqF6OMASinlOheGl?=
 =?us-ascii?Q?4OV//aB8aDO1lxozBq+x1bcV9NDb1beHWoa/4x0rQlySk49xSJsEH+xIVnAl?=
 =?us-ascii?Q?npVtnCKIloEcjtrI0nztvCnVFBtAwGq5vpUiTUrOG/S+OqpRa4GqHLwbvKpe?=
 =?us-ascii?Q?8ASM0GjzEDo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(10070799003)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KFahWN4jj/IlfMXmpA1F9hF8CdXQTmhmT0cxMjcfTzDs705LWkZQbYs9bA3O?=
 =?us-ascii?Q?F+4RLZA3qQjNI6sVb5Dqw6xeHBa3EMcbKXzqYDL9C05Q6K/RVIzeloMmTxlb?=
 =?us-ascii?Q?pLIDavY1SdafjN5eelwI3FT2jdi7+y6ZaaC2IGDhSjNbLCJjg3WM7EQwEQ1I?=
 =?us-ascii?Q?Wn2XPn+W9cR7LyIVhBqbUNGRhmL8KCJAQ022kM2Mo2H8pHNYwsu/wvsrkdWQ?=
 =?us-ascii?Q?f/Lk7birwzrUyKrzFU7lK1NRPPjyjjjtnl4YIRAgDut9SI8UzbOP12cw3wqB?=
 =?us-ascii?Q?LP/QstkLY/G7qvmBgXxblSriwPgO8UjsVjzM5IDeABHCxaUE3JMnK9JPIMNo?=
 =?us-ascii?Q?x1MNpALNv412O5sexQ/QVjj8rxszcwnY1GgJm8ZUGogdLDuA6yLjL0R1Gb86?=
 =?us-ascii?Q?LMSuFHYOW2mUGriCG8Ef7AwXNHuMTLrR3D/5cOYIATznxxwOhT4iGhTB+RkB?=
 =?us-ascii?Q?a+k1+coYKmxAINrqw593Z1orzd1TOrpACve4AvZho/UXsNvba7nZ4cY5bN/i?=
 =?us-ascii?Q?y663BUhE/s5S+1mGMMLR0AaG7J5uoKSnmHThW0Bfm2KS9Oxki8D4Y+hR5sD8?=
 =?us-ascii?Q?g1QCS6ihtYi1Q/nQtHB7ZF76YTD2ia16A2U4Mo1mrbMIN5mo9K0N+dQaWtxn?=
 =?us-ascii?Q?WGDyzM78XO8ybaBVwqfJMg1LO/5WIgXafxsbUKauMan+0q3NkrdiUDpzGfK9?=
 =?us-ascii?Q?ab53PSrYK7DQ+n9/LZI7W/YtLuZcS/7R3a2usce+qJKYsXoN/mYO1rS1hXsD?=
 =?us-ascii?Q?RTSqf/bzX0LLxKxrwDdQuAhfMt/8TWFkMHa/wLmDGX4RGMTRJLLD1PofBrrJ?=
 =?us-ascii?Q?/8MIc0o8CRtWIc9S+dSccz6RNqijced5tY5xvAEHKarZEDwTp4ydUS3r0p1s?=
 =?us-ascii?Q?D/KByfoI2SjbaTS3Gm5gxA4AXx7wrbpTW6iCmQP5lYFYa1/bFqUA9AYzFwZM?=
 =?us-ascii?Q?uZ6gYo5iGAETAjiiU/IEIgtaRDP//il7+sCpHSNiK87Bh+x8uE1uPEJCWkpG?=
 =?us-ascii?Q?9gJYbYW6gA8jkDIhSyh/EiYM0wJU8bzku/zPOJaEtFraN/qFdLuJhIgJEQnt?=
 =?us-ascii?Q?vtS0O5c9gYe2iRZf75WsL3q/ORoID3f0H6MaMiBQaT4o+OmycFZlxmysydKM?=
 =?us-ascii?Q?tN8dJOIBPaIWv3DT1ehBs/hQmw6SZkplGedAyi6xUrKiikEl5oj9F9HQZfbz?=
 =?us-ascii?Q?dL2DpRAtyYWLCVPovPjou8ZoYq/T5EMORQkdUqZqIorxwgn3ii/xTTMV8HUt?=
 =?us-ascii?Q?7NmXBTtUA4i7oADOKKRZwTrzy+0M3xqELkRI2sB3kXzYnLkSSBHEuqF1/mQE?=
 =?us-ascii?Q?Z/fwFuYr2Eq/j+3csmMg5u9nCyBfVoqGqH54h4D/h7oGDjCEHdbsjzFbjxGs?=
 =?us-ascii?Q?uUKNAFIhUwYLUT50BUw1vicUF1tZHc6sg7pcSZuvlh5spMZPB5QFZ8UTRJ/m?=
 =?us-ascii?Q?/TxOB5qpQMpLmNrRUTRngilO0OHBfRSI6LgvhpCNGaFPG7w2NMQuzb6t2OeN?=
 =?us-ascii?Q?z7HIblXb1V/mAdK++zcocWqvOVX/gT5XL41Y916BATFmZKb+LQph1Dy12oK9?=
 =?us-ascii?Q?7PuJ6lKwf4YzMnI96vGCVmvkQf6jkJSWyxmzExK0deEMwiz+8I+42dqpn5kh?=
 =?us-ascii?Q?Xz0kYLPMyHDmjgjWehlBQkQI1zvOggabcfCclbQWCrdrcrtwYMpOfWYsBYls?=
 =?us-ascii?Q?lqssEg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f065a6c8-5660-4fec-dad7-08ddd33de963
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 10:01:42.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CODVQWMnXCepIuVVu1ei6q7y8RIUaV+c7jhVOTkkcHe32cul9MGkblJKi2aov1Ui0cBiH5bT2nsF0Sgos6b4Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11033

--4tj3nzivy3sqjajf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 04, 2025 at 08:17:47AM +0200, Alexander Wilhelm wrote:
> Am Fri, Aug 01, 2025 at 04:04:20PM +0300 schrieb Vladimir Oltean:
> > On Fri, Aug 01, 2025 at 01:23:44PM +0100, Russell King (Oracle) wrote:
> > > It looks like memac_select_pcs() and memac_prepare() fail to
> > > handle 2500BASEX despite memac_initialization() suggesting the
> > > SGMII PCS supports 2500BASEX.
> > 
> > Thanks for pointing this out, it seems to be a regression introduced by
> > commit 5d93cfcf7360 ("net: dpaa: Convert to phylink").
> > 
> > If there are no other volunteers, I can offer to submit a patch if
> > Alexander confirms this fixes his setup.
> 
> I'd be happy to help by applying the patch on my system and running some tests.
> Please let me know if there are any specific steps or scenarios you'd like me to
> focus on.
> 
> Best regards
> Alexander Wilhelm

Please find the attached patch.

You should only need something like below (assuming LS1046A fm1-mac9,
may be different in your case) in your board device tree:

	ethernet@f0000 { /* 10GEC1 */
		phy-handle = <&aqr115_phy>;
		phy-connection-type = "2500base-x";
	};

because the pcsphy-handle should have already been added by qoriq-fman3-0-10g-0.dtsi
or fsl-ls1046-post.dtsi.

For debugging, I recommend dumping /proc/device-tree/soc/fman@1a00000/ethernet@f0000/
(node may change for different MAC) to make sure that all the required
properties are there, i.e. phy-handle, phy-connection-type, pcsphy-handle.
Either inspect the device tree through the filesystem, or save it to a
text file using "dtc -I fs -O dts -o running.dts /proc/device-tree/".

I especially recommend instrumenting the live device tree, because I
don't know what bootloader version you are using, and whether it has
device tree fixups enabled (which mainly add status = "disabled" to
unused FMan ports, but also change the phy-connection-type in some cases).

managed = "in-band-status" is not needed and should not be added. The
PCS only supports LINK_INBAND_DISABLE for 2500base-x.

--4tj3nzivy3sqjajf
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-dpaa-fman_memac-complete-phylink-support-with-25.patch"

From 2b4d48c93d317cccafc8128e33f18fab244d5bce Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 4 Aug 2025 11:15:26 +0300
Subject: [PATCH] net: dpaa: fman_memac: complete phylink support with
 2500base-x

The DPAA phylink conversion in the following commits partially developed
code for handling the 2500base-x host interface mode (called "2.5G
SGMII" in LS1043A/LS1046A reference manuals).

- 0fc83bd79589 ("net: fman: memac: Add serdes support")
- 5d93cfcf7360 ("net: dpaa: Convert to phylink")

In principle, having phy-interface-mode = "2500base-x" and a pcsphy-handle
(unnamed or with pcs-handle-names = "sgmii") in the MAC device tree node
results in PHY_INTERFACE_MODE_2500BASEX being set in phylink_config ::
supported_interfaces, but this isn't sufficient.

Because memac_select_pcs() returns no PCS for PHY_INTERFACE_MODE_2500BASEX,
the Lynx PCS code never engages. There's a chance the PCS driver doesn't
have any configuration to change for 2500base-x fixed-link (based on
bootloader pre-initialization), but there's an even higher chance that
this is not the case, and the PCS remains misconfigured.

More importantly, memac_if_mode() does not handle
PHY_INTERFACE_MODE_2500BASEX, and it should be telling the mEMAC to
configure itself in GMII mode (which is upclocked by the PCS). Currently
it prints a WARN_ON() and returns zero, aka IF_MODE_10G (incorrect).

The additional case statement in memac_prepare() for calling
phy_set_mode_ext() does not make any difference, because there is no
generic PHY driver for the Lynx 10G SerDes from LS1043A/LS1046A. But we
add it nonetheless, for consistency.

Regarding the question "did 2500base-x ever work with the FMan mEMAC
mainline code prior to the phylink conversion?" - the answer is more
nuanced.

For context, the previous phylib-based implementation was unable to
describe the fixed-link speed as 2500, because the software PHY
implementation is limited to 1G. However, improperly describing the link
as an sgmii fixed-link with speed = <1000> would have resulted in a
functional 2.5G speed, because there is no other difference than the
SerDes lane clock net frequency (3.125 GHz for 2500base-x) - all the
other higher-level settings are the same, and the SerDes lane frequency
is currently handled by the RCW.

But this hack cannot be extended towards a phylib PHY such as Aquantia
operating in OCSGMII, because the latter requires phy-mode = "2500base-x",
which the mEMAC driver did not support prior to the phylink conversion.
So I do not really consider this a regression, just completing support
for a missing feature.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman_memac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 0291093f2e4e..b3e25234512e 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -649,6 +649,7 @@ static u32 memac_if_mode(phy_interface_t interface)
 		return IF_MODE_GMII | IF_MODE_RGMII;
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
 	case PHY_INTERFACE_MODE_QSGMII:
 		return IF_MODE_GMII;
 	case PHY_INTERFACE_MODE_10GBASER:
@@ -667,6 +668,7 @@ static struct phylink_pcs *memac_select_pcs(struct phylink_config *config,
 	switch (iface) {
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
 		return memac->sgmii_pcs;
 	case PHY_INTERFACE_MODE_QSGMII:
 		return memac->qsgmii_pcs;
@@ -685,6 +687,7 @@ static int memac_prepare(struct phylink_config *config, unsigned int mode,
 	switch (iface) {
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_10GBASER:
 		return phy_set_mode_ext(memac->serdes, PHY_MODE_ETHERNET,
-- 
2.43.0


--4tj3nzivy3sqjajf--

