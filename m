Return-Path: <netdev+bounces-174237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A87A5DF01
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372221698B3
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DA785C5E;
	Wed, 12 Mar 2025 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nd9VOXp8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD171F949
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789951; cv=fail; b=nd25EGFMV+/iGOJ9Rvs00qvlcCoCba6MTS5iHGEUIVEAtyO4ZT28gGofVi7+JVX6cUvxJkJ0KS2+Sn9UdIGjL454nw6pdTQrPmhvo84xHMA8QzEcJxv9rhQQ2G43WH7wiIbs+VARWRpDXh3v2GBiwKkmMQYHlfoUSkVE6aVAW78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789951; c=relaxed/simple;
	bh=/YpKGLjzXcwhoPvvv5xfZflFXa++P28CzlJsbyDVg5M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qdW1JkL53R5R29ii6OcmRmt/3AheTI3vqjeMrCwQl3O1VgF1hB8VhMlzPVa0yPmSMFb3crnh3iZJmKNy0rwWOBb/+t4X+RVilVz9VszFJPGP0uUdUQH+KmCWrzwaLZysGCNIF2mH9Hp1NmZ8x3CsynHF7wd5kuyIvkKftSoFi9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nd9VOXp8; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741789949; x=1773325949;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/YpKGLjzXcwhoPvvv5xfZflFXa++P28CzlJsbyDVg5M=;
  b=Nd9VOXp84HMZimJybIa0XqYywUI9Cg7g0voDuD0KB+2xblukd5kFmFtd
   s41tbdBvpiI5Gqi2PMcFLDDI7PjUrhVV+H1/iQtBwymADEEvB+o0YnmEp
   0G/trxByeuDNzUPGNY9nstoX1K+inNzluJ1M0RVBpeIoHBUN9EYBo/UNI
   wFOLYVhqL3g7/Swcx2+SDNY5xXB7Kv+PdI+pjNwef/N0NpxvCaKc+90NX
   rQlOBpx6dQuYeyXYXZvwkZBgPwKuGdl/GJW2YjRy8WvUCQIil1K3AkEWA
   rvgqCwNFjbPFzSGCGxa4ekg/PmqAmf/QGvBuRBpl3GiVzjCcwOlYvUuhL
   g==;
