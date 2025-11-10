Return-Path: <netdev+bounces-237371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F1DC49BCA
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 00:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDE21883BE8
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 23:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9424E303CA2;
	Mon, 10 Nov 2025 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAqgWK5+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA5302CCA
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817010; cv=fail; b=vFRgLST68ZeSFf5Ajz9SklSD1TlHxi9nk5yARn70nm86hsgWvV5mYeuCmpgMDumtCYVb01Vzez6pAaGQ5IMko6vdFBXTx2n94Ub4xYUzvbH3sLddKf2oRte8CVPgzG/MGlIJ9iwz7ijMj0NKs+PHHHNpcd6uHAKyAjzadyRh8LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817010; c=relaxed/simple;
	bh=MUmFEjgq5biEuuYvxBpH0BYepyE7MxHvIfcA3ZCgw8w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hUP9SNAuvQr6FMwuS2Pkk7J5JsrlyzfbMaIZGQ5W/55p1vUQJgWle+aI4OLgLdhJWq0tH+c8JeD4twFVRMCIUChSuVt7oBVUJgl2aDnTogtbJvR0RlhwXQqvX9j0jWZtx2HnCE/9VCHpO2JIBfIjNTAjdmxngzOMs+gB3d3+kRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAqgWK5+; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762817009; x=1794353009;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=MUmFEjgq5biEuuYvxBpH0BYepyE7MxHvIfcA3ZCgw8w=;
  b=NAqgWK5+JROPXLsNBF1TgavxQ5dnhtjy3uRTr7tML/Y5fwf/twl10UtK
   fI+voBaovar2CQnU+meFRssLZHCn7nwisE86dI71fh4KpsjPO8fVGrbcz
   Y/4Gs+K2lL/dlc0mDcYE9NlNQgeqqUU2p45B1MttC2j0i4vqxuscM2r0A
   F0SSgSnuyUk8IruVUmKSGzjbIEZJuzOtIdfeg6g4+iqq4JXtv/T6x9iSy
   KVR65Ws3X4soc77tGU/LUF1Afb7bbyYuG+EOpTWSA0tlJ1y9/ASM79rd3
   vLlnthiGXCnC2XozCpaxRm4TCKqun0aKZ7tUjjEfMHO1RBSBjJXWWjIeQ
   Q==;
X-CSE-ConnectionGUID: Go5aR/DaTR6U545ORdSLdg==
X-CSE-MsgGUID: lBlhrhneQBC57EHmnoBk1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64909389"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="asc'?scan'208";a="64909389"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 15:23:28 -0800
X-CSE-ConnectionGUID: YuoxQz41Qv+964ZNUhazHA==
X-CSE-MsgGUID: hjaqh7c+RUGXHab+asMzGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="asc'?scan'208";a="189544384"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 15:23:28 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 15:23:27 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 15:23:27 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 15:23:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGK7uch0L1er4oIBFPFfdB41U1vM6KVYrigEs8hCeOZ7QB508ei8yY0Zhwb3UHBKNiAOM2PMb7fIHvPThEjAtRdwFe1Nzp9g77mjH0ITa7MZti/QDm5m5WRav1FA0Mi0GqQCx+yMRonQFvmYPYgr5YzzJ7XzUJP6dRotoq9WbYq2mZiywJzJYM5EHpuLK/hdkCFqXU2L4ZnJC9lhQBX2iU34d1bIO06xWaQl6ycGxWvj0bvSwqrsgJbIuDLR82nQpQj4gIFpB9smXyHh8WTU1faQy1y78wvlsNgFPxpwdekDzssMi6R6GsMsTkg1Ac4DCo4w5JBj3IxfKsXNtcsRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyHvqN8gwWGY3Wg0inMFMt68eQcWd0MnPjfl9maMLMk=;
 b=npLI5lvA9hleXc8Nyz24jnkXXTvHI8LzIzgRbccM5O+s0fH750ZCDQ3+l1GIFF4YutVIkisyyIcESOXF00J8X+LM/PWm3E2vJpxDzGeswoGuMiovIVVVgkVu+rn7LvcJ8OkaptEg1zXmJpG40Ok2ZfJfyaH8lpGRAVPqMPbKKhyM47FTdedBiSvrkpr9QRUdMomnEBnfdn70tEgH6yPJYAG7yVWhkDS9YJJmo4libuG5IWnG2UaavUuxnubHKg5+ph4OSDZRl38l7ytiQkDzVr4lG2Yu5fX3Z/07BGmwwyLW9V4Hs91iziR82p307H9dP2EKuNim0fRo6dG+oyGXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8774.namprd11.prod.outlook.com (2603:10b6:610:1cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 23:23:25 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 23:23:25 +0000
Message-ID: <8a91d75b-3ba7-47be-9176-5d2245ac4fd5@intel.com>
Date: Mon, 10 Nov 2025 15:23:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] bnx2x: convert to use ndo_hwtstamp
 callbacks
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
	<kuba@kernel.org>
CC: Manish Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>,
	<netdev@vger.kernel.org>
References: <20251106213717.3543174-1-vadim.fedorenko@linux.dev>
 <20251106213717.3543174-2-vadim.fedorenko@linux.dev>
 <20251107184102.65b0f765@kernel.org>
 <dd7258b4-266f-420a-b751-4429772a47b5@linux.dev>
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
In-Reply-To: <dd7258b4-266f-420a-b751-4429772a47b5@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------3N0081sd9JU8aQuu6iHJtb5P"
X-ClientProxiedBy: MW4P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: c774fcf0-5912-427a-2968-08de20b025a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXpjTXU5cDRyMkQvd1hwV25xUG96aVUrME1pV250RkpON0NzdHh5NldaQ3o0?=
 =?utf-8?B?U2hkb2ZSM0ZWdW9yYTBPcjA5UTgrbms0ZFlRbHN0bllCQUpOSzRsQzYxeUxj?=
 =?utf-8?B?bG1uUzVIVzRUcWQ3YXo3dThaU2RReG1ucGt2bzZtL1pYTVl2Z0o4Mm95MGVK?=
 =?utf-8?B?RU9IRHlCS3I0NnhVdjZHM0xpMzNtVmxSTXQ3N0dwTTRkc1RHQjFmNE9tazVP?=
 =?utf-8?B?WWRiSUNLS1czYWRjS2VxdWpkbE01TzdKZVkwczBRZ2JRSnlCbFh2d2xOekI2?=
 =?utf-8?B?NWhBT1BUc0s4akdGY05MYjBrRTI3ZXpDZEhGNWxGTWYzVzY1TDdnR2xmeVpS?=
 =?utf-8?B?bGt2dXFrRGZtTDNnY05PN0JMaDhidG95ZDZoRHlvR1dFL1AyakpZZGUwY1pZ?=
 =?utf-8?B?VCttZ3gxT2l1ZVNyK0tZOTNQUEdUMjlKYkI4OGYzWVZUWEhURjU4bng3L1JG?=
 =?utf-8?B?TWJrRnJ1enBlczRIQWRpeHhBVkZPU05SMlVFdXFlUWlmQW10ZFZUeWFqRldP?=
 =?utf-8?B?V2VBUkZ1MFlOMHE2MzVqWmw4VzRiNDNiVFdNanhaeC95bDZjdUtTbXdzbmRK?=
 =?utf-8?B?cHl1VUU2ZENxNU9UeEZTaS9wTU8ybXZGOW5jMy9pMWVsWERVcFdPeWJueHBU?=
 =?utf-8?B?enhwZnBiZmExRi96Vks4STZiMklXODFYdm9udVRNLy9JY280S25EK2lWWFIx?=
 =?utf-8?B?YjVMcXFFTXc4VXA3T3JkclhFeEZiVTVKakkyV1JrbUdlS3ExaFdzaEZVU2pF?=
 =?utf-8?B?TmZUMHlVRmt1V3VJc3kxbmRnTEV4akFFbjlNZ1pVSjlPeCtKZ2k4cnFDL2VM?=
 =?utf-8?B?YzBWV1ExQkk1U2M3TDB5Rng3YUNhT2JwQ1h3V2VvVkhCamVFcVlKMjVvaGFC?=
 =?utf-8?B?Ni8xU2taaDJIRU1rSkNhbDV0dkt4aWJ5RjlQa0docXVXRkJHWnh6bHFKOFlY?=
 =?utf-8?B?ZDVSN2tDSGxnRHM2NDBmdjhNcGE5R0g3ajRqUFVDZUZIcnRVMTZWUEJjR1dp?=
 =?utf-8?B?Mis5aUFmVURpOCtheVRHUkN3ZE1JalBhdEFObm93R2MvL0s0d1UyMzB3MUNR?=
 =?utf-8?B?ZDF2ejkxeEliRVNjWTdoU2k0Vllwcng1c29sUnAxeDlPRlRzb0dOQjJOUlg0?=
 =?utf-8?B?YzdTWUhVcjh1aDdNUVcvakhKWm51L2pTODlOV2F0dHgwWkhFeDU0em8zS0V6?=
 =?utf-8?B?UWIrTDFoMkxpMVRlN2thaGhtSkpEZks5dWxvTHRscE91NXN6TVJYdlhJMGN1?=
 =?utf-8?B?eVE0ZHFaN1pRb0lNa054UVpjZklhV2s2TGlua2JjQ0dSVDl1emxEbjg1L0Zm?=
 =?utf-8?B?NkRwVXYyM05aMGFSVU9iOUN6aDBKRDlYWis0L0JyRXFvNDUzU3hXNzZkK21p?=
 =?utf-8?B?a2pZVXRwSy8wdExwTTdnWXJEMEZ0VVo0NU9tMlNzbjdIV1RCalMyL2xXQWRw?=
 =?utf-8?B?dGk3dnFJaGtDbXJFSGVQSXNGWmgxM2hjWFZnK1dXNUNiZC9HajZlLzUxemM1?=
 =?utf-8?B?ZmRFN2VWYkpYYUptdlpJdDE4Y0k3UXRoTHR6NWNxRm5XZHVpanBueTg5OGov?=
 =?utf-8?B?UjhHMjNySWZJNmtHa3FBM3QzclZFUjJIMlBiaDB0NG12Q3VJT2szWU9maEhW?=
 =?utf-8?B?WnNjTXltb0QrTUhNeXluT1M4WDQ5YUxWSXRackxMRlVXY1k1ZHQxSVRReTV4?=
 =?utf-8?B?UlpxejRWdTB3aDVvR2Z2TjFKOUdJdW9ocnkzSmsvM2JBa3dMaFlRSE1NV3dk?=
 =?utf-8?B?Z2JzRWxERFFPUlhQdnpYeGpBaHpGU0Z1czgxRTBNUDBEczl3YWZTK0FmK2Rk?=
 =?utf-8?B?eXpsbS9ZYUk2aXJ1TVFycjdiSkx2R2FHQ1E0bC9lbDB4blJQSWticHdsV0R1?=
 =?utf-8?B?eThscGpNeE82bm80U0xFRkpmSEduQjdydVQ0MWUzRE9GN2hpRGdBNUQ3Zk1Y?=
 =?utf-8?Q?vWdZr4AmVn4i9zlRK5za0igQUoMxAI1U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjZWVGs3aWwyT3Nwd2NLUTN5c1cvL0FkMUMxMS9veW1aSmdCZ0xGQmszNVRD?=
 =?utf-8?B?VVlJSkh6czB1K05KTFhMQXZHT1M3bmdUTjl2WTE4ZFZEbEZPaURjZ3BXVGl1?=
 =?utf-8?B?dEVITVA5aGlUZDJ3VEh1MVVIMklFSHkxQk16RHZJR2hyNWtZUUVpS2o0Z1pP?=
 =?utf-8?B?TnU1cTJLdlZ1VnZjeUZmSXcxa3NFbjczZ2lXUjBSaTlSZlNZVWFjbk5sTFRz?=
 =?utf-8?B?OS9Scm1qK2RMODJ4SG0wOFJ3OEV0Y0FBOFJrd05TOCs5VlE0YXMrUFBPam93?=
 =?utf-8?B?YXdYUThIUFcvNUYxN0lKVXNMYStrSWVaMkRtK0xQUmhnNXY3Q2NqV3NmaGJx?=
 =?utf-8?B?WlhBcHFDakN5Yjh2eUliYUVSUkFBSXE1TGtaV1VHZnQ3MGVyaUFPeVhuS2ZC?=
 =?utf-8?B?V1NHcGhVbnJiNnA3bC8rUHhyY1pobk9zdW9yKzhMM2o2L2pyeFc0QThRaGo0?=
 =?utf-8?B?eURIZkxyQzhpNGxsMXNJaE4ydjNZWUx0RU84ZXgrY0ZXL2JDMUFZY3Fza2xW?=
 =?utf-8?B?UkEzc0tia0hjM2R3RnFIa2M4NFpYR2VNSFJqYjRIYm1yY1gxSXJPVVI5TDhS?=
 =?utf-8?B?ZVVuMzlJclRhRHBkMEVuYU5ldTlUTWRSQm5sY21LRGQ5L1pwaHo2NG1xOElO?=
 =?utf-8?B?dWR2c2RBa0NpMzB3WHhIS2FSTFMrOG5pd0JkMlNUaDl5Mkk0Q0drUW9CeWVx?=
 =?utf-8?B?Wm1nR0ROMVNEbXZNeDlHYmVzbnRMeW9XV3hLdEkxWGdpMno5QjJtVTlYMjlF?=
 =?utf-8?B?V3Jjakh2MnM4UTh0VERuWGc2NnFoaU92aFA3cWRRQXhHcWZPY2xNOThxaU82?=
 =?utf-8?B?R2I0MmJSTlorbXg1UjAzVE5lVEZWN2NEaUlPK0MwajVxcEFQaEI1VnhXOWRp?=
 =?utf-8?B?dTAvT2xvNmpqWVhJQk5HSWJ4VnAyUTdDM21EK3pyM3g5VXJxODFGcVk3QmtX?=
 =?utf-8?B?SXpZTGorZXV1Q3VVYlFYSFB4T3ZQMlZJYUI2QUFmOWNCaWZMS1R1MUlVeFpL?=
 =?utf-8?B?MHNKSFZKdHFwMVhwN2tlZ3hENEEwelgvZGxwcDBnRDYvYXdjTkxEOXVhU0pp?=
 =?utf-8?B?elRDT3hpbFhWL2Qza2tyWmEyc1hjMk02TGkwT3hjNmNYdGVGREpweUR4SVY5?=
 =?utf-8?B?STFvNHZRaFlsQVJFSjZaeFlKbFdpZ3NTeE5hVHdvdGRTN2VnTGZ5eDhIM25y?=
 =?utf-8?B?d0NZUUlBMVZBSVZnSkVMUW5ybjRHOTlMbGFNdmYvM3kzTk05OFBhVzhLVnla?=
 =?utf-8?B?QWRKTFA5dVY0QmNQNXhZaGxCcThsZmRkSnNFelFrL01kVFRieFhUdnAwaUZN?=
 =?utf-8?B?UW5wTDFjV1Q5TVl0QWxNMzVzbkdFRU1jV1RiQUowSWp4STc3ay85Y3pJRXlG?=
 =?utf-8?B?b2dFZUdsSk0xWFYvNXlPUmt4VWwxSGYvbklYLy9yak9vS0JTQjBoY1FWZGt3?=
 =?utf-8?B?RVBTVURhQjlWd05HcXlNbVJ0WjE2a0tSTkVYMHVodUQ4QmU1cUVVMWlJdG8y?=
 =?utf-8?B?TzlJdVlaODNUS0I1V2FGUjA0OCtoUmtTcTBLQUpJLzdORlNDSmZpc3ZTcXd4?=
 =?utf-8?B?ZVZlaTdyc3c5cG5iaUkrWVh0OHZlWUVtOWxPSlJJWkJCY0FmZkZmL0J0MjJQ?=
 =?utf-8?B?Y09rVGtjNWJydzBubXNUTnRiQlZsek5lV215bDhjUHFZU1lwVHRGT09DUkc2?=
 =?utf-8?B?VUJwSlR0MG53RUpFdS9heCtab1MvWWVhL2ZFek00TGtzZmtQMGJhSTZoVEhS?=
 =?utf-8?B?cVZyL2VkQ0RhNWtNL25zcnF0Y2hBck5DOGNLTTBzd1pkdjJrM2psemttQXdL?=
 =?utf-8?B?ek9WaS9wYnc1WUZWZ3MzU0tPb0Y0OHZabkVWcTRmU09yRFIvUDNRalp3SnZj?=
 =?utf-8?B?ZGhZTXhjNUw1eTZZaitkYVUvOVdnZHRSeG44L255SFZMdjlodDBOUnZuWkUz?=
 =?utf-8?B?clEyMUhhT3kvRUJkVGF4RG5CQ2VlVzFWOFlSQ1pEWFVQaXMvL0UrUjBWM0JE?=
 =?utf-8?B?MlZyN3B1TDlLaWxOclppU3VEZHRrNXVEM2hUOXlUUitOaGZrckdMMlFwUk9W?=
 =?utf-8?B?NCtTVWMyZjhkRGV3Tys5Z25BSUFFUTd0bjJkazlpSnB2YWw1cGljQWp5UWJ5?=
 =?utf-8?B?TjlzS0V4SFpkWDYwOG5LUjJnTHZ6a0kyQW1XWDJwMFlrNHBXMjg4R3QvUGhN?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c774fcf0-5912-427a-2968-08de20b025a7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 23:23:25.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpAC/67l5fvyubWXVuXTAYV6/l6TYimBI0p06zJecDK91SG5FiPJio9zbrgMQR+7LdOxw8zqX1VDn40INksy6JLH9HGfmCdJpxoVGyOcYI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8774
X-OriginatorOrg: intel.com

--------------3N0081sd9JU8aQuu6iHJtb5P
Content-Type: multipart/mixed; boundary="------------Y2utAcCIuQDLCgAgPAVzJ8pK";
 protected-headers="v1"
Message-ID: <8a91d75b-3ba7-47be-9176-5d2245ac4fd5@intel.com>
Date: Mon, 10 Nov 2025 15:23:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] bnx2x: convert to use ndo_hwtstamp
 callbacks
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Manish Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>,
 netdev@vger.kernel.org
References: <20251106213717.3543174-1-vadim.fedorenko@linux.dev>
 <20251106213717.3543174-2-vadim.fedorenko@linux.dev>
 <20251107184102.65b0f765@kernel.org>
 <dd7258b4-266f-420a-b751-4429772a47b5@linux.dev>
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
In-Reply-To: <dd7258b4-266f-420a-b751-4429772a47b5@linux.dev>

--------------Y2utAcCIuQDLCgAgPAVzJ8pK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/8/2025 4:38 AM, Vadim Fedorenko wrote:
> On 08/11/2025 02:41, Jakub Kicinski wrote:
>> On Thu,  6 Nov 2025 21:37:16 +0000 Vadim Fedorenko wrote:
>>> +	switch (config->tx_type) {
>>> +	case HWTSTAMP_TX_ONESTEP_SYNC:
>>> +	case HWTSTAMP_TX_ONESTEP_P2P:
>>> +		NL_SET_ERR_MSG_MOD(extack,
>>> +				   "One-step timestamping is not supported");
>>> +		return -ERANGE;
>>> +	default:
>>> +		break;
>>> +	}
>>
>> This is the wrong way around, if someone adds a new value unsupported
>> by the driver it will pass. We should be listing the supported types
>> and
>>
>> 	default:
>> 		...ERR_MSG..
>> 		return -ERANGE;
>> 	}
>=20
> But that's the original logic of the driver. Should I change it within
> the same patch, or is it better to make a follow-up work to clean such
> things in net-next?

I'd prefer a separate patch for clarity. A backport is probably
unnecessary since I doubt we'll add a new timestamp mode in such a
backport in the future.. but functional changes like that make sense as
a separate patch.

Thanks,
Jake

--------------Y2utAcCIuQDLCgAgPAVzJ8pK--

--------------3N0081sd9JU8aQuu6iHJtb5P
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaRJz7AUDAAAAAAAKCRBqll0+bw8o6DBu
AP0R+k3zqGLdLBEo2WG2y6Avuq98UukZ9t/Fr9n2tUIcBwEA9JpkquQgDkpPSTagCRroLj7vVCuh
EoEFS4XSkZa9GQI=
=ZlRJ
-----END PGP SIGNATURE-----

--------------3N0081sd9JU8aQuu6iHJtb5P--

