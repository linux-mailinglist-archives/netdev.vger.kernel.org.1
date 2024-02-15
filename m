Return-Path: <netdev+bounces-72049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B37B8564A7
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A941C215D4
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2EF12FF8C;
	Thu, 15 Feb 2024 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9JH0PEt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8764812BE88
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004523; cv=fail; b=mX9gctu11MavxOJ9yjuG9GxkBn368HH8fVGZyC/VJbBxKjjrOvJWx7w1euzG2iNQ4/yuWPk1HosWuatm+1dO1IPClDknxS+3+uFiUjBVR7ICp193bWybH37Qo479AcR0Wi2zy1y6EMlL85koSivBvsIw2uM18aEn2ydCT9OhpIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004523; c=relaxed/simple;
	bh=z54Zn6TPaGdzbFXFsIAi0wWoBhDQ1VSYtFfLZEzWA0k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BI9e9veLwwCvwbKwVps5S5LzQYyASqTsxQ/Z2svDsIVVcHBwk61BuNGcM2qMaZNXGxIEl8FtSoyJDBhQ75mX0/2yTRvPqtRIrvdxwIBHtmKD2gOsEfov4OwqLP/Fjru8KuuzMpxLCPec6C06to/oiMbj5nIHYsSuhV9YEkepahU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9JH0PEt; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708004521; x=1739540521;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z54Zn6TPaGdzbFXFsIAi0wWoBhDQ1VSYtFfLZEzWA0k=;
  b=n9JH0PEtDyE3N2BTgb9keUffZLiCr/GXxR5uRRbWajqVkrwpJOngKWTr
   dVhqHd1B2hTsXFgDFNh20m9/R/HgEssN+uheqqAbydTPGsdqoCIZ1Xvyx
   Sn0U3ZgK+sPtXBOHnl7MWrtgBlXTUj+7+df13WjilL0Yd3K3uEX7vi4SY
   H/2DlGzYXoW15474d03f3heVBH+dnxmu9Cu9PSJsxwMcgbLSDk4+8JixH
   UjGIiY3m4NjFzwdsOtUOZjcNVE6mY1aJtbjQazv9rcP0qalqnv0BOjMc7
   8izpUWi0P4j09BjJTk1vFc4C2EBDWU6ea+27PvECmFfPGlY6jYZswMLoM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2216037"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="2216037"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:42:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3605805"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 05:42:00 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 05:41:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 05:41:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 05:41:59 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 05:41:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHXXHd4sm7p/sJuXhfzaHI98t1LZKxXF8jcKOkYEu4tZqLfoND4ekYW3BYc2ZbMh28NyhLWDeMrNd2YD8q7/llf0L/eYTJv+0aehStQK79FF+FiGQ4lyjZErrEtBUGJQGfwDnP0xZLI7GwbwBMWIaVs0o4cxGP+dSuvx5/tIHGp+I6taklNuslNismFeVK7YZYeH0xaPc5zexDkgxdllA82i91KVZq0dqZUqYzNn2pLpwL1wvcI7Nf/vODOmHSPmp9qmN1ycnNxECSNINWEcdfqYoBzEcPKMDcR8TVfVdVJrSnYDNunMNB5Sk5Baz4hg/AzGsTP9anSPB5y/9f077w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wtum3Ahf5hH+J8gKHbasv2bwXQJVRmgGzLZ4PlaLob0=;
 b=CF+LTV4uwY8UXx85yH6kgc9SqeAYSNhrn7eixJaLN/bEbs4vM59wEVFFKO6Z91fr8CzOpVuvFKMSazEVtWt7SVMq/I9tA090wqnkTI3WOad9CIvkMRd8HpT7qQKCi6w/RWqMjax8awiWzFTkTeJ6oWulwKbhH1ajh5sH8cMgPZ7xyUzVJgltpGlhSwtNuAw9L5a4HyFqeiTYJe+qlmUcvR7UNiD7MbEjNQVZhePeBRoMK3hK9/WvUC+imlL8S1y3JnT4+pxgWFMkiY/ApTTWzGI0UD1wOkYs5wzC7XDVASTavkqgiD53ApmTbGU4/dOfoSTDu1bESxNUzjKFo6eFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB6145.namprd11.prod.outlook.com (2603:10b6:208:3ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 13:41:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6%6]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 13:41:56 +0000
Message-ID: <bff45ab9-2818-4b37-837e-f18ffcab8f47@intel.com>
Date: Thu, 15 Feb 2024 14:41:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next] net: page_pool: fix recycle stats for percpu
 page_pool allocator
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: <netdev@vger.kernel.org>, <lorenzo.bianconi@redhat.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <hawk@kernel.org>, <ilias.apalodimas@linaro.org>,
	<linyunsheng@huawei.com>, <toke@redhat.com>
References: <e56d630a7a6e8f738989745a2fa081225735a93c.1707933960.git.lorenzo@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <e56d630a7a6e8f738989745a2fa081225735a93c.1707933960.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: c24f26b5-141f-4742-2fb1-08dc2e2be0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tz5hLrejQX4QftNR9LRz9bVgl0/Ee+YfNgParnHD6fEgib5jWjiGfdaJbjMHp2mJJRaFbM95eBbMGiKQu7fRJoHC5r8Dk5RWMxTTfeF7jl5g7NK5+vZQUyJ190kQaCyYIYBBhCzqGbTF0k/d8AkOINPcPM+AdL5M4eLGiOqSTDYGVHdaNo6k/cVYc60PHk5KGM4QOGhcHJW/RF2M3UPoo/+1caraAlmmdKyy/hT8BGLedlB5LtVjuuhfdUXJzudxqjeULLyj9ujvhrH1B90dc+k6aRKw5z7zLF84Zu933eBnUlUX8D1W5MUrNUaS1I4+pcW+Xo1AR9XldwEfMzAOtDID34yGgq6jrTpGbNQ5kYLys+t8cWBQ4sAuwMmNvdbKsZSCoc8fUz2SgV7U5kbl0xgKnvDmvk8tTb72c0V0g0JyrAtVVMGj1EjIiC9/je8X1afJ7AIQhB3bquR2SMaYSjcfVaaZ2wYSuPEspEaj9nMKM6OSeAjc0sucqT5yuWdgb6KnZFWl8BAgm7rDyBshtedrM2KO84zdv2wNjtMSgaE2HwBEdf6HPx6n2xXYwAqc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(6486002)(6512007)(478600001)(41300700001)(4326008)(8676002)(8936002)(2906002)(5660300002)(7416002)(6506007)(66556008)(6666004)(66946007)(66476007)(6916009)(316002)(83380400001)(2616005)(31696002)(86362001)(82960400001)(26005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dThMS3VzejNZb3FmMnhSYlZyYThLczRmdDlNTk16VzFwbkhBUG9RWUhBUzB6?=
 =?utf-8?B?LzE1OGNFZnNicWJvckRGN3h5YjhwZ202ZVNsNVdJUXFqMGdQUmJSQXBuUGhE?=
 =?utf-8?B?N0RiWWRmRFR4N1hCV0lHUThiajBKVElrczNhQlVSdFZ6Wk1QRDBib2g5WTlU?=
 =?utf-8?B?Q0RKYTBnUkZ0cmlJR0FmakxjYko4WmJ6NWg0NXRmSmh3c3ZhZER3ZUUyK1pt?=
 =?utf-8?B?WCtLSDd0QkpURTdISGhKV3FudW5DMUhrZEJuV1JkaWltS29DUHhQT2dXaThN?=
 =?utf-8?B?KzdaWU9BZmcyRUFteU9VL3dIVXVETlEyK2RxYVA2enIwZzJLV0ZScFpnNUIy?=
 =?utf-8?B?VVFuN1drdkl3RTNscC82L3IrdGFwVUs2dStlaC9sYXRnenNtTVlmUTc3NE8w?=
 =?utf-8?B?VVZ0UTlZT2JoNXpFUXJxSkphSDZoeTQ3YXBXV3VTWmx0MXdkdmZ4UlB4Q3hL?=
 =?utf-8?B?Rlh4cDh6ZHhuaFIySzBDOU1KRURUMVpBN1RsR2g2NTBtakhRNVNod3JpVi9V?=
 =?utf-8?B?UytHQStQcFBobEZBU2o3WTE4Y0xFVngrc1BZRUhyU3liYmhoVGhsa1JvcTN4?=
 =?utf-8?B?ZmIvVE5IRDVpdUFFa2RRalB6dEN2eVIwVkRyN0Z1NkxRSnpTa2J1cWoxTjFj?=
 =?utf-8?B?ZWNWYUJvR05BSFpyRGoxTVNaSHFnblBuTDN0UzBSbWhyRGlUTUh1eENNUzZ0?=
 =?utf-8?B?aVBXMjdiNzBIeDFLc3BNN2oxMmYvTVRIYTNPalVtbW4rZ0FqakQ1bVhFWC9k?=
 =?utf-8?B?REFkV1k2Wlo4aWpRallVeGIyTzI4bW9pM0hJU3E2MG9ISlYxM2FiTlczbFNi?=
 =?utf-8?B?OXlOdkhsaTJaVGw5N3pJWEtjOTlRNjdmdC82ZFVYdjR6TS9FbnRQZ0pvMUlL?=
 =?utf-8?B?dU9zK20za21aNU84blRnRUxCZmRYYUpnR21NYzd6OWZiWk14OUY0VHRETjBJ?=
 =?utf-8?B?MWZmYk9DblpWK1Y3TTc5YTdzODU3MUM1WmxjT09DVExudFRPR002QjdzclB2?=
 =?utf-8?B?Y0Z4R2ZRWGo3aVN1VEd6Y0tJTWZwTU1NZjQ0TzBybk5PcDdHejNjQkZzM1FT?=
 =?utf-8?B?eTc0MVptWXpVTHlGOEtFTWl0MFgyNXFkUy9JV2JzaldyYjVTckw5NWhoa3lK?=
 =?utf-8?B?TDRPZG9KMWVGWHMzYkZFL29CN1JZNFVOeUpVazRTY2tITUo4YldPRDU3cldO?=
 =?utf-8?B?Qy9oa2QwU2IzVnVEVTJIQUZHYXpDTXhRaVcxM05tcWhEem5jL2FrRURxU1NZ?=
 =?utf-8?B?MXNvMGJTQlRCTUFKMUd5THNRbWxQUEo1N3pzamlsOXpTUG4rRjkwY1NGcjVk?=
 =?utf-8?B?Mi9pWDcrOGVoMjVZYnNSV2N1RkFhd044Q2RoUnJzVjZEcW9FRW5NZCtxUFlx?=
 =?utf-8?B?dmlVUFJSUlJDcDhIeFpHdUpSSGRQcktSc3R2L1pDTjVTMkZDRnlLMTB0MHNO?=
 =?utf-8?B?TnIrT3BXTFdHOEVtQzc5VmcwdjJxVXFYWDJxUVQ0ZDQwcGhVcjllSm9leUxu?=
 =?utf-8?B?ZEx0WnFMa2VQbmp3aHN4N3VwUmZtSDN4TWpHQmllZEp5a21IOFZ1T0VLZ3Z1?=
 =?utf-8?B?YkZ1SlFhQkdjZ29jTFpmMUloVWVPYlMrS1A4WUJuZFJ4NER2S1FBa2RxRy9K?=
 =?utf-8?B?cXlJSFNxd3pQWWpaRG0vTjl6bHlUTFBpVStJZkt0NU52Q3EwOVdGbzBLRU9p?=
 =?utf-8?B?UFF5RXM5UVRIVkVtaWJ3ZGg1c3h0Z0txN1hDQW83NjM0SVdReFQybnc3UFJF?=
 =?utf-8?B?RXd4S1lnNHZzSWhpc2tJYjNtRkJlMVNodU1ZbXMyNEN6U1dHMjRZek9VWmRS?=
 =?utf-8?B?SnZuNFJpRXpFc0UrWUpqK0NKZnRaUFMraW9KYnFSTm5IUEprODNnSGJQdkxY?=
 =?utf-8?B?bGo1TXZLZ2hyeFBRNVpvMG5uVFZINnU0VHBVTHNDUFFOemFGL1ltUjRYMVBF?=
 =?utf-8?B?czI4UmNlaTRYS3FsclVCS3UyZmVZN0dBSjFSNzdiaVNzbGM5bzVKZnowNzV2?=
 =?utf-8?B?bXRWL2FIUlI1c0Rjb2hZM3dGRFlJeXY3SDNWWkthbWtxUG8xQWVRY1RDVTBE?=
 =?utf-8?B?T0NQME95c1MrTmhTcFN1VEhPTzAxdkRTblpFTHM3VVQzaDJIRnZVeWtKSlo0?=
 =?utf-8?B?QUpjTm91Qml5NlMyWk5UNFR0ZUhyTE5iVlJ1VWZlYUt1cUNEYnBoQXhaQWg2?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c24f26b5-141f-4742-2fb1-08dc2e2be0a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 13:41:56.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3KwrtGfWXASZQSONVIdL2GsgaGxYRo7r12W47r5F9BNV9TmpxYl58Z+8EOo+REwDGqXOkXPfm1oae+qUNbebmlDBQxzjnrgCnUjC7uKdiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6145
X-OriginatorOrg: intel.com

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 14 Feb 2024 19:08:40 +0100

> Use global page_pool_recycle_stats percpu counter for percpu page_pool
> allocator.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  net/core/page_pool.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 6e0753e6a95b..1bb83b6e7a61 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -31,6 +31,8 @@
>  #define BIAS_MAX	(LONG_MAX >> 1)
>  
>  #ifdef CONFIG_PAGE_POOL_STATS
> +static DEFINE_PER_CPU(struct page_pool_recycle_stats, pp_recycle_stats);
> +
>  /* alloc_stat_inc is intended to be used in softirq context */
>  #define alloc_stat_inc(pool, __stat)	(pool->alloc_stats.__stat++)
>  /* recycle_stat_inc is safe to use when preemption is possible. */
> @@ -220,14 +222,19 @@ static int page_pool_init(struct page_pool *pool,
>  	pool->has_init_callback = !!pool->slow.init_callback;
>  
>  #ifdef CONFIG_PAGE_POOL_STATS
> -	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
> -	if (!pool->recycle_stats)
> -		return -ENOMEM;
> +	if (cpuid < 0) {

TBH I don't like the idea of assuming that only system page_pools might
be created with cpuid >= 0.
For example, if I have an Rx queue always pinned to one CPU, I might
want to create a PP for this queue with the cpuid set already to save
some cycles when recycling. We might also reuse cpuid later for some
more optimizations or features.

Maybe add a new PP_FLAG indicating that system percpu PP stats should be
used?

> +		pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
> +		if (!pool->recycle_stats)
> +			return -ENOMEM;
> +	} else {
> +		pool->recycle_stats = &pp_recycle_stats;
> +	}
>  #endif
>  
>  	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
>  #ifdef CONFIG_PAGE_POOL_STATS
> -		free_percpu(pool->recycle_stats);
> +		if (cpuid < 0)
> +			free_percpu(pool->recycle_stats);
>  #endif
>  		return -ENOMEM;
>  	}
> @@ -251,7 +258,8 @@ static void page_pool_uninit(struct page_pool *pool)
>  		put_device(pool->p.dev);
>  
>  #ifdef CONFIG_PAGE_POOL_STATS
> -	free_percpu(pool->recycle_stats);
> +	if (pool->cpuid < 0)
> +		free_percpu(pool->recycle_stats);
>  #endif
>  }
>  

Thanks,
Olek

