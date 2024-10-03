Return-Path: <netdev+bounces-131646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7615998F212
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2CFEB209BF
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCC919F42F;
	Thu,  3 Oct 2024 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ws6JYVyZ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E33823C3
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967919; cv=fail; b=CWyqKAraJxTwJvokiQm5SRge492NyqbEKGs0t+ipwh5nKw2n+3vZbXXxQ0IpnhpJdgF/0AHMzihZPNfz4k62+4OAVZ/XsVmZRgTGngWU/JFtODxq2BsqGJtesHEHNlxIAmEJoYYVNnQAeMZfflyPHhLXJfUf8zGGNBIMN2m2i6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967919; c=relaxed/simple;
	bh=H3syXaabhGK01piNOdH1FVCnd9GGQZF5Gfns7OElY34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MwiIxMIlduUfZTHp2QVJIsJeQFkYXXCHrybKua14nhRtRS3/POBKe4e5HQVmE+en0AzmxpFwPgRn8IFopNkCRsov+HJGx3SdNlMqAkoNRBhYQwropz/hvRQjSPQNgbZpLB8hL3TB3+SVrE+cDkFW26uZ6h7AI/+JxCQOv0WQnb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ws6JYVyZ; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDQFgTcKsBIB+WEv4dtbbTlim7Fe+pOxFgoDwB+Eluspd/GRLphsXAipEJK6J8nEtjJivB4Hcsyook7gcuNW+LrgPH7QnTnpHW4YLl0p51QzfEE93Y3ZbgKiJcnxzOGrabqPx+NJjawS65N/1lR6g+f7WXTHbVeTDjB46YFTwE8s0BEp5KEu0qwFVtxBG49ZFDBME64mvPzFvTVniu4YsTJKBmUoPXd8Rfay9LUaN5uKI33hrjkytAkvUqpRNFJrzuJ58R3yRtYfpTXl6tSvdfL/Jkyubo5aQ+4Gz/F0ZPTJeF6XKGQm9l+jx29ciGQFAZaMsoBaRJgrY0P6tWcMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDDECnrWUJvQtp1C7g1Rpy79SmGogGeQV/F6ZhAU2hM=;
 b=d8kygqFtQ0+UNkHOWo3cJ3nSc0Pj7FmRNBZeU6gpl1Q97NAaWuQu2AMjvu02xDrvmKC6cf9BD0JusW6QZyMweIwYV/ZlLy61nNTKDuGaYMrZn/P86Wkm0hA3n2KdIymC4BFVtN+Wq/08Oi5KZ4AI3TvumULif+r51gqeC0yvAr2gFTI2EfeUPLgYFkNHApaKzDgV5LkfOFIMBIVfJ17wCF3B0hV7U1dX4majFdJ5z9jF4smfGqbpccyED2SJL2UJx7wx20VrwI9ilgr0x3HGghaUAc/TBnnXiYaBB0jRXrzYviPJL4we5nLqw8+CQa1OBXn0vC/ugDFFPxTITi2JVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDDECnrWUJvQtp1C7g1Rpy79SmGogGeQV/F6ZhAU2hM=;
 b=Ws6JYVyZKZ2enQafkDo8yIVGdGLSRl/DhZjfM9gGaUb2nK2F0RZ5J4QRxX2nV94D6RMlcEKnxR4ac4f/oJdvBrJwglfzuRgT1+D3ByR1RVCcE0VtyQQ+FRAExUGIfKe7/YU5r+w+OUa7wtGEe6nq9R3oV30tEvqAAkWK3GPwbH1pEKta6S9N3ThabuJzXTnfDahVfDPOu2j2vB999H7WdsYmhHBFuthNruMUzwklNKuNu1MHvLhO7k7d5LzANcRYnV7KWS59iVMfOAs1fDAW7D4gNl18glp/jovdxeDg6VKJMBNZpen4w/I/FZTDPEnHNT8J5e6JlpQUS1trXUqYCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7456.eurprd04.prod.outlook.com (2603:10a6:800:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 3 Oct
 2024 15:05:13 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Thu, 3 Oct 2024
 15:05:13 +0000
Date: Thu, 3 Oct 2024 18:05:10 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 02/10] lib: packing: adjust definitions and
 implementation for arbitrary buffer lengths
