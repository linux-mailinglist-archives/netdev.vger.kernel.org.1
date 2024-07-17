Return-Path: <netdev+bounces-111912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D2393416C
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236301C212B6
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734481822CC;
	Wed, 17 Jul 2024 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkiKCqQU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997601822C0;
	Wed, 17 Jul 2024 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721237049; cv=fail; b=OdELnUQR38OcHpK529fwPKmAH64aLt6AhVAQny/UEHVsBWWZHROFsRcQvYSoPJzbzkOI9ttcCkpTTsBo8BIPOyLcl62mBjWXxkFHpBPGi/tfqLBlhUCAgYWNCIh/ZcP6/DhKxzQpF4uuzejKGDG48ZVtRGsSnaGln4si65efROU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721237049; c=relaxed/simple;
	bh=XIRIs21diakbDFAmOMj/6nHPu8yFnJBdaMlG4RfgFS8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M2MEGInEhPPPBUGltO0d7HXIYfp3QMulbWYL01LnfR729dpx6E3egsZdOw8hGQcLP/4jHsYYmr1whNKqWvowFibWcWFNTzPgdaokMBvDnLGOLKRtf5h4U23otaC3n/JZKofuxjxVEDYzMDd77GliSXGu62wCcd1RfMu7V75hePI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QkiKCqQU; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721237048; x=1752773048;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XIRIs21diakbDFAmOMj/6nHPu8yFnJBdaMlG4RfgFS8=;
  b=QkiKCqQUVG7d9jAgZyBSswRWx2O+/Igg7b8XWaPHXT1o1RMkIyVqRiDM
   IJ6UezqsimCGA+wp1XF2cD5C1fGkB5XSvha2cJ14yQjvUamKcPnU59s+V
   ndJ88DYaFdq8sOPx6F9m+J1W03anH8SzefoMQ6TFqRhIpLveuUhDcojGw
   k192aoEQzYnpFwBBNLnoavQQWNpS/zXXsXM5YciH4UHrelRpmKMl7OkOa
   pdtxG9EiyxocBtEc2RzCKoiBM12UwcKHleTIZdJzgtYZMLkQP/98IrklC
   E8RgGTSrSNWasOqxzGHWiori43npmc27CwuccdTbdf8q/85y7D76e8APC
   A==;
X-CSE-ConnectionGUID: vpEuxAz1SeWlcHHtKaH8AQ==
X-CSE-MsgGUID: wEhQEUweQWCXNLumVgtZDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29338542"
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="29338542"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 10:24:07 -0700
X-CSE-ConnectionGUID: 8IoKFOT+TXuyFS5vRIFphw==
X-CSE-MsgGUID: 6axVA+/OR2OD1BgzbpBMKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="50234043"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2024 10:24:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 10:24:06 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 10:24:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 10:24:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 10:24:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMYRzFoHNBSu2ZHdCSli/Ix5p6tT57LlqfGb6kXiWBTMO1V2NDdKStAov9uKN5MEkYMfzRZ5cI/W7oP5pfIkJNTTUp0FCZMLIRTJrbjA0s2TezEObwbuuROSood90+++AWDPE81cmZ/1uXAhFzNPWnXkh/ggXWItpziMSCuSC/6iTra2nqo5HhLCibecvK4KmYKUlcoRvEW1NeynsfqV4njqhLMMJ2Q74NNjvfHrFzvU17VAGaz5TR9WPNqb91auYMIhbYW2UGFA89UVbAQuWbFhWUDShmzsLJ0fRKL1GTBArKbTQZ3kKADs4LBJYMajEtlV+SC/L4fu5HqkqRyjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CX+Qm09oKTvaAu8ZZVtxJ7kfFRQZdfb1O9Byv0Sn5ro=;
 b=Url6/XqPANIiJX0GNTR7OlAu37sunE93Ka6NCZhPTbQX5GkCOcNFzMXYzfwuT51T5rf57tA3C0VLx7yEtKEV+19jNCgUHS1mCBET9oaSKBJItO/EvTs3GszTG+dtCycc0l9ai5+8AKWDfmSe7Gb4Wee0p2WoOwLfB9Mu5/9M6jtf7xeS1lW8/lBeQQoWwRXNIMtPghuhKbKrv8E+6K9ismMxmlEvuvSZyptJUQ1bboKI0nqj794hlWH1c0oCMbFJiK71V/+zIvpyb5tAbeUfAQ5foTYW5zsLg5fVcnCKnXf/cnfhjQ/IFaAj/F+BcVeIQqL9U7uWmKY7Nygj3a4m0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB8537.namprd11.prod.outlook.com (2603:10b6:a03:56f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 17:24:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 17:24:03 +0000
Message-ID: <dfe37e57-bdd7-4870-b453-b83ee977b8a8@intel.com>
Date: Wed, 17 Jul 2024 10:24:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 10/14] net: macb: Convert to
 netdev_ptp_clock_register
