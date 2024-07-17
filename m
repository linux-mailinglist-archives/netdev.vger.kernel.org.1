Return-Path: <netdev+bounces-111918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D605934192
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8000A1C20757
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8904F1822DD;
	Wed, 17 Jul 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mxfct6Yw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA61822D8;
	Wed, 17 Jul 2024 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238198; cv=fail; b=fza+VbNUEft0D2UtF0DstoSpKoNXoJT/gH6wqyze+Weet0mmmhxrVknjhODw1bM0pIEMHm4L8+kN8MgxafW0Uh2iAaa47JtdPXX/cui5oQP4QzyzMJDO6x/P3h6VBBFr73HRE3GugxGP6YSjmNbX+YgYHhzzI+NC6kAt6KzWoKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238198; c=relaxed/simple;
	bh=W6gd5YWgxg8t07BQYdAI6n6AlLkyY8tQHcJYX5vC5rQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZEetsxWbTNhm6ZMZsvfmEJ/72FNJLEWMTxowYJz/JcretUscz1+nx5FrkvQQBKChX4DRkkNCAwK42K7wUYgBC2F+4YuwquK5DCCyID/atRHaHs1riyn9BqP9KGnkumDQjlieb2smn248t1/jpLbg4HNM9LJYvGr9dEHQC/lPw2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mxfct6Yw; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721238197; x=1752774197;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W6gd5YWgxg8t07BQYdAI6n6AlLkyY8tQHcJYX5vC5rQ=;
  b=Mxfct6YwVEQutJccDGdoJosLaqmebjIZPCbVwTrYRUj1+HzplS+LSibF
   29r5PntjpuEjW6GvGFPVWVA6CLShl1NKCysYy1ekjKom5Fc1bw7Lvag/X
   QZJrE0ZsaXp1g6kCWKmJrfdSuL6kDM+fLecp32jKFsJDBTpCezh9groBG
   03SE1RJbhh0esI1atC2yGTukNryw9we8+0YfFdFphP6hVwxBFtQcR1sC2
   LfDtuj7x7QzhbIlVB1gOII0ufe/YK997xxIEMxpON0BR0DssN+uPiKL5l
   OA1v+4nnVsJcVLupEtiO8AOIBHARcEN37nzOet55hi/nzq73DxQxbLv7t
   g==;
X-CSE-ConnectionGUID: k3tzaiqkTz6ktFFpyOs+hA==
X-CSE-MsgGUID: wLguy2+ZQlucrvDA2+nM6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="44182892"
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="44182892"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 10:43:16 -0700
X-CSE-ConnectionGUID: uI4TMNQ+TmCCZLRaU9LSlA==
X-CSE-MsgGUID: eHV5zlUJROa+HhM6vzZVEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="81120220"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2024 10:43:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 10:43:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 10:43:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 10:43:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 10:43:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuGVW3x/tEqGXLEFeDMFOwlO82lnufCPrZ+KVWBevxiL//UmFH2MHndtB6cp860xv8y396JeCfth/w6VZE6nByIMVw5BoDJk+H+jqqbbR3FRgPt73ZlKsVOAdOK7G9N13vJz/oAqLe+z0NrEsj15RQxt8R2Du0TKkKHr7g8aC2tHwqGlhD5mlJqYdlaCNmBkDgAXxI4/JfIuZPu24WcdY0Qs5zYxj4CjPIIHLIm2WzE0lb9HCdP31TnWoH93cHURRp08nqoyzC1Q22sfn2HxxhUUoV8OCwT8+NS1sQ+mAUA83OZItr5px3eN6Br/rokZ/sO0Ba1bSlb/E7f9le9d1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lYdE0uscGeMR02I1PWtwZ7LyaxJh4lwwaYwg0UcYPQ=;
 b=cNFRC/JEoWVLGgImaL6CWDvyRcDqowdgT+hYPfZbC4zOkdNGj6/bxT5nhMh0fTcQH/PIJ+FFU5tzMObuuq7E3ICACCN1OXsiYgt4GI+OWy9cXcmKrLB45UABg5h6OtUknBx2Z3XQxavI06Cp5EsyIhMUrZsbgDVX30W0qqk9FLHHO1M+6pyRgy5HXV9hSQNi4VFQIOjX5td/zhPs/F1ixzoeG2KxMxyR2m1I/tVRUQ6cLc6CjM/UOjXkSglNA7YUAMpf4BzokRfapA+RAvuR4M13M2kuAgAHRwU8Tke3BJVnKAupT85XvVtskrrw3nIjMqcRj5O82EAQyH9KDV+ORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 17:43:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 17:43:11 +0000
