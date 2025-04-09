Return-Path: <netdev+bounces-180596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31BFA81C01
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A5E3AD642
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CE71D5CC6;
	Wed,  9 Apr 2025 05:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4gMbIfK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECC814F117
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 05:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744175095; cv=fail; b=ZVfXZF8ROYsyJOfUb2N9bEx0EpdWfzvNBROLKd+Oll8dKB35Kugs85hDJe35YCGKoKUsnpjU+9GXcure7wzXqZDaCPfqGZmhEaQLusUMBwnGp49cCWtMcH9M29T9hHJ5CcLRGTDXEN9F7tvNzrK5eTQ9EHwaRJaeArH4AXAuqo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744175095; c=relaxed/simple;
	bh=DZEvMIRte+dglc/HDr47YG+zCCP1kYlzk4JGmFCwUfE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nZQ9mGTjE4OEScp+IJMUvsa+4Yjhc0/RHMC7DuGKkqsKNw2L0ilxgvXNsokzXd4ETet5J2dn0hZXK8T1wGnTCmB3hiBOLv1QMUIWytO4+3DWc7wsvleRZA7WVuI8vsnIgSRbjShDPiQT5MMCiPAoAIyPr6XHddzV5RoNQA/mZ1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4gMbIfK; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744175094; x=1775711094;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DZEvMIRte+dglc/HDr47YG+zCCP1kYlzk4JGmFCwUfE=;
  b=G4gMbIfKekOOE2fNi3nUJuU8ZyjIbhaxNI201xDbYc01I5zH7oSl0JMP
   CHYR7zccfsxGvotlNz1tFIFhjlE+Y4DJcKpkLXb9YoNJ0XDR4r0ig4Ymg
   /WPhMbYw4sT4AEev2330AzZGX3g9BPn/VRzBVfRo9oAtbnW6qVlzcrtQt
   HwzIGdIPWhwSyTMfYO7dx+hOTbGws2ZzvM0AlxHXvYTtGe+1duTiU4yf4
   9oYmIxeDt+5O03G0wi+mtbZ8IYaHtbyG58aa7LpvUNArax3P6v/Z17tyY
   n7PhEo8/ZmY0OPATx0MHLps1DHbvg1pzR4u4WSRSoWlwtEGVOiBK69CZk
   w==;
X-CSE-ConnectionGUID: T+cY96w5S+yuzuqv3WgpiQ==
X-CSE-MsgGUID: tHdO61+GSBebJbbjEDGUVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44878840"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="44878840"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 22:04:52 -0700
X-CSE-ConnectionGUID: UKuS3bBKSeaUYIEegBDs3A==
X-CSE-MsgGUID: 7n13FqqDSvuOwKvYlsPheQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="133334605"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 22:04:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 22:04:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 22:04:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 22:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Srv1XqFJ1NVPHoZ0v4Hn62EQaz6/QbPVsJfB91Bzy59Bk27a14iEisauzkJM1irvEjs7cB4NP6NipLnT1Yo3LihdnOqBu8+gTz7XzV+buk3wWNQqFWE2PxzwLxRgxBbFJtJa69rigIBNIHBjHnTo6yIVv8qCeYyPTNxmxWoTiiru6hmOD7E9yKGkXw7SFb2DSCcRqecq6BFFvUCnxvpiCeqHeW/Qz5mg2v0PZTtFSZzvgRY9eYhI5rgl3osMkQEuMf3IbUXKsOpRs4Z9sedFLLq/oL86szPB+d8hGd7OO/c+DajyaPKuT+xUFIm9wrNC2sOwlgVXh5yWu09Y66E3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECS/YOqGyZ1qd02S5j3H96AfdkoT3IKZQJudBclTblc=;
 b=bPPdrrvt0dX+zPpyalAxpuDf0dmxW3Q15ErU+omEmeY16d8CJLrxcSmTokoznN2LyoGcihKR13oMHkxMp8q4maBrtQ+ebK4yiVRsuVDnwlhgqhgkJdEi5nCH9c8Gb2wQA04BxO8bsI/VkBLgk2ftIMDBn249Vn4okzZQI/yNUswzvXnk+gDCBSbBguqF5tigKXZTcv2jEawPlYLwh2HoD6cdQCB97UnDn7Zrkcy0qq/aimO6bL/N17+c/tXvsFdlNCWO+pdO9qHKdw4Pt9JV9eUN8CwdbPg2U1908Tm0p0oOPDt7tCNrN/4bk9M6WLY3kyFQZqj0IzBe66IOV8MM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5265.namprd11.prod.outlook.com (2603:10b6:610:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 05:04:48 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 05:04:48 +0000
Message-ID: <4fdcd9d0-b150-41c9-8d50-655e1f38098c@intel.com>
Date: Tue, 8 Apr 2025 22:04:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/13] tools: ynl: generate code for rt-addr and
 add a sample
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-13-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250409000400.492371-13-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:303:8e::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: 939ec50c-cf2d-4fc7-1477-08dd77240d2b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXM1dERvRjNtbzVvQ2w3QzdnNGpSTGY5RWU2eEQ0NjdqRG94WDVmTVc2Y3dO?=
 =?utf-8?B?ZUcxaUxoS3hCTExlTXMvT1VQSEZreWJSOWNPb0tsZXhhT29MZDVXc1RKNi82?=
 =?utf-8?B?cGNtanhDSlBiK2k1ZGwzVHhjamh0dnU5RURiY1ozRzdCNWdnTHZBQjlXRW9B?=
 =?utf-8?B?YXhONFcyQ1VoWUowVHB5NXlDTnE1WHpsQ0JCVGdRTEJZaFEzQlp0aDZ6WGZw?=
 =?utf-8?B?Z2cvbHh1TE1vR2Z0ZmZsUEN4dEVCcjJTY1JvZXZlOGhJakpCUFBpYk14WWIz?=
 =?utf-8?B?eUNtdkV6dEtaM0ZQOHk1dENtaC9SRnVjWVBJamxKUklLNmt1cW8zM1NCUUcx?=
 =?utf-8?B?TzJtL0FkN0FvVTRtbEZGSUUrNUFBdHVvc3hTWDRxdkhPZFRvNC9GNjlQQWN4?=
 =?utf-8?B?NWVmRkMwTGFWTzdPYTAySUlrdVpKY0ZqeVZlSEZBV1VuUytlbjYrMzJjNEda?=
 =?utf-8?B?UkhJTC9XMGYreG41dkF6T1BlU3JPU3BUZE1EazRvNHltNEZ2bkRuYzB3NjRD?=
 =?utf-8?B?WFgzVTJRSXcrSFh1QnYyb3IxYXFVYUJKODF2eEJKaERIa1JucFNtUXQ1NjN0?=
 =?utf-8?B?R2J1UGJYbzZaME14TlQwSU9NV0xHY0Z1T2RRLzFCYlJGOGRUOTZoMUhrSlZt?=
 =?utf-8?B?Wi8yR1A3WHVvbWhRTjk0L1JQalpuWlcvMlN3d2I0bnIwd3YyZ21xS2UrYUsy?=
 =?utf-8?B?US94NGtHbGsvcFRnUUM5eS9TbmJyeGd3eFZKMk1SVjlDdkxGZkpWMkxUTU1F?=
 =?utf-8?B?YVpKSFRTTVlFU0dRMlI3enNXazc5bDhVMHF2SjVMak9weU5vRGlwbXJ5Z3RF?=
 =?utf-8?B?N09JKzJ6cWJRSGhVVE1KTEpWMllUMnIrNXJ3ZnY1VTdjNm9IejR6RmRLYy9E?=
 =?utf-8?B?NGxnSzVjMEZiU2w4V1dqeHAwdEI2WjVENmlucFNoUXhEcFZFWHVJLzJIUXY4?=
 =?utf-8?B?Nk5Id3VHc3VEOStqRjh0YTFIQUZ4T1VxUDVXUUZkeUYwR1hDY3JxRjVzZGF1?=
 =?utf-8?B?OC9ZQmRqaG5LeDRyZGZVcUxJdDF1ZDZiR1FWaExrTHpJSkdGbTBHdUpSNFdz?=
 =?utf-8?B?N1lucFQzUDR2cEZMV2w5ZzNXQ3I3NWdkYUI0SU5DbkF2V3VlNUg2dC9ydHJq?=
 =?utf-8?B?QTl3QXlZRStCZ2pzWk1xOTZFYklJWEN4ejNYdzVpSmpxcTlKVWk4YU9sV1ll?=
 =?utf-8?B?N3ZDYTBtNDJncjMrM3RSdmZpdXJSM1NzMGxxdndOUmRUSkNrc0hQUjN6bEpx?=
 =?utf-8?B?YXhxNVF0TkF1L3NnOHE2RkJmMzMyczRBbk5jbS9acDVXUTNBU2U0bEtaampR?=
 =?utf-8?B?bTF4S2VwS0ZvUWtSKzBFWGZ1YkRlM3FMOHh1VEtNK3hVNlJnTjJiRjhGMTVI?=
 =?utf-8?B?UXlZWjdETHV2UmlFNlFwNkpDUG45WXJYRDAyRzhtc1J6cjZscXZHQlRCSCtJ?=
 =?utf-8?B?V3VmNklVa1Z6MEQrdk1rbXRGZlNEQjYwVUxHb1RNbzhxRUw2N1k3T1NzMWV6?=
 =?utf-8?B?VUovRC8yZzZYVjEzZXRYcWJVS21MNzhVSUliN0loR1V2bGJqWkxDdEE0cHdY?=
 =?utf-8?B?V3lhWVFtWVFZN2J3RXpNK2luckFYaEJ3dGZhTVJTaW43ZG8xcGlzQ0hYTm1s?=
 =?utf-8?B?NnNrZXVwbVRzK3VYMXVxajhjQ0MvQVNBUjFSc29yRVV4RWNhcjFsM3RibDMw?=
 =?utf-8?B?SUVNZG1oQnp1TUsxMTM2TnFZZXE4OWlaMmxNUU5VdUd5eGp5T2tVbUc4cmY1?=
 =?utf-8?B?WU1ETklwWUdqblJVcjR0dkN3Y0NhSHBSRnk5cS9lbXZRbzFFam1TeVJwMDZo?=
 =?utf-8?B?b3Jzb2x5VjRoME9lNjVKOUs0R3FaS1BCQzVYTHI2eCtrR2xDSzk0Uk9YcWhr?=
 =?utf-8?Q?ooHy/j0ZBR1Gg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2d2WUd5dXNZY0s3dHkyUEdORlpZR09vcHFCcEVwZnRnOXpMTUdXc2tmd0lY?=
 =?utf-8?B?VlBTVXpTV2lWaDhhSkdkekU2VW1GbnVlVDRraUlSaVk1SHJKVCtwb0RyMHMw?=
 =?utf-8?B?aXFya0V2S0tsNTE3NXRMKzcrdGtqVVVYa05WYUtPRUIvN2dJY05nNG1VRGti?=
 =?utf-8?B?YmdLbitsM2NveFlxTWZYUTl4Um4zeXZGV3BndFRXNUtJenpMaGtjTE9YUEp1?=
 =?utf-8?B?b2N2UXcxTDJkblk1ZUtjSTlwQnFUd0FVbU5BTE9ucVJONnMvWGxqY0RIbi9Z?=
 =?utf-8?B?RXdLMU1kZjFWT0ppVTZPcnViUjc2Vk9TSFBrVVVZRmg0RTlyV2tEK3FyMmEw?=
 =?utf-8?B?eVI0TmJTK3hyOHhlVEdXNEorM0wrWHF0OTVhVi9udk0wQS9LREF0WTZlaHdT?=
 =?utf-8?B?S3NVeUg0VDdnSEoyM05sN2dlbVB5b1k4eVBmajFlYTJ4T3lGUmxkeU85elN0?=
 =?utf-8?B?U3RRS2pqM09kUEhUbjRzS0lhcnBpNWVublBpVVNSSC8zV1FMUkFFYm5oMHlr?=
 =?utf-8?B?U2xEcjlpblh4Z1FyVTFoNlhOQzJtNEV1UzA4b2hxdmRFSHdWVnA3NXI1azhv?=
 =?utf-8?B?R250bVRueVdHUm90d3VDMktVRnBlMVZPcFh0eVRybXZZeXkwekVJaG5PajJG?=
 =?utf-8?B?ZThFbFNwWGtkSDEwNGRBcU9QaVJuM214UkVMRWFYM2J1UFdJVjh1amExMkk4?=
 =?utf-8?B?Q09yV0NySXdSbThUWG5CdDAvS2RmL3ZPRzkrQmI2T0RnVjBHVGhXdllieThj?=
 =?utf-8?B?UmJIb1RPdFVGZnFTb0NBT1RxQ1YxVXMreXJhb0x4bkxvSUZsRWN0M05XTzF2?=
 =?utf-8?B?YmxHQWsvcFNyOEVaYVhmZ3NkRnhBN0tteVB4NVJVUWp6ODBnbjhKRFk1K0pz?=
 =?utf-8?B?MmFQZ0dDeWlnRDhQYkpYdS91OEN3ay9DdGY4ZURzVjcybVhTME5SOEw1WnA3?=
 =?utf-8?B?ZkQ5cWIvKzVhc1llZWd5V1FYcmVib2RFbVYzVjNVcnZpKzFQZXVpOGtLYldP?=
 =?utf-8?B?R3E3OHdQYzNKZWx2NTZteUxtRWJ6THh2MVlQZ21jWFpVa3ltZDR1REdEd3ZD?=
 =?utf-8?B?VlhIRmdzSjdiOS9wRnNlVklGcXpqTUNNOUhuVHl4c2lCOE9tWmhPZnIwUzVZ?=
 =?utf-8?B?U1pBT3V1aFE2QjlTZEFjcGVRSGJjMkFDYXpEemhHZnBSdWxia3VpdHlXKzJ0?=
 =?utf-8?B?UEV5VFlTSjFoaVdjajVkSUsxZ3dlVUhxNmR1WDhIWU5VTzhLamdYSUFad2U4?=
 =?utf-8?B?emdVem15K3VsTUJOU2JRQVJkMmovODBzek80STROalZtVkdBZ3NWQTdHTWNh?=
 =?utf-8?B?Z1hHRTJRRUVYa0hOdVVkN29DZzQrQXgwRk9QVjdPdCtzY3pBZUxhcEN3TGVG?=
 =?utf-8?B?bnVWZG1TUyt3TnNnRlNORnR6Y2o3KzZRZUlJVTA0N1NpWDFsaFlqMkh5TXpo?=
 =?utf-8?B?UFlIc0R5R1BuS1FRR3VBZldGR21PaHpQUzFmWGZ4SmFjUFBSVWRROTJpRkhi?=
 =?utf-8?B?SUJSM3M5MUVtS3ZzRmJvcDhxMklCdTd1YjFtRDJaMGhGcmpIK1JZUmlNUGVQ?=
 =?utf-8?B?YjFCVnBFb0NSalVrb1JqblROS0U1eUJNNG9EUWtCbVJ6ajM5V2wvb3FzZ3d6?=
 =?utf-8?B?YWp4OXNhSUhzS2o2dWNFWGE2NW8vUlljNUVlelVJOFVqSExXYkJmUTVCbmlY?=
 =?utf-8?B?QnBOcFI4cjJMYkdsME4rd0UyRm1GNFowc0JJaU9uTmpwVG9zSkpQM1ptbWU0?=
 =?utf-8?B?ZldjSHcyZHV2djFUK1RNcjdDQ1VJbFk5OW1ZbHNQeklTTUJHM1U2QnpNYlZv?=
 =?utf-8?B?M3dqT3Vzd2JHQUtud3ROdEJYQjBnaUNlZk9FbGJjS0k3ZXd3c1YxalovYzJC?=
 =?utf-8?B?dyswendvV2JLbWhPT1hwam9iMWhrV0xFYTk1bnFkMUp2ajNlTTE2N2lhSEtO?=
 =?utf-8?B?N05xS0lGQVY3ZEZUenJlNTg0bkhCSzFJNnpmNVZLREZGUFNIcmpuOCtJVnlU?=
 =?utf-8?B?NThaSFR3ZWVFWEthcVo0ZWJYSnZwdHVwZUtDeHA0dUpHWmhpRFJqbUpEbWFM?=
 =?utf-8?B?YVhJelc3Z0FRempvbmtFMmtLdDdmUmFFS2FMYkRFeER2ZWJLQ1hIWnR6Mldo?=
 =?utf-8?B?a0NFOVpVNFFjZmY4S3FobmNrZGhXVGhYWFY0L2RVU1dTUWFVUGxWeElIMHR1?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 939ec50c-cf2d-4fc7-1477-08dd77240d2b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:04:48.0899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhPKfjEhve68VIJUftJgOExeFVnNr/ya1+SxqpIuRjN1RF331hhF8Lvt3hslR6t+LjIvaYL6hnCF3iboQaDuPePkC1guwxVXQaqsyHQ4s8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5265
X-OriginatorOrg: intel.com



On 4/8/2025 5:03 PM, Jakub Kicinski wrote:
> diff --git a/tools/net/ynl/samples/rt-addr.c b/tools/net/ynl/samples/rt-addr.c
> new file mode 100644
> index 000000000000..c9a6436ad420
> --- /dev/null
> +++ b/tools/net/ynl/samples/rt-addr.c
> @@ -0,0 +1,80 @@
> +int main(int argc, char **argv)
> +{
> +	struct rt_addr_getaddr_list *rsp;
> +	struct rt_addr_getaddr_req *req;
> +	struct ynl_error yerr;
> +	struct ynl_sock *ys;
> +
> +	ys = ynl_sock_create(&ynl_rt_addr_family, &yerr);
> +	if (!ys) {
> +		fprintf(stderr, "YNL: %s\n", yerr.msg);
> +		return 1;
> +	}
> +
> +	req = rt_addr_getaddr_req_alloc();
> +	if (!req)
> +		goto err_destroy;
> +
> +	rsp = rt_addr_getaddr_dump(ys, req);
> +	rt_addr_getaddr_req_free(req);
> +	if (!rsp)
> +		goto err_close;
> +
> +	if (ynl_dump_empty(rsp))
> +		fprintf(stderr, "Error: no addresses reported\n");
> +	ynl_dump_foreach(rsp, addr)
> +		rt_addr_print(addr, 0);
> +	rt_addr_getaddr_list_free(rsp);
> +
> +	ynl_sock_destroy(ys);
> +	return 0;
> +
> +err_close:
> +	fprintf(stderr, "YNL: %s\n", ys->err.msg);
> +err_destroy:
> +	ynl_sock_destroy(ys);
> +	return 2;
> +}
Nice! This makes it a lot simpler to write small tools for dedicated
tasks or debugging vs trying to use one of the other existing libraries.
I think it helps make netlink more accessible, and appreciate the work
to support the classic netlink families, even with their quirks.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake

