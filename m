Return-Path: <netdev+bounces-140182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425939B56FB
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C83283444
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B5C20ADDC;
	Tue, 29 Oct 2024 23:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdBlSLEG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC11DF753;
	Tue, 29 Oct 2024 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244766; cv=fail; b=nZuqsgVL90r8+9A68q6F8WEncRLevie0SUfTWdxOWtxgwf+Wr9vxfDejXKCPfr2Ish54rNK/whBk4rahItoK7CGnBEBNPv45LVqxcEdRu+JcA/1JwlMuoB+feSQVM9w3H5affV3/3qv0iJDNjzyuzuLb16jKqFfDxE2h7cMCxpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244766; c=relaxed/simple;
	bh=dXFZtceRF4ci57mp2hajgkY6H3H1FKS9cHX7XVh76qc=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mXyErPMOMrK47H31OYdMDAg6Jk8e+86/u/aqf7kJeMpUwdoz4mAXAUM00JzBBq/vXPgO6X2zDl41PkRISq29IKAiJT9uZqtTCoPk8gKlc0LZ9OPPHxtIEdYvuM7H5nPTyyDyGx1dYbOSH5HMp+ZjUxSfCVrFEjgfHEOoqzhvJSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdBlSLEG; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730244764; x=1761780764;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dXFZtceRF4ci57mp2hajgkY6H3H1FKS9cHX7XVh76qc=;
  b=EdBlSLEGeUKY9fh6R77BIXFqZxF4sFUjwzwRpp636o0sW+JqrJt6SeYQ
   0pAPWz8qmsNBG21AmyUOo9iFvTIRgRPCM8n7m0GfFEPIdeZ4xE84lpaLD
   rescPNvplM5BaKDEY2mxVvtGvjiiMmQz9XNyPmPEoi0JoJyvG3qpMHJyd
   t8xqDMHAQqao9ba+Ak6fb/1ImdDONE+IGRoIxcSw5rEccLkmDwAZ1fHRh
   ofFZBW11BUOpyxBBthZ2SRjAIAhxTaB4CBTjYMc4GOOSJtT/dMOZTteio
   cntBJn3CSN8K0K3X9ytUG8BGClvmFI0PImGC1t7ouDKn1Qu1g1DxE2OkM
   g==;
X-CSE-ConnectionGUID: jgyw5xMbRoSzS98TAfRChg==
X-CSE-MsgGUID: ZVQgbLunTiycc+ap3IJVpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47382781"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47382781"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 16:32:43 -0700
X-CSE-ConnectionGUID: UDfIMvr6T9eN3tqEEMrs7A==
X-CSE-MsgGUID: jmL9+1PuS7WqMJiAQbjf2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="86877570"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 16:32:43 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 16:32:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 16:32:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 16:32:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJono6Lmu0obkUgE3MgQGbSQdL3zpbluFKQxQ3cdEFYPeMZqOoGWUoF8WB53vH+i+6zw8I+folPn+DhsXBaE/5nwzgQqOjPZGM3/USULdKKPIz7VYZj1se/R5HgoxExz8ED4xKnU+6Y6Yt6NHZkpEC/GUzq7km3VzhW3Ug7WRoIoiyI+g3Qu72PReiGQYiGfGxKv6IKke1yOTiJgCjXpMZlSyGHuCfN7D9gV8KHUxxjyMOpWOjNH90EAX7NM8Acn9R9ONFWFlqj2xW3A53v2Y9XziLyw2qMgdoD7RXtlSFvp2gDJkf1fRArPhM8DhMJFCvxDX3ycwVGNrUCTD8dCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpsMJDCjXKiBrKXqEvaobd+aUlNI3ZGv468/PyhocNQ=;
 b=ctTxnP0yAwqyB4FfJR1AbVfu0Rg6kb/1uXTmfuSqUmbGC1WInln6Z9586KXnS/E2AjTvXZeclVYhJhF0oJngcGPcEHzyv1fi2m1XfFMF0IJFNPLd2bqoB6YwucevGe6ja7HGhqAxjchi+aLv5bi9sfKwAx7wMHoPv1/9w6uJOr7kQPvpx1VeXlmOUMfvL084OIFOLZQj9/Ebk/Gwpo00sq1/tEUFbflplKZlO9pbh+TbzAM4wNPdPWKJtEKxXE/6bT/OknSLrt6PVov9D7GmnvwppdAzxKfHfCsoPN2xR8sGEWTa1fvnDIPRQNRINp+Riev4tbIAHiXNZsqAWWOHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Tue, 29 Oct
 2024 23:32:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 23:32:39 +0000
