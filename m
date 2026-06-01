Return-Path: <netdev+bounces-293769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGCyKTOIHWrAbQkAu9opvQ
	(envelope-from <netdev+bounces-293769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:25:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC83F61FFE2
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C12423008D34
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573D33A544E;
	Mon,  1 Jun 2026 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctoTVKMS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6145438655A;
	Mon,  1 Jun 2026 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320139; cv=fail; b=Yhk/Hv6tfsSJ/B/qePF3um3ca2lbcYsZaulce0Os+SflMKqkab0eD9EpQQrnFCKUUdusYaHrVJirb1fwaYN7a6MsKWDr1dbZMisY9qWybnPPZVVuRXnlpBOjRsGu0cG4tUfmPVqi9ruFgvoUqenf69FCvIW3oJBC2N2UFS5WxF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320139; c=relaxed/simple;
	bh=ga8P3wCQdK59HP+aQ4R/eTK98s6sHB4l9ghdsnTw46k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lVKnvpij5OpSA+QRhzXZIlOfaqfV1VOJtBViAt5X3K6M3SBNxjY4gjEHUYwo8nl0D95lhh0sVPShVRLdi/qQ8C6KBF9OIQdqom7VtMs883pQgP01q2Sjf1XYnr5lTjteCf2A/uSH0WzQ8P697QNbBhvnwK5nbsqnuzijCQcA9Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctoTVKMS; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780320137; x=1811856137;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ga8P3wCQdK59HP+aQ4R/eTK98s6sHB4l9ghdsnTw46k=;
  b=ctoTVKMSRjmKhaHXBJC2BT7gB7h59C9aIvI7KWeg/vogGDzmtvZwmIMu
   GY3w8um5iz9YREYL5no5pLNcN4ECGuJeJpnSwTLREWcBNAYekZahi0qGn
   xPL/nZMKXqGJusbdOXU3dFT4pZWf4g6V6sLkiS4TnE2VWJpE73/l9MbrE
   2GZhWSfB7DsMWRYQF0gTe6yqXgXhGcJS0+wAa8tEfnVb5B8PiuAyjix8y
   OzsQ7b2XT1Rx7/6lrkmbQni2FrY8hBr4vWrVvgev7dHEzHwMg/0P2/LC6
   kc4+Y1k+J9KfEM47oWQjBP2I4H6IPL9oa0tQEg4TXo3a3vQtmOOrSZpLB
   w==;
X-CSE-ConnectionGUID: 1GzTNvdEQNOMlg2wR9oInQ==
X-CSE-MsgGUID: NeQFVNN6QzORkFpWRmqj6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="68610404"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="68610404"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 06:22:16 -0700
X-CSE-ConnectionGUID: 5WBZXXqESEypkepx/YUaig==
X-CSE-MsgGUID: abmMRkLdSfK1T8Q8yvUA+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="242763901"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 06:22:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 06:22:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 06:22:15 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 06:22:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNuKjI3ciWW65XcVFAtvWOdgmHUoNzlsRoVrY1hW+UWuGIpbC7cMhAC654F3hL/hrPFS4dYQ8oOZJ5pJuCxZuaBhOtYXl/loDKUzLOJCRoeN33qblES/mRaemL/qXg7T4Y9YEZHaTHaTN8tQpPbbg7ka5L9ViKcgiuUpopelhyBWzgC58uNL2kJgF/Mdz9Wyd87S8FME+MSqtbmgu5vNzsgnQM+VugFuZKRsNH+bYw+wctm0am5IZWXJKK4ZJHU6b3kAYSb9Waov6KpVQWYOnzyYaUoEX7Tgy2enoRvAEgxeU2Ws26ptY6pO6eiACCoWEpq0tNHQoCDB6i+wPaHb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLEyN17cTrUAmuyPrJDndPlh+/bi8Ljet6fD/Fgp9R4=;
 b=yGrKXm24Kh59vTA4JGA8X/XK/Pl3DsVXbK0RCKaC30wHImexqlgwC49OXvauzRIRjV/sOYbxsueAORSGa3w9V2IPebDYSs1a66hZK9NUoR7dVwwDKcHHwLfkN8TftY+b30MfKfVrZWiJbjTsjcu3bh/z3mdW4vRmYL1h8OOsQVk3V/WaTlZDj/GBBVes0HoGpwarJ3Z7BtLCe7gsEfZGaOTjx4dSvRot0R/0eGLHa8AF1QowUGv/S5qIm2nRWbtdMVxRDPTHKIRelszXsXjbf9ztc7G774evhWG4W62NtnVxXn25yxtFgRXLDutAzGiG2y4iGg8CpzV1RuBbf5aIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB7833.namprd11.prod.outlook.com (2603:10b6:8:ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 13:22:05 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 13:22:05 +0000
Message-ID: <1e7c8259-454f-4a40-9f81-6c9b91b72349@intel.com>
Date: Mon, 1 Jun 2026 15:22:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtase: Workaround for IP fragmented UDP packet hardware
 bug
To: Justin Lai <justinlai0215@realtek.com>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>
References: <20260601062341.63981-1-justinlai0215@realtek.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260601062341.63981-1-justinlai0215@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf47b7e-eca8-4734-4484-08debfe0c616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|6133799003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: tPxNZrtagQyBfzi4r/nDoE1b3SDieiuqr5rg6IkzTSDsYYBewERno9PyIhqVZdvejLuPVij6qXJnqt5cAvZUSmU2cnZ0PP3mpstHu4tfx0HAIkCZ+lBCxJEUmTDnszwAf2yKim3iwUD5aAzbOnl/UHwpZ0Xpe9j/eg6jsIHN4c5AAZtc6KJyB7dcsH0twKOEb2tvVLldBRvgABsE/z5VZW/3GU+3nDF9SG0KGen1pKyMpH6N9O2kLUdcdyTkzuuj5NSLzgH+KcqiAOyv+1ifhJXnCAo/X3fBYjqJnIsT+QYrXP97zQtemKLEU+5G/IvkGT9LgJwM3TJJZiPCi9XUoBaf8chuoHCHQTVs3nDBR9/NSl+ZLgzXNss7GqkdZRXu4Kl3M7BHC07s1a1g9NuhZK4kJxw3LJkRtRH9zl7f+kksXrf7sn4CML3tO5WCZ/hERCQOETr3fr6b4dPRH5e2bzFHGnrxJ7G09ujso3WPAM2jTBhvXgL7ajpm/C09rJ96Kq+o+uPW8hoB17jPrheqSa0UR3lvVxOG7Nhu0J4/PHHTig5KuA7epl/nKPLl/6DQlbOjhk21hU9iiaQi9AzpO4EM64+pu2u9EfZVPT7YNG/kNs7dTerKmhayZDMm20ElEy5CifgtMo7gaoYG4IMdaPx+gVsJEX4vKu+52X7RpNcTKH4AhqYx7lI0xXjGvDFz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWF2aDJod0dXMzVRd3JGV2pLdTQ2TUR4ZGh5YXVkbXJCZGJUNmI2dXp5UnR4?=
 =?utf-8?B?QUFDTm5kd1hUSnBxc3QvRE5GMDdWajJXUWJCUkpRUUNUOExkMUdYWGM3bElP?=
 =?utf-8?B?QXl5NGJSTUF1UlRRdjNuajlTTEMvR3YzNC9kZXZLM2RlaVF4NWxaSkNlZUtK?=
 =?utf-8?B?WDZqQ1MxRXJvVDR0dEkyMVNmM3NpeUcxellDSENRYmJ5QlZNckVTMXZTUFJs?=
 =?utf-8?B?cWlGRWp6ZHFrK1I5NzJoRjR3NUkxcTI1M3E1V1g1blVpeWxZclFHRDRyeGpX?=
 =?utf-8?B?V3ZXS0RqSXV5QmJqd21KMXk0WHo0VDYvNUFTNk9SVk0vZE81ZnVWbWlSZS9Y?=
 =?utf-8?B?ZmJCdXhXZjJDY1JRREFhMVpPTGhIcDM5YVVhMTBaR1ZkZjVzck1LYXI2MWp6?=
 =?utf-8?B?eTVpVFRSak5BVXRVTW11NlF3bGhYaTVyZ0xzeUJ4YkY0SVk1YndVeGtRZThz?=
 =?utf-8?B?WnpqMmMrTUEzNjU3ZkdtMmViZE9qRkl4ZU1PVkh6N3JJVlA2djIwa25laGdY?=
 =?utf-8?B?OWZINmRxcVVkYkVFRXg1U3A1ZTRVVEJOa1dNd1pzeWpRNDhEVS9ZZzlrSWJu?=
 =?utf-8?B?enM4ZnJ1ek9WZFU0V2RHVGZFRjZmRHBNUE41WkEybW5JN3NqZ244bzEzRnZZ?=
 =?utf-8?B?R3BKR0pQUU1GWVNka1g4eGZERUJvTG1YN1RlcGFheVhuY08wQWRJcGdoUXBx?=
 =?utf-8?B?OWk1MVVDUFZlUytkMS95b0tYUDZ3b05tWTk0NStoRVQrS2ROL2Z0Snp0bnEz?=
 =?utf-8?B?bjkrV1JRUGV2L3pHRUsyRE42aWIwZG9sckpoeEQwYXlaRlhuUWxIcGpIWUQ1?=
 =?utf-8?B?M1hBWHRzQzdJeGNBRDNoQ0VLOGljdW8xSWRGbVpIVUkwczJ5Q09Ec2JEQ09m?=
 =?utf-8?B?ZGpqVmxHcktENFJQNW1mc2huME5mVTR4bGVxV3g4RW5QMUFieGl0R0tJZHNE?=
 =?utf-8?B?QWZGN29Hd0lQR2g3YXliM2VHdEtoTTlZTnVacEpFdFZXVlk5emM1WnpQb2tH?=
 =?utf-8?B?NldtK29adWxkMFhhWU45eXU4M2VqNXFPaWM4dHdNMnIvWDBKWTRlWEdsTi9X?=
 =?utf-8?B?Znd5dG5xTEZGOVo0WjZOSjdHTlFDZFRpM3F3RWM5ZkpicGhQUDBnbHRHTWNW?=
 =?utf-8?B?Z0E2M3d2czVXTVJHd21UUm04OXFZZDhJYTlqTnRuZzZUaUR0aGsvZ3lzRHAy?=
 =?utf-8?B?RFhOM2ZKZ0pnNW10ckJZcEMzR3VUOCs3OVFuY2ZsbFR0SDJEOFplZnZDSTI4?=
 =?utf-8?B?Znl2akk0Y2NjdVhIVlZOaVBPb1o4a1R5d0pEQ1ZzSlJ0MkRaNWx6MHAzeVpl?=
 =?utf-8?B?amp3OSt5ZHNsMHVqYWgwa0tJd2wvSzYzY21uczYrRWMrWlBlaGVid1Uxb3Mx?=
 =?utf-8?B?S1p5aklpbUJXMXZCaGNEL1dCMFBjeWNqRnZha2NPWGdYcHVjQ2hNQ3JFWHVy?=
 =?utf-8?B?eTlBV1FXa1I2WEs2WkMwaWllb1pJNGROTStNVUdRZm5iSUwvcFRvSDgyTUd6?=
 =?utf-8?B?TjVvQUQ1cUJlYS82bDRBTDNNRGlHS1VPSGhxR2JWQWhwWUZjQkk3OU9ZQTRX?=
 =?utf-8?B?Q3YwbTAxLzhwYThPTzNMb2QzWUpIOTFJandFNVI1MU5LRlE5Y1hCelZvN0RK?=
 =?utf-8?B?Y3JISzRYNC9UVnpBZ1IzL1JzZFREQlFLRUZ6NXNURmFKMlYrRWRpc2sxRklz?=
 =?utf-8?B?WDVzTllFdTdISXM4UUZiNFJuTGxNQ3Z5UU1jcHVvbUU4bEltZjVlTnd0ZlhI?=
 =?utf-8?B?R1FVMmNNZzgxanFxMW83N2lOZWt0WkRsMkFtVW14NjZNYlNkYW5WRkJiNHFM?=
 =?utf-8?B?Tm14eFdmNXZnY3FFdFAzTnhSR1JoSFRMbXA3Q1N0ZGpSd1p2ZmpSKzB1OXVv?=
 =?utf-8?B?aGNhM1Mrck5yNDhPYmV2eW5TWkxpd1R5Q0E0bFVENDhJTExETDEvTFpvZE1U?=
 =?utf-8?B?RUdiaUJJSVRwR2xieERCd2dYUitJR3A2TGt1Q0FoSS9RQi9iejRzclozMDdq?=
 =?utf-8?B?UkxXREEzUWVTQjNEdjI2ejVwNnVRSGJVWE1aTUVLd242ZkxEZmRBUU9pNnVP?=
 =?utf-8?B?ZmR5WDkvWU45RkNMOXg2S2tDMmtFcGUrNTZJL2RLREdxQ1BtMHl5WkcrdnpN?=
 =?utf-8?B?bzdiK1hyYjBxbnpQN1M0Tlh0bTB6S3NteGZpbFFJbXRsUnhKMWxueWhrYzJ1?=
 =?utf-8?B?OERTTnNSYU9aQnp5U3IxdGRhQ0pnNG1ua2dDOG02eTNQQWs5c1UzbThLNmJC?=
 =?utf-8?B?VVkrampTQ2REYVYwQ2t6WHltdFdYcUFnOUg0ODBkYU9yZ0pTZk12dFpoUG8z?=
 =?utf-8?B?WGRkZ0g5Kzl0YmhZMGc5dVJRVS94Yi9Lb3lPNlphczkyWXV1RXNadStnTmZC?=
 =?utf-8?Q?UO5pSBKJar0rpEe4=3D?=
X-Exchange-RoutingPolicyChecked: rG7tcERck2fOIHSysyOz2e8fCtTP0xc/6eVeafuIYaQe/YKE4gQvlY5ZV6EIOnkz7LUIEIQwSDTtX2oosRPJUA7h8hnz7la+q+zwfKVhmQtJa37lPyYGkQLIZC1QyqkTYGJ2ySd3B7H08OTp8wiEPYRMHaDJCXphDVSZuVfBHCVODEwLMI0MCrCGejS6XPsgfoPubZkNEAbKVZ/Dj/4GyIKtiSzkOLdLJeUu3xaTKnBKT54WJ1k8aLQDxdhZstSkYH0tT7xHvsX+7HAc72HXwyLi54b3E1UGTyjA8C7xG7enFp/wT4mKnQ4djx63z690VJAET+v/ShvcDEGqPwSNPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf47b7e-eca8-4734-4484-08debfe0c616
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:22:05.2621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IA4Fz/1lL2GVixbZ6QN0waFzvtxEXfhmas6pocT4QJvKAqDXcwn9QFwztsqVWrlUuoCSpHryfKsaOclSeWldEgHCXzJW2vgUklE4AhKj8MU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7833
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293769-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: EC83F61FFE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Lai <justinlai0215@realtek.com>
Date: Mon, 1 Jun 2026 14:23:41 +0800

> The hardware parser incorrectly interprets 319/320 in a short
> IP fragmented UDP packet payload as standard PTP destination
> ports and treats the fragment as a PTP packet for further
> parsing.
> 
> If the transport data is smaller than RTASE_MIN_PAD_LEN, the
> remaining data is insufficient for further parsing and causes
> hardware TX hang.
> 
> Pad these packets so the transport data reaches
> RTASE_MIN_PAD_LEN before transmitting to avoid triggering the
> hardware issue.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Same 3 things to do that I mentioned in the adjacent thread.

Thanks,
Olek

