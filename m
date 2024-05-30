Return-Path: <netdev+bounces-99510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4178D5186
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B2F1C203DF
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712A47A40;
	Thu, 30 May 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUQNqfg6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAF9219FD;
	Thu, 30 May 2024 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091682; cv=fail; b=hCzlH+1TyQkwF2yn6SOXf+kSE3yI6nPYYczF/oQpg12nQsO4mvBMMP3SchBuPocmUb2iz/L3zsGE4/PEMOH3li39oKfAR5Z9Mi78jyJC7jnTJyXGT3jnmMwZ183u3kfeUvF89eRqweKhgYvTrjrIvh672HN3cVx0TTlVCzwlv8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091682; c=relaxed/simple;
	bh=s8NyHN7JLSQzzmcDl1Az856x+99tXsw8t69e2xB+pZE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D/7aLd1M9TF3PPROKOQqe91owZtHE68Pckmfzt6aev4UAlaGDjE1JbvGzLySSEui+yk+W7l86ACN9+G58XNthqZLEA60wM2psVN/jQWGAY2onkMJfT1TPaJa1ajsobM86zIRisQMzU5yKrbF9nQ8uJ2l9Qn0ZimoDBiNMnQwyEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUQNqfg6; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717091681; x=1748627681;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s8NyHN7JLSQzzmcDl1Az856x+99tXsw8t69e2xB+pZE=;
  b=KUQNqfg6vaSuyZJFaF8e5HREyg3J9VRmj25GgghLy+X2NPRslm9f74FQ
   PIg75nxZ5CCvVpuoHgiSEVQ8cc3EUEDK63HGCDXqRYHoBOQiOROx5+JSO
   1blNuPyk1fi49pjwDGWWppWmYKnB6CPAfVn3DaZimMyO7HnUB7RlQSekV
   dUGKjBD7WJNQx5el2XfK/DawkCl3uBXikjQE2tcZqRhAaeqZNuaQyFfjO
   +TcWv5DNtsHBWzY1yJxE8KbWDULKGhMzv7DqdltYSGWvYDkIWywiXc/pO
   VYPvMwOcScgIgf699GVIWWyV0ykBqNUs7IYoCtGB8o6m6sb6qikQjgxGW
   g==;
