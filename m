Return-Path: <netdev+bounces-241463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE4DC841D0
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4B144E6393
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5C42FDC26;
	Tue, 25 Nov 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fIUDz9M9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A322D8390;
	Tue, 25 Nov 2025 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061199; cv=fail; b=tcmpJWK5v9/uq/0idFj+9UKGwYNTxKPlWCd8zB79TO82ooOXOT1fZNwskAB/uCkElNZ9ld14HWA16bvT6hNdknO9+MttEQffPZjQEJo/yJM5FwS19NrThB7mmIP43oDtmQC9t/nz4UjK/e7TRCF5+J9wpx18MOybCwTtNMkvhgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061199; c=relaxed/simple;
	bh=DaGcrbZYYr509rHdhFOArBTv9gRkgczMOEZ4arEI6MY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YA1zBtt4zxUOx24s09O5z82bo+56xMfM3LH+xqZ5rJJFH5AK0PFkUCKsaoo9wpz39UGAJP2WSYWuPDf8DxSskKgDFvrGF1pkcSJxHiSCG0TXdNrUbZWP3qClcFLCrD5rV/ISFVK+a+K1xzLxvs8qbNQeGfF4gi5bC3gDRzUe6N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fIUDz9M9; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764061198; x=1795597198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DaGcrbZYYr509rHdhFOArBTv9gRkgczMOEZ4arEI6MY=;
  b=fIUDz9M9fJgxTMFRYXWKB2DynDgQsVEDNSuxwFb57J4wvHh3UC+be1iH
   ifpxxofLR1LzZGahrFTP1HvZoMwN21SVIxixEYTyf+zXdQSnbIGmd0Y2P
   8QiAypYUzBRBtNIx1O/uCu3XlxZclln0rYCdaSdLR1EV3tHNw18L7Pksh
   689sk3OKHrHGlxPziAbt9tyjkvRQeoYNo4qIPJROE7RzWC5nU4pq9J3dQ
   t31HRrVuB7Xa39vHUj0HCLH5Cp1ilAxIOBitjn4vfuJeC5d7jvh3/MHLQ
   mtMMeFZFyRZKUT5Fb+RuEKJUs+xzH3VQxJrPnYDr7iS36pNoF7gAXCh63
   g==;
