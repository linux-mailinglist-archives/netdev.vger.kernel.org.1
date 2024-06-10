Return-Path: <netdev+bounces-102340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B861E9028D6
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 20:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501DA28102F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 18:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709B014EC60;
	Mon, 10 Jun 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHwRBBL/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBAE14EC58
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044564; cv=fail; b=VSLYtHyydsEi2ZzVaQLe5XW1Dy8s0VjxkFPwtXpVHb47gNpF6Q6Blj96nIspKA1mBHWlL+DL0APYTSsz061rMV7aUQAPgIFS552LschZ5c+/OVSzqn1/5+HEMkk78jXRL4BHxe01/C3Auy8lrIFB0M8Hw8JLR1eWQr/FydmjrPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044564; c=relaxed/simple;
	bh=4oBQn73deDWOfFyMQlQkpt53U/rPZGEAEBPc8aZhbCA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UNshaYu+KwYaRC+R4kdSuNs04n51j/1ehBW6jvw96rr6RBQneGddyRXaYcDadIRx4tz9OsMnfy6qu3GUp+LhD97ySkHN0ZZsU6onX7/if73rlIhJKQxo8Qys5BhgyDDPD4nQg/w1dYXAJid6KBGmJHPcYrDATIUXVy8dJb7olfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHwRBBL/; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718044563; x=1749580563;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4oBQn73deDWOfFyMQlQkpt53U/rPZGEAEBPc8aZhbCA=;
  b=RHwRBBL/Po6O1w9l1HJhS5sq8He74Rz3zIVv/iSYuqzIAndZf+vA/li0
   yZoJvLGn2LQMrGd6EjD64pexAyVXXNfeZKZcMwGt17QbfADcE9KdvNMC7
   LG6zjbWHvNkb72vRT56H6h1ifaeflaW1IbR6anWehipJSsrddprHPohWh
   PfyH6YQpGnYgmgYFewmaM7assi/UttDOYPPAmQg4nh0qAQHyVegZ4lSH4
   3ZhXoyobk0wvMwsQeo5KNL4dLldrsrKvEDQHPvsFe2k+6X04jlnbzlgJR
   NgBUpXiMYL9/LJxhfvusN/4SGuau1gXNb0QDN9hX/CnNKz1eab1jv+7N2
   w==;
X-CSE-ConnectionGUID: EjAVPqtBQSSohEkemNiAPg==
X-CSE-MsgGUID: +9vgeAtjT666qKNIEOs5/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="40121197"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="40121197"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:36:03 -0700
X-CSE-ConnectionGUID: /P/YLuGUQcitd5aqjEnc4A==
X-CSE-MsgGUID: rnVFF/XlT3a8H2nAXwZGRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39095581"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 11:36:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 11:36:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 11:36:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 11:36:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 11:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=codljWYtodc8I6ug5DVJDcE+T27lAhG6knXkWLI95TqtiwGBH5E15JMkAGP6zqQ5za3OyM9NCO6EGfEVUnRt12zmqxqFDbSIIq63QyTUZNnCIiNIpC0xv8bnowz+xlapm2u7q5TQuJr8oG7XoIHapi6r2r9DiFEWgd16Q1Cu2Hf8w2OmrWw0R1PweTA9O5jqLEZvSXnaS6JByYhats6gv4Bq60FvpYKSg2cR3pkiq5UNyl8sO01+FuQh3EaM9xvGtCNaMxmhIf0L++XSp0TJIvEsHmEyXbouHGYnB0PX0VQTXZq0qOgOWMlvEjDjux+yrLIoxJ2rW3o5U+TqdsvKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZ/2aZDKisUwY/S3mFPqFS7g5gKb2FQ4RY6ZrbkVyWw=;
 b=cc2v0k+Y5OdVe7PiGOg12BX/jFqCsnMQR+i3FnU1154xm491PVPSACgCXxg1FJcvf6+JNRu3GEszG2Z0oI7n0P+xbzWgLPYIz28LVni0aRA4+J9K5Z8KhIsDWnRZGxEXdJRHYMFZ181ilnfF0rWBvNQk+1cNVP+1XA6wtnEdDvBPFyTFLqYg+7uNpnZQN5t3C0lnZcCSxCqYVK9SfuM9LJr3sQx02vQJIB2MQrLVHZwfReuZg7PTWXenRr6ybDOOmAHDJ2HK7DF6UXDO+d8hlEROKVMAUZPDkE0/tXwdQ+/7m1/XBsUzUOcEMRNjv+RIIx3ha5flOegL/iZtUxCUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7091.namprd11.prod.outlook.com (2603:10b6:806:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 18:35:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 18:35:54 +0000
Message-ID: <71549696-5d09-4322-94ca-709193bb8711@intel.com>
Date: Mon, 10 Jun 2024 11:35:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 01/12] virtchnl: add support
 for enabling PTP on iAVF
