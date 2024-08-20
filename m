Return-Path: <netdev+bounces-120234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84C7958A1A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088D91C21790
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F7719004D;
	Tue, 20 Aug 2024 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3micCPS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3F82745C;
	Tue, 20 Aug 2024 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165341; cv=fail; b=VESziDVU/dl1DmUKS+Op3pjR2iXEbV4aZBkn1WreyjVGrL11N1Si6gOTQG9Q0JmRFmWPTXbJZXWOpL0oMREicUYi5zEV1iC3LGSAsDrdnH4KPvcwOhmhtkNnLniM5g9kqGn6XDzagPfg/9brWAWSsmZiZ7KKicIBuQmHlAuZs+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165341; c=relaxed/simple;
	bh=ckFe+o6PioBGvThMPWXbbtA5RFqUzcjo/TLoJ2q+4YA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OM8jBLZ6dxdj++ShzaO0rL5A4LT5Bk/3FOn+FSSJTHtroyhBZOXWXf/fmlxFt+U88OvP95d1tK61gIU2SLCRLAExXsvhrVhPT6Lm6RpnMEYoAoymGRt2FDqPdzQnI0tYUttpebpVRGVNs8/REdXmppY6UkFg33sw9FVCU8sYg78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3micCPS; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724165340; x=1755701340;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ckFe+o6PioBGvThMPWXbbtA5RFqUzcjo/TLoJ2q+4YA=;
  b=M3micCPSskGIxGNA0spWUo6THoZP43YANkKoH7xE79MAaaAhE0cLVyu2
   J0ToRVYWJC04ecvzCo4THZ4JoAPP4LnkYUc3sro7zO4kWGt5PTvCKCzsL
   N5VzXiK/+87OdC4AUDQUZN9nivbAQKP/0itS30be2wVTS4YQ243RAJZW+
   NYBOhOcKYNIsW/Ks5ZwEVRH/uT6xIApVdDEX1g0wApInuRbGqXih0/mNg
   dTnz6aNIPHlRZ9ggXXrtWtldOdpdZf20m9RjkIRSgyTGgNprKoJDAlz+K
   Bc7h+aNskE/5ZseO7otu2eHRFkuSlYA45ZQNkIUj2ZDBxrEoprmTZ9xxv
   A==;
