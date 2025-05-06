Return-Path: <netdev+bounces-188439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AF4AACD75
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB0350438C
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E48283FC7;
	Tue,  6 May 2025 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WG2BEJBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C4F2820D7
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557330; cv=fail; b=Ri5QcShjcFg8TRieXv//51QEXtaHhSizKRSaxe+hNMDuXsWQFWFXURwOFOJVo27IDJBKUkOiV99H6oQFM//h3Y+03XPdgQ4o8ULuO5Td5jM2FsP0UUuzhyzVhN2rfYQWFKVDf5I7kxMI6S7a5oQZAnBJDJd/bBHS7wVXoEIARnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557330; c=relaxed/simple;
	bh=ef6sXi6jJVSqxOyJCO8vldDLcEIqunDx50TIXMXo96E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FNQSBo9+ZaUUBh2ZwoDx13avRdUjCcgHSx3CRKdna3hXv8spMIJYk137Q0rX1dNw1OeOPsm+LcNjZ5XZWB742RgMqb98kLRNGcS59roRzg84x5jF0ALun3h/14Az7Wp41cwr4JiRz+wFRmwQiGAsLEn2is7G3Vcb7CrdafMH34c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WG2BEJBQ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746557329; x=1778093329;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ef6sXi6jJVSqxOyJCO8vldDLcEIqunDx50TIXMXo96E=;
  b=WG2BEJBQ9PI33E7xfSsGrB+SdjqK2fFPCcfjOZq8DbXA5c79I+yrY+2U
   kd5suvr72c3NC5+vpmZv4XtBzYQA2UoI2z9cqO1khUN/340bkuBjIr+0S
   jT5Xpcgv/WmXfBqWdnov4e9eQrSArOYIJGJah8pHz9uzACP9yzl/UHiAn
   xjse/JN6a3z2tLHcn/yg71UhGjcG0fe6w7zzc/5ZZhxaxvwaY7FV73NN2
   ES7x9rzsYGlVVL6ti6nD1PI7Ow1yYgLgjRCojyDYQ6+DABl7z6AJri6Fv
   SmQ2xMTHZMDpy+lo9grur6nqXKafTNjKO1SL031Sk1SDdfuoOKIEyvtid
   w==;
