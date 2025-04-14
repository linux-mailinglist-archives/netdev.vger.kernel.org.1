Return-Path: <netdev+bounces-182281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B6A8870D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867731885EC2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BD8252287;
	Mon, 14 Apr 2025 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QuJ+61nM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C202472B6;
	Mon, 14 Apr 2025 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643272; cv=fail; b=f5ufcbyOHX4L6pf4DtuTqP+9EMxGWdoY39ue60wdtS/39Dh+id76dgjtFPsPwTrynXbD7mjhqOcDQfSsgb4OpQL3kgdyS3oVNj4F2wl3slEA6OWZg5i0gNrqiXZTHdLPwpW+PqPnaaxHUcTzNa5GyKABSPr4KqY/Ihced8L4ckE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643272; c=relaxed/simple;
	bh=jpynZLnE1qFxh1R+UFTPnVi3wX3AbrS4zGChFw7ivTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bu4/qepjVP1/l+KW5AiTN5KvIAqDawdqh67VYCafoiGrlegWIqX3Nj0Nq1Fz83gQ9a3VTBQ8gwAf2r/Nd+6z34JJRabWvejPyht6BUR/uFhXV73b/3geVGs2mklWkaj8A0w1BsH6BLLkn/boqOaJMzf7341+lMbsGuyTjWEuuFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QuJ+61nM; arc=fail smtp.client-ip=40.107.105.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlYD888G9SMLTY8ElqFE9j2Ro51Dwoh456//5kaQK5t6yhzOS+rKBmPzVVQLE9QgD4HPzcuGbjd9085I7DTRfCEXVppaHiUKSyOc6ZRLth8cb9qzZHrN18LVoPwsuui4tSVzi8VvOZNcCnIKv8n71V0IUV5XDlX05wqmOsvBg0YguqdzpiAc3BkCBJeSY5kqTjg6407zyGnGGGPr5CaQR3XBacwIn3qImBs5vVubCjpD/RLa5O3mo6pkZtRbJB9YdMB/3zAIOVp5SD6bcuyWGB0uiD7gv6O35IWyO9i4FDULG/mvgHJuw5SOYi4BVHlT2FofdAAc0dSJZdJYmkvRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFUdnbV+cPftXvmTy7hF3OZbVhAtFLVoIyhkHWnaFf0=;
 b=Hn1rFciORKczwZNEMfCojv9+6Nve5WkMO0FCmIROAqG1ayBOZcRyPz1SC3xchaz4XKFa57YionXucCYnz/V5t7Yf1/Pr2U2JRLe0d4lzSAcRap0NHq2pCpZ2M/lhQifdW6yNERAjyxPc9mA/+QRG3dd5c0I6Q7R9R4/e69zzXdAX1W3anRydfCdVkhbC6zoVbdpXL8DPnA/HaAHRAQwhmgybySekV7k9IXykQfQjOQNHxZT8aC3OAtQlFHiCeqTU1JZ8XN2mGveJ+bcNXFSeG1kagVWJzLPi+CGmLBNT6zlDb6FWnYvAQkUNUgICp4oOb6VfLE1MBIwYg/gbjDNBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFUdnbV+cPftXvmTy7hF3OZbVhAtFLVoIyhkHWnaFf0=;
 b=QuJ+61nMSziQSFv6CeyVMzsdefbZ6Jf6I9LOcwRd1QO6ZB+51/AukVAH7ORZxqVIXyYfLqtTpqFMm6BDmyLl36lgsraGp3JbCtQdE5opIvLl2WMDIhCU9WvCBiNccR/bQTuHEF0boroYvijZUkk7BfISvKLZDUtLF+uW9z3xfJMAAmUFp2pfhlIlpxJCUkV2BTOC+UuIdoMzlC6K9REzRm4IJg+pxStSeVkdLZN4S5sQRp88bmOC4UDJ+Te/6TieQBcvvEmASbnhD62lfXtTvXtJFVypks38dsmUMdC9eaTypzCqLkSmIfRZDqf+i2x+DgZCY2xWOdJjDMFq0CtGZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10816.eurprd04.prod.outlook.com (2603:10a6:10:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 15:07:47 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 15:07:46 +0000
Date: Mon, 14 Apr 2025 18:07:43 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net 2/2] net: dsa: propagate brentry flag changes
Message-ID: <20250414150743.zku6yhs7x3sthn55@skbuf>
References: <20250412122428.108029-3-jonas.gorski@gmail.com>
 <20250414124930.j435ccohw3lna4ig@skbuf>
 <20250414125248.55kdsbjfllz4jjed@skbuf>
 <CAOiHx==VEbdn3ULHXf5FEBaNAxzyoHTqJEMYYtcQzjkj__RoLg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx==VEbdn3ULHXf5FEBaNAxzyoHTqJEMYYtcQzjkj__RoLg@mail.gmail.com>
