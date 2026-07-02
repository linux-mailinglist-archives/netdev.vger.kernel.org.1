Return-Path: <netdev+bounces-304196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tKrJNmZtRmoNUgsAu9opvQ
	(envelope-from <netdev+bounces-304196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 15:53:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED76B6F893A
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 15:53:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=d03ebgtR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304196-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304196-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F8593000BA7
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 13:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD09D4ADD99;
	Thu,  2 Jul 2026 13:50:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7948124B;
	Thu,  2 Jul 2026 13:50:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000233; cv=fail; b=rx2RXeWkLtYB8dp5teDuC/tHU+LEqXIr/97nejgBanCX6RLZu7MxvRam3WUA5//l+QSCEpiBwRAwT5VoVcc1Rex8YUo9nU8ug4gYnoqVKMKvZLoUjCfiPgT/ASSVMnTYRHG3roHHfOeEOur++5lVDIKTd0UGC2CKoepDfVmnb4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000233; c=relaxed/simple;
	bh=p6UC0TeQbSdwV0p7wA9x2b5mzDAvtDQmqvjpAZUi9do=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lvmGHhWebgb43Tc0zPQ6vHldyevj3G8mWCtM8e1Bvj5PNs09cEPYLP5K4QlBAtwRkFQowpBjmTq/p3vxBZALzJerbHyk1coImf+j4rikkYyhOevy4q6A2eScHX/Jgv2p266foqqxO0udJ/7J7x32DzVZ6480b4EACGKPec6aphc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d03ebgtR; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783000232; x=1814536232;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p6UC0TeQbSdwV0p7wA9x2b5mzDAvtDQmqvjpAZUi9do=;
  b=d03ebgtRWUjI0Nzk10zf2ks7BxUq+PKE3Q5MiwRrsY9AAigXeRlu2569
   +Pl77W/HfRpxEp0BkFfCRW7GVOl/lFgURlB3A21OJiltknIZ/Ow/RD/ur
   GAJRpbESXT2WsLgR7ZaX8NB8X7t1O3GLnzqln7dv2F3yK9srj7sREmK44
   wKxQTmC6bvBMecMR/9YZkie05IHCerTXwFHe1mzYZBBatxnbM0sm7R1Ft
   hCj0xl2HhqzCg1XYE8TLDsvRt/lQ1uk3NKTo7D4zjzd3A8NGxhZiXt5zk
   PbqMIwZDfJY2COGNFsXOtqppUwLKCuXq4farEt/kcUuDUeTGRlsyky56a
   Q==;
X-CSE-ConnectionGUID: GZb9rVctQ52l01/E1W99Vg==
X-CSE-MsgGUID: tCPugoDrT9ObaZ3WO3pUsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="71276742"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="71276742"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 06:50:31 -0700
X-CSE-ConnectionGUID: kRgNMUwGTp+GcVEk2n2EnQ==
X-CSE-MsgGUID: /os37C1CS7y1mvAv37saTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="276074136"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 06:50:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 06:50:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 06:50:30 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 06:50:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hjt7EFZExXsBKepk01/BdovJKI2kODuV5TLWK2XQaK6H30+CESCUUoSFyvUKCbZPmmrBeCVk12hvdsgs/HslgDgUV4vbojQTUQLVAjp/F0+bbJWRDuSvvP7FoR6WHq5DB0ZZ/MSrJMol6bpiLCPr5EGW0A9oHJB+DGNsFAVYYr2v7RYiLJbwokU9XeDHlfIA4oyX46SzFKp8ZeRmzsYOq7ne3VfBUiy4v6Vq/9bkJrTZnrKFNzI6TmdQ8JgcLx45qnbPw+U+XvI9lxXdyTK0lcSQ18RJDQ51BmMLM3v02T5rD6qSBUh72ViwHgKHuacP1QnAbYbo/EwrfevtGwL8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zijv5yZe46OI3uwALdj3wzePt4zqpINF+FYxz28jkos=;
 b=Ux51fUjCqbgGawoV/ZS/I9VbWPH88XZZ49k5gQr4ssOjOy3csKtAYicH+l2R3SMVaItBHu0mLIOeO1t/zPO+5l9FFl56iMwm1AdhtxmyMM7By+2457i4Lp7JCrXY5LrEiADJu9ZrldFhioXza2dlaXN3IVgOb0dU7q3afCrFY/H4j9OAWRYo66Q4xV8UEOVX2wnG7HthDGNpaHO+39S7T/UGyeht6svlAD8Qosh3lwGffCeYcJwhFjHHXfW5O33xLDrbhOQzkWg23e9wGWJ1MTf4/tr/0b56/mQFfq1xN673un9QMZFfxpvCKQaOo1loFEZF1hIykCRDAQSC+ytvnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by DM4PR11MB6527.namprd11.prod.outlook.com (2603:10b6:8:8e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 13:50:27 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 13:50:27 +0000
Message-ID: <02237688-9532-4fd0-8494-a7bb524ca4f2@intel.com>
Date: Thu, 2 Jul 2026 15:52:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] bnx2x: use kzalloc() to allocate mac filtering list
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Manish
 Chopra" <manishc@marvell.com>, Paolo Abeni <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, Sudarsana Kalluru
	<skalluru@marvell.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-net-drivers@amd.com>, <netdev@vger.kernel.org>
References: <20260701-b4-drivers-ethernet-v1-0-58776615db6e@kernel.org>
 <20260701-b4-drivers-ethernet-v1-1-58776615db6e@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260701-b4-drivers-ethernet-v1-1-58776615db6e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2PEPF000008AA.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::659) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|DM4PR11MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: c63e9729-b47f-48d6-9be9-08ded840df5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yeEJ8Fsdx9wtr4PjkjkuTyY/c443LJo6PeKH5jPKldkiukF2kx1gwA2+52r1x+o3JOhntsc6xgUngWBnOzi9uCOB1DCDyq3+6Ofo9LEhT28nsyw+ngFATW4bhA8gbo7kwDJ7YUrkCxh/mMH5M1zr+ZK+hEu4UVyOQBkdvbRgyp46cUUCBFbxgLjXoZHsbxVz92861Qs1I67Rm9jWYTjFU+37QbFhLbjkfWspVt7PlYKlsxvAHHZ6jHmHXynvfJhsf3E0rCH9FsKq8E1+8CsB96EZ77I2hPT+jd0GsuUHslJfef0RPwgfiJOVZ3Xe60/KdXMTVT+kxNHsETkmeyPBRgU4dghqvdiSRmgPBQo9Nst8IvkR+AB/Jbq/HaKpXpriOJqmqp36EhXB+oeXEWy3SS3vVlfzOMrKOI76PCZL22ev491fxvaANPxhQvAgvkQ8hyDmPUmNQ1QDjZlG4IKJwgQGFuOIQcM6qf1iB0pOSlckcM0QWGtFe1adqKFYGU1LKWfEswxW9u+Vfa3A7LJRzY8r5Sddos2IXrEswFrtl28/W5J2uBy7eOTLQCs9wvnAcPGegmu1CtU9oJKfTlk3G5aTNZx8wPgMYZBtlw//bRzlxyC3/fW9SzAxzES2Z/T+EEapMYK43Q/Ni62F2nSm5+Jv7PdTGCQZrP/mS6in17E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1ZXM0VRTDBLT3dwL2xNQjF3aXcrTk10bjZqajN6bnY3UVVzRWJiTjVoL0o3?=
 =?utf-8?B?cEtMME40aEZ5eHVRZWdYMHBqVkxzQWNoMm55dVFhSDEzUjUyc1BLenphUUgr?=
 =?utf-8?B?RHpWWkowN2ZsOXlSZnRRWWowdjBYeUlhWUFHbzdXQVViN1JqV2VhV3dFUmow?=
 =?utf-8?B?MWZJaThJT2loK2lSZkU2aWhlOFIxQ01pK3RvTzZMTjJ0OUh3VXFNaXlmNlFz?=
 =?utf-8?B?NU1JMCtlK3owaTJkY2tVeGRQdGl2MC82dHBJbmM1MVVHUVBHaTI3RCtlNDlC?=
 =?utf-8?B?WFdIR1gzdThadzhQQklMbDg4VlREMnZ0MDVjNnVKZldlSUZrOXZBb0JEdC85?=
 =?utf-8?B?ODlQanBmd0NUUGc3WnNYajBlTlZPN01HaTRSTGJEY2Ewait1UEpBQk5mbmVD?=
 =?utf-8?B?YmVkblRzRGNSekF3Q2V0cFcyanBEZEgxeHJDK0xWUUZlUklpZHR1d1lLRDNx?=
 =?utf-8?B?U1JuY25FSGVWRGtiNnF1RmYxUjR1elFWemRaWVhwdVBWZklkOXBHRkxWcmlL?=
 =?utf-8?B?OG9odVlBWHhmYXBhZnlidExrWXBXWXZ1VUlhRGRZd2pQQ1gwNHp0TjQyaHlY?=
 =?utf-8?B?SlZUMEFXY3hqZTQ1Y29MaXZTYmd5LzdPMVVzZGRyV0Rhb3hIWU1EcXc0UHg2?=
 =?utf-8?B?YnE2aS9ueklIdUVncUh2bkJsQkMzb3loWko1enVPc1YyRkRQeUkzUE9uOFVi?=
 =?utf-8?B?SlJack9BU1RGSmVrVnM5d2U4clJXYlhSVW1GTXo1eElZMG9uQVlsQTVEdC8x?=
 =?utf-8?B?RDdWSm0vakJBN2RkSy9RYW9mbzhjOVFCcE4zTkFPRitlQmZJK1J0NlRzaDFI?=
 =?utf-8?B?RjZRSWRCdGFqbHIvUjBxcVM3V3Jid2Y3djBaMGY1RklXbWNWVnhkKzFxVEov?=
 =?utf-8?B?VVkyV3BmTlpRRlZtZ3ljWmt1MXlmeENIMTJpZkphL01Ub2xFK1Q2eGt1dXR5?=
 =?utf-8?B?K3JlYXJFa2ZkbXBQZ1FqOVdlcVY4QWVIMjBGbE5nQjhVTWkzZXgrOWhIMnRr?=
 =?utf-8?B?d1hWRkVkeEVGM2QyZkdCY0FoaWFaK3VWNHZBOWtqSWFUMy9qeVJDVTZ0SEl0?=
 =?utf-8?B?RVJ6NzdlRGlTVXJ1VGl5LzNUNloxZmZTTnlDZFJhTC9KZXZFTlNLVjFXOU5x?=
 =?utf-8?B?L29FUUtPOWRZbnVjNFdCb1o2enUzYm8vaStaYWJweWpNSGcwQVRuZmtORTND?=
 =?utf-8?B?OU5QY0JKYk0vdi9zWk82V01HQnozTUt5bVBtbGhkRDE1T3d2dWV1R2xOdEFl?=
 =?utf-8?B?bFg5Ym5SRnpWaGtGakpvOUsrQTdjb3BZaHJ5THZpTWNyVGlFS1ZyYnE4TFho?=
 =?utf-8?B?TExkaGY5WjJKT2pwU1E4alcrRjBjODJCamJXTWZkazdJaFBkdGZpdURLbks4?=
 =?utf-8?B?QVdQYlRMMUtNekZkeW9UVXBldzVSM0ppZVJqMTBDSHNxbE5hb2tXYTJtWTZo?=
 =?utf-8?B?YlVMd0lZcFYrSjFlRnliZVRWaXF6WW1jbk5pWDhlQVBuaG5jcTFwZU1JcVBp?=
 =?utf-8?B?cS9qYml1d3VlOHRzaE5HNVBxZzhjL01SZi9wWUJpWnl5a0R4YUZxdmtsRk9r?=
 =?utf-8?B?cWRHbXd6ZStFc2d6cVFYVzMranhlY25jNGQrWHYrQUhlZ3R1SFBpRk5MTFFm?=
 =?utf-8?B?cFRxWlFKV0VWa2E0ZElBaHhON3hOa0VuVk1QQXlWdFZYbjA2QVZ3RXZ1MllL?=
 =?utf-8?B?blJDR2pzeHJMUHUzNFBmaytjRDBoUVRtdVlRZ21XY2R3MVVvRkJIOVB0dU94?=
 =?utf-8?B?M3ZRWTd4ZDNXejFFR3FIYm1RY2dydFdMUmY1U2p4K01CZXBuWE5jU0JhT1hn?=
 =?utf-8?B?ZE0rakhVWGEyUGFkSFoxdjVNc3VkRFhSZ2h2OHJpRSt4SVhpYlA2NnpqR3px?=
 =?utf-8?B?VnE3RnZZcXhYMGRhZmUyMXR3TnJXZDZnV2dwZ0NhNTdrUXZwTVhhN0R3QjVK?=
 =?utf-8?B?U3F6aGhrbGZ3THJLTkNSV0lrdUdvNzFCUDc3MWR3QUcxcVg2eWhBYkVhYmxh?=
 =?utf-8?B?SDNmL2Ywa0RZcVJMWVVYc1luQ3BybUdLc1RlUWpkaVIwdnZ4ZVZDbnVaNmlU?=
 =?utf-8?B?bytPdXNBQnFkR1diRXBTMENpbkJJanIxLytIeGQzV1FrbTFnZ1F1cm1iNWgy?=
 =?utf-8?B?TCsvRWtjU2JWekRwVTduWU1qTWNLM3pXWFcxNFg0bkxLdlJ5eXJKWENrM2VG?=
 =?utf-8?B?UHJvWEVwYlJXOS9oaTc4UHdFR295eW1YY29wSi80K1FNVHRsc3E4T0hVelh5?=
 =?utf-8?B?V0NUeE42L1BPN3BYVmduN1VWeGlDd2NrMEFQTG1LeW12NGwzc0V4eEFPNjNr?=
 =?utf-8?B?Wm9IbEttNXVBUGJXOGVnTzFESHhsSWYyM3g5WTBkUnN5NytuTFplaUFBQ2lD?=
 =?utf-8?Q?7AOXTgFIr2wUeLec=3D?=
