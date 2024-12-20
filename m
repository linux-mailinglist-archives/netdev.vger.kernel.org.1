Return-Path: <netdev+bounces-153720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3137E9F95E3
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 16:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CC91898A91
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1241219A9A;
	Fri, 20 Dec 2024 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fb8Xsy3r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901A219A9E;
	Fri, 20 Dec 2024 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709856; cv=fail; b=juV/C3wNfZf82m4l0fHmhbU9Y07NEN4Vqn7zRijA9fhcNQ/xLQ0TpRZme5zd4UyUCIJPfP5FAsY7vsTo7QauujF7AVZ/Nd2WSsGzSgM0r9sskKtO/eHLSEvvQ3UM8Y7YeGO1GkGF3No2W5i0J39RHy1z3RLaL29gx2FXI2TNcFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709856; c=relaxed/simple;
	bh=9cc1zD4WJQ5M9HQ1pXNUD7MyyvS9QZBDyuifrI1Ky38=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B/vmxuWjnhjrqeMt4o7Z7ijcMk44CBCwYvOhZQ6SLyYrJEVp4b2TYtXyne5mroliv8HS+5N1FVTIImWmdlLWs7ZBbWOK7mroh1yLBCDpLe5IxKGBFKbTdUj1q8xbRwe7nTc0erzmeWp8JFQI9VrnEHItEIlh1vU+phkuAxqZyts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fb8Xsy3r; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734709854; x=1766245854;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9cc1zD4WJQ5M9HQ1pXNUD7MyyvS9QZBDyuifrI1Ky38=;
  b=fb8Xsy3rB1NsIKR5m3Ah1/Ky/+jHCNpUKp9rekOAvRu0qD7WFYHQpws1
   JXxkeI+Uv54zEtFBrrSOTpk5HdlmS87OGASnJmyDUm47EmvHfa3l2eCuh
   1EZHsPc+vyjLplxj7F34lDOQSPUTZIkQ/JnCNysYocAk8T9VhUxGKBoUf
   bpvAtocGDbwFGaHX0LjTwX27es2Ncy0rf8F36agGg3J2dkBASNgrc+tWQ
   BUG2BoDL3sIzY8jXkaNmZwmL8b0BHkrglFn+a9Ci9nhYTEHxb5pkBBPI7
   Bl6hVqHh6B9zdOLJvKlTmxlwQfnTO4i3ijYEWc6OKOBWgeHoYQW3jAxH9
   g==;
X-CSE-ConnectionGUID: 9dbib30CS3WK2D/OGzuxoQ==
X-CSE-MsgGUID: psGRxGR3QD2MKu3+2XvoOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="34544891"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="34544891"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 07:50:50 -0800
X-CSE-ConnectionGUID: BnZQBvAuRqaMCMoUkOkK3A==
X-CSE-MsgGUID: 0ah1jar5TziaHJIT7Uni0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="129504165"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 07:50:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 07:50:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 07:50:49 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 07:50:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQ/6MYW6acSCpBLyoH0U4osuokc3tjeCUqNy6XF1xsTILaDqdUjWR6Eaw3Zj7VNRjzIH4TGFXy6/cmjCt3ML0fIFZobf3Dp5cgHJ+hFRk1klrZj0ug4ej7pedAJUTBGH9yEZIlbigJMUH1HnC8NFPmndJnDWmYdA+p41u44VrAcr4o4Ac5L6q7j6Rx7ZM5YgK6X+qVLqxlCp3wARi0gwbmsL84ki5CTGXO1hStyrpgu+ZXDw1igExDfzy9/H0LAlDSqAco0GHN6ND29/MZbMuyJOKDdHAUythH1wAYgVRMUH+Vc7PuWUqno3IPxa7gc70c9w4Htezvnmy+mSZDYjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U8y3AZ3kvg8As7jbRXFksqjudA2z81vRKkBuc8ZMCY=;
 b=Z2qdiyiGxGsiyCLxAcmBQtA6XGiTwLQdOpDFHx9WQTsRoCPrvANGDlhkmIUeHV2QlQF6mEDb1Ley2FgUa0Q4hwohydY/JZX0GX/xiOvw8nvwRiVyIBmWCpQWrCSW7uaIdooTglEfNuy0kjeYF2vidNWwQ0iKSNl2WFtSPzYD+uln0UDLH2d2GNz49epUQ6R/r9k7Fx18nQULbEcd3IiupI2keOpVQDm+3vMbGcNTb8UKL3xWuGqOPhYTCt3gRTwzT4gjPKJn8GVql+tBRQRUdYG995R6SzAU94R0TnSwfNYXtW4zqCH7hG3rQPxYZq/dFXSQvp/htZC10bfqlg1rEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV3PR11MB8457.namprd11.prod.outlook.com (2603:10b6:408:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 15:50:46 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 15:50:46 +0000
Message-ID: <ad553453-eb3b-4c1e-9342-e1ae74e6ff81@intel.com>
Date: Fri, 20 Dec 2024 16:49:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: page_pool: add
 page_pool_put_page_nosync()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jakub Kicinski
	<kuba@kernel.org>
CC: Guowei Dang <guowei.dang@foxmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Yunsheng Lin
	<linyunsheng@huawei.com>, Furong Xu <0x1207@gmail.com>
References: <tencent_76E62F6A47A7C7E818FC7C74A6B02772F308@qq.com>
 <20241219062438.1c89b98b@kernel.org>
 <CAC_iWjLy4-cErYjCQ1W4h6fWVn17+A-uA5NiYy2-Wv5T=iQvxw@mail.gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAC_iWjLy4-cErYjCQ1W4h6fWVn17+A-uA5NiYy2-Wv5T=iQvxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::35) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV3PR11MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd96cc8-784f-4af4-dc58-08dd210e116d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlBDRXBFVXB4RXFsWUplMjl3QkNQczYybzh6a0MvT3R1RU9TYWZCVXpUUmNJ?=
 =?utf-8?B?N0FJTEw1TnRvbVBJd0VJSVJVTGN3RTZ5cmxDZXFURGxiR0NhaHVEZUp0WS9D?=
 =?utf-8?B?ZHFTeENXUGphNDBZcjVpWi9INHFpTnV2dGhobnp4cWxNeFFBcUVKTEIwSGxz?=
 =?utf-8?B?SXJGdm9Pays5ajcvZWZFOEZ0UmVPZVphWXdyNzk0b1hudnBKcm9JT2FQOTBK?=
 =?utf-8?B?RUVGYlhjUStnT3NXelNuSllSUEZTTmZXZm15M2dUZS9kbC9vTVk2UnJkM0I3?=
 =?utf-8?B?YS9Ka1VwemhUQXlqQjEzbERiRC9WOXZSekJJTGpweW0ydW9IL2xhVkdvbGVi?=
 =?utf-8?B?ZkR6aXN2VTgxU2hlRjYzY1hmT3psajNDWEFkT1p5ZmN4QllPc3FzblFnaUxs?=
 =?utf-8?B?dXdRL01hTjQ2bGN5TE04WE9xdGpuaWZGRW4ycHJLSUVpSC9HYkpDcHZxc0ZQ?=
 =?utf-8?B?WkRLM08zM2JIQUZQTmxHcFhEY2xWTHIraUxTME96V0lvSDNDMDBQZURsSU95?=
 =?utf-8?B?YmFwajVUcXZHeW9ZZDNQZmlMMmhKbVJCT09CQmxyMndGSUdDMGlJRHl6R1hP?=
 =?utf-8?B?aGJyY0Nub3BjbmllcVN2VXR4MDB5cmZHVFZQTUhISlRVaTBIQ0tvdTF3Ym5j?=
 =?utf-8?B?b3RDdjJwUmRscnY2TVB6RHorWmhOeFdZU1VYS3RqVUlhdXY5d1Y0V2FheXdh?=
 =?utf-8?B?aEI2aEFQQnlNbTBSVitHcWJWNVVRSzc4YlFuRC9YdXNHK3Nsd3BLRVRTNUM2?=
 =?utf-8?B?M1c0WHluMVc5QVlkd1ZmdzQvdEpvSlBHckh0MkFVWWJRRlV4Vmhna1VuMzNv?=
 =?utf-8?B?MEExQ3Z5TUlnQlVSOUVTdzZRVmVFVFEyK1ArQmlKaGwzODAyTnhaWmUyeEdW?=
 =?utf-8?B?TkxxV25wKzFuSFN4Sy92eGdiRURQRDZhR3VlSlV0bklHUk05M2dxTXVZTW9y?=
 =?utf-8?B?ZzZQbkVWcVIvUHFuY1MwZUMwUGlVTGNPMTU4akg5UUc5YXovSHlrVGVjU0RH?=
 =?utf-8?B?UXVMQlhNZWNoUmV4c1FvcWowRkdwSEl6NGhHb1dON0l5b21yczRtWlJyc21W?=
 =?utf-8?B?aXNtRTlnMEFXOFBaY0NJU2pJVlRYZ1BuSHdzeXBNRG9EbllaWU8wYmFHckFa?=
 =?utf-8?B?VUI1cjRsSndBUlIrVklPdHpUNzduQjRaeFo2OWdWZGRVS3A1NmFEV2NpSTc4?=
 =?utf-8?B?bWUxMGtIbkVnQzhzeTdCTnpabllUVzFHZk1HZjVaWVJjaDF4RnJhcXF6Vkl2?=
 =?utf-8?B?RDNtYk1ZQURqbEpTY1FnSEJFRDB2SlJyUi9oZ3VFeVFEZzI0UGpmZlZsREs1?=
 =?utf-8?B?Z01rMFRhY2k3OHYzNnM2ZnI4U0laNFphbjBmbXpjSmhCVDFsMFJZSG9BZmdT?=
 =?utf-8?B?ZlRBckJrVDFXS1Z5ZW5BTWFXQ2dLOUpaeHJwcDlBbDNEU3hESHhsaVhLL2dJ?=
 =?utf-8?B?cXp1MURVeWZ4KzhoYUVvQWhmQVJpMThzWG14UkE0OERPZTJoZkhsYlk3Z0U5?=
 =?utf-8?B?c2RYbEdBb2l1blA1Y0lPMCtIRUs4VmZWRVR4T1kyV3VhRjJuZEsvRXdycHhH?=
 =?utf-8?B?NlZsWVlWVnZzNi9jWWZsMDZORjhIR21FUlJocVRxclBDZ2pJRkc2cUdUTzQ5?=
 =?utf-8?B?T0dpS2pqMlFuTVZCbTNTUml5eU5SNzc3Y0QrZFBlcWgrVnpWZGdia1VsQXJ1?=
 =?utf-8?B?VlRuVTBtT3ZRWGxiWllCTE1wRTcxK0cxUU1CRzBIQk10RCtuRkMzRXRmcVVq?=
 =?utf-8?B?a1p0bGlHU3Y4czY3NVk0bFk4TGRLY1BYNUhqNTZUL1BLenNoeFhFU0poOWhJ?=
 =?utf-8?B?R3VSLzZUL3V5Q3VUZ3p3aGRnbmtYeGJ5SE0rajRZbUhnNGhNMXNGRW82QUVr?=
 =?utf-8?Q?do9y+CvMmvh5E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmExc3pJMHdEWGJBNzFXSzkyMUZmQ2xQb3hKaHREcTNDcVFRNmNtVHRQOXli?=
 =?utf-8?B?L2ZpRWt6Tmdja1dJQjJ2K1g0UFhOeGtvU1o0MkxUcU81QncyTS9VcUs5ejQ1?=
 =?utf-8?B?Y1NFcng1TklRcitXbzRtY0IydWMwbFBwSm5BcENQVTNYM1lmNFk1NlBPNjZj?=
 =?utf-8?B?NjB4RjdFQ1lCdmZLRDB6eSszUGE0UVhiWnM5N2xnZll1aXUrZ00wbkZ3QTJ0?=
 =?utf-8?B?M2tqZzhwWDhuQkU4QVdlc241eE5KQTV1dVNqNm05dWFVYjlFR01Jb2UyVDYr?=
 =?utf-8?B?MVlyaGFGa3kxbnoweE4wZnZ5ajdmYnBxTS9NaVYwSVh1Q0RlZ3FOVzhzMEU4?=
 =?utf-8?B?V2h5OFM1cjlPTFZoalYwVE5XT1Nsd0dBREpURG1RcTB6elBrdURUSlVDOWJt?=
 =?utf-8?B?YSszTGVGTTA2RWYrNGc1SDduR0pyQVF6OFA1VitWWDliajhDWEwvSEs0TG90?=
 =?utf-8?B?bWpvY0NZQjdxeU9GalU1bEJNK2swQ3REc2pISUFlN2RWUUpPcnJWbE1COFJG?=
 =?utf-8?B?SzZXUm12ZVpGUzF1RFpnRVFUcjV5WkFIN1pmTm9ydFR3ak0vVGZrL2FEMEZh?=
 =?utf-8?B?SEFwaE1Gek8ycmhIWlBPTlFLMERnZTd1Zm9ZNGVDcDFpU3pOTU5jUVQ3ZFRW?=
 =?utf-8?B?YjhzMkZCL1RxRHVBZktTZkpmSk1ocUxucnZvS3hhYnBrZ0NlSmJZVXRBS2tq?=
 =?utf-8?B?K1dWNWVEMHZpRTI3YlpMVng3d2Q1QjM4dXFHTXdJY1d5UUdkc3lZT0Vqc3lL?=
 =?utf-8?B?V29TZGhyNG5OQm1tSC9jeVAxa0RNd09MSjgrTWU2MkxBa2hMUW9jUXVPeFkv?=
 =?utf-8?B?WVdCMGhTT0hDS2N0RkNlWWhkZWVvWmphMUVKVkI3U3M2dWZ3SUkwS3Z2M2kz?=
 =?utf-8?B?ZHFJMndjUlczeHlkR2N6THp3OUJ4N0J4SHA0OUcrMkVhWDhCT1pPcnlaaW9G?=
 =?utf-8?B?RGpNdmRveEErOFFORFA1UlZnN1NzZnVoNXRON2toTS9FUWw5cjZXaW1XcEM1?=
 =?utf-8?B?N2RKTUdhUDdWUmo1UGtYSHNPWDNnSE01UWo2emdLdDZRN3BpNnVZSlpQdUtN?=
 =?utf-8?B?Y0FNR3lkd1hLVFUzWkswVFA1NXUyTkdyQmh3bm54MkExUTFpWjFlNXdqYVM4?=
 =?utf-8?B?YjBvM2hnaURFTlU2bE1nZUJWbklrR0R0a3NuZ3ZqcXQzYWR1VjVaWXdmSDVR?=
 =?utf-8?B?d01wcG16SlBVQ1YzSHMzSlFJUGJvS01reEhrbXYwdUU0L3gvSlJPZjI5dTRD?=
 =?utf-8?B?ZDJtNUk4ZXVZV0FqV0FjSFJucTI0d3Jjb1VzOTY4dm95U3IzY0E4bitEekdt?=
 =?utf-8?B?MlM3Y1ZhbUdqaG1SUW80L0h5b21SUlRYeXBUcnlpV1VRbitFcWpiem1sUWJn?=
 =?utf-8?B?SmlxcmN5YXI0UHRRMDF0ZE1qTjVOSjRLNHVmR2tzcjc2cVJSN2IyVzZNTHJV?=
 =?utf-8?B?d09vS3RwcCtWYVNDSndZVExGVlM0VzFNS3RqWGk4eVNxR2pmODhXWHVEV0lh?=
 =?utf-8?B?OW8wZXZFOTQvanNIZlRObi9ZamtDVFpEdzlxL3Fxd3E4bmd2cTZ2UmtKNWFo?=
 =?utf-8?B?ci9wLzNPMTZHRWIzb05jYkVMc1lGQ1ByL2Ziam1CRFA5ajlpbjRJanJzK0d3?=
 =?utf-8?B?VFdtRzFRVGpSRjQ4dWJQTTRwNmtEb0h3Z1NJRzNYT2I2ekc0cGtIZE5FWXNm?=
 =?utf-8?B?U1JtWnFuLzlYbmcyb2JaTkFTVjlBZm5JQmJwUThxMG0vNEZIOHk2SzQ0S2tk?=
 =?utf-8?B?K0pVa0J1T2UwV0VaNDhCL3MyQjZKd1djczlkdFZJNUZNTFpyTmcyaFJtYW5M?=
 =?utf-8?B?Z1g5R05WSnE2MFA3bFJMUUR1ZUZpYVlGZGRJZ1c2MTZUSFVxNjRibmpjQWFD?=
 =?utf-8?B?S3I5UnE1VWNoTXpTT1E1d2RNM0dwdU5BcmttWlRVTmlXVTE0OG9Md3RINTA3?=
 =?utf-8?B?ZGl3WitsSE81L2l6VFB2UGV5VzZsL1pjcHVuTFNuS3VBaW9mYURHS0M5YzFX?=
 =?utf-8?B?a0RMQUFiQzRSYW43MHFiRGNtbEVCR2pmMnRPT0xlSFFMUTFRb3VHczdCOXM1?=
 =?utf-8?B?cHBDbS9nZjlXSllIZThiSWtncWVLRytUek5oL2VKVVdLV3ZaL1RRMXJ2bU9O?=
 =?utf-8?B?eUt4UzB0YVo1aFpvL0R3N1liMTFUTHJMZm84ditHWm5Qa3oySFFGSkhCQTRJ?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd96cc8-784f-4af4-dc58-08dd210e116d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:50:46.5489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlqRH7bjQ6IKrqSYHheM9wNB/399xOOd6OonhuqRZI4DWgMRKn1hC9DiVy7sOWbFOULGcjp0WSR74oq0KQ3EGQZD65UK3VE21hbrsWWz13Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8457
X-OriginatorOrg: intel.com

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Dec 2024 14:27:16 +0200

> Hi Jakub
> 
> On Thu, 19 Dec 2024 at 16:24, Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Thu, 19 Dec 2024 11:11:38 +0800 Guowei Dang wrote:
>>> Add page_pool_put_page_nosync() to respond to dma_sync_size being 0.
>>>
>>> The purpose of this is to make the semantics more obvious and may
>>> enable removing some checkings in the future.
>>>
>>> And in the long term, treating the nosync scenario separately provides
>>> more flexibility for the user and enable removing of the
>>> PP_FLAG_DMA_SYNC_DEV in the future.
>>>
>>> Since we do have a page_pool_put_full_page(), adding a variant for
>>> the nosync seems reasonable.
>>
>> You should provide an upstream user with the API.
>> But IMHO this just complicates the already very large API,
>> for little benefit.
> 
> +1000, I think the API has grown more than it has to and we now have
> way too many abstractions.
> 
> I'll try to find some time and see if I can come up with a cleanup
> that makes sense

I'd remove:

* explicit 1-page-per-buffer API (leaving only the hybrid mode);
* order > 0 support (barely used if at all?);
* usage without DMA map and sync for device;

+ converting the users to netmem would allow to remove some wrappers.

Thanks,
Olek

