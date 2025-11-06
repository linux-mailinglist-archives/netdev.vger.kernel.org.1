Return-Path: <netdev+bounces-236380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4214C3B76F
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59186237A7
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A820338F40;
	Thu,  6 Nov 2025 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V901WtTl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD45933343D
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436537; cv=fail; b=SGKA5vQicWgXxPvLaj3q274BJhE3nweS4CojQuQdi9MB7J56LoIvYq+128zwwVfTSyiDDH6N4jRvXOEhOU6GKhXo6Isv4q94FFAsX+c4QgkVEBcSqvtmQIwqk+mbs7HPBUoQUZlGHZluNSjZL79xUVQ9O5AMQZJs6OYhe8iEf9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436537; c=relaxed/simple;
	bh=7QDXFthRNbOiVdZncZ4veSzk3GSylyHlkVuCC13QgBc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PjpVBnwu75GF9iO6fl7sFt6CeEXzt75jWh40BVmfLKGj3/bNOA/m2YU4i3V1S9/LRYYXAbE4ujtFzPGfwBCtBj/+7bcYtGTPFWNTPEFP3zDcE5fW2chpeEZtsyI4PigKF8QKWbV/7W9KSk+MZZnWbl16SzTLvu8qm/adiomhTcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V901WtTl; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762436536; x=1793972536;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7QDXFthRNbOiVdZncZ4veSzk3GSylyHlkVuCC13QgBc=;
  b=V901WtTlS3EFPrPr2Cp3fAqiDPPsZXNpl7yb46giT3/cBFUOgNkNuuc0
   3n3qmzKVF+NktncDDu6IBJHlVsU7nAVbBvExauy/DCfKGllWSSE9lr7aG
   6emq9zloK4HP2A0BADoIeZ7wMirIubWD96+tzCXfoJBDKDf9LBy+amPOU
   fqJLD5HT1BZf0NL5DHI2J8xfuLpwFHnJlJSrKjScFYwVBB5GqGCJy033/
   ZpSPN4fKTGz2rrK71ilZp3awsyCqhki5jb3/qE/O9HWRDF0Q/oojF4d5L
   noNkkWQoZzPcuFSdSKF3E2CyunNy8GKbIXx9jJBCLgfOHAC+RrPUZyCbE
   Q==;
X-CSE-ConnectionGUID: qEy+UpO5RoG9p3bG50LACw==
X-CSE-MsgGUID: 0Mj5fT6nRGiY5eLmYQEYoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64498328"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64498328"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 05:42:15 -0800
X-CSE-ConnectionGUID: ts/AWJBzS1GJrTKGQEPvyw==
X-CSE-MsgGUID: cuTLKDhmTL+IRn6+XO5i4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187702771"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 05:42:14 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 05:42:14 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 05:42:14 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 05:42:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCBWV3j7bzImiGOR1QrRMw2+qaeEgiMAfYuOGlwYEc2SjcEr35VwLwEANe6ymFjzUcmrmi+YBrG4Qs4nlnYH0AK8IYI2sHa9TYPC7aVBaeKvWIv6SrH+XJU1CmVxy2YzpSEYclEsW4O/znyL/TMKkggAbnaFhK3ctL+qXNw49TgLFpqrm15ZCk9n/o1r9ZPMf7Qu0r3+gEHlFrD8EeAxySWTrfnS7FxhcudZFzAHXLJC+Ve8TPp6mokXzRwAIMerZZXjQ+VBWEl+f4JpWsUeRHvmS02N8WX7IS/aFfhqzUmWRxkHInCD6rDlAVRk6vR+lsKbOFi3gR2Sjx/z4gb2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w45YXiCWoQjw+WUx7u29z+f3TLxagwll5qetIREcMjU=;
 b=Gq21U6k/xaZpG8yzXcQCSuy1ESbFgl/SjLH3GDVZxzXDmYOiolagHtGhLHRWpuXu3o1ItuP5LY1l1Fwngpj55zvEwTEwuoCRP5U16zFeCd1olSSFQUZijaXLIU3tCmyn4n8+AWX1pnCVBLSpILLMhssWW8N0tegAQehW1Dz5M/EcuC9q2yQE3xpTHtuje64dHD/YplH2FXj5SFa1UJ4O1TUKat+UsQaV4tP0KrxO/NUnbPiQRT1gFwpmq3vMqNDYjyqN5gaGk9xu1DSYcbQHRPngJTQ1L/NzTVKUVRDSvzX1kqJTCUxRfSSgkkiOk2vBn1tJzREaJHdl/Cx0dFljDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 13:42:12 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%6]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 13:42:12 +0000
