Return-Path: <netdev+bounces-157763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E68A0B963
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B72C3A0264
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762F9235BFA;
	Mon, 13 Jan 2025 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7qWNb2Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739B204583
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778352; cv=fail; b=IF9KJGcxWx/vGGtHPt2TPBWo6PEVIotS7xTxjXyowVLzsp70pBW4jJ5vMaxEu1/IelAdNXuAL6AT9LIjtJRQY30fHQnQs5L6KCBoGbNFxoLXVPpKvAdUYPY5NaPBciKNrB3fT9lcPB6Gz/ZmacND4uKu8JK5Fn9jzh4U9jj0hRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778352; c=relaxed/simple;
	bh=wctLvRxnbfK1EwHGC/sxJn9nYFzIPVNN/CKEjMoXhNA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JLHHDg101zTXyCPIUR1swX0D/F6YQ0wk4PAygbF2jhI84XGIO51QcToIkgBbNyc0Mm2/qx/zFl+gqxp/b0lFhe2jYWJJA/VOrCChX6SVZgRibPv5hI/9dooFuk6+c2siI/KZg37QHSx22ytD7fULQZ688fOv/uZycirHoD/1OcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7qWNb2Q; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736778350; x=1768314350;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wctLvRxnbfK1EwHGC/sxJn9nYFzIPVNN/CKEjMoXhNA=;
  b=Y7qWNb2QqBZCRY5el8z0FSRbKRvBKjyiAFiAbBKg6umzFJc/S4ICS1r8
   pYfJ/vCvUbOLFzlMO6z6I+Ac/XXeicgJSAto5zeEA02GEFm892i9ebIiO
   INNH59MDEaCa4Vn3kAdPyIqOJe9DaCwG1pCS2L1cxp/kPupkTxNQ3kM8I
   d8LQ5v+cediIn87ebTF3wqnpcY7X+HNbkX2HfTkQNGnq/qrpbChootMOB
   kkaKgUAcjLWLqyXAe1kRQ1vpw51OCA+Xzxdi+wrIAsve92MtyElszMYi2
   YtPlhM/5j12Cy+S3Rna1RUXFd1oON4gxlWx4ylOPj0pXuFTC0Ra6H0uHF
   A==;
X-CSE-ConnectionGUID: WrDupG0sTsC5uTQZbX6HUA==
X-CSE-MsgGUID: /1NxiNPoS5q57YbtEKYDfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48457580"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48457580"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 06:25:50 -0800
X-CSE-ConnectionGUID: qZSRhmwoSxCpw1Hnwf7wEQ==
X-CSE-MsgGUID: 47CyPXmRS+y1PKciy2qfEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141772747"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 06:25:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 06:25:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 06:25:49 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 06:25:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euvH+MCLyddhMu3gTNk0zNWKj5J7/UgGUQAhWsQHDkRUmNWeclJWzYxjzPeLNVRIVfDM4Aen1XIxzgOqWTz1EOUzTysftV5S9Q6SJxXfrDl5WboW0dPnCsTgHlQAfAebtlxlC1NbyiDNHdJgv7e5Rk3lmXuoOa7ue2q9Fen9fQpwSXn0VeRGf4+a6JW0XqGMit/OuJ3bbxzvpSL6jH/TRHlwAiR/orDAcOBtXL/JnA5b77sG4tYSxTAJuDtRMmqS6xNRRQlOk+/j64zAiE1SuXH6SW1iIW++gcXGV35c5lrPkDdsKEdB0ICglITkiEVnui36r8Ryavs+/cdqfr9Q9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DnpiHkz4o5E7JoFGW5M+ePPeCOV63iMNvsz5HFYFn0=;
 b=FNDafhsWWrL+M5r6z2xC5FC63elMU2g7ttySXRQuWLMTtQutx80HHTWmS04/MGwzbjBNDjC8OCDL83xPc2O1W+DGULLvuxxlhj2ZX2UR3+F6jd6f7UCRuS2jlTolKkPUyClvaV/szOkHXfFSBrBCaCtHpjYRua0QV6HLTu1kpn7YnVQw1DvelJq7HHJ8e9u1d7nKKG+96wgavG6vQGk3pgpZlUxzUtZ107oJn9sma3+KAZkGY3fGatP2X3uuWQJ9iiT61fVUJB5oQ/b0T89MkEH8N2VW1V5ZtGy8YT05xzhoCWIf/FyV3Cy/fMrW5BAGu3za5d/Rp3i+V3dKXblcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS7PR11MB6128.namprd11.prod.outlook.com (2603:10b6:8:9c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Mon, 13 Jan 2025 14:25:46 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 14:25:46 +0000
Message-ID: <2fe1bbd5-834e-4142-b101-8c420c459472@intel.com>
Date: Mon, 13 Jan 2025 15:25:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 09/15] net/mlx5: fs, add HWS fte API functions
To: Tariq Toukan <tariqt@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed
	<saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>
