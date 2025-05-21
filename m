Return-Path: <netdev+bounces-192408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86932ABFC7D
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 19:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2700C7AE2B5
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 17:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D8628A1E6;
	Wed, 21 May 2025 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVl1VmY1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7281A28A1D6;
	Wed, 21 May 2025 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849506; cv=fail; b=qb9LsG1Tf8/NEdFw5sWNHGVtCjGN8E2AFcdoW3Sfu4Re+Ahg8eMkyhAaykZ94r7CkzO2EmDe0CRx+r2DfFSII7a6k2wVikL/ya1yIgBKCqMErkPowFEa8SZvWnn5PwFKhFdwCjgWzF1F1KvFlfaA2mnMVfq7IffYA+NHtAG/Lr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849506; c=relaxed/simple;
	bh=OxFAXGRReEilqDbJdlYpVvx+qjbXO033VYpYmUhh/L0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oJenafwBeHuzmZFoqgFcsZ/6U2YSNhFWvybXJKIgOiaExkOvwzh02B788fSW1Ll44KesYGJVHz2QgWoVTFqK+y1RYzw33Cn8UZBtA24qNvd0YpXZrpiiJQkpl9SbWjLIQ0U3Xgm/YoXC6cYb7/Oc1dbUDG0IvFO4sq6pDFYqCUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVl1VmY1; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747849504; x=1779385504;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OxFAXGRReEilqDbJdlYpVvx+qjbXO033VYpYmUhh/L0=;
  b=aVl1VmY1FANx8s2SXJRpx/Me6BFLt/aUtwyGJTs5Ew6/aFqqqW9UYCNK
   giWPKIqXRE/m6tl3J9KdCElrfY+OWgAbSAbV1IkZ9D/zsAt9IOZAV9o2i
   hPVSfQoiB7DOu5iPMgquXloorMjPrS50WVkZVD1VTKJDDFIQjzANy4oVf
   U66pyTE4VQsUjpUCw8TrW76swJoFsbyEgQ1o/qSfb0WqS0bUr+Lvfu4sW
   W0ONrfY/mOo11Yzu0X5uvCEu5rdJ2vvaWtblKbaxQm7DYGQz/CQ5HcMQY
   ZxEDGBvlZrnX3Lx4GaDxihTYj2YJp0N3se+0DHFlkLukxNDmAcgO1Y5FQ
   Q==;
