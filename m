Return-Path: <netdev+bounces-131175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D537998D092
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C90428306E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429061E202F;
	Wed,  2 Oct 2024 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QewvIs1P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A71E202C;
	Wed,  2 Oct 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862958; cv=fail; b=nHdSHMI3UIqBqpBxgpdpunpamfImI8lNiShQjPrB0wZHNACueuTJLqYBA1JlXtN4zz/dZLbVHFftR125dtgOW6ZubWZkdmNhdSWSwTnz7ut+Me30w6zcR/GiYIxknTbqJ+mhtRZxcbMvW0wToC/FAXEJV0incizrGf5+wjB0Rtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862958; c=relaxed/simple;
	bh=DbehWCY26DPmYpe0pt0yrcYCvPckYTK+zC1wb43SSHA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rqTHMeLeK9sXnVTJnlaedJjzYaQQ1+lP0EvUdE2Ey86Sai0svPfMNZH1DuLAUa9oEQRTtp8i9K3o2Q81KzJTz14TZ5y4Ww8XrDOnPfw7FK6xlGW8V2IGGhztRsw1ImuffW6cVhBq9UEFKMKckQRvOl3x1sGHzK5mi8BSb6CBqN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QewvIs1P; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727862957; x=1759398957;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DbehWCY26DPmYpe0pt0yrcYCvPckYTK+zC1wb43SSHA=;
  b=QewvIs1PpNdlrMu4Skp9eID8pzKZZuzXcHJgMQbW21Q4BUXhz5/K6HOL
   F5Fv2UFsGOdDVQV9OWJgy4ymuVS4Zj+zGAnAlyxmV6Dnxox+Xg1z1+oUj
   vBzifkgpLG5gIeVruhButk9lG5WmeWE4/ncrXzv0fqwaIMHIOOCdfe4Xv
   ZpODGW7Txqg9ebAEZiHKBn/2ESwiXmI1G9izt2ucTILYM9XDanJHEPD5v
   nCQTzS9JItudHJryZzcD8Ml8HPs0qcNJEf7yTy3ye0WezHHR9N2zyf9oD
   QS86alvlrmK0g7wr7FdPjJQtlJwVCQnkpSI3rhwnEw03d+geaAGqBWnP2
   Q==;
X-CSE-ConnectionGUID: CUpHgGzHT8K6VwOW3YBiEw==
X-CSE-MsgGUID: DXogwcNFSfaLARvbE5E6Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37612501"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="37612501"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 02:55:56 -0700
X-CSE-ConnectionGUID: ZvHvuLE2QCaa5plKnt7uuA==
X-CSE-MsgGUID: tgGymx5zTmaYpMa32ifqnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="78483172"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 02:55:56 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 02:55:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 02:55:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 02:55:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 02:55:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yA0zWFeBlOj+/OBG3rgz11oE+zRwKQRh4W97OmS8SPCZfR1MToLPtd1Nb/sbPCUHZy7qYem4jeqrr+FUaSV5FalUjaAsczj1y83Zb5qb5mRVqqV0LjCQy0KiDLEsKu+x6QhQzxlxXq0UYmkqrtr6QGT5T3WFqEN5LEezoiV5aQmS0gnuXeN3wnBmjxl9vn0DYgD17IDg+IW+R8cmIfdcZy4Bvgq3J8g4x0eVa5Y+ZRxOdyj5bMJOXvtjnm6ljVUuzhxB5Q+tejVZKq+BsyHhyKKhL9lQOI03rVxYBAk+fG/G0qXlRUamHpOSAxDCuxCItgGCJx0Hvn2GUc2FMx3ITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH6xhwzwjk84FEI9kwc0VhSfqV3KcoQtblYE32vxaUM=;
 b=QVyiLrA6LSOgQ1Tw1a5yujHPZsWAmBexOvV6jkr5H5JbdXnoLIJBt8xIW6mk3HB2eH1CWhj2cGt6NgS4Gc6pD6/S08V7MFOcfJeVXV+ouhORuu0uOn6N0HGgvKk4BxlgzlSeNNCf6tC0IIUW4LCkscI9+yEf0fxj9cPFZQivj9k3BPztqe0cjQNe1p2pwEHqUkZvOqKA/cb1o3UYNbve5SJ+Ciha6hYKPccm20xsZs5HLWRRXJBFtL5kZW70atmEaqFAbx//ik3dMZxvMKikQLy1vJ2pfTB89fQn6n+CeGabHsT71wo7JalbjSTSTZCNkSVX8WD5ws37F6v1oSL6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS7PR11MB7932.namprd11.prod.outlook.com (2603:10b6:8:e5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Wed, 2 Oct 2024 09:55:51 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 09:55:51 +0000
