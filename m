Return-Path: <netdev+bounces-121335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0DE95CC7B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F410C283DF4
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2CC185B43;
	Fri, 23 Aug 2024 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqLrmQ7F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90179566A;
	Fri, 23 Aug 2024 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416788; cv=fail; b=o5jvb0nY6lx9kQ7ytNOI+nZwlNZlbP/VD1+oDbk09ceZHiHCdnOry8Fnk4/8rJPE/GbcJN5Lkrz/sJNXtdUtHK5O3orfmkUrD8rWXWeISl4SMeBZ+N13KQwz0i5vWbD7Gy+YE3ASg3QFrm2GrNThW6j4pTGo6HugiFc18pEr1V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416788; c=relaxed/simple;
	bh=kBzgGjuyYVhWwan0X/aM+RzeuLKCeakXGY2FQ72b4WQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ik4TNmw44ONBdy2FYdOxJZxOgTN9GSB/uLcqHAHLmsWMkAwrS9NbRZn4HhoCzaywdyZLqWP8owzZVDXmGoLcpkwlISklcrT9QVRO+RGnyY4lfzd6rCzJdBE4G+t1WDSb6dm5yw3AlCON07ieMfsc31lAIHGm5cJFGh8dWC1vIDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqLrmQ7F; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724416787; x=1755952787;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kBzgGjuyYVhWwan0X/aM+RzeuLKCeakXGY2FQ72b4WQ=;
  b=PqLrmQ7FTlJ+wvua/5weWgPkLuRM4RrHsVR4sTc28N6IolzKI7AufFlV
   H2hdEHg9Rm3pRkqQlFJN3uZ9GqB3J4YrjarIZtfwoZ8UWTl5ltrEqWKFK
   HDiC+b0xo8shxIMJYXlYM4s5GrZ3nqJBMZo6YbOCJPziSOjTDiLkQ54l/
   xkcvP2sPsNRnw9sPDybcA5xw0qDSNe1nY7/4hjmoGLPXnrBwI11aLtusR
   cPcqjfihElF6QtWB/8oRWsfU+UmbrWx9E6/H7qrEfIvYjjf9VpwT20pxF
   yRLzosnMMV5bbVWoh84ZEGoFsD7ZXSF7jb6MiZzZR4xP5lmQsG4uEFM0D
   g==;
X-CSE-ConnectionGUID: ggrY6p8sRnK8OjLka1YOeA==
X-CSE-MsgGUID: uu3w1prtTwSwMcWD5IMv+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="34260432"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="34260432"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:39:47 -0700
X-CSE-ConnectionGUID: kGwGlx/7SQeV4pGKIK5EwQ==
X-CSE-MsgGUID: 8I9MfSmTRheDTfsLBVyafg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61646689"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 05:39:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 05:39:45 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 05:39:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 05:39:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 05:39:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm/0Vqs7TKwfVULix+qx7758jTTb4ji9drJinP3iCeNja0GGGbG8mNPSGe4gvOsFVIkqdn+XJ/DPr4WEjB2vbj3ZaL2G9DJk2odYmWZWKQl8ki3NJrLJr7Xqh3H/FdFsgbsDNXUtcdaZXFdmLaf6t6K5cCOr+e+6iX4GdMB82hA4UN+vfWi/bbNDQzzeTlgG3Q9HXhmtFwq3no7TIteFS4nLPoL6vIDZdu8N9PyBToVZUTNRLT3iLz9N70LJHOIccEpBZ9XqWfMYwZ4giralFqX4NS+Ss83sURJjZn9XJ/7PTTVfUyHwpkIlDMEnfNbCkaYBDBuEfWRKdvrmyfo5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjHBZ9qYv3vJDgi+EJRobdr6S9KfMmAZrY0ptmxfvMA=;
 b=HvMZIXSETw+/z0xD0BZvuLNv2XKZdBfibrcKgNrZhJ0SWk0KjYtrJ3zdMfMoC7ndHHj2gGaqUPSZQc035z4+V/IgtVHbM6OjC09IomBRHzDEgKdBsEz1smGN4kMv50czpnYPq53Bog1vQDuH3hbGmBBcsCZTPE8DHOskKxmkwL/YwOizeV5glxZrJbTMJ6/AC5/A5zuGi123h6GDo/hKTFPNKNVKbdWxNS4Q75eHDO+GbjiU5KzVKwDbJ/sYjfiK9CWUyMC1J2jICYx1oWE1Co6lQBBk29GrrlQ5Rmmxt5Ka1gS4em4gTn54dDjq0vRrlQou8mxEk6OwV86f4QN6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 12:39:43 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 12:39:43 +0000
