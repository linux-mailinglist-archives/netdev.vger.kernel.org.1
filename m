Return-Path: <netdev+bounces-280642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHkuFHnN6Wm9kgIAu9opvQ
	(envelope-from <netdev+bounces-280642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:42:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C211844E14A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD275303A9DD
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8118430C61B;
	Thu, 23 Apr 2026 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IX6GCyB1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0BA30BB8D;
	Thu, 23 Apr 2026 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930132; cv=fail; b=J1bhVH3wAQ8B0XbK/V4AliKd8+zUuPmefqgk5KQnBaqPGklLo7cJzob+Dz5KGX+eVZd5sjgWbQ5IkPWtvlce+jPRPPrs5KcXtwT0y3gJKvk3cZU4SBJvfiLn7YOyLhzlPCZjlHw8U9liel3g/4kc9OJx8Nrkm0aQHh8zyY1pyWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930132; c=relaxed/simple;
	bh=QBiGdUA2pzAiAxwuv5VWcZhf7GXHggxpilSBx5GpUEE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DaHKpYEORGH+wUeQt8Z08mnElRCjA2Rpg+fvdrxsAmrQiYJjDRtgpg7uNPag5XubuMjco9AUR6yEQyxlvTTszXPwOFZpS0WU319pTEZmLFqvCe5k5USEyY7t4zdI6Uu3TA7jLZz9R4VQx/ZZUSP0u4en8mI1opA5SWqjlfu2w4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IX6GCyB1; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776930131; x=1808466131;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QBiGdUA2pzAiAxwuv5VWcZhf7GXHggxpilSBx5GpUEE=;
  b=IX6GCyB18SltFlKeabvY/WalaJcKmDwrD+7LAizhUWMjkU4UT1buoW2k
   V5Tzi/XVnRQuEtec6h8ifAXxozrF4E/ZgidphB9O7yRUQrMMP+yUbgHDu
   wqSWXg+qnOAsc7enaJu4Cn4SHnPFTLoNrT2cNa08HRAnDoHmaI9AEjCL+
   0OilKb9cDyAkZ2/OwN0rEpKYjY8yle/jUi8isOtq0/H7Vi16IBkb0Mdr8
   gHug1UNkz2gEXE5i8mBLi1zNr40hNr77VTCwsa+w+/R+z89HRT5fCTVHk
   JQacFC7P5YaTAqdg9eYGgEgfUjj//lC3bKVuE2m4OZj5+1QAp7tlz9MAV
   g==;
X-CSE-ConnectionGUID: XUplt8m+TjOEypvDJuKSZw==
X-CSE-MsgGUID: irZGQ7NrSyO6JpmPpgtJbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="81500387"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="81500387"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:42:10 -0700
X-CSE-ConnectionGUID: 6ZdsmUSIQmSoCaNZb0kxAA==
X-CSE-MsgGUID: ChHX3veYSiOBaPIVYDepsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="236576925"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:42:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 00:42:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 00:42:09 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 00:42:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0ZALWzKOZOMgJuKQDVO0z80M1HRwSlvq/gCKWwhV9b7HFPjMRpXKOrqJr2uhAdIkWU+/gZVvCVE3ksgSUneaSHqucpmdhRSUtf+aSbulEYBTS5kzfY7YUN7CO6J3ybYqvaV9BtfhODlix894WyQh6NGruRYlW733EE7F3FCdzRjJBVfDQrFk7UcgiL7dzOx2WsF0zLzA5nRgU3oFDNn4DHFuZT+2zXI4q1Sd09lBrAoePac1TZ+KobF9Hg352KezB7H+4X385nKZVCJpDXgVdlxUZEPbXaDpnvS7F0WgVmlSFncfFxs50urAe2HgkAxe2QUIvd8TYqxnezeb+MJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rq6rf1fB2x78JOlcnyOS9ncK/rO03SN3bxWrQ893KL4=;
 b=Ud3hHrI3J7ZPUIraU9aOi2C2RaVlOJvFIbwIGLxDnoODFNYB5u91vm8N8OYAd+cv06PkoKWVwt3XG1PeBTlm8s12Tpe167sgxHdjUs0534FbQUwDiPX+lLKRG/dxXgqKrCPJgNrikum/XzbZYnrPOQxn0zaMe3/ZRF+g+bYr3KUNWxkRx/UvE7rRoiw4p4hL59PaDgmghGqIQ8J6m93qd/5hP2qI/wx3LGS2vrvTxz2K2kapYkOa3ZalovkXOP/szg6sRRGJB9/H1gWENB4ohcV0aM3oe33TKLY1dng3jPZF6xbpNhJ//gVcVLpAMG3erSkdVCwL5JdQXBACkRRUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB6405.namprd11.prod.outlook.com (2603:10b6:8:b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 07:41:59 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 07:41:59 +0000
Message-ID: <1fa00801-b35d-4dd1-a229-c3a3b551e6f0@intel.com>
Date: Thu, 23 Apr 2026 09:41:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/intel: Replace manual array size calculation with
 ARRAY_SIZE
To: Jakub Raczynski <j.raczynski@samsung.com>, <error27@gmail.com>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <anthony.l.nguyen@intel.com>,
	<kernel-janitors@vger.kernel.org>
References: <aeeFh1zQqhVysvxI@stanley.mountain>
 <CGME20260422105813eucas1p1a59a07ab8c1ac0c4b7eba37d509f69b8@eucas1p1.samsung.com>
 <20260422105710.268003-1-j.raczynski@samsung.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20260422105710.268003-1-j.raczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0283.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: db70e6ed-29bf-4c5e-574e-08dea10bccf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: GtzIPLQGqtofzy0vjGRCv5KcMSYCWg751pmMRM2rnNNYbxMQoCcV9DVgcwo2fRpMfUfv+aci+o7Vbf65koGwzB2pjgfqdHl11AbSXuqW7QGxSJ6aEy+v+7zTHST8b70tDSFJ3clDk3lE11t+o7ofSDgvqjQzErFFDCt69a2bb6X+bdqUhD+JWdsH5uCQFVrn5ICBYr/7tYafslRcAvExp8pcgVREwXKUgcGNPEIIylQ/wErJ+A62kh8qjWU5WuwRBvFg+9zT7bFeEDsU+q1VIpCL9IBjy9LesAg4anMEOPRwVjeF8Sbvgl6Py0uNauod4k0UUUPURBh85RXg9r9IZRTxgqFAtQvPzgTJ0cao+V4i/56Zebf9LCC+TZm71PgPlLL0FY2WQmm99eNKqnz1Wy52FmpfbjptLlrPQSTazgfOaygUinu/5EW9p/G1VKohluAwoY50qveyqv70AUgrueW2eUgJH2iUUcDBbPnr0gDO9iRk4MMAHB767oM/k67Bski1s5OQTPRc3T+Fp82KbNeDwLMAc7t/iTAgynx1Hpp5XR9sEbKkLJ+SuoCRnxMutvw6nFx3N0D+javGxxgD5SvKrAeqB85ZMUXym6MbxoZtpTjkZgjZZKScnGoa0lFzG0SKxKmawarWInidUKLyrbkUiJpquLQ8+hNVDT/ZiZT7dyZKzbswKxc/Of49lCZNLdW/1Gx2uXY8JCii/kR4VSrxp4Myr6ilYtX+WjyAXFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2NRTld3NE5DTmY4cjM4QnJaQmxEWDlyc0FCQ3RBTVFlRktjTW0xQmVPaUJt?=
 =?utf-8?B?V1pGdllDVVhkVUs4Z2E1UFE2K2llb3FpWlZLVU9BU2F0WmhPbTQwQUI2bHRX?=
 =?utf-8?B?QVY5ZXhlSFBSR3hEY0hxL0lGeTg3Q2lGRHNwek5qdTRSY2RZdmpDcUt6R2R0?=
 =?utf-8?B?TjNKSStuTWtZaEVscEpvalRHeGJNMnVVVVJaNkRGT2RtYWtlTW1teGpVYlE4?=
 =?utf-8?B?c0YrQy9QQVNaSlo2c0lFK2MrMWFZMG53TzBUSEdwdGJZMEIwUXNFNUYzK3lO?=
 =?utf-8?B?UG9hbUJmWXc5WTI2SVVCU3F0YXNQeVlzMUwycmJnb2Y1S1pueENEb0hLdGp3?=
 =?utf-8?B?RmpPMmdnaXUvRldqYkpHdE8wTktpR29SNVlXd0hKQmkvN2FMT3dmTGJjOXZR?=
 =?utf-8?B?SGhYZ1Q2bDVJdXZqQXJIMERQWmdUZGtjT1dQU0ljVU9uYnpWOFNQWUZkWE95?=
 =?utf-8?B?L0RrZDZKcjNYTU5RTVF5cUpSUTlHUWxENXM5SHliNTJmSm5pMmxZODdSMy9r?=
 =?utf-8?B?VnVtbW1scSthRU9KWVR1THpGMTZzZitEM3l6VEtMd2QzVXlhSkJWVjczdjRs?=
 =?utf-8?B?Y2pKczZXWll4dmMyU1d1T280VWFoL1VtSlZ6eHg1SW81b1c3dUN6N1VYcFdE?=
 =?utf-8?B?ZVlpbFVWZFRnclk4ekdhQVpKeHFoSW9ERko4ZHd0R2c2OWFNNTE0L01oK0NK?=
 =?utf-8?B?VTBZUUVSa2RRYUtSMWhOY3QyQ2RsV2tyY1g3MEtzLzBlZFRnUDcyeEtjdk9p?=
 =?utf-8?B?Nzk1dUVJdHJ1K0FQeStkaUJGQjIyRUUzYi8rRW96RGJBTTFZWDBxN3VIMTJX?=
 =?utf-8?B?ZHd3T3kzQXpCNkhnTDUrSU1OMldMVHdIVWRnNlUyeHhIUG1KWG5HSnY1QUVC?=
 =?utf-8?B?N1kxQkdZSC9rbmFQMWNSUG0vL2dmcWJFZCtRVnhWZEJiZjVnYXp4L1JYblQ3?=
 =?utf-8?B?Zm5jK0NPZElRWm5Gc2N5K1ZIbXF3VGRieWl2NlA5bnpMVTIvR1ZsVzB3SjQx?=
 =?utf-8?B?MGRkRTY0MHNIa3Ruc1JucjhrT2tTY1JhT0lkWDI4VFlwRFE3SEhPcU0rSzgv?=
 =?utf-8?B?aDU1Mmg5NlRtZHo5MWN6d21tWEhrZ2hLaURYRzdJZnQxd2RkVnZMWEIrQmsz?=
 =?utf-8?B?NTFRNHB2NWpxdGk2NlkraHVPWUdTVTFLRWRJZVJrQm44REVpVHdjcmFvWDBK?=
 =?utf-8?B?d0Fpc08wVm5WMHJvaVBQZWZPbnAydHBoRjhKS012K3NQUGlsNkMrVlpLUk9Z?=
 =?utf-8?B?WkVzQ01aRURLNHZoTmF4RWJTTWJSenJkeVZhMG5oRzh6dXg1eWNjbWZzUHll?=
 =?utf-8?B?dmRpUzNoeHJ5NmJkaThMelNPZEkzYlZVZkZia2U2MUlVNjJaeW5JRk5ab0hZ?=
 =?utf-8?B?RFNMZUxlLzJRejJ5cUhvbFNSanBQc05nVFJ4TldHM2F0Mnk2WUpxeXR4eG9x?=
 =?utf-8?B?SGxsWkRLRXpLdWFYa3ZLcUJaSEd1bGZqWURJeGxFZ0ozdURqbWNrNG5zSWZ3?=
 =?utf-8?B?dWhPR3U1OEhnckFTZWE3dzhQWXJIZlNxUlRZVEdUTGQvVkV2ZHIvUmlsYWJr?=
 =?utf-8?B?emoyS05jTUIxU0JoZE9QKzRnb1NHTXozZ1NkeTY4dEsvTFVQTVdBSmNDaFl6?=
 =?utf-8?B?SzlCYXF5UVNQWEhOMGRpZHE1RmNBbDdaSk9IMUdLaW5Hbk1jdzNDUHcxOGVn?=
 =?utf-8?B?WFdRektLMk03ZlBlbURqQWd4MkdkU2V4VHpnT1JmRUR1WnYxN2RpamszWUxr?=
 =?utf-8?B?WXUvaDc4cmhiMTUyRDEvdmlEeXE2eDF4UExwQS9HY2dFS3grZjBBL2R0VVZQ?=
 =?utf-8?B?cXZUOGlsS1J4eGRubGhIWXhrM3hrVjZqbXZsRlJDcy9pQ3FyNk4zbkwxeTFL?=
 =?utf-8?B?MjRjbW9NamV5L2EyZHQrd2ljZTlQZEw3TjU4ZlZFL29JcE1BeEVJWlE2RGR3?=
 =?utf-8?B?dkxpVEthZ2xTa1dyalVPNlFzUkFvRVFlMkJtVk5GeEtjK2ZxNnhXcU5HYW5E?=
 =?utf-8?B?ZXhiRTFEcFBGMGlyQUliZHNBVXFWUjBqWXpzdlZlY2lhNnEwU0tkOWFZSnRa?=
 =?utf-8?B?Y01kMGI1anNUdWwxNDVpQTFoUkJsYU5tYnVUS0xhdWptZm1LeDl0R3VFaHhY?=
 =?utf-8?B?ZCtKTmFvQnczNjMzQTNzU2ZwSGZQbmNVbnZobmF0bVlZdndha05ZQVhjeEN2?=
 =?utf-8?B?WjB4WXBWYko1UXVHRFJuNUM0eWYwYktONVMvdDZZVDA2OTFmQ2V3eU5lTmN6?=
 =?utf-8?B?L1FlTXk5TVA0azBvM2xBdFp1bjJ4WVlGQitpZk5ZdU9TendNbUFjcnR5c3Zx?=
 =?utf-8?B?a1RaNEVoT1pVYVB2SjZpZmFwNE9Oc3RZRnJOc1JYaS9NQXdrdXA4bkkvYWUx?=
 =?utf-8?Q?Xnizne17s7o0+rks=3D?=
X-Exchange-RoutingPolicyChecked: RXsvdJY6/6zW6nMqHpOHv77v+8aW8/U8RZuRmPYDDwiGuPGODe4ebphUcFwDtmDyJywa1SGnFJHtnqNwtl54Invpb6ebkeNdSZfPh+QibjKIuJypglglEJNXG1waLY4Cuf0cqmm1ReEg2xfo9WbZHF+74Xzifkt1Arn9wyqhrM4GK+uMWK4ypi7qWdpKXSiP1ASb1Xm1JYKKw/2BWHAmn455d56jb7vorJq1Y163S787xgDITU0tb4AhsgbNblcI3HqpVEzzfBeC++AIeSbOeS4cYovP++/6WGtx66zN3pBVTyNZP/nzRv7B7sHUctUDfyrU/oCC5dlIxrLgxcypVg==
X-MS-Exchange-CrossTenant-Network-Message-Id: db70e6ed-29bf-4c5e-574e-08dea10bccf5
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 07:41:59.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXGJG/UpjgMZAkqHKjcYsiLco/IBBZ6r8chmR0WFkywkZBojzGoUA+K4M9R6oxIm+6KBwqWFIDT4RiXmGIXhEUxNGrC38JywOEFRz1S3lZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6405
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-280642-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[samsung.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C211844E14A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/26 12:57, Jakub Raczynski wrote:
> There are still places in the code where manual calculation of array size
> exist, but it is good to enforce usage of single macro through the whole
> code as it makes code bit more readable.
> While at it, beautify condition surrounding it by reversing check and remove
> unnecessary casting.
> 

thank you for the submission, please find some process-related feedback
from me

for future submissions for intel networking please target IWL (Intel 
Wired Lan mailing list)

patches should be split into per-driver changes most of the time

please don't set "In-reply-to: v1" to v2 - just send as a standalone new
series (but link to v1 in changelog)

this is also a smallest bit above "too trivial to merge" IMO

finally this is not -net material, but -next, and -next is closed now
for PRs, and this is the only reason that warrants "v3" from you
(to:iwl, cc:netdev, after submission window reopens, ~Apr 27th)

(please collect Dan's Reviewed-by tag)


> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_adminq.h | 2 +-
>   drivers/net/ethernet/intel/iavf/iavf_adminq.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> index 1be97a3a86ce..dcf3baec7b73 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> @@ -109,7 +109,7 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
>   		-EFBIG,      /* I40E_AQ_RC_EFBIG */
>   	};
>   
> -	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
> +	if (aq_rc >= ARRAY_SIZE(aq_to_posix))
>   		return -ERANGE;
>   
>   	return aq_to_posix[aq_rc];
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.h b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> index bbf5c4b3a2ae..dd2f61172157 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> @@ -113,7 +113,7 @@ static inline int iavf_aq_rc_to_posix(int aq_ret, int aq_rc)
>   	if (aq_ret == IAVF_ERR_ADMIN_QUEUE_TIMEOUT)
>   		return -EAGAIN;
>   
> -	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
> +	if (aq_rc >= ARRAY_SIZE(aq_to_posix))
>   		return -ERANGE;
>   
>   	return aq_to_posix[aq_rc];


