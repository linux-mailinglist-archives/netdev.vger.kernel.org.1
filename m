Return-Path: <netdev+bounces-180593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EB2A81BFB
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69903B6D3C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5A316F858;
	Wed,  9 Apr 2025 05:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuNvtAvB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FE171A1
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744174840; cv=fail; b=fmPvN+WFgxCLTT4KAFoDfZzSSnT9d6peHeZKv96zIGp5omR4yx6RbboAbyR6sro3b49M1wCBiGN6AR9MRHhFvnV7Xr9DZA/AmDosYInVceXlHxuN5GBsa349EVYs6ZKxyFLDHaQLaJE55k7IgksNDMADTyazddTSzbINKkulblo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744174840; c=relaxed/simple;
	bh=YHFCNsxhKjOqn6vE6SQ2ju7N1dIqCGmh/bOIbkFfvD4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e4jTRWlVSVSjLPwukaFWKGSvz3l4xIHHwtZSzx8aIWsdKB15+Yb56goswNASoBiSDNsn9IPNseDb1WlDlebvdCgiSl4MzpxnVplzEf7RMGUItrDGCW9FzmhHxzNnflvqGxn4P7dWpMxNJ7Q4mccDRmZOpzO35ldWzn2az63cLNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuNvtAvB; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744174839; x=1775710839;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YHFCNsxhKjOqn6vE6SQ2ju7N1dIqCGmh/bOIbkFfvD4=;
  b=TuNvtAvBwpYnp9wCUACVW5e8U3ae9IkpsVhoMW001nQUDDnCXMLZ+Jjb
   QdFBPq85kVW05jsc4+jLbUoJzMfIg6+Um2aoEVfXrPmSi6NFovyL0zzj8
   MaSUT5wF8JlZd5O9ITbyZOvqNCiDZYs97991t5iyBlxiOTpaWTT/wgC91
   iKrVgU913yKX0nj77WQdcztdRD/SW75dggEOaRAx5jCMuCNDzA90LXjM+
   DiM1ByBEYvVL7HgakxbfAxQ+H9F5AgRJJabUmGbYBgOJKKvwEeHoPrUYJ
   J673H3acPqZmX2LtcNRnelZuKKbayoMYW+rhCliaXGrQmzaBonNfzJAhF
   Q==;
