Return-Path: <netdev+bounces-122225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9DA9607C6
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5061F2347F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2890E19EEA4;
	Tue, 27 Aug 2024 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQqrqv95"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360D199EAB;
	Tue, 27 Aug 2024 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755568; cv=fail; b=QGTvwH6RCDH4UAzwkewPq6z58n7awcOBrQQxqt/JcOK7oKEN2NS77EDZrLKSc6YKyJRO+JoasfKt5URHWIMkGI0YIlIbSVC4CrX3ksSk5nRON2TGkT1kVT3D84LlScX2bQOjmB+2aFkBFFiRVAK60fFnEv0e88wmUlNKQdAUdvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755568; c=relaxed/simple;
	bh=J35BziznWuRb+J80n+Yz/WWFz6++ixMoBnZmgm3UVVQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BvXSAHPOV/SawUA5I9YQwJxXzH8GhoqH86ZcubknDZR7VzDs9Ric5/Ssw1BMBPXZFtsbXuPo++9q293VOt79usYtgMoztoUwvOIdcaz6qddUKyYbBBvmLq2AhfNXCct7iDinem+7i/ri0yMnuCi0/ri7qHaF56h56BOkTgC7txI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQqrqv95; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724755566; x=1756291566;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=J35BziznWuRb+J80n+Yz/WWFz6++ixMoBnZmgm3UVVQ=;
  b=MQqrqv95jsgmNg/Bw+Wy4t52obtTI4bGeb2st9KsnkKI57sSAa3o7rP4
   8t/kUG2qZKLj5AIp/2VTsZ7uOByeHOxSH0MMV3bZBXGoAZ5cb4wm+vP1t
   NyfdHyyoU9naIpfV4rI5nb5UAWNFi35P+upEx2ZDEx3zjjVkENmopg6B6
   HboCVCCGf7I28m1Ue59YXFvdRQHHbGkEhA+8C1G8blFPzqkdEIlSPGrGk
   SxPFs/a1Jx70jfIYdy23iXPCIOK6LW2qsMWk641EaRiYGoUj3bzCDvtaZ
   CFg1oeLenuBwOjoBRJYNrHMnFayriSLXOo9DxNT2J+yuL+/vB+m8+f7uW
   Q==;
