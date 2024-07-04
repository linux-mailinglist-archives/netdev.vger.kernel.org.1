Return-Path: <netdev+bounces-109178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627C19273D2
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 12:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A79228A4B4
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F801A38FE;
	Thu,  4 Jul 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVlcmp7r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C3A41;
	Thu,  4 Jul 2024 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088276; cv=fail; b=u8y6ZBLWwHYdOls/2iaE933vNn3KZEimMhASZtB9ldDQHd2nKk/cHrhXwtFaqz/HQl6THJDyOh8gQbxmVmMJ4GbfBl9HxqX1iBVpH/XsECeDyqXx8vN3oexmnZ/ZxTTpdxqqCH5stW0hIr31Bro9rvP7KBlMoTmGtkuJ+wL3fR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088276; c=relaxed/simple;
	bh=MK5YQFb2NwTrdkzveMYsev9ecET/UQufg98+PN4R/aw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e8UGcsSgUZtHUyFJcBkiIEBCRGpdjGHvDx15mZLAs6Zg3eh5SkQ3qadjfKtaS33EDRguaumzulb76DodWya1atJ/gFjlJRv+GuSusJOrnpyvGLvihQDk/tu07P6Ch3y6hsNGho3r5yQfK3p9kfAI41uvxpGF/IQAQ5qO5oeS1Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVlcmp7r; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720088274; x=1751624274;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MK5YQFb2NwTrdkzveMYsev9ecET/UQufg98+PN4R/aw=;
  b=kVlcmp7rhkmsw7NRHQf+y9qpzs7kyKYrP2IqRSupPCJl44C1HX3tn4lO
   ssIcsQq9L0JLVujeCQxrHjsEtqemUPa/ATLEroMsURgPj7NChfUpoanIw
   xhulfIGM+CxbvlDm2NxCqs3kuw4MrV71B48HionPEyl0yn3Ros/TbHzxu
   9rRjlvAXJQ5ncx97uAcPEQPHKx9qJQh/aeN2Uo3Z9jPOuWMwhBOhaLkie
   gSJoPbItc3ApUwIUl+Yke5aPSHisgvQiFQ3z2fYj4IwNaVFU6dBMbQeqL
   ToLXuOMVt3Z0kvaBEWRYctIc+CbaI3LmFNLQWQGzfaKUklou2KVPvJ+OY
   Q==;
X-CSE-ConnectionGUID: 8+BoIsS4T1WSeXDNr+DFLw==
X-CSE-MsgGUID: fbXHIGDDQqW/waG4grQ4wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17179773"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17179773"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 03:17:53 -0700
X-CSE-ConnectionGUID: IZCFMxufSKCXh+pMAfCWOA==
X-CSE-MsgGUID: o1lRLlELRXmg/mc2iMJy1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="47209727"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 03:17:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 03:17:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 03:17:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 03:17:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyGu3osDKmlIJ+c7OBgI8y8+3acXjUq7QjowFBAu0jAzsIFi/JM3Tai7k8IlMdtUZw2m7ssE57tJnlIxUvlbNi6wkL/tqjoKsumbYec99CaGU/SKujpPvU7SCQWO4dxwS9Ms8WCMntFmNJlUngU9lAogSyeJqO+AAn/fwLYKJxAF2JjbE6/EPwjSPfHozgnbay9gM0XCrTohfb3/9ofdSwfBHx+xZ/QUoP33qU/6g0t8PU+gUfjfiRKuKqecsmOJohWZSfWK/2lQi9eivBayzKZ71NLfXdpLUdZ2LkcuArJigUJz78G5hmjrxQuHSZHYd+sABtoFmEMI326BsO9lhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyGBy5FDaw2Te9ki3PSYEnGVSb+mrclE9BMHTzSflos=;
 b=gvI9vhxTjYlrzN1NBzb8CrsdO7jaUxnGluwaWhTIolgPui3ZM7sYeAxCVRZhY0F54b3aPUcnl81dKDFy+zNPdyFJSXLcTH7q27G2m6PryYk87hBRkkRusCe1Dp2mPj3ejbIu2RouZV8b1e1E3ttrmYHjpxo9SNzZ+8c8IhGlZQSpOif+MK/8SXAm/vhluKufEd1QzJniQ3pTj6it6S1WiDW9vL1IhU+mtedTdUgJuItYd4p7t2UIjAMLvF3cjjRdzPA9uvdBTwI+Y5S2lJJSkT7v9Y0o3DpERfFSy+WrkbOd6imiBylErQLL+NGqNMtOu4X9DaQffHrcaTNaEAHj+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW4PR11MB6572.namprd11.prod.outlook.com (2603:10b6:303:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Thu, 4 Jul
 2024 10:17:48 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 10:17:48 +0000
Message-ID: <2230e0ee-2bf4-4d86-b81d-1615125d3084@intel.com>
Date: Thu, 4 Jul 2024 12:17:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ntp: fix size argument for kcalloc
To: Paolo Abeni <pabeni@redhat.com>
CC: <oss-drivers@corigine.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <louis.peens@corigine.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <yinjun.zhang@corigine.com>, <johannes.berg@intel.com>,
	<ryno.swart@corigine.com>, <ziyang.chen@corigine.com>, <linma@zju.edu.cn>,
	<niklas.soderlund@corigine.com>, Chen Ni <nichen@iscas.ac.cn>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>
References: <20240703025625.1695052-1-nichen@iscas.ac.cn>
 <5cafbf6e-37ad-4792-963e-568bcc20640d@intel.com>
 <65153ac3f432295a89b42c8b9de83fcabdefe19c.camel@redhat.com>
 <b30c7c109f41651809d9899c30b15a46595f11ef.camel@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <b30c7c109f41651809d9899c30b15a46595f11ef.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0059.eurprd03.prod.outlook.com
 (2603:10a6:803:118::48) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW4PR11MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: b19424bc-37f7-4f0f-cb3e-08dc9c128dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azRvYU9pYTE5OFlzTXNXWk1RUXF6YVoxVEtWeEl6aktHNjlhWkN5NU9RMXVU?=
 =?utf-8?B?NVpva1hBWWlRVC9JdzJxakhVNWVOdktMbG0yVEp4a0l1WlhJa1d6TDVaamlu?=
 =?utf-8?B?T3I3ZFdDSlY5OGtoM1RXQjRhZmh1eXdrM1RldXNMK1kwUGpyR3JYWWMrUFIz?=
 =?utf-8?B?dlRiUVBBQ0ZQeEhwVzdRblZRb2tScTUvYU9wSjRrZ2FnemszOEpmVXZudUFQ?=
 =?utf-8?B?U0JiQjl5alBtU1BLS0VnZTZ1dFhTaEYxMEtwR1pZZmZ2ZnhYc3ZCc1NnTUpM?=
 =?utf-8?B?Zis5SStBbGVqNEJ2TnhtMENEN0YxTWw1UEhUcVJhN2pXZmhxSGwvUlZ4bi9s?=
 =?utf-8?B?d2x5aVMxMTA2aXZNK2RDelYvV2J6eHpBYkRvZjE2cFdMMmxaK2Z1SFlaU0w2?=
 =?utf-8?B?SEdDL0kvY0ExUlJYbGc0cUxHQ0RRdlFxV2QyWW9pZW5zRWlDYkxTc08wU2pS?=
 =?utf-8?B?MWNhV2IzdVBIT2RkdnpSSnMwZVA4azJueXd0RjdZS0x1dzBBYUdQNUoyd2xQ?=
 =?utf-8?B?UG9ndWR6ekFITkM5OHFuUEw0dGIxeDhhZmhMQjUrcy9pMGZ6aWFpelk5eE84?=
 =?utf-8?B?KzYvVkxtRWJTd1BNcDdGK2RZa05JeVRyUndBeTdwSS9wejR1Rnd3QnllMFhK?=
 =?utf-8?B?L0hRRTdVMlo1anFTYWdmQVliWGdVUEpGUVhnVHVIeXh3RTRuLzVwNW83Njc2?=
 =?utf-8?B?UXRFT3IzMDVqQUlndTd0TWp3ZlhETGxWcHZFOWYxWjV3MWU3ZWNSWEtMdy9v?=
 =?utf-8?B?YnBnRlZXWXVibytEcG95QzBtNWdxTUZSMFluSlo5SGltWFhtQk9WYmtwQUNy?=
 =?utf-8?B?ZE5ld004dkpIYkRyWWlWVlRCSmVtemgrdmR5UTk5VXowYXA5VlNQMXVvMUV6?=
 =?utf-8?B?MVl4VDIwamJ1MFRQeGkvcEh6U1ZNRUFQTlNWQzQ1dFRyNXlBd3NOZ2xSMzFO?=
 =?utf-8?B?RDFPMEp2UUR5aG9SWDlwdDFaNU1lejlBR1JZVEVZcE92cmgvVWxhbkk3QUFa?=
 =?utf-8?B?WktTbC8yNUFFUFEvbjFnZ3luYk1yYWpqVFkwSitNd1NHY0RyQmtkQ2NtbW9a?=
 =?utf-8?B?WW5nVmZ1UnFoNVVUU3hqR1pqL0tKNlJaTnNrNUU0eElwM244cEpONUZDOEp2?=
 =?utf-8?B?SGNFRG9QMXloTWVra2RPVGZYZzA5MTZhTzFGNHByL3dFZ0dqUG9vanFXMFBm?=
 =?utf-8?B?WFJSMU1KSWpmbHRVQU1pSDdZSGkrR1lkeHVQUWgrNmV5Zi8rRnVWTFcrcGNI?=
 =?utf-8?B?M2xmWWo2aUNNbGx1TFZ5STZnZk55czh0bitkS3M1c01pUEloZDQrRXlERVR5?=
 =?utf-8?B?dDRlQ0YrSzVMcWlNRy9RZjVoMUlqRnhrbzBmVHpySjFGd28yNjUyU2NGRThH?=
 =?utf-8?B?RmdFdXc0ZWx4RnQwaWpQanJETjNyKy9QL0xkK3M1TFZnZldQUGNvM2tTRVdY?=
 =?utf-8?B?TkxnbENJbDVVRjRoS3p4b3Q5SUVTeTNUTUpaVW5NakdQMHZWLzdNMFIrWlhK?=
 =?utf-8?B?b1FaNGhzU01DU29yUFp2RlNyR25xdCtWTUlZOTV3aGxOWE0xY2ViZTBHLzB4?=
 =?utf-8?B?YjFhMzRYTm4zeGRydm5Qd3Y0WmJMbkptKzA5WWdPcWdnVGw0NkY4V2QvNUEv?=
 =?utf-8?B?L2Z0MUp6NE9aWU8zMllPb1ZrQnFFN2gyclQxWktmMGJwTWNiVFhzNWpGeGtD?=
 =?utf-8?B?VWVJODVVTFFxSkJLdVFoWW5mRlhVVDBwZVNLTWZQTTQ0MHVVMHJ5TW9PZDRz?=
 =?utf-8?Q?49waGBFae9Eq9xTCqM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHJrU3VkMExMdUtvNldwbXJkdjRQZDVzY0ZpV2J0TmhBa2lLbVBkQUY3QVdV?=
 =?utf-8?B?amZUYmlmVENOSld1MG0zUWkzaDM1cE52T1Z6Q21ET1A4VDk2VExVYWFXSDZM?=
 =?utf-8?B?MjFsUS9GYWhjVXdFNWJLOXRVZ1gvdEUxL2k4dDJzbVB5RHZjOU1nazYyMFRq?=
 =?utf-8?B?ajZEZHJSY3kzSGlIcHAwL08yZ3dUYXZXb1M4UVh1aWFJY1l0SnFReHNTckRW?=
 =?utf-8?B?YnNaTHBpbkF2M3NCOHFmWkUzUHZSMm5idlRiU3JNOGFqRnlpeXZndWZtNFJv?=
 =?utf-8?B?Nk9ucFYwSDl6eERqZURqMktGbnNtcjUrMnI1TkJqVURtQzJLSmMyQXovK1ZZ?=
 =?utf-8?B?UlRXKzdvdGhjbU1vN0Z1cWJkcHVCYzNHdDZiczgxcEV3TVkvSmNkT0Q0a0NK?=
 =?utf-8?B?cUFDWkRQTFIxdnEwQk9rNEJETjByekZBNXVpakNodmFQRkFRZzl0STk0R2Nw?=
 =?utf-8?B?djFHMWtBbGcwVkhRMng3bElvUlQ2Mk9tMVQrOEZkcE0vMzhpejJwN2R6bGQz?=
 =?utf-8?B?b3p5M3hDOEtISlJ2bUpmZmt1VkdRczNSY0tFZk9sZitudlVIUzBrVHBWNzJH?=
 =?utf-8?B?dmtyKzlNaXUrTW9WZDN4cTVoL0R2bXI0VnhVVFhJbXFkMkRVK2RnQmwrd1k5?=
 =?utf-8?B?ZjM1RWlvUE9EVHJEMXhhZzVKNzRFeUhVTmZUcGJOTlJzdmZIR2N1L1VkOVdT?=
 =?utf-8?B?Qm5nSFVpTVpCams0eWx4R1FHUCtlcm9IT0dMNmRYdC9Dem9KamV4Qi9UYjRx?=
 =?utf-8?B?NG5yQ0dUU2U1SWd6UllaTHBaejI2R0x1RkJLalNodVU0cXVWZ2RHZWFlVEZO?=
 =?utf-8?B?NllNaURYM1J1bEQwYmNjMHkwVkk4T0t6aWtwOVlNbytxclh4Q1BnYk5SZ09j?=
 =?utf-8?B?M1NPRkZ0QWhQQlFQazNoYlJUY2NISG5zbGpnbFU5T2EybUF3d0YzZE5hNGsz?=
 =?utf-8?B?cURyaHh3TVY5U1IzK3RzRDdHVGZPd1BabytnUE9tcVpYeU1MR3VES2x4V0kz?=
 =?utf-8?B?U2RRdkM0bytWRVdGWkJGanZoTkZNWUtzZFdmVlQxak1GbG5PenUwRTg1Q2tM?=
 =?utf-8?B?QXZLcWJxbzBTbjFlUmZEQnVHR1JSNmhLK2lFNjk0dDBPbnNneFZFKzFSVmRt?=
 =?utf-8?B?cXhKNVZVZThyRnFwdXB6SlBlVml6R3Z5RU82N2luM0lGUG5vYmgzMmdDNlRX?=
 =?utf-8?B?WkdTNDJVdktMWGxNd1ZiSTI0cENkdEZWTXE1cWZaNEpaaS9uTHRjbTNVNWND?=
 =?utf-8?B?Z1VmcytrQkxsc2FLVEJoZjIxVkVDMmdwNXRMTEJvc291N1hZemhnbXhqTldo?=
 =?utf-8?B?Qkdib0U3RW1McExQUU9aMGYzNFNsOE5XWEFTSkFXKzhiZmRSR3cvaDU0N2k1?=
 =?utf-8?B?WnRjRzVXNzcxTmZlUW9zNDBqanE0YjFCcHRXRGNMbHhPMDRFUkNCSmNoSDRJ?=
 =?utf-8?B?NVRmbjFDYk5JeFdZdzRabGo5QkFDb1NYRUFWa21pbi9TZElBSTRqZlZEMDNW?=
 =?utf-8?B?S3A4NFRUOE1vQWdvZ1Fzd2ZPVm40eHgwVVlmam9KUGdTL3k4bzR0S3hkZUc1?=
 =?utf-8?B?eWU5a3QwbmdFc0NNdnVranNFY0pydkZNQmxKZmxPMXUwaHpqNWxuYk11ZUhT?=
 =?utf-8?B?ci9zblNLQUR2YkkreXFRRTcxNS84bGxTWTJ1K05vWllQNUxnK0ttbCtMUXhN?=
 =?utf-8?B?Q3F0YUV4MTVBR0lqOHk1K01xUVJnYkF4OWpuRTdNbFNuU1hwcEZsQmZwM2dk?=
 =?utf-8?B?MnZSOWhYME05ZEpvZTZ6dUg0UVlCVHhXWGR4d3ZFNGFqWUs5RStHUSs5ZjN4?=
 =?utf-8?B?UDhNMWE1bFdkNzhUV000bTFSVXFLMklyZFMzTWNKZGhYcmc3L1Y3TEYrMTNE?=
 =?utf-8?B?Qjd3WFZNWU15SFBvWEp0cVlLVm9CbXI2Z2kzSG5QMmZEblkxc3d4S1FubHFy?=
 =?utf-8?B?L3lzK2ZSSlNCdk91NHAzcXJ2Qmp2M0VuOWhoMFJTd2FXczFMZlRtUjczTFAr?=
 =?utf-8?B?RU1sZU1vOVpjTXRuVXhicW4vaE16dy9kc2tHcTgrcnduaERMSEVzUVo5RDVl?=
 =?utf-8?B?Ny9RSWwvN1MyeUNFeGxpbVJ2V3JyMktuT3VpQ1Mrb3pnNXVrdnd4a3JualNV?=
 =?utf-8?B?RWtiR2EzSENmbXExaTZwbFA5MWc3SWpLLy9sUCtObnIzZC8yTVhnVytQaXls?=
 =?utf-8?Q?axEGYbcLJOPZ5TNHNjqghxE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b19424bc-37f7-4f0f-cb3e-08dc9c128dca
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 10:17:48.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sudO6SsYz3ZedZY4c2YFKq7pZJbcpgMlLRnyBiNAuXV3ha9PNiy+76+KuN6p+mj2hOHymn6+9tvMZee45kGGtLlh/uZ8lxpvpC1d1bcURcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6572
X-OriginatorOrg: intel.com

On 7/4/24 11:41, Paolo Abeni wrote:
> On Thu, 2024-07-04 at 11:36 +0200, Paolo Abeni wrote:
>> On Wed, 2024-07-03 at 11:16 +0200, Przemek Kitszel wrote:
>>> On 7/3/24 04:56, Chen Ni wrote:
>>>> The size argument to kcalloc should be the size of desired structure,
>>>
>>> xsk_pools is a double pointer, so not "desired structure" but rather you
>>> should talk about an element size.
>>>
>>>> not the pointer to it.
>>>>
>>>> Fixes: 6402528b7a0b ("nfp: xsk: add AF_XDP zero-copy Rx and Tx support")
>>>
>>> even if the the behavior is not changed, the fix should be targeted to
>>> net tree
>>
>> This patch is IMHO more a cleanup than a real fix. As such it's more
>> suited for net-next. For the same reason I think it should not go to
>> stable, so I'm dropping the fixes tag, too.

I'm fine with targeting it at any of the trees.

But I still believe it is a fix, even if a trivial one, and even if code
"works" - it's a "wrong" code.

Here I received similar feedback in a similar case:
https://www.mail-archive.com/intel-wired-lan@osuosl.org/msg03252.html
and I changed my mind then.

> 
> Thinking again about it, this patch has a few things to be cleaned-up.
> 
> @Chen Ni, please submit a new revision, adjusting the subj and commit
> message as per Przemek and Simon feedback and dropping the fixes tag,
> still targeting net-next.
> 
> You can retain the already collected tags.
> 
> Thanks,
> 
> Paolo
> 


