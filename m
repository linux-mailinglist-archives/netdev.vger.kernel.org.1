Return-Path: <netdev+bounces-158957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE94A13F86
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20689188D7C1
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A1E22D4D7;
	Thu, 16 Jan 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTTL2+TT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADB726AE4
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045103; cv=fail; b=Op1E37BO5rY9Ea3vwU653JQbNhWKaoYoG82G4gm0Af6z/4t+N59voinGKwcTyz2oqlea+6dOaGIxbmuSQU+pLWeOCH9Wiyn8B5s4b0GH6K5Uj0Xmm1A0k+uEHnsHrnfCYN3PPqQ2IsRUTxmG/ppCuqexqfgVfihb0aMFrvG1Kgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045103; c=relaxed/simple;
	bh=PdHpBdFPuZkWQ9K7nIPHkftD1wOOEwidXN/eYpOYTxg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rYIifEmkVFWgpSLaQXyeLWacQYlFVH5jYpYqqOSXLjXd59VmzYJyOCwlspEoiUf5sVZ29kEGSVnOtWfSwU2RkDsIPkHEtIeJ9o2wkWR98LI446E2FUsNJ49ewoECoPofUSim3UC9EaVwi8E6VA+wQdYNGH2SeKmHD1isFiyBpaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTTL2+TT; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737045102; x=1768581102;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PdHpBdFPuZkWQ9K7nIPHkftD1wOOEwidXN/eYpOYTxg=;
  b=CTTL2+TTRCRnM6mSDyqBJdtllA3ezb0sZs3OQxKIjYpDwo0ZtyyjQ95K
   S00nVwQZkoK8pJezWrp7FZ4nhHm1luN4ZgGDU6qWLpA79S45ESvwrHeAr
   5LddJG7o96aZ7Li+y1EYkW3g1hR6boiFeeCIu/s+RcEDtCx8NBW9sfngP
   xpROJCLRxTJxng+UCKuGBAJWlbl4jJS/JEspFoMy32iifj02Q9oQ7cjVb
   RzoD2kiXzv79M5oFtr1tsfPuaWg1rIpaT17CNPrkAQLE19Rjp8XyX+KTk
   nWbw6eyjPhTN+spCWtW/lVbniR4SAP5ZwxzHSzo7T6WI6nsVr0t9l8hyg
   A==;
X-CSE-ConnectionGUID: 4ssL/8iTQM2Ru1knkch4Nw==
X-CSE-MsgGUID: 4oDhhyeCQIWnkykgNcGi3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48838816"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="48838816"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 08:31:41 -0800
X-CSE-ConnectionGUID: t5GjnYtZTGKv8SGadcwHLQ==
X-CSE-MsgGUID: jPzOgaXhRg+quma1dqbmVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106427145"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 08:31:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 08:31:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 08:31:37 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 08:31:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6+qMOfB9CAj1Ua2PCEj9yC1pXejchibfI0jrXIsBGeac9Dy6UbYr2it4Y6Y3PbMAZft90Lf4PhkbsydKTuPEp6umek66RBUBsFqCeVuAnieDPI8fuJqLbsUtWakh7XdB60Jo8zq+evF/fVgS7ynjo05jWI/rTQMa/IaG/9Mzw5l1TF8v8/8sUjEtCh38tpBllEut/Td/jQHywhHYYJhvDy0La502p8et4ATSTLcgomVQ0EG8rD4Vo+IQT+p59Huo098H0cKViu25+6PgIG04mBmCJeN6m5+FOqsEJGvK+D0DJZ7MJNN5EarpJgS99OKqzEI2NCAyWaq0eXiojVkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JKulMebDyuEwyZI0+GG1mjZEBc/D6Bqs7taJsNmT7M=;
 b=wBRl8UgSxwXDYfNC5Z2Rxe+3cuPznBAuL0a/ydMyf7tPf/jpiwUrRHUXLKv9YD+z9TMbm5YdZTrotp2Aal7RTvciWgt+Y5lJ0F/ogjh9P8E5WqScGIrxJOjxfNQQxVY1NtzQ/SUtCVqT4RTfoS9Ae89/REvD6nv6oJA2zdpOBHpSyFAzuRQ1y13GQBGwe7z9SUqvGBbok29hO0tqf3S3ZvHXGF4q7Iu9er/xnglpRuZZz0IjA/FOSXcu4NA0H3RU1NlhxfdRLS/hSa5+KgwpdvflGFrXMhiRc1YtmEuxwUnUFnndv2tgSiyNl2Veh8nOvG2Wit3ni6YFN6pXo85i3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB6218.namprd11.prod.outlook.com (2603:10b6:208:3ea::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Thu, 16 Jan 2025 16:30:49 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 16:30:49 +0000
Date: Thu, 16 Jan 2025 17:30:43 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<dan.carpenter@linaro.org>, <yuehaibing@huawei.com>,
	<przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next] ixgbe: Fix possible skb NULL pointer dereference
