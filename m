Return-Path: <netdev+bounces-283713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLlgDqVK+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:28:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3964B9546
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A093F30010CD
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAF32DF138;
	Mon,  4 May 2026 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ffc5ICz1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868362DF144
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879713; cv=fail; b=mmCE3cPBHMAc+Dy9kqc2J74Ylanp+NXhWSlUUM6z3h8gvMpqrCAnTLpI0TsMFOzKPWKujtvPBGEo3N7Bl3nDRtjFaX0id0bZH9zJ/TlPKH4GY4dUNNeiXcSBPBPAJqijq2HrhFqQR/iX50Urc4SoYzq1u6rqKuaN8qY+O6tuMpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879713; c=relaxed/simple;
	bh=zNLVqGRbB+6b2S4Xb+/5fXX7ALEj2JWnjsBbCvzUwVE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gEFqLGtozEu5qhLDFjvywCRdTyCoTvu00VFVLJczK9ef4uWvJoq4A9RqHf3DbqpkLEMEGqLcuauIo2W20gobbm7F7BkZD77nAIBWsg5DAMuiyMaFktDixVxCrTJBYRC/cWCmO/8U45XZWLDJ8hWYbUB1WPfjMzMcaV9hv7MXZ1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ffc5ICz1; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777879711; x=1809415711;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zNLVqGRbB+6b2S4Xb+/5fXX7ALEj2JWnjsBbCvzUwVE=;
  b=Ffc5ICz1XQiQGWBsRDF5bKNUfayDao7+vDIoQhS8d5hoQoPZhQgWG2GF
   H1FkoaNU0jtYBC7uX800emqlFsZvUHvcZmiN+u+/VN1mJjOgIgkyfVhAz
   SBbi5jo4yNPkT89EAVZB8v6MSyLjxESO+Wm6yTxzSBogUGZuVtJy2jMYe
   QU1BbTfRTskBs7B11NQJl0B6A3O/QViwWsL6RfwuWSg9IEgnCWwtFCqKK
   wQm1rC59FgRQF4G6GZhaOguNxG5YbqU5EAPpI58j/lLT8daiUQ6wQfHgN
   ulh5qg1K5TyEnDfjUI1dQem/xxzpP8EiiqbGZgxm1CqNPpNTMyIRvBxuu
   A==;