X-ClientProxiedBy: VI1PR06CA0106.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::35) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10816:EE_
X-MS-Office365-Filtering-Correlation-Id: fb227407-64d6-4df6-52ce-08dd7b661d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WizD0dN7rblgBxzplFB1R1nieFLc+cZOFmic6EP71aJVTBf52GPU32q63DiX?=
 =?us-ascii?Q?gudI1NkRCxkq7JfhJ708i21a7wAgkOMQWe8McvzSqXkRe2oOklLqjj5kHRK2?=
 =?us-ascii?Q?vgDc9MlzVem/tVlWm+vJKtT0smkWk1t6uwWw/vkzJO2bi5yg8IcA5h98RfZX?=
 =?us-ascii?Q?07+7LrSaG6+AuBtXqQuU4K/UTCxB/L+wsRzJ/j1LCd435d7QPrMorNQcy6BC?=
 =?us-ascii?Q?pr58Rc1KWdCP40xBCDLcr3mXFmcJsDG2jJk/+P6J8QVuOZenW+ZRSYAszlfN?=
 =?us-ascii?Q?IHJTNM1hB0Sw0KoORmfvHwV6LqyOJLf7dV1HA7B21QHZD2wdh+20KbL1hRiE?=
 =?us-ascii?Q?aNc8VPatVNfQ+tvR8ZKMOy4cG30yR/LDdcc4tRq4BqK0f9MuKBu2e1flZR5N?=
 =?us-ascii?Q?RQI93yMLGzglQ7OcSRwp6JOpe+isLr8eUrsUjcAlp0n1sNz/yLud7JUBawHQ?=
 =?us-ascii?Q?+qimjLoSvbShnb+O8Pt01nGNCzOOlmNaRAv35dU7BIGQiKTcgYlZsg9IJjPJ?=
 =?us-ascii?Q?gDORQPh6UnB6dScfZqgoo56gjwIiMpOAw7m4rsgFGAd8Q1+t7yMzjXB4KcCX?=
 =?us-ascii?Q?tDjWxW/fVGfOSNdW90XDx5SBJILghFX2dcSrQflIbP5JkAmzU0B6Efr4dvYk?=
 =?us-ascii?Q?iF6+9dWvAbwK3ySTO2G2jIXK8b0nqM1Z1Y69gYUoXlOwA6fLahBKqcH/Qzlw?=
 =?us-ascii?Q?qZc++YNjGB/DCjThJDL/j1dO75QJUbrJ+JC3Abdxp3zlRTlDgMWCSVYliVVm?=
 =?us-ascii?Q?a7Iss0f1chLjtdcH2mNmtPrmJ4hXix/wEUmNm6xlvHPFEjY2EljjFNnkGMEC?=
 =?us-ascii?Q?Bcbdk/LCCVSuxQCHYe7G639jcDZGZETY1qcnPnNccXmKN/nJws1Vow4sB5B6?=
 =?us-ascii?Q?82JhdwRLevlLK56c79FKlFnwMb7m6JPnXAVdpif314mBdw24PqoIpQJG49cS?=
 =?us-ascii?Q?c1dI4+8KFxamMRfhZ4IvbqMr3rD06CCba1/WbkMkfWtN+JsSjQxlWaqcQLXi?=
 =?us-ascii?Q?kn8AkvHxRF4FHAIf5kpUoHTAaBSz+jTO+ddhG9p6+gowMIbOm+VoWIZd/lCn?=
 =?us-ascii?Q?eUc4Jkwdwe3HPlPBEJo7bP8pTV4IFxR2NkgYO4dFBvsG0aS9B7gG8dEgAJCG?=
 =?us-ascii?Q?UnYrUC7LYK/fwrA+gHhzEdll2DteWvF3ogjSKffjevjzavnyuKpVqI/P3wMz?=
 =?us-ascii?Q?iVfDZGjOcrcaR9RXQ3Y3mFOpSizAHVyMVBeeyd653TQgv4+lJxshs7zrjtj+?=
 =?us-ascii?Q?Rt6olXqabXnRTX294QeYBhl4/1kcKEsU/4h+KHc+kGLwrnS6aJ9alcNk/rMK?=
 =?us-ascii?Q?3iYznLOh+vyWpP159sNbxbyrNqxm1QAfygfMmwiswpr0xQtpyJ78jwgQcigX?=
 =?us-ascii?Q?bw9Fg9smkFzCMBRil0wBSHOrGyBmSvn/TDLmNHSj6CChn9FugD9duQRuLPJa?=
 =?us-ascii?Q?tYQspJlzSFQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pfY6kGeysanYKsiZ3vtVvF4ve3E2zYg4Iwi1tBPkJE0G1WMTT6KsKJD4+Iwp?=
 =?us-ascii?Q?Re41BckrGeV3hi0lg6dVEVG9LvSqmuX8SiuaP038bJEFlUQc9QnNG4RawSDY?=
 =?us-ascii?Q?CapG6GJ3HbWrk2YtRp+KdUjtWjUWLRB1+OwUlUHah9HbDKsisAGVInaz10aa?=
 =?us-ascii?Q?ayP4rv5V6pnuXgmotWs8xghXe/zRYY3M+xMNr6S99ArNzC82CDXwbhOcX4D2?=
 =?us-ascii?Q?X4j14dI8K1YaEbjHoo9dejp4LTyenfipVx5JliBfiXOr/3r6aSVIyrgEPOfM?=
 =?us-ascii?Q?9dhr+y7L7No95IiX/1GTS2n6jspVPTJfilBdjzyTLyBeeT1+1aSdNiLVccBr?=
 =?us-ascii?Q?/07CUQV6+RCwf4SCdyQcHQiUVxBAQl4sC9QFnfch4AAgSTsf99hQy/eAp/GX?=
 =?us-ascii?Q?kQspMbd6QGKIFUP/CZ5PZBkW/0bJSuKZvL2SRR4jR9agDISgcn6xMgMCvUG7?=
 =?us-ascii?Q?6U62hVT7D7etSg5VvpFcBWaNZhWno78umHnsy7OBjhj1nMHuiDm0u10K4dlh?=
 =?us-ascii?Q?M3yOG4qutxEa8hcSMctstSFFf1DPEHByV2XbQAGHZVn2ZsRKidx8/gkPUBhR?=
 =?us-ascii?Q?YGL1VwkI9GLW6zMXnnPyw4L1Q+HFNKBQ4I8/F02or9k+d654AkTngOS7SSSx?=
 =?us-ascii?Q?FSSTFNzczlcctn359YGXdY6Bb7tRPkwVUXsmGLZoMD3w1CzTnD1prl7+z5AM?=
 =?us-ascii?Q?3OpU3j3f5tE0cSfcgdmtpfA+fziDOPKXLetOC8/6b2h8jsDPdMtQ9nz3HOhr?=
 =?us-ascii?Q?egDJleO3pV12O88puYcSMeFn1Hh2+ruBe/Cp2a2v3RoSHj7Dv24WcKfOsXh1?=
 =?us-ascii?Q?YvCGVuWcYSoNrRB+WAq2cq6MKvLP+s5QsasmxIM0EEwZYa22inCEWK1Vo8ZG?=
 =?us-ascii?Q?AlvSsFyAPFJq5zqlr3D4amCK1ERe0yJn5Z2a8GAcNc5x8S7/kbifbkHjnTZR?=
 =?us-ascii?Q?eOy5pK74WVcJz4S8+BnCmcn1Ahp/VJ3x+8k8YWmCS5oZBPYRnCGDU+yInL6N?=
 =?us-ascii?Q?RkNGv0/NhY5dGuLGO2jjaFtwmgUILLpVknuMvNIF2ExvRkq+nKy681K2I9pI?=
 =?us-ascii?Q?xKFC67BNih5TdcBDxyX2RKcyOtHJdKGv08ILZCtYjcNyhkVYc4EEqgcL7d2t?=
 =?us-ascii?Q?h6I407Ve9IQYO8w/fAvoj0HRbdjOrg8+RvERaPLst1ERz6hbMWVbl4R/+vx4?=
 =?us-ascii?Q?Hk97PWRkIM7eL1dXVHCI4s0x/C9x0vE/+v+Sofz49uLsr1ke+HUIpauKX+Ka?=
 =?us-ascii?Q?aMmgNwuVTmUHcf3gh/ovVYavvHU0OMBnaYGYlsHADci6gBHcBxLOnCmGWAsm?=
 =?us-ascii?Q?S4l4owWz00qPIrSR268Q+jMIva3Zl1K6OCyvFAThiUh17XifW14ZQocsKuLm?=
 =?us-ascii?Q?xLRiTjkn3RBqo+GqCElDg1dMmImvlBhww0ZJMYG3yqTaAqhPPqMhimBLPZ2f?=
 =?us-ascii?Q?IZduQ/B7eYV5f/aD/WHM4V4YY2qDcTA5fI8QOqbBKpJY/lNWG/TD1nzb9qk0?=
 =?us-ascii?Q?Qf/EJ63pu1D/k0ONtjDBhkkKmBvRSt1eSALKg1skKTbRyDlmcPq0qcN2dVuw?=
 =?us-ascii?Q?kEAO5KRwMehVzFJxoxs4gFOmNnT8oYflRY8i6gUfUvGYFLN37odzmuxO+efw?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb227407-64d6-4df6-52ce-08dd7b661d4e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:07:46.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+Icf4PASv26iqelnBKYzNnDUyCNp/spDajozxGjbCAFlN+HaHXT7U0w1AywsI1elTz8cmN5EHWejYVjbSOz6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10816