Message-ID: <Z4k0M6v3Pl8ozDvK@boxer>
References: <20250115145904.7023-1-piotr.kwapulinski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250115145904.7023-1-piotr.kwapulinski@intel.com>
X-ClientProxiedBy: ZR0P278CA0117.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aaccc29-0d18-4640-3237-08dd364b22fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xSMGyD1q1nurckZKjeU/mVbH7kHbbVCvTubdLiTeIaxAbqxX6AGXZTxAsAWn?=
 =?us-ascii?Q?na6unQXn9iXfZvecvDlGYILSB/voKZsE6dX//tDxB5bu1C8nopdcet2YQ5B7?=
 =?us-ascii?Q?q9VGxmgJ0ZwfzU8BkpLrNKAdnu0XvwbbIKAPMYuxjSuidJKsLt2fHx9Bt1CC?=
 =?us-ascii?Q?+2aSCog88obGe7l/qkAYwUw/lrNT6jkjD5zKQ3D/JdtxFXiZRmMrkIRUu3vS?=
 =?us-ascii?Q?tF181UlvKE0lAMgXGDvzXqgiRC8TFu4SHGvxwXUy1leej9T0Au0S7ln4QXRi?=
 =?us-ascii?Q?q8Mms+1bIl6WaBdv9300lYzE2KQUrXJBIOGXAy/sVsj9OkhM3OPKHmBeQAxP?=
 =?us-ascii?Q?S5iYI3ol6Xld0kD65KZb2GrBHLM6VnVOHfHLzPrAtOVsKwkpYKky/2Nj18Pm?=
 =?us-ascii?Q?zp2pCDr5/xvmnDkArZoxfbK5gQapaQq9XDsfppM/Kwr7OC3rmI0g7K/azGPt?=
 =?us-ascii?Q?zgdxpo5x+24fRISx7jryT4XNOy3QyWZdgmCt6GkWloKk53pmDUPOUBJSfYMO?=
 =?us-ascii?Q?XWfkMXQwlIpHjU9omCkMdXsHJDly8bCftk+vf8GyAQDtRgHdfgZwLW8V5cz2?=
 =?us-ascii?Q?ejfkfhipshU5hrs666pR51R6AAoGUKBrzIhM8bFV6Nt4S1br8FzdgdTS6jom?=
 =?us-ascii?Q?U0tpl8PaIiTHb+hXJaz7xN9JMdDoFH997987b9kZoHoyfKIWAace53+mnA6c?=
 =?us-ascii?Q?R0weHNLEb9yHTGTRcZF9934swWY96RVXojB5RUDdbUSzQlowNx3m5aeaFO6S?=
 =?us-ascii?Q?cbV2XspRn/OCW32ORpG3wVjuZQ0xMi2jfmY9lbKlYPGdKPF4oKRtX1Ob+27K?=
 =?us-ascii?Q?1e/OqH2RGex1A4v9sUMTebdTsMEVbjjMqZGxwmyuQez3t5bauH42+6gwP96i?=
 =?us-ascii?Q?buXjkRuFpArvKYJmUAm++V4Bdv6qn20olhAlOgkXw/oNIgk7Gi5zqBHjb+p3?=
 =?us-ascii?Q?6HZkpL1jZQoAdNGAhqDYobomCA9YCs3Ouf8t2LAyvKo77pNpwohIlDpbEOir?=
 =?us-ascii?Q?p2FoxkhsAao62LdvMleFW/bN5qZnTpUDTixK6wyPpsvGBK54M0PHDBHUKTNY?=
 =?us-ascii?Q?zvyvnGFk1qxe1EKzGTK3c5jsiLNoIDPDvKaqPvUJcDtwV1WH1yv6Pk8CM/iQ?=
 =?us-ascii?Q?iObxLaPlUAIwd1Q9WIrCxJ3EynuUPpV/USuxdv8GKSVO41n0z68inTkTgv4S?=
 =?us-ascii?Q?9HPHO0fpgT0QheAAPJP3kZFyc8PtDTSLZzGqFK6VEn2KlbZ0dweVI32W5cxf?=
 =?us-ascii?Q?BTEdBHHX4XDPYV36LFM3jBCUwSxnZLucCY0H3hX7IEuBDwJAsmdlP2oyVo3W?=
 =?us-ascii?Q?NSmTLTt1ZlO3aWhrlNjxeP47aj4WneEes/Uxcm1y9bAKzAW/ZZz8AvWpm2Xa?=
 =?us-ascii?Q?GHrooj3KNs9nZlAhLV+DslTyJ72a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fa3Rbta9TGyn1peq+WAsDEywohCqj2/sU3nAx68fD70NF2JqXmZvs8KRXqQy?=
 =?us-ascii?Q?TTkmJRmCiv+CEERw/c0PUqDH+PYnNUlanLEKJ2H2hIUmwkeBxN8hqj22XpKo?=
 =?us-ascii?Q?8Cj/Z1dMKv9TRKSGQwcjmti1wN2caSLa+O9DjI/IfDFoc41NeHpO06Aaj3Ku?=
 =?us-ascii?Q?rkI+OfnH4xfDC5G5T1W+TQYsF+5y7FnbrRfX+EBQQMGtDkYu7oPPGeErO34y?=
 =?us-ascii?Q?zWhW1CYZlZZik9MLK6MiS3xiDZGG6DlOsVTuRxqnAKZ5N2gWGWRtDAEzDR3k?=
 =?us-ascii?Q?cndfQ8YmINZpnQlpwntxvYI7o1/oCztTYtZ3/je8rBgvVw7RZa+696i/zmhc?=
 =?us-ascii?Q?YNZs/ADRNpw1bc+OB6pGQ5dshhQzl0HtIu7YBjtU6WFRkVVVptWD8WMc2Rod?=
 =?us-ascii?Q?+hO1nDmZWCtL69C7Q8hqOM//tKwd9CP2ngNlb4AXJHvEKe2AlEYqxff1s7U0?=
 =?us-ascii?Q?mb9No7D4HTRBF1eiROaUNBPDovDQzUk/sMWZ3CLfK/tpfjM2v95tHImRpnof?=
 =?us-ascii?Q?oPnjdvNlS7lIMYM9t8QPEBHLVOtbrfolZntnqOtzod5ytwGoO+3KQCUII23X?=
 =?us-ascii?Q?6ZJVVfZ252BUubCznaC1JgqVh5LLV3M9yIN5+F12d1g/tBvxdX2714EQFLTt?=
 =?us-ascii?Q?LrC3XyFMEbV+/kAcsEYS9zH2OKJpjkI3nWB9F1M+irOu5KNZNgdcnWKaLh5T?=
 =?us-ascii?Q?2p5fAEOWaZ7DV+eAdY5s5QUhxvNryP5h5dBONqB/JgkUp4B901EdxQwumsdS?=
 =?us-ascii?Q?e7tesPnLXzsrnIN0hYmglbkBQnF6vPq+8QJf1mLSFzn3XEGubM2hoaG+5dgn?=
 =?us-ascii?Q?bseAfjE6SfueRdIdf67IEwj8JXJFY7uk/8A+PDCwEmc2JFHo61SlXPCNVEgS?=
 =?us-ascii?Q?kwrEeWuwzB8TnLv8RiQPOE+VIEATRN31Yvh0fYkPHgRk39srN5QJmy8xWjcf?=
 =?us-ascii?Q?DbTl6Jk4chPXH7dWOfhkN8KEee6xDZ5V5ITwY2AosX7/aLdTGiwkXAnMtYxT?=
 =?us-ascii?Q?SfyHPl89hXUUy0sYFXsKChOowyWZ/iYJcLrWfDYLK9evnMCeEhwn5qpCbn0O?=
 =?us-ascii?Q?R7QrjcvMWIDflf0F2ZSOLM4IqM/QjnxhiyPhZx+TOvOSZ/EPYkcLQ21zRPHu?=
 =?us-ascii?Q?Nz+HDHcI4IOiFxxBY66uzx1b9+fo9LzTpVL470pEt97OUQfXNqTrJqakN9EX?=
 =?us-ascii?Q?OdN3G1xu+gVZk/127dp48glLNTdNbQ4xzEYnhI+vS/heCPlQ+HwV3LD7rVUJ?=
 =?us-ascii?Q?aUXf2ihkTn0e4bIHq8ENPvSa0Llfme1KBt9iZ4GRSI1xO1XLvaSNuDlJSrMH?=
 =?us-ascii?Q?SUjBtpUn/gCDeGSdJIg2/HtEZoLR8+ieJtPVA5HuUeTqNePqnzQ3daAliiC7?=
 =?us-ascii?Q?Lka/USypLb9TmVKh15DSdm0AGYoclZMJoqxoB7E+fSkY9Q3qlSZi7E13enhG?=
 =?us-ascii?Q?fJwODD8/vuCZtH41kAsNvqxIoP/OVkJDkX/LmzPV+QIbkWC5DUTTVZmsY4kI?=
 =?us-ascii?Q?EsFWz/C0vkz02ycGTiFzFdhPErZZYxFZn2btJ2E+Zit5UW97nw8ZGzncwTIG?=
 =?us-ascii?Q?pkMDo1S5qTMl32PZiSBmQMrJ+mNDcCyJmfw1+C5QoCBHYvkWB0MADclJJl+V?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaccc29-0d18-4640-3237-08dd364b22fa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 16:30:49.5151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hy4ZOO60r47nQS37UDtUvNBv70aHSfbJmyllq9gDsqwiHCRtQy0QEp7AmxhY6NlvcWFhWlbq6nY1JtN8n3TbW6uu7VstJmlkdtGCV4ukKSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6218
