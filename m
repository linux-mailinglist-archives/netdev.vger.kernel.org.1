Return-Path: <netdev+bounces-208729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C2B0CE84
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 02:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC083BD49F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 00:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30E87F9;
	Tue, 22 Jul 2025 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7q9f6eQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5480381E
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 00:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142603; cv=fail; b=Hyp+QG2ctCVsfgmzRjbgRd6E20dA5UYnWQq72j+f4tl0g6CAzAz0eA06Wm4ICFPp66Qwu25qINxHmbOakAO/ny35tRvvsxL1uHOa2XeXNY0iDywFuzka+Su64mM192eZSqkM6G68ay7718uH0EXfoCHkVR8WQ3EiQM8h/hvcqZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142603; c=relaxed/simple;
	bh=GsG8QqG2PXMvI8ITAlcf5vspoVLUpuP8kvmzugVq4QY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DfDkQ/HebB3RRusUjdHXjMvvNaNn3zdTVxFSBuiwrNnp+u6IVgA8GL3hwNbEjrRRu0t/tflYjMxJkOYYlFDbPvJCH/DdkvLdckbH2qyQ02tN7rX13vyhWza11ggyGDwZaLg4haC8skcYBCtGTtFw7IVzFZiSBRN8NzDyykGfUws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7q9f6eQ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753142602; x=1784678602;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=GsG8QqG2PXMvI8ITAlcf5vspoVLUpuP8kvmzugVq4QY=;
  b=W7q9f6eQQ0YzPwnt2jJY9Xk82JiCzrvShnZueIfF4Q854v8UwE9UKC7P
   FQAbPduhQL3Llofw2k+l13Tfd/gYsQanSaVnrlHai/9joV4sM7T1A5+MB
   nvIAjDmAhU0IQYxj2qesPIwXg3hkKSJFgYKbVsOE/gdYOKv2mh/NBzNEv
   0i3ygUpKUS5yoYZQ/vMXJOvUpzuSZAX0dv8FqLjudIzxJBz4uBTZmrEsT
   uJQ9VNF7h4va2XxIs1FY48RPsxVkSixJnJk5BlOW+HaqGiLLo7XM/oCSw
   SDMy9T0qWngbvOkDEAeW5+V92BqvsvYDJZGtA8KeGVrhqzRcS3IWsxlRS
   g==;
X-CSE-ConnectionGUID: EzcPTyXrTDqHEK/yhIzHCA==
X-CSE-MsgGUID: 2AE87QBlQ5mKuNmzeS1d/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55489072"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="55489072"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 17:03:22 -0700
X-CSE-ConnectionGUID: A9TGPH4DQXuPW9umtATykg==
X-CSE-MsgGUID: MzqErpA2SVCYnb5xUW8nzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="159533885"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 17:03:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 17:03:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 17:03:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 17:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UA2Kj56Kb4g6pmJph8OpFKmtgmkLzrjvt4TtW/PaBZb8BLa9dPxelrMbej5n1LAtAl3HuRvsURo7+Woc7jARThVlmDyikIPm/cYg9g4ZLNsWHn7M3r01Ae5VcTbpjwjYoSmvV2rEtcl9Fkt/Md+GfEdNLJFC7PEzqF/ZGBPUB716vuenFfMSssr82/kX6Pxg3hL71GimQUgkB4MWmScuduMvY3T11sik7FDpT5rCiBFMX7JbRpCKBP4r2bMtsNaSJ6wchdrRtqPg4ZeIzxH5pqpYSfOoF0E5ymRMioCSAdAtZOGqcSgAyFHr9E3Qdy3fDHiPDzL6MFXPb8hubon5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsG8QqG2PXMvI8ITAlcf5vspoVLUpuP8kvmzugVq4QY=;
 b=DrL7iAmmWuQ2g4MxhB/3/lfN0h1Xf13/6SpzAT0agPurL/6F6lq/rByMibxmCb8fTKclVPQCSpn58BK9YJLn2VNujNdTBpadUl/qAoJvtahoANJ7pdP4SCJW3NojlorzPv67QadEKzIRMtNlQJOjuqIEB2YiwEr1ZyTHS6wKn/Sou9ZVzzbjfDvdR8iau+/yqpLYkq2TuE4vSOjZCIZaXaznAv1+Bo/WPpH3Qg1s9LxDHO/Mpdj7HxU4LzRfbAsP/TO1NV91P+FIr+HlBysOeMFBXrqxPXQCA8XjT4HB/B4zUbijL/lzh4xXwzUAoBDqQEDpCOxqjSZTqsJYHqA/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Tue, 22 Jul 2025 00:02:35 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 00:02:35 +0000
