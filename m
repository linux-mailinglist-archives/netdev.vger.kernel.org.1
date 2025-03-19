Return-Path: <netdev+bounces-176031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BCBA6869F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166823A9601
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4682505CD;
	Wed, 19 Mar 2025 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bs8JIQry"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8224E4C6
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372532; cv=fail; b=VmLu5Se9PGLMVnOmXlb3fqfyFHvsZakv9si5BSqnjpPYpfMBbac4j4ubx6vyw/PhrBNEwCEMQ1F/0ttpP7lUxh4zL04Vs5jAhFDlPyDBPHxwbODdSsplTmF27wIjNUH3+EjSFRCvnvJU1Xs/aPcvy6gxoHdoY+6+tw8rSGqct+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372532; c=relaxed/simple;
	bh=y9N0/wGbD18tjykgNe5nLqmM+2EO0lqdA2II5Z+Q0gg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FueiaQM7OyIy5PQbjRhExyU3gBp/DxYOfLoDdABSYKn1JrXifcmkdYcVopx4zF4A7Zs3HYVZMX3Z6AtArO2xWbyQ3mja1DTw0fIz6wo2R9XpaEmlWYJft75v8gptiX6hRhcBeIEM30DLpVq7JfGasAtuv+RMc9O/xxEFMOd7Bg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bs8JIQry; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742372530; x=1773908530;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y9N0/wGbD18tjykgNe5nLqmM+2EO0lqdA2II5Z+Q0gg=;
  b=Bs8JIQryGjcAgr3gVWjIt0y233mumXCstePgbvvwBVNH2kscPqPPljee
   vr5z8fQ4z6cGmru1m9v6f0hk2wUAlAfXZFYGka+UKjPMqdQehUnlrhCTb
   htY22buOauzquRQ1zmmeytAY83DNwJHbsWArJwDOVRKRww/h7Q97DqVBW
   8VhCKwWy27zIELH0Yr+I6PI0muCuRKduPCw0zIBZXDABsgIzE8BJ8NY2M
   muvlq+jwdnd8kTiEpXvYah5FGSpITmIFx7/y5LNqXWeNvIOW2/J9Vocaa
   PJJm/pcpu/kMI8akEwEFWcStdzCf17/6QOGsJ+P/p3lufz7MOfevhueeW
   w==;
X-CSE-ConnectionGUID: 612eGGymTD2htOWS9IpCnA==
X-CSE-MsgGUID: VMt8TiAvRlmpVn2Hvwh/KQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="53762845"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="53762845"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 01:22:09 -0700
X-CSE-ConnectionGUID: 2ujgwtsoSByUooQcm7TH1A==
X-CSE-MsgGUID: pzMqzMDSQtqI6cCLx6oJrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="159666109"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 01:22:07 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Mar 2025 01:22:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Mar 2025 01:22:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 01:22:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeIFf8/OoNyBmD9A8j0C/h6oiIWfbvGE7YPZ81XhsT27VifX2BpcVl3OcXW21qCiwRBJimvD79VlWF5SbakXaTND8tLV0HRZBf1ScjPxb+QNbkiFvQXJv7ashTB9hrGUW4TVCx/iTm+6z/vnTnapiaAiN1wAVQmmlQXw7CjdCou1PZJOvVA7ul14ZODIfZMo3CPRyK+unQkK9YueO2A5YaQjOzm381zPyWiPvDlvW94H9s9ipM9vYBM8zGZQl3BugEfJgjOCseAOBxIz+m/OpUK2mL4/xvlWjbA5e3rX/Ljuv+s3LdT0taf262jTrfw4wsH/GspouFSfoTOFtUEW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9fIN65K6Xc8DkvBxd667B1dclByanMtII0VeNRiVZs=;
 b=Low1XrlKBYPRww+eM2WJUOlefxLJr7/LENmUKt58Q55erh4IQzwcfUbxxlRdaLDu9TkWoTFvy5GX37EcBaS5GEoAT82xvKCZjZXX/1DK7L7JlVIQdo5u8PAJy1b8lavP05gXJhZfWKETwLDuThLbEqAGp7KbBsmNsuxcMID/bfsmRiCzkzF15WUuVr2P763HGPMkuY5E6aDKidwDz/DJXp8xdIXACnBk5q379QnHp1+DP8edzIZfEoIzb9M0hYluB2GzoMmSYNEM+kbqHBCRKTpRb3mELB86rRkw9qTTQQvClqK4uVTQb8Lo3eY+1zaX53noBb3ujQWh9P3U0AQU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA0PR11MB4685.namprd11.prod.outlook.com (2603:10b6:806:9e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 08:22:00 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 08:22:00 +0000
Message-ID: <3be26dca-3230-4fd6-8421-652f95c72163@intel.com>
Date: Wed, 19 Mar 2025 09:21:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFC 2/3] net/mlx5: Introduce shared devlink
 instance for PFs on same chip
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Jiri Pirko
	<jiri@resnulli.us>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Dumazet, Eric" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "dakr@kernel.org" <dakr@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "cratiu@nvidia.com" <cratiu@nvidia.com>,
	"Knitter, Konrad" <konrad.knitter@intel.com>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>
References: <20250318124706.94156-1-jiri@resnulli.us>
 <20250318124706.94156-3-jiri@resnulli.us>
 <CO1PR11MB5089BDFAF1B498FE9FDDA3FCD6DE2@CO1PR11MB5089.namprd11.prod.outlook.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CO1PR11MB5089BDFAF1B498FE9FDDA3FCD6DE2@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::14) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA0PR11MB4685:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e60e78-9ce0-47fe-0bc3-08dd66bf1ee1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1BMb3VhM1hGY01RVG5iYUhzU21aWVBkT1ZFSFFueUxwc1Uxc25zaXVZLy90?=
 =?utf-8?B?SHhyOWRxaWlTVTc4czlFSmhFSjhvcDFReWVjeHE3U3FsYnFtZXh4elUrMThK?=
 =?utf-8?B?UGszNWU5d0lFVWxGcWxVVHJTalVVZVU1Z2k2WGluNzRxVmVoOHlHWWNNQThS?=
 =?utf-8?B?c1hRNXVUMUpaQ1NPRlNkcklBZ1BISWFiYmFCMnk1QlExOUxwaUlLeGQ3Tld5?=
 =?utf-8?B?U2NpblFwdWRDSzdOUzNSWHM5MG04Yks0UVhINEw0dDFZSmxXWUlXZG5PdElX?=
 =?utf-8?B?S1pQazgxWTk4WWJNejBMOGxVWVNtcE5WSHQ0TnB6bzRzZDg2dkxXdjBpa0ln?=
 =?utf-8?B?OFd6dmIwLzJ1aUN3QUtPMXNWT2NFM0E3cFFJdy81bk51clpFMVZJTlpnZk5w?=
 =?utf-8?B?bGYxVFZXTDVCOWNxbWlrZjlKZytxdUpwdmExSGxsWXFhQkI0c2dKOWtGZlNF?=
 =?utf-8?B?T1dzeUp6K2Q0RXFyZ1BvT0lqVmNqaVdaN0hSbjRrYTZXd0JvVlFKOWxYbUNx?=
 =?utf-8?B?RkFRamh3SWhXK1FSUGwrMlhIQ1JVeGRGclVkejRxNElHb0xFZnF4RWtwUERa?=
 =?utf-8?B?VWE5TzFXVzI1YlUrUTJRRWNwYWd0OENpNnFPUDNZMHBmRE5pcFdRTnJ0cU42?=
 =?utf-8?B?QXZiT2UyZFgyb0x4eHNKcW9RMjFuU3ZLTDhvMlorRkthYVhlWEQwVk9DdnAx?=
 =?utf-8?B?dDFqejhlR1ljRmhVcm84V1NXZlFQZzJvWlRtek9XSTlRQ0NmbTRrUG1NdXlD?=
 =?utf-8?B?bnZWREVJUEtxNlFzWUFIWnhIWmp3eFFmSmFXUzc2eVdOdGlZaUZzVktRYnZ5?=
 =?utf-8?B?dlBxaElJVW1ZUyttZHJoYzR3aXlGMHA5WDc4cHp6YTR0QmpKYUlTdVpOTjNW?=
 =?utf-8?B?TUlrWDRCNHI4MkZkTHJLbmtYaUtRakVhZktvdzFHWHdlbWtROW5EbWZwaDRC?=
 =?utf-8?B?SXQvWU9yMXd3Y3hHN2R5aVJwd1B0ZHZ4YTNQa0RLanVOWjJDTW9HR1BwdW9y?=
 =?utf-8?B?ejVoVXF0TFYvT0p2K0ZmTmZVbXRRcmIyUlRzY1RsSEt1VkhGTTdXTDNXUUYv?=
 =?utf-8?B?TVNMMVZHNUk4ZHV3d2xzQVV5NnA5ZXR6MHZtN3BFbU5ZWGhKRU5DVnJOMEFP?=
 =?utf-8?B?dXprak4wSTVEMXRSZm1IY3RmS2tDKzc4eDdYQjRkVFZwdzBsNE51SHJpZEQy?=
 =?utf-8?B?amd2eHlHcDRNYmdCMEp6NnlOc1V1VXk0STd0MlNiZnRIZE1tOHZqWlZrN25L?=
 =?utf-8?B?WS9ldzZmYXZpaFBodktVaGJhcDJQMDJaTDh6cCttQ1A5elF2Z3N2QnFPSk43?=
 =?utf-8?B?bkZHVklRZzFqZ2p5Nnk5a1cySVdYZGVUWlZkUkNob3B2cEZiTHVsQ0JBcDZ0?=
 =?utf-8?B?VU5XcVA2ZlAvTk9DOVBJT08wVlNYNjA2TDF5SmV4M3JXMG1PYnAxWkVQTnow?=
 =?utf-8?B?eldQS1VPY0c2aUpTNFEzTzUrRWRLN1lkcDNtRkRTeDMzdkpaMzlDbmZrQndO?=
 =?utf-8?B?c2NtcndZRTlzNXJwUVpzWFY4WFh2am8rQ3dIcytHazFoNk53azJWQWtqa0Fi?=
 =?utf-8?B?cERmWUFiWjI4Rm9ocGlOZHFuOXNVWmo4SzU5aUcyOHg0WmxiVktvbFhGYXNE?=
 =?utf-8?B?bjRPOUJFejkzZXRXaGIzRld1aS9vaEwrM0cweUovVDZqZXBXUHpwSkNIZU05?=
 =?utf-8?B?L0dDOG5pblFSWHdVZWNDOWpSUlVYM080M1NCNmUza3BUZ1Q3NjVLcCtONUZ2?=
 =?utf-8?B?Y2J1WHBoZTJSTmlHUTkrZllpTklheGNzNlhQTm9WRWp5dXN0STNGQWVVNTNn?=
 =?utf-8?B?emlzVGpZdW1MejRveG1tUnFMT2w5K1VMRFJWUkNRenJ1eHVPek8xOWNvWVVy?=
 =?utf-8?Q?84mhhdbXxRPkj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWlnNlhzQkMxdWhhbjlRZnpuNit2cEFLcmtpNjdsYTNpWGJYc21lalQ2S0h2?=
 =?utf-8?B?Q1hEVHFYajhpclpXQXZ1WDU3TFNNdk5DZTREUzRIdFB1UVFDK0xBYmtVL1dJ?=
 =?utf-8?B?MDJIYnBrSlVOdnJvNVhHQlBBU2lET3g3b1NuaVNVYi9oRHF2dytlWmYvTFhU?=
 =?utf-8?B?eElaYlVLZ0ZTTURNRStLUVhNVTIySEU2dGFQMVdvK2NrYm9vVDlrN21Za3ZJ?=
 =?utf-8?B?cjNoSngyYkh3QnhJajczS3J2MlpQVDhERC80UkxuK1EzS1JpVjBMWk4yMEFK?=
 =?utf-8?B?Nk5IMFlMcVpSa3lxMklJc2xNMWlaQk5yS1dpQVV0dGFPMGpMMi9kWHpsSGRI?=
 =?utf-8?B?RkFTZ2d6SkdmMzI4K3cwYklQYnU1Ym9lN3JOb1Vvb1IxRU1TNzBDdU90ekxs?=
 =?utf-8?B?VEpDUkpzbG5pT2RwZXRPVTdIK2w4SUw5MUxoQVNLdUQ0Z2tuWmt5bUI3T016?=
 =?utf-8?B?YjI1aHcwTTltMnprcEhnVDR0MXF3ci8zTTEzbkc5UnBEaFg1ekVQQXdrRThK?=
 =?utf-8?B?K3N3TGhDMUxsS2lyTzREQ2k5dXdYZnl0a0JhOGVwck81RnhZUnhMYVFuOGR5?=
 =?utf-8?B?QlhjcHNuOVZ1a3NYdFlHWFZVbW85Smc3NlZnUjlTN3BTTHFQRXArU2hQK0Nr?=
 =?utf-8?B?WFFpZ0M0ak0yMkFOSGF0RWV6RTFCdFVMMkF1TURzNXhOR0hTblltYjZJQkc1?=
 =?utf-8?B?STExUDAySDY3dDBjWWpzSVFCeHJ4cmJLWkdpdGdISUFxTHdnV2U1Q0NNaFpj?=
 =?utf-8?B?Qy9LY2psSWF1UGl3dUFJUGVtRzRZOUkwMTEzbWNKUmc5cTA3cXk3SXRpeWhE?=
 =?utf-8?B?dVNWL1Q3WXFORmxqcDFORDVoZ3M3dDNJUkJXbzBqUnFtSmhvZzVhcTRhckEz?=
 =?utf-8?B?SWF1TFBjRE5YTk4wUkJ2MkkwdGV4TVVhak5UU09PZnkybjVOaGhNSm9YUWpX?=
 =?utf-8?B?elg5RGdsaEdUbmpKYTJjTmhPcnU2LzU1dDZ2dVJHazlxWTM3WWFLZWRCOHF0?=
 =?utf-8?B?Mzk2TmhoeWIrekpmVEYxSWxFSUJkSGZUb2ZUb1VPcVEzbzUxUGFucTB6L0lt?=
 =?utf-8?B?TWdHbDFvV0RMdndhTm9aNVp6Qm9kVWQwTUFEVkRpckgyR1RpRkVXTUJqT1JR?=
 =?utf-8?B?VDBBNmdNb09acFZnYTR3a3FZWTdtM3lIQmpDNnpJWU9jK3BOMU1GVSt1RnlC?=
 =?utf-8?B?ZUtLTk9WZXNzb3ZVK3BZUTB6eW1sNXVBUUNNSDMwTjRaMGgvWEYyWjZBMXgv?=
 =?utf-8?B?elQ5cXRPNkxhQTRxTFRjM2gzY0sxemFza3Rad0NpcDBrdUNJU1E4NnQ1L1lN?=
 =?utf-8?B?UVJKS0hPbGgrbnhObkdoRXZya2Y3alVianUxY1VzOEVxYlYyU09wWDhQT0pP?=
 =?utf-8?B?QWUxLzRCeWI2VUFjWXFkUkYxTGdIOUg4Ky9SeGgvaThRTmNkOXhBMjFTWVNy?=
 =?utf-8?B?Y1NiaUEvTUx0OFJZVlJBcHpVRGNaS3JPUzdQSzltKyt6VTVNZ09DUWJSaWxZ?=
 =?utf-8?B?dXVPaEtKa2lReWJya1piOW1wNVlpaXM0Z2x0MkVMSUtoZSswZmdtNGwxTVJ5?=
 =?utf-8?B?eHpmeFduR1l3bEVmV3dzTCt2KzNnRFdxL21WOTd1UTUzV3JRTVBnNUh3THQv?=
 =?utf-8?B?M0NwQ1VjV0M5Mmkxb2RKblNGYUhINFVlQlNLeFZUd2dNYkE3amhVWFE5di93?=
 =?utf-8?B?ZDBwT2M4Y3J1dVZVU1preEdlaldCcXhFZ1JZeHpyNGdWVitxSFdueWZDdG53?=
 =?utf-8?B?QXZXcHk2R2QxR2N2ck5SZHVYMWdXOFh6QWpFek9WWm5DSVJ1dGM2SFcrcHZG?=
 =?utf-8?B?YnBROXAwditrb1NjN1ZMRUtNQkFkM2grTUpsSFRyTkd4djFKTjdVanZvOXFW?=
 =?utf-8?B?azZCYStLVjhHcVQ4TGZRd2ZtRzQ4cmErR2hJNHBJbEFnS2Z3UFpQUUU2YllD?=
 =?utf-8?B?RW0raDJrV1JxK3J4bURaVlJNV0lIMGpKMkN6VEtyL2JsbnpIV0c1RFpJNVFG?=
 =?utf-8?B?ZkcrL1pMZlBEVzdNcTB0QnhIYkVmK3hkZVFlZlYxN1FKNktKVEpDTTErQ2ll?=
 =?utf-8?B?OSswVVU4RjRFUFhOb3RKUEFYdnJTSW1EYnhWOG1BSXNBdVN6b1ZZWnAydWRr?=
 =?utf-8?B?bUh6akFnc1NUNFR0WGFOL29WUUFLclVRUDBDcWtzamFCVTVqOTd1bWF5eHc5?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e60e78-9ce0-47fe-0bc3-08dd66bf1ee1
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 08:22:00.1397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Afq4ZLMKn7QF4fSTUgBaSOpDAJjMz3VB3EP8XaynJ4Vz9I0KhDxzItlsabkN7GK6p13ImZmLpvdDdlb4XlgTsNHhoNORzQBvWF3jzBZFgYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4685
X-OriginatorOrg: intel.com

On 3/18/25 23:05, Keller, Jacob E wrote:
> 
> 
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>

>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>> @@ -0,0 +1,150 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
>> +
>> +#include <linux/device/faux.h>
>> +#include <linux/mlx5/driver.h>
>> +#include <linux/mlx5/vport.h>
>> +
>> +#include "sh_devlink.h"
>> +
>> +static LIST_HEAD(shd_list);
>> +static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */

I essentially agree that faux_device could be used as-is, without any
devlink changes, works for me.
That does not remove the need to invent the name at some point ;)

we have resolved this in similar manner, that's fine, given my
understanding that you cannot let faux to dispatch for you, like:
faux_get_instance(serial_number_equivalent)

>> +
>> +/* This structure represents a shared devlink instance,
>> + * there is one created for PF group of the same chip.
>> + */
>> +struct mlx5_shd {
>> +	/* Node in shd list */
>> +	struct list_head list;
>> +	/* Serial number of the chip */
>> +	const char *sn;
>> +	/* List of per-PF dev instances. */
>> +	struct list_head dev_list;
>> +	/* Related faux device */
>> +	struct faux_device *faux_dev;
>> +};
>> +
> 
> For ice, the equivalent of this would essentially replace ice_adapter I imagine.

or "ice_adapter will be the ice equivalent"

> 
>> +static const struct devlink_ops mlx5_shd_ops = {

please double check if there is no crash for:
$ devlink dev info the/faux/thing

>> +};
>> +
>> +static int mlx5_shd_faux_probe(struct faux_device *faux_dev)
>> +{
>> +	struct devlink *devlink;
>> +	struct mlx5_shd *shd;
>> +
>> +	devlink = devlink_alloc(&mlx5_shd_ops, sizeof(struct mlx5_shd),

sizeof(*shd)

I like that you reuse devlink_alloc(), with allocation of priv data,
that suits also our needs

>> &faux_dev->dev);
>> +	if (!devlink)
>> +		return -ENOMEM;
>> +	shd = devlink_priv(devlink);
>> +	faux_device_set_drvdata(faux_dev, shd);
>> +
>> +	devl_lock(devlink);
>> +	devl_register(devlink);
>> +	devl_unlock(devlink);
>> +	return 0;
>> +}

[...]

>> +int mlx5_shd_init(struct mlx5_core_dev *dev)
>> +{
>> +	u8 *vpd_data __free(kfree) = NULL;

so bad that netdev mainainers discourage __free() :(
perhaps I should propose higher abstraction wrapper for it
on April 1st

>> +	struct pci_dev *pdev = dev->pdev;
>> +	unsigned int vpd_size, kw_len;
>> +	struct mlx5_shd *shd;
>> +	const char *sn;

I would extract name retrieval, perhaps mlx5_shd_get_name()?

>> +	char *end;
>> +	int start;
>> +	int err;
>> +
>> +	if (!mlx5_core_is_pf(dev))
>> +		return 0;
>> +
>> +	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
>> +	if (IS_ERR(vpd_data)) {
>> +		err = PTR_ERR(vpd_data);
>> +		return err == -ENODEV ? 0 : err;

what? that means the shared devlink instance is something you will
work properly without?

>> +	}
>> +	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3",
>> &kw_len);
>> +	if (start < 0) {
>> +		/* Fall-back to SN for older devices. */
>> +		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
>> +
>> PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
>> +		if (start < 0)
>> +			return -ENOENT;
>> +	}
>> +	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>> +	if (!sn)
>> +		return -ENOMEM;
>> +	end = strchrnul(sn, ' ');
>> +	*end = '\0';
>> +
>> +	guard(mutex)(&shd_mutex);

guard()() is a no-no too, per "discouraged by netdev maintainers",
and here I'm on board with discouraging ;)

>> +	list_for_each_entry(shd, &shd_list, list) {
>> +		if (!strcmp(shd->sn, sn)) {
>> +			kfree(sn);
>> +			goto found;
>> +		}
>> +	}
>> +	shd = mlx5_shd_create(sn);
>> +	if (!shd) {
>> +		kfree(sn);
>> +		return -ENOMEM;
>> +	}
> 
> How is the faux device kept in memory? I guess its reference counted somewhere? 

get_device()/put_device() with faxu_dev->dev as argument

But I don't see that reference being incremented in the list_for_each.

Jiri keeps "the counter" as the implicit observation of shd list size :)
which is protected by mutex

