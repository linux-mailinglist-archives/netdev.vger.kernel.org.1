Return-Path: <netdev+bounces-108423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594DA923C2F
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B1028219B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDEB15B0FF;
	Tue,  2 Jul 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJdS4tt8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1CA15B107;
	Tue,  2 Jul 2024 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918908; cv=fail; b=f7eocsnbPqxn8oAQjASce1h0tmIYvE0M/NBj/EYTC74RjgXDayciK7UzKeJbro+PgON8WS7g/rzUJLz0Zh0xyLw3+d4JTr/6f2ueh5GI86WXLwlD0IRwONU560De00qDsSuQp2SaCvrqMnJGN0GPEM87KvO1d1y4mIcvtZI+7NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918908; c=relaxed/simple;
	bh=M374u4T2QGzc/lNg3AgDww9FpIMi1fu7/ZPW/gSYyw8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YW+6KL0cxS/LXU1w/u+Gl/PYD+w3RHIZgWhsDW0ILs5Ue3Ce3/FX327h+T81tckD+NPPnVA6VZwSkvBi7yCsKzqL/65PTdVMKvnBfqcRMPZBTRPyeMbDESU9Uz1P44EMol4DHp+Qo+0q9WyyzMi4J0MPDn6HjwZpIvpP4UqgheI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJdS4tt8; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719918907; x=1751454907;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M374u4T2QGzc/lNg3AgDww9FpIMi1fu7/ZPW/gSYyw8=;
  b=ZJdS4tt8AFEZUYB4OtFkT+I0a1ciUZS+qHg3KwcWaYrh7fdCm+7mP+X5
   z33JWBm+JyWAIs2cVkXPzJjeOUY1J14EXfcV60hoUZ3/HtoSg7Hxo9h9s
   OcdQzmzIpwiTMcku/Kp1Al5YKCFQHUgkhvALTkqe4+HGUwpaMJ3YsBIYb
   AdqRXeKy14Kv+sOacXX5691Me0DlbwWfQqFRYq0GrX14q6UZaCQBOrX0z
   68Y8bBGTyGdNRmN1FHrRKe1dalJALSMUd6E1MPeFFzTPZAtGFMtrK73/k
   pfeVTe6IFcUwwlQ00W89z6aGsPq1xjqiYS9mquEuPVHU+GMHeVYqk/Py4
   g==;
X-CSE-ConnectionGUID: heh7reSMQ5Sn4zpxNFz15g==
X-CSE-MsgGUID: AMK999PcTcCe9pj36TmkCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="34535207"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="34535207"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 04:15:06 -0700
X-CSE-ConnectionGUID: L2KdEBk6SvWtV45v2FLWkA==
X-CSE-MsgGUID: GD8Tsq3/S+ujouLP8wEoLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="46604288"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 04:15:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 04:15:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 04:15:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 04:15:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgOQpy7voShVMNWuD1WTB3QQ0aIHMicngNoLhLfOkP6w7YgUQCjERSnWS8QYvuekkCj5UOkzKRspie46NvINgCo9J/tjSByYNvf/kcxYTBPW00dHUStECEELQi3Pxj7oOE7E34drOLIwL9oBTjegf6p7XErzpMSfgOomfKLV4VJp14NG4ty1OTRH72Aq2euSvgXWxTghFa3nqStu1jxd2qORKk85kbosndXwWwa9CR9tU+mf4hZmkYyJVGy0Z5RG8l3+P1BHLRrj5BLdld2VmqYu+UC+wBC8CZdAibBCMw2gIZvm8k0gH1A9RE09QsX7S2+41ID/sQmZxMhIvU4sFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=864f0/OcZMM1PlM1KnI6wPaTXzxbHookwQ0iFv40uX8=;
 b=AsKbXMLf3vWdNblufdzMel6dDc6dG01OK99yysf6YL2xuU9YHf9IV3u5I1Nes0ctaurywxqVrcJl3iMTYjRSSN9KyJi3xGWojMe6Mt10mhk5SwtHkGuZdiFjB60KeWX4sd4xWe1sMOtMOsyNZtP4RUaxjnOQdjWenEQtQOM8uCXtbpRRaxwVOx3gqe79oSba9kcdE0eBqyDDERfEWehcWEwHc0aGlGH2TXmJEegg/EGXjbL8iTbrrE3GrRlB1SXjc5jpWuEq3WRJJoOhPo8RpWTfPGwcOR1+2y4s/ttRt0I6gwFtWMiUbkujb9oSGMAKMm4lzd2jvfS71eiqxKm8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by DS7PR11MB7689.namprd11.prod.outlook.com (2603:10b6:8:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 11:15:02 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Tue, 2 Jul 2024
 11:15:02 +0000
Date: Tue, 2 Jul 2024 13:14:54 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Adrian Moreno <amorenoz@redhat.com>
CC: <netdev@vger.kernel.org>, <aconole@redhat.com>, <echaudro@redhat.com>,
	<horms@kernel.org>, <i.maximets@ovn.org>, <dev@openvswitch.org>, Ido Schimmel
	<idosch@nvidia.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v8 02/10] net: sched: act_sample: add action
 cookie to sample
Message-ID: <ZoPhLnlQJyoznJuM@localhost.localdomain>
References: <20240702095336.596506-1-amorenoz@redhat.com>
 <20240702095336.596506-3-amorenoz@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240702095336.596506-3-amorenoz@redhat.com>
X-ClientProxiedBy: DU7P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::22) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|DS7PR11MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: def5f368-351f-4e83-7d34-08dc9a8837c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LUTXhAaLzpFpZt4HBnZ5HlOs0KhT9Sv7ReleSvTQCNCehuZBG839L7oSkDRF?=
 =?us-ascii?Q?IaelsOOV9ylhMFbjCBFPP34RepJZDmmqeX6jCBVTR+tJLe5Holq9VMUCkCy7?=
 =?us-ascii?Q?fT/RPQMLiVQDL/7CrzXOv7FrCbNr7gRze0L1PttuRQRSQKCxwhYEiU0Bwdz2?=
 =?us-ascii?Q?6TUr3GTkNuSBD5j5DqH12TkUd5d7Zuu8izro8SG9CZSoNpS0z+aGmodzCxoI?=
 =?us-ascii?Q?lTUqMSt6Tv4C2E86N1UrUotzmTe3SCj0ZMJaXZ59/I5LBVtyvnwammWZVRVC?=
 =?us-ascii?Q?7TT9AbsgSXIuQSB0BTOUdC0wsbba816PEI5WVrKqj0/AwH1vNqyb8BziDh/0?=
 =?us-ascii?Q?gEnwGX5TtjxVE5iM2V0+Q0p2jVP5QMc43S3REISf3RYG3w7OZ25JnsMP4sVD?=
 =?us-ascii?Q?/hldvKoSJa0vqocvDhbkqN0DrLOCPuMF7unXW40y8wyvAiv9mFIbglSXjAol?=
 =?us-ascii?Q?n+EgioAYpvt/qDd3h0f6+cax3kIr+o7J4aGer8z78pxPhoFzBjKbv4Ga7P9S?=
 =?us-ascii?Q?3yyT5xfTAxFjlhuCk5Rz3qQ2o15pFX/UHqlRX10MjHZfsNs4fOi1eDqcPw8y?=
 =?us-ascii?Q?4ZtrfEOOIgN2aURU5RQXymJsModjHhQtbBPmw+nONT8pCYQXhmlG5SK09KSO?=
 =?us-ascii?Q?KjfiemoPDWT8zdgzpPcEJDjGl2ROccVTtXiyjuIMEZhy0GGrQ06vZNjJODWi?=
 =?us-ascii?Q?E2rWAbH3KVeMoHqk3nwXJnIQyUvLLcJPLwP3G9eWlZ5BsiZd9mab8W5qahyO?=
 =?us-ascii?Q?QHG6Jt/LsHUzmTwxOAQxNc/2kvM9wAZGwnjkRjNSBX2Dn415SQqWKPgIP/Rz?=
 =?us-ascii?Q?/rPxu/W6QqoW7/pWxFvmqudHbXWOIdDBzQbZTqp6Qrgll/IdNEEC6Wfd24oU?=
 =?us-ascii?Q?bfMV69Q31bcmrJFYvgF2uQoJjAyObRB2nU/u1z5qPEsVGstQ56y5e65LfjmN?=
 =?us-ascii?Q?hBuKC45LFlbjCPHEpV74atBmMO4QRCRTsoTT4/erEs9UqnLIBA4Qp/DcCGeP?=
 =?us-ascii?Q?d4RIYDpFJjrKF3OR2EMNYTMwwRqjUQmiPWTgSYlTmtobBeSYLhxCz2B5Crpk?=
 =?us-ascii?Q?Cf3+8m5/iNsJ0kUzCB91KSvgeShf8qFkxOT7pphX3jv8dy/cLHeEAQfNeXz+?=
 =?us-ascii?Q?geqjXFh1TiASRPtZEPWN6aXf0bq1y0zKRlkAu4EESXYe/IwqrtefVx1iPopM?=
 =?us-ascii?Q?wgyBGXBJ1G/yOboPiIPQRvHvplT83MG1+3V9n4KzIx0z36jW5hTo475f66fX?=
 =?us-ascii?Q?cQ+fAwt+gyoqs0tq9Q7EohkcycOipLkZWCeNuIguSgjgrjRIp8JwOx8HBcWs?=
 =?us-ascii?Q?NAlJfSftaTd3VP2SRT/J1IcyNyZX0iQ8B1LzinFd/UrSLQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i2fFMpN2t834j+hQbmUmvkhAi+Y/4qKQnIjR43RgXTASKP9zhqUkwCRijsFk?=
 =?us-ascii?Q?ZPLNkf8TQ0Jc/RbC/kc+/0AD7F2npcMrk3ppI7yazkcQs7dggNSWBQJlyvrN?=
 =?us-ascii?Q?0A0ezQ5X2hauUoDS5iGIfdKUzoAC6v4nBS6n4lxogEvwEt2/tW9CHbu0T6ng?=
 =?us-ascii?Q?uiqIWUxdYpg6ydcV2+jHwwXgCRRUdeqmuAu37+NX1s6ROBG4gU8/Ly0X5CCu?=
 =?us-ascii?Q?bxfxttfSfQSpV7tU3u2Sfvma7oAcR5Morw5m1V8kYRvGIz6l+LHZXzuiZ/az?=
 =?us-ascii?Q?2n48rNjJvtyCC2QSImxOKqMW2e5xKUdnnEmQd9a2OhgxGWz/Rhgvgk/MlHTs?=
 =?us-ascii?Q?V9e6IoY9DAnaqNYZmeWHu5w6hVOtYvWFfrlap5oqBJmVkMcdBTs5l9WtFvpk?=
 =?us-ascii?Q?2HqDjxvSzzjFbSZ/i5kRSRIvRFl89jj9BPKeqdTvA32TQeI8gNPhbKlcnnRu?=
 =?us-ascii?Q?x8N8vorEqvfDQ/MkfcwAv/iyMrNSRyhtqoe8HErMTkdofzMPXkrSEYAnKB+i?=
 =?us-ascii?Q?Eoks1N6my3z5oqgsl5Shib7mG9Y68cW7cmE53uPPGIPfCAum96vQRyvNY0aN?=
 =?us-ascii?Q?Byb+1PiBc7LRm0PHgRmAssqX7ccYsNUD72LtIK8j1mCevOkBafj2T7R1IM97?=
 =?us-ascii?Q?ZJE/5MAt3Zk4e0nh5O/3vm8qtqGuPkGdwxTEgAFnHpE7YuSwb6rBelP20Fw6?=
 =?us-ascii?Q?uUjqr5BUwUROZTZhCkdviMj5VzKqe3TLln/EfWoKp9jGmHFenrUGJbcxMzZO?=
 =?us-ascii?Q?nx7vL0l+WTF4o+57fhx1Vxqa6gO9PjKP2m9r4ra7e7fSfccv8qh8mgPWKuzu?=
 =?us-ascii?Q?zQJ3qJK4Xg3G4RMyM9HwhIqVHnhbM8t12j6MGu+wZGPmp3JPF7M4mmY2Ww40?=
 =?us-ascii?Q?oOHB8uG0/jjpgDo7wd2QLaEPODly7+coagYgD1e3lmZagcARi64X3soRNqET?=
 =?us-ascii?Q?EpGuqc+fHSB5TXvt0xl6G8id2fdxGg45yj1MZk1D/GdwXzo6z8pfmMROoSys?=
 =?us-ascii?Q?IDN4Kc1+A9vpWgqkuQKo+Lc9Jvng3yAkqQyuJspXfxvKqbaf4qfhriOGnEJq?=
 =?us-ascii?Q?gS5dMulT2AwVCNS09HnI3RML/5Tf8WxlFPnKJSLUy8zOPOAgqBMqda8D8bKM?=
 =?us-ascii?Q?shIV5R3TkKAuoM0pxLpqxMB6oSPu2457TZin+S1Wrl+kcypUqN+Nok8B+6yA?=
 =?us-ascii?Q?//T+9GqMYBzKWngMePNJHNndHjl7K59QbgzMrMpwkQC1kBXT3eMOqQuYpSUx?=
 =?us-ascii?Q?u32repiSnn1sKXtLMO5dkjZETDr4/4FnWoOz3nUg1+aFHGIKcqtpBQYnW6PT?=
 =?us-ascii?Q?zqY1mnDCi3emgY2meMiulcfACPhDouvDBGv9IE9GBnOk01iJI9YwQO62a+dg?=
 =?us-ascii?Q?hHj+waehhYUxCaevHp2hkyi+WjBAujkIdNnSlFOHf9HFqqvYChsjWw2e2DUr?=
 =?us-ascii?Q?kFwEmfHBeP0I7ldRdqUTYN49j0VXD2bjDBb/hKln8CJxa0I0laYjsw59J/3l?=
 =?us-ascii?Q?NxSB184RS70SK9AcgW1siZso86/0W+w7k5tU3dBA3Ehi/7LeM4zRrUKTKHU3?=
 =?us-ascii?Q?w4PFQ7oLIy4YKvTiD7m9LL12zapYYKgu2I5iqa0ISAwLkfYEa2CTARWM1vBU?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: def5f368-351f-4e83-7d34-08dc9a8837c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 11:15:02.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGdxjf6pu6LR+uThmbs6tQJ79NHEwz5lZ4CoYGBzNUBo5C//iuHrT77w74DWwwyz1L4TFRmo+UnPYtet7NmY6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7689
X-OriginatorOrg: intel.com

On Tue, Jul 02, 2024 at 11:53:19AM +0200, Adrian Moreno wrote:
> If the action has a user_cookie, pass it along to the sample so it can
> be easily identified.
> 
> Reviewed-by: Aaron Conole <aconole@redhat.com>
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  net/sched/act_sample.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
> index a69b53d54039..2ceb4d141b71 100644
> --- a/net/sched/act_sample.c
> +++ b/net/sched/act_sample.c
> @@ -167,7 +167,9 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
>  {
>  	struct tcf_sample *s = to_sample(a);
>  	struct psample_group *psample_group;
> +	u8 cookie_data[TC_COOKIE_MAX_SIZE];
>  	struct psample_metadata md = {};
> +	struct tc_cookie *user_cookie;
>  	int retval;
>  
>  	tcf_lastuse_update(&s->tcf_tm);
> @@ -189,6 +191,16 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
>  		if (skb_at_tc_ingress(skb) && tcf_sample_dev_ok_push(skb->dev))
>  			skb_push(skb, skb->mac_len);
>  
> +		rcu_read_lock();
> +		user_cookie = rcu_dereference(a->user_cookie);
> +		if (user_cookie) {
> +			memcpy(cookie_data, user_cookie->data,
> +			       user_cookie->len);
> +			md.user_cookie = cookie_data;
> +			md.user_cookie_len = user_cookie->len;
> +		}
> +		rcu_read_unlock();
> +
>  		md.trunc_size = s->truncate ? s->trunc_size : skb->len;
>  		psample_sample_packet(psample_group, skb, s->rate, &md);
>  
> -- 
> 2.45.2
> 
> 

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