X-OriginatorOrg: intel.com

On Wed, Jan 15, 2025 at 03:59:04PM +0100, Piotr Kwapulinski wrote:
> Check both skb NULL pointer dereference and error in ixgbe_put_rx_buffer().

Hi Piotr,

is this only theoretical or have you encountered any system panic? If so
please include the splat so that reviewers will be able to understand the
context of the fix.

Generally after looking up the commit pointed by fixes tag it seems that
we got rid of IS_ERR(skb) logic and forgot to address this part of code.

If that is correct then you should provide a better explanation in your
commit message.

> 
> Fixes: c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()")
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 7236f20..c682c3d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2098,14 +2098,14 @@ static struct ixgbe_rx_buffer *ixgbe_get_rx_buffer(struct ixgbe_ring *rx_ring,
>  
>  static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
>  				struct ixgbe_rx_buffer *rx_buffer,
> -				struct sk_buff *skb,
> -				int rx_buffer_pgcnt)
> +				struct sk_buff *skb, int rx_buffer_pgcnt,
> +				int xdp_res)
>  {
>  	if (ixgbe_can_reuse_rx_page(rx_buffer, rx_buffer_pgcnt)) {
>  		/* hand second half of page back to the ring */
>  		ixgbe_reuse_rx_page(rx_ring, rx_buffer);
>  	} else {
> -		if (!IS_ERR(skb) && IXGBE_CB(skb)->dma == rx_buffer->dma) {
> +		if (skb && !xdp_res && IXGBE_CB(skb)->dma == rx_buffer->dma) {
>  			/* the page has been released from the ring */
>  			IXGBE_CB(skb)->page_released = true;
>  		} else {
> @@ -2415,7 +2415,8 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>  			break;
>  		}
>  
> -		ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb, rx_buffer_pgcnt);
> +		ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb, rx_buffer_pgcnt,
> +				    xdp_res);
>  		cleaned_count++;
>  
>  		/* place incomplete frames back on ring for completion */
> -- 
> 2.43.0
> 
> 

