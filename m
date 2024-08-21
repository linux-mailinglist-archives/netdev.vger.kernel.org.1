Return-Path: <netdev+bounces-120750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DDE95A870
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 01:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34431F22AAB
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9805917C9EA;
	Wed, 21 Aug 2024 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFqpNwcl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DAC17C7BB
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283668; cv=fail; b=IsGFdpYydn/E2rK8ANHdM9TvwacGmJ0a1oZlehCJ1gbJWAZkEUw8osiK/y7NvOntfZ8b3AbeGdMB/y01wrwj1F+aOi0p2Tbi7SLkDSVTfI2NOBsOsKGvjewXPjdk9ePFk9UErPptiGIv7aa8s9fMlTWsEjXStFRnaH/QX6H/0JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283668; c=relaxed/simple;
	bh=fYmbBpJnC1MkIjS3PA6bydotHeDdgONXaem+gBrQ9u8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fzMKk6u4YGls+9EzRXscxeszMu34GCeF8SK183kjD1D0SSzniCpY9C4olrFHDuIEjIpNyjvTUrBmD+GNaMIpPloTIo/vDNI35P7+hO36RVFppPt+r2BY47cUs1yav/RofZF1dt4KcKFEBFmkiz5Z4alEdvQgIMmIdEky9Rtz5I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFqpNwcl; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724283666; x=1755819666;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fYmbBpJnC1MkIjS3PA6bydotHeDdgONXaem+gBrQ9u8=;
  b=hFqpNwclSN7dLN0bxQs+i6dFRaS3yifgEX/cqc2jzYjl45otNmVi0DSL
   OrdDMKWNxKqzYvRO7xjpGcUuAC+0zIhut3eEdUf4+govpksNPpLude7dt
   wNS36SoTelO13EElep3KdvjQIcufM+fmyMP55WmIbBjiqdSQffw/glukl
   PGQcYwrbtr4nJCmO5WWtbpimRSuX0dAM6pkUXx8xSOlDNR4S8CYrvsSYY
   iWN9zeopGTTqKXkJ8Xy30FQ2wp6RgvyspwfO92VagJXcyDgcJJn7ILN4b
   ulcQ7yQvp2w8JXynUAVeh/9sXafY+SlTTpHnkXhIbf1qwNgMrsLbm2ueQ
   w==;
X-CSE-ConnectionGUID: qKMdmwnOSJKgArAWrgt/6w==
X-CSE-MsgGUID: inxaQlUCQcqjinfarKZdrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26540428"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="26540428"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 16:41:06 -0700
X-CSE-ConnectionGUID: zOlV7TenR5KMj0GvsxQhpw==
X-CSE-MsgGUID: 8uIqgZQCQ/K455+pyr6WjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="91988327"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 16:41:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 16:41:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 16:41:05 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 16:41:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJlBOgcLYLka9gD8jhR+dper73id8oKUOYw+77pKa+AFFV4aR7dfzXoig/Edg22X8RfGndNppnpuOgL0hKPWj3dtXFqxVFDmUved/xXvRh4qhY6JR9uiCfXzW7GeDCes4F0rO0zzK2tnGHHJyNDncXaDprneE9sgg+jfvuuSu9XfcygZMKQKWj4sObVC0oF+wPK65EVoD6UFGoYNGtF6poTTpv68SQqY6pDAr18QYy6ZD8NrrteoroLhkaC8Ua1wKkYZ2NbCKXGGiI8EV0uweKDmAojSqEWkhu2Pu1LgXIMmJVJPH0dxi6Vmar6l4eHbmmV73N5xCE7+nQ6tDMnk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8h20I24GjdNzW3/D1iqAt08syM+/Y9k61dLJ8ioDSg=;
 b=KUHBPVdzDRz0CdpaFhXTl7XHGJzdXtgd3f28+IYXMWyrvDAOoNqXQz9jGbDqd7zczDtmTZewmW8CWlWF0pnRRT3ke/OnSftePXjPNHfwVkbjnmtxUmbPaXLwzQIQ11MYpHWA+ZfVt52yDWmO+ITl9Lvsun0Y53IZXcuurDtgdR4Ng1sqf1BlZ8EhXL/9ZadfCwnNZeTQaHOvMyp7EbAnVWGJqGs0fBJOPfjiblMY6anqDeRTuMZvIQaadwimTrsjp3YnPok/cL49xFCwd8VsQek3GxFHFEIBvma/zykYw33DKqGbdUiCRpfZhMwBj0JX+hAbnWh+C+WMRukoupYKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 23:41:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 23:41:02 +0000
Message-ID: <7f9c481a-28a9-439f-a051-5fd9d44aa5a5@intel.com>
Date: Wed, 21 Aug 2024 16:41:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: lib/packing.c behaving weird if buffer length is not multiple of
 4 with QUIRK_LSW32_IS_FIRST
