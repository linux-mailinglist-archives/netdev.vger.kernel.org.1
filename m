Return-Path: <netdev+bounces-293766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL3zJiqIHWrAbQkAu9opvQ
	(envelope-from <netdev+bounces-293766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:24:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A23361FFDB
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09B70308112B
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 13:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0915D3A5E90;
	Mon,  1 Jun 2026 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MgsCYP0t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6437F8C0;
	Mon,  1 Jun 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319978; cv=fail; b=JnVkM6zGgbqqT45h8EfxSsMbLQksDM3PdRndF7cT9PEuawKnSGVF7ZnISxT/mA0AXHuZk5VHsOIUNRIrXN4+6m/nD1uiei/btZFgL4wgLNF1HeQP23XYsdgo1XSa6XPPk5b+nWNak6wvKKmes5KlqSqq3Jbl0sQyOTMwpy4ZfnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319978; c=relaxed/simple;
	bh=FzrjQTUgHXBCVmGwkkIxHX18y6thZoVejY0+ZpLfUlY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S4uA4STUen+KRdiVrn1NsKl+GnmvFw3TxPhDV3Jas+qVfbqV91GiqJQXZchFA99mjx6A2uJKG3LDuHvXeZ/kQ3V+bs9i8y6X2ymcltRgWpXRZOBEL6aMsy0RLwSWovu6UI4T7YFEN44tdX1l7YPg95cZfcElrD8VyWUmRmzcUV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MgsCYP0t; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780319977; x=1811855977;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FzrjQTUgHXBCVmGwkkIxHX18y6thZoVejY0+ZpLfUlY=;
  b=MgsCYP0tauUJzRxV2PVLhuqYN7G1ERY3KQaz+izvCWzshzyxiB9TGzYL
   GNpF3CkIBj1541cr6R+qVU+HSHLAkJlmcOqzO0gk22jgR9epVr1+qlzyQ
   WZGVaIqvjQZ1FDtcUXD+Q9HspNkyt4tm2XBhUUQ+7ussvAlsgv1uuWMPv
   WJKcIXlxz6APoqNNOX2xQ+DLNLmAqP/AozTPFCnGugJnMFfcdqn1hGcya
   xrs/xd/RfQjaM0MymrgQ7kGe0BqC1qhoBTFavRaZ4P8lkrmKsUFhO65wo
   cCnK4/RFSTBpm2x8IEEs8cI/JPS6kXSAToJ1QxH17J63dRf6EYZ/9n5BO
   A==;
X-CSE-ConnectionGUID: BWLXuKg7SmCTDJAXLUoPvA==
X-CSE-MsgGUID: t/rrunFmShyTmdeDlUN/FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="91647364"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="91647364"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 06:19:36 -0700
X-CSE-ConnectionGUID: SibWgcxWRR+DR/5iEH3cxw==
X-CSE-MsgGUID: xbr27Z+bRBmxb69X2gAZrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="247534596"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 06:19:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 06:19:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 06:19:35 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.24)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 06:19:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ac0Xd1+3hukawnWL7fngs5G/uLs29BRGtEQFIgVzj0vDaq1SmonTvyCtOBTiTJYWveso7X5AJQERlgYI8onsDRV1/aRbwdJVCYBNA2f6bVZtVxMkSWEZ+P7WtnOBakDt3FM3QdSRHh6Pk1k0IuuNlYTj5pRXkC/zRREVrpJoKAxg/Wn/aCqZ4ZK0EY+9HCZcRZloHnpDv8SQufxGbibPx7kWB/tnzJK5gVRWaQUjmf1IJkYNUnvjEbVJBtRLKM8l7jaTsv4OD84oD3w88WnknLEGfrgRU121AvW14kmXuELptoCKLRmdIglH11fI4JVe1OD4bZ5ABwr9kdhAPVW1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8M3HA5NcYGA9oBotAdNjEZXo7E9o+3QEC6o7JRrG4hg=;
 b=l9T90CFI5bvXBY7ET4GKO8hH/hMwarHzxg5/zcBcBSg1Rdk98FrGiHVLSb+KMaIpwYQNzU6WkjAI5TyJqruEqaRui5mcbLKFUoI7RVcpc2WF0y9SOPnI2+04ecdN55CoYbAEHANDHao0KP+80RCPd+nDuJQWUCpB3lHdjTHt4epTQ6N8aDKBnCyT6u2cQKcVB7kJyvnWJZZf3eKOfNvkqdt77Yqc8ejI/SA3dXi4ibPyWt7+/FejNaBMvjlyEviZjW7Q/Z/04I+RbB+1vt+LJptaPVBZTuu0KGwAIlWRX/dFZodzOe9nuNXK6LjM6NU7+lmPajTH9ZShY3Yt5MgUHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 13:19:31 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 13:19:31 +0000
