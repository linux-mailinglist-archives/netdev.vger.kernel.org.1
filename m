Return-Path: <netdev+bounces-75070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C374A86812C
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 20:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82015289D0B
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 19:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D711130ADB;
	Mon, 26 Feb 2024 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgYPWox/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847BD12FF82
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976216; cv=fail; b=CUs5q+F6zFB3hn201DPHPwmHtYBtXxXAuuG9X+LEjuqvLCiODpfPvPIFlbfgBWgsDN7Fmn5Mms9h2DpF/WnzsuUbHvvC80zmOmTmBXQPKDNIy3JhW+Ah4C8sTmEURUltqZX8fs8aZsSpMqLSNjgGUG2vsOAHfA3T10u8MPbkSkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976216; c=relaxed/simple;
	bh=9F8wFJToIzeokpQLwgHcq8jtjGUoBoIn/gZsLIT3250=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qlbkB9sASS5Ft83Nz5rAYvO6tLWYJ0xuUWd5Mi4x+W82Brjr1jW1BXaxqktB7kMJYCIyFZnPSkWkxvogGR5LJw9Lww2qmjLeL1fy07D525sLQvNfZmAEBhIJsy7SDZI5AUFPJGs3PfMmeoKykVUFumNSwUGQRsLuNRn1Q3c4R8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgYPWox/; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708976214; x=1740512214;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9F8wFJToIzeokpQLwgHcq8jtjGUoBoIn/gZsLIT3250=;
  b=PgYPWox/jx3P0Hd7e/7b/K/xEOZYcDrWDWy57P7H4mpBwBEwq1yJkMVb
   zDqhN96q24PYREbONouFEHjoMXDZU5OBG5VgedlR42ieTYu1tY0MpOr8R
   g0ZPHY5fg2Zg9pQMgxfRLcVC853Y8MPjnl6LNku1eeSxW7mtCsBiyFvcV
   6rUZeWdrqRr7DusT4fbQXLxNRKq9LDedFK/e7jHjj7XJ9TxDfH7dBpRQe
   IiA3CshDQYmWGm+fOWTtVkecdWCuhN+CmpZa/yIYl+AzMNdrqOBa0FR7Q
   Lnvvqlsys8EHJiKAlW0U2CAgrfkkiUYzXLDaiilly6ftr/alTuaEOt2Gv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3132622"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="3132622"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:36:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="11401347"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 11:36:51 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 11:36:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 11:36:51 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 11:36:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuYyV7Zoohyn1KTzbGNRWO7o2XhzHeStGflclOgO2eqUSCbXClpGymkOPElVPdm6FR6oRSgVmGCydadlpyr9131sUZctQO+rwDh5LA5sWN+YBEnYrCkR1W67qyuwGbutYSGnOwT9gclO3SmSmMVI4LVcWgXgd/GdWf2xAVUmwFVf8d6QBvUXPLS8HxbwguVBXcZnfrUZ4jUmGLAJpgJJF90MXgzYUG61G9y3B7ZEXsAnOiAbv7YRCRu3dY5ABuZUg809JO2WZ8O8WLdNBsFSkH8aUnouWC4zRwGkbwv800hUttvG3akzEXu6DkLLpe9jZK6fFYLOZGMyWkYVIhBthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrzggAeOPjlPkk8cNTRlYfthpRGO7Z+V5VUy+rZHe3I=;
 b=VdFnJ7eJbX7uPJdNzuyGvzYg4l+T8hizmndFM8KU91ROx6GCVuhvBtz6Mp/6hSKv4gX6S18mTTc5nxJeYdL2Tp7oj6eTePtOtECP8kD+wHvOtR//4tydAqruuJbHhrL+Ly0Wa3vf7puYuieBg5U8fByeLK1GdvYN8EcCgfeshQNe61ImvkcyzNnS/77xQg1jxWwDkPXBXqGe1kVVd0SY+54N7NaawQhrVzbm3EAfd2WHyD+x8upa1J/0tG8f/Hw94P51kVAZiVNMo7aYUd6I6T7xxAnhPvDmXDqNx3N1tcAZVNhV5F9GVkAKbqECafK1W1a2jvF5jfAs4aD/AyVJmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5228.namprd11.prod.outlook.com (2603:10b6:408:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Mon, 26 Feb
 2024 19:36:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7339.007; Mon, 26 Feb 2024
 19:36:47 +0000
Message-ID: <0ea688a3-f8ee-4383-b98e-82b84b791886@intel.com>
Date: Mon, 26 Feb 2024 11:36:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] ice: fold ice_ptp_read_time into
 ice_ptp_gettimex64
