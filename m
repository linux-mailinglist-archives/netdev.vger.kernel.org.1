Return-Path: <netdev+bounces-86321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FB689E637
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708131F22C1B
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37F51591F1;
	Tue,  9 Apr 2024 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+dUG+i6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16583158DC4
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 23:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706107; cv=fail; b=XlPkuWXO0RzMm9FztC7VhbgFcQpe3hUfviqRIEQc14L8weQnXsi0OnbKc7uZjZhYcWO4SpTRHlwdd05A3Oag3beLqn1fWdE/jnfGRxYbb9bbnZYX2Mtlb3drr+3agAYK4R+BPuxKp4Gk7Ds31sCJa77lahmWwKr6fTvAFUOC5jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706107; c=relaxed/simple;
	bh=hdbO220lILr52L7s/BnMy9HmMgaB5uaIsKRWFyINgZo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eXMKvhWkNtyWQRJ1T2hJwKIYxi8dg8SdDSrIDXe7bnbewx0SKNDrjMfkpCOJ2nc1/uGpsICckfruptL241rrTERkZCQdN/IJWszWCke5suBkgyILUMtflbGxZnUSqcF7QDhmv5EdrfAphkEPGZdbBfoMg2ND0/96bFrvdiEykJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+dUG+i6; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706106; x=1744242106;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hdbO220lILr52L7s/BnMy9HmMgaB5uaIsKRWFyINgZo=;
  b=T+dUG+i6E8JYN6JszRgfsvFzMLBAz1Du+JWC8Hhnw7ns+GMQkVd34Q0i
   vT/zD2nm6tD7cuDkWZGoNWKFXqvkRYDsn+bH7P5WhWeBnJkQ+rpRQ7DvU
   2CniDG3JhIq8YVP45/yqZmx7nDJuZ7tQ7vTYjlhkAHzPj5y97xPI/twRw
   qygjRRcinoj/3GKxAPsdK1+7JsA1rtAO00BWMP+dol6qYwCnYin3hEIZo
   3c/j55/1k64msH/CqSdigFmY4pf8eeepPJjrYk3HNkjikNuND95AGvNtN
   iTt1pzKkEgjwctEYLpsbOlfDwyOv10URErOdplH5uteYeOHDBQOzzVWG7
   Q==;
X-CSE-ConnectionGUID: sdTZRbCkRjSQmqx5RWsP4Q==
X-CSE-MsgGUID: QWzNbqwMShO6b8R3+PIR/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18656856"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18656856"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:45 -0700
X-CSE-ConnectionGUID: HQ8DFZdsRHOCbUDyfPphlQ==
X-CSE-MsgGUID: ij9K8v5BSM+WK6bBAS71Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20448239"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 16:41:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:41:43 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:41:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 16:41:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 16:41:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HX+SlSTv0OId2qKILjSSrAc7un/+f8MEdZBRLLocWebjoi5+WkQFBVw9UFlkuFmh90uXNs8fPakLE5Ou+yx5mW5DXaSWEncuzl/sPHnCvJneHhCuPejYSk5vrCT2rtAxEd5uFtwVz+owPzO4AOsFohk6XQUew3xVEYUny14EsnfNXBTUG2wfeLKK07FO+pl+2WdbZ5mCjA1MvV7hFw3og6l6nGDn2tskpXCyccnkLZaFFa4E8XFS3n2QOeoRs1ygSc5Fno+8nmcZXfsqzDs+BaseFH5iJXhKlkBvYvKkq/PSRZhdKxi7y9Tbw1a+Cn27zZn27vcKXrkdbvVFblNfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9b2sSMTJfZFEiCfe0mGCsPg7LAzbO9W3wAbP+G7MoE=;
 b=PPxsYbk2TSjNkr94oDUESvs/M4RpKkcre5jVQcmaM5FLtXYB6+S9OQILR0bjGV36UQ6TIqoPh3bk5TvT/l7r9gy6htX+CrTMuF53AK4fy7PgbmbYrndkDWdT9Uqdz/yLITipXTqF++P1qU0FAGV3kOt9QSRiC2qvITRHxgD5CQ4IQ8GuzOshItfuvXmEVtxlILxMhps9MELT8zluEeKJJ/KhSzH1Z97lGWP9n0xgVY//oa66k306xqdj/vFA9Rz1DXZ7+uf8mLpybkYQMsZdpLou4Ttp4GIkDTVJr5EwKy32xjUEWv/bv/28Ho3683uljRdBo3nVzSEkVjIe/dJskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6854.namprd11.prod.outlook.com (2603:10b6:510:22d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 23:41:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 23:41:40 +0000