Message-ID: <7a5702ba-af01-485d-84fb-f54c9d5269b2@intel.com>
Date: Mon, 1 Jun 2026 15:19:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtase: Reset TX subqueue when clearing TX ring
To: Justin Lai <justinlai0215@realtek.com>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>
References: <20260601062418.64004-1-justinlai0215@realtek.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260601062418.64004-1-justinlai0215@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1105e8-05e2-4433-84ac-08debfe06a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: OvuzFW0+b0cW1bdQiL/JmG1MCtqmoXujPBiqf0fiUE/2/RIKTjehN/+mcDH6elN8R+ZBscR6J8sP5kXD8c9T2Suw4Dc8sFj4JOhDGoBfnkJQB0KF19yDVsNa2sltX7A7NPA+gcQz8/7Uxqm90Sr3jTlEIpZZZXqk7sT34L6XrqlWvKah/vbRzwkjBOT5V9CQd/gqy5GKvGtEuc0hyLloXcyDVFPfJsv6cmXn99J6Yk3h5NnlfbpNPs94F3NACn0zhwuAXVMqTFh9qKeVaVSrGFf8Dzsin6TRvNMA/4NchfoOeXV0IZUTUEO7QSy3m1QEgCW1llBC7H2X+YB5NHVb+CcU/WMM1T65wxMwcVyxXQ9kY4KJ6JNZgxFgezWyk2bmjlpz/xcOGpClWhgtY9QaDvme4S6TfWR/gI2z+5tMhk/Gr1RI7GPN3+eMXmbnPb4J2VPpqeyel8kBzgrRnHtqDTaW+qr9vXCuDkv65Qa8S+ln+R0M/dS8x1Hl0Q+KIyJ9WSa1vspMnPBJJg4MRJTAdWHDnv94BN2jI4HTBcvmBJzd5hzsJntfpf62sYj4TPU7rbnpO9zk9nzv1xqwhuGhSMiz9aOz/NqfitTCEoI5mUHrvlq1j9Uih2IgtUXxkT1YEUZRCorDtqaSzcCxSuwv60ZUO9XPDF+EmnrXmbRGdDfYwCZF+2eqfqwUwl+pwYfx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0RiaEk4L3YzMVlndDE3Mzgxek9MS2ZvMUYvcE5jdXZKRmxwS0JjUk8xM0Js?=
 =?utf-8?B?c1RlSGZlUzMxbGNJZzhOQ0JLbWJZekh6UXllUTBrRDNWTUZIbGY5Y1R0S01r?=
 =?utf-8?B?aTlrYWtQYXpqMGJiRmUvcmw2R3gweHBpNlI4L1grZXNzNUNwdGFnQis1V0Js?=
 =?utf-8?B?WXR1K25aWFMxTmpvUzdEVFhFaUhEQm12YWs1RU9vQlNiL05tSksyOWpNbnNJ?=
 =?utf-8?B?Vi93RDBVUTBoLzdJcnA5bVdGS0luT1psbDJLeEJqSS9KVTJ0T3VWMHhKRHhy?=
 =?utf-8?B?WDlxTXNvS1NBM0VxaFRWQlQrcmtVZFpRZzExSzBYempINTdlY014VFY0V09F?=
 =?utf-8?B?TVZ3Vk45V0JJVGhGN1VPRkZxOWdDMzVWZnNQQXNPZENOeGVOZHMwTkhQSXJU?=
 =?utf-8?B?YjA1MFdVYWJpUHVTdTZKTktCNGo4WnFseldSWkR6bmd4WTRETWNtdEo2SEhi?=
 =?utf-8?B?M2hCVENncTVlSUlaTEZQOEJZSnJvd3l2U2p3TVpybUN4enBaQTJyM2R5N2d1?=
 =?utf-8?B?d0ZOeUo0Ty9rRXE1cG1WTFkzU29aUmNQdEQ2d0NESGVxbWo3QVJFM3NVdFdQ?=
 =?utf-8?B?MnpiSXBCRzFHRmU0OXphWGY2VVRpMzRJQ3RGdDZEdUpFWVJySUNweko4OGpR?=
 =?utf-8?B?eU5PUTdjSTFEV2lOK0FOaHAyQzEycEdvTktvTVQzODdrWHhjeGxEWG5ocHBG?=
 =?utf-8?B?cW5zQlhaQzJ4bC90T0o1cUgwS2dVcGxiV2tXVEd1SEZnOTkvK1ZkZk1pcVIr?=
 =?utf-8?B?Y24vd0V3WENOMVhQanhaKzQzTmVaL2dHM1NrRU96OEp3RGloQVFWL1JZYlN4?=
 =?utf-8?B?K0IyV2lSdDlPaEUrOE1qNlJ6SldJRitjdjFNMWpwa1FXVzNjdzAxczgwd0Z3?=
 =?utf-8?B?ZXJsbnJPZGRhQVF2dThtRVlaUkVabjlaTU9OcWI5RW5zQUFGT1ZJSzFCUGJN?=
 =?utf-8?B?ZFBva1NmSGJKOUdxa3lJZTJrL013cFU3MHdXOHRMNHVIeXRpWXBlZ0xFMzk2?=
 =?utf-8?B?enJXYXE3dzN2T3VpN2FhTG9FN1FvbHVtRUdnNlgweGV4SGErQ1hIbFZnQXpV?=
 =?utf-8?B?STB1cTQ4R2pZM2lwWmswYzRZNDF1bDhRTDdka0JTdGQ3S3QrNmhnU2xqdUUx?=
 =?utf-8?B?WjNPaWl2THRNcHNaWUVGaTFYYXVjMU9mZVNha2c3ckdDV2IzcG1OeWFHSHRa?=
 =?utf-8?B?Q3pZWlNCTmpYZEZRTzFndXNpTEhQVVRkaHJLWCtmc0VnMFdrSmdLdVBnN0FG?=
 =?utf-8?B?blVOWFJKVi9NUDhEbDc2Y0VrdkYyUVAzNmVZSHA4U1Q0UVdBQUtBQ0VXL2s1?=
 =?utf-8?B?TzA1dlJ0di9uSTJKcDY2M0c1VldrS2NDWDhzZS9kS3V2aXh1ZlhhM1c2dE9X?=
 =?utf-8?B?aUlJVVJQcWY4QVJQYmpML2I5bWdIZE9tc2kwZmlFeC9nTGpCS2UxaEtjNUVJ?=
 =?utf-8?B?b1dWeW9heXdIN0V3Vko3VW1YRHg2THJZbjcvLzNTbHJhSk9qYS9DdFlMNEVK?=
 =?utf-8?B?dmtTNktDNm91OEdwR3F3NWxwWUxpa3Y0RHhWalBXdmZwMFpmT25TT0tkb2Uz?=
 =?utf-8?B?dkFZa2F6aVZuNFFadEVPZ2hIVUY4Y2toNVRiWUY1aCt0TnFXWkdwaWdvaGRy?=
 =?utf-8?B?aFlpL0RpM1doNVlUdys5NE9IMEVnRG8wamRqL296QmtMcVY5bjFZWTNiYjVR?=
 =?utf-8?B?b09pMzBnTjBmOStVK1VNQmpTQlR2UjR3bG9NSGkwdVNMNitxTURPWkpiMjZJ?=
 =?utf-8?B?dkxVM0RUakE3VlA4T2lCMEl0RzNLUGM2S1h3YSt1MkQ5Y0U3RWRXbnMvME9C?=
 =?utf-8?B?NEUyNXFMOGJ6WWNZMFg4RVNiNjZBNnNpTnNBaEc5NWk2enNLSW44ZzN4bldH?=
 =?utf-8?B?bmZYbFd5VXZFeW0yT1oyay9XUzhReE95dnlMVlZYZjdoMWhzclpmYmxFTm1K?=
 =?utf-8?B?dmt3Z014cUFkeW9iQk1YeEFOcU55WTh0aGJMSklwTnA3cm1ZODJPWS9xQ2Fp?=
 =?utf-8?B?ZG1haXNURlk1a2NuTHdxd1BTMkJvTEdMSkY3dVNNcWZ6eFJ3UDVTSHk1bUkv?=
 =?utf-8?B?K1BGQjhxUWE5VHI4SEpxMTVtMkY3QjdjYk1nOWtyWVNOMkdqcmZJTEE2Rzg5?=
 =?utf-8?B?M3pEbS9XcEt1UXlQVVNPYXJHeUdBTk9Fcm5NUXNFUUQ0bk5jbzkwNGthUkk3?=
 =?utf-8?B?WVZTN2ZKK3BYbW1jQmkrVEp2STFjeGt4MzYvMjhxVjA2MERiMTVCa2NLbWx5?=
 =?utf-8?B?Yk9OUUQ5aXovWmpMb3dKMHhBNm9MWjVDLzVBcUNOK3F2Mkh0UnJIcm80THRh?=
 =?utf-8?B?N0wxUkw1NkNJU29Ia2FyeGJZTDlqNXpLMFhCdXh1N0NKK2xYU3h5NFZSODYz?=
 =?utf-8?Q?EbmSJRDf7LZr2EgU=3D?=