X-CSE-ConnectionGUID: sjBEQiiyT9a4EimqyEFwhw==
X-CSE-MsgGUID: Bbtf8rt7T/WEbbpWTyKgbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60415419"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="60415419"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 07:32:29 -0700
X-CSE-ConnectionGUID: tL+Xvn/FSP69qY0W2hzVfw==
X-CSE-MsgGUID: 9bEU3eVUTvWN+O+4yzyHuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125297879"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 07:32:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 07:32:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 07:32:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 07:32:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dg4SeazWo2ZQiuxlsgdabE5JHf9Hm2erBhQ9KErnZxScgpz9fRO6HdZJpyHQ5UfnQOzmTbDqUcOJcR69NhFBQLxH7WlwAdlnWremy+Jefy7eubkmyjtdA46VbJaV36jkuuTtaX+r0fD/Vx7WaffBHDIzUxzyN5hgQLILpANOHG0fehkK3SIWVmxtsj+hi+p/id5mDppFc9qJ0qj2R7eZBc3w/b39aBGDTvT16/amfzg56ooGphAkzalizuoAAvM8GaR1FuVSYXV6vOrDdntbQ37RHDVDKO7JZihzhLiV7kBzNuRATKKiKh0EfpCsJvCDt9UdxEDp9rin1vKBmBhiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M418CGFGpqSza0kwBrX7tks9q7tjisV+as3lVA3/ljM=;
 b=ZhW26rtWA2uzf/ermB88kmgWls0K/2azSy0HutQHw88MYkhjel9r86gyeV/yPVNuSp99/omMpJh1YBm6nPm707PG3Zo7FXeHeiDURnZcZlZKdnkyU2jr7ieUzFIFLU9mL62AzfajmGXAma3WxqpGgv1jTV+vlqtHBrHd04CQFcECAfVSzPieZaZmZcrwoDZXDoyO2IpkwOUVXKH58tYUarzkMvoyBJBuJZ7YJtoJAucjf2ci9E/6Fr+dpiyp915DxeB7PbV6JiVhoYYxJlTq19IoGkfXseQhQe45UEcaWrAbIXWEPLOd3jHeYQFEknc8NlL75Pfet5hPhaOPQ8YkZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 CY8PR11MB6818.namprd11.prod.outlook.com (2603:10b6:930:62::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 14:32:24 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:32:24 +0000
Date: Wed, 12 Mar 2025 15:32:14 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
Message-ID: <Z9Ga7gx1u3JsOemE@localhost.localdomain>
References: <20250312-airoha-flowtable-null-ptr-fix-v1-1-6363fab884d0@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250312-airoha-flowtable-null-ptr-fix-v1-1-6363fab884d0@kernel.org>
X-ClientProxiedBy: ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::18) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|CY8PR11MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddf2304-7a1b-4da2-1da9-08dd6172b4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B5p4J4hO/1bTICtCMlD5L9XXsPzH/dLThh91FQNTzTS8u/68BxUElHczzxE2?=
 =?us-ascii?Q?Abfw9584BjAgAKlt31Urk+jJvAgnz0VhM9j+KfxPoVGJu+wEfudMzx0EBGs8?=
 =?us-ascii?Q?0TA5ta1zROzn3kaO8INtz2b2xEih5lUNq7S1LXEJA0YMUsistbpApUWkc3Jc?=
 =?us-ascii?Q?TcqjsqdGzvbfUs3o71JG8jV8PoabGZszJWmxFO9iePmrBzO/4+m6goEKR17W?=
 =?us-ascii?Q?85rMhcZeCJ4ay09CD47sSaUdGJc0eerlOwyMter4ITAv+FPZBJV3b+8COoB3?=
 =?us-ascii?Q?LXBByGkXewlbv7PHNzfQsJgaHCdoN784kNzPyy2nJfRf2QDgveNvNJTvleLA?=
 =?us-ascii?Q?y9EFZ0k1euiVbYlAH9af4ncImokoNPFd3ws/PX/Jb7EJ+4ghZ58O2cq23CSj?=
 =?us-ascii?Q?Z1mcex0nv98YWFB9ORiAHhzi8Hz9YophmoCfFlscXTg9TGrWg2NO8NoM+OQY?=
 =?us-ascii?Q?r3iOO2KnBEU5S+bU/AQYik1/W73Oq/aIa9TvsQfELF6hCb4t2xUUeMnuN/dT?=
 =?us-ascii?Q?OqXeToiQHMI+02STBwrEDe9Vbml8lwXkZJR+wHDqaNIa+vKwztYZi4HkIqVw?=
 =?us-ascii?Q?wdL6xc3RZ9apKpx0md3cweaM5cTFFX+Xs+9PvzRQMmeg7Pe1vL9veaydj88C?=
 =?us-ascii?Q?eRbHyaWcY0U382xcsbP1XJApwFCtfO5o4xl6bPQbJkXC0Xqy3bUUTUbtqU6B?=
 =?us-ascii?Q?50j6u+YdYr2ofPm2SiXq3Ew3sjxunPOmTYuz/S4FaJPBDJHOIKee+6r8LmY9?=
 =?us-ascii?Q?uQR+j+gjr1mGUpplyI4RJgDURIpwsQGDUX/rwSmr3k0Mzl7x5oh6aBaQnDu0?=
 =?us-ascii?Q?HLhkVg1T29Vzq+dLGKRfYh+dxlBnpCRNYNC1qR9DUQjaFxc7vfPR/ttdlz+0?=
 =?us-ascii?Q?ts0m/C6ooRsq9x2nkvEwOQfcNhxbWtm935pim190O1WY63wxz1mdQAZ4KWhS?=
 =?us-ascii?Q?FXehV1b3Arx6vygNhlwGOp4Ebc6JESyR4TZ8dS/oh2EwtKpZPgJNqz643j7e?=
 =?us-ascii?Q?nGd2AMhQZbkrYKRaVv4qGhelqLj9SIkthbV44qlD4zrIWZB57GQzflRpf3ql?=
 =?us-ascii?Q?8zBt52H4HVCnHMS5pWDZtzz0u9JUG7YwRpYaJdHNE7hhLQ/HoEm6xVWUSJuc?=
 =?us-ascii?Q?QSiiT33nfQ7IjNMEqSKsX9KB2riD7KsqZqbjhu44nqabjrwNZLeTjIAGXpl9?=
 =?us-ascii?Q?gJHjmhOMiqtZ+yFj63H2ZsDBS4kDvHl81EGo0aEj8rul8C/z8zttcjBxX66C?=
 =?us-ascii?Q?BSBLORDfssPmsxJv5WLCULprGW94OYwdPE/fNWGykcDJLqVTx2TuRQGuuC9W?=
 =?us-ascii?Q?QYBNdtkIImCUcV8TnoDJfSJMkSHkSdcN4YilksUmQh9L3blL5VoLlM7bsqHA?=
 =?us-ascii?Q?3r90yZszWfOxD2auinaeXeSkPxsy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NWMX8zy5xE9HfuQfSFp7MtLAaZ5gYQminnPdvoo98S4XqtahgOs2JDtQ3LgS?=
 =?us-ascii?Q?wnZ4O2qq2RA1hmqewGe/xesbuM1kXLOJLVo8iNJ1thBsZLzKgZ3hvvJEtwr1?=
 =?us-ascii?Q?Eb2u1R4nda0uZx1d4cRRKM4MvZf6mQ3uOHEFHcz54ArXEQ9cVVBdYUbsbSE0?=
 =?us-ascii?Q?uHFjfax9JmK6vRoLnGdySLDoy57pIVVjk9fIjcRFsg364+uGOrWLtLvFeDGp?=
 =?us-ascii?Q?LZy4CrhRUy1WQWd2JzxUx+ulQm7htTOl2qnCbVAQjRMRIokQHy26vNzqBQ0j?=
 =?us-ascii?Q?RKH4i8kIFFHsrzgPBidrbTmmXckny/jXelN7FYpwpHkTb+QGE+ICJDqJbZl2?=
 =?us-ascii?Q?otn3n9sCkSIsD64Yj2fc4iXwSJarK1Qf9A2Gorac4btGDeXWq79xgARRjclh?=
 =?us-ascii?Q?uxWdeV94FU43EVatAii1/QkrYn5nV2fWUafOlrVgPSwhAgyQydSgVr2RTPLC?=
 =?us-ascii?Q?oQDklK5QHtZVw24c2ae6aY57k37wGotoQ3YJK45tMQi0x92POeKG2OnC1qYa?=
 =?us-ascii?Q?cGbd3YnefnK5yqtNi2s37I9Ff87Gcq8MpElPAlOW+hQ8g2Q2df+2m1MYMpSI?=
 =?us-ascii?Q?YEf470weG7d0CoVxiAdt/D1oWFacA0aRnp5j65iziQFpSDqbcItocEHq8eu+?=
 =?us-ascii?Q?rutDp/5JUnqXxJH6Jc21bHx9vn8RKaffAhjSEE5SFKiife8W8h9XKumjqbb5?=
 =?us-ascii?Q?7C5vpwHkMt9wu3+uFgZwbOJndHMFryY+cf7Rg+H4OV3X85OS1jfJlMGzmP+P?=
 =?us-ascii?Q?H3VnXHAtAAabyHI5oqNlqw/pQFdiOQsvz9TqJ1SoM2Ypqs8nGCkusWtxFcfz?=
 =?us-ascii?Q?XgJ1i01U1+7+f888LHMzohNfSULnOtlsXF5CzkgiY+8hnyxKah+povjcB03k?=
 =?us-ascii?Q?9CwQqPeU3QOJdBFfm4evq10h610wUqt8zc5kmuH56jN7Quc1n92Kjksskkw1?=
 =?us-ascii?Q?h+ICYXf/V9JyDdG1Oulc2oQlaaobVaHrCondS9t3a7X61iRb5Lid/WSkzQXK?=
 =?us-ascii?Q?Uj5fWTOVtH29Xdgo86SKchVxmyF0/Seq8Pj+K1E8HNCOMeUXaORlfN2JSuKu?=
 =?us-ascii?Q?UCnVhKLhOXs8UwW9/6jBvTtizUg9zTZmfyKLgfCqhA2v53oTntgZ0uw+EEhG?=
 =?us-ascii?Q?Jcs1pIozIMigrWDlnV6lrRJevq73XS1R1u2NcQDMNK6pMC2Y4SdY+f/oPAm8?=
 =?us-ascii?Q?0QtgIcxRR+adlNFSNYgsC+mhCCaj/C+2wYh0isfL1YCq+6BPgxBRZ48Ece4N?=
 =?us-ascii?Q?SVNdN0h64sptkMoL2ZqdYhbwfYDGBsjKyoXbzPfVyLxXDR7w/rnnIyWJeQ2D?=
 =?us-ascii?Q?6yByGuHZ6/9kdsTsY6XQbxU0RfBmuTcttUmffopP23YdIHADK/xd05/lVbGY?=
 =?us-ascii?Q?sZIChBiMY2PL0hrKNxP9kimiD93qnONDBSdqffbNLWfa4iXLG1BfcfBVvX1y?=
 =?us-ascii?Q?RJUOV4nNBiUgdAR+s7cFOaRsd5HRjLuFpYtw+9PDK+Bz+0A3EmEORfoQFWBs?=
 =?us-ascii?Q?5aMkemxwmxWFFFIcABSc1XeS7lDGVLJB/ngYf63xHcvuqu1huVU5TUYyyMyP?=
 =?us-ascii?Q?Fht+xC8otSrgLPZ93+R1f24XJm16WPHoxqFUcyBvlD9Cdm7tNGOIDnOQS1Oe?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddf2304-7a1b-4da2-1da9-08dd6172b4d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:32:24.5464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmJ5WGPMV/hHXYaB+s6VC8gApFUeZ8C/olRH6ojdT+s1D9z8sTFJo6jnYAvAVymGD9C92X2OEyjsSnLb2eSC3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6818
