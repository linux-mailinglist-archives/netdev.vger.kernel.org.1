Return-Path: <netdev+bounces-243139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F29C99EB7
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 03:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF953A5029
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 02:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A376276046;
	Tue,  2 Dec 2025 02:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYoZ5Kro"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E81921D3C5;
	Tue,  2 Dec 2025 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764643976; cv=fail; b=ubeQ7EjuzfLm/ms9Xn050xnbjVQB/Rc7a1wTtKw2ACYT7SlTMp3tcvukVrbC0vlNZpKL3nYxbDnW89RffscW/6zT0h7LGDJrxD7sKfMSKgSxV33iMZLbdQcD4diaU6cyJTXY5HcqYLKZ0uVfrJXmK/PhvwXI1REeDRcke2VlniE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764643976; c=relaxed/simple;
	bh=jg1l0ebHecXqfktTzT+o/EpG/KPwMnIE0OFXRy3sTus=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=jDpoHJjd55ibF6mDci36NGHbaaBYMV13w6hqr190rquQdURmDF1p6zGL7LzLj3r+SBk5SFy8+uQhOIu2LwC6n47yg4vJa4vBqVMz9d52pjXvqxib/Sa+54SpR/zHpM+LxevHsMPeoVhV/ZaqLcX0W4YTbe2/KSOU83jaRd6OTPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYoZ5Kro; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764643973; x=1796179973;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=jg1l0ebHecXqfktTzT+o/EpG/KPwMnIE0OFXRy3sTus=;
  b=dYoZ5KroZFrcpmUHnFQmAFjxZT4fwZAsYwLGBFvzZJWAH2t4/E4SJSGT
   N8LEwGT4vFj3yhoxo7xyEHbCoTOaMEk3+/fsxvQPEne6uQ7fEPveDAMYE
   xqDsE44AyMT3ImDm++/20F4dfiE4F/1lTx6PDX5/VTaXdGSZkTs0i9suv
   mWIOtdamWzOBF5imIx+f/veNVQCQ4aiZAaLeQtL8xquzWTCHjEM9qORO1
   Od4XdjtDdPCGBFiuaMVWzhY0a+wnmjP2IFG2HQ4Xn4eXl0cl+o9JAJdnp
   pdOd8p4P/bUNaigIWvtzA5KLX7WbM71GXxe+Qh10abWNqqsvSIayRh9Ya
   g==;
