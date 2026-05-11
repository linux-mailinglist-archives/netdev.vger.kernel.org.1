Return-Path: <netdev+bounces-286758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GB0DmkXAmoVnwEAu9opvQ
	(envelope-from <netdev+bounces-286758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:52:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FB5513DA6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCF72303717A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C95441022;
	Mon, 11 May 2026 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqUdWFtX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5164A423A6B
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520118; cv=fail; b=F3t/eyOZsSpcuPtLioJuZGukq4uWPfPn3ejesENbEtlizByC49kLC1DMB/mj1YaJXXZqsuJfYX+fK6vu6ZWzVZ9Kxfz67EM8FPEJH6fGJBpIpw+IiuD9SReCUt3OYfV8MuGVaz30627xyQvk2aNNjPsaVkLvLOFDiVegMq4VUc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520118; c=relaxed/simple;
	bh=lS8ARNr6b7HifY6MP0cmDPzokOmlMUIiuY4pkPuy3Xg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RmYgA0F6Iv0VQ7uTY1garkHbVNta8yvJlT96YDpvYp4/FS0E+3lTekm8qLt38MelmMghtVjvpbgNHC70p/itpuDvlXTqQn+f+hX2J/78UweF12Dix75IPkKG4FDr0oVnCI7ze1Xc3Kcx+75LmeG51jgYxHvsi9ROXKcT22HQTAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqUdWFtX; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778520116; x=1810056116;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lS8ARNr6b7HifY6MP0cmDPzokOmlMUIiuY4pkPuy3Xg=;
  b=iqUdWFtXDzWZw/FPv0ovGeCWtjB2clCZ/gkrQRtrrI1yYDv1iECGO44Y
   7bx/V1YhuE2cAaIJhZqq8qZXyGtIkCzysMK4AaGVQ66Pum2fWxoAZb66i
   TalNvClndLgzuQGucM76IyKqXVs3+bh2liQepKEAy1lXRRrRfbnXCQnx7
   nUWHrFfgYmKKV6PpncIzPRT54ylkXLxSQSacpfd6GbTt5+Ipk08fnAtON
   yj3k2hhwPHDXcQbkQbs+v3AbkYK21W4ljECzKVtdzf+OA6FXwfaTFtjGK
   /aghFrImLofSyizFFgaB1bGuES4b6kywNGqvQ1FTa3GD0OSrCdmBRozVA
   w==;
X-CSE-ConnectionGUID: M356pNI5TbOY4wJPx5Gb7Q==
X-CSE-MsgGUID: C7+FjfJEQnWdxqgsJdB4GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79440753"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79440753"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:21:55 -0700
X-CSE-ConnectionGUID: Zuhc8LknTvijttS2AVmQDg==
X-CSE-MsgGUID: KIVM76MJRteUO8MRH2CsLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="237608642"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:21:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 10:21:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 10:21:55 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 10:21:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mkjflx6uB0WKVfub7UyMW5/hldKFCB59qs00kG0AZZN2JMIsKjpM9dVBbs2tgEd5YyDgkQNjk2ium+0AErJmXLa3k5MbsaQdTvhooKmDnDwZnrjHjdtiucZemNTQO51LE6cOLcKORAPCq05qCQKJJnpM2H2MrZP9FtTI03rfiL4T0R0wnGEF9ZAwTog7tOWnl3OOYkEkOPqxN39iNBX8nAKVIagn2XkbK+TbJH17lUngW4xv9R5NKmwXhMWCroOEAMXN6RssBEatK0v6eY4iN4wIUA3px7y2u3FDjpVE5jYCQyHOmjtaq/Cpn+7Lh6KQ0If32ENdMmL71SRvtAC/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnKEdnChpuDyNTF76AeDpz2g2ZXRP+GLNKJRgCf2qoE=;
 b=HrsUQexdMiOUEQX6TGm00/WEH0n7nBQi7HoGt9HiSinhY6PWamESztGRmfoVgITcDWBDlQzc/vJw8vx1E1uCRgapPB5sX/Ubs0isv54ZFtZIpikdF3+UF+SHc31JO/8+Ah6OSzKvfCIL5PvuGge4ZcO4FI1EIjC/00xsfRVOfXMll0MW3TI8+P/6KRaiv17MyPYLx1rWutuvJOmrJB/o2/iSsjFJ0NrYIwGM80iOh07m6kop36ygAOZPA93Zihsnbg02EcHpW7ogfKug9e8mnvPCbwhR18sFYJD8PgNJXJczNXse81JziE8fVD2cUdPBPF3b3ecTXaVAyvFaQwAAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 17:21:51 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 17:21:51 +0000
Message-ID: <5e90b9aa-9432-43b5-ae40-1fce383bb043@intel.com>
Date: Mon, 11 May 2026 22:51:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/11] drm/xe/ras: Set error threshold support
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
	<lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <maarten@lankhorst.se>,
	<zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
	<michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
	<umesh.nerlige.ramappa@intel.com>, <mallesh.koujalagi@intel.com>,
	<soham.purkait@intel.com>, <anoop.c.vijay@intel.com>,
	<aravind.iddamsetty@linux.intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
 <20260417211730.837345-10-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260417211730.837345-10-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0082.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::12) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|IA1PR11MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 4defbe8b-ea39-4b4d-d981-08deaf81ca20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: VT/xw4XYcaYlsxhjO8WUkzo4A1+liGkdbPOuJ6ByMjKnCvrKSY8YQmasON+Og52qd9ZQUy+wa/XlfcQaK09UimosybKJ15rZ919BKz1g9s3z00Z9SdxWB6kHI5kmbPv1vk+OmuPaq3ff/MJxewDhkKzekvdJSr/E+oszSDwohAKHgi0gbCkZZB7UjLz8029djNemIEPkN4cGTgdUwl4WHE0jyxb/5IDRbtXII7+fNnfdTPaBuCWOWnC0pYiolieZa99w7ohhATfZOGHVejgYMxTn4RZclx5WP24nmax0JuInogMZHq2I8lTsfIpLD4JMzC0Dp54FfRwixupdNOfScjcCiJRrG9qkz+DwBMtdvOoMkGvyPy+P5lOzB9Z4dSTMevXSEdpVArX99lVjh5KwzHH2I3oqvi5pkkGdUjVr+wbIbrJgexxIbWI0LeTSiBK5horRTlj5GcBsY2bTWMIKuUGlIWiecpU3yisI5nP73izSd1mAjF1S+mC4BeQj1NTNjgI8IpHqG+DLKbfLQW6tAn3+H3QceTx0WfTuh9jOFwiwfoxFdVmWB0MMlV+hbiM3KCla3/YTs9woyrK2iEHjcbJfQ9o47c/e5WBRHxfxJJfMaS89tZ5lQpbOgcaTIcB82S06/Ibjt9scCZYWFqu529GyceiI8++b1JY4A1j+N5FK1Wx/iRgf9GeDAjm8uaxVrHMR9XHqDOhn5pFztOU12w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3dkcUhQcEZqWm1FMkRqSVBLdWExQkJubVk1RE1qR0lBZklRcUR3dXY5alQz?=
 =?utf-8?B?dk9zY0ZoMXJ4VmdqdXNQTENUNE9VQWNkNksrdlduYWFVbG9aT25GcnVsRVg4?=
 =?utf-8?B?MW5FZmxQMkNtZjROaExCWFo4RHNpUnFOZUg2VUt5WHJxN29LMzlhMEtVN0Vn?=
 =?utf-8?B?QyttbFRSOFROTE5nR3AwVk9icUpRamdKTHZPZ0tDSm9XSVdGZGovaXNKZ3o4?=
 =?utf-8?B?WVJxdC81K3FjVFUzbFBRenZxekl5ZVRVZXYwTGtIUFhJV09EVDR0WVdmRnc1?=
 =?utf-8?B?Uk9tOGZnRkNxZlRtOEdNUk80MEVaaUphQkoyWnJwWm9WUlh4RUs4YXJhVGlD?=
 =?utf-8?B?M0dra0ViejZBdGZaTjJIcURnckp1Qk1vbW5nbVBYTGg1V0VDQ3J4Zmt5bXda?=
 =?utf-8?B?R3pXYVFsYWdVNUNodjFFUXh4TWtjZTdtTnZFbGtOUTB4SnZ3cnF3Uy9rM2hP?=
 =?utf-8?B?aXpKSG1qd1EyOThoSzV6a1E0cXdlKzdrV2hOU1JDOEJVTXVsell4Wm45ZFkr?=
 =?utf-8?B?aytGakdaNXpZQmRrYWl5R0g3YUlib1hwT1laTTZWbHg1am85Q041Yld5R1ZO?=
 =?utf-8?B?QkRDYVJVTUI0YXNUaFVLQVIwem1PTmxuVnU0SGFtemd0UTA4N0dYQTB4czlY?=
 =?utf-8?B?R2RESmh0VkVtTFBsaHYrM2xWOWYxMG9OWGQzeitwWUo2MlVHd3ZIT1RQZzVZ?=
 =?utf-8?B?NVhyczZvdnNMeFZyVHRIV1YyRmU4ak5HRlg0enlTODVRWkhmVDZQR0NnSEVH?=
 =?utf-8?B?c1JIclVWeExBbFZVSmlrYTE1WnJSM1RVc0cwT1U0cFNENHlXaENXakpLUndK?=
 =?utf-8?B?KytrUDNRK0FGdEFDUXYvaWxOampDOVd3clVzTis3L2dieldBWFRQc2kvQWF3?=
 =?utf-8?B?STNnNktIeHNzSC9zczBCM002MmlIWTFwK28xT09waFM2Uy9LS21KLzgzVkFp?=
 =?utf-8?B?OFRsQU9zNG5EeXBvSkFiaFJtMjNrNXNFNGpCSk1KRlhrZy8vSUpJZEUxYmxT?=
 =?utf-8?B?ak8wMSswcHVBS2lteU1LK1QwV3NwK0l2WHAwam05ZU8ybGpMWTdTcDR1RVRj?=
 =?utf-8?B?aWo0Ym1PLy9aZFlSYzhvRE9pUzQyT3JkOFYvRFpEaWtobitoUU1zeUxOaU1x?=
 =?utf-8?B?K0NLVmtSWkU4MTZ5amlMenN4UGU5S3F4RWc3M0o4RGlWd2w5U3hWL0R1b1Ni?=
 =?utf-8?B?ZndkMWRkaHYxQWZOTzZ3SDBaZDVRV1drcUg0VFNCdEU3ZklvcXJTa0h1NytE?=
 =?utf-8?B?QktJT3NjUkhHV2RTOUJ2c2UzWStHUWNXNUZJaVdIQ05zYjJjeVhVWjJzZmgz?=
 =?utf-8?B?YS83WUd1R2Y4c2NGamw1bWVmZ0hxaUFWSm9Zc1dGdFhmK29TQlFMcEdzd0hX?=
 =?utf-8?B?dHQ1QjhZUW52em5YWXdsdC9ZN3RkUmYzVUpDSVRDNldjVnM3YmNKdkIrNlNi?=
 =?utf-8?B?T3c0b0RJVjkxTGlycXM4UFV5MkU5VmpybWhLSDdXMGU3YWdJN28wYS9lSXdK?=
 =?utf-8?B?UXNEQVAzUTFsdnZSK1ZyR042Wk10M1dQT1N4eS9rbFcwcWY4OXJEdldhc0ZH?=
 =?utf-8?B?Ky9uMVdQZ3N5N0dmUGZZRllDL0Y2L2hkY1JhcDhkWUhnY3JoTm5lb3BLSVVs?=
 =?utf-8?B?OFlmOVozUGduZUlSeHJvRWpLcWdJTlROY3ZJRFo1anlXeUxNN0dBemtkNEN2?=
 =?utf-8?B?ODdkbUdqdjFxL2ZXTE41QlN0WnIxRTMwNmFVMzNVMzFOUTdFSzBkV2xSZkg2?=
 =?utf-8?B?ZVpqTHFlUXhpU0hPa25hQWdNM1EvWGYvUDMzenN4bGJjMWdsbTYrYjFMdXRN?=
 =?utf-8?B?Y0EzN3VzWkdCOXBMWnAwREltTFpXK3JTMjFHRjVVVTkvcjltcmJBdU1PdlVR?=
 =?utf-8?B?dWMwaTVITjVIbkljT0s0OU9LdU1Mb3hySW9MS3FkeGsza21wR21yalBLMjJ4?=
 =?utf-8?B?TUFqMnpNcitkUXJNLytNaDBsOEljdjRweGFVZitreDRBRnVwQ2hKWUhFaDVR?=
 =?utf-8?B?UW04cEFpNm9FVk9uVWVsLzNsc05OcHBVcVlNbitOd0NPeC9HUHQwL3NLTzF2?=
 =?utf-8?B?Rllsd0VHWFZuRGpZbmowQlUxUXh0TFdYYndmc3I4S0FwdVZUQWFIT2tQVnNX?=
 =?utf-8?B?ZitEak9jY1ZDWE1BN1k0K2VERUN6bEZpcjJ4QjZUQXVZQWpMVGd1N05qbzJO?=
 =?utf-8?B?MVA2cDdVaXpQUVJObm1PZmR3RGFDSHQyOUxDMitKYjFWR00ySGdGOWNDVXZr?=
 =?utf-8?B?cmFMQWViRzFTYnVFQVdtalZxam0wUmhabEVMdmU5cUNGSjcwNFpzNXRKb1Q3?=
 =?utf-8?B?M0pCN1Y1WVE5WHNMckpwUEFPYlUrcWkyY0dHV0dVL3pmSVVFVmUrZz09?=
X-Exchange-RoutingPolicyChecked: EiRT1bXTNgcuCwcz0PCBy6HG+pYdM2ZKJiNanRDuJv6obn2fDbzQ0aXqqZUs32yCLKgYLTDmZu0vITcMPXAhWlF6SkIlTvnmc63TlXQMftyKc0CjfqYTTHJITyLGe/W6HAAgG03S7AXtwoe7cixMhPNlnZddVJ8B27dGEz/RBKnAWXzdEkhq3sSee3Wxgf2HbKLFu1nQJIumNaHrR6o3g9gznCheqzl2tWl1jWi+IApIRz+vhKzj8sMDBXzDyJqDrroZijJ3XFDmJIH6pZIcx2coC0DxzH73pJq/WMN2X7JjFmOCg8Te3FXGTj5hY7CZIBKi/Jsv70cbqC/ClFdLzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4defbe8b-ea39-4b4d-d981-08deaf81ca20
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 17:21:51.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdyyP+NPp0jgfvpfJoc1qiInfvK6iQt2itNavu1vKGg2R94ZwyG0fvz6RV5Wy9cZNNaqwYFOnJL0pVPH6lcwLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6171
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 86FB5513DA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-286758-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action


On 4/18/2026 2:46 AM, Raag Jadav wrote:
> System controller allows programming per error threshold value, which
> it uses to raise error events to the driver. Set it using mailbox
> command so that it can be programmed by the user.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_ras.c                   | 42 +++++++++++++++++++
>   drivers/gpu/drm/xe/xe_ras.h                   |  1 +
>   drivers/gpu/drm/xe/xe_ras_types.h             | 28 +++++++++++++
>   drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  2 +
>   4 files changed, 73 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 3e93f838aa4a..26e063166c5f 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -163,3 +163,45 @@ int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32
>   	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));
>   	return 0;
>   }
> +
> +int xe_ras_set_threshold(struct xe_device *xe, u32 severity, u32 component, u32 threshold)
> +{
> +	struct xe_ras_set_threshold_response response = {};
> +	struct xe_ras_set_threshold_request request = {};
> +	struct xe_sysctrl_mailbox_command command = {};
> +	struct xe_ras_error_class counter = {};
> +	size_t len;
> +	int ret;
> +
> +	counter.common.severity = drm_to_xe_ras_severities[severity];
> +	counter.common.component = drm_to_xe_ras_components[component];
> +	request.counter = counter;
> +	request.threshold = threshold;

We might need a max check here to avoid unnecessary values from user.

> +
> +	ras_command_prepare(&command, &request, sizeof(request), &response,
> +			    sizeof(response), XE_SYSCTRL_CMD_SET_THRESHOLD);

Nit: command, request, response seems to be a better format

> +
> +	guard(xe_pm_runtime)(xe);
> +	ret = xe_sysctrl_send_command(&xe->sc, &command, &len);
> +	if (ret) {
> +		xe_err(xe, "sysctrl: failed to set threshold %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (len != sizeof(response)) {
> +		xe_err(xe, "sysctrl: unexpected set threshold response length %zu (expected %zu)\n",
> +		       len, sizeof(response));
> +		return -EIO;
> +	}
> +
> +	if (response.status) {
> +		xe_err(xe, "sysctrl: set threshold operation failed %#x\n", response.status);

Status should be converted to visible error codes. check [PATCH v5 3/6] 
drm/xe/xe_ras: Add helper to clear error counter - Riana Tauro

<https://lore.kernel.org/intel-xe/20260504065614.3832331-11-riana.tauro@intel.com/> 

> +		return -EIO;
> +	}
> +
> +	counter = response.counter;
> +
> +	xe_dbg(xe, "[RAS]: Set threshold %u for %s %s\n", response.threshold,
> +	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));
Again not required. Value should be visible to user
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
> index 982bbe61461e..d1f71b1de723 100644
> --- a/drivers/gpu/drm/xe/xe_ras.h
> +++ b/drivers/gpu/drm/xe/xe_ras.h
> @@ -14,5 +14,6 @@ struct xe_sysctrl_event_response;
>   void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>   				      struct xe_sysctrl_event_response *response);
>   int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32 *threshold);
> +int xe_ras_set_threshold(struct xe_device *xe, u32 severity, u32 component, u32 threshold);
>   
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
> index d5da93d65cf5..d7e4a02a661d 100644
> --- a/drivers/gpu/drm/xe/xe_ras_types.h
> +++ b/drivers/gpu/drm/xe/xe_ras_types.h
> @@ -92,4 +92,32 @@ struct xe_ras_get_threshold_response {
>   	u32 reserved[4];
>   } __packed;
>   
> +/**
> + * struct xe_ras_set_threshold_request - Request structure for set threshold
> + */
> +struct xe_ras_set_threshold_request {
> +	/** @counter: Counter to set threshold for */
> +	struct xe_ras_error_class counter;
> +	/** @threshold: Threshold value to set */
> +	u32 threshold;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved;
> +} __packed;
> +
> +/**
> + * struct xe_ras_set_threshold_response - Response structure for set threshold
> + */
> +struct xe_ras_set_threshold_response {
> +	/** @counter: Counter id */

Nit: ID

> +	struct xe_ras_error_class counter;
> +	/** @threshold_old: Old threshold value */

Nit: prev

Thanks
Riana

> +	u32 threshold_old;
> +	/** @threshold: New threshold value */
> +	u32 threshold;
> +	/** @status: Set threshold operation status */
> +	u32 status;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved[2];
> +} __packed;
> +
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> index a1b71218deca..b865768e903b 100644
> --- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> +++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> @@ -23,10 +23,12 @@ enum xe_sysctrl_group {
>    * enum xe_sysctrl_gfsp_cmd - Commands supported by GFSP group
>    *
>    * @XE_SYSCTRL_CMD_GET_THRESHOLD: Retrieve error threshold
> + * @XE_SYSCTRL_CMD_SET_THRESHOLD: Set error threshold
>    * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
>    */
>   enum xe_sysctrl_gfsp_cmd {
>   	XE_SYSCTRL_CMD_GET_THRESHOLD		= 0x05,
> +	XE_SYSCTRL_CMD_SET_THRESHOLD		= 0x06,
>   	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
>   };
>   