X-Exchange-RoutingPolicyChecked: G5LQihXS8QPD61KbPJYmbd0uDYzDkh5pZacswPHLsAapWL9mhbzeXR+GgmEW7Wo4SNTUWV61RTuZNmTsTmGXGufJnledwFoxtQj94eazDFUK3TGUyZBnLWjl+ZvoN67is7eNKIy97JiK3wCw4YiEkznZLGv1xtqXG7y/gs71BtQPL7u404xfhxH86HgkXUilm2zx2A6Gizy302KQLWEzWBf19fF319jC/bD36FJ2qZWW9MNosNy6NM0q/ZuYRVX/8sVUMtDxZbdRTI3PNHzqJx7QDKokPAT9c6ZUVM68InZg2vhu2hW5ZrPyTk4oCOnFpPjxOsUQ+hpOgi0/zS2APg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1105e8-05e2-4433-84ac-08debfe06a96
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:19:31.7449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3t77fpMcDC6LBAx/A4h4z8ukLaMeeoAl6bBWEMPfAk4X6z6qUxAcYFuMVs699MjZivOBCXvWOrERczkSmd+vQ1H5Htumklf+PLeDFYx5kq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293766-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,intel.com:mid,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2A23361FFDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Lai <justinlai0215@realtek.com>
Date: Mon, 1 Jun 2026 14:24:18 +0800

