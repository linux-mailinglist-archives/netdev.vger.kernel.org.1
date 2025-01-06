Return-Path: <netdev+bounces-155596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A51A0320F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB357A0451
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA6F15886C;
	Mon,  6 Jan 2025 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvvkAVnB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA970811
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736199195; cv=fail; b=ks/A9W6KHg9ZEuGwsgj7ChJv8R6ATw0La3YwEZ83YbK5Z2VayudIf98xZDL4X5lNHU2chsvoFjhuqhPqDHswXbrOuIprFXc5sC4nNwOpniWOt2FLInQ/bU9pxqMyZY7TBhOzgwUvlDvBgY+2fxQRXkexV7uaFbmhp6+RuQZVfG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736199195; c=relaxed/simple;
	bh=zs3w4lW88sh/VhAIshsryVGgpAoGS60CjT5gmzGRGqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NTF/qfXWIP3JfjU8XwqZcYdUd8O9aVCWBN7X9DXT0MJFcJNu8hTHfYtwDphxS/j6w61s6NgWeRPDIReCnDkJ1sbA2tbYKRDJlujbmrFb30pWOIKm2jV5DB6qK61SFFDEM15s5ElR42XshkW+lneM4v0W2LdC/EuLBdP/sIeyqEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvvkAVnB; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736199194; x=1767735194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zs3w4lW88sh/VhAIshsryVGgpAoGS60CjT5gmzGRGqs=;
  b=gvvkAVnBe5sT/+VgY+A+gVC58bnjIO4tZF4h6+XutipaAt2bMyGcwB0g
   uFla+9l2ieLVdSQI+6Y7ujQNb9DdyPIxChDVsl4bJlno9XfomiBJT1vlj
   Wws2xh2R3Eb0LTTtY5+dVqxTJgyJiQAlczrjul3HquSvlZmcT7iLsqQ0E
   avqItzLhDF9O3mW7NWbHrjX0Qum4D00Bj1IbtKb7TXjioyrpd5kRk5AL2
   6RL33Yb5zCsKFnD/DRQuhorrTVVNbhMTQnvxuRZ7LNmbqQvtZs7bT+RWG
   prSSnzHyEyVQ9Khf0E+970oO9l7GeIxgQQ53zwBDgmcZXFVfoAQkDtJ20
   g==;
