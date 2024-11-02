Return-Path: <netdev+bounces-141245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EF59BA30C
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 00:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C4CB224CA
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 23:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1164C16DEB5;
	Sat,  2 Nov 2024 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKecdurZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D0380;
	Sat,  2 Nov 2024 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730590423; cv=fail; b=Pf0eBYqwZvh0Tta/623vHbqo98XRwC0kx9XsjeFvh9yolRwSVOi2JxTI9T7uZ6M0RitT1OsLztf8Ca+JfNKqA0DLrZdK+7+4tQN/KhTCImjKkqTNKiO/QBQB1yw/kupJrifaoFNvYmRpSUVOSd0Pcx4p1+r3amAHVR4FoCSBuOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730590423; c=relaxed/simple;
	bh=2ghv60vZhQZ8lqiS5LSOCqzvpMZyb2EtKiBtTswkBPQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K2HFK4gBvPDeXho/qJwyoyG7+4Tco1IR5YJmqVtk4V4bZaD/H/2Xxqe76sFx7VL1xFBE1B6QfM2ze/nt7GhbqDF7ATWWOwGAoHv9eT0eD16hFFPxujEEcONVQhZOXSg69t0DdzSLBOhdx1Zk+/EUTV+UnGbihv5mTTJv28Md99Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKecdurZ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730590421; x=1762126421;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2ghv60vZhQZ8lqiS5LSOCqzvpMZyb2EtKiBtTswkBPQ=;
  b=SKecdurZpyVkiqYucO3Hclnb+20GDpPdJj7S4JqRSqUnBfOSl6NC6PC2
   izcCs0SlUAOnp5D91kpA9uDfVThcsJjxb+hC8DoBc3cjmDEkqLKDsX/Sq
   q/feQis+DmmcpFgM9ggi8dUk1AyUrcV5mu4hb2Fnj3IYslEiH9VaviiE8
   MBp2xwl/MpuZvFqh26AETq63H+ES6iakrz6O0qwtjIc27D2oQqW6th0W0
   BIrG8GS9FDuKgP9uWfViivsAcHkSPzJBFfueJ0rnrMCRdwc9wnlUjuT2H
   TGJGINPXKf7U2nMH3Mp8/7JmGZGCQfflqYJBxL3vOJohfdozfFKSZjKq6
   Q==;
X-CSE-ConnectionGUID: nbWVZFDLSdWYAzwFZApKtA==
X-CSE-MsgGUID: goB0Qob3Rm2CYJi0XQMiZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52883236"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52883236"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 16:33:40 -0700
X-CSE-ConnectionGUID: gwhItoBORgmsYvbxNKwRGQ==
X-CSE-MsgGUID: PSU6kXkkSoCclLAuG3uihA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="88052460"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2024 16:33:40 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 2 Nov 2024 16:33:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 2 Nov 2024 16:33:39 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 2 Nov 2024 16:33:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AP0/spuZIC8gT+n0TZ/WGHVi15Ny4XRnY1Rb0NC6npNCEIwpH99X28Mjngrw8QCWs92iABC4pz3fuIpDhD8xYg7yj1bVWfmTTwPp74tConpCLN+N4BE0zfWnq4qsHZbA6fTnGxN6gPXWUKK+iXaVrWTWQrleVWR8mUNbSOBe+q4F0jGQaTbVm2fov6mK5oDX5TacJheilGhbijmGyYYZtgbHA0C9aoPhiQKdTca0EPzF0U+80/P6SWA4cg63fmuvmlIJeSYI66GuNO6C3AzSrCU3j2OXljV5qtdV1Pp/q+UH6+wV8vcvDyV6oosB9FMnarGMoC0ScW1laePdSEa6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnjEi/5hZwCMEfNKVmqLkEyvnkfI12itHa4Ks/CYHZ4=;
 b=cod7Dgs8likgPt6KqLbvH+iwTQ+Plhda/f/8NiiHv/gSSNtSn5BQ69hqHi82h//giR1lJwKEFuL1q7RDfwj72VZNNdzoi8p1O5QYm5AZDKTCXzKRCKNu35KxDjZ9ASA4FEDJezvfvEPanKbK/6KQPM814N2zDD+IdGVY1VpsiTNNjKygwtuoMGwB3/pCxdMaqiutMyLMQxaDBq09xTa6i0aHA3xnLMKYDpxMoOmC2HdGa6c1nYZft3yIH2vQP5Yk1OoLnG07HwtZacLnDrzyw2ZPr77yZgfFS75WjEforGhnBWscLv6bgBldDBYAGiy3ybWctTQVd/1zBLFz/XaTQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by CH3PR11MB7770.namprd11.prod.outlook.com (2603:10b6:610:129::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Sat, 2 Nov
 2024 23:33:31 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%3]) with mapi id 15.20.8114.028; Sat, 2 Nov 2024
 23:33:31 +0000
