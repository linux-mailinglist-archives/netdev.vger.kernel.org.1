Return-Path: <netdev+bounces-114622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C525C94339C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28041C2445D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41581BC080;
	Wed, 31 Jul 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awEDn1yW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71501BC075
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440721; cv=fail; b=ssPkY59RWSBayQFrT+Cq6whUu6X44YmmqlVms5yuQrgJZ/eWus5ryr4Toz1mr1d8TFTEMb3+7a2CB+aNpl1uFsoHy2gthAPkHt6soi2ZF0PzsFNVVCtKGWAZc9JXFLUSY/Q1ODCSjQycKjlAMJQAIG3FfIMfz+ua9a/rLKVDI/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440721; c=relaxed/simple;
	bh=ijivw+YHiebrxZFjDWkMDpjnw+HpGm9mk1xHDLiwC+M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NKhbGJD+CWWKoKDw+6WAXyQ6Nrcty2oh90KiA6FYNmO1BH/fx1HoNsa2VqMyxz4oY4dqCqOCqj6112ZPm7lHGE3zQqLT5zfM3ckYlTQlX8Ke+4aZlOqo/6LrKOY6Kfbz1R9gx9/sk0mnEYeUs9uDTAxguE5HyEEQQQUhaHibLw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awEDn1yW; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722440720; x=1753976720;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ijivw+YHiebrxZFjDWkMDpjnw+HpGm9mk1xHDLiwC+M=;
  b=awEDn1yWqQ1m2f6hMHLuXqe+jXwIPceC3wxms+9/QjgNvA6PaM9Wc/y/
   ppr7heQLfYvON/eJto+fK7Pip4fUsxpO7nSJiJsG7uFBmR/BMuFahjNY/
   2UEqQprxfzXfmM/NNIBult7KkupdtfbkehXUe8zKVMNVTSFBrJzVs0sKa
   IaQXsPdm4F/zpB2d/KvolouerFkjCWeAP0YZX7Wj5zzKlD6VRjJ5P0RXy
   S/NZqKRwmduiPRPnfrTVVFOthkEtEgQz9+cdqaZAaRk/0nvLKtMUGM+zC
   EXtnkP4SBwN/WS0pu3M4xHBZoj/0vVONXamd1ch7KYvePgG+L6KGL6OOy
   A==;
X-CSE-ConnectionGUID: D+YqOZnnSYW+yVETL9sR+A==
X-CSE-MsgGUID: ZXmuKYCJTy+yne6/qCjcXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="24093491"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="24093491"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 08:45:20 -0700
X-CSE-ConnectionGUID: Uejq47fvSveRocM9ZBnAQg==
X-CSE-MsgGUID: YhAfCyrUQPqthIMsT3i7kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="59779496"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 08:45:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 08:45:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 08:45:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 08:45:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHlndUqobSuNn6u6Pe00d5rhik0A8Mi7dCNgKmd9Fog3oKa06H5CLKbAeA2ijGJTO7GjhJjF8Q1tPEmFrLh/+j4NpZU7t4wpvWOVJfLwzb1z41AhvjMyjwiod7YkF56XdRGs3vmaqkYX4UMaKwpWkPL38iUQrNWhm5oOMac71XCvaefH1qoGIwdu2t3BPTaNxliF68idfvDGsxglDXopwSFMiNmOndzjyzvSdkzXIg5yezRQLCmi6C+dvv9t8knIbEp+ar2cdPMnD3VKhiwrdOeh+WjFVOAQNWibd52/kFJJ88kGVU/d0IImtGZNq43QsoTHX3HgH4H/+3oDXQM2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pX4tPWKbTwfdgLm9Vsuj+sz3wcROut9TpOtMRqGEVs=;
 b=OfEYHKhACXxXdjfpPk5XVxljAz2t2dNDZeoPRH4WD69bcqvxSMl9OeANJZVSJHsVGIYMY26ME9A0+rso0a4aLL5rWRwdK57IRPciT3R2GBdVgjBY/WJMXhlnN2cZ+oFGyBwmLRA8IaUtzxNNX6r3rD0mZJCcoQEV8hPvdDpopWv80uSQdBa3VK/qycbMvkxLN8Lc49g8EQXGBA3RCmd/GxbQ+KHvH/9XDmSa5wHVmcTWpiuyZJW/N/qeNCmytrzYic32Ztx3AlRbukUhUFcNItKaQfJKzFGj6hruv7oU9rL5jUYUkQytAPxzn8RzCi+DyJDkwtYfssGcAnA1Yn+EwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Wed, 31 Jul
 2024 15:45:14 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%2]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 15:45:14 +0000
Message-ID: <086058b6-0dd8-e61e-e905-1647ed62dc00@intel.com>
Date: Wed, 31 Jul 2024 08:45:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 00/15][pull request] ice: support devlink
 subfunction
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <michal.swiatkowski@linux.intel.com>
References: <20240729223431.681842-1-anthony.l.nguyen@intel.com>
 <20240730184544.60ff163c@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240730184544.60ff163c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|MN6PR11MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c43b27d-e800-4fa7-ff14-08dcb177c4d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHNpSEt0Z1lCTjFCcW9KcHFVMy9WOTBzWjZoZWZhVE5TVnFNWnMvYzRXL09k?=
 =?utf-8?B?WG1CUzdSbkpsTDdGOXRuZzhpNy9OclkxN3NjREc4eHFDRUxTWmo1Ujl2blcv?=
 =?utf-8?B?dnpSRUovbXFleS9EK0VzMG1mVW1MN2g5cGNxTld2QW5oQncxK1E0ZnpvRDJw?=
 =?utf-8?B?N01LTStzTEhHaVd0RUcwNG9LNjNNTE95RHZhR0N3UUp1OUs0T0ZSWWtiZVpw?=
 =?utf-8?B?WE0xcVNqK3d0cjY2OThtcnpod2l6QmplSEF3TXZzcDg3RW9sK1NGTDRZMHN5?=
 =?utf-8?B?Rnc1MGVoWWlPektSTjdCRHpxb1Avcm5XZzR3NDFLbjIzU0lDUmpjUGdGVi9t?=
 =?utf-8?B?dm1DZ1JCWS9ValFlZUZZMmlpZWl3TnNGcG00R3haZ2dRa3RXcXdPMjVYMUN1?=
 =?utf-8?B?aFBObTR3aDJHNk4xOFNKSEFCVTRTb2E4bFAvelk0VXlXdGhuZ0NuTHVObjBQ?=
 =?utf-8?B?SW5zcHF3ZmdBUVFCNFFhQlZBT0JjRFFCWCtCRjdlanNWLzdCa0JoZ2FpZ0hD?=
 =?utf-8?B?NWIrSjlFUnQ1TkNoc0FSbm9OeWlYMCtOMlZtZWlldThxSnhuN2lGcHF1S2Iz?=
 =?utf-8?B?YlJHOHNnNExiTHBNek1yMnBuMkJzVWFSWnZEN2wzUXNBMTNWYmhRNzF4aWRo?=
 =?utf-8?B?cjMrQlhiN2ZGWnBzT1BNNENqYnQxZnVxT1lGNHR4eVJabHhQSlRJQ0lmZVFz?=
 =?utf-8?B?V293djc4QzJYS3FZWjBUckp0elR2S2hlS3NlVURoSUJzQ0xvU2xmQzNFSDg2?=
 =?utf-8?B?ZGNDOTJsQnBidE14WE9uaUxkNFhlYzJUUTVVOTd4ZVk4YmJKT3poK2xkU0dm?=
 =?utf-8?B?Y1Mrdmx3RVlhRWN2MUxlaXlMWTIrYWF4NlRDcGJlcm5hTjJicG5ZTExMZWps?=
 =?utf-8?B?eUNYbWdBVG5oWWMvbVIvY3RwMUF1V3dpRTh5Skl0ek55S0pMcXNGZE51TTk0?=
 =?utf-8?B?MWlXckFQSEc3ejVUazZaOEdRRVZ5Rm9TdkVoYUN2QzRuMkV4ci9tVGdmSkVl?=
 =?utf-8?B?L1hHTWo1N2pRWnJTQ2V3K2R6aUkxd095U0ZLMk5QQzE4ZGxrTHF1ejhCTXZw?=
 =?utf-8?B?ckFiQW9jd2ZWdThVNDBlY0M3ZWt0Q2dlMktEWjJjMnRXVWliSHdYNHA1SXlR?=
 =?utf-8?B?a1NGN2VLTVFvL0MzQVNNOVlsMUwvWGFRVXl5QTdwdmE2WVZwcmJyRVVlUGl5?=
 =?utf-8?B?aFNFOFlnRzhEMlJhU2wyUndNazNvdXRway9DRTZ0VkQ5RUpBWU5PdXpkQ2wy?=
 =?utf-8?B?bEwxWFFPTkU4REdzaVZpZEJ4VCsrNFlROFJiUWt0RDJrMXZPSDhLSU9DSTJ4?=
 =?utf-8?B?OVVjOXNtZFZwWXhJWEpMdkcvV2Fvc0lZN245ZFEremMyNHRqTHZDOFg5Qkcz?=
 =?utf-8?B?WThmUXp6UXkxRzBZNnVycHNCV1pGV09PVjlpNzlFOTA2b3BzRTlqTUFOdzUw?=
 =?utf-8?B?SXZ6WFNhTHB1SUpsMzFKaFZmaFVmMXFRRjVSdlZNWFAzWkt6TnZaMzZOL1pn?=
 =?utf-8?B?ZDlBZnFDb1AwRzFJMjJrb2t0em5UNXEwL21WNFFsVEliYVJZTHp4QVhhaGlC?=
 =?utf-8?B?MVBoeHZjZ1pRcWcvcEFBcVM3RWFCUU1PNFhza1JMVHJVb3Y3OFdpWkVVU25a?=
 =?utf-8?B?Uk9uZDhVZkhaend2RU9IdHlFRTNVOVFFWFVVTnVheVR3RTUyaFpXMTVsWGZO?=
 =?utf-8?B?YmxRWG0vNnpScFhINzBXZEZSaVF0TXVuUk1uRmQxRnFrTndabnMxR0JjS3R2?=
 =?utf-8?B?YTJGZkh6VDViZ05PR2hjUVFHdTlFYndxZE9Nb1R4Q2UrazNja29wOE9pWUdq?=
 =?utf-8?B?YzUvSThwM25NKy95SlVJdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFJqSkxVcFhxSngwLzBVanBHMVdXQXR4VCtoR3hIYlRZWGlpMmtsQ3dXTTM0?=
 =?utf-8?B?YU9KZzBxMFFibi93RjJqMGljSDFWcnBTTlpWSTdWdCsyQ3NFSnUrc25aRjZO?=
 =?utf-8?B?OXgwMUZjb3hqZEN5SzByRUhvc2RjRnpjalFJcThySXp0UmdsQlFQM0FVeXg2?=
 =?utf-8?B?cFhVSnZBVk5FbFFXaW5WMlNEbFhleW8vdkxJTndZemUwVURUQjJ0bnlYWGUw?=
 =?utf-8?B?Zm9hZjlSa3VXUGtWRitqUzR2RTlLWXAzQzNkNGk1NW4zWktjdGJPck5sdFZB?=
 =?utf-8?B?dzR6bUg0aGNCTURZa1RPZEtmVVVPVlNoS1NWR3NyYVFjSnRtLy9PRGs2dzRT?=
 =?utf-8?B?eTZMbzlEVGJBdVE4azFINXhEUWF5VWdKZ1dvYm1mdkozc0lBQkxUWkFHN1E0?=
 =?utf-8?B?K3h6c2tabk9rbDE5eU8zbjlITlhNY2RScXF1S3dRNmxVbFRQWE4ycThOZ1ZQ?=
 =?utf-8?B?QjJWNS9lOCtGQVBjeXFNSWQzSTF5SmphVVNobnJkUjg1MWFZS1BKTGZiMVk2?=
 =?utf-8?B?SG90b0EyU0lxNm9UNG9qNUluRkw0bEFmQWNxNUpLYlhDVTQ4U3MrSVF6UWtn?=
 =?utf-8?B?R29YaHVUQ3JET2luM2RmakwwY3NWdDlFTW1EblhIQjdZMEVvM1ppTXVtTXBs?=
 =?utf-8?B?YWZoTlpvcnNlakFxQ29Fczd6YnBDdzg5RGJMVyt5NnNTK04reWZvaHpJNUFz?=
 =?utf-8?B?MjVQN1pCSEIrSVUveVpuMW95dVJaaDM2RXNONFM5azBTM09HWHdJK1g4YU0v?=
 =?utf-8?B?dUVQYXFHVWFUbENOZGMxOHMwV3o2enVpYW1JRzhxZVVrVWU0Z1pIR3RrUVhq?=
 =?utf-8?B?bFBYbWJBMnZZRjc3M1RuZWoyN2NUc0x1MHhNYWE4ekt2QmdNckc1RnJYYm9H?=
 =?utf-8?B?MnM2UVY1ZmE3WHNiMzEvUUhPMXlOTnJPRi9tL0NDTmxJZEQ3dFl5aWlaNVF6?=
 =?utf-8?B?d3VZWVAvVFR3KzZzVWIrdlNSYnVWRE1uTjdHT0lzR3RRZlpGbXY5VWZoR2VL?=
 =?utf-8?B?b2xTYlJzSlVjS3U3cFgzMkV4NU9Kc01nc1ZqQitzQmltcDVCWjZFTEpEZ04w?=
 =?utf-8?B?TGhoTjk3cW1MbUJSUFNoMFl1Y1Vhb3k4YzZDVFJ3dmRBYlZsZEdQNnRQazRj?=
 =?utf-8?B?S0IweDAvMW1YbzB2djk0YmRBYzN2Z1RpMmUxeW41NU5NTnJIR2k3ZU5aVnh0?=
 =?utf-8?B?dDg4b2V1U3BUUDdTNGtGd0xVSCtPU1lidklmL0Frd2hGNTZKcHJjbDU0b0Vs?=
 =?utf-8?B?V056UytCMVVseXBMT2liQkVPc05YQ1FybDVXbjNMQ3NZSjJYRHlJUVBIZFhY?=
 =?utf-8?B?bWFHZ0oxb1F6TmdWS0t1cVdDNTRJZVFFeDJ4a1MrWi95eXpKRG5XY3JmUldI?=
 =?utf-8?B?a3cwdkk5RUl0cVdrYmQvdlF5elZmVC9lbTRlcndRdk4rV0duWFZla2s2cDRZ?=
 =?utf-8?B?bmxiTkJMSE1RVnNZL2tSMFYyS1FGWUxNcFhCdWxyaVhheDRJYzFqakxGM1VE?=
 =?utf-8?B?Qm5xRC9aYWMxdDBsS0s0RDh1eWYxYmhNWCtmeTkyanRGenVMejR1RS81V2NP?=
 =?utf-8?B?UkVSL2htY3ZnUUdReUErN0NTTnZxNjJ5Q2h1QlFjR2J5N3ZkSW5LWGk0VVg3?=
 =?utf-8?B?bzNTRmhJZnFJeW1iYWhpZE0yTlF1akVqbkNDc1NiT1NYL05FSWZZWWw2TXB1?=
 =?utf-8?B?VmRadVQ2YXcrRFd2RGo4OVJnUXJIRVgyenNkR25KWFhsZWY4cVlMSU8rZ2xQ?=
 =?utf-8?B?b3hoTWtJQTdOUXR0UXdhT0RvdUR6OEUwZE0zNU8rYk1OQVBmOW1HVlllY3Bv?=
 =?utf-8?B?WCtUSkc3ODc1RlFKdnhVR0lhT3drZXlJWmgvUDdUMXFhT2tjVFZiK1FhVFFH?=
 =?utf-8?B?WFJJWlljVmJoZEdvZXgza2dGcDdLOG8vZWMzSm9mMGIwbktGL00rd1NkOTdL?=
 =?utf-8?B?VitUS1hHVW56VFdKM2sxL085M1ZYdkxlSmVyUXU5aVdGeGZTZnE5ajgxTHRn?=
 =?utf-8?B?Z2hlUERVYzM2OTYvRWpzYXRmczBUQkZtYWFJKzVGT2R0ek1tMFBNcER1RFZ6?=
 =?utf-8?B?anVvNHk3bE1aZ0ZxWkVuUzhWelhQcmg1NThnK2lqcGRwckJVeVh4T1JUK2Ns?=
 =?utf-8?B?M0grc1FSNi9NU2toQU1IMDJocGdKbktFaHVzZTNvVllEZmxRZW5YT2llRzgv?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c43b27d-e800-4fa7-ff14-08dcb177c4d4
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 15:45:14.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljYbB1PxvbFQwfxvlFxrTfPvz1X9kRpQydQlNT4pORzQG4ixYCGxBOBZ5/sQNy6h80YwjhfD0RC1f59KfO4E3gK0P+kdUPVYQvlrCuJEt+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com



On 7/30/2024 6:45 PM, Jakub Kicinski wrote:
> On Mon, 29 Jul 2024 15:34:15 -0700 Tony Nguyen wrote:
>> Currently ice driver does not allow creating more than one networking
>> device per physical function. The only way to have more hardware backed
>> netdev is to use SR-IOV.
>>
>> Following patchset adds support for devlink port API. For each new
>> pcisf type port, driver allocates new VSI, configures all resources
>> needed, including dynamically MSIX vectors, program rules and registers
>> new netdev.
>>
>> This series supports only one Tx/Rx queue pair per subfunction.
> 
> I'm a bit surprised not to see Jiri on the CC list here, didn't
> he provide feedback on this series in the past?.. Yes he did.
> 
> Please repost and CC everyone who gave you feedback.

Will do.

Thanks,
Tony

