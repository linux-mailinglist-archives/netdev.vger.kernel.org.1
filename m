Return-Path: <netdev+bounces-221463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F338B50907
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA6B465AD9
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62C426D4CD;
	Tue,  9 Sep 2025 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQFxpuI4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83808F48;
	Tue,  9 Sep 2025 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757458987; cv=fail; b=EF14d+lwYR917boGFoFc1ZmESyIOReeXwDnIzEZERlWaPxC/qpQ+KSZ8J52l5eVmcBMwQn1rlqUfla9VWxynecQ4B3z9QMSKF4UHiv1g4r814c2dzDCFi5w0s66LvzK0dyRwRKIr5wZVAOwofh5P8PwAVNytbNfpH2SyClH5Eds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757458987; c=relaxed/simple;
	bh=buI8rzb92nxHxSwcnaE1oeqRlrQV/vboiFo8IY5kwvU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jec+ZdOS4FRShjhMeDCL7kCZeoJuY9wykkGN9gOdAsWF7A3mIuIMlENDyp7KmkY80iUDHs84Otlpi+FlIAs9MfRmMLPJ6D0IJ/KY4uQR/W283wYsb4vrSQHQOkr9NJONhKRegHSLmOWGHdhNIT8hBiRrB/PiEPgYD08YucsdkLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQFxpuI4; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757458986; x=1788994986;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=buI8rzb92nxHxSwcnaE1oeqRlrQV/vboiFo8IY5kwvU=;
  b=AQFxpuI4lP87T5wqCTC1/uzg3+bwlc6ERQ/zhzTK5+OXRnoB9zJ8wkA9
   1mUX+Xwr2iVSEHv81JsxbmDCQR4CFla6ls9m2EBytbmHnHK8BNxKYDx5S
   eadj09FnLBwpZDv7rf+1q1Z+0TkaTt64fqlC3aTBkHQ9N+OieQad+Jg88
   +iC2Gxn4ju9qQyTPaOCqnx6GsCBAdwy2SIfLJA/bAVjWP+0+7WsVUoP1J
   WrscFf7ggt69E0aXj1lUVWgZlfVymk+0pCUdpGQlTkcXbyis/8FBEEC1O
   uGGHqvQ6UMugNKvarSp97qNrETI0ihr+c2jPmhy+AQ9RD2zNbuCwdwZsw
   A==;
X-CSE-ConnectionGUID: 1nAy9j6pSrmtdz0P1omwsw==
X-CSE-MsgGUID: wkP2u7n+T3OZDk4kNl55CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="47332081"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="asc'?scan'208";a="47332081"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 16:03:05 -0700
X-CSE-ConnectionGUID: UIISwYCkT/aY1CYc8fsHhA==
X-CSE-MsgGUID: SBq56idVRGCG/rNPB2wNZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="asc'?scan'208";a="178439155"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 16:03:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 16:03:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 16:03:03 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.63)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 16:03:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBgtH4YrhIhlAYSk0XF01tV3I8CtEEyidvPWS91ETw1gxvvgsYJx0Q5cc3nsUXwSBmrTVI5YQW7uH70TwldfD37rNppZXUuOpvt9X1zThX1juRbsY+2Rw737JCxlRdQRkHw0hkNxulU5A12oEb5/kYdsnl3D0Hr9tdSD0xlj6jSoSdvtgvYPLPh2EJ9Y4G4aZeCNRrRTBUTcehe5gHpIYyw82PAbSeyTt6Mxre57QjWtFQ88lyK8nRABiF0W/ed9dU83AePXSXC98oG1o7nYWvL+0b4IgOcptl/NJYRAeYg77Wh1FG1iOFJf7gNmqDqHxvcYGOGxsLk5K3I9XxzpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztUGZ2fl5YtXTGHBnaKINqqH8OVOkdDyJ2lJH6GEZ6Q=;
 b=cSXu3Z8JhNfO+6pZdaJmWhmZDwTO3K9xTpbQiYuXPLTDJZSPInCD5TiJTBeOY7I9CfJ6poCvG5UvttHDQOVyPHbMlbJAtWYqu1X9HzvYw0g14QEe5BS9jCxApL3Dt1C9aqBRio7PQHczG/kp0gzYOIW3XmUtLOLoVMgtwniiGuNEQ8OEjdWnRLDOEvjUmnO1rmXw0j3PsM3dgPay92OfEGSwN/X3LJySQjIswDGuXsKkQU1NQQBztKbLhQgz1tXZTMtpg76MY/3bkeAmfjHj5eL3ldSUnkQAYD+YML8ogD5omtJuFoOX9h8stODevPQCjUBAtraKqnNe7+nA88v0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7852.namprd11.prod.outlook.com (2603:10b6:8:fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 23:03:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 23:03:01 +0000
Message-ID: <2b62f1bb-ad39-4b51-8730-f8304552c161@intel.com>
Date: Tue, 9 Sep 2025 16:02:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/11] tools: ynl-gen: generate nested array
 policies
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, <wireguard@lists.zx2c4.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Johannes Berg
	<johannes.berg@intel.com>
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-2-ast@fiberby.net>
 <e24f5baf-7085-4db0-aaad-5318555988b3@intel.com>
 <6e31a9e0-5450-4b45-a557-2aa08d23c25a@fiberby.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <6e31a9e0-5450-4b45-a557-2aa08d23c25a@fiberby.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------1CxwRUm4m2czY1ivGG2SNzl8"
