Return-Path: <netdev+bounces-180597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E99A81C04
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060F04A729B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE3D1D5CEA;
	Wed,  9 Apr 2025 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ay9k/AaL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB4171A1
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744175138; cv=fail; b=luCg6XiaYjUtHrqkOBr2uYubJ85X4bzQ3GlZEEa2YVWAm0ArTqBiaRNxgkVghOlKlzyoPnLtIm9xJLrLAKzsHDlJrpQyVGZv656L8KjqQp3a5CC+gdXzp4eLCc/uFLhONgiVwP/3C2M35b8B06sv5XBDqz73+JUG7oi44oPr/W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744175138; c=relaxed/simple;
	bh=zaVDH/XztQfsbo+gpT2PqBxjpyjY/3kYDqegKho0jOQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n2J6/v4oQ9kpQYInJwqPXGxO+R3BDBPE0VYfMeh/q3fBg7LCkaZc8z/Zww8QZ0gXoiIVNLZjzdsm5qqCNwmE7XvKG5b3IPW/1L0+wEhrmPkYGP+yW7Lca2juFpw2uuyLXOFusa1A/73teQyfbsjE0/nd+Pm90ySqM2F8wBKzMiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ay9k/AaL; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744175136; x=1775711136;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zaVDH/XztQfsbo+gpT2PqBxjpyjY/3kYDqegKho0jOQ=;
  b=ay9k/AaLfrtKC+W/8JH6IOxbCrjq8LFeMn0ZV7aJVXXj3gVm5KBF1u/K
   w9wwdsCymDpZmqQSF6RFpMe9bUKe09EfHpDhbwQ3W0auSCp6X3D7GODXW
   CIdEeN2/VRDwGkOZM9qKJZwNinVt8hrJMaaaGp/ykbe2WhG4xLgWG3mXO
   12GYtb1WyE80CsgzwNoGuM8q+py/DZP890l/R3BR66uBKddW5qHf0upI3
   81XMnDEPtIQ+0fafCfOe9w80Y8xEJnct7b2BSypn2Lu0xG7WxCStscTdx
   T0bnRDr+5w316dVM1jTfhXzhVMGSNAxziD+9ld6NFIMkwwLBxlh6K+E0e
   g==;
