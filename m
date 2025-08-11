Return-Path: <netdev+bounces-212613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE284B2174F
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E4A3A9E6E
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB32E2DE9;
	Mon, 11 Aug 2025 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNVB7ZWk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E651214A78
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947591; cv=fail; b=oWpr7URUPNs+EK6V032ol7wFq0tS+OkvmnKlEmdpQ0FbU0k9J1qvT3rtiFTV9Sn2RuYRvWKKZezXK8CKsQUKMXjYTX+u8N8Cx9BKep7Qg9Y3MtaI4yxJh9j4GG6O1M2JqxQqGR5QculhoOmn9SyOQcIYTxdCdYXmLgM2F9F8fB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947591; c=relaxed/simple;
	bh=qlc0SlM6jrp6PUex9FkpAjVabYkKyapZZU7PkCMsyhA=;
	h=Message-ID:Date:From:To:Subject:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L823SxrIGqZWWjFNvTss7HyMDJLlXtXDJe0OSwulUaczOGB/Xco0kLHBv2HWSIfxOivf2xz5X8OMsn5+klX4W1aI7VErFD3rE6sVtSW+V9616GQ609o/ljKj7GMwZ4rKI8s2QJ6YQi7NakEfIplEJ5vWaPIaew8mFQfmN3mKdFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNVB7ZWk; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754947591; x=1786483591;
  h=message-id:date:from:to:subject:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=qlc0SlM6jrp6PUex9FkpAjVabYkKyapZZU7PkCMsyhA=;
  b=HNVB7ZWk9rokgWjM/myZgcl4Vyla80fha9ZQKL0odEdwp+lGhAlu/HFz
   IreOM36dNU61eBOM65Y7bHS04Z4+6Y2p0Y2YMJH0amJzZ2WvgpurbpljK
   ixKbwAFlL0zI9T2yLKP4jd118NDa6z/yBtzioyTqhFy8ZXVtyipehIg40
   gDkZDt4tWXYMOoDTvKGPvqgke82e7+ax+SY14VG1VLbUlpqGrOUsOLrue
   HzzGJ1KPlIDlmdDFLFqD9jKkDOrjATtj2/EMc66UZ75HV/JNPoqby9x19
   V7hWEN8+3gFDgMDRuQHsHIwoNkTvjv+YXTuUIzxlp2wEqUwALwkVkB/Mm
   g==;
X-CSE-ConnectionGUID: qDYFap4fQmm9VAZAY19frA==
X-CSE-MsgGUID: viBlxvQ3RLKwA896SlpOlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="79778509"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="79778509"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 14:26:28 -0700
X-CSE-ConnectionGUID: KwiXuaZISc+YnnLh3i+ZbQ==
X-CSE-MsgGUID: jKBrAG5GR0eKZjd8I7brsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170459660"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 14:26:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 14:26:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 14:26:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.83)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 14:26:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Imwl+9WDYJgkvAM9Z+jOrklKaPxQbSaLl0GhRrLzKfb581ImOmsEAEQEDPcuo58KDloyMZWkaT0Vhs3RJOM+uJnOtxvnEjK7qA3CLoPLBxcDRxLu/2mfct+PKWxLgjWLhB1gL208VvAYPmSl+hvC9bbjSGlAxkb2H+J5CZA7z6Et7a9GcO1aykptNspXod2g6xZeTvbfAmOJJ73QmXMrja6OHukTVWxwdiRGSN1kjEJpuuKLz0A938adOJaw9BS8rbW1aN49m8SgbJLxyZwOMXPZD9Y2DABoOUic0CsKBamSyfY38qh0YTXSlmBlsLFgR5GmVDXhRQ7U0jKoZR5SVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1IYbFB7jvWyyW+lH0ofGbtTLwNvuEfaaq48xuQesZo=;
 b=hVfrEo9faw8IhyQh7Fub+t2Yym2PFnUfvzyJOOYNAMBFFE/31e57jo+yIpPLBVPbKXzX+HF0fX42soN/Eajw7cDk3rxKeKyJ2C0F8oJGdohfhO3P4qvDrgx+q1HkogAMcGuBWeh5DJRtYMiUfrrVPnIQ/5dXK09Jy1rtBykmAj5vqWJnd5ub0U5pe5YOiAZtDCrdSSe2rbcGZCwXtmsw4La+7IapZ2O3agZCbpQ/FhKPTTYOM+ar+3MvAdTGEUU+LJyB4etKVbdie6fzfTv+xgzk/y0ZpkctG5SNpbDiCY0Pk8FFM8jXz1NawJUF3FLFltP/bAbsGTTz9k1p/cc9Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 21:26:21 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%5]) with mapi id 15.20.9009.013; Mon, 11 Aug 2025
 21:26:21 +0000
Message-ID: <af4fd498-5ffc-4f2a-883c-f362e5ad8cb5@intel.com>
Date: Mon, 11 Aug 2025 14:26:17 -0700
User-Agent: Mozilla Thunderbird
From: <anthony.l.nguyen@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	<przemyslaw.kitszel@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<David.Kaplan@amd.com>, <dhowells@redhat.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v2 1/2] devlink: let driver opt out of automatic
 phys_port_name generation
References: <20250805223346.3293091-1-anthony.l.nguyen@intel.com>
 <20250805223346.3293091-2-anthony.l.nguyen@intel.com>
 <20250808115246.67f56cb6@kernel.org>
In-Reply-To: <20250808115246.67f56cb6@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:303:8f::9) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH0PR11MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: 74edc0ca-2c06-405f-5a62-08ddd91db75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEdIdk5ubURrbU1XalRpU0ZmdTNzM0lDd1JtakZtYjMyVHRIbXZYdXRxQkV4?=
 =?utf-8?B?dnJ5bU5hME16TU01UGJHeWFuS3p0aWFoN0huVEFMV1AwSTVQMllGb0xpNWNG?=
 =?utf-8?B?cFprMloyS3dzOFZRbXdxTGlsSGhsdjVDWExOT3RWZUhoNHNZSUZnalZRRnFC?=
 =?utf-8?B?OUQ1ZFhLb2JGdmtWOTB0QUIyYjF6aUdueFFHc3RDRHFBUlBTaWpacUNTdXNi?=
 =?utf-8?B?bWh3NkVucFlYLzRqMGxQajJhVG9lSTRDWHhjcnA0OHBJQWtiN2FsNzA1bWU3?=
 =?utf-8?B?WlJUeUtmQnNRSE1uYUJDNUR5TjNSdkVRTVlnY0RmS3hwbHhuTmh0SkE0MHky?=
 =?utf-8?B?dXY4NU9UVFFYS2t3ditvOWthSUVoZ2I3TEE3Q2MrNy8xc1V2OUZYeDUzdTFz?=
 =?utf-8?B?RTNPZEt6YkRnTEJqMFF4VEw4RDE4ckl3VEx0R1Y5WXRtcUp6QjVYMU9UTXY4?=
 =?utf-8?B?YjVyeTRydkNsWDJDSUVVR0pVcmNJeG80WnZaNEpFVENDUnEwbWhBWmMzalky?=
 =?utf-8?B?M2diZVd2WVJ6MzcvUkJ0bzZreGF5SkltbWxkM2xzWkVmUUVjb3ducjR3dW5B?=
 =?utf-8?B?c0hhVUNpSVEyUXJhU2pYd0Q2Sm5ZMTZhMEZ6ZzVMWmpSOHhTWmRWMTVseVdy?=
 =?utf-8?B?VStmbXNUN1p1VnQzUmlWR01aQWgvbi9vTCtjZVgyK0xwYW8wb1p3UmR0NDNB?=
 =?utf-8?B?TkFoTjhjMHhlZU1mSVR6dWRmNGZIUUFWWmo3RTBmckxUSnZNWW1OZEZOZytn?=
 =?utf-8?B?ajlzbnFxTnNSS1FPaGlqOTNHeUUwUzdMTXowQ3dtT1A0bTdWWmErRTVlaUNu?=
 =?utf-8?B?VWVEWGh4eSt1Tm9NWk5MVG9SRVVmVStUelFtQkNxQnY3S1FtZzhKT1N6cVpY?=
 =?utf-8?B?UDgxY1NOdG85SW5kbXMva0pYajVvYjBoWlhPQm9EWFc4ckFLU3NDWEtHMEt0?=
 =?utf-8?B?c2tld09WaVNpYkRBbFZSR2ZVdjJQVlZFbVNnUi93aENweFJRQWxlNUxYTXNY?=
 =?utf-8?B?aUZhSWczcDZSZm9hcTBmSkI3QWZvSlJ6emR0bXcyQzAxRjk2dWdJWVljMUxr?=
 =?utf-8?B?TjV2elhHNTBxYi8xRVQwWk9SLzFUQTNibk83UlhIeWFBMTdZeDdRa1dVd2VC?=
 =?utf-8?B?TmxTaFJ1MXlSVHdUZnFCaGdsaHNWZVQ0TUZmSmlyTHJoOXdhTUdnQjFieDA1?=
 =?utf-8?B?cnc3QkYyMHNEOUNCdVMycHY4TEdFeW1ob3lJdXEyTU9YOXo5dUZHZnlVUmh0?=
 =?utf-8?B?VWJySE5BU2hwUmljcVR2UUxBWEgrd3lFODZpd3ZSOVJvdUp0MVRGY3h0a1RT?=
 =?utf-8?B?YTlCVi9SamlEWi9EZkdvL3dpM3Y0YTVuN2diS0ZhN3B0eVNXTFhnMHR3UWNM?=
 =?utf-8?B?YWp6NktZRVFqQjBvY2NhYWRwMFlWQlU0UFRGdlNabno1UFFvUm9kc2NiSWl6?=
 =?utf-8?B?OUJubVlSakZFVjVNZXJWWGlhaVBLdU9qWmRtWWRVRGxjZzVNU29HQmtCN01k?=
 =?utf-8?B?T2lUenVWYnpMbGlvWDErdkxPMVVtZ2xZcGVsbUNtY0gyYVlMdHIvNnlweHlX?=
 =?utf-8?B?ZmJEbzEwV1hIK3FLbUR2YXUyRW8wVFZkMzF6MTZOUENGRjZxRUI2SmdnMnlT?=
 =?utf-8?B?alY4b2dObTFTZXNUaWpaZHRUWFU3RUtWcDJXdmZIS0VmZENQdWJBVk1oaTRx?=
 =?utf-8?B?empSb2pYQmM2Y2pQQnRGVVduWmJld1oyM1hyeXZnUTM3WmcwV3FDYklReUta?=
 =?utf-8?B?V05NMDZFMHRwTEpza2tMeGZQNmttL1d0RE5DYWhOb1F5djEra2hHdWpqSU5h?=
 =?utf-8?B?YnYyR3FFQWtUdkIyaGFiWVpvbU5yclAvSGc3OWxIaW0zV2xocTRVVGRPSGtX?=
 =?utf-8?B?ZDBUSnk3QzFLZVlTdWtzTGdHUWU1Z1BGeDlYaG5IMDE1VmZuTGNjaVpGRGtC?=
 =?utf-8?B?Vk9pTG9hU1JsYlFiYSt4WEJjRWFXaGJHMGZYcnFuVzRQZHhVZkd0Qm1DS0NF?=
 =?utf-8?B?aGVGeUNwWW1BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkhNNkZPYjNxSmJLMXZRcTZkTVlDc01zeHlhRjViUHVhMnlybDJwOWMyUFU0?=
 =?utf-8?B?OVRpV25HNU81OFVyU21Sd2hpbW1OcmVkVFRabHljZmk0NlpyeFNFWHpNZzZz?=
 =?utf-8?B?akJBU253TUlTSWh2d0FnNnZiem8xZkRlZ2FtRmUxOStzM2RNYVM3SWdaRDVX?=
 =?utf-8?B?eFpmMUZHL1BrSlRWbFpxZktLT1hEWWhVMVRFeVY0TUEzdlVFMDdIdTRBdTd1?=
 =?utf-8?B?UnBKVEVIdmRNUS9nU1UxdThYMnJjZVIwUDZTYXk1TFNQbDluTTJMRTE3a0ZM?=
 =?utf-8?B?THd1TlBmV1kwMTB0VTNZOG1MVUtpd09ISHpIVWdLeGlvQ2tRRG00SDl6aUVH?=
 =?utf-8?B?MVNBZVBLK3ZMUFgwamVJT2k1VURIaEV2RURIc1ZCbFNyN1FHWUNtdjU0aUYz?=
 =?utf-8?B?cE5WQUdkUk56WEZpenh4S2dBYjk0a0JHNldKc2Q0UUYzeTVXKzZjN2RqbjlD?=
 =?utf-8?B?SDBRbVFiYmlZMVg0TDlZK1BQbW5IdjRmMmFKb1pFOTRQdGRhMllTTUNsbjhT?=
 =?utf-8?B?Vyt5cDdTUGg2b1ZMeHNGMG1McUdFcVcrUk0ycXE0U1ZWT3c1ZGhQU0h2cUpv?=
 =?utf-8?B?UmIzUzhVUStKaHBFdVZscWJkV2J4UDVMbTFNV3JBb3NuM1V1MGZkRVpjMWFN?=
 =?utf-8?B?eDhYdGxiVnBTbUZqbWlNZmZGdmtNcW9nTWtSbFVMd0t3OUZ4NDAwREpNNVdD?=
 =?utf-8?B?dXFpWUI1eDB6MExHVDdKcXFwY0o3c05sYmRsL0tobWlPeDlnZVc5RndRRnZx?=
 =?utf-8?B?TDhrTk9obXpJcEtENzFNUThWVWFWQm12d1AxR2F3V2JhV3pWMExObkFrVE5L?=
 =?utf-8?B?bEpZV1FSVlZOMXE5T29nQlM5TjU3T0JjVFhDN2RibjZneVdINUtiTWhPd1lT?=
 =?utf-8?B?SDMzQ2E3WjlyV0lyamFBQld5djFoWUdoaUZ4NW1FWmFub05UTlB6U1ZkdDhB?=
 =?utf-8?B?eGVaUWRTdUI5U1pnazF6Nk5qYkNSekhJRytCZVZrQWpnYzVFRW9mb082ekRJ?=
 =?utf-8?B?Mys2b1A3d0dPRTQvT2FRdUo2SUF2MjZaWmorbnlBRTRBWS9GTmNnTjlqWnJ3?=
 =?utf-8?B?ZjdPTXJsalFuY2Y4M2Vna1oraXFpMVhoMU0zdE9ITmJjSG9IV2RVWmhMcmlU?=
 =?utf-8?B?cmVIOXZUWm5YWWdJQ2NWSTk0RVg5ZHd3Nll6bU1SMDE0amRwU253L01rV0h1?=
 =?utf-8?B?WGwra1IyVUtvVDFqTjFFTjkxemhCM2gwQXpjNk0rM3dyWnJWaFRYYklDRHA4?=
 =?utf-8?B?Q1k5cy9qRk5FOU4yRmNsQ3NKSjV6L2g3M2lRVWRHTlRmN3g5OC9nSHppQW82?=
 =?utf-8?B?R0JTUStDUTdwOVdhdk9Da1lDQURHdU9NdVltNkk3a25HN3N6ZVdGVHhuRkIw?=
 =?utf-8?B?aFpjbTg5MkVrU0JFb2hKcmZLUDhHTlV0UWhHV2V3TEZEK05yWWJRQ3NweitH?=
 =?utf-8?B?ZU1FYWxINmFtbzlaeHV4SUJxbWRTUmZXY2FRRlpHcDBDS0tuWnlzTU1SSEZv?=
 =?utf-8?B?c1VmVUlxN3kzbGY0UjBLUk0xZU5WQXp4dS9lRFNXVkJZOVpTS0V5azA1cm5h?=
 =?utf-8?B?bWRrUWdBVHZMdHliOFphdkM3OWpnRElMbXY2YjRWeWYrZGhVdXFQMW5ZUXhn?=
 =?utf-8?B?NXovV3ltd3A0eTM2WFBvYVRVL0YxN3VaVDJucHpOOHMrdmtUaVZ5ZGRTUVdW?=
 =?utf-8?B?NGF1MFZ6WnhjV2JYRVdiT1lvanUwUk5ocm1BN1FGY3ZlbHFidkxXL0cxalpW?=
 =?utf-8?B?OWo2WU5UUjZRN3JYSTI4cDg0cG1vSDdTc2pXYVV3MjdsZnhMeUNFZVJOc2RO?=
 =?utf-8?B?bkFyK2gvcmpUNUFTUUVFM2ZVb2premxDNlFxTWlabXpOZWdUSnYyeFhXejJw?=
 =?utf-8?B?NWZUNThBcUpQMDFMeGZoR3FqMlNYUTE2M0R0dDQycFNSVjNmT05xbVlLdWJM?=
 =?utf-8?B?ZmlpV25LdEVBQit5b3RCTm9Bam1JTGt2QTVPOTZUODZ3Y1JmVjNzaFV1YUlz?=
 =?utf-8?B?bFVPdm5kdlkwenA4WDNaSGYvZmVWM09mQUcwNUJaMjFVQTJMSEFNb3drY0tt?=
 =?utf-8?B?bDhNU1piV1JKQlVyNmIzOVQ5Q0t6a3V2VkNKZGVpTXo5UGZZQXJjRTdGQ2FU?=
 =?utf-8?B?dVY4NDVpYWtDTmh6RFRGUVdpWVpFcCtRYzdQaktSelByaWVydnlKckh6T0FZ?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74edc0ca-2c06-405f-5a62-08ddd91db75e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:26:21.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfMu7q9wJ+87xfCh8jorfHRsoL1XuTk0yXjajsa6SMmSU1n6ghzniX4OZPsh23OH+vrzl2fX0+sVXHVz7ISN99QM3cdG8tRPl5Z0yNiBmJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5144
X-OriginatorOrg: intel.com



On 8/8/25 11:52 AM, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue,  5 Aug 2025 15:33:41 -0700 Tony Nguyen wrote:
> > + * @no_phys_port_name: skip automatic phys_port_name generation; for compatibility only,
> 
> line over 80 chars

Will fix this.

Thanks,
Tony