X-Exchange-RoutingPolicyChecked: ocLiD8u1S/UPMAZmGeQoYq0IxxA+QkLvc2i+bTs1l6fD/qI+9I4VLlzUW2SX0Zwdc50b1KT7pjbFKCEoKthl4SpUFzzC1UuvFy1rL4JbeTFPXRGNp0hC9MQRUNIkGU38iOxr9+ImfPa9jZC+BMXFVoF0IXWcdvlSqGntgvlbS03BgqM1kX3SJYr0RHGvQ8O+Wb7eZ9e8SLZ0OhworPqx97vyCe452EciF7CuscpDsKYvF/L5myDwMGctnpecJyXvKf51TvrKWBgAXMh4wVjdWMTyiBw9qwNLyR6IRKkywvvwiyH4o3CoDMH+TOhmy/OYSncuhSzJO/vLukOX4mhW6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: c63e9729-b47f-48d6-9be9-08ded840df5f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 13:50:27.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kA6TjNyOnH0n7zpMUtS84DnvTgkOj9l7Gs3OfKwHKVgRE2NVMOHKcpIfphuCf90qBS+fYH0BU4UO+f4T3iMCYabNO9cYsinD5nzX02Yu3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6527
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304196-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:mid,intel.com:from_mime];
	FORGED_SENDER(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:manishc@marvell.com,m:pabeni@redhat.com,m:ecree.xilinx@gmail.com,m:skalluru@marvell.com,m:anthony.l.nguyen@intel.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-net-drivers@amd.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,marvell.com,intel.com,lists.osuosl.org,vger.kernel.org,kvack.org,amd.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED76B6F893A


> @@ -2713,8 +2714,7 @@ static int bnx2x_mcast_enqueue_cmd(struct bnx2x *bp,
>   				total_elems = BNX2X_MCAST_BINS_NUM;
>   		}
>   		while (total_elems > 0) {
> -			elem_group = (struct bnx2x_mcast_elem_group *)
> -				     __get_free_page(GFP_ATOMIC | __GFP_ZERO);
> +			elem_group = kzalloc(PAGE_SIZE, GFP_ATOMIC);

what is the current rule of thumb for kzalloc vs kvzalloc size under
GFP_ATOMIC?

>   			if (!elem_group) {
>   				bnx2x_free_groups(&new_cmd->group_head);
>   				kfree(new_cmd);
> 


