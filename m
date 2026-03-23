Return-Path: <netdev+bounces-270802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDzxBqjHwWlUWgQAu9opvQ
	(envelope-from <netdev+bounces-270802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:07:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5FB2FEBFE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82FAF301FCA9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A68373BE0;
	Mon, 23 Mar 2026 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIVb+O6K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C479CD;
	Mon, 23 Mar 2026 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307235; cv=fail; b=bDvlBs84OkUOUASMMKR1auVuoJl5HR+x9NoYKw/nv/abnZI1JormVzs/sd91d5ZmYEt2R9jB92X7Ua+6MDyGiEo4h4JT/iIOxAwLhRP9xGxc9KVpuqc7Q63MhY7zUOVUuyZO4Yhf+q9idKkxEIBSpVqqxYuBr8EJWFkjP6Hdo2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307235; c=relaxed/simple;
	bh=oI91wpH4mN7Lc3ZGiBFRN9/+LljYceAo3u6OJMbPkbo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VnuB1I3koZWzEL2WKF0trrEtEyH3EpPne0ar2Nq1jOvWoX34e7wbvVzJLswDn+vzgFUqXmtxAoZCMFD6zg3TMk0lEcpdNM3FlYo7GCW9ckkGCng8px9+A3fxBV31H2kfQ8/gbN0vyFC31lz04a8GGT7CsRI2wev4ldL2851DevY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIVb+O6K; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774307235; x=1805843235;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oI91wpH4mN7Lc3ZGiBFRN9/+LljYceAo3u6OJMbPkbo=;
  b=QIVb+O6KTLYvFFKEiAlDCtPhsYnM8lNVR0Slpi3M8OdSqWgt+As+v3Nr
   1VPIJBhARz6os6X8YEU9i4sLlCop22dV34CiLz9Q1PhbJlsgkCQBfvtLc
   FghVZ9/+EFkW3AgqeoB/3yBYxhkDPRJP/sF1ezzvMLXo5UjE+2YANOXSI
   xrXXZXz7GSsSngGbx+T2vz1RE6zcszPHR4j0QVmT4FMv1nBJTbrK3v42h
   YuwMEIRSQ/AdYIoJifZCBxo8zBXjdzolntIZ3I1FxXA+P68DS1Ol9NH6F
   Vyl2iWZBsYXrGqSkEBHoOWFpYaDl5O4p+G6jzrlJdO7xisivPOGyzILSv
   w==;
X-CSE-ConnectionGUID: 8mrAE7cnR5K+m5VPdUBnhA==
X-CSE-MsgGUID: GgoGF5Q5ROagNbH+/p6fag==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75027413"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75027413"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 16:07:14 -0700
X-CSE-ConnectionGUID: oMj1I+3vSbCr8070AcR2rg==
X-CSE-MsgGUID: YGLk5JIZT5ao71jzuQn6mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="223363593"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 16:07:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 16:07:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 16:07:13 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 16:07:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAixYlFseIcyZWot0EQXCyrDqVBsBiG0PloJHufOwDZSKUqzGMXuNslW6MS9u5U2mQY7lB0dldZ71JNt3nsZ1RkWs5US54UY5dPCrvAuhsLi7HMvLul/lH0U2b7zCmw9S9r4ByHvpsrH9ipsrvpCO4kBQV1MrDSp+5wxGuC05jI8X4PZUgI/Pukgb8eHXW4cxKn7LTAa2JEzhqRFeYYhto3oKk5scma+zBZV/RMCXPPOfzrfGXbucmyUqvw/zTi65dOIhPg8X/hDGTPPB/jLdhVUH6MYUa10fxeHCOmYDK2Ve1hByXVvVyISBz89X2SxgG6CuDfs2hSoHTnz7F/ilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISo5kD8XpmWHarf57eLpMlBMlnHkDMf1OInyAseXSFo=;
 b=UXSLlyD4AaeJvQeU4u+qmEWu05VHBCmpZj5T5hAx0dBGClIFAxV+IqUVb0iT/l0f5Kc+SsbXS+otlaEHKKBOBIs/e68WAJZu9CtWs04RlCKiJ9FAOXEbuPREYFI6WC67w4M7pjbZumPvvS6X3a9/FbVr4ilwo42y+pdB6lxjkpjPpob5OQBhWSvCFTE5l3GOksa+UfNenT7m8qx/WqM86z1LwYxxIABDx1LMFayQHRHsE1R3Lb38xQVuo1OwFo7kh4uLJs6SBmZKA+rAa+spUcWnF8SbuqDTj86ET/MRKWBB1y9fIds7LbdeiLxEEHdr3fvgX9YfHEQnk5FteMcQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 SA1PR11MB8523.namprd11.prod.outlook.com (2603:10b6:806:3b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 23:07:06 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 23:07:06 +0000
Message-ID: <734bbc85-2209-4b6c-913e-e3637532e315@intel.com>
Date: Mon, 23 Mar 2026 16:07:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] iavf: fix wrong VLAN mask
 for legacy Rx descriptors L2TAG2
To: Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Eric Dumazet <edumazet@google.com>,
	<linux-kernel@vger.kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	<intel-wired-lan@lists.osuosl.org>
References: <20260323101558.1477593-1-poros@redhat.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260323101558.1477593-1-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:303:6b::19) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|SA1PR11MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: ee895fce-7e5d-4384-3c84-08de8930e697
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gkiHgA+x197Ddhr0E1uN9AMTf3C5F94xeMAILz32wrdEQhMeXxM+yhYPn4KC/b+EdK8l3BVB5MzHcFh7d+pKt3+L2lhCdsAzNTDtqDMCtQdzJRnsyetBKCFZBbJH2ST5KHAIYm37P0lhWUKSA+plPS/vU4OPzUHObBQWqt96UlT3PnZ0+coWxIAaBfp1a7E9NoECX87peiW256SgjeyL81t3uVBCb1CrMwuVher2k1BYUQ850R+mygtfJ+wWmjSsTBqMrjHMWUT7bC7Ox7nYEKW1XnDxYI2i0nUI9raZoXTEEhIt38XeNzd4STelNi6LroTQovJT05R6Hs1qvyYE8s38PgBGICyaZ+jB1AxI8ePC4uDbQc73X4slL9h6MQEvFEBmto/78uGY4bn3PJZNbu5Jdjl5M02pb/bKGLMuqQpsb23kmlE+UVnaF7iKwYtQCT4lWVkyb17xs91VINuicl0T5E8ZcsJMvXM4MNuOVoOJ7sSH4vcTvuNadLg292qLR+bkMqzlOqxcY1k8+ux+g+YsYUhtXCW9XRt9v0wLFRJKR1bdO5ndpKP0djToFvcCmTWeIUIDQGvI/s7vQWEB5WFAt6INBgXhBK+1g+aXagtpJ/2/FJFnV8dy8ruOWJ7EEov8KgwIH+4sytkW0YjVAB0o+tVs7RuF7cCrcRs1zBhUrIpUVake7A5MRLCQCuXNYhqeLE223wuxZED0Aju/wb1qNj1l3JVd4avbF7Se1gM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFAzZnprbDRxTEJCV0kvYVJmdnJoNHVNb3R6b1ZOemhXVUJwTzBBRHVJemYz?=
 =?utf-8?B?MHNpRDh2Zkt6SWRIOEFCRjNabGx3UG1NYjJUK1JJRXVSQnMxTXFwb3FUVDM4?=
 =?utf-8?B?bzRPcTNseWV5bkZ2TkRNa2ZxRkM4V1JmbEpaMStaT3Z5SmI1dHhRZXFnVmM1?=
 =?utf-8?B?SFRlMU1vM2dnaFdJZnQ4SzJ3b3NBdHM5SzB3RGlzTkwxREtOUEt3MDh1bm1D?=
 =?utf-8?B?YnFjaVhnWFN4aUZIZS9NbHJNYmtnSlRmNnlVQksvZHNCb0wxeDdnWFRzdjBU?=
 =?utf-8?B?TldXL1Nna2VhNnAxcmxJUlRZclVWbDhTRHdvTHdJVzRPRjNvbm04eUxUNjlF?=
 =?utf-8?B?NndUeVdqNThoZlBwcWltdGxjc1NQdkI2ZkpPRzJoUzZjMmxTejZXSitlcUdB?=
 =?utf-8?B?cHBMR2h5eVNERjJFMTAybmlkamFKZ2Vpazh4dnJ2S09FQnNUNkcyRHIrMk5h?=
 =?utf-8?B?eGR5N0lFKzM5aWk2QXg1QzlPN1FlZFlwZXoxb3ZNczhXTSsyZnZHTy9wVTdo?=
 =?utf-8?B?ZzdWR1VnSUtEVzh4N3ZnTEc1WncrLzlSeXZtNXdLTEpXbEYwNkljYjB1VUJH?=
 =?utf-8?B?V3pHcC9OM3FPcUFiOHdTQ3pPUURtR1c0ZUp2QWZBaGxmczMzZldpN2dmVE1Q?=
 =?utf-8?B?MGZWRXZDdlB4dEdweWpPMUFYdjRSZTNTNVdqaW1kWUNubnBqUW16Q25RenEy?=
 =?utf-8?B?T1ZOQXFESWg5d2NVWno1TGpwdlRlSnNwdy95NVAybm5lS1ZVSEM0aWZweXc5?=
 =?utf-8?B?UjVERk0rRDNtb0Y1WlpkRUJPS0hjeTA4ZVNNWmlncHl4WElZcFZ0UHpIVHdU?=
 =?utf-8?B?VFRydjJsOHgxQnc4SFNWUkdJY1JkSFo3VkE5ZFdyNGRXNkRGL1U1aEZSWmRP?=
 =?utf-8?B?OGp4UWwxTk9pM3EyMUdaZjBNblg0cVhXb3RnUk8xOWdkbmtJRmQxOUZLWTNj?=
 =?utf-8?B?QzdhK2JZUW05ZWowMW1wVGwwZXd6K0UzeTVBa2tsQzVGL011TE5uWkpRZjdT?=
 =?utf-8?B?dzl2RjhnL25IN2xoRUQwTVlEbGl1U0VOWEdLT01pSFRoWmJKWGM2R3YweEVN?=
 =?utf-8?B?QWwrbk1zZ2d5ZzZJcHdsYVB6UjhqMk9HVlFWVVBONlQrMmxObjk5MFV0TGxy?=
 =?utf-8?B?Ym9WYXdoQWRXQjd2bVJqRXVreFlzYjkxNlJVd2ZPQ0dQdGRLcE9LK1RabXBk?=
 =?utf-8?B?RU5nWFRhWjJyU0dYOUgxNDZINDZURWJNNU9yKzdldjNJUTNtMmR5QnIrS25p?=
 =?utf-8?B?VFlzTDBQMzdWc3lBWWFRcHhsVHlRNW5NKzFvNjltMFdnVEtEWkd6ZmdtUlNa?=
 =?utf-8?B?MVJDVUFDRWdZUkRKZDR2cTRMS3QzTk9NQ2VBd3ZEWEhjbDBoQXFNMEg3cTVs?=
 =?utf-8?B?OE9Sd1JVSWZRSkFoUThXY1VXQjJJMEJqci9vWGt2STlwT2ZCL0Y2SXFXSXVF?=
 =?utf-8?B?R2c3RXNxUW93SUNzdTVoSmNnQ0ZHdFZEeHhtMkdoTzQ4N1ZLRzkvaUM1c0hr?=
 =?utf-8?B?K3BCeGlMS3dVcjEwbytCRm1TZWtwSTFJaHRhZlBnS1UwRnpyU29KTkIyQlE0?=
 =?utf-8?B?Zy9ZbnVpVEdZd3BzVWNKVnFYTTFWVlNGMGNhKy91YTg3bGMzZFJlRzhBYWVX?=
 =?utf-8?B?VW9iZk5kbjd3TEhmVW5DeTFHaEswMHJPWnl3aE0rbHUxMms3N28zV3B6VnR4?=
 =?utf-8?B?NXFxSW9XZnlaZTBsemtOTmxHbkRYOWVDUEZyVUVzaDMxaXNETWZ4T0h0Wk9r?=
 =?utf-8?B?Y2VKNWR5dUg3MjYrQ1IrV21kTE9kY1VSY0F4NlNGb0pXL2VmV3hWVlF2RXJ2?=
 =?utf-8?B?Z1lXMlVIY1IwVXcxQXRacVJUT3l4TjZ4TDltVVZHT2NZTVN6Q1ROdG4vNjdS?=
 =?utf-8?B?OUVMOHhkMzlkVzc2b1AvOGJnUHJ4R3kwZm5HM1dCNjdlaHhSM3VDYVhXRjVW?=
 =?utf-8?B?TCtZMk1aNHBrZERkWXdSVytUNHpuc2s4L0VjZ2hWcFl4RmN0YWs1Tmc3YjhD?=
 =?utf-8?B?Tnhxc2JRWVBDdWJPOHNEWlgyVVVwZ1BObGtMcE1icFUyUUc1UERsUTJIT1M3?=
 =?utf-8?B?OG1oZWpOVHNCUVlWa0Voc3h0VHQ5U0ZUOTIzL0d6dGpsUmFBS1NTUXBZZDd2?=
 =?utf-8?B?bjNzTC9iTEprb1VPZkFnOFNMVy9ycHZNSEtXMmhrMlpUMmpGelB0WGhiVjB5?=
 =?utf-8?B?N2VvUlBYRVJYTjZHbUc0cWFrM2tlY3cxNVMwa04wT2dBcVJLM254MWtJZldH?=
 =?utf-8?B?WlJwQmxnOXJSUzJvcXNkQlNaZ1l3U2dxYzVZN3UxN0lxVHlTeXlnbDN0alpj?=
 =?utf-8?B?Tm90ektkSTZiWFRxWGh3Z2xQN1MzSklNbGMyMWkra3B3bEZSSXdWdz09?=
X-Exchange-RoutingPolicyChecked: IlSdfRSN+TpVkNbTMLTE6PK6/ZYj5Ah80Qon3pB17P7vL8SwLTwrUMVrATeO9ekvrKiKntGGGKU9xLf3l2qz+JOJ3u+p0cBxH7Y1pS4hxsRDXmNnzOUKoLa6x+zLvR/6jzqvxd0YD+mxztdWldOEH7mbAMsTmrHYzds4qBsNd/mHJT4kalyveqH4LoiMJtZmNSKUBDP4CRS1W3nQGar/JyrGKSu+AN0z7DsNxWLoTB16vdd3sqPQ/K1jKuGw9mQ8ai3GdloRYGXiPjxUpA+g1dfIOS2pEoxuhSNgg1oQ5MnarG4UVj7SI6j8FsC2BFe301x40xZzv8ZPP3pF2muJpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ee895fce-7e5d-4384-3c84-08de8930e697
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 23:07:05.7577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+/BienZU2MMvOz4PIrwLTaxdRuiTyeZCQTFHtguL/CC3hTfEl3yqE0ng8Fw8DI9D33b5AU7k3Eel/5M1qLWhhQHgsLnoj3AhgmVol/TGIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8523
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-270802-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8B5FB2FEBFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/2026 3:15 AM, Petr Oros wrote:
> The reproducer requires legacy Rx descriptors. On modern ice + iavf
> with full PTP support, flex descriptors are always negotiated and the
> buggy legacy path is never reached. Flex descriptors require all of:
>  - CONFIG_PTP_1588_CLOCK enabled
>  - VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC granted by PF
>  - PTP capabilities negotiated (VIRTCHNL_VF_CAP_PTP)
>  - VIRTCHNL_1588_PTP_CAP_RX_TSTAMP supported
>  - VIRTCHNL_RXDID_2_FLEX_SQ_NIC present in DDP profile
> 
> If any condition is not met, iavf_select_rx_desc_format() falls back
> to legacy descriptors (RXDID=1) and the wrong L2TAG2 mask is hit.
> 

> Fixes: 2dc8e7c36d80 ("iavf: refactor iavf_clean_rx_irq to support legacy and flex descriptors")

Sure enough, this commit changed the legacy version to:
+/* Stripped S-TAG VLAN from the receive packet */
+#define IAVF_RXD_LEGACY_L2TAG2_M               GENMASK_ULL(63, 32)

I guess since we basically always negotiated flexible descriptors after
this that we never caught it.

Thanks for the fix.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Regards,
Jake

