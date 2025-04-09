Return-Path: <netdev+bounces-180588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C34A81BF3
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 06:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B964885BE2
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E31D5AC6;
	Wed,  9 Apr 2025 04:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVi+OMoW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898EE259C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 04:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744174481; cv=fail; b=VF0DDnKRBC8WKUO+hN/bnT97E87nyRa/irzmaOYFZzD7Pqp3dzFjHACF59DTRh9kkSVLK9S+SRWUYeV7fxseWU7ym/WrXJoTLEtV0C0C7pjSTpV9yoYyJtKYQsNZ6ZEPlHIL8Ht75L3+CYs67GqTh7H11r8FxCOkWvqc1G8G62Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744174481; c=relaxed/simple;
	bh=IWkbADUx4+Lpq6Q6wnknXCGHZd71NHdVTnoLj/8Wurs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D1aqnTnZugYzPKULcjufTzYywI/2T53fpngX2vp0uR1I1dQzmrXbqRiRslr5aIDENjeXIMwyET+Vn60Vc/6VTYuT1ovoVD+Uvg0NDIKJMJYlawBVzb5GfmlkcBAE7n4Y/d0hgRzRDizb3YNDJ4KenDCxuFWJa6d+34MOeZK/ZhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVi+OMoW; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744174480; x=1775710480;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IWkbADUx4+Lpq6Q6wnknXCGHZd71NHdVTnoLj/8Wurs=;
  b=NVi+OMoWdOOelt8DRkqp5m336kGUP/y+b+Sk4AuV0hwvK42w8hWXs/J/
   +wSDsIweLu5f19WJ2wFjdDm5g4HA+0+EhMGpCA+CcKIwT30cYxdz8Czil
   c7MvuetAE9tIMYXRfdzTiip4rTW8xW5wDirQo4iDDEe7BuJLndQkff5XO
   nmqrHzTkmNFwTHUcTlQ5W6GZP82A/acSFlBQhhJ2Xz+SMuJ8b7GPttV0g
   wQv5+cLoUeZY2npgIqRXCNC1MnYMbPBFrNwbVpJH51c2jASZ3dzU2/5pz
   Oyg3RLsHgdX2piEN02kH4dVEE6olCbeSt6sjcNwl6eyzURa1xH2QvNABk
   Q==;
