Return-Path: <netdev+bounces-293072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL0fAFRnGWrZwAgAu9opvQ
	(envelope-from <netdev+bounces-293072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:15:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7756F6009AB
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1E683037F58
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A963403E3;
	Fri, 29 May 2026 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kpz/RWfl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5E20D4FF;
	Fri, 29 May 2026 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049610; cv=fail; b=S+5++hglNavCvRLcwxzOTJ0W13ldX8djdZjsrco/TIcYBCnI4+J6Qnv0hrTyL4ruL+NPlbVFcIltnaCEsQ4KvDj47ZUPCXDJ5TxoxxXDKVzusm+uEWDz5F5iiiP1qJaF8azqL1TTl/X/DJqtRGH1rQoZHk1VvyLR7NgPlYs0XZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049610; c=relaxed/simple;
	bh=38RT+jl4Vi2w1NruZP1KpBcJPTKJ/XW8Rj2JE16A6K4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AEE6ucY7X0yzmDgwS+X134FOD/qIBi0/OxXcWaUU1VKUX8Rgy5NRvFcbpHwlM1aTNtv+tYJtwl447RdI9alHoSdNHq07UlZxLfDMjDjx4e4JN4I4D9gRaCcPvny3rZsMeJgajfzFH2KxQgtXwmK53GBTkt8VKJjuHi4LNkGhPRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kpz/RWfl; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780049609; x=1811585609;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=38RT+jl4Vi2w1NruZP1KpBcJPTKJ/XW8Rj2JE16A6K4=;
  b=Kpz/RWflKAIPlrKK/lk/ap57ChOatIsV2xYJImnsR18+KMeNAfGPfAJ/
   nnbL0isOwjwu7Om/w8MresXGM8QlJf1k/MFm6jq6cLtTJQNilxFsavaPj
   ELzgUmIOS78/ZumiStP53GrFsX4BnjNPGGKMjpGabbFdYcRr28sA4b0a/
   9UgH/58TjnCh9wx3I93FpPJvByTwonoPF+8TOwj2WD4IpZGQ/JDxYUjhM
   Lqz1qEpbOYV7RISPM/+DulFoHa9HUd6RR1ScVfWxRgQV9oLQopstMJAhx
   2YJxqDBuCywunuIk6E3F3cxWH0RkkJlRUbqJRUdzaKoK6ET1KjG3UYgeV
   A==;
X-CSE-ConnectionGUID: tYqeV9DtSoWfrcNx/jSMqw==
X-CSE-MsgGUID: NqWdPTgKTZ6BTJ7Y4sUWUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91472943"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="91472943"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 03:13:28 -0700
X-CSE-ConnectionGUID: kWcIElnyQ+273Lp+YgLlXg==
X-CSE-MsgGUID: fxK2mFt1T86oNB0uIMj96g==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 03:13:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 03:13:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 03:13:28 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.69)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 03:13:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5Cy9GgW+68XHcifLpIIkL9cqwKbsjXDctDUA4Kgffc6NsiNMkHUiFIWpmin8wyqzwASOMS4pLpYDpToWrgabQw5tB9XkOpxkLcuhA7vBpGNmcgTkMm5rTetD92AjmfK1q+pKk+vw86qFccv5ibgUXjZ3g8qUGCOqHmusxNgCcb0f+f04BaWajUA1Ephyt0RX1jU3S9vZnCHFl7qDsGMrO42aI6RpUbtntWxPsJFRSgQLmeUcoFupRmfejJ+uGdvzghTdK/fY+jNTAeWCgR+nPMvLZNe7bzimMWB6LhzWg68Jf2EXJr3hM1OKInFwVW+GxdiFqZNiyN9N+r+MtAKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GUVsnHeJ5K++arNhFA411WuKaGKWKGBVhzjn8GkKDk=;
 b=QgzBNi6YBW6+wYrdyBaDitQqx31bB9w0L5LM5k7FQruhKvviVzLJcxnwvdCVMmCjRzSAFOt4cI1g/IXBl+Y8sJZpCAg1c2Zvr6ihMP1prOypjWfpjS5h+tXkyuZsdVNlAizSBlWA3NVUdMINpKXW1xQwW6/y962FT2TBm6IhSes2wgTjlqCHcoutrDKCeuBBLoZPOBZS2BfGEyZsinEFJ+GMFEfxGOyCYLyqQ7Ck7FvwmNv/nY8Kna3AaDINeHecPVcIuxeJGTTtsKcBj17I1iiSZ0O4BT4vim7AKI11czQe0Tf7Tfun7e/GL2pCgsBgLykaIZI/KB4EF0IOCd2g0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 10:13:23 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 10:13:22 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: ZhaoJinming <zhaojinming@uniontech.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2 2/2] ice: dpll: fix memory leak
 in ice_dpll_init_info error paths