Message-ID: <a4efffb9-9c63-4cb1-94a3-050260fe0a81@intel.com>
Date: Wed, 2 Oct 2024 11:55:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] Simply enable one to write code like:
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andy Shevchenko
	<andriy.shevchenko@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
CC: <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<amadeuszx.slawinski@linux.intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, Markus Elfring <Markus.Elfring@web.de>
References: <20241001145718.8962-1-przemyslaw.kitszel@intel.com>
 <ZvwTZxN1F6X6Wd2i@google.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <ZvwTZxN1F6X6Wd2i@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0208.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::20) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS7PR11MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 59591d16-02c2-4840-77a5-08dce2c865bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1cxcVgybXBUbHRva0hWNUIycVpoU2NHUHdxZkQrVVlhSldwUXFkK3NGV1BJ?=
 =?utf-8?B?YTdjNSt2WjVtM1NJM1FuL3hkWTQyNU51VTJ5UmQ0RzFaR052M1BJUTEybkhz?=
 =?utf-8?B?dzliOXhoaEFMQXN0YWNpcEF6bzBoUHkzTzZSWTRjYWpQNDVXdjdEbG90OUp1?=
 =?utf-8?B?cXJjTWJ2NEJYZ2pxcVBXWlhMOVdNRVovNEsyYVhoU01kV0JscXpIejRGaXhM?=
 =?utf-8?B?V3NuSkszbFBDWW81eWtna3gvTkg2bGVDWkNTWjM1M0pscnh0ZVMxbWFhUXZX?=
 =?utf-8?B?ajQ0cGJIK2g5bG1Hc0FDUmF2QTRjay9ucHdiVVgxMml6L2hpTUUrMTE4emR2?=
 =?utf-8?B?blFQTWR4WnptYUZUaGVsaVlMa0lzc3hZYjU5VmE1KzdNQVBvVXpzaGpoZHRP?=
 =?utf-8?B?bW54RHJTT2FTbEpvcVlMN2VuZHN6YVBIK2NONHg5U1VIUm5tZjZxOFRpUm5F?=
 =?utf-8?B?cGtBSitYejBSUzNYbGpDRzY3QUNmNEVHdGdaQTRFVTU2ZXYrL20xUSsrVENu?=
 =?utf-8?B?QTRlUHNQeUFTQ1I0cUtXeWxUVlBFRGU3VUZ6N0JwRTJRcjJXUTU4cktDcGs2?=
 =?utf-8?B?VWlqRTFZTFF4ZnFtM2I5c1BCcUZSU1RSQ1RLc2tjdGZiajc5aXQzUzdnRkFM?=
 =?utf-8?B?dVZ1OVpDWmhrekMzNm8xS1k3cEVQcDdaTGdiQzhQUHczYU0vVG8yakdjaitz?=
 =?utf-8?B?SnZKRXBNOUhKdjRndGNLK3dJQXovT0F3Ry9JV0g3djlZVTIrS3VLQWJvVk9G?=
 =?utf-8?B?eVBZdzVOanNPazJYMUdicnhpZUhCV1gvaldiMmtpdmpqUGhZSU9MNHlySmIr?=
 =?utf-8?B?NDB5Um5OVFZzcTJtekFFTjhVU2VUNENsenhjV1h3bVJhaVZBUk9DbW5hd0xL?=
 =?utf-8?B?SkQxWFIzU2pYT0VCTzFRcStXZWh4QkRCUDFyNmt5Q0MrSU5iUVZBNmVtMS9u?=
 =?utf-8?B?dVdycXhrNnk4Qm5VVWkrSE1LaFRaRnJaQ3dYRWJvZUM1b0F3M1dObzhETkkr?=
 =?utf-8?B?TVRzQVBYK3Q5SXBtMnp1d29HR3hHcy9NUEtLZk9BMDgxNE9HKzNsNk5oTHlG?=
 =?utf-8?B?a0VycWEyKzBSMllzWkJSWFpVTVZnVWhtYnQxWkozclBCU2hCN3BpNlhOalVG?=
 =?utf-8?B?Zkhlc0NTWmk0bmlFYTkvMDIzVTg0dTJDaG50cWo1V1k1TldFTWlmd29xY0pM?=
 =?utf-8?B?dlltZWU1MUw5YklPd1hUaW5ObkNNb0QzMjkvZ2tpSEVjZjM5NWVpV29lYjRi?=
 =?utf-8?B?Wlpmb2MzMkxuamhRMHlEdWVtQlhHc2VwV3RSdFMwMUpwQ3NROHhsNWZ5QTdW?=
 =?utf-8?B?QUdza0VIbnl4Q2JsUFFEbFdncitDSmhUamYvME9aNHprSWwrNDQ2R3hJNTdr?=
 =?utf-8?B?SERSVHkvUk5VU1RIZ3VMRTA0MnM5b0QwdUJUb3pJeE9XTUJtUEw3YURGOEds?=
 =?utf-8?B?VmE0VUU0Y2c3N3RDTUcxc3dUeWwwbUlJanU3N1p3TU5qR0FNVGZCeGNnZDZn?=
 =?utf-8?B?MVNPS3ppdjcwUGNrL0tscWl0aTByZlNYSTZ0V0VhOW5tUkhHOHp2bEgrSGVD?=
 =?utf-8?B?cG5henM0NThPQ2NQTEhiOWk5eUJybmRnOVdYL3BRcCtpQmdLL1AzUHFTdDBu?=
 =?utf-8?B?Vk1nblJsZ2N4MnJQTy9LTzNTRHJyRnA5WnY4dURKc3VTSFordExRYnlvQ21N?=
 =?utf-8?B?OXZKczhEZllkbUhwcERoTi9NUzJmaUhRUmVxNnVUR25KVkdOVlA4ekNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk55RnBVZlkwZUN4ZWFBNXNHaHlSbWJ1Z05Bc2hMKyt1UkRTTDJjSkdrN1VH?=
 =?utf-8?B?ajA5ZnhXTG54ZXJKN085aUF3a1Uwc2RyMXNkZjNFSVdMdHlDZHc1Vnd4ZWo0?=
 =?utf-8?B?QkJvR05Mc3VBQUgwZXRDNWVrOFFDUFJkMkhBK3g1ai9VVFp6cEJNb1lTdW9Q?=
 =?utf-8?B?dk5sdmNDRXlJV083djVydGhOejIvMzZpNVNEMTEwWjBPTUpqQ0RJNnl6WnBo?=
 =?utf-8?B?Vmh3dFZmRVk5UmJ6M3dLYXVBSXdFSEMwYUxZR1lhT0RQMjVwNjBpbVJwOVN2?=
 =?utf-8?B?aDNwa3pvWEJ3cG9hU0NMQ0orVU1TcVVQbll2eXJDVm45MVpHdG5yYlBIN3NP?=
 =?utf-8?B?d095aXNON00ya2dPL1ZHbXQzMkY4bGYwdEtxd2lYOGY4MHVnTHUrTFNDS0dr?=
 =?utf-8?B?QS9zcGJKdys5N0JmdkNpWVlPSlFpTUJ6ajhGcHREZ2xoajR1cVpSaXJMcDhQ?=
 =?utf-8?B?a1QzTTM5bEF4aVJrMmlabVNIRDM2L3ZvWVQ0enB4ZDQzSERHWVIrSnFVdlF3?=
 =?utf-8?B?U0g1NThub2dUSHRwNUhyeVdTcW85d3drb3A4WkRyaHY0V0tFZDI3NnhZTHlt?=
 =?utf-8?B?ZkZ1dGM1VVEzTUFJdFZuRGRmNWdSVlFLTkIrbC9MbTA0RnNXeEZxTVdoQ3Bx?=
 =?utf-8?B?REU2eS9jREJhdm1wYzIvWktoK1J2YTV2SFhzdHVRMERGTmJmR3dYcjMwa3o5?=
 =?utf-8?B?SWhEcEtqMVBhaDc3U2EwTHhsTHNmdFFxa1Qzd2dnMXV2dVZDelFwT3BGdGcx?=
 =?utf-8?B?VVBuZG81ZXdkaytkaUM0VkxYSEpSY3AxVHRvTnJDOUNZKy8yOEdYNzVhdmJt?=
 =?utf-8?B?M2YvM3Q3T2g2UUdqRU5UNktEY2g5K0NuVzdzWGE0OFhJeG5PQmFxOFpuaExX?=
 =?utf-8?B?RjI2czVZc1lVN3RSRzd1aVJlemRZc05Lci9ocW14OVVVUmpsS3NERDJTTWZs?=
 =?utf-8?B?UC9selZtbW8zSVZLQjBBWVU2L1k3NkIyam12eFAycisxalR6bVZ0aHBjUmF4?=
 =?utf-8?B?RXErRVRwUWIraVVNNVp1MWRRNUdRTHRCSDU5ZXNNRUdXbVoybDZpcmNITzFB?=
 =?utf-8?B?ekpIaFJuTzJONGliN2JHNmV4ZUdSTk5sM3VHVkxjb3dZQUNhWmNRQUNxaTMx?=
 =?utf-8?B?WWJ3VXhtb0NKWldYWnc4c1RvZXJkV0ovRnU3RElyN08xVXRuSloxQzdZa2Iv?=
 =?utf-8?B?aTRyUHRpNmV6Ull6d0RPbUFOM2JSYkdpQTRoN0hvdFdOQndKcXp2Y040N211?=
 =?utf-8?B?WHIyREcveEdmcm5UUE54c3Z2MnROMExyQnZDNS8xRnV4LzdFTk96dXAvT3hV?=
 =?utf-8?B?K3NIeEtITStxSnpiQzdJZDc0WHhPazBLWGc0YXBkemJEdzl3VzFXazViWWFp?=
 =?utf-8?B?L2lrTE5wRFpmQ2xKVFo0Ym9Ub1pTOUphSmY5eFBKNEJDQ01WVFFWMWkxRFJw?=
 =?utf-8?B?bmhSczdnckt3ZUhDQzZCNFlaNm5GVVEwRXN5SHFnSXNET1I0ekRRMFhBTTVY?=
 =?utf-8?B?d1c5bXVFY25BQ285VTRWeW9VOFRPdjh6RFN4OTVvMllOTkVTaWRneERoMlZm?=
 =?utf-8?B?MlQrQngyOU5kVCt2SFM1NlZuNGRGOURIL1JlcG5QVWVvN2NzUUNHUkJUblNV?=
 =?utf-8?B?RGVUOHZoZDI5dktFS1JqSTk3elJxWFp4ZCtROVNGR3FUSkxnbDVFL1N6bnJ0?=
 =?utf-8?B?OU8xR2RxQUN3WUdhZzhFZW1rcWUyVDRaUUovL0Q1aFFCOUZ1REU1anpPMDNh?=
 =?utf-8?B?eHJsNG5ITUYzNjE5dUQvS3F5cHFqb0Y2STRFMWhhQWM5dXdFZTRoRHJZOGxM?=
 =?utf-8?B?NGplbUdPU1ZXMUZBNUJuVU9SS1hHbWxFS2Q2eFpic2V5b2RlZCtwOGJEQ3c3?=
 =?utf-8?B?VzVYQisrNjhsK2JuU0p1RnNjeW50K0RyOTM4YkJwZG5pd2gxeVlIU1Erbjg2?=
 =?utf-8?B?dVNuMHZac3Q5WjR0UWJ4ejgxcGlnc3hjM2FZb3YzV0Z3M0hsT0Fha2I4cnZa?=
 =?utf-8?B?TmpyN2xMeU4xTU5ZME90ZTlMRXlvMndJS0p2cWhiWUtPNWE1VG5BeXhnQkZu?=
 =?utf-8?B?OUk4QkhJQkhNVENveEZUQTZqZXh6aENsS3MvLytsUFJLK0wybEFsenMzNXJv?=
 =?utf-8?B?QnZIQlowOWhKZ0ExNC9PSUdWQmp0OUFvRndFMFpUbFFGTHJjZWRHV29wVG1J?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59591d16-02c2-4840-77a5-08dce2c865bf
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 09:55:50.9200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWZJ2URIhd4rOG/dgAAqgeBAK/JvGpCc7D5q+rMgwTBNo0aXZwKhUGhgLf3DvYz1I5FCX0aJQihr7HxUnJTEMfE0gN4s9wC6k2nXMKAMkCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7932
X-OriginatorOrg: intel.com

