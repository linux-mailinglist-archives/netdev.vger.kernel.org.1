Return-Path: <netdev+bounces-218712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624FAB3E042
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 12:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493347A6425
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27FF30F809;
	Mon,  1 Sep 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X9QxpVEh"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973630F552
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722995; cv=fail; b=H5TYC2kSKOwaAFItbctgZNtndl4aw+VoQuMf776wsqaVhGQSGuSbTXj+XFHdpHPfirom9uRY8ST4/qMP/gRG1fo2edwPkR4570tz+Sp3+98Nmon1VrnpeRLxSzCH/9b6lQ+uosMlYtMZZ+I9RLipoG9iTqnPFtHI8+lO2CX0TuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722995; c=relaxed/simple;
	bh=y+/AjJAB6dutLS5itEFQZ7py+hgElVbzw8g11hLMGvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FtLEyITgTU5WTOp6TGCnU4qtDHrwi/3NEaUTlbFoZ8KoGhOYCpOa7UIuIFdMu5XUS+iE0tHvpmE+JrKWdeTg4qtoltmoUVkbt1X09jd/Z7gy1FUV103ZNTXpZz/HuVDyStT+RK2Uaz5uSE/y6FMIjIq6f3CLeoNqnyg4I2ThWVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X9QxpVEh; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WikrUXzS5kDn67G9DfcSyfqWPw/viwBETieTpjvAD0krMQ3yOY+wkaw9Imk8UkJniJQk+hGqSjoaL2FPi8uuea4LcIMVv+tUt2sUcKPaaCm2WT4VqP4yQBB0Qbc2nnbEVk2PAo+PVfVwR10xPK1ZCPuf6wFz5GscjwzNFydlKx5pwtqCJXtDzzfncFpS+IL/arQt9RU8au4EaXI3e2jxQjvMBzaQdjb1DGZNfzjRvEB226rKiPleWDnLSEWOCTlG+6Lalg7rWATgCeo+DM+WNlsywTAVlJYJtY58gUpGVHGmodcG51hzK8i0zJb5beLfew5BBLt+ixa/w79dmejuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghQq76+MivCRS3oYU5GvNbrJ7auNipLNZ3T6FZccTL4=;
 b=oGs0MseETT/Ls+sVBQtC6dpE66Ju1werNeJbOdNCVI6rQBRj0p90JhacykbFt3CEBSB7JYt35koP4njwt8VOoR0FZNuI8vnC8KI8mOx//5MAOm6znCRbc+oF17riD3pZeQtArRYFiWI0C3c3Dary97mqQPGtCp+RSvTRP+XnOWH08UCWi0JwR0k8Ag/Iffk2Tjpq21FYwSWye51TsFe7lJhcbeQa2TCfAUpZ1pnJummFQ+z79rq3yCz/oEArCA7KGAkAJdnHxMFiu+3HGqdVsp0j8/X3vv8KpNKCdSAWmZMe9Y9+k3A96bgm427DEZ9UpP2m0qm2pTCxDm9KBzDyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghQq76+MivCRS3oYU5GvNbrJ7auNipLNZ3T6FZccTL4=;
 b=X9QxpVEhQqKx9D0JipmipPGAHjD+nDxn6KfXRzmNNdUidVgB2qzQhXawnaPYHT3hB+nqP9HAlHNCNEhZhZnRrolGglGAFh2C4kUlO62M2oO6j4YURXjbL6EuM+hIQkyGa5PAmO6q+vX58eHQZIbO4N/Xq68PJ7u81xBlauDMbLj/VLJIoJDk87HbWBGtWI0+q8UuLqHTsOk4rEwAaCMYvDFZbqHiRNTphuQxhKEZYJoDR6YOb8VexQEppv4usqb7mIM8nyrsaYQRcV2rNGFVPs+aMXkQaCGzizMs/QBGW0F297FkBzJphsBC6oc/awqxHp8RSGPuZSBMR8rhh/f8EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8291.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Mon, 1 Sep
 2025 10:36:27 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.011; Mon, 1 Sep 2025
 10:36:27 +0000