X-CSE-ConnectionGUID: 758or3kmSiGgfjgtzSA+Gw==
X-CSE-MsgGUID: 24n6nM4SSvqwCoMPqu/6vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="57004007"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="57004007"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 22:00:38 -0700
X-CSE-ConnectionGUID: iUkkT60fTPyP/+GVGnq5Qg==
X-CSE-MsgGUID: nhO+DwUzQQiLSdOlFShKMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="128213440"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 22:00:38 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 22:00:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 8 Apr 2025 22:00:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 22:00:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bO5LwiQdVg49fqB25vpmISolz4J0cGiCX92+ioKj+KuPuzoezYxtmNtgHmVBLzKwiUFQdDFK4KfLPcDjhe8V0KEMLlWDs1FX+PdtuUvM76pC6LtoNB5rO9TYcue2pYzS0yc9yH9LFoSRrcbGCYq/X1DL2+43KWBvlQsvdYlZfw4ZyZLGkmXYZbeyk6g9u7GiszCNdQcRtCCWXwKtMDJNHtwRkA9a3oDZ7XxXgaaQ/LQtz1xxc64UmpyMzTXhoDQDZdjWAou4QcoVcGljAQxYRwNcDWCwavE3kpZJLC8QjBlFPGA+fLJgkthuO5XQydX6KskNVbDWJjzteftUac5CqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBMmUBUOgquXPhn0bdjNDXNamb7Ueey+JORCsSpG2Yk=;
 b=dSFz10D1BRb4XaNmIa7CHIbQG7aH4bHcJ2KwnmpcNiPNw8UUmyWuH5XNbf4ql0ItjyagYSf4WetqJ+xsfWm9BnXqM+KTIljKQERQ2X50vsIDPP/bfvWUD1icr7G8IKW1D3pvleW997udc+182Qpl9hKT15F5QMRdSQtHuL8NlZFhac1inoptT4Z0lTWP4QsOh5u9DIPfyv4197OI1GmXrseLEmbtSrGMFuOr2TWlPc+fU5EgeB55itlDq6eGFiFyqoQjlvvzhAE1tw4VevTInvYGyDYFLjvZg51zk1+WqC7ufbMl02deEnbSoPnbEAtxKJuaxCZq0zLfXqFzxSPgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL4PR11MB8847.namprd11.prod.outlook.com (2603:10b6:208:5a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 05:00:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 05:00:00 +0000
Message-ID: <bba800dc-80eb-47d3-be29-e600f6527d77@intel.com>
Date: Tue, 8 Apr 2025 21:59:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/13] tools: ynl: don't use genlmsghdr in
 classic netlink
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-10-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250409000400.492371-10-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:303:b5::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL4PR11MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 79951d5a-ecc3-4db8-307e-08dd772361f4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlZlQTJCcXZDdFhRYmlKZzhpNEhyVEJYZUd5d1hiRmlPekhZUFRLOWxUYUsr?=
 =?utf-8?B?MzZ0UFdleFhzemI0ajA3NjVGYW5WRWpxSnpHQXZDSmttV0t3YitoaVRNNXhz?=
 =?utf-8?B?Kzk2cHNqN1NNdnpha0JQZjdOTjhURlVrNmhRY3RzRnpNY2x5TVFmN0lnU2RG?=
 =?utf-8?B?REs3UktZSEhtUERoL1YzWkhqOVVReVJVNThXY2twWDRXckNtbVF5L3MwcGNW?=
 =?utf-8?B?dG5JVzNJRmRjWHYrS1pZVkVHVkdjUUhkZ1g1T1JwMTREc0RkTmJQNW1tYUxL?=
 =?utf-8?B?alJxTHhLRFhDZkZHTCtQTGx3ZUVkL1NZYnEwN0FXRStPdzdOTldrcExIdDdR?=
 =?utf-8?B?YlVGak1IYVhqNzZkZEdZVGt4c3lEOUhlL2xleHF3d1pvbEJiL0cvWFBjeFBM?=
 =?utf-8?B?MjRDb0Nod2VLRG13OC9hQUpCUkF4ZFk4b2V2SzZFVjJDdGZnZWhSTWxObEtU?=
 =?utf-8?B?cVhZZzN3cDlVSkZmVVRjdm1OdkxLR0hXN2M5MmY4cjJ1R0M3RlZ3bmd2VHVT?=
 =?utf-8?B?QklES0lpd0dYVTdHSTJ0QXlyd2FDNU9YUTU2dzYvcUJCd1NZTHY2ZitLU2l1?=
 =?utf-8?B?S0FPR2ovcDJiWHVPTzVRcFNXeEpRa3Y2WVo3TjViaXdpK21ldmFjWEt0NCtY?=
 =?utf-8?B?ZzlPYTJMbDRTUzRCUWpHK2Z1R05ZWnEwL0pPMFhZcVYycUh1a1hLd3pub2g2?=
 =?utf-8?B?V2lhak9pamthc1RDaTdXek5ha001MkNLWm1PS2hmMHB1UmlkTTFhWVMwZ3Fq?=
 =?utf-8?B?RXRCYURvV0F5VjVEdlh3UEJaYzZnUGtiMHAyVytDdC92eDR1cGRhanNmTHZQ?=
 =?utf-8?B?aENZRzdlNmdJMjd0M3dVUE51R2p3UUx2QzVKOXIwQms0RFVEVzB4bDYzbE5X?=
 =?utf-8?B?ekREeVpRZjJrNlRDemw1dzQ3Q2twODBBTGxVS1VHWWtFbjc5TXZnNzZvUTNo?=
 =?utf-8?B?UWl0ZVQwSXBqNDNDbWdLeUVNSmk5VGsyb0dpU1hWd1hPOCtLbklsdElPS1dZ?=
 =?utf-8?B?Y3EzSFNJMmQ5aUVDQnVXVFpOUVo4Sm5mWEg2OFA5N095N0ZMU1V3bVRUQ3dZ?=
 =?utf-8?B?Z3lBSFZ5Si9LK3dYWFhDajgzbWlDNWNQbzRxZ0NzV2RrRFB2Vk1Kb3UrdnAx?=
 =?utf-8?B?bk10YlhlWU9KOCtRVUkrdTVHNzhneG41c21pVmcxQnVKVWtLUmRsMDh3ZWhV?=
 =?utf-8?B?eTJkWlI3Z3pWYWtEanpMYllBODdGeVZjYzd3OHJ2aVF3U0Y0ZWRLUUl5V2E0?=
 =?utf-8?B?SzQxT293aitFMDFKQnBVN2JFZjFQQnVTSVNRZkJ1QzZwajZjTWU0d0c5Z1ZE?=
 =?utf-8?B?WUxqT1BScmxKZFBOT1orTDI2UG5DRzg3aHAzUWpHVU10VzduUEk5V2Qyc2J4?=
 =?utf-8?B?d3drUXZUREQvWm1RQ0lMTCtmaXViUFNwOFNoMW93WXNzQThDQnZqZ1U0SlRq?=
 =?utf-8?B?enBnTDc4VWNjTjRWNnlMM0dGMHBYNGd4TzN4aG9XK05HeElWdDFDempxNUpE?=
 =?utf-8?B?bXNGWm5xbkNQbEUxN1dXVG9ZbDYvZi8rd1ZEWHYzYmsyOFVXQmJrOWVXNy9R?=
 =?utf-8?B?b2xBSUhHWXhuT3RPbW9FS3cvMEZBaWpDc1cydThaOUxFTmRjOGhHNDdNNlRk?=
 =?utf-8?B?bFJQUXNrbDRUejdQWk5lRVdvYWs5dWdrTGhDNy9LZ1o5N2F5ZjE4bmZmRDB1?=
 =?utf-8?B?TzR4cDJqY3BLZWdPak5Qb1hNK2tvbGNpRWhISWxIMEhCRmFNaEVTQUtGZStQ?=
 =?utf-8?B?WWZudjdIa0RmOHkwWE5NYXVySk4vMC82NmJFSFl4d2F0YTdNcThDd0hHQ1BN?=
 =?utf-8?B?K2pXdTNoRTZPb2tzR1RBNmdOKzVNYWg2cjFyY0FCbXNvMStIamNIR0lsM0pO?=
 =?utf-8?Q?vcfLZoQlWYvUj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3Z6TjNPRjdENmJzWnMra05GeHhDKzF4ZjFGTVB3ZjlzNnQ5NmRwYkZkUkxG?=
 =?utf-8?B?cDNKOW9xYUVkdHNpdVBJVVB0TSt3Vm1XOEtUUU9ReXpkV05KSWdad2h5Qkwv?=
 =?utf-8?B?YzMwdnJnN0tVTlJBL0ltY3diRVB1OWppWGdaSWEyaDBRN0FWWFF3VDlhRnNT?=
 =?utf-8?B?bEptZjJacjREYmZtWVJMYjBCY1U3SVdlVUNsazA4WEQ2R3RNUERhZlczVGJt?=
 =?utf-8?B?ZE5rR0tKTEkwekV4NWRrZVc4enFmM05rYTE1Y1NIcmhUTmo1enpib0hyWEFp?=
 =?utf-8?B?SEF1V0Z6eEpHQlV5N0hIZkNYZ1NYZWUxeUlSL0Zic3o1RW5FRm5sNHRYOWRu?=
 =?utf-8?B?S2JRTy9jTmtMVzUzM1U2TXFLSEpBdk16YVBzcWg4SysxRExiYktaYnJ1eFdq?=
 =?utf-8?B?djlXKzd5M2xXVk5XWU1jRUsxZ25IWGZjUmZ1TzBQOVMyRjRvUzRJM1BKamxJ?=
 =?utf-8?B?YWNpS1RpZHl6ZHN2S2cyd2hzbDB3WGJRS3prUzBPZXNUNzB2bjFiWHlWMGJ2?=
 =?utf-8?B?Y04vZXFMN3I3SW5HV3BIbktuNmhJQXFubDZBMTVxMlRaWkR0OHBZSytoekty?=
 =?utf-8?B?ZDdIZHFrQzhBVnhJb2hUL3EwdlVFWXlkSC9vYll1d3pidU9oazJ6WlNldnhl?=
 =?utf-8?B?MXBNYVExckttQm93aDloVjZJQlpLYUpjRjNaL1hkbXhTM0pmblc1NjdoRmND?=
 =?utf-8?B?TXpOcS9XeTArVDRIK2R1VEg0d2JLTDZ5OTN5anhxMWVlY2RQcEo0d29qL3VM?=
 =?utf-8?B?VVFxMEJYVENRK1hIclUrWE9xYStEZ200NzNCWUpGcFM4SEdkNDN5WnI1UC9S?=
 =?utf-8?B?bG1WQlQ3VGVuTWt0VVFzTXVycSttOG9hbmlvYTBzQ3pzdWNPMzVQWUxaZExY?=
 =?utf-8?B?ME5zcVM0UmFvRE9CdEd4TVFwK3BjdDE3d0piWUVUWThtbDAxYnY0SWpYcU93?=
 =?utf-8?B?MDBYdzRnZitOQTUzbjNHaVdVQVliMlpseS91dStDaXpWclIyUGZUK245ZGln?=
 =?utf-8?B?eTRYZzNlbCtRY2ZaZ1p1R1hETW5WMCtFQTFodE4zUEpmSkg2Y3VZSkxYbHVX?=
 =?utf-8?B?Q0FDVUFsaGdlTjVjdUFadVlKd1gvUUtqT3UzdWlDcVZra3VHRGxkNlRzNTFs?=
 =?utf-8?B?aHFLL1FiTFVsajFRb21HMExoYlBydnJMWlgxb3JLZTRKUWd5anU2Q3BTMWhK?=
 =?utf-8?B?RWNET0xZMnpMZE5IVjZoK05sNmUzaUxpYzZ6T2NGcmNDanduYjViRGRITjBh?=
 =?utf-8?B?Sno0VXRsMm0yRTBrd1BobEFHT2xJUXdDNVJzVWhIQVM3NlVjdSthTVdlSytw?=
 =?utf-8?B?Z3Vxa3RwMTltWitocHpxc2pYdE1QVWFEb1dUU3oxYXdWUjlwV2l5VW5VZndW?=
 =?utf-8?B?QjR5dGVFV2xHVVczenVmOExrOGdHbWhBS0NJamJkUEYwQkRzeHRJeUxZeElu?=
 =?utf-8?B?ODBCTnlIbFhYeEExeWRLb09wb0tLVEl2UExzUGR0T29tUlppMEhYRkhPY3VX?=
 =?utf-8?B?ZWVLWFh1NzFTVERtR3V2azAzQ3AyZGlXelNQcFJsM0FCRkhCbmhUWms3OGtL?=
 =?utf-8?B?NytHRnVlWm93emVPenpEL1hidTR2dU1ISW15TEd4SDl5MUF4NUlZQi9FSUVk?=
 =?utf-8?B?K0lxVGJPNTlDZ25yNjlWWjh1N0t0T3FFS2x3UGJ0dWdlNlNhZUdsdzczc05U?=
 =?utf-8?B?RUVMMk5rT1Awa29Oc1Mwd3ByNnBTRFpzNTJSQmtNQW1YaUN3RWNwVFZiNFJ5?=
 =?utf-8?B?MlRXVDMwa0ZtaWN4WTBOR0RnQnI5b2wzL05LMFhGRi9QOW1sVmlLS05LYUd4?=
 =?utf-8?B?R3Z6ZjFlaGIzalpOb1p6amp4VmphWUViVHFQMkRWK3Q1b0JuMkNBMVpWc1Rm?=
 =?utf-8?B?RzJDVlVHQ3J2YWZxb3VjVEN4dWg3NWdveUlXQ1RpZE9sSWdFdS9MbE1KZ0gw?=
 =?utf-8?B?T2lpdkdLM29MOCtySHNGSmszU3lwczJ3aXA5ck9uTkJaNmlIZTdvUWlyUzNM?=
 =?utf-8?B?RUhsLzd5RnBGMGRybkZUSUJoZEtEdUt4R0dSSVcxNkg4ZnhUZTdlKzFoYVlO?=
 =?utf-8?B?R3F1WFdBZEZaVEtmNUxCUy9zWVJMUmhFZjRibE1HVnFUWGJYTkp1WVhSOVRG?=
 =?utf-8?B?SGgySHlmUkk1cjQ1WEFuTzg2eE1YT3NwWE1yZTAwdSs0b0N1SWlPOVBPM2VZ?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79951d5a-ecc3-4db8-307e-08dd772361f4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:00:00.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97ek9ykxo0nr0mjBT21ADziyMeqBUh4Qg7oF4C7zcRpXqFlcHJSAngymKEOwSxcqDEcW+ZHfDAtV0we0AEmQWhl3HlsyNjkg2woYrA+heFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8847
X-OriginatorOrg: intel.com



On 4/8/2025 5:03 PM, Jakub Kicinski wrote:
> Make sure the codegen calls the right YNL lib helper to start
> the request based on family type. Classic netlink request must
> not include the genl header.
> 
> Conversely don't expect genl headers in the responses.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