X-CSE-ConnectionGUID: 0b8vFLsISlSMMoSGK5N22g==
X-CSE-MsgGUID: Ys0Ug5BzTNe2YXgugPDiNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23384668"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23384668"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 03:46:05 -0700
X-CSE-ConnectionGUID: jsuQ+mx0RqGVVtPV6uOL3w==
X-CSE-MsgGUID: 7Slkxv9nT5G0HztXLelw9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="63136651"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 03:46:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 03:46:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 03:46:04 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 03:46:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/VbwZxOVXIC+r0iNs2VgXHjLj5aqthHKYBomvTM8q1n4erYaPX7ktgX5SNYKfrzGG1XkixYxpyUVa5me4H2VojOvHGOv61x9kG+KZlkbgnJILVPQ3zq8Jorwh3PeWiHi7OVxmHF1bGf4w7bvRSq8/b97qX7AWR4/m9d07u44QyETaVC68xgLz5TUxbhevCdXuagkladMVkcyPC6E8h3TBWlqhEu1kaL0OF1RShqcJf72MBtx8Zq8sR9IGsrzTydm0EZ7C2pg7GVXPJYjlHWimfysOlB7THtlS7uZIZ1MdT3fCqi+OdpNIp6as0bZnFNrZDDnwCVLaixWpggs/KsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9OulitBwXIOXWTXUwyzcuWG4QkJHDiXi2oXb99tbrY=;
 b=EOj9HlHcJYdoRxCYoN9Tj8QY0iUHXJ94g8BUaZI8nWDIoIpoxU4GkFyKCD2lrpRjnbtRLFDbK6N4kwUUU62l2S7hR2w8jkUEA2uwL5GOR5YmnyWP1jnixAZIq3izB3ZrCe1q4BBxpi3hXmMKGKkD2dWCvgjYQKAs1RJ8FljrXJ6FruLDjEq7LMXJdvWuQdxPvPesilrrI0cM1LhP/f3UBYXdR5C4LonZYT/RQrJI13Iq0b4Q++AXJjjK7pflqSxy4w73Y3lCsju+i85qIsUHtcaAav0+PQjasBcpq/o/FlC7gUORvCCiiTYGPqapS0IrOcBNJXmLL7XtBMaUmmmGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ2PR11MB8586.namprd11.prod.outlook.com (2603:10b6:a03:56e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 10:46:02 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 10:46:02 +0000
Date: Tue, 27 Aug 2024 12:45:53 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>, "Christophe
 Leroy" <christophe.leroy@csgroup.eu>, Herve Codina
	<herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>, Marek
 =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>, Oleksij Rempel
	<o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>,
	<mwojtas@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>, "Romain
 Gantois" <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next] net: ethtool: cable-test: Release RTNL when the
 PHY isn't found
Message-ID: <Zs2uYVvjcHFZoVqX@lzaremba-mobl.ger.corp.intel.com>
References: <20240827092314.2500284-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827092314.2500284-1-maxime.chevallier@bootlin.com>
X-ClientProxiedBy: VI1PR0102CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::30) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ2PR11MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7d2a12-8194-4b26-0e51-08dcc68571a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GtuFXo2kGA2Z5Tdwc+p89d21XMR6OgWOOpLk0tPFC4U9ZY0+XCUneTcpv2ye?=
 =?us-ascii?Q?VajCvzlvLZ/GSK0D3ubGXFcf88M5ZMmR24gkku7hGwXfwlrYvI9wFFNxGDiJ?=
 =?us-ascii?Q?jrawRMjIZeMFkJ1jnsMvPZAQZPzf9B023HUH41I1pAIRjDImA34JW5049OiN?=
 =?us-ascii?Q?O2qB217UY2xa1/NS2mQFA5u4NHBrwmRqEN/S8I6Y952kZa/WaL6BGlbNQk0K?=
 =?us-ascii?Q?qq6/YfFKU9QAUyn6bzq+IvUNpb2/3I1va2sI2E8N26NPa5broXsfMkD1IwQS?=
 =?us-ascii?Q?6ncsFOcikNeCKy0UltRMW3ys7FozDdG6Yw0mIoR5ehpS/wzGYxgPSApR1zg6?=
 =?us-ascii?Q?MfHCgtvV4qw22GFPSSvqLhsAyhyoxJlwp5S5T0fduMN6Qzv7C7R/jBGCSN2G?=
 =?us-ascii?Q?Y8GRi7dUl9c2JOn59Ezya5OIEO2FQMBmHED6q0zTi7Y7unSnI06AkOs/xm9A?=
 =?us-ascii?Q?z6wYKTObm5EyFQkAZddKqrxH0OBuj8kH0GEwQ9b0zQTt1N0Jf7UjLFN6gwz2?=
 =?us-ascii?Q?dSbsHXqeURYPNTy2sHlU6nauD7J+cqt8A1/vZM6xEnoewvhxEyoENXM1n7Gf?=
 =?us-ascii?Q?foY6Sa0576YogHrYeZNMonCMTiVB7EkhJWPcDuahrAgDRSlFjU35ihHqQDSe?=
 =?us-ascii?Q?jm2NCktkhTcafUhUfqjNg/1iw/TZtXml6rqznTjDaf6yLMW6+PbwpYfr43T2?=
 =?us-ascii?Q?z1/LPFxwo9M1p9TibccWCPhsbHndj8Wv+JkVZniZQzWpoz/rV1BRmobXeuD7?=
 =?us-ascii?Q?Mj3HVhpStFqdCcld1AvWKWeqlyNzzRKWn5q+bhiU9cjU/M60VMl+pSLXr5Jh?=
 =?us-ascii?Q?HnlUAUypv9vib31EAb0WlrMhZ0IcuWhaEaTfLi466BlCc1DUc/ov+XulF9h5?=
 =?us-ascii?Q?Sg4Pf2lZ6KPAZr2kPXhMxqARg8tD9dSnlEMN3qkks9seuJ5MjvjGVxTuJZ9w?=
 =?us-ascii?Q?vC12oV5/HtH/YoZAnvV8rNzehcfDDllK/7VkEhVW4kbb4NFW+zJDHkM9ECaM?=
 =?us-ascii?Q?h1jtETAlFP2xiRAIFYNsbgt6IMhNCUjfzSogVsMsPbYSyr9HkTftHq1jM94c?=
 =?us-ascii?Q?ctbLTkjJlZ4pMZ0OhzIDymW2DGUsxnHf14DT49BgyzFWjIAaG0ieOGVn8oIc?=
 =?us-ascii?Q?97xhtqaSQCaG60nRDSk4JhgPh9NkUXE2rLkGDiJACsp47d0Zubxu3++HM2c3?=
 =?us-ascii?Q?Hr/gua0ESn6pe/Y1pUzZgSf9W9hlGGOeDDBZMYOOqdcLU109R8BTkxFBt5HQ?=
 =?us-ascii?Q?7QBTyUZvKyAAecmp92PVdNtfgHZkIn19qC4rYchaiLIlROW69Ji6cPM4mlUt?=
 =?us-ascii?Q?b94=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RosRpPpH4ATn+GdUB84q7wcZwjuoWVgfWdeemWON0LX2btya03u8qxkXyli5?=
 =?us-ascii?Q?yeCOMVeeoCHSuo5IW+nfG7Dxh1c8aAYbuLlG0kxm4HC9rgYdxE43JJwG91RJ?=
 =?us-ascii?Q?OX7SwSzWcGa6OgAFAjJywOYyI/By40/sQPMyJajUCTmMqpWRgFHBKv8dWj9T?=
 =?us-ascii?Q?0Xk18MbiJ/p0Uwt+uQTPBxnjjJjsbRu8iVx8yDynM8k4gLEz/O34MjtsPmSk?=
 =?us-ascii?Q?CjFw+cqAdKL4vSqRhuYkZ2vh3HrU7U3f5wRV447ly/EWqh9TfPf/53cmgaHG?=
 =?us-ascii?Q?QG3w5eGSYdTADnWGaqcWtMrse2/dMB5La0arxYsQnDWVFXbsfNcr19Np1Y4i?=
 =?us-ascii?Q?AYzzySkYfTGunFSe+mcNiIifvh26MAIEQGuQ8jfmeStENf176q0YTlRU3u5o?=
 =?us-ascii?Q?0icstrpoSiUv+9FeyGnMGKXvPO4bdSCDShhPHKJGo+G2jUg8ZonkpHYCGKE2?=
 =?us-ascii?Q?ODrgy9XWNpydW+SJFpXkjf18H8ckau8NJ+MILqLfT0gkUO572pnQvsnUWW20?=
 =?us-ascii?Q?b0BQkXEGg4KN87eWPKZdKANS95GKkLxWq6M+4xOdzSWQGeAGXC/0jlKFl5in?=
 =?us-ascii?Q?VX3p8nXsUgW5v9uz8DnTIC7empIvY+G192rIQSyD2J6TGWlWBqWNE48huu9k?=
 =?us-ascii?Q?4L+GXX1hwqzPitDmLNBvFoyXkCUTGmg6vcO0rTzqBZOjSMhayq/bgbDS7mw6?=
 =?us-ascii?Q?PQrafwjDRbOFamrZ77qTb1IZ6hqrvfXXaB+uM7wc4dYzyywg9oZGh2RSBDVO?=
 =?us-ascii?Q?O3tdlUakFBwPlhVD5dvSx0rzB+PcLPgymwj9wpMmjbKFHp0XoCnrE4tlmX+r?=
 =?us-ascii?Q?YXMaJUa2V6UEKCj5ZOVC6daDT9VqHH63CXEGy5I44L8Z9MKJIYeXSxfVmJJv?=
 =?us-ascii?Q?VluItRXuC4NZ+Y/GoHZN57rZSw9s9Db2cdbmbRYj+CDZTr94BYS2uJT2Z1p4?=
 =?us-ascii?Q?h7epLy/5zw94ov1kzBqQpfbfFiEuToZ/ZagbqWZmRr3qmgG/vrhXWRca5eB9?=
 =?us-ascii?Q?YAwmRuImRSEbyCPnhsmD0yLW4hX4yhBAfx//pn++WAzctZFYDrB8E2gcv8gl?=
 =?us-ascii?Q?uzBYStOT82CWa7FI4SHKRwNLMMI5i9qfXftOJrSIdJgPN0IqzTEzpsbh3iwp?=
 =?us-ascii?Q?ug/3zczHJVNqsXAwtpwS7vrPTSUuZvtBfFqkJC2ESvQ3hDhS9mFnfvAdObzq?=
 =?us-ascii?Q?Nu9JZCOjaZ8ry0OUubUOCWLy/DIc67R+3yrLRq6BdX8soc68aFW2vCHHn4hj?=
 =?us-ascii?Q?dJQOBSGE1oae4jM4+sUCcyvWh1Q80StbZPBTbQYlIMD8zED2RR6u5h9t3WUJ?=
 =?us-ascii?Q?eEzQYY7D0subGNUE42Cg1hVOvWXFZNRO7pgeSEaSPyTJx+UUPfpJ6U1DviqJ?=
 =?us-ascii?Q?QHeSxHuTyLT0XLZ+CjialIU2VXEAdbmn+zxFtkYBA7nSuLIcSIJ+2isZPoyR?=
 =?us-ascii?Q?bxk8fYPmuyGwcgiy229rnsDwKDQqmnmK+W+iyJpnVFyXCC6Wzqz/+EnLPIFx?=
 =?us-ascii?Q?qP93kv6u4i03VrYJRPou8kCMkwHT7kWuLfxjrlGKh8dkeczy+RnsGVXmgdFY?=
 =?us-ascii?Q?SMw1lxtz38RIZD+GmieEeDGe7ghInLXSAtOuZGgB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7d2a12-8194-4b26-0e51-08dcc68571a1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 10:46:02.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwvYjxp517NnTOPI1eiaU3yMhrRPN2mSaWxpqYAwcm4Qr9Q/W4cA9fDSYuBiPXKtoG9n8c0u4kv8F6fyp9LQYKzDtzW3gwkqALuxL2Ns9A4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8586