X-CSE-ConnectionGUID: VMkU8xgxTbyvlVVUMAsLTA==
X-CSE-MsgGUID: h5YQbdneSX+2g7VQ1gV3aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="58879297"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="58879297"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:48:48 -0700
X-CSE-ConnectionGUID: AtYjbO2rQL+MT7hgPcMLCg==
X-CSE-MsgGUID: gGmG1YWnRkeHpCrFKtyDDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140815212"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:48:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:48:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:48:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:48:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehOIYObCYZ9tt1anFLzDDC0vMp16KKPB54MNPmxeiShCBeJHtR+E5GfipHiSXxIJKeNSIOKvJgDDZotH+zWQRPYaeI9aVghBGDNOne9wDYLnTiE6SGQXcPpS021PXGh72X+qejnN3wnNykkMPFQq0cfI3Iyz2GglXOJeIgZMa1imMyYD/1gheF6O6fsjHnemmrCl74yp+pSGqBOfgNEVE+WG4b7GTM4M3MBsz4p7+fwwWSjS4DGGIZlh2I+AfPIP5fRC0FTK1RtG2L2KnmR/nXN91A8XApL2kcnpgLBYFm1A0Vk4GIponH7H1bjgCMQIgzbsK/itAYGeqxPGejJN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PC68uGcpiTGZtNmzM22kdwF0sEIzxtHQqtosgjLJbB0=;
 b=i7n04aG2O4qNjUnI/L/9kA9JiNQnhkRDDQI+SU7oo/ylHr3eDg9MOHHlJ/HdV+NIJwPYEXfLSgNg75RAVnc8rvm1scrzwCG/CLCRTpi5cOiNavoN8JWA1xL+RUpUHxQuq5KrkMnYcZ3P0LltV7ygrSof0y572nldnnWt73Juksgw8GsBavSjjUFd9N6DJfLE7T0aGAx5mgfhQKJVpL05B0gLRnLxRbk6AftV14DILBHg93LM+krvsPkU9Rl6lWYIEORMeD9I6jCBwtWPHDyxAT6AjZkGFR2QznX6PAX5cJ8boc1YR1bpJmcT9m6MF677K66/KmA7TVuiMHNJ4r0kZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CYYPR11MB8388.namprd11.prod.outlook.com (2603:10b6:930:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 18:47:59 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:47:59 +0000
Message-ID: <4c437280-dc4b-414b-af6a-fa8fd2ace523@intel.com>
Date: Tue, 6 May 2025 11:47:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v2 3/8] fbnic: Add additional handling of IRQs
To: Alexander Duyck <alexander.duyck@gmail.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
References: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
 <174654719271.499179.3634535105127848325.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <174654719271.499179.3634535105127848325.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CYYPR11MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 869c7b54-19af-4c99-b77b-08dd8cce8601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFE0ZmtrRUs2anhoOUpWcExBbnB6b1cyblYweDZ6QWFzSTY2UVZDcU5NMzkx?=
 =?utf-8?B?YkR4QklvU3Rmc0JKL3NDMUVDS201SUpoOHY4a0J5bWhLTEVPWWQ5MDZNL2pH?=
 =?utf-8?B?RFltSG1Yby93NlowREdwcDFLOUNWTmdwenpJWkFHbDBoOE1zYVBwZktrQjJq?=
 =?utf-8?B?RHF3UTJiZ3FZYlRCNEVxYTBIZTlKTk9kbGxid0FsTEdXM3FSNU5tdXNCaXJF?=
 =?utf-8?B?Q0dYTVNZK2hxSEhGVmRBRXEwU2VuajVmMXhGRk9ya2hvZWN5VVJZS1pBTmNp?=
 =?utf-8?B?NkpvSEsrQkk1OU4yR0dEUXNCVGtxREY1ZENPcDlFNFgxYWpGclJjWS9QYkNS?=
 =?utf-8?B?NUFYcjFpMkVxclp5cm9TSCtMSXpmSy9pUUxRSGp5QlduVis0cWlGeHR6b3Jn?=
 =?utf-8?B?eWhNUXpZY1ZBOXN6Z0ovcVowNG95eEdqaWZHc3dnWFVOamhycGxuWDFSeUdx?=
 =?utf-8?B?TnNsTHludW5Pd1BnMFFUWHhYejF5eVdvWUVuZ0RwaW8reEJWa0Npa0hwL2w3?=
 =?utf-8?B?bUREdzNKWHdJMFo4UTFQc25JRHBsTFpVSDhoeWdPZlprT3JtaUQvcTI0YlVP?=
 =?utf-8?B?VmU2dHZXNzZ3dGhNVXZSd1IyRUlWNllGdzFaYmNMYU5Zek5xOVBGVElVY2ds?=
 =?utf-8?B?WHBOWEFqb2RkRE1pQmdGL2xQVlRwTERsUkt5OTQ2SytzcHlDZ2tHenZkY3pk?=
 =?utf-8?B?Q3hnODVRbyticFJtMlVvdUJmZEg1VURLUkRxMXY0cHoveS9zbWJWT1BDSWtw?=
 =?utf-8?B?ZmZUOEJGOGtWYXhNUEJrV241Um5xNmoxL203NTdkdGFRZklpd2EzZGkreTBh?=
 =?utf-8?B?STZJSGloRWNQeTl2dnM1YkRQUEtDOUxyQTlDakIvWW9GcCtKb004RUxPQTlp?=
 =?utf-8?B?bmxRd1h6Wk45Slp6OVd5OUp1VmJ5RHdrek0yQlBNTTZTc281UlZGY0F5YU9t?=
 =?utf-8?B?LzkxOEEyT1lhUTN0R29SNVdvR2Y4YWlsdFRVTlM3eXFEUVJ4ZEVDTzhPMmhm?=
 =?utf-8?B?QWVPSTdHSC9qSHcvdGsvakhNMXhBclE3elpJalpVRVJIVTZ5M2hGWmw5M0RH?=
 =?utf-8?B?ckpDay9NdGtPdHIwcUFKNjlUUWkyZWZZS1JqVkFZRVR6bXF1RWRMR1JBdGhB?=
 =?utf-8?B?ZmNZUUN1ZjdUb0s4ZEZqRWJ6WkF4ODBSME9LQnVTdmZYTGN4cERtRjFoMDg4?=
 =?utf-8?B?dzdYOThjcDYwbGRhb28yUjBLb21TaGIydDJNWE9YcTFDK1FTT2c2MVhYV05X?=
 =?utf-8?B?dmVvWTRsaUNCRlFxVmlnVHNuUlZZVDVGUkEyMzdBVlZ1UFJiK0o4KzE4dHV0?=
 =?utf-8?B?RXRFWWU2anhBek1VK3JKMjBLeEhUNTd3dTFMb3NkQUZleW9DVFZvYnpjYVNF?=
 =?utf-8?B?cjZCMFgvQkNVU2dsSFBnS0htRnRsVk5oMi9WdytaY3JLaXkraktvNnZKYWVh?=
 =?utf-8?B?endIOGIybmdYc1VLMzlYKzlDbzM2SGlEWUJHeGV0VWlGS2pLVmFKK3dXUmlw?=
 =?utf-8?B?NnNHdVg1NDlacjdCZXZKK3FwWnNLbThIZytZVzVSWDl2Mnlhc1E0RkVESDZr?=
 =?utf-8?B?bzRLZzJ1NzdwNlE1OU5NQ3c4T29nOHNCbzFZU0ZKQVZFSk83MkM3emlFSHJW?=
 =?utf-8?B?RjlNQ05GTEVQV2owUHU2YXFJanpWOHRPaUZoTUltOTRObk8yWDh1ejVVbEh0?=
 =?utf-8?B?eDVXWmRjcnErb3hOV0lXSnp1TzN4UW5rcFhOTi84WlNwK1l5aU1YN3I3bWlK?=
 =?utf-8?B?VDBPMHdGN0oxVFh1dVFtc0JRRU5TSHFUWGFsNGpOZlVaZlNwSjM0TEZiSjYw?=
 =?utf-8?B?SjEzN2wzbzM3RWprR3VkamZ5UzBNUEN1dEI3Zkd1SFROTWsrekphMmgxZFZI?=
 =?utf-8?B?eVZhWU84K1p2ZDBJUXlwMGVJVUlGOVpDeFQxSmtoeEwwbjJsNkFzUjZpQmZO?=
 =?utf-8?Q?3Z8271RBCwA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnNmM0FHTm5pUWdwa0l2M3hKdVA5VFdNWjlhclRJWXNkcFEyNnpxbEczc2tH?=
 =?utf-8?B?TUExZG5JYzNrcWtrK2QybUw4Sm5LOVBoWG1nTXZKL1lQRWowT2hQRURjQVh2?=
 =?utf-8?B?TThnUkpzTjEzWnJEQi9qemlOb0NPQmE5SGQ4cGEwQ0JQS0J5eGFjWFJCOW9Y?=
 =?utf-8?B?T2MwRVh6YmN0NnYvY2VEekErMjlyUE5xRzFnc2piL21MY1kyRjB3QWlQWFU0?=
 =?utf-8?B?QjQ0bTMzN1N4T1UzVnB2UE5KeXFjL2xwc0NrSEFWc0w4YlR6ZUY1T1laek5U?=
 =?utf-8?B?dHI2ZHBxb01VUUtDWnVNQURFTFloNUFZMWZ6clg2L2RRZXA3MzhQSkthTXlT?=
 =?utf-8?B?MVU5eDJPcHhhd0llUjlJRU5CU2Y0VFhFVXJjNkplaGpOcjJ3LzZzZlF4TGwz?=
 =?utf-8?B?dldhRVZpNE5hM0xxVnhXMVhuZjVwUXg0cTFyNXdPOURxRXdOUnFYV01hZ0gx?=
 =?utf-8?B?d09FY1pwSWpiWmxYMHZqNXBIMlFyREFTa2dXaHFudkh3WlRhUHh3MWJyMU1K?=
 =?utf-8?B?cDhrVWREOTVKaUNiNERZcS9VNFdXQXIrbkZ1Mmo2ZkpQNjh2a1BxQU90SDRm?=
 =?utf-8?B?Z3RvTkdRRDJNZ3BDR1VHZWxtazRNbHFqeW53djZEMzZ1UzNhUkp4Rm92cjEz?=
 =?utf-8?B?ZzU2R2loRTB5emw1VHhNNlRBbWY1bmlkYW85YUxBOGxJak5QY3FPekZUTzRP?=
 =?utf-8?B?S3R0aW5qd2F2QWNBNGdCYkh5MGQyT0dTcHRDYnlGZVBCTTc2eEZ6UU83YW1R?=
 =?utf-8?B?RUJzc1dNNk8zeGRFTFBiTms4ZXdYZXRqQ0g3V1ZNOGFhaUJVc3Z2Szl6OFJF?=
 =?utf-8?B?QUw5d3ErTm1WMkszRG5zYXE4TjVJazBSMWh4UlVabktPZ1lGd1JydmFQbU0v?=
 =?utf-8?B?VkxpNGJMQ0t1aWZTMU5qUDRLQ0Q0eDVFeTN6RklsQmY5OXVqaUtwbzFYbjdt?=
 =?utf-8?B?MGdjSVZ1MmpjZm84OEVLbHM0Y2tuQlZlS3lmV2dsdi9va2VvVWx5cFBXMHZL?=
 =?utf-8?B?WlY3TExDMWNtZGY4MzRVK3BvcGQ4bmZIb3ltdXZycUZKVFc3azJhSEwyQ1VZ?=
 =?utf-8?B?U3h6VWo0Z1dqam1aa1ZWZWpocStFVG5CN0tDUWhoMEwyUnRaMFZTWXB1dE9v?=
 =?utf-8?B?QktzOXBvNGJ5YS9GbWFTMzdXdXhMQ016SGtQWmN1MUxneGFzM2grd3ZVcUxM?=
 =?utf-8?B?VHZDRGlKUEdwcUF0dkJqaTMrdHpBenFrUGIweHR4Rk1UQ0tiQWRaZk0zV1NM?=
 =?utf-8?B?TUgrZDBLcThZR2tqZjJPUVBadHlnb281TWorajluMGtEWSsvdDF1MDIyY0Fz?=
 =?utf-8?B?SHJXYXRCRGd0UWlYL1Y2ekozd3lhUkVwaVZIQmVsY3UyM2xya3pNRWJNdVRG?=
 =?utf-8?B?YU1ET2pOdUN5bTdWR1RsM2ZvR2pPWmhUK2tqdlZwc09oOC93WGRqYkt1aEdi?=
 =?utf-8?B?cjlmZzBHaUlzZGtuM0RxTjlBZUlNZkZZQXJpYWFCMHRtWERyNXNxSzFXRjFH?=
 =?utf-8?B?a1JvVG9Wb3JzS3kzZ0VEczRuZXFKSUJYb1dmVDUzcW1IRWNsKzVROW9RK3lt?=
 =?utf-8?B?Yy81REJldk1vQ1BkWmZMb1hCcjltK2dhaktRNlBrMTV4bHQ1Q3ZZUTlRUmNX?=
 =?utf-8?B?alNUa01rdmxtWnVncFZMbi9tZVNXcnZ1N1ZFbnA0bjlSTEhxZ1p5blVWYjY0?=
 =?utf-8?B?TC9CVUI3SzhEa1QzbnB3L3NWMWpCTHR2alUydlBSY2dmOXlUMlJvSHNjMk5T?=
 =?utf-8?B?eGFSQ0dxcmhtclV1SFNGSVhFUFU4LzJ5R1Y0T2ZmUFJ2ODJEL1BPWm1kTUQ1?=
 =?utf-8?B?UU9qelpRMDdaQW1JRHlESHk1amhDOTl6K0JtS2c0ejZqQ01UYlc4bHUrVk9Y?=
 =?utf-8?B?cUZoVnFiSmtuQWpSbitzRTNHQVd4MEliakY2RnM0bzRiTkJxTGcxcnJXaWVi?=
 =?utf-8?B?UTdIblhVdXppZlJUbGZidE1TOUxxREY2TnFZUzhUWDI5NmJvZkJMb0NkNE1Y?=
 =?utf-8?B?ZkxYUjJjL1ptcE5rdURyNU8zNzhvRTg2QzBra2JZSjB6YXBSSVRpeUNvQ0Zr?=
 =?utf-8?B?SXBuaGhwQ28xNHJSckt4UDEveHFCOGN3VUsyZjk3QkVBSDNBZzRIZGNXTkpt?=
 =?utf-8?B?dzAxWm9KK0ZxZDRIQklxWkNvMGpLSGt1ZitvTjRMSUYyTzNxRitWUEo0eFZI?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 869c7b54-19af-4c99-b77b-08dd8cce8601
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:47:59.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3c0+mTvtvP3Y25UUwkOsNV+jJdAirqqLNHyFfLumAeWRRqAXFlsLDyv0z2aTtWKpUUWI59wx8433uZN4n6mBoH+HSrZYXoSFtsqictiLrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8388
X-OriginatorOrg: intel.com



