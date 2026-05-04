Return-Path: <netdev+bounces-283996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIsfO2zn+Gmt2wIAu9opvQ
	(envelope-from <netdev+bounces-283996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:37:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 555EF4C2A52
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA89A3037EFD
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F583E3D94;
	Mon,  4 May 2026 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YolnfL6f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A51E515
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919727; cv=fail; b=TA2ocGIw+nnw5fze90q/WdkT1a0mcyNLLhjwGfGOEjWQMg18xzmDrU7w6PchmkvhbvFExgqckC4kmQzA9uvvrOIovLu5E/Ls9/13LMpp4qwSPG/PdfLSS7QzVT4p9BoMsbNuX4h0nuofrRToJ2on1h7vQy181nsFDqK2N/3NXDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919727; c=relaxed/simple;
	bh=YPSoINydVJYE+lF3UTCcIxmJf4fHgb3mGMZBMmg64bk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dSNGWRdk9fzRKO2ZBd/uy8U1eE7BmRPAGa0qCB5DJJmPGpOnJrBDQM7ALBQLhaZR8UXWxfQKb0xo4D2tWqXnfBhj6pEMwLo4WJ6CVrd8Sis0m+2aLLkODyJ+9EPIYZ8j97Mp3JttH1L2/i6vYnrR60G5bgREmCL/z4aZF6FtGTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YolnfL6f; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777919725; x=1809455725;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=YPSoINydVJYE+lF3UTCcIxmJf4fHgb3mGMZBMmg64bk=;
  b=YolnfL6fiQuXlNwC0Zvlyx8gC14eqGYk8kqZyIYLYTnZQkwKRSNIN7S/
   38YY8iFpgv9PpJIXvWWhrFiP8q01PYrBsqNHxAs+kzJcoYq+7eKdu9ylJ
   RLYrYBkbjjf4q0Lx4ECRHolGQlCG0aKkkS8QI0p0mGD3UEWVnzBX4RE4S
   ot5zbjEHkwFfnqo34bsxca/LfxNr152P2So1YaytZiqN3wIebdFihF2o4
   7cBzVogiKgSUnQ+V4H3CX/4DJl8i7sPwh5bJctW9pqKWcWGupGXRCuRTB
   R8HPIhPk6uK6BFlwCrTRDxpattp1LeoF0dXBMra64EMGatMRrI5K/2uht
   w==;
X-CSE-ConnectionGUID: w79En9tGQfGjTdsOkwak4A==
X-CSE-MsgGUID: qpDNXdw1QdKQJ/icxGM6rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="104233627"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="104233627"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 11:35:24 -0700
X-CSE-ConnectionGUID: F0w1UcbDQW6nIwdBAttbew==
X-CSE-MsgGUID: 0wTjhcCxRAaVpz1cVb7WJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="273713945"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 11:35:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 11:35:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 11:35:23 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 11:35:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITtDhZiUaNEvB1+6u1BNYaYuFIn7PYIbZVQY7U2R8TOADufub35lP06MQTZiM7NZ0QHgYwQQpvjeI1o1mgvpHma7v4GbCuluAHM+xWYLmEUWGriZEf1rg1GYmUtusDNsEbrDMe3chmFB2SPhA7XFpHoTPLRvPLvuQMLX+7X2wgY7zFeTlD/teXK9SZmefDyuai0+LvW8ApYOfxxURbVT0NnOAW59IF8zc1eIujCqKASeT9exrlFyFmYLN67sshmBPZrOtCJcqLtPmTrBaRkmCWvqaLkuksnx8tEdgt25e9YncZJIXAkpQl/ayF1rR1R4NQ3VX/Qh4ACT/MxCvybXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/fkL9T9klfDwMeDzYFBxbj+6Lj/a7X47IZjMIXt6KY=;
 b=UraRtYDupMdZoq5LNaF5ksxZmBfom0G5Jat/21sSbSdmNbFdk7E3kY4O2+1GqqZ88Q0c2LIrWQ/KmYAz5mS5u+MtRsPfvhWcGazs9veb+jias/zst+RWF70hxSPngQ8VEYqzLhDCz64ypbSmoRe58M5nB37sAbcvFkqf4eTAoRrBxJRQFLcVvGauk2cmldWTSNAA8rDC8Q6ZtripM0XAqkJdw0uEHM1VeEGmEb0+0lBeAXi0QKZgUhSinWz+qmu8/fQi2hPnQEAE18fm2yvd9B+BWfgFJeCIw3kBjullUdhxeF5yfxYH9ui3FTZAXkZB6leW8cBweaxThwxpfhoJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by LV8PR11MB8771.namprd11.prod.outlook.com (2603:10b6:408:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:35:20 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 18:35:20 +0000
Date: Mon, 4 May 2026 14:35:13 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, <aravind.iddamsetty@linux.intel.com>,
	Raag Jadav <raag.jadav@intel.com>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>, <anshuman.gupta@intel.com>,
	<joonas.lahtinen@linux.intel.com>, <simona.vetter@ffwll.ch>,
	<airlied@gmail.com>, <pratik.bari@intel.com>,
	<joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
	<shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
	<anvesh.bakwad@intel.com>, <maarten.lankhorst@linux.intel.com>, Zack McKevitt
	<zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
	"Hawking Zhang" <Hawking.Zhang@amd.com>, "David S. Miller"
	<davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH 3/4] drm/drm_ras: Add DRM RAS netlink error event
 notification
Message-ID: <afjm4XJx1WdO-J_B@intel.com>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
 <20260311102913.3387468-9-riana.tauro@intel.com>
 <acPjxf5XTYuR7sbM@black.igk.intel.com>
 <09f253b3-ee64-4fbb-8cec-820e9769aa80@intel.com>
 <adc6hTz-xMopiJsc@black.igk.intel.com>
 <69c061b4-eb40-4e2d-aeaa-5dfa47b2db8c@intel.com>
 <65c6839f-a92d-4122-b347-a1250dde961d@intel.com>
 <20260423092922.6c527d75@kernel.org>
 <615d5a74-0865-4f42-a048-a32fff23f8e2@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <615d5a74-0865-4f42-a048-a32fff23f8e2@intel.com>
X-ClientProxiedBy: SJ0PR05CA0151.namprd05.prod.outlook.com
 (2603:10b6:a03:339::6) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|LV8PR11MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d18865-bd6e-405b-c552-08deaa0be54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: iSVW20lyu2mrbH9qYlZTjH6qjfflo2EI/m2erELZm5sVpLS8BQY4Jn9qp4krMHXg7wZMAmARnadJ4swP6Im/ioL5M2QW7JNi7EnS4wcNwbjogrC2KMUV+JbokXThPYKlIh8dITNxgXp99pfCaJtwZT9+sRezKlvCzpYB0Gze91ypqLBCO7O1Vmg0R9ELR4hUm4LrNVefSAQr8d1M7o7GNKKK7YU+22nwFKHOh6N8Hl1MlB2aZ4U1YSORG8Nq9Tk46tAAah8rWEMfCl36D8y0C8KbF//2kmlxJ/JYGX37RAq90gxg+yyC+jlLEpoQFfUpT5dUj1t5QpaMVUM2cTHAGu4Ny9X5uBNyX+azL0d012puBk6MdlgvF6OjfzAfL3Tbyr40mt2s5MwRb6mB4aa35HJP6fRu9w7EiM/GlHv56xkfLAPeWeSJxxGYV2xUpLmxrf5th8c+3LZx+EWb0nzBrFnBl2XQ5rIoXwpSslyHGNSb4WahLLaP2D1/SrCNtFBXGaZZtGjZtJS5g2+NGbOhJVPr8Cs/ypbKPEkNkydO9MqitR/VJxoaSCzDSwFc1AaYtiXGm8rszNE9830YRWUIa5PrrmSCIa1mIkRzVxFXdgs2gto+yPEbGIrHPkTvTxCwEa5PAuWuvKXK3bc5iS/UMDnbtOk+ByL0VgOkCApLXsZYCNyuZiPDGnT09hMjVqk6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NeblHsTKemHD1jGQZyFbhwvPGmY/k2PKua+e35J9duoCx6A1UXh/wiEMCP?=
 =?iso-8859-1?Q?eI8exgxzVzdt/VopwMyVu0suLqPUiw1FIGnkqbY9+Ysik21icTkzHWak8a?=
 =?iso-8859-1?Q?mpSDtRt0BYeGCXgfbdW/OYhqcAPS0TK9yvDlfMY9v1W1z04aFDuU+Eixrk?=
 =?iso-8859-1?Q?pRbY/AV+m8lmRdHLMMbxaz3TwPtqNr8vNC/tHPtj36sVlUBzMFQoKMrLoK?=
 =?iso-8859-1?Q?khPIosRajp0jmDB5So6yAOSeN0JhK+0ASJQ3/1w+5ROg+yjqkVas/UAi03?=
 =?iso-8859-1?Q?irrCgYxZDGEHKop9likaWvx7dberp0RLQXXCGXe5bE9uNq/Z9Za7yV+anG?=
 =?iso-8859-1?Q?03G5f9tJOIEUvlyhDuMmk4eLH6CFVXAgVlaOxgUmmB4GQt6poY59sNhBYf?=
 =?iso-8859-1?Q?D+fkukdaOBC4l4FcxYq9HBrpg/mGFwpca1IeQA9nMEq+rCSekdW6cihGk3?=
 =?iso-8859-1?Q?KsWR75It3CxVGV0fqP3LJaqLgkBjgDlKuWrcd1OOX8ldrE61rbcYEP6JVo?=
 =?iso-8859-1?Q?KPPa9WdmeCmX9yzNnrurSz8FoNf2iLvhUVaVy1V92RO5PjEAYxCCgoegEb?=
 =?iso-8859-1?Q?o8fSM8xo6RZQAR0JsDOOpTZkAj5onPNJ3MyyXUQGA7Q0c1ojJTIlrs1x8p?=
 =?iso-8859-1?Q?GYKZm2TTq/lYz+3zPV6B9zposO8NMJZhdCIMsGt6HXY0ODvtIDA/lxNrN9?=
 =?iso-8859-1?Q?Jd4SdR6108R2CtKp05E+SM/g41IQNU9EIQ1HLrSEIqT2K5Em+8gm99APlh?=
 =?iso-8859-1?Q?4pRnrhJjbBW8nLH8ZXMoQndnB0rlz8XO/GnFEyQpOdQ+9ieAqTRSmF1fqF?=
 =?iso-8859-1?Q?ag4SMIx3kAi+TM0NKSWFpon75EQ7nVHADMJx/62PBhzCUwm+KkjDIE9022?=
 =?iso-8859-1?Q?8JwLAZwGdQ7uVig5b/UgjBC03exwqtt/czjmFYcWR6W2bymzUg60SMvfkH?=
 =?iso-8859-1?Q?8e43/dR3DXMno9JCH0r0m/IqjGvt4wlMspcw3xd1hZolnqwHgMmRNLIubD?=
 =?iso-8859-1?Q?i7fGcxLyTJge04dhtLZItXIr1DccCNT4n59XBCweJ13gHdtgM1ZqOqpXyg?=
 =?iso-8859-1?Q?dcmqMZzV0rw6fnw/abfhUn6ZEmB3CmUw9z3TBlZ/88unFdhQnQ9/JPoHSA?=
 =?iso-8859-1?Q?M8XoJ447x7kUa46SDrCplBUiBOnSS3gOHs2akj5sN8pxfCJHmZdu2e9FoA?=
 =?iso-8859-1?Q?es1XRwIP0vASMwKTzGNpmHUkqRlfZJkBDq2vsCDRmkOkzf1EB4atIOxNRw?=
 =?iso-8859-1?Q?NLkADA2rSOG0OnaB8GZYkcXq+EcG0+XLo3N6ITdz1tT7Lyl/VSg6H/A4Lj?=
 =?iso-8859-1?Q?L+6VZ6pXkgUfrYsUhgn33DsEQTyEavBqjdEaUDcBSxAa+FeFmuYszK84uY?=
 =?iso-8859-1?Q?GHTOtmDhEo1omwdXfNSQxFpffsZKilabeLWYU05V8ESGtixabHuAM7jwTI?=
 =?iso-8859-1?Q?TVMDCIp7DskHuyO0Hs1KRmrLdU0Xo3SznTVVCMB6NWQWAWg0jV/OpCqVKP?=
 =?iso-8859-1?Q?w08wWesKunMl4wCfuoZN7VdqlbQG1/UtH3Dq57sJUqx2wCQIiEzANIP3Ko?=
 =?iso-8859-1?Q?aH7E0zaYWndX5TsOYgYHh5tKqBLRsPes3dp1Um20JUG2v7kKVJBDFuv99c?=
 =?iso-8859-1?Q?QLSRMTywbBRTCzyyG2VwPJK/YdNv4qPE2tRSoIA83I0uTdxpjvSuDjTpH/?=
 =?iso-8859-1?Q?51TK+FS9mRl1svXE2iXD0E14ubNFbGvvNvFEv0N4Q3HWgsVLwpyeXMMcRr?=
 =?iso-8859-1?Q?CT7ysEgmtMazfSrbquvBk+fYu5VaJ3LHNBGnLxhvEmAmMZbE9ct1kpY00B?=
 =?iso-8859-1?Q?vf7lVu8H6Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: jO1Ki+iXj/UQRT7nvKW8F7Cjba9t6KZwR+Z3eafl0WhUMn+WXN9I+S5REoO3OtnTnJnDgr9SI82BcCEopZW3AGn9KEdNN3HxnmZqVJnSkDx3KRdMg8eKHPQO6QUEU/JZh+D/qA0DMxBfXFwM+SHtzAXWKg2oPwTp+3nSEpwNOHBbapdsK2OQzKcp1sA3HtDTEcTRUgWpXSl6N09PPYMy/6BvriYw+tH5lNGwW2sjyr2IaF1Av8BhrCIEfwFAxcPJcsXVT0DepDa7ZWlfIea2xRvdnHQ09XmsYsLv3KX9AnGW1lJgo+b5ThhlcnyWCQAMwZin0yKuiv4eJN4tUrUkPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d18865-bd6e-405b-c552-08deaa0be54d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:35:20.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbbI7ifl/Yw0luxyX3eO3W7YajQoziNXWUyphBbi89MfA0ldZN1Nfdshy3jJcvgxA+bcYmGNs/ol7q6c+x9dyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8771
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 555EF4C2A52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283996-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,intel.com,lists.freedesktop.org,vger.kernel.org,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rodrigo.vivi@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]

