Return-Path: <netdev+bounces-131656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D3298F278
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F78280E69
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C15E19F410;
	Thu,  3 Oct 2024 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MZJWIXmn"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2059.outbound.protection.outlook.com [40.107.103.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4119CC3C
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969032; cv=fail; b=hUZRVxWmEr7Bo87Uzo3XsNXE2apzYYwvRHiuWYNrFxbWCMf1DiSp/o465ajOGPK0/LCdHyo/FrO8BH4JIDLoXcNt+ger279Bc8WwEZhXkbzvkmsaOyiayswoKLjRuwXBKsxtl5Ft0juuTDeNvQEt0yZ1im76j1ojrDfMUtm9FT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969032; c=relaxed/simple;
	bh=UbGJ2SoUzwb1IHqBsVahACSc0IEqqNMNaDf61eIWRnE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uUL984/3utiwT6JKDJtk1bZcI6daRsbOg7sYiXjzDFTPC0u+zECtbpiopdOdrV5JcwRp+Q6IDvMiDMQVjsiQRfEDC5mze+huN8vVbgumQA27dIFRBK/3PN4BpLYHktbnDCGyojSAD3znsqnjm3PaHyooqT7W5q3YT4sdpRfgXXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MZJWIXmn; arc=fail smtp.client-ip=40.107.103.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjvPdyZjkup+sGVVuI5x6/h4j7NS3wcY9FKSRLSZ4C8hg12MLgdqQgvDsVBEC2unmMKp8/mgOkG74B02rkEBwb+j2jM+YPjmLpPRX3MRUq0VtSxcI9QP663YJPCFDL9m3nO9jn9KameWftRa9BqPftJOG1ZBFkHNM96QeutWGq/m91M4rHO/4yOFOJRh1yd2C8lAKKhqglWZra2JZ1PhFGJt0nfxyYImAnGG+MEYqxXuI+z46sPiIbChU8Kp5mIaD3t1G8YHkgW8NEFFB+gFblnoRS0Pk9zv6lk1R2YV/dxwbC563APPoiqVlsWlPJU2mbssnYiXCHoC0RbJpjBMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGsB3ezrkoSm9dLqD1Zp2ViqerbS586PIWqidMmxCXo=;
 b=SOabGPRhKwn6g1TplY7rpl/2iqELkWrC9IJcUQHoWym68ZJRqBwkqjMuvOg0PctH/XvVOVkEGiFe6tOYwASeiJQ+ZHYPY5mvh5kl6Tn8wJKTISx9dDxgM0sU4M9QBdfNbFfsvuBW8OGIhQC/QFzbWRE3KSv6WIwwapO2KNALR1BC6ohT2N8jNiTAAJrDK5EdrnYQopFv9DmAJTxG0Y+nsQLJDqiS0XP3vZ6KL09prtt5cWJZs4GqJvgK+xixWKg85j5ixrAysuKZP8BGeHT+DldkFPskjQ48xZfNvaP7ZaWAGQjTGbnkOZNl4x83TFG8rmO/tKRlkcf0Aifj0sa3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGsB3ezrkoSm9dLqD1Zp2ViqerbS586PIWqidMmxCXo=;
 b=MZJWIXmnxqF3laqx/a0djogmGqnu3LSZr8+UTzpe9tQG84bOtuS8jiho/91NelhLF4JFxAAg5O6AaTzqggeY3DI6aiWF44UHfm+OlsGTkpoVZTiGMCvyfMoRn1epl07DxoAJiVnqPzoulqKcU5u5GMlzYc65mKI3BPHhCdyVrSMTgipRqp2AdJZTX4XEVQVKO/GUlJjQJNT6R8qH1Hn98uL3kHTNE9Bgpus66cKHvRI67vsVgeaaz9qN1j3Hxm6XOJhClNJTSBoI4xrFBzv5lbZDyKG6GKNd4lzsw3AuhCH4hBVB6L0jV9SKehe/hmxpdSYeQswOAxNk4LHo/HJpdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10152.eurprd04.prod.outlook.com (2603:10a6:150:1bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 15:23:45 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Thu, 3 Oct 2024
 15:23:45 +0000
Date: Thu, 3 Oct 2024 18:23:42 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 09/10] lib: packing: use BITS_PER_BYTE
 instead of 8
