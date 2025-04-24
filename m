Return-Path: <netdev+bounces-185625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE8BA9B2A2
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1837C1B87B74
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EDB1DFD96;
	Thu, 24 Apr 2025 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdEQoTPv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F2274FD8
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509257; cv=fail; b=AbTwCpyrrlQLPkHe44WwC2WMht1XDzGhj3sBAEtcht23Nm2od+7eaenFuN38BeVbDf7puDzsh8vF+megqC86TsFyzE5qqebkUxc2qiipT9x2WM8roJk57717Kx9UZW2V6ro9VQAfa4KZwYIqqzD9kStIxqQdAbQtPD3WuWHdqt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509257; c=relaxed/simple;
	bh=wr+JH1G3iREGAkomCtqbjSyHHhsrojACgVLSChMATwM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tn8b1z9D3gF9qDeoJXkMImmnedao4LhlLL7tYGbRM8fOBxcdnk4Q+rkA0rtwYdVVLeGhPD0KGec45YGoWfLaX8B90dPcZF69zU4vdLwlleIENoncFFI3X2y+yjtP/hI9OPeDqV+b/ZTGsfj/ZnJGLRK75SDs0yokorrtvMfjXO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdEQoTPv; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745509255; x=1777045255;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wr+JH1G3iREGAkomCtqbjSyHHhsrojACgVLSChMATwM=;
  b=LdEQoTPvjuS7FXwhtUDvJD6rOaQ4f3QR7iPjw89AZ2QAbWIptP9EhQb+
   0EH7x1S/ItNRU1Ya4Qp4hfg2VJvzwJSA/Js5NpigIvgsJCCco3tF2cwGh
   sh4cDxkEr1LO/Bed7keSVtdatZu5JrsOeCtD6Pu8DXcMb0St2aCwq01a6
   EIE3EqpYnMBjZEySTx1sQSR9BevbJUdTeBcKsFrR9eIdS3fK2FZlaQ1KJ
   FM1JtH/B7vxyUqRmPVgbIKyqyYBIqSw9zTJWzXn09Ch+vsIwZprrTd2Fv
   27d2vxi82UNWBTI/TBhNAvt8Yrn/mAuzU8cQLrMR3gHxQu8B+ZS3tIsJs
   A==;