On 10/1/24 17:21, Dmitry Torokhov wrote:
> Hi Przemek,
> 
> On Tue, Oct 01, 2024 at 04:57:18PM +0200, Przemek Kitszel wrote:
>> int foo(struct my_drv *adapter)
>> {
>> 	scoped_guard(spinlock, &adapter->some_spinlock)
>> 		return adapter->spinlock_protected_var;
>> }
> 
> Could you change the subject to say something like:
> 
> "Adjust cond_guard() implementation to avoid potential warnings"
> 
> And then give detailed explanation in the body?

thanks, sure
(and apologies that I forgot to add any subject :F (this was just my
very first non-subject paragraph))

> 
>>
>> Current scoped_guard() implementation does not support that,
>> due to compiler complaining:
>> error: control reaches end of non-void function [-Werror=return-type]
>>
>> One could argue that for such use case it would be better to use
>> guard(spinlock)(&adapter->some_spinlock), I disagree. I could also say
>> that coding with my proposed locking style is also very pleasant, as I'm
>> doing so for a few weeks already.
> 
> I'd drop this paragraph from the patch description (and moved past "---"
> if you prefer to keep it for additional context.

I will think about that, especially given that since v2 this patch is
not only fixing "my case", but just it's regular hardening for static
analysis needs.


>> +#define DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
> 
> This is not supposed to be used outside of cleanup.h so probably
> __DEFINE_CLASS_IS_CONDITIONAL()?

indeed

>> +#define __scoped_guard_labeled(_label, _name, args...)	\
>> +	if (0)						\
>> +		_label: ;				\
>> +	else						\
>> +		for (CLASS(_name, scope)(args);		\
>> +		     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name); \
>> +		     ({goto _label;}))
> 
> The "jump back" throws me a little, do you think if can be rewritten as:
> 
> 	if (true)
> 		for (...)
> 	else
> 		_label: /* dummy */ ;

user code must be glued at the end, so there must be "if (0) label:"
however I figured that you could reorder for and else:

	for (
		CLASS(...);
		__guard_ptr(...) || __is_cond_ptr(...);
		({ goto label; })
	)
		if (0)
			label:
				break;
		else
			// actual user code glued here

and this jumps forward

> 
>>   
>>   #define scoped_cond_guard(_name, _fail, args...) \
>>   	for (CLASS(_name, scope)(args), \
> 
> With your __is_cond_ptr() can this be made to warn or error if
> scoped_cond_guard() is used with a non-conditional lock/class? As that
> would make no sense.

good idea, thanks

