Return-Path: <netdev+bounces-165607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E4AA32B77
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26276166A20
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5A621504D;
	Wed, 12 Feb 2025 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuOvoYdt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1F211297
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377324; cv=fail; b=RijoGes1ehEjI1qgSmsfHu5tnt0xpP7xack73A9mYPnOYoPHM7mj2WG7r1CabZtfNullbiYcyCdJd359OR7vG1rQE8M8dnXlKdD2Jkp0O9vF7+g9wTUM38HjVIYyI5YGclLjPcgU7//wBZtGRTwRqGPb6SgjjONnfTZAmdOlxA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377324; c=relaxed/simple;
	bh=NW8tgOJGfIqq0aNLBIHvlCDQAazMVjGyTBP7hFPAFhs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Es/94YqJNCUzXJzULID8urWFiWyKp5KEC0I1xgDZl/VKFIo8a5kwF9s23aZXRBe4Vq+hH+V4gjdDAZ4jtfjZymmglLnkzEK/T7mj0Cm3Y+BOf00xm6D1td9mnMC33GSgyhut58E0nh7b4kR8Zrhxc8KKEcccAqJGR1oc1i4BJMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuOvoYdt; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739377322; x=1770913322;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NW8tgOJGfIqq0aNLBIHvlCDQAazMVjGyTBP7hFPAFhs=;
  b=BuOvoYdtmjjmse4qwO3l5TIC6JFzd1hISDASed/zFwm25jGdUT6oCoTn
   NRcG3LqOIBhQiPgoVd/OLQIYzmkdJQnxqCRJfhydiUm2udpvK+zETNusl
   EsPx2bampfikT1RaO3Y8Vr3ioLkLciZtDrgnoqK6ls09WPqwe/tF78bhF
   JkTjwppxHvRHrEvPP872X5gEPYAyrKJTDEUv2HL828Z8rIPREd5WvrZEj
   MoXUiwXL+s2Z9eXpFFIs+zMrKx7sbX0QT74yFJH83RkI8RBJ5NyNkuOYN
   oJJGjXcQR3JWvQqb2U63Z3ldEXNPgVK1ug2GPtGGUrYoulkeJ1dfEMyNt
   w==;
X-CSE-ConnectionGUID: ZVaBAbl3Q46GUM35a9p6fA==
X-CSE-MsgGUID: 4GOB+GL2Sm2pLFvbCPJyXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="51438183"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="51438183"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:21:47 -0800
X-CSE-ConnectionGUID: r6YhOMUpR1KmgEcqqgUOLw==
X-CSE-MsgGUID: zRmq3JKiQHWHwPuoHcg/Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113773216"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:21:47 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Feb 2025 08:21:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 08:21:46 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 08:21:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tl0bMdXxiQf6/3lWwwhYJCGipehGcKONlYdr67ZBOOYrwuYrNv3Q9jXxap+MvSd5xrchXrp/A1X2DPNK44UEg6Rw68i02N9jVOCkJTnQz2CxrLoyN7Rq5rgKuHQGM5nYDupPob2P6Do0FuMMbuEWuoHF6Fj86pS6lnu9wAc6j+b36V/yhQ49z39VC2BdbUqR78D+uXkAwOLyupjeV5wqIC9LIiuFIB2JM2uUME9/S/fzI7p6v+OphTe8VxT7TL3ayn0BbCODaD9D3McUx1HfRD3j4MZiCuLkVajE1tazZ/SzCN+cSUIH/PgQfSgey83ffRJmG9OOMaZEr1XYgns8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wwxu+B61Q0EC3pbSqO/L3ZPDSFLyYpouK4PcvIieJc=;
 b=uV5olLn9ZJXh7palEQA+xGjcY2dfPvNO69FwDPrqlR3ODJH9M9YPxC1gD/FGOAVdOD8wuhAHqfysCnOKOtX7BT7qcls/HBL7noMezylW/p8r4OMghuujQ8ysDSNLYD6rFJQg4wIwdDxd2msVCnWODgDDaeOw5REq7H1v26AY5jLkIrShoy5pXlqzBmtyDR0D47wTUTcvJE4xJG3xXjeWl7WI3dZd/2Dzx66dDEQj3bzFCbbJaFQLgk+qb606MhbnBkxqqCGP2KKcHKM1xOeDdTSnI5A4/2hvjpNJbD/OLR5MsCx8P6nw9SK3ytMPlHZZHpc23uwclenO78KyQ78X9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL3PR11MB6338.namprd11.prod.outlook.com (2603:10b6:208:3b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 16:21:15 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 16:21:14 +0000
Message-ID: <8274ddab-51ca-40b3-84ec-29b2815048a6@intel.com>
Date: Wed, 12 Feb 2025 17:17:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] eth: fbnic: re-sort the objects in the
 Makefile
