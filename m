Return-Path: <netdev+bounces-188824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B2AAAF058
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14AD97BBA8C
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 00:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08B2153BD9;
	Thu,  8 May 2025 00:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMg1k9Ms"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25A84D02;
	Thu,  8 May 2025 00:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746665774; cv=fail; b=fR7pRvPbxhv077Y50HS//tyJeU0QdF/94Ijp+IieMj4UvSZJQu8xoblq8vPSUUqsCiSAWHzgOIrmrkskow2gG3fc3jEYSSk+k05UXKCAYMJFyfDMlCKhX8wRYVcxCgAOTaksKE0B7b//a8afKEqLl4IY7wHqwoTpRksR+Br4brM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746665774; c=relaxed/simple;
	bh=NfSItkx2c8OR3uyoPsXlGVWi56y2+3CIlfJnMiNr8VI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PRubtqVqioUDLj/v9Qnck/dz1b4emjOkN4dZVdAaQQsR3mwck+ALoaduHWifLxHzfMqW/WXJ7wq6y+0Sboc0t7TidzwxjifbR23bhwxhueXdWX+d8h/vHL4H5AqTnwUmE0nVxKLwaafPP5Tvti5I5QLu9AUpSb7c3V7cDuL9/50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMg1k9Ms; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746665773; x=1778201773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NfSItkx2c8OR3uyoPsXlGVWi56y2+3CIlfJnMiNr8VI=;
  b=IMg1k9MsGHorMV2a6nHQsBv8sUCSsmZ0g+K+qx4do6zv1Ov6blUWRUjR
   lpOgjpL/6C6QOKOJWg/aDkz5QZ5n1n778ZCDcMMnjG/zdPaHKpat0AL1U
   jHeTdUk7fKKkGYVSSzwRt0secJk3YhzlSH2oCyOVsRS9LeiyGYx97E3to
   DNNnV04Cs4920q5nPDD50RGNybriWk4yEVBn+V9ZbrvWpDCwQyyr/GUx+
   PFq90y/rxvvYQscNwAvofQaohBJaRG3PU09G1x7Izh9YlX9H4BJn9IxST
   M56DHS3CuQbklBNmprDTWhQ5M/q8ogHM5iSDKAZ6nVbA9FEuNHzhyOsyz
   A==;
