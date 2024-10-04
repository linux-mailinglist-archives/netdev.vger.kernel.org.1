Return-Path: <netdev+bounces-132272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C98899125F
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7561F23BC3
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83041ADFF9;
	Fri,  4 Oct 2024 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJcbZtKm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1DF231C9F
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081416; cv=fail; b=CUevQV4UR7p6rLuP+p7g2DTzUFnV9Wq36zUwRGGbpflfjwer+q2QNct2Czzl51WmGHm9Zd/pWzqbSYEBCq94CZMd041RLx2O8W7KwC2Dab3Uu7QX8zzZNJTGJXHszgfZa4x5oPgk7R8QiV/4xlirLSO0RJK2T+NlPWKkMvagqV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081416; c=relaxed/simple;
	bh=LyumbUwYV684Kw3KIQHpyPIYW3CJbZjBWCEFY15M9XI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ysy1AosDnUQ8jtXiLXTebPvBNpJVXEmbDpzA+wR9XgykRrmqoHqcBaZ+lLAhokcetiORej/Mt1x0/gT6BvN01RaGeztSxIpnT8gEROZ1MvqYn0u+osReWkqDymUvblC0UB8D+ysu6zOymDRlgJVH8rOgO4/cW3rnFejZL9inc08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJcbZtKm; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728081414; x=1759617414;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LyumbUwYV684Kw3KIQHpyPIYW3CJbZjBWCEFY15M9XI=;
  b=iJcbZtKmUY4Jo1bfjxTFOB7RtsoRp+gZFAL7ZvUEw2oHY4eWh2ZBckSD
   WPOBWv1/T+dU/a/BHXRPF5y+YJriD9XjVUXLWbT4E7yCNxt6LJs8ntlSd
   sJbMAEXHUeEs3eQNufivyjuK1RYBpIkUR3tbXhVD2YU5xRKvFNYQ/DARB
   4p1vY7GCzfglgzMaBimjo2ZNk0he8WkiTB17XPowwBOcmzs45dpLsh/Os
   Lml5eqWkPqdA9BmsdnTV/a3d5XnSkA2qIi0aek8my+QvNto4jZo8oBMZX
   gIP9QaFyXpq0T978EYAUGlqznT+dsLH71rLQmZ/NoQrXtNoCIwLYMOazm
   w==;
X-CSE-ConnectionGUID: hTUCJ7zLRv6gcnkujyTzZQ==
X-CSE-MsgGUID: p1UUxNNPTpufgRUoHsn2dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="14938268"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="14938268"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 15:36:54 -0700
X-CSE-ConnectionGUID: FvWGp7bpTNuyYSxlSp9b9A==
X-CSE-MsgGUID: PZRPuKqSQlifDHeYaxaHdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="74428649"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 15:36:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:36:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:36:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 15:36:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 15:36:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyv+4jjxwymB/qJYcO+Lh0g25s3GdeM3tuM/6DJudaB2UjLgTkEZDKrfqj7wNTeNaU91CqQCjvl481eVUkCeCXrPxW8Zrc1n8LYqJCw2fSW8YO6r+78zO0b+r1IScJaK5W8VD21lycjjSs+0U3szeIFqs9+/+41UzEUspMmUT0zSZpec45Dd50glrUp59O5zZgVY24pmRynk0ZfkAy66QXKOngPQ86klCpm3zgAWKDyXO01rjXwdRSWOOHMiBBO4qN6AWIdwH48XDRSQSw0VPGv0fWJ3E0TVfwPTkDIcP59b0Nq4a3fwbsXcw3jmyrytxZ6qjFQLQHV818Ohg3wQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mubFxr3tifc8YFzkQqFbm7TcWoMIcWP+7QfxUfjQkZ8=;
 b=y5blZ7wGVdzwWrmUufOizzYkP/oWIG5C3cF7hImkaYJ/11PkVw17WJp9cP4hZW/yu4AJQGXPdQ0xJo+ToiM6dBL3c2lvy76uv3tojPWOMrnjMGmO/n0juof+SBER/9yIpj9w9lhSZC/fWg+mBEw6W5yiKrctBmkyN0RGRo1tuoMZG8TjdpyX2tcp4+OyiHJsAWiZfeDc1oQPJDlI7brZYVON1QwVF6ATwaFPzau1Di7TRJx2wPj8wAD5FQj2Z1rVZGdT2gHT7rFVTxsGrIZDHHAA4V9Q5vvkXf4nJWtc+WZrmCxOvRkJpX+2P3AhkiDcIOFQVcLk1ZgMD869acjz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 22:36:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 22:36:50 +0000
