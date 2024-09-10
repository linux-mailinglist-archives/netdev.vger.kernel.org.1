Return-Path: <netdev+bounces-126819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB619729A7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D251C23F01
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E15B1741FE;
	Tue, 10 Sep 2024 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9wWQRU8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1717ADF8;
	Tue, 10 Sep 2024 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950291; cv=fail; b=Srtaybtp8wXPv1PolenjKHBGeB6gkQAU4g05OeFiDuqmMc9acksno25yO8TfAABmGIwn1ZeAkte1uvWzzQ9NSWNZlCczB01NDimlWop7HoJcDG3CKcq9SrsrnyTKU2lDjNYs8cn7a20yuY8g4eXd2y/tuN6OKItm8rB3RHXBhvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950291; c=relaxed/simple;
	bh=YTVw+Y2Oz/zaXoSs0DCgh+qK+klrMC1kRurLQzP/MbY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NHcGw4yXoUbDKBWUfz//JcVuANBgQcniXRVBIzvayBc4/StPEvuUrHmEMfCtedya9NyPK2Bv4vboFj4LXOiwlusuObdAOuWjqxDwRthC1lcWIeVl/aj4CjoTmHkqwU9X8+xyxLqmqDhwFaUbbfbLi3EtQv3ecWsTvBA0JR4Rd5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9wWQRU8; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725950289; x=1757486289;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YTVw+Y2Oz/zaXoSs0DCgh+qK+klrMC1kRurLQzP/MbY=;
  b=L9wWQRU81t1WlOvKc2Ohk+2DfFCEch8Lrgc3A4WcFnqYMQ84xwj4MBMZ
   yZ/xh8EeIXmHJeihS9Jw5AtqXjPIOT61SpCggvbPBmLPQerXudSEXu3Ph
   iOhX+TF8S7wIAt78CpyGLebsy75cJaZ/z01WF9XDtQu1gQjMqPR8s1QUo
   ay5hbvTCkIv6qSG1onL3EU7sHODg7bdmrums15V1VdrI9E800DpIJFB8m
   16WTJQIlN2+Hzk1M1sG3i0FXdGHG10+TTtP50+F6j8E+qDUrhyJlI5H8D
   jJ99uVBYm5c/48s4pEPdcUXwRRPuj/Kz50rvpPq8K5GULvyzd6b3V1khI
   w==;
