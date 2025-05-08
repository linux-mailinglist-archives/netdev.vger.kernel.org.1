Return-Path: <netdev+bounces-189052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6725AB014F
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 19:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AB417707A
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F97E28751D;
	Thu,  8 May 2025 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REdDiXwD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA72882AE;
	Thu,  8 May 2025 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724853; cv=fail; b=fQrCr9gdeLJhCkWBufrp2RAUu+eBAMtH3eOiWCbcGx7sUEbtT/+qvpy83caeQEudYfazDf4WEeGR+XcWjoTMEtYk8ymyGcB2VxCV0TeaS5M2Qc3C76mCi1tcBDzPKqb38X/zznbp9fXy1PENKCBfDJZ3IwHOTbNLUk+mjL+QLVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724853; c=relaxed/simple;
	bh=682LRjUJ7IOMbNyJYPLWusgquDoib94BM45IHNQftOw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EzMIBxEpQqpJeV4W+qjoZjDD0+/iKutdTEv/u1D7BGiAlYWpzskOAkYR8mspiv4yBb1D6Uqi28Ra3tKBOFUJBRT8QcI1s7gAQWYUgJgsAO7+QJTfdXDFYK6PxNdBkJcJQVNi0hAS66pfdDOpwmURz4PCdp2MxJdS/IVjRh67DjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REdDiXwD; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746724852; x=1778260852;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=682LRjUJ7IOMbNyJYPLWusgquDoib94BM45IHNQftOw=;
  b=REdDiXwDhhEzu3Lix0VBmxviXh1MievXJiIVPvt1DmQsdxdUhEy3T3b4
   //IgTLWrKJjpxG2hWX2S9P1KDXbydCJkTkt7FLJV2hSrlCvL+N3qih/iE
   nSf+E6A2d6Y844SW7PPeujU0CGHYVla0uwuy/8ewPFGTv7YXA3NqipkfM
   fIb7i7a6bDPeuy7yYUW0eSdWSiUZxCBrQtnpNr4lgjPgjMyF++wE+5VyG
   X34TsBSUWvI0TWYuZKQmyy8UNYhLhqa972J8iwmE6I12CqlrU7aJD2Jvy
   hbYpgoJ5dbkOe9+zwAYTD7jL6xTeKjP9wKMc598CAGog99GSNVHRigc+l
   A==;
X-CSE-ConnectionGUID: akhMtISbTISWbeECMMiz1w==
X-CSE-MsgGUID: nrqA+KlTTSabhCDAkf80EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73904717"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="73904717"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 10:20:51 -0700
X-CSE-ConnectionGUID: M2peylW4QneW3YRdtTvgyA==
X-CSE-MsgGUID: eMJrXoQ8RFeLZjwhBMldYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167446840"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 10:20:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 10:20:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 10:20:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 10:20:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EG0iDIz7Ad381TK28T7mfmx9ONts9L3m7kmPgYkrQsKvqVm0CqX2bhMoLZb7lUmYNGXaS00hfszXw9JFgu7zajzaHS0faAcfFsRjtsSD2N2UKkSRXwS1dny/Z1R/YCKZXYihkUS/cVVDXBrfrcewIhL1nbvYpHnjaVrFTRpRiUo2EfQlHYmSyk0XvWtH8Fs7c82SBGR4IqeoO/WWIKT3X1pKRiqdIZSlEvfJDXC5kDe0RpAB/yZAP18Vi3bUyRTTdVnVD060Pyv5aPZTG6/83uW1LRDdkIjVtPIjog4PRpZzlAU4cUsKazL/RRvCRtQZDUqS4KkERyk6UDwfiClxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuTXVRbpQ+nL+91hjiB8L8n7G0enMpg30aAqRP0VrMc=;
 b=ab3wAYA8tXxUZM8CxOLlTi8BO7zAE26iyDKG+QlihkWkqEvYl4oK0VQDXi8juxpuh1YiGPiuywAHD1+g6sBssCv5lHP7WvjhMEfSijHb78qr4hg12DcwZ0OrMmkYraTkyrDsf0DAnTydnC3J1nFNBGQJJmd/Vst8dxQF0u/sf+0L8bgVm3Uc0//vib1os5Wfo76YYvdbcu5RmXo6Ygl6x5ilSHJpIlVpBjZl+qc/WYK+OCYj0UgWAApw4KJiFDRdrrLkI18VDTQcRASs1FmvhjsUkHuaFzqp4Jo5WbA84GkU3cR0MxE7fwBVre1ygfhp5kmzRoiUzp2CoOTWopOrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by PH7PR11MB6881.namprd11.prod.outlook.com (2603:10b6:510:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 17:20:29 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 17:20:29 +0000
