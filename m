Return-Path: <netdev+bounces-114080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2B5940E12
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CD71C2463F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D447E195997;
	Tue, 30 Jul 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M61X33FB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412601974FA
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332510; cv=fail; b=kb8KIE5yXHvXVQ4+sahTAcduJHYW9AQ3Z24rfNbzvxhOYkD49xzvFCFtmexuE+CzFCKHj+tvjXq+qwcJgkWdZL+d5EQX5k3w9dhvzfV8U/eFQUA0iPEiVgb/p/MgATretfPw1OvId4hBSnKqX7Gjl2oPUrEkY4X1mydtKW8kHBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332510; c=relaxed/simple;
	bh=BnNZO9tx4kUDNc7UScGolaS92sJ59SAZZYPU9jOJJ7c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MPNYZl9AKeMKt+7c+S9WtQTTGEgG799/YJuqBQoJ25wLUwLD2l7yUXHg3zLUy9W2mjaHbSuCgVsvc4PM30E73vgI0cviF9O+TG9Y2TEGvmT8lZ8OV0HsiBNOHq1X8rOZg7HWubp4kqpx7Gq1aS8nPDNsMRZGf8tI8XT9M38NMS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M61X33FB; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722332509; x=1753868509;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BnNZO9tx4kUDNc7UScGolaS92sJ59SAZZYPU9jOJJ7c=;
  b=M61X33FBTDa8s5Iqpt2+eI6VC61p+1D6BQaak+GNdoEMNZ8/fv9WImnc
   sC4lMgNLsNmddbu92ufYoLvl1lWA22D8TGf2cNwZlaZVzFIgudTgZScUC
   KRnrB+MzaF4yzqyWwvSkhq+npUUyu1p+kJ+eY5dsR/bL8OYLHB0pW7ABp
   zap4UZQAdIOqdUI1JBvGdWSJPtx6v/iWBIQTBr1S9BefeTYpOXRh7WDH0
   DAGZoUfncw+iLIz6Sh0MhGFe1ftIky/iLzvltNsTuqmC4lebSZVXb5RpA
   /Oy925mEcQLKpAJKnAN8TkjO9jkzDTE3Ziu4B3d1nzWccXArS6kdO1p1L
   w==;
X-CSE-ConnectionGUID: PxVl6xD8Q9ado9DGjiqOig==
X-CSE-MsgGUID: eXUsQHxMRn2yvl8W3FJWkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="24001864"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="24001864"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:41:48 -0700
X-CSE-ConnectionGUID: OmuK1C5QQRO8ejidiEolyQ==
X-CSE-MsgGUID: lrwKFHWlS8GTH7g+5DuB0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="91783528"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 02:41:48 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 02:41:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 02:41:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 02:41:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWz2rfkhYO1ohGVguOm+VzpaLDpiYDCWhqx3Z05yswGt5DIsDYQMyN2nLwgI6OymxKhBtvYG5Im0NilQfJg3eR/fCsA5lhstXtIO7Ao6Xhb1aOdrsZ2ShBmjkdJI3Zvkm5uPUYYUlzJSyHanu+eH7RE7sxhrRNAKNoKYZQTlkDzL5rGFc5dGBnD8w2flaFSU9p5i9HQs9ztsVCYWrjQSiy2jXSf0lMSSqEQQzCtiiWtdgH41R6BjU43IKOqjBpo9SqDDR4Dzt/YPJx3s7NjSLQqNApHBPCRA+LC4ym1FquH1Tq+5YOTuAcMEZpv53/0dqO1cMTiJ7fntx1kbT/rYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwqJ9sfMmzhhOMlvwr3vy3sA1BLLVlWGMCucKITmLi8=;
 b=kHU5y9phC7mxT23wm/tLKsEjv0Gm+WQWscZkfYdFrMAywMltG09+6fhexHnsjaGBhqQ/XtMCeqwhxLrMAXQZJx4EMKnuzuvxDXbk/MID8wplv4Z7KZu30KKVGrY/Iw4BkpnvkHM6wP8mHysPcLv+cqpzTrRobPllC++9MiqJckGaqKM//okwWQclPPCXy6QS3Pc2aQDaI6reMKvA3i/DFt5QZOFCiJugnoCO9OQRQntPDrmB+f/8ygeJOnxc5RDpn66RtH5U+NijgjYBflIq2I3b1M4hTTbAjff/ABJmiKHnCVm1iDO8exbxp2vCpGkdM6K0QdF0WYcRC6nujIpyfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 09:41:45 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:41:45 +0000
Message-ID: <7ad7af0b-24fe-4d69-87c6-902f7696b3e2@intel.com>
Date: Tue, 30 Jul 2024 11:41:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/8] net/mlx5: Fix missing lock on sync reset reload
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
 <20240730061638.1831002-6-tariqt@nvidia.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240730061638.1831002-6-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::12) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CY8PR11MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: f55bb090-142d-44c4-65ee-08dcb07bd35e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFY2Z2xVVHB6aHVGaUJiTXBtVk16Zlh5aGVPZ0hMMi9YU2o1SzkzV1dTRTQ4?=
 =?utf-8?B?MERQNHU0THNtTWZmWEhhZjdKN0hXVit4eldMOVI5U2Y5b1RUa2ZSdXlmQ2Np?=
 =?utf-8?B?SVhsaUZraXk5b2RVU01YY3RTWmtFYVQ0cmpYRTN0MkhmdEVVSzFlUG1Pc29B?=
 =?utf-8?B?VVlFL2sxWlpvUk9VZkIyOTQyUzFIUFlPc3NjdzEvckh3ZjQ4ODRRYlY0WkJV?=
 =?utf-8?B?TEJnSCtpdjhOTWY2M0l0VEx2VDh4WUNmaUM2S3M4NGtBQ0FJOGJ0dXJER01T?=
 =?utf-8?B?UHRsekpvWFJKZFJGbk5RbUxpNTVndlEvWE1KWFlEam02dEZUSTRldVRhL0pK?=
 =?utf-8?B?NXBldWQ4TDJSSVg1T093SHJ1aTNzN2Y3M2pRN21mWG1CL1daSDF0NTYxYXRx?=
 =?utf-8?B?RDRQRXFteXFPQS9KdGdBeUYrdzdaMkZRb3o4ZUFraWlPUk5yMXYzY0l3dExI?=
 =?utf-8?B?c2VId1RaVmNDL2d2QVNFdEdiUU9hbWM5RlJLTERvMHgvRllaSXAwSFVjUmNp?=
 =?utf-8?B?RWJGWmtsalUvbWgyVlhsK1lwK0hsT2lSUTFqTFJKbHJNUlJGbkFsUDJSQUdE?=
 =?utf-8?B?Uk5TbDlrTHBndmJ3TUV1TU81aCtHZXJVMTdlTmYrRU0ydjI0dzMxZThlWTY1?=
 =?utf-8?B?anE0TzZ0UFY0dktnTzduSURnL3dkaXF0L0hPMVNDblM3T0cxTG1QTXhhTjdU?=
 =?utf-8?B?blZYdDYrUDlkT0xVWUhmaUlQYTczKzUycld0RVVNZmVWYkthQmdqZC9UMWhv?=
 =?utf-8?B?ZFF0MXlEZnJxVHl6dzlxVnNjaTBVdEdNZ1BORy9weVl5ZS96WHhiUTFuUkJC?=
 =?utf-8?B?VzdVc2kvZlh4Qm9lcUxCNnhyazdncjRNNHBYZzBPV3VaY3RkVWRZQUViQ1Vi?=
 =?utf-8?B?NUFPb25TOXdBeFo1WjZybGVER09oVDVXOVE1eXdLNWs0dDd4UHhzY2dKaWhS?=
 =?utf-8?B?WE1yR1d3RENRU0piN1BZcXEydTRXOWxYNFlXSUhoS0dva2ZMZTZsRTdlSmV6?=
 =?utf-8?B?aVFSTzhLUFpHMHlpSEp6QlVQdXlGZzdJaXBNMUJ4b3p5a3ZsTmNoTEJEK2xv?=
 =?utf-8?B?b01UVDg5QmpnRjFlYXhySVFsWVdqZTlqSnVHWnhWVHFmY2s2WjI3RnRBSjY0?=
 =?utf-8?B?VnVJaVpqY0tRL2NIbHVldjhKYkRpZVpsdU0xNml2S1Q2aDgvNWpvUWx0U05q?=
 =?utf-8?B?ZnFCVldVbEZRR1E2Z1psMDJGUkpMQWdUUFZZbVBUWUJtQ0NEYnB3UFJ0N3Ji?=
 =?utf-8?B?ZFRFbkh1d2pndE5tQjh4aUMwTUVlVkJoK0FaQTY5eUdlcllZQWNEQnZKSWFt?=
 =?utf-8?B?amd6NFZ3R3B6ZE1KZjNzQy8wZEliaXQ3UUpPK01oZzEyVC84N2FVZEFlcGNB?=
 =?utf-8?B?N0ROWEwrQzI1OXptVmtibEFjR3lIMmg3dCtLVWZBOXpvSm93NGpuaTh2UzZi?=
 =?utf-8?B?MFF5UDF6UjMwdkZ3bkI2RjhSMjNDZzkyTWFNbnpSa01uYTNDWUJ1bVlBRHpY?=
 =?utf-8?B?bXNBbm40QTdiZG1vOFpZc3pSdTBId0pRNDZrOWhOdG03Qk5yQmsxRHYxVVp5?=
 =?utf-8?B?Ry9NUmxkQ0NwUDRSUmllRW1Gb2twMkNuaVl6ZUErUlU1azI5TEl5WENoNkdD?=
 =?utf-8?B?aE55aGNJdHcxS0xFeFJuWW5ZeUVXenZKOUg2di9YcEdIY09tclQvZ1VSbCtD?=
 =?utf-8?B?QVFWN1NjTGpOVWFSUDlJQm9SN1RncllyeVBMNmNJcHpWeVN5bG1PS2RXSmpV?=
 =?utf-8?B?VjN1ZFlVWnFoY2NpY3hwOXM4TWtxbTc0UUt6c0xySzc1QTQyc0xMTTdUL2lN?=
 =?utf-8?B?WnZKZHZkOVMwL0hyL2F0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnc2azJ6NFpOeUdNWmJmUzQ1RnhlcU5rcDlzUytteGFSNVZDUmxwdFpOS29r?=
 =?utf-8?B?aFEwam9kNHY2Y0toMG90bW1oTCtMVlp0S0hPTjVGL3E2KzQwUGZ2QmlGaW9k?=
 =?utf-8?B?NmV6SVZnVnp6eHpxNUFPWWxobmZvZnpkb0hwVU9wU3VwREN2NXA4WjBRTGtl?=
 =?utf-8?B?WHZldTZQU2lxUmJiM1QyQWJ1ejE0STZqUFhISm0yVFNMWG5IMnRhT3E4U0xq?=
 =?utf-8?B?bHF3REdjZzFKaHladmxPelNpQnAzYXFDOTRNd1djeVdKQmYvWVN6N2xXK2hW?=
 =?utf-8?B?LzJQaEpOalNuSFVzZ2JoRUpJZVhhSGpGTStSWTB2Q3A3MW50amRUbE1NYWc1?=
 =?utf-8?B?MWxWajhSTFYvU0FxbFVjSURLL0ptOXpsdFNKS1BJdDlvY0pJcnNUbTZPajMw?=
 =?utf-8?B?djJGSFd0ci8wR2lpUWNyQStKOXhITkMrdjVRemx1V1dxT3dhQ29CMFZ2SEc1?=
 =?utf-8?B?clhrK2kwalBrVzJZelcrZGdCUFRiM3p5d0Vja3RJU1NmU2EvV3pWcVVJb3Nz?=
 =?utf-8?B?ZzZjaFlEbWVZbXZBWEllZGczM3B3WGpYSkF5TVhiSTdRWnZaQk1QTnNNTUZw?=
 =?utf-8?B?YzJHQytOWldIMktkb2x6dVB5Z2JqcmZzQzU2aUNLcVg4bGFrZER3OU1jcUZ0?=
 =?utf-8?B?YUdVZFlwdEpQVXdrSzN5Rkt1WUdsLzZ6N3YxQ3NNSklTd05oa1lBYnNOQU02?=
 =?utf-8?B?UDR3emgzTnh2V1hRNGQ2S0NaZkNDZzNjK0dkbDBWb3NseHgwWnkwRjNOOE5T?=
 =?utf-8?B?ak54NGdHZ1A2VnZqSXpBVXQ5UzU1UXd5bHgzZGhnbzhXSFpXVW5lL3ovTkQr?=
 =?utf-8?B?V2hVTUZsQTFLaDd2Z05OMkdRVVQvZnVrZ2lqaVBLZjUzaGZjaHJCR0VVZmkx?=
 =?utf-8?B?MUZCQ0d5WGl2WU8rR0Q1dTMxVEljZjlVZ1Q3T0Z1Vll5SCt5T1ZCUHZMTVA1?=
 =?utf-8?B?OEs1NVhFdjJrcUV5YXVZWlBldjNHaFk4UGYvSnBxVmpqeGI1ME16K1haNjVS?=
 =?utf-8?B?MHFqREJ1bVlTV3ZJNGtsTC8xRjZ0ZFdMdjN0b3VQUnFKRVUvMEhTUHVEUk1O?=
 =?utf-8?B?bStIUG5nUlExR3ZBSVJ6Z1hnUVhQczYzSkpJOHpLR1phWUJQelI3R0dYcG5Y?=
 =?utf-8?B?V3pxVG1nSk1CblJzQ0R5K2NtRnRFZXZvZjhVU2lCWW9tTVY3M0RUZW1WUFAy?=
 =?utf-8?B?RFFWTWEyU0dibTROZm1IZ1hDNG93d2dhK3dDeDhRWVNmcHZsdzdPdzdnMDhV?=
 =?utf-8?B?VEhsZjBVVk82cnM0WDdMcVNKWm9MWUk2elNiakhkZXdkWEhIUHRFL3cra2Na?=
 =?utf-8?B?WHZCdXVYOWswaVd1Wm0ycGZlWGdldzdFc3Q5UVdPOCtyMnVjS29EVERYRGFO?=
 =?utf-8?B?cStGNExPdDdITExBMzYwellwaGhBdWVMZW5ia1hlUFExQXlSa1pPMnpKSzJI?=
 =?utf-8?B?azQ3VTVhRFIwUmF5MlhJNzhjejBpYVBrR0p0bmljbnpTZFBndjAydzZ1aC96?=
 =?utf-8?B?NHBaOUVEVTk1aFl2YmxLbjFoSnArNCtoU09YTGxWTVE4UlZueng4VWpVbUQ0?=
 =?utf-8?B?SGRBQXFkSmRpS2llenY0eXNaVWN4WWU4MDZVZFlocXRVT0Y4Nkd1ZmRxRWlH?=
 =?utf-8?B?VEhTdXV2bTZjRkREamRZTEErN2ZKSERNdTNkVTB3b1JUUzlQSHo5SVNSWjlG?=
 =?utf-8?B?NjdqL01nWUc0ZXRrdDY4VmZlVG5OSVpVZGxZYnJEQXN3M3Z2cUlpZHlTK252?=
 =?utf-8?B?R3VBMVJyNmtZcm1zQk40UDRjTWJOZGRhV0E2QnRyaDEwRUcremp3QkhqTThu?=
 =?utf-8?B?b2g1Um4reUhxeVhES1l3ZXdVQ3ZOUGIrT2oydWlaMytjY2pMMGNkejRQSlZI?=
 =?utf-8?B?T1RYNHZDRkp3Yk5UTE1jdGkrU2xZYSt6NkVWN1h3anhIS3lUa0NvSWJ3ZkN6?=
 =?utf-8?B?bERvbWtWc1BKWDZJR1VxZWNpU3p1NkJjQUpzT3NGNHR4TWwwR0VxZ3prQW9Q?=
 =?utf-8?B?K2ptVjQ5eERYdDNLNmhKVWV2TCtSb3RIbEQvRGY4am92L3llM2JjQS9SV0w5?=
 =?utf-8?B?dFJhZU5FeXNOckNDMXJ2M2s3eE1EOXQ1TTZxN2xNQVBxNjFieEZxazZlNEpZ?=
 =?utf-8?Q?OfOIPY+rq5wFwwpPbdCntpqJD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f55bb090-142d-44c4-65ee-08dcb07bd35e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 09:41:45.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUpD6i8kL1x11OUKhFFyPRNiIyHGm6BcJR9koGLgCYTiFD0vcnzySsQ+goIDarqhBvM3K5Ml6tvx9mvjrf1uJJKCA5+Ftalq2H8ujDfS58M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