Date: Mon, 1 Sep 2025 13:36:24 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phy: fix phy_uses_state_machine()
Message-ID: <20250901103624.hv3vnkhjxvp2ep7r@skbuf>
References: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
 <20250901084225.pmkcmn3xa7fngxvp@skbuf>
 <aLVivd71G4P4pU0U@shell.armlinux.org.uk>
 <20250901093530.v5surl2wgpusedph@skbuf>
 <aLVwAn87GhFHMjEE@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLVwAn87GhFHMjEE@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR0102CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::36) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: c0357ce5-8e39-48dd-0081-08dde94367e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q8Qn5D/1/PyYpDKMwfj3/gKaK2QPtUYZrGt7wFv30q6SNfbCT0b4oVDXBrFu?=
 =?us-ascii?Q?9uVnrmvIfh3K5Ri2kqHyS/dTuLI3ADAfs7Zm2nVRjC+DvydfWFRO+/5a5dWP?=
 =?us-ascii?Q?LEuJmpzE8THOrEq+K3H3t6sjf6wNKKuqqWqoN+bG3oqI9q1pbLv+o88gbp0z?=
 =?us-ascii?Q?FkHTB68pvzQfeVV41UEKQ0yaY2qlwwraYKji57UxQaJ4jTVKL71W4DW92hv5?=
 =?us-ascii?Q?zwfgfkUqCee/chVX7WHs+mMvPZfhrHvTY3EJ/GzgW1fwNEje19443Sqkav3a?=
 =?us-ascii?Q?V/qWj6Z4lnyNV82QWpatHXJdshVRddQUre96Z9HLxA5dSr2rTJJTgEflToTm?=
 =?us-ascii?Q?qZKfOyudRSLnnRJpAFs1lKWupjAuX3WPbIU1o8P04M8ow+4T4TlJ3RYjoMi3?=
 =?us-ascii?Q?e2U+ju5aSq6HLQBBLQd65P7IVlgEOIRrsaw+inovwEiu3z1pJxrWgHlsolc0?=
 =?us-ascii?Q?FVIdx47i6FW0p7F1AHSsFcRXjHU0p/2m87jUJyjHR/WX+NqD2XG1ejp60CS/?=
 =?us-ascii?Q?vUWkrYMYibro3sbjo4SfQXk/kBzF7TH+D1tCbrLTXvyyMJSfExTeO6RL7ABe?=
 =?us-ascii?Q?p6yl9um60n5XLJpuPadW7l5becEAEbBQObBoobaBEUn8T0LGH6uFe0o1cdyh?=
 =?us-ascii?Q?Pgl6+pF7MftZMBOgerfFvYrEpur9QA2bblRjPDTzZATikyrgcehSf6+zgMiD?=
 =?us-ascii?Q?G4suC2UKuQ4Vqzu+6JS1dMl6Wk7pbZmvkkU+mbuXpYIfK40Y/2UUpk0haK0k?=
 =?us-ascii?Q?Ef5AMnQHdlxRUxgnOca574MSSKAihf8aB8V3e3+9JiZrtIdXT262gkqGPUSV?=
 =?us-ascii?Q?I/FEbnZnqLP2KtADXAmtSMeAPxTaXUXgAu0iYVmkuYgwBf7d5aQwgPVgrkeu?=
 =?us-ascii?Q?S4kLxptkfYilPHcpp+L4G1EjuTfaLajNY1XQfPawY59BnzFw8lwluEYulE13?=
 =?us-ascii?Q?Jt4fgS9bvca38bBSopYBvGo5LnIFkr+uDpzjFHZTzveiHyToXKGbMzvexuvO?=
 =?us-ascii?Q?dPd+m3mOqNPeVn8tiBIakDlaEfn4eocbFfBVQ2ryRchs9Ixd5be4pKBpZMBT?=
 =?us-ascii?Q?sDMelpG0X3oaYdAdTIgX+ttwwmtAEyaTOMoGUOgvK22Rle99+OGqr1dYcTYN?=
 =?us-ascii?Q?2AaHwYFcxbseEzPAlFl+E5+HuWb0I7Tky7KCoAN8WdaD+dM9R47fhyKDyrdo?=
 =?us-ascii?Q?cKJ/K+NoxVYrU8OGR9UFuImIAehgKX8xKDRZiQ6BeJLnq3I9mpKI8I7h2NFV?=
 =?us-ascii?Q?cecqfxXTL+zh/AF6xboNAfkSZBkraHPvnC2GHPjD7k+HCJ0Bb+ZSoNN2OKwe?=
 =?us-ascii?Q?A2Sng/WSobfCDuFqWqZFibAVNCc1zYMxBzUEcRHqIiYsREHrtnLXakJll2v0?=
 =?us-ascii?Q?dvPf6IuqUAjG4FZrt4kVAI2jGDphfZ5iSKj3LqexSaLo4uMg7SvjXXrxz8mM?=
 =?us-ascii?Q?cJIaF2kSZIE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A/u6nfIeXjFOaxOPrn640l3KTZycBY9ANfLCSL0n5JDe7L76vXUOVn4fNhxw?=
 =?us-ascii?Q?mQoUaCxpgs3YTizakg5Ji8SZOrDnZEEUgUHq1CJPHD7FKnKkV+x1YhwBlsLy?=
 =?us-ascii?Q?A5Wa94LLmAWL9KqOu7QDMnmj6rz2aEa7fIXSdNpLitgJf/fhtfBPNeRj1VKT?=
 =?us-ascii?Q?rEZo5+ivFc4dBtzppLQu6ey3vKRzljajMTM83CNszgqP/UEMTOQGJUvWFlL6?=
 =?us-ascii?Q?kCmHPdQ4bS4ntufYJW5EJq2tPHopYUw4k8dmtVlNjDD6IHnXCplp1QetRY9l?=
 =?us-ascii?Q?XIvTzo/38ZzRSPVL90gNiQC6Wf0STo0fOOYajUWckHcGh8JgMCZplc0d/3gR?=
 =?us-ascii?Q?1nYHCsPslEYglQx8IrPDCGgR0s9HtBQNhYhSmLUv8CxuTXJTOYBB9SIeVD0U?=
 =?us-ascii?Q?47KBu3eI3pO5Rfn1YcTzROdLZTWSqjZmWIFbEwMP9f4tPki7lHyPg/+PrBFe?=
 =?us-ascii?Q?1Pu6MlTUbWIiIDnkQtsO8csa1ymcbhE9VoZW07hkeWEPpM+6HMq7NqQ+Treh?=
 =?us-ascii?Q?MA4Gc2KOsdINtowgY2GkQEgLFHV0EUqrXTY9X+RLory/RLtIGq0BNgMv4adB?=
 =?us-ascii?Q?A2VPOs5lEOcy0sy2ofneF+ZO+N92BVjtQx4ErFNLCZ+tNQSHBcv7Z2e68iBB?=
 =?us-ascii?Q?O3KY+vsZosliKePreO+XsFi5oZ61Lg/WAhXXgywf0FEm3HBE4L+77onEYWcZ?=
 =?us-ascii?Q?cA6hGtzU/Ag4hD4XiHt5+4WqNiDe04jvhrPw1IVEhJ1X+KlI5K+9LoKqZNn6?=
 =?us-ascii?Q?sHWJJ1ZwV3UcYzo/UZSzj65PN8GtAQWYToNbXFO92xgRg2YVKno/xlAH9fzn?=
 =?us-ascii?Q?hJjmqA0ODKj4jbGEDZJ31WY70CyMls4hd0cj8sjy3sYb0VSqnJfWxqPxI8PN?=
 =?us-ascii?Q?I91XMKCb6tz4ZJy1BSQyT+tKNzKxhsQOhaRixDEdZoOnY72jUZM6M4B41DVx?=
 =?us-ascii?Q?Gl0GG4C4bClKanjKSV/GlLGx7nPGz0dZLN5fnHbhasV9cRDxd5Hn4hXUgfSG?=
 =?us-ascii?Q?Ow4Ke3VQTpn7+6yWytSuLqfm2pMG3ZTaKry/3LgAGKQbqCybIgWOOPUgWMWk?=
 =?us-ascii?Q?hym7/ahEX0dbQcPK3ibOjqQRxEgpS6IEVOHdCLk6MzogvBgcDQj3SiEZfKe/?=
 =?us-ascii?Q?dc1C56nx7dcTHfwObpEWhzoyLKd0tjaCBLiJIIuW6KLWPO2YsmVMpqdUIqZ6?=
 =?us-ascii?Q?ek66xKGfXay60rzsMm/DZ0UTi4woOiNVlslPSd40eiA4n09CFbLZqI0+NAX+?=
 =?us-ascii?Q?MVhhfgW09PFOHBcGn59wlY56IfokbMwXrGIHApJ5rQ4Niep0Z+nnV37nwwgt?=
 =?us-ascii?Q?Wfadc3J64ly7SX5wpMXdEK/LlYv8pLevYK7qmiaJtmigG2T0BlO4NxaCC29j?=
 =?us-ascii?Q?C70ZQnIBjZMGijCi2Nrymv8uyJt3ItGzBdrp41GFRn8O14MpY+5hTOM+tgkf?=
 =?us-ascii?Q?G+nHmVNuQsGMZBIVkwInlxzleQZkB/ibxwSfvlxXHBeQ58ycFdT3qp5y5AjO?=
 =?us-ascii?Q?MydoACgh6Jg4NRuP9UqzTjE91iyBcgHwRrd6m6NZIVedIVYB0SU6RHE4OGyD?=
 =?us-ascii?Q?b3USX5xRR17tpyieJLOi/pf4Gv0Dink/fGYwS5rs8vB1Mn3LX/0EcOSrBvBB?=
 =?us-ascii?Q?SLG5f1stxCmzE3vMjOwEhnhZDxSQubxJeLurJPBfMPQ6swlN5buPQaxoWB8c?=
 =?us-ascii?Q?6Q+TyA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0357ce5-8e39-48dd-0081-08dde94367e2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 10:36:27.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGlmVrTyPCUs3EKwHN5VclTWhCCMAKE/VKKc9jvy7CfPiidAzbaOSicFxHqkceYTaBvD6GGbEYwaQ7xU/ldFqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8291