To: Vladimir Oltean <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com>
 <0e523795-a4b2-4276-b665-969c745b20f6@intel.com>
 <20240818132910.jmsvqg363vkzbaxw@skbuf>
 <fcd9eaf4-3eb7-42e1-9b46-4c03e666db69@intel.com>
 <7d0e11a8-04c3-445b-89d3-fb347563dcd3@intel.com>
 <20240821135859.6ge4ruqyxrzcub67@skbuf>
 <0aab2158-c8a0-493e-8a32-e1abd6ba6c1c@intel.com>
 <20240821202110.x6ljy3x3ixvbg43r@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240821202110.x6ljy3x3ixvbg43r@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 8892f768-2545-49fc-4cdf-08dcc23ab79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFd3amVrY1BQSUJFUmZEdXBrcjJIRHlyOHdjMDErVHZzTlFXWkpDd0pJdVlv?=
 =?utf-8?B?eTc0WGFWMkxJRkpXK1FBajd6dnpSMVpVSHhiTVRnSU10MmNRbkZlNE5PQlBG?=
 =?utf-8?B?OU9BVVMyTHJOQjBuUVU1b0VJdkRyMkFkZVRMaVBGTm5VT0plVTc1bTZFN0Ex?=
 =?utf-8?B?Z2VGMXdKdzN6OS9ZcmhzM0FJSHFtaFVvVWZCSU4rNnh3YlNVS0o4SDNYTlhu?=
 =?utf-8?B?ekJNenM4Q0FkWjZIbCtjRnRmVHZKWEUyeldwc3BJQ1pFNFFiN3lscmx0ZWZW?=
 =?utf-8?B?bkp1c3h1WUVhdG9VZ092by9JMk5hYk9YWWJKbDFKak94NUpUazVybEowL2lE?=
 =?utf-8?B?cDBMTlovU01SV2dYb21oTGdrZVJXWjdDanRVeUpwMkplT0M0UXFvWGJsV2ta?=
 =?utf-8?B?QXBCVGVlKytuMEdUdklESlNLRVFuQUxWK0Vnc1NFZmYxdDVqUmRIbnA1QVpI?=
 =?utf-8?B?b2pkZFBIaVVWMGN6MitzVnpLUHVpT3hOMnI0UjA4NnV2ZWN0Q0F1VlRQa0hG?=
 =?utf-8?B?T2RCUGlkbmNyMVdUK0duakFDQVhxeGZ1UjdOMkgwa25uMVh1OWRHSUUvN0dm?=
 =?utf-8?B?UGJKZG5zb3R4czNmdjVObVAwbEFJUUplaVNRL2FTQVFQemMzZjUwdkxuaGFq?=
 =?utf-8?B?ZWtQYzkydktJQ0FmVVl5dXBtbzZiTmp6djVTYXlVam10bjFHeFNpd0pHZkd4?=
 =?utf-8?B?Wmd5NDByUEJwdGx3ZWlkM1ZNaStNLy9LMk1jYzVSMnhMd1lzTWtETTJra0l5?=
 =?utf-8?B?NkVXdDVGcFo0emJaYzVHZVdsb1AvMVZBZXd4SGJrSXpUUmZhcmh0R0RSWUZr?=
 =?utf-8?B?a3N0T013SCttR0hhVXNvbXAxS1dROWJiVmVoTEwxUDhnampkTEdZMzIxbVhv?=
 =?utf-8?B?OWYwNStMVjFkVXBxU0RzbDdoNEJmSURoNEhKek5Qb2s0VG56dGU4bklTaEkr?=
 =?utf-8?B?dFpjM0FoKy9iYm1yQlg2Y3lRNXYyc2haRm5zc1lQRjl4OEx6bFhESmZUU21w?=
 =?utf-8?B?ZWV4eWh2RXVURDAySXRZdlFxUnQwRjQ3MGJDcUZSRDJTandzSGpydWpGS3Y0?=
 =?utf-8?B?alZuZWUrcFNnZlpXWlp4SDZhbytvdEtJcjJqQ0pISzZ0b282ZlhQeE8vS0hT?=
 =?utf-8?B?a0pUM1dDNC85bG1YWnNFUGMvWjV5bEN6QUw0N0JrMmdnWHEvcmZGQ1VoaVFR?=
 =?utf-8?B?MUJuVHFFYk00R2pZMzl1YmZBOUJJbTZIeGMwUG9qWWJjV0k5YnpNMVJZMlE1?=
 =?utf-8?B?ZzJGZ1EyRFYzNzg2Q1NoR2YwRDBVZ3Vrb1d1MStybnRRaDZpS1p5T0VhUDF1?=
 =?utf-8?B?dmRWQ25ZUWJQanhxUzkwUW9QOGRmVFBXa2ZNcEFuVUlkUUNLbjlyQ1dwL2lm?=
 =?utf-8?B?aTFLd2prTmw4K3lSUTBNa1dSTlBmbGRFZ0VSczYrQTZCT0xOdnZuVDRsTW0v?=
 =?utf-8?B?NFpjVHR0MGVmaitWUlNZZmthZG5BZkVUdzI2Z0FaSERMMGxkOXNGdlRBT24v?=
 =?utf-8?B?SUpPRlZRN0MwR05EVEgzVDg4TWp4b0VJZE1XRVpJUHI3Zjc0cFM1N0ZFNlZL?=
 =?utf-8?B?Y29tZHVvelk2SXdudnh4dVFCWlIrN212RmZ5SExHWnV3VjBRbVorZ0tvdXVX?=
 =?utf-8?B?THBRRVpQMWFhck5IMkppb1dDWlhNamxEZlFiaFRFcE5NNUxTdXJSYXprNVVu?=
 =?utf-8?B?OWFKRHJ2Z2w0Z0pFZkR0RnNOVW5IVU1tYXY0cldzNWp0aWhBaHprNmV1dTMz?=
 =?utf-8?B?aUpmblo3Ym92akhFUGdZcXF1NGFhN3ZSMGpyTmdzUStyZVRHaFB3ZnRXUDN1?=
 =?utf-8?B?c1VCWFRjQmcwS29MVUVoUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlhRRnpJSDZ6a2d3Y25pYTg0QXRkeDZrcHlNZFNsYWxqb2FyQUthdDY4Q05E?=
 =?utf-8?B?S0ZZbGliMXQ2Y0d4SExRcUt0ZzRoR0RiRDNyMDFYR1lXV1YvNC9VYzJaS1Fy?=
 =?utf-8?B?Z3JSWUI0UFNpaVhCanYvUHp5SUt0amZqVzdmUnVzSWxUUStRWm9tUjFiRHZC?=
 =?utf-8?B?M2FhdU9Dbk1HUitkcnhQQ3lJakJEWExmcysySmNkY3hWQm45SGh2Y05sMWMy?=
 =?utf-8?B?bmEzZjA0Y0RQTkpLL1R4ZUtkNWFwdHJTOGlVSVlaSUtZcUVEcm9zYk1CVFVW?=
 =?utf-8?B?eExnMFdKL3dZZ1V3MWdVaWRIYjZ3cUVCVGVkSmxUR0ZkekR6U2Y4eHI3L0JY?=
 =?utf-8?B?YndnQkd6blp2UDB4ZnNRNEFSNk9uR0FGRDFXak1XeWJUanRPWnBncld6VDhj?=
 =?utf-8?B?SHlMVGlXWUJYVkVXdXhadmdseWlydzJuZysyeUVrc3N0Y2h2bVNYMVNlTGxz?=
 =?utf-8?B?Q0E2S29pb1pWcHJCTWZVYnlmRWF1anpYVnpSODBJK0loR1NkdjlveTI3YjRo?=
 =?utf-8?B?aktlcXN6RWRQVGFuWWR2d0Z2a1N6QVVrK0FnR3BXaUUxR0lGU1crOW52aFkz?=
 =?utf-8?B?OWI4QkZnRnh6eG1JcWxpaXJCVzJDS0JmdlcxRXIwRVB0OXhvUEtEcjFqdXI3?=
 =?utf-8?B?ZWtsdUFENG9ZeHZzZDNOSnNDb3RBVnZhcnZrbHRPcXk2TGkrenFaSlRFR00x?=
 =?utf-8?B?ZjZWREowMkcwY1ZxYmVGbGJKelV3MUp5Z055S0RjdjdKa0J4N0hFbFFkNmRV?=
 =?utf-8?B?eVhQOVYzaERRZ0NqeEliK1J4Q2VKSStBbEZZWFBxTnZiNjE4V2xQbE0rSFVs?=
 =?utf-8?B?T1dOQmtMSWc2UnFMUUltQzBBcmhvNXcrRHY5bVVPdnp1TTM2VHltRUdIZ0JQ?=
 =?utf-8?B?NTZNT3F1WDlScnpiM3FDSXdGb2dkRXhoUjd4Umw4N0Z5d1pkbzdDeGovVEow?=
 =?utf-8?B?VkdLQXJjWklKL3hOSDcwSGdZK2FsUldhdzFSQXdZTEpPRHEvcG1rRk9ObDVr?=
 =?utf-8?B?ejcweVEvb3B5ZTVMRmhSOGc0ek1EKzUvMzlKc2ZDczlxOUJZZnZGODZ0bHFk?=
 =?utf-8?B?eGU0M0E2V3JDTzhvWkJmeHJ6M0dabEJwOHVub2JnVGN4aE44YU1lOWp4WGt4?=
 =?utf-8?B?aE8vb2dRZjk0NE43TE02SjZpWE5SVERnUSszVUZOWjI0cE1JNU9WT1QxNUhl?=
 =?utf-8?B?TlRsd0NlWXlMTTRuUHJVV3c0MTVNbE1vdTJEOXJGN2VxLytFVFVQaUlKUjRE?=
 =?utf-8?B?ODN2SDNkcWRLMzBHUWxVazJJV09kWGtNaHVRWFZ0ZFFvT29xdDVGRkRBWkRp?=
 =?utf-8?B?cWovUzM4N0g5K0FEeDd0czZKbjkzY0lxNE5TOVZEWWhURGNpV0RCaDZlVzNl?=
 =?utf-8?B?OC94UEErdUdRYnlzbk5xRHhPR3pDVFhoYWhleTF0dlV5SzA2THBEdlpoSit6?=
 =?utf-8?B?eHM1Sm1oc1JkZjJsQW5KTHZmMDVyc1VhL1Jac2s1N3B2Ukw0cGNsTnhKMGpa?=
 =?utf-8?B?c0VNdUkxdHRZNWx4Unk5NmR4cDRWT2pVdUthV2Q5T1JRNG1ySzJUQk40Yzlx?=
 =?utf-8?B?YnE5VVlVSWcvTEQvUnJueVZKOXBTeGVOUFJUK0grTlhDcStBaUQyYXhLdHVz?=
 =?utf-8?B?SVFFSTYyVjl5RXF2cFVVSCtyZXhDbDJLWHhNb3pybnhZdlFyZ1UzNXJ0ZVo5?=
 =?utf-8?B?OXJ4MjhZMVVxR29CSDYzWU5NSUFUQjRFbmp5U0NzMDdQT2pqam1wSTFFeElk?=
 =?utf-8?B?KzdLS3cwbGlRYnZ6Mzh5UEhrc3V1Y08vUitGQTJrWURrMzRuSkZZbEFJektx?=
 =?utf-8?B?cWdUT0tTQU82RXZ3cG5hS2dFUnBTVUowc211K1hkUHh6cVJxck81ZFFoVWc0?=
 =?utf-8?B?YXRGOTJ3eWtOR1FpSmMrSmorZGlXVG02cFhtUlJJQ2cvTWtxeGk2czl2SnpU?=
 =?utf-8?B?VHRocS9ObWk2cUFzeTFJcEZ0bDA0TFMzVkNKeWh6M1ZRZ1gyUDlxb2c4MXAx?=
 =?utf-8?B?US9FMXFOY1crUm0zQ2ZnZGJNRUdLeGpvNld1dU5sNzJ0YkVGZ0s3WmlEMFhQ?=
 =?utf-8?B?TERzRDQ2SFdkUnNsUlpqZis0aDRRUjh0NTVpcS80N0RYUHQyNWNDUDg1Z2Q5?=
 =?utf-8?B?QmZzeExmTGJ4cDJlTVBTUThXeGkwcGt4SFF5bG0xbjlvdmkvOEtuTGxQbVdH?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8892f768-2545-49fc-4cdf-08dcc23ab79e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 23:41:02.6095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJf8moWW8fEh2Z1+9FCdUvCM7DlFrVGCCwkheqUP1qCbAzX2vgLBc3qVy1ZvqjMU1kuUhP1fqxnTuUXS4t1qKa3GlsaCQGH51Mle78/slQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com



On 8/21/2024 1:21 PM, Vladimir Oltean wrote:
> On Wed, Aug 21, 2024 at 12:12:00PM -0700, Jacob Keller wrote:
>> Ok. I'll investigate this, and I will send the two fixes for lib/packing
>> in my series to implement the support in ice. That would help on our end
>> with managing the changes since it avoids an interdependence between
>> multiple series in flight.
> 
> There's one patch in there which replaces the packing(PACK) call with a
> dedicated pack() function, and packing(UNPACK) with unpack(). The idea
> being that it helps with const correctness. I still have some mixed
> feelings about this, because a multiplexed packing() call is in some
> ways more flexible, but apparently others felt bad enough about the
> packing() API to tell me about it, and that stuck with me.
> 
> I'm mentioning it because if you're going to use the API, you could at
> least consider using the const-correct form, so that there's one less
> driver to refactor later.

Yep! I've got those patches in my series now. Though I should note that
I did not include any of the patches for the other drivers. I'll CC you
when I send the series out, though it may likely go through our
Intel-Wired-LAN tree first.

I've refactored your self tests into KUnit tests as well!

