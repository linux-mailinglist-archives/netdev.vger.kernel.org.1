Return-Path: <netdev+bounces-282946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KobJO6G82l04wEAu9opvQ
	(envelope-from <netdev+bounces-282946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:44:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9B24A5EB6
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C4A8301B77C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9059747798C;
	Thu, 30 Apr 2026 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUfTjzh7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932B44BC8E;
	Thu, 30 Apr 2026 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567135; cv=fail; b=KLTaPRmXPZmG6sZcLeXIZgYp3neqOWpfYuT59jyyeirq3VqB+O1Z26OQSVgAbFUKuG7aOE/dHxKVXjuUZgV5txFVHJ8fkSo8bonzQAkW1+bEgmN9xcud3kCZiZUC05wyykLjq/SZhiY/BME4l+KdlErevM20f3GEaSBdWBXH1Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567135; c=relaxed/simple;
	bh=Nty5e9fibnG4aqfDqdzwtDvEVZ44AoXTQJLwJ0Q5oV0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JmfiMBREdqftvAwt8ZUnBsZIpjdWdpzIrg9aJ5J1oZF6j1B50Qxmed3KYmgi3vvIQfPKshBo9D17KAHjoPNIW6uiOlCGfC+R+jiscNpXs2y1LuM6XGZDm6AGtFsB5WoGV9fyZ0J5v9kQoTkgLJiRE9T097n11OUAZsxEBHfeKZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUfTjzh7; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777567134; x=1809103134;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nty5e9fibnG4aqfDqdzwtDvEVZ44AoXTQJLwJ0Q5oV0=;
  b=MUfTjzh7HJSrww3N+RrZ/9v5XQYLjSD+FxnxcHS6e9rzWB1kvUWEQIBI
   Pq8k9Dhvx9o3wDTO1F0jncOHi2UbYlpkOEVw6L7Tukpff028GdKTyXho2
   UupGESKJnqQtZqhuQg3/Ay4tU0sjNxXy81J6EYeLASFfes+FNVWMs5edP
   JfAF0Z8fHnR/OA+47GBDwkvAXz1h9Hu6ONZSfjtvE/7tt2PiNmYRp1qwq
   PBrYPAA0axJev68MeZ2ZpomgfQGEH0sA87t4kPfNV7DMD4PKJJBUJkAsf
   jaQypxqKOe1NfLy3Pqk+Zqgww/ktx9rgmWXhENpGyhfWzQ2e5VaX7chK6
   g==;
X-CSE-ConnectionGUID: 2dalJWVBRaWF65gVqMx5Iw==
X-CSE-MsgGUID: BbrXh+e1Sv+VUUUyBI1cPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78237265"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78237265"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 09:38:54 -0700
X-CSE-ConnectionGUID: Nbe8uZjgSiCYQK/RTUnRqQ==
X-CSE-MsgGUID: ha1qKy2ZSOC0m291jMesmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="230279922"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 09:38:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 09:38:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 09:38:52 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 09:38:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHS5nJCNe9ak+uXbZJoRsCc3AXMj6oFkFc7Mnva6k1Z841Ha826j/avtIoz5U3oAmVLVxvs8YztJwDrEURQaLYAfYIbtyI1CgKTLWb3CoDLwmkr15e/vp//jwSHULlZeSF3nq7T0/eCEtfiQy9VxMgmHJbQdQImdkzcrmlYbeONYG78dvkfPpQGaZKAfCzK4kpvl/A+V4p34s7st/kHvQ+xJ6V1ehCk/0qyXw3L/R9J0M1TFYIs8TE1twLedNR1ifv9moEPyYin74pscc2sHl1agl+NV2AoW1r7RmIq2WLdTjWmnFmZYRxtYBR17cFtTm0AUt0IIAWXAfD/M8boMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8GHjb1ptpDV4xgqteHfTSBvpCD3p34ZaVV7CNQTalw=;
 b=QnILhA1OESwZnjrGU94ScpKlRSprDQiEcJhElvGVtuaxvg56WJ36q4kihttrtKTCU18l4w9OoP7JN7YwZ7dxlLlfk09KtyUD5W2dz9yqTXiJk/hLfzQ5IcN3Rb/M5DVU0P+MXUOX+bsglBRsZaKFDB2fhMu6rCOYmbjdfmjwWlx5If6iEPaxq2eMUyvQG73plZcjHu6xjX+hoTP0aQJQcJ8Vliz141J0PWUzkbfih/p+i5t4bnrQTrzb0QQ6p5TJaVoxXZLM1WVhhBKkErSOboOcjS8z85Melu3WSep1QNNIM+tK/LWPBI/WXSO4HZk9SpxoOKpe36vRQ93gHPiiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Thu, 30 Apr 2026 16:38:47 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 16:38:47 +0000
Message-ID: <dfa0c54b-393a-4671-8531-13cb454b872e@intel.com>
Date: Thu, 30 Apr 2026 09:38:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] idpf: fix RSS LUT memcpy size
To: Larysa Zaremba <larysa.zaremba@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Joshua Hay <joshua.a.hay@intel.com>, Willem de Bruijn
	<willemb@google.com>, Alice Michael <alice.michael@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
