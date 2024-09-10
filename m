Return-Path: <netdev+bounces-126791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A59727A4
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 05:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41EC8B227D6
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 03:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CBE15382E;
	Tue, 10 Sep 2024 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlDX8oIL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0320314;
	Tue, 10 Sep 2024 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725938825; cv=fail; b=Z0yk7AJAfRByrP5Np0+UhateGq+bgOrDczaD9VH9mxdyN/cnDpnjh6D08o4PvOmFBEmoKmS5k7bRyMYyMsPy+R6Yyn3D8xzpXIQEhehFdDE6Fh8vyzuPHiwdqAzFbEINrVSRdQ/3pqbRR2MiYXJSCp8mJpm4LCm7e4KepDjf3EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725938825; c=relaxed/simple;
	bh=PUdTlZn30mvhD9aQZP797Nc8ZvHggD84iHEx14pOKVE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=irHOEPU+rk5s89EviXJe5vG92ZsuVwvgrboOWQOTEU4uDBa3AOdlk5nzDcUCHug1TQNvWfzhs0xSgUGizTrC7DOJfnEpEtE2zOn3RAEtoryCz/xJSfcdkY5iISFCt47a/QtiZqENNMJWpfzXWo10a6dJ60Cpv2hoQWmBX7bj4gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlDX8oIL; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725938823; x=1757474823;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PUdTlZn30mvhD9aQZP797Nc8ZvHggD84iHEx14pOKVE=;
  b=nlDX8oILxzrELuw9ruGMHhkYfwe/7WWRIRMar1Gva3zNmSEH+GsEJ4b4
   pZuAFR5Yjjhb50HZUpEyCtUyjSeJm8xpbB/k/qXURae7U2nUxZBCHdM1N
   cNwAdhGK125jXJYhdUcsMgE5+13mLzD4crHwssq+Ucrk+ImZ//rDRiMgD
   hpptV9481v1zlUXsm8XIKKE5/dYONZbeqiz+ApnZlMP3yyXeGLqBQMm7T
   eJWI+EEhq8KnpFdChAWy1mZsGSUiZstAiAVeNwZ6IvVCyij0GWhQKsedY
   n1s6YD6Q85lJfRT6N6T2cr1zXq/xjgosiofsfVcmZjrGLG8hBXqUdJsE/
   g==;