X-CSE-ConnectionGUID: S2lsUevtS8m70L+SKoJZkw==
X-CSE-MsgGUID: JGsu1o6nRHexEcjl/aeaEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="47864720"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="47864720"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 07:48:58 -0700
X-CSE-ConnectionGUID: 6+DhYhETRDibd6e19akpqQ==
X-CSE-MsgGUID: CEiu2mBsT5eQbyEeXSaMiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="83959663"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 07:48:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 07:48:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 07:48:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 07:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfS8LOkHHkFJhgwtcfzL5sD41XcfWZvJjkMcyR6+og+7TlKmGF0k4UmTjlsuC89AAaqx7tBXkPeUrKQes7d8Ib759o20ifSMPGWKevES5agIqOW+ml2L8NA+NvFwweVMrhSzxHE4oPRupDKXX7yADxwqUG39ty3YbqHkd7JJcKbMDmajRax/FBZifxyGzWLs30g42GjU47R0JbfdRPHHI9kxZBEfP327ZcVB2LeZVbbw6eplgpOhT+VmJK5c9CPJ5DCL9s/GxCSyOzjeBV8Nt6wQ32Lt21crPMe19/dVrxHT4KCMJoFrPP9LmHk9PgaBTLjBRJuKlLvxIpqtr5ttzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4izu3HHXDG56kq5ir1+YkpBOKpbXAThH9iBoCx2Oj+I=;
 b=Qhv6kVR9b860fGXVw/+hqkulEoXyXKIpFBCAzngu6lE82zEJQCINUv3n/zwRI5L3gnSSfHmpx2xzCsQjtrncK8vindZ6d3ele3sDBKIIZ6BILwApDQRUj/cswh64yfgvfuiymrasWoamNEanalGXWHaB4HA8zn5tnp4acqIQbvAzQvHcC5Li1UsXsQyTFHR0NrTxaIuXvXYyZryT6QzInsh7i7/77up7KkKjnNug5lwpv38ayqmKxYMnl0vXqOyUvL6htog9sKOt4hrzqgZSwudOSEugEVVZVsbqGF0RnVHUhSEPNciuJWrBPPBbAWnqgDbhxRsbqHspmhXIgo9PRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6235.namprd11.prod.outlook.com (2603:10b6:930:24::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 14:48:54 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:48:54 +0000
Message-ID: <69ae0aec-1b70-4964-9f45-3e468fa277a5@intel.com>
Date: Tue, 20 Aug 2024 16:48:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/7] net: stmmac: configure FPE via ethtool-mm
To: Furong Xu <0x1207@gmail.com>
CC: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Joao Pinto <jpinto@synopsys.com>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xfr@outlook.com>
References: <cover.1724145786.git.0x1207@gmail.com>
 <79c52f8ce576a5bb6027f806250f1f8286707c5b.1724145786.git.0x1207@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <79c52f8ce576a5bb6027f806250f1f8286707c5b.1724145786.git.0x1207@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0002.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::9)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: aa35a0e8-f806-4671-4276-08dcc12736d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YS9DY0UzQ3lGekdKTVJhU3YxWHJ2WVF2cHE3U0ZORkRxZ3VQSFhxdVhvV2U0?=
 =?utf-8?B?Q0szNzdSK2FBdEszMEphc2Uzbncvb3dVYVM0VWhUMjU0M2lYd1gyajJLRVVG?=
 =?utf-8?B?Zm9ZMlQ0bzNubmFaN2RZVjI3VVpyemtTSW1hOFZTdm96ZzRsTHd0aElZYVFE?=
 =?utf-8?B?UzIzRmNZbHYrNEFIM1ZTSWo0N3BqUmIwaWVJbmE3QUxPWkxGNVArTjJNd1VN?=
 =?utf-8?B?V3V3QUxDRnZubTkzSUJFdDJNYkNVYkl1RE1WUms2SmoxNW9qR2xPdkJpRW94?=
 =?utf-8?B?ZVNDbnE2RVRaZi82dFBGSnZQRUVZYXRLMm5EZkpweFhwVFVjcXRZa3diWUt5?=
 =?utf-8?B?SUJVTGx3L25ISm5EWDAydkNDYmVKUVJsbWZMT0NidDFDZEJ4WkFYczVTWVVk?=
 =?utf-8?B?MG5zQ05FcWdyMUxRc0VUNVpTRjZod0Y0LzRuVXlXMFErbnZTOHpwZ01LMnVh?=
 =?utf-8?B?N2xESExvYVlHalBONTRaenB2S2hiOGFBNjFmRVREM1BtU3lacFRzZWhBTXgr?=
 =?utf-8?B?cC80QzQ2aDV5YWlzVlF3dFRTTVlwWnM5dFUvK3QrMFpPU1JhUmpQSk9MNzBE?=
 =?utf-8?B?VW1nekRWQ2k3bGFHWE9PQlEzaVU1UG1LSHppRTdsQURzVG5OOUs2WnVhSHVK?=
 =?utf-8?B?dk14WlUzQnltcWtMTWpaSDgyU08rOHFJbTd4SmxlaVNvMkY0R1RJVXA4V3I0?=
 =?utf-8?B?WGphdmh3ckZORlRSWGdXVkN4bXBPUW1KVGlDY3lOREtOY0NvTWJwTzBDNmZ5?=
 =?utf-8?B?OWpGTWw1eEplVFNJdzY4ZVJETHNIaXRTZVpjOXQvMjBjaUx3U0lDTno0V3Z4?=
 =?utf-8?B?aW9qK3ZCeHFvUzY4SFRDRjJDb1J2MngxcmFpSHk5bDFON05UWmpXMnVLejcw?=
 =?utf-8?B?V3JDV2h1TG13N1VCYkp3d2pMUVZyRDZOeTYyNGN6UzNDYjh6cldCT0pJNE1M?=
 =?utf-8?B?N3JNU3dvWExXaWxPTXZiL3RoNjJTMUZxMEJ1eWMwZVNkRXhJUWJaaHhPR0JG?=
 =?utf-8?B?b2E5MkVPREFiK0xrZWhYaGtwT2trWlJDdEJkdzA0Qm8wOVl1dHg1MVdUb2NR?=
 =?utf-8?B?cnZaV1IxUnZPQnNMdDVNZ0doWUlxMGFQS295dFk4eTFPWlVTUVdsVkRnaVNk?=
 =?utf-8?B?RmdMOU41Z2dXd000dGNPdjNZRGpDc2lwTEFlVmlJeWxISG1sSGxQYlpRZFFS?=
 =?utf-8?B?MXk0TGlxZDZFdGtXeGcxRFJWdm90S3E0OUs5c1pGMTlRTGs3RDlGam1hQ1ow?=
 =?utf-8?B?T0o1ZjZndnVPUXpZYzJBNHJqRWpyTDArM2psa2hETnliWnkyR09mVzhiU21t?=
 =?utf-8?B?VUVubnl3MTRnMExQamRtMU5tOTJCczkzVzdoMWo0S2JYMmlCTG8ramk2ek9k?=
 =?utf-8?B?MXNLL05wMjNaeVUzSGNmK3RDRWF5NTVDbGxYdzFxVG16cUZzV0MrNWtKUWhh?=
 =?utf-8?B?REpodkc0TnBJbGRKTXRPNk1EVUxlR3VaYzAzbHZ4bDJOWWpPdktDRjM2RXZz?=
 =?utf-8?B?N2I3OFhGbDZkcWVqZ1JUeFBOblR5WnNaOWxSMEcwMkEwWkxueDFETnoyRy9t?=
 =?utf-8?B?M3N6UVlIVXNRbUNvLzdoMzZwdHA4YldCN1h5eldXVENkemFDS0sxTWkyWmJr?=
 =?utf-8?B?alBGNVM0OHFCNXFBMjE2QUhPRnZvN01pMlFUYzc0ZmhwdkNNdVRuZ0RnR1RX?=
 =?utf-8?B?YWJJOHpmbWJzeGZ1MFhPRmd1SCtmUkdEK3BJa25yZmU2b0N4MzIzOUk0TU9I?=
 =?utf-8?B?enp6Vk5Kbys3OHRLZmVZbkNDc1ZKL1VKZzdhNGhiSEhWeWtIWnMveURFTEt4?=
 =?utf-8?B?RHVrTU9RYTdvWTlnZnVaZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHY0UzlYQytKYk5TbWtBM1VYVHR6VGJNS096UjlCMm53QVBISVhtU2ZoOGtx?=
 =?utf-8?B?TjdyRHU0R2lKdHlwVXEwZ1hoRVhpcXR6VUY5Y0dwV2xuRjJJMTBXNXpkUWpm?=
 =?utf-8?B?UlJlcnpiRkZEUW9DWlRZNUlxQVBCaHR2dktwTFZPN3l0dGxqK2h3ZWtPOG42?=
 =?utf-8?B?by93WUswOE16bVlmOHpGZFJ2Sk9xeWxzcURMN1Z3NC9DYTB5b3FNYnBJOFk1?=
 =?utf-8?B?Zy85VDZZU1dEeVRkUFY5SzY4Qmw4KzByUk5Hd0w3Vk1hQUs1YkVGOTRySWpG?=
 =?utf-8?B?bWFMbDhVa3BxNlE5UEEyWEozaDRkMTVyVjBjTjlTN3NjN3g1T2lUZW9WcG05?=
 =?utf-8?B?QWZxRXF2TVppc3FMb01aWExxanltRHRvTExsZTBONUtaQmV3aytyRDRDNERX?=
 =?utf-8?B?RHRycXdUcmdsVWE1MjBwa0NpMTBKbVJoL1hSVUdzZ0Z4STlUbWt1M0pLTXd4?=
 =?utf-8?B?SHpVTjJ5YklqMXZRcExEYStvd216b3FhSmdVSmJOQ1NTaG4vZTRSMVJvd0Z0?=
 =?utf-8?B?b3dnK2dpQm5SZURRWDFlMjhoaEFVZjUxUVJ4b0V0NlRpM3k0SG93MCtVK0lQ?=
 =?utf-8?B?L1NoSTZ1eEgrdWQyKzFPOVpwQmJUcHZlUG1McllOUnVaK25rRkZyZVh3ZVhh?=
 =?utf-8?B?NTdJSDZWeENHNnZReFlTcHNCeUNRd0JTaGRtMFQzWndKakxna0RIZlJSTVk1?=
 =?utf-8?B?U3VmYTJVR0tFUUJPd3E4UUNUVlRoaGYvblZQNnRZTVZYaGFQbkFacmdndUZm?=
 =?utf-8?B?L210bkZTNU9WenR3SDFTOExKeGs5YWNhSTdHMmJlRkk5RXFFVTFjczNVRWJj?=
 =?utf-8?B?VUsvVjgvUVZnNDlnTHI3ZjMydmZ6NVBkb0RLMXpIUnhDRHZIakNKbk0wWFFK?=
 =?utf-8?B?V0VLU2RCU3FxVExwSDB4RldKM3M5WjgvNUhGVmVWOVpLTDczWDRheWNoZk02?=
 =?utf-8?B?U0RMVEZGL0lkME9BVVlxdEh0b0l6OGNVTkIweEEzRW9GcFJScHZiN0wxUmhl?=
 =?utf-8?B?U0k1Mkw4NDJLVWZwVXl1dTZ3bjJFMytuU3U1TzdmZ1dBUG43NzNhVmF6MHZ5?=
 =?utf-8?B?TXc0WjIraUdvNm5nVElEUVNoTUVUTlVoZTd5Z24vVTRpUTlCVlJNQTM1bzY4?=
 =?utf-8?B?TE9DMndmcFo5MjlGandKN2RtTUttdEkxY3hwVFVvS21rM3NxL29Cd2lER01r?=
 =?utf-8?B?TWkzZHVUbmp0aGN1NjFwd05FWHRibWRiNHJ0RHlnRnF2MzRvSWJFOFcrdE5Q?=
 =?utf-8?B?VFFzaTd1VHYwcUt2Q00zbWhZcGQwbTltUkd0K0V5QlE1UXNnemRVZFpTMnhM?=
 =?utf-8?B?UHVmNm1mR2NwYSsxbi9YcjdwK0hnRVdtZldETEw1TDhiYmsxQzNoazVDWUsy?=
 =?utf-8?B?ekc0ckNxazdmRFNpQkdjMFBoUGlTLzBMZGhydDZXZEl5aCtvWG1uLzNUY1pU?=
 =?utf-8?B?RWgybmFROVY0SUZtNGhkSDh4TkIrek1BZ3BweEhuUVkrdjNMYVlUTDBkS0hN?=
 =?utf-8?B?alhTamUwT2YwMy81QlZoRUxHakR4YVN2c2s1bUlieGluNjYyeDg5WjhWSjNR?=
 =?utf-8?B?WVJ0SlRrbjhPZVFpeUpKOVloVXRyOHBDYjVUTWFzd0JmczUzMnpEYWNtVTI1?=
 =?utf-8?B?bFd6aVdBQ0crKytNZmZEdWhrTUZRdHd4aFNnaHoyQW9ncFdscE9WSVdJZzdn?=
 =?utf-8?B?Z0NpUzlTa3IwdVRML2NUZ3FLbnRkbk5vRWFnSmhzLzJWUXBZVkhUUFcwenln?=
 =?utf-8?B?SjZEQzJYd2JVUGwrV0ZVQzZFVW5JUDdTbHFYQysrWS9HNTJnQWNKTEJWNzdG?=
 =?utf-8?B?RUFBMGp4S1d4N00rb3E0MlV6VFUzV2EvNWQ5Ky9oTng4QXFQd3JqMnBldW9X?=
 =?utf-8?B?M3NvcW9RMWlpVTVzQVNTeVBxd2xyWVBXb2txcDFINFJCZEpOenhrU1pJYTNh?=
 =?utf-8?B?Y2VJa0JOaWxSdUdHQ1Z1bnkvYTI2ZVFIV21XVmEraXJjT21sS2p2MEh0NmZ4?=
 =?utf-8?B?L21RN0Q0WW5Yc0pKTE9OeUpVK2M0MFVTVWdjek1NakNBa0NtNVlxeGFXL1M1?=
 =?utf-8?B?N2hYNFR6MjE0WHltSUdHVzYyZmxSM2pSSTcrdlFEd3pHengremJGMGEvSWpC?=
 =?utf-8?B?UDdsb3lTVDh3WkNIazQrMG5kNFpFNkdRVEhqNFNlVEV6QmxvTitucG11enVz?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa35a0e8-f806-4671-4276-08dcc12736d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:48:54.8653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mE/zqJmsxtUb/sqMNwok/DffoYP8wd7GGsdRq17NZcItWs9T7Wxnrs2JQsBoqZu+Ipd+qd4ou7tRRITAGFLTQxfKwO6xB964v4raQy40Y2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6235
