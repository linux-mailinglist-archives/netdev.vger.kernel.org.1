Return-Path: <netdev+bounces-113761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D2E93FD11
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 20:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B541D1C219B9
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D8B186298;
	Mon, 29 Jul 2024 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEP/AyfR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809961862B5;
	Mon, 29 Jul 2024 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276173; cv=fail; b=kIMpskhO5zobaNh685c4H9/sfFzUq7zp+7QZsdvWr8kCnP/XZ3A/EA2Ruc3DjTkiCaKmuPMhHnDth323/NRmAMl0b1EPQXn6kCLyVR8LigGZ6DXvrTaCZXjrcEJsg36HLq8XanWQWm5GMwPeGvAUImhFccLBibFaa1Ogso/peg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276173; c=relaxed/simple;
	bh=10nVhgDeGqZegTf7iuKTeIaC6ObAeyple8ijH3Qqy/g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q7kEgU+4Ujsxh7yzqQnec+wzJ87zNU8CagKikbW0nczatJz1oBcxpKdFk3Ci//nu45eg1ZIDDVmtTs3dShHo0rb2jcJWjrVMiPumLohpOw0lEBkZOrM9M4NBzxODOQkVotr8CPSe/KlqXKYre1rurSvhexJqOa+AmpYVZkKbmKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEP/AyfR; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722276172; x=1753812172;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=10nVhgDeGqZegTf7iuKTeIaC6ObAeyple8ijH3Qqy/g=;
  b=fEP/AyfRE3lidiCtbWv4Sp8Uix6MgmqmzIQQvg5R1wn16YUznJkUXVVd
   zFxYSrRnSmaNojF7KzWlxTTjnHJ+c6Jim+/6Te7UUvoYIVrThPa7ldsSV
   oFNZCVE9rzespW3dOtYkGQCzKRqfrr1Y9JF4Otr0kday/K/6VEPJeoZ79
   z6Nrm2Z7VtHQ5I6JRVhnByIJDMKvuHoQ9S2/LTvh7EPvpALjlNfu/eXdh
   +G0jDoX5AafRlfucXqexrG9JWCTC4wWNZbv3tsu7NOFazxhUZW0J2dF4b
   xA9C6Ldkf9U51Zf0xN3Sc3la77DQuvm8iVHPwo73HFY8cw/DTTrVIwMCT
   Q==;
