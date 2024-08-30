Return-Path: <netdev+bounces-123719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0324966455
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A30282418
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6919ABA9;
	Fri, 30 Aug 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6kmiViE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C91422B1;
	Fri, 30 Aug 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028995; cv=fail; b=g7Fi4MXSahpgKPMhUGIV84vSOFdJyZtjg8i0EEwTdyYVpsOGyL7Ssvln76qIHyobBgCmlqi+oD89xLTVY4yHxbSDP+3WEGtmCxm5VjuDnhBw0D6Y4lrhWs4qFUmmU8cHwRmDez3vtPyHQngMPZVYPD+HXN6gQWOdhCYCk42vM58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028995; c=relaxed/simple;
	bh=SDFTNEBArwb0Pz1cRD5cQ9/S8BhjPJmBCfdAJICVo2s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NHJysOwVIPE95hpLWwCHyFtRShScSSlAUrxjRaE1Eh6fYC5lyr7Kx06WRN89K25/SNT8Op6ErlM/KUrE/L+Y3G72xXlXILYFIeap8JkEw3nXFOlhmV0FitARn/spBpGNiP8Shhd8Tuv4+3yiadVVtgYLxLSWo7O8e/mEPchx+vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6kmiViE; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725028993; x=1756564993;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SDFTNEBArwb0Pz1cRD5cQ9/S8BhjPJmBCfdAJICVo2s=;
  b=Z6kmiViEjcQUwDdMYsrKQXez3nxtrVXp0lEx1qav6ct14QL7CcH2Vw8I
   XeXTt9tDDsA9YYOjqM31JCBSb4qcRHrL9JhCjQA3bvb9JQknD2RGJIdrr
   dLC+8MQTuUHvLK50K3dPtZY67yhc+s5QbNG9WXXc8JcCW4R1GuMa3U/Ph
   /F1RIfpYydFYWIOhO/zk7JSEkivNPxH9GDmJVzLHut1vOD7p036e1uYoU
   ftROOqEtAY6UQ8cCQSx5g3lDYGKxGf53aeJKlYkIH47oguoj+An9M0gnI
   WSvW8aPp51+AIFLE08rFLOoA5KaiEJkqrb+BMD3Acbn6NC57S7hMuLjEO
   Q==;
X-CSE-ConnectionGUID: sRbG+5LdSy2eHCwrauU3ig==
X-CSE-MsgGUID: jWLKo5XVRnu5zzVjgssFPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="41153712"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="41153712"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 07:43:12 -0700
X-CSE-ConnectionGUID: tisVofWDQ8uSq7LeLZ49EA==
X-CSE-MsgGUID: mcyASh+pQwCMQAZQbz1KPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="64267051"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 07:43:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 07:43:11 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 07:43:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 07:43:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 07:43:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylpDBpmAiYIZH2jw6ZNBK3KqkLLjH9yKdfWXmu3ocNjlEdXOEp/VIY8MrHdztmOjA7Ug7J733DC/Bp6af70vnyHmVs9B/11unmhsTZgUb1/e7Ol96nLC1LN0wKmR68an8Pj1tURU0Fxrjm0/8F/DhmUoG3L7KwjWoSdzV9GFm1LK1MJWGvRgKxWbqYFnDRfjzHb+vE4E7YMVjJpMbx3TwSaj7lO5mOIYLdW8wOe/85iwSDZ1vPCFANuKXMDch4hL7B65eeEhJqfEOM+nIeuzo48MFnUnFCSUBOGeAct4JGXB0d1J0Xcu869TlSbabZyZbDYzPhYclKtJxvSNJ70P5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qz5NTu+B3VsvfIyIPJg2bjLgDi7U6iFDHqD10A+hoL8=;
 b=T9TMenDZYM2zVAdfijKf6TZ+pBVQ4L2v9Aq7uibwRWpCdzWtuZ83I+0f0guP4HimjjgpmkS6PwZqNikQfzBNCkgJTQiuaGlasxHarAbJg/sCs7LmQtts7ENS/sJnp/ofn60/gVlnczU3iU0xTBIMrvsnESJko725Vm1XVA0nCm4E3rdX1WX08pVTzeSVNUOJhiN5wEEjFGj4XNG0KhgSqfZhCmex+Ixzh0ZIdW58GN/wCN/Sn6IzYmjh7JYMjcjPq9MLKaKotoRniHScUASdPYq1yV6NHqVabxnDxcmasi39nGMBE0vlF+zRXSGYY+zQQyUNaFFkLBBiiNZwTLYpbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW6PR11MB8440.namprd11.prod.outlook.com (2603:10b6:303:242::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 14:43:08 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 30 Aug 2024
 14:43:08 +0000
Message-ID: <32b49d2d-fac7-47cb-aa78-c21e8bd2f479@intel.com>
Date: Fri, 30 Aug 2024 16:42:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/12] net: vxlan: add vxlan to the drop
 reason subsystem