X-OriginatorOrg: intel.com



On 30.07.2024 08:16, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> On sync reset reload work, when remote host updates devlink on reload
> actions performed on that host, it misses taking devlink lock before
> calling devlink_remote_reload_actions_performed() which results in
> triggering lock assert like the following:
> 
> WARNING: CPU: 4 PID: 1164 at net/devlink/core.c:261 devl_assert_locked+0x3e/0x50
> …
>  CPU: 4 PID: 1164 Comm: kworker/u96:6 Tainted: G S      W          6.10.0-rc2+ #116
>  Hardware name: Supermicro SYS-2028TP-DECTR/X10DRT-PT, BIOS 2.0 12/18/2015
>  Workqueue: mlx5_fw_reset_events mlx5_sync_reset_reload_work [mlx5_core]
>  RIP: 0010:devl_assert_locked+0x3e/0x50
> …
>  Call Trace:
>   <TASK>
>   ? __warn+0xa4/0x210
>   ? devl_assert_locked+0x3e/0x50
>   ? report_bug+0x160/0x280
>   ? handle_bug+0x3f/0x80
>   ? exc_invalid_op+0x17/0x40
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? devl_assert_locked+0x3e/0x50
>   devlink_notify+0x88/0x2b0
>   ? mlx5_attach_device+0x20c/0x230 [mlx5_core]
>   ? __pfx_devlink_notify+0x10/0x10
>   ? process_one_work+0x4b6/0xbb0
>   process_one_work+0x4b6/0xbb0
> […]
> 
> Fixes: 84a433a40d0e ("net/mlx5: Lock mlx5 devlink reload callbacks")
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
> index 979c49ae6b5c..b43ca0b762c3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
> @@ -207,6 +207,7 @@ int mlx5_fw_reset_set_live_patch(struct mlx5_core_dev *dev)
>  static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev, bool unloaded)
>  {
>  	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
> +	struct devlink *devlink = priv_to_devlink(dev);
>  
>  	/* if this is the driver that initiated the fw reset, devlink completed the reload */
>  	if (test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags)) {
> @@ -218,9 +219,11 @@ static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev, bool unload
>  			mlx5_core_err(dev, "reset reload flow aborted, PCI reads still not working\n");
>  		else
>  			mlx5_load_one(dev, true);
> -		devlink_remote_reload_actions_performed(priv_to_devlink(dev), 0,
> +		devl_lock(devlink);
> +		devlink_remote_reload_actions_performed(devlink, 0,
>  							BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
>  							BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE));
> +		devl_unlock(devlink);
>  	}
>  }
>  

