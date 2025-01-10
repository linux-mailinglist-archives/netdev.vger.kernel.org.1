Return-Path: <netdev+bounces-156917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A7FA08486
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 02:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1FE4167BCD
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 01:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE6D286A1;
	Fri, 10 Jan 2025 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drkca26j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377F015E90
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 01:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471573; cv=fail; b=jK2SdZdY0ZNw6JYlxo0Y/4fOGvcJm/NzGGP87pepA8RpZTGyTOg0D2o+tisFa/6rqZzrmTFmOce52vvQZ9NwfiF28BwtoBiOSOwyeDuKBqT/VseLVlnu2um3K1c1PKPgUyuov1xzfiRm8a+rbRvu4UM4Zcrv2g8jh2w+m7kCNgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471573; c=relaxed/simple;
	bh=DNdMevvnldC3iPuouUgwabPGUu0+yOnrqhSmgiG2EEU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bt5hhHKSntFzp72GgV/cxuxDQHzcfJohYyI5Z5KLViskyzfG7F/5RD65+hR846hCfM9vnIf31X36blVvlzABhB3XPK8DTF8GeTpl4r5Ca45v+ymzAfghYetLc5+uXwTWM6TBnV7m2m6jzU5cu8UalE516SD24L3hjHSURGvaMW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drkca26j; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736471571; x=1768007571;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DNdMevvnldC3iPuouUgwabPGUu0+yOnrqhSmgiG2EEU=;
  b=drkca26jkynT6sE62BeNXXfMtTxCpEWbpofrG1LY7s0YYiKhqVGKXG6G
   CfgCISAGxIWbgzonLCniNCic5hH0AJJJxzdaqRkB6veZKZhiZmD/Hy410
   e+UnTAp7Qt8Iujop0brsnf3I9OlKGjD0HwCAg9VZCjKG4Z1Sgj3IQhxev
   Lek4Pnzx9Lr9G5PP7KnxXf9Ejf9oUCcHVOcckw+YojFgFSnlKoj9yvrCU
   s6EeA3m1V96nrDyzuonLR2nVe6/jRlQ+CgsLmTibuFPc34EvILFA060nR
   GQm6vjaWbsoGfb8Y/78q53OdfgLiK6I/iWMhXAkbyrunlj+U+I5d6HaR3
   Q==;
X-CSE-ConnectionGUID: iUpun9/ARhKyb/IDyxqS7w==
X-CSE-MsgGUID: toihnEYvRG+xiZu5yKGN5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="47749126"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="47749126"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 17:12:51 -0800
X-CSE-ConnectionGUID: eOLPCG75QLOIJkfNfp+Iqw==
X-CSE-MsgGUID: HFNiWKiwQruaysJpSx7NXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108683588"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 17:12:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 17:12:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 17:12:50 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 17:12:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Srb8gGQxEAzEWfqPP3OZ4tIRjD8yZoYYOdxgyg9HomYwBd/mN2Q2lytoktx4KC6iJu54IK674F5YrdJUyH0to8Zgm7WE49hH3h6yR5ctlyLj0ekopIMXwPa3VgeZHEWmnm4RBajQMLFULaWY4i2QO0kjUENIQHTQVeIZY8fxASjLt9td5LYw8TpGUV2IOVTcNKVElgzfflG2oRHLvZbUPDMO+wx2LCkjE6aoGn7tCvhc8CRn54YA0le2wWQmPWPvksm2yvGtlBi+BDYm+rSiuHnJfnsZIreZL8veSgRZUMcwfSwE+sXrz0qRGDW1dd5wXS3sdRdg4b1i8FlHYLNB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz37Da8hF26IRaNgGqLI1MzaKrrqe9HXgtIc6hKuykI=;
 b=JWImMYBXcEzx5wMd8mkqrZEBum2Paw2kqRpNcctvGZXudBBFe9MMStacZ8dqCt82O9+/msUFVF7zQ7zOUgQP9WM04b1yg4N6HttLLsAXGPAEDedNl4kTEJbS8QFI+f3HbjEgq5YSdLF3uNo0Nyk08wSx1yuehkDjaBcltxarL3t6kvIZ7G0MoMXzmGmtuIESqjWNo5RKzZ2zaYQi72b2SUDqe2i9/iopg42zJVtyq64G5+F7LSKqbCzWjja//iWIRXwqDZDtEPtHVCo/b+m2RgIdI7xfinnRhWd+tMmmAYLvUMgRqmCAQQjFom3M2jRKBsu4sJoHLI6NEghEjZH62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 01:12:48 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 01:12:48 +0000
