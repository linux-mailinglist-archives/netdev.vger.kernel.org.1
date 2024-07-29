Return-Path: <netdev+bounces-113758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE8993FCF0
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 19:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29991282D64
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEA416D4C3;
	Mon, 29 Jul 2024 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2YQB6RA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2143D9E;
	Mon, 29 Jul 2024 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275934; cv=fail; b=VLhh/Eo3Zd2dK/fQsb8v8Fh97ISMof6LNJb8nvkQ+7C2EgYPZJkM4eE2PHrlXkAvPC8q1VfQlp46JwW/IKEV8sIH9fLyasgzZVKNiemBcnnKiXwaP0NaiMMGSXehJJBVM8H6TlAdJvXmgWuZM0/11FloXbmxUW5j1bIHK3O3j4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275934; c=relaxed/simple;
	bh=uSp+VA4JBmmudEhXB2jh3LqMsAq8g9LqJCWWfX2hRFQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f1FgZSmdt14YBp/vu/pg8grHCCCf+I4eMyT6Yu1nu+V+imhZsOkhFbJJgSg73e4w+mlNZd70cxj09Y212QC/8/f/TRFnumljYTWl00NywyCkR+MxlEOTPOYZAyvDyNLhVHHBHPPICZs+wiTaYsxsdmGlL8XZ1roYZCFn13wHmXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2YQB6RA; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722275932; x=1753811932;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uSp+VA4JBmmudEhXB2jh3LqMsAq8g9LqJCWWfX2hRFQ=;
  b=e2YQB6RAgCS1/bTTO3uK5aK4bcpUYx7zK2WVa0viTCBFRJ5JotdK6Bva
   0AnEhC9CErozuSndOEWSxdd3t0VoQ+0tEAZi+Kggiv5lKH8wrfQz+fT4k
   BVtXv6rvANpfH5pO9YxEVXe1olHAJPf2Wj4pjZU0mYgS+JHhBc/eGiZlL
   bnG0tkSFUwV8cAKH8cZIk4gkDmvgu+hbSHRD0OTa0N6mtfxDNc2B/++Fa
   Y4pIDv9MmxlUL19LQ5UxtyzDHJvW9rDBMVdHbtvUfy9HGEPECfy2XE2OG
   +Br6tPSnGZGGKYCrTARwrHnmPHWBtWXvd5nombeL7/sZEbSNyj9vr1p5Y
   w==;
