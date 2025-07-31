Return-Path: <netdev+bounces-211130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEE0B16C54
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 09:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273BF7B70A5
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 07:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2129720F062;
	Thu, 31 Jul 2025 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzCU4qUf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3060F2AE7E
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753945364; cv=fail; b=E5/Y3JfG0iSCkVlD+zeJ95SZk91WwMKKmh1b68flcgcL4cAjZ5pefyC/X/dkZnfotHWwPeMLAU/q97D4shYnfsZMDkNYGvcTthjGb3YZEOot6P9qxoFSe9JW6J3VCylcZoQeUUcaXKQZ2fG4yjDQpbUB4NsmEUO5IgqBf3a9xr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753945364; c=relaxed/simple;
	bh=ZcBiwXBCKV9SmrC045wjKtnQdjBDmWKkHlXU/8m88+k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RYAOHqHfiHz//ujtC0y3sXduVqYrXCXFhlnv0OGZiKJ8fYxv1wtkmCN1HpRNkdjmlTEB+PkBCVlESjBz6myOs1mIuSk8QuvZSrImhtydQ45DeF1KVcGEyMlNR/mFHdT8yLqK7I6B/Lmk+FY+yv6J8mF24JbDtwpmMHkLvRWIvPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzCU4qUf; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753945362; x=1785481362;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZcBiwXBCKV9SmrC045wjKtnQdjBDmWKkHlXU/8m88+k=;
  b=KzCU4qUfaRjoWUy6cOtWCdEzb7bRNByg8YbaHn0gdPEziBJzIhlnRVdY
   3h9RcWF92VjVm+oYs7zwqMvyusLhpm+nqQjB1+rU/hKzckf9rqcM3fW0w
   bK/1g1kac8+TTUrkAuEjlGef2F+mVWKv+6bi8yvAeKva667NvDUvWRb62
   CHzxKwpL7c4RxP5H4cskQCBKMLrzZEQT4rCT2fFNsWTMKaPsULMNrGRuB
   B5OOd62DQ2vsJHPTh3/TgJQv0Aqsltrjskhd+rMbcEm3YNAl15xRrSmxe
   PZrFKMrGHSgyUhuEB5T+0yGu14qhBcytY1mgzAZnMt1lPpaiS+AjnJPof
   Q==;
