Return-Path: <netdev+bounces-228298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50A9BC6D83
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 01:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A56E405744
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 23:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3225F994;
	Wed,  8 Oct 2025 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdxmnjJB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBB23B63E
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759965454; cv=fail; b=OO0XM6Ecx0nCEqDfPKzrEdGqZm8kkN7Ptc7SqviM6KufrrlfX9VGp7V2i+62fzAck31gm8Whk9Ms6Pj1jX4thFa5xVUkz3RtqQoJn40Tylw3NL+uh0JxSlK/HxS5vglcL4Mfi7iiFOHjmKuZF6BmOckPyjSc0rkTie/g5dyjpRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759965454; c=relaxed/simple;
	bh=iGSvGB3+cVEUaAO+2zKh+eiJke66XlZb6bCukECq2kU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sJxbwZxW2icdijkv8bGgjSPoq4i02ALbfdQS/e49EQlvoumoscoW70yAcPAwTdS+3HbREJAzn2agh+Y8mM7fij8eJTM1DYoBkO2O4gEwyLmxllVLjjLIEqGpwb21cTtH39FPKMZj6QXjhTc8Gb6ObeuCDa2T+UpPYoiytalzmsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdxmnjJB; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759965453; x=1791501453;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=iGSvGB3+cVEUaAO+2zKh+eiJke66XlZb6bCukECq2kU=;
  b=fdxmnjJBPDbSMx9D0AJnpZT9klXEcWq9w0Vw//aZctwJLIRrowIEFfp0
   8jgwJoUTAooiXtc8CLmVAB+K8c8X6xxN8HdrFmH0EbLpsDNmtn6NYNE20
   CMU8zTquMnjF/er71bV+9ZYblCTBqArEFO6RC+uBcHYyEQYnxbbPLBMEx
   Ylw//W+K8TfLx5uceXG93gcZP0f3FMKOFwwSwzJWUnb2Iy5BVNxz+fPT5
   XhfEQhwu30gjKGVQUtGIIrw9rRVJg9MquurWmn3mx1gff0d2PcfZUDXRa
   KfOy1oiNSOjWxfW6bhKoVsIE/hK1Mqr7f9egUtHf5b6Sd/4sY3ADHfx4e
   g==;
