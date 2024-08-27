Return-Path: <netdev+bounces-122267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2659D960932
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD6B1C22F2A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9C21A00F8;
	Tue, 27 Aug 2024 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDok7abK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C01A00E7
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759070; cv=fail; b=uqujw/61SVc0DeN/nvD8wSSl+FLqzDf4SAUS8uaizR5PqsWTXtJfTr9AytnhivM/BK0KRFfpMnEulpKGMEuRIcjRRYSzNtNkrNdtqrNX7cXoBgHG2mWfe02S3CuiJAI1476jdFfPkHKLHlGcIvj2PCP/kChLKLmkLClHn0Fnvlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759070; c=relaxed/simple;
	bh=Ffe+t8cb7mDWgBm/gfE4M/rIdajqB+M+zcrgu0MzLS8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ohb0NyDKPukiQcT3uDG6ogBKo9AxeYrsVnn7NfyR5mCKUy5FhOFWeEmt8hXHbAiriC380Mrdi/ikALsy9XHNO3Fq1T+8Cr852gCtwxvMAD4Qjrol6KZW4EkA3SuGwRV0/jtjSYU5UZRQLs7ypaxHmbGAcO3vTGFYHKRllVmVjRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDok7abK; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724759069; x=1756295069;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ffe+t8cb7mDWgBm/gfE4M/rIdajqB+M+zcrgu0MzLS8=;
  b=PDok7abKWI0x2P5hjXCBqp+VWEKs++/SIEXHf57aQWF07fyeT4TrRT7P
   CUf6xZ2vi+MudkCsJVd70swKUcqiCYHwWbcgmlWaVN8lhyQwQi4tzzkYF
   UF6ZGx2FLuHuQ2GdkVDxCWDcp/OFvGjC9V1/qb4BtA5OhlxQz+YhGmpRz
   0Q+rSqGS5GQdeC94P89+73a34fmoZent9E1s2akMSqQ+MtM4/C33fhypD
   4QbcpXRTRZpbNdHgBk+PPSofuK8B1831otO+wd8jcLNNF+8EFURHnA1xK
   G3P0fYtQwQ/LnvNEaaknYhRxE6BWTc0GcC9k6lZZddVdzJNYHafiu7BbG
   g==;