X-CSE-ConnectionGUID: m9VZM+EgTfuCKBKpYcjz+A==
X-CSE-MsgGUID: 7VOMmoMaSR65TNGCY8rjag==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24227532"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24227532"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:54:40 -0700
X-CSE-ConnectionGUID: cw9X7ScWRHqdLyGJqT03HA==
X-CSE-MsgGUID: UrPPXfC2T1q3JMWk3AM4pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="59072057"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 10:54:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 10:54:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 10:54:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 10:54:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 10:54:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy44Ntyec3N4CHqGCnxkgGNbal3r7yTftWFkPfHPAeKYFFh7VE4se9SvWngPyAKiCGUXBVepj/I5J4f3r8I0C5IqN/bETlPE2XPXvVmqEPG56nHPGVwYQS+WVEzLAH1tj7RyPjrMxezJ7JwGDHXU9h7rUgwoS9Kvt1nQe5KwV3vfUUwOHGgPARCz7NlhrQikjzOxs7+4MQp3HW0FccS7F1FgVDZnRY3QJ4wfJnih6qJMukxeMvicIXMe/yz2GDYBq01hCwzU2cQYA3ENqbFntqb+FfXY8u6hZnYvXoroJC9zKykOrTFh6IB4mPsE/9m0AJxSignXUQ1iwnX9NJ4DoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+Y5i7CfCP1Hg2AHBHb3dR7aRU63PIgJBKAySm14y/k=;
 b=Z/j2cYS0sCl+c65OvfUw/2Dd3PrY5SkrNMI3xGRMaFdj3k+HQu0pPy0yNu/cqNYzDbCAwRxsCx5+Br+kOt8AuFnhtLbhXQXUMatPKMya6RbqQYo+Xhqj4SVDVYPqLuYWK+cR7M718bFxH9pW+AKEP7DM8FlgdtS/D016oDTHcJVGxeyl2XGiPkJxz2Zyd+OO2fYxABI2OKScQPere/Qw10RLGR5BjrUcMOX30K5lbObfZLY9Eqp7E7Hw5TcPZe/vl0yx5TdUv0BEygSE2ANwnuS21VDplUl+az5savFAhDJwbbeeafv8MS6MO8GSUMhRRvZYtTzknBuHNjXQJN+/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7774.namprd11.prod.outlook.com (2603:10b6:208:3f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 17:54:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 17:54:36 +0000
Message-ID: <2f1603fa-d03c-412c-895c-bc4afa06834b@intel.com>
Date: Thu, 30 May 2024 10:54:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ethernet: octeontx2: avoid linking objects into multiple
 modules
To: Arnd Bergmann <arnd@kernel.org>, Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
	<sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>
CC: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Suman
 Ghosh <sumang@marvell.com>, Simon Horman <horms@kernel.org>, "Tony Nguyen"
	<anthony.l.nguyen@intel.com>, Jiri Pirko <jiri@resnulli.us>, "Mateusz
 Polchlopek" <mateusz.polchlopek@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240528152527.2148092-1-arnd@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240528152527.2148092-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:303:6b::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa42e09-1c8b-4279-f936-08dc80d1920a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2ozMW9GSm5SRTZ1c0ZqaDBBK1hobUkzei9OUHNHME1HeW83bXBtS0htbkJL?=
 =?utf-8?B?cEZmTXA4WVlHVVBIUDVpdG9qQko2STNwb0ZnUm5waEM5NEtiOEt3NFc5Z0pI?=
 =?utf-8?B?R0N4MEhMeXVyRy9xY0pBOGZicjByeDMxemhmWjRWbXcvZDZaWndvU092N0t6?=
 =?utf-8?B?bWJQczNLcjVzVmx1bHNCd05BUWJKdXJDUEhLRUJRcVQ5R2t4aHZIMUhzb25w?=
 =?utf-8?B?QnUvWkR5WWdsU1Q1RE5DN2tkTzJSVTlLWE1lcWJIeDk3ZkpzdzBRbi9oTHFN?=
 =?utf-8?B?SGdSYk1vOHQyaWdsc2dFSTVRYkExK0VIVVY2UFdjb3R2MFdmZStRYmV6UndH?=
 =?utf-8?B?MGFQWkxJUC9HalZyaEs3bXRaTU13UzJjT1VFL3ZQUkJUTHVHUHJSU09ZTDBp?=
 =?utf-8?B?N2ozQmVyR1plaG1KQm53VEl6bXJ5Qi90MkJ4K05vMldFN2x4ZWJSTU9hTVpB?=
 =?utf-8?B?WTdKZFhsc2J3USsrWWVYZFBKeno3STZmQWlUZHhrQWVCS0NwUWtCUXRrRnRH?=
 =?utf-8?B?by9WcTlqTGtiK3hoTkVDbGR5WEd6bVY5S2FTTG5WQWM1TEt5VkNvZmRKWDRs?=
 =?utf-8?B?eFlIdzJnYnUwMVkyRENaRmRSaGRGdm1qTUR3NUlOT0prRktVSXFJajRNQ0VM?=
 =?utf-8?B?MlBaeHdkYy9HaW5QaUlUKzNnMnZ3dnNXNHAxVi8yMFRSZTNSd0Z6ZzkvK3lN?=
 =?utf-8?B?alozVGV0U1RPL3J5WHA3d3BlTDM5OURidjhtQkVjaDZ1SGNIeG5XdmpTZTl3?=
 =?utf-8?B?cTlrSGZvd3cxdEJxVFlIbk1HMTRxWjB2SFliamFDd3BNbjBia3d4cjhJbXF1?=
 =?utf-8?B?cWZSa2hDTThWdDc3SGFwS3pVMVA0NkZMcXZJUjA2NWFyTW9GZXdCbnc3a1My?=
 =?utf-8?B?WmdOTDVlb3p5OVdQSExHTTY2TDZMOUF3SVN6QjBmMEpqNkk5bUhaaFVCZFlS?=
 =?utf-8?B?ajhmbjU0N2FDMWpoMXBuOEIxZTRjSklWRTA3VDRrbUlhZjRxcHBjS2FNV0Yy?=
 =?utf-8?B?dGQvVjVYRGI1RitCbnVDR1ZBWXpXaHpPdGZZUTFXcjNLWUlSZG5aenF2em9D?=
 =?utf-8?B?WngrV0lBOEd5bUwzdHNFY3hsV212aVFrR0x0aG5FSExWaWhpRDA0ZHk3aUF2?=
 =?utf-8?B?VWhJSHlTclRRTk1uaThDT1BtYkF0UjBjak9UOUJiNFBja29Lci85NjZySzVZ?=
 =?utf-8?B?YXNzRDZ5WkRUS1NnQ1dma2tycWo3ZER4dnc0cTNlZHMvMjZJVG45ZzFzV0ph?=
 =?utf-8?B?dEkrZTdQR0gyUzhBTllzemFWSDZWelZSRm56TW1Lb0RoL3VzQ2RSY1B2T25w?=
 =?utf-8?B?bktUL1hicGY2Vy85am5IVkRHa0V1Tm9JSGZJTHhtcmJHa2ZVNExrMGE2bkxW?=
 =?utf-8?B?NnFMa2Zvb0ZPOGtTamJsOEt2bE94YzdGVzAra1ZSWFF1Yk1EU3Q5NGVwZGpp?=
 =?utf-8?B?YXF2bXBqSzN0b09vaEF2WnVnS1JjbklqRXovWCtObituaUlURHppWUFQWVVT?=
 =?utf-8?B?b1EzcnpDa0hmUU9xQXJWZEdJSjBhMXJOalNFcStUK3hTSHZkUm8rSGNuYklk?=
 =?utf-8?B?SUZ5SVZXUytQVzhRdTg2cFllQTNtNGVBcFhKMTlwSzczRkxHZGhjazB1U3FW?=
 =?utf-8?B?b1kyYW5mdW1BZFdUOEJNU0lHVFFDeWl1VEgzQW9xYWxrVUJVNHkwYzY1RkE1?=
 =?utf-8?B?V2Z1VGdPZDFtVmV3ZmF1Q3d2UjgvL1pjVjBWdThnWHlYZjRxeW5yWFBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVdsdVpWQW40SFpzOFJOS21nV0ZYVEZyVXRQQXdIREFWQ1FpYUlTbXJWTzVF?=
 =?utf-8?B?UWFvekhVMWFKZkVsNFBUVU4rTjZpTTRaTVdDYUVjWHVRbytQVzRaTTNSM28w?=
 =?utf-8?B?SGQ3UVI3bmhRbGNZT1U2M1Y4TzNQc2xGTThqOXpWMzBwSXJ0b1lza0ZUL044?=
 =?utf-8?B?RHVZZ1VSd2FNS1NiTEhlNXY3ODJZekxiTUZ4RGdqUlgxNHgrTm1VQU1sWUVh?=
 =?utf-8?B?YTFNdWhmMld4SFFYWDkwUnRiVlFDNXZHcEl6TDUyVWpaSmdwc1RGeWx6VDBD?=
 =?utf-8?B?ckIrOGYybi81dEw1RG9nWGUxbjU1ZWprM1B2QjhnRVpGSkRMY3FQYTNZUDhp?=
 =?utf-8?B?bXB2a2l3dWl5UUZuWmNmTktJY3czeHdOMk1nWjBwQjRGekdaMU9JdjdoUEdF?=
 =?utf-8?B?blRhNXVjOXhXR3NSdHl2eGJvU0ljVkJSNldvU3FJTElGLzBIQ25FRkkvQmFq?=
 =?utf-8?B?bWtYTVphMTVjVmlQOGpOd1Q0cDVyYk80TU1meThsVG5UaS9yMDFseVdvSzlC?=
 =?utf-8?B?TzZUYjZTeEx4d0RYcVhZd09XczhWZGNhQ1NzQ3F4dnBaN2FTZGtmeUxWSE1P?=
 =?utf-8?B?SG41TnkxQ2hKeDc0WWIxMTU3bFFYSkREUUE1ZWVXbXQ3T3drY1BxNXRqUzNj?=
 =?utf-8?B?dE10Nm9BYXFxNmVtMk83VktaRmNUYTV3VDRnTDcwd2hKM3liNFZORElsSWN6?=
 =?utf-8?B?RWhYRmN1RlZPYmZFK3IweXJCeFk0WXhjTWYvMWMrYWNzOXJPd2gwWVhBRHVG?=
 =?utf-8?B?di9tMEhlZ3NSR25OdFU0TExaNVRDcFdhNVV5YUhpRDNnbHpKOWdSSEMwT1JN?=
 =?utf-8?B?ZHBqc1AzYWhkelFXaCtQaytpRkNEK0dad1ZTb1doOWZHeXJvR3ZoWGltY1o5?=
 =?utf-8?B?Sm5pK2hrZWZqTWhVcnNpSGhIWThEUEtPZEJZVWd4NjVMb2tZeUptK2h1YTNo?=
 =?utf-8?B?alJuUkxZMWs5ZFh0WlZ2R3VJeGFaOUFtS3ZMV3hJajN6bkxldzNCRk4ycTFZ?=
 =?utf-8?B?VGhJSGRBNERUYnVhQXA2ZnRJM0hDODRtc3FxajhJekxqVk93N2NVNThKS2ov?=
 =?utf-8?B?MXhVTWFSZUUxOXkyb2ZKOFlsVTBWcVZkbWZ5SVpaTHdVVW5xTjdpWW0xZ3lL?=
 =?utf-8?B?cFJKc3N1WjJRWFZMUnVWWnJzS2pXdVk4YVRFMFNjYTBRZmRPTmF6U0JZMnhN?=
 =?utf-8?B?VURlUkZ5QS9ya3REelhUZzUweVFqUWVGS2dwZm5kK1ZvZzJhcFdmWk1HUW9k?=
 =?utf-8?B?d0t5WUxFSVFCTm9VNzdLekJwbzJyWE9nUzh3b25ZRDJ2bHBPRHk1WTh1dkVC?=
 =?utf-8?B?QTVaOFV3djdOZVJwdUNzVUxaVDg2REtRK1Nodms3dmxSc2gvbzA4c2lxSm03?=
 =?utf-8?B?WVd0UkJzWXNBRHNpK1FLcUJQWTNZd3BSejQyS2p0bm9jc1R6TjI1MGFpSi9K?=
 =?utf-8?B?SWtRTHljZTJjOExKZWQ4NUFVY0M3eVZlQk9iK0txd1RYb0VnbUhMRUZRQXRp?=
 =?utf-8?B?RHAybEJKdzF1SzRsTFAyRGZEdnBxRUdLT1pIVFFpSTdURGUvZER2OFN2Ny8v?=
 =?utf-8?B?Z2tWS2dsTW9wbi84bHp5OG9OVnlrczk1VDUwazd5Y1hmU1liSE1MZGlucGpi?=
 =?utf-8?B?Z2pVQzZneGQ0UE83Qkh2SEFuU09qWWdDczMxeTFqRzBnc1hSdXg3MlRFSk13?=
 =?utf-8?B?TU1QV0JWUjh2VGh3bHlFZnFCNkI1WWpqVTB6VVZEczFxOHdFTDBXOW0zaW8y?=
 =?utf-8?B?blJZQW5nRFVYUFlKYjI3QUo3M3B5N1lNeVJtRDNFS1dQRnhOSlBDYmZaNDEw?=
 =?utf-8?B?TXN6T3plZzI4SXNxV1ZEejQwS0NBeTdIVFRoUllhdWxyWENRMVZNdy9aV0xm?=
 =?utf-8?B?RmdyenV4MXVTY005anpmS1d3bTZzb05XSktMVGk4Y2hRdXFmY0JxTS90TVlv?=
 =?utf-8?B?MnZNSytRekYvOW1zNE40UGh0NDJDcEVLanRtZHFYMEdOdWRoVWhhYUt4UjZk?=
 =?utf-8?B?eUpKSW9Ka0RTN0JiZzJpK0lScVR6U3JEY0hNWmRUdU1pSTVSMHFlU1B6a0pw?=
 =?utf-8?B?ZzROYjRUbjVqRUxRNkdLOUVNazhidVZDaWRsZm5JcVBRWTJDcEZoSk01RTNm?=
 =?utf-8?B?cmJQZFV1aE1ka0RVOS9RT1gvNG91eEFWckloajZZNTQ2YVh5b0dFSkZhd3pl?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa42e09-1c8b-4279-f936-08dc80d1920a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 17:54:36.7205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NA3vauaP2tFfkXhryx23g3GkZbmk6tB/vt7yKlgN0Oi7RNHxZ5A5c7QedJckQvYUtoDfnFJKXyIvTB0XWO+GM+eLjdseC/G71+iXO5faiiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7774
X-OriginatorOrg: intel.com



On 5/28/2024 8:25 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Each object file contains information about which module it gets linked
> into, so linking the same file into multiple modules now causes a warning:
> 
> scripts/Makefile.build:254: drivers/net/ethernet/marvell/octeontx2/nic/Makefile: otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf
> 

When I tried to build, I don't see any warnings produced on the current
net-next with W=1. Is this something new and not yet in net-next tree?
If not, how do I enable this warning in my local build?

> Change the way that octeontx2 ethernet is built by moving the common
> file into a separate module with exported symbols instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

The change makes sense to me. I built and tested both before and after
this change.

On my system, before the build change, the driver built to 3 separate
modules totaling 2029176 bytes:

> -rw-r--r--. 1 jekeller jekeller   72104 May 30 10:46 otx2_ptp.ko
> -rw-r--r--. 1 jekeller jekeller 1774008 May 30 10:46 rvu_nicpf.ko
> -rw-r--r--. 1 jekeller jekeller  183064 May 30 10:46 rvu_nicvf.ko
After this change, the driver builds to 5 separate modules totaling
1977984 bytes:

> -rw-r--r--. 1 jekeller jekeller   81480 May 30 10:46 otx2_dcbnl.ko
> -rw-r--r--. 1 jekeller jekeller   19784 May 30 10:46 otx2_devlink.ko
> -rw-r--r--. 1 jekeller jekeller   72104 May 30 10:46 otx2_ptp.ko
> -rw-r--r--. 1 jekeller jekeller 1698880 May 30 10:46 rvu_nicpf.ko
> -rw-r--r--. 1 jekeller jekeller  105736 May 30 10:46 rvu_nicvf.ko

This is a savings of 51192 bytes from removing the duplicated object code.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