X-CSE-ConnectionGUID: j+fElBPFTZK/XeRQfG4x9A==
X-CSE-MsgGUID: ZQO7kknzQKSOaKykkyOb5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="12775575"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="12775575"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 11:02:51 -0700
X-CSE-ConnectionGUID: jEHncqAnTtaN2U9NrIpu1A==
X-CSE-MsgGUID: tQT705P2Q4KX36TX04SlGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="53782422"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 11:02:49 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 11:02:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 11:02:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 11:02:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAbMskFYAowbfaFhCNCAfLutM2R1MUn2AJtjV6c/ZF3/TFjQzPAGnGc7D6xf/fCckixEuBDX7vchFZEtoJ4tzYRNDmBK9H7lfn5l8e+DKP71pHzT6T5wi9HUCjPrR5eFiEGa2KpOSvPBxj2ch6zEbGkDBnztXinXHF1T0aSl0ec5HM4OU/GLFL+7UTkkvcdQ838n/oPK2Wry23yy7xIvm/OgLswkJjmWwjcz4Un6hcZK2MMr2BrEOpgxcTUvU0NEx1FadObDx6cI8PGuiTQhTnh3bzskCl6SCPWFr9hC7lBhmW/GP+IGqCKzhbK9KgdNLWD1wnAZPpPh5j+r6SLCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ll+UpNiq2vmR1nUrPE4Nmetd5uMwerXJwvq1sxd+cFg=;
 b=gtSixBRxWqjq7a2ZaBPpJHue9SFiRgLQsIzyYZzLHm1D+oIOpKsPUI9mIh5JlhgWi6oKYwXwynWlF9BcKcWrbROnEyUh8l9jiQpgEC0/oJhV8TfK9E/s13QRWEDo1i/oK1HjZzqoaKhR2UjQqL7NJ/zwrqKliy+EuzdL5rO2AC85eD3evf9VUrB+EsWm67eFWVZ5CO2e6/FQOWD8wQX5gcXs93KvahMF18poSwIniWJmQr1yF/nrWLvXBWswVijYo3Tahc0Qhv2+cdo2pRzQKQfKKH2ho5unig3A/lrgrmjX2HvdXwB6srKrq2FdF9ycWXvkPSxyJlp9jayqCKWElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB7905.namprd11.prod.outlook.com (2603:10b6:8:ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Mon, 29 Jul
 2024 18:02:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 18:02:43 +0000
Message-ID: <5e97152d-c992-4056-a204-861035e35d60@intel.com>
Date: Mon, 29 Jul 2024 11:02:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 13/14] net: ethtool: Add support for tsconfig
 command to get/set hwtstamp config
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Florian Fainelli <florian.fainelli@broadcom.com>, "Broadcom internal
 kernel review list" <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu Pirea
	<radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, "Andy
 Gospodarek" <andy@greyhouse.net>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>, "Horatiu Vultur" <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "Simon Horman" <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, <donald.hunter@gmail.com>,
	<danieller@nvidia.com>, <ecree.xilinx@gmail.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-13-b5317f50df2a@bootlin.com>
 <f16855bf-ae2a-4a0c-b3e9-d25f64478900@intel.com>
 <20240727150009.66dcf0ae@kmaincent-XPS-13-7390>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240727150009.66dcf0ae@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:303:b4::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 5760d590-976b-48b1-f2d4-08dcaff8a4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVNlanF3UktnTU05ckpSWG1RdWZZVEg0RmdESnpDa1RCUFl2WkhteVk0N3Ux?=
 =?utf-8?B?SmVTNFdWSVpLdE44UWxPTXFjb3FoTGJKaGc4eHB0ejl2cVhuUVp3UmlvUUxK?=
 =?utf-8?B?ZUM5dEVFQzA0U3pjMDRldGJPMllpT0UvQTAva2c5WENJNE5TVVQ3NmpUSkVr?=
 =?utf-8?B?a0dGR0gxZ294UDZoZnFaaFNxdEtyTXRZSGdqNlJaZUxiNlVYeW5VVGxYY1Ey?=
 =?utf-8?B?dldhaXA2UFZxTEdyRi9sVVdPRjhqOHNtSjM1d2xYVkpmcHl0ODVweHBDRFly?=
 =?utf-8?B?REpVRGxIdnRFOElINEU2Y3lxS0ExbU5ESVBMeFlkd0NCancxN1VDN0JuMlNo?=
 =?utf-8?B?M3V5OFpZdFpRTzJWUnB4czNLRTRCemgvaWhHdkVxZkptSVQ1UGdrTHVCbmdC?=
 =?utf-8?B?NmUydnFmN3hZN3NvVkxYYkFoeFJRRWtZT1lTK3Z6Z2ZOVDFuVFhydnU5WTN4?=
 =?utf-8?B?bktvSDZDdE1XVU83ZGpMZGdiWU5YaHE2b0VxVE41d0ZaSVgyQjIveUlDSVdu?=
 =?utf-8?B?Q0NiVTJHSHJQMzdyb3Y1YWFJZzJQRXdML2E3SUZPZXBLSXdQcUswemhEQ1Js?=
 =?utf-8?B?RG4vR25WYTl3QkJ0cnk5NjlLSWpyN0hNTksvNk02UGpxNUYxbXBMb2ZoMGV5?=
 =?utf-8?B?c29zRVZCdm00dnp4M1FWZ1ZCS0RMc3dDSGY1U3F6eFpET05CZjUwam9jdlR6?=
 =?utf-8?B?dWk5Tjk4S1RLVEN3RlFGc2o1NXc3OEI5cWNQaStPRW9jcDJralYzNzNycGZJ?=
 =?utf-8?B?Zlp5blVvNUNVWGdlL0dlMW42YVRhK3kvTHZOZHgxcGMvcENEbHpSWm5QTjdh?=
 =?utf-8?B?cW9Sd0lDV1VFaEY4Mnl2WXh3L3ZLOUJTdzFqNHZwckJOaDg5NWUycHZGQkU0?=
 =?utf-8?B?MHlGOURCbnlONEQ2anNWenZiYUl3SVkrVTJQd1R0ZzByN3Q5QTVFb1JpUzZX?=
 =?utf-8?B?d3hNNXhyOGZYZnZxQUROWWNCbUpCVzVPZlhZWXBBbEhnWkF4UlF5dnJRRm4w?=
 =?utf-8?B?c2VSeWxyK2xTOU04bDRvK2JKMUFhZmh6UjR3UEQ2bGNPOVhqNlFkZjlqR1FJ?=
 =?utf-8?B?azFBajR5LzljQWtFREdQUG9xWlFxZGN2K1pVNi94N0Jtc0E4MWptR0VhMjZX?=
 =?utf-8?B?T1FjeWRNd041Nmw0MHZHTmhIUzRxMHQzN21OZGp2Qk9HZS94TGRMYzJhVm5a?=
 =?utf-8?B?TzVlUnEzODVMdXd5aFVtWXBFcXlCOTkzYUhoV2MyMkhUdUw2TGRwaDV3dk5s?=
 =?utf-8?B?aUlJWUpRWTBmelp2aktaTmUvcC92YUZRUzl2OXVoVXFsS2djWlVOWHJxSHIy?=
 =?utf-8?B?clM5OEpWSUw3WGxpcHErMWZScTYySXdpb0IxWkpSUTFjS255RVlvd1RTSzkv?=
 =?utf-8?B?RzBoYnFEME5rUUkyVEx3K1MxQ0VXUGh6N1l2L3RxdDlmZnR4WkJJZXd3WkRV?=
 =?utf-8?B?YXIrWUZrVzhsWTA1SnloYmJQaUFYaWpaVkdXMlpYaFVwaHEwVFRvcERYOVQr?=
 =?utf-8?B?VUxkNTUyMy9SV1V5eXRCYWNpZTM3aGxTNGJtYUdkbnV2NUgvQVJlQXAxU3FZ?=
 =?utf-8?B?M3JjR2JpY0F3QmVDa0dNazZ3azJRMnZwb25UbGNZcDJidFFjVjdaemVaK2hr?=
 =?utf-8?B?YURxaTVKTHIzdWhtWDFVdk54OThWTkNLdHVoS1BCT2NpclpJMEZEdVViQSs0?=
 =?utf-8?B?L3JESC9OYTdkOEhPWXZOZDUwSEgxbTNBQUNmTTl6WW5JNFFGa2o1UVhkaE5v?=
 =?utf-8?Q?NGexfiBUUSIQ4bQ8MM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU41YmZWTEZJNHN2YW1heVBzYXRxZzI0QWswVFN3U29XemF0TlVuMDZWY1JL?=
 =?utf-8?B?cFE4aXJvaUtuYTlaTlprOHhtSldNSExDaWtVUFFlZHJ2bUxUZnFITUx0YmRz?=
 =?utf-8?B?cGJva0VETWo5T25QdXNxa0F2YTg4bk1tVytJcjNJb0I2c1JKVDR0OEZDV3ZN?=
 =?utf-8?B?WUZzMDIyN2dCNWFNMElRek5KbGdNVEk5a1FPYmlOaDlzS0NmU0Zyb3l4dVVm?=
 =?utf-8?B?RmRaZHpNeGRLN1RrZncxb3MxajJQSEJhcm4xdEI5UjJLRVpnenBVemp6L0xM?=
 =?utf-8?B?dU4wVVR6aXZseE1XZjgxOHA4U0M1RlhTQndKM2VrMU42ZkJCdHdET3U1V2lk?=
 =?utf-8?B?eFVmbitaZ1U4STArbUJFVlpieE5CcWh6K3VNWVpmOENnYzRYZU9ic3lLUXVY?=
 =?utf-8?B?bFV0QkdPNFlCRzZvQUpKcitzbGZZQlFGdEtvQWswNUJYdEF2bWxycjhjY1l4?=
 =?utf-8?B?eVdXS3JJOUdGV1hPaGZlcXZiNDNqV1VzUFk5TklwbUVldFRvRVVwZndNYVpV?=
 =?utf-8?B?MjZSL0dRWmdRUER2VCt3MkE3T1lxQ0pEUG00UUtsWU5ZcWdKR0x2VDcrSDlH?=
 =?utf-8?B?Unl0SVNjQmlNd3NEOHZNanZVRDM0YnZ4aWc2Qnhzb3JvQ0tVaEo3UDloWU5S?=
 =?utf-8?B?QUpydWt5bmF2czVCb0F5RlhjL3JLazIvT0hsYTN1MTZVTXQ0UFd4WkYxU1hF?=
 =?utf-8?B?WDZUajJYa3JVVFRvQ2htbkFzRjZHKzRBbkhJVkY4QWxsSllHTUJid2xrQ3ZR?=
 =?utf-8?B?dzZFSVFuaUk5VmFXbWZwbW9MOGxtNStYdjhyMmFGaXpNckpXNGthbGNtK3Bx?=
 =?utf-8?B?Y3NadnZrSHlYNHgwQStnelN6L0UvTnEwZmQ4RWxzNzJYdDYvNGRJdy9TdVJL?=
 =?utf-8?B?RHRzZEs0aWZyamFvVjVFNmVqbjdhdGZFTlJ0ejdoT3NZY3NCdGtFU1RYK3Rz?=
 =?utf-8?B?VTdHSSs5ZGE2TEFHY0lGYXIwd3dSWWpOa2FpeFplVkJTWTNrOTREL3RHMjZT?=
 =?utf-8?B?dWtXY3IrL0pVamV6WEJxU1k5VzhqelVyUEUrSWxLckgvR0YybHcwMUZGVmor?=
 =?utf-8?B?bWlBVXhud1Boa0tsbHp3aSs1ZWpHaE1oYkhNQ2F6bWxKN0dMYzVYa3c3KzVN?=
 =?utf-8?B?dCswL1graElFMS9mcGxNTS9sbEJYa1cwakd5UzRQbmNiWUMycStjL1JOejJ5?=
 =?utf-8?B?U3BJc2tWM2c1dzlkb3RwMm9sNTRDWk5MQ01sbkdlT1l0aTJrZ1Qvc3ZzQlJP?=
 =?utf-8?B?aDRQZSt6YmR4L3pDUnViaTFOY0ZZNWZBUnh0S3M5dVU5dWRhcE55QlhZTmxO?=
 =?utf-8?B?Z21icGxmaWxFTzVIOEVrcHhRU2pCQnJwU3AwZTNNL2czSTdqdmppZW5Ia091?=
 =?utf-8?B?UzRoRldEWnFKSnk3TE12T3dmMkZBNStZeXZMQTZsWENNNGtNbzRnSjZCL3VZ?=
 =?utf-8?B?c21tcUI0c1NUS3NzTkVlZE1aRjM3ZGpEWTZWakpMY0lXWGhjSzJnVzlZRzJB?=
 =?utf-8?B?cVZicmJnSUZnenpkN2gvWUd0b3N2dFZJMWd4OW94K0w4WkRDZ2VnL1daeXhF?=
 =?utf-8?B?a0JoWG13WGtpQ0NIaUhrYlhpR0krSjV0UkZoaGR2VlhaWWNWOGZqK3dkTUc5?=
 =?utf-8?B?Y3drVDNoUjROb1dxZXA0cTlvNitiRmpLNE0rMGorVVpiMWZ2TU15dUpYcWpr?=
 =?utf-8?B?SUlCaGNYS2Evd1BHT0RKa3RDWlVxL0lEWnI2aE1NdUZrK1NrRHNpRzZLZE1m?=
 =?utf-8?B?Tm0vTS9DM2FzQTY4QUFhYU9IT0lySm1QTTBwSTlmb1UvbkRsaUFjbE1ya2Qv?=
 =?utf-8?B?QnhIMmZESnN5TGhFWWl1bzQ0bnpqbXZvQ2RZQ3BqSXNETEluSmZSL3RYejhU?=
 =?utf-8?B?WTlUdjRVYlZRMU1hSVg5NE1XNzNIa0krWjR2WkVqbkZVV1BtUER6YlFSUmhU?=
 =?utf-8?B?Ri81RkszSDBHY2xPNWc1NzJiZU0rN3pwNno0VUE0Rkk0enJiNWRQWENxb0lo?=
 =?utf-8?B?cytMSi95enRIUHIwUHpqL080OXZlc2M2MnN1cVBqKzFuUWN0WThFd1F1OVJp?=
 =?utf-8?B?bjBNTnZralEvN0IrSHQ4aVhEVE1IZzlkdnl2WUNNdkp3TUQrb0xjOVBNaWE3?=
 =?utf-8?B?ZVFMOS9McGJhMGlZWVdGTGQ2c2l6em5obmo2S1l2MHVHRCtYcVdRbE5YaWtj?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5760d590-976b-48b1-f2d4-08dcaff8a4f5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 18:02:43.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Taxs2GevATmghLVNqj6T+iEd6Wn3jVyujB94eHF8Q1hfENL+66OtVB0v6k6uMHyp/Gnb3zZOW9w7NO4QTNhz1AtKpVn7eV+bS8PMyOZySDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7905