Message-ID: <e979594f-b668-4dec-a7e1-f7e60db07133@intel.com>
Date: Thu, 9 Jan 2025 17:12:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] r8169: remove redundant hwmon support
To: Heiner Kallweit <hkallweit1@gmail.com>, Realtek linux nic maintainers
	<nic_swsd@realtek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, David Miller
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
	<horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <afba85f5-987b-4449-83cc-350438af7fe7@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <afba85f5-987b-4449-83cc-350438af7fe7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:a03:167::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a5d8ff-e3c3-4c74-c993-08dd3113e574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUtwVGRTcGdNdy80b3BDejlZVlhUeVZoV2JzSmdjaElDWk1yOUc1cVgvOUhH?=
 =?utf-8?B?M3RGeHJYTWxDQUNaMWtwVjBIQXEvQmE1MmlabWRUWGo3Q3pXWDk5NlRzV0Vu?=
 =?utf-8?B?bUUvenlYcTB2TjhzdTZDMytEZStVS0pFVEQwVlBibFZidTRWNjBCanlCM3FQ?=
 =?utf-8?B?d3M0cGR6QzE1Y2NISGcxNE1FY0tGSUw3V2cxa2U2NzBHZTBmdlp6WUg2TEdj?=
 =?utf-8?B?MEFxV1N6ajIzbkMwenJzRWF0c0JqWUp1TWc1NkloNWJNaUxhNVRiUXd5ekY3?=
 =?utf-8?B?b0x0bkNvMkYwS1htM21tNGpZVWY3QVlrRUROR21VZFVMK3VMdTk0eWU3UVFm?=
 =?utf-8?B?RnJoV2FPbjNWWlBZU0hlTUZLay9adXk3cm43QThKVVVCVi92TEt5MW1HQ3or?=
 =?utf-8?B?ZE82QmRmVSttVFB4cHlIa1dpVUZQMWVYcFdtNllZQVVwNUJSc1R4R3hOOXYr?=
 =?utf-8?B?a1BPNmtwcVNJelhoWjR3aW9qWEpGTElGaGZ5SlFNUG1sMStNaFVORHRUb252?=
 =?utf-8?B?bHc0dnpTbHJORHlkcHlrZnNDTms2UGxoTU1mYk1CMzhGNDlMTWY5bTZDRDBO?=
 =?utf-8?B?MUYxa001L1BBeDZXaEVWWndFT3lpMlFuVnk5akExY3FkQm9uS1ZWRmZQcWlm?=
 =?utf-8?B?c1Z0SHBYTmNKbURrU2VDeVluQzRvRDZsTk5BNmcrQTNidldqR2NxKy9rYVE0?=
 =?utf-8?B?WVgza25rSnJsS0R0OTZSNEFtR2libk1od3ZLSHVXbEpLSWppNjUzUFF5N3Iy?=
 =?utf-8?B?UmJ5UjlLNWRxQ3k5TXlnVUJCbVVzTjlVQ3ZyY3pSMllDTmR6ZDYrd2dLa2xD?=
 =?utf-8?B?Mi9zajJyRnhxY2QxY0s5Y2UzSW8zd2hFN0FQc1hEQU1RR3hPcUxRWE04VFBj?=
 =?utf-8?B?QWFRQ0hjdk1MeFNVQTl1THhlZ3FXQ3FJOVplQitPdVJqaEx4L3UweU1HcFlY?=
 =?utf-8?B?S3c0Wkk0NG1seko5VFM3MGpRek00bDlEUTVNTldsYkozRm9lT1hjWnZiLzRX?=
 =?utf-8?B?cGZEVVV6M3JGTnFrVm1MZEpydk5rdnhHQ1EvVXEzMkNvRElTRWJRSFRLOVRU?=
 =?utf-8?B?VmdPbDRlMWlaOVk5RDJ0bm1qTkpYRURXVGVmanUxZWdBWGJqL2U4VVp0QWJ6?=
 =?utf-8?B?emJEQlJCU3pJUFIwNFF4ekxvTUw4SkQrNWpuL3pXNE5uNmRxTjI1algzUTBX?=
 =?utf-8?B?WHl4YXIzd0RhelJZZjlhaFk0NDNpcmJVY0lQa3RVeGdJOFJYaHhtdmVkYWVk?=
 =?utf-8?B?TUNGTkpnNkVLaHMrbURSVWdlbnlhZ3hqeGZhaDYzb3gweE5UY3B3LzRjTmk2?=
 =?utf-8?B?QTlDRm5qN1cwS1lXa2JoQ0QvYmJOSkc1dHJlSUlGWU1hOTNYNkZqRDhZT3ll?=
 =?utf-8?B?ZjBCSjBMM0Z0bTJMQXJSdGg2U1JKWUpNUzdRYUgzckpQNytmTmZuVXlMd1Jy?=
 =?utf-8?B?WTdHQ3htaHNrc1oyYUU4VkhzWWNCdjNLdnlyM3p0SE5iRXRCRFA5UmlNVUZw?=
 =?utf-8?B?WXNJOVZRTU1GRmlDWTMzMW5PYmFrRER4cHpwdVA0SjQwUm94U3R3WHhzRS9H?=
 =?utf-8?B?WHdzRXRBSFpDWlRvSTBDWG95MmlLN015NXUrQUhPeEorbDI3K0V2MWZncTd4?=
 =?utf-8?B?dkdSMjYxeDgvK0ErVzhyTm5XQUNDbGF6WlZrTWQ3STJsb2pGc01rUjFtMkIx?=
 =?utf-8?B?ZjFzN1NBalhlNWZuNTJtZTJNM1EzT2lBZWdtNWJvSURBcG1UVnhjMEtaOHR6?=
 =?utf-8?B?cmswUk0yZVhnYThtUktROXR1UkU5RG9hSkZBYitzSW93OFRxaE1kRFZrWExZ?=
 =?utf-8?B?cTlaM0tSYWVBQmd3ZGZ4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlJXaDR0cHNNRDMvL3FJN3cvQmhyQk5RbW56Q1dZUEZlaFpkSHRXY2NCaXdM?=
 =?utf-8?B?SG5ZME1TQzhpaUg1dHBUNGJPUjJxekVoQ3k0RUI1SDNXM1l2clZJVzI2L2lW?=
 =?utf-8?B?RjNHSk82dlp2UHVxNEIrSmhWZEo4Y0pnamhnNzhIWEt0WDVsZEdGazMwWlVO?=
 =?utf-8?B?WnVlNEJ6MStsRU0yM0JzWlNpMmhDbWJxUUhQVnkvNGtPb09XYmVLSXJBc1BF?=
 =?utf-8?B?VlllaWNzODJiWEYzZWNBK2paczJnTlRaQmdzNkxJekMvdi9KMUJDMkFHVXo2?=
 =?utf-8?B?TTRhOWZOSlBmcGRlWVBHMDR3Mi9KSGxQbjgxdVdlSW82cWRWWHFVSUQ3TzZy?=
 =?utf-8?B?N212YzR2U1pMNUdUQUxhaWRRaDM1SWtFVjY2RHEzT0kzNXpmcjU4ZUxxSjZz?=
 =?utf-8?B?MG9BZkVSNnZQSjg1bE8wcSt5VEY2c1R2U0VrWkp2QXBxbk11NDhrUWxDay9S?=
 =?utf-8?B?SXZRT015cCtWOXBEaEJBajl5dnFTZG5YUGNIQ0xFSGlOYVhRVnNpam5aUXpB?=
 =?utf-8?B?aFdKdUpOUlltM04xWjlHTnFpV3hDdnNPNjJVYUxsN0wyUE9hbERiOE1nOGJH?=
 =?utf-8?B?LzNZTFhpS3JJUVRQaVE5UGg0SWFaaDB2UUVEVm1nOEpnd3dKN3ZTV3BGeWZR?=
 =?utf-8?B?WFdTcmE0a3g1aEQ1ZDNOZHgxWDFTLzBZMjhJZUpWU2dXQ29KTVdtbytTRXhy?=
 =?utf-8?B?enY5czZ2QjdIU3Q1dzFsUFpIRlQzZm4yczBGK3BrOFlWWUlKZHZHdmYvSnA5?=
 =?utf-8?B?ZDNZNnFOcDMrdC83TGlIN1l2K1FHZHdkTTd4RWNhT25kcjlGZ0dYZGpoUFk0?=
 =?utf-8?B?dUh5eG9iTmhPREQyVVVnb2x5OHVPL20rMktzMExEUEMxRm16VzJuOUhXTVds?=
 =?utf-8?B?MlpzM1RIR0NUaTR3NXd3VmZlanRHMGlIaVNoVldibkwzZUt6a2luaHpJVDQ5?=
 =?utf-8?B?UUhiTmt0OUZtVWwrR21kdDlTT1pmSEx5VGY0cmhrTVgwcjg2T0hZbjV5Y0JE?=
 =?utf-8?B?SGwveGsxWVc2S3lUdUVHREFpVWYzWHdVNHhQV29xZVVDWHBzamlIWFZyM3M3?=
 =?utf-8?B?SVpQbU04ZWM5cER3SWl2Lzl5L2h1YWhtYXNjMUxIN1J4NzJpMSt4bVlRck9y?=
 =?utf-8?B?L3RLWC8yNURrTlkxdjFGMzArd0tYbDBBN0RKZFRGU2RzdzV5eCtCMm5Lb2hn?=
 =?utf-8?B?OWtXMDAzMDVIa3Z0eXBXQlMvMzNVOHNkUjMvOThSMVRFRU5jYmF3SEkwNlJ0?=
 =?utf-8?B?bFcyRUtqeDIxQUhzdUMyM0pCUkpqTXBTUWhyV2lJS2tHbEpETTkwSGxvUGMz?=
 =?utf-8?B?c3pTOEJpUng2b2JNV05JZEpYcW9zaGVkb0FoUVpsNjF2NFdCblh4Z1REU2RZ?=
 =?utf-8?B?akxtam5iYnpQczBPdkF4a3BZcURBcHNYYnRDUm5qdExHbjUwczlORkpWT2hJ?=
 =?utf-8?B?SUZ6Z1U4ZGh3UktKZGRBU2JKSUhvdUJaRy9YZTVNNHRJRnlzb2xHV2RUcHJH?=
 =?utf-8?B?aStkdWJkRkZ5endqaUdFREEvRDg3anlpVWRJQm1WbFdXeHVMVzZsb3dJMzZh?=
 =?utf-8?B?cVVjSG9WZjBlb0NjV2FvUEkyQTNEb3g3UVhsZEllSTZkR050RGxSYTl0bVNj?=
 =?utf-8?B?Q1MxR2w2bWNPS0lrVUFyVFhRZTJreHB2aUk1VTlHWW0yQk5aYm9NWXB5UERU?=
 =?utf-8?B?aTF6OTdPaXFDUUs2L2tNL0dTbUpwQmo4TUNlYTZKd0hVT3JmNm1Xa2Q4dlNv?=
 =?utf-8?B?c3Vrd2cxYndFbDlaNXA3b1I5bUN1Si9yK0lxWjVOL0lSZjRKUDdaYUdGWGZH?=
 =?utf-8?B?WVRlcDF2YTBPU25jNkQzU3k4dnFtNFQvbXQzWG5acVhMOW9BWm0rUTBPT0pT?=
 =?utf-8?B?SHBkZE5EczZaU0N6Ry9kcm9JTDI2bFg1ZlBhSHFGU1ZrM1BMZVdadHEzWnBB?=
 =?utf-8?B?NG9XMGM5QjJkaEoxYXFLZE9ZYytBeE9oUURndUIwdk9aWG1XaG9VaVNCVXpF?=
 =?utf-8?B?NjlYbldIbmpiaEl1dzV0SE1abDZkY1NDK0lqb01QTnVVQmxicWYrZmozWWtV?=
 =?utf-8?B?UkJDNVh3bzg1QUJnUXZpS2ZlamY4L2JvM2RNamVjZUgyTlM5NFl6UkFlTG81?=
 =?utf-8?Q?oYch8mFmlT7fGbGGfDbjcp/wf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a5d8ff-e3c3-4c74-c993-08dd3113e574
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 01:12:48.2065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /T714RnoU1zBlqjqYv6mi4WbHM71WlS7D/gfFFesHxm0fM4OJTPPfJJWZacm4w8NI3GeP+lFg6c2RmzJBAwZQH3GfPCRHkk4IUlLCL8q+WE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com



On 1/9/2025 2:43 PM, Heiner Kallweit wrote:
> The temperature sensor is actually part of the integrated PHY and available
> also on the standalone versions of the PHY. Therefore hwmon support will
> be added to the Realtek PHY driver and can be removed here.
> 
> Fixes: 1ffcc8d41306 ("r8169: add support for the temperature sensor being available from RTL8125B")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - rebase patch on net
In the future, please avoid re-sending within 24 hours:

https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

Thanks,
Jake

