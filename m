Return-Path: <netdev+bounces-128343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4579790DB
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 15:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B531F225DF
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 13:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133241CF2B9;
	Sat, 14 Sep 2024 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lR+dagkM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539B61CE70E
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726319668; cv=fail; b=L3uBjbPT1rMA5r3NuH4/28jjnVnWRLJxrBUphi9++FpU3s5pCksaEMZGjjJej6lMtq/+mfqShBBM+YZ5S15wYOR3ynahJnpVKjUErwBGFVpLVcmBAIhuYAOGV7YwgKF+8vuJ6Zvoui0epf+FVuQvxn8NT+Hx+jEjC7RGwCf63EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726319668; c=relaxed/simple;
	bh=5N+KdqCnxzkZijJ/BhGPt7MTtUTmOmaqxiIgpPD1waw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F1nImvq8daUqOnkTB7kpFRE1JjYqnEXxdBUcn/0oN5n3iL0KiQ0Mq48rpn9/aD8TnqbV/z/jeIk1e91OL3z3HZsY52tb934JDuI+LU/GWKCZxSWgsEiHcAEMATCh0H7HCJ2hoD8kQzWrXnrc6IuwvoH50XJGK/ht44DR3TnRt6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lR+dagkM; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726319667; x=1757855667;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=5N+KdqCnxzkZijJ/BhGPt7MTtUTmOmaqxiIgpPD1waw=;
  b=lR+dagkMndYX3yj4ZQQACyPRop+IiFk2YzSdLX5yUgQzERbCDWdWidkw
   tzSXRRYrYYSIXx8CLQxqVLBIjxg3ktAKJQUHcrXpyWW0qgiaorRAiCqf+
   sAYOFjfrD5IC8Rwu+Img3U5rxuwibceovy4QXfodnxjnHcGlpUrEYXQ3d
   Tww1j0q2IziFLKNMlMRJHWkLoSJc+Lu/V2byV3HuxXbcAzD9RUDgaV3L5
   DPUIFWxrZSjJIDanbU5ITm6rFSIHcgJPltWFOyN+BrCWZbii3lBvBG21W
   e67it3ywI1s+onJ8crbS0Ny7LLSFNdpecrhLmtDiPcWK6C2ASkI+bnNrf
   Q==;
