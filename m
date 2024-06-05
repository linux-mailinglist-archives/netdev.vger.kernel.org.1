Return-Path: <netdev+bounces-101145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 293928FD79C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191591C22599
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421C815ECF1;
	Wed,  5 Jun 2024 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBSvfha6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368315EFAC
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619746; cv=fail; b=h2x73Hwhvm+XoNS0DjuPwek4XE0EI1esF4GQmmQ5S5YXQuls4TN1YXyUwKOM6Tc3GsTJ4IQR7s8JfEvnmIlhIxT1m732/PZSZ3XnZThzKKvFzQsHeGx7MebUVgLr2fM4goPd+yKM+w1B8wlmTNF3Cf0oir0+KucEKvXzci5Muaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619746; c=relaxed/simple;
	bh=u4ph4El0wPbYj4bMUTgnfPqGwyjLvbAgkIScUsgIHDU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XxuC7QJlkAnAF5x4CJo0ZbIN4N+/7CTbFQ8Di1yoHaEJrouWRk+r1WcgSwxsrF2pbNS/z9HYD4/Uiy8P/XfAr5grW6ZCulkVaHjoe0YdZKHTTFGjl/O+zlr6AWtsYZdcPEoOuJl5wmdqfWHWLhaclqk2afM06XrRO1SjbmJss80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBSvfha6; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717619745; x=1749155745;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u4ph4El0wPbYj4bMUTgnfPqGwyjLvbAgkIScUsgIHDU=;
  b=cBSvfha6nupsemZBYDMDHtZF2DoyWW06Upg12iDYMlY18K3HB+U8kgDA
   v9YaBvcyZGyythH2qG4OW0ih8hQ9GXBy1pb9bdEHtsQAhAGqTDwoLVn6M
   0qqWA7EOj3QhEh2VzRD44UOVRJS/Yz7hOpTqJyfVXDuZB+MpiOMp8zs/n
   hy8GmNIuMaQQ3M+Mdl9Bsd/LFSKm2yefpHVmDTAYk4956ySWiL/f18efv
   XHR2lWlNbvyEF5XOSBIt/yQaRxpi1p72+1Xwta9teGKd0Chti7OTooL54
   QpVx/nLyWPqqkiHRGeBNzbDXQtTyjW1Wz7UhzfNAILZBQrjYD2qMFJ7GX
   g==;
