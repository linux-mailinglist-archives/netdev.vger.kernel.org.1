Return-Path: <netdev+bounces-254397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FVFHO9Nemkp5AEAu9opvQ
	(envelope-from <netdev+bounces-254397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:57:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF92A7562
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3E87309A7B6
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C4436AB48;
	Wed, 28 Jan 2026 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBDLSi09"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2DF1E3DF2;
	Wed, 28 Jan 2026 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622495; cv=fail; b=NJFSP8ypeuIK3vWJMyZVLSo3R9/gHfMouWcCfLHo/n9D6gjTOzrC4+c5vf/dyQmOFPJyt1F3csYNaFlQs+HnuDRwqz83XJR2UwplpqF4q4nXBrh6uAbZ7te/qm1DLZhm1uU2pA6Oz/hutBSh3Y4G7WaQRCvAekGTTWonNQH8Cbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622495; c=relaxed/simple;
	bh=zCWHtnAUuclWnTdmenrTwfOPi1Tl8t89ZnhH4FCvsn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KFqa0HOogACGq2ld5c10bOaaGxVTBWD13VCuxiV5wuR2+jDnHvwQxZQvVB65TaB3WZiXZqUqi716TZiWD85a2zYvso8d8xqQwp7hrZgLD3Rjlk8mdZ/4Ug7bsuJRAMm5XO/T4cqcq8oi5CXw6zJJbi0hxYuWjWxC5lGJI+R+wgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBDLSi09; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769622494; x=1801158494;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zCWHtnAUuclWnTdmenrTwfOPi1Tl8t89ZnhH4FCvsn8=;
  b=RBDLSi098Flvxpm/TaO8n+ECZXbwfSHIpXH4z2QizWf3euVUwnIKvDil
   Bqxarlb188dShvhkNr335i9VqGjwIQ97m620/9x3y0iQgq0hk6HlFvp/z
   Wb4ziQYDBlD+eabmCRjzP0k3Ah4Ij4gUb8kleCIJE6iX5S9JkdfaBkHAC
   EXsaaZqGu4uM9pkJw7xK4RmqPAMMPO660/Z1H7B/7dOGyzKna62gxp//H
   fcXoU4uj+KmZvcz+VCWkjgxvxY0p2Kg4n01HosJmQR34xnClaOVD3k8O4
   Jgkr50yUz40OK+G5ViK9hp7sQntUUpjoXkRBqlws1rHkHFG+dzpV6Vnvj
   g==;
X-CSE-ConnectionGUID: y6BFLEbWS8Kr3nG3IHGsdQ==
X-CSE-MsgGUID: +vpQLS1+SP2mfWqPwtjzHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70898033"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70898033"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:48:13 -0800
X-CSE-ConnectionGUID: PRDxr9HcRKmm0FzH+IdAjw==
X-CSE-MsgGUID: lrwdD5c6TY6cyZLwU3TFig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="213196952"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:48:11 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:48:10 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 09:48:10 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:48:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRWjaO2VW2fiLKv1m0PnC0qD0Y74gqVOCxws4UzpWVE3IE7Rc1ithXOoKKRWC1No6mm+xdJY07Xo5f31k2ghJ1y4YeerGASFmKpmzC5cL27lZYNLI/A6nhQt0BOkS3SmZoBUhi2QmWpCs7A5f8GKX527TF39SsGNCoJLAeeOuP7U2B9lbXDo03dHrNNNKNlhXqgxH4Twq176SdDfugEF+Gafj8iAgH+CdWEFB9s5IsSDonzu0i4PUPiF6+0i8B8mDPoQdq35VX+W9kuFJtBE0oG6UywyifeqR4LQ85xPuPRj9wcUZruWZoHD2WwSbWHkrsVk1Nlqzkhy9A2oO+F3ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCWHtnAUuclWnTdmenrTwfOPi1Tl8t89ZnhH4FCvsn8=;
 b=K3rIckI/LvOB9H7hfisbqsfhIQBrJmOEGrYHwYcWYCt4SkLIYXF7b1E1LLqtDNl7juyqYxuvcPVjZmIEkk9r1dhBawR37lCvXMMT/cLcuYJOzxU1J3JfG/HRkmXauFQsiG9IzHA5/LXKddCQc8eZSd2VDTN0sSWJfcwcLrGWwgVXK4XqFsP1rjoQFkd5iYIXdjy+3/ffLDmEcuB6k5cYicl5JPeiywjwI9Cpg+xftmDlHAXKXVGTUzxizSDOoUdhTG9NqN1Qi8ft2FUBmASB4DCHwRv3SR+azGWikwtfpHdLLXoHZAb780tm5m9kfmwlOdqsMefcae3QzyyrkbCo1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS4PPF4B1ECA5EA.namprd11.prod.outlook.com (2603:10b6:f:fc02::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 17:48:07 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 17:48:07 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Stephen
 Rothwell" <sfr@canb.auug.org.au>
Subject: RE: [Intel-wired-lan] [PATCH v2 16/25] docs: kdoc_re: better show
 KernRe() at documentation
Thread-Topic: [Intel-wired-lan] [PATCH v2 16/25] docs: kdoc_re: better show
 KernRe() at documentation
Thread-Index: AQHckHZujMj8Q7S+f0Svcm3nBiYL+bVn25DQ
Date: Wed, 28 Jan 2026 17:48:07 +0000
Message-ID: <IA3PR11MB8986564EFE9504AB4A59E14AE591A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
 <56e007be74d8572c7c695d811e72e70447c466aa.1769617841.git.mchehab+huawei@kernel.org>
In-Reply-To: <56e007be74d8572c7c695d811e72e70447c466aa.1769617841.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS4PPF4B1ECA5EA:EE_
x-ms-office365-filtering-correlation-id: 14dbee24-6bff-4bfd-606d-08de5e95655d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OUlRRmpOK1I5eDhnZFpuV2VtSGlqU09ra3BtSGNzUTcwbEljUkFRTVFiTEZK?=
 =?utf-8?B?NDJFYTNXMjVjSXVObHJKbTVBRXNBTjhneHo2MlpTL1hqU3gyWVVyOFZYa1JV?=
 =?utf-8?B?c3UyVFFmRXBMa0VlQXVwdDRLdTRVd3dtK0lteG5xakNjN1lDK3ZpaE0wQks1?=
 =?utf-8?B?K3g4MnkwaWhJSDRLNmtCbVNlQWxkcEdRYTkxTVRuS2tFdGxKcXk5NUJsVzFz?=
 =?utf-8?B?b0ltQ1RrbEJsNmRIOVdWMEtBaHNGbWZtZkdrT2V5S3dDakdGeVJ3ZTBrMS9N?=
 =?utf-8?B?cnV6aWNiQkg5MVBZR3VCTHVNRjI5eWxTTmVyczkySGNrWTIyOE5uZHlsamox?=
 =?utf-8?B?K0tmVGpQWlFqYnRMbDBxM2hRMC95dFA3VnZoQTEwQiszYzI5YnQzeGNwYUUr?=
 =?utf-8?B?WENmZGZ0cnZCazkwUzZKNFBsS09TM2JxV3NiZXFMcHdHM2VxWkZNNyt0eDdS?=
 =?utf-8?B?eW9mcmdoellNbFVZeDJhSjUvTEJqSnc5ZlF6ZTl1L09YQ1MyMGZVTFdRTHV2?=
 =?utf-8?B?akhFMHp1Qy92eUdkQ0NWL2R2Yks5VkRNUTVnWWV1WFgxS1pxZTljRTFEN2JG?=
 =?utf-8?B?czQ5YUdXb1h4enBBTmUzUnQ5Z0p2U2JxdFpyWWxpb1pzUUJFVFBacE56NGxo?=
 =?utf-8?B?MzdiK3k3eWVoUk4xUnR3R0U4WEU0U1ZTT0J3NTlhTDN6UWhvOGZjVzY5YzZZ?=
 =?utf-8?B?ZWNRczZDNkljNGJPY3dPSTJJSXF4ZkRtWVpEQzRRWjRKSjg3eC9sdy9CMDdW?=
 =?utf-8?B?WUFIMEdIUXNSaDNWeEFDbDJPYnd4MVlrYUZYWnY5MnBtVHY3dlBCOHZwWkJU?=
 =?utf-8?B?TE1hMTVkU1phNjN4ZWNRUVpEZExpTWtnbGJIUG9adjlIRk1xMFFTSm5jNU1X?=
 =?utf-8?B?dER1T3dvUldJSHJ1elEwYzF3UHRONEJudlhUZnBUTlVsVXZCOWxCMWo0Y0xM?=
 =?utf-8?B?bjNNT1I1SlBMZjNxM0M1Z2t6KzgvaTd3dlhNS0d3cUxRSUd5OXBQaHgyMmxw?=
 =?utf-8?B?Um51ajZyNno3Wi9jRUJxUC8xYkRyNW1saWNOVWplSW9xWmtRVDFveFFBUUpR?=
 =?utf-8?B?eG5vRWlqVzJkaFk2RWhDV0JHT3BTMnAvT0VvQXdTYjhzTHp3OTlIeTdUaWUr?=
 =?utf-8?B?ZUJ1SDRQOHVMSDlkdm92MnZQNGsvQXJUUkUrem1ac0ZaSXBSSHp5YlcrN0kr?=
 =?utf-8?B?azhlNTgwdlRiY1Y2K2dQUHVzOStHaHc1ZzNYdFMwSlA4c2pmbFJKdkNIY09F?=
 =?utf-8?B?WkZqdmUwdFhENkxMTnFZdHl2M1dkUm8yaTlFSDhMVktZWXl4dElRQlhzaXhm?=
 =?utf-8?B?eEszd1dFanY2SjlYOTZuZHFadzQ3MG1pekxQZEZWcHFlSjVIMng1OU1IRG1w?=
 =?utf-8?B?Q1dMVStPY0ZpaVZycmZINEw3bWhUdW1WbVlrZ1U2RTVsNHlyZHZ2S0YwSngw?=
 =?utf-8?B?YWJ6NkF2UVBiUDJZNGZxWDFqcUxuZ0xCalNpMlpTVWxuOFpFODB2aUh6MmQ1?=
 =?utf-8?B?ZWZ6ZFdwbUVHdkFwR1ZZTGxhUTBoTDFWME4rVTFvS1l0VkN5Y1h5SFByVlYv?=
 =?utf-8?B?dFlmNTdneGh3dWxiWUwwdWJsQ29TTmtrU3NRbzByYXZOb3RGSHBmQkt2cUR5?=
 =?utf-8?B?b1lSSUd0ZXVjQVo3dGZ2cnlYbnhhb1NkZWlNTzh5TTZza0U3ZmJmZnNQK0hj?=
 =?utf-8?B?NmZpbHJPaVJjSGxaYzRXTUEyVGk2OGlJdHRtMy9VdWxpOUI0MzZZVC8rTjls?=
 =?utf-8?B?T21BSmpFNHkyc1E3d0M0dmRBQlFkWFRZY1ZDcEtBcy8wUWlMTldkVm5zSi9i?=
 =?utf-8?B?SjgyMHd5ajEycUIxRHhkdE9pYkd5bEpnby9lakM2OS8yWHg0bmtlR3UrUVE4?=
 =?utf-8?B?dUVSOFpidWNoeVZVa29IL09ubWhxN3A1eGMvaEpIZkcxbXpXRmlwaGpabFpT?=
 =?utf-8?B?aDNtTzdjeTVHSFNnZDNaVjJFU1NTZTJCaW5kaUNJUHk4UmRsb2RrQXJNOVBX?=
 =?utf-8?B?QVl0ZUFoVmd2cVdNQ2VlRkV5RUJtV0phRnhGZ1E5SWE1ek1VMDEzaTV6Wmor?=
 =?utf-8?B?TmhhcHhPWFdoSHV3TDhnZFBBT1VRU0JmV0VZaGlMc3hYSmNycEJONlFMUTd2?=
 =?utf-8?B?c3NIcURXY04zdk5wMEVmQXVUVy8wRDVZMkRXSzUzQWp5SjRUUWdxU0FzTVBm?=
 =?utf-8?Q?yLa7cQ944e+3SYJmw40suw4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1VZMW90OXhRSlBYZGxTSTU5dUNOVGlFREt5UTU4WXBsWWMrZG1oNzh5a1Zx?=
 =?utf-8?B?bU83V3dtUjJvVlQ5T2ZJN2wyNndOSTl3L2JIQlNFQWFjdE1HVGxMUjNBSTJF?=
 =?utf-8?B?dWhpbnZtSzgyWVEvbHNwa25pKzgzalNBcWVJUS9NNmd2ekJ6SnJBeG5zeDRN?=
 =?utf-8?B?VWkyelEySWdibFM1QlMxTTFEbzhiQnh6NzZ3M1JWNkZBbHUrbzYxeWNBdjYy?=
 =?utf-8?B?aDl0dGhoOXpzTVlBNENuUEYyeXRud1h5RXFHck9VbWpCT3VyOXU0NE5hWUda?=
 =?utf-8?B?RWorVWRGWjd5MXlydDB6bCtqVTdJbG5GN21CVCsraDNmVC9IZG9QdysrN21t?=
 =?utf-8?B?cmVyMVZGNC90ZlJHTG01Rng0SjAxd0g5cGpHcDUxNGJSb1FTejBNR1RuQ0Zt?=
 =?utf-8?B?UkliSDhDNUVTRWRDSmE2T3g0L0ZRNDlMTFcyRVZsSHRLRVNDc0xrQ2EzRno3?=
 =?utf-8?B?N2x1aTk1NDU5SkZhT0xhY1BnWUhyb1BNWlZkZ3R1bWFkdUpPNkVyZDEvSjRs?=
 =?utf-8?B?UGxnVUNPc0UxMG15dDRBclRGQVFoYy9XMnkwNEcrYm95ckk5YzFGRzJsTFVU?=
 =?utf-8?B?akZYelNKSVdiSjhFSDFITldVY1o3cGU4dU5LRS9nK1RIK0xVSHpYVnc1OVBI?=
 =?utf-8?B?dmFqWEg4VS9hQzJLeENvUSs3TWY3VDVhR2Q3TzVUcGU0eEJLNVQveEY3czU2?=
 =?utf-8?B?bXk3N1ZDR281ckNtM3VNTzNScy9qdXNyV3EyNXNkR3dIc0VNOHRCbXhIcmtG?=
 =?utf-8?B?NWhyRm1PVEdtd1JPOHQvWm91ZjJha3duVUNFQVpWV3UzdnRtNEVRNmJYVWhn?=
 =?utf-8?B?ZWZYTkd5Q2cyQyszNEFBbnU2V211Y09iQVNKa2dRU2p4dUVSNUtDTnRGcFIy?=
 =?utf-8?B?SlNKcDk2SUVEcFlDT1hxc1o4dnIxc1VwbWhBRFk2eWdVeXdWS2tMUVdXRkV1?=
 =?utf-8?B?RFd1UTNPanhhYkZQS1kyQnhROHp2d2I4SktNSm5wdGZFcmFvQWtEK3VPUlRh?=
 =?utf-8?B?ZUVIeWxjZ01WSTV0OUlIdWk3MERzU3g5dFlOZkFjQ01JdDFnaFFmNUdYanFv?=
 =?utf-8?B?ZE0rY3BaT0hPTkhPVDAwWlkyTFJBd1UxUjU3Yml2WlJNY2tjTTU5Z2Y1Wlo1?=
 =?utf-8?B?cHZLZTZxTkxQRzRFWWQ3TDErc05TSCszbzNRaVFRQUlIYlFrTXJWOEQ2VXJP?=
 =?utf-8?B?elJjMUtrRWl3SGNaS3hPMG1lRW16SDBsU3pIQjlBREJNOHlwUmJ6N3FuM1hz?=
 =?utf-8?B?b25wdFBZMVJjZ0V4YkwvVTNvMi9CYlhraUc4YU9jdHkydVVpL0xkb0ZlcjN3?=
 =?utf-8?B?S2FpcnRSQVZCREczTVBka0JDa2ZVOGtwUU95dStQWHR3bTVaOFdQOHBGams4?=
 =?utf-8?B?MlliaFlYZFZma2ZSQnA5Qkw4S1REbmdTN0hWYmxhRGVZWHJmZUUwa2x6dTRJ?=
 =?utf-8?B?d2lpZnFNT0FZK0VMS041Y1Y5dUZvbWpHWHpxN0JLc3M5RzMrVHJGaDhrbGhl?=
 =?utf-8?B?dnllMVdzdFA3SzhUaGs1M3RYbHk2WE94RzdHenhuN2RxN0dkTlU3OGpONm41?=
 =?utf-8?B?TGdQNlpiUEtBU25JTWovSTdOTk9xaUtWWWNoczZGVU8xZG0xTDI3VEtrK3Y0?=
 =?utf-8?B?cUdYUjZ6eTd4N3h2VUFMMXhZOGZINmVBODRuOURraU5TcEZsU05JbW9ERGlt?=
 =?utf-8?B?NDlmQmxZZEw3RWJoeENtY2xUNm9lZVA1SmZkWlM2T1o5c1BoQkdsUGtGdWVn?=
 =?utf-8?B?RElRdVQ3TlZxUWRGZUlRdjhVV1ZJU0xlZVdCd2Z4Rk9ucTJIdFR2dEJuYVJ1?=
 =?utf-8?B?Si9ZalhMOEJnYU1YS0hMaHdjT1RQZ2NGdXRGSXJXbDBwSW5MU0xja2tEblVI?=
 =?utf-8?B?bnR4aWJ2bWJWem9FZnRLVEZreC9WUDZEWStmczZvaWlveld0eUxBRzN4OXBL?=
 =?utf-8?B?cHBiSkF1N0Y4dUlLN1lWWnd6eWxmbGgvbXhnbkUxcHI0TnpTMTVvd0s3aHFU?=
 =?utf-8?B?U09jdkZPdjY0T09YM2V2QUdQU3RqNk1WSSszWTNGM0RZTjRxNkozSW9WVDVN?=
 =?utf-8?B?Znp5aFlnaW1yUWN6SDgyV3lCZ2FUdVo0Z3crQ09KbEZQdnFGUmpyUTI3eEJw?=
 =?utf-8?B?bFIvYk9Qa1ZoTlpaSC9hTHlodmRDY252MTI3SnhBVWp5VGNNM0lZOWhIRGR5?=
 =?utf-8?B?bTljZFEyOS9zV2w3YTdjUndXYWk1TEdBSjI5blVobjNTNnhzWXNPUUFhV2hm?=
 =?utf-8?B?amN4bUt5QlhmbXNHYVR5ZVJyakpmbmdEM2ZkVVR6TmZXT0FlMFJMdjlMcWZL?=
 =?utf-8?B?KzBmSVhHSCt6bUNKRkRydmIzVmdaODI5eEVsYjF6b1p2VXl5WjhNZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dbee24-6bff-4bfd-606d-08de5e95655d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 17:48:07.6623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /uJMW1rCjvsc/c/WkK/RGYY9ti5aQ3ZWKi+mj5L8A313ooyM76le9hUVjMAPzft3oKlDlfAw4N61wYckRZMOrNlacEM4HNFzqR8uITwekbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF4B1ECA5EA
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254397-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CDF92A7562
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgTWF1
cm8gQ2FydmFsaG8gQ2hlaGFiDQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyOCwgMjAyNiA1
OjUwIFBNDQo+IFRvOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PjsgTGludXggRG9j
IE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGRvY0B2Z2VyLmtlcm5lbC5vcmc+DQo+IENjOiBNYXVy
byBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+Ow0KPiBicGZAdmdl
ci5rZXJuZWwub3JnOyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbGludXgtDQo+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IFBldGVyIFpp
amxzdHJhDQo+IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBp
bmZyYWRlYWQub3JnPjsgU3RlcGhlbg0KPiBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+
DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCB2MiAxNi8yNV0gZG9jczoga2Rv
Y19yZTogYmV0dGVyIHNob3cNCj4gS2VyblJlKCkgYXQgZG9jdW1lbnRhdGlvbg0KPiANCj4gdGhl
IF9fcmVwcl9fKCkgZnVuY3Rpb24gaXMgdXNlZCBieSBhdXRvZG9jIHRvIGRvY3VtZW50IG1hY3Jv
DQo+IGluaXRpYWxpemF0aW9uLg0KPiANCj4gQWRkIGEgYmV0dGVyIHJlcHJlc2VudGF0aW9uIGZv
ciB0aGVtLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hl
aGFiK2h1YXdlaUBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIHRvb2xzL2xpYi9weXRob24va2RvYy9r
ZG9jX3JlLnB5IHwgNSArKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9weXRob24va2RvYy9r
ZG9jX3JlLnB5DQo+IGIvdG9vbHMvbGliL3B5dGhvbi9rZG9jL2tkb2NfcmUucHkNCj4gaW5kZXgg
MTg2MTc5OWYxOTY2Li5mMDgyZjgyYmFkNjcgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL2xpYi9weXRo
b24va2RvYy9rZG9jX3JlLnB5DQo+ICsrKyBiL3Rvb2xzL2xpYi9weXRob24va2RvYy9rZG9jX3Jl
LnB5DQo+IEBAIC01Miw3ICs1MiwxMCBAQCBjbGFzcyBLZXJuUmU6DQo+ICAgICAgICAgIHJldHVy
biBzZWxmLnJlZ2V4LnBhdHRlcm4NCj4gDQo+ICAgICAgZGVmIF9fcmVwcl9fKHNlbGYpOg0KPiAt
ICAgICAgICByZXR1cm4gZidyZS5jb21waWxlKCJ7c2VsZi5yZWdleC5wYXR0ZXJufSIpJw0KPiAr
ICAgICAgICBpZiBzZWxmLnJlZ2V4LmZsYWdzOg0KPiArICAgICAgICAgICAgcmV0dXJuIGYnS2Vy
blJlKCJ7c2VsZi5yZWdleC5wYXR0ZXJufSIsDQo+IHtzZWxmLnJlZ2V4LmZsYWdzfSknDQo+ICsg
ICAgICAgIGVsc2U6DQo+ICsgICAgICAgICAgICByZXR1cm4gZidLZXJuUmUoIntzZWxmLnJlZ2V4
LnBhdHRlcm59IiknDQo+IA0KPiAgICAgIGRlZiBfX2FkZF9fKHNlbGYsIG90aGVyKToNCj4gICAg
ICAgICAgIiIiDQo+IC0tDQo+IDIuNTIuMA0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9u
b3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K