X-OriginatorOrg: intel.com

On Wed, Mar 12, 2025 at 12:31:46PM +0100, Lorenzo Bianconi wrote:
> The system occasionally crashes dereferencing a NULL pointer when it is
> forwarding constant, high load bidirectional traffic.
> 
> [ 2149.913414] Unable to handle kernel read from unreadable memory at virtual address 0000000000000000
> [ 2149.925812] Mem abort info:
> [ 2149.928713]   ESR = 0x0000000096000005
> [ 2149.932762]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 2149.938429]   SET = 0, FnV = 0
> [ 2149.941814]   EA = 0, S1PTW = 0
> [ 2149.945187]   FSC = 0x05: level 1 translation fault
> [ 2149.950348] Data abort info:
> [ 2149.953472]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> [ 2149.959243]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [ 2149.964593]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [ 2149.970243] user pgtable: 4k pages, 39-bit VAs, pgdp=000000008b507000
> [ 2149.977068] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
> [ 2149.986062] Internal error: Oops: 0000000096000005 [#1] SMP
> [ 2150.082282]  arht_wrapper(O) i2c_core arht_hook(O) crc32_generic
> [ 2150.177623] CPU: 0 PID: 38 Comm: kworker/u9:1 Tainted: G           O       6.6.73 #0
> [ 2150.185362] Hardware name: Airoha AN7581 Evaluation Board (DT)
> [ 2150.191189] Workqueue: nf_ft_offload_add nf_flow_rule_route_ipv6 [nf_flow_table]
> [ 2150.198653] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 2150.205615] pc : airoha_ppe_flow_offload_replace.isra.0+0x6dc/0xc54
> [ 2150.211882] lr : airoha_ppe_flow_offload_replace.isra.0+0x6cc/0xc54
> [ 2150.218149] sp : ffffffc080e8ba10
> [ 2150.221456] x29: ffffffc080e8bae0 x28: ffffff80080b0000 x27: 0000000000000000
> [ 2150.228591] x26: ffffff8001c70020 x25: 0000000000000002 x24: 0000000000000000
> [ 2150.235727] x23: 0000000061000000 x22: 00000000ffffffed x21: ffffffc080e8bbb0
> [ 2150.242862] x20: ffffff8001c70000 x19: 0000000000000008 x18: 0000000000000000
> [ 2150.249998] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [ 2150.257133] x14: 0000000000000001 x13: 0000000000000008 x12: 0101010101010101
> [ 2150.264268] x11: 7f7f7f7f7f7f7f7f x10: 0000000000000041 x9 : 0000000000000000
> [ 2150.271404] x8 : ffffffc080e8bad8 x7 : 0000000000000000 x6 : 0000000000000015
> [ 2150.278540] x5 : ffffffc080e8ba4e x4 : 0000000000000004 x3 : 0000000000000000
> [ 2150.285675] x2 : 0000000000000008 x1 : 00000000080b0000 x0 : 0000000000000000
> [ 2150.292811] Call trace:
> [ 2150.295250]  airoha_ppe_flow_offload_replace.isra.0+0x6dc/0xc54
> [ 2150.301171]  airoha_ppe_setup_tc_block_cb+0x7c/0x8b4
> [ 2150.306135]  nf_flow_offload_ip_hook+0x710/0x874 [nf_flow_table]
> [ 2150.312168]  nf_flow_rule_route_ipv6+0x53c/0x580 [nf_flow_table]
> [ 2150.318200]  process_one_work+0x178/0x2f0
> [ 2150.322211]  worker_thread+0x2e4/0x4cc
> [ 2150.325953]  kthread+0xd8/0xdc
> [ 2150.329008]  ret_from_fork+0x10/0x20
> [ 2150.332589] Code: b9007bf7 b4001e9c f9448380 b9491381 (f9400000)
> [ 2150.338681] ---[ end trace 0000000000000000 ]---
> [ 2150.343298] Kernel panic - not syncing: Oops: Fatal exception
> [ 2150.349035] SMP: stopping secondary CPUs
> [ 2150.352954] Kernel Offset: disabled
> [ 2150.356438] CPU features: 0x0,00000000,00000000,1000400b
> [ 2150.361743] Memory Limit: none
> 
> Fix the issue validating egress gdm port in airoha_ppe_foe_entry_prepare
> routine.
> 
> Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")