Content-Language: en-US
To: Michal Schmidt <mschmidt@redhat.com>, <intel-wired-lan@lists.osuosl.org>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Karol Kolacinski
	<karol.kolacinski@intel.com>, <netdev@vger.kernel.org>
References: <20240226151125.45391-1-mschmidt@redhat.com>
 <20240226151125.45391-4-mschmidt@redhat.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240226151125.45391-4-mschmidt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:303:b6::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e58afc-207a-4aad-c265-08dc37024539
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxSf9Y08H0q65NPsavFchghElc0YoI+W2/xtV58VPir4av4sD/iapQyoFYQp93noE63XnvUlsQAaT1TuCAwTXffR84rW2UtaExMFtMwxYGp6tEfRjc/KD5B/CNN3L/pE9D22P1OW1urRqOINyeusD2Rzv9NPtiC7ddL8XeKPDWy/IMr+djVdxnqn/3sDaFSf8BhAwQ/ZsCySiVzsQF0cn3nn9s4sOcK1IVf5OTQTaO6qpY2EDFEvy8aZRaFc+yEfkHRnLPSvZc7CeRgAPyeGjtM0yrxCETG1fZuR9MGWwWMXZsLTmo32YnIiJFFTAm0LfuyEbVOb8otzJJ8aCcZeUcW/NSAjpdZa5Z9ASLm95rlSGStIgajdmQ8bjW5kqUfuGFqtSOPE4xa7TYL38GT1r5BpLIzkKih8vDjVq0qteiPAiUgYy9hx5M54CiIPMZyj0yLPe+MbspCBZ6/rB6vVi+KEO+g3fB0PMokoqhTDMK9J8zDYmwB2xom9kLU5uChW1QHSyCo6f6nErzcY37eGj+phi9hsHfQPbXmoy4vB5ahIpOIn3pFMRKSR+JlN9hfpZqYltGxQC3TgFzeynmEst6kC/ceGKW1vKdZMcbomfbcAROaPSJ8w4ddLP0GjwS3+Uib23GNbVihSNxI+bYkeiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0RhcmFIbngyMXFYMWpTdmdZT2VPWlBMUHVidnU1RUkyc3hUaFhmbDBBUWc1?=
 =?utf-8?B?bTBIWkR3b0FIMytBUXp2WjhaS05MSmxXbHRpQk1vdG9hVFRrbVp6ZFZYdFdT?=
 =?utf-8?B?di9NQ0ljV1NsdmgyamY5cUZ6cU04V1BxUzZ6aDRYakVmUmNRNXZPTktmOGt3?=
 =?utf-8?B?bXR2Y2Rtdklzc2tqSk95QmdVNEFlZWFNY1BxOG1QYlo4VVZ5eTlINU5QODUw?=
 =?utf-8?B?ZVJEVnY5MkR6VzJpdmlIRHpoUjBMazVRNjJUSzNrRWs4bXJwOUtKSEZFTkFo?=
 =?utf-8?B?bXo0MmUxZEt0RXlXN3BnYVEzS05Nb0ExbXdkRmJzQW5ZODBMWlF2YkZTbHZi?=
 =?utf-8?B?RU1MSXhtNXNmcmI4MFU1akdGc2tPQjQ4eDBzeUlsM25hUDlBUlNEQ2tOVkhV?=
 =?utf-8?B?Y0VVQy9LemZYRExZbzhPWnROTDZqWTJ0YmZOTVBEZ3ZWTWNXamxJMCtXblVX?=
 =?utf-8?B?L2V4US9uVmo4K0oxcVRSbnJlcEhoaSs1Z3pyczlUc3BTRzBXeVEvSjhTMjZ6?=
 =?utf-8?B?RHJSM3hjbVJkTTdHT01tSnh5SVd2Q0R3aUF4Z3IvS29xTjdPN3VTTlZLWFZl?=
 =?utf-8?B?ZFNCTlNIQkRlMnpBUHc0N1BrTXhhcG9pZUk4eHpCVHNiMnlJNjlqaG9kM0Rk?=
 =?utf-8?B?T09kd0p4SENCcE1nYUwyK2hkOGxYN1M3RlVnSFAwMkFWTHFTWlYzbnVmKy9W?=
 =?utf-8?B?UXhMd3pjbnFjTFVnZTVMTllZR3U5dTQwVWpad2czS2RPNGEyaVlPS0NUL0o1?=
 =?utf-8?B?ZkpGKzM4SzJHRTJncVFpY1VTdUlMTUdaeEx1Q3NWZkdFRWx5enNtUUJ0c0RY?=
 =?utf-8?B?Z2Q4R1NyZFMrSW9mMzd0WWE2MlYrOFJRTDRydG1TOE9DMllYYno3bDljTHd0?=
 =?utf-8?B?SjhXWUhrbFBnSW9ybTVVNnYybm9NMUF4RTNqOGcyaTlVVndlcVJmNENMd2Nk?=
 =?utf-8?B?SUY2QUZ6SE9iNWFoN0JWbnlzdkNnemduTzBhZExKejRkUnQ4bXA2c3dXM1Jp?=
 =?utf-8?B?clQ0c1BIblhNWnE0UDhjQUcvU3p3QVkwSnUxRUplTElkTXFidXZCVkwza01P?=
 =?utf-8?B?b0NJUlpqUUoweVB1TTJBODlZM1BqaDFGVkNRRjQwdC9ZQi9FZlhDanhnVGhM?=
 =?utf-8?B?dk5IMldRSUZFcmhtYVJLUmRYK292TkpPYnBwdG44V1BmR09rRlcrNmxQMFAv?=
 =?utf-8?B?WG1XNndOZmxvdXhoY1ZmWTZtbndaaUxSK2wyZ2lubHJ2djZ4c09mS0Y3eHQ2?=
 =?utf-8?B?MXBMNUhCRlEzY1JhaStIVE9URVB5SElDNTZxWmU0Tmo4NEVrYTQ5RWlacVhO?=
 =?utf-8?B?cGhwS2lMWVQxRi9QN3JKQkEyMTN5V2dXSE9yMS9DSTY1elFzYk1nZW1GVDk4?=
 =?utf-8?B?eDNsVysweHB1NTdkYmJucEtyRWpXaWRGR2VtT2lQZituSG1wTUxwdGNnZlBT?=
 =?utf-8?B?eW5TazRlUTVzbTRwZ1dtYnBiSFFhYm1QMEZKVE93eXdlc2pNT2h0eTFlUUFq?=
 =?utf-8?B?ejhUWkM1SDYzcmN3NENOSVd1WFNGeTJzYXV6L21LTnhydFJ5MUxKd3lmNHk5?=
 =?utf-8?B?T0FhZEREMGVSYk5kNG1NczZBY0xyazR2a3owM0grZENpNVJydHR6NkxEWTRW?=
 =?utf-8?B?SUxpMGhWTmxVUFdmRFRqNk1wZEdnc3IxeXlNL2Ixc1Rna3YyTEo1QWNRdExw?=
 =?utf-8?B?akdNb005dUkrTGovbkxISExhcEpxTEJ3bWNMbEY3S0V3NlVjeGJmQytLM1Fo?=
 =?utf-8?B?eTQ4S2ZEMmIvcEsxdTcvU3QwcWM5d203b3Z0WWdyeEZSZkkrM1YxYzg1Tm9J?=
 =?utf-8?B?Yk40S0hwWWdZL1piVU90TXFicVNGL1hRVkR6c0NVUGZOM1kzb0F3d0prcFFB?=
 =?utf-8?B?RWplR0YrNmlYNkVkY25nZC92N0ZIK3hjZ01kWjM5c2VTSlM4QVBFdEF1ODYv?=
 =?utf-8?B?b21VT2VWMkk5VzFWem1xU1hZOVNlcGRJaFdGUWF4UXJJQTM0SkdHNi9BV2du?=
 =?utf-8?B?NFhxRys0K052Zm1BNFdVZnFqaUk4Rk44OTNrV3JKUFFZTWxCT1RTL2gwVnhL?=
 =?utf-8?B?RFdDT3NZTXdNVDgvcFJNVUJIZWcyTFlSTTZnRkZpY3JRVm0wVWwxb1dnZkh2?=
 =?utf-8?B?dGhXRVRYY2VxcXdxVlpDYXRSeXhiK3dIQTh4UnZJeTVORlZHVWNrOTZGUnZ4?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e58afc-207a-4aad-c265-08dc37024539
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 19:36:47.1865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaQUDTZ3pRvtbgrRX6qLONnphBTUYoou4sTlI7VwDdZaEsTyvV3cRKuzxve3Unr4zI9cKAStEo+YyV2eUJ/qDSS1SVudGYgd+4DIOEbkGvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5228
X-OriginatorOrg: intel.com



On 2/26/2024 7:11 AM, Michal Schmidt wrote:
> This is a cleanup. It is unnecessary to have this function just to call
> another function.
> 
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Obvious cleanup, thanks!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

