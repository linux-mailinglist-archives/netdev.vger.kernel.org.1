Return-Path: <netdev+bounces-109274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6CD927A44
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF361F28296
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3564E1B012B;
	Thu,  4 Jul 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fy5gIwhg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2481AC252;
	Thu,  4 Jul 2024 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107442; cv=fail; b=eoKtFVhG8vVsuxb67npqDdJ9M29dPcrV3YXxpARWDDPbxJn1oLzg5lzePDflzv0Egc387G+GZ6mqjGBMl2QTw1lcxzRZAzE9LuoJinamzNoWiyc6tqnBFvKHFieiWlYp2jBvdOqeChHYpfWljPZpdZGc0yeL9Ec/IZuIG64Ggjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107442; c=relaxed/simple;
	bh=Rw/RegzeA7bp28Vd0YFP2jrbwFTqMxLSkRD8OGX34Vc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HgmxieRY0RyXDVcmQI88yuH1fno1o5p6z5ZEfR5w3lUr+3RQmcGPpVIMCrArgtpW/E0YAMsVdQ3pLauvIzJY3iKr/nFmJkU2nL0V6r6RbvQ2rxyzUl/xq9ILni5fjtMdk6AiHkG1XWHVpNgoMckp9nUUsAihIdV6tC5HQAybTq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fy5gIwhg; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720107439; x=1751643439;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Rw/RegzeA7bp28Vd0YFP2jrbwFTqMxLSkRD8OGX34Vc=;
  b=fy5gIwhg4TY1JB1YXuqI9c/f02fsoiF/lsFRrV136RYQMFOxeSYeCy/S
   DB5qF6WzBULBtdmlcOi7J5tqQuwdFmR6Y2RQSdw+BZFqb0jayy3qzbExv
   ZrWCYqOzjjErW273/hQjDLDlvgJcQHA/33YwBKkr0QG2h360EgZfNh18r
   bIE0xDEUjkGZ9ZVKLsUINBOkDENGW1GyLOZ/oKxi9pnTo/gdJEn01UgFn
   TKg7xoIapgq/Xr480DXbZE314g46QMj1s7g2SBboE65I0Sn6F5Mifg6C1
   b7xlYtb8FY2g7GJpw+xl45guBIYPeQS6Cc8bbOgdMwLaF9JAlBkBG59F5
   g==;
X-CSE-ConnectionGUID: kj95J723S1Kd3HgBMpv8+g==
X-CSE-MsgGUID: NuKlIoPLR1OV19JaC2f8GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="27997969"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="27997969"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 08:37:18 -0700
X-CSE-ConnectionGUID: lEoK8kmnS/iNRT0z49nFiA==
X-CSE-MsgGUID: 92P7xiazRsmliev0hBjYSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="77764131"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 08:37:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 08:37:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 08:37:18 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 08:37:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QS7LqjG1512jMqYM267Hpy2u0gR5kPwMt+o+7F/7BWMvFrfLeDpHo1tkkGu6bzVGZQOub5nRRuBBDju/83uC3HwtotVwrZ8wsoRTx6s98xcvOQm1OQYqHsv4gzRSlGpn316Ne2bDRCz6Ir/iqQJcmfXrlX5VCvEWHqxgbXwj0DwKfWU+FpCN0ZykwVUQd62MQPoEazD59DwuEiKJojO0veztdH80mis0kg9cq9+86QWUv9zOZVZa54e9i0aiwYuXJzrLX14i9bNaxjYu0rqnOJGb1eMOp5YGuVlnwlSEHoN+hh69HFPid0xzH9EICehN4iPHcrCVl6ftzHnns8Duqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9Qgz2Y8y+dHq8a4DhgTCcXhELqhUQPQh9/YZO7f8sY=;
 b=ClJJjTDg+LYh7IdOoSdeK5mHwOXXoTe6wWU3wxMdaAlhbeUPgDbJkKaSTvUo6xs48YtuAtvV5ZNkj8qzK3mjym4+PY7lFZzduAO61pImQIvfhx8H4TyybuvM6r4F3fk90R6iuNGJMKU8PB0txFBux6tsJXF70p+z0uFFiqmY4KlNkPb60YeINuovCnygMtUvdN9KGahwSgqYEGCLnXpYjRvjwmF7WwfN2olBV4iOxIXCrvxD41WLxGtf/Ej0+9/NIDjmfT1HJGJNHjMXomu9nviYIpMtAla+BrFjZuWNH/lK/4P1rQHCE9QBk2LlGgr5iEH1DinLP1046dBpALBUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Thu, 4 Jul
 2024 15:37:15 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 15:37:15 +0000
