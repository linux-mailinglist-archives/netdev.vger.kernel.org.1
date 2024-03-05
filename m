Return-Path: <netdev+bounces-77618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4E38725C8
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6094C1C20D47
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CE5171A2;
	Tue,  5 Mar 2024 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8d559QK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF65BE4D
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660160; cv=fail; b=NPcLKDIBYLE47npF8X7pN0/XQQRMDtcI2dQIiiiwY9VlPT2Ap5Rj/KeOUPG0RoHTVTuh/wkTuIwF0s1nobOa5f5jzdPDQXN0OQTPz+bBD6gHfHjrVO8jJop0mXpbxt9Zrp86q5f+MpBmjA+EbA6NnGyJh7dgJaGi58eovDtiI2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660160; c=relaxed/simple;
	bh=9xlbKbQkSNYU7vSMlrICLkfOQ3DgnUEKAoEqIU6OnVY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ekZ1kbTPkjq1okGcUqXnh/uHR87T2KcetaVRDMQfeygp44CTcim0sVI+HXOSFEZCNDEEUnAfYeJuSqvxNSKVA86A0cXPxq5ggnpqMMHP92zUpqvoteNtkPhAMQ4z3LL+wk2vlXnYabnftWtwv9/OX1a15ocEh/pyOjByRABVgc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8d559QK; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709660158; x=1741196158;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9xlbKbQkSNYU7vSMlrICLkfOQ3DgnUEKAoEqIU6OnVY=;
  b=M8d559QKzdTq6ui1kCldxeQOiVoetBAxhBEwE3w/c5eypBom6p1UQMz4
   oo2lsymrzDeLybUdyED65NnVi5GK8EV423hhvfsFbEiIKeqUciwQ5Huw4
   1iUraelONrAHuAEMCDME/8YSd0fjfUXLJz0xv8KRiShISPdDVgAnnDrue
   dtfZ+qXeFDDLWwPsVTiPYMeG47F8FSDcT0rOIM27ml+LD+TVJ5zULts5l
   gZc/eYPdrwoRUs9v5cJIZWj5W/WWDFJ+UqEalNZydDSW9beqzAG5dot3f
   0FmS9tnUifHWM3TPbEP9DmItxmDJbdXMuOYp9iaTOu88ay0R3gRpH5aRG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="8052153"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="8052153"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:35:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="40339342"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 09:35:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 09:35:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 09:35:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 09:35:56 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 09:35:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7Xd8la2YT6fgDgluTe8NBVFNwxqf0FoOyS2zhwr71CYiTLORP/XAIhPJMi2I9sJLEYVzl/L8DD4nT69re1jLj2DjNicRv8LSREiYFLzNQt7yAZkUKEhjjFOdrrzP6069MasTBmpVs1RIjlmVEqXadoaojK6+gWaQqspeMDIBppiTmP22uZkCDrCcSfDa2ZZLBBHHzm3hoPgaHhxbVoR/IK7Z5EyG2trMovrwrOQMz5kIzMbth+pMR+oms8Hnli4yKbwSaa6LjXQaE4An00ep357occBV+rfYq64r6zjP8BX6qd53MCOpK+3TdJU/3Y2hs7jHBKwB1kXwAUtzE5zSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eASCN6eafNlcogwIBRcqO8gvOTKavKMUbk76qDWSe/E=;
 b=iKocmI24XEjJuAAtXVHFuZptbGDhU9I5AzQ8h6IqVFuIQGFZoFq1wWvjk7FuDZFc8fsXfDwbaCNQttsGtdNYLFw6dr8SY1kX+P5kAfhyL+uxPfFi9sP2NwHuabQv/58KAGnizDt9zepYLf3VZcYMvrx74s9CcOAF1bZfF6KxTuSBJrPY7V7WMTl29jk4mloT/mKODXZ+r9rfFpCatbD4Gi9/jZeEZWp9idQGRUdTxc/4GmL5l4oHIDWy1ZlYsmV4rB/L0y6852I1s9c8qktAJ6sg3rwNBMW3Xm8DzfWfvNDwBrUObv9MhnPDLQYEtfEpldX4BKGmTriQUVLlL2Mx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by PH8PR11MB6853.namprd11.prod.outlook.com (2603:10b6:510:22e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Tue, 5 Mar
 2024 17:35:53 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9d72:f2c2:684b:6b50]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9d72:f2c2:684b:6b50%3]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 17:35:52 +0000
Message-ID: <cb61bb19-ac6a-4271-b699-69b94d55b945@intel.com>
Date: Tue, 5 Mar 2024 09:35:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v1] ice: fix bug with suspend and rebuild
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Robert
 Elliott" <elliott@hpe.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
References: <20240304230845.14934-1-jesse.brandeburg@intel.com>
 <20240305131704.GD2357@kernel.org>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Autocrypt: addr=jesse.brandeburg@intel.com; keydata=
 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
 /fnLfll98Nhx
In-Reply-To: <20240305131704.GD2357@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:303:b7::8) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|PH8PR11MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d92d457-656b-4beb-0e85-08dc3d3ab4a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySGn2MemIscMUfJCIfGB2XFE9yZmpZ0yS6YEQOHOOc1fX37692P3dGHaxfZk0CCqoWYol3J/zkJ3TcRepAONa0+I2bYc1VmIo6DMMmdPP3gEyt0kmxT/vvbcHIRvuahSiHm+GU69VFKdv0d0mGt71Xuwgk5AjLpSi1Ys+go4YFbIOQWyPmMqIZOe1/azndgtqESieFYxJBAZWHuqsEZwboPQf4zd3rKw7GkzW9cmxkPYpv74PN8M4q5UmVLxkHpNaNaRn0G8ZNRwKAPZpNVfrUqD83zAlCvu9dw9zyI4PazPOL8UPiGLLzBcbmIqtUTfatF2xWg84KH9c7TaMvpQc7ifO4Gx9Qc2jizCc0ORFSBgdpxF9VbzXk8ogfrP3Aa0D0c9iRFhLlx1c1OxVxqZ4EISIoRQrlWQMmBL6YCE5w9nSAQWHOY5Ncz7fW0NoumVcOvzd9/K0olCDuaQL8ye4QFAa0raRUMHiC6XiZzsioywH/yYW1LBSAif4teKKwjv5BTAuKG5/VJG3vf4MapB9NThtumvq5exeDXdaxyyhy4Uknl6WeBOn/10SpxmYYwdM+9jGYhrHwU6LbRXBNxAFxqWgVp+wjEviLpZFU41K/16UEtpBkfieD4GLpQXWXhnNL9Ju5LRLPPiUO640VQWjMyMOrW2RYOjh0bCPe4r3/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nzg5RmV4SzhGZjF4M0kwZ1dZZE4zZW9JQnI2TFJNQTlSa1hxK1F6eG05cjUy?=
 =?utf-8?B?U3d3clcxSVk5dGdhNXRzQWRQWjYralNlWldHcmN5TmJXODNRRXd0T1czeGN6?=
 =?utf-8?B?YW5qbnBZQ3Azd2gwOVpKOGVGMS9vU3A2aFBESTlCNEh1SXpycXlCZWFOSE45?=
 =?utf-8?B?WitzZjNOY202WkVjS2VJMFhWTmR2Z3A5K1FabU92YmszVTJqTzJPQXVYNEp3?=
 =?utf-8?B?amlDRlFZaTd6YkVwQkxwT3lnV1k5VHJxVVVPMk1SMWRER1RrUEM4Q0hRT2Iy?=
 =?utf-8?B?UldMOWJBWStkNlhpV2lFa0VzQUcySmZrQXNZUW5IQ21LeXFLc3I5d3BWZGpo?=
 =?utf-8?B?ZEdKK2FEUFFrWEF6WnVwU0pkOWZiUURxSDdOOXltdHFBYW1MbUJMWUVZRUZi?=
 =?utf-8?B?UncwYWpzRjJQVHFwd05CZjZ2UlM0NVdUQ1dLU0dSOWRGZEZSc2ZLVmd4aEdD?=
 =?utf-8?B?d0FodXdvcko2M0tNSDh6MFIxUVRCK2JOMm5vUU14QSszSE00bnJvelBjSm0r?=
 =?utf-8?B?bkR4Y1lkdjRSeW9hK1BEVHBmNDBCdTQ5NmZSNUU3d2VkbUNnWWw3a014dnU0?=
 =?utf-8?B?SGZLQ1FlSzIwL2Q2U2hBWmNtSVhTaVlsazR0QVdNbld3bGNtUUdNV2dnekRv?=
 =?utf-8?B?WG1QanBTaEdHQmlaNWlGOTdGUk5RbEhpa3g1TXlCK0xDNjZQNHZjcUFtQ00w?=
 =?utf-8?B?Q3FrSWFlSzJCcnVIY2FidW9uUFNhWkVCWWd0YzJ1bFQrcUltbm1lWDZFVWdS?=
 =?utf-8?B?Y3QwVG9TUUhTOHpnQmh1c2Z0aUNOMVRRdXFYRHY3MjRPQUZNMTBnMTJqRklv?=
 =?utf-8?B?UEFwRFFoZnFhdEk5SUdETURxcVFmbVlQdStKMURDdERlS2dVZE0zRFBJUXJR?=
 =?utf-8?B?ZUhyMlBtd0xoMlVBYUkzQnBMSGUwdEE2bzNORFI0MUFETFlvWmlSNlFIMWE2?=
 =?utf-8?B?RzJEVFBTY3BFVkRoUlFBKzB5N0UzRlk2Z0p4dmFFNFdVcElWMUk0bEQ0aE5q?=
 =?utf-8?B?b0lndDZaNUg1LzE0Rk5YaGQxb25Ob20rU0pYdWE5b1pSNXRLanVERWtnaTN1?=
 =?utf-8?B?VWtPYnJDYlJoZjVHbHg5SkRTeUsrbWx0eFdhQ05ZZ3VBcTRXQjRFcFdrNkJ1?=
 =?utf-8?B?MHM4OXhVWHlvblh1eDhyYS8xbmQ2NFEzMzM0NGFrRmplanE0dHVnVlNkUGhV?=
 =?utf-8?B?bGlDaDBCN1RjVlFnTG5ja0FFTEhsY2lqOVpCV3N4dWNBSkRQWWVGZzEvL05r?=
 =?utf-8?B?YzVrY0pnYmExK2RZUk5oVE9EK3kvckVMbHJsbWRaRW9rdXBlbVJkUWZSZjJ0?=
 =?utf-8?B?Zyt4a3AxZWgva0t4M3lyVVdidVBtbmN4VEFoUDZsU0FQcHBSSkl2SVRhc1Vo?=
 =?utf-8?B?aS9RRGVsVFlnMGErYXc2VVJTakpTdUhSZ1B2eUJtL0dmeWZTZkxlZnNVU0Z4?=
 =?utf-8?B?SGFMeTlIZ3k4dHlObVpWRGdWV1kvQTFxODd4WU1wTTI2T3NackJHK0IzeE5n?=
 =?utf-8?B?SW9KcFBjRkFXbEtaSFRHeTdhbGl3UEh5Ni9HYU9QYjJxTy9PS2J1QVhabEVH?=
 =?utf-8?B?Z0lQVXRVUlBzQWgxNUlhZUJkVjBlaUVCclByUnE2VzYxTytqMnF6QTV4Mkt5?=
 =?utf-8?B?dEJIa3dNaWo2ZmJoUlUyakMvakFhMzVyaWV5QitqRUp4RSsxQjViYW9VYUti?=
 =?utf-8?B?bFVkY0swVFJJcndnY2kxSnBmVjVSZ0phODE0ekpkSnRuV2Y4bUpYbC83U2hT?=
 =?utf-8?B?bVdUWFBqdUVMOGgwbkF4NllieDNpM3Y0QlNyQ1h4aENXSkxianZicktzdWgx?=
 =?utf-8?B?d2Z3eCtYN1RiSFZSc1ZrdkU3bkhSZGVtcndLNXFuRmwzaUY0ekJmOGpPNkIz?=
 =?utf-8?B?MG1HbU5ETnRCKzdNRkxFOG03Y0J5TTVqMGZtUEMwZmFRb2czcDlhY2g5cWcw?=
 =?utf-8?B?dWFNdlFCbWpRTnZNU1F3S3hOR0lBbXlQajhMemtLRndLczJIRi9MRVltUTN3?=
 =?utf-8?B?clZkeEZBS2kyOFZ0ZnRza1lpQkEzTlJmSnZvbEExVVBDWDU1T3VnNkV3c28r?=
 =?utf-8?B?MUtyTmMrRXBkQzRUNUNOQjAvc0lmVG51R1ZEYkVGQVFocVRZMlBSaXNrMnFY?=
 =?utf-8?B?R3V4eFk5cTArZDd0R3dkc1Z5VERNbTdvNDY1RGJmVEJ0UFRHZFg0UXJvbDYz?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d92d457-656b-4beb-0e85-08dc3d3ab4a1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 17:35:52.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKvjkg9o8Z8l8Gw8eK9kA+SHu13U+MIEaf0gin8dTAqc0U1rlPBNeUDU+k4bZdqaLCBNE6dwSNA6RlOafddU12FlJ/pRFHYeuQIUZQWPX4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6853
X-OriginatorOrg: intel.com

On 3/5/2024 5:17 AM, Simon Horman wrote:
 --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>> @@ -3238,7 +3238,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>>  {
>>  	struct ice_vsi_cfg_params params = {};
>>  	struct ice_coalesce_stored *coalesce;
>> -	int prev_num_q_vectors = 0;
>> +	int prev_num_q_vectors;
>>  	struct ice_pf *pf;
>>  	int ret;
>>  
>> @@ -3252,13 +3252,6 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>>  	if (WARN_ON(vsi->type == ICE_VSI_VF && !vsi->vf))
>>  		return -EINVAL;
>>  
>> -	coalesce = kcalloc(vsi->num_q_vectors,
>> -			   sizeof(struct ice_coalesce_stored), GFP_KERNEL);
>> -	if (!coalesce)
>> -		return -ENOMEM;
>> -
>> -	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
>> -
>>  	ret = ice_vsi_realloc_stat_arrays(vsi);
>>  	if (ret)
>>  		goto err_vsi_cfg;
>> @@ -3268,6 +3261,13 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>>  	if (ret)
>>  		goto err_vsi_cfg;
> 
> Hi Jesse,
> 
> the label above will result in a call to kfree(coalesce).
> However, coalesce is now uninitialised until the following line executes.

Thanks Simon, you're right! And it figures, The internal static analysis
runs caught this only after I sent the patch to the list.

One fix is to NULL the initialization of coalesce, which solves the
problem with a one-liner, but I'll look more today at whether I should
just move the label or something else.