Message-ID: <f16855bf-ae2a-4a0c-b3e9-d25f64478900@intel.com>
Date: Wed, 17 Jul 2024 10:43:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 13/14] net: ethtool: Add support for tsconfig
 command to get/set hwtstamp config
To: Kory Maincent <kory.maincent@bootlin.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, "Radu Pirea"
	<radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Horatiu
 Vultur <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>, Simon
 Horman <horms@kernel.org>, "Vladimir Oltean" <vladimir.oltean@nxp.com>,
	<donald.hunter@gmail.com>, <danieller@nvidia.com>, <ecree.xilinx@gmail.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-13-b5317f50df2a@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-13-b5317f50df2a@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::43) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 83568b93-1e38-417c-b830-08dca687edab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bk4xZlUzYXEwdU8rVU9ZYWlJcXRHSmpCOFRDeTcycmxCT05TTWZidnBkcFlF?=
 =?utf-8?B?VDdQQXNVNFg1ME4yd2tEaGUvbGl4V3VNM1QyMVBDWFlrdUVpMVNiKzFEdTI4?=
 =?utf-8?B?N1ZVSjZKSmRWU2ZPaWFpQVFkYllXcGFQbFpHK1EyNEZUbHgxQkVxaEFNS1RU?=
 =?utf-8?B?SlFLMjN2cm5rZVpQRk9ncjNuTmJ0a3lLa3FhY3o4d0hSdldsV3V6SmxtNUJx?=
 =?utf-8?B?c2J4YUEwZUU4NTBTUElWdElaOEYxNk9vN1VPMkZlVzgvTkRzVEhLVnhyNVZx?=
 =?utf-8?B?eU1LYjB1UElCVlNOVlkwdlVPNEsvT1JPdTBDWGs3UVhkbWgrOXhFK2piZXhi?=
 =?utf-8?B?emh2SVJ2VXJSckN5cWU5MkJlV2xXbUlWeTBBOCtQbU82Vmk4L1VZRzV0WGpq?=
 =?utf-8?B?UFQxNE81UDBaWmdOWXI1MURCNjdCYThheGVnVWVLcGh1TUUrZVBUbVhmUTIy?=
 =?utf-8?B?V0FIRkpXeGFuTmo4YkdDd2w2ZktxTXVIcWlLMmdaTUFwVnVybUdBajBTZlp5?=
 =?utf-8?B?ZTRZREx5eGhUSE00SSt4ekJvSmJvL3h3LzhFOFZFQzQydWZSMCtiaXdYVEZD?=
 =?utf-8?B?MzRPNU5xQVpKUHNLUXBHTHQ3WlUrMm1hM2NUd2Q1cWgrL0o4a1VwRytoaWRL?=
 =?utf-8?B?T3ZBTzYwTitsUWlteG9ia1ZBSWIrNEpxc20ySWFNeXFaOUV4STZydWhRbkx6?=
 =?utf-8?B?YlpBZUdWSWR4enBvTWxSekNvWDJFWW41WEVqVTczei9MOWtpV3JXWHNCYWRN?=
 =?utf-8?B?aFprcjhKK2s3ekJSRjRmRzBsQzZJbGszVkc5QUdEV3NTeWxEL0hVVlh6R3B0?=
 =?utf-8?B?ZlNGclExWHJBeHBSQVVUS0V5WVpGS2w0ejdsRVg3SUQranVFOCtRYlR3bjhq?=
 =?utf-8?B?VVdES3k4QTl5OGx0RFlycGFWbHBiL1NoNjJ6cGRxeUthaXdFbzJxem5zRmNC?=
 =?utf-8?B?ZUIwVVB5VDJHRlhzdGRQQTVDd2hUWHZsYzZDbUd2VkU4UHhnVXlyMzRkVVpq?=
 =?utf-8?B?bVQrUGFocFkyU2Q0aHFQbDlUeFZ0bWZzNTdYSkN4dzExeFlYK0pkZjN2RG1a?=
 =?utf-8?B?SE5SK3lqL2xGR0pnTkx1TVF2Y2M5YWR4dm9GcDBQQ29JYUNwNFkzRUlSN0lB?=
 =?utf-8?B?VG1XZXZjS2xYb0NxeGV0dHQwT3hJUWFMSDF1UzJqdCtmbCsvR3lpTllDaE5B?=
 =?utf-8?B?d3liSThYOFc5VVE3akF1YnRQeTg1eGRlRDlzaTVZajNDdnc1RHFsOG9TcGUv?=
 =?utf-8?B?QUl0NWNwM3dVNUM4Z1hKVlRhaWJVMFJzdFJJSVZLczEva2xoaGxHVjJ1dWlG?=
 =?utf-8?B?U2dFQ1FJZzFhQ0ltOHArcUVhbEdNNWxseTVGVWVXSmhnL3RBa3YrUUl2N2Iv?=
 =?utf-8?B?UEpPdWxNYXBtMXcwTVlZcTlqendFT003K0FrZy9sb01scE16MTFsZWVMblJW?=
 =?utf-8?B?TEowV0d0dXYxM292VzNVaVlQSXBUblJ0S21IWUVaL25tWXRVd3RIdWxoRmRn?=
 =?utf-8?B?Y1MrSzZ4V2lnY3A0K1dsZU41ZWRyaWdOMDNhMks5eTduRzZMTEh3M2tIK3dV?=
 =?utf-8?B?cG8vNGlrUDB0YnVLZFE2SGYzTjNoNStIL3hjdjZLZjgxb2RmdnEzd3VUYjNY?=
 =?utf-8?B?RG9JdFkybzJCU1RJalJnamd1V1E3SVR0eDlrQTVxUjdpVDRTdTV5NVpHaVZH?=
 =?utf-8?B?THlXYy94N2V2anp1MlRNaFA2cDVxVTU0T2h3TFlZdlZpd0h6N2pmOHpaYVBZ?=
 =?utf-8?B?elp4ZnlLblRNTUlhNjdyUGJwQkc0VHpndzR4K3p1QTN6V2U0MFRlamJGWWhk?=
 =?utf-8?B?dWRGYkVHcXYrV3NVUUg4a2hrd3JlbHUxcjNOdzFXOXY5Y0lOTjVPSWlOQy9j?=
 =?utf-8?Q?QXqTFd/pKSGUp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djZqOUxuV05CSHJYOW81c2ZnUUZ1SVFFNDB2K1dSbGFKUnNnZEJRY3lSQWZF?=
 =?utf-8?B?bC9OclVrUytIZG9WRUxNVW5RTGVydXNDUmN1Y3NhODNHL0twZmpqZUlHbHlV?=
 =?utf-8?B?MGdxWWRwWFRnU0VwOTk0SkR5eHlkVFlxM2plQzdJQ05WSFNITnRWK0tBZEFG?=
 =?utf-8?B?SS94U1hmdjRlOXZjQXNNM2JSK2p3NjJYOHQydFlSZFJtMVZYWng2RVpJWmRF?=
 =?utf-8?B?aXNsQ3dMTU03UG9NRlA2dW5UNmFaRXZXdmx0b0VKVEcybUZnY1BBWU5GV21Y?=
 =?utf-8?B?eG03TzJnaC9LZXpoZUpaTmV1L3o4YUZaWEN0dXQ0UzNYcHYwdG9KV1JtTHJL?=
 =?utf-8?B?N1pPQ01jbW0vOTRVK20xL3VJOWxXQnBxaURWdzcxSmhHd085U0xsT25UVG9D?=
 =?utf-8?B?aHFtSEJSb0pieVQ5SG1mY3ZYVTBndUwydVFjbzZKVUxuT2tIQjdwczVXL1Yr?=
 =?utf-8?B?dlRFejQ4U0VKVngvTDhwcUFiR2FIY0pmMTZwTytlL0dURWkzMU5wMUE5Y1Q1?=
 =?utf-8?B?a2EyaGZjWXlqN29YYVpHODg2bVVoOFM4KzlUOHRNZHBPcG1GREwrYVBReTQw?=
 =?utf-8?B?alZMQ1d0TDlQaVhVaVhYVXltK2gzb3BIWUpYVXdaY3JOajR2QitvV0RSbGww?=
 =?utf-8?B?alNoM0plRTF5V2E0Q2JVVXhVajN6TlU2dzVpYnRpWG1CRElRUTNPMW00QjJm?=
 =?utf-8?B?WWlhZk4rdm1EK3p3SGVVR09tNW1sK2dGU0FhZUxnL1VNT2FGQmNIMUN2RTJS?=
 =?utf-8?B?dWlZc0NSWldZOEI0WE9QdDZNT29vYUJkS0U0SkpkSGxSWHpMUVNURC9mOUVX?=
 =?utf-8?B?YmM2b2pKaXo2T3ByZzlxMnhCRGVSMDBuMy9xbFJSNHFTYXZ0d2ZaSEhPQ0E3?=
 =?utf-8?B?Ris1Ukd3bjkvemN2SVloV1dTSGNVQ2Y2WmMzODhGRWJLMHZHOUZNTDBvNDZm?=
 =?utf-8?B?b0V4M3Fhc0VOSnRDNUlsSTEyUW1OVnlSakVsaWVHZFBsK09LVEYvdWt0M3p3?=
 =?utf-8?B?TyszenhzbkN5U3FoNTZQN0gxUlppZUZMUXU1bHdZVG9YKzlDQ1BWSHJnU0xG?=
 =?utf-8?B?a3dOWG1aTHhlckpIeDZMYXdrTTV2Rk9IdVdiUHkydmJZWWl2d1NJei9HVWZW?=
 =?utf-8?B?TnpxZ21qVUxnR1ZGYmxYOUhyMVYxTmlCOG9JSVh4L0JZWXExeUZaVjlsVkVt?=
 =?utf-8?B?SnhUZDZ2UjRKK010VHlCUC9Rd3JWVk9sVERIYnRHZmowMUpXWVZJSmM2WWZB?=
 =?utf-8?B?dUNFaEd2TXRGU3VSbjNMWVJ1SDltUnZJTTZHQjQ2bk1WeWp4YTJLVitPRm9s?=
 =?utf-8?B?YmhwaGlPUWlZdXBIU20zdHBXcWV2d0dad3ZvRk5iU3JFbzB4bVBXTmpvcXpp?=
 =?utf-8?B?VkYxSGxrdG83bG51RkFPVUlmYndwWWVXRzJwU0FYV244MWcwU3hHUzI1djNL?=
 =?utf-8?B?Z1VFdGwzcUtGNWdjQ2poOVR6bm5Jc3dITTA5c1RUbE13b3lJbjJhUUVselBE?=
 =?utf-8?B?SWJ2cnlvSE9yTE9lTi9BSlJVL096SldDenY2S0lDdUZaQVRER054VkFYekNN?=
 =?utf-8?B?OE0zeW5VbVF0R05VaXJsenl3ajZ3R09nQVpmUjR6NE1SNjZNZk5oOTFPQ2w4?=
 =?utf-8?B?RHVyZVFIZkRxRTloZFlhbkVQdkF3WFdkM1A3dUsrS204dWJFeThUTS9yYlRE?=
 =?utf-8?B?eXpsQ1RYL1JielVENWdiYlVWM2RrdXJFWnU5YkFvTUJXWmxKaDMvbktDeDU0?=
 =?utf-8?B?eDJVZVZlUklvdW80NGtjaXRhaHZwRmJIQmYxREFSeC9NMmFXY0NJL3ZVN3hH?=
 =?utf-8?B?Qk96WWVpaXJpMkNTRzI2NXNlQW1aZ2VNazI2aTZoQnZicHp0c3J1SldubXBt?=
 =?utf-8?B?WFJKUHlKdkUwSVpnSXFVSWpFUmg0c25xczIyWTFTdUQ5ZEZJbnBpTjFGVXl2?=
 =?utf-8?B?WTdwTlFUczF4SFZBOHEvQW5QQW5IbTFTaVRaSzNYZnlaSkVtWUZnd0cwajNH?=
 =?utf-8?B?MlhuT2tBa0txckpvS0x1UHgwVmxzTVRTMEVKRE5tKzRFektqUktRTHJKS3Bj?=
 =?utf-8?B?c21rOHJ2RDk3amNZVHIwY0NjSmpLWnYvWEdjb2JzVm1tYmI0ZEt3UzdiL0N2?=
 =?utf-8?B?WlNmbzVVTUdEUzJjTzMrVUZVbDdwczN4M3RVTHJLL0dQWnhNU0g3U1FXZnNT?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83568b93-1e38-417c-b830-08dca687edab
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 17:43:11.9082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIhNQJuoicu+BXiJctl8c1Kg/g4GjqkIGFpzc0WaaFS+dzRawJfql01CZFzV8vdfBtJ3P+ljVE+IvSJjM42dDavTT62aZHIuoW8LPpygNEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5150
X-OriginatorOrg: intel.com



