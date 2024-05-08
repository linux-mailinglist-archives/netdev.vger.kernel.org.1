Return-Path: <netdev+bounces-94510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549A38BFBA2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781BD1C20F12
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4911381749;
	Wed,  8 May 2024 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JiTcLXkL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C687D07F;
	Wed,  8 May 2024 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166938; cv=fail; b=TeIIIwubZYM7PZThoHdc7JDdlZxX9BNBYGWqh+6l7lwjMfVRFOQK36nJKja0Mac8NH/P9VLP+Py4zG4nvqJBpPAZbL5gEiklt0cDKMi34uJhaLgdv8Iq9unR3s5eQKjCdJS6WgPp+tOKRfQbqYzrEYl1ruc8gG6ZKb9lkyrpUUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166938; c=relaxed/simple;
	bh=HLtsErxjYZQV2gYCUX4/RUO+rYcgzu2XaYZl+Uhec9s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sY99v8swWKoAQ5sCEDgBjbIzMSLWwzV5sDRM+3Kj7nPuXJlt2UJH9awjsz4f6Q4E1OpNbra2uj4sEEbXhjQKoa5x/Px8p+EJUbMpf3vO4y0FQ0qawhnNeo73U7eMRSAYgNAAtKwnlrAiBiSw2UYx+uIlG+on5tBaubtOZgIGlow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JiTcLXkL; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715166936; x=1746702936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HLtsErxjYZQV2gYCUX4/RUO+rYcgzu2XaYZl+Uhec9s=;
  b=JiTcLXkLV9uVsZmNA1O8jP9FiB1OAsb/XKZb1EZn7OBSOfMQKDNxB+LC
   n6MBjMt+G0xk//jOtXh61j80U/er3vrnd1vE4yJtlbQJL6mdpAT8wrQ9w
   nxYtmJshvxoM1iUzA0YVPKdWOOblFmM/sdt3h994z868nhCg8LMZikM+B
   6nalo3gkScnshHr0hEsyHEPLZiQaSdp3R7EMSJCThD04tcG+/M5udCAUL
   ZxNvZg84yAphZZMeYvBqkpFSbE8YadVYiPvBg1R6As8OxwHwY3F6ugI5w
   JtjJlGMqJ+Ih27IOnY6vA4QbYHF8GpuQqOHi20LuVAK+QSY2nXCw2iHXB
   w==;
X-CSE-ConnectionGUID: xFEMOmcaRkeqKkU7oDzv/A==
X-CSE-MsgGUID: 1QAzKgevRCmbjanxNG8KlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="36399078"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="36399078"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 04:15:35 -0700
X-CSE-ConnectionGUID: VS4KKiZxQtKX4OZPg36YAQ==
X-CSE-MsgGUID: CAyGVac4TQKliiIuhnR5yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28824951"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 04:15:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 04:15:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 04:15:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 04:15:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHg2kqKrZuLUV7smmpZqbXYD234jnlxzX6hu82RrVoYgc/9r46T+AdET+rGWB/JANSXPM5tZKwN+BAJSNnmvE/UzzVmi1IBmFuuF5BVtgVpEVb67f3JMaVU9eU4gWCBIbZ5izwHpRw/EGXgOKYpAPKWEveSkPXpzsg4HQimllvUFXNZ6BkiJaOP4xCJSoj00jLV2QRIU3KidU9enZUalnGm7Ivq6oQOLtJkN8m2hjuohDl/y8koVadRns/aqUVBK0U8AGl9EZFp4x759otZh2hB5DG3q7PsdYLl2pt0f0sU9gW3dKWzjwlf/gSH8PPpESc8knaJSWsHSLY5uOwQ1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLtsErxjYZQV2gYCUX4/RUO+rYcgzu2XaYZl+Uhec9s=;
 b=JTs1wxaX75oQcdZvD/CX0ikA4W2YznHjbGD5sFwLgUvDuwkYA5ATFSC4NTizfJlh/FFux1Xyl7lVAl/JibMpdSeesE6x/atyRG0N9+jhcj1sbMKJ5OwannNl8XK/SYPnLV3ij0DKteZoQLLik9uRJCvps5FlBgrcpxFqGRL9RZEKR0XBsulC2zNMZZTpBwjEj9rHPFENfnzS5+l+c1t4rKRpl0m0+7dT89TmJtkduF9HbSJN4IxJFWzlFUD0BsAJzwT50Hw5xTE7RSvxxEFwesMy9nR5BC2W2Rn+lhKHVxKMqtCMGNKcyiT5qd2UQoRqH7Q1x19FUjq+mMkJNESaug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SA2PR11MB4778.namprd11.prod.outlook.com (2603:10b6:806:119::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 11:15:29 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%3]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 11:15:29 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: =?utf-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] iavf: flower: validate control
 flags
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] iavf: flower: validate
 control flags
Thread-Index: AQHakA4MjiZvoVMaDUCrpkkDdlp28bGJy8TggABBY4CAAALMYIADQcfQ
Date: Wed, 8 May 2024 11:15:29 +0000
Message-ID: <PH0PR11MB501352BD1C13D13CFDF1842B96E52@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240416144325.15319-1-ast@fiberby.net>
 <PH0PR11MB501366480345AB20618700D1961C2@PH0PR11MB5013.namprd11.prod.outlook.com>
 <af4986b8-e868-4540-852f-7dba5e3196d8@fiberby.net>
 <PH0PR11MB5013958C9390750E1F98A92A961C2@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5013958C9390750E1F98A92A961C2@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SA2PR11MB4778:EE_
x-ms-office365-filtering-correlation-id: 2f8336e8-a310-4530-a113-08dc6f502b77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZEIwRWdpLzhjYzc2c2Q4ZnIybU4xNy85eEcxbFBzcFUyYVhCclQzR1p2NlVH?=
 =?utf-8?B?S0xRK2NIci9BVm1LRzZaeHM0RkhUaTZ6NTJ4NHpjbjBCR3pyZndJNTFwVGZU?=
 =?utf-8?B?SWRENk1NcXhuRC8vWE9XL04zZzh0SUlaM2N2TnFFMStSS0Z3TlVEWlRrSTA3?=
 =?utf-8?B?VVFWZTByUU51ODRtUjNFdEpRTGtCdnFSdFd6SGhYZTZ2UnhjTjNsY0VjakU3?=
 =?utf-8?B?bkNTTm9waTJybmtZUGdPdy82OFRGc21udkFURDB3SlhDMlZweDBUcDc3TGov?=
 =?utf-8?B?cnF6dzRiQnZXMGZhMjhCNVB2Q09LTnFlVUJEbWJOQmE4UitkUXFoZVFUU0dY?=
 =?utf-8?B?MFFsMXRXN0h6OWtJSjFNclVuaXRvK21BVXc3VEhWckV1U0oyWnhiVHByTGtT?=
 =?utf-8?B?MGxFeE13bGY3ZUxUMGZSdGJXbVJTcXlQekhIL0d5OFBGS3pWRTBtVXZBcnpn?=
 =?utf-8?B?cnp4bVAyaUovekJzRXlWY0xEVWdYL2FSRVh0UC85em4wZlUyWlNMQk13Mlpw?=
 =?utf-8?B?VEtSZlAyazBhQ1dVOVFmdEVHZXNSSmZhYXd2dCs4TEdYOGMzY1Z6ZGRia21p?=
 =?utf-8?B?NmJia3FldEdNd0RUMGZSbWdKdldrWFI5a3hjTndMNEtDb3NuVkxGS3FsTkxx?=
 =?utf-8?B?cjZMMHF1cmp0Q3BoYmpOTHByenFRdG9ac1gvZkpIYmNvSm5WKzZFamtxT3Bz?=
 =?utf-8?B?dXlZMzlJdTdmUUo3L0VONFJEdmF5UFlHOFBPNTBSVno0SlFCdVVDUVBMQ1Mv?=
 =?utf-8?B?Q2dEbERKWmJacmJxRFRNcTNSK2RWc1ZJa1lHeDIwZStLR2xBZlhvR2ZMOWZY?=
 =?utf-8?B?OVBiWUdnckdZbG40V1o2OTQ4Ri9rVm9wRFE3NTFUNkk0WHFUQVoyNkpCbEZM?=
 =?utf-8?B?NEdsVmsrWjVCNlpma25BbG9NVWg0U2xuOTFnMElwZ2U5elMyWHNlLzBSWmhK?=
 =?utf-8?B?bXUvajVWbXg5WDNZSXBKRjA0ZFdmNEJQUkRra0pZZko3TU80TUdyRGE2Y3gv?=
 =?utf-8?B?TU4wRUg0OHlPUk1XcHZyNW9ac2JITjUvVDBISm84SUhieUtLazQvV2p3TnRh?=
 =?utf-8?B?SHljeWo4bk8vUmV5ZmZWTVM3NVJSSEpFNmxYNDViQS93TTR0NlBSeHZtRWxy?=
 =?utf-8?B?Vno2cGdNT25FbUd0N2w2c1JuZk1oZTZqQzJaWUJzYkg1MGpHbGU4aHVxTzFF?=
 =?utf-8?B?SE91NWVXcEFaUDV5TkViWldNNmlLMys0N3ZYcEZaVkhrdUo1SFM4TlpHeFZy?=
 =?utf-8?B?Z251a0JvM2E3aGZ6ZGFJeTgzS0pQMlBzNHlwcGFjWXdEa2U4MFAyL2trbGk3?=
 =?utf-8?B?dWNtVjBmOUxobVdQNGZQMHZYT1ZnR0d4V1NSM09QS0JaUlNJNUZnUS9MSkRl?=
 =?utf-8?B?LzhvbUFmaFR1RHBYR0l4eGErUHVyekE0UDdHcm9wUWd4TnJ6K1VtUjB5Z3pm?=
 =?utf-8?B?azJGZkc0QlJIQXYxNUxYYXZCc2xVWkExNmZQc09aMngvblJSTWhTTnBNNmFJ?=
 =?utf-8?B?YWZPb1ZRUVFkWFlJZDUzTlkxczRxQjJDcnl1TjNIclBweVJ2dlh0bFdwNVNh?=
 =?utf-8?B?bW1HM3pMYnBnenRBclAzYzFJcE9hVFBiOTZmZlhEQmMxeGxXbGhkRE9YU29j?=
 =?utf-8?B?OThTeGVBQ3RRNFFnVEpUMFFEQndJQk5NVlRES3lNWWFvcDA1TEM0a3UrdlFy?=
 =?utf-8?B?S3F3SVh1bkREdWlUVy9FQUYrNUg3TTByMUV2SmR5bGh1L3dnWWxOT2tIcEtM?=
 =?utf-8?B?UlFiNS9xK3Y5U1FTZFdxSXRKUWV5UGhvZTNWUm1uWlNRNFhyZXBwNExOaFBE?=
 =?utf-8?B?ZGg5eFM3UEp2bGhhNSszZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFBUSzkwU2NtT282dVZRSEpmNnNSOEN4ejNWQ1VBaVdSdVArNFhZMjZQOUxr?=
 =?utf-8?B?TXRCZGtyLzZLbm04NVI5Mm9oVDJBendHVnZvUTZEUWh2a1VVWWZybG8rSGhr?=
 =?utf-8?B?Vno2OEpMT2VnUlRFcU9FVGE0Smk0ejg2aHg0bk9mNDhWMTRaV2E5OTh4Z3pY?=
 =?utf-8?B?QldYQ0Y5WVBVTy9zUUlzbEVYVUwvU3dBQm5RNDZ1Q3A5ZHdnUytvZWx6ei9N?=
 =?utf-8?B?ZGpnM0YwQ3pwTHR0ZWxURUJCK1pnMGVQOVBVV3gvcjhxVUtHdC9vc2tOL1Rq?=
 =?utf-8?B?RkozbXhSUi9oODErdmtZeUxXem1LY29vZUpOSEtpcGtON3FETWw1dmZxbkFr?=
 =?utf-8?B?RG1UUjJpaHhBWmdVMlVyNWlVL1V1L2FNZ2NqRXB2Y1VINFBSR3RjdE9nRDQ1?=
 =?utf-8?B?OGpORkxHd0RLbE16a1VjRk5aSUswd20xV1lSRm94VXJYTTRIR01Od1pOQkQ1?=
 =?utf-8?B?NVM1WWRZeGRjVFYwTDJ2WjRqV0JIMUU0eFQxRW80WFRPQndETUFHVWpBRWdr?=
 =?utf-8?B?RDNxTFJHT2VJazRrOHZnQjBEc0hIbkl4OTZNV2tKL0Nhc0pmSzlIV2RTOTlU?=
 =?utf-8?B?VlpXa09IT1RzdXJlYUR5cHlnQ0dkcnpPcVNndG1MMGJWMFYyQmQyMmdWNm1w?=
 =?utf-8?B?TVdWa0ZVcXdncU44TVZQcTVnL3h2NnEwQ2pKc2s4N2NWazZFUzhtaHlKR2lJ?=
 =?utf-8?B?QnZUZUFjdWpQN1dOaC80NE8zbWNQbWprNEhKTHZLTDJjL09kUUJvOE9Cc2pi?=
 =?utf-8?B?UklGK3lPcHZhQWJNcHNOYlM2SzV5aUEyMXJjdEZmOGdQYWlDaGFrQnFiUVhC?=
 =?utf-8?B?WTdTTE5NOU5LeDl1WTZZY1ozRHh0d3VtRG9NNW5keW1xNjQyTW0rUS9UdkdR?=
 =?utf-8?B?NVpIT1BqRHNCYlVsTEdXQXJtUnJmeGkvUWMzTktvVTA2QTJ2djlRYzU0M1pH?=
 =?utf-8?B?UVkrSTRFd0pUOW9TNHZlUXU1bXpzYk5GeGJpZFZQOTdUc3pUNWw3U01FMTdO?=
 =?utf-8?B?V1VQTk5qZUZFRlA2T0dVZkFDM1QxamZMZkRLYlcwWFk4aFpiVXhXa04wMHFU?=
 =?utf-8?B?NnlWUGxRY3dBTVdZa2QyeCtzSDRDaUwxblo5VmpXM0t0bnRYOW1ZZGlZNmFz?=
 =?utf-8?B?OUNld0dMVkZpZnJwWHRXNWZaUTBOM1lRbGtsUEpuWVJROTdKN3diQkhxZE5R?=
 =?utf-8?B?ZjJlVFZRT2JRazJyaFpERFdoSllZS1doZTNlSEdTUHRGNytkTHpvaEFFZTF2?=
 =?utf-8?B?VnQ0TXU2Z0tDQ2JXVmJiK1RXN2ZjWWVodlJaU2NqYW5ta0RIQ0hhcXhEU3hK?=
 =?utf-8?B?d1lMRU9EaVpDRjZyTEM3OUlQak9FRURHWTdIdk9SZ3dMWjZLbnQxTHMwd0lr?=
 =?utf-8?B?cVdaT1dIbys0WUJ4MkV6YmYxVnRDQ05RK3JjK05TdlY5RjV4eTRBWmRtWGI1?=
 =?utf-8?B?ZjJXcXpGUUlCU2tRUFRDV1JVR3AweFV0MEhWemhrbGtZQ0xMQlYydWh2ZEU3?=
 =?utf-8?B?V1RyVlhyZnRIN3JrYXVkY0hTVXJTSndJbm9weGJWTFhWUHFPZ1VCMG5SOFJw?=
 =?utf-8?B?NHRjN09McmE2TDRCVEhxYUswTHk3QUhDR0s1KzluSWE2Z3h6YitLUG4va2Jj?=
 =?utf-8?B?clZ2RnNvOEgrYzdRTmdSeFBJVkhPSnE5cENJKzNHZkFkaGU0RW0xZlhraUxW?=
 =?utf-8?B?WU9EVVdnWHJXaUE1d3ZPTTkxbWREejJ6bzFLM3hmbE9KVlJKVFA4bVl0VWVu?=
 =?utf-8?B?M29qc2RJcVhGbk4zaVppS1k2dU1WcGVLTWE5ZHh3TldUcHY2VlZrWStCTUU1?=
 =?utf-8?B?dlRjRUFPK1ZNWDMycXpGc0NuNFZBUzRsTUxkRWJqaTNVemZGdklpcmxtRnls?=
 =?utf-8?B?L3g4N1ZxUkJYcFp5bkZPUTFVZ0IwQSttT2tOeVA0OURpaGtQYlBFYXY5Mkdn?=
 =?utf-8?B?NzB2dHNaYldDb3BLZmNJellCbFNTUTRjMWpmSXIwVXZ1Nytqelc4bUo1cWdW?=
 =?utf-8?B?MGtPaUdKZUJDdkhmV3FCVTJVQlVqazV2V3YvMXZNN3BtNm9Rd0dVbFc3V1FR?=
 =?utf-8?B?NjgxS3J3Yml0WjloVkJKbkI5MFhOWTErZDYxQ0FOcnNwZTNPWDBUdFF6SUVi?=
 =?utf-8?B?dndPUENLQ3Brd3dyblBQSGVBRGxaRmpnRUoxUmhQKzR6Z211YVFBa05mSzJO?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8336e8-a310-4530-a113-08dc6f502b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 11:15:29.6953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVaysub/dDzT5bmZhxWvJTHX+qZNUFJLL7PvRV42NBGYLFGDzAspuAbUFU0z0OtOjKj/mxPv6NyIINp2J55Nv4tQk5hek+hteXtI0AXFuYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4778
X-OriginatorOrg: intel.com

SSBoYXZlIHRlc3RlZCB0aGlzIHBhdGNoIGZyb20gQURRIHBlcnNwZWN0aXZlIGFuZCBpdCBpcyB3
b3JraW5nIGZpbmUuDQoNCltyb290QEJQLW5vZGUzLUJJTkRVIH5dIyB0YyBmaWx0ZXIgYWRkIGRl
diBlbnM4MDFmMHYwIHByb3RvY29sIGlwIHBhcmVudCBmZmZmOiBwcmlvIDEgZmxvd2VyIGRzdF9p
cCAxOTIuMTY4LjEuMTAgaXBfcHJvdG8gdGNwIGRzdF9wb3J0IDEyMDAwIGlwX2ZsYWdzIGZyYWcg
c2tpcF9zdyBod190YyAxDQpSVE5FVExJTksgYW5zd2VyczogT3BlcmF0aW9uIG5vdCBzdXBwb3J0
ZWQNCldlIGhhdmUgYW4gZXJyb3IgdGFsa2luZyB0byB0aGUga2VybmVsDQpbcm9vdEBCUC1ub2Rl
My1CSU5EVSB+XSMgdGMgZmlsdGVyIGFkZCBkZXYgZW5zODAxZjB2MCBwcm90b2NvbCBpcCBwYXJl
bnQgZmZmZjogcHJpbyAxIGZsb3dlciBkc3RfaXAgMTkyLjE2OC4xLjEwIGlwX3Byb3RvIHRjcCBk
c3RfcG9ydCAxMjAwMCBpcF9mbGFncyBmcmFnL2ZpcnN0ZnJhZyAgc2tpcF9zdyBod190YyAxDQpS
VE5FVExJTksgYW5zd2VyczogT3BlcmF0aW9uIG5vdCBzdXBwb3J0ZWQNCldlIGhhdmUgYW4gZXJy
b3IgdGFsa2luZyB0byB0aGUga2VybmVsDQpbcm9vdEBCUC1ub2RlMy1CSU5EVSB+XSMgdGMgZmls
dGVyIGFkZCBkZXYgZW5zODAxZjB2MCBwcm90b2NvbCBpcCBwYXJlbnQgZmZmZjogcHJpbyAxIGZs
b3dlciBkc3RfaXAgMTkyLjE2OC4xLjEwIGlwX3Byb3RvIHRjcCBkc3RfcG9ydCAxMjAwMCBza2lw
X3N3IGh3X3RjIDENCltyb290QEJQLW5vZGUzLUJJTkRVIH5dIyB0YyBmaWx0ZXIgc2hvdyBkZXYg
ZW5zODAxZjB2MCByb290DQpmaWx0ZXIgcGFyZW50IGZmZmY6IHByb3RvY29sIGlwIHByZWYgMSBm
bG93ZXIgY2hhaW4gMCANCmZpbHRlciBwYXJlbnQgZmZmZjogcHJvdG9jb2wgaXAgcHJlZiAxIGZs
b3dlciBjaGFpbiAwIGhhbmRsZSAweDEgaHdfdGMgMSANCiAgZXRoX3R5cGUgaXB2NA0KICBpcF9w
cm90byB0Y3ANCiAgZHN0X2lwIDE5Mi4xNjguMS4xMA0KICBkc3RfcG9ydCAxMjAwMA0KICBza2lw
X3N3DQogIGluX2h3IGluX2h3X2NvdW50IDENCltyb290QEJQLW5vZGUzLUJJTkRVIH5dIyB0YyBm
aWx0ZXIgYWRkIGRldiBlbnM4MDFmMHYwIHByb3RvY29sIGlwIHBhcmVudCBmZmZmOiBwcmlvIDEg
Zmxvd2VyIGRzdF9pcCAxOTIuMTY4LjEuMTAgaXBfcHJvdG8gdGNwIGRzdF9wb3J0IDEyMDAwIGlw
X2ZsYWdzIGZyYWcvZmlyc3RmcmFnIGh3X3RjIDENCltyb290QEJQLW5vZGUzLUJJTkRVIH5dIyB0
YyBmaWx0ZXIgc2hvdyBkZXYgZW5zODAxZjB2MCByb290DQpmaWx0ZXIgcGFyZW50IGZmZmY6IHBy
b3RvY29sIGlwIHByZWYgMSBmbG93ZXIgY2hhaW4gMCANCmZpbHRlciBwYXJlbnQgZmZmZjogcHJv
dG9jb2wgaXAgcHJlZiAxIGZsb3dlciBjaGFpbiAwIGhhbmRsZSAweDEgaHdfdGMgMSANCiAgZXRo
X3R5cGUgaXB2NA0KICBpcF9wcm90byB0Y3ANCiAgZHN0X2lwIDE5Mi4xNjguMS4xMA0KICBkc3Rf
cG9ydCAxMjAwMA0KICBza2lwX3N3DQogIGluX2h3IGluX2h3X2NvdW50IDENCmZpbHRlciBwYXJl
bnQgZmZmZjogcHJvdG9jb2wgaXAgcHJlZiAxIGZsb3dlciBjaGFpbiAwIGhhbmRsZSAweDIgaHdf
dGMgMSANCiAgZXRoX3R5cGUgaXB2NA0KICBpcF9wcm90byB0Y3ANCiAgZHN0X2lwIDE5Mi4xNjgu
MS4xMA0KICBkc3RfcG9ydCAxMjAwMA0KICBpcF9mbGFncyBmcmFnL2ZpcnN0ZnJhZw0KICBub3Rf
aW5faHcNCg0KVGhhbmtzLA0KU3VqYWkgQg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEJ1dmFuZXN3YXJhbiwgU3VqYWkNCj4gU2VudDogTW9uZGF5LCBNYXkgNiwgMjAy
NCAzOjAzIFBNDQo+IFRvOiBBc2Jqw7hybiBTbG90aCBUw7hubmVzZW4gPGFzdEBmaWJlcmJ5Lm5l
dD47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRXJpYyBEdW1hemV0
DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgTmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnku
bC5uZ3V5ZW5AaW50ZWwuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBh
b2xvDQo+IEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldD4NCj4gU3ViamVjdDogUkU6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBp
d2wtbmV4dF0gaWF2ZjogZmxvd2VyOiB2YWxpZGF0ZSBjb250cm9sDQo+IGZsYWdzDQo+IA0KPiBI
aSBBc2Jqw7hybiwNCj4gDQo+IEkgaGF2ZSB0cmllZCB0aGUgYWJvdmUgc3RlcHMgYXMgd2VsbCBh
bmQgc3RpbGwgaXNzdWUgaXMgc2VlbiB3aGlsZSBlbmFibGluZyBIVw0KPiBvZmZsb2FkIG9uIGlh
dmYgaW50ZXJmYWNlLg0KPiANCj4gW3Jvb3RAY2JsLW1hcmluZXIgfl0jIGV0aHRvb2wgLUsgZW5z
NWYwdjAgaHctdGMtb2ZmbG9hZCBvbiBBY3R1YWwgY2hhbmdlczoNCj4gaHctdGMtb2ZmbG9hZDog
b2ZmIFtyZXF1ZXN0ZWQgb25dDQo+IENvdWxkIG5vdCBjaGFuZ2UgYW55IGRldmljZSBmZWF0dXJl
cw0KPiBbcm9vdEBjYmwtbWFyaW5lciB+XSMgdGMgcWRpc2MgYWRkIGRldiBlbnM1ZjB2MCBpbmdy
ZXNzIFtyb290QGNibC1tYXJpbmVyDQo+IH5dIyB0YyBmaWx0ZXIgYWRkIGRldiBlbnM1ZjB2MCBw
cm90b2NvbCBpcCBwYXJlbnQgZmZmZjogcHJpbyAxIGZsb3dlciBkc3RfbWFjDQo+IDNjOmZkOmZl
OmEwOmQ2OjcwIGlwX2ZsYWdzIGZyYWcgc2tpcF9zdyBod190YyAxDQo+IEVycm9yOiBUQyBvZmZs
b2FkIGlzIGRpc2FibGVkIG9uIG5ldCBkZXZpY2UuDQo+IFdlIGhhdmUgYW4gZXJyb3IgdGFsa2lu
ZyB0byB0aGUga2VybmVsDQo+IA0KPiBUaGFua3MsDQo+IFN1amFpIEINCj4gDQo+ID4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBBc2Jqw7hybiBTbG90aCBUw7hubmVzZW4g
PGFzdEBmaWJlcmJ5Lm5ldD4NCj4gPiBTZW50OiBNb25kYXksIE1heSA2LCAyMDI0IDI6NTAgUE0N
Cj4gPiBUbzogQnV2YW5lc3dhcmFuLCBTdWphaSA8c3VqYWkuYnV2YW5lc3dhcmFuQGludGVsLmNv
bT47IGludGVsLXdpcmVkLQ0KPiA+IGxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+ID4gQ2M6IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEVyaWMgRHVt
YXpldA0KPiA+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgTmd1eWVuLCBBbnRob255IEwNCj4gPGFu
dGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsNCj4gPiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJu
ZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsNCj4gPiBEYXZpZCBTLiBN
aWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQo+ID4gU3ViamVjdDogUmU6IFtJbnRlbC13aXJl
ZC1sYW5dIFtQQVRDSCBpd2wtbmV4dF0gaWF2ZjogZmxvd2VyOiB2YWxpZGF0ZQ0KPiA+IGNvbnRy
b2wgZmxhZ3MNCj4gPg0KPiA+IEhpIFN1amFpLA0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB0ZXN0
aW5nLg0KPiA+DQo+ID4gT24gNS82LzI0IDU6MzAgQU0sIEJ1dmFuZXN3YXJhbiwgU3VqYWkgd3Jv
dGU6DQo+ID4gPiBIVyBvZmZsb2FkIGlzIG5vdCBkaXJlY3RseSBzdXBwb3J0ZWQgb24gdGhlIGlh
dmYgVkYgaW50ZXJmYWNlLiBWRg0KPiA+ID4gdHJhZmZpYyBjYW4NCj4gPiBiZSBvZmZsb2FkZWQg
b25seSB0aHJvdWdoIFZGIHBvcnQgcmVwcmVzZW50b3IgZGV2aWNlIHdoaWNoIHVzZXMgaWNlIGRy
aXZlci4NCj4gPg0KPiA+IEFnYWluLCB0aGVyZSBpcyBhIGF3ZnVsIGxvdCBvZiBmbG93ZXIgY29k
ZSBpbiBpYXZmX21haW4uYywgaWYgaXQncyBub3QNCj4gc3VwcG9ydGVkLg0KPiA+DQo+ID4gVHJ5
IHdpdGg6DQo+ID4gZXRodG9vbCAtSyAkaWZhY2UgaHctdGMtb2ZmbG9hZCBvbg0KPiA+IHRjIHFk
aXNjIGFkZCBkZXYgJGlmYWNlIGluZ3Jlc3MNCj4gPiB0YyBmaWx0ZXIgYWRkIGRldiAkaWZhY2Ug
cHJvdG9jb2wgaXAgcGFyZW50IGZmZmY6IHByaW8gMSBmbG93ZXINCj4gPiBkc3RfbWFjDQo+ID4g
M2M6ZmQ6ZmU6YTA6ZDY6NzAgaXBfZmxhZ3MgZnJhZyBza2lwX3N3IGh3X3RjIDENCj4gPg0KPiA+
IC0tDQo+ID4gQmVzdCByZWdhcmRzDQo+ID4gQXNiasO4cm4gU2xvdGggVMO4bm5lc2VuDQo+ID4g
TmV0d29yayBFbmdpbmVlcg0KPiA+IEZpYmVyYnkgLSBBUzQyNTQxDQo=