X-CSE-ConnectionGUID: iPVOSSxrRzy9ev5LFwVicA==
X-CSE-MsgGUID: Ct0k2hwcRYqL9CY65x6VAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="37464158"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="37464158"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 10:45:03 -0700
X-CSE-ConnectionGUID: GpZ2XPWCQsqOhomPr3RCDw==
X-CSE-MsgGUID: EOgzMQYbT86kQDpvacW1DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140700948"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 10:45:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 10:45:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 10:45:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 10:45:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUoe4m9qryHOAue4mBq8EfOZ3Z6bhMVwfnFRJ5Agz7dquqQC/kyQ91V1Qb8hZ0hlAkyYmCxIgNPZjIAJ+NUTQxkWtfcIn8plsaS6RWyqpLLPNq9R8NGu0vRrthFM+TOmD5uoAQMSSvjxAzUa+EG9zMagbNwL2GpSmgO3NdcvmU4TRCu5+Y4aoxBv9Cm6yJzHQh5HUS2TPzEEtUP8QwwS8eD5ck8fs/XlbhWLImUmToB2fnuRyEVc5LJ7I1icQOl6O+YcaNcNyrDcrHkJGuoKYTlUnXHxpjU8W9NhuQlu4Ynn1TiB3Dl2/FHdrcBgEBZVvTauWLr+aciqWseVSUpk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVUnOQS3svdpCVyChD2fzF3MncaiDsXBrLYlFPUAL7E=;
 b=KFtfHnfapFuxMB9w76m7ZIhpJ9otp/1UTrcbOl0PBn+uZWHQPnD+TZQBGFAMpztkfrlr7c/ocYWAOqqxeFvO8K8TnY9rR68plf3yp34uKzkXWYGeb18VsOtgsc6NG6ZHxqwC0M8AuNBtNSle7q81bp61bUh8eeOM3td6kpKyCALXT9gsrsWvoH0+UTS37wJxtyoNAXLO6hioE9htu9Q2nnV1811knZfmBmZfcksF1Mw7aHQ/BHpbrRC3pRV6X+glocu914vasO7na5NROsY2dmkapAx/Z5ts801IpcKB15gfCidwMK/5fuqdiKCo+layWQKomJADjI1a35rD9KAzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5922.namprd11.prod.outlook.com (2603:10b6:806:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 17:44:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 17:44:31 +0000
Date: Wed, 21 May 2025 10:44:27 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 03/22] cxl: Move pci generic code
Message-ID: <682e10fba8a1b_1626e100ed@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-4-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: e7514059-0a3e-45fc-934d-08dd988f2409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D5oyeTXUrsozuN73tGgZusbV4VuI4ROsTL4xi0SsT7MrIJhdAiURVqX5p7FV?=
 =?us-ascii?Q?H07LDJZFCbCuoYjjgUt/0886mAogeqqVnGM9K5+RSLK4sEHLoNEe7QLpnviZ?=
 =?us-ascii?Q?daAv4EfMTm2NKaI0d9j/MOG7jR/N70RunJTd/qp1a5gXRGMXMeZq4sP1wjYo?=
 =?us-ascii?Q?GAvO7Ri22Hwhosr9APvoowJiIMpaoqVdLZYPNkQ6CVhntpzRtbJKiXkQ3bG9?=
 =?us-ascii?Q?VCzhn7i46xR6aydHWIfp40MClSp0gSgXSPqluZOZ0m+cO3TonNqaAeIu84/e?=
 =?us-ascii?Q?lHGYISKUbNmRPuZMxaUltyO1YhZA7+crLiCBbUzh9kYaPfatFNYHSU7Nxtnb?=
 =?us-ascii?Q?keOkA10/nkyBFwf4D2ZcU6GDt47raO7aYs/OtN5kDFbtGtllppmyO1Xt07Ad?=
 =?us-ascii?Q?A+DyQKHnMGToqUBCipmXclsc1YEqHaDP0vQx6hXe8+5wemduDfhdbGVzo48D?=
 =?us-ascii?Q?uqRVMfhce3BU0eiBkoHzkgLo51FgKNa3ZqIrD0uQiBWFWyfRy6uamkzzA+vS?=
 =?us-ascii?Q?pHmUddNvp4TudV8gu+ABv8j6tK7jmMer6l94Z+L+EQD5Jy0z/0JEHV2lXwAp?=
 =?us-ascii?Q?pUbMUUXeCNEa9IHAUP9lbd/SB35oBy0SY59wTzrNblN8ffrMMg6ZZff1Ty04?=
 =?us-ascii?Q?hrev2DbmQ+ZDAGOLLp+KsrVlssbxQQPP4Z+qgaUn/QddqJ4MCcqzQasbgvpC?=
 =?us-ascii?Q?GJPjG6RmnnmojDzAKH15bEnRReFGs2z/Ib+nLLEeeIZwlff6+ZRRvZYaQ/mu?=
 =?us-ascii?Q?O1NpjVsvPZPGPb204lcMGnHM/2NA3ziAC0O06GDHml55yzWmSmlkbS7si+ec?=
 =?us-ascii?Q?yHW2ZtvEwmycF5mUD71VbsvklRoDwzuPBIOobwiy4eagSMndrKDaSB5/oEZZ?=
 =?us-ascii?Q?GgrzIkdYYnaqFA3tGaRZb+SrlK+k23ul4qZAEFACF1ZDvvEKoUkVlVcNnK00?=
 =?us-ascii?Q?uxgN1E2FKbAXS+vXm5pRoS7HKhASEResPzrvLR7fX7puWd6EFOx0C4NH7egD?=
 =?us-ascii?Q?FF/CJk38BOt+4CJ69upUQfeAoqYs3xBe9+lwlCfj5Xj/70SgR47oCFNTAcG+?=
 =?us-ascii?Q?gtRsPE/Ie7W7g0MZw7UmynSh49HeQdB7Ktt7frX68q1nlM1abU5aANJ/ocVz?=
 =?us-ascii?Q?KZYYN9Yijuwbuhv/aFATMQX3WarZtoIBCYBLyAwssWYMDYEeYM0qSLhklGjv?=
 =?us-ascii?Q?jxlUiL1PpNOoNxPjJVAbSdBLig4TNCIw74v1+0qcYzpj0SidApNCdyCQh6UX?=
 =?us-ascii?Q?Jm2aquWaYDoGNXxk13eTnPLuApRNA7MuBNgnBlIc5E53aeaTq9v9i8X8c/YF?=
 =?us-ascii?Q?SSIClJenRmfCbHPEXp8D8nVAfz9iparjftAk/7VFCGDALqRWy6p0C4bdyjyV?=
 =?us-ascii?Q?L/vItZ9e7F2EKR9fhn46f06rjlMqcYN0YQ1kIsACbALM8TlvaYKoATFnO3T7?=
 =?us-ascii?Q?qW0pXp4zSsgK8iR63r3XNhei9QH408SJoswnYBHDpeId0scjKLeWEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B2KitXfjkU/9F2KrtQVa/XxV5YgfEthO8yhFQuyqGH/4xes82VrBAp3twvIM?=
 =?us-ascii?Q?519BWNN48v61fvhLodEuzLHXpt0UsHJGnORTFgUfFuvQx6Q7Luyp1oTOJdMp?=
 =?us-ascii?Q?ndaa56DHYv5XSKaSjHlcBwpYT+0xD9xhZ5Bqj1uW6pSFf4tnHhAkQC5UzMV5?=
 =?us-ascii?Q?ZszscU2AyYm7F/iBAONR25/CGd7XaKtfkMDStzqVriycVuPkD6+IF5dwoXIq?=
 =?us-ascii?Q?ZovBG9tUR1+tdmyk0gW9NHHzhI/Qd2pIrX5cKgz4Yi9UnZfrNxen07GL+puN?=
 =?us-ascii?Q?ABBhe0yfs6uuN6ma31vAzOaIPVK1V/rsdPR88id7hXIzlhCG4Uue3B5Q9grU?=
 =?us-ascii?Q?xxFuL5EW3B1WgVEGFV1+9RfqqbDlDTe8sATdvbWYUIhUnpKiWi5cwNDycDaT?=
 =?us-ascii?Q?CdOiN3fvh+XROUuf737Qu2ZcpbfCAWu4rb67KdG8bXuVwQmb9NVd0jJMTqM8?=
 =?us-ascii?Q?3iAvzLpLXklw5PZGCk30ExrdJLjm9QcYjrR5aU19ZZWu/+2TROvfG950cEBZ?=
 =?us-ascii?Q?iDPCIV1S2MT8pvzSMVPKHsP8LdYZPKdkgFeQRdWaMlKx/qx476MafOTx6gYP?=
 =?us-ascii?Q?Dgrkuv+Mf/pG2KXuApacXBEke8BfCQu9TfQuTzg3driSpYovWn6b83zZT/RK?=
 =?us-ascii?Q?B3Vdo8AA66vhU6Cr0rTtdJVuh8WD/QDBW3YXx7qRYmh1JoOkLrT75rIngb7P?=
 =?us-ascii?Q?yYfKqC59ZFRExnF+2ekAsH8l/1qO4LazwjHePXRVPD7QLxVXcU1aW4m1pZLz?=
 =?us-ascii?Q?b4U9zA2jALtMiKq5N/NFuIKVz3lYSt5vz9RUwe8xQeVrfYwSpLTNnxWTdYNP?=
 =?us-ascii?Q?2Dq3beHpMQookH+dUYfnsvlbcE3kdxrWxFGSzJFYSKx+pZ//g2NaAtsEMUkO?=
 =?us-ascii?Q?AfVohhE9EKvjwyOfZd+o6hXMqadhOSK5FJnJr+Yi33mQybQYq5MWI8wla8DX?=
 =?us-ascii?Q?svZvImkoL05AP2KX/49NpUBvZ4h05CSRsmk6CihXsFWxoSoW4xD0K6NMFISE?=
 =?us-ascii?Q?5CnpzxJV5ADkfCrNoZzDqYQzsrPwAVZ0e7niQN9lOVJivLbk5oT0bneOQ3bE?=
 =?us-ascii?Q?iWs5Z9L43kfjFCfIG1Ehf/UQla+mrB4Bo5tMjmMry/JXAGoXs1o0LBKQ7x2m?=
 =?us-ascii?Q?tp6kDPytbj/I9y5d5Bzx9dTlcK3JpiZkhcLB3hY8a6v6jIMvbQDnAyapYdoY?=
 =?us-ascii?Q?DdhiIu44Xq55E20JkkNw5j11n186JRnrieurKUXe8vhnX16qT/IB/T6s0Q8e?=
 =?us-ascii?Q?Vfho0c9UFkV4L2dxl7SKIv21U4J81tRBc14ulgzMgNApdsdNaS+yKyW0Y2A4?=
 =?us-ascii?Q?NopjOAc2FGHY3LPO+vtl0I9svJzX2i0q0LObxkNqtMInH5G4XPfblFjefuXB?=
 =?us-ascii?Q?DXnvwIjJ7gwTgkP8ILhLspnkWVmsQ4AE/TDZ5vEO+veX7CC3uEkLssYFXpNO?=
 =?us-ascii?Q?q11tQdpV7VOWZS3GAkeXoIzQ7CYMt3bjHZJWN3k/kntbSr4cIN2qZlCaR1x1?=
 =?us-ascii?Q?m3LxeRY4ansGoRqMj8aAmWoBeiuHeZ1T0BAb/DnGl1q/9UCBkUy3IhW2xnGZ?=
 =?us-ascii?Q?NxzUSdLZaTOR1fcRT29O1bxGQhWvCJBAZQdzoGEebLHxPgLbLaMWolbYQPsE?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7514059-0a3e-45fc-934d-08dd988f2409
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 17:44:31.0945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOvwKa7DdJX3igltRxTS+pjI6dPh64WteJSjtzeI8SD3anwi3uouBt3i2Xry90oR9CN5X7Ypj57SVIdU/l6tBCSoin5hOjWlPCzzXjP4Ktk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5922
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci.c implements the functionality for a Type3 device
> initialization.
> 
> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> exported and shared with CXL Type2 device initialization.
> 
> Fix cxl mock tests affected by the code move.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/core.h       |  2 +
>  drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
>  drivers/cxl/core/regs.c       |  1 -
>  drivers/cxl/cxl.h             |  2 -
>  drivers/cxl/cxlpci.h          |  2 +
>  drivers/cxl/pci.c             | 70 -----------------------------------
>  include/cxl/pci.h             | 13 +++++++
>  tools/testing/cxl/Kbuild      |  1 -
>  tools/testing/cxl/test/mock.c | 17 ---------
>  9 files changed, 79 insertions(+), 91 deletions(-)

Yeah, simple enough:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