Date: Thu, 8 May 2025 10:20:25 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v14 03/22] cxl: move pci generic code
Message-ID: <aBzn2dYVhh4W_I0S@aschofie-mobl2.lan>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-4-alejandro.lucero-palau@amd.com>
 <aBv8iyReoXruSaA7@aschofie-mobl2.lan>
 <92ff6f90-3b32-490e-9b62-0f516cb89ef4@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <92ff6f90-3b32-490e-9b62-0f516cb89ef4@amd.com>
X-ClientProxiedBy: MW4PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:303:b9::30) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|PH7PR11MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 27dc5d24-0d6e-49dc-c667-08dd8e54a161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bBu/VolkR6YCgp/0GTG34rj8yW3dZjDMOoFNeQa9wWawg4YvmPmwWKzFBuIQ?=
 =?us-ascii?Q?ac7qJFNjMQrpmNEJnVHnkV/szp45eqg38j+Vah5xe3vAql2SW76wC59rA+hi?=
 =?us-ascii?Q?d6ehzJEaq2yA9h7FfzaLiXLXoOPgPyk0OOuvKtPE54Ku26pRzvINkGLLai8D?=
 =?us-ascii?Q?up3i53c+/YC/rXFAgraKYdz+uJa45xNC3FfOx+z4PJoDYjgGxZAajqdSA6hr?=
 =?us-ascii?Q?HNY1Angy7xtuM5//9HeY0VLkLFPHhz6cBNlnDzxyBgFM+OFLFvWTMXXAn2gJ?=
 =?us-ascii?Q?lu0d7DInQm6vYFC9WGneBY7YENRq2hlLZGYrjBxC6jjco55NBI6QQDdAneof?=
 =?us-ascii?Q?KMon3Zigup/YvA784A3WgS7SAuZN4VvEA0XlTNOKPua6cvqOscXSvkd7Ix+F?=
 =?us-ascii?Q?y1VPvX2D90P5GR7/zqcRSTQCFn+LNwwoZBsnaMpDPtJh2tHxuPrgjaZWG1+I?=
 =?us-ascii?Q?cjfsIfppL3uS6McaOOBR3rYkiBaHluuVvwKocLaiMw19rd9HCJvltVyeFe2H?=
 =?us-ascii?Q?EVOQkbruKGu4GQvsJPibECYGVuKJmacJk6qdSqGGyY6G4p78F7QCvc+z8Z+n?=
 =?us-ascii?Q?/mOfzHstQ0F5FNbquFocIipJREujIK1yPCaaNEY12uPdLZ3v3lnsa8YAE9sM?=
 =?us-ascii?Q?y8dUxQTI1i2edxJ122IF+673eRXQ+3aw+TKhr28hAYL1sTHnknU8wwbokmCy?=
 =?us-ascii?Q?3ZZ6BmmOByYqSbzwlP0DtvYd7MS7VmnNXT4HZ94KH4v2r174oHxVsmA+Q0mJ?=
 =?us-ascii?Q?5P9RS+d9AAmxll9p3TmLhyacTm9TXVBj8kTPPmpsB+Zy0tpmatTmse+GqAiw?=
 =?us-ascii?Q?M2O1QD0dMB/N0qkK/sIvXMdXc7BiIG8jqkCwR8soegd02xH48bJr5O7nhsxg?=
 =?us-ascii?Q?9G+DTDTIsgG1K8sXLeeUrSTi8Je74UOzWzPWzTeKfTJAUrWS0FAhj/vgvYPB?=
 =?us-ascii?Q?hjgl14YZ2vG7OU7xhCR4qNtkx3ZiLs6abun8ubR+MhplVnkXbvGmbrsEjSQk?=
 =?us-ascii?Q?6UW7W8yoF+EHqLhz9OhNmdntiouTGPz3n8BU6EcMkqeOdW3xfEJF/RIVO2U0?=
 =?us-ascii?Q?TcZMatuu9zCp0XGy18aPyHrA22XNF+AIj2Uy0EEwi0CAMdUIomv1asGNSdm2?=
 =?us-ascii?Q?pa9Kgd0Up44LlFKt34w1gKNVIHhPI6fEHnawUQf1CRgTyc9wGAyFVVMtKvAi?=
 =?us-ascii?Q?5LWIFiCiZQVOoKA4FtRXBUACICR8ij8pxwKPXQj5eeas0Ozto4GIzSkoRtel?=
 =?us-ascii?Q?Hx85+WfKgEniKlzmSP3sPV90IbO/UNpXUN6QMiehH+kwefGeE5g6XUQxlsu/?=
 =?us-ascii?Q?ZZMR4t7c0HvPHkDEHZl0pujtzz8mdcPD6xo0eQrSrIS0fx3ac/gsnIBgv+Nx?=
 =?us-ascii?Q?9fsYiEJA7/7pb+PsHIVtDMoXG5lyY9X91Q1Isgt52sdkXU5cQC7sDah+F8B4?=
 =?us-ascii?Q?VbDQaTBgSaY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7fE/yPSf6JvoA5SnGtyOlfAbVXxH8hir0Ev2krzqvi9K1Tm5oWmanzbTqWts?=
 =?us-ascii?Q?sfSvuSAJzb5CEsGmjHdOHuVVyZLQC+Ei9ldoV6GzutlO4fJk/lsM7iCwhcxq?=
 =?us-ascii?Q?V7VWPJAQuhbwae+ANlMh/G+KfqPsoRueA345u4RbEuctoGjWrAPsYRaiYwb5?=
 =?us-ascii?Q?6vvJUPSsI+ICQLLyacr13rBu9WDXVudo2sjJXUP+JlqTRxSIpUJo4n2cRQrY?=
 =?us-ascii?Q?/Y8zMAE0QGAx97DQGU/YaECFyLTf8D+y0+balph5IgKCtKlhKhQcQuuK26a0?=
 =?us-ascii?Q?FRxselmvDYnPhOgFtPojvx761ZbGZO++9xz0QNwBRqa9D9X/zPUNFrRB/Ztq?=
 =?us-ascii?Q?aYCwDv5RuX29Ig2CJqQ8iNk7SkSM2E43jCOnKPQRZUtzycuD3coaAUQuSLo6?=
 =?us-ascii?Q?ODuSF9XEJlDRpgkkqqN1ybUmRn+u994srQ7DGQOuWrQ6VO7+wVyGL+cUqkU0?=
 =?us-ascii?Q?OiWvi8iz+AEe5bSe8GkLT9I1QKx0NDRJLfe7Mgix0aULI0+dkXA2rvSNRDzw?=
 =?us-ascii?Q?CautZvzKF9xcMxAXNMQ6Jhp1Nq0+qguHqpMzIwVsUKoeE0ptKnaM60PsZVZc?=
 =?us-ascii?Q?pGNmRs1jrJd9HMPxLEMyBsquGRiyj/b59V3jruplZCFO7u8AXp8yW9iu8YVu?=
 =?us-ascii?Q?yOgzW789GGX9raKoDFDj6S48xsJwtKpc2AlDviPihGCAKHTDXpjDJ5b3XgtF?=
 =?us-ascii?Q?AtGuIzYopNHDSE3uTqVxdnz3vv9c9qcWRloR9m9BLa9ez3KC3+UAFh5I98YK?=
 =?us-ascii?Q?T5zrMmsxg12hJThCMw3UC83H5FXa9NTi9UQzFOyaJjR0vivZRgS0WjTySdyf?=
 =?us-ascii?Q?6+HxF2oY8FhGy9fduayrQofxhXm7Pr5CDveYoSXqZT59/sXKKP/xIcQedlol?=
 =?us-ascii?Q?jZe0tzYcwSz81OBHQ/XffhV6I0RuDJFbaGPiY8Addp5ZIq89XrTwp7sTw9Ch?=
 =?us-ascii?Q?dq5cQ9A7/Z8PJS8rbz8jNMa7DwOakbtLFq4CRywvuNuKyM4DSKIMIufX+j3/?=
 =?us-ascii?Q?DFKur8Xnczy4keQbjP5nQnakGWBKbfzPoGEnjvH/uO+JMuL3eKiVUbQcaobE?=
 =?us-ascii?Q?pWsr7Yi6Ye7WGPVAKb6HThF6c1f42V1xw2cflkJnjHOOvJNPCFq/FAtP7FR+?=
 =?us-ascii?Q?md817yo4b4iWTCtxb313R1HL9XO10mCKVzR3nRRTuLW+jv7dJS+iR34yb7bi?=
 =?us-ascii?Q?nBQtBerA/cy3+6uDpj4zv2TXDl61OpBlGQScauL2RH//JrX9H72YF/UKXJNL?=
 =?us-ascii?Q?O42TgYR88fCrXxHya2Xcx/9NSZceZVHeQGFVciWKJPB3+V4S3Bpj5LSq4re2?=
 =?us-ascii?Q?R65b0xLTChZ5iMw8lUmRMAas/hw/shdb+IokakuIoqbJpCzBBIn3Y9dOSAaK?=
 =?us-ascii?Q?FI0JL3lnvQfYQGn1XSp6AQghCLqAtB+E43d2QdOuMask4LrGxA6slXypCLnh?=
 =?us-ascii?Q?Fj6H7izJz+Wgt7bYyDwQfLzwg0HE9V3UITXNpQF/DZoluSQpdEv07pG5NEoO?=
 =?us-ascii?Q?f8s43dyNtS7ey7nuMjBVgROQh0oaUTBgLJY33o3+Vu3ZN9j7qQgtrLUUOZg3?=
 =?us-ascii?Q?bkqJlP8qkegAqfT/MKeanS1865RVkAA6HEyzxRFlqSl+7h0T+O445HK0kyuI?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27dc5d24-0d6e-49dc-c667-08dd8e54a161
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:20:29.4506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNOlZ2wbYrZN1TYwpALptGSQWoteCo4NoMX+2rQlGO4MpndoQQgS5uWYvJGupWTknzIZCPsvSD4iLHaxu9A1am0rftPE/UW1+GDSBIRKeuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6881
X-OriginatorOrg: intel.com

