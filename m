Return-Path: <netdev+bounces-158833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1878A136E3
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F96E3A7290
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466221B4F0C;
	Thu, 16 Jan 2025 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXVJzifO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C754145A11
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020745; cv=fail; b=QYdMg3msjO1YSTsWYdf1U/L1PrhBTiNoHVCLUuB7TKRro+6EhG3JC9JObkqmYVcAaPmItjpbgE3FaMRo2XmMIEHns3EYWyKF803rxLizhFBLkMjfktOv+YiXJn/A3lIXGYguqIOkMULLnJSjZdv6hAcANbDbSj+X8EQjv25m2/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020745; c=relaxed/simple;
	bh=ktunQyTnqJG8V3w42nMJnjfszEM90v8F1uX5aAjgVOA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TiWuYFWoKpy63bbkTm8bcth6jo2FBx05mGk5yDXeFPgdcHToUQaIf8bMg/m55dHrAPID3gPSNw1Tbu5fiKCRRYz6U/JKli8TnZf5PODCTv5pl71Z+v0jIrakrFmU4dtICCKdsVQtPR7PYAyt+FbqbWpOYm1OknGPbSLB+8lcPE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXVJzifO; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737020743; x=1768556743;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ktunQyTnqJG8V3w42nMJnjfszEM90v8F1uX5aAjgVOA=;
  b=IXVJzifOueBproiEYkK4RJLerYl+6SvzzSgB6OMyviHFE1NF/DDymEWn
   k80B88/RgPrWA7e0X33P2jMoZoKj7J7+nzp5CkytqgysqTErRfnmqNSnF
   wJxUIlnDZ7C0+t0lM01X36syRZpCCMjNJvQpWoxX+JpexvE8IC1a1XPQE
   yheic7LqOh9xPTTXRMloHw52/SrWghXCQlSbwf8rPZm0neoRh8pVu7kHq
   IygHrE5LnvGP9S+OcEHhV9vwgrUFBR7oy9lyyajH1WzX6ylEeQlRoRSLE
   hnmqmNp7FIj80xGDIfoqrBnUspFmYaGOrRcNtpKL4f6UXV8ng3Dcew/HC
   A==;
