Return-Path: <netdev+bounces-138863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB639AF3AE
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD2F1F21831
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 20:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC2E1531E2;
	Thu, 24 Oct 2024 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WQYKdn+7"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F922B64E;
	Thu, 24 Oct 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801855; cv=fail; b=LMz8PYKXX2W9SPRZDjhirJImrRqflU+anYFP/I/C1hEjZ+oG1BPwQ+0D+8ekekavEKm14ET7UIYj0rSIlikFU7PMN3tZud1B/UZqx44VgU/WU7ql9Wa8SC1wzWHg6SVgSUobZbhqywCclI4EDIwETkVctsmYn0X8epZaTPLV/D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801855; c=relaxed/simple;
	bh=XPg3tH7OGYiLcaJqfdvE4rJk8AldcRxns2+X+/xzq40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ideVhgb3mjnO0gxiGX08gqawFzZB4BTclwBMEqhUwE/gz6wODCdc8kW6S1CwoWdqniUem+nrbqlx1icXQ/d5uDsUn316wdJ/RjX6PVExS7E/ipFCoUkZEM1Z80bbEp7iH9IOXRxD/G17AvW5E9DusMX06h52RWDKP046j7EdMiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WQYKdn+7; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezjWaJgJGdGbqs5jLkcZiIaRCn4sybKHDZW13nf8vrn4TgrbNMoeZ6o+NPGsX0c3ONNbhJt67PD9nsOo6MFp+dChA2lz7VFFg//mSrbPIeanL1tnwSNVnkIKo0QIhzX56pdj8ZvTvP1kJb7EZhv3iye0k+hZeq9n43ZJUxJtrQg4GufkGrBtfxQmxrNbmdI5bvMvrpnFeoiOMWFAMskYve7b/oA4k4338+BTuq4GsbFs7VXyDzGg6YTRmUfTKoadhM2XHiMoBELpDHfqDFFuLh4a14TY7sIfIWxNC6Rny1+W6XNE3ZW+hU7uRGkCxVCUAYMQ9Jj1hpEsHTG41I0sYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6lzj2n8A905mfffWDxtHAIwZ+2cFawiMlJN4TD2pOI=;
 b=m0B5+btQVnJluaXx81dicREj7Qv0AIWKvz1eKAIQV1hyPqOnNqF1pch7BNFz0xrmhIJz/qxdfTbZWHCs+ASC3huYU0oHD5VcJxXK6YBRMLRLA6F+93JAIqj0510vvGjRf1Hh/J/WzBe6MkJKYP+YG6w9pHb4Bb9Wcm9SJcI9sHq9c6dZAGPQAdIeTmVdImHTREEFGX2LaBWIMcobr4eWqi1O0SLYcT/weRKsShV2eXswAEYWrBEbZn+Qdw8mq+jXCCof/BkDRtmh8bEc2WHiidO/wYEZBCJxDYb4UZxLRtk/lYRhcHHC+XoI6dJ/aR2ta3TqOhDAy87fyAOTBhtFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6lzj2n8A905mfffWDxtHAIwZ+2cFawiMlJN4TD2pOI=;
 b=WQYKdn+7IxCkR38bXiwWiDcinWgQ6HoVtmWe/uPnk1yYWegwYYSumBaw+dNUd8VWjsqmzx1m5QAmUiUHBIUPYkHiXe1jERbyCZmkKCjdOfnmmuyRisn/fcbMzS3qTj1rBW4U10Qn5dWTbFUQo8RFFj0pW1DMVn+WkVHsAUFmAX0/GF7f9GjTII0zkmvmVyd4fiO2U2wDPU7iRxRdNXEogPVmNcdTrscDiFhVFuFwEKKOF3PFtFEf4x/aXo3WzxMQ1sksBy1mVbXXruf7PP2jHQoc5mASLymDwMuRN7JvOAGdb0RBPnkVR6q0kAIYyUgPtS8sbp+Ey1A438SyrYiOEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8486.eurprd04.prod.outlook.com (2603:10a6:20b:419::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 24 Oct
 2024 20:30:49 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 20:30:49 +0000
Date: Thu, 24 Oct 2024 23:30:46 +0300
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
Message-ID: <20241024203046.dy5cpl4by4sgqlfa@skbuf>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-3-d9b1f7500740@intel.com>
 <601668d5-2ed2-4471-9c4f-c16912dd59a5@intel.com>
 <20241016134030.mzglrc245gh257mg@skbuf>
 <CO1PR11MB5089220BBAF882B14F4B70DBD6462@CO1PR11MB5089.namprd11.prod.outlook.com>
 <e961b5f2-74fe-497b-9472-f1cdda232f3b@intel.com>
 <20241019122018.rvlqgf2ri6q4znlr@skbuf>
 <7492148c-6edd-4400-8fa8-e30209cca168@intel.com>
 <20241024134902.xe7kd4t7yoy2i4xj@skbuf>
 <38f27382-3c6d-4677-9d59-4d08104f1131@intel.com>
 <80c591f0-ce17-4a58-9749-ed66f14ecc6c@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c591f0-ce17-4a58-9749-ed66f14ecc6c@intel.com>
X-ClientProxiedBy: VI1PR10CA0087.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: d2261098-f653-4517-ca98-08dcf46abf43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wcFYReHgIjkGrgt5cWUmK2VcvsEnpEtlZXYtLqXxsU+3lZ397WC1+0OekePl?=
 =?us-ascii?Q?n7ecVgNGxeDhgHeGa5XO+cpljgrVy6Yan/27wrftynK2cBR/xiTyhAyZic9J?=
 =?us-ascii?Q?EzWywSb0mwtq1BvZo68A4iNMZqkpbEP+FdRqqcF26KuBvVabRZuZvpvrt6wA?=
 =?us-ascii?Q?8SkX98RSO7PfSM6++Fg29ukFm9f9ltv+LkC8OXsAijIVZGSOSa+R7v8vywyu?=
 =?us-ascii?Q?P+yYNjsO6kGR7AtqO1oORt0+Br9lua3YMIq/13bCJSIUOcYhsI65081QLsrM?=
 =?us-ascii?Q?LveBiqavMcNdGZFIusjAzfIZMUqvFiuP8hcXdDYMTM921Bxz03hRwnKpH15w?=
 =?us-ascii?Q?+QC7l60C5vObzfisC8fa4b3lLrXtNyPDYRK9tG5AMnWzcLmJ/vQQTr9yC6q9?=
 =?us-ascii?Q?12Py5SJBMXTJjmS0GEozn3TgWtl4m8AnumJtUQ+uuwZs7/8qHTGQOXRAj7T7?=
 =?us-ascii?Q?FInObL6PouSSXwrTe8/GgBDityCg9gROTdEGZ1PFGKZJsT040gnjnS5ZLApV?=
 =?us-ascii?Q?rtlYfCBX3mZEw9UL70dCnW8BDyz+ixOEn+aPx67iQgXjR/MNSGILk58jm0Ye?=
 =?us-ascii?Q?rjZlnVnt9pNNd73uwXtwHjKX1UMtnYMcqM7zRctvuRMmEFJEbFKHcphHThWS?=
 =?us-ascii?Q?mnRGFCwYyntcxYG9YEOjlfaklpE8qYADz81jolMAnqR+aAqswPo3yU3Flh0X?=
 =?us-ascii?Q?W/1V6v8cbdr6BjsJ6Rbadm/8J/F8+lmAwpjMosMMmgUoX6ZJdTfPce2zDK5a?=
 =?us-ascii?Q?xPE8bC6I5NGGBoVXpqPmwkD8ky0Ugt6YhkuVHkMLLDub/nYAhyJ5O+kOrRJq?=
 =?us-ascii?Q?0dcxs9FWXZ+kPCSTEtv7miVSN6AFnZTTCWJu9vXtkHzIrEHtWlhnu+Dp0tpF?=
 =?us-ascii?Q?/X7ON63DVlMM7tv1s6GFhcSmUGWudRviGJHEJ/Zcbn/D5lfGbj2wY+RtEozG?=
 =?us-ascii?Q?ubWeBCaWIHSbFIf91XKko14si+gJg9Oj42ifVmYxJNRzFCBBAao2p6TxTN5q?=
 =?us-ascii?Q?2wZB08tAyAIADBuy8UThbVnazYXrNSZwpRvPPy+XBXRRiTZiuXdI2INkW3zR?=
 =?us-ascii?Q?MWlhXaHCt67WFoTtbkgJJyplp08O4JKXfCT8qWF2Wxuyjcbb8iyiAt/vJhGL?=
 =?us-ascii?Q?f8OhgtWGmMx2z35SxCt9fVDzJCaKjzaOHliJWD4OLSdST5XRbQWj6eT+Vu0/?=
 =?us-ascii?Q?dzDU7M+5/T/CwByy+E34D3CBQepylHzuUvOTcXnFf0tzPw2Gro0o3K1DRQMw?=
 =?us-ascii?Q?XqehviHT65NIFYDBtNy2cvN7RFfvt734vyRWEcJLkE0ofZkrBcHry289fqon?=
 =?us-ascii?Q?0OmJqylR7L0e7yylzfaBaT0y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tF74KKfJnPiukflYVq5Dug/z8nMmT692NVtTUcNntOd1/cgxCdNsArkxHcGe?=
 =?us-ascii?Q?MJuvfmIK/KR7NW6m3r8w6afyjfzO00vpz02SzoANfR/LKVQnNsYLb4jf4GdV?=
 =?us-ascii?Q?pu3Jmo4StRjRxp67VqWbuGkipH/tQwi87ZUjhKllRfG8ggPgCOCa5Gbd9zkJ?=
 =?us-ascii?Q?Lkm/g2DKU0HJqjmz2GHMPNVO2uLufdZmq3jbDa4lo04mg/b3q3WR5Y6KDMZL?=
 =?us-ascii?Q?kY46TRRVIDMdUFPCHSragAuYaw1ZQil1rtxtfA0yub2a3qygwsC/EJptQF84?=
 =?us-ascii?Q?kQ7if6bVKzLUzqGQGcFc0avisim+6q/T5k/CY+nXSbjHtfHmOUad5ITtt5z4?=
 =?us-ascii?Q?/BTCtGxuqVdBMoH5+cWDC6yj/swkcR2ibsDm7Boa38r6sMFVbaebV4gmpali?=
 =?us-ascii?Q?E3SpW/iRFhupLrQGrQu3TOaqB+SnFL3uuTS4gbKsdafvp2cqE1KurDc91XjO?=
 =?us-ascii?Q?Fa5YoFK/7easLF7KeZYL4dFLTdIs6tFQEHo4BGm4ApC2YVN7Lwiw2b0AKxs0?=
 =?us-ascii?Q?VIKHOAD8FxyigWA9K6CJHAQ/1ya6PO6O2yDY3fSq1RCDlyddZ0jQPdxUJbtV?=
 =?us-ascii?Q?KkY02n2JSXhAaz77fs0GzBRra6apRpMHg+p3xl9KJ/W8HLbXH+ij4uzrdriR?=
 =?us-ascii?Q?egr1BSJSw6nWj9lTJ8B+QbR4f8Llpp2Ds5c1XpCEyuL6f6Y1c6vLW19uhdPs?=
 =?us-ascii?Q?MCYpSD553+Uvqbw1cRpC7uVg4yC/zP6MX43h31KjYFwMEK2ZSYlVGduyOMLI?=
 =?us-ascii?Q?V4yTdLpzUdzAS2E12Bbq/K2Tx1TKI+HhdAsJyaz4m8HvrKDkRgjeYRQktT3w?=
 =?us-ascii?Q?F4xwlw3mGhWuEEA/gTwpYhV378sCzj1Se36AwBLg5YN8UQ/TcEMdxZBAur0K?=
 =?us-ascii?Q?B1J8AKm7RCo0hkglmBpwsftEUPV6s9HlmJ6yDkAXVGsVzLZHjj96YE/Qpwew?=
 =?us-ascii?Q?Hym+GHpwGj2Hp2jcn5GY37xxReYBbDIeYjtW66BOUPbMqVQ5mduCjpf5UxLe?=
 =?us-ascii?Q?tZLmQVemqnCxRESQEEVWBSr5gry+YeOVhWN6hECPkOT6ROWyKrURhH22IeZT?=
 =?us-ascii?Q?/3dVkaq7AoJJCOVon+NChRhZSw1czizf720tS5rEpys7o9MIGlVts19TOIb3?=
 =?us-ascii?Q?f5cbVPrbXc5TSOKY3z7vRD8/JlCXJo/SnUFEQNbfzKDjpzK3G0XxCXyci2BN?=
 =?us-ascii?Q?HXuOm8iYmh2Lgpcy/e4H23x6oV2cladHtUZHMPsULUN/OD2CnC8u7GOZKBLn?=
 =?us-ascii?Q?R8an60ENpXXAHFWVSwr98CdSYjZ33BnYba6Pzqq7zCJT1EbK7Sz7PsXJSili?=
 =?us-ascii?Q?Ljjj3ptc26niTwy/th8xMXA7BUtexnG4oXNwevWAmSdUrj+RcvcsfpMWXSy0?=
 =?us-ascii?Q?qhOutNk4QH657hPDkS8J41O4sclDK0uIGtDjx+h8YWBLtc5yIBxSkRLvfwN+?=
 =?us-ascii?Q?Wo7siVJDWQD0N16ZETw6c61ZZBk15LtJ+z8ykrslZ727lRRfEVa6c/pBc53k?=
 =?us-ascii?Q?3zYh9rJB6AsvZtDdU+WTsma/CIIJc5Rj1jxpkswbb2xxcrpEXRY2HvEdWFaU?=
 =?us-ascii?Q?CN7cl7gWuV+9ThjuDSiKPg5ZpqvKOWgSMyonB4ccv6hhujNScMZq++Fm9xp/?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2261098-f653-4517-ca98-08dcf46abf43
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 20:30:49.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ou4k+mAlhNBa4zncaocSkNoOplHu3QFW4bwkltdmpr7ujJfKXw2vB0C0ZSIZwcrZamlj2qwq+WpPMPqYW0yQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8486

On Thu, Oct 24, 2024 at 01:14:21PM -0700, Jacob Keller wrote:
> On 10/24/2024 9:38 AM, Jacob Keller wrote:
> > I also have some thought about trying to catch this in a coccinelle
> > script. That has the trade-off that its only caught by running the
> > spatch/coccinelle scripts, but it would completely eliminate the need to
> > modify Kbuild at all.
> > 
> > I'm going to try and experiment with that direction and see if its feasible.
> > 
> 
> Coccinelle can't handle all of the relevant checks, since it does not
> parse the macros, and can only look at the uncompiled code.
> 
> I'll have a v2 out soon with Vladimir's suggested approach.
> 
> Thanks,
> Jake

I should mention that my earlier patch is a big blob, but it should
really be broken down into little bits which are each squashed into
existing patches from this set, until nothing remains of it.

