Return-Path: <netdev+bounces-235288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB0AC2E779
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1C264E5B93
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD8B2FE04D;
	Mon,  3 Nov 2025 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3ekOM2f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100792F3C0A;
	Mon,  3 Nov 2025 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213567; cv=fail; b=bl2jDiG0uFf9twrcDwT/JJIoz1xokEo018LanIne6TXzwL11AlmM8eEXpiVW4aD8svjNK3pkh0Fs2+jI4Xo8ovqwkDmF6Si8rSi4VTosxRv7PhBlEpwnqZ9kCPPlc0QZUQ/Q+A6HIux/8wVIa3+VjzE/6goHmqwHWK6/5cnIa2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213567; c=relaxed/simple;
	bh=aWMK8Wpp3OfXm4atYrAIo/2vY1d4dqP/6dM+VNACJ2Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m4vJh1mTU5FHaK6ELlsuddJ2+SnQFZevMmQDgbOJ/4txLz9p6Xftj15cXeiPzQusp5wHvhpUrlkKi0H35nmZvfWouvDuxqJM3/4c70q0sxOXvDEUk6PzR1HsPXEhhZ1D6D1FzFMG0DjFPPcuSIf2wtPWuSCCHFBOUIzKnkDNYto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3ekOM2f; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762213566; x=1793749566;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=aWMK8Wpp3OfXm4atYrAIo/2vY1d4dqP/6dM+VNACJ2Q=;
  b=h3ekOM2fFS0GVe6qnf33zmgEuBSTPG6x1JCCkFOdFE7TcDlGMHjDyRng
   /m4HLTuTYWUy/wBNsHSllHomsnFSss7eHZXcSOAuLUYB23hLoLfjx7Nhe
   5QfgWoHj/VY2UjPNCVA+garFr0RYUzkZf5xnyR5SgpVImChbHnE8xqjmk
   jH4Rto7MQZTP1SXA+H2+THxxIpVlnqNNWfXYHx0564I5b6go5JwJjb/7M
   qmxmADyqj7MWlIhHprbOUHhHW/dGdlXI3Q3RNMds0mYvx+QPRxhknb7WA
   YOa/KnSm2gw0qm6vlExrMERPq9PRrpyigXNOXzMVJqPYDex6ZWRuM7TsK
   g==;
X-CSE-ConnectionGUID: VFRZ2PJVSF+XSKCxGpuw4A==
X-CSE-MsgGUID: eRK80dSERuScM7mZ393wlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="81707429"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="asc'?scan'208";a="81707429"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:46:05 -0800
X-CSE-ConnectionGUID: ffOHauc4RW6t9jUXmBne/g==
X-CSE-MsgGUID: cCWn3NUUQ9e3gIHn8rpZ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="asc'?scan'208";a="186686026"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:46:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:46:05 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 15:46:05 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:46:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=at6E5ug5BUyZLk4w78OtLWYTy5UtH2xfidARiP+wDhvR/LfLFTAZl9qwtTv857Mm7xor7GjjD7tmHqjQ5aFjVPSm5ig4tC5W+W6jx4jcOy7CxGVYvf0LI2msPHPHdpsZbi/TRxzh0/Eiove+kVc2eX9+N50r9q1VerzTIuTdbsVYqebs+YZqpAjhOY+MWapHOODBYSmXk2jl5RXUQMpdjb23tYSNqhMc1QHvVHp/icDv9AckQaVxj1ATOGlJcPCFnx5v4880joqPcZUNfHMR5uuVfTWAH8hxDFEKlICrej06f9V7Q8pkYRaSewGbk4g8PrL2Ct1jZs4Dwr7qk0Mqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSxwnIQOsKEUBMpO5nxMZWYovtYeem1mYmgcZslyxD0=;
 b=FHfwkVFe0FryC1MM+llIjeEy8ffMLMpnTsQoZDp0Cn2kK5KxwxElJZTKPgxzvRu06OUw7hF+XXWcSE6zQn5/txVw8EurN7ZxIhTuhLMrofkDdKPwt2zI00GBHKLzapsqoYiezyd3J1SKTu5FmahJdW9LCxgG3VEPT+2K8Kh0kwqaFBjxbGG7YVJGpdecYmZ97dbAXOU6dMxSCYNnowIDMKhw6rDK1i1+iVxY3EWcFvm5D9ur7DYj+icqjfKTrWHBqRQ/NGlSfb/cOy1vRl7JzayJqdIsR6dt/dw0R3+oCw2Smmv+5QSsI3Gf+XTauFdnv0icHqrmwTiabBz5nDZ8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 23:45:57 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 23:45:57 +0000
Message-ID: <a992abfe-9433-47d9-b925-bab6e3ec91ff@intel.com>
Date: Mon, 3 Nov 2025 15:45:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_net: Fix a typo error in virtio_net
To: Chu Guangqing <chuguangqing@inspur.com>
CC: <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
	<virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20251103063633.4295-1-chuguangqing@inspur.com>
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
In-Reply-To: <20251103063633.4295-1-chuguangqing@inspur.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------l8rd31RqoCX0HposHdID3eW6"
X-ClientProxiedBy: MW4PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:303:8f::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: b9958261-2060-44de-2131-08de1b33226c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnhiSVR5T2UrZE5abSsvOVUvclE0d1ZDQTRkQXFMRlVnamZrTkVVN0xmazZ1?=
 =?utf-8?B?VjlHSDhNSCtjY1ZPUUJuWEE0SWZxREg4RFlqUGhuM01mRml4aGd6UWpUOURP?=
 =?utf-8?B?V21NQ2dENWdLMEgwMGE2ZjBhN1dNZmlUcEV5c2FYR1NEdm83WjFqUGVoRDlx?=
 =?utf-8?B?emZ6T2huTHd5VndXWW5WOFVhTGJ4aVg0VEtsQlhIMm1FVWM4Ykl2YllYUjJw?=
 =?utf-8?B?azBlTnhRaE9yRGlJT0htb01hM3drYXExMW1wWjIrZHplRWl0cHYvZTBrRStO?=
 =?utf-8?B?QkVFQlZKV011dVJKUW9nN2pBUGpPN0FNUHM1MWJnbWhsc3J1VVozWDJac1lw?=
 =?utf-8?B?SEhpYnpoN2VDWjhpSll4UXdOUmxGbkd6SVh5Ri9GV2ZNcGFHbUM5czgzSXNx?=
 =?utf-8?B?b090SUsvSCtsWVRTZXZQM0xXMXArcDZicnB4Vmtab0xUY1BTUDY2S0xwbFV2?=
 =?utf-8?B?dG11VVZaSkNXYzdkelhydEdEdXg0VmExb1ZxQUpKU0ltVFEvNXl6cTIxL1BI?=
 =?utf-8?B?bENnTzBkMEt4RTRKWVNkZTJlWVhjT1BYR0FQZTB5Tjd4Mit4ekgwcC9NdkpF?=
 =?utf-8?B?aVYvSHRrbG5nN3BveE53dlBHQitudHdNTWdOVk9lNlY0ZnFNTVNlQlh1dWJ1?=
 =?utf-8?B?T2xjM24yaDNxWWtxRm9yY3JIZkU3Vmh2TFB0bGR5di9kbDJXNjNvS0RkWVcv?=
 =?utf-8?B?TUJ2UG1acE1BK1NIN1RoUC9RNTE5WWtHZitNNTk0NU8vMjZGVEFodC9lbk9I?=
 =?utf-8?B?cXJZQzMvZ3NpOXVqd2VWM3Q4a1pqNHNZVzJ4b3U5L1dnaG0yZEs3Q0hEMkNq?=
 =?utf-8?B?UnVsVEdYeUYwcFhXTll2U3RDb2trbWx3bS9OMHRvdzdwSG1WZHlvMXowUnBi?=
 =?utf-8?B?MGl0aVQ0eGNlVmc0Wmo5MGZpZnpxY3ZSMjVsaUcxVjl0SXpzOWNjYldvbDJO?=
 =?utf-8?B?OVZ6UzhGMkJHcnlyaHZCZ0cxTm5ZUDh4ODU2WlhsQm53SThtY1V5QXJkTVIv?=
 =?utf-8?B?dXVMclZLTm0yYW5mRXdLL3AwY0VBbmFWNU05VnE0ckVMRmhnTElqMU9VWmtS?=
 =?utf-8?B?emRrdXdlNWNSTlFWdkVrV0ZmUTF3Kzg1WUVrbmpyUjMzbUYrRndyajNlQ3lv?=
 =?utf-8?B?TzhJdVIrRUxGRHZJU3djcVNoY0tJSFo2UnA2RENIMWNnbTYwY2NXWjNiWDF6?=
 =?utf-8?B?b3dNb2NUYmc3RWRDRFZkMnRiQWozS2ZvUnY2ano3MTJXeGZ3aEZCR1o0TTRQ?=
 =?utf-8?B?MjgrY0E3ZVlzc3BSZjgvbFV3Y2R4dUJHTzNLSUt0QU1jRm8vbk9rZG5WUEJN?=
 =?utf-8?B?MDhzcXBMaFF5THdMbmY0ek0wTHgzYkcrNUFkS2JWOCtOdDNpQ1d5SStQbFU1?=
 =?utf-8?B?azgveUY1cjg4YnBQWFEzaEtRL1ZuVUI1THo2YTg3U1A2bG9jc29NeDd5NThH?=
 =?utf-8?B?NGJoOHcxTldZNnhMQ052b3N5N0NKSHZvR2RoZVdhK3YxS2hEbWZWWVZzaG9n?=
 =?utf-8?B?SWY0SE5TQ3IxN0wwSVNzdHV2MjhndUdrNSt4UmszempWUlo2VG82emxDMGEx?=
 =?utf-8?B?eDJWemtVUCtQbjh3alp6QzlOazRVQTRmTHRpa0lmcVdQVmdCZXMzT3R5YU9i?=
 =?utf-8?B?T2tUTlNwRUlDSDAxcEdLZlNlYXc3cVZDZzdMZkYzNS9DTTFheUNRVjN5Y2xP?=
 =?utf-8?B?amlCY3V1UGFDMmhLTU8xRzdGcGRVOWFIMXlSZ3A0b1ZiRlQrc04vSzEyVlFR?=
 =?utf-8?B?UG5KTlpOZnpFNnN1RTd2T2pIN2cyRmw5NjdVY3VNY3hPNkJxU1JQODFHMWRw?=
 =?utf-8?B?QVBJa2dtVlRJVUdza0diUm01cHJmN3RmVk9KUWRsRDUxU0I4VzZZeFZoQWxV?=
 =?utf-8?B?OHl0UktMaWV4eWtjRnlIZDROVEJwQ0l5UWhCamM4ZW4yN2crU05LZ09UUWh5?=
 =?utf-8?Q?GLDmgXpHmJZrnouXnYf18/meTe6xBtCp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVorWDE3RzZTTElDbFZTMk5ITDY0M0JsYVlVWTVLVGdFSEdJZEd6TGgyYWkz?=
 =?utf-8?B?OW1wcUNYR0xTT0FUSnlQSVFCRzZENmdaeHdseXFKOExwUHlBK2RZcHY0YVRF?=
 =?utf-8?B?ZjhDZHBIeGw5eHFSMlRkL3NEUENibnlOcUxtM1k0TFArc0UzbXpMWnJyc2Zq?=
 =?utf-8?B?SjllWlVYZFZtSklnUS8wUVI3UFZaeUVHb0JqNmZwQXNrZHZVVWtOYytjVS81?=
 =?utf-8?B?Ni8zM3VDamU5Q3hqOWlPbnViMkdyUlVTYWJuSU41RG5nMndKc091eXJUWWRO?=
 =?utf-8?B?bndMVGhLOWlHZTI1WXhHMFFCWnk4YlJnNFRTSE9qbTRoYVdQYlhJZytJeU9S?=
 =?utf-8?B?eGJpTldiemwyRmdNa3FUZTlvdmhUcHpVMGJnVGhaRHUxOXAvdzRMVDNEd1Z5?=
 =?utf-8?B?Ri9rVC8zeHI1QUE5KzFhVzhtY0tOUkJPQnhMc0JMTWJWTUY3a1diaFlMYmFX?=
 =?utf-8?B?RGViUkVuWUxNNFpCdENITmF4Zy9NbFBzUmc0NnQxK2lkRTBnaS9iaTRJd0Fa?=
 =?utf-8?B?QTJ4bURleFE5Mzc2MlRBNVUzNjhGV1hFT2JKcHc1Z3pyRkFocDlWc1c3OWQ3?=
 =?utf-8?B?WXhkRGJwOXBTV0RmUXVPeVExMVlBSDlFS2hiZitTMVlUWlQxZEMzT1ZvZzJ1?=
 =?utf-8?B?WUE2TVI4SmhxZUM4L1pramdhRHg3RkxQRHZaaG5aaVh0aHNpSHQ2QnBIYkpk?=
 =?utf-8?B?MjF5dFhCZEZONGh5bkcxUDcwT2c1TU9OYThTMTFZdXU5K3huRTJ3ems0eFhh?=
 =?utf-8?B?R0VGR1hRbERFS1Bxck9SWi9DUnMrUFFlcllSbUdSY3dnL3dZZnU1eXhTMXQ1?=
 =?utf-8?B?ZUlleGlHSnQ4ZW14WUVwdkpNQjkxT29kTlIvekFsK3NNYy9RZDZsZk1OT0Nx?=
 =?utf-8?B?U0VFODZvMkd4Q3dLd3BJWW9rQTQwRUQ2dUI3eno1Ymw1Tk0zcUR1ZDFXbmhz?=
 =?utf-8?B?dWlQRFdYWFdHNm9ERkFWVGI5OFY2UWQ0SUp4bmM1Y0pRM3VSWFNIRmdqTC9S?=
 =?utf-8?B?WUtFcURsY0RNNTdjcXE2REJweW5YYm5iYThaTk43RitYZ3BhYmh3TGtCM0xB?=
 =?utf-8?B?Z0dRQ3JNbXlwdjZZTXZmL1J2ZUM3UXVhc1pTcXBnQ1ZwVTFxZlZ0WHlsV1J2?=
 =?utf-8?B?Ukk5WGk0TnZlVzRMUEE3TmJ1Q1hWSzhTVkxmYlQ2ZzYzQzAvUGN1eXl3MHdy?=
 =?utf-8?B?Z3BGLzYrZVU1N3ZtNHRDTjRMaHZ4bm05NlN5OVNoRXdVY1dJbEdic09yOGFG?=
 =?utf-8?B?c25lVXNKelRLTkZnZTBidnJQcExUYlNJdGdGdUZSSVdRMWwwTjQ1MC93amxw?=
 =?utf-8?B?aXhSTzFzdTV6Z1doLzBBL1pRcDROWGU1bmxLdzA1MitjazNrL3hxSHQrVmlL?=
 =?utf-8?B?dEFKNGFKcWFYQUZGa3N6S21oNU4zb3BhVFl3dW5DVjUvcHBJQVloem50UHRs?=
 =?utf-8?B?SmFEcFFRRStXNlUrZm5HS1h1dnNob2pyS1piN1h5NDg2ZGJLMTdQZnRxQlZl?=
 =?utf-8?B?QkcrRit3M0k1YnIzakczaE1QMXNmY21ZeitzZkVra2pTT3NyRW1ReUxiSkJR?=
 =?utf-8?B?Zml1YVpMRnF3c3ZLUHg4QVA3cXlYZVExbmJ6V2w1bUx5ZGFtdHhBQjlMV0JT?=
 =?utf-8?B?Slc5b0UvajdDb3FGdndVSXVIQVUwZERBc0tJMGMrb0ZtOTI4WkM4aFJJaDQ4?=
 =?utf-8?B?cDlRNUhObmw2TEhrVndNZ05WVjViOUFOQlBHS1RPR0g1MHpHRU1HN1hSc0Fl?=
 =?utf-8?B?NHlaSFhhb1BYUEkrNjNVdWljYXA2dmxxUE9hb0lGVTBTSXhoczJaMDdicjdI?=
 =?utf-8?B?M3A4U2h1TkNjdDV5Z080SitaM1BaY2lYNFBDdDYwQWs0aG9mdW1oVzBubWtj?=
 =?utf-8?B?clZsL3ZMekhJQXBJdzF0bHl4cnRRZk9MVm1BZE5MVGZDM25pYURoVnptdktw?=
 =?utf-8?B?bzZtNnlhZkZ6b1EwTG9odEt2Vy9pYWlpaHN5YWNJdUJjV01CSDh1cElaTmM1?=
 =?utf-8?B?TzNhQ1JzSHg2ZExqQVNPa2FoWGVWZlpZVHpWMFlhVW5yQTRIZTVjdTg2MEhm?=
 =?utf-8?B?TlVFZVhYb0hSeTF0N3ZHNkpxZWVNYkpuSklTaHlaUzY5SXVtSG4zRDZ3dXpQ?=
 =?utf-8?B?RkFyNnh4TE4xSW96WGdIdnAvODZkQVZ1Mkh0dlJaRHpsSjVyalEyV05PWlVQ?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9958261-2060-44de-2131-08de1b33226c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 23:45:56.9724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeQzzz+Etd0pHsCUBYTLxZBx0OqN+LvWvSo89l3B6WKVe7SmldSqoKNExcKGHP4Z4mGo4ZRHaJksoDopc+pQJ7ZNfjP0EjaTxX0H1IM/COM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com

--------------l8rd31RqoCX0HposHdID3eW6
Content-Type: multipart/mixed; boundary="------------mmcNmMFukubg0JhasZkAV0AO";
 protected-headers="v1"
Message-ID: <a992abfe-9433-47d9-b925-bab6e3ec91ff@intel.com>
Date: Mon, 3 Nov 2025 15:45:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_net: Fix a typo error in virtio_net
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251103063633.4295-1-chuguangqing@inspur.com>
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
In-Reply-To: <20251103063633.4295-1-chuguangqing@inspur.com>

--------------mmcNmMFukubg0JhasZkAV0AO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/2/2025 10:36 PM, Chu Guangqing wrote:
> Fix the spelling error of "separate".
>=20
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

(As a note, several addresses on the to line were somehow
merged/combined so my email client marked them as invalid.. not sure
what happened there)

>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..1e6f5e650f11 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3760,7 +3760,7 @@ static int virtnet_set_queues(struct virtnet_info=
 *vi, u16 queue_pairs)
>  	 * (2) no user configuration.
>  	 *
>  	 * During rss command processing, device updates queue_pairs using rs=
s.max_tx_vq. That is,
> -	 * the device updates queue_pairs together with rss, so we can skip t=
he sperate queue_pairs
> +	 * the device updates queue_pairs together with rss, so we can skip t=
he separate queue_pairs
>  	 * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly=
=2E
>  	 */
>  	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {


--------------mmcNmMFukubg0JhasZkAV0AO--

--------------l8rd31RqoCX0HposHdID3eW6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQk+sgUDAAAAAAAKCRBqll0+bw8o6JtO
AQCbKSm9qLvNoCUfGgwkWJpbnXVdKbn1wUBcB3ldXFFdagD8C/pkHCTzQFTtUTDgj3sF1qPLxU2R
Hs4RroEQtck+hAI=
=Hj3w
-----END PGP SIGNATURE-----

--------------l8rd31RqoCX0HposHdID3eW6--

