Return-Path: <netdev+bounces-192709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE814AC0DE7
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494277A35D7
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EF223875D;
	Thu, 22 May 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgbJmUXq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D128841AAC
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923502; cv=fail; b=NUsrGqTSj1dQxZoBwQxCjco4wUPRdi8xidKUBBClBtQvfxbsiE8Q2Jcv4DjZjr2g8CUiK+WlgzclJzwLGol7bERYzbOdQGxKOd11UqpENVzDA72icFapxiS/3XBC4+zdfccfmTufAoEE40niHAcDgFAKOmpdoZkrMpR/5H+2Hlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923502; c=relaxed/simple;
	bh=C2tGqR8M/m9CxFOusVqWnsbJE5F1c+KFuuXTX29UAf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rSkMC/wdfJD45sP5G8V/53u2og6nl+hDEbtrmM1mjAlXU7c25yH0jxaCwYZUaiz0psVV8SxoWaRdN+yz5uak6s3gpZdpZ7OxNpbihjb3J+3lYTsWcwEkt9fikhO0a6y9QYm4cst7CoKRa9Nk1PRPUw/xAgdXDmnuiBvZ6VVDUXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgbJmUXq; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747923501; x=1779459501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C2tGqR8M/m9CxFOusVqWnsbJE5F1c+KFuuXTX29UAf8=;
  b=hgbJmUXqrW/+xzKc2SI3WpYMhgPxhDUHcFDH2E8IM4WxrFAbWrqMsCWd
   IoBxgmRBppQg+LXQ7NWBV+L9dDzuEkM45jNpIfovoSyD8CdSjXfq7A+kp
   wyVVSGAvbzKjQmhJ4g8NLqIdZ+cHJ/sNAJBjmBLb3T/YCsX4E1s2Fgezp
   mmQLfmhPAa6Mn9quP6UeGmcjqcO/hQybzIQUpluilQWo//nJKdgAHtbAY
   7AzJTJBu9zZrkbg1eCP1uXu9ymMQJwsbnVZ7/gjHRHr6lJ/5uLTaK0aak
   QmtbgoHTuL2tYUHSivi1SRRuQM/oXar7N9qzDfBrImJwQ91GvHN7+zSa9
   A==;
X-CSE-ConnectionGUID: vageuDLxQuSt4CLEiV2fKA==
X-CSE-MsgGUID: Ehfpj7VeQhiprj4AI2hfpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50095598"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="50095598"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 07:18:20 -0700
X-CSE-ConnectionGUID: DHMH4aLfTSyrzbiWnSvgrg==
X-CSE-MsgGUID: ulJaL0AKRnCNpis8fJxrbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="141038057"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 07:18:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 07:18:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 07:18:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 07:18:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YI+tYQogLPRm5Zx8UBCVK4WG8xfwLft98x+C/DaF+Pb+lueR1hrZbjjNUGiRdI5nTqHawSQ/oImv+hl1DtyHUYA1jSM2vlmgPM/PjfQaGVPeD81JzhNxddDh7Rz981gDBCSNJOmE/78extxSftv6CxzgUmVlhWJUvZOIMIhhiDmNju/uD57cnVDOLmy/PB1RBfhNG+s0gkUHf9cUIZ0F8Tlx8eYoyKM4e9JIndJnNFp7F6LkM+TKbP5ueHBaA6xxbzFYNtj5qjyEeljEHpmbs6EYK5hFHRDhRpFR88TMrr1Gt7xiUO2mJe+uy725ibs7JFawP6qahDnlq8JrHCca5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2tGqR8M/m9CxFOusVqWnsbJE5F1c+KFuuXTX29UAf8=;
 b=jnI548WDypo/GXOMkR6lEiSryC1QyO0yxLK0YLFMs6pX467GJz4/ItWjsoTNLIyNBfEt2b6UJPDsgP3aUMMoWaXTWMlwg1f4vBgVfYo95gA5/QZXI0G9mCjzW0jFR77ejVBO7XrNpR8xiVNyZXdSX7ESjDI/wW3jGmLuMS+RIIEQ/QwYcit7zjsd1Aq65tDQEAJZhmth9JPlUwxbuKMrIG5wJpacH6SlukaVyv4U1r0RalX2k1eedqVt2qrV3vAVikcFoR/yMtMpbywVp9Fxb64C+7ii5yMMxPt3c5SV3n2+50rgTxX2M3OzuJhaqT+5VtczgClCbDpqGaihbpSMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by LV8PR11MB8698.namprd11.prod.outlook.com (2603:10b6:408:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 14:18:02 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%4]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 14:18:01 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, netdev <netdev@vger.kernel.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Kubiak, Michal"
	<michal.kubiak@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH v4 03/15] ice: fix E825-C TSPLL register
 definitions
