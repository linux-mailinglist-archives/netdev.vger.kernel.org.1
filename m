Return-Path: <netdev+bounces-111624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05B7931D9A
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBF11C21793
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 23:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B41142659;
	Mon, 15 Jul 2024 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLa5N2Mo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35765433CB;
	Mon, 15 Jul 2024 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721086126; cv=fail; b=pZoROktW/Zwu/8vBDSW+gCi/VxUk1SNCGlxQkVjbrSx041n1FRULTCq2yTJ/7m26o98enOjQpCEd1m9g5NKFxN+WAoDjwMGbsQdZOSxdybUcJ65AcVIN6+njLLZ9ZOS+GH7tBpDaAH5nt/L1l2KYgpJZsnM7Hxtek1+zZHOfP5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721086126; c=relaxed/simple;
	bh=TNY39L8mFJpMPlgpx7iYEKaQ0SS1R0AbmJPnosxy/58=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p+PcL2ExiTvGYw0dQCHa5H5svb4OiGHbUA3Otm2b/XvZzRJC19ZDK/GuBrtuV4FsLx5q8e7QndSLq8/IlFyupAwty9JCjqE+Vw9XCwvOf3L8kbZOQJUKZ71Vv1wizW3JFttPlU4kNIQOv8AhbL45LrdymnBSUKoUbxFVSzIY7S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLa5N2Mo; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721086124; x=1752622124;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TNY39L8mFJpMPlgpx7iYEKaQ0SS1R0AbmJPnosxy/58=;
  b=fLa5N2MoPZJPQe2H68jPoHh5MzCIMG9GSJYK/Ynxf+s9tpdQTFO8GMxO
   YaTpp08l5oZj+oDfrEoHIeQ4tH24amgZJ0VNVHmCGwdGUtKdixY63jZQx
   3HNsu55bPY1b4ZtlTmOLscRCCxF0W0KMACrB31hAE7ikZSSHw54eFaewo
   KzQLli4h2y3d6MUXp3OTHGf4H/Tc8nI97/mBohI5YxxpArmPIA2dBaViM
   BCDriR0zQqQlF+rpHJAizWIkNVemDjVK+UIWbZWbs0wtM97LqF9q1WDdA
   mO1CcI/F4nnnk5lpUlPsNg+3q2ow5ESx0kMV3eVZVFWPCk2bsc/2PKdpf
   Q==;
