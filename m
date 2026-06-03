Return-Path: <netdev+bounces-294960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IFmbJKywIGoD6wAAu9opvQ
	(envelope-from <netdev+bounces-294960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:54:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 972DA63BADF
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:54:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=CZBbE4l7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294960-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294960-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1E343014429
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9E3B27D1;
	Wed,  3 Jun 2026 22:54:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC76395AC5;
	Wed,  3 Jun 2026 22:54:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527271; cv=fail; b=ElmsZdCQLML6nV6gUkaMG5ME6Gs2CBMY0vVpUTpIn5shH/TUZ93soDrZV0YF7G1JCJhn5kRwT2yKvS4BmcaK/zNQIabe2Ri7ESduXHjFjlPU8IoouqEgojUH+ENOmg2DusQnDAde22GzQgJsl5dZEOnYc591cH/3dsJXHADdiME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527271; c=relaxed/simple;
	bh=SxeEwzkIvxw1VvkFefAfpEOusq9az67BmiTD+bZ2caQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RIV8JVmUu1a/L/lVBoBqO2w8lcwZEzkf3geqfDzyAfDodo3XIuL+Ve/wOM2UYfKalhgZ4wUHTZs1wi8fq+8XbUw/BVCWsT9OyI4HVQ0tAn28XLBYCDKh+M21udkT6hI4Ldr7NiZrFd0KbR3mtVwpRa+FM/R9/wyTQKs5DoN5DVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CZBbE4l7; arc=fail smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780527271; x=1812063271;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SxeEwzkIvxw1VvkFefAfpEOusq9az67BmiTD+bZ2caQ=;
  b=CZBbE4l7hbBHDgSgTCKMVC6HyjUdWn/ZA8Rz9o/swpB/+Rae1skg5tHP
   aVa4MPJzmj8X1alM59jB048kYKYWeOFQLvUMrSOwaxyTxXfZkFIts1jS7
   lj94F7vYWx0jebefbtC1t2aoirtmefmfF0HBXJDeGsgCJaCKzOn5bsiEY
   C5KwLYSETS9+KSWIHphgAKhH1ek4e0k0pEdJCbEF5m5HCRCI4s4ZNuxF1
   skpxMfUVC+8Y1yLJrj98YDg8/B/pHaYxhKJeEO9mZcVvkShqvc+NspkJt
   tGKqMWVyOP1M2beK3rb5Bg9MugiUbBenAvPRnBNZLXCv2uH5XkVvCCLNb
   w==;
X-CSE-ConnectionGUID: ddkl8zOpQnuLLXwwwqwlwg==
X-CSE-MsgGUID: DYvTN3PpRdWc+qrf7u9mzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91666388"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="91666388"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:54:26 -0700
X-CSE-ConnectionGUID: u9LltfCdTWSUSWsJhIV3rQ==
X-CSE-MsgGUID: RPe1nXc2RqO+XMH7ptvvJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="244452930"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:54:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 15:54:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 15:54:25 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 15:54:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MynjpnvvRpTQ6zaEnDfSox0kq3lZHtFLe8NVakQ+kiFQyR3Ei/rjNI9+o954/Azwg7uj360FsmHg59MQpHb9aBFlNGfibBubkuyFZz1RM6h95WATlZ4tfNEdTGYUz1J+BxbzlNEo8WBjeuiUlHaBq1kIqqUKHFZNKYv0vqUVXxva+H5ZC8n7w5Bzi2hczF3qoC957At+HcPLEUCVGQsPsXTk1vQbLVFZQx9K6CZpT1bqaMvO6ZUblMJ4YN4wfs38RTvO7HuZDqyI1mKROw1HEgCYLml4aPbxRPTgD38UuyeyQ89FmCBz8Ey3t0VtZWD81StXQ4C1zXOxBkZcLDraUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=em/3FBV5QHE3orwmM0ZO6dOIjwuXF568PlcYBaYIoHU=;
 b=tIQAJLWzU3OBRAAnqYujvZxy+SvWn55WZUsSZjAr7zy1IjKH1QPru6w1cDf4pU8LwArm+wg/UiOylH3TkwMnmppZjM5iFyULG4Ho0RXNwFNtEoJpO07xfJ2xv3uSbwms+KnpZ1ScN/eR4yJ3S14KRc4RRJcxrYG2pPZ+XOIts6q8pSrdupq151ljIpQjH6MYHWLpdo5V4424vQPbAcfdhJMI7fSXaqteDdfAoeKLIWmOm8Hl7qQpuNMjY3rmvnR9xzvcwhxd8jMAUnxVRXkbSlYJMFM4wqOyNByEVkzmuXFc5Fd0uqzZ/EsvkEM3p/pWrcqOFwglEsnxjnhLh2OUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by LV8PR11MB8772.namprd11.prod.outlook.com (2603:10b6:408:200::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 22:54:23 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 22:54:23 +0000
Message-ID: <2c41adc1-89ff-4ca8-8c86-3fe3dbb0a8fb@intel.com>
Date: Wed, 3 Jun 2026 15:54:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] docs: exclude driver and netdevsim bugs
To: Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski
	<kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <workflows@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
References: <20260603162943.2406080-1-kuba@kernel.org>
 <c78c1ff315ec96795461f100064bc42c524a67e3.camel@sipsolutions.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <c78c1ff315ec96795461f100064bc42c524a67e3.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0307.namprd04.prod.outlook.com
 (2603:10b6:303:82::12) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|LV8PR11MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f600a94-0655-478b-9198-08dec1c30de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|4143699003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: XsH83n9zSPaMrtCi7P9BiKVzzyUDKy7/X50BNMGNNC+Ntm1e9r1e/nXZOdCfI/XlcNipcqCoQVnOawjmET8lAwcI3ucKPGM6m4Q3xaacPLZKIY4kRFi6ThbCd68UtQvfXOxNcSjkV3JtNlIKP4Y4OA6cOFqLNZq/eRYo+m9+6ysxJuIjQDQR83MvKo/23c33xv8NNHoP5pQ+kvfAIW879aflkajshN1KKXcBfNK1zESe5278Hgf/9Jwp0I9kfsvRs57Y3drGUJyP4f0XlAGH9ZsOyc5DlKkKrYStX7blbk7fitOF1Sw9RaGxUdOUj7wO+K9gaZ/3MmOy88fllaIHMdSACwSPy0uqtxdCQFgcBt7O2XAG0/kbrriGXZ6auyM+dY1OpxvsRnOUwwkY250AuTG1JuUNxZbMceCSIek+fXH6Y+45av8gHRLWzbMtt+PRWz8iqT6juwsW5zdq8KTG04VhPMD6iC2Ajg3wiA2B6WEu1onOzrMIwUIEtl8FTJEo01UJmVvpbUw0IlOH67/Iev2gB1EioVB2eTSks/lnd9hhYS14voCdQUB1ZyXBVE+HAZtFnR8WnfCuU4WuNbfnvVJC7zNoWsERJHuFB7XSqV1LiGBd6dDPxlFnMcnJpNEmkUzAEiUGUitdJA1xBIcRGqqDoKXVp0cmnLW5oEozg4niCD74/E7htATa6yoah4R6HS7ylF3q0x3hxeMr0TqVKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlViTGs2Z0pwcXVEd3JHZnMzY3gwSXdSSGt5MHlEd09oWGlOQWJUVjV5Q0hh?=
 =?utf-8?B?MEZySjQrVWFmcGpxU09GQ2U1bmdhUGpEQjZwNGxGdGN4K3pWTEJTckVFbjMw?=
 =?utf-8?B?aUVhaWVZSzVDR2sxMjRYajJZTHhJY1FkejZoTUJWOGlacE1NTFoveGFscjBz?=
 =?utf-8?B?ZjBTZ2tCVlEyMXF5bGlZMG1kTFlMZ3pqZjE4Z1ZsT1dkdmJML2JVMnNZVThx?=
 =?utf-8?B?YUloWXQ2eHpoVUFJdVZoK25RRUZ0aDg5T3dEMnV2a2llSWpvZDFLMlp2R0ow?=
 =?utf-8?B?L3pId3FYRWYwZXZOUmFjWHo3YUMyVHNIUmtDUDUwR2xTbk9zbkEvTVJnZk5r?=
 =?utf-8?B?WG1HcWZZR3hDVzBQYXd2NWU3R0Q1eWtGVnlicHJmMWNCRWpIQUp1UjdXeURU?=
 =?utf-8?B?WkdLcWt3T0F3Z2JDMTdCSWN6emRKdkwzdzZoMnVRWXZ0Rko5dmtOZkNUeXZ2?=
 =?utf-8?B?L1hncHhVamF5S0ZjZlZBdmpKTWZoVitDK1ppRmR5Q0lxbndJd3F6MyswNzR0?=
 =?utf-8?B?ZXFXUWtuQTBLQWxiWmtMY3huQjl5cWplaWFSZ1V1TkhleENTRDZUZWlqKzdt?=
 =?utf-8?B?R2t4TENlSkxGd1BoTTU0dHhEZ1Q3cWpBK2F1TlJNWmhtcUhwZFpnMEZxR2NF?=
 =?utf-8?B?RjA4NHlxeUpLdXFmVUxFWHdDUnJuZWs1TFB4dnJseHJzeTdsNXk2MzJGc0tx?=
 =?utf-8?B?NHFMa2NJcG9jQUNCTUZmaHdBZEkyczR0WDlzVEE5eWpUczZ5b3NncUZFa0Nr?=
 =?utf-8?B?MHptMFBMZjYxdmZzUEt4MU1wL2pTMW8zTTh5WWZRZzVkaUhRWURiY3pQZklE?=
 =?utf-8?B?QXE0a00rQnVCWGNkNTc2blFKQ2JpKzhKNHBhelFOSk5YaGFBcnY3dWtZTFRk?=
 =?utf-8?B?cXA5WFZHRE9mSXc2eUV2QWdmRnZMajFHUUpucHFlNDdVMnJJTTNSNFo1Mk05?=
 =?utf-8?B?S2Q1WWtpQ0lFNE11WkRGSkQ1L3U4RFp5aUVabXBURFJ4MGJHNjJpcVhOM0dM?=
 =?utf-8?B?MkMrWW85VE1qc1dpK3BINlQrL3IrZkhNTkkxTDVLbGdTY3dnZFc2d3BMY2Ey?=
 =?utf-8?B?MnIxbCtJRGhsbWsyMS9TZDYzRE5QdnQxNFZsM1dGVTE5VENpZVp1REVXUnM0?=
 =?utf-8?B?citoekZ2Y3FJaFZSVW9zbzd0eHgrdGdXS25rZmtNQ1JkTU1LS21IYzhmcjF2?=
 =?utf-8?B?cUw4dFMrdStmS1RZMTBwU1RxNWJIUmI2QlJGRWowS2Vha3NUd0loak42OURK?=
 =?utf-8?B?UU9admlGOVBKTzhZQjdvSHZwdTZUd0NUZ0V1NnRSdzdScDF1Rnkyc2x2eTNK?=
 =?utf-8?B?Y2doOEdxNjZHSVVoaGdRZktJMWtJOVRuNXk2ek05UWdUcXpnaDhzVGdLUm8z?=
 =?utf-8?B?MEhOVjNSVWRWclVRR3hkTk5zY0gwRVo5dzR1U2c5b1g4SlZWOU9PQktSUkZF?=
 =?utf-8?B?VjcxWlVjZ2dpTFlrZGVQMzBmV2FTa0FqY0gvRjdqdWpIcENxbk0zcTE1NE1w?=
 =?utf-8?B?eXNrVnNVQjUvdlVSRzk5S1A3Vy9zamtkRGhIMk1vSENpS1ZQejdNZHdxWXdD?=
 =?utf-8?B?dnJWNElLUTF5QU0yZHE4VUxCOEdwbDByQmUrRzZONWY3bElodUxTVkMrRmo3?=
 =?utf-8?B?RjE0V3V0WERJYXM0QXRhN21peE5JQjJPcERzVkI1Ri9Lb21qYThEeGFrcnUx?=
 =?utf-8?B?Sjd5RVl3Vm1wUGxIZEF3d2RvaTVRb1hJYWFVUUh1enBxZzAzNUJZaFliUHFI?=
 =?utf-8?B?aWRpMThQQXJIaTZvU0pGb0ZtSTFGL1FNVWtvVDd1S24xYml2ZkxEbkR2UjN2?=
 =?utf-8?B?NFQvOHJUVzZuemxCU3MrSE1wNTd0RUxtNmNrTnJMYytkQVpkelNqVUh1YmFV?=
 =?utf-8?B?N01TNGpKc09jU3hWY3h3Y3ptbUtBalpMcEhXM1pCQWZzSHZBVEw0QTROQkpu?=
 =?utf-8?B?Q2ltUzVPVUxyZ0VlNjFSQUg1OEtpWTVlcDd2QWljUjFzS2xOSjRCVGhPd3I2?=
 =?utf-8?B?UlNDM3V0OU5KKzAvdDV2UXFySEJuZlpFY0VKbDNZbUVxblhudE91V0FXM0Jm?=
 =?utf-8?B?TjI0OFQxMWdVUlA3YnVIeDV3RldlSGhpZ3loakFsbHBPZGtDYWdCZEtCakx2?=
 =?utf-8?B?QlVBYkZRbHR0MWVqUWR1UUxKd0g1clRnMkhhUGNKNllEQnBvWVNrd2VTdG1T?=
 =?utf-8?B?RWx6YWJaZVQyeER5eGZsclNLTFVQYW0rdmt3c2VTb01UemtRVDNzRk1JRk0y?=
 =?utf-8?B?eCt6bHdhNHBDc0NLa0FTK05PeGJLTUhyTmlieFpkMFo4QnYvZHp3V0UwazBS?=
 =?utf-8?B?UXRlL05xb24yZ3pZQWR4V3V0Rm1MMUthRE4rbzNyM2lhbE9HV0J4dmVOWEFB?=
 =?utf-8?Q?tAxZNjicsJ9uX5gI=3D?=
X-Exchange-RoutingPolicyChecked: rOF0RdAwDLgeS7sHTQ4t/m+7WJdccvKFoCnJi5TZfOUvSUyvunZyXunJ8FZtetgU6bVquvMnhOF6CCI/91HD43RJonTq9xpcwkkTnkQJjsH5nMZeck6UAUFUzq5aA0KNj4anftueCYrc3Nw1lBkWd1VY8agZTFxX8JT1NuDP3Gyf9lW0c9jZS/Eto2/PoOqXMXhN13xY3myfp/6iuzetY5l36v6eEsrnxM66XMhWlKPQ/I+VwC9yojL0Evo85cya74YJgPMTxg6yhk8S2lWzja8yYidLW8pCubTEElY6hflJgoUTJqNnI5pBNLcTR2sxNBLuxDbMuoi3OT6g4pCpcA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f600a94-0655-478b-9198-08dec1c30de3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 22:54:23.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77+1QdQAy3YiBxN2fkKn8VPQzUDe0Dl0osDr0uv7/wZKhmcfR70UbihpoLu5ThdVnIP/f8Ednt1DfwlYCzPhF2hbtGRnTCs43JR9JAF7n9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8772
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-294960-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:workflows@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:mid,intel.com:from_mime,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 972DA63BADF

On 6/3/2026 1:12 PM, Johannes Berg wrote:
> On Wed, 2026-06-03 at 09:29 -0700, Jakub Kicinski wrote:
>>
>> +Additionally, netdev does not consider bugs to be ``net``-worthy
>> +if they fulfill **all** of the following criteria:
>> + - bug is in a hardware device driver;
>> + - bug is either a missing error handling or is part of the error handling flow;
> 
> Do you really want to be this specific?
> 

I agree, this does feel a little overly specific. Perhaps there is
better wording to clarify the intent such that it could cover your
example as well? Hmm.

> Take this fix for example that I mentioned the other day:
> https://patchwork.kernel.org/project/linux-wireless/patch/20260531145435.701703-1-runyu.xiao@seu.edu.cn/
> 
> It doesn't formally fall under that definition, but I think it should,
> it's a silly thing to send to stable etc.
> 
> This isn't even a USB device where you could reasonably argue that
> someone might plug in a random one and it could be programmed to look
> like the device in question and misbehave. Sure, you can build PCIe
> hardware too that can do that, technically, and there's technically
> external PCIe via Thunderbolt, but it's still far harder to actually do
> anything with.
> 
>> + - bug was discovered by a static analysis / AI tool;
> 
> I'm not (yet?) convinced that this bullet point is right.
> 
> It risks getting into an argument about how much the LLM did to discover
> it, or if the actual discovery was a manual process after the LLM
> pointed out issues, or whatever ...
> 
> Maybe more importantly, why should that even change the result?
> 
> It's true that today the reason to start spelling this out more clearly
> is AI related, but that's really because of (a) the scale, and (b) many
> of the people running the LLMs not being aware of (and frankly often not
> really caring about) the community norms. I'm not convinced that the
> "silliness" of a change should be measured by how it originated.
> 
Right. The point to me seems that "fixes" made purely to resolve tool
hits (static analysis, checkpatch, LLM, whatever) have lower value than
fixes which have a stronger motivation such as user reports.

I'm not sure I have a better wording, and perhaps you could remove this
bit entirely.

>> + - bug was triggered/observed only with kernel changes or fault injection.
> 
> Given this fourth bullet point, we'd still accept fixes for such driver
> problems that people actually run into, while excluding "theoretical"
> things that are discovered by "reading the code".
> 

Right. One could argue that some race conditions are difficult to
trigger because a window is very narrow, and fault injection could make
it much easier... But we could still accept such fixes as development
improvement rather than through the "net" tree, so I think this criteria
is good.

> johannes
> 


