Return-Path: <netdev+bounces-109460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43A29288C3
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C142C1C21995
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77928147C98;
	Fri,  5 Jul 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCa+S8oy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A9143C79
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183032; cv=fail; b=Zc6QkGHU3cMUOQrlmGd2GUQ5d4a2ny/oFFhEQBybag6KluK5BbirGQ/oPODB2aOZZUeGDUw+JMF8d9Vv1V5jF8UGIajhSrSQ20pNoftd4B8a1WrKSGQ5t8Q5Ep4ipEQK1fsmVnfXTFNS4SkIj3C0PqEMn+9NnkagBzeR5YjR+UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183032; c=relaxed/simple;
	bh=N2oiJ21DoBW55vIrmCao2G7GyfOSWj9H+KPrbx62SHU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u2/Kv8mDX2eCpdYjhCnjY7cZ+eYXbU88u6tt1PmA7gB82+YJft2gGaHtOqwZ0KCuyjnYwcoh8/CyvvaIl0pl9wFx/+MHISalW0NTdP5x594ZJy1iu2RJ5PyI+S8f5C+ar4MvTsoGIW57dbQ+OV57GJk1iax1CogAobUdu6cAg2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCa+S8oy; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720183031; x=1751719031;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N2oiJ21DoBW55vIrmCao2G7GyfOSWj9H+KPrbx62SHU=;
  b=eCa+S8oy6WnHSBzvp82AlOS5KFrgwj5aZP7KIbGcbPPAGDcr4S+kwGgS
   W+ctOXjglh6qUBww97ewL99L3dEvVmLPiwJ9aFb67Qvab9zY5Qu+6kTEN
   SYCA6c2SuiVyiEOhOQbTnOQFuOT7o4UwcvO8tQN2dtG/Ao+y8YQ1s2yiJ
   7y/IUiRAxRrqJISUQ46AhoRZQEoarObDuigLzlPyEgJymwDnwB8zmlZ9Z
   s6i2SWFStk2bvNXLRMCghMTCnlIBpQe4Qt//U8A1/TBBLb6/4GqR86YUi
   OiiRmDQFodnzjM9yjAiNc76kVb5eNn78ytA2hYloTgSS4vMs0nghXQ5+h
   Q==;
X-CSE-ConnectionGUID: NKstoFFwRIWOzMSwjQI6dA==
X-CSE-MsgGUID: aYsP7sEzSky2I+hpsGhIKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="21345844"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="21345844"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 05:37:09 -0700
X-CSE-ConnectionGUID: djLHRloxQzuvcagM73ci3Q==
X-CSE-MsgGUID: D/+JHN+ITZ+wiT694v7TXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="47615858"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 05:37:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 05:37:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 05:37:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 05:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dimO72v967I6W4jFTukQu7nIeRjaUmODyOIxn4y2R8ME3o57c6iFB3YnnVrONjBqrkTyQL2k3Q4wUhb8wr1TvRV0i1tFunz6C7g1YM5/wBzDRx2ohrfqVXJNUPeR+JCYNdHM+4QdNFg9hkjxxuexwQKuwNix9baJhVM5vdpj7KvBhoM7U18UUC+q7kocbKKS9r8wXto4lc0dpzyMYCJRmQ65k5gV4PlP2WxGcr/gq2DviXEewMqEmh7Fm6y5lGlK6pGL0l70TWcDvxT8N/HSbiS2/i22W0TquKv5fGH4bffsF0v74PXMH7bhy1GMEorcRf11QAKFDnC6ticXZT61ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9tT+WEL20oz9YdWzOFGDs5L4mgu3/ekMCNDGQUan9E=;
 b=IH47Flm3T5w2OoEOFGtYKNpx/XsbqIVe3nQJFKdNEToWNKIi+1Lk+8+ZbL/6Wm8StSt7OGLy7T8l99GGF1Z+IiM0Ww/8218dEnoNdGk0zg+3YgV4Ua0pip1hmV9pFzQVInyMw/mZbf2Go04L4FsK+4MUNDAiBJH9QdGcTWieQXqOzpBNtv7RfAYgzaEFiIyERo2k1VZmJd3gJH8w9HUnC77OXAIbEbRnQytMs6FWZQbGw8wDrZs/6X+1/qb/HPMTR/IJ7OcTwmXtl3bxHQOgEe0hfELC5LJnvlgqgiOcxBasoNGYrmtK6S6r1kx0ukkB2XmefBJj0jWSC0QWJoqq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB6923.namprd11.prod.outlook.com (2603:10b6:806:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 12:37:06 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 12:37:06 +0000
Message-ID: <228b8f6a-55a8-4e8b-85de-baf7593cf2c9@intel.com>
Date: Fri, 5 Jul 2024 14:37:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: page_pool: fix warning code
To: Johannes Berg <johannes@sipsolutions.net>
CC: <netdev@vger.kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
 <50291617-0872-4ba9-8ca5-329597a0eff5@intel.com>
 <ac90ee8aa46a8d6dd9710a981545c14bf881f918.camel@sipsolutions.net>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ac90ee8aa46a8d6dd9710a981545c14bf881f918.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0058.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd9d57c-b8c5-4607-3222-08dc9cef2ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHE0ZnhzV0huVGdvZFJ2SkRrbkFJMEl4clMxR2FuWXdZZlBpR3BITmhmOWJW?=
 =?utf-8?B?S2lXeUR5ZDhzYXZYTlBCVnk5RStOWDFlT1g3UWU4QjFGSklrNmpSallmV0Q0?=
 =?utf-8?B?QTR0NloxOTA2RzMrYnFyK3p0cjZGZWRyZEZSeXl1VjROam9aMk4wUGJ2NER6?=
 =?utf-8?B?L014ditkMG96YzJwT0ZPZGxFdnEzZ3VHUmpkbm9QRXVxN0pENUVRVG9LeFVq?=
 =?utf-8?B?QTBqZTM1TU1UNWJQS2tqckhWaEk0STkrRWpDWURyTVhTWCs0R21pdEg0VUpi?=
 =?utf-8?B?U1Y1VHZidXA0T2w0ZGJiU1pqU0pRc3lKanUrVWpYUmkwWVpSRFk5bXlnYmV3?=
 =?utf-8?B?enFEYUlTWWtBcG1OQVVGb0hsZGlldmQ3Q1BVd3RqWXE3NWZRT1NqUTFpRWpl?=
 =?utf-8?B?TnMzOHBVMDdsN2VyUVBEWlhBTHBTdFh6STlGdmhmMnRrUmFub1I3cFpsWVJI?=
 =?utf-8?B?aTBZRzUyc0ppRTF3eHB2T041M2pjcUl2Vm1CVUE4ajV4Sis0a2U3cFMwdDZX?=
 =?utf-8?B?UHpBUGlnL1JqQlpDV284eWYrTWdEc3hkN1FDUDg0OXpFczU2M3VHRmVoVE5O?=
 =?utf-8?B?QnBVTmZSejQ0R3lXalJxN0tVc2Yvc2JtMkF5T3diWHJtb2VyOGFPRDV0ZGRY?=
 =?utf-8?B?dzdCOGJpeHJ0c0c5TXg0QzdZKzRrNlZvMkQ1T1N5SUd3OE1TUExtZWJsVi9x?=
 =?utf-8?B?T1A1Nlc1SzFvS29yNUhJMHJXYTJlS1RBb3NRSThEM1VDUXRZeEwwZHlyMTU2?=
 =?utf-8?B?YzY2a3ZSMkxHbmV3UUlITmhBcnZ1dkZvVFM1cnM1VUg5Z0YvRmppUkR1Ky9t?=
 =?utf-8?B?QWdNaVRCTHdESEJ2R1paRm05K3lxMTJuL1dlT2xFaWVtTXIzakV5d01IdTl6?=
 =?utf-8?B?QlgxSjh5cUVCSFdFeFFBYVJzSU5ieGVHelJIdjFTQ0ZkSnphczg0MnR0M2JM?=
 =?utf-8?B?aXd3ckh0amVKZmZxNVl0WVAybC9Md29yMnlpVDE1ekxoQkxLR1JUQk9pWHU0?=
 =?utf-8?B?ejUySlZEU0ZEMnRDZUp3eFhTVHdqYzhRb3ZOcDNXZDhlTmkrczgwS0J0MmUv?=
 =?utf-8?B?eHBlbmNDTHFYcWorSG51QlJrQVdiMzFiV0hrYXZabjBXRVlxVGVFNWZUanpT?=
 =?utf-8?B?VTFhTklLUlY2MlJXS1RmQ0pXS1dPcDZHRml2OW12WTk3Y0ZOTWVUTTVFcHVQ?=
 =?utf-8?B?cVJkNGxjd0NtS21OUkR4cVNYRktnKzZtaHB3bGVnQjM1VTEyYWVDVEQ4M1Ry?=
 =?utf-8?B?L2cwbnRWMnJzQmxEMExPMlhwQTQvd0lFYklzWEJtMUZRNXQxV29mcjNHUFdn?=
 =?utf-8?B?VFlIOTlZdTVWRWV0Sm9jZ1ZlSnpuTDExb0p3M29rYTFVc0VMeWdIREZjekxj?=
 =?utf-8?B?TGNBekZlVWpBMWRueUwxcUhMZHllMFdnZ0JlYWRhZmFuaWQ3MTViNkxXdUhM?=
 =?utf-8?B?cFYwek1GVmROd2Z6aDF0STdpbXBiSkhtVnhuMmd2RTd0dFlydjB1UEJZU3Fu?=
 =?utf-8?B?L3BZWUtuSlN0YS9ha2Y3SHRjc3BvQStWdHYzeDYvck9hVmNrUFpsNVQrNVRD?=
 =?utf-8?B?Y3lPWFkyYjZ4OUQ4YjBJL0VSa2pTb2ZZeEw4RExpcjRjOEk0dVV1anBhSkVV?=
 =?utf-8?B?NVFsMVZSUHNGTDFiKzdmc25EZzVuNlRLNTVCcWlHSFRuNTBuSjJKTUlVdmJl?=
 =?utf-8?B?MWxTWXBSQ2JFMFN5WENKOFM5MU40bGRsZGdPb25pTGVPa2lzb3Yyem9PWmtN?=
 =?utf-8?B?dnZqYWN3NlhlTVAvd2pNMm9oRDdod3pqL1Y4UFAvckxWYmFEdWdzem8wa0FK?=
 =?utf-8?B?dmV0MGZINWtoSlhERFZCUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STYrQkR2VEhoZHExeVkzN3Q0RFRYdEFrSy9SR0RZelQrNjloVmhwNTdkLzRB?=
 =?utf-8?B?UGtyK3JPNGs3TDRDRGpmRWlKU01MUEhzSFhSZXFDVlRNY1MydmVoVXdHcks3?=
 =?utf-8?B?cGVtWVFEN2JybjJvMUJvN2RMdGtzazZxeFdSS1NPRGtueEFSMnJwNm0wL2NR?=
 =?utf-8?B?KzNmZ003VXBnUDBlYnV5VlZ5SnprMXJmaDA4M21zeGxsSjkybGJlamM5ZVBN?=
 =?utf-8?B?ZCt3NTZJQ1Q1ZWJMZEhPNG5hYVNMTHYzaDR5VisxRFROUHRPVlFBb3YyeFgy?=
 =?utf-8?B?a2p2YUYxY012dDFwZkFyU0xZWUsrQWRRM2VRQUhFVURRcWRZVlZzalVlNTZp?=
 =?utf-8?B?eHNiQklzNzZ2QUhxTURCT3RFTWhFRFpWc0pQbC9LelJYZmRXK0wvNnM5b1lQ?=
 =?utf-8?B?VUdLblBoL0E2cVk4MVRaNkRkZXBLclJhUEo4dGh4eTNqK3k4T2VkN3FNTkhr?=
 =?utf-8?B?TDk4U2NJTG5iVWRJYTJuS1R2LzE0RkQxU2IxMG40YUNLSnpnN3VqMmE4VTBv?=
 =?utf-8?B?TmlPdjM5NStHZlhMTEdmU2FYTmxhdC9IZnIyY09BRnQyR0xXQWZTR1Z0UDJm?=
 =?utf-8?B?NmZFOEZmV2VjMlEvNVZSN0tzSm12WGhRMTBkMlJlSk1lU0FWRE9vcjIwOWcy?=
 =?utf-8?B?Vms5aU0yd2kxemF6M0FlRm41QUJSa09NQXVRTGxXU2hqM3Q0S1U4SmZhUm9r?=
 =?utf-8?B?STJabjl5M0xwOGc2L1h0U0U2L2NQTGNiMTNmY2thR0krRjJkYVMyeDllWjRi?=
 =?utf-8?B?MVVPcWhxeHozSTY3TFNTbVRCRHArZjY5aXBZSU0vZDBWRlV5RGhyOXdkMzJP?=
 =?utf-8?B?aTVwR3BsNGppbHdFSzRlUEZqd2xJWHNKbWI0d012eWZHcG0rU0ZkSGk5bUc5?=
 =?utf-8?B?ME9XY25lUEtUN1pXcklQajJzSWh3TnVnaVpoTnZRZmtSNVFHdm9PdjZkdm9R?=
 =?utf-8?B?aFBQQWFyT3hDZE1TYURvZXdOMzd6TTI5ZTdGbnZzOUlRLzk2QTN4WGFXLzVP?=
 =?utf-8?B?WDFGU1RsYWVFaDJsZEpGeXhvYWVWUHhVNWlvN2VoM2tiYmFGR3hXM0NQaCtR?=
 =?utf-8?B?eUUyKzdYNjlKTGNPU2JnVW42M0RCc0pmU0ZpbGQ1SHJ2QUVQczdlRUxJY1VK?=
 =?utf-8?B?OUdDQm1UOFo0bUhYS1hpYVpzUVEvbXdvL1VLVDd1WElYQWtIM1dza1QvTU5v?=
 =?utf-8?B?c3RqYXJpWHhkWmJxaGt0VzBoZ2RmQjZ2RForbXRIRzRXRVpHQURva0hwVjdF?=
 =?utf-8?B?Z0lMUU1GK3loZVBpWmJqbUNhc3ovN2FycVNianRkMjhWTjh5c3IzODY5SDRu?=
 =?utf-8?B?NFhuTTFwSHV6Y0gzekxmTmIxVEk1UlZHcis1QlhPZzhpZmhBcTJjMHEwK1Qy?=
 =?utf-8?B?LzJneEVBeldvYU95MW9YL1JkUkxNYnk5WlhCNUsvRDhNbmh6eFF3YUE3Wnpp?=
 =?utf-8?B?YXBvRUYzd1JkTU1EQUpzWDRYc1lDTlVBMTlkQ0I1b21PU2tzM1A0K1V6R2xw?=
 =?utf-8?B?cUhRL2tQV2pvQ0pzYkFhcDNXQmRBUlNiNmt2SDMrMWVtWkVvZkQ0eDhrM0lK?=
 =?utf-8?B?S1RmVVZuZW9ubFBJOUxUeDVhZXBEY25TZ25pTTlxY1lqZm00OXJObTZUc2Nx?=
 =?utf-8?B?T0oxTkRxNmMvdW9SV3Bld1dReU9CV2lTZ3U3NW9TVEhwL1lkcmRTdGFtTjhX?=
 =?utf-8?B?STJWTzc0RUJTZG4waHFya1Z6NU9SNEJpdk9IbktpejEzMElqTHlxNmExbUtC?=
 =?utf-8?B?UTNreTNXd1Fmb1ZZdHJDZkZ3RTdxMnp3cHorK0pNTmg1STBhUHBhVzRMR1J4?=
 =?utf-8?B?L0pOYUpDTjRPVFFqdVFndk1LbndPTURDRjZrYW11RHlKNGd2TytaK2FYQ2NN?=
 =?utf-8?B?U2Q1bHZKVHlUVzhiQWFEMTdSbTR2eFhsSFl1Q3g0VzRvN204NVc0S1RjdGVl?=
 =?utf-8?B?bFZCY1B1Smc3OU5LVE9RbEd4MWtJOWRlS21XTmdBSUNpVmdnbW9STUFEVlYx?=
 =?utf-8?B?VGllVy80RGdFcExLZ1RjYVVSalFyMVhDMGpiU2ZjcDRCWWNIWHJNVjg0djlK?=
 =?utf-8?B?N0U2VWhHSWJNRzlWd3BkU2RKZ3h1TkJXa3Y3cjdaYTBxQVJRME5wNWhjZHI2?=
 =?utf-8?B?VHViRUxMSHVoNE92cXBmbGkzUGI2Vm5MaXd4WEJsaVlhUkxWc1dDK0tvcWZz?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd9d57c-b8c5-4607-3222-08dc9cef2ded
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 12:37:06.3465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOAtb2SOo6sFrvzMHiY1x0mjV2RGnL09ltd9BrqdY+Pas7+1EdCuoGZrnIkikGsSVU6WKPiF70sctFVYcBS3ecdEv6IJCsSuLYeBfIPknMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6923
X-OriginatorOrg: intel.com

From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 05 Jul 2024 14:33:31 +0200

> On Fri, 2024-07-05 at 14:32 +0200, Alexander Lobakin wrote:
>> From: Johannes Berg <johannes@sipsolutions.net>
>> Date: Fri,  5 Jul 2024 13:42:06 +0200
>>
>>> From: Johannes Berg <johannes.berg@intel.com>
>>>
>>> WARN_ON_ONCE("string") doesn't really do what appears to
>>> be intended, so fix that.
>>>
>>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>
>> "Fixes:" tag?
> 
> There keep being discussions around this so I have no idea what's the
> guideline-du-jour ... It changes the code but it's not really an issue?

Hmm, it's an incorrect usage of WARN_ON() (a string is passed instead of
a warning condition), so I do believe this should go as a fix.
Maybe let the maintainers respond what they think.

> 
> johannes

Thanks,
Olek

