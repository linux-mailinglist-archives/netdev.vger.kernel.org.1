Return-Path: <netdev+bounces-131481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C21E98E9DE
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 08:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607D21C21D91
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 06:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4029580C1C;
	Thu,  3 Oct 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CajP5UXP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D298003F;
	Thu,  3 Oct 2024 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938444; cv=fail; b=VlJAyuYez82n48TBrV52lSVd0y/H5+MW48yWM+xqjKLkpo6gnvdPq2LcgIxiZBanf5+t17lNR8djykZiMXnM5ZnLN2ygXbc2PLKSZhxEkTARE+n6zcnTNUQgNu/BFJrMsZQCVxU+LEx2Pl8z9JW29Dtxq9O4N9gMJYXhGi06G7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938444; c=relaxed/simple;
	bh=EVmzDImtM8XRRNrQCLgcQy0Hpfa4w2n4xx5wTKdD8lI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GJfZA2G/HaZvwwiuj3MldJptApYqEFWIKxM2N4j7O04ysYcw7qD6rPhtvnnNl5DjLGOu2tQi7vin++nuSCCT6NAP0wQ7mw14CybRpOkn6AOolTQgugDmGAUkVxNWHSPePwb2wrgdu9kNIqXEsvgp9cMtIsa8lJNzS4hOHOn1TRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CajP5UXP; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727938442; x=1759474442;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EVmzDImtM8XRRNrQCLgcQy0Hpfa4w2n4xx5wTKdD8lI=;
  b=CajP5UXPyDvBeRXO9qb8tmpLdUNhOJ28Yby1s/s/gZu1cX27U3l/tNb2
   RHdbg+M3q4QVLfx/GPiOMtbyUbjrYDMC2ckRMYETlQKQ0S1ATgZsHx3co
   fbiATEnEOwZHpGblodRrtxSDjKb3052AGV21eGKGG9dQE+p9p5Rp4iCz1
   wFCV0SC+r/tH62oxUwA7CfCtxkAkH2UdfPCgKTflO0sq5CDyvneybXIwy
   3TfvvebQMNYlgAVxuSNirPZjlcDITJA5eluBrpEyfFFydsoFdT+cIUi/4
   T/nF6mPlSNWxdL1+qcnLFkrIAIFyb5e/Zvqsf/0i/BGnl+WI+XTIeUHnO
   w==;
X-CSE-ConnectionGUID: F7dS8UWFSdGtr7sS2Wzo3A==
X-CSE-MsgGUID: KwyFUH0RSIiAN+TmqRoLeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="31004509"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="31004509"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 23:54:01 -0700
X-CSE-ConnectionGUID: 7dLQRbODQb+vDyaK4KoWVg==
X-CSE-MsgGUID: WTZeMatlRCKp3iIZSC/n5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74281512"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 23:54:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 23:54:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 23:54:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 23:54:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 23:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZyQjWs3s9luROEXUoz+fomw4eZF5heudy6g9ak3AzQwQMgVewThsuYpk0tMPffi1GxqtNfgXbNCn22m4Rakp2IUnET5gaIWLXx2tZ5izrXQFkvySUqA9wXUHPuIugod3oxqiljvyB7ZSdpzPJINOGmbVFPkDLyLdTlZCC5ZuwDlklNamC6pKeTUEV7grEcxxI6Fvaw4pMT57RRuqQRnavdHqAKgMQGa+hjTz+m8j0a/dtM7BZkADrIIdGurzvM4g+QM2+oIxa7OwcRudRYW3XFQQHj1+PJ2NZMbIAzNexmsSrQViPpjFu+xAoql7c+gAvMQ8To70/T2JJYys8XH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU/jlDnp/T06Mr9oQ6XsRMa4r3QvSCRvXrsTHuVqFHE=;
 b=rghqtp5S+QNjxjluk3kYe/erqW8LJ6DfdzhKO9YZOT/ma/IhsiRcq1kQhQWEcz0nvTIKA0zSCoZAFOi81VLWy5vG1YNkfL5m111wT582N83Tjckd8WGGtW8sg196oYPdzZiT5TqeuElYKqR9JhpxSjUU5LdZiBv01lwrl1/U8qQV2es2wSQr4C69rFbHzmzKGbghf/R/houpxorUXouoY6y6fEBkO28EAdkMgR7RjpEBT+zB8vGY3uy/9wmWVvY+bgfmFj21Eq9ivoKX9zeJyMaytU6q8/U41iu9X7f4s2hwObJ6Yp1FdTnTi6Mhv/r42vAkmYn3jTaBYLjlLZly7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by DM4PR11MB8157.namprd11.prod.outlook.com (2603:10b6:8:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 06:53:57 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%2]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 06:53:56 +0000
