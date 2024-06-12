Return-Path: <netdev+bounces-102819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8F3904EF0
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 11:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB9A4B26F2D
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4687022F03;
	Wed, 12 Jun 2024 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaT21pBE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E65F42ABD
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183769; cv=fail; b=sjfsRb2LJDngv8KRLTb0wjV1dCSKlGOEpKqkSbPRMOl2+MVKSTxXfltXGUzFN+VI8YfYL8FzZpDgjxyH2B6cmXtB3zixbr+GF1EBh+3zfmGr3uSDcSZFTXiLclsdZFsYLlR/8hcpNL3snrpuyox1aWqMhK0l7HxkpTeR34RNbE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183769; c=relaxed/simple;
	bh=lbUfapHX1jcn4kAmUTYdLqHS4JOHO5smEN0oZ8D8pg4=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G/4Pl+T89Xhe6rcetULtrC6S+aZd47rciXVa5LXd5kO6SvNz5eHpeSIH4IX8i7vGohomClZMPUtu/xmIh7dEzRE304Y7YjxGHfDOmhQlg03lKwms2H2DzFLf9iQfPvrBhCHDbZ+ZSzzFtfApOwa0GLjmpnz77f75F0WJin/92uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaT21pBE; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718183768; x=1749719768;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lbUfapHX1jcn4kAmUTYdLqHS4JOHO5smEN0oZ8D8pg4=;
  b=EaT21pBErRBB6caKVC9o8zyFmx40JEeYLMcRxoLMcSyk6UhR2u0UsO7M
   IvnMPBvS/yXhzhh8eHcJIf8e6czAh5CPAQY86o+UeRcL66rjX6BEwFrbc
   WROnTRPwv5pO7dSZ9H7QzLtfW69B/v1u5F8VXn0VPGS9SqZX1y4htsGYU
   MvVZQ+yYExpUXKTFu2xLBbIyH/aAHWXLLJSxFpNlDn94lkt0YTaRHNXkG
   Oib6okiuCqtig7LNeWzmErSHbya3V8lZgPkBw1OxC8HO4/aVQdNFzaQkF
   /6YU1nqlVfXHxATUC3J0ONPWzMdt+QXyIm4w6uglCvXxzh64Ss+S8zvZJ
   g==;
X-CSE-ConnectionGUID: K8BgADwJQBWoXmKK4QV8mg==
X-CSE-MsgGUID: KGSsnjwfT6uxminLL1bnbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="18794586"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="18794586"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 02:15:54 -0700
X-CSE-ConnectionGUID: 0f5kW/+xTOyIt4CNQmJL3g==
X-CSE-MsgGUID: Kb/+hQTWQJCvC37JnxgKFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39586753"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 02:15:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 02:15:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 02:15:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 02:15:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDaq18BAOLsDRYvbiDSgfMa6cNxP+wnJRMlqIPnNC1jcLHzeWMyH32wc7WxmAObdBlUl6avAzqb+UWAOrJDpDnSZSdvmrFWptconiOPY2yWFzuzrmlM4TkuSTKzRRgyXVYKABXoMrFf/bV69rs3ZeTpOiJ34nGoSehXV5EwnKQPzNUv7OsPm4SLbAx/hwy5a4sMn7WBAMgZtbAEu/pARDKWew0d2wzCJZvMREImCuR5+Gs0XNy9Z4vwWZ73oxsiX5kc4bX/cSOmjN0IrdGLecv6CeKibgyK7KSmW5FGvQI0rMi+43Xzx/VJmLRGmPoSJecODZXBISRmDxbNp2R9w7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuRSVUZfzLhNRHrkFEAUvXSkOPsJqJPaKtqIzxuEDhQ=;
 b=m33u16KEM4/CcDtgr/PrYN1zVC/h6Qos9ugnpMk5ipq6/kfAXZZfmcVWXwo8Ol/JSVmyrQVpCzQA/sZ3p5jsiwlAZXRHoVTmZihnD/6PruYptIgX8DFE4ezet+6MRgEYXaacbrK6PrgxW8I0HtyHfxgsUO2sofF2W+WBPDbXplyVfPSyg7oi7v+LpjcymsXrwlIgSvTXY0YO6VWkA3OglHmqu+K6KUz6YNoKqt+VYYEMVZ1DD57lqYfB85ccKKPiiO388cj6Xbkf0gNKooGOiDYqLCwVypgVEEgS62DB5pdE8gdZnDKcoOmD589UeH6BhIP6lSiTgnhPBF5dENhqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN6PR11MB8243.namprd11.prod.outlook.com (2603:10b6:208:46e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 09:15:50 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 09:15:50 +0000
Message-ID: <f453bcc8-8528-432d-b90e-35db9d4b0fe9@intel.com>
Date: Wed, 12 Jun 2024 11:15:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v3 iwl-net 1/8] ice: respect netif
 readiness in AF_XDP ZC related ndo's
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <larysa.zaremba@intel.com>,
	<netdev@vger.kernel.org>, <michal.kubiak@intel.com>,
	<anthony.l.nguyen@intel.com>, <jacob.e.keller@intel.com>, Chandan Kumar Rout
	<chandanx.rout@intel.com>, <magnus.karlsson@intel.com>, Shannon Nelson
	<shannon.nelson@amd.com>