X-CSE-ConnectionGUID: vcEyjTBUSvePzhpwD+5Taw==
X-CSE-MsgGUID: cnXl4/58TZKtncz6fP1CBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18633199"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18633199"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 16:28:43 -0700
X-CSE-ConnectionGUID: uW3vQFodTNKqkLH8yawiXw==
X-CSE-MsgGUID: cG0XaUfFTju0xjSy1pfqzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="80870875"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 16:28:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 16:28:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 16:28:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 16:28:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrDmIhBD4FZWoWt3nLh4dzukjkc2Nj5D7xlHakJGd2QojRHaN+zU9xl4OIQDIYgrk28E1ValP7ZD5ryRCb7xmPsMilQHZBZSRtFmg7qR8J+cxSPH/rsof6BPm4smqb2/KFM06abWzBwJ8JApn+tS8q7YWO5PdxAmgwxUzYj63kVTdBRFiHg0HKAbH8L8j5UDPMDhz1PcwrpXDZuB8MppcOZibwXa1yqnh8BpHc/bxcMKbqElzx85L1UmrfVyB3qVOFpd3tymA8TAhiPUVWra/vQf3G2a81C+BdVraxeZ1NQD/+9IhECmhGRe3AIKL3SCXLBldqgvdkzcF05FB55zAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBFwHm6noJ/Q20b6UkU83ep45WGpT95KVQI7ERyh58E=;
 b=IKz0gAVNwq9SKRpt0iuWHJ4nJO1JCKPXvRLQppNIuIkguvfGX5S9ur91wFDYYz08Chob4hwHuEGOaQPI5NTbiMtkLdqM9RQ2Q6Q54nABAob3r7dbzNcNTgeHCPeru4qqiJC6ItyyvBt2Zd88HvAv8dQFxLYT8wGoU71v72iKjED2FjjGSdbryW64fwd+NW0acAfqK4igxTYyPJIlz+FbprHXKwxxQev20RjdTm1Inzo0wZr11b1MH2E6I+Gd3xYVQGjEnW7FdoKon1eJa5T7ckM7po+xgZiff63ldl97doHMNyP8q3pML/CWYg87YBoEneJaCXZnFhF5P8ugJN1F9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6359.namprd11.prod.outlook.com (2603:10b6:8:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 15 Jul
 2024 23:28:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 23:28:39 +0000
Message-ID: <015a85bb-b775-4752-89d2-459ea6818701@intel.com>
Date: Mon, 15 Jul 2024 16:28:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 01/14] net_tstamp: Add TIMESTAMPING SOFTWARE
 and HARDWARE mask
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
 <20240709-feature_ptp_netnext-v17-1-b5317f50df2a@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-1-b5317f50df2a@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 728d2a07-17fb-4f81-2a4e-08dca525db7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0QrcDgzbUlxMlhYa2d3T1I2LzkyOU14ekxnOStMSkw4R3lOL2hoMUJQNGI5?=
 =?utf-8?B?N2hiSWQrWFBockZQZVJMejlDZnNTcGc5dXFRcjNyWDhrSmdYWGhCNzJJUFk2?=
 =?utf-8?B?SHNwcnVveUFDYkF3U093MU93Y2EwWVliSFRTek1URU10T0hhUjdsNzdJM1BN?=
 =?utf-8?B?bU1XMU1wQmRBdEdDSEp2YmFUQVRncWpYVTlXNTk3UndJVXdWZlBvSHBmOU5a?=
 =?utf-8?B?dzM0a1h3M0xKd0liQk9JUCszWDBzYjhiNWJpRzhtL0FJckQxUThJQzUwR3Qv?=
 =?utf-8?B?WVJoaGhVTDRVWVJ4WlpiSi9kNnpya1JjUUJPQkh5NmxQMGNIV052cENUdElw?=
 =?utf-8?B?ZTRBUUN4cXliT3JMSVU1SmprM0dyaWxPUDlkcDI3WFNEWFZzRWMrY3hkYnRZ?=
 =?utf-8?B?T2F5a1k2dElCQkdUbTIyNFlCY3RjUVlSaEliMTNMaFVOd3AxUWxMNHJibE1o?=
 =?utf-8?B?cDBQc0RIWm8reFRqY2FDUDA2dCtLT0JBKzNSWDVhRVlIZDJrWlZoeFhsNWY0?=
 =?utf-8?B?MmNxV0hnbGlFLzZpYTE2MWxyYUNnU0RQYkRVbW15S1lpLzhyM1d3VU4vb2NZ?=
 =?utf-8?B?Q0ZmUFlYYWRBbFQ4QzJiU0N0bGFDZXI4allETWZpUHFEUmhXd2RoWlF0K0Ja?=
 =?utf-8?B?Q3h6K2VrMm1jcUxUR29DVmtmUDgvQ0k1VHB5ZHFVRUliTTBUZHk3cGhNSmtP?=
 =?utf-8?B?SFZWZytYaXZGVlNzWE9IajIvdUFIaGRCM3RvbTJjV0d4UkJEejRFcEhiTytV?=
 =?utf-8?B?OTlYWVNCVUR1OTFnTkdDQlkwa3hjQ1dIVlEvQU5KcmZNU3RSVlgyd3ltMTRS?=
 =?utf-8?B?aEtiMXZxeVlYRmdEa29aanVRVVMrNDZZTXJlY053VmFaL3ZKSk5JR1BWTVhP?=
 =?utf-8?B?c3d3Zk1sOWJJT08yZnQ1Z21ZWE54RElCRjB3cC95azJxM3ZVWFBRc2M0MzJP?=
 =?utf-8?B?V3J4TURWWlFvVWU3c0RpN2F5RXhFYkZBNTV3SGMyU3h6WWpMdDhkWlBqZEM0?=
 =?utf-8?B?UjdudGJPMFNZSURHMmI2VVVkSVI5TE03TFFmQWlrWXJFMFo1ZWt1Zk1TeEl1?=
 =?utf-8?B?ZXBhZjJGTEtMTTBrMG9XQkJaL29oQU1Oc25lK2o2ZWFKWlZkbEd3eHNoYUVX?=
 =?utf-8?B?UDliWnNIeFcvOVVDMzd3ekpySmtjSnJHOHU0Sldya1dUQ2wvUlphbDZpSzVw?=
 =?utf-8?B?K1laVFlncU8zYllJMjRiSzVDMmFXeW9rRWg2UGwrY2pDYVFBaXg5WklPdWJl?=
 =?utf-8?B?QmR3RTVNaS9zY3JxWEY1bzUvdHhUekNTUXQ1MFdLVlBkZ20xU2QrZ0h5LytE?=
 =?utf-8?B?VysrSmRWNGx0L21PeXFWOGZtRjRvczFUVDh0UjdRZkFHTXFFdXJYQ3EvK2lV?=
 =?utf-8?B?Tk96RW1VL1BuNFl2b1prc1NYUlo5Z1NlTUR6akNhZ0JQZG0wN2dUalYxTnpz?=
 =?utf-8?B?dE5TNHBYM1dHZnlzTkROc2RYNjlhZTRMb2tMQmRZd3RUTFRXcEZDZldwYmlG?=
 =?utf-8?B?Ynl6U05jdGovSXhpdVFCS1p4eWJnMklTWHI2ZCtibndtTTRYMVZlaFlBRmd0?=
 =?utf-8?B?YW5rMTJtTUdiS3pGZHpWa2wyaExManVSZ2lOMGdrOGtiYU9qSzllaG9qZVQ1?=
 =?utf-8?B?dWg1SmpVejkyS3NCMFVpSjA4NndJMW82c1J5cWNRNVFnbVZzVEhKNzdLMjRy?=
 =?utf-8?B?QVlubjFUSEwxc3Fydm1zVzhVNlVsY3ZDcmQxYTBNbHJiaHMvcllKOG96Q09v?=
 =?utf-8?B?bDRLeEIwVzI0UUZsTzBMM2Rab2pKU05MTVFSQkhDWGxIa1V2NHhGd3dhTHFZ?=
 =?utf-8?B?ZHUvU1Q5Vzc4bnNXK2gxYUEvNTFaNHlGL2V3QWZlL3lYdDRVR1NVRXlCZ09E?=
 =?utf-8?Q?xsqHJAqoDXCu8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3RnREF5WWpLNGJqbW84SzJPR2M2VWRZNFRjUmxpRXBTRU1QbWd3bFgvS2dV?=
 =?utf-8?B?WVpVK3MrM0hUbUFNRmpuVHdhTm53RTMrMDQycm5jOE5KTXp4N0plVUtXQ2Ny?=
 =?utf-8?B?alMrTmg5Nzc0WkpTdm8rSVE0cyt5ZDZZYjhxcWliaERqcHBabm1DSUc1NTlx?=
 =?utf-8?B?L3hvU0ZNSllxS1F2eXA3RnVSeGdLWVI0WU9yZEFaMWhKeTJ1SXZva25BeGRs?=
 =?utf-8?B?emhCTk03NzljaDJCR1VIRVZHNjY3WDJIT3FBYTlPSERlODhUM1pkU0RtRmlZ?=
 =?utf-8?B?cXBiTCtnek9wWDlDbEpBSFZ3S0ZNSGtwZS91MjVOeVA4czA1MStmNllvSW5z?=
 =?utf-8?B?ajhYOTA4SGc3d0g1enJOeWRSeWlaOFpYanVkZU9pNy9BTGhrbjJaTVgwcGFS?=
 =?utf-8?B?WDlDZ0lsaC9aSTJGYzBHQ2l6WkQ4N3dKYjVNKzNzMzFlbk1iY0xtdEFLTmVm?=
 =?utf-8?B?RmFhUXU5aXRCUG1oUGhVUTZlOGMxaTJLQkJXY2hmY3JWa2wxTVFxNnRTWWc3?=
 =?utf-8?B?N1NRbHdNUFhxWGtveFBVd1Arb0s5cVJvcEd5UnBrazBHSTYrenlSUkJFM2Zn?=
 =?utf-8?B?NTRqUnNDaU9UbDRGN0F3K3NlL2libzJKQnhwR1dUR0w5SURsdlFlNGF6WFdn?=
 =?utf-8?B?am0xaldZY3djdU1Xdm1tRk01RDdwcjlmL3o0SzRiVm1VTnBrNyt3NlAvZXRw?=
 =?utf-8?B?ZWJsdE1panN4UDA2Q0tYUVJNTms0YUgxa2lDNWszMW5GQlBsT0pPdTkxOXg5?=
 =?utf-8?B?NVllRHBuem5KWTU0bERwZjd2d2dqeWFTZkNUQzVFcXpoTkNtMDNJZTM5dmlC?=
 =?utf-8?B?QnpnODBmZDJPNUllekpqZDJvMWJMWmdWMHpndEJUSkNHWDhSY2JFM1NKc2ZN?=
 =?utf-8?B?WUN2RlFRSytWMDUzQUlWWlJNTHVIS0ZodnVVZ1E4SkEweXBCd29PVmg4VFk0?=
 =?utf-8?B?dkRRQWh0WFAwUVYyUjlMU0x0c1YrTmVSSmphRU8vMmdobXBSY09XOEg3ZzB3?=
 =?utf-8?B?WmRMY0p4dzNyOWxjNHlzMmtNT3hxSzVsQUJkTHZkVDMxbVVVeEZpcjFxeXow?=
 =?utf-8?B?OUowbjFDQmJQd3lPY3NJNUVxZGRXc0htUjlLai9NeUJrRnZma2RhSjJrM3BD?=
 =?utf-8?B?aXg2YlhHUFNRdmVpaTN5dGNpVzJtcnc2RHJoZlAzQmw4U3Q4UkZzUFNCVFYv?=
 =?utf-8?B?WTBPSUsvMW1abG9RaE81bW9PU1RXSUVhRndlSXNzRzM3aWY1aVcxN2V4cTI3?=
 =?utf-8?B?TXhPZTdid05Ta1dZRzZ0ZFF6VGVVK0hLbWRLRXhaczR1REk5czIxWDc0L0ZJ?=
 =?utf-8?B?dnNIT0tzblVMU3dnZ3RwQWl6bWptVUhEcGFJYVlydXJFREpCOEZEZkhuWXN4?=
 =?utf-8?B?Z2pOZHVyaC9ZeDZPMys3OUIvZk8yZWtlTFoyNTNCanp1NjhaWnVXY0RBWE1r?=
 =?utf-8?B?eU1acXlFamJPQUtXWEtDNE5HZEJIZFpYeCszK3ZzU1dqZWhTQ1diUXJ5ckoz?=
 =?utf-8?B?TVdVRDJvQ203SzR1Mnk0TDZqdSs0ZDV1SUdoYi9zVUFxZHBHRTBxR2lMTUNY?=
 =?utf-8?B?Z0s4VlozcHlpbytVQ1FQVkVJL0FKRVN5Mk5XQWVJekZ2QXNtMG92U1RCc0Qr?=
 =?utf-8?B?ZHl2Qm1LMlY1VVYxK0xUZm9NSGsySHBGZ3Rwcy9MeVJnYldhaExWeDFnZ2Y5?=
 =?utf-8?B?S2Q4OUNXcGpCQXpMcHM4TmZhOS9MMk9uVUFHUlQ3dHAvUHhMYXROajJ3aDRw?=
 =?utf-8?B?ZEgwWXNmS01adlNlL0tIdEZoaXhHWHFwTmlwbWFnTmZ6bmF0MFJYOWh4d1J4?=
 =?utf-8?B?dkg4dG5EVzVha0pYaFh3YndtVGlTZCtpaXczUTY2OUNOcFFPYWQxb05peGtB?=
 =?utf-8?B?Skx6aHMwNkd2NW5aL3dGSTlTREs5OXNHZXBoVUI4bEEvRk4vOVJGZXE2RGxU?=
 =?utf-8?B?UngwTFJvZ0xRZWJHbG1ZMnNvUGgvazQ2SHZ4V3o3V0JJcm1aYUJDMVM4VE03?=
 =?utf-8?B?dUpnRTdNdjBaRXRYRzZLMUNDanJ3VS95RFk5amxPbXJsL2VBZ0U4YXJkY3c4?=
 =?utf-8?B?bjhucm9lRnlCaVZCSmo3dG9uRjlzZHRQMTIvemVzaTB6MHZ1dVNGSVZiTDFv?=
 =?utf-8?B?bWd6VmVIbUdNM04xTEJjYVpQd3VORFNicmt3QUtLSDJSbE45QlJPQ2FPUncr?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 728d2a07-17fb-4f81-2a4e-08dca525db7e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 23:28:39.5944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIQqqaTLojzYuoYETrwakdBSeFEdowODy8++7cR8LECSXP4qso9+3QvF074gyxgczL0k50vm+8FGMYB74RKz4p46MzmrkxRXEbGKim8UMA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6359