On Mon, Apr 14, 2025 at 03:49:27PM +0200, Jonas Gorski wrote:
> I was just in the progress of writing down some thoughts myself I had
> while thinking about this.
> 
> So to me passing on the original flags but then no updates of these
> flags feels wrong. I would expect them to be either never passed on,
> or always sync it (and let the driver choose to handle or ignore
> them).

Maybe, but right now it seems like the wrong problem to tackle, and it
is probably so for every driver for which the VLAN information in the
receive traffic depends on the bridge VLAN configuration, and is not
statically configured by the driver.

> Having the cpu port as egress untagged I can easily find one case
> where this breaks stuff (at least with b53):
> 
> With lan1, lan2 being dsa ports of the same switch:
> 
> # bridge with lan1
> $ ip link add swbridge type bridge vlan_filtering 1
> $ ip link set lan1 master swbridge
> $ bridge vlan add dev swbridge vid 10 self pvid untagged
> 
> # lan2 stand alone
> $ ip link add lan2.10 link lan2 type vlan id 10
> 
> as then lan2.10 would never receive any packets, as the VLAN 10
> packets received by the CPU ports never carry any vlan tags.
> 
> The core issue here is that b53 switches do not provide any way of
> knowing the original tagged state of received packets, as the dsa
> header has no field for that (bcm56* switches do, but these are a
> different beast).