X-CSE-ConnectionGUID: B9NsoklMSG+BI3i3sAg5oA==
X-CSE-MsgGUID: X851ICLTRgGR6vM75z14DQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="11927930"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="11927930"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:35:44 -0700
X-CSE-ConnectionGUID: OEj9vKKESNK4kDZOXrO0Sg==
X-CSE-MsgGUID: ct1stxGiQUGSeO45a0h//w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="68859979"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 13:35:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 13:35:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 13:35:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 13:35:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAZTIAlpI5MjElyxxD2teN2E2jomOTZqS/rFONx0ABNWU98BeCrJ+FkdWedBA2Rt9ShCN0RlfNOCnijiOF+/9sQV3b9WsdX+jg1SfsXlLQGtN/gQo/O+LeUqGbA+EGHhYXNUAhv3fLXOEe9VUG+9MDbfGE4OulvU8atTW4wI7dO9tcE19/anWWgD8yymDPq6Bk0xuroUwJL7Npntk8XKc7IP+zpsgf7zVfDiFmygc2jbUOpmp/nz5a0DNeevQKEsINvRsdTWxd7gFSCH7LLK4nZIF+jv2eLD3HoW2KNqe5hTcd3GTZAGssVW2OBOlybHxb29yvHFvztJ672j+7d0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPnZTUk+u1a5w5A+2PUczp2cyFi8IKYjf9TFTG7G/mg=;
 b=F1HYcJwbO55ANUqGUSt2p81RGZpH00lWbOsge/KwdJfyvTAaPr3hm9stdkzn73+RIFplPTmgAw3UPZbb6+qXHCHM4W6DUTBAs4jZ9zqIF7ttmus9A/Q6GRc0ZDhqCRp5g8Xz2X7FDHXcHwElBKxSM7U4O4vMWe/2agSMYJLiJ3v5iohzhnSCWyIvHkPbKSqMNMx4pDEKmoEoKCTxuQESzYWvZXSV/G47/AdiRSmK7TIV3n853XrublMSVqpIR6SkgBDwV0IADRTev9pslargJqvvb0Tsc/Rbn4bI4e195jtLW9EEDUSAXiHDK95Qg2TEZyyqCRNSLIcvKD6fxbhWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB4975.namprd11.prod.outlook.com (2603:10b6:a03:2d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 20:35:41 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 20:35:41 +0000
Message-ID: <009f97c6-c7d1-46b3-8595-88caf7e65dff@intel.com>
Date: Wed, 5 Jun 2024 13:35:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Fix VSI list rule with
 ICE_SW_LKUP_LAST type
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20240605141744.601582-2-marcin.szycik@linux.intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240605141744.601582-2-marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:303:8d::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5afb63-d6c7-47ae-6be9-08dc859f10fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3AvTjZMNU5XaUV1UWZ3TzFLN25GbTltaFBuREFCL2xSdmZJclBlNjF2UjVK?=
 =?utf-8?B?R1Z4M3hibzZjYVhJb0hNcGE0Ty9iWUxhNVViaEQ0U0srNlQ2Q3dzUTZqMFFE?=
 =?utf-8?B?dkZRZTA2SVBhajRpVko3VGQyNDFzcEQ3OC9aMi9hczFBM0xGdEFzbDY1OHpB?=
 =?utf-8?B?SGhxZXlYNGdCcHZlYUI0UkpITnF3VUNmc2NDbkZEdkdtOGY0eXh0dnZldlEv?=
 =?utf-8?B?aVRMb0dUd2I0K0M0ZDRHSk1jZjZHYk5OOE5pbEE4SUJFVllRbWlCSFZYejVh?=
 =?utf-8?B?dGZsZDlMeVVHd25waEJmbXFCb0tzYTJMc08zSnJlSnBtTXhQYVl1R251NXZS?=
 =?utf-8?B?MEZ0TlVjKy9Kc0tzeFlLMFpUT2hHYmhaUVFQVmhEU1BiVU9QNFlFWTc5ZWxI?=
 =?utf-8?B?R3JJcEdaOXIxN1o3QjYzVFpqTUswSkl4WjJqaitrMEUrVTVzbkhkNUdvRDdE?=
 =?utf-8?B?eTR2WnJGU2l0MkJoZEFuL1FpbzNwaVRpVmZpYTFYRGdmT3g5WXBRU1N6b00z?=
 =?utf-8?B?L2V2a2Yxa1JzQWJocUhzSEF2YTZweUZGbUlxUlowKzY5ZE10R3JabHJrQ1hL?=
 =?utf-8?B?aW8xWFBtOGl0N2NXUDFrclEyYmtBbE4zZVI5Zlhaa1dtWVAxTEFxRkM2RWRT?=
 =?utf-8?B?ajdlU2E2b25wQXZPOVVjb3RNUVhkcElMcWk1bXptWFl2VDRaR1ptb0QrcUFv?=
 =?utf-8?B?YTdzZ29NWU1Xb1hXSGhYUmJ1TkwxWkNGMTN5OUVScjRWb2o0VUpHakVIdStI?=
 =?utf-8?B?WnpRYjJrWEtVV2FKRGZ4enlCcUozWm9ZaGUzV2toK2pEMEwrZytSOGRDVlZn?=
 =?utf-8?B?NDc5bGYwWVZIMzJSczFVcEhwaUhVcnVCTi9hM21Vait6Mm4vVEhjY0hMMUVN?=
 =?utf-8?B?TS9NcjJBbGpxYi9INlhmVlAxN1BvdmFYKzFxY1ZKclpZTFBQWERLQXgxb2JB?=
 =?utf-8?B?citYcmRlZzRnUm44eE1XSHY3cERaTVVuRDhCeUJoV2N1QmJrRThPTXRTZGNr?=
 =?utf-8?B?UHpyN2ZmaE42QWsyaGRsdzluN3JxeGt3cFp2NkVvblNFZ1B3NkgralhTN0Yv?=
 =?utf-8?B?TCsvL3Q3MkxNMEVLaHR2TkM4RTEzREtkeWRpTXhKMXdDRmVNSFppYk9UVmNp?=
 =?utf-8?B?dU1CblZMUk9RUWwzeXFZRzVkcGNZS05KWFZHZkVMbVVjN2RwaEdJTS9FNVFP?=
 =?utf-8?B?TlBlUTRxNzdUSGFpQkxkTUhvSllKQ2R5SEJWYnE2MlJZekpKc1E5YlMxcWp6?=
 =?utf-8?B?djl5eXdEK3gyeXlMQVRTaURJUTMrM0JHNHlCclRHN1lQRC9tVm1kTHhhQ0M4?=
 =?utf-8?B?M1dXWExCZEkwTUErNklkdVhmeDl1Z3IwSjMrVld3eHUxdURxYWRuZ0R4bTM2?=
 =?utf-8?B?MGJRVXlucnJXY00yOWdOamFuU1FYaS9BRHBqaC85S08vams4QlY5bko5dzVt?=
 =?utf-8?B?c3NjbG1GeEc4UUNncFVWbFFMMFNiZDJwbTNrUWpvKzVjT1llUjZYTkhYOTZC?=
 =?utf-8?B?T01oUzRXdUR2bzYzZDFDMCtQZHowMUJuckg1MmthMHRVZENWaFV1Nkd4dEFm?=
 =?utf-8?B?MFZ1bk4yZ3lmSDJ5SWdiblVYanpIVVZWWDBFTXJpd3B3M1VONnZwQ2RtZTRI?=
 =?utf-8?B?cllmUEZ6UWdJeWF0ckxaNWdxOWdUTm1ZaG9zM0xqVUxDV0tXS2d2TytETVNS?=
 =?utf-8?B?WjV2YnZDWEVpUDcvb0N6MWpVNHJabzZkOW5DcTRsREo5SjVHR3BFME53PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck14b1dBTytpVWw4aXZSWFR2V3FabWtNQytFRlVEWXhMRmw1d1JrcnQ1Mk9W?=
 =?utf-8?B?d0FSNGR4WUNjWXZXbU5aUmpGdzByVDdvZVZMcVJuTTQ5enNXeENuYXEwTWlp?=
 =?utf-8?B?bWpSS0ppcW9KSXF0QVFsT3k2cnJLSGpXS3QzdlQvZStzODg3ZzVta2pvTThk?=
 =?utf-8?B?R0F6azNpdlNuZHlWNzNmOW90L1QwYkVRMGd1Z3dKdzd1U0QrUzByeFByRWpS?=
 =?utf-8?B?MW9tWlJsQW5MU2VudjlORGhFcFpRT0VnSGZrNStvNHRMNndVZktEdGsvT2dx?=
 =?utf-8?B?aFZKbldIZlIrMXZiWGgrNFFsNmtsRHJDbURhZG5tUmtPRXVxY0lZL1Vzdmw3?=
 =?utf-8?B?bkx0enVUMW9WWHg1cGdCQ2VoVTlKU3JBY0VzNDQvRmhDQ1lzOTc0bXI3dHdN?=
 =?utf-8?B?YVpkQ1M3OGE0d2lwTVdhb2xKcEJyNVowdGxQNENoOURFM0traUYrSWNMR0F5?=
 =?utf-8?B?elF1MzdXWHlRZnJXVVdJd3l3a1hFUng5M1lFZ28ya0pQYzZJU2dCMm5kL01t?=
 =?utf-8?B?WDZ4Nkhob0QzaWdOZ1d2WnFEL1V3cXI3ekQwTnEwNXU5ZXo4VDJOSXRXc1Zu?=
 =?utf-8?B?bUF1clNtUkJLZFY2VWpGdjVXdDNzVC9NSGxrNGlkRisxWFpJV1RUWnJaKzM1?=
 =?utf-8?B?ZjM1Z0J3aVFkSjJjR20rN09ScUNFVVFNZW5zWmJKdXpFSTJwRFM1YlFpb0M4?=
 =?utf-8?B?cXlOR1NVVmhkT2RCYkxSVFF0STMwS0ppN2xtTGY1NEtqempCTWd0cnZSQlFU?=
 =?utf-8?B?M1ZZOXJmZDBhakFwa0Q5M25IejhIS0QreENGRUhpMnBjYmhaeWN5dWxmV01h?=
 =?utf-8?B?YlduOTVSQWt1TUNpY09vK0QrZDhmNGVCLzNObDZhNGpMcHJxS3NJaXR1LzZu?=
 =?utf-8?B?YXFPMXZTYVJFZ3pPUnVOQVM1am1jd1NSZFFIYmQzdHdtallOek00SlFNWTdy?=
 =?utf-8?B?UXRUYzErMlJtRndJNHZUQXR1ZkRzRUYzalF0VEtIejlUTFZaYVVpUkNGMkF4?=
 =?utf-8?B?LzNaTDhzTlVTS1BnNHN5S20vQ3l5bGczaFhTTnhncTJqMmJ4OTR2L2xMcG0z?=
 =?utf-8?B?bTYrUEdMWGlPckkzMGI3aFdEV2NOUDFZenl5bXVkVzFGaS84WFdEMFlnOW5G?=
 =?utf-8?B?TXRHNjNrSjhpSmFrbm13QW5nOEIrNWFIS29tOWwxZlJ2clhhc01XUll2Q0lw?=
 =?utf-8?B?Um9HeElCUmxOQitnOTEyZ0o4WVl6VmRQV0xLdEhOSURkNEVINXZTc0hTbHg3?=
 =?utf-8?B?M1pBMmg0MXF2YkxZdUtXQitWTWQ5a3VQbU1TU056bW9jY3JReUYwQWxhSWdT?=
 =?utf-8?B?ZlloaUNWcVFnWTJsRCtpbHFrcWNWTldzUW5nZnBraDJHMk9DalZXVytHcVJD?=
 =?utf-8?B?TmdiQjNjZDF3c3g3RnBrUHJjV0pXRXl4LzMvTi9MZ3NGWkdiUWJRUjJuVUJW?=
 =?utf-8?B?Nm9RWTBQUVBrSm5ocXZCNTgrY3YyaVE3MmtxejNMZHhWR05uVHpDOXk1aUk1?=
 =?utf-8?B?cmYyUU1sMU5CVE9JYyswd0dFTnkyNnRla3poRVZ1cldtTXBxS25GcW9DOG9m?=
 =?utf-8?B?b0VFbi9LRU5jN1c5ZUtuZ2hFaEpkM1ZGWFNOWkdTNlFqWXcyTzVHOG5iWjB0?=
 =?utf-8?B?cDBFYXlxamhJZnQzSDRiQ1J3YytkNWVuQnByMnRFbmZEMDJDa3huVnJ6MXJF?=
 =?utf-8?B?SlIwUithOWJzTjNqNGxMajJXRVU3ZHViNDZhN0tlbmdvUlA1eE5jbmxpbExi?=
 =?utf-8?B?MDlhQUFuVHBHUnFwTEs4RGpObTdyR1ZkMWREUEE1MVJyK1ltdDBLNnlGQXgw?=
 =?utf-8?B?UFBRVzNkb25yR3BYVVp6eHhncTN6dFJqQkpucXJ4V0R0OFg4bW9COTRHRjl6?=
 =?utf-8?B?VHcwZENDUkJ1WDNGaEt5eUlnejh1elVSYzRZZUJMdEhMdkZXNmpjQWdYdVZ4?=
 =?utf-8?B?Z1dGb3g4clJjWGlvYlh3czhUYTFHdzlCdlZ0STFETUx5RkMwZFEwRzdsTlhB?=
 =?utf-8?B?SjEzUXNEV2h1cTBjVEN3TmtiSVJXOHdRMWdzVGoxUDk4K3FYYW5BSUIwTjRM?=
 =?utf-8?B?T0VPTGtoSi9FdDVwamF2eUVSaUtJU2l3bjRiM2lDRlMvd0tIa2FhdzVLUCt2?=
 =?utf-8?B?Z3FvaGt0RXVIS1BGSTc1d2JKL3BqZTVNMllmN1NXS2NRQUEyUkp1c0MweWlF?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5afb63-d6c7-47ae-6be9-08dc859f10fe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 20:35:41.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7/d6Gc4dUWDhn7/Re7qgTF3W7E1/+vH7oBUU6FIoumh6JilEZuNlfJqzASQnsEuW3mXYhH13RaDxtq8UmGzSZ5rOAGs0ZSeCXF0z2yfn9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4975
X-OriginatorOrg: intel.com



On 6/5/2024 7:17 AM, Marcin Szycik wrote:
> Adding/updating VSI list rule, as well as allocating/freeing VSI list
> resource are called several times with type ICE_SW_LKUP_LAST, which fails
> because ice_update_vsi_list_rule() and ice_aq_alloc_free_vsi_list()
> consider it invalid. Allow calling these functions with ICE_SW_LKUP_LAST.
> 
> This fixes at least one issue in switchdev mode, where the same rule with
> different action cannot be added, e.g.:
> 
>   tc filter add dev $PF1 ingress protocol arp prio 0 flower skip_sw \
>     dst_mac ff:ff:ff:ff:ff:ff action mirred egress redirect dev $VF1_PR
>   tc filter add dev $PF1 ingress protocol arp prio 0 flower skip_sw \
>     dst_mac ff:ff:ff:ff:ff:ff action mirred egress redirect dev $VF2_PR
> 
> Fixes: 0f94570d0cae ("ice: allow adding advanced rules")
> Suggested-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

