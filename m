Return-Path: <netdev+bounces-279173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VQQXN3Bi4WkpswAAu9opvQ
	(envelope-from <netdev+bounces-279173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 00:28:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C161C4153AF
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 00:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C2A23025384
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BE834F49F;
	Thu, 16 Apr 2026 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9xOt3vj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26733F8B7
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776378476; cv=fail; b=mzNx5X/GM6OnpNsVU/Us0eiXyKUXJ6jPemooAGTOoEMAbL7Xh8BcG8bt0sky3ktQDOMbsLGMBoFFQiO3FjQ6T8e5hMNK4SDgfrfMwr2NBx4McnDB9Lm0no8fpV3CXPGtkf6VlH72m6EfXrp2AHH5c4YLVY96UdBN8/NcW2EYk6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776378476; c=relaxed/simple;
	bh=lyWqF79kKSzKSmOU6w0ZmLsNMwrvPZRenSovmagmcYM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mHOBJ9Umy2j7TqgXoR1cBQAlvc9gl6QlQ0WfMZe+7tJxlFV+dJ5Ohq583cJwRvChjl1VmLWZ6JymRtZbK1mxxEq171iAVv4ZgPcBDkwrta1HLtc9vYHgsAJe+QgJqV2xWI0pzzASvX3wt8aO/hPaIPURQ7kuZFpRxuAYZIFBQdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9xOt3vj; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776378473; x=1807914473;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lyWqF79kKSzKSmOU6w0ZmLsNMwrvPZRenSovmagmcYM=;
  b=M9xOt3vjNTsFSFtUaDi/wyWdaZkBhVrhzVMTnc19nQhosNqgm5/YCZW/
   BazxxvRczSXDkcug2bYTym3qFWwrtijsY/GSgtHtYgXYMqtg/EVD5fh4d
   X7rFn9SHQCyl6zFu+XbQQlkadz9eSdzeto5g2axmSG6ISXT67NZCRUWhN
   2cC5uH0l9ypyDDO5qKH2VzkL4ttbCG44i4Dm+5BlWkgq57+1SWD8XmeUu
   nDUec7t913ycmB+Y5sX4JNklNp1ySaMkCb2y8QISBiIqGG9ihh7k75rkU
   RaSv+3Z2yTuzIJljA00TIbGMzkT3rvIZzTVOxxcZMD8atgdlyJ37a7WPZ
   Q==;
X-CSE-ConnectionGUID: qU/8RewBTEmQmzYh3fLOfQ==
X-CSE-MsgGUID: rYfM54lrQ5KPUT+cAF/cnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="76558477"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="76558477"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 15:27:53 -0700
X-CSE-ConnectionGUID: 7ITFU2jnQjiS3kO0+0cxYg==
X-CSE-MsgGUID: AUWquGRaTs2yy25XAgvYsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="227723393"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 15:27:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 15:27:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 15:27:52 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 15:27:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rqtnz2UD8k5INS0oUcC8amMThfX4UTLCoY500zlW2nb4QWxQ3N4GVOhJfo3v+BWG57oA1Dt4IE83ecacCpD1WEkSMEqe/kMgpO9WUqPVhHhTwIEYPR5cUiYYAFfilA2vSkqL6SPopjZIbweY0EFr8VaV0339nKf+AbpM44tr1laEXMXS/8Q7WTJ4El0RwaILKKfdQUp89aVC9V/3DlPgXGrXqihve6GoICo2h+VcqMpXJNXruBIUrZw4lxwQ7U0Vd1YftuVHA/IpMu12mjlHJ46M8kWxxs7Fj7rW7CwHzTP+pZQ9e6YiuWMSQ8a8L270BOiH8NpeZnXy/UZQYIk0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYu5/aaNHeH13/3NAl3udREcef1nm4bBumw95SY+EHg=;
 b=nt0f56EDp42x0SrIzWPZDovBg1bvrDcpcA28v0p/IwqwpLcClXCW88LIu41rwMPhzDrKJDDFUAmFcXevnQTrxI2PY6bR9aa898ZzFGTiSeRyeZMDTtHa3CmaeAOu0HRbgzoHbkF4YCWzPQLGEesX3CQeJFZMgNVn+Wd6mLJ33xTWprEMyvgna+uWUVOuwwuOp78CBoIQqfvzDvbYNno1y682T18MRv9ZlFAPd4VeRD+HGx+/uUVYlO8Xk3pveFze5NBBUr82CaXhpnzLlnk+TOX30pjEljz8V1a99XRVVSQ78a+QT9RtgAh1O277VEcjLkzbTApEZ7qH/pOJBZseFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 22:27:46 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 22:27:46 +0000
Message-ID: <51e90f6d-d2c0-43ae-b5c4-1eaedf7f497d@intel.com>
Date: Thu, 16 Apr 2026 15:27:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: set supported_extts_flags
 for rising edge
To: Przemyslaw Korba <przemyslaw.korba@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
References: <20260415102511.1560665-1-przemyslaw.korba@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260415102511.1560665-1-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::19) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|CO1PR11MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e89e1f0-d675-46cd-5f4b-08de9c076297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qt/hAtr7JDz2/tgSV48yWa2vDo3rgSjKwIBe8+sLXEp1MBq6MdgOJoQReJVKzSaq13Ju/pheLQV2XCe0izNqLsLEfjqZ0q072ZqLiWUHNCo8b08bD3yVzQYlZ51N0WaJ7LjLmbWxRjORDEzcGkiUmPZkdlZAcHyMmTJWhwsjT61HjkqINKPtxyz9Pw+ijgH/PfQsdetGlKlnXNj9xC/Ek5b8N9dTQjQlMPn+Zd8cMNEfOVZRI8jhuqn/u4CnsN/eJlb+SlJi35UJW5t+jkzXJe6FiiTb18ppPoyOeQnICWAieAZ/dX3dctheztKBNNdFZJAnkJdoiAKM307HxNEMRr3487u89fZrRVvrNnkgR3dtpGtDCz3vWnx6Yzou6LFuvZ7gz1p14hu7mlF1sV8rUHcCT2zTzyXZftbmAn+qMjsxCv3deIajzJ886QDKUqENqyJZXeR7ctU8tsRAPHDkAKKylmdkD0xhSYXopOd/2wBpc0Ib0FZ+Zx1g2z8GV2P3cInJORfQqkRxhqvB148Uihd32GQYUaxtGNgH4w+RNaHDwMqBjNTBOrvv5L0+1bNd9/MWmhZqnI0/Nzn4LbSSh2cI7xqbfpinE9Uct1AvyXpDdXhXoent0P7miJtjTtfPYbGFJ5x+lf7Hjp+wnYWBru/WMOzuMdg6qqEFB9t3PTXyyhUnL+HtxSM3J+PoOfM5iP2Jx5LFZcDjzMHVn5Gre9kRxiH7SITpfD76fPSVsmQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7588.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEpQbkZ5M1lNRmRjQVU5ckpOVmU1SWduRVNPM1ZVaUlES0Zvait6TmtnajRE?=
 =?utf-8?B?SnZOc1BJNzdQUS80ZGV4dUVQNnpGRU1objBFblB2OWgxM1lKVEhTSFR1NTRU?=
 =?utf-8?B?MFRJU29IZFQ4RW5XTkp3NVhIeHZEaGNjSER5SlJjREV2K3NWUHNjRmIveFhQ?=
 =?utf-8?B?TzdHMFZJOGFZUmJ4YUFQeEprOEJISU56WXNvL3Q2V2xmOTFjaGFMajFydzJU?=
 =?utf-8?B?ZC9HeisxSmxEelRyYVhtSVQ5dysrV2RpWlozNVR4d0VzWUxWYjlDaXpWUVJC?=
 =?utf-8?B?QzVhRjRSdjJnZjU0SUNoQXlBVFNZMzVMakRKM2N1RVNvcXJoTndJREdUSEhu?=
 =?utf-8?B?S3ZNWnBBcUhSZ2VvWWRwQkFZdGhnTTJLU2E5aVdxdjJObENoTk9sdkdaUHhX?=
 =?utf-8?B?THhyOUFiYjYwS3RFbjNFamJYb0t6MFBZUGt2Nm5rSUFFczc2MGljTzRPSmdI?=
 =?utf-8?B?RExkcWNObmZoblpmaFpxYjdRenVpbm5EWXRkUnRUMnVTemlxMm4rS3QraDdo?=
 =?utf-8?B?cmJPM2k5THBaNTc1Q3BXM1NUcnFHTDBGV0lFUnJneFhrckxKQStHZjMra2wz?=
 =?utf-8?B?MnFKMzFkS2h2SjY2WGVCcDVxa293elpHSENTQm5pQVk0aTJmcVE5a21DR2hC?=
 =?utf-8?B?N3NEdXZWUHRRU1pPK1dLQWYvNGM3N09sUkYwK2poUXUvQUhrNjUxd1lPcEFO?=
 =?utf-8?B?bHFGRzZIU0JNNGM1TlhLS2twWUE4VlVjdmFacG8weDBzWSsxRUtIOEtENUlB?=
 =?utf-8?B?a3JYQ3VIVFVkdFNaaStBbzQ3OEVpZ3dLMWRPS21BODlqWHhrd2RxRE1BNVUw?=
 =?utf-8?B?R2ovaHdMNGVtNmRuSWt2QjE4NjJIdW9EcW9vS1JFOTYvZ0RwdFByWHY2dEFX?=
 =?utf-8?B?U2dhRHNadmZTWm9jNk1vTnRUemtUOE9mU0pGaUhHcHlCTnBLSkVKYkxJVlVq?=
 =?utf-8?B?aVI5RWRUdmg4U0puSkNkanpHZmtKZTdLdDV2aVNUL0xoV1A5TzEyeGc4SVo3?=
 =?utf-8?B?THBlck9vdkpNRGtSU1FQOFVnNlN3QXJwaGt5OTRxd0ltOWVIMzNXaGVQMDNY?=
 =?utf-8?B?aklTTkszVU9SY0JOWmlWaFo0WXRPZmE5cGt5czFkVlRBYWhXdFY5dTBuZlZ2?=
 =?utf-8?B?U1p6YXIrcXlzMWhCK0tpT0lqVndvTmhVcXY1UFhKSGR5VUVCSWcvMzZvem5l?=
 =?utf-8?B?VlZMOEZOT1diM3hsQkk5QS80anVvUjlYaG5wSjk4enU0ZmVpZ1NsaXN5NC9J?=
 =?utf-8?B?WmlCMmIvd0Y1K0xKZnVqN3lXS0VCRzVTQjZoenFLenB3eUlpenlkdzliWVN1?=
 =?utf-8?B?endWRjRkT1dFTTkxU3N3cHlmTk8raVovQkpleEJXQjJhOEl1VTEzMTVEc1pv?=
 =?utf-8?B?MjlhMTBpMkVtTEZlajFSc1NYNDF0TjJrSWRkZ1Z0aktMVHlEN0xFOVZvbitR?=
 =?utf-8?B?cWRmL1ZQaHpKMFVlSTN6azU2eE1DaUIvTUE5RWRoa2YxeUZpRnl5QlhHVXAv?=
 =?utf-8?B?aHEvUzhnTWNpQmNnd1FsdDB0MFNjbStvdFgzdS9ETU1nMW41RHI0bzlUL3VK?=
 =?utf-8?B?MXpZU2FFcGtjbEpRaCtqZHBuNUVxUWxjOGxUU2ppeTRGcjdRclR3a29GN2F2?=
 =?utf-8?B?bGQ1RThTNnBMQ3FETUN2TGJZMUN3L3pCbmdyWG1FOFF1Wmh6KzVlVHJmM0xm?=
 =?utf-8?B?M1ZCMXJ5dGdiNkdOODNLZW44MVdnUFMzTHltS1VEb3U0bThiamczKzNGV1BN?=
 =?utf-8?B?STkvckFwZ2dUVi9oWXVwWHJrVWdzYnFNSUp5T0R3MTFQTWR6R3dySTZnSGJX?=
 =?utf-8?B?d1Z5TlpWbndLZnVqdm1uLytXTTRmeE9OT1gyMFpkajBkb0M2VXp4aElWS2Zh?=
 =?utf-8?B?TlN3dVBJMGYvRHBtK01ab3RlWDVZdTZmd1BJT1pHVHN1OGZoNmtIRFV4QktY?=
 =?utf-8?B?U1E4THd5ZFpzRzFEMHROYmZ4VFM2Y2dYWktSNVpmMldLbGpnd1NOZ2VOOWhP?=
 =?utf-8?B?dytpckVDalBLMG1PakxXeGhNRmNyQU54d0x1TXhzUkhZYllIWnc4ZEV5ZFlC?=
 =?utf-8?B?YzVFUjcrMFM4bHZPRTc5WDRqUWhOM2IxZzJMQ0dsS0hSWXlIdlNpdE13SVlT?=
 =?utf-8?B?RFZtSUt0R21LeDlVVFRKQTc5NGMrMmd1Zy9lV3BKNzUxQTdjUUUxN24yM3Jy?=
 =?utf-8?B?VURPbVBPZTlyc2tKQithdkhRMjk0VXgxWS8wa2RIUXpETnUwankwNHUrUWdW?=
 =?utf-8?B?SjdUMjdmOFJ3aUEyWnBFOWFod3ZWeENLMjJVU3ZEOS9JbndIQk56dHdTSHlR?=
 =?utf-8?B?ZHdqVkRhZFhFUC9ydU9XcG5OMVRBbklDNGx5T292MzJXOHhhdDgwdz09?=
