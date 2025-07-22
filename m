Return-Path: <netdev+bounces-209133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F650B0E6E8
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7FE1712CE
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 23:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AB828153A;
	Tue, 22 Jul 2025 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KW2Hr62f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8FF1B808
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225634; cv=fail; b=E01caKvdyQfFfHYLQ9EOHwqjFbznCzspsIZeKLV0ln9eqNLoaXdKDOF2tvQWcQqGQgG/c0Rn1e8d4QqTnmsZQmJpfsYH2U+nFUvSWSat6Hc30/3yQJXXW/7zAxnuROwS20JkGgNeEcK0geWJpXnn6eYYF1ZQ50q8aNzX0JgHCZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225634; c=relaxed/simple;
	bh=BVgehvAjw0VKg+epklHZ2HxQMwNwoWGLOszm0H9RXxQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K0xBUPyRU1op0sFknhBlnatiRLupRXkf2UieHvhUQAcp6AQcnxYkktYTfelP/R2A6VX//dOoR51xaW4LIAtRs5a5vxPSWOGe1ccblcS4pPi0tlbIFV7s8Tjdp57dSKlp5q7Ry7y+IL6oKBaa0HO64uQM9JMkwt067eyNb6P9EOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KW2Hr62f; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753225633; x=1784761633;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=BVgehvAjw0VKg+epklHZ2HxQMwNwoWGLOszm0H9RXxQ=;
  b=KW2Hr62f5GlR1YQt/LOy9A6Rajm9wMFJ48i2DBMgaguxqxGGjm8LuMMa
   n60BJbGDFQdvc+hWAJb0xbaUuBSbzbPdydApsXMG8v2MSzTgw2l+Qc0hs
   N82n6OAg+F7jKTWFG9n+Wc37sM+RAU8hdV9gudOYmnXJ+dlMp4Zs5K2xW
   wqsZJ9qvGXmLiSewsSTUTd+Tc1nPwnA4AKHBSkm0budBlS2lxLXavFIEQ
   w23J5iF4ZPJVALPAvj/+wMKlOav0lb8l5abXVj2StZtRxcAqtTB0dEvCD
   PLWPdScfLVIfbWXGyIe1CkthBSRv51y2OcE/8j4tQPglbTjmWDnGvhIkq
   A==;