On 5/6/2025 8:59 AM, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> We have two issues that need to be addressed in our IRQ handling.
> 
> One is the fact that we can end up double-freeing IRQs in the event of an
> exception handling error such as a PCIe reset/recovery that fails. To
> prevent that from becoming an issue we can use the msix_vector values to
> indicate that we have successfully requested/freed the IRQ by only setting
> or clearing them when we have completed the given action.
> 
> The other issue is that we have several potential races in our IRQ path due
> to us manipulating the mask before the vector has been truly disabled. In
> order to handle that in the case of the FW mailbox we need to not
> auto-enable the IRQ and instead will be enabling/disabling it separately.
> In the case of the PCS vector we can mitigate this by unmapping it and
> synchronizing the IRQ before we clear the mask.
> 
> The general order of operations after this change is now to request the
> interrupt, poll the FW mailbox to ready, and then enable the interrupt. For
> the shutdown we do the reverse where we disable the interrupt, flush any
> pending Tx, and then free the IRQ. I am renaming the enable/disable to
> request/free to be equivilent with the IRQ calls being used. We may see
> additions in the future to enable/disable the IRQs versus request/free them
> for certain use cases.
> 
> Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
> Fixes: 69684376eed5 ("eth: fbnic: Add link detection")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---

The function renames make the diff quite noisy, but I agree they make
the new implementation easier to understand.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