X-CSE-ConnectionGUID: C8N//ICUTTmte1hHNQQWMg==
X-CSE-MsgGUID: 0e4/Gho1QP6FsWkXzKL0Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="57799765"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="57799765"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:40:54 -0700
X-CSE-ConnectionGUID: KHL6VsPSRdK0JlTEs5PBbA==
X-CSE-MsgGUID: CSl7/6B3TkKODO6ufaDblQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="155878568"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:40:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:40:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:40:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:40:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5MgtYcUGGD7b5st9mLLo+PttLMPthS8CSQqm4x94UQBqPcBUc1avJ4Wxdg6s8EZgqWt9bxfmPlwdut/SKHdamKWTOIlFnHO2bl/a2GP68CpZf7e/f1z67KDAPslq0246is4hNY9LW4daY+uDKJUXLBxoGD9nmCmXnevI4gHpFKxUdiFnlIdxBM7WuUFj027rEDtoUiW9m1LgFuCG4OL2ztuPn517YacqDulTCeyhwPyYUORjPtLlaf1b9tVboG72QpXQVqwHZ0ogx69onGOBjXHV5GqQ/QOvvARYqtJPsab3P4Vz/KCcSTnMXCfUReb6tIkIfP1Y2yhTCO6X/DIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9jQyf39TV7A7AUynM3d4h6+uCNAG2vFLzZsngrqdNc=;
 b=BSPP8LqnTV31glSqAvQxOk38RtBxS5ljH+lYAicMSFB0Br38X7RKPAAYrq1ID9vb74Bsj1vWKh0RoHQOJalujp0ybQe9mLtZNf2iqqHHnR7u1od2sF2cKpsrcTi3u7o6YyVzoC2JW1S0T6BtoxwUUkcWakivS4xAwnFTdCfqxq99JO2JGb5C6Td4X9NFsQvf/ZWCIb/VOvLIitJptG7D5MF63EB3Xv5+flHk0xo5mBUYBGw5i2iPoH9keD9UD8LFTLqUsLMJQIio6rq9KjWul5oBo+B4gpWRJDjMXCFnH3S5YKIegnSg+PFg+mB6au5Xd932j8+04VTeoQGzrhRH+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DM4PR11MB6528.namprd11.prod.outlook.com (2603:10b6:8:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 15:40:48 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8655.025; Thu, 24 Apr 2025
 15:40:48 +0000
Message-ID: <65235ebc-17c0-46e2-a684-19870b9fb99c@intel.com>
Date: Thu, 24 Apr 2025 08:40:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/12] tools: ynl-gen: fix comment about nested
 struct dict
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<sdf@fomichev.me>
References: <20250424021207.1167791-1-kuba@kernel.org>
 <20250424021207.1167791-2-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250424021207.1167791-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0385.namprd04.prod.outlook.com
 (2603:10b6:303:81::30) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|DM4PR11MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: a19930b1-8fe8-4f90-3c17-08dd8346628f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3hPMjkrRDZ5bytxMWxQQnBYdCt2S0REdVQ4Rm12WVdvWlU3VDBsaXBocUx0?=
 =?utf-8?B?YnZFa3lwSmlEeGdHREhZYVl4T01waGVrbVk3TVY4UWFZZ0FEZWg5a1BFTnND?=
 =?utf-8?B?SERmdVdOMTc3QUU1QjFPcjhIOUFka0Z3dXJYNkR3MXlXVmVXcGdBNEh6ZHRl?=
 =?utf-8?B?aDhyZlUwOWRBbExiZjRIQVc3V1RUSDRMUDdIMGhGcjRxYkt3V1JJd1VkcUhG?=
 =?utf-8?B?bHBIeXpiMExnOUZPeFExNDFRaW16Yzl3VU9LUnI4YzRuSXFyNEkzUzZ3SDQ4?=
 =?utf-8?B?Mk5YcXZuWGtpS0JlZ0U5NVB0MEtlUG9QTUY5by9kSC9ZWmhEU0hnQStlcjNj?=
 =?utf-8?B?RFFHRHVZNXZEM3ZwNDJNb2NLbEQxK2tKeUhzd00rL3U3RVV6eFpLOUJQSFhj?=
 =?utf-8?B?TTZTMjFCWGlzUE1HR3lMWnk5ZnV2VzRJczdPYURLQnB0RnNoTmRvazFzckxh?=
 =?utf-8?B?QWxGY1luRFhWREQzTzRLVzA5ZExZQkhBS2piQlEvRWRLdEhnNHdaUGdKK0R4?=
 =?utf-8?B?OFk2K3krbS9zU2pvU3A4UGgvckoxQk1QVkJpTzc2Zkk2Q3IrNkp6eVg3cGpU?=
 =?utf-8?B?V2l0Y200M0t3RGl2WEtaN1VFTkR0b2g5Z3hPYTFIVytZWFZtQjVMMEhHYmpl?=
 =?utf-8?B?cFdZMmp4WUtiVDY2NzR1Vm1TR1dIb3NIQmtiNzFCZUM3Rjk0cEdQZm1nL3N3?=
 =?utf-8?B?RDlSbkZ0eVdvT2hxUi9lQ2FoK3VQaEJzZFIydC9OZ0NPaEFrWWtwVDlYOG1V?=
 =?utf-8?B?cXdHOGN0MjQ4UUNMQ1p4bW9sSWh5SVNiWHUyVEpiWk9OaWZIeG9hZ3NydEJN?=
 =?utf-8?B?OFhmcjBhcUVoWkJxb0FGUStTRk9abHphRldKTHE4TzgrSTFWeWFJcVlHdTI1?=
 =?utf-8?B?cjFZN0lxTzBIYjdUc2JOdnB2UHZDb1dsditvL0lZbnVkMGtyenA1MW1rVHNo?=
 =?utf-8?B?d0VERithbmVFVkFqdEJ4dFpneFZpVXROcmlzdFdpTURMQnpSSGVCZzY1ZStR?=
 =?utf-8?B?UXV1YWp5WHhXQm8rQjN6NGF1cUU0amQzSi9FNTVwN1lLQ21ZVEFPbHNjOGJt?=
 =?utf-8?B?eUJmcU1TMExqQmV6MkRJY1liQitRaUNzTUdvYm5tTy9SdER6NzE5THMyY3hI?=
 =?utf-8?B?TWdRQnp4WFU0dlVDT0tTVUJGVzhoT0dtVk9xTm1vL0pKdlp2am4vUXRYWGo1?=
 =?utf-8?B?dmVPbitUL2RsQWVlS2xJUEJIOHJLUlE1akQwUjVHWklSeEJKcUZuZVY4bGFE?=
 =?utf-8?B?Mng4bkZXUUVKZXE3OVI4SHRWWE10UXZ4SHZPMHZ1VVR3WDZUcHhhWlZrR21P?=
 =?utf-8?B?UHZmc2JCK08wRWlNSko4M2FBZTZPdGhyRWZLYXRXa2JkM2dXNEZRRHkyMjB5?=
 =?utf-8?B?MkJNelhFRW9VTmpsekR1WkNNdXlBQno5bDQyUUJ2akdpQzV0VDBhUjJPeGov?=
 =?utf-8?B?eUQ0TkNnLzYrcjlBUXh5VWJ1VERBcEdWMHltOW9EMGpZeXhhZXZuZHp3cGRW?=
 =?utf-8?B?K0pkbFphNTlIVXdDUFZiSTU5V3NYb250R3ZwVUszQ3FiZmRGaVhHQVpKMFVU?=
 =?utf-8?B?Yk5SWm5DVjRXR1pGT0U3VFRGdlJRUGZSWkdEZzBXSzBxc3gvQmZDK2JxdGNB?=
 =?utf-8?B?Q0dlSDNRYWlMcG00ZHdoYnFncWlPNEZRbXphNjNEN2pUVVdYbjl4bGRnUy9U?=
 =?utf-8?B?QWg2QW8rdnhRQ2tZU3Mzamo5OUZTaTJEQnRjM21PVUtta0doSStzUUpFQkpR?=
 =?utf-8?B?V3NnWFh1ajZ3UlRMSkI1QjFERnZHSEY4YnFTb0pBMGZFQ0pjVUJzdlduZG9G?=
 =?utf-8?B?c1hjUzJwVkhhUnJ2aytRY1IyejhsdFRGKyt3VmtRZTg4UzV6M1U3ZndFbHRw?=
 =?utf-8?B?aHJaQ0J0bi9CckNTTmtGTUtXd2xCY2NwQ25HVHdyRE8ydS9oeVNSYUlxTnoz?=
 =?utf-8?Q?Lr6kIOpyH/I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clM5d2daVUFHaXM2OHdLNDRYRHFONnJpdkgwUVU4QURSeGhSR0VhMVF0ZmNJ?=
 =?utf-8?B?WEJpUjdRcE82a29wdGZtN2Rld2VXQUhuOWV3TGs4bm1VNGVGaTBDMm5ybVpr?=
 =?utf-8?B?Mm84SFl2WWI3aHBzV3F2Z0FCZ2tTNCtwQXNuendWdVJxTkpjeWFsNnNMaERY?=
 =?utf-8?B?QWhvUXV5bFFJK2d5RGs5anY4Y0ZidW5yU1IwbktOd2VvbTRVNUMxYjNoeEIr?=
 =?utf-8?B?eHExOEttdE40cjZMK1pDSmhiNkdmWVNUKzNDTTZyaFNaYkJIR05oTUY3VUJ5?=
 =?utf-8?B?ek1vSzRpQTRqVWRmVGNGcURxcjZwS04xa2lmczdtZWFhbHJJTVZBNnF1Sm9L?=
 =?utf-8?B?dU51TkpScWNDcTNraEtRMjVCLzhrdVMwT3NlejM5K1B0VWw3cERFaUUwb3ZP?=
 =?utf-8?B?ckpKd0ZSN3NaTGw2NUluV2Myb3I4dmlIcGtZTkg2V2ZtQUI2cWF6SXhuRUxl?=
 =?utf-8?B?bHFMMlVvdHF2Zk5sdXdNUm9Lck91OWlKcmlHemJQZ3pYSXU4WXlzWkN1OUdF?=
 =?utf-8?B?SVFOV0diazVlNmxsQ2piQmZ4aUxDajMrZ3BBRWZpSGgwdTBSZHFMcTNwemsv?=
 =?utf-8?B?N3gyL3liS2xvWWFQdlFveHFpbGNsMEJnNG83MjlrcDdJSEhwQ2dOYWQ5RHds?=
 =?utf-8?B?c3d1b2ZYNFdoUWFGYmhMeW1BTERPMWNCWWtIYjNxUUdFSTh6UDdjelN6K1Ra?=
 =?utf-8?B?QVZUQTNJK3lwQUtVbmFvMXJSNll1TTNoVGswdkdxekR5VzBUaHNZT28rdmRz?=
 =?utf-8?B?Zyt0S0xQL29XQTZzWHR1STBaNzVDdk1WMFV5RFlYNkIvMHV6V1pEVDAxcGhw?=
 =?utf-8?B?ZXUzcEZudERYaVZGUFhWWWFlbE10Wnl3em1IOVkvMENPQmoxNlpaUWpFWHFF?=
 =?utf-8?B?eWJCK0t3ZU9CaFhJeklFaUo4eU9TdVg4MTVuR3E1NmE0NFRldUQxeG5GekhI?=
 =?utf-8?B?SXRIZks4VXBibVRrNzkvYnB2ZGZVeDJDL1B1cjlTbEpobjhUbW1TV3B1RDlV?=
 =?utf-8?B?WEY5ZTI1ajFLVjN2R1V6TUFkb2N0bEUzTFdMLzRlRjhiL1ZhRlRsbkZkZmcw?=
 =?utf-8?B?NDE2WFQ0WXJ1NTRjcTVQSEtGSHIveU9veWUzQ29LWlM3TGh4V0dkUFRoWjAz?=
 =?utf-8?B?dVIxUGgrUkx2SVcvVkFjZlpvK20xbzZhdnBDaTVhU1NoaGNROXMxaWRsbnJO?=
 =?utf-8?B?V1ljZVc5Sk1NL2dOa3VQT2VWdHZIakxQenptdEVRUFh0L2t1VUtRYkk3WjFG?=
 =?utf-8?B?N0NyOHgxRU1XRUZ3aURhNTlVaVpubnUwVi9ERklic2t4bUtJMDZKRlRNNklN?=
 =?utf-8?B?akNsREF0RU1CZTl3eEN4Yml6SzhMNG95blg0QnE5SnF1eVB3YjEzVmFWRytn?=
 =?utf-8?B?NXBwbHZDYVRRcFphTmJHMWdmYVErK0RVUlVFVGxYNkF2T2p5ZVpzekxacWRI?=
 =?utf-8?B?MHQxVCs3SWkrQlhWTmR4eGwrRGQ2U3QyRW5KbkhHZzhzRU9hSVJYbnBHMTZ0?=
 =?utf-8?B?VWdlanZOSjlDUGhIYU5xd2tVaGNlYTNOTGsxSjJYL2VvVWtPazFpTVpiY3U1?=
 =?utf-8?B?RVF5NnA2dzJFSlhWYVNYNEdRbUxFY0RJb3NWOStLeHhEeE1oL2xJTldxN2lp?=
 =?utf-8?B?WGRFY1JUWjAxS3RyUW5KVUdubjF1Q3UrOWZ1Njljb08zU1lkZlZGQmcwUE05?=
 =?utf-8?B?Q1pxUU03Ui9XOEcraGVwcEJseEV1YXh3UDhiRWtMVzBkRDc2OVo5ZDFJTUN3?=
 =?utf-8?B?aTQraDBSNm0rSlhVbGtXNm5PTGRQemtqR2VJSmFDV0pyUG5XeHBqcnFUa3hq?=
 =?utf-8?B?d1RwalpmSTVJUEduS2V4aHZaZzJsdWNOdU9Wcm9vdlBLY0ZTRWFHNFpCbnFV?=
 =?utf-8?B?cDFkYUtHd2lZTFkvTEh0clBFSGtxNXdOczRPTWhDaktkTnVJRlhTWnBmVC81?=
 =?utf-8?B?K2VER1dSMjN6Wnc5eHUzNG1VUkhCN0czQk9nYll0anlDNWRYb3NUZi82WkJF?=
 =?utf-8?B?aGErQWYzaVIxS3cxMEV1VVhqNHZuM2tOODkzUyt5cnFFeWFGdk1SQjVPZDJR?=
 =?utf-8?B?SGJqazJvZXF0MGlqa29vOVM5V2k3ZndJZzlMMXdrUUo0QjNSQXg3ZjFWbjBD?=
 =?utf-8?B?WngveUFSeHY1aWo5RVVjSkxpNDBiNURrNGp5R25CQWdiaGNTMUhmRU50SU1M?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a19930b1-8fe8-4f90-3c17-08dd8346628f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:40:48.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1viDFfFV59NIozG5a8Q5/FoygEEdOVISqZuVnoGPQYU2b3RylEXPbPyc78Y4m6m/aw4Eb4LETLD2nDxqmbCndlo+AoB6lDP84Mzk9Np8yuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6528
X-OriginatorOrg: intel.com



On 4/23/2025 7:11 PM, Jakub Kicinski wrote:
> The dict stores struct objects (of class Struct), not just
> a trivial set with directions.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index 9613a6135003..077aacd5f33a 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -1015,7 +1015,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>  
>          # dict space-name -> 'request': set(attrs), 'reply': set(attrs)
>          self.root_sets = dict()
> -        # dict space-name -> set('request', 'reply')
> +        # dict space-name -> Struct
>          self.pure_nested_structs = dict()
>  
>          self._mark_notify()