On 7/9/2024 6:53 AM, Kory Maincent wrote:
> Introduce support for ETHTOOL_MSG_TSCONFIG_GET/SET ethtool netlink socket
> to read and configure hwtstamp configuration of a PHC provider. Note that
> simultaneous hwtstamp isn't supported; configuring a new one disables the
> previous setting.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v16:
> - Add a new patch to separate tsinfo into a new tsconfig command to get
>   and set the hwtstamp config.
> 
> Changes in v17:
> - Fix a doc misalignment.
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> +The legacy configuration is the use of the ioctl(SIOCSHWTSTAMP) with a pointer
> +to a struct ifreq whose ifr_data points to a struct hwtstamp_config.
> +The tx_type and rx_filter are hints to the driver what it is expected to do.
> +If the requested fine-grained filtering for incoming packets is not
>  supported, the driver may time stamp more than just the requested types
>  of packets.
>  

Does the core automatically handle SIOCSHWTSTAMP and SIOCGHWTSTAMP in
terms of the new API? I'm guessing yes because of the new
.ndo_set_hwtstamp ops?

> @@ -531,9 +536,12 @@ Only a processes with admin rights may change the configuration. User
>  space is responsible to ensure that multiple processes don't interfere
>  with each other and that the settings are reset.
>  
> -Any process can read the actual configuration by passing this
> -structure to ioctl(SIOCGHWTSTAMP) in the same way.  However, this has
> -not been implemented in all drivers.
> +Any process can read the actual configuration by requesting tsconfig netlink
> +socket ETHTOOL_MSG_TSCONFIG_GET.
> +
> +The legacy usage is to pass this structure to ioctl(SIOCGHWTSTAMP) in the
> +same way as the ioctl(SIOCSHWTSTAMP).  However, this has not been implemented
> +in all drivers.
>  
>  ::
>  
> @@ -578,9 +586,10 @@ not been implemented in all drivers.
>  --------------------------------------------------------
>  
>  A driver which supports hardware time stamping must support the
> -SIOCSHWTSTAMP ioctl and update the supplied struct hwtstamp_config with
> -the actual values as described in the section on SIOCSHWTSTAMP.  It
> -should also support SIOCGHWTSTAMP.
> +ndo_hwtstamp_set NDO or the legacy SIOCSHWTSTAMP ioctl and update the
> +supplied struct hwtstamp_config with the actual values as described in
> +the section on SIOCSHWTSTAMP. It should also support ndo_hwtstamp_get or
> +the legacy SIOCGHWTSTAMP.

Can we simply drop the mention of implementing the legacy implementation
on the kernel side? I guess not all existing drivers have converted yet...?

I have a similar thought about the other legacy PTP hooks.. it is good
to completely remove the legacy/deprecated implementations as it means
drivers can't be published which don't update to new APIs. That
ultimately just wastes reviewer/maintainer time to point out that it
must be updated to new APIs.

Obviously this will require some effort to make sure all existing
drivers get refactored.

