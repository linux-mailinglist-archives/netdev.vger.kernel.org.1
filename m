Return-Path: <netdev+bounces-137997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4999AB67A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 21:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D847FB215BD
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 19:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9B51C9EC0;
	Tue, 22 Oct 2024 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gu4g57pb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34331C9B9F;
	Tue, 22 Oct 2024 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624306; cv=fail; b=HVK2IWr9mlEGOR0JHXxWhWGY83u4q4NZr/ZG54EA2zv1oHebXhRtSlD5TJrkUVl4FLJuivYcmWF6PtJdre/ayhcadmy+11ULRgrhUxdpx8Qe3GZJSOuGaTgEhhltNS1d9DGmFrWTtblu1rtWCS4UOT4jBKEQ1unLMXEMK6NQsEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624306; c=relaxed/simple;
	bh=3mDk+gAqGBgOw4yB0sQsrLVgiHcMHQssPqn61VFr+nI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ozbu6Ypz4AXRLOOfUUzqZ5XPFkjAjkoZ70YlebH4Gj6+c3+d5EEIYE6Ei53D8fFC8RJMkwxycoFEJRIjVEJzy8Txv7FM4DNBVkvNGLuGjpbvgbsqEZXVyMfZKUCjh1xdC1dr8O+m/txSlsNka/VAdcNtmIUSZkqYlWbAljeB/PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gu4g57pb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729624305; x=1761160305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3mDk+gAqGBgOw4yB0sQsrLVgiHcMHQssPqn61VFr+nI=;
  b=gu4g57pbbIyNSm/nt2vGPDSsFLlI5k0Pe4wdg8rTh6/GfMZOhDllXZk7
   3tYO2ofTEjkdmdigu+Anx4y5GGmUlpVU2MauiFOefjUjVNJUNudtXG42A
   t011ijL3FXZNXP6x407Y1rxjM9FuIt2GD3ZABA6koNfkNzcvFb+WWA9PZ
   0fFd/5C45q2MQuJBV2URik7GmdVyzul3SKwmDlQE/9yV3Q0ZZPPjsImvA
   5wSNaQmsHgN/6HFiV4/pRRJ7QY5Py9kPmZ2ln+kEwSn7Os/2eSD+BVzz4
   uS1h1EE8rlup5hMXBbTuSQqhjFbhkWo7gVEFZ8r3N+TAv1JXwTm/J0jnY
   g==;