Message-ID: <696b83f7-4c22-45d0-9655-f7bfa6d6e334@intel.com>
Date: Tue, 9 Apr 2024 16:41:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/7] bnxt_en: Utilize ulp client resources if
 RoCE is not registered
To: Michael Chan <michael.chan@broadcom.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>
References: <20240409215431.41424-1-michael.chan@broadcom.com>
 <20240409215431.41424-7-michael.chan@broadcom.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240409215431.41424-7-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:303:6b::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6854:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l10T8k4hiL1Gj/yaRijNM9V6vQz+KRPUcgqSQrfTpZaR5lbinZVtr04wwCqM+OzLOyUp2Ha3Pzqx0f64m4FLilZz8WjzMBChtATfZ/Zve0LESYXxTjE82RtlYWvHKEEVAQoOGdWtCoRYVVyNrO+AnFzh6kCMYzh942QoJW35Y/Oxs4gss2cx15uE/q9gSaLOFNMLlbIGVz75RS2ZM8rLVoCXlTiFSrfQ/0b3oHZYthxrpjo5Epb2nvysKJ4L2LfjGVRrQYHSbf5A8lkm5TYu8UNrq57G6f8LQxIang2Fj4qS5UZnAktGDKgcoR+yGeX4IlCbdEeC2KBPaX3WmQS8AYsmMBh1T/eOWWymI5zf3y2ToHts+4IBVBKLn2yScwPUUn7OdZianiRgo6mDuKL0eYcZBlMhNMdLZsVfP96f/391bwXPPXev1OwP4RXqG+LUrWu6JOTijFfVq0t/gmH7Pse1jP9znMExaH39cDk+2TRm1KnCq7ke4afNeivCnM/xwoLHev3tBkyxQG5xwj9txon75EuOXx9ceveanbKrjSxn6TZB1d8LTUTCiCTTFAvr/wrtKC8czm/46PmKPcFXCHbFShDJtruTY64dxvKtNneurI+zby7GKE3QRKa3zO8mAMpAQjwGJ1igwyKtbRIriSYw8m07XVWKk+ZImFpoiQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGtxd0s3WW1OVXJsb1NyRVlkb00va2FFRC9Ic0x2QTVIN2FEeDdwY1ViTmhl?=
 =?utf-8?B?bkROc0R0N1diOGFPbG1NdmRWUDM4U1JwUnV1V2g5Y2VFcVVjSUNvbEtsdzdx?=
 =?utf-8?B?MFUwbGMzMzRCc0s0cTVMMUlWU050ajF0MG9oOElHQm5VNHdlbStnc0ZZalQx?=
 =?utf-8?B?SGxJM3FlM0M3WVNvSTh5UHBwdm5EQVdNQWhVM0JPY2JVVDdaS20zVEEzb3ZS?=
 =?utf-8?B?dC9VeU1LZ1liYlBDOFdUWGNWTzhMM2d5NHBZaW5qWXZwTlhqRE5MdWlPSGZo?=
 =?utf-8?B?QndNTEZVZVRDNjhFTkZTdXRTYzBQSjdkQXBTcThTMWVQMGpmeXZLS0xRbmJr?=
 =?utf-8?B?a05yTnBUbDlzYm9hanFicFo2MDJaQ3YvMXo0Y0hkQmFHRjVYSDZPZGxqT0JB?=
 =?utf-8?B?MThvMGpoSmE5TW1ycEVBdk9nUlIrYjRSeWZtaXlJc2dSdktsSTVzVnAvRkhP?=
 =?utf-8?B?RXQxWjBuUXBZZ3RCNTJKc29ZTjdBaDR1MUpIUjlITlRGazZXMXlwN0Y2NnMy?=
 =?utf-8?B?Qk15QWFkZTFITzU0b0pkTHgzVG5mZUlTOFpybVBrRmlsVURMMHVLMGVoK0xa?=
 =?utf-8?B?Y29xSXEybHNtZU94ZDRJNzdyRFJEQVNJQzNXQ0JrcDhPN01qZWdDT0FnZXlG?=
 =?utf-8?B?dSs4Y0o4bWhZbzZsYU9CSWJaMisvcUVQWkNwTDA2a2dFMWV5VjI0b0dmaGQw?=
 =?utf-8?B?cGNTUWZ0d09BZmhYcGZIS0wvbUV5ZnhRaFMyU21QUXVJR2VSZzBER3BMcHUy?=
 =?utf-8?B?Nkxacm5OdUxlVnpCL2NKa09TTjRibURObk52dzQ1cXRvREZVWGp0V0tvUlRy?=
 =?utf-8?B?YW10bmFQVTZvdVljVzV6Rm1GYTE1NHFoVEExTDEzYjFZdXZUeEdLQnEya2tF?=
 =?utf-8?B?Q0VjV1FQbXpPdTFFdnZUcmZjajRwbjVYOWpIUXZVZ09qRys2WVZDaW9aQm9W?=
 =?utf-8?B?SG9QN1hGbXVnZ0E3UGtIMVI4eFNaNlBQb3RqVmU1Y0xwQjViODBObFlFemsv?=
 =?utf-8?B?azVXSWlld2t1RitJZ2l0Q1Fhc0Z2MkY2VFgyN20yQWNjQUQ1Z1ZCQlZpNkxh?=
 =?utf-8?B?VWFoWkw4NHkyQ1QxeFEwOHRYVEFWbEIwNHVUblJZMGl0WUhjeC85T25hZTFO?=
 =?utf-8?B?NHVnVFZIY0VtR005MmdrMUlHTmRmNmM5eGE0M2VMeDlpTnRRejhQSlVBQnFD?=
 =?utf-8?B?YzY4Zm5xVjI2MXN4Vk5KTDA1SlFRcWlsbjk5TC9tQjZ6eEZxTVh0TU95SzRv?=
 =?utf-8?B?bjJJZVNGTmtJdkhJNGYvTUZXc2JrdmdZdGFKeURPWGVTb0syWHJwZXgrdVF5?=
 =?utf-8?B?eUEwdHkrUXpPSzBjWVc5a0dEWHlqMWNpWWs1ZWQyOW84dkYyTnZHaDMwS2Zz?=
 =?utf-8?B?MEVhbVdNVkZGL2ZLcDlrQW9pUlc5cXpLY2JBQ3U2ZkprdjMzMjFzTjYxcGxy?=
 =?utf-8?B?NVZhL2J1Ny80MVVJZXVvOUZSZVNOMUU4dEg2eU1lcnJ6MmZTUmw0RmU4TE5F?=
 =?utf-8?B?cDBBWEx1blc2SjB2RVJxenhxN0k0UDROM3pXM3kxZXFBQjJLQndDSmd3QndX?=
 =?utf-8?B?dTMvcThzZkU0QmxDT2hJWGRsRTN0LzhlQVUzeGU3VFJ2cUxSdktlNG5NSEFU?=
 =?utf-8?B?Nm8zbmRrOUJVdmhKWUNYaFhaTmt2Z0c1MFNHU1crczRsZTYxTCtMc1MrWDJp?=
 =?utf-8?B?UFJhbSs3R3FhQ1hKeldxQ1F1VkFybDMxQlMrYVNyVjcyVEdJZmpGdGYrZUdZ?=
 =?utf-8?B?YUs4cUtmS1JYb2d2M0h2eUhjN1NKUlNTb2tLZS81cVdmL3ZXZlVXU1NucUFE?=
 =?utf-8?B?eEJPSkZVazlJU2JGTnM5YzRrNkZPODJPZXJPc2tKckllS01oK3ZXa1lkbWxz?=
 =?utf-8?B?cE16VjZSc2VOdnF3WmpYbm1ROURFWkQ5d1lKb3JNd1JVVWluVXhDQWh3MWU1?=
 =?utf-8?B?TXdFaHBPQkpiZWY5QTN4Mmc1dWwwaVR5bHY4RXYzWWRLMkVYS3NsZjNob2lH?=
 =?utf-8?B?U1dYNUpWQkdOaDhQUnlLbTNEM0lUQWc4L2tWWmV2UmZFc0hCY1Z2enZJYUdU?=
 =?utf-8?B?QXA0K3kyYXlvTnBSYUI0TjdqUnJ1TitDR2tUVkZHbGIyLzJuRk1nYkFEUjFN?=
 =?utf-8?B?cTZ6ekFpVEJ5c2Foa2gyR1JHMGVGbW5GbnFpMHlLT3UyNnQ5bjF5cExtbDll?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b94336d6-8ea8-4fe7-1563-08dc58ee9aa9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:41:40.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0YI7GO8h/IM/u38xOpXZAZ6v0f40zA7yYp6fuJVTlShvsm10m0VF3Hda/Enf0HNSA+YAn9EYLT1W80nj6V7yvhNud/hc65kRExfBjf5eS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6854