X-CSE-ConnectionGUID: GjU6pLdnTIeAg2Dv1FN27g==
X-CSE-MsgGUID: EPQh3uu9R6iE/8yh0qPptw==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="73517383"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="73517383"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:17:32 -0700
X-CSE-ConnectionGUID: LK3h7TcxRV2CxJQHB58bbA==
X-CSE-MsgGUID: WSYBYV7iQfWttWNKTGRcRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="204275651"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:17:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:17:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 16:17:32 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:17:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWcQGLQV0Yr3UVs4puk6BqzmnbT6bBgd81aVynKBkm9NPggh6OSIW68naLrTSB3HXqAlOJqXNzMYBEDZYomxENmd6OgxDmXxfR1lkTWcTFun4zAGT8+Zm5q2qDWaAMUw/3M3ikIOxWO0LhDEq6ADm6lffQR6MynLNR7AcdbpowH9lXg1WhtISEuTKOSHhdSxdALR55pq0Q8qaoYbWehPyrMKOFTzPd0wWdWJF6EvO8vqD2KZse65sDFBsEOmwTevIsNrs6W/oTAYb6/vTepn7UdCcfo7++2L73tTSFN7DthVzp1upsCsfRZVK+8Jwy5+ZDVK1H6ddl/inGy3lkuy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oono6WTjGPBD6Adqa3emgDp16HFWHyiHpRlvSknNwhc=;
 b=GHFxkUJ+G7yDcrTKK5gMmiKbdMXSrHCvbuIFYQGiTFijGqzxQ2UvX0v1YAcPDAmt8bjBu53pUXXcmizKvSM+Bcs9DJchEjEEDb9+T44tuwVjq435a+wuTW78iODym37c9mgI1cyTUqAE838RDX8XYqcNw2DsKtawzaT4iC9sk11sirjo2Oo6P8MHtqSc+2lWAuVE7GVZNZYD2quNt4c5bridfuVCr24n/3wSpea2Muy7hQVaofZDcEKhDApbXuC2vMxseUYI4SsFLMr63B72Pw15HriwNIqVixPvWz9hZAAGsFkWOOhZE2O9Wv3FYixlpQcn2PN5t2zmJWlbJXKrYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DM6PR11MB4643.namprd11.prod.outlook.com (2603:10b6:5:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 23:17:25 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 23:17:25 +0000
Message-ID: <b2ee7a29-97f1-417b-9d32-c9dbdb02fff5@intel.com>
Date: Wed, 8 Oct 2025 16:17:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: airoha: Fix loopback mode configuration for
 GDM2 port
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>
References: <20251008-airoha-loopback-mode-fix-v2-1-045694fe7f60@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251008-airoha-loopback-mode-fix-v2-1-045694fe7f60@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------R7M20TKZNnok6T3ku9FNZyAz"
X-ClientProxiedBy: MW4PR04CA0331.namprd04.prod.outlook.com
 (2603:10b6:303:8a::6) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|DM6PR11MB4643:EE_
X-MS-Office365-Filtering-Correlation-Id: 197947ba-f689-44b2-3122-08de06c0d7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekRtMVFhbDdEeWVGRUxzbEJ4Zml2VENJUkxHaGZkZVh6Rmh6S3hWdmJOaTNt?=
 =?utf-8?B?L2JyZGhpZVEzVXd4L0xRNmxUTGw2ZXpNNk44bmgzdXFMRjU2TXFPSkFoelp0?=
 =?utf-8?B?YUZDdEtqRjBDRHdXL3U1WmZkWFd1VHJuZU5lQkcwU2NKZzVnaXNJWVkwcG1m?=
 =?utf-8?B?dmJST2NHaGxkZkhVR1UzeGhIVVdOZ3B6VVhKeEUrOWNOckY5OVh6ZXZ6UXpC?=
 =?utf-8?B?WUVJb0Q2UGNKZWNwN1FrQXB2MldPOWpnRDVTNmdaWXc0NmdTQTZ3d05NNXl2?=
 =?utf-8?B?S2FpN00wV0lsUzEweFBPTGs5SHFNSzUvL3lpeTVIUVFxeXY1T0hEOUE1Tld4?=
 =?utf-8?B?cTZvcEYvZjMxTjJMNzc4Y0ZRVStLZWpKMUVaL1IxelFYU1ZCdUI0blpLNWVo?=
 =?utf-8?B?Rk5kNHpNSCt3dk4xZkdNcjJWWkhCR0J4YVQzc3ZFUDlIOHJESGZ0ZEUxaXRp?=
 =?utf-8?B?SnFweDVJVGlhOHdKU2Z5S1I3NTdsUVBpOXcxQ09nNUphVmUzTUhuSEZSK2JZ?=
 =?utf-8?B?ZTBWanAzWEZFa2JubHVBa1JlN2JRVVpvK1krOU8vS3hab3RIWHFrYk5Qbm1S?=
 =?utf-8?B?dktSdHNYVGlmaUdCaU5aR0IvRExrMDA4QnE2VDU0VUR5RVpJUkNLL3ZiTFF2?=
 =?utf-8?B?WHh0UlhQNlRZeURjd1VQM3ROc1hGNWpLNkQyeTVBVFNNZXBqdlJsR2VIbXor?=
 =?utf-8?B?MEFNWEUxZzdaUmM5bUtwVlk2a0xHYUVRNE1LM2JiV1pNY0UyMDFEeUZZYmwz?=
 =?utf-8?B?Mk53d0poKytkSHZibjZVc3VtQjk1T3pUUWF5UWxxbjVsN0xmVlluTmFONkJC?=
 =?utf-8?B?bGR1Ny9MSm9jZno1QjkzSStkQ3Qwam1SWUhDUFBidXhwYW55aXl3QTQ2VUNH?=
 =?utf-8?B?NDYxVXI2UVBzd29UK3BaTDlkLzdMRlhvSWNnR2lvRDl3YVVhWFVad1VuZ1BK?=
 =?utf-8?B?VElxeDF6cDdyZk8zWnVXNlFzdTV3anFYcUQ0ZTZBL0JMOGprNFlUYmJtcjIr?=
 =?utf-8?B?OXVMMmJVN09yeEZiMGdlUHl2U25hQ2VURnVHdi9lVnVqZGRNOU5HM2xpQWFQ?=
 =?utf-8?B?UnM2Z3BWVE4rY0krRVZOTExjZ2Y1NStuZW1hSXorMUlXNkhqTHZlb1RFa3Mr?=
 =?utf-8?B?Mjdmc2pRSTZ3VHBkd3EwdTE2bDViUGVNMEdEcGdhcm1iK0xFOU96RCtPV2FB?=
 =?utf-8?B?eWxiZitnRkY1ekFQWnZYRWpsNlA1SkxDMG1FMkU4bFdrcEUvT1BubkNWQTJY?=
 =?utf-8?B?c2lVbEUyY0J6MldWSHNaeDlqek1kS09QT0lmSnVJdlg5Q01NN1VLUktkZ0xV?=
 =?utf-8?B?bURwT1BmVTZYNGgvZjNiQURIUmNBbXZSRGJqWldHZXkveVlCNE1aQzJaSUdw?=
 =?utf-8?B?Q2V2L2dYdnlZeG1VdC85WDFSZ2pKZFhCNkpJSTBQQUs1RStxWHdwSXZVV3dY?=
 =?utf-8?B?SnZWNGlpeHRERVcwQ3hYS2xLS1A5SGc1MXpNdkFFRm9CUGNDMEVBQkRQbEhJ?=
 =?utf-8?B?YlZBRlJJNW5UMGwyVGFySTlnNTc5RUxFRjJyaFJVSkZKSGgwQUtXRVp0amFU?=
 =?utf-8?B?emZkaHRQMDZYS1FkMzdrSnk4N0J5eHg3Q3N2VmJVQUpncHpGYWhDNzJLQ0Nh?=
 =?utf-8?B?VjNDZzFOSGU1dHk4TWhBSGpGeXhTeG5FaWp2SkRBbGE1dHVzZGlqZTVhRFU4?=
 =?utf-8?B?Qk82NThKK2NGS0R4ZUh0bENvQ0VGbFlsTWJVcDNmaWJJODF6eUppNzVlZG5W?=
 =?utf-8?B?V2pkdlFRckltOTlURjZqdktiZ09hUFRjK1lvV0h1VGZjeUI0azRnNzkvdWFL?=
 =?utf-8?B?cW91TllZZVpKWEFUaWNBU29QcFRFK2ZRVytHYXFQYjhZdngrVU1YWWRIK3Yx?=
 =?utf-8?B?NDBjQmdCWXVuVkNmWGZkL3M3NjdKb29qclMxVGhUc25RRGZxYkp6NGQxbUR3?=
 =?utf-8?Q?f6h07zBSROWkEnZ6G9QthQjHTmBT3qSE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3g1UHJiME5IV1ZsWDBhYUVYZktmSHBja1hLTWd5N2RmWTJKOTY5RE01YUJo?=
 =?utf-8?B?eUdOOHROOWlFTEFCRlJjNnlib2VXZmVpb25PQmZvZkdTTGhNdjBBZkJRWkV5?=
 =?utf-8?B?RWlGTGV2UkdwSGU4RVE4aU5qY2YxSWRQbjNaNDU3RXpzaXBMcDk5UHJNK3Fh?=
 =?utf-8?B?VWg2cEJVSm4vUkdvZkpJUVFNVVdlZFNhVURpb3FhdWhiUWdlZWRGM2VkdXkz?=
 =?utf-8?B?cFpUVlVkKzRXUE43MDFLV0FaMXBObkIwTWluQTV0ckRoSWlKaXdTaVI1UFlY?=
 =?utf-8?B?SDhHMEJRMnZ0bzVQeVBYZ09mQ081RWVnb2hLNTA0Z1N0M2tGM1pzb1hoMVV2?=
 =?utf-8?B?c2dMcEM5bWRUMS9FQWdCQmFLN3lKQk5PMHpsMlhjTHk0ZzZ6Ykl6eHBXZDJk?=
 =?utf-8?B?OXhETzl0SkJiZVRiczJ5bEEwbTd1d3lnVkpOd0t2R1BEd3Z5K3lLUnpWdWdI?=
 =?utf-8?B?RDdNSDNJVDRvOExna21wQkJzWXc1ZGdKMHJFOXhDNllmOUpDQXRFZlZiNlJq?=
 =?utf-8?B?UU4vYXE3RkJNNjVQbTdqekFITHpuYTNSMWVVekhIblJubXdkV1I0YVZONjM2?=
 =?utf-8?B?M0dLbWtGREpvUkJZdUoyRzdwSkUvOTVObzdWZG8wbXdiaDN6a3c3NklKV0FO?=
 =?utf-8?B?Tk1mbEFQYkYrU3hZSkx3K1EySlBTUmhOL2hPQmxPMXhGTFo3SnNvQks0U1U5?=
 =?utf-8?B?ZzAvQlhtaTJSUEhHMG0zSWRSMzJiTnZuM09xQjJrL1FjQUtqOHdZSzVWYmdr?=
 =?utf-8?B?ZHg2UXVwc2lBNmd3TTdwMkRKdng4SE5YN0o2aDNubHdYQzkyMy9EcEtPWUkz?=
 =?utf-8?B?VUIzRHhMcG14L2VjeTYvTGg1Mm1wd3ZsRHNJVy9VZ3RYTGptT3BDTHRHZlkz?=
 =?utf-8?B?dHBPSmNYYnRVUnZXVzNDd0pGZ0w5ODhXeE9GV3Q4bHpKMm5taURuM0oyam9v?=
 =?utf-8?B?STBULytvR0x2akxNWUh2VWdneW5nWmtYdnBxangwU3BxcDFEV211RnI4cTdH?=
 =?utf-8?B?ZkRjNEtsRUp5bXIrcjNUaWlzM2tyZmg0UklqSjY2WDBocUNDSlExcnFmM3Zu?=
 =?utf-8?B?Rmh3T2t0TDNyQkl3WFhlZHJyd25KZzVlZ2d5RUdZVlI3ZkZzTFVBa0lJRTBH?=
 =?utf-8?B?RXM4ZmRwcmRCTTIwMFlyaGxjLzNCTVpVLzRoK2FTWlNLTVBnYStQdEZsaE9C?=
 =?utf-8?B?YlJOUXROVFdXZ1J2UDd0VEZOYzVzekRwYlZwRkQ2MWxaSVNYSGhUSTdNY05z?=
 =?utf-8?B?SUJSU05tQTk5ZnBrNmJhWjZDQUwzKzJDKy93aXh3K0c0VzAvQ2lNMUNuOTBJ?=
 =?utf-8?B?VDBJVStZdjJiWXg0K3grRVRjdnJjYjhUM1IzRmVXcVFYb1RPdGllRHkrK1Q1?=
 =?utf-8?B?VC9RM3Y5ZkQ3UzNNM3pHam54NnM0UXZya29HaU1Bd0M0MW9hZ2pSUWFpTEhp?=
 =?utf-8?B?ZTRUaHQyaXpKNU1DcHpPZ1orMmRYL3llRjJ0MkExcU9jZ2pMSlRjQnFRZUhU?=
 =?utf-8?B?N3NtSGhSTjRYYmVPYVNCMy81NnBNVWg1WlVkbGZjbldURU1RV2VPY3dNRWd0?=
 =?utf-8?B?VE5WbXBJRzg5RXdoRFNRWWJITzhGclJKSmdtZmNnQkNFNU9raytJaGJkLytB?=
 =?utf-8?B?TEEwUzBBdnA2SFVzTERSTVluOUhiWHVJUGk0c3F2UjVMUURSSFZwZ3l3S2F5?=
 =?utf-8?B?Q0dsZ3M2L3JOQ2U4ZmNxSURmOG5WQUROdWRvTTRGM3RDVUVwV0x2TEx0K3BR?=
 =?utf-8?B?anR3eGNrbjViMXRLTEdOcGlMZHlIRHU4UnhMdkF2eUZPMWJnQ2FRM2dwV0t5?=
 =?utf-8?B?UXVVOXFETXpHOUZmbktMYzE0RFl5N1djenFiK01jcHN6ZW5DRmJFUy9NdW1u?=
 =?utf-8?B?ZFhxYU1yZlhwUlNCMk9Ga1dVd1pKc1NjK05jZlo4dkdrQWczMFpNK0NCZ2VF?=
 =?utf-8?B?VS9OWlJjRHpZbEgySjdSNnJtTTJ4TnBENEpPelhTdFhjS3hlNHp0RHBxcnBq?=
 =?utf-8?B?QjBpd2R4VnpsMHVQN3RRWnVxWm1PbkkrKzNHR0xndmdnbGJJWjJjZjI2ODdr?=
 =?utf-8?B?TDArZXdPWit4dG9zdXlPMHhPenBadnhXdm5Ta0Z3MFdtNzQxUTB0TVVUbmlW?=
 =?utf-8?B?RFRYcytBTUk4bkxVSk13bUdGc25rVDRiT3pWV2VUWEMyM2hmZTFMVmxsQUhD?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 197947ba-f689-44b2-3122-08de06c0d7a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 23:17:25.6639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0pCx+JHgBVandUxqWo+ix2EPBkN3UVVuSPP14vVXf3e3MLlN0YJIPRA3pQZpbie/3xeovvdjVanFPrkFzOx6TS0jEwbEzUTKvO4wK5LzvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4643
X-OriginatorOrg: intel.com

--------------R7M20TKZNnok6T3ku9FNZyAz
Content-Type: multipart/mixed; boundary="------------f3JDRmJSkJv0mbma0y1ZUGAf";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Message-ID: <b2ee7a29-97f1-417b-9d32-c9dbdb02fff5@intel.com>
Subject: Re: [PATCH net v2] net: airoha: Fix loopback mode configuration for
 GDM2 port
References: <20251008-airoha-loopback-mode-fix-v2-1-045694fe7f60@kernel.org>
In-Reply-To: <20251008-airoha-loopback-mode-fix-v2-1-045694fe7f60@kernel.org>

--------------f3JDRmJSkJv0mbma0y1ZUGAf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/8/2025 2:27 AM, Lorenzo Bianconi wrote:
> Add missing configuration for loopback mode in airhoha_set_gdm2_loopbac=
k
> routine.
>=20
> Fixes: 9cd451d414f6e ("net: airoha: Add loopback support for GDM2")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Use human readable marcos to configure loopback mode register
> - Link to v1: https://lore.kernel.org/r/20251005-airoha-loopback-mode-f=
ix-v1-1-d017f78acf76@kernel.org
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/airoha/airoha_eth.c  | 4 +++-
>  drivers/net/ethernet/airoha/airoha_regs.h | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> index 81ea01a652b9c545c348ad6390af8be873a4997f..833dd911980b3f698bd7e5f=
9fd9e2ce131dd5222 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1710,7 +1710,9 @@ static void airhoha_set_gdm2_loopback(struct airo=
ha_gdm_port *port)
>  	airoha_fe_wr(eth, REG_GDM_RXCHN_EN(2), 0xffff);
>  	airoha_fe_rmw(eth, REG_GDM_LPBK_CFG(2),
>  		      LPBK_CHAN_MASK | LPBK_MODE_MASK | LPBK_EN_MASK,
> -		      FIELD_PREP(LPBK_CHAN_MASK, chan) | LPBK_EN_MASK);
> +		      FIELD_PREP(LPBK_CHAN_MASK, chan) |
> +		      LBK_GAP_MODE_MASK | LBK_LEN_MODE_MASK |
> +		      LBK_CHAN_MODE_MASK | LPBK_EN_MASK);
>  	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(2),
>  		      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
>  		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/et=
hernet/airoha/airoha_regs.h
> index e1c15c20be8e13197de743d9b590dc80058560a5..69c5a143db8c079be0a6ecf=
41081cd3f5048c090 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -151,6 +151,9 @@
>  #define LPBK_LEN_MASK			GENMASK(23, 10)
>  #define LPBK_CHAN_MASK			GENMASK(8, 4)
>  #define LPBK_MODE_MASK			GENMASK(3, 1)
> +#define LBK_GAP_MODE_MASK		BIT(3)
> +#define LBK_LEN_MODE_MASK		BIT(2)
> +#define LBK_CHAN_MODE_MASK		BIT(1)
>  #define LPBK_EN_MASK			BIT(0)
> =20
>  #define REG_GDM_TXCHN_EN(_n)		(GDM_BASE(_n) + 0x24)
>=20
> ---
> base-commit: 1b54b0756f051c11f5a5d0fbc1581e0b9a18e2bc
> change-id: 20251005-airoha-loopback-mode-fix-3a9c0036017e
>=20
> Best regards,


--------------f3JDRmJSkJv0mbma0y1ZUGAf--

--------------R7M20TKZNnok6T3ku9FNZyAz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaObw/gUDAAAAAAAKCRBqll0+bw8o6Oyv
AP9ABf4e854QmwiK47nm0m5GxPgNSOcIqg/wCK4f5xHd7gD+K/Reod81c9QqmHFwW8q1seSqM6LR
zuGZFn5pSmddhww=
=uZyy
-----END PGP SIGNATURE-----

--------------R7M20TKZNnok6T3ku9FNZyAz--