Thread-Topic: [Intel-wired-lan] [PATCH net v2 2/2] ice: dpll: fix memory leak
 in ice_dpll_init_info error paths
Thread-Index: AQHc7y2AmMEKZwbpQUay/IVHQ4uZkrYkyScg
Date: Fri, 29 May 2026 10:13:22 +0000
Message-ID: <IA3PR11MB8986C30A496A498C2321DA7AE5162@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260528171202.2659491-3-horms@kernel.org>
 <20260529053733.764996-1-zhaojinming@uniontech.com>
 <20260529053733.764996-3-zhaojinming@uniontech.com>
In-Reply-To: <20260529053733.764996-3-zhaojinming@uniontech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW3PR11MB4652:EE_
x-ms-office365-filtering-correlation-id: b45b27b0-ccaf-48f9-1089-08debd6aea3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006|4143699003|5023799004|11063799006|3023799007;
x-microsoft-antispam-message-info: oRYa7hw/6YgHDhr1tg4dez75aaZ5MWZ/zff50V/XnHJn63kqwOu6hPyGb+G7CiymC30MrWh1uhUW8ZAnbJspNZNA/1oEQnvRlq0eV/PQvgud9+iB6X3dwjG4tr6KikpKle2XtAMsyq5WYEhbKOE0iNYXdoUWGW3i0h/iQMXGwQt4r4bPZSRePvjEjh7TmSXO8+xSwhffvFIqhMC4awMI4IHY1YTvNSKweBujw9b9Rt1poyDl3t9D/lmFblK1NiKI0pGJJ82mAyr9bY9AUmEkRshYIzXNabZgoGWhrCXe8Q4iH+0MFRV9U/0iho5wfjXbv/bhkI+iROYSGR12PUVSn+oSsjeuFK/LqKmz/BuyuZNxkoHPpyQD9//cz/shgBVe/DZiG+fNZw8RFH69mMtPGne3oTJhYYfPZgR+R2rrhOwOtnaBqQ6JlZvs4YtfpGoP6q+QFf7TxCqg7gkdm8KnQqR9kOLV8wk4hEyTWragwCfkLgWCMxjQanr9wxkdP0Xk3MS9yZe9GfLALF4PtNEcO8LhCBXQvmdOaWE3uwnXWnM3/ewkFJxXflkoYOgjkPmYVDSCVam2MvU1GNRhUewgxUaqH1jWjlv+2fmC5C+3u6P5YyJCRQtKS8SQ53ets6uCZCrevUOAYncLFcvqxlErxVuC3zyo0ls4AF1yoSBz+jnvSdvixcYlpFVZXkNThVgWFVxg4EzuF7/v5m+SVsaaGfeIpBAxrMlCZMRHYkiI3nBubIWv0lXdXa7qh1vrqTDM3jvW9+nuibPsdWAaI5UEAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006)(4143699003)(5023799004)(11063799006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YVJGbnY0eUJVbmdJNkIrVEFXSDBtVEp2Tkg3eFpubUxKVG02MmZaM2Ix?=
 =?iso-2022-jp?B?UXptRlRmRDdTSHE5Y2Jzc1k5ZTdlTktpSzFzNTJudHhnOWpUaGh5N1RB?=
 =?iso-2022-jp?B?bHZhaVdwS1hBek1Ed2hIeGVzUzlmSEdmNG85SDdPZTdmYnpDY1o4d2pq?=
 =?iso-2022-jp?B?S09VbkRKa2gxVW9JdVRJVlNwcFltemdVUlNWaHNkWFZnbVhiREtDN2Jo?=
 =?iso-2022-jp?B?TUpWZGNKTm5kU0RFT3FIdW5lUE16c0xaanBTYXVFUngrMmpzWUY1S0Rz?=
 =?iso-2022-jp?B?b0ZTL0hOV01MUlB0eG0wYVNjaFNNb2dUTzJqUFp3M1VvNEpLSnlGVW9E?=
 =?iso-2022-jp?B?SkUvTkFiZmdCNGxkcE5GZjNrY2EwU1FvRjVvNXFsZXhkQjRwYTZYN1Na?=
 =?iso-2022-jp?B?aVNvUEJ5SXJmcjRPUU1VQkVQaXZKQkxyTko0QndyTTJzaHBySHA2S3Jl?=
 =?iso-2022-jp?B?M1dmU2hWN0Exc0pRK25NcUZzZW5vY1JNdmw4MXNzRlBFQy82RWNMZEpM?=
 =?iso-2022-jp?B?dURtRVZvdXdoeGRPV3RQcXZjb1BCVjUyT2xvb1BheDZHK0pMeTdjeUR2?=
 =?iso-2022-jp?B?T24xV1pLV2JrTWx5SjFUbGx0RThvOVVpYzk2ZU9KSktWeXM1SlpPOUpL?=
 =?iso-2022-jp?B?T2s0aGYweU1Da0JwZ1Z6UHRWdm5OUUM0YWMxdjlVWGpMRTRQZGJmVUxM?=
 =?iso-2022-jp?B?Q25vT2NBYzBxb1llRkFCejcrb3JJcGdRYzEwZWN0dXUrTU8xT290Wito?=
 =?iso-2022-jp?B?VFdvczdnQUhuYlZ2SHllWjRBVDhYOTRsaVhxNzFXRStCMGdUNU56cnFx?=
 =?iso-2022-jp?B?SzBKSmt2cndZWFM3WGY5VjJnMWpQRzJaMzgza3hjdzFjZ0JFOFI3Z1Vs?=
 =?iso-2022-jp?B?bzhqMGRNUE5RVy84UEVUUnJKRkkraENtUVNzV25LaUZuUHNtWll0ektN?=
 =?iso-2022-jp?B?Zmx3MHlodzRsSzlPTWMzK3o0TWlPOExWOSthWC9zbGt0UnlrSzUwRGhv?=
 =?iso-2022-jp?B?UTR1eGtwQitVZWJpYnRNL3JCaU42dHJRUEtsakJod1dvNG5HMjFhUVFp?=
 =?iso-2022-jp?B?U21xK1RXSERNbzFGb0RjblVaZWxlcFBWbkhHYm9ZTnZHcjRtVmNHZkhK?=
 =?iso-2022-jp?B?Wld2SG9NSU5pNlBlUUI1UzNxR1dSTXpFUGE5NkY0UDhuNS9tWkluWjd3?=
 =?iso-2022-jp?B?eks4SFdaQmtZT2JmdmZ0eTFxN1UyNHNlMEM5ZzdIYWxEVFVoSGExd3hn?=
 =?iso-2022-jp?B?WGNLQW1DY1VDNnl6TkxtRjBXWjVLdFBFNE4vSE0xMHRyOW1FdGZzN01r?=
 =?iso-2022-jp?B?TWQ5aVdMUWpsVWtZQjQ3TUpoQi9ITGZ2QlVMV2RGU0NoRUQ1Z0x4VFh0?=
 =?iso-2022-jp?B?clcwaTVCbCswa2tpUms4cHpmUVV6bzVSRGhQNUpzQXYzQU9UeFIvamVD?=
 =?iso-2022-jp?B?YVVmMlhFZndaeEVKbzVLMEw1d2hpMk1lemx6dnUzV0I4UmQ5WmgyTE1X?=
 =?iso-2022-jp?B?L05WM0k5Q2lsbkhMRzMxSkdXSzFjbTM4Nmpwc3BPYmxRRFhMbDJBMFFo?=
 =?iso-2022-jp?B?cWFqUFQ3RGN3VTJJOFhPUFYyMUU1Y0VvOGxqTGFEN3c1dG4zOXhNQzRW?=
 =?iso-2022-jp?B?clN2c2hmQzU5eDdyRTMxS1F2VDliTDlFVWphT1F6a1JxSzAvdzlha0tI?=
 =?iso-2022-jp?B?ZEJnd2ZCdlp1elNucGxqdjFrOTcwYTZDd2tGVS9CRXhjTG9uSUtDazlF?=
 =?iso-2022-jp?B?TnV3NXJXS0tYdWpXdmxkeGFFdHovRGFRcmkzSFhEWFZlbDRIQS9ML2hI?=
 =?iso-2022-jp?B?UTlmOEx3MnF0WEJDTlhMbGVBd3ovTjkrVTNxaDFPR25UNXJueEUzM2Rj?=
 =?iso-2022-jp?B?dGZ3d21EWXZLc2M3elJMUmY4VHpUL2luQWI4OHpDeURZcW84MzZxdjh1?=
 =?iso-2022-jp?B?bDFWcnN3ejQ1bVJ1SE84b2tHR2VYUm8vNU9BZlZQNXZnTlVSeTNiM3VH?=
 =?iso-2022-jp?B?TWU2cmROQi9OWGIrWElRcjFqTktLVmR0VElrL3NabnNVajR3S3JvMDR4?=
 =?iso-2022-jp?B?Y1V6azE3V0FpdXp2dERHQUpGQTcyNXJvOU9QS0M4MVZvVWhUNGRyQ1k5?=
 =?iso-2022-jp?B?RDNYcWUxWVNTeDRGczdlSGZZNCtTM0RFMkV3THlzNStYWUcrT2MyWFdJ?=
 =?iso-2022-jp?B?RlBrTjNGOFg4SEhvOFdFTVhqREwrOVlqa3IvZENmcTUzeUEyYmFESlJv?=
 =?iso-2022-jp?B?SXJuZ29MSTVoYzBpNlltd28xZDJEWHJ3OUZxczlyenB5dmRZdVdoQm9h?=
 =?iso-2022-jp?B?c1BtVGVXVndGbGoxUmUwVXA4QzdJaHF0MkRwbW5tcXZoRGFiUzVLM3Vs?=
 =?iso-2022-jp?B?dWFObTkyMWtyRTVlWmFpMndtdVRmaTJhVWZNZ1BWVWZhbTZ4THlEYmJz?=
 =?iso-2022-jp?B?YVVWNTdpa3AwUG44U0g3L25rWXE0NDFaSkw4WWx6SklTeWRDWnY0aXpx?=
 =?iso-2022-jp?B?eGtmeHdoZkxWb3lCYUtrV2Z5Z004R1Yrd2lpT1BoYWdVODh3WDVxRnI2?=
 =?iso-2022-jp?B?ZjBTdkVacz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c4rIj34BgsH7dYj0YaCRKu/ebOYNIHChVMzKaoSSL4mFZDIQuKMEin2WJT3ZSgWPUWh8EOgrND7uvYsXKz92a3lKvaY3ioG03/prQqbeoPIjBgbR5bwtFeVcPq+X4KiO01TQXVf9i1cSB3xWg94ycqu3epHfuKcA0DXwPVHGr5AuRnW/QfLj4ROtLnUvOo27AIeEptMGN2kDA58AXcHzecNCjhTwaJoNxJfFcpqoElvpeE+PgJyqgb6UDRuklyILruHiDnvFKRyFLwnwqcCsI/OxAhowEHyHvG1olSbQ8pBJlaktkaWuDjZNCFzsJy1KxffUr8NvuIiAaor9PqdxRA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45b27b0-ccaf-48f9-1089-08debd6aea3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 10:13:22.7061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ev0/WF/NOjfAJxsqjN25QNQGmyzZ1czC2SiDy3eDo/dqpSWQoLGCWvZLXNVfxQtG67ReRftLpRQkr2zDc0eBnaCGkItvbDF1kjc/wMQWTVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293072-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8986.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,davemloft.net:email,uniontech.com:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7756F6009AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of ZhaoJinming
> Sent: Friday, May 29, 2026 7:38 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; ZhaoJinming <zhaojinming@uniontech.com>
> Subject: [Intel-wired-lan] [PATCH net v2 2/2] ice: dpll: fix memory
> leak in ice_dpll_init_info error paths
>=20
> Several error return paths in ice_dpll_init_info() directly return
> without freeing previously allocated resources, causing memory leaks:
>=20
> - When de->input_prio allocation fails, d->inputs is leaked
> - When dp->input_prio allocation fails, d->inputs and de->input_prio
>   are leaked
> - When ice_get_cgu_rclk_pin_info() fails, all previously allocated
>   inputs/outputs/input_prio are leaked
> - When ice_dpll_init_pins_info(RCLK_INPUT) fails, same resources
>   are leaked
>=20
> Fix this by jumping to the deinit_info label which properly calls
> ice_dpll_deinit_info() to free all allocated resources.
>=20
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
> b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 99bb308255cc..7240152f1655 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -4345,12 +4345,16 @@ static int ice_dpll_init_info(struct ice_pf
> *pf, bool cgu)
>=20
>  	alloc_size =3D sizeof(*de->input_prio) * d->num_inputs;
>  	de->input_prio =3D kzalloc(alloc_size, GFP_KERNEL);
> -	if (!de->input_prio)
> -		return -ENOMEM;
> +	if (!de->input_prio) {
> +		ret =3D -ENOMEM;
> +		goto deinit_info;
> +	}
>=20
>  	dp->input_prio =3D kzalloc(alloc_size, GFP_KERNEL);
> -	if (!dp->input_prio)
> -		return -ENOMEM;
> +	if (!dp->input_prio) {
> +		ret =3D -ENOMEM;
> +		goto deinit_info;
> +	}
>=20
>  	ret =3D ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_INPUT);
>  	if (ret)
> @@ -4375,12 +4379,12 @@ static int ice_dpll_init_info(struct ice_pf
> *pf, bool cgu)
>  	ret =3D ice_get_cgu_rclk_pin_info(&pf->hw, &d->base_rclk_idx,
>  					&pf->dplls.rclk.num_parents);
>  	if (ret)
> -		return ret;
> +		goto deinit_info;
>  	for (i =3D 0; i < pf->dplls.rclk.num_parents; i++)
>  		pf->dplls.rclk.parent_idx[i] =3D d->base_rclk_idx + i;
>  	ret =3D ice_dpll_init_pins_info(pf,
> ICE_DPLL_PIN_TYPE_RCLK_INPUT);
>  	if (ret)
> -		return ret;
> +		goto deinit_info;
>  	de->mode =3D DPLL_MODE_AUTOMATIC;
>  	dp->mode =3D DPLL_MODE_AUTOMATIC;
>=20
> --
> 2.20.1


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Code looks correct. Please add `Cc: stable@vger.kernel.org # v6.7+` to both=
 patches and include a v1=1B$B"*=1B(Bv2 changelog before reposting as v3.