On Mon, May 04, 2026 at 12:58:13PM +0530, Tauro, Riana wrote:
> 
> On 4/23/2026 9:59 PM, Jakub Kicinski wrote:
> > On Thu, 23 Apr 2026 11:22:45 +0530 Tauro, Riana wrote:
> > > We had some questions regarding events in netlink
> > > 
> > > 1) According to netlink spec, "Events are considered less idiomatic for
> > > netlink and notifications should be preferred."
> > > Since we currently don't have a response that matches a get operation to
> > > use notify. Would using an event be acceptable?
> > I have only glanced at previous messages but would it not work to
> > include the counter values into the "event" as if it was it was a
> > counter get?
> 
> We wanted to keep the notification general with error name and node name.
> There is another series which will re-use this event [PATCH v7 3/3]
> drm/xe/ras: Introduce correctable error handling - Raag Jadav <https://lore.kernel.org/intel-xe/20260428054826.1202076-4-raag.jadav@intel.com/>
> <https://lore.kernel.org/intel-xe/20260417085812.4013309-15-riana.tauro@intel.com/>[PATCH
> v4 00/13] Introduce Xe Uncorrectable Error Handling - Riana Tauro <https://lore.kernel.org/intel-xe/20260417085812.4013309-15-riana.tauro@intel.com/> .
> We do not have the complete counter value there.
> @Aravind/@Rodrigo Do you think we should add the counter value to the event?

I don't see any reason why we couldn't include the counter value in the event.
Although we know that this value is likely the threshold, I don't see any problem
with this flow. In many cases it could mean one less call from user space.

> 
> Also, there is a request to add other parameters in the review comments
> so cannot re-use get-counter response
> 
> > 
> > If it makes no sense - it's fine. We have been adding events in some
> > places, too, in networking. The thinking is basically that when the app
> > that does the user space monitoring starts it will often want to know
> > the state of the world. So we end up with "get state of the world"
> > and "notify about state of the world" which should really be the same
> > format.
> 
> Sure. Thank you
> 
> > 
> > > 2) Is there a way to check if there are subscribers to a group before
> > > creating the event message?
> > >      Currently the subscriber check happens in
> > > netlink_broadcast_filtered, but a reviewer suggested we could
> > >      optimize by skipping message creation if there are no subscribers.
> > Yes, genl_has_listeners()
> 
> Thank you
> 
> Riana
> 
> 

