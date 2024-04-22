Return-Path: <netdev+bounces-90029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCAB8AC8D0
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312C1280DAC
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9300F53E22;
	Mon, 22 Apr 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpUMjfIL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19BD524A0
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777794; cv=fail; b=JT3Xlf9oKlRrka4cYW63JK0wGWDvuyXe7qnkvYz4G8suqqS4l4RS32Ds5nFoUYF0bw75H2BcnYYeCti+WuyW/QEQ9kRDSLb2rWruRbSWaNOnYwoHTXZCDYJKfkr97gFnsCZDW8B8ZoVuHojcJ1TtxJn+zKswMCZn2mUYE1WqC2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777794; c=relaxed/simple;
	bh=V5iwkp2lvgaJRiBeOCrv8MM1iBLYNztHnr5H8IkPnjs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NbXju9Y2W2XcgEAPGfcR59l256Pwb/tBoxGCvZyKJ6hkOoAL2UFduYH+0KZzg/zRFTGd2TH6WDUcPADF/qBd7LCJtaY87BE6i40katldJv0DPrYdMSDPmxlAWHiORWOiDpTheZZYzcXAEW1WqAyIPuan8KLjEiKp0+Ui7NRntTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpUMjfIL; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713777793; x=1745313793;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V5iwkp2lvgaJRiBeOCrv8MM1iBLYNztHnr5H8IkPnjs=;
  b=mpUMjfILFAP4BXV0ta98fCgv4F9l93cx0RcwR/zWomcM7JvxJjYadgRP
   ozBFwFooCurcSevYpUia4jXI5WNSQX43TRFtfoyPzN8eekuc6ccHfsnoK
   SgkhbJ47/uInBAVJu3xnedFINO+7XJXc4LMRebt6Cwxljdu7yGIXLwDQK
   ZUFYZi682GtH6s7sRr5xUOjOD7KhJ79QMjDpJ7j/pVspwqsHG4WCFQ9SO
   XEUuWKTJwGq8olXLzlFx5xGvi2EHa3b9RFVHvvqiqzAdoX/kyum1ZMJns
   Ski8vQ0S8YguGmtpdibS/VS8PbMLMkpOH8OaToBI86thJrKaOfNUfgxNO
   A==;
X-CSE-ConnectionGUID: KzRaGSuvQa2vSea+0FKy7g==
X-CSE-MsgGUID: 5taOSstcRJaNuRyYUhGS9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9171651"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9171651"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 02:23:12 -0700
X-CSE-ConnectionGUID: roG+3CfZSFmGSbO9Lo7OTg==
X-CSE-MsgGUID: BWS/Vb8xQy29l6Qg2p8jnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="55171056"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 02:23:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 02:23:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 02:23:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 02:23:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 02:23:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ztq7igwTbCtFvibphuuvfkZEasFKDS2Tycjkzd21ZPvEeT3F480zfL6LMkXuNHqVNz66AUnE9/PRAg1ez/RKf+i4kLM2xcx7IohRaEimKoll4AYDUw544OADa1f4o90eL61KVIfmDq/v6j8pkpOs6nanSU+0IKSEUI2voHfjpZejVVDO3BN+4HsybayR6+/YlnPpbbbjZkOozrhkgr6fEc6YPxMIj+kmLQF39ONsAVdvy/hPoqcfxbJ7bC/uAZxw4higZ31Kzi2fuvqtdX8Oy+Ph38YitTrkEhNUr78LDCvMTVlvlPznA+lSqPajaEeeBpyDbQiSk0zNdXxb5ohtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAvufupSFuIGbNo4UZKu3EcAaEydoFlJZIuAe9EF8OM=;
 b=Y4tnqZCXrHeplAqyvCnn2G+9+lqy0LnIK2YUDJ3yNXkZ1QtM4oKOmk3zVfcgFgaEq3aLRcifwSarhdapHA2VNTH4TIsFxwIxhodPBRUAE6kYpGtmP1FQ+KuEg4BqYiqzI/E8E5RwGp86hq/ZWKeNpcwS+cVx1aTwgrL5LzDolLQ3WWAEjlcYdwkgtzGAzS0+WcKQYjrHv2I6Txvgwyhdn4WWBnTdYgYW4w9d/DpIVfKACu8oDcN0jQKwiKDXfhQh5DUeA/DhAwDEsQJ4H4LI8NyOEGkwnccju5HFdgbznqNawYc2IDLTRNwqKgCPjjVEdCEGBvnFu0oP89YEiqO4/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by SJ1PR11MB6249.namprd11.prod.outlook.com (2603:10b6:a03:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 09:23:09 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b3ae:22db:87f1:2b57]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b3ae:22db:87f1:2b57%6]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 09:23:09 +0000