X-CSE-ConnectionGUID: qvHMD2G5QQKFwSZyxgOOzw==
X-CSE-MsgGUID: SklsgtVdRHyy0jFUi8lMCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23406180"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23406180"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 04:44:28 -0700
X-CSE-ConnectionGUID: XY/CYEMxSHS3zisIllnNfA==
X-CSE-MsgGUID: cQcCO32/RP2vcobIrhyOVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="63145851"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 04:44:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:44:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:44:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 04:44:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 04:44:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/MGM4c5myFLc+piaDs5Dw6k+9x5ZhH/IuVXznCnIvyQXefTijL+Rb/jwfSq5D07XkyrmcteFa9M0Apq1cbr3ut15GfOpEwUnH2Nx7rbl4HOQGqI+4XTqA76XUBC509h7C0a6e9BabCnBQuGJpNhqdR9XG/OKJGC1p485smxYyUQFi3wqeqNnLigl9aKSEmE+AYtHnTKWiKjCctQICJ5tX4Nb7H1nUAeMS89vDbfvGznD9LE8UiQuteOxXPFvjSMgHb31ExLyYePBBYvbMIhmtCauysu0kbJBjtKhg0ssuKduwkM1BjwYRmj0M1EG2ZBrQLQJzo75On2WSbsBae9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0hNIrqshKEJb4QsSn645TZUTcxqyeUAbVmgD39IlYU=;
 b=bBdsAHfZy/JQG0bxLbkYcFnyFEM+Fhr4vVlJa6ohHjQyx/sYL++cz8CN2idQLvsr9YzQxPExwlV6xgPgnfSEVl1ybnkD3GxYhzyl2FpHv+C8+dy0OuioNqmu79veM5aw43x/tzk0IT+D7mr4W7X2+7sc1hF9SDTKdvnGkViGve6UmgXd7t4kCVAvwrFyKbMJqjsYLd4kzwjv+xHzO087SyjcOZjeI2Nnm+IoIEac2zzu6enMT/ePCvF3/agjmB54G8PX4ZSEcksjU4bDUzn6J0GCtjS0wGW3hhX3aWd4hOKgUG+reCtFWjzgpZ5Wxg6Ove4qBX9goDn3rL6SRheyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB6243.namprd11.prod.outlook.com (2603:10b6:208:3e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 11:44:19 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 11:44:19 +0000
Date: Tue, 27 Aug 2024 13:44:10 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Brett Creeley <brett.creeley@amd.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <shannon.nelson@amd.com>
Subject: Re: [PATCH v2 net-next 3/5] ionic: use per-queue xdp_prog
Message-ID: <Zs28CpU2ZkglgUiZ@lzaremba-mobl.ger.corp.intel.com>
References: <20240826184422.21895-1-brett.creeley@amd.com>
 <20240826184422.21895-4-brett.creeley@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240826184422.21895-4-brett.creeley@amd.com>
X-ClientProxiedBy: VI1PR02CA0051.eurprd02.prod.outlook.com
 (2603:10a6:802:14::22) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA1PR11MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a1477d-4d82-44cd-5c0e-08dcc68d9661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rnCylZJaxBi8d8bDC7XjNoP4S6LbsNzZrPLldVBW7nTFyuXysDNGRNj29N8H?=
 =?us-ascii?Q?59O9LMOmb0UUL5qQxDdzeKxpyZW6Js80IOKMN56h/z2wc8DKCGX4cLvYnuG3?=
 =?us-ascii?Q?nM+ulf/hnK/hWamryJcRTUNSV6QqHFUwfg3xzRjK2gh7qjCvhyv6Shw6vcrf?=
 =?us-ascii?Q?i+jrtiAv6nDy5Q34iK0nAkXMiygcLqvW134ruugbM++U+/2370O3TTZRHPEz?=
 =?us-ascii?Q?wquKm2vgavCpApLdYcpsYVejMCduYxyzEqXO7a3AyZDELYV8QkPa2W+niMof?=
 =?us-ascii?Q?Q9RGZXUtyptMXOIIrSTej/Ofoao4+96QUC5lRwKdFjsABia1u0ht4KATIdQg?=
 =?us-ascii?Q?EbSWl8dkuY4YLNj6UPhfs/0Ij1F33nccDBVMXkHY/BmeKygOtG/SEa0WoMaM?=
 =?us-ascii?Q?ulsmTdL0DQTbyo6TGHVfIfnobedjpAkPgmm5+dLrlPPmHcwVjGDqLp04WOmV?=
 =?us-ascii?Q?v/K/k4g1lXu5jYB8NE9bbClq1pYv8JJ8hPB8JOMTFY2UIAxOI2hEP4n83wNq?=
 =?us-ascii?Q?AITkNj+EfWKojVdTh6rw7EAbkEAfejUywbnVc/pxQuzg13AK2RyBsJ7vWyFY?=
 =?us-ascii?Q?DsxYxKguNdG6vTLE0xRi/6ksuW/AXq6D0Vm9XZ/0jjjN7g1yB5Ag4Vah8FWa?=
 =?us-ascii?Q?YS2sJq5BujgjL+L+WDe994oOG7SOaA90uigLJ1uxFVpqa8CK81Q0TPCv1D+p?=
 =?us-ascii?Q?p1vn0WUfAKwNxdgBaW4d5xzSAG6cP9V6nZv/iLZu+TLraM3gBv0GMz3NAKj1?=
 =?us-ascii?Q?uSi5jk1UarZQ5JUlJLhnBYPWWAbjPTCIGDc2IEyT8cMOzcrSKogKikDVvdbU?=
 =?us-ascii?Q?PnJLLdVy0yUPh1R8LU95OqxORdPMLD+YvPbPIxcyzCG4UTJfoQ75DpPmdusw?=
 =?us-ascii?Q?hl8svQAT7F7E0D7e+e4ZI8Hrl7ULw/Lr2h+0KfPVeRdaG50CPZqmA9YNI42m?=
 =?us-ascii?Q?E4Htc42bLcygEfkOxkxGtDWJ295iYYXA9RCNmmhPfqsZrFR2hNdOzFdRqNE+?=
 =?us-ascii?Q?+OIsuBVIVqWt6CUHdS7KqH770IqoNL0vfMWPUL8r5qKdcOVxcfOKbVV8RT3G?=
 =?us-ascii?Q?DEEP2l1Us5ArV8PwldbWCv4uvQvRdj29i4Ev7VKyITqRVfBKJEgcHTZT1j2v?=
 =?us-ascii?Q?Oq9ndnhZXnj5inn18JgDXhWYSZ/+6cRdnCfeydLU4HoSdFYUCmf91MtSsumz?=
 =?us-ascii?Q?2dKJp6RrRgPUIvQZmmfbu8kJE8eDnjDbiU4epOJWCb1fkhcCebjlWBIDZVSc?=
 =?us-ascii?Q?4tm4BWTuXW0f8HfULuYQdrljM9i9E1QYeueebFik1fOs6Ua5f1DQia7LWnYo?=
 =?us-ascii?Q?9ADenylyXS9yL5pKEHm6889DTDLGTvVuICWK2zY31DFL9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4YStO7pASqTQY/ese4sOCcwqK768SzuGOF/vCdsYuhCwLzm9PPVfmOLeEcdt?=
 =?us-ascii?Q?6TTZ81Du6l8aD83WZ3gp+Op91fEujbftz6gln+2plUuled/gmSoSiwZwqmft?=
 =?us-ascii?Q?deLBkWf7zmvfBgtcvJaiaCKupSbkZRXfEkVPoVzCvJrhMHT45Z+Mo+u0IhaV?=
 =?us-ascii?Q?ZtYztToM0WCtXJ0Pv7NaCsl6V/U/YYLyx538cQCmsW8t8S9C2jyDyEJiWtIY?=
 =?us-ascii?Q?eIbrZiBX4U1mBnt/OuEJEKEHvrGbCxzVp8ZmnlZZ7WCMZbajlGM+5GEFOtWj?=
 =?us-ascii?Q?rOEmZZcQsvatCyUYPwvpZJrG6grj50mXZSel3Axde8AXkMcmn0fkGhqS4VBN?=
 =?us-ascii?Q?Cx9/VLZLktN5G5QPrGAynWbSnkH+SVwwracUFAJjlkcyj+j/KgvmfPX0d5KF?=
 =?us-ascii?Q?W+jywq09Q8zLBlOYu6As3NNVsHx9VYwF+ecxUk2eDqAU5HbqyTLIxQunrCy2?=
 =?us-ascii?Q?UCfJS3fomkLm6b7CPHB2to0BgRlwar8jIWiL0+Sxe3iS/SScW44Ct28KXUZr?=
 =?us-ascii?Q?U5VV0V9i3giW300Rb1eNFdRLpJ9bUc4TQkUA5UXjcMHZuOczVGx7LyWVTkSp?=
 =?us-ascii?Q?d2aHix7fS9kXjwdGj8gCOWCS7a3MBWgP/Xe8egAxVO9rK25O3wgg6vQYOTlU?=
 =?us-ascii?Q?SSX5HhdSY3I0qoTQpb5tO04jjL/lRZLoba50ywxIWSXVFKw0CbeAGboThGtI?=
 =?us-ascii?Q?KveEQL05rVDYkj7JuTXCfcWzGxSZLjRKeiuiunKmeyWrfIlWMXxBx+rrQ1J2?=
 =?us-ascii?Q?/SM5Ity0ev6roYzqY68c2+HHM180jw2Cr91kimnHg6SLll2YlErvXlH9tVO3?=
 =?us-ascii?Q?HtXqU6GkeMb6RtzaZgYXikUPQmNLLr+UM+gScnJ9V4KdSNhCu2MqVS7gUqi5?=
 =?us-ascii?Q?kLquhcDxl5M8ZCn/7R0Fz/SYHwBQdwgqc7aIsa1VskMAor1enRr4hCn0HEOa?=
 =?us-ascii?Q?5GhoZZfX/vyOsfVffJ+aH9RwetHUa3VsMtkxeJcXEhcN0dyr6Ku4JlOBZpwz?=
 =?us-ascii?Q?mKoJ6ma9L10yQw8L8utIq/saX9tIRyUNtCVtKBNmWgaRIsbnlJdsO0CLxHi1?=
 =?us-ascii?Q?mzmBGvxq/cGTPiYmmQIckY5lVC+c6kDIsvZRahrkDYlI+Dt6y9Jz19nf7mxh?=
 =?us-ascii?Q?ACQZ+1yKsj2FuPZfEiZsQqvvRPNqiy3BHe6P0VVg1xelpbIKsSv5hgxVnU7T?=
 =?us-ascii?Q?F3W0P400WD7gjvXXlM1LPHOJu+X7OZaOrG8hqU96TDUu9ImtwWuQ557djoSS?=
 =?us-ascii?Q?tPLtEJv5V4kCDZ7761p7tu+z3GX4RIbZ9j8jaW6IUJJCF5GxhN/+ivtsFyBE?=
 =?us-ascii?Q?H5zmazkdFQ/PdC2a3G6KlhXBrj/za3g2ZKnIHd/XqBwLg3/s+It7A3KK8FrL?=
 =?us-ascii?Q?m2eR/onEhrtEL8Oca3uZbHkGnvgIzrvYuf8wAyv78KUQvGNMOmBuHCQ7o9UB?=
 =?us-ascii?Q?Rx5zD5LkjNcvTvJ2GjfnqoZPlrSjvIKI1+DzwxrBM9c8JBKKShPAMlM/npXi?=
 =?us-ascii?Q?VfQh3ozrC734tctiWGRdRO4pgaTXk3egmgWVhPAR91zBO5IZchCryoYNHuuu?=
 =?us-ascii?Q?dkYFtWAFLQXM+/yiIhvWp+LgQrJfl95mS5oEWFJM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a1477d-4d82-44cd-5c0e-08dcc68d9661
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:44:19.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sh42G56aEQil4F3oGrtgK+TMYUVd5WIEf+FivKuRLNP8AaDgsvV4GJ+pn8k6AhjAHXg1P2Vtza38OvOArG/0iYclsrKa9vHbeyZCBz5zKJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6243
X-OriginatorOrg: intel.com

On Mon, Aug 26, 2024 at 11:44:20AM -0700, Brett Creeley wrote:
> From: Shannon Nelson <shannon.nelson@amd.com>
> 
> We originally were using a per-interface xdp_prog variable to track
> a loaded XDP program since we knew there would never be support for a
> per-queue XDP program.  With that, we only built the per queue rxq_info
> struct when an XDP program was loaded and removed it on XDP program unload,
> and used the pointer as an indicator in the Rx hotpath to know to how build
> the buffers.  However, that's really not the model generally used, and
> makes a conversion to page_pool Rx buffer cacheing a little problematic.
> 
> This patch converts the driver to use the more common approach of using
> a per-queue xdp_prog pointer to work out buffer allocations and need
> for bpf_prog_run_xdp().  We jostle a couple of fields in the queue struct
> in order to keep the new xdp_prog pointer in a warm cacheline.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

If you happen to send another version, please include in a commit message a note 
about READ_ONCE() removal. The removal itself is OK, but an indication that this 
was intentional would be nice.

> ---
>  .../net/ethernet/pensando/ionic/ionic_dev.h   |  7 +++++--
>  .../net/ethernet/pensando/ionic/ionic_lif.c   | 14 +++++++------
>  .../net/ethernet/pensando/ionic/ionic_txrx.c  | 21 +++++++++----------
>  3 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> index c647033f3ad2..19ae68a86a0b 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> @@ -238,9 +238,8 @@ struct ionic_queue {
>  	unsigned int index;
>  	unsigned int num_descs;
>  	unsigned int max_sg_elems;
> +
>  	u64 features;
> -	unsigned int type;
> -	unsigned int hw_index;
>  	unsigned int hw_type;
>  	bool xdp_flush;
>  	union {
> @@ -261,7 +260,11 @@ struct ionic_queue {
>  		struct ionic_rxq_sg_desc *rxq_sgl;
>  	};
>  	struct xdp_rxq_info *xdp_rxq_info;
> +	struct bpf_prog *xdp_prog;
>  	struct ionic_queue *partner;
> +
> +	unsigned int type;
> +	unsigned int hw_index;
>  	dma_addr_t base_pa;
>  	dma_addr_t cmb_base_pa;
>  	dma_addr_t sg_base_pa;
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index aa0cc31dfe6e..0fba2df33915 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -2700,24 +2700,24 @@ static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_
>  
>  static int ionic_xdp_queues_config(struct ionic_lif *lif)
>  {
> +	struct bpf_prog *xdp_prog;
>  	unsigned int i;
>  	int err;
>  
>  	if (!lif->rxqcqs)
>  		return 0;
>  
> -	/* There's no need to rework memory if not going to/from NULL program.
> -	 * If there is no lif->xdp_prog, there should also be no q.xdp_rxq_info
> -	 * This way we don't need to keep an *xdp_prog in every queue struct.
> -	 */
> -	if (!lif->xdp_prog == !lif->rxqcqs[0]->q.xdp_rxq_info)
> +	/* There's no need to rework memory if not going to/from NULL program.  */
> +	xdp_prog = READ_ONCE(lif->xdp_prog);
> +	if (!xdp_prog == !lif->rxqcqs[0]->q.xdp_prog)
>  		return 0;
>  
>  	for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++) {
>  		struct ionic_queue *q = &lif->rxqcqs[i]->q;
>  
> -		if (q->xdp_rxq_info) {
> +		if (q->xdp_prog) {
>  			ionic_xdp_unregister_rxq_info(q);
> +			q->xdp_prog = NULL;
>  			continue;
>  		}
>  
> @@ -2727,6 +2727,7 @@ static int ionic_xdp_queues_config(struct ionic_lif *lif)
>  				i, err);
>  			goto err_out;
>  		}
> +		q->xdp_prog = xdp_prog;
>  	}
>  
>  	return 0;
> @@ -2878,6 +2879,7 @@ static void ionic_swap_queues(struct ionic_qcq *a, struct ionic_qcq *b)
>  	swap(a->q.base,       b->q.base);
>  	swap(a->q.base_pa,    b->q.base_pa);
>  	swap(a->q.info,       b->q.info);
> +	swap(a->q.xdp_prog,   b->q.xdp_prog);
>  	swap(a->q.xdp_rxq_info, b->q.xdp_rxq_info);
>  	swap(a->q.partner,    b->q.partner);
>  	swap(a->q_base,       b->q_base);
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index d62b2b60b133..858ab4fd9218 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -190,7 +190,7 @@ static bool ionic_rx_buf_recycle(struct ionic_queue *q,
>  	if (page_to_nid(buf_info->page) != numa_mem_id())
>  		return false;
>  
> -	size = ALIGN(len, q->xdp_rxq_info ? IONIC_PAGE_SIZE : IONIC_PAGE_SPLIT_SZ);
> +	size = ALIGN(len, q->xdp_prog ? IONIC_PAGE_SIZE : IONIC_PAGE_SPLIT_SZ);
>  	buf_info->page_offset += size;
>  	if (buf_info->page_offset >= IONIC_PAGE_SIZE)
>  		return false;
> @@ -639,8 +639,7 @@ static void ionic_rx_clean(struct ionic_queue *q,
>  	struct net_device *netdev = q->lif->netdev;
>  	struct ionic_qcq *qcq = q_to_qcq(q);
>  	struct ionic_rx_stats *stats;
> -	struct bpf_prog *xdp_prog;
> -	unsigned int headroom;
> +	unsigned int headroom = 0;
>  	struct sk_buff *skb;
>  	bool synced = false;
>  	bool use_copybreak;
> @@ -664,14 +663,13 @@ static void ionic_rx_clean(struct ionic_queue *q,
>  	stats->pkts++;
>  	stats->bytes += len;
>  
> -	xdp_prog = READ_ONCE(q->lif->xdp_prog);
> -	if (xdp_prog) {
> -		if (ionic_run_xdp(stats, netdev, xdp_prog, q, desc_info->bufs, len))
> +	if (q->xdp_prog) {
> +		if (ionic_run_xdp(stats, netdev, q->xdp_prog, q, desc_info->bufs, len))
>  			return;
>  		synced = true;
> +		headroom = XDP_PACKET_HEADROOM;
>  	}
>  
> -	headroom = q->xdp_rxq_info ? XDP_PACKET_HEADROOM : 0;
>  	use_copybreak = len <= q->lif->rx_copybreak;
>  	if (use_copybreak)
>  		skb = ionic_rx_copybreak(netdev, q, desc_info,
> @@ -814,7 +812,7 @@ void ionic_rx_fill(struct ionic_queue *q)
>  	len = netdev->mtu + VLAN_ETH_HLEN;
>  
>  	for (i = n_fill; i; i--) {
> -		unsigned int headroom;
> +		unsigned int headroom = 0;
>  		unsigned int buf_len;
>  
>  		nfrags = 0;
> @@ -835,11 +833,12 @@ void ionic_rx_fill(struct ionic_queue *q)
>  		 * XDP uses space in the first buffer, so account for
>  		 * head room, tail room, and ip header in the first frag size.
>  		 */
> -		headroom = q->xdp_rxq_info ? XDP_PACKET_HEADROOM : 0;
> -		if (q->xdp_rxq_info)
> +		if (q->xdp_prog) {
>  			buf_len = IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN;
> -		else
> +			headroom = XDP_PACKET_HEADROOM;
> +		} else {
>  			buf_len = ionic_rx_buf_size(buf_info);
> +		}
>  		frag_len = min_t(u16, len, buf_len);
>  
>  		desc->addr = cpu_to_le64(ionic_rx_buf_pa(buf_info) + headroom);
> -- 
> 2.17.1
> 
> 

