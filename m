Return-Path: <netdev+bounces-293637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFpFMspQHWpYYwkAu9opvQ
	(envelope-from <netdev+bounces-293637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:28:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A91461C6CE
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65B8430AC475
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171C9390234;
	Mon,  1 Jun 2026 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EX6Stv75"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691213905EE
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305631; cv=fail; b=EDct/isdBh2EznWpVMpJSnu1kKPAENU9yxraucv0mzBK9Ybz20yDq/lgcdZOcUNC4OPXVXtr2hgRcSjtyT/bihhOu1uOCO2sSi47ZR0kcsWIoeoH0hWJSstsOmskLyOZz26FWMNgVqNlwpJRKnLDp3SZIrvCP66xuwMfdezPHkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305631; c=relaxed/simple;
	bh=PDWWXfsK0F1GyaeY3JmWXVXpUf7DgL1P45YBz9MFHk0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=idMw9a/aK/6a9d7YMuuiWhMhpb6v4iYTsdXV4UE2YAH89qSyroFNpVfSvowWqmyhkEJcA5J2GuSmjQI774Yac0XJBUofM6x3dPEaibch/V4KZdBO9xJBJh6tYp68AZWARlAHS1WPM1w7u+RuYi2RB4X0q80Bu03OTuIiA6D0Hpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EX6Stv75; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780305629; x=1811841629;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PDWWXfsK0F1GyaeY3JmWXVXpUf7DgL1P45YBz9MFHk0=;
  b=EX6Stv75Zm+fuxRgLl7S9JSg61ggWCizM86omgjtkVhGuA0bGxa8CWoM
   qOUMbOEcuD7j1iYf8/qxoCJWlqHAqDv24qJEAvYdcPbGPazPJH02y3CyK
   ChjHOT+t9Lc4v9CzNtQi5UVS3uoG1XV0blaZb5LUBkewXRkrqVK5lq7Vy
   yzTIbsBemKyjuSKi5/t+I1T6IjOXfwgTBNq4YK3HzAgsWg4YlWwxGYFow
   rWc2PZoKrIq7DZW/Mp9bKSQM6BzOW0XpaG1xteNxT+3FpOqlvTG3H5Fku
   SjFAcL8of/Sh0r6irrNnqHobuBxWsLoahJpGPt512dAoUPC2sUfI1wg3P
   Q==;
X-CSE-ConnectionGUID: qSxhXBSyQFee79UEEUhKTA==
X-CSE-MsgGUID: lSEHL2xhSASWtfOhhovV1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="98626710"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="98626710"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:20:29 -0700
X-CSE-ConnectionGUID: M3upSNeGR9WDJ+qBV15zbQ==
X-CSE-MsgGUID: +UwtpTWDRtWVFdY4vM9hWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="245351749"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:20:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:20:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 02:20:28 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:20:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOJVbW0drjwBeRjBVh+q6khmFVSrsiHsCaQUgsUjF81Q3RVEAohqm9vkA7byCOnqB9fZKnL/wdsHy1mhn+Nxpbdv6oyMuXQy+TKifD1vZcrKjsM1MYWcMXYfnj2iCeJ598gr7xMty/B8luHhqO15/bQHEd+qTAFXfYjrtn0d3jQ5ohMv72toRyhtrs8XlCOpvvOFwNTqQj2DsMa9Wu5hEd9geoQEqLKc1WCWr/ygl8bUbtTieguK7R43L6fqdluOoQnJmwj7P2CGYLlHPQbEUfeWbuVAkaxObKcnp6KVdVi7NHpZFmeWjWOGdjZeL382SHldumc0f1rBu7xXYI/LZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2na5f0/PqWHPMR79veAfPEAwCWgox9bOs5/Ii/Zh5kE=;
 b=uqQUHElE2Z39NRp0sui1i3iCYJ8voCzX3+KCjXYYXc2VMjhLdaNnodauzQiXhyYtTVSw+Fv6PHqMh0gn77t9OfdwlICIG2eHqIVIUturit8UNrtJyFXxf8ZQjNii/q6pHrfpWUO6L8lyIiXZkY8cpja3SZEVJdR+QWjjMT+0cLS74Ju0OsOgb0BcqEvV4A5/PjHLXpvOISj80NuBMxL0/GdJj73jTUGSPP619sz5/2UyVKv1RpcSsj3RwQAHc67njy2/92fSZgA5mv71Qcwv/TxLMlrBb21euhz5IWbdvNUpj0Tbh9LTNgiyyDcehxYp2n1n8KIzZCgyzTBGdZk3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SN7PR11MB6749.namprd11.prod.outlook.com (2603:10b6:806:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 09:19:24 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 09:19:24 +0000
Message-ID: <4775dddc-1b5e-439e-a57c-df540d588bf3@intel.com>
Date: Mon, 1 Jun 2026 14:49:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/xe/hw_error: Use HW_ERR prefix in log
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <rodrigo.vivi@intel.com>, <dev@lankhorst.se>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <kuba@kernel.org>
References: <20260523050212.557292-1-raag.jadav@intel.com>
 <20260523050212.557292-5-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260523050212.557292-5-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::13) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SN7PR11MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e0c787-e4b1-46f9-6d56-08debfbedf05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NI2k4reM5pHJfH5aTQ3WJQLtvyEpBUDtoH60pY4CnC9bhIZhz0lY4U4gg0FMmiCpNcGvniHfN6P8AtwNdUi9SDJ57D886PNaNMujqBDjqiDmPrPzvLiMa54x/TrK+M9k8Ca4C36nnHz5qlUiuTQMAR0aoItNw/VYOZONuEwI+m7JAIgnGIzATPVNHza66KQgsO/LfEgMMp5AfxvvTrPhSWvCgL144+OMTYjy1boozOGY4fAxK6Kvc1kKOTzpnTbf6GG+QIabx/bI/Uk1NtUk8+ZavfNBwaANIQvg46qZKpFCx95gRmsyEnxdE3zrR3FQxbFWS8sJlxvDqzLaOlsyqkKJU8wmVfrjT6LwPnSl4mYYyhQCg8ZfHmlRSKq7SpBJBj+lIddUupWNo4KdyUv0t8p1BhntYvsFir5kQYQwRVQBDqQQwOIpkMTf0Z/r+DhrPYhvREjhu0XOfR7/SlahCOYK6SilAKCRTH+QufCz866AM4Fx2/GBISW3xWRZsaYmyvs2r7zBwDWRTCMHTYxWBsM137gv2qvqFzPJvyjCoCP6Al8IlwJIQm5AyIqXxwrhbbNg6BIHWvE9XzfHJNEo1Hh69E+z8WhC0tmkfpA25fpEyflKz5wXZTLo5fTjzioHtUaXSNhxpuT5oCu+ILoweiabNb6Xawgiy7cHGmg0c3pu4zV0Rm+JTzoDgqm6v6gP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SStDYXFFR3h2aElEdXZGUXB2cnJiN2p2WTZpc3ZBZEVzN0FCWlM3Z052ZGNN?=
 =?utf-8?B?cEliL2JoS0Jpb0ZvK2RTTjlXTFBGYWszdC9aVWlTNG5WZWRNRVh5TU1QMGRL?=
 =?utf-8?B?Mk1pZUZBSlFiVURVSmZpNDROeHNXZXdJMEY4RlJva1owOHVXbEc5R0EvL3dz?=
 =?utf-8?B?Zm9qQm45MUlvaU1CbzVjNXI5cTBpNUo5NnlYK01SdUNZVzB0bFZFOWtNOWNC?=
 =?utf-8?B?ekwyZVQvS291OUo4WnpTS3Z0V3FON0cyWGFPSkZ1QkVGem1LRUx2RFR1ZUh3?=
 =?utf-8?B?UGhPck5Qbk9YNVdrUFh4Mm9ldExySVdSOHJwZVhyVDdiM1NqUWtNQzRrQVhr?=
 =?utf-8?B?NTIva0FhZWViWEs5SmJoYTA5cHdTOEd0dHdmT2k2VzcxTStwd0EvZCtzaFhi?=
 =?utf-8?B?R3daZ3I4bVVPZEpiZ0YrdXRndDI3cFZuZFFWUVlqRDRvYmtuWi85czZ4UmVQ?=
 =?utf-8?B?YmJEbE5lblZ1c3MvWVBQU2xWbTk3WTdjcVR6WUhpV3hXbU11VS9YZzJtb1pZ?=
 =?utf-8?B?Qy9rTTBRaXd0M1JJYkpRZ3U0KzN5WGlsWS90VmFyVmF3dGxZUDl0a0pZMjFo?=
 =?utf-8?B?ZWJSYS9GdEFoNE5EemZGYWJrR0NWaTIzcWM0ZVFJR0VqVHJTYWlaWkhuRW93?=
 =?utf-8?B?Q0dBSnRsbDB6WURJaUpFeis5UDNmSW5tNkVFbVQyQWVYOGhRQW1iZ3duRjhG?=
 =?utf-8?B?WWNLb2Y2eEJVQTBBM0Q5OWJhSFVmN21IcFJHYVd0Ukt4YmY5ZzVMWFp3S1lD?=
 =?utf-8?B?SUVQclJ2ZFdKMHc4Q2ZncTZqVmhacGl3dGNBb1dKcG1WYkxZb3l5V3JRZWNs?=
 =?utf-8?B?eDdYaGw2RzhlY0hFV2VZemk2YXFuV1luUDFrYWpOZkt3WC9nV0w4aTB6OWM4?=
 =?utf-8?B?SGZZL3Q4cE4zbHZiTWxCeDJGWXkyWU90VTluWDdTUGJXNDZiNXhtcUROdDJl?=
 =?utf-8?B?MmxUVWNPa2RSWC9WRmp0Mlk5QTk2aWlvdmVkSE9kTmgrM0JMMjc5M09yTlBu?=
 =?utf-8?B?aERCSU9DMmJ0c0xiUlFIZTFKaGVPWFpQcnFicGpQbVVqakFhMXAzV0VHQ3Vi?=
 =?utf-8?B?T2VtKzhRT3VKbG9Ua1NHNFp3Z3BhZyszbHVrQnRVRmYzQzlpTUxGVnJzY2tk?=
 =?utf-8?B?SmQzenRGanJiT1kvTm11aERqVGdzZXNWMlppb0xiNmNFMCtjcWt4K0poRUhP?=
 =?utf-8?B?K095dHNydUxJeFVPZFVwWFA1UlFJSXUvR2o0YUlUT0lhakwrZkIzeU1zVFA2?=
 =?utf-8?B?RU5GSkRDTlkvY3hBaHVybVp2NkVha3k4cHhPdDZLWVJuMnVPUW9DMzVXanQ1?=
 =?utf-8?B?T3dzMXY3VWUzclMyTmM2RE93eWhmYXk2ZWhiWWU0T2h6dkVsbit5UTg4cmVt?=
 =?utf-8?B?Mm9aS29DQXhPYWp5Q2t0ajVGbzBLSEZHQmdpa3JSSE9qNnYrTEVLdnNndkNp?=
 =?utf-8?B?WFhMcXlVYkF5cmRPK2R6QW9iQ3ZaZTFRQXBHc0lnZTFHMndiVzFrbTB6NVVW?=
 =?utf-8?B?WExKUTY2Yk1ORjhVYkVJZ01XNzBPdW4wN2NpTDVjUFpkR2o5M21nMmlZWGd3?=
 =?utf-8?B?U3c3N0NRb0pPOGV2YVJPSzIzTUxGNzZxUk1xdDRUMTk1ZzlKTjVNeCtNSXJJ?=
 =?utf-8?B?NllIMVpScU5EK0NpOHlMSTkwWTNpa1ZzSng0S1J1RzhBR2d2cCsrZDgyRGQ1?=
 =?utf-8?B?Z1NFMmowYW1OdzRHT2FlTVZZWEhROU0rQlhnQXlKRzYzUWpWR1dzc1BGY0x5?=
 =?utf-8?B?L3R1bkx2dnkxVStpYXF6c0t1eFlia0wzdzNhUHA2ZW1keTdPUkRDaFdOd0E1?=
 =?utf-8?B?eFEyS3FESllielFZTGYxZ1EvdTZhTUFtTmNQTHJERDdDdFhjRDZlVmw1YzJH?=
 =?utf-8?B?UElSaGordUdFWktJc1NobFhRdFA3L1E2aHZOcERMcmFUcnBjNnZkRUY1SDdS?=
 =?utf-8?B?VTc5Q0tIdUNoTndYeEcyT2Z6WGx5TTA1SHo3eWtHL0ZSNVB3S1d0K0wrNHJN?=
 =?utf-8?B?NzIyN3VVempWeUlOLzZGSllYb0RUdnpSUk14TFo0VVIvdVo0Yy9GR1V5ZDN2?=
 =?utf-8?B?RVRZbjE1czJicFdGVE5JQ3dQQWZyelVvUDhMeTdmTmtyTGx3R3l3Nzd0SkRD?=
 =?utf-8?B?R1U4eHNWUFRKdVpZUXE2MFJiSjhjRyt5clJqRVduRDFWMWtPam9sSDFHRGRo?=
 =?utf-8?B?T0pFWG12Wkh5TVNCSVo0a1BqOFJNOU5aZmlCYnJ1ZVFocEdRa1NlcFRxdml0?=
 =?utf-8?B?eUpLek9HZ0ZxVDhkeS9xaXFpTUtFQWlRTzVVKzdiZS9IWlRSS0pmN1cwYm9U?=
 =?utf-8?B?N1Y3TVFhUHhFMDM5RGM0SjZmTFFjSGhVSzYwM1VaTTNybFFrd21qdz09?=
X-Exchange-RoutingPolicyChecked: AfGGlSe1vYkQ4+Pn1e7Fyxgec9e//SGvia6xJTaoBxLo5JFCPQTKkkGHEzCqsQ0eTWTHklhP7QgcWb3nIIH1uwTV2pZbekfXHLMRL2FDi4myd5+YmiFCtpr/Ho3UDzxrkw0efthXv9Ocv9/MIB346vk91/5Sxegn3jJk1+egaasXuEMFSVNqIp+MiO0vCZFUWQyfjD/qhPOJ6KoWDisvJz663/P93drOt0owoH6gAv2nK4VBHAzNdZJsVSS8wGo7TC+uDO61VdKAVYCtEFNvds/ASolAgIF34G0SOWwQh3XqDnd0HEWdxxZZM1uNhiLkaTdhYNTRzvOQOA3mqL3e0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e0c787-e4b1-46f9-6d56-08debfbedf05
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 09:19:24.3322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7Gsl1ITRlcKxBE8zK5xx1oasHSb1yZi6mPvUJUgcfdzJFhDqyYcHLlrDF+hSEPKPWwa1lJnrEMQU2zZJ+ZzLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6749
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	TAGGED_FROM(0.00)[bounces-293637-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4A91461C6CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/23/2026 10:30 AM, Raag Jadav wrote:
> Hardware errors should be logged with HW_ERR prefix. Make them
> consistent with existing logs.
>
> Fixes: 01aab7e1c9d4 ("drm/xe/xe_hw_error: Add support for PVC SoC errors")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

LGTM

Reviewed-by: Riana Tauro <riana.tauro@intel.com>


> ---
>   drivers/gpu/drm/xe/xe_hw_error.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
> index 5135e8e4093f..4b72959b2276 100644
> --- a/drivers/gpu/drm/xe/xe_hw_error.c
> +++ b/drivers/gpu/drm/xe/xe_hw_error.c
> @@ -223,9 +223,9 @@ static void log_hw_error(struct xe_tile *tile, const char *name,
>   	struct xe_device *xe = tile_to_xe(tile);
>   
>   	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> -		drm_warn(&xe->drm, "%s %s detected\n", name, severity_str);
> +		drm_warn(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);
>   	else
> -		drm_err_ratelimited(&xe->drm, "%s %s detected\n", name, severity_str);
> +		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);
>   }
>   
>   static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
> @@ -235,10 +235,10 @@ static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
>   	struct xe_device *xe = tile_to_xe(tile);
>   
>   	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> -		drm_warn(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> +		drm_warn(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
>   			 name, severity_str, i, err);
>   	else
> -		drm_err_ratelimited(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> +		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
>   				    name, severity_str, i, err);
>   }
>   
> @@ -255,9 +255,9 @@ static void log_soc_error(struct xe_tile *tile, const char * const *reg_info,
>   
>   	if (strcmp(name, "Undefined")) {
>   		if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> -			drm_warn(&xe->drm, "%s SOC %s detected", name, severity_str);
> +			drm_warn(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
>   		else
> -			drm_err_ratelimited(&xe->drm, "%s SOC %s detected", name, severity_str);
> +			drm_err_ratelimited(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
>   		atomic_inc(&info[index].counter);
>   	}
>   }