References: <20240604132155.3573752-1-maciej.fijalkowski@intel.com>
 <20240604132155.3573752-2-maciej.fijalkowski@intel.com>
 <6f616608-7a56-43d6-9dc9-ea67c2b47030@intel.com> <ZmhdZwzIStFpghZK@boxer>
 <8a835d02-d65f-42be-b4dd-309e9e04d7f0@intel.com>
Content-Language: en-US
In-Reply-To: <8a835d02-d65f-42be-b4dd-309e9e04d7f0@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0028.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::33) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN6PR11MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b7b725-f7e8-40eb-4314-08dc8ac04055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHg3TnJtaDFkL2ZwSU1HNEJTMFduZHoweU8ra0V3Qi9Wd3pJV1EzTUFSeHRm?=
 =?utf-8?B?SU9JWWF5akNFWm5jeWNDekQvMzd0YjI4Q3RPbzg5Z21qL3NZZUJDL2xQSVc0?=
 =?utf-8?B?YkFKdkdwWlFHTVdkOWcwZUJCZ01meEJZWlFHblZkWjF5VWhrY2VTVG9UWGlq?=
 =?utf-8?B?MVVWbllpc3c0Z1A5L1ZJeWxVazhMZnF6UXFoeFhPdjNTUjFqR3h0RHpFU3Va?=
 =?utf-8?B?a3dzU1hYREQxVW0wRWR0b29XKzRXbTEwL2MyUURsa216UlMwaGpON21DYlBN?=
 =?utf-8?B?N1VoR1ZLVW4wa2NSUTM1SkRTS29qRitFOUhpaTFhRDJDWFczYUVTZG03aEx4?=
 =?utf-8?B?alRIWDdwaFU1Ym5BNHFqcGs5Ni83bkFxTXZUcEZGWGRDVzVoKy9NdnNlNWp2?=
 =?utf-8?B?L1BEcTRUcUI3S09rVVZvc3Qrb3NUSGpUSCtvNHoxN29ranEvREJGZkhEdUdS?=
 =?utf-8?B?Y3A1VHRpb2xtbUxHUmlhRUVxdUEwNUtVUDA2aFNiQ1RWMVhVcWxWRmVLMHJu?=
 =?utf-8?B?MVVIbXRLaXUrbFNHN2VvZ2kvemNmamRlN1VaQzJ2UksvYWxIZnh4MitWdmRa?=
 =?utf-8?B?VXhYTzVNaWVQM0h2NlNxVzE1RTRUd0t6dHZSQ1o3cWtjenNGUUErQVNrNmtN?=
 =?utf-8?B?VkMwd2FXbk1PRU1EcmRvZzdnL3lEWDE5aU9RWE9kYys3M0FsVUlZM1ZPV0Qz?=
 =?utf-8?B?Qzd1Mi90ZXZmeldldXk3QXYzVE5jUG1qMzZsTGhhUkV3elRFZkRrRU80djZI?=
 =?utf-8?B?Q2NiVnVxcWZCSDRRUlUxSDYwNGVHbEp1ZXN5RGU1VXl1eGY4Zndib2E4ak0w?=
 =?utf-8?B?VFNnak8raThPcjBjTGNOQ3F3V01pVU82aWgxWHI2RjE2dnZuSXQ3QXNYOVlI?=
 =?utf-8?B?aDZWUm1XRFVEY3BTZHp5VnNOSWdialFveEljMy84TWhPczZERVNGTE9ybUlB?=
 =?utf-8?B?TUNyekg3VUxaUm1TVThxa1YrOEQ2OFdwMEVlUnpWT1dWZEErZERySHREQWlF?=
 =?utf-8?B?bllPaTFoRy9lTzRaSUhOTkc2WWhIY3JrcmtvOW1NU3J6bWVzYWZKQVR6N2xL?=
 =?utf-8?B?R016OEhQTXpwbEZSVXpsWUs5bUR2YldyU2pkSC9qcDl2cmZaWWhYWXFSNEJO?=
 =?utf-8?B?c3lybW5xZFVHRStxNFZiNXVoazZKWHJadkRRL2E0bUgwRk9GRDJyc214ak1q?=
 =?utf-8?B?MG5vQW0yVlJRNHA3ODBIVWVaVFFmYU1LalZCTzc0cjRpcm10YVFib3RYT3J1?=
 =?utf-8?B?VEJLTnlHWEVlY3RWcytqVGVjS1BnVkNTc3Y3bHBaUURWRHh0OGUyM0FBWGRh?=
 =?utf-8?B?T3hsVElVRGQzOFRIcEo2cmI4d0ZoaGZiSnNtRkQ4S1VTOW5OZXJJeS9Pa21y?=
 =?utf-8?B?cWlVL3NUVGdKUjdyRStMVS8rbFJvaHdlRGsxR2xCT0pRNHYvZEJVZlJyVFR5?=
 =?utf-8?B?NlhpOXJsUzlGMnR6eHJoaTlnYXM4V1JKRVpUNEt2YlQvRDhSSkxmenZ1Uy8w?=
 =?utf-8?B?T1pNNGZGaFlsSlJaUURZR0xwbDFrYzcvMFlIcDBpOXczb2RvUzJwWkFsTFFG?=
 =?utf-8?B?eDFCanlGSExmeWFYU0RUeXBPS0xtL1NEVTgvR0tMZ1c3Uk1seVdPaGNmMCtM?=
 =?utf-8?B?RVhCNlExMXI0YzQxZWk3NVhUR0k2MUtiSVA3R0xtbUFLREQ0cjdQL0NOdHpn?=
 =?utf-8?Q?v68plLNBZzDYDSs6RWuf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0RNeHZhcnZ5d3NJOEU0Qnh0Mlpyb1VTVEtvU0dNQ09ML1pEWXJpNE02THJP?=
 =?utf-8?B?K0tHQkM5YWRtcWdrai92aE5CR0M0OE5Hay8zNlB5dDhTOVNqWTZrK1E5b3J3?=
 =?utf-8?B?emtvNSsrSDA5Y3pNbjhkRExpaWF1UE5XNmtZUk03SXFhN0tDbGFYeXdDNDJF?=
 =?utf-8?B?WDEzaTZxdDRBL0o4cmVtaUYySnhWaWorL2IvMkdhMWxWR1ZwQmZtKzcwTVhl?=
 =?utf-8?B?eEQ2VWg1TTJSZm0raVJKay9sTVQrUXhUT2ttYVhTTURpRW5zdERBTy9GZGdn?=
 =?utf-8?B?aWNJa1BWSElQMWdkSWpicU02UWNtMG5ZMDZRVnZWRVlJVDFvSVBvb2Rua1JC?=
 =?utf-8?B?cVNNNFNHQkhyUDU3VHREK3Z2NWpGckcwK2VtdGVvT2hab1VBTjJjVTFvUkdM?=
 =?utf-8?B?UXNXbllEMUpvcTlnUXBTYWUrcnpYYU85UHFiQW9ReDAvYThPNy9PMTNjMEhK?=
 =?utf-8?B?djJUaVVzb3lhMTBZaXZLd1VCRUR1bUtiVHNiRGNnaUltTFk4RXlnSndDV3RN?=
 =?utf-8?B?b0lxaS9FNnMwc2JyUlpjUnZyMDZMcjg4MGl5S3JTU2laTkFxdWpFaXR6WDAr?=
 =?utf-8?B?Smt5Y3hMdWZLcitjSnlMQWlzR0RlaFUwQWk2SWVNWCtBUlhpQm4zUnRxV0M3?=
 =?utf-8?B?N1NoMkg2U1BDbVFPcENpOGlEQ2ZndXJqYTJaYUh6ZXlNblNEWERCLzk4ZEZy?=
 =?utf-8?B?QjJYRzM4M0k1bVNHVEp6MllwbXZMT2VzVFJZdDBaemp3UkVuOGFneTJNbG9i?=
 =?utf-8?B?ZWhxaWhVcEYxbHZoSlJOdFZEMjAwSzJQMlNSd3FmbzF0L0R5d3Jld3ZsYjRP?=
 =?utf-8?B?YlFxL3FDNW9xbU5ONm44di9VR2lZV3YyUmx5UnIrQnhRbDV1bTFVWnRSU29t?=
 =?utf-8?B?WFhJWEJlRm9sK053NkN2RERjV20xT3R6UUhXNlQ3eGFtTlhCTFp2VVE4akJx?=
 =?utf-8?B?LzRTN240Zk40cGJmS2VEOEpHV1NFZVRDVk54SEtLSGRNV2tLbUxKY1FvemhP?=
 =?utf-8?B?c2VvMVN6UjZKbzEvc2ZEWHlxUGpiNWg5dU56ZlJaQjlOaFViMzBobVFuZXo2?=
 =?utf-8?B?UUZNekYrRUdrZFdjTVJPWTFGdkhhdVZPbXNVZW01L2dsSmxicC8wbUpzV1hT?=
 =?utf-8?B?U0RMR1VqWkxhVEdGM2h6d2lOV1FZT2g4MUJJR1NlUW5PYkF6NUxlMkxQMTU5?=
 =?utf-8?B?a2dKN3NhNDBDT2lFQnovNE9xQWVBS0FpZTlHT09qSTBFcTArRlJ2SVhNM1k4?=
 =?utf-8?B?bXdDalNVMWhWUzdYYnJ6STVRbnNIRGtmSk1LRHdDOVNIRjNXUFdkaFhlR1Bj?=
 =?utf-8?B?bk9Vb0tSTDlzTDRnR2libnQzcE93TnJsR1NlNDR3V3FqWldDOXZZU3BmKzU4?=
 =?utf-8?B?TU5MTENFVEZPdktYVkhnSVMyeldZNyswalljeVRPaldtbnBlN3ZFb3NnVDVW?=
 =?utf-8?B?cjkxT2xZTG5yNjduQ1R6VTR5R2dOYVdVVVVSTmFidEc3Z2M4QjVmaWwzMGs0?=
 =?utf-8?B?dmI5dEphOFlZNmdob0pZL25zSmZCQzArNkM0QXZ0cVdHSWQxQmNOWW5JZ2Y0?=
 =?utf-8?B?Z3pCMnEwY3grYmwrOHNrdHo0U3lGOENuMy9LMllEQ1lGNTU1R1lBdFdUZ1c0?=
 =?utf-8?B?SFBkUGpHK1AxWWZ1UUpsODM0YXhtVHNIQzJYZlFLY0xtNjlzNTYyN1RUaGQy?=
 =?utf-8?B?UWFKVzRLby8xbmk4VGxrTmhiejVlVjBES2FENFNsZ1ZnM0J3QktGRGRXcHVF?=
 =?utf-8?B?V3B1d2ovZlZBS1UyQjl6ZG1qY25LZFlZZ01oR1JEcXFpMXdYTm5aYXkvYnFm?=
 =?utf-8?B?b1ArZ0lrZHd6Z0I3UVZjc2liZ21lRjQrRWxPYkNTWGVQNWNjb3liZkhwK2tk?=
 =?utf-8?B?Nkt4c01kTThjMEFMRUxSdVBmT0dCMUVnQVpKVXJyL211WWRLekUrbXJhZHpB?=
 =?utf-8?B?aWVpdXlaTmcrR3RKN1V0cFZnODRMcno3NmdkMm42Z0hxR2doVmV2aFo0UkF5?=
 =?utf-8?B?enhXWE0wSURSYlhLUGtyeGhxaFJZMkV3M1RjdlhhL3FVVTVyd2F5RGE2ckpr?=
 =?utf-8?B?WGhvNTlOWmxaQzNrK1hNZ1IvRVBxS0hFRHNXaGR2aWp3ZSt0RGhoWG9lUnpN?=
 =?utf-8?B?VUNxUXR1Z0NOL2NIQVFUTTYweGJxZXVaYzZXcjB0N2p4ak5ZSklTeGErWXN4?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b7b725-f7e8-40eb-4314-08dc8ac04055
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 09:15:49.9682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MEoFGZbZ4ysEsdeP2EjMqSR6iEXC7CVG4BfCJBg0nEX4pAaLAXM5Cl/E8GknR9kDnhF0I5gSXRFlRcCVz3mbzUE5g4uEI8+a3EkZb2cJg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8243
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Wed, 12 Jun 2024 11:09:10 +0200

> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Tue, 11 Jun 2024 16:21:27 +0200

[...]

>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
>>>> index 2015f66b0cf9..1bd4b054dd80 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
>>>> @@ -1048,6 +1048,10 @@ bool ice_xmit_zc(struct ice_tx_ring *xdp_ring)
>>>>  
>>>>  	ice_clean_xdp_irq_zc(xdp_ring);
>>>>  
>>>> +	if (!netif_carrier_ok(xdp_ring->vsi->netdev) ||
>>>> +	    !netif_running(xdp_ring->vsi->netdev))

Oh BTW, I noticed some time ago that netif_running() is less precise
than checking for %IFF_UP.
For example, in this piece (main netdev ifup function)[0],
netif_running() will start returning true *before* driver's .ndo_open()
is called, but %IFF_UP will be set only after .ndo_open() is done (with
no issues).
That means, I'd check for %IFF_UP honestly (maybe even before checking
the carrier).

[0] https://elixir.bootlin.com/linux/v6.10-rc3/source/net/core/dev.c#L1466

Thanks,
Olek