Message-ID: <20241003150510.w2yhj5ox2tnqdjst@skbuf>
References: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-2-8373e551eae3@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-2-8373e551eae3@intel.com>
X-ClientProxiedBy: VI1PR0202CA0029.eurprd02.prod.outlook.com
 (2603:10a6:803:14::42) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c217fb-e6a4-4d45-e8cd-08dce3bcc86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IDZKzTsfPa3a7mS/TLf6kV6Sy3Z+fls00yFiECewFoeIUEhnq1MzOd2H2RPj?=
 =?us-ascii?Q?i1OWs7JkxvkXyVNxTSDSzjyZBL8SoRpD7Uj3CLvl5B74Bv/9VFrCjbonH1bl?=
 =?us-ascii?Q?IASxSBpyHfG5XssLbXGGMWViz2GkzfdD+HKUmrGNcxNPDRfYGjBL630ePx11?=
 =?us-ascii?Q?0XB549fd0F29xDmvE2Et+zi6UCPAqc40FHc9rD6PkMVyf5QxtBp30foJFSdk?=
 =?us-ascii?Q?NVSvn8M2YQCV++XYeesrocOnH+OqItysQA7HF2Kc5ttBBGykFm10e7Tl4ljk?=
 =?us-ascii?Q?sJe/aBgi7BaiPBSPGeMc+dje1bRIDI74StDurg0tjS75S1u4IpIZ8FWu59Cz?=
 =?us-ascii?Q?NaN8wEAJ2xh4+rq+9YDZ4aNtbcI/sBTImsaVqtDaky/hvCjzkTrGzMGNMwAd?=
 =?us-ascii?Q?9zZ3GSw73tFkhfU59+KmrUH7W3JHVTU8YAGChMGgC+a3wgx0NnmqMQQ/o5Ma?=
 =?us-ascii?Q?sNuj48eAIkEmE7zj4iGybQ4wQ9S3pUE9mP5Tl3KfDfzr7/2z2pULjzftQbGs?=
 =?us-ascii?Q?sTovRV8pism5Dlh9UZE5ozDZm9SnErJJNwdZAYg+15JyB3Z3Ng5RlguojGSc?=
 =?us-ascii?Q?TPOEPbp4XZFnV6iXXYwtOMhKc/aqdI+K3EFin6TwLqa0QB9Bcer53qAPQVnn?=
 =?us-ascii?Q?B9pVnOqEOHO8XM71duSwZefqH7/nNTSMdFGS7kwdcnGXJW7pRpHpYpG1nRG5?=
 =?us-ascii?Q?wXJGIxPNtGY97x2tbKULrJCEEGGFbl3ZdwoGjLzot6dBXQTCatjMoL0ule5w?=
 =?us-ascii?Q?Ce3IRX5SL6D2IjbqfhurAqhKMaq7uKnzY/ufvspSiD6t4kjmsEizIJNp4azC?=
 =?us-ascii?Q?0ETG+5u7u5Bfozi7PPfmEnH+VtZV57d+1UoaFw1trzFOpXMhr8+sQLk1LMNB?=
 =?us-ascii?Q?trIC0dNVsqtKXvTNoBxuEL9vf68UyqQVJvXTsxQZCT+YSobyBc6Fco1Gb4dm?=
 =?us-ascii?Q?I0iWH3Fusbq6pLIeWA9lVqZwHrgHk4WNwlXlKKz+CPNK/g4PJyyaBiEqnizK?=
 =?us-ascii?Q?6yWF6l4Zonebel1ZiEIq572UrYPOLPsj2YoFtsI5UPbKSkwwKoZ56Krb8H3f?=
 =?us-ascii?Q?za9yX+YfS889pjlkri8LhlgtyVd30UR7eaQNV2X16+rCTzky24DJBCogRL+m?=
 =?us-ascii?Q?ptJ7eZ/90w2HGAI2TQT3qnohyjvw+ZK/Mhtt+idoTpNpI54Gt+dwCTAJZo/z?=
 =?us-ascii?Q?/6ifhNnUKSZP4nUqOm1PUXieR7y9ZeJi7Os1EkEvxJYVML30rPLtUewlA1v+?=
 =?us-ascii?Q?biCfqhYpoETxetUi+sk35ExLX8NgpyNaJOYNvX7y7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wcfETrB/zP4Vf0DEj63hiXs1zYn1UM8KeOoEawFMvhxeN4g7fzoXm7rT5Atb?=
 =?us-ascii?Q?4C9vT83Aed+x3wRJFj5w67fjQ0XdD28Xlphgn20bit456yhbp/Milxqj00P8?=
 =?us-ascii?Q?v7wnVVQxYg5yLgdZLT5UhAAeccCtM3UtYG7Yjm4HIvXNhrXivyj6lm0Hcfnn?=
 =?us-ascii?Q?5zWHIG472PiVaIZJ+iHCYGIKbQmX02QWn/EmtecYfq0OpfSgsOZyer8mvAk+?=
 =?us-ascii?Q?5uSJ2+RFvUbhsvJ9ozNwOCs1Q8X0pH76/4E1P+hlTm+z2CzerP4OWIZw85nO?=
 =?us-ascii?Q?R+xDmcEVNH7uq8iWGj5G7crAaqj4rXSzYFDQKjDdPXdUYCo6V6IjUl2kW2dW?=
 =?us-ascii?Q?49IEiuP5saMHJdNu6aLpG/RFT7LssEaF2PZ70rtSW+nHui79ewHccjduqoTF?=
 =?us-ascii?Q?c5h/FOWZVMm3rojEyLYVLBZU1l1CToq3gvYIiD4UZ27PcEfdmRmSanMjIFye?=
 =?us-ascii?Q?uXThP6XusawV3/rlCmAbFmkzuWD8t66Z7jMdKbRHkjgbc6/DUSzU1NPhkGW9?=
 =?us-ascii?Q?hea+QXqHbMgchrdeEzLY4fXKmdIYMde0QcXtWlKys7Gy4SJaOb6yyWKa7u7L?=
 =?us-ascii?Q?JUXh7xFIKWbzSb1H2DgCu8zvhrAoev+bIw1hdw3Uw4PnXokUEsT2K9bs7yHV?=
 =?us-ascii?Q?IRxVtGt9AZJ8grD8ouhu/zPZSRG+L4PYHbT2XRaZG3k/WoYT3+v/+Gy3GJ9h?=
 =?us-ascii?Q?odn3RtbzD2KeZmlfUriD0NGAZMySxCkxqcqODK4LN8moxg/aqQjtVsXuJ7Nj?=
 =?us-ascii?Q?0MNcRTWCQ7lQVbNPmcDfR67eyGISezpuGioUUJGoXo9wGzcUxBWKIty4Z3hJ?=
 =?us-ascii?Q?tDR+z8DZgSyivxbH/jbPSt+ss4Aw4AHCe4DyFFNvOxM0xPwvYiqgY3YyAwx2?=
 =?us-ascii?Q?SRyncua9Rzem+KMatEWi07ivxBcIrpFODMGSiFJ+AR33jo71At+QYX4QIx1D?=
 =?us-ascii?Q?rwrtmJ0TNUaO0TAnPvo4Rsvy/CGFW2gtJkExlXyhX5gFpPk37hxB0WuHEH5m?=
 =?us-ascii?Q?VqNEydWm5YKFX49C2YnqHhv9gAYTr2nqa0RUBPaLCi9hfrrtSbUXKCRDZhPI?=
 =?us-ascii?Q?Ntd8OE2SxPCG+IdZFtp19eExkxeEqNoJfwQxnEVLWaWEq/0ZliXCtbSvF2MU?=
 =?us-ascii?Q?r7Evp6S2vwSjdEoMJI/LsVgvLJz+OJI9I38B770+2siyf68kj9SqdS6842wn?=
 =?us-ascii?Q?UqqX4louAXkrFoDYA8e6l+H5+NBZBTKgUjUdJBD5yxsNi0ei1PvmiupSiyhX?=
 =?us-ascii?Q?L+GeR95uazvAVe1h8nykcaJTSTH3hdgkkpzqe+otI687g5O5P7wm73K4WaT4?=
 =?us-ascii?Q?8nmE1TB1uCDSGhABPbsI9hFUts7oHdd9bi8qevgwSpBXaKxRJ2ve47cpVhtU?=
 =?us-ascii?Q?i/iQ2iodOTgWG6yWkmhl+uyf9eTn1ow3ybx0x9ocwBQBEisDolFQCVbjyQqb?=
 =?us-ascii?Q?0sqV00vnH/hSAUNWd0HDOdL/lkbowzAHw/2qNsIzX+0h0BW3adk3H02uIKBu?=
 =?us-ascii?Q?Kyb+ik04EINBhVQ04+UgEqkk81BENgjbnutGTsoLp3ktyCa1goyBksi8ElJQ?=
 =?us-ascii?Q?ftYNkisYW+4yUYeo9DoqO6tI3kSIybw7L/ahh0nPhre36x8ShKUy6K89/zMj?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c217fb-e6a4-4d45-e8cd-08dce3bcc86e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:05:13.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRJGgeFoTlK/kWSWSZB8+4e7m6vzuUCC/DqR1zZ05ED1/Ynt2Km5e64y1kE0K0kSwJpZt8pNbB2DsZujOPZ4MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7456

