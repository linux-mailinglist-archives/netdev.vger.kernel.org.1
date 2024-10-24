Return-Path: <netdev+bounces-138756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8147C9AEC5C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 18:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411BE280C53
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9B31F80C8;
	Thu, 24 Oct 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDriF0RT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662681DD0D9;
	Thu, 24 Oct 2024 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787937; cv=fail; b=LjQlo6KXRqyD7CVnAk+SAw8IwsDwGHqW5LOT17JNwPb4CMXK/BJ8O/u1uBAJ0lTAVNOiUhUGf83IoEM09horD3FNFEKBST7Y55ziv9cahibaXEbfnU7kcQ8+PaR1hwOL5vx5e5DDFLVswn1VVXrDfvll39dioEav8Jw/5N0VVho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787937; c=relaxed/simple;
	bh=EnMOb+TMQEUUHq/3yPnNvINMmEGOEPJJMoRBqPKxdQY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QG0+B42BlwB0P5nTdncixzjG+is+DrzWclxG4r94HsItBonQxZTKGpxxS/mzAWghQiFqhpH8ZPQ33i2NzZ/xk/W4IYD4/5k3omz2Qig08Ru1fuqs2CGhWPFh/Gcu9PtnDFZq8Y/WoMSDNBkA2aeZyd7TLUN/esZyjnYdT7ren2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDriF0RT; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729787936; x=1761323936;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EnMOb+TMQEUUHq/3yPnNvINMmEGOEPJJMoRBqPKxdQY=;
  b=ZDriF0RTqyYdD2US73YcejGPZxFfu7bFeR5WtJmt0/sdLTG/k0qh/jyK
   g7DhXVeYzankPiQtPhEV0MQOFTrmSiYLtfVnDujxE3Bz1dnF2SGhCVKJZ
   41YzrQf+bbOj1yuTmPC8WvFfSTV8D5cuI+87EQ6tJJRacUAvVLKwZsYHe
   G9Ri3nVkzurCluUmyZ5iWAVglfIeozOgsrVeNmiqq3+63YklJhqayH9Cd
   /w73X/uR9xxUmF7VhFhqbEDMSTkbtn2ZwxNXUSiMqQZI/Oxlh0WVMEhkV
   zVO9DJ7LsGZAv1MtqTit8+kNYbgMJzrdwiAw4XwMXJnkf4E+KkwGEBSbr
   g==;
X-CSE-ConnectionGUID: MRwWd4YbRIuLGUrGanxXbA==
X-CSE-MsgGUID: Qu8ZgjpJR1+YCMhpYAbagQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29538370"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29538370"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 09:38:55 -0700
X-CSE-ConnectionGUID: CQ7rgDlOTf26hRLQHeC9/g==
X-CSE-MsgGUID: sTk+JZ2LSB2/lPab2M0Ybw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="81479735"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 09:38:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 09:38:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 09:38:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 09:38:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1IC506BEkKL1D8z7ov/fbZqYdLqv/AVkLTuucDmY+/mRouIWP1L+uzu92VUGzaomwA1zWu16fVrcHDG/lgWNQ6+X0tvcPsNh1svAtqjQGpb5QThLYGHzF1zCMNNIQfeyOI46TtHKsV3WLnurF9SY1eNnfbtPB9fBdf91oyja9nDfzeAD54WS9LU6bui5qp33JFepJzxJf6JGyIYjwJS9zsftcqsiQsWu2OBaVDDUBdq8DeHGKLKFsraVDUjbrQt8ro6b/GcdLpx+7rwbLoxaTRa1FFVTTjjLhjGBgg2pJc6jNoKcZD9BuljOsDy5fJoFjpm6JHketPg6YvaacW2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1Q7dSQuwQPExFomqY4nEHkOQ68qHClRZtpQhQ8rgxU=;
 b=sSnItreFlkrzn/dHCaNqExLoM6D1oA0Jcv3WRrHlwpXAqS1HznkyG8+XK8aBKX1HGrEgPPX5he2iy49w/+CA1Pu2xrXCIWcKdonqcpV8VrM6k3wS1IRfsShbd8M+iOiUH486fJ6I5Yi0aXuJtX2dJ448E2lYt30KcGvdjNoW3n+LlYR2wSIr6rxXkFE3R2e9C3zoUyI5NFR4REXpXofhBg4VnXQ2hTG8RyIpyDE166xapo6FYIpUdKLS5qe6wGX7YjgaQ5nRYdWwX0Qr0qyzyKE0sq2WKwuLi2bG+hsNRTby3finh8Rmmu692lb9mevG+cvaqSADbTCnIyPvapXeNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB6768.namprd11.prod.outlook.com (2603:10b6:a03:47f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 16:38:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 16:38:50 +0000
Message-ID: <38f27382-3c6d-4677-9d59-4d08104f1131@intel.com>
Date: Thu, 24 Oct 2024 09:38:48 -0700
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
 <7492148c-6edd-4400-8fa8-e30209cca168@intel.com>
 <20241024134902.xe7kd4t7yoy2i4xj@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241024134902.xe7kd4t7yoy2i4xj@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0301.namprd03.prod.outlook.com
 (2603:10b6:303:dd::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbd25bb-1b1c-4c61-70cc-08dcf44a56cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2tMNWZJeW1xNmMvWlFkTkZrVFd2cHVXWDZKd3dRTW5mcnNtVStlUmpEenpU?=
 =?utf-8?B?M0FCOEhRVjZpMnNNbmltY2hiTnFGOTZkV2o3eFJlZlVNY25jSVFYYTE0UnJM?=
 =?utf-8?B?WThLSEp0blZrQSt5SzFKNXZZV082WWdxaDhsYTZqNEo5N0E2ZFVQcUZtaFF2?=
 =?utf-8?B?R2VhdWw5RWFMdGxtTU1OY0VKZGJqVmdpU3lPUzdtM3lDOE5HRG9xV1BJb2JD?=
 =?utf-8?B?VjB6QzI0RUdXQ2l5RVd5a3hJWksvKzVxanZCS2laWmN6SjFBdC9wM21IYVpo?=
 =?utf-8?B?OGI4aTg5V3RiZ3RPOGtaeGoyRGZ2dWxGZmtIZEVMcW16bUFrd295OGlaNEdW?=
 =?utf-8?B?ODdSbzFlZ2hNZmhMNkNRRnBkRzd1Z0FzeHBCelA2QllXdW9Cd2JUanVnQUdz?=
 =?utf-8?B?eWJqTmp4cUN3eXdET09TV0V1d09RTGcwNDZZRitEUmVTNlB4cHlCZVVVUGhH?=
 =?utf-8?B?RzZ0dG1nYjFUbnVsTkhRS283RS9zbmtaSFJ0amtKNUE5YU5ZelM4TUVSZDkw?=
 =?utf-8?B?cmFJOUZ1ZWF3YTFVU0dhZDdOQ0JIYVZ3WUNmZWtGSUhOcWRSbHBkR2xvekdR?=
 =?utf-8?B?V2xEUXBkWkdwaXVTMS9IYWNXZW5MaC9INjJIQ3FMWDZNd0hEN0t6UGYwNTNY?=
 =?utf-8?B?a0JPL1RSd1lsQVpVRDd5S0FOdEtUaWt1RGlmTDdBZVQzd252YVkyaUhTaXN6?=
 =?utf-8?B?OVVhaHE0bkJoOXF2TG5kQjJteXhyREFGZDZ5MENNQlQyZmphU1ZCT2tXaW5R?=
 =?utf-8?B?ZUluck5mZ0xoVXlhdjNIVXNsdm1PSmZydjVobThBUTJITUFlUXFWazdpOUxD?=
 =?utf-8?B?MFVpNzZ2R29jL3VTNTZncWdpd0hVUi9CTHBZK3k1YUpKVWo1U01yemY2VzB1?=
 =?utf-8?B?MzBrKzVuMktKR1BIMU0rUnlla0ViNzd2ejNqei9sZTVaT3BsaTRMaWdWdXNJ?=
 =?utf-8?B?cG4zT0JKZG1ONk9QUjhaNUt4VmlmaTloTWlRSHlRbUFFZThlZnc3ZjVOdDRO?=
 =?utf-8?B?dlQvUjQ4UzVJbjFWTEhNalQ0Y3JsRHd2VjVKNkxQY2t2UXVVMDlnOFJuSTMv?=
 =?utf-8?B?Tk1pS0pPV2dSS1c3bCtzVFBXUlpQandMdU9mRWhlQklaeG4zSkc1Yk85aTha?=
 =?utf-8?B?WHdEWmFYVDh5Qm1MMlF1V1FJbmh4K1FJREgyTGkzV3dabGhsY1ZOK2E2NkFa?=
 =?utf-8?B?YkxWa2RZakU5aVJtQjhvUGJTTklzbTd2NlRTaVh1YzNzSlQwaVRvV1ZsTWRG?=
 =?utf-8?B?Y0tVc3poSGdlVVFHWk1Ec1BBS2tJMnRPQVN5R0t2Z2t3Mldnd1Q1bGxReW81?=
 =?utf-8?B?ZkxacHdobkMzazZRK2dNZWpJYmpLMkdDR2NDdllKclk4Q0JSemlpT2hnRk1C?=
 =?utf-8?B?R0JDZnBsZGZkdFNzSXRybW5kSEpHMjNiVUJqcDR3ZWFIUUF5YlVFSXQ5VEF1?=
 =?utf-8?B?dzdwaFlFWmxscWh0SElFVzBEN1hjVk9HYWRPc1poQ1ZveGlWYW9aQ1FiSU1t?=
 =?utf-8?B?ZHJNTGMvRzBRb0lCYlNHZndkb1N2K29mNVFLWUxlYkZYWEJidVJOTS91QzBZ?=
 =?utf-8?B?M3lOTzlqei9TZkhqSnBLTFpDZHNuVGJZeGJZeFY1MERYOXRQb0dnakdha3pU?=
 =?utf-8?B?M1ZZQmFMT3hxa3YyMnp4elp0cmpHcmdtZWtRMFpCVm1KdVdoYTRQYVFXc09r?=
 =?utf-8?B?WHd0aHhrYUlkaFMrZ0tUelhCZkpDWUhHTzRudXhCYko5SisyZnB5Wm4vbFVJ?=
 =?utf-8?Q?uzdpkT7SN4ucLbwDhSze4VQ0y7uUZAOf3ztc24F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmo1ejhLNHBXNEJGRStFUkhCUnprbGxYZER3VmxoNU95YmZic0RlN25kUHo4?=
 =?utf-8?B?SmRNUkN2RnQvRXVDZHp4N0xJY0NtNGxIZy81S25PMjVSZklzVlgyTFdERk1u?=
 =?utf-8?B?Q3VvUVB1ZzJZa3NKY1JxcDdLRzc4Q0IzNDYwRW1ROENIWFRIdVdtaFYrY2Jx?=
 =?utf-8?B?U3FpbitOL1lybHg0aGJXUEZhd0lCdFpOREw4Nm10UXFNUVdnZEQ5dks4T2M0?=
 =?utf-8?B?dHRWbFFhQ2hyaHMvR2FWZlJKOTAvWEYxYVlZUVJORFVHMlZFNFp5UjJkWnlS?=
 =?utf-8?B?bmxwU2JiT01qNjA5VzduZG9xenlBQW8rbjdIcytMWjdsSzgya0drZ3Q1UzFG?=
 =?utf-8?B?Q3VjNnUwSXM5ekMvSlBzcUVQa2ZIRjFOU09KT25lZnMrOGR4UkZIL21GclpF?=
 =?utf-8?B?azN4WXlWM0c0N3RpUGZ5TkpIMk45VzNESUFZSWx3SGZDbE1rMUV0amJvRzJN?=
 =?utf-8?B?MTBvRVRjcEEvQ01VVzUyQVRBYi9qUkluQVpCK25QMUl4T2V6NUdyeWF4MnBJ?=
 =?utf-8?B?WkRwbjlFWGpOOHAwNGd2aXlmZ3pDWFE2eUw1UGJOSGl3WExwcE1VcWJwTTJN?=
 =?utf-8?B?QTV1TGtodXNNcDZaTWRBSVpPbkxWY0UrYjZHUkxud3RhVk5YY2xjeVVYa1pz?=
 =?utf-8?B?ak90YzJSWlVaQ1gxK09LcFFac0NJSDlzOUlwOTFDZHUrYVdCMVdnbnlNZlpF?=
 =?utf-8?B?OG5RbU1ubDRnODIyeDM2Y2ZtYlcyU1FCaEl0Z0djWWNQZHFBcytQTDJlYThu?=
 =?utf-8?B?NXRtVEd3bmRpQkxvSTBtZk9ZYmlmZGswMjlEMndWV3B4blpqR1hPZWhtWGph?=
 =?utf-8?B?L2NwTEl1L0VsV0V4V1BZZG5tNE04NXNYMUNNSDFCVXFiOXJpaEF2VWhaU29y?=
 =?utf-8?B?V1FucG1VbVdVbmxrbXE3bjNuUWt1ZHJRcTVTUFAyZ1lUTU5NQlZYS0VCQ3dK?=
 =?utf-8?B?RStuSUVLaFFROWpaTGVsRCtXYnNyeUdWdmZzL2NBbnUwOEp2QWVaamgvdVlI?=
 =?utf-8?B?Y1hab1YrU3dZZllYaWN6czc3eTg2WXFCRUF3dGVXYms2bTYyN0dFczhpT0RL?=
 =?utf-8?B?L1ZZTzJKeXQrQVNIL1JUMDlMVFZNYWNqNm1pQ3hIdnEzMU1ndVA5MloxVzYy?=
 =?utf-8?B?VlJiNEtqZzVNcjhlbUttNnFsQ1crdEVrQi8vSnFrN1pCN1ZIU1REd0s5K2pr?=
 =?utf-8?B?Uk9XSXlHdHVQaFcwRGlENXFodG9FS0NuSmdsdlN6aDkxU1pSUThGdzV5WEZC?=
 =?utf-8?B?SWtwSmZ6Nk9vM0RBc2NLb1ArOThMcFJaN2xuK2VuRnpHRVBGdzJhYmx4c2dl?=
 =?utf-8?B?MFhFNmVwZXFCNklJSFh3anFiRW1OSUQvL2ZFUVFWa0FOVmQwTXJZK0Q2TTIr?=
 =?utf-8?B?ZXM2UnRuV2M2WllHank4bVJJT0FzNHYxU3ZyQ0RzYUJuRGtjc0libGlMTlVv?=
 =?utf-8?B?VUJZY1YwRUdsSlg5cEFCTnE2cHhLTWplRmdPQ3RLWXZmTFZvcTczcHlySEh5?=
 =?utf-8?B?b0NTNGlRUlRCQVFEOTgyVks5M1J5VC82R21iZWFIYlpzMFV4VU1RQnZvSUVq?=
 =?utf-8?B?eE5KYmRzZFBTMHlwa3lCZkRVN0NRVXU1S0U5VkxrZXUwWStqWitXNCs2aW9v?=
 =?utf-8?B?Qm5JWnZnZTd5ZEpncnE3SkdvYkFCNmZVaFB6TE9iUGpLdFFycDhyTGlJZ3Bx?=
 =?utf-8?B?L1dZTFdJbjUwdG5Sc0h0dFJOUEJuZ3VGU3JIQ0xsYUlOYWxHZm9aTTJ4MGpP?=
 =?utf-8?B?bUVBWmpSTUxmWG5rM2Q2ZVkwUlB6VnRUWU9vT0R5TW5ORlAzUDM3QXdRV3Fv?=
 =?utf-8?B?S1dqS0hDRXZuVXgrTVRaRVNpd01rbk1JbmJYUVpKNXkzKzFMRGlwMmRwSERv?=
 =?utf-8?B?VlBEUVNJc0JHTmMzbHlLRm9CK1REc1FPMU9MQTJiOXdwVVZxSy9KQ2M3WS8v?=
 =?utf-8?B?cUg0aGxlZE1yUGpsN2tWOG5rMEhWbUl2dS9qeG90MHUxRTZOWnY1amxidlA1?=
 =?utf-8?B?TTRUMjlENUpYWEpjcDJMQUo2NVBCTHoySTE5YkxGc0Q2Z01RM2Y3ZEEwL01z?=
 =?utf-8?B?LzI4N0laR1JPaVczWGJvdnVtRVBTNCtwUS9aWGxNbzZnSm1XS0RNb2xaaTNY?=
 =?utf-8?B?L3dGclFYTkFIdUlCYitHSzdzL29HQmVwWG5EM2lxOHpFTXhHUkpScXNCMkNL?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbd25bb-1b1c-4c61-70cc-08dcf44a56cf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:38:50.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzMAqrCnx9kw44NV2uLMzu4mv5bpz5rjt5RzP98H+Mb+rjxPCj4nsGdVHwWAT3lKKE46+IIOvJ4CfPLrIkSULs1qzWP2BalWDmI4f5Ck15U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6768
X-OriginatorOrg: intel.com



On 10/24/2024 6:49 AM, Vladimir Oltean wrote:
> I just want to say that I don't have any alternative proposals, nor will I
> explore your sparse suggestion. I don't know enough about sparse to judge
> whether something as 'custom' as the packing API is in scope for its
> check_call_instruction() infrastructure, how well will that solution
> deal with internal kernel API changes down the line, and I don't have
> the time to learn enough to prototype something to find the maintainers'
> answer to these questions, either. I strongly prefer to have the static
> checks inside the kernel, together with the packing() API itself, so it
> can be more easily altered.
> 
> Obviously you're still free to wait for more opinions and suggestions,
> or to experiment with the sparse idea yourself.
> 

I also have some thought about trying to catch this in a coccinelle
script. That has the trade-off that its only caught by running the
spatch/coccinelle scripts, but it would completely eliminate the need to
modify Kbuild at all.

I'm going to try and experiment with that direction and see if its feasible.

> Honestly, my opinion is that if we can avoid messing too much with the
> top-level Kbuild file, this pretty much enters "no one really cares"
> territory, as long as the code is generated only for the pack_fields()
> users. This is, in fact, one of the reasons why the patch I attached
> earlier compiles and runs the code-gen only when PACKING_CHECK_FIELDS
> is defined.

If I can't make that work today, I'll send a v2 with the
PACKING_CHECK_FIELDS and the other cleanups applied.

