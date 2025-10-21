Return-Path: <netdev+bounces-231400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E51BF8C02
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A361A4E743E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB1727FB26;
	Tue, 21 Oct 2025 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGP6RpvK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970227F01B;
	Tue, 21 Oct 2025 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079317; cv=fail; b=n4Qw2hmh47/VelOLZ6P62Ou9eRRFjePXg96n3EFPANdfbeJAHPUcNoos06oHK4rEhZ9Mo/18dCfmIM/J9IJXKxbCfJYt+a61PpYWMx2ZvSSHH/CX2SPh41hux0YxyW+7yNsbLYk9oFFVOskgOd94TTb4+fOrXPMLCYy94Aep/9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079317; c=relaxed/simple;
	bh=nxMasFnYv94clKftDuI7s58R35uSi3PVba8L1D46fpE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f52GN/xv6vzfsT2Q0haNI2tzd5RnIztX5QSFRRXyCblM6xX1CrKaePwUdeSfsz4IgfwJmw702JXiNn/wwq4vv/eQ07foMQ+y8I0CKYRPE3rmqbS1AW92jrx+jliBQfi6b1RkQfQDdYmOmSKuPt0qXvpqA640+ApsFEVBVrh5ZH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGP6RpvK; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761079316; x=1792615316;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=nxMasFnYv94clKftDuI7s58R35uSi3PVba8L1D46fpE=;
  b=KGP6RpvKiqtG4Ay/Oa8rz8GSW5b7/IiPskNvmmT1sNQT1qBTm7WC8oja
   Pvoaf0G2nFV+O+TJweouGfevrJJLaWXjbnQ/L4+jJBlfZkOg/qE9wDYDi
   1KCNpLNm0vbvPuFsntmj7G3tBk/ooQi6k1bN/Iajvwk7uXG1tSTS/QiDp
   m75d+FOj7mtFMEuIwuBmV7rkOTMib/P+injPFX96zmxrQdH4b9Kz/6lSa
   5Ydohctg9uhcbv+WWRXAPilG4itSW4ioDAczaRLxijQlPwu0FOubwvNMz
   WZ6aTRY7zCMMLUu4CKxOgAm5s05jWqvE2clDqq0x9dC2fpoYFFypAewb5
   Q==;
X-CSE-ConnectionGUID: R3vuM/10QiCfcfY5Co+Dug==
X-CSE-MsgGUID: ASg9JbfWTBaTNXH7DApd/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62425616"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="asc'?scan'208";a="62425616"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 13:41:55 -0700
X-CSE-ConnectionGUID: VL/N9nZ4Rkie464sexyYRw==
X-CSE-MsgGUID: W27xPW4kTLq01zZMGCZm3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="asc'?scan'208";a="183388576"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 13:41:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 13:41:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 13:41:54 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 13:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQ+jZ8lfLarD+rQ7vF15tdKZ/t8hvTJYGWMUFXLoCvzPZ7zuMS7khBIp3dj4Os5jOICSM73rtusLnQ/8qlPAXi6zs8lIKTW+St4DuTVJP7bs1g8jsnTs7R4SYr0xKnnUMba0272GfGa6KMZWTwjKHrUiDryvY3oTXnFyDMe4OsX0lzJKR1tBJMrj2HAxKWPOiqyKnHdjt3EpaO9EnPI0Zu0kNy4aDclSlCwCGWwuqixDqUycDV+2dl70gFLIgE1/00lI6TgM7D1YTw3fOB4NnMhuO6xt0WEufwLSgULAWzvNj0vZjb5pnJILfn5BGmsLRB2YM5cqaPIHFFr16k5mMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWDMW60wfZEOiO+fY1PgvuVIae8m15jvwiF9EZqoEwU=;
 b=GKNIrjg0300grl9UboRrINhbqJvbJMsI9ZmrYrnkJ2Xj9yIeVC4FRps74aeFqa9AlSF/a7uE8f4L9OLuj0qhZyv+7/EXe/8ozvlFq3ZhIFYRBQBpIh8fZr4NneevpvaoaPLxOWdZHwRdxkMnizV9yYY0hwKuhJrasz9QepVCILIgKLGehr5twYU5d3c8v3AxAZvB4pqXycB/rwo9ahFdrEMA+KRaCZhsV7Ckn4Hkyp7lGO0BhA4fdcvdDedXpDgNUvsV9sef4z1rE1FLdptaa8/YO5x/oS5JX5PElDY+btjcPb0y9Gi5ykskmcaNPHXVrtpHKpsnPnJARkw1EZIjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 20:41:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 20:41:51 +0000
Message-ID: <7928f17e-83a1-4f6b-8319-eb316e2ee595@intel.com>
Date: Tue, 21 Oct 2025 13:41:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/14] ice: improve TCAM priority handling for
 RSS profiles
To: Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>, Dan Nowlin
	<dan.nowlin@intel.com>, Rafal Romanowski <rafal.romanowski@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
 <20251016-jk-iwl-next-2025-10-15-v2-5-ff3a390d9fc6@intel.com>
 <20251020181644.5b651591@kernel.org>
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
In-Reply-To: <20251020181644.5b651591@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------VBSCiKWEdxG0MHA2YQLGhFSi"
X-ClientProxiedBy: MW3PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:303:2a::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB4911:EE_
X-MS-Office365-Filtering-Correlation-Id: f10816be-af74-4044-cc59-08de10e2434f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGl4K3V0QWw2MDRDeWxPMUVNaFZ0SENwekVIQld2alJSc0lJSTg0QlgreTQv?=
 =?utf-8?B?YjNEdzFKcmx0SkgxVk4xc3VVZXZaMXlnWFBkemF1NUgxVklrK2kzQlY2d2cz?=
 =?utf-8?B?YjN6MUNZeDNRSGRqNkw0NlYydisxMkRoZWxlTEFoVGk5TG5kSWlIWFBSbUlN?=
 =?utf-8?B?dTVEQURYRHYrUHdVZ2pCSTl1RXhvNDYxTm52ZW1oblRVa3lZM21IbG5tOUlT?=
 =?utf-8?B?WjlKOU9ZZG1ITUx6eS9KaXdjOXNzYTRiMkpYMlNIc2NjbWUxaDR3REtKRjFR?=
 =?utf-8?B?SWcrYStNUmlTVEpYMWtFM284WHpsdVZoa090clhMVk5xN1ExZFdoemlsZXpa?=
 =?utf-8?B?SEl3Qm16d2x0V29ydFNTTWRHZlJGWnNSSlpoYVdOK2RUV3I0dU5ZaGlWMkR5?=
 =?utf-8?B?MW4ydHRaSnNuRVdSZElSNVJ5TWdnN3JxdHRBWlM2RFJNMytZZldBRmxXTVVS?=
 =?utf-8?B?elphWVR0c2xmKzBRUUlRVUZVcUpuV0hqU0tRS05BN0E3cTVSSFo4eUtGQjF4?=
 =?utf-8?B?NnUvSXFkYTdaZzBBbHRrZVdxUDZsTWJFdE1EV1FJbjVNTXBHZVI4QTJSZ2Ri?=
 =?utf-8?B?UjZzaHhTVy9kQ0xoSXpIdzhLRHpzR04zYkFnNkd0YlFCdVBKT25LOG9hbTk5?=
 =?utf-8?B?K0FUc0x5cWZxWmVRNUEvWXNaUm9SekkxRTJSK01VV1c0TDFKbFRNMkEvQTZR?=
 =?utf-8?B?YzlhNVhPMG0xMTVOU29FNmQ4SzBOS0tnR2NQQk9zK0JtWU5iT1JXVWErUGtE?=
 =?utf-8?B?WTB6bTJwWWdzdXFSK2h6dng4QjNLL25vSC8xaW5mSW5tVGN1dnRTcVhLNlR3?=
 =?utf-8?B?YndaNnVSR3hZSENialVNTFQ3bTNMUWtRWWoyVXNYTnR0bVJYTEdHaWxFZDB4?=
 =?utf-8?B?L3IrdlU1bW53UEI0aGFDMnZtRnpKTlJkMWNjbVRIME9JUGNINTl5djlyNDBG?=
 =?utf-8?B?dVRrOXU1REh4eCtZNzc2MmZqNFVac3ZKUmR1TDZQZTFpTWhKbnByTVZiUzBI?=
 =?utf-8?B?emVDaEZtcmRTZUw4ZkI1UENKOWdkWmdCdTFOTTFWcEJ6QlZoQTkzSkZUR1Nt?=
 =?utf-8?B?SXRlUmFibUdibmdUb2xjTmZ1cVExVTIxRlVxWExIZ2JiQlZmTHN1NzIxQllH?=
 =?utf-8?B?S011WXlWZ1U5bmI1YmFyek5pN0thQmhON3FpaXozTlBDbnpyV3p4R3dQQStq?=
 =?utf-8?B?UHljMnRFcldRRndaQXQrR1cxT0g3ZU5uaVZFZXJQdWNQNlBwajVldXlxQmF0?=
 =?utf-8?B?Y1RMSWdqeGJwbmp5K01CcWs3eUJGVzVmSHhNM0VCdEN6WFNpbDlTU2pOejZF?=
 =?utf-8?B?azR3UUZWVitxcmt0OXRIZWhrdmR3WC9yMVcyV210Qmk4bk1WNDNBVDhyZldq?=
 =?utf-8?B?NmtaeElWeE5YWDdKNjNwWEFwMk5mRXRWOUZpbkdKbWJKRGNaVGg5S3FlcldM?=
 =?utf-8?B?MEhBRTR6d0N2REZNOWd4bmtweEtWanJ4eENFYTZLb3NVYjlKWkI5UGJ0MEZv?=
 =?utf-8?B?R01sSmVvT3IycllHcm5JeGRxZWdJYXZMS0FwSU1tK3lnOFNlL2lGQ0VsR3d6?=
 =?utf-8?B?OVcyVXdvZDJtQ2NEWGs5c0ZzU3NIR200VGNJaG5saGt0UG9xSVU2TmR2bmJH?=
 =?utf-8?B?Y3AwUVFqMlJXU1pDV1RicnFVa25ZY0ttTHRoK1kxZ2dyaE1SQytnQVhkNzNQ?=
 =?utf-8?B?VUJPUWhXcndyMjU4UURkbkhldzhleHZUME45cEQ4RHUzd2JUVjA4U3JDMktz?=
 =?utf-8?B?RExJS2pHYVNoaGs0d3pCK1Y2bjIwTGFjSWNHMGpEd2g1M2wwcU9IMHZybWl4?=
 =?utf-8?B?NFF0WndoUzVHWUtQaWYzdVMweFlJSUk0OExJdFVCVjlFbE9YOU91RElRU0xy?=
 =?utf-8?B?RWdtVHpwM05Xa1VuOTNORTJEVmg1U1VDZW5uMStkQVB0M0dSL2U3QnR3aXBO?=
 =?utf-8?Q?fOYPArL/dGBjGOkzJhEUp/K9iSHhCPDd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0I4THlTcU8yV2xCRzMzajZjaU04TnprVmZ6M1ZTY2NhL1dwMGNVcDhYQzBl?=
 =?utf-8?B?VWdQb3cyTVNuT1dUemlOajVxNWZwQW5Sb2REdlBYNXJ1RmZ3SUwwVmg5RW5o?=
 =?utf-8?B?RUJPTlBxNGR0cGYvbHIzYkVXUTBzVk9qdW13ZWJ1VUlidThZbEtNSk9UdWpn?=
 =?utf-8?B?N0JyZkUyYmxsb1JFOVlLdVMyR0ZETW8wMXlsRGZ1aGxadnVlVGl1bUlUU1ht?=
 =?utf-8?B?dUZ6SXAxZXByVlNFVVJpdmx0WG5GSE9UY3Z5eGdzL2dMK0dVU2ZLc3dvNDNZ?=
 =?utf-8?B?RzBVWFM2Z0V2NEFDSll5ZnNvSFgrUGJzVkZjYlYzL1lTWkVTNHpVWVBlS3FE?=
 =?utf-8?B?cGdESFI3VCszR253VGZWbHppeXRPVlFRdXd1dnVnMGdaRktZTVk0bGJIYnpZ?=
 =?utf-8?B?ejA4RzQxZ1dMUWptZUs2aGFUTkdhd3MyMXBPc3A4OUR2ZzUvZjkyWXhLekJY?=
 =?utf-8?B?Q0hoWDJUQWFtRUlUVU4wMG9oQ2tkU2xoQmdKTWtram91cG5pbjI3Und2TXI4?=
 =?utf-8?B?eWNhYmp4Uy8vc2gyVm9oV05JVUlPeVdvVURQUHVVdFVrQ01CeHlNcHlTRFBh?=
 =?utf-8?B?enlUMzh1RkJIQUdhK05MdTd3UVZHbGNVR1o3VFN6UjFrTFZYLzZQa2RFQVcr?=
 =?utf-8?B?cHY1T2JhY0RpazI3SjIwL25QbUVMZnNGQUZFM09HSFhkRkNreG9tbklEcndw?=
 =?utf-8?B?TnNmOHlMZFhBUmJCM3hxRFltdHhOT1d5dVdCOGVkRnJ3bE83M2kycEd4WjNu?=
 =?utf-8?B?NVl3MTNKajhMWDZQUXB4R0oranpHZGUwSFlYUHVUdFdQT1lSYWt6YnFWb1gw?=
 =?utf-8?B?K1Yrd3NTdFY1ZUZnMDBCTWNWeUNwSHUyTXVFUUtYTzVjcU9YRU4xVzQxbmpa?=
 =?utf-8?B?YStoZWJ2dHRPZ0hWZ0RvSVZPTWRoaDgxc3M3U0JxY0tFSmhHNStjZ3lVYjM4?=
 =?utf-8?B?cHRvb3RxTUxURU5SZ01FWURlSDl5aUdMTU1hZXF4ejdTSStBd2lCSjlQTUty?=
 =?utf-8?B?K1ZwUER1UlFWRHRyUUs5ZTNVcmg5c3VYeiszYlVhMVhyY3l6Znl0d1FSVjlt?=
 =?utf-8?B?RGxDREJEU2NBTU4zeWZMUzN2MlA0dmQ1UGdKVURHZmFuMjNGbUJOV21yQVFD?=
 =?utf-8?B?RnJFNXI5M2xrQkFpTEwyZHNVR3BxZmlsTkhDbk5MYm1IdFE1WVBSMzNyTXlJ?=
 =?utf-8?B?Q3JqS1RaZlhSaGNxcjFidnlrcHhnQ0hyT1dZL0hqQlFIRktoYXhPaWFQOXFp?=
 =?utf-8?B?Z3dEb0RZR2xxY3hKRGwvOXFKYVh1TVhpdC9OZDduNUl4TTJERWM4b3FNTUUy?=
 =?utf-8?B?OEVDc3ZSYzNVa3hubUJhTXNBbzUraHpIbjdjVzJPR3NIcVhDaHByR1o1bnRT?=
 =?utf-8?B?azRJbmRsU3lhQ1Vid2xyTjJ5SEJ5bXUyZDdDUndKVnc0b1NCQ2QvY0xtVlVK?=
 =?utf-8?B?cmYzb1UvVzNybG15UlgwcDNXZDN6bzZ3TlNyUGxEdEZOTGpWYUJkcXFKRUxG?=
 =?utf-8?B?M1pLTE5pMlJEcTlRY1pnRXBJeEJ0OWhMdHZQWmM4YkRmWHpDaTRNc3kzUk1a?=
 =?utf-8?B?RGFoU01KTVhnNUl6WDRldlFWajFUVFFVVVd4NDlOU1ZRTWJQdHBYZTdNOEVM?=
 =?utf-8?B?NUo4a0dBU1N1Qkd3dyt2VnMzR1RxNy9yV2Q2cEYzamovcWFWRHE4NldraWQw?=
 =?utf-8?B?QUkxUFFJMHpSa2RKN3VuN3BFQXZzc0NiQUg2aUd2VG1ub3FJd2xucmMzdUVw?=
 =?utf-8?B?dXVLdWJYU1JBeU9KQnc1NnlpdTBPcTdZOENBMFBIUlFlQ0RyUUs1bVlweHFE?=
 =?utf-8?B?a2g4bzRncUZoYmVubjV3NWVBYU9WdmhiVnFadHR0WmdQc3lMc3RtcTU5U3oy?=
 =?utf-8?B?ajVDM1NrM2VVZjVHcFQ2Rndvc3pEazZLUE9WNlh6R2JicHU0Ry9XVzJwaTN6?=
 =?utf-8?B?eWxmaWVDYUp5RDJpc2dtWEQ1NzJhZktrWlNtZmZaQlFWLzF6QW55TytTaVli?=
 =?utf-8?B?TUxyT1Bpa3RCZjBWcWRjMkJuQUxObS95eG8wdlphekZKL2RzZzZJaWFqcjZj?=
 =?utf-8?B?RjFpK3NnblVNTWZUdHBGYW1jZmN3ZzVHbmdEZVlKMTBPeFJ4Q2krMDRnOVhL?=
 =?utf-8?B?djgvdEhuci81bXhseDVGVFR1N1hHS0tNQ0Z0RVVYeVFhck5UblZ5ZWEzWTRl?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f10816be-af74-4044-cc59-08de10e2434f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 20:41:51.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S01faz3OgeXDV6DHskE0dk3MtQH/ybu4s0PPRnxho63hOZCuN2FYcpP3LwQ6enMgzNzcLq9H2/TiCjGW5mIlbdVCcYqoZUMXJEC2nWpTaEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
X-OriginatorOrg: intel.com

--------------VBSCiKWEdxG0MHA2YQLGhFSi
Content-Type: multipart/mixed; boundary="------------pnHfpPXzcC6UaHsZ6Iwivr7O";
 protected-headers="v1"
Message-ID: <7928f17e-83a1-4f6b-8319-eb316e2ee595@intel.com>
Date: Tue, 21 Oct 2025 13:41:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/14] ice: improve TCAM priority handling for
 RSS profiles
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Dan Nowlin <dan.nowlin@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
 <20251016-jk-iwl-next-2025-10-15-v2-5-ff3a390d9fc6@intel.com>
 <20251020181644.5b651591@kernel.org>
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
In-Reply-To: <20251020181644.5b651591@kernel.org>

--------------pnHfpPXzcC6UaHsZ6Iwivr7O
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/20/2025 6:16 PM, Jakub Kicinski wrote:
> On Thu, 16 Oct 2025 23:08:34 -0700 Jacob Keller wrote:
>> +/**
>> + * ice_set_tcam_flags - set TCAM flag don't care mask
>> + * @mask: mask for flags
>> + * @dc_mask: pointer to the don't care mask
>> + */
>> +static void ice_set_tcam_flags(u16 mask, u8 dc_mask[ICE_TCAM_KEY_VAL_=
SZ])
>> +{
>> +	u16 *flag_word;
>> +
>> +	/* flags are lowest u16 */
>> +	flag_word =3D (u16 *)dc_mask;
>> +	*flag_word =3D ~mask;
>=20
> Please don't cast pointers to wider types, get_unaligned() exists=20
> for a reason. BTW endian also exists, AFAIU, this will do a different
> thing on BE and LE.
>=20
>>  /**
>>   * ice_adj_prof_priorities - adjust profile based on priorities
>>   * @hw: pointer to the HW struct
>> @@ -3688,10 +3733,17 @@ ice_adj_prof_priorities(struct ice_hw *hw, enu=
m ice_block blk, u16 vsig,
>>  			struct list_head *chg)
>>  {
>>  	DECLARE_BITMAP(ptgs_used, ICE_XLT1_CNT);
>> +	struct ice_tcam_inf **attr_used;
>>  	struct ice_vsig_prof *t;
>> -	int status;
>> +	u16 attr_used_cnt =3D 0;
>> +	int status =3D 0;
>>  	u16 idx;
>> =20
>> +	attr_used =3D devm_kcalloc(ice_hw_to_dev(hw), ICE_MAX_PTG_ATTRS,
>=20
> attr_used is freed before exiting this function, every time.
> Why the devm_* ?

Yep this should be removed. It likely came about from old legacy code
that used devm everywhere, before we started trying to remove or avoid
it except during long-lived allocations.

--------------pnHfpPXzcC6UaHsZ6Iwivr7O--

--------------VBSCiKWEdxG0MHA2YQLGhFSi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPfwDgUDAAAAAAAKCRBqll0+bw8o6HBy
AP4uUEjyHsfk/wLhvgFK5wW0NRzUS/iDcLWUOU7GsvNnqAEA/kGu7dHS4ryrtuUMO2LMkDcU7ItX
P1zXQh5rOpgMXwo=
=3FDk
-----END PGP SIGNATURE-----

--------------VBSCiKWEdxG0MHA2YQLGhFSi--