Message-ID: <c18fe74f-392d-4edf-b343-ef955741fe67@intel.com>
Date: Fri, 4 Oct 2024 15:36:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 4/7] sfc: account XDP TXes in netdev base
 stats
To: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>
References: <cover.1727703521.git.ecree.xilinx@gmail.com>
 <44d77cdcc1df6d2606945481ded02ba824d9d507.1727703521.git.ecree.xilinx@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <44d77cdcc1df6d2606945481ded02ba824d9d507.1727703521.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4719:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b99987-c16e-4109-2793-08dce4c509e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzFtVFg2bGFIMzNzSHNRZlpMSGZtZHliL3B2VVFVL2lPYjFtb3BEM3F4Q3Q3?=
 =?utf-8?B?ZUFHR3hQRzg5VjB5aGd5M08zRlZHOWlDMk5sS25lMndDSXVhNEdlY0RxVmtJ?=
 =?utf-8?B?NlBLcFB0WmtGbDdEc0NTblhoaVZCYUthTjlBbHY5VWtoUHZZOGxnZUlvNWVH?=
 =?utf-8?B?ZGY2M3RWR0ovc2ZWWmM4TDM0Y2N5NkVKZW5QV21xTjl1TGF2eElkVGE3bDVR?=
 =?utf-8?B?NlBrQTV3SEhJZS9UT3hoQjc4ZmVFVkFPa3p5WXhoVDFJNml5NkQrUzEvbGEx?=
 =?utf-8?B?bUNYMTI2WHRickFJZ2pYZVNRL0xtd2F6RFhoemhQZFpQY2Z6TGlBL0NCRFpx?=
 =?utf-8?B?a3JRbEhWQktVdnMrcFJTN0N0VkNXei9FNVliWXNFZWd5OEVmTUVvOGtvd0Fm?=
 =?utf-8?B?dlR4cWEvUHhUU1JPNE81R21vbGV1elZ1UWdsU043RWdVUEMvVDN3RndiejhH?=
 =?utf-8?B?VGxLN0QzSWhKd1RQbUk0YTJDclU3Z20rRFBrWG8zNVUvSVUxMnhaaGNncTFM?=
 =?utf-8?B?K1QrUlByWUJIMElFNHJTUm0zWU8vTHlFeU11Q3Y5SnpiblpvWW9BWDBUOUpW?=
 =?utf-8?B?MzZoVjZwVnNaUndGbnJQWVVuQXlMaGNMdVlkMWNITk9nT01NWThRN3dmY3Bi?=
 =?utf-8?B?ZWloNU50OFhpS2Q1VlI4TVZiVUMyQ0RwTkRmbGFCdTBsRlhjVDk1T2FNR1Ar?=
 =?utf-8?B?bmF3NERPRFF6WTJPbUlOZ3V0K0U5UHB2amlZK3ZaTS96LzBjREpHZ1FkbGJQ?=
 =?utf-8?B?QlhrVlpEK0pEbFhzcHR6Y1AySGc4UnZGR1JTTHhObzdoTGRJTE1tRCtNMDBv?=
 =?utf-8?B?NHJiRXZKTTgwZUFwM1VUWGU1MThCQmtxSFp6REJKODdkK3VXQVBVbXd2Q2dm?=
 =?utf-8?B?b2N5aDJUSTI5RXJOZTM3ZnBKc2JtTmcrOTMrK2JLS0xFdlhMRnovcmFOSjB3?=
 =?utf-8?B?ZFNZWmhjZHNIZU5pUEEvOFlHR3JuaFlnUExRRUdGVEZiRCtMUjIrdmFoUE05?=
 =?utf-8?B?cHkvZVVsRlRGZVZYLzczUFdzR21WM2pFcnBmdDJiWFE5cU8wWmxDRU9JZzVt?=
 =?utf-8?B?Z1NxVTdnQUJabGNBNitsU0psV0RZVHAzYXZZazQ0TlZmaHZkaFViMzRjTjg0?=
 =?utf-8?B?TDZqWmNRZEFVVjVPYmZ3UmxKekFBdHF0UWoveXdoeFJjSDg3bEliS3V5dHl2?=
 =?utf-8?B?YWJGMjNtZENsM1hCZmtMYVRDYlJiaktQZ2hJNG04RnBRSFNKdEZSMkgvTk11?=
 =?utf-8?B?UG5qV2lMMkNDT0JpM0pSMVlzUGF6dFc2QnhQT2Q3VEJKR0lzNlVuak9RcVBO?=
 =?utf-8?B?STNoOFJwbkdlak1zbFhvWmtIdWR1TWJLRHlxVFN3OGlNcUljbGJ0aTVlU01S?=
 =?utf-8?B?V0F1Ky9yUGVSKzBIQ1I2QVJPVWxWT0pqWUh5MC9veUNCNzA0YnFvbkRweXVN?=
 =?utf-8?B?TXZDYXJFMk93dEVjdEpsd2FsOFFSd2xrNlgybUp1VzY5eHIzVHV5dDJrWGVZ?=
 =?utf-8?B?djRvZW1qTkFZTzRZN0FXbEFWdWhPNGdWMWpXMFozMkh5K0ZCMWJrQ0FjQ0h4?=
 =?utf-8?B?dTJPN0Y2cmJ6b3RKM0Qxd0hIcXRtZkEwTnBNaHNlMks2ZHMrS1JKZUpMZjlw?=
 =?utf-8?B?aEtzNHJnNW41VEVOQmcrMkRCa05USEhYZHFXdk1zMTFycTljZG5TM1c0UmVp?=
 =?utf-8?B?eS8vcklGM3YzSm1BMExlUVRYYWw1TjJxT1cxZUVEY0xraXd1ZU8zSnRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3J2WmltR042U3Zna1FjZnRaVDhDTVpRUHhoZmZxUW5EUXlKWW52Qm45bWdP?=
 =?utf-8?B?L0IzdThhcUd5QTlFMWlzMjdDUFhncjdrQ0VYa1NWU01NMXZPZjJ1SlNINlNp?=
 =?utf-8?B?Qml6SEFKRkt0R0gycXFoYXJwUmFoMjNsblFZTXNaTVFCR3l1dEI3R1FTcy8z?=
 =?utf-8?B?UDZzMUZjMjU5ZXVNR01GREFwTlErQ1FWbmlhT2JzSVRyTG9vWHpvK1JRNnNs?=
 =?utf-8?B?NEJqbktXQ3lRQ1dLVEF4RCtNcEhVVk5DdTM0U0FqZGhoV1k4d3ZCWUFxNzky?=
 =?utf-8?B?djAyenFGWDNhdzFWUkNKbm1EYS9Bamd3QzZFSkM5YjNGdGxCUzg5VE82aEFt?=
 =?utf-8?B?ZWVmc3dVdS9JYWNJYnl1Y1RaOHlNOGgrRVRnYnhZVDZxa1RyN3l3N04zRkpU?=
 =?utf-8?B?RGVhVUErdWJ0aGkrOTVLZWt2bmhUckU3dTFza2lyUDMzQVNoaGp0cERmTlRu?=
 =?utf-8?B?WU1lWExkL2pKWktTVnExSnk1Wm9HMXdFWTU5UjQ2VFlucVJZcTBsZGVSdW1N?=
 =?utf-8?B?YkE2UFBvdWR3c2pIeXYxVlFZMzZXU3VMNVdrTmZuaW9IM0VTRFJGOVlMVU10?=
 =?utf-8?B?ZGxCUFhkNk02RzY1RVlYMTRRcktKaEo4VnZDRFRXSEovTHNGbWplbzRiYzc0?=
 =?utf-8?B?S3JxN2xaNS9Wd3F0a1h6QXcvdmFjSWJzVjhZN3hHWk1IUVJybmIyNDJYam1I?=
 =?utf-8?B?YlZtNStwNlF0eEppVHFONFdIaitUVFJUL3VNNi9BVXJOaEdCQ0VFb1MxMWRn?=
 =?utf-8?B?V0JYOVk5dDVPd3NoK202clJwUm9ST3FLaUd6VXZPbnlBcXFjMk11RVJxQzZV?=
 =?utf-8?B?aE5lVnJyVmJsS0phVDVwWHBvWmp3V3JJYk5OczRzdkcxaHdjV0M0RWc0TnR3?=
 =?utf-8?B?YlNsWk5rVlArWTV6OUUrTjlKajl3TFN3Yzg3bFE5OXppLzNTU0I3YmZtbXcz?=
 =?utf-8?B?a1UvdUlRUHpuRVdpSGw3SVREZDJOdm5HeDdPOHMya2xvb3BsR0c3N0YrUWN2?=
 =?utf-8?B?enhiTEo5cWw2d1NsR1B1VytLZjRLc2VDTFA5Q0RLZ3ZUVmxnZU1yU1dubVZO?=
 =?utf-8?B?QjRvaDdEUUF0dmsvYnJkZ0pTWTdmeUxZclFvcXhFTm9PRDNzWjhVOFB5UGcv?=
 =?utf-8?B?UnV2SHRuWmNIRDN1bjJwNjU0VkI5cGIyTjFmK2NyZVFna1MxcnUvcUY4LzNq?=
 =?utf-8?B?TUphZ2JyUUpUSWFxWFJJRDZpL1V1MTdQaDY2Qi9qVzZSbDdkYUxCcXZCK0FT?=
 =?utf-8?B?Wlg0RDFjWStvUFNOc2tjZ0xHaGRXYmdyOThaeWZDMDZDcEVQUWVsWXFpdzlz?=
 =?utf-8?B?MUdzNG1vbis5bUpxbzB2M3dlWVNuaHhOQnQ2OHB1QmRWWTBLMkF1RldpWTV2?=
 =?utf-8?B?d0VUSFJJUzlJR1daY3h1NDNBbm1GUVc4bnYrQlhTbmFxeW5OQUJPYStNeG9P?=
 =?utf-8?B?TjJOMDdYbUxTcUg0bFp4OUs5MHR1U1d3Si8xK1RmaVZvMFJVYWJvMFU5MHRQ?=
 =?utf-8?B?Qlh6SHJRaFNtMmlaSnF1ZmhmRXRvRk8rYXRabUpyRVJlMlF0bFQ2VjBUaEQ5?=
 =?utf-8?B?QSsvZ3ZpNDZId3NsUmlCQWs0cU5LT2MvT2JNYmRWMTdSSHRtbDZ1RWppNDhi?=
 =?utf-8?B?dFNQbjI0NGorY2NveHVjNVBiSzdxaHF4ODBuUGYwWVRVYzZwejBoTzV2V3Iv?=
 =?utf-8?B?YjFkN2F1Z0VPVlVXTVNaeW44dlJndFJLRG90djYvTUF1bTZONWhHcGkyb2R0?=
 =?utf-8?B?RTlHVVRQNE5UdStkK09Va2JHWVdXTENyKzhhSzZ2d3NicGZyNmpRWHhIdGdB?=
 =?utf-8?B?SGQwSWgyeW5UZTF2dndkVC8xT2FFRXJXQVkyUWlDbUYvSytGL2NRbHRvYVg3?=
 =?utf-8?B?L2grcXJIQzlzbFBWdEg3YmY3SlpsQjlNOElIOTROTU85ZEU1blF1NDZCVjRB?=
 =?utf-8?B?b1FzZGVnV3JqOVRaRUhiUWRsR1pvSGZJNzJwaVRnNStIcGRpZlJubG5vdWlz?=
 =?utf-8?B?SEx0V09MNkFES0RhWEtDcHFkV0hkYzhTSzNiRWd3V2hnWmpPODR1K2pNbHgx?=
 =?utf-8?B?M1Nubi9YY3JiUWNSbXNxVDZ6N0V2NG0zREtraSt4bk1MMk93WjltdElOMVVq?=
 =?utf-8?B?bFdGNitwN3JnaEIvWisvZHd1dEQxbnBTcStueHBwMGlNTVI4bWRoU2FOUHhh?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b99987-c16e-4109-2793-08dce4c509e5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 22:36:50.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcQxWs3zBrZ8jXZW1Dkci0WylntQ8MAWDoDFYa/PJc+Rc9RyuscUFAmjWI0NllBq/nJu0tP8dSZMRz/jcBSLBJNoF4zGIHkHTGskIpHrvKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4719
X-OriginatorOrg: intel.com



On 9/30/2024 6:52 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> When we handle a TX completion for an XDP packet, it is not counted
>  in the per-TXQ netdev stats.  Record it in new internal counters,
>  and include those in the device-wide total in efx_get_base_stats().
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