X-CSE-ConnectionGUID: LXJkcw+UQa+fsfDsK1ziIg==
X-CSE-MsgGUID: VCDNSNF+Q1+uolyABS50Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="42181996"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="42181996"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 20:27:02 -0700
X-CSE-ConnectionGUID: 6cR6GA8nQSyVqnO5ycJSJw==
X-CSE-MsgGUID: 75HE/EhbQo2yXCJaCryMPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="66937523"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 20:27:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 20:27:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 20:27:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 20:27:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDvSmuB9ReujaDYs1PuIR3UBIYzRr+KfEaKtJ3B1VCzVkTCKFn7ta2OIrENaw0XrDsoeTF8Vi+QKl9XafG+Yzy35ZEpZxuTk6dVNiFXloDguYuiLVSXor1yMrzTEHYKJRR1cFt4yQohoeSIZCZ3gwudTIgf47ozqYN6+zDHeq8/rwczKcAzA1e1BW9LPgQNxpcRvrhtZbUzrDVKziEzM3etR/AnQTP+Bqtiy3RsXpzxJW4HrI8MI23FwymFTl7kI3XfWDfBLZJxE7lP4O7a9l/sPBFc6aGb5Pmy6xeK4/EV60QJBW4oeTtiZVXbtlWcnaRDhb/wNXh9ItmtV5wNckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGnNsPr08bBkncHjoPeBXtmABe3yw1Nyv2WtIWtd6o4=;
 b=WTOw8fIdU21uWcRAvbukD0U9YIBsvaElJsRJlZASWP+YmXRuXsJeErGcB3WI7f2vMO/oyTeKEVSJMdNCvOudMsBOPvBoHX6IiViJwhShYd0NSqeN7qlIWcKOeOMFTsxq4GBGVNGq1jNtC0KYh+OmhBiBWMsYk2mAqdVg11CWPFqwNHDBkCu45Vqrkl8vTPJco0Swi9XRbUgrcQ9BDwFYm2wnr9VOvf1SuUVxhlYpmAauL+xB/yXuAeVrMcXgtgH1D8rO+qcrXwiUAxLE/gwId7TUUtSuJXQM1wPEotvUZL5C/7zKTAu44ybE5GwAe5JYWkOzjALNni+WrhQrDTy0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by IA1PR11MB6490.namprd11.prod.outlook.com (2603:10b6:208:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Tue, 10 Sep
 2024 03:26:59 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 03:26:59 +0000
Message-ID: <937b2409-c34c-4540-9bb8-3142d719a881@intel.com>
Date: Tue, 10 Sep 2024 11:26:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/20] cxl/pci: add check for validating capabilities
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-4-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240907081836.5801-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|IA1PR11MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5f69a8-f85a-48f4-65a7-08dcd1486d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTRpR3UyWVc0cHVkTnFYbjE0U2RMaDZpcmpyelZMdjVlc2V3OE96WlE5YTZy?=
 =?utf-8?B?ZXRsUmZZRVk3YVh3MCs5L0IydEgyRTdkYnhFRkpiNEs3dlJwbkxWNXhMVHpn?=
 =?utf-8?B?d1pJMHFsenYzRTBzSHN1WCtLTHg3enl3SURsK2plVm52bjd0ZHIxNXFvTi93?=
 =?utf-8?B?dENydDBiWG5QVlhWNktMVjU2cUdUSzZjZ0hCeWZFZ2dRQVdtdFlFUXliMGp4?=
 =?utf-8?B?ck8wc0QyaHhCeGo3dkNuNytwNUQwR0FLMHZEVCtpY1hZV3VacUhYL0lxUnUy?=
 =?utf-8?B?YktkNlVKYVFUVDc5bDdmS1EzY0FsVkRaeHlTRjBJUWlhSloxb3gzdFI4dmxG?=
 =?utf-8?B?cUVMVVhnb3YrUHlUbnNpaU1HdnFlcWJ4c2t0Y2thMzJycWpUVHYvTmtnYkR2?=
 =?utf-8?B?TEdCOHhSL0taYTI0YXVRQmhkN1dyYkIvejhhL3dqeHEraWxkR1llYlRGWHVW?=
 =?utf-8?B?eFlOSmluTVlxYlhteDhOZGtnMDdYU21EV2JGMlpJRVR1Mlh5c2JqS0VMV29j?=
 =?utf-8?B?eVgyaGtXZFNWRUpFdVFiUmxwa3FOeURIU0lRa2Nwcm1yZGp0cHpqcC82WG5o?=
 =?utf-8?B?MEVYK29HWDZ6UWU2eTBkdFdESjBLbzBqVUJrZm1QR1lWdGhjODJKZStad2Zz?=
 =?utf-8?B?SGxEd3lzR0dZNkxZV1hXUWk2NzM3UU1EM1p0RzJBTS9yTzhLMlVnNDZvU2JF?=
 =?utf-8?B?d2duYUZtaWMxeUFBTTBOQU1icDFXSlVHdVJzUS96WEc0SFFjTk5kbU5leEU0?=
 =?utf-8?B?eFc5ekgzZUxYYW1BUVJRWTlCcDIwQXBuWHRnbUx5ZDlSeUZ0dHlLQzR1Mzcy?=
 =?utf-8?B?R0NUU01USExLUXpBTFN1L2xiRFZ2Z2JvMkthMnpxdHpldlIwdFluaWgrQ3Nw?=
 =?utf-8?B?UzVuWk1NczJ2WnQwYVVMcnlpZkJuSzc3VFAybG5ZSlBSL1V0L3NzejJrU3F1?=
 =?utf-8?B?UElNYWJSWDBlcTlwalgvUEh4dXdFck1uWGV2bFVYL3dSdTM4R0c0Q2RIcHBk?=
 =?utf-8?B?TE1neXdib0hZVEJ3SU15M2RucXhaeTM5dDF4S3hxU1gyVjVxUDNsTjJmaXhB?=
 =?utf-8?B?Z3IrSjNFa2U5dUNvQ0tFbjF5U2Erc2g1WmZNRzVmRyt0eVBGQ0g5MndLZ2VV?=
 =?utf-8?B?L2dUWDdLNlk4REl0Y0gvc29ZTHBSbXQ2UjhQNXlNZXpYaXVRYjVpdTM5aFAz?=
 =?utf-8?B?NUw3RjNCRk9ma3UxbElQUDVDak83YjNUYzVXWXJaaytOUE9Dbm5DYlluQXZy?=
 =?utf-8?B?STQxNnR2SUxKbVByZ3dMVU1RNTl3a3NvNmNxcFdCSVNoN0dEaXRTeWxBQllG?=
 =?utf-8?B?WEdIbm1LUDdCdGxlUXBpT3M0V1VESkFVOTVvL3NZa1JUcFI5UHhHWWRoSUtC?=
 =?utf-8?B?MW0vYlNvYUUrSGdMeW03RlhEMmw3UGVHSnp2MTYzZjVMRGlmeTdmKzlWNkdx?=
 =?utf-8?B?SUxqQXhUQWl5Ym5WZjBGSmlOS0ExdElEYm92bDNwWlk2dEYwaTc1MGpWaU5C?=
 =?utf-8?B?WjU5dmliaHEyRWdpSzlWczdIOEo3dWJ3Q0YwR0VtRUM3aXhBTDQrYkVmbjBT?=
 =?utf-8?B?bXdZU3ZCaHdFSVM4cGg2YzJTZU1YY21zdEJnTHpnZWdEYXhSc3hIS0NWUlpD?=
 =?utf-8?B?NnFwTFBEeVM2cmxNQzJEV3krYTF1MExNNWlZSWIwanZyN1JROHBaRGM5Wkcw?=
 =?utf-8?B?LzMyT3IvN2pPdFgxNy9UQ1BaRUhzempVZDdkdnhhcEhnbXBBTm1EUnIydVNv?=
 =?utf-8?B?dXdMYk1BTUN6Q2FPd0JXS0ZNMjh2ZDNXVHN0ZEg4dW56dk8wN05EUzhWeWVo?=
 =?utf-8?B?U1UwSUl4U2xoOG5zbmpvRlR3Z01aU0h1c0h6Wk82WEtpY0VBT0M4TlFnUDdn?=
 =?utf-8?Q?fevDEvXSKGFRR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFM2M3dGNHhtRm9sV3hnZWFMSkJ5QXRhcFBtM0Y3bGU5SVpYakx2VTZEMU1h?=
 =?utf-8?B?aHRtWno4SFowK1doWk5xYndxL2ZFdkp2NTNSMjF4M1VXb2dqZ2ExK3QzL1F1?=
 =?utf-8?B?bGNhVXV5N0c5eDVNR3VFc1dOdTNrVVJqY2RTOC80bWtNTlNsUG0rTW40ak9v?=
 =?utf-8?B?bkxWT3N2OGRwVCtHemlYaGlyUmtkejFiU0Vnc2tZS2ZuMHFVcnJiWG5yalNq?=
 =?utf-8?B?Wm8rTGhXeE9UdE55bnk2U0dSWW5zcmYwWkErWDlOUHR0NFRvYzR3NTNzK04z?=
 =?utf-8?B?bE5icWdObXI3dUh1c1Z6VENiKzQzSTkxakYxSHoxVGZCbGthQlBnS0xLNFRZ?=
 =?utf-8?B?TTA0UWs4djJPekpIaDFqcmh4TmhiYWtpcXJpbytPZEFTNFBveUhuQVFYcDY0?=
 =?utf-8?B?YVpodFVKeEt4a2dpU2ozTExPeWdrWVFuWkZhbXp4VFZ3SWZQMnArNm81TGp6?=
 =?utf-8?B?c2VRN1pwSjVjTVRqRWFxZFZGNmxaaVRNcE9UZ3drdXhqVEozRldoYkk0cE02?=
 =?utf-8?B?VitFV2EyQWNmcUl2Mys3eXBkcTZXSXNJNzBmV3dDbDdRanhFN09mczlFQUJK?=
 =?utf-8?B?VGM4RVZTWXo0WklnV1RhcGhnRDB1MVQ4eFh2dFRaVWFHNUhDOUFtQldzV2cy?=
 =?utf-8?B?aURDZXVsZ0p3TmhLK1NwSW5qUm52T2w5d3Qwd0FrU3pUZWVTNEhvQXdHTHF0?=
 =?utf-8?B?cE83YkxFUjFtckNOamlPZ09URHlDcTdLb2twaWxxZTlkc1RsWlVQM1V5bTRL?=
 =?utf-8?B?b051alh2bkVYaVZ6Z3RMM2ZpKzBEbS92ZVlsYStTMWsrT1Z6MjllK3Q2c0lG?=
 =?utf-8?B?T2ppdWJNdXY2bUV2VWJRdXRhSjAvRjdOSkZoM1FSaGJmVXVSM2tjWEFCZ01u?=
 =?utf-8?B?aHgxY1BJWEMvUmpRcUJBY0I2bENGelFlSXU2RGczRUNoRjRGMnZ6WnJFbnM0?=
 =?utf-8?B?U0ZZcDRFdnJVbHZSMUl0TjU2eFBZVXcvNWFMMHBtT0hVVENUWFJvSS9kKzVi?=
 =?utf-8?B?dHQ5Y0w1Q2grS2NONndNMWhKWkxaMVFUckF6ZXJVYnE5WVg4QUZPWFNXM2gx?=
 =?utf-8?B?RFBmWGxyckVQN0Jqc0p0WE02T0l4QVF0ZnZiNnByazljRjF1aHVQYk9adS9t?=
 =?utf-8?B?akxGaTJUQ1JzZDZrNnNCMXVEVWZqZ2RuSXYzcU04ZGVoZXJmSlJCZDhxeVQ0?=
 =?utf-8?B?Q3M1dUFHaEFUbGJCaGU0WjMrWGNITFE5RmFsMkpDRlZQYXVzSHB2QjUyaUM2?=
 =?utf-8?B?MHNQMFFCOUJzZDRQbUdSbnIrdUdyaTBaYkZNK0lTWDcxMWNWTERhOUpQSmd2?=
 =?utf-8?B?TlVUVS81YkowTTYwcWxoYXJnaTRHdDU5TGN6UTVOdjNndVFvcVFNUE15YUJm?=
 =?utf-8?B?bUZkcUJialhIdmgrQm50akY1NkJpQ2poZktwaWh0c0taR240cVB4REtSeFNN?=
 =?utf-8?B?T3NwYmorZkpsSndiR2dtKy92M3B0alJLbDQ3Tm05UXlhSVZERnZRSndrZURX?=
 =?utf-8?B?ODRPcEprVDVEUVk0Z1MzcmVnYzlrNXVsMFMzdFRXVW9YZGI1K0l3USsyVW5H?=
 =?utf-8?B?R3BpRVlNa2VybHl6UlQzZWtXd1RBUHBFM0o4WlZ0TEVjazdnaS8zRHQvc3o4?=
 =?utf-8?B?Q1NaUzB6TlhXTi9MamQxQXQybTVDZmxRWkJoUE12MXVDTGJ6UHF3dDVWOUVV?=
 =?utf-8?B?Mk9DQ1lyeHNpR2NDTWVQUFY3ZG5CU1ljWjVkaVpXQmNFNmNuV0tWYUt3akpu?=
 =?utf-8?B?YmIvWmZzaVJEb3FWTzFaRExLK0RUWC9BQ0QzVkRtZTFwYUF2dU91dlVUSk9Q?=
 =?utf-8?B?OW1PZThkazZmaEtveTVWVmlCUE9QWlZ2OXVDOFc0SkdVaVZ6MGVseDFKUTF5?=
 =?utf-8?B?OWtHY0lGNWxrUVJWeGdRelFWRnFBVVpQeGF4RTRTdnFvTmhPZk9hQlN2RWNH?=
 =?utf-8?B?UzZEQUZiVEZjME5SWTZFQzJOa0lwZE5zVzNpMnhGU1VhTEVocE9naXRJbjIv?=
 =?utf-8?B?ZzlNYUY1aTlZbnA0K3BMRHV1MVpBQzRTQmExYThNRitRTUdkYldZS3oydElu?=
 =?utf-8?B?b203a25rYTFsLzR1cC9IZ2ZEellUNHpYMkJQb2NKYm9nMEV6anJCc2FkR0l5?=
 =?utf-8?Q?q/9BB6SF0k26Ruwf2buTXo1Qy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5f69a8-f85a-48f4-65a7-08dcd1486d96
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:26:58.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3celuVzTK3PIFUDcsVLpHM7gX2IAMIp24nkQBEgG+tNxYqEF0PayJ38+lixa0/YcR/s2ktVfFrqHB28/V9psKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6490
X-OriginatorOrg: intel.com