Date: Thu, 4 Jul 2024 17:37:02 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Woojung
 Huh" <woojung.huh@microchip.com>, Arun Ramadoss
	<arun.ramadoss@microchip.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Yuiko Oshino
	<yuiko.oshino@microchip.com>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 1/1] net: phy: microchip: lan937x: add
 support for 100BaseTX PHY
Message-ID: <ZobBnuU0EtcpxQjH@localhost.localdomain>
References: <20240704135850.3939342-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240704135850.3939342-1-o.rempel@pengutronix.de>
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|IA0PR11MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e97febe-4f94-4189-80cb-08dc9c3f2e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OhuXckJ2eMCq2GvIns09uc2Wfzf1rmU4Cy4qzQEVh5eefA4Z8Jyr9hrxeIRg?=
 =?us-ascii?Q?LxgiQMKNmgHmL44clUTBg+ZanwlJ6hPQ8FENz+iN5DQweYZWlPR5dAWJJTWJ?=
 =?us-ascii?Q?bSyPe9ecvwxsv9u/wqhNt8T2oqCH5Zl5Nx7CTIJ8LEGHxxNOwz84loDjRjCJ?=
 =?us-ascii?Q?3Kn8+ycHWbwHrDFfbn1nlahVqOBuUyfPoSB2fIdhV5GT25d5m6uzkY5o4KyM?=
 =?us-ascii?Q?gmWi9NFNEiQBBHSbJOIdhDNjT41pjV6Xj/KdtAAnDLFhQ0uThHVKWdEi3K3V?=
 =?us-ascii?Q?EGYrFqqHsgvUZI12y9N+ERBwQ1qz5CVoWFdn1jh9+HGr2H8WSMQ4XiEtF22N?=
 =?us-ascii?Q?yxkfA7k9GaDRt+4RNchUsF8d2Cob6GEn8xbfW9peBuJpgVJkU5hVS0TTKlSq?=
 =?us-ascii?Q?gnYwaLMn9bDKh9CXCVwu9t23om6dpWigEEccrfeCTc/myhG+XkpYdo3XWTvf?=
 =?us-ascii?Q?L11pvk7qOIKa6goWqWPRJoD8Uc6kvQlYuaFGxugwEMc1uoRifGyzRLwdyiQv?=
 =?us-ascii?Q?9ejRamo894bgXsNsoFUP1g3x5JvKDp8u7UZ0N06kmFTh5Dp8pWYtNrSE3BX9?=
 =?us-ascii?Q?TaCOZktRx8TOvNIMup5D41A3cSbt02IahDdmn6MZzY6cF6d195CnLLri003I?=
 =?us-ascii?Q?J6/IUMvt8w4uP8M95V+hgpnDthfVdfmOS83qdw4+YIFqpOWC7gsixsTWN7vT?=
 =?us-ascii?Q?8JIXXziMdqIZD/5z6OfdJ+1ZE4EtnHy5wmjuYErP4JvSVCLzstRmCRlsosNK?=
 =?us-ascii?Q?XeoBRAIqu3GhL8MsfKKwpU6CUh0YsLTNzRPlOoEUb7FTaQHVfpt4G5wv3Bmh?=
 =?us-ascii?Q?lJj3V4SeSxplNBWt3fFeDfVW67Ou4IcWCJui0d/VJqQafRSDuDminc25P/DG?=
 =?us-ascii?Q?a9wm3HiAnsfkuoOUb4ggJyGXe3I+6BlsonqbRdW/5rTjJ8AKuL+fx6dKN4Vx?=
 =?us-ascii?Q?hkqlBhoGq1U6cSQHolNqpotyMls0mbmr2X9sRFgaE7LIG+Iu1Cqlo2yxU/nT?=
 =?us-ascii?Q?bBOFPWA297rTPRfQZRfcU5hMyVbkGO+O7yCc+gXDFg43pWVzj3BtBhVoLlfs?=
 =?us-ascii?Q?iGQOIdjzSidQ2THJnoX9Hk1YfFgd77IhL2AoEC9CRjfGNdJeuEvBYLPOgqR+?=
 =?us-ascii?Q?a+by/wKZwIm9/6a9HjLPv9SOgM8aWaFxD/oPSvrbncr+u8Xm8tCvAmws675S?=
 =?us-ascii?Q?Sn88b40Z7qHXXPfEf/qiMgU1mAA/0xRcuWI+96tq7jSmoO9QE2r3DPD+0ze3?=
 =?us-ascii?Q?hfvjWigexzHTD2HuSUz/TMsTMqnLtTCqdkCrLz3jkqOi9T7bZHr1RXCcl0YX?=
 =?us-ascii?Q?wFwrcAGvnAAI9TaWs3RoNz7q3UIMsLEGAdox8nqGukL7EA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?02LLY58gUgiaQZaGe9TuiqsNtxJZBf9p7sEbJXcDLTUxKhcJh2xS6c8YgUm0?=
 =?us-ascii?Q?uoWIx/oO9SGJ761NbufiJ/j17XonFDGX7YK+Ry8KNP6PPNmvvekM/RVPkfPN?=
 =?us-ascii?Q?VZUgWJc2b7O1r2ULXYRVwms9kUwyBgijxkTS4dS8eNt1v18I66FFJlXhsXp8?=
 =?us-ascii?Q?uGgJRVObgllMHgO7mL7OKkJvn0419kVyVCKCWWwxa9V4GDhXyEJJc0ZnIhEV?=
 =?us-ascii?Q?5vAtSHSgiMIDDptixX0SebSq1EtNlbRebLhSukksfCds6Z5474sc4GyrY8zV?=
 =?us-ascii?Q?AKOxyzWubPVWz66SVlh5eVSOigkD0bl4hk/4FK9xNxtz4Dz+Vk4WgvT/QKUG?=
 =?us-ascii?Q?UT/KX/oLsw0H4HKX8RFBQxGwIdNwF4gsaP+2jQ9BCjSiomqaqEaBqYLOQQrq?=
 =?us-ascii?Q?CTaauv+dqS43isEEe2s2R5CWxGOo1/fMtKT1sJamacu3phM68y5Ou4WLE/mE?=
 =?us-ascii?Q?j3CIMuJ9VpXxWtc2oX4jS4ICSvtBuf0ZGxnHlzdJR42iYzEC2VlNJWZfQzO6?=
 =?us-ascii?Q?wqVwt4qVcXh113lXCx38emm5VNtomObGMyWSw8Xu26Iwedg3DhPhWl8oU8BL?=
 =?us-ascii?Q?0Rui76tEiE2c7NXXS10JQuQ4m44qacl5yEnKoVzW+5bytSxlC+iOR/ummUTC?=
 =?us-ascii?Q?de+IcNA4haPmbzYBWtsNR3EEJ1Pfum3DpNa2uVPQ+1FeNBWZHW071yu17KeY?=
 =?us-ascii?Q?JOTnAsjUX9+zr/E9UORnIKctPHzb/gMXzoQ9YwqIdCTerwBN4FYEt8r2ChUg?=
 =?us-ascii?Q?sjeowloHwP7z7tOChsrVKGNNkv1tUzWP3y/3Sdp9YUkbLoRIXGxkecHogq57?=
 =?us-ascii?Q?mdku3xSCjYhTYigWOzINbYoSe93ABkKp4oEY/G5ctyd6vKDwDG5puyrInI0r?=
 =?us-ascii?Q?bcn4GDntMVnapjM1O0lFd7ObmMAZOJgomrYpREH4UI5VsxhN+p8LbwNtqjj3?=
 =?us-ascii?Q?msHmU7Jh32w6KtKtG4lTrCW4d2fnEcuCKoR4dSxD/JrfDgYrZbXPF9mL/Tmb?=
 =?us-ascii?Q?ZAv5F/J/7atk1V/nNJgMTGeRhqCEbQleEo+piqwk4gNQSrYzxmjNG1J9ailJ?=
 =?us-ascii?Q?6W499EUZkhnWRwV61VVOcUdOvur37TDHDUAEs8MHnBANRt7yls7PjNjuIEUg?=
 =?us-ascii?Q?dgl5bLio78Gd8qp8XXqJtNghdNVmaqCFBBvnclRItb82oOhoH0OOh8L3RiiL?=
 =?us-ascii?Q?PP5CUtbfnf8Jx9UvSUuPZIogDULO2psHIwat65z2/OKVzAXbw2Go9N+i7P7N?=
 =?us-ascii?Q?WPtZSkLvC+/Ng6ma/bVKMrf0VPbSRouidJM416K5churiVJYuCmf9wPrcyWm?=
 =?us-ascii?Q?EQeeAk14C7Y4i5/Aoe67Q9fnWi7CYcVJr7jYnjKL0y7O2NzlhmxTTSXOIhHn?=
 =?us-ascii?Q?kgP9KSYhb2Q5JktJovXkM1OEuaI3Cjp0K6eqwPfhTQt+ivoWkLqShjLhST8g?=
 =?us-ascii?Q?2f3BgkKUlyxZ1To+M17d+JodTiL65OyTcVKBQRy/pvISeIPEbUu64vEYDXw3?=
 =?us-ascii?Q?KrDHU9LnCV7BaO1/BokM0VOe8Bmn/R++xmMHJAtY5yjaJgRN42nCYbYfMGKM?=
 =?us-ascii?Q?Xq3Mz+pq57ZXjNuZ6N5RxBRvpiwMW3w9Tzri9ewAnZmNzlLl8kN87UfRYkWh?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e97febe-4f94-4189-80cb-08dc9c3f2e79
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 15:37:15.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oa5aSCb+L9dV6QAF95jhZZqt0Oh2bpQbfl2w01t/Gs8HBGiqiZndeuyC5w0ay4+wbkws7kVkKgCKZKkhMrOaKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
X-OriginatorOrg: intel.com

