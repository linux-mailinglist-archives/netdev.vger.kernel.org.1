Return-Path: <netdev+bounces-150630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A49EB05B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480081889BBE
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37BA1A00F8;
	Tue, 10 Dec 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hi01AtYE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56323DEBA;
	Tue, 10 Dec 2024 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832244; cv=fail; b=YnrwXDwnrvggJz4RDEK8POvoOQvIo+bs04y4lt26u593R5Gib3dtT0TRaSHI6fHi/EaC/gV9aQdZlJiLqLKRhkWnhuZam3FULLXg3SVMN4+UfbfwgHSF0FXyng3NhYFy2A7kEbcu7yEIPuWtdTrGCpn8E9SZI5Zsp5ykl6yMh3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832244; c=relaxed/simple;
	bh=nCEA4G/gPVkUtBAfrvRzg2TCSY0Th4WlN304Sh2fkM0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L+NNdXVzyTRpwQCTNKDyDigjSeUsheVa3lBoXancisvApSao8x48M+kKSiB26CBK0ASkkx9jU1RlfmmIvsXuKAbOcunFSj0EgXStGUXAvEazhJkU+N+BK3EJ06nWUu0p+K7P/DV3Oj48mgZ6AFlYLti/aV0U689i8ehG7SqTjYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hi01AtYE; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733832243; x=1765368243;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nCEA4G/gPVkUtBAfrvRzg2TCSY0Th4WlN304Sh2fkM0=;
  b=hi01AtYEauXZaPshRqEEwtg5xaDn3YTB/PqRBEn2f/JQQviM7wBiRVPT
   2gbYC/ks9ybWyjtyZDRriegyo5qahU27rW0YazyvteEfOkGjoK6J/s/w8
   Vtc20gMWiXWWYN3YDHBIUrHlh0EQgp1PtFznoNwgxp2rUqrfIZwOU3Q3P
   zlXPXNkjGxEq0hwz1HFdW3ageUlsSUxufkTc1oredktS/5JpcLEiyIci0
   ydxHQ7t34MRz1JUNi+Vqt5klMIuaz8j9ZOK4f4wWL+DfcILgQdQbvt673
   O7SKUVORSWG7LlLLL6MEzzn7ImUL5vlR2aUfJbatdUDodtBi37Ld4nhax
   Q==;
X-CSE-ConnectionGUID: FHDFuBj9RVGaylELxnG3KA==
X-CSE-MsgGUID: hCPmtAqVR5GRRNMNKzo3MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45182974"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="45182974"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 04:04:02 -0800
X-CSE-ConnectionGUID: RrYH9CarTuG85IJXsvIXeA==
X-CSE-MsgGUID: fL95YMvyQy+oc2R8vZkxfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="118637326"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 04:04:02 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 04:04:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 04:04:01 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 04:04:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWk5h0YCj3vaBd5IBqpBMER6gTI2zp+abR/ycw1w+ySMD3tqVM9HFq5Nv56yygAiUpNw1dKJpm+TwXZk5gHRpwbf6qZsTUrLzqsyGzL5kt6OMKZMm+EE06d7XNbqmPVCU+IxcNPHOGBsLiOJVgaaTDFPO0KvXTmbfR5uqDSBrdBIHc8QX/cNPijGiBv89XPDAQZqyiRXPclYk7YIUtQaJyPuJnk8ua315BbvYka9PKCRTBhEiVlfIoHoJzsBxIEXmybTyoQ4Gcj9U5sPLy0dKNaTZfdx/BAts5Sr6zvrWwRvtEqSo4HCcbs46l5FE1JHmqVcvgKXbsar3uh0WDIV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnS+6tDsS0/FUwl0ZwegRV2+fOFkvVI89Bcaa2WqxXQ=;
 b=Efdgt3JXCIw73eNJG08aNyp7fLmU8DJGm5mvurpYkGRXPUsSzVAFKMdo7Idkx36WlIfxHgpz25BcfjxE78qAS93DXAOMJFcg+71CLPApC84D/3MR8U+B/GgUg2YxAYukVrTFmRnU6giwOhGn9RE4sWNpZ1g5rqOE0BkV4hwTmijUVhm1aGj9/XPc0R+efE2LjGoVKcCDa8zeNL8/5CAAGJ1Jb6Sk8mvBJt1HNGmU5OXFxLee3kuwDkY8BJTQbNLcmsoSfZLrrcPebA8iDEA+yM+BHEDdoMeZfjl2dkLMcLOJTq14E5sIGCgRufwinTD9k50gAVE231W3nPZpr/dFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by DM4PR11MB5246.namprd11.prod.outlook.com (2603:10b6:5:389::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 12:03:59 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:03:58 +0000
Message-ID: <7801c223-b45f-4f21-9ba1-bddce2ab0d9e@intel.com>
Date: Tue, 10 Dec 2024 13:03:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] net: phy: Move callback comments from
 struct to kernel-doc section
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "Jonathan
 Corbet" <corbet@lwn.net>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	<linux-doc@vger.kernel.org>
