Return-Path: <netdev+bounces-86320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFB589E633
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9109D283226
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45A4158A28;
	Tue,  9 Apr 2024 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJ7r849N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB81E502
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706022; cv=fail; b=p81a6vs+w5Vegxpfj4S67gy/J54HvpCTHseUUnWcFZg85qW0I1PYaQphxeSSwtMaAaxIoG4XOdlrb7YiwRGAGFOnJm+CpnM86177yWyQO9ShRlWkg3iFRRAQU8NH4YL3o9mRgIvhny6gMejhMrAMBuRMjuusLT5Nv/Dm4h21aSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706022; c=relaxed/simple;
	bh=le4ZGhrUCyxLdgcXMk26bIN1weDQnR6sMRfJAh78YPg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XR08HOslI8a47tJ3nKM8qobkRhr8HwREMj59tYbFGR0gJPjCfnyF2wpERH+JnVWeStO5gsjIAV8nxSLOtL9MLh2K8Mj2JKQs0SYko1k2lre0wY1y1Zi6h9HsNIGDvInaoOG0juOGxg/m8At3GYoQYJ9s5nAfyPurbYqZTMw7R30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJ7r849N; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706021; x=1744242021;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=le4ZGhrUCyxLdgcXMk26bIN1weDQnR6sMRfJAh78YPg=;
  b=GJ7r849Nkl0Exp/ECoo+kKEwvb4FThGmaJMzcwVrXr4O7dZHxNlPA+ms
   0QSl01v3oiJYnKgkH6t3iv4CYFMBrakQUY2b/sJiySAtjYSUrT0E1nUAL
   ZznmNV3Ao0dTcmOXZrm87iWTbU3U5lUT43dmPsk8Jlee4pxOKp/lRAqHO
   Q+uvclbaxmrhw2V+jN6jJ2GBFDkGEsEuEMxg0Rt/zFnomPHqn1vkbBMCV
   VZGDf4Cp2k4W9RY7yP92YrBzpaEF4q6NlHeflUGplnpJBUklKseKV5lVZ
   MPQe9RhDPvpSoiiys5+OuSpX6cgwZpYU5fGvvahqXSEAze9CICRpiN3TJ
   g==;