X-CSE-ConnectionGUID: GSrktvrgRuiOJ9tufRC86g==
X-CSE-MsgGUID: yoiG/5qqQzeg/kYnEo726g==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77550309"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="77550309"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 00:59:58 -0800
X-CSE-ConnectionGUID: DcNSi4+CSd+KumD/ip1IIw==
X-CSE-MsgGUID: BIioX0cERY2RLOCGtIoqRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="196754012"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 00:59:57 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 00:59:56 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 00:59:56 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 00:59:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZKMR0RB0eG27r0ZjDoGAcOzn7hv1nQFQ0pv8YSQ49BLGilRvj96A2RryFsKz39RjC8zY2ed0F77PNYsKMCuBtCsbA0FgditdUOgOk5KzjifGBdVMQdOpOc1USkvZK98Kq2k8WXbnj7fbsBwTA650FMjmi5PQUKVSK5q3p0/tatjQe/XXWXeZbCNQ5Z6VtbYnxOhb1mOY5BSOrYrOH9Czb4kKsMUtrnmwGhKD1PYydfGfqiPMnXPSpzXkT5LUY/HODJ4aJa4z0/qzFQlN48NVQwu4aYwBp9BAeAiDuN+UtUaYCYVd2sBtClAj1D2WzCpfcZhzfA5sk1pdfSIMeij+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaGcrbZYYr509rHdhFOArBTv9gRkgczMOEZ4arEI6MY=;
 b=M1yaf2JgGsjTINqqQBo0nyS7uyDEWqtgolj63MDH1W0Mcc81fEzLoNIzePZ7PdUcvHT6ruFTeiv841VkeSZEGwE4ARKH3tqXsUpJTeGGQ0HvwAdtnE5jqfnwOYea0+A8N0V/Nx7Y7kREaq7+Kofrzj1Z8nEsDhLb1R51xWnSyCQkLQZRYXBcNcpi/yS1/B5vONkHKbuUeArbCwh1kBu2TWQKZxKYDM9Y04wQ+BlB8HQ/wC5TSKyJsVkLzsZX+J/oX9FAmUWppybV780YzjYIRAO0BzcJzxwhWP5KTC6IHstm/DG4oVhtIaKnY6BSNicBulaxZgTrhDtuDBPuuTY/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB8017.namprd11.prod.outlook.com (2603:10b6:8:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 08:59:49 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 08:59:49 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Slepecki, Jakub" <jakub.slepecki@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>
Subject: RE: [PATCH iwl-next v2 4/8] ice: allow overriding lan_en, lb_en in
 switch
Thread-Topic: [PATCH iwl-next v2 4/8] ice: allow overriding lan_en, lb_en in
 switch
Thread-Index: AQHcXeZwbpNedV2ucE6J9CkWSpqhJ7UDFwQQ
Date: Tue, 25 Nov 2025 08:59:49 +0000
Message-ID: <IA3PR11MB8986E6C10E42C5DD6DC717B9E5D1A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251125083456.28822-1-jakub.slepecki@intel.com>
 <20251125083456.28822-5-jakub.slepecki@intel.com>
In-Reply-To: <20251125083456.28822-5-jakub.slepecki@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB8017:EE_
x-ms-office365-filtering-correlation-id: d2d63be8-e49c-48a8-67c8-08de2c00fd85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?M1FwQ0p2bjRNSW5URnZtQTNvK2tjTmVvRW54VEYxMFlnRHR0d0xWcmJXMG5y?=
 =?utf-8?B?U0crOUxIUUpxNFZXVnpjdm5YV21DQml6YUUycFQ5WXlQdU5SZFVaSENKUkZG?=
 =?utf-8?B?dzhlYmdPMFRnQ3RZcU55UGd3dkQzNmdhWlpYbXNTa0U4RFAwU1lBemlNcW1U?=
 =?utf-8?B?MFVkUU9NZDR2NXhTcW11VEVHZVNRb0RLa2h4UEdYdjNXOUF5UEh6RDR4a2pi?=
 =?utf-8?B?RnJseTRreE1XNWZFRmVzcTVld2lWY1E3MitlVzAyNGpZeThKOGc3Umd4eGVv?=
 =?utf-8?B?cStLVmNTdmN1SmdCdHVkYnhsU1FXNlRBbUR0b21kbkcxa0Z3am5YSFRsQTg2?=
 =?utf-8?B?alZ1dFh2TG9MUlczN3h3dUlyN0d6aytzSkd6WW11SmVHWVEzaTZvY3FJYkQy?=
 =?utf-8?B?c1FnRi9UTGpWaWU2d3huRG1DRjJOMS9PaWpFNFJocDFBcmkyZ0huSmJpQWxt?=
 =?utf-8?B?M2tYYUNLb24xWmE4VTRlcDVyd1huWi9YeW5zME10R0xrblh4R3JCYXcwS0tJ?=
 =?utf-8?B?VFJsM3BRYTFVVExjTmV0cDRNdmplNFUxVXhDdHVUcEdQZ3N5MWhRTDh1TThx?=
 =?utf-8?B?cnZCbmpQZWl1YzFEVFlrL040SG9NUm1kRWw5cWEwWUlUdDE3bnhXNVVvTndS?=
 =?utf-8?B?L0FYanZPVUwwT3NNeDhURHdsN3hlMUN0NUQ4UDlrYlRhNVIrNVlPRmRCMEdB?=
 =?utf-8?B?blZHQVQ4QTJuakllZmNDOWtZTzFJY25hVU0zTU9mQ0NvL1YvSnBibktVdTl3?=
 =?utf-8?B?NlB1SnRMZjFKM2hjbUNHRGpmTXBzZzRZdThzZ1VDYWdDNVlqcDZURm1nUG1K?=
 =?utf-8?B?aGFCTGNNK2k4Z1FCZUJGRUhsUXIreXBpbk9MTDgwQ2xuL0hYdWdzNUNEdTVD?=
 =?utf-8?B?SU1xSkpqWHJ2N2R2RDhHdzhmeUxLQmE3RXhXSU92ZzFQQWdGR1VMcGtMaEY3?=
 =?utf-8?B?aDVYWmNwc0ZwaW5nS1pyZUUwODhra3B0ZS9SMGlpN1liUERHN3NOVTFrcHNw?=
 =?utf-8?B?UGJYejdTZWI5Ritzd09QT3ZZV2VLRWZhQnM3L3FkZjRQTVpjU1MwazJ3WjhX?=
 =?utf-8?B?YSt2eEcwK1NPNHd2N0U4WlZQOUpnd1RLWGtOdnhwL3ZJVEhlNEF6V0FDTk1k?=
 =?utf-8?B?WkpIbXlMSTNCV2laS0FHN2hOUFdwNXJhM2dvSTQwNWNuMEYxSGJiTFJFRktL?=
 =?utf-8?B?VitobVNPRmZBWGVPUklYSFphemNpcnpFbC9wQklvWGFMRnU5d28xTVZWQ0pU?=
 =?utf-8?B?Unhac09Cb2VlZW83YldDSklXMHVkVHExb0xlSHZkQVYyaWEzTzdjM3ZlNmg0?=
 =?utf-8?B?eXJyRkpvTnk5MTlUK3R1TmpHa3NnV2dLdFFETXBSdGNRZ3h6a3F5dUNkVnND?=
 =?utf-8?B?N0lkQWJFbEJHWlZsU0FKZTJLajVOUE1takhtRzVmTy9XdHZBS2Y3bDdVWU9C?=
 =?utf-8?B?MmhNdytFUlFkazlwcnJ6ZXByaTZiUnJRRFZJTXFWNkRBZmpuelYwUVVMNXBU?=
 =?utf-8?B?SGlrL2JPclVldWJ3M3JTRC9Ua3lqd2V2RDVHTnc5NkNNaXJNZDArQzBGcFBT?=
 =?utf-8?B?MUZHM3JhaHNsVzF6c2crS3liNDRCaE84bVVsdnpjWGlwS0RBYkVWVGExN2Vl?=
 =?utf-8?B?Tlk5RzRadlhHelpwWUtoWXZ2UWRWaGxSL0dIcHVFVlRTdVFLT3hoK1QwcnEw?=
 =?utf-8?B?ZmU3M2t5dTg1anMrdmozZTZQeERnRzBjWXZxdmVPR3VmWWljREdUTFZIM2ND?=
 =?utf-8?B?dnI2SHorNFkzZElIU0lidTZJRFh1Mm55OEtueEtTVmdWSDBxR2pPU0w3dmZY?=
 =?utf-8?B?MGU2eGN5TU5zVnJ5RkVTM2NRaUxxVnJHMWxEL2xFcEk3VHB5MjBINTdLa3hV?=
 =?utf-8?B?cmhUS0FZN2NwUXpydGN0TkxxMkg0RlpFbnFXclJLY2JsdjZZbERGRURrV3Z6?=
 =?utf-8?B?d0h0TzJtUHRqU09GZmtUVEJLTVVkdzJLZHBwTkw5Y29wVTVnUDVGTzBLVm83?=
 =?utf-8?B?VDlKSWdrdk11QzhVNDJUWkJiWmZUdDJQM0NNUkxOelhZMlA3WXpSdzRGWjdL?=
 =?utf-8?Q?NW8ef8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1FKK2VSL1ZHTnVlSmtuM3VQbWZaTmdTekpPWDFvTDUwMXhZSFBqUDQwOS9B?=
 =?utf-8?B?V1BLejh0UEozUmZQZWF3SzZjSFNINXl0QlRZcFhlUGV6cWNBZ2ZXWGVXWTdC?=
 =?utf-8?B?SklNWlprb0Y4UWYzNEd3WU1sZVo0NHB6c2Nadk9pck5YYVo2TU9FZ0pYZEdp?=
 =?utf-8?B?WmV0eG95b0hhdUFOa3pLZDdRSExCUlNrWDNwaHFVdXF5LzVtdDNCeGl0SjZV?=
 =?utf-8?B?RnYxUzBBZUdmRGJiNFJkbFJzdFUzR25HWkd1Rzk5alpJSitjc2pSZFN1UGRm?=
 =?utf-8?B?S09PQ2drZWwrK1dHamg4akFCVndDMkV6WUNCdzNlTlRHdEZUdmQrQmFMelNH?=
 =?utf-8?B?WVdZSUFlV3o3V1dnVnRDajA3R1NxeE5kVXhYSDNzckZ2dzhvVVppMmJOb0Ny?=
 =?utf-8?B?YmpZRm1WenNHNCtSNHRudzFuRHVMOCtJV1BVNGQrYzgwM2czdUhRaW1oZTdJ?=
 =?utf-8?B?UTJza3I4QzZxaDM5NnljTHNhbndNZklkOXlTM21jZmp4MTc1MzIyNkN6T0Nq?=
 =?utf-8?B?eEVXajQxaS85RjJwTEhvQUluYjhaa25uMkVrcXFUcTZjeWg3c1M5clkzb1FN?=
 =?utf-8?B?YnJBK3FGR25qZGFMejdFWVd4N0o5a0ZVNzRFQXhtWm5WZ09wenV3b3M1UDlq?=
 =?utf-8?B?UnVuQ25ydjBobzFZSDdaWkJLRHZ3aDJ1MU9BQXB5ZC84d2FPTitJa2Ird0g1?=
 =?utf-8?B?eWpBa1ZsYzQ3L1VyREJnbEVXcXhrcUNQM1lPWEY2NEZoaGpiWG8vUWdJQ3gz?=
 =?utf-8?B?ZXU4Mk9zbTZ1dlUwSm9vdXB4Vm1QNHY3VVFzQUxuakR4amhaaUgxWk91RlNa?=
 =?utf-8?B?cG1qek9wU3hxMXFkb1creE1QK2ZMS1hUNzZFSEZIcFNIRFcwVWl6Ym9MR2Y1?=
 =?utf-8?B?MEx6YmZueWxuTzB2M1JjMGhYZEZwbE1NN3Q0SlNVKzFhUjJBYVdwQTNRSnVk?=
 =?utf-8?B?KzNTVUVJRzA0V3ZvS0M4UHg1ZHNPK3k0R0VFSTdKM1YzUVNLd0s0NmpsaE8x?=
 =?utf-8?B?aXVYSThTNmJOVWVYNVU2dFVEbklUTSt0Y0dscW1jbGN5YVVlanREdzdIQm80?=
 =?utf-8?B?Mm5wVy9Mc0Q2TyswTGVYMkZNc25EOXdENWZNWEJFSXZGQ2RrQXVPL29MQ1Fl?=
 =?utf-8?B?OEQ4WVBlZnZVakx6Y2JuOVJRQ1cwcitTWHJYZCtSNXczbEtnbjFzYXNtVlFG?=
 =?utf-8?B?WlcyZmE0MzZZN3pPRGwySU84bHFqVURrWGpVNEd4ZzAzR1FyMUlrTW1pVnFX?=
 =?utf-8?B?MDJWNnpabHlrNFJSaHRhaFRKeWZFSVpsRWh3TUNCWHJCbXBDWENDdWNhcU1T?=
 =?utf-8?B?b3NSRUNhc1pHaitkZGpaVGVERXJsTkNLdkY3cFB3Wm9US3hMM3RUYUFjVnp2?=
 =?utf-8?B?UFo4eFZld2ZGWFBVaDQ5RnQwSkdTRWE2clVwcnQvOUNETHVxN1FCZG9VUWg4?=
 =?utf-8?B?S1k4b0d6eDY0bVorVlk5UWR3WUIvZys2aGpRYnB1bTROR01qQUZKbm1uWllB?=
 =?utf-8?B?QXdseEhBQ21sTWRjZTV6RHM3SXBqMDVFRGdneWt3SDhIY3NrSzRkdjNzR2l0?=
 =?utf-8?B?ZmJxeGhaYkczdU5PSlJXMzQwTHYzL0MzeVFuZ3U5TXptMjVHOERKVEdLOVM0?=
 =?utf-8?B?NGV6bFBoVktkQlJ3UUg2aGdqUjdSclFYdkNpRzhaU3hicXlycDhvNk5KSjFy?=
 =?utf-8?B?U1J0ZCtONjYxVitVTTVMSnZ2WkhTdWM2VW5tS25LUS8zOUJ0UCtUTDV4aHlr?=
 =?utf-8?B?MHN2VWFtc2kwMk4ySmM5bjVRREpUV0FPSzZVTk5pWEo4c01ESlNWcUxVbk1X?=
 =?utf-8?B?V1hhZVhub2hWUTljZWN3WmtieUVzbHc4WGI3bmtrYlg1amdyVEJKWUdKWUFR?=
 =?utf-8?B?M2JyRngwVVhmVWJVUkZmREIvd0hvQnZiN2xBQnVHU2p3Ky8ySCtvak1qaHgr?=
 =?utf-8?B?WnY2YnE2Q2pIWEd5VDJsVURYdHE2R3pLOUI0YlFQeUQxQ295cThUVGVEYWl5?=
 =?utf-8?B?SkpoUXI5aUx3QUtYcExRdWRZOXkrUkJoTzhjVXNKazlMRUM0OFpjUnFZTzZk?=
 =?utf-8?B?b1dOSlRYQWpYTmR0WU10ZUNQYmpxc0FlYXRMbk44TjYyQWFZRHIrMTRUdlVV?=
 =?utf-8?B?RTdpb2toTjBEQVFUQ01HRFlWNEJlL1lsSHRqT2d0UHExejVNVnVROHE4ejhL?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d63be8-e49c-48a8-67c8-08de2c00fd85
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 08:59:49.7631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yjp7B5ShfVFyTicZDQqtuSK3DR6RKtilf8MQ/OcQawtvPJo5mDB3lSDr1DDtYj6NA6g5wtHjHHOGqpjsB0hFOSmcKZNZ8sCEgzGII3GTXjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8017
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2xlcGVja2ksIEpha3Vi
IDxqYWt1Yi5zbGVwZWNraUBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDI1
LCAyMDI1IDk6MzUgQU0NCj4gVG86IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+
IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
OyBLaXRzemVsLA0KPiBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsg
Tmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgbWljaGFs
LnN3aWF0a293c2tpQGxpbnV4LmludGVsLmNvbTsgU2xlcGVja2ksDQo+IEpha3ViIDxqYWt1Yi5z
bGVwZWNraUBpbnRlbC5jb20+OyBMb2t0aW9ub3YsIEFsZWtzYW5kcg0KPiA8YWxla3NhbmRyLmxv
a3Rpb25vdkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCBpd2wtbmV4dCB2MiA0LzhdIGlj
ZTogYWxsb3cgb3ZlcnJpZGluZyBsYW5fZW4sIGxiX2VuIGluDQo+IHN3aXRjaA0KPiANCj4gQ3Vy
cmVudGx5LCBsYW5fZW4gYW5kIGxiX2VuIGFyZSBkZXRlcm1pbmVkIGJhc2VkIG9uIHN3aXRjaGlu
ZyBtb2RlLA0KPiBkZXN0aW5hdGlvbiBNQUMsIGFuZCB0aGUgbG9va3VwIHR5cGUsIGFjdGlvbiB0
eXBlIGFuZCBmbGFncyBvZiB0aGUgcnVsZSBpbg0KPiBxdWVzdGlvbi4gIFRoaXMgZ2l2ZXMgbGl0
dGxlIHRvIG5vIG9wdGlvbnMgZm9yIHRoZSB1c2VyIChzdWNoIGFzDQo+IGljZV9mbHRyLmMpIHRv
IGVuZm9yY2UgcnVsZXMgdG8gYmVoYXZlIGluIGEgc3BlY2lmaWMgd2F5Lg0KPiANCj4gU3VjaCBm
dW5jdGlvbmFsaXR5IGlzIG5lZWRlZCB0byB3b3JrIHdpdGggcGFpcnMgb2YgcnVsZXMsIGZvciBl
eGFtcGxlLCB3aGVuDQo+IGhhbmRsaW5nIE1BQyBmb3J3YXJkIHRvIExBTiB0b2dldGhlciB3aXRo
IE1BQyxWTEFOIGZvcndhcmQgdG8gbG9vcGJhY2sgcnVsZXMNCj4gcGFpci4gIFRoaXMgY2FzZSBj
b3VsZCBub3QgYmUgZWFzaWx5IGRlZHVjZWQgaW4gYSBjb250ZXh0IG9mIGEgc2luZ2xlIGZpbHRl
cg0KPiB3aXRob3V0IGFkZGluZyBhIHNwZWNpYWxpemVkIGZsYWcuDQo+IA0KPiBJbnN0ZWFkIG9m
IGFkZGluZyBhIHNwZWNpYWxpemVkIGZsYWcgdG8gbWFyayBzcGVjaWFsIHNjZW5hcmlvIHJ1bGVz
LCB3ZSBhZGQNCj4gYSBzbGlnaHRseSBtb3JlIGdlbmVyaWMgZmxhZyB0byB0aGUgbGFuX2VuIGFu
ZCBsYl9lbiB0aGVtc2VsdmVzIGZvciB0aGUNCj4gaWNlX2ZsdHIuYyB0byByZXF1ZXN0IHNwZWNp
ZmljIGRlc3RpbmF0aW9uIGZsYWdzIGxhdGVyIG9uLCBmb3IgZXhhbXBsZSwgdG8NCj4gb3ZlcnJp
ZGUgdmFsdWU6DQo+IA0KPiAgICAgc3RydWN0IGljZV9mbHRyX2luZm8gZmk7DQo+ICAgICBmaS5s
Yl9lbiA9IElDRV9GTFRSX0lORk9fTEJfTEFOX0ZPUkNFX0VOQUJMRUQ7DQo+ICAgICBmaS5sYW5f
ZW4gPSBJQ0VfRkxUUl9JTkZPX0xCX0xBTl9GT1JDRV9ESVNBQkxFRDsNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEpha3ViIFNsZXBlY2tpIDxqYWt1Yi5zbGVwZWNraUBpbnRlbC5jb20+DQo+IA0KPiAt
LS0NCj4gRHJvcHBpbmcgcmV2aWV3ZWQtYnkgZnJvbSBNaWNoYcWCIGR1ZSB0byBjaGFuZ2VzLg0K
PiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gICAtIFVzZSBGSUVMRF9HRVQgZXQgYWwuIHdoZW4gaGFu
ZGxpbmcgZmkubGJfZW4gYW5kIGZpLmxhbl9lbi4NCj4gICAtIFJlbmFtZSAvTEJfTEFOL3MvX01B
U0svX00vIGJlY2F1c2Ugb25lIG9mIHVzZXMgd291bGQgbmVlZCB0byBicmVhaw0KPiAgICAgbGlu
ZS4NCj4gLS0tDQoNCi4uLg0KIA0KPiAgCWlmIChmaS0+ZmxhZyAmIElDRV9GTFRSX1RYX09OTFkp
DQo+IC0JCWZpLT5sYW5fZW4gPSBmYWxzZTsNCj4gKwkJbGFuX2VuID0gZmFsc2U7DQo+ICsJaWYg
KCFGSUVMRF9HRVQoSUNFX0ZMVFJfSU5GT19MQl9MQU5fRk9SQ0VfTSwgZmktPmxiX2VuKSkNCj4g
KwkJRklFTERfTU9ESUZZKElDRV9GTFRSX0lORk9fTEJfTEFOX1ZBTFVFX00sICZmaS0+bGJfZW4s
DQo+IGxiX2VuKTsNCj4gKwlpZiAoIUZJRUxEX0dFVChJQ0VfRkxUUl9JTkZPX0xCX0xBTl9GT1JD
RV9NLCBmaS0+bGFuX2VuKSkNCj4gKwkJRklFTERfTU9ESUZZKElDRV9GTFRSX0lORk9fTEJfTEFO
X1ZBTFVFX00sICZmaS0+bGFuX2VuLA0KZmktPmxiX2VuIGFuZCBmaS0+bGFuX2VuIGFyZSBkZWNs
YXJlZCBhcyBib29sIGluIHN0cnVjdCBpY2VfZmx0cl9pbmZvLCBidXQgeW91IGFyZSBub3cgdHJl
YXRpbmcgdGhlbSBhcyBiaXRmaWVsZHMgdXNpbmcgRklFTERfR0VUIGFuZCBGSUVMRF9NT0RJRlku
DQoNCkkgcmVhbGl6ZSBpdCBjb3VsZCBiZSBzb21ldGhpbmcgbGlrZToNCnN0cnVjdCBpY2VfZmx0
cl9pbmZvIHsNCiAgICAuLi4NCiAgICB1OCBsYl9sYW5fZmxhZ3M7IC8qIGJpdGZpZWxkOiB2YWx1
ZSArIGZvcmNlICovDQogICAgLi4uDQp9Ow0KI2RlZmluZSBJQ0VfRkxUUl9JTkZPX0xCX0xBTl9W
QUxVRV9NICAgIEJJVCgwKQ0KI2RlZmluZSBJQ0VfRkxUUl9JTkZPX0xCX0xBTl9GT1JDRV9NICAg
IEJJVCgxKQ0KI2RlZmluZSBJQ0VfRkxUUl9JTkZPX0xCX0xBTl9GT1JDRV9FTkFCTEVEIFwNCiAg
ICAoRklFTERfUFJFUF9DT05TVChJQ0VfRkxUUl9JTkZPX0xCX0xBTl9WQUxVRV9NLCAxKSB8IFwN
CiAgICAgRklFTERfUFJFUF9DT05TVChJQ0VfRkxUUl9JTkZPX0xCX0xBTl9GT1JDRV9NLCAxKSkN
CiNkZWZpbmUgSUNFX0ZMVFJfSU5GT19MQl9MQU5fRk9SQ0VfRElTQUJMRUQgXA0KICAgIChGSUVM
RF9QUkVQX0NPTlNUKElDRV9GTFRSX0lORk9fTEJfTEFOX0ZPUkNFX00sIDEpKQ0KDQouLi4NCg==