References: <20260429074232.180528-1-larysa.zaremba@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260429074232.180528-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:303:16d::10) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|CO1PR11MB4929:EE_
X-MS-Office365-Filtering-Correlation-Id: a37a2f27-aca6-41b6-08de-08dea6d6f39e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ew9XUAeLCcGjheRfgSDFbLugEg+VQ5GJJO5CmbKlxwzsh5LtQPQl5BkRV2cRs4mBlqmdQAJUp/YTIFZ2i6HVhFav40lgEzcUGgOBxzdoHndnqYMX71SwksdiV30BG0KpUgONvm92yYxOQ5Uk3/ISnLEuXtQQbJ6ju7RLu/pb3JOXjMdMP9qaDiTh1QfoX7+fcUl4Av/jVbOwOCPWG8muLpEwSvBmIXZUStSJvF2+0LJvolwkiJRKygsCbn8ydrm1eAzI/TE5qOyNBto3v1f9mL+mKhIREM6ieTr/Syd1zYoRkqKGKmbqR+qTpDCOZ5vchvrgNF7/vGCTuYqJSf7eS+swArfcfycsq/7hLRooi8ItsTU7HbLnvzmOE6Fy99VLAEuU5JorHtCLwk0D1/OvsR0BgLTpnnU9SB7/nzoz8NQQqcb1q4YCWg1C7VwuDQDIOq/yBsFQ2TLck8X5R6TN2DrPAC1ia8QpAyw9b3/Mg90BRH0gBIt9ES68YiWqWDH9aSikxu/kNI/pDWemuJ3vgmpJ0dSI4S8XWme1XggUaJLG//3YnH18xLOE9iPGTAruaPF4c81RPCjEEaGYeRcLccNEoQL31maax9LDjWr6NrkzjZ5Dchx6VqPGKgaoB75iOrzPC6rcru09ToI6bCTmoRBSZyL+mXHE6m6B5E9GrSzclH+sIgQEPRtN+EFzXuaE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFE0bCtDb0EzSXJ5NVZ1WU9vMVUvL0xJTi8zdGZhR0xaVGc3MGRTZTlic0ZU?=
 =?utf-8?B?aE1tdXc0Wnh1Z0NZV3RQSjFhUnZ0QXpRQUl3L3dkS1RpQW9RdTd2TDhGZzlx?=
 =?utf-8?B?UzBUbkhuVXRtOFhIMVhmZHdqUWhtRlBvRXpuc1RhMW8rV1J6OGJudXpyQ0lB?=
 =?utf-8?B?U0pJSVowaFhWdjZ5d3ZQS3hyQ0dlcHF6dmhISDdkMUl4NllqR2RLL1Qwb3NE?=
 =?utf-8?B?WVBtTFo4MlNwVEpDVFk0bEdNbWR6NkhnMTQyVTBFenpCQWNqV1ExRWtudU0v?=
 =?utf-8?B?c1JVWnJacW93MXpZSFhNL1FOdlpnWG1tYzI4U2ZaVGZGRjFRcHVEMlBIdFNt?=
 =?utf-8?B?d2RRV1BXbTNWOTlhMWlMQ2pDdndKZFE4MTh3WndmOHNvTFU5VVlmUGU2YTZT?=
 =?utf-8?B?OXk5MldYZ1ptNTVYSmU1VlBPRUo5N3FudnpEQkhXNzFYY3l0elJnZnZoWVVW?=
 =?utf-8?B?by8xcllHQVJuS3d1aDBUSlhSTGdRK0ZaV2NQZ0dpRVNDL0h1OHc2MVVzVVhX?=
 =?utf-8?B?RGxDbFMrTVF4NXYyTmkzclkyQ1BYVzQ5MUprS1V4T3BQdlU5OWM3dFRpY2Rv?=
 =?utf-8?B?MTlLL0NpRmhZZUZQbzBGNHYzK0tlMTdkOXp0NHpSRGdCUDJoRmhHanAwcTNw?=
 =?utf-8?B?bWxZbkFUcjlsUnQvQjFybFk5amdiZGpkbnAwTjBid3FxOWxNQXQ0NnpJaS9t?=
 =?utf-8?B?a3VrZ2VXei94MDhKYlNwYjhicjdnWEZtNk01eUg2OHdxNWwzbVZiQ1RnV0RG?=
 =?utf-8?B?VWt4NXdBbThUMW9UQnl0ZUxPeXNvRzhpeGFjcFVRNFlWUGZQYzR3RXNUc2Nr?=
 =?utf-8?B?WUdzU082SGJLZFhpcTh4QS9udkxyeGtRaWt0NGU4NnMyQ0ZJTEg3V2tZR21o?=
 =?utf-8?B?dVVPUE05bnNENzJxMU96enp3d3RDdTJIdHhuM01vNlFGMGV5L2h6Ris0aUpY?=
 =?utf-8?B?OVkya1Y3dTd6TjUrSkNLSmhNN3VGekhiY1lhZCs4cFIxdmxYVDdaeXUzYThZ?=
 =?utf-8?B?Nm9OY2l2TkJMTXlMa1MxVzgyNXkydlpORUJoWm91Y3pzYitiV00wVE9qNHpS?=
 =?utf-8?B?T3cwY0dWMlhtRmw1NGN6bGlML1lDOVNzd1ZwNzBZdDExWWdwM3NuQU5GSjhF?=
 =?utf-8?B?aTR2eGx6TW5iM0x3YWpDVzBhRGdVblpSRWtmeWxSVTZza3dvaTRqMWpVMjJN?=
 =?utf-8?B?MTBKTUZkUC92Vm9zSHlGTDhNbzlCTUJEeFd6NHVsVU1tV2NhcW1Kb2FNdmlD?=
 =?utf-8?B?V1o3dmRsdkpEeHErekhBcTc2VTRrWFlEckxmTmNhQVBkekt6bGprcnJadXYx?=
 =?utf-8?B?VHp1RmJBWTEvUFJpSkY5aHdQdEkwVGl0QmxCYm5LaGNjbG5VYXRYUFZVb2ZC?=
 =?utf-8?B?WGFMK2wzcHpoaEsvbWo0TER1SWxsOUtiSVV0L0NVSWlXMXJORHZqR29CREds?=
 =?utf-8?B?L20zbHg5NGdZbjdRN0o2cENWQWtJQk5La1VmaEJnSWpBSHRMREhlWjU4RVlr?=
 =?utf-8?B?Mmc4UUhHTGhUL0RpV3hvaU1tY24zenNRY1FobThKdWxEb3hialhITk5UWjNt?=
 =?utf-8?B?UWc0YS9OTksvTmZqQys3OE56Q0F1YzBJd3R6MVJPN1FoTDhCZ1hwdEF4dVN3?=
 =?utf-8?B?aGF5NjU1UzNiTndFRDVqTTVZWUlKNGNwTGJmVjNBSktaREZ5RS9vOTRxZGNz?=
 =?utf-8?B?S25CRmNvZ05wcytSeWZhdjNCNmVaV1ArN2R1UXFyQWlKdExXTDJKQUM0WU5p?=
 =?utf-8?B?SE14SnVxeis5ZER5L2pLSE14Ly9lWUJ2ekVtZmJaK1Vya1BCdHRlWWlvUFc1?=
 =?utf-8?B?bVJkRXpNRFJ4cjJxOWhhWWZCVGltWGYrZFl5alhkcld0NTU1ZEJLZDM1amVY?=
 =?utf-8?B?THdHTnljYWowS3diQ2pqK1JldFRzWGJDOXVZQjYwR2s0THlBNC9GRTBLaEIr?=
 =?utf-8?B?NEY3ZmlPc3lTWHVzV1lOT0tqeHlqYm9QYUJzcUtYSUc3UlE0bXV4NFhiUkF6?=
 =?utf-8?B?N3d2cmhNN2djN1RMaXJ0N3B5d1NoWEh5U1lkYzZmdTJwaDRMaEtPZkdOanJH?=
 =?utf-8?B?aVk3cENJYjI2WFhOZTVVRzBwMjc5RE5EbWhHd2U2TklmQitUNXZZRzVwK2gz?=
 =?utf-8?B?MUdqcE9ISFRQSVVUdUFqZ1pnTzRSaW8vL0o1MlBPcFhMODEzSkFJWng3VUx1?=
 =?utf-8?B?YW1PMkloa3ZQdnJId2ErWStZMFZOUUpiZVRFaGNWK0h3WmFzbjBnbld6eURo?=
 =?utf-8?B?NWc4cTBLb3J2bnZxd2N5M3VXaGRicnZ3YXNxUDJ2SE5zUkpXNW5qZnNDZlZu?=
 =?utf-8?B?QjhRVGZHSGFrVTQ5SXEyNWxKU0VBeXRUdnN5ZmFxMmdta09XWGtyZEdFaDRi?=
 =?utf-8?Q?sjvESV/KLFZ91AX0=3D?=