X-CSE-ConnectionGUID: /LC5V+nMR9yqi720/LM7nA==
X-CSE-MsgGUID: MMVfdMejSPSs/46f7M2oyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="36241832"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="36241832"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 13:33:13 -0800
X-CSE-ConnectionGUID: VjIrjqxgTP6JtLrO8ROc0Q==
X-CSE-MsgGUID: 4j3d7DtVSbKkvf/Ouf4Uaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="102442235"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jan 2025 13:33:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 6 Jan 2025 13:33:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 6 Jan 2025 13:33:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 6 Jan 2025 13:33:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enF938o0m4jTixZ+4Qr0IN+NSpTR1C1NFyGqhykSG25CpWKWxvsf/X9YBrmc/+eS3GTNI1fm7PwliUC5jrQld+n0ZJ5epUIAQnZZ9fYFoU84ZlY6nIdA/HAReh/9gntlaEbbtg/NPh6VsxxarpFv2fO4gFtgVm5/53V9TRRHu3R+HHA8Nl2mXle1R8IDXeDFhPKZUGDQ0KcSnwf9qZESo2IpcB+XLG0sH2LenaDbPDpfDbO1vgBffWyUdTYyElpKW8qLwi0SVRaO0dNk5160gbvKZnQcBYXdts/CvjpGoNww4BmcvJ5wLlftvEOhpeTKg64nw3gHhbugcJBhZJbhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RL6XZhlPd62AX39enbe+ceB/s7gLBOY3t0qTCI18i6c=;
 b=LdnQRm3DtFnNt4z2JMxZxP+9AThSmNc+C+/MVikWfj2F31Z6wq/AlNpmCic58Jz1QeUV4wT4XsIbEjS4HRScZCFc0qoEy0HC2ZMV6BHd647tuA+chptftD5+6l5EHLp4Q1+0l+t/Un5QOXvaAveUptmHkKabB03XIL9iTJ4H6CMWLSuzTYwsUEMXx0jIy++w0I+/7XFvkIJPjVaUyw76Y2+0GyIeZ+FPgde07LJe4pG6Sil9UHs6VqCUXBMZ/+NZN1l8auKaDFIst172x7VLikbk20po6XgWcABh1Bfutc8dMLdvQBPqedwB82W/Ir08Pxur9h3M33wZHumjkV2H7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7193.namprd11.prod.outlook.com (2603:10b6:930:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 21:32:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8314.018; Mon, 6 Jan 2025
 21:32:51 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Shannon Nelson <shannon.nelson@amd.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
CC: "brett.creeley@amd.com" <brett.creeley@amd.com>
Subject: RE: [PATCH net] pds_core: limit loop over fw name list
Thread-Topic: [PATCH net] pds_core: limit loop over fw name list
Thread-Index: AQHbXhkDoxc5VZw/50WBIfdCKxjSXrMKSKZg
Date: Mon, 6 Jan 2025 21:32:51 +0000
Message-ID: <CO1PR11MB5089948E170987010BDA05DCD6102@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250103195147.7408-1-shannon.nelson@amd.com>
In-Reply-To: <20250103195147.7408-1-shannon.nelson@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|CY8PR11MB7193:EE_
x-ms-office365-filtering-correlation-id: 36ccde66-1db8-4bb9-51eb-08dd2e99ac65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5TzWx+6Kn9q5rBPsre92kcmicum/L5Wt1jBijAPKNxmATzAh2zEXoDVGHC4d?=
 =?us-ascii?Q?xMA1xZGNIyjz3qXVVtyFh1aNoFzX+zciUwVXt2MisLLwmujPJbjs1gknjQP1?=
 =?us-ascii?Q?WZJRkLUwDLpCzXeZ/j0ymVCv7bjbYOkxX8NF3/o4Ta47fH2sxH8yKIGDW7kc?=
 =?us-ascii?Q?jgz86O1eXhKwBMDKZyl+lfLrCPrhSI9VcfxdERLzycoQupA49AIatUPN5SDH?=
 =?us-ascii?Q?MBWRfm4PL7686lw2haWmCcpvygXY3DVZRZmRw+WWUTROjLwdwH5CkSwbxZpK?=
 =?us-ascii?Q?jqQq/Vk7IMbpKgVQI3WC/SIZaEaNzFZPxLuMNWszHwRZMTpMT2X4Xp3DLIjU?=
 =?us-ascii?Q?0iVlWScAL3SkIDkmjjy77uLuFzcc/i9YiB8MDDY++KV97IWMPgD7k1dN5POX?=
 =?us-ascii?Q?NKQIJj8ANHf7udObYtjpY35AsJGVpOet4YYjbLlaMun+wVLagtiRiA26CsA+?=
 =?us-ascii?Q?dSBdC3NNnchJcfVpLmazpbcs0eAqYvqQgbH1BIOe6tN8UVR+A9nuhQ9iqxvx?=
 =?us-ascii?Q?rBYPUxHDc8yPvkAPonYJh48l1LOyfiAyEZm5nupLT602W/HpyN+Fd9Rk9ykD?=
 =?us-ascii?Q?8XHTrYUMoSk4jrAbrKbiiNODE5qKWlnhkliS32hQZAu3Wzpas7kU+bdvONsW?=
 =?us-ascii?Q?cF4sd5c9ksNqFKdTxg3DTu281OmSqwRE1R5Omv4MZ+OJommqj7FcuxzApv6i?=
 =?us-ascii?Q?S1pg7pbHS50fXgaIxBOMWq/74a+pI1XMznlyaDjzCpON26yVYiJ6MxIMRfjJ?=
 =?us-ascii?Q?vN2Rao/euIbkV58e+w0RazYzICs9xL/kLJPebO/VL+UBFyUzEc6jwfcIjsRQ?=
 =?us-ascii?Q?awWIcnjKNUoxd8icnJ6XQZmFr6uOIbUDa+6zcBwVnr/ps3NbzhBd2SFQn0jF?=
 =?us-ascii?Q?Vk2g+dkx+fMDYd2bHVjAmdh6QjOVtHsclF7Z2a/h6Hegot7+GbEY6/YvShO6?=
 =?us-ascii?Q?EyQrhTUas9hJlQ6HZkeE1mQ2N77KM1b1hK+0AldsQkqAw/rhHdloKw5JqJuj?=
 =?us-ascii?Q?P03PXpdlNlQsQ8S5cbIkgXyvE+t2lAA6mvVyXy2FG54Tc4lHimgvaynx9/aO?=
 =?us-ascii?Q?2KCr2Ba6iacXTX6zLSbUoG5feJmM+EXypfE0MM4Arh2BnEcr2wnxnm133BEd?=
 =?us-ascii?Q?6NX9yVQ+/GhfN2uqULcAbMGS+bA+DCqF2QcyBJth/LXSuW6suwetQA8eQm88?=
 =?us-ascii?Q?j8uUWq4Pqm0ePwoKJvZWSjOe/8A8ScHypnWpymsiEd4GzdwN5DY2mR1t9WIA?=
 =?us-ascii?Q?IUA+m1VUUH98aggViRyShg49d+uFUwP9/FlhjdC2QLknAFuKoLOTAaKkSeqV?=
 =?us-ascii?Q?FJseLgc4EP0wcpKD1tAVfgrAnoKweBjhumqXB9n4NtWbKR8FMMOT+b8Pggq9?=
 =?us-ascii?Q?Vpne+ScJdo20dWYGdJ7a9dFUsg2IZtjR3PpXzkGm3WOhoL06SJ/AhRiumwos?=
 =?us-ascii?Q?C/W5vSrmcbA35+QypyI1BwjIa9oJoPrG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ylfBKbfvXG6RarPSqutb6JuvQ5z52lx9shR580U6dq3nppYqBpaRkT5GCkxL?=
 =?us-ascii?Q?s2CwqFfOiJHJqQuwkZaOmbeM4OSzGWi/+vgYdfp5j+Z2I3/G0HFxYXh2zs9S?=
 =?us-ascii?Q?Ymj62izzRWH/IhaQe/jWi0z8jEKpuJmHgx/rZ7rUodKVIQNYPS38xMZyU/3A?=
 =?us-ascii?Q?CD1I3syuHSf4FXcFxPUNQjiKOFD+FqIb4x0gpM5MVNB7lqYN+WTQWFnxkm/z?=
 =?us-ascii?Q?bMJyLcu/TX8PKJh/LUrL6jP6XhVF5XT0oTPJ47AM57hagNueRE1c/RKSwOZt?=
 =?us-ascii?Q?EBnWs3aoJbOsb4EBQuxDP4RDV71uRHhjPjedqy+CgvZIHHuPWH4yE56THkV6?=
 =?us-ascii?Q?lTBkdQFvMsqNvyMD0xhsgFmkGjzHUOyv1UBfhjYw86Uxy3EGmQyJBd2THU5V?=
 =?us-ascii?Q?Iy0F87DLtClptHzv9QIHH2D9B3ZNR6riY4WPHr/AkIRtyKyUqxUXTPBDTswk?=
 =?us-ascii?Q?iaVbV6qa8GiseidXAdY7HfzwjLOPrhNXGLliYplfr+jMtb5NlLfQn3oycKiE?=
 =?us-ascii?Q?Idv/D/dIakQO7Y4sFhH00yNvJSPiVN3bRZoMfR5Z39pGfu6zOwckSX60VYxL?=
 =?us-ascii?Q?0A+q7CnnxWa1tfuLB/LyCInOxB9NIoqkSe0YUfP9Sq8XuHsia6Ofrz1yB3+c?=
 =?us-ascii?Q?7WlxskPEgzBD8WEuD/kkCgzymIJ9o9zwPiFyTRal8B3cVNtLL2dlIsVZufwP?=
 =?us-ascii?Q?zK4VMc1rRlOaW2RNafNRkLBi0yXB7VartnC2trZ9n50TJNfA5LtXvSpEFoRk?=
 =?us-ascii?Q?RkpNnTSy5Q41KHsnQnbFAaVmgxjiwGmPJV+UeT1d2Ylx7smaSEtVorma5UUh?=
 =?us-ascii?Q?vx0L+nWJQWe6xBzOpXXet8ME1+h46WU0IFwmR1RRxdKTaNPQYpL3v+2cN1dZ?=
 =?us-ascii?Q?Zg8FtNqAUH1d7vCQaDMDVF5QXMslgMVzBK5Y41Po7xXqOBNRVpr7zBdiojYt?=
 =?us-ascii?Q?c9srg7jFeSZryOvrWy4ODpOnlqiKF7kl8x7oXv/zOt7Qp3+XM+SJf49sHsWc?=
 =?us-ascii?Q?3QicFeodHZyoaGTWfU5jwQBsC0qAYdLJhEdeNevmg2MFU7bkstq025UFdtsF?=
 =?us-ascii?Q?0qRTmaANVznTxsNFePiYn09hrSLfB5eJYCix/wfZ4+YOFfaAq3BTZbP/T7/L?=
 =?us-ascii?Q?Uqf+clllHnxiRZNuH4XvcA4kprT/P2CBTsmmzwboGxfP8tYJYLubIwMn2Cmb?=
 =?us-ascii?Q?EDxORlzpqaRAG0CKm48153HuOovxUFUWRSPsa14rpDJqh/jorcSbUDSRRqnm?=
 =?us-ascii?Q?MYHonLQPxc1K3x86ahLk5WKYBOTZwMa9wXjoRjFViI1aMCYPzKJ0HioNS95Z?=
 =?us-ascii?Q?gVdRcvPcJPwXvevTiZHBiv8jKqnz+2C415y7/6QL4OT7/87QRzwsQM+mhcef?=
 =?us-ascii?Q?h5n2SAePnhy7cWxsVNQQTieR3xZL0HUjnnrjnaUAT+rtzyt/zT2aOzZ+b/Qc?=
 =?us-ascii?Q?3KEL+33bfMd+GKpbfC9l/j0/88wxVAhsyg9TzoAaVZ+y8bhqAPcZZvLoG0P5?=
 =?us-ascii?Q?MBslVZl33DrMmmGeNnsujEf1j6jcX4wN63CYSlYwCGyieB9IEi6+iRhfYVS1?=
 =?us-ascii?Q?M4ce9h6zfSifuhh8NgXcgzj6imf0i09cGkbDpiTL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ccde66-1db8-4bb9-51eb-08dd2e99ac65
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 21:32:51.3646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: myrhAFPFSiLfWzrO7WjKGflrtCKddu5YlBud8n0dEBaXjSpnhsaBNtQQGIi3oh2kMT9wjg7Vh8D/5BIRJbndfmKmt50gDqdfb7I4jvEZ4MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7193
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Shannon Nelson <shannon.nelson@amd.com>
> Sent: Friday, January 3, 2025 11:52 AM
> To: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org;
> edumazet@google.com; pabeni@redhat.com; andrew+netdev@lunn.ch; Keller,
> Jacob E <jacob.e.keller@intel.com>
> Cc: brett.creeley@amd.com; Shannon Nelson <shannon.nelson@amd.com>
> Subject: [PATCH net] pds_core: limit loop over fw name list
>=20
> Add an array size limit to the for-loop to be sure we don't try
> to reference a fw_version string off the end of the fw info names
> array.  We know that our firmware only has a limited number
> of firmware slot names, but we shouldn't leave this unchecked.
>=20
> Fixes: 45d76f492938 ("pds_core: set up device and adminq")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/amd/pds_core/devlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c
> b/drivers/net/ethernet/amd/pds_core/devlink.c
> index 2681889162a2..44971e71991f 100644
> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
> @@ -118,7 +118,7 @@ int pdsc_dl_info_get(struct devlink *dl, struct
> devlink_info_req *req,
>  	if (err && err !=3D -EIO)
>  		return err;
>=20
> -	listlen =3D fw_list.num_fw_slots;
> +	listlen =3D min(fw_list.num_fw_slots, ARRAY_SIZE(fw_list.fw_names));

I assume num_fw_slots comes from the firmware? Makes sense to ensure we lim=
it in case somehow the value no longer matches in the future.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake


