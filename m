Return-Path: <netdev+bounces-228297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A755BC6D79
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 01:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37CC24E19B0
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 23:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B79233136;
	Wed,  8 Oct 2025 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSeYodxn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C700213236;
	Wed,  8 Oct 2025 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759965369; cv=fail; b=WFwAdwCr7CQbojXlqujBbx81N/WzrMdDq9UVyxvdv4trJhCekDPnaY/901FHH7tFVE0LDfa+1avU75sh/JMgbmSGQ2pY4c/OLz41YcwE8yu4lk7SZKQOBxIIq0NhTneiPSmuE3UJe9eHHwid806dlFH8PAw+JWh5O/+uo36bxFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759965369; c=relaxed/simple;
	bh=YZ+FUVCVjA0EVXPy5fhRVyQ03q4jYieN/7T1pRzgH3E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MDVbBgbKiwULDiPus6T5YcnCBOz8F+5nS/0Y6ENXoPerwfu3+soE61TMuX6bNsHPn2w/ueAnTuLvyVfD3PRll9Eo0kcnksXHAGx7sEXnYQQLO6BtMzctgTxTEBtwkIlTkSOi76masO/y14bmTHc3JWjpe75DJnhabmRbt7nwLEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSeYodxn; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759965364; x=1791501364;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=YZ+FUVCVjA0EVXPy5fhRVyQ03q4jYieN/7T1pRzgH3E=;
  b=GSeYodxneN0whD5jJEnYKL+szGYhHcBel/0ucKc9XwEl/dxjrY6HxeMm
   Asi+QxlynmUWL/5CWhphkVHRofrRnCbbAWXEGsyvgmjYLIadyxv3AU8vR
   FGLnT2qpJKujeXN/RVj3UZHaevuoG1gJwWKNOVZ9d4Mn//UfP9jnQUxp8
   Ih4in/CQeCWUtweGUPyyA3gWyqjl5kI/QVR4e3p9wuyCgnmuGPkrqmUFO
   3BUmReIHON9DjCEVr1EDPLjnSw/yToG3FRVoFx48YKkFEZDzNYO9EOUSq
   nxYQmdJ3kOEFtREe1OsLS5q8bRprmuvZO2c5/k2pIU22z9rRI99toshCe
   A==;
X-CSE-ConnectionGUID: XM1cCNgcTLm6P+jhF9jZbw==
X-CSE-MsgGUID: kABG0FPVRnOma4eaG36r/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="66021228"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="66021228"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:16:02 -0700
X-CSE-ConnectionGUID: 2HaDoanIRGuKyICF6wbEww==
X-CSE-MsgGUID: jEcbJ8a+SBmNbELdfjpmyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="179815748"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:16:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:16:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 16:16:01 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnsVugr4k/PCY6xgD4/8k7WjlKCL916DXmaPV/jEqBZgeQYkw0P00vUSV5Dj4ts78RIqjWstXKHMbht1qWnjC+rzPb1SznlfZYFxxHzHxRofqsGG3NuzERRyeF3502PcBXjJRxLDPAz8TMW8lx422GuovRrPZ4TKeq1rigLIhH4l6CGznPxdLYOvhYzJtlLqqNLyS2ylEJIM97QshQRdbsc6KmCl5gWgWDCTGdiLYS6gIeSNzKjlBSpvWN4YSPS+vr6r7tuIt1mbrLbwOcPaFvrA0a9mFK3cBKdSAMtRPaizQDj7i6ScPJvtYIuGuXWsl0JrcegfXxDd22xwmSI3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7f1FrbVmhg9t+9bJxIzjL6NI5mExNkP2JRlM0MemKE=;
 b=K5Eogscrgr9JtZFn74dqeRwHEuxGAV2SNmwG5ITw2l45pCeAzuIlwdP7GQYT5zAoZzpjtA3M6aOE7nDINLOZqYgtL6U/Im2x3Opsclo+7NpajRVIxcCRweU8oHG4AuD68alAgj5W9eCSuMG57W5CjcbD/Sr5J/8fHn61qCUCN3Y05Jku4M70ttyAZ/zNBLwnHquEmFzuSgl2I2DWU5H/2/r9jc6S8ZS4SzeFHEW6pFNPt8W0XjROmA2QVZfAWNJxEB1Sdj66WjhXg4IQXP4zYsmga+32LV3FsXOlUPEEJXxhSXjJPX468B26o5V35GFitruWBcKJGP6hx0PWonCB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DM6PR11MB4643.namprd11.prod.outlook.com (2603:10b6:5:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 23:15:56 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 23:15:56 +0000
Message-ID: <4a98e5f6-c638-4b99-bc59-bdfab7cd8c47@intel.com>
Date: Wed, 8 Oct 2025 16:15:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: fix packet truncation after S4 resume on
 RTL8168H/RTL8111H
To: lilinmao <lilinmao@kylinos.cn>, <hkallweit1@gmail.com>,
	<nic_swsd@realtek.com>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20251006034908.2290579-1-lilinmao@kylinos.cn>
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
In-Reply-To: <20251006034908.2290579-1-lilinmao@kylinos.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------ntOiknk23yfN24IWGPyeMEWM"
X-ClientProxiedBy: MW4PR04CA0348.namprd04.prod.outlook.com
 (2603:10b6:303:8a::23) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|DM6PR11MB4643:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a8069f-18b0-4a62-e6a6-08de06c0a205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDV0RlMzK1BHWnk3Ykx3RllLOFZXMk9ZS213M2gzRUt2NlgrNllqRm91MC8w?=
 =?utf-8?B?aXU2OVJ2RXRlM3FTV2p0SmxSejNiN013d2tEUE9VbjA2V1dlR1AwaklPOUYx?=
 =?utf-8?B?Zk1BdkM5bndSblhqNHZwN0oxQnZNMDNMeDZ6TWtLMkE1amtrd2xDQWZxb254?=
 =?utf-8?B?Y1NBL2QvUDNpbk1JSGMvekpldDJaT0dqNS9RelF6SjZJSldUbWdjMjRoc0la?=
 =?utf-8?B?NmdlTE0wVkZpenJHVXVWR1RySXJDcmlvcXlsaFJRVlozcUZNd1FINEJncXpT?=
 =?utf-8?B?RG5uTTlISTBuOUllbkxSSVlON0xFVHR4VUxqdnArYUMyWlpMdWxtWmhmdEZN?=
 =?utf-8?B?M01vK012ZTlPcTEvTjAxRXZyQjFUbmlQcHEvRFYveUVndzFqN3I0UHNPK3dG?=
 =?utf-8?B?L3Q1QUIvdVhDTTltYURIUTdiU3IyUDJIdWpQZmFhdlZxei80dTRRdWRUNWd5?=
 =?utf-8?B?QUJDc1huZ2xjT0UzQkNGRk1jYlJCR2tMWHl6NkZkcDJseVBJbmtjZ0o5SXQ3?=
 =?utf-8?B?TzZWcHM2TXVMd1JsSXI0andhN0p4Mmx4WkVHT001dHhJaEdYdlQ1eUpnT0h3?=
 =?utf-8?B?cmhmd0ZNUk0vS1RZR3A5bk40bXRJU1JJd2FlOEd6SGY3NUR6L1laNjMrdmVK?=
 =?utf-8?B?SUQ0VElHVkhaOE1GUE9QY1N2Qm5uSnpQK0NJSGNaUWN5WnJHZ0R1UjY3aHdj?=
 =?utf-8?B?cGl3Q1RYMnVRUE5qajkxeFdaelZ2WWFYeDdLSUNGWXJhemFPRjZkdEVHOENN?=
 =?utf-8?B?Wm1qc203ZWVPellUN0l2V3BiMXU4Z285cTVOZTVXbnZyNEw5ei9tUWcrNENB?=
 =?utf-8?B?NE9kQStodVo1Z1RZUlNaQVVSMDc4OWo0L01JRlhlODdRZmE4N1FiNzNyQzcy?=
 =?utf-8?B?N2JyKzVVTk9RN3hqYWZBU2pQQXpETU8wcnFMZVZ6TTlteDFVUEthZXlYdmt0?=
 =?utf-8?B?NXk3NytySnZUaFRxTHYvK3JScERmYms0eGM3ZFhUNXBDRzlkN3BUeE9IZjh5?=
 =?utf-8?B?Q1pHM1Fqb2NyaWVyTXpKRmpjSThQazFPNTV2T05lMG5MTmdiN3VUc1lkWVdN?=
 =?utf-8?B?RW9sbER6MXZOck1GM0VRS3FUcUZycHk5bklYLzFFYWNTaXl1Mi8xdzU2RGg4?=
 =?utf-8?B?cEJIMEI4Z2lFU040U2JyRE8vZERtcmVybm1uYWJmSFRZNnFUNUFoQWp5c1A1?=
 =?utf-8?B?a0dhS3R2RlJiVmljR0pWc1R0bm9OSnhvRnlWTTdCQWQ3ZVZFWGJiYUtCMkRl?=
 =?utf-8?B?MHdzZE5vdkNwcUNva0E1V1JIOXpuRnFpekRZb05PNlRqKzB4Z25jL1Uyb3du?=
 =?utf-8?B?blRwWHUxcFNIUVBoWGF4cEVHdyt6WXlmYjJWQlNzL0ZHbkRUZkJiSmJhNU56?=
 =?utf-8?B?ckQ0M1F6Rm5BQzB3Y2dyYTJtb1o0MWpkVllGM2JEcktUNUJzOEQ0VFlMVTY3?=
 =?utf-8?B?ZW1QQit4TC9VcVZYMVltcmlFQ3RWczZSbEh3MERHOExHeFJiaUdCVjJzVkFj?=
 =?utf-8?B?R0EweS8zd1k5OFhkYVlia3dMOWFtM1ZUVHlwZUNXcExnNS9lYk5SVjM3TjM4?=
 =?utf-8?B?eE01d3VESERITGgxRy9kZ2JCYk5reC9Cb2RsemRWMEUvMTl5YXB6S3QzaERT?=
 =?utf-8?B?TnpucS9LV1o1bGNKQklGbVlwTXpMRzNibkhOUHoyaXBESkdYektPQ0owdEJP?=
 =?utf-8?B?dTF3dG1qbHArREFpWHRXYnV4WTlsd2JvWlBtQk1vQUlRTmdSRXlXNGM0dkdx?=
 =?utf-8?B?T3VYUjdQRkg4NzV0TEJoQ2JHazFOaGtWRkVUeTNyVXNwZWtncHZHKzJPQjVy?=
 =?utf-8?B?Z1duZndDQ3IvcEk1MFQwcjZCZ0dBOU9MY2thY2hUSlEyTE9lQXUwb1dmcjN1?=
 =?utf-8?B?T0ZXUDMrSHVHcXpidUtiWitmbHd6MlFONXpuMnozTnpIKzU5a0lDZnZzRS9Q?=
 =?utf-8?Q?vyixykJjYhKdNS91GzbIXZcKv1U58Qjx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmpjTlJaRnE4QStQNkxsNml1SmgreFo4N1NJVEZKemFXSVNXTGVSQTFwS1lx?=
 =?utf-8?B?TnF5ckF2NlZGNG5GK0RTb3NQTnJpWXpFL25wY3l4eVdNdFEzMTB5aXNGbWYv?=
 =?utf-8?B?MytSK0Mya3BaUUoyaDMxQUZPdlF1QmVNclF3VGg1dVdxMG9IaUdqL05PRTlN?=
 =?utf-8?B?MVRDVDYxOWFXSFpMcmRXSEdQNjAyYjcrbFhxbXJLLzBEOSt0cEwvcE9iNFJW?=
 =?utf-8?B?VzVxa2Qyb1htaUVmWnhkc2hSbnkrNEZjUCt3L0JHQ2NQOExiWDJUc0FudjI4?=
 =?utf-8?B?bkM4VWdoL1RMa0FhMGgxOG83VitKQTBKajIxRGluTVl4OTR0Nzc3MWhNdndM?=
 =?utf-8?B?UnZBQXFWS25oMENIVHhOM3JtaWduclRsVWdlYVlMNktIaVpQUldHQU82QmdB?=
 =?utf-8?B?OE1yVi9icmNuempkTTlUNW9zQTZ2a1pSdU5JaldtUHlIZUhST25OUm9ZeEFS?=
 =?utf-8?B?VjVsSTVER0RtK0RBVHMvM1drZGM4eUlkamp6WjFIR3NOUTNua0ZpNTF4SUtJ?=
 =?utf-8?B?KzlCeGZmY2xYdHh2WVpHZkdpMnZuazd4YlJvK2tIa1lDSlpEdTdmeGFqUXR5?=
 =?utf-8?B?eXBVVVE4NWE0a2R3Nk9sTU1UbkFSS3pOUndqVUhMWHFjWjlUUzZNODBxM0xh?=
 =?utf-8?B?eDdNMjJPYm9mbTJ3QkxaUThqdlVYaU9YcEZKd3dzMzJxa2JZNVVhdkZHRllD?=
 =?utf-8?B?M21idHNVWWVrY1dVV2lBOUw2RW52ZytESGxjaTJxMkRZTkFBV1V2alJ0ZUtE?=
 =?utf-8?B?Rk9JWGIvYnF5K3dOYm0rK0lCV1ZDc2NTYTdWK0xiT1ZxNUVXeG13U2xwY0ZD?=
 =?utf-8?B?c0ZtdWpRMGcxUEYvWVkyZEhvK09sSUkySXFXd25TR2FxNjVkcjdzNk9vR2FM?=
 =?utf-8?B?VVNnVkhZS3JST3RSMzRQY0pCaDVPTEMrcmJsZ3Z4bVh1S3h5V0ZSclBTdTho?=
 =?utf-8?B?VEFONkxSajhGTmFTQS9GT1JCUzJYMExBZWtCOUF2MUdTLzROMnB5djZEbTBj?=
 =?utf-8?B?emVjN2hoTnU0ckdwOGdvaVYvNGZnVTBweUZIbytEeStPZGR1R2Q2d2IyY1Ux?=
 =?utf-8?B?SXQwb3pKWWQvb0hwTzFucUFmYmJ6ZzFUbHAvdkNxQ0hLdXgrQUJJZG55SG81?=
 =?utf-8?B?RHRUR2FpM0tIZzNGbWVwaGRGZGhwTDVMVy81RXlaaFcydVd0eDMvQW5wZytE?=
 =?utf-8?B?bDk5YnhXWGRZN3RoSnVGTlRXVHRySEd0QVFjem54aGx5VWNkK0pqZFRjTDNz?=
 =?utf-8?B?dWpwWm9VMmllakloNzFGQmEzQ2NvY1ZiUmR3K3Fvd1M1OVJMblNCaXB5ZVIr?=
 =?utf-8?B?SFZoTUFJcTMwYTk0Q1lvZTRid0NSTDNPWEFDVmFTZFlHcDl3N0ZmZnZ5c2dr?=
 =?utf-8?B?bWl6c0hxUHo1elV4cE9qMWphNFN4YUFGNDFUaDgwaUtidjdXcFNBS1gyWHln?=
 =?utf-8?B?QnlmMmtOMHlYL2RrckFYRlozcGNWejgvRVdYdkNpV2M2N2JlV2ZtdTdPWHM0?=
 =?utf-8?B?WkwxUzNYUWlDam1XMFdweUIzTmJBS3pzL21ocENXTHdJajk0dnU0V043MFhQ?=
 =?utf-8?B?U2dIR3pheXNWSUoxZHFYUWRYblhGbElpbFNGVjNQVFdFdWZvZWhVQk1MNFpr?=
 =?utf-8?B?aUFKejIrWGNxL29FOUlGUVlQcXY0QVIyWnFqa2lJUXdxRUFuaUJDMUpDc0Js?=
 =?utf-8?B?R0tUc1FBTDZjRnY0Tk9QTDhRZEplaGJDZEpMVTFPY0EvNnNxTk1DZEIwOFNP?=
 =?utf-8?B?NFFWM0g0UnVGYytkSFZxZEdVWmR3U2c4eXFRVWdxQlE4d0Y1ZXRLaW4yVldR?=
 =?utf-8?B?SHZQS1lJemNlOTRwTGNxMTg1VC9DYmpIM2MraWNvUUNGeXYzdTk0OEZqN29r?=
 =?utf-8?B?bXdwQkVSRWQxMmE4T2p4cmVDZUtnUGtmeWM2aTJQMmpuK3RMZWlJWGhDamln?=
 =?utf-8?B?VTE4ZHJibWIzWU1hL1R2YklMTStBK3doT2N5ZjRsSldUL0VodUZrY3pLMk9v?=
 =?utf-8?B?aTJ6TTdIMFRTOUlPTW5QZjBCalpRSXpGbnpsbElVUFFtYzZaNkVadmhxd0NO?=
 =?utf-8?B?VXZ2YStWMno1dkRIV1diMnJydDlLcW9wWjYrQzd3eGRmMVJHcHljdCtiODBF?=
 =?utf-8?B?cUpIa20xeTdSU1BaR05mczdJS1RHN3Y2dGlLdW0wNk0zTTlDWERwUXpqQkdG?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a8069f-18b0-4a62-e6a6-08de06c0a205
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 23:15:55.9325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2E7uJNv03fqXe6uItZNy1OpQpAHahxXgJzkR+Zfxkp1WGW0XFiWVpvPDiMIlnbu5ujRB1jhkXydwyx/4giwgYMu3Wzg+eXeMicZBHGU0vMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4643
X-OriginatorOrg: intel.com

--------------ntOiknk23yfN24IWGPyeMEWM
Content-Type: multipart/mixed; boundary="------------PSUybeCehX0eYYQSzC0dFtPR";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: lilinmao <lilinmao@kylinos.cn>, hkallweit1@gmail.com, nic_swsd@realtek.com
Cc: kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <4a98e5f6-c638-4b99-bc59-bdfab7cd8c47@intel.com>
Subject: Re: [PATCH] r8169: fix packet truncation after S4 resume on
 RTL8168H/RTL8111H
References: <20251006034908.2290579-1-lilinmao@kylinos.cn>
In-Reply-To: <20251006034908.2290579-1-lilinmao@kylinos.cn>

--------------PSUybeCehX0eYYQSzC0dFtPR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/5/2025 8:49 PM, lilinmao wrote:
> From: Linmao Li <lilinmao@kylinos.cn>
>=20
> After resume from S4 (hibernate), RTL8168H/RTL8111H truncates incoming
> packets. Packet captures show messages like "IP truncated-ip - 146 byte=
s
> missing!".
>=20
> The issue is caused by RxConfig not being properly re-initialized after=

> resume. Re-initializing the RxConfig register before the chip
> re-initialization sequence avoids the truncation and restores correct
> packet reception.
>=20
> This follows the same pattern as commit ef9da46ddef0 ("r8169: fix data
> corruption issue on RTL8402").
>=20
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
>=20

You forgot to tag the subject prefix with 'net', but its quite obvious
this should go through the net fixes tree.

---
>  drivers/net/ethernet/realtek/r8169_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/et=
hernet/realtek/r8169_main.c
> index 9c601f271c02..4b0ac73565ea 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4994,8 +4994,9 @@ static int rtl8169_resume(struct device *device)
>  	if (!device_may_wakeup(tp_to_dev(tp)))
>  		clk_prepare_enable(tp->clk);
> =20
> -	/* Reportedly at least Asus X453MA truncates packets otherwise */
> -	if (tp->mac_version =3D=3D RTL_GIGA_MAC_VER_37)
> +	/* Some chip versions may truncate packets without this initializatio=
n */
> +	if (tp->mac_version =3D=3D RTL_GIGA_MAC_VER_37 ||
> +	    tp->mac_version =3D=3D RTL_GIGA_MAC_VER_46)
>  		rtl_init_rxcfg(tp);


Part of me wonders if there is a problem with just calling
rtl_init_rxcfg() here unconditionally.

Its contents are here:

>=20
> static void rtl_init_rxcfg(struct rtl8169_private *tp)
> {
>         switch (tp->mac_version) {
>         case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
>         case RTL_GIGA_MAC_VER_10 ... RTL_GIGA_MAC_VER_17:
>                 RTL_W32(tp, RxConfig, RX_FIFO_THRESH | RX_DMA_BURST);
>                 break;
>         case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_24:
>         case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_36:
>         case RTL_GIGA_MAC_VER_38:
>                 RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_D=
MA_BURST);
>                 break;
>         case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_52:
>                 RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_D=
MA_BURST | RX_EARLY_OFF);
>                 break;
>         case RTL_GIGA_MAC_VER_61:
>                 RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST=
);
>                 break;
>         case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_LAST:
>                 RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST=
 |
>                         RX_PAUSE_SLOT_ON);
>                 break;
>         default:
>                 RTL_W32(tp, RxConfig, RX128_INT_EN | RX_DMA_BURST);
>                 break;
>         }
> }


So based on version, we're going to do a different write, depending on
which hardware.

Without knowing the hardware, I can't tell if there could be side
effects from this write that are a problem on certain revisions... But
if there aren't, it seems better to call rtl_init_rxcfg unconditionally
just to ensure that the register is properly initialized. It could
potentially prevent finding the same issue on another revision in the
future.

Either way, this is obviously a fix for the given revision so I don't
see a reason to hold that up:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


>  	return rtl8169_runtime_resume(device);


--------------PSUybeCehX0eYYQSzC0dFtPR--

--------------ntOiknk23yfN24IWGPyeMEWM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaObwqQUDAAAAAAAKCRBqll0+bw8o6JYX
APsE7TJ+RTxBvMz1tMiTVC9nq7wBzIwlPVahz3+m5EUePwD+MFSS738N2Hsg4LWETxkCReQopbmw
TEVBRAuktSriBAQ=
=RRRw
-----END PGP SIGNATURE-----

--------------ntOiknk23yfN24IWGPyeMEWM--