X-CSE-ConnectionGUID: MpSg2Z7jSA2a9gIj0FErog==
X-CSE-MsgGUID: xLs+q591ScuTTvzi86nowQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29293257"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29293257"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 12:11:43 -0700
X-CSE-ConnectionGUID: kANGtfzMQ5C6G00PraqkMQ==
X-CSE-MsgGUID: h1BOOa/lR8WZc36mcRIUIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="85045325"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 12:11:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 12:11:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 12:11:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 12:11:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 12:11:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPEu90HsxRz4R83KxUmUnHPW45RCAeMZf1sOyt/T4G3q6kRZMkUpwzjZJ1YVNsqYd14aGj/ebinXhiupIrDS71rxvZ5Yp+K8fXAYxfSaVSJ7LXNJxZ4J8emwhBfH470cONmRSrHhdjnYIgAHLu5ayvYQDyLkbkxpnbS+stljrsEDh8efEJVzXKLpla+h1+oPufQoVgbbuZFkIlu+ULwwlXLi+GwPCtJIi53RM7G+CQCSSqpZV3ufpvKGwhwE1nza2+osr3sEhR+xVhjilYftaDQ/QhplLV5DJC2QI3jbNCX81vilFYJWlooBzdlJ2x1JbGJPzVOPZNYyaTFK9NChGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAjO8J1RICR5Ef9u/n2YVFQskq27W6aCeJacwL1JLLE=;
 b=rXIr2yPVjWu6qj2+P1FOvqo/2C3HOohZPcthFVTEExol7TZJ7npyYbdWiI6gKd8hEQ2r2f/CNKK6kxxOlWFPDuccJxSCk8eNMRI1yCnbEJjOMJ3ZVe57qiJ+kuBFFpiIn2SYybOSKiSEqQrC/46tPC0E+ALw+Ue4FQ0Xw8TO+ajbH/w+cbQrhYRFlu9a5VMLILSpxGUM9wE89C7sWfeE4vgPMbpz5cGeL3rmDqDjEpV4N0SEwGgn7sn1k2le/J+dUxpKZmNVV7gdkYrt8jKD0+aOMdJ3vHF5KbNMVjLUbnGuHKtehwV/nbHPfmsDjCV2t9Mgip3m1FiyHiGcBd8xiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB7040.namprd11.prod.outlook.com (2603:10b6:806:2b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Tue, 22 Oct
 2024 19:11:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 19:11:38 +0000
Message-ID: <7492148c-6edd-4400-8fa8-e30209cca168@intel.com>
Date: Tue, 22 Oct 2024 12:11:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] lib: packing: add pack_fields() and
 unpack_fields()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Vladimir Oltean <olteanv@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-3-d9b1f7500740@intel.com>
 <601668d5-2ed2-4471-9c4f-c16912dd59a5@intel.com>
 <20241016134030.mzglrc245gh257mg@skbuf>
 <CO1PR11MB5089220BBAF882B14F4B70DBD6462@CO1PR11MB5089.namprd11.prod.outlook.com>
 <e961b5f2-74fe-497b-9472-f1cdda232f3b@intel.com>
 <20241019122018.rvlqgf2ri6q4znlr@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241019122018.rvlqgf2ri6q4znlr@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d0c6cc-ae3b-4637-e1f6-08dcf2cd5a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWVXcWpkc2EwbW9wMjR1SU1WeEsrVllLOFQ5ekVZNkNiMTQ0dEZBbmJhYVo2?=
 =?utf-8?B?SDVVS243UTdWWS84Q0RWTkNOZk4xM0pmbzdrc2lheWdoRTJRTUxMN0loOVh6?=
 =?utf-8?B?Zmd1Tms4OVpNK280ZnJYWEw0cWE5a1RPOVdLbXNjRm52WHJFVDVCT3hTbHZB?=
 =?utf-8?B?MXpNWkFHRU1uYWl1UnVSM29TLzBzdnVkRU9xcStWeVU4ZXJqWndPU3kyS2dP?=
 =?utf-8?B?OWxvUW43VnpVbnlRUTg4c0ozblJnZjFsZWhhbTZzL0ttN3BKUGFqK1NwZ09L?=
 =?utf-8?B?dWFFSUZ2RzZJTkJub3k4TWwxQy9xckFFbzFqV1cxdnpoQXl1RmNOUFIwUVRU?=
 =?utf-8?B?c1NxYnVOYVcxbUZHN0hrYkdjZWlOMWZKbGpOdStxQ0FmR2YzVGZFRjliOXZz?=
 =?utf-8?B?U1gyR1pmWHVEb2hXaUVXSkxOT0k3d0RlTHBrZmNJYnNTTHIzL09JMVdyeUo5?=
 =?utf-8?B?NnB0Zkw4NHNGN1hTeEw4ckpldUFzYWFEUGgzdjVXK0lKQURucGh6Mnh5b1pQ?=
 =?utf-8?B?SEI0R3kreHFBM0Z3amZZQ3puOGpNK0VVNzlqekQwU0RiaWFyaVlMc3dUaG5r?=
 =?utf-8?B?NGNYZ1ZjWjZvRGZCRkM0YTBWSERCK01CZUI5WEJGaWNJaDlGTUY1LzgyZjM0?=
 =?utf-8?B?QkxJZTVxaUR6ZzZ3MlBrZncyQVU1OVBHTWIwMDdmdXFpTkpjZDQzRlZPK2VR?=
 =?utf-8?B?L3RyVEhUZlg2OTdkdW03NVJhQWlHRDNqQTZsTEdtVXVha2VraFVSNk5xQ1dv?=
 =?utf-8?B?ekV3b2hQa2pVc1h6dFBVVnFaanJXWGprVk1kb3BJOXJITzdrOWNsZmxnbXdw?=
 =?utf-8?B?ODBKcHRZZEhaZWZCYkttVDZQWk9COEFndURSZTlPM0JwZW5GaFZCRmhacUw3?=
 =?utf-8?B?Rnp3RGRySXk4QTJGb01SaGEwMnBwamVQUlc5L3FlNTBBYktPWjlTTG5ZbEJl?=
 =?utf-8?B?M1NQOUpUZ2RtRENYMDVQdjNQWFhtN0poWW9lQXQyUEk4ME5zNlplVjR0c0FZ?=
 =?utf-8?B?dlBIYTVmVDNsQkJiVExzbUtETXJTTjR0SDhvVkJSRWJvUTlQcG5pS0o4R0xJ?=
 =?utf-8?B?YTNpMVV0dzd2QnU5UkY1Zmd5R0ZPellPZ253bkUvYkZWRVhRcVRYUnhpbUJv?=
 =?utf-8?B?ZUMzNkNkZExmSXdrTCtHZmZVVWpLZDBGNW1nSS9HMkhpUTBETWU2S1Y5TUxr?=
 =?utf-8?B?ZUpBNlNCd05hbEV3MXdlL08xTXVNamFnemYrOTMwb3IrL1BtaGdwZ2JERDV2?=
 =?utf-8?B?ODRWczNDR2hMSzN5NWhEamtVVXVSM1pZdTUxazlSb0lUQWtCaXFCWGYvbmVs?=
 =?utf-8?B?ZXVDbkhXazZMYkhBYXRHWXNoYWtxb05CbitJT1NkdXcwVVBVdW00K2loM3U2?=
 =?utf-8?B?bVpxRkllazNKbVRHV2RteVNuQkZuT3RkZkJ4UkFlSmptVlAzL1h5L1cyVHNy?=
 =?utf-8?B?anF2MXVQS2NGNUNrZkxndmZhSHpKNDc0ZCtCclVzZGJzcHNzNVhWVmdKVk5z?=
 =?utf-8?B?d2RvZWY3cnY5ZUhPMDRDcnFBM1lNcDBDc2xDZXJ6L1o4SDd5QWlFb1hlZm5r?=
 =?utf-8?B?WTNhNDk1dGp4aXE0OUEwT0lXb21TVStldmZSdTA4cmc1R0IwTlBLbXBXL1dk?=
 =?utf-8?B?WS9QTHBJMytrOEJKSVliQUM3ZWloU0srQWxZZk5TQVdseUNlL2FMeXFZclNz?=
 =?utf-8?B?cnhRRXNmd0FHRTNwa3VaaFlXdDBVcmJnK1JoZmNHU3haNjdDYzk2RWcxbUQw?=
 =?utf-8?Q?umAMNujfQV5Auez80HSWmaxgRoRGsDoD/6zJHbv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cS84ZGQxbkd6NHZzV3U1eXZFRi9USDFkZ3RPdWE5UmYrK2paanRhY203NUlO?=
 =?utf-8?B?WThmSTVHcDRaMlNHRTZ2NHBGc0x2dTJoMlR3YytBTzNHTEoraktMQXFOMXJw?=
 =?utf-8?B?TWNLck5EUjNoM1hPdXd2NXI3TG40cHZWY2hwYmNBaEtxMWpLOVg4cjY1L09x?=
 =?utf-8?B?UnNPWCsrRkg5S2g4cU5wa0VRc3dwTk1EYzhxelkzazhsL2ZGNlVyTWZkSCtv?=
 =?utf-8?B?dGF3NWZNelVhRXhKRGQ3bGQ5Ui9ocUhEU2cvSXFKK0ljaE0wVWxSUWRZYXly?=
 =?utf-8?B?U1VvZ3RQQ0YzanE4b3owQ0tSTHdPQytZaUZjVHdwOWhkdW9NVU5IellLSVZa?=
 =?utf-8?B?OTRMRGw3SDhVamwyWnJCNzNYSDI4WkRRNWFYSHlkZVg3VXNmdWFXdlYzQUcz?=
 =?utf-8?B?YWpGZTZwRjZpUFFwTFB0T1JMSDJZL2srUEg0WFNzQmU2MmltMy9MaUNJWHNz?=
 =?utf-8?B?MldyUkRpcmNvZVVKWFp4MkFoMlZMYk5BK3VlRm9QaG1JbVFMSElRQ3l2TjNW?=
 =?utf-8?B?MEhVcFl2ZnNsbkxxTjRlanVMQkYwbWt0TUpZbHF2QkUyUlZhVUxOYTQyaXo0?=
 =?utf-8?B?d2JidEVTKy95LzBHeFppMHpzK3hteDhIYnpBSE80cGFydXVUVjRRbFhuTUxk?=
 =?utf-8?B?QVJEeFZFT3lvUjEyVjNNZjJIU2d0bnR3YmJYNVFzcm9yOEFlSGVBUWM1S3VL?=
 =?utf-8?B?Zi94TVV1dHUvTmw4dkJEaDR4UDZ1Y0JJQVlJVDVxWWpLbmJwRUhVQ2lEUUFY?=
 =?utf-8?B?YWZGY2dXL28yTVBlVVZLSHB0VnIyRGZ5QTJiT05zK1YvR1VBbitnWmZBNDNP?=
 =?utf-8?B?M25adG5BMFFDeVJrMzEvTkN5RS9VNUVJY2EzbDBidUh6dHQ2bzRJUXlhb3h3?=
 =?utf-8?B?RmZLMWVnMUMzSGhMNG1QaG9vVldXaWNaVHFyaUdGYnRrWHdTaFpOY0czWEhR?=
 =?utf-8?B?NzUwS203MnZqZVZWZG0yemN3QzlvenhqU01udFA3UWhIeExFVmN6dzhleTFr?=
 =?utf-8?B?aWFnckFHYWpOeHZub0VBL0M3YUpKZkNCT3prekYvakZmRGxmKzBvdjJKeWRV?=
 =?utf-8?B?ckh6TVVMNFc2ekZhMVBqd05xYlZXOWRYZDlFMDllNTF6cmNTcENxV0E1VldV?=
 =?utf-8?B?SW9DOGV0eTlKTENlTGNSYmk0dFZMUFB1RHQ5RVF5dnNKWTd6a1Bka2hQRTcy?=
 =?utf-8?B?VUJ5WExwc3Z1TjVCSVhvcFFxRDlZQ3YwQ3lQbDI0UXR0dUZwS0dJdk1qTWhh?=
 =?utf-8?B?R0ZRY1VjWFc1cHNSc25nT3hnWHB2c1NKL3ErUnE4Z1NYR1crdzhHS3IzTkxD?=
 =?utf-8?B?dGVsYkg0NzNsMTdkWUNoSHU3NGtxZTYwOHhJS1hQTmZKdGNrUVREejBXVmhs?=
 =?utf-8?B?ODRWL0htdFV1WWp6aGJ6aXBSK0RjUFl2QnRCRnhGMFdLMjVxekNhWGJOMkdC?=
 =?utf-8?B?Q1JEVlZ2V0lJQ2pWMndHS1h6QUZpdmxFa29QZStXS24zM0lGS0xPcWgxUkdQ?=
 =?utf-8?B?SWhuVERxQVJwOGxpRHRXdGgwL3FXcnBEMURxT0NicjFUR1dxSzRLbGpxdEc0?=
 =?utf-8?B?ZHN1ZUtkSmNZRmZFdmE2SlV6NG5ncVJjTTJqdmY4OEEyQnIwWFgyQTZ2V3B0?=
 =?utf-8?B?YUhBTjdQU0RtUmpOaWhyaW0xekNFNmdRelVmY1p5S2FGd0EvVE50NFZYSVI5?=
 =?utf-8?B?SjJoMnZuZGx2dlFMYUxLa3NSUFR2MllleHM1NUxTSzBjK1kzaUdyaFdqZzQ3?=
 =?utf-8?B?ZzE2eGdtZnJSSnBWSXVSNWdzMXgvbmJBTWVSUHhlZHYrRHBkaDZHUjVNdXY4?=
 =?utf-8?B?V0ZhSlpZVGRjV21CMm5xL0Fudm9KSTBMM3g1a3pDc1U4WnRaQ1VTWlh1MlBy?=
 =?utf-8?B?cGdWUE1hSXM0a3UyUDdneTJjeEtrU3lCWVJiVWROeWhPaEdxR2drZjZpYytH?=
 =?utf-8?B?d2srbDZHeVdtOTk1SjM3a01zWldjSDhNUUYvUFVCSGVzcTFDenNhTXF0ZXhU?=
 =?utf-8?B?Z0IvR0NZekVSNFRxTEhDRVlhWDVpRG12cVpVZXZuTWRjYzF6YkFoOHFKSW5u?=
 =?utf-8?B?U0RhWHdvUWJMVzJpWC8reXdSY0JzcEJva2ZCVHZMZG1EZVVUN21Vc2Vsd1lB?=
 =?utf-8?B?Z0cwb1lLSk5lVTVFRW9sdk94dm9LdjA3dlI1ZnRFRmJQUDB2Rk9leEVaVXA0?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d0c6cc-ae3b-4637-e1f6-08dcf2cd5a97
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:11:38.3442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lT822+MLEcLowTUmXQZ5/JB6qkajgYkTTg3bl/QsbWpqJOP31Oh6csXixRsweUPAMZrBku9dD1a0lYGjXU8jztrgIhsd+herSh//eaRPqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7040
X-OriginatorOrg: intel.com



On 10/19/2024 5:20 AM, Vladimir Oltean wrote:
> On Fri, Oct 18, 2024 at 02:50:52PM -0700, Jacob Keller wrote:
>> Przemek, Vladimir,
>>
>> What are your thoughts on the next steps here. Do we need to go back to
>> the drawing board for how to handle these static checks?
>>
>> Do we try to reduce the size somewhat, or try to come up with a
>> completely different approach to handling this? Do we revert back to
>> run-time checks? Investigate some alternative for static checking that
>> doesn't have this limitation requiring thousands of lines of macro?
>>
>> I'd like to figure out what to do next.
> 
> Please see the attached patch for an idea on how to reduce the size
> of <include/generated/packing-checks.h>, in a way that should be
> satisfactory for both ice and sja1105, as well as future users.

This trades off generating the macros for an increase in the config
complexity. I suppose that is slightly better than generating thousands
of lines of macro... The unused macros sit on disk in the include file,
but i don't think they would impact the deployed code...

I'm still wondering if there is a different approach we can take to
validate these structures.