Message-ID: <9d8e656f-1b04-4fc5-a5b4-c04df7d34fdc@intel.com>
Date: Mon, 22 Apr 2024 11:23:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 08/12] iavf: periodically
 cache PHC time
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<horms@kernel.org>, <anthony.l.nguyen@intel.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>
References: <20240418052500.50678-1-mateusz.polchlopek@intel.com>
 <20240418052500.50678-9-mateusz.polchlopek@intel.com>
 <87jzkue99b.fsf@nvidia.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <87jzkue99b.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0025.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::11) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|SJ1PR11MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb64945-28e4-47f5-b1e5-08dc62add314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEE4elluU0V6NXJPTzFvQWFjSVBJU1VwY2FHbE83YUJLY0RQUWFPS2phRS9C?=
 =?utf-8?B?K1RyYXVwdElSZVJEbW1tSSswNDRPUFpORGtYSVBFN3FwZnpQcGVuQWhJdi9n?=
 =?utf-8?B?TWprZC83ajd5TXVsc2tGRDVyejdqb3d5cW1rM3BxTExsYUNuUHJDMUFkWk5J?=
 =?utf-8?B?ZSt2dXZscGN1MjFCN0NkV1o2cFEycU5Wd1VPQVVVMkoyeklpbjNZZTRWc24y?=
 =?utf-8?B?ZW1MUCtNWnVyNGQ5czZ2NTNKSFJoUGVzd2svTVB5T1ZpSzFNbENXN0RSdDJX?=
 =?utf-8?B?RC9SU1RHanUxcER0R2Rnem14citWeEZpdTBGQ1lwU3l2ZTUzVjFtVTNGZ1Fv?=
 =?utf-8?B?R1VnVDV0cjVpZXhYMG1NT2xKc2w3NVhtWTJIazZUR0duMEhScGVkOU5pcXU1?=
 =?utf-8?B?WklkQ0NHVHdVdTZQMnZpYkpsQm40QnIzalVFK21mbTFRNzQxVDV5OFVvcXh1?=
 =?utf-8?B?U3NHVmN6WEx3am5jTDlBcy9OQWk5TEwrMDVOc2F3dGNaOUEvSXoxbmFpYm1D?=
 =?utf-8?B?L05tU1NuREVEYnRFNTVSdWhEODlIUEs2dDA4M0xCOHAyWVAydVhYSzlSVjE3?=
 =?utf-8?B?YWU4TytvQWVad3dRTlkraldldlk4TmNsTkdSeFN4T2hwZEJBM2ZSbUt1R3NW?=
 =?utf-8?B?Unh5YkJvcExDTnpWR0VZWVRmV3ZyZXVkNzZxZzI4QVNWSDdzR1NKOHZoRDdz?=
 =?utf-8?B?SjJIbDJLVzhIVTN6dm53ZDN6b2tpbG1SdVFFbXVNby8wSmtnVnpjQ0hqUitJ?=
 =?utf-8?B?aVFUdy9Vci9wR3lNUXBaN1dYYnlFSnArbmIxRWFicUxsWWl2Y0Qwbm8zM2V0?=
 =?utf-8?B?M1FXVnBYL1FwbnpxUWdpTWMwUnhwdmFqVXViRDE1ckF1U3BWOUtSMHpIU1Rp?=
 =?utf-8?B?cEVOVDBpRXQ5MTVIUC96enAwRzlXWk1zMG9nZXFwUTBJZmdmYjhiR2lib2dV?=
 =?utf-8?B?YjVITGV6b2lEbTg4YmRURVN5UUU0WitZTVB3cmpKeERTTWhhNVI0d2RkUXBM?=
 =?utf-8?B?SXJrYmNua3FjRnBBTVpWcE1xNXVIOXl6Ui9UazVzZ2ZUNzBjd2ZPWmp5YzFM?=
 =?utf-8?B?MEcyR3VjV0MzOEpNaEd1VEhrU2tWT3RGbVdyWVIzSU0ySVc3MVZPT2JyU2dU?=
 =?utf-8?B?ZEVDTTlmTG5yY1hnUGRvUzNUSWtqQzNQV2xWRWlNelZZRW42TWRZQUZqQkZD?=
 =?utf-8?B?NW84SjlHR0ZpQ2VYUEhGaXhuOTIrWW5rYkt0WkIrNGt2clBSem12bWhhSmJ5?=
 =?utf-8?B?Q2cxMFU0L1hwNHdjRVBuU1BqZk1mTnlIOUJySGhJeFB2OVo5VnVYUUd6ejM1?=
 =?utf-8?B?OE5nWWowQnFGLzNGS1NmQ1Azek1idDFTWlQxdmNUNmgzNTJZUEFnWSt1RVFt?=
 =?utf-8?B?cGZLWmNQd1NxR253MzVrQzc1YzZjWkNBSUEwdnZnU25HZ08xY2NNUDhkekN3?=
 =?utf-8?B?Q0c3VUtxM3YzMDdEQjVDNkhMekFFeEJiekhFTDNtcTNuN05FTXI5TktaTDkx?=
 =?utf-8?B?Z3VwUkhJNEp2SWU4eXBvalRVS3FpSzBVS1NIM2xoQXVYd3pkS2R1K1doRDBN?=
 =?utf-8?B?VlZHYnRBWXVNKzVrMWVGOUU2OThXZ0hnWG5mYmVXN0xoT0w1aENtVk41ZFhE?=
 =?utf-8?B?TkJTdExLbVdKT2lsVThyUkVNNFk4MnY3S0J4cDRBWlp1dC8wV3NUT25qN2hh?=
 =?utf-8?B?azJXL1pvM3NXb0RNSXdTajR3RWRTN3pMQk9WN3dGVS9temFURlVmUWtBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGVJK09PZVYxdHFpNStadk5DMXAzZ0dtWndQSVVsZHN1d00ySmhxb1E2YmZQ?=
 =?utf-8?B?TVcxN3NIblUxN1h1dDNrb2R5NDBKeFcxUkRLZWs4eHRhUWtRRCtsUnB1TFV6?=
 =?utf-8?B?RUNSZERITWE0cWlXRlFhM3RxZUd6U1RhYjByd2lCTTRkVmdUcGJ4cHlxaExB?=
 =?utf-8?B?OGtWZGpXWURLaWVXNkpXUzdDQ3JMRXZpN2JUT1BxLzdNbWVheDZCeHVIZGJT?=
 =?utf-8?B?ZCtKTDZoTFVEZnZXeWE4b1pWSmQyQTJOUXpFb0EreFdZVHRBSnNzRWE0RWti?=
 =?utf-8?B?anZYNlRER1h0c3JBMnpaTExKYUNnSWhGejIrYTBJK3RkTm9WemVaSUViK0x5?=
 =?utf-8?B?NG1GbjhNMmJBWWdSSzJnTFhlOEVzTlBlQ3dXT3k2S2ZDTmVMSHdINzE2d05D?=
 =?utf-8?B?VTg0NzRweXQvWmM2ZGU1MUdJWU80L3J5U0xUNHRYZmVrZzdwcWEzSHZYWGp2?=
 =?utf-8?B?VzY3RmdJMm9PTEdSUGdZQnNuTVVCSVpENnJJMWxQcDJaK2F6d0x1VXc0U0VJ?=
 =?utf-8?B?QXRaaU82MXRTWHZxVmg2ZmpMOTFuMXJzOTkzbzltYS9WUDNlNm1TZXFTd201?=
 =?utf-8?B?NUtvdUhYZ1lBTmFxcmtlSW96dVdGU1RzWkt1SGhaYktrR3FBTFI0UmFXZzl1?=
 =?utf-8?B?Tng5OXo2K09TZDRRbmVWYWhWTXd4VURLYjZvTTBKR21CL1VWeEhzYUwvYkFU?=
 =?utf-8?B?NVBiQ0lrdGw0L1FrNXZSK2VscjljbXZyYjc0QXBVY1hsRmpxZThHLysrWldW?=
 =?utf-8?B?RkdrS01DVVdiUE1UV0MwUFJxcnZjVkFMQVlFTFJtUzNGV1R0M0FsMGsxVW94?=
 =?utf-8?B?YURkNVVrVDhLQW8wSTZUWkpqK2dIbjl0V3gzR0hvVm44TVpxNFpLSnl1Uzg1?=
 =?utf-8?B?Y1ZlU0Zudk1ycTRqa1VNT1QwWGNKaWZ3eDcvdlhmdUNMWVdad0haWm1XSkhL?=
 =?utf-8?B?Vml3eVNESmZJYm11VUJ5bUY0Q1lNZnV6QldYVGFqbWdYWW4rdE53NUZqNFND?=
 =?utf-8?B?MWNuYTRaVmgyc0pBaG1mUm9FaXFPeGVQRnBiREtUNjMrQS81NmJoWFlvdGhO?=
 =?utf-8?B?eVNnQU1IRkU0SnozVXVrM3A2dzBWOCtGTjFKcFFVbGZubzZPQjRUbjgyWmM1?=
 =?utf-8?B?VVhPNXVZVWFQbmVkdUIwdFlmM3ovQU1iL09RTER4dFRZb1BHRlB4eTNUZWZI?=
 =?utf-8?B?NVJzT1FrMXVXL2o0ZHpkYTNUcFVmaWIvZ3VBRk9Ta3Y2ZDJteFVlMkRlejZY?=
 =?utf-8?B?WEZIWFlFVHp1ZXhRd2pjZm41d0hIcnJZaENGY3VUOHdRZ21TdHN1L3Z6bjVF?=
 =?utf-8?B?T3VKNmRYaTI0dGR0ZEZDdjNwUDcrRmdZblRhb2RvdXRCUkxWSGw4QlJRZHdi?=
 =?utf-8?B?aERUNWg5QlVWam1DL2tDYlU5TE1iSUViRnlxeVE5eVRZMTRIM1BEOGpGY0RC?=
 =?utf-8?B?anYzb1JQcWxnZ0ZySWQwYUZEVWQ2aEttTlZnQ0tMMzQ1M0Z3VTBGbHA2Ykdw?=
 =?utf-8?B?dHI4TUZXQm8yYlo0bit3bkVsZjBEUVhFaHBMYjNka24xSitRYnZWRUNCd1dS?=
 =?utf-8?B?Wndna2pKR3VYa2M1MStvZGdPb2ZCMzZCbGtWcDFSUGxLWVo3TUx2VXdhZnFD?=
 =?utf-8?B?d2dqRTZpZ2xmUzF6cnVYckU4Ujk2bkpGRVBGeXdOUnBaN3l2eFZKNlpnNHpZ?=
 =?utf-8?B?WC84Nk96L2g0Z2kyYVdsZEE2ZFdUS05nMGJCYlhnRjBERVcyVGpRZ1M2UHla?=
 =?utf-8?B?ZW5JeEo3VHNTVlN0U09td3hFc2crbDRIT3piUHQ3dDRoY1BydU1NZmhkNytL?=
 =?utf-8?B?bkpuMG41WDFOUWhVRTJOOERQWWs5a3JBWThnK1pWb1VFT0xTbGc1bGVrZmg3?=
 =?utf-8?B?ejYzN2RRWHFBYXlkY3pNMFdyck9BSTFYb09zWHZENEZGUjNEU0lUUXhEOEgx?=
 =?utf-8?B?cDhSUkNDR1Y1WFhHdzhQMFg4SldzbnFxNnd3NzRBOVJORzF1aTdwMmNTM2ZL?=
 =?utf-8?B?cXBBTTlNZ1l6dWpsdGpNY1UwbloxK1A3S1JtMm9qeXc0Y1hoYTl0K0ZVSVI4?=
 =?utf-8?B?bVFqamoxVEEvSTlhQkVEYS94SHFaNVpubE5HZW4ySEt0Zm5wbjE0cjhtOGtv?=
 =?utf-8?B?amw5Tm9RU2hrMDJMeGdvVkJIeHZmNUVmK3kzekVueHg3RjBuUHpqUWVtL2xo?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb64945-28e4-47f5-b1e5-08dc62add314
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:23:09.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02qvDHOiZxJRRZULp5V6QzI7fjm1j/b6jQyKIQlJrnCxFQSPdXhWjsPaY/KLEfcHV3/VzxpRN/TY+/7pAs6YjNpIj9Ua64c0MsZ+ieCNgIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6249
X-OriginatorOrg: intel.com