On Wed, Oct 02, 2024 at 02:51:51PM -0700, Jacob Keller wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Jacob Keller has a use case for packing() in the intel/ice networking
> driver, but it cannot be used as-is.
> 
> Simply put, the API quirks for LSW32_IS_FIRST and LITTLE_ENDIAN are
> naively implemented with the undocumented assumption that the buffer
> length must be a multiple of 4. All calculations of group offsets and
> offsets of bytes within groups assume that this is the case. But in the
> ice case, this does not hold true. For example, packing into a buffer
> of 22 bytes would yield wrong results, but pretending it was a 24 byte
> buffer would work.
> 
> Rather than requiring such hacks, and leaving a big question mark when
> it comes to discontinuities in the accessible bit fields of such buffer,
> we should extend the packing API to support this use case.
> 
> It turns out that we can keep the design in terms of groups of 4 bytes,
> but also make it work if the total length is not a multiple of 4.
> Just like before, imagine the buffer as a big number, and its most
> significant bytes (the ones that would make up to a multiple of 4) are
> missing. Thus, with a big endian (no quirks) interpretation of the
> buffer, those most significant bytes would be absent from the beginning
> of the buffer, and with a LSW32_IS_FIRST interpretation, they would be
> absent from the end of the buffer. The LITTLE_ENDIAN quirk, in the
> packing() API world, only affects byte ordering within groups of 4.
> Thus, it does not change which bytes are missing. Only the significance
> of the remaining bytes within the (smaller) group.
> 
> No change intended for buffer sizes which are multiples of 4. Tested
> with the sja1105 driver and with downstream unit tests.
> 
> Link: https://lore.kernel.org/netdev/a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

