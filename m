Return-Path: <netdev+bounces-182075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8C4A87B10
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B869A1893DA7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6231E51E7;
	Mon, 14 Apr 2025 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BF9rk+Py"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72514DF42
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620793; cv=fail; b=CMbM+ZzhApduc+FiM7T0z1pNxnvmBpG47vu/Q4GDEZWZSDennc9ciykQSGPxPlBU73r42vYhf+h7u2D7QODkCfQ6d1nmF5rPatpbsgZ5xZzeV5xeAuQMLYJXEBBmyKj8lSbiehgyjjKaN1lDPl/7/a1beKf9UtrqrvEGJkoripg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620793; c=relaxed/simple;
	bh=Dk6K6T2jOjxDd87xxkQ3PUfdtWlEppBiZgfMuXafqRk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mr+qrnGrwZlfH4HDUpVeFJqmJGotNcIgX9ASZeASRfQXQkkoFxpVrq8BdLnYzVuhPavw8EBBPGaAIiKmi3AKzJ0lYk1/i2+axHOsnVnwpKSscB3zHI/GcUGCnLJ14VFMYXffUFFO1NlWHFaTBw7pLsHPEatBsyR0XQf15B+/qzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BF9rk+Py; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744620792; x=1776156792;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Dk6K6T2jOjxDd87xxkQ3PUfdtWlEppBiZgfMuXafqRk=;
  b=BF9rk+PyBBaKetw2jzaZQDsk1UUvc64sl+BKnAZmCDAXAJbfRitiMI0M
   C613vVRSYebVjrm47mymWl1EGrPVLrYiBDSHzZ+gD6No7GaACC7iv3RHh
   wFhQnxPSAf2SGQmmtaLcZ04kxo1R2zherf/bhBICkwZiNO8F2IbLCeNQI
   bTn2qoB/AMcOGOsWFM/duiOU9a7mnlmPb8yQv1HRWJIIG3S5mww1FkTVA
   o87ZL5iJpU0NPi73JrMu8xOGbKXyf/L06nBeWKxDJ1CdhdMaZ9VHNlDoT
   WNVLZOuvNPfohUfB3ACnoxojCI6ubitj73JDfUhXdawGhICWuH+oU2qNr
   Q==;
X-CSE-ConnectionGUID: PHS3ZoXgT+6qop8E0MSakg==
X-CSE-MsgGUID: mpZdOJJqQHu3SBe7jOL9Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="48782083"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="48782083"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 01:53:11 -0700
X-CSE-ConnectionGUID: arAwqVK0Rmi6SUdIVRK0dA==
X-CSE-MsgGUID: sF/ehSkBSpSttL99xDHIpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="130618612"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 01:53:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 01:53:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 01:53:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 01:53:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIc15wdG3iJoy6wMztycGeiiAmr08tePTkcm5hGDtHhCPtXUcctTE74HLnxrqF4ia+U2p3ymJO7/yJYAKwfyHc6QnMQSZvZyGTQ9ANleUkbvnAm3S7gxH8V7jCs6szUOICvzfYkWqqF8zZ5J1C8QGoHbBsw+sUlucyfLIbVPkERS218WdM1C9Vr198FuSOUiJIz/mgwNLrOgA//7LCmVsDgVqZs1ceN/Zf3nykGC3ewICN9bMHfk0+cf9LtjOhqJBM5JIQU5c8ywIZ0tqmXw1x+uaZYBjvkOsgSD6UT6t98xolliqY7gMW99TI96YdJleNsfq15+927l4xyHPrAEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrKEyD1+1TbvgIG9Zg+QsHtkJ2WN0vtoJ2zM9OGBXWs=;
 b=VUSAhkaAT0QCEZ8IjMXnRaga6xL27K+qvuJ2cp4g10SVHq3IZVT0zCMG8m1XOSRCkyH6w4as9i5lSENRcj70dbF2onk99lz800jXDJlcYlaVo50Z+jLCcPzu1PiSv54LMp0CvZljBGFNNuo9TTxhXCQLuPWa6pU5rOE6RgExf7pSKDSkkOu5IGn8OEpCAYUIgNI/DK7HT1oSGEz2307Rrx2FChVPETU8p7oEEqEn5y3QuByBvQnnPFktY4MMe7NSX6PCekfjjm21d2mhI5epjcF5NJ/KZnGEm95sOLlsMSXUFkAZeChuAtM5tqP9FB/oiwjGcjS87WCNyBzeISdNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 MW4PR11MB6692.namprd11.prod.outlook.com (2603:10b6:303:20e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Mon, 14 Apr 2025 08:52:51 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 08:52:51 +0000
Date: Mon, 14 Apr 2025 10:52:45 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <dlemoal@kernel.org>, <jdamato@fastly.com>,
	<saikrishnag@marvell.com>, <vadim.fedorenko@linux.dev>,
	<przemyslaw.kitszel@intel.com>, <ecree.xilinx@gmail.com>,
	<rmk+kernel@armlinux.org.uk>, <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v2 0/2] Implement udp tunnel port for txgbe
Message-ID: <Z/zM3fDrQ380gm5x@localhost.localdomain>
References: <20250414091022.383328-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250414091022.383328-1-jiawenwu@trustnetic.com>
X-ClientProxiedBy: DU7P194CA0026.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::23) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|MW4PR11MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d590a7b-893b-4464-9311-08dd7b31bd3e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/6o/EtLb8W1rWIx/pRfElr0IA9JhjsbTtNIqcbEDRVDm8f0ndWKwftu12HO6?=
 =?us-ascii?Q?iQuGSN07LtCNTj3hbmqtOY4IK5gf4rQfCkRjHM5dK7J8mlHvpFKD02HeP/JC?=
 =?us-ascii?Q?zTKDjjrYmyHSl87dAYpnMZdzhzQipPdfVCsbn45GfXFH7gASqxjQnu3HB+oc?=
 =?us-ascii?Q?wrzGNYLGso4YrOYUQfmcuWvp799PqJWItF3aCjDk4DKOCoNHIW56kO8c9W/S?=
 =?us-ascii?Q?Ntrc5d/d170FKwEvBAI/Qyt6BoopG+hjr/JEcdnB7uzsv9QklPr2IzCuMc8f?=
 =?us-ascii?Q?XiZ7q2D3BSbaYVKyUD2U6/Nvas5u6vW09Uzu5JH2edh5hpPF9syY9wXso/q9?=
 =?us-ascii?Q?xqoo9VAgGkdnlqCatg0xwpLj7Qad054ZDKuSvd/Le5K5vSGZCGU8DOhKK4wB?=
 =?us-ascii?Q?ynTSvUfZyHCaUkKzwqKhw8LJy/KseFX/sxQidaxodewXOU9cbEmWzw/7EkOq?=
 =?us-ascii?Q?ib9niGrn8jxg4TFNYymWlrp4JUIohWXUaidUwoFpoZrW+8mTEG8ZuUt+Hb+k?=
 =?us-ascii?Q?HGKUt6wrEwMvow/NN7XXKBOOr/a07MebU3UUKXT+2tGU3PXK5W0KgbqJ/3NY?=
 =?us-ascii?Q?cO4wsvj7Stq/2xU/b5J6SoVdENfAzjEMVATER/uqnp+hMuw8YX6F5EKDWAbi?=
 =?us-ascii?Q?gtPblgykZbyY9iYB7bXejEGws30A07kRcW5y5jt5sCPu/I0lcfI8bFtaoDNU?=
 =?us-ascii?Q?T1+lep+9XOj71h/gDYbJHzAuXVXJECdQA7o9EI0GlLfrj8ioFU8E3CMCmILD?=
 =?us-ascii?Q?T9eeEsOucwmsQmYoTra9p9klprZIa4ExUWOzRMky/xUg5eL13+sZUKqSQkvM?=
 =?us-ascii?Q?qHl33tAF93iv3FX+U0ka0n/NFJx/jLTa01ziS6mQNIheqaagUTdYfWlhfHrd?=
 =?us-ascii?Q?I/qY2xy5o+XfAgV4AEi+cQp2W7hBJLaXNbsJXMIT0W3gkY+ntK1hrP6NGCOb?=
 =?us-ascii?Q?9bGj7hQcvP3IINrgBv5kJ7P79+vNe4B/x9/4sqVno3cT1yUlOZO/vYXzINvW?=
 =?us-ascii?Q?Cr5sz23AAPT8rPUT0PsxXQ+UwJiGb7+exakydU9sL5A3JNZMlu61qQpna6l8?=
 =?us-ascii?Q?lcetKIU5pOqhHgpeQavbHkuau2l6AdCA22gYSgtzAWSaGt9nh+JjxkXxRlCy?=
 =?us-ascii?Q?UzNM2rQ4YH8nBcXtVGjCPtusIjP9/WqQxXbEQ68hnI+wwQEHb2vyz5W8tcuJ?=
 =?us-ascii?Q?eOa3zrSC+s2GDAm9bKXFJOOzoGSECgELDud2v+eN7xpGtUUmFN6MziB9CHu4?=
 =?us-ascii?Q?O5fSD+/OyA/kRxP2MMHMxNO7F5iJduh4DXHcRP5yCFWAwhzt3FyjGKLzkpjJ?=
 =?us-ascii?Q?Cod2iEGTGuW0OAUaAl5GBHafgHdWB0EJUV72FIzvLp8uLrYEjtG98Od0DE+1?=
 =?us-ascii?Q?s9zVp5/EisMX7NM2orcQfwRKy9NbzriTBI48+MaZTwmt7ABVbLeDlJ5md8fV?=
 =?us-ascii?Q?UycHY/QUcNM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3yv9NLJS7xK8XpcMtce60X3YDu2R/YpKC6F0VU+j4zT9W1WXvrKGUrRw2wWS?=
 =?us-ascii?Q?Ej9EA8ciUuThlWM2m3acXdW2uE+F5UFu4G2IoKXaeOZwKbkEbPEqWIFIn8wS?=
 =?us-ascii?Q?wuB3CIrA6PlboKF1EIZss6/XLFzRsFOzjVAKQ1YLun7/jKYBFrCurRCOIzQR?=
 =?us-ascii?Q?xcHyE5X86GsYlJjkIF/AaaRMlqSkLlurI9RkmjsRSc2hvYRQ/qsQkcDtyuyj?=
 =?us-ascii?Q?9xtIdrAAKEwqVvTAQanY02LkHajDq4S9++Fvtk/3EZ1eTgSQqsoJv/wSPw47?=
 =?us-ascii?Q?2UUaitpAR89ZhD0cMWUK8QpiLn7PwKm3ALsrxZVspmgPsD2MghJNN+JXOS7+?=
 =?us-ascii?Q?3Bnz1KAZaYnb6NVYdOlUoHvBupio51b6NpeyM0XzOjEPGCwWxhULOPe+UWsV?=
 =?us-ascii?Q?pI0p/V0npqOYtWn3FVuL5PkTfqXi2E0dBD7HABJB6i8ggjpfT3uhIpxipxLh?=
 =?us-ascii?Q?+hBOwkCA7vo2kK+46KkpUJ0lNWSyi6FqA7Q5asVUifyBspZTrPXxXXsJtFcX?=
 =?us-ascii?Q?TZZ0SyEmIWE+teTyBRhaPRp4x1NifruqGW2RAu0/vVj8XmSGOg9W/cGaI5KM?=
 =?us-ascii?Q?J/mQGfTYCFBSniOjKAxAfQ7tbIj/ikfBmsHAbVsDv9u/+GogUHf8IDCxsPnV?=
 =?us-ascii?Q?rDwA12sXlrjAg5RDJerp9E2R53KCMnA7kGVSp3svRQmxxdYYhqA0UgHKyH5O?=
 =?us-ascii?Q?oBFKUxNnQ4xzrIP4z3OO9EjJZ9pEkJ+Gsmi1Xs5i16MSiZ2Gzm4w+s+vQx19?=
 =?us-ascii?Q?Ii6RWBbs+RdvZ1Zjm6dEvEl6N7ugzE8/UF8jlAwsTSKMF6Y9di06bK/PQT/Y?=
 =?us-ascii?Q?/53HmZmjIgEnSLkaA1W6wb7rXmVGBzZYYVbXFeqzv7nwkjjFOLHmenBO3p5J?=
 =?us-ascii?Q?5qGI1bB6CEaSM+Wv94w8QyUQcG4FzBLCm8bEIyzvWTGQIkoUwWTapbyufYDO?=
 =?us-ascii?Q?U5NB+aE4oAnD6W9ZtciCVixJHLVA8qZtlWhpZqRdO987abo+NMtfh/Pn3KUn?=
 =?us-ascii?Q?VtsTFAUbABootFKD7UUnAMTFvsGdjVjo9y00emYCSwUpt6VV9vOLpJ12agrV?=
 =?us-ascii?Q?HKhek3ClYjidRztJ1k7SK02bZWIE1Rnw/N1BKY3IX1NkUypNdu0j9eLpELTG?=
 =?us-ascii?Q?t19xyWtd7IS7e9vKZfDw2h+SfXUVjTTdVGmO206czGRav/4mUGrprFtuZlS6?=
 =?us-ascii?Q?pGUceGHqXqtMUA87LnZeZ3q9KOblVNjhhXG+7SYgn22R8FzGcK1+aZrHEz+p?=
 =?us-ascii?Q?bZevlSinyKEKR+yTCKB3YOHmDPOZcEiqx4QGhV6Rshgl9NFA21TEyMrZk0GV?=
 =?us-ascii?Q?Or0h2ydpY0lSYIsoXU+Qiug1/JJBgtf+JpfKZV9vJ4Q4kp6kRaRfxzuwusHY?=
 =?us-ascii?Q?pvESl/12CB+YAhFq0JkgrAy80c0JS3J/eyWNpruwK326++PmVeToVq4/tO8L?=
 =?us-ascii?Q?usBTKW1zS5zczuIyQMqy0vB/eLw63s/rt2uy3oRwSLZoiZ29MwGhQqYTbzo+?=
 =?us-ascii?Q?Vtitd9JMujHqtCUTvcpFCkaXJAt5qkkYmljbQhnv/CnM+xlvYm3Yt3/d2/x2?=
 =?us-ascii?Q?sjVO8OcczNE/Wg4iBZSETdI2CUF3U7ZCFDSz3WJO4inxy4aQOyEy+qY++8tQ?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d590a7b-893b-4464-9311-08dd7b31bd3e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 08:52:51.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbP4WTAL7roQCnLvzP2jIFlxC8lOPiH/snxhz0VS4KF1KmSAKc+HYpAczsCAFDTBPVZV7p5xXTJko4WXrtawPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6692
X-OriginatorOrg: intel.com

On Mon, Apr 14, 2025 at 05:10:20PM +0800, Jiawen Wu wrote:
> Setting UDP tunnel port is supported on TXGBE devices, to implement
> hardware offload for various tunnel packets.
> 
> v2:
>  - Link to v1: https://lore.kernel.org/all/20250410074456.321847-1-jiawenwu@trustnetic.com/
>  - Remove pointless checks
>  - Adjust definition order
> 
> Jiawen Wu (2):
>   net: txgbe: Support to set UDP tunnel port
>   net: wangxun: restrict feature flags for tunnel packets
> 
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 27 ++++++
>  drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  3 +
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 87 +++++++++++++++++++
>  .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  8 ++
>  5 files changed, 126 insertions(+)
> 
> -- 
> 2.27.0
> 
> 

For the series:
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

Thanks,
Michal