X-OriginatorOrg: intel.com

From: Furong Xu <0x1207@gmail.com>
Date: Tue, 20 Aug 2024 17:38:32 +0800

> Implement ethtool --show-mm and --set-mm callbacks.
> 
> NIC up/down, link up/down, suspend/resume, kselftest-ethtool_mm,
> all tested okay.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

[...]

> @@ -589,6 +589,21 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
>  		cfg->fpe_csr = 0;
>  	}
>  	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
> +
> +	value = readl(ioaddr + GMAC_INT_EN);
> +
> +	if (pmac_enable) {
> +		if (!(value & GMAC_INT_FPE_EN)) {
> +			/* Dummy read to clear any pending masked interrupts */
> +			(void)readl(ioaddr + MAC_FPE_CTRL_STS);

Are you sure this cast to void is needed? Have you seen readl() with
__must_check anywhere?

> +
> +			value |= GMAC_INT_FPE_EN;
> +		}
> +	} else {
> +		value &= ~GMAC_INT_FPE_EN;
> +	}
> +
> +	writel(value, ioaddr + GMAC_INT_EN);
>  }
>  
>  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
> @@ -638,3 +653,20 @@ void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
>  
>  	writel(value, ioaddr + MAC_FPE_CTRL_STS);
>  }
> +
> +int dwmac5_fpe_get_add_frag_size(void __iomem *ioaddr)