I see, and indeed, this is yet another angle. The flags of the host
bridge VLAN do not match with the flags of the flags of the RX filtering
VLAN, the latter having this comment: "This API only allows programming
tagged, non-PVID VIDs". The update of flags would not be propagated to
the driver, neither with your patch nor without it, because VID=10
already exists on the CPU port, and this isn't a "changed" VLAN (because
it is an artificial switchdev event emitted by DSA, unbeknownst to the
bridge). So DSA would still decide to bump the refcount rather than
notify the driver.

You'd have to ask yourself how do you even expect DSA to react and sort
this out, between the bridge direction wanting the VLAN untagged and the
8021q direction wanting it tagged.

> I guess the proper fix for b53 is probably to always have a vlan tag
> on the cpu port (except for the special vlan 0 for untagged traffic on
> ports with no PVID), and enable untag_vlan_aware_bridge_pvid.

What's the story with the ports with no PVID, and VID 0?
In Documentation/networking/switchdev.rst, it is said that VLAN
filtering bridge ports should drop untagged and VID 0 tagged RX packets
when there is no pvid.

> To continue the stream of consciousness, it probably does not make
> sense to pass on the untagged flag for the bridge/cpu port, because it
> will affect all ports of the switch, regardless of them being member
> of the bridge.

Though it needs to be said, usually standalone ports are VLAN-unaware,
thus, the VLAN ID on RX from their direction is a discardable quantity.

b53 is one of the special drivers, for setting ds->vlan_filtering_is_global = true.
That makes standalone ports become VLAN filtering even when not under a
bridge, and is what ultimately causes DSA to program RX filtering VLANs
to hardware in the first place. Normally, 8021q uppers aren't programmed
to hardware - see the comments above dsa_user_manage_vlan_filtering().

> Looking through drivers in net/drivers/dsa, I don't see
> anyone checking if egress untag is applied to the cpu port, so I
> wonder if not most, maybe even all (dsa) switch drivers have the same
> issue and would actually need to keep the cpu port always tagged.

What check do you expect to see exactly? Many drivers treat VLANs on the
CPU port in special ways, sja1105, felix/ocelot, mv88e6xxx, mt7530, ksz8, maybe others.
Some of them are subtle and not easy to spot, because they are not from
the .port_vlan_add() call path (like felix_update_tag_8021q_rx_rule()).

> And looking through the tag_* handlers, only ocelot looks like it may
> have the information available whether a packet was originally tagged
> or not, so would also need to have untag_vlan_aware_bridge_pvid enabled.

ocelot can select between 2 different tagging protocols, "ocelot" (which
leaves the VLAN header unmodified) and "ocelot-8021q" (which does not),
and the latter indeed does set untag_vlan_aware_bridge_pvid. It's an
option from which more than one driver could benefit, though, for sure.

mv88e6xxx uses MV88E6XXX_G1_VTU_DATA_MEMBER_TAG_UNMODIFIED which
provides essentially that information, neither "tag" nor "untag", but
"keep".

> Makes the think the cpu port always tagged should be the default
> behavior. It's easy to strip a vlan tag that shouldn't be there, but
> hard to add one that's missing, especially since in contrast to PVID
> you can have more than one vlan as egress untagged.

I agree and I would like to see b53 converge towards that. But changing
the default by unsetting this flag in DSA could be a breaking change, we
should be careful, and definitely only consider that for net-next.

b53 already sets a form (the deprecated form) of ds->untag_bridge_pvid,
someone with hardware should compare its behavior to the issues
documented in dsa_software_untag_vlan_unaware_bridge(), and, if
necessary, transition it to ds->untag_vlan_aware_bridge_pvid or perhaps
something else.

There is a relevant selftest at tools/testing/selftests/net/forwarding/local_termination.sh
which captures many (though not all) gotchas, it might be interesting to
run it.