> rtase_tx_clear() clears the TX ring and resets the ring indexes.
> However, the TX queue state and BQL accounting are not reset at
> the same time.
> 
> This may leave __QUEUE_STATE_STACK_XOFF asserted after
> rtase_sw_reset(), preventing new TX packets from being scheduled.
> 
> Reset the TX subqueue when clearing the TX ring so the TX queue
> state and BQL accounting are restored together.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

You need to:

1. Specify the target branch in the subject prefix ([PATCH net]
   for critical fixes, [PATCH net-next] for features and misc
   non-critical fixes and improvements).
2. If this is a fix targeting "net", you need to provide a "Fixes:"
   tag pointing to the commit which introduced this issue.
3. If this is a fix and the bug is present in older supported kernels
   (LTSes etc), you need to add "Cc: stable@vger.kernel.org" right
   after the "Fixes:" tag.

> ---
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 43a4aa275b62..11e9d0feea68 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -240,6 +240,8 @@ static void rtase_tx_clear(struct rtase_private *tp)
>  		rtase_tx_clear_range(ring, ring->dirty_idx, RTASE_NUM_DESC);
>  		ring->cur_idx = 0;
>  		ring->dirty_idx = 0;
> +
> +		netdev_tx_reset_subqueue(tp->dev, i);

The fix itself looks ok.

>  	}
>  }

Thanks,
Olek

