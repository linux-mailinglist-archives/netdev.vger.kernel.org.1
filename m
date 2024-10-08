Return-Path: <netdev+bounces-133212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47151995535
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21DC2866B8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172A433B5;
	Tue,  8 Oct 2024 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3FYu1om"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2737708
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406887; cv=fail; b=Qy58tnxJGUprnFSXhSDug+CR9NJ22Wq1tZCj8LX3t49gcjg74CaGWkzJg09o3b3HKSvkF7E06VVAl1Y77vTCW2Z9iDJQpl50OtY0kaIk+17GE8vrKR/8QWEOafMQOCZcdPB4u199YMOqoBj1RebYSoPv46XfRm4zU7/Ynf5cbsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406887; c=relaxed/simple;
	bh=PM27B6g5VQ32JWHC8jvB8K5LJuyTLZKPdL/g6H37tL0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cwDUiQ64xnpK9qT/ix29s5vJtK+FwRNt+ftuQEnFlkbwo1FO3T2rjUATxaHu+JBrrMO42pf7zMS0c5xx8uKJvBWT3L20LsImp8iq5jrXACqouM80uXLVb6E83thn0gW/1L9KpNLu6PXnDJCRaNZEZgY3sUhvEHj1G/PzrsHr+tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3FYu1om; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728406885; x=1759942885;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PM27B6g5VQ32JWHC8jvB8K5LJuyTLZKPdL/g6H37tL0=;
  b=N3FYu1omIwD8AMxpB3WBaBGZWt/HRSaY4ffZ+tKmVe5TcTMPMfT7rwe7
   vOHU+dnH/IeirKtXWQXj//nIoheRw4SKknlR6lE5q+5bouexQ8DAkH1o4
   bo4rEZjQ6y0qsmrqgW5mD7uBsuoVbOm8EsjR94oqIe3Kw1apX4rjbh0Lv
   B5Qm7PtfuraJvNUCvLdYY7IEOS6z4uVBLGOo1//P3T93z52l6dS4u98EA
   5UfzrD/BCF2+YOc6jr6BV0Ntw9+Hyn9BzGHlQkYw3EtxdpZ31Vwt1+pzK
   CnO0RN+bIQSOixMrCjFkw1Xm46zrQxMbcrH5n2oGFSTuLPLSkS560R5tf
   g==;
X-CSE-ConnectionGUID: FF7dPcUhRjqtDzorQvZWtg==
X-CSE-MsgGUID: 02FrLmRBR52DDwcaowDd7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27503396"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27503396"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:01:18 -0700
X-CSE-ConnectionGUID: uD7+VTPjSVq1BY/ObnpezQ==
X-CSE-MsgGUID: b3ayOyz+SNC9UZ9JE6NzDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="76016593"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 10:01:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 10:01:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 10:01:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 10:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mP1dYLjWXcWtZJwp7UftNEdjQL6ioRVttPTGS2au1sXDPZdo2xB4beHW4kGbFaWh540y+TBTAOHTbhghmIKj0P7uhQ5F+7SBd3PxkZ5a0hJY7EaxjLGxJHvQGm8Qbt/Qk/D8s/aAHrsNK/k1UB9FXYFeYSiOGnZbu+v+5TOyazjqV8Api3F8ciI9A8kCDeXgsJPsbgc/FbBpQXRcuLh41fxiEMS8fCQk1skJ2DF4L0BQuqOasiGAkocfjvMafa4UF/ZQqFS7IYgI3Gw0J+AJTe9T5/1IMhEA7nCkEtzahFJ2gDOvLS2fz+eU3LHucksBh8SBHJ2n2PfMkBxrUXTIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t0c9Gl+I6Y/Yx3TwlEGgW5Um3Z9egFK4V4pEs7kxFQ=;
 b=RUJ/vlGvwlHqSYvKEVypqUB8VQjNppqIyvQQD9aHqAjpGdBNs0YEK1Ew5i+W9s4k15qK9vO+csKhmMIbPsPXW/XD4wCFDAFennDQqcbOdnEDkwTAyYs/ckv5Qi1gJo4/zTv4/YjGhVg7OQ4HfbHbg2VX/h3ZcddXVAj01SBLxVGsD7XshvrnewIfl+YwskzywlqUVEbi+aCY2wunDITNh4pjX47xQoBF0NbVYJPB5J1xgXS0KUidReGfOcgCfhwLOa6bb4mtg/VDLu7VFOgeUZ8ZtOLbOg8RX8bS2cu4x0L5/9HP04aDRuwL7nAGGsNYR/MKNpyD9fPqNE7r17/tgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6975.namprd11.prod.outlook.com (2603:10b6:510:224::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 17:01:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 17:01:11 +0000
Message-ID: <89b40200-34b5-4c94-9e5a-2a6626d44477@intel.com>
Date: Tue, 8 Oct 2024 10:01:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] eth: fbnic: add RX packets timestamping
 support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vadim Fedorenko
	<vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>, David Ahern
	<dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Alexander Duyck <alexanderduyck@fb.com>