X-CSE-ConnectionGUID: T7l8ZYIzRhSyT2Q6P1ltJA==
X-CSE-MsgGUID: cSOMBwkFTXWnVBJXWjs34A==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66766906"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="66766906"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 18:52:53 -0800
X-CSE-ConnectionGUID: zfWkbpQ2RCqJ68p4rp9J4Q==
X-CSE-MsgGUID: BWWi0bTRRCGJqRrvVCdoXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="198450036"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 18:52:53 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 18:52:52 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 18:52:52 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 18:52:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uk9IJ4vo++ntth1Ag5FZGqOHTUSt/wmK+bN8TX2vBFu2MvoOOisVpmx7c+Jorh+YW7QRN5wZRq8SE4fnmdbvvlYFMi7pn4Z0YwG6cQxnVY0yyqLZ6X/PgSbW4l8u8VcKFmxTGfFYnmA3u0xPcan3xXw/6I2qcA+rGD9vrWjBR9hEg49yl2vijLI5+wj5ACtH6cpVxddaUNFq9uX+viZRf88a2BDfD84Uy7DyYyrUEO/hDYO8rwOgcGXAKcvSn3dgCYZLkE9V0YjMSUYcAzdiFYJ17fy6H4PKhz6mjix9CrRrRqaUxemO/HQU6/ANFv0WtPWAwOs2sDazazHT46+xTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDjCX5dmRQ/qoZQxCNOPlFc96+0oBT4o6Bsn7lKKz5k=;
 b=E144vNr1BQkZa0Fyg+hWkNP7wxzu5LEPpcLuA0O8A1y/wRhUE8GvK9svS6NvSYAoLtTkp/kWpMjAppLNIGwUwXCstNcvePMZQMOrnW1vlqKdeUjp5eLVNCKG2zoRnEeKWq4Bl+E4eegBls9RCQtl8FiZjblygP+OqKnv9yJbz9Q/pCE2M7/r7ww75rkn9lNl+c2PGJTgWMBZiCfcX+tDHop83ImH7PfvEOzgu4KnZTEdJffOUI6TgADMQhQoK9RqOOZCb7Ar97awGhKZVkDDxstPdV1J8Wmc6bRsJCc5vSQ1ckaeeGgu8QyKp+BT6NeM6sHs0LjsZp9sTAvLJxwipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PR11MB8670.namprd11.prod.outlook.com (2603:10b6:0:3d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Tue, 2 Dec 2025 02:52:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 02:52:50 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 1 Dec 2025 18:52:48 -0800
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Message-ID: <692e54808af8d_261c11001@dwillia2-mobl4.notmuch>
In-Reply-To: <20251119192236.2527305-2-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <20251119192236.2527305-2-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v21 01/23] cxl/mem: refactor memdev allocation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PR11MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f21efc-10e9-4b53-57f8-08de314de18d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3dkM01iT0U4WkZCbWhqRGh6VTB2Tlk0d1ZwdGYwamhNelJ0djg1djFuaXdp?=
 =?utf-8?B?K3FNNWUyeFFYNnE3SGdTSjVRK2pSUFgvVmdSNFBWcVdianRscUhmdm9tWUFy?=
 =?utf-8?B?RW9LTTZrZlRoVWFReGlxRXhKcVpJNGpCOTY4bkc2RE15eXFFZDIvNGZjT1Fk?=
 =?utf-8?B?OHp2d2F1N0xGYmYxYS9vNWxMeHRkOGgxT25RODVSZC9OcHdpUEY5MFFRQ1hU?=
 =?utf-8?B?aEo2MmR1TTZoSHNKWFVoYWFyYnh5MFJpeE45T01YSVZKQU5XMlVHeXRSVGtt?=
 =?utf-8?B?YjZuVENhNEx4Q2U3dE9hb1lObW9KSTlrV2VpTE5XS0gwV2ttcWUrdU85amt1?=
 =?utf-8?B?UW9yYnNsdUJwbTZOejBlU1VRSEpJQWxjUjhzZkFZNzErUTJ6TVBFRkFVRUJs?=
 =?utf-8?B?YTBXbG03TnFja1cvdWh5T09zcWYvYkxCLzgybTVPNEdzY25QRWI4K2FBT1ZD?=
 =?utf-8?B?engxaU9oT2Q5RFBKN0MwendyZGJVTzFNSzhjajQ4YzBsaXFrTldjaHpMdE9a?=
 =?utf-8?B?Qmx6dU1kQnJFVkNOU2ljZ05saXR0WUYwSDZLekN1Z243QTFZY2cyQjdsZ3Iv?=
 =?utf-8?B?M0xWV1N2K0JCZWhSZmJITlhwUHRrRVZLSFZOZlpqdDFkc1VpcEh0UVY3L1Zt?=
 =?utf-8?B?M2trdk5xaWg2QVJEVlEzQ3E0LzNwaUlMM3BnMXVsZytnMUVJZ2RhMnM1Zk5s?=
 =?utf-8?B?WVAwajV3QklDbHk2Sy82Q3VzRHplSU14REovZkRmdnc4L0g1dXEzSHBjWE1X?=
 =?utf-8?B?N0l5OTBqK3BOUTB1VzR5dWVodm9tbG5EQnh2YVFjVGRMQlAvRFBWVGhQM0ov?=
 =?utf-8?B?OGhlRWl5UXFsRzVUOVMyTjI0Y1J5N0xJS2ZWb2tnSFlCMUo3S3NPcXpQN3Jq?=
 =?utf-8?B?QTVjQnpnQ0MwdW1qbU1aUWtZazFKUy8rQmJVQUhQU1A3Wnc0SGZqVzNYbDNl?=
 =?utf-8?B?NHJhR3ZGSXQzSUdFNjZTY3RHdlJrQmIrU1RvQW9nWUVJWExRcmdBTkFCaXVG?=
 =?utf-8?B?bklJQ1gwdmJ2TnZPaWU4c3ZjRFBPSWUzVlk5MVVUUjBKYzlxV0FRMWhTY3NY?=
 =?utf-8?B?eVcvVldrRzBHU2xkVjgzWWpZS21Ca1BwUGRUZlFuUXdGbklhdGkzRUwvRG9U?=
 =?utf-8?B?ZFFWbnZaRG85UXB1Y2JVTlVGOGl1OVJ4UmRGVm8wdkxuM0tCbXpKOU9aZjA3?=
 =?utf-8?B?N2ZZOVRZZlR2REF1ZmQ3eHpwajhTV0VDaGg4bUNnL3NoK0hKck9lMEM2aWhx?=
 =?utf-8?B?bWlMUEFySE14enZybm9wa2QvL2lWOTAxL1RzRXdTVUx6ZFo0NHRMZHVoc1hN?=
 =?utf-8?B?QkhrYXdKSGpsMkJoRE5ZcHN2bjV0S2xhUUV1U21wSDBrUmYvbnFUQjdLdnJD?=
 =?utf-8?B?ejV3TVRxVS8yS3A4UVlIVXhpUUxaTC8wMkM1YW1VM1NFODBWcHljYmFSZW9z?=
 =?utf-8?B?THJNWGNRYU5hQ2RzRlRhY1FkNC85Q2dhellGNFpLWVpxaGRpRnp3dTZLczI4?=
 =?utf-8?B?ekxGaVhjU3JZYjdFd2hOTlpZbFgzRkgrbkl1UC9UQVF6aStXMXRacDJtanho?=
 =?utf-8?B?KzdXZVFOK1g2WndUMVd6WnJyWTk0YnVXa1B2VEduaWJxT2FWUkswd1RMWWdw?=
 =?utf-8?B?azVBUXdrZFN0ZHRWd2RkSjNiYlk0QXZuYWNmK1lwUksvQmZzNWFFMk8xU3Fy?=
 =?utf-8?B?SHhWTVlQRDcwaTdaamRUdzhnUmszbXpNUEUwN2xrMjJXaVIzVC9kVlBQaGU1?=
 =?utf-8?B?dWZIT2ZJbUNuVjltK3F3cDJGTVJLbnB3M1RqYjd1c0dsck1vZnVySm5YUDdt?=
 =?utf-8?B?SnBpWUtqb3NuK0dESitDRS9QdlhmYlpTOW9Kem1wUnRPNWhlbkxYQmhJSzAr?=
 =?utf-8?B?WFZ3aUZGdTlXWGZTN1duNno5aUtkVXNZM09nYVF6YWdiTkZPRkZ6b1RpTTlm?=
 =?utf-8?B?eHhVZTdMcEhuTzV0RGsrZkhtYXpPcGJzS0dTMjRCSE5rOUdwY0NVbCtPcG1a?=
 =?utf-8?B?MDFmbDhuNWlMcWx3cmhUZjhRUUVGQlZ6YWhoTk8rVDVqK3lxdXNkLzhZTm5E?=
 =?utf-8?Q?dOLyhY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0Mrekk5VDVFWWE0SDZNZzNndnk1aEZ1dklWY3gyandveUZ5eW5FYXdkUktv?=
 =?utf-8?B?SnZvNTZIL0x1Y1U0aFBpbDNoTWI1VjNvQ1BzbWR5OHhpbjVPUGZvRkxEOWU3?=
 =?utf-8?B?eHk1OTMxU2RoWmROQkorcGVIZld5MlNvdEQ0aGJLT2duazZ0bHh3bUxWZDdj?=
 =?utf-8?B?b0VMeW1xek1vNkxyT2owa0ZidkkwTGcwOUF4S3pGai81bkVHMFM0dnRJTC9q?=
 =?utf-8?B?dERGbW1IUnpKdC9TMStDSGJ6TkFybzh3ZU96UndURzY4SzBEYzcvSmdjVVhy?=
 =?utf-8?B?ZzJlOXdVellJdWdDb2VVM1M0TE44N2hRQlVveDBJVFB0T2JIdHpzZGlZV0VB?=
 =?utf-8?B?Yk1tckR5UGxOcUpPQnQ0WkVGdVZJeTd2bFV3cE5vcW9SQjlwamJVNTN4MmxI?=
 =?utf-8?B?dFgyeWV4OXB0Mzk1cmxWalNFV2Via0R3YTcxTTRKUGxOdy9hMGdZNGNzWnNG?=
 =?utf-8?B?Q3pXcFZlSW5uVG5XR1N0NjJFbk1ZMmFuWFBzajNBNzYvZzdkMUpPbUxtRDVS?=
 =?utf-8?B?Si9VWGN5UXNxL2tNSGtIRFBzWDJUS3d5TmNHbGJwZVZCWm1ENEZtWTVoaFZO?=
 =?utf-8?B?dFFiRWJ4aXhDZ1FrOEtHcXY4ajRuWGNyNmUyYitlSjloMithbjJodzdvRm92?=
 =?utf-8?B?WWNEa1VtRjVKSzF4OFpNSjZNWkRJRlZBa3ovTGpPWGJIa0VWQzZDU0cwSTV1?=
 =?utf-8?B?ZGU4bklSdnRpaENwc1lPVHo2RSsyUGkveXpDaDEzK2tvS1lZVVh6SlVVRDJC?=
 =?utf-8?B?VTFWZjZWZ2xLSkVwNzNZZm53VkM5UFljYmNIcktnNG85NW9wMWIvaGNDaitZ?=
 =?utf-8?B?QXNoNktvcEhGSlFXbElIRy9pZ3ZTci9DVVVGR1Y2Mlh1eE1wUE4rTnJzR0Fn?=
 =?utf-8?B?WjJNemJDU1g4eXZ4aE9GTm1sMUxRNWVGKzc2ditWZFVCcWl1WSt4ZHRYZmRV?=
 =?utf-8?B?SlB5Q212OWk3YzhXSDVoWTdOREp1UXVtQUpJMW5UbnpoYVlwM1JHYUJ6VFky?=
 =?utf-8?B?ODdudHY1ckJTazBIQ1lkK0pWZFhlcVFwRFdXQTdRNXo2RjJud3IwWHFzdmdK?=
 =?utf-8?B?S1lTSlNyYjRDcTdtRWhITGh6RmhtUVhLNzJMbE05bjIwWGxrb0s4WTkrSmpm?=
 =?utf-8?B?VjJLbmdySTdRN2VOTXgzVnI5RjJBSVJnMStWNnRxYVBCQnFnckRlMVJabTll?=
 =?utf-8?B?elFaaW9UQ2dLNnJ3MEVGLyticzlkTGpCbkpaNzFveGFGQldWZzR4WWtOSDNj?=
 =?utf-8?B?M3hkWGJ6dm1IMzUwUWhORnI1K2xKL2tyZmV6ZGQwS3RGZTBnUUdXL1FadHdo?=
 =?utf-8?B?WGxaNExOaWg5SDZ5UnlsSlhBQ0QvRVd5RmZlQ2NJQTBFY1hGVHBnUjBGVCtO?=
 =?utf-8?B?NllBNnIvQWdINmhEZXdJUi9HZXAwSjZZMEdTSEVJVW0rNEIzTytSWGtqZUF5?=
 =?utf-8?B?dlJZRDB0bG5NLzFzaVdvSG91cndIL0Y3emsxNlA4NmlicUhFTXJBenZMaVFQ?=
 =?utf-8?B?dFBlM3Y3b0xtbU5FcVNkVHVnSW9aSHVvYWtyMGdFVklwR1NNb0N3VUFDZHlF?=
 =?utf-8?B?Y1NxazJlSFVzODlGMEhyaTBJd1FEcG1xMzdzKzIwUllGbWZjSVQ1UFZGemVQ?=
 =?utf-8?B?QjlrbU40RW4vdi9BM1Y0RnowZ1NVMCtkV2ZZakJnMHo4eEltQkV1bkQ5Qlgv?=
 =?utf-8?B?MUEvQkJXSXlaVERKQVNuenhpZTJodWZIa3owT2o1dWdtQ2p3NnBrdjZ6K0NC?=
 =?utf-8?B?dmZLWGxiNHFxM0lSV1VtUUNmeTVuMnRJVU5ESW10MkhPYjRoanVPbW8xb0FC?=
 =?utf-8?B?b3o3VlVwcHRlNU1MVUJpU3g5K0RpVTF6SlJ6Mm9XMzF6NUhaeUp1aGQwS0kz?=
 =?utf-8?B?SFVDQTlXS3BZaVp3QjltYytzd1FaZFc2VUJ4Q1g4Z28vRGNXTmZmZm9hWXI3?=
 =?utf-8?B?VEQ0QzZCR0d4NmhGS3hGc3h5Ujd2SWViRDlzM1RVMy8zYVE2OVdjWHUrT3pI?=
 =?utf-8?B?cDdnSkdWZU5ZcVZNTDRQNUREQjFjS2dYdCtrMjBqSVVBbDJiakpRVTI3b2xW?=
 =?utf-8?B?K2VVOE4rbXMrYUtqWDdIYXZJZkpLd0ptSXgwRjhTWHdSd1RzQ0kwanNBc21a?=
 =?utf-8?B?YjAyMlp3THRadEErdThTc3JYKzlBUlBGNk1aTCs1ZHRpekJvd21WRktWaTZJ?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f21efc-10e9-4b53-57f8-08de314de18d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 02:52:50.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AecN6m6ZIrkWQtVxOpBUQ1XubBwV3U6Lxxj/2kaDh5hOgY5WNuWQzCZFkLIO+IYkMdrGCWv68FZVoLO0icbBVIR3NtPA5Sil/gX3oWNcG6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8670
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for always-synchronous memdev attach, refactor memdev
> allocation and fix release bug in devm_cxl_add_memdev() when error after
> a successful allocation.

