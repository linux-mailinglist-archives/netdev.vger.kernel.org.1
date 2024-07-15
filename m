Return-Path: <netdev+bounces-111627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C810931DA7
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5101C216D3
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 23:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB2F140E3C;
	Mon, 15 Jul 2024 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfqcbhKh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98260208A9;
	Mon, 15 Jul 2024 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721086632; cv=fail; b=i9VvdwNtUqnGzGF/6F+vZs7jwdt5k7kkIyQ4rJ56ablZz4Mk6WGFRBOX/gMmlL0s2jkYjTggGA/rGKi8jBeTo/avrHz+ped1sIepgoTJMruKEN/RO10927FjwG1E4CHdVvEMnsZ7xwNqpflRi9CdQq3Ye1XEP6qpCN402WUB6lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721086632; c=relaxed/simple;
	bh=oaNZ7lyYEnFlaDLM/70L+vdN2NXXNQ0WzqXscr974v4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g5R3W9+J83WLuQPmbv16rxkdUbJNECK7zYAz8Ne6U+P/2uIJEs+TVH3ZNEF6Z0ahnZDIlkFd6nEnuH51UlwI6yP+5IKYkKKqdbfP51kkqD+dt2OiDCq+fd9nzOS6t4NHdd5Mom14oLDRC/V4/XdE7sdeuCAGBx+YhFNZEuudQi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfqcbhKh; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721086630; x=1752622630;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oaNZ7lyYEnFlaDLM/70L+vdN2NXXNQ0WzqXscr974v4=;
  b=CfqcbhKhJZ7ce4nWzjW62KMu+ItVro8HA5spML0oBK2DhNeumeoX9x2+
   l2LK9WElEL7qExT5Oum76EpShgPBVgRqd5AhgeMO3r21aHtAYL3TEbw5g
   VMH6pZ0auJWaUit0uCgtBhIlIyIB22Ud5D9V/9gRZsrVMDo1GbK44/Hzc
   SV+CMakuRku3fSbThswcoF9k+9MhNWX5luB9qvZpWbx5H4+Tu01rScNiQ
   HlYTL+gqWNNS9dXXcuGXDuKmz0qkJycStaAnLKww5M8wONFZFrWZoD7nR
   OPPwW+GcyYm4MslNlhvZAy7SXzvk5vHr3pyzjKDXh4O5kzS1pWUHdF/vI
   g==;
X-CSE-ConnectionGUID: DiF1KkzsTNeIJAI4/q0mFQ==
X-CSE-MsgGUID: 1M7YDVIfRU6NVqPfNy4pIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18342673"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18342673"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 16:37:10 -0700
X-CSE-ConnectionGUID: JcJoAUndS1yJJQiLEpaGMg==
X-CSE-MsgGUID: OWp2iB+7QcO1HwURDebsDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="50426922"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 16:37:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 16:37:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 16:37:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 16:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/O+yh4FDOq/jyXNwPWcxWIPqwn5zEixwwcsWNb+5f4f67lB1NMlRQVomF1GFZFAILAjugkNTvTctk2hHjYEZVjhE4O+HqDuqjdIdPF1mnd+lvI9oB6qK/pJaHjcbo/ha2HGcUE7nKo65c0pGCoASlPu098PaHosvHQFvLn3EUqPD0Re6O53F6A0VX9wNRY/DdVjjlkz1/KEvEmZ6Qop5gId7PoxSxYZmvfO4i0yDh/69QUVjyXZqv/ZDyonqR4P5tCjQrUensMu4zlOUON1mzbiBkkyNHuom1TcZeoKlMP9k6cpQHscZwX9IVaVn2m0wvTx/PLDeLRO9LPQwk46Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu1CmHW+XOGkkS9rgDEDoe8O+MuuIKz9dn2BAF8hSkc=;
 b=U0ns9b6b03PGLc01k/16Mu6X/yJ352Umfa2vsqpitgazncLxWRr8EXXpmYNUQBjG3exFLak9cwv2xsndeHMZT6CZkO1iYrT5wngYKeHj8cbqjo0wJXMfGMJLR4WyiyGNIBTgWYHMylCSgZVp+uI/KXUmZjdG+wOAbLI0Rl28IO0I1vttXvOq2L6OI3ldffIkd+2qvaCi8q/AHx1W6jdAJ0V9+FZsbnIiykjvj6cGx5IdxRWdfCTU8lt67NuH7YjNl6/iVtRj7fCNQ01heqLbUBCMBlPaabRjfjx4Q+jyp954oBwQA+w1o1muHE+9EIp36zEYnvMkNiNgOqKCMiy01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8659.namprd11.prod.outlook.com (2603:10b6:610:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 23:37:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 23:37:05 +0000
Message-ID: <39c7fe45-fbee-4de5-ab43-bf042ed31504@intel.com>
Date: Mon, 15 Jul 2024 16:37:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 04/14] net: Change the API of PHY default
 timestamp to MAC