X-OriginatorOrg: intel.com



On 4/9/2024 2:54 PM, Michael Chan wrote:
> From: Vikas Gupta <vikas.gupta@broadcom.com>
> 
> If the RoCE driver is not registered for a RoCE capable device, add
> flexibility to use the RoCE resources (MSIX/NQs) for L2 purposes,
> such as additional rings configured by the user or for XDP.
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 41 +++++++++++++++----
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 14 +++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  2 +
>  3 files changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 88cf8f47e071..a2e21fe64ab9 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -7470,14 +7470,27 @@ static bool bnxt_rings_ok(struct bnxt *bp, struct bnxt_hw_rings *hwr)
>  static int __bnxt_reserve_rings(struct bnxt *bp)
>  {
>  	struct bnxt_hw_rings hwr = {0};
> +	int cp = bp->cp_nr_rings;
>  	int rx_rings, rc;
> +	int ulp_msix = 0;
>  	bool sh = false;
>  	int tx_cp;
>  
>  	if (!bnxt_need_reserve_rings(bp))
>  		return 0;
>  
> -	hwr.cp = bnxt_nq_rings_in_use(bp);
> +	if (!bnxt_ulp_registered(bp->edev)) {
> +		ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
> +		if (!ulp_msix)
> +			bnxt_set_ulp_stat_ctxs(bp, 0);
> +
> +		if (ulp_msix > bp->ulp_num_msix_want)
> +			ulp_msix = bp->ulp_num_msix_want;
> +		hwr.cp = cp + ulp_msix;
> +	} else {
> +		hwr.cp = bnxt_nq_rings_in_use(bp);
> +	}
> +
>  	hwr.tx = bp->tx_nr_rings;
>  	hwr.rx = bp->rx_nr_rings;
>  	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
> @@ -7550,12 +7563,11 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
>  		bnxt_set_dflt_rss_indir_tbl(bp, NULL);
>  
>  	if (!bnxt_ulp_registered(bp->edev) && BNXT_NEW_RM(bp)) {
> -		int resv_msix, resv_ctx, ulp_msix, ulp_ctxs;
> +		int resv_msix, resv_ctx, ulp_ctxs;
>  		struct bnxt_hw_resc *hw_resc;
>  
>  		hw_resc = &bp->hw_resc;
>  		resv_msix = hw_resc->resv_irqs - bp->cp_nr_rings;
> -		ulp_msix = bnxt_get_ulp_msix_num(bp);
>  		ulp_msix = min_t(int, resv_msix, ulp_msix);
>  		bnxt_set_ulp_msix_num(bp, ulp_msix);
>  		resv_ctx = hw_resc->resv_stat_ctxs  - bp->cp_nr_rings;
> @@ -10609,13 +10621,23 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  {
>  	bool irq_cleared = false;
>  	int tcs = bp->num_tc;
> +	int irqs_required;
>  	int rc;
>  
>  	if (!bnxt_need_reserve_rings(bp))
>  		return 0;
>  
> -	if (irq_re_init && BNXT_NEW_RM(bp) &&
> -	    bnxt_get_num_msix(bp) != bp->total_irqs) {
> +	if (!bnxt_ulp_registered(bp->edev)) {
> +		int ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
> +
> +		if (ulp_msix > bp->ulp_num_msix_want)
> +			ulp_msix = bp->ulp_num_msix_want;
> +		irqs_required = ulp_msix + bp->cp_nr_rings;
> +	} else {
> +		irqs_required = bnxt_get_num_msix(bp);
> +	}
> +
> +	if (irq_re_init && BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs) {
>  		bnxt_ulp_irq_stop(bp);
>  		bnxt_clear_int_mode(bp);
>  		irq_cleared = true;
> @@ -13625,8 +13647,8 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
>  		return -ENOMEM;
>  	hwr.stat = hwr.cp;
>  	if (BNXT_NEW_RM(bp)) {
> -		hwr.cp += bnxt_get_ulp_msix_num(bp);
> -		hwr.stat += bnxt_get_ulp_stat_ctxs(bp);
> +		hwr.cp += bnxt_get_ulp_msix_num_in_use(bp);
> +		hwr.stat += bnxt_get_ulp_stat_ctxs_in_use(bp);
>  		hwr.grp = rx;
>  		hwr.rss_ctx = bnxt_get_total_rss_ctxs(bp, &hwr);
>  	}
> @@ -14899,8 +14921,9 @@ static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
>  	*max_rx = hw_resc->max_rx_rings;
>  	*max_cp = bnxt_get_max_func_cp_rings_for_en(bp);
>  	max_irq = min_t(int, bnxt_get_max_func_irqs(bp) -
> -			bnxt_get_ulp_msix_num(bp),
> -			hw_resc->max_stat_ctxs - bnxt_get_ulp_stat_ctxs(bp));
> +			bnxt_get_ulp_msix_num_in_use(bp),
> +			hw_resc->max_stat_ctxs -
> +			bnxt_get_ulp_stat_ctxs_in_use(bp));
>  	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
>  		*max_cp = min_t(int, *max_cp, max_irq);
>  	max_ring_grps = hw_resc->max_hw_ring_grps;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> index de2cb1d4cd98..edb10aebd095 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> @@ -61,6 +61,13 @@ void bnxt_set_ulp_msix_num(struct bnxt *bp, int num)
>  		bp->edev->ulp_num_msix_vec = num;
>  }
>  
> +int bnxt_get_ulp_msix_num_in_use(struct bnxt *bp)
> +{
> +	if (bnxt_ulp_registered(bp->edev))
> +		return bp->edev->ulp_num_msix_vec;
> +	return 0;
> +}
> +
>  int bnxt_get_ulp_stat_ctxs(struct bnxt *bp)
>  {
>  	if (bp->edev)
> @@ -74,6 +81,13 @@ void bnxt_set_ulp_stat_ctxs(struct bnxt *bp, int num_ulp_ctx)
>  		bp->edev->ulp_num_ctxs = num_ulp_ctx;
>  }
>  
> +int bnxt_get_ulp_stat_ctxs_in_use(struct bnxt *bp)
> +{
> +	if (bnxt_ulp_registered(bp->edev))
> +		return bp->edev->ulp_num_ctxs;
> +	return 0;
> +}
> +
>  void bnxt_set_dflt_ulp_stat_ctxs(struct bnxt *bp)
>  {
>  	if (bp->edev) {
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
> index 04ce3328e66f..b86baf901a5d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
> @@ -98,9 +98,11 @@ static inline bool bnxt_ulp_registered(struct bnxt_en_dev *edev)
>  }
>  
>  int bnxt_get_ulp_msix_num(struct bnxt *bp);
> +int bnxt_get_ulp_msix_num_in_use(struct bnxt *bp);
>  void bnxt_set_ulp_msix_num(struct bnxt *bp, int num);
>  int bnxt_get_ulp_stat_ctxs(struct bnxt *bp);
>  void bnxt_set_ulp_stat_ctxs(struct bnxt *bp, int num_ctxs);
> +int bnxt_get_ulp_stat_ctxs_in_use(struct bnxt *bp);
>  void bnxt_set_dflt_ulp_stat_ctxs(struct bnxt *bp);
>  void bnxt_ulp_stop(struct bnxt *bp);
>  void bnxt_ulp_start(struct bnxt *bp, int err);

