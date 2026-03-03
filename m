Return-Path: <netdev+bounces-263322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMpTOzcPp2k0cwAAu9opvQ
	(envelope-from <netdev+bounces-263322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:41:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 054DA1F3F8A
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70A3B304D975
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FE1370D48;
	Tue,  3 Mar 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGIV0Dh3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839E370D41
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555873; cv=fail; b=uJB/43bMncQZ8+JBhqvNTUXPjSKByzGzBIfA/PTaQv6AgKKjyn7eV1NheTFUifRTa6M2qyRPWo8y4/2BwuYsPsXn5kPm+qDrG8xKRgcDiOhv+qBWfXt2XCxDciIo4JZ2n1G+7qVnou4QIVQ7LgRbEKgGDlaXMVb1OjfBBWEuXvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555873; c=relaxed/simple;
	bh=BcOCabt7ygaXwA61rDdbpqTeYPBBRViQQad9iHH2Zfc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NgVnvKSDOh7/xyZoyKPo+HlEN0q/LQFMlbitdgk+NFLszW6SjouRDwpLvXMD1Xwap7Wnh6ofwdBU8WSiSWJAmR+7H7XvfxWEosbW20m8f/d2OJPbEh1wHPu1TAZ5dwGhpNJZo0efFHlwHCrbU8ipSS1M/IpOho6iuFDScwwSi4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGIV0Dh3; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772555873; x=1804091873;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BcOCabt7ygaXwA61rDdbpqTeYPBBRViQQad9iHH2Zfc=;
  b=hGIV0Dh3w4p90iOQlN5iyERSWV5zwz5i2J7Eti7A+Vg55qIg54KHm3ly
   HfExGjkxM4SximNMD58KAUc+ptGiQy3JElTanZxbgaMjjhiH0IVbXBOGU
   H+L/T1eLs8cv8uGnGJTPNXzMK7MCc5WQg6ljLLoohGx1KB0i8lers9L1+
   xEcH9O2vibw9/zEpxxSKbCD7iHDf5jEI/WQ3lZVnIhPKgicaIwiywC7Lm
   aUJfAQ7GkY6tiNotTEvkttO3a6fe/BjOla4jLFYI4NfvPOHikJiNCkhgi
   4Kho3WQMJUnacHdkWmaPIEqLQvLceKb77BmUb1Ch1oMa6zu3JnwstXi4c
   Q==;
X-CSE-ConnectionGUID: 7hZ+zMgcTY2E6rAYYI5oMw==
X-CSE-MsgGUID: ifnfynKcSxOUHf8VsoAlGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="84235224"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="84235224"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 08:37:52 -0800
X-CSE-ConnectionGUID: nEBBoU/2TlG0SksgqsQYzA==
X-CSE-MsgGUID: +t3nGTmYQ7e3X24Wj0Fiqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="218174176"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 08:37:52 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 08:37:51 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 08:37:51 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 08:37:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sm/GUSiBtaZC/whfY+Ck+olKFc3Up61CDd9J5GHUd6fnz+QX3zdGQ23z4GhtUir5+OXPnx5TVRVw4Thd5KHMWFhpkQzp9VXkK04D2V3H+w3Cfz62mNbU4k5ShIeG4p5lOxaeK5mqi6E15PM+IVDLpZHLYswREbGCY4PR3l0QbGWtkZAnXtjOvJ+u5n6vCVw0YEJ25HGvdmzG3RPLU8fRkxeL3HJloh6sP2outo3gnJfvLTBk/mHlJhqy029nsjRjJaadgxMMwbzFuivbA0DyFVeOlUrE79Ktf8qP5hbRi5QulxAzWoNS24SGg9SWBOL4YvJ7pyuMCicIXsd/gfGNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLoZO5ZalU8btyPaNwFtdcSyGvGsQdWf4oC82N2Z9ZU=;
 b=S1KPIMUWIpGgqu605Qb7LJUPIAeWxutBYl7YVaJOllqlgTxeNW8KxgflNVfP0dPsmsuRVoEXEVR2DiOMRGIOcW/Y4AcW7ThdZc+2F+KZghjl/z70YCyaAed0y5xbr2jnIvih3rXWolngnmbs/4WvlMutO3pMYnBLjSMR+aw0UlY7XOrH8YG0Nqp6XFRdCR/7hHlmYi9SWaB7dGwggtr5DjMpKVQt0ViCA+9H3MgcgmWto+MvCq64T2yDPGOq5pdk0uq39IWexCRzFPTcY6sLvKMQewSvPb2UlKqYRPYlIxyi0bHrhranG38Y3UpU0bFDW5Jj/l2kzE/HoxruD165mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by PH8PR11MB7022.namprd11.prod.outlook.com (2603:10b6:510:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 3 Mar
 2026 16:37:43 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 16:37:43 +0000
Message-ID: <39f4c46c-4db9-4178-99e0-8e3f3a452ab4@intel.com>
Date: Tue, 3 Mar 2026 08:37:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] i40e: Add missing header
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260302234105.2658400-1-anthony.l.nguyen@intel.com>
 <20260302234105.2658400-4-anthony.l.nguyen@intel.com>
 <aaaVnmx_QHcpiVbG@ashevche-desk.local>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <aaaVnmx_QHcpiVbG@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0331.namprd04.prod.outlook.com
 (2603:10b6:303:8a::6) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|PH8PR11MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff35ffd-45c4-43ca-30f8-08de79433136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 8C1zyiYIXmWpsogXZ4SPHtlLseI04T2gWvAAPTacz3PXuCJ+NqnetuEaTYLX/9+mnROPCEHrtFQ/F+uQgTibBCcGSHPetVCJL+PFdDMwXpJzfswc9XPj2uTJPGrMVOJtUKRdqtFGENVgZtGQsjb9gX2dtZ1xAfGcvzIfRke1B9sVxiwRS0kIMtvi5+WzRiK0LTpC7PkTAzzto8sXuJjYgDyDwLuy7swdxWfXWijwaV1rD9JULqi4x0j/HjmYgBClgPFM/BoO0/L+3iirAJEGDavt8XrQ66K+YmAmw8EDtdpiNtXr3Qhhf+4hyVF8cHrBI6CGbU/CozEVxkf1dyy3RpIz3EaxgScTyMp+jTCHuOMpdq7gy7lhzoO0tiE6LkwBYLUzd1VHx6dYE7GVETEbpDzyP9GggoN2AJT8WeM8VCr4vG2mwKMj9Xg1MauMpktS3cJAy3egokHiLTy4BhMcFeRknEGeReyxgYFwOCgjsPh/VAbH7tAk8XtqBO/LJYft9Vst/lNapR/vvYJjwN7fR/GUn3A3IXD90NnB5fSPovh1oLQuzL3SBPT47c3Z1zrqKBoaeov8xY+2+HGZvsxbUvp0tu1E5x0Eu3Hp1nLDYBfVkf6qhcRJvxvQul9DfhPin96+1tn8dD6LtBJVGov6wJQjEM5x8DcNHxwzYuINEi+h8gfY1ym4kgkD4QyyIuHnTyRJoiV9f1NxiVrykAEnu6glon5M6nK3iod+PHci674=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHVCd0w5dEJ0UytPbkRBTXo4MzZGMGI4MTRWZ3pEMEo4RFhSNXR4Q04wTnVL?=
 =?utf-8?B?ejNocEttazQ4d0Vva01MN28xODNRSW9LaE4zVDhXZTJZaktiN01kZEFkQWVL?=
 =?utf-8?B?NGMwSVpieEpCWGV6bkJnMXNvbWc2eVZWaTl0Z0RlcG9KODdETUc0KzBNbnBk?=
 =?utf-8?B?ZE9Va1htazNOWXdGcmk2Y2U0dVF2RG1WV2JCRU9kN1JvNHE1RW01TzJpNkFF?=
 =?utf-8?B?R0I0WFZvQkREOWJVakptUlNiZDFWYkExVnFvSXI3d1RHemNTaVNZc0N6UEg3?=
 =?utf-8?B?UzFSbXQrUXZIMkRoMjAvait2YnJFam0vK2Zjd1JBMWQ0REhDN0pjeXdKMU5F?=
 =?utf-8?B?QUZBQkVHcVV1K2RGZ0VJVGlKK2M1eXVnTWJLOEZHV3VFSkd3c3ZicjMxdy9a?=
 =?utf-8?B?RDdwMHROZnNoalhrNXJKWjc5RnYwQ3FBSjIvbnVLeXQrTmE3bktDbC9uMnk3?=
 =?utf-8?B?TW45bnNyaFN1WjA2Z2VLNXV1Y2IyS0luOFJINXN5QWJ5QmVBU3RXb25Fd2lm?=
 =?utf-8?B?Vmg1a3p1R0o0Qk5WeHRSa3ZSdm1LTGo2WUJvWlZ4cEFvbXRpWjBWT25aUkVu?=
 =?utf-8?B?VzVyazBQRStZTnY2Nm4zMVBWQnhna3hUUGc3bFhmblYxaHRBQ3owNUs1d2FB?=
 =?utf-8?B?MWRmVGtGODhXWEJmeGFyVWtVMU0yTmlvbisrMG54YmRJZ2xhYzRzb1JwWVlK?=
 =?utf-8?B?MDZqeWQ4OGdGdDN6elJBbTR6R09CbVdKS0cxQ1Qyc2pSSW9JYkpRRFkzcGJ1?=
 =?utf-8?B?SC9QL0JrYW5uZHdRN1luTDdDU0p1NmY2TGphQ0dKQTQvQW5Xb3BlOXlZNk9w?=
 =?utf-8?B?RldGalljVEQ1UVpRME1iL2N4TWlOdjhrZ3VxaEwyOWllWHZmQTVGVU1wSmFE?=
 =?utf-8?B?TDFHeXNJWkFPZTJDMEJrWlhZV29DOXh1bmJEMHhCSWdlcktkc2xKQlhVc1Za?=
 =?utf-8?B?Y3ZJSHNWM1lrejhaMkVFZG9sNjFMM0JuamYrSVhvdlNTdXdUWGdjeFEwbkhw?=
 =?utf-8?B?c3U5NEkzNEs4U0M1ek4rWExUblNVbEZQODhkQ29meUx6NlRaUk03bEJmcnQ0?=
 =?utf-8?B?UXh4UEF2NWd5NTFiZTJqd2VTb05TZEJxcWVtcFdXcyt5ano0Yk84dHIycTNU?=
 =?utf-8?B?V3Z2YXFKekxpem1KT0RIekc2UDhSbjh5NWZNSUJxRzlOd1pjTHJlbzVaSWc3?=
 =?utf-8?B?OGk5QmpjWUdRMlBtSGdpVWg3RG1sUFZOSzhIZGVTNzl6MTgrV2syK2RGTFAy?=
 =?utf-8?B?dlNheGZJOUZUYjlhdzhrRjJ3R0dhVDk1bm5GMEJ3TVNGNG43MGo4d2p5eDl4?=
 =?utf-8?B?d2hESVA5YzIzL3RNVHBWMDdlVjBFRlZwbmhGV1kycnNyeDVKSFRqQlRMY3V4?=
 =?utf-8?B?T0plbDJZUEY0QkZyQXVUZkVzSVpJSVdzWitNM0FMckF0MXNtTlBhSjl2d1hJ?=
 =?utf-8?B?WitOM0F3Q0kzVzV2eWpxbkk0T0FBUTl2M0VRZ3Zvb0ZVTU9EaVNGOG1rRitt?=
 =?utf-8?B?c1FRWS9RejJKZHZDNVk1bXZ3b0MzeGxCWXc2MVp3NTlMclJ1emloV3p0Ulhw?=
 =?utf-8?B?VFJZWmE4dDdkZE5vM0dJMmFDTU1WcXJGOEZLL1RqSzlWUXB3Uno1cEFOdXBs?=
 =?utf-8?B?bkVleEpRTGZNWWMycTRNSy9OdmVDZFZXWEtoMDZIMEtwaGZoT0prdGVjcHY3?=
 =?utf-8?B?M1lKRHBWanhyODdYQjQvUHJHNGJFdThJZUVqWHp3ZDJQcVJWNXhZbUczdDFF?=
 =?utf-8?B?azdQTnZ4OC9qemowc0RKR04wTURCcFdTa3FuK1B3Y3Y3aW9BVE9RblFWRGI1?=
 =?utf-8?B?VjFqck13MThmL0FNZUx2KzV4STh3S2NNS1Nad05rWWdSN3U2a3FHKzlySXAv?=
 =?utf-8?B?NW5nR1c3OXFXazZLbzhCUjlCQlM5dkltL2VOd1Y0NTI2cVJKSUxiTjIxRW5s?=
 =?utf-8?B?Ry92a1l5eFlRdEZBZWJSRHQrQzVKSDBKNHBSTDI1b3hhdTE5UlV1SlN0eHBB?=
 =?utf-8?B?a0VpZHp3dk9IRWxBUGNRc1dWZDRBTXZnU0RPWUxlY3h3ck14eFdzZEkxQm42?=
 =?utf-8?B?bExBblVTQi9lNTA2VzMzclh2WHJ0QTNGUXU5R3A5dEtkU3JmUE9aS3ZmWUZP?=
 =?utf-8?B?UGNmeEZ5OHROVFNEd1dDN3phY1lUZlV6YjkvcTFiblJVRitMdnhVL1FFQjNn?=
 =?utf-8?B?UlVOTXlGSFVBY1pxQjlEZ2c3S0lIckNOMGMzR09CeDBYeGI5cS8zSVJXRzl3?=
 =?utf-8?B?dzd3aFpDUGZIMW5XMmI5NUl5aVN5U3RMaTQ3RjJUS2ltMkF3dGhCWC9XTGNG?=
 =?utf-8?B?UzJNbFJHZFdQNFR5V3NkazAzY3AzZ2Y3b1FWcElmd2psTFJnSmhRWG9Kanlm?=
 =?utf-8?Q?jBGe9rylvBzlceZY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff35ffd-45c4-43ca-30f8-08de79433136
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 16:37:43.0656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: depHi7gZgm1xKFUW67yUisKnwLrpPoVIUHrIsT1Xof6dwcMLudIGpUXc7i1RZIHKFe8TzGN30aCS4S9oEQbMJAvphA2YEzwwZaabIaeJKKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7022
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 054DA1F3F8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263322-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



On 3/3/2026 12:02 AM, Andy Shevchenko wrote:
> On Mon, Mar 02, 2026 at 03:41:01PM -0800, Tony Nguyen wrote:
> 
>> When cleaning up another header I have met this build error:
>>
>> drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit declaration of function 'upper_32_bits' [-Wimplicit-function-declaration]
>>    105 |         val1 = (u32)(upper_32_bits(pa));                                \
>>
>> This is due to missing header, add it to fix the possible issue.
> 
> There was a v2 with the other (missing here) tag is added (it was given against
> v1 conditionally) and Subject amendeded.

I assumed you had found another missing header with that other patch; 
guess I should've looked closer :(

I'll update the PR with the new one.

Thanks,
Tony

pw-bot: changes-requested