Message-ID: <fa366511-e246-4e6c-9e8d-e539802e49ef@intel.com>
Date: Fri, 23 Aug 2024 14:39:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH][next] idpf: make read-only arrays
 tx_itr and rx_itr static const
To: Colin Ian King <colin.i.king@gmail.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240822213410.644665-1-colin.i.king@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240822213410.644665-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 4098956f-098f-425f-c6af-08dcc370a981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akRZSjcxLys1VGlJNVZpVHFPRzRudkR5ZEI3bHJtbFgyaG5ScDd0dVd0S241?=
 =?utf-8?B?NzlqVEJsd0hHc0dObGhnb3VwOHNMZmFuOFlxNGVtM2xtVEFoWTA3dkxQR210?=
 =?utf-8?B?OXg4OThaa0s1ZDRBaTk5RnFrUm5NR2NsWDZmK2t2b0plK2p3ZlJUTmhZOFJi?=
 =?utf-8?B?VllMRjFURGFFRjRzQjRJSTBoUmIwSGtralFCNU1XNmdhVUppMFpMbTRibzhT?=
 =?utf-8?B?RHNoSit5TzNEUGxNd2swVTVBUXVRZ0VMRU1sYnpGZTFWdUtKRHBoV1VSTisv?=
 =?utf-8?B?UVpYVkpmeFhXUUdpSjZWVE16TnluV2V6eE1sbGZlTHh3L2ZlZ0hreDZMY0Jx?=
 =?utf-8?B?ZlBXRXlnRlRQaHd6cXJmTjFHZVp1MG5sWFRzdWwxYXhtY2h0ajZiNHRrdGl0?=
 =?utf-8?B?U2EycUFvQTB1S08yMkxISmhhUHJXWk9BZW1HMVgwMEVwZ09RSHVuWDF2MnZk?=
 =?utf-8?B?UUtHbTRaRG0xeGtDQmhkUzk5SU16QjlLRTFwTFpLbFZaOVRVcjJuWkVKWm5a?=
 =?utf-8?B?ZTBjN0ZodkFSeExiQkUyMU93c1ZsaVh2cVhUajZaU0UzMFBqRlAra0RzSW1T?=
 =?utf-8?B?QjZzamlxOGR4b0ViZXpwYTJkSGFHSEFUcUNvSHg5YnZ4cldLQVNFZkd1bUJY?=
 =?utf-8?B?R0N2cE5pNi9FNVpBMEd0Y3E1UFlRY0VDbFFXcmkzdFU3YWlmSURPdXkrSWJP?=
 =?utf-8?B?Rms5TmFEdnZpMm5LOFRIZUxOSWNkQm9yZ0RTOW5rOXFuVEJXM240ZHliblRm?=
 =?utf-8?B?RWgyUUpHSi9JUHF2WXV3eGtoMy9acUVKNkdHcWR1cjZHK3RoYWNkWUQ3SUtw?=
 =?utf-8?B?bkRSazZpN3cyRFY5dERoSWw3TmZpQk10OC9JaFNjNHBBcytra1pyZGc3Nmtt?=
 =?utf-8?B?ZnlCcURsZ2FWVzVtSVFCSXFSelVOS2R6bkR6R2Z3eTRKcVFnRkhBM1lRV1Ja?=
 =?utf-8?B?K2hlTkMvK25sRFA3a0Zpa3VZOE9lR09DQStzdTRLWUo0aGhpWWc4NCsrYmJH?=
 =?utf-8?B?b1FLVE5aSTY0QS9ScmhyZDgyNFlwbUxXa0JGTnZjOThuS2VHeFZES2dVSGR1?=
 =?utf-8?B?cUxrQkdtRGh3MTJxTW9RUXIvalU5eEpRNEg5WkNjeS9FWGE5MFBvUEdrR1d3?=
 =?utf-8?B?dVkrQkh1ZmR3NXF0eVhrTlBWVnpUMURad2lrQzlENEJRcjlnb05KeGtSUzNo?=
 =?utf-8?B?QzNteWpxeHA0MUp1VUdZclpXWkdzaEs2cTEvSDJzNVNNZFl0cmdJaExLa3p4?=
 =?utf-8?B?bFlNMmFPcU9ma3hHQkZzWFpTWnpEOFA1QlVqRGFEUnJxUTU4U3pwcVQzUXRB?=
 =?utf-8?B?UDJvQXE1ZUNIek04UTZ0TTNVZHN0MXdpY0NBYTh1dVpCNkwrbTNZcnlNYkxU?=
 =?utf-8?B?YmZUek9PeTJWZ0ZWVHV2MTlpbTZGUnRPYUNKTzZ3WE4yZFJCdmRSOFNEdEgz?=
 =?utf-8?B?VjdmdUczR1dVbWlkZnh2b0trZUMvY3ovazZPWk1uV3ZURmtPSVVZNWF3SEtT?=
 =?utf-8?B?SUp5a2doTkM3Tk01djBSc1VnUVN6aW5IZHZmMGZGYXplVjZzSEt2dUhKSkhH?=
 =?utf-8?B?djY4YmQzNVdBTkl3Y0ovSVJEc0o0K25naU45RDlGd0N4NkVJeHcxQ1BKQlRr?=
 =?utf-8?B?ZlM5UHNUaXZSWERtVmcyYytpSlpxY0FncmFrR3ZGN1dJS2IyTVlOc1Q5ZGRJ?=
 =?utf-8?B?aTN2NGovMFFKc0xPVjFlbVhmQnlFWGZUL2R4emlYWnhUbGpWaDZJTzIweCtE?=
 =?utf-8?B?THUxOFh0RlZicVFsR3FwazNXZG5iWTZYSlBSZGtNeGZJYUFLYkF6Z2tGNDVv?=
 =?utf-8?B?R0pYY2xDekZFa1MxRnhLdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alZ3OXdVOEc3cC80aGtTYjFmVVVuMFlpNmxreUlQUHNhTTduUHAzYmZGRFJl?=
 =?utf-8?B?L0N0NVhhNzZSYW55czY4c0ZRL2JONC9SY2xXZ1ozcnFRODdUMmQzdnQwNnFl?=
 =?utf-8?B?NUVjYklsVm9rV1VYYlBxRE5WQ3NwYjE0ZEVZTWhTWUdGRmROaUtGRHRkMjll?=
 =?utf-8?B?OGpXSjNmaDBxRFdXTllCL1NoRUh1RGxrdUxlUGxVYm4vWGMrVEVDdXVoV1E3?=
 =?utf-8?B?aXN0cEpCaU1KWk9va1Q0V2o2TVAzNi9YaW9MTWU4SVA0MTN1alBWbTAyQUoy?=
 =?utf-8?B?Y0hsS2s5MXdoQ0xSVEVlSFhNM2Fqcmx5UnN5TmpjeE12clpkaVlqWjJ2eDNi?=
 =?utf-8?B?RVFMOGx5QTg4NGVEM0lha0lnYytPZWw0allER1BUQU5RS0xybWV6OGlqTlNR?=
 =?utf-8?B?djk1N1JVb1Q5NHhBdWdLNFYyaWFPZXc1U1F6OGxwZ1h1S1dYT1V0MC9TOTBv?=
 =?utf-8?B?R3l6MkpLL3kxNGlPblE1Q2pBYlV6TTIzbkptVEZzZk5RMVpCaGQ3RDNuRXV1?=
 =?utf-8?B?YXpkL090Y2FkNTBWcFRHWXF3NVpxQjB3eDlhSzU0STdNNEpaWlZXMkF1SkJz?=
 =?utf-8?B?Rld1ZjNxMmErSWphcmc5cG5UY1VueEVNTmRyd05kTWtBNmxiZDFvMTFmdUhG?=
 =?utf-8?B?Q3ZaUU5uV3NsME5MTm5yNnVhbEZqMjdmRVpEM0JqSjBSWnpSUmttbG9WSUpP?=
 =?utf-8?B?WnRYNnhxeEFjNDZWRGpQWk1oT3duanFqVWV2dUw3QUVNaGVFZEZrSitJRGdL?=
 =?utf-8?B?WG5vRFhyNnA1eEN1UVpzZjdZeFphdzZKVmNqWGc0REpxYkxDR1ZpVzVhQkZN?=
 =?utf-8?B?SWp2RVNPTFZZSksveFBXb1pKbndQRFltWllPLzBWdGZobDZieUp3Zk13N0Rh?=
 =?utf-8?B?NEVWclYxQkJ6aHhNc3B0em5wK1BMQ1FZK1cvNmUxalNLZ2tzL0F1N1VIRXhn?=
 =?utf-8?B?QktwMlZhd2xpMG9hV1hEOXU4K0laY3hWYytpOGIybWV1QytoaElUREdUNlFN?=
 =?utf-8?B?RlVCNVNWZjhMclVlWlp5MGRDVEpnbzM0VUJzb3VERGFPbnpGd0FBSEZvOElK?=
 =?utf-8?B?NWZSNUQ1RThWTDJLNzlnZFUvRmF0NW5wTVg2UzhIVkxvaFJZbHBmMUswRWV6?=
 =?utf-8?B?UnhtZHAwR3F0UzVwMUxINityS2htVTBoY0VTWkdoMXRPV2ZJeDRqWmVCNFpR?=
 =?utf-8?B?cHM1alNsYmtpd0N3TWh5RlA4T013Y0kzMTBIcnBlbi9FakIzS0ZRRUYzc0Uy?=
 =?utf-8?B?ZlJnM0Y0b2g0YTkxUGU2azdVMy9TcS9wMW1UVk1ER09JR2IxSng3TTdPTE1x?=
 =?utf-8?B?MHZJQ0I2bkVFVXVtQzZUL3ZrSldpSjc4b1B2c2dwaTgwMGtVN1NOQkdJTFlP?=
 =?utf-8?B?a1VNbWZ6cUpwZ0Z1ZGMrRENYQ29SS3U3QlVNNk9Fc01TaTEyL1Y4Z29TL1Zo?=
 =?utf-8?B?b0xmVU1XaDB6SUk1NkxQRlduMDg4blpkNElBSXdHaGcrelVMRW9mQmtzV3N0?=
 =?utf-8?B?cCtPaVE1RGFTblBZTHFSVU5XK0xPekR0MGJkamlZK2hvaGJ5b2l4VTdubi9N?=
 =?utf-8?B?Q0RnV2d6QTZpaDQ1TWVMMTR3aUZCYVRtamsydGhZQ3RVUFQvMmF2SEFRZXhC?=
 =?utf-8?B?NmU3RS8xVW5HeG5wZ2RPa2hDSjMvT0RWaUJDTTg2amhOdE5ZSGUybENNQUJ1?=
 =?utf-8?B?TWJMZnlwcnY1cDU2YUFNTTJXRmVKM2JsVCthdE1MWDBKYTRCVU9DYU1DVFUv?=
 =?utf-8?B?SExwOWVkdDBKZ1JLME9WRTBKTXJBbHZuUGhZd09Ca04rS2VQc045WTl6UkpK?=
 =?utf-8?B?WU9xbkpXMnBncVhKZEhZQW1KTlNYdEVsQjYzOUZYWTBpVytyZ21waXZOSGc5?=
 =?utf-8?B?UFE5ejFZZGRRSW04NVZHVmZDcDZySnQ2cVowZDE0RDJueU82eXNUaklHbUVO?=
 =?utf-8?B?Z2lhS3pleDVPbjZjNEZsRmtUWGtKajkyN2RjM0hnZTR5WWNtSVMyNjZzaTNH?=
 =?utf-8?B?MHd3ejFJNXhVbzhYd2hvZzQ4TmhsQ2lkQnZCMnVQT2Y5NzFQaVhmbm9nYTJj?=
 =?utf-8?B?VEVyVGE1NHV6SVRncEVkbkVSdXg3SWVxZ0tNMEJtVHEybEVWTkpMYkVvU29W?=
 =?utf-8?B?VEVzd0NwL3dOZjJ2eTQrcThjckhCTnNmK2VKZWl5NFVHOFdKUmd3TTZmdUU2?=
 =?utf-8?Q?803LrvzMCbLpsVStBQR+aaM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4098956f-098f-425f-c6af-08dcc370a981
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 12:39:42.9748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBEimnZJnUzojrsvJC2AzbIgGjX5dPHxv6YI2YOmPBrOPA19JdLdhvQL1Ruuvox3gl3RbSCxxORNrEUmvmLl4hEoW18d+0ve75W9aI6ZzPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com

From: Colin Ian King <colin.i.king@gmail.com>
Date: Thu, 22 Aug 2024 22:34:10 +0100

> Don't populate the read-only arrays tx_itr and rx_itr on the stack at
> run time, instead make them static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 70986e12da28..d50e5cab05fc 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3149,8 +3149,8 @@ void idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
>  	struct idpf_adapter *adapter = vport->adapter;
>  	struct virtchnl2_create_vport *vport_msg;
>  	struct idpf_vport_config *vport_config;
> -	u16 tx_itr[] = {2, 8, 64, 128, 256};
> -	u16 rx_itr[] = {2, 8, 32, 96, 128};
> +	static const u16 tx_itr[] = {2, 8, 64, 128, 256};
> +	static const u16 rx_itr[] = {2, 8, 32, 96, 128};

Move it to the top of the function to keep the RCT style?

>  	struct idpf_rss_data *rss_data;
>  	u16 idx = vport->idx;

Thanks,
Olek

