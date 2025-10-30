Return-Path: <netdev+bounces-234471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C8C2101B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 16:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C23465018
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423583655C2;
	Thu, 30 Oct 2025 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILlaUe15"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A53644BE;
	Thu, 30 Oct 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839094; cv=fail; b=CRbiIeVb1VdD6o5cqMPrrJZ2tzA4fsEv1JJohxcHBRizpJVVW4o4eaFTGF0nhVQ+BdsZBOxc0oN+TBP9Rpg0w7o6yfMYV8xo5Pf514kgBnopDbr9XWlwf6NH25ShViCiyP4OEaLBMUgGofa5n1wZEPER0kem/tGUlErKhJFlDaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839094; c=relaxed/simple;
	bh=bjzNFnxm8Hd+GAyNHBzxb3c6DRxR9C+LbuMDD2KlxZw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o2YkmLsyXwNbK9sz3+epdxiIxIfuIXY6NhTzzwWOz3GI5d5554DX1mugUcC1kgndrc8ER5GX08bM/3J5I5h8R/DEXJnWY1IXlGD8V2JtJOivaKnKH1EmUpmFsBnmazaYcv2ws8AfLjB16wilxUEmS0shz9KXPuIn/y8wyQ65PTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILlaUe15; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761839093; x=1793375093;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=bjzNFnxm8Hd+GAyNHBzxb3c6DRxR9C+LbuMDD2KlxZw=;
  b=ILlaUe159EdxAlehBtNt84gOJsMpBgUG9hMTRk4v6XNawLEOLPIKxuvV
   aOdzF8rX4L9PgEdJe9cRecA+4EbCJ/GWWb02WHxJsRQQMsHKPsQXzT7TI
   uvookEBQL6TpOK9vdUrkWjDH1VYF17NggRB4/luAL3NroPXa3DxoQ46qG
   ag9GsUXjVC+Lbokx+NIyWVhU7+q9VZYlVg7tL5YTQjTYm6nddxgkzI/1Z
   632vBFdOW06Rf3Pqee7vv/bfqW3q5vwTJBS7w9xK12/lvu/TXjZuv8zNT
   v1liVUuihfoDDDHgSEVGkoln60vgXfbpZ6gfvpSF4OkkTDfRsXcLNiKI0
   w==;
X-CSE-ConnectionGUID: lSDaRKn1R0ykJkwu3cgnqQ==
X-CSE-MsgGUID: GD/EhSHZRY6r+CQ89xGhPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64026757"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="asc'?scan'208";a="64026757"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 08:44:52 -0700
X-CSE-ConnectionGUID: UpMQZ4ssRJybxyuI+O8hNw==
X-CSE-MsgGUID: MeZP8AQURvibuVLyKr6orA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="asc'?scan'208";a="216644729"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 08:44:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 08:44:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 08:44:51 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 08:44:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQuiuhIB0/R39jc4FO/ALzY0nFcpqaiqfG3G8l7G2mnz0fX5ivnIUbCq/v37WzBFdo48KVOsrGe/F7r11uz7aYkxvfULruITWUZb+oQTiu+j9tZyR0MZK2giZaBXVhODDhDDdq0Ci96U87narNS5ANAH4QSFc8Y7MeNKLnL+7JwkriZKNkePoPmNVfPJUuOaTpLq9LtFc8tpAfkMwsWCzqA2fZFIll8YVsV8EXV4Jz24g3h7KHfXxL8ba/6vIBfcftAqxpDK4GKCDcSH3bLDiXzx7hwxQobbIrcoLuT0ihPGFlZdPAxyMv2KxFiYcA2qgRwbq8torMh0IL8df/H7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjzNFnxm8Hd+GAyNHBzxb3c6DRxR9C+LbuMDD2KlxZw=;
 b=psh/eWWcxrUvHO91rnpdy4BLyQYJ/q1zkiqNNcDmQHyvFor4x9t7KqJB8EijLbFGDMsrnv0uDzFRl7CL+5NCMvGl7XRh/79LETZIPHEo9ycVsBQNpq9b0f2dls3VRg5vxlGuOBi6I/g86S+gUaxWBzcTNDNPGRzmyFJoOW/Mm2lQkeq1G1E0qWpySgZTyuFfz5xH+rpKN9hjib32y9WxT4+lp45xhFM0rPyZniRr4NW8492d2VMC2+6OVAyG7sRv0hffCc2/btv5kVMZbzWZc3wAbUFb8boz86sDI0h4/GISAkzLto/nKSeRdP/qUnxQC4tz4hb9HKHfsoLAjKUkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH3PPFD114713BA.namprd11.prod.outlook.com (2603:10b6:518:1::d50) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 15:44:49 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 15:44:49 +0000
Message-ID: <1c23850b-eb67-4ee8-ab1b-2e4d8999bbaf@intel.com>
Date: Thu, 30 Oct 2025 08:44:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: kdoc: fix duplicate section warning message
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20251029-jk-fix-kernel-doc-duplicate-return-warning-v1-1-28ed58bec304@intel.com>
 <94b517b7-ff20-463b-a748-12e080840985@infradead.org>
 <e8e0cc0d-3f71-42a9-b549-39840952ef0c@intel.com>
 <f226af11-adbb-444f-9322-1dd3116321f7@infradead.org>
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
In-Reply-To: <f226af11-adbb-444f-9322-1dd3116321f7@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------dsCw2KwH9io0Vc0ThIfA9L9c"
X-ClientProxiedBy: MW4PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:303:8d::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH3PPFD114713BA:EE_
X-MS-Office365-Filtering-Correlation-Id: fc46845c-71f9-4c87-ad7a-08de17cb424c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vk9IbVRISmFyaUE2ZWc4QkZCdVNHK2JybUlWVy9hVmE1dmNZcWg3Lyt6WEhu?=
 =?utf-8?B?enRwWTJaQ0xaMXpCSTQzTnZpZ3ZFd3JWd2JMOHlKNG1vZXQzM2hoalpmL3ZW?=
 =?utf-8?B?QlpGZjkzWFY2Rk5oam5tbmNoalRJTyttYURFa1lmOEdQSXJveUYrMFNvTGh2?=
 =?utf-8?B?Ri9WYzNaeGJIVWZkMVVoN25yazByK2M0ZWRkYmdRa2VQOTBIVWVLazNRL2xQ?=
 =?utf-8?B?Wk1scE5rNUdTQ1NEL3NaanplM1k2ZTBqcVVPcjJYSkd0bkpOV2NPcjZyWEhx?=
 =?utf-8?B?a0VuZkNiaFJrQS9PSkJTSkRCczd1WDlxSnhzbG5ISFI4akZvVGRLL2xWOG5H?=
 =?utf-8?B?bUF0RWFxeU01N0l6dDlSMFB4enEwelNiNk5qaC9TQlhxY3hxK0dqRVM2dEoz?=
 =?utf-8?B?OGpHM1lWb0NEMUZ2Syt5SkIwMTA4d3lwQk5YbXdjYnRSakxkbG1reDd1bUYy?=
 =?utf-8?B?UXpIdkhEREhzZHhSMEtReEorM0hSWUpUTmJtYm9MRGIvN1E1VExXVzhWRE8x?=
 =?utf-8?B?RVpVdi9EM28xaGRTTDhnUzhTUjB3Q2xKRDhtdFdFa1ZPOUlWeWRQU0hqeUhm?=
 =?utf-8?B?bFBuYnJYekhsQWdtWlAxS2NvcUhLdWRsRTIya3p0UkJGL1ZVQ01md2pCaHBN?=
 =?utf-8?B?RW0rOHlETDFwM1BETlRyL3dva1E5T3pwVk9QUURYdnlNcDEreUcxYzNER1lz?=
 =?utf-8?B?aklaWUxDUERVK3NnUDJ4NzBjM09iSlRHZjZYSXZ3T01SRGRVVHhOT0ZLOGh2?=
 =?utf-8?B?WWFscXFHS0RCRDIyaE0wOEpRRThmQjBIdUJjNGFmdTRxOFhJY0xsM3JETEJB?=
 =?utf-8?B?Smt3bzZxTmxvSklXQkFFblVBZGNiODVvYlphWlQrc1EzUSsrMUVvMUllNDlP?=
 =?utf-8?B?R2lObi94Ym5TcnpvUHgrakNoc29WU3AyUllsMnRNSkFTOG5kKys2YUJXUjdG?=
 =?utf-8?B?MFAvWmJJVGsySCtneUFFMWozclQ0Rm9kZktPUU8rdEVvSFU2VTZ5RWF6dEdp?=
 =?utf-8?B?QnJGdWR6OHZIR05nQ0VuKzJpUWU0VE1IZC90UkdHaksxVXNYSE40cXR4eUpz?=
 =?utf-8?B?OXhaS2pieHJyalZMQ1R3cWVLeXVpcncwVzhONmszSHdad3hnVW5NYkh3dm1z?=
 =?utf-8?B?Y0pSalF6Y0tWVENPSnNYOVQzQ3hjdFU0OGxFRC93UFMzTXplWU1VVW5oc1dX?=
 =?utf-8?B?Umhod0s0cFlmN0FSdEZnQkx2bU1sVUhxc01kRnZvOWdXNGQyU29yQWpKSHlk?=
 =?utf-8?B?NStMR3pqaGFnMW9QYzNKa3NVdmM3YlNVZFJjYnRkMGswY2UwZ2VObVRmMHhE?=
 =?utf-8?B?eG5xdFNmeWxrdForNkhjK1lGTGV4bFAyYUFNeVlOdklEWTFhREJJTGlpUVlu?=
 =?utf-8?B?WmpLQzNBY2E1UEVNRU5zRzd4QXZqSVdRcWZUSmNhVnV4WW1INmord2lLR3JS?=
 =?utf-8?B?clBDVllYNkVGWFN0S2hxYWZrYmhFNDNFTUhiSXlkQldQeUlFdmtUZmJmdWow?=
 =?utf-8?B?RnRUUmljeWgrSkdoa25kKzFodlZEUDViSzJyNFFwWTFCcXU5WDJoeDROWldK?=
 =?utf-8?B?cUIxc2NiSjZZaEsvdmdtcVNjYm5UcWZIN1ZaVWcwUG11Y0l5QW5jNGJIMFdp?=
 =?utf-8?B?aFVza1UvcG14SXNPeEVKM085M2dzVllkWGhrY1Jna2tpaDdoNS9YMjNBcFdH?=
 =?utf-8?B?c1k1WG1ZOEN5WGlYU1RiNzBiT2lBZTVnUjV0bTA0eW1lZkxzSStaSSt2ZWJZ?=
 =?utf-8?B?MW1ZL2NZNHJ5UFVyV2JRdk03eVFSMWI5dStUNDdKQlhIL29LU3gyWW9jT2di?=
 =?utf-8?B?ZXBpNjQ5VDhsNSs0aVVaZVV1aCtaUGdBZFVZMkQzem4vWFZuajBiSzdvRlpP?=
 =?utf-8?B?MnI2bk85NzEvTlIxTlhiUWcvWHRIZGxwMGljRG44WVd0OU1pZ0g2SHQ4dnV6?=
 =?utf-8?Q?JthKoSZR89M20oswU15m8gSA40sjVo6c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MElBV3V2TDA0RUFsTlJnMXlCSVRiM0VMVVBpdjRlQzlKdU9QdVg1N0h4SHdH?=
 =?utf-8?B?S00vYURxa2NOdUo1RUhCY2tpcDFtT1VKa3dTYzdnWEpwVHBsbS9KMUpjZDRW?=
 =?utf-8?B?QThiaWY4dEJDa29CYXo1TUJXQUtmZ1RjVnA0bzYzTTIwd0RXTzN4Q0tOQVEw?=
 =?utf-8?B?VktFZ0RleHRVM253c2UrdytkVzQ4eGF1eG1rSW01cnJsTWEraTV5K1NkTitv?=
 =?utf-8?B?TE9LYng1SGtzVS9uazROeXRGRTZkRnowMmV6ZzUrQkRFM3hkOFdHeUxxVXRE?=
 =?utf-8?B?K0lUOWh5cDJzMUg0bUxQY0NmcmpaTkNvUWordStnczZYb3JMbndUTmtRR1Ax?=
 =?utf-8?B?WDc5UWNLQk93MXkrYUx6L1l4d2NSRFdXUEV4dHhxNURVbzJFY0dOUVJiMHUr?=
 =?utf-8?B?MllSOUU5QTlKWExuc251SnlFdXMvV2dvMXY3UFpsSGNCTjcwSXptNlBMaExI?=
 =?utf-8?B?OVRWTTk0M1FHZS9BaFh6dngvVWl6blpXMXU5OGFzSko2WGs0UnZtanlYSUhU?=
 =?utf-8?B?cGUvNWIwWVR3NTRHcXBwUUh1YTF3UlJBZEVwTGw2dnoxYitnanlETlZRWlBW?=
 =?utf-8?B?OE1aOWFiMWNMQUk0Z2NQMTl2VDl5aGZudXJJODNxN2VYV1VLNjAvOFRtN3FS?=
 =?utf-8?B?YUNWdEF6S3VNRjBSd2h1d3FDSUpqTU9rYUZQMU1acUxiY2VJZ0lYVHkzMEU5?=
 =?utf-8?B?Ykt1bXM0REl6bWRPSTJWSE5tZkh0ZFhFdTlqL0NKWkxRNjBPdDhUa2tnSFdq?=
 =?utf-8?B?Mlh3UklPcFhvQkVrTnEwOXQyUS8raE1pK1l2eDU0ZHR6Y3o5WjQzS1c0ZW1t?=
 =?utf-8?B?NmUwVU1ESTByTERpeFVHNlNpVUdZbFVlc2RsaUViSG5BS01kOVZNd0hDZHlP?=
 =?utf-8?B?MmYxQUR6V2Myd0FjT0J6dEkxUEJvTS8zcW1aeUNCcThodWN4VUhha0wrTEIv?=
 =?utf-8?B?bi8ybmV4QWxTMnhTYTR0NWpQbnl5a200YmpGeG91dHJ0aGVJOERqK1JZcWh3?=
 =?utf-8?B?UXNkSXk0K051US8rZmhEZWw2L1paR25WMWlEYUF6V0dadnFxYXN1L2lHNElW?=
 =?utf-8?B?T2lYTmFNV3F3eFE2b3BMbG41TDR5eTRVajF1RmN1L1hwTFZlYjNhZklEajBW?=
 =?utf-8?B?K2F2eUVad3oxSWhOdjBkQTBPYkNUdWRLVGJoZ2hkTVNuKzJySXdVdmxlRXJO?=
 =?utf-8?B?M0l1Yk9KY1lxSG9DU1Y0R1pqMGFvR1E1M1czU21aakpOYWhISXlMY1ZSbG42?=
 =?utf-8?B?b3hxUEQ4azJTZkZDQUFCdlJqMFBqNEpZZk1MMUs1WnFFYXc0RGxCU0gwT0U4?=
 =?utf-8?B?NEhyQUlhdG5ETnZKN3ZENkFkRXV0amtKdGlTeW1kSmgvOUFYSnRSaFBSSDNW?=
 =?utf-8?B?OU5BUXpTTm1RTC9ZSWtmTEdVVkFmZ1lQc040MnpsRmdwRUtxaGQ4VHVDQ2VS?=
 =?utf-8?B?azZqMnJFenNTSTMvUGQvMEZUdUwzRUQ1VDl2ZG1ub3AwUHBGbzNZdWN6MGtX?=
 =?utf-8?B?NitKZ0hJYXBIODNkaDJ3RVdpMWRTS01TMWdHTUhBRlVIbUplNjUwbmJ1TU1u?=
 =?utf-8?B?bUE0Y2VrcVBJNDVLWlFZUEo4YVJQMVdxSUpXeDkvbkx0b3FyNkFHVXlCR1Zz?=
 =?utf-8?B?OTdqbDBGNWVUR2QwbEV5ejZ0MzBDcE45ODdRNTUwSmlteUNMaUNrWmF5aVYw?=
 =?utf-8?B?dFJ3TnhJTGFUY1ZyRzhzK2Q4YmltbnF1c21zQTJwOUFFc1dBN0ZXTHNUWFp2?=
 =?utf-8?B?K051RXRSLzNEbzE3NGFVeldmSjJzSVNDM2liUnFsVDg5cG1GUURqNjM3dkNR?=
 =?utf-8?B?S0hpYk5pTStxT3k2eU52NDk3b2pLOFU0VjhoZFpIK0crZG9aZDB3NnpzTXBi?=
 =?utf-8?B?V3lxZ3ltUXNzNCsxODI4c3dCVFB4M2pKaHZDQzZaUEJKUFYySTJmdG9OejFW?=
 =?utf-8?B?UDNaa053NUxIdHZZRm9XY1FONXo1NXBrY2NVU00xWVM1Rk5lYy85Y3pUaEhE?=
 =?utf-8?B?Q0NCajVRWHRsWHVQKzNXTUZJRE5Qdm9FK1NOVTN4Wi9YUXRBZitaYkxCN2Uw?=
 =?utf-8?B?cThjeGJycWt3UTdwUUQwbU4ybXE3MDQ4YjRmejZTb0tEY2lzUE5JazNVb1Bu?=
 =?utf-8?B?alhtSmhUS0xMVlhXT2lhd2NldFdQVFR4TStWVVJOa0lTVzcrRmV1bjIveSsv?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc46845c-71f9-4c87-ad7a-08de17cb424c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:44:49.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awRk10qj6KXTYTkm8x0lpCfUz36Ewi04tpv5h9rNvPNsTV39AtXokO/ZnkvKEXsmJVkrxNF2Fm6V//QmnrYqSeCTJU1ppWl23Y1CBvkKmhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD114713BA
X-OriginatorOrg: intel.com

--------------dsCw2KwH9io0Vc0ThIfA9L9c
Content-Type: multipart/mixed; boundary="------------0U3gKRMixfmGy7wiXWR8M2QH";
 protected-headers="v1"
Message-ID: <1c23850b-eb67-4ee8-ab1b-2e4d8999bbaf@intel.com>
Date: Thu, 30 Oct 2025 08:44:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: kdoc: fix duplicate section warning message
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251029-jk-fix-kernel-doc-duplicate-return-warning-v1-1-28ed58bec304@intel.com>
 <94b517b7-ff20-463b-a748-12e080840985@infradead.org>
 <e8e0cc0d-3f71-42a9-b549-39840952ef0c@intel.com>
 <f226af11-adbb-444f-9322-1dd3116321f7@infradead.org>
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
In-Reply-To: <f226af11-adbb-444f-9322-1dd3116321f7@infradead.org>

--------------0U3gKRMixfmGy7wiXWR8M2QH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/29/2025 1:39 PM, Randy Dunlap wrote:
> On 10/29/25 1:04 PM, Jacob Keller wrote:
>>> We'll have to see if Mauro already has a fix for this. (I reported
>>> it a couple of weeks ago.)
>>
>> I searched mail archives but didn't find a report, so hence the patch.=

>> If this already has a proper fix thats fine.
>>
>=20
> It was discussed here and Mauro said that he sent a patch but I still
> see those warnings in linux-next-20251029.
>=20
> https://lore.kernel.org/all/jd5uf3ud2khep2oqyos3uhfkuptvcm4zgboelfxjut4=
3bxpr6o@ye24ej7g3p7n/
>=20
Thanks. I don't see any fix from him on the Lore archives, and I don't
see one on linux-next or docs-next, but at least its obvious Mauro is
aware of the issue.

Either way, we can wait for Mauro's response here and take or leave this
patch, whichever way he prefers.

Regards,
Jake

--------------0U3gKRMixfmGy7wiXWR8M2QH--

--------------dsCw2KwH9io0Vc0ThIfA9L9c
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQOH8AUDAAAAAAAKCRBqll0+bw8o6FlA
AQD62UHg1yGtL0EMC8DF0sH5yJH+JX+DuJqqFBpTfU81fQEAh5eja+Lm+NeOvGaZ2gPr76vkoCRI
c+9VeEJSgRiCyAU=
=MlMC
-----END PGP SIGNATURE-----

--------------dsCw2KwH9io0Vc0ThIfA9L9c--

