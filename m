Return-Path: <netdev+bounces-281533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLDaDo3s72mjKgEAu9opvQ
	(envelope-from <netdev+bounces-281533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:09:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6740047BB6C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47E69300B748
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B583AA182;
	Mon, 27 Apr 2026 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgjLA9G1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5443AD527;
	Mon, 27 Apr 2026 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777331338; cv=fail; b=thhUFMeg9GZwaPaBzOM8OdaOg/nBAtKVlRijjBHUFRAwywChIh+aGcJ9ljd1TTKqR6mKSoP0qwVcbw/gdZekinpKmRspmQmJJOLxPzOcmmbjyb6HtgJGy8kZj9rQcAiIafLWjgaFPi8Z5TUlE5IyUtAa9a0JoEy/7hcHJMMtr/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777331338; c=relaxed/simple;
	bh=E6875dHXjoRZMngdfMF6YCLFmA76IeyJDs/3ho40dMA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=apzzQ0d9FiPJy781oor3Mq6pmwfit20/W1yBFCQ6nAtxhw62Sw5QmV5LBfpIFVbn7XAHyjca5nTMwNK1pMKforE7dWU6Y8/ERs+P3QCMsRhEoZkgqNTjuioxEK5kdszRFRKtjcAtTq83AtxVyDxQo+lXzn9x3ekqp9Y0uGNlt8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgjLA9G1; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777331336; x=1808867336;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E6875dHXjoRZMngdfMF6YCLFmA76IeyJDs/3ho40dMA=;
  b=DgjLA9G1Tzr713mLEDoV02oZf4k8n12Gg72Tg46651kP+YKHkE0bvNaE
   a8HqFAew/qyWw5yxZXrPuUbcaeMWCwbHwIaM7PtZyQYSCmxpmjWWgkbc5
   XQMeFLP/OdbBRDyR9bDTzIPNXG9jCIkBSp9nklgczqMGG1LEMWA7ewPvY
   Jyoop4QSHyEfp95hVe0iqDbJTB5gcg4xT8Iu3T+RKzMej+mOCM2vEY5mx
   3Orso7zAcfg9ZN10YBsUR62mT2LyLI3RF9RcpeA7fhKguRYYmXypsGUDg
   vUSL4TUCGufTjYexujJuSKqwHuKpJZWBCb8WukfCDGqqo60R8oGj9tV81
   Q==;
X-CSE-ConnectionGUID: qzppKbHySturM0vK3EtU2Q==
X-CSE-MsgGUID: zL8bPOP6Q/qePRmTmwElaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="65763653"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="65763653"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 16:08:55 -0700
X-CSE-ConnectionGUID: jPwSBYzKT423punZH03/dw==
X-CSE-MsgGUID: 4yJQagHnQumQG5VUCdkSfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="257310942"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 16:08:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 16:08:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 16:08:55 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.46)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 16:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzW7C7k7YnGGWJIX1AqR2dxekOjmc6dB0bHAHDvXuY7EFuy5yu2IGoe3oJXP+tpZo9Q5EYhCvbNbZcYv0ajzbfF2p4SdIQNcdNvvry/TAEkxwlFALrIINbnAWHcvcsQ3f+/y3aDSRlDaN2pJEXjVv1BHHqaZqx+yW/PdJf7zxgALOtqCJeqvptmsRLokE9z16qNLFnAsOM2Vy7OghpkXx9ZjjhbB/Qlep31wnKqHTL5jxYpSHXWoz5lAB3KUf1lbyrtp1T3GGYJMgj2EsBwkY9sKE1vi2/Pck5Upd8dd1ky8TzimaewI9q4fnxMKfHfmZDUsqTeXxC1tOIGDeBGZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6j9L0GQ2bBK4o0luKgiuaVpnsLhfDGvEpb4k7g/Rks=;
 b=JSf/i66o9uAjqU5AUMv2yKISxboy4qYMBkEZNmCg4Sd6rIUhNQ40UYpZqhanmoIUkDWcTJdxds2oFBck6znSUJwsoHjfMCpIw7HmYKAMFGLPYe3tdK0lJE6eut09QPHmz2ce3iGs37ho7sUkM7S7CnNpmg/FgCmGiH7PzYv6sLY4ZODAnkjO9hqHM6UHgZTC0svd9Fs8cH9kCenD+RWzu/CWVwlY5IjsS5XCo/a2LypKG2II6cWkh78ojVUSrsSl9QJzh4MQbgBxco54o8KoEkvkbUC+RZBmlRYeKXfwrF8tXSWmOO00as/Nn1SU2d6y+mePiyB4lnJ7iI537DGY9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH7PR11MB5959.namprd11.prod.outlook.com (2603:10b6:510:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 23:08:42 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9870.016; Mon, 27 Apr 2026
 23:08:42 +0000
Message-ID: <1108c3d8-df01-4a6b-a616-87c5940d5e15@intel.com>
Date: Mon, 27 Apr 2026 16:08:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix stats array overflow when
 VF requests more queues
To: Michal Schmidt <mschmidt@redhat.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Oros, Petr"
	<poros@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20260427151827.43342-1-mschmidt@redhat.com>
 <IA3PR11MB898650A3226F812E881C1630E5362@IA3PR11MB8986.namprd11.prod.outlook.com>
 <CADEbmW0m_4p9XZZYWnX8RmYjtj1YtV2FRVygac1QH8iN8+FpGQ@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CADEbmW0m_4p9XZZYWnX8RmYjtj1YtV2FRVygac1QH8iN8+FpGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:303:16d::25) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH7PR11MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 25978703-c1c1-4d66-c8b1-08dea4b1ecad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: UdME7KfSGL/4uRPG7aTAYhv9YzKr4zdD6Dp0visd9EQuVrxTLHR6II5+VYrwehxt0G3uik813MvOYKSW804Eg8kBpUMGp1HI5kc5Q2BIv2d6JVh2GkEDPnMCJEK/zCGc2jlcKBxpHQtvnPhTkEoeHac6DCaf9HWjmv660k+/orSMIEzxnTcVur93ri9fiwwAOLfoYVlO/Vmb5kKXqLjzDGMVl2rnN9aW7yRYN8RHq7c17CykVz1WAoP5sij+xWaAG3tnhuze/TnzKm5ygvEkxszueYi2x2CEgv0010ddqnb4GRRMmoPFxYhPsl9YSzaqJitz7jw0nAQ3neKO1PKFd3uW26HuLJCTuujL2pc4P6eIXoiGFwn/8VOtzrxxRyvI9jsb32LBKXM7PhS4iq5/SPxxqqANC4aFYl6FUR6fOczAGj+TNN3oEBq7A5uXRq/nX0tb7JawHnMadVmLjRjayXotSKDOF6B4YvUyf4nt7WcbLw1x4b90fcSEe3755pEldrL9ebnrX3n1SuvqSytlynVbrrXL5IXrByBqcQJWgC4FQ6ShBQS+MTdRn0487J3B91T4KmB6W7fsLiPQyB2Oh7ZOfSENyqKh25LBZpeasMEypE0ejgzRDAbXZ7dfpUJ78VwcNaRWDcY9oCiPAdo7WxaCwMwdQ39akGA5mLcHv8rSBpShZqbraXEVzKZXALcnUxjXHHp6PaecsTLatfcwoC4FZzOiIl6yn2Q28X9E+hE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0lTMnhleVdVTkhMYTdMbVlJUUhuUTVOU0FOVVR3UzJ4UVdsQjI1TzFjWlp3?=
 =?utf-8?B?dzNaTDgxQ0R2ZWRaZ21LbC9KanllSlhjdVVoMXlPM0pXaUdoWm5ISXdTYUxB?=
 =?utf-8?B?TkFoV1hZZVFxdnNoSy9HdzlvY0hQUnVNMFdUd3dVeE1tdGc2NXBZMU9EY1V1?=
 =?utf-8?B?RWNWOWtDZ2U0MXdkZy9ENG9Jc2ZLanEyem5PaCs5Nzd4b2pnUEZ0c2g1Q1Bw?=
 =?utf-8?B?Y01pZlNycW1xL3NzRHV3c1loQ2JVMWFjNnlWYTY5akFqb2VwUjdab0ZEQ1BQ?=
 =?utf-8?B?VXk3di9yR01EQlhpbjkyWEl4OHJLeU1tNE5RZ3IxMEdUZVJuT2VJL3dxdGZP?=
 =?utf-8?B?YVc5bEhFU21qYTV1ZVlqcHRDa0M5YW1mU3d3RVlOaVBUZ00yK2tQWTU3bVd6?=
 =?utf-8?B?alE0a0xzRE9wWFUyTFBmYVd6NGlDYjdLc2NPdFRWckhCRGNSTVlMMkJiZVkr?=
 =?utf-8?B?UFlJQllEa0ZWVUxqS3dBMVJTMlo2WkluQ2E2d2VJTnJoaVcreFZvM3V2R3VG?=
 =?utf-8?B?VDdRNThPV0trV24zVHhOeTdUcUFxRjAvM2NTd0tkRUNuOGRSUUc5MGUyVEQ0?=
 =?utf-8?B?Z0x3TDNPdUVLak9xUkZNOTFUTWM0c2Q3NW9MWnFiZUZpa2FYYXFNTWxhNE5y?=
 =?utf-8?B?dUxuRmxCNCs4NjZBbzMwcW93ejJ2N00wY1hEUVpYR3RUUGhRSVl2clJMNnVT?=
 =?utf-8?B?MG1Uams1UXFUUnBkclJiQVZ3aEd2cVFCeWJVZFZTbUpKRDNscHNENkF3d28y?=
 =?utf-8?B?eG5pVE15ZWFzOUVDQ0hkWGpVS3AxTWNoQVMrUms1K3BEdkV5Y2RLTlVabkts?=
 =?utf-8?B?QUVsQk9WTmxSUElnNEUwdjJBaUEwUEROb0RBZFdFVHVpdzVQSUZ0S0lnMXdl?=
 =?utf-8?B?VlJuSDFlbXR6WEVIK3p2ditZdVZyRTJjdFc1cjBybDRLd2lFOWxNS1VBa3BO?=
 =?utf-8?B?dENYODdGR1BvbjM3NjRlRGdiVXNmRzhnZUtsaTlYeU5hZlEyTzROV01WMUdT?=
 =?utf-8?B?bEN5MTJhK1hCaEFTS0dYOFRxdnNVZWwzWXhRVS9JWUFycFl1RU5DdWc2Z0Nk?=
 =?utf-8?B?UTl6dXJuSjY5bTUyd2JGWmJySStUTDExdmJkK3FtZ3I0djY0YnJ1aEt0WVpl?=
 =?utf-8?B?ajN3RkovcHhCaVZyUWFLQkZUTjZId1ZxeTR4VlZobW9QcXF6dVRMRW5iQk9S?=
 =?utf-8?B?VDhqYzU5QTc4UGNLd2NHcjhPdDExNStsVjJWZFo0ZVhKQlpBcG16L0dNUEtk?=
 =?utf-8?B?ejNyOEovQjI4dmNERFllZDFoM0hUcDFQSjU0TFdlQlF2SHZvbjhWRnpsYXRZ?=
 =?utf-8?B?SE1LN1NEejk2blpNZnlCUGQ3QlllcjU4czRKVmk0SDRMYjFlMVdLSDZJRW1D?=
 =?utf-8?B?alhQNGd0YkVGbnBwMmdEbkJyRGdseDNTTEdVL2UvT3h4aW81V1k4SXdpRDlh?=
 =?utf-8?B?UmcvT25LRUphdThqWkwwaGhDNTF0OE8wbUpCZWFxZjgrNWE3QXFtQ0RveERa?=
 =?utf-8?B?YWdIaG9DT2ZtTTRwVStDSkZYNCtNRkZrNktGeEZhcnhzK1BzWXhJakJqWkF1?=
 =?utf-8?B?VnZvUWpqWjkrOCs5SW80bnFjc2Rjb2ZQVkcwdnJ3NGN2YjVDN3IrT3piNzJm?=
 =?utf-8?B?QlRkZ043VzhkODRXWXRYemNtYUZnMTJ5ZTBHMW9wMGwxd0NOU2NneTlKOGx1?=
 =?utf-8?B?SWpEd0Nvck8vZFd4eGxDWHVwTHpNeTYrTGZBNnZIcjJIOGhVemZpTk1JS1RE?=
 =?utf-8?B?czBOWnd5UThIdUIrb25kUzdGZmNZbFptMGd2V3JnSEU0dUMvdXJLeDU2Y2NS?=
 =?utf-8?B?a1NlQmlIU0NLVnhkMHE1dTREMW5YRmdyVUp1K01oU2dQa3VWMWxwNHlraTQ0?=
 =?utf-8?B?bThKTVBvamp5U00rOUR0M1ZkMGFkMmVTeXhzbzhVWTc1NG40cW81Ujl3MGpD?=
 =?utf-8?B?Ukk4WTZEKzQ0dGVsOFY0ZDY5R1NsOFNsTFovL3Bqa08yVVdqRFpEdFg0QW9I?=
 =?utf-8?B?Z2hnVitOTkNLWFduWTNZZ1hET3hjSmozbStqU0NiVnNKblBTeHRJUkpBaW9r?=
 =?utf-8?B?OEh2WEFuZ3BPTDlYcnhkNUFiMUNtNk1Td3VnTlJueTFzMFEwRnNUaUtwMXhM?=
 =?utf-8?B?RzU1T2toTFZ2ZHMySEtlTU5LUTVPOVQzcU5IcmFaTjhLcWxGRE5YSVI3RjAv?=
 =?utf-8?B?eHZYTmVtbGEzQ1NUbGlYampBR1crYVdwLzhpeEYyeUdCRjloMHdpYmxnUjJy?=
 =?utf-8?B?VXVUWFByQ3NORElBZmRqMVBYTzNrVFN3aHRDbFRtSTNSVC9ZMjFzS0xKQ1Z3?=
 =?utf-8?B?OWg3YTZPSWFla2lWWUk0WWRtckhBbWxoZWxFUDRvMXZyZTZWY2tQZz09?=