To: Kory Maincent <kory.maincent@bootlin.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, "Radu Pirea"
	<radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Horatiu
 Vultur <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>, Simon
 Horman <horms@kernel.org>, "Vladimir Oltean" <vladimir.oltean@nxp.com>,
	<donald.hunter@gmail.com>, <danieller@nvidia.com>, <ecree.xilinx@gmail.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-10-b5317f50df2a@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-10-b5317f50df2a@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:a03:54::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a79b35-59cf-42c1-3ca1-08dca6854147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDdSck9QcHZWWVpyZTdDOEJIdVphajkzK2tVQkVHWEp4d2VkUUl2TGxXcUxO?=
 =?utf-8?B?em1Cc2g5T3lTT1JsT2o0Wnd5cDVuSXY0VWZhTUFNWXlUQlg0b3c3RE5zV3M3?=
 =?utf-8?B?R2JhTTd4RHk2emo4ek5xQjRiaGF2Q01MejJwRjUrM2IxUTBSbkwxY0tjNXEv?=
 =?utf-8?B?NDJtZ3dGUjNROExIYjZzTUdxS21wbWp0ZWlRVThET2VvMmYrbVJQSEY2RUJr?=
 =?utf-8?B?OUs1Um9zSFkxZjgwSTNKV2FlTnVrN1Vod0hITGV4MDlnVEVMdnpqcUZ0OWkz?=
 =?utf-8?B?M3BjcDRXU0xoYkU5ZnVzWUtiMUxOWDVpdXpxNHZ4Q3pRUk1lMEplcEFibksy?=
 =?utf-8?B?NTVVK2g3aWJidlhkR2lGdy9NRHQyZFNmWWNMYyt6UkMxb1hWMVFNdW9lZ3d3?=
 =?utf-8?B?dUI0MUE1YlU5SDdNek93ZDFWYzl4d0lLZGZJZEd2YlZUSkN0R2l0SDg1OGJ3?=
 =?utf-8?B?R2tBRXpUVlJ3THNuMUpCYkJ6QlRDOHVjaWpkbkd5VnRFQndWRlYzeEQyTnF6?=
 =?utf-8?B?YTQ5OS9iOEU3Y2w4WDlXd0Z4Z2Q2SUFrb0FtU3RqejhVYWhRQWQ3MmxCd0pC?=
 =?utf-8?B?S0MzQS9qcjBtQW1SamIvY2RyOUNaT2NKSStBbXlMVktUODRMNy9McE9hKzRD?=
 =?utf-8?B?d2tkcm5WcFVMNzVuNGpyLy9OYmZOZDE2SDR6cnc0bCtIeWZZTHUreUpCUnZC?=
 =?utf-8?B?Tk82WWQrS3JQdU1XSjNRN1JKb2hUMmhVRFppbGYxWkQwNDRSTWZrK0w4R3lq?=
 =?utf-8?B?UHYrYzU5SlU4aVpnZGVIUmlCSzFmNGpieGlma0N2TUU5VzByeStTVlEzQnJU?=
 =?utf-8?B?VE56bE5lNXYzTHhvazRKdldEWk5qVVdoQ29XeGhQajdJdGxLS1RzMUxHbVlV?=
 =?utf-8?B?eG1DNWtHaFA5bzNqTHBob0p3UjdjaVk3OTM2eURKS1Zoc2Jibk9zRVNKTGNz?=
 =?utf-8?B?UWlVWE9VaXl4WWltM1B6NEd5cmlkRjFNYUNwQ3NmNVBJMU8zbmVVclgzR2dq?=
 =?utf-8?B?UVp3bFp0a3NJV0V4a3RNVCsrQ2Zid2F4bHlIaVM5MWNaa3BQQ2VEVVpwdWR4?=
 =?utf-8?B?bFllcWlwTzFoTVNOdE5KZ2huTmJjcmNNNG42RXFZUUR1djB3eVY3VENjUHBT?=
 =?utf-8?B?NEVxVnJ0TEFnNkQveDdyeEZIbEZKN2FlQjByLzlKM0tuTGFvVDU4alRCTllO?=
 =?utf-8?B?TVpaa0llVWt5S3hWQ3NnVE45ZjIvUEczbXJTb0tJTVpGdUhKUkE5Mm43K3Vu?=
 =?utf-8?B?SlJab21zUUdrdzcwcm1zOVhFWVAxbjFPZ3FBb0pmK2NqejFQWndsbWVIWnNO?=
 =?utf-8?B?VWhJdWtCd0pYczJtaThTYXhaWksxN1kzVTRLd3d0dFlZNFBaTXc4eG5jeVRq?=
 =?utf-8?B?bDc4cGNvcHBuc2ptZUZkYU9BM2NlaWI4TVplajlESXkvSk1sK2JSRnBZTkdy?=
 =?utf-8?B?VEE5WDFqK2gvYjBMQ1YxZGRLVFZ4MEFldUhSaURPUXhJd0tEQnphUjB2MnA5?=
 =?utf-8?B?RUlYS0ZsTTZCY2ZKYmtiUTkvYmZtR1NGekFoZUdvWUpxZHdpU3NIWlk2cHNk?=
 =?utf-8?B?REppTkcvL0VlWU5vSnAzQzMraWJ5enpiNnhJVHJwTzFsRXNxUytCdit4SDJh?=
 =?utf-8?B?elFBTVpnamZLZ0Q0dkdIelpzckFTdS9CL2JVL2c2WkpjRXJ2Z0FadTAzNkVM?=
 =?utf-8?B?L1NVRXU5cFQxTnlLZTVBbUh0cnp2dFZ6ZDF6bHZNTVhFV3I1R3NIREM1ai84?=
 =?utf-8?B?SDdlaFJtVVRodlAydE45dlNZZnR3YktIU05SVTVnNTFtZVJUdVpIalQyWFUz?=
 =?utf-8?B?OURYUTlIYlZkTk5mb1U5N0FENm9sUURxWWh0TkYyYzBxREF3ZUNzRDRVKzIr?=
 =?utf-8?Q?rbcuerm44E4P5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEp3WlFaQjlXZ08vTmVuZ2tON056T2hJWmtkNXRYTjUxb0lidGkwOGtZWjVR?=
 =?utf-8?B?UCtaYTk0aVJhY2tCM1h2d1pjN3lPRDBHV2tCSGlIYUxOczkwMk9yQWIvdS94?=
 =?utf-8?B?S3I3d0V3YzFJWDFQWVVQN1MxMWdJV05vVGlhak5UUmpkcjNCVi9wVkhQOExX?=
 =?utf-8?B?czV3TnN5V1RpU2NDY2g3Wk1PZGdOT1JIK2kwSkVWaElGcmpZa3hrdXE5V21F?=
 =?utf-8?B?bWlaSHpHV0dDSjcyazY5dWptRXBkM0NTNXJDWWNNMnhuKy9BaW9rVHhYYTJ2?=
 =?utf-8?B?bjRmeng1YUhkbGRvOWlUU3VCSEo0MEZEcFJVZlN5cFNWMlNCL2xZeEh4MXFX?=
 =?utf-8?B?YnErMDdZbTZwM0FDaFZJakpCU1dqYW9HNUc3dFUrK3JpZTRBQTQ5RHJjYzB6?=
 =?utf-8?B?b3Qwb0UxWGYrSWRWMEYzTk56QTBlRlE3aTBwNCtmOFNYVkwwMWpuT0ZtQjYw?=
 =?utf-8?B?WS9xSHJXMFU5WldyejR5ZEtLTlIzVzl1RmhvanRrMWZ2QWNiM1JSUnhHWW1C?=
 =?utf-8?B?OEhoQUdpVVkvczhZRDB0N05RT3dMc3hVUXFuU0VmN0RxVm5nL1FlcENpNmNs?=
 =?utf-8?B?RHByNWsxSGJZa1BYcHlRSmdnNXAvT3JNQTdFWFdUdGRhbnRYWnZOTTVPZlYw?=
 =?utf-8?B?RFBGMnVLS2pWNENQNzRxRFZ1ZWJuWFpidEV4TXRpclh5Q2swQm1BRE9hZkM3?=
 =?utf-8?B?WmpacXZlVFdLbkp0ZHpJWExERVM4Z09pNDRmUG44MVBNWVVjdFQySDc0Z3JT?=
 =?utf-8?B?R2wza0VmSU5EckRLdE96VEhWQ0QxZnZPQ256TXAyci9wM3ZsVXpsMzJ4ZTVX?=
 =?utf-8?B?cWxmWHd0a3BqNjBUUkVyMDVnUzFEbDdIWGlTbFMxR044VnVrbEJCVWNtMExF?=
 =?utf-8?B?NXkyOTkxdWRaTGpSa1oyZVRpTmU4bDhSejlGalNFMW1wQ1AwbWM1YU9CY2FJ?=
 =?utf-8?B?MnV4RFhISE9FUXBKaDNvUm1yTlhkRXNHM2tibk9mREFGWk9ucFFMbHV0dW5t?=
 =?utf-8?B?T0d6dUVUaDBpWmpaTmJzZS9BdCsrek5KNW5jNmwzVW9yNWVTSnVMV3VCOFdN?=
 =?utf-8?B?UGNqYXdWVnEzaWhQbnNqNUNQaHpUeEdtZGxXSGdQbHBDWERFbVJhMHJuREZ0?=
 =?utf-8?B?MjNPVEdUZnpHK3VEN2ZJVVFOTzdZYU9OaGVIK0o2bUVDSWJNZC95MWtKTG5j?=
 =?utf-8?B?Z1BxWkFZb2ZtK0JhQVRraEpkcHgyWmc4aEEyQlVjVGxpKzZ0d2MxN3FwSXRJ?=
 =?utf-8?B?cHdRdHZJNlA1bnFER2o2d3A3M3IrQUxLWFRUejQwRGhrVklmeE41UjBmNVN1?=
 =?utf-8?B?S3FVdTNnc2JLQWJuUHpkZG41L3ljSFdpSmdyaE9QdFFyc29XMlZXZjRyV3RY?=
 =?utf-8?B?dzFwMVBSS0lVWDNLcTJBbmlyNitRMkl1Z1FLV0h5bGV2bVlzVk9hQ2k0K0dT?=
 =?utf-8?B?QmtjZ0FwajJ1U0M5cVQvdG9lWk9pbDZJVGNhVDJYOXNHNnJ1QU1QK0pOb0w3?=
 =?utf-8?B?YkZ1OVFnUVowZVVvZXkxeVgvRU4xUm41aG5BYXF0Y1UycnArWWcwbGlPUnhs?=
 =?utf-8?B?TnVnZjFIcUZNS3kxNkh6VS9yVXBjdFIzL1V3OXhkbWw3VFpQbUsrWUhrU0Jo?=
 =?utf-8?B?d3l0d1AyL0VOelZGQmxFUmx4QTBFQ3pMNlJVZCtCNGpMbEJ6VFBjV25HSkNE?=
 =?utf-8?B?LzJzSnVpejBlc01DUUd1VWV6TUVZQjhGQjVjYzYwVlY5d2VFR2grem5MT3F3?=
 =?utf-8?B?d0Q2NTVwL3V2dVFXcWptUldiVXQwdkxSQjBQNnhDUCtSdTJLcmhiVnp5Q0F3?=
 =?utf-8?B?RXBiR25hK3hLeDc0MW5lRWkrNisvbWp0T2RMRVVtVkZRVXRobys3VTRVcDRr?=
 =?utf-8?B?a2lRdzJ0cHdsSkJ3WktRNTFabVptOEMrdTFvTVhDSmh2WGh4YktJeFhyZXZ4?=
 =?utf-8?B?c1dzRGZJQmdCS1dtVURyTDVxVWxRUVBxQllDSklVQlJvcldDNFpkY3EyeGpO?=
 =?utf-8?B?MHZRNitacVlOMUpQdjBITGhtZ2VrZ09GcGdKMm9UeEkycm5sQ1FRRzdUNGNC?=
 =?utf-8?B?UDBETW9qdFk3OVA3cVhTazEyTkhYaXpSTW4wQmFqWUZEajRzamkzRUVwbEUr?=
 =?utf-8?B?M0Nad2dLRWdLOWQ3dUMrNFRKWDh5Z1Z1QnUzeW1IaTZVTVlrVmhtQkhZNVNN?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a79b35-59cf-42c1-3ca1-08dca6854147
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 17:24:03.6984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: px8DAqKn5M4uh9+Ffyv9/ywhxGZy6QmJtNEOwlPYmyDdobF9WIHGJwbi/o0DVMKGj6115GPCKa0FnTLjZHBBhXsNneXXyghwS2v6Ognsjys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8537
X-OriginatorOrg: intel.com



On 7/9/2024 6:53 AM, Kory Maincent wrote:
> The hardware registration clock for net device is now using
> netdev_ptp_clock_register to save the net_device pointer within the ptp
> clock xarray. Convert the macb driver to the new API.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change in v8:
> - New patch
> ---
>  drivers/net/ethernet/cadence/macb_ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
> index a63bf29c4fa8..50fa62a0ddc5 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
> @@ -332,7 +332,7 @@ void gem_ptp_init(struct net_device *dev)
>  	bp->tsu_rate = bp->ptp_info->get_tsu_rate(bp);
>  	bp->ptp_clock_info.max_adj = bp->ptp_info->get_ptp_max_adj();
>  	gem_ptp_init_timer(bp);
> -	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &dev->dev);
> +	bp->ptp_clock = netdev_ptp_clock_register(&bp->ptp_clock_info, dev);
>  	if (IS_ERR(bp->ptp_clock)) {
>  		pr_err("ptp clock register failed: %ld\n",
>  			PTR_ERR(bp->ptp_clock));
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