References: <20250109160546.1733647-1-tariqt@nvidia.com>
 <20250109160546.1733647-10-tariqt@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250109160546.1733647-10-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS7PR11MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 052ac179-a42c-4dcb-3632-08dd33de2bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3pHQWF6V3NwMFluaE1WMWNQREd3K29Iei9rNGZFV2JuK0FyaXkvYTNNNE42?=
 =?utf-8?B?c1B0MVA2aFlQMG04Q2IvdHdFNVhiNVN1cGR0MVFuZ2FraWlrZlhieWpGUGxU?=
 =?utf-8?B?S2hLWjd6OUxPNXdWaU9YbGM0YlljNi9qZGk1OGFmRms2dTJtSWRkdURSdVZx?=
 =?utf-8?B?b1ZyalVGZFFoeWdLTzRJeld4VUtHb1UyTGtFUjBvWmNtMXVZSElFZVo2ekhS?=
 =?utf-8?B?dWQ3SWJBc0RNK01FdjRwSjZjSzBXOG1qeVlwZllXcHd1SldaWFZLMlo0Mi94?=
 =?utf-8?B?Vk94cFIwZk1uaDhOM2VrKytNVi9kT1dxRU1lUVYrMG0wcDZ2emtTRnJqSnNt?=
 =?utf-8?B?bnlFZ1ZFc05qOU96YlJVaHFhN25ZdVdCSCtMSUZpYi9CaEJSd3lFb2k5V0Fi?=
 =?utf-8?B?ZHNwMis3Vno1THZiY1lKNkJmbmlIbUZCK081VFNJb0FuVGQ0WWx1c3oxVGlY?=
 =?utf-8?B?YUF0eW9mQ0VBQ21ONHJBNTMvQ2VSaFl3K3ZTV0lPcWQ2b1Q0QzE0RVpsUGFV?=
 =?utf-8?B?YTY5eUsrR1hwQjdwMFExdHdRdWZ2azhIUkJrbkFwZkVyNTJHM1JZc2FEemZP?=
 =?utf-8?B?UUpGcjZ2ZDd1NnVtNHZuZ09wVVVLNEVvbzZTV2VCbU9GWXFTMEhndG9waTVB?=
 =?utf-8?B?MFM4WU1hMUtZNGxXZW0vK3o2RFRYa0dGM1Q4cVZNbWY3a24xZ1N1cThZd05B?=
 =?utf-8?B?d3Jrd0R4ay9PMXV5ZHpLVE5RRGtaK0UyZW1tWU9UdlJPck1iWENCaUtuUjlB?=
 =?utf-8?B?aEJwSnNFZjBxbjNRQ2xRcGhqUHE3UU1xY3JvYzJHQmZHTUIvT3NuZ3Fkb0JR?=
 =?utf-8?B?WjByUjhwWWR2TUpxY1dBaElvY095Q0J4RlJIUTc3ck5UOEhNdGRxdER0Nnh6?=
 =?utf-8?B?RWRyb2JFck5BTkVMa3VzblhJUGdxMVQ0cjg2ZFpjS0dockoyZzVZZjBYYnVj?=
 =?utf-8?B?ZzQ2bGY3bGdETHhSNkZOeXhMaTFvNVpMYVlvdlI2WGZWZytVY213QWxNNk0z?=
 =?utf-8?B?UDNYcE41a3d6VnNmdCtlczdOQ2xOVlpIWmQ2M0wyZmJIa1V0dDYzYVZkT3JV?=
 =?utf-8?B?UWRVb2phZ0dNODkvMkJPblRva0ViMkpIYUl1SEpxOXFaUGhMd1Vpa3dBQ1Zt?=
 =?utf-8?B?bTBUZU5FQzVjZmNEUlBmcUFHVTJBRVNjQm44eFlOOHlkWnJZYmtqT1gzRkdU?=
 =?utf-8?B?THpyaytTOEQxWUsrYjh5b0FlYkQvQk4zSHFNLzdRc0hDMzk3UC82VlNhcjVu?=
 =?utf-8?B?ZklLTDB2V3QwZDJwUVFMRVJtcFdwdGh6Uk12VjBWS3p5QW5NMkdJSG5rWDdG?=
 =?utf-8?B?OEh0cktRWUxBYnJiSGpta2FhVm8vSlc1RWw2L25MbGJYZkFqZktmdjRLdGQ3?=
 =?utf-8?B?bGZRZ0dCQUg2dnNFOU5TeG5yM29oU0pkV3ppblh1a2VwNFVyWUpyQm9iYmYr?=
 =?utf-8?B?VzhXa1o5THBPWFhZditBem5PbENWSkVjYm9YamY2UEkzbWU1N3hxdFVjUU5x?=
 =?utf-8?B?VGlxbEg1YWFTWSs0WlAydjBrZjdrZ255TWJrWkNBUk9ZbWlxQ3pWaTBrTjZ0?=
 =?utf-8?B?ZnNYRmpkY1JiZU1sM09HZGNSM0Vvb1QrZlZVZWlhYkNPZUU5SEV3QklCdk9D?=
 =?utf-8?B?cXByV2ViekRvOEVjUHQvTDg1L1FDaGY3QUdob25iUlMrK2tObkVoM1lIalgx?=
 =?utf-8?B?dnUwYXJvcXZFT01KclBZZm9PcWRiV1hqM05XbDRpM0VaaDBxT0dXYm8vQnFO?=
 =?utf-8?B?ZkorYzBRM0RMTkFsUmFPUmZRTFg4U3hqTlp5VEVtOWFES3NZRXdoRWM1eU1I?=
 =?utf-8?B?Tlp1dVA5NFJZMEIrUlZ6dkhzTWFqVjZUbXNMOHhETnZwa0RSV2Jja2xnYU95?=
 =?utf-8?Q?05f80QwFtAuB/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFdJR0ZjQWNxdFk2eXNwT1NrZzZ5QkZnbTdweElndzMxQjMyY2dLSE9aVWhX?=
 =?utf-8?B?TkpiYm9UZUYxTDREaXNSUXUxY0xyekJtbUNoS3dQeUVSTHgwT1hmZzZjRGsw?=
 =?utf-8?B?anppcmsyM2JRS2V5b0ppMEx1OVRmQklNZnNQOHJHUjV2azIySFFFUzJJT0hB?=
 =?utf-8?B?cE5UNE14TnBBZ1hjcmlUcnluRWVHaEFzQkRZQnQ3OG9Fb2c4YkIrbHhrdVlE?=
 =?utf-8?B?UGJuWWpkbHpndlBHNG55SFg2T0dQU1UxNXJpYzduSlhudkdvVERGVW03MDY1?=
 =?utf-8?B?am5hV1dycDlZb0ZrVUtkNHZOZW9iWWlSWEVxL3AzVnRjYUZUK3lJb2cyOXMv?=
 =?utf-8?B?dVBwaFNnQVBFbUk4ODdMUmhGS2JFOXVZZnBDeGVQTFBrbzJUOThtSnlMSW1P?=
 =?utf-8?B?THNwNXVrNjV2OVlkb2d0c3M5ZGc0T3dSK0pjTGFHdFB4WGMvbFdZaW1yRkR0?=
 =?utf-8?B?eTZSUVRtWWM5U2xlV1ZObitiOEFRZENGVHpYSG5nVWtQMFhsQzI3V2MrZ1Y0?=
 =?utf-8?B?RWg5aDRvOWUrRXZMRGtvVXJRSkVvcEFiWEk0V3c1d1hSSWNGL0wrYys3Y3Qr?=
 =?utf-8?B?eGFPNm94Nkk4ZU54Z1RndTY3WE01cFRXM3ZuV0lURmh6amZabjFBWmNCNXFl?=
 =?utf-8?B?NVo3eDFGaGJBVmhXemFJUVVMck8zaGgyVDg4OGF0OTMrdmNRMnlZTkJqakYr?=
 =?utf-8?B?SXh1WE94ZXlpWDc1VUo4eWp3MTF2S1k3MXVjU0xtT1RiTWpUdk5aVGJ5QUhL?=
 =?utf-8?B?MHRBQjRLdVN0WmZpOGZOZFZ2OG4vQzFzTTlTZXJOTnR2b3UwZEtoSWdaU1Rm?=
 =?utf-8?B?YlMzNGpobXNqNGxCMVFHU2FKMUJmTHRTOTJEQXNXRnJNdVVtNkdJeUVITUs3?=
 =?utf-8?B?QXdPL0tseWRJTS9ydUh4aFB4SDJnbEo1NU1qenB6d1pGYTZDVS9sQVhuaFcw?=
 =?utf-8?B?cGRhT0ZyT2Y3dXM3L3p4cWF4VTVXYmZOT1JIVThKQlV6aFk3WHYzOW1lWWdR?=
 =?utf-8?B?REFqcS9yTXpUK25DeG55Qk5ZRjgyRnZiTG1zK0NjOWJqMWxYcDkrSmduQkE5?=
 =?utf-8?B?OSttMHpvUHpyNE1MbEc4eHRiYlBrdVlnMy9sMXd5V2JvZmJ4V3BKdDF0WFU4?=
 =?utf-8?B?bmxKLzBqZCs1bWhyTlBkSHBRVlpaTXVLT096Vk8zWEgxT0puaFAyNm8yL1FH?=
 =?utf-8?B?cTFGS0J5UWFVY3lLZElPc0tLNDlQaHBRei8zSEhWck9tTjNXMkVLNFk4OXBv?=
 =?utf-8?B?Yll6UzZRWStzbkIvY25qUnNhSGkyK3dkNG5pRXlmVE55WEd4VVl5SUptMGsy?=
 =?utf-8?B?MFlyU0U2eTBna01iQ1k2aWUzUjBRK2NaZnI3YnVZaG9KdEdqZW5qM2lwWXRK?=
 =?utf-8?B?MTVqd0s3RkE1M0gwMmVtWml2V3g2bUZRbzVPbXRRUzkzdFR6dk1ZWTU4MkE2?=
 =?utf-8?B?T2lmUmg3UTVDUkFnUnlRem0vY0dTY2h4bnJGOHk5ZXFBL0xFMFByVlRDKzJW?=
 =?utf-8?B?S2FxS2FLK1ljNFI4L3RYV3lyeVFGbGZUZGFTZWIxMWtXL2s5dVp6MFJxMWJF?=
 =?utf-8?B?dWxnNnFaZjNaZmFWc1BPdnpTRmRZdytHUzEvd2Y5ZzBjbVFXVFR5WSs5Q2p5?=
 =?utf-8?B?UmRJQzhOWmg3Y01lV2s0b3E0R1Q3QmZLdmtYMENoV2xSWi96c0QvVG5xTjBF?=
 =?utf-8?B?YXQzcXQrcnd4UnRiZDBNZG55SXZ5Mjh5WHBDTmwyQzZ2d0ZDM2RGNFU3NEg4?=
 =?utf-8?B?Mm10L0c2bDBSSzg3MFpLaisvOElXMlkrSWgrQnQ1bnRJZGNrdUkzbnVjdG9V?=
 =?utf-8?B?NjlxU2ZTSWxVWENOcnRtL2V3TmFhVkNkMkZVV1pkOWRyZXowVHBCdGoxbi9q?=
 =?utf-8?B?dlJNT3MzczZpUkVkVncrbGxrQndjSlVvRDBVMzdkRm00Zm9iVHU1R3YxblBl?=
 =?utf-8?B?Q0ZTQmRJSFlxQ1R6bC9CQ0l5aGlxRkVCa3V4ZVI4bXhqT3BZRmdTdzhCU2Zs?=
 =?utf-8?B?NUJWK20rOTZkOTVBMHhGbmtKdkZ1dkhnMkhGd05uQy9rSXp4ZFJRRVZjRVBR?=
 =?utf-8?B?ZFJHTVVlV0RYUmR2RE9DR01Xdmtic21jTFZCd3p1eTNBdlh6Q0VIbmMrWVJP?=
 =?utf-8?B?U0dqamxFQ1NFNUxXcjR4V09jQlI3THQwRXZuRWR4OUVIZXB1d3BCNWVHb1VQ?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 052ac179-a42c-4dcb-3632-08dd33de2bac
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 14:25:46.5867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /a7UNbEkhJpD5iE3jyCDtR1yHXP3IcAogXagVI281YICBwB2Pm8U4vzZbKwPLyvaGN1/XHIlGZBB9xnpvWXpS6mAXwIWBGaSIg63/tOhY/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6128
X-OriginatorOrg: intel.com