X-CSE-ConnectionGUID: Oi1GhmhoTjy8yaUT35f/9g==
X-CSE-MsgGUID: 9Lops0nNT42X9/quzoryJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="35788847"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="35788847"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 06:14:26 -0700
X-CSE-ConnectionGUID: i/Mi7xSFSh+3W65tF5bfbg==
X-CSE-MsgGUID: 49gEq97vSB+if6hleheXYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="68388118"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2024 06:14:25 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 14 Sep 2024 06:14:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 14 Sep 2024 06:14:24 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 14 Sep 2024 06:14:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAgMWuibNZnUqlBeql9tYNH58fuaSDsB6yZ1bMArip4OLVyT2yxce0T/KwQiBDUiMz3ZSDNhUNDWFrUsYWaBVKQ1HZeywZRD+w1p8J6AgsBJFWD6G0N0MjoGbSV4BjljE8/YY6P4e286gDw/zGXDq5317TXLhhM8veu4Lk9uGKCxIq1xTG4NG6OX28qth608pdNgMQHgHM2YIs8KFxZkJYiVSMQDPxqNw/qn6jUyoEPSIVeFXUlBOXbSPWZVBunS+Zx+uQBCHBGnDFzUzFBgrBvl750uAZd6V7wRUVRpyAbU+UVBv+/u0QNxk3AKlxW0sxHdFIO79rEOBO91b2ztOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8za5osWWOW1aFCUfmdRY6iOCKQfl52CFYIAbYgz/JI8=;
 b=HrKXPVsh4zHYrsgxnq02OdfShUdUkLY/DZRRxJUts2nCP8dpax3Q56fSWcOHzxyuHv33771PDrA5SM2oF07gptzpG76+xi6yYcyt7XNfH+/OcIhr7LnLvOkVQekEVwZWWiXu1ONr6LovE31vrx0rwI6yfyu13QHN1r44lhrQ4cVm9/HkReoMemk5bxC/EAfexBqMVWoS0fTh5FVO/qvvSB7SGHsNrGlUR2OoVk1MFx2csH8LRw175Rfu0KC9dvfI50uTlM6SisUtJtatID4u0aMoRYzj2biYglgx0xl3jmxkrrBERAoHAKDUXSM7ycn8jXIObwYdE8tIrzil8xJ2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SN7PR11MB6921.namprd11.prod.outlook.com (2603:10b6:806:2a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Sat, 14 Sep
 2024 13:14:20 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7962.018; Sat, 14 Sep 2024
 13:14:19 +0000
Date: Sat, 14 Sep 2024 21:14:10 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, <netdev@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, Mina Almasry
	<almasrymina@google.com>
Subject: Re: [PATCH net-next 10/13] selftests: ncdevmem: Use YNL to enable
 TCP header split
Message-ID: <ZuWMIijAeT728Av4@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240912171251.937743-11-sdf@fomichev.me>
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SN7PR11MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 7048c17f-b06c-4023-15a2-08dcd4bf2429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e7DqiHlhEipOo9Avdf/vnLg/N+/uVGp1lLJKDrcF9rQOjhQOu3mUPjO9MtcD?=
 =?us-ascii?Q?L5HJrY2ine1uBRouLzpXW0yZJGG0HEfVHmL+FV48h3kVcbYSmbdnsVChmdj0?=
 =?us-ascii?Q?esb1SWp51Dtwv/BdSKjLOxb1XORQp+NHZOKQjdOuNXKa+7PR19QrarUThb7v?=
 =?us-ascii?Q?FGZjO+2HqYq17WBa6Tu+SMfOrCTa7BamfS+i+/5UsMCMQqEX3F+z+AslE9HF?=
 =?us-ascii?Q?AF9O/9JUyWzyAGUzghkB9doSM9/oJan7atz8t6kwhPVrZ3hnRSQyz+WlQAlw?=
 =?us-ascii?Q?DwKKiavVV0Qn+xNQ8sjxoKcchxGalNXP9WAuXS87MgAAoQiuIN24eOYqTFoj?=
 =?us-ascii?Q?R7KbuQKKaqZjJBjfwxksGwp9etPe8AIPxuT1reIdAx08V+xmhaq+wg5+XJm5?=
 =?us-ascii?Q?rxYcrqqeFe+QC4FeoWOgiC6U03qzmCqUYU0Pdt3m+4AJctJtUgk/+ngqzo79?=
 =?us-ascii?Q?ZtWtYPnEwuyVaye3iuIjjAJwFJQYwuXdN7q3WSYkKc0vDEQLfrNPtSHNdfPB?=
 =?us-ascii?Q?pFmJTk4mo4n84/PdyqYcaM/QpUYxShCXj0Hgms7iyC8CQfAugaoJ6DQievAd?=
 =?us-ascii?Q?bDp6BYN4TFL908Zwa7QCU5odi4gdSrSB3eDZeXDm/Bb21KH8ud+pFCM7YOwD?=
 =?us-ascii?Q?roDdukKoUzlZDtYx9PKhimwRHW5ylsI97U6Y1OvQ9pR1X0unzMpkGZFPCUsr?=
 =?us-ascii?Q?wiImITxpfLbvpxhZUNFL+e1dvamXTIju7F1syUf+tSeIeyrHfxPUhqfiIFjr?=
 =?us-ascii?Q?HIs68sb8geMj6v4s7GS378Km2dPfNPKNF0ZYmz1+knYuO0b8oRslrI3ROHMN?=
 =?us-ascii?Q?Jrt3152R4OMqkSdad/1g1WM0X2cJPCGA2bR8R9zQFEvcMJv9lr2qC1u3Rvsd?=
 =?us-ascii?Q?OLQdxLYcUDnIwwe0NK2GJjRBgrDdylAwnlqN0IxsdpubPFJkEHGOC3nZ+uz5?=
 =?us-ascii?Q?wCuKceGQLwkOMwOstbg8Ok2hy8wHS6gBTO32sWMTeu02pj6b1yrTiFxVDl1L?=
 =?us-ascii?Q?1xRaIyo8MS9JLYJ27hGZ4ATPPkRu9NiQdRAneyBvj77ofJsEqZsTZ3m1/gpH?=
 =?us-ascii?Q?l2K9vy6EAFAdxeyhEsV3e8VP8gLioAtMy8FfYIOP/V1V5FNlk0Q9mwZ8hkaw?=
 =?us-ascii?Q?girfUPYef7dDVLsGIrPQA+2zbdCXwtaU7pftScZR/C7vQNkCn9tvHBVEpDhy?=
 =?us-ascii?Q?bGAvgrt0l0k33ymy9jqHtvsXHqfmePSiRN2B0Ncn2r01HFN7INxFLT3Tz8zN?=
 =?us-ascii?Q?c+wQXKLVq8nLWod56H6angWcIx8qtK3pBpiTiCRh9fyskQLchN1LQ4i4Ihu6?=
 =?us-ascii?Q?5dY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZasV6pfcwguszO0Tx8XRfDw2oCR7WPgDqkcMwIJJ0cZen8cWWuOiAddc58tJ?=
 =?us-ascii?Q?krem+IrW1C2pjyajKOHQ/BvsP8ELwpgUdCXiWacohNmqi37cKlbrtCsxwPeE?=
 =?us-ascii?Q?bacI1N4GF6Odqaguswhb3fs3LE4TqDFdfWeTJplWV7+/0T+9gnqZAXn+LXWC?=
 =?us-ascii?Q?qcEzAvgo5wEbwcimxXFEPstUqapzJjCSN8bDp2TCegDrPurqv8OMqEy1UU+u?=
 =?us-ascii?Q?LKJEGn5Vo+H9pdznTN1j2fmzJtsu2cz+PSfxxBnWVeY8l7hUSYH1u7grMO9T?=
 =?us-ascii?Q?l2/o1Ghlf0GEVmXDYyZ6AJ+k+muZ6XaTZNFpfA6BCc4jMKkwNQp4d93hp9L/?=
 =?us-ascii?Q?uaFn/vxQi6FudeKy+IudQu6jgmWgQSU7slyW53UEVcQ3X95axg8pirZs8OEt?=
 =?us-ascii?Q?Rbs8lz5+BNNZwaMjPVbYTgy6AbusMejJNKEr4pI1iNx6Le+UMz4MwGmvBU0J?=
 =?us-ascii?Q?ivk0DQFanwhIUqsPdeBHp+Zoqj/961mQ6T8YUCXZmAXca1fAw6Sg2ZDKjfR3?=
 =?us-ascii?Q?cToidOv44Uodi6T/NMrdWrk1h+D3Ews8CLywwl7HVDZ3S2fFlc8sEaBPH5M8?=
 =?us-ascii?Q?psvBqJyMvbaA9g2KaAOQcWgZGHs2HxhZ0tFDgIZBXsYtt7AecX7ByRskwUHn?=
 =?us-ascii?Q?joTx6qfCxVRIJkc1+N4VwdT0du+/1lGyKqr5rgJoGWn1QCNMGFQhERqK2DAq?=
 =?us-ascii?Q?n0sdGx7t/cWRYCZs4UwVFJjfMkMK8X4Wc9q/wSRpxdMJk7PBSileMo7ls5Md?=
 =?us-ascii?Q?MJwPpqWgEhPVi9DsKsJmyTQJzHqakpATojqDFreljmyYch8AX/o2aqhOpH1R?=
 =?us-ascii?Q?dCzCXTOJIXdQ43URTrr61Z0Tm0x3MQtUD4ykqsdc3ciOQEsI6f3aH4/PLQd/?=
 =?us-ascii?Q?fiLrDoRQIH48DPp5J3WTg3NhzPbIYTry1jV2ZEdsJq5BtMjNPFFO7EMJeL9v?=
 =?us-ascii?Q?/CPgzrZ9edtomVP264WKDBiaSGoGwibYRrTWCa5alal6zycPgJeCklsE8jNT?=
 =?us-ascii?Q?xvrda1WacOoag5TqVHvaCr3drn1biDlBzhx9Isscr3O6A18M1qshD//wTUZs?=
 =?us-ascii?Q?EmIwqiXfktjQc8m9xv9Ia1ZzcJJl4WIjQ7NxIryRgcIqm3x5L30elDlhqc6N?=
 =?us-ascii?Q?XGf9fsvkIAkE4uL+awG8e5PPO2YA7lvop5IbDEi2d2NETwQyKgHJQStL3tI1?=
 =?us-ascii?Q?cxIf1n6QhtuSCFTB4T6Fzug1oQ2aii9kmH/5WZByFhzyV5DHzh1LK09s193+?=
 =?us-ascii?Q?7DytNkDa6/SWdQtfU0rOMMBNCcoBRwMf8bL+ByhEwd1eu7/XKdCMVT8PzLcZ?=
 =?us-ascii?Q?GNA1zGbP6Ho8P307sRbwshVdeYrGUo8MvcFEynSz3DKBMiaiW7YFbH+NaV8z?=
 =?us-ascii?Q?SerkDis9SMvq9Nx+Up4R5hH+s7HyiiOEyWV79Xtj5J4eNEYHupDWYBXXLd6b?=
 =?us-ascii?Q?rWHasNAGzxkeW5IQWDis64LHCauY5uK3s6LRYC/aao18CYY22vo5Uwm05/16?=
 =?us-ascii?Q?ZutC7ZQQsBpgsPp3ayEWTW/pcXAtGSn0V4fB/aPbdFk19nkIznfVNLPDWiAq?=
 =?us-ascii?Q?i3lLG810eq24RFSUCSAtWrXW6N6qCRPwGJ6+8CPJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7048c17f-b06c-4023-15a2-08dcd4bf2429
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 13:14:19.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lt2Zb7XxOjuEOq9EobHE4mZxyT0qw1SN0DJ0azchiquupMCPl3za3UMyTtjbCxT6esutWoJ54lw62E6LMQuYrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6921
X-OriginatorOrg: intel.com

Hi Stanislav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/selftests-ncdevmem-Add-a-flag-for-the-selftest/20240913-011631
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240912171251.937743-11-sdf%40fomichev.me
patch subject: [PATCH net-next 10/13] selftests: ncdevmem: Use YNL to enable TCP header split
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409142047.UOZ425m7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202409142047.UOZ425m7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from ncdevmem.c:35:
>> tools/testing/selftests/../../../tools/net/ynl/generated/ethtool-user.h:23:43: warning: declaration of 'enum ethtool_header_flags' will not be visible outside of this function [-Wvisibility]
      23 | const char *ethtool_header_flags_str(enum ethtool_header_flags value);
         |                                           ^
   1 warning generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


