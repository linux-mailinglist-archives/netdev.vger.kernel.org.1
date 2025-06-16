Return-Path: <netdev+bounces-198316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1767FADBD36
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7033A3041
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212702264C9;
	Mon, 16 Jun 2025 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwoHjxS0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3883F2264AE
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750114114; cv=fail; b=hrSDBeOMRob6rO50dJT/2FZwiJxEHgNI33nMIMakzXQngzQI+7EMaqrYY6UIHdy3aIFEa004a+eeU3pwaPIFe01r6ItpnnLanB6TJtQrdQCw/I/wa5piq2qxXc5NQwkRfe0CVSbbXAakFV5lhfiOO5d9mkdiBdJxRSZaNI0fBRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750114114; c=relaxed/simple;
	bh=Vsx7GeaYzQXtMvI3EwIBojhkwT8sbVGET6BwPBPJQpw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OxfSHQosh6hw/LyxCgcy7P+/mVm0h65FUp2hVnNXLu75/rG8nDDg05f1xtH29QswOkuzZCHJB98cP6q/UmDKTUsykkDwHiNVPM0pR18f86IkNjDytsrLbyu+O0Z42GOaZfx6pAabQPHFjzYLLMEYLFH836xd33Yls1fN1TSImok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwoHjxS0; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750114113; x=1781650113;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vsx7GeaYzQXtMvI3EwIBojhkwT8sbVGET6BwPBPJQpw=;
  b=cwoHjxS0KNDVyqiVAWCOA4lELUYUNZpLOxJRCyYBKgkBpJhduULG5vHy
   FksymXMwFKgyYZDnvXSevl5vofjT6FYLzcAsCNPrCy4r4JpkJ+XjcoItm
   WaqZTjuztTRm7WP/LmQkaWkyZOXyLnz+feFjeVScfyVJEJ6oyzW5kmAD2
   QglTOPUizlk8G26307IJ3Y0r3z8RkV3FTeyst36TQsfB8aQRJlXf9cvFq
   fczzTTF75sVJT2b+rvgDTihUkCIFx1+FCCssbCWlIO5GEWhEQ1IFyGT20
   dhjVcMGgMRA2aYTTQQJZirLUOt/t+AKAuXLYD+5ETwRusOyOsBqrLIBj/
   w==;