@ioaddr can be const.

> +{
> +	return FIELD_GET(AFSZ, readl(ioaddr + MTL_FPE_CTRL_STS));
> +}
> +
> +void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size)
> +{
> +	u32 value;
> +
> +	value = readl(ioaddr + MTL_FPE_CTRL_STS);
> +
> +	value &= ~AFSZ;
> +	value |= FIELD_PREP(AFSZ, add_frag_size);
> +
> +	writel(value, ioaddr + MTL_FPE_CTRL_STS);

	value = readl(ioaddr + MTL_FPE_CTRL_STS);
	writel(u32_replace_bits(value, add_frag_size, AFSZ),
	       ioaddr + MTL_FPE_CTRL_STS);


> +}
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> index bf33a51d229e..e369e65920fc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> @@ -39,6 +39,9 @@
>  #define MAC_PPSx_INTERVAL(x)		(0x00000b88 + ((x) * 0x10))
>  #define MAC_PPSx_WIDTH(x)		(0x00000b8c + ((x) * 0x10))
>  
> +#define MTL_FPE_CTRL_STS		0x00000c90
> +#define AFSZ				GENMASK(1, 0)

Can you leave comments next to definitions explaining what this is?
I guessed AFSZ is "added frag size", but meh...
Also, I'd prefix every definition with some vendor prefix (STMMAC_ or
so), otherwise it may conflict one day with some generic one.

> +
>  #define MTL_RXP_CONTROL_STATUS		0x00000ca0
>  #define RXPI				BIT(31)
>  #define NPE				GENMASK(23, 16)

[...]

> @@ -1270,6 +1271,112 @@ static int stmmac_set_tunable(struct net_device *dev,
>  	return ret;
>  }
>  
> +static int stmmac_get_mm(struct net_device *ndev,
> +			 struct ethtool_mm_state *state)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	unsigned long flags;
> +	u32 add_frag_size;
> +
> +	if (!priv->dma_cap.fpesel)
> +		return -EOPNOTSUPP;
> +
> +	spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
> +
> +	state->pmac_enabled = priv->fpe_cfg.pmac_enabled;
> +	state->verify_time = priv->fpe_cfg.verify_time;
> +	state->verify_enabled = priv->fpe_cfg.verify_enabled;
> +	state->verify_status = priv->fpe_cfg.status;

See, you could embed &ethtool_mm_state into &fpe_cfg as I wrote under
the previous patch, so that you could do a direct assignment here :D

> +	state->rx_min_frag_size = ETH_ZLEN;
> +
> +	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
> +	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
> +	 */

Also make it a definition.

> +	state->max_verify_time = 128;
> +
> +	/* Cannot read MAC_FPE_CTRL_STS register here, or FPE interrupt events
> +	 * can be lost.
> +	 *
> +	 * See commit 37e4b8df27bc ("net: stmmac: fix FPE events losing")

I think it's not needed to leave commit references in the code?

> +	 */
> +	state->tx_enabled = !!(priv->fpe_cfg.fpe_csr == EFPE);