To: Jakub Kicinski <kuba@kernel.org>
CC: Joe Damato <jdamato@fastly.com>, <davem@davemloft.net>,
	<alexanderduyck@fb.com>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
References: <20250211181356.580800-1-kuba@kernel.org>
 <20250211181356.580800-6-kuba@kernel.org> <Z6uq_f7knvHIhFT_@LQ3V64L9R2>
 <20250211143234.1733c071@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250211143234.1733c071@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL3PR11MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 451d8370-f14b-4aa6-364e-08dd4b81452b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TE9VbFh6MnJPK0M0SHN3Ri80cEVlU21KMlZNUzZObjFNK05YWGQrRHp4NWYy?=
 =?utf-8?B?MGpCbk5GRHpPdXR0dWJmODBhRk5tMnVLTWttei9nTkFGM0tMODhudk0vMll1?=
 =?utf-8?B?MkpoSk94a0hrc0lFK1Q1VEI2Q2Vmd0EyTnFhWVNrNHVIYnJmUVllNEY2S2x1?=
 =?utf-8?B?TmNjQ3RpSlordUl0RzZLUGpQSHlvSlhrK2d3MGJvQWxJUVE5RjdmSUlSdHZo?=
 =?utf-8?B?cS9YZXNUVjV4NlBIU0VKL1R0OTBTbFF2M09aenBEbDBaRFFVUko4MkFjOHRk?=
 =?utf-8?B?S0plTkVDWGJSRm9KblRXVzEzakZ2SGZmcmIwSk9KVStSNGpHMndoaFN3WmFm?=
 =?utf-8?B?Sk5CL2NSZFlBYVNnakFzMWtXdWlpaUFtdFk3T2YyRjUzakw1cFcxNVgwbU9m?=
 =?utf-8?B?b2dwTUVHK2tFNUlhNjM2VC9PQ2E1S3FEd1AzWEpmWjFUNnJSdGd1VWZUNzJq?=
 =?utf-8?B?YTJzQWNKdm9xRSs1cGNEQkpra3dzUjFLWVQ4a1g0M3d2NWpuMC9RbE1CR0Na?=
 =?utf-8?B?SHgxU2hYMTFyVnNrTzl3RGViQjdJV05GYWFVaVZwRXJwV0RGaWc3cFVHci9S?=
 =?utf-8?B?QmZWUUhaeE1rcytEQkVXWTNTeEJKcHNNeWdDVTBrK3Rjb3AzRmxpblJ1WjY0?=
 =?utf-8?B?M3JkbWVNYkMyZEVQaEljMVhYZWphRmEwWUxsSkpMTG5jTGg0aVRBUGlqVXI1?=
 =?utf-8?B?Z1JsS3FsdjBrYlJaeG13dDBxSmR4OWJGa3dGMU1ramlEY00wUndXUlFqQzhS?=
 =?utf-8?B?NHpTL01ZbzZreFZDMjRXS1FXdmpDS1VnbklDUDFzeW1aSm02V0crcU9tTVY3?=
 =?utf-8?B?blcvWFl2dHFmUzByNkpOeTM1T1l3RVlFZ2o1WEtPV3FpV3pXejlkc0l2WE9z?=
 =?utf-8?B?QWZjN2N6VlF1Z3lHQmtGbjQ0RlpDc3ZoTmhYcWhDbTArTG9vRy91eUtUV1NI?=
 =?utf-8?B?L0p1ZHV6TitoL3RZeFlRSTZIOFo4Rmw2NmNWTkRVWW5ObnpMSGpBN2NucUl5?=
 =?utf-8?B?dklVZG5UalJXN25GNGMrTEdLdXBkNFM0RXIrdTR2SnlkS3NPOHI5dzVDT3VF?=
 =?utf-8?B?N3F6K0ppZnFQc2o5Y2pZbDZpRThySnVrdExEckUzQ28yeDFaaHpuQXVnSTEz?=
 =?utf-8?B?Smo5bGJRMW5xWFI1cDVqVmtDbU5BTkhZSkVrUTlkQW1MNmQ5eTE2L2duR2R5?=
 =?utf-8?B?S3Z4STBFNVpJTDJuY24vT20zWTljTHNWa2Q4MzBoblROZStETC9XL0wyZVc4?=
 =?utf-8?B?R3ZWcVBEa1RzWlFuaDNsaXMyRG1aSjZmb3N3T0llb0QvYi9OaytkcWpCVXdZ?=
 =?utf-8?B?Wmdqc1BiYVVTc3lzSmVGTUNxa1g5UnozdDFRTStWWVVqTFUwcWxGVEdPckYv?=
 =?utf-8?B?VzRCdTlPUGd4WDJMWmxMYWRia3dNUG04bUNjOVMrblE2OW4vTlY3U2ttZ3R5?=
 =?utf-8?B?ekFJUkRUTTF3ZUNvSGxUWkJURFJOTTYyRzNHdkNtcVhObUdaZEZZSGM3c01S?=
 =?utf-8?B?WWJOK0hCSFRqVmIvdWs5RGtmM0VmZkdCdDduZkd3QUpKczE1UlE5a1dEanRJ?=
 =?utf-8?B?K2x3Tnd0L0RJQ0hmdnFRVVhabERwWFRPdnVrUWJlaTNKS2JRaVduRWhwRzRX?=
 =?utf-8?B?YXpYaVdMdnBZNE4rVWFpTnZGaWM3WlNPTlNoTlFZRUxUQk5mS250MXRTZlBF?=
 =?utf-8?B?d3JFWlJZRW1JaXgzYTBCTGFBcE9hZFVuUlRoOUNIcnVOVHlnLzdNMEtuSTNp?=
 =?utf-8?B?ekFoM2hUbWdjQUNlNEROVjRhd0I1eFR2K0RsVEVtdWZic2srdTFzMDdqb1h1?=
 =?utf-8?B?RzB1M3dMaW84Uk5lUll0OGt2RDB0UktMUVNETmhRbDZHbVRIRU1HZDY3aTlX?=
 =?utf-8?Q?4wfpWUGgaePmn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGdZUFVFSmV6Q3VBd3U1RmZXQmptWEdkWDhnT2xCVnAyRFFVb1RqanJVNElR?=
 =?utf-8?B?M1JUeHVCOU9qbUJidFEyWlkycVJKc2MxaHY2bDBpdUlMMmgzVTNQcTB5S3l1?=
 =?utf-8?B?SjdOSjh5VnNZaGpiblpxQnF1UGNqTElRZ0lxNDMwcmFCRGl1SGg5M2NTK0Fm?=
 =?utf-8?B?aEZqVitYRHFGb3dxSG1FMnVYNEI2ZTJDQTY4VFJvOS9jSkJmeVcvd2xYbUd6?=
 =?utf-8?B?amNwVVp0SHYwVm1lYzdpMjBoZDhLUjlGZVhKbTRIa1VWVTZBVDl2MXFDdXls?=
 =?utf-8?B?anJXYjhTTWE0UHRDall3cnBQTGtFZktDRHNZUUs1eDcwYzJIam9TSXYzS0h3?=
 =?utf-8?B?Uzgzd0Z1UlI1bFhPd2hkdmttNUJVRWVtRXB1UmdKL3kveXRjeDhud0JMVm9h?=
 =?utf-8?B?bEl3d3hFUkxGWUwvMkV5UDlWYW80VzA3M0doNTRMOG5CZE90VXRVSFpyYmxr?=
 =?utf-8?B?OHF5bWZHNDkwRE8rczVCZEhpVXgwT0lrUlRGRGxkL2ozL2lqWEFLdUxlTGF2?=
 =?utf-8?B?a0U0VDVjb3lKM2d4RXpvM3pjays4WXBJdHRKMU5DcmtFYnIzWWR6K1dHdlJ6?=
 =?utf-8?B?N0Q3VEcrWmVvY2RvT2puL3BjQ0YybVdia0wrOTc3NklDb1JCNi9hV3hpYi8z?=
 =?utf-8?B?OEVod0JMYXhRc0kxdE9Gc0FYRHFHbng3RTZRZndpcFdobnIyWjU4SVpEbHVU?=
 =?utf-8?B?QmR4RjBRRVFyNHN1RHQvTVRZUnhnNjJPM25ER1JSMWpkSEcyU0lrWlNDbUhF?=
 =?utf-8?B?WTdsRzZNSGlNTFZSRmliSVdjNHRFWDdWRWdOY25QRzdsc0JqYWRPOFhpQzBt?=
 =?utf-8?B?Rkp0WXBFREQ2YjBEMHVWNnhCU003bE1vczh4akwvTEFGRERkWVZoMkpBOHh1?=
 =?utf-8?B?bHY3M2VSdW4yMkt0RWc5YlJWNmlxUWtFY2hvNHNlNEc0dXBOZW0rWnQ2Mzho?=
 =?utf-8?B?bmMvL0p1dnZUbXV1aHJPWkRwQUQ5ekl5b1BPNDBrWi95MDZEc0RUODB4T3J2?=
 =?utf-8?B?NmlRWDVid2lVZTFxTUF2WjV3RjFweTJUL2lUeEpoMGJ3UE8vRG0xdVJGR2Ny?=
 =?utf-8?B?ZmxjdUlMeEhnM0NyU2cyU2VnZUdwek9odE9WZ0ordCtQOHBiTXp4QkxjMnFC?=
 =?utf-8?B?bmZNWTVQZ2xtcFFSdGEzQnlRZmx0bzhmYU1USzFOV1lrcnM0UE5kdCt6WmJl?=
 =?utf-8?B?SjBMbEUxTnlnVnBDT2p6UjlmME1KZjliWG8rRjlJQUk0a1QwWGVNRkhBcnFz?=
 =?utf-8?B?ZWFPVG5HU0JqWDRxa0FQR1BUU1BieFNkbTJXUmk5TW45dW5BMHB0cjAxem5q?=
 =?utf-8?B?ZUhwdDJNazZJZGlsblB1djhpOVgxVkxVUHp2TEF1TFlIcFJnSWJvVnJIK2Z6?=
 =?utf-8?B?ZDZHdUN6QXVvTTg2Nm5jRlZiaHZSN2NrSWtsU1VyRzdpcGZwQVhzdWc0bzBs?=
 =?utf-8?B?aVpKVHMxMVRiSzIvMHBkYTh5Sll1OUFjTTJZRXp4Y2NWRmFUNXduKzNSaDgz?=
 =?utf-8?B?Vlp5VndpUGhQVnR1NDV3QTFrUmNPbUFCamJFNlArQ0syMVBlRTB2ZE5yRGZa?=
 =?utf-8?B?b0tZWTg4VGhuSGwrbHFpcVJ5RHdXaWJlVDdKRzhwaUJzbTZKUjhLZXZ2R3BZ?=
 =?utf-8?B?bCtQdy91N1B3ZWQ3TE80WkttZ2lFbXNVMUhRRE9WTURoVkQwRy9xQzEyVjVJ?=
 =?utf-8?B?dGt0THFPNTVKRExpclFrT2VQMFU4eE9TQWNaQlNvV2gra0M3dzhYV2VKenNU?=
 =?utf-8?B?NGV4YlVxczU5V3pDUG9US3ZYZU1NWmlxckN2b3daRkxQSXZJY1JuWUorU0JT?=
 =?utf-8?B?N2tjVVBpOWZlSVg2aWpsRGVpUTZxWHBzcWZOWmNBOVRNdVRyVFhFSXIrUE4y?=
 =?utf-8?B?UlpYUFJDOEhzclE0Z1pFcTlsTU9ERDNvVEZsY3BKT0loYXF4VU01ejZNZzRD?=
 =?utf-8?B?TlNmNXJGYUxWaEZBdHhVbFlqem9YMk5FWCt1SEpDaXEzSEJQS0hwOGRLL2ti?=
 =?utf-8?B?NGNhK2FzYXU2eE4yTEwySkVoU0kzSkFZQXBvalVnSlZpQjZRL25hdVhqQ0h5?=
 =?utf-8?B?YUlUSitNNXQ1NGE2eEJqZWVMYmVPMmdVTWJyTXNBZEwwZTg5VUhRNk9LK0lS?=
 =?utf-8?B?UWJrb3FJWGt0aTlyZXVuZkpmclFiSGMvamNqNkZPdHVlY0lsUXF1RnFqSGpa?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 451d8370-f14b-4aa6-364e-08dd4b81452b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:21:14.2999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9ytJHbi8tLKj4nMAuuoMp1Niw2bidWj1+1gtbOomd8+1fJF7YLzWEvngXdLztT34ffiS+jLeHc9XrDcFhmgBuLYduEqns3YbByRwFOMato=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6338
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 11 Feb 2025 14:32:34 -0800

> On Tue, 11 Feb 2025 11:54:37 -0800 Joe Damato wrote:
>> Incredibly minor nit, do you want to remove the trailing '\' after
>> fbnic_txrx.o which is the new last line to keep the format
>> consistent with how it was previously?
> 
> The point of having the comment is that the last real line can have the
> trailing \ and therefore will not need to be modified when an object is
> added after it :)

Nice idea :D

> 
> Thanks for the reviews!

Series:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