X-CSE-ConnectionGUID: I9/mWLrEQTawcriOxcH4nw==
X-CSE-MsgGUID: DZGb8s3TSWOJPNQIULxgQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48055726"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="48055726"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 01:44:49 -0800
X-CSE-ConnectionGUID: KQf+mghsSXKHqzyNUgf9Ag==
X-CSE-MsgGUID: DYUQIjinQNGe69Wghc93GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="110408782"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 01:44:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 01:44:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 01:44:48 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 01:44:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdXsW9UNLSwMqEXs72WaCZYrZYbNqM82Kp51SgUfP9HxhnqM/Qkm5XA+WgAqSiWDtgwRbmVeKaZbYAiBLfHuSyAgSX054jbLmtNTN2ApihAztmOk6liVTv35tzIKR3jWnMt0HlycPXOXf8XI3ig9evHrREMBqaKN0mh5FYvMDWdDiH5pRkdW/EJaPseRHgHtECy0QB48dj4iaOObqNXQIUhuJP3S8+o4InScM60FoZTZ+tggAfEGxSZtYxlcPwACqt/TXHpnH3pHsTHe4j6sVHfAFfV69dczHcAvz/nju3KymHn/Ok4QWxPlIDaLkS4JWK7sYJMDfh83n4+LIO60OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+LHc08mOrYDdekwohmklJgO+1aEADTcyo5uHkEZUGs=;
 b=o3z6Cz31xGMJhoyTDNv9GWWflMao7rQAWxxBle/Kbj4DKv+kLe8CSrc1CU+Y8lGr7jY+0rt622IO9iQadmb48Ask/id0NTc8d7wwlGvhsaytIayV4FSaj4rYwfq44PsDVwpRNLG1ZR967ZPjzoOVBYDOzb5JHXT5hEZ5fUdOPmIZr+C1QIwBYeHXwbBNH82wYzxXfJgb2NYyO/0cHe2nIm/TJbvZjxx86BnWnzG1Ke/ykUOhcMHUDRG6zblNodWvFlg7vGpt13Q6mxLcz4leTDyB0FeiRnr2Su7rqGWX0UoOoQZmeCOTSuEOf5EezZiZnQ2LucvJH7ajNwMK3bvVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS7PR11MB7906.namprd11.prod.outlook.com (2603:10b6:8:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 09:44:46 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 09:44:46 +0000
Message-ID: <8fdd6e04-c7ae-4d2f-b984-98d41d4ef8bc@intel.com>
Date: Thu, 16 Jan 2025 10:44:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: avoid race between device unregistration and
 ethnl ops
To: Antoine Tenart <atenart@kernel.org>
CC: <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
References: <20250116092159.50890-1-atenart@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250116092159.50890-1-atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::27) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS7PR11MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf51af5-d383-46a3-d612-08dd36126937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEU3Z05kTW5LT2pzRG9XL09KSUZJbTlVK2hGUCtTQW9rM0IveDhCbkVnTjNn?=
 =?utf-8?B?bmVaamVNRW56YlRFRDNoMkdzNXg2VWJrR3NWcjBQb3NhWUMzMHhJb2tWQmVa?=
 =?utf-8?B?K3dDeWI1OU9sRVA5cTVBUFZzZEk4SFFTT0E1NFROTjZLZnVPSGJoYVRrTTd6?=
 =?utf-8?B?T3VBS21teVZQaGczYjhMVjdHQWRtMGxWQjJUZEgwanpjV3VaRTVKRncrdWFk?=
 =?utf-8?B?VnNrejdwOFp5SittbU9ic0lLbVNvbWNxS2hhUXdYdWtDN2VocnV6TWFuejVi?=
 =?utf-8?B?VUdabHVhaGdDVmhJdGczVlo1QUlPYkpTdHBGTU5JZytuMnFZRURCaXh5U28x?=
 =?utf-8?B?SEo4Wnk5RFJ0R29sWlVrYlQ0Um5BL1pqVmpFNlhWU2RhU2VLZzdrRm5RTGlG?=
 =?utf-8?B?VVptS1lrUjh6amdoSzVKZ0JaK3FPMVMwbnVhaDFTSlcvWXBsNng5Y0FMUW9s?=
 =?utf-8?B?NnZUK2s4QmtzWC9OUEEyNnA2Qi9JSVZubitoTmJPaFk2b0ltTU1nZ0ZyT3d2?=
 =?utf-8?B?eStpVmpaUkl3OWRTU09FUzJzeGhvQklpK2xuK0p6RWRlT2NWdXpLbU1OQXRG?=
 =?utf-8?B?OUdWUnZEWUNLam90OUlnaEJSNERtb2hmUjRMcTUwVWxsS1lwWURubEVnQnkw?=
 =?utf-8?B?V1ZVdUQra2dCa2R0VTFpL0dKS2hwcGJOWmNPc1dKbzl3UjN6MEx6NjJxWEFv?=
 =?utf-8?B?ZnFkKzVkUTE2WFI5dm44cTlLNnVnNVEyRG0vWER3SFlMMjQ4Rzl6RERYcitN?=
 =?utf-8?B?cEUzTUZxam55SU5admJtT1BiQXhucDgvazV5RWo0dmFNMXEwaDc0ZVFVeVpr?=
 =?utf-8?B?Z28zSitHMExrTXRBK2RrT2RvcWtQNUZTeHR1ZmdOVEh1TW5xSUJKVDVSMWVq?=
 =?utf-8?B?bWtTanpWNkxpcVRRNmNiM1htRElTQ3ZaU2JsUGVMMU0yZHdGNHYzd0RqVFJV?=
 =?utf-8?B?UDZlNXdNT2c1SVhJaXZtNDVyU0lsajQ4azN4UHpheWE2dVN6cWJmS0I3YS9H?=
 =?utf-8?B?NEJmbS9RcEZzRmVpb3JWWHl5dE9oSWdJTUdVK3JzL1ZBeUV3aVpNNmc4WlNh?=
 =?utf-8?B?RDBDUVJKTEtwL1V2ajAzQkFXb24zTWRJZGllYXRmaExzaXZRVThNU2Q0alRK?=
 =?utf-8?B?aXd2WnhoRnNGeVNiL09DQ2dub0FmbHJ6RFJoWmhNV0dHNzVCRkp4aUhnNFBC?=
 =?utf-8?B?aWs5c3V2cDM0VWtOanVqazlsMUlVaFNYWUVNbnBoY25NbXRxMmVGY1p1VlBr?=
 =?utf-8?B?b2xWMmRKMmt2WTROeVIxeERKa1c3QThlN09BbHJ5ZjFMU1FGMzFtTnBOK0V6?=
 =?utf-8?B?a3hYek1nN1JleGI3OGJkdHlQVVM3eUcxOEwyNkU3UUxjczhJcVY5UW56Wk1Y?=
 =?utf-8?B?ZXE0UWFyWVJrTDJnYWF0VU0zSkJNWk9HaU9TYW5YdUx0YWsvVFVqYitvWFo3?=
 =?utf-8?B?MktHYis4Uk1IWkZraDZZVCtlZnV3YUdsNmdkYzRsUUVzeWdvbFV3dkZOOGFp?=
 =?utf-8?B?ZE1OSGpXQ0YzcWZNTlYwM0UrMEhCTkg0emQ5aFFIUjd3MTRhWmxtRjFHZVVH?=
 =?utf-8?B?WFdyRG1MYUJrc0VWRVVGQzZjeG85RTJkQ0FKVEg1bTNqZzI2Q3FIbjFCK2Iv?=
 =?utf-8?B?R2tqRmVWMGs4Q2VxMDA4aGVsdVB2NExRVmx2MWc4aDExWlhEQmdHRjFwZmEv?=
 =?utf-8?B?VFFMYWtyQnI3b1RVempYN1A4L2I1TWlZUnErbFU0NU00VzRKZUZqSktYTzJB?=
 =?utf-8?B?VGtGc0tlMjgxekw0b0J6UVI2SjZqbVpodUtBb0gyS1pvUUNraFJ0bXhxSXox?=
 =?utf-8?B?Z3MrNWdXakhnTWE0WGMxTnlsWFZsb1U4L051UFl2ZFpxbE5XUEFVV3p2cTlL?=
 =?utf-8?Q?ZtZ7/1zViy2GD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEREVWRNY2tOajAzNDU3Rk5CcnJTYVgrcnpHZGRheHkxdEdLSnJ1TU00aFRt?=
 =?utf-8?B?eXBFUk5DUmVqWlZuMGVCaU10U01aS2xVd0ExaWZJK0NocURmTUxMZDh0YkJD?=
 =?utf-8?B?Vi90bEpNZXdGOWxTVi9FbjQxWlBNN0NybDFwQmVQcDdmYVp3WHpQalVnZjFP?=
 =?utf-8?B?MkdPM1hwSHdsQnRJaWtQbTNtdEdGZnVSZGxqUkx1T3Z6c3RLS1kzREtUekFr?=
 =?utf-8?B?a05DVExiZ0JOMjJtZU55cHY3RWFUVlBaN3lWQStMbGlmaWNxTzhlYllFamJN?=
 =?utf-8?B?VGJLa3Nqc1V0aytVK0tHU0xYSVZMWVhPVmVWVXRPRExNaFM2QVY3bU14M2Jj?=
 =?utf-8?B?NzBkTlY4dVdON1IwclVGY2hHb2JMMmMvZEtLeDJmcXFRWnVWT3diZWF4eU8x?=
 =?utf-8?B?bERwQk92SVh1UGwyU2lvd1lMR092MmNsZ0FSSkhRTVRIYkgyZndXUUVNNWNH?=
 =?utf-8?B?WWJhdzNpalZQc2ZTV0J2TU9CdEJzd2xueWF3eDFUc3hTdUJ3SEladjJFcFdB?=
 =?utf-8?B?cmlQMFFQeCtjaDh0SkM3YVVwcTBqUTlJN0ZyWDl1b1ppREhjd1hUZ3RKVUo5?=
 =?utf-8?B?Z0xEeFNtN1N0LzJuOHRhUkpQYVJ6eUVEY1ZGb1ZwOTNHVFpMU2dNdnNZNHNW?=
 =?utf-8?B?SUVvbER6Qk5zajdyanVqY0JrNnU2THYxYnByc0tLbThFMlg0ZzhrU3lRZXFL?=
 =?utf-8?B?Yk1yRklOTHdhcmozMVM4NlRUelIwenZPODN3cU02a0d6Uks5RmwzOWRRSzJP?=
 =?utf-8?B?eWJvbzZCeWpuRzZWb2pla2Z5aDh2OVFJQmEvRzdUOWZ5dWZOdlQ3RWhRSFRi?=
 =?utf-8?B?MlJlZ3k4eDFOMDlEMzdWTWQya1B1emFYT25FeWYzRGhlRDhBeW1SbHN2Q25K?=
 =?utf-8?B?RFlTT3B1UXE2cXZlUlFhclFjMldMVFpXZ0g2Z3VDc0xTdlNZSTlTUmJmcWdq?=
 =?utf-8?B?SlVkd2N3STc4M1lOVmVoSjF6anVVR1I1TzRWVEdOa0hIdnBXdFhTUllLMXVh?=
 =?utf-8?B?YUFMT2J0NnJxUEhuaEpHU2FrKzVHUHYrMlFBL2h0ajFRa1YxbU5tWHlZaTJm?=
 =?utf-8?B?MWtVdTYyTytBWUtJTkRiRGIyb1lEdG4yZFJpQllPd1VJRTdsMzgwdXhXdUxB?=
 =?utf-8?B?djVRWVVIeERSMTBSQU9BOGpTamNwNUdCV3JpN1U0eVR6dHJ3YjJjdDlSd0lh?=
 =?utf-8?B?aGNKaWZocy9sZHVJYXFPVkQ2Ynd3Uk8xclJmM2pERVdxbUw2OFk2Vzh2U1py?=
 =?utf-8?B?Y2hGWW5Td3d4ZVZCaWxZRWVaRlJ6Z2gzb3JYMzQyb3Y1Z0dDYXpkUEhFU3pG?=
 =?utf-8?B?NmNjbnhIejNKK21aeUI5bUszcUVMTlVnSU1rbGEzeE1HUVh5VkdZYzhWcENp?=
 =?utf-8?B?ZFN6akMycHcxZHkzbFdySlg1NUIrK3BvRzd5a0RJc0VvVFNRR3lEUXdGYmhv?=
 =?utf-8?B?VWc3S1RYTmo3V2FBSlBJeEVrcGhzVExrQzd6VlBpSVEzLzI5RTdmKzRhSG5D?=
 =?utf-8?B?bytoZFhUK2R1NGp1R0swV3BFZStBUVlYYVJLeGNXWmJLUTk1Rk5GWHp3QzNZ?=
 =?utf-8?B?ZEY0N1dMaVlTNmxjZ2lRc3A0TUpJbzRzZi94NEY1eVFkbEgybTMwOG15NWhL?=
 =?utf-8?B?QThMZ3BRN1JVcGJwbzFON0pDMHN1ODg4VnN4WGI0ZDJiK1BFcGZRN1pKZFJS?=
 =?utf-8?B?MGxWQXdWNVplN1RjMW54Rm5Zc0k1VmNUSkFzd3I4cGhlUFdibUN5M0FYd1hD?=
 =?utf-8?B?WHFQbEZoLzRkSzZZWGQ2VGt0ME8zeE9zLzduY1NYaWl5VU8rZ3EvcU54WHQw?=
 =?utf-8?B?RU1rVzh5SzlVNDRCS3kxL2hEV0I1YWVlNWZ1b25ZcDdINDZ0RXF3Z1RwaWMy?=
 =?utf-8?B?c2ZTajdUbmhqaVN3SU5CcFVPbDRmMmRLYVYvcEFSUEFVenRUTmdXUDVLc1Yr?=
 =?utf-8?B?QmtpTXhFa3pZdjlSNG9BVFM0OWQxNUhWMC9tKzdCU3JXYnV5L0lUTVovUmJ3?=
 =?utf-8?B?YlZ1OGgrcWdkVzFieXAyeTVmNytaSW1YTUJvRVFGcGwwTnlCbHZ1QlEyMnFJ?=
 =?utf-8?B?V2VnNUNNc0xUeGw4bXpVTGFKMWx3RFA4RXhvUVdzUlc3ZnBja1pRelA5RytL?=
 =?utf-8?B?T3RWWFVUdFR6MzVyY2c0eE1yeHpoL1hYL25PZjEwWFVVTnZrR2loL3kySk91?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf51af5-d383-46a3-d612-08dd36126937
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 09:44:46.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCI13MZiQcg6SZULwx/3CnnenMhycOjaOB48Id/pjYwTYVL9jVpQYZqHxX7IUE4ZSi32ZdoN+Nt5UcLYLN+d/qO1bkZkBr/z7SUkfS0c6zU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7906
X-OriginatorOrg: intel.com

