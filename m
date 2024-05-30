Return-Path: <netdev+bounces-99523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B776A8D51EC
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE3728273B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2118C4DA09;
	Thu, 30 May 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwHxS98V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41650286;
	Thu, 30 May 2024 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094597; cv=fail; b=D/9JJMlye8Cz5CJCuLSxG45sGkJjdEC3GsKUSGhBhnok76jDuJdP3qiwGCUm0y3CRE3RwKAtmFnunXmh6rxQEuzDjbhas3+RP77dam94UUN0C1nM+q6jwqQFtlnioKpDsyuepIkUctDFKtj73kJSZTDadjLpSR7hCPwVnlOi3lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094597; c=relaxed/simple;
	bh=u3v0cGpTbWtkd4Ohcn28c5sV5jJPPDe6fCXEr1j4StU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nsc1LPotxUXIuKABNXF+s19PnnquTJL8vfDvO2P1aVl0eIFIupQ23llZH6YF+UMQqpS9etKfpvIsDR7+q6Di98iOshNN8wyIaKViwHBs1f8XNyb4M8t5YNyg1cSU7tTZZr6arrnN1HV3tx/3H9w/TqM/7hTTkFXwgLcz+GIiJmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwHxS98V; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717094595; x=1748630595;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u3v0cGpTbWtkd4Ohcn28c5sV5jJPPDe6fCXEr1j4StU=;
  b=TwHxS98Vvc/kWPwjH+XcIJ/H0jxZz1QJUyaGCYMPTNsyzoV4lDZrUKWd
   9OaFNK8CTCu55iptzrrYQpkdoFXess/nbYg0VU/0gBcFJNpf58Q52v2+c
   L9JSqPNHfejZVQb9Xzl/QZ0jwoTbf3/y3krrGoaCCsHlCyObAlxs3mgqn
   ht1bt+RfroQ5q1Xqg99H7Bk4AS/OIZON54ly7bH5vBDOjsyH978EweNB8
   d4ObqgdWu+Fy1osOQ25akmuRCUNE7/YaAthUI94RrnqaPfMg/INb4QKo1
   j7lYaJhxNFXTDOdWPBX7o7Ktku0U16IT8w6MHHRCA0oC+HXWoytqgS1hu
   A==;