CC: <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-4-vadfed@meta.com>
 <a64b3bfd-8a85-4523-aad8-e4b534448a0b@intel.com>
 <09283978-f414-4c77-b48e-f5586fa67edf@linux.dev>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <09283978-f414-4c77-b48e-f5586fa67edf@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f2972b-7b12-4b6f-fea2-08dce7bacf74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFBlUzhRVm5NYlFva3RyT3pYbzVhUFN2eVA0Z3c3OFUvdXVpRnVCYUhvUU9O?=
 =?utf-8?B?S2xCWDVueXB3SkEwNnNWZWZnWllZYzg5UlZrTjhIZXgxSXNhZi9xcy8vQVZ2?=
 =?utf-8?B?MEd1dnpJNUlKK2xnQ25WSXN2TWo5TU5naktSN1BVazRIWi9jZmpiNmxLZjNY?=
 =?utf-8?B?c3FxMVZMNU82bHkyU3c1ckk0Y3VWdE1iM1dCeG9VZVlCY3U3UUJlbitXM2w3?=
 =?utf-8?B?aWRxZisxb09GQXN0dmlwcW9US3JWY256MGhsSnlSdUxNbXFWNmRlalJMOUZk?=
 =?utf-8?B?azg0bFJPU0licm5aRnlOaEppSnl0d1d4dE13N0JTUWhwUCtmVHpVUEdQekZj?=
 =?utf-8?B?UXhJNXd2b1o5T2dTRVRYUC9NeWs3UHNVWnY2UG9EYlRHdWltRW9KNFlSaFg0?=
 =?utf-8?B?MEk4UUx1NDBOUW5rS2N3VUdZWDU4OCtGRmJjcWpMb0ZDL2VQS29YREV5WEkv?=
 =?utf-8?B?aEZuY3QvUlovbG0xTDJTODJ6c0V2ck9CTlM2ci9nMUFJYXNCUzRDZEo0YjZq?=
 =?utf-8?B?YlFXY2paOFpyQlVRRkpFbkg1bTlEMkZWc0Yxb3RzSFViSVVna25FdjBYWVRk?=
 =?utf-8?B?dmJPVUxhOXIzRW1zWUZBOWQ5MkNWQjJ0dStab3ZlMlZHV0N2WG04QlJqWFdN?=
 =?utf-8?B?VllJZ0pGUS9JY1lGa1VwSlRnbVhRdWNsTnY4ZTVLWTVTMVVhRmhMYythazR4?=
 =?utf-8?B?b0hGYzlhRmpudktpTlI3akNWeHFBbVdxK0YySVJSaFh1cjF2ampEZG40VXh0?=
 =?utf-8?B?cTd1NVQ4Q1ZMdHNOZ1RJbDlHMFYzdGQrR2ZrWFI4dVI3SWl1aGhNbk5ZR0la?=
 =?utf-8?B?VVBaa2twL1RNaUNFS0tXcHg3Sm5Wa0t1bGJHWjBWVHlZOHJ1eFg5ZlZCN1Ji?=
 =?utf-8?B?MXo2aVh5dVU4dmczdzhodURNRm9YM2x0aVNDaGhkd0laQm1tWVc4SFVrQmhx?=
 =?utf-8?B?UnM3clYrc0I3QmdQM1dwSVpVTC9GMnI1SEZ6T3hlQnFGaDVLZG80bmQvcEQw?=
 =?utf-8?B?MzQ4a2Z3WmxqTExuSGhiQk1jTzNpQ0N3VTVjaWpsbG5CZElSR0RjZngwbWQv?=
 =?utf-8?B?R2tsZ3QzOW5LMm5uU01pU3ZCajBEOEs2TG9GT3pkUnFscGpKZS9DUXlHb29U?=
 =?utf-8?B?akFyR3dtN2dLa2o0R3F0UU94YjlEYzBaQW85R0Z5dVVZVGxUZExtMzRMU2ky?=
 =?utf-8?B?UXV3ZFZnSXJPTzZqeVAzbTdQcWZrdGY2UFdyM1FDV0p4ZzZrWm9yeTl1QW1r?=
 =?utf-8?B?RlVsUVg2b3did3ZqbktVeUpRaFlnUlRucVBXL3hVcUhmMW0zYzI2VVBkUVUy?=
 =?utf-8?B?dEdVZS9mUUNjNWxNQWN1TVJVdWtFYk5KR2dZTXZ1M0ttSXFaSnRxdjJQMFpQ?=
 =?utf-8?B?dk9CcE8wWEM5VFdSSEJmai84ajAySm42d0ttVEQvdEV2RzduUEE4SlFINlRR?=
 =?utf-8?B?bjUzczlqNmY5OTd0bFdlZWMvY1RiUTFHZ29UN0E3RVJyZDFJYVlETjFtRlU4?=
 =?utf-8?B?Z2FkMTFiYkM0b2tOWHdmdFZ0d210NHhaWUZieXhLNHZteU41WUlrbFF0ekpj?=
 =?utf-8?B?YVdUTFBGUXZxenBQSVJ6Y2NicXhVcllsekNSRVo2QzBPaWt6KzdXVEhjdFc0?=
 =?utf-8?B?NnVBbHZEZlhFUjVLbmhVRjcxUnBYdVZ4RVg0MU41UXdqa2xRc0wxdE1qY0Vn?=
 =?utf-8?B?TVdWT0JHSExRSVdXMGxlQzBSaWp2Z3VxaTFMcHJvS3V2OHZabzhPcUhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXM1R0Z3TUNVVlRhZzRqZWVYSlMzRldOUCttT0FiZWU0MTlkWUhvWEkybGZM?=
 =?utf-8?B?TlErc3RzTUF0K1ZyVlJGTGF5aWZEZUo0cDFVT1F0bnhDNW4zTy9PNmtkbWlU?=
 =?utf-8?B?Qy9jZHdwOVpBRjdQalJrV3cxZld4anE0RHQ4VXN5L0ZQcnZJU2pyQ3JFbEZO?=
 =?utf-8?B?SE93eUVtSlNaZzRnMWdUZUhvYVZCVE9NbVR3NHByRC9JNHRYbWZSZzlnR0g3?=
 =?utf-8?B?OHR3THYyRnNwTUg1N2ZiRDd0Ti9id1I2QWcrVHlRQW94MjJLT2w4c3NrZ0sy?=
 =?utf-8?B?eStJSWNSTGNQR2FtbitVV1NkMmVMR3hMQlN2ZExBV2xISE1BS0RZbTlkelV3?=
 =?utf-8?B?SjhhcSs5blBVMWIzVGdSdkxWdnhGUnNITE5HR2NRRkZzdlE5UytTeENZSTc1?=
 =?utf-8?B?U05kOG1OazZHVUxRYllJb3R3UGdkMlcwMmVPRkVJNDZqelRJdzZuUWFTdmp6?=
 =?utf-8?B?QVhGSUhnT2Fud1lBZUx3QnJhVVRpRW1JRXRlOUJDLzliOVMvNjZxaEQ4T2Zj?=
 =?utf-8?B?VW5zTGdRdGxVVWRUUm0zNjQ4cjBQRUtMSjEwVGlJZUtEcDhKOGpkdWJKMGlQ?=
 =?utf-8?B?WlJyQlFzTmc2U1gwYkd5bWxiMXFXVTM4ZXpacCt2Y0syWlVySk9ndHdnK1gz?=
 =?utf-8?B?UlVUQnVVbUl4cDRCSkIwdnRvV3oyV2RFRXhSamsyQ05pY1NkalA3UHNuVi8v?=
 =?utf-8?B?L2t3ODB5cG5hbkFVT0oxOXNxUmFBYnFnS3loaHZQWEZyWFByYzZuWUFOdW9D?=
 =?utf-8?B?OWlzbUtKVHMzYjhDaEVCNzJrSWpMRGR4dzA4VGJlRFQxY2pxZE0vZk1oZGQx?=
 =?utf-8?B?NE9xWnRTaHJ0bW5teU9uWGIwYlc4TGpnY0NDSFpuckRYeXdLU0FybUVCSnF5?=
 =?utf-8?B?aVV6MWxITTNWN21DaGM3Sm5LVDI4enNVZ1VOYjhMTUdxSGVoT013b29kMEJH?=
 =?utf-8?B?cW11M0kvK1E4VXpsNVdjVzAwR1VVZUpCK3BVQW1CQnBKSW1odEM5YVVocVZ6?=
 =?utf-8?B?S2UzZnRQSFZKc3hKajBqZ201YTlZVmhpV2tMYXc4bjRMUXQycjNQZkNJT1lw?=
 =?utf-8?B?S0R6L0lJbSsyY1duNkJoVTJ2b3JhTERndkpsR1hUNTFCLytaMjc3SHBiRS9L?=
 =?utf-8?B?K2t1ZkVTRVBiYmVReXlPaVJrdm90MDdLSjNVems4a0t1VjVQWkhlbzNKeEZR?=
 =?utf-8?B?UlJ0NW1scGtKNFRNaWs1akIyV0R1c1lBTXRjbWovVTlYdkF1SjZ1VW5BNkFs?=
 =?utf-8?B?MzZFVkFqTkRPZGYwZ3RBNGU0Y0dlcjUwRjZ1R0pmcHBxclhnZ2ZkOUxFM3NF?=
 =?utf-8?B?aXVQR01uWExLc2tnMVNGSFFJemdJTytJQWFzeXNSbEF2clliM1VzR2Exc1FK?=
 =?utf-8?B?eUJRK1p5L1BMUzlqd1hQQ3ExYmwyYy9oOWFJaFJ2SFJNZklocGhBMWptSXRP?=
 =?utf-8?B?dXhNOGhsVGNTVC83Z012WG56TkJVYU0wYXhBc0dYQ2R6YTk4WUNEOStDT1Rn?=
 =?utf-8?B?b0dDbzA5NEJKSlBHeW9LRVJkN25OOFgxRm9KbDFlcDlRVVFXakdpUUFZNFhF?=
 =?utf-8?B?ZXkwTm5nY3ZLbTlid2NwZkVjSTZ3R1ZVaXU2WDBQbWpRRnpZR1paWXdMWWtl?=
 =?utf-8?B?V3QraTVxUkw0dVNsMVpnRWxBbUpqWDdSaU9ueEhiMDRpWWVySFpWUmwwVnVF?=
 =?utf-8?B?eHdoMHROblFSdDNDd2gwbFZNaXF0RVMxUlFrQ2YzR1A1Mmh3T3cvV0tRVndw?=
 =?utf-8?B?b1dlVlZmelRCVXo5bnM5WWp0Zml6RTBoQjNOUkx6VkpJY1JFbkZGbk5uUFNa?=
 =?utf-8?B?RGRPakpzOUJ5TlJxcXFseDN3YWJXTlJwNXRHa0YzWFhFMzI5QTVxYVNJcDZ3?=
 =?utf-8?B?MjA1T1hBL2Z1eXZ3RGR5S0RKRHdvRkVGUWl3a28wZW00Y1N0L2hQaU9nUEQv?=
 =?utf-8?B?NHQ4dnI2QzRGcVJESnAyeVR6MHBNVjZ6SE9QQWtDUW9uS2FzSDN6NCtBRUxJ?=
 =?utf-8?B?cXBTdG1lMkp5YzY1U05nakdPUTdsem8ydEVJVnFOQjEwVk5TWlc1Ylg5bWF3?=
 =?utf-8?B?R1ZMa3dQYVp4dzJOV3RMQ2oreTRwWnBoNmlHWk5uQlZCQ1U0dy9NNnZna0Mv?=
 =?utf-8?B?bmNmdUxjMGZOcWJoMG55MW9vMTJBZHc5NG5iZkF6UFAyYmVlUEZMaWY1Q3dX?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f2972b-7b12-4b6f-fea2-08dce7bacf74
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 17:01:11.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEhzUB76cwb8YpjI+IDGnVi6BlJ7XQR6xKxE540LCciHZ3egSPu4Yf/Kplx1DGhxqnhiVPHKgpXsjIb70o1e0qI92RczbOx61xkKh6rYKt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6975
X-OriginatorOrg: intel.com