X-CSE-ConnectionGUID: viUqqPLUTbyL35WkOIwoHA==
X-CSE-MsgGUID: W097MIjxQ1S9/fYx1W6yYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="47684275"
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="47684275"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 17:56:10 -0700
X-CSE-ConnectionGUID: hXZuKOZQRIuitwtYzm6weA==
X-CSE-MsgGUID: 0JuDDexOSbC1CWKeaHvzcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="140899020"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 17:56:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 17:56:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 17:56:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 17:56:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ9bHPyG8Zmf1IFKulNUsiJp+o9Sb0F4V64M2HZs5x7KbXtFAVefSobYW7hZldg5YO2uLpGXnC7e00W17nJtLmVQBnkC0BDhMMR5gbCAw2oFM45ZcbSNHPytxVY43ULYY5H7Cctz8xP4k6HE1ITam6UdIQjpyv0DAYo/bhsTG8S9cnKpqAxhgC7mwUe3anwkYEFPAK3sHRX7sOe8EuBudPCwSg8QLsz17NdkIQ00+Aucutf9RJ2BTkKB0AP1w+Hks93ZmGIxaWisFvXsnVhcmHudKdSQPB2SLPdyCC0y7KpWfHAjUQQicemd7QGfNDgADdFm4gnkUiSKzkJla4wyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gewOxdnxrkCBPFfOO1Cw9Gbz79g+9+CCaT5LpnHIylw=;
 b=aViJFt6WSFVoDCg2Ic6GsfJ+HwfGjAr/lWVWfZtfB4sUfnVREAsVxvSqqh0B2013wVpBtZCEdHwe2BmH28aKmAEAmJBZIgiCBHr9uzJnnVSQewBQFOT+mZEh4XNDZPODEKOwkpFAaAk1UtXAvJLFgW4RPZwpKMMnnySy1S/wsXlgrA4ifGOQ9FXtjTeZLJyBxcAFD0G4Zfsux5rqKRwdOFY4Oem7Ao1gQAbtUUGLpbcGH9/cdO0qHGHWHBRuEIhVyoy1FUBl1HNuZZOof8UxLC0rGEucHyvBkzDaTuIpFakU/yVZzEqRzLhUhLyH02ugHghyXhFaR3szzbU3JghoXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DM4PR11MB8157.namprd11.prod.outlook.com (2603:10b6:8:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 00:55:34 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 00:55:34 +0000
Date: Wed, 7 May 2025 17:55:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v14 04/22] cxl: move register/capability check to driver
Message-ID: <aBwA_CI5-eNll6Iz@aschofie-mobl2.lan>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250417212926.1343268-5-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DM4PR11MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: a19a1bcc-b838-4326-0716-08dd8dcb0a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?atxDSKfj3VsDThF1b0BSwVaNSj87qn3LjnQMSPBnIcyIJIABVYKzgfNdqD4M?=
 =?us-ascii?Q?5T1fAMDkF0Q//Wax9A4+4iHC1/2APS7FgnTCXtQDkSxhL251jBKQoeeW5Y//?=
 =?us-ascii?Q?GPtCq9eQ+nIdA1Ps3CYEXnKg6PoOF7VL3Y8hyGkOZzLyBhgtOFOKxNM/QaZo?=
 =?us-ascii?Q?blQ2sb21C4v1KMD1TuBS9DVb5/kasZno4u6Usb9HgV1nEoVjubeSal13/8sw?=
 =?us-ascii?Q?kEDE12D+ycm1JN2frQLwOH/QccSQhglzRGSfyUranmnKmla/sJVNDL0GCkHG?=
 =?us-ascii?Q?ui2cRVO/u4w3pCkKIrF7iy9yT47ce+RifIIR54cO8ydOU03Uei9ReRRmv2th?=
 =?us-ascii?Q?o7bfXgqsF3vruMK+xWfjejX7cZGBJwlI+je8fCeLylg26NIDCdRRC860xKmV?=
 =?us-ascii?Q?Ipd+TcziS3JJnUVH5b//cywsPVCHhxAS3jsurfJHCzJQXRZMRFEI4thXyn90?=
 =?us-ascii?Q?KU/oWEOC2yOHqlww8S8XOnmETjqnZPyrrUEG7nanMunKVfwO1H98uQznTjns?=
 =?us-ascii?Q?C+aq/wII4KGUZUPg0vxpeinatwTBdAVTx3I89UmxlHcBV4q38K4KOqp0idHE?=
 =?us-ascii?Q?A0bo82ExX6Uq2vG2lWFI6iPZhtv7Q2uKhXTi0hfPThzbScY8pgq3ufXpdKic?=
 =?us-ascii?Q?5iPWS8JGjlPiOtTJ8WSiFOvg9fKjYmTjAZ31xsBDlUvf6ndcyN5tQRj4Bo4J?=
 =?us-ascii?Q?yRSSfekFsuaeBaBqgWbbwYQ0m9Vv0/mYHJ9CuW67OSlwEXMCQug0iD0EoOmf?=
 =?us-ascii?Q?REmCQSt1cX0Bx0fX85oKn7oT+jhWO3PU412sbe095JJdcTGRGlRsFjWAL+kf?=
 =?us-ascii?Q?dwM1OwduhqbX4nGXFM/EKH49K/KkAIBW8M7KUOdXMLOj1kH680KkqvE1VmdJ?=
 =?us-ascii?Q?1doilrE+SPTd2UUllpHMkhQZrqTiTj0ibh9Fwz9bXOGx7cgn0GLsKFHjj7Hg?=
 =?us-ascii?Q?yruIaoFP4oS6/HVjkAlfZ4ATfTfv7/DxB4xarG2zlTXzbDdWeutLfdGN2sEw?=
 =?us-ascii?Q?S8zQA94IUbmikA8WczHE7kFBzG3gRo41BWBhzI/GJly5zCcGdRHDIt2yI+4p?=
 =?us-ascii?Q?yHojOnRR3uOAmVcU5RM2g0vJrQy8YxLYh4qtVQdu6SOg7PKC6s4lu8krZh9E?=
 =?us-ascii?Q?fPdsliCGBh2l4MveawtC4xdzrY+grl50krdU4j4FAhpdxMqO4ufDV9nKNa1k?=
 =?us-ascii?Q?eSZ9r8deAnKiIOsGax4pMt0MXe/t6EToSapMHx7S9u2iB1LPN+6bdtFslAck?=
 =?us-ascii?Q?Kxp6xwkZ9Z5wIMS8LhEy2kSLmqK6rX+8/ljJ/oMEpUV6dItYUagmu4u7kUt6?=
 =?us-ascii?Q?sLheXY/N2umAu+8qlk+Or8MuOAhc/88hUmSuIwklm1z+IUg27Dgxuzbkxj4m?=
 =?us-ascii?Q?9BZxFw1T8zVITEB55VPDx+H7KMD+tfiz4oVaX4CG3N49nUMUjJe+iHWVEms9?=
 =?us-ascii?Q?yvtNiBHGWOY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SuZQfZnfjOEcO+rHPtG3GFTiwLBLb2GpxwRPzlUTW0MILFZhm700zZ9qZqRp?=
 =?us-ascii?Q?LOub4YF2jZdEMeNtq4TW/HudfhTYVOjgnjDzeEmx/tAdO9tRV0PlP41yLHp+?=
 =?us-ascii?Q?IuHzoDx2IhXFQjxup61tioYD5T9frJnAwrFFvBPpNZc3yXBWuloZMDO2t/+X?=
 =?us-ascii?Q?0Cl71QDFIJUXUC7SA0hBp98R3FgL0ZAEwLCKYSCQ4c3Ea1aqCES3Ea12oQ+N?=
 =?us-ascii?Q?wR3spaiYQXJ1NrC7EjoR/PHZx1T3xndAuRh8OzxrfbAH0UD44hzpbW3dKVWK?=
 =?us-ascii?Q?WZPMse5YnyQRNAkTmkp6IFApLFtO6o8s7NDAYoY8VL/6hOxqdIwePDte8dYO?=
 =?us-ascii?Q?vceALGTun63o5Uk+0velzBwXwd7ZiVI+10t3qWjKwmNOdJ8HoQv6stsTLuUB?=
 =?us-ascii?Q?+kC/W6SAI4uLWdflcHAojBY157+Ca3eRPGF/3+DOe7HJ3ALnwD3ewYOKZuLr?=
 =?us-ascii?Q?8yrhFxjcfIz7BOXXeKkudnNmwsLoo59dGHxesR4frZzu1dZJXWbITTtU4uNQ?=
 =?us-ascii?Q?ihCm/mYL1LfXlO6FSchToG0c3WEipqZzhOHYLh1tq+As8Jxy3Ggu5FATR9bI?=
 =?us-ascii?Q?cD44AYknX4WGP69codRNutFMKmig7E3lXP1CVjy+DnFlrLgkCEmPxsVJYMrO?=
 =?us-ascii?Q?7rEb3NfLIY0M07qkMXHXWNrM+0TQeLEuP7OD+c8Ctj8r2KWq6R6ZN0lDJ+cy?=
 =?us-ascii?Q?eNwn2mVU1u8nbdkidq67+CgZIBlIEl7TeCRZFlWGjM5EbP5ntUUZr+9gSJTj?=
 =?us-ascii?Q?LfzrMrG5sMeW8v3FooaiCYxhmJqlvjIdUNm7A0SZ1yJE05HdvMOA1tOcN4Gl?=
 =?us-ascii?Q?s1jWsAlgXUHNleZmkI3/nmBw4nalnO5qn+AejR1N5B1nJGrVrCCZmiDnaRGm?=
 =?us-ascii?Q?RFAS7u7gT1amsJ+SUE/qc+EidIHFjyU3tsrn4mpa2r8Qviqh4o4ugnchlJiJ?=
 =?us-ascii?Q?whbSb/C97VA0z6WltG/jDjvfYYUWi44Jik3zZxl7MYqVciTLyUVlDhHuYzJd?=
 =?us-ascii?Q?wppbhJsVmJ6iR2r2ys4ZpaUAAG3kHKUAjwQs3IohhZL6uVnl5di4lpsDruM4?=
 =?us-ascii?Q?l03Fh0TR7zhzTE3YlvT/ARsJJa5CO9kLhiAPadXrXDDa/Fd3BB5pe4nFYLsW?=
 =?us-ascii?Q?fjWrr8vg1a+OCpB09z1eDINvKC2V3l7vlU5fPXADU3h06dgxH+irIPg0Ydtz?=
 =?us-ascii?Q?Y9RQEnTs7Apw5mXAby2u7lFIhkzJtYviWKB99sSh9l6nmjD5Cwl4LuVNx6fG?=
 =?us-ascii?Q?KitxkCXa+TDYN+gNmDFKS6SYtpj971iIQrghcHM2yDRjszo0lwx67azHQYrH?=
 =?us-ascii?Q?vQ82Lk3vRB+uonhOXEjcHpZrpqe+YgoZia+M7TR9P/dYhW/Cs76dSic/I1Xq?=
 =?us-ascii?Q?uLLOHZw10Fr/6PUQ5O3GZhlLWes61of1uMhPFSP+ysRyuykFFrGVGQA0YM8F?=
 =?us-ascii?Q?UR+Nkk3DqpE2DfzS+AB7mLjhAmKmRHQ2E5sXCSouuThAD5Ty+YLrGt2UFvhF?=
 =?us-ascii?Q?+64S3KrH2JJulzhNALyQlQD8Bl7BxrOKyT7qr3qRKUS1pm9w4xD1cM6lt4qm?=
 =?us-ascii?Q?LYN3dIX8sCS6EqzxtEEmOXNTAbcDSHw0t2ESrPKryOSaXWkDcXcKLfBdrX9i?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a19a1bcc-b838-4326-0716-08dd8dcb0a06
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 00:55:34.4047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nra0TFFv6rjtd0A7sVe8Ek1QyHB5czFM5zfNtoqE5X90omuLVt1H2sJRFZFO1/Up5AWwKBSxkJcezj+p2u8zmAOB1Zuc2Y/sxIxEeWRB1hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8157
X-OriginatorOrg: intel.com