References: <20241206113952.406311-1-o.rempel@pengutronix.de>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241206113952.406311-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0131.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::15) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|DM4PR11MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1a6eca-08b2-4163-65e3-08dd1912ba89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjI3OG9jQVNRM1lmSU04OVhVVVZXVUdKUE1tQUl0cDVVTGpmNEZheU1CRlVy?=
 =?utf-8?B?UzhOV2hjOUtRT3hqN1hSSm1mZFg1MlZTY2ZXSHc4c0R5S3cxOFgxUkRmbWhn?=
 =?utf-8?B?SlovY0JRajlBWnh1VzJ5KzZMUU51M0tVUFZudVA4d3A1YkpWbjQzNlR3WHZR?=
 =?utf-8?B?eWNQZ2hQZVF0ZWx4dE5nYnVQZTFnaExGRk53Wk1vTVpoQktTMFpYakVsQnRN?=
 =?utf-8?B?azhLeFZjUEpnVmpIUEV6ekV1Zy84M3hwRnNvbVhiVmY0STh1VDlCazF1QUpG?=
 =?utf-8?B?L00zT3pLRUM1S1hndklXcEd3QXJINFFtVVF5OTJTczJad3F1WEc3ekZHWUMz?=
 =?utf-8?B?dkZld0FmK3V2TGVrWUNiNVpiUk0xaytrazJ1NmlmRjRXdVNpaHVzYTl3U210?=
 =?utf-8?B?YTlhWFVvOUVWdmhjQWJlTDRWU0ZQaWx2Rlp3Y1AyYktZMEtGOUJ2MUdmSWxJ?=
 =?utf-8?B?RVpobHlDaVluSUVKQTVmSTFOZGM1cXh4R3hKcFhwQ3cvSGpTYnBiR2x0WjZ6?=
 =?utf-8?B?c2diWktCVngyaDVYU0tNS1dYeVppalU5d04rRldzeXViTlBTV1EySkY0RXFD?=
 =?utf-8?B?bXZFZEErTmZPRzlDdWM5VGNzTHR5VVd2d3FqQzlQQWZwbEZ1eUloRTZTWWtG?=
 =?utf-8?B?dnNzcVJDREZrQnl5N285Nm5uUmpuRjFJVk9lZ1p4VFY5L2VabFc0MS9YWnps?=
 =?utf-8?B?UzhhYWsrcDhUM1U2cnlBUnp0Z3BTKzM4djJIc2tKM0hrbjkyUWNUeHg3SCtG?=
 =?utf-8?B?U0o2RitKS0NEbWdoY2w3OWZ0UWRtUzBhY0M5UWNyWVRVT0hMWjhQOU5xNzFq?=
 =?utf-8?B?VWdHRDJEaGZ0Rlo0aXkrbkd0SkFLWTNhN2lBYUJWeVh3NEFjRDBub2NpTjBa?=
 =?utf-8?B?aU1mTjdCRDZaM3FlK2ZQalA2YlVSajFWRHU4NEF6bjBiS3NybE5XeG5FNi9k?=
 =?utf-8?B?VUxkSHNzY3ZUOFB5R0NmSkt1WTBiazZHZjdzbC9tZmxaZ2kzaVBWWDBhL0NI?=
 =?utf-8?B?T2ljVCtMVWhBZDlyT2tqWjJ0NGdkVmlrbmU5YUdIRG5zOUlBcUdMWm0yYzRw?=
 =?utf-8?B?OHhoWFY0bHVLWTg0Q0ozQ3lndGJHT2o5cjE3ZTYyZWRtWHo1Qm04eGppdGJE?=
 =?utf-8?B?QWhwTWVJYURyS2xPZFU3ZHlZWnpXbUZKbCtBQnJ1RkVvRnM1WUtzNC9JejQz?=
 =?utf-8?B?WVFVekVGQzV5dlhydmJaR1ZXRVEyaDJYU1pyVzR4OGNuUnNQRFpuTTdFZmdP?=
 =?utf-8?B?UVVGR0J5WDVKa0VjVitLTmZRZElJOFlyVy9NZmcxeDVhVndoeEZ5UGJja0Fj?=
 =?utf-8?B?Myt6NjMwTUFxM0dGeDVteDBTWUQ5bHpKL2UvZnNnQnQ1R3d4UVZlVVFCL24x?=
 =?utf-8?B?cGhvb2ZDTm83Rk9QVzFTUHh5RWZvazhlWHV1dXR2UmU3aGhlbFJ4eW93UjZs?=
 =?utf-8?B?ODJ2T25WNzhTSTNMb1JqMXJmdUVwWUo3aFB0UTg2Zkk1bUtWK1d3TTlmbzVG?=
 =?utf-8?B?dG5VdGVQakw1TTRaVXFHb2ZLK2U0bjRUMzBrdU9tamY4RThEWVJEdkJLSTBm?=
 =?utf-8?B?Nk5ya0F4czVLdU9hQlVoNER2WDRNVWdZMFE4MEJ6empNZnhOeWg3dmpGUWYw?=
 =?utf-8?B?a0xzZU4rZDdwUVZ3L1lqM2VaMUR3aktaU0hwQmxiNkRvRHZscTNSdFh2SWcz?=
 =?utf-8?B?N2lqcXhiUlpZYWJYcUJwL3FkNDNsb2F3QWFpSnh4YXllZ1dqdDFhbmh0Rngr?=
 =?utf-8?B?M2xUN1lscU0wM1JTWWFROEZkL0QvNUF6V0RUbnpvNHk1a1pLWFJka0ZuUHhW?=
 =?utf-8?B?VmpKZWZ6cTdDYmJrdGZHZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkF5NHRramREMzUzM3ZWTld3MS90dnk0SnB1RlFyMEhUQit2UzhXTytXV3RM?=
 =?utf-8?B?VjNkTDFyaEkyQ0tZYUNEV0c1a1BpcmFxUGpMa3dxZ3VRUVNPZnMxZXpjZUtj?=
 =?utf-8?B?eU8wd2JNVTNZU2lMTCtaSitXSFh0UjR2bDY3b0k1cVpuUjluOWJscDRGZ0Zk?=
 =?utf-8?B?NTdJV0lMbUpRMjlrTUFyVk1qcHlManVPc3lWaTJ0R2xsYU5PaW1xdnpIZC9J?=
 =?utf-8?B?UUkzUmNrM3U1M3ppNjFBMWQzQlc2NWZXU0VrRndyTksxcVhjVXpiNE9Td005?=
 =?utf-8?B?emJnazFLR3BWa0tUM2U1MGxqRHUyVEZCQVpXK011UGRZNkhHY0dOUGl6TUFs?=
 =?utf-8?B?clVEQXl3N2dYODNubEhvZUlCaVd1QnpJaXIvRWZ4ZlNZWnJCL05CN2xjVmdn?=
 =?utf-8?B?d3p5cjIzTXA3dmhmQTk3TkU4U1BzWGRHTm1HbDZ4SGhTSWYyQkpyMDQ5NW9L?=
 =?utf-8?B?SkpKcHJhcFU1QW4xTElINGNLWERuZ0VoN2d1QXNGREM1VnpJL1cvQnRVTWVL?=
 =?utf-8?B?TVYxZUNYNkJyNFA4VmRWeDdLVlZ6Z042akFqMnh4STQvSlhKaEFYNHRRV0RF?=
 =?utf-8?B?MzNtT255cGRwT25SVXhJQ1QxNHVzdG5URHhHNEFDVVFLS2dYVDdRU3lhODdY?=
 =?utf-8?B?cGhQWnF3Qi9xSC9NelRRSVJIRi8xSk9FRURaQzdrYXJXN0t0SkdkZU9LVytD?=
 =?utf-8?B?Zm1wSndqTXNoSnZpZVlmVHFVdXZhdzBEUENFRkJyOVBuYXZnL0dsR0d2cnV2?=
 =?utf-8?B?ZktIYXdQSnpOeC9IdVFkeThHaWtaM2o3MzVsVzdUY0hjdzA1ME9PM2c5anFl?=
 =?utf-8?B?elVGRENVM2pmZGNqRVhmWmJXMi9HWjNlNTVETW1uY0dhZCtWRnQ4VkV4d21t?=
 =?utf-8?B?T21kWHpkYmFRamk2Kzk4VElmMWczdkhrNFFTb05JRGhhRW9mUUZtd2JDcnhD?=
 =?utf-8?B?NVhaNXBSUHBZb1pWQnVpWnFHamNsTXI2SWdBUFE5WTlKbGtsZzVLQ01XdldC?=
 =?utf-8?B?N0dKS2JyMFBVRTROUW1aNGpXV1V5MDZ6eWJucVI1cUY3UVFrWWRYQnNkdXRl?=
 =?utf-8?B?M3cyZWliOHpNQjNkYTFKYTJ4SEU5ZmlVNFE0RDZndU1mMHJUWWdHZkhPSUx4?=
 =?utf-8?B?dWdNQS9MWVlPejlSTHczT3RudjV3b05WMnJLZzVoWDF3S0dsMHFtdmNTMDgr?=
 =?utf-8?B?OGczWHpheFV5UjFFQkoxR0NTRWkyam9BbWdDQ0pOQXcrNnBqcFZseUNGYU5C?=
 =?utf-8?B?bFhSbUhzdGMyQ3JaNDl2ekg5MndzUzNPRnU4VXVKdEpSY0ZacFNOVGhHL3Mx?=
 =?utf-8?B?TnVwQ0x0ekZtTUZKVGFtdWVzZTMzR0VVL0xTYkxNc0w2MnlCZ2lvZk95R3pY?=
 =?utf-8?B?M0NLTkQ0VmRhVTkrNlBQZlRReXljMWNJTTlabDRlR1UzU3ZqOWFRUnU2VkVw?=
 =?utf-8?B?WE9ldHF0UTFtZENYcE1qMTM3em9FaEtBNGVxYUNpQ0JDdGdzZjkvaitmZ21Q?=
 =?utf-8?B?ekp5RHpuNEcxK3NiV0U0N01VYUpIdU5DNllZNGdiQ094TEhTVElueU1uckh6?=
 =?utf-8?B?cklzcWtWOVgwck1ZV1dWSE5NOG5IQkxUd1FmaFhpb21saDA1YUdtNTRQb0Na?=
 =?utf-8?B?am0vR3RhcEJOeXR5QVZtdlVwT05FRjUwbk9vU01Ma3pkZ1I1WUpIaEtobEFR?=
 =?utf-8?B?bWoxREV6dlFPc1JJSmxqVHo2N211TzJZN0lsZ1J2dDZSL2t3UDZYN2dIU294?=
 =?utf-8?B?YlQ0Rkw5ZHJyQldlRGF5OHQxcVVQREEwc1NLdjZINnlJVlJoSnBCdU1EL1N6?=
 =?utf-8?B?bmRDTE9jRlRWQWpzTkhEV3hMNk1qNTJURFRtRENhVUlWb3k0eVovclB5M0hO?=
 =?utf-8?B?UmsxWWJjU29ocGlGTGVpYWRpOU5JZjhJZWpTWVZoRlpHdmVxR2FhdGZ5bnpx?=
 =?utf-8?B?RXRmWU5hZ2FibjE4MXlaN2RIOFpWaHZDZ2JWVDQ0UEZoQm16WFZiaTR3WGdv?=
 =?utf-8?B?N0V6ZEVyUm1qcUNiejl2YTRyUFlrN0FwQkRIb2ZOVHF2Wkp0UlZPUHNMa2tE?=
 =?utf-8?B?dktJTS9iYXNLaHg0YmFsNXJuQ1NwMmQ0SE1LZmFTQWtuVVhiUU9DWjZlbyts?=
 =?utf-8?B?ZDN1QzVsQ2ljNlQ3Wm5NYlFsTXhQU3V3bHF4N04wcUhpcjk3cDJ6KzJLb3lC?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1a6eca-08b2-4163-65e3-08dd1912ba89
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:03:58.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukfhmNfcZn5uVCiAgmULdyonFeWvzXA15oGKUrXwVhZadf9Ouxh/bHcPFuSB/bhUWpwKP4OtQ7vr4+jEQa8At7JW0bMYL7aIeW0ctCoZ9iM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5246
X-OriginatorOrg: intel.com



On 12/6/2024 12:39 PM, Oleksij Rempel wrote:
> Relocate all callback-related comments from the `struct phy_driver`
> definition to a dedicated `kernel-doc` section. This improves code
> readability by decluttering the structure definition and consolidating
> callback documentation in a central place for kernel-doc generation.
> 
> No functional changes are introduced by this patch.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   include/linux/phy.h | 705 ++++++++++++++++++++++++++++++++------------
>   1 file changed, 522 insertions(+), 183 deletions(-)

[...]

Nice cleanup! The only nitpick is about the "Returns" statement in
functions. According to the kdoc it should be "Return:" . But
nevertheless it looks good, so:

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