On 1/9/25 17:05, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Add create, destroy and update fte API functions for adding, removing
> and updating flow steering rules in HW Steering mode. Get HWS actions
> according to required rule, use actions from pool whenever possible.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/fs_core.h |   5 +-
>   .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 549 ++++++++++++++++++
>   .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  13 +
>   3 files changed, 566 insertions(+), 1 deletion(-)
> 

side note: there is an option for git to put .h files before .c files
in the diff (and thus in the send email), you can plug a git orderfile:
./scripts/git.orderFile

> +	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_VLAN_POP) {
> +		tmp_action = mlx5_fs_get_action_pop_vlan(fs_ctx);
> +		if (!tmp_action) {
> +			err = -ENOMEM;
> +			goto free_actions;
> +		}
> +		(*ractions)[num_actions++].action = tmp_action;
> +	}
> +
> +	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_VLAN_POP_2) {
> +		tmp_action = mlx5_fs_get_action_pop_vlan(fs_ctx);

It's not clear if this was a typo/ommision of second pop impl,
or it is expected to just work (this get_action_pop_vlan() helper
returns precomputed action command, that has no link to prev action, so
hard to tell).


> +		if (!tmp_action) {
> +			err = -ENOMEM;

I would use -E2BIG for cases like that

> +			goto free_actions;
> +		}
> +		(*ractions)[num_actions++].action = tmp_action;
> +	}
> +
> +	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR) {
> +		mh_data = fte_action->modify_hdr->fs_hws_action.mh_data;
> +		(*ractions)[num_actions].modify_header.offset = mh_data->offset;
> +		(*ractions)[num_actions].modify_header.data = mh_data->data;
> +		(*ractions)[num_actions++].action =
> +			fte_action->modify_hdr->fs_hws_action.hws_action;
> +	}
> +
> +	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_VLAN_PUSH) {
> +		tmp_action = mlx5_fs_get_action_push_vlan(fs_ctx);
> +		if (!tmp_action) {
> +			err = -ENOMEM;
> +			goto free_actions;
> +		}
> +		(*ractions)[num_actions].push_vlan.vlan_hdr =
> +			htonl(mlx5_fs_calc_vlan_hdr(&fte_action->vlan[0]));
> +		(*ractions)[num_actions++].action = tmp_action;
> +	}
> +
> +	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_VLAN_PUSH_2) {
> +		tmp_action = mlx5_fs_get_action_push_vlan(fs_ctx);
> +		if (!tmp_action) {
> +			err = -ENOMEM;
> +			goto free_actions;
> +		}
> +		(*ractions)[num_actions].push_vlan.vlan_hdr =
> +			htonl(mlx5_fs_calc_vlan_hdr(&fte_action->vlan[1]));
> +		(*ractions)[num_actions++].action = tmp_action;
> +	}
> +
> +	if (delay_encap_set) {
> +		pr_data = fte_action->pkt_reformat->fs_hws_action.pr_data;
> +		(*ractions)[num_actions].reformat.offset = pr_data->offset;
> +		(*ractions)[num_actions].reformat.data = pr_data->data;
> +		(*ractions)[num_actions++].action =
> +			fte_action->pkt_reformat->fs_hws_action.hws_action;
> +	}
> +
> +	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_COUNT) {
> +		list_for_each_entry(dst, &fte->node.children, node.list) {
> +			struct mlx5_fc *counter;
> +
> +			if (dst->dest_attr.type !=
> +			    MLX5_FLOW_DESTINATION_TYPE_COUNTER)
> +				continue;
> +
> +			if (num_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
> +				err = -EOPNOTSUPP;

I get that some combinations are not supported, but this looks rather
like "too much requested" (-E2BIG)

> +				goto free_actions;
> +			}
> +

In general, this function is over 300 lines, it would benefit from some
"rule action builder", that will keep count of actions, and would allow
you to check (most) erros at the very end

Should be fine to over-alloc *ractions, so it will be safe to fill it
without checking for if there is a space for each element, and just
decide it's too much, when it's too much for your liking at the very end


