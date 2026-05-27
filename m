Return-Path: <netdev+bounces-292448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IELLHRJaF2rgCAgAu9opvQ
	(envelope-from <netdev+bounces-292448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:54:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 154EB5EA3F4
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E13DC3004D22
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13CB3B9D90;
	Wed, 27 May 2026 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXXGoqBz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A296313520;
	Wed, 27 May 2026 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915278; cv=fail; b=k9SLaa6zcI6pmeg5OWeFbkLq+mwlVQoefZ7j+ZIqYfX1JT+pQH41FUMcr8+wITAHXUTA9MhJRN5FP7+l5o3EyZWOmx4ozuVW7BgD8mgCX/ryNDRlHM9KS7PH6cXGEvGv4peOKrrsjWbo1j6SJ3Oy8KXiGAbNlwNWPNUK5KNPSuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915278; c=relaxed/simple;
	bh=k2O5tmg4mCKJv1evLcObsEV/w4zR1tYSevaC/KW+kkU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YDFa8aFBNJm/25VSLRJDk53+JESRg4rwnp+BoNMSOZWYbVG01thrRRM8lNwZAQ++VWnXruEGUisu9DeNvP0v5S65xNczYkcmLxbpyhsQYIniLD859LdiGARnE6kAkieIhhhJ+QWzcsr2kwyPjPGBDZmvobJdwu1uyzV/lxjsJ84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXXGoqBz; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779915277; x=1811451277;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k2O5tmg4mCKJv1evLcObsEV/w4zR1tYSevaC/KW+kkU=;
  b=LXXGoqBzE72FvsU/ksX+vD4J/J5yqOk/e9cmRy4otUEIlN1qbuDr72OO
   /iJofvp8+V76E7MHHXvcwwZNvduPCf813J0+RjnFvF2AdZDuB0h6aXfPA
   eZSVleP+HV1bO/4hgQVkOkHkVMv9kiGRnZaYMbe59rXW8M1/LXwMguAPM
   yuose6NCT1KHWG/kxEdN43budyZavNHR9BzLylyyFe7KwkZmuRhxfwuaU
   bDkp6xMrAWd/ml9aOo9FZe6ZeNeDwZMxFgN3c5WneJ6BEpZtU7Q92ztJ/
   mzXrdNh0Ckcztayg4teBke37KNzD6fH6Qy+fHzP7fPmNLmOX18SLZ2xvi
   Q==;
X-CSE-ConnectionGUID: wmQla8WuSxyqXvR4F2rUzw==
X-CSE-MsgGUID: JxU599UfQ1WoLnyl+GgpTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="79907814"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="79907814"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:54:36 -0700
X-CSE-ConnectionGUID: xwZg7yZURjqXiWFFQcgZ0w==
X-CSE-MsgGUID: m5jbQw/NR7u1MzYLUXfkuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="272684165"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:54:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 13:54:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 13:54:35 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 13:54:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBHs8uqPuSFZOBGJTrnvGJPGBAJ4Hl3PejqjWw8MbGUoxyg7Bs0upgRC3EqALQiWCqVLZFzumCnRuprderNNbm6GH2CPrJXuqDNVgC+0tRjnHqaBmRTlDN0jzm4UjwpCfQE4r3zslUAgym+/5xGaLNwQVFvBcEh0j+y5BCezg9YgROQ4BK3UMM3co+DIfmB9/HwoeQe8XkAnmCOjdABh0i366pLUNU6B029T78YBJf9gOWyf5nwlaf+majPrY+/zVFqcvR7p2O99PG+IrEK4Opp6vggaalNdTunSGUyDYRAUEPjpl6KcPbbZYkcPAi5RxTgJ9cUh7NbUk6tHvgAP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fv/s0chkTUAKZZCEB5SCn9/+my8h/26i5j3V2fOKVzk=;
 b=Qnd93ocmzfqnHwSwtW3TrlfCM1znS1amTfKxBStFL7PM78bFDs2A0hrFYJ0RSV8d+Aqu4cBaxM0vYVuN4M++KNrPzraUemyf0T19FCjY/z/bp1hk4DcBPLNvtgrNqgF7ixgH6aGn1HzdyovtUb9QQpGrg7LFvAxIzb/wW7Ex0ynJBm0jrtygG8TOW3AumblICiUD1KIG2bHMIOCtJPixOKKPZEMidAE1PJ/jgLDyio6aKU2KmI2iamSv1F7v6lEJFG4haL4AwTEeNNlaDBn/J2aaYxc9YtUat8c5ddgYIbh+FxS9Badt0fpEAnYOtnBljD13aC7Zb7n3431BA4y0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA2PR11MB4972.namprd11.prod.outlook.com (2603:10b6:806:fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 20:54:31 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 20:54:31 +0000
Message-ID: <1af08d75-ecc7-4e8b-abab-dcff2eac5228@intel.com>
Date: Wed, 27 May 2026 13:54:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: microchip: sparx5: clean up PSFP resources on flower
 setup failure
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, <andrew+netdev@lunn.ch>,
	<edumazet@google.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260527073855.2334001-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260527073855.2334001-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:303:b9::13) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA2PR11MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 546620cd-fcb2-425a-a4ec-08debc3226af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|11063799006|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: a+JmLsZXjp+xP1VLG+8JyznjbkvS4O2cUKFQ3UFDl3BsRRa2zYKLWHSJcC8Q9eiBMipf8n9lzEIKZ3flltcCNNF6XGMl3pjqyGqtQubMC5iy1f3kwTZIZ1D/SyAw13mK9cdWdplu0kZOUv5tYSd/KpTG3XYfvwxBCi4XtGTjePkRt+LepfuqoJzO/0TujxAi6JzLzPvA2WN51DecBT21H+EwYJbaVdqBHA/5/93nsnzYTsdScfvo2BTSxGCTWLoHkYfWq8cqPAVhQNSLVcu4bQbFKTYrY/PpqJw3Hkit5Nc0Tp1e56dYIKtAihUhqgnuQ6fnB46C0kR3Srfi5n/5VB4Tdj+f4cGNvk3DNoh36fDR7WxQvQoHyPj/GZrri5R6a0mCj1DduYDnjdNyNC/y4JZlDQawmhhI7necUU0DCO5rrhtvmMeSzasBb5b4i0y8JwbCvFkD3va/bwrZpJD4TlcaWsTxuabznVD92zSsY1TVJ1GXf0ek1BIwNfWbiWeZmgQhsWM8QLb9rlyTTMIyYc/skilVA6jfCih10vTnJuEqNKiYGv7b/NvubTTumCvqG9zpUDKx1B+H7whvb+bGJdmDehFUdaaw1f1DYxh3BtDXeFTPtcMV8SZxEOMM9qRhhDRK3xLgUWFihjkTAZIy7dCVAEiGVi+2FntYx3gakr0bf/mfr7PAkto2DTD/bkVV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(11063799006)(22082099003)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S20zeFM5WGlHUGNwaENxeFNPRkQ0OEhPSWd4ZnFTQ0kzaHgycUtNdTRkWkl1?=
 =?utf-8?B?bkJzNHhJTCtuTXJVOUNRQkYzMXNtVHlPYVJYazlLYU1RbGw1UlNKNWc3Zmhy?=
 =?utf-8?B?UjhsNm1lYlpRSTVnS1cvdzh6aE9WMkNKa0tXenZQaHh0czRLMGcxK1h4cTlY?=
 =?utf-8?B?d25scUdkYlIzVGNLd3lPWDJYZVNCbi9tKyszY3hqZHo2N3lTSnF4cEF5RUFF?=
 =?utf-8?B?SWlIL0hlNmtMRlBnN2grNHlTRWZIRll5V0dsVzFDcnFYMGF0YkJrZ3JLU3Nj?=
 =?utf-8?B?L0JsVVdlOFJTaG9KVzhyV2lGT3I4UnlTaE16U2NoSFF4Y2luUWtvREF6OUk2?=
 =?utf-8?B?dXZYN1RsUHhNQXA3dk1PL1g5S1BaUVluM3R5Qk1KOSsyUTdvcng1Y0trQmRo?=
 =?utf-8?B?cTl1ejJpMlFNbEdjZERZa20ybTdSOEl2Vm9GVnJVUkp6VG55VXNhT05sK2oy?=
 =?utf-8?B?ZlNPcDRUcXJDWGZLb1Z4MXFpdXg1dDRBeDgrN3NqOG1HeTNmM0EwelFpSXBX?=
 =?utf-8?B?MXBaR1ZiZTUrQ2sxTmlYZG5DeFdBTkh4M2xFenNuL1ZSTGtXcjJEc1YrRExh?=
 =?utf-8?B?em5kb0RraVJXT0pBWG1OK244V1JwTzFtQmNoKzJXNnF4UHZIVTFVOFpIdlRR?=
 =?utf-8?B?c1VzemhQWDQzWE5tcHE5TnB5VisvYmNBbDhJYUtqVGZoaW1MdHJEdHZoMnJj?=
 =?utf-8?B?anJSL3NwcmNYaFNYVjJ2czZHVGdGYitKMlllbm1BZHZicVBDVlhHdXZ6ZnhY?=
 =?utf-8?B?TW0zNkMrRWQ5cFljMEwrcGU4a2QwYUJWRUZQbkRUOUp4SGo3Rk1OSzNJbisv?=
 =?utf-8?B?V0xESUVqQWdLYkwxaTYrc2ZKRHJUb0ZVSkkvcml6dHBTSzJRdGdEZVpWTWQ3?=
 =?utf-8?B?dFk4MlA0YkR3WnYydlhyeFA3MWdXQmdXZkhESHlJZkFPeEhYYlJIR1J1ZG5G?=
 =?utf-8?B?cDFjdFc0aVk3K1l4VHRwTzVJVndtSDVvRyt5Z05zMUk5L2hWc0RiUHBldnN5?=
 =?utf-8?B?SXBRT3UwbzdMZWtxT2luSDVBTFZTcHVsYjBaRE04S3VscVIzSEZSM1FqL0RB?=
 =?utf-8?B?RDlldmM0bFdJd2M2YTZFa1lFaDRLMmlmSmtkenJrYWRhRkg1UmI1Q25tdEhz?=
 =?utf-8?B?UXRqVzkraVJCTzVMdlVVK3R1VURTSGN5SnMxczM5dXNUT3Eva3FDdUh2czc4?=
 =?utf-8?B?TC9qQVkzT2dWWFJicDVPSi8vWitYdWFSRTVUZkhsMkxaVlJzMjA1RjByWUY0?=
 =?utf-8?B?WGo1cGFWMHVZL1YreTVIY2YxYWsyaUZuYjVIUWxzeVRNT3dBOVJCek1lc3ow?=
 =?utf-8?B?TWpiWEt0L1g1ODk1akJjS0ZkSFViYTZ3TWlpYnR4Q0xxUDJ6RDJocWJYalli?=
 =?utf-8?B?MDRpd2M3bXpIMFBQL1JsRkd2NFB6dFZFVFJObFh1ZU5EcElUWm1oTjNPV3Ju?=
 =?utf-8?B?V0FhZFFLY0pmakhNbmdFKzByU09zcjFsRFZaVzAvekZZRWpSL3NEUk9mOWlp?=
 =?utf-8?B?aFhHRS9PRUwvcmRKQ1BVUzg3QWxpREJjRG1ISnFtSlF2VUQ1SVpBMUVleXR6?=
 =?utf-8?B?U0N2NzBOSUR1L3EyYUxYUGJxQUxLV0NKa2hmTUpLcTVCMUVEM3hReHZLZ21I?=
 =?utf-8?B?aUlaZG9sYWwyZjBzbGdPZkdBRmhTREdCZlRmeXFUejYvb2U5OEcrNnFSRitu?=
 =?utf-8?B?K0lOL3hBdmdXaXZIWXhIUmJEa0U0Z2l6dHByMCt1bUlPRmdnQ2t6dHhRaEdq?=
 =?utf-8?B?RlFEbkRNdkJwS2hCbllKWGRxVlIyRlNDaFV0UE9tYSsxN2NabS9sUnkvOWFV?=
 =?utf-8?B?aXoyU1JvRklmbDBYUFliN0FmSEcwRmZWT3FsbkFBTjFOQ0w0NUlnZUhabzJ0?=
 =?utf-8?B?OXl2OUNhOC8vbmFYQUs0VExoNmtTRUIrTGx0RWcwUEdnR091NXAxRkJENjRn?=
 =?utf-8?B?MkliWUZmcDhJTk5XZDNkMlREcVdOWEU4c0FPODBkdzAvWlNkakFVb1A1TXp4?=
 =?utf-8?B?TFB4WkZnOTA3QXJ2NVVnNkkvT1F1azJ5bncvSGgxRzU4bWpHMkVDZC9PNHNQ?=
 =?utf-8?B?Rm9wSFUxSjBtZFJrdmhvUk1FZG00VXluRHlHdmt3S3h2b2d4dlBKNk8zN3lj?=
 =?utf-8?B?b3draytLb3dueU9McHJFamdiaS8xZ0JycThoVkhZRGt4ZzQrMStGTmk1Tm42?=
 =?utf-8?B?RkI1dDk3VVhrcDNJbkpNVyttcmV6Y2VFaWpPbmNtaThXOU4xMUxhTUZzTGEw?=
 =?utf-8?B?VWdoM05qdjZ0ZUFCNG5DZHNjZ29aRFA1VDFrZFh2UDR3Y2pCdkxDS05aQnV2?=
 =?utf-8?B?ZUh1QVB3TDIxZ3REUWZOdE5UbExTY08vTFJlQWsvdmNYL1lldGc3QT09?=
X-Exchange-RoutingPolicyChecked: VyvWArAQfYaE9TmdX9OFzWTI3os/UBfLWpnLE3HwMiGN7CNfRZFlijW/PBaqlxrB9xkDLTjus/3eTBTTXECQ7SgmxRT6t6Dz3N/NxhLkc1ikwd07e+hIY2JFOomPKHlSjovdZemOr3IePfkAP5oo+cSULovuboqVPlKCXVyD0hNuQH3FctrzS6lw9EC2U/Vpm2XoAMWwDxZ3+MN6YsNp04E1o2ch2Q+gjY6Wfenf3McPVa/Mmmd3znWpjXdlesu6IdYR0PCoJHRC9DS4c6oGCXoKsGaNI1MlicfK8a5azIOM7pVqsDRn2DjxIwugdUoNrnrR5ICOdF5hj7OxxnwVmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 546620cd-fcb2-425a-a4ec-08debc3226af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 20:54:31.7775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qz3IG/9WdDfq8b8EPOSasNJ4Mdbpn+CJvi9VzQ+ftHP61x4F9p/sa/sY3ooj5ZSRCv32Og47TQ+czOTpykbQsh/0CQiY79HxDfZ5v33UQkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4972
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-292448-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,iscas.ac.cn:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 154EB5EA3F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/2026 12:38 AM, Haoxiang Li wrote:
> Add error handling paths to unwind the PSFP resources that have already
> been allocated before returning the error.
> 
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  .../microchip/sparx5/sparx5_tc_flower.c        | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
> index 4dc1ebd5d510..e5022d783ee6 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
> @@ -807,7 +807,7 @@ static int sparx5_tc_flower_psfp_setup(struct sparx5 *sparx5,
>  		/* Add new flow-meter */
>  		ret = sparx5_psfp_fm_add(sparx5, pol_idx, fm, &psfp_fmid);
>  		if (ret < 0)
> -			return ret;
> +			goto err_sg_del;
>  	}
>  
>  	/* Map stream filter to stream gate */
> @@ -816,7 +816,7 @@ static int sparx5_tc_flower_psfp_setup(struct sparx5 *sparx5,
>  	/* Add new stream-filter and map it to a steam gate */
>  	ret = sparx5_psfp_sf_add(sparx5, sf, &psfp_sfid);
>  	if (ret < 0)
> -		return ret;
> +		goto err_fm_del;
>  
>  	/* Streams are classified by ISDX - map ISDX 1:1 to sfid for now. */
>  	sparx5_isdx_conf_set(sparx5, psfp_sfid, psfp_sfid, psfp_fmid);
> @@ -824,13 +824,23 @@ static int sparx5_tc_flower_psfp_setup(struct sparx5 *sparx5,
>  	ret = vcap_rule_add_action_bit(vrule, VCAP_AF_ISDX_ADD_REPLACE_SEL,
>  				       VCAP_BIT_1);
>  	if (ret)
> -		return ret;
> +		goto err_sf_del;
>  
>  	ret = vcap_rule_add_action_u32(vrule, VCAP_AF_ISDX_VAL, psfp_sfid);
>  	if (ret)
> -		return ret;
> +		goto err_sf_del;
>  
>  	return 0;
> +
> +err_sf_del:
> +	sparx5_isdx_conf_set(sparx5, psfp_sfid, 0, 0);
> +	sparx5_psfp_sf_del(sparx5, psfp_sfid);
> +err_fm_del:
> +	if (pol_idx >= 0)
> +		sparx5_psfp_fm_del(sparx5, psfp_fmid);
> +err_sg_del:
> +	sparx5_psfp_sg_del(sparx5, psfp_sgid);
> +	return ret;
>  }
>  
>  /* Handle the action trap for a VCAP rule */