Thread-Topic: [Intel-wired-lan] [PATCH v4 03/15] ice: fix E825-C TSPLL
 register definitions
Thread-Index: AQHbuuwR8PbdAEcS/ku6ct2jUTgjI7Pe0lkA
Date: Thu, 22 May 2025 14:18:01 +0000
Message-ID: <IA1PR11MB62419F45C39C48528947652D8B99A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
 <20250501-kk-tspll-improvements-alignment-v4-3-24c83d0ce7a8@intel.com>
In-Reply-To: <20250501-kk-tspll-improvements-alignment-v4-3-24c83d0ce7a8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|LV8PR11MB8698:EE_
x-ms-office365-filtering-correlation-id: 566c798c-f4df-4f94-e5db-08dd993b75fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZWJMY3lIczErTG1La2FMdUpBeHJGWi94TG9XdXJPZ0M3SmV6REN3czhJcy9i?=
 =?utf-8?B?ckhFcFEzNG04RC9kZWttUURjeFBaaHNTeFBiN25nLzU1VllOT0tvQkdEZ2RK?=
 =?utf-8?B?Umh5NnJEb0N2S1lBN25xYjRhWDlmOUxKeFpCR0dwZllNRnJWdWQ0L0dGS29R?=
 =?utf-8?B?TFlSNUVpTFg0dXZvNUFIanRoT1NFOU5GZnY5blNaR1ZRUzVQZ3lHN3A3QkdR?=
 =?utf-8?B?aGxsWVZqSjJjaEwyTFV5NzBycURIOHMzdU1yblllMWdjUXJUZUdXb3RnTHlX?=
 =?utf-8?B?anphaUgzRklpT1R1OFFnb3lZcFhVS2MrcnpjZVczMXVMQVIrMWxhQVNFZTN1?=
 =?utf-8?B?VGVkZW8yWHh1SHdBU0VDVm03WnlwekpBalpRNVgrbUtwd0xJVE9QclJTaWQ3?=
 =?utf-8?B?bStQT3dCdDduQURIV3pKRllDTnl1UlE5QmtiOSs5cnU5WXR3NDFuVnJDZHI5?=
 =?utf-8?B?OE9TRWRkVW5sYWNqbXovSEhCdUdMbVBGQVdrODVETlJma1hzRDA0UG1qZk4y?=
 =?utf-8?B?eG1NY3hncWJYNk00REgwT3JyUXlTOUh2Uk1JWFlKek4vSElmcmNyV1kwQUNu?=
 =?utf-8?B?RmN2dlhDZXB5Z1F4TDJrR0g4amQxcGJPenZXRktoMFg3eWp6dStobmcwNDlO?=
 =?utf-8?B?UWIwZk9qUm8rVTJZZGxJNnVHdVZtK3JnbkVlVTB1ZkFQOUNvd0xCelZBZXZ5?=
 =?utf-8?B?bVJpZXlPZW55VUtzQnNKM0dRY0xDV1NPSjFkTUYwQkJjYTFTNmRscXFrUy91?=
 =?utf-8?B?L2lib0c5YVlvZFdvSUdKblRiaURZTFVzVlQwS2JZVmJpelN0ZVJhbWlzWlRU?=
 =?utf-8?B?WEV0UldQb1YwdXRaRDVINGJrYkhJRXdlTWlKcG1QaXdUT1RIMDFIUFd0T1JB?=
 =?utf-8?B?UXllallXZmFZRXhBTS80NlRnM0NmTitYcGlXd3psNXhjcG5GNUNKa1hKRVFQ?=
 =?utf-8?B?L0xQUmUyaG1Db0tFOVJYS0krMjFPQ0UrR01TTXhvdFRQcUVLM2ozcXNmVzRy?=
 =?utf-8?B?L0tYQVV4TER4RkxpYklFbDJKS1FnK0ZtZDBHdGYzaWI2MXg5cmlWZ2JmRmk1?=
 =?utf-8?B?ODl3SmgwQ0tJV25BYmtnMkdxaVNFK1VUYzB0RmpzQk5Eay80cWI0N2dLNU4v?=
 =?utf-8?B?QUkzN3FvejJMek5kMm4xdU14M0JQUXhsSGx6cmFnRFFtNHZtTkxaT1VHYUcz?=
 =?utf-8?B?bGtLZ0ZjVWhxOTNtWmV3WVZnb3k2VlBsczVjZEZ2SXcwUEdGTjdlbStXUEEx?=
 =?utf-8?B?YUNoUTYwdENiUGRUb3hwSzM4N25aMDFKT1dQNnpYc1E5Wm1PRUE5MWx1TFlX?=
 =?utf-8?B?b1R4bHFnaVlJcjdJN29uMDRPem1pR055eWV0dllYUXVYRkpPcE9vTHRjUm0x?=
 =?utf-8?B?OWcrN2JmamJDaS9WU1JUUFNsdWwvUW9HRnBsYVNMbkNEd3FwY2N1R1cxM01L?=
 =?utf-8?B?Wm53dWdQR1dtbW9vVGltOGpCb2lkNnN2RWlULzhIekdtcEhGSCtkYlVmcW52?=
 =?utf-8?B?ZktsTXdtMGZSTWIxak9GcUNQNUJROUpBWTF1L0tvc25LaUpsN2RPK1liNlZx?=
 =?utf-8?B?MzhDWUl2QWt1aUN4cHJNaHlLSWNMSU1DUDQ2NmdmRHFhOURsdmVhMWtuOXZw?=
 =?utf-8?B?eDVGamczcEdJcXJ6cm5oUktuNldxVXR6UUt4QlR5c2tRS1VPR3MzRlJlNDJP?=
 =?utf-8?B?eVBSYTc5a0d5c3FmR0xmeHROSlZxSVBoSis5UHJQTnNVdGx5M1RDWnBXNmkw?=
 =?utf-8?B?NnZKU1VzT1NTNDFpYXlDblRHUGtnek96VTE1Nm9mb3dyTmdYUzlFL2RjUFov?=
 =?utf-8?B?bjJ5UTN3c25UTjhrZVVTT0RzSU11cVFOaE1ib3kramhMQkJ5Zkg2ZHZsR1d0?=
 =?utf-8?B?OEkwU3VLc2Znb2JMd1FJd2JNVDBvQXAydjhDRHJ2SXNRNWhiTkRJWU8rQ296?=
 =?utf-8?B?ekdrWUJtcWlFcVg1RGw5cE9lN2UzNkJtV0NSbFE3VnQ5NExRV3RRUjRMa0pq?=
 =?utf-8?Q?uOD9DmDs5mLMpZI03t24yKChYffZF0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UStEbDN3Mm45YXlWQXpiYlFMU1ZjTG9YajI5YmxqSWVHakJqcG1nQ1J2b2tv?=
 =?utf-8?B?L0I5OVM0K0tDWXBzMzd5NWpMeU9aUDdqcFp4REJLR2dYZzVTQm12OTVWSU9n?=
 =?utf-8?B?VUtjSWd1ek5IbFpxQXdNYW1MMmhGVXhVUTBLZ3Y0eThoSkhBT1VEWmIwQkIw?=
 =?utf-8?B?VEUxSmpYVXhTY3VUZTAyTU1QWG5meGN2M2dZdUxXK3djdWQ2WUpZRG1kMEhj?=
 =?utf-8?B?dFZQZG1qcWIzek9nbFJ6SUlqYkxJUE94MDFBY0lCWC8rMnhhcDZxNCt2NkZ2?=
 =?utf-8?B?cVlUL2pnVkY1VUtXcFl3TERSeUV0eTVZdWtrWWpyTHFOLy9sU0wrVGo0aDNv?=
 =?utf-8?B?Q09ZMWx3OHVuTnlhc3NhbGtYdXMxR0d2Wk5HTzVIZmZBZXl1VU10VXphQkVP?=
 =?utf-8?B?YlZtb0REeHlEL3NIWW9TMVZncFB6ZnpoaTZvNmJRN3d4TjB6dlRMVCtvZHVs?=
 =?utf-8?B?YWRSb0FNbHoyQWhybzlTRHJCUzR1MFM3RWljZDRmb05pQ3JOeDd4SEg4K2wv?=
 =?utf-8?B?MXBWbVZXTDRraHJob0FvWGtiblZXbG4zSkJ5MWxmYkJrOHlvVTBaTVg2V2s2?=
 =?utf-8?B?Um5mc0pCVkJZQkFtZ1NveEJtK2RJSWFtdzI3cmZqVlJ6QVhsK3kxWkRoanBE?=
 =?utf-8?B?SU02OHN3Z2JUdnlwZmI4QWlZcHFqeFpRUzMwVGRSMmVMT2JrTkJwcW1yQlRL?=
 =?utf-8?B?aEFMQ0FtR1hoeGVvWk0wL3IwMVpmY0ptYWdDSytHVk5BbjRQaHdYTDhEdmJ3?=
 =?utf-8?B?Z1k5ZmdWR2dpNThrMkRwZFZIa0RPYzBBRkk1eVVlMFBnd0ptZWVXL3oxalhL?=
 =?utf-8?B?ak93bEtwQUQrWnBQZUN2RjFUeEprcDJPQ3l1T1BGbTZNVnlUYkJmTlA4ems1?=
 =?utf-8?B?MU1MWXdydjBiTmp1OTdkUHBGNkZadUlMbHZEYi9ITmFXOWRFTzV1eW4ycWFW?=
 =?utf-8?B?SW5YNTJFVWRMZ1pJRzc1WFNOZm15SW42UDdkYlduTVdTWGVHMFpwcTk0QjI3?=
 =?utf-8?B?S2NxRUVpbzRCWXpEZGJibXkwR2lJcDJxUzF4SlBiY2l4enN4N1VMbGJ5U0g2?=
 =?utf-8?B?Ykw1dml1R0xjZE9ZOW85blArYTk3VE5rWkJtQUwrRlRzTndSUnNtVWV3aTIv?=
 =?utf-8?B?YnhNOWZINnVCcE0wZUszbkZFOVpJWlNTejdwVU01emV6OWp2aFFOUXE2SjJW?=
 =?utf-8?B?VlhBQjFqYllSL1lrWHZiVllWbXdVMTdDWTBxdjAvU05KVGtWZ3J5UHJkdG1k?=
 =?utf-8?B?MFgxZ285STVaTHhwdU51OFNHRlMyNjh2TVJGVk5HQjMrdnVVOVVkMlhiRVdy?=
 =?utf-8?B?b0p0ZWMrZmw2TVpWMCtoY05nTFdycnRJbFVBUFhZdStnM2dVVUhvS25aNVEv?=
 =?utf-8?B?KzlrTkFQVDV6b1pFbkNPQ0VnTFdFajY4RXU0ZjFSalZpaWFtV01kcE00SUFr?=
 =?utf-8?B?bmlRckJwZFYyTnY1T1V1eXE0VVd6dGVYbnlQZlR2SEU1a20veEdUSHhYSGdu?=
 =?utf-8?B?NWpjY0RDZWkyOEROa3ViQ2NzTUdNMnZDODBWbXJHZVRsZUo3NWRvaVJGY0s5?=
 =?utf-8?B?SVlySmFUUXBaOE5GMkFIZE15d2pKU1M2ZE5KSVZuaVFhTGJ2bXlKN3Bnbk1s?=
 =?utf-8?B?STVBdzl4eHErZnRqZ0VmRzdKakcrSDJnUWNyK3BMOUdyVlA4MHU2UEhnY1hZ?=
 =?utf-8?B?OFh5NHZiZ0JBZ3VVRHVNRWhjdHNDLzdVMXRrQmJ5UzY5TUQ1WlNua2o1MFpX?=
 =?utf-8?B?WlI5WlFpbURNbnVHYVJpT01VMlhLZ0tnNGlXeGV4WGxNVjZJQjFSS2pBRmgv?=
 =?utf-8?B?dHpRSHUrTUpnM3A1MExZVFZIdVFlY2MyaDdaY25hVGczc3ljWVBzbGg1TndQ?=
 =?utf-8?B?WEFuWFZpMjU0c0pUdm1LWWMwTnIzYkM3M1E0QVYybEVLYVM3cVphT0RGanVD?=
 =?utf-8?B?NVoyK0J6aGRGR2RTK3JzS2ZOSlM1UTdrN0wyRmU1M1NFRnJ2bEd5Q1Z2Nitr?=
 =?utf-8?B?dzVqMFVJbmZUZUJ6QndaSHYvRXc3SFRaaHpKOUVCYkZOcUU4SXlpY1dDM3JF?=
 =?utf-8?B?YkZEVGE4QmFEKzlGbEMvZXhORTJvWlFwWmdiSHNFMXRsakR4SnVQcTFsaVNQ?=
 =?utf-8?Q?EdWWLgz/PltIJfUPFEbwiMlvh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566c798c-f4df-4f94-e5db-08dd993b75fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 14:18:01.7740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rui3x2/NO9sSJ1nMxtMqVFIUeb6kyaPYsBh47bMbA7QWxHDo15NtMs96b8qb087h0mtYqFUEV8VVQniTmGezzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8698
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWNvYiBLZWxs
ZXINCj4gU2VudDogMDIgTWF5IDIwMjUgMDQ6MjQNCj4gVG86IEludGVsIFdpcmVkIExBTiA8aW50
ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9u
eS5sLm5ndXllbkBpbnRlbC5jb20+OyBuZXRkZXYgPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+DQo+
IENjOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IEt1Ymlhaywg
TWljaGFsIDxtaWNoYWwua3ViaWFrQGludGVsLmNvbT47IExva3Rpb25vdiwgQWxla3NhbmRyIDxh
bGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IEtvbGFjaW5za2ksIEthcm9sIDxrYXJvbC5r
b2xhY2luc2tpQGludGVsLmNvbT47IEtpdHN6ZWwsID4gUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5r
aXRzemVsQGludGVsLmNvbT47IE9sZWNoLCBNaWxlbmEgPG1pbGVuYS5vbGVjaEBpbnRlbC5jb20+
OyBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KPiBTdWJqZWN0OiBbSW50ZWwt
d2lyZWQtbGFuXSBbUEFUQ0ggdjQgMDMvMTVdIGljZTogZml4IEU4MjUtQyBUU1BMTCByZWdpc3Rl
ciBkZWZpbml0aW9ucw0KPg0KPiBUaGUgRTgyNS1DIGhhcmR3YXJlIGhhcyBhIHNsaWdodGx5IGRp
ZmZlcmVudCByZWdpc3RlciBsYXlvdXQgZm9yIHJlZ2lzdGVyDQoxOSBvZiB0aGUgQ2xvY2sgR2Vu
ZXJhdGlvbiBVbml0IGFuZCBUU1BMTC4gVGhlIGZiZGl2X2ludGdyIHZhbHVlIGNhbiBiZSAxMCBi
aXRzIHdpZGUuDQo+DQo+IEFkZGl0aW9uYWxseSwgbW9zdCBvZiB0aGUgZmllbGRzIHRoYXQgd2Vy
ZSBpbiByZWdpc3RlciAyNCBhcmUgbWFkZSBhdmFpbGFibGUgaW4gcmVnaXN0ZXIgMjMgaW5zdGVh
ZC4gVGhlIHByb2dyYW1taW5nIGxvZ2ljIGFscmVhZHkgaGFzIGEgY29ycmVjdGVkIGRlZmluaXRp
b24gZm9yIHJlZ2lzdGVyIDIzLCBidXQgaXQgaW5jb3JyZWN0bHkgc3RpbGwgdXNlZCB0aGUgOC1i
aXQgZGVmaW5pdGlvbiBvZiBmYmRpdl9pbnRnci4gVGhpcyByZXN1bHRzIGluIHRydW5jYXRpbmcg
c29tZSBvZiB0aGUgdmFsdWVzIG9mIGZiZGl2X2ludGdyLCBpbmNsdWRpbmcgdGhlIHZhbHVlIHVz
ZWQgZm9yIHRoZSAxNTYuMjVNSHogc2lnbmFsLg0KPg0KPiBUaGUgZHJpdmVyIG9ubHkgdXNlZCBy
ZWdpc3RlciAyNCB0byBvYnRhaW4gdGhlIGVuYWJsZSBzdGF0dXMsIHdoaWNoIHdlIHNob3VsZCBy
ZWFkIGZyb20gcmVnaXN0ZXIgMjMuIFRoaXMgcmVzdWx0cyBpbiBhbiBpbmNvcnJlY3Qgb3V0cHV0
IGZvciB0aGUgbG9nIG1lc3NhZ2VzLCBidXQgZG9lcyBub3QgY2hhbmdlIGFueSBmdW5jdGlvbmFs
aXR5IGJlc2lkZXMgZGlzYWJsZWQtYnktZGVmYXVsdCBkeW5hbWljIGRlYnVnIG1lc3NhZ2VzLg0K
Pg0KPiBGaXggdGhlIHJlZ2lzdGVyIGRlZmluaXRpb25zLCBhbmQgYWRqdXN0IHRoZSBjb2RlIHRv
IHByb3Blcmx5IHJlZmxlY3QgdGhlIGVuYWJsZS9kaXNhYmxlIHN0YXR1cyBpbiB0aGUgbG9nIG1l
c3NhZ2VzLg0KPg0KPiBDby1kZXZlbG9wZWQtYnk6IEthcm9sIEtvbGFjaW5za2kgPGthcm9sLmtv
bGFjaW5za2lAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBLYXJvbCBLb2xhY2luc2tpIDxr
YXJvbC5rb2xhY2luc2tpQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmFjb2IgS2VsbGVy
IDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IC0tLQ0KPiBkcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX2NvbW1vbi5oIHwgMTcgKysrKysrKysrKysrKysrKy0gIGRyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfdHNwbGwuYyAgfCAxNyArKysrKysrLS0tLS0tLS0t
LQ0KPiAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0K
Pg0KDQpUZXN0ZWQtYnk6IFJpbml0aGEgUyA8c3gucmluaXRoYUBpbnRlbC5jb20+IChBIENvbnRp
bmdlbnQgd29ya2VyIGF0IEludGVsKQ0K