Message-ID: <27eb44ae-b84c-46c1-9ebb-53a79a3d68a1@intel.com>
Date: Mon, 21 Jul 2025 17:02:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: wangxun: support to use adaptive RX
 coalescing
To: Jiawen Wu <jiawenwu@trustnetic.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20250721080103.30964-1-jiawenwu@trustnetic.com>
 <20250721080103.30964-4-jiawenwu@trustnetic.com>
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
In-Reply-To: <20250721080103.30964-4-jiawenwu@trustnetic.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------WUotvIwsMNEGkTR0oK7V6SKX"
X-ClientProxiedBy: MW4PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:303:8c::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 3999a7e2-c20d-4cb0-5c77-08ddc8b31050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3oyS1lRS3cxODhmeStTZUVtZVQ5Wm5vY3I3a3c4STdqYW40U3krd3V3b3Fl?=
 =?utf-8?B?MU5xSm0wRkJEVWY2ZS9tam9jZy9NQnVWRnVKUDZxa2ptdDNzZUNDMTc5YVJS?=
 =?utf-8?B?YUx4ODgxK0FaUTJvUG91eXJMZlhLNVhUUDZCRnM3L1ZWQ0h5QTE3MHdYL1dp?=
 =?utf-8?B?bHlEaUpwaE9YekRQUFNheFhuUkNUbHNXd1U2MEl2c1RzYzBIWktWUGtiSFpZ?=
 =?utf-8?B?UGFYRDZOdm9lUzREeTZ0RDcvTW96UW43S0VsY1NXU05qSnZFeDFWcHpTb0dl?=
 =?utf-8?B?VmNIT2NwMzQzMXRrUDJONjR6Y0I2SjlVcEpyL3BJUUFrb2RwQ3l0dDBNT0xn?=
 =?utf-8?B?eWhZZy9OVlZDSmtVTU5QZHFXMzhlNGRuSkpidGpiM0NlUG1NSTRIOU5pK012?=
 =?utf-8?B?aE9SYlRrSFJhN0NVSjlSMVhlUFVBWk5zemtZRjkraFhIeXpTczcyQnY4YytE?=
 =?utf-8?B?enJheFNEa21GZVdha3V4MitXeElzR1dlNDQ0cmhzd283eDV6b1BPeVhDT2Fo?=
 =?utf-8?B?QTBOQVNybExZczNqTVJIWWxsZHkvNXFENzhVL1hXSXBUZFBTZHlBS01ubHM3?=
 =?utf-8?B?akNnUGl5WDVLMWlrN1pUM2JuV3kwVG5YaGNQQmZIbDRBVnM3WlFKTmZkejhs?=
 =?utf-8?B?eCtaaWIvNTJIeXk4Q1FyaWcyc2VEQTNaT1NMdmhXTTVCd3JPYUtaZ3hwMVdn?=
 =?utf-8?B?enY2MStsUHVjV3BMeEVZQjlKeEM4R05mOFkrRnRpOTRPUlBrRFR5UTJpTTNr?=
 =?utf-8?B?WkZEMkUyQkJXS3o1WHB2c1Z4RGt3dVNvcFlVVXNCdEFiSGZPaUdnVmFKZzVn?=
 =?utf-8?B?VXJqYVl0aklUNldESEtYV0pMekNaYThuenNJREZkUzU2dzVaaEQxRDlvT2dq?=
 =?utf-8?B?YUEwc2wzUXdTaHFHNThXQU9yU1QzNW1EYndpUXR0bU5OSXAybFQwaWZYZUsy?=
 =?utf-8?B?dGV4MGx2SFlpeHpFaERyc3JUaVMvU0d0K0UxTkIrMm40Y25DMDRiUVIrSlNy?=
 =?utf-8?B?VnZJY0ZqZzdqd1ZvVmI3cGxvajFkM2twaGQrVjB0Tm15eFNZK2VscW9HRFlD?=
 =?utf-8?B?NGVIMCtRUlFuN0JHbkl6UytoZHRYMHQySUUvRk1xQTVuWURxMUtCMnNHVG1T?=
 =?utf-8?B?bER3bmRFTE1Zdk1qelRuVkM5aDVVYUl3T29uS2Q4VE9uR2t2clVpalBkaTZv?=
 =?utf-8?B?ckZTUVcvVEp3dnBFSTNpT3ZXV21oS0RiRWpkbjE2cXpmTGNrdU15elRYRWJz?=
 =?utf-8?B?Y01qSXhOS3N5Y3BDM2crUGtOSUN4djM5NlpYRkVseE5NcTBDd0dFVDhsTUJl?=
 =?utf-8?B?VDgvVERSQjlKQytqUzdXYTRqSmdYV3lUeHVPWW1XRldYMTlhUVJWVGU3dWdO?=
 =?utf-8?B?SFR1Z295MUVRbmU0OVVUTWRiVEgyanRaNjRjVldaVDRmWVNYSnpSRHQ1OWJi?=
 =?utf-8?B?N1V1VnVWdlNVVHBTYVBadCtJM2lkRGVJclpmMHpjYVpLT28yYnQremx5Ti84?=
 =?utf-8?B?bUhoOTU4b1ozV3hDd2V4SzlGeGtZQlYveUZSSVF0L2RhSTZvamFDcEF5UXR6?=
 =?utf-8?B?MG9SdzV5bTV4UlZOOENUTGdBU1JCUnRLL1U2bFlmQ1IxM09aZUlYZFhoK0hv?=
 =?utf-8?B?SDlkSW40dUtSVnVRUjhmUEdSakxLWDN4QjhRVDUybk1HZlJNY0FKeUpNeFhL?=
 =?utf-8?B?ZTBjUDZHTnl4QnVxNUEyQWRqZGNqMTZTVVlkaFVGdUZzYXZyVGRkWjZOVTNx?=
 =?utf-8?B?UnpiM3VTUk5Mb1pNeFlXWlJoVXhXdDBnRytrWEtJM1VKdk54QUhiQ1lmMUN2?=
 =?utf-8?B?bi8yckRWY1J1ay9mREJPaUoyR3BTcWU5U1RTckwvQTRBMEY5TEZVTWc3c3px?=
 =?utf-8?B?ZEp5Sm1IZGtOYUpDZ1Q5ekU4TVN1ZUdSSVN1YmVOUThmV3JhaXBCK1NDZDBB?=
 =?utf-8?Q?AEAHpGBKOvM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUM4RjNORUhWZVZGbGUwYnhpWjFmamdvR3NmbGsvRlplWmRkbjV2bTdOR1Zl?=
 =?utf-8?B?NzNNbU5QMEc0VDNWYmF4bFZtUzlQR0pQcjRLc1pwMmgvMmlLdVVjbEl5SkdH?=
 =?utf-8?B?WS9JNW5KN00vcHN1dWFaZFhlRXQwNE4ramc3dEJncTNOcnBpT20rUnpYTm95?=
 =?utf-8?B?VkpwbDVLeStnZmluL2hGMUsxZ3hHSE1rUnhkdVlmMDdrRjZwRWdRRFJQa3Vu?=
 =?utf-8?B?VENZblF4RGRnUWQ0WTZ0UUxDRWFna1hlaGFlWHFaM1RnZDlLeXJjR2lxZHFF?=
 =?utf-8?B?MWtDUE1TazBWQU8rMlJXVWdPOHpyVUlGcEtrYkVWdVJ4Tm1DSVp2NkdselFM?=
 =?utf-8?B?ZnJxWDM5YWNwYW9uZzY0VHdxQXJCRFVXaDI3Qm1idWlvc0VMZ2pTWjdUNGE3?=
 =?utf-8?B?Q2dqSmJxTEwydUxVOU1aUkRDV2NmZCtodzR1dXdWeWJmNHZSajVjcUhuYWNC?=
 =?utf-8?B?YjFTaWk1dytCdjRTcDMxdnVvSEd0UHQ1TVRpcHdObXBvL21lT0dURFRsdkdN?=
 =?utf-8?B?QlRFdFI1dHhUbFc5WDF2Wmdjb2FsbWVYVUhnblR2UWk1SzJCS0tCeWNPVjRU?=
 =?utf-8?B?VHgwQytlOUtNYUpWMDFyWWxpZUVFVWJIWlVoWEpvMWJCRUhLeXM1QVU4dFFs?=
 =?utf-8?B?emw4c1ZTRUxsZDQwSGxwanJuTnhQYTZBVXQ3ejhpUUxaY2E4L09McmJTSVBh?=
 =?utf-8?B?OHF0YWpEVlZ0MTRadEQzSG8wOWNxYW1FWW5FbkxkNjBhT1Z0MW1QWVRmZTdG?=
 =?utf-8?B?eEJrZTRtYXFGQ0svU1RXQVJ6V1pDeG5wNFhKejdYY2N0VTc4VzVrMUhCYmRG?=
 =?utf-8?B?aTVvZmt0M3o3aGg2SjE2U0lJQWdoL0c5RCtZTWpkZGNJdS9QUVdDb2RjYjFj?=
 =?utf-8?B?NnRYaURZOFI0TzdiVnl4N3NpWTduR0xkSDYwQlFBZkF3K09yQStxbWRtQ0Q4?=
 =?utf-8?B?b1Flemg1RjNwMnIyMW1kbWxwRFEwTGJYcjZNNnJyZ2lKTlg3OHF0bFZVV29F?=
 =?utf-8?B?bllBc2RyWTQwaVEyaGlHU3ovQU5qazNrUGdETVZ6aG43M0VGNGp0Z0lBelBN?=
 =?utf-8?B?MktsTVVQYmFvb0h3OGhTSXRERGpKVStuaHhXcjR5azNWQzNPdDRtTXNaNTgz?=
 =?utf-8?B?eEtLblRIR2tPVUtkM2JZczhsODhraUgzMXhKU3VRdGRyelhaM2JwWEtiSURU?=
 =?utf-8?B?ZjJlTzNTUFk3b0dHYUdSTWRLVGd1WnF2bWhYZlFRRXU5K1I5SGFMK1RSV0k3?=
 =?utf-8?B?YmRQU0w5bVZCamowbDhPd3hBSEtYejMyekpSdFRZY2VuN2pFTzVrNVk1WGZE?=
 =?utf-8?B?bWthK2hweVFBSDRBYkpUTkpkczRNQUNVWjZHZUd4enBQbERGVmh6MXExS1FF?=
 =?utf-8?B?MkZtMHgwbUZXTzRMdmtxYzJ0Q09UeWFXNmw3RjdOTTBSRlJDT1Iya00xRWY1?=
 =?utf-8?B?em5IejMrNWtlbGJPQW5BdjhPRnZOYkIxWDVTR0dnaGw4SWtIK2tONVhDVmYz?=
 =?utf-8?B?eVpBc1pjbkJaWEtLVkdsY0Jxd0JZNmJFVnJkamdMM1ZiazlFNGJWOW50ZmZp?=
 =?utf-8?B?WFVVU2l6d0pTWW9GQmlHVlV6eVM5MUdLYkNNYlZQd294bUxvdmlnUFJ2eWRy?=
 =?utf-8?B?b1dCNHV4ODk5RG9ZSmIrdTl2R2V6YXBxb0tITjFQell6NzUzcWtWTW5NOS9J?=
 =?utf-8?B?WXc4OGY3OG5OMnM5UmN1V0xVTmJPTXpnanNtS2EvZzFwdzBMMGlNaUphMWYr?=
 =?utf-8?B?OVlrM2VqNi80UDVhQ2IxaER1MTVMbVdEdzF2QzltZ1h2b1hTa3lPZTFKZkp3?=
 =?utf-8?B?ZnZNZDB1aEs0QVphbnhIeTk5K05Da0x2bmtNYTlZUVlFSDExZC9Mc1hUTmth?=
 =?utf-8?B?cFAybnRPZkUvNGwwYjlWT0dnTGorTGhoVDIrK29jaU5ram9DTXdwaFcvLzha?=
 =?utf-8?B?YzNiZy85QmRXc2tsMEVRRXo3cG9nTVozYzBnL1hUT2NLWW81QTVFYnlrY0ph?=
 =?utf-8?B?TlZnTHpzQ2dYUHJSZ0xBVHJOaGkrMXd6b1FoSUh2cGc4Y1ZUZVJ1SStmYTE1?=
 =?utf-8?B?TXhnUXBBZ01LR05DclhZMHhFUmF4OWtZZ1JLWStzVzJLUGRvUFNjcVRHTmVk?=
 =?utf-8?B?Z1ptT3dBUDFWK0s2MUJwUVE1clptdnNmS0NtaWRXcGtBNm04VWx6RzlXSjVV?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3999a7e2-c20d-4cb0-5c77-08ddc8b31050
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 00:02:35.6004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pYBYBOxDiks9NVaUsB2ZaFzLDTmvV+M2Th5cKxTj3now2+KncBex2WHJ+t2UbbPE9Os8ttj9yFDhneF6Ma12nnKiMhiOOBuU9CmGcBYDDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
X-OriginatorOrg: intel.com