X-Exchange-RoutingPolicyChecked: pCnlUE3KKKMn3iBPazcPFy5Xt03OZ9kAuB09I7DzdRyepXul/bIuWvPUygielnJuwzHUUcceBdO//s+IMGyTQQ1sNR7OtKLvXPcP0220JUww890HDknAymBRw8Gx0oraePuLMnrkKeyhFwwUTm/N/Xghzga4khXCx/2kFCRENAX2XD5uxMxcBO78G7oPGarxhQrRC98odK6hpwZqUqon2J7+3JjDSZt7OKvd5vV/6oC6caGF3uTcvr+8JtSz56M/ctk8KurqBjTPH5L866NV2wx5SPiOmwdrQLv1Qm4f7YxMnNI1JmuEnaR1H9FTTQgMK6EpzmU59F8HvdDZOBSCxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a37a2f27-aca6-41b6-08de-08dea6d6f39e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:38:47.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UK78BW8Kqr/hg4Qzm5AoIl7dNfTLAjX8af2OnEwZxFBEyP82thKzdovY2j5Weyeihps1Encoo3WOv+/XGu6knB1zYH3IhRR6HjGTAf8T9Vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4929
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 7F9B24A5EB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-282946-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On 4/29/2026 12:42 AM, Larysa Zaremba wrote:
> Based on the following feedback from Sashiko (received for iXD phase 1
> patchset, but valid for the net tree):
> 
>  "Is the bounds check xn_params.recv_mem.iov_len < lut_buf_size sufficient?
>   Since lut_buf_size only represents the size of the array elements, should
>   this check instead verify that the payload is at least
>   sizeof(struct virtchnl2_rss_lut) + lut_buf_size?
> 
>   [...]
> 
>   Does memcpy copy the correct amount of data here? rss_lut_size stores the
>   number of 32-bit entries, not the size in bytes. Should it use
>   lut_buf_size or rss_data->rss_lut_size * sizeof(u32) instead?"
> 
> After inspecting the code, it was concluded that RSS memcpy size is in fact
> 4 times smaller than it has to be, since a single array entry in a u32, and
> rss_data->rss_lut_size is clearly used as an array size. Required Rx buffer
> size is also too small, but this is a common issue in the idpf code.
> 
> Use a full buffer size (lut_buf_size) instead of the array length
> (rss_data->rss_lut_size) when doing memcpy of RSS lookup table.
> While at it, increase required Rx buffer size to a whole flex-array
> containing structure instead of just the array.
> 
> Link: https://sashiko.dev/#/patchset/20260323174052.5355-1-larysa.zaremba%40intel.com?part=8
> Fixes: 95af467d9a4e ("idpf: configure resources for RX queues")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index be66f9b2e101..a97d2e9b54d4 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -2916,7 +2916,7 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
>  		return -EIO;
>  
>  	lut_buf_size = le16_to_cpu(recv_rl->lut_entries) * sizeof(u32);
> -	if (reply_sz < lut_buf_size)
> +	if (reply_sz < lut_buf_size + sizeof(struct virtchnl2_rss_lut))

This feels like it should be using struct_size or flex_array_size...

>  		return -EIO;
>  
>  	/* size didn't change, we can reuse existing lut buf */
> @@ -2933,7 +2933,7 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
>  	}
>  
>  do_memcpy:
> -	memcpy(rss_data->rss_lut, recv_rl->lut, rss_data->rss_lut_size);
> +	memcpy(rss_data->rss_lut, recv_rl->lut, lut_buf_size);
>  
>  	return 0;
>  }