On 9/7/2024 4:18 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> During CXL device initialization supported capabilities by the device
> are discovered. Type3 and Type2 devices have different mandatory
> capabilities and a Type2 expects a specific set including optional
> capabilities.
>
> Add a function for checking expected capabilities against those found
> during initialization.
>
> Rely on this function for validating capabilities instead of when CXL
> regs are probed.
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c  | 17 +++++++++++++++++
>  drivers/cxl/core/regs.c |  9 ---------
>  drivers/cxl/pci.c       | 12 ++++++++++++
>  include/linux/cxl/cxl.h |  2 ++
>  4 files changed, 31 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 3d6564dbda57..57370d9beb32 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -7,6 +7,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <linux/cxl/cxl.h>
>  #include <linux/cxl/pci.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
> @@ -1077,3 +1078,19 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>  				     __cxl_endpoint_decoder_reset_detected);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
> +
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
> +			u32 *current_caps)
> +{
> +	if (current_caps)
> +		*current_caps = cxlds->capabilities;
> +
> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08x vs expected caps 0x%08x\n",
> +		cxlds->capabilities, expected_caps);
> +
> +	if ((cxlds->capabilities & expected_caps) != expected_caps)
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);

Why has to use this 'u32 *current_caps' as a parameter? if user wants to know the capabilities of a device, they can get it from cxlds->capabilities directly.


> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 8b8abcadcb93..35f6dc97be6e 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -443,15 +443,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, u32 *caps)
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
>  		cxl_probe_device_regs(host, base, dev_map, caps);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> -		    !dev_map->memdev.valid) {
> -			dev_err(host, "registers not found: %s%s%s\n",
> -				!dev_map->status.valid ? "status " : "",
> -				!dev_map->mbox.valid ? "mbox " : "",
> -				!dev_map->memdev.valid ? "memdev " : "");
> -			return -ENXIO;
> -		}
> -
>  		dev_dbg(host, "Probing device registers...\n");
>  		break;
>  	default:
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 58f325019886..bec660357eec 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -796,6 +796,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct cxl_register_map map;
>  	struct cxl_memdev *cxlmd;
>  	int i, rc, pmu_count;
> +	u32 expected, found;
>  	bool irq_avail;
>  	u16 dvsec;
>  
> @@ -852,6 +853,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> +	/* These are the mandatory capabilities for a Type3 device */
> +	expected = BIT(CXL_DEV_CAP_HDM) | BIT(CXL_DEV_CAP_DEV_STATUS) |
> +		   BIT(CXL_DEV_CAP_MAILBOX_PRIMARY) | BIT(CXL_DEV_CAP_MEMDEV);
> +
> +	if (!cxl_pci_check_caps(cxlds, expected, &found)) {
> +		dev_err(&pdev->dev,
> +			"Expected capabilities not matching with found capabilities: (%08x - %08x)\n",
> +			expected, found);
> +		return -ENXIO;
> +	}
> +

Same as above, the capabilities already are cached in cxlds->capabilities. seems like that the 'found' can be removed and using cxlds->capabilities directly here.


>  	rc = cxl_await_media_ready(cxlds);
>  	if (rc == 0)
>  		cxlds->media_ready = true;
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index 930b1b9c1d6a..4a57bf60403d 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -48,4 +48,6 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>  void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>  int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  		     enum cxl_resource);
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
> +			u32 *current_caps);
>  #endif