--------------WUotvIwsMNEGkTR0oK7V6SKX
Content-Type: multipart/mixed; boundary="------------EdV8IKgkUGFBCzDmcW7w96DL";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Message-ID: <27eb44ae-b84c-46c1-9ebb-53a79a3d68a1@intel.com>
Subject: Re: [PATCH net-next v2 3/3] net: wangxun: support to use adaptive RX
 coalescing
References: <20250721080103.30964-1-jiawenwu@trustnetic.com>
 <20250721080103.30964-4-jiawenwu@trustnetic.com>
In-Reply-To: <20250721080103.30964-4-jiawenwu@trustnetic.com>

--------------EdV8IKgkUGFBCzDmcW7w96DL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/21/2025 1:01 AM, Jiawen Wu wrote:
> Support to turn on/off adaptive RX coalesce. When adaptive RX coalesce
> is on, update the dynamic ITR value based on statistics.
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---

I haven't yet reviewed the adaptive algorithm in this patch... However,
have you considered using the Net DIM library (dimblib)?

https://docs.kernel.org/networking/net_dim.html

--------------EdV8IKgkUGFBCzDmcW7w96DL--

--------------WUotvIwsMNEGkTR0oK7V6SKX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaH7VGgUDAAAAAAAKCRBqll0+bw8o6Paj
AQDIdFbNbGHgnE2bsxJ8SH4jfg0nzEbk9faAjm8+oo0zugD/UhRexzNkKe9VhSdKCYRGkeJOZZOX
fsZQzJx2LJS/bQs=
=UqWF
-----END PGP SIGNATURE-----

--------------WUotvIwsMNEGkTR0oK7V6SKX--