X-ClientProxiedBy: MW4PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:303:b9::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c3c001-1417-4276-0b69-08ddeff5066e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGpWeWdEVG90R1JGNG9wQWpSbklnd2NJRllRVkhQcnZtUXhKQy9nRWtXd0Rn?=
 =?utf-8?B?RjNPUmtQQ2p3cUw0SXBCSnpSZTQ4NDlVZHU2aVpTV0xOcE9NTVJmVnhRWHRz?=
 =?utf-8?B?dENKSUNJT2F5SVZIRWNKU3BCdVJMaGZBbHJSb0tOWHNCMC9rTHhrb1h2NWEw?=
 =?utf-8?B?SVhXbTBaMlJhaXVwRnNHWXdYeFA1djZsaTMzQW1pVlNTcnZYUTJxTWRvQ3kr?=
 =?utf-8?B?R2VMOTI5TklucDZ5czAreG5vV3VTazJCdnZuSTZ5VmRpWWkyTWpDSlVXOG9r?=
 =?utf-8?B?Zm5ZZlY5WVUvd3NzcWpuYXdoZnE2YXZ5RTY4aitjWjQva2ZiZEFUQm85dytW?=
 =?utf-8?B?aC9ZVjVDVUhxYWFiREVqaGdFbHpvNjRUR1NZOFBVcmMwMk1kOEpIbnl0QUFE?=
 =?utf-8?B?NXVQQUJZSHcxcGZUbWRKNml5UnZPVmp6bXRuZEJSNjhvbGJEaks3OUNzSnpa?=
 =?utf-8?B?VFpsUml4aDhlTUlnUGMvL0RJejRnRlJ3RjEzQ3FWMkg2Z1Bzb21LMGtIYkJr?=
 =?utf-8?B?SzVGWVg0M3RFak9tRUNOK3ZDaVlWcTFORUdzZzVzMUtLVkRzR0lnUHVydWVO?=
 =?utf-8?B?aVJOVUxQTGRSRnJhMGJUeXhwSlgzT3FQYTh1VXVMcEVTZXZaaTQrenJUdGx1?=
 =?utf-8?B?aWRqNldnWVY0T29uVFFZRzhOdzVCWVVWTWZvTjRjK1RmenUyYWc0U29ZZlR1?=
 =?utf-8?B?TDRZLzVPZVc5ejBMQThYTEQzR1VwelJ5NG5UN2RUSHpZM1oxNnRsajZYRmdZ?=
 =?utf-8?B?Wi9QL3dvLzhaSEswT1lFMzhvdHR4RUhwOEhqWDRjT3A3bVRWbEkrTVIzWmdT?=
 =?utf-8?B?RGtsZDZXRGJtN3dOQkc1RVViUmJJZjRlVmNtM2M1RmR4ZE5kTUdzajNhcWky?=
 =?utf-8?B?b3NpR3hjdkk5MFpVbEtkejdFUmZwNlFJSGFFUmpEdGJTcUUwcEl5NVJLcEN2?=
 =?utf-8?B?QmExSmhpS0RCSTVUYUdiWWlTbHd1RG4rSUwyVVpwcHpUSlA1VFcxQlBMdHA4?=
 =?utf-8?B?NEx4UXFtMHBKN2oyVkJIcVQwVkVHeXYvK3pnbWRhcFl0OEJQNUpVbi9YNUZ5?=
 =?utf-8?B?WmYzc29mOFZiYjRnS1FIdDV5R3NRdDBMcGFIVXdUbW1FOHF5SnFrSTNjN2U0?=
 =?utf-8?B?Nk9aa0RyYzJ0OEYyZm1MR1ZZWkdDeWhtMlI2akVsUDd5U09oUWFEMUkveStZ?=
 =?utf-8?B?bE9YWEVBQWI1cGJidGNKa1FIN2ROK2tiWHg2TGE5ZTdFaXUwS0Y4OHhrRUNR?=
 =?utf-8?B?bk9Va3U2dmNyUE9ieThuZjdCdG9KU2VGYXBoWi9ocmNOa0Zicm93TTFpaDVD?=
 =?utf-8?B?MWJIdjBHRHFieFBFRjV3ZEIzdXlma3ZiZmE5bXR5dVlCdlkrcGJJNGlEM29r?=
 =?utf-8?B?clhpSzFHSHNpbG5HbmZpSUE5NUg2ZDl1QytQRFJuTTdybzJIOXJIQUZTc3Vj?=
 =?utf-8?B?VmRPMTR5YXdRZWZFanovdlBSTzZ4L3JsNG9yZzN1R2lXNFJEYVEvSjVYMnhM?=
 =?utf-8?B?R1EyWDJEYkxPcSswSEl5OEhnSEg2a0JqQnByNlhTRDB3L2w4ZERhWWsvOFQ5?=
 =?utf-8?B?eWVPODZLQm5EQ3J3Ymx6OGpteDNwN1d2M095Vk4weHFNdzVaY1FQNXBOUlRi?=
 =?utf-8?B?SEN3TkpmdFh2d09aWUtmcldQYzdPQzQ3N1JtdURiNSt1UzY5encrL2VFengr?=
 =?utf-8?B?di9YRlQ4V3R5dWp0ZlF1NnBKcEl2TEd1dXdWUFlGVGppcXdpNnMzenNSTHJ0?=
 =?utf-8?B?a2kzdDU5N011NEFSY0l4Qm9VWlNrT1JDa0EvK29MVUUwODU0WTliT2lSTm0r?=
 =?utf-8?B?R1dTYjdsNnB3ZHlCR2RvWjdudm54cWJuVktKRmJIcmpOTk03NFFrZkJVWVY1?=
 =?utf-8?B?TFo2aUpRaForQ2phSk5ZeDdwQURacGdabEtMaXVqWTBvbWtvbjMyUC9ublZJ?=
 =?utf-8?Q?yqhHNPKmnXE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm90MXJHNGoxUG9JMmZsNGZIeGZWdGhFemt0U1RvRWhnM2F1TEd3YjNWdzJH?=
 =?utf-8?B?Zk13VUdCVjZ5REUvTXg0bk8wYi96bllrVHVIMlNBMy94TldmTXpLSFhyTkFq?=
 =?utf-8?B?eVBqS3IwRXBzZ050YjR2UnFjbWJsWmxQWVh0MXZPb2NvczA0YW5weCt4d0ZG?=
 =?utf-8?B?TXp3Vys5T2dMQnNFN0ZoUCt6eWZodFBBOG5UNVc1aDAzejFaWEFkS0NlUjI5?=
 =?utf-8?B?c1B6VDZOTkF0RmNkSmtPS2FveVFxZWQ0Wlo2L0RJeXo1U3NseDBCOUYwQ2tD?=
 =?utf-8?B?TzNheitycTZIUmh0dU9OU0xrdVFXUVZKY0dnNVBPKzFiaDVZMjVVUnc1QTBS?=
 =?utf-8?B?Vm9wWC9BQTdDMG9qYWIyZWluY3RUZnhIK0pPYURIUVZ1QlB5UmdBRDFRbWQy?=
 =?utf-8?B?emIvcmNVaGVNMmZ1M2R4WG5FZW52eVhycVhUdXIyelVyVnBMcE9QOGhEUHAw?=
 =?utf-8?B?RGlXd09vc01JZ2VFV2Njcm1HR0NVTEVGRjVYY0liTTNxUmgyTHFnaEdQcG1D?=
 =?utf-8?B?YW8yaCtjUkVKVVN6eGtZL3Z6eUROMnJvV09YZWNLSW1nK0ZZWnloMDZhdUNv?=
 =?utf-8?B?ak0rdkZDTUFLUjc0KzhscmVVQjUrVFZZUlgzVXpWQ0Q5Y0RBYkh5KzZ2VklT?=
 =?utf-8?B?bW5OM3lVT09QV1VNOUVuU0k5SWNYemE5c243TWJjOVZWbDZQUW03bTZhM2dt?=
 =?utf-8?B?U0xid2VsN0NQYlhhQzVGdnkyNy90OFY5aytmOTVMUHFKOWpGQklXZjc1N3dQ?=
 =?utf-8?B?Nkt1S0twd2Z1VzVaZnpCbi9aZFh1c0Z2SllWakRpcXNhRnF6TjV1UGMrSnRa?=
 =?utf-8?B?Z1h4d3JYTzdSRmNjbEoxZ0JIUGF2cTRsSGtON3B1NTBWbDVGeFFzUVNQTHFq?=
 =?utf-8?B?ZXBQZ3B3S0Yrd2pPelNYU04rZDlodDdPcitaTjlQWjBMNnRCS21jYUVLTlFX?=
 =?utf-8?B?emEyU3c5elIxN1M4dW9waE9ZR1ROK05BYURlekpNelZrVEtHTDR6NVBrQjQy?=
 =?utf-8?B?Lys4eXpMYzV1b1pQck1ia0ZocGVxbFByUGdKTFBFa0tDc3RPdzFhWDNHN2ZO?=
 =?utf-8?B?VnRyRTdJOERQUms2dEF0Ym5nQWlBby9lbEl2OUtadEJSUWlJeTlURFRaUkZG?=
 =?utf-8?B?bERXMVV2UFlMRVJUTWRWTW1zd0pjajRqUlg1Sml3UGtkUk1PTEYvNU9sRCtW?=
 =?utf-8?B?TUR0M0NHcVh3TEMzSUVGeHA5RUd4NTB3VEVTTUo0dzQxOUdQQkQ4b3c0UTVY?=
 =?utf-8?B?TkJ6T2FPcmtyRDV6WlZ5YUY0N3JhK1kxT25kVjZSeDU4QjZ3YzlYd08reG1G?=
 =?utf-8?B?V2Y2QzJlSnFpYnl2RHNWMHBpUnIrY3F5b2NVOUxxV2U2ekN1TVNMRDhRMkpx?=
 =?utf-8?B?cHhLMWtIOERUVmdpZUJidWpPUllINlNIaG9jcXQ4VFJESkwwcDhEcGtGYzdi?=
 =?utf-8?B?K3N6a08vSjk1a2o4ZHUwWHVXNVpmd3dEREtlRVFVeWxtRVZIQzBIWnVPc2Jt?=
 =?utf-8?B?RzRYRWV2K09aL29HaUlEVklKRXpDN3RGYVFvY3QrcFFieUlxMHI5dmowZXAw?=
 =?utf-8?B?RlB1Wlh4U3RFamlvT0xEcWxISk5pTkRtbW9tQkdCNElhdGxLeUhsVGszNmhF?=
 =?utf-8?B?azdudllWMWZpNDBHcjRpdkpyYVlWd011NDRERjNjL29OSEpxdHFDeXQ5SlZ6?=
 =?utf-8?B?T0FjbE1aamlnd2QranN2a1J1b1dtVTFRWEFSWEpibnQwOWdVS2FRSmtabEhU?=
 =?utf-8?B?a2h2YlY5L21mKzh2L3Y4dk82TC8yOU1md29HVGFpYnFmK2IrUUppZVJsTVNo?=
 =?utf-8?B?b05GamRzd0pET2lWSW5yVThHRWdSSC9XNkhTNi9FckhFRXR3enVUOUZldjJl?=
 =?utf-8?B?eWt2SUFNSWU0emZ3eUlyVVQ2SWJSTXBkemR3ZnVuYWpkaDMzSUtmeUtjUWZ4?=
 =?utf-8?B?RGt6dmVqbDNRYU5ZTTEwcVpwNEpVSjUrNWhuQVMyTFU1eTh5YThyNFE2RHFl?=
 =?utf-8?B?V0I1cTlKMmlnTWMvRzkyZTNTUVdwVkZOVE1PZXorbVBVOWhPL3NGRUJwbW5C?=
 =?utf-8?B?bmpuM1kxMDRVSVVIcCthNlBYZ1B1OHJUbEZSaENVdWZSeTlJc25tZkUvYTRQ?=
 =?utf-8?B?K0tUcXhSTUdOQ3RSRkN2Vnk0cEUxNWF6NnIzdU41bFFUTUJiUytFVm5aeFRV?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c3c001-1417-4276-0b69-08ddeff5066e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 23:03:01.3671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFrKRWIYJHVFYzF4gF0lYaJyP+Dl3CEiS3+mqiLKRcDV5OdbWrZSA9ndnR3HmPjvWJ5VV/9WsI0nznWBGcF4Mzqb8SgDNyffuaL8CYwCztY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7852
X-OriginatorOrg: intel.com

--------------1CxwRUm4m2czY1ivGG2SNzl8
Content-Type: multipart/mixed; boundary="------------jhX03wUHIpQ0HknoCFkvDnqM";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>
Message-ID: <2b62f1bb-ad39-4b51-8730-f8304552c161@intel.com>
Subject: Re: [PATCH net-next 02/11] tools: ynl-gen: generate nested array
 policies
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-2-ast@fiberby.net>
 <e24f5baf-7085-4db0-aaad-5318555988b3@intel.com>
 <6e31a9e0-5450-4b45-a557-2aa08d23c25a@fiberby.net>
In-Reply-To: <6e31a9e0-5450-4b45-a557-2aa08d23c25a@fiberby.net>

--------------jhX03wUHIpQ0HknoCFkvDnqM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/6/2025 7:13 AM, Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> CC: Johannes
>=20
> On 9/6/25 12:19 AM, Jacob Keller wrote:
>> On 9/4/2025 3:01 PM, Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
>>> This patch adds support for NLA_POLICY_NESTED_ARRAY() policies.
>>>
>>> Example spec (from future wireguard.yaml):
>>> -
>>>    name: wgpeer
>>>    attributes:
>>>      -
>>>        name: allowedips
>>>        type: indexed-array
>>>        sub-type: nest
>>>        nested-attributes: wgallowedip
>>>
>>> yields NLA_POLICY_NESTED_ARRAY(wireguard_wgallowedip_nl_policy).
>>>
>>> This doesn't change any currently generated code, as it isn't
>>> used in any specs currently used for generating code.
>>>
>>> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
>>> ---
>>
>> Is this keyed of off the sub-type? Does you mean that all the existing=

>> uses of 'sub-type: nest' don't generate code today? Or that this
>> _attr_policy implementation is not called yet?
>=20
> Thanks for the reviews. Yeah, it is a careful wording, because we have
> specs matching it, but there aren't any source files that triggers
> ynl-gen to generate code based on those specs.
>=20
Ok. That's what I thought and just wanted to be certain, since I saw
several uses in the code. Thanks for explaining!

--------------jhX03wUHIpQ0HknoCFkvDnqM--

--------------1CxwRUm4m2czY1ivGG2SNzl8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaMCyIgUDAAAAAAAKCRBqll0+bw8o6Iet
AQDzcq0a8p6UP2ZCl0MGc9qoa0it+y3Ci4JBTrGj2vq4eQD9GmqeklzhKl+EoOIlA6tHm/qW5wNC
rcUCIu1r3o0AQQQ=
=ptUN
-----END PGP SIGNATURE-----

--------------1CxwRUm4m2czY1ivGG2SNzl8--

