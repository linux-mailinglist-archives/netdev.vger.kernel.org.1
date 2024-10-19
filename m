Return-Path: <netdev+bounces-137214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 055139A4DC3
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 14:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C101C236FF
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 12:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EB31DFE0C;
	Sat, 19 Oct 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GoNAV21D"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29401E4A4;
	Sat, 19 Oct 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729340430; cv=fail; b=PhyHTntQZspA9JmTuhjSyhIjmaltRwBhAr64LotaCp6dHymUZ65SlYGhUo5nneNySw0uzRDA88/KwzNVUVw97unBGmX9niLmGGT39JkUjdv5CfwVyRzFoQttCNOI+QIeTg/WP+AoRV06koibd1/KdCG0r1zOsVHsqemzPkcjjDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729340430; c=relaxed/simple;
	bh=VCxofkK6MurZIhe959JDL0r7Jyxq40P1cPH8vqzrnWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MCjlQXClSeDBm+yo9LHc6ryQSTUpQKr69vLCZtrn4P05sMAr7eCAcAyG5lNueRuASQ33Dli2rFYii2koEp0IreqpuV43rcEDVEujTA+Mi4vNaABIsm+6otYZeeOWyB8NH8KdZLW338+u3YtjNZ5Lvr/TJbZ1RvPVWHeoX9HVMD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GoNAV21D; arc=fail smtp.client-ip=40.107.105.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yc2CQOsJ7eNXa57ST+mfKzMj1WXsA6bMNkpSEfr4Vz1Y7xY4UXsrz9PygFg9GqNdroiOrqlN1S+O7PpFRmEnpTYehng+luckCH6T9SaIIh7nWi6wD6Qj0u06jkcAf29sNimbMIJJx7H9T5OYJ3MloDLjczWTjVVvv/gmbYk86aMx6JeLDe4jb/AZv+lvhC1DKwWLE4jYbQk/yS5xpLxoBB9jsYCWmB2g4OLsT3DWdHWhDA0+bimmMTQKJYQ5HulMCcFhPRNkUrmrixoE2928YW8JkVmRP46hhiXnpzid1GrGYBLamJLxk2T/AR/2dHAXrxGoaKuemCxtBeEf/n6hAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtYDDEewgwV+PqBMr2pCo5VQpTkxX6hT3xgw7wNkuts=;
 b=SQwbSmZ8+uvk70g9TlIbwkUe+2zD8rbhTOu16iz0KwmTpBVO3+HPBIi/K9DQyWd9nRtfABQm7V0ET5JBzo6Z/ntBfxaxojNs/ZqYy95fSFwsWvxXMed/XQwBoUrRaJPMuigbwR3ezmWdyB9qHd5y0UBjydcCdJ/uULx1tATejrlxvwTHzsTVh6drhobR90R7/QLptGlsIrDy+e835w6EhWMu5/XLSOrtlVqmZLMs2fDzsqqLktl0a54VYeSmp1dgtFzVmPxf2OHqaM+ibOZNnuBkTx8zW5MG5VTsgH32SUU4FaVSgNJQrd4wyWB4mEzsE/N1oai8ZEVVRIEPtiN/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtYDDEewgwV+PqBMr2pCo5VQpTkxX6hT3xgw7wNkuts=;
 b=GoNAV21D6VZra5mVG/64scfSTRyhKrFuwx7U0f98D0FtbJNGErAGMtmhuSxSH1KKAv1GU0uvDAJvtgM24JZGj+UjDrhI0sFNWZgnRzsvO3mHCtIryxXXYb4DZ6P5ggpuhFV34qQE0XXl4DbYkkq9TgPumTt+EUhbzLOs+PrhbAftYO7YCXXbDrUT/WTV1Qbc1qwKkulF8UgEbLRRc2zT0F0UPScumm7GHpCIciXHavwzM8Cyu209TnQAdTbsPjE39/hwMD0L7s2/cafU1Ux55q+XXwKtKOfUwhZMEJCs6EwNTxzE1wLAXRS9N/fBHB3VDMdCIg2yyq2t1VDhPpB/BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Sat, 19 Oct
 2024 12:20:23 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8069.024; Sat, 19 Oct 2024
 12:20:21 +0000