X-CSE-ConnectionGUID: 8aIVILQhTOqlUAbJkhcNDQ==
X-CSE-MsgGUID: i013Ri/TSTOXYBmeMQs/hg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13732869"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13732869"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 11:43:14 -0700
X-CSE-ConnectionGUID: CqDZcSwlSaeDh1cTnbxFGA==
X-CSE-MsgGUID: IJofHa1yRFyUZ5al8VYf8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="35841618"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 11:43:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 11:43:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 11:43:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 11:43:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NN578zWgrI89oNWe+c/smvaN5KD+S2ZacFCbLLFN7EmlrMCBZQOVDps3sXB8V9UAHLj3NoGOxks8GieBovbKQHvgJ8qKW72F4TZAPeW5oU2iQFbvpoAGSdpyIqUIXiw6dFd7nhu8+Xxt32z5SxGpYqkDkrfk0orJakpYO5UCkbdnEu3r+q/1gOQPzfqMUEntGYe/taPoLzXbyqrV6znllVNbhNdylyGcwrtdUMzIewOhH1xd99Pkkv2fI6YzWtEBffHGFJ1m+rQm7vvmIUIk10x3KSkceecNxdYmURWZ/Xq64CoW7u9k2koNReVWLf8uFSBb1dwpdpSPMxpp+2tnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQnlbwbuUIS+I1bIjJvlbmr0G+CrXYatasYSQPoeLGo=;
 b=T5ucRQVcjeyeik3YyEGnLhTs88Mt/Q9K2CbDegL7849AEzOm/0AV1mY9DwfWjidq+bYsQCcb8RT3TnIsRyx3ytFOzqJYzJ/w1nyr+Gy8E7TgPT/T0nW3rGaRCHL1LVD1O+SH8D/afuRcoJONhvXqpBaa6Ccc9Ktzlcv9Z0shyklpHTRBN3WEXY17NtkeRd/IWMR3wd+iFMZxYJgNJBBhAyyqEGv5bkQdZ9rFsFDpmVeTZiYsCLHZMpRIzr6Mif9edkImC5VPlZ3DBHedaGCMQI6iL9ujH3PzQg07COji88fzrrfxbzF5eHLzrwdfwjmdS2n8CB6TzPDPGkWxoFXZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6249.namprd11.prod.outlook.com (2603:10b6:a03:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.33; Thu, 30 May
 2024 18:43:09 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 18:43:09 +0000
Message-ID: <46b4e8f4-e86a-4755-8e82-a3975973c43e@intel.com>
Date: Thu, 30 May 2024 11:43:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: ti: icssg-prueth: Enable PTP timestamping
 support for SR1.0 devices
To: Diogo Ivo <diogo.ivo@siemens.com>, MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Tero
 Kristo" <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jan
 Kiszka" <jan.kiszka@siemens.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240529-iep-v1-0-7273c07592d3@siemens.com>
 <20240529-iep-v1-1-7273c07592d3@siemens.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240529-iep-v1-1-7273c07592d3@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0372.namprd04.prod.outlook.com
 (2603:10b6:303:81::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: b4cfe6eb-6ad5-4d57-6ece-08dc80d85a48
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnV3YmpLUGRseXJSc0puWng1dVZQVThEd3ZvZVZ1aXFKSHZVbVVUT01ER0tN?=
 =?utf-8?B?Y3dlK2s3Vlk4ZXY5bU92b1FFd3pEVGRSUXdxeVRqSXZMT2hxK0Q4T3FXMGo1?=
 =?utf-8?B?azJ6dTlaRmpkVGdQSzFGamoyNnVSdWp2MzN6eEhmZTJsQWRwMXcvSnZzbUdD?=
 =?utf-8?B?cFQ4MnlFeGhFWGg0Qko1bGdHOVkrV05CbkRvSk1hR09kVTJCUXdQOS9LYVZW?=
 =?utf-8?B?YXE5SHhCRkdoZTJGNHNSb2VCaExEd2hzemV0UUZLbGxjdjYyM2paaERpZWdG?=
 =?utf-8?B?c0FmbFNKZUVTVmg0enpQbTEyMTdzWGppcmFhQmdrMDJVREMwOEZrQzNHZ2FK?=
 =?utf-8?B?dEdlajhRbGN1QVNZMTZIWjZNT3BaYnh2TnBJMFRCNCs5SXUrZFBUNTROVU1O?=
 =?utf-8?B?dTByS1pqL0g4eWk2RHpkaTI3aG5EVkpDYklHZEkwb0lXZzdhWDJiTGlnY3NZ?=
 =?utf-8?B?T210MjVoc2V0ditqbnE0UG5PeTQ5cEVMYUYreEpRcTB0UTNIakZxZElNRmNl?=
 =?utf-8?B?R2RidDJDK3ZEL0ppRXF6cHF3V2VaYnFqR0MwaHR5SzlVZXM1dUVVRm91UDly?=
 =?utf-8?B?SXN2dHZ6amIzTEgrOE1CUkpPVlM2Y3RHQVExbjJHdFVWUTBhbm9kMFFjM2lz?=
 =?utf-8?B?Z1VpaldWQWVralFOc0w5WTZvTWovcDdURXhlNWZSdng5K2xWZWxWb01BblRk?=
 =?utf-8?B?RGZ2ckFydXFKenBVeWtNZ3Jld29JeEpjNEZmb3AxTHRwV2FqTU44ZnRUaThV?=
 =?utf-8?B?emVVNzdnNk1SeUN6S0E0MXhadElRVjZDZ29YeDBTUTZqRHByQ0RoWjJNZ1R2?=
 =?utf-8?B?RFlTMzRjdElXc0ZOMkQ5bXM3ckcxRGlqcDJjTGdEMVhtb2lVeFBSK2ZuSHJU?=
 =?utf-8?B?VnVxVHdKUmRnMlBNUWpUVEY1TkloQkpEYkFDU3MzYTduQzlsRFlOa2dvbHVu?=
 =?utf-8?B?eUtLZFhSZGtsU0pjclhBMGpwU09RWUFJMkMrQjZUSjRYM2E1aHVvdUtNQmlC?=
 =?utf-8?B?M3FKeEFsck1ET3drL0RBSDVWU1JZc3BkZWhjb3ZuTVBQMmlyWm0vUWVRWFcw?=
 =?utf-8?B?QW5pSzRNTGNjNEUwWWI5MzdzY2NEalVsZHpKODFOQmtVa1UwanFDcUl5c3ZS?=
 =?utf-8?B?K2g0RVh4NStkOUhHVHZONFh3RHhHMlozVzYxN2gwS1BaZkt0R3UrVWJUMDBW?=
 =?utf-8?B?dXU3VzNWQzEvK1YwbHMvYTI0aUtubEVpamd0Mm5kb2NSVjhJSzNXNUdGVmgr?=
 =?utf-8?B?VWxwNndBSmJWbVJjWmVlTW1oQnBkVnBsS0ZSWG42aURpMG1DaFZsSXZIbmJW?=
 =?utf-8?B?Ty9Kb2EwY3hVRFhTQ2orRVRJRVh5V2xBTDh6ZnF5SjdZWmMvblIxT3hCTTYr?=
 =?utf-8?B?Qm9zdzBXN0pacEtSSW4xeHZTanRFNTlqMmt4U2ZDcWFDTWdrSm1lSjF1OWJY?=
 =?utf-8?B?OHNxSEpIVDRjdEh0L1c1UW52bkVYRi9Xcml2MEJ6OVI5dUxIbmxDR2RabWt5?=
 =?utf-8?B?ajVQNitUaUNvc1NIRXExNW0vVUtiK0ZFaSs0SGkrYWJDZ2JQUmdQNjVDaGxI?=
 =?utf-8?B?S1JOTDVZemJrV0lrMm0wRjBZcTJlaUh4NkdYT002N3VVb3JLTUlheU02OHIr?=
 =?utf-8?B?azZINFFPNGxFK3dMUXdPdzF2dklPOW0zSVZDcFM4b0R3UHJrakpSZHZKL0h0?=
 =?utf-8?B?QTlQTGZDNU9NTU9qaXR6OU5OL0FGSWZmUUdtaWYyNXVMUWxRTk03VEs4UXlN?=
 =?utf-8?Q?4PNE7WsIfN/EvMdkZZ7tXymwE+Nub7uEgF5Yb0H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGp3eXNGUEhkeFhZSkxRZzFxdllyQkZScDk1Wk1JT29OalgrSHpHRnBKQUNY?=
 =?utf-8?B?R1JYK0VLTzJheUc0WktuZzJCWDQvQitjTE5aTTZ2U1pXSEtkYTB2QmlTVHBq?=
 =?utf-8?B?VHJLQS91VHlkUTVDZEhNOXVsZmhYQ1NXNE9BdURMKzBzTXBqUnBVQktxRGIx?=
 =?utf-8?B?S0Z6clJtN2FJbFF6N1Q3ZTZQVzd3QVp6K0pKMVV1WFpSTWVIWHNxYm01ak9q?=
 =?utf-8?B?WGc5VUJMUlM5THY2a3ZXb1NldUd3a3Z2NVlYWU9rOXRXTk52dkNWcDJWU25C?=
 =?utf-8?B?RWx4RDhzUVltL0RhN01ZT2lXWnMwR0RES1BmRjljSE9LUS81dXN2Tmxlb0lH?=
 =?utf-8?B?Ym9zazVmSElJNWppdG50YWVDam5yaTdlWEw4K3dGZ0VCTnhzb2w2Zi90UDQ5?=
 =?utf-8?B?ZmJ4bGRJNVB3ZFFESTlQSytTWHdBK0w0dzZFUnp3akt0N0lxZUdEODZ4b3JE?=
 =?utf-8?B?OEE3UU1vb3Q2MFNWZVZwRVl4R1VLOVBWSGNJM0dqcFFvak04U015cjdnQlB5?=
 =?utf-8?B?NnhaNVpUY2laeFovS1IwMlhMeE02bWZVQmtSaHc5MzhvaHJWTmdBMzZwVDgr?=
 =?utf-8?B?cjhNRXhJVXo3Ri90YzlUemZCaGsrOVo5cHlBUWhHd1pRR2ZMaHdvaVp4Z0c4?=
 =?utf-8?B?bkxrenREazFvQkRZQmlrMDNIeHZEc2tNNWRxTm5VY1pyVWVIa20yRDBKemR0?=
 =?utf-8?B?UHZTUEs0ei9tbmVSUDRNSG14cldmb0M4bnM5SFFwME5PQlBtVUJ6QlFhVkN0?=
 =?utf-8?B?enNpUVh0VzRjWUFNc0FpSmhGa2lRRXhOQ3lFSjBIR244bVZTS0dhOHZRbEFK?=
 =?utf-8?B?N29xZ1BPbUxLNiswOWp6ZzNXZWZYdDlOdlpxajFGTk1FcEhCT3MveGV6Y1hv?=
 =?utf-8?B?aVJJMVdpK2dQK0pGQ3IyUk9jc1F1R2NuUmlPMzErSlRzR2d4dWtKcnRQRDdE?=
 =?utf-8?B?NDQra0VFUSswcjZDRXNsM3gwajI3WkMweDErNHpwZEgxdGN1SkxqYStzVmRB?=
 =?utf-8?B?ZjhrK0NON1BXVWpTbFJCeHFBTXlucGQ2VSs0bmZVcU54c3Mwa2JSNWxwM0Nx?=
 =?utf-8?B?Q0xUb011djlRU3NTZUpqMkhidGpzMXVyMzZjYTd5ek1sWlpLZHdjQjhYV2ln?=
 =?utf-8?B?a21OT2pmOXoxT2xDU0RQTDBPMkJ3dzVnZTNJMUtKcmdNQlFwUHVSWGpDWDdD?=
 =?utf-8?B?ZGs3Mk8zcS9sajJySnhmeSsyM2tWWHAreEc2SHN0YU5EOTNlSDZ5Wk9icDZk?=
 =?utf-8?B?NTRlWnl4cnhiZE42NE5WZklROEpjM0dkTG5TS2srOXN4RUxNa0FRcTBFWjZn?=
 =?utf-8?B?VHIzZVJPRkZZUFRycm4xbGgyajVjMzlsTFdmVHMyeUNPTzBUaUI4V2x1UWxU?=
 =?utf-8?B?VE5TTHc1ZmZrRUNDTnJpSkxTcnA0Q2doSVM3ZnpMYkplWWlTSXQ5Tkh1WWJE?=
 =?utf-8?B?SThvbmRvWnV3Y2dSZmhoZ1JEVkszR0JjTUZqOUcyVU5lRVFwT1hnY2F4M3Ux?=
 =?utf-8?B?bHJVeXJPN1U3NWFrZWd2WnA1LzJxeHdGdDJTdllNV0NYL1JIK1IwdnUzYUxq?=
 =?utf-8?B?TkdlUHplaFFtNmFGNE5yc1B4bFpZZk1LdkFoQWxVUXZyUjJaK0UzaTlJR0xN?=
 =?utf-8?B?Z0ozZnR4MEFqRnlwS3JIdXBiZVZLcWtGb2t0VHVnZldDTnRsTE5QYWFZZ09H?=
 =?utf-8?B?K2NyWTN4ME5URWozM3cyTHRGeVFITTBjV2RaeDFuMXd2SUF1d0I1SzFwQ3Yy?=
 =?utf-8?B?YmlCV3FtOE1DU2Yyc0dKNExqb2ZPSUhEdGpHSjlWTFhPZ3dFN1YwQWY4YzJt?=
 =?utf-8?B?Wk5XSGEyMGk4L1M2amU2TVVjWlM2bFQycU5wTmdWak0vN1U5NnBWWmsySDZD?=
 =?utf-8?B?VUZqNm9temcrT25admg1Y2xyNGJIK2xyZXhSNi9JNmE4UlZpRHVZM2lSVUtJ?=
 =?utf-8?B?YUV5ZURkQ1V2QmlHRkQ2eDUxZVcydUtDVFlydE9CQ0EvRU1aNmVROFlhUFRl?=
 =?utf-8?B?dHpzVFpYY0lQUGt5bkx2MnZMNmNHNENtU3VieHVMekVZUVdkS3Y1c3BuYTJV?=
 =?utf-8?B?ZWFtY1EyZU5kQlBTTHdyeEIzZTRQemhLUHNxRVh5UjNWV2pMMmhFWjY4Yldi?=
 =?utf-8?B?bEk0N2sxK1pXV21LayttdGxpYmdVRkx5TDRQWnZrNkQyQUNwUURuQUdPZjNo?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cfe6eb-6ad5-4d57-6ece-08dc80d85a48
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 18:43:09.6627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chDM1PqeUYwpnW54lJrWO8Yc1E56dn9MYJAKd1sa9qW4bsIo5UyGuamuOLuyXadOo4jJVGGAvbfMX0ItO2owFnswiXEqCSV/QhW+c+3tv8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6249
X-OriginatorOrg: intel.com



On 5/29/2024 9:05 AM, Diogo Ivo wrote:
> Enable PTP support for AM65x SR1.0 devices by registering with the IEP
> infrastructure in order to expose a PTP clock to userspace.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 49 +++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> index 7b3304bbd7fc..01cad01965dc 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> @@ -1011,16 +1011,42 @@ static int prueth_probe(struct platform_device *pdev)
>  	dev_dbg(dev, "sram: pa %llx va %p size %zx\n", prueth->msmcram.pa,
>  		prueth->msmcram.va, prueth->msmcram.size);
>  
> +	prueth->iep0 = icss_iep_get_idx(np, 0);
> +	if (IS_ERR(prueth->iep0)) {
> +		ret = dev_err_probe(dev, PTR_ERR(prueth->iep0), "iep0 get failed\n");
> +		goto free_pool;
> +	}
> +
> +	prueth->iep1 = icss_iep_get_idx(np, 1);
> +	if (IS_ERR(prueth->iep1)) {
> +		ret = dev_err_probe(dev, PTR_ERR(prueth->iep1), "iep1 get failed\n");
> +		goto put_iep0;
> +	}
> +
> +	ret = icss_iep_init(prueth->iep0, NULL, NULL, 0);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to init iep0\n");
> +		goto put_iep;
> +	}
> +
> +	ret = icss_iep_init(prueth->iep1, NULL, NULL, 0);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to init iep1\n");
> +		goto exit_iep0;
> +	}
> +

Once initialized, the icss_iep driver logic must implement the actual
PTP clock interfaces?

Neat.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