X-CSE-ConnectionGUID: OU67zizPSQG43tN0Xx1BLQ==
X-CSE-MsgGUID: 3piGVYEAQFGFQH2hFHbb3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="57004721"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="57004721"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 22:05:35 -0700
X-CSE-ConnectionGUID: kvSeMDcDQeWHd8JW8ZpZ+w==
X-CSE-MsgGUID: uj8oB+z5SueG1OshVTXXbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="129301479"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 22:05:32 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 8 Apr 2025 22:05:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 8 Apr 2025 22:05:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 22:05:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtmKnxttwrR6hHRZiU2ZsASF4KqXJHDnYxJQc8J+ud9vX7ij5ktN2wMEbL8GtuEpWRhFDSQg1TpJ19DoQ12gHfSkMrr8Ijb+Fa+0gclBrmY3qmAOG5KlPqIGZMTdYLKSptO3y+GHsQXR+TK79WhlaZKOGo0Rb5TCI3DTlOPV94KZ/xIn7D6g2fqTzYmqB0z3+YrxhDQA45oBYrwTyjO+Prr+6P52CgS7RuclKnhkzFDq4md9wONnUxwTu2TVCCJYdbItfzxd7jnYXA2s9vT94hJPzrEkB3nRx2ZvxRf8WbICqX2Qx9Br7jARQZ80jRfPnXnP+qKsVo0GJ3NnI5KGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/byzL1dVSdc4XS2qDZaDj5ixTKAjGVsYQHaHy1am3eY=;
 b=TzVE6UtzNmPoTE44+8pPgc4an7jNuT2e+lP4iz+X27BhmySRSSwBVc5YE7lomDZ0WXkFUs+StilGhfLmkdwNv5PQ1FfSst59SqVpOsZ4aWvifoBpAyMB/IcdIghhdsg6rXiMEI4talxjGoyOk2RXRiX6k41kUmv2ZZ+JonLj1kTZFrXQt1pRE/ISlllJkMnMYAHn7GCOFpp72MdIU0qeqBZ9cb0AGo0APwfLJoEvosRmuk3vq9foDdytZo3ixCxffIgIrbxEZzG5SVI1BdwXEBS85naktMruSzxz1SIz+fkkJiaFQ+sH/8JwQl314g3z0bqJti0oCdH9nBYOI3fWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5265.namprd11.prod.outlook.com (2603:10b6:610:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 05:05:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 05:05:12 +0000
Message-ID: <b61f537a-65a2-460f-9a5b-081f5d1acc5e@intel.com>
Date: Tue, 8 Apr 2025 22:05:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 13/13] tools: ynl: generate code for rt-route and
 add a sample
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-14-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250409000400.492371-14-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:303:8e::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbab3c9-8716-4ee5-df03-08dd77241b7e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zi9lYXVlTEFyZ1doMjBSQjJETWVQdFE4bDFsNUtPdjRmdytxVGRTRzhEb3Ft?=
 =?utf-8?B?TTFsMGdwOUx3R1kvSExFdHI1L08zNXpUMExnVTZUbVBUOWlYY2NzaUFkWDNJ?=
 =?utf-8?B?dWtoVXlMK0tJV0FoUk5pNlhyZFVRZjBKdzVJcTdNbEVNbXVJbzFTNjB6U1J4?=
 =?utf-8?B?SFVYRkxOTTVTbzBpMjhNdUlSS0FjY2M3MUZ5WGc2SjJIVEw3Ti9lYTlLK08z?=
 =?utf-8?B?cDJ3TXZ3WlB1MU5zZkpjaFBWMkduTjVQQ1pnTGVNU0FucThFQ2hZWmVGYkt2?=
 =?utf-8?B?a0RHZE9PbnBieklQcGlJRzlxbDFzZ2VoZUVobDQ5Y0Z5N2syYVJ3WVRObVBS?=
 =?utf-8?B?RWRTRktVYUMzR3RSQkJ2M1N1QzBaaHZOUFhudlRaOGNxY0c4V2MwWStyU0tG?=
 =?utf-8?B?Vnd1NTI3dUVHaldBdkdnZmRBZmZpYXFMUW1sZldEa0oxNjhjMFgyZ2lURHFj?=
 =?utf-8?B?K2N1am02b1YrQlRtQkZCOFlkZERhVG55WDllK1ZZWkpBcklIWWFpTi9Hb3ZC?=
 =?utf-8?B?S3dVRUdZRWpGZGI0K0lrNE5Pb1VrWndZOFhhTHpsVVZKSlBWazM1RWs3VUts?=
 =?utf-8?B?YklEVkw3cTJESU03c1dHL2lyeUFQZDFhZkh2ajhVNGUxN09Cd0FEWXV6ZjVL?=
 =?utf-8?B?K29xOERhbTJGZUJCWDMyNXlNMFJBNlBHdzNnSWRNeE1renNzQVVITkU5ajV1?=
 =?utf-8?B?U3NjZFlrNVN1QVRYNHdNdTZYTnc4bmc0cGZURkF5MERBaUJqRXNDV0krSjNR?=
 =?utf-8?B?cUpmcFpodkJxNDlXN1diaDZtSEs5bGRHT0U5T0phYllhUUhTeUxCZXlBeTdX?=
 =?utf-8?B?R0R4N1dwNVN4c1NxWTJwMVVMcTlSeHBiNWhwRE8rcjJaUW9uN292UE52ajZT?=
 =?utf-8?B?RUwxRmVjTXQ1ZFRjd3R5MGdueHlrREREL2J3Ulg5SThzNCszRVNidFNKcGpK?=
 =?utf-8?B?SmlDcE4zL1daZ2Y0VEh5UTZ1U055S3Q4bHQ0L3M1RENpTkkycUswVHV6UmhC?=
 =?utf-8?B?TWdhV0hOTDl1amVFSyttZjRYWnBwckJHdU1rMGhXQUprMzM3MnVWMWs3L05F?=
 =?utf-8?B?QmpLL2VNZmp6akN5cFBIOHFkakJZZDNBZEhYN200R1A0SFpaQVJIK3RBZ3A4?=
 =?utf-8?B?Yy9jUTV2cUVmaEVtQjlJQlplN3hGZGt6M2wrVmwyOHl6cnhJalZSWFNTSW1D?=
 =?utf-8?B?K1AvMEdJNXRieXFRTFc2c280QXU0UFk1cWNzeEl6Z01QNWVVbnMzNlVrOUhm?=
 =?utf-8?B?eWdVbWdrYmY4aHg0eFl1UzkrQUVQWWlqTEEyMDdLSjNjdWQ1ZzN5alF4SlFr?=
 =?utf-8?B?M2ZONWlxNkhQN0FMRWs3R0RyODRwYnZLVHRMd0R2VWVCNi9sUGlpN3FTb2gy?=
 =?utf-8?B?ZU9xMEhTTEdvTkM2eEwvS1pHQStobDhjdGlFZWF4SkFPR1c2RUdUdXBQQWVw?=
 =?utf-8?B?MW15bGlnY2hQeTduVzlvalFsR2RBQ3phL1pLYlUyMS9hV0IyWGhmOTN2UHVL?=
 =?utf-8?B?aWVtdFFHOEc0Yk5zdE1HM3NJMmxkVnRFbEJVb0R5TEQ5ZXRxZnlWM1FzSGVs?=
 =?utf-8?B?cTBHWXl5YllWOXp1T240eEU5eGhLdyt0Z2VrcDB4aENvYlJRYmgxVXJ6bHBo?=
 =?utf-8?B?MDE1NzhsYms0bE4yeU1VNG1qZGNWT244azI4Z0lodmVKaXdwNFpDL2ZxeWZI?=
 =?utf-8?B?bVpYemZLK3h3YU9kVVZSNlZPcm80S3JYdUZUV1ZSMVBqclhXSHYrT3kzUlo0?=
 =?utf-8?B?aTQyamY1RFM0ZXRaNzlXTitCZEdhU3FoNTNidnhLVUJoN1UwMWc3dnVkUUFj?=
 =?utf-8?B?MVQyM2J3RmxNT1o5TEVaSitFc1hWcks0dDQxTGZRTHgwMmQ4YXd0YzV3bFZO?=
 =?utf-8?Q?FxhFcloZKrcs8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVZ0ckt4U09YK3p5TzEyR0JFbUUrZU53Q2hYQnNlR3ZQeE9wcm96YWFhK3Nr?=
 =?utf-8?B?TFJmYUVWZU1sWjB2U1lWUTZBTmYzbTVMMlFXbEs2MEdva3hvL3k3UXY3cWlq?=
 =?utf-8?B?ZHlUTEM4MXViM0lVb05za1l1aktTQ2d1Mm5xMWRxNmJNZlIxcGdrUjVBaWxO?=
 =?utf-8?B?L3lwSjZuNUZ3SytJaDA5MU9WVWdSOUlIblZYd09EZXJScTgyUnl4SUJJblJu?=
 =?utf-8?B?WW1Nd0RwYkIrYmVSbEtyM09GMmtHeGJ5aU40Q2RoMHpqTlpYUU1SN21VRUlU?=
 =?utf-8?B?aUR1cGhnZC90ektWVTJWWmJSVTBkZ0MzTUtreE9ZODVGL2RRZmo2MlZTT2ZV?=
 =?utf-8?B?eUpKamF1K0lBNUVIZlVUWHpYZzQzL3RhdEkzNEZlK2ZWbXFic1cwVU1YWnZw?=
 =?utf-8?B?bmFEZTdMVDFGaGJYN3lVS014djFTbDRzdHJra2ticDQzdm10dmNPQTUrWC8v?=
 =?utf-8?B?ZlZScDhGVzZaN1c2c3pBUlRIUHh2THIvSTlLclpWUEVONWtHdWMwd0x2S29J?=
 =?utf-8?B?YXZtWTd2T0hab0V5aDNMSjhPVTJ0SWpIbjA3S3g1ZzB3OGo1bk9hSXlCalpQ?=
 =?utf-8?B?R1greFdzVzJlOWFEUlI4RG16V2VWcUkzT2FTelptNFhFM0JkZU5OZDZETjB6?=
 =?utf-8?B?Z2RoU3lGcklRSFkyakZMbDZ5YnNmM0RpUE5EcWhqTk45ZUY0R2hJQTZvQVM5?=
 =?utf-8?B?TkE5cVZlUldPY1ZUTkRkdFFCRUFQWFJLa0NETVlDek94ZGo1WnpUeDZOT29y?=
 =?utf-8?B?R3NRTDhEMXMvazVXdTJqWWdRUG9JcmZlVlYwaEIzQllLOFk4ZkdmbDhieWF6?=
 =?utf-8?B?Q2JRUTNMdEV1dTNvNmQ1M01VQ3JtYXFRYVQzRFRpNWJuSUo4aFhUNEtlNEpQ?=
 =?utf-8?B?bEZoMGdrcjRrZkwybTltbExyVktKUlM5RTJjbUVMNTBvK1Rpb3kzK21zR3JQ?=
 =?utf-8?B?SnJRTktHc0ZwUkIzdXZkeFhlc25XZVZLN25waWl3SHJzVjUzWHlUZUJMaW9n?=
 =?utf-8?B?VjVwY1VlalZKOTVuZTRQaW9TUExZUGgwckVDb2xiR1Fqb0tXUkxoYXpRTnRs?=
 =?utf-8?B?amZ3Y2JsU1ZGRm9vR3diMURYb1hMVzRrc3ZXN0dWaFR0bVppNE5talRUbk4w?=
 =?utf-8?B?R0hnZ2pqaUF5Y3Z3eE1MYWwzOHlEcWI1TWNUbjVLSlpMMC9MS3Q3QThTVk0v?=
 =?utf-8?B?OE5IU0Z2VkRQanhjVlBjWENZZUQxd21qN2tqeUVQREgyQXFUSUVsMTdVVjdu?=
 =?utf-8?B?RFVVV3J3amVmdUpyY1YzQk01VWM3QzQ4V1ZXK3BOVGwzRjdPcEhmbXdZVWJS?=
 =?utf-8?B?SVZQYTE3d3g5ZjB6VUtSU3ZIV0FncUZMajBVZFBIRldRNkFZMzJsdWJrdWJs?=
 =?utf-8?B?WnBvcjdTL2I4SDFnMzF2L0h4dVpWSWJFWlBYbWVoMEpnMWlIbkM3ZFpBK3hj?=
 =?utf-8?B?eU5vOWVxT2IzaHNJUDdkRnJSL0x4UitHOFNGQVFrdEVRdmtYaVJoZllYdElL?=
 =?utf-8?B?M2FRSFBOSGM4RnVwTFd4WGgyYldtMytQeVBmNUtqN1FNc1lXMG4xdjArVm4x?=
 =?utf-8?B?bUU0RkMwRCt6eFRPa1VWTG1rKzlTUE41SWdMMU5KSzFXS2hhcU5QL3FFdzVS?=
 =?utf-8?B?WEluczBQTkM5SmdncE1lRXEzdXJZOFJsRFk3V3Y3RTB5dE1Ub2szbkNORnVu?=
 =?utf-8?B?Qm9YU0RsdWE0TlV0SVhHR3FMalpNMGFRSEIxYTVaSXI5VkFuTHJCMTEyWDdY?=
 =?utf-8?B?dXB1cHY5ZjVFZkw4NGVqL3k0bWxIQndwYnlFU0EyVk1ObE00d2JvRkErbFZD?=
 =?utf-8?B?ZnZvbHBzdlZrWlc4UWx3Zi9Ed2ZoWE1xYmk0WE14MTJHM3BrYkh4emtXaUFO?=
 =?utf-8?B?cHVnVGZwZVJMZ2VZeVZSVzJIQi9WdGN2ZU4xTTJBdDdMK0RJam1SV0VqTW9k?=
 =?utf-8?B?blRRS1dINUZwUU5VOXdzbDhKUWhKMFhoYytVR2ZQbXNETkdKVlYvMTdtcHo1?=
 =?utf-8?B?RnNhc0Z6OHY3VXlEK2xMbHRYQ1BqN0NvZ3VFL1JRYURDajYyNWdWcmhQU0JG?=
 =?utf-8?B?cE1CZUd2MldBU2txMS9URTNEQWNCM0pyNlJlSDJ1MFZ0TDRiZE1iaHBlWEdk?=
 =?utf-8?B?dGxSeU84d2Q4ekhnbngzdnQ0Ynd0a29GaE9CcWJ1aUl6UVNjSHV0Mkl3Tk1T?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbab3c9-8716-4ee5-df03-08dd77241b7e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:05:12.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+qPk7qf5t+QP/NTlRk4YVRPPXSjOMNAl6hm32OOYBd+qn4UOMG8S5xXO0W9xy/HbP5hvbb6lvsgnBAaxJocvJuppezEMi/QqwhJsQ+rIF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5265
X-OriginatorOrg: intel.com



On 4/8/2025 5:04 PM, Jakub Kicinski wrote:
> YNL C can now generate code for simple classic netlink families.
> Include rt-route in the Makefile for generation and add a sample.
> 
>     $ ./tools/net/ynl/samples/rt-route
>     oif: wlp0s20f3        gateway: 192.168.1.1
>     oif: wlp0s20f3        dst: 192.168.1.0/24
>     oif: vpn0             dst: fe80::/64
>     oif: wlp0s20f3        dst: fe80::/64
>     oif: wlp0s20f3        gateway: fe80::200:5eff:fe00:201
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