To: Simon Horman <horms@kernel.org>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Wojciech
 Drewek" <wojciech.drewek@intel.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-2-mateusz.polchlopek@intel.com>
 <20240608125530.GS27689@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240608125530.GS27689@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:303:6b::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0f17a0-9ec6-4c92-2a7c-08dc897c2921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmlvOEl0Mmk2a09SS0ZvR0RPVWxabXAycFNlRmx5MktiSzZ1NTZWazVGZnJH?=
 =?utf-8?B?UGYvWTMxdXc0YmdQQ1JQekIwa2gzN2ZDaS85UTN0STcyWjByY0p0bENlb0po?=
 =?utf-8?B?L1lxL2pHMm5SZWVzcS9talB4QVZnbEVoWW1WeU5nVEh1TkR0YTducHlTcXZz?=
 =?utf-8?B?Y3RMdlBuLzFMMERuVU01ejdDdzFzemhIemkrS2pXOENqOG5LS05kVDlMVGU2?=
 =?utf-8?B?VmVFcFlNd3Q3b3h1UzllSEEwLzJJWTI1NkY1dHc1OTExTW50U0hteE1IRU5z?=
 =?utf-8?B?ZGYvQ0R5SGpvNERyRUZxTHpuZGNnejd2ZStJR3o2by9iM0pQK0dXblQ3MWtV?=
 =?utf-8?B?aGpMVUJpMnlUajFoSzNSVnhMQXJsQnpIc2pweFVaVTBJWUxkVWpYdzJ4anZQ?=
 =?utf-8?B?VG5GZHlWNG9zWGdsSUN3Qk45WTZmWFhyWUFJZGx2LzNEb3VtZ05WNlFqeEgy?=
 =?utf-8?B?N25HeklVQlUyRG4xRVlXeFBUS3dETEZlQmJVaEphL1FWV1paNUxUcDlUenlo?=
 =?utf-8?B?TmpkdmxnQUtVbWFHZ1VwbUdZMVhQbGxmUmFjM1BmMTVvVDB5eGsrU3p2OG1Y?=
 =?utf-8?B?OFd0UHlFTkNQMjJha0RtY2w5RGhNdGdjK1MycEY4T0ZpdnFwdi9QQTZ3YkhJ?=
 =?utf-8?B?NEhkMXpJTVZPQzF4M29wVjc5eHM0SERsUHB1T3FkVEdybDh0OTl5Y3FiWk13?=
 =?utf-8?B?eVBqcU9wcVkvdEFzc0NFdzRHcU9XN1VrUVdSSVcydzQ5NndGUXM0dVBKVFF0?=
 =?utf-8?B?SmxnampCQS9hTFpSeU1BNnAwbjVyMWNFaHEyWUF3NjNHblc4TVY4cHZwVXBV?=
 =?utf-8?B?M3c4UllTVEpDR0N2Y2syVXc4UW00U3E4WVBOa0tRS05NMTJyUWQxZ2dnQm40?=
 =?utf-8?B?RElla3Z3bTdGL2w1Tng0UnI1b0xrTmhkMWVhTmJxVDUrMVpzYmFuQTZIUTBO?=
 =?utf-8?B?YmZBQ2tDcTJ4QTV6dFN4UUcwVkhPbW1GWHkwR3ZnYmpxQ1NyMlhlWVJZZEhQ?=
 =?utf-8?B?TjJkcnNicEJxSjhkZDdyZm5LaE1qTy9kdEZHSTAyWUU5eVhLSFByaFdCUGpu?=
 =?utf-8?B?TWdXTUlxM1RvcG9sTnRZYTVCbTdnTCtCbVdYbm1Majh1bk4wSjhqcVpBREhm?=
 =?utf-8?B?ZWg4VzduWnNnOE4wOGFMZXVEb3NOSFV6eHFmMlZkYm41MGxoTmYxSWp5OHR4?=
 =?utf-8?B?SzEvM2RqanZsZDMzMjJBZnI4NWN5VUtzSWNXWTI0ZjZyaEFPckFBai90VWJO?=
 =?utf-8?B?enE0QmpuemxiMzJBK0hBUkJRNjRBOWVNSGQzRjFRaUNWdHRUTFJkaEF6Yllq?=
 =?utf-8?B?all5c0E0cGJxMVIxYjdzZUgrMlh0eUpPQWdCK1NXUWdPbjVaTEd2OWc2UUNh?=
 =?utf-8?B?K21JcmpPcGE5MmZjZlpraHJvQmpMNW9GR3orOTNEZldTbSs1Ymc3ZlA3Nm5j?=
 =?utf-8?B?dDlkSzFnejhyNVpUaTFDVFVjM1Vvd3dBM0RoZDFMZEFxWEQzTG5IUWM4UWRk?=
 =?utf-8?B?U3d6SGNWbmFLdUJWUGR4UWhQNXJpQ2MzSjRTVDY5K2tsZWx2d0N1T0ExMjIy?=
 =?utf-8?B?YStGdjUxN253TFM2TVV0TWFUbkJCMThGMExUVEI2Y0x5QnVtaE4rNkRaM3ds?=
 =?utf-8?B?RXFOZnZScjRFWmt1WmFNZGJodVlKeVdNRnBtcUdYVE8xbTNXOVRSb21OYVlN?=
 =?utf-8?B?YXgwSktaOTJucnhOTVlTcmF1dkVpNUUxU0k1OEZZOTlNWWNXekRiaDVFNzZX?=
 =?utf-8?Q?9DgYyombGmQuq+iGq0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTJTYVNrMm92T2JtQVc2aENiZU5kUmRmbHM3QlJlWlhhV0t4dzE4WDVMWDNi?=
 =?utf-8?B?anZmbmhoL2pBcUlQdDlBWnpLVDJ1dDFSVlNWQ0dSWlh5VVNJemt3c3lPWmgy?=
 =?utf-8?B?Q0VFOGpKcFRySTcyTlZod0FuSlBiZnd0aUNIMnFEbHFHa281K2FDa1YrWlJm?=
 =?utf-8?B?MS94MVNMbEJkc1A5S0RZUFZrcGlWajdoU1Q4YktGM3BIcUVtaFJmL01DbzA2?=
 =?utf-8?B?aEh3TDhudHJycGtmOGc0UVVhRTRPTm15T0dXSmtvS2FRZHFBQXZTSzJnVm83?=
 =?utf-8?B?Z3dFUnlYK25VRGNOT3duVVcwdmlVUlBXNFExSkpFeFBRUDJDMkt4OGRlQnBY?=
 =?utf-8?B?ZHpuZDJxaEkzK05rbHlRa1N0ZklXMWVGbUkvRTl6MVhyUmp0REpWeXpaTzlP?=
 =?utf-8?B?N3JuWlNaajlpaEpmUm5IditDRThlNEV6WkxvMTBuT2VjTnd6MXgvMXdIZ1ZZ?=
 =?utf-8?B?UHFQSU5WUzJpMEVPZXNieTRBSmw5eEdpQ1BTRS9aSjFURTB6RFgrUHNMVUl1?=
 =?utf-8?B?Y3lDQmlzNWJIVUF0T3FmRkJhRlRpQSthVFBaTyt6cWw2NW5mRDRHOG9MVEgz?=
 =?utf-8?B?QUNHRG5oUktDcGxkSlpkMmE4clltMzkyZnlXTEJLSEFIZkZaNGE4Q2NOTGxH?=
 =?utf-8?B?QmdUVjRGMUZLS00waEgxQVE5cjRETFY0ODIwUzZKV2tndTJmbU1pc05LbG54?=
 =?utf-8?B?MnZWRkZSVWE1Tzhsc0RaQjYvY21OM3BuMG5wTGloYStodDlWRUQ2d0ZIM1lm?=
 =?utf-8?B?SWpOcW10LzNJZkJqcDFHRDFoU08xUVJMdjRBVlQ1TkFEdk5aODIzbmpnZkZl?=
 =?utf-8?B?RllXUmNjSW5YdE13LzNuek5zSm5nMGNTZTNEc2U4TlA1MlZCYVJtS3BPNjZj?=
 =?utf-8?B?aU1uQmRVM21lV2VZQ0szeGdqM0YzZ3cya2pobzhKWW1mOGFFNFR2NVBCNDF3?=
 =?utf-8?B?N0R2dzQ0WHRLdnUzN3ZoT2VYRjN0RURzczVER2JFanJSU2lPKzZKYW41bDRw?=
 =?utf-8?B?aDZ2dW9KVEJMVkY5cTBnZU4rREt6RHlCOXdDTHd1b3ZsOU1vZ1p2VTh3QjYr?=
 =?utf-8?B?TWE0a05HaWViL3pobXpwSXpRSTBvUm9EZ0tsMmZrOU9IejRBUnJKR2oyV1ZB?=
 =?utf-8?B?eEE5VWlDeTdoOXpEN0JIRFdqNEhveFRQSHpuK0pHMDlwZFVxT0Z6cnIvSkpT?=
 =?utf-8?B?V1JKc1pYK3lEaldIMm03WjBtTVVXNkNzSXAvenVjbWk1U3k5SXlubXVXUFBz?=
 =?utf-8?B?VnJrQnFQVXUxRWhRcXA0OVJvNllBcWRYMVFJbVpIaHNRd2VoMnNRQmxZcS9m?=
 =?utf-8?B?L0hicWRXU2NidlJxRmZ2aXZJRnhqcmgxaTFtTytkTDZwamFFZFJQTmFBK3FR?=
 =?utf-8?B?SUthZi85K0IxSGVFMUtrN0QvQkpjRXdQcTl4b1dPQUp6ZWJpeThXZVg2OE5s?=
 =?utf-8?B?TXN3ajNlZG1aMU5jN0Ezb3Y5d0NiVCsvR2RwbzVmd1E3WG1oeDljc0s1Wk8x?=
 =?utf-8?B?MDR4cFdoVEhqRHRwUXNZWXE4aTBQd2l3NXpwaTZ4cU9JZGE4T3V3eW5EZmdv?=
 =?utf-8?B?Vmk2TWszOUZiS0pBTk0yTkp6QUNCY21abzJkUVdBc1BDSlZpRDB2YlNGNW00?=
 =?utf-8?B?dUdJdWJaeWJFQkhaOFFTTEt4ekpUUVFqL2szc3Y4eitxVzBBcUVnZGU3bVBl?=
 =?utf-8?B?Wk5udXVLU3A2bkVVVlc3TDZEWno3aEdtS3R0Q2w5dWJwdnpaV1VxNXhsbTJY?=
 =?utf-8?B?V1BpenVCK2NtWHF6NHdQbFRNUlJlTkVjb0o5RG9VVTB3N3ZaeDlLODhqbTR0?=
 =?utf-8?B?R0IvWnpKblY0eDhBMnhJbmVtWXNzVjc0M1UrSHZqYXdSZjVML1FNWit6WXhR?=
 =?utf-8?B?dTFqa0ZuZkFCYTlGemY4MGJrSFJBTWZ1aUJjcnNrTGx4ZU1jRGVvcm5OdkIy?=
 =?utf-8?B?R0VrYVVPdDVhRWRIc3k4ZGVSQ1ZSck9Vb1ZuYW50bjl6QWU2bDhWYzVXcHBp?=
 =?utf-8?B?UUFucDgycllVVytXM0ppVENLanZiVHJKQnNINnJZMkdzVmlsTGdQS2MxVFhy?=
 =?utf-8?B?RW1KamJONm9zVncxSzdPRXhLUnVnWXBKYzl6Z3M3Y3p2aDhkTStuNGJnanBv?=
 =?utf-8?B?OU9wYzFsd1gwb2JRYUtPYzlnbU43TzR6c1hJVnBpWndtWXNQeTNoR0QyTGZq?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0f17a0-9ec6-4c92-2a7c-08dc897c2921
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 18:35:53.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEHHPsd+pCDZo4jxJoxROKPBQOjqyoMAtEPAUhNtorxz9RhH7V1c/yNKUWsR2A+kT9GS8V6Bvd6N2Q3je0439ehRr6uMvX2zs0dQsBimglk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7091
X-OriginatorOrg: intel.com



On 6/8/2024 5:55 AM, Simon Horman wrote:
> If you need to respin this for some reason, please consider updating
> the Kernel doc for the following to include a short description.
> Else, please consider doing so as a follow-up
> 
> * struct virtchnl_ptp_caps
> * struct virtchnl_phc_time
> 
> Likewise as a follow-up, as it was not introduced by this patch, for:
> 
> * virtchnl_vc_validate_vf_msg
> 
> Flagged by kernel-doc -none -Wall
> 
> The above not withstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> ...

At some point I would like to do the work to cleanup all of the
remaining doc warnings in ice so that we can get a clean slate :D