Date: Thu, 6 Nov 2025 08:42:06 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, Lukas Wunner <lukas@wunner.de>, Dave Airlie
	<airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>, "Aravind
 Iddamsetty" <aravind.iddamsetty@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH 0/2] Introduce DRM_RAS using generic netlink for RAS
Message-ID: <aQylrqUCRkkUYzQl@intel.com>
References: <20250929214415.326414-4-rodrigo.vivi@intel.com>
 <c8caad3b-d7b9-4e0c-8d90-5b2bc576cabf@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c8caad3b-d7b9-4e0c-8d90-5b2bc576cabf@oss.qualcomm.com>
X-ClientProxiedBy: SJ0PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::14) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|SA2PR11MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: ca33ab2f-3a28-4284-c596-08de1d3a49eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1C5CxDxl9hY1oDF5fIu3rNB+mg+q6R+qd89hPLw5EmLkTtvUnMwPIGs6hTX3?=
 =?us-ascii?Q?IhqkvE0bqMxifRXQRmtS63ZEPu0JPIYqZxE9PSWGUCZKkDjBmdxyjYLz22he?=
 =?us-ascii?Q?NweT9a7UpphyC+Vsc+gNznzSTLr0dnaBMaBmcH/84cB5RVIosqHpMMgzESp2?=
 =?us-ascii?Q?voR2ZtDz/0/XFseURux1hd0GPj4K5gzIsCeO7ou6Ql38oiz7IRyV47/Sjuq2?=
 =?us-ascii?Q?UTfubQ21Ty0c2a5GJx5c5T04gH3bQYNJLdmFnL4G5b7w6WMUplUyua2yV6tz?=
 =?us-ascii?Q?fNhk0Qc5VvwA21kT/tW+iacQPvBHlmciCfeRf4t5JNa4/lLQRYZ+M/tdhg+L?=
 =?us-ascii?Q?xc+0u+csYpjzGqS21ONK0SZKw0JSR9+9QnTfGT/YZ+F/IzM1Usu/biI0PpED?=
 =?us-ascii?Q?RwuyXvGbvsaW0Si8F4FJzzxz1oU5PEf7x74BF+pfgDJLPPGQruWtOFBF0Whd?=
 =?us-ascii?Q?lszZraSQAcVjiM9mOqOosLyueVHNuXhUuaz9IMJY16T3sN40B4/osFF2de4b?=
 =?us-ascii?Q?PTCI8gA4Ml8pUDX2Hnzh4NBHfoX21uzR6yluD3ic1FIswcvYQz92GS/aU9Xn?=
 =?us-ascii?Q?+nLPqwmN3l/pmv0rEOp38xo6b9L0XeH2U6jcNo2lr7m/uGAuP5u++8VJRjEL?=
 =?us-ascii?Q?Q5JlxcQGSfhwDRHABktK3gvbE6ug3/XtRTAtJRr0CzTkeMYw5X8VGV+AOytg?=
 =?us-ascii?Q?bWdygkVLSbhppHzbSDyBeVwOCraizw2XFTkKQ2wv/5issqQxhVCjt/Jw1rLV?=
 =?us-ascii?Q?t5YdHtNR0DV2SjTJ1RpjltfWetbKDG3t95Ii2d4QprxIVn3FgDDQxU5WdLgY?=
 =?us-ascii?Q?OFH9xoT4HSCpisHOX1k2B9JVIhxXoXSKEkAgN/lKNK3/jF5M7EWmroGgX2HG?=
 =?us-ascii?Q?Ae4AD3dtiseAoY2v2encw9iW9DRIgXURqKGoKOgmEGgx8/s+Upx8TjMI0/YX?=
 =?us-ascii?Q?Y7xWPRIskAsuF0q1NdsnnTSBQYZ1sfqkx4p5eJ9XvMp+nNSD0O11uXN1Zb7q?=
 =?us-ascii?Q?4Ejxnf0peUBz45S9ZFcqCfKTB+PPejq0CKBdAeIKcG0oW5Mp+ZE3ZKtYnkk7?=
 =?us-ascii?Q?uT3nVLQfke9VhkuQdzfS2OhuWynOr0UpWEPntVf1HzhvsFvNdilDpapSwjJZ?=
 =?us-ascii?Q?bQtSwCbrmoYzOJfHExtXh9hZQLxFN2xWG3UyBVR13yutRpWK89OsjOsmxeNM?=
 =?us-ascii?Q?uzE63BSeyofX8lX5NUyA6mrJMPf3uGuyytK883r5IuElJ2UTHakQzjOIqhmH?=
 =?us-ascii?Q?J7t9hyymQdyZ8uIfCd94/jKXMXyThT+dfrQt3qWEExBIsgWN+5Ff0ow2stzd?=
 =?us-ascii?Q?i8IT+dV8yN+MUomt5ufb2ONdjCDgAabj/IJL9wt0n3tJ4daR59Ff+xVkAcWQ?=
 =?us-ascii?Q?Pl9mj/wyLvijZTErnBFu9Px4JvMHFSYwKNFlSMJrXThyo44D6WgtfaNje9Nc?=
 =?us-ascii?Q?tFrzk/lN3uAN/21pbaYIyzT6A9zQ7TIv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?htDPKUX8CA9dATwvwWub6FYUS6xSJwiHVbVnJdnh58yJcinE9XbqReFvwxRs?=
 =?us-ascii?Q?dU7+4QDCCeUSoS2d201P4r49ETxMh6JDOqMQrwZ5xTTyjfmpmXAQu5O2/YER?=
 =?us-ascii?Q?88MibOBmnpOzQjpzReLaXMSDqxTRAMfFEqVkT+txriZCJnenGvQx8zCyZLdX?=
 =?us-ascii?Q?SPC5WXnJF3Ch4Gu9XBMlO4xzhRY/AuktHSU792bFUde8pagJZB41+U+biIOy?=
 =?us-ascii?Q?0r4UrzjzueAFcs8H/CW2MMrifN1jUPpbhuuzER5Bs+0CynZ5Km0g2Up0gPAp?=
 =?us-ascii?Q?83y86dpqE2YmZh9ge1kqJUZ7n1LkQXTyTv83zC+0avg2dQRF1yxuWKMcL/8R?=
 =?us-ascii?Q?+HehHK14H+Sk9QVGS2hlqvqBuFrq8CxbHVUmMAYn0LEygF9m9Sc7947Gn7mC?=
 =?us-ascii?Q?NXvCn6zPFD08pGCBTbJXYuOso+8AKKxw1wqCYZl/lRHSkER+FctyEV77NAiV?=
 =?us-ascii?Q?6N4OXR9jCrB5nGeSMgR+fS/fOslIgKl3HRWj5Q7BDSDACkBNdMJoYpXgUuaz?=
 =?us-ascii?Q?gDLyCxIcp+Ll2dFIg0LmOM+ehoQu0FUAH4LRiB+RPF39WG0xzKdYoXNzgrdP?=
 =?us-ascii?Q?iS9YUAfQ5IE7Znofgn4qo+2oCUFKMyin8aKRvYWsgd00gBa0aNVH6zQrabNJ?=
 =?us-ascii?Q?JMVYi3+9gfNxeiKBcdUDpHrEbDtmdNa3A+rgO7kQMXke1B2ddCYjW68ChjoK?=
 =?us-ascii?Q?2u/lnKATqFhIuU3XmHgo1t/d/yHTPd3bIEwq2/9P/cQpWF4KXvALx09M9Sem?=
 =?us-ascii?Q?HniITpW/O5nR5uUn0PiQ6j//AVoOsFP3CnG9AAbmjhJIi/2CYPNUNTpuwYdn?=
 =?us-ascii?Q?vLQw/4CrMVGV6v5vksCYkcyIRlh5yVrJHgc3fvmdH/Keifrgv6nllMaBDui1?=
 =?us-ascii?Q?JgAqmj6jJ40JgaRBlmCJhBPTOqtdV2+s3teJWBH/M917FiMRmgtR8Bpo2FEz?=
 =?us-ascii?Q?nbjHUNOiRhBtvUWZkj0qItNevJ3opTHBA+d+hhGMsuehkDT0a0YEi9HAsMjL?=
 =?us-ascii?Q?8943L5MFZs0xBkrMFpxXd1g8Ddz1vHqXEWbFdowh0W5ofrd6kQWegjnZ1l5P?=
 =?us-ascii?Q?ov0C0Xtwior1F9KZRIg0tIZQ6wSAAqDlKcokKZw62a2CycM3MzWRevQwX3sM?=
 =?us-ascii?Q?siXBJdUDsMgOSGYHegApgMKgANTMJhh1/CVV1a8NDmIvmcIpLxaa96icNkkm?=
 =?us-ascii?Q?hs1Uo6u4a+y3kS02AEF3fPb6hOE8f7Vld5rZZdj4G0HbzqfY1oEOTHpjETL3?=
 =?us-ascii?Q?KhIwhhnmyB6LhrhiH7hSxIHkotD8BPTvnNGohaxyZbP1nIRoXKYlFRc45xnQ?=
 =?us-ascii?Q?AY4zRaA/ZT9NJOF0zPIppgjXiDncTbrhycWNqrxAr+MeavaA/2smaIOIdswh?=
 =?us-ascii?Q?XmEOf/65iUl6glBy4F5WbRSwHdthTck1JyR03vSnga4vzilaXk9B0djvYNpP?=
 =?us-ascii?Q?BeHd7HdIkf2WuXOX8R/uWajMX6W5KmvPMf2LpVEwlTSzSC8XqPQVs6OTdGzo?=
 =?us-ascii?Q?FKKsuPL1dwmCyuiklzS1mdkDnLZGbS5W3XJc2UP6PGLGb/V8s7RGvNetAow1?=
 =?us-ascii?Q?Xn8Xl0jWE/efQq/wtquKqyb61Rs4pp9W3jKWXjYY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca33ab2f-3a28-4284-c596-08de1d3a49eb
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 13:42:12.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fawKGXFjpLcY7LPKJWmaP87RNssiKBnJNuHdS93KuP+PR6YxWiZIuIqyJ81R+N7w6/mE47TYVPUN0QK+NcxKcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com