On 4/18/2024 9:51 PM, Rahul Rameshbabu wrote:
> On Thu, 18 Apr, 2024 01:24:56 -0400 Mateusz Polchlopek <mateusz.polchlopek@intel.com> wrote:
>> From: Jacob Keller <jacob.e.keller@intel.com>
>>
>> The Rx timestamps reported by hardware may only have 32 bits of storage
>> for nanosecond time. These timestamps cannot be directly reported to the
>> Linux stack, as it expects 64bits of time.
>>
>> To handle this, the timestamps must be extended using an algorithm that
>> calculates the corrected 64bit timestamp by comparison between the PHC
>> time and the timestamp. This algorithm requires the PHC time to be
>> captured within ~2 seconds of when the timestamp was captured.
>>
>> Instead of trying to read the PHC time in the Rx hotpath, the algorithm
>> relies on a cached value that is periodically updated.
>>
>> Keep this cached time up to date by using the PTP .do_aux_work kthread
>> function.
> 
> Seems reasonable.
> 
>>
>> The iavf_ptp_do_aux_work will reschedule itself about twice a second,
>> and will check whether or not the cached PTP time needs to be updated.
>> If so, it issues a VIRTCHNL_OP_1588_PTP_GET_TIME to request the time
>> from the PF. The jitter and latency involved with this command aren't
>> important, because the cached time just needs to be kept up to date
>> within about ~2 seconds.
>>
>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>> ---
>>   drivers/net/ethernet/intel/iavf/iavf_ptp.c | 52 ++++++++++++++++++++++
>>   drivers/net/ethernet/intel/iavf/iavf_ptp.h |  1 +
>>   2 files changed, 53 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> <snip>
>> +/**
>> + * iavf_ptp_do_aux_work - Perform periodic work required for PTP support
>> + * @ptp: PTP clock info structure
>> + *
>> + * Handler to take care of periodic work required for PTP operation. This
>> + * includes the following tasks:
>> + *
>> + *   1) updating cached_phc_time
>> + *
>> + *      cached_phc_time is used by the Tx and Rx timestamp flows in order to
>> + *      perform timestamp extension, by carefully comparing the timestamp
>> + *      32bit nanosecond timestamps and determining the corrected 64bit
>> + *      timestamp value to report to userspace. This algorithm only works if
>> + *      the cached_phc_time is within ~1 second of the Tx or Rx timestamp
>> + *      event. This task periodically reads the PHC time and stores it, to
>> + *      ensure that timestamp extension operates correctly.
>> + *
>> + * Returns: time in jiffies until the periodic task should be re-scheduled.
>> + */
>> +long iavf_ptp_do_aux_work(struct ptp_clock_info *ptp)
>> +{
>> +	struct iavf_adapter *adapter = clock_to_adapter(ptp);
>> +
>> +	iavf_ptp_cache_phc_time(adapter);
>> +
>> +	/* Check work about twice a second */
>> +	return msecs_to_jiffies(500);
> 
> HZ / 2 might be more intuitive?
> 

Makes sense, will take a look on that and if applicable then will send
in the next version. Thanks

>> +}
>> +
> <snip>