X-CSE-ConnectionGUID: FRQS+FXNTMeNI1U5qqjf2Q==
X-CSE-MsgGUID: s7K4JLvtQtyWsQt0VWf9lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20198768"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="20198768"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:58:51 -0700
X-CSE-ConnectionGUID: AIxlcVWYRfO1eLy9v2vWig==
X-CSE-MsgGUID: uEhz0S4wSmim8zlLAputIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="59149270"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 10:58:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 10:58:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 10:58:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 10:58:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 10:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVzpP0XbHW289Ij4YcSvREkJXVyesqj3JU5PsfwVaVKHcpEMNA5/JAaJOrbSCOVulnLBjMlI7nAxz7XGDX6/w2jut4P3bbI+iM0VN9TNrFqRkZJqCMmjotFxppxopHj2eNR34S0skHq+V6xhl0qjPL/xXoMBTGgLzeCxBocJXT6X5N3KR1ePnpUm4hFYbp0Qi3Cnc/9R0Q3cWkELom1DczxwZ7/SYWNUfz2l461Tvg+QpbiqqDqDe2hjEDNRGcjo7G8r/UL7U790nRKg6o7ncekMy8DB/dwMlQsVyTBBOi+adhsA2j5+zrjytz8fGJKSJLsDquQS0Y5ILA9TpU5/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoAxF9VFbukXKK/2ArPOQtK7VhWGVUAVbrr+MaGaqn4=;
 b=NkTDpztYPm4wfOIj0PrFikMBkTTqz6eZFbHX4644DXRAFKOxJW0KkWOoXNbw27Td33nQHqEcAoEnHuJnm+Qe74pc8Dxi/KimNgrhiXV87n6TyWhkZqsu6JGlTqQSKgNo1zEx+W+CwdiCTzcBRExPpA24kUF9XLV+RBI8hc0YJopviGfdiK7KrkmDuyktHHOeLrTkD1uLIZAwCdeiPUTKX4607lfmYaROOi87YzcwpCR8VZjMC2uWnmuqzofAWfjmjsyXNaGtguZnC82YedBN1IZvTBVYV/fn7fvdfTEkVlC3eyuUgH1lgyKAFQ4TU4iJ5jShAU2jj/g81Gqdf9qaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4694.namprd11.prod.outlook.com (2603:10b6:208:266::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 17:58:41 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 17:58:40 +0000
Message-ID: <4cfadc45-2f8d-4c9d-a4fb-4c255ebca228@intel.com>
Date: Mon, 29 Jul 2024 10:58:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 12/14] net: ethtool: tsinfo: Add support for
 reading tsinfo for a specific hwtstamp provider
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
	<corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Simon Horman <horms@kernel.org>, "Vladimir
 Oltean" <vladimir.oltean@nxp.com>, <donald.hunter@gmail.com>,
	<danieller@nvidia.com>, <ecree.xilinx@gmail.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-12-b5317f50df2a@bootlin.com>
 <667b3700-e529-4d2e-9aa1-a738a1d70f0f@intel.com>
 <20240726210427.525c7abc@kmaincent-XPS-13-7390>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240726210427.525c7abc@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:303:2b::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN2PR11MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f49426-29a2-4080-e495-08dcaff81425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDYxR3lMeFpHdllTalIwMXFYc2JnT3Zlb3Y1WWJKNkw2ZzFJWjdaK0R3a3ND?=
 =?utf-8?B?K3ByaytnajEwaXdteWovdXQ0WnduaFRmM0x3Y1VxdlkzRGZXSEFOZEpzTlNm?=
 =?utf-8?B?NmJ6b0hUR1c4cUI3N2FvTlFUZzQxRmE2eGRMNTBYdFZEQUF4Rkx6ZnlFMGZ6?=
 =?utf-8?B?MGpUV0Qwd2lDWUFhcUVYT285K29lOGwvM3dkdFJoamdzQUd4SlRmNmxGMXVR?=
 =?utf-8?B?RytKcFVBSks0OXNrYTRhSWtkS0tyK0xWdUl1YXh1VFMvYy9ya2kwb1VPNTN0?=
 =?utf-8?B?d0pRSHNPaEl5VVEva0s4WC9aTlprelVFdTQvVWdUMHYxays3QmExZEZ2UEMv?=
 =?utf-8?B?NVFlZkpXSTFDdzdNaCs3b1Q1M0lIalRVajRkaDFOYkZnNVF6VlpXUnFlT2Fa?=
 =?utf-8?B?SGtvbDQxcllFNkN3M3Y1aFhPOWZ4WDk0bFNMZjlnc3drb0pWcVUrUyt0VUw2?=
 =?utf-8?B?cnQ1VVVyOE5iRjgvUW5XbFM4UHlsV1orR2IwZ1lETWptbWtLNEx0QUo1VEgv?=
 =?utf-8?B?NjJRVFBCd3pwNjRPMXJlM1Z3cVN6K3NBSnVyckVLcVhmVzV6RC9CMGF1SG92?=
 =?utf-8?B?SFFBKzQ3RC9Rbk84T0s4OEl4b3IySm1DZHNZaStDei9hUDRLSXYzdk5mR0Nt?=
 =?utf-8?B?cExuZGxGMU9PVjRIQmpYbmRoL25KS0VyM29GaW1KcWlEU1licW9jZC9XdXBm?=
 =?utf-8?B?aU5KL2F0YzVUdnFtaFBKcStHUlEvT3NNV21xaFVGdm52SXM4YzI2TlliU3dC?=
 =?utf-8?B?MTNienN5NDNRZk1uemNUTVFDeFp2RWg1dXEwV1lENysrMVFjdUxTendsdkdJ?=
 =?utf-8?B?bW1GK0xpdWtQWUVwMThERUdNbnYyLy8vTEJLMUVnQ2xkUGtqZmp3MXZpb0tm?=
 =?utf-8?B?bUU1bktyWG51bkpuSXpYQlVEOU1uSVh5YncxSHlNTkdaTU95QWViamJpMzY5?=
 =?utf-8?B?RlRnVnhaeCsybWp0Wk1WVTVQK3cvdzg5K003YzdLSlVVWE52My8zeGFZZjJ2?=
 =?utf-8?B?eGFxeEd5bGZMdkhHQVcxMlllcjhoQXVpLzdFdHl0dWxRTDNWVXJqaGovWHVo?=
 =?utf-8?B?UU5JYno5Q0VXRzY1Zlp2UW5OSE5SNWxLdkk1RXJuRlVXZDBvMG54alRuVnhH?=
 =?utf-8?B?dmlmYyt2UWhOb2pyaVJqNUJaV1JNOWF2U2FQcDN3aXo1YStpT3FDMksvWTdo?=
 =?utf-8?B?ZE44clNRaHFuNkRDTTdOQ3Q4UjZwTnBTOFFrYzUwTXFqOHJicGRESWtFRGJ0?=
 =?utf-8?B?ckRSaVp0ejJtK1MvSWJMN2NOZ1NXVDZxMnJVMWpHb0I5TEVMdnFraU1HTnBj?=
 =?utf-8?B?MzBFdDRmMFlLb1Z5ZnQrQ2xINHNTZUgyTjRGY0ZHZXhTd0gyWVRyMTk1eEp6?=
 =?utf-8?B?cWY1TDFUVkRGZHhSY2ZZU003Vm9UOE84WDM2d2J1UjZlUHJHZ1M4SmQ2ZWJP?=
 =?utf-8?B?bHM5bUtiMkR1Y1NZaTFUZkV5SkhsR0tGMkc0dTQzS1ZmeGJDUHRCZ3B5UXls?=
 =?utf-8?B?dHloQ2lGblBvZUswZmVGaklXY2t2Q2MyOVVKN1JUaXZ0NzF2NUd3S2dZeVZO?=
 =?utf-8?B?Q0UyU0svREgrT2duMHRYZkRwK0I2TkFkd01pNmJOZlo1TzQyUTR6VjkxR2tD?=
 =?utf-8?B?T2dzMDI2dHEreUplUWhQSk5ZcjIrbUZlVmhOaTEwdFBWYXlPNDNkTHptZ2ls?=
 =?utf-8?B?QnZCTlM1THRVNjVGRTlVTjNVWm1EaEJYTzIrTDdrQnVoRkZ1VWdrcXc4OVlh?=
 =?utf-8?B?MnV5WHAyYlc2elFENmlSTTdnTzVYTng5djcwam5aZmE2VDlVVHZBL2F2OEZQ?=
 =?utf-8?B?M2l1ZnExVDZjOTlTZHVkUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dENtN0JnczdNQ2F4WFNVbGw1dGdQZ25FSGtScnhIVmlDRys3aHBDOXFHWXFn?=
 =?utf-8?B?V0M3d0c1WGF1QjdSUTRxNmlXY0FYdnJISFpBUnZFK3VteWFCbDhyeUVuSFBK?=
 =?utf-8?B?TVI3MzhVS1NKSjdVOHRPREJ2aENGS1ZvanRPYmhhaUVaQm9nY3ZwcHduS0Zs?=
 =?utf-8?B?VzN3Y3UvMVlja3Z1WkYzM2VPM0s4VUJ5SXNJVmxvMityVW8zd3dMZHZkSklM?=
 =?utf-8?B?emxFc2IwS1E4ODhDM3NqcDhxcXZQaHVEbkNUUUluVUtaUFFscGRxODFWY3Zo?=
 =?utf-8?B?cVAzbzc1dm00bStvdGFoWlMvQlZTM0lkRExVYWNRNXRXejViaDkrU1M2Wmxk?=
 =?utf-8?B?VU1lY0hmQ2NzZGFmV05OQ2djTEUrd29QM2RlallVNVhkZFNJdlJlLzlEek11?=
 =?utf-8?B?bVBiTFo1anMyci91Vnd5ZFV0RkpGMU9oY3l6ekpKMk9HV2ZkTFk0SDRZRWlS?=
 =?utf-8?B?aTVHQ09ySkFkRU8rYVhXOVdQOHpVL0k4UG1ZNlJjUmJpeFZzUEtCeXpPRzkr?=
 =?utf-8?B?ajRnZ2owT0NxbWFIKzFBemNGOXV5ODRyVXVvWUFjZGd1ZWlJcWwxUTVtck8y?=
 =?utf-8?B?VzFwdUE4U2tqWjZRbVQvOFZlMnljU3F2MHZKS3NUbmRoUUVRa1I1U25Xbnda?=
 =?utf-8?B?U1d4TFVNRWpLUlB4L3lIV25qbjdETkJJK0RrOXVMK3ltdjE2MjJTQXNlS3hz?=
 =?utf-8?B?YllyZFY5K1krMW5UbkxDNjdUN2ZLQ3VTTDZwcko2TUdhaTNyWDFhY2QraFk4?=
 =?utf-8?B?M1BtZkErWXMwZTR0WGRZU1NQMFBlWkc4MzN2OXdVaFlTMzh4emJBbnROQXM0?=
 =?utf-8?B?VGkyM1NhUUVFYllEcW1ZTkswZGtOL2Mvd0djVkNJYjdBV09kQUxtb0JCRXpQ?=
 =?utf-8?B?OW9HSTNCV1dJN1paT2l0d1lMWnp5cUJQcHRlYWlIRC9qcitnZFNVUm9ra0Qx?=
 =?utf-8?B?WkdQUWxyZGNVemRkT2tDS1JtZ0JEdEZpbVArdmZHMThsZW1Id1pXMU9iL3Jo?=
 =?utf-8?B?NGZYbDlZbk1tWmRjbHUvVnYzSkhXWDZ6akcyQWtlakRKcTllb2hQVFRtbVdQ?=
 =?utf-8?B?TlFpSDg2OFZQU2dSNU1LbWJ5VG00bVVkUy84ZEJOdHU3blJtdCs3NlhiWEV2?=
 =?utf-8?B?dGc4RUZjd3Zlcis0NlROeXpvbFQzUHR2c25hZENNaTRTOVpYL1kyM0NUenNN?=
 =?utf-8?B?NU0wcVFQaUVENGRnTkNaOWQxVjR0Qm1FYUdGdisyTWNzY0hFbjVzSE00T1Vi?=
 =?utf-8?B?eGwyQm52MC9RODU4QTZFMU02aGk1VHJadzVmZ09od29Xa3dTUk5ybURBZmwz?=
 =?utf-8?B?VDk4NEN0dGxEM3Bqay8yYWRPTDRGbVZKcHB2bDNoZGtvZzB3UkRvTTYwcUdR?=
 =?utf-8?B?MWFpNUlDMUw0S1dLZkFGQWE1RVJKSjBEZU1wUVZDWll0cE9kQ2N0STg5V2ZB?=
 =?utf-8?B?UFhVdENvQll5REpUMEpYRXNKUkNHY0dSR0lvYWVTNjNqdFZ5TFFLVWZQS3o2?=
 =?utf-8?B?SkQ2QXQ2M3B1bDM0d3BDSVBQYUJhUW9jNnFOYkpZN3lKUEtYZ2N6ei9FUVFy?=
 =?utf-8?B?ZnlTMnJHendtMVdXRjY3RFFEbk0zSFUwc3VEcGo2ek8rc3VEZmhXM2RDYm9V?=
 =?utf-8?B?YVBHZHFkNGp4RGN3NjZJR3RPUFVVMXYva24xNTBJRFMvejc4S2tMd1FmMHlk?=
 =?utf-8?B?OWdwcEhuZWxvblExYnBYUFRUdUdJd0x1ZGJkNE5nWTVMTFlzUFFUbkNwZGtL?=
 =?utf-8?B?KzFVNmFBK2NqYVJTaVpuZGpSTDBNUHZFdUdZcFFZcHZBeVI2cmRYMWRGVDBp?=
 =?utf-8?B?dzIza25LYVFSc29LOEcwSk5sdFVtV05USXFQNW1ZVzg2Sk14K0lPUm0yWXNx?=
 =?utf-8?B?TGQ5UUxwNlBFVndDWVlWZis2dVRlWTIra1VIbkdxYWJRbG9sWEJEMVhkbURQ?=
 =?utf-8?B?VXVNMUNFL2Q4cWFOOS9va29GRkhFUERsUUVjMXY2bWJSTnhicWhuT3Mxd1ZO?=
 =?utf-8?B?Vm9ENDVEZmYxRnBKdUw5QlBqYUF1L2dUWE1XaDF4TElTV1ZMbGVtbHp0OXVF?=
 =?utf-8?B?eG1IVjFlRm1XbWYvd0hocHRvam1NM2tXemc2eG1udFUxc0t6bVBRVnFsTDdP?=
 =?utf-8?B?QWVBeDF2R0puZXBwZkNReE5rWjdDK25pU1NZSmNsMkN6SytVNWJjMWJvZExi?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f49426-29a2-4080-e495-08dcaff81425
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 17:58:40.5874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmc+JJmh3BjDRxCs+KJYitHzh4nRaCkMGJvT4ozb8cgkTr7FEFW9mYbBn40fSbQVsIVMFeez7QDnwI+2mI31Jxm5tRaP3fPd5wgFiO92ih0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4694
X-OriginatorOrg: intel.com