Message-ID: <20241003152342.uebujs4aqe3ouojv@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-9-8373e551eae3@intel.com>
X-ClientProxiedBy: VI1P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10152:EE_
X-MS-Office365-Filtering-Correlation-Id: db9f9beb-33ad-4c96-5f89-08dce3bf5f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uzPF5W2/pL8L0GtgfL/ZvGwJNbeK0nNefh1D13qcMqgs5FwnKSqJK1EQ89ho?=
 =?us-ascii?Q?1XfJKbQfRh232KBQNWfD6iYJK5G3V870jv6DXOPFxebEc/ORdUnL6AhTPgZ/?=
 =?us-ascii?Q?quK7vb5wN42X80EvAP6e8iFOThXGJ9IBjsECyEX0WTLhaGD6bshD+Y7WL3AN?=
 =?us-ascii?Q?0yRsXAIz72tkEgSyKkAK/zJmYskXwgfM9zHF8TpHIB/kGUaePjxDE0HZsd+P?=
 =?us-ascii?Q?Wi9w0uNtpLbX0agWvVj3OmWEZkxZN3TPO1f1/8l8GZFZB1ME5HCJuezN3MMp?=
 =?us-ascii?Q?29fs33Y/VH7wvWvNTUW6n1vWWoqe3QoMgvcFjnthtXG2cNPmd+wr8nBchxjE?=
 =?us-ascii?Q?PSsL9coRt0RQXSzXfXsmHYJXzKXezk2AfrroS/kOAoEId30btao5tKoVpyO9?=
 =?us-ascii?Q?/t6qrvIPFU5iTOdtUUdUCdYnovyioGkF0zHp/G97oPaCzPOmxEUQrEAPs4Om?=
 =?us-ascii?Q?m+1pvbngCxUKQlmHLkiWjriJJ3UkJq22o76n6fDJsOVJQXu2l6ihlwi/T9wi?=
 =?us-ascii?Q?R4o0Ru2EE5Oelz71vXp9BnfiKm12pxREilV1ekLXWeMwROMEP3RbP7c+ne75?=
 =?us-ascii?Q?ErJv0qyavl5nYN7C8rJnE60Hs2dZjR5KHy1Fd4Nhvqrlt99GuOOHGP3R57kP?=
 =?us-ascii?Q?hSMhfu18z6eiXuorYwzHuiFcI6jri+MVEELF5iCsTs7O0kAx3qJx8RWzylhM?=
 =?us-ascii?Q?/OfSLZcnamUAPDYH77u8YIc7Qf/jRR2CqQMMEtf258fkdzad40cqoFevZFQM?=
 =?us-ascii?Q?RquZJ02zM3DpIGvIZAUMQr3lVRmW5V6xPjoTK/L7NVvZdjV2s+tIlwvJq5Z3?=
 =?us-ascii?Q?u+2EyxCpkS1WzxAk0e6VWEicGF0nuea3fff5ZhFMap8UgTfgr2z76A32i0qk?=
 =?us-ascii?Q?Yn7+JnKM9k8wja5StV38Lnk9g5E5KucOANezJFeiCldJbeh1N8/nIGRJl47I?=
 =?us-ascii?Q?3UalGdZXf4kkbv+huh8VHxahiuy/dYo46pnr6HNUkKmHz2/DkijcY9JFpSep?=
 =?us-ascii?Q?Iy8BP1BjXqAzS2o3laYwz8W24eJGftyYMv2hCZibjtBToQfcq29ZxDCdqx+R?=
 =?us-ascii?Q?KJh9a/3GcWuv+IRDtCf2a4+VqUxLRXIpmgZ12wOZBp8iLsOWZPL4KsqJvAgT?=
 =?us-ascii?Q?ICc7deOFcYaZmL0l+n4LtYdKJCj/cq+9gSahzemjOFwSnYeoY2E9Gg9nhfjq?=
 =?us-ascii?Q?J5KP4Mu5H3XrgSgAica7fdWayyGg0+82txdkolzxR7glFJRpc7AC4g9om68R?=
 =?us-ascii?Q?UydjJl+CsIwkCoincuNOeRt+jt8+cRvMkX9DXgI9Mw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XrFZpP9c+LI0LVbeIFJg/8/6zvUP3YV72d/Lia6+6yt85l84gZP19II3IPgo?=
 =?us-ascii?Q?yrH2YzfFStE3nfJ+z90VuiHAJl2HBrzCb+mDSBW9M234ZbPxfEjtcb5vUVNu?=
 =?us-ascii?Q?WzCXPNHuoI2xSxFLjJAHvhGY6eTAFNPA7JjBVhBjjnmlATzK2elUL3KT+Szf?=
 =?us-ascii?Q?b6Dt9T9lMW99vpvkRpU6gQS34FCa80+e8SnvsQ/ERGi8FCYQd4JudLE8lsR8?=
 =?us-ascii?Q?1TWzstCrku/h8z2J2Z0xIYP7rIMuYbCNoI5RursfbkRskqDYSmZBkilPmBVj?=
 =?us-ascii?Q?SGDrv+vtHWoTxys51b2zOekesMQ/XAO0Ov53QdZfQauawkRJRZjMfabZYqj3?=
 =?us-ascii?Q?qAo63twz57lP+mIYZvQJYmCJVWkWGJ2Oc/e0F4oBC/wDtwWhj6WC4BaOMePZ?=
 =?us-ascii?Q?tqJeVfDJTF+pIOAseRDOdscYtAlPTpsWhPnoyO53e6BXEEZS18TcqgQ6IzFi?=
 =?us-ascii?Q?9dSt276Vo8J5mG4b+YQAcqEHQP8ESzYCrDpMEH4dnD6gwZ2Gqnw+l1/Jeg8b?=
 =?us-ascii?Q?vtq+Qqgc9o9rAwsbwrsFyj+CCsdrJBXpSHtCMbgrxO2rK22Y5PVPsGJIyTNW?=
 =?us-ascii?Q?qeUM5janZMc85RrGx8Z6DEwhU9yCnQz2eLCfKGZsVdJG1RkKdXWt44MYNGPT?=
 =?us-ascii?Q?D6uutpMYrRf8srfs1dMKtfJZHXFnOJLdtOoupuP6374RiPd65h1AKlBtRQ73?=
 =?us-ascii?Q?iQqnFouz9bzPDwwhHdpmS/pj//Cgs6bkUL1UMwPnCIlPp3CzJM0yS7b9pNeB?=
 =?us-ascii?Q?iczDRt93zUpS4SkvSul3Vu++gvkOiYZBUc29iqnceM66rCLYSyCxYJth4r5W?=
 =?us-ascii?Q?O164bgV6DaIHvREip8vYSYVboYdr/S16xVVg6No3DyB/1ZkWBAfpElRFF6+G?=
 =?us-ascii?Q?YpZWYx0/gS5eTpgqG7EfNluDlTxW1HRT8/i3oJZ07yQdp+p3O9B5X7QWxW3+?=
 =?us-ascii?Q?L4ircz+IQj6nry2I5WadqnREH9Ugxw8gEQqXnt1ED/rEtjUn4niKWgiyp4ww?=
 =?us-ascii?Q?SxOXka4R9Lfu2u5Ypg7/U+tWS289aL6Sruf4A537RONn7fyaQeW2LPgrKYgU?=
 =?us-ascii?Q?LXR++WeggUHyOgiWgD6Dxx9RoCZCMV8yHrylz97EqJmtcsDICD8jNVF5+PRY?=
 =?us-ascii?Q?bg/yL1aPlM/4rUclr+Oj8Z/WF+/FPUQovH/Nwduv2Sres27osGYqOktXvMhG?=
 =?us-ascii?Q?d/FLwvBPH/B+asrrE9F0tCcqnPeBZIka8gwVIPop3SFaQVxhlaOfdpQbLB3x?=
 =?us-ascii?Q?PIcPbpHLupYfstHBYTAkN/jsFoIDVcOnx9PfYSxIRvgL2RZSqBlHt2A4SNPx?=
 =?us-ascii?Q?Bmewwyvh3K5xkDebKCaFbokG/ZzYAy1MHeRfM1eek2DNfzzmE+N7AnncF4SV?=
 =?us-ascii?Q?t1BxwAx1sYphfjgoG6+PVqN5W1PNqDa04K09l6bjMdc/7+B0RNy/cPDouT70?=
 =?us-ascii?Q?8Vq/FqROePmWOvNujmk/gqcW97P4Gj+nswa7rDk2kPAjFoKTABTUemPGxy0K?=
 =?us-ascii?Q?1CnoLh7raQBbn0J+VOgq8XbmKTkKm7Gy522zxnCB3Qf//K3w7NpgzGheCBR4?=
 =?us-ascii?Q?lrrqaTMSJ3mJzEqCTT/aArUGi3WY8ORqF0KTFBgZD33ts9CJ9xA9UTdw12Wo?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9f9beb-33ad-4c96-5f89-08dce3bf5f2c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:23:45.5900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCJIgYSlPmsImH8b4NvOSXbTDEv84JEo6qGuCSFwWh34+zY2LlmplSbXBPPUAWhRHtNiMlTW/+Qt4S1/tl4PQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10152

On Wed, Oct 02, 2024 at 02:51:58PM -0700, Jacob Keller wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> This helps clarify what the 8 is for.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