X-CSE-ConnectionGUID: tPIYzEZYSNip9cLqc/de2A==
X-CSE-MsgGUID: ATNxSaJcRGaLMzI4U6NjUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78724347"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78724347"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:28:31 -0700
X-CSE-ConnectionGUID: m7NKSzHXTIuHFSfYNyapmw==
X-CSE-MsgGUID: Y1OSRScxQA+7KAU+47MuqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="231085418"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:28:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 00:28:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 00:28:30 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 00:28:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbMoRMD9akC4/zb9zSp96XRol+sgLGtrs3hKReupx6kqxmnqfi+iEjsBdVJIbGyBCu9qeYmtbD/vHAExyBlZcJaN1Eax5ZMSpGZ7kMdE7FLVIGZke3BbmgWnYkgfSLaxq9Q7lDl5aOV58x4+39OLXV9zcu2ZiRHJu1RoQYgkXUZ6VrT7Zl5KKnNOS6+nKYQH+pdU0NdIfVAf7/opMDIsjITbD6MCr9Jsm2T1B3NRaQDTftEdJy3D+c3d23S5VVrStLCpnGmEEaxTrWcbSgTpHM+IP4p23z5s8MPVj1zWkII0gM7qkSXSGCcbGQfUYXBUCC+uZy17F4dUV2wi85WXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXZIr0RlmyLWBXzfk9sb/MFZhsalgI15TSvLTJenChw=;
 b=EATxC09ANmZcoo8Gs613RY2QKEl3LpJYuSov2KLv2ExMaGoLHueB7sQGUKSHvsq4wwnzTg4ScAJRJHA+xrGq/4fsYztu5YPZGA3J9Pyf2j5Gey6bhLyHJkf7dNpSfMImfTOK36q/pm6B69RMbrY/9OfzgCfqSqFfkHpcr/OlUaySW4kmPqh1muA4MYMAHqUCxwZwB0J312uC5XU5BCrCSYAuPh/rR1GJqdVk6/7jKpHh5v/sWNS/tN7JQgzp6+AxvnSSxVNPdcd4cg6R8qAa98rgWtDzb28R2UxCyhNJpX3bGHv2/DyxpWqCiB5in8AYo5Dg26b4MQ/I/Q0N6njBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 CH8PR11MB9460.namprd11.prod.outlook.com (2603:10b6:610:2be::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Mon, 4 May 2026 07:28:26 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 07:28:26 +0000
Message-ID: <615d5a74-0865-4f42-a048-a32fff23f8e2@intel.com>
Date: Mon, 4 May 2026 12:58:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/drm_ras: Add DRM RAS netlink error event
 notification
To: Jakub Kicinski <kuba@kernel.org>, <aravind.iddamsetty@linux.intel.com>,
	<rodrigo.vivi@intel.com>
CC: Raag Jadav <raag.jadav@intel.com>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>, <anshuman.gupta@intel.com>,
	<joonas.lahtinen@linux.intel.com>, <simona.vetter@ffwll.ch>,
	<airlied@gmail.com>, <pratik.bari@intel.com>,
	<joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
	<shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
	<anvesh.bakwad@intel.com>, <maarten.lankhorst@linux.intel.com>, Zack McKevitt
	<zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
	"Hawking Zhang" <Hawking.Zhang@amd.com>, "David S. Miller"
	<davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, <intel-xe@lists.freedesktop.org>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
 <20260311102913.3387468-9-riana.tauro@intel.com>
 <acPjxf5XTYuR7sbM@black.igk.intel.com>
 <09f253b3-ee64-4fbb-8cec-820e9769aa80@intel.com>
 <adc6hTz-xMopiJsc@black.igk.intel.com>
 <69c061b4-eb40-4e2d-aeaa-5dfa47b2db8c@intel.com>
 <65c6839f-a92d-4122-b347-a1250dde961d@intel.com>
 <20260423092922.6c527d75@kernel.org>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260423092922.6c527d75@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::13) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|CH8PR11MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: 0600d1f3-7eb0-447b-4d01-08dea9aebb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SBR/sJK94AgRgxSCmKc3iL0chh0Q/FGuVUxBqV6shPAA99RHynNYFNfpxiIJXS7J7fQ/8uTgZ/uiNhNpPEcozlfZDrJ3JH/x3acy6taxKt4/OtgiXEyLY8DfQK1x90hAz/8tQDozywezwpPtXDl1szNun9ZJgZWincEpqHTp5+cNGXey/F10+nd3JRkiX3Lbt0DO77qwh6PgQkqJ45mAZuTy3jYftgNOAC0XXftFZ16tLIqKBgo60UYzrRwTui84aHOslGFvgDYeDUMES0V0lojFL/363JUTkhQ80x8rBWdMePRaCk4PDGQld7P2Gb7YHcgen/3yKmHiWcwDZb6V2rkfm3AoHApcGVUZmYrq3vNZI03+f+Wisu5HfgIrH354BAdMVjaiNsv0Ty+GL33GDbmiJM20GYqyXxMeruu4vnpGN4Q80vE3flrBa/sRfbFWjX8zXib2Q43hOu5Pr0tPnPu0FV/RHQHQpzmkJRJzdMK2J2vvSks5t5L9GRkFiPDNRMkKYokSrro0QSDO6GVpNzb1ljwA9uJ0puxbAmOOiiCZR1qNHLP5a663z89be43zV2iGfeaMFoxbIPO2zp000246lHxEXAPPUn+Ji80y8dkHjLgtADRFWhmhqOioje7KsU/CqNK4KxnbD7Tj4SRpGD72CqHdKB48RbV0qUuB1kaFRESDiLVfZY0A8WnCoP+H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTY0cEtvcDR2NFNiN0tJcWVWQmpLU2xtNVJDQmo1Qjl4OFFWUWNaMnE3YjJt?=
 =?utf-8?B?V2R0N2dGUGVSTDRMcnpNRlNtT0Q3WERVcG9jT3AvaHF0OFJZNDJnWTlCS2Z6?=
 =?utf-8?B?b3QxZUZpbVpPOHBETm5DeXROVWQrT1Znc0ZlNjBHK05vaHF0dmorNG5IU2sz?=
 =?utf-8?B?NzlhMTU2aXRScmwvNUtEb2xrS3l2UTV3bHN6RDh3cG5OK2swQnBHcEt2Mlhm?=
 =?utf-8?B?WTQyRUd1M1dacTdUamk0NEltWWM2ZDNuaElMN1dEYjNSYkU3YjJPSEZXZUp1?=
 =?utf-8?B?aFNGaVM0NXZLWmFiTlVsSlN6OWJNdVd0c3BWKzJBVTFsbVJxc3dmR29qeXJZ?=
 =?utf-8?B?MXg3c0hSVC90VGx2N3FsWkhlVDVpMVhiVk9wUWJIVWhZZEptNlRteFp3NXVE?=
 =?utf-8?B?L2Y1RDhZWlY4QjlxaDlWeUxPRzdXbE8yam00YTF2emJNYUM5aXZWazN3OGVv?=
 =?utf-8?B?NDc2cW90L0p5a2w3OG9pSUFaMlpPekRGVDVxZVVoMWZqOGM1dlhpa08wTVFk?=
 =?utf-8?B?M0VEZGk5RmxEdXZoZG43ZG11RnU1UCtZNS9VZU1sZUtJWVA5eU4zbjhZaXI2?=
 =?utf-8?B?R0VZM21WLzNGYk5vMnN0NUhnT200eFFsbGRSa21EV1RGeUc4MDZqL2xMdCtP?=
 =?utf-8?B?Tmx0dmVTUllXOERjSHlqc2Q1ZDQxRWZucUVjNGhPMGNsK2hMU1BWTlhyVlFl?=
 =?utf-8?B?OUpzdEgzdVpaZlRsZ0o2MEN0cGlHZzI3T0NUaXJQYmdVWnJBSXpENHFrU1NS?=
 =?utf-8?B?OGRHN3J1OForUE1hZTQrK2JJN1Z0UmVteDVZOTNxU05HMzhNaEszSktKTExj?=
 =?utf-8?B?czJCeW5OSXZzRVk3SmVsRjd3RU50RTVIaE10L1RodU0rcDR5L1FzRXpNcTNr?=
 =?utf-8?B?dFBOSkNhUGVIQ3pVaDhQNG1wZkxpL0JFUnVWQUtDR2RIL24rVlhLNTZCaHlo?=
 =?utf-8?B?TmluQlBpbGNKV1FzY1YvSVRXQ3VOaVJNcVNEZ0JTWEF4MEtSTEhEYllRYTBj?=
 =?utf-8?B?aG83V29nd2hVRHZJL3pxN2IwUGxyZVR4TnF0S1ZLYkN0TFQ0bFJvbkxJU1dp?=
 =?utf-8?B?eVMwbE1YQXpvOVZTMjdhSVVDVGNzL2VENUNkWFVVWFpoMW54Q2NOblEwbWUr?=
 =?utf-8?B?bWFzc3RqWG92VDhub3c1SmhYelNOUXhUMDhjQ1pVWUxjMmNRRWJJSmU3TGE4?=
 =?utf-8?B?ZnRmdGtYQm81TWV0RVdZSlRYekdGVG5jaDZLYlJYOUJNZkpJR1NhdE11NE1J?=
 =?utf-8?B?Ujk5bkNYUHE5UWx0T0UrZHk4NGNFTmYxTVlwWGMyMmhkZTJjcFFXLzI5Uytk?=
 =?utf-8?B?NlpBTjE5ZnV6V3ZXNDdzeVBmMWtnYm5WTzVaeVFMekpWNTZTRy9HU1Z6QUNX?=
 =?utf-8?B?QnNZUmt2U2NnT213Q0FKQUFEK3o0WEMyKzJJVEhvb0NTd1ppMzBQM3h5b3Ny?=
 =?utf-8?B?eklrQVliaVN6a3ZKOVU2Q3RsNWpIVFlic3pSYnZQZlFLczlWVzRmaVViRm1L?=
 =?utf-8?B?NUt6eGVEdzQyREJqYUFqVXZ6a3BRZVdGVlp1ZGFsejV6VDQzVE9YTjJiWi9I?=
 =?utf-8?B?dktQeVBXbUwrb2lvWkcxRnBUMEFTZzd2OU4xNFYyUVUxU2s4RlhRQW54V0xR?=
 =?utf-8?B?MUxJTmNiL25CUmlKOXhJOGVzR0Z5L2ZvUXRYRlhwTUZvRTNiSHFHN2JJWjQ1?=
 =?utf-8?B?Ui81M0V6NC9CbFFJcnVpdDNzZS9rcFNNbjc1T3Z0UTJxSU5kV1UwU1FIUkJw?=
 =?utf-8?B?N1ZobFZRTHpUTzEvZGxQT2x5anlVTjVLb1U5TjZPOVRYRU85cXc5MHpUUWkx?=
 =?utf-8?B?Q3RQTW5BWEtBVzE3Q3lCN3pzZWlpYnErTlpIbTdLYStLcGJEMm9lMlQ0cjAy?=
 =?utf-8?B?alNuck55MmFjS1FUU1BiY0JlTXJsU3NDdHUxNGE4RUNObmpBb3ZRWndEdUth?=
 =?utf-8?B?MkdIMC8yZWVuc1FFYXc1eFVlZnR3V0lmZWpTSkkrU1Z6QTROak53MzFwK0JD?=
 =?utf-8?B?VW9pSG1PV1QvQTJPZFU4TW8wUEVRTXNSWFdOblRmL3c2ZHRIczFzOENOTzVL?=
 =?utf-8?B?dzVVcjdZUm5ZRm4rbDBUYnRFSVZhekozVXlUNGxBdFFZTGs0bXBvOUZ5M3ZR?=
 =?utf-8?B?NTZLaDc1N3dTTTNEM1lsNDZPNDlCNmcxemYxeEloNlFucHlBTU9ydDRlbEFQ?=
 =?utf-8?B?WVo2OWlaL2pVdSsvN0t5TmJIK28zOURnTnRjNm4xV0hRRloweEU2NHhEa1Vo?=
 =?utf-8?B?dUk4S01wVjFEZEVjbzBmOTEwWkQxdXVwWVlNVHJEYTh1YWJkOU42SG4wYzNt?=
 =?utf-8?B?dEJPUmFjV1RIakFCTDZkd1FpemRiNVdLNmxQS1RGZnZONTd5c2k3QT09?=
X-Exchange-RoutingPolicyChecked: aVSPXUVipsBpAzyEj8xdo69TfgH5i2oZyXKu7ZbuWS5kIQv7CXR07+uvB+beNX+2kOhoh7LdxSPxEawLTh7ruAdu7Oj43fcoAlJkvydwy0l5k+nelFnvs+5YxRDOFLUro0MsxY9nm3QvojwFPGymXHTCzTE/unADRYiQhB2kkfoa4atuWmz6SKYacAh00aZLIG/P1LzQTy0qqjILdKBT60Gk0w/QvjTrDcaYmvCBIKcIUOqSCbSf5CZNUApl/orI4xSIEPWpnffJEun6/Av5vDMM3Xb8wn4BSni20O0ik6lE1ESVO9ppSNMtZ9oaVGbrcUVQ02319EtKhoB6vdQs+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0600d1f3-7eb0-447b-4d01-08dea9aebb33
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 07:28:26.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csv8qX/FSkQqi9bhcUjvZcb30HmhM4u4d0Jwz2D23lUMcXJCCcOyJrs0hTF8O7s9TcuVMP5repARqhlku2gcoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9460
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: BE3964B9546
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-283713-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lists.freedesktop.org,vger.kernel.org,linux.intel.com,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]


On 4/23/2026 9:59 PM, Jakub Kicinski wrote:
> On Thu, 23 Apr 2026 11:22:45 +0530 Tauro, Riana wrote:
>> We had some questions regarding events in netlink
>>
>> 1) According to netlink spec, "Events are considered less idiomatic for
>> netlink and notifications should be preferred."
>> Since we currently don't have a response that matches a get operation to
>> use notify. Would using an event be acceptable?
> I have only glanced at previous messages but would it not work to
> include the counter values into the "event" as if it was it was a
> counter get?

We wanted to keep the notification general with error name and node name.
There is another series which will re-use this event [PATCH v7 3/3] 
drm/xe/ras: Introduce correctable error handling - Raag Jadav 
<https://lore.kernel.org/intel-xe/20260428054826.1202076-4-raag.jadav@intel.com/>
<https://lore.kernel.org/intel-xe/20260417085812.4013309-15-riana.tauro@intel.com/>[PATCH 
v4 00/13] Introduce Xe Uncorrectable Error Handling - Riana Tauro 
<https://lore.kernel.org/intel-xe/20260417085812.4013309-15-riana.tauro@intel.com/> . 
We do not have the complete counter value there.
@Aravind/@Rodrigo Do you think we should add the counter value to the event?

Also, there is a request to add other parameters in the review comments
so cannot re-use get-counter response

>
> If it makes no sense - it's fine. We have been adding events in some
> places, too, in networking. The thinking is basically that when the app
> that does the user space monitoring starts it will often want to know
> the state of the world. So we end up with "get state of the world"
> and "notify about state of the world" which should really be the same
> format.

Sure. Thank you

>
>> 2) Is there a way to check if there are subscribers to a group before
>> creating the event message?
>>      Currently the subscriber check happens in
>> netlink_broadcast_filtered, but a reviewer suggested we could
>>      optimize by skipping message creation if there are no subscribers.
> Yes, genl_has_listeners()

Thank you

Riana