tx_enabled is bool, you don't need to add a double negation here (the
parenthesis are redundant as well).

> +
> +	/* FPE active if common tx_enabled and verification success or disabled (forced) */
> +	state->tx_active = state->tx_enabled &&
> +			   (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
> +			    state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED);
> +
> +	add_frag_size = stmmac_fpe_get_add_frag_size(priv, priv->ioaddr);
> +	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(add_frag_size);
> +
> +	spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
> +
> +	return 0;
> +}

[...]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 6ae95f20b24f..00ed0543f5cf 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3537,8 +3537,21 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
>  
>  	stmmac_set_hw_vlan_mode(priv, priv->hw);
>  
> -	if (priv->dma_cap.fpesel)
> +	if (priv->dma_cap.fpesel) {
> +		/* A SW reset just happened in stmmac_init_dma_engine(),
> +		 * we should restore fpe_cfg to HW, or FPE will stop working
> +		 * from suspend/resume.
> +		 */
> +		spin_lock(&priv->fpe_cfg.lock);

I don't think this happens in the interrupt context, so you need
_irqsave() version here?

> +		stmmac_fpe_configure(priv, priv->ioaddr,
> +				     &priv->fpe_cfg,
> +				     priv->plat->tx_queues_to_use,
> +				     priv->plat->rx_queues_to_use,
> +				     false, priv->fpe_cfg.pmac_enabled);
> +		spin_unlock(&priv->fpe_cfg.lock);
> +
>  		stmmac_fpe_start_wq(priv);
> +	}
>  
>  	return 0;
>  }
> @@ -7417,7 +7430,7 @@ static void stmmac_fpe_verify_task(struct work_struct *work)
>  			stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
>  					     priv->plat->tx_queues_to_use,
>  					     priv->plat->rx_queues_to_use,
> -					     false);
> +					     false, fpe_cfg->pmac_enabled);
>  			spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
>  			break;
>  		}

[...]

Thanks,
Olek