Message-ID: <62387bab-f42a-4981-9664-76c439e2aadb@intel.com>
Date: Tue, 29 Oct 2024 16:32:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/9] ice: use <linux/packing.h> for Tx and Rx
 queue context data
From: Jacob Keller <jacob.e.keller@intel.com>
To: Daniel Machon <daniel.machon@microchip.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: Vladimir Oltean <olteanv@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
 <20241025-packing-pack-fields-and-ice-implementation-v2-6-734776c88e40@intel.com>
 <20241029145011.4obrgprcaksworlq@DEN-DL-M70577>
 <8e1a742c-380c-4faf-a6c2-3fa67689c57e@intel.com>
Content-Language: en-US
In-Reply-To: <8e1a742c-380c-4faf-a6c2-3fa67689c57e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: b68c77c6-abad-497c-1359-08dcf871f98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlJMOXBaemllalNXRm5FOHVzeFcxYVJLMlBuTkc0YkhmQjBBaENndkZLaTR1?=
 =?utf-8?B?OWZpWmxHVUV5V0FrSWhsT01TczhqMk5sbXBva2dmYU5qaXZGUWIxRUVSak1F?=
 =?utf-8?B?UTdlVUkyRkFGalJobDRUd1pLVW5zalZ2NjV2dTdiSVdTUWdzWTJaZE5aanE0?=
 =?utf-8?B?VkZDSEY5TklZU1FHTXRHTHgvVW5JQXpnR3FHYUNjSVE0R2xhaXhZQ0h6dlFt?=
 =?utf-8?B?UVl3Vm5OdXM4Yk1rT1R0Uy9MUUw4L09xRno3NE1VSTVBU2NYVHFQSGI2dWFU?=
 =?utf-8?B?N2E1eURhd0srbGpqZDNwSjJzOE5BK0ZkSXNnT3NNU2xNRWpBZEdiRXBxYjlZ?=
 =?utf-8?B?MDNQVHNsa2w2bDhWenRMR2ZUaElpdmUwZ25TK0RzV3RYOVVTclBIR3hHMXVh?=
 =?utf-8?B?NWtXT1ZpNU9TVnZWM2RIcE54dE1wbllPZU9wVlBoZVovVUdscklqWGdSOGw1?=
 =?utf-8?B?UEZwbHMxNlM4TE1sS3NmbTQrV1R6SGluSVFOT1dhc2xFVXNZVzJrdEJGUFZi?=
 =?utf-8?B?VWNqTGYraWJUNFpOLy9PWFhEZkhuU0VxbmlTUXpIeGhGcW9VMmdkdVJ3ZWhT?=
 =?utf-8?B?eGFqcDZsZHp0Zmt3SmVpRzNZcXkyOTNQTjJjaW4wVnRQTGhDK3haN0xUbGgz?=
 =?utf-8?B?TVpYNTV5WmZkTkhJUGJtMEMzcTJ1blZaTjUwYnEvUHlibDQ2aU55aG9yRSsz?=
 =?utf-8?B?djZiQnVpcnJlT0NrUGxLNzg3aDdBUzBVaEhncDBIelFjbi8vRFhjalNRUTVo?=
 =?utf-8?B?d21IT3VZcVFHWE5vTnB5TFR3RUJCZkh3MnlxenZIYXZxbHIvVDFtc0RwTUc3?=
 =?utf-8?B?elowY04xZjI4R095djVwQlBVR0dmbEpaRlBJbWVaSkRhNWNHZ2ZNWHdHY2dK?=
 =?utf-8?B?clJtM3ZZdXpCbmh2TGJ5ZmZDbVVSREY0K1pOVmNqMk9ILzdKYStXa0plMkRM?=
 =?utf-8?B?WVRSSmFOU2Vzbzd6aHRhNE1QZDI2ZHY3eForUk90aXRIQll2WnNkWitNN3B5?=
 =?utf-8?B?YzFxQy9xMVNPckZFZ1hvZWhKLzlvYzZkaUlMMnYveUVKRExkZ2JYckdpYU9M?=
 =?utf-8?B?N1UvdVZlQXZlUW4yOFMxalNRN0ZUZFo3WUhiUm1kV3ZEVzl6OEZCcmllY2lj?=
 =?utf-8?B?WlVDQllXcWlqSnJZdndMcFN5Q2RpcEQxVkdlNWpObXVrR0g4c1pwRDhEZ0VK?=
 =?utf-8?B?SERZa0F6STc1U0l5K2NBMUJLUFVYS1J0S0laN2tTanROZVZ3dEMzRkFpRVQ1?=
 =?utf-8?B?N05RQ1lmQVlxOVp4bXV6VlRMRnVlWm14K210VUQ4OWU0U2hQQVdRYW9RSjhT?=
 =?utf-8?B?YjZhL1JuMkY3RDMvRTRuV0ZEZGxvQ1BLTWZCVm5kTXBsRjJWM0k1ZGNlU29S?=
 =?utf-8?B?U01tNWJuVk9sTHNCV1Q0akpIUlFpS1c5YmgvdDNPMlBtMDA0L1BEenN5aGlM?=
 =?utf-8?B?UkxSekliV3dqbjBqeUY1Ujhjcy9ESjFzZ1ErTnA4TG1NL3FidU54T2ZCcjF0?=
 =?utf-8?B?ODEza05ZR3NGUlRwRXVVTUhHcUZ0Wm9GNFpETCtndlBZdHVwY2xORmx3bXg0?=
 =?utf-8?B?ekVOZWUxV0hmcVc4VkFacVorNVJPajhYc0puTGRNcUV1VzluSUM2RDYvYkVs?=
 =?utf-8?B?b3pTRFJvSUxWSW5MWGFwWkhXOFQ3bHd2YlpuckgvK2M5SUhVNiszYmdPei8x?=
 =?utf-8?B?UDh3c20vU2VrRWcyWm9LYTkzT3B3dDh0dGxiWXNxWkdtamFTTTliVVdENy9E?=
 =?utf-8?Q?dfC+GBRAjt/QWFe8qjhUss3oiWk4RGsdW7Q18QS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU5zdFpJZGNtQm5kWHpTRjhNRll5Si9Gdm44UmJmdThnbVpibERUejFuU1Ax?=
 =?utf-8?B?TlJqNys1MTJ4QlkxWHVHRjBCQVNQMGtQL2ZMUkR2Sm1UeVBqZHpVTnFsYUp1?=
 =?utf-8?B?dlE0OWliMHFQdXZHYk1ZWE5idXMvRzA1bkorNS9Pd0NpaFcvVUhydi8wSDdM?=
 =?utf-8?B?VjBSNDluRVlKakJSL3hPL1hsaWJwZkJCVTViRnEzSkFJbm5LVlhKeVRRR0lQ?=
 =?utf-8?B?QlROTVMzOFZjU0t1VXRidnFhSmNLSUVZUW0zMjJXazdpZHZFc2wyVGgzTFJ1?=
 =?utf-8?B?eFhOWTAwejBSdVlGV1FSeUQ0YlVkWHNpRnBUZ0xhTy9jblBEdGkyRXlITWti?=
 =?utf-8?B?ejZnQ1BJMi82VzR5NkpreVoxenFiQi9NOEhhT0NtbXBjV3RISUQ0UW8xQ0JU?=
 =?utf-8?B?aDBaQmdKakc5dnpXbS9NZWFEaUlUTm9MZU9BR1U4eTYySjc4VXZNNlBrT3Z0?=
 =?utf-8?B?V0g1eVlVK29GbGdLZ2FrVm1BcXlCMWpqVk1seU5VNHJINjZKcVAwb2pkNzMy?=
 =?utf-8?B?dmp1NmJYcWk0b0hYbnpUTWxjWlh1Uk8wWER3ZTY5NGI4S1NrMlZELzRtTTU3?=
 =?utf-8?B?TzhxWEJPZkFLSktMVTAveHhHdHRwaEExbHhpVHhVTzYzdkhab0pNT0xTTjMx?=
 =?utf-8?B?eGV5dHJadkR3c01ubkN5SFFkMFJJV3dHZnJqcGlldzB4c2Z2dysxT1FzNVpj?=
 =?utf-8?B?ZGZpQVIwTmtsbGRJWlJ6UHN3eXJlUkhLSnB5NmFxWHVSWmVrZk5JWmtQMzJQ?=
 =?utf-8?B?Sy9STjlKNlNNOWxZZDR1cmZMbDBJR1J1UVdxRkFXMURVeWpvdEp5WmF0SkYy?=
 =?utf-8?B?Q1RQdHBxcCtvditWMmNKUzNrZllGMnZSTFA2UytCZUVCc1dXQ2sxRWpBN0wy?=
 =?utf-8?B?a1FPNUxJdFhIa05uMEtHcVh3N3dNUnVFTDNaWkhoRlQ0dmQ3WEs5UVR0Ynpu?=
 =?utf-8?B?QVRLMHJYR255MVUxSFlPZ2J2QVdDYTZIZEdwN2hwandpTFV0VTB4bk1NNjdP?=
 =?utf-8?B?V0ZBVVMraHVqYzI3Z2UrT3NNRUtEejhHait2TzhZTDJZblFmNzgyeEpCYVV3?=
 =?utf-8?B?aHMxYmFQYk1FVzZ4dHRhL0s0SDF0aU4xbFhSemlHUHE3RVd6U3QzeDNpUisz?=
 =?utf-8?B?TnRXdmh5ZHdMVVpFajFncEtRdkt6Qk9jS2piZUZ6R2lkbVNUR2JrLzR4dmJM?=
 =?utf-8?B?U3hadWNPNjdVdWw5Y0VaTHFJZ05ZM1UrbnF1eVVpMWw1OFZHcm1UTlQ0V3p3?=
 =?utf-8?B?YzlxNjNPRGh4NktiWVIvdnlJamN5aGN4eVorT1VyZWlpSE1TNG5xZk9Bdy9o?=
 =?utf-8?B?V3FROTljRUlCbkZUV2xqZjA4VUtvZmMzVS9hdHlQUGR3SG0xMnhCVmhTaGhW?=
 =?utf-8?B?RnhycWM1dVJ2ZWRRMFcyUVdUNjNwTVVHMXhYQlJOTHA1Vi8zeUw4Z05FMm5M?=
 =?utf-8?B?Z2cyaDMvaEtFUUxXaXlXcnBQekJ2R0tCdzNJNGNWK0EwV2RGVmpnZG9Kb0lx?=
 =?utf-8?B?TTF4a1lFWmtMTWFpUnhjanI2OXRGQ0JxK2IyZHZGQXFGTFk3UnE4RzczYmp2?=
 =?utf-8?B?aytXc1dTQm5QdTh2TFNDWUhvZ1FDcFhpd0JxVzBHQmc1OHU0N0JMaFg4NHRP?=
 =?utf-8?B?cHVTZ1NpZk4rdDc3ZERTQWlJdTNIQ3A3UHpUNnd6TTR5RHpJN2FOUlpVZE0r?=
 =?utf-8?B?ejRiZCtzVHpIM0xVQlpmUnFidGdDbkgvT25mMjVjTjFKYXk5Ymd4NngvUTll?=
 =?utf-8?B?ZVZXTFlUMXRUWTU3MkR5bkJHODBSY1NEeDFFUmh0ZjcyamZXSm5CK1ZmcWpJ?=
 =?utf-8?B?VWZwZ3VhQTNmaFVrVThzR01xVUlvYVV3SS85NUFDSUtYSXUzM3N0SjlEMlVS?=
 =?utf-8?B?VWE1bFF5ZXplR1h0K0RheFRuWFM2bzZSL25HOXd4MmdYbXQxSXMrOHY2WlVM?=
 =?utf-8?B?Z1FBNXVTWHYwVmlYdEQyaFh3SGp1ZWhJYjlLVXk5ekF6SW9RaWRUUVFiajFs?=
 =?utf-8?B?RnZzdW13VkVMTHc5Z05TTmVuYzlyNGM2ZVI0d0h3VWlqaDdMckt1aWZaT0lB?=
 =?utf-8?B?MW0xTlNOdWUraWQ4b0NodVdhbVBQUkRXeHZMaERPdUpDQzFHU3lhUVdZQk9o?=
 =?utf-8?B?NktRQUJwK1B3MnN1UWdjUzhWREdYZG5vZVBUUjNveUczVmVaVzdHZTNxVWhR?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b68c77c6-abad-497c-1359-08dcf871f98a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:32:39.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bt/1OKf/3Nm0JmCExj9pn+SC3+dhPctFttVkImla1HhNICAfqPIbBzJQ3XRTGmQDE0rF725AfEI/+hVWt2W9eKmakp25U8MXUKQ/engDcXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