On Thu, Jul 04, 2024 at 03:58:50PM +0200, Oleksij Rempel wrote:
> Add support of 100BaseTX PHY build in to LAN9371 and LAN9372 switches.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/microchip_t1.c | 74 ++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
> index a35528497a576..c7ca0d04b9e1b 100644
> --- a/drivers/net/phy/microchip_t1.c
> +++ b/drivers/net/phy/microchip_t1.c
> @@ -12,6 +12,7 @@
>  
>  #define PHY_ID_LAN87XX				0x0007c150
>  #define PHY_ID_LAN937X				0x0007c180
> +#define PHY_ID_LAN937X_TX			0x0007c190
>  
>  /* External Register Control Register */
>  #define LAN87XX_EXT_REG_CTL                     (0x14)
> @@ -94,6 +95,10 @@
>  /* SQI defines */
>  #define LAN87XX_MAX_SQI			0x07
>  
> +#define LAN937X_MODE_CTRL_STATUS_REG	0x11
> +#define LAN937X_AUTOMDIX_EN		BIT(7)
> +#define LAN937X_MDI_MODE		BIT(6)
> +
>  #define DRIVER_AUTHOR	"Nisar Sayed <nisar.sayed@microchip.com>"
>  #define DRIVER_DESC	"Microchip LAN87XX/LAN937x T1 PHY driver"
>  
> @@ -860,6 +865,66 @@ static int lan87xx_get_sqi_max(struct phy_device *phydev)
>  	return LAN87XX_MAX_SQI;
>  }
>  
> +static int lan937x_tx_read_status(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_read_status(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_read(phydev, LAN937X_MODE_CTRL_STATUS_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret & LAN937X_AUTOMDIX_EN) {
> +		phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
> +		/* MDI/MDIX status is unknown */
> +		phydev->mdix = ETH_TP_MDI_INVALID;
> +	} else if (ret & LAN937X_MDI_MODE) {
> +		phydev->mdix_ctrl = ETH_TP_MDI_X;
> +		phydev->mdix = ETH_TP_MDI_X;
> +	} else {
> +		phydev->mdix_ctrl = ETH_TP_MDI;
> +		phydev->mdix = ETH_TP_MDI;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lan937x_tx_config_mdix(struct phy_device *phydev, u8 ctrl)
> +{
> +	u16 val;
> +
> +	switch (ctrl) {
> +	case ETH_TP_MDI:
> +		val = 0;
> +		break;
> +	case ETH_TP_MDI_X:
> +		val = LAN937X_MDI_MODE;
> +		break;
> +	case ETH_TP_MDI_AUTO:
> +		val = LAN937X_AUTOMDIX_EN;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	return phy_modify(phydev, LAN937X_MODE_CTRL_STATUS_REG,
> +			  LAN937X_AUTOMDIX_EN | LAN937X_MDI_MODE, val);
> +}
> +
> +static int lan937x_tx_config_aneg(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_config_aneg(phydev);
> +	if (ret)
> +		return ret;
> +
> +	return lan937x_tx_config_mdix(phydev, phydev->mdix_ctrl);
> +}
> +
>  static struct phy_driver microchip_t1_phy_driver[] = {
>  	{
>  		PHY_ID_MATCH_MODEL(PHY_ID_LAN87XX),
> @@ -894,6 +959,14 @@ static struct phy_driver microchip_t1_phy_driver[] = {
>  		.get_sqi_max	= lan87xx_get_sqi_max,
>  		.cable_test_start = lan87xx_cable_test_start,
>  		.cable_test_get_status = lan87xx_cable_test_get_status,
> +	},
> +	{
> +		PHY_ID_MATCH_MODEL(PHY_ID_LAN937X_TX),
> +		.name		= "Microchip LAN937x TX",
> +		.suspend	= genphy_suspend,
> +		.resume		= genphy_resume,
> +		.config_aneg	= lan937x_tx_config_aneg,
> +		.read_status	= lan937x_tx_read_status,
>  	}
>  };
>  
> @@ -902,6 +975,7 @@ module_phy_driver(microchip_t1_phy_driver);
>  static struct mdio_device_id __maybe_unused microchip_t1_tbl[] = {
>  	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN87XX) },
>  	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN937X) },
> +	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN937X_TX) },
>  	{ }
>  };
>  
> -- 
> 2.39.2
> 
> 

The patch looks OK.

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

