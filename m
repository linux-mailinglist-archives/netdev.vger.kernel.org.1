Return-Path: <netdev+bounces-100900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57228FC825
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E04F282086
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE52190040;
	Wed,  5 Jun 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJkPQN1S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1891946DA
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580510; cv=fail; b=iyWpQUqu8sq+mA8P54n3b1gP24KfOWqgasr4w+FK5ZPiMnk0+b51UEeFXxCkggjclzgu2lpn1hu/Lp7FdorK4MOLxhUF005CInlaMhyosY86y2+YWmTZO8FUWRiUpA59hNUNMTkByS0h7ltN6Luk+QgqSjr+tn3B/P9hdB9e2ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580510; c=relaxed/simple;
	bh=kah9hzZl1tq3pIMgfZudcWcqRtZ7Ve8YcdIOw2eg46U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMpALKMJGgohblxoL8xkYzm9GbHBMY+vg+qsAoD4allonPo6scQvaqdDjDfD5zq6OPxQtxwZrWLfNwPbESletu64sXcsw3MEwzoAPceJkJMkj6uuEB9TrDmVneWATmE0WClDQ4kfEyt4Eo6vH4CYmIv6G4jO/D1a7aViWGQf+qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJkPQN1S; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717580508; x=1749116508;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kah9hzZl1tq3pIMgfZudcWcqRtZ7Ve8YcdIOw2eg46U=;
  b=mJkPQN1SKtYUYcqIgvKKiCGJiU2AITB5naP1uUc+8EROX0vGGs3cq+cc
   RBu5b5ql5fwnE+ejTKeVaT2NzY0UQjqSkahil62UFJZm/NQ/VaqC4YszB
   0YNkBMz4r8klZaozdHjroYnL8LkheNx4BKWhAJafnhxvEZvimUW5BDkju
   mE6E0fwdTnVeE1ySZURG2lhfQmxZ9Rj76LkmXCMhbkXK/Ys44E+o7HKlL
   QH81ajyVMI5hZVUe5eTzq5QEfH4IyRHaOkc6HDk/kt3jE2v28pKwXIhyp
   1TV5Z0aA+Or45DGsXdmiccYXWKQMfz01ApeLKaBtzfLxza8mEexQmKtAn
   g==;
X-CSE-ConnectionGUID: i3S6ui8MT0ycJBoXFh0Xpw==
X-CSE-MsgGUID: 81RD0TVGT7iVhGJz8I/SZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14312435"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14312435"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 02:41:35 -0700
X-CSE-ConnectionGUID: bdrQBfDbQP+wESjX7wezqw==
X-CSE-MsgGUID: 7VS8UCpQQRylkY83hSMn7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42492683"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 02:41:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 02:41:34 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 02:41:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 02:41:34 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 02:41:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuDtw8iScSu+WfwQ3J5ZSk+/C9nj8ZqLKvKbNvDzhvd+0VsBZmaLEUrQgFzKsrA3HkER8F6o997Llbsta/YWmOw3m0huNGpRX5HFhpEU84kgftKyIIq85ghHjwxuhnO9Po757Aveh/C9nQ1kFJjfLlGTDK7xQjmW1jGc4D/OVdUPzfShNmhr5gGMngawrGNp6X2E6ZP37G+N8NRIjfdhRjeoLCdomVQf49tGdfYXDbf4kyq8jtBrcrc3sptgRJ2HGv+sc5wE5q0DRjUhhHWGeCtUxLi1UgG2+OJxeu0UicjfWZEj5yOXIy2ZAqcCsyI8W4dth+doeWR6IxyqcSt92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZixX5ih/ozuZ6q4lVnB3rANLUFuET4LY/SSMUvBzjzU=;
 b=iM8MGkqIvMsiFfvOUm06PkouP7/47wtFKe+/A2FESumIwq0oO4qAvAHbjhW5KhEQdKQH9dXAHrcvkvMGrG5nlkE2VWMUaLC82C22TqPcLKwiy9gKwlHIJGk6n/QHM1RDQZn9NRsNI550Lcl54EUv06Z2IQmt0OTF/ODrO8o9XzptIBTE5Frjs7TEJyBK7b2YakK8+u2tktPDrR7T83Z6FoCgmgLGCSCAcy592W/OfD0D5+i3RPtovWfUU1kTGnwuwjb19tKSrIDnSel6Va8BgIx3qGeuH0dft1G+T4AGhzEAUaKe/r3SQe4KAvzGkR0M/nUDZuy8h3WWf+P0dMPi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SJ0PR11MB4863.namprd11.prod.outlook.com (2603:10b6:a03:2ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 09:41:32 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 09:41:32 +0000
Message-ID: <056efafc-28c2-4d1f-8421-529a663499a7@intel.com>
Date: Wed, 5 Jun 2024 11:41:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/6] net: libwx: Add msg task func
To: Mengyuan Lou <mengyuanlou@net-swift.com>, <netdev@vger.kernel.org>
CC: <jiawenwu@trustnetic.com>, <duanqiangwen@net-swift.com>
References: <20240604155850.51983-1-mengyuanlou@net-swift.com>
 <3EC6B1729E82C1C5+20240604155850.51983-5-mengyuanlou@net-swift.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <3EC6B1729E82C1C5+20240604155850.51983-5-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:10:110::17) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SJ0PR11MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: a143025a-75ea-4871-ef42-08dc8543aec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEVJVXVzSjhoOXZLNVdVWVFHbHd2UU5NYmQ5QWZ3d0NrU1JpcU9sQmNaQjZy?=
 =?utf-8?B?TXF1VVFFUHhVRUwxQjkvWS9PeklZSC85NTNPYVVtaXZpUXdVaDNUYUJzSTFn?=
 =?utf-8?B?WmpDUFVDOGRyREU3NzNLQmJYSmNzVnE5QllXRGVYTllIWXE5M3VJU05HOG4v?=
 =?utf-8?B?dE5lNTR5OVFCd3hoWUVjdERRN1BaN2xOU0dFRXBPV2VRUStnWlR5azNiRExq?=
 =?utf-8?B?TGdKUWRkMy90akVMWENjUXJiQ0p5SDFJTTR4eTZwam13OFZUTW0vaXBDQ1VG?=
 =?utf-8?B?eEVQVHg5MUd2SFVrdUpRT2VRbkVxWjhpOEFkbnJCSTNrTTY2cmdXdHBlVlM3?=
 =?utf-8?B?SXJrSkVZbHhLQ0NjOUJwRkZ1WFp6TUV3STlRTWltb1RZM3pwNzdXQ0ZtUFo5?=
 =?utf-8?B?czFxc1lzYnpuSXlibHNMaFBRaVAyZ2dOWC8xbFhIWFE1SUJJZk16Rzhjc0FD?=
 =?utf-8?B?UU9vc2NVNGFWUTlYUzd6Z0pxaisvOGFnRFZsTDZmaU80TUxXU2kzR2N2aWVG?=
 =?utf-8?B?bWJtdHdYeDF5djFzSlloMzlxNncyWVdqdkNycGNZUnFraTQ3bmtSZlF3VDNJ?=
 =?utf-8?B?WTVWMkFSWTRybGdIVEQ4QWdVaXNvd2tRRVVjWjZTOHZTdjZFNURkWHVYS1Uv?=
 =?utf-8?B?ekg2alBxKzdmck9FNUNhTHJhS0tBT2hKak9tUmFJMkR1RFhzekpseVBhSkh6?=
 =?utf-8?B?MG13Wlg2UTZvRWJyUVhSS01EdFpSVGcxbm5GZURTTCtHRFdhbElmMFJseEVD?=
 =?utf-8?B?U3RVSDNHU3hqMnhwbWRUVElCcExaeUtuYS9INGJUSTV6YnFZQnlZbEFJU3pC?=
 =?utf-8?B?a2tlNW1vSUx6RndDNCtqM1BjWG4wb0oxWFFJQlMrK0gyMEl2clpvcUhxNEZp?=
 =?utf-8?B?WlkvVnV4VmVpWDgwL1IvR1VoRjVQclBnOGw3aEc0L3dvQ3ZqYzM3ZkdWbXND?=
 =?utf-8?B?R1RTUnRKS0x6OEtCQ0JWTDgyRGFnOHZVcUhPbmsvS2RRNlBnaU1KNFpsRGxT?=
 =?utf-8?B?Wk1oMkovdjM0WFJNb09RcjVrSHhpSnBERStaWkF3dXhrUXZGS2hFMTgrT01B?=
 =?utf-8?B?SnNkWWNRekFlb0w1dVQ5RzlldlFtbW5oNFN0aHhXUTZpL0ZwZjJxUDZtVDRp?=
 =?utf-8?B?c0dadFp1aHJUUG9NN2FTYng4LzN0QThMTGU3NmRvalo2bWtYM0JOaDJCSzRW?=
 =?utf-8?B?UTI0RWIrMjhBOWxkQ082R3dvcGJPY0pTNUlCR0FDNmpyUTBmM2RMS3I0QTAv?=
 =?utf-8?B?ejMvZUNJQ2dVdnpYVHZIbWwyWGYwN3ZNc2ZNTWJFNVBROTR3NWl2UmE1bzZC?=
 =?utf-8?B?eEtFTC95eFBFMjBETDNnWnIvVFlBR1ZDYXBtVTNvOVMxekZsb201S1RrTGNB?=
 =?utf-8?B?eXlibzdWZW9RSmxwWE1nTFRGdXRtVlN2NjJneEp3M0UxN0tTWlFxSHB0WUo3?=
 =?utf-8?B?ckZqeklCcFBYMkpLblh0dzh0dE94d1l4aVFHbnlmbUxoYTZVSDhaVEF6cHl1?=
 =?utf-8?B?TmNFR0hwN0YyNGVBMlBzUitWanZRZWJKTEFDYUpoc2wrYkV6L0F6NjNkSERt?=
 =?utf-8?B?NnBQSk05Qk5RdXNDRlFZeEhSRTNzSS9yRlZ6U3BseXVKbTNZamE2NGxFUHZD?=
 =?utf-8?B?SEM1aWd2Um0vZDZNWkcvb1UrYW8yYWhyamJZNVBWQnJjMmtWU3pYaUJxSTZ2?=
 =?utf-8?B?cm1NdUlORVpacDNSTVZtQUREQW5KcXFlMGZUV1ZjbUtMNlpZTUFPckFOUzhY?=
 =?utf-8?Q?+il5Jbs9IUzmCWK6hiUL+JNMK93+JASF4P2v8Ez?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkpnejF1TGxlaFF2aXpBYmlMMVlveTFpd0pEVjNSeVlkaDZrblNoUHd2N2pM?=
 =?utf-8?B?YmZnZXhsY3MyQkhzMG5qRDJRcElNNUUwb2JFd3B4SnRCOCtYSDdoc0lHeE14?=
 =?utf-8?B?dkFoN1Rpajd5T0dTME9tOW5LTVI0dHBvYkNWbGNWSnY3RitpU295UXFKajY0?=
 =?utf-8?B?OG9yZDYxb3JlSXhPWUI1ZzU5NGtCcHFBbTJCSmM4TXVHcHZFZ004RUVtM1ZK?=
 =?utf-8?B?ZHFHTG1rZENLOVlJeEJHODg2OFlvQUtPaUxCTXhpR200WXlEc0Z6QjhNblZt?=
 =?utf-8?B?N1ZmMTI2RVpIRk5jN3BidkNkWUVHd2lTWng5aUp3T1NlcVFyN0ZlSFhmVW5w?=
 =?utf-8?B?Sjdud2wxSlpZN3ZLWEF6SnBKYnhRTkQvb2VtSXAwbUJVQ2VDWFNHM0NqWHdz?=
 =?utf-8?B?SXdJWkpqNldJK2oyemo4RTJzSEUyMkdrVGVFOExyMmgzdDZXbFB1WE1tbDVK?=
 =?utf-8?B?SjR5TWhNSVQ3SFFLTnVpc3QxejlJVUF3b3pQT040Wjk3bGgxQzRCSVROdGQ0?=
 =?utf-8?B?NlRKRmV3UGVCUVVabHNCeVRMTnZnK0V5OGgzdVRGbDFnOWY0YlhwRFRMbzZx?=
 =?utf-8?B?Z3phNEE0V3ZpdUNtVDl6YW5tVXhGaStNYlAxNlcrT3dDN3kzeGprMW40UWNU?=
 =?utf-8?B?UlFIcW1OWUlVZWtqYU5lYkZMU1grc3RMV01nNmttM2JYTDRRMnZiQWdHOVJ1?=
 =?utf-8?B?a3BuNUFrZWZFV3JVdWtISlF6MzJZaTJlU20yZmhZOFN0b01halVhUjZzRFZm?=
 =?utf-8?B?eUxxbXRsMHdaUGdSZjNDd3NoRTdRUjRoSnYzaUNJbEdZVkJXeFR3d3F6bkdS?=
 =?utf-8?B?OGw4UDhZMHBwMkhiT3lYdjdjV0lNUUhEelJ2azBqeHQrZmJrNXMrYzRrVlFj?=
 =?utf-8?B?azA1MnRzb0V4YVppMTYvenUwY1pqaGJJQTVVcEk0WXdXS29VOUlXSlVsWDRv?=
 =?utf-8?B?SStLa1JvNnAzc2pmSnRSNG80djQ4WjdsQjVtcGdBS2VSdzBaakRvV2dzNXJs?=
 =?utf-8?B?QmphNEYxa05ESHk2cHZKRkt2TXZuWEJUM3RiV1luMHIvMlB3N0k4VmkvWDRp?=
 =?utf-8?B?WUFEMjN1cndVd3BKemc0T3duQndkdGdKcFRGa0tEekVBMnhVdzhwSEt4Sms5?=
 =?utf-8?B?VlloWFlybU5JNGowbktpaFFqdjk3SENRVVdER2QxdDhpK0d3RmhwdURKV2Vn?=
 =?utf-8?B?WjJBRXBybnNxTUgzQ0tOdVBJMmFDTWQ4RFNSN21sTUNjRXRoOUdlNVpQVEJV?=
 =?utf-8?B?UHlXeWp5RzhiZm9ZTnQ2KzRLcEFmaU5DTnl0dnZVL2krM3Q4d2gvZVk1cnFW?=
 =?utf-8?B?aGtwcVRLWU9nbFU0czAxWWxldzZHV0NUbEthM2pMZTNTK2xCbkdTblR3ajRS?=
 =?utf-8?B?MXpEOE5JRk5PbHRDN3FJdVN1aUtLZEZYNTNvdm10R2Q5Z3ROTWRWT2M4dlVo?=
 =?utf-8?B?MEdHMHZuNHJRcVFYS3FtZVIvR3RhNzB1dUtFOUFtUWQ2Y3RnbTVpUWVtd3ZZ?=
 =?utf-8?B?R21TUzRuUUNKSUVMVm4ycklKOUlXSWhtV1MwazZDNFYxdElVNzlQamF4ZU11?=
 =?utf-8?B?MllvbVpsdXppeWlqVDZ1aGZUSjhHYmNMeXdIVmFRNlExbkpISTN2K2F4MXVy?=
 =?utf-8?B?WU5jaUlYRDZzaThZNXJXMHkxdFdxTGlOU1BjMVNGUExDZ1hzakVTdTh3MzN6?=
 =?utf-8?B?ZTM4N3ZoOWpvQzB1Q0pSTUtQOGI1WTNZNkZJYzh5VW54MDN4Q1ZQYlA0S2FG?=
 =?utf-8?B?U3Q2cTZEcmF1dGZPcmw4bjJiRU9GbUlyRU9KUy8xT0YrSEFSSWczbDAzSExk?=
 =?utf-8?B?ZnVsZ3Y4cndqblpZY1FSdVVQNTV1czFiWEQyUCszbFVKTTM3SENjSUJ2aGVq?=
 =?utf-8?B?RjVKL1cvUk1LL1huUVE1OENqL1dlTDNrVmN6TFB5U1dkWC94T0tIOUU5TEUx?=
 =?utf-8?B?aE9jR0FVMjBoajhvclJvWVhRWDJjYU85bmtmWVZLUGpPbUFzVTM1dGRFRjZ3?=
 =?utf-8?B?SFFYc3NFdjYrWStaTE1CUkpINFFKbTM1NlExWWxmbDZVUGRqY20zQUNBcWJS?=
 =?utf-8?B?eTVhZ05GVFNib2xwdVk3KzNYYVdiSzZZTE9oMU9CWm5ub0FKOEwwbFJyMUpT?=
 =?utf-8?Q?I6dcN3HDr1U/PzG0tOqF4hVmz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a143025a-75ea-4871-ef42-08dc8543aec3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 09:41:32.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCD2X7ZyCtuyB63sODUpEoBiokTV8To1IDROL1HBWLRurTuVyraB53HCJIfFMC0jS8Zf8JXLygqQrV5jtJlxRB6lZPtHbRGWvIjg8FdsHv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4863
X-OriginatorOrg: intel.com



On 04.06.2024 17:57, Mengyuan Lou wrote:
> Implement wx_msg_task which is used to process mailbox
> messages sent by vf.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  12 +-
>  drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   4 +
>  drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |  50 ++
>  drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 725 ++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_sriov.h |   1 +
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  17 +
>  6 files changed, 805 insertions(+), 4 deletions(-)
>

<...>

> +
> +static void wx_write_qde(struct wx *wx, u32 vf, u32 qde)
> +{
> +	struct wx_ring_feature *vmdq = &wx->ring_feature[RING_F_VMDQ];
> +	u32 q_per_pool = __ALIGN_MASK(1, ~vmdq->mask);
> +	u32 reg = 0, n = vf * q_per_pool / 32;
> +	u32 i = vf * q_per_pool;
> +
> +	reg = rd32(wx, WX_RDM_PF_QDE(n));
> +	for (i = (vf * q_per_pool - n * 32);
> +	     i < ((vf + 1) * q_per_pool - n * 32);
> +	     i++) {
> +		if (qde == 1)
> +			reg |= qde << i;
> +		else
> +			reg &= qde << i;
> +	}
> +
> +	wr32(wx, WX_RDM_PF_QDE(n), reg);
> +}
> +
> +static void wx_clear_vmvir(struct wx *wx, u32 vf)
> +{
> +	wr32(wx, WX_TDM_VLAN_INS(vf), 0);
> +}
> +
> +static void wx_set_vf_rx_tx(struct wx *wx, int vf)
> +{
> +	u32 reg_cur_tx, reg_cur_rx, reg_req_tx, reg_req_rx;
> +	u32 index, vf_bit;
> +
> +	vf_bit = vf % 32;
> +	index = vf / 32;

I've seen those calculations a few times, you could define a macro for them:
wx_get_vf_index
than you could leave a comment explaining them

> +
> +	reg_cur_tx = rd32(wx, WX_TDM_VF_TE(index));
> +	reg_cur_rx = rd32(wx, WX_RDM_VF_RE(index));
> +
> +	if (wx->vfinfo[vf].link_enable) {
> +		reg_req_tx = reg_cur_tx | BIT(vf_bit);
> +		reg_req_rx = reg_cur_rx | BIT(vf_bit);
> +		/* Enable particular VF */
> +		if (reg_cur_tx != reg_req_tx)
> +			wr32(wx, WX_TDM_VF_TE(index), reg_req_tx);
> +		if (reg_cur_rx != reg_req_rx)
> +			wr32(wx, WX_RDM_VF_RE(index), reg_req_rx);
> +	} else {
> +		reg_req_tx = BIT(vf_bit);
> +		reg_req_rx = BIT(vf_bit);
> +		/* Disable particular VF */
> +		if (reg_cur_tx & reg_req_tx)
> +			wr32(wx, WX_TDM_VFTE_CLR(index), reg_req_tx);
> +		if (reg_cur_rx & reg_req_rx)
> +			wr32(wx, WX_RDM_VFRE_CLR(index), reg_req_rx);
> +	}
> +}
> +
> +static int wx_get_vf_queues(struct wx *wx, u32 *msgbuf, u32 vf)
> +{
> +	struct wx_ring_feature *vmdq = &wx->ring_feature[RING_F_VMDQ];
> +	unsigned int default_tc = 0;
> +
> +	/* verify the PF is supporting the correct APIs */
> +	switch (wx->vfinfo[vf].vf_api) {
> +	case wx_mbox_api_11 ... wx_mbox_api_20:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* only allow 1 Tx queue for bandwidth limiting */
> +	msgbuf[WX_VF_TX_QUEUES] = __ALIGN_MASK(1, ~vmdq->mask);
> +	msgbuf[WX_VF_RX_QUEUES] = __ALIGN_MASK(1, ~vmdq->mask);
> +
> +	if (wx->vfinfo[vf].pf_vlan || wx->vfinfo[vf].pf_qos)
> +		msgbuf[WX_VF_TRANS_VLAN] = 1;
> +	else
> +		msgbuf[WX_VF_TRANS_VLAN] = 0;
> +
> +	/* notify VF of default queue */
> +	msgbuf[WX_VF_DEF_QUEUE] = default_tc;
> +
> +	return 0;
> +}
> +
> +static void wx_vf_reset_event(struct wx *wx, u16 vf)
> +{
> +	struct vf_data_storage *vfinfo = &wx->vfinfo[vf];
> +	u8 num_tcs = netdev_get_num_tc(wx->netdev);
> +
> +	/* add PF assigned VLAN or VLAN 0 */
> +	wx_set_vf_vlan(wx, true, vfinfo->pf_vlan, vf);
> +
> +	/* reset offloads to defaults */
> +	wx_set_vmolr(wx, vf, !vfinfo->pf_vlan);
> +
> +	/* set outgoing tags for VFs */
> +	if (!vfinfo->pf_vlan && !vfinfo->pf_qos && !num_tcs) {
> +		wx_clear_vmvir(wx, vf);
> +	} else {
> +		if (vfinfo->pf_qos || !num_tcs)
> +			wx_set_vmvir(wx, vfinfo->pf_vlan,
> +				     vfinfo->pf_qos, vf);
> +		else
> +			wx_set_vmvir(wx, vfinfo->pf_vlan,
> +				     wx->default_up, vf);
> +	}
> +
> +	/* reset multicast table array for vf */
> +	wx->vfinfo[vf].num_vf_mc_hashes = 0;
> +
> +	/* Flush and reset the mta with the new values */
> +	wx_set_rx_mode(wx->netdev);
> +
> +	wx_del_mac_filter(wx, wx->vfinfo[vf].vf_mac_addr, vf);
> +
> +	/* reset VF api back to unknown */
> +	wx->vfinfo[vf].vf_api = wx_mbox_api_10;
> +}
> +
> +static void wx_vf_reset_msg(struct wx *wx, u16 vf)
> +{
> +	unsigned char *vf_mac = wx->vfinfo[vf].vf_mac_addr;
> +	struct net_device *dev = wx->netdev;
> +	u32 msgbuf[5] = {0, 0, 0, 0, 0};
> +	u8 *addr = (u8 *)(&msgbuf[1]);
> +	u32 reg = 0, index, vf_bit;
> +	int pf_max_frame;
> +
> +	/* reset the filters for the device */
> +	wx_vf_reset_event(wx, vf);
> +
> +	/* set vf mac address */
> +	if (!is_zero_ether_addr(vf_mac))
> +		wx_set_vf_mac(wx, vf, vf_mac);
> +
> +	vf_bit = vf % 32;
> +	index = vf / 32;
> +
> +	/* force drop enable for all VF Rx queues */
> +	wx_write_qde(wx, vf, 1);
> +
> +	/* set transmit and receive for vf */
> +	wx_set_vf_rx_tx(wx, vf);
> +
> +	pf_max_frame = dev->mtu + ETH_HLEN;
> +
> +	if (pf_max_frame > ETH_FRAME_LEN)
> +		reg = BIT(vf_bit);
> +	wr32(wx, WX_RDM_VFRE_CLR(index), reg);
> +
> +	/* enable VF mailbox for further messages */
> +	wx->vfinfo[vf].clear_to_send = true;
> +
> +	/* reply to reset with ack and vf mac address */
> +	msgbuf[0] = WX_VF_RESET;
> +	if (!is_zero_ether_addr(vf_mac)) {
> +		msgbuf[0] |= WX_VT_MSGTYPE_ACK;
> +		memcpy(addr, vf_mac, ETH_ALEN);
> +	} else {
> +		msgbuf[0] |= WX_VT_MSGTYPE_NACK;
> +		wx_err(wx, "VF %d has no MAC address assigned", vf);
> +	}
> +
> +	/* Piggyback the multicast filter type so VF can compute the
> +	 * correct vectors
> +	 */
> +	msgbuf[3] = wx->mac.mc_filter_type;
> +	wx_write_mbx_pf(wx, msgbuf, WX_VF_PERMADDR_MSG_LEN, vf);
> +}
> +
> +static int wx_set_vf_mac_addr(struct wx *wx, u32 *msgbuf, u16 vf)
> +{
> +	u8 *new_mac = ((u8 *)(&msgbuf[1]));
> +
> +	if (!is_valid_ether_addr(new_mac)) {
> +		wx_err(wx, "VF %d attempted to set invalid mac\n", vf);
> +		return -EINVAL;
> +	}
> +
> +	if (wx->vfinfo[vf].pf_set_mac &&
> +	    memcmp(wx->vfinfo[vf].vf_mac_addr, new_mac, ETH_ALEN)) {
> +		wx_err(wx,
> +		       "VF %d attempted to set a MAC address but it already had a MAC address.",
> +		       vf);
> +		return -EBUSY;
> +	}

nit: space bfore return

> +	return wx_set_vf_mac(wx, vf, new_mac) < 0;
> +}
> +
> +static int wx_set_vf_multicasts(struct wx *wx, u32 *msgbuf, u32 vf)

this functions can't fail so no need to return

> +{
> +	u16 entries = (msgbuf[0] & WX_VT_MSGINFO_MASK)
> +		      >> WX_VT_MSGINFO_SHIFT;
> +	struct vf_data_storage *vfinfo = &wx->vfinfo[vf];
> +	u32 vmolr = rd32(wx, WX_PSR_VM_L2CTL(vf));
> +	u32 vector_bit, vector_reg, mta_reg, i;
> +	u16 *hash_list = (u16 *)&msgbuf[1];
> +
> +	/* only so many hash values supported */
> +	entries = min_t(u16, entries, WX_MAX_VF_MC_ENTRIES);
> +	/* salt away the number of multi cast addresses assigned
> +	 * to this VF for later use to restore when the PF multi cast
> +	 * list changes
> +	 */
> +	vfinfo->num_vf_mc_hashes = entries;
> +
> +	/* VFs are limited to using the MTA hash table for their multicast
> +	 * addresses
> +	 */
> +	for (i = 0; i < entries; i++)
> +		vfinfo->vf_mc_hashes[i] = hash_list[i];
> +
> +	for (i = 0; i < vfinfo->num_vf_mc_hashes; i++) {
> +		vector_reg = (vfinfo->vf_mc_hashes[i] >> 5) & 0x7F;
> +		vector_bit = vfinfo->vf_mc_hashes[i] & 0x1F;
> +		/* errata 5: maintain a copy of the register table conf */
> +		mta_reg = wx->mac.mta_shadow[vector_reg];
> +		mta_reg |= (1 << vector_bit);
> +		wx->mac.mta_shadow[vector_reg] = mta_reg;
> +		wr32(wx, WX_PSR_MC_TBL(vector_reg), mta_reg);
> +	}
> +	vmolr |= WX_PSR_VM_L2CTL_ROMPE;
> +	wr32(wx, WX_PSR_VM_L2CTL(vf), vmolr);
> +
> +	return 0;
> +}
> +
> +static int wx_set_vf_lpe(struct wx *wx, u32 max_frame, u32 vf)
> +{
> +	struct net_device *netdev = wx->netdev;
> +	u32 index, vf_bit, vfre;
> +	u32 max_frs, reg_val;
> +	int pf_max_frame;
> +	int err = 0;
> +
> +	pf_max_frame = netdev->mtu + ETH_HLEN +  ETH_FCS_LEN + VLAN_HLEN;
> +	switch (wx->vfinfo[vf].vf_api) {
> +	case wx_mbox_api_11 ... wx_mbox_api_13:
> +		/* Version 1.1 supports jumbo frames on VFs if PF has
> +		 * jumbo frames enabled which means legacy VFs are
> +		 * disabled
> +		 */
> +		if (pf_max_frame > ETH_FRAME_LEN)
> +			break;
> +		fallthrough;
> +	default:
> +		/* If the PF or VF are running w/ jumbo frames enabled
> +		 * we need to shut down the VF Rx path as we cannot
> +		 * support jumbo frames on legacy VFs
> +		 */
> +		if (pf_max_frame > ETH_FRAME_LEN ||
> +		    (max_frame > (ETH_FRAME_LEN + ETH_FCS_LEN + VLAN_HLEN)))
> +			err = -EINVAL;

return -EINVAL here?

> +		break;
> +	}
> +
> +	/* determine VF receive enable location */
> +	vf_bit = vf % 32;
> +	index = vf / 32;
> +
> +	/* enable or disable receive depending on error */
> +	vfre = rd32(wx, WX_RDM_VF_RE(index));
> +	if (err)
> +		vfre &= ~BIT(vf_bit);
> +	else
> +		vfre |= BIT(vf_bit);
> +	wr32(wx, WX_RDM_VF_RE(index), vfre);
> +
> +	if (err) {> +		wx_err(wx, "VF max_frame %d out of range\n", max_frame);
> +		return err;
> +	}
> +	/* pull current max frame size from hardware */
> +	max_frs = DIV_ROUND_UP(max_frame, 1024);
> +	reg_val = rd32(wx, WX_MAC_WDG_TIMEOUT) & WX_MAC_WDG_TIMEOUT_WTO_MASK;
> +	if (max_frs > (reg_val + WX_MAC_WDG_TIMEOUT_WTO_DELTA))
> +		wr32(wx, WX_MAC_WDG_TIMEOUT, max_frs - WX_MAC_WDG_TIMEOUT_WTO_DELTA);
> +
> +	return 0;
> +}
> +
> +static int wx_find_vlvf_entry(struct wx *wx, u32 vlan)
> +{
> +	int regindex;
> +	u32 vlvf;
> +
> +	/* short cut the special case */
> +	if (vlan == 0)
> +		return 0;
> +
> +	/* Search for the vlan id in the VLVF entries */
> +	for (regindex = 1; regindex < WX_PSR_VLAN_SWC_ENTRIES; regindex++) {
> +		wr32(wx, WX_PSR_VLAN_SWC_IDX, regindex);
> +		vlvf = rd32(wx, WX_PSR_VLAN_SWC);
> +		if ((vlvf & VLAN_VID_MASK) == vlan)
> +			break;
> +	}
> +
> +	/* Return a negative value if not found */
> +	if (regindex >= WX_PSR_VLAN_SWC_ENTRIES)
> +		regindex = -EINVAL;
> +
> +	return regindex;
> +}
> +
> +static int wx_set_vf_macvlan(struct wx *wx,
> +			     u16 vf, int index, unsigned char *mac_addr)
> +{
> +	struct vf_macvlans *entry;
> +	struct list_head *pos;
> +	int retval = 0;
> +
> +	if (index <= 1) {
> +		list_for_each(pos, &wx->vf_mvs.l) {
> +			entry = list_entry(pos, struct vf_macvlans, l);
> +			if (entry->vf == vf) {
> +				entry->vf = -1;
> +				entry->free = true;
> +				entry->is_macvlan = false;
> +				wx_del_mac_filter(wx, entry->vf_macvlan, vf);
> +			}
> +		}
> +	}
> +
> +	/* If index was zero then we were asked to clear the uc list
> +	 * for the VF.  We're done.
> +	 */
> +	if (!index)
> +		return 0;
> +
> +	entry = NULL;
> +
> +	list_for_each(pos, &wx->vf_mvs.l) {
> +		entry = list_entry(pos, struct vf_macvlans, l);
> +		if (entry->free)
> +			break;
> +	}
> +
> +	/* If we traversed the entire list and didn't find a free entry
> +	 * then we're out of space on the RAR table.  Also entry may
> +	 * be NULL because the original memory allocation for the list
> +	 * failed, which is not fatal but does mean we can't support
> +	 * VF requests for MACVLAN because we couldn't allocate
> +	 * memory for the list manangbeent required.
> +	 */
> +	if (!entry || !entry->free)
> +		return -ENOSPC;
> +
> +	retval = wx_add_mac_filter(wx, mac_addr, vf);
> +	if (retval >= 0) {
> +		entry->free = false;
> +		entry->is_macvlan = true;
> +		entry->vf = vf;
> +		memcpy(entry->vf_macvlan, mac_addr, ETH_ALEN);
> +	}
> +
> +	return retval;
> +}
> +
> +static int wx_set_vf_vlan_msg(struct wx *wx, u32 *msgbuf, u16 vf)
> +{
> +	int add = (msgbuf[0] & WX_VT_MSGINFO_MASK) >> WX_VT_MSGINFO_SHIFT;
> +	int vid = (msgbuf[1] & WX_PSR_VLAN_SWC_VLANID_MASK);
> +	int err;
> +
> +	if (add)
> +		wx->vfinfo[vf].vlan_count++;
> +	else if (wx->vfinfo[vf].vlan_count)
> +		wx->vfinfo[vf].vlan_count--;
> +
> +	/* in case of promiscuous mode any VLAN filter set for a VF must
> +	 * also have the PF pool added to it.
> +	 */
> +	if (add && wx->netdev->flags & IFF_PROMISC)
> +		err = wx_set_vf_vlan(wx, add, vid, VMDQ_P(0));

err returned here is immediately overwritten, should we check it and return it?

> +
> +	err = wx_set_vf_vlan(wx, add, vid, vf);
> +	if (!err && wx->vfinfo[vf].spoofchk_enabled)
> +		wx_set_vlan_anti_spoofing(wx, true, vf);
> +
> +	/* Go through all the checks to see if the VLAN filter should
> +	 * be wiped completely.
> +	 */
> +	if (!add && wx->netdev->flags & IFF_PROMISC) {
> +		u32 bits = 0, vlvf;
> +		int reg_ndx;
> +
> +		reg_ndx = wx_find_vlvf_entry(wx, vid);
> +		if (reg_ndx < 0)
> +			goto out;

It would be simpler to just return here, no need for goto

> +		wr32(wx, WX_PSR_VLAN_SWC_IDX, reg_ndx);
> +		vlvf = rd32(wx, WX_PSR_VLAN_SWC);
> +		/* See if any other pools are set for this VLAN filter
> +		 * entry other than the PF.
> +		 */
> +		if (VMDQ_P(0) < 32) {
> +			bits = rd32(wx, WX_PSR_VLAN_SWC_VM_L);
> +			bits &= ~BIT(VMDQ_P(0));
> +			if (wx->mac.type == wx_mac_sp)
> +				bits |= rd32(wx, WX_PSR_VLAN_SWC_VM_H);
> +		} else {
> +			if (wx->mac.type == wx_mac_sp)
> +				bits = rd32(wx, WX_PSR_VLAN_SWC_VM_H);
> +			bits &= ~BIT(VMDQ_P(0) % 32);
> +			bits |= rd32(wx, WX_PSR_VLAN_SWC_VM_L);
> +		}
> +		/* If the filter was removed then ensure PF pool bit
> +		 * is cleared if the PF only added itself to the pool
> +		 * because the PF is in promiscuous mode.
> +		 */
> +		if ((vlvf & VLAN_VID_MASK) == vid && !bits)
> +			wx_set_vf_vlan(wx, add, vid, VMDQ_P(0));
> +	}
> +
> +out:
> +	return err;
> +}
> +
> +static int wx_set_vf_macvlan_msg(struct wx *wx, u32 *msgbuf, u16 vf)
> +{
> +	int index = (msgbuf[0] & WX_VT_MSGINFO_MASK) >>
> +		    WX_VT_MSGINFO_SHIFT;
> +	u8 *new_mac = ((u8 *)(&msgbuf[1]));
> +	int err;
> +
> +	if (wx->vfinfo[vf].pf_set_mac && index > 0) {
> +		wx_err(wx, "VF %d requested MACVLAN filter but is administratively denied\n", vf);
> +		return -EINVAL;
> +	}
> +
> +	/* An non-zero index indicates the VF is setting a filter */
> +	if (index) {
> +		if (!is_valid_ether_addr(new_mac)) {
> +			wx_err(wx, "VF %d attempted to set invalid mac\n", vf);
> +			return -EINVAL;
> +		}
> +		/* If the VF is allowed to set MAC filters then turn off
> +		 * anti-spoofing to avoid false positives.
> +		 */
> +		if (wx->vfinfo[vf].spoofchk_enabled)
> +			wx_set_vf_spoofchk(wx->netdev, vf, false);
> +	}
> +
> +	err = wx_set_vf_macvlan(wx, vf, index, new_mac);
> +	if (err == -ENOSPC)
> +		wx_err(wx,
> +		       "VF %d has requested a MACVLAN filter but there is no space for it\n",
> +		       vf);
> +
> +	return err < 0;
> +}
> +
> +static int wx_negotiate_vf_api(struct wx *wx, u32 *msgbuf, u32 vf)
> +{
> +	int api = msgbuf[1];
> +
> +	switch (api) {
> +	case wx_mbox_api_10 ... wx_mbox_api_13:
> +		wx->vfinfo[vf].vf_api = api;
> +		return 0;
> +	default:
> +		wx_err(wx, "VF %d requested invalid api version %u\n", vf, api);
> +		return -EINVAL;
> +	}
> +}
> +
> +static int wx_get_vf_link_state(struct wx *wx, u32 *msgbuf, u32 vf)
> +{
> +	/* verify the PF is supporting the correct API */
> +	switch (wx->vfinfo[vf].vf_api) {
> +	case wx_mbox_api_12 ... wx_mbox_api_13:
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	msgbuf[1] = wx->vfinfo[vf].link_enable;
> +
> +	return 0;
> +}
> +
> +static int wx_get_fw_version(struct wx *wx, u32 *msgbuf, u32 vf)
> +{
> +	unsigned long fw_version = 0ULL;
> +	int ret = 0;
> +
> +	/* verify the PF is supporting the correct API */
> +	switch (wx->vfinfo[vf].vf_api) {
> +	case wx_mbox_api_12 ... wx_mbox_api_13:
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = kstrtoul(wx->eeprom_id, 16, &fw_version);
> +	if (ret)
> +		return -EOPNOTSUPP;
> +	msgbuf[1] = fw_version;
> +
> +	return 0;
> +}
> +
> +static int wx_update_vf_xcast_mode(struct wx *wx, u32 *msgbuf, u32 vf)
> +{
> +	int xcast_mode = msgbuf[1];
> +	u32 vmolr, disable, enable;
> +
> +	/* verify the PF is supporting the correct APIs */
> +	switch (wx->vfinfo[vf].vf_api) {
> +	case wx_mbox_api_12:
> +		/* promisc introduced in 1.3 version */
> +		if (xcast_mode == WXVF_XCAST_MODE_PROMISC)
> +			return -EOPNOTSUPP;
> +		fallthrough;
> +	case wx_mbox_api_13:
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}

nit: space

> +	if (wx->vfinfo[vf].xcast_mode == xcast_mode)
> +		goto out;
> +
> +	switch (xcast_mode) {
> +	case WXVF_XCAST_MODE_NONE:
> +		disable = WX_PSR_VM_L2CTL_BAM | WX_PSR_VM_L2CTL_ROMPE |
> +			  WX_PSR_VM_L2CTL_MPE | WX_PSR_VM_L2CTL_UPE | WX_PSR_VM_L2CTL_VPE;
> +		enable = 0;
> +		break;
> +	case WXVF_XCAST_MODE_MULTI:
> +		disable = WX_PSR_VM_L2CTL_MPE | WX_PSR_VM_L2CTL_UPE | WX_PSR_VM_L2CTL_VPE;
> +		enable = WX_PSR_VM_L2CTL_BAM | WX_PSR_VM_L2CTL_ROMPE;
> +		break;
> +	case WXVF_XCAST_MODE_ALLMULTI:
> +		disable = WX_PSR_VM_L2CTL_UPE | WX_PSR_VM_L2CTL_VPE;
> +		enable = WX_PSR_VM_L2CTL_BAM | WX_PSR_VM_L2CTL_ROMPE | WX_PSR_VM_L2CTL_MPE;
> +		break;
> +	case WXVF_XCAST_MODE_PROMISC:
> +		disable = 0;
> +		enable = WX_PSR_VM_L2CTL_BAM | WX_PSR_VM_L2CTL_ROMPE |
> +			 WX_PSR_VM_L2CTL_MPE | WX_PSR_VM_L2CTL_UPE | WX_PSR_VM_L2CTL_VPE;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	vmolr = rd32(wx, WX_PSR_VM_L2CTL(vf));
> +	vmolr &= ~disable;
> +	vmolr |= enable;
> +	wr32(wx, WX_PSR_VM_L2CTL(vf), vmolr);
> +
> +	wx->vfinfo[vf].xcast_mode = xcast_mode;
> +out:
> +	msgbuf[1] = xcast_mode;
> +
> +	return 0;
> +}
> +

<...>