X-OriginatorOrg: intel.com



On 10/29/2024 3:09 PM, Jacob Keller wrote:
> 
> 
> On 10/29/2024 7:50 AM, Daniel Machon wrote:
>> Hi Jacob,
> 
>>> +/**
>>> + * ice_pack_rxq_ctx - Pack Rx queue context into a HW buffer
>>> + * @ctx: the Rx queue context to pack
>>> + * @buf: the HW buffer to pack into
>>> + *
>>> + * Pack the Rx queue context from the CPU-friendly unpacked buffer into its
>>> + * bit-packed HW layout.
>>> + */
>>> +static void ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx,
>>> +                            ice_rxq_ctx_buf_t *buf)
>>> +{
>>> +       CHECK_PACKED_FIELDS_20(ice_rlan_ctx_fields, ICE_RXQ_CTX_SZ);
>>> +       BUILD_BUG_ON(sizeof(*buf) != ICE_RXQ_CTX_SZ);
>>> +
>>> +       pack_fields(buf, sizeof(*buf), ctx, ice_rlan_ctx_fields,
>>> +                   QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
>>> +}
>>> +
>>
>> FWIW, I noticed that smatch bails out checking all the CHECK_PACKED_FIELDS_*
>> variants >= 20, with the warning:
>>
>> ice_common.c:1486 ice_pack_txq_ctx() parse error: OOM: 3000148Kb sm_state_count = 413556
>> ice_common.c:1486 ice_pack_txq_ctx() warn: Function too hairy.  No more merges.
>> ice_common.c:1486 ice_pack_txq_ctx() parse error: Function too hairy.  Giving up. 43 second
>>
> 
> We might need to wrap these checks to become no-ops when running under
> such a checker. It looks like the parser doesn't like the size of the
> macros?
> 
>> Maybe this can just be ignored .. not sure :-)
>>
> 
> I would prefer if we found a way to at least silence it, rather than
> straight up ignore it.
> 
> I am not that familiar with smatch. Let me see if there's an obvious way
> we can handle this.
> 
From the look of this, smatch is running out of memory trying to keep
track of a number of possible states. Likely the depth of the macro is
too high once we get beyond 20.

I think the simplest solution would be to disable these macros under
__CHECKER__, and possibly even write our own checker in smatch which can
cover this case..

@Dan Carpenter:

Any chance you could provide guidance here?

Thanks,
Jake