Message-ID: <bb75fbe2-cc86-4496-974c-3e437bc96c2b@intel.com>
Date: Sat, 2 Nov 2024 18:33:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/7] net: Add control functions for irq
 suspension
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>
CC: <bagasdotme@gmail.com>, <pabeni@redhat.com>, <namangulati@google.com>,
	<edumazet@google.com>, <amritha.nambiar@intel.com>, <sdf@fomichev.me>,
	<peter@typeblog.net>, <m2shafiei@uwaterloo.ca>, <bjorn@rivosinc.com>,
	<hch@infradead.org>, <willy@infradead.org>,
	<willemdebruijn.kernel@gmail.com>, <skhawaja@google.com>, <kuba@kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller"
	<davem@davemloft.net>, Simon Horman <horms@kernel.org>, David Ahern
	<dsahern@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, open list <linux-kernel@vger.kernel.org>
References: <20241102005214.32443-1-jdamato@fastly.com>
 <20241102005214.32443-4-jdamato@fastly.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20241102005214.32443-4-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:a03:100::20) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|CH3PR11MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ddd654f-cd99-40d3-730d-08dcfb96c300
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzJOZldVZGtkKytrZXBVZ3VYVnlwT09mNm84UWxOeUM2MU9TSTEzOGRidE9n?=
 =?utf-8?B?RlFYL3ZMRHF6a3FJSGFqNzJieHZlNGZkNzlwMk1vcWNlaytUVGQrYnJMdTF6?=
 =?utf-8?B?ZFF2VVNGM0N3aEpHLzdJMDhTZ1ROdVZFRHRzV2ZuakpVYlhqK0JHbVV6ZXc3?=
 =?utf-8?B?bkp3WEtpN2tpVy9hQ2tLRjBmTVBMeHNwR1BpcjBiNEwvMzFOc2dVZnlLK05W?=
 =?utf-8?B?blB5NDltT0hEc0VjRkhKc0htWkdvMXBOa0tuZ0ltWHZrNTBSQStNQi8yQzRY?=
 =?utf-8?B?bnZZbEh0U3g5TUdmbFhjMDN0Y2FRaVd2SU16Qkp5TWIwMEdERXBIYmFsSGFq?=
 =?utf-8?B?TmVSRy9QTWpMWTg3L1h3dVV0VkFJY1VVMVNPT3Z3ZVlBUHBSQlNtNXpwem4v?=
 =?utf-8?B?eExZZFpldndkYTViYjFVcXlFcWFUTXJ4N2JESHdxVW1ZMkR3MmtsUStBazZI?=
 =?utf-8?B?TCs2NnNaOWlMY2RrUWVjZnAwQy9GWi9xYnZzM3NRdzR4MWVWM1U4a0lXTU9a?=
 =?utf-8?B?aFN6U2J5Rll2Y0Q4Skx0eHJsaVQvYU5qVXlLeWttM3FLcjJ3K2QwU0ZZK1c1?=
 =?utf-8?B?NHZWQm00cUVycnZzaVNnWHNVMHAvMEI2bzZEamxWbWRNYWxoNUFlNzhKdy95?=
 =?utf-8?B?NWlxbTZ0NXZoWDB5bDZ1REM3UHV3UDBRdTV3bUR5WlZzczNiS2lRWnZuaGV6?=
 =?utf-8?B?K1NrT1JCV1ZCb2xLVVVWbXlkVHdOZ1pjNXNORzVxQjduTGhPa0JjemhxZ0JW?=
 =?utf-8?B?cEJBSHI2Zk9wRGlueUNqd0t1bnowVThKeVhVM1hJVDBWYlJyTUhxczJmeW90?=
 =?utf-8?B?eGJ2cU1UNnV0T1FEVFVkUkpkZnZydmZoMzdoYXpzZTU3SXM4KytEQnd5c0lW?=
 =?utf-8?B?enJHSHMxYmJZdVhJbTNiVCt6R2NhLy9Mbm82aWxxMU43WW9YMjk3cFhpV1lo?=
 =?utf-8?B?eHlRTm1nazNwTElJL1VMUXpmbWY3eWM3NG0xdVN1aXI0RXNNblpuMTY3QnZN?=
 =?utf-8?B?ZThDeGdBb1FGTjBHR1RuV2g3ZFppTmJFM1pENTMyaHRzNmZocjU1UGN2cnpa?=
 =?utf-8?B?NXJHQVFEdjdVMjduSXBOS1JFdUlUcXBuRmR4NFhtbk5rZVlObHFwOW1tbit6?=
 =?utf-8?B?YVR5WERTdHlWRzFZMmp0UDBoNEEzYlF6K2xvQXU4MzM2M2J1eEFnanlYVFE3?=
 =?utf-8?B?TVpSUXB5RkgzWEZqVmxaOFNsWkJENkRiRU42eGc3NWtxUm02eE1LWjNDTWhB?=
 =?utf-8?B?bzRyam1MaDJEVFZQRG1NRDlsblRIdnMzdmFucjB2dUNabjhCUDhSZ0xCRjhx?=
 =?utf-8?B?aU0vT2tDSEZMSHROS2htNHBJZjBBdEdtK0owQlN3aUk0cWVKemhKR1dXSTRp?=
 =?utf-8?B?M0kzMmtyejArZFFNK2VsaW45TUN3VXZ6bTZTeS93MHlpMk1ZTFZCWURDeGNU?=
 =?utf-8?B?dUVpdDgwenRVdjhQUnJwVGh4N2d1aU5iRHpTRi9LaFV3RlhaNkh0a3B3aml1?=
 =?utf-8?B?SHZvTnJxTXlmR0RJcFZxNklCYTc0alNnR01uYmVFOTArN1NwcmMxRGtNM05J?=
 =?utf-8?B?YzZUNEVHTnNIK0hQM3hUdVU3QTJEL3lDTUNmYzBJTThybnR0L3V0QUxzR1Q2?=
 =?utf-8?B?NlFBR0UyMGpzUE1Ld2NOdUxKckdoWXhIVm1mVFVTdTIyQ1NST3Z0SzRxbE5q?=
 =?utf-8?B?UUhHOFh6MitTN1FxSEt4aWZKRlU5TGVHbGt5L2VKeWtpR2dkNWRKS0U2ZURj?=
 =?utf-8?Q?M3Rak2+duEtFEQ7B29hpvU4upiKN120JSLPvS2Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0ZsOTFqc1BXejJRRkZ0SEZidm1kRWtZdUdSejlpK2ZjQlFtKzNGemp1MXI0?=
 =?utf-8?B?SDhObXJJOWlrVFgwb0NrYk5OVVhnMTdCdFcxa0NRNW9Tai9adGNiR012NUgx?=
 =?utf-8?B?UnNBeEs5QzNJZlcwbElQS2VHM0NJS040RGY5S3hBanJEemozY3lLTkNmOFF1?=
 =?utf-8?B?SXlqNHFoR3JENTdQenRZMTdNRkFOWHNFZUY0N2NqR24yUldrKzdZNERPTDVU?=
 =?utf-8?B?Nno5ZE9pbTBwbzkwZS9lR055TVlnZHczSC9yY2h5S1FEK3AxejZTd3R3NW9O?=
 =?utf-8?B?L1NFYlR2WTMwSlVVRFBCSmRoTUVhY2NNcENINW1qcmpEVjZCQzZOQ2ZGOUtY?=
 =?utf-8?B?U0tNc3ljcDA4Y3RmOGZ2Rk1JU0Y1K3gzMEpMQ29Ca0xlOVRuczVpVjcwQVVi?=
 =?utf-8?B?K2dVT21lbWUybDFreTdXVThvbWNjQVhEZzQvQXVyNjAzeFVhaHBta0FJL2Jx?=
 =?utf-8?B?ajBEZ0tBVkVkUjMwVDE1OWhEQjlPT2JlRmIremo0MnlROGlFYkF6RTFTQkl6?=
 =?utf-8?B?aVA3bjhtMmU5TVBWM3V3MlFQRStMUDhpNytkMlJoZEUySFh0TnpnM0Q3dlk4?=
 =?utf-8?B?SW5LRk1tMUpmZzVFNlN4eThQdGhFVUM5TU1reVJSeTZtbzhpbnBqb3hHck9l?=
 =?utf-8?B?WStRR2tlL2kydE42akNmV1lYV3d4MmNNNFRqbVg2OWxGbzQvV2lWU1RtS0Vo?=
 =?utf-8?B?NUlvbUVia014YzJCTXREb0VFMXhFSHpXdzBLM3JTV3NwMTgwcVNnZnFTQnFi?=
 =?utf-8?B?U3pvWGJ1bDRlNGFzbmtQMjNuL2h5dUlpaFd2ZGRiMlFNM1JTMlNOVktRNnVp?=
 =?utf-8?B?bGZKTkg0ZW5UdTBaVVVmSG5RQzF2OXFncmFKMEhjQzRRU1ZMZWpaU1ZMbzdV?=
 =?utf-8?B?SkFaemhJdi9UMWZadVlxbFZGdmhhNFZXcHdSMkIvd0gyMkhVWDF6bTZSQWlZ?=
 =?utf-8?B?dnhQK2p5L3JlOFRyTXRKeVlyRkxpcjg1SWNlMFpsak5zcTVPV25VU2UrUHhw?=
 =?utf-8?B?ZUx6UU5zazB6SmNTZWI0dlpRS2NlV1drNG5BV3UxNGVKU0FQUld2aHVVRnhj?=
 =?utf-8?B?MzZoMmxDL2c4dVM1MnZTakZ1K2loTTN5OEpYd0h5ZU1ydnRJY0szaStHd2Vv?=
 =?utf-8?B?czRDWGVOYmtqU2Z3WWJaTTdzUWhkamxjZ1c1bEVMUmcxZE5yVWh3d3RQTG15?=
 =?utf-8?B?SzluV29QRy9MeTFPZmxlc3RDR2ZpeG9yM0tmdW9LdGp4blZiRFBuVFJVOHdL?=
 =?utf-8?B?VFRyTEFMZEoyMXhuMVdFZzAybVN4bmVrM3BCSnNHT252VzJpWU5KL3VQeWx6?=
 =?utf-8?B?QnVRRE41VTlLckRUTEdBU2dCUG05MVphU3ViVjFpYUttTDhENTRNVHlyUVFM?=
 =?utf-8?B?aitGbVk2R2hMSUJVaXYyck5PcXp0SjAxTnRXMlgxU2ViRXdYZlNTQjRFZFIw?=
 =?utf-8?B?OTZsWUJWZStlSW1nSlJidGl1aEptaTVJUU5ncmsydXFVK2w1aHlVUTJ2R012?=
 =?utf-8?B?eEh3OUFCZmpuV1FVbW5XU3owbXRwN3JMc3NKcC9INFo2WWNWYnlQSmxtTFZu?=
 =?utf-8?B?Q2c3NWVRUWt4UjJUMzhzQ3g4bk96bi9PZmZBVzE2MDFUMjR3VVliczJQUXhL?=
 =?utf-8?B?SEVMOXZDZytBT2xVVlYzWGRSUEkrVmRQSTdEZ0hOd1RxdVdBZ2M3YWtqY0xJ?=
 =?utf-8?B?bEZVM3lPVk0wZUpaZEpIeEFQRTF2NE14YUIvYnlGMnVnOVQzcEhCZzM0Zlg2?=
 =?utf-8?B?ZnlDQmlqYW8rQmNjek5wNG9XckNhN0owOFZVSmtLanNCL0dNOS8vaUdLWGUz?=
 =?utf-8?B?b3VGaUdlbkRDM1dmY08yNmFMdXlPQWY4NEpOempodGJHMnhGNzhDSlNZcytk?=
 =?utf-8?B?cnE2SitNdFljY0FidHJlWWNqTDZicnkrWllxN1VIVE01NTd0aWlRUWJ6bFhQ?=
 =?utf-8?B?dXRKTE9DVThsVDUrR25UbXBkRW1BK25kTnU5UTV3VVFBZGV2emE3YW96SGxT?=
 =?utf-8?B?dzNjcFFNdWdWSjVZOGpBN0o0K1dNbVhQci9KMDRTVWU5eEduOGtyVFIyc1ZQ?=
 =?utf-8?B?WWNiRHNQOXpTVmNmVitISCtNZFdpMCswNFZQcFh4cHNEV1FrRzBBaXlFS1Nt?=
 =?utf-8?B?VHdqaEZNZGRlSjkrUnc5LytqVVh6cTFiakRWWkZiM0tnZFdHd3ZkSWFmdnJ1?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddd654f-cd99-40d3-730d-08dcfb96c300
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2024 23:33:31.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkNClvZvUUw8bA0KjZ82PRvcRHxCQFTQuizMJzNIrtXIBsgt6kIFPn8yXMXwlc3xa9+zG7WMVohMmScM7viPEzp+tJ5cagYNL36eC7KKQCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7770
X-OriginatorOrg: intel.com



On 11/1/2024 7:51 PM, Joe Damato wrote:
> From: Martin Karsten <mkarsten@uwaterloo.ca>
> 
> The napi_suspend_irqs routine bootstraps irq suspension by elongating
> the defer timeout to irq_suspend_timeout.
> 
> The napi_resume_irqs routine effectively cancels irq suspension by
> forcing the napi to be scheduled immediately.
> 
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Co-developed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> ---

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