X-CSE-ConnectionGUID: cD9xoo3JSGycby/2TorYkw==
X-CSE-MsgGUID: MDnx3SBRTn6yqDUt5zIAuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49425821"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="49425821"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:54:38 -0700
X-CSE-ConnectionGUID: 18+PujAoQxqAxnuPfNhNww==
X-CSE-MsgGUID: t8U77HBwSLOfzGivVT4rlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="165701138"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 21:54:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 21:54:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 21:54:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 21:54:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcdYjDrSoc38RKMYCk749tsivez96T4E1tRQMqbddZCpoHmIDGQohvng0nEEddP5/FN1HPROoP5OIbRAnlsfx/Xp5sEmO8doI3a73SdKJk9hc2HPQ855E8c7cRamS2nZPg3i4F/tLZgKDKep3Hsgyti9hVS6Pwgwev4TVRcDmKxknRZ7WI5zUWzEftyXoZM+yZ4jIOuBSlBnSwyze5NGM12YoEzSIm90V9OwyR7ghhrqjLDAyxTspBbDFpyB8Oa8DLbGY4M5qdyTgO5MX1TGbZ45DgE+2/x1I89qg6daKFJtmQJZiu7p0ZCRRlmCreOkr18PDgIfESgEJ1KJ79dQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3P8+T9GD/2BWqyj78/rHEQOGaNFvQVlW5IP+0mDh64=;
 b=oGZLfyMGGvZM+jDua+Yl/M4oKqMr/sLKsV7dUS+9S+lsC+6MD6Rwm5BGGi9yfDZl9kNgYHq10+lXp+4X1njWHaLRm8lIwbXsMLmovEkZt88epB9SfLnS5DNl/1Ijs3d5wWt0GoGj2d+ndXkerCBEcAqe+kCceRcDK2gn3hQj5J4X5ikIOn+tDmV4mP4uQGhVjjO+ZSJiBipG4PuHzADO2OYCdmUQeLNbwT95tV50rQKp/3vkRPHAgnD9+NJLmOwGA1Tl1+BczUt9kbmiA+BbwT2ZDKAy2jn3FQ2X1kGkObNBw3YV72B6z65BDgetOUkaTdtuE/zYjYw88/xjkiy8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL4PR11MB8847.namprd11.prod.outlook.com (2603:10b6:208:5a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 04:54:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 04:54:33 +0000
Message-ID: <34cf7076-1928-4594-aa8c-af7cb6a3de5a@intel.com>
Date: Tue, 8 Apr 2025 21:54:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/13] netlink: specs: rt-route: add C naming
 info
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-7-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250409000400.492371-7-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0325.namprd04.prod.outlook.com
 (2603:10b6:303:82::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL4PR11MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3bd819-a736-48f5-70be-08dd77229e95
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2RhSXhaUWtiem13T3J6V1hnWkd4STNqYVNueDMyYnlTaFZQTTlGQjFFeW9M?=
 =?utf-8?B?ODc2T041cFRaSkx0UmJ1SEZTK3M2YjZpeUVxbjB6V0JhUjNHY1BWNDRuaHBv?=
 =?utf-8?B?ZnpmUTFBazdGVzlDMzhFUUdXL00vYjFYQ3JQaForakk4WkNzR0E4cXhNU0JZ?=
 =?utf-8?B?WkRRSnM0M25wZ2RFMVA1Q09waDBQbVFrTUJsZ1pNeUx6K2JPYVdGVjRDMDNq?=
 =?utf-8?B?Tmg0dEV2Y3NTcnJoUnh3YUFTQThmZ1N5VTdtVVgyUmxVeHV1NVY5OUViREJG?=
 =?utf-8?B?dkhmQmwySFExVE5jWkFhSVpabGZIZDdRM2JIWUhlU1ZndTd3MXUrQnRFNFZl?=
 =?utf-8?B?bUtOSFlpbmlXa0hZOWhoQmE0bktKZmg1bXpqK2EzR08vSzQ1TU5yYUxjNWRh?=
 =?utf-8?B?KzFyQVhQeVBsTlptSmNwS3V5T0tOdDZabWg0MktreTlpOHYxcjUzMHllWFpw?=
 =?utf-8?B?anl2aFBwUnljQjllR2pxeDhvdlRuQzR4dUZzYWlmOUFCcWxDc0ZENmR0c29U?=
 =?utf-8?B?aEpPOXdpUEZiVWdab0lURUFuYUpRTlpmTEtDbXJ2MktUbkRkV2duczNselVU?=
 =?utf-8?B?aWg5aXpPMHl2eVdLempzdnA5MVRSQXRBeThnWU1XMHJkYUp5YTJrdFR6TS84?=
 =?utf-8?B?Mmxkdm5EL3FFWTFVNVgwRDRZM05sM3RKbnl2NUJhS0dpREpVZjgvUlFQSGJG?=
 =?utf-8?B?eGdIcisxcERXTi9BaUFMeENnb01KenlMYm82cXpNc1RMWnhlUkg0ZW1BSFFj?=
 =?utf-8?B?MTNPdkg5TndUc0pRTGlRcWdPMjZNYU90a2lIVC9vSm9jdTVtbEtzbTBDR0lj?=
 =?utf-8?B?eExyRUROZkw5Slg4NlQrVW5wMGhYRkhvN1lPUnkrbnBvNFFZSXJSd25iUjcz?=
 =?utf-8?B?c2RNVWVXcFZvdTdrL01NL1RGY0x4ci9jSzNEUnJqTW1sc25wcVc1NFNoSjRl?=
 =?utf-8?B?VmdLcGUxMHdOWUNNOVVpeXNNVHE5V1ZMNEV6UVltaDBNY2ZxTlRML0ExaHZP?=
 =?utf-8?B?bWhGaWpSZ3I2QUtFV3BoWjBiSFFpL2oydFhLenNkNUwzVFZzenhiVm14YlNC?=
 =?utf-8?B?WlBJOHVrU0JwRFBOb2JMQU80OEdjcVhnMzVMUS9PcktIcUx2dkhMbjZiTDNi?=
 =?utf-8?B?V1A3UHdVN3RmaVNSRTdMMG1uR2VzVVJkbjN0eThSQzljLzZyKy9ZK1ZkMy9N?=
 =?utf-8?B?YnEycmhlMnhmTCtkc3QybS9iL3ltekI5NWR1bURkeVRmNm9MNEhjU0NBSmE2?=
 =?utf-8?B?bjJVRmFXRE5tK3BEcGZyVzV1b1h4aWZFS28zSWFhc0ljOW9UMWVEMUxZNmRz?=
 =?utf-8?B?LzJLSjNQckp3NWp4N0RnQm1LalhFSFZZb0FvY1paQ2U2dEs4aG4rTGNQUU45?=
 =?utf-8?B?MGFGV1plMU5XQW1YUFpGU2JIRHF6ZklOczVRR2w3ZVEzaEJMOFc3OUJ5Qldk?=
 =?utf-8?B?WFlnSkpPOXNuV0N0bnhXc0Qvb0FiYVhpM3pBYzh3UnlHRUZBS3Z6b0VQTUFh?=
 =?utf-8?B?dE1xOEU2YkdyRmR5c21rdWsvYUk4UmNyWkc3c2V4QmpDenovdTlhZGF1aGxj?=
 =?utf-8?B?d1VSU0RBcVNrZ01ZSTNONXBDenNzcUJNaVBDUnE5UjR0SytXQytUZEpPVFJN?=
 =?utf-8?B?OVF4RmFoem13Rm1PQU9Qeko4dHNydjdNb29aclFUZURuamhtUFdEbVZ3NURr?=
 =?utf-8?B?bTJpOXVNWEFSSy9VMExGU2FnWFdsN1dtbDdoS3FWWVIyMktJMkt3bG1nRSt6?=
 =?utf-8?B?cWdpQkVVOGx1SVU4SklGOFg5VUFjcUFsTHZZeFd5K1VrYmhDQUk0UkY3MTdw?=
 =?utf-8?B?UTQvektFRDJRbktmV0ZCVEw0UDBwMEpob3JyZGUwTDhrYjMzYjBmLzlRMzBp?=
 =?utf-8?Q?5WvlwGNibNnqj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clA4NWIwV1U5c25RM3BMVTBXK0pNRmpqUmE5cVNEKzJndyt4OEFRd05XMVVh?=
 =?utf-8?B?b0l5V041WThGU1ZWTHUzSE9BWHN4eHBtcllzT1JyVjdQUFhKMVNQVGJYYUhn?=
 =?utf-8?B?TFJZZzI0U29OenQ4YTRXdDBaOWlPZ2U4MGRyR1dXTnN3cXJ2ZS9pMW51dFdp?=
 =?utf-8?B?aEFHeEJBeEFoNXR1T3MvK3R4OHFQRVpmR096bkxTU1BkdGlFSVRHY21KSStZ?=
 =?utf-8?B?TXVxK0JzQzdkb0VjTzQvakxzcDVqbkswZmFUSDhjMXpUcllEVDljdEFhTDBG?=
 =?utf-8?B?R3pHaFJoczU5bVJHaG5PeXE2MTRxOUhib2QyQ2Vpc2UwYXh2WEZiU0ZSNFNZ?=
 =?utf-8?B?NjFId3BsbTVNR09IQXVxOXZmS1VWSDBFY0NJK3dmZjg1VWQ3Q3AxWXF0RWRQ?=
 =?utf-8?B?YlRGRVFzaDJna3ZpU0hxS1JKY3dIVStoQ01obzJETWZMS1pqRFNWWWJvaFhZ?=
 =?utf-8?B?YXNlVTZrRTA4ald6ZUxPOEpqdDA5aG8yZU9IZ3VEaTJzWVNtMVNYMW92QndV?=
 =?utf-8?B?cGNCSGFiTTBYUWs0dFBncXhLRGFGQWtTTWpNejgyY3F5VTgvT3dkcFQrQzgw?=
 =?utf-8?B?YWwrN3AxclJhaENNeVNrSmpFbjVaRHBwcWZuNzBKSXl1cU9WQ2M1aWxZNUZo?=
 =?utf-8?B?ZzQ2WVBIRVlBYXBOMWNIT3pGL0hVSlFNdVhSMW04UFdNMXFwNTFXN0cxQW1k?=
 =?utf-8?B?ZDNrdUV2M24yckFsMjhKZnhWb3AzMGhGa3pINllQOXN5cU9sN2xIa0x6MmhF?=
 =?utf-8?B?ek8xT04yS0hLSlJLMURKc2poYXlBQ2xaQ1RZbEJjSDF4TWw5RDNUaFdqeEhv?=
 =?utf-8?B?TVdoMS9IaVA4N1NUZWVFYlg5Z1E0R3NsdnpkdEFLUk5VYlZFTk9UaUNEYlVZ?=
 =?utf-8?B?SDhtQitzeE1MbEVld1RvOWhDWWdxcExPSjdPU2djWU44NkFLQUJLZDhMb09Y?=
 =?utf-8?B?dTE1REU4b3c1M3hPUnhoWmpHUUVTOTRqTXJBUTBWRzBVbkl6LzZBTWkxSkQy?=
 =?utf-8?B?eVpxYU5ZYWlPN0EwdDRTbWY3eURmSVl0akZsU2NXNzhGTnZxQ2FEcTd6Ym5I?=
 =?utf-8?B?RDR4OS84QUovMXpNTTBrdjdnZEFxZkwwMjV5M05OWlFFSzhHWUEvNEpHRThR?=
 =?utf-8?B?NWxVRTYxd1MyWWJIOTRlZUxvUlZ1TDR0T0NJelZjcFJDL2psVjlQZmRCL0xz?=
 =?utf-8?B?dy96V2pycHU0VGd4L3o5SERVZ0dPMjZGWTBJQVByVXg0RHFabGZGYTRKVS9L?=
 =?utf-8?B?VHBGc2hMaEVYYmY2L2g0bUp5MlEzODh0STRZaS96OXVwbC82cUNlcjZ0S0M2?=
 =?utf-8?B?cTFSeGM1bGhlVXNsbVpLc2dkaU9NRVRNcDJUbWZOSlZGMUlYQ1UrckJPRVNQ?=
 =?utf-8?B?bmRMdjBEdFdzS3VTVkg3WGt4L0Z0MmJqU1grTnlkVk9ORG9HV08wZmVhZFVF?=
 =?utf-8?B?bWtUV3JkVkxuck1vZERKdVVWTkt4RzBHYnpSMExrS2h4d3JteEJ3OG5ZbGE3?=
 =?utf-8?B?cE1kQ0MzSlErVlBISlR2RlNacitMdVdKalhyd0dxNTRRTUZoc0VVLzVRZTFW?=
 =?utf-8?B?ekNqdjFwOUJpZFloY2ZLT2hZNGYyTVkzMjhsaXVQOVdsR012TDk2dlEzMGhq?=
 =?utf-8?B?Qzc2MTVaeXpDaWE3b1cyWmx5QTkzd2lVR1Bkd24yRW5QenV0MmNYZ1ZxZkly?=
 =?utf-8?B?Sm8wVFFOWHlrN1hPMlQyUDBjSmV0SjRPQUk3TTdTZHBjRzdxdzJ2VW5ZWlNR?=
 =?utf-8?B?ZlZ1QTFvMmgzOW9lTVZ2TSs2Wjk5VHFHdjVYZXdlRElkUC9hbmdkdFRJQnhs?=
 =?utf-8?B?M0hvcW1qczlCeldCRzRRT2t1NjAxYXpXdkhxSHg4Qk0rMnNJTDhwWnZaQzFN?=
 =?utf-8?B?MXJTYWNOaXhUc05VUngrSVNMUEJ3b3MzS3BsL3pmVXg5OFd0aTArMlhsR0Fm?=
 =?utf-8?B?R04wL2c2dldKTDQzUk81TzJjL1hjdlJkaEYyWWR5T25QamptNmlJMGNFVW5L?=
 =?utf-8?B?NW5MejNibHZCSXFQcW9OcE5rSTNvSjhiZXNaaVFtempsL3VlSE00R3Q1SGJ2?=
 =?utf-8?B?UkpoWWJnS1hLeFF1aCtRTUVZeTZGSHlpUHFNaEdKbWJYT2FUMytOaWdYSWlp?=
 =?utf-8?B?MC9Qc1FXOEJtMDlIcjBsc29VblRQMnNUN1RyVmdJOTJnVkgyT1BRbU1aeHBD?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3bd819-a736-48f5-70be-08dd77229e95
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 04:54:33.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jnx6vZkFrelqGDPwNNwGt4sqPo/D0jLYUN8/BclzHOHoFV36vQcRQysZS+lQrVqKy6rKiTqL4CKaTUb0Zc+qHykt9X4UkqsQkhpEaHup2TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8847
X-OriginatorOrg: intel.com



On 4/8/2025 5:03 PM, Jakub Kicinski wrote:
> Add properties needed for C codegen to match names with uAPI headers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