On 1/16/25 10:21, Antoine Tenart wrote:
> The following trace can be seen if a device is being unregistered while
> its number of channels are being modified.
> 
>    DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>    WARNING: CPU: 3 PID: 3754 at kernel/locking/mutex.c:564 __mutex_lock+0xc8a/0x1120
>    CPU: 3 UID: 0 PID: 3754 Comm: ethtool Not tainted 6.13.0-rc6+ #771
>    RIP: 0010:__mutex_lock+0xc8a/0x1120
>    Call Trace:
>     <TASK>
>     ethtool_check_max_channel+0x1ea/0x880
>     ethnl_set_channels+0x3c3/0xb10
>     ethnl_default_set_doit+0x306/0x650
>     genl_family_rcv_msg_doit+0x1e3/0x2c0
>     genl_rcv_msg+0x432/0x6f0
>     netlink_rcv_skb+0x13d/0x3b0
>     genl_rcv+0x28/0x40
>     netlink_unicast+0x42e/0x720
>     netlink_sendmsg+0x765/0xc20
>     __sys_sendto+0x3ac/0x420
>     __x64_sys_sendto+0xe0/0x1c0
>     do_syscall_64+0x95/0x180
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> This is because unregister_netdevice_many_notify might run before the
> rtnl lock section of ethnl operations, eg. set_channels in the above
> example. In this example the rss lock would be destroyed by the device
> unregistration path before being used again, but in general running
> ethnl operations while dismantle has started is not a good idea.
> 
> Fix this by denying any operation on devices being unregistered. A check
> was already there in ethnl_ops_begin, but not wide enough.
> 
> Note that the same issue cannot be seen on the ioctl version
> (__dev_ethtool) because the device reference is retrieved from within
> the rtnl lock section there. Once dismantle started, the net device is
> unlisted and no reference will be found.
> 
> Fixes: dde91ccfa25f ("ethtool: do not perform operations on net devices being unregistered")
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---

for future submissions, please add a changelog and a link to previous
revisions

>   net/ethtool/netlink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index e3f0ef6b851b..4d18dc29b304 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -90,7 +90,7 @@ int ethnl_ops_begin(struct net_device *dev)
>   		pm_runtime_get_sync(dev->dev.parent);
>   
>   	if (!netif_device_present(dev) ||
> -	    dev->reg_state == NETREG_UNREGISTERING) {
> +	    dev->reg_state >= NETREG_UNREGISTERING) {

looks good, but I would add a comment above enum netdev_reg_state
definition, to avoid any new state added "at the end"

what about NETREG_DUMMY? you want to cover it here too?

>   		ret = -ENODEV;
>   		goto err;
>   	}