On Thu, Apr 17, 2025 at 10:29:07PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 has some mandatory capabilities which are optional for Type2.
> 
> In order to support same register/capability discovery code for both
> types, avoid any assumption about what capabilities should be there, and
> export the capabilities found for the caller doing the capabilities
> check based on the expected ones.
> 
> Add a function for facilitating the report of capabiities missing the
sp. capabilities

> expected ones.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/pci.c  | 35 +++++++++++++++++++++++++++++++++--
>  drivers/cxl/core/port.c |  8 ++++----
>  drivers/cxl/core/regs.c | 35 +++++++++++++++++++----------------
>  drivers/cxl/cxl.h       |  6 +++---
>  drivers/cxl/cxlpci.h    |  2 +-
>  drivers/cxl/pci.c       | 24 +++++++++++++++++++++---
>  include/cxl/cxl.h       | 24 ++++++++++++++++++++++++
>  7 files changed, 105 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0b8dc34b8300..ed18260ff1c9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1061,7 +1061,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  }
>  
>  int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -		       struct cxl_register_map *map)
> +		       struct cxl_register_map *map, unsigned long *caps)
>  {
>  	int rc;
>  
> @@ -1091,7 +1091,7 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		return rc;
>  	}
>  
> -	return cxl_setup_regs(map);
> +	return cxl_setup_regs(map, caps);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>  
> @@ -1214,3 +1214,34 @@ int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
>  
>  	return 0;
>  }
> +
> +int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
> +		   unsigned long *found)
> +{
> +	DECLARE_BITMAP(missing, CXL_MAX_CAPS);
> +
> +	if (bitmap_subset(expected, found, CXL_MAX_CAPS))
> +		/* all good */
> +		return 0;
> +
> +	bitmap_andnot(missing, expected, found, CXL_MAX_CAPS);
> +
> +	if (test_bit(CXL_DEV_CAP_RAS, missing))
> +		dev_err(&pdev->dev, "RAS capability not found\n");
> +
> +	if (test_bit(CXL_DEV_CAP_HDM, missing))
> +		dev_err(&pdev->dev, "HDM decoder capability not found\n");
> +
> +	if (test_bit(CXL_DEV_CAP_DEV_STATUS, missing))
> +		dev_err(&pdev->dev, "Device Status capability not found\n");
> +
> +	if (test_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, missing))
> +		dev_err(&pdev->dev, "Primary Mailbox capability not found\n");
> +
> +	if (test_bit(CXL_DEV_CAP_MEMDEV, missing))
> +		dev_err(&pdev->dev,
> +			"Memory Device Status capability not found\n");
> +
> +	return -1;
> +}

Prefer using an array to map the enums to strings, like -

	static const char * const cap_names[CXL_MAX_CAPS] = {
		[CXL_DEV_CAP_RAS]	= "CXL_DEV_CAP_RAS",
		.
		.
		.
	};

and then loop thru that, like: 

	for (int i = 0; i < CXL_MAX_CAPS; i++) {
		if (!test-bit(i, missing))
	 		dev_err(&pdev->dev,"%s capability not found\n",
	 	 		cap_names[i];
	}



snip
>  }
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index be0ae9aca84a..e409ea06af0b 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -4,6 +4,7 @@
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> +#include <cxl/cxl.h>
>  #include <cxl/pci.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
> @@ -11,6 +12,9 @@
>  
>  #include "core.h"
>  
> +#define cxl_cap_set_bit(bit, caps) \
> +	do { if ((caps)) set_bit((bit), (caps)); } while (0)
> +

Prefer a readable and type safe simple fcn:

static void cxl_cap_set_bit(int bit, unsigned long *caps)
{
	if (caps)
		set_bit(bit, caps);
}


snip