On Thu, Oct 02, 2025 at 02:38:47PM -0600, Zack McKevitt wrote:
> I think this looks good, adding telemetry functionality as a node type and
> in the yaml spec looks straightforward (despite some potential naming
> awkwardness with the RAS module). Thanks for adding this.
> 
> Have you considered how this might work for containerized workloads?

From the use cases that we have, we are already expecting network=host,
so there shouldn't be any problem for this usage.

> Specifically, I think it would be best if the underlying drm_ras nodes are
> only accessible for containerized workloads where the device has been
> explicitly passed in. Do you know if this is handled automatically with the
> existing netlink implementation? I imagine that this would be of interest to
> the broader community outside of Qualcomm as well.

My understanding is that it is. But adding the netlink mailing list and maintainers
here for more specialized eyes.

> 
> > Also, it is worth to mention that we have a in-tree pyynl/cli.py tool that entirely
> > exercises this new API, hence I hope this can be the reference code for the uAPI
> > usage, while we continue with the plan of introducing IGT tests and tools for this
> > and adjusting the internal vendor tools to open with open source developments and
> > changing them to support these flows.
> 
> I think it would be nice to see some accompanying userspace code that makes
> use of this implementation to have as a reference if at all possible.

We have some folks working on the userspace tools, but I just realized that
perhaps we don't even need that and we could perhaps only using the
kernel-tools/ynl as official drm-ras consumer?

$ sudo ynl --family drm_ras --dump list-nodes
[{'device-name': '00:02.0',
  'node-id': 0,
  'node-name': 'non-fatal',
  'node-type': 'error-counter'},
 {'device-name': '00:02.0',
  'node-id': 1,
  'node-name': 'correctable',
 'node-type': 'error-counter'}]

thoughts?

> 
> As a side note, I will be on vacation for a couple of weeks as of this
> weekend and my response time will be affected.

Thank you,
Please let me know if you have further thoughts here, or if you see any blocker
or an ack to move forward with this path.

Thanks,
Rodrigo.

> 
> Thanks,
> 
> Zack