X-OriginatorOrg: intel.com



On 7/27/2024 6:00 AM, Kory Maincent wrote:
> On Wed, 17 Jul 2024 10:43:05 -0700
> Jacob Keller <jacob.e.keller@intel.com> wrote:
>>>  A driver which supports hardware time stamping must support the
>>> -SIOCSHWTSTAMP ioctl and update the supplied struct hwtstamp_config with
>>> -the actual values as described in the section on SIOCSHWTSTAMP.  It
>>> -should also support SIOCGHWTSTAMP.
>>> +ndo_hwtstamp_set NDO or the legacy SIOCSHWTSTAMP ioctl and update the
>>> +supplied struct hwtstamp_config with the actual values as described in
>>> +the section on SIOCSHWTSTAMP. It should also support ndo_hwtstamp_get or
>>> +the legacy SIOCGHWTSTAMP.  
>>
>> Can we simply drop the mention of implementing the legacy implementation
>> on the kernel side? I guess not all existing drivers have converted yet...?
> 
> Yes indeed.>
> In fact, Vlad has already worked on converting all the existing drivers:
> https://github.com/vladimiroltean/linux/tree/ndo-hwtstamp-v9
> I can't find any patch series sent to net next. Vlad what is the status on this?
> 

Great!

>> I have a similar thought about the other legacy PTP hooks.. it is good
>> to completely remove the legacy/deprecated implementations as it means
>> drivers can't be published which don't update to new APIs. That
>> ultimately just wastes reviewer/maintainer time to point out that it
>> must be updated to new APIs.
> 
> Yes but on the userspace side linuxPTP is still using the IOCTLs uAPI that will
> become legacy with this series. Maybe it is still a bit early to remove totally
> their descriptions in the doc?
> 

Right, they would need to use the netlink implementation to get the new
features, but the ioctls can at least be translated to the new kAPI
thats in the drivers?

Removing the old APIs from the uAPI doc is bad, but I think we can
clarify the wording of the doc and update to make it clear where the
separation is.

I may take a pass at the doc to see if I think I can improve it.

> Regards,