X-OriginatorOrg: intel.com

On Tue, Aug 27, 2024 at 11:23:13AM +0200, Maxime Chevallier wrote:
> Use the correct logic to check for the presence of a PHY device, and
> jump to a label that correctly releases RTNL in case of an error, as we
> are holding RTNL at that point.
> 
> Fixes: 3688ff3077d3 ("net: ethtool: cable-test: Target the command to the requested PHY")
> Closes: https://lore.kernel.org/netdev/20240827104825.5cbe0602@fedora-3.home/T/#m6bc49cdcc5cfab0d162516b92916b944a01c833f
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>

Your SoB has to be at the very end. The patch itself looks correct.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
> 
> I'm targetting this patch to net-next as this is where the commit it fixes lives.
> 
>  net/ethtool/cabletest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
> index ff2fe3566ace..371bdc1598ce 100644
> --- a/net/ethtool/cabletest.c
> +++ b/net/ethtool/cabletest.c
> @@ -343,9 +343,9 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
>  	phydev = ethnl_req_get_phydev(&req_info,
>  				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
>  				      info->extack);
> -	if (!IS_ERR_OR_NULL(phydev)) {
> +	if (IS_ERR_OR_NULL(phydev)) {
>  		ret = -EOPNOTSUPP;
> -		goto out_dev_put;
> +		goto out_rtnl;
>  	}
>  
>  	ops = ethtool_phy_ops;
> -- 
> 2.45.2
> 
> 