On Thu, May 08, 2025 at 01:45:16PM +0100, Alejandro Lucero Palau wrote:
> 
> On 5/8/25 01:36, Alison Schofield wrote:
> > On Thu, Apr 17, 2025 at 10:29:06PM +0100, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> > > meanwhile cxl/pci.c implements the functionality for a Type3 device
> > > initialization.
> > > 
> > > Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> > > exported and shared with CXL Type2 device initialization.
> > > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> > > Reviewed-by: Fan Ni <fan.ni@samsung.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >   drivers/cxl/core/core.h       |  2 +
> > >   drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
> > >   drivers/cxl/core/regs.c       |  1 -
> > >   drivers/cxl/cxl.h             |  2 -
> > >   drivers/cxl/cxlpci.h          |  2 +
> > >   drivers/cxl/pci.c             | 70 -----------------------------------
> > >   include/cxl/pci.h             | 13 +++++++
> > >   tools/testing/cxl/Kbuild      |  1 -
> > >   tools/testing/cxl/test/mock.c | 17 ---------
> > The commit log doesn't mention these cxl/test changes.
> > Why are these done?
> 
> 
> If I recall this right, moving the code has the effect of not requiring this
> code anymore.
> 
> 
> This comes from Dan's work for fixing the problem with that code moving.

BTW - It works fine, I just see no comment noting that the wrapper can
be removed because this function was 'elevated' out of the core? And I'm
not sure that is a good explanation.


> 
> 
> > 
> > > index af2594e4f35d..3c6a071fbbe3 100644
> > > --- a/tools/testing/cxl/test/mock.c
> > > +++ b/tools/testing/cxl/test/mock.c
> > > @@ -268,23 +268,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
> > >   }
> > >   EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
> > > -resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
> > > -						  struct cxl_dport *dport)
> > > -{
> > > -	int index;
> > > -	resource_size_t component_reg_phys;
> > > -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> > > -
> > > -	if (ops && ops->is_mock_port(dev))
> > > -		component_reg_phys = CXL_RESOURCE_NONE;
> > > -	else
> > > -		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
> > > -	put_cxl_mock_ops(index);
> > > -
> > > -	return component_reg_phys;
> > > -}
> > > -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
> > > -
> > >   void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
> > >   {
> > >   	int index;
> > > -- 
> > > 2.34.1
> > > 
> > > 
> 

