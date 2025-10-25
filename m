Return-Path: <netdev+bounces-232734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88519C08743
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 02:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7B13A80B9
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 00:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065141A0BD6;
	Sat, 25 Oct 2025 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9lVwo1U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474374A1E
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761352587; cv=fail; b=UPMEZbnf/1GkHGinVmvc/fs25fiK7HhQRJwRc+/RMNS6WCHG9uIgDB0FeIM/UlvKYNuAusMBy8ZBRaiztCxCh9xoh9TjMXjFXw/TD9niheXEq4SwQjNozVB8gl72/NoVvkRc7ZD3acbUN6jSy+eW+nge9R7UQV3sBTHtO/5vSYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761352587; c=relaxed/simple;
	bh=oAmmapfLQpsFi1cedD89O0eZrKMmIfMPxT13oP1ipKQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=USwhszCjlrBlVRnzqHpfv+Ns4kJuGC+7DgEqHULs4PuRQnvwID6qKAsyfgr/plmb36EVwtwyUH3E66rS/UZeHFCC+oXCWpulFXEeXTGiWz22y/0HenskXOUOQOIwFNM4hgn305gS/6nLCwNziM8tKzo6GsblmOov0DiKcuz1oGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9lVwo1U; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761352586; x=1792888586;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=oAmmapfLQpsFi1cedD89O0eZrKMmIfMPxT13oP1ipKQ=;
  b=f9lVwo1UqNgpUEuDmFZ03CVmj9AZtyTq5aqcs6oO74d7baeLgkBMz67J
   7XHntjAAIIeyu2Op6GkHMECnY255A16vjmx6M+tkcFKs1EBKpy/nZLtTc
   gGten4Sm3SbwxuZfl2q6kyUnE5Lp7XPteWhVimLwZe1a9Umuhk5Ppst3j
   W2c7vwgwRui1/IBod9wEreT7ZB30+Asc8vRS5LIVkAN8wqe8g0Y53Cu72
   OsYE85IE2Eisk0PLWf7a7G4qfwTEjDu/BJDUgaGLN8imX+woClEMgHmNJ
   uHgJWHHclCgL3teUMNW8NOt2Lrha+UiaKTthAthQnmYdRhl6UyQcY+pxa
   A==;
X-CSE-ConnectionGUID: PngTAd4SROKIFqCNv9hENQ==
X-CSE-MsgGUID: FyUmxrYfR1aVcNbcNSPi+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="51110682"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="asc'?scan'208";a="51110682"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 17:36:26 -0700
X-CSE-ConnectionGUID: 3DVR8PGWTPiJcZZJsoQkrQ==
X-CSE-MsgGUID: pMVEoH2VQ5OrfFc9dpe7Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="asc'?scan'208";a="215210244"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 17:36:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 17:36:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 17:36:25 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 17:36:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8EcR9dCdiJtMP9xwbCzYqFr3AmVlwqSjDizNLoU1rPcRHwc6BV9vxDa1l5MMVALdvYfHFoKj8BDZ+lAj2armycVWCXeTewYke+uFCW615xIlKJqv5p2aJz1Vu+MjkiESAquxup19ND8177OVSBwoSDxCExxH0JX8d59o3MHsbXUQwkRLOM2lCM5cHUBiul9K8U7GgCn/vQjrNevMQO9W1D/DkklCoui9PQ1IJcwbkdaZvRcFEtjKozCziR74S6ZB6iIHubgYlT7P8euQYGQvgPo3BRkw1dRw40Rfoahv8430EBp3NkO3iyMELI8VyAJuq/zKSaLiliWKk/ykTj0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAmmapfLQpsFi1cedD89O0eZrKMmIfMPxT13oP1ipKQ=;
 b=joK6xk8e2NeVjRcrNJJumiwfa5gF31nLoxDIetjeTL1RKu6B2Ps7a1J/EyCZDE8+CZlwuvu0mM8PtchA19QJr5lKjhYeSYvPWHeHhHUI39kDoirtiOt2bCPh1BdjViMBM1jCZdaASNw24LILVq+fG0N2E8UbMI40DcC37gm93fLJhI84KVpEP5HeJDzAFeiByfJqt9sW5nXQ9xFAnv6CIKUuyDVwPV6y98xCiOh2Vr4nskF4RDxZifgHJ+TVf3yOvRauwc23mREhsya3S8cxlqwkmKzSJA2S/meokjvB6qvqG8z23dLGmMYvWXEmvf5Jq5W1hJKqt2VGzOo7n4Yzsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB8328.namprd11.prod.outlook.com (2603:10b6:806:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sat, 25 Oct
 2025 00:36:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 00:36:22 +0000
Message-ID: <ddfb7415-008a-47a5-ac81-b88bb79b9353@intel.com>
Date: Fri, 24 Oct 2025 17:36:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: txgbe: support RX desc merge mode
To: Jiawen Wu <jiawenwu@trustnetic.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20251023014538.12644-1-jiawenwu@trustnetic.com>
 <20251023014538.12644-2-jiawenwu@trustnetic.com>
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
In-Reply-To: <20251023014538.12644-2-jiawenwu@trustnetic.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------OUNBn1rJmyCTUvArXSJdGy9j"
X-ClientProxiedBy: MW4PR04CA0177.namprd04.prod.outlook.com
 (2603:10b6:303:85::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c5db6b-9133-4115-7a71-08de135e856f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2Q2TU5ZLzJONXN5SS94VmFhZTdtVGhZRGRxVE1MeDlWTGZ5MWRsUlRPTVcy?=
 =?utf-8?B?MVVZZHArNE5YUllCN1F3OXdZM25BZG9YSEZyWFI5akJCUzY1T3ZmU1RPT2Vv?=
 =?utf-8?B?SWRXNXF2aitSVmdwRmR6ZlB6Zy9UOFVXOXZ2RGQ2YkU4ZEVoMUg2SUJ3dCtL?=
 =?utf-8?B?ZHFKU3RIZ2RBdWE4OUdtOVZ3OE93K2JLbXd6dFpNYk9wenE4V1RRbmFqRG00?=
 =?utf-8?B?Nyt5WkwwZFhXb2dzdkdMWXJ4Y2tjUlU5N3EvVGFKZ2NoUGpnaU8ydlpPREkv?=
 =?utf-8?B?WDRPUXNoQnp6T3Zhb0d5U0EwaW9uZmMzSWhKMzY3SURTR2hqQld5MGJLdlc0?=
 =?utf-8?B?V2Q0d0JPYzJtdWpsT0x6MFFhSndrdXROZGV1T2tyU3U2ZXFrWjZRUEJRRkc0?=
 =?utf-8?B?K3ZYMGV6NjNQYVpVWktzRVlQUkNLZVZBYWd0UkxWWDZGVkdlcHpzY01KVWlF?=
 =?utf-8?B?aXpwMU85OEhLbGNOTER6dEkrSlNXdnA2ekVBQ3JhQk1meWlIdm5Ma0ZCaHpF?=
 =?utf-8?B?NTlaZGJhdGY1WFZqbkFwVWpSY0xMQTVpVGpqcmcxOUczZ1RPZDJmdk5qL3hC?=
 =?utf-8?B?UnBKcnpFNUVhRlkwaTQ3ZUg2NHBGVW1mamF0a3BBQXluT21wcW5UTTBUOWt5?=
 =?utf-8?B?ZEprZ2x1S1k1aHl2UUhpZThxY0RRSU1sTCtZb0lWY0VwWUpJZTZhODBlajlr?=
 =?utf-8?B?NUF1TEF1QkdoMklLVkg1a3RWZnZZSEZETUtJZHhQKzRkajc3SjFhL3BCQVRC?=
 =?utf-8?B?djh6akd6T0NNTXhlVVlZZnZQYlNqajByK1RwQ2hUOEtwUi85VGhXa0J5VzF1?=
 =?utf-8?B?aGRoTXc1dEJUSFJMM1hqM3M3bGYyTTNZc3Q3aGR0eERPRGxmRXlQZEpIei9k?=
 =?utf-8?B?N1lkTm5JSXk5SUZkNUlMenFpQzhqRnhCTjNQenJOeVBVK1dQZXMvcmdGVnFF?=
 =?utf-8?B?cVNKM2pCU2h4OGdoTVVqZVlXTVc5WnN0aW9ZSHJXVFYzTGhSQy9jRExEZWNX?=
 =?utf-8?B?Umc1cEJMLzVkaVBzaU1hdmEwTit3NERtcXlsQmlrWW4yaXdjZkVMU1pWNDc1?=
 =?utf-8?B?SE9QWDgwdTd1U0RKTGxLcWs5RVVBR2ZDMnk5elV2NWl4MzY1YVFVaTdkVml5?=
 =?utf-8?B?d3I5cUEvbzEzUGZSZFcyOFJqV21kN1FvVFNnRzQ4aDl5VVM2S3lEeEx2V2V5?=
 =?utf-8?B?ckU4bE5mNERLbkl5bjgzQXhWMlNIeCtBc2xiU3JyaS9OVGZtMENTMUJpV2da?=
 =?utf-8?B?VWE1NE9DY1N5bTJ2Vm5NMStIRW1Zb2NoMjFpUGFYQUMzRG8wT2xMM1BxTVVI?=
 =?utf-8?B?NEZMNmJWaHQ0clM5Q3ZIV2tLTlM0OXpMdnhlWVVLa3lYS3daQ0VzVVZIaS9i?=
 =?utf-8?B?dkdiU0EzTGc4UEpseE9IUEx0eUhZZERHcTZtUWN1K0Y5V1MvRWJqdTAvanBK?=
 =?utf-8?B?VnpINjBuM0x3MGpncjBnVlBJcHFSOWVEZHpkQUhpd2RxdXplTzRoOXJCT3h0?=
 =?utf-8?B?ejAzend0OEgxRm91WmZXcUpzYjZPblpRSW8zUlFCZnphaTRXUVRqTURFdlM5?=
 =?utf-8?B?MURaakc2R2tDbTM0L3M0U2FxQ0dlYjQvYk9nNUVzTGhoem9KY0V1TnVFTFpa?=
 =?utf-8?B?QW83RThXNVpWSGl3QlcwZ3BZa0V6K2ZxWXc0cGxyVnYrd2hMVUpBUEF0bjdp?=
 =?utf-8?B?RStmT3ZVbEtSOXlyVVp2b0FzQWNHbFNXTzBBczJ6akg0UElleWM0Y2tGMW1s?=
 =?utf-8?B?ZlNmTE9nTG9Tb2twSnYzODdxSTRzbXN4OFB5NlNCYnJ1WnZuT2ZMUFJQUnM3?=
 =?utf-8?B?eW1uckZNRGRSWkpwcFdpSlAxNyt3SlFDbFM3R3JnelpwRzFhczBVdVdtejBz?=
 =?utf-8?B?SzhoV2kvRmhuQWEwdzZneCtHRzUzQUlaRWlxUlo2OEJzc3VNNnAvR3hDOFRY?=
 =?utf-8?Q?UiDz3jsNQke0vT83hYZHzK6+NDDqGG4e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFB6QjlEWlVIdHRxMVlJUlRmWkVOck01L2k1Z0IrdG1lV0tEK3h4T0M5ZytH?=
 =?utf-8?B?WWtIOEtEMm1Bdkg4MFJTV2ExRXUvNTlZdzVqNDBEN3ZrL2h0TjFucWFLNC9i?=
 =?utf-8?B?c3FtVmRGbUxyK1huSjYrRjBoRGtxWklpMC8rL0dSQ3ZKNWI5QVkrR1o2UUZr?=
 =?utf-8?B?RGFmY1hDTFA3dXRUaERXZ1BJK09qY1hvQUdHTWxXclZGRzZwMmhxVXhwYjI2?=
 =?utf-8?B?RGpHNTltbmdZTitrMXFnZVM0ZU56RlJKSGRVZDNRNGJpTEpldXZPZ1NjeWtk?=
 =?utf-8?B?NzR1bkpUeW1Zb0ZRbkNZOU1VcjQ0RGJ1dFBycS9zSTM2ZjEyWnJzdHdscHMr?=
 =?utf-8?B?MER3aFVrRjkzdldRM0hzMFd0d3ViSlhwdUt3NGtuK2kzeWo4RWk3ZElpdUhv?=
 =?utf-8?B?OFJ5UEtmM1ZwNEdGM1k0ZEJReGNobmtQTHYwUWRSaW5yL3FUTFJlZlVkRGdk?=
 =?utf-8?B?Nmt1ZW9XdnN0VVV3Vk4xM2Z6ZGFMLytRRktrcFpueDd2ZEFSWlRrRDBmcEw5?=
 =?utf-8?B?d0FUNXlTL2xYQi9xalRHMnlMQVJydHVGSmtKUTdFQkJDaVBSaFRoUkRvUklR?=
 =?utf-8?B?d3A0YzM1WHg3UjBYWGFIQ1lzSWpYUnZLK2pLZ2EwYzcxZWJBeCtZNmxxanhK?=
 =?utf-8?B?dUFUNkNST3F1T0dzd2dRSUx2T0IzVDZXaG55WFFxV0hWbFlhRGtPdTQxT2hj?=
 =?utf-8?B?cDFORmpRa3Fpd0NBU3IwWklJWHZ3QldiVEF6eXE3ZTRIdXJ2VUNJVXNma0w0?=
 =?utf-8?B?bURtSS9TajZ2TVZwVEJiMnF2YWo0RDJGN25hVUZ2UUZoSUgrSmI4TTJROHFx?=
 =?utf-8?B?eHFkMXMxY2pJczZGK2F3eG11cmhWOVY1RWR4RTIyZk9BSWdzM3l3eVNIVisr?=
 =?utf-8?B?UVk1dzlIb0tzcXdNcHlidVZ5NjIyckZGdXBGSjFrMUFsU21jVzU4WnNOUlpT?=
 =?utf-8?B?YTBiS1RJSWlvVWFkbmJ3Z2VTRHZ5OHRjdWl0SzRQRHhERGZNS1oxSEVxZERi?=
 =?utf-8?B?MWhQTVk4WHlkTGtQSDB6TkM5d2ZMQy96aEYxb3VwT0xLeFdYaHhVc1N3bEZs?=
 =?utf-8?B?ekZOVWtoRURWSk5Ga09Zb0FPV0Q1empSRVloOUdlYkZCSVlueCtmdU00TG9B?=
 =?utf-8?B?dGtZNlJuSE9oSEJOc1V0Q0dSTzJCb1NyOHlMcFJMU3RyeFNFNjZUMVc5ajBm?=
 =?utf-8?B?Mi95RXVBSkRmVXMwVVUxeVcyeVh3R3J0M1ZQemx4YWVnZ0NqdDVUdHBnNWRv?=
 =?utf-8?B?SU9sNUNkTENSYkZCRC80WkxycURDalR4WnN3YVBGOXBFNk5UUzh1eHdQdUEr?=
 =?utf-8?B?dmVxWVN5amtFUGlrcjlqUW1TdS9UN2FZckhuZ2owdzBHdXNXZjhkNDRlbWVl?=
 =?utf-8?B?eGpBSCtKWU90Z0tMbGVxdWFVangxUXRFeFNUMEZsNnJKNG1BYmF5blU2YUpU?=
 =?utf-8?B?UlhmOThwMVlUZjllMUJqTXE4VWM0c1U3SHZ3eTdpSDRpU012cDlTalAreUU0?=
 =?utf-8?B?YnExSDFOT0ZCRnh5cnRwNnRZMzkrUHZra3VsdkJwNy96UTJvWjJVb2RFV0dp?=
 =?utf-8?B?eTlvalRaMjhTZDRUY2hXY25nRzZhOERJM3lkU3lOZUdQOURNTG1hVk83VUti?=
 =?utf-8?B?MVBNQ3dEaHI0Qk1KQ2czeGpuN1hoTzhua0Jkem1EUi9HTzcxN3VHR3IvWTZE?=
 =?utf-8?B?YkRjNHp0R2loYUJ2Q3ZDRVlWNEpibU9nOWUrYWpuTnZqbXlSU1h4TGlxWGVl?=
 =?utf-8?B?Z05xc2ZDQ05aajQzV2pNN3N4Yk9SYm1OOUExZUJpUUpwWHBta25zOExCcHdE?=
 =?utf-8?B?QVlrTWtIUU42MVBFMW9MUjBBYkN3Z3JkSFpvcEFhTVA3b3I2Z09aODdVcHVE?=
 =?utf-8?B?dVlWUXJ6WVp3M1JhWU81VVFkUzdGMUFWZ2xWYnZKaWpQUU91YTFmY2J0NDdO?=
 =?utf-8?B?RVEwMGJkcWZzQ2xrUkhaOC9EYnJteFNsRU9QazBKWVhxczVCMGlsUXQzdFVE?=
 =?utf-8?B?YUZIMTF6SWpUSmFNRm5NemRiTVBidXdtNkh5ZW8rWEpvOTR0MXh4TUc0Vm8z?=
 =?utf-8?B?TEZHWjQwczlFb1JyM3FNUnAzZHNkaE41c25PY2dBZzVUOHRvTmJhUmxEcXNq?=
 =?utf-8?B?WTdHUkZpd3I5UzlqbjhBY0Z2SXl0aHUrUmZod29zM0RtOG1RYjlubEpDVU4v?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c5db6b-9133-4115-7a71-08de135e856f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 00:36:22.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J31zK/F1tn9xi+X0DaydCYimg7rJ3HbGhL7l+Ad/8ntWx9ClYTUe2I5Mx1hTD2QWcBld7Hi37/VZ7BrkmdLSC3aFVwYNalLX0SxYKWtmYg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8328
X-OriginatorOrg: intel.com

--------------OUNBn1rJmyCTUvArXSJdGy9j
Content-Type: multipart/mixed; boundary="------------yjQwGvLcW8R5d0hIG7scybEn";
 protected-headers="v1"
Message-ID: <ddfb7415-008a-47a5-ac81-b88bb79b9353@intel.com>
Date: Fri, 24 Oct 2025 17:36:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: txgbe: support RX desc merge mode
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20251023014538.12644-1-jiawenwu@trustnetic.com>
 <20251023014538.12644-2-jiawenwu@trustnetic.com>
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
In-Reply-To: <20251023014538.12644-2-jiawenwu@trustnetic.com>

--------------yjQwGvLcW8R5d0hIG7scybEn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/22/2025 6:45 PM, Jiawen Wu wrote:
> RX descriptor merge mode is supported on AML devices. When it is
> enabled, the hardware process the RX descriptors in batches.
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------yjQwGvLcW8R5d0hIG7scybEn--

--------------OUNBn1rJmyCTUvArXSJdGy9j
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPwbfAUDAAAAAAAKCRBqll0+bw8o6PWh
AQCnGlftMtqR7d5Q6YaN0JrWWJ230k/47HHCatZuAmV07QEA1mIoWAg+Uk0qxFX3cVSRbTKoTCW0
qdTzYZZARPBYNQ8=
=vQTg
-----END PGP SIGNATURE-----

--------------OUNBn1rJmyCTUvArXSJdGy9j--