The patch has "Fixes" tag, but it is sent to "net-next" tree.
I think it's rather a candidate for "net".

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 16 ++++++++++++++++
>  drivers/net/ethernet/airoha/airoha_eth.h |  3 +++
>  drivers/net/ethernet/airoha/airoha_ppe.c | 10 ++++++++--
>  3 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index c0a642568ac115ea9df6fbaf7133627a4405a36c..776222595b84e4fba6ae5943420e0edf0d0ecf8f 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2454,6 +2454,22 @@ static void airoha_metadata_dst_free(struct airoha_gdm_port *port)
>  	}
>  }
>  
> +int airoha_is_valid_gdm_port(struct airoha_eth *eth,
> +			     struct airoha_gdm_port *port)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {

You could reduce the number of lines by moving the declaration inside the
loop:
	for (int i = 0; i < ARRAY_SIZE(eth->ports); i++) {

> +		if (!eth->ports[i])
> +			continue;

Isn't this NULL check redundant?
In the second check you compare the table element to a real pointer.

> +
> +		if (eth->ports[i] == port)
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
>  				 struct device_node *np, int index)
>  {
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> index f66b9b736b9447b31afc036eb906d0a1c617e132..c7d4f124d11481cd31c1566936cd47e3446877c0 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -532,6 +532,9 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
>  #define airoha_qdma_clear(qdma, offset, val)			\
>  	airoha_rmw((qdma)->regs, (offset), (val), 0)
>  
> +int airoha_is_valid_gdm_port(struct airoha_eth *eth,
> +			     struct airoha_gdm_port *port);
> +
>  void airoha_ppe_check_skb(struct airoha_ppe *ppe, u16 hash);
>  int airoha_ppe_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
>  				 void *cb_priv);
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
> index 8b55e871352d359fa692c253d3f3315c619472b3..65833e2058194a64569eafec08b80df8190bba6c 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -197,7 +197,8 @@ static int airoha_get_dsa_port(struct net_device **dev)
>  #endif
>  }
>  
> -static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *hwe,
> +static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
> +					struct airoha_foe_entry *hwe,
>  					struct net_device *dev, int type,
>  					struct airoha_flow_data *data,
>  					int l4proto)
> @@ -224,6 +225,11 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *hwe,
>  	if (dev) {
>  		struct airoha_gdm_port *port = netdev_priv(dev);
>  		u8 pse_port;
> +		int err;
> +
> +		err = airoha_is_valid_gdm_port(eth, port);
> +		if (err)
> +			return err;
>  
>  		if (dsa_port >= 0)
>  			pse_port = port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
> @@ -633,7 +639,7 @@ static int airoha_ppe_flow_offload_replace(struct airoha_gdm_port *port,
>  	    !is_valid_ether_addr(data.eth.h_dest))
>  		return -EINVAL;
>  
> -	err = airoha_ppe_foe_entry_prepare(&hwe, odev, offload_type,
> +	err = airoha_ppe_foe_entry_prepare(eth, &hwe, odev, offload_type,
>  					   &data, l4proto);
>  	if (err)
>  		return err;
> 
> ---
> base-commit: 0ea09cbf8350b70ad44d67a1dcb379008a356034
> change-id: 20250312-airoha-flowtable-null-ptr-fix-a4656d12546a
> 
> Best regards,
> -- 
> Lorenzo Bianconi <lorenzo@kernel.org>
> 
> 