On Mon, Sep 01, 2025 at 11:05:54AM +0100, Russell King (Oracle) wrote:
> Well, having spent considerable time writing and rewriting the damn
> commit message, this is what I'm now using, which I think covers the
> problem in sufficient detail.
> 
> >>>>>>
> net: phy: fix phy_uses_state_machine()
> 
> The blamed commit changed the conditions which phylib uses to stop
> and start the state machine in the suspend and resume paths, and
> while improving it, has caused two issues.
> 
> The original code used this test:
> 
>         phydev->attached_dev && phydev->adjust_link
> 
> and if true, the paths would handle the PHY state machine. This test
> evaluates true for normal drivers that are using phylib directly
> while the PHY is attached to the network device, but false in all
> other cases, which include the following cases:
> 
> - when the PHY has never been attached to a network device.
> - when the PHY has been detached from a network device (as phy_detach()
>    sets phydev->attached_dev to NULL, phy_disconnect() calls
>    phy_detach() and additionally sets phydev->adjust_link NULL.)
> - when phylink is using the driver (as phydev->adjust_link is NULL.)
> 
> Only the third case was incorrect, and the blamed commit attempted to
> fix this by changing this test to (simplified for brevity, see
> phy_uses_state_machine()):
> 
>         phydev->phy_link_change == phy_link_change ?
>                 phydev->attached_dev && phydev->adjust_link : true
> 
> However, this also incorrectly evaluates true in the first two cases.
> 
> Fix the first case by ensuring that phy_uses_state_machine() returns
> false when phydev->phy_link_change is NULL.
> 
> Fix the second case by ensuring that phydev->phy_link_change is set to
> NULL when phy_detach() is called.
> <<<<<<

The new explanation and the placement of the function pointer clearing
make sense, thanks. Maybe add one last sentence at the end: "This covers
both the phylink_bringup_phy() error path, as well as the normal
phylink_disconnect_phy() path."