X-CSE-ConnectionGUID: hWIjXG3bRFSwRwU5YlwjsQ==
X-CSE-MsgGUID: vZ+ugj3sSbmSwpOcr8iISA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="66179750"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="asc'?scan'208";a="66179750"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 16:07:12 -0700
X-CSE-ConnectionGUID: nhQK+xsURjOwC/3gP19d9Q==
X-CSE-MsgGUID: 54R21ds9Sq+weTVDHN8/5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="asc'?scan'208";a="158568033"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 16:07:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 16:07:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 16:07:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 16:07:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qs/1s1rFhsJ1hUTZi+5gJrVsWgEfQlUMLmoVj5Xlh/0afObMMiu8N29SI3A/udl4ZpAPH5y9rlAdVpR5MLWPEtICMCrf0b72OFEzRAkpU85XlhSM7c5JCuY0iQCeTax7CvPsow/wxljg1RDgifbbpFjhr2nyaG0VNsXOGdd4pk7P97b9wgYGf8HandrgdODJCjcPuDU2finbIqeNimzq+lH9CTxCbk7vOq3+ajEQwDk7QCQkzI2coeloh3i0XJTNoYEA3q7ekXlfGIGUmSQMiHVXvchMpFNgRmGkzxZpzyoC+i1FQ2HSCiCkPW5A9Gvqe+8PSFL5/m4acXS1maf3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zT5fX3dcEcNfi+B175T81qTpzbbhbEpsoSuMS99PS8w=;
 b=MlHyEDoKCQcWEw6rAde4CAqtG3D8ER0WHObd9xQOUQqT6SwqKVMbjVEoax+AztiP+G+R5gx9igmSL9HUBwciisPklGai4u6kt35yiS/c+rhbVPNpTIfqom57ma1GOqQI60imHn674AvFzqWZSFQmMCOSqDOdQMPKEarFa0F0l6/R2LRdqn2RwQbH9w1Yd06Y9urC02JBi5m6roZBkR+1ItKVARm6ydbCjbZnKdX6Tk61ofCNxiA5KflnPGkX5gceatVCTYJkOK5OdHCfwexrtbxSrnQdkGWnKuylDj3rkS+FKd7J9gAj8PDkvJKURis+8RtF3bw4dzsPmfo0hmKg+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB6482.namprd11.prod.outlook.com (2603:10b6:208:3bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 23:07:09 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 23:07:09 +0000
Message-ID: <4c9d9e0e-139f-40e1-9934-ae9bb5b43f58@intel.com>
Date: Tue, 22 Jul 2025 16:07:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: wangxun: support to use adaptive RX
 coalescing
To: Jakub Kicinski <kuba@kernel.org>
CC: Jiawen Wu <jiawenwu@trustnetic.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20250721080103.30964-1-jiawenwu@trustnetic.com>
 <20250721080103.30964-4-jiawenwu@trustnetic.com>
 <27eb44ae-b84c-46c1-9ebb-53a79a3d68a1@intel.com>
 <20250722160002.2b5ca56d@kernel.org>
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
In-Reply-To: <20250722160002.2b5ca56d@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------HZ0xJG0589F9W9lH7ZjWgL0b"
X-ClientProxiedBy: MW4PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:303:b7::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL3PR11MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: ed77306c-6d50-4788-209a-08ddc9747b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emhCMTRpQnlySXl5Nk9nZ3dFR2R0YjQ4VHJSK3g4TEV3U3daZzY4VHcrc2NU?=
 =?utf-8?B?bzJjUk5rQytPR2k4ekdwaFNJL1lSMjhBeHArZy8xRXRVOURBZ01EYjFsakVW?=
 =?utf-8?B?MnRSMWJNK0FsM3VSL3BMS2Y2S0VOdTJmb2tBNUtVZHRDTmQwTVN4N2NRSG9y?=
 =?utf-8?B?RHVBVnFGQ0hEOWtzVFRiNHVCQnA3RGFpVUVGS09jZVVqUmM5Sm5XR010SDFi?=
 =?utf-8?B?Yjc3QkZxSGV4V0JjbjQ2MTFwUXh2MlZMOTdyZjFWYyt0Q3NHZG91TklnNFg5?=
 =?utf-8?B?U2lIcHdteFQ5RHdaWWhubit4dWhwVDVUV1R3aUdBR05WWGNoVHdLWE1vZHZq?=
 =?utf-8?B?dk03Ky85eE04YXh2TG0rcGlQVE9mTThxcXlzK3hiQ0d1a2VrTVNuckp0ZU1B?=
 =?utf-8?B?clJsT1kvVU5sQWo2UjgvRmRXMmxSbGFuUG4rVEY0UHMvc254WFVXQVZEaU8w?=
 =?utf-8?B?d05SUndFdDVuU1NFVkkrVXVnSjR1S1R2OEVrcWJONUhOK2I0SWxEelhqRzdy?=
 =?utf-8?B?a3BMak82aUdUTjhxdmpJWkNRUE9qZi9VS3ZlZlkzdk9VbWN1WEI3Tk5FUHR2?=
 =?utf-8?B?RmdOWFlIQVdJMVhMaUg0ajRScGFTaVY2VmVudnM1K3VEaUs4M2toYTBDZVg2?=
 =?utf-8?B?MC9yTjhXSUxXUTRMUStvOVhOL0JCTVNSYndpQXpUaS9vNUlGRFJTMXBwYUVE?=
 =?utf-8?B?bEl2dU1ZMmRDMUhFWHpKbU9nd01hSmsyQ0czRFFjL1F3RVlMTGx6TzRMS1Y3?=
 =?utf-8?B?VjF5d2YwQVlxK01rbmFkS3RJaHM4SmxnWVdUTmlUWWFMRHJzRlBheGNZYUdz?=
 =?utf-8?B?MkRoajZHbWpkNnBqTmVza05FbWZpajVzcHNSYmlNTTlDMHJuRlA5Z2tHWWlL?=
 =?utf-8?B?UEx5VjlnMk5JMkg0aXhhR0djb1JYeTNDaW8vVEwrNUJXTVVPbkRnU0ROSlpR?=
 =?utf-8?B?MTJFZFBDM0ozcHgwSkxPYklmSDYxWm4yL0ZtZ25XUGxJU0dkcGoyTDNnY2VL?=
 =?utf-8?B?QnVlWFZyUHBtUUFSZ2RveGVyR2NmWjdjMzE0dFdTVCtCeWFWdk1PT3dNQ2RX?=
 =?utf-8?B?TjhFMS9aN2tES3pPWE9pUDFJbjZvSnF1bmoxT0V4K3ZWU3pHcFZNN2ludkUr?=
 =?utf-8?B?S2J4Y01Sc3JEaWhuYjhqcjlkTzRsWlRLcGNGQ3p6RVVpUkFIWG5UdjB6MXlj?=
 =?utf-8?B?U2s4MmQwbkhQZUl2bHZiV2JSaytKWDloMjI2czdMaEdhZ2FXNzQ3V0pRckpW?=
 =?utf-8?B?NzEyQWVSRDV6SDN2MkdXS0d0WjRHREMrKzM4bXhDRUswM3FpSXR0Z1BlSit3?=
 =?utf-8?B?cit4V21WK2NpRmpCQVEyK1F2TFQ0OUNaNzFQTHpGdWFCaXlBak1XNTkzV0Np?=
 =?utf-8?B?bURoMDBTdVE1ZllxVzhMUkRnWDNsSC9xM0hLM0Njd091NTYveDZIaDg4aEJn?=
 =?utf-8?B?U0xWTllqcGpBNENZMGdKTFhVMWxiQk01MFJaQ0M1dHUrRXNpUWZBRVlOUEVm?=
 =?utf-8?B?VVQ5OUQ4ZmFSdnFBZGdDYmMzQ1hFVkNEY0hWRG9VY3FRdFVkWHZySHdaNHNG?=
 =?utf-8?B?Wi9LRGpFT2RUNEhneVMwZTcvTTZuMTZJQmRoWHJTdWIrazl0VGdJM2p1OVor?=
 =?utf-8?B?WjUrV3NMV0xLTU9tWnRQZ2NGSVcwWEt5YXJrSktyMld0ZkNlVk1XaDNuZHIv?=
 =?utf-8?B?c0k0dWZ3elNDUmtGZWZYZzlMVzFVdWEzY2JwbkRDbElTZm0xY2luNnd5dzMy?=
 =?utf-8?B?TXFnZExaajU1bFlmemg2YzVqazhEY3N1K3RVTkkwSEtYMVFsMEZHazJLTStl?=
 =?utf-8?B?YTkyYjRjbzV1OWgvRWlrMUhLM3NIQVZsMkgyNklCeHlNMS9SVVpSdklLMjJu?=
 =?utf-8?B?aWJFYUNzbUdpSlFmaTluY05mZFNmTnhyNjZpQzI5V3RBL09iUHlnd1MrVG1T?=
 =?utf-8?Q?7orlRinhGwk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDlaNFQ1NkgrRmV0VWlLSVM4ZVVZY1c1eU9KVHljSVZrZzdPOWFDNG1aNDMv?=
 =?utf-8?B?T2c5eFUwU0ZxY0IrZDArWXdXZVdZL09mUVIrUHdsK2RCaitoUytQZWg4eGc1?=
 =?utf-8?B?MTNsSnZIUlc3WjA4NHpLVExZVGFpSTB6b1hJK3VWb1hWSWdhNjA3L0ZBdGV1?=
 =?utf-8?B?U3BUNXdPNWp2c2xLQzh5WHEvSkdMKzE1ZUlCbGw3aVdwV2FCbW1XN3l0UWhZ?=
 =?utf-8?B?V1ZYSFo5RUxZcC9KcDIra3Y1TTJwUXd0OWxMaGd1Ukkvc3hIb24vcnpPSU9C?=
 =?utf-8?B?dE9QTFNQQmlTdjk3SUo5MU8zNVVmTWJLcUlteW1IQ21lZlA4clVwL0RiaWJC?=
 =?utf-8?B?Yk00cWZ2dUFhTWhpOTZRRzlLUGdmUTVvR2psVUVGbnJTRWlqL0Y0RlNPbC9y?=
 =?utf-8?B?b3hWNmkwQ1ZFVDhUUHdzNXhibmd4QTZ3eWRkVlNzVHdiYmFEci9WZ2l2S0ZI?=
 =?utf-8?B?TGJ2aDJWWVEzMW9FVXhnU2VwTFhDLzJhWGoyR2hVZnpMakVHMGxXV2FJTUJ0?=
 =?utf-8?B?TTV5bkU5eFNmRzhtS0lZZzEwTFR2d0VNWmNTeExQMFdEbmZtOS9SR3J6ZTk0?=
 =?utf-8?B?cnlGUzB3VXlJOUpBV282SURoMXVCNFg5bTNXZU5mZnJ3VEVzdmRWaGlTd1Bh?=
 =?utf-8?B?NndEVTJvVTE1TU1RcE9Xbm5ENjNPcUxRQkxNL2J0c1ZrbXpmRUNWakREdUZx?=
 =?utf-8?B?UllJV0plc0NNdndKRWc2SGU4RGwxQ2FIVGJlSTVpSFdjS0R3ZFJnQUtqdzdP?=
 =?utf-8?B?aTZrUWFieXpLKy9RbFNNQzdaWHRZU1J4Nkh6b05aWXVaUExlQnFteGFxNkNH?=
 =?utf-8?B?OGRaWFZQNUFtd3lCR1ZKSHRIZWZUSGJDN1hqSWJNREpQNnNvTDhCV28rVG1X?=
 =?utf-8?B?OGRwVjY5ajRiNHJTMEtMYXVVaitUcTF4N1V2OXZmVzZROHhXWkcvcjVzcjlr?=
 =?utf-8?B?UnFLaE00T29pQitWdDZKYnF4UXgxV2ZSZFhncmZ0STlPQ0RoZTVNa3l0cWJp?=
 =?utf-8?B?bGVtMkNncHdza1ZrTlphaWdmbUZSSUF2MnQrL21yYnVjYk9pMmtIbWJURVNZ?=
 =?utf-8?B?NzZKK2hmbU9UR0hYL21yWFRXZXN2UWo0YzlLQ0VESGJJekdyYis2SjFjdVlu?=
 =?utf-8?B?d2JnN3g3VTM4cDJURXU3YjRWK2htT2UvVy92UWNvMWtKRko1SGpNU05zWGJP?=
 =?utf-8?B?d0xSamJRMTVmV3Nwa1Z4eDdMYjBFYnVIUmtvNyt0cHY0bXZQODhla0xQVVRl?=
 =?utf-8?B?bFVEYjlqcEpxaEtxRDI3QXV6Nk9QdWhRR0s3Rm44R2VWblVkUjk2Tk9FQXpJ?=
 =?utf-8?B?dHliYW5sWUx6UHIwL0J5cVNtbHdxRitRbXdQVTdGSVJmZ1E0MkxwaGdvZWFM?=
 =?utf-8?B?eWRtd21HYXhJcXRXVzZHbjZqa3NnVDk1bGM4dVFrT2Z3RnJvZnRPQXBFcEpy?=
 =?utf-8?B?ekkwaENZN2gzT1NXNm5yb2JCcDVnQ21XR0txSGg1YmxySWFmazR2Z09HTld4?=
 =?utf-8?B?V25Idm0ydC9kRk91T3hnNThMZDRvSUNHL2JFS1JveVZlenZaelpsY3dIN2RK?=
 =?utf-8?B?THFhVUhnSjZiSUxQK2h6ZHBjeDVoWXhicncra0JsdWd0TFlRVWVQN0lhT0pj?=
 =?utf-8?B?VnFOY1dheEdpQ1cwdmh6cDZuY2MvbC9ybUZmY1BPK3lXMm9ZU3hkSWRsS1Fo?=
 =?utf-8?B?TW5qQlhGMmVTeVZ4KzlZTFB3aGRXSC9oWStlZE9QNDdnamlJUjBsU204aDZ2?=
 =?utf-8?B?cEVQOWthTFQvbEpqMitkcTVBZml4ek5QQjdDTDlhNjdIcys2cSsvdkxlejMv?=
 =?utf-8?B?SWpvM2lTQzlZYUNxUjhGdkFPbFRxVFFFMUdLa3lDTU9tUkR3RUdjKzVxY21K?=
 =?utf-8?B?Z2thcnF6RDlrY2l4VjBvRGlPMVJIejByNnc4TnVOMlIyT2RYNFhZSzJETlE3?=
 =?utf-8?B?emJLNFUwODdlQnVkcFdCZElIUmxVQlJTM2hRaVBRamhDazBSdE93ZWh5VEhw?=
 =?utf-8?B?QnpVVXEwVUorTEdIY3NnNG0yVk9ib0hHQS81RnkvbmNDVGFEOHJrSm91S1p6?=
 =?utf-8?B?bDZKV3k3akNlamtrT1RWOWVYM2dmQkE5ZHpER2lBKzJiaVpKYmlKa3oxZHZU?=
 =?utf-8?B?cmlXWitlTXg5UjNFeXVJTXFtRVh3eDVDWERieEU1Nit0Vjl1VzFwNFpjd1l1?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed77306c-6d50-4788-209a-08ddc9747b8b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 23:07:09.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ehfWEkJc5R+r21OhfJhFJ8HpbO9j6hNdvTbljujteW0sxJiHYpbNnSYak5KeQbSS/XZPJragaKfslLT6/b+5cWpl1a9/hKQcdJ2ihq2ggw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6482
X-OriginatorOrg: intel.com

--------------HZ0xJG0589F9W9lH7ZjWgL0b
Content-Type: multipart/mixed; boundary="------------Mx309HweCNYGgvWS0uXBY2Z4";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Mengyuan Lou <mengyuanlou@net-swift.com>
Message-ID: <4c9d9e0e-139f-40e1-9934-ae9bb5b43f58@intel.com>
Subject: Re: [PATCH net-next v2 3/3] net: wangxun: support to use adaptive RX
 coalescing
References: <20250721080103.30964-1-jiawenwu@trustnetic.com>
 <20250721080103.30964-4-jiawenwu@trustnetic.com>
 <27eb44ae-b84c-46c1-9ebb-53a79a3d68a1@intel.com>
 <20250722160002.2b5ca56d@kernel.org>
In-Reply-To: <20250722160002.2b5ca56d@kernel.org>

--------------Mx309HweCNYGgvWS0uXBY2Z4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/22/2025 4:00 PM, Jakub Kicinski wrote:
> On Mon, 21 Jul 2025 17:02:34 -0700 Jacob Keller wrote:
>> I haven't yet reviewed the adaptive algorithm in this patch..
>=20
> I presume you are already familiar with it, as it appears to be
> a pretty close copy of the code from Intel drivers, yet again :)
>=20
> Agreed on the DIM suggestion.

In that case, even more reason to suggest DIM, since it was a pretty
solid replacement for us in the ice driver. I meant to get around to
adapting the other Intel drivers to it, but I have been busy.

Even if the existing DIM profiles aren't  great, it should be easy to
create new profiles that match whatever this device needs too.

Thanks,
Jake

--------------Mx309HweCNYGgvWS0uXBY2Z4--

--------------HZ0xJG0589F9W9lH7ZjWgL0b
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaIAZmgUDAAAAAAAKCRBqll0+bw8o6EcN
AQCB7URFL2MdzRQwcDF/pyVRaRyCKUu6nPvrETyL86KbpgD+LQKATg1KF4c8xdKcdkzwYGim8rQ0
0mgfV19wHda9eg0=
=P+iL
-----END PGP SIGNATURE-----

--------------HZ0xJG0589F9W9lH7ZjWgL0b--

