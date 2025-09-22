Return-Path: <netdev+bounces-225269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40620B91650
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00837423D8E
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73699306B0C;
	Mon, 22 Sep 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dQuTfYe+"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE051A2C11;
	Mon, 22 Sep 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547736; cv=fail; b=kpy8GjOtbHj/iKDtyV02KrDENHGL5+h/mju7sX6ydEgO4zNIzbx3RRVZsJo+1wSnw5SC2nyqI0AtGtn7neADteMkAlQDE2GCvvukSoTM+TmBJXS8nNHsU3+Fxo2JNsqHGZnNhEEv6gsP3dJaNA5USbwQns7k4yEF4j+LKdMQ5+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547736; c=relaxed/simple;
	bh=1RqgFWKpDP8pbWhFuNG6f+htR46sytI8NuRTW9IJGSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PeiEOH57hZXL2fZFQ/1GNtDS7bEyi22obZIzyM11tbSL/gaR32ukijeYXd6iiqXiOQ8ExtbEA303MtfE+IwjB/NgV5GLVQc3stF+dyWcIkk1eTs7LlD0V6xU9KotJejPYXpbBE8tOQqY9R9i0PbXdUaoogDv0xn+bIAERlko3bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dQuTfYe+; arc=fail smtp.client-ip=40.107.162.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9pxjgl9Bw8wIUuI6qrxU4KrGXZD/bEcg2LRhCrf9qYkvHCvwGjN91Emd7Yms3qPyc2ADf3CSUtTxMkVZGfPcQKPl5UcaBO3scIb4+CST2muANxBcVorfLzw2302ShoCRt94kd2gnmiXW+ifstNwzLDBemKki8mqU+w4iL7KvEiSC0ZdEQIHKpmkZemvzvXYCN8qLvpgIaoIBc7DPZVY49uKhurgSc/0BBB2+FAtrtWO1mmnT6/+sQV/WU1/FUDiFPfCqjgKMBJfMqZjdQsP00n39wC1jlmurJOMDG7z/LnQWPeHjKOVDLV6Odl9H3IHatNUuDLpk+E/3lcv7PSH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8/ywU7DdHkDu79XFubQr2rJlrNSIW+zguTkScxXkpE=;
 b=QutqPr7qBWWrSAk7ZjAUCynsoh+vOk31CMPb76lyfjQLY5NodoJRo64/pyyKZfYHBzgy6qvP8sTnls6gcE4DAb/YoxFSIoXpnPi5rk446KjesYP8J+RngFaTFzJrdSYB9fdO8wde51UDG+HIh7Af9nmGMDCKD0/z7tIx4QHiN+6XEHF5rtk2DfQdFXwNPnt6nVUfK4Jw8TU8WdmcUSDumd7/oA6sy5ojjVvhqReA0wZsAMmZTP0bunKH9AZUuqXmv54+TJHSEXsoNEHMoY+S2jnIPKztefaGFmn8a6USLvMvi5SvrcF/Zv8/H4k+8XUOyw5qoqiVPnp87+CJIJl9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8/ywU7DdHkDu79XFubQr2rJlrNSIW+zguTkScxXkpE=;
 b=dQuTfYe+6D9XkfmzmaNbiw3qsTK0heoaTRM6P6IY+erpomhloX7Dkq4rhAhje75f7CfgAb/FwpfASngde04pMsyCnRSERlpwvAbS0GlxvaD76TtkjrhKmL0H5vCzbIqdstXW/VohLQobcLsLQ9MRO/VVOU5rdiv7nE/Jzfa6KE65VtbL5hlLRfGyKTJKT1UoNjnSHJL8ctLySLvHTZ4Lcp3miDHkhgRS/m0WWde97bc4+CqU1voFAko5ua9ob7fFU57rSGSHYk53FLSeUs14trh6nGk6sb749TQ0llQOyfCAJY1Kgww7zUV4FKxL55mcs4Z5tPUfgV7gBdwaumQV9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU0PR04MB9467.eurprd04.prod.outlook.com (2603:10a6:10:35b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 13:28:50 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 13:28:50 +0000
Date: Mon, 22 Sep 2025 16:28:46 +0300
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
Message-ID: <20250922132846.jkch266gd2p6k4w5@skbuf>
References: <20250917113316.3973777-1-horatiu.vultur@microchip.com>
 <20250918160942.3dc54e9a@kernel.org>
 <20250922121524.3baplkjgw2xnwizr@skbuf>
 <20250922123301.y7qjguatajhci67o@DEN-DL-M31836.microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922123301.y7qjguatajhci67o@DEN-DL-M31836.microchip.com>
X-ClientProxiedBy: VI1PR09CA0163.eurprd09.prod.outlook.com
 (2603:10a6:800:120::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU0PR04MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 9afc0e4e-431d-4b5d-a27b-08ddf9dbf759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|19092799006|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Nv+fy0zeJWj3ynYhSz2lD0HegZkydeCFoAC00NXSOblke/ElikUF9MDT/O3?=
 =?us-ascii?Q?ST0W1xGESRw7C/phbL560S9cfvuk0dYlyPAYwnM6pfluD5VM2vxc5On+fbXH?=
 =?us-ascii?Q?UZn5SfMUhNiICsHhxIibuZ1bKo9TH5uGaYAy0kSDact0yMd2mT1oS/3jsla6?=
 =?us-ascii?Q?myeqEY7xEZdNJQL1vcxjKWaR8M1dyZ1jtClSH/u7XEX34kKOagDe49Rf6bRW?=
 =?us-ascii?Q?/00Vc3BU34ke62D3K1hRk0OIGdYOnbOaZbNOoj3ePxasEhOfcm3R++310/bD?=
 =?us-ascii?Q?HZ2a66+3wgVThXEpvG+i/6nyMuvDC7PpQNMjc9hv/rtGEpPDoQhev+4swncq?=
 =?us-ascii?Q?HmQeMBXNR3oHoDowMYunqjraR0Wt4F33O76XM9f+vWzVKcuTfi/q4opdFIzq?=
 =?us-ascii?Q?H/sk4Z3zgjYHrg4/uJbGBbyiQ6V4oHyO9XypD+WNGsYp8/RnLMOgvYKBEZEp?=
 =?us-ascii?Q?mDjfcpAR9p/AHBpgfyNmi6OvPnm+6GnSEy8SFnZol1cV34e6ca4ZfZ1PG96A?=
 =?us-ascii?Q?Fcy3cbXUeIB0/u3PEOwxLdl+jfw+wcw5YL0h5N3NZ/400dz6Ik2PMdSn4r0t?=
 =?us-ascii?Q?jyj6GJGoVlxG7TA3Qsk2aV+yeUND0mWCcc7iYqL8ZALyYMil6IyVr+pN1kNN?=
 =?us-ascii?Q?qFFz++W+EI4HwaSsqtFK2C/jJoG4W6eqSfwjM0SImYPbdCyM/01h4WR96jKm?=
 =?us-ascii?Q?XIKwJeZHDWK6sNdwrxE8jjor74SVdr+wXaRtaabemSo+LdJkoCinHRK3aMfr?=
 =?us-ascii?Q?iWfKItrmvcGuI8rscaYxl6Wq8nkeFY1xRQzF7jEG8u3H7tYcSjA/6VKrznI1?=
 =?us-ascii?Q?vtdfy16x68zpmxYzLQTyp+25brqlxM0lbrVDs9jqlzJuhg+P0iSlJDXP3ayC?=
 =?us-ascii?Q?Su1QuYEDN3lTotvmZFAmYbNl4I55aj9vjukNfxRpus1E+q6YgTGQypqYqORs?=
 =?us-ascii?Q?Fa0hQt4ACmrmmtxDelIWD4OqW99u2jysUDqMa+s27y7g2JGKR+n6KbaV8v7Z?=
 =?us-ascii?Q?Js7Yp9U7CoDjCd/l/WOTypFnV07yWdoKU8B7v+tqApygCRRNCrYdzE8Xg8sA?=
 =?us-ascii?Q?IUHWgqa75McYZJVRF2wHuGWSkKs4NcWo+zRUAIXkbKNTqMFWR9l6OdnJSzrG?=
 =?us-ascii?Q?iB98NF0XdDyQiMcNmcLYt/Jveb4uHoTcUmKOG+U9KcmC1taG1Y0LZADiATk7?=
 =?us-ascii?Q?6nVJlOja7eMG+8OUgRlB6G5qRxN8OAepZa5SQk70yQeAdAvNFPuPdI2sDiR7?=
 =?us-ascii?Q?R06P8kJAV7/ijIr+7jVIG4O/w2VRx5+FnrKhh+GZHr8fwBLLfURcsWeEdGCJ?=
 =?us-ascii?Q?XiW59WBqNJTFNglVdGN1Ie0PfVRqglDQhLLi/ImS0K+RyuOttV9cSv5ZGrbR?=
 =?us-ascii?Q?HU4njFFAiMZC8eJPDKAyoV9hCa0mFDER5Wgp4sZJvsV4Tn0PWEHxmk7P2tx0?=
 =?us-ascii?Q?/v6hiPt1pRg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(19092799006)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5dGVBZSstBWnkK2rPF59gQWKynP8ywA1LRUoXJ+yNNFaafKR7B2Xd+ZAeIFy?=
 =?us-ascii?Q?EFbTC2NY2Gi/qErGjzH9n2+LErL/VAff8BMPfWBPUZIqFLD2DB5hBynCXzXw?=
 =?us-ascii?Q?b1WGasqF8Anoqe+fQatImvsFTNlO8rPPhjUv8oIgwEfY75fvAx4DS5cFpPEO?=
 =?us-ascii?Q?p7x6uH+wjdPSc0saLrKT2s/nQe01uHH2DEBeK0l3NSJgHrZ1pqg8ypL+9nvZ?=
 =?us-ascii?Q?rfyynpqRbkltG91sxVXgfrFog4Knwcjqo5ulIU7jXaxeOI7qh6E0rvkk+Nuq?=
 =?us-ascii?Q?agxvRrz7TfJ+JCTMltg9MRWuL5QcaYtyowx4sance0XkoHfS9rXZZMwl/aDL?=
 =?us-ascii?Q?4qy5gH6YZoUXzs0BL/YtHu48kd3sp4d3/xE1dcUQLUgtvMgks2VuJrXG/qYB?=
 =?us-ascii?Q?RvfF3fzh6pWWZ/504IGXdkLrydPcOxZDyib9IuywUsDYZXjHU/tetilBUChe?=
 =?us-ascii?Q?1crFnecrWJD5QIlqOL7B0hc3Mt+TAWmtfHPbrnP9a6FGMrqDrNpEypYRH2F7?=
 =?us-ascii?Q?ZWQ5H/lyAzr95taNuBTtg4ux0sZUa3cQ4iIfkk3fbF+a7UnqP/STJxWpk/Ka?=
 =?us-ascii?Q?vDKQMLgB81He8N4bmfXYm8/fOZXxcfuAvR0dGpT6OOIMvNJ7d1PsWZE/rzK9?=
 =?us-ascii?Q?CV+zu6CzybeMNL6kYewzou3GFqG7PQ0sCKeCozh1uUw/b2Z7SML1c9AWpQwA?=
 =?us-ascii?Q?gQKPassmjS8ItIr55MrvX0Zzv4LYRotDz1EHZyLQ40P2n2XKsQK+o71NLNHo?=
 =?us-ascii?Q?AXRpO3EtlIN1mzDyeL3C8ln6lG8s/Nd8p74kZ70lUU3uAco2+4bSJJzgzvZ3?=
 =?us-ascii?Q?OrewG7kfcEzNHtrUP80syw0kLkRsLlOw3+q4lQ5E2yTtW2VqBD0LUkmx3lPA?=
 =?us-ascii?Q?tjhhVrwFJpR31sziMXmUf2XXyMgTq4qMGvuEqqeo18pZ4bUjOibrfHEyI7RK?=
 =?us-ascii?Q?Si+T478R20dum2kTuotFV1PclSVe6uzplRb0AB+Tp9bQ0vvJ7sGIwPpFV6aG?=
 =?us-ascii?Q?snNa5b4o4OOlde7yvvQb5l8W2p/38RJ6LhVg8EmgI37esKi71PMwKpUzci8+?=
 =?us-ascii?Q?j4cfAcIPfYu9j1Y2ahwGZpbII39rcjSHySvWAvZ9ukUoXPq2SZkVeoCu2GFl?=
 =?us-ascii?Q?R/es+0VA/Yi7+Ds108/smXkOefLwcT9Lwl0Zu9jevMRO4X0cG79pb+skHQzS?=
 =?us-ascii?Q?AcK1fpmensJYWJ5WitQ4BWwzqhW6unwuSQqlvTTdfUOivPZGTRfKBKS9I88X?=
 =?us-ascii?Q?RgR7Hp3EjvAXhNfFGQmdQSU4Xp8l6sT+9LuF+WkavVLvoCqulzo5+gBdpBV4?=
 =?us-ascii?Q?ZxJM1m11e96gjCCXPyPkseD4zZf60jgFJs9sN+ZpsgjAe9LlQxtPQ8wL68B3?=
 =?us-ascii?Q?f8Qz7B7jR48U+rXOzbI1uyrovu1Y/AuGbGXNzVEMRfDxMK2lgodjnsEe7qUT?=
 =?us-ascii?Q?4vd/f7pWENH5GzQSB7nCozoZ+bAQ3ph3W49l7ZyeOKC/7d51iDf8QH1YY8Vb?=
 =?us-ascii?Q?icbdKclAJgNvrntISIzTe/0+AVeyW6aoMksPU8ThVoLpFg2ariQmlCAuq/y0?=
 =?us-ascii?Q?aovQZLHTqt0aUJ4O7tXxbGInCq0F/sqhUdVq01RBMBAbbecMWASU//CMf2Jd?=
 =?us-ascii?Q?yRCI2Ozv0amp6xk2Ru1WLZQAJlR0+klRMOmukmvkuCp4Xmqxm7FTmNqjbLol?=
 =?us-ascii?Q?rHoCCA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afc0e4e-431d-4b5d-a27b-08ddf9dbf759
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 13:28:50.1680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHciIuHbovv4pDCocV23t7hNxAavCek2bjdCtqKvKEDaenK0CL0QHiw38v7U0/3BCqaSWxxx53evSawMm5kfZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9467

On Mon, Sep 22, 2025 at 02:33:01PM +0200, Horatiu Vultur wrote:
> Thanks for the advice.
> What about to make the PHY_ID_VSC8572 and PHY_ID_VSC8574 to use
> vsc8584_probe() and then in this function just have this check:
> 
> ---
> if ((phydev->phy_id & 0xfffffff0) != PHY_ID_VSC8572 &&
>     (phydev->phy_id & 0xfffffff0) != PHY_ID_VSC8574) {
> 	if ((phydev->phy_id & MSCC_DEV_REV_MASK) != VSC8584_REVB) {
> 		dev_err(&phydev->mdio.dev, "Only VSC8584 revB is supported.\n");
> 		return -ENOTSUPP;
> 	}
> }

Personally, I think you are making the code harder to understand what
PHYs the test is referring to, and why it exists in the first place.

Ideally this test would have not existed. Instead of the open-coded
phy_id and phy_id_mask fields from the struct phy_driver array entries,
one could have used PHY_ID_MATCH_MODEL() for those entries where the
bits 3:0 of the PHY ID do not matter, and PHY_ID_MATCH_EXACT() where
they do. Instead of failing the probe, just not match the device with
this driver and let the system handle it some other way (Generic PHY).

I'm not sure if this is intended or not, but the combined effect of:
- commit a5afc1678044 ("net: phy: mscc: add support for VSC8584 PHY")
- commit 75a1ccfe6c72 ("mscc.c: Add support for additional VSC PHYs")

is that for VSC856X, VSC8575, VSC8582, VSC8584, the driver will only
probe on Rev B silicon, and fail otherwise. Initially, the revision test
was only there for VSC8584, and it transferred to the others by virtue
of reusing the same vsc8584_probe() function. I don't see signs that
this was 100% intentional. I say this because when probing e.g. on
VSC8575 revA, the kernel will print "Only VSC8584 revB is supported."
which looks more like an error than someone's actual intention.

By excluding VSC8574 and VSC8572 from the above revision test, it feels
like a double workaround rather than using the conventional PHY ID match
helpers as intended.

As a Microchip employee, maybe you have access to some info regarding
whether the limitations mentioned by Quentin Schulz for VSC8584 revA
are valid for all the other PHYs for which they are currently imposed.
What makes VSC8574/VSC8572 unlike the others in this regard?

It looks like the review comments to clean things up are getting bigger.
I'm not sure this is all adequate for 'net' any longer.
On the other hand, you said PTP never worked for VSC8574/VSC8572,
without any crash, it was just not enabled. Maybe this can all be
reconsidered as new functionality for net-next, and there we have more
space for shuffling things around?