X-CSE-ConnectionGUID: huZtrsxlRKW4PZjtsRSkFA==
X-CSE-MsgGUID: 1OvUUWnBR62OwDona2eZSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7908255"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7908255"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:40:20 -0700
X-CSE-ConnectionGUID: qjURCrPNTR2haSUySh4phA==
X-CSE-MsgGUID: aI+T1oOnTYKfHikzpuA+Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20946026"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 16:40:20 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:40:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 16:40:19 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 16:40:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J169emcxWpn1l8bErThymU6U04blSnrtYvLOY9iLcOLdqEZ1xx65mjBz18jUMvPEjWU0cmFI+Dn+XslEVvnKYRClsthiEe+tURfdhasG0Z/qmCvFn9+47y7s25CmGpAU0p5o78Qmlxdi1EaPY7sMipSz85+ZlP5eMO/u2aH+VMNnhTW9toWqnxo9h9nTDa+yN7dl9FK2x6q7+rS5S4kjccUlE2jnhIIhjEhEP/sEi74SseKKiemMW3S7fyg82/p67S8GezVTbMc84vyluXGJYFyoP7BP/P0c2nVkapN8caax39p7IYoL02YOnvzPTktwX5+g2Ddr0n95M/J8SmQiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNnIKc7ucVOos2H9xA3c+jYT3XjYkJT8LCvDVkCB/K8=;
 b=bjXqSq4xR8PD0336GFJ+jUC+geHoh3kYYi0EZvvW6eQSt7Redr0J6o0I14j3+yoGosntujK7OTuR1B0G+xfdmr2Yb4EUIYRIUbChdPtmjM8XqNnwL+xSo9oPsnCZkBbpdRTcHg8lAm0aqbIsn8Ttmdy4k9TzOFgqtIe5oY/oqkWMwUDp3222CXh2bLx5D/jyzZB6cYIBmQ7vdw+EFq/twCLnAsgdSq4OGM+a42gLctEiiUnRdmqJwxv11mWjQdpDm1xFL6frcAO3NfgNXGmQHOtQfEFWQZ2khxUbfgd9eRbE3poZX70wp9htd6Rt4Da2ZKZ6uFR2Q9ynGOvATvcnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6854.namprd11.prod.outlook.com (2603:10b6:510:22d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 23:40:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 23:40:14 +0000
Message-ID: <7f4f5a1f-1320-4082-bfe2-6b1eb422e37b@intel.com>
Date: Tue, 9 Apr 2024 16:40:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/7] bnxt_en: Change MSIX/NQs allocation policy
To: Michael Chan <michael.chan@broadcom.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>
References: <20240409215431.41424-1-michael.chan@broadcom.com>
 <20240409215431.41424-6-michael.chan@broadcom.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240409215431.41424-6-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:303:8f::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6854:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jglqWw9rsElbkFHnGIVJT5GcLs6VC64WqCKunQ0W/oNUkog+iH+VVlSD4AWoLJXvCkDOsHdsosMW6bKJ3DBco34LxwF6vRRlBn7xSDQNVrZ7fKhO04bE4wYmKtYuj5MdgH7Xse4n7EoS6Q36KEkp/OylnvcAiaFc6UCqUkRAQJE9oyxNUGSzX1pWGFC/Ueuh6cQYxG0ahY4oDuuBAJDbdY6CkjTqJRIYH5pg08TPGwKsuZTwpxNPoHkGR6zrDHBqUcLIqLC6wW6gzlGRlBwtuvVCQMsExtpuMrjDq9lKHZQ5oWR7LsALLuPOQt/NgvBBYWTUWyv9SyCFScPV5uL/yS++q6Zgf0PQTOoqiw+6LdCrzShRlxAFRWtP0d95A0KJp3UrSdzl4Q9gx+/ry2os+TPHAEhR5coACQUpsw5czSNzulQ6x9/5j1bor0YTTUHkTt7LoEhPBgT+ngIiBrjAMp/JCXI+VZghfqtswalCC+s8Ak4ZWcRLE35i4gnmbTZRcs86nKRQDfcWa0cYGYoG0ButmZPIDAsUlOz0YYqR8YkGBc5tDynY2oQTNLVEwCqJXWOV1AG2I0+pY1Ue3QjBT9eDyRDvSmKjMVEXiSkA1D2ztkMfBobJnAlHGSOH7MEVxHpYFvdHg5q9gva3w7msAH//JimyovHT72QfXXxWjAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elFUSGNEM29kTTdKbGpxQTdEOEFzWGZTUDNZQkxMb3RwK21iTWRaTVc3VEFP?=
 =?utf-8?B?QURkLzY3NnVKUXdMYkNQWEhuTlJQYVZ2dTYyTXo4eDRNdlVkcytlUVltaVJI?=
 =?utf-8?B?amlhc3ovTWs2MGNMYmZRdnJRWmloL3RCYXlZSi9hNjhSWGoxUkZJeTFubnNa?=
 =?utf-8?B?Y3FXaWdFTi9kejVpMWNUbXBMTWFRSmxMaDFUd0llc3ZqNEFPcC9oOGNZZWRC?=
 =?utf-8?B?emJEcEw1cEYrU3VWSUdldFNKK24yZ3ZIMkNmWlRDdzFCdm55LzdQcXBvV1ZB?=
 =?utf-8?B?RE1xOGRHOE5RM1dpN2QvQ3YwTGZldWtuUmtaT3hKcll6dTY1dnFjZWJ0U3gw?=
 =?utf-8?B?RnN6azZLcERya08xYU1OalcwUVNLWnNxeDM1OVRKanBJNkU4ZENvU3lnN0gw?=
 =?utf-8?B?YnhtU3FTSHBGMU96KzlYc2JReFUwaHQvVTg3aWRNTHhYUGdLSFRFYnl0dzFj?=
 =?utf-8?B?UWNDeUhBc3JHS29LMXJveGtYMW1kdjMwdzVyOGt4SjVMY29PU09oSlU4OXpQ?=
 =?utf-8?B?UExuZEdVT0dHVGtpTDNZZWpBdW1hbVAyVkxHNSsvVjVIbHpCWjZhQURLc0Nl?=
 =?utf-8?B?ZkpXUDdWRkVXZkpsQzJ5MzV5ZnRzbjJ5UDdkYUlrQjdiUEFHcnpxZzc1U2VM?=
 =?utf-8?B?QXdHSzZSbEJkR0tuK2I5S0ZOUlc3eXphUzNxZXdxSnpoNFBaNG1iV2tkL3du?=
 =?utf-8?B?ZFFjSHIxcGNSdU9nc21EZXRtcERYTUFWVWNFUVd3emxDU2RES1o3bDcxQ1My?=
 =?utf-8?B?Q1VDVFNyL0RlczZtaE9VdlVtMnFuclBBemlkL0lXNjQ1b2Jjc0xKYXBEdnZn?=
 =?utf-8?B?Nm1EeFlSdFBmc2FUZWlhZlJNZWFFZXFJNklYV0F6WFdJYndBN0s2Rnp6ajRp?=
 =?utf-8?B?Qi80b2lYNnhnZVNJZ2JkUXUxUE1NbXBSbWRCMDN1YTBudnkvRjRQMWgrU1lx?=
 =?utf-8?B?NkVyNXRxOHF4OUpUMjY4Y05mRHliNk8rcjdsUEdvZ2lmeG5rYVBCQWtlUTVz?=
 =?utf-8?B?OWpQdFRwYUg2cDEwTGNIZHg5WGpTN1ZmbUFNbWJnQzBDMkNjZjRQZ3Y2dng1?=
 =?utf-8?B?YnVtbnp5MkhDeHMzRHJ1clZ5cEdldUxWcVVOQi91U0RQNUVjaHhHVm5GNmlw?=
 =?utf-8?B?d3lFZHIweDBQdVBOYmdrRkdya2FvZmpCVzMySHRDOTFsTUFkeWxweDBKM0I5?=
 =?utf-8?B?ZDZnRG5ONWJ5M3JtaXFwcVdhTGdqcTIyQ3FRQU1kYnBZanVHYkNWYU9FVm5K?=
 =?utf-8?B?QTlNbDMwck42MjZmS3dQaDc4WDdqWWc1a093VnZuaCtMSlROVjZPd2pMVG5B?=
 =?utf-8?B?ekk2QlJKNktabEVTMHdWMjBsb0gxVkFMcE9XYWx1VEZZRG9pYVZVc0I3MDRr?=
 =?utf-8?B?YzlsWkNTZnRQMkpJNCtuTHhodHhFSnBMdldZWjR2MFJ3MnRmanFPekM2WW5Y?=
 =?utf-8?B?Ym82dmpMTDQ0U1RaSmpHSlNlUWEvd2Vzekg2RGVZRVhvZmpXZTRHazRqTFlV?=
 =?utf-8?B?YkhQNWYrUUN3UFF5QTQ1M1pxSG9TNzlLdGgzblhJZGgzRUx6YnZHR01ibHlW?=
 =?utf-8?B?empvNk1Qc2Z0c1JsRWNrelRoZ1N4SVhTSkpQcURsWGlqWnFJcWdiaGtaTjBk?=
 =?utf-8?B?SHRVN3daR3lDQzZVdGE0WXpvQ01FQkJ4YlRFb2xaSU5jY25paGYvZXg3RVdX?=
 =?utf-8?B?SzhYUWZRRDRJK0NyY2lQWTFKNFhQcFJNZDhzaEZlRWU1b0RQVnI2MlkwcW5Y?=
 =?utf-8?B?WjJub3dlNFdlTmxDSWxzUlBTN1Rpbytha2lXbklSWGwvMDdVbU1yeGFWNGtq?=
 =?utf-8?B?MndpVGV5aGhOZ2VCSzlUbzJtalNtelRPQlorNGlpMXZ2Mk9CaFJFK0ljWFBk?=
 =?utf-8?B?UU9xYVVGNWNFaEtyN29yNCtjSXhQZXdmazVGS1MrMjRlQjRJcmJTcDJicjRH?=
 =?utf-8?B?UkhocGUrWVQxODJwN0xzUVFic3JGWDlHQS8zTk52WUZwejFmVUV2bVAyNnA4?=
 =?utf-8?B?bHFtczBUdnZCa0RLQ3RWYTl2aGZBN1lraXlWWVZ4UDJvazQyMjk3aGV3Z3hG?=
 =?utf-8?B?LzluM1M4Zld0enQyMWZtaThRQzVQd0VWRm1MUUl2TVRjcE9GTmpUbHdNTUJQ?=
 =?utf-8?B?dHJGbGFDK3RVd0wrWkgyV24yT2ZFZmJlMG9nV0ZuWXVIdVk3ZE13WmhibVZM?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58440427-30df-480e-5891-08dc58ee678b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:40:14.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEjiJHQN3c/ULezgpLCItsIf9PTvIkMidLycPDlg2S+RSNSA/6pU0gIh8eoptPj8IqdxoKtr2Odbz2xLvYJOkWCBfsgEyE2iM99F/F+9t9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6854
X-OriginatorOrg: intel.com



On 4/9/2024 2:54 PM, Michael Chan wrote:
> From: Vikas Gupta <vikas.gupta@broadcom.com>
> 
> The existing scheme sets aside a number of MSIX/NQs for the RoCE
> driver whether the RoCE driver is registered or not.  This scheme
> is not flexible and limits the resources available for the L2 rings
> if RoCE is never used.
> 
> Modify the scheme so that the RoCE MSIX/NQs can be used by the L2
> driver if they are not used for RoCE.  The MSIX/NQs are now
> represented by 3 fields.  bp->ulp_num_msix_want contains the
> desired default value, edev->ulp_num_msix_vec contains the
> available value (but not necessarily in use), and
> ulp_tbl->msix_requested contains the actual value in use by RoCE.
> 
> The L2 driver can dip into edev->ulp_num_msix_vec if necessary.
> 
> We need to add rtnl_lock() back in bnxt_register_dev() and
> bnxt_unregister_dev() to synchronize the MSIX usage between L2 and
> RoCE.
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---

Whats the behavior if the L2 driver dips into this pool and then RoCE is
enabled later?

I guess RoCE would fail to get the resources it needs, but then system
administrator could re-configure the L2 device to use fewer resources?

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake

