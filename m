Return-Path: <netdev+bounces-280071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFv2JHBP52lW6QEAu9opvQ
	(envelope-from <netdev+bounces-280071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:20:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AA84396DB
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 813D330166D8
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862B34C155;
	Tue, 21 Apr 2026 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTKqpzwR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19734846D
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776766829; cv=fail; b=Ysv7M/Vr7O5XliZ4U6VNRDp8lOxavNvgfNGrBBGPZv4hoGGAB/TEQELS3x2LbRrjmMtt1OhJ5SxF+9ykaKzt0zPN8kgeUoMBuIUhiDgBP7sQOTNQat/P3zpzAW3CgVqN2pKzwivNuDgEt6FH7fzv8avRgCZnHO74wKUa5mG1V24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776766829; c=relaxed/simple;
	bh=niKcx0rBl1m+DTqtmi+Mz8XYk4tuRlBOdtHYK7Bss+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RgFg1Z/g0aoMN2wTFECXiTo/E4FkiM+SXnwdu9PWotfxB56PbyAprFcvUDr+GQHhFw+e9CO8bjaClqWzIMWqslU0ihqsYYhs7ADnpAy3iN3dFThwmEhEGxUZDvYxjoLhVLRNn3HUggYY+7lLDhESWDsMUvZNUuzxyh5ClkTgjSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTKqpzwR; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776766828; x=1808302828;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=niKcx0rBl1m+DTqtmi+Mz8XYk4tuRlBOdtHYK7Bss+k=;
  b=gTKqpzwRnteN2QFZXKUubUPifflk97/VBhoUx04smIpkARUDdUfWFvyU
   grUVriDDz4hKiuu01O6xhOqgExEDcMyIztcYL7v12DLsL6y9FgyxFKVv8
   amqG/oxalK/IAPsM2l57u12N1CkYDYO1ReHMwYDT3Hnd4sSmYtCAEcrPA
   TPYWgwLGU0XMCm7v1l2ccj2c0/w0PB1DGkBXZXVDvBu18GjchFBRdaPJN
   9xe6antxKuwFieSOdLksyb1ZENGdpTHt+NTpa9vMwseXGtHD6PRbCLs9d
   jkCScZ87brrHhxJG7BFO84LkaSBrxrwmd914LaEuZfwPZNprj0cfIu1GN
   w==;
X-CSE-ConnectionGUID: Xqw63YKlSNOJAUo5Z+VPig==
X-CSE-MsgGUID: wZVph0tqTCOATEw3Bw4bRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95107505"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="95107505"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 03:20:27 -0700
X-CSE-ConnectionGUID: Q0Kl9j1gTSqgCdXKYnELAg==
X-CSE-MsgGUID: teNXTjtFTQ+NBoRTvZHUhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="236009839"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 03:20:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 03:20:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 03:20:26 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 03:20:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxekvqOQBLMTYZp3IdDuX8yPsqrn6SODMUY+EQFXN8QPa9dxMFj7NSDB2umuahQXjNul7+nyHiXDCbqVkJ2FpVm/f0R1G9z1yDH5A4eZ0h402HBTCCSBiHWyEBzHIZFVJ5NWoWE8L6txe/YLEjGnR2lKDiieMP4o/qwAnH8tHTM7WH0lSxuQb4WwsxGjKSwXCbXntmK6uloDu77nmAIjcPB9/O9tJ/4gCqaD2s4yBYnwv4sCDvPtfyL0/dgR5XPi5W/xb86phW4HFmSpXSuubsWUZy3w4vqYPuCcolvevrjCc7Sdsw1+55rDspI2VH+6+KJV9ybbnbGJ0SIbBVbw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBzb2NKcmAdOvDygPojtlsUh3/O53VgQNG/xiZjChT4=;
 b=PmW1DcZ1kMFaIfH9KIakIeAfHGk3N8n9BB+0PIbYSV3U9c/NfAsEBy52gpfk1EYwZecg/msu4M0HJ+cJTE7ADGI20Md6QX8NlbnSD+jj8Bk4mKyYmkPJET6pfkmJ/hSaB6+eYbdfe9HBaj2zXiHQWOSDE3wxCiL+9+ZI7FQL3DNygITW3jw5xLuShzHKEoal/YoMABFMzOtnORRwerzmDDH7PEoEwqat1c2HBtbDuUNFoLACJecQpVlVm2f0eIAw2wmFEdHHTiz8fN/HBRRJfR+1qHOzt045rdhGQvKkcRhHS3H1E+jIhsV2WHI5OaYlw2tOtdbpEQ92hTgdWzdcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV3PR11MB8507.namprd11.prod.outlook.com (2603:10b6:408:1b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 10:20:23 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 10:20:16 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Vinschen, Corinna" <vinschen@redhat.com>, "intel-wired-lan@osuosl.org"
	<intel-wired-lan@osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vinschen, Corinna" <vinschen@redhat.com>, Jose Ignacio Tornos Martinez
	<jtornosm@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH net] iavf: iavf_virtchnl_completion:
 drop duplicate ether_addr_equal() test
Thread-Topic: [Intel-wired-lan] [PATCH net] iavf: iavf_virtchnl_completion:
 drop duplicate ether_addr_equal() test
Thread-Index: AQHc0XW24mG2Vt90N0+KDojNIRC2l7XpTYYg
Date: Tue, 21 Apr 2026 10:20:16 +0000
Message-ID: <IA3PR11MB898664A49E614F197D4FED6EE52C2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260421095947.868695-1-vinschen@redhat.com>
In-Reply-To: <20260421095947.868695-1-vinschen@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV3PR11MB8507:EE_
x-ms-office365-filtering-correlation-id: 15fb906f-5e8d-448f-3949-08de9f8f9569
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 7sNsnp38crhKcQyji6rw5tXtORNDAKHjNjh4riJ01eHCLsVcRKnuzTLnOg6WlmeDah5kmwuoyMby7OEQmiOiNKUlRj6ObnQXeWk7QSXu1M/uyYhnAUcpvNlliUmoR5Rl8EQVqe0sxWvkAGb8uOqg8sU/ELbKaPqU5EKUw6NU748EsQg5hejr4iYub9dAlfRBAyS6dHdQHkgU5QPqzYzZU04wXPi2khYbP0H3uh2kPM/2Ba2/v06lgpQqYJaTSa4LkVkQjAgxTC3nihmfUPBTnodjZhFHY2zYqlirIM9ojD5apJ0Ni89u3sNINDV6L/owwLLbrxxtYaFXlrggqHysHYyn7I05I6/Wlyg2lfWrqXXwFLk69IWXMxPTkn1OFxmmP8Hp9X5hH3w6U+BfZJXOLRDuFX6ll7sGouTrVc+0I16fyt2vQGobdVIHBrhUtN0pG16qGIyvbqVCLrR4CmbNXvfqOWVIOPgvbqx6bMw8fVOfuOwc25jvGI9cnrQp1oQVQFLHGQ7OghdrFP6bUZy/RhCqAYTH1mYArjxDIsSvxcjOxzj/4IJZGFk5kW5p/o60olNAi81VILcTspUX5Dh88ehg28CVnUcR2c4VA/7qF9wxyhqakvJDygSmLy7uW5WuRCiCoZFs3z9fe1IcVnaqCQRo1IDnpvnTV7tKgIKgxlGdQ+Yaujv+oklyLzupZ6zN9LHwnAEvdMdXLiLqCfP+mAAVzYE5mu4nO1THp7Q7U9bppH2rJqKpo384/rnYW9qRdkAGxUBTAZVtDbDrKpp9No1N3YfuxBestVkhGivfE88=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GNZqZH+gsD2AzjncrSPF73IXUkEQ4f8F1Z459Gsvi1iKrnw1sx4zzfkO4mdn?=
 =?us-ascii?Q?Lvdn8VpEulLhKczP+Ul6oUS3AzkC/4GmF2x0XgZMIE1fkRHeskTXr9+9exik?=
 =?us-ascii?Q?q5QC0CzrhD5KNHLLPNNIsKCg8AQdazVDvRezCAdsok8PmQuXIFeBLsamlUm6?=
 =?us-ascii?Q?744Q3vxVK+IRNY/lqBHSECgloy4nyvv2ri25819SPD0gXjp3XUnCdWFFvH0F?=
 =?us-ascii?Q?a69cWJDcOgJdVxtGvpfpuWpsXljpqz68AoP1fNBh5c7NipwfEjXJmToOmUFP?=
 =?us-ascii?Q?Ku1izb4uhaPMk4llqsfXPni8Yuo4L4JUwBwMxFBuj8vbMT2+1a+Yd09hkHmT?=
 =?us-ascii?Q?NBUg+7G5lVChnS4ixjY83hWJzofOrKKEcFFNi23OB7zSkSbW1AmAOfZcVQZ5?=
 =?us-ascii?Q?JsrohGn6VbIbE+4DscWVt4dg/imJX9NdF0diKW+QCdBP5edwVYrlE/JsALEd?=
 =?us-ascii?Q?6cW+IqoHqrBy4aqFdmrt0OyTLUlKMJW3TrtkTl7wjY9Fh0KkQ9xm70wHvoVQ?=
 =?us-ascii?Q?WHDTm4MzMqNpkmshARj+4eKywkfjSQ3Omlhdq1LRxabgJhu8NiXSmtzQ1mNq?=
 =?us-ascii?Q?mcOW+W6ZHPbZTiAPPgoNFm9kLgQR3KxESlDU+/hVdtgYcwgcIvkS/9KpHiiD?=
 =?us-ascii?Q?Ih4hHX4rV5UsCoMMDfBCEUtLnSqohImCfKnlmCVWQGFSEeEfepuxaFWQFs2o?=
 =?us-ascii?Q?yh093StE2H95YAwdj807y8UmmCx+ZIjxoXJ1eVrdjflbBzZkWWvtyOAsbQ/y?=
 =?us-ascii?Q?O9aFj+vKu7GBBHmofaE5j3idWIU39GXXiOYTus5rBFuIBvbw3lVQVBNi5WSf?=
 =?us-ascii?Q?fBI72hDXxjVqNqbanPvwxSrtEzGezbP+DpeZ6WRzjKXioXoDPJ7D27goix9m?=
 =?us-ascii?Q?TksEbigHOwrY0RlWArETvQWvkxruSYnf53mPKpayPgfZyv6//W2sBXbAb6kH?=
 =?us-ascii?Q?pSIctY2lO/0AfB8xBCyERR4yVrNlvv+AxrYTC/n11KHun8qfqFjtVEnHQIUK?=
 =?us-ascii?Q?hWKdRAUW0hPeSEBPanub4KD76XBKLrGdjsHzAYWDH5iJo/y4QRyLI04x/TTD?=
 =?us-ascii?Q?J0MhLhUKi5/owaJMUlE5iKvAZu+zHHsOWKdgb1SH7APntU3V5x+hymJ+OlHT?=
 =?us-ascii?Q?aF8Oata4V51VYZeHOEzOHHhZL2GxNutjHxP7+EUBBzTA6Zf1u+Rejh72SM+w?=
 =?us-ascii?Q?ceo9NbgnoLdlAkk9KyWzDOTjwmh++YvrYPlCjsLuQTbS5PUQ7dCmYvA/q38Y?=
 =?us-ascii?Q?GYThttp5PDv6MYQ4nbYIgQ/gxt6BJLzyIksArT1gbvqSRLJxwWORiLqOzQ6I?=
 =?us-ascii?Q?PVWyVtP9w1y8Thj3v1YgW4f/7twp5I/gZ6M8HPUAL2he0iqe+GSnQXB7NzOE?=
 =?us-ascii?Q?aCsR79GOHlA2mQ878PDVAJFgG5+YlV35Dqeaclayz+DLpUbX6y/uFiK9Y3tW?=
 =?us-ascii?Q?KmBzHGNbggMGSUYz0TreyJJSFX66Bu9Hapl81VnBM4GPjvcypLGaFBn6iXgW?=
 =?us-ascii?Q?Xz2goA7e0RdJ0cOfAMVLJu3ISsi+RtaCHolaAkYBQJR/T5N3M/COeNENfp5h?=
 =?us-ascii?Q?oMr+cluvhUfKwduP9i7b9BDRTOrreXyrXm10fB+tC8YJ7oxb1zdt0BC+v8mo?=
 =?us-ascii?Q?Gg/IV20WA6Ox++lRbDlQ2YHrMT/pTiCZi3HYFT4kRPcepyYtPX1NYFzHcaxx?=
 =?us-ascii?Q?tG13zvN+1e1xD2kB7mcVWvN3PBSGAZ6tF9FyQ/313X7n7qbcRDTDfZHxbeHz?=
 =?us-ascii?Q?uRBJUub7ci1iBMASzlzoMaE8rC0yWdk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ToBk/pPuNtd8yjJpF0LE2GxjNZlCwXLVIT8WAFgt/eqitBqmVQUk1EWMyoZnt+zUhzle9Oow5Sb1cqF+vMe6bex8deO3Azw2juTpIPBP3f9TAcI400SFvv53nAHPS3LPzYsOtdE6RaMKBn9E63CqQpmr4IVgTVXmzLCfVR6QWfYwuns2Dq6nEqZ6PMKPFFZXpor2yyN8mHN9kRaEFIUEdrJMrZqPnOJqUjUslkfKlU00iuh9tydFpPuf9MayQdLfwFTo7N9FoEb03YtdQUo0KfbxZsU9LYDaQ6YywMJTUXdY/sr/Gg4+HMHCl3jGNH1AdHBz4+HAufjAci5R5FVINA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fb906f-5e8d-448f-3949-08de9f8f9569
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 10:20:16.8795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: INILZu4+BFAHDyWOlhF7wQ87s9u6b82c1qm86TAYfYfqfAg3rXF5mTtGVfww0v5ovMFKgFilHA1CzHDh9szckDmu26e+VLsKMW5Cx3V1vnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8507
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280071-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 89AA84396DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Corinna Vinschen
> Sent: Tuesday, April 21, 2026 12:00 PM
> To: intel-wired-lan@osuosl.org; netdev@vger.kernel.org
> Cc: Vinschen, Corinna <vinschen@redhat.com>; Jose Ignacio Tornos
> Martinez <jtornosm@redhat.com>
> Subject: [Intel-wired-lan] [PATCH net] iavf: iavf_virtchnl_completion:
> drop duplicate ether_addr_equal() test
>=20
> This is just a simple cleanup fix.  Commit 35a2443d0910f ("iavf: Add
> waiting for response from PF in set mac") introduced a duplicate
> ether_addr_equal() check, so the current code tests the new MAC twice
> against the former MAC.
>=20
> Remove the outer ether_addr_equal() test, remnant of commit
> c5c922b3e09b
> ("iavf: fix MAC address setting for VFs when filter is rejected")
>=20
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> Fixes: 35a2443d0910f ("iavf: Add waiting for response from PF in set
> mac")

I think Cc: stable@vger.kernel.org should be added.
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index a52c100dcbc5..9b8e7e4376c2 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -2579,13 +2579,11 @@ void iavf_virtchnl_completion(struct
> iavf_adapter *adapter,
>  	case VIRTCHNL_OP_ADD_ETH_ADDR:
>  		if (!v_retval)
>  			iavf_mac_add_ok(adapter);
> -		if (!ether_addr_equal(netdev->dev_addr, adapter-
> >hw.mac.addr))
> -			if (!ether_addr_equal(netdev->dev_addr,
> -					      adapter->hw.mac.addr)) {
> -				netif_addr_lock_bh(netdev);
> -				eth_hw_addr_set(netdev, adapter-
> >hw.mac.addr);
> -				netif_addr_unlock_bh(netdev);
> -			}
> +		if (!ether_addr_equal(netdev->dev_addr, adapter-
> >hw.mac.addr)) {
> +			netif_addr_lock_bh(netdev);
> +			eth_hw_addr_set(netdev, adapter->hw.mac.addr);
> +			netif_addr_unlock_bh(netdev);
> +		}
>  		wake_up(&adapter->vc_waitqueue);
>  		break;
>  	case VIRTCHNL_OP_GET_STATS: {
> --
> 2.53.0