X-CSE-ConnectionGUID: d52V3u3hT/6Sfo1lujNEiA==
X-CSE-MsgGUID: RXRLybwCQ2C02AFf4xwVlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="69713338"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="69713338"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:48:32 -0700
X-CSE-ConnectionGUID: m4UpGz4BSgaLstOI7MMFNw==
X-CSE-MsgGUID: 3JeHoL9fTNaAL+1AaOAHEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="153894121"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:48:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 15:48:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 15:48:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 15:48:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GI9cvY7FwiZ0KbJU2ly8JsjkqmJoHKntA6/TkWZP/k//F0D5Rx8YLlzeMwgBMw1U8NYdDMT5EocPDDgzc/3xgvZyhY3qO2lxY4y1n/efUCD2TaYxpGC/fbwMKlqGz4DqHNc90Ycjh3RtDQC+HKov/URT8wSatSg9s2NRRoV1p5p1UIQhkj2hyhSV9B80zvRA3NxpQxwxRBKQ8ugQ2xg57hYEs+MnKk1vD8tIn5KWhahXuBKB+JGN6wvo5jf2g6mgkZHfGAjPmOg4++z4v1rFSVeAv8Ctpdgtpi5B2onlRaulOA3pjCtwLmBHX3pD2FLm7h1JhpRcuj4UudoRRRVJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkS37TWZQ3hrZZB6W7e+SWm6RTgGxbRlCxKtr9xaiuU=;
 b=bMTSk1J48ARxWfRanfEqgjIiJtdIFuC7zhl1RZbWqwfzh8VLM8G9I8UE0lDazepqTx4eo515IPwR9/yhuCzXpdD+2A2BYN4KdkGI4OM060oMfwvRDYq8SirtJa1qbVYsns93RtY87uRJu0oyIJ0NOINrPfXtr8oJIBBwLTHEOsBpY4JAdQ+ENaHdQSTLoiKkPwaCtrL2WPl3hDtR2o7YwqrrfurObTgcGQXkXNGuaOhi43zRmw+Lg2AIWAW8SRo8RtVzD85PuzvWwOtgbKHn0r8C8zGPNL0mHdQEiPw8rKxFirvoKZlwJo5HN/mDCQn7sg/FK17LgsTZGIUu3FP/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB6818.namprd11.prod.outlook.com (2603:10b6:930:62::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 22:48:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 22:48:00 +0000
Message-ID: <8020ee44-e7b1-4bae-ba34-b0e2a98a0fbd@intel.com>
Date: Mon, 16 Jun 2025 15:47:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dpaa_eth: don't use fixed_phy_change_carrier
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, David Miller <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Simon Horman <horms@kernel.org>, Madalin Bucur
	<madalin.bucur@nxp.com>, Russell King - ARM Linux <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Joakim Tjernlund
	<joakim.tjernlund@infinera.com>
References: <7eb189b3-d5fd-4be6-8517-a66671a4e4e3@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <7eb189b3-d5fd-4be6-8517-a66671a4e4e3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0376.namprd04.prod.outlook.com
 (2603:10b6:303:81::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e56547-b636-4dcf-aa67-08ddad27d860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YS9UckJwRnNHdGlJdVNybUJHa1Yzc1dnM2EwWnBHak9kbFpDdTdFQWY0czhx?=
 =?utf-8?B?MXFyOUtlZVdCRi91b293WTVyaEdSSjhtZE1sR0NZR0JHbXFUQjErZDFJR3Q4?=
 =?utf-8?B?TEZpbDYyL3JuVzRFYlNsRmZKSDRkNlc5YmxYQVdVUXZvUEhMaHh2eEVuSUlZ?=
 =?utf-8?B?Y3FtdmJhekxLU0FOaURyYTBFaW9zK3lGL2VaWVBwVTBJVXBXdE9VQWhqamlR?=
 =?utf-8?B?cHdaOTEvc0Jia2JCUEV2RGpUTjUvMEhUMFhHZmxhazJzSW1SRDBKdnBhWSsv?=
 =?utf-8?B?Z1h1Y0JrZk1yeTMxVko5dzFCdXRCTGYvMUNxUE84blN1YWJoNVhINDYvRjkx?=
 =?utf-8?B?VmxJMWRTQjBKYklmRFNXdXJtTmczU0tLbnkwOVRybDRJUGtvRWpsNktITEo2?=
 =?utf-8?B?VzFKMUtrRXZDUDNpYllFa0pnTS96M0FwOGdNQ0RqcEZCcUNlcHdFc3luYzFh?=
 =?utf-8?B?NENLaTFqSUdqR3VLTVgrZ1VYNmFqbHFNclp5MHNSd1FEdTFnNjdHU3Z2ZVJp?=
 =?utf-8?B?cTBFTmRacEdaeWxuOUFxeVlqdXV2STI4Z3RwaFNCRzFYeG5nZXY4RllGMm15?=
 =?utf-8?B?eDd4Y0tWdWhGR0VSd3FETXlWK1g4Q0E1eFpWd2JLREdjbGg0QkoxekJOTllG?=
 =?utf-8?B?MlA0UUxrelZtQkFZVzhrem1DQ0xHbXVhSjBJVHh6Tld5dnUvdzEyMDhVNklW?=
 =?utf-8?B?TUh4bXFlNWdtUXVDMGExVzJzZ1k2VVh5c0hiSVpETWxzeXU0cndZVlhvc3o0?=
 =?utf-8?B?Z0dFeG1lcExuNzhSTGthVFp6clVRMS81OGJhVHdmWnBQZHFRK2htZmZoTktD?=
 =?utf-8?B?TEgwU3liaHJvOVM5czkrR1p1N05GUDFSZWFiYUlmbHFha1VabVRXeW9VZ2Vh?=
 =?utf-8?B?Vm8zUnlzTEEvalczWWNYQkdJVGdpKzNteUJGVUdzTXRSd1dsQkhxZHdGZzRy?=
 =?utf-8?B?UjY2YitQV3pOaGVER3hKYjFlZGFtMWRTTlEzSU9ZQitNa1B5UFZvRnNBVGhS?=
 =?utf-8?B?QXVvTitSb21XSkZMNjd3dTVzb1gwWjA3WnM2bTcxalczRDhlcFpHcHppaHBT?=
 =?utf-8?B?RUtvSnR6L2l2WTNNTjJPckE3aE5WSWswdTNhNHN0cUlPUXdmRGdFMkI4RTk5?=
 =?utf-8?B?TXVYRE5UcUdwK3dPVXBqTjdGN3lkWHNtOG5uZ1BOWFFwa0kzRUh6R3NZcmxH?=
 =?utf-8?B?bmNQN1pOT1k1eFY1RjNpMFA4L0lSN29YaUV2bm9FRXVPVVZHUk9lUklWR2dS?=
 =?utf-8?B?YkJiV050MDIzUmdsdzU4TVNjcE5YdlpvMXF5bklwdmhGdGF3VWQzUlpWZFJj?=
 =?utf-8?B?SG9xOHJYSmVwdTBIWFdhVXNrSE5LUnNYak04WEJDWmRlSWxBNG43b3RtUWpI?=
 =?utf-8?B?aGZ4VnZ4ZWxRL1U1TGpUSHVRRzdaOEpZZVk1NUg5RzVObkwxSzYyNXFUWENC?=
 =?utf-8?B?NmFOYUJDS1BPNS9ZaysrWUVnSDRsVFQxRnBEM1VySFJJTXp0NXVvdWpOSnkw?=
 =?utf-8?B?MzYvcTRGU2J1SGdRRDZlRHJKQnBrNzR4TS9vbnN2MUIvQi9sYkk0d1V4L3di?=
 =?utf-8?B?dHJRR2JkUnF5Z1pLVWx6cnZVUUNWQUZGNzlCSWtOb0hXaDN3NlRtbklhdXNP?=
 =?utf-8?B?UzV4bHJCUHpzNStBUGNpNGRTZk1PWXNLRThzZkYzbXc5QW03MWFlb0s2eHpr?=
 =?utf-8?B?Ny9aL1AzSVNSODdmeldHY3BjWG9rZ2F1WEpjTzFMbVIyYmNrMEFmMktvS2RF?=
 =?utf-8?B?U3hlMW9aWXBJV0p5RjNsYnZTSCtEcHVraDVob3c0VVhYekJNaTQyL2pJMzlj?=
 =?utf-8?B?d0Iya1lReTI1azc1QjRZQjJnenVEeUh4c2Z5dEduSWFUQmlCMVI0b2NZODN2?=
 =?utf-8?B?ZmhsSG1KWEdIN0FKNGVja2NPdjBEM1ZKaW1SdnRDWkJ3YXhyOHQyQUI5ZDY5?=
 =?utf-8?Q?guh35QXwT48=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUhBcjNyc0FiOTA0eHJqUTBVczc3bVl0RW9IQkJQWW9iQ0dCRjRzUmEvenhL?=
 =?utf-8?B?eVExc25rNE9oaTVjRGZ5Q1ZNNk8xRjJ6N2pSWHpXcEthemhPeXRsNnZCUStQ?=
 =?utf-8?B?cGtSRHV4MnlUNEFTUGRjQ3c2ZFphZXNOeDA0WndsQUhJQzdia3lxbHVBVlY4?=
 =?utf-8?B?S1czaGlWV3NlVmo3bEV0NmdBMmNBWDRieklrVEdENHAyeVk5S0lIL0tiaTZx?=
 =?utf-8?B?bWwzekpBRGNaQVhIWjkxbjM3WWxPR3h0R2lVNmMxVFErVjBGWURyVFZLSHR5?=
 =?utf-8?B?RlRpc0RYRklDUGRkT1g1NTZKbXVVNXhtdHN2NU1nRUYzUVdLai84S0dyZjZX?=
 =?utf-8?B?QytFaHI1OWx6MHNzUU8rZmdMbEdxNlI1YmV6ZGJzY3ZOUmc0MkJqYkpWUVB3?=
 =?utf-8?B?aUJsd3diVDk0QitDaFVFRGs0ZUhjRWdLMG9tcjg2Z25sWFdJSHgrZkhDaFZF?=
 =?utf-8?B?TExObThhRkxtWFZHdXg4WVozVnVyeG9XV0NMRHdrV0pHVDFjTkVXaTNNeFZL?=
 =?utf-8?B?ZllBYnR1L0F1NVFMTVBXTTRKWmpIZ1U5aVZQdjR0UnJ5cWwzTzdPTStIaW0z?=
 =?utf-8?B?djdlR2dlekwwLzhTeGQ2TTJ2d2hxRnlXcXZPZEhrdDlseUFNWDhtSzh6a0NV?=
 =?utf-8?B?dEQwaFduaWptN0x6dE1OeUxiczFtNXg2bWVqK0wrUXVXY1VLSXlVN1c1MmdB?=
 =?utf-8?B?QnVRVk5ncjRhNkZjSUNQWVR4cG55bzBPN1FQWlBESjBLRzk2dHkxVU5tdDdm?=
 =?utf-8?B?L21Ea0c1T1pYeGtRVjNQdm1KQnhaODA4a1VWTVcrTHRGNTR1WmZMMkphTy9r?=
 =?utf-8?B?YWZKakx5SUo2ZnZTM1VXb05iZ1kvSUZEOTFIM1lLa0J6UkxJd3dETjVVTEFp?=
 =?utf-8?B?N1hzejhySURqVjlUQnlEQWVoWnlwb2hmNXloNTI1bkkxQ0FDd2VtZ0lFcndK?=
 =?utf-8?B?MEJsbmlkVUhNTXU1NXhCbEhweFBNYTJ6amRjdnlIQlJabEhzVWFWY3IyOTR0?=
 =?utf-8?B?ZU15VmpQMFlZdnlxbnM5cFlSUWgwcFNQUWJoTnJrTWhVczFWS2Z1TDZ4VUxu?=
 =?utf-8?B?ODF4dGsvTTVRRnZ4MkF5WVRGMzRtYVRvWUNrT05PSXdWaEsxWEtpUHRJSEc3?=
 =?utf-8?B?M1haSmJmQ3dBd2FPMlpyVDVpeGlpOExDVlBCQ2ZadmQrT1UvaTA0dHJQTU9h?=
 =?utf-8?B?SWQvVUVUQU9yUE1rVjlLSEEvTEdnbndxRmVLcGxtV0tRTDg4eVJBZjVMd2Rv?=
 =?utf-8?B?ZThFUFpEcjRqWWc0VWx4UmhNNXZRZERncDVqN1RCSFhyKzdXMlh3Y1VldXR3?=
 =?utf-8?B?dG9vMUZzTTliVjV3NEF6WERScFVGZmJIeWRRc3g4TS9Udlhydm9yV2VzckZj?=
 =?utf-8?B?R2x1cG12ZkY1L0FkVVdqcmZrZEx2am9FK2owcEp4U0hwVmtiUThWRmRmaGsr?=
 =?utf-8?B?TFA2T290cXZaTysrckd3RHorMmFRNmRxeWhRV3BzZlVaQW1VS2tGS1dCK0Ix?=
 =?utf-8?B?TzhHbnRJQlVRa0hDZXF4S0FWYS9tM3BDeFdhOFVQalVXTVRydWhKRHVXSS9B?=
 =?utf-8?B?Wmd5YUptL1dIWjRpN3dlN24yUEZ2NWorMlBJekkvU01NRVMzVzVsVVJMRlE0?=
 =?utf-8?B?VVdOZ1ZUcGZGeUR1YzhLeDJCbmFobSsyanhCN0gyK3IwQk9Ib0FmRlphQmEy?=
 =?utf-8?B?MWtOR3FXblpQeDhCbDVUSnpQMEtRa1UwYU9Ebi9UektsZHpWc3lYZW1ic0po?=
 =?utf-8?B?bTVqYnZrSTRGT2hoUFZBdEZkUkpLZmE2ZHdiUXlCa1VvVG8wOVpzZGNhb05W?=
 =?utf-8?B?emd1aWRWU2ltUU5IRElTZFVjQ0o3VzN1VlBCOVlDZnlGTkxuSTc5eUhSZ2FM?=
 =?utf-8?B?S3dXUW5uS1ltenJHVjY2NWJZUDFhNmtaeloraFhUaWJKWGdKWVpkTFJVUVVq?=
 =?utf-8?B?N0pmTHE2K2hqSzhpSFl2UnRUTzFpaFJFOXhnRnZ3ZXE0NVgxdGxqS214TlR1?=
 =?utf-8?B?OTNNTC93MzlFckJyN3JjbWdnWkhXcjU5T0RBSGQ3eDlNUllQcTNNY0o5amZR?=
 =?utf-8?B?OGlhNk9UVGZhMFVFYW5SL28wZnJib29HRFU4NVpqNHhxRkN1TG9PZ1lKbFJI?=
 =?utf-8?B?Y1E4R2l1TFVCamcweUxCNngzT2ttQnFaOEhYc1k0d3FyUzlWWTBoRjJrUG1H?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e56547-b636-4dcf-aa67-08ddad27d860
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:48:00.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AebNkNn6H4whAVnta8Gz79U976kcJmtz8QFdJJWlYeRD/HsU620k1l7tJjwYKH8uxm6+lpbKuEYohwxPUGLMxBH0cNRfexYPKUN3LG3yz4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6818
X-OriginatorOrg: intel.com



On 6/16/2025 2:24 PM, Heiner Kallweit wrote:
> This effectively reverts 6e8b0ff1ba4c ("dpaa_eth: Add change_carrier()
> for Fixed PHYs"). Usage of fixed_phy_change_carrier() requires that
> fixed_phy_register() has been called before, directly or indirectly.
> And that's not the case in this driver.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Is this harmful to leave set if fixed_phy_register() is not called? If
so then this could be net + a fixes tag instead of net-next.