X-OriginatorOrg: intel.com



On 7/9/2024 6:53 AM, Kory Maincent wrote:
> Timestamping software or hardware flags are often used as a group,
> therefore adding these masks will ease future use.
> 
> I did not use SOF_TIMESTAMPING_SYS_HARDWARE flag as it is deprecated and
> not used at all.

+1. Is there any hope of completely removing it? I'm not certain if this
is part of uAPI or not. Even so, we could make it more clear with
deprecation naming or similar.

> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v7:
> - Move the masks out of uapi to include/linux/net_tstamp.h
> 
> Changes in v9:
> - Fix commit message typos
> ---
>  include/linux/net_tstamp.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
> index eb01c37e71e0..3799c79b6c83 100644
> --- a/include/linux/net_tstamp.h
> +++ b/include/linux/net_tstamp.h
> @@ -5,6 +5,14 @@
>  
>  #include <uapi/linux/net_tstamp.h>
>  
> +#define SOF_TIMESTAMPING_SOFTWARE_MASK	(SOF_TIMESTAMPING_RX_SOFTWARE | \
> +					 SOF_TIMESTAMPING_TX_SOFTWARE | \
> +					 SOF_TIMESTAMPING_SOFTWARE)
> +
> +#define SOF_TIMESTAMPING_HARDWARE_MASK	(SOF_TIMESTAMPING_RX_HARDWARE | \
> +					 SOF_TIMESTAMPING_TX_HARDWARE | \
> +					 SOF_TIMESTAMPING_RAW_HARDWARE)
> +

We can't drop _MASK because there already is SOF_TIMESTAMPING_SOFTWARE.
Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  enum hwtstamp_source {
>  	HWTSTAMP_SOURCE_NETDEV,
>  	HWTSTAMP_SOURCE_PHYLIB,
> 