Message-ID: <4f4baf9c-b9e9-4add-89d4-75f3150264b0@intel.com>
Date: Thu, 3 Oct 2024 08:53:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: v2 [PATCH 1/1] net: phy: marvell: avoid bringing down fibre link
 when autoneg is bypassed
To: Qingtao Cao <qingtao.cao.au@gmail.com>
CC: Qingtao Cao <qingtao.cao@digi.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241003044516.373102-1-qingtao.cao@digi.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241003044516.373102-1-qingtao.cao@digi.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|DM4PR11MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb664cb-33c7-41f2-777f-08dce37826d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnFuSWhuNHdkSVZaNVhuaUgwQ25nRWcyN2FWZEtnczlMaThFSUQ2cmlPcE84?=
 =?utf-8?B?d3dic0tQMVd3RUYxWm5GYXZJNEpZUWFNN1JPWjExVEMrZ2IvamZMKy9hQkRx?=
 =?utf-8?B?a3NHQ0tneEZzNGltT1o5c20vRDBuTVZ1emN3SmRpSDhWV1NkcUVJQXBoQ1M3?=
 =?utf-8?B?MlFwVUU3WGh3K2tjR2FVS3hvM2hPMmtSSUNlbUNRZnZGS3NzREh0NDdKNjlI?=
 =?utf-8?B?T0JrUjVlSWh1UThpNEFJUjg0SXBtQjFnZGZxZE9ackhsbjlyd3pqSHE4SlFt?=
 =?utf-8?B?NmFwOUJNL2loc2Z3WHJYeFJnVmhCNjVTL2FFYzY4Ym5kc1lzalhnM0dnZURv?=
 =?utf-8?B?L0JLd2x0L3ZjOTB1RzdGUlRmNEZNZStwcFlzTHdvaWloRWhRSFhPc0tXMzlU?=
 =?utf-8?B?ODZ0SElQMEJBeVIydW1uNTg0Y1NNSUgrTUJDMmFkM2pKcjBCVUFBdGUwdUx1?=
 =?utf-8?B?TjdkaG05bE0xa3FnVk5KS2IvZzcrN3NGa0dOcmlNVFhsRUdGQWlWTHZVa1Yy?=
 =?utf-8?B?VzkyV3lKdVRBZmJKZDd3a01OZUY2d2craDRvQUY3STFDOTA2cXArR2pKTkFE?=
 =?utf-8?B?eVNsVTZ5cEtiV2lIeWtnZkRZbWJTc3FJWERsM2t0aVJ3SlQvMXdCWUdhUDRG?=
 =?utf-8?B?WE16UDl4THljekQ3cjREOFJoUUZUVDNPOW0yZFpTTFg3T3Bia2xzL3VlZS9M?=
 =?utf-8?B?ajk5alV3S1BVMnppaTUyOUFqQ3RmYXhEYXZZUm9JTnlOTGN0bU9yRVlSSEt3?=
 =?utf-8?B?L0lMajcrLzNkUHppUkFWKzlnaVoyNm93UlpwSGJFK1pJK0RHN1ZjN1RBcUZh?=
 =?utf-8?B?QytoR0xFOVo5am8xTFhmcTlud0dZYU5EY2xUc2VzR2pqVW5pdm8yNHBhWlR0?=
 =?utf-8?B?Mnk4Tit4WmhPcVFLNGpPNjdaQXNIbkt6YXRZK3UwYzZlbnh1eFNsQ2J5NndB?=
 =?utf-8?B?bWcvOGplc2ZlamtMZVZzQUNrMUZWZnR5d2dnOVRzMU1pei9oanJVdWxvNGhM?=
 =?utf-8?B?bGtJQ1FjOXRpTXcybTZRa1BrbUVhKzNpcEtGMDNXd00wbDZTeWJXbHJKRVdI?=
 =?utf-8?B?WlN6d0NEWnkvdlpjc1FCZVc1UDc2SitibjZzMDZDc3dPbVZpK3QxVE1hKzdy?=
 =?utf-8?B?QTF5bkhETG82QmpqdlRVaDg3UGhWU2p1akYvSVE1THVPMlVDdFh6M0p0R0pC?=
 =?utf-8?B?R0gxWGxoWmt0K2dzdFRiYlNnN2c5c2JyK0ovNkxad2dMWm5maE1xRmR6RjFi?=
 =?utf-8?B?MDlmQ0piQ2pDREUveHBwSEVyZFU4TDNGa21tclF5MU1vVWNrbnRQQ1FYN0tN?=
 =?utf-8?B?bVdUeGRVcmVwNGNkRGt5RFdnTXFxVFA0RkJvQjBRc0tNT1dDZ2h5L2w4a3JT?=
 =?utf-8?B?eUdoK29DWkJ4TElxOTZCQ2djNEVOTVVLQVM5Z0VWSU9QbWZJbzVyaWVMWWJX?=
 =?utf-8?B?NzlyL0dPTVJiVzVMYlNBMjR2Q01xSEhHZTFHVmtXc3pOK0o0MTlxVzhSK2p3?=
 =?utf-8?B?bGRqWW9zTzdXQmx1QURyTHpjLytsb1lKdUpjazFCS2pBbXpadTlaWWI4R3ha?=
 =?utf-8?B?OVBhMUcvUG1kY3FwTEZRaDRWcmtJakJ0QVFZOGQ5cDM5ckxFc2pYWGtoOGxr?=
 =?utf-8?B?N1FRVXdoWTkrWkhLZzlzckFPM01Rc0dnUmdsd1h4TEdQYUlUOUpiLzJDYTU0?=
 =?utf-8?B?cjUyaXQ0TmdQT2U5aktvdHNIcllIc1FKbVVLOGNFVUwzZ3FnaXkwa3dBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk5yNXRUY1F3cW0vWGlFZTNqUG1vTlNCL01DTWdDQWVPb0Urc00zZVdldXkr?=
 =?utf-8?B?cU45VStiWE5OMVV1dkRuUmQvRDFSQ0p2R1pFU0FKR3B0RlVoZkJuN01oVVZl?=
 =?utf-8?B?RGV0bWNZNDl5K3kvdHUvVll0RWpwdmZxU2NmMzFGSXpPY3NiVGFLdFpTdldC?=
 =?utf-8?B?ZElRQStxWG53c2RxZUl2WkJpMnFKckxHdzRtYnc0Z0xjSUtaM25ZWUEvUHpx?=
 =?utf-8?B?M2t4UHBIL2x1WjFPNWl6OG1MdkNBTjVUUElpUVVxUllESXJLRzlmejlvRlJM?=
 =?utf-8?B?Q1p5WlQvUXZEMVM5WEFlK01uei8vK2tTWHZuWTV5RWw4VHdways2NG9obGsz?=
 =?utf-8?B?MTR2d2N6L1FMUjM0MDRGMTJHV2NQUWN2cXZyeTNFbFlTcXBaMVZTejdzVm5C?=
 =?utf-8?B?Ni9STm9jZHhJZ1FvakFVcmtkdXRFd0RrektuOE53S0ZLdjNqS3NXL1E2V2NQ?=
 =?utf-8?B?aEIrQWJpT2lVTGV6Z0MyVFh6U0NWVTAva1pZaWx0R2RPZUp3TnJlVUc0Ynhi?=
 =?utf-8?B?NGlJRlp2Snc4RUk5SDVHRTBqZHZXdFZ0V0Y2cHBHa0xzVlNvdXZhWndheEhy?=
 =?utf-8?B?WS9VeStXNmc5SnJoZG1CckcrR202Z295ckxWaEl6SjJHT3F6S091MjlHdUM4?=
 =?utf-8?B?SWxSVEtVejM3TElWU1dVd1pVczBHWEVJOVphKzVaWHNBMlF2dGZEa0I0WXdw?=
 =?utf-8?B?emNaRmNPZFJmS05DRmY4L1dTczlzTEZ5emIxVVUrZi9rU3BPeWxYVVd4SWti?=
 =?utf-8?B?QVEzUFB4dWRYaU02MmdQN0xwNTErdmhEUy9XN3g3NFpzTUJxRkFHbW5ueVQv?=
 =?utf-8?B?eXJlaVgwUDhmU2xFL2drNWNta0svY3ZjaVJYcWo1KzRIMW5lWitmQmNIUEtV?=
 =?utf-8?B?c0gyczFLVHAvdFdGNzgwQWtHUi9NT1RnSTNxU0RvRlArSWNnSW1aMTl2MFFs?=
 =?utf-8?B?Z0ZWUFFFZHJaRnVISjk5dStQNjBEUFRTRDlBbzZWc0tRUE16bEI2RXVmWTRz?=
 =?utf-8?B?d2dpalZ0WUtoM2J3elBnMHBzaTlMSStoSE81UkpIYUxJMk15dFAydW9pRHJ5?=
 =?utf-8?B?SEdOWENYRk9SRXAyV1dyNWNnZEd4cjFWMUVubGdPOGRscWVoR3ArWVJOTUJZ?=
 =?utf-8?B?ZEZ4MWI4aU1xUXNoTVEwSUZkMlMxeHY2MFpZMnZSOUlzTFlQcGdDcUcwcXkz?=
 =?utf-8?B?OFFUbkhnc1FjZ2trdzA2SUhSdkw1M2UzUXFLYUtRS0lmbDNUVkNFc21BL3Rq?=
 =?utf-8?B?Mi9uc1ZTSCs4dUJBN1B5WmZBWXRueDAyN2RCUWNkK05tZzgyQ3VXNkRObk1p?=
 =?utf-8?B?eXNZTmZhaG1OeG95MjZDeURPUHRQNzJBZGFSWHo3aUhZUmFXU09qL1N5R3px?=
 =?utf-8?B?MlRYelFuWSt5YzEveS85UmdNTWI4cWUyWVBWbUJkTWVadDVwZDRrMXNSei8v?=
 =?utf-8?B?cmNrSitVQkdmbExtWGRnaEZGYU0vTVFiWnRvSE1Da2hOZzcxZUJ1Q3pFTit1?=
 =?utf-8?B?UnRWNktMUlZiSFNDajJoa2taRGNKMEt5ZW5WWDhEeVNoUWpSTlAreXc2SXpr?=
 =?utf-8?B?WFJ1TWV4RWlORHA1a0RlZ2lFRWlzYWxVdUlrVXRrTnVDUVpLOXhnRjR4RVlZ?=
 =?utf-8?B?QWRqcW56RFhuQ21aVXorWTNIcFpZalkrc2tCMnFzY2pkTjExMHVENnN0UXZ1?=
 =?utf-8?B?U2dwTUpoalFUK1FuY1RVcDYvaVJQbXpuSjFDUXpyVFdmK0N3R3l2di9DNWlz?=
 =?utf-8?B?OUloM1ZFb3BLdGxvUkFoNEhLQjluV2p6RTJ3ZnJMMUovUm52YUpMcU1JcVcr?=
 =?utf-8?B?NXFHbXltWm1GdytrTnhhOWJDWG5YcUp5NGtlYUdEYjhyNUVOcFhLOEJxUkFv?=
 =?utf-8?B?Q21xd29MNkhaNDV1eERjV3RyY24veHFSand2K1R5dFFLUXhJVmpHYW5GbVc5?=
 =?utf-8?B?Q29Ca3dhUXJqMkpleGJYdDNmN1VtejlRUEs0VjFmcnZyQUFBOFZjM3FyZFAx?=
 =?utf-8?B?Z2FobnlERE1LVHMwOWQwa01xRmMvbkxNZWd5Mld2NlVUblc3NjJ5dmllb2pH?=
 =?utf-8?B?T0ZjQmpONE5ZOTdUVjFlT0kxSkVLRnBqSW1OOE1scEJNNjBBNThjT2pva2pl?=
 =?utf-8?B?L0hpS2V4YnhIS1IxbFRZSU5EZnpaZDNZdGlzQlZiUTlyZTk2ektNd3V3NGwx?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb664cb-33c7-41f2-777f-08dce37826d2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 06:53:56.8435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wCD/libKX2MIuJZNFH5FcZNVGy4yKzP1hLEI2/KghAgVXlgL0mHkGAMRzf7aaz3VaQ5pORwAB0W812D9Xg2/o9vu8J6ZJleiHzKRpNLuiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8157