X-Exchange-RoutingPolicyChecked: tTd7766rcZbLfiAxy6MCkaLXT+uOjSO3xEPyHCEcNy3Z7GBSpC0B62b1dSbAUohcvPl6Z3iOZCVDUEqVH4D4b8R4g7ggjJXG7VWj05AGlitWaa/hxJxpfGDhUOZwLt3LmUUvHSaCyXKHPkqo1zbpvBUvTdxzvsCv+H7pxxnsEmBJcrgKYbb3p7s1hNFPCzRr9+XKjGJp/dP4wj1cvt1wECmgXJVy6SDQWsdFaREF3EcgmewpU6d5GUC/ONvAHBXoEwJl2bxhXt5VEQnnjrEe/b5eFk85dRJblaXt0FHnSVoFM6Fkxaz9u1pb6UT9A3n9pqazF7TvI+39MjtXfokJLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 25978703-c1c1-4d66-c8b1-08dea4b1ecad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 23:08:42.4623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aK9iC1YVPl3LxLCEWSQ6zXO6PE4pTrlkZKZ24/869toWqy+Suzb4NcmXnCHouhmljUAy4F4VP/RXTrQ4EcNzZLU1lMHhImyRIzIPOFV7m1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5959
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 6740047BB6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-281533-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]

On 4/27/2026 12:32 PM, Michal Schmidt wrote:
> On Mon, Apr 27, 2026 at 5:30 PM Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com> wrote:
>> Why no Cc: stable@vger.kernel.org?
> 
> Apparently I still have not internalized the removal of the netdev
> special stable handling from 5 years ago. Sorry!
> 
> Michal
> 
Old habbits take a while to change :D