Date: Sat, 19 Oct 2024 15:20:18 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/8] lib: packing: add pack_fields() and
 unpack_fields()
Message-ID: <20241019122018.rvlqgf2ri6q4znlr@skbuf>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-3-d9b1f7500740@intel.com>
 <601668d5-2ed2-4471-9c4f-c16912dd59a5@intel.com>
 <20241016134030.mzglrc245gh257mg@skbuf>
 <CO1PR11MB5089220BBAF882B14F4B70DBD6462@CO1PR11MB5089.namprd11.prod.outlook.com>
 <e961b5f2-74fe-497b-9472-f1cdda232f3b@intel.com>
Content-Type: multipart/mixed; boundary="euj3bym2fbv3pbxs"
Content-Disposition: inline
In-Reply-To: <e961b5f2-74fe-497b-9472-f1cdda232f3b@intel.com>
X-ClientProxiedBy: VI1PR09CA0097.eurprd09.prod.outlook.com
 (2603:10a6:803:78::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 9551b520-67b6-442f-27aa-08dcf0386693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oedTHWxIuCCyGWxNRbwiFVWWav48JaFS5cJdM6GlcaNmV6h9X3fcZNR8juK9?=
 =?us-ascii?Q?Qk6oTLLH6h7jye01+FRktYAdjadWVql5X8wbFEoEYhLheo+YfjQYU1prN22Q?=
 =?us-ascii?Q?7L+F+waW4bv+m2IaJsxP+x/UGaLK/v+DdRTGd7002HdswECAoXwMsC5OhOyV?=
 =?us-ascii?Q?FwjDcyHrneo+Tn9PczoTr3EMDmiYKSB9B3Mk5e1e1Tug4VqJKxrQub19c7zT?=
 =?us-ascii?Q?DJxgjZbGtHEagHiAF3Bqp2gU+YWyeQlOknMj7HvIOJxyKL6zl0vCL1U1KaOu?=
 =?us-ascii?Q?GJTGMCB0x1riijKo3UxFqxyoU8FQPxb9YAupBt8wLy4o2+lp2qYvM83zc0Is?=
 =?us-ascii?Q?ajYF1wFQH4Ba3igyE399GyT4AUjLYnZrQNV49R3kbf/ZmaAscu87k9p9WRi8?=
 =?us-ascii?Q?+CrymduC7kpqz0O++cdQOSJHGIlckTooCoJLQLC8NUfX007jCgACc2o1wrKx?=
 =?us-ascii?Q?dP0aGFRdzF5c5AIwI9xdq9VOo2ibY1+G8yHxJaLkza6YKHfoUm3yTkO6BQ33?=
 =?us-ascii?Q?U8q145N4O4Egxacab9znM82txaBrEk2UqtcSNBsL/1S0rc4dedua89XtKGQj?=
 =?us-ascii?Q?diDsrosc6XZudD/soCxWY0fLtOGoPwTSAEMf34+iuzMDRcBoi8V+bp5ICpxb?=
 =?us-ascii?Q?9Mcwjbc+Iy1deT++bqJUdhA/RMKvxk5hN8M8wmwrwsEVDPMxqlDnsVpfShk0?=
 =?us-ascii?Q?fQAXTSc/AHlFeCRbpylvlJcFIox8T8qt/9rTAz3kuAimkmESPOnL6ASaKGiu?=
 =?us-ascii?Q?XciAwdgyKhwA42XF5fkjsTXYaorUtGyTHkiTB3fr/d09TYjLve3kOa8jQLnK?=
 =?us-ascii?Q?62n5X1nC0cfKRsz9sxd7BEjnGn85ktLeohvIkTvBWTPGMn3E/R9jFa6Zc2Ov?=
 =?us-ascii?Q?JxSFnCukTHfxJo5QiW/RmZq8y5L8/9f/eQqDi/y2x5DKM3Oaw+6cJO4vtyVx?=
 =?us-ascii?Q?DOlklbQWJJbGz/naDiVmcrwAm4hVbOe9yrnyzQV9snXlbwBieTDD29SWLKdz?=
 =?us-ascii?Q?EJI5+nZW2Irkp7mgOysqLcdtV+MRJ548aZoSYzmBL/NcUfqIAY222oJw0/2v?=
 =?us-ascii?Q?k69xjUyIsFfCNkgTXyKbhpvoluWro3QO1gWYTw/G+kVk7DW7ZNeIwX0luM2c?=
 =?us-ascii?Q?PERyL0wp1rLVB8qw/bzJTEZHpr91XpPQndwCDrhTPvH46CSK9299mwPM8E5Q?=
 =?us-ascii?Q?GqD+kWnLt6lGANGCggZemVepoTvyOITff1Z63N0A8kH4/GAvSNe3bAXTUaiY?=
 =?us-ascii?Q?UuRH85S9IFcIB1PxZlRjoVfkhnslaNTFyomxrjPWLEqMeZbeWKQInszQIIhV?=
 =?us-ascii?Q?hCXVZ1+onnYktzdzsMlGt1mu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wakCTEaDh55mG2Gz8U1nDhLKwiHE7/xGimdj5GDTzGb049GuhE3DoRJ4NAym?=
 =?us-ascii?Q?BDx4/c6nb9w5d2HmucVClW51NgfKw2XV3ihzm8JZWVkpuLbOtwrHa0W7ZAxz?=
 =?us-ascii?Q?faJyb7SPl2KHcKV/PANzw0Mv0mAg8P4dblbayy7S+lVpX+OnIuVmMaSkpLfW?=
 =?us-ascii?Q?TQ2NAJY6POxmvBBhWj7BVfDX2oQLtNXMvq+AGID49h1XYVAZ9h6W0+YQg0WA?=
 =?us-ascii?Q?sNf8qzKgyPp53CL1cqnYGmqv+i2Z6lhND5Bd5o6C8K843TYN+rPSkgrsX877?=
 =?us-ascii?Q?9NhESMdGRRenrzFt97yf8mZ7yv+96iVuqd0sD4krA2MOrGiTudo3t+K2AqvK?=
 =?us-ascii?Q?TCRg1JA7bn9/AIfL+mFWwz60AYIl21vGSspG/SS9gOghWPlF6Dt8wzGn7VPY?=
 =?us-ascii?Q?0dz8ce3iZFBvDyqGhOIaf7s18JcmcdWjiHEt1WgO3LjZMQxsmMjfeWKZO+UG?=
 =?us-ascii?Q?K/OS3pST2SiSrB0R2dS8zxRYdACcappw7vOjmC80C44DYQDCAMK85vhtsHrL?=
 =?us-ascii?Q?YUHrlH99TkFkSHdF9S/bF6JvRrjgSegsO+aRNbarrFDqmGELJh4H05GX3PUr?=
 =?us-ascii?Q?4+8/h6EDlciuQDj6Kc4aQnWlw0Tj/bkhzrFdwKTjnOAn0pkhyEONV9ssVIzl?=
 =?us-ascii?Q?nDkhvBeW6rFZ/4+5O4xNkd0Qm0RKrcVdhKhFvIuKIHG//25BIf8ZrXKhw/Hy?=
 =?us-ascii?Q?3bsLrb/zOq39H/QNJ+fxvs8aOq+oye/FeIKUy4Jh61KoCFvM+SDQBgJkDH8H?=
 =?us-ascii?Q?hNuDLJkH9Hz2xuPaLL+G+gpUI64YBx4pPxE8W4kDFvLckMRGtHtH+1Lowbtt?=
 =?us-ascii?Q?isqPc5vW+MAtSr3NO8NgAxr5qM8V3acQw33TWzNlaLsRnM255viMIy7p5IjG?=
 =?us-ascii?Q?L3X37sMsVuXskmMwIHr+e3ufasdgPLULER7H0XLKl45bkXMIGQlFRmCEmikw?=
 =?us-ascii?Q?BUtj8qG6qC0fv6jXQZmtpsncUnveNwFVBRUtWpZXpNmD/a/njLF6pCwLv9pk?=
 =?us-ascii?Q?dVBCYV/saagbI7N/XOjo2Dw67eHYG6ZApWCr40cNOSZLFdraaD+beEsILV4V?=
 =?us-ascii?Q?4NU3gps9d0HT13aKQdgO2Bg5HDTKH3WZj3WhzrNmhlmI2mKrPFWpdc/isyg3?=
 =?us-ascii?Q?XN2KAUl2qydmifcNJshUsbsVaZYvuDgC5bsw2zNcxNY9VOMmXZAXkXuPQzRF?=
 =?us-ascii?Q?XOwuOcJ4eYc7b6dydx4gWO2nqb+cyzblsWygG5tBQKEh9GqRBxcDItzenRq2?=
 =?us-ascii?Q?OqzBe2peFHGy/7MSATRxN6xduEtzk/sedQSxFDQEZbk8KnrTRzdykeqov9bT?=
 =?us-ascii?Q?Cs3rXkfyEDo+AzVcitrRWuSF6bB496Im+egnB4droA6EwkOwLbxDc3jNmH0B?=
 =?us-ascii?Q?QPi6QU6PguX1ZcNy70XrzI6NqUpXkj6uO5zCcJe/SYsbgq92gMjkyu4Lv/jW?=
 =?us-ascii?Q?AH6x9Dh2MZHzNrUnDT5UuzQmlMwDFNDgtPufih5TXldPf7i8K6zyZyZX8wBr?=
 =?us-ascii?Q?jhSUu6G0Uv/XrJiFxoeJML9Js4nFFlCXrSvYnKOdH24m6iQm0/M8iMc1FqJw?=
 =?us-ascii?Q?3uvyUdHMFHeMAEW+Ky8OYgDCsAMunZrRhnOLfRVLTkNEiIRzM8Yj0SKiKMO0?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9551b520-67b6-442f-27aa-08dcf0386693
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 12:20:21.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WY5Vsqh4lWd0x04fFGlE/0ZRiGjrCMyiX0wvknTK4I/rxOpcKRHbgz2VIMP1zTy+gXf15xgyxGsFIKq/XAZO1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8951

--euj3bym2fbv3pbxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2024 at 02:50:52PM -0700, Jacob Keller wrote:
> Przemek, Vladimir,
> 
> What are your thoughts on the next steps here. Do we need to go back to
> the drawing board for how to handle these static checks?
> 
> Do we try to reduce the size somewhat, or try to come up with a
> completely different approach to handling this? Do we revert back to
> run-time checks? Investigate some alternative for static checking that
> doesn't have this limitation requiring thousands of lines of macro?
> 
> I'd like to figure out what to do next.

Please see the attached patch for an idea on how to reduce the size
of <include/generated/packing-checks.h>, in a way that should be
satisfactory for both ice and sja1105, as well as future users.

--euj3bym2fbv3pbxs
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-lib-packing-conditionally-generate-packing-checks-ba.patch"

From f5321d0a6201827127eddce51ccd69639bc133b1 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sat, 19 Oct 2024 15:11:37 +0300
Subject: [PATCH] lib: packing: conditionally generate packing checks based on
 Kconfig options

Przemek Kitszel complained that the size of the
<include/generated/packing-checks.h> file is large (2 MB).

There is divergence between the ice driver needing only checks for
arrays of 20 and 27 fields, and sja1105 driver needing checks for arrays
up to 40 fields.

Since each driver knows which array sizes it needs (it open-codes those
sizes when calling CHECK_PACKED_FIELDS_N()), introduce selectable bool
options in Kconfig to generate those corresponding checks on demand,
rather than generating them all from 1 to 50.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 Kbuild                             | 155 +++++++++++++
 drivers/net/ethernet/intel/Kconfig |   2 +
 include/linux/packing.h            |   4 +
 lib/Kconfig                        | 361 ++++++++++++++++++++++++++++-
 lib/gen_packing_checks.c           | 166 ++++++++++++-
 5 files changed, 685 insertions(+), 3 deletions(-)

diff --git a/Kbuild b/Kbuild
index 35a8b78b72d9..1a4d31b3eb6c 100644
--- a/Kbuild
+++ b/Kbuild
@@ -34,8 +34,161 @@ arch/$(SRCARCH)/kernel/asm-offsets.s: $(timeconst-file) $(bounds-file)
 $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
 	$(call filechk,offsets,__ASM_OFFSETS_H__)
 
+ifdef CONFIG_PACKING_CHECK_FIELDS
+
 # Generate packing-checks.h
 
+ifdef CONFIG_PACKING_CHECK_FIELDS_1
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_1
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_2
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_2
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_3
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_3
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_4
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_4
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_5
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_5
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_6
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_6
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_7
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_7
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_8
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_8
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_9
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_9
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_10
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_10
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_11
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_11
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_12
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_12
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_13
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_13
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_14
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_14
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_15
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_15
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_16
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_16
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_17
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_17
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_18
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_18
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_19
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_19
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_20
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_20
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_21
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_21
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_22
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_22
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_23
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_23
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_24
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_24
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_25
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_25
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_26
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_26
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_27
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_27
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_28
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_28
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_29
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_29
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_30
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_30
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_31
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_31
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_32
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_32
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_33
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_33
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_34
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_34
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_35
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_35
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_36
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_36
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_37
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_37
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_38
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_38
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_39
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_39
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_40
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_40
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_41
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_41
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_42
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_42
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_43
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_43
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_44
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_44
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_45
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_45
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_46
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_46
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_47
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_47
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_48
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_48
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_49
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_49
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_50
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_50
+endif
+
 hostprogs += lib/gen_packing_checks
 
 packing-checks := include/generated/packing-checks.h
@@ -45,6 +198,8 @@ filechk_gen_packing_checks = lib/gen_packing_checks
 $(packing-checks): lib/gen_packing_checks FORCE
 	$(call filechk,gen_packing_checks)
 
+endif
+
 # Check for missing system calls
 
 quiet_cmd_syscalls = CALL    $<
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 24ec9a4f1ffa..c4ea8ae65a95 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -293,6 +293,8 @@ config ICE
 	select LIBIE
 	select NET_DEVLINK
 	select PACKING
+	select PACKING_CHECK_FIELDS_20
+	select PACKING_CHECK_FIELDS_27
 	select PLDMFW
 	select DPLL
 	help
diff --git a/include/linux/packing.h b/include/linux/packing.h
index eeb23d90e5e0..31afee8344a5 100644
--- a/include/linux/packing.h
+++ b/include/linux/packing.h
@@ -54,6 +54,8 @@ struct packed_field_m {
 		sizeof_field(struct_name, struct_field), \
 	}
 
+#if IS_ENABLED(CONFIG_PACKING_CHECK_FIELDS)
+
 #define CHECK_PACKED_FIELD(field, pbuflen) \
 	({ typeof(field) __f = (field); typeof(pbuflen) __len = (pbuflen); \
 	BUILD_BUG_ON(__f.startbit < __f.endbit); \
@@ -67,6 +69,8 @@ struct packed_field_m {
 
 #include <generated/packing-checks.h>
 
+#endif
+
 void pack_fields_s(void *pbuf, size_t pbuflen, const void *ustruct,
 		   const struct packed_field_s *fields, size_t num_fields,
 		   u8 quirks);
diff --git a/lib/Kconfig b/lib/Kconfig
index 50d85f38b569..68b440d622f6 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -40,9 +40,11 @@ config PACKING
 
 	  When in doubt, say N.
 
+if PACKING
+
 config PACKING_KUNIT_TEST
 	tristate "KUnit tests for packing library" if !KUNIT_ALL_TESTS
-	depends on PACKING && KUNIT
+	depends on KUNIT
 	default KUNIT_ALL_TESTS
 	help
 	  This builds KUnit tests for the packing library.
@@ -52,6 +54,363 @@ config PACKING_KUNIT_TEST
 
 	  When in doubt, say N.
 
+config PACKING_CHECK_FIELDS
+	bool
+	help
+	  This option generates the <include/generated/packing-checks.h> file.
+
+config PACKING_CHECK_FIELDS_1
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 1 element.
+
+config PACKING_CHECK_FIELDS_2
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 2 elements.
+
+config PACKING_CHECK_FIELDS_3
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 3 elements.
+
+config PACKING_CHECK_FIELDS_4
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 4 elements.
+
+config PACKING_CHECK_FIELDS_5
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 5 elements.
+
+config PACKING_CHECK_FIELDS_6
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 6 elements.
+
+config PACKING_CHECK_FIELDS_7
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 7 elements.
+
+config PACKING_CHECK_FIELDS_8
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 8 elements.
+
+config PACKING_CHECK_FIELDS_9
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 9 elements.
+
+config PACKING_CHECK_FIELDS_10
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 10 elements.
+
+config PACKING_CHECK_FIELDS_11
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 11 elements.
+
+config PACKING_CHECK_FIELDS_12
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 12 elements.
+
+config PACKING_CHECK_FIELDS_13
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 13 elements.
+
+config PACKING_CHECK_FIELDS_14
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 14 elements.
+
+config PACKING_CHECK_FIELDS_15
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 15 elements.
+
+config PACKING_CHECK_FIELDS_16
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 16 elements.
+
+config PACKING_CHECK_FIELDS_17
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 17 elements.
+
+config PACKING_CHECK_FIELDS_18
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 18 elements.
+
+config PACKING_CHECK_FIELDS_19
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 19 elements.
+
+config PACKING_CHECK_FIELDS_20
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 20 elements.
+
+config PACKING_CHECK_FIELDS_21
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 21 elements.
+
+config PACKING_CHECK_FIELDS_22
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 22 elements.
+
+config PACKING_CHECK_FIELDS_23
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 23 elements.
+
+config PACKING_CHECK_FIELDS_24
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 24 elements.
+
+config PACKING_CHECK_FIELDS_25
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 25 elements.
+
+config PACKING_CHECK_FIELDS_26
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 26 elements.
+
+config PACKING_CHECK_FIELDS_27
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 27 elements.
+
+config PACKING_CHECK_FIELDS_28
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 28 elements.
+
+config PACKING_CHECK_FIELDS_29
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 29 elements.
+
+config PACKING_CHECK_FIELDS_30
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 30 elements.
+
+config PACKING_CHECK_FIELDS_31
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 31 elements.
+
+config PACKING_CHECK_FIELDS_32
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 32 elements.
+
+config PACKING_CHECK_FIELDS_33
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 33 elements.
+
+config PACKING_CHECK_FIELDS_34
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 34 elements.
+
+config PACKING_CHECK_FIELDS_35
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 35 elements.
+
+config PACKING_CHECK_FIELDS_36
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 36 elements.
+
+config PACKING_CHECK_FIELDS_37
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 37 elements.
+
+config PACKING_CHECK_FIELDS_38
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 38 elements.
+
+config PACKING_CHECK_FIELDS_39
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 39 elements.
+
+config PACKING_CHECK_FIELDS_40
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 40 elements.
+
+config PACKING_CHECK_FIELDS_41
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 41 elements.
+
+config PACKING_CHECK_FIELDS_42
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 42 elements.
+
+config PACKING_CHECK_FIELDS_43
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 43 elements.
+
+config PACKING_CHECK_FIELDS_44
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 44 elements.
+
+config PACKING_CHECK_FIELDS_45
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 45 elements.
+
+config PACKING_CHECK_FIELDS_46
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 46 elements.
+
+config PACKING_CHECK_FIELDS_47
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 47 elements.
+
+config PACKING_CHECK_FIELDS_48
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 48 elements.
+
+config PACKING_CHECK_FIELDS_49
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 49 elements.
+
+config PACKING_CHECK_FIELDS_50
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 50 elements.
+
+endif # PACKING
+
 config BITREVERSE
 	tristate
 
diff --git a/lib/gen_packing_checks.c b/lib/gen_packing_checks.c
index 3213c858c2fe..5ff346a190c0 100644
--- a/lib/gen_packing_checks.c
+++ b/lib/gen_packing_checks.c
@@ -1,25 +1,187 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
 #include <stdio.h>
 
+static bool generate_checks[51];
+
+static void parse_defines(void)
+{
+#ifdef PACKING_CHECK_FIELDS_1
+	generate_checks[1] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_2
+	generate_checks[2] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_3
+	generate_checks[3] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_4
+	generate_checks[4] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_5
+	generate_checks[5] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_6
+	generate_checks[6] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_7
+	generate_checks[7] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_8
+	generate_checks[8] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_9
+	generate_checks[9] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_10
+	generate_checks[10] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_11
+	generate_checks[11] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_12
+	generate_checks[12] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_13
+	generate_checks[13] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_14
+	generate_checks[14] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_15
+	generate_checks[15] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_16
+	generate_checks[16] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_17
+	generate_checks[17] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_18
+	generate_checks[18] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_19
+	generate_checks[19] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_20
+	generate_checks[20] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_21
+	generate_checks[21] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_22
+	generate_checks[22] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_23
+	generate_checks[23] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_24
+	generate_checks[24] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_25
+	generate_checks[25] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_26
+	generate_checks[26] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_27
+	generate_checks[27] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_28
+	generate_checks[28] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_29
+	generate_checks[29] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_30
+	generate_checks[30] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_31
+	generate_checks[31] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_32
+	generate_checks[32] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_33
+	generate_checks[33] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_34
+	generate_checks[34] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_35
+	generate_checks[35] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_36
+	generate_checks[36] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_37
+	generate_checks[37] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_38
+	generate_checks[38] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_39
+	generate_checks[39] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_40
+	generate_checks[40] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_41
+	generate_checks[41] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_42
+	generate_checks[42] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_43
+	generate_checks[43] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_44
+	generate_checks[44] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_45
+	generate_checks[45] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_46
+	generate_checks[46] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_47
+	generate_checks[47] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_48
+	generate_checks[48] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_49
+	generate_checks[49] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_50
+	generate_checks[50] = true;
+#endif
+}
+
 int main(int argc, char **argv)
 {
+	parse_defines();
+
 	printf("/* Automatically generated - do not edit */\n\n");
 	printf("#ifndef GENERATED_PACKING_CHECKS_H\n");
 	printf("#define GENERATED_PACKING_CHECKS_H\n\n");
 
 	for (int i = 1; i <= 50; i++) {
+		if (!generate_checks[i])
+			continue;
+
 		printf("#define CHECK_PACKED_FIELDS_%d(fields, pbuflen) \\\n", i);
 		printf("\t({ typeof(&(fields)[0]) _f = (fields); typeof(pbuflen) _len = (pbuflen); \\\n");
 		printf("\tBUILD_BUG_ON(ARRAY_SIZE(fields) != %d); \\\n", i);
 		for (int j = 0; j < i; j++) {
-			int final = (i == 1);
+			bool final = (i == 1);
 
 			printf("\tCHECK_PACKED_FIELD(_f[%d], _len);%s\n",
 			       j, final ? " })\n" : " \\");
 		}
 		for (int j = 1; j < i; j++) {
 			for (int k = 0; k < j; k++) {
-				int final = (j == i - 1) && (k == j - 1);
+				bool final = (j == i - 1) && (k == j - 1);
 
 				printf("\tCHECK_PACKED_FIELD_OVERLAP(_f[%d], _f[%d]);%s\n",
 				       k, j, final ? " })\n" : " \\");
-- 
2.43.0


--euj3bym2fbv3pbxs--