To: Kory Maincent <kory.maincent@bootlin.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
	"Heiner Kallweit" <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, "Jay Vosburgh"
	<j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>, "Horatiu Vultur" <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "Simon Horman" <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, <donald.hunter@gmail.com>,
	<danieller@nvidia.com>, <ecree.xilinx@gmail.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-4-b5317f50df2a@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-4-b5317f50df2a@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbbd625-c7c6-4fe2-4214-08dca52708d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTMzemhFN0dpM1NXQngzKzJwZUxDUzFOS3NZVUFaQm51KytTWHBFd1ZyVUVD?=
 =?utf-8?B?WjBRVHRadkhDazVZY3IvTDVmT0l1NDM3UC9FZGJjemIrS04vanh4dThwKzZT?=
 =?utf-8?B?UHlKaDVSUUVTWnNMbGY3Q2F2bENTWUhKQ2YrVkxsdHJ2K1NUTk1hYTF3Yzdi?=
 =?utf-8?B?T0l5MWo3ZjkxQWd6ZkVNb2x3WWtUblpzVzJXVVpaZ0ZESE5VdGRpVC9UWkc0?=
 =?utf-8?B?eE5nZEhMUTBQdWIxOWo4SEs1N0ZHK1hQazNwbloyTkVXdjROeW1XNWY1dk81?=
 =?utf-8?B?NlhEaXBKNFloeTgyTzc2cExGZmVkbXg5ZjI0NStZU3VybDcyaVZpakJPTXcx?=
 =?utf-8?B?VlFiYUNjdDVRaUNsZW5FUEVxcFNaZFhSTEJOckk3RmhrSHFWNjBHT1l4NGdS?=
 =?utf-8?B?Y2pnT2Z2VEVvTnFOK3I3ZjgyZXJnUi9mdE9qZnpRSTNGYzhjTzZrLythL1Zr?=
 =?utf-8?B?MDNNbHNaYzFhUTB1SXNtTUVwZUYzMU80YWw4dU9XYVdybDRiekZYdkgzcnps?=
 =?utf-8?B?VlhCZ3VIejBiY2ZGZDRnOEZnMDFJK3lDSE03SWhMSkpMQnFaSnhmbmMrYmR0?=
 =?utf-8?B?YlRqTVJGb1VZY3dCQnJUdHFpaU0wbFV1YTRVR0kwWkN2ZURLcFpiVDVtUmxI?=
 =?utf-8?B?dkYrSWtwcllsZHRCM1FVbTIzR29vNnhGU1hKUzV1YVBVdXZoOFB1Vk1FWkp4?=
 =?utf-8?B?dkRpQytudldmdXBLZVh0eVdrWDFNNE9TNGk0RnJhd2IzZGQwVXN1Mml0bzds?=
 =?utf-8?B?WFRJUDc0ckdXMGRHS2lobWdFWTg2VUZuWUxoWkU2anRzVFd4dDVLRDRkOHNX?=
 =?utf-8?B?WFMrTzE5YlBnMkVDU1l5ZW14b3pSbUx4czhxSjloWHFqNlMzTXhlM0xUZXJx?=
 =?utf-8?B?RnNUZkhOL2Vld29qZ3oraGtRcGFtdkNoblYyRytuL3hhOG5wbE5KSVg0dkdF?=
 =?utf-8?B?dmxqYlY0R2Z4b0VmT3E1MjlxZFdDVE93WERLWm1pazE1Lys4cExaNHVWM29R?=
 =?utf-8?B?LytraG5hSEc0dVFBMk9HZ0l0dVNnaWR1dGNyaVR0ajhkMWFFTTQvRkxFYVFG?=
 =?utf-8?B?eE95MzNITWpHc3NHclp0M3lHdlhwMjBvYVZrbUYxMGs4VnF5bzJPUjBUVWxC?=
 =?utf-8?B?SnZRMXJyN1k1QStNRGZxUnNwQTJobFVCbmVidGV6UUlvZTBxUUxJcFoxN0Zn?=
 =?utf-8?B?d1ZvM2sxSXdzYWo5STI4OWltRzR4dmVzOERpVmt2L051dDdVVnZUbmpQU1hq?=
 =?utf-8?B?YnNWd2Q3alZOMC9iU3UyWmxnSVZIdWRsVDZSd1cvRUJFTFBNbUdNSmlYNlVM?=
 =?utf-8?B?amdBSWJrUEpJVjJ3c0l6MFVCNitHVG8vWHFPK1JzUDk4amRENS9Gd3NDOTJZ?=
 =?utf-8?B?VTNmUHJSN05OajlJeDYvSm1nWGlab05PaEdjNW1XQVRSOHEvd0FRdkdlY1lR?=
 =?utf-8?B?QlE5QTJZWnE5aVZhVjlVemM1d3ZzcmFxWXB1bmN5LzJtRTdwWXpMb1JFUG1L?=
 =?utf-8?B?dG1Wd1B6RlZESUNyQ2F5Vy9PZG9TYkZ0Zmcvbzdpa0xRdm4wYVYyQUdHSC9M?=
 =?utf-8?B?WmcvaTZYQUtFRGQyaXhUNTljcnMxYUhsN0NMak5DQzFDKzg0Zmc1Uk9BZnFB?=
 =?utf-8?B?TjN2c05uMmc4M0hFL1FtSTJ1Zm83VDBoUXNKdlI3dzBzSWlrbEVqR0hDV1hq?=
 =?utf-8?B?bGo1aWhFMDhqQ0MzN3NGZnprbW5qdXdyWDEyaFJQeWpiZ0ZUaXVsOURITzJM?=
 =?utf-8?B?Q0lMUkNGRzVyY09DcDFSb0FjSFdlRFNXZ1RVNmFOSm9VdktXdkdqUE1OSlF3?=
 =?utf-8?B?NkJ6NVpJYmJWcmdwQ0U4NG9NT0FoQTJoTzY4OFJYY0c5TllDNktwbzN2YlV3?=
 =?utf-8?Q?iEOdYYmBqjPHC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NC83UUJIT1NLRDdsa0JvMjZ1dkNVby9hU2xkWEllM0pUS2I2cDJkcnJxVzlL?=
 =?utf-8?B?OVNUMlhLZENEdld2UjhkV1VpdmhsQmM1Ymd1MmtucnNQeVhqd2pqMVVUaHk5?=
 =?utf-8?B?SnR4TklkYndkUmxXOEZrbkVCRUNOY2tFS0xUMXFubkJhclFUSmdrTHhhUi9L?=
 =?utf-8?B?c3hxSER6OHI2Q1NKQUxRMjJMWkQyYnhTR1YzUzhSbDVsa2QvMVRoelhteGNt?=
 =?utf-8?B?UWxMZWFjVlMrblE0Z1pCaExXL3I3UWxNL09SZGNVVGJjODI3TFE1N0V2MTFQ?=
 =?utf-8?B?YTNnOEEwOWJKcXQrek9PTENzcGRvWmtLcEVIalZVVk9xa3NvOGZrKzdUSXdT?=
 =?utf-8?B?Mm9tMHFwZmtodDRNaEtKdEw4VWFmcG01ZXVPakN2aVFUSmUvdnJCZ0xHZFIy?=
 =?utf-8?B?NHo0cG9wYmh3cEE3VnJCcDM3ZDNoYlJ2dVBDMGZvWHR0TDBDQytrbUd3My94?=
 =?utf-8?B?cERGZ3dBYXVxM240V1dZWXZIQnNkWEtIamJKOHRYZkhHQllEemkxVmFxY0F3?=
 =?utf-8?B?Tm5UU1B1em9jU3pjendobytmcWd5aVhHOVphMEY0TEh3N1RjYWhmZmsvTGdL?=
 =?utf-8?B?TnlUaVE4eGJ4Yk1URjVDajdReERtTFJQSG5NYldCVTNBVnhMMkFBUElsWVlx?=
 =?utf-8?B?N3NvZG8wWmI5eWZPRnVud2lZZThZcWVKNzE4T2pwNDIrbnFXRkcxbnA0aWNZ?=
 =?utf-8?B?VjBGOVNCTUhtR1lvRFpXdmgvNFQwZnVlU010U2JPT2ZhTHZHRXRaOWo3T0ow?=
 =?utf-8?B?QSs2K0E0SkZ6SGwvWC9rVGZ2WUY1YitlcEpqcEFSdE9PQklUc2U4ZXkxOWhE?=
 =?utf-8?B?ZVY0MkZ2QTBZekQ4a0FOOFJIMDlWVVZ0QmZkbkp3WjJvSSszMk5jZi9lWklo?=
 =?utf-8?B?clJBdnR0cWtLajJlOVlxY1NpWm5yS1dKTmhzRGJpaTExU0JJOTJSWkVuSFdC?=
 =?utf-8?B?WndLcERDMVRsN2NkdEdMU0V2ZDFETzdKRnFhM3hMbmd1SmJaMzRadi9zMVlL?=
 =?utf-8?B?MWROMzhYMjZDQWdJejJoNi9KVzNwNDNyVE1TNitvRGh1eXQwVG41Q1hwaWZx?=
 =?utf-8?B?YTNjM29aaFkyd2R0WUNWUVFaUTgrWm5GK1BEWHRPWWtGbWt5bWhOQzIwYml6?=
 =?utf-8?B?dWhnRXpUbWcvaFVhbnRvYS9DVlg5eDJrOEZSaU5ZUG9JNGlmYnJBZXpJU3V0?=
 =?utf-8?B?ZmFLcHc5L3BGbXhlSHhlMzN3YllrS0RnMkdWbjRQUnltVjh0dE1udjZXbDFs?=
 =?utf-8?B?ODh0VERmUkd6VGxXUmxRd2g4WHZTNURhV3pFU29EZ3Q1cjJqS1pOd0JUTS9Y?=
 =?utf-8?B?QSthVXFxVDlNSnkweDh1dE5Gd21JcWtvT2V5NERTQUVSbWtwMUg0cXdMeEl3?=
 =?utf-8?B?NktjSEFGSlpYNm1oaVZSa0g4NmI3eXVCcFJGZThoQ0V1WVR3ZzR2VHowWndK?=
 =?utf-8?B?TFlLNzRHeFh6U0NaQ0s2V2VxRG00dUFQclA4OWp1bUhxbDF6U3hocjUwU0Ix?=
 =?utf-8?B?NHVYVnc2RDRwSGI3bDRESlZhOVdvRTJHVUQ2cmRZT3RhWk4wV0dnNzNRWmY1?=
 =?utf-8?B?VkF0YVBaMTRnRGFiVGpLUitpVDFpajVxbVVoNnBSb2dPeTltaDV2TGRYdzFU?=
 =?utf-8?B?NWVXNXV0dzM0ZzNDckllRkozeG51VCtMN3Rwd25RWE1xRXhyTTlxczhFVDRI?=
 =?utf-8?B?Q01kbXh3VWFsSzBqWkFDUmZ4Qk8yL0pQelgxVC91NnFIUCtiSlczTTZQTklR?=
 =?utf-8?B?a2VaN3l1Rm5DUE9ONVM0eWozeTBtSXhBdFRqTFNrQmdVTWJFUFAwbU91dklI?=
 =?utf-8?B?ZFQrd1g0K2xrS2ZjQzdQNUhSR3VESWlrYnl5RTVET014VDlQcUZ0Y1ZTVFNM?=
 =?utf-8?B?OTdvUmtuWUdsOWt3VlQ4N1NDNURHU1FwOVROTzl3L0RIcVZmODU5Tm9Qc2I4?=
 =?utf-8?B?MkNhWERvYTZuS3hGYWFlNUxmRWtBWGM3TFE1Q2UzclpSL0gwdmVnNjE4T2Vl?=
 =?utf-8?B?Nld3Q0ZJb08zVWQ5b0RlV0lxUlVSRWdHR0tZeGVwN0VDWmo2TlRGdlFlQTU3?=
 =?utf-8?B?bDVUWEU3YW1UWVNFOWNWbElwVTF5NkI5UzNJZGtpSktLYnAzNk1WSHZ3VUhw?=
 =?utf-8?B?M3RkZDFXNW1ZdFd3cXZyL05vTlJrSmZJektlRjZYRnpRcUpZWVQ0M0pMTGZI?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbbd625-c7c6-4fe2-4214-08dca52708d6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 23:37:05.1741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpH3kvYL2WslfxlZue/GvUejDmBsJpD8RIbo5x7yvdBqx6S1T/I/QoPcJXBCp4ju9inC7bpQIwAMEB0UDy20/kInHk2UThrecpEIWSCYIQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8659
X-OriginatorOrg: intel.com



On 7/9/2024 6:53 AM, Kory Maincent wrote:
> Change the API to select MAC default time stamping instead of the PHY.
> Indeed the PHY is closer to the wire therefore theoretically it has less
> delay than the MAC timestamping but the reality is different. Due to lower
> time stamping clock frequency, latency in the MDIO bus and no PHC hardware
> synchronization between different PHY, the PHY PTP is often less precise
> than the MAC. The exception is for PHY designed specially for PTP case but
> these devices are not very widespread. For not breaking the compatibility
> default_timestamp flag has been introduced in phy_device that is set by
> the phy driver to know we are using the old API behavior.
> 

This description feels like it is making a pretty broad generalization
about devices. The specifics of whether MAC or PHY timestamping is
better will be device dependent.

It looks like you introduce a default_timestamp flag to ensure existing
devices default to PHY? I assume your goal here is to discourage this
and not allow setting it for new devices? Or do we want to let device
driver authors decide which is a better default?

> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Overall this makes sense, with a couple questions I had during review.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index bd68f9d8e74f..e7a38137211c 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -616,6 +616,8 @@ struct macsec_ops;
>   *                 handling shall be postponed until PHY has resumed
>   * @irq_rerun: Flag indicating interrupts occurred while PHY was suspended,
>   *             requiring a rerun of the interrupt handler after resume
> + * @default_timestamp: Flag indicating whether we are using the phy
> + *		       timestamp as the default one