X-CSE-ConnectionGUID: ZGgquTNhTkK4Z7ywD5ymAA==
X-CSE-MsgGUID: q50nn0YSQt6ApT0uvlqWFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56347558"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="56347558"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 00:01:20 -0700
X-CSE-ConnectionGUID: 6ohD/4pESoWd9en9Er2lyQ==
X-CSE-MsgGUID: A6E9efvPTZiST1fGskS31g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="186871851"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 00:00:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 00:00:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 00:00:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.62)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 00:00:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTVo9Uc1ytuiAZoIc4FHvsKNK3xWH5G1bUGc7es3zar4oPvziEo/K1TO0lR1rGscoC0N2QTJz1ywV4Mz86vH3aBeKgFFKh++6fa1W7c+uG6GGpv/Gfc8XwboB0e9WhkDgRxfQ2Vdd3xNZCw9Nv7RN7f6zSGFJYV/f2acpvFqGp/x7dS+BTskXqe6IcWde35GD6+8qKd34ieUsfhJCrRkEvC137rM9C1rPBa2h/jFXEasbSioP+AK3oQa7VDXMwyXDjj1mDn25y97Wr6F4vDsY2rXDZu3gO1g8rQeCUH5tcE+AA/K0i4fZpvl2qj3/ghW3+wbXp/rWwdpCXioQjfoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUevnqQiieG2pIp1PvTTUNE3Fa9gtQN7kPKujdl2m58=;
 b=hk0fnj+rcwe2ZX71Rl6rdF6liEljWNU0GdcGWf/iH3JY0p6OXErmBHh3er2po339/wBfMBbQEeL4H/5OMKuMhdO8ZKo1FsWr/BYSNMR0nciooN8EiVe+Q/4LanQhW7iGtjoKAuOz/7sVQ18qJQEmqoSra3CQeHGW7RP8Ljip5nkCnnK2ApQGn1RU11xOp+4X1z1v8VlyPWIZbAWYmjFjRTwMvGybpbLNYaBcnoZLQGfWJqvStQYlyuehPdEWQGluxeKX6LX+Y7HOkpgysP/jvZ5zLX25N5SUc2zzEPyZ3eTltEKiskfC5ZJ5TSG9c5R2pSZ421Ho5f+MDUdU6CnCSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB8894.namprd11.prod.outlook.com (2603:10b6:208:574::9)
 by PH8PR11MB6683.namprd11.prod.outlook.com (2603:10b6:510:1c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 07:00:49 +0000
Received: from IA3PR11MB8894.namprd11.prod.outlook.com
 ([fe80::817d:526d:9031:d5ba]) by IA3PR11MB8894.namprd11.prod.outlook.com
 ([fe80::817d:526d:9031:d5ba%3]) with mapi id 15.20.8964.023; Thu, 31 Jul 2025
 07:00:49 +0000
Message-ID: <e04d3835-6870-4b82-a9a5-cb2e0b8342f5@intel.com>
Date: Thu, 31 Jul 2025 10:00:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
To: Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
CC: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>, Simon Horman
	<horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
 <20250714165505.GR721198@horms.kernel.org>
 <CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
 <b7265975-d28c-4081-811c-bf7316954192@intel.com>
 <f44bfb41-d3bd-471c-916e-53fd66b04f27@intel.com>
 <20250730152848.GJ1877762@horms.kernel.org>
 <20250730134213.36f1f625@kernel.org>
 <55570ac6-8cd7-4a00-804e-7164f374f8ae@intel.com>
 <20250730170641.208bbce5@kernel.org>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20250730170641.208bbce5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To IA3PR11MB8894.namprd11.prod.outlook.com (2603:10b6:208:574::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB8894:EE_|PH8PR11MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: b78538c2-4e0e-4f19-bf6a-08ddcffffb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVBxWDVxcGNiUUFyQW1ReVpJNkMxZDAyT0xWd2ZiZFlQV1hid0dlZjZmTk9i?=
 =?utf-8?B?Vzg4MTVRSDhHVkJFMWVkWTJJQW1VTzU5UzFqY3c3TVphNjB1WTBvR0Vxa2ln?=
 =?utf-8?B?ZmZSeTJsUkV5bzJjVzFhZU80YUJkR21VOFFMRVhwTkxuK3gvZG5ya2xMak4x?=
 =?utf-8?B?L05XK0lMS0ExcG9nZnd2Q2o3cnM4dVFXM1RWckpGMDk0c29ITFFZZHBJQ0Nq?=
 =?utf-8?B?R255WEw1U2JWOGJPL0F5UzhPUXdFRkx6VG4wc0ZpTEN3U1Y5dWRBNCtWMFVJ?=
 =?utf-8?B?MUI2dEVmU2ZsZDhJM0hpeW5leXJjTzlCRGpueXV4eEJsRjVha0s0Nm5lSjNJ?=
 =?utf-8?B?NWE0WWpQenFpUUEyOW5NRDZGYU51b3VOYjBkMGczUFo4SDlVNHR1dnlkaDFn?=
 =?utf-8?B?YWlOdU91amF0eUxxVjduT3FVWkk5emtsNTBSdjk2UUlzNThUcThHS200bXcv?=
 =?utf-8?B?MjlJV2VoZ3RzZTJMSmRrVXdmUlNoWTc2WGtZdnNEM0pncmZsR0hGNEVIU051?=
 =?utf-8?B?ckRtRFA1ejFQZE1BVWozUHhzRFdSMkZ5L3RTUWpZYTJLbCtGY3kvSFF5WGk5?=
 =?utf-8?B?cnBmNzNrSHFzZEE5eHRwd3p6blowcVQ1N0cyNnZ5eld3K1RhOHQ0Vk16cUlY?=
 =?utf-8?B?WXJsUGNaYW1lOHFWNFF3SjhRK2JYRm5RWnNkV3BjTlFMcFhHYm9RVVdSU2N3?=
 =?utf-8?B?M3RlSlJGV2RTTG1DL041NzdiNFkxY2VFMFZINzJGWmsyL2hHQldBTmN2WUJS?=
 =?utf-8?B?MTl4aEl0emdpRW5WOTRxcXBtdThnLytpd1NUMU9CKytHU3libWg4ZG9vMmlN?=
 =?utf-8?B?Ty9uYmpadXU0MFNib3Avck1HNHMxei8vVTllaFdpdm0zSnV6M0dialRYQ01q?=
 =?utf-8?B?RlpldXJQUysyNjZnUGU1dTlQOWRaSVExb0JYOGc3eE1DWDgxcENLUHNwSkRR?=
 =?utf-8?B?YzZJU3JPZDAxdEF0VWtDcG1yWWxhSGtEMEJqdW9OY2xVd09qeEd4ZFRUa0kr?=
 =?utf-8?B?ZDdTWTZtcmt0blFMeUFpbmVIeVZUbHdXaGdlaXVxbXVYbW9KbUlRVHZNQXFJ?=
 =?utf-8?B?UUlqSllKazBXZEJqRFV1T1dCYTFpR080bEl3c2hGMFZjS25aTXpES1JRRXBX?=
 =?utf-8?B?cDlyaFRoT3pSY1VXeFNsSUw4NUsxOWtZNE1NemhPNzRzeUpOM0ZxczJHMHMr?=
 =?utf-8?B?dFh6SE02bmF3NlpqRU1UajhWNXdSYmdod3hYbSt3RWhCOW1GdXczL0RaWnJH?=
 =?utf-8?B?MXpDdGRTaGF6SGZjNG5jSlcxU1dGQUxoRnVGWGF5QlBtVjIvcEFGdG52UlJw?=
 =?utf-8?B?UXJzKzBualRDL2FJdmYxY2pGSzg0WWlpNHcrS0hVdk5qbGZNQUkrWE1UR09l?=
 =?utf-8?B?T1NRTS94ZnQ2QzEzUzY1cnZhdGRRelo2RVdiMEpJa29HRTQ4RDh4UkxTWWNx?=
 =?utf-8?B?MUFyZk9oMmZ6NExEbzBCbVNTL0YzYU82S1VLVk1rNENHcTFPOWZIaDZiUjJp?=
 =?utf-8?B?NGtKL05tdlVYazJTVFF3TUFVQU02QXNpMW54MnVNN1cwRVozbktaQTRJd3hF?=
 =?utf-8?B?L2hGS2dOd3pJcEJjZVlHTnV5WWJwc3pTZG54bWs0b3VveFZXcXVXSXM5TkJq?=
 =?utf-8?B?Tk1ydVZWazJ1QjdVTGE1ZjZScERoMmNiVWR1WVNiTjF1azlNWjBDUjNEdlYy?=
 =?utf-8?B?QitOTys2bGlVVVFGTGRGRXJQSjBhTGpMN3AvdlpwZloxTldyMEswSHRSTDEv?=
 =?utf-8?B?VXFBcDVwTGtDL3JCV09WREJmZGg4Nk1nbXZzMlg5TFJMK3FVcU9Pb2Z2dXVi?=
 =?utf-8?B?Z2RQV2s2UTlaRU8zTm1tYTFoWGxJdFljYkZVb3lBL09XMlhzdjN4YVA4UVhX?=
 =?utf-8?B?U3F2M1QyVEZGMmJwVlk4NWg5MkNRSll2RnRNSkhDb2JXUUgwSTlxbVc1dkdx?=
 =?utf-8?Q?O9Yu2upgzOs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8894.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWdRNDkyTmhOQysrTTUyTnFYUmVvMk44dzg5U0RDbFIySnhES0FsUjB1TEpm?=
 =?utf-8?B?NHNXcnZKWmhRb2VDNG5sVERPVFFUby9vUVBSeWJzYmJ3b1EraHQ1SHRVTnJI?=
 =?utf-8?B?Q1hmL2c5YkJxMWc5WDZYaWF0OXR0SHVJUFRMNGxsRURmUXhFRlVyYWVSWjRZ?=
 =?utf-8?B?UHdjQmo0MU1pWStpRWp2UlQyZU9NandmcEE4Uy9JY1l4UDZ3Mk5GUXFBRDRt?=
 =?utf-8?B?ekVzdHVrRjd5dWVWQ0lEbjFyaDJwT01yc2FGc1IwQ3pISWJBdjE1Q0N0eUNr?=
 =?utf-8?B?TTdtcHRDOU5qcjZFQlUxWkhSRm9maE4vUUtuN3hYcjZMMUtRU3JXWnkyY0hR?=
 =?utf-8?B?YWNTMHVXQnN6NGpETGNNSWpWZlFpY0NiSGhOQ0RrYS94eHR0WFB4bEtQWVRq?=
 =?utf-8?B?eW1lS1pncXhEQ05CQjhYZjFGcU9FQ2EyekgyYnVYQWtKaFBMQk9iQ3pSaWxw?=
 =?utf-8?B?TnIyUGgvQlNweDFoTU91REd4YmlCYUNaRitWLzlnbEM5RDdyemd2Rm4zSlVN?=
 =?utf-8?B?QlJZR0VkOG4xZnRNNURaZlRsNFhEWFhnUlN1SmZqRnpiQ0ZJY3hBcEY5MDF0?=
 =?utf-8?B?NGE0U1F6QytsMlgrNlRsOU1RMEhGeldROG1LUWhTZVprMjlQamZoQzFhV2Q2?=
 =?utf-8?B?WmxGUmpXdGxqRFY3aTM2azdKUURuazhrNStEMk13WGpTTHdqREpGRVlieWto?=
 =?utf-8?B?d0lqMXROV29rWjFJdk5jb21UQk1BazdxMW5KZnlrVVViS0o3V3N1eUlTclVB?=
 =?utf-8?B?VFpVSDVhNmcycVpZMnJIdWpBU2c3WTBtS25iSWMzU3hCU3VsZlNZcGV3ZURk?=
 =?utf-8?B?aHZFaDRQNUFUZThmdXJKdVhKVTNXQkM1VXBWNFJEWndjeUVVcVF1NXFZdjVY?=
 =?utf-8?B?em1GUUNYTUtRM0l1YWozVWFhR2tnUFJwWUJJdjdvUCthNUg1bUVZQS9QM3dT?=
 =?utf-8?B?Nno1UnJlZTlPaCtCQzc1Zkg4cHdMTU5qVUlwbmV0SjRwTDNydEJqRWg2dERx?=
 =?utf-8?B?VmEzZENDNVpRTnBDNXA4UzFnOUFtemNCTGRmYzQ4ZCtlU1VoUHNhYnNPa3E3?=
 =?utf-8?B?QXdoZmVtNEcxNjNvQ2REQ1BkL3krODR2T2JwdHFmTEZyM09NU0pwcHE4WnJZ?=
 =?utf-8?B?QlJLcDBJMVBLQk5NWnhrSlpvV05WUG03T0xpc21LdlV4dkZON2Y3ZnV2Vy94?=
 =?utf-8?B?SWQreDZUZWg1enJVYzMrMUpuN1hBallpVXYxZlRNbTAvblNIZWtVbjRqdGlP?=
 =?utf-8?B?bjA2NDVuQTdIMml4c1RNeTBEcmR4a09CYVAwYTg2TTZkV3luRmdtQ1ExMk90?=
 =?utf-8?B?SjhJQ3JydVFmODVac3NaTEZCRC9paDdWdCtCOXdXYmUyMG0wbytLbHVGclZZ?=
 =?utf-8?B?ZFFXWm1hSy9lNjh4cUFER2EyVktPTG1vNFZYeVdVUC9GeWVaRGRPVTBFTk9h?=
 =?utf-8?B?N3BTUDhpMG1FRlQ0MHd3cWQyd2NJL3Q0Vko3c0d1UVlCVEZRSW9UQVFyK201?=
 =?utf-8?B?NGZHbGFBeEgwcmlQdi9sb2JTOWoreWxqekJ1cVRtT2ozR09Ra2c5eWV0MzZ4?=
 =?utf-8?B?d3d1ZndMWXdmT29HK3g1K1pLTGQySjFvck82UGs2b2VvcTYrczFkcktzNkFo?=
 =?utf-8?B?Y1k3bGpCRUI2eFIrZVVvNHlKYlM3empFL1FWSEszTndNYjRyc1ZzQ0R1VXNB?=
 =?utf-8?B?SGFGUUF1dGZpa2ZFTFZDK0x5NE93WGtUNGR6bk9qM2pQd1EzUkVOREpvNDVX?=
 =?utf-8?B?SjNxcE9jMlNtWUErOVh3UUhicXJPekdCRE5vazVYNlh5REc1c0NzY29SeUli?=
 =?utf-8?B?S2FyVkFQdzMvd0dmbTJNcXNxS2h5V051cm1vci8ybU5iV3pOZU5udHJpVHVC?=
 =?utf-8?B?UVhNTTFGNFA5V25nVWh4Z004bUhGQlNNWURBOCt6Vm1VcnhMWTYrNnJjNEo1?=
 =?utf-8?B?aXo3Skg4a0pVOWpMMmtETGN4Y0trU25Ycld0L1BXM0ZCRWVzSWVZTE5ESllm?=
 =?utf-8?B?M1JtcnJBMmhMTDBWZWpaRTFBb2d0QTFNR1ZEcUQ4eFp1Z2pmbm5wSTAzV09q?=
 =?utf-8?B?eUd0RG91eGhpa0xSZUxRS0VOSG5UdlB4cWxDYmVRQW9HVjhoVGpXWHlyZmxy?=
 =?utf-8?Q?R34x/Kv87dAcyWaJUVHSlhOeh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b78538c2-4e0e-4f19-bf6a-08ddcffffb2f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8894.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 07:00:49.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs+/E3QMsNix8D+v/HAyBUOZZdbgHuv350aCf4Pah2zjDBwSjX8jjLCKSXdlk5J7BK+jfpHE0XFGb6L58SadeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6683
X-OriginatorOrg: intel.com

On 31/07/2025 3:06, Jakub Kicinski wrote:
> On Wed, 30 Jul 2025 15:10:45 -0700 Jacob Keller wrote:
>>> FWIW I will still object. The ethtool priv flag is fine, personally
>>> I don't have a strong preference on devlink vs ethtool priv flags.
>>> But if you a module param you'd need a very strong justification..
>>
>> I think just the ethtool private flag is sufficient. The primary
>> downside appears to be the "inability" to easily set the flag at boot,
>> but...
> 
> I haven't played with udev in a while but it used to have the ability
> to run a command / script when device appears. So that'd be my first
> choice if how to hook the setting in when device is probed.

My concern here is not as much as how to set the private flag 
automatically at each boot (I leave this to the system administrator).

The concern is whether it can be set early enough during probe() to be 
effective. There is a good deal of HW access that happens during 
probe(). If it takes place before the flag is set, the HW can enter a 
bad state and changing K1 behavior later on does not always recover it.

With the module parameter, adapter->flags2 |= FLAG2_DISABLE_K1 gets set 
inside e1000e_check_options(), which is before any HW access takes 
place. If the private flag method can give similar guarantees, then it 
would be sufficient.

--Dima