On 10/8/2024 9:47 AM, Vadim Fedorenko wrote:
> On 05/10/2024 00:14, Jacob Keller wrote:
>>
>>
>> On 10/3/2024 5:39 AM, Vadim Fedorenko wrote:
>>> Add callbacks to support timestamping configuration via ethtool.
>>> Add processing of RX timestamps.
>>>
>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>>   
>>> +/**
>>> + * fbnic_ts40_to_ns() - convert descriptor timestamp to PHC time
>>> + * @fbn: netdev priv of the FB NIC
>>> + * @ts40: timestamp read from a descriptor
>>> + *
>>> + * Return: u64 value of PHC time in nanoseconds
>>> + *
>>> + * Convert truncated 40 bit device timestamp as read from a descriptor
>>> + * to the full PHC time in nanoseconds.
>>> + */
>>> +static __maybe_unused u64 fbnic_ts40_to_ns(struct fbnic_net *fbn, u64 ts40)
>>> +{
>>> +	unsigned int s;
>>> +	u64 time_ns;
>>> +	s64 offset;
>>> +	u8 ts_top;
>>> +	u32 high;
>>> +
>>> +	do {
>>> +		s = u64_stats_fetch_begin(&fbn->time_seq);
>>> +		offset = READ_ONCE(fbn->time_offset);
>>> +	} while (u64_stats_fetch_retry(&fbn->time_seq, s));
>>> +
>>> +	high = READ_ONCE(fbn->time_high);
>>> +
>>> +	/* Bits 63..40 from periodic clock reads, 39..0 from ts40 */
>>> +	time_ns = (u64)(high >> 8) << 40 | ts40;
>>> +
>>> +	/* Compare bits 32-39 between periodic reads and ts40,
>>> +	 * see if HW clock may have wrapped since last read
>>> +	 */
>>> +	ts_top = ts40 >> 32;
>>> +	if (ts_top < (u8)high && (u8)high - ts_top > U8_MAX / 2)
>>> +		time_ns += 1ULL << 40;
>>> +
>>> +	return time_ns + offset;
>>> +}
>>> +
>>
>> This logic doesn't seem to match the logic used by the cyclecounter
>> code, and Its not clear to me if this safe against a race between
>> time_high updating and the packet timestamp arriving.
>>
>> the timestamp could arrive either before or after the time_high update,
>> and the logic needs to ensure the appropriate high bits are applied in
>> both cases.
> 
> To avoid this race condition we decided to make sure that incoming
> timestamps are always later then cached high bits. That will make the
> logic above correct.
> 

How do you do that? Timestamps come in asynchronously. The value is
captured by hardware. How do you guarantee that it was captured only
after an update to the cached high bits?

I guess if it arrives before the roll-over, you handle that by the range
check to see if the clock wrapped around.

Hmm.

But what happens if an Rx timestamp races with an update to the high
value and comes in just before the 40 bit time would have overflowed,
but the cached time_high value is captured just after it overflowed.

Do you have some mechanism to ensure that this is impossible? i.e.
either ensuring that the conversion uses the old time_high value, or
ensuring that Rx timestamps can't come in during an update?

Otherwise, I think the logic here could accidentally combine a time
value from an Rx timestamp that is just prior to the time_high update
and just prior to a rollover, then it would see a huge gap between the
values and trigger the addition of another 1 << 40, which would cycle it
even farther out of what the real value should have been.

>> Again, I think your use case makes sense to just implement with a
>> timecounter and cyclecounter, since you're not modifying the hardware
>> cycle counter and are leaving it as free-running.
> 
> After discussion with Jakub we decided to keep simple logic without
> timecounter + cyclecounter, as it's pretty straight forward.

Fair enough.