This is clearly intended to ensure existing drivers maintain legacy
behavior. But what is our policy going forward for new devices? Do we
want to leave it up to PHY driver authors?

>   * @interface: enum phy_interface_t value
>   * @possible_interfaces: bitmap if interface modes that the attached PHY
>   *			 will switch between depending on media speed.
> @@ -681,6 +683,8 @@ struct phy_device {
>  	unsigned irq_suspended:1;
>  	unsigned irq_rerun:1;
>  
> +	unsigned default_timestamp:1;
> +
>  	int rate_matching;
>  
>  	enum phy_state state;
> @@ -1625,6 +1629,21 @@ static inline void phy_txtstamp(struct phy_device *phydev, struct sk_buff *skb,
>  	phydev->mii_ts->txtstamp(phydev->mii_ts, skb, type);
>  }
>  
> +/**
> + * phy_is_default_hwtstamp - Is the PHY hwtstamp the default timestamp
> + * @phydev: Pointer to phy_device
> + *
> + * This is used to get default timestamping device taking into account
> + * the new API choice, which is selecting the timestamping from MAC by
> + * default if the phydev does not have default_timestamp flag enabled.
> + *
> + * Return: True if phy is the default hw timestamp, false otherwise.
> + */
> +static inline bool phy_is_default_hwtstamp(struct phy_device *phydev)
> +{
> +	return phy_has_hwtstamp(phydev) && phydev->default_timestamp;
> +}
> +
>  /**
>   * phy_is_internal - Convenience function for testing if a PHY is internal
>   * @phydev: the phy_device struct
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index 6aaa8326bf8f..36cea843381f 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -259,9 +259,7 @@ static int dev_eth_ioctl(struct net_device *dev,
>   * @dev: Network device
>   * @cfg: Timestamping configuration structure
>   *
> - * Helper for enforcing a common policy that phylib timestamping, if available,
> - * should take precedence in front of hardware timestamping provided by the
> - * netdev.
> + * Helper for calling the default hardware provider timestamping.
>   *
>   * Note: phy_mii_ioctl() only handles SIOCSHWTSTAMP (not SIOCGHWTSTAMP), and
>   * there only exists a phydev->mii_ts->hwtstamp() method. So this will return
> @@ -271,7 +269,7 @@ static int dev_eth_ioctl(struct net_device *dev,
>  int dev_get_hwtstamp_phylib(struct net_device *dev,
>  			    struct kernel_hwtstamp_config *cfg)
>  {
> -	if (phy_has_hwtstamp(dev->phydev))
> +	if (phy_is_default_hwtstamp(dev->phydev))
>  		return phy_hwtstamp_get(dev->phydev, cfg);
>  
>  	return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
> @@ -327,7 +325,7 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
>  			    struct netlink_ext_ack *extack)
>  {
>  	const struct net_device_ops *ops = dev->netdev_ops;
> -	bool phy_ts = phy_has_hwtstamp(dev->phydev);
> +	bool phy_ts = phy_is_default_hwtstamp(dev->phydev);
>  	struct kernel_hwtstamp_config old_cfg = {};
>  	bool changed = false;
>  	int err;
> diff --git a/net/core/timestamping.c b/net/core/timestamping.c
> index 04840697fe79..3717fb152ecc 100644
> --- a/net/core/timestamping.c
> +++ b/net/core/timestamping.c
> @@ -25,7 +25,8 @@ void skb_clone_tx_timestamp(struct sk_buff *skb)
>  	struct sk_buff *clone;
>  	unsigned int type;
>  
> -	if (!skb->sk)
> +	if (!skb->sk || !skb->dev ||
> +	    !phy_is_default_hwtstamp(skb->dev->phydev))

I don't follow why this check is added and its not calling something
like "phy_is_current_hwtstamp"? I guess because we don't yet have a way
to select between MAC/PHY at this point in the series? Ok.

>  		return;
>  
>  	type = classify(skb);
> @@ -47,7 +48,7 @@ bool skb_defer_rx_timestamp(struct sk_buff *skb)
>  	struct mii_timestamper *mii_ts;
>  	unsigned int type;
>  
> -	if (!skb->dev || !skb->dev->phydev || !skb->dev->phydev->mii_ts)
> +	if (!skb->dev || !phy_is_default_hwtstamp(skb->dev->phydev))
>  		return false;
>  
>  	if (skb_headroom(skb) < ETH_HLEN)
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 6b2a360dcdf0..01b7550f12c6 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -637,7 +637,7 @@ int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
>  	memset(info, 0, sizeof(*info));
>  	info->cmd = ETHTOOL_GET_TS_INFO;
>  
> -	if (phy_has_tsinfo(phydev))
> +	if (phy_is_default_hwtstamp(phydev) && phy_has_tsinfo(phydev))
>  		return phy_ts_info(phydev, info);
>  	if (ops->get_ts_info)
>  		return ops->get_ts_info(dev, info);
> 