On 7/26/2024 12:04 PM, Kory Maincent wrote:
> Hello Jacob,
> 
> Thanks a lot for your full review! 
> 
> On Wed, 17 Jul 2024 10:35:20 -0700
> Jacob Keller <jacob.e.keller@intel.com> wrote:
> 
>> On 7/9/2024 6:53 AM, Kory Maincent wrote:
>>  [...]  
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>
>> One thing which applies more broadly to the whole series, but I see the
>> focus right now is on selecting between NETDEV and PHYLIB.
>>
>> For ice (E800 series) hardware, the timestamps are captured by the PHY,
>> but its not managed by phylib, its managed by firmware. In our case we
>> would obviously report NETDEV in this case. The hardware only has one
>> timestamp point and the fact that it happens at the PHY layer is not
>> relevant since you can't select or change it.
>>
>> There are some future plans in the work for hardware based on the ixgbe
>> driver which could timestamp at either the MAC or PHY (with varying
>> trade-offs in precision vs what can be timestamped), and (perhaps
>> unfortunately), the PHY would likely not manageable by phylib.
>>
>> There is also the possibility of something like DMA or completion
>> timestamps which are distinct from MAC timestamps. But again can have
>> varying trade offs.
> 
> As we already discussed in older version of this patch series the
> hwtstamp qualifier will be used to select between IEEE 1588 timestamp or DMA
> timestamp. See patch 8 :
> +/*
> + * Possible type of htstamp provider. Mainly "precise" the default one
> + * is for IEEE 1588 quality and "approx" is for NICs DMA point.
> + */
> 
> We could add other enumeration values in the future if needed, to manage new
> cases.
> 
> Just figured out there is a NIT in the doc. h*w*tstamp.
> 

Ah, perfect, thanks for the clarification!

>> I'm hopeful this work can be extended somehow to enable selection
>> between the different mechanisms, even when the kernel device being
>> represented is the same netdev.
> 
> Another nice features would be the support for simultaneous hardware timestamp
> but I sadly won't be able to work on this.
> > Regards,

Yes this would be useful, though I think we're somewhat limited by the
API that returns to userspace currently.