Never do "refactor and fix". Always do "fix" then "refactor" separately.
In this case though I wonder what release bug you are referring to?

If cxl_memdev_alloc() fails, nothing to free.

If dev_set_name() fails, it puts the device which calls
cxl_memdev_release() which undoes cxl_memdev_alloc().  (Now, that weird
and busted devm_cxl_memdev_edac_release() somehow snuck into
cxl_memdev_release() when I was not looking. I will fix that separately,
but no leak there that I can see.)

If cdev_device_add() fails we need to shutdown the ioctl path, but
otherwise put_device() cleans everything up.

If the devm_add_action_or_reset() fails the device needs to be both
unregistered and final put. It does not use device_unregister() because
the cdev also needs to be deleted. So cdev_device_del() handles the
device_del() and the caller is responsible for the final put_device().

What bug are you referring to?

> The diff is busy as this moves cxl_memdev_alloc() down below the definition
> of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
> preclude needing to export more symbols from the cxl_core.

Will need to read the code to figure out what this patch is trying to do
because this changelog is not orienting me to the problem that is being
solved.

> Fixes: 1c3333a28d45 ("cxl/mem: Do not rely on device_add() side effects for dev_set_name() failures")

Maybe this Fixes: tag is wrong and this is instead a bug introduced by
my probe order RFC? At least Jonathan pinged me about a bug there that I
will go look at next.

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Why does this have my Sign-off?

> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/memdev.c | 134 +++++++++++++++++++++-----------------
>  drivers/cxl/private.h     |  10 +++
>  2 files changed, 86 insertions(+), 58 deletions(-)
>  create mode 100644 drivers/cxl/private.h
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index e370d733e440..8de19807ac7b 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -8,6 +8,7 @@
>  #include <linux/idr.h>
>  #include <linux/pci.h>
>  #include <cxlmem.h>
> +#include "private.h"
>  #include "trace.h"
>  #include "core.h"
>  
> @@ -648,42 +649,25 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> -static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
> -					   const struct file_operations *fops)
> +int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd)

Can you say more why Type-2 drivers need an "_or_reset()" export? If a
Type-2 driver is calling devm_cxl_add_memdev() from its ->probe()
routine, then just return on failure. Confused.