X-Exchange-RoutingPolicyChecked: XOGIRYncqIUu+BSyB8WcXZOu0begeljLY9WUzdpDiWtAVh3JsAnKzpgJfuVDjHnSeG+YPtLtF4OZkDSxrKGqzn0cs3MKacKyOFB8C2Kx0RD8UcPsgxDDxX6jYcAyM8bXESDocGpDaSPpCQnBN40m9Ed3ezsqFhPLGg7ZzwMKV2FdYts/Y0h8T2OPaH+2KdsZXL0coIfP9JN55VjYtpa4g+4L9Gj6uY3T7EB/nxUBRpUZWqrU0xQt2sp9paoNEsWpdQ8lJkipRxiViP7/S02v8yTAWHVmoeYRN2TzKN5irV/h78hQ8v3pz5o7DHgmpDcKCV+EWzBk22mUwOC+ODP/Jw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e89e1f0-d675-46cd-5f4b-08de9c076297
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 22:27:46.6985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xa6ImrnheY2e/KhTdmLcQ59SANcYnJz/N8Q58SUQngf8FEjyWUZSyWO1vwFtY3VV/W92s1xDQJMFblOkdOh58D0QLHhfCuyDqt+uzUjAJ1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5057
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279173-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C161C4153AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/2026 3:25 AM, Przemyslaw Korba wrote:
> The i40e driver always supported only rising edge detection, so
> advertise PTP_RISING_EDGE, and PTP_STRICT_FLAGS to ensure the
> PTP core properly validates user requests.
> 
> Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks! This is the correct fix for net, then we can update i40e to
support all modes in the future as a next feature implementation.

Thanks,
Jake