To: Menglong Dong <menglong8.dong@gmail.com>
CC: <idosch@nvidia.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <dsahern@kernel.org>,
	<dongml2@chinatelecom.cn>, <amcohen@nvidia.com>, <gnault@redhat.com>,
	<bpoirier@nvidia.com>, <b.galvani@gmail.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-2-dongml2@chinatelecom.cn>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240830020001.79377-2-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0142.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::21) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW6PR11MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: b016a484-590a-4b6c-bd3f-08dcc9021087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WU5TMld5ajIyVnVnOVltTXdrTnNxclhqSWo4N0hJa2tWcVdFM2h0UjdHVXlW?=
 =?utf-8?B?QjRucEJYL2NtMGxyUzVWcGJzRHRoK1JVcldTSkVLNVZiaEFIWmNoTlF3cG16?=
 =?utf-8?B?L0xwYXF5ald4TXpMQTdHV1BUMDF2UVZZNHFaYWU1V0psMFhhaE9zN09uUnBY?=
 =?utf-8?B?NWdxczhRdzFKZ25STWJ6VkU2T0c2QTU4NkhyekZ5Q3dEUTZXWXNSYXB6ZkVG?=
 =?utf-8?B?bkt3RGlsTlVDcmlpNnZGOVBtTHB6TzVlM2NZRHJ0Yys0bXlGTWFzSHg2ejdq?=
 =?utf-8?B?Ky9JaS9EWURCTHZXamJTN0RjSERqMTE2ZjZPMFFLRjZYbU9DMDVMMXdoQ2Yw?=
 =?utf-8?B?cHYwdFNNOFJRR3oxWTlUZkpDRzVyei9YYWJPTTVyU3RDd0wvTXFwTU5mNWpx?=
 =?utf-8?B?YkkzYUtKbmNIYkd1UWQ4bTgrMHBKWHNPMmJPQkxGNC82bGFHL2tsdmttLzkv?=
 =?utf-8?B?UTg5ajZTNEdlYlcvVnVjczFIdE1lVWZXVmFJWEttdzNxNmdQeS9iUGxhUjM1?=
 =?utf-8?B?eGh2ZnNVeExqZWh0WXMzVjBUZ2ErU1dmcFVPdHJLTG9yYzJ0R0ZvaEJsTEww?=
 =?utf-8?B?TDloSi9MZVpzYVNJdVlWd0dRL0VuZDk5ZG9rR2RJeXNoTjdpVE5MRXhEV29F?=
 =?utf-8?B?ZTkzTDA1SmtpSHFJREZaUkV4TGdkcDJhckxad3lsTTdqWXJmZHo3dUQ0b00r?=
 =?utf-8?B?K2hUc2hrL0FucnkxYmdBUm5UK0ltNm9sM0NxdnYxNG9pUzczOHRNMW8xTmFt?=
 =?utf-8?B?RzRaR0ZFVGt3TDBwOThGMkhmVTBiTURXdEZjSTVYWGNpQ1BTa1VaWWNXaDNv?=
 =?utf-8?B?cU1BbXlnSndjZUJEeThoZ3dyb0tQMWlFZUxJeEU2RVZoN00ydjBEdVJVMGI1?=
 =?utf-8?B?SUMwdmNMSzVocEF4YnV5V1k2WkxQL0J6RG1IK0RpMTFCVzZkbGNoM1U0UEgw?=
 =?utf-8?B?YzVkWTRWWHpWOXY4WGFwZ0RHTjdldVpKVVZEUTh2OWx1cUZLN084UlQrMlRX?=
 =?utf-8?B?aFUrMFFrenA2eFFKR1p2K1hBVHhhWXIyN2paQ00zUWdZOUpCS1djcXMvbkVq?=
 =?utf-8?B?L0dza1pDV3RxKzRKU3Zwc1plYnJqejArNTA5RENsdmJHRkZLcVZ0TGVHMkFw?=
 =?utf-8?B?cXU2TnRvb1drWG5hajZ1K2FxdFk3OTl6eU42VnoxRUlabVRwcCtIbXhuOENa?=
 =?utf-8?B?RU5kSlhSSHlFMm1CMVJhT1Z4SjF0eEFkaVlGQlBPYzhwNC9Oc21yL0tmNU5j?=
 =?utf-8?B?ZlFlUnN1TVRyTGovV0hxZmhJdkVQNythSE1xYW1GY29wcjlFY01qSjVmUmg1?=
 =?utf-8?B?Y01tTWdsZHJnOUxGcXVpMkkyRUJvVmlId2F5N3N1TmdNNEFpRXdxaGVKVVd3?=
 =?utf-8?B?YS9CK3paa0NqRW1oaXhrdVdjZFZ6dFBYTzdxSFZFejN4TDhZaTdWQitmaGE5?=
 =?utf-8?B?TitaUzVTMUhOSXFPT1AvM1E1b3VWVTRTeldNU0xyUVZYeXF1THlQeTFPR0FO?=
 =?utf-8?B?NXJlMmFZais5UlBKV0pPL1Mzb1FWVkpoeG96SWlaQzI5Z2VXUEpxUkFEYVRI?=
 =?utf-8?B?ZUJ3bzB4cFYrQlZtUWM1OGNTaHpxSy94MlJyUzJaTFdtY2ZlSnZnYklOR2dI?=
 =?utf-8?B?dVJaOStqdjB1Ykd4dCtMaG5XUnJjOTFrNDVaQXRudEs5UlR4MDlJUWJhM2tF?=
 =?utf-8?B?cXF2Nm93bW5FZ3JTa0pxdzNhNXg4cHFqbTFYWEFRMXdDdkVhZ1U2emFNQy9D?=
 =?utf-8?B?dEp1VEhBbVlXZkIwSVRCVkxOTHNDVFplbVN0ZkFkMzhFSzh3TmplQ29KeS9I?=
 =?utf-8?B?eW5yWlBRMnVaSGltOFc4dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clBDVSsrbW5rL1VKRWg5NzZVeVpNaUNPbkdvMlhvRWt0Tjl4dEtaQWdxZThT?=
 =?utf-8?B?QTdYaDBmLzdiTFFkaTlNNnZ5N05rMzFkQm9kTEV0VWFkbTl2eU1pSisyN1dE?=
 =?utf-8?B?d3F5WS9kQTliQ3QySmZVSlBzTXJ6TmhKODRBTGxsMmIwa3VSd0Q5SnBmemhM?=
 =?utf-8?B?dGoxdlBwNzhzOU9DejA2NUpRdTVOd2RWaWljR09sSjVRenB1RDl2YjBYcnYw?=
 =?utf-8?B?LzljSDBqSkplbzRNQlA5cTRRUnplamEwWWJKYnJiV1F3TWc5OFluZGJFRjRC?=
 =?utf-8?B?WGhtaUZRdnFWTEh0ODUyMkR2YjRHWjRsOWRmKzB4amhJTzdzSG9ocWc4N3NK?=
 =?utf-8?B?SGprdmZQd284bW5LM3pycFFvN2RuTVRGTnlETDdnbEo4ZTRGWVFRdTljT2d6?=
 =?utf-8?B?aDhaVUlyVkRWMmUxR1dBdzZuYStpbDJ1Z0dTOStxbFVEanNpZ0sxdU00UjlE?=
 =?utf-8?B?bkY0WHdlY2loOTNzNlZVWEFtTEhKTUNwU2xBcENZM0grZy9WY04wc1k3Rk9L?=
 =?utf-8?B?ZWlUaFprSjVsWDZQTkxtSGJQZzVRRGYzSWpISlpQV1l3MzV6TjNsc3lScTBY?=
 =?utf-8?B?YVBDNllMY0l1V0dMcExlRjhVdVJPSUFCaXZSVzZkT1k0R2JFOW9FeUhFRURy?=
 =?utf-8?B?YUdBMGNEUTBGNCtUdWNpRko1QVJCTkdTNEtTZjlUWXB0c3diVTU4Q0Z4bW5F?=
 =?utf-8?B?dGU0MDk4K2dnQTZFMHZ4UTd3c3BxSEMxdVlGVEFvK21lcWtvcnNuUkxNd0ds?=
 =?utf-8?B?eHcxbUdjaGdzeE9NcHExc1RjOTJvZmlhaUpUeWJ0SHMra1FIZWc3UDVma21r?=
 =?utf-8?B?Smphb01PY3NJbG5WQ0Q3RENhM1M0Ykg2WFZ4T25qUElWY2FnUTNaek1oTUJW?=
 =?utf-8?B?UXpSejIvOFdWbStqUHhEVWZGbmVpQStkcGZFRjNNMW9rSmNucTNqV0tHQURm?=
 =?utf-8?B?QUJ1d0x6WUl6UEtpQWpNcklraXlHYzdFQW5FS3VlQXhaTDI2TDZDTHJKTEhy?=
 =?utf-8?B?STRjTDBJMW5KZDNaYkFKbzlndUxFZEIrQU1BWjZXRDFKcW10SWduc1hBYzRl?=
 =?utf-8?B?Q3NscE8raStFeEl0TUN4elBCbVJqL1RDc25Nc1h4MGo3NjFVMmNGVEsrRXQ4?=
 =?utf-8?B?RWhyZWZzRTJtVHZJdW9DWFFvbytzRW0wZEVKNzBEYmFHWThLZlVQKzJkZlE1?=
 =?utf-8?B?OVRscVpGRWxnaVZHYk1ZTnRoVEtjcDI5R0Y3MkxZQ1VoYVVXUHdjR1FwbHlo?=
 =?utf-8?B?UDlYSjZlRHIvU0hXYlBDL0w4TmM4SmhtYXVLSy8xWmp0YW4wekI3eUhHbXh5?=
 =?utf-8?B?MGw4S3JlNG1Da09LMUhZb3UzWVpPVEdoc05mZ0ZxZzh0dEc3S3Q0NHVab0xu?=
 =?utf-8?B?ays0cXRTN3hOS296MThwNm0vRkVzRzFEbUd0N1k1NlRBRTFwNTlOczREZ2p0?=
 =?utf-8?B?bzM5V2RlZi9LelNBdzcxV1N3UzBqN0dyWlhiblpCR0tDVWRNNkttM2tjSmIw?=
 =?utf-8?B?L3c2bTRTazVXbTl1aU80djFhZXZvSldHTFpTTFJabVYyZjNGcksyeHZOelky?=
 =?utf-8?B?K1lKS2NKc1AyaCs4V0xNWjNRVDN5Ukx2c1JaS2xmZUYzZXIrSFdMMnBUWElC?=
 =?utf-8?B?WllmMURCVDZ1d1M1ei9sWXlJZDZkMFRTc1dNYmliVGloRDlFZ2xhOGp1NTlM?=
 =?utf-8?B?V0lreG0vNHc5TkpucHRJeE1lMmZGODNEcGU5enk2aUlZMHZLdWZQWVd4T1VG?=
 =?utf-8?B?RWVvK25xcllCdTFIeGdQVm9mNnRuMWRvNWFLMWNoWFNmNHo1dkhBSVZyenp2?=
 =?utf-8?B?TWIrNkZEN2ZmVjZxTjVOVXgvV1VuMW92QmJlZ25rUFg2VFc2TkhPcTBmUEQ4?=
 =?utf-8?B?TXdmUkxsVjlGUHdjcnVVMHlLSG1nRFhhM0hmTTRGZUdIazJUbVJNbGE0MG5X?=
 =?utf-8?B?Q0haSFRadGlzamF1VGxjd0hob0ZuTEhlcUN1SXBUWjBBMTBubFUreFprNGc5?=
 =?utf-8?B?amwya3Y1N1ZCYjN3RStCK3BLbXdBOUFIaVBkY0Nla2YxNm1oUzY0MXNRVzN4?=
 =?utf-8?B?NTBudnl5aHRoNU9ma1pVSXYxYnkrV3ROTGJyTlF3bWtNelJFSGpuYlE0WUNp?=
 =?utf-8?B?a3YrOW5pL3c4eFpqSndjTFpvRWhWa0VRMmRYTVpHUmNhK0hqZlNtOThjaVhN?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b016a484-590a-4b6c-bd3f-08dcc9021087
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 14:43:08.6867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rG9WKQBsGvhEw9lrNLtHxo1/i+gwxb2IgUU1Z1PWokAbssfksbJVEPwE7VdhVEuQZE/niQ6QSeF9D1rixa3AJ0eghtuxudyz+u45yKH1sf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8440
X-OriginatorOrg: intel.com

From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 30 Aug 2024 09:59:50 +0800

> In this commit, we introduce the SKB_DROP_REASON_SUBSYS_VXLAN to make the
> vxlan support skb drop reasons.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  drivers/net/vxlan/drop.h          | 25 +++++++++++++++++++++++++
>  drivers/net/vxlan/vxlan_core.c    | 15 +++++++++++++++
>  drivers/net/vxlan/vxlan_private.h |  1 +
>  include/net/dropreason.h          |  6 ++++++
>  4 files changed, 47 insertions(+)
>  create mode 100644 drivers/net/vxlan/drop.h
> 
> diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
> new file mode 100644
> index 000000000000..6bcc6894fbbd
> --- /dev/null
> +++ b/drivers/net/vxlan/drop.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * VXLAN drop reason list.
> + */
> +
> +#ifndef VXLAN_DROP_H
> +#define VXLAN_DROP_H

Empty newline here please after the guard.

> +#include <linux/skbuff.h>
> +#include <net/dropreason.h>
> +
> +#define VXLAN_DROP_REASONS(R)			\
> +	/* deliberate comment for trailing \ */
> +
> +enum vxlan_drop_reason {
> +	__VXLAN_DROP_REASON = SKB_DROP_REASON_SUBSYS_VXLAN <<
> +				SKB_DROP_REASON_SUBSYS_SHIFT,

Maybe make SHIFT start at the same position as VXLAN, i.e. align the
former to the latter?

[...]

> diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
> index b35d96b78843..8720d7a1206f 100644
> --- a/drivers/net/vxlan/vxlan_private.h
> +++ b/drivers/net/vxlan/vxlan_private.h
> @@ -8,6 +8,7 @@
>  #define _VXLAN_PRIVATE_H
>  
>  #include <linux/rhashtable.h>

Also an empty newline here.

> +#include "drop.h"
>  
>  extern unsigned int vxlan_net_id;
>  extern const u8 all_zeros_mac[ETH_ALEN + 2];
> diff --git a/include/net/dropreason.h b/include/net/dropreason.h
> index 56cb7be92244..2e5d158d670e 100644
> --- a/include/net/dropreason.h
> +++ b/include/net/dropreason.h
> @@ -29,6 +29,12 @@ enum skb_drop_reason_subsys {
>  	 */
>  	SKB_DROP_REASON_SUBSYS_OPENVSWITCH,
>  
> +	/**
> +	 * @SKB_DROP_REASON_SUBSYS_VXLAN: vxlan drop reason, see

"VXLAN", uppercase?

> +	 * drivers/net/vxlan/drop.h
> +	 */
> +	SKB_DROP_REASON_SUBSYS_VXLAN,
> +
>  	/** @SKB_DROP_REASON_SUBSYS_NUM: number of subsystems defined */
>  	SKB_DROP_REASON_SUBSYS_NUM
>  };

Thanks,
Olek

