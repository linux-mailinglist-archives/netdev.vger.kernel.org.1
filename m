Return-Path: <netdev+bounces-71851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B791285557D
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC0A280C23
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D9813F01D;
	Wed, 14 Feb 2024 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGa7L32I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212B313EFE3
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948239; cv=fail; b=huKYsJIDrve0U5pp/lLIgJ0lXprfiYM3ruUUItMWZKziKajmPaybf5i6hQ12aKTllhwmOQwwxJ+wo008RjVzArV6yMZMsrk1e57GPRlmjGUvCqg0zJkNgJOQd9gK7sZumPm6q9nxSlY5zDeb1ZZ+7WqnmaX196o9wic6b/YS1AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948239; c=relaxed/simple;
	bh=ZXCwoYL3tdA/qghWkThZinSeT5wunNZfLNFuGjsNaJg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NjUW84QQENO1AHNlrq9a/x46xhtUByYfG1KwL9lByeO44nkriOj0VVlPgrsFMMPXO6Ho+6v/fxMOZxcIjVHqf13Ao2Odh5K8z0P8OxptvySzl+ZKkseo9CYUBJawk6BBKteOlw+iQJwjRntrijUCFLrsEfkXiBTTJ+RyWuj37Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGa7L32I; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707948238; x=1739484238;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZXCwoYL3tdA/qghWkThZinSeT5wunNZfLNFuGjsNaJg=;
  b=NGa7L32I5JX+XrKZ9n5Ep3dNLC5cc9x6t7NiZJxWU+fO9S8mRPJ5xQJ5
   EqowgFm8GWXtHWlj27Z44+uQ/IIsGY877toVIYHWOmX8Av2HV5AIYNev0
   7K+IjGrh3/6cmkf8pjCsU1x/2bBFO0E+cnstZV+8OJlqmZc1LDlqx3KOW
   vqr540+XFjTKB4+qjYJMWwYB876glnz7sFz4LVV8wamvIJ/ffUPi2sZI8
   RwfJcK0JqF4ycpnUKICXlyGSlrXGS8oJWaCOPxVJP3becN5uDIKIRDKpD
   QhnevURUQTJzCO9njacl8JGut0fJQXC2IJMeia46XvAiLriL8Gg9TE/jN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="24489141"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="24489141"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 14:03:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="26498316"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 14:03:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:03:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 14:03:56 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 14:03:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=degLE40f0pzJveGcZluWcejR7DQOl98BoPykwfysVWJalFg42Ml9SjsH86iOmnSiBLcPp7iwx6uxzgf6TQlkDSjbU01X7Xz2Mo+YFoUc+14L8cv3l5SA/HGDvu645cqhCSSznOYeupg8g3No6syQratYRMkxCeSWgZrth9bnxj3C0Vt0bULgaHJ7JjLQY97g6Ez5BuvauggdKXp1HbHaHVY4TEm876Mip3JtDrXKixZfAQe8ojXs//jLe23eiznOpu+km3So4dJ8ljs9z0uC2dQR3+88hvRN/wAWDKguZ9MpgaA1JP5HED2p3FMM2c+15Mnc9IWSPwHUHsTcxxyUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+e+RDqN4wivEmYDiGV4G7uXqOxpj0WRC63rszG1TWn4=;
 b=Om1p5WsBanTdBnRMZrrvfzVbVV+MqHDX0edFQGiszfJL3nBc2n/gmN+fEIOsKXuMg1nro1pE0Vm3Qkv7FD6gcjwUCOfgmCAY8qaOFDmMr2PFiYc5PtqY3cONb93rfge3OUPm3bMy7tg6dJ8g0iRs6PLIbt/zejJx9D5VEEU0plHiCaU+tyf+gRh0VIMDsOsnrjesLkEcs4AE4AuqUStYhAspSfaEZqF9Ud6noYW1L7EPWKLdkDmLz+XTH36YQSotD/tZCK+FPGgfsMz9i3uxMIH6Yyd9KwNfXa3A1+yPchAyYLNmpe+/mJpYoLZlSjLztsswH7dxO/6K2Ve3YNHOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB8572.namprd11.prod.outlook.com (2603:10b6:510:30a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Wed, 14 Feb
 2024 22:03:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 22:03:54 +0000
Message-ID: <52beb4e6-3736-4022-8c98-7d26a756b62d@intel.com>
Date: Wed, 14 Feb 2024 14:03:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 5/9] ionic: Add XDP packet headroom
Content-Language: en-US
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>
References: <20240214175909.68802-1-shannon.nelson@amd.com>
 <20240214175909.68802-6-shannon.nelson@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240214175909.68802-6-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:907:1::40) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: c4275201-8966-4f20-7249-08dc2da8d58f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5MAmR4DBV8/+9+mjuMxF5FDwEl9hXf3tcc9khLZTxM+eIS9I1b0sEFBVOhElC2STgHxSYKQT4qZM5jJ5jGMFeyQkJhV6Ewoeb9iIpVvGgIMRpZPJOXjzW1OZKI7RTnsdgj6pJ9WMNYREmnTVdrQwYH3UJ5Ts2oGJ8QSL3uio49EnLj4ONGnZNTjjoerztPWDxcwXXOhhVXPyoEIeH3jcrkgAFi133VRNx9/djtu4QbjQy1jzlp8IxOieTIczkTFNlgRVubVHUKR++uI/5aV4VQWBM1Ni/Lzu3pwPkEDloSOB7MYzWAuAsZ8DXj8CROj06uv0aBDgUoA3k5R650Rn3k67budSjJvJRzQhaXGtBgT03YbZcP/ojVOjSNf/I3XX3j+ZNzThhWhwlQWQIAbA5n7NbuBls3boaHVqCXVx8nPUaCDPUXLcYhwPAtOQx2oxw1bjlRfmVsd4FojbGWk0bQZ6ZE6fj9zh/mzzxQ+OLv6iG9NkFH7l/KtocpQu8MJY1c5PEGs8I7/NiqqQx+mvk4QobRdSX9vKcSGIOE05dmMGUro4jJJfcf1mLNPAZY6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(36756003)(31686004)(41300700001)(2906002)(478600001)(31696002)(4744005)(66556008)(4326008)(66476007)(66946007)(6486002)(8936002)(8676002)(38100700002)(82960400001)(86362001)(316002)(2616005)(26005)(5660300002)(53546011)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEhRRUpBTzJWLzgwbnVxVTg2cVlzYkZ6Smg1SEhvbmlDYXZ0eXRmNEpZRE9S?=
 =?utf-8?B?MldZRFdpMWNaSUtjQjlnbHlkaXA3eFEzUFY3MzdVcUlEOVljaC9KWlNEQml6?=
 =?utf-8?B?Sjh6RDF3UC80alFyaU1ZRHU3Z29zNFAwNjlsQTkrWlI3bElDRmJybGhOR3lK?=
 =?utf-8?B?bm9sQ2drYkU1ZzVuZXptZFp1Nmx4RWgraXZhVXltUXVMM0ZVWStOeXBCRHpD?=
 =?utf-8?B?KzVsZkdZSUhtYzBISjM4RUhhNDhiWXJaNFJ0ZzBESWkwUDk4VDRCMUFza0Iw?=
 =?utf-8?B?STZHclZsb2FJM0I5UlBDaklUQk93Zlh0NmtYdGE2aUdsdHVZcWxWUnFvRzY2?=
 =?utf-8?B?VVN4amdmRTgrcTJVU0FJdzFESk5DenVjcHpuUUdmcHJSeXlxUmlJZ3IwUit1?=
 =?utf-8?B?R0RpV3JBUHZ0dUlkMXhKSU5MMC9XcVFtd0JQWnEwLzhRWmV0ZmtaeE5mZGZk?=
 =?utf-8?B?dGV3b1dacFJBRUxhS2hWa1VMa2pZcUVxRWNnUmdqY3NNMmpibERxZHpRZlVV?=
 =?utf-8?B?N2xYZkpqNmxwV2pHb2JrTDdNZGpZejJ4aVRWZy9JcU9xU0dtOGE0SWJsc05O?=
 =?utf-8?B?SDJmMXlDZTFyZCtzZnhRVnd6R2cxWXZwdStSL0dGUG9NRUpyOTlxS1Bxc2Nq?=
 =?utf-8?B?dExPYTRGZ1M2YXpJaCtrU2c5cGU3aGxCWTlDRGFNNEZxSmhBbzRURXFFWDlr?=
 =?utf-8?B?VFlPY2hGU1RWeWIwTTU1clF4THdJQytUYW5UQXNES2NuM2dSVlAza3pNc2p0?=
 =?utf-8?B?STAvMC9BREdtS3B5MWpUb01raTVXR0ZjRmRYTFR0NzdTQW00TFFOZGl1N2N5?=
 =?utf-8?B?R1NTc0tRK0x4WUY0T1JpaWFQNkpoYUV6TnFFcVU2bWdGc3l1WXlBd2xxeFU1?=
 =?utf-8?B?VXQ3eGw2WmhJTkRaeHhJMjVaV2Q4K3pldUlrUmxGMGtVZVdUMHovSXB6dGl6?=
 =?utf-8?B?M2xPSHRTR1pNT0hvS2xoUjY3RUJxT0RYdjN5UEd4Tjc5SHhici9qVXhPeUla?=
 =?utf-8?B?dFNDVXVNTTVLVDIyUnVGWFEvQnY4NjUrTjhIbVdPNmJOSm93MzBJQStrek5K?=
 =?utf-8?B?RjRMVXFSS3lkeTBiRXdCOFY3S2VaWlNDZHZtSXRyYVhjdThic3BRUDdRR2xC?=
 =?utf-8?B?cTRrUGp1M0ZrRDdGb2lka0Y5WmxXOTBqd0I0bUxpK1oyOFB3MzRUUDNKYzlV?=
 =?utf-8?B?V09PaEMrcVVFKzR5M0ExRU9HbG9IWWhFY0RmU3NWeWpEMnB3TWtYU05xdjhL?=
 =?utf-8?B?OW14eVJvR3YwaDdHcWJvQkhKdkFqdC90b052b1pZaXVjWG85bUkyQ2l6K3p1?=
 =?utf-8?B?MG9LZ043YWN6YlZobHpTQjI5bjNqNTU4RUtJRHN1L2JZQTV1YTdTTHd6V3Nv?=
 =?utf-8?B?bXZJOXRFem41SHN5dm8wNEtxODZ6NnM5NXR1Zmkrc0ZPMHhKT09JUmJVdGpq?=
 =?utf-8?B?TE5POWpTendYV2FoVFhSenVQQmlTSDhhaTlaeXNGYlNUNFJkbHlLTHlZTjZI?=
 =?utf-8?B?bzV4aWlQMEdtOGRjY3pTMGoxZGV4dTVBaVlsS3NoLy9aU2VLUXozM1NtTGVu?=
 =?utf-8?B?c1pWd2pydG9GNERmUHd3Z01aY3FyMFQrSEZjMW92Z2dkcGdaRVVNcXdNNlMv?=
 =?utf-8?B?SFZQL2lYVHhic2o0VXdGM0ZTdzRmSTZoUGx2aWdncnVGUWN0cG5PTjFMYlJL?=
 =?utf-8?B?SFRtdjk1QUNNUEtrRTVTbkZiN2hSRWRRQzE0UXpqM1ZneXpiVlpPYkUwbFQ5?=
 =?utf-8?B?UlRoZHViM0dkUThwRDdVMVRaMGZJVjdvcStoWW5NNlFVZUJwRit1QUloM1BL?=
 =?utf-8?B?U2xXdHhJckJOY05pZElKTUkyZkdHcXFsV2toWGpWanQwOGhWNFgxTGFLZi8x?=
 =?utf-8?B?Ukg2YnpHZXBMMnhVU2plZjhsMTIzbUx6ZnEvdW5sOGQ5VEd4ZFh2QlJTbWFl?=
 =?utf-8?B?NEhRakhkWkVzaHFlWVVmQndBdHpMSkFMRXA5VGRWMDVkSGZHOGRFUVlaNURG?=
 =?utf-8?B?Njl1SWdkZFV4VUZtWGk2WWpSWmdQNGhBRjI1bmxkWlhsV3B5WC96RmZ0c3Yw?=
 =?utf-8?B?Q1Rlbzc0TUpLSUhEbjBQODZXWHFBRDd1eW5qTktPZkhpK1poQkpZeEdmZTYv?=
 =?utf-8?B?dnBQc0U5blJrMlZTd3ZoTFRVNE83Z1JDY2xQTDZOVGdZMmhReVQzVmpHWDhO?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4275201-8966-4f20-7249-08dc2da8d58f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 22:03:54.1333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50/MrPNp+aBUJypzcLeE03hErkwzp+E2gT/6dSh+OhyxzeM8eYMH595ZJd2QrbFA7jqPwDlVUoFGPAgRnxEn5OQS2gMPcxrr+4PtCU2lUiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8572
X-OriginatorOrg: intel.com



On 2/14/2024 9:59 AM, Shannon Nelson wrote:
> If an xdp program is loaded, add headroom at the beginning
> of the frame to allow for editing and insertions that an XDP
> program might need room for, and tailroom used later for XDP
> frame tracking.  These are only needed in the first Rx buffer
> in a packet, not for any trailing frags.
> 
> Co-developed-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