X-OriginatorOrg: intel.com


On 10/3/2024 6:45 AM, Qingtao Cao wrote:
> On 88E151x the SGMII autoneg bypass mode defaults to be enabled. When it is
> activated, the device assumes a link-up status with existing configuration
> in BMCR, avoid bringing down the fibre link in this case
> 
> Test case:
> 1. Two 88E151x connected with SFP, both enable autoneg, link is up with speed
>     1000M

checkpatch.pl complains about this line, it exceeds 75 chars allowed for
commit msg. Please adjust.

> 2. Disable autoneg on one device and explicitly set its speed to 1000M
> 3. The fibre link can still up with this change, otherwise not.
> 
> Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
> ---
>   drivers/net/phy/marvell.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index 9964bf3dea2f..e3a8ad8b08dd 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -195,6 +195,10 @@
>   
>   #define MII_88E1510_MSCR_2		0x15
>   
> +#define MII_88E1510_FSCR2		0x1a

Please use GENMASK_ULL for creating mask.

> +#define MII_88E1510_FSCR2_BYPASS_ENABLE	BIT(6)
> +#define MII_88E1510_FSCR2_BYPASS_STATUS	BIT(5)
> +
>   #define MII_VCT5_TX_RX_MDI0_COUPLING	0x10
>   #define MII_VCT5_TX_RX_MDI1_COUPLING	0x11
>   #define MII_VCT5_TX_RX_MDI2_COUPLING	0x12
> @@ -1623,11 +1627,28 @@ static void fiber_lpa_mod_linkmode_lpa_t(unsigned long *advertising, u32 lpa)
>   static int marvell_read_status_page_an(struct phy_device *phydev,
>   				       int fiber, int status)
>   {
> +	int fscr2;
>   	int lpa;
>   	int err;
>   
>   	if (!(status & MII_M1011_PHY_STATUS_RESOLVED)) {
> -		phydev->link = 0;
> +		if (!fiber) {
> +			phydev->link = 0;
> +		} else {
> +			fscr2 = phy_read(phydev, MII_88E1510_FSCR2);
> +			if (fscr2 > 0) {
> +				if ((fscr2 & MII_88E1510_FSCR2_BYPASS_ENABLE) &&
> +				    (fscr2 & MII_88E1510_FSCR2_BYPASS_STATUS)) {
> +					if (genphy_read_status_fixed(phydev) < 0)
> +						phydev->link = 0;
> +				} else {
> +					phydev->link = 0;
> +				}
> +			} else {
> +				phydev->link = 0;
> +			}
> +		}
> +
>   		return 0;
>   	}
>   

So many levels of indentation... Couldn't it be merged somehow? I do not
know, maybe create local variable, store the current state of
phydev->link, then set phydev->link = 0 and restore it from local
variable only if (fiber && fscr2 > 0 && (fscr2 &
MII_88E1510_FSCR2_BYPASS_ENABLE) && (fscr2 & 
MII_88E1510_FSCR2_BYPASS_STATUS) && genphy_read_status_fixed(phydev) >=0 
) ...

or other way? Now you have 5 (!) levels of indentation and almost
everywhere you just set phydev->link to 0 depends on the condition.


BTW. We put "v2" inside the tag in the topic and specify the tree, so
instead of:
v2 [PATCH 1/1] net: phy: marvell: avoid bringing down fibre link when 
autoneg is bypassed

it should be:
[PATCH net-next v2 1/1] net: phy: marvell: avoid bringing down fibre 
link when autoneg is bypassed