X-CSE-ConnectionGUID: a1Ws0w5KSJqMsbMHkpyttg==
X-CSE-MsgGUID: 4oTRL/fRQJu7umTdaqM6qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35344068"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="35344068"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 23:38:08 -0700
X-CSE-ConnectionGUID: iIiStfbOQC6e8bidSseSAQ==
X-CSE-MsgGUID: /m5uVbopQ7edD1gGhYZz5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="66619348"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 23:38:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 23:38:07 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 23:38:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 23:38:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 23:38:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSLIW/hzstX1aIW9R+toWiFEwX1AapGyyO1pzygiejN+N5LbNEu4fnW0h+a5LRm3axCjM5NieKhbUHwPAEbEQMkKaZpS+Hv70VNMr1kDdC7O63XvpaQEKADJoRrdTg/sG7ubhDzdmEfcHtG1ms3hq7/2QiW44eMzsTxtPFihspaRd3UsSxFYElkZYAZ6U3sTuVpHsexCYnhqv+htxIFKsSttN4PhkB7GusnqcotDV0lzhWmYL3Tj7ZJdb/leDxJb14dtHfPapRznKi4oisH7/jv71wRigWUkycP9DWY/30ZKQTAueptiH2rEvf0S5pgEM65ObTYgop+yEIkfxHAFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCdvftoFBhTz2rx4jAnZDFNtEgA/voaJteJu13pXLZw=;
 b=h/eOrUMP5o2L2k7u117KEqd9dSgNBA4Hhiyj2Cp2W6NVu4tvFHsyUzRBCqUlDr7MZfAj6dX7TiTOkDkOGoPpN5ItiMWxjp4hdezsBZrol3F6bA1UJbEU6eLNqbpkHZuZzwwvkiPEQkHMwb9ahraO0aH0mbkaEKT/3pR3SrouQsm99mN3aCP9saBQtWC4Ncbe14KuEw428JiK18KxG1HaM3UjYJln++sMMUgM0Fi0HT0JOV6Jydmnn+CuPs7Fm7171rj7AKAIfVD2J/xfBj63pr17S4tAi3o8hcmDqh/5vLcFhjlIGPsQGo7Q4l76DL4oN4uLOJ7FUhkzdrwv95vsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by SA1PR11MB6920.namprd11.prod.outlook.com (2603:10b6:806:2bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Tue, 10 Sep
 2024 06:38:04 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 06:38:04 +0000
Message-ID: <920a9258-650a-454d-b45d-673b7cfa1e56@intel.com>
Date: Tue, 10 Sep 2024 14:37:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/20] cxl: indicate probe deferral
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-11-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240907081836.5801-11-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|SA1PR11MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 678e14cd-6962-4f66-7515-08dcd1631f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rzc0MXI0RWtUcit6R200VzdCQzZpbWVLSWl0b1ZiYWVuM1V3OFRHZnJrZHpl?=
 =?utf-8?B?dXpyM1lNbk10TnRpVGlTaUZScjFNYU43R3N5bzZVUzN0d1hPYzB2a2toenJQ?=
 =?utf-8?B?RHlwejFqYkd1SVFDdVY0QytzZlU1NEVwZHh2SHNKWFY2Ym84emF4RUdVVlVE?=
 =?utf-8?B?aXZWRlVpNG1jaE0rb1pyczdaYnR6bG1yc1Y0ZHF5ZXU3ZDlmRkU3R2ZYZE1t?=
 =?utf-8?B?UTF0eWJnOTQ4ZS9HeWpVY3ZKMnZVUmwvSTVicjd1akpqNDVwUW5aR1RmSTB6?=
 =?utf-8?B?YUdwR3J2OHRGRjc5dkNSN1FtbGp0S3J4cnVxSGc5cHJlZ1NLUDFFL2ZoMzVt?=
 =?utf-8?B?NHdSQWxacTgrMGJmZk9jNStHZmRFSXliVDA2S0FXRTJiSGpkSCtuRUs3SDgr?=
 =?utf-8?B?VlJOODRaZ1RNMG93eEJZTHdTT2hHaVB2K21zbDhzSWtiU3hqeXh5M0d1YkdN?=
 =?utf-8?B?akNYbTNUVDVsd1h1bFVYeTU0dWlXOHVJVTBXS0VsYjcwYXlpZ2xDMWRlbTJT?=
 =?utf-8?B?SEtCOGs0ZlgzbHdHK2tSVk9vOGVGSmZCMlVUL3pYNFlpNW5HSDN0UlRhRklR?=
 =?utf-8?B?OG85YnhuTFdobDBwVDFyR0o3UldRbDU1bmptWmMyR29VSC9INWFXQWJ6VnU2?=
 =?utf-8?B?bHNWbXVPKzkyd1ladUlpbG9QSjhTdmtxRnJOaVNxWDhCTERFRUNoSHNJaVR2?=
 =?utf-8?B?MHl6RkYxN1BsSXVrVnV2NUsvZ2JHYnBld1JyQ0lJaU5MUHBWRlJLaGcxVHc0?=
 =?utf-8?B?MkhzU3pycFF2NWg4ZEJKYk9HdHVMWGFMSnZoaU9VTnVaRFlJZFA2SE8xL2xu?=
 =?utf-8?B?cjBFWUhSdlRtTk1FMjZFUUo5ZWJPQ3dTRGYrZUZOODRTVysvT0g3cnpCY2c2?=
 =?utf-8?B?amJ6bGUrSkcvLzlZT3JKbDlRRENocnBPNFpuRzJFdWUyc29ucEdtenpnTEZr?=
 =?utf-8?B?cVI0TkZyOTVpc3RxYXlkK3Y3QXVUKzUzdXpIZmE4S3A1RDRPbUlqK1N5UzYz?=
 =?utf-8?B?MHRMU0xuUTczWjdzZTRiNnNobHdMQmJDd04zK0NJcmZ5N3MraFlBaDRsMnJw?=
 =?utf-8?B?Q3VpZUF2aXpMVDc5c0t2ZllaQWVlZUxFb0ZQTllZYkMvWSszRjlMeXJ3Y1ZB?=
 =?utf-8?B?Y04zQ1AzU3Y2ajlQbVBhVk9VZUNjbWVpRnZyWWVYaUpLWFBFSm9NQlM2c0Jq?=
 =?utf-8?B?Qk56dEUzYkZlaTlpb0tmcWtZU0d3dDJTQis1MTFhcVZnUXJ5a1J1U3VCcGxu?=
 =?utf-8?B?YURQT3J6ejI3b0JVUCtmNjZLSEYrK1ZVdyt0L0RlM1hsR0VXS1dMNllFWS9M?=
 =?utf-8?B?SGJIQkpCcnJjMVJGbVBTSFRyU0tOWnc5UTNkWHduTDlxVFNuZDg3WEkyMWdz?=
 =?utf-8?B?L1BzckRZcTVQVm5EZGcrUEpxbE1sMktYR1pkTk9qaU52ajBKbU5VcHpuOGpJ?=
 =?utf-8?B?YXJFMEowa0xSc1R6RWRob2JVQ1NGeDd1bm1JNDRNendVeFc5bDl0TzBWcVg5?=
 =?utf-8?B?NUM3a1JRRDRPVm53TXc2SmJDbFlPNGZ3U2cyZUh2cjU5N2pWVlRQb0JkT1hE?=
 =?utf-8?B?UitNRXlzT2RFMmVkNnFXeWZrT1lvejg1cGM2STdsNjlTdmVuci9WaXo0ZFNm?=
 =?utf-8?B?cjdhai9ORTV3TUhUWkltNFdGZHpCN2haNXdJT25rSko5dWptWE5mcUt3OWZK?=
 =?utf-8?B?eXY4WVhkRngyY0c3NVBTU2daY2RRRFZIdUZyMFdBVTB2cXF6YllnZ2wyQnZw?=
 =?utf-8?B?a2dtd2p6WHRXVnN4QkpSQTlvUzIzV0RFZy9GdDVJZDZiYzNheHdHZTRZQzAz?=
 =?utf-8?B?SmlNRVhWYVdpL1ZaOGE2MmZ3NjdKWHpySUIyK1JISFBOQmp3MTF4dlRhK1Za?=
 =?utf-8?B?YTlpeW05YmMzdmZjdHIvdFlWMUpOVkIyTlM5amh3RkJSWnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHViWFFhYWNRL0hXQlh3anFFQmprd3BudjIwRXgrSDBHc2ViTXhvdTZzQ1p5?=
 =?utf-8?B?Uk13anRLSHJpd0hpU3VibGViV1hBaThOVlpzQ1FQbVZ5dzF5MkFhbGZXNDNS?=
 =?utf-8?B?Z0FpYjJtM2NLbVE4UWQ3QmNqTlBVUHlIYmIvdDlKYVMrZTRTR3JGa3ZETG1t?=
 =?utf-8?B?cEtVRmdIYnZLZ2dSNG45bmxEa0JHdi9VaHNPaSswK2Z2QWJSYWlHWGJ2TjhR?=
 =?utf-8?B?dndOUzA2YzBJWHpzRGtiNkdSMVMzUTdXZTNJZ0xSeXB5MDQySXdQSzlwZGt5?=
 =?utf-8?B?Nm00WldmQndlUjlKZVhCbmlaR1IvWXJtWlF3MnU4SThHSEJJQzhYY1UwdTQz?=
 =?utf-8?B?VmdEM0s4eEtybGtqVVVaMWM5R3NueHJyV3B2R0pDYk5OWlFDVUxJdU1QWkZJ?=
 =?utf-8?B?bUYvcnRtNWk2WXRYdnkwM0p2ZUpZdkhqb0w1ckhBcm1ua1FURU1nMTNhWnlT?=
 =?utf-8?B?N3llTXptWXdZdXFCZUQ0MWRCL0Izd1h4OUVjRG1NMnVXSTlRck53OFZuV2g3?=
 =?utf-8?B?S1BMZkJGMHlhYS94b2k4MFF6dzdjMXU2czJuMjVOdmwwbmUrTUpVYzl6NnRE?=
 =?utf-8?B?ZThSOWg5ZnhVWlptMzB3TjVDOFdIcTdpU3hBRHdpMEN3RjM5RzdYZWNyTDdE?=
 =?utf-8?B?QUVYSE5FV2xTWWtPZWU0ZzRqWCtLcW02T1B6UEp1R0hkODJFMkVqOGIzYVR2?=
 =?utf-8?B?UlFXTEFvQWhzNElVNEhpSXZuMWtPd3RTUTltc1dtR01VWUo5RTlWMXJxQjV5?=
 =?utf-8?B?QjdqTlRZT3B1UElyYVZUZVVJa09HM0F4bFRjdWNQMW52TlFiSnhYYVRrMzYx?=
 =?utf-8?B?M3NVZUpVbnEwcXltRGo2dnlnWjlCN0xBa3hQcFV3Y2ZvUUhOUmtWa2lKSmtW?=
 =?utf-8?B?L0VwNE13ZVdCeFA0akd1b0ZpOUdPY0EyOUlOK24zQ29FN1pnUy82Z3RVWWRT?=
 =?utf-8?B?Qm8zRXhZMWR4TnZsWllCaGJ1U0JHZlZ2YnBtL2xvbWtBUE5haXJBcENIZ1BD?=
 =?utf-8?B?a21kZ2NhL3YvWjg2NHZTRWRDMTRxMVZiOWtPNGJ1OUNnTktNV2ErMVpkVSta?=
 =?utf-8?B?VE9GVW9HOHVnbkZWanJUOUNydkhLVGRibnM2RmVQcVlOYWxaMitPOFhjd2d5?=
 =?utf-8?B?VEVGZmo2MHYvVnZyc3Q5TytRODFKV2c4b09qZFR0b0s3VXozU09XRlBLM0w3?=
 =?utf-8?B?bU95MUdSUmlRb2pIMHZEVFJFTWxQUk1hYnhuclo1V2M0RXQ5dEI4NC9NT0Nr?=
 =?utf-8?B?NEhoUVZ6bmE0TDB2eVpKbmllZWtWVUs5SXduQWVoYjltbXN0c2FYOWlzV1J4?=
 =?utf-8?B?Y1VIemxyYXoza2tEWjZzRnFNOWRsbmg1YnIvU05DMVk3SFp2dE5wNWpPT1Zo?=
 =?utf-8?B?a2VwcWNZL3dYcVJHcW9tREhEMjVicFE3QzE1bm5RZ1FHWHRTOUNIK2hCUyth?=
 =?utf-8?B?ZmRyR203TW9MTjVLUlAvZEhLZWhSMUNFa1hkUnJlN3BWTUpKdk9XR1ZaM090?=
 =?utf-8?B?cGNiUXdQOGxGMlIvdGFkMUlvcnU2QnpNMlVaNUYxNlhtbktQYloydWNVMlZt?=
 =?utf-8?B?YWVBMkpFOWlHUVBFMzhWQjBzRUMrZTI1eUhONmZhOUpQS3doN3hpZWViM3ZV?=
 =?utf-8?B?WlF1ME11Ykg5dTJ2Y3hQYWJFTGdkc0Z0RHk1L3cxZHNqYlc1cFBlTWQ4QTNY?=
 =?utf-8?B?UVh3Z3UzUW9NWGZmMlJzQmxPUE9OdDA3ZzU1R3FQT3h5MjMzbzBwaUVLZ2RR?=
 =?utf-8?B?S1R1N08vVDYrTEozcW1EWWNmYnFsSnRaNWh1S0JVeTh6MkFvdFNRNnhPR25B?=
 =?utf-8?B?YmJYVlY0Z3NkYlFxaS96YUpMM1hCaGNBWUJxU2dpSENUOWc2Rnd2UnZyMVc5?=
 =?utf-8?B?UHFwM0RYRGkzVjh2Y2hUYmNMV3ZKZHhKeGVEUXowclpydjJwb2RSdWRDUXIy?=
 =?utf-8?B?bXl0SFlRTFcvMjIyR3lTMmpRS3pLcDk1YW0vbHplVVZZb2Zsb1g3RjVuWmdQ?=
 =?utf-8?B?TFBHUlF0VGVTWXNhU2NvSmc5VDB5N3pLZnRLWDY5YkVyYkNlVmZ0eVlDQ3hi?=
 =?utf-8?B?RVhqOHZPSmR0YnpvQXBWbUVWaVpOSTJ5RnJpUHpwU0ZobWh1QlpUZTEvVFk5?=
 =?utf-8?Q?IvSt6H5L2NRfCkADkcEMZoyxr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 678e14cd-6962-4f66-7515-08dcd1631f65
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:38:04.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Iq3+ZI1u+mcSUr4zREYmq5nvW7eCyFoVIFSGNWHbWC6PUXx8HwtCcFk1+/y8ORvKHR3cusGU1QxL0KX2P1+gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6920
X-OriginatorOrg: intel.com

On 9/7/2024 4:18 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> The first stop for a CXL accelerator driver that wants to establish new
> CXL.mem regions is to register a 'struct cxl_memdev. That kicks off
> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
> topology up to the root.
>
> If the root driver has not attached yet the expectation is that the
> driver waits until that link is established. The common cxl_pci_driver
> has reason to keep the 'struct cxl_memdev' device attached to the bus
> until the root driver attaches. An accelerator may want to instead defer
> probing until CXL resources can be acquired.
>
> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
> accelerator driver probing should be deferred vs failed. Provide that
> indication via a new cxl_acquire_endpoint() API that can retrieve the
> probe status of the memdev.
>
> Based on https://lore.kernel.org/linux-cxl/168592155270.1948938.11536845108449547920.stgit@dwillia2-xfh.jf.intel.com/
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 67 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c   |  2 +-
>  drivers/cxl/mem.c         |  4 ++-
>  include/linux/cxl/cxl.h   |  2 ++
>  4 files changed, 73 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 5f8418620b70..d4406cf3ed32 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -5,6 +5,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/firmware.h>
>  #include <linux/device.h>
> +#include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/idr.h>
>  #include <linux/pci.h>
> @@ -23,6 +24,8 @@ static DECLARE_RWSEM(cxl_memdev_rwsem);
>  static int cxl_mem_major;
>  static DEFINE_IDA(cxl_memdev_ida);
>  
> +static unsigned short endpoint_ready_timeout = HZ;
> +
>  static void cxl_memdev_release(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> @@ -1163,6 +1166,70 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>  
> +/*
> + * Try to get a locked reference on a memdev's CXL port topology
> + * connection. Be careful to observe when cxl_mem_probe() has deposited
> + * a probe deferral awaiting the arrival of the CXL root driver.
> + */
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +	unsigned long timeout;
> +	int rc = -ENXIO;
> +
> +	/*
> +	 * A memdev creation triggers ports creation through the kernel
> +	 * device object model. An endpoint port could not be created yet
> +	 * but coming. Wait here for a gentle space of time for ensuring
> +	 * and endpoint port not there is due to some error and not because
> +	 * the race described.
> +	 *
> +	 * Note this is a similar case this function is implemented for, but
> +	 * instead of the race with the root port, this is against its own
> +	 * endpoint port.
> +	 */
> +	timeout = jiffies + endpoint_ready_timeout;
> +	do {
> +		device_lock(&cxlmd->dev);
> +		endpoint = cxlmd->endpoint;
> +		if (endpoint)
> +			break;
> +		device_unlock(&cxlmd->dev);
> +		if (msleep_interruptible(100)) {
> +			device_lock(&cxlmd->dev);
> +			break;

Can exit directly. not need to hold the lock of cxlmd->dev then break.


> +		}
> +	} while (!time_after(jiffies, timeout));
> +
> +	if (!endpoint)
> +		goto err;
> +
> +	if (IS_ERR(endpoint)) {
> +		rc = PTR_ERR(endpoint);
> +		goto err;
> +	}
> +
> +	device_lock(&endpoint->dev);
> +	if (!endpoint->dev.driver)
> +		goto err_endpoint;
> +
> +	return endpoint;
> +
> +err_endpoint:
> +	device_unlock(&endpoint->dev);
> +err:
> +	device_unlock(&cxlmd->dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
> +
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
> +{
> +	device_unlock(&endpoint->dev);
> +	device_unlock(&cxlmd->dev);
> +}
> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
> +
>  static void sanitize_teardown_notifier(void *data)
>  {
>  	struct cxl_memdev_state *mds = data;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 39b20ddd0296..ca2c993faa9c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1554,7 +1554,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		 */
>  		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>  			dev_name(dport_dev));
> -		return -ENXIO;
> +		return -EPROBE_DEFER;
>  	}
>  
>  	parent_port = find_cxl_port(dparent, &parent_dport);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 5c7ad230bccb..56fd7a100c2f 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -145,8 +145,10 @@ static int cxl_mem_probe(struct device *dev)
>  		return rc;
>  
>  	rc = devm_cxl_enumerate_ports(cxlmd);
> -	if (rc)
> +	if (rc) {
> +		cxlmd->endpoint = ERR_PTR(rc);
>  		return rc;
> +	}
>  
>  	parent_port = cxl_mem_find_port(cxlmd, &dport);
>  	if (!parent_port) {
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index fc0859f841dc..7e4580fb8659 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -57,4 +57,6 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlds);
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>  #endif



